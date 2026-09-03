Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AB4C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24vV-0008PB-O4; Thu, 03 Sep 2026 06:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24vU-0008I2-C2
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:44:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24vS-00074r-LS
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:44:12 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AH8ZQ3203919
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hA3ien2PAEPF4LFUutqvJSyo93SVzDHV3/mOyRZE5PU=; b=pYc2WFlbqtRTvWVR
 iBi2QIP7eoPbUEgdN/1tRHFrzN+EKU0BjPgswXtEjYkJ9twn/wwKKbLth4RDpzIH
 9kXsdzaWRQdN3yCBi4XafZRMBl3xuG5qFsEI/AK1+gZTsVZFdvZOZEVgPULjZSXZ
 LiSUgiTeDyVBUwNGDKM4QwmqPGENDEdWAHbbP+p17GioUBVaOUvtvLhfOFc2qb1p
 pCkyPuEHTxfuw1iU9rOMyWU3DanaLfgShBaONQzKuFZ0DHZCOlz9zNyR6afw3Mza
 uxiuQykzhRe+lag9ILvSHf69GdLAu7zjTv3J1bPANCPDcIwzYosRKzjXTmgVMT2M
 N2HUDA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5d10hk0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:44:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9390a2c895bso580385685a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432248; x=1789037048; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hA3ien2PAEPF4LFUutqvJSyo93SVzDHV3/mOyRZE5PU=;
 b=HsGqYk7L8aRkU2f7DXiAdtgZ12o0zTQ3AQAKVfdYRWlEhdT7d4vq4lAXGEPs/GhN2i
 UEfWBrCZ/dZxDlikjW5sf+y5kl58/l8X0Ag+tPJZXMwZD1qjh8uk6MnzMnUAvOKl+QvA
 2KUnszg6FbrtPY3P99uaGbGb8kMnLpd8fQKEpJTaTLW+L7QjcgCQsTAq+oqWsbVHmWbK
 HlYzrotIQi/njE8x0aHDf0zLa49i467e86V8Vj8e2GW0C4KidHRFmPSqp3IC7WZ12lJI
 AKpysUukyjM6aV9FLSDY/yPlPYh1ES1Rn7HWVUck6E/QSKnA/Mc8QZbIX46mLiEt/2SL
 y0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432248; x=1789037048;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hA3ien2PAEPF4LFUutqvJSyo93SVzDHV3/mOyRZE5PU=;
 b=cC8RSda/OxWyKDb2BK0icxrPxsLdzu6x69IG5MDrS/eSi/OfWaG/ERsYtsYLIUNKMA
 ExS5tKhggbnhUr55iGDJj4MU2JDP5Rihi+x9CHwZUhKZolwFcJsQfe8J1/asCfsHT+IY
 39/licJ+4FaNnV+RjFQ3uDAWM9vDLHEwIm5QrOtmPb6kRMosp84vC1wGXdeilndm05Sg
 6sdIGXVuhsydu16EIH5M2pXppMH/I2RA9dJQIXJmVihonb2oCjoDrDP5ELkG4KC17M0x
 8+KHmNpB7U9JS/zGPfURSTEUsXZIE0zXDuyeOicYiHQ2coR9gIk++pR9hS42VLB5IC6C
 hB7Q==
X-Gm-Message-State: AFuF++lWltE818tzszryh2QTaaa0ES8HVNmBUv7ac3g85BMZnHssJREz
 mbtBailTV9yGRr3hHKArsH7RDDXHY/GVdIvQFiCWRQ9B8ILvfPpEAsOy81Yi4IJFIDCG+pMUuAU
 oIcPEbqBvWI/g88Ku9bA3vIH3SuNYWE3aANbSRrRGPZ4kSkk5+lbsYcVhrUX5fQytvw==
X-Gm-Gg: AYBFou2zhAeG0oKXhWmfHj4gsiUPF3gtWPTELhpn2LXBVlPktFPdvkVZ86gYR/4q+Rp
 YjAtQaCxB/r+NGP2BqEzojBdQt6ulk/IkbzXKShprzTtJ/7M2bTVi+YWaKCRXtHT4WG+WIcYuoC
 mM1ymPq3fyuuG+50eXgM+wFU38VXX9L0/+QY/OpBrEBX9zzhLsr0yn57bqCvZOSW3heVkDhCCki
 W3VkKtWIaGfKuKyw9v1G1lTDd+lfgAuT1ewyGPSXzLrMVH7/u8mgwCp4aoRWqqoi+YTXwP6J23i
 i1K3olAqNNW0M0j43gFIGC8CcfIBSpN2JIFPSuR2k/EGEERiFLSP8/QYBANEY/mZ53HwMIp5ncq
 b5Plug155Hc8426Ly1ghKX40WiI5qhnRBMcd7fbyz
