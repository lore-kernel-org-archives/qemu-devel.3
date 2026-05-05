Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F08FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 23:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKOqx-0004Xm-Jt; Tue, 05 May 2026 19:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOqv-0004Wu-Du
 for qemu-devel@nongnu.org; Tue, 05 May 2026 19:06:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOqt-0002Ux-Sf
 for qemu-devel@nongnu.org; Tue, 05 May 2026 19:06:57 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645JiiY33187637
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 23:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=HN4ev9+aOO4fpyMWomRVdw
 opGOAT0RTs36UKCVdAeQs=; b=MlCKCEMCg2ticz0dA7wJnu3TJ97JaDHLBtCGZY
 Jl0NBfRybq1XJLwrWMRjJMPYJuzT1F71U4g9svBtookkQKl3gHB5Yb1KZHch4JsB
 ecvF3BqCmPSDpS/3e218eX3by1aY3so2R+g/5kJFp8/s9Vl4Z68NpMm8UbbRtueH
 izEwL5IN4mcZrWByeaCX6h+Wno7kIJqrpFwHkXR3l96fwlhjdN9faT0PRFKFamTy
 FAjMsTnkDgcEbr6sGDnf1oJrhxCgfe5vYo7zuKgAaXBuOx+izFuc0ZhB5j9Oi5bm
 lkWYqg+2YN1+ak28EU0UdwB5cuvjmbaEowuj4X2gX3uBJv1g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkkbnyf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 23:06:54 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12dfdde7ce7so21814537c88.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 16:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778022412; x=1778627212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HN4ev9+aOO4fpyMWomRVdwopGOAT0RTs36UKCVdAeQs=;
 b=MsaP4PVvJrIKipW61Z83DgKQ534iLDXO1ujD6bSzjL0cZOwhB6xPv2R6OZB6GzZ7lM
 uUuY4dfMh1vAvFA50E3dVNbQjORq5FJu39GZ9fmLD+S9WsWYYYT60RJhQ7D2ukWNvFMB
 h3rvA41eIEDVQlaYAs3UUHsd9pMzSCvOuKLLtTeIlrtZmbYDo3HY2pkjKzSwD6BioPhD
 bAZPHgAsXt+D7SuSKQwQMFZAjC52MKIvoGJhV95JEdLSwTj/yTF+h6JUb/FlBMrBzzI2
 57wPHvPuD087F1xjsoIXIFWRj/y86AMXuuTzYD3z3GCjz6tIc3J75mQQ6+3PvSw3h66n
 Q12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778022412; x=1778627212;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HN4ev9+aOO4fpyMWomRVdwopGOAT0RTs36UKCVdAeQs=;
 b=LYVC0HkfGZLCoyfy9GZWvsQKXPbF6V/azOjbdP0qVTgRAZW/m+ztV7Kl4fluTgbOub
 930wZFK9hF3Y/2izBsmx+Lj63A5feOG95bFCgRrvPWaj3of62y7H2vl//Q2NTwkj6TLG
 Waf0w2pssP2ny+w+KHikFfkoZG/fLq75YPqW1IepZ45EEITy/05ddOdxnxZYEIgpsW8I
 uT6DIRLkBQj7uKtl4v1UKCz8imxCnr5oMQN8TtbuCIl6CGdAZc4V/RQ4d3IJGdeKxVB5
 2umsoP4FbUruppjJqFanSTXkbYSRML1yOZrQMRCp+/xdMoX+iHuSnzY+E5dmOZevST30
 TRyg==
X-Gm-Message-State: AOJu0Yw/+sF1XP5aU77yJHz+q1xMkWRY+zuHrQzOV02QqZplSNoo4CnE
 d4ZbmKtJohw25jW6gtIkXJAeSlbFAkQB15hW2a0UeCp66oFhEJ6PMziNKLGP6CJsCPzGzTbCKAk
 ZySmjelBS/My73wG14blTte5isX6tiVak04NDRv3JE55S0TLe6U4jNMDlVu1okIzkeJAf
