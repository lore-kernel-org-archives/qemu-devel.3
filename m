Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB24C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4hA-0002P1-CM; Fri, 10 Jul 2026 02:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4h6-0002GQ-QH
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4h4-00065G-R7
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:40 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nEl43752799
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lbeJ/z0Y4pV
 6kGShdVXeqMaL45UssSZvIbEU8StjZ1U=; b=g6H3PeT6Pm9CFzaOegiIT0Y/bfj
 GwH8/wy6Eirv9031RLvlBB2Z1Ip5A7cHg6dj1A54Pjec80oVb9AjohOWF4HtW7GE
 k+TWw0pdAvEJXBKFuMu2iMKoTiRs/FdyqBG6bvkdSMpfU+iC7YFFR7djO/aL+7Zo
 Vw8w06KdQ1Ny97OQGZLq4C05b4szIsF1z/Nj7WBhJl6I3yUP3truGCnjvsywk/Nx
 XPvbG4XWSx5oyecd4BJtTllpN+TugkWFQNaANxSaZCtVa700qsma/3Qcef72b4ua
 B0ILIISTVtHBlG+ZW/lPWLWEfAHZqPPpfH6eZmOOqqr4HCh2M4EnQdQoOSg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjbae4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:27 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84877b362f6so617953b3a.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664787; x=1784269587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lbeJ/z0Y4pV6kGShdVXeqMaL45UssSZvIbEU8StjZ1U=;
 b=Jr0If29fiOT5qAR+zc7S9JqJZts0vXHZF4D3oNbqu1WSTi41h2b0+4SAJR1oo/zfnp
 lvhBPMjeVeCNIHhVOImTKj9dt8ego242vVckIHkWmCu3fGNxtu83f3Rb0Wn3fsPuchlB
 QEj86/kj22TjFf0+pBDNDo6aZPZp25tvWeaA2y0pduk7z1MmLaMIJukTCqejxKXK0ern
 pk3NfO5w5OvnGzqcpQ8rA5dI+PKpXaVruKByM79LfF3evMWi0F7S/6YzNRzDcnsxDv+3
 toaaJ5A2tGwHuCNh7QU2UUxt6TMq5+R/b4kOe2A98ib3AEH7hxsFFDLi9SrkAzm6dBO0
 PQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664787; x=1784269587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lbeJ/z0Y4pV6kGShdVXeqMaL45UssSZvIbEU8StjZ1U=;
 b=Kwl0E/ljyCxbhB2KxCshk+OZMSRgNFZ3xtMPpHCtAvQWJozAHHlhxUbUEJr4NEGJs1
 nm6Wn9htgHVfQ2N+f1s59SsxWMd6NTkn4+0eWnQJRWmJLffCORpgpowjWm0YE+aZFINM
 1/40NFkQQhLRK/6lrPpCOu/4pxE2AxOxIaEqHeXJ+1OkVTEZQZReo3OBqoSx7AjHpg7+
 SElw0iAHuhLUlj/Fw3mdrrr3ZKdsJd5gu5dMobJLvGg64gZyG70jg7wLS0ZoSarJvJO4
 8VG77bJQQEy5h4dhxHohMemjHxxlLJp/oIG6LoIlQmUHYzzVJxZ1I5sbbcxIzpqEaDLZ
 2tqw==
X-Gm-Message-State: AOJu0YxaE6sMleONXNdzbtNb74jAgZINJly3CBOKU5WM7RS4HpVqDlgl
 c799MktirApEdPyvD5ADxTp6VuFV9k+PlNROJsp2uk5gThOiiEsvaOYTWtpowpqZPL+erKSHwoc
 D8YKHsmcTSlBBvGiVSYC4XPPttZ+XV7mWos0upd5Wrg+ewnC9fIut+LvCmaG2pDdUzw==
