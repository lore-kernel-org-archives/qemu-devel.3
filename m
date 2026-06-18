Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EADCD98F3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBst-0001qs-G6; Thu, 18 Jun 2026 08:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBsq-0001m3-S1
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:30:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBso-0000Bf-SK
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:30:12 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArtiL1536470
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4BN6IjOidG3W0LGKwFbttIsGvRt1fzfLI/MYhDLt73Y=; b=Xtve2SBXuON9mf2D
 O4PONr2ID2sVRi95OpboP+xN6C9Uep6dsa1HVQNAl9sKVaTW60MRwWdhzDl8R1eq
 d7XF7GQocr/Pk2GRU5fQBYqrO3LFL9LTMJZ2/IQ/M389+Q6o+s36Ln22LpqnLMsm
 Qf7yzIGAOaAg3kDjz50X4Bh2huqCKkGcGA374EppgDTFWgwx/nRbhQIbRG+zKV/s
 zGbC4rVLRUNpxdf208AFyEvR5W2HKuLdc4otzGdVy6uxvSRReBnpfHraHdqn3tmB
 /0C5TR9BMKYvL0TFuRkY7h0xj4SjwDsfWfrINx9fBxfhLiAyHLrej4pl8h6AZo8X
 Y5WnmQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev12kkcun-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:30:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91574ad6871so179945985a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785809; x=1782390609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4BN6IjOidG3W0LGKwFbttIsGvRt1fzfLI/MYhDLt73Y=;
 b=aA3FurYGfyDVqK42ranVQp6fE9DQAVYBZPbb7LJRpEDGqXWfsc2j2bQBLS9DZ3B+Ur
 Epp4X7jsTqn9s2kT1f6OwfL1OoT5NKHukNCfR9Lsj9mp83z+MwAl6oE17RU94TLOlZo5
 Vgc3t+m8/0K+SaM1GvMibCGM35HwlXqch7+pn31MbqnomNSbs8A4naj7+wUuCHEfZupm
 5zonQ7zigar7pgvwqx3aQWEggq92NTIAluqJZkvbg2BKCj6uLZHk/3YoqTZIj4Gl2coX
 1ipuDd1vwgxVcr5xnb1gZmqwHpmmAhy9536j8HhO4d+L4pHrigAaw6VLkQi2/G3gmZoQ
 aMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785809; x=1782390609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4BN6IjOidG3W0LGKwFbttIsGvRt1fzfLI/MYhDLt73Y=;
 b=PWCC4i/Qq/3YCFFARHSOWU1n3LQRs8Z6w0NGum8UAoQ+COfwgF0axtV5Kba8w0W/Fz
 n0i+aKN0D0zkdtk49itWDQsdsVb9NTy2tPm13WVVZ9DrsD5l7hmwVUH2ufxtZ6w/hPs4
 97DqbrtrCTqbtsA2wl8WNxXQHaVfio1h2dBTG4hRjP/ttXlSMKsBIpP1PDrzwAknBDp2
 po6Y6KkwL9ewrkjhSCAdg5Rc1pm9pTstKBsDeEfuZJUjl+gpig2UFLu9Hbxq7AaGKcXR
 6OlQxTZmq0HBsNmMnqbXXGzsaQbQUhnQ0RljnOclgagE2OWZE4/qn8YWXIDD6vNqXEK9
 USfQ==
X-Gm-Message-State: AOJu0YzvU8kMxzHsOIXcWomtkM5ocNkSIKNfeQTni1HtLW3am5U28qm+
 lZMX6m+cxSlQSTQUU6ISDRJRWFW78SyEzRADMy0FzJlrvGyH1sbkSDAs3mT3B8kGzHb5VqW8asa
 fZ6a8fST0TCG+VZreZdcD9QXLYt+9f1hvvDQuZRo2NY/z4m85vp//2f1T5MuTZcIsJg==
