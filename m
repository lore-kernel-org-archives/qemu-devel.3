Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CCAC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 23:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8nEI-0008Fr-9k; Mon, 21 Sep 2026 19:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8nEF-0008FN-Ee
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 19:15:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8nEC-0000Fc-GS
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 19:15:19 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LKfhb51751643
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UQ8zSOYCkkH
 K/kjZgPqpPGAkZD9xc9Zh5/gs1YPFwiU=; b=TkuAw9MB52Ywe884F5p7wq/JP3u
 0frob2bPAaFS868vbX9Osaefu12Nse952oJYS2HITkjUpuaor649MlPtL8PQIglG
 NPxSUlyfhcRf1V+Ra3r26ZkkstQYPaXN1SLWHhpJCgTVMOqGHRWcFq5Wdcp9+sOU
 Ge1CpoAEYcnB6TKTqfhsYHfMP4hwyfS7Ep7ESG+dtVe1qNDeVaj0+g69RBz9lR2Q
 IQi56XSZbtOV2vJSE1j59txOOgQM1PegL52DpQ/mkbqADtXZ/KLduU/9Mcm/7I36
 NC+uuckS2Gx0k/q1DypALvbnk3+PzHlt6x2wlgAcbakUt1p7CCisOJGYVFQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu8xes6rv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:15:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-398d0010cfaso5859690a91.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 16:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790032514; x=1790637314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UQ8zSOYCkkHK/kjZgPqpPGAkZD9xc9Zh5/gs1YPFwiU=;
 b=NKm/2B4xIpBbQMZHMCx3LspTmNH5tAWzw+6IyNdwoGXLwzOxp251qa3DMr+5ov/9hh
 pYkvT9PKIwDL8MF38IWQI2vV2W+wzTO9l1uvBlbY/acl4qUX03jZdlUx1kuR6Fov44r6
 LWwqa3jw9/metmji/bP0XQHR9O09OIE+Fkd86s2PIsDvBmV3atXjxQg9vAAHSGjiDagE
 jbmWlf+9krGPOXyQW4lkG+jxsLn2qPfSJ60IsWO4w2e25Dinm63KGcwpRIhKjzqpGEXb
 iC8UURpqfR9iJPErkEw6VrcvvL4TBuKETgWNm+l8Bh0aYHuYgcnDJ7qiO2am3QKtUTye
 hFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790032514; x=1790637314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UQ8zSOYCkkHK/kjZgPqpPGAkZD9xc9Zh5/gs1YPFwiU=;
 b=TOkoChzMcFYLq6jLx9ybttKAH7HnGSTaZGUHgrN/9CeJDkWW6eE7nUbViipNKm7cM2
 LcuZcS5xM9oEHjaS2VhWrgY3yBcxkWfbLnteNOjgWhUEG+21zVAGb8EMyZgVNXNmwHP5
 wjsDxbhtcdHCcV5WJscFgY6/VkehK5PkRe3a1Ijup5LSLK0p4ddDg+Y1iW9SjK2Ps4u4
 pSsJfgwkCnYF8fCqg7duXOtYt6viwJoI3tuDQ6p4CSYQGQYiK3hBwdGObEBkOcXmr07W
 ZuNdnAmRJdRmTGvAOgkb3iqpTBesInKGkM9udwDHuOHDF9uvETbF9JDsfDzA3iZkO3kw
 h2JQ==
X-Gm-Message-State: AFuF++lvdPGEn5DH3q56CYym0QoV0sMcoWv6jzikOdTK6QUvanPwLLap
 mfUyV89caMR+CXBT9pfS+NNXb3QCrhKWGmtLviCYilI2puO1Fq+itQOk/U8yQajBWVKnw5bXxk0
 KjMAbvTb3jFXwd97b2ulMjjT1gZe+pmOm8aIPZNX0G88TDqh8kqKlpNQfq8JgvNVsIQ==
X-Gm-Gg: AYBFou2oBBkpExEztj6a2er7Iod3pxgRsllhAho3iabdOlqwnJTkdBBWSljpaaw7i6Q
 duzyoXxan/ym8PMBwJ6JIeNA1+rXZqSDqwGTJPVkbX1DxwfjZzY8t39GX6SPUpOJAFN6FwJKABY
 k7Jvr22o2vKZfMn0Irb9I2oIrO09GCU1gnQUzvdHB8az3oh9IsAUcWkNDtHmXbMbj1+gfegQqUZ
 dANtQqG1bh6yZ32kqX+9bYfcOctBtd66n+Uo/sg1zXcLB9N6fbgqLyEf44nIkYZ93H9qnvQApxp
 GEKFeX0ARQ8z/BpGUDeNo095R3t7P20FuJKDIqtDoAUDwhn1E0uvro0H71d86zbPpbDeNsurLV1
 Wc7HUAjoM41NY8vkFOshBup7yo+jfAzY2kevQIkoOdXJIZiKql+3mzV2/akasBQ==
