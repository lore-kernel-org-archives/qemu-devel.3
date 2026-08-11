Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBA8C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtk8O-0008LB-Ev; Tue, 11 Aug 2026 06:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk8M-0008JN-UR
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:55:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk8K-00008q-20
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:55:02 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BALVb0338595
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XgdgW8FHpQY7YzIFnfakjsIyt0J+i7IP25N5DI75/PE=; b=H0JL+lgs6MhQ1tQN
 Pp307qtcLPVuluhvTosceEtzMvvnt9VkXmxERWWjdeffFWDyT55EmSSrcB0uYwY6
 PC0wLhVBSuVWahbxMj3oG874B88eO8gSsEfajpFVN4zDONhoWVsUOHPRPFVpHYHF
 PxOxPt8nokfrnBxcqq4DGkusvAGYoJeI7zKvNemlQ/lh5nN74/IEiW9ZBAQe7g5Y
 verJ6g8r3bYVI5qjEzNl2j6frkc+wzqVBKyfnNS6YUqIivO5HlbmV8v5Vw6MiPGk
 gbOnAxv3aeqX93hhHTSAb7T5NSCaY5IoXMOxjpPQWrdeSBMsmeTR+gE6loRQ8Ibw
 YMySYg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01nc05bg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:54:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso37818271cf.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786445692; x=1787050492; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XgdgW8FHpQY7YzIFnfakjsIyt0J+i7IP25N5DI75/PE=;
 b=WCBczY7DU+Rew8aUsK4lKkc79SJHenkuzacNo+WkrLmXOkQ04Wx1+T6pOUO+JfhYwb
 W99rCX9Yq3XaUCoYFZbLN2Ulyl2oGDbP33tsQ0iUjFRyDb1e34mKuUpXtY8Qs+sl5b1V
 j3lRBE1hQQqvN0AgdQbI006/7MGHEeiPDHV4DgtUsqnSgVocEPpjCdjyrEpuNHoDqqQn
 +2wxTYlt6YguHuTq2vJgUdcYlZAKGUtbEMqJi/CtbOMQuVWO9hSZbnBTSdhbrTVBlsrw
 50QPD576drSW9QD4bliSKRWBJvtGjISK9sXo/fiHRwTIQwown08+K04vNJPEj0u1VSgU
 aMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786445692; x=1787050492;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XgdgW8FHpQY7YzIFnfakjsIyt0J+i7IP25N5DI75/PE=;
 b=PMJYP6fZCLtlB/M0AgYMxWz7QSajTTWx00nbhRMeBsPQNbODIaFKl/zGfKk/HWGzN/
 gIuBhAdQXAVD6Vp0XI5Y2YtH1x5eF8+9IZ2jYjMkZV8avb82vSg8EIAMVVitl6IZw7c5
 sW8d7N13l6s+87QfyPpbUWaSmMoGpsy53j7BlM9T1Cis1i+pkOiBtnr1Udzwj0pi1csv
 qAS+8ik0bgIj4yD/9Z7fIhKgJHuaxHij8ar7k6wnyRd5zeEZqryzcbB9zUUfs0U2O9ta
 JPKtObmSeKYA223ejR9UwaijduMMb2UAp0e4V5vcnyJKJOBQnBh7G3kY8KpolrNEewW4
 2tBA==
X-Gm-Message-State: AOJu0YxHLWr4+Nca7yGNreCRGMiTugnplBafX7jRaida0y6ZtEcUuCMV
 Jp6keqdRc8pz1+33iImE8xn45c3PoHFTvFhld+HTKd39eUPWnckASDpN+dNLTBjypJsdSvXTU5a
 CmMpIZqi4OpbEhUi+VUyh2JsU4uYe7AIkID58i0NxiQTxxQVvDuPaTZFLHv2h3ts4GQ==
