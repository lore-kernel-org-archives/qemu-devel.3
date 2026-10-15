Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D05CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPtC-0003lY-FL; Thu, 15 Oct 2026 14:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPt3-0003k6-71
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:05 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPt1-0000zh-Nc
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:04 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a17baef589so21968815e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792087742; x=1792692542; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J8Og+Tt471TfOsQyGsjnZ4DFD7n2DfoB/3flIOgIsX8=;
 b=DPC0zwU8bwzVwpY/1M3F1s/Wgd5+j56uYDY15VZBO0pyb10s/R7YgxYCOWHKTzR3nd
 z8u8r5/SNabcH/mT18koDZgPSG8Eg8I29UkPFVv46FYnuxyi7DT/AAGAM+FR/INr3AFm
 4truoPXVHLWI44BlolY3mRQXdANw3aehwhm6JevRt0iUGdWptxQvZGAUCwtgZb9ZjgPu
 BrU4qVbf/U4bavSweYmatHlVWq6qXqkEx3Nfo1XvtHY4iLSrcCC8Dpynb9UMTn2PcCjA
 crkRJiW239VZlyqO7WueJuiCRoblZGYR5nsw925I66LtLThpBGOSlZsRdwp9jlyY3Y7z
 PXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087742; x=1792692542;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J8Og+Tt471TfOsQyGsjnZ4DFD7n2DfoB/3flIOgIsX8=;
 b=Rg+dQUPMvVNlBRSTTEbbHobXmbPVuiyBqUY0EZKJAxIKQUwRAN0AKRLyoqMts6gmJu
 /mSZ81ReBc9Anwhyu5+2EDOk61HSFwHRzyT5MOOhH0Zikg0QKyWQN2a6s21LldiF8o7F
 XCIpLDyhy2cPBW7Bp7TVb6RIt6YwWWn/w/5XtcHLM49TvnmA79LQrrDP4gfrHaaX48QU
 rJlbp6JOkMcf1URiDWdGaViUE9XIjJzoFM5x9VJaS6mst+I6Mfel7TF13rsGPUs/N43+
 6UVc6j1Bz9XRbTL5iSVtNGEcC0AvbmZb5oAELk+sU2TEYHbXHBfencO+Oi7W7PEltC8y
 52aA==
X-Gm-Message-State: AFq9FYLIZ+3yMJs+/ZTMH3flwlJwQciPYHc+QZKTas03foCc9T1t1dfw
 Nzfd/9NyH74L5FfyuuES1AIT9aW0rr0qoMIeGcQHXHzOswr9Wre/PggGx4z+UcjStzds1QpbCQL
 CIvY28Ec=
X-Gm-Gg: AYBFou1GCvrl+gHDVRJfAA0cYauRsxix9OyKD0NYfxUExz4frt4GNaYQrt1wlIdiVSe
 h3KI4KHLqBEhLlAXjiU0tyio+26bTGM3lY398HuAoOgVLC4yEDloTsVbFwMwhYYU1iEnS6td4Um
 EjYdwtCBlpQHQilk55mnfuoEs0dbr2UXyLZfrpTat5emHGwBoKbOyFIhkMGKZOR2V2JXGHCY0X6
 tP8rrb717r9h10qxeS7w9fmxRG89LzeA7u2OQOuEfILwy53O1mlaGeWz4ucLpvPd/+WHYTMQ7Ln
 0d6hwGF8U6yEtyzTJxvxMrNMDgC1nbEmt6MTy04a0zv8oMHrPkt0x/O2TLjdycpnPVEF/S69FHQ
 6PfLTHhSJcA63xVHBHYKTKPlZXcW1jeAOI4iIHTg0BBWj/RpwlzME9dtRExEppo+bTcDHACQfCg
 u4bZPy6HEdMO2YVw4B7EDfFAyPzRqrPVpqVy2fiBJAGz1g5jceE15yEzDgRMmNufzkz4sC/f5KD
 LS+Nwg+uv1CUccANhqzcqCi8eghs46xD/YL6b/YjszqqlHjqX7Bet7Ex/73NM7B4vXIX5j+yHqN
 6E4=
X-Received: by 2002:a05:600c:1d11:b0:4a0:25db:4591 with SMTP id
 5b1f17b1804b1-4a18e4a4c33mr427166775e9.23.1792087742206; 
 Thu, 15 Oct 2026 11:09:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm14692701f8f.13.2026.10.15.11.09.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:09:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/16] hw/arm/virt: Use TAG_GRANULE when creating tag memory
Date: Thu, 15 Oct 2026 19:08:44 +0100
Message-ID: <20261015180858.1863407-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015180858.1863407-1-peter.maydell@linaro.org>
References: <20261015180858.1863407-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Gustavo Romero <gromero@redhat.com>

Use TAG_GRANULE definition when creating the memory region where the
FEAT_MTE tags are stored.

Signed-off-by: Gustavo Romero <gromero@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20261009121545.241772-1-gromero@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9d192515d85..0d56197dace 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2308,8 +2308,10 @@ static void create_tag_ram(MemoryRegion *tag_sysmem,
 {
     MemoryRegion *tagram = g_new(MemoryRegion, 1);
 
-    memory_region_init_ram(tagram, NULL, name, size / 32, &error_fatal);
-    memory_region_add_subregion(tag_sysmem, base / 32, tagram);
+    /* We store 2 granules in 1 byte. */
+    memory_region_init_ram(tagram, NULL, name, size / (2 * TAG_GRANULE),
+                           &error_fatal);
+    memory_region_add_subregion(tag_sysmem, base / (2 * TAG_GRANULE), tagram);
 }
 
 static void create_secure_ram(VirtMachineState *vms,
-- 
2.43.0


