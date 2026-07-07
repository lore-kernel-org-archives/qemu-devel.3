Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B00DC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7Ut-0007O3-Hm; Tue, 07 Jul 2026 11:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh7Ur-0007Nu-SM
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:14:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh7Uq-00078R-5n
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:14:05 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C9MOd3740915
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 15:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yaf/5V76um47pCfHP8BnuraAKiicIkAa6eTW+KqrJtE=; b=Q7F7OVyptQpNxEmm
 itsEZqdtxP7EN/yaf+b0EJgm8ZVqTYCALfa9yHYSfgFB9H6cgIjUb0CoSDFwbtbL
 ezs1vyuimkPnM+4m0Ek9HQP2HEnTpmkZswEpHVXW/kmdpuNNjX9mhgj4KSbpH6+k
 1NMLGONyMywmJ6jE4vQh6uWj+6KLdael/kjl0UkcvQUpgvRYT9t9Qqw3kyoQwX3E
 EwV0j0LLrK2H55glWZ7EOCGtPhJNB/06SBTlHr5yHSFhMWK0zVW3kvcfhQgnIc3i
 iTYOpb1+nHQeQZtaC/yS69Ji0fPFBQ42lLCZiSfSxXUpvtXDG931siSg3KfN9deY
 6qRlDw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v9aa52a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:14:02 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0d6a2f4cso48545941cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783437242; x=1784042042; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yaf/5V76um47pCfHP8BnuraAKiicIkAa6eTW+KqrJtE=;
 b=Ll5WjLlPV7Tmty/qCAWlhYs4ierHPs453aPBD+WA2UoLpbUUgn4JQoeshVr6NRdo/m
 aCiGlvr+d7BV9iiHGyRn366BnU/DRpmkHP38sjsSXF0YYLy32Y1PkoRbjQGHdMhJYMDm
 x285+Diu1G59As21FUHwrIXixe8qk+MEZYZDmQVjc7WkrQTbI7sthr9LbAexQmVbHkfG
 DkoOLD3SMuOZN473H1FUuPaVbfpIsR8qu1vJ8ivWXdzaH8bljpCiCfHAucxnWwohwr6k
 3p0OWsezqiu7yagnguEcI8vZDgsut5/hGSWRmCiEPY+b90si2VJ+0Td2yyjdumaaUinQ
 mY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437242; x=1784042042;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yaf/5V76um47pCfHP8BnuraAKiicIkAa6eTW+KqrJtE=;
 b=gCrOVXfuHX9ae8+xfFXy/WriOvpEAztUM4y2EP0LbDTMr1qOtLqlWH09dV/rogLb4u
 5wMJtNthrv2/5MhZYI3DYEo/qRGWzBnNLnDtwqnnLP2gQUhyhylrXeBcjAlmFySSN0IT
 G6Uhk7juz8IVlkxwiZqb6m0P+ZKMErPOTQCNko+nGDGJwj0tEfa350A2cnqIW5sW89rM
 CpuaKtD+JXqEjVwcfPOYsIZwaUgk+Gz3QAZBiQJAE6eewnDtMmDMbnk8KET3ECqb/S3b
 q1JQOLLdIsGZ1WhjOW1JltU9AzKio5ItyXZ0zAaxgi8nBY55WKIe2w4DR8zfjostWun1
 FwaA==
X-Gm-Message-State: AOJu0Ywb8otkIQOm+jsJcF9pwLUTHc0CZpWsP0Y1HgFEpmDfGNkQ4+Qp
 BJlcq8Qps+LJ8y8VnK1mDkjrvBzri9n3fSYaLqF1aWHgqOc5zyjaAKYpbj6YnmZlHZlof3mQhVs
 90HgCT0wNIqVrU/eYc5z/HdTFrFEJN6DIFYCj+oZ5trzTExaej6WZOuzna7HUk/JvHw==
