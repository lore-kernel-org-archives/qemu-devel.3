Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8927BCA5FAC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfJz-00009h-2A; Tue, 29 Sep 2026 17:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfJw-00009D-94
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBfJu-0003fR-Jt
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:25:03 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68THhYvm859712
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Lx3ilcJU4DktXK5WxWp4pk9d/LMgVoa2miI3F9WGCMU=; b=gk9LOJXvJxMl1jWE
 9imCMZJlkUksCdNt6ao15VwmTuLso7WJE39GNJTRwHEB0GA6XRCnD6M+STqbbelg
 nkuVqt/MWx6xiKnrUWp+l8uDTSblbjT+BWKzrD2UCU2y79XIDv20gwImMj6C4nEh
 1mKWwHaEBLcxJ6ywFYwEuo1MkEvkhsCBKrSu5ouX4I88NP6m0r0thQrh+WAbHvUZ
 xXEprXl5wX+vmd0rV6HyVzVB/Avndzlq5HKL4SU7y8HmE2eQKTqbs4jZEAWhMqs7
 HqU/r5XO6vCrtNUmPcs41PHI5Q0kZbYGc6dHAuWYuUqgQN4ORM9Y1QiyZH+YeBvE
 yOCv/g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h08e0kq3u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 21:25:01 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3441e2b3fc3so3815977eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790717100; x=1791321900; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lx3ilcJU4DktXK5WxWp4pk9d/LMgVoa2miI3F9WGCMU=;
 b=JskK2nEOuWaGPegPSdOI2h6h/ESgm6sK5VP17DrTIvVgB7Is4hy0xLJHkNVzCRWHZD
 KdS43/iHp106spbsOg37zk/sHF7ikL8rjLIfKLNRNwOlRs50EnD1JESlFGxZZKQDj/uW
 0a0tH6E4QqeY+p9FRBxEIPK7JZ47+ZTdNJQnlQieIMI3E4ontl8nROreGteY5K2aqScq
 p16V3h1tsiIe/Qw2C/dsJELsnciQ2zIrJfMYxwDsFtVBn6rArbF4Ne2gAVrQyc1aTC1S
 Baa0QXtdbpmgJyUG66qsfLSCADUV6Ixnbdk17WsFRjSOc9eBDikHoW3pDnFzMZdGqcnK
 qCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717100; x=1791321900;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lx3ilcJU4DktXK5WxWp4pk9d/LMgVoa2miI3F9WGCMU=;
 b=uMlTdjsiLQUVHV07iBbUgP/ZkxO38mhpuSl6xe7CB69zeee6b0sCw4UOiFljKrvPD1
 wMjiJc4njFJ7CnX3egdY6xBJSr+K3ebvu+eJjyuCfNLJfmXFbwsq4lcwVvYrBkwTXV9/
 fPId7CFgdRXesNcMO2B/U6KpATQZ7sdPzKzXhOLFmPB7pwQ5V6lxY4oK56iEaPze5TIl
 sn66owqOiXljFCPF1EKxGRLOnFjKTWGKioyTyQDsA7eK+HpMvmMAhWapg3fo27X7fFLz
 gS8YsUmPtlX2vQehH9Sw4nu25ptP7LZ2cBW0UAa0eCTcL1KYWgicN/WpxtSosCvnJWDt
 xLFw==
X-Gm-Message-State: AFq9FYKTj2A3cKNMjHbyKI1DZ0fr9rdd+CZaMUZZnctB+e1XRSrj67I/
 DEnHdUQjvMXLxzMN+qNF47p2dTGXj3kihS6JklI3is80/nHNdWiwkaDmssL2026VB6Dy4mAria2
 2akoogqp64bhu9NfE2qe5pZRiNbeXlNiR+FrPxE1i6hBWyRxIURSS1PcOmM8ySx2lVQ==
