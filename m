Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFD7CA5FD9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCJnN-00056s-Bh; Thu, 01 Oct 2026 12:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCJnL-00056U-Tk
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:38:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCJnK-0001yz-Bd
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:38:07 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsqX52268204
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 16:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1Zvn+RmAjEU
 tz/5eH6BzMcDPuaQpPavSQmGyu66v+ug=; b=krBmfs1hR7h3S5JeFnSYewBUf/d
 UsrmaXEoOiLCzqXMylWfM0/3mtbSsxNvt21v2Qwgpl3jQdVo61xPwSE4M5ywRCzR
 GSY5qG4yXojBGjfpqm43lorPpLEdJOlf0zDxKf5aPcns2zMDOcQwNvEP/gk6ClpG
 mEGJf1Pwi+oBJG7JKUX3Q4q83KeCP1gTKWtUQhUsJN4Z+2jvzREP0LPXdyHVNerj
 dEugqgJe3oO5EPfDq3lMFWR7i0C5U1akaRvFOp8mFn4tJHyxnssl7hft2Ne1TOTj
 VSVRA/2M5mb5eJ6rE4ctw+5ug/e2jPPmZYt1sCJxYYTJ8cuAT9jN/Xi2jvg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1rvq8t2a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 16:38:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34afa104860so4352011eec.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790872683; x=1791477483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1Zvn+RmAjEUtz/5eH6BzMcDPuaQpPavSQmGyu66v+ug=;
 b=eCubqf3drgwWhTAVHwLVF0gexn5bHZlRxAY69G/dyGYFAv6N8CVabFNpC75QLHNx3G
 53S9bf7yl0xZmimdGmQhRjc6PVIMFmV4oeAqOIrcyd3e7sVuXY2hW5fkM5z3ZjroqXq/
 EI0F84FotIoAn0ZJE6bIeuW/NEATzg0tE3MO4NELnluNjMggCk65BlO2bTYoGjD4GNTy
 Ikd/ZWjVuWtlzWlVB5+G5KBfeb1UaBknRbgaToWuPykLjK3+Y7LwVQHVlsvM0IdEdTR1
 Tzrzd2Rm08qGZ6PD8yvDM8PYGX+a0P5BqtTG1neOuXJttAhOqcJkD9x4BBTv9/85H9C8
 ujTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790872683; x=1791477483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1Zvn+RmAjEUtz/5eH6BzMcDPuaQpPavSQmGyu66v+ug=;
 b=qe5hyTACxdV04hFPICWNOQS21liUVPAneDhY8AWxrzllpYOVjdVT4W8tUlSOSxcesm
 pn0shwljXurhFueNZp6ZccznxN2OnA1C9FjNMkY+ruo/w9gXp9SB596LRl97QecIc/o7
 N8vBUjleM4JOuigxXYJ/SIBjL5AaP+Tvq2x8mBhs/WbrzUpRMDRtGaW97+Aij0Ka5e8z
 x3Skl9gFJtLvm2RGSvkkNnJXWkvu2SWhgrBVw3hu1nCIw+O0nbCJNITwF8YIiAsAkt2W
 8Q2m6HMrC+zlzbTMe3Z7hemnO1r5lshBqY/eGyMWXtBlWCr/vhNDmPKsV8CAZSWF/YEK
 sVvw==
X-Gm-Message-State: AFuF++l5Xx/J651kK7yFVkK3XOvL/hIobwzh8zCsESliwUC508j2iUTJ
 C43jstWOL/J/9CEQrZf+XVud7thc0yODCkBkRqofGNRfd8FRVA48avG8vmzPufhifkeDVvtq6bc
 5RGKOSgyL9lF0W+OehZEvWGxICW//z5j7B4D2R9oxFmk8WXoul740BVIguTgCsPNweA==
