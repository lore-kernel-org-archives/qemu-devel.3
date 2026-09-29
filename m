Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C869CA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSSK-00039f-EM; Tue, 29 Sep 2026 03:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSH-00038h-IV
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSG-0005qd-1M
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:49 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7TkF34097687
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=n8wJ7qM9+X2
 8bw82PKFMw1fSNoPLyiCVS/6VxTq85tg=; b=pdPK5lJmHuLRdeeqGsIG8k3uEpY
 p4kZ+SfxnOfLYlSPu/5eNF9wT2RxbLjwdV4yheSfkGlYs/yH/1KHdc8CGEGQMWy/
 8M3B5e1DkJTiZkmpWBt5TBsTVWEVOHzbEVvVpDMVV7PfoWDIwKSMI9xVqWwos0Mx
 TIT7kk5fE7jNNF209C+6spH6qC0zRTHMObiTRf6tOWj7yHLtkOtgI4iPJQLrf8YR
 BaMvp8sziBOQieIFZHLwWMYScHAM/pD7CaW0MFHXPnB3vfs3WUZF/mbecc2xVu1P
 q9mYtBQgFHk5H5xd06W2ven8r+LQOFBOg6wHkb7X0DYvVlgl3o7Tl/hzxCA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h03ew19yt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:46 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34bbf2e3c5cso268035eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667646; x=1791272446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n8wJ7qM9+X28bw82PKFMw1fSNoPLyiCVS/6VxTq85tg=;
 b=N6FkoCv2P2mTOuHn8Iy/MK1Jh+QwfcV79ocBb5zNFNVueo6ClKOZz4WS2p0wTPHIyh
 u99BAIh/ZyT2Cd8ueIy/NSFn1CF367gNsq2GCp2zN3ueN81YkR1zzKQ7iSLHutliZvNR
 CDXouLijbDbcwOdlixlbI2PO0dUQ2dKywYowLfJq82H0E+bo6pJ2LxI//XzGZN97pGzM
 r8X4NAh7vi6qHTd/6pn0xupRQsq2c2qlQ+RA4QzlW4iYkCyofkDWJEcnNtAdcsRRdo8S
 J23MqjLFBOUP7f6UF9MtM30/FQKTfNAAb9e9cs7HHxxYzzifReETM0GQY1uWEVaiGHLo
 BEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667646; x=1791272446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n8wJ7qM9+X28bw82PKFMw1fSNoPLyiCVS/6VxTq85tg=;
 b=zJPts6kmvhmP42ZATprQhf9vQUgXuVhWnKM9gtTGn+clQ1rH7/fP1fKvzVMTktQrA7
 ulbbPISE78Trvln314lzFNfiRWSbgArm0VzMqGzkvf8pgDKkvKWZ+xV7st3Ynjh6i7vb
 Sx5bIRhrC8v1VkGh7CZ7MlxElQ7GMQhSYk5oY6tBxj3GkNkwk6kh61nWaT/Nld7CdOCn
 hmYHGoHXdJD+k9ddKqVYSPIMFiZXTLQAmwmlKwk0MvR7cH9MxcTaaU0lrq6Dzg7uJlCe
 cY3KVONu+qntw4PPcO6qMhFmNhX3zKtYhHYOTr+yZKNinfLux+ET1qf8joh0vX5qmHbm
 eoUw==
X-Gm-Message-State: AFq9FYJ2fJGZnd0jy+5b1Hg1zlWYH4uZ28KKl6yhB4fuGH3UIcqu/Fq3
 B5k95r5sinLTRxzu31gNUVgkK0d3unYglozhuGb7szgjvmeynYHsyP8fzQiutDgVfMvx5G9WabM
 v+c85eUCRZqo7H+PN8j0eIsxeli9rfnW3N1pa1JrPUFb5wE2nskAU42GKP81nWydJ+w==
X-Gm-Gg: AYBFou0BMaTn4uF2/UIY3VFgsHwElCsZkn+sIaiIEbn0COawXd2Kz9aPiYY8J1vcSIu
 zZhfJqq82iPQIRdSGBY9a5gwYJLfLJvqhYCCr16ecIFJ57SJvwpul4Jn3pOQEPfSzmvkhYsYoej
 9PPhr60IMxy3YOZReWUwxn8a5RzykYuDqnoEYu9+SIgIOy/JJxYv0Pki+cUulPJziwJ0orldxPj
 Jny2B4hqvpUzwokPD00El3Uk2IsMqNYNBIaqEkyyZ0iEpuwAeK904X8vIM2vjxtKrww/i8yNRq9
 W4bFo/3j0N9Kl+0ExWZ+HZRG/UqIuu+1MNBtoBUAMpmLgGuSNFjBYR0o6U202FSb4T/LK5+KY5e
 xp8EN6xkBzGPmv9HFbC2YpI8ON52Mf/Lxakyz1V3CA6MyLSSObM4Fk6ju4w==
