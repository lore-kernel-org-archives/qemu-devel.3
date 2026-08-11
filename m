Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A0EC5CFC1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtk89-0008Ff-EJ; Tue, 11 Aug 2026 06:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk87-0008E8-VC
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:54:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk86-00008I-DE
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:54:47 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BALhFT341090
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0ooFzW+Lv9lCiVhFwqR4/0Q/n2XWyHN2y+PA3RDrHc4=; b=ksU+8xIrlW3NeCfD
 uhCycczPvuaMDn04fPPcJf7M/k7579PtrzMA0tD/b3Z4yEm2sm78rcxhxbUsMIQF
 KMweGxAsTC6LYbiBy9knhSRWYK3GIFyYFqrtwB5Pdg7d3GL0FSitZBew/A6V7UPo
 Sg60P4ZxM4vbTpbJK3+TyIJvenrWQW2noxlydSrH+8vqhaWV7A7o23PbEcMAzjww
 tCbRbMCq0uwU+vY+7fNcCTPGkALL+ympO9fJ0vvwN8YaLLBC+fJZlsHpEUwi4Cza
 bGDq6n7EAkPIqpFq6+iGnuiMyvHBXm7CWmnRNF4ChrfkEjO54D8y4B98SCelmT2r
 qe4EFw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01q104ss-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:54:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c07f25de2so3244761cf.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786445685; x=1787050485; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0ooFzW+Lv9lCiVhFwqR4/0Q/n2XWyHN2y+PA3RDrHc4=;
 b=Zh+ZNB2LbCw+gDURXxpVnYYp8YQf92qNrnsDoPpyjA/AQ+RYf5F56aMoZLZ7e4UXNT
 22ms1CVoCIaD94vCXlrCBDn51zk8ZiZCikcOdKTsXx6SR0UXksFUIMyFeY0YFEIdytRd
 gQC3+2ahgkcLH0vhKOSByk+bBeVRs/RDA9da2sGxADc7403ltYa8UEmAyEfJ5gde63ME
 IHqjZg9iZO/L+T15gwnvrPgb5aOt2sPq4OVC4FEjfMnQaMWWk1NlGe+uhhAp4fBBCOF2
 tQwsGozVnb3v5b06+QL0sofUBatbbHRc7vpzUDJ+W3aPURP61yY7t8k3nSt/XEAK3pPe
 iYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786445685; x=1787050485;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0ooFzW+Lv9lCiVhFwqR4/0Q/n2XWyHN2y+PA3RDrHc4=;
 b=ZfhT7pT2hDLdeVIvWnQo0KU7N2MFudpEuo4sfOdHJpJCZWhbYzp0cE3PNkEwmPceTL
 NI5LJvaqPadqRg2wEU2FYL3SoxnwRFpL8aFOCaKfFBvGU7bmAnSjkztThdP+HMh9hbf0
 eZzyURoj/stRTRPTsxhvW6Drw+ftA6iRz/uVa2FfeTFc9euBvDVrqmlvNqsYQmei4cvy
 ApLHVAdYU1b49VSI3QFOQSe1t4vxLaioFw54TrCcotqULFHtpwo51WF4FasJnBRitRg/
 uJI1u6K3x9ksKeNk02Z2GPXZomj1p2lzFkZgqifm9wkjzd6dtoh0fK+VWotTeKjEeZL4
 uXWg==
X-Gm-Message-State: AOJu0YweFmyCUxUl6ERWpuCCEio2VAHWJBXBOcW3zpQ0ifXezN428HZE
 bcar/glfvG/766wJor7W3qws1cNfm7CO9T+7MPv9VmPXZCDMwO7TyiNe0aQs33ArUwAi8jx2tjU
 mmUXVsmns/vn3Ijh/RH9KZ2+Hp0vcJKhZ6ASyFUbq2sXfoTbLV4fjFC1iCCac60D2wA==
