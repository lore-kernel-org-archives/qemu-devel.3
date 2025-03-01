Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D0FC282CD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 05:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toFNm-0002xc-5P; Sat, 01 Mar 2025 00:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNi-0002wU-W3
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:23 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1toFNh-00088M-80
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 00:27:22 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213KLkV027550
 for <qemu-devel@nongnu.org>; Sat, 1 Mar 2025 05:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2XulbkstmF3qIFlfigvxqGEKu4MWWQdO6526+iEnfAs=; b=CinO9YyxPqQEfOPQ
 RIiKt79scFDgNYuOkxjcSC7zZLco6uqRVSpkx6Abz1LICfbXXlD4JpaRrTuGJaYg
 N20t2mHyYW+jDtdN9VcQ/7VS2SmRW0kyXM1u54LgMVjeeJADhPCKfDJhNv/U92iO
 lmi8H5NNNaC7L/lDoci+t1nyLOuuOd6KBnvDyNIDISutAwzXCn++CXcwoLIXboKP
 9JS2pLDh8nAHkkS56OIvvkRLcZCn0WtvMGEqjLg/Yid0nQALaHFaF+6NVhyC5B4G
 i1LjD5X0YQlnVMCgev5uxacap2I6iiEGlsRehHhPg3g7VRuROmFUttNHN4vt4ELy
 1l2jpg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t89r63m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 01 Mar 2025 05:27:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fea8e4a655so8098955a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 21:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740806829; x=1741411629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2XulbkstmF3qIFlfigvxqGEKu4MWWQdO6526+iEnfAs=;
 b=mFAQqUtW4NtMIFOcgAR9oMh+Tn8x7zeVoqwy/GptjKGaITr8n0qaerp2y3u61mV88l
 NprlhAU9MK6y/Eq3dTOdUUZVb/KwBh2cFVB82zFC4r731/cRQ9R0hOFJoPebKTgUQwfF
 xOhgsinZhkPUHnmZ502s0CekhUaJS8kDboWB0d00uMhEzIkOmgGDOoj4U6qG2czPQLeS
 0V4JzZpHfb3WivcmIFvPixJgvoo+n4z9o9j8D2jk1hU1bOU73nV3gP6nsa7/08DG23ar
 Ysus2lZMaBuFYrGlCu8JKnk1gS+iF+wRsaBzWgJV/8hnRboQ4RNTX/nU+xQ8uXF9ekdh
 szQg==
X-Gm-Message-State: AOJu0YyNoVwbh8Ci7wxSQpmeAQSxUnk82yr6Jk9eSJhS8y5tj+PQOPP7
 +azed1UM3urEsPkgMlTSQ26KP+1FGiisqF0qsS9xBbJv9wOcxnwZAysi4uYiA+U5ajfs5+/7DXh
 J2RqsgPqQW4Vp+qGDAhHwa39e2SD0S88ApZBpwf9UJBl8906HavVpXlaqgEFXQQ==
X-Gm-Gg: ASbGncvg43WREAPhm+SlWUhKa6mAs6aAI0JV3f9LROTOKf0hUGl47nbMGMjO3rfEFGi
 U8sas3+BVzkTeDAoxukOnfLiLzy13VM/S4RijrB/PTbokZu5AQBBJJlfI6fyH8eJck77zahla29
 0XHbD3km1uykf/3c8WU0R0cq6Y27nd7RFc0qvdbGFzqmvTNxvft+fICuEnqmkXk1X50hIzX7Ck6
 Mh5rlGVKS3H8MoL68vc7Zyn6dsI0bxh74fRcFXWMv9nDLP+KF9u457s2OUyBy5se7TJiI9rB/2S
 YJXl8ehTgXcxS5MOpKKmxVesyC7QgH2BsQElom0phDiSyYPyDT58byP9kaosFM3N
X-Received: by 2002:a17:90b:2792:b0:2fa:137f:5c61 with SMTP id
 98e67ed59e1d1-2febab50e88mr12224117a91.12.1740806828713; 
 Fri, 28 Feb 2025 21:27:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt+7IYqIn2UHoUrOycxpVtlHm/hyRbMQQSEz8d7uB3u7fbiRh1dgHb8V5PVamcHakgXgXDkA==
X-Received: by 2002:a17:90b:2792:b0:2fa:137f:5c61 with SMTP id
 98e67ed59e1d1-2febab50e88mr12224087a91.12.1740806828391; 
 Fri, 28 Feb 2025 21:27:08 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe825bb346sm6930596a91.18.2025.02.28.21.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 21:27:08 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 16/38] target/hexagon: Add placeholder greg/sreg r/w helpers
