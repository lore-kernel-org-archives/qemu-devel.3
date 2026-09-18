Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19687C982DF
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 19:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7eKl-0000It-3T; Fri, 18 Sep 2026 15:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7eKi-0000II-UF
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:33:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7eKg-0007Oy-2E
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:33:16 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGnqYx508145
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 19:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=5ZFVoDU+7DCrBGh4TFzKLmWeRmxboVUz8am
 jMWfsDHk=; b=cYFYpTSAi4AvI8xZWoMapSB25oYcd9hz6uevLJ8Fod7SY7rF3wE
 633jc42trp+YhCmuE3mPNWG2rI8d5SOfcZMC9b7OpOH7cg5/c3eFdN2VlxNg9hel
 4BppDmNoaF2217k2XTZjWRtb1ZLr61vDMCx6geidTlrGxheyuhK9Fjb46rKFQ+kB
 gSYDD2Va7t5+a8aLfAiSLCTuIH1mHSfCP4jJ059C2Qfgin+i8CBdtyWfkAg93iQL
 E0Zt2L7o5lgIif2yiNtWJ1UAmJEC9m8yo8uZ8UYdYcWtcjTdf5cPErqUEWfaXTd0
 s19QG1MPGZrj5KUKAf7jYg8OF3Ww83gF/Pw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs84a10yn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 19:33:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2db3b126c9fso14910695ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 12:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789759991; x=1790364791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5ZFVoDU+7DCrBGh4TFzKLmWeRmxboVUz8amjMWfsDHk=;
 b=ilZVMdPN6uaJay913gudiEprRJ1+p9wtIddFQbj2Axen9jD5cTWP1qowUeBbTI8vK4
 BxbRM1AvPmBMT3maUabAo8FibqGF6JfXY/coWcqrLXmWQHad0xt3HQTTvwIp5JQFWhb2
 OZJJw+cBSFTdWQdw6v/yyeABPo6CBaCRBwQIsx/C5+oph8SOnRYEzpJFp+bn3JVpmLeh
 sKvXQCCuCFcqKNZifWggCoGZoubNPPhSbuogUPku2jJ8F8Cl1NvMGxBq8l8lEnCEUD5Z
 AO/IYnKWdToJ0d72Um/RjGzS3CowCAN0bUtuV2e5iBxDfnUic/VZWulKgTa6jx2VxnxI
 sR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789759991; x=1790364791;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5ZFVoDU+7DCrBGh4TFzKLmWeRmxboVUz8amjMWfsDHk=;
 b=beHtnVvhRM/uR2DQcWPyuQ6y6v08SDqwwCelW5JGZA2p0hb4TqdRCDcqT4C7tnl4kI
 pWw3Zz8P2wpWsooWiLiNs7b6X3z/iO+ANpzcyhNTHmyvkXxzp1uOf3B3f9PcjkHkuZ1Q
 3iIzg9D0mC483fCA+uOfL607INlhh/NsFjsfgnTLDdkgWgmBi0r2/bWAI4QlnsHECvHT
 DgA1dlMTz5rHn2z0gPly1ku5OOw9K7ZQZE8jJZZr0AwHWnqTFiqMG01mg+ozf7BQiFeE
 JXHV7UyxY0xQpcrGeeuxC9LqRMp5b1FWkWZy6d6h5flzjWcQuGz0jJROusoTvFVtR2uH
 ZZXQ==
X-Gm-Message-State: AFuF++kAO2IBs8b4wT+yjqh/28DshVaGu1EjUrn0Xl8pIjR1SUWx5dgo
 /VXwSL5MQWYaiTsPd41IvsxfVmXckx0+bfg5cRFdvmuChbxccdzlSHycCk/K+DDw8SfZ1sUjrlv
 nFeGlOdcKlxDBBPIYLVy5ECWiP+cPzLgNJ9nAISsAeE8+pwQWx6sAm1NAJe2KdJWL/Q==
