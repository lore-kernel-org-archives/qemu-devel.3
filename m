Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA43C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 16:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKJou-00038h-IG; Wed, 28 May 2025 12:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJos-000353-IK
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:39:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJop-00077A-9s
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:39:58 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCq321022193;
 Wed, 28 May 2025 16:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=F3MAN
 f9b/OGaaTOINQU/nwlAedax3Z4dTG7FaSxCpdc=; b=Aare72FJweRThBZx72g6U
 xYZEZR+MHP5jYZc1G+YhlISb3F2vSM2UTzx9uzPq7MDhNM7oPEXoUTvC+oLV+MB1
 lqvtsvUfKx+o3k56bGJtZA6Qng57CAMrm+HMJxHyIhsIoAwBZogkZP+B7Uj1FXaC
 E01YdbOWfycpv1u+v7SNh1sSFyMWPwmPu2HaK1fWhc66GpmY4syhYfUciqneNAYe
 vNSlqakaZZ0D8otOQyvfi9EgKEUVGDn3qBgoll08tRftnuZ9E+dntvaYYsSMZhOr
 1CEJtKpevSSgEAZb9GA6G+fafS5ZQVKpdH1e7A/i2eJ7Ll80bXDTLAp7ZMVt8HKg
 Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0g2eh27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:39:47 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SFi5Ai027802; Wed, 28 May 2025 16:39:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jannrs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:39:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54SGZvH8004472;
 Wed, 28 May 2025 16:39:45 GMT
Received: from localhost.localdomain (dhcp-10-43-12-51.usdhcp.oraclecorp.com
 [10.43.12.51])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46u4jannr0-1; Wed, 28 May 2025 16:39:45 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, annie.li@oracle.com, miguel.luis@oracle.com
Subject: [PATCH 04/13] tests/qtest/bios-table-tests: Update ACPI table
 binaries for x86
Date: Wed, 28 May 2025 12:39:35 -0400
Message-ID: <20250528163935.2175-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250528163545.2143-1-annie.li@oracle.com>
References: <20250528163545.2143-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0NSBTYWx0ZWRfXxe8njYO8CQGJ
 mv8VpegWFhvtI1XGmnpuQhbg0Cbr314m8eVBV4PnxUwStun+JBsx4WoqNdyJ6i0ZXMFTyK2GM+w
 B3uD+zdz8KLLbYW5mIgUgVtHmMDDII83YN+Jkus1oHgyAxLlXCWX5BrE16+BtBeIVWE+6kmcBLH
 vjNZJNDEABVYTnbleGNA8gG8w0lkG50+kKuElJKGwvzuhxAQsmdPRCZhNiw5YIhyFati1n0LVJE
 +cEVdbcWKXH5iHVhDA7Kyv3co4Orj/Av1rtc9k+ft+/slfzeK26ESrxSS1JEHdtDpa7v1/zkwXu
 AmzC2rFRbPMW3tMN8ZZnX50vJwiie0i4yrG0+p9KLYRK0oXyDfew5RIPgYiofsuswLuC1geoZC5
 Q2XRj8js88kMyslEAwqvGZW5v5UB/22HT3OKRQUhz+VBTTZ6CNJcI5Mo7b68ROQX4qO1Cyzv
X-Authority-Analysis: v=2.4 cv=NJLV+16g c=1 sm=1 tr=0 ts=68373c53 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=oGYXHMgr1OCP1unz2CkA:9
X-Proofpoint-ORIG-GUID: kk0ZPjjGingjJxZ89iCcP16YICNQsBup
X-Proofpoint-GUID: kk0ZPjjGingjJxZ89iCcP16YICNQsBup
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Following is the diff generated by the step 5 and 6 in
tests/qtest/bios-tables-test.c

Diff from iasl to show changes in DSDT table:

@@ -1,30 +1,30 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20210604 (64-bit version)
  * Copyright (c) 2000 - 2021 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
  * Disassembly of tests/data/acpi/x86/q35/DSDT, Tue May 27 15:40:59 2025
  *
  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x000020F8 (8440)
+ *     Length           0x00002166 (8550)
  *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
