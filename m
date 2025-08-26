Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6668CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 13:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqu1a-0000iK-N7; Tue, 26 Aug 2025 09:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uqu1X-0000i4-KB
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 09:47:43 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uqu1N-0004Dk-4q
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 09:47:43 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45b4a25ccceso33358505e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756216044; x=1756820844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n4BduerXLbw54RivkHUFSaWTdvv6sqPDGxNfwa6hgf4=;
 b=gODsMYSbyYIOIWPJc2mvbO7tXzOUV3FbEMIASI+uR3wkYqw/W8flRCshkvKP54dxS9
 b5C2og/6n99K5KSvsA208eMS4aAuWBKVB3mhXvRGGvhbE8FpwjSlfUv26DhnOGBwKhRH
 zOxxhrblLCf3lhgP+CZfFHBoacX2XdtxgLpMFQJClf/346vnc7LhSW6RGo+dI6BoFIIT
 vzBVYKwKPTUv8JLK+od8c9UtH7NHxsymAWIQ1wKJwGVtF6QQL2TaCPrsDqcI/Y3L9dAV
 CqvPm8+1hiTqIOeTJ34yTa851smTfw2Xzd/y2GRK5ZhEf7LMbPjNS7a3yxYml90T/jBa
 ZghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756216044; x=1756820844;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n4BduerXLbw54RivkHUFSaWTdvv6sqPDGxNfwa6hgf4=;
 b=ad8y69V+gZJHQOKxlo5qTuVcBo5/steBRK4Ca2lZodoilIbpCjORcD+gvxxm8kUawl
 9esNlFTVulrHhjHG3rE93qa2PB1qnGb/h6UJrraBj93S1JGiQ2vmmkm6QUrR43xErER/
 AGPkUODy+k0RVI2GAmiWDuZPtqxSdvQaPCIQkEPhTzvTZAI/CzaNvrWpwp3LHsGg8NSv
 AibUGVExwvDL1gszyLnmd5Rva3KFUvG5zJ4hkBhV4pqbxmVESyoGkPbBzX+FjxYOGkBz
 vy98nrHwLxSUYox3F2udvKcoUSqG5LOAkENj1yfxas5debqXf+bo4JcMKLLeFsb5Mmwf
 u2cw==
X-Gm-Message-State: AOJu0YwEXJMHg1Fl0gGCPHS62Uv8QW8+dNMwVwQz88pdK+K/M3VuMfOJ
 ZZriZPkNEQR8hXF/zL5ofAGMTPT2sj+x8OYWwXS0AVAiRSFqHI7UJQ+KRgxzpugSQgI=
X-Gm-Gg: ASbGncsYqdtKMJE6cnw4AJ3ItBv3yQDPd37LQPn4utqTQQiMaastqdLykzXkwdPYc1Y
 t/+KI7Cej+SKY+MVpKeG+NxtLCALk9haZBj5OTE58gdD61vxnex3c1T+yGHJsuLFHTFwPDmW5ij
 oSAVjfeVtGMGHFR/o+e22qM10NrWV6svPbyzmtztn3h4C0ihAjpdpeFqca9x0xFAS1kMNzxN94a
 R/BmxdjvHarunUi3DrMY8kaIUq8Xo6nStiTbfNtQKd6ughn5vntGH31F0IsTCO4Ls6OLQEz03Z7
 v4Bnf6vLO5vGB8hhdmVzsvvmAT8SqcpkiRJfUDDr+svsB1TwEjLmdXTjlekwWcga/WKkPYsdl/i
 hqWbltHC+ry4R6nYV9Z9jmZWRgNVdHdJDsw==
X-Google-Smtp-Source: AGHT+IF9RYj5s+z/fuLWLRlZnIPYEuaYkiwNvG5ZtS9ey5kkjlTAmy6DE/9dBbupxFpdhMRq3UIkgg==
X-Received: by 2002:a05:600c:6287:b0:45b:6743:2242 with SMTP id
 5b1f17b1804b1-45b69616f4fmr8080715e9.22.1756216044153; 
 Tue, 26 Aug 2025 06:47:24 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4b9e1fsm17747704f8f.14.2025.08.26.06.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 06:47:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9AA785F80C;
 Tue, 26 Aug 2025 14:47:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH] tests/functional/test_aarch64_virt_gpu: Skip test if
 EGL won't initialize
In-Reply-To: <20250826123455.2856988-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 26 Aug 2025 13:34:55 +0100")
References: <20250826123455.2856988-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 26 Aug 2025 14:47:22 +0100
Message-ID: <877byq19g5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> If you are using the Nvidia drivers and have installed new versions
> of those packages but have not yet rebooted the host kernel,
> attempting to use the egl-headless display will cause QEMU to fail to
> start with
>
> $ qemu-system-aarch64 -M virt -display egl-headless
> qemu-system-aarch64: egl: eglInitialize failed: EGL_NOT_INITIALIZED
> qemu-system-aarch64: egl: render node init failed
>
> together with this complaint in the host kernel dmesg:
>
> [7874777.555649] NVRM: API mismatch: the client has the version 535.247.0=
1, but
>                  NVRM: this kernel module has the version 535.230.02.  Pl=
ease
>                  NVRM: make sure that this kernel module and all NVIDIA d=
river
>                  NVRM: components have the same version.
>
> This isn't a problem with QEMU itself, so reporting this as a test
> failure is misleading.  Instead skip the tests, as we already do for
> various other kinds of "host system can't actually run the EGL
> display" situation.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

