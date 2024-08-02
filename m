Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768FAC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 10:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZpib-0005lx-DE; Fri, 02 Aug 2024 06:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sZpiZ-0005lC-66
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 06:41:03 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sZpiX-0002TC-6o
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 06:41:02 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5a1c49632deso10508610a12.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722595258; x=1723200058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KaEekznGiuQmxgotdY68FtlBSpUh28C4n2k+xpgE/DI=;
 b=TJY28zcvfO8wJf7j6+++NvQppWglcVgpJjM15wZN815wCPT6Sf1wn06UVTW8zDtd42
 FGb8UUGaxG0wehY8V/BPFomj2qW6Su8OvJchNIUWpeiRX/ubLEDMOxrrWuUSPB4uyBUH
 taOgi4qrcgHyYRYMz0l9eyjygwRf4GqArCf96JHwHH9dj8REj4EyjR55z71haH9amJbC
 5rMemM0kMzVZrXHr2NqwyHbTHhF84CDwAI4iKr4zkEJPzCHEFGaLttU3NaU/15bwpg10
 Xli5YbJhNusFn2J3wsbWj4LujUBX1ByLHZWS8R9ajGdDW5Ix05ZWpxTcRbN6ZnlaPErm
 8ozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722595258; x=1723200058;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KaEekznGiuQmxgotdY68FtlBSpUh28C4n2k+xpgE/DI=;
 b=Te4Dhk1x8CmLrDiVBOarTdtjt/DO+ZjpOitqwVvAQpevUpHzoLSTi2xNnjqhLdbQ52
 hF8+AudnHr7htHiKhb7fz/znnR26kEgsEERaFCZjvzF2bFmm71G3q1UIvm/ZZHliUdLU
 9dREchhYS+rYRslD9pwBIht9SREAQqISBKR3JNoP0tfmruxftt7USlfXpApNbOYMAJn+
 tXikAduPWUCLeJFSQU/Tcs8941SglCMCcvRe0JVLFXvhfpOBkKrrhFBSiHWLbej6zzjT
 rtHOEYnnaQ8Vnep94wR96K+oU6btVt1FRkMmhm5c+IX3Bd8NxC3Bhktj5PCe1PcYgSmN
 pQbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW85WjOih/SYuL5L2VUL8EZLDUEqoRawRfP2AyUc/euNbgDOHRuTjMDvAUI2QF2AhuKiuNTBKsp0icUd+bqf5MA0mjkhJk=
X-Gm-Message-State: AOJu0YxkUuLrHNtt905fZMLgHVgHX9RKrmPFvGOx6hAkvrPwrV6OV0YF
 gy/yg3L6vWPn++Y2CcnvOlZJbZHPI48mO4YF6rbxqGk0le/BS0BMDmNwsOIoSzQ=
X-Google-Smtp-Source: AGHT+IGz7cUbjaVOpNo4jtvmLGnU/bveSogoDhxYfv/3OnBJNiZX8Ue4sdv2jtiFVuk/zUBjoNlGVQ==
X-Received: by 2002:a17:907:7f21:b0:a7a:9144:e254 with SMTP id
 a640c23a62f3a-a7dc4d94affmr236903966b.10.1722595253282; 
 Fri, 02 Aug 2024 03:40:53 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0c557sm83422966b.53.2024.08.02.03.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 03:40:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B7FE95F8A9;
 Fri,  2 Aug 2024 11:40:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH 5/5] tests/tcg: Run test-proc-mappings.py on i386
In-Reply-To: <20240802095942.34565-6-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Fri, 2 Aug 2024 11:59:18 +0200")
References: <20240802095942.34565-1-iii@linux.ibm.com>
 <20240802095942.34565-6-iii@linux.ibm.com>
Date: Fri, 02 Aug 2024 11:40:51 +0100
Message-ID: <87o76bcimk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> Now that orig_ax is exposed and GDB is happy, don't skip
> test-proc-mappings.py on i386. In fact, it's broken only on
> m68k now, so skip only this architecture.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