X-Gm-Gg: AfdE7cmy061rDrIznt0uRG0S6fFaESir4YnYCIK0iNyvW6yi1C0GeaUBW/CX0R0fc2T
 qpcQfJj0CO6a2hWlO07RAzkPi44MENx0EHLI7ZAVvwYjLVyajvtTsWup6adsowfhzVL7d9JmBf5
 1uhjDDbqfMrfAbACu+dXC/lN38ZuguYmpPsIuiaJgwzM7lqi4+wXKvmcrQrJZD/fvlcmIWCF7H+
 rauDidxYCWrpZPWgDpKrlxxSQuMlep6eIa0ehWNAaydY0ACSi0EXGhDIhfKXEb2wJ/Ud0nUi58H
 TjIYcXgf6okwUSOJtHtL64ahPbyNWUnYGPSqJvJvYwagTsZlHZ0ognFBQbL0EhJiGQGcLJe21/h
 Gk61aQv94h4seSss+i8Ey+pfh2m5sbKlb9Qbxl8dRb1radtTD9/eM2+5lTLQ6yfgV6Kb+
X-Received: by 2002:a05:620a:d95:b0:918:42b4:2c92 with SMTP id
 af79cd13be357-91d8dab24a7mr1348508585a.41.1781785809069; 
 Thu, 18 Jun 2026 05:30:09 -0700 (PDT)
X-Received: by 2002:a05:620a:d95:b0:918:42b4:2c92 with SMTP id
 af79cd13be357-91d8dab24a7mr1348499685a.41.1781785808517; 
 Thu, 18 Jun 2026 05:30:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d4fsm67816584f8f.24.2026.06.18.05.30.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:30:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/48] hw/xen/interface: Remove pre-C99 checks
Date: Thu, 18 Jun 2026 14:27:51 +0200
Message-ID: <20260618122825.90331-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX6CQ2kF01NBC9
 1WbDyo3NHS4Skvd3c/e+GgICKO7B7jUjUxESZEW9Qu2CULWnbhlQX5IRZSliuzuh+tmM1ZYQVOt
 y+PrRJSo6BmZVXBtzj6Omg9I36VkmXwAODn37HybxsBrq0J6ic22Kdtn5g/arNHGQRMTKri/xSC
 y4TsYYwU+9/JhH4cLgjvhkuvtwMOxRvA52eFEDg2K0R2/a3T7aIk2oHHC3kJ1MCnkjKymqbe0JB
 DG/5ZmKc/LDwP5FredR8h0xnfCk1UsHOB7u2pJdyC+8M8G9akYnnttwGUUWdCDGg0dAI2TLnLb0
 tZrJl/CzMSZ7D1V/k55DD6nJ8vb1PxyzejHryw2W1cEV2JTZONbAADyzT7tH2MSsPYY12b2l+oy
 XwwhArY3W8RMpx8rXdwW4PBf0aqH5fbe593p0jts/QnEHkxkd82ziW8OPQ7e2zScf+38F7qnyJs
 1gdISsitqZkw9CbjdvQ==
X-Proofpoint-GUID: BS_eQKWyrDHrbxBwYk84vbHaVSKsfDrd
X-Authority-Analysis: v=2.4 cv=HpVG3UTS c=1 sm=1 tr=0 ts=6a33e4d1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=vkG9KRslzty0At4LJNIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: BS_eQKWyrDHrbxBwYk84vbHaVSKsfDrd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXzIMeyaMtLoy8
 tF8RN9l9njyX+bxUsf2WcRxTwlbqhC9HxbL8q9QqQ1ZWxZrnIM216KFgFSpU6RsMlnpTrAYkh4J
 BCk1QBEx7e3W7VH3X5g/WMcdBq8I5Wo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
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

We mandate a compiler supporting C99 since 2019-01-17 in
commit 7be41675f7c ("configure: Force the C standard to gnu99"),
thus supporting flexible array members [*]. Remove what is now
dead code.

[*] https://www.gnu.org/software/c-intro-and-ref/manual/html_node/Flexible-Array-Fields.html
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260615091308.4458-2-philmd@oss.qualcomm.com>
---
 include/hw/xen/interface/physdev.h    |  2 +-
 include/hw/xen/interface/version.h    |  5 ++---
 include/hw/xen/interface/xen-compat.h |  2 --
 include/hw/xen/interface/xen.h        | 14 --------------
 4 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/include/hw/xen/interface/physdev.h b/include/hw/xen/interface/physdev.h
