Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111E4C55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 18:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrJu5-0006J8-Ew; Tue, 04 Aug 2026 14:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wrJtg-0006CW-Gq; Tue, 04 Aug 2026 14:29:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wrJtd-0004ew-LG; Tue, 04 Aug 2026 14:29:52 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674FlcUq1254399; Tue, 4 Aug 2026 18:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KNXfZ17SNliyzgTBA
 6dS0Av981buiMUBpl6Q8DZjMSY=; b=S/k+wlQXNZk0fpf8cFKjjeJxQ7UEhNX45
 WBhEo6FcwzaLeuS/hNe43ZVZ8r4upm+I9VvFySDTdxHQkxLW2hgO9rVTo4jYHmSG
 FwqPgb0XxnBia/0prK75Iix6aCU+5VuZgr51Bwudk+DiZlKWfFZCiRxh/SBjdK5T
 2DMuagZRauOdIkpZ3pSmcF3D3jWit7/Ybs321YtmJFDHNJiI1cO/NDt+b26KCcQa
 mqRpaM1fHBtqUBmb1J8JZbAmO7LL6aF4w9pO8P/L+pWhwmJbT5tfWycZSKwnIxn2
 M8T/nWsYhbHmKobzi8KnCPjDxVCWzZnYDGZUJLTEFjzqQIGg7HnOA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3ycy0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 18:29:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674IQJME029912;
 Tue, 4 Aug 2026 18:29:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhb5cb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 18:29:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 674ITfeq36372836
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2026 18:29:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C3BE20043;
 Tue,  4 Aug 2026 18:29:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D77D2004B;
 Tue,  4 Aug 2026 18:29:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.28.45])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2026 18:29:38 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH v5 1/3] [DO_NOT_MERGE] linux-headers: Add uapi header changes
Date: Tue,  4 Aug 2026 23:59:12 +0530
Message-ID: <20260804182914.83091-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260804182914.83091-1-amachhiw@linux.ibm.com>
References: <20260804182914.83091-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a722f9a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=s0W6FxVOU_Te4IgUSpQA:9
X-Proofpoint-ORIG-GUID: pudrksY9_O2uKcJkJaaEbEG0dtBuNKAJ
X-Proofpoint-GUID: 2szFs18Vltwe9CebE245489Ikwmfz8yj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0OCBTYWx0ZWRfX8JmyqqfS18AT
 4MWvSDWGb4K22Y6LIiL8X4SZD3UlYIpHe3NsPMSWbWfI1jB13oAZHJv8Ak2CcDzDTIwTX5rTCpo
 LtawhD+qduzI0e8Q+OM3KN6fsQtXOXw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0OCBTYWx0ZWRfX978s91lG6+qC
 cVV9JJnEuvegd6ptznDxxCXdwBnKTbilkDwvdB/9AbncqtgHtHCEZlbZAmD4RvkKqmPmM0jB7bg
 r3FznjeVSiNnxsp/nIekJKoImXbZih5HS0SaZRGaG7OY8DAvxeFovcjSwJVQddOx4dK6SnlGTVv
 Kc7ojrJ5AgPpxn0BN+1lmlU+QfeNMIBFyHkMzfy9QHPz9Z/iIdEfp6GAfzRusroflpwpTdiqNhG
 XsZ63EX1Sz0NCfSU0pVcJaPzy9RVu6RCPfzyw/vte62w+Srzw1BhGbRY3SnJey/U3NzKcKbZ0j4
 7uPokkhI8G4bavPfFWTMEHvDfFxpRyeJGHB+xTdWj9vETzNUhvNlG9Q2bKnkQeX5UhMiMAiFDwt
 +eriyayVo3B/Nk/jfmlOk9KuKQbLHKd08QqFaOJeiPPOw1fUH3x5HgBgXhOZjVr/CW3Ki1NnflJ
 468sn+PxJDoidSyunJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040148
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is a temporary patch intended for review and testing purposes only.
It syncs the QEMU linux-headers with the kernel v6 changes that introduce
the KVM_PPC_GET_COMPAT_CAPS ioctl for querying host CPU compatibility
capabilities. The struct kvm_ppc_compat_caps places 'size' as the first
field as required by copy_struct_from/to_user() versioning, with
KVM_PPC_COMPAT_CAPS_SIZE_VER0 (24) defined as the frozen version-floor
constant. The capability number is KVM_CAP_PPC_COMPAT_CAPS (250) and
the ioctl is defined as _IO so the ioctl number remains stable if the
struct grows in future versions. Capability bit definitions for POWER9,
POWER10, and POWER11 compatibility modes are also included.

The actual header sync will be done via scripts/update-linux-headers.sh
once the kernel changes [1] are merged upstream.

[1] https://lore.kernel.org/all/20260804180705.59160-1-amachhiw@linux.ibm.com/

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in this version:
- Updated KVM_PPC_GET_COMPAT_CAPS ioctl number from 0xe4 to 0xb8 to
  match the corresponding Linux kernel v6 series change; the
  0xe0-0xe3 range is reserved for KVM_CREATE_DEVICE fd ioctls

 linux-headers/asm-powerpc/kvm.h | 19 +++++++++++++++++++
 linux-headers/linux/kvm.h       |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index 077c5437f521..2c229fe0562c 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -437,6 +437,25 @@ struct kvm_ppc_cpu_char {
 	__u64	behaviour_mask;		/* valid bits in behaviour */
 };
 
+/* For KVM_PPC_GET_COMPAT_CAPS */
+struct kvm_ppc_compat_caps {
+	__u64	size;			/* Size of this structure */
+	__u64	flags;			/* Reserved for future use */
+	__u64	compat_capabilities;	/* Capabilities supported by the host */
+};
+#define KVM_PPC_COMPAT_CAPS_SIZE_VER0	24 /* sizeof first published struct */
+
+/*
+ * Capability bits for compat_capabilities field in kvm_ppc_compat_caps.
+ * These bits indicate which processor compatibility modes are supported.
+ */
+#define KVM_PPC_COMPAT_CAP_POWER9	(1ULL << 62)
+#define KVM_PPC_COMPAT_CAP_POWER10	(1ULL << 61)
+#define KVM_PPC_COMPAT_CAP_POWER11	(1ULL << 60)
+#define KVM_PPC_COMPAT_BITMASK		(KVM_PPC_COMPAT_CAP_POWER9 | \
+					 KVM_PPC_COMPAT_CAP_POWER10 | \
+					 KVM_PPC_COMPAT_CAP_POWER11)
+
 /*
  * Values for character and character_mask.
  * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index dd52e2a65bfd..aea4ab5c6953 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -986,6 +986,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
+#define KVM_CAP_PPC_COMPAT_CAPS 250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1330,6 +1331,8 @@ struct kvm_s390_keyop {
 /* Available with KVM_CAP_COUNTER_OFFSET */
 #define KVM_ARM_SET_COUNTER_OFFSET _IOW(KVMIO,  0xb5, struct kvm_arm_counter_offset)
 #define KVM_ARM_GET_REG_WRITABLE_MASKS _IOR(KVMIO,  0xb6, struct reg_mask_range)
+/* Available with KVM_CAP_PPC_COMPAT_CAPS */
+#define KVM_PPC_GET_COMPAT_CAPS	_IO(KVMIO,  0xb8)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.50.1 (Apple Git-155)


