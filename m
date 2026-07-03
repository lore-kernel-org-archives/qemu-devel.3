Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD02C44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgxo-0005vs-5w; Fri, 03 Jul 2026 12:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgxm-0005uy-Gx
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:42:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgxl-0001rU-2Z
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:42:02 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GInAU498238
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 euJn44qDWZ2TcdTti8/aLCTKwbg3pgDFPtWDEjD8jME=; b=B/xCTxpwXLVicH5P
 IrEa1/FkWlfDOjzs4pqXYmkC2gLCNxEjEmII/hhNPezS9sYmeaAYarjCEVA7Mjj2
 cM91wtz6dRROlZrbVJoC+bSMZq0Ma4PspTTjEN9S8ntyRAB96NmofMQIuQU6ocf5
 ipSg8QlTk8pZB/ga+NdK4e/EcO18T/D61LYfQGkQiitQmCAhMlULCA7wyuleTH0J
 fBnbijQof3Ajhw1FYSgK1P7Z2ECa5z79oOIY1Smix7LrgjRuZ6OcdDp7eUmmaJYt
 fHiJ3f0o8WAQku4b/VOem5S2cFazuYcaES8poLbffZzoHuBl3wUDRWBcbzJWFbsW
 sgQ8+w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qcjx45-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:41:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e7ee64b25so124589885a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096904; x=1783701704; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=euJn44qDWZ2TcdTti8/aLCTKwbg3pgDFPtWDEjD8jME=;
 b=NkYHBvlqT5WK44uZ6vU0133ghK43OwZlav62XZ7LEt2m/hc4XUFUrYbalyjKs1MN+n
 H6MAeQ1k+6VvpthvkZWQIrXBXjU33K+GqPsmFz/Ad+rfzZ0vO7ivC/MpYFqW9ypimDwN
 OoKYDtMhY+trb0HiRaMizkbqS1cjqaWmekxZvNYtOyja85JOmyzZnzWIbG1MizMNJjXg
 bL3kkGyEp1SgMVwx2cP/ci0w6INrIi9gHMPjqVIJ5f81CwBJQI3jjtBbHCMJVR033afj
 Cr8vh0d1nU38oIs97TlhiOjMVG0w557E3HPfo3/Bpp9il6j99JQDxd/R7z8cMqmGJfSC
 BTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096904; x=1783701704;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=euJn44qDWZ2TcdTti8/aLCTKwbg3pgDFPtWDEjD8jME=;
 b=OIRyrnhQ/LB4vBCMVtEyYJH0ApipbeF2gAnNwGstMF5yCwllvNKV6pDhao9lkkTf53
 4RZ8gMCLyQAU4F0b4cDC7yJHNkWDlmRrqsIfLo4kWiRMRUEsfdFA9J2xbI3eP7GxKTVY
 Wt4/SSHXAXpzj/77TwRFGpRh9SFtNuR5bHmMq5Lp/taHWyYfkidcVcXT1BSmWgt6TXXy
 EoM1m6ab34oKdGCeOD87zFNRS2edxmP85T1w/PpZLiVyyYhqAuMTWi1VxRwAHtFZ+DKK
 8VeuwhEtvaV9c5n5wqx3MjONsogDPYWdKIcdLkErBY1sxHSKRb4hf9tFHUebBG4/gKZN
 8J0A==
X-Gm-Message-State: AOJu0Yws+r3uMk4XjmHggkGbAcFT1El2VqDjvgwkWUJo+lX8yVBTLBSj
 Nfxzft6oNQEyPQrG3EtiM1CCqIejOQmuFE75b07sfi6wu6j0si+ke84aJZw1MPyoi21hFswRezh
 xMPu1vc/Ff3W0doEhKr2matcbrppiZilm7JMeGqS5xvBRvFIUsE3sCHimXBlfx2+m2g==
X-Gm-Gg: AfdE7cmvqjihsOiLyqAO3ho6M/w+yB4mRzNhTWXwcQomBb7WHNDsnmRRMoSLGMfPdHq
 ON/QiO54S9A9JXGZIZecpggY50iFmlWpse1G4jS+zk366jaxLrLG8YnxT1xcyYDxRY1PhaN/+ee
 Nt9acnB24TetkjqXa7g2ojfGHIYz0RDASUbxR/7teSbcntYo/Hlk1j/wkwYlp1LeBh1Fgaw9yVF
 AnNvv9oYYTUWgbXHBCSg3zQGly41kJhxLK90Poe8Dwu84D3RSbgcoAA8O6o5DMwgts/9Mkqn7uf
 9AM69yLPspD34Zh+fGdrgrgKhG2OAQ+rGTNQ+eXLwsKZDDNdfFlUYLDi/POeCoVZdbQswoUGcdv
 7lY8HyemmjXPvwFBu+uwBskRnGZLZEt5yCQ4+hz7zIN7m7hiOy6jfkxi2mpbApH6ZxFB/
