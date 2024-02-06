Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D62C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 23:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXUn9-0002BL-MT; Tue, 06 Feb 2024 18:23:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3fr_CZQwKCj0mZahgdrsdeZmfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--nabihestefan.bounces.google.com>)
 id 1rXUn5-00029i-1S
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:23:47 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3fr_CZQwKCj0mZahgdrsdeZmfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--nabihestefan.bounces.google.com>)
 id 1rXUn3-0006WO-AV
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:23:46 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5ee22efe5eeso639207b3.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 15:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1707261822; x=1707866622; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Q4joH6qxgZL675hV+mshQF+wvkCtYa09lcCu1PX3ELY=;
 b=fRolq+AD3xJigPkRDQwSPcmP92fSO+Eo44XW3DURCbJJWnlMV6cawk5DokTe+RCzrA
 zuos159VXlyyqu4JjPAj0IlvdJd4Y2+XyId4Ys0lUBAe/AiXPsmkTZyKz/AEu+Fg9ALk
 GI45uLZKj2SqR3wDfvqzuNkUlymFiXc2KEbWVW80lLia/I1g89ClBHNEOHe3dfTD47z5
 FrjHszmU1B0Qh0E3O1QgH/BY4fOEIGNnWQe6hUC9iL+N2PPc4j27UnwMd6Z3zYVb1YAp
 UiuELFk9VhEDs4pSXiTt2OKRG7KO0Kz9mZ/shTY83HwdZaMCAZIRdywpZxSi+zoudswe
 7QOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707261822; x=1707866622;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q4joH6qxgZL675hV+mshQF+wvkCtYa09lcCu1PX3ELY=;
 b=Otv1Hmo8QwRZOLwTk+/hWBIhKMqOoCGXO7c9acahDoSgYGfksFxHlpyVoGh917YUn9
 xE5sfxgDd86hzPjZCAsHvrwiDsFO95FtRjs7rBK5sJrQNom6uNAqU30OnRKT6coRRpTX
 qgwpi1rqJhiGZfGN1wfjGc2GN28cvvXUZB9u1ZqUz5/BYtGouKbSgD+JRpJ4qIvQ1sDv
 VbJBCsWqBSrERQ8LUBXnj+pPMjfgdKWuPZgY9zFCHQCyciplATM8sfHkeeqonn/PuUuJ
 UHn2lZraOoPqqnV+xjWgEp3QGnwQz2EFBHhWy4iX7ilebZkWiQlUZk/vT7yVgPDm5N+e
 LGEA==
X-Gm-Message-State: AOJu0YzQ4zucdprXP4DcQ+TQT1+wa3UqFvM9Qc0aqweQ3JavZXk+Gau5
 ZBkdO+0o6NdsttPwA0tS7Yu019Qib3O9OBAB4ERgyyxr7S3rSLrZOQoknn8Q4lw7HG9J1CvSkvA
 uoxU7CdaoAPp9je4IRJ7fTAx1wQ==
X-Google-Smtp-Source: AGHT+IHip67WVnoxLNpYDvctZWjEISLUQamIFC2oRmusAnhIFftMYpwLAtZaQ2yxV1EFHkzn3HbIFw9k4G7XCiGLZes=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a05:690c:86:b0:604:b83:9cad with SMTP
 id be6-20020a05690c008600b006040b839cadmr559640ywb.5.1707261822165; Tue, 06
 Feb 2024 15:23:42 -0800 (PST)
Date: Tue,  6 Feb 2024 23:23:36 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206232337.1043760-1-nabihestefan@google.com>
Subject: [PATCH 0/1] Sending small fix for NPCM GMAC test to properly test on
 Nuvoton 7xx
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3fr_CZQwKCj0mZahgdrsdeZmfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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


Nabih Estefan (1):
  tests/qtest: Fixing GMAC test to run in 7xx

 tests/qtest/meson.build      |  4 ++--
 tests/qtest/npcm_gmac-test.c | 12 ++----------
 2 files changed, 4 insertions(+), 12 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


