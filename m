Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28034C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLJf-0002g7-NB; Thu, 16 Jul 2026 08:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLJe-0002fL-G9
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:35:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLJc-000734-4i
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:35:50 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBiZfE3747257
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IEmOH+y3eJI
 /+UHqBYKVlHFvW5x5P24mE84XXeY0tUk=; b=ZD4wUBgjdDQ0vyvwqjb6ewg58BY
 ZlpERv/51QA0FT/vTUHoXHPVQaYxz6NBmEWKog5biH36gXoHbD/jTL5TL1AmrsY/
 UThnwz8kFtDAIxiC+hfxacCN1INS87QDX81DxBWr2iS+XlLNzsva81S6FPrHN/d6
 CMa+ObZ7yV7mltYyOKsNClqtVHe77O/W2KurL6052/vpjlkWUVxd0GIRb133s94j
 v7grGoogECE2vs0HXn5M6nuAm6NR4qJPELGN0rNvNSA3rnh9icWvPF0EqiOR+fNS
 BbtQ8d0LFcl9AWU5w0fEFdqthZN1MJakgzrmo1NouD2VuGB2kZi59jQ8pbQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feq3pj54q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:35:46 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8eac2620cb0so65214396d6.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205346; x=1784810146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IEmOH+y3eJI/+UHqBYKVlHFvW5x5P24mE84XXeY0tUk=;
 b=AI3HmYUPRHxZKM2FMOkw15uBjBArkJUE0NxkvicGCwFY+26mxJ3+LYAvAn+09B8N4n
 3gI+ipFo6JHYViIw4XUf7Swzo+0l96BiTZdMC7PW5GXC3z1wDdAin01G4vN/T5BcUCQ8
 E9Vnxdb5TYXz+cGpkCQlM7rpCzdz5mNHgeRSdWBq8w/jRDMFnZZJk2d1rYseMK8tpXyo
 sjvXMFbDSK59Edgzpj1Pu3vnzOmhGHzC8i+hELNR9G1pwI8VHFpBKPvPwOybL91DU0xN
 9Pb1rN0lLPPvuyyy9WFwVx49upMwVOMK9O0WBXH1AknaG6u+AOawB4wMZG98Gw7J4DWU
 zA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205346; x=1784810146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IEmOH+y3eJI/+UHqBYKVlHFvW5x5P24mE84XXeY0tUk=;
 b=DAWntuB9fKAkERS9qU7y03pYwTslsu/2ArBka5wJp7EkX5KSvLoxUrb/u4TJhX3bEH
 0RPLNqc4GLZaUy8qVI4la65E2omtFfu5plsZch8ISUIY9ffhzrftNWCAwdeWg8QjQ/ie
 gApCIT6MeIAzCg9j06tEEtBBwB7fY1jid4zdFg/wmCo6wR94l8pmwJ2N/yGfRJr5HOS/
 c4B0RVW//nYAs+AjX3Nv0vEk/tl+wqBfEZtFVeATNEwuFcji0KgSNiRq4jAuYfl1rLtV
 XwhORDTQ7igK/oEU/zoZ0XatF8tF6dlN0g3jD40+gsHwXVGEEIo67rm+EmrQF+ErTegV
 xN7Q==
X-Gm-Message-State: AOJu0YzX/pGaIOai2Zyx08YfA0aJ5/BT8Zn66LoOhgjEOW+WXH11IyeH
 IoO03XaHh0I/3pgtd/4l/l/h1nLIvzyg+xvygtA70DWO7gXlecCwrzrIOo1y6wa7UfFKJO26iwO
 slU1gpHyZ6YXdJT/HlMx/CSxTJ3NGaKgpTr5JZVKf5zmMipNqTv3l9M+CYP4gLAy4ug==
X-Gm-Gg: AfdE7cmmrFXuz6LFRHvLjDWCen+hDtfyueNaFLkRizvxWMZIorncpAJoSUUEAqPhTOt
 KbdtvNj34N5xpvWAPvT34u1DxnhgiUcWPb0/Z/QoDuSfUwpFQJzs+z7aSWKkslSnOd0wiJFGtKd
 gH6zLlpE64KBWjx85bkFhel/a1u5wXNYTZlBrgL8rUD5thF9ZiajSRz2J5RptztWtCIXGBDEQYy
 QrzIT7jYwD05QciURZM+WYis8ZpK+jYUsAjjB50cV8LtXCOmHiur3pUBm2l8Oq2vTh0jlVJ+FnO
 +3w+3LOnVLLOEjQ1a82jpG0huIkw4JgAviDhxy9TYl69gU5tpMu5uCrexyNonS4sGeH1Q4rXIeF
 kbU1gsm+tVWsAevnvUx19EfyVkJhqwsZrSR4=
