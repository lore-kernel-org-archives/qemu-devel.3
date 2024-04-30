Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE9FC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 17:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qxg-0000Fi-Nf; Tue, 30 Apr 2024 13:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s1qxd-0000E7-08
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:08:09 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s1qxb-0001Cp-EV
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 13:08:08 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56e78970853so54143a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714496886; x=1715101686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+5EWkn1V/7JbQNikcmhRTSibEcnep6bZwCKE+4NwtzU=;
 b=SnEOJYLPP5V5W6nZk7YBhm/NyPKKYWhqAOQ55x0dhRGKtlKzq4i3J3tXHdOx8aUjEx
 7COVaR8/PH8nkDFBMDvJpakAPS/LTMtwouKfRJGO5v/z7r1xbaXRbQXq7lah/pRNkcAe
 LK8bPA5CC70N89XNyJhnW3uTUD8IisIDGb6B+lqNP2FyE7dZ88K8Ljq2GJyHgQd+jm2N
 bN4iPZ5PMezessmdyqCvEwdqmPHDIHMJqiUgIrFnUvlyCefD4zZLjxega2nfLQjXldLt
 f3QYxpSZyC3gqTO2sWxmntVK7LSQR8sANR4iSYyOqUUlFWGXFAmGJRQMDHaVmTE8Fq5f
 Y3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714496886; x=1715101686;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5EWkn1V/7JbQNikcmhRTSibEcnep6bZwCKE+4NwtzU=;
 b=amSabj80o9ziSxuH8SKSho055o14ITAx1rbDjZJjIkgRODBqoaLqI69aALGeQNd3cm
 xM1jdk1FEa1BVm6FSdxa+7JdnF3qYVQy+oDDR7M1RgF+fRnX5jgIAI1HNInMbx4+La7A
 qDnAo9vhGp6yHYzSCYW+CJgYdAjeBg1fWh4O1/ZYHM9zekf08zFZREYDHjSnkweW/sUS
 KKUk/tvPLzPUVa+G33CX2df/4/ygmS1qV3g4KUGxT+z7PsngeVRSDfPc482+gCZs5NuC
 whE3OYz5T0tr5JSngV0yqgoRNPeCYiEPzBUHqQFSAoir4Enw69yq9Q5WFUcMW+uJbbHX
 Orqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv11Eh4WxJP0lz56HgC8oSNruE99GgJZlZj7qACDU2he3lOIEUKywvSypJJST3mcwMvkOMUAfEaAb3xEzv3uclIEfYm8c=
X-Gm-Message-State: AOJu0Yx/Hg+afp/f7klrAJXvfn0mwXE6/zaye4C2UPLyDur4vdqoSA8s
 Gra4K+JEXABC19nu4PnvPHdSFHeN9vcU33hZ8n+H/5div5+hTwssXvg2qqwqEvc=
X-Google-Smtp-Source: AGHT+IFnGb6rFkcn9mOacaEE2Zj/cyCgmKX6tVBCfAVqUb1HA31p715zAsuszOOY0fsvd6PR3MxHlg==
X-Received: by 2002:a17:906:a0c2:b0:a58:c550:a102 with SMTP id
 bh2-20020a170906a0c200b00a58c550a102mr364615ejb.29.1714496885700; 
 Tue, 30 Apr 2024 10:08:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bb6-20020a1709070a0600b00a55b020a821sm11403279ejc.13.2024.04.30.10.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 10:08:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D54E45F7A7;
 Tue, 30 Apr 2024 18:08:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Alistair Francis <alistair@alistair23.me>,  "Konrad, Frederic"
 <Frederic.Konrad@amd.com>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  sdl.qemu@linuxtesting.org
Subject: Re: [PATCH v4] fix endianness bug
In-Reply-To: <20240428181156.24071-1-adiupina@astralinux.ru> (Alexandra
 Diupina's message of "Sun, 28 Apr 2024 21:11:56 +0300")
References: <20240428181156.24071-1-adiupina@astralinux.ru>
Date: Tue, 30 Apr 2024 18:08:04 +0100
Message-ID: <87y18u3hjf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Alexandra Diupina <adiupina@astralinux.ru> writes:

As the subject is what ends up in the shortlog it is useful to prefix
the subsystem to make it easier to see what was touched when reviewing
log files. So maybe:

xlnx_dpdma: fix endianness bug

or even:

xlnx_dpdma: fix descriptor endianness bug

as we have space within the 60 or so chars recommended for subject lines ;-)

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

