Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9F9C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1UyX-0002I1-C9; Tue, 01 Sep 2026 16:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1UyV-0002HH-S0
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:20:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1UyS-0003UB-Mg
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:20:55 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681I2jXd3530989
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2EF7NZyQ7PO
 Bsa7fAnhyiZa+QtFssuto8f55BZDO/kQ=; b=g+YRNtikkItCArdYh/3d8URri0B
 ueV3zfEB+bYP/a/SSc8FyIBX8TdR4nDfgIdNrNmdw+/CxvwMtMPb9ui1DUAIsD9Z
 KKUj1+4MjInmNWwKgmyIugFq07pHLMPeEB9oKAEXvu0CWD1FOewx0GijBj5Q6s6u
 R8ZHDPzMiqtfpknNp1vA2q3znwL8TCHJ9dRIEuWtzST49YvPuyaAK//225DmZO9F
 X8XASRAg+o1NcAUtEZUtGAKAa/0rdwFhwu79Q06av0LaA6h65UnIhTLTa8g8QjPy
 hG0inWVJPY2PJI0C2Hb7lYN2YfjBGHo70ldbVrjvDJQ5BKFcny6nueMuHww==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge3n0rhu0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:20:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3965ba1ba3eso284629a91.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788294050; x=1788898850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2EF7NZyQ7POBsa7fAnhyiZa+QtFssuto8f55BZDO/kQ=;
 b=Ixm+xSL8JLBOivMlKtctnmKbWDfuMRA2ZWzVpRXNEcZ2oJ9a4qfdJEN5wrR3HvBUTX
 EBzbpOqkhhzNAwaxsNbiEx4xaiaxznygqIkqwnonBNgQWQZ8eXq7054hkZceXSWhEllP
 e0Q3WFtpZ1WPOeQVexXnFJSPnM9iMpLfXtp+50Dz/UnLymPjuwRLivrCjHyL1f205oz1
 /yr7XVZLjnd6dzWn43TqXuUAe2J1lkPriCNm3ErHegTEcEDeTAapIfeW8Vb8n/PCqTJC
 ZNN2XIUkqH08b+jMRBWr7lEMFhUKAWUhJRFuyQFDL4eqax+/owGNVQ/CZVuz5jdD9cU3
 ythg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294050; x=1788898850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2EF7NZyQ7POBsa7fAnhyiZa+QtFssuto8f55BZDO/kQ=;
 b=m1jaQKZsJiE2MgMDOd3riY2JoIrAWskEQYGFpsW5ZCvgqdOKC1o42nDCPf9MWXp15o
 LI9MpYqq9qrsBDCsur+N4ejdqm4q3ex1JgfDSSSuTOJIoy1Y7v9YdBNcJtZOSmNd2X4p
 sv9SSV/omU9aqOnyMeCL9WgBuKCdxe4KDvRnivPF2o+lS2HaOlXv8C1FUd5ToVUkY082
 TKs4WQ3V/RYJnu3bt/vIRWF8PYr2uTvtdmu1hrCy2aMQM518C7Yt3GTdCvY4GpNx/BNU
 QQMcV3gDEPRte7WDvyIOQOHjVz8EZnxvLp2l6mvK3l5p6pqMnnRpHbhnlgr4gw2olU4v
 SMWA==
X-Gm-Message-State: AFuF++n4+4LgduYtPxafdseFpQF0UdFgnF+Hv2xJsv2elYyvSvipxOEG
 Di43Knl9VL2sQ+ElfuCjrF68nNywSu673jDBOLtN8suv5VeHptkSAs4aV/GQyCgF6DL/gVbSLDi
 SktlLWrcYlMPBZZB11+PhNhydkSBz/EaSXeijqT0PgvZPxXZiWSEZeXSE3BRYewJ3yQ==
