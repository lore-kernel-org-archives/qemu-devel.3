Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BCAC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LB3-0007Xe-SC; Tue, 01 Sep 2026 05:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LB2-0007X3-NF
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:53:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1LB1-0007Xt-0w
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:53:12 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68179EOj1211681
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 09:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5vYRARi2QtmKNQI0is/5y9raLqQC71JC+pNDAX0+lq4=; b=NXjE7oW4BEH9NEZg
 UmdKkUn5L6S6tX69qWPmU9k3dYzSkGadtlO62lPpRRkqnuOlzay+QxUkK3T4yoZd
 4NwCpfZyKki6VUvAXZNs9ESXZMfWm1v0Ac415apjtVts7UJ72x3pv0/p9PK+UqW0
 YLVzjaVzFMaX02zGiZDcIBeKour9Qy3dchbxgecbA9kmkdGqiEpV7VgfS/Vx1pOv
 raqVuAxyJgoHx5+hCxNun4PT1DEXC12gZCoj/sB+jN+d6U1H3alQvoe9HgqJcGQq
 G15/MKjCDA2dG8zezz69UmJL9EQmTD51dvTdpC3V+v2wwnshsTuyFB8aVs2rB35O
 rFQvNw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdnk8svvq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 09:53:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e4f946461so777954885a.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788256388; x=1788861188; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5vYRARi2QtmKNQI0is/5y9raLqQC71JC+pNDAX0+lq4=;
 b=HNkbpm0rEJiVVAL17Y6/sQ13LriIYkFp2nszOtRGyE0RLRu/jMqvqQl4IkI1032dUM
 Ydfx6uLGCI9+V4xUe1svKUgJkohf7YgC8e9SCSqp96rNBSbvcDKJZbQJZ6KWaeeXjQ1W
 ZYc3vwiIH2laUgsMjiTzweu1e+k2ApSAXRlgpB95twkFBsSWnVeC8v/lYPp8Gza6fLGm
 POP61X1po3Lfom16Nsn3kLplT+25no11RJpLzmcOtKt5BbDsX+2sk0zgOqtGk+4T1901
 KNNfUdD38eqLultXm6D1yyz4DeMvBkoPmGi9XyHUj4/ZOp2gcs5KxuasfhQikNlkYcFM
 sVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788256388; x=1788861188;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5vYRARi2QtmKNQI0is/5y9raLqQC71JC+pNDAX0+lq4=;
 b=MR5MaAl44WMhhbgzpv/EBRU2U50EVfFzipLIEoA8F+BKABuPH1YhzxNUs7yWmFW84c
 R7PrF8cHuK6yYbA9V4CrIh3mvRPtcmV+VPyTNLeER/gdjvrbn6Xc69Kxw53avoPHbs/d
 0WUGcU7GKhcciwGulap/UC/WQt/IQcm19DDZLjCUBlnkJTVteCYbmHZs2y2fFd/PqZZ7
 JQbtt1FuftOoEEdqi4Hmvq84HaTdR+wUbKEKwzmWwZqRsDymbjjb6vkkPboHmEm4RDCL
 fS6xshB4KZGG+R9P+g3SEuDWrs3spV7akwCZ8lKM6n9IviHBjLHxcgBmxaOk0PNmpe+c
 lezg==
X-Gm-Message-State: AFuF++ld6hE0lzw5eZ530NR2LXXYvGNFXOzVqYObIA6aGWUNfo2LRmES
 LeEUEMbjH6CEdbRuYY0WFQ0KAQtJHUEoyddYZuq6wLJyuu2bDRaTVcADAJ7ma1uBZwmJpr9aQs7
 Njv09McDn/3HIsSwmAHpXZyPQajp7D1iXh7seL5vicF4D23KAxaeS+kL9902y9FtZzQ==
X-Gm-Gg: AR+sD11R4RCVvTPEBLHIWUW616IWOo8MhUWau5ewcZeH15VjyjBf9rbKyiY1jZ9P1vb
 7UbQz99qAVkwyBj1PGUkBi0fBH8oVtahWRnH9dxvMu76A/10A97O84QJhM6y7yzVu8OZB0eUk0d
 D/m2yETewVcQtT8361JDF9e2J9dFk3jCCMzVS+UUHxA4ewDNP4f2WNowS2qI7eQbkCHjXDMchRX
 71He7XayJ/ZcFPvS4sP8JdcV+jgg5JplM5YFNKT5gRR3Jxr6BdJhBHBt5DhDQ0UVKCQL0ui4hqw
 l3c10FWghDNQuF1elNqfRZCaGwSB5RIk8ukjuzZESxydjEO3yHCVkEhyzd3fQ+4yE0xp1oh7vE4
 oGn3ZUxoKEdVrFRF+Sl3BGx/8TXRrPwle0dCq6Lwd
X-Received: by 2002:a05:620a:27c7:b0:937:6d2e:d023 with SMTP id
 af79cd13be357-93948156bf7mr1057571685a.30.1788256388376; 
 Tue, 01 Sep 2026 02:53:08 -0700 (PDT)