index f0c0d4727c0..ca2bcbfd159 100644
--- a/include/hw/xen/interface/physdev.h
+++ b/include/hw/xen/interface/physdev.h
@@ -283,7 +283,7 @@ struct physdev_pci_device_add {
      * First element ([0]) is PXM domain associated with the device (if
      * XEN_PCI_DEV_PXM is set)
      */
-    uint32_t optarr[XEN_FLEX_ARRAY_DIM];
+    uint32_t optarr[];
 };
 typedef struct physdev_pci_device_add physdev_pci_device_add_t;
 DEFINE_XEN_GUEST_HANDLE(physdev_pci_device_add_t);
diff --git a/include/hw/xen/interface/version.h b/include/hw/xen/interface/version.h
index 9c78b4f3b6a..2f183c3efd4 100644
--- a/include/hw/xen/interface/version.h
+++ b/include/hw/xen/interface/version.h
@@ -77,9 +77,8 @@ typedef char xen_commandline_t[1024];
  */
 #define XENVER_build_id 10
 struct xen_build_id {
-        uint32_t        len; /* IN: size of buf[]. */
-        unsigned char   buf[XEN_FLEX_ARRAY_DIM];
-                             /* OUT: Variable length buffer with build_id. */
+        uint32_t        len;    /* IN: size of buf[]. */
+        unsigned char   buf[];  /* OUT: Variable length buffer with build_id. */
 };
 typedef struct xen_build_id xen_build_id_t;
 
diff --git a/include/hw/xen/interface/xen-compat.h b/include/hw/xen/interface/xen-compat.h
index 97fe6984989..582c0182367 100644
--- a/include/hw/xen/interface/xen-compat.h
+++ b/include/hw/xen/interface/xen-compat.h
@@ -24,6 +24,4 @@
 #error "These header files do not support the requested interface version."
 #endif
 
-#define COMPAT_FLEX_ARRAY_DIM XEN_FLEX_ARRAY_DIM
-
 #endif /* __XEN_PUBLIC_XEN_COMPAT_H__ */
diff --git a/include/hw/xen/interface/xen.h b/include/hw/xen/interface/xen.h
index 920567e0062..a6f4aa61993 100644
--- a/include/hw/xen/interface/xen.h
+++ b/include/hw/xen/interface/xen.h
@@ -36,15 +36,6 @@ DEFINE_XEN_GUEST_HANDLE(uint64_t);
 DEFINE_XEN_GUEST_HANDLE(xen_pfn_t);
 DEFINE_XEN_GUEST_HANDLE(xen_ulong_t);
 
-/* Define a variable length array (depends on compiler). */
-#if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
-#define XEN_FLEX_ARRAY_DIM
-#elif defined(__GNUC__)
-#define XEN_FLEX_ARRAY_DIM  0
-#else
-#define XEN_FLEX_ARRAY_DIM  1 /* variable size */
-#endif
-
 /* Turn a plain number into a C unsigned (long (long)) constant. */
 #define __xen_mk_uint(x)  x ## U
 #define __xen_mk_ulong(x) x ## UL
@@ -986,13 +977,8 @@ typedef struct {
       ((d) >>  8) & 0xFF, ((d) >>  0) & 0xFF,                           \
                 e1, e2, e3, e4, e5, e6}}
 
-#if defined(__STDC_VERSION__) ? __STDC_VERSION__ >= 199901L : defined(__GNUC__)
 #define XEN_DEFINE_UUID(a, b, c, d, e1, e2, e3, e4, e5, e6)             \
     ((xen_uuid_t)XEN_DEFINE_UUID_(a, b, c, d, e1, e2, e3, e4, e5, e6))
-#else
-#define XEN_DEFINE_UUID(a, b, c, d, e1, e2, e3, e4, e5, e6)             \
-    XEN_DEFINE_UUID_(a, b, c, d, e1, e2, e3, e4, e5, e6)
-#endif /* __STDC_VERSION__ / __GNUC__ */
 
 #endif /* !__ASSEMBLY__ */
 
-- 
2.53.0