X-Gm-Gg: AfdE7clbtcW9lAsEh4plMB+10m1cL3X5Cckx/Z/LQr7zKpuXJfDEsDa1Z0Qggqgj1Mr
 ZhXPx592pTi0jKxQLUENeZG9xP8waCpJgK8vFDg6UwY3HR4dP/ElBUzIRKpWzK+XL0B+PmQ8Fwz
 M7ziY/CNSXByvzE/J9YZ0yYfuaso7K671yKHrxHifu+QYv3Ss962m2Ac/lz9SUREBMYwfRiCpBf
 WT5VCi96uBElvLPywvnvWhBjmrjkhqUeqSsINN6RwsNDsHMwdYFpNobBrpUGyGbeIDdNL5W6Eaj
 iIGer+gDPBBfc9wPvWAzcSLO8TvjizH0OMsfpznQkVWdBLO/ONSk/tBNZFwwXmr/k3nyKEHmIFl
 DxAK9JW3er857txcPlBOhFZBZOLbUFpakmBa4bGLxonCFmjyafTmksJk2MCwxYCDyR6cj
X-Received: by 2002:a05:622a:10d:b0:51c:7b12:6003 with SMTP id
 d75a77b69052e-51c7b126696mr28023491cf.79.1783437241819; 
 Tue, 07 Jul 2026 08:14:01 -0700 (PDT)
X-Received: by 2002:a05:622a:10d:b0:51c:7b12:6003 with SMTP id
 d75a77b69052e-51c7b126696mr28022901cf.79.1783437241186; 
 Tue, 07 Jul 2026 08:14:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ae44sm33446143f8f.23.2026.07.07.08.14.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 08:14:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 05/36] tests/qtest/ahci: test ATAPI read completing after
 engine restart
Date: Tue,  7 Jul 2026 17:13:48 +0200
Message-ID: <20260707151351.57769-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707151351.57769-1-philmd@oss.qualcomm.com>
References: <20260707151351.57769-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xd-TjnvQZcIRYyVOkkj1PV8VXptWIlDL
X-Proofpoint-ORIG-GUID: xd-TjnvQZcIRYyVOkkj1PV8VXptWIlDL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE0OCBTYWx0ZWRfXwwRWW5liU/Kj
 Q5GoM/wmrm5g4skrLs/X5LRw3e9dTljlvyJQDCbnsV2zZVla/Prkn+eAF4ExKdkj5gST0K4FSF3
 Icko+01e9LYEJDTPR4Ns5U2Jc0KtvAQ=
X-Authority-Analysis: v=2.4 cv=b9yCJNGx c=1 sm=1 tr=0 ts=6a4d17ba cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=6rqHouBjAAAA:8 a=EUspDBNiAAAA:8 a=-zOJN3Dk7xpj7_uVN0sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE0OCBTYWx0ZWRfXycY8ecVl72ie
 ibx+crq0uTi/6BhtntHMUSQ2KknPNm3uPX3dNWe3BNOFxaa8RM/Nmc/9rVH43UXyvFmomORdpeV
 rPFjTH59v0nPCMvnxdH7Bt+IAnHzmFQmjZ08ph2mCFhyQakLDMZrk15bgS903hxkbDqbEP8oGtj
 bzCrlpRqExuuWtGtVLboG/+yCf/1SHyNxymk+aohWaiTOxmiuvmgYjzcDrWpEpastbWKhgypuLv
 8GCgxZYXqRzVdrJrZLj+sxSeb3eqSLqVFtF2fveUL2czOn5asM7fpTh/gfqE7xss3Y9d2tmpQdT
 OOVp5OF9qyU9MY+kecR2cohH0qws+P2pq60q1LkSGo0p4wVQEiRQxpK/s4r04OShGQsReJqCche
 MHoGU+w48/YmmacXxJDvQjxzTGju3fVd6DyZ+LDmmsPBWpLwABU6JkWuj8TTgKs7xsxQsF4mGxo
 eP45BkRg2ejbSnF0guA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070148
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DIET_1=0.001, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: "Denis V. Lunev" <den@openvz.org>

Add a regression test for the crash that occurs when a buffered ATAPI
read completes after the command engine has been restarted. Issue an
ATAPI READ_10 against a blkdebug-backed CD, suspend the backend read so
it stays in flight, stop and restart the port's command engine (which
re-maps the command list and clears cur_cmd), then release the read.

