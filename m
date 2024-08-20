Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089BDC531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 10:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgLy7-0007RR-1z; Tue, 20 Aug 2024 06:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgLy4-0007QH-OT
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 06:20:00 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgLy2-0002ej-OI
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 06:20:00 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-530e22878cfso5566180e87.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 03:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724149196; x=1724753996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gD2sMexriUoPGW+vxWU9COKb8xpZ3ZrhJ2Hu89h/Xm4=;
 b=yHyV5dKuQdQA4dwNLdbbGM4nocoNhMOmiPSiPh5zYOy1inyzjSU71IoIYZNgQowZFO
 TfhllIqjDklWhvqjSYGHpT658bjfMHs0MXKT1T2EKyW4smpCycGYsxl2qRzq2I7qoiwJ
 TXuM/7aE48C20EWaS3cSdREwnGlsb1iaMoFQXgY/nTC7Oe/tSxe9VdbMA0GahSr0nOaR
 o4eWvfDbPZ3BtDulqFO+L3dqKup0UdaMDphc58d85odQJV/6BVia+1XDNT15Nboh2LWC
 PM58K6tUAdsiZiAjMHh8menrzTCn7jTp26WuQ6L+sppPfuU6ZmMy4METdBeTggMU2kSg
 uDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724149196; x=1724753996;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gD2sMexriUoPGW+vxWU9COKb8xpZ3ZrhJ2Hu89h/Xm4=;
 b=H2Dxlygf6TnFNRhJo5bjmsqv1Pk4k9hnijWsAM/fruUgifjmd9Ov1ExuJd3vr9l3Ea
 QxgLrPHhOzFyPVi3+jC5f6VlxGC9UaVi1LDcQ46ew2mXgX1XC6oGp2mCbaZGVvQs6ebX
 fVyy4LXGMv7Loy46lZjEiSQuG1EUdVXNR1IosHZqAbArN/0qRwvgCRjAi5xR8i6iZBkU
 WGdF+CzzSxxOcSoaPRip+PAztt770jR7OUv8syBkiLOHmEEiLEDWvqLS/uvZ0gMSlk04
 mkpknE3TD1PU8oMaADKd8rU9VCMMAjodXdLmkFNRp+WDUkRsOH0wYjRHl+JxI5+e/q+s
 1ptA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8kUk1pwfY3f4qfuP+/SjFoWjEGb4R+XzRFodNsycpOEvlP/Kf0wYZRFvqOZAIdIOj+uQP/RzmD2stP/x36WbA1Dknb88=
X-Gm-Message-State: AOJu0Yw4Xo5Jq162kWOAzNvVPuEH9mQqhbyktAq7AYtqPDZRanu00CX8
 yL2O1o56QRXVMJ17ZZDgRZWzQCBd89QvL2nzNlGn9glTyJh8G7IingcpFjCjPRs=
X-Google-Smtp-Source: AGHT+IERHTtjOQP/mu2pDx3tugmNAKohxRO35tqOHH73DK0nlGMxIG787zzHQHHa454IqM6EsbQLRA==
X-Received: by 2002:a05:6512:2391:b0:52c:df51:20bc with SMTP id
 2adb3069b0e04-5331c696975mr7668795e87.16.1724149195339; 
 Tue, 20 Aug 2024 03:19:55 -0700 (PDT)
Received: from [192.168.223.175] (84.21.205.77.rev.sfr.net. [77.205.21.84])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebc080277sm6603575a12.80.2024.08.20.03.19.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 03:19:54 -0700 (PDT)
Message-ID: <a7b2d31a-6318-43dd-abbd-a8d8c867d4f3@linaro.org>
Date: Tue, 20 Aug 2024 12:19:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] python/qapi: correct re.Match type hints for 3.13
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240820002318.1380276-1-jsnow@redhat.com>
 <20240820002318.1380276-2-jsnow@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240820002318.1380276-2-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

On 20/8/24 02:23, John Snow wrote:
> typing.Match was removed in Python 3.13, so we need to use re.Match
> instead. However, Python 3.8 doesn't support using re.Match as a type
> hint directly, so we need a conditional for now.
> 
> The import is written oddly so that "Match" is explicitly re-exported
> for re-use by other modules. mypy will complain otherwise.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   scripts/qapi/common.py | 10 +++++++++-
>   scripts/qapi/parser.py |  3 +--
>   2 files changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