- *     Checksum         0xBE
+ *     Checksum         0x1E
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
 DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPC    ", 0x00000001)
 {
     Scope (\)
     {
         OperationRegion (DBG, SystemIO, 0x0402, One)
         Field (DBG, ByteAcc, NoLock, Preserve)
         {
             DBGB,   8
         }

@@ -2852,32 +2852,57 @@
             {
                 Memory32Fixed (ReadOnly,
                     0xFED00000,         // Address Base
                     0x00000400,         // Address Length
                     )
             })
         }
     }

     Scope (_GPE)
     {
         Name (_HID, "ACPI0006" /* GPE Block Device */)  // _HID: Hardware ID
     }

     Scope (_SB)
     {
+        Device (SLPB)
+        {
+            Name (_HID, EisaId ("PNP0C0E") /* Sleep Button Device */)  // _HID: Hardware ID
+            OperationRegion (\SLP, SystemIO, 0x0201, One)
+            Field (\SLP, ByteAcc, NoLock, WriteAsZeros)
+            {
+                SBP,    1
+            }
+        }
+    }
+
+    Scope (\_GPE)
+    {
+        Method (_L07, 0, NotSerialized)  // _Lxx: Level-Triggered GPE, xx=0x00-0xFF
+        {
+            If (\_SB.SLPB.SBP)
+            {
+                \_SB.SLPB.SBP = One
+                Notify (\_SB.SLPB, 0x80) // Status Change
+            }
+        }
+    }
+
+    Scope (_SB)
+    {
         Device (\_SB.PCI0.PRES)
         {
             Name (_HID, EisaId ("PNP0A06") /* Generic Container Device */)  // _HID: Hardware ID
             Name (_UID, "CPU Hotplug resources")  // _UID: Unique ID
             Mutex (CPLK, 0x00)
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 IO (Decode16,
                     0x0CD8,             // Range Minimum
                     0x0CD8,             // Range Maximum
                     0x01,               // Alignment
                     0x0C,               // Length
                     )
             })
             OperationRegion (PRST, SystemIO, 0x0CD8, 0x0C)
             Field (PRST, ByteAcc, NoLock, WriteAsZeros)

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 tests/data/acpi/x86/pc/DSDT                   | Bin 8611 -> 8721 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8522 -> 8632 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9936 -> 10046 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15482 -> 15592 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9075 -> 9185 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10265 -> 10375 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8562 -> 8672 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5100 -> 5210 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8683 -> 8793 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9970 -> 10080 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8469 -> 8579 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8617 -> 8727 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12404 -> 12514 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8440 -> 8550 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8457 -> 8567 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9765 -> 9875 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12650 -> 12760 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8719 -> 8829 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8486 -> 8596 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12053 -> 12163 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12998 -> 13108 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33855 -> 33965 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8904 -> 9014 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13231 -> 13341 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10094 -> 10204 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8515 -> 8625 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8528 -> 8638 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8457 -> 8567 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9799 -> 9909 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9570 -> 9680 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13293 -> 13403 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8302 -> 8412 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8298 -> 8408 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8446 -> 8556 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8541 -> 8651 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12998 -> 13108 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33855 -> 33965 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 9046 -> 9156 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9072 -> 9182 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18674 -> 18784 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14697 -> 14807 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35803 -> 35913 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |  42 ------------------
 43 files changed, 42 deletions(-)

diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
index 4beb5194b84a711fcb52e3e52cc2096497d18442..62bd8eae9602af4c590c6962689da54e4bff9c70 100644
GIT binary patch
delta 152
zcmZ4NJkf>ACD<iIP>F$oF<>LtX`Xt6_+Y2_=qAlzp8zM0cn?n(9>)tje9;XtK!JEh
zZbl}?=tdqe$1&ImC?a4J6Yn12Dq<S%V_?p(Krcq08Ds)TJ4n8O5lx^iMh_;>)ga*H
Q46)9G3#x4MGoHO70CXWM82|tP

delta 24
gcmbQ}ve=o+CD<iou_6Nl<A;r0r+GFz^PUp{0AxW3ApigX

diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
index abda6863b64c5dc8ba5aba1a286cbfa76772a1e4..6c9cf3df3902fb30c704b7a657c4c08402c28837 100644
GIT binary patch
delta 152
zcmX@*w8NRpCD<iohav+5<IIg*r+MlP;)9*yqnk8?eFB^~;ypZFcpNYA@I^Po00rV1
zxfz)lqZ@g^9LHcMpooA?OuT!5tB7g5kAXSE0=*c0W{?RW?I8IAMl^x87(JLgSA&3)
QGsHR%E~v82&v;Tq03>NE`v3p{

delta 24
fcmdnte9DQ-CD<jzOOb(r(PAUlX`ao_yrm)lUH%6H

diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
index d081db26d7ba504b3344fad130d5812419291ac0..36f952d730a1d64c1babf7adf05c0ed364f559f3 100644
GIT binary patch
delta 152
zcmccMyU&lyCD<jzPMv{)k#{54X`Xt6_+Y2_=qAlzp8zM0cn?n(9>)tje9;XtK!JEh
zZbl}?=tdqe$1&ImC?a4J6Yn12Dq<S%V_?p(Krcq08Ds)TJ4n8O5lx^iMh_;>)ga*L
Q39-(D3#x4MGoDwH0Ih*5tpET3

delta 24
gcmdnzcfps-CD<k8f*Jz@<Jyf}r+GFz^Zu3u0B*SmumAu6

diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
index e16897dc5f0fbb3f7b4de8db913884046246cc3b..da189168ffdae5817a4fe7b0e62531a333cb3d75 100644
GIT binary patch
delta 152
zcmexW@uHH;CD<k8g$)A(WBf+0(>(PC@xe~<(M_7cJ^@Y~@gANoJdPK5_@WzPfCBN1
z+>A_&(TzM{j$^PBP(;8cCf+^3Rm3#j$H1InfnJP0Gspyxc947lBbq>4j2=v$t3klY
Q8DgCW7gX8iXFOB%0jE+eBLDyZ

delta 24
gcmaD+`KyA<CD<jT%7%e~@!v+S(>$A<d6((~0DNZ&D*ylh

diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
index e95711cd9cde5d50b841b701ae0fed5a4b15e872..d6f96a071f1a7d570400dffedfd10af38eee0faf 100644
GIT binary patch
delta 152
zcmezD_RyWnCD<k8p)vyl<B^SAr+MlP;)9*yqnk8?eFB^~;ypZFcpNYA@I^Po00rV1
zxfz)lqZ@g^9LHcMpooA?OuT!5tB7g5kAXSE0=*c0W{?RW?I8IAMl^x87(JLgSA&34
Q0>nBGE~v82&v<&p0E=BL^8f$<

delta 24
fcmaFp{@IPoCD<jTSeb!=F?l1`X`ao_yz|5WYLN%t

diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
index 90ba66b9164f9a958d5a3c4371b1eec03e922828..ee06a74106606a3725b7f6882d020cf487873771 100644
GIT binary patch
delta 152
zcmbOk&>qO;66_MvuED^-Sh$hvK2N<te6Uk|bdzSVPk<9gyoaX?kK+X%zUYP+pg=q$
zHzN~cbR!R#;~4A&6cMnAiFXfh6)}zXF)(LXpckXh3^D<v9VB1Ch$he$qX(1cY7p=a
Qfmr9k1y#2B7mvI&0NQISX8-^I

delta 24
fcmZn<oEgC766_KpslmX&D6o<1KF{WGUIS?WQ{)C!

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
index 0eafe5fbf3d73719c9c3e6e26371863bfb44ed2f..1730d2ca1d83c08eca05e35ac1691e559a618489 100644
GIT binary patch
delta 152
zcmez5^uU?RCD<k8fg%F~W9vq)(>(PC@xe~<(M_7cJ^@Y~@gANoJdPK5_@WzPfCBN1
z+>A_&(TzM{j$^PBP(;8cCf+^3Rm3#j$H1InfnJP0Gspyxc947lBbq>4j2=v$t3klY
Q8DgCW7gX8iXFNS30AG15hX4Qo

delta 24
fcmaFh{K<*SCD<jTNRfeoQDr07X`ao_ymLhWXATFC

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbrroot b/tests/data/acpi/x86/pc/DSDT.hpbrroot
index 077a4cc988dc417a1bc9317dddd2dbd96ff1ff50..4ae9b5586f27761f77eabc801467a343a88d84a4 100644
GIT binary patch
delta 152
zcmaE(eoKSPCD<h-N`!%d@$g2j9PWC9_+Y2_=qAlzp8zM0cn?n(9>)tje9;XtK!JEh
zZbl}?=tdqe$1&ImC?a4J6Yn12Dq<S%V_?p(Krcq08Ds)TJ4n8O5lx^iMh_;>)ga*H
Q46)9G3#x2$J9jDv0MnK#{Qv*}

delta 24
fcmcbm@kX7?CD<k8jW7cPWAa9>9PZ6exXU;IX|o6f

diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
index 8d465f027772f9c59b0c328c1a099e374a6d2a90..71e2566c59b03670df98d8f3dced9b7f7df1a985 100644
GIT binary patch
delta 152
zcmaFueA9)?CD<h-Qi*|q@ytf9(>(PC@xe~<(M_7cJ^@Y~@gANoJdPK5_@WzPfCBN1
z+>A_&(TzM{j$^PBP(;8cCf+^3Rm3#j$H1InfnJP0Gspyxc947lBbq>4j2=v$t3klY
Q8DgCW7gX8iXFRN;05ZWVwg3PC

delta 24
fcmccV^4gipCD<k8wITxpW6nmd(>$A<dBsElZqf(7

diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
index e3b49757cb7abd7536ee89a6824967d2cb2485cf..5955bc2920d5327a90ae604d406496d73d543378 100644
GIT binary patch
delta 152
zcmez5`@oOOCD<h-L7jntQDr07X`Xt6_+Y2_=qAlzp8zM0cn?n(9>)tje9;XtK!JEh
zZbl}?=tdqe$1&ImC?a4J6Yn12Dq<S%V_?p(Krcq08Ds)TJ4n8O5lx^iMh_;>)ga*E
Q46)9G3#x4MGaeo(0P|uiP5=M^

delta 24
gcmaFh_sN&bCD<k8lNtj9<B^SAr+GFz^U6vA0CoNdPyhe`

diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
index 9e772c1316d0ea07c51717466c4c7e383553f345..2eef579e2fb3629b3e6a66eccb1565e2fbf2864d 100644
GIT binary patch
delta 152
zcmbR0)a=aV66_MvtjNH?D7BHxmZ#nzKG-Qfx=AzGC%}m#-ow*{$MFIWUvxtZP#~U>
zn~{kzx{(LWaSV0>iU`=m#JdN$ikQax7??9G(2LP$2AKfT4w5fmL=$L>(SylzH3&F4
QL#*@Qf-2h_!LwHc05@AI8UO$Q

delta 24
fcmZp6p6bNq66_Kps>r~=xN{?yEzjnyJm*9JRQv}a

diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
index 9bfbfc28213713c208dfc38a85abb46fb190871d..b2c8220fefd1175ff403a77f77ea2fab7675d096 100644
GIT binary patch
delta 152
zcmZ4KJl%!MCD<iIT#12!@y<rB(>(PC@xe~<(M_7cJ^@Y~@gANoJdPK5_@WzPfCBN1
z+>A_&(TzM{j$^PBP(;8cCf+^3Rm3#j$H1InfnJP0Gspyxc947lBbq>4j2=v$t3klS
Q8DgCW7gX8iXFP{R0Lqsu!vFvP

delta 24
gcmbR4veKE$CD<ior6L0ZW6egc(>$A<d9R270AVu+#Q*>R

diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
index efbee6d8aa5c62ff4fcb83e6c5cff59542977850..287ec23844e6887a24276d21b9bdcc415796e656 100644
GIT binary patch
delta 152
zcmey8@F<bXCD<k8kpTk(<K2y1r+MlP;)9*yqnk8?eFB^~;ypZFcpNYA@I^Po00rV1
zxfz)lqZ@g^9LHcMpooA?OuT!5tB7g5kAXSE0=*c0W{?RW?I8IAMl^x87(JLgSA&3)
QGsHR%E~v82&v^Qj0ln}oK>z>%

delta 24
fcmaEq_$7hMCD<jT#DIZ;v1TLJX`ao_yz`X-aRmrT

diff --git a/tests/data/acpi/x86/q35/DSDT b/tests/data/acpi/x86/q35/DSDT
index e5e8d1e041e20e1b3ee56a5c93fe3d6ebd721ee6..813e489f98b6be8958d8bf9bcf1d0b2eed691a5e 100644
GIT binary patch
delta 152
zcmez2_{@pRCD<h-O_70tQEnrbq-4E8e6Uk|bdzSVPk<9gyoaX?kK+X%zUYP+pg=q$
zHzN~cbR!R#;~4A&6cMnAiFXfh6)}zXF)(LXpckXh3^D<v9VB1Ch$he$qX(1cY7lU8
QhFIsp1y#1$MDhqb0FYQJkpKVy

delta 24
gcmaFn^uv+MCD<k8hXMlw<Gzhtl9HPzN?v6L0CM#Rm;e9(

diff --git a/tests/data/acpi/x86/q35/DSDT.acpierst b/tests/data/acpi/x86/q35/DSDT.acpierst
index 072a3fe2cd17dfe06658dfd82588f69787810114..2d81bcbc781d3fc68a053d5319fbdcfa153a4653 100644
GIT binary patch
delta 152
zcmeBl`tHQ#66_LEuE@Z^xNjquq-4E8e6Uk|bdzSVPk<9gyoaX?kK+X%zUYP+pg=q$
zHzN~cbR!R#;~4A&6cMnAiFXfh6)}zXF)(LXpckXh3^D<v9VB1Ch$he$qX(1cY7lU8
QhFIsp1y#1$MDi*-0Jz>N_5c6?

delta 24
fcmezF)ak_K66_MfsmQ><7`u^6QgZV|$!F{US$zim

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat b/tests/data/acpi/x86/q35/DSDT.acpihmat
index 2a4f2fc1d5c5649673353186e67ff5b5e59e8d53..0b911c9425d2f59fc6e0a2aac97fe23ee0b4a18d 100644
GIT binary patch
delta 152
zcmZ4LGufBRCD<iovKj*e<L!-Hl9KfX@xe~<(M_7cJ^@Y~@gANoJdPK5_@WzPfCBN1
z+>A_&(TzM{j$^PBP(;8cCf+^3Rm3#j$H1InfnJP0Gspyxc947lBbq>4j2=v$t3klg
Q6JnhQ7gX716UmP}0KMcZCjbBd

delta 24
fcmbR2yVQrvCD<iIRgHmxv1%iiq~zv_l1#h+Rh|Ya

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
index 7911c058bba5005d318b8db8d6da5c1ee381b0f1..bd0f517847bd71eb78db72010df699c1bea64d4a 100644
GIT binary patch
delta 152
zcmaErbR(I|CD<k8h9Lt3W5Y%+Ny&PH_+Y2_=qAlzp8zM0cn?n(9>)tje9;XtK!JEh
zZbl}?=tdqe$1&ImC?a4J6Yn12Dq<S%V_?p(Krcq08Ds)TJ4n8O5lx^iMh_;>)ga*S
Q2eHnB3#x3hiKLkX03_=xHUIzs

delta 24
fcmcbS{3?mdCD<h-%aDPAQGO$rq~zv_lI{`!XLtuC

diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator
index 580b4a456a20fc0cc0a832eaf74193b46d8ae8b1..3ab30d885f483c1626a9ab5a3501610923485462 100644
GIT binary patch
delta 152
zcmeBo`Rl^v66_LEtHi*-ICUeJq-4E8e6Uk|bdzSVPk<9gyoaX?kK+X%zUYP+pg=q$
zHzN~cbR!R#;~4A&6cMnAiFXfh6)}zXF)(LXpckXh3^D<v9VB1Ch$he$qX(1cY7p=Y
Qfmr9k1y#1$MDjKV0J0=20{{R3

delta 24
fcmezC((l6M66_Mfuf)K>XtI$@QgZV|$u}GTS;PkN

diff --git a/tests/data/acpi/x86/q35/DSDT.applesmc b/tests/data/acpi/x86/q35/DSDT.applesmc
index 5e8220e38d6f88b103f6eb3eb7c78dfa466882dc..7e17c9ebb3b7d28526bd04c9af5ca05a3461ac13 100644
GIT binary patch
delta 152
zcmZ4HG{u?ACD<ioiXsC8Bi}|YNy&PH_+Y2_=qAlzp8zM0cn?n(9>)tje9;XtK!JEh
zZbl}?=tdqe$1&ImC?a4J6Yn12Dq<S%V_?p(Krcq08Ds)TJ4n8O5lx^iMh_;>)ga*H
Q46)9G3#x3hiR34C075n@I{*Lx

delta 24
fcmbQ@yv&KqCD<iIO_70taqUJfNy*I<C7C$@RoDhY

diff --git a/tests/data/acpi/x86/q35/DSDT.bridge b/tests/data/acpi/x86/q35/DSDT.bridge
index ee039453af1071e00a81ee7b37cf8f417f524257..9da24d83ea7ab37c354a0cdbecbcf5129a3e1621 100644
GIT binary patch
delta 152
zcmbOl*BsB~66_Mvtk1x}Xtj|`QnKD4KG-Qfx=AzGC%}m#-ow*{$MFIWUvxtZP#~U>
zn~{kzx{(LWaSV0>iU`=m#JdN$ikQax7??9G(2LP$2AKfT4w5fmL=$L>(SylzH3&F4
QL#*@Qf-2i=BKc4h0A%4RcK`qY

delta 24
fcmZpUpBl&I66_Kps?Wf{cyl9{q~zv_lAlBYTLK4u

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count b/tests/data/acpi/x86/q35/DSDT.core-count
index 7ebfceeb66460d0ad98471924ce224b7153e87ef..22bf4a17db1b8175db939c5159e1686c8bc54066 100644
GIT binary patch
delta 152
zcmX?>x+RUvCD<jz#F&ABaoR>MNy&PH_+Y2_=qAlzp8zM0cn?n(9>)tje9;XtK!JEh
zZbl}?=tdqe$1&ImC?a4J6Yn12Dq<S%V_?p(Krcq08Ds)TJ4n8O5lx^iMh_;>)gaK2
RzzDI=gA1Z=vx(#+NdT{dDyjeg

delta 24
gcmdmzb}W_4CD<k8m=Oa5quE9-Ny*I<B^OHq0BDs5v;Y7A

diff --git a/tests/data/acpi/x86/q35/DSDT.core-count2 b/tests/data/acpi/x86/q35/DSDT.core-count2
index d0394558a1faa0b4ba43abab66d474d96b477ff3..69e710caba4a353d3c0805acc8faba7043bf0ff3 100644
GIT binary patch
delta 154
zcmdnr!L+uMiOVI}C1h<20|VoWja-tF^#<|5PVv!An!!E+P8{(bo-RC&7kK!h8)AS0
z@r>MzOpMWuJYbGvuoF;3z$PZ%J-}7OG~UO+oMC}pj6O5S1dw)+d;uexKwFF+OrEPj
TptGC}VxI>WMBQc+N$zX_b$%=I

delta 26
hcmZ46$+W+NiOVI}CB(jkfq}7oBbTJ)=82Lr*#K~72iE`q

diff --git a/tests/data/acpi/x86/q35/DSDT.cphp b/tests/data/acpi/x86/q35/DSDT.cphp
index a055c2e7d3c4f5a00a03be20fd73227e322283a4..0b9e315600b8665a8cb4ddfc57c4cf60968d0b4f 100644
GIT binary patch
delta 152
zcmX@%y3LKtCD<jzOqqd!apFcUNy&PH_+Y2_=qAlzp8zM0cn?n(9>)tje9;XtK!JEh
zZbl}?=tdqe$1&ImC?a4J6Yn12Dq<S%V_?p(Krcq08Ds)TJ4n8O5lx^iMh_;>)ga)M
Q0I|-43#x3hiR2Vc0D`qDZ2$lO

delta 24
gcmdnycEXj*CD<k8gc1V-qv1v_Ny*I<C6{sn0Ag_mR{#J2

diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
index 20843549f54af1cb0e6017c4cfff7463318d9eb7..0a49b62f39f1e4e00db2d03bbf34de4e20f2ed7d 100644
GIT binary patch
delta 152
zcmZ3VJ~xBQCD<iI)`Wq9F=!)~q-4E8e6Uk|bdzSVPk<9gyoaX?kK+X%zUYP+pg=q$
zHzN~cbR!R#;~4A&6cMnAiFXfh6)}zXF)(LXpckXh3^D<v9VB1Ch$he$qX(1cY7lU8
QhFIsp1y#1$M6y~60Avm-6951J

delta 24
gcmbQ6u|A#4CD<ioy)gp=<EM>Wl9HPzO7=(r0BWlU8UO$Q

diff --git a/tests/data/acpi/x86/q35/DSDT.dimmpxm b/tests/data/acpi/x86/q35/DSDT.dimmpxm
index 664e926e90765550136242f7e3e0bdc7719c1853..1c14b91bb4d341d16527d330e2bb0515e2fafb81 100644
GIT binary patch
delta 152
zcmaFocgLU0CD<k8jyeMaqy0uMUCDZb_+Y2_=qAlzp8zM0cn?n(9>)tje9;XtK!JEh
zZbl}?=tdqe$1&ImC?a4J6Yn12Dq<S%V_?p(Krcq08Ds)TJ4n8O5lx^iMh_;>)ga&<
Q0<q463#x3hhol-G0QRCP-v9sr

delta 24
fcmccP|IUxgCD<h-Po05*@!m!*UCGT$CC&K&Y?uek

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmibt b/tests/data/acpi/x86/q35/DSDT.ipmibt
index 4066a76d26aa380dfbecc58aa3f83ab5db2baadb..5561088d97a871f858461680d77d016f6b71d799 100644
GIT binary patch
delta 152
zcmX@?w9%Q%CD<ioqap(XW6(w}Ny&PH_+Y2_=qAlzp8zM0cn?n(9>)tje9;XtK!JEh
zZbl}?=tdqe$1&ImC?a4J6Yn12Dq<S%V_?p(Krcq08Ds)TJ4n8O5lx^iMh_;>)ga*H
Q46)9G3#x3hi6lP<0GEO(^Z)<=

delta 24
fcmdn!eAtQ0CD<jzS&@N(@#97=Ny*I<B^5XTU!w;5

diff --git a/tests/data/acpi/x86/q35/DSDT.ipmismbus b/tests/data/acpi/x86/q35/DSDT.ipmismbus
index 6d0b6b95c2a9fd01befc37b26650781ee1562e2a..cecba8c0629f89d2ccdd017791be69e5a98f52fa 100644
GIT binary patch
delta 152
zcmccMw9lE#CD<iopCSVT<Kc~5l9KfX@xe~<(M_7cJ^@Y~@gANoJdPK5_@WzPfCBN1
z+>A_&(TzM{j$^PBP(;8cCf+^3Rm3#j$H1InfnJP0Gspyxc947lBbq>4j2=v$t3klY
Q8DgCW7gX716G<5k0P7zrnE(I)

delta 24
fcmdnze8Gv!CD<h-K#_rgF=->0q~zv_lDZrKT|fq)

diff --git a/tests/data/acpi/x86/q35/DSDT.ivrs b/tests/data/acpi/x86/q35/DSDT.ivrs
index 072a3fe2cd17dfe06658dfd82588f69787810114..2d81bcbc781d3fc68a053d5319fbdcfa153a4653 100644
GIT binary patch
delta 152
zcmeBl`tHQ#66_LEuE@Z^xNjquq-4E8e6Uk|bdzSVPk<9gyoaX?kK+X%zUYP+pg=q$
zHzN~cbR!R#;~4A&6cMnAiFXfh6)}zXF)(LXpckXh3^D<v9VB1Ch$he$qX(1cY7lU8
QhFIsp1y#1$MDi*-0Jz>N_5c6?

delta 24
fcmezF)ak_K66_MfsmQ><7`u^6QgZV|$!F{US$zim

diff --git a/tests/data/acpi/x86/q35/DSDT.memhp b/tests/data/acpi/x86/q35/DSDT.memhp
index 4f2f9bcfceff076490cc49b8286380295a340004..056366a2c9fd535fa02d7494181e76b6a76b4cfb 100644
GIT binary patch
delta 152
zcmX@^v(=Z&CD<ios~Q6X<EM>Wl9KfX@xe~<(M_7cJ^@Y~@gANoJdPK5_@WzPfCBN1
z+>A_&(TzM{j$^PBP(;8cCf+^3Rm3#j$H1InfnJP0Gspyxc947lBbq>4j2=v$t3klS
Q8DgCW7gX716G>rS00Y!2$N&HU

delta 24
fcmdn$d)$Z1CD<jzU5$Z(apFcUNy*I<B~^F<Ug8GH

diff --git a/tests/data/acpi/x86/q35/DSDT.mmio64 b/tests/data/acpi/x86/q35/DSDT.mmio64
index 0fb6aab16f1bd79f3c0790cc9f644f7e52ac37b1..3ab05c9ec6afa014ad53ad246fcba7336bef3901 100644
GIT binary patch
delta 152
zcmaFlb-|m<CD<k8f+_<8<K~TAl9KfX@xe~<(M_7cJ^@Y~@gANoJdPK5_@WzPfCBN1
z+>A_&(TzM{j$^PBP(;8cCf+^3Rm3#j$H1InfnJP0Gspyxc947lBbq>4j2=v$t3klS
Q8DgCW7gX716G=TD01g}~?*IS*

delta 24
fcmccM{m6^UCD<h-NtJ<tF=!)~q~zv_lJ-0RVyXu4

diff --git a/tests/data/acpi/x86/q35/DSDT.multi-bridge b/tests/data/acpi/x86/q35/DSDT.multi-bridge
index f6afa6d96d2525d512cc46f17439f7a49962b730..41543787c443606ccef7191c2b0bee6737efe752 100644
GIT binary patch
delta 152
zcmaExemjH9CD<h-+Ju3D(Rd@5q-4E8e6Uk|bdzSVPk<9gyoaX?kK+X%zUYP+pg=q$
zHzN~cbR!R#;~4A&6cMnAiFXfh6)}zXF)(LXpckXh3^D<v9VB1Ch$he$qX(1cY7lU8
QhFIsp1y#1$L~^GT0Kb|l>;M1&

delta 24
gcmcbe@iv{yCD<k8tuX@w<K>N9l9HPzN}iGe0C=|u^8f$<

diff --git a/tests/data/acpi/x86/q35/DSDT.noacpihp b/tests/data/acpi/x86/q35/DSDT.noacpihp
index 9f7261d1b06bbf5d8a3e5a7a46b247a2a21eb544..1c09aff8b5b8955730d5ca1737e4e7f6e698e401 100644
GIT binary patch
delta 152
zcmaFoaL19$CD<k8jsgP%BjZM{UE=iy@xe~<(M_7cJ^@Y~@gANoJdPK5_@WzPfCBN1
z+>A_&(TzM{j$^PBP(;8cCf+^3Rm3#j$H1InfnJP0Gspyxc947lBbq>4j2=v$t3klY
Q8DgCW7gX8itKu^`01GWE=Kufz

delta 24
gcmccP_|AdLCD<h-Pl17faluBeUE-UKBvx?%0BS-9?*IS*

diff --git a/tests/data/acpi/x86/q35/DSDT.nohpet b/tests/data/acpi/x86/q35/DSDT.nohpet
index 99ad629c9171ff6ab346d6b4c519e77ca23e5b1c..86a109d6b12d38501d4353b5f8e31e9f3c15dd43 100644
GIT binary patch
delta 152
zcmaFmaKn+yCD<k8h5`cv<BN@4-4gW%@xe~<(M_7cJ^@Y~@gANoJdPK5_@WzPfCBN1
z+>A_&(TzM{j$^PBP(;8cCf+^3Rm3#j$H1InfnJP0Gspyxc947lBbq>4j2=v$t3klY
Q8DgCW7gX8iWfDi&0caR3kN^Mx

delta 24
fcmccN_{xFHCD<h-OM!ubv3(;~x5Q><$*b%DW~~R9

diff --git a/tests/data/acpi/x86/q35/DSDT.numamem b/tests/data/acpi/x86/q35/DSDT.numamem
index fd1d8a79d3d9b071c8796e5e99b76698a9a8d29c..454aa65803d8da71c9d5f1a263fa0b59bb76af4f 100644
GIT binary patch
delta 152
zcmez8_{NFLCD<h-N0EVnan(jHNy&PH_+Y2_=qAlzp8zM0cn?n(9>)tje9;XtK!JEh
zZbl}?=tdqe$1&ImC?a4J6Yn12Dq<S%V_?p(Krcq08Ds)TJ4n8O5lx^iMh_;>)ga*E
Q46)9G3#x3hiR3AE0OrmsI{*Lx

delta 24
gcmaFk^v{vYCD<k8p8^8|qt`|*Ny*I<C2z9>0B`3AJOBUy

diff --git a/tests/data/acpi/x86/q35/DSDT.pvpanic-isa b/tests/data/acpi/x86/q35/DSDT.pvpanic-isa
index 89032fa0290f496be0c06c6382586541aa1118a8..8ef053f6dc2f1c3086756698c5953e857067df9d 100644
GIT binary patch
delta 152
zcmccXblREACD<k8v?2oo<He0!l9KfX@xe~<(M_7cJ^@Y~@gANoJdPK5_@WzPfCBN1
z+>A_&(TzM{j$^PBP(;8cCf+^3Rm3#j$H1InfnJP0Gspyxc947lBbq>4j2=v$t3klY
Q8DgCW7gX716G=@D010g>+W-In

delta 24
fcmX@@eAkJ~CD<h-R*`{$v0x*Yq~zv_l2#l5VE+c<

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count b/tests/data/acpi/x86/q35/DSDT.thread-count
index 7ebfceeb66460d0ad98471924ce224b7153e87ef..22bf4a17db1b8175db939c5159e1686c8bc54066 100644
GIT binary patch
delta 152
zcmX?>x+RUvCD<jz#F&ABaoR>MNy&PH_+Y2_=qAlzp8zM0cn?n(9>)tje9;XtK!JEh
zZbl}?=tdqe$1&ImC?a4J6Yn12Dq<S%V_?p(Krcq08Ds)TJ4n8O5lx^iMh_;>)gaK2
RzzDI=gA1Z=vx(#+NdT{dDyjeg

delta 24
gcmdmzb}W_4CD<k8m=Oa5quE9-Ny*I<B^OHq0BDs5v;Y7A

