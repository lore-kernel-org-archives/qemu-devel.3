Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC6CCAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyBoG-0003TT-4S; Mon, 15 Sep 2025 12:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyBoD-0003SP-1N
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:12:05 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyBnw-00039E-0T
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:12:02 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso3279444f8f.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 09:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757952691; x=1758557491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l96gdQrF8pYYDiqdxH1DB/7ba2n2Eq4Mj2fHqoGJ+Dw=;
 b=vOoQMTh1GF76V68ILhnD5+OTm5m+C3Y0K8d6pXm5p8V7l1ktozMLnzFVoGwJiZNJZH
 4cgLe9CIy4/MZZOrClIqfWL3p+qY++mMIBwK8UN+UkD7OtLMvE0VZQDUmq5VyBmvVM6h
 2hejifkvdHo4OoOUDqMkR2r8Wkt/e/OYT5tmMNlezSzVUJXFBSUhZRWZzoE1FjUC1upT
 XtpSzMA7qIGlUqGbTYoW+JG4oHiK5xaYS/dPQsLrl6wrrrYaM/YCn9x72TrswXWDGa8p
 9FsBIgPjAACmZVOQ3c9rVBLWf+VdavB71bRWZfjlJngkTBydB83+ruv/zoslAGgH80TL
 ou8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757952691; x=1758557491;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l96gdQrF8pYYDiqdxH1DB/7ba2n2Eq4Mj2fHqoGJ+Dw=;
 b=urrjilTVG2okXEnYxfiEPoernLNyl5XwUd15Aa975QDWOOhizyQAGZ4SErSh6AxGEk
 02wpaBq7fYrPLdWfKTXKMzkzEH5X7hlR90msYN988nkHBM8pQG0hM7l4w7Z01BHmayTB
 eznBNSgLQTHIkuywdF+t8vH67cF2tizu62pI2yZzaMP6tA5b7xyZu+NQDQCJ2ft05fja
 IV6vCMwmil4BdA3iHuRFCNKz9jxpkQ3gtRWemb+A+TcD5Rdc1Du9aHhSnMFklsGzUJWi
 hmcrrfH9PpjVHIy9gxrkyuOuTY40/WSPTOw+LDM0XULTdOcUbgVjjKD7WsmVejIivKkJ
 Ddnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdYp9C+Y8pHBoCt4izIcc7lSe8BEz3jzIFXNoCW0BBGX4XeRLaTHuSa2o/rjxx53LdSReKLHuADc6y@nongnu.org
X-Gm-Message-State: AOJu0YyYxInc3vew3J1h7Ndr1GLQkAU2JHUBNxHleEGR8BEmxMmgBPyB
 XPFgnvjGPoaZSyx/+YsNxPJ+fSSLPqvUOGbckiNAi6Lkk0sNa/18dpIFgB4odJiPZ5s=
X-Gm-Gg: ASbGncsEdMJsSagGzpF+rsVw/C+56UziM1fzuF1qeazYzGPiKeJLc5d1GIOn+fP5HoK
 m075CbQ/a7GT4vlsiyEATNS2vC6OdU7xSYqeM0Ci2MjWhiWL+6BMOTY+Bd9LuYiagt/SSxOq/xb
 xkL4ZaCxqXPHY6NLPtKglBGPELJVzMRPDj8se/74vAlQu4ZctN/hDhpI8W7VoZOL2R13SSUvqYP
 wge7LiqXwATe+AhzJ/274Vehh30JwW2J/wLdPeZ7TNA5z2yDfeaqaKlit3X8yQgtXbSgLoxC8fE
 QPcochRZmx3Y6XUILBY+wPbinE7iAqCeEYQB+XMHEUGs5DcbZI5/kAM7jEx5xkwzfXOP6taTZ8H
 /p4AKOPmW7tlFFKNq6P/nWSs5yuLDLRZbww==
X-Google-Smtp-Source: AGHT+IGmRHLXJx9+4JldA2xffnm8w4mgqEugIEG2OBZDDi9L1UTG4i5xzDHV+TLyTGyO4QxtPgGBJw==
X-Received: by 2002:a5d:5d0f:0:b0:3cd:5405:16e7 with SMTP id
 ffacd0b85a97d-3e765a2eed8mr12498230f8f.29.1757952691391; 
 Mon, 15 Sep 2025 09:11:31 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7d369ea3bsm12922872f8f.0.2025.09.15.09.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 09:11:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A5F85F867;
 Mon, 15 Sep 2025 17:11:29 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  qemu-devel@nongnu.org,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [RFC PATCH 1/2] tests/functional: Provide GDB to the functional
 tests
In-Reply-To: <20250915124207.42053-2-thuth@redhat.com> (Thomas Huth's message
 of "Mon, 15 Sep 2025 14:42:06 +0200")
References: <20250915124207.42053-1-thuth@redhat.com>
 <20250915124207.42053-2-thuth@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 17:11:29 +0100
Message-ID: <87bjnbpufi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> From: Gustavo Romero <gustavo.romero@linaro.org>
>
> The probe of gdb is done in 'configure' and the full path is passed
> to meson.build via the -Dgdb=3Doption.
>
> meson then can pass the location of gdb to the test via an environment
> variable.
>
> This patch is based on an earlier patch ("Support tests that require a
> runner") by Gustavo Romero.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
<snip>
>      foreach test : target_tests
>        testname =3D '@0@-@1@'.format(target_base, test)
>        if fs.exists('generic' / 'test_' + test + '.py')
> @@ -121,6 +127,7 @@ foreach speed : ['quick', 'thorough']
>             priority: time_out,
>             suite: suites)
>      endforeach
> +

spare newline?

>    endforeach
>  endforeach

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

