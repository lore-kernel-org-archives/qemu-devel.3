Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648D1C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 16:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKgQB-0007DK-Ta; Thu, 29 May 2025 12:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uKgPx-0007Bh-V4
 for qemu-devel@nongnu.org; Thu, 29 May 2025 12:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uKgPs-0007JK-4q
 for qemu-devel@nongnu.org; Thu, 29 May 2025 12:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748537256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+SRFdzgt9fpgN9gh2lrH4ajQ0IPg8DOKUGvEkuNXWHw=;
 b=Ps5l7sUHCmnypyIJ/r6DgS9lkXLTmIpF/ckeXGpd5sd3rv0lDhhceSKyfaH7i8jBInA/v7
 8DlTtzxpKRUcwURV1ItACb02FRfL8O9vovyju11LG7Qs0tV1d1TXgzt8lLYXQa7WpD5VkJ
 3qwaAqy2ywN1QgtPQ2vUQ/VMvT9LAL8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-k1mFtjpxPy6Rj3nvDR3_Rw-1; Thu, 29 May 2025 12:47:33 -0400
X-MC-Unique: k1mFtjpxPy6Rj3nvDR3_Rw-1
X-Mimecast-MFC-AGG-ID: k1mFtjpxPy6Rj3nvDR3_Rw_1748537252
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43efa869b19so9792725e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 09:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748537252; x=1749142052;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SRFdzgt9fpgN9gh2lrH4ajQ0IPg8DOKUGvEkuNXWHw=;
 b=MdG9V1lbIkEQ43n9op74LLvD7JFyTYyUoQoPyUh95L+ouE7PvMU5/mvsaKxusgJDuT
 X+oOfGudz70coVP0QktByhWQc6dkoqt7c01CzQTXD//cbOCDWWB2uS3l1MfQulWdjncI
 0OUF+gi4625bVAsC+wbxTiE3OsJK/Qx3Brm9Ul+wl2hnRB5CStuWSY7zahK45fCKOxys
 UsTCS4XmITqyUEz63eeornlUhd00nk3SWlRUap3/bvRVpbvHNJdYwNkV9oTbWZUu4Jf8
 UtBxFu40+4D5NbvUUhNzMo7f4EYc/f6oEnDBIckdrW5HpQkI2/n+EORwbMh99p2x37e3
 PVhw==
X-Gm-Message-State: AOJu0YykuPiiKVeCxbPJ2jzglW2KNAIPBIqi34HV1qTReukVAsUjklUy
 tkPXHfxAqfdPorZImz6trbvLbOPgPDjMpENNXNBWuD8SjPB35vGaqIUoeyzN4iekJzYe7X1+HLZ
 3JpM31KlMTGqsasfp0bmixawsIlGnIQwko/8K0Fg5KlSLRQgq6r6p5kTS
X-Gm-Gg: ASbGncv2eYEReyiixhnWx9guAO0J+5ZvLHXbmV+HOaltuZZCgBj/FKh/VSedX6E5XZ/
 Pt6Uwts66qnUAtb7UY87g8Q9Corhu3W0Lc37YbK6j6gORgmjY9DsahvzT/4CrbZVAvG4andt7DF
 nVMUGCNLFX/0L2CHjP+Dl+TH7IzwDPQFpJEciVX9PIiyWdO5wWkvygJMgV3gzLsXQ0XY1ZfjAWe
 sV/klc4HSIyRa0Wu2Thke4Ik3G6FywOh/xYccVOeAE8WlLfBpu1b0QegXOR08FgdbAR6Sb+tlgc
X-Received: by 2002:a05:600c:5248:b0:442:dcdc:41c8 with SMTP id
 5b1f17b1804b1-450d655ebe3mr3693555e9.19.1748537251950; 
 Thu, 29 May 2025 09:47:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsiRFEVheE3ocpS42e97xuPGdBKFSb6H05cMhHsEEmbWu8cPuq8rUaSPLlTOE1+S+9ViYsUg==
X-Received: by 2002:a05:600c:5248:b0:442:dcdc:41c8 with SMTP id
 5b1f17b1804b1-450d655ebe3mr3693385e9.19.1748537251614; 
 Thu, 29 May 2025 09:47:31 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00a0a96sm2498814f8f.96.2025.05.29.09.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 09:47:31 -0700 (PDT)
Date: Thu, 29 May 2025 18:47:29 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 08/11] migration/ram: One less indent for
 ram_find_and_save_block()
Message-ID: <dunru5gdrvfwmx52pp5ecfeorpxf6ig75cpr4cfvib3atv5dte@txxdksixjfhg>
References: <20250527215850.1271072-1-peterx@redhat.com>
 <20250527215850.1271072-9-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527215850.1271072-9-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

On 2025-05-27 17:58, Peter Xu wrote:
> The check over PAGE_DIRTY_FOUND isn't necessary. We could indent one less
> and assert that instead.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/ram.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


