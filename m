Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB16CF54ACE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53vd-0002km-EP; Tue, 24 Mar 2026 11:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schlameuss@linux.ibm.com>)
 id 1w53vW-0002jC-2B; Tue, 24 Mar 2026 11:44:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schlameuss@linux.ibm.com>)
 id 1w53vU-0003Qi-2z; Tue, 24 Mar 2026 11:44:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O6rxXl196681; Tue, 24 Mar 2026 15:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=goAbn3
 M6s8E6UDo35Jz9BSCp5ZhlCs01KLjg80bSd0Q=; b=bqDGfEL+25HdehRO+DfeIS
 8LEwdjt93GQJFxOkVFU3xDrLx4o/KWsYwXaeblwvHMNvrkMgluV6lrQXJ1Tz9RXJ
 KDhYWQBy3UZpkkGD4bOLmOvnFEum7nhkrrktaHLJEoSIb56OxOxgIOPzF9YWr1a7
 ppyUH92W6aWGFGbvA83vAuUJHvmw1UMksmJKPBA/aq+MioypPnhvuT6iTpZV1JbZ
 CaNJj7HX46EMDV9A7XqiPUagq+DYzDK70AkdaeSbtplrIBSErX/eLT/E6i7nrrSM
 rJHYVl21H5sfk3ba+u4TjfNi/QSzFGPBUDIrNbvk7RiGA5sRX6EfkrjrupDDlLxg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumkrr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 15:44:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OD3dBd011788;
 Tue, 24 Mar 2026 15:44:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk2c77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Mar 2026 15:44:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62OFi7Ib24969518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 15:44:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C925120040;
 Tue, 24 Mar 2026 15:44:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDE3D20043;
 Tue, 24 Mar 2026 15:44:06 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.21.79])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2026 15:44:06 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 24 Mar 2026 16:43:44 +0100
Subject: [PATCH v2 1/2] linux-headers: Update to Linux v7.x with
 KVM_S390_VM_CPU_FEAT_ASTFLEIE2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-astfleie2-v2-1-13008712da00@linux.ibm.com>
References: <20260324-astfleie2-v2-0-13008712da00@linux.ibm.com>
In-Reply-To: <20260324-astfleie2-v2-0-13008712da00@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>, kvm@vger.kernel.org,
 Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=899;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=aguW8fYG0qpSz/k+6lHIr+3GbPHh6X/lMXQp85Z0fSg=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmHNroy3pqQPdFTWPvH00eaYs7Wcg/YFYU8/KaJLO02e
 mH78FFgRykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABNpLmJk2Hzp6N3S5dN/WTBK
 Hc/3nrw0rtxKvbj2lN7KnWZb1wq6/WL4nzf93mehWdfPdi/viLv67vPrbo0k76WJvJfy3R32VH6
 awAIA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dHEQX7RCwiJGkPrO79YzfWpn4Uya3J6q
X-Proofpoint-ORIG-GUID: dHEQX7RCwiJGkPrO79YzfWpn4Uya3J6q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX/JkWA0XBAdF6
 FfKhvYQVApuiUuvKk0NHiF5jm8iiZmUb8MZOFxs6V3QI8Oyx2z2hgrZjmpJ9Ry5vBQCwy7Rm4HV
 IKUrNARFwiYHmRIfYkjPL9qEZ7Xps82+XyGdLPHQlXA2nvJUMw4GNgEfnM+3xjDlWsUoUJS1/HN
 YV9vdWyr+nz04SLD3gCclbG4HjYgc3tjmMGnfRRQTUNqIbExKdf7Ir/HfP6sG1VnHLoFuhcN+hJ
 931oI33d6ivLeqDM0/BZAxuT5eVPuNv/M8edWs0xNuwQZpC6Ri1flbTmSsam2NOfnUI2PIC95xD
 FgdWoB6Z2DGm8qWY/UFV2VpMl3/5iXfrzNgHZeBNdNOCFNCzMrJ6TGURnlOw8njSuoc65P7CWZq
 VaKlXt41klMk5owDYDLm0JnXEGRI8Y7Z3uxOlCk1pURd9SQYslXuVP1ZBJ+VINLFsEPiIWE7vzc
 APAgWm/990jES3XfFSg==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c2b14c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=owZ0ccYYszmCy-IndPwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240119
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=schlameuss@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Need KVM_S390_VM_CPU_FEAT_ASTFLEIE2 specifically.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

---

To merge this this needs to be changed to a proper update of the
linux-headers once the kernel change is upstream.

For now only include the needed change here.
---
 linux-headers/asm-s390/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index ab5a6bce590c722452dac5aeb476bd1969d2235b..45a6d0a7406a3f1b71026c49e00ac25a6fc620ef 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -444,6 +444,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_PFMFI	11
 #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
 #define KVM_S390_VM_CPU_FEAT_KSS	13
+#define KVM_S390_VM_CPU_FEAT_ASTFLEIE2	14
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };

-- 
2.53.0


