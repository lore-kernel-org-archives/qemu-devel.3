Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F08CD6E49
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 13:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTJkm-0001pu-LC; Sat, 30 May 2026 09:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wTJkl-0001pm-8g
 for qemu-devel@nongnu.org; Sat, 30 May 2026 09:29:27 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wTJkj-0004PK-NL
 for qemu-devel@nongnu.org; Sat, 30 May 2026 09:29:26 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso9081365f8f.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 06:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780147763; x=1780752563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGjxcXFKQaJWCitxfrkzROrkKg6cLM70RNbxKwS5Hfk=;
 b=mjUdZSCLmoUpMLBPCvL11RnhCtJRgfua0/CtOTiIiUMADswWr4J644gJ1KSrd5gZdx
 C9+4qvpln5tJv2I4AKipr67QG52L4GVqjcCPDFdMDEH+BsqF6qkZuo4XXHBAMa1Zuszv
 F5vbEDCbkxLRwaqpA/Akp5f1nWCsoCT57LrVcKQxbmpD8Yy1OZpZafaHm+HebN1C4jdQ
 bzNofEhOVJWsOrBZO2PVrSYO9yHhxF4qRR00OdwSS6BaDZvHov+gYkWkLUvn+SF3Q/Zv
 AdN/m09EDrxWX7mpDRGFLLf85FPodGySWw09bIWj7C9dBERRYcnS2kBmZxu2IVLNrQuT
 Qsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780147763; x=1780752563;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OGjxcXFKQaJWCitxfrkzROrkKg6cLM70RNbxKwS5Hfk=;
 b=KUHJmWLlyoR/ub8icI90x5HPdQR+9Ul8c88vUbIKB1YxDTcYwLpQPCowLFq0WPfHxQ
 I05D4K6LweHLUuBeguWozht7chTmwDDGzHl3bDDjj5hs2TKx6pZSdF2vAfJarARS+1qO
 rSqnCKgGu4D+YpeP70BLTgpcXyyHpLUMCRgy2hn3+cooYTfzQSNcBMLhZ6MFwTGtTKVo
 zFagu9YTh1KqA1X7uMC1BtC5MUMKU2ZHgPHagt5dlk9AF/8hgy+A2LGL2ZhVCn40//Qh
 CxpNgfCWc68fTVJ5bl91MEAk4aF9WqoOrBznV3u8CifnsXUXqn33cVsF1HCbWQa3/2mX
 FCxg==
X-Gm-Message-State: AOJu0Yw5iWPMkjARmPI6AqhnqnMncdr+BMQls1l7sOq/5ElNvMy0EOUm
 3FFBeH42E3tf/+eZe7Jk0siqpi8ah7CGga4dZKPfVAg0dGNaI30RMU81NJ1gP5zmULs=
X-Gm-Gg: Acq92OFnJrHdr58oLinfJKrPv5Cg2QegP+tkto2MPdK108uz+lRxK/oT152328InKtc
 6ukKfBNR7SjFycfpe/r1IbHkRXRY5tpY4UFnpd4zW90Ip7ehggUTgwu0z3Nkg1KJImmHL/Ofg7/
 BfVGKHR4iz9556HD/d+NLypKqKlBI2x1ld8i2Cv/ON9OhFXOXsVUbKEhQoUysyo0uMVBAKJFZZ7
 rjs4WzAJd/TaQE3NXMgeYGlscT4iYrQVeGT53hsPzqOdR0MzQN4Ao//vUpjiOczEkPphpQPpG1T
 bZKbMHgiUFZ2qpDhqRxwW3IloEGJ43AbMYoOQKpPN0Kv2HnS5ruPlCCT/5sCEkjUsKs53+1Cqx8
 keBtR7rP7wVhO6IYK0B7/ogvWHnL7saHRH92jfaTDHyt36ktsLpK+hB4fXTcwLzKZcOOq6m+tcy
 PhfcnGGtHqu/6VRJYmw4ke/wSS+2IjzXiI+w==
X-Received: by 2002:a05:6000:481e:b0:45e:8edc:dacc with SMTP id
 ffacd0b85a97d-45ef1392e8emr10642870f8f.27.1780147762642; 
 Sat, 30 May 2026 06:29:22 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34a065esm11219295f8f.5.2026.05.30.06.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 06:29:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8D10F5F7B7;
 Sat, 30 May 2026 14:29:20 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org,  Warner Losh <imp@bsdimp.com>,  Kyle Evans
 <kevans@freebsd.org>,  Laurent Vivier <laurent@vivier.eu>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [PATCH v2] util/cutils: drop qemu_strnlen() in favor of strnlen()
In-Reply-To: <20260530062816.59206-1-guobin@linux.alibaba.com> (Bin Guo's
 message of "Sat, 30 May 2026 14:28:16 +0800")
References: <20260530062816.59206-1-guobin@linux.alibaba.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Sat, 30 May 2026 14:29:20 +0100
Message-ID: <87tsrpf2kv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Bin Guo <guobin@linux.alibaba.com> writes:

> There are only three call sites, and strnlen() is available on all
> supported platforms (POSIX.1-2008, Windows via UCRT, MinGW).  Remove
> the hand-rolled wrapper and use the standard function directly.
>
> While here, align bsd-user/uaccess.c to use size_t for max_len/len,
> matching linux-user/uaccess.c and eliminating a signed/unsigned mismatch.
>
> Also remove the stale qemu_strnlen() entry from docs/devel/style.rst.
>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

