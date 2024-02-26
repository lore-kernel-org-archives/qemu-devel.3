Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3946C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVsB-0001EP-Cy; Mon, 26 Feb 2024 02:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reVs8-0001EB-Ct
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:58:00 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reVs5-0008Qc-Ve
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:57:59 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33d066f8239so2027239f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 23:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708934276; x=1709539076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nKGEnvhBIprzbWqnaEP2z0IqLjreqBWMqYbiIdD+Rgc=;
 b=B50m9g3mE3v8OXGBqREgR524JjNhiGHkq1EK8mH2idjPrJbJPSUd8IsK8tpxFXuXoU
 iHpQoZf51sE5vrbcldR3nqmP38n221qmC9Vjg+4xy2zsEnqMeW4Ow7lS3pZwaJTSWNFz
 KJ1YMXMmmp7YtHtJEZNWqr6UTnlG54gqIua8lDJh5xjl+hhhr1txs8kZxXrx4LiyO3Qh
 6ttIug3kB3+w1pdhfsRBmtAYmKfasZ5AsC/p+wYI8mP6Ga21uxZJjqPQ8sApBiG59s+y
 RaXOQ3q5B81dLRQHs8gKCZyjtEIfPGlH17lfsqGg8ithSDYdfJGpTOlm4h/gTL+43QGz
 PzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708934276; x=1709539076;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nKGEnvhBIprzbWqnaEP2z0IqLjreqBWMqYbiIdD+Rgc=;
 b=Yk0tvwDDO8C5rgzlNJW7d9ZRPsLWpIZzwDrVJi2YLLaKq9Nh3vRjIPwXjo31K6TQzb
 a0van1FVYdg5eu6dpVLBNIGrODtR4zwqEZEmijHT2QsHkVUqjwE5sRYL94l+DY4iGgCt
 FopFjB5gbU8rbN5dtHfDcfXCNwojv2XmaS5XF3mgEWBHawkmDYmNL3oM1sP9n5vbuD7c
 TfgZ+5htfVasouXSDNzrpWtO7cN9j0KB7HtJoQe7uUVK0vD/9GaqQAaP2yemyiKVjNod
 fj/0oUe57ex2scOqMw2aSGnYjpuCt9pIvAKn8LL/4N5qxLqCQCbQS0r69FUqzGBDJ5FX
 o7ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvLj3zg2KZx2qzHl2oiGCG5BbWPYFRXJ4vAytLSKXzpxf0PBLVBRCdXG/3WDUWmRT4H1wFSVsD51jlpUyF2GrIytHB0Uk=
X-Gm-Message-State: AOJu0Yzjor9AOO0yHsGNxa2JBla1jNyWYDlCKztIT+BNi4P2yhU0oTUg
 sa4xLzFpPwiJBUVovaRKhSPf9OS8/4hkojap+V26Ahz/d87hQI3ZMt6A7k4ycy0=
X-Google-Smtp-Source: AGHT+IFoRyddsH4HF7HSTFjfhwVyrtvvzkZ4R3rygVRBQGI5zMavUwAY+IIB7pkL3HW5XgDVZcHuJg==
X-Received: by 2002:a5d:6142:0:b0:33d:38ca:1b51 with SMTP id
 y2-20020a5d6142000000b0033d38ca1b51mr3964695wrt.29.1708934276305; 
 Sun, 25 Feb 2024 23:57:56 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 ay25-20020a5d6f19000000b0033da430f286sm7548309wrb.69.2024.02.25.23.57.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 23:57:55 -0800 (PST)
Message-ID: <67303b68-ad32-4054-803d-619453aaa02b@linaro.org>
Date: Mon, 26 Feb 2024 08:57:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] usb cleanups: remove usb_bus_find(), extract
 sysbus-ohci to a separate file
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu
References: <20240223124406.234509-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240223124406.234509-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 23/2/24 13:43, Paolo Bonzini wrote:

> Paolo Bonzini (10):
>    acpi, qom: move object_resolve_type_unambiguous to core QOM
>    ppc: sam460ex: do not use usb_bus_find()
>    sh4: r2d: do not use usb_bus_find()
>    mips/loongson3_virt: do not require CONFIG_USB
>    hppa: do not require CONFIG_USB
>    mac_newworld: do not require CONFIG_USB
>    pseries: do not require CONFIG_USB
>    usb: remove usb_bus_find
>    usb: extract sysbus-ohci to a separate file
>    usb: remove duplicate file in system_ss

Thanks, queued addressing Thomas & Markus comments.

