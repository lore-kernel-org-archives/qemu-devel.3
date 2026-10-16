Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D0BCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhbj-0000vv-Mu; Fri, 16 Oct 2026 09:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHfDy-0006ZS-S5; Fri, 16 Oct 2026 06:31:42 -0400
Received: from out203-205-221-209.mail.qq.com ([203.205.221.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHfDv-0004ko-3Z; Fri, 16 Oct 2026 06:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792146691; bh=nQuUQzk0s+Oj9Xb/wCLE9CX/lkMW9AotEI2rbeosXxw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ztpGR/oV/k8Go+eLHaFHRBMuoJYYGKGZUnJPZs1q8XKkvGytkHAeUa5a3eaQI9LTS
 UIQVrijodwpkKB62HV+kOoQSrEnQUbQdHiaNcMpUukntQ8omrCydg21ZkQWmlsJ3Ep
 A+eH3dko6wRbodFzS1bR0zQYTUO8akcjOQ0Z9DXk=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id 7DCA540D; Fri, 16 Oct 2026 18:31:28 +0800
X-QQ-mid: xmsmtpt1792146688tfoe4fvo9
Message-ID: <tencent_EA6765326D6BC209B1EEF6434A6E46E93805@qq.com>
X-QQ-XMAILINFO: N8JXP6LS4uUrOMb6qXpTQ2tSLI0J2hDNEVzTUSeW1fTv9fGVF1vIYRM1nputGC
 yrvwxksGR2783X/8WMUpX/1kZy2oib/CKHW+prU6PhG227VnZ+cQmcvgQ5RjBobRT3iZma7vNCc0
 DuZSzRQHvH8Bo+oR19+yzHVTBGlCvkTYcReKTfdXZcNr5MvNEvnnCrD8fpXq97fAf4PQMv0Dqs/+
 beoiLofK/lmnIAB6ii1c7PMW7ww/yxkHEQCMNP4Aj5PHxUx8a+kigJmq9qsa2ogbXaS11O6HOb4o
 apH3lkCCkRsSqTuW6JYc7MD0HNsRuwdB8TDyh5xssOXIP71H6yvqmGUZ5FBPxwnu/8P+OzQ0JrUP
 xbTHqKgpTgbpPQwLbU46Lssv36yg1UWqnj/es3U2gazu7jLSB/RTRRBNAq+Vsp0Lh+oq3a0lg/e/
 7l/JBXNvUx4uIEZqcKVJxUKDzwS6Sm4+lmWGmBM6mGO9jzyURkl3JtCt7BNj7ZvT0kixPxQJp0Rb
 ScqmHxntLIYcFMQ3QHrev3G9ZYIYYM3pGEzX4CCuzhLL+O0wvtGWWc2CRL4ZWF+NthsdYVrM0y/9
 mxNVuPXYAYJh91eb8TWDsJoIqkXUoVPU2ae3GlJIDtuo0jR7DjKgoCo2WypPhvdMqwgqiyFn5RhG
 QZVaqFVI4Ue/tfYHfnORD+nTa+Y/cgyPGOiXLYktepqzy4CxBW5wlHifdLJ+9n7U0gtFXGW9ISUY
 Ul4y2M8zMfOHrZwIyYTihQ5/uapO0wREuxaAsOvcN061RxnKz0cMbI1VapcUsZpCVzOcgNTaUucI
 bkN88vkcdyS90rQCzJgibX81U7CUEPID8oOcvZPEofFpapOduI3il9f7y8SJ754midt02Q0vo5kj
 mV47Sbo71vekG1GL1Gj/lkaPDazVi2j+wOpwP9SiURfC/MGCXh6dRRiXbyb3g+AE0GPKUYnxDbZQ
 qGZtc2S5O1ttFMP2+Nkjbr2ExX7HF7TH/0+7/FZSTF8qBbznw7wB+H2r7YFRFevy6IKf9XLQbn17
 rwm5fjmJa6ztf4hiwk4Fxndd7MJ9itZkmLnAI88i/e+gQA7zGS0GKNzZgd6wAntsjwhkp9xB+Lke
 GC4/6aZoJ1txM2qOi9JqqPi+pCDDArpr38FY+m69u3xY46paQ=
X-QQ-XMRINFO: NIY0FsY06mWik60O6xSizP/2tkZG+oPoPQ==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 35/37] hw/arm/virt: Default to implicit node 0 for MPAM
 without -numa
Date: Fri, 16 Oct 2026 18:10:55 +0800
X-OQ-MSGID: <20261016101058.1900808-21-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.209; envelope-from=2118537295@qq.com;
 helo=out203-205-221-209.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:46 -0400
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

Instead of failing with 'MPAM support requires NUMA nodes to be
specified', -M virt,mpam=on with no -numa now treats all RAM as one
implicit node 0 and creates a single memory MSC for it (node 0, one
RIS, same partitioning configuration as a per-node instance).  The
ACPI MPAM locator keeps proximity domain 0, which the mainline
arm_mpam driver resolves to node 0 via its pxm_to_node()
NUMA_NO_NODE fallback; no SRAT is fabricated and the guest stays
non-NUMA-aware.  Cache MSC creation is unaffected, and explicit
-numa / mpam-min-msc paths are unchanged.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/virt.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4ef7aed..ee4308e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2244,11 +2244,31 @@ static void create_mpam_msc(VirtMachineState *vms, Error **errp)
     hwaddr base = vms->memmap[VIRT_MPAM_MSC].base;
 
     if (ms->numa_state->num_nodes == 0) {
-        error_setg(errp,
-                   "MPAM support requires NUMA nodes to be specified");
-        return;
-    }
-    if (!vms->mpam_min_msc) {
+        /*
+         * No -numa: treat all RAM as one implicit node 0 -- a single
+         * memory MSC with one RIS.  The ACPI locator keeps proximity
+         * domain 0, which the arm_mpam driver resolves to node 0 via its
+         * pxm_to_node() NUMA_NO_NODE fallback; no SRAT is fabricated and
+         * the guest stays non-NUMA-aware.
+         */
+        int err_spi, oflow_spi;
+
+        dev = qdev_new(TYPE_MPAM_MSC_MEM);
+        object_property_set_uint(OBJECT(dev), "node", 0, &error_fatal);
+        object_property_set_uint(OBJECT(dev), "num-ris", 1, &error_fatal);
+        object_property_set_uint(OBJECT(dev), "num-partid",
+                                 MPAM_VIRT_NUM_PARTID, &error_fatal);
+        object_property_set_uint(OBJECT(dev), "num-int-partid",
+                                 MPAM_VIRT_NUM_INTPARTID, &error_fatal);
+        mpam_msc_assign_irqs(dev, &err_spi, &oflow_spi, &next_spi);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                           qdev_get_gpio_in(vms->gic, err_spi));
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1,
+                           qdev_get_gpio_in(vms->gic, oflow_spi));
+        base += MPAM_SIZE;
+    } else if (!vms->mpam_min_msc) {
         for (i = 0; i < ms->numa_state->num_nodes; i++) {
             /* at most 16 mem MSCs (4-bit selector space, SPI budget) */
             if (ms->numa_state->nodes[i].node_mem > 0 && count < 16) {
-- 
2.43.0


