Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2A7C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4ge-0001GC-7D; Fri, 10 Jul 2026 02:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gd-0001FW-E3
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gb-00060y-IH
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:11 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3pEgA3856035
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=I72i8fmmW5R
 rqAPZKyyIEUFoZ/nEA3u1hbKO/gLuVeY=; b=NHvw9I2zHHCMRRjYsnqa/gSbCrE
 FM1LTcA2cQXC6FPt95x41IWfE1XIvm5xaeMNhNEgjs1Mwb3zlMYRagKs1uIqnmqF
 Xg7T91PBeB7db5Ny+S2+G2qq8gvnNvAVZRrHDCmSUu0Cpd5E7KPWNUV1qHpa3j2u
 hztEZgr6jzsavSkzso4xUaSI6v0jrq3D66ynhe9Occ65dY7xxJsnMa9tmTGDDZHU
 3yXbM+6KxCW6GJrt4XG0TXq6Zkrvtj2aZT4PCWkeO2zTfWAprIyLUpPZmB0aAV8W
 FE2mv+tv+/tpiyXd2u8VrmM68GSu3gVDJ/XxH45QIs1lCHqfB5WQOuC/r+A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n0hwk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:58 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so746569a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664758; x=1784269558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I72i8fmmW5RrqAPZKyyIEUFoZ/nEA3u1hbKO/gLuVeY=;
 b=O3/DnCPj54rHi4vTsnhWoBh+/ALFFI/N3eWkaqdT4gSRTGcxUWjot8Fx+yV4uVqGs6
 9MJApfalzeQtYq2WlSnjUOK18qTiJHIuxzwSHJjoGaooMLmhR0ddIjZUsY3OZQN6msTL
 jdSL4MN/X1Fz6SwCxA3MrhAa1S0cbh2sb7zkHDbgPM5WuXejtjHGkzYP7UAJbEXUG8NR
 Xkc2jRJtES2dkpLGnL8XxkrXP+pMIUwizBDtJYKhroCk3E/0t1wfrI9to2LxVgTyYbFC
 NCYuq+95rDiylciJTPD1B+7bf4HWzzCvb27lk3Bb3J9loS8wOYcN89YZnWnLejN3DBhz
 g2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664758; x=1784269558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I72i8fmmW5RrqAPZKyyIEUFoZ/nEA3u1hbKO/gLuVeY=;
 b=O31571Zdscs0UFzr5BzKPGYMvatsqQ0YeGz/Wicvla955HEgaaDZDaJgoMBE41XEOl
 8vnPUF801Bi1x3O+67ugi59OCziosmlCCOgUvAjnG8QTjt2zJ2UqMvRNWxdW1pN/5RSo
 4MHd91I99/GMcX44TSotqiILt3RSmVgdXTwonC1K+RQZs7wXgiIlpfjX752GQRszwAgL
 ULqFN3FbGwBLH5XaiQWcjT+3FxZ+D5AwGlHQb05/1x2bNBGMsdwwPs8dkfLo3Sruro98
 VEa8i55UQ/loGQYQe52F21CiAKw7amsmUdfaZujOpNyxW5xRGEXvreKx4GF75Mb5nmum
 SrDQ==
X-Gm-Message-State: AOJu0YxLJrnda56dLo6oy2FXMSGfxYCPvy0YXWRlfTySs7efEGHQcIy2
 HJyRH8CfI23Z0RVeJErbUfDxpS6fMTRpxcaPLak9cwFq42M+DrOeryax4BPfJr4qeuQ9kQMDnop
 KTb7T3vI7Tf+GGj4jel9vjlgg1jTppFZbjq83jwOdpCcqyS300SDdc4hV7KYlxGAHtg==
X-Gm-Gg: AfdE7ck57lhJsztcpgtv7yfqRFBxG8NvxX08T+cvLaU+SPlwOBHUbHolvNwbOU6bafq
 UcKMxsHYVkG/yw6KcUCHN2TMDc4T58s2Xf5P0JFa/CmatA0szsdvR+fEZqcNpalSsRqvYJt1SL8
 H9tmRk2U7RHxs5dnqNBV/E5nEdEXkH/1W04wvilpdJ0QwWyzR35K68TSqzeNjzG1ISLV/N5oBKr
 3EeM51Ot4Fq0bQJ9msw6g/uVeO8AhZ8MKAn/cO0gxeolZ0DAMqXwl2jdJzc6XQE9aXgVkDVRB99
 /fWR7c6gx7AmyS63vyO8u1bVmHRPiqhpoBqlDXF1EjjX/OljgRu/U2LXT0/xxlFJSLRcugtOpHP
 BcKqtFszC3d02Q7xneIpetrhLNt34i18tYLj0JMjKkWUwDrHvGrrzh/OUGSW0J9lY81bkbZPyBe
 8S/zbrXw==
