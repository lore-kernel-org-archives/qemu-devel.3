Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34444CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArSO-0000Ks-50; Mon, 20 Oct 2025 11:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vArSD-0000Ef-UM
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:05:47 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vArS4-0006zp-H0
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:05:40 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-63c489f1e6cso4108381a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 08:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760972731; x=1761577531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPxwioLMU82XG6aL3RZuFmO5DMVVUT0tCYu20mykXFU=;
 b=hLkttJzXZAYFgQuvEL+N07aVUtYwdt+Hr/G7h2aINR188YE2UbjhPFYyYBUb3jA0CT
 gTOUCugYZHeOC5a2bL+0nZpzG+Elj/cx5U6TMGUQHe0wr1JFJaneUBh9vaZXZnrohVtx
 mZUeelCpmgibiSjoiGhYGOvRifowSuGKmrPqytqQKDuui2Zt/0ZviWBA7C4qtCnEV/S/
 gdkUSazSgkqnUnPqlh/wv7RBW5m8ySUtLH31aYX5DDw4p37NRg5E9boz3DfDsHV3eNKH
 H4M7eObiIK6iE1lpgRg4WFf3oUDiXOfClE00J8uUTd+YHgv9rorMALRQ6Cj56xJBfP/4
 mx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760972731; x=1761577531;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uPxwioLMU82XG6aL3RZuFmO5DMVVUT0tCYu20mykXFU=;
 b=Lum6xHud+W1nVdGoQY9Gwsu4wQBZtkRvReLMI5qXAFTemei/z0E6gNzUSzV1rUwWJU
 UedSwLDRnkE6NLX+oDAKsKMEzUNrFxooyCAL753B3FvTG9zQOUIbhnUhrSi8MjXra0Y0
 Ruq8FO0/LCSBKTh+TjBtORaV50saUzzQVws6tk2OzyAs5DjlWMoksHcrhKzNcXyv/vlL
 BZJ7d8LX4IE0hGH9n3c/nyv3c1TDnvuuG+wgVu+Fe+qdaCF6ob9r+NqiAads+JGKT5tQ
 h7Fd5Md7x2u1adt0o43wSFtI1hT8APvFFgQ17OKCOO5okAICmEKTejOckT77XqEPCdfV
 nbZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzrMjSam7gBndWkgtPjXZTbbMkE65oXENxqQ0kQqnBHNfxUVL6T0fVR4WAmd4ehVQmD5WC2v760b3f@nongnu.org
X-Gm-Message-State: AOJu0YwJrIWW4uJDDFYvuU1P++xBKpt5bnsUNbY9JeF9Qw6V9r1+/ner
 KrxRE9Ri6usOG7TgWAn34hFTc5Ry33TXSpflg08fVox+8Ic/rvzy4bKdl4TWXsQ3NLM=
X-Gm-Gg: ASbGncvm9IlJsgZJvQ1br8u9Z68Z/ravOMr1Odhtbio2zbYi+XxTAIs30NneAD6ilbv
 /6TdtE88j1Z3oGbpw8GjNbhx/uAlIu4w9v++Hg5yHW0+4n6fKxNmu9Uc1PBMABQPvNYfiyMS1Xo
 5viv501hmH9U0wig9jv9JoGP9LBow2lJW8sWCXiSAvKO0XQ26fmdBTG1E/QUKYNEP7gWHu2E7PV
 yRyFZc1rGRim8JV9pi56qyoEkQkkSa8M5nYpDN1VqVnkt2SarxP1W40erLR8WJ3qxVfTmVpq8rV
 GRbwFgB7Gi5wXpDDHSCv0qAU1SClAXvO2cpmW/AUCupe6oEh84NxByU043DFOoomaMRgjuvYMxo
 ZAuFQgz/6aEhvp1MLeBwh6RpqTsgExR+JGVqFcvz1qcAzup6dTgUYnk9+tQd6I/sfgUfL2OV7pU
 32
X-Google-Smtp-Source: AGHT+IH6frY65PuC1oT6+snkOB+sKdbX/Hx7R5m8UkiTIv9FFS1p1fjYIP8RJumgI5lqMM5ch/P1cQ==
X-Received: by 2002:a05:6402:2788:b0:63b:ec3c:ee32 with SMTP id
 4fb4d7f45d1cf-63c1e2571cbmr13478049a12.11.1760972731310; 
 Mon, 20 Oct 2025 08:05:31 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c4943015bsm6992616a12.21.2025.10.20.08.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 08:05:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C48925F83E;
 Mon, 20 Oct 2025 16:05:28 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,  Luc Michel
 <lmichel@kalray.eu>
Subject: Re: [PATCH 1/3] gdbstub: Fix %s formatting
In-Reply-To: <20251017213529.998267-2-sean.anderson@linux.dev> (Sean
 Anderson's message of "Fri, 17 Oct 2025 17:35:27 -0400")
References: <20251017213529.998267-1-sean.anderson@linux.dev>
 <20251017213529.998267-2-sean.anderson@linux.dev>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Mon, 20 Oct 2025 16:05:28 +0100
Message-ID: <87v7k97gw7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Sean Anderson <sean.anderson@linux.dev> writes:

> The format string for %s has two format characters. This causes it to
> emit strings like "466f5bd8/6x" instead of "466f5bd8/6". GDB detects
> this and returns EIO, causing all open File I/O calls to fail.
>
> Fixes: 0820a075af ("gdbstub: Adjust gdb_do_syscall to only use uint32_t a=
nd uint64_t")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

