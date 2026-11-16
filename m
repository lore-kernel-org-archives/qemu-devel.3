Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DC7606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZGuKsmEh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P/Dn8iiw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT623-0001Qq-Me; Mon, 16 Nov 2026 18:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT61R-0001Dy-T9
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:22:03 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT61Q-0007bZ-7e
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:22:01 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJes6d2727738
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IOhpZiCpqaY
 nKSsE+BPATiYGVJq6NbBud6fgy8i1mH8=; b=ZGuKsmEh54W1iN+gcupozitRLEz
 aJktOErICVBKxRP9b5HCPlHxBnAILCtzSX82I1KMo8B0lQUiY9NhuwMVK1+g0BHo
 MYlXFVWoo5B448FN7/RNlW4gseT9Q7xr6FWjWD6wO++wTAzl0ypQfbwQs1YZbEij
 aZmtDKXEELJ1bybJN/cwhJMlKQSiK33RPn0qJ8MgqFu/GiVoAgwJ61JWIkiC0TW1
 pBITITVSj1kWJGcVWHBEk3mBmR0ajOmhoRAEX9YO0T/9+ZL/5A9/yzWLsGNgGEkp
 KglFfvF+gO3m8srq3eh18XquN0XVchEWKk/MnZF7rinsGjE7RNyAv6QX/Kg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07regukk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:21:58 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b18165dc53so5732711a91.3
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871318; x=1795476118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IOhpZiCpqaYnKSsE+BPATiYGVJq6NbBud6fgy8i1mH8=;
 b=P/Dn8iiwzzOctIpZ414oh1ptZWmZYyZfvrbzBgnhrPFYGrv+rvpkpQtDkxhP2B3Iqq
 yKrBOtwWVb+qbZI4EfTXNP1T3+ggPot/pjYtlRGNzwsmQqiAxTb2Qw5X4ik79R1Q2Que
 05vG6GHR0zCcVpLJos+dNapcGjVNjK6k1TEzg/6I/iuBSLJG2zN3Pw52ooYNKAZq7D9K
 xAVJpXNmn0VuyS6lU5m9pZQsSukGO+KnHs3f7ob/3sY1S07c9n1zm0+OKIgbmRg0aBG2
 ZJBUDRqrwlCtc6KfZIG3hsYK/DnqJnwjWre+XmxxGsNzpC00/TjNyavvZ6rqaVcU0kGC
 Q1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871318; x=1795476118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IOhpZiCpqaYnKSsE+BPATiYGVJq6NbBud6fgy8i1mH8=;
 b=SIVT3/x2fxf5k4LKPPmNds4/1RSRtGFYp6Hii0c71/tMGKyJg/+BeRKmJm+YNiFl3z
 LBdrafrHxHlQtv6//P67MspOb/0q47uw2qoINY0Drkz/Bpb8PDAVYXXqKV78wIQbdzX3
 CQUgNwTObiVtzB/1hVPu6ypUSHbvLidnwd/pGhWfHWPamdBzMRnAWjuk/EUbsYeA71pQ
 48UuTigB0EdZrOg0708q6O+4O0ENLJdo0I134j0cv1dR1P4AGhief+hFZNl9/oboSaqj
 04j/80vqzuuQc1EF9xFQtd5B18RC/LwACQj7GQPmfc23ch8ATvT5kkDskRbvRYadN2Qd
 XiKw==
X-Gm-Message-State: APuU4Z88ErN76Mn0mWAEwFtTjH+GoqMiMfsaEECgJtTMBQpi0JUe43qd
 gVqC2rZSwrQTJk8oJ37BrhuUdC7bnmveu/y3U3f3k3XxwOmlcqot+vJE69nB1O0X7xz7Abyk+E8
 5RMOPTwhmuvLZhmx2Q34V605BB9yTkuz7h8F/DSs1F0dC8gs/RlO/dA06EYh+4tTRlQ==
