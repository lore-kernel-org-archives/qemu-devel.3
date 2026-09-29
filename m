Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740F8C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 07:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBSSM-0003AB-H9; Tue, 29 Sep 2026 03:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSI-00039A-W4
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBSSH-0005qu-H8
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 03:40:50 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7TxND4098390
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XMVJiKk5nVI
 K/yjr4VSmTey3kJFzghUeAbC+v7VGikE=; b=Wcjgstc+J2hiDROlVGDU7cyINPZ
 LxmhTYau2VqVS+ZkTZRP8MqC1MKIBvTMvqBVnpJv9f/CJ2yjCM1SdWYz2/gVnyUe
 7x/ZsGb+SfL35bsYJcLsGuFmVP2cP9PPiKnrtkwAg0FXkjNwgzaEBxQs7kJ5072Q
 cyOVM7fjJ1sl3qRQrFsgKth2WstH8yYU8pghVfBFiXZSBzeYZF9QqFv+42dPMeY1
 8/coW2G40SgsXR9ft+ubsD7w7iJMeni/E5yU+OlxFyEeaMp4iN/6YPCsmi73Lz+B
 VKcvoOvogz+notubyzUjyXtMly/ihpsVhEPd17th3dGnkv/TeQdldWou4cA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h03ew19yx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:40:48 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34afa104860so865372eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790667648; x=1791272448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XMVJiKk5nVIK/yjr4VSmTey3kJFzghUeAbC+v7VGikE=;
 b=TvkZ/aRs5INPhe92QBSDJ8tCjLhCwWfsy3QG3JPzSi7d7aVZFBXtfD1oxZHmmsHgvx
 lMhHVj1+uTR5J5YCmZ/tNHf9uGPLCcda6sWQatFVBgKybwvWkhd/X9v9urvRo8sCCF7I
 Jc0PXFc0uyfp2riy7JlE3CAnGN8FN4lOUTHKsxNdj8zj+aJoOEKKHK5dC8v9Zw5qXnQB
 psJt9wYcsF2+dooZpPiRa/+/cmXgy3YF81Vw/+dDyLUEYmJtdTLZLpzT/1EAaMxHcyYu
 Vn2zg3Okm2u4ePhv/3H9RjrDv1ifqn6BNWvHlowf14sLpTdGrWug4PfS/9ol2TPaEK7z
 Q9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790667648; x=1791272448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XMVJiKk5nVIK/yjr4VSmTey3kJFzghUeAbC+v7VGikE=;
 b=oB1J8MqLc0fzGRqH9QpYlWkQrrT0Bg1K3UH6FjPisXHRIeLdqlAq6Z10AIq+SbsI6l
 uzs58bJSCwsYVe4NuJg+WeYPdB1AcaBTFuYkGm+KznoP+PUYomRynYzP//sBWYmtM60H
 0ytrNT1Mb7MdHwn9VkV36H0uBhNfpJFFkpkdKvh3v47Qg+Y+FJ83EZbdnn5ECjFNSeXM
 GnMMmPge6bPFBLM9oR8YninFLs1J7pD7zWJlcVOQvttYy+TlnA4CKGSJtaHVDk1AFaNX
 CCB40RC+8V46+kf7J+wc0Jd2rew4MJrWyO0kI/uFlZSXPpZr53StLi1Q/DjGVijZrLcc
 ftlQ==
X-Gm-Message-State: AFq9FYLqYyhDy0QSVZWXALtIEm138dE6W804LxujMcGtAXFk+0etOaua
 Hj10PhxGgaxLwR2yB5qUY5Bjr1dp6GVrzxQ18xEj+pZ7k8wW37MLOYn6nuB2F4aqMBbNTX96WGx
 fktzF7JwzCXJQZLR3T3xx2LR+S7klfK8YHoJduClNX6RkO7O8y9r4bpXQmWDQ6hN4zw==
X-Gm-Gg: AYBFou3DtK4HAWBOkFsWAj/UI02NCi+WVDL3dR3NAyT9mVyEJTqGn8RdL9siBiLRyAa
 /UmrIKKAi97nV3wN9KIUBVYZtkxAgjQsg8tNTUaz0d+prvT/M20TDgHzhkMwdrzULwVq9CtC665
 7OYvJNnnu+/vEYWvcLRTxix/k3ha5gqINqB89n8dlHa8rvbE5L0Z+JCIfbmi5OHKeOYzNGoLaWt
 VXRLEuTm1tp6vH19+8/oPe6JFYROBrTWJkfeDjcyRkfb3BO5yuX5RznYDz9KlScuMnbssLQ+cYq
 ZmfyJxT5wKOzvTwp26iwWXA9M9pFMkTD/ZgRZp+SkHQv/SoTRflaZOp3QfdIW3IDSoiGQJ5bOgI
 7iNsJ2Z979Nd4abS9NtxCSSY4hoKto5sHlsHOGKltR+K3XZhkEd1F3ubEuA==
