Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33CBC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7pP-0006xE-M7; Wed, 12 Aug 2026 08:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7pH-0006wc-Il
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:12:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7pE-0007TZ-R7
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:12:55 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB480v3319901
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7Q6fhegGiu/A6dM+c37Ci4gQqTgdFecpqlNFbfvbjec=; b=U+shqUxeYbrd++vp
 BJFNYouUU51IdnjnfCSeCO9aXTVpgb8T15frsuAc+rZDxoVMuqEIQsx5jIUC+3hS
 ilVA0BICpxag0UGztGS+QNiNFhTKVBHmLvTEa1xmZ12L7UaiO70E/WYakuumyI/4
 IuejEtClOi5SHYiARS6IG/Ts4RwpnsxGZYrxANhItcErXTf9dd2ANFGeqxkmRdYG
 gccSz+dNvSCqzXynyORIBU3zbqMJhztIjQpoSLV22ZcMOcGMFxX89rQhfnRoCxIY
 x097Hs8bSs7/1Ei4du6froFDyS6cyTZhhKsDNQ/FiT4Mvz2830UpEDCr6u3c8ice
 okDP/g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0pmyrfe9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:12:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c20762d21so14020181cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786536769; x=1787141569; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7Q6fhegGiu/A6dM+c37Ci4gQqTgdFecpqlNFbfvbjec=;
 b=ZIgUPXSPkvdTeiJc4pgeFg5rSafdFflAmXh1ZZrfRiPNtf03MbVm9ipLdc74cmCQXA
 Pkx5WQhiVxUZsk0MSKkYnKRsifZhmZSKMy9y/GKnqdyQBh5NukS5/TgnpDWrNzRIjwSv
 7Os2zRKgWkf2teZ35HO2wes+OuG8z5+lZHwOco/eYSdiEpYoxCQWIPj+fjmAbEckuFjX
 nPtHcPJvimBZuVwQzz1iVu/5VY2ig1BBS2J/SspvMoRClVUjDskdL5JavRuCFu7QN9Vc
 0QGyO6uJ8drepa3Gozwe/lkag25usns9fiUn7YFsDN9fNLinu45vPRhE57ZILbbHyCDv
 WGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536769; x=1787141569;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7Q6fhegGiu/A6dM+c37Ci4gQqTgdFecpqlNFbfvbjec=;
 b=ZJNI8CS0oeMeiwW2RIAePeMjMmLFm7S5VAH5eC438ruxAtcsrAi+eSLcD04jElUHyQ
 7PDX+szhGNzoYz8vGHZZXXEv5K+IzVaqHNh9QL/K4yC4yNqFeY1TBGAKoArq9xX7hfzn
 b/w2UlI6QUrpLO1n1ZvLOPnBiTTaHjUAFDOUwoE7thupOfMaMHh/bhRQSW1u6Rcpe/Ci
 HAgQ9rGNr6DZkFJi91Mm/Yi/lTYKirihYfunNBdR481ycofRFWvpuU2zvaDfNiYoFnRw
 TMa2gntY1o5zFBR/jXe9XrEvlEwZtcNu97+izrFbzUq8JM0roGldg6pA4zNvZHM2D39K
 sCmQ==
X-Gm-Message-State: AOJu0YwDQ1b4Z+DTtbr5rSH/0ovNE8jJSNgnJ34ZBNqQqtcEke7+l3R4
 XB5lI6B3BJd7AhuMQGj7xetDqRiGy59aThJ2fUvxEurw3luLA5Ci0ZWSHBslG1YioMfgtDhk39N
 kKVpqJcuo5nZgCjVOFDJCI1aU98mO61bIb04AnIOfQSZAiIiXPfUDcTCrFOF5CYRCMg==
X-Gm-Gg: AR+sD11YH4TR9XJZWirC/7IsZIU8QP/oXIHYhZKHRRY7mXyk46zyQPmLhVslr4vtMeM
 wcvNoc6xXZKqczM5L7QbYoGPQrYjPDuQ9wIi+Pw9YNzSjOnYjUOwatMsUxIK25a/ogZ7pnCmmbq
 gdiE+OaZq8c5rPYsvOLyeLsNxhq0e1EhFvdhISlxOD0O5HkccZI+4YnLFZGUbgOKa2F0Rz9u202
 0gM7vWNmImvc2T3Kcu3KCgfFJ+jrGLR2sGSb1uhW4kgSfxpb+em24tDUwkOHBa+Ru4cYodcUvmy
 CA1+hRsNfETO/IqLJlKwX95/byBy3jaQIqqAkVKM5ZjDPZLMibwH3tjfmns4kaMmbHG9Z+jniJ0
 E6vgLm4W3wG/KxiXzfA7qtwDNzTPdOnssfogiO7v7TQ==
X-Received: by 2002:a05:622a:2d5:b0:51b:cdc2:fb99 with SMTP id
 d75a77b69052e-52d647a2fbfmr33526151cf.24.1786536768941; 
 Wed, 12 Aug 2026 05:12:48 -0700 (PDT)
X-Received: by 2002:a05:622a:2d5:b0:51b:cdc2:fb99 with SMTP id
 d75a77b69052e-52d647a2fbfmr33525491cf.24.1786536768427; 
 Wed, 12 Aug 2026 05:12:48 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150c08dd7sm6510552f8f.16.2026.08.12.05.12.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:12:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/7] hw/s390x/virtio-ccw: Always inject NMI to first CPU