X-Gm-Gg: AYBFou3vk3JCf0XG8UO0ntOLEKygNZEef9FDX4sa92JJ0vGQxqk2PbyF8DM5WyulFxB
 xh1MB45MzJTk5kYwAAIvFpGQQflnAiJiAtosSCeK6A15GbAtNHrVkCTkExzkmbpGbxQYvEyeI5U
 bMzT8aOkB8adDUcHJyB3kPjaIM+E9MLbi0wmFUhGD6uNVF4M2YjTMwFSBNFhdzJ1eomz8SQK6ob
 KXReDpzI0ITCh9FN3mnfSv7b/v42m2n8SrQgGzQuTnjX8JqE4aroicF84wtcp0DIiyPZ+GJobnM
 cgkDNpwKgCb3uocB0BvKq8UjVPoE1ujSWI9ePwxLCHj283BzVeUbWLK1H1HnVCA4P12gfZUHaR/
 KlVuy7XXnlt68Tz1UiudeFur5OFWh+o/pw+y8jxCb3CrNdPrMnpzDgXYLu2g=
X-Received: by 2002:a17:902:c94b:b0:2dd:c053:ec70 with SMTP id
 d9443c01a7336-2ddc0540948mr14679945ad.35.1789759990848; 
 Fri, 18 Sep 2026 12:33:10 -0700 (PDT)
X-Received: by 2002:a17:902:c94b:b0:2dd:c053:ec70 with SMTP id
 d9443c01a7336-2ddc0540948mr14679645ad.35.1789759990271; 
 Fri, 18 Sep 2026 12:33:10 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3311a716sm810682eec.8.2026.09.18.12.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 12:33:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/3] TCG tests final fixes for container builds
Date: Fri, 18 Sep 2026 12:32:56 -0700
Message-ID: <20260918193259.704462-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EM8Lsvs9EuFg48Y_BbWLBdKYGiMUL56c
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI4MSBTYWx0ZWRfXwB6VKijBDppy
 fWRSk1o3Zau7TtDZzrrAhrAb3hGhff7HmGgrmXhrIIEGkWi6oy5xt7JESVlE8O9FPHkcyXAkJAF
 kx3+4OAfjsqqsTu3VWfmoMmx30MFb+E=
X-Proofpoint-ORIG-GUID: EM8Lsvs9EuFg48Y_BbWLBdKYGiMUL56c
X-Authority-Analysis: v=2.4 cv=MLD1C8Zl c=1 sm=1 tr=0 ts=6aad91f7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pve9gBknOMzfdEEbZNIA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI4MSBTYWx0ZWRfX9uap86GZdvq4
 oqilbyx5Amzjauep4VHucHh3oiDWlA0FS2PRRvrIS4riAYwTRRHcApUCQ7//QSm5gVIxrCvr/PE
 Bczq5EaiR/vBxdUrvfORa/w6gd0qYm8eOM0Fze7s2vPAFN1X6MQdkgtuIf2FKmbJ8SY3S0s7V74
 ctqgLWQg6CLUqf533+KiaLn+oj0Vh5WzGo9rGEWPMBGry+O/n0D2NehKvRiUz4yCIPQ8zJ59W8d
 8XXArhp5Py20ehKjmr5RMtWc4vW2T1GLqxyTyoO2hc/jFY2gc01p6S7dKdtbPU/7KYqkVXCoG86
 i8VT/3h7lqxrWDG6uJdAr7ScqZtKBN/vGcyG6rV6L5ApNH9IvqveZcuYUsRbKrypV39XiaIq9SN
 ow3i1DkoUFSJ04479d4gVZ2gaX+qjJMywaiSDzTac3jO0BFBaRpQ3hu2s7SnfupPA76HYip0JTR
 87ZcmerKKImTG7azXwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180281
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

The following changes since commit e8dca265c91b45f4cde746e5094d7b763444eb6a:

  Merge tag 'pull-11.1-more-check-tcg-docker-meson-180926-1' of https://gitlab.com/stsquad/qemu into staging (2026-09-18 07:52:24 -1000)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg_tests-20260918

for you to fetch changes up to f115b35ed817df6ddbc96f47cc0a537ea76e545a:

  tests/docker/docker.py: do not add-current-user if $UID == 0 (2026-09-18 19:29:56 +0000)

----------------------------------------------------------------
- [PATCH 0/3] tests/tcg: fix more container issues (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260917221117.274619-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (3):
      tests/tcg/meson.build: fix host fs mount on SELinux enabled systems
      tests/docker/docker.py: fix run command with $UID == 0
      tests/docker/docker.py: do not add-current-user if $UID == 0

 tests/docker/docker.py | 16 +++++++++-------
 tests/tcg/meson.build  |  2 ++
 2 files changed, 11 insertions(+), 7 deletions(-)

