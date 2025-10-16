Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6275CCCD195
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Pal-0000AJ-AA; Thu, 16 Oct 2025 11:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Pae-00006T-FA
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:08:31 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9PaW-0001g2-FM
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:08:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso6919705e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760627298; x=1761232098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pz8Uk6XRi7NLPJCE3ivBH5VhQAk+WZCgHBRQPgQKvt4=;
 b=Ktmc12bSQQeMUCVu0OhkFgMsso0qujB/Be/c9bZRUyw/I4+ePp1ffS0ja5+baCHUD7
 iZfQ7SaJX6GRzYCip7LLSXDmPv+TF+Y2IfODaw9Kil714WWTPtusSaLLdd4VPTISoKoZ
 XHozXJf2KElMin2Jm6FYPnMsyzjXwAzfKjRujtRQNm0f0+9W3xtfS9wPMgvdq2s4/38V
 3OlOV0mkNQGsoza3SnlkKLbE59Z/Ml6JxtzRMKay1AhsAuEgZoi1mO4npcvlsOLWtx3B
 7w9DI2orWzgy+zCYGNgVFCnXtctm57FqutTdqxJDIa6QK6Wy37cd2k45dyKwGfTg6q3u
 vTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627298; x=1761232098;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pz8Uk6XRi7NLPJCE3ivBH5VhQAk+WZCgHBRQPgQKvt4=;
 b=bCWUAhQHDaDa3saRGxMZgb0+e01UnWWhbB0NcbAa7o5y38kp4hldTz/0hrbbYF+lNU
 eKUcqvmDpkWiYUp0ue0gwAPS7aHkSVxO2tJuv23JGG9HE8CSO2e1rgc4NRDn5b2bmNbm
 j5CF+Asw0JlMWaR6a5XMZpuHlKRVYGGOkD6tF+vEtDE4of1qVp/+JwHkJZe7LvA6Fflc
 EO9v5ewtakDImpWZ9wYgEXHKBnVEd0vwWhyuouR1IplX9T5DklHABWyYGCopjpdbajey
 w3j4GHNAJmj+Hi9CbRPvYkpU0cuQNUsU/KC5OMmsexjpROfkiqg6/nB7cb656MLnVaW1
 yXIw==
X-Gm-Message-State: AOJu0Ywyjvv9iTePLXgIkOZZkcbnWENi0Jv7PRoexeYwff3luv1wC9eu
 xiWYpxPF451bcj2LAdr87963zrsdritJimPFvIp2QRAk1mQoS1RfHct/VJkRsyLUilYi45X234x
 rY2GhTB0=
X-Gm-Gg: ASbGncsatY/zWa6HbasEjq1p2X6COVKCP3yxhrW7T1ZENXcrb8uTI27+j+e2ZyLKaE+
 K/r5AWGVVS8dPuT9UxJVeMc/jfVHq+wQ2iEtLqGxq89Sm7JePpF7KQKCcGCfo3zgk2cq1kBpOxM
 /j3eYyqUFSvFP+xyOwFJp4jidCKm/yYZC723eGaGs3GL/1vY1q9WrQhVu7gKOFXbV2MkNdCD7Kk
 0dvAcXMMQgdL+Zcs47qh0isvmuI61bUw8d3h0+zwa+RYlcDYjWskjRYQEumpXl54YO1L1mZtoH6
 o+KUuIpoaoyhapD+tCH/viVWaF1HM5x9K76YViuYoI/tevS3zH9QZNSxPhd2b9YtLsoFeZzmJEE
 O0ydYVUVb9LQgovNRgfqtMx2sd/XkLnan/nqHGbsmTIcTsY/WYICRCulgm/7mZKF6wWnQCCoN2S
 IKZ9Th7xfj+ZOR0pjtldDzVEYoIhWjzPBpngALSbWAdFoqxttr8dnlHw==
X-Google-Smtp-Source: AGHT+IHHSjTDlkZty4YOcNOkHrfnuYxPfC1idfE3C6QAi1RUQm0K1B4dBAMeGCVGKB5EJheuveZfFg==
X-Received: by 2002:a05:600c:8b6d:b0:471:3b5:aeac with SMTP id
 5b1f17b1804b1-4711789eb59mr2643625e9.15.1760627297655; 
 Thu, 16 Oct 2025 08:08:17 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e8207sm34424193f8f.47.2025.10.16.08.08.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 08:08:17 -0700 (PDT)
Message-ID: <f7e2014f-a01a-4767-b523-cf373ef8470f@linaro.org>
Date: Thu, 16 Oct 2025 17:08:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] target: Remove remnant legacy cpu_physical_memory_*()
 calls
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20251002145742.75624-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251002145742.75624-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/10/25 16:57, Philippe Mathieu-Daudé wrote:
> The cpu_physical_memory API is legacy (see commit b7ecba0f6f6):
> 
>    ``cpu_physical_memory_*``
>    ~~~~~~~~~~~~~~~~~~~~~~~~~
> 
>    These are convenience functions which are identical to
>    ``address_space_*`` but operate specifically on the system address space,
>    always pass a ``MEMTXATTRS_UNSPECIFIED`` set of memory attributes and
>    ignore whether the memory transaction succeeded or failed.
>    For new code they are better avoided:
>    ...
> 
> After converting the target/s390x [*], this series convert the
> remaining targets.
> 
> Based-on: <20251001175448.18933-1-philmd@linaro.org>
> 
> [*] https://lore.kernel.org/qemu-devel/20251002091132.65703-1-philmd@linaro.org/
> 
> Philippe Mathieu-Daudé (6):
>    target/i386/monitor: Propagate CPU address space to 'info mem'
>      handlers
>    target/i386/monitor: Replace legacy cpu_physical_memory_read() calls
>    target/riscv/kvm: Replace legacy cpu_physical_memory_read/write()
>      calls
>    target/riscv/monitor: Replace legacy cpu_physical_memory_read() call
>    target/xtensa: Replace legacy cpu_physical_memory_[un]map() calls
>    target/sparc: Reduce inclusions of 'exec/cpu-common.h'

Series queued, thanks.

