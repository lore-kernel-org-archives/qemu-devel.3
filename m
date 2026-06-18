Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4EDCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBtA-0002Iu-Lc; Thu, 18 Jun 2026 08:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBt8-0002Df-Bp
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:30:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBt6-0000QU-RB
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:30:30 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAs4Hp1334240
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hBkxem0L7DWiKia5psfTtA2lXWcjA6cr5QosUow+Nfg=; b=om9Zg5nB3kjkTQ+r
 pJB3F17QScIzjwjPHgn27yTZaBNx4h83oaf8gb3zcGM8H0NMqeKriivXML0avtWl
 fJQ/8EdphIyw7RlkXaJHK3yz/kht7ta5oplepwDiTCSU3Dq4mwcyKYCyWnGUhr98
 r3uLyIBXn16RUBBUjUOX02+AGvNRNj245+NqPa5ZMXweH2Mg92637FbeICfuhLiE
 S4Bwpc1zWe7XmV236SJEFA21ZLEAwi3srueVpdkF2xHECL1F5dBavQejJtfRtiOt
 ee5a+8bNFD3gU+c+NP2rWUAvirVIT2Wrll8GoT/OdDB6MoR9+AAVX9/fOl8e2jZS
 i1lW2Q==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1wc340m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:30:27 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9661acbf65cso1144508241.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785827; x=1782390627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hBkxem0L7DWiKia5psfTtA2lXWcjA6cr5QosUow+Nfg=;
 b=OHg96NspNk8ZV0xmPorjsFPJRQd7r89UCiwFXS3MEyCjHfXNcQyvwn3qzHRkWIw8Z6
 MykQWR5TIcSCr0NYusLaTNGR9/XHk07yitqL7LJ8MW2iaet7zrw9sl9yhJxjhDp1gAph
 PApeikb1Ju2q62l92zYskQsFUGwTnpkKql/ayUkBqOgs+9pbePxGCwsD0Di+KSThAxuU
 hMkH6i4U1jrDtiULLxMcDfT2wmKUNiGh3EwTyhorBrxTXLK2LwLgTVXY0OFKb0VuB4Tg
 11WWshPgAI7mfrVYm7Ro/ZQ3FHw2W4Pj51dnHVcr+YSgtbpv4DQ4LNR32Vgh1mBDvLCW
 pZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785827; x=1782390627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hBkxem0L7DWiKia5psfTtA2lXWcjA6cr5QosUow+Nfg=;
 b=Ulyesp+9qGactJM/640/d/BZ3QbF4+BMrq/oe1x1Yg/nB6Dv7Hi5pis8udjQkVZm7e
 vO2jn92w73YQ2vCPv82aXHQpQmUIEXNUAImSgloO3tzBc1WlFYKEguvNQ72q+PVdOPZv
 0Q7jjojEijV/6GDEkdW1ejfrF98zCYgX5OjQYFLIZ3PslKsoadFL2Nyr+1nEv3MP2sIi
 gXmy5obd51Xtrx/VuUJbGIKwzHp3G0ztEflboxGLtVKelcrSZ/40izht70eR7bwE5UkN
 yeytS84CoGlFKljaNanZHTCT4yb/gkGJzKF+BtRF945k8B5vgPabeZkgfV30DAB7gXFs
 y04Q==
X-Gm-Message-State: AOJu0YzdJx4EgS+j/pB3d8vC3Ldcmuz4B4jYhmMsK838G07qcEP8fATh
 Hls9LHkBJnqhWkBAk3YjVbqFeuc65Kczr2au6cp1jWd0zqPY5eXERhUN+7ylYHU5g8d4DigVkpO
 l46I28tfXeJdFZi5m0j10MPWYyDDvwuTIa492O6cc8iFU95o2Ygc2VmMxLKgoRuqeKg==
X-Gm-Gg: AfdE7clPwYq6Xw0GaqU/5/XXZoXwwlQHgGr5Bj6A+IU+tU0iiUahKGUUDjnaZIcMbe/
 LEjO+of9fAEImZbbdvVPL5YBi3ocz/NfmPGdhwHMFfHxV0Grig3pxgPn1pwRTbNCACRAsNMuC1T
 YUSj6Jsslkm6eBtf9vaEPW9Svq9wMqRxEEvbAXzoOxLLFbP5/YMXIAVYk2WPknsDsYo5Eevq4tJ
 V5mPVBr3AQwABWG4eA0PvlYgI2HGY3eEZL78NiO754ZY+HZnHxRMvBXx18uVMj9c8oNB6FqA4Ol
 JBZfLXGS4j4Z8EjYa8asBVfBkmrc/vz+dQBCQeIHbIKOv3iqEVj4NAjk/AjxBZSbTfy4pJxM3g7
 Hm05SIyKXuDPMGjiqkPdh8EpkyD0A3c/Yt6/A15KqZcMsn94LPXeEdQioheLr8fP5x+tt
