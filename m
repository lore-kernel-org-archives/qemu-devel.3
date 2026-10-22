Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167F6606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JiJIadsQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hd/la1U7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK1mu-00054j-UM; Thu, 22 Oct 2026 19:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1mt-00054V-5Y
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:01:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1mr-000254-Ay
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:01:30 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMF2qw1487580
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N26oTeCSi2/a8zF+/sOaLdhOjr7TVk/pJ4SVAauOh9M=; b=JiJIadsQs1xzvNn4
 n1ztKaz7rGm1JcoDtbeIDvQdZLdkkNWIhW5RGybniDV3x5MI6OYf+NBWkqi3DQ6V
 W9Z7Uc1cVXig+D8iaZQ9awmDwbam1s6cf09dQ6pv/djIsD9jKzAMx7cX+e5mysz1
 2manKdmXOUKZOF5SKiyUVdy21b4oJWgyWzwHTUkH8fR67JiNft4JjO00n7698pm+
 JU9PuOnx69YjKZWYDFyeizm92/KuiRQk1DNrb743rDRjDautxrH5b3aN1zyRVuUA
 sltr+Hdjx3W9zE9vJWqVHp+qLH5ko+2GlsBcTK0dr16xxv3ztmLbhhOqaQ+OgDdF
 VXwlxQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmj8xy8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:01:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36637676140so495592eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 16:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792710087; x=1793314887; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N26oTeCSi2/a8zF+/sOaLdhOjr7TVk/pJ4SVAauOh9M=;
 b=hd/la1U7ZhQO6pdwDCase1aKda0Hxh/Rz+VTpWwavc2mBeILUClJojw3hvk/9uEUau
 zCLEFQ3hwSLQ9DyHmOwxebIo5paVBdlT8eUOys6h0fIluWefCwtgKKKyLrN2ZjCyqoW1
 ys8+1F6TxFIBJIpU9VEHPu5ZBz45PVwOZJ5cGJTC3NsnoC3pHP2p0EgUHTq5DWBtjjmf
 NJFhJ2ISXU9zKkT7r102fRdiUIqzRWZP5wOf2WYy5XpQld7ju0/MfOQbja46zqI+3Irz
 LOodr87YLsFSszExcREdD3hj6bk0arlFAIvB1P63uNeI1ojQV3hOinED7Ghr/nDCWf6t
 sMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792710087; x=1793314887;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N26oTeCSi2/a8zF+/sOaLdhOjr7TVk/pJ4SVAauOh9M=;
 b=l6jt3zOYsdB0+yXRkPERnKZso/0i9bHFdQQ29k+QsB5ziioqnP2Db9uVqlVRuxsgN1
 9gjPuhEMAH67u3qMtkrvMKZGGI0o0zw/4fCeBNYvVYMlPI1k66BdDsXEijfMF7kOHGf1
 ychoNUgfZjtgfZBz74BE9aIQWXBY4NaJerTspe0V3JAWyil0jsKLutxlMHlPznxrQ4VS
 gB1T6Ha/2/DWVlbEYWPgQJKjVS4aGzo9OZS2La045YTRs40R6od2kuWvH3kwTjUm/rlE
 ONDLnlvSKl+41vXQNqL7MEz6YEWCHzfGSWeTr7RtiKf7/j86MjBKLmEtz8zNo4mqsQI0
 L/vg==
X-Gm-Message-State: AFq9FYKMu6ye/xmHox9qLa+yFI+3lNc3UuGDFqo7QNB20w3iRpJAYmNw
 QUjvtJaVgp1cCx3XMSBjm7+56yuh6yugKi8bdmfvmA1hvpAuwDjOVe4FwedC316KSixVEoWttPY
 ceCoiVhlAQJDk3de9lq41I1DcuSlREZIiqYY3vGyRPeFiMocNBHiL3L3ZO9bE/AQ5fA==
