Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B35DC61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzYvS-0001aT-Ip; Thu, 27 Aug 2026 08:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wzYvR-0001a2-2T
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wzYvP-0007x0-Cz
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787832582;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PgeeWjtfQltgIjCPzXNpTJTj8fAdJm1l7RIL8AatcnM=;
 b=aak5bOTeclfz6YP3OuXyN0ODjYrGtPV8fO2NoJrlsUU1vKWQtKiA5EPlV1k+Tghni4hrXT
 5tTB0lQR/9g+1d22Yjzhfh0MGhOZRtxPYjB+j1zE0S3N5EPrhx8TgEVR4gROuUfein1cOX
 jL2pBf/RQWtwgY/wU/Kdv8wk9UCybhg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-ZmLD1O-FNQSb__i4gEUvjA-1; Thu, 27 Aug 2026 08:09:38 -0400
X-MC-Unique: ZmLD1O-FNQSb__i4gEUvjA-1
X-Mimecast-MFC-AGG-ID: ZmLD1O-FNQSb__i4gEUvjA_1787832577
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49b8c651ac0so4918295e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 05:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787832577; x=1788437377;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PgeeWjtfQltgIjCPzXNpTJTj8fAdJm1l7RIL8AatcnM=;
 b=F4OldyFiSho0ry1NDszdH8Au0OyoYBl/o5EbcEApnM4KbIsCLcyAo0UqDAmzwGrm/3
 BRq8ioQac0sp/jSTIm1tM22bpmak+5lexVth2o/Bi6ssI3lEC3rF/10X25W6VIStFs1y
 usk/lsUKu9eo5NkV8EYgDO3bc8Pt2p0TZqG/aUmAaYgBEg00gtRxTNDgbiIHMtoFkYD2
 QDxLn/gQYtBHqS3tKH47kquNDAraRjYgiyIkE6FWRXXMKr1AyUviSvqO5mloxpaqqFXe
 riJIqzAgwflPSiYX5/bxH0foUGZAblanWZa0BNFh42TqFOjdYH+/Te/Ko7gf5AodAJ1j
 DxqA==
X-Gm-Message-State: AFuF++myCO44LnwhNH+N3CteGMh+0dSIgNAIFK//2/69kJYPJY48CC5x
 tYW8B03lHjzHHBkmN7aTO+d42wAn6N9l4DSsb/GJNWJHILu1UbKPeNJIL5l+TWH/8YR7714eA9d
 RWInPFE1qDUhmiPRW/XYZ4rgBqwoi62UF2/c9WzSruTvPftQZFNQEGoYp
X-Gm-Gg: AR+sD132ttNBMUJLOFRwBFEEsog5rHr2qtCnlzgpTBgjcs8WtSLnW0yBnvhKoBBIJz4
 dBM3mSYvChh1b2bdzZrRdwGlkHwwUI8eRAgNFUoBIuJR5IpHUzReJPBOTmZVo1eKTEfUguD51Xh
 pLiCdW1xscIOt2txlUVWRAfIjivXIJlefEEPfQ3On9Tazl9T1ct1bES/iw3VOhDn5CUXQYD0x9H
 8tebuJPXxItOWPWGNVxZb27W29Sdy1MRGLBJrYOVNL0p1xj7VRx2pGsL8j3P3dGCfc2ZuRI5ljn
 D5WsaGCNZdpvR/gHxxwGdTsBGDb3ZTQv1LOW/E3gx3Yobdaps2c+LEuxxP1MwhmkWI9XUTpH4ps
 2wAzBHFZXkK18VxVFZthJOY/bJFPRYshYyNcTMPob45AsMu2H
X-Received: by 2002:a05:600c:6912:b0:499:cd34:100d with SMTP id
 5b1f17b1804b1-499dc703bd3mr187757475e9.7.1787832576818; 
 Thu, 27 Aug 2026 05:09:36 -0700 (PDT)
X-Received: by 2002:a05:600c:6912:b0:499:cd34:100d with SMTP id
 5b1f17b1804b1-499dc703bd3mr187756495e9.7.1787832576403; 
 Thu, 27 Aug 2026 05:09:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49610170sm110944935e9.6.2026.08.27.05.09.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 05:09:35 -0700 (PDT)
Message-ID: <7eb87bf3-39c4-47b8-804d-15cbbafb78a7@redhat.com>
Date: Thu, 27 Aug 2026 14:09:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 07/28] hw/arm/smmuv3: Reject secure STEs with stage-2
 enabled
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162446.2806393-2-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260813162446.2806393-2-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Tao,

On 8/13/26 6:24 PM, Tao Tang wrote:
> Pass sec_sid into decode_ste() and treat a secure STE that enables stage-2
> translation as an illegal STE.
some coming back to [RFC v5 06/28] hw/arm/smmuv3: Plumb transaction
attributes into config helpers

why did we need to modify smmu_ptw_64_s2()

>
> The current model does not implement Secure stage-2 translation, so reject
> Secure STE configurations that enable stage 2 and report BAD_STE. This
> restriction can be relaxed when SEL2 and Secure stage-2 support are
SMMU_S_IDR1.SEL2  (secure EL2 and secure stage 2 support)

Besides I don't get why you set SEL2 in last patch
[NOT-MERGE] hw/arm/smmuv3: temporarily enable SEL2 bit and some other
features
> implemented.

>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index b5dc67dcb01..3ff2f498a3b 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -597,7 +597,7 @@ static void decode_ste_config(SMMUTransCfg *cfg, uint32_t config)
>  
>  /* Returns < 0 in case of invalid STE, 0 otherwise */
>  static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
> -                      STE *ste, SMMUEventInfo *event)
> +                      STE *ste, SMMUEventInfo *event, SMMUSecSID sec_sid)
>  {
>      uint32_t config;
>      /* OAS field only presents on NS-IDR5 so we use hardcoded SMMU_SEC_SID_NS */
> @@ -651,6 +651,14 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>          if (ret) {
>              goto bad_ste;
>          }
> +
> +        /*
> +         * It is ILLEGAL to set STE.Config == 0b11x according to (IHI 0070G.b)
> +         * 5.2 STE, Stream Table Entry, Page 218.
> +         */
> +        if (sec_sid == SMMU_SEC_SID_S) {
> +            goto bad_ste;
> +        }
>      }
>  
>      /* Multiple context descriptors require SubstreamID support */
> @@ -916,7 +924,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>          return ret;
>      }
>  
> -    ret = decode_ste(s, cfg, &ste, event);
> +    ret = decode_ste(s, cfg, &ste, event, sec_sid);
>      if (ret) {
>          return ret;
>      }
Thanks

Eric


