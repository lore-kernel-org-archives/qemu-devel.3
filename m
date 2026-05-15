Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB1FCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtPh-00025I-7L; Fri, 15 May 2026 10:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wNtP0-0001wn-Sj
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wNtOw-0007EJ-1n
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778854828;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h3jJlzzgpDRe0nKg33oaFu46l0y/vmLScvSFm/S/f5E=;
 b=MjUrehdrkHLx5ArAkynZIR0tcVSV8VNwoj29qdNhm3fnFFJgl/byTPFzGDkxHzLUqiK8+l
 aNu0h2bfvd2kEZT12Gr/Wbz0vlFRt46w8I2c6CtZ68GWPev2BweDCqE1m0Trl7vVS5ihUu
 glAcLKB+I1nJEVhZBbW+yfFqkkREsU0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-hwQgTkSdMvWQd4s-E7DDTQ-1; Fri, 15 May 2026 10:20:27 -0400
X-MC-Unique: hwQgTkSdMvWQd4s-E7DDTQ-1
X-Mimecast-MFC-AGG-ID: hwQgTkSdMvWQd4s-E7DDTQ_1778854826
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48fd2b502e2so23816935e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854826; x=1779459626;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h3jJlzzgpDRe0nKg33oaFu46l0y/vmLScvSFm/S/f5E=;
 b=lv/4QHIxR0I5PVG7PSB9UymfYugsOAoqI+D42U9iDw8REvSocXGysy1jn/2p75l9sM
 E1HkRttmGVRAEZ8ARqhqpTSNO7kBH3v5Jqi3AD3S7UuLKhpDK06sHQP1bfjxeXkmiYF7
 LB0jGmLYQzbgN03nI9CIMqoGuwj4cxMkyJq7LYC8A7O3r07zUCPNEnzdVVo1hUSSVjij
 uCGSqP6c0JS6miChCnI7pfx6DjcV0IopYyZReQ8qmOlIzTxh35rBo96wkJyjInN1f7nW
 eq1N2ETx4DuAt9ltIC9EbfwD++cpNWS0yiKUpKrTlRIKaubwMf5iMaIh9pd6WLxLN8Ce
 PV8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/H6NssW/vuU0L/U5DWPag9TYUiRORgTPrkNNuqxW79ZYW+C1AGmLhhlR6zOk1alqeth3SBvBEbWH5m@nongnu.org
X-Gm-Message-State: AOJu0Yz6AvbCaTSiM02Xlga4KcDVzVK+WUFTFRlUz38YaYxjmXwgvjBN
 T7g8SxmnNXSJIJgweAUWuEkmTUnL6DaQHEpk7RToTsYJptvVHNmNrB4ag542MLokl/r8/2/nY+X
 /M5WEkF1QhqM25iXmD6GPXa2f7BiGejwEOE4HU9MgURVmKtcIJYAr+kjtFET0bt9q
X-Gm-Gg: Acq92OFRyDqZbzWPDoQtf9GJO80J3zMoUhtaXiZHI4UWNxdp/jS52jfABQ2lOhplc20
 +JS7IL1b4BiYv08bN/wfpzmp1pjIUlojPFWWpBtFATKMEG1hiPuq8SxSTe689ZP3lgmqgwkiVnA
 MRq8MlMIspZpsh6nuEjJiPlvGcHlNk0rZTzJWQBHctIZdDnKEa1V5OQizUisUwL4LZEI1hme1RA
 DhfbdEQ/amvToLkr+7eKlELbgFaZwiqAWvdIJAWrgtLahYf+Ra3C/ZQF7joIeut8bsUmyMKReUJ
 iBl6yslItXP1IestAX4qN+mWpVgAJ8f5Z1nd4FRqn32AMsidcjDWV6S3nU+j3itCSQuW3xyfcZv
 l5QOoV8Pv9N3wEuBx2cL0r+bOY0BfmYEUAp8IN1SCx47AY2n0EgMVfEO+Y4iHbZSBKasKo37BO9
 xUVXjD
X-Received: by 2002:a05:600c:46cf:b0:48e:8974:c377 with SMTP id
 5b1f17b1804b1-48fe6626ba1mr57267185e9.29.1778854826008; 
 Fri, 15 May 2026 07:20:26 -0700 (PDT)
X-Received: by 2002:a05:600c:46cf:b0:48e:8974:c377 with SMTP id
 5b1f17b1804b1-48fe6626ba1mr57266545e9.29.1778854825433; 
 Fri, 15 May 2026 07:20:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2c96csm16508605e9.2.2026.05.15.07.20.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 07:20:24 -0700 (PDT)
Message-ID: <a2e9e975-5fc0-4045-bbdf-762c4809b704@redhat.com>
Date: Fri, 15 May 2026 16:20:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 03/13] target/arm: named_cpu_model: initialise
 additional sysregs
Content-Language: en-US
To: Shaju Abraham <shaju.abraham@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, cohuck@redhat.com, sebott@redhat.com,
 skolothumtho@nvidia.com, philmd@linaro.org
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 prerna.saxena@nutanix.com, jon@nutanix.com, jond@nutanix.com,
 Khushit Shah <khushit.shah@nutanix.com>
References: <20260513163356.3033159-1-shaju.abraham@nutanix.com>
 <20260513163356.3033159-4-shaju.abraham@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260513163356.3033159-4-shaju.abraham@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/13/26 6:33 PM, Shaju Abraham wrote:
> Add entries for sysregs MIDR_EL1, REVIDR_EL1, AIDR_EL1, ID_AA64PFR0_EL1,
> and ID_AA64ISAR3_EL1 to cpu-sysregs.h.inc.

Can't you reuse
[PATCH v4 03/17] target/arm/cpu-sysregs.h.inc: Update with automatic
generation

and associated python script to automate this. I think it contains all
the additions you bring here + some others.
for 
Eric
>
> Co-authored-by: Khushit Shah <khushit.shah@nutanix.com>
> Signed-off-by: Shaju Abraham <shaju.abraham@nutanix.com>
> ---
>  target/arm/cpu-sysregs.h.inc | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
> index 3d1ed40f04..82a83d9d5c 100644
> --- a/target/arm/cpu-sysregs.h.inc
> +++ b/target/arm/cpu-sysregs.h.inc
> @@ -41,3 +41,8 @@ DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
>  DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
>  DEF(CTR_EL0, 3, 3, 0, 0, 1)
>  DEF(DCZID_EL0, 3, 3, 0, 0, 7)
> +DEF(MIDR_EL1, 3, 0, 0, 0, 0)
> +DEF(REVIDR_EL1, 3, 0, 0, 0, 6)
> +DEF(AIDR_EL1, 3, 1, 0, 0, 7)
> +DEF(ID_AA64FPFR0_EL1, 3, 0, 0, 4, 7)
> +DEF(ID_AA64ISAR3_EL1, 3, 0, 0, 6, 3)