X-Gm-Gg: AR+sD13e4Z5BoVvnyg2arkBJKbMmq6DdMAFpCx5F5csWf2XPLbC5cE2+sy9/brn2YW6
 ZF66uGHdpTxha5di4b6LBTvqA8T54HqbfOqa/M01nHeU4Vx+bJrL4Bdxyzs1b2UzRgt4+hIXKm9
 liytIfP221ynPmBAQsb8St5yC3yWGdqFrEIcZuwJKJqds6ew/Q8Mp9MZDv9Yd6VhVfbxw408qAr
 B+7595yvsmFuVhIq4qr1OFuwe0W3PmvX4vK2Gcz8hDfnYO2zHw4CdJF3YKFFmGRLe7lN7QsrmCs
 4NsDoDVews7YgzgXa3az7CtZNdDy9aj5ZkCMR1b5ZFI1bzv/+pC0eA2iqY5MOxuNrWVyjG52eW2
 +AMv8X4xti4temo9Ai0BDDpB0rbr3cCPTnWJkvnUjpqVyMdQ=
X-Received: by 2002:a05:622a:4d0a:b0:52c:cc14:ff5f with SMTP id
 d75a77b69052e-52d5869539amr18874711cf.38.1786445692347; 
 Tue, 11 Aug 2026 03:54:52 -0700 (PDT)
X-Received: by 2002:a05:622a:4d0a:b0:52c:cc14:ff5f with SMTP id
 d75a77b69052e-52d5869539amr18874261cf.38.1786445691889; 
 Tue, 11 Aug 2026 03:54:51 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a5ac691sm3705229f8f.3.2026.08.11.03.54.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 03:54:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <minyard@acm.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v3 3/7] hw/nmi: Remove @cpu_index argument from
 NMIClass::nmi_monitor_handler()
Date: Tue, 11 Aug 2026 12:54:21 +0200
Message-ID: <20260811105425.7429-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811105425.7429-1-philmd@oss.qualcomm.com>
References: <20260811105425.7429-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfX5n1oBufJVF5E
 Po67A6OsWPYBgRQZov2koDo+2MqDpPDXwb08yXpqo5T82BSzihcUbognuX7B+clqQ7vSjsGgTRn
 q3XdI/PjnIhF5K1hofh99q3TYx9VGA0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfXwFD849mrm8qp
 VTboY7MhgfkiLr0jG36me58btvRnsEEU+7htzFBWAR/bbW2J6YE5q1CzHnLcA8N4eKs/wso2l8R
 dL18RDavUevKZVmJjlr27Q2w6u3bX1+tE9wXYxpAXauzeFUxa42Tzraw0aR4n38fooVcqzyx/Cv
 3LCTO0j/lKjOZLHJPWY2eK0gyNcobkStuMs/kpnKbH95YQnAK5rzO/O9/gXEltHZx+0sLKbxBSC
 axTO/Z4ddCY24tkJdjIwY6qFSZ99Te69cBOvNYUVWM0Ps87LWNIiieQONtOyObURjerCdDgZ6Ny
 vg3qAsHRxBS8YYWIaE5PMvftTSFKJ7Q/ZyJpVwO8JaVEp0iNr8swI/hzc4fCeVMbLzqvyMFZ/li
 HQ7O0Gk9k7kV6zlItjGrHCqM59jADfY7cDw71xs6GqVxD5qt3MU4VXlmJPYdtRrtNHY6hTDCvmx
 AY/uCPIBHgW6D9wMa6w==
X-Authority-Analysis: v=2.4 cv=RY6gzVtv c=1 sm=1 tr=0 ts=6a7aff7c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=KpD7k0r93PjNlcRUnYkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: D-IdwFgsNk1-Id6Gn8Loy5m6zYKsAXbY
X-Proofpoint-GUID: D-IdwFgsNk1-Id6Gn8Loy5m6zYKsAXbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110090
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Only s390x was using the 'cpu_index' argument, but since the
previous commit it isn't anymore (it use the first cpu).
Since this argument is now completely unused, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/nmi.h      | 8 +++++++-
 hw/core/nmi.c              | 2 +-
 hw/hppa/machine.c          | 2 +-
 hw/i386/x86.c              | 2 +-
 hw/intc/m68k_irqc.c        | 2 +-
 hw/m68k/q800-glue.c        | 2 +-
 hw/misc/macio/gpio.c       | 2 +-
 hw/ppc/pnv.c               | 2 +-
 hw/ppc/spapr.c             | 2 +-
 hw/s390x/s390-virtio-ccw.c | 2 +-
 10 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/hw/core/nmi.h b/include/hw/core/nmi.h