X-Gm-Gg: AeBDiesJZb5kGqm6LIVsfBj7DjO1OpHCwC8TJd2qpKYEIqxeB9tyCVTsLG5FAdUMa93
 wZSatXgfFUwaOfdKgDtFMiCW/aCaSkmt7qWSIV5I2rLix+QbZj/CRPHrD6Eqnm9ONakQLakx7TX
 SRs/36dCZl353izZPPBW3+1lHrfOjJSfyX9O8N9jMjwky0dstEH2p8FwSaxn6GfnhFav6Xkw2z0
 lm/JtV8cSCmp09+r+xfJWTkSKpg+I1kjDtV1xRZgz9dNs0mpyYqT46NeZvXJSdOrs933OvoDp5y
 l8+nKCWgizlBzwUQj2yy0Rp1QIF9TsipRd8rF6gSSpho902H2c/CSS6Cp1oK+eFa3FDGv+vQ0Bp
 aWg7maV/dVfkVjVpZeBN2akBPhEo1GhRgsNSKKi+TsfYQe3Z2uOFEMFzL0qkZCcQJz6RsTnGAda
 MQuBkiptwWIDggqDTw
X-Received: by 2002:a05:7022:ea22:b0:12d:de3f:d844 with SMTP id
 a92af1059eb24-1319ce5634cmr656092c88.39.1778022412446; 
 Tue, 05 May 2026 16:06:52 -0700 (PDT)
X-Received: by 2002:a05:7022:ea22:b0:12d:de3f:d844 with SMTP id
 a92af1059eb24-1319ce5634cmr656068c88.39.1778022411842; 
 Tue, 05 May 2026 16:06:51 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f57038c644sm911290eec.29.2026.05.05.16.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 16:06:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/2] Build system: add stubs per target
Date: Tue,  5 May 2026 16:06:42 -0700
Message-ID: <20260505230644.2710049-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIyNSBTYWx0ZWRfX8KHJQNjtoqXS
 s13KhBfYhlRUjCVz65T3TFX4But7nEihcpbxCBavrEi2HrIYnhT7YA+rTV4SI6R3eixzilq4xZt
 wVaUlIZqbUMbUUi5QmeKWiXOmdgGyMN92pDqSqY0Ri7q15nxO5IHz2WUTUSfLnbygpSsH5z5RWE
 PLbOsWyDqkF4ZrNBC/mwqkGx+MqxjApRsrWFrE+Rsqssxv2GuvJ5uHC0qi1xYhh8OXi9irw9/I4
 KvHmR5p3Og+/nGvyG2aLsK/xht2f4ajSEsh9aWDGXxMUnurC172Zol8M6XAvd/6+tBc4QP8KUff
 33YVYLCmcEi29DBRbonsDEcfr+zIb/AXJ7ykIgs+NjJioZaKiGf/1o0ZiWqvx8E5DKpR5rm79W6
 lVLLljyKj9qR+NSITQfjWRKSy1QFTQ5H9TO0kVKpUyoYT9Z7d/VL81HRhcifLxEZjEGKSY99MDr
 ZAtpJR2dZGWVTD8Djhw==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69fa780e cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=-AnQz9JOAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=kqsxatxNWiF1iH63L2gA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=3bnadFWGKyIZm4bBUiDd:22
X-Proofpoint-GUID: 0ouKquqRaCvZO0C0ZNPdbCBLGrLxbHQu
X-Proofpoint-ORIG-GUID: 0ouKquqRaCvZO0C0ZNPdbCBLGrLxbHQu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050225
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

The following changes since commit a85c588d07f8d3345ccad38b22026569a04571d1:

  Merge tag 'pull-monitor-2026-05-05' of https://repo.or.cz/qemu/armbru into staging (2026-05-05 10:11:49 -0400)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/build_system-20260505

for you to fetch changes up to 2e44ff32fc758bf8c0df13b0287afb75bb00c38e:

  target/arm: define stub library (2026-05-05 16:06:00 -0700)

----------------------------------------------------------------
Changes:
- [PATCH 0/2] single-binary: add stubs for target/ (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260424230103.1579600-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (2):
      meson.build: define stubs library per target base architecture
      target/arm: define stub library

 meson.build                | 22 +++++++++++++++++++---
 target/arm/meson.build     |  8 +++-----
 target/arm/tcg/meson.build |  2 +-
 3 files changed, 23 insertions(+), 9 deletions(-)

