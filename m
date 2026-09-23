Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB6FC9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 18:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9SA0-000154-P2; Wed, 23 Sep 2026 14:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9S9z-00014b-Sf
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 14:57:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9S9x-0003Xd-C6
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 14:57:39 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NGTqDS3082027
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 18:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FmJAhf+mYrfd8vHVOlHWMxKPDDBFKpRbCQu4Tnfom1s=; b=CTwO3L/gf/d/riz6
 vrV160PcJ9cbi0FKq/vAT7ARBKCAcsfSWTPhlohp4lDbDYEKtu9NFCrBmDseQhan
 R8rhtYoAlInOqmlnViBX746Rf1FQze5IUOp2mtIS0LbyzmI9bA2oQDfYnJEuhLoh
 A3CeGhs6AanXJhvzReR1WYnKgpG8oKUvVpqCu3KrYvHJ942db55f90bpMz7AYOn5
 3g44wQrszN9F8HqnQoEY/Smxo7KKFISFhRa2g+ZE5fV1/+i7J+V8vy845psIiuUy
 mN0zsMFBlXgSS+mVnnwmVSD6v7OMNrY037Hz20n4JWEgKjXPY8w38LsaipYTuHIo
 eTgVTg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbx7jgfq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 18:57:35 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1416f32fe11so966735c88.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 11:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790189855; x=1790794655; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FmJAhf+mYrfd8vHVOlHWMxKPDDBFKpRbCQu4Tnfom1s=;
 b=AK4mSpTWDFemB3tRFa8IZ1eihmHvQuaSnHhw3BrcNqvx7XW8XvI29xt6krvDM8ZBdL
 18D1SX0xXnF7aycQfD0ypqpAMIncd7NiCzJaFzfodiD/LJxfsikSy3BYobUegiaTM3gR
 VAEGftr6RvXOtoj4BV1cP9rSEkQNYYG+8IOg0eAVuJLUdUV3FFJGJbB9JZcgiUBqYPGr
 ifHb7oiNLjAZoo8FoeQ91clgzWgIw/oKfocQKJ/r40CohuoY7fo2Y/RMtONm5otY1o69
 3oswrwelb/qSDAqQgXrEhANRGGVOSJ8/n49CD55MnQxwidUCh08DoYgc1bM48CGRORtq
 10iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790189855; x=1790794655;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FmJAhf+mYrfd8vHVOlHWMxKPDDBFKpRbCQu4Tnfom1s=;
 b=Eeu5j14qFP+rJng/UwIbV5ntfyllS+znmTqZzR4gY5j5zQEMar6U9qL8EsdgXsLVYO
 9CBoyTuK7vpdwvIgWDSqELcQ/19mQr+M3gafKEC8o2xF+Ec0tXNdRLOGBiRsOmGXCzX0
 jG0cc2w2IiZeK+FSayBsUdEpKKFX08/WP2EvmVdFDzcvZZgz9QMH50n9fk2FtpLS5Y/O
 B3tgQxpOfHQ+47+3GHx3fEJwQpqjNDMev71YWrbNrG8MzGWRXcUB0y5udz8StcBugtsW
 p5aMxJUKUVysArNkdE2shAaV8xsnpLOW+qZGB9y5jK6pMD3uToCzZFq0wq59DFbXEQU2
 2qoA==
X-Gm-Message-State: AFuF++mPDMF+qVVrgxvCXnRUzUIaZgpFe1jOgzkOvvDQQJX4PtgTTSPk
 K6MlsDc3NfDCNcHo+gdaiKcaaV2viKKzcgbuqH8pfQ698yvS9gT2cH44FYlg6q/hV9synXNwtU8
 IgmJLS7nradaS3VzqN4vxFrFCRqkyT4+oyEwdyXfCt97PLOCwh4tk04U0YgnA2uvPcg==
