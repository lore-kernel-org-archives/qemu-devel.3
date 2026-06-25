Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD5CCDE00C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsS6-0000iD-16; Thu, 25 Jun 2026 18:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcsS4-0000hh-PY
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:21:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcsS2-0001MU-QP
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:21:40 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFdq2f3872213
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 22:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6j1DTm5aR0pAY6j0yRN5Jbnom5C6VnfQNBoX/+MX9BU=; b=T0ozDwquElD4+w/p
 zxHLJF+wGkN6+OW5bYwIvTrWwZdf5wcdqbB9vDf2ajnBiuLjIibfHvFCErdniQrq
 eYtgUcEhvG5HlaMY0O2t9PDvzpfQ1HqjVOi5b4P72TQZqgCL7AY3PtC/HiRsqlj6
 kpRtocZyB1hK935+uaci1DIZ6A+96dWMt7VlUaib66P3A7OCg5HXk/wZOpGfPPr3
 Na7yFb1zjb7j0/HGBYMv3tZPhIEg2EaPGTP3XeCcvR3b398b1Yl1nSqKE20imEb0
 kqoW3GxtF3+I1JxI0Oi/LFe21mChIu4l6X3XmC4viigo6QRcLT1t05AGdkv3HolJ
 i3u+jQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0yynuet3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 22:21:37 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-139ca26403fso732790c88.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782426097; x=1783030897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6j1DTm5aR0pAY6j0yRN5Jbnom5C6VnfQNBoX/+MX9BU=;
 b=J677PVApec/87E1tJ5F2GqnQJJho5sxM4qVagCqCu3PCgPHkYKasSvX09D5AV5rKA0
 LL+kTP1UQ8Q1bJWQqsNI/gr1J3Q/tEYnQ+2X+7cLCXoNGij0BV67NaixcDmwwZrTKPlw
 DXkpniulmSiQ00kKMqarJ4ttL6OMbS6wUhgYZJTfuBK0gHiuplUEvorZr5pb0Fwi3XlN
 5XsuTVYb+3TnDIH+qQX6jLiUCrxJH/uuMKLCQ6RQo+33AZ9MVk2OR4y+fkRyN9Ksh+R/
 lFrJYodWRKvZWkwZSDVwRhv1glZl2ZmhrU6q+w2MIQpImWXSu9xFW+MY1a0q2V2DU472
 SYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426097; x=1783030897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6j1DTm5aR0pAY6j0yRN5Jbnom5C6VnfQNBoX/+MX9BU=;
 b=erhdYUdCR6tos/g3+OP2AhKiLnGWHdeFuXig4wltNSbiBc9UygR0zKRFUPsP9w8Qe8
 ZyBX+4j/OUWFWxs9wSlm++w1Hdq7Xdn0s0X6OXOdMS+gzrWzW81xJHf/zAe1HLDOiQbH
 qzqRNTrTp3zFIZCRcHqMN/k28iaqgtAWWcn2T3tbkpNnEtggBx3q9FugUWgQqxFMh69u
 CWDaKkJ+GvxlgTEBSQB5SFKDa7sppDvhCfPfpQe4zVBf/imBwFmjkGcmHJO4Gqu8dNqp
 ESuqr4vby9B55gXA0kKvUKzvcDUE7/K6eWRXSwX0EITpaPpB7tKLxrqMd77+bFgsa5WL
 W57A==
X-Gm-Message-State: AOJu0YydvKk+KDjHYznHCSIOyZaWwXTrkjVGWghVAiF+enbaaofxhHgI
 JiKZKX3oN8gi6KBhj2doNUNCiY2uRlJvZyNgB3r2EK9+jjQdWlwY0gm5S9RLvIFHL7pB/GxmAss
 cAvktj+b8I2DBxvFibULm7H1r/4E2fyoaxeWcyqIHTv3uWfDjpRTrBg6L3GHxbLb1Qg==
X-Gm-Gg: AfdE7ckl6SBvU5DUVNS6RB8g1mOgBVhjqEY/3GDNPm3mHQovwg6fX+pbyDGHa5b6lzb
 Bk6OAeMo4EKuPHf0hC1rWD4/nQaDynBvRxmy0UU6SJUkrs4+bkeThZjIvVV7Wec2s5C2SGvdJK/
 JJLXKmRDOZC8JzorYp1vJ11iUrHn1el9Rh+I2yhoPZKqHUsTJyTGUnMKvwQaS67HTAYdoj7HXoz
 PhfrI5Q+rlbXJG7CyVA6D+kYGSBoyA6b7b1xe15nY47KwbhjxA3wRQgbe4FLXHrQKt7qT45NH3a
 TeV9hl6uy9SX4ns3OKJAXEiY+MQXCbxuUqZv2qz/4dkAKFhEJtDMOL4as4XhrgwfDGA6H6uiPzF
 T2srBmgN+cOTfRR/zoF5W3HUUDXsZFkeA0sFvZ/WWGudTBD0xPI2LhiLPtQpLaEmdGQ+PvDhG9X
 o8xLbTTw==
