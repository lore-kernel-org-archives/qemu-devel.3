Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6C7CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENXe-0001Jm-DY; Wed, 07 Oct 2026 05:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEKjZ-0001oF-TJ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:02:52 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEKjR-0001Rw-KQ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:02:31 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 69761tqL048409
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 7 Oct 2026 15:02:01 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=KgLaGwzpffAEtPsyT40xetrRoR43bW6muopW6J6sCDQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1791352921; v=1;
 b=pJ7tOpcI97OHwIlROrQq4Am0MUMEyyTWS7u4nd8G9ox7OWrcRhOS4RFtugcuT1mA
 crs4eksmyoxeq8xlNUP0T94KQfRoHKw7xewQ/Aqr5dWOxDzLGJD90us6YoIhhv84
 TEBtjYZGs9BFITPiyrlmBpFjutUlnvZ981Ykj7XVgrpLIrMUecd83fQZJhA/+SUZ
 eo7onXRdfzjnrnb3hngMTo0/W1iSf1vuoCXRezzhls6Ii8oOcD0R2oiic307kOCs
 +n4Le4lR7z1Hg4AK5tjINNfTbLc0rWfEMvPs1SzpERO/ztkisJ+jcoTCItU5s+FK
 JHXsnaRbqXk866po4Cga3A==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 0/2] contrib/plugins/bbv: Add region-of-interest selection
Date: Wed, 07 Oct 2026 15:01:48 +0900
Message-Id: <20261007-bbv-v1-0-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ5AMBCE4VeRPWtSWxG8ijgog3VAWkQi3l1x/
 JJ/5iIPJ/BURhc5HOJlmQOSOKJ2bOYBSrpgYs1ZojUraw8FhgHr1ORcUChXh17O76Wqf/vdTmi
 3d0r3/QC08i1xZwAAAA==
X-Change-ID: 20261002-bbv-e2e3e2043829
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=wQ/NlRGwtAaS3GD5ZvzPpE5nCZ78wnFehBcamkomB0w=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bRB/7hce/m21nmLX3/bfPe7b33Zl8N33tk5sFfca+s+
 rrudE9w6ChlYRDjYpAVU2RJKdrNrRFd+6kwIb4FZg4rE8gQBi5OAZjIw2uMDM3h+QUzqky2zFhX
 nBDElW0q9YU5YUPpw117nzUXaz2T2MnIcGnR64Wrz9vEsjOu0408ZhS/ePuh0lP8Hu173S6FPJs
 7kwEA
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

Benchmarks can spend more time parsing input or initializing state than
running the computation of interest. Generating basic block vectors for
the whole execution can therefore give these setup phases too much
weight in SimPoint analysis.

This series adds optional begin=A and end=A markers to control BBV
generation using guest instruction virtual addresses. Omitting begin
starts generation at program startup; omitting end leaves it enabled
until program exit. The markers let users focus collection on a region
of interest.

The first patch rejects non-positive intervals and values with trailing
non-digit characters. The second adds the ROI options and documents
their use.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Akihiko Odaki (2):
      contrib/plugins/bbv.c: Reject invalid intervals
      contrib/plugins/bbv.c: Allow selecting ROI

 docs/about/emulation.rst |  8 +++++
 contrib/plugins/bbv.c    | 93 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 97 insertions(+), 4 deletions(-)
---
base-commit: f7ada39edacaa5c26b30e98b94017b0b2ccbcf94
change-id: 20261002-bbv-e2e3e2043829

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