X-Gm-Gg: AYBFou0MqmmyA7GqnbKzDv4ufMMP6YdrbYUOuWFRI5XCqLRITaoBIjvtmT8y5yNzD61
 XjaI6BgzLy2Eta2pZfMapjIm9YBfFzRUQ6UNpWUF3v2XY5kGKN3tad1/lfAXepaajHJo7ds0mTh
 QjMA6sGmp7Ziv0wj3UG+1zvGnQY0FQCKKNwNd9fo7/KRGrhIsp8qkOwDBLWvKgUq9oUWXn5aVUY
 HjnvwbTiHtn8yZ7EL/MQn2VInWw4ZyW1OFDq6PdscaHRFDYYgVTWYNxI4ZZLcgu9fbEiZjbmb7O
 s2UVPM4BtkhYL7gW01IsXV6EcJ/BDpUv7dUChKcph4IRsRCGcT+mOXMznwPI5sRgl1wS3b2O5M8
 Q2ztxy20JqpIMU0RWiO2hGk0nDdSKUG7/NRN5PX5gDNNMTNUU
X-Received: by 2002:a05:693c:894c:20b0:368:5750:9869 with SMTP id
 5a478bee46e88-369d96dd67bmr643118eec.8.1792710087021; 
 Thu, 22 Oct 2026 16:01:27 -0700 (PDT)
X-Received: by 2002:a05:693c:894c:20b0:368:5750:9869 with SMTP id
 5a478bee46e88-369d96dd67bmr643075eec.8.1792710086254; 
 Thu, 22 Oct 2026 16:01:26 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9c0e60dsm1088138eec.2.2026.10.22.16.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 16:01:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Anton Johansson <anjo@rev.ng>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 15/16] tests/functional/hexagon: boot DSP firmware
Date: Thu, 22 Oct 2026 16:00:47 -0700
Message-Id: <20261022230048.2160400-16-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
References: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: MJEoKFkIw-QBu72xUWKQGbW5MJd0MuVt
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6ada95c8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=FjKqm1ytYyOSSueK_-UA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfXzv5XZ4ERO+I/
 T0EUXEICLRdM5fHi9SQgUlr2vpa01TSCZ0qEbnCeJ/9znD9eQcddor9BdNwgTwQXQyUtcW5XTp7
 iMlkyQZ7B58fjtRLF2gtj9N1qkJHkio=
