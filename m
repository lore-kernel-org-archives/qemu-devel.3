Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AF0606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SHc8Hlzt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OyOeYhki
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMxw2-0004yh-1J; Fri, 30 Oct 2026 21:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxvI-0004aD-Ui
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxvG-00033k-Vo
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69V1CWhG1337701
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UcHiswPaF6LbYg2tr0f+Hn2l9IXt4XEtCKz/0vzeLxk=; b=SHc8Hlzt4CeWmc1f
 zb9uuqc1mfYKGWkqGcpK0t5qz2ug0j29c81+9DWij/5Z8vxJ0++SaTKBGDC7OKNt
 FuzDJbPYiEFMd3i98riB2Nf7JpOjtX82+t+Vtg9m3wYKsJP3vlxip2Ekn7dX3zjJ
 TM1sfmKrJxEVixUWt1jaJL0FAQEWKqlNizw9WZwB9hLQcZhdqY+gb0E6Z9pJGJaP
 AzPyPU4DP0jcHxP4Ksx/bhlZSzF0TGVrgzU1E6WGA0fNRkfJpEIVgdZZUxI6yrVC
 TBtYJ3XzPc2qIwcJiFe2krTluVflZw+5iAxZJu0bm+1DjqPu67SEZiAIT8hNv5Y9
 J4WQ3A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x08n7s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so2460988eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793410217; x=1794015017; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UcHiswPaF6LbYg2tr0f+Hn2l9IXt4XEtCKz/0vzeLxk=;
 b=OyOeYhkiwf8Oq4vVCg10dn9m5MHEDuCMdI7lfa9KM8uf5FJMU5RJJj+eh2lKOL82w5
 oBvtKlZVRgG2Q8Z9IjzPmTGsWyVX3VGJCeUQUkqDydeWynC8tl1jsbRCEjL/AAblMAoK
 dmF7Z/NYjJIsrQjatrogIDyjAbgAjOQqsFDqIf07cT915YmHpHpzu0JUzQLqNnEkJvsS
 t3H5tKD1zMS+bgaEQPwOUHBMdr6oGjxcxcmCObalVvCN7ZO19/tkMjsnL9PeDwMJ4/xH
 Ns8ML+zi5KJgXubHSHKyFjEtGDHV8WPBrKYmVSlBFX/Kc+CBWinENKvMEc02i69FpAGP
 c/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793410217; x=1794015017;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UcHiswPaF6LbYg2tr0f+Hn2l9IXt4XEtCKz/0vzeLxk=;
 b=LeXZ3yEFGkSBPkDC7m5YdbP2PUWfLKNnKvp4gHBg2vEqAs2ZLbwXoYV7LnoYc9eJDo
 rrLwRk+94dHBWfAqQ5ErPa2vLdvRCSq/rhS5hCgXsKyYnhhoYMPXvyVNVSnXt/O78DBP
 qPllMj6wpHeNY72lxXlMlJJvADM5PIUvTwTn85FXpO5U/nVItEQfoBH2n4Izj3FD05ss
 I9hh7DNmVeVcgKhZDGHooZ5Gp+yHxrJGVydihzmUKSIDtOCKUROZjtkHhdcvgp05lsjI
 6myXw7Gpjc30L/mTBsxwmi5bm58iS3ZJ0AhdZkfNhpXaqQEd1lTwcBnZzfNPrn1FjYWv
 Ta+Q==
X-Gm-Message-State: AFq9FYIWNgZPCgVBjpEDaYD406MM4YZxAt7mexJcT4zTB06vpvhQthLp
 BIpNVAfauFaUe8l2PDbdxSLSAt30yD+ruVRfP2HJ14598jFiuqexLqfaj/ZrG1BxwnFXB5/oNh2
 +idphCuc4RbMwOk5ozkbzFhGHRxiKcicW5VrkYaznchLEl1+t87NxDazKMTlzai3Ibg==
