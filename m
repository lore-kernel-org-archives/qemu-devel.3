Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21540CC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8gS-000742-D1; Wed, 14 Oct 2026 19:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gP-00072X-CN
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gM-0006St-Co
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:52 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ENRK85586453
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Uhi4txl42tK
 kPIaQLzX0J7e559tjsyj/5nsF0REzlrk=; b=iSbmQMv0Z//xribqOSvM50bq7oZ
 eiRQ6snhLIN9lCKUZTR34wzNrQ2gBSrm6kAp4ek5vTYDfHF9LPA5YMMExLwwGt3G
 OJK0BNc0rkiC+mItscDS37xyJz4h1agUqAcFOEmPY3JpP/YLzFiZinFridmQgmNp
 QoKHyJDklrr8nDb8xI/TPtDVskwXcN7JxEUU/jpwXh+4qRxB58tMqgBayCt+goU0
 Y3l7n0DKp++NXyhhPT8xwR0P9o9Y6x1uzHeRb68JvESGsYgY/UeRAmFdL81PSZrm
 khMrFS+eVQ7GoDleUn4X7632jBLGUc5tz19ODP8WrG147eDDsQigbJaAvSg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakder1xn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so2247350eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021598; x=1792626398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uhi4txl42tKkPIaQLzX0J7e559tjsyj/5nsF0REzlrk=;
 b=h9ngfN73+VI0jiTM+jHH9p3U3UuU8PJiD4974nImI+ujBAZ7W1LGFUHeNaGClGjGCs
 9sNz5IxhLSQoeWx+IbAX6sXTXkV8kgeu6/LcD6WvalAHpjD4npZW8/0ePDqgKjuHpbc2
 9WI/h2xMfECUyVKGBUbWsg5QelrxIlQPqgrA87zfrcKrIUoDDY58DJekiQLst4NgEBhr
 EsUEYBkBqAr8kWaINDYkScISjT1Jws1QTqKzu9IJaoaRlObB0gSTK8tRWOqvnypUxIVF
 2Sa9+PaJe4FyLyIKDkgEONaICgb37amIbJrT4EgFkcl8EhExvxr7Rr4A7srJ36RHT0tG
 yooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021598; x=1792626398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uhi4txl42tKkPIaQLzX0J7e559tjsyj/5nsF0REzlrk=;
 b=mIw9o2Cx67Eln1cfKrISOeO3nTVZt6UqLRpA1vBSTxQx/zhwgUSP9VwMLOWajMjPhI
 JS4vZ+wE+XrRmTCNIyPvFfwJoCDEiltegaI1CGVQw6lCWMjklBxDZJAxpiP8poWISPys
 na8SIwV/MnI5b92IdRQaHPIGsa2hdr9TLFBcE3No7T/5VTQhykaJ1ugrDrbz1Hn46VDg
 rU5Qe8cmABWxMXBC5GlPf54T2XYstFPVNtf62vaKkTPuDBux7DSNMtOXbZhYlM1Vy6vS
 ykqzX2q39s2HZDE5erJrJvd+RwKq0iKcsTjbGkE+EQbU+XmtoDRG6h7cmTDo/f34EQ4C
 q5qg==
X-Gm-Message-State: AFq9FYJklDK+V7jxPpOGCO4S2x1GQyz4mYqLV61FFZ5ZsmybeWopNmug
 O88UzoaHxELb0OFegUGQL19gpaAmQP//yhY2df2hb2auAyUal1M5mGsC/ybwk3UJjF+BcksiOMj
 cxcLQQk14LoHq45X8QfjXHUNJuC/6XT/zj+w31dd37w/qN1g83AVp3D4rcOCGOYyssQ==
X-Gm-Gg: AYBFou2vuBmdcVT/DXA28LAZ7F8dkxzZ04HJL+xgTeQ0+Aobvk/vOXsmVcvCbW2Lf7h
 iY0yHWWML5aTBETxrbsHDBcbE2mC1S48IXkT2+s39XX284uB03vTQRUaHjPAw/yZeX8gLdqO211
 SDeHbLGKBUEM18l3zZFw+ymdR8VJWXF/Jr7+bY7OuaOKeRXSdMvm3W8lcBIpR/lwyZmDGyNp2QM
 kAJorMjyNUmMB+dm7BM1zEKaiNBYuOayL9S+lq+iOsi1KDOVuJAn5O+H7IkoYNWZ2d5tICcbAD8
 bN4uXCZyV/82gk0ZTmmfh5ZABvaH33+TZkego9l7SM16/kRP4G0AcKKM3mRSEzufPZMv0P4WkI+
 y4slbhimUL1HLnE+T2LueWeIy32CcVhEzVd8Jpes+JmuFz7sz3Wdh22AlZnag
