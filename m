Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADEACC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHFJf-0003pq-EQ; Thu, 15 Oct 2026 02:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@oss.qualcomm.com>)
 id 1xHFJe-0003pf-OS
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:51:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@oss.qualcomm.com>)
 id 1xHFJc-0007lK-U9
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:51:50 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F3wbbr1889513
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FtXTyNE+ySF
 l1RccLZzdpB9NDkIK2AGfN/me+zt3GCc=; b=Pi9VsRYKXfVCHM4OAppIwL2tx0X
 Z/JP7Wc3t/UEw2pTjew+oNY9LcuDt6Mcm8rAn7u6BunuzbyoCAHXfGSOSwesIPbQ
 9ucDbdSqIQpG5Mg2TdBAjI2aS7Y/SOfQSi+QZaszYy1cu8+DTmUIVLFOdqarCI+b
 FdGjCtITkTO5ijAUF+oEoJqYwMkQQgfPd5aTgvqsCRJGDUTlfAIv1uVsbeWEdb6y
 oTDkitdFO6YjuSFPQbwxRsE9GILam8oj71J0rSBXkxh+hdtnGNUKvy7nnWnJAnuw
 mBKbyNNr6oXPWbwWNBx8RUjFfpnlocTbgPEG1V6snTKl+CGYM2X7MLNBbNQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqda0kjw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:51:47 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1663fb7e005so6334943c88.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792047107; x=1792651907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FtXTyNE+ySFl1RccLZzdpB9NDkIK2AGfN/me+zt3GCc=;
 b=StDfCgC6Su3qnnzrDfWSIa1bfCSNl3mzIpzkJjndYQD2Ja9rXGoKbGbYfK6zVzyam1
 2U67bbocs+NRh+uqaLAturRUkyAAOh66rgZXXwKi/uWB20lIpWwDADHBHoo5rkUyu0vS
 5COrcgJnLOo3aHueiNdAevQ1NTI7miQg3/5geA82QePPALCoZiA2tnkxpKVn+WPBga40
 sWE+2QdxKAf326p/ImZoaV1P7RRBGwBirWsp1ePom2aURfAFuBCLuPjmX2C5KPvaw/sz
 DroHH64GObd2ye/931C0mPWh8SCzhC3ajk6SQcUYZ+Nn3WLeymyQoqjVbspF1bEu53cQ
 fbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792047107; x=1792651907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FtXTyNE+ySFl1RccLZzdpB9NDkIK2AGfN/me+zt3GCc=;
 b=lHgWzoNdfb0chNd862d52D5aR2OTMaEXuRbIQh7fAK/qSztoxvnxdxsuwlZhjOvwLb
 N/OFh7PI7WdOavagfnVW30CGtaikNRKgxMwI/Anh+SnqhgSPXsg11FdyXXCni10mlQgI
 LlNJWn+nYgpXns0fxXjuSEjM0i2gATjtDArzky2PINJYAGdmK0wgDQVYBluEr4wbVBci
 6Kp+AREdWjVFmpP9SZUpyhJq/AaYiQSGUEWJb+cnSL0F9q8Kc3CqiBfSBAbfNf0H1nRV
 RR1mzZALvTJBtU3YIMPKSCTDwuxnwTHm+PIvBq6KMWHhWHwTeR+8qwlH6FStAAkNTr9C
 3+iQ==
X-Gm-Message-State: AFq9FYL7keO3PPto09cysVJZ9//xCPyOnjxsL9Xh2EHqSdtURQ2YT6la
 68L4T5Tz3tJSF1WJf6rIIuBDS2atHfNRTKQd9l3KTk7yE9ViT5RWz2LuWJJhnjHrqj4okxPc+Zj
 Gt4kYz87m4FLq6C1fr2s2kyoJ6nP0RThNKf1QXd26/q2Xupqs1cVRgDdsX5mqFnPeZw==