X-Proofpoint-ORIG-GUID: MJEoKFkIw-QBu72xUWKQGbW5MJd0MuVt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfX/zMWIEvQn87F
 AX0luATwpq2tlofKAQKFe3sb8FuTakxL52dE/PPEZfqTSSkC179v0gP2JE9pcB+IJqA6NpHezXI
 b3gymVmpO4MRo0IIPA8KW3CQa7LqC+8Yt5TRpjHRoJXgUEMLWYUBCBVVAczPwMxmzOQdJN08W5+
 TxxtXRjuTptkzKwEmVgz82jVcLQfl8YNw9badsF8ValktqrpW0UUQWwkV9FjijQdb6vA5HKrGy0
 60NqL8WGngJ36ta0e/mD1nW2MG3fLumbw+bMRp3U2HwqNmNXKZp0Q0uyCEWiQvGlhMLS/haEqJg
 3m8qAgzBuJtKPhS/FB5KWxiFQfgKeiAjXLn87aTo7u5DiIx4W/iPgtcJnT2jZoC/qM3sO1qz4hf
 Ucz0z3qRTl3hIo/J9Yic4y+K2ZHI/DbGu2JDpVMfl8vomtKgajomQdnt9b71usWfg5Bkfsl4kHM
 pqYqRwoybOEXrgHYULA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220091
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
Li4vaGV4YWdvbi90ZXN0X3Fjb21fZHNwX2Zpcm13YXJlLnB5ICAgICAgICAgfCA5NyArKysrKysr
KysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDk5IGluc2VydGlvbnMoKykKIGNyZWF0ZSBt
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
IDAwMDAwMDAwMDAwLi4wNTUyMmU2MGQ5ZgotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RzL2Z1bmN0
aW9uYWwvaGV4YWdvbi90ZXN0X3Fjb21fZHNwX2Zpcm13YXJlLnB5CkBAIC0wLDAgKzEsOTcgQEAK
KyMhL3Vzci9iaW4vZW52IHB5dGhvbjMKKyMKKyMgQm9vdCB0aGUgcHJvZHVjdGlvbiBEU1AgZmly
bXdhcmUgb24gdGhlIFF1YWxjb21tIERTUCBtYWNoaW5lcworIworIyBDb3B5cmlnaHQgKGMpIFF1
YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmllcy4KKyMKKyMg
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKworZnJvbSBxZW11X3Rl
c3QgaW1wb3J0IFFlbXVTeXN0ZW1UZXN0LCBBc3NldCwgc2tpcFVudHJ1c3RlZFRlc3QKK2Zyb20g
cWVtdV90ZXN0IGltcG9ydCB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4KKworCitjbGFzcyBRY29t
RHNwRmlybXdhcmVUZXN0KFFlbXVTeXN0ZW1UZXN0KToKKyAgICAiIiJCYXNlIGNsYXNzOiB0aGUg
ZmlybXdhcmUgaXMgdGhlIEVMRiB0aGF0IC1rZXJuZWwgc3RhcnRzIHJ1bm5pbmcuIiIiCisKKyAg
ICBNQUNISU5FID0gTm9uZQorICAgIEFTU0VUX0ZJUk1XQVJFID0gTm9uZQorICAgIE1JTEVTVE9O
RSA9ICdFbnRlcmluZyBtYWluKCkgLi4uJworCisgICAgZGVmIGJvb3RfZmlybXdhcmUoc2VsZik6
CisgICAgICAgIHNlbGYuc2V0X21hY2hpbmUoc2VsZi5NQUNISU5FKQorICAgICAgICBmaXJtd2Fy
ZSA9IHNlbGYuQVNTRVRfRklSTVdBUkUuZmV0Y2goKQorCisgICAgICAgIHNlbGYudm0uc2V0X2Nv
bnNvbGUoc2VtaWhvc3Rpbmc9VHJ1ZSkKKyAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWtlcm5l
bCcsIGZpcm13YXJlKQorICAgICAgICBzZWxmLnZtLmxhdW5jaCgpCisgICAgICAgIHdhaXRfZm9y
X2NvbnNvbGVfcGF0dGVybihzZWxmLCAnUVVSVCBrZXJuZWwgc3RhcnRlZCcsCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBmYWlsdXJlX21lc3NhZ2U9J0ZhdGFsIEVycm9yJykKKyAg
ICAgICAgd2FpdF9mb3JfY29uc29sZV9wYXR0ZXJuKHNlbGYsIHNlbGYuTUlMRVNUT05FLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmFpbHVyZV9tZXNzYWdlPSdGYXRhbCBFcnJv
cicpCisgICAgICAgIHNlbGYudm0ua2lsbCgpCisKKworQHNraXBVbnRydXN0ZWRUZXN0KCkKK2Ns
YXNzIFFjczY0OTBDZHNwRmlybXdhcmVUZXN0KFFjb21Ec3BGaXJtd2FyZVRlc3QpOgorICAgIE1B
Q0hJTkUgPSAncWNzNjQ5MC1jZHNwJworCisgICAgQVNTRVRfRklSTVdBUkUgPSBBc3NldCgKKyAg
ICAgICAgJ2h0dHBzOi8vZ2l0bGFiLmNvbS9rZXJuZWwtZmlybXdhcmUvbGludXgtZmlybXdhcmUv
LS9yYXcvJworICAgICAgICAnMjAyNjEwMTkvcWNvbS9xY202NDkwL2Nkc3AubWJuJywKKyAgICAg
ICAgJzQzZTljODllMTVlZTgyZGFmODMyMTRjYWUzNDAwNmE4NTE1ZmRkZjlkYjdmNjQ1ZjVlZmY0
YjhlM2M0ZWJiNjQnKQorCisgICAgZGVmIHRlc3RfcWNzNjQ5MF9jZHNwX2Zpcm13YXJlKHNlbGYp
OgorICAgICAgICBzZWxmLmJvb3RfZmlybXdhcmUoKQorCisKK0Bza2lwVW50cnVzdGVkVGVzdCgp
CitjbGFzcyBTYTg3NzVwQ2RzcEZpcm13YXJlVGVzdChRY29tRHNwRmlybXdhcmVUZXN0KToKKyAg
ICBNQUNISU5FID0gJ3NhODc3NXAtY2RzcCcKKyAgICBBU1NFVF9GSVJNV0FSRSA9IEFzc2V0KAor
ICAgICAgICAnaHR0cHM6Ly9naXRsYWIuY29tL2tlcm5lbC1maXJtd2FyZS9saW51eC1maXJtd2Fy
ZS8tL3Jhdy8nCisgICAgICAgICcyMDI2MTAxOS9xY29tL3NhODc3NXAvY2RzcDAubWJuJywKKyAg
ICAgICAgJzFkOWQ4Y2QxZTkxM2IwZDNiNDlhNzdiNGU5NjI1NjRhYjQ4MTE5M2U2YTU2OTdjOGYw
NjQwNmIzZmQ4NWE4ZmMnKQorCisgICAgZGVmIHRlc3Rfc2E4Nzc1cF9jZHNwX2Zpcm13YXJlKHNl
bGYpOgorICAgICAgICBzZWxmLmJvb3RfZmlybXdhcmUoKQorCisKK0Bza2lwVW50cnVzdGVkVGVz
dCgpCitjbGFzcyBTYzg0ODB4cE5zcDBGaXJtd2FyZVRlc3QoUWNvbURzcEZpcm13YXJlVGVzdCk6
CisgICAgTUFDSElORSA9ICdzYzg0ODB4cC1uc3AwJworICAgIEFTU0VUX0ZJUk1XQVJFID0gQXNz
ZXQoCisgICAgICAgICdodHRwczovL2dpdGxhYi5jb20va2VybmVsLWZpcm13YXJlL2xpbnV4LWZp
cm13YXJlLy0vcmF3LycKKyAgICAgICAgJzIwMjYxMDE5L3Fjb20vZ2x5bXVyL2Nkc3AubWJuJywK
KyAgICAgICAgJzdiMjJmMzNhZTI3M2QzZGZjNWY3NDFhOTY3ODMxZTdkNGZkNzlhZDE0MWU2YTFl
Y2VlMTc1MDllYWMyMDcxMDknKQorCisgICAgZGVmIHRlc3Rfc2M4NDgweHBfbnNwMF9maXJtd2Fy
ZShzZWxmKToKKyAgICAgICAgc2VsZi5ib290X2Zpcm13YXJlKCkKKworCitAc2tpcFVudHJ1c3Rl
ZFRlc3QoKQorY2xhc3MgU2E4Nzk3cE5zcDBGaXJtd2FyZVRlc3QoUWNvbURzcEZpcm13YXJlVGVz
dCk6CisgICAgTUFDSElORSA9ICdzYTg3OTdwLW5zcDAnCisgICAgQVNTRVRfRklSTVdBUkUgPSBB
c3NldCgKKyAgICAgICAgJ2h0dHBzOi8vZ2l0bGFiLmNvbS9rZXJuZWwtZmlybXdhcmUvbGludXgt
ZmlybXdhcmUvLS9yYXcvJworICAgICAgICAnMjAyNjEwMTkvcWNvbS9ub3JkL2Nkc3AubWJuJywK
KyAgICAgICAgJzQxMGU3Y2EzYjM0MGU4MDgzNWU0NjQ1NDVhMjE4ZDkzNzYzMTBhMDlmMjRiYzg3
ZGU0MGJjMjVmN2Y1ZTMyNDAnKQorCisgICAgZGVmIHRlc3Rfc2E4Nzk3cF9uc3AwX2Zpcm13YXJl
KHNlbGYpOgorICAgICAgICBzZWxmLmJvb3RfZmlybXdhcmUoKQorCisKK0Bza2lwVW50cnVzdGVk
VGVzdCgpCitjbGFzcyBTbTg5NzVOc3BGaXJtd2FyZVRlc3QoUWNvbURzcEZpcm13YXJlVGVzdCk6
CisgICAgTUFDSElORSA9ICdzbTg5NzUtbnNwJworICAgIE1JTEVTVE9ORSA9ICdRVVJUIHJvb3Qg
dGFzayBzdGFydGVkJworICAgIEFTU0VUX0ZJUk1XQVJFID0gQXNzZXQoCisgICAgICAgICdodHRw
czovL2dpdGxhYi5jb20va2VybmVsLWZpcm13YXJlL2xpbnV4LWZpcm13YXJlLy0vcmF3LycKKyAg
ICAgICAgJzIwMjYxMDE5L3Fjb20vaGF3aS9jZHNwLm1ibicsCisgICAgICAgICc3MzczOTUyNDEz
YzE0MWZjNjM2YWE5MzNhYjBjNzFlN2JlMWQxMGY1ZjdkZDM2YmU1Mzc0ODI3YjI1M2MzZGI1JykK
KworICAgIGRlZiB0ZXN0X3NtODk3NV9uc3BfZmlybXdhcmUoc2VsZik6CisgICAgICAgIHNlbGYu
Ym9vdF9maXJtd2FyZSgpCisKKworaWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoKKyAgICBRZW11
U3lzdGVtVGVzdC5tYWluKCkKLS0gCjIuMzQuMQoK

