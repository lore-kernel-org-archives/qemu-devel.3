Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22589C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtv-0003Hc-TR; Mon, 06 Jul 2026 18:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtV-0002m6-DH
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtT-0005cP-SE
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEXPC1666178
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2gqzCA5YbdK
 lu81B/knbccHtl4kE9WOEvhh3GhZ3bu8=; b=OR+HUCkDy5XUlvxc1goLYw0skMU
 r3GFtyYIZ2RzdBYuD05CiHmL75tYDEj3abY1ToUg86Iv1O3d9f5TQHESeUoy8eUn
 gxEnTOMOT+i3mUxkQs7oMKOkHB8qkGbZoRFid1lowZ42VB+tyZ6IPbvS8wN1wZCA
 pRt3f/caRa5a+ixHKBgXF/CROfMsXkRbT/Ux733B9mjKre/mMJBQ/lBouSdZ7xX0
 LKFpzEsHa9a0d16W8Y8ZaWCxWwr1LIHXjLO6iBn7HfyoxhulbLb6a1WqfGZgRQy5
 1XdhQMk7hIeTWTK8qWoKD2ZNu0Idx3/SxqcMo3OFRE8Cu7Wo+Gvw0cSeH+w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gu6f2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-37d4f23eb37so6073647a91.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377266; x=1783982066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gqzCA5YbdKlu81B/knbccHtl4kE9WOEvhh3GhZ3bu8=;
 b=H2VOh5s3+UZLgK7n+SS0GODIfEuWWEvHC7Orx3KN+2+3RR7/hpogbkuTUiVwwJajYN
 hDM1HUUANHu8iVOuNQnCuiodF+GTmJ5OB68p4NCrj2WiWDKEvjvc+cb7ICabJpbT6zGC
 GlRhlth/qR6t5vZZtcLc5xr38isz1T3lxQ/CKcY0KrZPCRrcBMjdDY2EADYj1/a7lLKR
 bBeViEK4cfetbBWge7pPvgsm9whkBZea/lpyA5H2OhCX5t6mZprsh8/9vaKXFjX+IqQt
 F7ilINkjDMqtJf5iCyRj9n92MycuJ8VrIaCMqIodzMa/CvWJ3OwNnjXCPhkVFanR02Ci
 zlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377266; x=1783982066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2gqzCA5YbdKlu81B/knbccHtl4kE9WOEvhh3GhZ3bu8=;
 b=OBtggwWnJpOJGa9UR2NZ8h1dmtQht0uPDHqJziPcRF9xp6A1nufiNT3h9lDrD+xVZ6
 XvZNZjLPfcNTxnrb9XYOCVpr0Amg2gbVMxeaCl5bRc7AKA26Sg7DnWFL99Kr8u33OPHn
 k4Le4Ahk0sRAhWJCVBXJscUPF8gIApWyPPJJyuHVXc1+Vumsk2mLFBbt8+CjADxEa5Yg
 Ykpkdhl1RSOWTyS+Vn+ezEo1fSvrSnC4/HllMboqodmDtaUfv+yB1JjvH0S6sKnRvJBr
 Eyk+nwlkaLxW1CaO5ceKDE2aWthle48h7BqcgfChyfhuL8Mzq1kbt/QGGoh8c5KN1yFB
 yejw==
X-Gm-Message-State: AOJu0YylaT14QvfYAwivRFRLUEtgR6pKjHGWKolx0pNLPXtdPDReXGkU
 REE4UG2904w7vDXxbqWEqx6KfwH0qlIRpLeID1c+KTtaz13zOUKhxjFhVX0g2qey+EvB5yqeYIZ
 WIxKaOOMgiiHbsqBzBkdGS/mnQSjuFwmUESp6+RhNMkAgphH/9vb10CbEiRjPNyreFQ==
