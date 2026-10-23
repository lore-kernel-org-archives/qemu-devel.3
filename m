Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4834E606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FEo75hnp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kboOuVyM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4Sz-0006Zn-Ol; Thu, 22 Oct 2026 21:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Rg-00024j-2R
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Re-0006Of-1A
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:47 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1FAWP1336166
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bw2h6GyoClLyfLaWfnI3rOl5IwvTrM6vtRlM/bfR27E=; b=FEo75hnpgf5d+eAL
 jN6w/rbCoxrS8Ad5Nx3BHRWn0IpkhMKjfF+iNhIj3kfnrpALqNfAeshY4ECDihx7
 HoaL3+stAGFmcUm2yI4j8juyB5lbLVR0S5b9cXnrzBFhyxcyVaMeWzPn68y6jHq5
 kc38Cf8dUjb8hLH2avszF7SNK1Xz8grrqtWg+xLv2ahwMFnfeOgteb2ia996CkmJ
 /e38d++zPIr/F4+qzWD4qP3EPxoP1w9cnQ4mJvSxhWdUNYwVugvWYn8Tj3sXL6Bx
 6SAwFfALlfPJm5OcMcjrtdashJ1g36aSoC+dnQnjmQBW3kQe0PcgMYeDfG95cOqh
 o29vBQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyk8tjj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:34 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35cbea41088so562449eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720293; x=1793325093; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bw2h6GyoClLyfLaWfnI3rOl5IwvTrM6vtRlM/bfR27E=;
 b=kboOuVyMawCBNJ6GjrlRW1j4i0Kt1PtQDGFuZm7EENAGKzaf4UOLmoT7Hzwwq4X5uC
 VNJf6bmACTAJbVuPk9RNzNt+yCogZvAG+So+76Zt/z8rornpswYue4u4sY0gNy4sTAK4
 3HJb2qrbD36RDywr/syUSvHrVmSyUk5NUy69ZmipQxj8RLfXsDfuAAt69+/V8o8htfK0
 2aPAa3GzKvpgpLAVIgDa6nMi7BJZ7AaQAUyujPcRU0Uwvbc01MpAyNz8CM2uTx8XEqka
 z6pGAbYLgjvx1Fr9mdk7I+XToduQ5qRLMtC7Hk61PxPdcw/qZPa6JNNGxqGEjsIJyUV4
 /CgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720293; x=1793325093;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bw2h6GyoClLyfLaWfnI3rOl5IwvTrM6vtRlM/bfR27E=;
 b=fKx+UCaq5sAb122xAEOKFucbckOGcE4SwTgBIK2q07LZaJWRGJQvbVogmfOpz6sOqW
 D48E33V27KVB3Y4Ykj6VUnunTU01Xw2j8/x3kmDcH8x1t+megrR0dVkIDUqiB1PRLYAB
 aumQFXUkF+sf2IU+juo/JgLU7ygwlaZktLIvx8dgjAxQlo4Fh036ZcvS2arMeqWIp80/
 EFXH35msMEM55WHXifDCMsM9UF6qRUj8e9Pi95eu/gLXtLEj06GV+fa9VXevBcCq/S2l
 csH48xWfPh4e3ErNFgb39/WzFCXoDaHwIjqQauXvE+NYMpfoaysNpcrGjTlwISZXsgYh
 c1Kg==
X-Gm-Message-State: AFq9FYLu9kUDPTTSlIu4vlgv/UIjc6lhCmQUKf2hmX/IEjtQzmQlx2h9
 FCB0X1pXSsZPOLByE39heJa7e2adn4py9N4m91T3s4M/zTa7m3jzz4kMCnSmjMHwppbdt+93Xip
 CB0U2N8VJkMOzXTn3EOsv5RVb7VhNGLeqyeeQbpabmPrhsC6L+sqfm97JIiX/HCI2IA==
X-Gm-Gg: AYBFou0SDtRarn6MYeZcdLbNIZeLhGC6qc0EJCh1DCIxl/zFK0W8bU+vOPIDAfQkGef
 gDu9keBBw92Q14smEXaQ1TgW0EslBDELt+Qa5rSwoKEsxwkD4glc7PjPhd9P1dVWnqqmZgtadOl
 gQtDozWo3cWzA1ND2Y5D8ca3hyg39Tuuae6H+Z+iYjBnSdUpsEX0a2+CEuiBAZVSKCOWPo8zEuK
 UcxkZVCb6gA72ZNWtxAMLIxXUA1nHUgAls9b7Ht84asxoDY3DsUF4OkFzNw6vj/RKM1TeQiObZZ
 dtTnLUGr+t2IBvxIAhHKhzue4U0c+whYCM6hlBHCMiwTvlF7ohQeIn299D5e/jtDDS7zCpyv0hD
 ZnyuR1v73bmSRLBl1wvHlxByF3RlpROq2ZBEvr8KgZ3omU3np
