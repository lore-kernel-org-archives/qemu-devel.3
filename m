Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED93C44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 17:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkmc7-00018O-7k; Fri, 17 Jul 2026 13:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wkmc5-00017v-Gc; Fri, 17 Jul 2026 13:44:41 -0400
Received: from m16.mail.163.com ([117.135.210.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtao0430@163.com>)
 id 1wkmc1-0002Vz-9C; Fri, 17 Jul 2026 13:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=yh
 H6GOAIVK5s4M8vN29Uja9Jk9Ng/FYWWqOE2FP4K9s=; b=en7ZxgU98Izhx1Iiul
 ZzZt7b+Gdas1KQsm7rUTuDULMBj4EJPdVkVLfRfax1ibqhmwc7gBniq6hD0Qjs9h
 HC3uWukBq0BjambEWR/uMnH/ZE66r3Caau1YRyhyzz87y00EDt6rXxQ1EXAxQREX
 h0R866qjWcrXrAtkPSaS0m6+g=
Received: from dt-VM.localdomain (unknown [])
 by gzsmtp1 (Coremail) with SMTP id PCgvCgA3K23uaVpqrimnGg--.13203S2;
 Sat, 18 Jul 2026 01:44:14 +0800 (CST)
From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Tao Ding <dingtao0430@163.com>
Subject: [PATCH 0/1] Aarch32 TCG CPU: secure register migration
Date: Sat, 18 Jul 2026 01:44:11 +0800
Message-ID: <20260717174412.88258-1-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PCgvCgA3K23uaVpqrimnGg--.13203S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr1fuw48trW3Xw1xKF47CFg_yoWxZrg_Gr
 40kFyxJ34kZFWDuasFkrnYvrWfWa18Kr13W3W5trnrXryUJF13Kr4DCa4rXa18JFs0krWr
 JrnFqrs3urya9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUIJPJUUUUU==
X-Originating-IP: [119.4.20.225]
X-CM-SenderInfo: pglqw3tdrqkjqq6rljoofrz/xtbC-g-GBWpaae8AagAA3u
Received-SPF: pass client-ip=117.135.210.2; envelope-from=dingtao0430@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_MSPIKE_H2=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Hi, all

In TCG mode, the xilinx-zynq-a9 board cannot recover normally 
after migration during the uboot phase. Some secure registers 
did not recover their correct values after migration, causing 
the CPU to enter an abnormal state.

I have also submitted this issue:
https://gitlab.com/qemu-project/qemu/-/work_items/4037

In this patch, fixed the issue of aarch32 CPU secure register 
recovery.

Thanks.

Tao Ding (1):
  aarch32 cpu secure register tcg migration

 target/arm/cpregs.h | 11 +++++++++++
 target/arm/helper.c | 14 ++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)


base-commit: 5ef0ecc5942ee07bb581cc96a97bbfc0fdf4005c
-- 
2.43.0


