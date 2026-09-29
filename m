Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0B0CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBcdx-0006DX-6g; Tue, 29 Sep 2026 14:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBcdw-0006DP-Am
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:33:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBcdu-00016s-SR
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:33:32 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TE5oRU128890
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 18:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=5oLlRzj/TbQimE+rHQWjBYQz4uWOutEaxv4
 9UzrMkVA=; b=APB41nib8cTQtK6MPBiLwHIViGDSFnkQnfXGoGgNcc4YjMM6FZR
 cUI20MPv5EUlF+rfZofiqNSqMD4MYSsWXQ7+wd3AKqHjiPp+cexBZcdypkb3N5w5
 0J2tX5JbWOnu2NICRWygQh/9wxQm+d5eYNIW20UnWBkxVle4BE5BonDiNRNHlmNa
 L2omPofDyjEaF6mQCDvZsMVSDJL8OJBKK0X7AC4V9i5JNXj76LbREv4oW+DIg85n
 ULeKYh1nrSnBaT5we4xS9vTOcQ5bqxAfE6HasbMp1pkdAwd03/ampN35EKRqQeMA
 m0K8DGTz8IxVR9ZgNLuLkdG6cYn0UrwGfoQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0eswh91d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 18:33:28 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc72777faa2so2553421a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790706808; x=1791311608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5oLlRzj/TbQimE+rHQWjBYQz4uWOutEaxv49UzrMkVA=;
 b=g06aVI8L8FwqRh3uHNCzplmpJgKhPZnJJwcsxon2hf8593gDDe8aSzWFrJ8pdIs0xn
 jVHiG9L2HnNRXqKCvJ4ruqZAndD9A/6p/jON+/69+Cln9q93+aQlxJO7MNZmcTuc/d87
 tH1VzMdfEJgjU8ALD156Pz6rmSU7VsHfN3YLxkr/4B8MabkWc2wj+fLnv8WOvlwogEl5
 OsAsQUf6ZU43EQF4c9i2o21vDI8NzIxixmvoWPnOQLagC3HhN375fg/RZu/VXS47GAMc
 YH0lAJ+UVce78h2dF/NLo6Rw1CFtjeBiHG+SWvR3bleieL/o8Fa5Cva+twdM61MzQY5+
 g+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790706808; x=1791311608;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5oLlRzj/TbQimE+rHQWjBYQz4uWOutEaxv49UzrMkVA=;
 b=PzvWG6J8cpJ1SpWh8CKbgdslikilJhs0TytXJIGn0f6FNOq/Dh45Fdnn8levZZ5Qf2
 Z1W7KJgN6CuyW3lG3sPn5KapUBAZ9LLs30K8ijoZLubfIHCQdv4EwMmBeVvB9Du5vW4m
 AgRBVlB1WkXbCLYJtVmojHvWLmYSP98Lz+8Y6hRAOGjhdaH6L1rJr5TS7lSQMGVuj5PU
 vqB+/8FmhN6/3brURhQc6VSGibhK1LL666GVg60/ZNDKrVt+kv72HDZfLYEENS5Nz5Do
 F9bb8/vSkuZPu6Dzi51K2urym9v1NIt+UXmF/5fiDUFZ4lPtw/I2COfpj8ft7oiukJjN
 QTkQ==
X-Gm-Message-State: AFuF++k0xsXCOZABJIisaB1qXu7D01WoyMBhI5KtoxQknZYfaIMfaAGP
 bDlCZaNhC+e8M23KMKEO62CE7aEN+aVXyvq2L6c5LwHJNbXffwiqsFI97K4guQMnnpOViSXI0fp
 pHL4RSrKBxIioQKjyYMd71AGsEUYq+ujHBiEviyR91AWEMuxEsXLdlgJnt8XuEXQa5Q==
