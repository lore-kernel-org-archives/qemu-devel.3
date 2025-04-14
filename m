Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30485C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 09:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Fqu-0002h0-Pf; Mon, 14 Apr 2025 05:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u4Fqm-0002gP-Sp
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:11:34 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u4Fql-00005j-5T
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:11:32 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5e5c7d6b96fso7510480a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 02:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744621888; x=1745226688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBeGzW4GRT27FD9nBqw0WpL9INMPF/1w15OX3dtxfq0=;
 b=WDFIb5PRtT50+SDl+RDnslgunZ+YlVkP126rQny2e57VVQq/G3/dy4TuxNS4CRJUlM
 QBoiYg+TSCcpPSeg/AYOimV2Kklw+GeDI1BP/DzEMai1j81BiVxdH7aATOcYEb9l8vlV
 4CfN6XVuSEIwjUMma5QWMzSsUGlQR9/ZBK2+O06PwZVqIWKi6OJfLiofMIBg5eYOYHDB
 UF4NgD9ePMBeqoHjeJ9ILRhX0kginP/wRPRElcKHu0Ae+e5fuEOR+x37wqmPFSAh1x68
 baeo+DmpfoaXHNXw1R6FfWSozxHUyaK2Rmf6rboqnHzOYnv83t7FkzIVp4WJku6hnW/b
 sPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744621888; x=1745226688;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EBeGzW4GRT27FD9nBqw0WpL9INMPF/1w15OX3dtxfq0=;
 b=OjTKU/GydXwuwHvvbLzUb7/mutk0lI1ou8liB8XK+Q/nB0ykL5N6Nb2MJyYRcYBgKn
 rcWVvavb2RVO6XSU4t5sWKXK/ae3wJJi3+B7rz7Atd+q/nX2h+VMkK5qo3IJu5xP24H1
 G1HZnkW3MpPvgfc+Jq/GyL24Q4VtlZUiGYwjjGlHDz+tKxv5NQGiR8h2xLcS+MmXu17F
 AmUJaWcP1SIVC2GpCLF3lt3XGhxOJHObC8BcSm4b3Lq22fiY8nsp2rBoR7srRn3qgaxP
 oE1O+SYLeRKgwoS4TqPnmx17q8ahvESnjg2fKhMfyNV4o1YwFEjpA24UfnP2Isw+lib1
 mtlg==
X-Gm-Message-State: AOJu0YzE3VSKD3T78Jgv7e4w2uj+wK6eKrz7PsE9PFJ308WvQgfknyMu
 xRHo7Ee0Ri+w+mXXyJAtWisPeKn03LMZPzmsJLlE/kEGnDYprjgkvFQvjk+eldg9kcczafWYpTr
 E
X-Gm-Gg: ASbGncvvIXv39hWhw/kidfJyXU6DaY569a6/Up8zgRRnRTYpyGRt6mNK1/bMHpCSOer
 sQM8nyU16JEYNUrb1ATuPGMdK6JFs5fAlwpMdNi/LKeoLMbbAx31Ne6qaTmtBgN5U+cJSohlNUs
 V8Ui40TPctCrFPViyZmxESmBK2JKAFJKzAlyBTn3Ujca2LuO7lBJz8vtMFDJLmM1d8j+r2Vvnb9
 kzQu10hpSBvZ6De880gKJpH4Qkki1/c0XtnePawhkSbj1pIt7vB26N20r4CpXqCUfi2s3vcGJ9u
 4/7yPHYFiWi3XZ+5c1YtFjOXu2NTcgTFBSFSPZstzyE=
X-Google-Smtp-Source: AGHT+IE1v/TIbw31VO89KEZg71S5Tj/ICKLgtpo6R6LAWMiGBf9isBAB6+IAAUNV72+z+Cc1HXpKzw==
X-Received: by 2002:a05:6402:3487:b0:5ec:cc90:b126 with SMTP id
 4fb4d7f45d1cf-5f36fed53ccmr9172252a12.19.1744621888137; 
 Mon, 14 Apr 2025 02:11:28 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f36ee5541fsm4537046a12.14.2025.04.14.02.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 02:11:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 79A7D5F8A5;
 Mon, 14 Apr 2025 10:11:26 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Phil Dennis-Jordan
 <phil@philjordan.eu>,  Cameron Esfahani <dirty@apple.com>,  Roman
 Bolshakov <rbolshakov@ddn.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,  Mads Ynddal <m.ynddal@samsung.com>,
 Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH 2/2] hvf: only update sysreg from owning thread
In-Reply-To: <20250402135229.28143-3-mads@ynddal.dk> (Mads Ynddal's message of
 "Wed, 2 Apr 2025 15:52:29 +0200")
References: <20250402135229.28143-1-mads@ynddal.dk>
 <20250402135229.28143-3-mads@ynddal.dk>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 14 Apr 2025 10:11:26 +0100
Message-ID: <8734ebf6pt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Mads Ynddal <mads@ynddal.dk> writes:

> From: Mads Ynddal <m.ynddal@samsung.com>
>
> hv_vcpu_set_sys_reg should only be called from the owning thread of the
> vCPU, so to avoid crashes, the call to hvf_update_guest_debug is
> dispatched to the individual threads.
>
> Tested-by: Daniel Gomez <da.gomez@samsung.com>
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

