Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E96C98328
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAA8A-0008FJ-VL; Fri, 25 Sep 2026 13:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA85-0008D6-A3
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA82-0000fT-Oe
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:37 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PGspvG2083412
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4zFP2x/CykwhMx1RQbYna1UvaI174FXFdmcKa/1q4oM=; b=b+nwUcHGkqwhHxE9
 pKzXtTFb438kEBaziGIAlyafQSrliNb1akLLESApK0nG8sREIi/91rd6G13zs/J3
 D1pTtBVuWIvbC3oiMvHdMdxogDo2m+yAQhg9rJUAzBl8crH3DNcoSu8Ur4ZtbQMV
 6Z/csL05zO31SdxSEV5aZTJVhE+YsId1dYc+QBnwVB1ayPrW/VvE5THyIx3ibov8
 Mkm/Se07tyTQBZ2OSnK6URTCeTRVQp+/BFiNQ7JBE28FeAZxcP/lKLUQdvUvfDIf
 oZPIbhITqRR0UP+cmW5inVf35S5eA1SVVSdGrrXCGP31pDVt9YqtDQffQ3WxouBy
 a9wvRw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwvw1g78j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:23 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3282d5302ffso1480444eec.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790358863; x=1790963663; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4zFP2x/CykwhMx1RQbYna1UvaI174FXFdmcKa/1q4oM=;
 b=erEUruKJMylOwl/XAfq9C+j/YgYqlaitugk6AuFrs/kFcOduAjgpbj+H2ucbFaRcA0
 YkNu/ex+bIU+A9OW3HhKOd7kkfSYRzhD3L/10W/Xy3R2DqhGQm1L5NSyn7ileuyJfiCC
 7SagbrIeRhu30oe6Eh1S8vA+4yeZsyHwdjRyOLmogCJ3wVxRDNfTXHuCGtiF+l7FMVx+
 S8s5dsTlUFQoWUwNH/DRzMtUlwehK55J93falDi1+exlxSUMhJPsanoJ9lFytNd4fNn1
 bcS5BJLdUUvE6hI9xKfrAA/vfDTEmAWMdT/OqUM9aHYF+XzMPnpmCflbZ2KG1UxIhccN
 v7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790358863; x=1790963663;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4zFP2x/CykwhMx1RQbYna1UvaI174FXFdmcKa/1q4oM=;
 b=rXrKwyf2D7CG9FgHu9AGUc4NIa0XlySxkRr8cyMUcvEc0WMjFrAoUubhIyCyfBnk+Y
 OkNfAGrECJQiMakkQ940zK85qqDQWfx6kyHFQ1p5Bk2RsL2+RRT4n5qJaunq63Q/RCeH
 m/+LJlpvoNvXVXSO8GNm/DP+m9H9L88fHhdyAQ6uqOt3VmIAMNKv6pc6k/mTP98UrNC2
 EF9nL3BMz5QpHcYPJURFPGHk3ff1isVhhiGk4BSts5S7Q3fOnSw/pPD2ACSaN89yfUSI
 EHKWksLPsbHUMUUEzsXyC0JpPEexP05qTNM70r5gVdYl+cs0I1mfSp2LONxNxVNzKAXg
 INOw==
X-Gm-Message-State: AFuF++kDOa+qIIuDh4w+JuAImtqhVlQPW5qHTuf8zzhDJ6x2A0mFQvNK
 LtGzG6fVYWd25wq4VN9+UvoIvHPcQBOUe6s+xB4AcLYlrWm6pIr0eG1MaA5WHpOq5zfsEBlWLel
 slWliSTfJz2IVNUqgR2YBJGd4PIcC0SnekqoIWhIt6PrWvWXDYq1+dxR7KU8p+2nSLA==
X-Gm-Gg: AYBFou1lQJIe/Fs3JmjBhsX3ydcmDB1DBmS6eH6785vBrGoy95nCile2xvfQM123VJa
 kuerdih5CgibcMBw+W9JrebN8y+rvieC5uWogKQ24b5FtRZNgV+VDIpL+lFBPITbwodmWXVyUh9
 218EUy0kkL8jOOOzOsCqBbCaXzaPsek/v40wYQ5/4cb7dj1DQkvZVQk/9h9YjhRd4nzTJAKbVi9
 2pECwZUFKVbIO+pRUpA8sR6tgLe3275wzzf62w1ZGBfQqT+4aExMyoQPCbWo3saSV4EqJ8A9XFO
 9AHo3TwTLN+XGWveILRpAaQORsRXHmCP0AseaDeH9UJaivvEj7DrxLf3rWbcgyNDDff1cxqPngX
 Mx5bomjcpOToNGFokmBfeQE1E5INM9iCPo+uQteiQbz5FkP+LJt0pCtWfig==
