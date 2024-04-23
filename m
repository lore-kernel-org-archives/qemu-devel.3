Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E027C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGJC-0007LY-AJ; Tue, 23 Apr 2024 09:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzGIx-0007Kz-S7
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rzGIw-0005YQ-5s
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713879324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jJr0wZGtSwNcfVRHmt1q+50wURqdaNmubrnTYXEoRS0=;
 b=e7QxN8Q8jvi35riwGkN73ABQdpleeBhxCeFEZV+qdbK2LyCGeFataa5WKCDaSzFl5p3g7H
 BQ0+fdNSGh1EuGrChIHBEqa7b5pzYEMFtfhV2apZC/Lcb9w4gG9js5BFCd4hCbNGAVzaq+
 LLtMZjEDmPUQaEB1cZGwKo/Pgu5mogg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-1BvKtz71N8SoPfTgnpGkcg-1; Tue, 23 Apr 2024 09:35:22 -0400
X-MC-Unique: 1BvKtz71N8SoPfTgnpGkcg-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5aa68b37021so2108287eaf.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713879322; x=1714484122;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJr0wZGtSwNcfVRHmt1q+50wURqdaNmubrnTYXEoRS0=;
 b=GoeqtjYHZgkThykRrxcVVoFMfqgZZi93DfwPOVrsEcvwCkdEz9cg0TBKAWKwMEmvOW
 NrJOZVfcE3fLCIeIk0CaW5WfTLwaNz4CTqUxZrV/H7aauwshvoSEbxxKnbhD3QzZ6qKS
 h4cLOrVv0GPd74kTDKnSSsTV02HyShmb2yfQnd7m1CZrfZkc6rqFch3+VBzrsWaXkuMc
 8ChyYBd0Xsi7dlrXdf26obtoph9eCf4KXX44AFfVJgWnLPhhJ85sGPmBfQEiQoCxd0x8
 VM0/Ljm9iz2QU0er/xgeQVmN2V6yCaVXUGJExUcwVs1vymtLXPt5WjhX5MlfznN7rRK7
 nXGg==
X-Gm-Message-State: AOJu0YxPySM89gS8BedGXhWGoij62LEpxVQUQF/xKUgCy3Hw9G5gdayR
 S00EEtTgkxG/FxWJnYPne+pNu8MtmtZUEJh/x82OlK0YpkSt67CWWRk2gFkkKkt9783jKf+V9ws
 fiqCn6VUpLFKrTI/qHyGCEqLqycZDfgOJGHKEKiG3XmgVbk6dOhYj
X-Received: by 2002:a4a:5581:0:b0:5aa:3e4f:f01e with SMTP id
 e123-20020a4a5581000000b005aa3e4ff01emr15034314oob.1.1713879321573; 
 Tue, 23 Apr 2024 06:35:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCbXDeMEdiIhMOSLaOeSzQqJBzJNIrg6BGs24FP+yxZqnYT1E4zZyLwuLdgiNs/Gw7o2cJow==
X-Received: by 2002:a4a:5581:0:b0:5aa:3e4f:f01e with SMTP id
 e123-20020a4a5581000000b005aa3e4ff01emr15034285oob.1.1713879321063; 
 Tue, 23 Apr 2024 06:35:21 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 jx11-20020a05622a810b00b00439e87f900dsm735558qtb.83.2024.04.23.06.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:35:20 -0700 (PDT)
Date: Tue, 23 Apr 2024 09:35:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Masato Imai <mii@sfc.wide.ad.jp>
Cc: qemu-devel@nongnu.org, Hyman Huang <yong.huang@smartx.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 1/1] migration/dirtyrate: Fix segmentation fault
Message-ID: <Zie5Fr3m9BquVpp3@x1n>
References: <20240423091306.754432-1-mii@sfc.wide.ad.jp>
 <20240423091306.754432-2-mii@sfc.wide.ad.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240423091306.754432-2-mii@sfc.wide.ad.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 23, 2024 at 09:13:08AM +0000, Masato Imai wrote:
> When the KVM acceleration parameter is not set, executing calc_dirty_rate
> with the -r or -b option results in a segmentation fault due to accessing
> a null kvm_state pointer in the kvm_dirty_ring_enabled function.
> This commit adds a check for kvm_enabled to prevent segmentation faults.
> 
> Signed-off-by: Masato Imai <mii@sfc.wide.ad.jp>
> ---
>  migration/dirtyrate.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 1d2e85746f..2a7df52519 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -799,6 +799,13 @@ void qmp_calc_dirty_rate(int64_t calc_time,
>       * dirty ring mode only works when kvm dirty ring is enabled.
>       * on the contrary, dirty bitmap mode is not.
>       */
> +    if (!kvm_enabled() &&
> +        (mode == DIRTY_RATE_MEASURE_MODE_DIRTY_RING ||
> +         mode == DIRTY_RATE_MEASURE_MODE_DIRTY_BITMAP)) {
> +        error_setg(errp, "mode %s requires kvm to be enabled.",
> +                         DirtyRateMeasureMode_str(mode));
> +        return;
> +    }

Logically dirty bitmap should work with tcg.  So the other option is to let
kvm_dirty_ring_enabled() check kvm_state too and return false if
kvm_state==NULL?

>      if (((mode == DIRTY_RATE_MEASURE_MODE_DIRTY_RING) &&
>          !kvm_dirty_ring_enabled()) ||
>          ((mode == DIRTY_RATE_MEASURE_MODE_DIRTY_BITMAP) &&
> -- 
> 2.34.1
> 

-- 
Peter Xu


