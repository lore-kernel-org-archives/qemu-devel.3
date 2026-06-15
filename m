Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9D2CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 09:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ3Nr-0001qd-N4; Mon, 15 Jun 2026 05:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ3Nk-0001pR-T0
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 05:13:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZ3Ni-0000Ht-9Y
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 05:13:24 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6J0qj3344569
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 09:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4s/yUxjPNLve+3gfnP5xoK2AqyLlEffP2tRAyASu6G4=; b=lkBL6qSoRD/Z6Vb4
 UmY4e5QEW9jJL+nu+BvFJtg72MuG8gYgYmcS0A8Wy8rFkgb6Tk+RRmckjLoaLSUu
 tCYR20xqsqqVjKgDKD/5Fj93ZZLX8Pu4QcZO8gSnWGJZO+ULLRxQHaEp1erwxv9U
 q/79nezxMqieHoa0x8lsANj0hvUVE7M5hiKoYeQI3mKifJysURPq12kOfp6gCCw9
 LuAMLHfiaNGTa9t8FStG+GJxrJkuVJWvkkcFQLIcOSqusxg3gmVwM/SfPr3iJ6aZ
 w9lLfENNC5yufpuatA4xh0r9pJ1zRoyg+OPsR/dZ2rcah5giWf1IXBen5mCfoP3x
 hMOXOQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery9fekwu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 09:13:19 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ccd77414afso40493576d6.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 02:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781514798; x=1782119598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4s/yUxjPNLve+3gfnP5xoK2AqyLlEffP2tRAyASu6G4=;
 b=d9zf2S06nMxiWWPw+T80iI/mSwyzIis8iY0hfVMmDo7vXcqec/inAid3uuWYJONjLy
 ShamDfNwZsii05KNoG9ygpEBvREkmgyqBdaEYVRIl35cyDp+Yr3zvIuPUx0FEp46DSSk
 m6TUGtv/IS7R4WxjRyNCAbL15q2OhTzsT3mY50d/Cd0Eoa+BXbI4SB2ePv2MRPexPf+/
 ZrhgX8jD/laxDvud4+iNaTxBBtYKNtrNyT/EfZnG2SRTZbsmjT1pct40Kv7StNUAzuUO
 CVVsc+EDAc3ZhMa+EzEFozbT+XCd57S5NjtxL2u/4SNCKRAW8KYWiwPZXUBj2O1IjFhJ
 bE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781514798; x=1782119598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4s/yUxjPNLve+3gfnP5xoK2AqyLlEffP2tRAyASu6G4=;
 b=k2x5uxBRSGh4E4i8/GRmCm9y6NlFtltPF6O8wk3Yi2Sv5+6g+KauuzqEP1I7JJIghd
 O21XpWb1TQPVeimmQXIvxYTGrC5s1WVP09TKEauY2ZpvIsegF1TOqSGHnFZth1d7+TDK
 v6ylopW5UCMLlQjbLVki8ZkoqSkQ78QEIgBass+rjK6Ju7KeZVbR3iZydCjIEoF5xLuI
 x3AuKqwdu7AwyA34c+gt1/jYipExDaaoL4/ErGSgbnyLzJTC3a6fYtNNZjT9G0IVMf/6
 vzt5a/ZfPLS2Xxv4O6Ef8KRgkYmZs2cNFV3QlEikR7fXRCC+YpjAwpGpQyTVukKJwza9
 8FpA==
X-Gm-Message-State: AOJu0YxjXW9F4sYpCjffdng+jVHUspff+/Ofid+mLUEslIbCIzpmt5hz
 bjIOhfEspjAnEHVEOouFThlnSnTX0D+v6FJ+tEvBNSu3qmBBHOeNLOltSumAYV8k8/VD50ty/Nd
 ukNEtdWONC+zxnJUzrCCNdDa1fFfwMCb10VuSNGaDosVlVcl+J7Uz8UxiRxYbkPcncQ==