X-Received: by 2002:a05:693c:42c9:b0:32e:f6a4:ca8e with SMTP id
 5a478bee46e88-34270ab8d57mr746116eec.11.1790358862601; 
 Fri, 25 Sep 2026 10:54:22 -0700 (PDT)
X-Received: by 2002:a05:693c:42c9:b0:32e:f6a4:ca8e with SMTP id
 5a478bee46e88-34270ab8d57mr746098eec.11.1790358861911; 
 Fri, 25 Sep 2026 10:54:21 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144172de6sm11055128eec.9.2026.09.25.10.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 10:54:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 12/13] tests/tcg: add alternative cross-compilers for fedora
Date: Fri, 25 Sep 2026 10:53:59 -0700
Message-ID: <20260925175400.1897574-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7e5YY3sKXN8CiZhx9aMPl-LmeEG4OPGV
X-Authority-Analysis: v=2.4 cv=YqCa1IYX c=1 sm=1 tr=0 ts=6ab6b54f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=vTr9H3xdAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=UsS_lcMcihzkK3EOuUkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 7e5YY3sKXN8CiZhx9aMPl-LmeEG4OPGV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX0kMxHDkrUcdl
 7auhCbL1XlZITy3EfznSf63/IkpwnkLNmmxwIK6wd0G3KWqD7Z6bW+DC9s/sfmiIH2ilVelqa26
 LAzBz/ZCnm6Y1XJphR37pQUsYI18Q13khX3kV71b/bnBM5HdKjj6X7I0YEQjsMshGmWjr9fYWsV
 hsb32uwC0ueEljAJQbmlqagx0G7vyYS6ShsqXnY17H6YfwF8+iyvfglvdP63vvdI6RXJy9SD9C4
 dK7qmMJw25dct4wrEHMPq8lmurzxtg+/RgxcyGqImPEt/RYCWikAJG8DzjCLb4m3AOXpC9CwOxx
 iE6q9AO/2ISF6uCLMQr1qn5sVH0A5cevOwmRXAQo/zmKE1HM9wVsHtr53yMz685okZAMFchVOEt
 j/LSoyXMwuZg77KxN/DgCdYpDu9QLeBcynRLI2X8z9wmiQRbJU0fYZZBzxalBJcJ/TkatchbdPO
 qac9DXMZWfxz4Xh8KEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX4R344yhMOv7N
 tWU6x5LGlYprzoigd+D06HTZ2D51yosS4U7IhulETU7MeOsBUo1rfxL9vm9R2ieN376qVpySPMY
 qgsB7LFItmqniTtkc1mSoF53NMT5N9o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250071
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

This allows to pick host compiler automatically on fedora, as those
binaries are installed with 'gcc' package.

This covers all host arch supported to this day:
https://fedoraproject.org/wiki/Architectures
- x86_64
- aarch64
- ppc64le
- riscv64
- s390x
Note: QEMU and Fedora don't support 32-bit hosts anymore.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260924213942.26491-4-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/meson.build        | 2 ++
 tests/tcg/aarch64/system/meson.build | 1 +
 tests/tcg/aarch64_be/meson.build     | 1 +
 tests/tcg/ppc64le/meson.build        | 1 +
 tests/tcg/riscv64/meson.build        | 2 ++
 tests/tcg/riscv64/system/meson.build | 1 +
 tests/tcg/s390x/meson.build          | 2 ++
 tests/tcg/s390x/system/meson.build   | 1 +
 tests/tcg/x86_64/meson.build         | 2 ++
 tests/tcg/x86_64/system/meson.build  | 1 +
 10 files changed, 14 insertions(+)

diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
index cc2c59fb4b6..1cec335df04 100644
--- a/tests/tcg/aarch64/meson.build
+++ b/tests/tcg/aarch64/meson.build
@@ -1,4 +1,5 @@
 cc = 'aarch64-linux-gnu-gcc'