X-Received: by 2002:a05:7300:d209:b0:35a:47ed:c39a with SMTP id
 5a478bee46e88-35a47edc590mr14360992eec.37.1792021598476; 
 Wed, 14 Oct 2026 16:46:38 -0700 (PDT)
X-Received: by 2002:a05:7300:d209:b0:35a:47ed:c39a with SMTP id
 5a478bee46e88-35a47edc590mr14360955eec.37.1792021597673; 
 Wed, 14 Oct 2026 16:46:37 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 18/19] dump: use new dump ops for note size
Date: Wed, 14 Oct 2026 23:46:04 +0000
Message-ID: <20261014234605.209084-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OdENnRTY c=1 sm=1 tr=0 ts=6ad0145f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=2GaGCBqw96iMQ7DTiugA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: A4QGcXDv2fdsVWGtgGjuxMlpFg5eqtng
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX+JMm1oDdvMSu
 lUC7S1/r4Dk31Fx9+SHQrn3/y6Xx2o/9PP087hSrPrhfaJq9d7/2K/aoKvYN5mnVBZhGZGwhXua
 ALk3Dc56AICqs0J+BpnccPrKF8r77yzJnkmhIL4FGwRXwzXuZW+qe4O8cbGt4+eHCb+F/K/AFRA
 nSSg8EK4RebfasUm/qEdfjl7rYd2v2ENfOK1tbw6Xf8Ei5N1Uwd+AfWRmc4eoRFH9X8qMbwWETX
 c15ovdQqFI6W/k8YFR0Gkgz8hf4UCZBM9/wa2yzQLNqTpooEf9ZKe3l4Ze0pbIP4siG+a8DpEpy
 1f1CAnSLHrF+zdi20jkXyk2nG0rb35Tj5r4KRiKU+piv7SLVq0fxrt3UB5AgcFcsw5nqSwV8+9B
 Vnccyor5SczMYyi6NsdV5HLKlj23+TqO9nh89XlQ9RZeFdeFpeYMn+W6I/GcGedpOGwCQW0uQ4l
 sWUbEPuWR8MTsv8UI2A==
X-Proofpoint-GUID: A4QGcXDv2fdsVWGtgGjuxMlpFg5eqtng
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX/ELWubK2Hflv
 ZHnRom0Wnkq2AzS7UGXishkyfuZZ8jl/lPPFWhVvwfyZb4VypMBk+tpTwsbjMiV+GnIXZov47xA
 ZOhkrQJXppq1r3wXqjgWc8ZCGE4Y/fk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Now that all targets implement this interface, we can replace the
cpu_get_note_size() call with the new interface. We still pick the
first_cpu, which will have to be adapted when we introduce heterogeneous
emulation.

A target implementing get_dump_info is expected to implement
get_note_size as well, so we include this check before calling
get_dump_info.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 dump/dump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index a08a1eff3ea..05aabde5686 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1860,6 +1860,7 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     const DumpCPUOps *dump_ops =
         first_cpu ? CPU_GET_CLASS(first_cpu)->dump_ops : NULL;
     if (!dump_ops || !dump_ops->get_dump_info ||
+        !dump_ops->get_note_size ||
         dump_ops->get_dump_info(first_cpu, &s->dump_info,
                                 &s->guest_phys_blocks) < 0) {
         error_setg(errp,
@@ -1871,8 +1872,8 @@ static void dump_init(DumpState *s, int fd, bool has_format,
         s->dump_info.page_size = qemu_target_page_size();
     }
 
-    s->note_size = cpu_get_note_size(s->dump_info.d_class,
-                                     s->dump_info.d_machine, nr_cpus);
+    s->note_size = dump_ops->get_note_size(first_cpu, s->dump_info.d_class,
+                                           s->dump_info.d_machine, nr_cpus);
     assert(s->note_size >= 0);
 
     /*
-- 
2.43.0


