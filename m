Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEEBC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrxQ-0008T4-FZ; Mon, 06 Jul 2026 18:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxO-0008BX-BH
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxM-0006t4-HE
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:29 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE3d41478204
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jTsEfz+MAim
 OmM9brhrTBKm+QY2xkc7AAAb0QC1gSng=; b=MISxR3pxnmsPhDJgryo4gORQhj/
 SoKazhAocdLRd96v2lo0xOw61EMLPl/d+IxUyigBZBcRXlpC7DSoDkBxcfbZ0pdr
 H94GIrjWOHKnx1I8cki/tTp+RQLpBKSCjm33Y6n7ZkZxNWZfku0SDIOM5yCQ84ud
 YCVW3tbtb5w6awX6xcWisYo/CET5ir8t+4QGdXNschNKDNAgNR83zfaje3kYiebI
 g8lGt3VjS7tWmINnDy6bMnyc085a3DRmzncjVNMowiSj7NiDCc7CSsZniBcec4vA
 KapIhmZmb3AtZ5FpeXGskMWcRRzZTMDqsnELIckmNCwNsEceuYjOM4BdZag==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsbmft-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so2648765a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377507; x=1783982307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jTsEfz+MAimOmM9brhrTBKm+QY2xkc7AAAb0QC1gSng=;
 b=caag1LN78xF8uvTJOqCixtALen4QZkhF52V9Ti4sdJuWxvFK6F+7gTr7ZSdx5honS6
 fRNvsg/KzGy0xP5u4ib3gtnhpMMGm2d9pKc8YwhD8QyT48cFJxkEDK4DKbX6Ucyo9Nm5
 +IVq5ujCUtVTqQCbPwRRxnqm+g+QiIJqgUUqwSGDPFfQb485+OjbuQawe8oDhW8LlsOS
 tnwd+qd+DXZPEXTbjPl01S63b/Sh6kJyd+/DVHvXbwykjIjSiz+7bTDHM7evT2zMmdZp
 MNtWpRE8L/6VYr17AibG8wfgTHs6IE4wxmUg2+I+SEx6nR0F269RhSgxEr5jziGaBcjO
 pkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377507; x=1783982307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jTsEfz+MAimOmM9brhrTBKm+QY2xkc7AAAb0QC1gSng=;
 b=WLEAQHYXjiOuv0Z25n7iMrJ+MV433szujezde9olKx1Cw/utUQNtApLq5QZDINcZYh
 XP/OTDp7VVQH9NH6rJ5W9StPjhB9ccqoidIk97j1W0r0PV6tX+uMf92agXzVqiLXKgcI
 GLsse8VepxrIfI5G4pKMPQdVegYmiJUHCVpP/lgYWwT6jcvvb0gkbwMddMG6jdfprOZy
 1s4dWJbIHCj1GmJ/NPgAk189tpk405rQgZmtZ18zLa9Nqxmtb7XCzxaJ8GvKZ/HmOoqy
 SX2bLyqyDAerLdhrrARHtBIsDUbTwaA73yytGYAnSjQ78Q4rhJTrW5+KdBAiDC4Bboxn
 D9vw==
X-Gm-Message-State: AOJu0YwR+7yiHh0TbIScUYQNW140+Zxc3V7qljkuXW+ii1uoVNLUpimO
 IYRLDKTqzBhwEXuouk6tUgLpEKXQYGZO6UJN+CcjRngWfZiAnrEJhty4+tSLBDlAkInU+2hH2ZQ
 k84uGjozqBLpZ5vO0QFQnctyogpjmmARga/NMpWTeBEIGLrtURsKQB0C+K/c3vNWCPQ==
X-Gm-Gg: AfdE7cnRTzjoDitIVskTb0baAVv0H0N98knDr5zeKHv7Venk3aG38L4JwdN7wjdIEw3
 kAfcxYkQmeN3fovifjSsYBbu10SrxKNna6WeZpZ5fLR1/ZyYEMb5MYJ6TrlTY+rmeMBg++cJ6QY
 hZqreBkZxGjSqE8cjkr/s1HH991ZTY9Ts+JLfeZJ3uPCZf8gyCljteRnUjn0N/3YBSEWafbkVxj
 6kl3HtdncpQuQi5Z43pzF1x/ocQ9xIz99f+kwu29/XWqEuI0MyZ5UGPSgYagf0YbqLiAEn0zSng
 rlaFkDqc4mddFYgwiGtOJdGqd83zm+NOUdpXxNEbi0ZJwTGtEO7bNckCRL9M+J3wv3udLDuS+DX
 Pk08B6x43exgrZ5mu7Haz7C/LVVUpV6JM0UUadBKyTthVDs44qkVC+AbZAMze0DqveGo8XoiF6E
 0jKWQO3g==
