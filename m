Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7763C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 21:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtXgw-0003wT-Jx; Mon, 10 Aug 2026 17:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXgu-0003wB-Jw
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:37:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtXgt-00083U-3X
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:37:52 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ALY1YZ2488349
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:37:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ATcBrG2yeZMCHfljDwPMFnFAKAfIn2nijZT8vQgsxbw=; b=mKMZG/x7eSH0HUmM
 /U4d9obHxtRatBuqoJvd2YPlGSHYWiRyVitDORYucwz/E8rAhlgXlxEeC46sI7Rf
 xOL2ke4gDD2r7wSd9xPQP8gzQ9Ingv92T2V9xTrM2gBRs+ur0TjXmA9aedvdClGc
 F3AoqkFmUc9+LTAiuLk1AO+I5mDV4PqaNfFZ9BN+KTMBvibOp0B8XmYBpg9CwLan
 i0ZmTeYCns2F29lQNKZkPUS1YKxop0g4yaks1au7PCCby6G6QX+cdL7gL4FgNDCU
 Y3xTmKGQTrSCtaC+usggUSsORWKfPhYq9Hq2dYSCd4NfPZlk6//29cA9YhTHrkPM
 fEqzIg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyccqu0ks-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:37:49 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8e934385db1so1656256d6.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 14:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786397869; x=1787002669; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ATcBrG2yeZMCHfljDwPMFnFAKAfIn2nijZT8vQgsxbw=;
 b=N6MosynIuYiVQVBh69fYQnp96Xb9/wb+XcXeyLB54EKflrZ/K1ntmszGQPBxIdsgXf
 a1Czp5d4JuLP/3kXn817v9J9JGf2aVRZ7qbC/xQYmlv/AaPS+csiWhUg6EfTCUVSnxNE
 wE4EiPc86yQ6UirlyGzTDrAV9IBzKW4O8ZPRK3iHdw6OjUFBujh1pP9mQ6cdhzMBMIc7
 6rx6FN6zyO0se4pf7gHASkJRItwxS1anuZMCGgJZgsPRtpACX818qxuXynlbL9ogLwWQ
 0h6cUEXcFPqnMayLMAAEYPN2hWYU21Zcy9lSnBezsrrqpkbJe7bYOdA3VD406WDoA214
 bgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786397869; x=1787002669;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ATcBrG2yeZMCHfljDwPMFnFAKAfIn2nijZT8vQgsxbw=;
 b=Odb1RuPjtnLQKYOd8Yza65ovzaulILCVIbLFvkAfJUYrhl3IxyAI25EvqxIOkzAUIZ
 /FDDWtOOtK1DQvdw8Fiz5emBgX5Wdv/jfaYR6uAm+M97tRG8IegAt8WncrZOUChwr7GU
 hRb0jOnMh8Kmy4jTeOz6fjLi39GC8SuXW1ye3dQf3a+9Jdsub864ZEVzqvyiOUFlSlLY
 tBxoz+IsgIcQHiB+7cBIjLAfLv1UwH2xAbSvPtT9OW+1jS0uNMtOrOU9UgQNVQkHC9yq
 ieneWrRJ8Xqsm2A1Jxlzd6WcWwyXXsblNBZi0yOiYDMZSxlJDHK3WKxb7nbymbWs/Vl7
 mlGA==
X-Gm-Message-State: AOJu0YyeS8JrUAoLvmUBljLKxN494D79HrH7wNV0oj/2y0VoHAKHsCNI
 K8pkRXjmLAj8hnIsOxR+P5JVSmIVGOK7tu+9+yq+7nrM6EQ46uGSRMNxysHePYHTL+yUzwnXCJ5
 /mbRFdfHnpSqcN/bLw6zD/aRQWnuJXqk2uVlSc6zzuArBTTRz/KOZ2DTNYqNNPYYWVg==
X-Gm-Gg: AR+sD10UeVZykaZCLAeDPAPSgqy9eCHZBFxfvKccgxlF7QHAE++zsTXh2Z+82vycnAF
 XWsw0usQLZhsNDZp0oS6XlOKN6xRoj21cgcIdfnRdiCr1F3uL4qOPrE8xD/pIIjN0wJ/KAuf5GG
 0IArG9qDihXxjPNvbAXexpoe/dlbaw++yioPsrAQBDYbhBVIOvCk8GtzYfP3nNQ2D9FOQ4l/7Bb
 nvyKWZoXEmj75nm+A4OBJFf2jf3R0ci1cwFoYmCyKueEWhhaeKkGxoexx8mk2Ez1fiS0+9YxFj1
 bEu/A7zPfZlTN4W8x63infQgZTMKN7nnRhtncyV2wypNnI1xVjSaQA0oLRgU3W7HL17v07XKEo4
 w/Ufcief+AkQuoAnK2/a/qheAlAJi7S1z01OYikf0dAWiqCA=
