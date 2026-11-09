Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA4D606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ax4XGijs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW1X-0003sU-9v; Mon, 09 Nov 2026 15:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSu8-0005Q6-D8
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:11:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSu3-0004Bc-Ax
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:11:35 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DF5B03701918; Mon, 9 Nov 2026 17:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JpUqKGyJMwDfRrIyf
 WQjKrxlV3OXYk1YGxkzkDUeOGo=; b=Ax4XGijsnsDGrtaWwY9WOkAFRiXV0NCWP
 WTuCEjZWXFNsiQkBOoCoHLoaq0FnQIqjbDAFOGdHWiw8pcmGb70EwV0KYBviVxsD
 FPeYc1HBmvAfoE4BCdhjCNAvDOhRKxXMq4zRYcuawaN84RZk4aZKTC6RD1yLo7XR
 3z0YixOYJ5re39+DsoAmVQGAIX8FEhWxz4bouKnUqF3d8qjNthc6pirLOjfRJqRj
 2HesYRaUxsaFmGMswoyjoIpyOSPYK5sFRzcy1QBvInul8DjAoGOYtMAuZomCLA2w
 Sp6H706Cptty7Gjy1C6dMJQPZnB9ouVTdF4s0iI8gfXEf/rPlnOug==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug5ykq3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 17:11:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9GoP9I173296; Mon, 9 Nov 2026 17:11:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthhqqt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 17:11:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A9HBNiq44564808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Nov 2026 17:11:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E0C420043;
 Mon,  9 Nov 2026 17:11:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4D7E2004B;
 Mon,  9 Nov 2026 17:11:22 +0000 (GMT)
Received: from a46lp03.lnxne.boe (unknown [9.87.84.240])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Nov 2026 17:11:22 +0000 (GMT)
From: Bjoern Walk <bwalk@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
 Andreas Grapentin <gra@linux.ibm.com>, Bjoern Walk <bwalk@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC Patch 4/8] scripts/update-linux-headers: Post-process KVM UAPI
 kernel headers
Date: Mon,  9 Nov 2026 18:10:30 +0100
Message-ID: <20261109171036.3806884-5-bwalk@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109171036.3806884-1-bwalk@linux.ibm.com>
References: <20261109171036.3806884-1-bwalk@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XS1MYaSCplLTpgf0BKJGLfZcoqB9RTBq
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af1fec0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=vfzFc5w0W8UZkTp7TMwA:9
X-Proofpoint-GUID: XS1MYaSCplLTpgf0BKJGLfZcoqB9RTBq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX6IhGmvpKMKIH
 Ullwe5q1a5oMAB44Qx2d1Sb1u3knSknM9vW8KLLIJS5N7KcYC9FL4ctQvAP7EwBYlGvoYLI2BQn
 P6nBoYh5d+XxI3Qg3IoaXS5TTXT5nYgAxNtM+zy9ajIaeW9oCl15s34JL6ph4HQo9cpdKj5C2hu
 0vOLadFVOETx5wX+55ITsoITnstK6DFR0gTzTZyIEzkYJROdYg17TCDHTpTMHEH7QSPhZUAVlIN
 9ybELzY4vYGF634oX77dc7B7ujLQCkWsSL1bK2KEfF88qxSWc2Johhwemct23z+vjmVn//ts6K9
 sh5Vf70ZOGuqGrGxV+zzX8+XawCny/j59JIDzzIvW5hLaNB1qUnhx+VrMvD0arxMf/Q+4JqMvhJ
 kKoS7L7QnYaExgG5uEbHhNzXcsu9SVJwjta3fZh26qwETVzkeRcAkKdnJ5tyb69+wMCptp9BNi/
 OqN4asY0f+ObAHBKudQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX9OOZGDdno/X9
 c0GYk4Y+PBZ4lOQaa8yU50ah0LjioUdP/j3pXXPOhVUEFIt5ceJX6xxnuQsbSOgLuKOo2MILqwO
 PXNx6W4Hd63nBBdsCgmEoe1lu2uiTdc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090066
Received-SPF: pass client-ip=148.163.156.1; envelope-from=bwalk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:31:03 -0500
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

To give QEMU more control over the selection of KVM UAPI architecture,
we need to post-process the kernel headers.

First, we need to make the paths of transient include dependencies
explicitly refer to the architecture they belong to. This change doesn't
affect anything and is safe, since it is never sensible to mix UAPI
header files from different architectures.

Second, we need to drop the include of <asm/kvm.h> in <linux/kvm.h> so
that we can delegate the inclusion of architecture-dependent UAPI
headers to the QEMU source code (in "system/kvm.h"). This change makes
<linux/kvm.h> defunct by itself, so we guard it from being included at
compile time.

Signed-off-by: Bjoern Walk <bwalk@linux.ibm.com>
---
 scripts/update-linux-headers.sh | 60 ++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 3c3a0e93..cd8b5035 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -46,6 +46,20 @@ if [ -z "$output" ]; then
     output="$PWD"
 fi
 
