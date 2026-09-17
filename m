Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A66EC982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 22:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7KKc-00038l-NA; Thu, 17 Sep 2026 18:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7KKb-00038W-6A
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:11:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7KKY-0006iK-Fh
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 18:11:47 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HLpIfn3859825
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9g72FM4KAL9
 fPzUiImh/xcMA74+b3La8tuWm8tFChy0=; b=ikToqNbrH1Kpl0/5sWA+Ouk2NdB
 Wl2iAtxMNqko1pETvAQLRcndIUNLrxICy9h5eLPsq0E9GQ5Na0LNmsv9nrKSjFIh
 Bxzx+/afkWSPG44NDUPPtDZGJItlSErIl3NKBRbn8zOW5NPatktIocwd05CIeXL8
 2T2oL+CFCzCwvRTJDKNn8DnVQwH8IfP4O//Ndb9rNqmS3Qnmh5XHUtD9274MngDp
 Ns5om+eIh8fQxNwoeWpAPXdq9XUSdAOzXmojFza9WxdS2lFEXD2yrP9O/zuIfHq0
 n/HCEcjM6I70YckX6/zLiW4vLvtWRVS1Z4qW77dzB6pHedI6KVAZZADbIpw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grrg4022s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 22:11:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-398dc3d8f0fso1253565a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 15:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789683104; x=1790287904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9g72FM4KAL9fPzUiImh/xcMA74+b3La8tuWm8tFChy0=;
 b=HI2TsXSG1+pkiKfuxPkfaEGy7odpEnth08AAQhWTKq07dLaoh8gPCMzmckqOc4eBEc
 wMBtuhCKtOBAN5TTz62izIwrpjcCYprO/M5Jr/KEXFfiH7+VRw+hZkChau3rLisOc0t+
 ufUwuopN2K/+W8+1Kn/k+OJqvhb3kEV5O19Jxt69rMMLjBxZNQA4IxjPzWKQY6mNqmjh
 3WhRaind9U7rVbXQoNzGXwEZxakK43EF2EncpyXkGuMXQrxFrPsItNbiUsqZ/mXgRs1F
 ZABoM8l/pocyaRDzuee6A2d0fZ1cSnZpKIaHZLErpOo7EeMyUTEZcWal8REonqv8sS1W
 v+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789683104; x=1790287904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9g72FM4KAL9fPzUiImh/xcMA74+b3La8tuWm8tFChy0=;
 b=mz4QjvqmU1SIUeimHF3GIOmralltHeHVGfNBK3s+SMHp6K1lj0RDN1sGovZ5PzWXpG
 AQ53WXIk2US/WVl2l3EccswzxBNxvroAEu9Gl4aWznKlaZL/esfRkif7yf2Bxkw8a5bH
 w6VjvrpysROaTOUdwmYzWW3zYoYbaVEVpDWClH8QcLlrGuZdNqs9UwF27HC4O4J+xNtu
 y8WAVpHzZ7O7pd6myVQ3l29O0bHyMhBjuPzuP8d0NjJZTHm6CAqLSxAoqzFEJk73VG0r
 449sx+629PedvoVPgfZRzWZXL9Is3rLPieSgM7+KcWCD0mhUORaewdoB7jrettvqZSF4
 23iQ==
X-Gm-Message-State: AFuF++maURW2yC1vmfkIxnh0SOEw/X2CjhBwRHI91CVgeT4E8vKZUzhw
 i0s+0zqou0Bu7QTDc8YDRWYYw6iKdV8HWa7FVtJPdiX/7e5t7ilWwXyQjAIS4Ntv1skMfYvDZIj
 o1Q9C9h2x0GCMI/9syDEasb5Nox5TUTWBh13HTrNYt1sAHBwOwKzhLmswZ4766XiJdQ==