X-Received: by 2002:a05:6300:389:b0:3c0:9c19:b27e with SMTP id
 adf61e73a8af0-3c09c19b36dmr62386637.76.1783377506666; 
 Mon, 06 Jul 2026 15:38:26 -0700 (PDT)
X-Received: by 2002:a05:6300:389:b0:3c0:9c19:b27e with SMTP id
 adf61e73a8af0-3c09c19b36dmr62351637.76.1783377506224; 
 Mon, 06 Jul 2026 15:38:26 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 51/91] tests/tcg/loongarch64: user tests
Date: Mon,  6 Jul 2026 15:33:03 -0700
Message-ID: <20260706223343.988769-52-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zkkWmS7RDRCsqsBmbA0n7BSiN2p5Ez9B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX6aceMguJUfSX
 PEAkrZ+mdq5pH/+vB6ANYTzX+K9SqSKWzk7uuFFZU+NZj4ACmdPcuHoQXjaE8D0sHPZOcLrmjOx
 6MuKLD2QqsANN+aI9OEvPC7kS0nGK+sJc6zISFuz5hMNJ3PP7MRVH6FYWLpf6sVFobCUNzlhZEn
 nYF8KYCBMd2KpClqVhzPzhh1DTaswo19a1LDL4EarY8VtIsF8FsWZli+dcPKs6RCPkJguTmUmf3
 7A97E4V/NPaZfAQ5O7tTpPBVIZNPbuSKFOexzG52Qo9kaZpIGVN8//RoM/2qauOYCkupMdU8POS
 hXHtphKr2TE0xxbMdB0qPPT54wfRoGMCd312SZyR40LBFkDoeXiWmkJtIKrQCYkgelNN9nJ38CN
 hvt/DOCPUc8+fJChQovG0hXZhw+VxYMtg1zGrrw3f0Y/40mwAFa++o9HLCs8es6jan0B0/53R+x
 GKxRHbLNzzRR6LHP1Ww==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX8Hs/d5EBlL2M
 Yp+kAAI166DxMj0A6+Dq9M4Q1Zp1dM3rNoW55OilvA2tEsdlR5lISNuWfmtAXXv1aN9LYGhN+Sb
 ZWNhkHRk63T95J9sGdr1jh4iX0p0feY=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c2e63 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=lIOra5X4EBvVxrSTrwUA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: zkkWmS7RDRCsqsBmbA0n7BSiN2p5Ez9B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/loongarch64/meson.build | 30 ++++++++++++++++++++++++++++++
 tests/tcg/meson.build             |  1 +
 2 files changed, 31 insertions(+)
 create mode 100644 tests/tcg/loongarch64/meson.build

diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
new file mode 100644
index 00000000000..399c1617a99
--- /dev/null
+++ b/tests/tcg/loongarch64/meson.build
@@ -0,0 +1,30 @@
+cc = 'loongarch64-unknown-linux-gnu-gcc'
+cc_dockerfile = 'debian-loongarch-cross'
+cc_docker_arch = ['x86_64']
+
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'test_bit.c': {},
+  'test_fclass.c': {},
+  'test_fcsr.c': {},
+  'test_fpcom.c': {},
+  'test_div.c': {},
+  'test_pcadd.c': {},
+}
+
+if 'qemu-loongarch64' in emulators
+  tcg_tests += {
+    'loongarch64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_arch': cc_docker_arch,
+      'folder': 'loongarch64',
+      'gdb_arch': 'loongarch64',
+      'qemu': emulators['qemu-loongarch64'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f1f27c2da1b..28a5b50eea4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -141,6 +141,7 @@ subdir('arm')
 subdir('hexagon')
 subdir('hppa')
 subdir('i386')
+subdir('loongarch64')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