X-Received: by 2002:a05:622a:998:b0:51f:20e1:137f with SMTP id
 d75a77b69052e-52ce6035ce7mr544736931cf.19.1786397868759; 
 Mon, 10 Aug 2026 14:37:48 -0700 (PDT)
X-Received: by 2002:a05:622a:998:b0:51f:20e1:137f with SMTP id
 d75a77b69052e-52ce6035ce7mr544736431cf.19.1786397868289; 
 Mon, 10 Aug 2026 14:37:48 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021457ebsm37416160f8f.6.2026.08.10.14.37.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Aug 2026 14:37:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <minyard@acm.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org
Subject: [PATCH 3/4] hw/s390x: Deliver per-vcpu NMI using nmi_cpu_handler
Date: Mon, 10 Aug 2026 23:37:21 +0200
Message-ID: <20260810213723.58467-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810213723.58467-1-philmd@oss.qualcomm.com>
References: <20260810213723.58467-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AbSnmWz-Mr_Q5Ch2IPBw1H2s4UVx6T90
X-Proofpoint-ORIG-GUID: AbSnmWz-Mr_Q5Ch2IPBw1H2s4UVx6T90
X-Authority-Analysis: v=2.4 cv=WNVPmHsR c=1 sm=1 tr=0 ts=6a7a44ad cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=H2vGOfxKvbjFiM68sVQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE4MiBTYWx0ZWRfX6ocF7UOADBK3
 cnyZ+hJ3Smi6oUvY5ux6WLDbUlQ0nUPutX5fgw/Cnd6CKzh38VzOWBOWWUjJYFK6bR6MmZp98+B
 yevRQxsoEr7o5GTrtLdFlj0gs9muDayVlvX508dWCey02riftwX2G6G0kJsPZIE74hB+X1O1xvq
 /M6SFxSi2e72cFylgMYp1bj2I8rMOB6cy9RMW7EICSqmErAqZ2npKIXTA9UTAMCQ5q18x6qUxFw
 IlgD0+IcRPeNieQyh9K0tXgy3wLOBjEGDrhFkwJF1N9AcP11Kcb5SPn1QPLXdx6O7yx1XUYwO39
 3Vsy8gN7XYIvPlB4hAnMr5bhWLEfixxEehLPlRqfecUqGj4M/zrbab0M/1X3SO4gZ2C7zqZY2lD
 LlV9EwprULkLPiu+PSQ9KtlpJoutvyaBt2tyneGPtlefMIocwgeD/v9HLw1g05TDJQrbbzA1Iam
 gwE4W+GDfETPRJQZnng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE4MiBTYWx0ZWRfX8BmkRfvfbA2r
 FPEIlpAmIRsEwGh/Lzqt0uu1qJK2A/kLxha3GGMCJD6Z9BcriQRx0pMNr4sikzh7Ii+jvAYgkwW
 P3Wu045+3JchosyiPy/x1xWwFDgVjUQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100182
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

NMIClass::nmi_cpu_handler() handler is safer because
the CPUState argument has been checked to be valid.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/s390x/s390-virtio-ccw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 25a9fa49554..b71086c254a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -725,10 +725,8 @@ static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
-static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
+static void s390_nmi(NMIState *ns, CPUState *cs)
 {
-    CPUState *cs = qemu_get_cpu(cpu_index);
-
     s390_cpu_restart(S390_CPU(cs));
 }
 
@@ -832,7 +830,7 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
     hc->plug = s390_machine_device_plug;
     hc->unplug_request = s390_machine_device_unplug_request;
     hc->unplug = s390_machine_device_unplug;
-    nc->nmi_monitor_handler = s390_nmi;
+    nc->nmi_cpu_handler = s390_nmi;
     mc->default_ram_id = "s390.ram";
     mc->default_nic = "virtio-net-ccw";
     dsi->qmp_dump_skeys = s390_qmp_dump_skeys;
-- 
2.53.0


