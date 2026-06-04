Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5109CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 00:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUvcj-0001ss-86; Wed, 03 Jun 2026 20:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wUvcf-0001qK-Gu
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 20:07:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wUvcc-0006YY-ET
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 20:07:45 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653GusRw3552126
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 00:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ydDfqW3HQgM
 m0aCoNggM+YWoFrc02YxYTfBAg6WQgd8=; b=d4KXUSdicZ/SlPvS2joMb3E6W39
 +e6rczSV7+Lt/U/Tbn9NTg52tvhTJfU5eJ5/CpDjgK43zgPCti8amFIgXAuuaM8t
 +69H1bbzBkb8NL9Z/mP0odMFmNQMw/hjmAhrKRZ7PK17wDxHQqYTvOTmLGSwfX8E
 ffdYcxrnZUlLv3FfXZ3mYjYTlTDfgfeRU1EtXFl9Hhk3B41NmWAMCTIiEmbMpQhg
 0+Ct8bPArF4V2nliTeLHj6oSrF/IVnfZIBxJEfiagrhj/RE+Dr6kEyuhp4W800gI
 Zq6d11AqmSAS5PiT/eH4I7dmwAx/2viqslW1+VWD/WhyiFBH+ACQ2xQzO9Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejj9mu89n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 00:07:40 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so86901eec.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 17:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780531660; x=1781136460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydDfqW3HQgMm0aCoNggM+YWoFrc02YxYTfBAg6WQgd8=;
 b=MJffcBvmXKfsrJ3oEpmvbQCaQAZSDIwT5zCh3p9Agggo1Idpnpf+1v5pHtpWrhtOPI
 Ab/VVRf8zZCSQN51oCsUTiGgjUg1ZKoNlufsZHFm6yfX04Q7kR4sfgf2J7c085w9C7Bn
 cdUpe12hM4PIkQy4Sv7CzL1YiGmYg6iM87GCLN28ulmUOk3Hy6t/QD+v7/s9tPhpjUA0
 brePoNdy8/WbWTi1a4HKTM43WENzZ4iHAJQEzUXfqrR9B117aNEkL441bxzOWtZ/LcZi
 oZYV16CEKKnSbEJr2FpVWtUhJ6VNibIaqSCYU45AAIvOlpI/WilL+c+GmS5346Qa/YPF
 EQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780531660; x=1781136460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ydDfqW3HQgMm0aCoNggM+YWoFrc02YxYTfBAg6WQgd8=;
 b=QrL4dLhuAQJh/n1FLd7D5gQfbxKSOV9GCW3/UnQWuJXcbgW3ZuxcDKhn2b0COuduJu
 a0JW3cH9agjsKmntNQeNR38c+m4vvx4/QSAgPHLh2GWQEFVJ83x8XBMpohf0XHSdHxLt
 rycahyMUVW3JFV39LdQbG+kBINnGuzsyvWoALjxXpPMzuzsEb+W/NYeqHszuf49xXIfQ
 YrBozjY81S8N6FvOvOLth8DFaIIr27oV4Nh5ja+gcBOdWokJnj71mtO5jLc4QjrYpBYs
 CH6MFdM4buWCQ/P83jOoXLAXJgoz6cKb02h2u5gzk3UDnvW/4K6MMeKJ9wWtnhcwLx2I
 9fgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9D4mJpkoBoYmpMbpfoOuRjaqgpDv/fZh33bhRHKIBxjx8EFONCVAUhy5gam41THIyA8PNlRJL1w2kh@nongnu.org
X-Gm-Message-State: AOJu0YzLqIK0DBtnWUsuos7+Vo0amDvgQEC6uq3EisY9ucB1q75AIZh8
 3+nG/yG4/v/DTW5Xkb+PB4UWG+Iwf5gywlxWE0ezQS9wy/eSX5l96+aDl3ijOCAiVp7NfJqVTwj
 j/taCsUSP2CCuN+mRLt3lhj4uWHbt9qKCGH038trBnIkoEYgJAb3n6C/obg==
X-Gm-Gg: Acq92OEhZAX63c7iN/7LptlHfF6Gp2HA1Z4C6eionNPtPccSYe8mBc3XXsk8AlXsF+R
 jVqjiESfq5TtvpMqEjeG4u0VW0J3YaRvIRlUoXQdxMonJQVd1iyKm60/z+qCPIrC8MUbN7F+8ZD
 mQluImgjHyyIxFFfYY8w79oYpxJJhZoEQK00Ll4Vw07y0V3uR3j33cGjf4tfOan6B1AMacbb//n
 7Hbv1nX8SInL5y6k1PDGUhsZd/C3SP28mFW2E+0LzVLHhD2gj/DPAzaq6VPZTupfdtIdAoKX3WB
 ezUmNCjSpCETCE4dBijzUvTyyQrOIhSsolgsVltLtZhoeE6NAZpN8tCD5xkxEP4ZHL1xRnIG+ZG
 OspHhj13itLXItSP4doiWnRRsJaeWlDLaTyOMx2Cc0yf7uEvmf3j7fkKmvx9eWl5vhd+v8oEbFG
 yO89ISnAIZF/M=
