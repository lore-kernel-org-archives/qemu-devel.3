Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659D7EDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so5QK-0006wg-BD; Tue, 10 Sep 2024 14:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1so5QJ-0006s4-55
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:17:07 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1so5QH-0000GQ-Fp
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:17:06 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a83562f9be9so107759066b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 11:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725992224; x=1726597024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZNpInoAnaoFw/b6JC0InJhjKIpedK1j64nWnGbkzwe8=;
 b=pMFBBQ2j/F8v11Ly6s+NnqOszW1o9o87RoysG9uVGY5VMJeYyYcvgrfum9KEP9PQvu
 8vkbgnAy2nxP/ZMonM6F3SPRd98AmJv9O2qgGxhyfzPt3r4XZX4XZRBQTwsywn1ny5Gl
 IouuAC3EjVbqbV62KloMXqnYGikgPz9jL3qSV+cwscr8dDabgGG3Q3tg9vD0iWNcBWar
 aAj5jbLvpdg3cYilwpq6QA6hOxCa5/91CCOgQFU3KJ3Q1/9phAz6SrmPZbUtsHHNIhsc
 2ov0ORLmUmHMJ6QgrGnt3sjaExDcCtO5PsCuxKQI+x4j4o4TVdm78LVAySTImvKw1siD
 lDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725992224; x=1726597024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNpInoAnaoFw/b6JC0InJhjKIpedK1j64nWnGbkzwe8=;
 b=FVncLOHKWpdwOxqBknCMV2PSSi6gdtpN78UjnuAh/tHl6JeyOnLXU9bg28XrCaEROr
 Lc1Q7PyeYX3aQOQguyPt7tqZQM1kCprkAPTxDTOdRLeoKVtYJtdgiEJIEs/bOm4obl8m
 /Q7Jbx0cpB9fHbFsy/HZjFluRqrFEqnPcLYOby2Zrit7AnDmRYcWG6S7lL8C1BcAU52y
 PLatHgR9bMoJJeWTAR6wgAiemEfIhC+sZ6O+0RJCMSMSH3DjPUFKwYtyCoHo7L015jxK
 cUtdcxgRctpo0giBqaupsGul61KnSJJ98sRW9IDsHtnILgnINKwK23iYSPgdNtLuoIbj
 yZkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCViuLNPy5kkZXCAq+pvCHOzdIJR5TZ+MU+uyd8kViUOpQRIXaBd8m5ZXcUFTMPPB3OeJ81sE02bpALn@nongnu.org
X-Gm-Message-State: AOJu0YxWnXCf/xQNCBH9GqhgAGZNREokqjklEfOlwEu1fLUP17vuiob0
 nLjdkTzRSEQ6btiWD7EzXTHgXBTwPGJGBaKH8SNqCja8seuptgiYcedpgSbjW1M=
X-Google-Smtp-Source: AGHT+IHVBAS7aoNz98tml5HNyb5wUj8Kc52IBzujPkjYyxzcZdwbjvBFkiRx/JtImA3ubIeoEer34w==
X-Received: by 2002:a17:907:7f25:b0:a7d:e5b1:bf65 with SMTP id
 a640c23a62f3a-a9004818013mr46073066b.21.1725992223484; 
 Tue, 10 Sep 2024 11:17:03 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ced20csm514193866b.172.2024.09.10.11.17.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 11:17:02 -0700 (PDT)
Message-ID: <8f93171c-2964-48dc-b742-72c73e57d917@linaro.org>
Date: Tue, 10 Sep 2024 20:16:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] tests/docker: remove debian-armel-cross
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Beraldo Leal <bleal@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20240910173900.4154726-1-alex.bennee@linaro.org>
 <20240910173900.4154726-2-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240910173900.4154726-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 10/9/24 19:38, Alex Bennée wrote:
> As debian-11 transitions to LTS we are starting to have problems
> building the image. While we could update to a later Debian building a
> 32 bit QEMU without modern floating point is niche host amongst the
> few remaining 32 bit hosts we regularly build for. For now we still
> have armhf-debian-cross-container which is currently built from the
> more recent debian-12.

Indeed I can't remember a armel build failure that wasn't also
happening on the armhf container.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Message-Id: <20240910140733.4007719-2-alex.bennee@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/container-cross.yml              |   6 -
>   .gitlab-ci.d/crossbuilds.yml                  |   7 -
>   .../dockerfiles/debian-armel-cross.docker     | 179 ------------------
>   tests/lcitool/refresh                         |   6 -
>   4 files changed, 198 deletions(-)
>   delete mode 100644 tests/docker/dockerfiles/debian-armel-cross.docker