X-Received: by 2002:a05:6102:3f47:b0:6c6:432c:84d3 with SMTP id
 ada2fe7eead31-7245da9f2e8mr4816041137.12.1781785827165; 
 Thu, 18 Jun 2026 05:30:27 -0700 (PDT)
X-Received: by 2002:a05:620a:459f:b0:915:9125:e634 with SMTP id
 af79cd13be357-91dbcf0c94dmr1226135885a.42.1781785815672; 
 Thu, 18 Jun 2026 05:30:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm275387615e9.12.2026.06.18.05.30.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:30:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/48] qom/object: Remove pre-C11 check
Date: Thu, 18 Jun 2026 14:27:52 +0200
Message-ID: <20260618122825.90331-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TMt1jVla c=1 sm=1 tr=0 ts=6a33e4e3 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=_WKHBmQO-qgaVRkQabEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: E-rGbNIzJMfxaGvm7bbekntdWqm0MTtS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX3LSloWD7k95h
 hnquNMaBgyTB+lUivQWcEJan6e4zm+6pOpTVd7fAxMbcLj/Y3V5l6cZ0KNwUwLYjb+0hkQu4Tfo
 oI7oYNy81h0UevprHUnYURRG/MLeheo=
X-Proofpoint-ORIG-GUID: E-rGbNIzJMfxaGvm7bbekntdWqm0MTtS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX+8sfmC0qIKBj
 3jvR/dFU4hYtC9bzmKfb4hv/lwos+CkW9i8ygf7kGARn+gmSK/byV1NpLLzPuXbrscqijQcCDQx
 FdkpxxMgYKoUR7Ruewr7iwWYKDIb1JfxDVLIpLXDs/GRHZn2bYWJ5d2k5Cz358zMGepd7vOzlSc
 gK7efW0rzEU5dz269VYM2zdrdqtuAJervtZdNr7hLRr79Kstt0Q1neBPHWXHGHFvkTQdGpFBpRb
 m4quScHaBZ3NNfy5qtQei/kaZzXR8QEB45zsnHrhk7fcW0PkC3irXYbUmHWZjFQ/fN72jwg9Gb3
 ldQ1/MH+Ky7oGujVUDO48nkEMXpZms/9VTFRk69K8adhTcykrpxX665z1LnllSZAhPovI0Q4S//
 +eBfl+TltDI1mWvKICweuelTwPcMHWpWBIR7VJrVvD7B4uZw99opV8qG9mO/8aB6+NbQ6fLDeza
 3QwqvZBQLB9y3vYLzcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
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

We mandate a compiler supporting C11 since 2021-06-15 in
commit d22797ce36a ("configure: Use -std=gnu11"), thus the
max_align_t type definition exists. Remove what is now dead
code.

Note, C11 provides aligned_alloc(). Using it is left as a
future cleanup step.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260615091308.4458-3-philmd@oss.qualcomm.com>
---
 qom/object.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 0ac201de4c1..f79b2cf3618 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -675,18 +675,6 @@ static void object_finalize(void *data)
     }
 }
 
-/* Find the minimum alignment guaranteed by the system malloc. */
-#if __STDC_VERSION__ >= 201112L
-typedef max_align_t qemu_max_align_t;
-#else
-typedef union {
-    long l;
-    void *p;
-    double d;
-    long double ld;
-} qemu_max_align_t;
-#endif
-
 static Object *object_new_with_type(Type type)
 {
     Object *obj;
@@ -703,7 +691,7 @@ static Object *object_new_with_type(Type type)
      * Do not use qemu_memalign unless required.  Depending on the
      * implementation, extra alignment implies extra overhead.
      */
-    if (likely(align <= __alignof__(qemu_max_align_t))) {
+    if (likely(align <= __alignof__(max_align_t))) {
         obj = g_malloc(size);
         obj_free = g_free;
     } else {
-- 
2.53.0


