Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA211098787
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3aae-0008F5-4g; Fri, 20 Mar 2026 10:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3aac-0008BV-6M
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3aaZ-0006BQ-Qv
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 10:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774015951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfjRFr0OoaN3FQHv/rWOnr1mumKP6f+HaRE84uZTPWM=;
 b=YvUAiU+k/lKx9hajrwBYl9OBYbldo98VeiU99+8MlvAbUYHGDcp/OG+g55QGfSJ6Nvnydh
 gkmI+Qi+p8GcqjVvDbCm1qFqjkSK/PWTv+FXsyNX2Nb7ZMWjtOQucY3rXrOE4xwWV41mQo
 fVKHg3KIQORlACtSF4i622H/UUXx+XA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-z94ZrfIqOyy-wKt1kdQjzQ-1; Fri, 20 Mar 2026 10:12:29 -0400
X-MC-Unique: z94ZrfIqOyy-wKt1kdQjzQ-1
X-Mimecast-MFC-AGG-ID: z94ZrfIqOyy-wKt1kdQjzQ_1774015948
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4076dc16so42354931cf.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 07:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774015948; x=1774620748; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jfjRFr0OoaN3FQHv/rWOnr1mumKP6f+HaRE84uZTPWM=;
 b=r4JEGlqeBgaoOG3X5dw0rEbFMGpC1chBTAxdiBUvK4ZVOTF96pg8h+YqBaUBmVbpdD
 6st/O0hJzmiNAZPWVssRUR8Cr+81UUA/hrnMtI3yAVpzwcEsBMrswxC0RS30DkVmgd+8
 KX3eQD1ZXuSycugANYY3pqnqU1v1iGIO5RJP/uiE3JkIXHfBl7wmAGgfIqU7o3IoE08K
 yVwDFC5tyuvnH7F48HStNNIkOIkQDj4EQrI6zoW2quyJU8t8DCBpq2FlbAKAMqW6/Bep
 a/o+Rfk1Aj5b94YXzN9gVaa9LPvcZ9KUODO7xIwyVYflwtVeFx/6DA1xfkFBNWSQXSFB
 P9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774015948; x=1774620748;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jfjRFr0OoaN3FQHv/rWOnr1mumKP6f+HaRE84uZTPWM=;
 b=iO1SRi0UuiMI2FDFLGPxBE4YRZz69yNUjU6EM9w6VfAwFUsusJpPyXhSSNByVWDVFH
 ZtywmXBrMmzk7/A49ShMWriamL5LOxuznj0RoeJdJJuLjkJQ0h0gtYTdlwUezVWDmnQe
 bsUW7V84hIxYNxfXKIT9C3uIc8I49IPV9UnMHkw1B/md3ccXls+ytbEN1i6+WRCiWaRx
 f+yyglNCkT/SgTdErnJ5TFjnDcjLsM10mKVbNeQ3E2lOb5uIkRfZzB94DATW5ii9p+xz
 CUGIN1xhiQUUqd5Ig39Je9Qg6kH8/j3dDHkaIQ6SnyPI3hfsHPY5dwvi/xIU2BIjgJME
 YH/Q==
X-Gm-Message-State: AOJu0Yya+eCDRmJh0FvsrI5zbgrjNu8dDMdEnDOS1IFW8iL959JMYNgr
 KRZl3KUlkvxz12PJjOVevfMgL3xe/lDbdOY9CJy939LxSGBxi7cf+zRtjol0c1vnlnGNVxUZe+T
 pMflpdTevRXtMf1bAnn3E9NQEwaIRqIGU8yb4o9xPAAugB2Nve1F8C3wh
X-Gm-Gg: ATEYQzwMfQdPLX+XYAUGXOVr+DxiP4Y/se0rMhj2x2y6LvZ919SnFwd6SnwkK7Ztf1B
 0kmN0tfTYKx44zcnCgsEhsO2Gjd0o8oIGTxt1MCgmqypnck/bQDyxIy5mCbF1xss2/lUO5jvmeO
 nl3WZioWMtvkWqtsOfn1IReTCjBgTLSfwcvF1KZCshHAHQj6hzLSV3pauUr5lOt9qzO7BYBeioy
 9whnQ7Hr/FWCGR5IsqRZv7KfKJHK80txgZ8FQ9Qvgyvmi8molPkeW3tcb7x9fXROqTQWrfSP7UQ
 oxEKk8ahsBG41Q0RgDK4p2TzQtfpvh3ZtMnPr9rOj1GxdQoW0t/QJZOLEUJnlIlYdO6wASW1NUk
 vjPB6qpaUErHx/Q==
