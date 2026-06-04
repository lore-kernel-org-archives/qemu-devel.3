Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE002CD6E78
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 14:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV8xo-000762-D9; Thu, 04 Jun 2026 10:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wV8xe-00074H-Fx
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 10:22:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1wV8xc-0005Ri-IA
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 10:22:18 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6548c7XT598270
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 14:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LdDLyB+vHFv
 xt62M17Q3Ldx+UeIjawb95Nhxjty98s0=; b=Gxq9k3QKHx/b+9Xzko4aYWygRuo
 OHbCK9h3MxtrP/ui0vLfdCJDZvkwL4X3+WveExnatDjsJtdlQstbvQpdwF9t7PKT
 dYjKPze3w3zufQQH4EIiGrSQYag+x4SGk1sofYqbhW33P/WK4vAkzotMYlWF/QId
 AWvZaexYJvmkFSB0ump60EnOPuqZEU3aB4/nsrkwtFmXAp0//7sLBt1TNBe5wivG
 deB66DjrXtrueU1dq9DixFfNLmKES6w+RrcQOrn9uOGujWXxhQWklpD1IlhjHxtq
 21vnoqobnLX4ElT7bngfuMS/28DBmc3HDTMk9XI7IWSaJUoFrSoBlkhkkqw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejy8m2t6b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 14:22:14 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304ea42b025so341137eec.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 07:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780582934; x=1781187734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LdDLyB+vHFvxt62M17Q3Ldx+UeIjawb95Nhxjty98s0=;
 b=hKlMWKlQhh2sJLvuPasNIzDKVZ5x4OwVZB/QwrkrOgQAiOiL2E04CTcDPmHLfNQm0s
 WQyiwSzGjotRXHT/AYD2ZvyKAX5Sjlj69u3qkOzr0GQqVfjQGx+pQqaz8NLVHnkGtsb4
 7va0X7cW4bLieGNvGRv+6PSnyorZ0Py2cs2lhwxAPAzLWM/mwRfZWplcF+6gylZotXRO
 U57Bhis0E4GszfI1EJZoQ8+nWUjfsNrpOg1OxVlFsHE7XmWHiyUfb0YuPZTf0OyHVHOY
 9Sa9gBbmkHYodA/7gdew5mAtftUdSTor6uHsQOyW+qeDPyh75rXJPnNrF8R4DAU3tm70
 J6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780582934; x=1781187734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LdDLyB+vHFvxt62M17Q3Ldx+UeIjawb95Nhxjty98s0=;
 b=n8VcYA801TT8q7O9ltlSCbPdEaVCUVwU3npKjCbFvxcaFGw4B6+7yJJb7LviC1+BIJ
 +CAPWWozKKzKrY+qDq7kM5J3VTKoa6JIHiWH1HczcAPUgINEvKTCvT7dK5cMrgTfPXRg
 SV+xz/nXIf4+RIhblg6GL7n8l8/K+gYo8mv+jvOXIx9cFj4Tuq9AoD6VH7iHs2MXRxs3
 iSQtI/w7OmlJKf77eGQCbA5x9+Iwixr4FumlMnevrc0S4yvQpqw+brOyRlEUt1QznsVd
 dSFwxmt3WXWY++wZONqqZFi/Chil0bsU9sCoS+k3oDMnERwP5mW4nTKWgzjLxxsI3MMt
 yQYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SbVbuQTbsmB09gE12PLB/UINViNxHq7QzQ6ccHkUg8VUN7mXpp+mXe1qZh7pf+6HaVG8CZGmJfBnx@nongnu.org
X-Gm-Message-State: AOJu0YzSHAsumdI9hwbUTZn70EnsXFau2h8fPgrtZw9jkaYJUE3QSbGk
 KFqxPKAhQIs/BYFBnkF3Pce8piYIzHoehrmEzAqJNmNZfrdw7JtwmXPTOB+S3+Vltj1cKELEKeP
 jKAsnx6E0ItABwqPqxhYqBsTq9zdaPq5w4mnei+MpAkLua2kr5nigGVSzvw==
