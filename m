Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA321C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgwT-0003Db-6Q; Fri, 03 Jul 2026 12:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgwR-00032l-0f
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:40:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgwF-0000en-Cl
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:40:38 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIoun348246
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eygAFTCQW0B87uY1lVPXWDPzg3gZxNFs2eCC7PkFP/o=; b=JxC7fkAgRgeItd1C
 FPqRLJWdzTFTqaludgl7+U7D03Zb6tg7r3jbHk73WZYBNzulHijjliofwf5V+Ei/
 7oo7MRCBc7wfhkjzoAg+1LTsPGpGtk6nuok7HxK088djOkM+baMErG1daXYdG2fR
 NMBrwNJN2AWOwH3nkmns/GjjxYKwuBbUD9CbmwoNxq8a9ydF6x3Ie8QdWdpRCERe
 N5i3+mJJN6fvDY/iVaniBvG1p59ZGGz2gVqAfXMYrQCi2dPOsgJoFrSBkm5EME2V
 DWki9QMg+Tv5Wt35eVTR0pis2qPg46HBIDS3mcP4Dnji00MQ1+6t9dagLCR3BrjF
 IFL7/w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n38dj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:40:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915d3261c5cso70220585a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096815; x=1783701615; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eygAFTCQW0B87uY1lVPXWDPzg3gZxNFs2eCC7PkFP/o=;
 b=cId3NbDq3uZVr4YD/zSau+MIwa6R/I+QAyc8ME7Znl2hM/QjgRBIEBpirsPd05m8UW
 e5Nj/BRafqnZHDKiMjnsULVr9Kbn8QW0WoTmO79WlJCkMLohhyUI0CSeo+MSyNXJz4lx
 Ea4WOIJkZfH2bxyWK0qbZnUsRjjBGKVMot+U02WIhXw3ngwlXnyE8SiAitUk/ujXMe0S
 xRUpEEtWCj0SVtSEXbW3I7xjTwkN2TZOnIADjPg4mXbywslxWKeW2aYuJGhbjAm4IXu9
 AA/M+Hg0uLAImeOEhHJ3IKtwT07PAAJK834PHxcW/wUDfsikVKX5udgmLdLcUwDsIpDk
 qDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096815; x=1783701615;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eygAFTCQW0B87uY1lVPXWDPzg3gZxNFs2eCC7PkFP/o=;
 b=Qm/uUG9MyyZhfhGrP3qBQ7/wsHzF7v6VU6ABUesn9mkWKbscY4qPLZemFZBEQa1Sn/
 qsEWrtkNekZFcybHdeS06BHA2znH8wqmFqqw3uEMzqraa/4bM4a+e2QLaeph2ukcj6Oq
 uDr49JSbZx4xjVlaUSOdR8ZUHIjnHnHnwaqyTGzbvsjh3vNBOIDzX0dsSLQPFKGKf4nF
 qjPF1smpLTIcu3jHQNGN/gsrfmlOFXafzRSv/QJDoadN7NHJJdvnjNXP/QoGc2H713iY
 l6UATdRBm1nUO07Bfzk0EPereC3nkdm1zhH3GtxH3MGSHpHrV5M8RT2fIsaKlwmOjley
 O3vA==
X-Gm-Message-State: AOJu0YwlFhZJScMjMz/YHgiRneehCJSIrNdhOOb80IUtI1eTY076ts+5
 0IObIBiEDz8nRYCYvRW2jx4g/SQdUxyqZk9uPyXH0LhPX7LhymIFgkyIcwdIdDAb8i+58X9RDzA
 Ddxm3f4cCqCZYc/Ah0aReD7QnT9rNm7c5hDyFM+6avoiW4Rr/ZFm6Vwe4CqIMQEGW+g==
X-Gm-Gg: AfdE7cmNsF3AVnLsK83+7J5m92HrQt0YAhCzF05ENKVwdAFlG0ZT29cl03hV9ynKU7a
 ynYEXYrbS5o/5o7WUr588RVlgcCQons+IO6RKU+08jWj8yGSQ1NI7mDMtDof3WuAfF2TiV/KfLJ
 r9pBgujcWavBYg7hGuQhAR+GDnw0By9lwmVagksnOfZD7I63aMY1jF5wlVm0K+R7kFLoCYkYi5Z
 gWgs993D1T8RXPoItax7peZw5R4jjVxxyqeWzYomQs2Omm8yYdX5EmMqvOvauyCAVbw4JqN9bwB
 pzL8jNUkPJKuBm6E4euzfwz3293KZ+2Im4OHIOM8QyXXBIMH/HdRATtZKXAu5GaW4cM6zuOKpx7
 PFT+SVMEUQEumQjq4lWBZO48nKmyOurBBPE7Y2wLdgx1fkAHxPXumEJGY1hH3r07OcTSa