The PIO and DMA reply paths fault in different AHCI helpers
(ahci_pio_transfer() vs ahci_dma_rw_buf()), so cover both. The DMA
variant is the reliable guard: on engine restart check_cmd() can re-arm
cur_cmd before the old read completes, so the PIO variant does not fault
in every build.

The test only asserts that qemu survives a subsequent register access;
if the blkdebug breakpoint ever failed to park the read it would pass
without exercising the bug, as with the existing break/resume tests.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Message-ID: <20260619112158.304782-3-den@openvz.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/qtest/ahci-test.c | 67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 5c32ff20029..44799eea153 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1625,6 +1625,69 @@ static void test_cdrom_pio_multi(void)
     ahci_test_cdrom_read10(3, false);
 }
 
+/*
+ * Regression test: a buffered ATAPI read completing after a command
+ * engine restart must not dereference the cleared cur_cmd. Cover both
+ * PIO and DMA; the DMA variant is the reliable guard.
+ */
+static void test_atapi_engine_restart_in_flight(bool dma)
+{
+    AHCIQState *ahci;
+    AHCICommand *cmd;
+    unsigned char *tx;
+    char *iso;
+    int fd;
+    uint8_t port;
+    uint64_t buffer;
+    uint64_t iso_size = (uint64_t)ATAPI_SECTOR_SIZE * 2;
+
+    fd = prepare_iso(iso_size, &tx, &iso);
+
+    ahci = ahci_boot_and_enable("-drive if=none,id=drive0,"
+                                "file=blkdebug::%s,format=raw,readonly=on "
+                                "-M q35 "
+                                "-device ide-cd,drive=drive0 ", iso);
+    port = ahci_port_select(ahci);
+
+    buffer = ahci_alloc(ahci, ATAPI_SECTOR_SIZE);
+    qtest_memset(ahci->parent->qts, buffer, 0x00, ATAPI_SECTOR_SIZE);
+
+    /* Suspend the next backend read so the ATAPI read stays in flight. */
+    g_free(qtest_hmp(ahci->parent->qts,
+                     "qemu-io drive0 \"break read_aio rd\""));
+
+    cmd = ahci_atapi_command_create(CMD_ATAPI_READ_10, ATAPI_SECTOR_SIZE,
+                                    dma);
+    ahci_command_adjust(cmd, 0, buffer, ATAPI_SECTOR_SIZE, 0);
+    ahci_command_commit(ahci, cmd, port);
+    ahci_command_issue_async(ahci, cmd);
+
+    /* Stop and restart the command engine to re-map the command list. */
+    ahci_px_clr(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
+    ahci_px_set(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
+
+    g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"resume rd\""));
+
+    /* Round-trip through the device to confirm qemu is still alive. */
+    ahci_px_rreg(ahci, port, AHCI_PX_TFD);
+
+    ahci_command_free(cmd);
+    ahci_free(ahci, buffer);
+    g_free(tx);
+    ahci_shutdown(ahci);
+    remove_iso(fd, iso);
+}
+
+static void test_atapi_engine_restart_pio(void)
+{
+    test_atapi_engine_restart_in_flight(false);
+}
+
+static void test_atapi_engine_restart_dma(void)
+{
+    test_atapi_engine_restart_in_flight(true);
+}
+
 /* Regression test: Test that a READ_CD command with a BCL of 0 but a size of 0
  * completes as a NOP instead of erroring out. */
 static void test_atapi_bcl(void)
@@ -2042,6 +2105,10 @@ int main(int argc, char **argv)
 
     qtest_add_func("/ahci/cdrom/pio/bcl", test_atapi_bcl);
     qtest_add_func("/ahci/cdrom/eject", test_atapi_tray);
+    qtest_add_func("/ahci/cdrom/engine_restart/pio",
+                   test_atapi_engine_restart_pio);
+    qtest_add_func("/ahci/cdrom/engine_restart/dma",
+                   test_atapi_engine_restart_dma);
 
     ret = g_test_run();
 
-- 
2.53.0


