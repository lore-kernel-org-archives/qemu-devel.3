Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C34C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 14:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmwGX-00079K-A8; Tue, 25 Feb 2025 09:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmwGU-00078X-Aj
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:50:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmwGS-0001sK-Kd
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740495027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7zwOz03HrnyOh169HrOBEY0Ry0JjLl4gs6TpmAYzSw0=;
 b=cwUEGaQJktRArDGoi1QAAGo+RCEXFCUzSVwvi6Uwwa58gTJm7payErMi/bwZrWF+GWe090
 gu2nqGhYi9TI167Zr0dhPXiLY/xQe+nJasZCftDaEn12xCdAkSdEY1/nu/22TFg9NI9jPj
 RBynhFGBo72Z3EY4wYvxHAp0j3L1TzE=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-H7nWVY4AMGCTkJZnTIkhkA-1; Tue, 25 Feb 2025 09:50:25 -0500
X-MC-Unique: H7nWVY4AMGCTkJZnTIkhkA-1
X-Mimecast-MFC-AGG-ID: H7nWVY4AMGCTkJZnTIkhkA_1740495025
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3f40cd0175fso5080601b6e.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 06:50:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740495025; x=1741099825;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7zwOz03HrnyOh169HrOBEY0Ry0JjLl4gs6TpmAYzSw0=;
 b=fnLoHq6j0ztA6rRsx1LI86S73voMAui9ltmnGtUCWPBIa5wE6Kbcle2as0nlzPpJkD
 6oZ4Kn9eUgd1yXJZlsg+AJqpN7r8n0nQpKnWZxMGLgP74VrFTv88Qypa6eP+GUEaybb5
 Z6CZtoh0Ngw1I0WYLkQFhVsJ+Re/k8nJ+2pjvwDwHEDqtrG1eDhr3/zBGasHPIFWq6u9
 49nwQGB8DAgvvWGAo4D0oSqba7zMWLY4ziF9YYG9+CC6vVG3I30XhiCvr6BHS6zum8H0
 nY/r2rhtTX9KGqA26egAxALnS61O62el+k4+sy1leVUHWuHd/bPE8joqFkIQ1oZfOx0q
 rwKw==
X-Gm-Message-State: AOJu0YzlVGy2u6BJJewcvPBBxbnTYUih/v9LE04XhZHPKiYaFb6kT8w+
 xYJHDpqwlWTXT3hFJvlqdon4A0mB/fm2vXr3FJjFicMA2PR23HWQn33fIWpOEJY6x6i/UJan/1N
 sCepuX4N7kUm3uDJBGfCi9SKQSZ0gXnid31h6wI2iMq035oA3g6l6
X-Gm-Gg: ASbGncsikeJry3aOEnCEzSXgVf3oclnHd4bcpaq3k0CzrAg4rFK+FxQI+hKW+qeRVkt
 HU93RAW3KPnxw87JrA4kl0SGWn/gpO6QhNiDmzPzbZYu8OXHDM7WvT60nKxx6Sh06ffp6cUmljE
 8BkMz/cit4RXt+Lvz2NyR9wew52wHADLl/SGQcB/Pofi/N55youualYXihv2Bw3jZHphmDg8Bqc
 iclg2cfGyFbs3K+me8Fzmi3NopzqRob7HtMI4R/J3OjIvwetHvOVgAyiSZJm+6D6CNpwA==
X-Received: by 2002:a05:6808:4445:b0:3f3:d6d1:c051 with SMTP id
 5614622812f47-3f4247c30c7mr14919828b6e.37.1740495024970; 
 Tue, 25 Feb 2025 06:50:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQsIeJ3FOuTBry5Np0N6wFWi0wlVbXfdS7ygtukLYsjcSXuLIsiXq3liIpI+RHAni0XjWUug==
X-Received: by 2002:a05:6808:4445:b0:3f3:d6d1:c051 with SMTP id
 5614622812f47-3f4247c30c7mr14919819b6e.37.1740495024717; 
 Tue, 25 Feb 2025 06:50:24 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fe941209d9sm317209eaf.10.2025.02.25.06.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 06:50:24 -0800 (PST)
Date: Tue, 25 Feb 2025 09:50:20 -0500
From: Peter Xu <peterx@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 7/8] migration/rdma: Remove redundant
 migration_in_postcopy checks
Message-ID: <Z73YrKRNV5Dy7mjj@x1.local>
References: <20250221063612.695909-1-lizhijian@fujitsu.com>
 <20250221063612.695909-8-lizhijian@fujitsu.com>
 <Z7zP-HRmX-Oe89Yf@x1.local>
 <1e44eb40-9131-42ef-8544-ffda89ddd9e7@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e44eb40-9131-42ef-8544-ffda89ddd9e7@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 25, 2025 at 06:21:20AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 25/02/2025 04:00, Peter Xu wrote:
> > On Fri, Feb 21, 2025 at 02:36:11PM +0800, Li Zhijian wrote:
> >> Since we have disabled RDMA + postcopy, it's safe to remove
> >> the migration_in_postcopy()  that follows the migration_rdma().
> >>
> >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> >> ---
> >>   migration/ram.c  | 2 +-
> >>   migration/rdma.c | 5 +++--
> >>   2 files changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index e07651aee8d..c363034c882 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -1939,7 +1939,7 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
> >>       int res;
> >>   
> >>       /* Hand over to RDMA first */
> >> -    if (migrate_rdma() && !migration_in_postcopy()) {
> > 
> > This line was just added in previous patch.
> > 
> > Would it be better move 5/6 above, then somehow squash 2/3/4/7 so that it
> > doesn't need to add something and got removed again? 
> 
> Yeah, it sound good to me.
> I tried to reorder the pathes and squash previous 2 3 4 to a single one
> 
> So the new layout will be like below:
> 
> e5b1998ad30 migration: Add qtest for migration over RDMA
> 9a1b87e2db6 migration: Unfold control_save_page()  << this one squashed previous 2/3/4
> b6ccd49e934 migration/rdma: Remove redundant migration_in_postcopy checks
> c7c4209db6f migration: disable RDMA + postcopy-ram
> 0463b54d7f9 migration: Add migration_capabilities_and_transport_compatible() helper
> 21c76dcabee migration: Prioritize RDMA in ram_save_target_page()

I'll have another look when repost, but so far looks good, thanks.

-- 
Peter Xu


