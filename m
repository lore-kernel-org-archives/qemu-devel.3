Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3162CC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuZzT-000269-Fy; Thu, 13 Aug 2026 14:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuZzL-00024e-DR
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:17:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuZzI-00025S-SB
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:17:10 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DH8ExG3052426
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ii+NakEKXLwaKt59HrJUbtrSCVrxMYJtk4E5DyQdSG8=; b=cKXJ/dGITmTYU76g
 QK6H2QsSx0tIKzWS+1UbfDX6ErVmzta/AHyXVk2GTefp6qPAKcukvlXoAaFIGXfz
 56W6fpGRKhgWlpm9QXQD//3F6BagJWRX/5fqg30tQNR874qolvR6X4eV3ow0+RZw
 TG6dj0PEnIZZv3JYew8/2laMYaNPI9bU7Xbsag2+XwzEC088taqtc41ouFFZ0PPU
 u8N7Ut1KzEnlMgasU/Q+dptng8KYLSFGkTxbdyq9+jWt0ib2oI/lsrmGiwo1VHK6
 ryRSHnPeNx9x3jPbB+oHg2amgacWrfD0jvfhfvTO8YTnQoAao3J4YrJMD9eUDeu0
 6BJpLw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1j2f09t3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:17:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0e702df8so2684751cf.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786645026; x=1787249826; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ii+NakEKXLwaKt59HrJUbtrSCVrxMYJtk4E5DyQdSG8=;
 b=Xj0yDf8GEFtQda6+ZVR9kuj5Z3wQP0pEF8hzzwVA5tM8odpCgvLLrhQocmOO5r6ICs
 JafYkqzPu8Pa7j65uFNsFwllItTiJNu8BnTtomt40lfXX3YNDXprc22nBqnOqXanjvGn
 csWowzUQCfwsAB2IO6OwZ6rzTNF4I5XI74IP8IPXlG8ju7y/0cS/lUZeTlxk7guiDS14
 cj9CTbRdPoyqXkcaCQWTSl2hCdWjsBcORjILRt5UFcJn7zAxtN01M9c2KkntriG2F0m1
 f95R45AW9lP91hDfWmvxw6/Ns5JKzUsHZxbQdrtykyXjlBeiDLROW/TjuxzqJBGCNlOW
 fOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786645026; x=1787249826;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ii+NakEKXLwaKt59HrJUbtrSCVrxMYJtk4E5DyQdSG8=;
 b=GLKxUhPSQZ4/UzaUehB6pbHCc9RKNj6AWukXxAkWFH+meLhx2JfokWdil1ZP+nJQyr
 gg5Jecci6xVMgoD5cvmlBDjTydxb9LJXi/m3+OkV+mYM6JFmmu79pSw9HgqGlJik4d2f
 xZ/l69VnWkmerSxP2dBZfJvFjkQNd9wkZc7stbEg9XCSPg8UeLvItv7cMZEvHh8fqy6F
 ZJCErEyS9VPg01mwJVztfcuGNjN7WQFKw9ka3xCU0bTvjOY4tEssZWIdwxsQhhwryKoH
 WfgZMIVRA1LVpdPQcoNJG9TZLpgfyIHPMGu4wM46wNlOXvI9cgI4DjDmwO8UHBojpNur
 u/sw==
X-Gm-Message-State: AOJu0YwTpOldgfu1s86fR3rRUwMvgjHo7k5XSE1Wy7APW/2PlGDqH5Dp
 SNZePsIHgtlasEbf+yHZUtvL7RLGHhcIDGn1f2pfmXF1zsHbTuB7D/q34iXjKFzDC7x6HhA7JDH
 GrZEhVaBxAyWPxzLC2ARHQaOwLR1ybjjhON8ZEOYBng8Tli0YlEHWwfHlbX4vknWjyg==
X-Gm-Gg: AR+sD13jNEhnyv/ZdGyMid7EezMwFp4ZtWG1wdmFNctXRPDvvrikBPm22fAahbDyAUX
 a75dTsUm9YiFg5OyDD5hMGe/xHCpmIbh2Tyvt+magkWM2sN8n5Jc5U8k7kDfukiP6oUw3RIJ1LV
 EzeeGugzPcxXujuJkIgJVKDK+tqIvvYGd0SIabSewqM4wohgmcqMb6WbufUO2klS8HJgRInEWzA
 +WBQxLQ5xbf7WfRD6/C3bI+OPL1FMe8870sTAcBXUmrHsNyVW674vRLFwXLx933graf+rQAwkyQ
 Bm9ppaQ1iUoTXjxSqDEa0ZUQt+3YFv2lCw6tRduQRa6QJuibQ5DFdHTvJjidaf7igKeeugVLN5u
 vQVPTDSWElso7URpX53vLqKAKs1f57BmGD0s+/g3+lw==
X-Received: by 2002:ac8:574a:0:b0:516:d699:a99b with SMTP id
 d75a77b69052e-52d73da2a13mr76547961cf.40.1786645026286; 
 Thu, 13 Aug 2026 11:17:06 -0700 (PDT)