diff --git a/tests/data/acpi/x86/q35/DSDT.thread-count2 b/tests/data/acpi/x86/q35/DSDT.thread-count2
index d0394558a1faa0b4ba43abab66d474d96b477ff3..69e710caba4a353d3c0805acc8faba7043bf0ff3 100644
GIT binary patch
delta 154
zcmdnr!L+uMiOVI}C1h<20|VoWja-tF^#<|5PVv!An!!E+P8{(bo-RC&7kK!h8)AS0
z@r>MzOpMWuJYbGvuoF;3z$PZ%J-}7OG~UO+oMC}pj6O5S1dw)+d;uexKwFF+OrEPj
TptGC}VxI>WMBQc+N$zX_b$%=I

delta 26
hcmZ46$+W+NiOVI}CB(jkfq}7oBbTJ)=82Lr*#K~72iE`q

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm12 b/tests/data/acpi/x86/q35/DSDT.tis.tpm12
index f2ed40ca70cb13e733e39f4bad756be8688e01fe..a36710dd89085f8ec5f173b84d4cd2a25473530e 100644
GIT binary patch
delta 152
zcmccScEp{_CD<k8h%y5MqyI)ONy&PH_+Y2_=qAlzp8zM0cn?n(9>)tje9;XtK!JEh
zZbl}?=tdqe$1&ImC?a4J6Yn12Dq<S%V_?p(Krcq08Ds)TJ4n8O5lx^iMh_;>)ga*H
Q46)9G3#x3hiKG%20KDHSNdN!<

