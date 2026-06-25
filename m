Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A82CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsS1-0000fu-8Q; Thu, 25 Jun 2026 18:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcsRz-0000ew-V2
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:21:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcsRw-0001J5-ON
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:21:35 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PJkKJE2808638
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 22:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DO0AXk79K2EOyBg8BS1EAEZqySPI1beHPa9wUzOFieg=; b=cXmM/Zz2CiWonlZE
 y90l4vxRJWF/xN57r5f218EmVmQi+pbknnU3lR/yHmnaThsZMJecF/AoSCCz/gV1
 FVr7xUUZ7AkMhlAJvER/QuHHCK14PNrxLMnjcg0uwZITU9Rx4/Oh50FzCo+kNQSV
 K7f+D4oSVd8ntmJ8MNOzXBGmaF4H0AjXqZLjubGxbFtmh8GqQqbAKkG1oKWC3QYE
 pMd5DtEeOovo1OPpOQeYvLbMKM5cNW+JrKYhZaUdVi0ywk15IGQxMcV8wo6T8Cya
 ZJvT3bQCYnF6X5GzdjTL0k4O7ZNtGfusf+Qun7aZaOMNPJ2tCocLGmH9FgzMtXpQ
 IPCQEg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1asj8ehv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 22:21:31 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1384427c3efso1820650c88.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782426090; x=1783030890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DO0AXk79K2EOyBg8BS1EAEZqySPI1beHPa9wUzOFieg=;
 b=NRjxH9CjuK5tuZN1WppnMgHMvwEAWFwIxfJsNu+UH54ne3EAicctoYbH2BXof11bpT
 EVsZX4eWT/SBGrPB1TMeuqD1cK1eI6p+yfQdlCviZBa3ISuZT3D3rEGSPN4wHPkFTpKA
 bF/3q2W7baV59lb2IcVvCaNRaOUfAlvONWPh6AoNcQaHgPNJgEk6TODIaGRaoJB1kyIr
 PUKo/+Qcian2IO25EzZuZi1yLPL4glRLjwBXrW5SBofN5ovPgs9yZFp+/H0/4FqOjXVG
 fUV1f39Ht6Fd8s3rDaglrbGO11AU0D4EltiFuBt4a0mSgAuT7vwRbJ3uf+5hUbd0/1Vc
 XKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426090; x=1783030890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DO0AXk79K2EOyBg8BS1EAEZqySPI1beHPa9wUzOFieg=;
 b=eF3YksjZVEgYC51I4iSJb8eydkTOveuq/7jZSVtWplx/K9SlzTfD3fzbLdlQQvkQVR
 gy9HfCtOFPGqIoGSYJlq796+yFF9M4UL1xgMi06UBXZZz48XiGstPhbc5ay6zNZ7EfNm
 UPUiBWEd3rtoDtSzaznb4dnUTOlRPcRn2uQ82cp4yH5iz9o8DFiKmgCFAo3AU1MS1Roh
 Xc4FIokqpr0REbsUmdPBVHgGtIgsWrkxzhItLZSgbvKD+opgM1cdJE7ZzAbjHUIwszfW
 aTPpnIFvi6QIFu1l4BJBjjVcrJu9qiLOiUlI8b1I499gYWE+8RVz7HeVFWdchluF6Fs9
 JSBw==
X-Gm-Message-State: AOJu0Ywq7P1CMxMXpndwYQDb+tLdIcdOfWYHAXCCc1Vbew30qC4d98YA
 K2B/8lH6LgIjz47SCpoQ38EXLO7hvw4wf0WaOFOj7au4I7esNH6fJX2IyHMY045wedyCKcEbgxS
 O/uieSg7epq2+3fCZtwD5AtneDBWAOoJBzwGYTvMKxrz1cgfX30Ez42iHJ6wLwzyfLw==
