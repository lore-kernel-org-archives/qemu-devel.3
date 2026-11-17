Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E85606A33E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TOnk4bDE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S2u2N+ML
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTNq3-00056u-FW; Tue, 17 Nov 2026 13:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTNps-000525-85
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:23:16 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTNpp-0003cq-I9
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:23:16 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHGJM9O3327629
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5A+3ksJTNBV0fTs2yihHjyhHRx0x1jmtGt3jdUNcz9Q=; b=TOnk4bDEY3eFPjX+
 PSWY73+mgd5Sl0HjgLvbt3LOuXVhfSg5Z+8XazMeRtHd/vG66rlr23i6cHWjDHL2
 oGK58Vyv/opJX3TRpQj+ajAOiDlmqVZcztKxfU8+qwEnalyErKAKssGG2wLHs5P2
 xR3ZuXr6eZkTq8R9OARoWj6/7PXLBj7/q56La6nGTTTRyifhGP0ylwE2+gwX86QA
 Dw9rvbWQx1gAO4vyJP/8SCiKXtpTihoQtXIPg5Vs0XZQa/8R0RExKj2COarNeQzT
 vjOKLo1CFPCXVt7NXN1NR+UVK+FlYlq2UiXXkz/aFLXeAqT9e329U1wU0VUzlf2y
 6+EWeQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0tbarje3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:23:12 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd60e4e8bc3so99455a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794939792; x=1795544592; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5A+3ksJTNBV0fTs2yihHjyhHRx0x1jmtGt3jdUNcz9Q=;
 b=S2u2N+ML+aqp1+rwUnTFAaZiQl7WADM7OGmpfaviJ08T+UccJXBNYlp4caReVBe8u7
 fKCa+HGrjPgPp1oRmUDUrHEF4lWaINjypfuIOtlImJO6uzISj5vC+198nF20NvA3ZdP5
 phfuxUE4mZqE1dTokiqV3+JTHu7WDzBP7DU3s//kJXLzGGU5t+jTQeoi25o9RkJYJd0h
 qJ6YbMfvwEzaSHQ3gwBoxDJGJMuZ+lzvPx44CTL89N+GWlyD9tiYrYxlwhe3hgFVzn5p
 5zGi4DVvzVbthdB3YM7RUkBMM3osMyqdJLNjak4X+igsLt6BG7TMHr0BZ8aQRxjhKrWq
 Gvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794939792; x=1795544592;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5A+3ksJTNBV0fTs2yihHjyhHRx0x1jmtGt3jdUNcz9Q=;
 b=LEWd7QYKkQCddo6+zTeACUszadpA+yU/YChgPeEBaHA32pqemQbVgxtDTK1RZl9y+g
 k0pslfxi/ChLJ3Ai4VQBx8ksSnK3yRcRX8VelZLbPL63kaYPh39GktITzg9Bglmf89Jr
 zv5l6qb3/q3k/dVMuYK+ZTCNpfnFMm2uyl/9FAr0g+zkZbLTyLI0pcMUCRWfbomWRfBS
 gQqvXs1bNLYC9vQJjW7BCbfOhsVRf3bTuVAsXrj1cIr4xcNMBn8kCxwL4/+PuyqF750w
 sBhzKN6+qSVkdCxIa7LlUGkbG9foI5BKr6efiXiamKelaJtBMdHrT6f4IGemIYTq7fEy
 fTNw==
X-Gm-Message-State: APuU4Z+T5typllyf6eTi3z8ooqErD2FUsqj/b8MCLTRN22t/iCwp/eke
 vmhyuIAzl2/UAX+WVz8U3asuR6aiabotdVCE4xFkCT2pI7ue12Tumoo89QUO4bzNnIlnmvWtp1J
 agpG98zfMsKa4y+5bNdYWkyuNxB4xCLFLPtU4Q66LqW7Io4hQGQ4q3WapeTUjxpgFhQ==