X-Gm-Gg: AYBFou2Q6H4wc12fIvtscWUXD4gg5grfJPdDzGkYdVx5zyx8Q8BUDPh07BmAoKplLJb
 eADyky4TC1mXu2S0OpjUpzuCo7PE0ZKZdezu/rvdFzPkuJlARQLMRamqZsnhuElFk5DhsL3FEw6
 6xjxOFWVmp1LIl4ZFlrySxl93uXKMBsYuC2/vjBif4gGhwObqLViNt9sgf4+2sk+s959U22HOKb
 ljlK5Qv6KcUWbGNBeCe81qF/M04WvxfJiw2tUj/omhohRgta4jEc0hYVtnGDZlEPDh2On2U1gtw
 cP3D8GBWf3R2AYiE6nIVh1ZmFmuz6p6l+lTfSvbZnxgNH1d7sQQSmP8KvxoHLh6NqFI2utch84l
 XPkDYfBqar7wvT8e2IIeXJB9Mjq1uCm656xr6irtL6KJ8P6g+NDHhTmomPYc=
X-Received: by 2002:a17:90b:48d1:b0:393:194d:5366 with SMTP id
 98e67ed59e1d1-39907b5fefamr17235770a91.10.1788294050177; 
 Tue, 01 Sep 2026 13:20:50 -0700 (PDT)
X-Received: by 2002:a17:90b:48d1:b0:393:194d:5366 with SMTP id
 98e67ed59e1d1-39907b5fefamr17235667a91.10.1788294049558; 
 Tue, 01 Sep 2026 13:20:49 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d7bb9d7sm7734802a91.15.2026.09.01.13.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:20:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 01/14] qom/object: add is_available callback to TypeInfo
Date: Tue,  1 Sep 2026 20:20:30 +0000
Message-ID: <20260901202043.26532-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX76722TSE4t0C
 W9vgQDNfZ6nEVF6jQwg63MnBFRN8fhXOMsvbsvW7hQk+juXtsXaVXfV3yb5TdWMz6xBxc+d2jJ3
 tuoLAx6k58WWhpmwS/UbM8Z8AaUF+6w1x+9rc1xB4SXitnzQK7HmMrmuDKuCjbEKDbOv6v1amLw
 JGlmxt1I7Hj7zVWasFi9Iegt1LVti7hftTvfv9EGdzCjydTTmyHNP1CcjZr0nO3NH0M437Q+zHr
 6K8JBE6TPb9E/81UQcSv77j4waPWkwwjnXu+nHYOOwy0Vfv4aummAIzWHEh3ocJauFWJSIPeV7m
 QdDRxBHen2Hmfi7MYC/juKchVOMVaSQsRe5nLxcbNjtH4G2WHplaLx9cDjwwhIMf98uD6fjQlyc
 Us7YN9xhJ/WfWhYf2OeR7y84R3RLj4AHlJSluS8ITvuuyJef4r8FtU/57xjRAiZprUcZzbvkuxB
 xJGyVQ/TzwbUdTJY2Ig==
X-Proofpoint-GUID: 278csvv61r4v7TpK-EQ4UuL96j17ZlTT
X-Proofpoint-ORIG-GUID: 278csvv61r4v7TpK-EQ4UuL96j17ZlTT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX1K8e44snSp67
 7918CRkzU7gWinIKsbYqlRVePrti0jVZMtdsQl/vqFfsVk5HBxhx6uTMo5D4BNSPCkAeXDaavmt
 sqSiWMDtdKMPCeJD8jrT8zMi8W3cRfw=
X-Authority-Analysis: v=2.4 cv=R9oz39RX c=1 sm=1 tr=0 ts=6a9733a3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=AB6Ai_UoB1uFYp04BLIA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010178
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

When removing target specific sections (#ifdef TARGET_X), we started
exposing types for different targets in the same file.

Previously, we implemented a filter based on interfaces, but it
proved to be too cumbersome, requiring duplication across architectures.
To simplify it, we add a new callback, is_available, to TypeInfo, that
will replace the existing filtering mechanism.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
2.43.0