X-Gm-Gg: AYBFou3MW7oWXOO8Uubuu+EXu+AGio48FgtWl+upWjogjRyPqp6/Nyz4gPf7zh+qFmX
 WQ6Kp6ceXYIZr4vPvp+9NbStFdaHIHUU/PV2gJpduQgf5r1fgiTi1POy6TmLs5fgPOkyeukwCDz
 /wEI0to8NlK9MGJVuVMzae+wAYEKLq+OIz3rkLP0IU7ntkWIY/RCXER0/4EXqYHNF5cnBSvXYxs
 hn+LBtQFbVNF+uqA9CrTB4Sby44OWVutqddes0cdL/fCzOvtYRUZ+waceooawhMs+ofgqsidMhj
 dRVCB1XpAh3DG00scDvFTUtk+PzCh1avWum9R8mPmhV6L/f4UWgU2hwW/+StzTqkpZJODa44y+V
 qoWIRam7XNi5aEIocGgNj/AynSW9bw8vp9ZUKWWGWL4Nmv/XCziQyCsAh8YhREtZhvVstVKKobN
 zcyNis0oDTDFeRo6p5zo9++Q==
X-Received: by 2002:a05:693c:65d3:b0:36a:a10:ab95 with SMTP id
 5a478bee46e88-36a423cd4admr6150923eec.29.1793410216784; 
 Fri, 30 Oct 2026 18:30:16 -0700 (PDT)
X-Received: by 2002:a05:693c:65d3:b0:36a:a10:ab95 with SMTP id
 5a478bee46e88-36a423cd4admr6150881eec.29.1793410216054; 
 Fri, 30 Oct 2026 18:30:16 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm12170472eec.20.2026.10.30.18.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 18:30:15 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 12/40] tests/functional/hexagon: update release assets to v0.3.1
Date: Fri, 30 Oct 2026 18:29:13 -0700
Message-Id: <20261031012941.339141-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
References: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 2nWCaKtbN6ckDRZuT1Rujf8TtKPMGrJO
X-Authority-Analysis: v=2.4 cv=Z6N5j3RA c=1 sm=1 tr=0 ts=6ae544aa cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=dgVQSAvUoH3QtQfB048A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX//SBN0BfM4Eb
 Sqm5mFq9+bjxVi54xai7ZgVCuLzi2mweXXsLRQFxA1ifRx3bbZs2BCGyWe5kmmqiFJqn7Aib6+F
 uv/Lx3kqpBfN5/TO5oHnps7p81XxOqi+FF5BecM4SkREqmKBdnbO7+Dy2hKinyy6fRwdbdU++0w
 HLxx6TOXb+ejwakvGDLAjS/w9EIcTlM77Jy4rrdlDXfAJE4o01t0T6HsvTEpXxSThM5RIlqLkTR
 d2lQxxDaYh54RXX/CDtlqMgmLufVgXdLxynGzhnP+jIKjSeVuYCXnBvGsK/12b/itlgeEnErauU
 1ljxS2qNa7X4xbxvNASof6unYoOZlEJwL6J5hXT3YRVbyz4yOaYkJf0zAuiOc3jzEaUcKPJwdkV
 OWWzJx1USDrXChtXEk/mZ1SXAwpXR3bO9CDjcSJyS5GT+StDMtxMRfruMP3BEWsEXzmUQLnYJPx
 biNowqYltBMM1LVADoA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX5NpqqE1nLBpP
 /WJ6gCJMdsm691H/3WkZYg6bW5XZJtOVAl3rIUx5iGauFhM9X8zk1cEv//NmjLyjEaQmK3DzTLK
 PBee3K2AGTFLN0StYe0xUqO2L3Qk09c=
X-Proofpoint-ORIG-GUID: 2nWCaKtbN6ckDRZuT1Rujf8TtKPMGrJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310005
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