Date: Wed, 12 Aug 2026 14:12:27 +0200
Message-ID: <20260812121232.71958-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812121232.71958-1-philmd@oss.qualcomm.com>
References: <20260812121232.71958-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfXx0ZAA5PMl/sz
 TJjn5xc9hLzrTsVbA7PaTOnYaJ65hoUAEfXE+ABKJnBy61lcWYTYRcDKaaqz2nQ9U14H8MXev88
 DL7kCV7XVVl82fOy9POusKs43cUAsjg=
X-Proofpoint-ORIG-GUID: pQu4X9wUQCODMbxNR21TQuwr1j3wftoB
X-Authority-Analysis: v=2.4 cv=C/fZDwP+ c=1 sm=1 tr=0 ts=6a7c6342 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8
 a=43zqHlSF2DfHiYptYdwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: pQu4X9wUQCODMbxNR21TQuwr1j3wftoB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5OSBTYWx0ZWRfX5TQhqU2AbnUQ
 fouoMCZf48iNQ4YzPiM2z+sRKJjbgEXoPgIUUfQSVrBTUyZez7P46zhQ1xTeuvC3WG6Sl3HiLbm
 Uvb7BqKpQiKAomFTJSlT1WvBjAAuKsLHtepobUpVyMDnO5dqP2QRK7qt418aG/M6J4+WX4GJvy2
 DRxWgmRALKa6uIawJIWyOymwhvqnDhK7EZYzGhDNGZb84MyNFCUQaE1SYxGUPm6luqj0jfDpCfs
 vsDsYy8QUDNps3WUdKV7Xggh7KU4eVGaSGPUG8pEOzLDYuuPNA4PhDQqJib/BYfMzLgO1XdBh0J
 v2yyJUrKx1XoFJaxJP+ACv7o4El4cX/ggdRK6FLhIozEi9AZOkImqY2R2s3eMhM08cF85IEAqby
 +T22NFAietr01ddHuoP3m4griHqOS6TALeIGutfSy+p9ZN/SriiVk+eoUQ63uXnTxRupjku8yqR
 v/ozcPXoZqjKSA60bxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120099
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We can trigger NMI from HMP or QMP.

QEMU maps the NMI to the s390x per-CPU 'RESTART' interrupt.
Linux guests usually setup this interrupt to trigger kdump
or crash. Such crashdump can be triggered in QEMU by HMP
"nmi" or QMP "inject-nmi" commands.

Using QMP, since we can not select a particular CPU, the first
CPU is used (CPU#0). See the documentation from commit 795dc6e4
("watchdog: Add new Virtual Watchdog action INJECT-NMI"):

  @inject-nmi: a non-maskable interrupt is injected into the
               first VCPU (all VCPUS on x86) (since 2.4)

While we can select a particular CPU on HMP, the guest behavior
is expected to be the same if using CPU #N or CPU #0. Since
always using CPU#0 simplifies API maintenance , update s390_nmi()
to inject NMI to the first CPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/machine.json          | 7 ++++---
 qapi/run-state.json        | 6 ++++--
 hw/s390x/s390-virtio-ccw.c | 4 +---
 hmp-commands.hx            | 5 +++--
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 9b2248038fc..2d63c1bac3b 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -432,9 +432,10 @@
 ##
 # @inject-nmi:
 #
-# Injects a Non-Maskable Interrupt into the default CPU (x86/s390) or
-# all CPUs (ppc64).  The command fails when the guest doesn't support
-# injecting.
+# Injects a Non-Maskable Interrupt (machine specific: for example on
+# s390x CCW only the first vCPU receives the NMI, but on x86 machines
+# all vCPUs receive it).  The command fails when the guest doesn't
+# support injecting.
 #
 # Since: 0.14
 #
diff --git a/qapi/run-state.json b/qapi/run-state.json
index a5771ad4681..e4fdead1e0b 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -317,8 +317,10 @@
 #
 # @none: nothing is done
 #
-# @inject-nmi: a non-maskable interrupt is injected into the first
-#     VCPU (all VCPUS on x86) (since 2.4)
+# @inject-nmi: a non-maskable interrupt is injected (machine
+#     specific: for example on s390x CCW only the first vCPU
+#     receives the NMI, but on x86 machines all vCPUs receive
+#     it).  (since 2.4)
 #
 # Since: 2.1
 ##
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 25a9fa49554..4f7861dbbb7 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -727,9 +727,7 @@ static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
 
 static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
 {
-    CPUState *cs = qemu_get_cpu(cpu_index);
-
-    s390_cpu_restart(S390_CPU(cs));
+    s390_cpu_restart(S390_CPU(first_cpu));
 }
 
 static inline bool machine_get_aes_key_wrap(Object *obj, Error **errp)
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7ae2468a3d9..a1b77ae4044 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -865,12 +865,13 @@ ERST
         .name       = "nmi",
         .args_type  = "",
         .params     = "",
-        .help       = "inject an NMI",
+        .help       = "Inject an NMI, in a machine-specific way",
         .cmd        = hmp_nmi,
     },
 SRST
 ``nmi`` *cpu*
-  Inject an NMI on the default CPU (x86/s390) or all CPUs (ppc64).
+  Inject an NMI, in a machine-specific way.
+  Not all machines implement NMI handling.
 ERST
 
     {
-- 
2.53.0


