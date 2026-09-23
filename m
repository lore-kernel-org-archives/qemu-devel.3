Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5734CC98310
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Mxu-0001UC-DL; Wed, 23 Sep 2026 09:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9Mub-0002Z2-Va
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:21:28 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x9MuZ-0007Wm-7d
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:21:25 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-33e630052ebso1068563eec.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790169682; x=1790774482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xe2eD+AiZP/2qt9dfiB6B/fVlOtPvZaEy5H5CusisPI=;
 b=ISDxkOYTPDaASlcP4zOcoY8de5QeJmxKf5mMO5xam3lfBn1l6QnVf3iCD6zpj1xyS0
 yrGM/jRk3xhG4WijwB9og7rluwDNea8y1P2YHaeHIaKXQhdQoCHEWUdKdJlAURP1U0aq
 MDg7unAAPYKEB4dyoFZxO5D1/jKIKPsqfZKQgQn8DQWsm78PnTkuadNkcFM+VoJXtyIs
 sIVlLhx46jKpA5YvD7rAs+AsD9WSqd8xuIP4UVTzueVQZHEOkw0MpzJIyfKL6yM3Cl3M
 v2NtDt+nFeo4VzqpZBFGzqy2tANC8cFYmAbI96fzYPwZup7pPcddpC3sNxWztwrmnYsH
 B3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790169682; x=1790774482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xe2eD+AiZP/2qt9dfiB6B/fVlOtPvZaEy5H5CusisPI=;
 b=cpMHu6rY8LrU03aieq56w4HMx5KlWr+MqnxP3Bx48HBLCKiZ140KvvLDhH6ysm2l6n
 6p8EigqMEGtUcfpPAVJ6kfXwsgttBPKLQKKEqaKRvTnNJhzHtvH4d7iwP1Bh7732gQjX
 3kAc8V7avZw1Q91nXmoyC4mOebOegZmuwvFJV2dPZBTKiw7irkBLlos+TuymcempHGI0
 MXxPaesEYtaivulMJZewDiUKsrCfhAJsbXvPH+C0sa2VhBVyNhNPR4N3SzGlxq2NRC7m
 REP9XdKMhue+QPuPUafTK4m8h1fcpYFajV6Y+3rw/qGj9TKV29LRURwaCc5AdgcEmmmR
 xkaw==
X-Gm-Message-State: AFuF++kSqshsHdI+TG6ZuhxDkiCle3wGInCl5AVPZVR++Lzz+Pwa5/pm
 CVcmoWPhseFrb9epsGWMT4hd62PFFJpFm4d4ny/fG1vcQssWjb3uuBhE8jX9hvjpz2c=
X-Gm-Gg: AYBFou06jhsJy6/f8TJoH/gR0RJVFa79TN8wdGBj0X/3wT0Pp5cqqz0EE3eQmDahur4
 joMoZr3bKeCr1Gmhzta5SAilkvYHjfwjIW9jq2jnNvGUXM+DoUAgCl/pG9cJQmvyA8RrFioyvM4
 TXvKae6MzvYk1cXnP53OtDg1eTe812bmNHBy4XPtQbkcxUnHmnWWxXpC1Gc/DVjQAT0/FJK5R43
 YikBzPeqPpxBU0FcLZ0jJVQ4Nhr3H6SxBonMsR9YtH1Ztzxa5hD6liveWuIOSW+55GMrx6iQU8l
 DLrp85QZpV2HTib+u32Ni9JDtohQ6S8oVTc84HH5V39OI3AVDf2j2bPP8lK6jrU8ciVtAOoI+0g
 US5E6YR/LVdwIYhyOGHbV4EndnoOAJZFPQzrXouGV8VigB9robv1MeW8OzgeyPO1eXMzs13dhwA
 LLemRV7v/6GIGDzpfZkyhRaaQn3prOEmLy86SRISoncOsdbgcmTvWslIFdHs5aaEZ5hmq1MobbL
 en2shFD/f1ZWdjp6L8kWYBrKfjPwq63SfB657sPMg==
X-Received: by 2002:a05:7300:8242:b0:339:7909:9782 with SMTP id
 5a478bee46e88-33e8d9ce7f9mr2561360eec.21.1790169681656; 
 Wed, 23 Sep 2026 06:21:21 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:21:19 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, xen-devel@lists.xenproject.org,
 Chao Liu <chao.liu@processmission.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Fabiano Rosas <farosas@suse.de>, Xianglai Li <lixianglai@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 kvm@vger.kernel.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Song Gao <17746591750@163.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 026/114] hw/intc: use target_long_bits in IMSIC geilen
Date: Wed, 23 Sep 2026 21:15:00 +0800
Message-ID: <20260923131635.1894-27-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- Compare geilen to target_long_bits() instead of TARGET_LONG_BITS so
  the check works when TARGET_* is poisoned.
---
 hw/intc/riscv_imsic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index bf0434e96fd..30fb60cc312 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -52,7 +52,7 @@ static void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
         return;
     }
 
-    if (geilen > (TARGET_LONG_BITS - 1)) {
+    if (geilen > (target_long_bits() - 1)) {
         return;
     }
 
-- 
2.52.0.windows.1