X-Gm-Gg: AfdE7cn2R+jAj30NnIhvSVhRnONckL37mADCZfp5ivzL+v2PX00lS45ebucciyx81IZ
 NOvIN/CZdi0PU25qcQ2KyPli/JbXis2HV7uAKRgnZYTMlnTIUuv7Fvp4sQauXVPZXuJEreV93ZW
 RT79bry7ToOrkgQp3HUP7ilZkHtxwmu6a01ETX5Te2l95t703F0lvrJoJQl7eP1yF0wAiaehqME
 CtRNKwq2iN7L99nbDb4RUz9zK+kYPIEvQ3cxt8wDwiwtlrqoRnosCR3OLVyOIi6Uff13t6QZ6NX
 BjAX7o0rJr8oTU6WBs4yWgkQwuaNn+n8MlLqI8W7kMEJaVJhO3oXmZzGJwj9SN7c5bfJBY7chDO
 YiBRYv/5nribi2E6qSREIgt+xaU/RsvSiNpm1/yHhnw6jXVYirU5MDhSRt8nq9GEcNHzmc2xKon
 wWZl2Vug==
X-Received: by 2002:a05:7022:eacb:b0:137:c0a7:8d01 with SMTP id
 a92af1059eb24-139dbb5b05dmr3569839c88.23.1782426090397; 
 Thu, 25 Jun 2026 15:21:30 -0700 (PDT)
X-Received: by 2002:a05:7022:eacb:b0:137:c0a7:8d01 with SMTP id
 a92af1059eb24-139dbb5b05dmr3569821c88.23.1782426089801; 
 Thu, 25 Jun 2026 15:21:29 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f318e7sm11538477c88.3.2026.06.25.15.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:21:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/6] gitlab: remove unused .cross_test_artifacts template
Date: Thu, 25 Jun 2026 15:21:06 -0700
Message-ID: <20260625222111.1761-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625222111.1761-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260625222111.1761-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TO11jVla c=1 sm=1 tr=0 ts=6a3da9eb cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=6JbnKxEl2cEP0CV1l5oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 55XB2QBmW7LG1gzjzRMZwU6kYQ9vrrsV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfXz6XgovMIOcIL
 w8s71QRScJTAEE0l121LgxLaAVyuQ5iOL1ElWkV1uFECzz/r1X1YOOf9ZTfIGmGjcKeLvaLxljw
 Q1lAZuxgtw+zDWHGQ/mNnzT3VCxNVTU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX0gzOhgzrmUHy
 Y6Qqif//QdmS5o1PpHkUhBu8RHaxgDMgrdyNkkvv/6rc+JydUaHNlAsl06e5+5Q5OGHL4glp1Ep
 gnzaJkvXrGwU70PEXqd+ja06CyWs3xrJa5rxo713DZU/1Au1m96AY/R/YOYCJzlE/5mamMMFnsh
 k+tEtBRxIBu6QcMLsqK8ir9++dmruAK9MJD0zQdQJd8/Yktxa+oxdFF4QNPtq0jG6nw2iqFbg+S
 XY1TRkKZLRLj9BzyRdNCGVy3Zw8girDCrCV0PRbkfdAOn+H7c0Gm8LdGzaPXpq/RdkqzojNDkCe
 U9jSGknI1t9AvAm8h2lNRlDv5WQ/ff/OEDZ/XF9VkX04xRpQLBe51i/u5bI49kRdNBIZ+pZm2T5
 Z1y2J2N8wTQ30oyfF0bAn6Zpq6wEDLw7w5g9uJaf/npEiilUHShMsLH4glZpc8mTJ3AtzSQ0Ot3
 7bUOot/0ICtdGH140SQ==
X-Proofpoint-GUID: 55XB2QBmW7LG1gzjzRMZwU6kYQ9vrrsV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250193
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

This is unused since

  commit 0d1137550bbf3af7ebe34801a9bff5a4839cc34e
  Author: Richard Henderson <richard.henderson@linaro.org>
  Date:   Thu Dec 18 09:58:33 2025 +1100

    gitlab: Remove 32-bit host testing

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260624124657.2725376-2-berrange@redhat.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .gitlab-ci.d/crossbuild-template.yml | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index 58136d06e4a..786c5cdb88f 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -119,15 +119,3 @@
         $MAKE -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
     - section_end test
-
-# We can still run some tests on some of our cross build jobs. They can add this
-# template to their extends to save the build logs and test results
-.cross_test_artifacts:
-  artifacts:
-    name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
-    when: always
-    expire_in: 7 days
-    paths:
-      - build/meson-logs
-    reports:
-      junit: build/meson-logs/*.junit.xml
-- 
2.47.3