delta 24
fcmX@&e$9=`CD<h-Oqqd!@!du)Ny*I<C5^cNWdH|I

diff --git a/tests/data/acpi/x86/q35/DSDT.tis.tpm2 b/tests/data/acpi/x86/q35/DSDT.tis.tpm2
index 5c975d2162d0bfee5a3a089e79b5ba038f82b7ef..c7d737509dfd229d2dde46ea92d292039d854f79 100644
GIT binary patch
delta 152
zcmez1cF&#5CD<k8o-zXiBj-jgNy&PH_+Y2_=qAlzp8zM0cn?n(9>)tje9;XtK!JEh
zZbl}?=tdqe$1&ImC?a4J6Yn12Dq<S%V_?p(Krcq08Ds)TJ4n8O5lx^iMh_;>)ga*H
Q46)9G3#x3hiKGn|0K|zZYXATM

delta 24
fcmccT{=tpQCD<jTK$(Goam7Y1Ny*I<C4IR7XsQQt

diff --git a/tests/data/acpi/x86/q35/DSDT.type4-count b/tests/data/acpi/x86/q35/DSDT.type4-count
index 3194a82b8b4f66aff1ecf7d2d60b4890181fc600..2d8b82a36ef1a8a4325817b164f77ceda78dd42e 100644
GIT binary patch
delta 154
zcmew~k@3MKMlP3NmyiTc1_s8>8@VJU>kZ<Ao#LaLG=qHtoH*h=JY9GkFYxe1H^cx1
z;u*OanHZxRdB7aUU?-r6fK5!idw{EmX}phtIl}_I7=31t2_Wqt`2t2XfwmYum^@d5
UK+hp2h<zSh5OtePB=_k909vmsYybcN

