Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB10CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2026 18:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFyG0-0003Aa-2L; Sun, 11 Oct 2026 14:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1xFyFY-0002zi-0v
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 14:26:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1xFyFW-0008Tw-EC
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 14:26:19 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69BILtgl3180723
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 18:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:sender:subject:to; s=qcppdkim1; bh=l3kV
 /dgEJvnaoguBfGnHN/xHN/fCnDtDoOefoJcVsDk=; b=cLt9HznLDyvbjJph5qRZ
 +R86OHFHLhxIZWwsph3AXr900nDwwdCrCzWFe9ca1TtpEbemrTKkd9fOLKvqCyMO
 R3HbTs2EKXE4Lntyq1zjNufPebMgpWEVdo7O+PM8vM8vpsSMvci1stynNoph2VWQ
 pJ7Z/KmhX1UZ4N9SicW6qPzlNzxSsoNUMpwtEVdRkFKZWeu+K8s0/HIPh5Y66Ybn
 z8gyaAZJ11sNnhJTZ5HfD/E0N1n2g84ZTLiEugfkY0QMB2+5R8gu7utuklvzbR89
 +GiJ0KmVzJ91LvnGNvY8tAmTlUcNWjQybdIHv86TCGtaankm+YVALaYa0+NKlJOX
 CA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dr7kgvj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 18:26:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35ac5255f1dso309764eec.0
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 11:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791743176; x=1792347976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l3kV/dgEJvnaoguBfGnHN/xHN/fCnDtDoOefoJcVsDk=;
 b=AYmyfWIiZqptsvwBVeFdMbNPG3TVSw/pEKNRRZhIlfz3kejI5HnUHUOzZ7uDzkk16u
 z7fo73xxglh/vju8NtXX8apizjESCoRicq7E3kLcEKt+lOH6hb2DaItQvlhI30zH2K0H
 617x/ppn+P0lfPtcN1tnltGDYHUOAXOioS257BV89Tdy5v5rwlk48eFT51sUf60ubkEd
 LCxbEOHnzJXUOZ1x1DAUKZghuD2BiZ0Q3IaO8YbRBDKqXRkRSJAjq7e/3SpaaXKlht6z
 F502Pi9f2JwX8LAmAbuGZoFCsQfkkBlCyhPSdW0noFRggfuVsl4BRmDSAE2gQ4Nl9tFW
 /vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791743176; x=1792347976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l3kV/dgEJvnaoguBfGnHN/xHN/fCnDtDoOefoJcVsDk=;
 b=UvqNZAiOxALS8D3PFLZvLQCcFU6ByYh9l+QGUHNSyZRz/9fIswi6U7H43JdsjVahKr
 Mg/CpKQw2iBuJjonnKJY2PqR+utxx/bw9nf3CrkQJNSxgZm7h5xREs8KsJsa+u0l1FGR
 Kn4p4b6HP8PFrHOKBRrPfys08caInDyeJBxAzyLw4LzcveBQvTGYEuvfHQfsregf/R8Y
 T0Qy+lzL6VrOaWJqMc/UBMMFZHpE2Wi8V50g8i+hNld5aFI2bLqKwOJRGGHOkPUMzKLS
 Qbaxoxla9eizOU92Hikc5xqux1A06LwZl6ptwAfzUOSsPuKNG/z6K+Qzg6KYBSFTUm/4
 fegQ==
X-Gm-Message-State: AFq9FYLG2qdJj+B9A0mWeChn1v4iTfhRArVyZhELuyamHPo13PK+jr9j
 B6uh7uflMyuoc9DYVHUATqm9wtbfOZiYqJikchCxlIuAIiqXZcBKr6ILUAz1qwcDfpwABOU7TJp
 RFwJegtF6quViCfsoG+QWuaU+VpS770R+1/6BlqtwVoREGaHPsBsRyDOb0OM1BXU5tg==