X-Gm-Gg: AYBFou3khPJl9yFCfl+GDYK35R+MJH/9hseAQ49ERgRAaJva5zzSPCkn0GRG0FQL8aw
 avCSefO33DgGqBdNbnBYspayHVgXj0MEsXGhzo88F5roZENHBpz6ZxdWK9zyiKY2/Sgj7tzHiYn
 AC7oL8lh5MvdVFXxwTuvR+1HsQjK6/YPgrU1b/U9vFUVDeaipyAL2kD2WADa99YVYjnN+KEWnFP
 gP8NkS14iqg3ohJ/++uYhEcyja79JWhoUF6N9fQM7awkrVAua1mHciYOeC4r1VbkqXqEBVq04EQ
 Y8j9wUoKH25u1TR5UoZbFLmIv+bp0uWPY6a/8oo9v/tN6NrDSaLF66QdUBn2morxM5IdGmeqtG1
 RwSpi0YvzKw6r9t9+EPzFD/gO0mgSsscyQ4FqgsGS+flH9xeCi2X2kcozeA==
X-Received: by 2002:a05:701b:4184:20b0:138:3613:dbb with SMTP id
 a92af1059eb24-14503fc11ebmr68856c88.5.1790189855166; 
 Wed, 23 Sep 2026 11:57:35 -0700 (PDT)
X-Received: by 2002:a05:701b:4184:20b0:138:3613:dbb with SMTP id
 a92af1059eb24-14503fc11ebmr68830c88.5.1790189854444; 
 Wed, 23 Sep 2026 11:57:34 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f9820ca5sm8154931c88.3.2026.09.23.11.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 11:57:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, philmd@oss.qualcomm.com, 
 berrange@redhat.com, alex.bennee@linaro.org,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v2 3/6] tests/docker/dockerfiles/debian-all-test: remove arch
 specific bits
Date: Wed, 23 Sep 2026 11:57:22 -0700
Message-ID: <20260923185725.863311-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260923185725.863311-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fO1I0pxdQvgQHV6ts_KjHKV8SAlyC3SW
X-Authority-Analysis: v=2.4 cv=J4s/fwnS c=1 sm=1 tr=0 ts=6ab42120 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=TNSyY6zQAAAA:8 a=3B-k7g5EAAAA:20 a=EUspDBNiAAAA:8 a=-iYKgs8SGnXLXrbbk7oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
 a=01gnQneks5i7xkQX6LlV:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3NSBTYWx0ZWRfX94L5CaorrPQF
 Fh05EGBXxdKmpCGZGVpG02xJ3wM9ns788ijM/XXfN6vUywqt1t89mZ4Tbm8w9JO3Ynp3ZX71YiH
 V1q7iqrHz8bNpdrRc0NUXjxAG/jGTzMuoXG/f29F2OPlgPNSeW0HipfRUL8g5s+PwnrvB0e3onG
 k3VwoQW6Zmu0WUS6yvDVsymF6oZh9DsSHLfTYbUG5eAQI2ZXRvtUVyQ3ZWM1Ls4gxXmC3cRpG08
 0oNV89Mph0FkkH06EucLru/938y1iGXHwpWw4gXnMGhyxZ5cz99PDseUMAfrhBDnQTuKbHJjjr5
 KFmRhZT/JSUDYB2W5gGXQyIPdChAuagHRmGgCqzblbuFmVgwISDxcFLmtyPE2Tq7Ft23tmfXMwj
 Xk8ba8exQPKlOevARqON2iaxFDa0FR+K6Iu5wZwjY3NBOxLyndc93qevFHoJeCykvMAfMDEUhyX
 iCsuq9LLL2kcZPY1K9Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3NSBTYWx0ZWRfX8KNq/3PZ9QQg
 EcyrF3l5NukhDKFY/jOvxMlN3d4MId+RvOke9G3b5/FgmezDkvAEOIG1aCAz/RkXHHzdjAgycSs
 0egoGidhhSO6KQsDra/quZ06I6oij+k=
X-Proofpoint-GUID: fO1I0pxdQvgQHV6ts_KjHKV8SAlyC3SW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230075
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