X-Gm-Gg: Acq92OEy8SsbIj5X1Vf6ZdlPmSJwnG/13LKi7tXcVoQRzgaN3r+fx8vl/tKFt5JJROt
 0kK1S0CKRFRJ4zGfFy/jhbUQHRTkjq/JI+c7/jm7LPC3BHwwwJSYLg8K6FpNT39X5b7TUCkPHcM
 XgYMBLnZ9NfnJ3KhuWS7zzB+XKcUOzQZbVHhDmaVWfAmBbWPqIXpFIP7J6BcWk/U5tzXoIV+mYv
 KOEDen8pSLZ04v5k4lNQHNKh4hnWUyQfNo9WhOAOAPOdMhKi90tqibJwTy03wjCFwjUHt5EqhsU
 +Jl8uSvLg9R7dGhg9YJdcSIY1rTwFvwcCb9b8N0mf0EycIIu3wnePJF138iQeQQ3SlT1zKqrBhU
 tnwt+qRin3VT86obDeUWd/jHpCD5RkovJ7MK2B4ZzqN+cBCJa0wuawRXoP5QGBStFIU5xkSI3gy
 O2L+w=
X-Received: by 2002:a05:620a:3198:b0:90e:2f56:2f0b with SMTP id
 af79cd13be357-9161bac7a1bmr2185348185a.7.1781514798480; 
 Mon, 15 Jun 2026 02:13:18 -0700 (PDT)
X-Received: by 2002:a05:620a:3198:b0:90e:2f56:2f0b with SMTP id
 af79cd13be357-9161bac7a1bmr2185343885a.7.1781514797978; 
 Mon, 15 Jun 2026 02:13:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm31131680f8f.34.2026.06.15.02.13.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jun 2026 02:13:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bastian Blank <bblank@thinkmo.de>
Subject: [PATCH v2 1/2] hw/xen/interface: Remove pre-C99 checks
Date: Mon, 15 Jun 2026 11:13:07 +0200
Message-ID: <20260615091308.4458-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615091308.4458-1-philmd@oss.qualcomm.com>
References: <20260615091308.4458-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5NiBTYWx0ZWRfXyVpz9+2WwDd1
 u1WSgZZgIfX15FQtbaODvDYtFVqxzN6QiYPeIz+0jfgPctR4uPFctb9m+JO6hT3sCxCVBpUsI3l
 +pTUJPnqPxaVI6ddsrH5DwiU/dTl3ldthpl8OWRmUd02Q3n8pRWydqQorommnpHego6CRz1UJhd
 h4Fb5obUUa1qAkXu8vqORbZ7R945d8Kl+6E8IENwfvAE4teiW9N8TMwKcZ2V+Hr+Ev+dPpfoBry
 HkOUmhLEGGtL7rOm/yfsAP6+Wzw+gO1UEcGZxgNjB366hwnT6TMvNN96Uxl6aO+A99FyO+VyI23
 DUQOx7D0YfTblHZJvEDiB7TTzS132kwQ3X+6n/fQqCysnILH65C+hb2kj0K/OjTsCmmxwc3d91S
 1/unUUJiAhfAlwSmQJMCrb8oyoN39dpSbBAaCR0DS26jLznu+Qrqwrh+JFHe0bkg6JxtrVUdAwp
 vFWIVppjk9dbgpSjFXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5NiBTYWx0ZWRfX1IX8Acq+qvhB
 10rnhDGVy993bWtCNRhDpFoNiJxI1aPr0u96IemVmH2lhKaI6P8L341siTqMEy6/nF/Cw6aMri7
 kTtXdGZT+4bh2slMCMY8gN60acvS6I0=
X-Proofpoint-GUID: OimOLEOFxz0N9wmBqxeP4kno4pEKkmND
X-Proofpoint-ORIG-GUID: OimOLEOFxz0N9wmBqxeP4kno4pEKkmND
X-Authority-Analysis: v=2.4 cv=ULvt2ify c=1 sm=1 tr=0 ts=6a2fc22f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=vkG9KRslzty0At4LJNIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150096
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

We mandate a compiler supporting C99 since 2019-01-17 in
commit 7be41675f7c ("configure: Force the C standard to gnu99"),
thus supporting flexible array members [*]. Remove what is now
dead code.

[*] https://www.gnu.org/software/c-intro-and-ref/manual/html_node/Flexible-Array-Fields.html
Cc: Bastian Blank <bblank@thinkmo.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


