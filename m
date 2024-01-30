Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79DBC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUl0A-0004op-4U; Tue, 30 Jan 2024 05:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUl07-0004oW-Te
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:05:56 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUl05-0003P4-Bq
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:05:55 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40faf6788d1so786995e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706609152; x=1707213952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGjj4t6Tt0bfPXKL4DzHKstkGoaCWrviJvk5cF8v3JI=;
 b=cYGWIkP0BxpKI5fXdowSImYobbiw7zDwnC9qabMz24mpu2yTRVDjq9merS10Anf4O2
 OKHB3dVzGRMdUxm0EzYd4cE7I/M1Z5PLgLy+XRnE5a2saIpEbpGJd6INntUj/4Np3Hnq
 +8ztjL+uVrNxeaIr1JxydUM9IaQULvUTg49fzvl1T5ofGW8pmQFWJBozD4eDG+5Q/sFG
 x8vsJ7Dyil5z7RwwlhfS4UKSShz5KGnwCqGoD2A4Gu2Qay527fo7irhpk+aLBmKaqRoQ
 8uZhSM2G72NUv5wUonlIVA2XIJfAtKcp/pzF9KYxt1MqSFIU2y9ZgJUdm1jxLDz4fM3i
 Gy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706609152; x=1707213952;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PGjj4t6Tt0bfPXKL4DzHKstkGoaCWrviJvk5cF8v3JI=;
 b=bqBQiYSI16rERMLdfQdi9ICtruavSo5y7axLDfiHDa1sNYreKFs8I3GY+36tCrVD9e
 ToZ+igTTuWoqkusue9lL9Gk2vGMReKj/xC0/3cGcaBRfjkxqzk6L3ZjHq1kDy44siQ2W
 FJH6iZNSPpKLY5QEG/W85GYVN4ixEbnsgXivszkUG5bAfCyCtYDzVuNJ/SKmh5+Y6TY7
 9Yiwt06roTXPUbBoziLpc2VAqkRE8w/pSIYHWCTqnv0e9ikMcvg2NsF9YdbZvJ3fvrdA
 +nV7o8grIQc1pbQxP2N5edTiDKUIKVGV0Hr5adO4LahlEszXy4aCrNT0AwvJCPEdu+P/
 6wkQ==
X-Gm-Message-State: AOJu0YyxLQA6v/Tc35duN/Ho7z/fwfrA4Kxdas3WMUo9h1n0EWXmWwVq
 bbdVZEsFxQigDbYLDlF+04Ar6HR+su4kN4WBWqVch1upTZvYzFKBWqqL4BSf2xQz5QJM3b6iTAC
 F
X-Google-Smtp-Source: AGHT+IEVpRJfzbaAlKNFmBWom/z95zvc/A0bG95rOio6RyuB2LN8r/AzevkFaZe0x0Gor0Wj8R+n5g==
X-Received: by 2002:a05:6000:1848:b0:337:bdd5:778b with SMTP id
 c8-20020a056000184800b00337bdd5778bmr1172982wri.29.1706609151803; 
 Tue, 30 Jan 2024 02:05:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ba1-20020a0560001c0100b0033ae593e830sm7766308wrb.23.2024.01.30.02.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 02:05:51 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3E0BF5F9D3;
 Tue, 30 Jan 2024 10:05:51 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-block@nongnu.org,
 peter.maydell@linaro.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,  Anthony Perard
 <anthony.perard@citrix.com>,  Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 4/6] hw/xen/xen-mapcache.c: convert DPRINTF to
 tracepoints
In-Reply-To: <2fbe1fbc59078e384761c932e97cfa4276a53d75.1706544115.git.manos.pitsidianakis@linaro.org>
 (Manos Pitsidianakis's message of "Mon, 29 Jan 2024 18:09:40 +0200")
References: <cover.1706544115.git.manos.pitsidianakis@linaro.org>
 <2fbe1fbc59078e384761c932e97cfa4276a53d75.1706544115.git.manos.pitsidianakis@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Tue, 30 Jan 2024 10:05:51 +0000
Message-ID: <87bk93qgow.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Tracing DPRINTFs to stderr might not be desired. A developer that relies
> on tracepoints should be able to opt-in to each tracepoint and rely on
> QEMU's log redirection, instead of stderr by default.
>
> This commit converts DPRINTFs in this file that are used for tracing
> into tracepoints.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