X-Gm-Gg: AR+sD11I0am7v77KRinFXtNTgdk5UKZKsvG2Z932oDVcjcsXkZLYLvZYA7gN5PGNHmK
 YFrKQVjTUByNCUPAHH2NtS/oyuTYxYyZbBkB8KRh9jr/4rHx1rFtAQ3gphTjM+bzdhEd1UayajS
 4yj3/ycog9OU5DXUnKMJrUAu5X5Kx/kz31xr9gRzXjoM9+asEOemDfHGoY5VoNVlTntFcCe115J
 ilVXgtm2W/WbBFFc8AE3xnKdTAnmVYYMjEAGS6jx5WsCe4vp3r0Vghmt2KrZnlF3o/U+4GgsSOV
 49fj/VDUZsY8au80U626ym0mklTsVyRAHQpuGZoWzdbrmUsqd9es/xurMsO9s0zodNNi31uBO1B
 SXm/w2Fj9wQz8TQSCoZ2cde9QljOJWkwRryN/+GkMtoUzu9g=
X-Received: by 2002:a05:622a:1314:b0:51c:844f:28da with SMTP id
 d75a77b69052e-52d584a6d54mr14264431cf.5.1786445684555; 
 Tue, 11 Aug 2026 03:54:44 -0700 (PDT)
X-Received: by 2002:a05:622a:1314:b0:51c:844f:28da with SMTP id
 d75a77b69052e-52d584a6d54mr14264111cf.5.1786445684087; 
 Tue, 11 Aug 2026 03:54:44 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49974146b83sm57807885e9.11.2026.08.11.03.54.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 03:54:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <minyard@acm.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 2/7] hw/s390x/virtio-ccw: Always deliver NMI to first CPU
Date: Tue, 11 Aug 2026 12:54:20 +0200
Message-ID: <20260811105425.7429-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811105425.7429-1-philmd@oss.qualcomm.com>
References: <20260811105425.7429-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cpQnHejahy_rcLEOQ3vaKPJNYytbyv37
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfX2BKMqdAz5fBP
 I82rgY4BfzbwaLqJ3GKIXYmxDS3P7etnK9ubUto2lFaQKFT7EW88rTGlNNpm5SqzUukyMpOKlfS
 wqNiIwxhTtMUWDuEuV6Rdq/PQFv5tFdWMGTAKv2oI/zGmZVc4caLUFD0utU9UecmNqIMDnE0XCt
 Sbkb/mfUVcCYjBUJF4+ViUfschzh1wW0clnAcYUytxPlQIPadonFFifrUEez02BwaBTiqwcMm5p
 x0Ws4QbbA4ybZuoi8FYKxt0SKC0YAJ1uQ/O6GHLMHAn9bBmAUGWZ3BIdCStWd/XzUaCLwf4OOCc
 ftmupUOjZd0l6Hea3ec+G1XOJP9TCKB2OvhYdNGpszta9Dj/W1vY/4mPGCrtOB2YC2RMF7oN3nG
 SAQDpiW/qaOBFu2fI1qW5VLww6jAzfCA+xe6rgJJXQzPl7mg0lsuUDc+fFO16Y/QD/vrR6vNtcF
 j7MA22ngouCDFm8TVzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfX4htn8FnkNtOo
 YKRISGJsMuHDD+5boJqVn1iLvOwwms1SkhRqPbJLUgQX+NOU+IKtPrSe6rwDhsou0GtB1bOwyaA
 7M3wTr6nZmO/AdvFNsa0HxnAZOKrJV4=
X-Proofpoint-ORIG-GUID: cpQnHejahy_rcLEOQ3vaKPJNYytbyv37
X-Authority-Analysis: v=2.4 cv=brt8wkai c=1 sm=1 tr=0 ts=6a7aff75 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ON7NdJYOkfl7qig6nyMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110090
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
always using CPU#0 simplifies API maintainance, update s390_nmi()
to deliver NMI to the first CPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 qapi/run-state.json        | 6 ++++--
 hw/s390x/s390-virtio-ccw.c | 4 +---
 hmp-commands.hx            | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

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
index 7ae2468a3d9..3aa159f11ce 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -870,7 +870,7 @@ ERST
     },
 SRST
 ``nmi`` *cpu*
-  Inject an NMI on the default CPU (x86/s390) or all CPUs (ppc64).
+  Inject an NMI.
 ERST
 
     {
-- 
2.53.0


