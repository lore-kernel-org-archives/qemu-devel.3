Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6E3C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcBp-0000uY-0r; Sun, 16 Aug 2026 10:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcBm-0000dH-Ri
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:50:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcBk-0001ba-Vr
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:50:18 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkqSS3448447
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QqIkE/I0/yFqdHPM6vpD2vvVo379ilSQzNAkLmO2waE=; b=BAzB6Xq/+BhYkwBt
 zY1Hnk7IR2WPOdn4vRk3+RP+3yD+Us6Q/nelIkiuHxEuuVpUr8YFuugUKN2hUV4s
 J9fcdvpcyN5Uh/xrR6S/84tMxBJUXp6JxAeqBgHwdHGozOHFjUVxm41C60hhy8d5
 lENO/FjM+ASUEdQ6gu7qneN8Wk24pOuka5Ygo5XKTOVqab8Jq2VceEnGf9bHKExt
 cID5SNkZiAyjkZgwOIWhIHXC2wRLPiftYZSHTws9grbl3HaCwZ0MpIxS5i8Am3Zy
 2CQgd8B3XQdcHQAgNjIFtgYPJMqbdSvE311yWqcp4RpKW7DUfvDDYHR7iclnTk1k
 1ngPCw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghk3mwg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:50:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936aa34873bso234183285a.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891815; x=1787496615; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QqIkE/I0/yFqdHPM6vpD2vvVo379ilSQzNAkLmO2waE=;
 b=QMyXmHExsCmpIoImUcUtCYSFeBj31nAFOWLYWYVJq3IE5amSxVx/dMyO2UHP0admCG
 Aza7qZqsNnQdwWJR/5h1S6LehImDgZ4unK1JS2oCgXNsczECINfgwrahIu73jdET1bBk
 o9pcAW2wRpuddBs9kZiPtsU79fOYvV7c9PtPU9Q4B+JLo1i++ZHN4jqZhaLmhM1r24ME
 AoACwgmcJLDWq3z/XEslv1zZCBoTGvVhWYxLvOsdTNbn9AaEBmy8jOYFyTfbaGSdAau4
 ZR/ioV40wQOzgd7/08UIEwRtHj7t3oSc9NmU1xIWeIufaBtZ8ZGmx57lMjlrmf2WAY+J
 YbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891815; x=1787496615;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QqIkE/I0/yFqdHPM6vpD2vvVo379ilSQzNAkLmO2waE=;
 b=Jptqi5U5NTU7AxBKbN1KMoid/iJAEGC9cK6E/0mpmonhDyfdjtU9ikEQgi7jN9cZWP
 6KqCDFWBYkmrq/W9Y5sfSJM9UaG4AzKe4435bEcnFJWCHjmjChZlvKFZPAwE22tSujkl
 msNPwa2Qt8VTDp1s8ejJXWnJZkkvqb7/M+/9vibyc+m6ZpP3QwoV1+PbbMLxAQAINvCU
 zbEz/IMSY3yCq5aGlVAdac5bV7N/wMXZ+cbDbd03k0wsDy7iFJCF1Qc8GdGuFOBCxm4F
 r+zDS+LpjTM6NsL/SX4p3srtIz8gTSmLRAB0zcmjMcEKB9QQyPh4wtG7bIJsYbbG0Lsu
 MD7g==
X-Gm-Message-State: AOJu0YwIczO/t2Su+KvzyM8TmHWtIfdlWYGb/vEF1F/4ekpjfO5F5SOf
 M7DXRYQ6Py7w12GpLkEcNfmjz/50rPfCe4otD4WOmNQOkNMSpMBWtsAwWZJOa/hvpK0G6CcoNDy
 3ThW1j1MsE9imWxU6x+S11xX53AmKp+vVelp+3mbe5EstfLfk1txk8mjtg4Xk05LQ3A==
X-Gm-Gg: AR+sD11yPrZUpDy3y/xwKTGzvaMt8p6V8RMQL8jtAjP1JpedY9pA8tswBRvlozNy1Q2
 0J5rl0m8oLwDh4BSEQyjk0S5Qcw5zEkvYBvfmEyZl1oJn0MfoEmcCaBoDOZ8OP5TIWyQ+c4A5/G
 +Nvhm6nWrJTT5NfdNGFmcN8SuEqWetRwtTKmfiKiLnXP0g0d6Qma820o+oHKG9UlAInXwkc0H+P
 KwNsygE5Z+uQ02a5FlhNmwi0K+jW/Jm88MGqaur4qUYRzZM8HcZOHOA+4zN11hQdB/lmFH+KdEC
 WyJGKHUqZ9dJKrNEGN9gzpjGfBpyZsuQ16DSiUm8qj7oj7qcYAng5wIVQmFHlfmC82Xac32T/W0
 BgpFKalybogI++ACzhCWLeHmlfmabJ/DyRsWn8GCwXA==
X-Received: by 2002:a05:620a:6881:b0:931:2:65b6 with SMTP id
 af79cd13be357-936d238c122mr2345954085a.38.1786891814856; 
 Sun, 16 Aug 2026 07:50:14 -0700 (PDT)
X-Received: by 2002:a05:620a:6881:b0:931:2:65b6 with SMTP id
 af79cd13be357-936d238c122mr2345949185a.38.1786891814353; 
 Sun, 16 Aug 2026 07:50:14 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610e381sm72886405e9.9.2026.08.16.07.50.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:50:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/56] hw/s390x/virtio-ccw: Always inject NMI to first CPU
Date: Sun, 16 Aug 2026 16:45:29 +0200
Message-ID: <20260816144556.69009-31-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX1Ir1Vrt3dh7k
 LcnymkwJF+j13pFmNCytlX1K80+5ElQN1uFqi8l5Rx8T3NAAJpISew7Pzx+64WiTtKy+P53aK35
 6dsRupLUZxe/JJZWSiNd5JpvWrRs/r0=
X-Proofpoint-GUID: fDCa-W4CmhhBi_LRlKSfMUtHV65MhCSV
X-Authority-Analysis: v=2.4 cv=f+14wuyM c=1 sm=1 tr=0 ts=6a81ce27 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8
 a=43zqHlSF2DfHiYptYdwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX5RzeQ99M8GvZ
 6W2wCqrtG1RkZbpJ0dlS/3XyELithapWNVN1Y3cc6nuTlbXECVsOVRSD8s0FyoEBXeTWSUGzoC3
 427kVzu6Dr06s6KxEV5kt7ToBd8Ea2GNStweLwsFRloyKLsW5yPiJ3TDelyWblwMjcGsoSFaXF5
 /lO0KW8JQXY/XJgBMXIF8W/K8/V93+JXKjuTxPBQNIR1p6BWLKmqV2WGiQ6EZ+MRwllHptWGNp8
 /j2l4EI1D9kA5VuTAfCj5fj/D1+6M++ZY0HozYMtfwUAiR7DWXnxopsZvckMAaqlNUQii78vEBG
 FLFJapZQ8XG5+Dk9/tzlGrfyYhE/l7X/Kg2SdJ/VCRHPLEZKHpoOPyKwnqSKbpj1wJJ5ipbOBOj
 IirZUIpL2KlsoaIQonERhBBbbzOWYLl+mEJpy8dZ/5ffXAHCO3aMNbRswlxIEZ73mCXP3vTFw+9
 kgIphMYRokE9iitIiNQ==
X-Proofpoint-ORIG-GUID: fDCa-W4CmhhBi_LRlKSfMUtHV65MhCSV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812121232.71958-3-philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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
index 55131c1a444..a2f373b1190 100644
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
index 7f43cf537fc..a29f02b623e 100644
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