X-Received: by 2002:a05:622a:a291:b0:50b:1adf:89ba with SMTP id
 d75a77b69052e-50b375254a4mr36964761cf.40.1774015948356; 
 Fri, 20 Mar 2026 07:12:28 -0700 (PDT)
X-Received: by 2002:a05:622a:a291:b0:50b:1adf:89ba with SMTP id
 d75a77b69052e-50b375254a4mr36964091cf.40.1774015947752; 
 Fri, 20 Mar 2026 07:12:27 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36d23237sm24887611cf.13.2026.03.20.07.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 07:12:27 -0700 (PDT)
Date: Fri, 20 Mar 2026 10:12:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-for-11.1 3/8] system/memory: Constify various
 AddressSpace arguments (xlat)
Message-ID: <ab1Vyay2knkOdcuT@x1.local>
References: <20260319191017.12636-1-philmd@linaro.org>
 <20260319191017.12636-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319191017.12636-4-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Mar 19, 2026 at 08:10:12PM +0100, Philippe Mathieu-Daudé wrote:
> Mark the AddressSpace structure const when it is only accessed read-only.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/system/memory.h |  4 ++--
>  system/physmem.c        | 10 ++++++----
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 858dc40dc5f..38e4f7b25e5 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -2783,7 +2783,7 @@ void address_space_flush_icache_range(AddressSpace *as, hwaddr addr, hwaddr len)
>  /* address_space_get_iotlb_entry: translate an address into an IOTLB
>   * entry. Should be called from an RCU critical section.
>   */
> -IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
> +IOMMUTLBEntry address_space_get_iotlb_entry(const AddressSpace *as, hwaddr addr,
>                                              bool is_write, MemTxAttrs attrs);
>  
>  /* address_space_translate: translate an address range into an address space
> @@ -2804,7 +2804,7 @@ MemoryRegion *flatview_translate(FlatView *fv,
>                                   hwaddr *len, bool is_write,
>                                   MemTxAttrs attrs);
>  
> -static inline MemoryRegion *address_space_translate(AddressSpace *as,
> +static inline MemoryRegion *address_space_translate(const AddressSpace *as,
>                                                      hwaddr addr, hwaddr *xlat,
>                                                      hwaddr *len, bool is_write,
>                                                      MemTxAttrs attrs)
> diff --git a/system/physmem.c b/system/physmem.c
> index 23ea6b69255..bbcbcedda15 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -528,19 +528,21 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
>  }
>  
>  /* Called from RCU critical section */
> -IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
> +IOMMUTLBEntry address_space_get_iotlb_entry(const AddressSpace *as, hwaddr addr,
>                                              bool is_write, MemTxAttrs attrs)
>  {
>      MemoryRegionSection section;
>      hwaddr xlat, page_mask;
> +    AddressSpace target_as = *as;

Is this one an overkill?  It'll deep copy everything of AS..

> +    AddressSpace *ptarget_as = &target_as;
>  
>      /*
>       * This can never be MMIO, and we don't really care about plen,
>       * but page mask.
>       */
>      section = flatview_do_translate(address_space_to_flatview(as), addr, &xlat,
> -                                    NULL, &page_mask, is_write, false, &as,
> -                                    attrs);
> +                                    NULL, &page_mask, is_write, false,
> +                                    &ptarget_as, attrs);
>  
>      /* Illegal translation */
>      if (section.mr == &io_mem_unassigned) {
> @@ -552,7 +554,7 @@ IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
>          section.offset_within_region;
>  
>      return (IOMMUTLBEntry) {
> -        .target_as = as,
> +        .target_as = &target_as,
>          .iova = addr & ~page_mask,
>          .translated_addr = xlat & ~page_mask,
>          .addr_mask = page_mask,
> -- 
> 2.53.0
> 

-- 
Peter Xu