TW92ZSB0aGUgYXJjaF90ZXN0c191YXJ0IGFuZCBzeXN0ZXN0c19zdGFuZGFsb25lIGFzc2V0cyBm
cm9tIHYwLjIuMTQsCmFuZCBhcmNoX3Rlc3RzX3NlbWlob3N0aW5nIGZyb20gdjAuMi45LCB0byB2
MC4zLjEuCgpUaGUgY2hhbmdlcyBhZGQgdGVzdCBidWdmaXhlcyBhbmQgYWRkaXRpb25hbCBjb3Zl
cmFnZToKCiAtIHRlc3RfZ3Vlc3RfbW9kZSBub3cgY292ZXJzIGRpcmVjdC10by1ndWVzdCBldmVu
dHMuCiAtIHRlc3RfcGFnZWNyb3NzX3RsYm1pc3N4IGNoZWNrcyBFTFIgb24gYSBwYWdlLXN0cmFk
ZGxpbmcgZmV0Y2guCiAtIHBlbmRfd2FrZV93YWl0IGFzc2VydHMgdGhlIHRocmVhZCBlbmFibGUg
bWFzayBhbmQgbm8gbG9uZ2VyIHRha2VzCiAgIGswbG9jayBpbiBpdHMgSVNSLCB3aGljaCBjYXVz
ZWQgaGFuZ3MuCiAtIGxvY2tfdmVyaWZ5IHNraXBwZWQgZm9yIG5vdzogYmVmb3JlIHYwLjIuMjIg
aXQgaGFkIGJ1Z3MgZXhwb3NlZCBieSBtdHRjZywKICAgYW5kIHYwLjMuMSBzdGlsbCBoYXMgaW52
YWxpZCBhc3NlcnRpb25zIGFib3V0IFNXSSBkZWxpdmVyeS4KIC0gdGVzdF9sMnZpYyBjb3ZlcnMg
VklEIHdyaXRlLCBpbnRlcnJ1cHQgZGVsaXZlcnkgYW5kIGNpYWQtbDJ2aWMgYWNrcy4KIC0gdGVz
dF9pbnRfc3RlZXJpbmcgZGlkbid0IGl0ZXJhdGUgZW5vdWdoIHdoZW4gd2FpdGluZyBhbmQgd291
bGQgZmFpbCBvbgogICBhIGhlYXZpbHkgbG9hZGVkIHN5c3RlbS4KIC0gVGhlIHN5c3Rlc3RzIHBh
Y2thZ2UgaXMgYnVpbHQgd2l0aCBTREsgNi43LjAuMC4KIC0gc3dpX3RvdWNoX21lbW9yeSBpcyBp
bnRyb2R1Y2VkIHRvIGNvdmVyIHNlbWlob3N0aW5nIGJ1ZmZlcgogICBhbGlnbm1lbnQvcGFnaW5n
LgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1
YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVh
bGNvbW0uY29tPgotLS0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAg
ICAgfCAgMSArCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5IHwg
MTAgKysrKysrLS0tLQogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkg
ICB8IDE0ICsrKysrKysrKysrLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyks
IDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21l
c29uLmJ1aWxkIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL21lc29uLmJ1aWxkCmluZGV4IDBm
ZDkwZTQ5MWEyLi5mMTc1ODRkNzUxYSAxMDA2NDQKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhh
Z29uL21lc29uLmJ1aWxkCisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWls
ZApAQCAtOCw2ICs4LDcgQEAgdGVzdHNfaGV4YWdvbl9zeXN0ZW1fdGhvcm91Z2ggPSBbCiBdCiAK
IHRlc3RfaGV4YWdvbl90aW1lb3V0cyA9IHsKKyAgJ2FyY2hfdGVzdHMnOiAxODAsCiAgICdxY29t
X2RzcF9maXJtd2FyZSc6IDI0MCwKICAgJ3N5c3Rlc3RzJzogMTgwLAogfQpkaWZmIC0tZ2l0IGEv
dGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weSBiL3Rlc3RzL2Z1bmN0
aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkKaW5kZXggMjhiZjJmMDJkMzkuLmE0Mzdl
NGQ0YWFjIDEwMDc1NQotLS0gYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rl
c3RzLnB5CisrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkK
QEAgLTIxLDEzICsyMSwxNSBAQCBjbGFzcyBBcmNoVGVzdHNVYXJ0KFFlbXVTeXN0ZW1UZXN0KToK
IAogICAgIEFTU0VUX1RBUkJBTEwgPSBBc3NldCgKICAgICAgICAgImh0dHBzOi8vZ2l0aHViLmNv
bS9xdWFsY29tbS9xZW11LWhleGFnb24tdGVzdGluZy9yZWxlYXNlcy8iCi0gICAgICAgICJkb3du
bG9hZC92MC4yLjE0L2FyY2hfdGVzdHNfdWFydC50YXIuZ3oiLAotICAgICAgICAiY2U5M2NiOTBi
OWQ3NTdjMTk0NmRmZThmZTZhYmNlYzgyOTJiMDhhNjY1NDZhYzUxYjJkZDQ4NjUwYjA1ZmE5MSIs
CisgICAgICAgICJkb3dubG9hZC92MC4zLjEvYXJjaF90ZXN0c191YXJ0LnRhci5neiIsCisgICAg
ICAgICIxYmFiYTU5YWQyOWMyNGEzZDM4MDQzY2M5ZjY4NDZmZCIKKyAgICAgICAgImZkM2Y4OGU4
YjY3NTAxYzEzNzIyOTE2YzZjNzQ0YzNjIiwKICAgICApCiAgICAgQVNTRVRfU0VNSUhPU1RJTkdf
VEFSQkFMTCA9IEFzc2V0KAogICAgICAgICAiaHR0cHM6Ly9naXRodWIuY29tL3F1YWxjb21tL3Fl
bXUtaGV4YWdvbi10ZXN0aW5nL3JlbGVhc2VzLyIKLSAgICAgICAgImRvd25sb2FkL3YwLjIuOS9h
cmNoX3Rlc3RzX3NlbWlob3N0aW5nLnRhci5neiIsCi0gICAgICAgICJmMGNlNzMxZGM4ZGMyYjg2
MTc5MmI4YmQ2MDgwOGNiNzE0ZmQxOTIyYzBkYzc5M2FmNjUwOTBjMGJhNTI1YmIwIiwKKyAgICAg
ICAgImRvd25sb2FkL3YwLjMuMS9hcmNoX3Rlc3RzX3NlbWlob3N0aW5nLnRhci5neiIsCisgICAg
ICAgICIzN2I0NjAxNDZlN2EyYTY4OThiYTY0NTRkZmVhN2UxYyIKKyAgICAgICAgIjY0MDUzYjMx
ZThlM2FjZjdjOTdlN2U4MjIwOWI2YmRhIiwKICAgICApCiAKICAgICBkZWYgcnVuX3VhcnRfdGVz
dChzZWxmLCB0ZXN0X25hbWU6IHN0ciwKZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4
YWdvbi90ZXN0X3N5c3Rlc3RzLnB5IGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lz
dGVzdHMucHkKaW5kZXggMWMxZDU0NDBiYjYuLmZiMWQyNDU0ZmQxIDEwMDc1NQotLS0gYS90ZXN0
cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weQorKysgYi90ZXN0cy9mdW5jdGlv
bmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weQpAQCAtMTMsNyArMTMsNyBAQAogCiBfVEFSQkFM
TF9CSU5fUEFUSCA9ICgKICAgICAic3lzdGVzdHNfc3RhbmRhbG9uZV9wYWNrYWdlIiwKLSAgICAi
U3RhbmRhbG9uZVN5c1Rlc3RzXzYuNC4wLjJfdjY4IiwKKyAgICAiU3RhbmRhbG9uZVN5c1Rlc3Rz
XzYuNy4wLjBfdjY4IiwKICAgICAiYmluIiwKICkKIApAQCAtMjEsOCArMjEsMTAgQEAgY2xhc3Mg
U3lzVGVzdHNTdGFuZGFsb25lVGVzdHMoUWVtdVN5c3RlbVRlc3QpOgogICAgIFNZU1RFU1RfVElN
RU9VVF9TRUMgPSAzMAogCiAgICAgQVNTRVRfVEFSQkFMTCA9IEFzc2V0KAotICAgICAgICAiaHR0
cHM6Ly9naXRodWIuY29tL3F1YWxjb21tL3FlbXUtaGV4YWdvbi10ZXN0aW5nL3JlbGVhc2VzL2Rv
d25sb2FkL3YwLjIuMTQvc3lzdGVzdHNfc3RhbmRhbG9uZS50YXIuZ3oiLAotICAgICAgICAiZjBj
NTM1ZDc0NjM4NDEyNjk1NDc1N2I2Y2U1NDQ1MmM1ZmU4MjYyNDYxOGM3OTg2MjQ5NWVlYzI0NzE4
YTZmZiIsCisgICAgICAgICJodHRwczovL2dpdGh1Yi5jb20vcXVhbGNvbW0vcWVtdS1oZXhhZ29u
LXRlc3RpbmcvcmVsZWFzZXMvIgorICAgICAgICAiZG93bmxvYWQvdjAuMy4xL3N5c3Rlc3RzX3N0
YW5kYWxvbmUudGFyLmd6IiwKKyAgICAgICAgIjQwMTYzZmE5NGQ2N2E2M2U1ZWY2NDVmYzgzNjgy
ZTRlIgorICAgICAgICAiYjU2ZTFkNzlhOTA2ODYxNDA1NWU3NGYzNWQ0Y2Y3MGQiLAogICAgICkK
IAogICAgIGRlZiBzZXRVcChzZWxmKToKQEAgLTkwLDYgKzkyLDEwIEBAIGRlZiB0ZXN0X2FjY2Vz
cyhzZWxmKToKICAgICBkZWYgdGVzdF9zZW1paG9zdChzZWxmKToKICAgICAgICAgc2VsZi5ydW5f
Y29uc29sZV9wYXR0ZXJuKCJzZW1paG9zdCIsICJQQVNTIiwgIi1hcHBlbmQiLCAiYXJnMSIsICJh
cmcyIikKIAorICAgIGRlZiB0ZXN0X3N3aV90b3VjaF9tZW1vcnkoc2VsZik6CisgICAgICAgICIi
IkEgc2VtaWhvc3RpbmcgcmVhZCByZXN0YXJ0cyBhZnRlciBhIGZhdWx0IG9uIGl0cyBzZWNvbmQg
cGFnZS4iIiIKKyAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJzd2lfdG91Y2hfbWVtb3J5IikK
KwogICAgIGRlZiB0ZXN0X2R0Z19pbnRlcnJ1cHQoc2VsZik6CiAgICAgICAgIHNlbGYucnVuX2V4
aXRfemVybygiZHRnX2ludGVycnVwdCIpCiAKQEAgLTEwOCw2ICsxMTQsOCBAQCBkZWYgdGVzdF9o
dnhfbXVsdGkoc2VsZik6CiAgICAgZGVmIHRlc3Rfc3RhbmRhbG9uZV92ZWMoc2VsZik6CiAgICAg
ICAgIHNlbGYucnVuX2V4aXRfemVybygic3RhbmRhbG9uZV92ZWMiKQogCisgICAgQHVuaXR0ZXN0
LnNraXAoImxvY2tfdmVyaWZ5IGhhcyB0aW1pbmcgZGVmZWN0cyBiZWZvcmUgdjAuMi4yMiAiCisg
ICAgICAgICAgICAgICAgICAgImFuZCBpbiB2MC4zLjEiKQogICAgIGRlZiB0ZXN0X2xvY2tfdmVy
aWZ5KHNlbGYpOgogICAgICAgICBzZWxmLnJ1bl9leGl0X3plcm8oImxvY2tfdmVyaWZ5IikKIAot
LSAKMi4zNC4xCgo=

