Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A62BC9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAA7t-00089o-GZ; Fri, 25 Sep 2026 13:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7p-00086g-Po
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xAA7m-0000dk-Cd
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:54:21 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PGsYLv2083029
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zk97HMpgj9MMpeEenN2BfcF0iEUCL+Q5O7cmo4UdlJg=; b=SUXo0Ogp2yF6Ytt3
 BuxJfCzvqVY1i0rBJpjtEQOyZPOOhzCJksY2LT0aUEkMCSy74qDw5Ahfya12AlPp
 188Ril/Wy8Pln/bPDfC91F1zkP2z47H7dL3AmJiMj+LO2VEal5IhLuYhW8lUVdoy
 9w4Zo24GLAAYTFaAcTr3vvaO82imCjNDeFtVuD64Us6FTvm38yVPrwXhZaUHQ6pg
 T5BowcHiMvOLv2JKwP1o+yTkt1fFf6+BahehuFCRLHX2pLtwZR2YZ2mcRW2Xf++l
 P/H/52+ckxd7cNyJzdJ3THDDE+eW5ACpqHejGvvdgqtSOlYzjDMAp1x+ZIjdL9WJ
 lzu0Zg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwvw1g77r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 17:54:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-32b8c2b30c4so2050791eec.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 10:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790358855; x=1790963655; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zk97HMpgj9MMpeEenN2BfcF0iEUCL+Q5O7cmo4UdlJg=;
 b=hqYTLeFA3x/v1j55BSlWiwJgayY0W1JQZDmX7ay/jgfpvOm8iBKWvAMIttfPM7ZjD6
 976LtTRPRJT4LIbnXY+gOUKy+0Z7e+9ydusJN12wIWplsDpUugWB0BqvK8M2RlYtOYHT
 OR9S1Kyjr9sWVW2fOr2VpgxOnV78WhuF7S7H56MTOqXa4QejTN4UyybMM0eOpVa4SIUa
 a7rM5q+w4upCKbm7CD/PB80gV7fDe4ZNrrhuORxUvjLpRRpnOONs+WN7Q3cHwGLgqUlH
 hhhDzV01z1ffqTV61oXSpQshSeu/9h/F1zXZmaOzsvOxSIthFyGTx35XFjxGk6w8JfTd
 /d1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790358855; x=1790963655;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zk97HMpgj9MMpeEenN2BfcF0iEUCL+Q5O7cmo4UdlJg=;
 b=WGLg05DEWqBPn4Pt4qifFCq6oog17GgEM0peOtag6tthcmtlIRPjmPAtoKDBBfK1bO
 YBYQUf1R20vPxQb1EiKHScS78ur511+dTqjDcRHoMi1Avteugad6N1q7wMUmyOIRdUs6
 g5LhjcoP8q8wGLp5+pg0I/Da1uC1bbb7KNki0WNaSQE3zSbeC2lIZWrPPnDbM6HMTdSr
 9vM2VGXHkCy2tS9ShXe5BfIHtMITdTnCQM6TkQsoRYKfHIdNEG0kCRZfUIJIh/yzjc/R
 mBDKbxPkmHLFf0DHt/4Ym2/2Q0qukJdSqx6T+Ic/E4CViFCaCt75fibd2VBwUu4VOvrl
 glmQ==
X-Gm-Message-State: AFuF++nvDT9y1r8MrkiObn+9F7wN1xhdCaACJgTS3BWDlWOUkL2Z+Isp
 7m2y0G8hYrjHgusEDBnUYezECd8fT5MiIKjvXHIBkfGfytTRf9GMjhbd2JwH1sz/IjyXRFhsxAf
 T/uPs4+gFJqBeOYNe3btPf4XceT+jimqmdKnGNCfrU1uWWVrqneqZ6UvUt4Sanj5qfA==
