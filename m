Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28598C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAA81-0008Ao-OG; Fri, 25 Sep 2026 13:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7s-00088M-2A
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7m-0000do-H9
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:23 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG0JM51363017
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EIEz09rL/rO
 mvsiv4h9ZY3NjAIGbE0ivwp2YtIUzh68=; b=TtM767NcgRJALWK4Nuk2PsqITvK
 5zE989AQJ5mdcV3C1jM6rsoipIHCf8aHJH/tQSyTbhnczjrik09SoeGyckNFRT0h
 wcBWx96lm8Sd+xhlPZYJZoYLAkkVKCV3EfmyScjH40YI6HXbKa6JmmMteqqL0M92
 qz8i/KNK21d6g9OwhxwpTpJUj/vkBOlhtazRMilMnn0uDtl7riYR1NOwH6QkSlSi
 J98Jpm/0kK6/2lLxriL4GARDOSs6v4lrbVW5iB06f2erLQg09DRyemRKUAGV4a8K
 jF8V5UbBdNpA/16IK1mjq1KhVIRIip8DYQgxLaRZFgOiR8Sepzal4GlkKdA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwpvnsmm5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:17 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3412efc2661so1454667eec.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790358856; x=1790963656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EIEz09rL/rOmvsiv4h9ZY3NjAIGbE0ivwp2YtIUzh68=;
 b=btq1jHf/aPP52txey7/E/pSKiiRO8HVb8Agys/YDqwnB2IdkBVv1xbN3TmBHUvX0/C
 zJ0neLsbjqp9gRgD2mcyILAwRxFt7GpiyR/sgT90uxRS5Jkc0qe9hWSgkG3YkdZ9/pc3
 UuSf5HXw72cgQHh5idoiyxUujRh5MqYcfy9mEhGqmw3HQtOpWi3qA8FaCzUjmQSet1Qy
 9IOQ99Ff+GGGdyhcKXZgCg6q1VgTPMpiX1xbVimgF1Akvyijewfb4iiadiSXIqlHiEhW
 4FUx+3PDaz/lIqFJmuHTY1EYftjc34ysGFA+E4UF9QV40qwPKvlQM2KAVVBXMlUwzig2
 YKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790358856; x=1790963656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EIEz09rL/rOmvsiv4h9ZY3NjAIGbE0ivwp2YtIUzh68=;
 b=JIJMNd5q1+92bOIEgmsZKbwwupKTRZcAAu7oDM8ra0LOfep4kr2tTlwU9lvA4IEeg/
 jOruEk1Y9Z3Ef6xJ7axDqNOQuMaNBuWzV8wgvyphETaXGYjuxSOuf54dibl8DURQZJlG
 Kjjzbsjvy0+vGcFVWAgF+Wjg5g+TBNxa4ej6VEfmi3DFquzFsYPxOL0YwxkRY0WY8QJ4
 lSQl1fFS1UWJh342PUk8ECVwawY4Pur4NhEORdF4vfGpVYa7QiYVTmPvRDVyFaNQqkrQ
 jAQlh/+UOZitY91MvrXKChAAmFtYu487bs4JVDkQhcaoq+fHS6Fc/PIuNJHyoGKwCLqk
 GNow==
X-Gm-Message-State: AFuF++lY/Zk/Fy728pb8D1O8CHX9ksZns+3Wdus9u6ixoZPP2hrNUNry
 9Pwf80yldgcWciKZG3wg3TNggddFUJP9SWLZoV+MFDpNqBaCUtAZaUIoTOeWkhzRqioLcYX6+On
 ikjQfD7flDFGZvMkZYudH8qtgaWDmulTAaeeqxEbXzJvjLG279nxiTzrAei+0+xEqlw==
X-Gm-Gg: AYBFou31Bqyt18r1vZhNpzW5KBPolaU1nZl9wh6sWExWmqxhEvgcasQUqirnnDpoupb
 tmf/XD9bnznbxu/rswDf8g4Vh4uchneyWzEPke6VAcJKfy3dR7y/sFf0hvaPM1xfnt1i/g8JcNn
 qitB24Joz+Ctkf5olwc/N3tfG69DsdEydGofpH92b4+kMWbEqpo9Wp3d22bVaIcrZmcF/U6ya1W
 znRT/ukzX/V4xwTXHVv3Lxw1VV3puRsVy/XRB5xr6ehzTKA/t0DdeLRzLvP0c++CgTDqUgqi5qT
 +JD2ixPNfChUjRpzybWjnUcd0wtl8vN1Ja6l95as2KOWkOy/qBbHEEcXTcnLn/YqbBj1InXD5tI
 kImpnn3vNJsp2vTuinNwh9n29qzV2IpZWX8HI7Q50Swge9Atzg15t4Aw5Hg==