X-Gm-Gg: AYBFou3pdVChlyRtfqOqPDRw3+S8AkQeB6iIu5FDGIx2J5wA+w7Gm1SpOMC7ZjHxttr
 irLFXfv9QhNX9tJpFJSc6VJSJnwHC6e6ebGIPmQ9xPYwUEVBvBrkeSYqa9w8vF015wIkIJLIlCV
 4gYMM4HTBqp0KujPSAWGjQ78cRDERqlB+pUaMo/6XSHOl6hu9odQlY+UVg11GRAB8Yh+YAcPWYy
 psN3KqikQOy8ZGzwRNz8apVPT2jxaPbkcz4mk+yz0f/2zwtoqfVRumQ6PMoCJMMzhvuC4r/Ai+k
 ZAy+o4c3bmrWTZlxdWs+8cQpEqaexyGongtPlLEIfi8snmOjEutKKQCDTuN/ydWS2v+Z7SM8iTf
 QbtVeJxw7S2I3dr/qJg4uvTGBKrMYIhkos9wteVBrbOPRx+Ne2midrmIwaNLA
X-Received: by 2002:a05:7022:424:b0:148:80d4:84ac with SMTP id
 a92af1059eb24-14d331aae41mr7241587c88.29.1790872682509; 
 Thu, 01 Oct 2026 09:38:02 -0700 (PDT)
X-Received: by 2002:a05:7022:424:b0:148:80d4:84ac with SMTP id
 a92af1059eb24-14d331aae41mr7241245c88.29.1790872678551; 
 Thu, 01 Oct 2026 09:37:58 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f26bb14cbsm389846c88.7.2026.10.01.09.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 09:37:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Dominic P <gcc@gcc.dp11.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/3] tests/tcg/multiarch: add missing vma-pthread test
Date: Thu,  1 Oct 2026 16:37:49 +0000
Message-ID: <20261001163751.172720-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001163751.172720-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001163751.172720-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2NiBTYWx0ZWRfX495n9dV4fxvh
 gvFWI1Oe6ngS1h2l6cm/P8L6QcSI9xglchyvJ5/gwGGu2p5FktDJnfX3PgxBkcGEuIumS8/oQvU
 lWFYwYn2Nxo9nTZmnddY0FEkuuV3yomxdtfANSkQrGVmqevEvWLHAsurPGMASaKPKhvhD9UFHLh
 BVqnpT8wCpOjzA6o6qu3a5B6B7RYwvtdpx8G/y+xTKdRuUXryUZ8QyHOhmmVIGMsABCaRk0bmsk
 f8Kol3X4yqfgt3gZGLL5jh5GBF7rOz89q3mKbOZAfIGgRiASe8IIHq+rs8MWFaVpuyi/5BycB2u
 Rj1chTnADnvqWn1vvIdNW/Kaibmw3f8S74/WJgAl9MHzvy+7HUbqVAiQatKjcXdnttcaVm5UNZQ
 af+NOcZBv7qWlHuCzn86xkbI5BqekiM5VjVB0ufX+M5ZNp5Pdg+nEW/H3deREaWVU3U6RiDtAst
 n6UH1MUuKyseKtM1UEw==
X-Authority-Analysis: v=2.4 cv=JIauIMKb c=1 sm=1 tr=0 ts=6abe8c6b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=7XvPPADXJ9JnL5iyw08A:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: M65F0Xv8Bxus2ACss9LOzB9lkWEVVmQn
X-Proofpoint-ORIG-GUID: M65F0Xv8Bxus2ACss9LOzB9lkWEVVmQn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2NiBTYWx0ZWRfX1Zhw7xpFna5O
 j6YX0vUD8vXHFFF/spWT3sy689sRDknHjyAUc6qYKsLm9QsCTDNx0vjADWm0PSwixiFuWUAz7mO
 1tjHuGRc2lb/14qA3/btaabTNPLSkUo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010066
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meson.build
index c3816d3a218..e60a0527007 100644
--- a/tests/tcg/multiarch/meson.build
+++ b/tests/tcg/multiarch/meson.build
@@ -51,6 +51,7 @@ tests += {
   multiarch/'test-xpage-chain.c': {'cflags': ['-lpthread']},
   multiarch/'testthread.c': {'cflags': ['-lpthread']},
   multiarch/'threadcount.c': {'cflags': ['-lpthread']},
+  multiarch/'vma-pthread.c': {'cflags': ['-lpthread']},
 }
 
 # Linux tests
-- 
2.43.0


