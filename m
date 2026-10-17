Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD557CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 17:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI8PO-00024t-Lt; Sat, 17 Oct 2026 13:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xI8PN-00024d-7Q
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 13:41:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xI8PL-0004sO-Ep
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 13:41:24 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69HG9lCx634831
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 17:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=s/u2FeQ9ByEYzoQoR7Zds2Ck/4+GrCJUwpt
 Hk40EXKQ=; b=jtpW+bUcYfQ9J77PdKnUUvji3so/ZRRme3HhO4rzdRGISsVWFUZ
 dc7uppO86OrW9nNiEMqFwXgtZk7In0//u+2jen24hyamsANVdVt/Hn0f7KBUu+o8
 wt5QWSvOIQwUSLdunPaIvEpH9vyDoBAf2nUsklMyCiMFqLgKxL2kqXD6TvZvgqxj
 xWmJ01Lb7s7TcwMkHn6cp306bJAwBDRyTRGnKhT6TRLXorkrXWOgtSOjZgv1MKyW
 ObCCwM6eTbQ3TOYN4TR17OTEkjII62CeZ2hMc9t5OIAR0597/O0udw6jUQ5MlBkU
 gtAQzDAeLHkufXxoGaOjwp2QFc0Ubd9xbeQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc2a9hade-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 17:41:21 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab868fe362so200034a91.2
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792258880; x=1792863680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s/u2FeQ9ByEYzoQoR7Zds2Ck/4+GrCJUwptHk40EXKQ=;
 b=Wi8gwP3NUv+N4BcrA6weDAVnZHoQz9r5W9RYbPTT6+HpIuEfx6S8wIrvK9s0RJtrQB
 RjJ8zinZlloTZCERtx6WNo1EtnplHBdSQrEk+3rZkMzO2naLMgRHxm0tcXiKkoBZ69WJ
 5mkKxhs9Ro9mHxeWTZY2UFs157eoZNMzWOze20H1WA0KFzoehgoi/zxDIVLqNltsQhab
 M4vq3EzNXbFHDcT00rFU8MITATHeCOGmZs3VqwCpBhiWFwQfpPXXdQN8fv2d+OlpdliT
 5u2XFlsGUc2qt1fbovZ+bUa2tpes/85lfrRfBhpiTBFbcCvqBaaS4xu0l5MR8Y8gA73d
 wjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792258880; x=1792863680;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s/u2FeQ9ByEYzoQoR7Zds2Ck/4+GrCJUwptHk40EXKQ=;
 b=Wex4gesH9ZVwz8XTYQY63v0hh7JkEdTWKd4kqBFHLA26IMt4ZIycuCDQxgcepkUt46
 1TRTJvq8VEBHzEU92JPsY6us2U1ro1zkL7S4ww92hlRyvh5x/HRBITRqPBs5oUEi1Qjh
 Z+SQ8gLxkxBkKHhDH49vnkNe7J0dME279u/6W5ovrL14RObNgc/bJBGIcS96RiIYQPqc
 hX/r4tu8tbT62GEy7qWWWT3PWt4yScqVcRrxaIQdz5PHLQv8TxRGXdicQr8PnACFLaBU
 c8ymA3doo64/BaHx9Z4EP6HUorDizLHKjxo3W0EAbF4x2ZC8m5WAcP97zrLDDBPqRpiw
 kNUA==
X-Gm-Message-State: AFq9FYIXtkGMGk5JXqwt76jUt8kEp5mem0BQxa+CCYPgkbDw0q+g0GMu
 UejPLug5aRg2wFtoOVBjo+n49LUUzSPt8t/Sbqf8xavilLLCa9hk5Z6NBJ+JUCUp7gUkv80LYnC
 48e4kA9DzYPNZFhkkGWnsbjeUQsdauu0TwtSncjhiyi6cQ9UEN6wxiuiI4PDNHSgmqA==
X-Gm-Gg: AYBFou2JLNwhSR18vaPVlMIfdIffGa3vcadHGh6F2ylrU1XRDqRBj66l+mXccENNkwl
 RERYLLbZqL2CFSX+ZK4y9piLrQzWLmfpbYSJHrWoExQrjoEZRdt1HUjC+PPZf7IrmwpxQgdn/OU
 fzeojqkzou+IoCP9oDrZhpSeBAXHBsgq/xEP2tS3FOo2Jncc8MO0T2NsHWtIB+4rRvTgpRnNqYB
 V2iOsXRw0CKmnDi9zdzSbBmRgg6RT0N+osJ+IhosBR1pOL3YFor/W2Pw91e+jdD9OaxKUu8AzHh
 RzeQ2hCXKO/q0zvgZxZ9MsiLVV0Br4xfgyFGCu3DxKzAZcx2Ssui6ayJGwCgNgk0vnX/VpVlekT
 yy15VPkBUe5XYMzZqEZSnAm6mfKyB9ROMnHLbdjaklLmN0IbQCKYywkUpgEpGRAM=