X-Gm-Gg: AfdE7ck0DRUiOjEDU/erqxVDpxJ7ZWPYs7vq10HT2NVF/2f/5uaIZhHiiZWIWvLQ5mY
 JOWAXuezhA1mju/c5N1rJgbCZpZj8enHiHlXTcmgahEpAfgPFIW/a0ql3xVvPchqfVvBv2Q7cvm
 KTwc+ZOBKD2E/0cORFG5LS/X9mG7K88+N2PC5A3Lgm64/B5ZrE9hJhp9gkyRk+WZVyCsfCPcyLr
 hWXXE8eMINTlhTY5jPKXNayZfwRv1Ag5dWdOTuewtaa7oCZ0hKCESl44t/wJwvHMbSBpgwJlpEm
 IrStdht6Dw2PisgG3wGT2DTu+RigSz8vc6zexesOfxrn7GH4Rjt9poQIZdkOIkLudmTiRPmxFrl
 Venu1B2zV/K6pGl1q1/mfPI9XvX2N+xmAsxZutO+Ddt87dmvGvh92Omor1fZqJXOGfhFhkQDcz0
 7+4faw7A==
X-Received: by 2002:a17:90b:58e3:b0:37f:f89a:a1e6 with SMTP id
 98e67ed59e1d1-38753d124cfmr2769881a91.0.1783377265784; 
 Mon, 06 Jul 2026 15:34:25 -0700 (PDT)
X-Received: by 2002:a17:90b:58e3:b0:37f:f89a:a1e6 with SMTP id
 98e67ed59e1d1-38753d124cfmr2769852a91.0.1783377265369; 
 Mon, 06 Jul 2026 15:34:25 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 21/91] tests/tcg/meson.build: add logic to skip tests
Date: Mon,  6 Jul 2026 15:32:33 -0700
Message-ID: <20260706223343.988769-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: u6lrGpzxuAHRSKMujrN021gVXpFG0Pvs
X-Proofpoint-ORIG-GUID: u6lrGpzxuAHRSKMujrN021gVXpFG0Pvs
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4c2d72 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Yg2_v1zmUQqHFUBEWrgA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX7Tug2CjhNXUC
 b+/RUNNYxCmO6mOgcyz+ji8quVAcUfUBSehAI7vdMq9gMsDMNwCijgutWnfDYHFr0Yhv4f4R+L6
 SnhlCW7knm69d166FzcCMc1bC/ZSIKg0UQKuq4ixg9gF/oWXtnI2cq8Gfv5+xTkWGpRp5XvwYO9
 bTt+or7FCBMcBQ+aT0Dth6vWjAujxCqcYTzbjruNmZjFp5eXJgZAQFjOjFi5fZEJt2fnyj+ORXr
 NWWuFGt+ygM9HmMPED8Vlxr6j7nvZ1sKB0wDQK52eDtHMfRUceHFVtNI6BDa9EFddUAhyv6MlfR
 CuXcwV687eloTyBwdbA1aCtVfglO5F9DXcN85lfX4kuaP5h+5L4D6W6stLFol75mvWkl7bw9ZGH
 n9+zTIXEQix++h2Z1CPH49v0Gx3Lmnq0kLsYp+6bzXVE/pqnzm7rBURUQ5PtrRCIF2bRZzk0alU
 1kg3jGUNIqe8iOaKvTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX60HZS5zSPlM4
 vCBBE5B7QEK8HqlxfX+adkZb9H5GH+rc6nOaGrO+nIWNHkeKe6FQ72EAxDhZWnTXW7LNjcgKPxH
 IP8++PzB80ZoM8vQWvu7nq8VtNcNSF8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Instead of skipping tests and not declare them, always declare them and
simply return an exit code 77 (SKIPPED for meson) and print reason why
test is skipped.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 679a69054e4..2bc1fc77775 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -115,11 +115,15 @@ foreach target, plan: tcg_tests
         endforeach
       endif
 
+      # if set, we'll skip test and print the reason
+      skip_test = ''
+
       if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
         continue
       endif
 
       if 'plugin_test' in setup and not get_option('plugins')
+        # do not use the skip_test logic, and simply ignore the test
         continue
       endif
 
@@ -227,6 +231,11 @@ foreach target, plan: tcg_tests
         cmd = [setup['env_var'], cmd]
       endif
 
+      if skip_test != ''
+        # still declare test, but skip it and print reason
+        cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
+      endif
+
       test(test_name, env, args: cmd,
            depends: depends,
            suite: ['tcg', 'tcg-' + target])
-- 
2.47.3


