Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0D7CED241
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 21:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxv6I-0007xl-SQ; Mon, 07 Oct 2024 17:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sxv64-0007sc-2e
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:16:52 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sxv62-00011R-GU
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:16:51 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5399675e14cso5632527e87.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 14:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728335807; x=1728940607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WTsx4tGg+0BZ0batbq5fRRa5gbLdHaXOR3GOVsVa/MI=;
 b=eIuvnJn7CnDCyavwrnfYvGjAObLHNyJbORr4w6VnOrolFRrVWWVvpYj1sfeDpAl+06
 Cj/Uc5HuVUqQ/v+Zx6B4haujzAydnZJf0aUhh3LqC/9FzPzRfZlzJB78SoPtTzuI+dCt
 7fu5a/gv0WSWb0SPAbzCP6QdhdNNXlICzSmDtb1hdeN6B1vHNcvcXqFy0FUFNrdYw13W
 PxfpOITCwq2N0XvaKheo4cDsgsqDzCQuEFjtkMzqJpseIJdhZTASuhSDmBWdukmfyazz
 u3NxEZKmk9z4ZZr6ms103w4zSAQ67yeyqtXcIMET7uaWpYElA7vK67oeZQeO75LfwdVi
 Wtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728335807; x=1728940607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WTsx4tGg+0BZ0batbq5fRRa5gbLdHaXOR3GOVsVa/MI=;
 b=bA6wvseMZn48VGSgFqDSG30oMlK9xoGCO33VV2pvZnez1hf62GBJyrSp8FIMQipP/+
 hEEn9vowFful1s540Jc4RyAjIbHaZAcC542TqqSSr6WPFKyiSJzVnGH8zrmJhhyeOQhP
 HKW6Kgk3LKyW4NCBTTHxs5yFdK5XUtV4Po3kMZwNFTbXyb6I2lXeOPQ9ZnKxKiYRU8HL
 28axQZJHX5iMIxQ57FWDjY8Qi/Bmdp8yxEhgAdHp37D9VwluNqykgi3FX6ZQ1CBKn0fn
 hpcheJdgPEh+tZOLbmCuvEFkAPQPeTp9ONAK9fuPrjzvcd1LFIDSRcPDKGsnimaLjTF+
 gpFQ==
X-Gm-Message-State: AOJu0YxFbZuSx96uoo+nwjlL5xbPrkIYAqZGIYuysPmLfupUdy0yP8r9
 b+UpSDqBwJoFrckIGYicrDYNjR9A1Ly7SdOnaN0QxNXpaRwyiZZc1PQsLWCE
X-Google-Smtp-Source: AGHT+IHM96Ou/Yg0S6T+8VUjhm8uxhY/cn7FmBubowF4/pRcTBUlupijb+NR9My3MkGaQGgdakpFhQ==
X-Received: by 2002:a05:6512:ba2:b0:536:9f02:17b4 with SMTP id
 2adb3069b0e04-539ab9cf41bmr6550868e87.40.1728335806821; 
 Mon, 07 Oct 2024 14:16:46 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539aff1d1f3sm940665e87.153.2024.10.07.14.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 14:16:46 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: [PATCH v1 0/1] hw/xen: Avoid Avoid use of uninitialized
 bufioreq_evtchn
Date: Mon,  7 Oct 2024 23:16:41 +0200
Message-ID: <20241007211643.1572271-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x136.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

This has a fix for Coverity CID 1563383 reported by Peter.

Avoid use of uninitialized bufioreq_evtchn. It should only
be used if buffered IOREQs are enabled.

Cheers,
Edgar

Edgar E. Iglesias (1):
  hw/xen: Avoid use of uninitialized bufioreq_evtchn

 hw/xen/xen-hvm-common.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.43.0


