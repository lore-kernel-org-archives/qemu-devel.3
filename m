Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886F7C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwYJ-0004sg-5z; Mon, 17 Feb 2025 03:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tjwYC-0004py-TU
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:32:25 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tjwY7-0002ka-U3
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:32:24 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5ded1395213so6317459a12.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739781137; x=1740385937; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QHj67i3Y4ScqC8RVebaIiHNuSVYQEphLZXIWhHwBrxg=;
 b=fQkcwhj14eaJtoBlzwXM6APMA+BZYXAZ/P3qUcFtmPk8qy//B8y2d0FrxPav+cDFDZ
 v7BrtCjH+TMEa/7nFL2LLJJyxE9DDACOklKnJbaJIuOofnSgdCdz+ippFwkS6dtM4gT3
 3Tte61il6x/e+bN2/JZDSa0LtIKSAsqBqenZ1mBMvW5o9DzdVUpc/NW0bc/UjMsMSGcW
 kREsc9Dx3NPjcXCt3rdw0Q0srOUPZlsTC7jPHRn2QGQxuPQ6Z9RxN9fAPgPS/zPTMIug
 JoxZL/XiU8kK/Mt6bcFuBxCm89xh/XBJNkcZt2cUKpavZJWK6pKyTaRHXzmSWZFSvTww
 uDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739781137; x=1740385937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QHj67i3Y4ScqC8RVebaIiHNuSVYQEphLZXIWhHwBrxg=;
 b=RnR9+WHKSPo2Mhuw/Kru6wF04a6c3f8WwcwOIO8MCalkn0KdRsQVTFCd3dyYRpyIpT
 IcF7RMBZSEbjY0Y7xmjuyfochx8paNC7EmFIQwcGrRlYo0l9l+8EE3OmdozZlfYcTYlk
 ovddVTFm4K4X26uf0Uiy73Se2bmGGiifERWmdmh8gRQSnFPhtqqibPnCGpaCF9wiphT+
 j3IPj5jWxeRGJqp0KipEqwaq+wkROu4p+yyUPeZ/Jc9N9kmfVNmAy5dn3J27oRoUM2ei
 BYENYOmt27MiaSs2KOOnIn1SZMnfJBCLI8OpdHYBn0V/HPFBTh9d7vDI95unv3dN5Mnz
 THOA==
X-Gm-Message-State: AOJu0YxLt0p5coU9f/SuzNkPq3C0rA5lHf1CKKELcH/zRaDPc5McPgBL
 EmZibNWq6t3FlJv/xO+1QD4CSIRGWoXLtkjhb3v7AjDG0fqaW8jwGwAiWjDTJ3fHwLNlcVZ7vW8
 Uzkg8p/kzAX1/H0XNzRONv+ezNls=
X-Gm-Gg: ASbGncsSBNVAJKZMF261PTaUNofMhQ8d2eiYJ8NwPv6Q9oRk69JwTpY1rAg/fY8oJIO
 grcE/EcGV5/bOK40FoDRAidG+vehohYSajuqngeYzGR1RjdaOX5+Y3e7sfKFoECkL3NCYrcdo
X-Google-Smtp-Source: AGHT+IGxs9jjudzdzPufcqV3Qf3yMva4+7KDt+5kipj+eAI5tadJ51MLqDLQ6gGJSAEMHDnAUwTCQirHcSqdWnpkXDQ=
X-Received: by 2002:a05:6402:2801:b0:5dc:113c:46c3 with SMTP id
 4fb4d7f45d1cf-5e0361cbdffmr8560732a12.21.1739781137211; Mon, 17 Feb 2025
 00:32:17 -0800 (PST)
MIME-Version: 1.0
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 17 Feb 2025 16:32:03 +0800
X-Gm-Features: AWEUYZmANipFm3HLxerzoR_tXmp3Tg1wQBwIUwtHGzQV2nlZ0vELhQKW2M5rwvE
Message-ID: <CAJSP0QWmPFXx9_cUf2WAEtjGsgGR0umZgRaDSPdBukqDXXnXjg@mail.gmail.com>
Subject: Re: [PULL 00/24] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Please take a look at the following CI failure:
https://gitlab.com/qemu-project/qemu/-/jobs/9153630625#L5195

Thanks,
Stefan

