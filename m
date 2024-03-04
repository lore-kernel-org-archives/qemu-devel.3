Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385E3C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 18:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhCfD-00010e-Hp; Mon, 04 Mar 2024 13:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhCfB-0000yP-IU
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:03:45 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhCf9-0006T4-UR
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 13:03:45 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33e1207bba1so3833658f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 10:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709575422; x=1710180222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OEq8+T+wLX8mR2vomKvWYeIZ9wf4ORqtMKoXQKvvhAQ=;
 b=Nxl8nUZ67wXM+mSGZA2vVMC0VGQCKxuEKcNN9vxDQ321PyHzr78hvHYMpGipm2MV2T
 66lKVsBwFZ97aZZmcXq0bntXJ0kbotGsDvF1sCtyJ4lH8R/afU5nr56UQZOVNJ0NRJOb
 sZzgKImk//YFcnVu7EsZqt9j6xtvpstSfP5cROiFkBVswhFhLvYy4xavWVyNKsa76UTh
 UdJQ65L6EqXkzI5Fqn8XUGdcQRWv6/+p2inMuTek9XDqC+sZewRKbibJ9FNGSlaJX1BF
 pZPJph9CZ2cTWAgdPUy2d9IjY+0ZLcFUq+NEXdgnawNkkopPQde3Zw97TZvfosCZi5wC
 rlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709575422; x=1710180222;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OEq8+T+wLX8mR2vomKvWYeIZ9wf4ORqtMKoXQKvvhAQ=;
 b=bCD0v68Jz0h9LgpLtnVzyZsogVs9gUy68K0NTnYYPxyVjddUw7HPLAFQPehFIc99RG
 tFE9p70991eV/GeqOrspPKDhWnX8D+nFzvq5lt1NDBGED2XMefiUmzfIhrOZ1VFr0J1E
 D1w1PPUV4z6+4SXqGbo3QT9KEmgbCpUFK2Fgbx0w0MUgHd+Yz/fRJCCGA+CmaRTSayYc
 C5GlClJLV+kbYIz7z0s+y0KjPRRq8RmL54SBE1+nMGfYt3pLkh2225UzvKji+xnHlVX/
 2aliWHDQpffsTJ9GtagXR3zceWiCV3MM1xG0Aasxc8L4y+W6WCq3Cy3eA7yuoyztHT/E
 GerA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSEtKxJOafw8+r/k+ZRN9aO76pBzwyS3CzQY3Q1ZTsJRiRT4QTM30OBKJnGQ61/obnxyVUWj/rNbg8ZUpUfRWclmLPgPQ=
X-Gm-Message-State: AOJu0YxuH0yLkUm9bbghrmgn9utLYLiLWLqXnmQe3G3LlIMr6b9Al5ui
 jZtiRR2oCclxSjzTfNRYD80a1hAkv7hV0IOKiIP0PvzgsaQiwCkyJxEnTMTg6bs=
X-Google-Smtp-Source: AGHT+IFtFfgLMWGEKfU7ZedXy1p6ZGpw3nDTmRlhZa/OJqf55XXOcAS+7Qm7KL42jOpdK5OAt3I2FA==
X-Received: by 2002:a5d:55c4:0:b0:33e:854:8b24 with SMTP id
 i4-20020a5d55c4000000b0033e08548b24mr6054306wrw.12.1709575422358; 
 Mon, 04 Mar 2024 10:03:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bk15-20020a0560001d8f00b0033b48190e5esm13119949wrb.67.2024.03.04.10.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 10:03:41 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4E4D75F796;
 Mon,  4 Mar 2024 18:03:41 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Warner Losh <imp@bsdimp.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,  Kyle Evans <kevans@freebsd.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Alexandre
 Iooss
 <erdnaxe@crans.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v4 00/12] gdbstub: Implement follow-fork-mode child
In-Reply-To: <20240219141628.246823-1-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Mon, 19 Feb 2024 15:15:48 +0100")
References: <20240219141628.246823-1-iii@linux.ibm.com>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Mon, 04 Mar 2024 18:03:41 +0000
Message-ID: <87cys9yiv6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

> v3: https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg03142.html
> v3 -> v4: Address the review comments, add R-bs.
>           Add the get_task_state() refactoring.
>           Keep passing CPUState to gdbserver_fork_end() for tb_flush().
>           Patches that need review: 02/12, 09/12-12/12.
>
> v2: https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00810.html
> v2 -> v3: Rebase on top of master.
>           Fix a typo in the 01/11 commit message.
>
> v1: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg06646.html
> v1 -> v2: Factor out a number of prep patches;
>           Add a state transition diagram comment (Alex).
>           Improve a few comments;
>           Extend the ts_tid fix to bsd.
>
> Hi,
>
> I needed to debug a linux-user crash between fork() and exec() [1] and
> realized that gdbstub does not allow this. This series lifts this
> restriction (one still cannot debug past exec() though). Patches 1-10
> are preliminary refactorings, patch 11 is the implementation, and patch
> 12 is the test.

Queued to gdbstub/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

