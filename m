Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6AACD98DA
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 17:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYSWb-0001aF-Vh; Sat, 13 Jun 2026 13:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wYSWa-0001a1-IM
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 13:52:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wYSWY-0001Pd-T0
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 13:52:04 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65DFAuKK3283491
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 17:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gZNeOce+dK0KUkcgQ5PeixCUOSWnH6ycUAlOAzLUVQ4=; b=YhSNFuuIe4WGHWUa
 6NcMP8PeVgTiTdrcWlk2frHViUn59WsDvcbFBLFbCP0BoiqcsXTibD6QoJd/rybr
 lmybUl2eceYoXK1doSe1UvVKZU0xPyf++UKSRuTrvPZ8kslcretujWkDgiIH7Gn+
 PnGfHmFzdK79brT/p+7vMtK0RQI9fm4eegJyTJDiKrMuVYWrw7LTA98oaIbxxGVX
 cp/zmNbVWv3t7G+e5oM6cvIjtFzvBzXjwRW8ekwY9CLryCa7PEeTsGAyPuQSYb9I
 Ptt8szG08p/M0sXzLjFlwwZfTgEJ6y+MvhW8dLW7aLc4f+GyllYVCdGOuMG4EdW+
 b8mmVA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery8wsp94-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 17:52:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-91931144870so41058385a.1
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781373121; x=1781977921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gZNeOce+dK0KUkcgQ5PeixCUOSWnH6ycUAlOAzLUVQ4=;
 b=AyOaEku+LSSJ3qgRKcwn81D+FXdkndJRma0ogXSo+Sbjixj9gFao3EwbGXIAaj8YAR
 pmO9oJegzVxwEcXZ1jHP+Y4k7unAcs2BqdWtG7GxjF8qJLHfJQbtIR/pE/TQVmrGOyug
 RiXphdt4LYk28EIJ5fmBcqXeGp6PIqphqc95GuR08p94Koex9VFpxZF3odrpgKn24zQR
 Yg3LDJxL7oOlUux1lB9iwOL/9srn5/J9RiPKdZEKYgy6sw8AlTl+X4eZPPLqmiNaxcKA
 dybkbvB02UvO2K8U7hI6FlreXjqJdov6PphuYuXXWyHYk81vjtL/6ndEQVYoGMaRxtGg
 1guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781373121; x=1781977921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gZNeOce+dK0KUkcgQ5PeixCUOSWnH6ycUAlOAzLUVQ4=;
 b=gtyrob9dQUHxL5lQjQT1TFu9IAs3aqPGFpNFWqFa3fumvFdCM1tTBTEI44zVl/ne1l
 Ny/EmhmAHo2+V8oGHuxmwDgaqT03V04/vFM5AbvTBCyXRsyLkm7CYR5HcNuvLitT2FAs
 N1qZ4KARKRvMjA3eOYwfO26IeDoQEn5HJohvyt2OeUYbfnli8z8KomHW4tED7V7EcBzs
 03zNilxYobDU0aC8sY7qHbwjg7579x7rNuNiNhXOn1blF8xWedhGnaSHjfFGaFKIkm0H
 mVrBBrB6GNgO4QhdtQ6vxYqNluu7XfsPKJlYUCD61qua+XXH2ypzxSRmfikPEVtJm4wQ
 RqKQ==
X-Gm-Message-State: AOJu0YxkIfk7VooDCpj7iaEQ2fcCy3N7lWCK+3JaXyuIS91vLPU1CQVm
 /BlMXnXYYHkxhYcy42EKoiO+xfddX6lvIhMywwSIvnvSs3j6iNbwhH6Su4tDv8j/T3UXeusi3HD
 BLkD3AdaU9qpRcQ1d+3+Mxf1Tpfdvw++uFIQS9TRP+17QYXrwpX+Jg7wp7vcpHyHcsQ==
X-Gm-Gg: Acq92OEMR6/hgmAVKk9oYyO2on5jLyhtwfzih3DpL5Lec7K7857ZCCsfN//xCycRbrT
 CdugbradSbh/XgWjnFdgyGyEE0DK9JhWifFfs7indCHqYIViT/oh0gWDUs4kpgZdwvkiaWi0l/O
 9zZjSWv31vdJQ3nG8kR45iInOI6cdTQys1XFTTVirEUSZe2Cd7k6UYwDDEpaSIwXd2Dx5D12xC4
 TXLTnCdkiWp4SqJuh3dYrNHEea1D9tPumkWlYUufDEWJ9aL4XibMgHTaP5uVYlgITmGQINLDDjx
 qygSX93i5hl+BrRtJ4WN0gt8LM7xbqosoKqbUMjavApZihnI0Rye+GCgc6/TwoonPWuV1IesQcd
 m7eL6z55IQaHBmjAkTxVfmKgpWksWG2RU1HQS9QQSnR5ghA97RpMaTzx6TVikjYd1Bryw0KJ/uF
 YzhjKbTxaZ
