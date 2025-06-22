Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A906C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9XR-0004qu-QB; Sat, 21 Jun 2025 21:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9XQ-0004ow-Mg
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:30:28 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9XP-0001cy-2s
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:30:28 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2353a2bc210so26016295ad.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750555825; x=1751160625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RWOykvxfGjPHUadBLUF/geJT55VSm7MpbM9JSKhb3Ss=;
 b=WHMZSoCMOKqtHnEnwv1tn8l0U3N8ek0YSdwv9Lr//VtVr7Xsr/ONNm0SyyqkoFYLyJ
 L6OujTdFyZTMapHw6ym6oKFexMoyNond+kFxmKeBU9J4Ub4GUbG0YVZKbatWEpHqTF8G
 /zI1deBi6slKGnVgjyD1iQMgdcHWz5gyvZdgP/rT+tO8apa4X3R5HZhmR4kamhYS8oj4
 qJKwF8Ya0PZ7P5Xbav8eDLnexnhVp3MiOB/mwR1TEEfKCGW9/1WB6pDMvv7hNqMPCrHT
 ZJ18GvEB6bt85R6ThqoUwWUBDmebN4TphswiDblxg2k9GISrofNloslJMjDUVXZFdWSj
 I6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750555825; x=1751160625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RWOykvxfGjPHUadBLUF/geJT55VSm7MpbM9JSKhb3Ss=;
 b=t60S4HJLZeMun1M43D8iqsH/4kAx3QVjXWvnXVeC6I2Bm8wgg6sw8hIS8yD8nguOY5
 GC3j3LoTyDeL5/8pqfu/EGut6DdSRDCj95SUzR8XsJK6R01zLfZDuHWsbb4/yrLyKD/5
 oYIaqhj5vu5g3UVMRKSLRfajmDf27uDmyL4YHJB2YIKyBS3ckDSMFjCo7ywFdtLR74cE
 V/fy3xXnknF0EgBuOZdMFs47cSamD6ZjeDuwGe5HBtJvDMaVsMeaXkAMv7FsjKVOUEf4
 GG6Pj7ipectU81u7C1WolU9uvios/m7fGA2w0MokaKtt8AHiAAeiIsNZpn8ySfgPsrc8
 VPtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEtmrNzW1GVjoXFGLkR4Uh/G0yETFAcwChNvO1RcgB/GnFdNIFt8inzZg3C1eCwn/VwGCjmH1//qHK@nongnu.org
X-Gm-Message-State: AOJu0YweijrTM0PgF+ZGBWgFiDc0EWNLhgt6QJHl+rFVP2fb+q81cztP
 WqeRU//eR1lYP0Om5Y0ee19z+bJOyQ+Lfdx8yIHQzk+IBU8uBhoipeTylAqpTbx4xnM=
X-Gm-Gg: ASbGncusaIjcJ6ZiwXL1zrCQSMjIHHyOu9ttkN0yeXbA9atAbKRV230g/dDoB3c+im/
 HtQAOHOuSYxh1KyNlQh14B5o0srzMQMTitDaiFXoSh83o7ZomI6aVpR82zdTQiFMCRFWVOrGYZa
 7w5k+sV8TbhQtmL5dEE4UUjgGXnmYYRiQ9elxnKWFZis6BUsnTYuMeQEzwdNPNzNHC9D9azQXRj
 ieBQA5+OSFBis4JpJC/KU58Onh+Hs0Jev8+u5LUZutZ24VID7iQQEvIhXF174OpJsjdHgzMMnas
 UWH9kSHi+Ujq9YX8GdFr30UnOcf2OvLlQE1+BswlcCUsuxfG8fKQh7pRqa2honX0WK9Jyb1imMX
 W8RV+/nbnsyHBLh+JMPhM6voyhcsRtSiBtRrD9PA=
X-Google-Smtp-Source: AGHT+IGFfoJxndH2LNwameJiCXsHvU+Eh3uIXw11Zz/bxrfw9DcDCc6fmmjrwEWVo15XlCL4WK+pwQ==
X-Received: by 2002:a17:902:e752:b0:237:cadf:9aac with SMTP id
 d9443c01a7336-237d98e2a87mr124848845ad.29.1750555825452; 
 Sat, 21 Jun 2025 18:30:25 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d871f10fsm49323275ad.233.2025.06.21.18.30.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:30:25 -0700 (PDT)
Message-ID: <a31e12db-724f-4263-af3f-1e3f78990f24@linaro.org>
Date: Sat, 21 Jun 2025 18:30:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 19/48] cpus: Document CPUState::vcpu_dirty field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-20-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 33296a1c080..69ea425c458 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -441,6 +441,7 @@ struct qemu_work_item;
>    * @opaque: User data.
>    * @mem_io_pc: Host Program Counter at which the memory was accessed.
>    * @accel: Pointer to accelerator specific state.
> + * @vcpu_dirty: Hardware accelerator is not synchronized with QEMU state
>    * @kvm_fd: vCPU file descriptor for KVM.
>    * @work_mutex: Lock to prevent multiple access to @work_list.
>    * @work_list: List of pending asynchronous work.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