X-Received: by 2002:a05:7023:b0b:b0:138:4e43:6399 with SMTP id
 a92af1059eb24-139dba390d3mr3712827c88.11.1782426096782; 
 Thu, 25 Jun 2026 15:21:36 -0700 (PDT)
X-Received: by 2002:a05:7023:b0b:b0:138:4e43:6399 with SMTP id
 a92af1059eb24-139dba390d3mr3712807c88.11.1782426096266; 
 Thu, 25 Jun 2026 15:21:36 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f318e7sm11538477c88.3.2026.06.25.15.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:21:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 6/6] gitlab: greatly expand captured info about CI runner
 environment
Date: Thu, 25 Jun 2026 15:21:11 -0700
Message-ID: <20260625222111.1761-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625222111.1761-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260625222111.1761-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX0hMlFQN7dQTc
 pmyqhGEapXWeqLi5oEQuOHSD8dJx6lB53NM6PlM7kwNvEBmdPM4GKrV88V5Y8r/Yj6RdoYkYYcr
 DK2C3MeG4juaAdX79OzhimQCzg65xCG4HkuGuXATWWugpUP8aO62tMHZe9yl6TUoEXBfSW03r3n
 SXTzSkFSo2BDWV4pxVgvlMSqd65RXUlVycNlg42dHp87I/iMv0/exEyXNBlpyl1EaFNCEjohdsz
 IapMpBCAboXCdDWVItUAzp3e5YWOEz87hTzN6wAeOuMpijVRQTXAdvkVesfMMC2prrvrHKAMtGq
 gH+r3lpc+JrR/kTZMiw8yrDxzTZyKIf5AAYfrYYUIvtoQEj3TW3oSQB1NCUaSoyygeCuutvxrFQ
 6jzCdSugqjypxDAKN39TFYtt0/vm52VX/CosD3iHh+jcmO7LXRa2259qaOBaOK6s/1yac5VnKss
 ZmGCRYIPN6EYMq39CUQ==
X-Authority-Analysis: v=2.4 cv=aoyCzyZV c=1 sm=1 tr=0 ts=6a3da9f1 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ZzUb408nXwOd_ZFe-RQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: K6AxXdD0_3Ib6C3PtHV7nOOz-u1oY5SU
X-Proofpoint-GUID: K6AxXdD0_3Ib6C3PtHV7nOOz-u1oY5SU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfXzkyOU/byOXFc
 JbZ2ymE2RhrxAvXW9JmqMVCbQ4CS67KPjcvdZRlUWQglvyGNEUJdcB4e1hJrVpNI1B8coXjk1xO
 1BXJj/ZYWql8Jg4gsUEwZtTPpm4p9f0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250193
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

To aid in debugging wierd CI failures we need greater information
about the CI runner environment. It is usually container based
and can have some unexpected characteristics that significantly
differ from a developer's local environment.

This captures the mount list, CPU model, memory information,
device node lists, kernel info, user identity and all environment
variables.

Since this information can get quite large it is not emitted
directly in the logs, rather it is exposed in job artifacts
under the "ci-runner-env" directory.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260624124657.2725376-7-berrange@redhat.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .gitlab-ci.d/base.yml               | 11 ++++++++++-
 .gitlab-ci.d/buildtest-template.yml |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index fa0ca940481..8fe00809357 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -146,6 +146,7 @@ variables:
     expire_in: 7 days
     paths:
       - build/meson-logs
+      - ci-runner-env
     reports:
       junit: build/meson-logs/*.junit.xml
   before_script:
@@ -155,7 +156,15 @@ variables:
     # Prevent logs (if any) from prior build job artifacts
     # from being duplicated in the new job artifacts
     - rm -f build/meson-logs/*
-    - test -f /packages.txt && cat /packages.txt
+    - mkdir -p ci-runner-env
+    - test -f /packages.txt && cp /packages.txt ci-runner-env/packages.txt
+    - cp /proc/mounts ci-runner-env/mounts.txt
+    - cp /proc/cpuinfo ci-runner-env/cpuinfo.txt
+    - cp /proc/meminfo ci-runner-env/meminfo.txt
+    - ls -l /dev > ci-runner-env/devices.txt
+    - uname -a > ci-runner-env/kernel.txt
+    - id -a > ci-runner-env/user.txt
+    - printenv | sort > ci-runner-env/environ.txt
     - section_end setup
 
 .base_meson_ccache_job_template:
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 11d7a756678..e62b3f21239 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -38,6 +38,7 @@
     paths:
       - build
       - .git-submodule-status
+      - ci-runner-env
     exclude:
       - build/**/*.p
       - build/**/*.a.p
@@ -83,6 +84,7 @@
     paths:
       - build/meson-logs
       - build/tests/functional/*/*/*.log
+      - ci-runner-env
     reports:
       junit: build/meson-logs/*.junit.xml
   after_script:
-- 
2.47.3