X-Received: by 2002:a17:90a:3f08:b0:3ac:fe93:a731 with SMTP id
 98e67ed59e1d1-3acfe9f4581mr923431a91.56.1792258880489; 
 Sat, 17 Oct 2026 10:41:20 -0700 (PDT)
X-Received: by 2002:a17:90a:3f08:b0:3ac:fe93:a731 with SMTP id
 98e67ed59e1d1-3acfe9f4581mr923424a91.56.1792258879980; 
 Sat, 17 Oct 2026 10:41:19 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48f19d9sm8838862a91.11.2026.10.17.10.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 10:41:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/2] tcg tests 20261017
Date: Sat, 17 Oct 2026 17:41:03 +0000
Message-ID: <20261017174105.25814-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA3MCBTYWx0ZWRfXzXPYrZgADB4m
 YgnrjpOTlC67naqoZiQFGhI7SDo3P91Pxa8q69pScKtkyTmXFP2kwTMZdibXvrvmsmbYD0ikk/F
 S3sLrwLPkgbko8STbq4f2g/u8C0c2Lg=
X-Proofpoint-GUID: NKVXHLOqB7tkz7nPxLxg_53B3hbOt30F
X-Proofpoint-ORIG-GUID: NKVXHLOqB7tkz7nPxLxg_53B3hbOt30F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA3MCBTYWx0ZWRfX2eMVW+I82ynn
 uc4Us6Al3ryVLjwWNEK4oRwZHonMyoOZxyudWYxwy2xB4gToiO1L/q/jqqLgQ0huo7dXCQLQFR9
 LxcIpNzSf758e3odf/ekxQH5fVgucwCjCgFwVUvO4eISFzrp39UPAm7KjlFwDJCz17i7B1LUWmN
 UzBc0i4ODoxRSpqBCX60MQ+1X5eNfxBtcEz7Y2MISLNGz8PDlcpz7l4sUILzwXpFL9eVV4xNQ74
 PzFDppxhifL9a9Co46tBos1K2/w0uRSXoDicCgAbIiQxQ1GfHQdJU0U/3SkOVZVl1qOHONFrYFr
 pknpuASjC2owY6a5qmjWu++0GLFIwW+T825qrhvJOUReMLT5vENr7Z95seWOAi/FgNfeyUNo4lW
 dnAPQzbpoF0L8RrLOcHk4uJUgxMndlZbgVgoKywjOGCa7p1j7m7nCjsAiaNoYQ9/IOHAgspxyjA
 khU4CJr5/ghnUn6frWg==
X-Authority-Analysis: v=2.4 cv=PMeaavqC c=1 sm=1 tr=0 ts=6ad3b341 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=NEAV23lmAAAA:8
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=IE-8sZk1nr3pdtXTKngA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170070
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

The following changes since commit a19f59a72d96056d9a8f48cf6c77f5787491e414:

  Merge tag 'pull-hex-20261015' of https://github.com/qualcomm/qemu into staging (2026-10-16 07:50:02 +0200)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg_tests-20261017

for you to fetch changes up to e77a38d8944cafd7285b9f7caa4771e89027dd1c:

  tcg/tests: add an alias for all TCG tests of a target (2026-10-17 17:40:25 +0000)

----------------------------------------------------------------
Changes:
- [PATCH] tests/tcg: match custom target name to executable name (Paolo Bonzini <pbonzini@redhat.com>)
  Link: https://lore.kernel.org/qemu-devel/20261017074226.1347492-1-pbonzini@redhat.com
- [PATCH] tcg/tests: add an alias for all TCG tests of a target (Paolo Bonzini <pbonzini@redhat.com>)
  Link: https://lore.kernel.org/qemu-devel/20261017073952.1346449-1-pbonzini@redhat.com

----------------------------------------------------------------
Paolo Bonzini (2):
      tests/tcg: match custom target name to executable name
      tcg/tests: add an alias for all TCG tests of a target

 docs/devel/testing/main.rst |  6 ++++--
 tests/tcg/meson.build       | 10 ++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

