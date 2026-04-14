Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B9DF9D0FB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 22:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCmMn-0002hd-3N; Tue, 14 Apr 2026 18:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wCmMj-0002gw-Mx
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 18:36:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wCmMg-00083p-TU
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 18:36:17 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63EGLPKF029994
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 22:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xv1+/LdnW+O
 Qms/PDn72dEykm2XU4bOhubkQeNddRpM=; b=fIcXVbkCGixwvR6gi/V+wHqQGzq
 mwCNbGwJLadHvoN3fWKOOUMTwUnrIN+McIu04WlFNpaBXqIOhD1TbsXtKMicyKBl
 BTXbuOy1aePHfz07zuqlVPNKB7m128gABJFiSoFFiQbE5Jt3hVnZMKIPg/n5j63A
 Hlw48tuO9YUKHF0oSY1B9p61chiareSt+L77b80z8a3sVWtuul2OjtzIkR0EO/5K
 FoV4tkQwIQTbn7Mvi0cuxylLIKUtQM7bo5igAB+fYlR7EEoLR5tvitUOnx3Nxd5N
 6g1f/c6btlXjpZrC+Yq93o4eUPl5ZbIrRSUlOi7soE4YRahFJS7FiOOTicw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhkgmjgmd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 22:36:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b242b9359aso55463295ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 15:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776206172; x=1776810972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xv1+/LdnW+OQms/PDn72dEykm2XU4bOhubkQeNddRpM=;
 b=Pmd/9iQcOY/N01GqwiMkJYR/mz3HQqHbNBxWaYe0FppQIjivJxKn6q0GjSQ55xwHtL
 srLsF9xb2CxxyxyIcBD5bxRCbo+4tk9hq4ZfD/EmSJkWmYfjwDq89Tg+LmXNXiV0yjU0
 ykvr+QZnXcz1A3q8YQDSfFVS77gys8zHzMp8zE8Tj6AJcWLnCgd+HbNGvvQQDpDF0ksB
 BfM3R4mDs7NYr+BufmmyY6fxxcF94KUoobU/nGG38CkCdtiqsCuhDfSqMCbPAedgJBLu
 0kLpY8wwOVVXRF0SaZELlal6Qd1D/2YdOzNiydeVGvv5XkYtTCip42sStfH7+LcvuUeC
 l02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776206172; x=1776810972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xv1+/LdnW+OQms/PDn72dEykm2XU4bOhubkQeNddRpM=;
 b=aoz0gkBz3l1a63zylWzKY0YPNVSHitfYpbsCLpySvYTawjqAqV+ryoOFB3QqpXL8EB
 i5rBHigZDsRY27fepqfDhdGOvzIfL100dZ7ZxJr0lh7qMbuUGRqM2xAMsOnCMX95kwWQ
 qSJfGOTl9FBRE3Lwi94Vavyd8APAIVydw/Pzlpzh6trvNO7skGsYL7khXm+rIHfP3769
 vY1eDhGPiWghxCjPOPDt29lLKbNBC9fJ3MDBHuTA0oMzeEZZmOhtQXauR9+7s0zYe+HL
 qaq2zISRR45seNUB99edeFGaQVGS9bnf5W84vL7zBxy5MsSsuYHaJ9ISp8w+QWBuO1bX
 M1Gg==
X-Gm-Message-State: AOJu0YwDTfuUVxOX7w/RiFaG6iEf4iiLk9W2/CJDCKdYpyrq9CjFtQCP
 6yPZl2CNgNVrXql3qoD3tmSC1ff3yHoayIbtQ/ZYFdNIIeF5g0wjZPmVFvHiiI6teWu5O+inJUT
 FKvuDBeCwFgQL3sXkwsVKAlqYElfSATdSYOZH+NIRi3Kd5h4ResuNyU/AEyhFx3r5jGVutv0=
