Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6B4CDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsS0-0000fb-Sq; Thu, 25 Jun 2026 18:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcsS0-0000f4-3n
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:21:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcsRx-0001JE-Rj
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:21:35 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFdxwg2160353
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 22:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fpjnokISaspkLyURW/cb1stM82MNs2pYXO5RJwrKBZc=; b=hugYubXEu5GHBTEp
 gYDy0pP+2uu+48xaxkj7tO41ojjNKEZClLLbfDZM2yOSIFGReGFFMA67NJrEFFhF
 zqP/bhw2UPzrKUxf6ZBNZL8HjyNm3D9cxZ09dcafmn5SGZw0460QJtMaYFWzLbY1
 /0PLqbDsoiVFJqDUnUp0qGW5MGTerMk9KjoZ69RDxnV5biAD9A9FpP4iiKtZ8jL+
 YEW5acjUjjjn3OW5msbnabT6aHBliCekaHD62sXZxeZSVksqb3S0yPajGU0waSmk
 kYfvb1QCkd/5jDJmVOkx2OO/TaoryLObis2djPsP2tAaGGf5Vp6hfqiAV3DXeyqf
 D/8ubQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ymv3f91-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 22:21:32 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139553dd8acso56715c88.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782426092; x=1783030892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fpjnokISaspkLyURW/cb1stM82MNs2pYXO5RJwrKBZc=;
 b=aZhaNa+wKiBr1VFPL9UexVGKN24EqdqWjEHiZtHzs4dJRQuVaz+sqLQlEyqc3PpSHm
 4KWn48p0dS3QKZdKEZBlozQ8WRTw4k8lD5gcROCx29mXyHC1BKaaMLE74BI/9yDRI3ZN
 LxEEnfuSc2D52EsAOMppcL78/dSKgAW1a6G6d6GdHKrVz0evKSgYv/w57NoMoyc2occE
 235m5s2IM8kstIMj7mKMBYjlMHIQuRRzGbxG2zhhE3Xux+5nYbQG8kr3CyPBl5/uaexi
 1OFpxuF7PCoUGAGqrTtL1CqDq41vJOWGtwxlOlVL2EjZwzF3YhVp0o1i1lwxJpJSBgky
 7Qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426092; x=1783030892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fpjnokISaspkLyURW/cb1stM82MNs2pYXO5RJwrKBZc=;
 b=dAkvKxE2TXHFHre9Y0X8AdLSQs5T6ipJQZy4qH6uVhigZZHeCCKygD5geUZML9LSCD
 ibIxAUAkk0OcDvJztK9OS0dN1CiWsGqoOxKixpWYDHQeQNtzsL2em2KIH6u95YFn+vIC
 YUH4UDQIXJ3NhWkPmfg/S8Ol9L0yaXLjGn/MKHzmQkwdrL5X6omLemnYbOH7PTPROKFn
 xNpAalfmRYQU9rGAr7xeHsRUcOFP2GqkaGlaJZaYlFb7ulpbK2yDE38NtpoblAid/aQG
 wPuhb1nHBdYQXKQJR4rQRfmoMvvilLYXEOddJ0eHyMAAVHheWlT3nZNxvgxrAEEtpXzt
 WjSw==
X-Gm-Message-State: AOJu0YxYd5QkQPE3chtfg1r8V5anrSoTKELmp5H27oqak5NkBSArs+DR
 7dIixsTTrTF4KIWtJe8mzsjFTemO77e1ybXH/LIeDe885OlEjvIr718J5At3nvZ1G3NV5xtuhag
 8vTS5kF1+fKf5GyQeF+e/MGLaiBMGDbhJlBU5c7y9LrhvImtP4tGAABYH9cJCqnk9dw==
X-Gm-Gg: AfdE7cmesgPE8kdtoVR9CDg8AfmUvmag2jZ4fWp+tVwVvf1eMSYM1ZlK8m5Z6rz3p0K
 3+NhcYTBEVJSrHmbPsxcENIEmTi2zRJqJqsDTDqr//T4GKYm3Q5Cgd+T8D484QWtM4UGVpW3q0j
 S5g0D+ChPJHqLbXkgex9e7txgvu19FSRYJm+gT4inuQlygP379kIc/VapMnyWak5Lb0ynyVgeEy
 tAd7LARmfk9yuxHTuwAFCUJThO6ficPfARSmWe7F2iJbsDhuLN9Y+ZLwWk0slL6jZ4meitcvly0
 9eu/nL8m4mRf+RP+a0orMwPHrok1067JXhlfWwauUuJ3t4+MQQo2+uWFUvN8Xz8TgWQU9Fjdvvc
 M9gIBCqx9iJMqmwVI8XjwCuNKs0ZQVFGqjOWwu1uBBmE12cHdpMEbZN0juL4MRKUZO7nTqsPMvS
 TQjoxpHQ==