Date: Fri, 28 Feb 2025 21:26:06 -0800
Message-Id: <20250301052628.1011210-17-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: nlTBYwdeMvgavxvE3PkGoRA1in9Ee4UF
X-Proofpoint-GUID: nlTBYwdeMvgavxvE3PkGoRA1in9Ee4UF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 mlxlogscore=562
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503010039
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
aGVscGVyLmggICAgfCAgOSArKysrKysrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwg
MzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA0
MyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVyLmggYi90
YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAppbmRleCBmOGJhYTU5OWM4Li5mZGRiZDk5YTE5IDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZWxw
ZXIuaApAQCAtMTA3LDMgKzEwNywxMiBAQCBERUZfSEVMUEVSXzQocHJvYmVfbm9zaHVmX2xvYWQs
IHZvaWQsIGVudiwgaTMyLCBpbnQsIGludCkKIERFRl9IRUxQRVJfMihwcm9iZV9wa3Rfc2NhbGFy
X3N0b3JlX3MwLCB2b2lkLCBlbnYsIGludCkKIERFRl9IRUxQRVJfMihwcm9iZV9odnhfc3RvcmVz
LCB2b2lkLCBlbnYsIGludCkKIERFRl9IRUxQRVJfMihwcm9iZV9wa3Rfc2NhbGFyX2h2eF9zdG9y
ZXMsIHZvaWQsIGVudiwgaW50KQorCisjaWYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkKK0RF
Rl9IRUxQRVJfMihzcmVnX3JlYWQsIGkzMiwgZW52LCBpMzIpCitERUZfSEVMUEVSXzIoc3JlZ19y
ZWFkX3BhaXIsIGk2NCwgZW52LCBpMzIpCitERUZfSEVMUEVSXzIoZ3JlZ19yZWFkLCBpMzIsIGVu
diwgaTMyKQorREVGX0hFTFBFUl8yKGdyZWdfcmVhZF9wYWlyLCBpNjQsIGVudiwgaTMyKQorREVG
X0hFTFBFUl8zKHNyZWdfd3JpdGUsIHZvaWQsIGVudiwgaTMyLCBpMzIpCitERUZfSEVMUEVSXzMo
c3JlZ193cml0ZV9wYWlyLCB2b2lkLCBlbnYsIGkzMiwgaTY0KQorI2VuZGlmCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
CmluZGV4IDRmZWVjMjMyOTguLmNjZDgwNjgzNmMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29u
L29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCkBAIC0xMzE1LDYg
KzEzMTUsNDAgQEAgdm9pZCBIRUxQRVIodndoaXN0MTI4cW0pKENQVUhleGFnb25TdGF0ZSAqZW52
LCBpbnQzMl90IHVpVikKICAgICB9CiB9CiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQordm9p
ZCBIRUxQRVIoc3JlZ193cml0ZSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZywg
dWludDMyX3QgdmFsKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKK3ZvaWQg
SEVMUEVSKHNyZWdfd3JpdGVfcGFpcikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJl
ZywgdWludDY0X3QgdmFsKQorCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwor
dWludDMyX3QgSEVMUEVSKHNyZWdfcmVhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90
IHJlZykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50NjRfdCBIRUxQ
RVIoc3JlZ19yZWFkX3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCit7
CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordWludDMyX3QgSEVMUEVSKGdyZWdf
cmVhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykKK3sKKyAgICBnX2Fzc2Vy
dF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50NjRfdCBIRUxQRVIoZ3JlZ19yZWFkX3BhaXIpKENQ
VUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCit7CisgICAgZ19hc3NlcnRfbm90X3Jl
YWNoZWQoKTsKK30KKyNlbmRpZgorCisKIC8qIFRoZXNlIG1hY3JvcyBjYW4gYmUgcmVmZXJlbmNl
ZCBpbiB0aGUgZ2VuZXJhdGVkIGhlbHBlciBmdW5jdGlvbnMgKi8KICNkZWZpbmUgd2FybiguLi4p
IC8qIE5vdGhpbmcgKi8KICNkZWZpbmUgZmF0YWwoLi4uKSBnX2Fzc2VydF9ub3RfcmVhY2hlZCgp
OwotLSAKMi4zNC4xCgo=

