Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8826C982DD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 20:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7fBC-0000te-Nj; Fri, 18 Sep 2026 16:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7fB7-0000t9-VK
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 16:27:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7fB5-0002Vv-FP
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 16:27:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IKEtY51552231
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 20:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=PKkSjEVQ7X3Dq6zkc2ZuQfmWynIi5uot7q1
 eWN/4uzU=; b=TCZz2W7KpDxGqiSke4d/iLJV/2mrZTrmJzFG9jpnl6JPr4ndxZt
 v2Ow8B/Dx1s0WC+787OB42f5fMpim9E8ll9+64rlJ7JFkf7rExAcwWbTZctZ3dV9
 O4SLuVbrEDLse10gapQPoHCsPcGHnE+0ZAGHpshD9DiUaThFCgs/VsyGJ0rxQzRY
 clMc3irQ3q6HVM1AGQqwwkwOBkSwonz0EgSnYv43Ja3J2yJAAsoRIyehB/BctB1J
 jKmCckwUOW5ryNsiQm5piphar83yT21LxGIh1FYL848sIQUX7dCSu0BGeLX5TvmF
 q9eVMTv7Ke0sjWlMjFcf66nnpB1gXxd0kcA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gry2bunct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 20:27:15 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39de4a68f7cso1996996a91.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 13:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789763234; x=1790368034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PKkSjEVQ7X3Dq6zkc2ZuQfmWynIi5uot7q1eWN/4uzU=;
 b=fQ6OZg43RyDd+dFl5X+J7JHSS1bWrn27ULKmL3+AsQ/pp/Yeojz8zYiGfu/Rc3b/og
 z8uegbW10qCxxpWMVcd9PsESbd4HdMNkqkZWDyCs0Tk/CG13eHaDftO+aW2cIHrI/fEP
 tbSANJyCuwGfKC0K+j4Hy603Ztt0EdZqteY1nbl1HOZiQmnLmDwmL3iZTAAl8PDPgbQK
 qDh/6H41fWDiTMdXSkY3XNzhY2+wIXuFwXCf3I/VUKhtouOAAEIJx58icjhhNxPbb3gB
 1Qj30baPrxSZDeVTjIOg4Tct4MD7oyyApzl4CLJBbD9LkpYGpe3+ChqUCczbmxHs486S
 7Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789763234; x=1790368034;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PKkSjEVQ7X3Dq6zkc2ZuQfmWynIi5uot7q1eWN/4uzU=;
 b=t+P/MON1/5TlbK0Z52rfVtmq7viNON6BVgsS/I0qnCJMiB/1HaU2q/9P0V0xHQnu00
 OQYpISNKtDxabwlJyB+6YxxDlNptIdceM6vgFJ30GRYIfXaZX7B6DFs99/R99bWferO2
 FRy4NPMjfO+U/J2eVu+nvE1Q/AqFVt+Yp15rZPLmMZM/ciURfEDsdOZ78eCltH0V5kzV
 ou/aEF4I2JzGThEcorYQkmVLFIaUvPRM4XOeZb2zhq4wdet5yh3YYXut1TKipD5m1V9I
 1RXjpxvvKlObyqHlywVPdBA8zDuxPL71FNkpM+mLdNrW65I79lamJ6BOS99tbekCjgxI
 0UaQ==
X-Gm-Message-State: AFuF++kmoPsRoB9zhblr2MPQDABwGMvs4xCrSUF9cY1o8mJRw6WmrTSJ
 WVhDK3EwsPXwtgDwibTGX9zFd2pQUANHNi+45oRZ6cw92Ibwgl2WNgtYQm/8sDM5fAe4wUwpKEi
 RsqubIQykee4fh3SNf1YqPYaQfJQ3rg7822rglEilUkolgpt4MoJi7QPC4ugYxNup4g==