X-Received: by 2002:a05:7300:e9d9:20b0:360:d4c5:7243 with SMTP id
 5a478bee46e88-369d97cba4fmr1184004eec.11.1792720293399; 
 Thu, 22 Oct 2026 18:51:33 -0700 (PDT)
X-Received: by 2002:a05:7300:e9d9:20b0:360:d4c5:7243 with SMTP id
 5a478bee46e88-369d97cba4fmr1183968eec.11.1792720292766; 
 Thu, 22 Oct 2026 18:51:32 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:51:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 30/43] tests/functional/hexagon: boot DSP firmware
Date: Thu, 22 Oct 2026 18:50:27 -0700
Message-Id: <20261023015040.2473105-31-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfXzmuEtrbOPgc+
 TlGwGTm+Gsp6vTeIbCo2n/bt3EPymcWQg3SATgoOy4M4tWcb0khqQuTHoaXyHQZvdQ3/0e1a3nG
 00q0stUflHJCnwKyOzWRdGamNJRNuQm6iSaQz2OK6b3pafJ6uGDETMr4PBpNKvuICmTtea5WBU6
 ZHnEwadJRixzh5/7rsjwKmPfdJsT2kDCBwKb7IKFJKwlo7nDFSFIEW4hwoXfG5NMdXJVuOAc+Hy
 K2xrxbMT2KmbIc48J7SfnxAXWLrh07CcSig6u6e45xf6oP1kGQw2BUsQAPi9CkfV4ksYfam/ARf
 1xmel+oMBeUClkDC/2SAzumGoUGVnr+mALfkHyo03wfnggLL8t8gpJHIAppbVYtTqQ4M8edvVzN
 GbwwG943oyCMzJCv8aecCP2fs+Atl0RxbMLYkChQwR97KtmoSAT7bLP3lnVkx+N6tut9N/EU6jw
 5AQNlucjC/A2VJhnM7Q==
X-Proofpoint-ORIG-GUID: FKvTVXZF9IXoTvxtjbyKxI-GSMU9Z_Td
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX1Cm9Y9woe0/n
 SjSkQ50A1ikhqLwFs5WcUtUFEbW6bi7qnosGwM2i3+pZAM63zh2EG1oh09AQT8AcmPKm8HLTmvL
 Df5sbp9W9/mXuzt0YB4fIXuJ9GE6Iw0=