X-Received: by 2002:a05:7300:7fa7:b0:341:fcbb:abfe with SMTP id
 5a478bee46e88-3427217a18emr17349675eec.26.1790667647633; 
 Tue, 29 Sep 2026 00:40:47 -0700 (PDT)
X-Received: by 2002:a05:7300:7fa7:b0:341:fcbb:abfe with SMTP id
 5a478bee46e88-3427217a18emr17349644eec.26.1790667647061; 
 Tue, 29 Sep 2026 00:40:47 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3444fd04d93sm14647822eec.12.2026.09.29.00.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:40:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 12/19] tests/tcg/mips/include/wrappers_mips64r6.h: add
 missing wrappers for and, nor, or, xor insn
Date: Tue, 29 Sep 2026 07:40:00 +0000
Message-ID: <20260929074007.118970-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX+6Tv9AX7vbsr
 5zoqrTXkgjUb3fz6Unv43IAouZn+z0ObvTvQo7lrEk9Z4Wghuf2oQ1/K36XsDFNqNx7YeESM6tw
 dmT0WinzQXR9DYN+5eMpaLtekz89cx4=
X-Authority-Analysis: v=2.4 cv=IIOXmQvG c=1 sm=1 tr=0 ts=6abb6b80 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=0C6ggQj9Uaz5FJV1fPYA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMCBTYWx0ZWRfX4hPMKLFENxUQ
 4Bt8qGVfwU+N6LzM4lvuhqnSCJc1SNR4fJlbZ8mr0za2gvFHusymbXQZSBcD90HeroUmiPNz2xI
 gI0awzchiYXY49TPPyFSelq3qvL0nKzz289HL5CBeiIZ7bwbVX2+cBlTuPylXSwrpSHNW3+AjtU
 M0SsjZVPSywiVOGXd9Gm4DrjBoRlA4fE8fu3pmfgM/mQN1QzUyguZxYuwn0pPqqz+SCewROhOf6
 mQoOVHd2rBMEJ+FDAsHQhjVUpWdvJXkq6LCEjfBBTFvBfZF6mli0VMvtMpYbgpDaX2S9dz3QVtf
 UDmQtThdT5vm6WqJ+LWrk4gzIy7dRu89UgW2wXJzzMH0zPdJAHnkRS3dHIaxVLpg+Vu2SokjIoJ
 Bm4tjB4+f/9tj9Q+lx5qIDQ6OGtlP8cXYkDPNBPRZ40MM6MV1DmfHGqIDk93dJlfA9f1Gv1Nkbt
 0EXMUhg+HgCISKpZRnQ==
X-Proofpoint-GUID: BHGWeDfdFO_ddAhChe5hVFoWqNfBRS5K
X-Proofpoint-ORIG-GUID: BHGWeDfdFO_ddAhChe5hVFoWqNfBRS5K
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
 tests/tcg/mips/include/wrappers_mips64r6.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/mips/include/wrappers_mips64r6.h b/tests/tcg/mips/include/wrappers_mips64r6.h
index 33d03de50b2..f078f534f05 100644
--- a/tests/tcg/mips/include/wrappers_mips64r6.h
+++ b/tests/tcg/mips/include/wrappers_mips64r6.h
@@ -47,7 +47,6 @@ DO_MIPS64R6__RD__RS(DCLZ, dclz)
 DO_MIPS64R6__RD__RS(BITSWAP, bitswap)
 DO_MIPS64R6__RD__RS(DBITSWAP, dbitswap)
 
-
 #define DO_MIPS64R6__RD__RS_RT(suffix, mnemonic)                       \
 static inline void do_mips64r6_##suffix(const void *input1,            \
                                         const void *input2,            \
@@ -80,6 +79,11 @@ DO_MIPS64R6__RD__RS_RT(DMUH, dmuh)
 DO_MIPS64R6__RD__RS_RT(DMULU, dmulu)
 DO_MIPS64R6__RD__RS_RT(DMUHU, dmuhu)
 
+DO_MIPS64R6__RD__RS_RT(AND, and)
+DO_MIPS64R6__RD__RS_RT(NOR, nor)
+DO_MIPS64R6__RD__RS_RT(OR, or)
+DO_MIPS64R6__RD__RS_RT(XOR, xor)
+
 
 #define DO_MIPS64R6__RT__RS_RT(suffix, mnemonic)                       \
 static inline void do_mips64r6_##suffix(const void *input1,            \
-- 
2.43.0


