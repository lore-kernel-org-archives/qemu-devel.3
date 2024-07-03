Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689A4C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvUa-0008S0-6S; Wed, 03 Jul 2024 04:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvUZ-0008QG-3Y
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:37:31 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvUX-0008Oy-I3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:37:30 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ee794ec046so13768741fa.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719995848; x=1720600648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lcQ4zNFVAuzihPprr5Iitke8LLP03xuO7Km9yEiceW0=;
 b=htgbQQfOGrPCaxfGCUKDiEwm+f+lhIbgxvwleFG8QUDZVv5Uw2NvuJEjYAA0fkQVMb
 VY0AmGN+fykhg94blTFB5XN6Oci6EsxBNyTlGeN8paEs/7Zj1IXTAnfurQyvuflJ8UEq
 VkpvpbnOpHnqVHcHgzPt7+4JJYJuSQrGq4hK2YqoF68tQuL/GH7GnrKM/wGc6VaYcdd7
 CaM9J4KTZmoSoONdcuc5NBZSpLzMTStg2fB0l0Q8nn4bNsdqO5IPFBUVB5ksJyOpR0kY
 E0wu5u3inc/baZtCcJKSNda8WrWaLqYAhJ2XbF6y9b0/T9yOejC4X6hmWZ4+lp/aQUQK
 zZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719995848; x=1720600648;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lcQ4zNFVAuzihPprr5Iitke8LLP03xuO7Km9yEiceW0=;
 b=A+s/L+zXQk84F5sRE0tFsqVN+l+41+ywknxt7pXsbsWoEm6zKt1XWOuTrFuPIrzCwJ
 EDaJidaL982prEwqAHVTlFfupxcF8+86cnTQK8j1NyyU5p5mSIf4KUPrWe02laSZHvq9
 U/e7bzTeSHoWM6yTRer30Ul/DekRu9HwWztu5/SrVwKsRTEKsgtXEHXfIFPNOimm7XV5
 m5rz1TUboNVdd1Z/8rhE1fLQ2op+b8BpGvv8VGvv13Dy6Z7yrKJHc3F9yIcZAgJ5gGS1
 v0N6j71Da6GhboEyQFyMS1A3HrA8hZG3+4LuUAg6h/YQgyKacdoGzPmAWyJyZPhEJ6k+
 bTlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFNk0v99KYy3Iu4RTuIoMknGCOCW2N6lCLXcT0ft/NBUsiPdKM+0DWiAGl1wYbyAlHqajEwW6kilEcWrcg0moM1ZFMd2g=
X-Gm-Message-State: AOJu0YzClRQ4xwhku1F3wiD1pOd2C+e8arWNI2AJ7y9jk6gF69NcTiGq
 IbQxHdLtgFjjf9eGwwRluKwUVhnYy7G2gPs/4trWvI0ALb8Qc0Vc5PJeaiKWzpo=
X-Google-Smtp-Source: AGHT+IHqAojHpjyXGGf8e5tWpOetQsOA0Hr67A7kfUU81jpDi/hrblxayaM5VlZ74I+ZvUDc/VTwlQ==
X-Received: by 2002:a05:651c:1549:b0:2ec:5685:f06b with SMTP id
 38308e7fff4ca-2ee5e3c334emr84459081fa.27.1719995847816; 
 Wed, 03 Jul 2024 01:37:27 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678a23b349sm3445273f8f.36.2024.07.03.01.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:37:27 -0700 (PDT)
Message-ID: <3b740f2d-8fe6-444f-ab24-0f0f035448a7@linaro.org>
Date: Wed, 3 Jul 2024 10:37:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/22] qga: conditionalize schema for commands
 requiring libudev
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-10-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613154406.1365469-10-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

On 13/6/24 17:43, Daniel P. Berrangé wrote:
> Rather than creating stubs for every command that just return
> QERR_UNSUPPORTED, use 'if' conditions in the schema to fully
> exclude generation of the filesystem trimming commands on POSIX
> platforms lacking required APIs.
> 
> The command will be rejected at QMP dispatch time instead,
> avoiding reimplementing rejection by blocking the stub commands.
> This changes the error message for affected commands from
> 
>      {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}
> 
> to
> 
>      {"class": "CommandNotFound", "desc": "The command FOO has not been found"}
> 
> This has the additional benefit that the QGA protocol reference
> now documents what conditions enable use of the command.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qga/commands-linux.c | 8 --------
>   qga/qapi-schema.json | 8 ++++----
>   2 files changed, 4 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