X-Received: by 2002:a05:620a:46a4:b0:915:5ce5:d3ce with SMTP id
 af79cd13be357-9161b94df24mr1173534985a.0.1781373121191; 
 Sat, 13 Jun 2026 10:52:01 -0700 (PDT)
X-Received: by 2002:a05:620a:46a4:b0:915:5ce5:d3ce with SMTP id
 af79cd13be357-9161b94df24mr1173532085a.0.1781373120808; 
 Sat, 13 Jun 2026 10:52:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2ce361sm16615053f8f.31.2026.06.13.10.51.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 13 Jun 2026 10:52:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 1/2] hw/xen/interface: Remove pre-C99 checks
Date: Sat, 13 Jun 2026 19:51:50 +0200
Message-ID: <20260613175151.1357-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260613175151.1357-1-philmd@oss.qualcomm.com>
References: <20260613175151.1357-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TWquQK97HF8rLafqcJku5dNKUCJJcJZ2
X-Proofpoint-GUID: TWquQK97HF8rLafqcJku5dNKUCJJcJZ2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDE4NiBTYWx0ZWRfXxebcKBUVZlLK
 fxMpEw+8Le/kiAMFSR0t/jLkYSnBKEHKzBxbzSwixs0G2jJwj4vGts4pzYoi0w0eTxr5E8VnAth
 r5F4D8PAUd4iHtujIOvblk+KsNgn598=
X-Authority-Analysis: v=2.4 cv=IqAutr/g c=1 sm=1 tr=0 ts=6a2d98c1 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=vkG9KRslzty0At4LJNIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDE4NiBTYWx0ZWRfX4Vo0koqq3njL
 BVN54OZJMnoBjjUQfiBb0zxB36UER6iOsGfbeawZP5vLy8shAp9CQ3xZfWSy7RU20KEZHKuLWMQ
 TrJQjgTIB9T078+BV3jEBvmDw1UkHV6XhN7YNIC9c9ZaKvExxpxR0dkO1PgfuhjIRNwquU/kkBl
 8uTOX212rjMqY/5UQTtu2ySEcSAZCmGHTveKKhKe0zhkoF5CFRatCGuUjBZ3MxZj0SpGYKl9704
 6sMrZnu40SCPYGlGTXgQg2SMm9PH6FqAv7eJYIYs5lN7bBQTEoqoja06gBH7UNscVV9d5lY2egX
 vvbFzjHqpU1fBzVg9/iKeYBYDPcJdonAdm8GHkMquKqhrqKjjLOlsajiWKLHYOxFJNoZZkWZs8Q
 PPT6vrp9f0ttXSZ1V3vF4Zts6rQS68T6qNY4mRvW9JalXX4oAbx5BC0Vn8ovXM1Qeypev4+P43F
 bYvBhUvSXNu2ksQTkFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606130186
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
thus supporting flexible array members. Remove what is now dead
code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/xen/interface/physdev.h    |  2 +-
 include/hw/xen/interface/version.h    |  5 ++---
 include/hw/xen/interface/xen-compat.h |  2 --
 include/hw/xen/interface/xen.h        | 14 --------------
 4 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/include/hw/xen/interface/physdev.h b/include/hw/xen/interface/physdev.h
index f0c0d4727c0..8da03b685ad 100644
--- a/include/hw/xen/interface/physdev.h
+++ b/include/hw/xen/interface/physdev.h
@@ -283,7 +283,7 @@ struct physdev_pci_device_add {
      * First element ([0]) is PXM domain associated with the device (if
      * XEN_PCI_DEV_PXM is set)
      */
-    uint32_t optarr[XEN_FLEX_ARRAY_DIM];
+    uint32_t optarr[0];
 };
 typedef struct physdev_pci_device_add physdev_pci_device_add_t;
 DEFINE_XEN_GUEST_HANDLE(physdev_pci_device_add_t);
diff --git a/include/hw/xen/interface/version.h b/include/hw/xen/interface/version.h
index 9c78b4f3b6a..41ff28c7ee5 100644
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
+        unsigned char   buf[0]; /* OUT: Variable length buffer with build_id. */
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