delta 26
icmaDbiSg4!MlP3Nmyk~$3=E9H8@VJUH&2v2uMYr$`w0gC

diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
index 129d43e1e561be3fd7cd71406829ab81d0a8aba0..3920d98b2501b08a4e0d57767a8c47cd57080748 100644
GIT binary patch
delta 152
zcmaD^biJ6%CD<k8x+Mbx<HwC$l9KfX@xe~<(M_7cJ^@Y~@gANoJdPK5_@WzPfCBN1
z+>A_&(TzM{j$^PBP(;8cCf+^3Rm3#j$H1InfnJP0Gspyxc947lBbq>4j2=v$t3klY
Q8DgCW7gX716G>AA0Ch<#y8r+H

delta 24
fcmca!{IZD4CD<h-(~^OKal%F}Ny*I<CEXMNZrcaK

diff --git a/tests/data/acpi/x86/q35/DSDT.xapic b/tests/data/acpi/x86/q35/DSDT.xapic
index b37ab591110d1c8201575ad6bba83449d7b90b21..1c6c420f9edb16f2e706d2b495d6e856441de000 100644
GIT binary patch
delta 154
zcmcaTo$2HZCN7s?mk`e$1_s8*8@VJU>kZ<Ao#LaLG=qHtoH*h=JY9GkFYxe1H^cx1
z;u*OanHZxRdB7aUU?-r6fK5!idw{EmX}phtIl}_I7=31t2_Wqt`2t2XfwmYum^@d5
UK<h^~h<zSh5OtePB$pQf0DWdH00000

delta 26
icmX>(gX#8kCN7s?myp}t3=E9T8@VJUH&2w@Q3L>kAqj5)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index a1047913af..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,43 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/pc/DSDT",
-"tests/data/acpi/x86/pc/DSDT.acpierst",
-"tests/data/acpi/x86/pc/DSDT.acpihmat",
-"tests/data/acpi/x86/pc/DSDT.bridge",
-"tests/data/acpi/x86/pc/DSDT.cphp",
-"tests/data/acpi/x86/pc/DSDT.dimmpxm",
-"tests/data/acpi/x86/pc/DSDT.hpbridge",
-"tests/data/acpi/x86/pc/DSDT.hpbrroot",
-"tests/data/acpi/x86/pc/DSDT.ipmikcs",
-"tests/data/acpi/x86/pc/DSDT.memhp",
-"tests/data/acpi/x86/pc/DSDT.nohpet",
-"tests/data/acpi/x86/pc/DSDT.numamem",
-"tests/data/acpi/x86/pc/DSDT.roothp",
-"tests/data/acpi/x86/q35/DSDT",
-"tests/data/acpi/x86/q35/DSDT.acpierst",
-"tests/data/acpi/x86/q35/DSDT.acpihmat",
-"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
-"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
-"tests/data/acpi/x86/q35/DSDT.applesmc",
-"tests/data/acpi/x86/q35/DSDT.bridge",
-"tests/data/acpi/x86/q35/DSDT.core-count",
-"tests/data/acpi/x86/q35/DSDT.core-count2",
-"tests/data/acpi/x86/q35/DSDT.cphp",
-"tests/data/acpi/x86/q35/DSDT.cxl",
-"tests/data/acpi/x86/q35/DSDT.dimmpxm",
-"tests/data/acpi/x86/q35/DSDT.ipmibt",
-"tests/data/acpi/x86/q35/DSDT.ipmismbus",
-"tests/data/acpi/x86/q35/DSDT.ivrs",
-"tests/data/acpi/x86/q35/DSDT.memhp",
-"tests/data/acpi/x86/q35/DSDT.mmio64",
-"tests/data/acpi/x86/q35/DSDT.multi-bridge",
-"tests/data/acpi/x86/q35/DSDT.noacpihp",
-"tests/data/acpi/x86/q35/DSDT.nohpet",
-"tests/data/acpi/x86/q35/DSDT.numamem",
-"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
-"tests/data/acpi/x86/q35/DSDT.thread-count",
-"tests/data/acpi/x86/q35/DSDT.thread-count2",
-"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
-"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
-"tests/data/acpi/x86/q35/DSDT.type4-count",
-"tests/data/acpi/x86/q35/DSDT.viot",
-"tests/data/acpi/x86/q35/DSDT.xapic",
-- 
2.43.5


