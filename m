Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD2EC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1coq-0000M3-Up; Wed, 02 Sep 2026 00:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1cop-0000LI-Nl
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1con-0000N8-Sx
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:27 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6823JMi01025979
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OLqX3lslZDdZkMrvqr4J8bRoj7IT+A5jFpR2gBcu18c=; b=D4IwyVUfEjOv/ufP
 vYwz1u0kA09roq8HPmZgxWfnOlpSYCHgDjNBdxJLmbuhzQDf7BQnOaf+pD+3WVla
 LgjDE+cfFhro4mpXOn9GJofWiCRYK6nL3ogxr5TU4OAyjNo+fgSiF0vJ36WhdbHa
 HzM3cqmwK5BCJy/rSeIXvsuBehqNVt5HLoff9PJfUEJ5wJnMoyvlWYdr/skK3f/P
 +jNoLOdTG1Wrpzh8Hh0DGbuho7b47L3EiD3gJgBjXAKi0zvVAbj8E3praVie+Jml
 y+m/D/w32La6td0V+baXNbImFbf/YNYaJ1UihtwH54FqJqdLeY/bT/GHO6kRnZMm
 t3H55Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gebsx08cb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:43:13 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ce7dfd33ffso8223385ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324193; x=1788928993; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OLqX3lslZDdZkMrvqr4J8bRoj7IT+A5jFpR2gBcu18c=;
 b=XLV1eragJjvpK7jSRyrQm1HJAnLoSbjygM8emt2e92+t3Nf/DGp9y4jED67Tg9KeMh
 aaPx0/RfUqqyfKVwmd2lQn3sjhB0ICcU17IhuBwVEwVG1r+kpolk0lTZF0mn182f3HJ5
 cV00b74f9NSs9hTxl9cL5GddJbvdhFlmZNqSxKsvddLrO6Y2e2A7VkAZhcPhv2yyi9uD
 gMA420vOL4fRidihMXYJUTtj/EcUvsYvO7vh5SA0BIRXI5ywZ/pKAno8XwK5REMlC7dx
 qN560LQryEl93PTXe0Qoj8Z0YkpmHxHl/ZAmSjoN0NCbkj9kxAQUwZfJyRfc8PevaZHF
 2DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324193; x=1788928993;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OLqX3lslZDdZkMrvqr4J8bRoj7IT+A5jFpR2gBcu18c=;
 b=a6NaJr4STakt3L0wSt/VcK5IIa2hM0C0R+531WbqkS5HENmxCuObMZ/AWz4max2Jud
 Nq3oscrkAxJDF7uZZRB007OOLq+Lw86dbayyMoJYkFSoHC7csqsrWlbUm9imzF2kgL3y
 YeLd/JfuR3QxKs7nvXusKtkpNOS4LNQLXh9iDXa1nGH7c6a9ytO2LRYjcQxtjd62KMHl
 xHI4NVPoUNs8d1gSla6Cq5fWDJI6MQsEHcPxsj/+tY/8I+ZwcP2Gs5AwSSfZ8eW8dVDK
 EXUSESqjm5+f7Ro9uAD5+IRXohWbtMaWNGeAjX5G7Z0tJUpPAB0mefji563s22VmBjMQ
 7r6Q==
X-Gm-Message-State: AFuF++nVBqPm/EXrdADmXkN+wy3nC1NqXhTrQVhK+9dlEae1HkKhs3zh
 Ku8DFBVWT0tcx9paesh+rwxyuJwk7mcBtvDbnA/rY2vt+IKMcn4ON0KF7k4dwFyzjSIb/nPWeVC
 i7cW0GcuRyYRPCZC5JycoFR5A0FfsHxK9/9puFkSGkaDDFXWkKuBRNYZSNZam/A6jYg==
X-Gm-Gg: AYBFou06l/9wLk17LBozFn5m11pmcWfLzn5Mj65dxb2MqErPy0Y1c/H/LwEGIVJu6nK
 ROP8tMGEudzyAAPKxyfrNRhE6F99lIukT5hhLdvq7CnjmFKXiArUse6U3xsfVqeYIDNJASOYg9y
 4pB3MCJqTnYfzcTd0tpj+URoIUoaJGrAigZTjTHECbTiSc7JujFCdWTu1l3ms7tm93bjC2KOzc6
 RxqRqJrkDpGAb7i5zGW0Xg2+9P4ybt9xmqXwwFnnCcVwX6tHuyxzb0eBuDNX4BAynCqYlFBijye
 l+9uZh/I3DkG0lr6ZMeLSf9ummAQa39DpPBYKxZ3xG+/e+rktcI6DNTFDOooXOdQhfQUT3J+eqj
 FLUztxm2J/2Sukb8YK0GVJxW6vzPHEA1eLT29RVKgqzhHC051