X-Gm-Gg: AfdE7ckdkU0bnKe21+t28IzAEe1ghLTFfATs/gVHuPJUnN0ch5qzeQifNwyf84oJVu+
 cLHhdS0J6+NGZs5guaU5mJejHvUxW3oMcHbj7dD+V4KOVPCgKNbAU8KRHIf4PcMxrky2/2h14to
 NymSuU2Gt8s6lWhfvCqm06/hchY7538SKWZfCG8TLKYlw4F73z5k8+d8IKtuwf07E+6GL3swMha
 ZPCmZ15Kcr3OTnHDYRwkY4Hez+DqDrjLWBsea0sUvwGP8s/iPETVQl2ZR9u0CPDiDC3/uW53M3+
 AunxgUROIaNQAlkPPPwQN9gWlAn6Vw7RvaUmZ1Lg/NhXZx5liEjtxWnwFNd3rahoGFNd8eIglab
 /Z1Y7ucxC9LocRObZqgkM5amAK+wIA7OqNBztoc9EPi6reh8JFny2Dn0Z7t5ScHQy8SxwX879QL
 8VQ9IU9g==
X-Received: by 2002:a05:6a20:c998:b0:3bd:203b:982b with SMTP id
 adf61e73a8af0-3c0bcc487demr10853555637.16.1783664786930; 
 Thu, 09 Jul 2026 23:26:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:c998:b0:3bd:203b:982b with SMTP id
 adf61e73a8af0-3c0bcc487demr10853514637.16.1783664786458; 
 Thu, 09 Jul 2026 23:26:26 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:26:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 77/97] tests/tcg/riscv64: user tests
Date: Thu,  9 Jul 2026 23:19:55 -0700
Message-ID: <20260710062016.1818125-78-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX/YZVoVo5a+WJ
 +/x6O6iTSbqYvpKDmEzmzPml5qkLsGt1ELXQwHp5ab9VnIBlDZW3HEXFjLSfIaTyzjn6VR9SPcz
 VH2treQHsgkPZOwFAQ0VXyVssI1U4XhGdP6Bjiiyg+T+IwM4DGsrWyf+TaoO2Qdm3+pa3zzL6ZB
 /tjoUT0PGoVBk3m1ILXVU4OfqX0qm9SESNoN/UAGWo50wwNcNRuTHTe8Thc4J4wFjegYC2s+bHy
 jE1pfzUn0ujeSkeljDWrnveJ01kcpd02dBJPHdwfKYl7TotG8et1oGzgBYJKth7VYU401hGNWcr
 rRK/phlqKxZjBDUDj9vIIU2AqIdxP3DU22irOR3nw8HUwxYU1BcuHFKj3dUcvQ0huOq4ZiUzkh0
 M4U4hvKr9aqj1bfZlNb/79WyufwpGJ/kOyIAnxkN9uTdZYQ/NDNB0fUoSu/yETbybuHw/j7zng3
 MfpPa8+R6jG6cyV70sQ==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a509093 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=RF0wyrqyR16z2FtBPQcA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: t5TLhKfcConCJiTS0CWx_gRLXIaxZrtq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX6MSvmMbfcvgt
 JBIAlVlGPT3NOCBVir+Xjp5NeGgiLJVg0SwH5MU1iQUL30QZb6UheoJ/hba43XUB4qxxpRHwFXi
 ja6PQqU6gHYeLx1fI8U9sXOJ9nc4rVc=
X-Proofpoint-ORIG-GUID: t5TLhKfcConCJiTS0CWx_gRLXIaxZrtq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100059
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
 tests/tcg/meson.build         |  1 +
 tests/tcg/riscv64/meson.build | 36 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 tests/tcg/riscv64/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ad8b40661e8..bb4b770070f 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -148,6 +148,7 @@ subdir('mips64el')
 subdir('or1k')
 subdir('ppc64')
 subdir('ppc64le')
+subdir('riscv64')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
new file mode 100644
index 00000000000..b5f574c1377
--- /dev/null
+++ b/tests/tcg/riscv64/meson.build
@@ -0,0 +1,36 @@
+cc = 'riscv64-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+tests = []
+
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'noexec.c': {},
+  'test-aes.c': {'qemu_args': ['-cpu', 'rv64,zk=on']},
+  'test-div.c': {},
+  'test-fcvtmod.c': {
+    'cflags': ['-march=rv64imafdc'],
+    'qemu_args': ['-cpu', 'rv64,d=true,zfa=true'],
+  },
+  'test-noc.S': {
+    'cflags': ['-nostdlib'],
+    'qemu_args': ['-cpu', 'rv64,c=false'],
+  },
+}
+
+if 'qemu-riscv64' in emulators
+  tcg_tests += {
+    'riscv64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'riscv64',
+      'gdb_arch': 'riscv64',
+      'qemu': emulators['qemu-riscv64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