X-Received: by 2002:a05:620a:27c7:b0:937:6d2e:d023 with SMTP id
 af79cd13be357-93948156bf7mr1057566685a.30.1788256387771; 
 Tue, 01 Sep 2026 02:53:07 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d3b4f1sm3403934f8f.9.2026.09.01.02.53.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Sep 2026 02:53:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v5 05/21] system/cpus: Constify various CPUState arguments
Date: Tue,  1 Sep 2026 11:52:11 +0200
Message-ID: <20260901095229.72018-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901095229.72018-1-philmd@oss.qualcomm.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=f6p4wuyM c=1 sm=1 tr=0 ts=6a96a085 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xPOHbBPGvMiCLs31fh8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX/evWZwAnhzAq
 LHKLzhhMzPeAabWXc/QdX95Vq3RI21bRwvkwcwZnZjEXJsnnmFkh2V3dCn2icXyBkf5JF0KAyVd
 COBCLMmYK34CFhOpYP7k012GPszGY1PyuK7rTiBPtNE7nfx3IdbahGrXgubED/19QVWGKOSfKdW
 HuhoYoz1dzehLXsR9I0vFAVFpaXoI6rx3W2HSJ70dlyBmOuwRn6W7k+p6CpWza0+kequqorho8L
 L+SRetZVI7eFWTWwp8mp0RrnXcNHvfi3b5kW8bAdGCfIE0XP3Ddju4eHgV0GhOGQC6YjN3ac4VB
 P0MvV3GE3Mxojbfr6DdE5KjDUvT1QaOCRcjU0uQBfH76FL9KSEeXuHDWyhw3LHQ0OBsVEBpVPpN
 fDymz4+rqAMO8BS0FL6sTmxho0dT36n1+OgSSHDHqo5hL+nnevivioprsExe8oBtqE1Z5aD4enE
 4S0eIU84Mocbrjowx9A==
X-Proofpoint-ORIG-GUID: it-m8NpGQIjPdg7G_TrQx8bYFh7fCyzy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA4NyBTYWx0ZWRfX9EijgLmZfdkP
 oV6KHZgV/mC75qiqOnFdhmNObyZVyeW4RqMB94354TfX3eEgTCiTgqHMJ0MOczEGdeyc7vINPV0
 Yz07N2tma7xex/rgYcD+a/Z54miNU74=
X-Proofpoint-GUID: it-m8NpGQIjPdg7G_TrQx8bYFh7fCyzy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Mark the CPUState structure const when it is only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 4 ++--
 include/system/cpus.h | 4 ++--
 system/cpus.c         | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 18970ea39f5..328e30045ce 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -900,7 +900,7 @@ void qemu_cpu_kick(CPUState *cpu);
  * Returns: %true if run state is not running or if artificially stopped;
  * %false otherwise.
  */
-bool cpu_is_stopped(CPUState *cpu);
+bool cpu_is_stopped(const CPUState *cpu);
 
 /**
  * do_run_on_cpu:
@@ -1007,7 +1007,7 @@ void cpu_interrupt(CPUState *cpu, int mask);
  *
  * Checks if any of interrupts in @mask are pending on @cpu.
  */
-static inline bool cpu_test_interrupt(CPUState *cpu, int mask)
+static inline bool cpu_test_interrupt(const CPUState *cpu, int mask)
 {
     return qatomic_load_acquire(&cpu->interrupt_request) & mask;
 }
diff --git a/include/system/cpus.h b/include/system/cpus.h
index 508444ccf1c..bf36b823769 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -13,10 +13,10 @@ const AccelOpsClass *cpus_get_accel(void);
 #define VCPU_THREAD_NAME_SIZE 16
 
 void cpus_kick_thread(CPUState *cpu);
-bool cpu_work_list_empty(CPUState *cpu);
+bool cpu_work_list_empty(const CPUState *cpu);
 bool cpu_thread_is_idle(CPUState *cpu);
 bool all_cpu_threads_idle(void);
-bool cpu_can_run(CPUState *cpu);
+bool cpu_can_run(const CPUState *cpu);
 void qemu_process_cpu_events_common(CPUState *cpu);
 void cpu_thread_signal_created(CPUState *cpu);
 void cpu_thread_signal_destroyed(CPUState *cpu);
diff --git a/system/cpus.c b/system/cpus.c
index f37e215c586..e11a5aab6a6 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -69,12 +69,12 @@ static QemuMutex bql;
  */
 static const AccelOpsClass *cpus_accel;
 
-bool cpu_is_stopped(CPUState *cpu)
+bool cpu_is_stopped(const CPUState *cpu)
 {
     return cpu->stopped || !runstate_is_running();
 }
 
-bool cpu_work_list_empty(CPUState *cpu)
+bool cpu_work_list_empty(const CPUState *cpu)
 {
     return QSIMPLEQ_EMPTY_ATOMIC(&cpu->work_list);
 }
@@ -271,7 +271,7 @@ void cpu_interrupt(CPUState *cpu, int mask)
     cpus_accel->handle_interrupt(cpu, mask);
 }
 
-bool cpu_can_run(CPUState *cpu)
+bool cpu_can_run(const CPUState *cpu)
 {
     if (cpu->stop) {
         return false;
-- 
2.53.0