X-Received: by 2002:a17:903:3c66:b0:2d8:d4cc:be64 with SMTP id
 d9443c01a7336-2daec73208cmr35406945ad.17.1788324193111; 
 Tue, 01 Sep 2026 21:43:13 -0700 (PDT)
X-Received: by 2002:a17:903:3c66:b0:2d8:d4cc:be64 with SMTP id
 d9443c01a7336-2daec73208cmr35406545ad.17.1788324192602; 
 Tue, 01 Sep 2026 21:43:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:43:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 20/28] target/hexagon: read UTIMERLO/UTIMERHI from the global
 timer
Date: Tue,  1 Sep 2026 21:42:23 -0700
Message-Id: <20260902044231.843004-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: dkuUrFQ1EOw2nRgOl1IqO2AJylkaDOVV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfXwXq6goiToXhi
 NLVuRmvqCjY0M3g23I7G2Uru5zohuDNL/9jP38QEE2mYT40pn4vnjD+5ewrMbzXwrp9INbcMQYG
 VqL7IqrPb6gvUAcchBzP9zBWGyKgvOKEJ6QQAnTRbBEuY+wCHTT1hrV01yCugc10Q4pgU7EqXQB
 AWMN7OmbQRq279yNnJcOl6xja9dgAD2N72Xx0o6KyjKUtTYCYWR5WoDeGLMrWi7+rpQ2amjTsSm
 s32OU4Kn4+PxRAkHGdhiX1+bUWd2iG40hPkdTSyHBUuL6VOAM6BlNQc7/IeBB82p9qyxdcrPyWS
 euR3T4QaoSM1v0cRUJHl7KpWrcbQSviVrDhPQtzYXqwg/6VX1rX13GrFyXmCBJAKb/rVtXjqxy1
 t1UFb5wQyokmD2P7CvcTqm58NAuXQOKBD673WZbaI23ua8Y+BSEjSY0fh/7gwJx/YyI0HmLryeB
 53H8YNWv4UZTUbngHQA==
X-Proofpoint-GUID: dkuUrFQ1EOw2nRgOl1IqO2AJylkaDOVV
X-Authority-Analysis: v=2.4 cv=AufeGu9P c=1 sm=1 tr=0 ts=6a97a961 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=q_fxtLUCAn1J2UUIEkUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX94VbGJCixwhd
 y4evdpknRXYW8qFgLG5V1u/7qRPOcItrlm1OqSaK1qRIMDXQmffGhlpN4CDtIT4549UbJ2YRGxq
 FFB9n/8U4JxNes0JnRzOlSfOms9tZgQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SW4gc3lzdGVtIG1vZGUsIHJvdXRlIGFjY2Vzc2VzIHRvIHRoZSBxdGltZXItYmFja2VkIGdsb2Jh
