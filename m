Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F08BCD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc4fJ-0005Ee-JT; Tue, 23 Jun 2026 13:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wc4fD-0005E4-LJ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:11:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wc4fB-0004ie-F6
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:11:55 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBZsWg4053144
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yN44TcWdZRN92Ft2TQTS0iHWagJ6OjygZsT7PM1CrJk=; b=mSKXAk7Ycx5aR24d
 X2HV4O5mCfX6PZUxFxacpM97tsoS+Ep9Pzmwupj83DCncXsb5J53sHyTlvSLbb4D
 iskXpJA5zsDbKHv1ge2VC6Bdiixlu+QkcJPyAfpwPo4lgs7mJxvOjRkqljT1mDUC
 Yozt6jBR9ulVDPm7fiYHKKChxtJWijlIXt/POj1qWm0+7VjSIFB8GTAMMkeN1scd
 EXh8gT+ADNosc0RnYy51apVtoNEx3WrKSlXa1o9ba1lcqRBm3gQIHjLUXtRGAtlY
 O131IDTGGZbHZOqTBUaeTK0uicdDjRW1zaZzKp0Ah8+aRzBephKVNwmPCbnjp2qn
 bXUWPQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr9yspqe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:11:49 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so127777eec.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 10:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782234708; x=1782839508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yN44TcWdZRN92Ft2TQTS0iHWagJ6OjygZsT7PM1CrJk=;
 b=CBeL3C1dzPg1AuBZZ1PQ3Cio/QOR/ci9pmUP41wQ/vOaDWx5sn6/dd3679p48Et2Eg
 tLNV7aYIAbYsEY1VsK9gMwX2IhmNhopqZo3anpLr/MR7E2ic5ay2rkE/foPwaKG0Az8O
 5wwz1woPbL9UeDwvslR4eV7QSNHAAZuFIdU1hZNU1jptVzhH7oPN6nnB3HZtJKev5K89
 cojlddcDMWYRkswDYXeceCOK771vZJ7Vkpf9gvBJf1fqD+60lfvLPRFvJ+MVDmG4lt2w
 jBVFlIoEwPz/4E/yBDreE5i4LjR5mEr+wq9dUR0H7TaJP07lG4mYPJQB6MAiliiP1ZQh
 +0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782234708; x=1782839508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yN44TcWdZRN92Ft2TQTS0iHWagJ6OjygZsT7PM1CrJk=;
 b=QeK+psJ+nqSbbmteml1QTNMuX4LDSQKqLfRsZtOjR5+7HntjsaP0kGQJ39HStYwGmF
 TADEgiEn2b/BEZepw6H2sqfZJ9CTzDocFg9TOf/uW9LlBGMRsupdVoV8aeKCsko9FH++
 rS2gyRz1pk5DoQq6ab5vI8BAbEwyVmBUEqiDfiokyBalXMggvDiXxXOKoTq6pSx1nBpx
 sM3KB9Hnm2AOg6tbC+67IFVbRAakPk21T4BJSJnJBQGoNAQsKhcTeKA1wtaFfpcK0Yuc
 gcVXO7cbL1DU1dNdxepjDCtsRBaIUX5ToPzduGTt7Xw/1uzzDyj5M1W/wHersQePzahV
 b31w==
X-Gm-Message-State: AOJu0YwSNq5VPB+ypwaP2Tj7eGJL8gMctwkQehGYhiUvjY0oGIwQMg5s
 otb7XXfJOEBLwitmTzUKmGq1tBtDcB/DlBBZ7KF0E73Yx7AhiCoQljXJ51hXOi7xXw4lM3MOnKM
 lPwdB4PG1sY5TSzLBHo/oXFghcOubR5Y0bg/cjzmzbjZxPitGiDPRXigUoQ0ZDe5qdA==
X-Gm-Gg: AfdE7cmU5r8SW9z6PweTN4wiGAp/MRMHrjENGrmj2ZF9fcAWMrtUsZsdOFUIPxewZp1
 OOCeeRnweDNhv8eQE5pjqq/UlDwJkbSe1D1bCsRSmHwoKCl12ORkOYIj3lML1/H2egwVljXmuJY
 9MMzkCPonRJ7DoP7CFapHzMIZFqkUOugCUVOZPRIk3Vi10KisSctMJHMDkWv8OqXnZNGIcKrbju
 8CgLt0Dnfsi2OgbOnPx6HIx4qnKjFnThve++4GQzzvvGWd2wS+YKQAz2pH0egyeuC4T9/U02YwU
 HuhLurDJmYfDEVemOASrX/i/T4p3tVgWde5hJhGCnJj/yzdQ8DUnt4jdH+iHPojvJtE5Ivwd+cz
 LhM3VUddd9horLz8AofLKlrBc2PO1Sr5YK6lVmgROIcG9879MilMpwIjX/MvjGC4kNS/SYgOgkB
 SwQDl9xA==
X-Received: by 2002:a05:7300:5411:b0:30c:53bb:ca17 with SMTP id
 5a478bee46e88-30c53bbe778mr5323477eec.23.1782234707918; 
 Tue, 23 Jun 2026 10:11:47 -0700 (PDT)