+cp_asm() {
+    f=$1
+    to=$2
+
+    if test -z "$arch"; then
+        exit 2
+    fi
+
+    header=$(basename "$f");
+
+    sed -e '/\#include/s/<asm\/\([^>]*\)>/"asm-'$arch'\/\1"/' \
+        $f > "$to/$header"
+}
+
 cp_portable() {
     f=$1
     to=$2
@@ -132,7 +146,7 @@ for arch in $ARCHLIST; do
     mkdir -p "$output/linux-headers/asm-$arch"
     for header in kvm.h unistd.h bitsperlong.h mman.h; do
         if test -f "$hdrdir/include/asm/$header"; then
-            cp "$hdrdir/include/asm/$header" "$output/linux-headers/asm-$arch"
+            cp_asm "$hdrdir/include/asm/$header" "$output/linux-headers/asm-$arch"
         elif test -f "$hdrdir/include/asm-generic/$header"; then
             # not installed as <asm/$header>, but used as such in kernel sources
             cat <<EOF >$output/linux-headers/asm-$arch/$header
@@ -142,30 +156,30 @@ EOF
     done
 
     if [ $arch = mips ]; then
-        cp "$hdrdir/include/asm/sgidefs.h" "$output/linux-headers/asm-mips/"
-        cp "$hdrdir/include/asm/unistd_o32.h" "$output/linux-headers/asm-mips/"
-        cp "$hdrdir/include/asm/unistd_n32.h" "$output/linux-headers/asm-mips/"
-        cp "$hdrdir/include/asm/unistd_n64.h" "$output/linux-headers/asm-mips/"
+        cp_asm "$hdrdir/include/asm/sgidefs.h" "$output/linux-headers/asm-mips/"
+        cp_asm "$hdrdir/include/asm/unistd_o32.h" "$output/linux-headers/asm-mips/"
+        cp_asm "$hdrdir/include/asm/unistd_n32.h" "$output/linux-headers/asm-mips/"
+        cp_asm "$hdrdir/include/asm/unistd_n64.h" "$output/linux-headers/asm-mips/"
     fi
     if [ $arch = powerpc ]; then
-        cp "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-powerpc/"
-        cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-powerpc/"
+        cp_asm "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-powerpc/"
+        cp_asm "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-powerpc/"
     fi
 
     rm -rf "$output/include/standard-headers/asm-$arch"
     mkdir -p "$output/include/standard-headers/asm-$arch"
     if [ $arch = s390 ]; then
         cp_portable "$hdrdir/include/asm/virtio-ccw.h" "$output/include/standard-headers/asm-s390/"
-        cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-s390/"
+        cp_asm "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-s390/"
     fi
     if [ $arch = arm64 ]; then
-        cp "$hdrdir/include/asm/sve_context.h" "$output/linux-headers/asm-arm64/"
-        cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-arm64/"
+        cp_asm "$hdrdir/include/asm/sve_context.h" "$output/linux-headers/asm-arm64/"
+        cp_asm "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-arm64/"
     fi
     if [ $arch = x86 ]; then
-        cp "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
-        cp "$hdrdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
-        cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
+        cp_asm "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-x86/"
+        cp_asm "$hdrdir/include/asm/unistd_x32.h" "$output/linux-headers/asm-x86/"
+        cp_asm "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-x86/"
 
         cp_portable "$hdrdir/include/asm/kvm_para.h" "$output/include/standard-headers/asm-$arch"
         cat <<EOF >$output/linux-headers/asm-$arch/kvm_para.h
@@ -182,20 +196,28 @@ EOF
                     "$output/include/standard-headers/asm-x86"
     fi
     if [ $arch = riscv ]; then
-        cp "$hdrdir/include/asm/ptrace.h" "$output/linux-headers/asm-riscv/"
-        cp "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-riscv/"
-        cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-riscv/"
+        cp_asm "$hdrdir/include/asm/ptrace.h" "$output/linux-headers/asm-riscv/"
+        cp_asm "$hdrdir/include/asm/unistd_32.h" "$output/linux-headers/asm-riscv/"
+        cp_asm "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-riscv/"
     fi
     if [ $arch = loongarch ]; then
-        cp "$hdrdir/include/asm/kvm_para.h" "$output/linux-headers/asm-loongarch/"
-        cp "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-loongarch/"
+        cp_asm "$hdrdir/include/asm/kvm_para.h" "$output/linux-headers/asm-loongarch/"
+        cp_asm "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-loongarch/"
     fi
 done
 arch=
 
 rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
-for header in const.h stddef.h kvm.h vfio.h vfio_ccw.h vfio_zdev.h vhost.h \
+
+# Including architecture-dependent KVM UAPI header files is delegated to
+# "system/kvm.h". Remove including <asm/kvm.h> and add a guard to prevent
+# including <linux/kvm.h> in QEMU source code directly.
+sed -e '/\#define __LINUX_KVM_H/a \\n#ifndef QEMU_KVM_H\n#error Including <linux\/kvm.h> directly is prohibited, use "system\/kvm.h" instead\n#endif' \
+    -e '/\#include <asm\/kvm.h>/d' \
+    "$hdrdir/include/linux/kvm.h" >$output/linux-headers/linux/kvm.h
+
+for header in const.h stddef.h vfio.h vfio_ccw.h vfio_zdev.h vhost.h \
               psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h \
               vduse.h iommufd.h bits.h mshv.h; do
     cp "$hdrdir/include/linux/$header" "$output/linux-headers/linux"
-- 
2.56.0