X-Received: by 2002:a05:6a21:670b:b0:3b2:b1f8:c745 with SMTP id
 adf61e73a8af0-3c0bc93823bmr12531790637.20.1783664757577; 
 Thu, 09 Jul 2026 23:25:57 -0700 (PDT)
X-Received: by 2002:a05:6a21:670b:b0:3b2:b1f8:c745 with SMTP id
 adf61e73a8af0-3c0bc93823bmr12531760637.20.1783664757098; 
 Thu, 09 Jul 2026 23:25:57 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:56 -0700 (PDT)
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
Subject: [PATCH v4 65/97]
 tests/docker/dockerfiles/debian-all-test-cross.docker: add or1k toolchain
Date: Thu,  9 Jul 2026 23:19:43 -0700
Message-ID: <20260710062016.1818125-66-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX6Bl+KFP/Pu3Y
 DgaAMErqQQOBJwjndcebmrMiM1j/lPUXxWb4tGc2rYndpBsg7P69/3nfjwGScAMmjbi0Ud5CR1+
 hOqqsdHIW7wn3eWEJeHnzPPQw1ldbDI=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a509076 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=TNSyY6zQAAAA:8
 a=3B-k7g5EAAAA:20 a=EUspDBNiAAAA:8 a=ucEKaO2-bgP9YeC-RA4A:9
 a=3WC7DwWrALyhR5TkjVHa:22 a=01gnQneks5i7xkQX6LlV:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: nj6y_r4aeuyZEaUjxQ_5slXkQ3jn_Ly0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX6wMVlm7P/BAH
 u13gL6WygoE29BTpWluZ8J2VlviWqhe50E6/LjiPxz1sg5VY/z8Gjmnxg/41WMPWcJpSRS9uHuv
 dVoj6+U9ALusU6nQVh9m3E4brc+KWWvdNVne0T9fyfpIp7sdwAzxrKQdql7lKkAmIfJHb66pMyT
 chq8xi5C9mRj6ZUqg7ssFslIeBkH+oreGSxqfXZwWaI9aC2d8DwU6ywbnY730sIQACjHlpzLzBD
 l8IpKeksM549yMVai9Wls+VgF4PZTyfVI8ShS4hOizk7RrtE3XuRszNY7YZmzwgK43U9goAFJ3F
 CVE1Ilgp1IqO23dVAE85J53Pf6rFXDa8yqVY0a4p0bQJlTWsivtvdf2aae8VNboXgR6jMCjvO8V
 HbfDHurRzy05xdj1avHBvz3bbnyTFhWG8zrBYF8EGoFMV2Wcqhc5cN8fdJUBzC8yF36FkchYilP
 1A3MfvKLgerL/+o3+hg==
X-Proofpoint-GUID: nj6y_r4aeuyZEaUjxQ_5slXkQ3jn_Ly0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100059
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
 .../dockerfiles/debian-all-test-cross.docker       | 14 +++++++++++++-
 tests/lcitool/refresh                              | 14 +++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 2dc580552e3..449ea0301a0 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -61,7 +61,19 @@ RUN apt update && \
   clang\
   dpkg-dev\
   gdb-multiarch\
-  libclang-rt-dev
+  libclang-rt-dev\
+  wget\
+  rsync
+
+# https://openrisc.io/2025/04/20/toolchainrootfsbins
+RUN if dpkg-architecture -e amd64; then \
+cd /tmp && \
+  wget -q https://github.com/stffrdhrn/or1k-toolchain-build/releases/download/or1k-16.1.0-20260614/or1k-none-linux-musl-16.1.0-20260614.tar.xz && \
+  tar --no-same-owner -xf *.tar.xz && \
+  rsync -a or1k-none-linux-musl/ /usr/ && \
+  rm -rf /tmp/*; \
+fi
+
 ENV AVAILABLE_COMPILERS="\
   gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 6bc611b0e6c..9a71af0e41d 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -172,7 +172,19 @@ RUN apt update && \
   clang\
   dpkg-dev\
   gdb-multiarch\
-  libclang-rt-dev
+  libclang-rt-dev\
+  wget\
+  rsync
+
+# https://openrisc.io/2025/04/20/toolchainrootfsbins
+RUN if dpkg-architecture -e amd64; then \
+cd /tmp && \
+  wget -q https://github.com/stffrdhrn/or1k-toolchain-build/releases/download/or1k-16.1.0-20260614/or1k-none-linux-musl-16.1.0-20260614.tar.xz && \
+  tar --no-same-owner -xf *.tar.xz && \
+  rsync -a or1k-none-linux-musl/ /usr/ && \
+  rm -rf /tmp/*; \
+fi
+
 ENV AVAILABLE_COMPILERS="\
   gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
-- 
2.47.3