X-Gm-Gg: AYBFou1nnb45f2A9XZZB+Ba7kukNU5fh9+9DI1Q1yqa7amCwDGP7jl6qqNUSpCEas/R
 9aK9TMn70DADzrLHOtfYEGOiHLBTs2HAxU/+4tM8Zv6qgIe3BoehREZ7UhoNCgJJA4aLi1aRf1s
 sk2lG4AYo7MmjTazAnPfT4IhfsK/511+HmzSd8jVQYRos9YfgdwFkgop7MzlFLpjS1EDWFjP9Ez
 /9WZEu3rHvm9xDFP6SNfDtUqxPr7a8cpBl05z20OONQqXibpdiDhcH9wErZ57bRA7hKOvF3ZiTS
 OeCTz4Cnx6nDv7uPynsd0oJ6Pysxs8ikCpUWpT8ujayzB5tqio3HSCi9zHT9gLh2c9UiOpqZHh/
 9fSibaRZvPQkp5E+2NO7xD4ePm/J6mXqThm1+db7SbyEF7fQfQk+bG+4=
X-Received: by 2002:a05:701b:2607:b0:144:f096:4dd1 with SMTP id
 a92af1059eb24-16a611c76a1mr9230049c88.41.1791743175818; 
 Sun, 11 Oct 2026 11:26:15 -0700 (PDT)
X-Received: by 2002:a05:701b:2607:b0:144:f096:4dd1 with SMTP id
 a92af1059eb24-16a611c76a1mr9230011c88.41.1791743175212; 
 Sun, 11 Oct 2026 11:26:15 -0700 (PDT)
Received: from hu-sunilvl-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a5866477sm22505284c88.22.2026.10.11.11.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 11:26:14 -0700 (PDT)
X-Google-Original-From: Sunil V L <sunilvl@oss.qualcomm.com
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>,
 Drew Fustini <fustini@kernel.org>, Sunil V L <sunilvl@oss.qualcomm.com>
Subject: [PATCH 3/4] tests/qtest/bios-tables-test: Update riscv64 virt PPTT
 golden reference
Date: Sun, 11 Oct 2026 23:55:51 +0530
Message-ID: <20261011182552.1071742-4-sunilvl@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011182552.1071742-1-sunilvl@oss.qualcomm.com>
References: <20261011182552.1071742-1-sunilvl@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KAQ5Ma04xN15B57sMoYYlIxFHMKxI12G
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA3MyBTYWx0ZWRfX5G5Td7Wt7h64
 MqGX1oxiQ3jhGoABKRhqQu57ES49a+5RYvLlegBZtRg5r7AY8FpIMK8OeA9j0AcB0G5cJ1inJ9A
 Zk6uBrkdq13lcxH7kPdd6PyRBlDiKLA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA3MyBTYWx0ZWRfXwrX6SS9cSKqw
 WWsX4+JE3ZgpmhLHfzcduWveW4huMV5RlX71B2Wa8BYkCRxpzDNWCUuiGa3y3iiTBb2HxmbiKAU
 ++5KIlGa2YxJ+gsOJxF57jX9aYRyp57U5mhsrRAZHs1fajbZqilcv/FL4qedjc6u90Refn2M0xp
 P0EbWjwFWgw3bpsOZ6cw23UpJkoWDAwLrKP9dgP+wR+cq3GF7anMQr5MM5q4VJT/0SmMgcd9F3V
 8TutfQ2AvRxwaFfWzJZ4s3Un/DKnPIruBn3eGcyMBa3qLa9PSM/VyZz/TuVNX29c1THjRIFXwci
 NF6h+eGIfF0H6orfVFa/o2yjycW2zrBR9jz7DvJKPgPV7g0bJBYFZIVkwjans+7j3CUXzyTWIZT
 EVtvqTC5+F/vBdBfgRnKZ4MbdAiA764MZS/Sqb4B9GgN5UqodrlaLn6hCXePgy3CnrG54oDJ5Gw
 KYiTPZ0L1Dh9V9GWwrQ==
X-Proofpoint-GUID: KAQ5Ma04xN15B57sMoYYlIxFHMKxI12G
X-Authority-Analysis: v=2.4 cv=asknmiZV c=1 sm=1 tr=0 ts=6acbd4c9 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=7nS_kZPvwonqTfo6PMEA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110073
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Reply-to:  Sunil V L <sunilvl@oss.qualcomm.com>
From:  Sunil V L via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Sunil V L <sunilvl@oss.qualcomm.com>

Update the riscv64 virt SPCR golden reference file to have the fix for
the UART register width.