X-Gm-Gg: Acq92OFILoxFMRnQNa76UNlMalj3h13X22zifQARtszmQkFQDWdCliCubxOEKttD53s
 6UNTKXpZJ6f8Xveebb8VmzzgwiDH07qZvYPeUe3mZh5Nml9GCjMLi8gNXtfW7/UTsynJzVJ4fRn
 vtvRf/XbF6Q8ZWLZ1d3OQPNBDCmbZZOILeWyAUPfhVcnOMQ7hj/ieKwitYcmM3ESB0j8tM4pPP7
 BT9GFbGv2bNfgJ7pUE5IECp658sJWYa3r3IU004mx+tttEbKQ2iTfaQkXH6fJ2exKS7DISoSOId
 wZDLYcISlGBz67+rL/R5I7MmrHCNrWy0XYIQXkEgSG9mijbrIvW3FykyumCl/qaRX90Rnb/jQxT
 2TuZMUvJJgr75OwsrUuGC+k+5YCtZMuqnSytqjAftRVwPh9w2pjE5sGNNPHKENR1Vnei7VAlxhc
 uXJ2yPP7PulOA=
X-Received: by 2002:a05:7300:724b:b0:304:ad0:e91 with SMTP id
 5a478bee46e88-30761eaa50emr2012142eec.4.1780582933788; 
 Thu, 04 Jun 2026 07:22:13 -0700 (PDT)
X-Received: by 2002:a05:7300:724b:b0:304:ad0:e91 with SMTP id
 5a478bee46e88-30761eaa50emr2012114eec.4.1780582933060; 
 Thu, 04 Jun 2026 07:22:13 -0700 (PDT)
Received: from hu-jithjose-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db528dcsm6179560eec.3.2026.06.04.07.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 07:22:12 -0700 (PDT)
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
To: clg@kaod.org, jamin_lin@aspeedtech.com, komlodi@google.com
Cc: nabihestefan@google.com, philmd@mailo.com, jithu.joseph@oss.qualcomm.com, 
 qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] hw/i3c: keep _bytes aliases for renamed queue-capacity
 properties
Date: Thu,  4 Jun 2026 07:22:06 -0700
Message-ID: <20260604142207.2118098-4-jithu.joseph@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604142207.2118098-1-jithu.joseph@oss.qualcomm.com>
References: <20260604142207.2118098-1-jithu.joseph@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a218a16 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=V2NxCb60AAAA:8 a=gueeoCY6Jtxq1gdPNooA:9 a=bBxd6f-gb0O0v-kibOvt:22
 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE0MCBTYWx0ZWRfXz0XFl57ZuikA
 TDJ0BQovQEwme0zA6SSjEVqqBVq1SgKmV5p16hS8ZZEICDcbxwR3P0nGvGSWmqMtCEYIgDFJej+
 42q+O+d/X9KEW4TKlNrZbBBC1b2GloSSEORQVa2DEQfo/KxnMTC7t9hymPC33exv6gyl2cSGQNg
 Bph4zWXXJi74h/P0Qyd/SKGQ7oG97ejY+NRyOCckRrkxtXvURkmQ0jxtOfJCjbCuiALx0z76CXr
 H0L2Tngoc9cAKIQ0ZelERGo84KKX31IUFSfH650SWNMkBv2fmGYrDJ9fit/OsffJM/i0KSlYJhV
 AY6VbU1NNu2jLS5JRfDxL58jBFW5zIGYNGcwG9Bvrpu+w8OqMqx+oXJ366dx5vxztH8j2Bj2Yl4
 3hnBvgfZSIGptgUnrnpaBuzDX//yWOrmm+RY3feBufxBojnlQclyfsFUZ9j4h8a5fl1M/yDCv8K
 YqiezAN/ZtklTAWWxlw==
X-Proofpoint-GUID: 6miUBAXQtZWuNjkTvofycbsx7LPd72u0
X-Proofpoint-ORIG-GUID: 6miUBAXQtZWuNjkTvofycbsx7LPd72u0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040140
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
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
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


