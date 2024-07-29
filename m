Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6066FC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPbs-0002PI-CZ; Mon, 29 Jul 2024 08:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYPbp-0002Fk-LN
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:36:13 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYPbj-0002CP-8J
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:36:13 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f025b94e07so44225821fa.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 05:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722256565; x=1722861365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r0Rx8ux2I2T0MDGdLpBR4i+gQPQRXAUPKUVcKAgDUuc=;
 b=b/lqTEaEiF+S1JXToH6vumbwpJP+zmqmXyF77BUwVZLet4NJ9M/xr0EqgBO4plqkdC
 mL+vD3VFk0APcSeFFk7fiYy35yG8GdWpiiw9ktsq8+scUOKQI81BP+hBWE/suFGordN+
 vQ2WziTe3FqwD7PjwGWed5Qtj/VHLfp4D4Eh30jPwtlf8G+72UwR4hZ30j3gFbDETCvq
 Fn8J8/8L1jMDJDqM/tUWRpidvBvKNGbruOjFQgFUnkYT4kkyHD1Dfwr+wozic0lmlHsm
 PvBbH7oIQuEiEh0e3mnohsABLPNS1AEZUaHHEDY5uJ6e7Kj3KdahvqG1JTf9ScTZCCPG
 fZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722256565; x=1722861365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r0Rx8ux2I2T0MDGdLpBR4i+gQPQRXAUPKUVcKAgDUuc=;
 b=McwkXn5JtDYEnmMzaXI04jKiuMYFCeJpKyjQyZG+xlbHlFHMlmVD38pvyCg6sIwXtd
 CtMn7+VdFQoMIlbwgeAjOcNaJ5+MqjWXaUN3RbRjcGzeS3+6F+h1Knc3G6EVnVkRrpkz
 DDLVWCEHNvYvaopL3kcK0dO94INLk2k+TWQCvWztJ0d8o3iC7zSDIEh1eyHN4LTbN8SB
 tiLfNTKuKy91avdv3J1XtwqWBvsUdkl+jzZCmdA4zHpteK5xIlMHpdqrHhGRVdwHqVJS
 IAEVTntQ4YId1bYWPMtdYbW//n/0y/Fv14Gy0KHE4GGHHoDcvuReR7ftxdKHrF83gyCO
 dHaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtD8MVWnnvFkaqqNXebciUIcP73jX0RLI5y7Xoq8F0wXm9WAX6+uA0MGKHCExz6OfTMtlkqHPx0gMZMm6dOFUqZTDO2P4=
X-Gm-Message-State: AOJu0YxvmCjPjGBBkyjHXyP+A94d0s8mLpAwEiqtqBr9OiP32SssgOcR
 GM/fERWDROvw2VX+3MSn1O0Zl5nEYGKlknPIQvmuavqFzNuu0GNUP9JkgzAl4rU=
X-Google-Smtp-Source: AGHT+IEvYcpnZEO+kxSOmrCPB0hUvQSnyaP/8wiNiA14oDkpbi0X2mNXzBho/xjrJ2eHV4KoggMxsw==
X-Received: by 2002:a05:651c:201:b0:2ef:2b38:8796 with SMTP id
 38308e7fff4ca-2f12ee23df3mr57777831fa.32.1722256565192; 
 Mon, 29 Jul 2024 05:36:05 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428057a6283sm176363875e9.32.2024.07.29.05.36.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 05:36:04 -0700 (PDT)
Message-ID: <91936071-fe2c-442a-934d-202076cb0d5a@linaro.org>
Date: Mon, 29 Jul 2024 14:36:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/23] tests/functional: Prepare the meson build system
 for the functional tests
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <20240724175248.1389201-5-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240724175248.1389201-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 24/7/24 19:52, Thomas Huth wrote:
> Provide a meson.build file for the upcoming python-based functional
> tests, and add some wrapper glue targets to the tests/Makefile.include
> file. We are going to use two "speed" modes for the functional tests:
> The "quick" tests can be run at any time (i.e. also during "make check"),
> while the "thorough" tests should only be run when running a
> "make check-functional" test run (since these tests might download
> additional assets from the internet).
> 
> The changes to the meson.build files are partly based on an earlier
> patch by Ani Sinha.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/Makefile.include       | 11 ++++++
>   tests/functional/meson.build | 66 ++++++++++++++++++++++++++++++++++++
>   tests/meson.build            |  1 +
>   3 files changed, 78 insertions(+)
>   create mode 100644 tests/functional/meson.build

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


