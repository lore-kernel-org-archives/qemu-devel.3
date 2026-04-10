Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A954DF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBG5Z-0006nH-PC; Fri, 10 Apr 2026 13:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5X-0006mN-Dy
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wBG5V-0001XT-A8
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 13:56:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AH2Wjj017381
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UQmlyxpZaVV
 P/6TW6V7qRLUtxbYcGCiDyOnIxm58+4w=; b=jOwNQHGMcxjYBEkLu4vH/9A8QnZ
 Q3xDRHsZ/Tfi5KFD3o+G0tQUIeVtZUhd5IDzON9KVRkGkfKWHLrscMOXpcaKhpDJ
 0X7aKCVuM0hBz0/nVRwGV1zH0WhkEHwDTtWej7Zi3cV46J4V09YJ8U7FMli8tSk1
 cGdoWE8SjVCMHgoWKca2h1v3QE6MKI8lCYMlBjxLLfXCxajm3xiKaVQH/6PWzKXB
 LMKcHiyPb9PGhCIeOThUhPzr41+gUq/qTI/jlMh4BFYTzcey3hVHi/UtFoMfhLyD
 A8HErZVfHbYCsYBx95FQWYt5pvA8OOCSDmRq2ps8sk2df1qGm/eafFNRKFg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dey5j1ev3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 17:56:09 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12c20d5d7f4so4771881c88.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775843769; x=1776448569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQmlyxpZaVVP/6TW6V7qRLUtxbYcGCiDyOnIxm58+4w=;
 b=V4+cpEDqCqoCndZHRJMlv+Cr7bqoshaM9ue13WWHKW/s5Fhba4V+czMFAwLa7eBjBZ
 s2n8t13jhKG44NyBfFBmBvodIipbDVpLwUwnlyJLHZZ6U/uTZnFVYSbeqAQmKuM56SoE
 aawcgf5XJloeH2aoZmmEg4bBKJGvcSuSDtcTu/SWPbtzX6v/1iF9CHfWMP6CMnFyw4x2
 anIP2U84KJLsMc6AC34187B+0qWp87+x+auE2XRgdKIMy9pNyv8EY/aANvMNx11IkdNR
 oQw57mh8ZVDSQG8phsowQvzqGF7xroJyFKvBi7oweYX+vy33z79NM3xkdWoM1hWzs/if
 rQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775843769; x=1776448569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UQmlyxpZaVVP/6TW6V7qRLUtxbYcGCiDyOnIxm58+4w=;
 b=B4jVNcD1UpbMQLtArwDV0aZxatMs1vpADj/ron1AXSu3TwVytN7pMG7SULVJY4QDKZ
 7na1I4KOrhJi4MuB0aiFQBzF/BECQrrpmd5JeRQ2zOLC8Qg2eXuC0cqz1vaZZgsLE0xX
 XvngzQE3hLZE3/iBRHRRfkuOqVZSfZNlAI1bulVerX9OeZhNbvhs2mi6yeMSsEwMY4Gv
 V7T+nrrIb+cKmhhWbFx0/G7XlcbDd7h+gOrCMom2TjRF7n/ZiJ4bYTtKV0dPmrxguZ2D
 A8MZkhPhS0OSRXtLdBV5u/z39ynkUqv2bOxzudCHa6sE2v1NMmLuDfdIViIisQTDIRh5
 84Kg==
X-Gm-Message-State: AOJu0Yy7AHMw8wuHKr0diw6flUA0v3/J7xhtr12+kAscgr1XUepfG6ZY
 V5fy9BMu3E4LC2e8eR+eONM7ilwsC/J+vN2Wd1hLX697+JZ5sQ/Jox/5SdqwQpCDXRd7VLrgTBp
 weEDiQi/mU1SmP9ADEuN0GW52CP3Ef698+MQXsiMQKJuhfCVEHWtZprBJrftI43UFkJui
X-Gm-Gg: AeBDietfxPE+/zId0j5vYLPjU3eDM9r39tQDG5TrK1KvWKu0fLGfcKjPGD2r4xFqKWM
 S98DkYePHo3SmH9fr+96f+dpr8/5oeaENS5yXSQmotJdcgCKH6hJjehsQ4o3wuMMb/HPBQmZzHR
 9+AzHD6JJfJdYCH2DViz+zI+B5FqBmwm4+dA3p4bw9DOPuRtZ+dU74pnLZ/GL1zSONCNMiX6Mls
 t6NJ10wXHrVt6jOtUaeJY7y6/eJi+Sa2/dWOztDSIOPC8ePIrVKgX/xHcBDuzz6woMsbRNHs4Js
 N98vL3iDcoewGhPJdthVPuZjF73PeC8JksIyBnvnADqWl27gwqDzr8Tw4q3yIw3k+jWlDbNJfMc
 rPGwgnDhQXl3fn6IuKz6wzxLtaMZI8OjaFRygVI5clcwBXYMNDQB++XfoflgF5PFFvcVf8t+4rS
 515OZ8CxtJ