X-Gm-Gg: AeBDiesz+FWrMaMKARZrWgnEzl6l8rtu1CSkPKCxZcBOhkLuTOkr1Mtlam1Da/qgdhK
 8XN2KoI/hBePj4iP/83CxhCuSSGAYQ0ERqM2VQqaYriibAqPcjhnfuV3qyP19KE5JZm6TtYUafr
 avr5Txh7sLyNeHwHVCBJgKBRODdvoYjFM6Kp01pCGzWg/s6mLI7SkPG6teGCNN+BoJ6RX4r4dhe
 Im8s2xBryijLeJYqgHeAr0nqldtUFZH9HpMy06x4UdQ8Vzy5NDAsSIxVxwED0XADUOkrIZhnCJx
 gtdW8c7Rb3kNWUQ931ha8XTODM0oL5VKga0PzyphxiC0MNmHJNSRvzTXHxCbqk0U/y7S8qTFlnz
 knBY8vhCrS5bbBc9E8A5h5bK0dJFywVCkUZK+SVljOY3xh3B3jmoGMq15d/xTwNuVO6AseuE6am
 poPjM=
X-Received: by 2002:a17:903:b8c:b0:2b0:68d1:2537 with SMTP id
 d9443c01a7336-2b2d5a5c483mr205010815ad.42.1776206171987; 
 Tue, 14 Apr 2026 15:36:11 -0700 (PDT)
X-Received: by 2002:a17:903:b8c:b0:2b0:68d1:2537 with SMTP id
 d9443c01a7336-2b2d5a5c483mr205010605ad.42.1776206171525; 
 Tue, 14 Apr 2026 15:36:11 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b46151801dsm68901025ad.78.2026.04.14.15.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 15:36:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/2] MAINTAINERS: add new reviewer for Hexagon target
Date: Tue, 14 Apr 2026 15:36:03 -0700
Message-ID: <20260414223604.104290-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260414223604.104290-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260414223604.104290-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDIxMSBTYWx0ZWRfX6e+1g4jUGwBS
 B2uHh4Mqp7T72+zb9e5Erany2QG8caVPl0DMBpqAAMKadxrXAP/8AMcxqbo0iJvxtPYF6WChMsa
 qHs0WyDDHOlsMw2dN+wUlmN0h6jUjhsdujjLaxzV8u9AjX+0HHOAOSy3UePWWfq/FSKyOUIggMq
 l4lSzMlZngbJIkq2wKYThzqyY+jOWxbNmBhFPvkMrsP3AhOsAtZrv3rb57gLdG6RS/zc3g3CWGS
 2VBhKDYNbX+SlCAfMxGmbV3mBF12tR02z+WbSsW8ZSvGvncQLI4wfasi9BHbu0R6aDzpykl+WIu
 SgYvjfGp1etZX/IEVNI3IfZLpZw4yTCFfctfK32Byzo25ICeyHrbJMulp2zOheV0tWlfSbRx2US
 91+xyV1GPkFqln9ew67mpWdTK/Ky/9P+Lkrp6PzMwq3NKGcOSWIM5jSPCSArXejyy9d4q5mzPic
 ZNHAAyhvEX/sZ1LkX+Q==
X-Proofpoint-ORIG-GUID: i3N4VmsrWjoulflVMdtKxxznIcOOSHwl
X-Proofpoint-GUID: i3N4VmsrWjoulflVMdtKxxznIcOOSHwl
X-Authority-Analysis: v=2.4 cv=HJLz0Itv c=1 sm=1 tr=0 ts=69dec15d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=EaJnpZ2ZbUPJMKaiO9cA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140211
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 14bd822ddbe..0a90204ae93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -244,6 +244,7 @@ F: tests/functional/avr/
 
 Hexagon TCG CPUs
 M: Brian Cain <brian.cain@oss.qualcomm.com>
+R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Supported
 F: target/hexagon/
 X: target/hexagon/idef-parser/
-- 
2.47.3