X-Gm-Gg: AYBFou11KlkLt9aRKDvTEV6mKj2Dtk/Y4J7ivHUtFe14KGulDJmInIo3jbuoDm4eK0R
 i2zop/HUHRHchvCPG6wphZ9XlcAieLam81jUQj1/SYYGP+atdOo2swLFLY62cXyiTrA4OWNQMhb
 sMW5Gwnc1tMlUsTOqQbMt6RDc/aFy28c7oFpAgy7CZ7Uq/VkX85CDmjKgLRCDoKs0/NBosLt/sH
 rLg7BtyFQrYbFFSvd6YLkboSBNteE+vubxq5Rt5jKXaUAetcgcacWyg0GGUSs06sZYfFnHAAy69
 NwpXi6XqIZ3F6ZTR7nnNpw0L09VuUx3wGX09rSkQWyvtOhLUty9PgTmQR1bNlVS6Gz4ekUa5koO
 rUk9oG8gv02bVgttVkwdgjDuKRSJPt90Gy6YlJmnJ9HMjXasN6aJjm3xTITIp
X-Received: by 2002:a05:7301:3d06:b0:34b:7acb:b8bc with SMTP id
 5a478bee46e88-34c6312d53emr838164eec.4.1790717100415; 
 Tue, 29 Sep 2026 14:25:00 -0700 (PDT)
X-Received: by 2002:a05:7301:3d06:b0:34b:7acb:b8bc with SMTP id
 5a478bee46e88-34c6312d53emr838115eec.4.1790717099616; 
 Tue, 29 Sep 2026 14:24:59 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388d0110sm1415413eec.20.2026.09.29.14.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 14:24:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 06/24] tests/tcg/mips64: move octeon test here
Date: Tue, 29 Sep 2026 21:24:21 +0000
Message-ID: <20260929212439.110454-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX4f6TcNtr5ua3
 SWovz8ju82vgvWbLSPfPmj95VpmB+OHG2GRKTHJymuN2YJAyTdslx2IAuxvBLeM3TxVpPGgCXS6
 M5DjMccJB3Zm+R6hmZu7Ml55BPNrHrA=
X-Proofpoint-ORIG-GUID: NVGg0ZhL7KsRit8-TZuNbmjxzxVYQko0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA4NSBTYWx0ZWRfX/0lZ3e3FKEOJ
 6OndpQ3D0R8iSU3YXsl9ngYUM4+kMRvuPZ3uTfYKGfvjJ2TuaZCRwMbe+ediXQYcVu67PDV2hck
 ZPo1/hBE6lR/ckWLH8ivNcujq8E+M3FCLJTEYKCn+rDWynwKIXYz88vqBdOXE0eTwKGDFxHcHf7
 H8I+Ri5NwUqftiyG1N483FATLCrlqRP+Xvsfp9RNoS/6oZJshBoEUCO33vkFPtWhJqww1q1KCZj
 EFriLf/KJ9rucQghCNeeey2j3bQ5fzifBhADZOGjhm4+NWnosITPpv0wJLHCR7zgj5NuW0233jI
 gFScolrlEIsLV8fPrLH6EVqOruNwqUi0FhPvbNM6mKsxHwzbbRrt77kk7hQhA7O9GVH6qGj4irJ
 /8I692DFeNhXBu4eHhnaLgS2abHrO9YRZRe505o3xgmLJxIFY+qJsKH6DnjKyxAru025AJ/oeI8
 9XpFKFYQJ8VCl0wrs9Q==
X-Authority-Analysis: v=2.4 cv=WJ7qzXsR c=1 sm=1 tr=0 ts=6abc2cad cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ybKMF2EBzz_YHPg-y3kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: NVGg0ZhL7KsRit8-TZuNbmjxzxVYQko0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290085
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

Acked-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/mips64/meson.build                              | 2 +-
 tests/tcg/{mips/user/isa/octeon => mips64}/octeon-insns.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/tcg/{mips/user/isa/octeon => mips64}/octeon-insns.c (100%)

diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index b8eb6705eae..a324a16d671 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -3,7 +3,7 @@ tests = []
 tests += tcg_tests['multiarch-linux-user']['tests']
 
 tests += {
-  '../mips/user/isa/octeon/octeon-insns.c': {
+  '../mips64/octeon-insns.c': {
     'qemu_args': ['-cpu', 'Octeon68XX'],
   },
 }
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips64/octeon-insns.c
similarity index 100%
rename from tests/tcg/mips/user/isa/octeon/octeon-insns.c
rename to tests/tcg/mips64/octeon-insns.c
-- 
2.43.0


