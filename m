Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A902C5CFE7
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtoki-0003fc-NC; Tue, 11 Aug 2026 11:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtoke-0003bY-4z
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:50:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtojg-00023C-5O
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:50:50 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BDWXmU1914347
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 15:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZNPVG0pKMHrN58VHLVnd6gBqWmgUFYW3CfavPyrN/lk=; b=g+s4IhTILG6XVyKU
 7A9PWFf5tgTZVMh7YgEElFjWziN4ZbzkL5qigb21Jwc1iCLfvmsTc99m9lGZyOEt
 wAauAhR7eQbRaI9AQmoR+hvLQvq8VgcxAn3XF5+mEqUA+QEiYSCeG8tk6dRGmWxh
 wtjA1vvT1f2zZ7SIW0xfCDOjyBmN3dFhdeZiZWAsrIoKfvTJuMUg9i4b6IT7azEa
 ZXeRSB4R5aqwwc/aTruxS2ckzzioQRibY9t2n1RQXoBTFXPy3m8Atxk+W759xcPW
 3q4vzO1poUDiOM3B52wNiWXphCZgcrEDwf9bUDNCmChwGHIMzZFjD9418y97lpNx
 u5e2jw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049brs03-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 15:49:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5276aa86d00so600721cf.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786463390; x=1787068190; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZNPVG0pKMHrN58VHLVnd6gBqWmgUFYW3CfavPyrN/lk=;
 b=ZSqwP2fdIB9DBi5Op3y6QYwrZzWIFASkbju0WTeAXJXZaF1TKB7tGczSwIXrDivA5j
 UpIYesYfGn+UB7Zw21tNrGqvGrhjjUXYWkzlkU25My//DzatIq1d8QLbMst5Crhf7kuV
 un2AlnvdA/JSzauz9T+ajtMEYJJLFB2oathzT5eylx9rDynKN1HmurwT7y5hPnEyg7RH
 oekHZ39GlqeJjHc13N/Xj91ULuV1/S3joe0NPqcMZ9o7RhZUw9U8hp1wB5EyJ6/enAxU
 Kckulddpiyvja0H20Wc+2pMJCeLdALfHhhX1JIQKn/rwTAxDesyyz4UrLhIQ8H2OVZMj
 b6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786463390; x=1787068190;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZNPVG0pKMHrN58VHLVnd6gBqWmgUFYW3CfavPyrN/lk=;
 b=gmH9TWDZ7nbDnWdIBIx7DEtDxUH1Wb2SYJEpyJLpe65gwPSh41F2st3QjRx1d/BVh7
 zGnRAIvjlm3TK/KbTyb6qMrmV3F35rmmey1wI+8NZ8Ltm3aewIVSgcsQOYj4wZr7sxCB
 cgEmGoZHSKcHhXgT47/SIwddjMX1CTUCOWQ68GyCI15wiC1nEDwL23FT+1hWkn32I4Uj
 RupCzuj88kEhE3Ko8qozAg2Qioi9fSZO2mQS8Uo5ZdUjkgzYlS5WxUJiKpyFA2T68K46
 4aVH0qppjxhiEcEj5b/RBuCW+vjqvwoUHYwVCWfiEf3kXrp6+t//7ugozW8/xWm5dEWu
 qM+A==
X-Gm-Message-State: AOJu0YzpDCr5TGTxleS/T6AV5a61iezsMt5VZZsy4uRlTgAN87UlVsIS
 Iirjlq5XfUwX91MLNNYccl6iKU3uC3ZXuoZNEGiBoMDQMIePGjwomKG8MY4mZcn2L4q/TsjlVvh
 aAoKrwgEiJFpJtqTOAYWnB58hrTbPsTgB+wAJZcSarDPyJYaLcWmdx9RduEDoulRVUw==
X-Gm-Gg: AR+sD10/lOejKO35FggMzM3hcFKK8pbnTPS0JhBkiSeyxkV+aTAf6+M7EiqOJBRX3fQ
 mrT5Ybjsi1Vredof3dygnepH7B/zDxcsswELvUFwOXvzHUQCvS0sDbcaG2vv9Dbc3GiQh0bIEAO
 R0fLaJ8eMucWPbdb1lAmqLgytS9jfVHvRGtr7bQElTM1R2YVVkwZm6JHsHYE9cRtULbYlvBzhuw
 2xgx8oj55Cv0sklR/KCJ8m6e7DYQhKmunZjYlew9d6Dx3CFKVK3Zn4qJClwGV/wI5kOsaQzPKxs
 Mx59Z54vXgh6VDL1wVcrDzJAgf/2FfX2JeBa1OwK0PED1SHmoOdRvRvLw4zz0ZnEBEYi8fQygkX
 iigFZEtI8UaBtsOBV05jhitZqi4WYSvg/xeeBpda1zQ==
X-Received: by 2002:ac8:5c85:0:b0:517:c65c:488b with SMTP id
 d75a77b69052e-52d582aeecfmr36666691cf.0.1786463389531; 
 Tue, 11 Aug 2026 08:49:49 -0700 (PDT)
X-Received: by 2002:ac8:5c85:0:b0:517:c65c:488b with SMTP id
 d75a77b69052e-52d582aeecfmr36666051cf.0.1786463388991; 
 Tue, 11 Aug 2026 08:49:48 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a709594sm5364913f8f.18.2026.08.11.08.49.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 08:49:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 2/7] hw/s390x/virtio-ccw: Always inject NMI to first CPU
Date: Tue, 11 Aug 2026 17:49:25 +0200
Message-ID: <20260811154930.13915-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811154930.13915-1-philmd@oss.qualcomm.com>
References: <20260811154930.13915-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uc25wsfe7cTpj6vP7qN5izVc5e7RK5eW
X-Authority-Analysis: v=2.4 cv=ENg2FVZC c=1 sm=1 tr=0 ts=6a7b449e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=43zqHlSF2DfHiYptYdwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: uc25wsfe7cTpj6vP7qN5izVc5e7RK5eW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMiBTYWx0ZWRfX7yOkG9cOsut1
 O576sPA0i31YAS2/nCOwlw4DTIXdYz71lytSwtR7IYd51TjlQUns6Y1FHyqOBHxO9x9Ni588wy3
 OW7aZFqM+osajP6n1vJ6dSqnXaU1U5eoAx3s8xDnHPRjuApfxW+aYSz4Pxiz9u1HKaDg0HImzNQ
 LVRsH7G/eRgY7/TrsBBn1z5LUgBzmDsmmnxqKTPoWcw+4UMBOF3dSUnETird463MtAOqVZyABTZ
 5NZmNr8a35P4VgpryFUqsIFPuIu+mIsPGuXp+Wcd1D2FsySmOX1+qgSynjmfMKBRf2FYauGa40j
 DdJJ6xi5sAEhF1+Dquol7BjEoAh81sQm7D+k6kfPfydkgbchNvKEWuE37JNnACJhNzUtcpU8A0q
 QaNw5MAdhIyHUSgAoILrGPr6ofsbryouK0OG33iAV0Wt/ByrFN0KoF06u2/8H7LdGfDDIm4uPJT
 7B0psPuYruwDE++VQdg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMiBTYWx0ZWRfX8ib22UlhDbup
 m3YeolTYhEJPDuzZ9EpsdlF9hPmvQTrkTxMSm0yAQDm2fienGiCiQV+XwTHbAXC1Vf4JdZ4hLXx
 6HaIQKjFnbDWfkLSD10VuIiMKfhKCBc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110132
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
always using CPU#0 simplifies API maintainance, update s390_nmi()
to inject NMI to the first CPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
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


