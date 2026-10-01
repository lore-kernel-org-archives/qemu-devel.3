Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACAECA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKy3-00088H-Jd; Thu, 01 Oct 2026 13:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxo-00085B-Ta
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:53:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxm-0001qm-T9
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:53:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsoS03512604
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cYkuVEtuWrCF8pAS9/3X1k/uyEwk40SoexmcXPuMtsU=; b=aBd6fO+v8y5h2Dzz
 CpCUnuhNCOppkl5C71vmybROCSm7HDcGCxLdWpM81aPNwNqtZutGHUFDTxVmEga6
 lrtRLMs8Pl22GLKRLtkhbYgTGPuQ8yrp2kIbOrm+CmT62Z03UbCJSGLjcEOYb3BN
 boaeOJGbfrLaNcOiiaDRxPjRbGs66lu1CyhUcaPLqFKdmic9s1ZLWeGcAKmoy3pL
 exSQZl9iIPphEtwLCvjJ7wuF8+tf+Kzucma6fsAg0p06fRqwpRYkRm62DXklVBzn
 k0JPmevcF0w899A2BxA1gq7MXdsuR2B0QgXgJ7NmF/cLH5h7dt61igEKeYqasylE
 Zcnktg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1quk9e25-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:47 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-149e8e8ad71so1278334c88.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877167; x=1791481967; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cYkuVEtuWrCF8pAS9/3X1k/uyEwk40SoexmcXPuMtsU=;
 b=J7zjMoUBVOeTVM9HPl0iFefm4xr0rU1uJKpdSyvoAPGRYLg8NUIsBqIVu7Cs8SHtEI
 /5zhd7Wti3J8wEjEXSYwU+drH3la/6mnz+U1UqsdXW8jZCgxPO2wEkK8vO+jYncttBDC
 qROC+lEabBcjVGNM1tmU6v5TVMp+5PPCxjbiLDnE5C3zd5x31NOzYUL1wvpXL1RyR5yI
 Mn5Gf6W8tGm2ND/temasUiqTpb0DdBojygq6PIrFl0tsU4OAcQargGNPzz/61VYQtfWJ
 YqPRzHk8rjBYaVZhmLHrMa3j+xXBz06hoBPtZlJdruIwcnEMnRcZys3ZCcyjv+HqcXs2
 lMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877167; x=1791481967;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cYkuVEtuWrCF8pAS9/3X1k/uyEwk40SoexmcXPuMtsU=;
 b=WSOLdHuqpJnuTLLf4N7hQjzGPFTTBg6ixXT3yYwWTwSOzeyPGyH32iFXOQy17lct89
 1DoDFRXWD7fFMfYEq7a7Ci08TukFMpZdAa7+a4s0o1LJBX+9tEDJVfVZdTqjDP/Dr73i
 OaNqF7BXJl+PuU2+Y+xOgShhXfNT+xeaCif7H6a4KpA2hYRf/WJLnMksBPIiJVCkkgHt
 9G91v94Tv1qZ2L/ZKNW1YFmXc+Gzam1yo+OU7Bd/ibnqO3DVMrE3ARSVsjBWQj8ydJaq
 ijrp3BDBpbUz1dbY1QxzcN6j+D+wKKFaYeVyoglKIDI8/NbpZ7AIIHZqmFZViHoQBkhL
 OoKA==
X-Gm-Message-State: AFuF++kJ41doquojJ3Izfasnmrb6ThzyELbm4e8GNOrdUhj81psH9/rg
 LpaT1xgYiU3UoIgH7wjfKa4BAXBT8/R1vwKTGrygFr/q8u/d0V34YL+N3Q+/fm60bKP/a0BW+li
 SWd+/49vZFk7HjG83cZZH2QieJXehDUN7mf4K8LgTUR6svSi7vYkg6oYY8X/aHHdx7A==
X-Gm-Gg: AYBFou1qIVtwi7DVx/F44uYN7F7P5Chxh7XOpvYFHhIfR70FvstQjUZ4l6P79lC3dw2
 FowGWD7u4LeZGXuyPJUvcnP8wgmFTh6k2S8g49Co8NOdHIaWvBQsSYhveSTt0oQcbiJvz7LAU49
 NP4Iy+sIgW3cerb0EzJ6wyZNBWPPvuYz69HjgZ/7hLno1eC/4tVWVRWnXaxYC98qwmcxLSvQv1v
 enAuIQsuLz9RFg1pE76qHpxLfMM4Z+PnmjCPIEaKtYZGpGmxl4nEVeRQWaIK+d/12AX0s4FobH7
 KLZ+JE4KOk/PSQYIX6yWGz6aaI9bfyEWkdtrPSiEoyGboCW0F7rOXia800uvJ77OxaWTkQOPDNj
 mA7W4uA2h3jWREm/Uu92UGV8YOnGHz8NaFYJbghkoXbL0UbLPEyW0i+oFtgWr
X-Received: by 2002:a05:701b:2611:b0:139:90ab:36c8 with SMTP id
 a92af1059eb24-14d2fbc61fbmr4610685c88.1.1790877166569; 
 Thu, 01 Oct 2026 10:52:46 -0700 (PDT)
X-Received: by 2002:a05:701b:2611:b0:139:90ab:36c8 with SMTP id
 a92af1059eb24-14d2fbc61fbmr4610643c88.1.1790877165813; 
 Thu, 01 Oct 2026 10:52:45 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 22/27] tests/docker/debian-all-test: add mips32r5 toolchain