Diffs from iasl:

+/*
+ * Intel ACPI Component Architecture
+ * AML/ASL+ Disassembler version 20230628 (64-bit version)
+ * Copyright (c) 2000 - 2023 Intel Corporation
+ *
+ * Disassembly of /tmp/aml-DN3NW3, Sun Oct 11 23:01:04 2026
+ *
+ * ACPI Data Table [PPTT]
+ *
+ * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
+ */
+
+[000h 0000 004h]                   Signature : "PPTT"    [Processor Properties Topology Table]
+[004h 0004 004h]                Table Length : 00000060
+[008h 0008 001h]                    Revision : 02
+[009h 0009 001h]                    Checksum : 27
+[00Ah 0010 006h]                      Oem ID : "BOCHS "
+[010h 0016 008h]                Oem Table ID : "BXPC    "
+[018h 0024 004h]                Oem Revision : 00000001
+[01Ch 0028 004h]             Asl Compiler ID : "BXPC"
+[020h 0032 004h]       Asl Compiler Revision : 00000001
+
+
+[024h 0036 001h]               Subtable Type : 00 [Processor Hierarchy Node]
+[025h 0037 001h]                      Length : 14
+[026h 0038 002h]                    Reserved : 0000
+[028h 0040 004h]       Flags (decoded below) : 00000011
+                            Physical package : 1
+                     ACPI Processor ID valid : 0
+                       Processor is a thread : 0
+                              Node is a leaf : 0
+                    Identical Implementation : 1
+[02Ch 0044 004h]                      Parent : 00000000
+[030h 0048 004h]           ACPI Processor ID : 00000000
+[034h 0052 004h]     Private Resource Number : 00000000
+
+[038h 0056 001h]               Subtable Type : 00 [Processor Hierarchy Node]
+[039h 0057 001h]                      Length : 14
+[03Ah 0058 002h]                    Reserved : 0000
+[03Ch 0060 004h]       Flags (decoded below) : 00000011
+                            Physical package : 1
+                     ACPI Processor ID valid : 0
+                       Processor is a thread : 0
+                              Node is a leaf : 0
+                    Identical Implementation : 1
+[040h 0064 004h]                      Parent : 00000024
+[044h 0068 004h]           ACPI Processor ID : 00000000
+[048h 0072 004h]     Private Resource Number : 00000000
+
+[04Ch 0076 001h]               Subtable Type : 00 [Processor Hierarchy Node]
+[04Dh 0077 001h]                      Length : 14
+[04Eh 0078 002h]                    Reserved : 0000
+[050h 0080 004h]       Flags (decoded below) : 0000000A
+                            Physical package : 0
+                     ACPI Processor ID valid : 1
+                       Processor is a thread : 0
+                              Node is a leaf : 1
+                    Identical Implementation : 0
+[054h 0084 004h]                      Parent : 00000038
+[058h 0088 004h]           ACPI Processor ID : 00000000
+[05Ch 0092 004h]     Private Resource Number : 00000000
+
+Raw Table Data: Length 96 (0x60)
+
+    0000: 50 50 54 54 60 00 00 00 02 27 42 4F 43 48 53 20  // PPTT`....'BOCHS
+    0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
+    0020: 01 00 00 00 00 14 00 00 11 00 00 00 00 00 00 00  // ................
+    0030: 00 00 00 00 00 00 00 00 00 14 00 00 11 00 00 00  // ................
+    0040: 24 00 00 00 00 00 00 00 00 00 00 00 00 14 00 00  // $...............
+    0050: 0A 00 00 00 38 00 00 00 00 00 00 00 00 00 00 00  // ....8...........

Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
---
 tests/data/acpi/riscv64/virt/PPTT           | Bin 0 -> 96 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/riscv64/virt/PPTT b/tests/data/acpi/riscv64/virt/PPTT
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..15598a9b8a3cc0cdd50bc1f77c73ae0ba728a272 100644
GIT binary patch
literal 96
zcmWFt2nk7GU|?WUck*}k2v%^42yj*a0!E-1hz+6{L>L$ZK{PUeim9N9aRK=jNMZmJ
Cwg&+K

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 94be7a69a22e..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/riscv64/virt/PPTT",
-- 
2.43.0