X-Received: by 2002:a05:7300:5411:b0:30c:53bb:ca17 with SMTP id
 5a478bee46e88-30c53bbe778mr5323418eec.23.1782234707236; 
 Tue, 23 Jun 2026 10:11:47 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba5c25csm18186385eec.8.2026.06.23.10.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 10:11:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/1] gitlab: disable macOS jobs in forks
Date: Tue, 23 Jun 2026 10:11:37 -0700
Message-ID: <20260623171137.1847038-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623171137.1847038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260623171137.1847038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JYSMa0KV c=1 sm=1 tr=0 ts=6a3abe55 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8
 a=BjYdUU1l7qfxFpQLjp0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: zIUw79iZ9GqqGh9bsZv2h4dyV15HHynq
X-Proofpoint-ORIG-GUID: zIUw79iZ9GqqGh9bsZv2h4dyV15HHynq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE0MSBTYWx0ZWRfXxSIxCmSBYxzn
 LfuCQ/yvScbDWrFD7mFLFdoU6oj6HrG/EqWSFozVV+jhAya9EW8A2qKW8BBZPRkXJxdjZn5en9S
 hIIMH9kNoxKo6x+GVsa/B4BhYqTBkYDPcym7Rbw3Q3nqQl/+0zT3kxmHx4vhH+XBPnZ/AvSFhET
 mdx7CZwbRBZIAKmWJejyWXY8lNAO6tsVikgMR1naQf5b6PCoNQh9fvATFQgVKVG6CfRuAk8t/V6
 sqHfCxuv4xj8RxXMPIlZpcdE8ywWAdR6LHc5stx3x243ycqhHZdKCw+S8nC3uZPbTZ9htn8IU/g
 EbhzOKzxiDOrIS7rw2Ei7RNe4gWbcQ9HscnTRhBVVxNMVYDpTjamnoz3/npNiGU1MmBppz4/Izp
 5VS7FaIU9II/sUyxUGQgJKDeMwBuBE6BB2lGzGwiWdd5onzlZDxI61kvnSNwZlnDYiCwnGqETNA
 SzVGc0SnhOzbr70WNbg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE0MSBTYWx0ZWRfXxtXzfuyqXx8y
 BiE0OVm3O8pBU5vpeDOVKrGQ8n9QzGzjlSsHvtk2d8QCnxZDAFOc5j9ajsBFQRJoeYq6wsSy8ad
 2YN+/BA/1WBWLdLdP8ns8G7IMOdwfFI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230141
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

From: Daniel P. Berrangé <berrange@redhat.com>

The GitLab macOS runners are only available in Premium and Ultimate
tier projects. This permits their use in QEMU upstream via the OSS
Program membership perk, but this does not extend to forks of QEMU.
The macOS jobs thus need to be disabled in forks, otherwise all
pipelines will immediately report a failure due to inability to
access a runner.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260610091700.2772973-1-berrange@redhat.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .gitlab-ci.d/base.yml              | 5 +++++
 .gitlab-ci.d/macos.yml             | 2 ++
 docs/devel/testing/ci-jobs.rst.inc | 7 +++++++
 3 files changed, 14 insertions(+)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 72eadc80733..714d2ed8a6b 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -52,6 +52,11 @@ variables:
     - if: '$CI_PIPELINE_SOURCE == "schedule"'
       when: never
 
+    # macOS jobs can't run in forks until gitlab opens up runner availability
+    # to all tiers https://gitlab.com/groups/gitlab-org/-/work_items/8267
+    - if: '$QEMU_JOB_MACOS == "1" && $CI_PROJECT_NAMESPACE != $QEMU_CI_UPSTREAM'
+      when: never
+
     # Publishing jobs should only run on the default branch in upstream
     - if: '$QEMU_JOB_PUBLISH == "1" && $CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_BRANCH != $CI_DEFAULT_BRANCH'
       when: never
diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index 8366b4ad564..84ad2492ca8 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -36,6 +36,7 @@ aarch64-macos-15-build:
   extends: .macos_job_template
   image: macos-15-xcode-16
   variables:
+    QEMU_JOB_MACOS: 1
     NAME: macos-15
     PATH_EXTRA: /opt/homebrew/gettext/bin
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
@@ -52,6 +53,7 @@ aarch64-macos-26-build:
   extends: .macos_job_template
   image: macos-26-xcode-26
   variables:
+    QEMU_JOB_MACOS: 1
     NAME: macos-26
     DYLD_LIBRARY_PATH: /opt/homebrew/opt/expat/lib/
     PATH_EXTRA: /opt/homebrew/gettext/bin
diff --git a/docs/devel/testing/ci-jobs.rst.inc b/docs/devel/testing/ci-jobs.rst.inc
index d5b081978a4..d747a7ad137 100644
--- a/docs/devel/testing/ci-jobs.rst.inc
+++ b/docs/devel/testing/ci-jobs.rst.inc
@@ -125,6 +125,13 @@ QEMU_JOB_FUNCTIONAL
 
 The job runs the functional test suite
 
+QEMU_JOB_MACOS
+~~~~~~~~~~~~~~
+
+The job requires access to the macOS shared runners, which are
+only available to Premium/Ultimate tiers. This includes OSS project
+members, but not forks.
+
 Contributor controlled runtime variables
 ----------------------------------------
 
-- 
2.47.3


