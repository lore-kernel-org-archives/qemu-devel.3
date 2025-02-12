Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B8CC021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 13:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiCQ0-00079a-7Q; Wed, 12 Feb 2025 08:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tiCPt-000762-OA
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:04:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tiCPs-0007vS-2R
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 08:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739365475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2ZFDgS/m6BkeZPliAwUkjnEBmPfpb7tagttqpH98zqk=;
 b=hoknb0AaoLY0DKYHaBWA6QM+GVXIfAQg6XQQ288sF7ewlEaOBjFUtSrOqacg+cYwpn9c6d
 F0H+2RtFUuo/15OWMA3RNUbucd6i5OU6bSwtX2Op//CWQbg8w+APVceG4Ox0/u1Zlz0VUq
 aoEtOjIakDIl2uktW9jOd7Y6RzQ1zq8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-WMicKxcHPVe7Nq9sFndBzg-1; Wed, 12 Feb 2025 08:04:34 -0500
X-MC-Unique: WMicKxcHPVe7Nq9sFndBzg-1
X-Mimecast-MFC-AGG-ID: WMicKxcHPVe7Nq9sFndBzg_1739365473
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38de1668f18so1526547f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 05:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739365473; x=1739970273;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ZFDgS/m6BkeZPliAwUkjnEBmPfpb7tagttqpH98zqk=;
 b=X3rPonZOKa8b27D/BDkfsNsaPHCYCOGargH03dJeq9JJjGZ4s9XsumhoLmhN4BL4JW
 jMc2xkaB7DdNymnA8PiNRgST9/XutEjylRwLUWnolgdq71unzP6Ub0zvqB1WcM4TPrhJ
 5CGTuNsDw4LdcGg9tx6d+5asPT02HIo9MnGnJcNHcgjKPlKenKsSHq9yBcqeNsendGkn
 wHXgcFneALYk19LJGBCHQbZWK0fQaS51IPwbLHJDz10GhXLUZz4mcIBNFJ8nfOX+dIye
 Pu4qB5h0Vgm1qidtRkW092e0t8umxF4uR2BwFB5xJo3tz4FrMnIqWt1fC4FDgMWsxFXV
 kv0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlQbNJbpr5MFQ7jFc5NNZ2jafjw//EKQDBNnyMPO63cJIChIOo7unY92uHBeq4KXuWVi2oxhBKwFvA@nongnu.org
X-Gm-Message-State: AOJu0Yx8DqrRStFNhVRFFuI0HQO5JSp/OAMYXd8Sfh6t/zPt1kgAGsc6
 loQU0Le5YXxWDrqIbqixRr4E6Kx3dpYVuUPzqfJ4vUdN37PdBC2EEKSqK5VdDrmXyCzwn1QvrL1
 XXf/8EC9WHOyOI0rbbVcdiS3zvZaYNEVJR+gL4sLxgjGd+pgpkh/W
X-Gm-Gg: ASbGncvbSuR8ABYLnbGOBeyNM3MawCuVDunp0Co+kXKgCda/vdFLskpdW4bSWZAvI08
 KG33nPWaD1b4abDsP81hVfI23712w2uFowIqHPbLtbruIYhCcwYQK5k8bdiELutn4KvTtUliPEm
 HH1Wzicim6qmUxJphgrsmFDO0QduiPe4XnlMpcCXxviStsBvbhC1UYr9hY0fQOCQ+yACtyfG6Ob
 qoSHIWU2jCYwOd0w6xOQBN/W50Aekd06FA6ksvsyUwB0Y3zKtLw/ooAzTrXgCVxxV7gkZv8GQmn
 24HIDH/HqzOwIdy59+Ay2/usFxnltvnLJA==
X-Received: by 2002:a05:6000:4025:b0:38d:e1b1:be9f with SMTP id
 ffacd0b85a97d-38dea256927mr2102748f8f.4.1739365472686; 
 Wed, 12 Feb 2025 05:04:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1Eu/CSkUKVSuHhiX4HnO+oMxf33QU1dJH2e0yUchVSgYR6kXpeLW5EeRkgbJAC00Qz75hGg==
X-Received: by 2002:a05:6000:4025:b0:38d:e1b1:be9f with SMTP id
 ffacd0b85a97d-38dea256927mr2102724f8f.4.1739365472315; 
 Wed, 12 Feb 2025 05:04:32 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-37.web.vodafone.de. [109.42.48.37])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc7711bbbsm14908076f8f.47.2025.02.12.05.04.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 05:04:31 -0800 (PST)
Message-ID: <ba9f09d1-88fd-42d4-acb2-5e531762371c@redhat.com>
Date: Wed, 12 Feb 2025 14:04:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/10] hw/timer/xilinx_timer: Make device endianness
 configurable
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250212123659.52764-1-philmd@linaro.org>
 <20250212123659.52764-5-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250212123659.52764-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/02/2025 13.36, Philippe Mathieu-Daudé wrote:
> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
> of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
> Add the "little-endian" property to select the device
> endianness, defaulting to little endian.
> Set the proper endianness for each machine using the device.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/microblaze/petalogix_ml605_mmu.c      |  1 +
>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
>   hw/ppc/virtex_ml507.c                    |  1 +
>   hw/riscv/microblaze-v-generic.c          |  2 ++
>   hw/timer/xilinx_timer.c                  | 43 +++++++++++++++++-------
>   5 files changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
> index 55398cc67d1..490640e9428 100644
> --- a/hw/microblaze/petalogix_ml605_mmu.c
> +++ b/hw/microblaze/petalogix_ml605_mmu.c
> @@ -127,6 +127,7 @@ petalogix_ml605_init(MachineState *machine)
>   
>       /* 2 timers at irq 2 @ 100 Mhz.  */
>       dev = qdev_new("xlnx.xps-timer");
> +    qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
>       qdev_prop_set_uint32(dev, "one-timer-only", 0);
>       qdev_prop_set_uint32(dev, "clock-frequency", 100 * 1000000);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);

Same question as in the second patch: Do we still need to take care of 
TARGET_BIG_ENDIAN here?

Anyway,
Reviewed-by: Thomas Huth <thuth@redhat.com>


