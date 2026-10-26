Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CFC606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kSB8Pjm9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOGT-0003pn-DY; Mon, 26 Oct 2026 13:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xLOGN-0003oa-MD; Mon, 26 Oct 2026 13:13:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xLOGL-0005pO-QZ; Mon, 26 Oct 2026 13:13:35 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QFE55Z4039005; Mon, 26 Oct 2026 17:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=03+kTjUwkd6T3mwxeVe7S4Ie4ZmQgbD6o17jsQPbK
 Dk=; b=kSB8Pjm9KaLfx13RLEbAqB/LiHUxSO6R+YTgty5vU4vJdwSIKPCvX1FN9
 AmIvR41s+bOF88XoAqzP65RE7L0QXp7XEYTC0fYJHT0sU3e1mq6dU4rFxQZ0CVR+
 Pun2ZjMtYhnaDZpsk8qG+Wrt4VZq/sAPjhfdIVFAaQ9PzOLSesZ1tDGPDWk+D4nP
 zwO1kvWgmpxKm3d0fWxgvKyhseU2fpl17VzRuTuD5FQ/zd3ki8CsEIWbP9S1aUvs
 DSBdhWaYIESOFqgZBnrLCkbr/E4gGDT8WaytA9FNKolQOE2wCnvZAjKNMjjtJVsf
 9Z3+zaqZL/E3u26xIN38VMV+pVREw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm63ug18-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 17:13:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QF5DLn2784950; Mon, 26 Oct 2026 17:13:28 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh9py6vqn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 17:13:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69QHDRKh13042228
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2026 17:13:27 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 808CC58055;
 Mon, 26 Oct 2026 17:13:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B1D15803F;
 Mon, 26 Oct 2026 17:13:26 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.249.110])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Oct 2026 17:13:26 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, oelghoul@linux.ibm.com, qemu-stable@nongnu.org
Subject: [PATCH v2] s390/pci: Change reset method from legacy to resettable
 exit
Date: Mon, 26 Oct 2026 10:13:25 -0700
Message-ID: <20261026171325.876-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NiBTYWx0ZWRfX5L4mGVU8KQGm
 GGbJHjV42I9CxaXqQJbk8h3WrgxYW8YU/sGNkHwDip8YMEVKNsuYoCKe189e9NOJeQMcgueyWey
 iV1YI6zgNvjF5cvwVewEmfuHmHeBou8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NiBTYWx0ZWRfX2yGiwS4obcEX
 NCw6OdT4GCtvA83wNqdd1Gt3wV8/CJJXbZy//tiW979LivE4N8AxuswNbI7ytGJi+Wf1nPf+n0X
 Vb8GbyKobNc0fKqA+poSYaS+mONO3Yaa2ballcb/kFM5lvcRv+ZwRZvEFBoXW46zOLNjRqxIWDZ
 kps3jfxv7D1QhXhA//8Xlse+zB7KP2WfQGUmNffwIwLT/HmAkzo+J4RN1ogbS8WbmIxC3vq6DN4
 4iQYEvp/jKgUp/8FmMko94XPOQCzCoFROn+stY3ClyT4DHEwYxUDtEkesz95s+YX4AOpmrIF2Jn
 HsCOXgkOB3KwXlG4IuSW3kjvqc9/jmpS50TcNVf0Sn22VI+8NJRIDNdalu+g84Hezc6jAhhVfFC
 rn62CRXnZ4m1JKZ0+bccR5nhRS2C6iBoJE1o4A804e4YB661RBgRbE3EBdBPxaflerc8KQrDxKl
 Fzf2NsbRCAGYPf7qlsg==
X-Proofpoint-ORIG-GUID: TcIl5kCHFNll_h3D-Pc_46Uv78ZD_YuZ
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6adf8a39 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=d1GJVicS2NaZ5qTk1R8A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: TcIl5kCHFNll_h3D-Pc_46Uv78ZD_YuZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260066
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On subsystem reset of the s390 PCI host bridge (TYPE_S390_PCI_HOST_BRIDGE),
child buses S390PCIBus and PCIBus are reset in order. Because S390PCIBus
devices are reset first via the legacy reset hook, IOMMU mappings are torn
down before the PCI device itself is reset. For a PCI passthrough device
this opens a window where the device may issue DMA to addresses that no
longer have valid IOMMU mappings, causing an error (PEC 0x7) on the host.

The QEMU reset documentation (docs/devel/reset.rst) specifies that IOMMUs
should perform teardown in the resettable 'exit' phase, after all devices
have completed their 'hold' phase. Move the S390PCIBusDevice reset logic
from the legacy reset hook to the resettable exit phase to close this
window.

Fixes: 3e5cfba3ca0a ("s390x/pci: introduce S390PCIBusDevice qdev")
Cc: qemu-stable@nongnu.org
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
v1: https://lore.kernel.org/all/20261022185829.11835-1-alifm@linux.ibm.com/
v1 -> v2
  - Change to s390_pci_device_reset() to resettable exit function. 

 hw/s390x/s390-pci-bus.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2724b27ec2..a24ec98c1e 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1777,9 +1777,9 @@ static void s390_pci_device_realize(DeviceState *dev, Error **errp)
     zpci->fmb.format = ZPCI_FMB_FORMAT;
 }
 
-static void s390_pci_device_reset(DeviceState *dev)
+static void s390_pci_device_reset_exit(Object *obj, ResetType type)
 {
-    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
+    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(obj);
 
     switch (pbdev->state) {
     case ZPCI_FS_RESERVED:
@@ -2010,10 +2010,11 @@ static const VMStateDescription s390_pci_device_vmstate = {
 static void s390_pci_device_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->desc = "zpci device";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    device_class_set_legacy_reset(dc, s390_pci_device_reset);
+    rc->phases.exit = s390_pci_device_reset_exit;
     dc->bus_type = TYPE_S390_PCI_BUS;
     dc->realize = s390_pci_device_realize;
     device_class_set_props(dc, s390_pci_device_properties);
-- 
2.43.0