+cc_alt = ['aarch64-redhat-linux-gcc']
 cc_dockerfile = 'debian-all-test-cross'
 
 cc_feat_cflags = {
@@ -196,6 +197,7 @@ if 'qemu-aarch64' in emulators
   tcg_tests += {
     'aarch64-linux-user': {
       'cc': cc,
+      'cc_alt': cc_alt,
       'cc_dockerfile': cc_dockerfile,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'aarch64',
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
index 6ba35a9f722..fb3b33861ea 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -96,6 +96,7 @@ if 'qemu-system-aarch64' in emulators
   tcg_tests += {
     'aarch64-softmmu': {
       'cc': cc,
+      'cc_alt': cc_alt,
       'cc_dockerfile': cc_dockerfile,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'aarch64/system',
diff --git a/tests/tcg/aarch64_be/meson.build b/tests/tcg/aarch64_be/meson.build
index e45a49ec2da..509408de8e7 100644
--- a/tests/tcg/aarch64_be/meson.build
+++ b/tests/tcg/aarch64_be/meson.build
@@ -10,6 +10,7 @@ if 'qemu-aarch64_be' in emulators
   tcg_tests += {
     'aarch64_be-linux-user': {
       'cc': 'aarch64-linux-gnu-gcc',
+      'cc_alt': ['aarch64-redhat-linux-gcc'],
       'cc_dockerfile': 'debian-all-test-cross',
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'aarch64_be',
diff --git a/tests/tcg/ppc64le/meson.build b/tests/tcg/ppc64le/meson.build
index a0f3e62e4d3..9f386287e7a 100644
--- a/tests/tcg/ppc64le/meson.build
+++ b/tests/tcg/ppc64le/meson.build
@@ -2,6 +2,7 @@ if 'qemu-ppc64le' in emulators
   tcg_tests += {
     'ppc64le-linux-user': {
       'cc': 'powerpc64le-linux-gnu-gcc',
+      'cc_alt': ['ppc64le-redhat-linux-gcc'],
       'cc_dockerfile': 'debian-all-test-cross',
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'ppc64le',
diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
index 5ee20a1e98d..91c840b0058 100644
--- a/tests/tcg/riscv64/meson.build
+++ b/tests/tcg/riscv64/meson.build
@@ -1,4 +1,5 @@
 cc = 'riscv64-linux-gnu-gcc'
+cc_alt = ['riscv64-redhat-linux-gnu-gcc']
 cc_dockerfile = 'debian-all-test-cross'
 
 subdir('system')
@@ -26,6 +27,7 @@ if 'qemu-riscv64' in emulators
   tcg_tests += {
     'riscv64-linux-user': {
       'cc': cc,
+      'cc_alt': cc_alt,
       'cc_dockerfile': cc_dockerfile,
       'folder': 'riscv64',
       'gdb_arch': 'riscv64',
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 87c3f9f11ce..c87e3eee1ad 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -65,6 +65,7 @@ if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
       'cc': cc,
+      'cc_alt': cc_alt,
       'cc_dockerfile': cc_dockerfile,
       'folder': 'riscv64',
       'gdb_arch': 'riscv64',
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
index 1f9aa57fc73..f2328d9e5cf 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -1,4 +1,5 @@
 cc = 's390x-linux-gnu-gcc'
+cc_alt = ['s390x-redhat-linux-gcc']
 cc_dockerfile = 'debian-all-test-cross'
 
 cc_feat_cflags = {
@@ -140,6 +141,7 @@ if 'qemu-s390x' in emulators
   tcg_tests += {
     's390x-linux-user': {
       'cc': cc,
+      'cc_alt': cc_alt,
       'cc_dockerfile': cc_dockerfile,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 's390x',
diff --git a/tests/tcg/s390x/system/meson.build b/tests/tcg/s390x/system/meson.build
index ef19c4831fd..359d124cc78 100644
--- a/tests/tcg/s390x/system/meson.build
+++ b/tests/tcg/s390x/system/meson.build
@@ -82,6 +82,7 @@ if 'qemu-system-s390x' in emulators
   tcg_tests += {
     's390x-softmmu': {
       'cc': cc,
+      'cc_alt': cc_alt,
       'cc_dockerfile': cc_dockerfile,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 's390x',
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index cfeef1d969c..968fe27cfc5 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -1,4 +1,5 @@
 cc = 'x86_64-linux-gnu-gcc'
+cc_alt = ['x86_64-redhat-linux-gcc']
 cc_dockerfile = 'debian-amd64-cross'
 
 subdir('system')
@@ -72,6 +73,7 @@ if 'qemu-x86_64' in emulators
   tcg_tests += {
     'x86_64-linux-user': {
       'cc': cc,
+      'cc_alt': cc_alt,
       'cc_dockerfile': cc_dockerfile,
       'folder': 'x86_64',
       'gdb_arch': 'x86_64',
diff --git a/tests/tcg/x86_64/system/meson.build b/tests/tcg/x86_64/system/meson.build
index 43e7d7afa85..08b770d43ae 100644
--- a/tests/tcg/x86_64/system/meson.build
+++ b/tests/tcg/x86_64/system/meson.build
@@ -52,6 +52,7 @@ if 'qemu-system-x86_64' in emulators
   tcg_tests += {
     'x86_64-softmmu': {
       'cc': cc,
+      'cc_alt': cc_alt,
       'cc_dockerfile': cc_dockerfile,
       'folder': 'x86_64/system',
       'gdb_arch': 'x86_64',
-- 
2.47.3


