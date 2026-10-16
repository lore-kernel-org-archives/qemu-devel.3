Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D11CCF2C2
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHheF-0003As-7f; Fri, 16 Oct 2026 09:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf7y-0005Hw-Qj; Fri, 16 Oct 2026 06:25:30 -0400
Received: from out203-205-221-173.mail.qq.com ([203.205.221.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHf7w-0003ed-GO; Fri, 16 Oct 2026 06:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792146323; bh=CZrt6n0uEIwF3mOIOm+Ry7EeuxKjSXFVHTo7sQVSpVk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jPaku8/AZuMyaIS6QhL+DuKiNOPokfnGQolPurjeRD6AHzyE+LgT3FIH59M7i1BVV
 NxA/RsDfzbnbhE5Ox62zxWp9Pv0JxiTkNtpQ5caLFgG9+xHkVtQndK8wfMpq0PcQHc
 el1+OgJ7kIaiu3/mingpV9gv4C3dxG3TC2zbJKmk=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id 6542FCA7; Fri, 16 Oct 2026 18:25:20 +0800
X-QQ-mid: xmsmtpt1792146320tegb63v4h
Message-ID: <tencent_5CA6D54DF02302DDEE4B59CD141E77AE000A@qq.com>
X-QQ-XMAILINFO: Nx5J06Esz7r7+jCvJj56TVIj4I3TMD9JFtalKRVslSl0X7SDSTHwbxTKMaXqnX
 qyIJ2BhJLzg8wwb3hoNdoUwtE9gjd9MQ0czSiJ/LzQNp9hXaRiYABpw/AleLH/OS8fVClMY7u5HJ
 fYbz2Vh2R4EP31ocFG4DsSAGkdavpEVVqE09IxqIAvqYvOWQAplhIRK1fv4+ks+aAQKvmNH5V+lk
 vDEYaVO0M++CMtBqpFEduumpsKftpzQhXBrKDHrg3iGWaR9VBtYheKQbbhvlcSdJC3kp05OLn92X
 GiniYgudOLV8PZxVS635aG28TDeBypTmkWqYXSvbj5+g1n2Si0fOq0JCSBXCHagTKAb202e1lnlN
 TRuBcZHpJALEh4OIX6Eus5KO4BtSEJICDWhbKME2UbieydPFLqcDk1ZCIIbgEO7IdcrBK1e3cWj/
 ne7kd6iIOSpWAV+zHEa3cRCgVBz524lYC7MAUo3YYxVWoNVADp7QzDG7Q0SvMmz8fYWbCGpJUs8E
 qOkWV+Hms5UyVUo000Jzf5qWaW/p8DkMEJgewWcUYckWIw3BZpNwsbA+rTIMgRvlYoeMVYdZURsr
 hMVyJz9FUQTq53LNKDmFQcGARPWQvnpweHLkQiYjgpFPCG6+EljbE4p8KH+DzhEzR+vg0k3UfACu
 DHId5lD4Mo6ycmtxmntNCB+UrJhEa7fPCWQRibPACeEGqyhybTOe6NQ7yNQHJX73NifpM1qSfia/
 0hnpGLSI7/dE/1TX2OnlrP8aHYbaaqs9Q4u3+AF+xxsdVwb58QCcCxhgUpRwOKOe3k145rTqZzkd
 PR4sEE8XYKMlXNUMaFhVirkjwCUaSNbNrh1Ci039XM8nQdUrHVVX3/3BBBFPA4z56HgyKP2E1VcL
 yzht5PW6GYWutdHq3zkkBeve5ue7xvpgTn642zfG6tZsuOw+8CrWn0TCzOjBBI8C8JeUBO1ZKKFs
 XWsp7rZEQli2x9QI/xir0iK92PPMgo1rrN8P2jdCxNghFlbQF1rq/JLzZsFq0VaE6L9X1bBZ0Mow
 FDbGBh0M44TYD0Lt40pBtNY15iFszX7/kMPVIbKb2WZs6bNBFDF2vHSkQ8Je1mqUlKNEnwVNXf42
 7AbnuM
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 29/37] hw/arm/virt: Size the cache MSC occupancy model by level
Date: Fri, 16 Oct 2026 18:10:49 +0800
X-OQ-MSGID: <20261016101058.1900808-15-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.173; envelope-from=2118537295@qq.com;
 helo=out203-205-221-173.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:45 -0400
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

Give the cache MSCs their CSU model capacity: 512 KiB for L2 and
32 MiB for L3, matching the cache sizes guests infer from the
topology, so the occupancy snapshot reads back realistic values.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a57ba56..1bcdd20 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2192,6 +2192,10 @@ static void create_mpam_msc_cache(VirtMachineState *vms, int level,
         object_property_set_uint(OBJECT(dev), "cache-type", UNIFIED_CACHE,
                                  &error_fatal);
         object_property_set_uint(OBJECT(dev), "cpu", i, &error_fatal);
+        /* Occupancy model: usage = capacity scaled by the CPBM fraction */
+        object_property_set_uint(OBJECT(dev), "csu-capacity-bytes",
+                                 level == 2 ? 512 * KiB : 32 * MiB,
+                                 &error_fatal);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, *base);
         *base += MPAM_SIZE;
-- 
2.43.0