X-Gm-Gg: AYBFou1/lZ8x/Hg1EYs7KwFP+8tghhy+nFoYHJMHRSeST5VpbcTGJknP1phSYiAhgaY
 ETO6L/6wykcxfFYy6tta6wYW2g4sQNY/g6ankGG7fJuCSvUm2Kp2GDPWs3bydwyXzY0J137Vc3J
 7FC92NufYlh4lqfWfcyTKC/k7Ecnt4xA1bI131m7EHlIWQMvnYmzvjQV1f1eLsSQHRxzBMUXfCn
 RJpjt76C7Z7bg5XAwVhObbylfR+d4xLTd9tNlYwWN3xfQGlGz69OLaMWapDNS9vMnKtQqGKss66
 Gd5WCudId+eQLSIEXtYl+S2zQC5aTdHAAfVb4cFrjc62dV1VgRPg94q01TnEXcBa6uuZbvvqflH
 wrltMrhmkO/dutkOBbuAkM95p0tG+v02nhjbGqqt0C40idDBp+hxIc1/hSdk=
X-Received: by 2002:a17:90b:5626:b0:39d:f5b6:ca47 with SMTP id
 98e67ed59e1d1-39e54fb868bmr13227223a91.12.1789763234413; 
 Fri, 18 Sep 2026 13:27:14 -0700 (PDT)
X-Received: by 2002:a17:90b:5626:b0:39d:f5b6:ca47 with SMTP id
 98e67ed59e1d1-39e54fb868bmr13227171a91.12.1789763233937; 
 Fri, 18 Sep 2026 13:27:13 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d55bf843sm1179117c88.8.2026.09.18.13.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 13:27:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] tests/tcg/meson.build: reintroduce build-tcg target
Date: Fri, 18 Sep 2026 20:27:04 +0000
Message-ID: <20260918202704.9790-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI5NCBTYWx0ZWRfX4ET/Gu+rexHy
 5qjpKrEiSE8eFjD42D6VGekgejubTzyfvv6VpUvuD0HXlPQSBH5E2iUiiL5EK6m1y69G81NP3QM
 lGRMcwLOFtB+votSZHVHEsgDN4m8An6RcGxTdCHf0CdL8onPtnDAY+u0+h78eTtj+AFzFTHH+h8
 c2HBj2ZHKrLz5u7wjPdYu+MtczVf1pcNJexV0vvULEF3U/TyR/jexjUNIxoQk1D04b27JLwqkQp
 y5CVeL1glf+zjWtpPlRHu2Vo1OTstilbtIqyZPuISjNcw3INMWswcL7JwJPRNYF0hMb792LZTyB
 4IrGw/3dc+wHwL/71thFAAdIaaBuD8yQcA2DlyQRunmUYauFbCITxQ/0VIzCujshNjhYHzHWIMw
 Ye0/f3ddFL0YgdGD3Qd7BJ44dpKDqzbxmm6X7CaOkkdNBRnb5JDGlehpwgz9PXyo5SkM1btId4b
 fxObflmgQJZE95abUKA==
X-Proofpoint-GUID: gl2M4iJk6EF-92nZKgBfoDcAhRvQ0YaJ
X-Authority-Analysis: v=2.4 cv=bYP+w+PB c=1 sm=1 tr=0 ts=6aad9ea3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=QDOw5-jm7CSiVGTWIMYA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI5NCBTYWx0ZWRfX9/8N7tRucU24
 QLr0ihvFlbEsLO7EbIiJHVWs+wT4MR7wl/pNbgvBelY21uHXUKp5OusdxKGJhGPKfstZ/phq3pB
 falkJfU6m7GsLbgDGYweLdjsfLOnx68=
X-Proofpoint-ORIG-GUID: gl2M4iJk6EF-92nZKgBfoDcAhRvQ0YaJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_06,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180294
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

The refactoring introduced a new target named tcg-tests to build all
... tcg tests.
Previously, this target was named build-tcg. Keep both for compatiblity
sake if people were relying on it.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index a5e0462732d..a571b939b89 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -522,4 +522,6 @@ endforeach
 if exe_targets.length() > 0
   # finally create a top level target to rebuild all tests
   alias_target('tcg-tests', exe_targets)
+  # before, this target was called build-tcg. Keep it for compatibility sake.
+  alias_target('build-tcg', exe_targets)
 endif
-- 
2.43.0


