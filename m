Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4FFD58E48
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 16:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx6S6-0000Lj-La; Mon, 02 Mar 2026 11:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx6S4-0000LC-DP
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 11:49:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx6S2-0003ik-Tw
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 11:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772470137;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fBpMbwX3UDx8VRo8Xyumd1xbogO0srXD+bob7gtfAw=;
 b=PerG+ZIHkht/giv00QmbKynQ4ww5Q2/XMw4UY0j1hYefl06DIT1vCqBZufxfZOz6iw4nLY
 PeoCBhLkFZ8zFhAxVycrmQyvH5TYRR3vBoyCRhk7Sve1+x7DqjVK93M8r174S9pzoSUjnx
 n6tgtAdpTtxd6xFqvrNDZusAG9Ta6BQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-O7uQ4YuSMMG4g3KfLHnltw-1; Mon, 02 Mar 2026 11:48:56 -0500
X-MC-Unique: O7uQ4YuSMMG4g3KfLHnltw-1
X-Mimecast-MFC-AGG-ID: O7uQ4YuSMMG4g3KfLHnltw_1772470135
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48379489438so44307125e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 08:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772470135; x=1773074935;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6fBpMbwX3UDx8VRo8Xyumd1xbogO0srXD+bob7gtfAw=;
 b=sEix9hqwbUyWlvLibFuAvoIlKZKZJ5n2GnZyFobtwJ7Fs24GI9/JhCQ8ZJuvRcMncU
 wRjQXyEPrhnNHHsly9WNzQ7CNHRexUyx2zfJjrS3//qT34KsMDpcjlmfYS6eAxzKRtPT
 qoJW/nc9PUKa6brUxAhYkVhEoCEnbBKZ7g5FYYwJIfcUI5ee4bqueTfzAwV1W4K4i7hR
 SwWFz0bjSx/ThIm3tOhx4jMd2XDgIRCnA4TLswraDPWITr/ySSVQ449sZAZwaRu6cFr+
 8QWmxe9eI9fyriavnRfRjesun//XvifZkL0ixOXWZYCa9D7WD63OiGx2/GpdAzljTDiT
 9CvA==
X-Gm-Message-State: AOJu0YyIF/6bMJI70tnQexLgJjNdTJ5Nb5O+hWkzYfs75YB90pcnhU/n
 qE7z3nc3XcInrUP861VHlVSrLS8oi8zscwADh9Z+A9f/9BYPRr1Zo9NW1/hiBGCa5DztB+veZoy
 GBMiP1cMsgNFt1couQFcqYpF3bmwiQzw1UK5VCj8038c9enWi38kvkMM1
X-Gm-Gg: ATEYQzyBdlMj9GStkIvaZqBMIALUfG2S6nwsQrA+zB1Tpl2Tz94ehMfv2lj9BPwmpf8
 h6hKAvLJgcp466ezLC2y3Uv8iwSkymblSKeUDSZ1W6Y4y+mXrrb+Xy1448yixDM3tcx92/XOSCC
 57AK9uYqWexUOhSjr7iDNKaDJnZDAGzQ1H2B57wNcA1sIJsXYgOuAElMAadYBbSSdTTE92pRtmj
 1jV4gTTDJtw4Wt9f93ty6jCTY3Hxiz0kaP/0+qDRM/v9pd21zvPpI8+I4NIg7hoUaKECvnVwDip
 q+9k/OZLHHB/IXyMLO2+ZTGWv+RHVNsKPtxmMOpPBlrBNEAfypIYP47RsS9Rdz0QqJQMhCEXRjr
 yFsViJ92P7tBJ6Ics/X7E0rSY7iD64cKiZPGnnC8BvpKx//6z6nw9622nlVkN5Xm/FCJM3g==
X-Received: by 2002:a05:600c:198a:b0:482:ef72:5781 with SMTP id
 5b1f17b1804b1-483c9bfa529mr200898715e9.25.1772470135052; 
 Mon, 02 Mar 2026 08:48:55 -0800 (PST)
X-Received: by 2002:a05:600c:198a:b0:482:ef72:5781 with SMTP id
 5b1f17b1804b1-483c9bfa529mr200898405e9.25.1772470134638; 
 Mon, 02 Mar 2026 08:48:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b770e7sm315928895e9.9.2026.03.02.08.48.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 08:48:54 -0800 (PST)
Message-ID: <ad1f2339-0f48-4431-8334-5641c817d8c8@redhat.com>
Date: Mon, 2 Mar 2026 17:48:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 09/31] hw/arm/smmuv3: Enforce Secure stage 2 capability
 check when decoding STE
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221100250.2976287-10-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260221100250.2976287-10-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/21/26 11:02 AM, Tao Tang wrote:
> When decoding a Stream Table Entry (STE) from the Secure stream table
> that enables stage-2 translation, verify that the SMMU implementation
> advertises Secure stage-2 support via S_IDR1.SEL2. If stage-2 is
> requested but S_IDR1.SEL2 is 0, mark the STE as ILLEGAL.
>
> This implements the requirement from the Arm SMMUv3 architecture
> specification (IHI 0070G.b, Section 5.2, Page 218) that a Secure STE
> with stage-2 enabled is only valid when the implementation supports
> Secure stage-2 translation.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 2192bec2368..d011357253e 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -623,6 +623,16 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
I think I would rather pass the sec_sid as a parameter, indicating which
secure stream table shall be used for ste decoding
>          if (ret) {
>              goto bad_ste;
>          }
> +
> +        /*
> +         * Stage 2 is implemented but Secure stage 2 is not supported while
> +         * STE is from Secure stream table. STE is ILLEGAL in this case
> +         * according to (IHI 0070G.b) 5.2 STE, Stream Table Entry, Page 218.
would reuse the spec full terminology:
I would explicitly tell explicitly: " it is ILLEGAL to set STE.Config ==
0b11x."
> +         */
> +        if ((cfg->sec_sid == SMMU_SEC_SID_S) &&
> +            !(FIELD_EX32(s->bank[SMMU_SEC_SID_S].idr[1], S_IDR1, SEL2))) {
> +            goto bad_ste;
> +        }
>      }
>  
>      /* Multiple context descriptors require SubstreamID support */
Otherwise looks good

Eric


