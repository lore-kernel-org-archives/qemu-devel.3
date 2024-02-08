Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B59C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 20:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYBHQ-0001sv-6v; Thu, 08 Feb 2024 15:45:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYBHB-0001rb-Oj
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:45:45 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYBHA-0000Dj-8X
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:45:41 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5d8b887bb0cso138800a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 12:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707425138; x=1708029938; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EsSzy3wQvknz32a1jwZ+vWlE083EatXSi9fcFIbNxIQ=;
 b=JGaPoVTOIn09ycLrR5AIk7UIDwJqKk8ruGze9U3cCSNJgDngmeqEf5gH6hT+dGonI+
 uqNTYNoQ3AFZ9jMghiBzfLeU5QUslVUloibT3ijPMX0iamlnfeeD5OV7OS9Um5eKwj+0
 IxN4jzg8wPmw+RBHZvuSmma33x8sY9ly+JrqBCznBCa/HfF3VrLLsTqggR0y8QvPZd39
 1DtdmKIqw8GFwtXcBx0B4qiXFbCkCjn1Qab2CYX1xwlqJykI8iIFYxqF4148HA9pRUl2
 VsL41iKT60E4cCWF3VDxMmk0zL+GFUrCpXIdujiMzNKLiFuiyJwb3umm7hLxrUcnHJAO
 Pu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707425138; x=1708029938;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EsSzy3wQvknz32a1jwZ+vWlE083EatXSi9fcFIbNxIQ=;
 b=Jd4ggyzG6AZeFBtzDEnboRaEextb0/0GR2t0VY1lB8kcWEGaOEag6k3Vw2EnNw4GrX
 F0aWM/oShG791E93E0W/ehBk1EqBn/8GkzTHfgcNKPZUDLt0WwloL98n9qs+YevaGn5P
 V+DcER7jVawI3Evrpn+ssnxZhzJuOrAFGlP+1UefTF/tdyHxv/9f1qV9G4116ox2gwaH
 fHCMZ68rDW/CuxxpujBgflmDjhnK78/Ux1rK/kuMHEu3t+3p5/AR35nRoltTC0Xn2J4K
 7b7aWzHsUQzP9ivBkMBUfeLd6ju/SXNKT8O9vHyedCoNsYk2NXbocMo8vbhYnuGt5WxS
 AumA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfX1HdbB68I4sYfQlmzfxvXCZcYB6Ul4cTNQiyjcznOx3we6uKM5rlLNJDf9XR96iZ05xmyScpuX6VAFFjoRAPkKKhgSE=
X-Gm-Message-State: AOJu0YzB6zGg7Js/AOZBp7zbaU1uwFRTOBD2517uB0bHYikIDhSjO63R
 BUXFMysb5sOsud3WDve2nXCq/3ITlgts8xrzHZCEWPby/VOhlzY+nWak3fGqwEc=
X-Google-Smtp-Source: AGHT+IFDwmnXxtyj5nFFSYO5ykGXJADenFLepoE+FFIQ6IC9HP/bof5U07VTFFwWmoA3vOJfA+hz8w==
X-Received: by 2002:a05:6a20:e119:b0:19e:3ccd:6f86 with SMTP id
 kr25-20020a056a20e11900b0019e3ccd6f86mr855004pzb.43.1707425137841; 
 Thu, 08 Feb 2024 12:45:37 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUpHIa3IlDdw7TxryK3xhDZ+VjYfBMfKRI5XSv2Dsk0389yl9iPou0ATQFJwTAw7w+4ulx2r8MLVPdKtS0HuJTWDkBhcRg=
Received: from [192.168.4.112] (066-027-223-101.inf.spectrum.com.
 [66.27.223.101]) by smtp.gmail.com with ESMTPSA id
 st12-20020a17090b1fcc00b002970242eacfsm226796pjb.19.2024.02.08.12.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 12:45:37 -0800 (PST)
Message-ID: <b292807d-8d8a-4b93-861d-10b52fb87bc7@linaro.org>
Date: Thu, 8 Feb 2024 10:45:30 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] hw/pci-host/astro: Avoid aborting on access failure
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20240207182023.36316-1-deller@kernel.org>
 <20240207182023.36316-5-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240207182023.36316-5-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2/7/24 08:20, deller@kernel.org wrote:
> @@ -610,6 +607,7 @@ static MemTxResult astro_chip_write_with_attrs(void *opaque, hwaddr addr,
>                                                 uint64_t val, unsigned size,
>                                                 MemTxAttrs attrs)
>   {
> +    MemTxResult ret = MEMTX_OK;
>       AstroState *s = opaque;
>   
>       trace_astro_chip_write(addr, size, val);
> @@ -686,11 +684,9 @@ static MemTxResult astro_chip_write_with_attrs(void *opaque, hwaddr addr,
>   #undef EMPTY_PORT
>   
>       default:
> -        /* Controlled by astro_chip_mem_valid above.  */
> -        trace_astro_chip_write(addr, size, val);
> -        g_assert_not_reached();
> +        ret = MEMTX_DECODE_ERROR;
>       }
> -    return MEMTX_OK;
> +    return ret;
>   }

For writes it's cleaner to just return these values directly than introduce a local.
Unlike reads, were you still want to go through the tracepoint on the way out.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



