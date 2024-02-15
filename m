Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82EB1C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 09:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raY83-0006Ut-3v; Thu, 15 Feb 2024 04:34:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1raY82-0006Ps-1G
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 04:34:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1raY7w-0005Ef-8s
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 04:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707989635;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HzhtXHLir8CDQnAkHAFmNr4fZ/GLTywIOTaBPghvAdE=;
 b=XXGn/xTxUbJ+wF5u5HoLm03SnurhDz4E1Kv7P2cUaBvmfPP62wXuVHMnvakqoHd8PNqMlK
 0L2wmwaZfjg2kkBPer2J3zdO2xlnU6LZlxJVSMOqS9f7iKpCfnGTMMeQmSDAzahL8Dpa+f
 cNzyYABai4U1POCHO87DsQSE2BPoU7Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-wpNClk6fOCSXnPcZfk7L6A-1; Thu, 15 Feb 2024 04:33:53 -0500
X-MC-Unique: wpNClk6fOCSXnPcZfk7L6A-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-68c7947e07dso6461356d6.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 01:33:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707989633; x=1708594433;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HzhtXHLir8CDQnAkHAFmNr4fZ/GLTywIOTaBPghvAdE=;
 b=W1aSlMVWrAIXltp/OtmIAOZQf//5J3sZa/k0Iubg9TVFBo1zMIL0csU6tLd1cmlPnt
 9Uw3zdVD8lBO0Rd9GZ9NyeJZwSGrZi6jGqo5m19gE0NlZ3jtzlq2biuit1cPiC3gBIlJ
 mZxiiBM4Gwr/7Sr2abbbmFWfynTy23RT8iwIIG8PCwHY4O+0ohP2LHlWeKjaLl0UIR4d
 oxtJaaSLpJQMxrbk83RCMgcXxo70zNVrE27u2MiWXcfvy/kUStfiyQPWKopuIrj1tZnD
 wIwHiIV1y+sEWarxHqd/6MlvCri3fbucdihsNgO9Q3ndjcPzpAMCxNjklDXxu7uU1Rl3
 qOJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfsc2QT9Sxg7iPdHgXXNuDk7zvObuHlqRjr1L2FXMIDiVJEenylQUvbD59xpgI22X6g0U+oLXOCd0M/OF8zIUcn28O5dE=
X-Gm-Message-State: AOJu0YxkXIfuDX3LEe4NWeKGEhjJequSwkKcZJ2BMNPl/7a7j1FV9oQA
 DAcdpWMY4z4R9PnojMFBFPFuvxoTY1YI/YCAQLKeBlAXjqiWG3/ld0CXkfiFIDq0mu0zuB9yiA9
 aRkIKF7dj/hVrqqcd80fmhwN1YBR9SpV5Qv7BcCrdulhwRfECzHx6
X-Received: by 2002:a05:6214:c4b:b0:68c:5a4d:35ac with SMTP id
 r11-20020a0562140c4b00b0068c5a4d35acmr1415072qvj.1.1707989632974; 
 Thu, 15 Feb 2024 01:33:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHr7AbwH4tjUJNFnbVixJ0meQXvvOOQlUgZGBGvZF2K6p+1yMN+Nz0c+V6jc83r/i/X/ItrnQ==
X-Received: by 2002:a05:6214:c4b:b0:68c:5a4d:35ac with SMTP id
 r11-20020a0562140c4b00b0068c5a4d35acmr1415060qvj.1.1707989632749; 
 Thu, 15 Feb 2024 01:33:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 mn14-20020a0562145ece00b0068ce5582a04sm484742qvb.80.2024.02.15.01.33.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 01:33:52 -0800 (PST)
Message-ID: <ddf8b1c4-059a-4567-9ecf-4186711b89c2@redhat.com>
Date: Thu, 15 Feb 2024 10:33:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] qemu-options.hx: Add an entry for virtio-iommu-pci
 and document aw-bits
Content-Language: en-US
To: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, mst@redhat.com, peter.maydell@linaro.org,
 clg@redhat.com, zhenzhong.duan@intel.com, yanghliu@redhat.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com
References: <20240215084315.863897-1-eric.auger@redhat.com>
 <20240215084315.863897-5-eric.auger@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240215084315.863897-5-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/15/24 09:42, Eric Auger wrote:
> We are missing an entry for the virtio-iommu-pci device. Add the
> information on which machine it is currently supported and document
> the new aw-bits option.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
argh forgot to add Cédric R-b collected on v4

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Michael, please apply it when/if you decide to pull it

Eric
>
> ---
>
> v4 -> v5
> - tweek the aw-bits option description according to Cédric's
>   suggestion
> ---
>  qemu-options.hx | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 8547254dbf..a98bc7bd60 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1172,6 +1172,14 @@ SRST
>      Please also refer to the wiki page for general scenarios of VT-d
>      emulation in QEMU: https://wiki.qemu.org/Features/VT-d.
>  
> +``-device virtio-iommu-pci[,option=...]``
> +    This is only supported by ``-machine q35`` and ``-machine virt``.
> +    It supports below options:
> +
> +    ``aw-bits=val`` (val between 32 and 64, default depends on machine)
> +        This decides the address width of IOVA address space. It defaults
> +        to 39 bits on q35 machines and 48 bits on ARM virt machines.
> +
>  ERST
>  
>  DEF("name", HAS_ARG, QEMU_OPTION_name,


