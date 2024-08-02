Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB4DC52D70
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 06:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZm2N-0001Xc-5s; Fri, 02 Aug 2024 02:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZm2K-0001Ot-2V
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:45:12 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZm2H-000537-55
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:45:10 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5c669a0b5d1so5282471eaf.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 23:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722581108; x=1723185908; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mgjiSS41us8Umqmas73ZqEn9GdntHOOBLqlg0IuwkR0=;
 b=MWNz41lTp7G+8ZpVs4PdwbMS82obDTSUpNcM+o/bRKfOlchMGcLLQc+QSMxBQuZsiE
 UIQGF1b1r+gl1eBBn8qMuMBfYbr6FB3O/AWeyiyjHafEGs41RYY6sT6O0LOgIIOGOK1I
 kACXpvzMQTEhlFI1iRR9Mjh/RkxgYsDmYgaQO/73sa+hjN2+6GxqnQjHNVYWudJ6kXZL
 fp7pyKRv/ESkJLqob8VEB6KH2NH+ixL4cm5RapQab/Zu5L0bBHeIWhzvHehdaCtTGqxT
 ltC2jgWS/cvEpH8scWYFCo2/dX9tZMKi/WkttvW6qPMJBwaOA5KGJT9IEoT0xl9/wpq0
 GdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722581108; x=1723185908;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mgjiSS41us8Umqmas73ZqEn9GdntHOOBLqlg0IuwkR0=;
 b=Vd2e+ERYtO+gL/SSGhXUVngNJ4bqy0253QOnuUSTpX+G2gsrttPzrIkJMcYpa6mJfG
 2wW7gtpAlDD4fj6iKE/33jcI95EY865cPlTmnr/nYn/Xw+cjMAy5YiMhjfHnDlMmfMS8
 HaXZhGF7DBiLX4zdTm35cXyJ5sHptcIr9nyL+zU1q4lq8QaP/eHOdCwIEZ+86XRY8Tln
 etGA39IzC6/9ZeuglVpiyc/b7Tl1tdxact4dGw3DxO6noHVsE4pF0u68yX3XacAvowMs
 OnUc8VBpp2y8p/l3XWQIYZSwVVL3yl7u5guY7R0RPx3fXJzKf9hr+HZ/CNh7feEeM6QU
 2veA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfTELKN8ytIc+dE/P/MXhBIc1Hig2RA9Ot+QQmz6dg0eezQTOQ96v2uJr7GrziQSQmePawfAK14ScCXd1DnWJcu3yhWlA=
X-Gm-Message-State: AOJu0Yzd7WGo4cK7Ipy0QxuN+qRWm2qDJeLnXOss00ToSvsE8oLpci2Q
 cN8375vWyIJJs/lnxuKsp2jhQm3hsICYMrh1dVHgi6qVOCvkN7T4SHhB1UWkwgQ=
X-Google-Smtp-Source: AGHT+IEQG1oTbtrbxVx+X/EmoO3BCOcRERL6k5557hHodmoB6R7PBjZRCZMoF5wM9g6QICxUVq3ocA==
X-Received: by 2002:a05:6870:4714:b0:261:877:7459 with SMTP id
 586e51a60fabf-26891ea8f7bmr2611888fac.38.1722581107656; 
 Thu, 01 Aug 2024 23:45:07 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec0bda0sm782677b3a.8.2024.08.01.23.45.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 23:45:07 -0700 (PDT)
Message-ID: <5580439d-08ed-483c-aecf-e31536f36f79@linaro.org>
Date: Fri, 2 Aug 2024 16:45:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] target/riscv: Add MXLEN check for F/D/Q applies to
 zama16b
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240802031612.604-1-zhiwei_liu@linux.alibaba.com>
 <20240802031612.604-3-zhiwei_liu@linux.alibaba.com>
 <e565894d-8378-4dbe-92ef-afd54d864810@linaro.org>
 <b65aa4d1-c206-4ebb-af8c-75b034c6b875@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b65aa4d1-c206-4ebb-af8c-75b034c6b875@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/2/24 16:21, LIU Zhiwei wrote:
> By the way, the MXL is const now in recently updated RISC-V specification.

Oh yes?  Then perhaps we should rename misa_mxl_max to misa_mxl.


r~