X-Gm-Gg: AZFdTZdoG3R4e68kauGCM8EYvq1oyJ29rVKVT5GCpdFc7MnhuUX/JNTL/P/hievplCf
 wp7PxqhRA87huAoUm/RFZ9ZcLL0R0a99RSVURmrB9dh1lg2BessB2fyQqjmd15cNnqsccKRgptj
 xnvZGB9RFq5fzeMTQHrJpSsqhT3wUEuj+7hnEZAv0LBUMqPgRNSIEHHyHwCdwkr7nBHVEYHgYWZ
 ydX1SNm69nffEzvGa1DeXlzyBSzXtatGPme2o2lIwatmJFj7Xdkhq+HkEGSTWcqmLN/2k1t6drU
 Bp/D8Y8V5RfeXKve56wwlTxkZRj7NLZ0yqbTNE4cdTGI2++bgVrieH5R5hI4/8RkiwTGcxFpDlp
 iuSSDUS0dLXXy+SQoIFM/FsHiLRqTSAFcv1bsBGKTh/eZmIoVfkRYUNN/CNz0+opJvZSIyejOCE
 a8B3aeR8VdaTg7MaRmUkR1BzCGn0unfLhLZkSx
X-Received: by 2002:a17:90b:1c05:b0:3b3:b5b4:e4a9 with SMTP id
 98e67ed59e1d1-3b3d06a57e8mr264079a91.3.1794939791595; 
 Tue, 17 Nov 2026 10:23:11 -0800 (PST)
X-Received: by 2002:a17:90b:1c05:b0:3b3:b5b4:e4a9 with SMTP id
 98e67ed59e1d1-3b3d06a57e8mr264048a91.3.1794939791051; 
 Tue, 17 Nov 2026 10:23:11 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d19a32ccsm68045a91.0.2026.11.17.10.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 10:23:10 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/3] tests/tcg: detect redundant exe_name/test_name
Date: Tue, 17 Nov 2026 11:23:03 -0700
Message-ID: <20261117182304.3261165-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117182304.3261165-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261117182304.3261165-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3MyBTYWx0ZWRfX0581oAdqGWpz
 Nh2sV1hjJ4P9hG2FzzoX0BdQ/EB3NUCuObcFOl1up3yztu5ZWj4oz3rLv69M/WqTJlVoBOau/+k
 QIy9P9oMVYt05RQQYA9jtNmmRPYkvQCxdV9+chjgVlpxs+hA4RSZT+nkt7uF4Wn+OBXEMrMSJen
 R5C/EcXPDVJTxSkBzkfL7K6clC/0zXBUrVhMSG0vYlcA6labgIH7vRaur7SzdMD0P2l+J5ezXlT
 55a+wnrFOgYI57n59cyaSwkbqMtX1nodjSja3iS6DlyiaTLkvmA/x87pd75aEVCoTKXpZSJoeIH
 44ntjB3cxPqdiSbkmwy/MQoLdu+7tQkeAkO8RBB8/PalGqB0suuvzx7p/mw9t3lNW1q5Run7C6f
 rVn0QhLRgCji7REAuf0YgEatItZCiTeh2v7NwxgkGZ+xHLXOYxUp4PzIj014/IRGcD1aj8uZS3i
 50C1dUfubBnIWnQutLQ==
X-Proofpoint-ORIG-GUID: KhLjFxquZy6QzfzOyp3hFJx4eZVLrglq
X-Authority-Analysis: v=2.4 cv=Vsy2kO2n c=1 sm=1 tr=0 ts=6afc9b90 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=zTXboHLKykkbUYI2VpAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: KhLjFxquZy6QzfzOyp3hFJx4eZVLrglq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3MyBTYWx0ZWRfX+oFxbuyZyguc
 Vza+hd9Wt7CQOHTOnkP6cuTQ8AwMa8Gu/Xqj3a5nu2lbTBGUggITk1bSf21u5hJE9gdeVlAmtTy
 WJqpujLTzSSB6EKDkPDQ4Ck19q8LNCM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170073
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With this, we make sure it's not possible to add redundant information
for test definition.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261116232140.2758664-3-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index b61ddf80514..01c0aaf9685 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -356,11 +356,19 @@ foreach target, plan: tcg_tests
       file = files(src)
       exe_name = fs.stem(src)
       if 'exe_name' in setup
+        if exe_name == setup['exe_name']
+          error('test ' + exe_name +
+                ' has "exe_name" that matches default one, please remove it')
+        endif
         exe_name = setup['exe_name']
       endif
 
       test_name = exe_name
       if 'test_name' in setup
+        if test_name == setup['test_name']
+          error('test ' + test_name +
+                ' has "test_name" that matches default one, please remove it')
+        endif
         test_name = setup['test_name']
       endif
       if 'gdb_test' in setup
-- 
2.47.3