X-Proofpoint-GUID: FKvTVXZF9IXoTvxtjbyKxI-GSMU9Z_Td
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adabda6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=FjKqm1ytYyOSSueK_-UA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230007
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RG93bmxvYWQgdGhlIGZpcm13YXJlIGFuZCBydW4gaXQgb24gdGhlIGNvcnJlc3BvbmRpbmcgRFNQ
IG1hY2hpbmUuCgpUaGUgaW1hZ2VzIGFyZSB0aGlyZC1wYXJ0eSBiaW5hcmllcywgc28gdGhlIHRl
c3RzIHJ1biBvbmx5IHdoZW4gdW50cnVzdGVkCmNvZGUgaXMgYWxsb3dlZC4KClJldmlld2VkLWJ5
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgfCAgMiArCiAu
Li4vaGV4YWdvbi90ZXN0X3Fjb21fZHNwX2Zpcm13YXJlLnB5ICAgICAgICAgfCA5MiArKysrKysr
KysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDk0IGluc2VydGlvbnMoKykKIGNyZWF0ZSBt
b2RlIDEwMDc1NSB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9xY29tX2RzcF9maXJtd2Fy
ZS5weQoKZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZCBi
L3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZAppbmRleCBlMTgyYmM5OGEwNi4u
MGZkOTBlNDkxYTIgMTAwNjQ0Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5i
dWlsZAorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQKQEAgLTIsMTAg
KzIsMTIgQEAKIAogdGVzdHNfaGV4YWdvbl9zeXN0ZW1fdGhvcm91Z2ggPSBbCiAgICdhcmNoX3Rl
c3RzJywKKyAgJ3Fjb21fZHNwX2Zpcm13YXJlJywKICAgJ3N5c3Rlc3RzJywKICAgJ21pbml2bScs
CiBdCiAKIHRlc3RfaGV4YWdvbl90aW1lb3V0cyA9IHsKKyAgJ3Fjb21fZHNwX2Zpcm13YXJlJzog
MjQwLAogICAnc3lzdGVzdHMnOiAxODAsCiB9CmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFs
L2hleGFnb24vdGVzdF9xY29tX2RzcF9maXJtd2FyZS5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4
YWdvbi90ZXN0X3Fjb21fZHNwX2Zpcm13YXJlLnB5Cm5ldyBmaWxlIG1vZGUgMTAwNzU1CmluZGV4
IDAwMDAwMDAwMDAwLi4zMWJlYWJjMjM3NAotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL2Z1bmN0
aW9uYWwvaGV4YWdvbi90ZXN0X3Fjb21fZHNwX2Zpcm13YXJlLnB5CkBAIC0wLDAgKzEsOTIgQEAK
KyMhL3Vzci9iaW4vZW52IHB5dGhvbjMKKyMKKyMgQm9vdCB0aGUgcHJvZHVjdGlvbiBEU1AgZmly
bXdhcmUgb24gdGhlIFF1YWxjb21tIERTUCBtYWNoaW5lcworIworIyBDb3B5cmlnaHQgKGMpIFF1
YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyMKKyMg
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKworZnJvbSBxZW11X3Rl
c3QgaW1wb3J0IFFlbXVTeXN0ZW1UZXN0LCBBc3NldCwgc2tpcFVudHJ1c3RlZFRlc3QKK2Zyb20g
cWVtdV90ZXN0IGltcG9ydCB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4KKworCitjbGFzcyBRY29t
RHNwRmlybXdhcmVUZXN0KFFlbXVTeXN0ZW1UZXN0KToKKyAgICAiIiJCYXNlIGNsYXNzOiB0aGUg
ZmlybXdhcmUgaXMgdGhlIEVMRiB0aGF0IC1rZXJuZWwgc3RhcnRzIHJ1bm5pbmcuIiIiCisKKyAg
ICBNQUNISU5FID0gTm9uZQorICAgIEFTU0VUID0gTm9uZQorICAgIE1JTEVTVE9ORSA9ICdFbnRl
cmluZyBtYWluKCkgLi4uJworCisgICAgZGVmIGJvb3RfZmlybXdhcmUoc2VsZik6CisgICAgICAg
IHNlbGYuc2V0X21hY2hpbmUoc2VsZi5NQUNISU5FKQorICAgICAgICBmaXJtd2FyZSA9IHNlbGYu
QVNTRVQuZmV0Y2goKQorCisgICAgICAgIHNlbGYudm0uc2V0X2NvbnNvbGUoc2VtaWhvc3Rpbmc9
VHJ1ZSkKKyAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWtlcm5lbCcsIGZpcm13YXJlKQorICAg
ICAgICBzZWxmLnZtLmxhdW5jaCgpCisgICAgICAgIHdhaXRfZm9yX2NvbnNvbGVfcGF0dGVybihz
ZWxmLCAnUVVSVCBrZXJuZWwgc3RhcnRlZCcsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBmYWlsdXJlX21lc3NhZ2U9J0ZhdGFsIEVycm9yJykKKyAgICAgICAgd2FpdF9mb3JfY29u
c29sZV9wYXR0ZXJuKHNlbGYsIHNlbGYuTUlMRVNUT05FLAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZmFpbHVyZV9tZXNzYWdlPSdGYXRhbCBFcnJvcicpCisgICAgICAgIHNlbGYu
dm0ua2lsbCgpCisKKworQHNraXBVbnRydXN0ZWRUZXN0KCkKK2NsYXNzIFFjczY0OTBDZHNwRmly
bXdhcmVUZXN0KFFjb21Ec3BGaXJtd2FyZVRlc3QpOgorICAgIE1BQ0hJTkUgPSAncWNzNjQ5MC1j
ZHNwJworCisgICAgQVNTRVQgPSBBc3NldCgnaHR0cHM6Ly9naXRsYWIuY29tL2tlcm5lbC1maXJt
d2FyZS9saW51eC1maXJtd2FyZS8tL3Jhdy8nCisgICAgICAgICAgICAgICAgICAnMjAyNjEwMTkv
cWNvbS9xY202NDkwL2Nkc3AubWJuJywKKyAgICAgICAgICAgICAgICAgICc0M2U5Yzg5ZTE1ZWU4
MmRhZjgzMjE0Y2FlMzQwMDZhODUxNWZkZGY5ZGI3ZjY0NWY1ZWZmNGI4ZTNjNGViYjY0JykKKwor
ICAgIGRlZiB0ZXN0X3FjczY0OTBfY2RzcF9maXJtd2FyZShzZWxmKToKKyAgICAgICAgc2VsZi5i
b290X2Zpcm13YXJlKCkKKworCitAc2tpcFVudHJ1c3RlZFRlc3QoKQorY2xhc3MgU2E4Nzc1cENk
c3BGaXJtd2FyZVRlc3QoUWNvbURzcEZpcm13YXJlVGVzdCk6CisgICAgTUFDSElORSA9ICdzYTg3
NzVwLWNkc3AnCisgICAgQVNTRVQgPSBBc3NldCgnaHR0cHM6Ly9naXRsYWIuY29tL2tlcm5lbC1m
aXJtd2FyZS9saW51eC1maXJtd2FyZS8tL3Jhdy8nCisgICAgICAgICAgICAgICAgICAnMjAyNjEw
MTkvcWNvbS9zYTg3NzVwL2Nkc3AwLm1ibicsCisgICAgICAgICAgICAgICAgICAnMWQ5ZDhjZDFl
OTEzYjBkM2I0OWE3N2I0ZTk2MjU2NGFiNDgxMTkzZTZhNTY5N2M4ZjA2NDA2YjNmZDg1YThmYycp
CisKKyAgICBkZWYgdGVzdF9zYTg3NzVwX2Nkc3BfZmlybXdhcmUoc2VsZik6CisgICAgICAgIHNl
bGYuYm9vdF9maXJtd2FyZSgpCisKKworQHNraXBVbnRydXN0ZWRUZXN0KCkKK2NsYXNzIFNjODQ4
MHhwTnNwMEZpcm13YXJlVGVzdChRY29tRHNwRmlybXdhcmVUZXN0KToKKyAgICBNQUNISU5FID0g
J3NjODQ4MHhwLW5zcDAnCisgICAgQVNTRVQgPSBBc3NldCgnaHR0cHM6Ly9naXRsYWIuY29tL2tl
cm5lbC1maXJtd2FyZS9saW51eC1maXJtd2FyZS8tL3Jhdy8nCisgICAgICAgICAgICAgICAgICAn
MjAyNjEwMTkvcWNvbS9nbHltdXIvY2RzcC5tYm4nLAorICAgICAgICAgICAgICAgICAgJzdiMjJm
MzNhZTI3M2QzZGZjNWY3NDFhOTY3ODMxZTdkNGZkNzlhZDE0MWU2YTFlY2VlMTc1MDllYWMyMDcx
MDknKQorCisgICAgZGVmIHRlc3Rfc2M4NDgweHBfbnNwMF9maXJtd2FyZShzZWxmKToKKyAgICAg
ICAgc2VsZi5ib290X2Zpcm13YXJlKCkKKworCitAc2tpcFVudHJ1c3RlZFRlc3QoKQorY2xhc3Mg
U2E4Nzk3cE5zcDBGaXJtd2FyZVRlc3QoUWNvbURzcEZpcm13YXJlVGVzdCk6CisgICAgTUFDSElO
RSA9ICdzYTg3OTdwLW5zcDAnCisgICAgQVNTRVQgPSBBc3NldCgnaHR0cHM6Ly9naXRsYWIuY29t
L2tlcm5lbC1maXJtd2FyZS9saW51eC1maXJtd2FyZS8tL3Jhdy8nCisgICAgICAgICAgICAgICAg
ICAnMjAyNjEwMTkvcWNvbS9ub3JkL2Nkc3AubWJuJywKKyAgICAgICAgICAgICAgICAgICc0MTBl
N2NhM2IzNDBlODA4MzVlNDY0NTQ1YTIxOGQ5Mzc2MzEwYTA5ZjI0YmM4N2RlNDBiYzI1ZjdmNWUz
MjQwJykKKworICAgIGRlZiB0ZXN0X3NhODc5N3BfbnNwMF9maXJtd2FyZShzZWxmKToKKyAgICAg
ICAgc2VsZi5ib290X2Zpcm13YXJlKCkKKworCitAc2tpcFVudHJ1c3RlZFRlc3QoKQorY2xhc3Mg
U204OTc1TnNwRmlybXdhcmVUZXN0KFFjb21Ec3BGaXJtd2FyZVRlc3QpOgorICAgIE1BQ0hJTkUg
PSAnc204OTc1LW5zcCcKKyAgICBNSUxFU1RPTkUgPSAnUVVSVCByb290IHRhc2sgc3RhcnRlZCcK
KyAgICBBU1NFVCA9IEFzc2V0KCdodHRwczovL2dpdGxhYi5jb20va2VybmVsLWZpcm13YXJlL2xp
bnV4LWZpcm13YXJlLy0vcmF3LycKKyAgICAgICAgICAgICAgICAgICcyMDI2MTAxOS9xY29tL2hh
d2kvY2RzcC5tYm4nLAorICAgICAgICAgICAgICAgICAgJzczNzM5NTI0MTNjMTQxZmM2MzZhYTkz
M2FiMGM3MWU3YmUxZDEwZjVmN2RkMzZiZTUzNzQ4MjdiMjUzYzNkYjUnKQorCisgICAgZGVmIHRl
c3Rfc204OTc1X25zcF9maXJtd2FyZShzZWxmKToKKyAgICAgICAgc2VsZi5ib290X2Zpcm13YXJl
KCkKKworCitpZiBfX25hbWVfXyA9PSAnX19tYWluX18nOgorICAgIFFlbXVTeXN0ZW1UZXN0Lm1h
aW4oKQotLSAKMi4zNC4xCgo=