X-Received: by 2002:a17:90b:5587:b0:3a0:309d:5549 with SMTP id
 98e67ed59e1d1-3a04b116fcamr5283208a91.8.1790032513985; 
 Mon, 21 Sep 2026 16:15:13 -0700 (PDT)
X-Received: by 2002:a17:90b:5587:b0:3a0:309d:5549 with SMTP id
 98e67ed59e1d1-3a04b116fcamr5283182a91.8.1790032513097; 
 Mon, 21 Sep 2026 16:15:13 -0700 (PDT)
Received: from localhost.localdomain (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0674c0b4bsm1295939a91.13.2026.09.21.16.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 16:15:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 6/7] tests/tcg/meson.build: remove cc_docker_host_arch
Date: Mon, 21 Sep 2026 23:14:57 +0000
Message-ID: <20260921231458.3369-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Zs5RFxjiJdOpDuDh0oX7LTnLY5jnqfe8
X-Authority-Analysis: v=2.4 cv=PZhqFShd c=1 sm=1 tr=0 ts=6ab1ba83 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=lf3uF_WxYAFngkJIBPEA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: Zs5RFxjiJdOpDuDh0oX7LTnLY5jnqfe8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDM0MCBTYWx0ZWRfX5PwCJNInBiy+
 tkTUtLdi9MB/v2MZOJvvnMgxdqPZqqWOGL3z5V9lluWNCTHITRnCfOU5BSTwEtkePQCFOMc/gh+
 pvcj+V/5Yh9yIxXs76NGUvi8ZFUE21SS3zWbdWyb4qhk8nIIDJ6bkro1owT/h7k85Z8vbYymZnx
 OIC8Mj3+03skcnYMEQCVUeoDuAboEM6WMvI5ihs75Rzx3KlcZ7XhqUByHPUVL8VPXKxBuPhk8Iw
 iPwr+Afoe8dtR7KbCGVurLVpMwL98ma8HAvKjCUfQoBXXO1WNAth20Bspgrf65JQAdOX+NsU2Zu
 CIlRMbxE3YFQqiAVfEfJT6qeCzby2TT/jt/7YrUc3wkQU/5S7rBPU8NEekdMJ+NSnF6RpgulIsV
 ZozXkzYYny6p/4S9hO3/XvKVKJ4t4lI5hoRGb/uXXJsSa+LxTMjNVI/BIEqpHdyLayokk7037an
 ogcgeF1+qFTOI+4JCTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDM0MCBTYWx0ZWRfXx8yqqCPamxZW
 lGdFYits5EsGdFJZ//GkU9MRNR88FRUUTBjOccOIqFY6slgyflRdEUHjNFRM64Vj6Kq31mBrtFY
 WdUZA3s0pdHg/RyFWKX4NqgpPjp4/dY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210340
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

Now we know all container images used for tcg-tests are x86_64 only, we
don't need to specify anymore which arch they support.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/meson.build            |  2 --
 tests/tcg/aarch64/system/meson.build     |  1 -
 tests/tcg/aarch64_be/meson.build         |  1 -
 tests/tcg/alpha/meson.build              |  2 --
 tests/tcg/alpha/system/meson.build       |  1 -
 tests/tcg/arm/meson.build                |  2 --
 tests/tcg/arm/system/meson.build         |  1 -
 tests/tcg/hexagon/meson.build            |  1 -
 tests/tcg/hppa/meson.build               |  1 -
 tests/tcg/i386/meson.build               |  2 --
 tests/tcg/i386/system/meson.build        |  1 -
 tests/tcg/loongarch64/meson.build        |  2 --
 tests/tcg/loongarch64/system/meson.build |  1 -
 tests/tcg/m68k/meson.build               |  1 -
 tests/tcg/meson.build                    | 11 +----------
 tests/tcg/mips/meson.build               |  1 -
 tests/tcg/mips64/meson.build             |  1 -
 tests/tcg/mips64el/meson.build           |  1 -
 tests/tcg/or1k/meson.build               |  1 -
 tests/tcg/ppc64/meson.build              |  1 -
 tests/tcg/ppc64le/meson.build            |  1 -
 tests/tcg/riscv64/meson.build            |  2 --
 tests/tcg/riscv64/system/meson.build     |  1 -
 tests/tcg/s390x/meson.build              |  2 --
 tests/tcg/s390x/system/meson.build       |  1 -
 tests/tcg/sh4/meson.build                |  1 -
 tests/tcg/tricore/meson.build            |  1 -
 tests/tcg/x86_64/meson.build             |  2 --
 tests/tcg/x86_64/system/meson.build      |  1 -
 tests/tcg/xtensa/meson.build             |  3 ---
 30 files changed, 1 insertion(+), 49 deletions(-)

diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
index 28498e82cba..cc2c59fb4b6 100644
--- a/tests/tcg/aarch64/meson.build
+++ b/tests/tcg/aarch64/meson.build
@@ -1,6 +1,5 @@
 cc = 'aarch64-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
-cc_docker_host_arch = ['aarch64', 'x86_64']
 
 cc_feat_cflags = {
   'aes': '-march=armv8-a+aes',
@@ -198,7 +197,6 @@ if 'qemu-aarch64' in emulators
     'aarch64-linux-user': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'aarch64',
       'gdb_arch': 'aarch64',
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
index 94e16ba3300..6ba35a9f722 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -97,7 +97,6 @@ if 'qemu-system-aarch64' in emulators
     'aarch64-softmmu': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'aarch64/system',
       'gdb_arch': 'aarch64',
diff --git a/tests/tcg/aarch64_be/meson.build b/tests/tcg/aarch64_be/meson.build
index 9ea111f9885..e45a49ec2da 100644
--- a/tests/tcg/aarch64_be/meson.build
+++ b/tests/tcg/aarch64_be/meson.build
@@ -11,7 +11,6 @@ if 'qemu-aarch64_be' in emulators
     'aarch64_be-linux-user': {
       'cc': 'aarch64-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['aarch64', 'x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'aarch64_be',
       'gdb_arch': 'aarch64_be',
diff --git a/tests/tcg/alpha/meson.build b/tests/tcg/alpha/meson.build
index fe60ce2496a..30ea2a6978e 100644
--- a/tests/tcg/alpha/meson.build
+++ b/tests/tcg/alpha/meson.build
@@ -1,6 +1,5 @@
 cc = 'alpha-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
-cc_docker_host_arch = ['aarch64', 'x86_64']
 
 subdir('system')
 
@@ -45,7 +44,6 @@ if 'qemu-alpha' in emulators
     'alpha-linux-user': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'alpha',
       'gdb_arch': 'alpha',
       'qemu': emulators['qemu-alpha'],
diff --git a/tests/tcg/alpha/system/meson.build b/tests/tcg/alpha/system/meson.build
index b10f2c3e28d..5388e17a2f7 100644
--- a/tests/tcg/alpha/system/meson.build
+++ b/tests/tcg/alpha/system/meson.build
@@ -37,7 +37,6 @@ if 'qemu-system-alpha' in emulators
     'alpha-softmmu': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'alpha/system',
       'gdb_arch': 'alpha',
       'qemu': emulators['qemu-system-alpha'],
diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
index 1b491cea026..30154efaec8 100644
--- a/tests/tcg/arm/meson.build
+++ b/tests/tcg/arm/meson.build
@@ -1,6 +1,5 @@
 cc = 'arm-linux-gnueabihf-gcc'
 cc_dockerfile = 'debian-all-test-cross'
-cc_docker_host_arch = ['aarch64', 'x86_64']
 
 subdir('system')
 
@@ -70,7 +69,6 @@ if 'qemu-arm' in emulators
     'arm-linux-user': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'arm',
       'gdb_arch': 'arm',
       'qemu': emulators['qemu-arm'],
diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
index 52869976704..93d0cfec24e 100644
--- a/tests/tcg/arm/system/meson.build
+++ b/tests/tcg/arm/system/meson.build
@@ -65,7 +65,6 @@ if 'qemu-system-arm' in emulators
     'arm-softmmu': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'arm/system',
       'gdb_arch': 'arm',
       'qemu': emulators['qemu-system-arm'],
diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
index 6e36a9a1220..f3d20091aa9 100644
--- a/tests/tcg/hexagon/meson.build
+++ b/tests/tcg/hexagon/meson.build
@@ -111,7 +111,6 @@ if 'qemu-hexagon' in emulators
     'hexagon-linux-user': {
       'cc': 'hexagon-unknown-linux-musl-clang',
       'cc_dockerfile': 'debian-hexagon-cross',
-      'cc_docker_host_arch': ['x86_64'],
       'folder': 'hexagon',
       'gdb_arch': 'hexagon_is_not_supported_by_gdb',
       'qemu': emulators['qemu-hexagon'],
diff --git a/tests/tcg/hppa/meson.build b/tests/tcg/hppa/meson.build
index 9ca8f29fa93..01d4554d993 100644
--- a/tests/tcg/hppa/meson.build
+++ b/tests/tcg/hppa/meson.build
@@ -11,7 +11,6 @@ if 'qemu-hppa' in emulators
     'hppa-linux-user': {
       'cc': 'hppa-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'hppa',
       'gdb_arch': 'hppa',
diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index 5cda03655fa..04d438a062a 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -1,6 +1,5 @@
 cc = 'i686-linux-gnu-gcc'
 cc_dockerfile = 'debian-i686-cross'
-cc_docker_host_arch = ['x86_64']
 
 subdir('system')
 
@@ -48,7 +47,6 @@ if 'qemu-i386' in emulators
     'i386-linux-user': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'i386',
       'gdb_arch': 'i386',
       'qemu': emulators['qemu-i386'],
diff --git a/tests/tcg/i386/system/meson.build b/tests/tcg/i386/system/meson.build
index d3f73997c7f..0986f5898d4 100644
--- a/tests/tcg/i386/system/meson.build
+++ b/tests/tcg/i386/system/meson.build
@@ -39,7 +39,6 @@ if 'qemu-system-i386' in emulators
     'i386-softmmu': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'i386/system',
       'gdb_arch': 'i386',
       'qemu': emulators['qemu-system-i386'],
diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
index 1d62de64ed6..4dd64f16d87 100644
--- a/tests/tcg/loongarch64/meson.build
+++ b/tests/tcg/loongarch64/meson.build
@@ -1,6 +1,5 @@
 cc = 'loongarch64-unknown-linux-gnu-gcc'
 cc_dockerfile = 'debian-loongarch-cross'
-cc_docker_host_arch = ['x86_64']
 
 subdir('system')
 
@@ -22,7 +21,6 @@ if 'qemu-loongarch64' in emulators
     'loongarch64-linux-user': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'loongarch64',
       'gdb_arch': 'loongarch64',
       'qemu': emulators['qemu-loongarch64'],
diff --git a/tests/tcg/loongarch64/system/meson.build b/tests/tcg/loongarch64/system/meson.build
index 5bf4c56e385..035dd5f85fb 100644
--- a/tests/tcg/loongarch64/system/meson.build
+++ b/tests/tcg/loongarch64/system/meson.build
@@ -38,7 +38,6 @@ if 'qemu-system-loongarch64' in emulators
     'loongarch64-softmmu': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'loongarch64/system',
       'gdb_arch': 'loongarch64',
       'qemu': emulators['qemu-system-loongarch64'],
diff --git a/tests/tcg/m68k/meson.build b/tests/tcg/m68k/meson.build
index 8ecf450ac68..4b73d7fc57d 100644
--- a/tests/tcg/m68k/meson.build
+++ b/tests/tcg/m68k/meson.build
@@ -12,7 +12,6 @@ if 'qemu-m68k' in emulators
     'm68k-linux-user': {
       'cc': 'm68k-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'm68k',
       'gdb_arch': 'm68k',
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4cf4865461e..f46516d6e72 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -22,7 +22,6 @@ tcg_tests = {}
 #   'name_of_target': {
 #     'cc': 'cross_compiler',
 #     'cc_dockerfile': 'name_of_dockerfile',
-#     'cc_docker_host_arch': ['host_arch_supported (meson cpu)', ...],
 #     'cc_feat_cflags': {
 #       'name': ['feature cflags'],
 #       ...
@@ -208,7 +207,7 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'cc_dockerfile', 'cc_docker_host_arch', 'cc_feat_cflags',
+    allowed = ['cc', 'cc_dockerfile', 'cc_feat_cflags',
                'folder', 'gdb_arch', 'gdb_feat_version', 'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
@@ -255,14 +254,6 @@ foreach target, plan: tcg_tests
 
   if 'cc_dockerfile' in plan
     cc_dockerfile = plan['cc_dockerfile']
-    cc_docker_host_arch = plan['cc_docker_host_arch']
-    allowed = ['aarch64', 'x86_64']
-    foreach arch: cc_docker_host_arch
-      if arch not in allowed
-        error('incorrect docker arch ' + arch + ' for target ' +
-              target + ' (possible: [' + ', '.join(allowed) + '])')
-      endif
-    endforeach
     dockerfile = files('..'/'docker'/'dockerfiles'/cc_dockerfile + '.docker')
     image_name = 'image-' + cc_dockerfile
     if cc_dockerfile not in image_targets and docker_supported
diff --git a/tests/tcg/mips/meson.build b/tests/tcg/mips/meson.build
index 3c4f6ec482d..efda857ab61 100644
--- a/tests/tcg/mips/meson.build
+++ b/tests/tcg/mips/meson.build
@@ -14,7 +14,6 @@ if 'qemu-mips' in emulators
     'mips-linux-user': {
       'cc': 'mips-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['aarch64', 'x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'mips',
       'gdb_arch': 'mips',
diff --git a/tests/tcg/mips64/meson.build b/tests/tcg/mips64/meson.build
index 69391c23187..b8eb6705eae 100644
--- a/tests/tcg/mips64/meson.build
+++ b/tests/tcg/mips64/meson.build
@@ -16,7 +16,6 @@ if 'qemu-mips64' in emulators
     'mips64-linux-user': {
       'cc': 'mips64-linux-gnuabi64-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['aarch64', 'x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'mips64',
       'gdb_arch': 'mips64',
diff --git a/tests/tcg/mips64el/meson.build b/tests/tcg/mips64el/meson.build
index f6c0fae7981..2aafbba750d 100644
--- a/tests/tcg/mips64el/meson.build
+++ b/tests/tcg/mips64el/meson.build
@@ -3,7 +3,6 @@ if 'qemu-mips64el' in emulators
     'mips64el-linux-user': {
       'cc': 'mips64el-linux-gnuabi64-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['aarch64', 'x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'mips64el',
       'gdb_arch': 'mips64el',
diff --git a/tests/tcg/or1k/meson.build b/tests/tcg/or1k/meson.build
index 5151e8f361f..c89bb372b47 100644
--- a/tests/tcg/or1k/meson.build
+++ b/tests/tcg/or1k/meson.build
@@ -61,7 +61,6 @@ if 'qemu-or1k' in emulators
     'or1k-linux-user': {
       'cc': 'or1k-none-linux-musl-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'or1k',
       'gdb_arch': 'or1k',
diff --git a/tests/tcg/ppc64/meson.build b/tests/tcg/ppc64/meson.build
index c7e495f3d34..8cca4d65a4c 100644
--- a/tests/tcg/ppc64/meson.build
+++ b/tests/tcg/ppc64/meson.build
@@ -44,7 +44,6 @@ if 'qemu-ppc64' in emulators
     'ppc64-linux-user': {
       'cc': 'powerpc64-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'ppc64',
       'gdb_arch': 'ppc64',
diff --git a/tests/tcg/ppc64le/meson.build b/tests/tcg/ppc64le/meson.build
index 720aa167f23..a0f3e62e4d3 100644
--- a/tests/tcg/ppc64le/meson.build
+++ b/tests/tcg/ppc64le/meson.build
@@ -3,7 +3,6 @@ if 'qemu-ppc64le' in emulators
     'ppc64le-linux-user': {
       'cc': 'powerpc64le-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'ppc64le',
       'gdb_arch': 'ppc64le',
diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
index 2292bf8ed1b..5ee20a1e98d 100644
--- a/tests/tcg/riscv64/meson.build
+++ b/tests/tcg/riscv64/meson.build
@@ -1,6 +1,5 @@
 cc = 'riscv64-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
-cc_docker_host_arch = ['aarch64', 'x86_64']
 
 subdir('system')
 
@@ -28,7 +27,6 @@ if 'qemu-riscv64' in emulators
     'riscv64-linux-user': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'riscv64',
       'gdb_arch': 'riscv64',
       'qemu': emulators['qemu-riscv64'],
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 8604c2a45a9..87c3f9f11ce 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -66,7 +66,6 @@ if 'qemu-system-riscv64' in emulators
     'riscv64-softmmu': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'riscv64',
       'gdb_arch': 'riscv64',
       'qemu': emulators['qemu-system-riscv64'],
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
index c9af66aa1b0..35e27b47141 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -1,6 +1,5 @@
 cc = 's390x-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
-cc_docker_host_arch = ['aarch64', 'x86_64']
 
 cc_feat_cflags = {
   'z14': '-march=z14',
@@ -131,7 +130,6 @@ if 'qemu-s390x' in emulators
     's390x-linux-user': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 's390x',
       'gdb_arch': 's390x',
diff --git a/tests/tcg/s390x/system/meson.build b/tests/tcg/s390x/system/meson.build
index 1e360e70821..ef19c4831fd 100644
--- a/tests/tcg/s390x/system/meson.build
+++ b/tests/tcg/s390x/system/meson.build
@@ -83,7 +83,6 @@ if 'qemu-system-s390x' in emulators
     's390x-softmmu': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 's390x',
       'gdb_arch': 's390x',
diff --git a/tests/tcg/sh4/meson.build b/tests/tcg/sh4/meson.build
index d73df074497..12b24fffc77 100644
--- a/tests/tcg/sh4/meson.build
+++ b/tests/tcg/sh4/meson.build
@@ -14,7 +14,6 @@ if 'qemu-sh4' in emulators
     'sh4-linux-user': {
       'cc': 'sh4-linux-gnu-gcc',
       'cc_dockerfile': 'debian-all-test-cross',
-      'cc_docker_host_arch': ['aarch64', 'x86_64'],
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'sh4',
       'gdb_arch': 'sh4',
diff --git a/tests/tcg/tricore/meson.build b/tests/tcg/tricore/meson.build
index d0bf55dedce..837a3d5e22f 100644
--- a/tests/tcg/tricore/meson.build
+++ b/tests/tcg/tricore/meson.build
@@ -47,7 +47,6 @@ if 'qemu-system-tricore' in emulators
     'tricore-softmmu': {
       'cc': 'tricore-gcc',
       'cc_dockerfile': 'debian-tricore-cross',
-      'cc_docker_host_arch': ['x86_64'],
       'folder': 'tricore',
       'gdb_arch': 'tricore',
       'qemu': emulators['qemu-system-tricore'],
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index ab336eca9b2..787a2ca61b2 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -1,6 +1,5 @@
 cc = 'x86_64-linux-gnu-gcc'
 cc_dockerfile = 'debian-amd64-cross'
-cc_docker_host_arch = ['x86_64']
 
 subdir('system')
 
@@ -74,7 +73,6 @@ if 'qemu-x86_64' in emulators
     'x86_64-linux-user': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'x86_64',
       'gdb_arch': 'x86_64',
       'qemu': emulators['qemu-x86_64'],
diff --git a/tests/tcg/x86_64/system/meson.build b/tests/tcg/x86_64/system/meson.build
index 80110d0ae57..43e7d7afa85 100644
--- a/tests/tcg/x86_64/system/meson.build
+++ b/tests/tcg/x86_64/system/meson.build
@@ -53,7 +53,6 @@ if 'qemu-system-x86_64' in emulators
     'x86_64-softmmu': {
       'cc': cc,
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'x86_64/system',
       'gdb_arch': 'x86_64',
       'qemu': emulators['qemu-system-x86_64'],
diff --git a/tests/tcg/xtensa/meson.build b/tests/tcg/xtensa/meson.build
index bb1dd1542e5..5ff9c6cd548 100644
--- a/tests/tcg/xtensa/meson.build
+++ b/tests/tcg/xtensa/meson.build
@@ -79,14 +79,12 @@ foreach core: cores
 endforeach
 
 cc_dockerfile = 'debian-xtensa-cross'
-cc_docker_host_arch = ['x86_64']
 
 if 'qemu-system-xtensa' in emulators
   tcg_tests += {
     'xtensa-softmmu': {
       'cc': 'xtensa-dc232b-elf-gcc',
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'xtensa',
       'gdb_arch': 'xtensa',
       'qemu': emulators['qemu-system-xtensa'],
@@ -100,7 +98,6 @@ if 'qemu-system-xtensaeb' in emulators
     'xtensaeb-softmmu': {
       'cc': 'xtensa-test_kc705_be-elf-gcc',
       'cc_dockerfile': cc_dockerfile,
-      'cc_docker_host_arch': cc_docker_host_arch,
       'folder': 'xtensa',
       'gdb_arch': 'xtensaeb',
       'qemu': emulators['qemu-system-xtensaeb'],
-- 
2.43.0