X-Received: by 2002:a05:7301:6906:b0:33c:20d5:b7e1 with SMTP id
 5a478bee46e88-3427265d58bmr869444eec.33.1790358856120; 
 Fri, 25 Sep 2026 10:54:16 -0700 (PDT)
X-Received: by 2002:a05:7301:6906:b0:33c:20d5:b7e1 with SMTP id
 5a478bee46e88-3427265d58bmr869422eec.33.1790358855383; 
 Fri, 25 Sep 2026 10:54:15 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144172de6sm11055128eec.9.2026.09.25.10.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 10:54:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 07/13] tests/tcg/meson.build: remove cc_docker_host_arch
Date: Fri, 25 Sep 2026 10:53:54 -0700
Message-ID: <20260925175400.1897574-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MqUlFF8FdjPxe3P1_of3fx1_NWOxCk3W
X-Proofpoint-GUID: MqUlFF8FdjPxe3P1_of3fx1_NWOxCk3W
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX8uhe0vs0cDYo
 8r7HvcBG+wkzflpaFbbr/ZXGE37C6jzaVAWzZIi9in5UmABnnkrgiUZN71xO//dU4Q331lfCaar
 ZmpEaKgGbll44Bsze/tFO+K7l2bkCr8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX7p569uWpJOxa
 PvAtYrk8LmGCluUvbo2qBHHjfdZlAmA1DiYOKwtxmMISTUAo3ceDWpi/7Tqc/Xk9XOxMTT3Hevw
 ZLQLhbkFsRO0K5O8oIB3DIKQGt//Idl5npz65+RPjBgOnzFOa7ITPbrhSqTYGBY8ECwtmdOKqnF
 B9yawToEkSmL2VZypjI4AGoFrtuA3CcNDvqsjP1Y9qDwdp4i5ldJYREEY7+Aq6kxHyBdDfxqhq/
 foipZP0NpMFnLsF76rYAACeV4TqduCGoH/2rpHw0mdHFVpy2vNOJ2dKCjnTx+Jvk4P6V8r9CEm6
 crMqpxGfbqPZsjVs4XArBuC0RTly9rwSR1Sg3kOzQudHDRuVPq/W+dxLZUWdvCfE06V7duzb2bN
 1rEoDWs0B6Oue6jKxnb3h1s1dVvH9vYvVGRwDdU+qM26UwVvEpsBHmsmO/YCdVIq0Yc/hU9muCS
 ZawpMHDYXspCHyodUoQ==
X-Authority-Analysis: v=2.4 cv=eNmGH3p1 c=1 sm=1 tr=0 ts=6ab6b549 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lf3uF_WxYAFngkJIBPEA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250071
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

Now we know all container images used for tcg-tests are x86_64 only, we
don't need to specify anymore which arch they support.

Link: https://lore.kernel.org/qemu-devel/20260923185725.863311-5-pierrick.bouvier@oss.qualcomm.com
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
index 5c2af2189c5..8f70411dfd6 100644
--- a/tests/tcg/arm/meson.build
+++ b/tests/tcg/arm/meson.build
@@ -1,6 +1,5 @@
 cc = 'arm-linux-gnueabihf-gcc'
 cc_dockerfile = 'debian-all-test-cross'
-cc_docker_host_arch = ['aarch64', 'x86_64']
 
 subdir('system')
 
@@ -71,7 +70,6 @@ if 'qemu-arm' in emulators
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
index 1cffc63e091..7b220174ff1 100644
--- a/tests/tcg/hexagon/meson.build
+++ b/tests/tcg/hexagon/meson.build
@@ -115,7 +115,6 @@ if 'qemu-hexagon' in emulators
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
index c08563d0ab5..c3a19f43260 100644
--- a/tests/tcg/i386/system/meson.build
+++ b/tests/tcg/i386/system/meson.build
@@ -43,7 +43,6 @@ if 'qemu-system-i386' in emulators
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
index 3a6339c2a12..52d073a0bf6 100644
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
@@ -211,7 +210,7 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'cc_dockerfile', 'cc_docker_host_arch', 'cc_feat_cflags',
+    allowed = ['cc', 'cc_dockerfile', 'cc_feat_cflags',
                'folder', 'gdb_arch', 'gdb_feat_version', 'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
@@ -258,14 +257,6 @@ foreach target, plan: tcg_tests
 
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
index 39a480033de..1f9aa57fc73 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -1,6 +1,5 @@
 cc = 's390x-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
-cc_docker_host_arch = ['aarch64', 'x86_64']
 
 cc_feat_cflags = {
   'z14': '-march=z14',
@@ -142,7 +141,6 @@ if 'qemu-s390x' in emulators
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
2.47.3