X-Gm-Gg: AYBFou2GG8rnjo9u6rkHuAXrjDl2yfj0T+RHcVAcAhs+kuOXRFFTmNSqZc1irjg7iU3
 Fig0UOMevWLXa+8LgpN3fugqwNXgOP+5urPsxsAmRRmMaADz1DiIeyqy3tisSeEHYsvdHydcU8A
 8cNrW2W+d47dD1uUiAECP1sE7+T2TUa6XkPBEojVbrIWdcLL0QfO9ZyPiOjvKF2hzD+V5vglc/9
 n7lqSdafNQo2Tld371IAzLZ4MFFRzcWKSceFGOtReBqHPIhqU5oRlISiB5VszR+8cWiemMTiVjn
 +BUVVky945DjcPCi05lek9NLQ6or55kGQK+gGGMZClyUh8mGiAaOXqQgU+BSj5XpWmtm1cbCbxN
 CNVtTPuQnzAD7egPbNvEk4JbmUBiSZLf8Gl25oqy5gSzDK/um4se+GcvbdTcu6J4=
X-Received: by 2002:a05:6a21:398b:b0:3de:46cc:b637 with SMTP id
 adf61e73a8af0-3de46ccb8acmr8457755637.64.1790706808305; 
 Tue, 29 Sep 2026 11:33:28 -0700 (PDT)
X-Received: by 2002:a05:6a21:398b:b0:3de:46cc:b637 with SMTP id
 adf61e73a8af0-3de46ccb8acmr8457738637.64.1790706807830; 
 Tue, 29 Sep 2026 11:33:27 -0700 (PDT)
Received: from localhost.localdomain (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc7d2b562d8sm261100a12.24.2026.09.29.11.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 11:33:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] ci: add multi-target job
Date: Tue, 29 Sep 2026 18:33:20 +0000
Message-ID: <20260929183320.2960-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA3MyBTYWx0ZWRfX3jFjOjqdvRmO
 5AuAo22g7cTKQhceVp/lFfUwOp/0I9tdBNfsAGRLiX5Gsiuq5/Urq6DqP6s4xqCFyq+xmdbWFlQ
 O5d/6V9JKpAOxC5PLORxd9OVYZuNq7WBcOtglio+eb0euFqEwZ86ivFhb5aivhsQZhaPE8d3BvB
 uzg27FfLQvcRdoGPnDzB3pLQX6c5E+kS7OUNv00+HKfAhbeUEv7S9LkZHPbqdaqPvwhfO6AjbMa
 /4T7YBpMoxinF9eH7wraS3VZBY2Gnv35IIcvm1MUO/IE1Y91kwwVlpXvQzg7cGBBSc+oz5GtVWV
 xRkz4OSptuiDeHawXUZ3dp52Tvdyq4JNvof+yLGEbu9+Q6uviEw3/263M3/2iubQ8WSxjf6kDYV
 oXTwvrnxWOPk7KC3RBDhVIR2s0UfPjrdor7bW9Sa8FS7PVtdr0Tdug7gQoP/b/XE0GErUxZA2GN
 y5ZmFgnLm8gVz20I2Rg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA3MyBTYWx0ZWRfXzP2qVLcWK9Vc
 u2DVM0yK6lOuYMcbFxr4b94MLIKHZh0BDSh28cd/wAOsJwFVqHj+TIZkdcsV/PTSlV5Iwlc1AtU
 RF1ueoH6yo37cZMD4fEKjDLLA1NV/Pc=
X-Authority-Analysis: v=2.4 cv=LaWpeTfi c=1 sm=1 tr=0 ts=6abc0479 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=0YY1nSzvyr8hLm4aTogA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: ViBL2OghdoaXISr9GpATS-T2MKjHiTYL
X-Proofpoint-ORIG-GUID: ViBL2OghdoaXISr9GpATS-T2MKjHiTYL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290073
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

This check ensures we don't bring regression for all targets that can be
linked together by building multi-target test. Also, running it ensure
all QOM types are unique.

All compatible targets are automatically detected, so they don't need to
be fed to ./configure.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .gitlab-ci.d/buildtest.yml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index a97cc0b20b8..b1e95395d0c 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -659,6 +659,17 @@ build-tci:
       done
     - make check-tcg
 
+multi-target:
+  extends: .native_build_job_template
+  needs:
+    - job: amd64-debian-container
+  variables:
+    IMAGE: debian
+  script:
+    - ./configure
+    - make -C build tests/unit/test-multi-target
+    - ./build/tests/unit/test-multi-target
+
 # Check our reduced build configurations
 build-without-defaults:
   extends: .native_build_job_template
-- 
2.43.0