X-Received: by 2002:a05:7300:8182:b0:2ea:cd38:f921 with SMTP id
 5a478bee46e88-3074fbc75dbmr2928064eec.26.1780531660077; 
 Wed, 03 Jun 2026 17:07:40 -0700 (PDT)
X-Received: by 2002:a05:7300:8182:b0:2ea:cd38:f921 with SMTP id
 5a478bee46e88-3074fbc75dbmr2928049eec.26.1780531659547; 
 Wed, 03 Jun 2026 17:07:39 -0700 (PDT)
Received: from hu-jithjose-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074dfa3a2asm5374960eec.31.2026.06.03.17.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 17:07:38 -0700 (PDT)
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
To: clg@kaod.org, jamin_lin@aspeedtech.com, komlodi@google.com
Cc: nabihestefan@google.com, philmd@linaro.org, jithu.joseph@oss.qualcomm.com, 
 qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] hw/i3c: keep _bytes aliases for renamed queue-capacity
 properties
Date: Wed,  3 Jun 2026 17:07:34 -0700
Message-ID: <20260604000734.1094382-4-jithu.joseph@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604000734.1094382-1-jithu.joseph@oss.qualcomm.com>
References: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
 <20260604000734.1094382-1-jithu.joseph@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YiEfzeZd7B-F-2P-ePl0xY9iwBivCR91
X-Authority-Analysis: v=2.4 cv=XK0AjwhE c=1 sm=1 tr=0 ts=6a20c1cc cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=gueeoCY6Jtxq1gdPNooA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIzNSBTYWx0ZWRfXy2rxd8F5YGgF
 QR3CRQAt4bu5M9dfS92SGIhZR+qqEyQ05o2Fr6mSyV6/gnFlpcGmt53d2prS487zE1Mni0Xpje9
 jw96IgWIgez6bOUxF08t5nam10pcX2cKZIL+POvVVVmZQmHQLYaS0EvKeQJFLCl3VI7Pcsogd2D
 lwdjdLPdroNNMKLuSOlG1biwBJDI8OrdosKonr3QNbkrk9w8pZHCkZ03cQAeH6Sv96wza0G97aL
 QJDEQXevRnG7H1P4O73VmpZzA12dRYSbwa8KjB0ZYr+29EWjzvsLFzpJnoayN//aCrELf61cKXp
 k9lXUAdyi3iM4yXj6mL/sOVQKzsWjXqmZpvRYCYJFXAvqQ2+m76C1s9d0/0lIVkVH0xDYM6HssI
 89bjlzmPFG8+IVCyMoyJ0F0IRQQxLy4akRbUpiv+6D7xLNOVrkqxPuFCjMkdxRw8lA3sObAapZE
 nPWnpD/tMNX8vo0xAYw==
X-Proofpoint-ORIG-GUID: YiEfzeZd7B-F-2P-ePl0xY9iwBivCR91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030235
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

The command-response/tx-rx/ibi queue-capacity properties were renamed
from "-bytes" to "-words".  The "-bytes" names are user-visible and
shipped in v11.0.0 (reachable via e.g.
-global driver=dw.i3c,property=tx-rx-queue-capacity-bytes,...), so
register them as aliases of the new names to keep existing command
lines working.

object_property_add_alias() forwards both reads and writes to the
target property, so the old names behave exactly as before; introspection
and qom-get/qom-set continue to work under either name.

Signed-off-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
---
 hw/i3c/dw-i3c.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 0d32d9ce78a0..6386499dd9fc 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -1830,6 +1830,27 @@ static void dw_i3c_realize(DeviceState *dev, Error **errp)
     bc->ibi_finish = dw_i3c_ibi_finish;
 }
 
+/*
+ * The *-queue-capacity-bytes properties shipped in v11.0.0 under names that
+ * implied a byte count, but the values are 32-bit word counts (they are passed
+ * straight to fifo32_create()).  They were renamed to *-queue-capacity-words;
+ * keep the old names working as aliases so existing command lines using e.g.
+ * -global driver=dw.i3c,property=tx-rx-queue-capacity-bytes,... don't break.
+ */
+static void dw_i3c_init(Object *obj)
+{
+    static const char *const alias[][2] = {
+        { "command-response-queue-capacity-bytes",
+          "command-response-queue-capacity-words" },
+        { "tx-rx-queue-capacity-bytes", "tx-rx-queue-capacity-words" },
+        { "ibi-queue-capacity-bytes", "ibi-queue-capacity-words" },
+    };
+
+    for (int i = 0; i < ARRAY_SIZE(alias); i++) {
+        object_property_add_alias(obj, alias[i][0], obj, alias[i][1]);
+    }
+}
+
 static const Property dw_i3c_properties[] = {
     DEFINE_PROP_UINT8("device-id", DWI3C, cfg.id, 0),
     DEFINE_PROP_UINT8("command-response-queue-capacity-words", DWI3C,
@@ -1868,6 +1889,7 @@ static const TypeInfo dw_i3c_types[] = {
         .name = TYPE_DW_I3C,
         .parent = TYPE_SYS_BUS_DEVICE,
         .instance_size = sizeof(DWI3C),
+        .instance_init = dw_i3c_init,
         .class_init = dw_i3c_class_init,
     },
 };
-- 
2.43.0