X-Received: by 2002:ac8:574a:0:b0:516:d699:a99b with SMTP id
 d75a77b69052e-52d73da2a13mr76547071cf.40.1786645025661; 
 Thu, 13 Aug 2026 11:17:05 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2c6115sm1270516f8f.32.2026.08.13.11.17.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 13 Aug 2026 11:17:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 03/16] cpus: Rename cpu_stop_current() -> qemu_cpu_stop_self()
Date: Thu, 13 Aug 2026 20:16:26 +0200
Message-ID: <20260813181640.6537-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813181640.6537-1-philmd@oss.qualcomm.com>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FeMHAp+6 c=1 sm=1 tr=0 ts=6a7e0a23 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=ao8Q1kDP7eBHT8PKhbAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: PhH_8HN8K9xGnGVsNVeoKe5eV_27MJ9e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX3KjOagrCH/c/
 sGwCiBIjReqvxVzy355klorWkeCIM4PkQQZWbTszLm9xfXCqdKz7sw81Few6ImxOKbKg6mLJNX7
 PoqOa3RkT2RNCF29wJ8QY1DmHOGuhHLnvreviFhy5MVNLk1wdjVfdXZSs0SYk9Ja50Nia//WxKx
 rYdHnSf2IMywZDkZoxf6sMHHCTNUjMKT8VQx1hhwrTZeDZn19LPLPjs+WLOth/y4fb2OKxXHbb4
 Ep6kgxOiEikKQJUnlvQFqZlUG1z9T/RSMcIcbLJ3E2hNN7JZGvE2+7C5+C96c56ITtbCA3vE2dS
 Fylf4SpXDcO/37OF0me/fTdXqNFZgP1AvB1ZQY1kQdugwsZ/yqRmi/QPxzvJWyaoSwMOFIUYkZB
 3PmxeAWJJcukLGyjbY4r0vHMQ13q4eBPkG2pwZ+T+6CQA3i2ezhOqlpuwIBb+WbmN91l1PkKCEF
 tQTsS1W3Eu8OYcsnE8Q==
X-Proofpoint-ORIG-GUID: PhH_8HN8K9xGnGVsNVeoKe5eV_27MJ9e
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX3mfuHem30TRO
 Xj7rPXhyBhX8piXF3+f65c3JhOBTF05xuEDupnxtC/v9jHZ/S7njb0WQ8GC2pCMMlkAHLymmLUU
 dmszj/UXontq8AsMFKWvZOwvaDDQ2j4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132
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

There is a single method with ending with _current() suffix.
Align with qemu_cpu_kick_self() and pthread conventions by
renaming cpu_stop_current() -> qemu_cpu_stop_self() for
consistency.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/system/cpus.h | 8 +++++++-
 hw/ppc/spapr_rtas.c   | 2 +-
 system/cpus.c         | 2 +-
 system/runstate.c     | 6 +++---
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/system/cpus.h b/include/system/cpus.h
index ade13e068eb..2365c7c4597 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -28,7 +28,13 @@ bool qemu_in_vcpu_thread(void);
 void qemu_init_cpu_loop(void);
 void resume_all_vcpus(void);
 void pause_all_vcpus(void);
-void cpu_stop_current(void);
+
+/**
+ * qemu_cpu_stop_self - Stop execution of the current vCPU
+ *
+ * Note: No effect if not executing within a vCPU thread.
+ */
+void qemu_cpu_stop_self(void);
 
 /**
  * qemu_cpu_kick_self - Force vCPU to re-enter to its inner main loop
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 328fc27c400..80cd4246af8 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -93,7 +93,7 @@ static void rtas_power_off(PowerPCCPU *cpu, SpaprMachineState *spapr,
         return;
     }
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-    cpu_stop_current();
+    qemu_cpu_stop_self();
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
 
diff --git a/system/cpus.c b/system/cpus.c
index f37e215c586..1a6fd286a81 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -674,7 +674,7 @@ void qemu_init_vcpu(CPUState *cpu)
     }
 }
 
-void cpu_stop_current(void)
+void qemu_cpu_stop_self(void)
 {
     if (current_cpu) {
         current_cpu->stop = true;
diff --git a/system/runstate.c b/system/runstate.c
index d3e64d2b625..1302fea9ccd 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -472,7 +472,7 @@ int vm_stop(RunState state)
          * FIXME: should not return to device code in case
          * vm_stop() has been requested.
          */
-        cpu_stop_current();
+        qemu_cpu_stop_self();
         return 0;
     }
 
@@ -900,7 +900,7 @@ void qemu_system_reset_request(ShutdownCause reason)
     } else {
         reset_requested = reason;
     }
-    cpu_stop_current();
+    qemu_cpu_stop_self();
     qemu_notify_event();
 }
 
@@ -918,7 +918,7 @@ void qemu_system_suspend_request(void)
         return;
     }
     suspend_requested = 1;
-    cpu_stop_current();
+    qemu_cpu_stop_self();
     qemu_notify_event();
 }
 
-- 
2.53.0