X-Received: by 2002:a05:7022:ec89:b0:138:37a4:fcc1 with SMTP id
 a92af1059eb24-139dba1e126mr4574569c88.12.1782426091806; 
 Thu, 25 Jun 2026 15:21:31 -0700 (PDT)
X-Received: by 2002:a05:7022:ec89:b0:138:37a4:fcc1 with SMTP id
 a92af1059eb24-139dba1e126mr4574547c88.12.1782426091237; 
 Thu, 25 Jun 2026 15:21:31 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f318e7sm11538477c88.3.2026.06.25.15.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:21:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/6] gitlab: move .meson_job_template into base.yaml
Date: Thu, 25 Jun 2026 15:21:07 -0700
Message-ID: <20260625222111.1761-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625222111.1761-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260625222111.1761-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DqBmPm/+ c=1 sm=1 tr=0 ts=6a3da9ec cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=29VL0hIdhPriTrIy8fAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX8G+8tshRB0X+
 r9YYlqPEPX8dwa61bA9tACMSgk2knwnDRnLXp/vHGmHpOyfqHYn0ckWk17z8DUpMirz5uKPSrbD
 GvniEbBJIRKZ1OOWDHm4hkYVHxly4zs=
X-Proofpoint-ORIG-GUID: 8iWLLqBOrqHwLWUQWXKxNvZk4TElC5Yl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX7NIhG69WKS0z
 MBB7pcUaD9Zug/OOY+nOltzR+EV9NngR9mgRZre+a5hiB7MmExUyH5FZghXu2I7W4SEUZxDP0Rz
 Sr4wnffpe3LDQOCNSSbadNUtAWW4SOwGyuib/IQwz6OKqod5W8ln9N9zgmAw0r0I5vvbS3Njwz3
 H8hFWpwbEe35DTBFmAvQEr1GYy1XnDkV5BShdlYf04FB+dOBhJEcv4el7EEosffrwmkid52lWCG
 Hv8OPS8kdchIdtoFINJMXPvRiIil/Vw2rCTaBL5x8iGcNPxMEzSvJsPApHdGAB5VTKuKOQACpLj
 N8E1GK9bkewHzJs5laEwf+vQM1IxGfT97P15eOs95Y9nGwHjqVHZItG7ozL6H809WGID8umr454
 qJNleQYWb8q7YEzJY6zSqOeF7e6vm8QMubcipGnzGoy1Gpxtvf9fuZWDBGf+3oV1DKQZKqsfm//
 4kQ7AvUHulhqkg2gkmA==
X-Proofpoint-GUID: 8iWLLqBOrqHwLWUQWXKxNvZk4TElC5Yl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

Rename .meson_job_template to .base_meson_job_template and move
it into base.yml, in prep for wider reuse.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260624124657.2725376-3-berrange@redhat.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .gitlab-ci.d/base.yml               | 14 ++++++++++++++
 .gitlab-ci.d/buildtest-template.yml | 20 +++-----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 714d2ed8a6b..94107579fe3 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -134,3 +134,17 @@ variables:
         QEMU_CI_CONTAINER_TAG: $CI_COMMIT_REF_SLUG
 
     - when: on_success
+
+# Any job running meson should capture meson logs
+# by default. Some jobs might override the artifacts
+# to capture further files
+.base_meson_job_template:
+  extends: .base_job_template
+  artifacts:
+    name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
+    when: always
+    expire_in: 7 days
+    paths:
+      - build/meson-logs
+    reports:
+      junit: build/meson-logs/*.junit.xml
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 005058625eb..0fa2351d877 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -1,20 +1,6 @@
 
-# Any job running meson should capture meson logs
-# by default. Some jobs might override the artifacts
-# to capture further files
-.meson_job_template:
-  extends: .base_job_template
-  artifacts:
-    name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
-    when: always
-    expire_in: 7 days
-    paths:
-      - build/meson-logs
-    reports:
-      junit: build/meson-logs/*.junit.xml
-
 .native_build_job_template:
-  extends: .meson_job_template
+  extends: .base_meson_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   cache:
@@ -75,7 +61,7 @@
       - build/**/*.c.o.d
 
 .common_test_job_template:
-  extends: .meson_job_template
+  extends: .base_meson_job_template
   stage: test
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   script:
@@ -133,7 +119,7 @@
     QEMU_JOB_FUNCTIONAL: 1
 
 .wasm_build_job_template:
-  extends: .meson_job_template
+  extends: .base_meson_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   before_script:
-- 
2.47.3


