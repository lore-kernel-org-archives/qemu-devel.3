Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201ABC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 17:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb1dg-0008CK-IW; Fri, 16 Feb 2024 12:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb1de-0008C2-MM
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:04:38 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb1dd-0000lT-3G
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:04:38 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-412393ea2a0so6431615e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 09:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708103075; x=1708707875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KK1dLFux+4Y1KMwT/C6JVyp1bTN8wM2T5x66gJXmM8I=;
 b=ulQFGu0XRcIePkevVlUmGfsYf1746qdO8kd0nOAJ7/zY2CzlOM6m8yG9qEtTp3H+An
 n7WcX1qEKIWJBal7ETPnP3sH3/qZgoGrP7so9lnThR0JyOCzf/D/94rTCaCxmuoo2edA
 FLsqWjgNnwaOWmdTmAu998Eyvz2gsAkRhoEzXW8B3cNsyxGmP8T9R+eS1BgCztEK8TOl
 JgRKJrb2YsPJRZaRJfmKwzhOuR3H1OQOToSEpmmoeYfcPaunm+PAqkeOE3wVCScJnjVb
 mG4sq9W52Oo6dwl3EiP3zE5V+0tJ/nfsIG8tCSh0Xrj58yYhTI6pvbsNFkMpr9Y2Fq3W
 5aEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708103075; x=1708707875;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KK1dLFux+4Y1KMwT/C6JVyp1bTN8wM2T5x66gJXmM8I=;
 b=CAlADPLhAeJ6KTES5NQBnhNDwNyIMn97F9iRh6gxSyCagUuA+SU0WXJw0GNwvpQQBY
 asMEODpBwseqr1lSas5TPIESaMYaF2a70/Xtu2y4E56Nm4yi1iQhCnYXep/RpS2ICOOg
 U7bgqO8IUd2UyNqNnXFova/zJ4uQWH8++kEPSIQZ/Rl8Fja2xG8XvFs1gs62O+4wjXzQ
 6MLbNUku/eKk6zjiJyC8Brer7dYXAPmori9qDH7WQAhTJSlsPP47RTKS00EuDSs6GLxR
 T08T4AVs7tD/rCIVUQOv/S0zyTq0jrohmmjEL8y/PRUn3IO+zX6aLsboHX7ZSyJFfuuy
 FTgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVV9+woaRoRuC2tEDBmcW3rR7puN+15O+Ft9VUFtigVDZVbVaFbPu7a9Z9/n/bzbH0STy03r29eiNVfnnutSRUyh3dL6Q=
X-Gm-Message-State: AOJu0Yz5zzymWjDgVrJdPNz//F8GIbKqQxe9y+BHaEXg2yd9LwwGyzss
 A9sptmV7pBCc3GaNqjF2l+aeaZHyf2OnxG0WoJrjcX5Gea4mrFxyStqXPNdwRPQ=
X-Google-Smtp-Source: AGHT+IHc7x57NZklmjha9LgYz9zhsoINDs+P5j5uoPJ9Q5ZGBiMKORC8Z9F6lMeLZ4WlvkI9BjA0VQ==
X-Received: by 2002:a05:600c:4588:b0:411:e0f0:7a71 with SMTP id
 r8-20020a05600c458800b00411e0f07a71mr4520176wmo.33.1708103075132; 
 Fri, 16 Feb 2024 09:04:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o8-20020a05600c510800b004105528c61fsm2917558wms.35.2024.02.16.09.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 09:04:34 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 831BB5F83F;
 Fri, 16 Feb 2024 17:04:34 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>,  Warner Losh <imp@bsdimp.com>,  Kyle
 Evans <kevans@freebsd.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 01/11] gdbstub: Support disablement in a
 multi-threaded process
In-Reply-To: <20240216130817.369377-2-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Fri, 16 Feb 2024 14:05:28 +0100")
References: <20240216130817.369377-1-iii@linux.ibm.com>
 <20240216130817.369377-2-iii@linux.ibm.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Fri, 16 Feb 2024 17:04:34 +0000
Message-ID: <87zfw02vdp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> The upcoming follow-fork-mode child support will require disabling
> gdbstub in the parent process, which may have multiple threads (which
> are represented as CPUs).
>
> Loop over all CPUs in order to remove breakpoints and disable
> single-step. Move the respective code into a separate function.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