X-Gm-Gg: AZFdTZdWJY27RStLligKpO7FVkffHyIjIt8kY2m4K7dEnCzE+sUOux5hLQ/RhwEJEXI
 I3/2SS2Jx4xHxJZOimw1tfyMLVMVZIY5gXQZaaT9kfMVNDY5HhxIyukKCvupVZGRcsVTKV03nwQ
 0s5nhvS0nxP0Y55V69VJm6AvGfWxJ8hFgs6Di9tpJuYKG7T4RGW/niqwbrj/am1nDLFm8JSwQca
 AOcbOiSb0QD98bOjAROKnfg2I/cD+2dxrf3L5cNTo1xBY9Q5DmtL7DVwYAv1lBfVecpJBLMWSpa
 1K+9yNFiX4x1Gx2MIORF+GR5Q18ancN3ZiwqLQH1pSemqwueUOOY5LPaVVdYdV766GezyKDppuk
 cZHDgGtaJdWxKA/GcVAXdU9YYZkZs4lZnuyKY/7bV9Jc9mpGUbXa7RjwspCXeUSdevIHoxOkFag
 aCN3/8HhafpwEOOwmp8jNZ03dxgRqlZlvwMLby
X-Received: by 2002:a17:90b:568f:b0:3ab:b39f:41b9 with SMTP id
 98e67ed59e1d1-3b1b0b5000amr11114322a91.61.1794871316815; 
 Mon, 16 Nov 2026 15:21:56 -0800 (PST)
X-Received: by 2002:a17:90b:568f:b0:3ab:b39f:41b9 with SMTP id
 98e67ed59e1d1-3b1b0b5000amr11114303a91.61.1794871316282; 
 Mon, 16 Nov 2026 15:21:56 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3abe77179sm1059550a91.11.2026.11.16.15.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 15:21:55 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 1/2] tests/tcg/riscv64/system: remove exe_name as it's already
 the default one
Date: Mon, 16 Nov 2026 16:21:39 -0700
Message-ID: <20261116232140.2758664-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116232140.2758664-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261116232140.2758664-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfXyCbQhoeM4JNB
 aE6IvBZgiItjjGirmWUgS6d8sh0x7nzDPc/oFPQ1VFCyGdIfZfyM6M41Pt9kLlwDe2ZDaWQsM51
 glTeSWvYw3esYjjYrsmEss/t8BAxEA8=
X-Proofpoint-ORIG-GUID: BtfhaqHFm_79brHuHT7FK4Nt_Eyr-3Yw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX4ltFP+gl+YPx
 QTbqzaIx2o1gBsI5fyfxH1NrpuAirKDuthz6/r8BnltMgsTIqs3alN72B5C5KNIJsGtFIi178Sx
 LiC2tMIUbW7rsrDlDRlavPofVEXFbApZG3nlcaMQopWk1K8l3xa+0KfwuUO+azNWDHaG9iXCTYs
 0iFrWzuBaj2xMRaVCBB/yHaQVMVmXE1WIjJZaMyrMs3Z/CtilBxWTgr+7LiXMmCIKsXEO1z4tML
 fiPHPTs6IGIvPKu4VqMYcROrkgZW0g8FgO75h137ljAMqNYkYFHP25Qz8evLjeQ3Df7wpbO6MOz
 CW9Yte6CapylAFaPYXEVIybTUbxpsziam6sgKIsiZ0mBeFFKmS5IRY7cbQvVzZu6V90oLmKqH2B
 9UakypN5nJCKEzCBtsNnfM1mTiWYRH/OS2ieSTY68SSGVh8HRbCJQ6U2kJmJw1yCHaiyCIW/O9t
 SfcAeFpE++wq/b0Xv7g==
X-Proofpoint-GUID: BtfhaqHFm_79brHuHT7FK4Nt_Eyr-3Yw
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afb9016 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=V_hc6lPSFJMs_eCW-sAA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fixes: e723a1e16319 ("tests/tcg/riscv64: add sdext "not on Debug mode" sigill tests")
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/riscv64/system/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3c8b018d9e9..9edab1fd7ad 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -76,7 +76,6 @@ tests += {
 
 tests += {
   'test-sdext-sigill.S': {
-    'exe_name': 'test-sdext-sigill',
     'cflags': cflags + ['-march=rv64gcv'],
     'qemu_args': ['-cpu', 'rv64,sdtrig=true,sdext=true', qemu_args],
   }
-- 
2.47.3