X-Gm-Gg: AYBFou0WF7IAjRfKem/yNWCTBwxWYNJHw5iqJ0A9AZGPV/+A1V3j3PuSjsCxVLp66/A
 /ey6KYYCnvXStObuuZODs5XMhK3xsvVZOgWUMhFYMcQyDKJaYs01XAAR+vUHQSzPcjEZ6RDhnua
 I3QNJWFnh26SegnhGQdrV3EVUy5N/chg7NUHB+pRKYz6b6lQ6MCPr1JmrE/LNZJcooIfKrQjBoD
 zC02XMJVzdkF3xO8wSPF5LFAsAMJ6Ez7XHVOvprchJcwXjXlg+RDYbrJDKEMxfsA0aRbwzvg+Kp
 w4LhFpk4TWbRt7O6/Fim2lNipW+8EE3alsSeH1g1FUyxAdPr5XEXQQjhgFuk1irOplvDHYw8nj7
 bZ8Jv6Y0Kxx9kUQoFXBA6UccYVNktZQw6lk/2PQ4U52f0so9aHl+g5EJ3hdltd2v2+kKzMwOI9G
 A9pqOyYzJXJog=
X-Received: by 2002:a05:7022:ea56:20b0:17f:7280:134b with SMTP id
 a92af1059eb24-17f72801559mr3244916c88.30.1792047106738; 
 Wed, 14 Oct 2026 23:51:46 -0700 (PDT)
X-Received: by 2002:a05:7022:ea56:20b0:17f:7280:134b with SMTP id
 a92af1059eb24-17f72801559mr3244868c88.30.1792047106109; 
 Wed, 14 Oct 2026 23:51:46 -0700 (PDT)
Received: from hu-sunilvl-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm67451789c88.16.2026.10.14.23.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 23:51:45 -0700 (PDT)
From: Sunil V L <sunilvl@oss.qualcomm.com>
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
 Drew Fustini <fustini@kernel.org>, Prajwal N <prajwal.n@oss.qualcomm.com>,
 Shankar C <shankar.c@oss.qualcomm.com>,
 Sunil V L <sunilvl@oss.qualcomm.com>
Subject: [PATCH v2 3/4] tests/qtest/bios-tables-test: Update riscv64 virt PPTT
 golden reference
Date: Thu, 15 Oct 2026 12:19:56 +0530
Message-ID: <20261015064957.4076464-4-sunilvl@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
References: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyNyBTYWx0ZWRfX2ieX/G4O12cB
 FoUqniM5Fj8OaDDduwpPh+H2v1xqOVCzEVrfnN04/fQ9OOLPNIKHAxYtl0zIKRN2EnjHHxNVXBb
 1B9e5WlPaMgTx5BRjgZyRIvX7sZnCWc=
X-Authority-Analysis: v=2.4 cv=K9u3jCWI c=1 sm=1 tr=0 ts=6ad07803 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=7nS_kZPvwonqTfo6PMEA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: sEJ-FmKvH6A_hYjBsAOZ1LqjKJXxUzlO
X-Proofpoint-ORIG-GUID: sEJ-FmKvH6A_hYjBsAOZ1LqjKJXxUzlO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyNyBTYWx0ZWRfXxvyS1InwPua0
 asouJrcF8laMerh8NcEUeeH5Gerid+EAP4Ug3FekNYKcCYDqYJ6O8uu5iSSytYnkn6HiB0Puscs
 u/urmbJ1sLNrZtmwR2w4i46pmxWWipdzvAeTNdEavlr8QskFQ0tBnBf93fkvkwVY1DfJ+JlxzGZ
 7C4OFG3RNsPdAz4iWrmOiQVg/16OK9CqPV8eN/JScoDZzuiJ//U48JA7NTGvGRIl0oN3Wq+sK7p
 JEyVTvagKLSFg59IYerqgeda9AN05xvJy1YhdeXEl0Braw71j8+fCvjLn8JTaoaWvvLrVaIbjHY
 KxFCt4OwPA8C06iKPlkfSlye8THSN1+YdfhCrH0i8B9xWJw5sPQbDcEIyMcZ3qO1/+xO5lvG7Y0
 +xtpXwrOhdqBwABeThMX9YUHEqpIY2Vq/uB6eNVAM7Y4eeYkHf5X68Ne8RLo+1GZ8NiVSy+ScgG
 D6MiRKF+wbmYEePRC4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150027
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=sunilvl@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Update the RISC-V PPTT reference to match the actual PPTT generated by
QEMU.

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
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
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


