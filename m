Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53569FEFB4B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvxSj-0004j7-4F; Fri, 27 Feb 2026 08:00:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvxSP-0004hP-TH
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:00:39 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvxSN-0003Nm-Mt
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:00:36 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b8fb3c4bbc4so292158866b.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 05:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772197228; x=1772802028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/P8Dw5SjZ9erFXlIDk5Hj2i9CHN3A62UtBOXidNtRo=;
 b=yPyCqaUoTXzt3J7u0/5C0DLGEksQelSFkVIjifkcgOgKaebXN3bUfPtM/sjMEJa46j
 nGH+XrwikjgU/KOI3zjZj9quz8GJe100+g5vM9nLBnyGSg2zqDVv09/vPGPPAiBRqvmc
 el41WxtsulJeDg8fNldtIAhCQXRDGaD2TSy5ytDfUO+Ak7qxgehhmLZYyU/uTDmax7D5
 jpl2EQa8q805SLSUuZMBsL5Q//nthXz1/6HDmV/gs9F7sNhWhFF75hniuZ0jKCWogfQ4
 4ANmwnIM8YikYFzihMDjNsH/p7yrHxYywRpj9AoTjY797nKUtfs/gkwbQtYXucuQM8LV
 Bixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772197228; x=1772802028;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7/P8Dw5SjZ9erFXlIDk5Hj2i9CHN3A62UtBOXidNtRo=;
 b=TnEBdlzvAcqT3hVawNiqkyz64n6PBkOQE/3EY+yj9cWgdbvlIqBvIxbe53XYFjl0Tf
 DxKvya05sVSckz/z5h45gn24hJR4JXf9RdRCUFgtcLawbrX/KiOyV1yFWaNRQgKNGzFM
 5jXJK/a7ayI8SmgIqPjbbcVlPNlY8pr2dETUFErXYzrlEQGvyYgof39GgwJkBnUDZC3n
 /f8vj9tv8j0TfuuZrXcSp+QXtyCo6inr4CJWwF80OaU56Bw7qc06uA49RiUqHHmPJFka
 RXUn7to5dIRLChChAZftSnkaoMSaAV0cDVpKKnFi1axsXTPbeWoUnF+fTJzv+m0UxF2U
 CAeQ==
X-Gm-Message-State: AOJu0Yzzvg/TvWDMnYbclznWOtboJRLYi4h+/9yBGCVqMJKJuIPUFkSN
 U0CN0t3BiGu9CXHYXpDABthHUl/ynn9LJLkhac4QvDspsuVNoPNvmMSGAA+peQWh3Hs=
X-Gm-Gg: ATEYQzzAltIyc2Aw2XunWmINPb9byxlLtl55312YVLRxbWkl3dHgsl+20+vmOYSjSaC
 VZD/vk8kopcI3mw3hARJ2YFuPaR5rIfOTUS/Cy209oIqi2n1Zcla7xCgi8ygXfyyGuIY1Qv22Vl
 5MqVcPt6rIGDj+bqdj0aiGQ6tM1OqCbGdadOTU8LBzjAT2AFVabFowOcEnKXe9Zfq16WwGBvLPg
 jYXxV9IBvGRzi5//tD+2CkbBoaXIfLVEs2DwobwHzTe/Wly2pZMEuiNjwczCSkWh26nsSjilwYh
 P1emYxtd0V3knEphJP7l31WsoD/0fyIILowaLzKMoYTwut+aDocqBaNbi4GA5C4ZcJW9jXDM5nO
 aKCVD2n4V/5BpZ3NB/els9wOTRu4LMc0f4LksBIbui0z0cCBIB8Ct6nhTfUObGe3f/h1TbpmFmy
 HhPuFQjfqGTYYuR1PGERFOga4=
X-Received: by 2002:a17:907:7b8b:b0:b8f:97c6:1e2d with SMTP id
 a640c23a62f3a-b9376365a38mr182354666b.4.1772197227399; 
 Fri, 27 Feb 2026 05:00:27 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fac06e3fasm1236144a12.25.2026.02.27.05.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 05:00:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 182A15F7D1;
 Fri, 27 Feb 2026 13:00:23 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v4 1/4] meson: Restrict gdbstub to user/system builds
In-Reply-To: <20260227104314.81038-2-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 27 Feb 2026 11:43:11
 +0100")
References: <20260227104314.81038-1-philmd@linaro.org>
 <20260227104314.81038-2-philmd@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Fri, 27 Feb 2026 13:00:23 +0000
Message-ID: <87seamxrx4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Limited builds (tools, documentation) don't need to generate /
> build gdbstub files. Only process the gdbstub/ folder when
> user / system emulation / acceleration is built.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

