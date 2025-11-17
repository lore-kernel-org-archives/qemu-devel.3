Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF0BCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL2fu-0007W3-Ol; Mon, 17 Nov 2025 12:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL2f6-0007Gg-Dp
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:05:17 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL2f0-0004pd-RZ
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:05:04 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-475ca9237c2so25293295e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 09:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763399100; x=1764003900; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HE2fmlyORJFUjXBDWXDExn8hzuILt7lnHbNQZ4qzuks=;
 b=N/9UUhtLS/A7gXyTeFCTh9MRAybN8kmBSK64KI0sDOi9EB3/JKQTbALj84okcPH0C+
 5GJJx6IlOgMV0mi8XEoZ57D80s+M/Xa9Lc9J9sJUIevmoEu/6muz2rFXCvjEk6OUbkgO
 bup3m7VFhLUgV/3ECmK8NqQjTRCneSMswDurhcmLZxjLT4iic0DDhBYCtMDf02MGG3YW
 n/OeqjHCoOUIP95W0o6PxqMb9d96TZh98OTpB14J+EZTJ32dXM3vLrYX6lfPk+2yvhKU
 q4JR84NERqkFx+soV5xnayHlVmHv6tGHe0lcCpYe20uqHxQdcI+Hy9ptDHjhP9iOEzGY
 UHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763399100; x=1764003900;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HE2fmlyORJFUjXBDWXDExn8hzuILt7lnHbNQZ4qzuks=;
 b=JMjrC8P5pcAoeKogi6hQ72owchYIdC8arblpyDMbRG0La6U9kY3l5nf9xnpjdjbuIC
 xT90LjOKH/SaF9GDhDR6Uuj7s7XYUv27i+EzHbFui1rzgWpx9XQrNl0zL9L+9lsgsQNX
 gwlpLAXdiAzC+AH8lWCMqTV76E2AeSMPDn6tsppmM+4UAPyFvgWKe38SGUhWlvi8zH4q
 jPORA9d1qjUFM3QB87POibrOWF25OsatwXkvtFswEZ9tbeHlak3D0LFfBV5H6zdQqm0d
 MLoOZaKXX/KxZAjcNgop+sZKHxA4SR7yfRfAajhZ0Mnt/WJrj4VjQ03SVL3neB8DxZtL
 Fq9Q==
X-Gm-Message-State: AOJu0YzzcrNDQKmz49vbfi/c1OnAqs2YUrSvFnR+qcT2pyZ+XXP4daw/
 uVKQORlOZIhGG/FYYazyDdXgX3GKryQOgmsse62B2+F4ZEJ96FP0bwOcvQMAVIA3A6s=
X-Gm-Gg: ASbGnctnK/zq20Nz4vPzCtiDIuJ+rqxdXf//cZ2IcSxCQFv6/8O5IHI8j68fxHNmZ9Z
 iZU3rHST9tFlCROVc6+rel3Db6mpWJIUhWL7gyo4o45c5Paq2b2puSeMrACGIPyJUp0G37TOEb7
 mSGeqt6wVbcHTh2ZU94gEkOyLDEE1bw+YIwhG7WrUhpuV8Fy1tG3bxeNYYe9Ac+3A7Iw/UHtLAc
 0Ao7Fnu33sPHEvQ/QJnL9Imcxuw8595T8iDLz3eEovxJIet4FFFC2asQv4qrftPWM0bmSJK5Og/
 i51U+lDNYnsNqo5w4LqKSnbg6rhdKj13oVGuHJy8KjPhTHPlvW7cxHDWx7kGjaD9kmPwFFOXYlE
 EnKXxqL/yyx4Kb93GrTRjVX+/uq751iqy56M43m7wldG9pBQ30Fr+dMJqFSwMcFshfJ0qMls6vK
 /hZOyqgVVVMzPrcH3biLtsskOOAwdzlCy1MZCKNnSAb5lFzki9/bYUnQ==
X-Google-Smtp-Source: AGHT+IH0EZ8HCV7GbhiyCN/x53Sxj3XUTx+ngK88SGVXYGsuOYnqgMguELmgrquf5p5afIpnniyxPg==
X-Received: by 2002:a05:600c:253:b0:477:94e3:8a96 with SMTP id
 5b1f17b1804b1-47794e38b9amr60505025e9.20.1763399099831; 
 Mon, 17 Nov 2025 09:04:59 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779f45776csm40738495e9.9.2025.11.17.09.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 09:04:59 -0800 (PST)
Message-ID: <5f9c6578-793c-4284-a7da-9181f06ba6a0@linaro.org>
Date: Mon, 17 Nov 2025 18:04:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2 0/2] tcg: Remove support for 32-bit arm hosts
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251117154154.79090-1-philmd@linaro.org>
 <CAFEAcA-e6fC6yaZP1WSV5qg6-LYYrSDFJik4yLPUPMUDjxQ39Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-e6fC6yaZP1WSV5qg6-LYYrSDFJik4yLPUPMUDjxQ39Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 17/11/25 16:59, Peter Maydell wrote:
> On Mon, 17 Nov 2025 at 15:42, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> 32-bit hosts are deprecated since QEMU v10.0.0; we already
>> removed support for MIPS and PPC hosts. Time for ARM removal.
>>
>> Based-on: <20251117140420.62193-1-philmd@linaro.org>
>>            "roms: Do not try to build EDK2 for 32-bit ARM on Fedora"
>> Based-on: <20251117153756.78830-1-philmd@linaro.org>
>>            "docs: Mention 32-bit PPC host as removed"
>>
>> Philippe Mathieu-Daudé (2):
>>    gitlab: Stop cross-testing for 32-bit ARM hosts
>>    buildsys: Remove support for 32-bit ARM hosts
> 
> I would prefer us not to drop a deprecated feature after
> feature-freeze, please. This seems like it can wait for 11.0.

Sure no problem on my side (per Daniel comment on IRC,
I thought this was a due task).

Regards,

Phil.

