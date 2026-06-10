Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8114CD98D0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 19:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXOVg-0002uv-JZ; Wed, 10 Jun 2026 15:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXOVd-0002te-21
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:22:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXOVa-00008p-Pg
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:22:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJLIed2529038
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:22:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nlRGkzet7M0uylTzix0QmY8CW5b4ovsIg+ldm6b1xoc=; b=QKyXFtPUa3JOUXVE
 2jQryqthpococMzMbmT/VWdHTdzWDHMepZqaWe94GnKwrxu28wm8VOCQ9PKIZ7I4
 otU4wH/JotfHVc9e8CwcNRJxnCokooBEdx6m1lnfPO7iIAI5gSkSFl8CmJqtmcJ/
 x+17w1rFz7B4jccwQC/AJXzP0w9udmMf1k1BU8dSxRuqTH/V0kS4yGvZT05R+etv
 p71rgn1L9mfip00zY7sfe10KQmvw/CQeuK1CpRRhr+Oe0O5mUrqOhbyICVhZCCID
 Ini4w9BGhwgXs+RiMq7D5NaoAbho24vTlf2uvOY0G37lYfTw/qfzT3Gn44QHNiQX
 yeRLGQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epwnnv9x5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:22:36 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3074d4102a9so5524888eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 12:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781119355; x=1781724155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nlRGkzet7M0uylTzix0QmY8CW5b4ovsIg+ldm6b1xoc=;
 b=RS4KTH8zfFPFz2tx70cAQkg46jfZwvL1k0I0G1jG9zM8ljXkg5wRKZHgK/8pGqXF93
 eSyvKy3SJEsf68gPqNpld7QQFOdfP0AcSVJJi63ypbYOFX6UcjMV5ZW+8VHP/kNkQhf8
 VlEF8ncAfMhcdNlk3ByVlSX5kSdBKbYu5ZqQWt2ohbgkmrRgWhdOWWUuNbN5gZceG6WW
 WCUQhwLtsGKLFaL7ONqbSGW4K9Beu05XAso6BbRbJMg0EGQiAEZPWG/4IelLcOAEJn0D
 QT9ywoWPXZaeUgy3Fi3GJZdsHQvC7aWARQ3qWpafP8SHD+uFHJmQNB0nKgsRvf8zepjA
 Trxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781119355; x=1781724155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nlRGkzet7M0uylTzix0QmY8CW5b4ovsIg+ldm6b1xoc=;
 b=pJf2mRqLFN9n1Xs+nlo/xXTy8VtQlK6w8wvc2g8qh2/exn7bUuEdTOWzkZYDb4e5y5
 MHYzF8oNjF9UuHN3G7PG0lVAkqYMeLmHWMi+AGL1Jlaoqgq2MqcYhmEaOsJvkZepqnPY
 mP15yrVGn/odQ1sFnqxFTp3+wR6mKVdkuMvad+erx74IyvJZH4q8BH2m57ocICzHMFTN
 5OTGZqoafAYdkE/aOTMXmj+pSLl0yNMoitC6Z6X5+8goWmT8fUb5FTOGZFpYwQoyEZX8
 N0kpJP9fj9lWKerlFSS/RIwdZy6bj2cqtIy2iBg0PTwTsLxLY5G+92SKF+kUwnwX6hLL
 vLOA==
X-Gm-Message-State: AOJu0YyEZzYyCXctdu4ew0fWUiFCSisAOMa+aHCVpNXGhzE96bLOjIyp
 T1ihtRIX3xykaHEEYAzouxGxml86V8tSrE5nCQM2Z9jz7ZFzLeRCSDNJuwkNmwYYNHQggpsLx+d
 Ry3oYpiDCNWwTi4wimkOYHFCDFbQx8fCE4uSaKNOOd8EN+fqKfNUv2OrNKmIQunFWw9eB
X-Gm-Gg: Acq92OHm1OFk+/NOY7LS2+5xuESzZrlL8/VvV1VOd+MFr+FmUP09V21ohFNflbBRFPu
 meBYQw2oRyuT07kwCyGxLxUD+fuCtydzFm1o/p904MoLogQfvZvRlxGtBCcCuawOHVdNRMux2gX
 CxXRNmicM5l/ak6wNAYPtK9HRiQa4tQLyYeR+nyOBuHNTZ/ZSad1pQkUVmvpItfR+iSE3iYo6Wc
 cVogG1R09IMI123Ynl4ATlCKFv72p2jgBPEvR+sS/UA7QRm6cD1e81RVZYaxRxIRS2rMlDFeBSF
 Y3QFwMRO/uoAHpqQoKuj9ojzASCwabymDbzzVaByQtQEAyU46kukU+ZvxR6ZThVieNZ/RS15khn
 YDhv9/Gt1KEacEYmnB3EYHGp6lSImZIvl/PswA153rhwfnvWcwmTQ0JHPGB5lhQzM76yRTkdfFz
 HKGx6EpV0GzKFEc1A2
X-Received: by 2002:a05:7301:2f8f:b0:2ef:8b91:212 with SMTP id
 5a478bee46e88-307ff55b3b7mr450737eec.14.1781119355018; 
 Wed, 10 Jun 2026 12:22:35 -0700 (PDT)