X-Gm-Gg: AYBFou3hfcqDocW47g2EytY9eJjYoh+p5S2AO5nJ4nnbV2vBOKfANy5pUKeurZcUETm
 ESIKmoguSJyFdkEMhrYSa33KCe8+AwaVYBwbXpJ6uS1KkFfFmSGicKGtvlKgmMZ72DKQFS7qiDs
 rzIUD8u6lm+aGycn7Tvqz2wnFuMj/niGXPGjpqTbmuVuKxRTKMaqsmL3o8KXoa8RjegMBse8rk9
 WqtX9DXPBaafruLqLrBUT1bxaphKXBFs3LEIl8muyGKbrV82pnbFYoh3BRv9ulD/s0UO4dkISxI
 URd/fvFrPIYHM4+by8TrkbXvymo26122UfZZquHXoYYhUhPmXj/wmDG1hHpavqPa9O+0YnA5FKW
 KoAjqytA/VkjD7GfgO1jm9xlz01Jn60soMdt+E0mcFpZggSGWPj4Tcc2yTw==
X-Received: by 2002:a05:7300:3b28:b0:33e:6b65:5eb6 with SMTP id
 5a478bee46e88-34273c40a64mr1123207eec.30.1790358854660; 
 Fri, 25 Sep 2026 10:54:14 -0700 (PDT)
X-Received: by 2002:a05:7300:3b28:b0:33e:6b65:5eb6 with SMTP id
 5a478bee46e88-34273c40a64mr1123172eec.30.1790358853950; 
 Fri, 25 Sep 2026 10:54:13 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144172de6sm11055128eec.9.2026.09.25.10.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 10:54:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 06/13] tests/docker/dockerfiles/debian-all-test: remove arch
 specific bits
Date: Fri, 25 Sep 2026 10:53:53 -0700
Message-ID: <20260925175400.1897574-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260925175400.1897574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ccXry-zrgWVBpKVbW8m711UEJ_yMbzmz
X-Authority-Analysis: v=2.4 cv=YqCa1IYX c=1 sm=1 tr=0 ts=6ab6b547 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TNSyY6zQAAAA:8 a=3B-k7g5EAAAA:20
 a=et0sjsPFApox7PfucLgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=01gnQneks5i7xkQX6LlV:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: ccXry-zrgWVBpKVbW8m711UEJ_yMbzmz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfXwlIufWoFgIZq
 Fn2qDwtdZ6ti0A832xF6H72G1MDs6TK7SlLAjdsjhvBwm8fxxDiayU+YcEuNEC7Aq/PKE1u7bEM
 8SmxidCYJYgSLRbgq3R3CvsDw2OwfjWtnbCk4etjRCy7IJaFN4Namtr6WsXQ3XCB1iFWkzWJ25w
 JbCBhr9xE2qlYYvmh+R37RCQ/FwaoVbjsUWj8/yqRmEyV9V9UlQD0YNilyQDpeUH2R0CSwQZGqj
 X4ymCQyvn3wf84DFv3n3yDnTIlnTVYfd8DzT8LsLYicy40oHfF850cjFDtn/+bhv8J/fIOVzOJ7
 BhTAfD8/HjkfYcfF+sE+jqRnDD6+dRUpG3IT2nDWDXSuEIMaZa+AXEjA3drdfHKfmdd53K949sz
 pa9Pq2f4qmwFiAwuBgPkvxecy0Muv7I0tZOhAMjWaB5t9rKvTLCcsw92jgoxrSH/yXsODMMbOSZ
 8/RYmMcCc/EoYj7ZZTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfXxHh2Ka9Mljxj
 fScpDGu4Nx1aIRqNSeXGZsK4kZyC0oGPVPqPXZnk8Zt0LgUKG4psRLAPBYA8S8i4rWulVN7iHjC
 3cas3DgEJVorDSKVXqES1veIDfXZ6Bw=
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

Now that this image is amd64 only, we don't need those ifs anymore.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260923185725.863311-4-pierrick.bouvier@oss.qualcomm.com
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


