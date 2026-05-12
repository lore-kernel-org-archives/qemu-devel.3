Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951BCCD4F25
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMocz-00086P-2j; Tue, 12 May 2026 11:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMocx-00085u-MD
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:02:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMocw-0000XX-2I
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:02:31 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CB5MiR591849
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e+lyn/CQmNPYMHgzrRwruoYF/VyCUk5nKBqAzD0pq8Q=; b=WZ7Jx7k+YjfyFxlK
 NRQQ5chV3YEEQLgks/lluU3UHzIRF1S6EXuabu+Jz8mHEBUmxNm3vaqXhcN/M6VK
 tqaKf6mfM4P2/LMcJEiOXIYA35gjzB52lJ8wj+HWNMPjfauhwR9gtbGGMGd4UFJo
 0sy6d+uYgYhaydu8Z4IF5xP9imgRy0K770V9pkY3vLsWMAsmrIZVbH63Kyt8lwTL
 8LkVVXTtGLtR4HH/JXTJcaaiM25VYJ6t6UMi7+CYvRU6065qrUdBwqJGfaB2vMSl
 7XN62oDRtH311YMjgNMuGE/pVpETZ/YyaUdlRqYT/AQq3LAW4Svn9HkR3RYSJldz
 2ITr9Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4319ryfu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:02:28 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2f3ec2e8d07so9759547eec.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778598147; x=1779202947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+lyn/CQmNPYMHgzrRwruoYF/VyCUk5nKBqAzD0pq8Q=;
 b=IFAJUigG6cn0EJFPxZKRxXkESrPYV/jumXHcsFRI+MT8i3MmRVgKubbVSgOlcYpL5+
 HBpYKCQvVFVuBeurcjHgpHOLukp5d7txgIlP9x7GvojM1eMQQy4Wj4qRa3l3KqU11Vw0
 E4gUoOjoP6Wv1wgqtj5ugJc977w01EjJeO+BQV205zd8xg24bnaTVEgkejFqxTGVbcwH
 jJ0FxzICW3L6u6MvLj7t6extOawgFbwTfgdyUF5s9EZC+7U1Ebg5eiP/3H71thFKrpTw
 AFzoZMZubw8zrHvfUXreiTghOS0nqBT+JEyRbqH7zE28yAd1pmyL9PHnvUx0hKR9OEMp
 QFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778598147; x=1779202947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e+lyn/CQmNPYMHgzrRwruoYF/VyCUk5nKBqAzD0pq8Q=;
 b=o/k+sMjo7rNP5cL8T7hiHFHCUsrmjHSBte9gA9edF6PpxPqwOUeix6O8UXsn5pKw2Q
 biMLJqAwDeiJtt3QUS2XX2SOHqPq3hc71w5Tq7mRyocEmD0FXAYYWncuLj0MKGN+Yojw
 4EOUwlRLImViCr0wrNGLf/xPttQm+1KLgZXfMU85nEYCxSAjvhtxAOQoz+OuAyVDwY2l
 7IkIzPUP2amHsX1sduoza5npNEuVsgio0KJFpDfRJOer0IZWrSQWDMAH38Ogyj0ftfRT
 VsaP0S0+pu8cifmgadNsrKbOjYscPw6DPaIOnWx/Kjxgc9ok6UVljwu7wBYheJWSx+VD
 7Gug==
X-Gm-Message-State: AOJu0YxAWN378gPHisBcdx1WDiI255p3zM+MUnbGYFAlgKgESA+GdG40
 upKOYcSntCrkcRp2Y3k0OYbjq0szl/nJupKfSlvcHmEI28BritqhXZrpJxfBLRIY6ekpnn/H1u9
 oKIA7gIjUqm45dUcxmPas2dt/YlU6oZ4rDfaQqHF0U/9OMhOUzu2n/x8cq2AZJ23qLx7V
X-Gm-Gg: Acq92OEe7QHlZlliJcVKiAuayK3aJly6NH3YWDS0sf5f6wcP3QHm9ld1FC2fP8Uzp1j
 FxsBqYMU61F1EaPsEVeXbGmq7kEIcScBA0ytTsRBJ0k1IjA82lvSYJN2iNLHYBY37U3Q1GCZ2HG
 TW0BqGkhtUoNI/npcilFrfijFUHjiLwBtC02sw7fVr1XWVaELQWAYPtgULXMXJtmBJEn8Hh8BSd
 9+x1xny7lxiY6LJRP2uWscRdmiidgnwrYYKjba1bWAOpLvASAUtQFYBEcCPx/JxZsrZoaK5oS+W
 Md1/fYlBlEJPTfaRE0uH2XkCm/Uva6Bqg1I43P0GT9tpkU+GTG91A/lfi4xJo/ajalWJmFkXz8S
 N9IDxa6ST1Es5vy6zHN6sruYqJrH6j4UBG+LwbeWZrXj6jLCrIvmSIHOKtPMw4tBfDVT4igl1cf
 clpUV9lQ==