Date: Thu,  1 Oct 2026 17:51:58 +0000
Message-ID: <20261001175203.8673-23-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX81jalv0jZs+U
 PsUflNeFtJDybIr+rAC4EtIEIfGmC/Q6Frr3xCK7m63WXSgDhsK0nnL8qxKCVyoHkA38l8QpwwS
 oHC7jmk+AiSJBuNg8ZWhh6+3jerXl4o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX8fs57kaZgykf
 eEdD13bMechUdnqzWAZv2tQV6QttSA4IQwNYMIi5YKH9t7/vcSYgDSnRioJ7Zm8GnyQlc3P6iEU
 0dJRc5QbqJzc6fKyrAnzjxkbc5on8r8PlZPY9rAvSDK+0lqrmzoJR8eMNJEN+/lWCxJjlt29zRx
 WSimeAl430HcEI0TOYqfQsFxqex0ITSRMpgt1PxvgaLUobrk0NIEWf0eATGu6kNnowore13fTS+
 pRYX6xvKbbtvWZnSQV23xKGjnXSXxajPURpyjmyEy2qBpSWoUyjFIlFtgruyZr6NbrHRpJEvZyZ
 UpgP7VtCxFwUH/9X6+Qw2Ovy7dMe604CHAgugFhVaalSOSplqa6OVYQefnRxbJjbE/73XS03n5o
 Q07O9FhINHShnRv42jVWFL95G83XZ6XYBQOqaA/bfRs2LmswrcX3KhFu9QoU7nOWIciOET9WJjW
 KILcw4auB+w3+qmnQpg==
X-Proofpoint-GUID: id-UyndoQZChkM2NvnuE76hgiwS2stIF
X-Authority-Analysis: v=2.4 cv=TdADJhQh c=1 sm=1 tr=0 ts=6abe9def cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=gPJu0pBYAAAA:8 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=LKAvCFhEUFdIRXT5rOkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=AlIIF0cMT2hfDT4axODj:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: id-UyndoQZChkM2NvnuE76hgiwS2stIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010071
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

For our test, we need a compiler and libc that supports -mnan=2008.
Debian compilers support this option, but no libc is available for it.

One possibility is to use previous version (2019 or 2020) of official
MIPS toolchain from https://codescape.mips.com/. However, it's a huge
download (2G), and even bigger on disk (8GB).

Bootlin provides toolchains
(https://toolchains.bootlin.com/toolchains.html) for mips64r5el only,
which is small (80MB dl, and 500MB on disk). Since all mipsel* variant
binaries have the same name, we explicitly rename them to
mips64r5el-linux-gnu-*. Also, this toolchain is maintained, used, and
updated frequently, so it's an excellent choice for us.

mips32r5el is more widely used compared to mips32r5, so we can ignore
the latter.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260929212439.110454-23-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .../dockerfiles/debian-all-test-cross.docker     | 16 ++++++++++++++++
 tests/lcitool/refresh                            | 16 ++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 94524480880..eefc03c49a4 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -113,6 +113,22 @@ RUN apt update && \
   libc6-dev-sparc64-cross \
   && \
   dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
+
+RUN apt update && DEBIAN_FRONTEND=noninteractive eatmydata apt install -y rename
+
+# download mips32r5el toolchain from bootlin, and rename binaries who are simply
+# named mipsel-linux-gnu-*
+RUN apt update && \
+  mkdir -p /opt/mips32r5el/ && \
+  cd /opt/mips32r5el/ && \
+  wget -q https://toolchains.bootlin.com/downloads/releases/toolchains/mips32r5el/tarballs/mips32r5el--glibc--stable-2026.08-1.tar.xz && \
+  tar xvf *.tar.xz && \
+  rm *.tar.xz && \
+  mv mips32r5el--glibc--stable-2026.08-1/* . && \
+  cd bin && \
+  rename 's/mipsel/mips32r5el/' mipsel*
+ENV PATH="$PATH:/opt/mips32r5el/bin"
+
 ENV QEMU_CONFIGURE_OPTS=--disable-docs
 ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 662d8a79f3a..94cab24bbdb 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -224,6 +224,22 @@ RUN apt update && \
   libc6-dev-sparc64-cross \
   && \
   dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
+
+RUN apt update && DEBIAN_FRONTEND=noninteractive eatmydata apt install -y rename
+
+# download mips32r5el toolchain from bootlin, and rename binaries who are simply
+# named mipsel-linux-gnu-*
+RUN apt update && \
+  mkdir -p /opt/mips32r5el/ && \
+  cd /opt/mips32r5el/ && \
+  wget -q https://toolchains.bootlin.com/downloads/releases/toolchains/mips32r5el/tarballs/mips32r5el--glibc--stable-2026.08-1.tar.xz && \
+  tar xvf *.tar.xz && \
+  rm *.tar.xz && \
+  mv mips32r5el--glibc--stable-2026.08-1/* . && \
+  cd bin && \
+  rename 's/mipsel/mips32r5el/' mipsel*
+ENV PATH="$PATH:/opt/mips32r5el/bin"
+
 ENV QEMU_CONFIGURE_OPTS=--disable-docs
 ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
 """
-- 
2.43.0