index fff41bebc69..4c4ce79071d 100644
--- a/include/hw/core/nmi.h
+++ b/include/hw/core/nmi.h
@@ -37,7 +37,13 @@ typedef struct NMIState NMIState;
 struct NMIClass {
     InterfaceClass parent_class;
 
-    void (*nmi_monitor_handler)(NMIState *n, int cpu_index, Error **errp);
+    /**
+     * nmi_monitor_handler: Callback to handle NMI notifications.
+     *
+     * @ns: Class #NMIState state
+     * @errp: pointer to error object
+     */
+    void (*nmi_monitor_handler)(NMIState *ns, Error **errp);
 };
 
 void nmi_monitor_handle(int cpu_index, Error **errp);
diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index 22724046575..ff6454437c1 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -40,7 +40,7 @@ static int do_nmi(Object *o, void *opaque)
         NMIClass *nc = NMI_GET_CLASS(n);
 
         ns->handled = true;
-        nc->nmi_monitor_handler(n, ns->cpu_index, &ns->err);
+        nc->nmi_monitor_handler(n, &ns->err);
         if (ns->err) {
             return -1;
         }
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index d762163ddf5..2b44debc388 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -829,7 +829,7 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
     cpu[0]->env.cmdline_or_bootorder = 'c';
 }
 
-static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)
+static void hppa_nmi(NMIState *ns, Error **errp)
 {
     CPUState *cs;
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index dc7f0d56b01..0ea5453403d 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -147,7 +147,7 @@ static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
     return ms->possible_cpus;
 }
 
-static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
+static void x86_nmi(NMIState *ns, Error **errp)
 {
     /* cpu index isn't used */
     CPUState *cs;
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index 68ddb5351be..bc41b44d455 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -70,7 +70,7 @@ static void m68k_irqc_instance_init(Object *obj)
     qdev_init_gpio_in(DEVICE(obj), m68k_set_irq, M68K_IRQC_LEVEL_NUM);
 }
 
-static void m68k_nmi(NMIState *n, int cpu_index, Error **errp)
+static void m68k_nmi(NMIState *n, Error **errp)
 {
     m68k_set_irq(n, M68K_IRQC_LEVEL_7, 1);
 }
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index ac9062c6488..b13e5ef95f1 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -159,7 +159,7 @@ static void glue_auxmode_set_irq(void *opaque, int irq, int level)
     s->auxmode = level;
 }
 
-static void glue_nmi(NMIState *n, int cpu_index, Error **errp)
+static void glue_nmi(NMIState *n, Error **errp)
 {
     GLUEState *s = GLUE(n);
 
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 1a7c534d652..1bdca728f97 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -188,7 +188,7 @@ static void macio_gpio_reset(DeviceState *dev)
     macio_set_gpio(s, 1, true);
 }
 
-static void macio_gpio_nmi(NMIState *n, int cpu_index, Error **errp)
+static void macio_gpio_nmi(NMIState *n, Error **errp)
 {
     macio_set_gpio(MACIO_GPIO(n), 9, true);
     macio_set_gpio(MACIO_GPIO(n), 9, false);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c0cb45dbfbc..8676be7bbb1 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -3552,7 +3552,7 @@ static void pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
     async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_HOST_INT(0));
 }
 
-static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
+static void pnv_nmi(NMIState *ns, Error **errp)
 {
     PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
     int i;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b79828b4e90..189334b9f0a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3550,7 +3550,7 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg)
     }
 }
 
-static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
+static void spapr_nmi(NMIState *ns, Error **errp)
 {
     CPUState *cs;
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 4f7861dbbb7..5d8a73a63df 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -725,7 +725,7 @@ static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
-static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
+static void s390_nmi(NMIState *ns, Error **errp)
 {
     s390_cpu_restart(S390_CPU(first_cpu));
 }
-- 
2.53.0


