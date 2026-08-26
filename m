Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C60EC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBfT-0004ro-HG; Wed, 26 Aug 2026 07:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfO-0004YE-SA
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:39 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzBfL-0005lQ-Lj
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 07:19:38 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a051b737d8so1035483a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 04:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787743174; x=1788347974; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EOlP8ddaPlk71VLkEiYFvaBjk4ID6/66RcHruFcFYXo=;
 b=c5rZgDCB5qY1J7XrlCD2N5wboHAPjImyz14lk5giUfSBSQPQGbh8AKNV1m46FAsoo0
 cryN8xi5zr/TpsUc01JaeQVM5QrloamfZB6mEWaMoyMql2VwVEZAEp+PLgCRoy4rVAR9
 iArzxK8JZAe9PJuOp75JRa8+yj2lW6FJ+QlUl59nAihBjJKi0mLy9SIy1MNC0NZmM/PK
 t/RnynO43qh50jEH2pN5QRog3MX0a6+LMboJ6OQqEnxegQYlqqO7v++zOWfj/oelKdk0
 kwClfk6KQX5aZHTrPJ3oXaToJ6aEH83gp3gAFBZFIHOi4Jx2ic0iNVcPPg8OkGOpFwUf
 7AcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787743174; x=1788347974;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EOlP8ddaPlk71VLkEiYFvaBjk4ID6/66RcHruFcFYXo=;
 b=jdesFtAlL0VuO863C+/L4lqkip4Q+AidmhMnMDeeUFXsGCjXaT/XYsj8ODHTokOjKp
 nn1PpKCDYVLZvokZYeGE/LRnBbVvwdg88q9O7Zcb8Rhv72tYMmOS53zZCAogaVVMC8EI
 xlnCT6w+YkE7PxfFsveXRTslEd3vlXyL9r7N4JkSPmXEDknIN6DdnQXR6RdCH2Og/rRF
 Xu3TEJo6bwvngAcKrIOvdohYVUtIs846+43YZ4sSRVNnLBvz3pGRiNglFO4ONV+xXXKA
 OmDzKDvHJ9NAo8v/dfD7+84Rhb/LD6LWZ91GMw2Od0cTJmU4LB7EolEnrl61SSN1EIMr
 rM/A==
X-Gm-Message-State: AFuF++nxap+uoNF9Fc+UpnHn7BpSUBADbGPT5ZACgF7na8CTB1lZzhOl
 PfvKY8sTM1jJ3bEJlaeNJgwcJuj2UtuCsMPtypmralh7Dl80+xUHmbsJKGaA7HjHNG5sfX5Uwy8
 47pPN
X-Gm-Gg: AR+sD10H0KjAZLiZCRCakg0w5rnO/7SumuXkfVDVj2MraNzUQEkiAtzpgAYz9x4WQsk
 zoExut61hM/tfQy2ROlnHd0/SWPkfb7b9yq5Jw8VxV4ioTH1dne0x1Ptn0HZdFKjikaSfNelrWg
 o5x1SV8v4zDyehITxjJ5Vr4r7n5jwpawu7wUj4ylCeRRVH2zpVzN/kGoHp+A39sYL7Bs1YRvo07
 czj5DsCuVESHX4XE/wBdjb/kKoINHMQhFkv2mKEfVZkfMTlGwahRlYVyCE/MNhXxHz1xEKIL12y
 UFldwu5aFRd8rzL6q2ZjcBLAKxupHf/W8WEmX5i3Wa4mIbFgBgGZ3yTpDeyYtGVBwa/8C3CM2vt
 +bS6vcuBY6SniYQ/UPerP5imztvTrZ4nxnnB3rKMy1Fy+ON9MumvK0NvP5NrTBO4brqKXHjAAQR
 /A89M9DFC/qC180A3+ZIhVXnTotHIErbBl53j72LumJoyPyIZ5
X-Received: by 2002:a05:6402:1ed6:b0:6a3:ee65:478c with SMTP id
 4fb4d7f45d1cf-6a5df6091f2mr7507430a12.6.1787743173995; 
 Wed, 26 Aug 2026 04:19:33 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa8473sm4838366a12.21.2026.08.26.04.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 04:19:33 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Katherine Leaver <katherine.j.leaver@gmail.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 21/28] hw/ide/ahci: clear cur_cmd when the command list is
 unmapped
Date: Wed, 26 Aug 2026 13:19:08 +0200
Message-ID: <20260826111915.3387926-12-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826111915.3387926-1-den@openvz.org>
References: <20260826111524.3383479-1-den@openvz.org>
 <20260826111915.3387926-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=den@openvz.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

ahci_unmap_clb_address() drops the CLB mapping but leaves cur_cmd
pointing into it. The cancel added by commit d9f78431d8 covers the
buffered reads, and ide_cancel_dma_sync() drains bus->dma->aiocb, but
neither reaches IDEState::pio_aiocb: a PIO write started before the
guest cleared PxCMD.ST completes afterwards and runs its second DRQ
phase against the stale header.

That is harmless while the CLB is direct RAM, because unmapping it
changes nothing. It is a use-after-free once PxCLB points at an MMIO
region, where address_space_map() hands out a bounce buffer that
dma_memory_unmap() then frees.

Clear cur_cmd after the cancel, so nothing reachable from a later
completion still refers to the freed mapping.

Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3719
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4043
Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/ahci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 995b40efd5..4c138b0c51 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -743,6 +743,12 @@ static void ahci_unmap_clb_address(AHCIDevice *ad)
     /* Cancel in-flight reads that would complete against a cleared cur_cmd. */
     ide_cancel_dma_sync(ide_bus_active_if(&ad->port));
 
+    /*
+     * Whatever survives the cancel must not be left pointing into the
+     * mapping this function is about to drop.
+     */
+    ad->cur_cmd = NULL;
+
     if (ad->lst == NULL) {
         trace_ahci_unmap_clb_address_null(ad->hba, ad->port_no);
         return;
-- 
2.53.0


