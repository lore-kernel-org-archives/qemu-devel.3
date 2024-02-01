Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53370C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 14:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVXd7-0000Uy-TA; Thu, 01 Feb 2024 09:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVXcu-0000R5-Q5; Thu, 01 Feb 2024 09:01:12 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVXcq-0005Kl-Gv; Thu, 01 Feb 2024 09:01:12 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a2f79e79f0cso123205366b.2; 
 Thu, 01 Feb 2024 06:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706796066; x=1707400866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U7XjHbwwvWEkeLfzO8kMCvPK8+1IkX1iR4uHS3wTHDo=;
 b=h5ayomFL0eQ7fA/lcRucDMJWWtNIkm6WDQgPeeO0gBeXwQ42XJY4wwyFTb5UgCSnOq
 52LoZw4dJkk8Hh4xOS8BSB5N6MyNAWSmf7Bf3OA/pd1tkActgiKspTSvtO31lNUZEisc
 1ifPk74yuxyX+0cx3EKHbhHDzFTwoupHHH+hXCQuBgo47PMNOOh65qVALG1vsV3GXUD1
 W/DeWtxPniqlOdCOXpF+Kzu2jefI4VNWh0xhqUE/eIXaNERW2/g/5ttoWnJoJeJfiIga
 D9IoHxUaLWT/rpABKIIEo9n/JVGIHYsxHB+RGaXKPMULTt84pwRvPCYrnQVXOiYDAPNR
 cHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706796066; x=1707400866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U7XjHbwwvWEkeLfzO8kMCvPK8+1IkX1iR4uHS3wTHDo=;
 b=u7jOMbGCekj5+KeVzLuIYW5mRPb+XhbMSOXROkH4ltx1EgWIjA/X3cRLsmADmsAQyE
 j/U6Ynm+6aBLUk1nTFvvim/LvFSowFmFQwjULnP7zQHZo+WjbSCa3N4mfD4XRzsVUapY
 dnfjsQEnFKhyfVMUeaT7Byd23SWEL76Hg2No3TcQXuNeFS7AKIO+51Dj70Y1rw0cWsV6
 Wb96kLprBRdm5ASJPS7i/Qz4rneXwALT2ECzySBH//j0iREtLC5EA/fdsCvn/Eryau/S
 eG18VDiQ7AWCcQLlzy+5WQylzTTO0USqt1z/eFtLcooZKe5Mkrsq/i+4NLExNxowO2tT
 Itsg==
X-Gm-Message-State: AOJu0Yz+yMgKvq9HUfWYkfaTnglE+zWeJmts5CKuauaem5bubLiaQmhO
 i0x0+7wCYE9qRLTE7lnDfLpxUsVIQqq8XebPlmjk0uLLTCeqexhM
X-Google-Smtp-Source: AGHT+IHRwBo+FTRI1v0U6rE5ApNlVnbyhdkseHsTT3BvavWLTlFTsq1Vd22suMjWf0cuvGDaAIB7IQ==
X-Received: by 2002:a17:906:3b19:b0:a35:7192:1f with SMTP id
 g25-20020a1709063b1900b00a357192001fmr3724841ejf.49.1706796061091; 
 Thu, 01 Feb 2024 06:01:01 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXlDpHbq7DlTy9b/4dNfR+ZoQZ3h96n0KS/ztheCBsWdf0EGcvQHFxArjD4D4t1JElDnP75BtzOJ/Ma+GhgLVmcXUCrn6i5oaAg8quyDi4DlKHuwRAZUe+1bWDBg4Wb8aXRnTt5IGpmhjKlTo5I7or/tewNEMRE+LpB8XJt7fzko8goP0ncXZg5K6VuTw/GzmyAo25PkfGXHZhdqeszXGuBsAjhTV1V9Tn06aeGDNg2773rWVRvPGV8xaWN8WkzCAGA+UWVX1f/5pTrIIn6utu4EY3bKY66HafwEPRGg0WG3o/VIpmKv1Mwe/Y1iGi5PjJpZctEwWifTjJRv9pRYiTs
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 un6-20020a170907cb8600b00a36a7f0f087sm902728ejc.222.2024.02.01.06.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 06:01:00 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v6 0/6] Pointer Masking update for Zjpm v0.8
Date: Thu,  1 Feb 2024 14:00:41 +0000
Message-Id: <20240201140047.3456114-1-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_POST=0.693, TVD_PH_BODY_META_ALL=2.546,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Hi,

This patch series is rebased on https://github.com/alistair23/qemu/tree/riscv-to-apply.next 

Thanks

[v5]:
This patch series targets Zjpm v0.8 extension.
The spec itself could be found here: https://github.com/riscv/riscv-j-extension/blob/8088461d8d66a7676872b61c908cbeb7cf5c5d1d/zjpm-spec.pdf
This patch series is updated after the suggested comments:
- add "x-" to the extension names to indicate experimental

[v4]:
Patch series updated after the suggested comments:
- removed J-letter extension as it's unused
- renamed and fixed function to detect if address should be sign-extended
- zeroed unused context variables and moved computation logic to another patch
- bumped pointer masking version_id and minimum_version_id by 1

[v3]:
There patches are updated after Richard's comments:
- moved new tb flags to the end
- used tcg_gen_(s)extract to get the final address
- properly handle CONFIG_USER_ONLY

[v2]:
As per Richard's suggestion I made pmm field part of tb_flags.
It allowed to get rid of global variable to store pmlen.
Also it allowed to simplify all the machinery around it.

[v1]:
It looks like Zjpm v0.8 is almost frozen and we don't expect it change drastically anymore.
Compared to the original implementation with explicit base and mask CSRs, we now only have
several fixed options for number of masked bits which are set using existing CSRs.
The changes have been tested with handwritten assembly tests and LLVM HWASAN
test suite.

Alexey Baturo (6):
  target/riscv: Remove obsolete pointer masking extension code.
  target/riscv: Add new CSR fields for S{sn,mn,m}pm extensions as part
    of Zjpm v0.8
  target/riscv: Add helper functions to calculate current number of
    masked bits for pointer masking
  target/riscv: Add pointer masking tb flags
  target/riscv: Update address modify functions to take into account
    pointer masking
  target/riscv: Enable updates for pointer masking variables and thus
    enable pointer masking extension

 target/riscv/cpu.c           | 22 ++++----
 target/riscv/cpu.h           | 47 ++++++++---------
 target/riscv/cpu_bits.h      | 90 ++-------------------------------
 target/riscv/cpu_cfg.h       |  3 ++
 target/riscv/cpu_helper.c    | 97 ++++++++++++++++++++----------------
 target/riscv/csr.c           | 41 ++++-----------
 target/riscv/machine.c       | 22 +++-----
 target/riscv/pmp.c           | 13 +++--
 target/riscv/pmp.h           | 11 ++--
 target/riscv/tcg/tcg-cpu.c   |  5 +-
 target/riscv/translate.c     | 46 +++++++----------
 target/riscv/vector_helper.c | 15 +++++-
 12 files changed, 160 insertions(+), 252 deletions(-)

-- 
2.34.1


