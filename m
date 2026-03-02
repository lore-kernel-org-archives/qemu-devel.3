Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9A5EB3625
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 17:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx6uS-0001Fj-8q; Mon, 02 Mar 2026 12:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx6uQ-0001FE-AN
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:18:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vx6uO-0007kJ-TH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 12:18:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772471894;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dpxjjh/gF6uN1WRr/chSKettRcQBHQ1QzKI2hWN0Ehc=;
 b=FfKbfZuVdg/uCTvAM7QI+zr+QXWhpbbZQSPd3QF1qSI+dtv5qR6qnzAZEo8DuIlNgyOAb4
 ug8cDRAC2wS4EA6ae2ITz5w27PftXr0bZhg+PC3de6X3VVvdp2hZb1Hw9QMaLYbsPgbBda
 G/SOy0zNUV3awhIKRZTTd0Li/4AQ96A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-iywb-BNZO76amx36yZHtBA-1; Mon, 02 Mar 2026 12:18:13 -0500
X-MC-Unique: iywb-BNZO76amx36yZHtBA-1
X-Mimecast-MFC-AGG-ID: iywb-BNZO76amx36yZHtBA_1772471892
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-483bcfdaf7dso44502765e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 09:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772471892; x=1773076692;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dpxjjh/gF6uN1WRr/chSKettRcQBHQ1QzKI2hWN0Ehc=;
 b=DjvRM0r/82Vn/tEYBVjPu3AIQPED4d/SkhpKjkOKOCFNX7YV8geY0RHMA4E/Epqbzc
 HNYFryN0HjBswnnr7zlkEF5td22hMR9PdhbEkL2Ro46XmzeZtxujyfQJjA+odVuhn2yS
 z6lqfxEdR6+BxoZD2pe1WyRgC5xlWZpZj9fpvM+/RDJJa5C+0KL+4T26tYR3u6eXK7CP
 8wm7LqfeuJMeIZMGcV4D7qsj+h/8D+SDZXH2TtwZ8tgLmcNpiwxKNKXmauVDkzMc5Fmr
 Ofnzq/zs+ImbNpB14haE1sN7u8BJ7fR431H+b7Pwz1WOfPsvYTXGPY5FlyqBIfIn7VHP
 KVkQ==
X-Gm-Message-State: AOJu0Yyqu/8udQTnnjV2uYYkFNXexm3jSjemBSaZ9fiBfXeLZCrAmmWT
 W06nPzL08yKGmAREwG2t14QU/a3XZZ58pYrwoahwFBBbt5SuhMf6ggQqMW1/OBEvF7wuuRuNBoD
 XVSsOOJLQytwuwUJs4n1eIxYdkUdFin0lLCXm9SWP8SYerpsr5nfdQOtl
X-Gm-Gg: ATEYQzxBXj0WIftm+k3Ypnv/pR5HLZCRprBiv6SxVTL3QJjmjnHr/Vp6ch5jVhl1wt6
 yy/18zf9zyvID9LAemd8CawzP2z1Tjx8pDe2nGHlTWHgeCt/zMC3xlMEN7qDt1Jxc8AUtD8BsUD
 y6Sn9nHw+sbkE70NwQO/8BD8URepGhumrzZFPlF3NhD360ZzJXhdUd+3AkJOxwaTe7nIwtKepTc
 W3c14HheRmpL9edEZLKsQ0midoXJfaGe85Jsa/Tjy6+mJgN9bM/Vd7cvkXAx9mNP8wpgDGcX2fi
 OgZdsLkGCqbQgYAMeTBce1MGO95ACMv1+mOJ7TpkkK7ws0qjSak5ynyGJQ3cTGVcXgrMryI9okt
 fANEGW2NCi/BVMbJftbXHnylU6B7SWpaHOKCl6O7QFfFh3iL2mC+GJllH9oFAS0vxGrLD5w==
X-Received: by 2002:a05:600c:c490:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-483c9bb1fb0mr217025935e9.10.1772471892039; 
 Mon, 02 Mar 2026 09:18:12 -0800 (PST)
X-Received: by 2002:a05:600c:c490:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-483c9bb1fb0mr217025315e9.10.1772471891494; 
 Mon, 02 Mar 2026 09:18:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb8724bsm171157845e9.11.2026.03.02.09.18.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 09:18:11 -0800 (PST)
Message-ID: <f41eb7d1-9287-49f1-9eb0-c2eccb07b394@redhat.com>
Date: Mon, 2 Mar 2026 18:18:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 12/31] hw/arm/smmuv3: Store CD NSCFG in TT info
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
 <20260221101632.2993305-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260221101632.2993305-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 2/21/26 11:16 AM, Tao Tang wrote:
> With NSCFG definitions in place, record the per-table NSCFG bits
> in SMMUTransTableInfo during CD decode for later use.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c              | 1 +
>  include/hw/arm/smmu-common.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index aa1a95a0093..b8f2fae9a1d 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -838,6 +838,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>              tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
>          }
>  
> +        tt->nscfg = i ? CD_NSCFG(cd, 1) : CD_NSCFG(cd, 0);

tt->nscfg = CD_NSCFG(cd, i)?

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>


Eric


>          tt->had = CD_HAD(cd, i);
>          trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz, tt->had);
>      }
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 9e44c9f7710..bd88e599c77 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -83,6 +83,7 @@ typedef struct SMMUTransTableInfo {
>      uint8_t tsz;               /* input range, ie. 2^(64 -tsz)*/
>      uint8_t granule_sz;        /* granule page shift */
>      bool had;                  /* hierarchical attribute disable */
> +    int nscfg;                 /* Non-secure attribute of Starting-level TT */
>  } SMMUTransTableInfo;
>  
>  typedef struct SMMUTLBEntry {