X-Received: by 2002:a05:7300:dc09:b0:2de:6fac:f666 with SMTP id
 5a478bee46e88-2f85e32c7ffmr7540167eec.27.1778598145774; 
 Tue, 12 May 2026 08:02:25 -0700 (PDT)
X-Received: by 2002:a05:7300:dc09:b0:2de:6fac:f666 with SMTP id
 5a478bee46e88-2f85e32c7ffmr7539969eec.27.1778598143772; 
 Tue, 12 May 2026 08:02:23 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8862d429asm18270335eec.12.2026.05.12.08.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 08:02:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 4/5] target-info-qom: detect target from QOM
Date: Tue, 12 May 2026 08:02:07 -0700
Message-ID: <20260512150208.1167711-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE1NyBTYWx0ZWRfX+JHwC00kIHbh
 t2gMOONxYZocsTQpxWW3GYCs0URbLxHjC+1M+LgUUVL9EudC3UZPnnrg7N73KlliHzidROHr3S/
 0sQTl91cxE/uAtUbpjKCEN9dL6kw+v2RB4a47AzzfzZgl7/ZDxXoa52I047etn/fNTX90onPxh0
 I814uyD9CgPZe0n9tSveZkYDYMJ8T7M9K/hCeBlNIGrmwJwk3X/NrIPJL/UNcawn21yftKRrtEG
 cRYgTN6sp/WM8jJrRJlJEbgLIONFKLU9qdSqzI35v0Ay0HTmvwmObVys45YmBaRDrRLGWKDIczU
 7+zi/TpuqeQJfmTwdyo3Vm37ZkpIGjvARniaHd68r/YCnXVmKNyKcm9/XHAIffqmfqNKchFNHAP
 Er7Msht8fdYwpauydgg/3h6HTWVgyEtn6/aFcIzHO60VlsQoYz4l5hkHcbQCLX3ButuwUyk82tU
 PnISDv4NCTZ3IR5muqw==
X-Proofpoint-GUID: lWPlYYPxhkGY2tRBl_kKAlhNLS6c5zDc
X-Authority-Analysis: v=2.4 cv=bp98wkai c=1 sm=1 tr=0 ts=6a034104 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=0wc84GFNkZAXjcWhtbQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: lWPlYYPxhkGY2tRBl_kKAlhNLS6c5zDc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120157
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

For now, we expect only one target to be available at runtime. This will
change with the single-binary and we'll detect which one to use
dynamically.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-qom.h |  2 ++
 system/vl.c                    |  2 ++
 target-info-qom.c              | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
index 585995c7ad0..91be415ed33 100644
--- a/include/qemu/target-info-qom.h
+++ b/include/qemu/target-info-qom.h
@@ -25,4 +25,6 @@ typedef struct TargetInfoQomClass {
 
 OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
 
+void target_info_qom_set_target(void);
+
 #endif /* QEMU_TARGET_INFO_QOM_H */
diff --git a/system/vl.c b/system/vl.c
index e44da0941d4..e690aa3ed8c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -28,6 +28,7 @@
 #include "qemu/units.h"
 #include "qemu/module.h"
 #include "qemu/target-info.h"
+#include "qemu/target-info-qom.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
 #include "hw/core/qdev-properties.h"
@@ -2890,6 +2891,7 @@ void qemu_init(int argc, char **argv)
     os_setup_limits();
 
     module_call_init(MODULE_INIT_TARGET_INFO);
+    target_info_qom_set_target();
 
     module_init_info(qemu_modinfo);
     module_allow_arch(target_name());
diff --git a/target-info-qom.c b/target-info-qom.c
index 79752366b61..9947fcc9922 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -46,3 +46,19 @@ static const TypeInfo target_info_parent_type = {
 };
 
 DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
+
+static const TargetInfo *target_info_ptr;
+
+void target_info_qom_set_target(void)
+{
+    g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
+
+    size_t num_found = g_slist_length(targets);
+    if (num_found != 1) {
+        error_setg(&error_fatal, num_found == 0 ?
+                                 "no target-info is available" :
+                                 "more than one target-info is available");
+    }
+
+    target_info_ptr = TARGET_INFO_CLASS(targets->data)->target_info;
+}
-- 
2.43.0


