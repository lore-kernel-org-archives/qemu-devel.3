Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5F6C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 04:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXZgg-0000BI-Cb; Tue, 06 Feb 2024 23:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXZgd-0000Aj-RH
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 23:37:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXZgc-0004ZD-7J
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 23:37:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707280644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h69bQuRLpyF3N0cm/TlYmgIHLErCNp3rh0tSzgBpecg=;
 b=OVlia35gaMOdgic5QtY4ZWBaFRK7iLGub97GEpx2HrmfZduy7t8wcQ65lPMazs7wZ2HUU1
 /bgiH5YeNIqgOtFxzTYxCV8E7zHkQle3sT2Zrb6laNwIf2v57O9/a2WaSV0XxF7Rkf1jeB
 /G/vJ00t1NS592rc/V1eKkCSVwLeGQI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-k5fDMtvKOMK7R5n0yB9J5g-1; Tue, 06 Feb 2024 23:37:23 -0500
X-MC-Unique: k5fDMtvKOMK7R5n0yB9J5g-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cf53f904f9so69331a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 20:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707280641; x=1707885441;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h69bQuRLpyF3N0cm/TlYmgIHLErCNp3rh0tSzgBpecg=;
 b=GJlojOX9H1TA1LheP99QYEw2LOK4/j1v3K3JvzX5v5BGlRWeICXCXmk7lQDS4S9Xpv
 stKIqG/sIrBQlQy70mXnPkrkU+hTIpYiY+AARrm5/Afpgvgjdzftj8xvXj0+c7b/9BwB
 I609zF6hcq8l7eVcLfb/0HgdU5ARSZekLnng34gBJDPlgRTF5GMdYEsBxySoLnYat1Jz
 fn66OX+TCxuKgwTAQxbtHAeodqed0Nn88KiYbOW1TTSuwMxVSy7yVl6h0ddEoDPyu+Y/
 o8Jcugu+MrW8Gj8rLwYnpFQ4VLIddXbsG1SrwCDlGdH3Y+kSW/L8zoZKdT85la3GlxbA
 FuJA==
X-Gm-Message-State: AOJu0Yx4NhrcWnU9z7tPAwCyERS880mHPsJ54ryIk623FjK/Q1X6gONq
 Pv1K032XJ3z8t7vzcyCTTZ0Fwr4guJFShdhFH3vDJEclWho+u7F58e2kvil7GZ/vPug1mrA5aQj
 5dacrEUs9QIn9jWsIVzuicw5G6YCF8QE8PtEAfYJuZn4nZOB7wtzxNRDw+70iHic=
X-Received: by 2002:a05:6a00:1ca3:b0:6e0:500e:e063 with SMTP id
 y35-20020a056a001ca300b006e0500ee063mr4998721pfw.2.1707280641593; 
 Tue, 06 Feb 2024 20:37:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7QhT5m6SV03ST0haabuV9rMGAaVcx+fWM9UVVKPmUp3/dLciIxVg+p2GQFGdLicwcejudBQ==
X-Received: by 2002:a05:6a00:1ca3:b0:6e0:500e:e063 with SMTP id
 y35-20020a056a001ca300b006e0500ee063mr4998711pfw.2.1707280641286; 
 Tue, 06 Feb 2024 20:37:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWruyCBs1rn4yCX6LbaeKgcoSJy7IQlkh1yQaADvRsd/J4oaGGB1thY7XS2Ca+ip59Mk2dMbC2dlXw624RCWYRV2YcbhCGFcsJdiW+N+SaNyaAWTnI=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 o8-20020a056a001b4800b006e03c68ae9asm398284pfv.16.2024.02.06.20.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 20:37:21 -0800 (PST)
Date: Wed, 7 Feb 2024 12:37:15 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH 2/6] migration/multifd: Add zero pages and zero bytes
 counter to migration status interface.
Message-ID: <ZcMI-wPq94x6cO2Z@x1n>
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
 <20240206231908.1792529-3-hao.xiang@bytedance.com>
 <ZcMDVpLilA-PZ3he@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZcMDVpLilA-PZ3he@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 07, 2024 at 12:13:10PM +0800, Peter Xu wrote:
> On Tue, Feb 06, 2024 at 11:19:04PM +0000, Hao Xiang wrote:
> > This change extends the MigrationStatus interface to track zero pages
> > and zero bytes counter.
> > 
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

I'll need to scratch this, sorry..

The issue is I forgot we have "duplicate" which is exactly "zero
page"s.. See:

    info->ram->duplicate = stat64_get(&mig_stats.zero_pages);

If you think the name too confusing and want a replacement, maybe it's fine
and maybe we can do that.  Then we can keep this zero page counter
introduced, reporting the same value as duplicates, then with a follow up
patch to deprecate "duplicate" parameter.  See an exmaple on how to
deprecate in 7b24d326348e1672.

One thing I'm not sure is whether Libvirt will be fine on losing
"duplicates" after 2+ QEMU major releases.  Copy Jiri for this.  My
understanding is that Libvirt should be keeping an eye on deprecation list
and react, but I'd like to double check..

Or we can keep using "duplicates", but I agree it just reads weird..

Thanks,

-- 
Peter Xu