X-Received: by 2002:a05:620a:1a18:b0:915:efa6:d70b with SMTP id
 af79cd13be357-92e9a4a12dbmr26042185a.43.1783096815481; 
 Fri, 03 Jul 2026 09:40:15 -0700 (PDT)
X-Received: by 2002:a05:620a:1a18:b0:915:efa6:d70b with SMTP id
 af79cd13be357-92e9a4a12dbmr26035985a.43.1783096814817; 
 Fri, 03 Jul 2026 09:40:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e6ccsm598453f8f.5.2026.07.03.09.40.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:40:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 18/33] cpu: Move cpu_breakpoint_test out of line
Date: Fri,  3 Jul 2026 18:37:41 +0200
Message-ID: <20260703163757.55500-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXzMRdFMTqTZVC
 pUldFrqRspnLHqPhoggj3GfXUIgbfPHyZs+NLQYIW2cfqBTfoRqUkNNb12ZgkEfstvC0qEGIoTu
 elHgF/hlUvB9mTN6iB3WkT0Cxxgs+Pg=
X-Proofpoint-ORIG-GUID: uAZKdOeEwAoQIgi17kugA0B8kVUDKUut
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a47e5f0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=f0gnTpezwqI1Ju9rGxMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: uAZKdOeEwAoQIgi17kugA0B8kVUDKUut
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX4eoY/tCuDK4Y
 yGMZ0N2S7tgQA7cUetwPJL19hITKFedCi5CVy2edDg3ZG5QDM6kamCXGLxgaMdKHX/Yy7Ok+URp
 1rygSWYL7rZmgCxczffa4o/q5WvadYd32UeTWquCfF4w/0wsBETqC88zAu6ifzF15wHYphTxi1W
 S4E5qRpPsLn8jTKJj/30A4hUxsJrjMb0e4xzQulXHV8Z2wn1vk9d8wJDDu2UZbupgkx1Xf6uTID
 Xixrhoa3/obD4qm1N6KFNDi2noI8RvZTWjuvJk2T/DIN/UB3g8Hhcy9R19ptQqXjN3nIr2VZBSn
 0hA8kcmDxoyX9Ub+z1IELff5a9dgj0Q72VQEDWdsSg06rxDvd1pDAyCSkhP6jjW2Th12Cbovzkb
 hH8Jx/wjJvyUeSJMNCugHlE/QMX9PLukmZCMlkWmpBQQeGjrg3HK2o/nhSMJxiFSyhEpuZQzdUl
 o4P0wRYX6sF5NWwcdMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
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

From: Richard Henderson <richard.henderson@linaro.org>

Move the function to cpu-common.c, with the other
breakpoint functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 16 +---------------
 cpu-common.c          | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 60a23d6f38b..31753f331fb 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1157,21 +1157,7 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
 int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags);
 void cpu_breakpoint_remove_by_ref(CPUState *cpu, CPUBreakpoint *breakpoint);
 void cpu_breakpoint_remove_all(CPUState *cpu, int mask);
-
-/* Return true if PC matches an installed breakpoint.  */
-static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
-{
-    CPUBreakpoint *bp;
-
-    if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
-        QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-            if (bp->pc == pc && (bp->flags & mask)) {
-                return true;
-            }
-        }
-    }
-    return false;
-}
+bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask);
 
 /**
  * cpu_get_address_space:
diff --git a/cpu-common.c b/cpu-common.c
index 988d057d844..adb76b3a786 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -388,6 +388,21 @@ void process_queued_cpu_work(CPUState *cpu)
     qemu_cond_broadcast(&qemu_work_cond);
 }
 
+/* Return true if PC matches an installed breakpoint.  */
+bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
+{
+    CPUBreakpoint *bp;
+
+    if (unlikely(!QTAILQ_EMPTY(&cpu->breakpoints))) {
+        QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
+            if (bp->pc == pc && (bp->flags & mask)) {
+                return true;
+            }
+        }
+    }
+    return false;
+}
+
 /* Add a breakpoint.  */
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
                           CPUBreakpoint **breakpoint)
-- 
2.53.0