X-Received: by 2002:a05:6214:8110:b0:907:4850:d191 with SMTP id
 6a1803df08f44-9074850d6e8mr130114856d6.49.1784205345700; 
 Thu, 16 Jul 2026 05:35:45 -0700 (PDT)
X-Received: by 2002:a05:6214:8110:b0:907:4850:d191 with SMTP id
 6a1803df08f44-9074850d6e8mr130114476d6.49.1784205345092; 
 Thu, 16 Jul 2026 05:35:45 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-902de1fdb3bsm191609316d6.23.2026.07.16.05.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:35:44 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 npiggin@gmail.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH for-11.1 01/17] target/riscv/debug: Check only mcontrol
 triggers for break/watchpoint matching
Date: Thu, 16 Jul 2026 09:35:18 -0300
Message-ID: <20260716123535.3709148-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
References: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Cn0g6R4c6XgtbyZwMM8KNY3DwAz5SovH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfXwwDXkPcri+zo
 8rOtEoZGWLgVhWvQpmiVy0hAOjeiFeYdKPYaUYUMFfsdAIpvbmtEsuH1QOmcZyYHgYV6Wgj4H3R
 DJLuHgNhh5buf3DyP4yLXj9oUW08PBs=
X-Proofpoint-GUID: Cn0g6R4c6XgtbyZwMM8KNY3DwAz5SovH
X-Authority-Analysis: v=2.4 cv=PN8/P/qC c=1 sm=1 tr=0 ts=6a58d022 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=uJK--5DT46cJm71gjCUA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX2jWs4k0Goc4k
 tXTzPnd22+4O4Ae0aSgbnczs+fA684UPFGe/pdSMIIePfZkSxvWpAouK7ZAlZrSCIOiypeQ1P8P
 lEaLaC6JM8YDOQMGNrfvkwVUtQs26rObyN2h04ZnkdmpXV2qOGEyiNFPtNL4Oo1oCaQybdudMNV
 FMVVmC9fRFvLssFPPvPCXE6qK0cr1jqn8FPAlhN9NvYPTHCIzdgfiTL2uweSWW+v/6ERC+oNs3Z
 OrVzDzkF8COLJ45GQqCj/cOEDt0TaSYs13Vm+V5WqKeW21vSL2fMSi7YPPxg3m24DJchWQIdmBw
 fdZYOLWA+f4p5Zky+sCSYroQuvazAQIa5mNOXTqyw9DKcwaTAtVRzjKo4jicGWebvuPa8Xr3wOU
 YQ3M2ocul5XhXXz04Xb5Z/T8oobg/mWY1cTN+uW6yLcNAIy2xuJIyY8wlWp2onNu/Xd63ITJ8yL
 75gY2dOF4K9WBUYG3+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Nicholas Piggin <npiggin@gmail.com>

trigger_common_match() has some warning log messages in it for
unsupported triggers. Don't call it in BP/WP checking except for
mcontrol/mcontrol6 triggers applicable to BP/WPs.

Fixes: b5f6379d13 ("target/riscv: debug: Implement debug related TCGCPUOps")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/tcg/debug.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 3c0fe70101..3ee598b86c 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -954,6 +954,14 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
         for (i = 0; i < env->num_triggers; i++) {
             trigger_type = get_trigger_type(env, i);
 
+            switch (trigger_type) {
+            case TRIGGER_TYPE_AD_MATCH:
+            case TRIGGER_TYPE_AD_MATCH6:
+                break;
+            default:
+                continue; /* No other types match breakpoint */
+            }
+
             if (!trigger_common_match(env, trigger_type, i)) {
                 continue;
             }
@@ -978,8 +986,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                 }
                 break;
             default:
-                /* other trigger types are not supported or irrelevant */
-                break;
+                g_assert_not_reached();
             }
         }
     }
@@ -1000,6 +1007,14 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
     for (i = 0; i < env->num_triggers; i++) {
         trigger_type = get_trigger_type(env, i);
 
+        switch (trigger_type) {
+        case TRIGGER_TYPE_AD_MATCH:
+        case TRIGGER_TYPE_AD_MATCH6:
+            break;
+        default:
+            continue; /* No other types match watchpoint */
+        }
+
         if (!trigger_common_match(env, trigger_type, i)) {
             continue;
         }
@@ -1038,8 +1053,7 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
             }
             break;
         default:
-            /* other trigger types are not supported */
-            break;
+            g_assert_not_reached();
         }
     }
 
-- 
2.43.0