X-Received: by 2002:a05:7301:2f8f:b0:2ef:8b91:212 with SMTP id
 5a478bee46e88-307ff55b3b7mr450711eec.14.1781119354454; 
 Wed, 10 Jun 2026 12:22:34 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df3b234sm34128986eec.23.2026.06.10.12.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:22:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 4/5] ci: update to ubuntu2404
Date: Wed, 10 Jun 2026 12:22:21 -0700
Message-ID: <20260610192222.2709135-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610192222.2709135-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260610192222.2709135-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rZq4OOU-ds1qtOck4XE6PpbwyFRat-er
X-Proofpoint-ORIG-GUID: rZq4OOU-ds1qtOck4XE6PpbwyFRat-er
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE4MyBTYWx0ZWRfX3jOl1uCGMdE+
 q7O3nM+FPrYLB4Nosc+Aixugm33+RZanGNFKtp0+u8a26dTPw3ltu1jY821hwpAzu/OqS16qjjy
 KjzMh+LCUli2SHd49lZ/CSr+X461VLbx1I2NKWF78kb7B1T48pU5GhlbreBuRbhbxHHaTPZ220q
 +P/qLmZqEyhOhoMZ1b3u8DAxo/mPjrxNtLMsk+1w7/wz0kmSXuktdelOXDxMbm4jpW5Lx4l1UsC
 Qarq8IHR5ftkH/jc7WKFrw9vGKrqk+NuQ8KT1c5C661u6Le8rwsMekYfEs3hcHFPyedu5TKbdzj
 hw+dlFrQNrQDJOhda+0iVwNpMQdXPpgipGzu7tQfa5yeTke4PFqh6V/XZQeXlPVznOXGHJYEQJw
 779BZoEoDPeHQr55fiIuf2OAJKA8Eyb56KO/ZhPuzHaMuBt5t6edsl3HNCkaG5FEhbu7oFdLHd8
 ZNkgpqavnR94P6ruRkA==
X-Authority-Analysis: v=2.4 cv=epLvCIpX c=1 sm=1 tr=0 ts=6a29b97c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=S56xvJB5AAAA:8 a=EUspDBNiAAAA:8 a=gx47tQcWSZ5Zqgra8CgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100183
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .gitlab-ci.d/buildtest.yml  | 16 ++++++++--------
 .gitlab-ci.d/containers.yml |  6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index d0543490309..e2553e7326f 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -36,9 +36,9 @@ build-system-ubuntu:
     - .native_build_job_template
     - .native_build_artifact_template
   needs:
-    - job: amd64-ubuntu2204-container
+    - job: amd64-ubuntu2404-container
   variables:
-    IMAGE: ubuntu2204
+    IMAGE: ubuntu2404
     CONFIGURE_ARGS: --enable-docs --enable-rust
     TARGETS: alpha-softmmu microblaze-softmmu mips64el-softmmu
     MAKE_CHECK_ARGS: check-build
@@ -49,7 +49,7 @@ check-system-ubuntu:
     - job: build-system-ubuntu
       artifacts: true
   variables:
-    IMAGE: ubuntu2204
+    IMAGE: ubuntu2404
     MAKE_CHECK_ARGS: check
 
 functional-system-ubuntu:
@@ -58,7 +58,7 @@ functional-system-ubuntu:
     - job: build-system-ubuntu
       artifacts: true
   variables:
-    IMAGE: ubuntu2204
+    IMAGE: ubuntu2404
     MAKE_CHECK_ARGS: check-functional
 
 build-system-debian:
@@ -577,9 +577,9 @@ functional-cfi-x86_64:
 tsan-build:
   extends: .native_build_job_template
   needs:
-    - job: amd64-ubuntu2204-container
+    - job: amd64-ubuntu2404-container
   variables:
-    IMAGE: ubuntu2204
+    IMAGE: ubuntu2404
     CONFIGURE_ARGS: --enable-tsan --cc=clang --cxx=clang++
           --enable-trace-backends=ust --disable-slirp
     TARGETS: x86_64-softmmu ppc64-softmmu riscv64-softmmu x86_64-linux-user
@@ -591,10 +591,10 @@ tsan-build:
 gcov:
   extends: .native_build_job_template
   needs:
-    - job: amd64-ubuntu2204-container
+    - job: amd64-ubuntu2404-container
   timeout: 80m
   variables:
-    IMAGE: ubuntu2204
+    IMAGE: ubuntu2404
     CONFIGURE_ARGS: --enable-gcov
     TARGETS: aarch64-softmmu ppc64-softmmu s390x-softmmu x86_64-softmmu
     MAKE_CHECK_ARGS: check-unit check-softfloat
diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 515e7382f26..87c20094d22 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -13,10 +13,10 @@ amd64-debian-container:
   variables:
     NAME: debian
 
-amd64-ubuntu2204-container:
+amd64-ubuntu2404-container:
   extends: .container_job_template
   variables:
-    NAME: ubuntu2204
+    NAME: ubuntu2404
 
 amd64-opensuse-leap-container:
   extends: .container_job_template
@@ -58,7 +58,7 @@ weekly-container-builds:
     # containers
     - amd64-alpine-container
     - amd64-debian-container
-    - amd64-ubuntu2204-container
+    - amd64-ubuntu2404-container
     - amd64-opensuse-leap-container
     - python-container
     - amd64-fedora-rust-nightly-container
-- 
2.43.0


