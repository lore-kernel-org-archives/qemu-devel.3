Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D015E6FE23
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 17:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY69I-0007fU-LM; Tue, 23 Dec 2025 12:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vY69H-0007et-SV
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 12:26:15 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean.christian.cirstea@gmail.com>)
 id 1vY69G-0002MJ-Go
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 12:26:15 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b734fcbf1e3so1023073966b.3
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 09:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766510772; x=1767115572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jdSrQ7BPT4/es4jfLjmE9LTAbNbt7LmG3QP22/iV3Ms=;
 b=Xk81r6VUNeATPHjmk4tBle6dgKS558BwuKbgzazCkje392/q0fWXvKJZvvogp3CnNO
 3dqK0NfeBnMzDfIuDYMkzSB0ZsSk56N1sN9zlpbfeyUvjvfV0KS5YPCQH1gay7AYEHQT
 0JR1PmkN7ETqgz5yoZv94np5rqRCOvLHZpc89SUNz2q1Fnx7e1YawHL7DAmRRxnPBhS3
 IbolJinEjd2SO/s406vVn1fjr7/wcKM399U2PMhOWr67QNpkTwiIDLbLym1oSAvTzHXy
 edCl/CplUqc1IdAI1Juhr5CfkNiRnNi+a7S+mxkltmtjz1+C67Bv3uksnV42tbpfgfWH
 M9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766510772; x=1767115572;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdSrQ7BPT4/es4jfLjmE9LTAbNbt7LmG3QP22/iV3Ms=;
 b=Aj/doLyeCrpMEGsJu0mxMzp27XNdDosZqy+1dP+svFDbVvVSaOiZPcxSehhcAnNqNS
 XpyLmk37l54iqyuEGyV8rvaSk3Iib3pgzhW6IsYRphv21KIPELByRBejXBzvZF1ugouN
 Iq0PGp4M73vydjTZslVRM9mJmIEfgsMu1LW1XgPeG3E8kdggq+/HvhzOWv1hVA61pz01
 rdEHsq4DHshD+dAXliRV7OCnl4PJTEB2m6et/dgGZXw0rPL1nT15cJGrGRLaravLVDaz
 wTI6wnPrABBgg8HZaDynzQIGAkZcGENAjaMJa6YFP0civLPK/LN9Bn+fVNSHUEIFawji
 yeIQ==
X-Gm-Message-State: AOJu0Ywu4Ewj0e0bLXE/9UiHxDLHtKisYKBRRMWqKMDjNgMXWPbRaQyJ
 BwCxiM52/g8OFB6Fj3wdzpCmAFeKdF42OHxvQJhXo7oP/yPhMdlbM5FaGOHHdRD7
X-Gm-Gg: AY/fxX7pVpOwnS7v0axbWs5QMgXzit7t471mLU9EQ5ZM9GlCyfqUozEQiZ3BF3mZsUf
 Xeen5p8+ID+saL7ZKe8+g3wT7akRfRVBvuqE9beEpXftBlM76nOrhd+2jl2Rs9utOcfVzjH8YTi
 y8d5LYFgWXBhyZYQ6L0hpTFu3XCYPkhi2qkkMqag+So4v5gN86V5fj8ADijHNx963tKSxKy3cn4
 nc3s3mEzfGPMs305CJc1oB6kmiLsaIWDT3hwczr6x2cR0A+4Db20T1xQv4oB8iqLDO/f894FNq2
 9KBiO1D+6UY4Ah5gpnua+rkxsFECmAnI8HYQEZBxhhj25w4BnqbbtXLIlUzjEhD/+iWtVXd9jJn
 qkipS8uxe1W4Hjz1s5zPWUxbNBZnjk00QQ75ypJhb4lqdgTFIz1DyInTx74C3hEPWT2BZSxQsWi
 dOTM2vyylgjBFisTqRcL7Hi10GIJ2LoqnCEbHB
X-Google-Smtp-Source: AGHT+IFqJISXNjzTIDcq2qSqkrYDNITkcB/1L60n+yWQdPxBc3oTpwfCrxbfMQOE3b2115plKdM+sw==
X-Received: by 2002:a17:907:9406:b0:b73:9792:919b with SMTP id
 a640c23a62f3a-b8036f0a57bmr1551955166b.13.1766510771928; 
 Tue, 23 Dec 2025 09:26:11 -0800 (PST)
Received: from tuf-gaming ([82.78.167.169]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037a5c4dfsm1465822666b.14.2025.12.23.09.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 09:26:11 -0800 (PST)
From: =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?=
 <jean.christian.cirstea@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Jean-Christian=20C=C3=8ERSTEA?= <jean.christian.cirstea@gmail.com>
Subject: [PATCH 0/1] linux-user: allow null `pathname` for statx()/fstatat()
Date: Tue, 23 Dec 2025 19:25:47 +0200
Message-ID: <20251223172548.1847032-1-jean.christian.cirstea@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=jean.christian.cirstea@gmail.com; helo=mail-ej1-x62a.google.com
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

Since Linux 6.11, statx() and fstatat() syscalls accept a null `pathname`. Before
this patch, qemu-*-linux-user failed with EFAULT when `pathname` was specified
as NULL, even for Linux kernel hosts > 6.10. This patch fixes this issue by
checking whether `arg2` is 0. If so, don't return EFAULT, but instead perform
the appropiate syscall and let the host's kernel handle null `pathname`.

Jean-Christian CÎRSTEA (1):
  linux-user: allow null `pathname` for statx()/fstatat()

 linux-user/syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.51.0


