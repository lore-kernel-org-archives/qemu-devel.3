Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9554C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 20:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhy7p-00057F-Su; Wed, 06 Mar 2024 15:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhy7o-00056o-33
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:44:28 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhy7m-0004yt-DF
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:44:27 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-412ee78edbbso1895365e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 12:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709757863; x=1710362663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qOs77BSVkN26lRtJwEwSVGiJq8nL5CI5avAC0pC8yu4=;
 b=Q1NexMJLu6VVVPFa0SPj2OiMXQ3RqsMg39HMOtYrGh0HOd1U/+0B7V+wcUoz7l933h
 pf6egPUMdA49GJXQLSD3jbJb/+DoMci+bX+t/UocjljyDXjHFxubteN6X351YD4EFBOF
 rfufWvKOX8v1eX5Y1WWkuJ0Fq3t9N2BIS8OIdMRLebi8oAIPfJZIT+5bOB+3F2Dpt3JN
 y1/v9hBmaBi+0/o9UwKZsEKk8v5l7ltpNyIwiHuj5x/RNLZQusjB5VcFz2XT+plDb3nS
 CuT15YNN0xuIL+0MIAfxmzyotRiVuJIORSWBu0bup3zB+wYmBIm0K8vPJH1AUJHs8HBu
 rI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709757863; x=1710362663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qOs77BSVkN26lRtJwEwSVGiJq8nL5CI5avAC0pC8yu4=;
 b=GXKEdPdIKh4voAKbE/Khqu2pO/Gd+PFhC3kqKav2xu3uSoNpqKisJQVb05LllHhMZK
 lj5+TXVmGQnK9hWs2bn0LtAuvmQeYxMOhOLDyZij50Y37twQtc2pyJoCS9v7BPklXYgV
 kpi9HZfHFf4CmQUBrVvoasiBMgIBY2snyn2Qr0uaK/FVq4ha+p8n7YedRJYz/H9YrkZF
 K3hnhYK/gpKiCuMweGxUjZ+JlB+63O8R2vbBm+tNL2kJKKhE3mXdcnDa6j85kIdNERyF
 RbW4FOhwjubHCy1YM1zzxZF+rOMMMRvH0tPajJUMnVyMFTzgM+Tho6jq3ioKrgmT5l8q
 h8RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSJMPHt0LzWWCcO4cZ76DNu1OmjOJDvuHL+gwmW5XhH8ynFDExaJERZeEWgagYU5GON+5bWmtobqUqPrFwG1XfLnYhdXM=
X-Gm-Message-State: AOJu0YwJsTtEjIjJtFqRJ/9E+7pgPtI8wxKcIbTDELWdR3tBDakBzgk8
 tvMS5mvMoo+/u42UH/xVGdYioQyRpqnXeQPcmB2gn3BV3B2NNslQX1pQ65N2D+M=
X-Google-Smtp-Source: AGHT+IEp2E3Um59CqfmAJFIs+3ECHPDuyhQA4LAIJ6b6TEXi5BO/Xa7IIwwa40vJt7rPqAJ29ZFyDA==
X-Received: by 2002:a05:600c:cc5:b0:412:df1b:4875 with SMTP id
 fk5-20020a05600c0cc500b00412df1b4875mr7975337wmb.30.1709757863682; 
 Wed, 06 Mar 2024 12:44:23 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 jg7-20020a05600ca00700b00412f778c4c7sm364335wmb.16.2024.03.06.12.44.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 12:44:23 -0800 (PST)
Message-ID: <fcaf95d2-bb09-4c55-a333-21a93a707ad2@linaro.org>
Date: Wed, 6 Mar 2024 21:44:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/9] qemu-options.hx: Document the virtio-iommu-pci
 granule option
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, imammedo@redhat.com, peter.maydell@linaro.org,
 clg@redhat.com, yanghliu@redhat.com, zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
References: <20240306203348.65776-1-eric.auger@redhat.com>
 <20240306203348.65776-5-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240306203348.65776-5-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/3/24 21:32, Eric Auger wrote:
> We are missing an entry for the virtio-iommu-pci device. Add the
> information on which machine it is currently supported and document
> the new granule option.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   qemu-options.hx | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 9a47385c15..757df3eac0 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1172,6 +1172,14 @@ SRST
>       Please also refer to the wiki page for general scenarios of VT-d
>       emulation in QEMU: https://wiki.qemu.org/Features/VT-d.
>   
> +``-device virtio-iommu-pci[,option=...]``
> +    This is only supported by ``-machine q35`` and ``-machine virt``.

Don't we need to precise x86 and arm here?

> +    It supports below options:
> +
> +    ``granule=val`` (possible values are 4k, 8k, 16k, 64k and host; default: host)
> +        This decides the default granule to be be exposed by the
> +        virtio-iommu. If host, the granule matches the host page size.
> +
>   ERST
>   
>   DEF("name", HAS_ARG, QEMU_OPTION_name,