X-Received: by 2002:a05:7301:29b0:b0:343:9eb1:9940 with SMTP id
 5a478bee46e88-3439eb1a517mr10423948eec.26.1790667646059; 
 Tue, 29 Sep 2026 00:40:46 -0700 (PDT)
X-Received: by 2002:a05:7301:29b0:b0:343:9eb1:9940 with SMTP id
 5a478bee46e88-3439eb1a517mr10423921eec.26.1790667645541; 
 Tue, 29 Sep 2026 00:40:45 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 11/19] tests/docker/dockerfiles/debian-all-test: add
 mips64r6 toolchains
Date: Tue, 29 Sep 2026 07:39:59 +0000
Message-ID: <20260929074007.118970-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX0MJwDYo04vkp
 58up1l2dtrkzrDkyYFg02ySxUemxBYqcaX0l9NTDhbwZcjh5PiSuVNbRHHxWHXYrHzBcOQYMwmp
 Q8YPgMxt87sorGUe4TBC8RgWSUZRcAU=
X-Authority-Analysis: v=2.4 cv=IIOXmQvG c=1 sm=1 tr=0 ts=6abb6b7f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=QGe5pQXJF13hUJcwtqwA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX1nW914ErcIWg
 /mhpxxvheKZenxu57VggJK2FumrYBHWEBfYSEe/6XWbqUZbg7RQGiIAniZU8EmWY5/NnCFxTP0V
 Gb9BKAQEX/hdQaWF4QncxmVesr1i0Tc6ktPOw6rq3FLrpRjIXOT9i3EoKiNpgfdSd4JHpq4+Gao
 wtEC4XwFPkf7n+jxsAHCSaNnsWrYbVPbPR0wFQdbdutt1yVL/5hjm8RYLRlJ5JXzyv+oA716I5G
 wdGpMMNpaNdq9HO7d6KhicxoRi2cg3e2n5kQ204NuqSx1+yFjvT+/XIW+Rw4794UzIGdkLvM5iD
 6dLifirDU3DGSj6vo0aub9Om5YU8AwG6EZSrqlaM9JVoWOmtywIYUT20z9yloW1U4teDop0TbbQ
 zo3dxBoaRlQL+CsPbpKIK70rkXqYU5hwge1jrLprpMLmYeh9j6xTHt/wc3IB7t+JPssbbWtJrg8
 zVC0iudFEgHjTZ3ml7Q==
X-Proofpoint-GUID: CDm--ZHwBOZlbSVyuQfFQJV0hst4TYq-
X-Proofpoint-ORIG-GUID: CDm--ZHwBOZlbSVyuQfFQJV0hst4TYq-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290030
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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
 tests/docker/dockerfiles/debian-all-test-cross.docker | 4 ++++
 tests/lcitool/refresh                                 | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 97d3dae6d7f..94524480880 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -89,6 +89,10 @@ RUN apt update && \
   libc6-dev-mips64el-cross \
   gcc-mipsel-linux-gnu \
   libc6-dev-mipsel-cross \
+  gcc-mipsisa64r6-linux-gnuabi64 \
+  libc6-dev-mips64r6-cross \
+  gcc-mipsisa64r6el-linux-gnuabi64 \
+  libc6-dev-mips64r6el-cross \
   gcc-powerpc64le-linux-gnu \
   libc6-dev-ppc64el-cross \
   gcc-riscv64-linux-gnu \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 31c06734879..662d8a79f3a 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -200,6 +200,10 @@ RUN apt update && \
   libc6-dev-mips64el-cross \
   gcc-mipsel-linux-gnu \
   libc6-dev-mipsel-cross \
+  gcc-mipsisa64r6-linux-gnuabi64 \
+  libc6-dev-mips64r6-cross \
+  gcc-mipsisa64r6el-linux-gnuabi64 \
+  libc6-dev-mips64r6el-cross \
   gcc-powerpc64le-linux-gnu \
   libc6-dev-ppc64el-cross \
   gcc-riscv64-linux-gnu \
-- 
2.43.0