X-Received: by 2002:a05:7022:6282:b0:12a:796b:7cf1 with SMTP id
 a92af1059eb24-12c34edb8f8mr2729694c88.23.1775843768532; 
 Fri, 10 Apr 2026 10:56:08 -0700 (PDT)
X-Received: by 2002:a05:7022:6282:b0:12a:796b:7cf1 with SMTP id
 a92af1059eb24-12c34edb8f8mr2729669c88.23.1775843767887; 
 Fri, 10 Apr 2026 10:56:07 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c3459f7ffsm4256271c88.3.2026.04.10.10.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 10:56:07 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 01/16] tests/docker: Update hexagon cross toolchain to
 22.1.0
Date: Fri, 10 Apr 2026 10:55:49 -0700
Message-Id: <1440dd86da7dfcf88037049a8868cbcd05947ec9.1775843299.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1775843299.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0GC-aE4hFtjoVQWrb_jwPvNcPhuBEn18
X-Authority-Analysis: v=2.4 cv=b9aCJNGx c=1 sm=1 tr=0 ts=69d939b9 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=ovJmrJClAAAA:8
 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=q7X4_axEi9qJq2Gpr8MA:9
 a=Fk4IpSoW4aLDllm1B1p-:22 a=brTEhlvMp4NY0_u118I2:22 a=fsdK_YakeE02zTmptMdW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 0GC-aE4hFtjoVQWrb_jwPvNcPhuBEn18
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2OCBTYWx0ZWRfX2sfPvGOksyon
 LKm8K4L0urg5EHJ3LBctK/PN6fTx/Qe6Hs2j3voeItqvQ3UPQEVhuci5qQp5L6FpVXMICAHMGea
 2bGScK0zNdJnNRce2pZLEoeHAVk3KvVSJjnGi7bl7mr7yBkVth1XxamztIDopVlpG0b7F2Ztbzm
 +6DaAm+dzWp3D7K7CKkFMEQ4pG0JYE546MrwqjvzTqKSSo7AVb/rNSLbdJygZjCne23ukuGiAuT
 VWaDcRhPM9FvnCQvFF2sHaDzYIXAkL8Xax4NDKYEylRgpMAoAelI59LZa1ICF6U/U0xaXYe8u5Y
 0uzKgUtv/5oeT+QOsaQeIt1Cz60MqgCMDb6gTHoKblecH8Z7nOe+RzsMsdYD2q1NwD4T7lekzSa
 in/YeTPRfRMvc+rgjSA3e2Tmh6Co34ZsGWJy88EuLBI4dmsJ6tAXquq6PkZuCOkilUMWmS47v0q
 5vhArZRobe9K7WR06dA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100168
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

Update the hexagon cross-compiler Docker container to use toolchain
version 22.1.0, replacing the previous 12.Dec.2023 release.

Changes to accommodate the new toolchain:

- Add libc++1, libc++abi1, libunwind-19 runtime deps for the new
  LLVM-based toolchain
- Add zstd for the new .tar.zst archive format
- Update artifact URL domain to artifacts.codelinaro.org

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian-hexagon-cross.docker | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-hexagon-cross.docker b/tests/docker/dockerfiles/debian-hexagon-cross.docker
index 91d4b71ac9..636d0ca8a0 100644
--- a/tests/docker/dockerfiles/debian-hexagon-cross.docker
+++ b/tests/docker/dockerfiles/debian-hexagon-cross.docker
@@ -19,7 +19,11 @@ RUN apt-get update && \
         curl \
         ccache \
         xz-utils \
+        zstd \
         ca-certificates \
+        libc++1 \
+        libc++abi1 \
+        libunwind-19 \
         bison \
         flex \
         git \
@@ -40,12 +44,12 @@ RUN apt-get update && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
 ENV TOOLCHAIN_INSTALL /opt
-ENV TOOLCHAIN_RELEASE 12.Dec.2023
+ENV TOOLCHAIN_RELEASE 22.1.0
 ENV TOOLCHAIN_BASENAME "clang+llvm-${TOOLCHAIN_RELEASE}-cross-hexagon-unknown-linux-musl"
-ENV TOOLCHAIN_URL https://codelinaro.jfrog.io/artifactory/codelinaro-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}/${TOOLCHAIN_BASENAME}.tar.xz
+ENV TOOLCHAIN_URL https://artifacts.codelinaro.org/artifactory/codelinaro-toolchain-for-hexagon/${TOOLCHAIN_RELEASE}_/${TOOLCHAIN_BASENAME}.tar.zst
 ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"
 
-RUN curl -#SL "$TOOLCHAIN_URL" | tar -xJC "$TOOLCHAIN_INSTALL"
+RUN curl -#SL "$TOOLCHAIN_URL" | tar --zstd -xC "$TOOLCHAIN_INSTALL"
 ENV PATH $PATH:${TOOLCHAIN_INSTALL}/${TOOLCHAIN_BASENAME}/x86_64-linux-gnu/bin
 ENV MAKE /usr/bin/make
 # As a final step configure the user (if env is defined)
-- 
2.37.2