X-Received: by 2002:a05:620a:19a1:b0:936:bcd8:8650 with SMTP id
 af79cd13be357-93960ff3badmr1140388885a.38.1788432247855; 
 Thu, 03 Sep 2026 03:44:07 -0700 (PDT)
X-Received: by 2002:a05:620a:19a1:b0:936:bcd8:8650 with SMTP id
 af79cd13be357-93960ff3badmr1140386985a.38.1788432247390; 
 Thu, 03 Sep 2026 03:44:07 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf2531232sm36130955e9.7.2026.09.03.03.44.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:44:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/51] qom/object: add is_available callback to TypeInfo
Date: Thu,  3 Sep 2026 12:39:20 +0200
Message-ID: <20260903103936.62355-37-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX/6n6n+mCZpkF
 rsgxbzj+AigbubVvgiQ8zSWXQnFCCNc715RqfmPsNgS25V8P60G3d2H5oPmFG6ohvjZ928rPFsU
 YmmbsZhlQzwYBcyRgzs6bK6y9zQroHQBdxiA8dcQH3L11viyrsQPz/pQ7nSO4qKi64mIbI6E96e
 YS5oT8gDBZNHcyOCgwm3v5kSMkt8WG033Fo+D1SziPezHCgY2Lnur1xohIZhx5F8SWinY7k7VeB
 z6GW2reExksvV/O5R0VlQndA6ERaZLxb50q36NB1AplmyJEWZzDhE8b+rgq/n1+fxXpVdi54jeL
 Xz6aBNNpXaYQjgdx8RVdOeEh+SmHy7vqctjivorBjOMHo+nyncD41d9GRScZIdUhawhjEGKpFIQ
 7507HL6WiFwmiIVJAbmz+uwNz3uNaaYV3xMj9GizXtK4ZZn9ACwgEFLtGctuWMNDUDrGL0v6hNZ
 uT2gD7IBXsEeTR1SgNg==
X-Proofpoint-ORIG-GUID: rnniKiEB5ETzwFniYy93ZQetOaJ2BqR6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX7/e3GaaGc+/8
 fohEjAwAfJT7BaLnqSXBbf3p6Bfbia5TydiImBD9S+hxnxa7J4ZteHJbBcyu9B8SUQuyfQaBsWS
 bgnhNJWFtTLVb/e++S4ikKu7xVi4oyk=
X-Proofpoint-GUID: rnniKiEB5ETzwFniYy93ZQetOaJ2BqR6
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=6a994f79 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=AB6Ai_UoB1uFYp04BLIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

When removing target specific sections (#ifdef TARGET_X), we started
exposing types for different targets in the same file.

Previously, we implemented a filter based on interfaces, but it
proved to be too cumbersome, requiring duplication across architectures.
To simplify it, we add a new callback, is_available, to TypeInfo, that
will replace the existing filtering mechanism.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260901202043.26532-2-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/qom/object.h | 3 +++
 qom/object.c         | 4 ++++
 rust/qom/src/qom.rs  | 1 +
 3 files changed, 8 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index e24f0a2b2d0..7ecd0f210fb 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -469,6 +469,8 @@ struct Object
  * @class_data: Data to pass to the @class_init,
  *   @class_base_init. This can be useful when building dynamic
  *   classes.
+ * @is_available: callback invoked at registration time, to dynamically check if
+ *   this type should be available or not.
  * @interfaces: The list of interfaces associated with this type.  This
  *   should point to a static array that's terminated with a zero filled
  *   element.
@@ -491,6 +493,7 @@ struct TypeInfo
     void (*class_base_init)(ObjectClass *klass, const void *data);
     const void *class_data;
 
+    bool (*is_available)(void);
     const InterfaceInfo *interfaces;
 };
 
diff --git a/qom/object.c b/qom/object.c
index 85bbd7f9fe1..b1834a57cc9 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -163,6 +163,10 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
         abort();
     }
 
+    if (info->is_available && !info->is_available()) {
+        return NULL;
+    }
+
     ti = type_new(info);
 
     type_table_add(ti);
diff --git a/rust/qom/src/qom.rs b/rust/qom/src/qom.rs
index cc00ddcfc98..bbb485e2cfd 100644
--- a/rust/qom/src/qom.rs
+++ b/rust/qom/src/qom.rs
@@ -691,6 +691,7 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
         class_init: Some(rust_class_init::<Self>),
         class_base_init: Self::CLASS_BASE_INIT,
         class_data: core::ptr::null(),
+        is_available: None,
         interfaces: core::ptr::null(),
     };
 
-- 
2.53.0