X-Gm-Gg: AYBFou1EB54IGNUWn/OqjtMsWq+kdhYBSiejFD62Al/g9q4rXN+yOouxdOhzJ/5Ytv9
 k0JOTIvkJ7OenenmboPGkcoplBnMaz6F3lbR0ry7Dq3CTKdwZ92rO3pcVYws0FddNArr5+0sLuP
 IOcJMecckJoytRvP7tFLoWNdqGJ8xncWo0u+/n2seSmfvOz7WXDURNHx40ygC3o9Ol3ozGLLCj6
 /HDJeakSVEoHPg7yErNVsLw+8ysEwsejFfEjrHHJaA9J2/aMR3LBPNrbhJcjiJStyyI4nPntARa
 /k/x+ZFe4Wq+l04kSKH7ZgSOhp/0sJ3ggHYDkdMH7ityEp4uWEE7wp5AgWQGYKGj+LVADAm+A8V
 /AJV5f7rCecU5e251yenhp1ZiGMXl4MNVr2Ma/p8FjlWW7kPFd6IR/P7fllk=
X-Received: by 2002:a17:90b:498c:b0:39e:5481:54e with SMTP id
 98e67ed59e1d1-39e54810a5bmr769670a91.19.1789683104311; 
 Thu, 17 Sep 2026 15:11:44 -0700 (PDT)
X-Received: by 2002:a17:90b:498c:b0:39e:5481:54e with SMTP id
 98e67ed59e1d1-39e54810a5bmr769642a91.19.1789683103839; 
 Thu, 17 Sep 2026 15:11:43 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm21021430eec.14.2026.09.17.15.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 15:11:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 3/3] tests/docker/docker.py: do not add-current-user if $UID
 == 0
Date: Thu, 17 Sep 2026 15:11:17 -0700
Message-ID: <20260917221117.274619-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917221117.274619-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260917221117.274619-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: v6HOREf111-x4nQfebx_szJPyNuRPyXA
X-Authority-Analysis: v=2.4 cv=ZO9CCn7b c=1 sm=1 tr=0 ts=6aac65a0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=-vN-UFzxm2gmQjGixjoA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: v6HOREf111-x4nQfebx_szJPyNuRPyXA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDMxOSBTYWx0ZWRfX3wGGUh3Z34Zz
 zBkMb327pbclPTUeEbi8z8I9XCi5QlVAqTu6I9HrGj/Sgz+bLMgeVFpl+uu3147TR6UO/5xqpOR
 EhG4MxkIK8b9GCkJI47l14b3RFa2FYkGzAi6T0ZuXBbRdak0hERKDs3tujqPwcAWHiYqyxJjgbV
 7wRs9ZcTVpiLX5GOz0hDEurox3eElYLjPzXbi+t6zMCiNCDFCl50dcz4hwPWWHDFNFyTjCFIC5o
 CjY17AoTdDWEjcbFbJMM0Fvh1mVjZ+tcAm8Lkjf7Iv4QAYfcUIhYNuvz6OsC+g2XajJFyjsvyaM
 xYnEh4aX6IGtHOxvLDYj91ilusT/MM2XOaEgY2PUKd/4+y/oHKSgGiGYOCp5snCbSVQ92tWgVNK
 h1yU8mGgcidQ4A0zEX3ybNoZY403kcDltptV4mBcFx0ZCggyJE/S0jWSAJLmQdlH7hCPbSjmOYq
 jev0poxOMvOt1iJ4rlg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDMxOSBTYWx0ZWRfX41ub1kNfIvA+
 QBDJ/xxRI7TpK2NEotT6giekNOkY6TyAeKxH9EF6/zv4GGX/JfXB1wClCQUIj0+8zRJ4OsEXNCZ
 2ozx5dN8ODYpeCkx0DDsZWFKNhSFJoc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170319
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

root already exists, so this step fails with:
useradd: UID 0 is not unique

The setup where it happens is when working on QEMU using a dev container
with podman, with default root user being mapped to host user. In this
case, uid in container is 0 but effective uid on host is user's id.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/docker.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 7c15da59db6..80b1a5c6925 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -300,9 +300,10 @@ def build_image(self, tag, docker_dir, dockerfile,
 
         if user:
             uid = os.getuid()
-            uname = getpass.getuser()
-            build_args += ["--build-arg", "USER=%s" % uname,
-                           "--build-arg", "UID=%s" % uid]
+            if uid != 0:
+                uname = getpass.getuser()
+                build_args += ["--build-arg", "USER=%s" % uname,
+                               "--build-arg", "UID=%s" % uid]
 
         if registry is not None:
             pull_args = ["pull", "%s/%s" % (registry, tag)]
-- 
2.47.3


