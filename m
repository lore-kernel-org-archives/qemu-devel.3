Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE3F606A32C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nUGVX3Bj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP2km-0004qQ-VO; Thu, 05 Nov 2026 14:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2kg-0004qA-ML
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:04:00 -0500
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2ke-0003kI-Gg
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:03:57 -0500
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-36cad25b8b0so3327305eec.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793905435; x=1794510235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rvXH/mY0k5x15Ps4VL487FrGx/knJKjiaXJT4zsxitk=;
 b=nUGVX3BjlekOVaDVMjR9nfIvHafT3DAj0kYSmkafg4/07mr2o5V4n9UlACXKLK5ItT
 3pVGhOo4O/2sCsP1WUwJBMi0SrtNPSV17DVxQOnXcK8qX5N6HWvbXDLOMNr6SEvCfFwl
 zKYvkUCTMcNnc2qIfqBaGa+pA/wL7bAj9IT54UyviSkI3EWTqEujp5qdz7Xx88jd9yJ4
 KUxZ+6dHWFmUYhbGPd8ubKckd8IWQCezfMOeorLdpI34P0QV9MUa3HN08wL3lrORPytq
 L9ZblISO5oKwnTGoGpt1a45SRIBwoFlBNZEw5YqEIFwf3ErRvGPhoYwr4/W/irJkhtmK
 UAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793905435; x=1794510235;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rvXH/mY0k5x15Ps4VL487FrGx/knJKjiaXJT4zsxitk=;
 b=zDHOSfemJX8t4rLN7ax8f0P8hUQN1T0J2NANm9IzqXDojG2TOZT9YwEJQpC/PKOcUt
 sbw+bapjFlxn7G8wv2aGvbYcjxXRBw1Eb8a/0vCSKgTAeUbSLXuDSxtUkNI05vHHPfk1
 joB7j6huAbNVUIwyHvxZEf7AsjmH/Ralzl7/Es3BF41P76O4vjMThpO7E4vUB1PctXyh
 QXV8UPBg9QpDfkLrPaiI8F/l9ZkRI4Fm29R7v533La5LiDcGRBRSz9CcH5NlmOfpnC3M
 K+wtV9mNepzHo17Nex2chQaw9qMwjTmVmH4NurGng9PhU4t9fFJUdqCgg5Zel+i5wsPm
 Bw7A==
X-Gm-Message-State: APuU4Z+rw3dbhQvlz8b8dwjrXIf4B6AbR3e/3EwLyhlXYAB9ReXWAx4L
 zxCvv9rF7iYOzLoYkmyAikd4ij88DRzqm4R4TNUR6/fkJ1p5idNmNKVhtvvFNDgwHkM=
X-Gm-Gg: AYBFou2tlH4+vNY0Rg3wh6c9EJkrqjBJGQMFA3ir/mZHv2Xx2MyY+2Qkrh3lsLe+nUy
 khSAKBtEyPm0qSV3PYzrtKUet0GiUC/YIf13tzwjCnjh/2ETAEEvQWyUjVUuCG/QbUyXg5Wd+xx
 8ByY1X6gTW/kb1PrR/zdlfQTZtNvMR1kyFRlrn2Zh8dSTtXQLXC8AUgfTPmg8s7xsYr93uFAQVN
 WLvpdVs49sDYAPVgIidrbYEpg7qMlfeHg7XU/2OLUSqDwbXV2NRAPdUhtQ8U2P4u+8kZwtoeCA1
 mPlZe4V6ZUSx8aLQxp6jxVuy3EDaXRs+EAaOowgStCxF+UuJgf54asLIfxCdZLrcgQO1f4bWe72
 xc85KYsDN9/y0TRetI3V0+aXSRU5wyZCEfaGXu62f1UZlKhiU8ve66VHt7ukWSNe88Wi9EuBAA4
 5ts2B/C2lZQQ6qW3rp3dqylWUFd5BvWsuCmMb/TClA/cqMt4RLzfoDSzhiDtSGLp6jm09trR3ig
 LPfboRMQNaunbdNT774Dmc/NKyaxnN6DgI4s6EudXT12mp7LFGj00j2JsPk2KTF6r4HgeNC3Y7n
 Amn8F0rcOm4whekX4Olsk7JT2ZtWDyY2r43ltnx3ZbB8La68iy6wvMn/Mss/aD6Uc5TW6A==
X-Received: by 2002:a05:7022:f513:b0:185:8c9f:de82 with SMTP id
 a92af1059eb24-1ac5e8deb47mr24053164c88.33.1793905434325; 
 Thu, 05 Nov 2026 11:03:54 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1b245c4706bsm22924284c88.15.2026.11.05.11.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:03:53 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>
Subject: [PATCH 0/5] qom: prepare a TypeBucket for same-name target variants
Date: Fri,  6 Nov 2026 03:03:41 +0800
Message-ID: <20261105190346.1539-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x132c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series prepares QOM to hold more than one TypeImpl under the same name, one
per target, so a multi-target binary can register same-name types without
renaming them. Nothing uses it yet.

type_table maps each name to a TypeBucket, which holds the variants and the
union of their QEMU_ARCH_* masks. Registration still aborts when masks overlap,
and a name lookup returns the one variant left for the selected target.
type_register_targets() registers a variant for a target mask.
type_register_static() is unchanged, so binaries keep one TypeImpl per name.

The change stays in qom and target-info and does not conflict with the virt QOM
name or is_available series.

Daniel asked what a TypeBucket means. This is that prototype, based on the
bucket idea from Pierrick.

Daniel: what a TypeBucket means:
Link: https://lore.kernel.org/qemu-devel/auyP09mbwuefulBL@redhat.com/

Pierrick: register types per target bucket:
Link: https://lore.kernel.org/qemu-devel/d754acaa-0811-4185-a78f-1a352ec8bbab@oss.qualcomm.com/

Pierrick: the bucket work can proceed in parallel:
Link: https://lore.kernel.org/qemu-devel/CAE2XoE-iOCdGxPtg7MqydmahpnOTFM_15dR0eJKGMrQKxrgeQQ@mail.gmail.com/

Yonggang Luo (5):
  qom: store registration targets on TypeImpl
  target-info: add target_mask_selected()
  qom: add target_mask_filter()
  qom: filter type lookup with TypeBucket
  qom: add type_register_targets()

 include/qemu/target-info-init.h |  15 ++-
 include/qemu/target-info.h      |   9 ++
 include/qom/object.h            |  12 +++
 qom/object.c                    | 168 ++++++++++++++++++++++++++------
 stubs/meson.build               |   1 +
 stubs/target-mask-selected.c    |  13 +++
 target-info-def.c               |   3 +
 target-info-qom.c               |  10 ++
 8 files changed, 197 insertions(+), 34 deletions(-)
 create mode 100644 stubs/target-mask-selected.c

-- 
2.55.0.windows.3