bApUSU1FUkxPL1RJTUVSSEkgc28gZ3Vlc3QgcmVhZHMgc2VlIGEgbGl2ZSwgbW9ub3RvbmljYWxs
eSBpbmNyZWFzaW5nCnRpbWVyLgoKSW4gdXNlciBtb2RlIHdlIGRlcml2ZSBpdCBmcm9tIHRoZSBo
b3N0IG1vbm90b25pYyBjbG9jay4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVy
cmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4g
PGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9oZWxwZXIu
aCAgICAgfCAgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICAgfCAyOSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgIHwgMTkg
KysrKysrKysrKysrKysrKysrKwogdGVzdHMvdGNnL2hleGFnb24vcmVnX211dC5jIHwgMTEgKysr
KysrKystLS0KIDQgZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCBiL3RhcmdldC9oZXhhZ29u
L2hlbHBlci5oCmluZGV4IDc4ZGMyOGNhOWU1Li5lMzlhZmQ2MjNiNSAxMDA2NDQKLS0tIGEvdGFy
Z2V0L2hleGFnb24vaGVscGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgKQEAgLTEx
Myw2ICsxMTMsMTAgQEAgREVGX0hFTFBFUl9GTEFHU180KGd2ZWNfc2Fic2RpZmZfdywgVENHX0NB
TExfTk9fUldHLCB2b2lkLCBwdHIsIHB0ciwgcHRyLCBpMzIpCiBERUZfSEVMUEVSX0ZMQUdTXzQo
Z3ZlY191YWJzZGlmZl9iLCBUQ0dfQ0FMTF9OT19SV0csIHZvaWQsIHB0ciwgcHRyLCBwdHIsIGkz
MikKIERFRl9IRUxQRVJfRkxBR1NfNChndmVjX3VhYnNkaWZmX2gsIFRDR19DQUxMX05PX1JXRywg
dm9pZCwgcHRyLCBwdHIsIHB0ciwgaTMyKQogCisjaWYgZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZ
KQorREVGX0hFTFBFUl9GTEFHU18wKHV0aW1lciwgVENHX0NBTExfTk9fUldHLCBpNjQpCisjZW5k
aWYKKwogI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpCiBERUZfSEVMUEVSXzMocmFpc2Vf
c3RhY2tfb3ZlcmZsb3csIHZvaWQsIGVudiwgaTMyLCBpMzIpCiBERUZfSEVMUEVSXzIoc3dpLCB2
b2lkLCBlbnYsIGkzMikKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jIGIvdGFy
Z2V0L2hleGFnb24vZ2VucHRyLmMKaW5kZXggOTMzMDczMmM5OWIuLjFmMTA5ZDQ0ZGU4IDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYworKysgYi90YXJnZXQvaGV4YWdvbi9nZW5w
dHIuYwpAQCAtNDExLDYgKzQxMSwyMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZ2VuX3JlYWRfY3Ry
bF9yZWcoRGlzYXNDb250ZXh0ICpjdHgsIGNvbnN0IGludCByZWdfbnVtLAogICAgIH0gZWxzZSBp
ZiAocmVnX251bSA9PSBIRVhfUkVHX1FFTVVfSFZYX0NOVCkgewogICAgICAgICB0Y2dfZ2VuX2Fk
ZGlfdGwoZGVzdCwgaGV4X2dwcltIRVhfUkVHX1FFTVVfSFZYX0NOVF0sCiAgICAgICAgICAgICAg
ICAgICAgICAgICBjdHgtPm51bV9odnhfaW5zbnMpOworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZ
CisgICAgfSBlbHNlIGlmIChyZWdfbnVtID09IEhFWF9SRUdfVVRJTUVSTE8pIHsKKyAgICAgICAg
Z2VuX2hlbHBlcl9zcmVnX3JlYWQoZGVzdCwgdGNnX2VudiwKKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdGNnX2NvbnN0YW50X2kzMihIRVhfU1JFR19USU1FUkxPKSk7CisgICAgfSBlbHNl
IGlmIChyZWdfbnVtID09IEhFWF9SRUdfVVRJTUVSSEkpIHsKKyAgICAgICAgZ2VuX2hlbHBlcl9z
cmVnX3JlYWQoZGVzdCwgdGNnX2VudiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGNn
X2NvbnN0YW50X2kzMihIRVhfU1JFR19USU1FUkhJKSk7CisjZWxzZQorICAgIH0gZWxzZSBpZiAo
cmVnX251bSA9PSBIRVhfUkVHX1VUSU1FUkxPKSB7CisgICAgICAgIFRDR3ZfaTY0IHV0aW1lciA9
IHRjZ190ZW1wX25ld19pNjQoKTsKKyAgICAgICAgZ2VuX2hlbHBlcl91dGltZXIodXRpbWVyKTsK
KyAgICAgICAgdGNnX2dlbl9leHRybF9pNjRfaTMyKGRlc3QsIHV0aW1lcik7CisgICAgfSBlbHNl
IGlmIChyZWdfbnVtID09IEhFWF9SRUdfVVRJTUVSSEkpIHsKKyAgICAgICAgVENHdl9pNjQgdXRp
bWVyID0gdGNnX3RlbXBfbmV3X2k2NCgpOworICAgICAgICBnZW5faGVscGVyX3V0aW1lcih1dGlt
ZXIpOworICAgICAgICB0Y2dfZ2VuX2V4dHJoX2k2NF9pMzIoZGVzdCwgdXRpbWVyKTsKKyNlbmRp
ZgogICAgIH0gZWxzZSB7CiAgICAgICAgIHRjZ19nZW5fbW92X3RsKGRlc3QsIGhleF9ncHJbcmVn
X251bV0pOwogICAgIH0KQEAgLTQzOSw2ICs0NTYsMTggQEAgc3RhdGljIGlubGluZSB2b2lkIGdl
bl9yZWFkX2N0cmxfcmVnX3BhaXIoRGlzYXNDb250ZXh0ICpjdHgsIGNvbnN0IGludCByZWdfbnVt
LAogICAgICAgICB0Y2dfZ2VuX2FkZGlfdGwoaHZ4X2NudCwgaGV4X2dwcltIRVhfUkVHX1FFTVVf
SFZYX0NOVF0sCiAgICAgICAgICAgICAgICAgICAgICAgICBjdHgtPm51bV9odnhfaW5zbnMpOwog
ICAgICAgICB0Y2dfZ2VuX2NvbmNhdF9pMzJfaTY0KGRlc3QsIGh2eF9jbnQsIGhleF9ncHJbcmVn
X251bSArIDFdKTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIH0gZWxzZSBpZiAocmVn
X251bSA9PSBIRVhfUkVHX1VUSU1FUkxPKSB7CisgICAgICAgIFRDR3YgbG8gPSB0Y2dfdGVtcF9u
ZXcoKTsKKyAgICAgICAgVENHdiBoaSA9IHRjZ190ZW1wX25ldygpOworICAgICAgICBnZW5faGVs
cGVyX3NyZWdfcmVhZChsbywgdGNnX2VudiwgdGNnX2NvbnN0YW50X2kzMihIRVhfU1JFR19USU1F
UkxPKSk7CisgICAgICAgIGdlbl9oZWxwZXJfc3JlZ19yZWFkKGhpLCB0Y2dfZW52LCB0Y2dfY29u
c3RhbnRfaTMyKEhFWF9TUkVHX1RJTUVSSEkpKTsKKyAgICAgICAgdGNnX2dlbl9jb25jYXRfaTMy
X2k2NChkZXN0LCBsbywgaGkpOworI2Vsc2UKKyAgICB9IGVsc2UgaWYgKHJlZ19udW0gPT0gSEVY
X1JFR19VVElNRVJMTykgeworICAgICAgICAvKiBPbmUgaGVscGVyIGNhbGwsIHNvIHRoZSBwYWly
IGlzIGEgY29oZXJlbnQgNjQtYml0IHNuYXBzaG90LiAqLworICAgICAgICBnZW5faGVscGVyX3V0
aW1lcihkZXN0KTsKKyNlbmRpZgogICAgIH0gZWxzZSB7CiAgICAgICAgIHRjZ19nZW5fY29uY2F0
X2kzMl9pNjQoZGVzdCwKICAgICAgICAgICAgIGhleF9ncHJbcmVnX251bV0sCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
CmluZGV4IDJjZWExOTI3MjYzLi5mOWU2NmFjZjg0OCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTM3LDYg
KzM3LDkgQEAKICNpbmNsdWRlICJjcHVfaGVscGVyLmgiCiAjaW5jbHVkZSAidGNnL3RjZy1ndmVj
LWRlc2MuaCIKICNpbmNsdWRlICJ0cmFuc2xhdGUuaCIKKyNpZmRlZiBDT05GSUdfVVNFUl9PTkxZ
CisjaW5jbHVkZSAicWVtdS90aW1lci5oIgorI2VuZGlmCiAjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKICNpbmNsdWRlICJody9oZXhhZ29uL2hleGFnb25fZ2xvYmFscmVnLmgiCiAjaW5jbHVkZSAi
aGV4X21tdS5oIgpAQCAtNDYsNiArNDksMjIgQEAKICNpbmNsdWRlICJoZXhzd2kuaCIKICNlbmRp
ZgogCisjaWZkZWYgQ09ORklHX1VTRVJfT05MWQorLyoKKyAqIFVzZXIgbW9kZSBoYXMgbm8gcXRp
bWVyIGRldmljZSBiYWNraW5nIFRJTUVSTE8vVElNRVJISSwgc28gZGVyaXZlIHRoZQorICogdXNl
ciB0aW1lciBmcm9tIHRoZSBob3N0IG1vbm90b25pYyBjbG9jayBhdCB0aGUgcXRpbWVyJ3MgZGVm
YXVsdCAxOS4yTUh6CisgKiB0aWNrIHJhdGUsIG1hc2tlZCB0byB0aGUgcXRpbWVyJ3MgY291bnRl
ciB3aWR0aC4KKyAqLworI2RlZmluZSBIRVhfVVRJTUVSX0ZSRVFfSFogIDE5MjAwMDAwVUxMCisj
ZGVmaW5lIEhFWF9VVElNRVJfQ05UX01BU0sgMHgwMGZmZmZmZmZmZmZmZmZmVUxMCisKK3VpbnQ2
NF90IEhFTFBFUih1dGltZXIpKHZvaWQpCit7CisgICAgcmV0dXJuIG11bGRpdjY0KGdldF9jbG9j
aygpLCBIRVhfVVRJTUVSX0ZSRVFfSFosIE5BTk9TRUNPTkRTX1BFUl9TRUNPTkQpICYKKyAgICAg
ICAgICAgSEVYX1VUSU1FUl9DTlRfTUFTSzsKK30KKyNlbmRpZgorCiAjZGVmaW5lIFNGX0JJQVMg
ICAgICAgIDEyNwogI2RlZmluZSBTRl9NQU5UQklUUyAgICAyMwogCmRpZmYgLS1naXQgYS90ZXN0
cy90Y2cvaGV4YWdvbi9yZWdfbXV0LmMgYi90ZXN0cy90Y2cvaGV4YWdvbi9yZWdfbXV0LmMKaW5k
ZXggYzVhMzllNTUxMDAuLjljZTE4ZjNlYmU1IDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdv
bi9yZWdfbXV0LmMKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vcmVnX211dC5jCkBAIC03NywxMCAr
NzcsMTAgQEAgc3RhdGljIGlubGluZSB2b2lkIHdyaXRlX2NvbnRyb2xfcmVnaXN0ZXJzKHZvaWQp
CiAgICAgY2hlY2szMihyZXN1bHQsIDB4MDAwMDAwMDApOwogCiAgICAgV1JJVEVfUkVHX05PQ0xP
QkJFUihyZXN1bHQsICJ1dGltZXJsbyIsIDB4ZmZmZmZmZmYpOwotICAgIGNoZWNrMzIocmVzdWx0
LCAweDAwMDAwMDAwKTsKKyAgICBjaGVjazMyX25lKHJlc3VsdCwgMHhmZmZmZmZmZik7CiAKICAg
ICBXUklURV9SRUdfTk9DTE9CQkVSKHJlc3VsdCwgInV0aW1lcmhpIiwgMHhmZmZmZmZmZik7Ci0g
ICAgY2hlY2szMihyZXN1bHQsIDB4MDAwMDAwMDApOworICAgIGNoZWNrMzJfbmUocmVzdWx0LCAw
eGZmZmZmZmZmKTsKIAogICAgIC8qCiAgICAgICogUEMgaXMgc3BlY2lhbC4gIFNldHRpbmcgaXQg
dG8gdGhlc2UgdmFsdWVzCkBAIC0xMDYsOCArMTA2LDEzIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB3
cml0ZV9jb250cm9sX3JlZ2lzdGVyX3BhaXJzKHZvaWQpCiAgICAgV1JJVEVfUkVHX05PQ0xPQkJF
UihyZXN1bHQsICJjMTU6MTQiLCAweGZmZmZmZmZmZmZmZmZmZmYpOwogICAgIGNoZWNrNjQocmVz
dWx0LCAweDAwMDAwMDAwMDAwMDAwMDApOwogCisgICAgLyoKKyAgICAgKiBjMzE6MzAgaXMgVVRJ
TUVSSEk6VVRJTUVSTE8sIGEgcmVhZC1vbmx5IGZyZWUtcnVubmluZyBjb3VudGVyLiAgVGhlCisg
ICAgICogd3JpdGUgbXVzdCBiZSBkaXNjYXJkZWQ7IHRoZSByZWFkLWJhY2sgaXMgd2hhdGV2ZXIg
dGhlIHRpbWVyIHNheXMsCisgICAgICogc28gb25seSBjaGVjayB0aGF0IHRoZSB3cml0dGVuIHZh
bHVlIGRpZCBub3Qgc3RpY2suCisgICAgICovCiAgICAgV1JJVEVfUkVHX05PQ0xPQkJFUihyZXN1
bHQsICJjMzE6MzAiLCAweGZmZmZmZmZmZmZmZmZmZmYpOwotICAgIGNoZWNrNjQocmVzdWx0LCAw
eDAwMDAwMDAwMDAwMDAwMDApOworICAgIGNoZWNrNjRfbmUocmVzdWx0LCAweGZmZmZmZmZmZmZm
ZmZmZmYpOwogCiAgICAgV1JJVEVfUkVHX1BBSVJfRU5DT0RFRChyZXN1bHQsICJjOTo4IiwgKHVp
bnQ2NF90KSAweDAwMDAwMDAwMDAwMDAwMDAsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBD
OV84X0VRX1IxXzApOwotLSAKMi4zNC4xCgo=