Now that this image is amd64 only, we don't need those ifs anymore.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .../dockerfiles/debian-all-test-cross.docker  | 35 +++++++++----------
 tests/lcitool/refresh                         | 35 +++++++++----------
 2 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 45edba38e92..97d3dae6d7f 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -66,15 +66,15 @@ RUN apt update && \
   rsync
 
 # https://openrisc.io/2025/04/20/toolchainrootfsbins
-RUN if dpkg-architecture -e amd64; then \
-cd /tmp && \
+RUN cd /tmp && \
   wget -q https://github.com/stffrdhrn/or1k-toolchain-build/releases/download/or1k-16.1.0-20260614/or1k-none-linux-musl-16.1.0-20260614.tar.xz && \
   tar --no-same-owner -xf *.tar.xz && \
   rsync -a or1k-none-linux-musl/ /usr/ && \
-  rm -rf /tmp/*; \
-fi
+  rm -rf /tmp/*
 
-ENV AVAILABLE_COMPILERS="\
+RUN apt update && \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
+  apt install -y --no-install-recommends \
   gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
   gcc-arm-linux-gnueabihf \
@@ -97,19 +97,18 @@ ENV AVAILABLE_COMPILERS="\
   libc6-dev-s390x-cross\
   gcc-sh4-linux-gnu \
   libc6-dev-sh4-cross \
-  "
-RUN if dpkg-architecture -e amd64; then \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
-fi && \
-apt update && \
-DEBIAN_FRONTEND=noninteractive eatmydata \
-apt install -y --no-install-recommends \
-${AVAILABLE_COMPILERS} && \
-dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
+  gcc-hppa-linux-gnu \
+  libc6-dev-hppa-cross \
+  gcc-m68k-linux-gnu \
+  libc6-dev-m68k-cross \
+  gcc-powerpc-linux-gnu \
+  libc6-dev-powerpc-cross \
+  gcc-powerpc64-linux-gnu \
+  libc6-dev-ppc64-cross \
+  gcc-sparc64-linux-gnu \
+  libc6-dev-sparc64-cross \
+  && \
+  dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
 ENV QEMU_CONFIGURE_OPTS=--disable-docs
 ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 002ab11270f..31c06734879 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -177,15 +177,15 @@ RUN apt update && \
   rsync
 
 # https://openrisc.io/2025/04/20/toolchainrootfsbins
-RUN if dpkg-architecture -e amd64; then \
-cd /tmp && \
+RUN cd /tmp && \
   wget -q https://github.com/stffrdhrn/or1k-toolchain-build/releases/download/or1k-16.1.0-20260614/or1k-none-linux-musl-16.1.0-20260614.tar.xz && \
   tar --no-same-owner -xf *.tar.xz && \
   rsync -a or1k-none-linux-musl/ /usr/ && \
-  rm -rf /tmp/*; \
-fi
+  rm -rf /tmp/*
 
-ENV AVAILABLE_COMPILERS="\
+RUN apt update && \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
+  apt install -y --no-install-recommends \
   gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
   gcc-arm-linux-gnueabihf \
@@ -208,19 +208,18 @@ ENV AVAILABLE_COMPILERS="\
   libc6-dev-s390x-cross\
   gcc-sh4-linux-gnu \
   libc6-dev-sh4-cross \
-  "
-RUN if dpkg-architecture -e amd64; then \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
-fi && \
-apt update && \
-DEBIAN_FRONTEND=noninteractive eatmydata \
-apt install -y --no-install-recommends \
-${AVAILABLE_COMPILERS} && \
-dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
+  gcc-hppa-linux-gnu \
+  libc6-dev-hppa-cross \
+  gcc-m68k-linux-gnu \
+  libc6-dev-m68k-cross \
+  gcc-powerpc-linux-gnu \
+  libc6-dev-powerpc-cross \
+  gcc-powerpc64-linux-gnu \
+  libc6-dev-ppc64-cross \
+  gcc-sparc64-linux-gnu \
+  libc6-dev-sparc64-cross \
+  && \
+  dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
 ENV QEMU_CONFIGURE_OPTS=--disable-docs
 ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
 """
-- 
2.47.3