X-Received: by 2002:a05:620a:261f:b0:92e:6d2a:7772 with SMTP id
 af79cd13be357-92e9a41d90fmr26793485a.41.1783096904160; 
 Fri, 03 Jul 2026 09:41:44 -0700 (PDT)
X-Received: by 2002:a05:620a:261f:b0:92e:6d2a:7772 with SMTP id
 af79cd13be357-92e9a41d90fmr26789685a.41.1783096903779; 
 Fri, 03 Jul 2026 09:41:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce1a844sm59579755e9.15.2026.07.03.09.41.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:41:43 -0700 (PDT)
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
Subject: [PATCH v2 30/33] cpu: Better name cpu_single_step() trace event
Date: Fri,  3 Jul 2026 18:37:53 +0200
Message-ID: <20260703163757.55500-31-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QzL3h9bpX69y89RxDJZBawwPxliAt9kj
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47e648 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=fWCg92Okmkq_k9tJrKMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: QzL3h9bpX69y89RxDJZBawwPxliAt9kj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX39xWYz1ry4gL
 9LtnwpsyfgMdjIwSLW1BmYfGSDpr8/NAeQG41IEQ9ZruWIAALM7jXDGGFD79eQtPIJeJUFnpgU3
 4egQvWaQwcToYXifEAH0PtWkq7BW7s6qDjuvkF/far3LB2KZXMtPaqr0s59yKixPjStZbCcqQSU
 MVgjhk8UWrzzuVPFN3oA9iRsjnmpfXSOmIkL5oq3BqlNWkrRQRNGvlPYBXjsWrvP6byv25DSvfl
 8iJBQfbrjUDPka/F4UMN2gMjakk8Ne1/Yt2rHMI7d/fuS+twz8vbnrnH4vHWfKqC0XcZ5DBchX9
 fof9ROy8GRm8oYNu0defJKYbATqFfLAV6dOaLWJgUDrya2gUcuWuKq1N5NWuk6bmgc4zcslFbO2
 WmIStRsthXxB3iJZSAVDW0lSbbwiuyJNJa9asgEeBG/cNivMDSF/2uzWvXGUrwIOhrmqYdu/hY/
 CAvzBscjMVtiFr/Qc8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX57qBNQR+n4eS
 Hl7hTx4vS/Aa0TiBiF0iguZaIxMOrdwDpuhiDuuUeJoZLqtnRrmg/Hg4IQS+sz0cn93uh8G1amf
 n3xd+/HcQbAM1n7aiN3JP+NSO4nR3y4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
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

cpu_single_step() is not related to breakpoints. Rename the
trace event.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 cpu-target.c | 4 ++--
 trace-events | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index f030e2c642e..019906b32eb 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -31,6 +31,8 @@
 void cpu_single_step(CPUState *cpu, int enabled)
 {
     if (cpu->singlestep_enabled != enabled) {
+        trace_cpu_change_singlestep_flags(cpu->cpu_index,
+                                          cpu->singlestep_enabled, enabled);
         cpu->singlestep_enabled = enabled;
 
 #if !defined(CONFIG_USER_ONLY)
@@ -39,8 +41,6 @@ void cpu_single_step(CPUState *cpu, int enabled)
             ops->update_guest_debug(cpu);
         }
 #endif
-
-        trace_breakpoint_singlestep(cpu->cpu_index, enabled);
     }
 }
 
diff --git a/trace-events b/trace-events
index faeba6242fa..ea1d2b11a22 100644
--- a/trace-events
+++ b/trace-events
@@ -28,7 +28,7 @@
 # cpu.c
 breakpoint_insert(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64 " flags=0x%x"
 breakpoint_remove(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64 " flags=0x%x"
-breakpoint_singlestep(int cpu_index, int enabled) "cpu=%d enable=%d"
+cpu_change_singlestep_flags(int cpu_index, int old_flags, int new_flags) "cpu=%d flags=0x%x -> 0x%x"
 cpu_exec_start(int cpu_index) "cpu=%d"
 cpu_exec_end(int cpu_index) "cpu=%d"
 
-- 
2.53.0


