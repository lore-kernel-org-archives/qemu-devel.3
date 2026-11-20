Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E868606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 03:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jkh9ufx4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dJo9Xy7s
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUFhM-0007qB-Ip; Thu, 19 Nov 2026 22:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUFhK-0007pu-Vy
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:54:03 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xUFhI-0000Sm-VO
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:54:02 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK3V4NH204659
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=AzGGEQ7Rn7wxLTW0F/AXyG
 RNEMbHlOMNSB/atu9BoJU=; b=Jkh9ufx48Hi8NNPBYxEZYd4PhHaCMwW4yL2g+p
 bJ+kLcR9FeS86RBwRp28pAvgkfEYRZUaILIR2V9HsLIZa1y0xhI+loRUacTVTsKV
 voba6H//jGDV6ekrHYMrzz2F1GAOsBAS90pH1Vfuy3/29qPaPTLLJPhPc7StCIQP
 Db31S/9zMsc8/98JOtnC36RrCEVBYvX3iCNS5RL8raAmUDTD5pbJ6XChjG9owd8d
 FoGZb8ocQ+/Xcju+O8kidrHm9UXNj3tve2us0FZi2YrUOdvTHu6AVWdkfh5vGeHk
 4m3XcKVg5mgJdFM2nnX9RyUs++FrHeDUXUy3TXvQFamcNVqw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5sqdq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:53:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-370230d93efso1458527eec.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 19:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795146838; x=1795751638; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AzGGEQ7Rn7wxLTW0F/AXyGRNEMbHlOMNSB/atu9BoJU=;
 b=dJo9Xy7sOJ4M81IQModo8lYr/8DDI4KV5ncwUjqqjY6BkSNeACVYN1HQzwCtLwwGBZ
 yKxMjPOV2BCqN8vuAScwK8jFuvclZ4xRuPWPBBsCuy/RN82yrV37s/86PE7MN5FxLRWt
 iVZVWsqUff5nTpP+uTukLS/VCOc5bnCHZB/s3fymcTKS/DAqf4066BSkuPrKOojXufmv
 08lKiZyey56ZxyR4Jdqt/6d8Y1NGCIrv83Vk0i61ULHACT7aI84itKjGKdkAGI9LrHMp
 jpXnyS7/KdTwiVeNeXs8X6fenhOsKznk27vUrJrFfqrTZVZoQZLAUKc7qgqQ7VNvltDB
 mLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795146838; x=1795751638;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AzGGEQ7Rn7wxLTW0F/AXyGRNEMbHlOMNSB/atu9BoJU=;
 b=ti5cX+9lySnoNq+c5+jy7M4rEjKp5Q5lhxAnKEl/W0sz+ODi/FgWNwtnwu81eLtNAa
 6G7QJqhuDw2fKBPBIXw9fk0P+zmsIRl1q65cPlP5Nh6/o8YFNfi9YFF7wYPde3E4TYpw
 LUMvLffbny3t3fQKW+ydatWSGduCAP3dEW2UTGzioZnXraq1FY2hB+7v9U6k0nUzyvPt
 +RzxNX5r3BNR3j149QzA8mQZUznFdx3ZgQV7alliwyqZPhpO6S1dT40auxteXpeEKPUP
 EF46JuzwvZIhdrv6ezh7xG09eJf/j32FbdWDavf1X6VAMJvZqOdTVYFWFwVD/SXowC7M
 Vc6w==
X-Gm-Message-State: APuU4Z8QJZmEBop7dYo9HICbZn37FwBgK97S0cR8daounoU6YCZkZHtG
 yqWcGUxhHgfaVE3rKZw3nYx6UNSHnlqvcm3zXCT/GVH8TTPkMWBPUirF3s7c0uPhr5S3Yz6ieql
 jO1LH0cVaxEYgFeEnOYL8lZsFHzuQO7ZiWXXi5zIWkkEWdeso6A4aPHD2EIqiyhDs2Q==
X-Gm-Gg: AZFdTZfADiY9Hw2UOKSFwljg4MZ+Mbg3OAfFbgCp9H/+7wrjNkrrAEjTYAo31D/Npgp
 YPssP+8bpvMHvyEJz7n6P52Ym1kDid7pE9GyGiisNwV8AmSpUjt+Wmu2qE7hPJm4hrRBNFokBQO
 a8qnLyollLgyw0608FdWujsieWlpfV2KS2iHxSqu/26k3JaZu1u75XLVcOGt3xyEd3gfRul4rXj
 4AAHLOUU6RGL1Pg1b2DjOV9RzaLFhTVpcLNDzMZHV6BuCrQy/E5lIgmLAthohkeD0NiHJ47pmL+
 9FsaDhaSMS94WXZ+WSJWYE1JbhHYcLD3XFls3sql2CKb0eLL/pUKcq/hQCYESDmAKQDYZrrfZnw
 lE+f9ul5ZsHP4m6ZrDz2H7JWsacEfCS7hohwEIt7KMMCfEszXMSRtYQbYgKn7AIQGnc01Lrhwaf
 h0yefHA+nTNRqxGgUoeMeA
X-Received: by 2002:a05:7301:182f:b0:385:cf42:9b9b with SMTP id
 5a478bee46e88-385cf429e7amr565928eec.8.1795146837943; 
 Thu, 19 Nov 2026 19:53:57 -0800 (PST)
X-Received: by 2002:a05:7301:182f:b0:385:cf42:9b9b with SMTP id
 5a478bee46e88-385cf429e7amr565913eec.8.1795146837445; 
 Thu, 19 Nov 2026 19:53:57 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385665f21aesm3854126eec.4.2026.11.19.19.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 19:53:56 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com
Subject: [PULL 0/8] hex queue
Date: Thu, 19 Nov 2026 19:53:45 -0800
Message-Id: <20261120035353.3215703-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAxNSBTYWx0ZWRfX183Ay5yCQ1el
 b9iMtDKSWIVORgVaIN78IEsF7vG4N9UnnRGULzhhnrAjSX5oAWWnEU010imz9lUM2URzd/DvaIV
 wvuo76MASuMBFkaRppOAmpQgx02paAE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAxNSBTYWx0ZWRfXwRHLUQ/81bc6
 IuHEOLjPHgzPoZ0n5IrJrfck+R7Pt4bu5moHfXMyWKs7HRsOqPIalmPPkkQ2cf6PPf/mLZ9/kIk
 DGhETiMxlhro8XcPJAduVTcAPG9aL9ouE25twueezd6xhGoXQrted8IYVUSi/zVQwizKVvjBFuY
 xt51I1GkLBj/CGtXdu+yQkoIaC2w5SoLVlw2nVsdohVoocvncRxNXtUsA+l/8xeMQKEoNhrEd3n
 y5DzDffH01T4kh9nfdLiR7uO37dM+hkd6NZKFK4upfXGhge2FBCTUYrt3LfGv9WRamq/ZAhUf94
 oE9zxKnDixz+Y+xZZ7I6NPH/U2hAXMk/+hOHwLxxe0XXOJdyiLxqbbVk4bBzz5I7fIvIGuecxe6
 5DjHeeixqo+u2fypWg9387kvi1445ekhUYcE5L9CZaQdUsZBMUE1KOO1AQUz+8TN7TSrToQd0fs
 MxFhYC4kwf2RA0o93QQ==
X-Proofpoint-GUID: uhdm4o-3uwhGH36neiMgQ1kJWGdFBDps
X-Proofpoint-ORIG-GUID: uhdm4o-3uwhGH36neiMgQ1kJWGdFBDps
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6affc457 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=KyiuhIRjj154mL6bZjIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200015
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAwOGVkOTdjMzNjMzgxOGVmNTFhN2M4
NTIzNDdhMjhlOWY2NjgwN2I1OgoKICB0ZXN0cy90Y2cvaTM4NjogY29tcGlsZSB0ZXN0LWkzODYt
YmxlbmR2LmMgd2l0aCAtbXNzZTQuMSAoMjAyNi0xMS0xOSAxMzo1NDoxMyAtMDgwMCkKCmFyZSBh
dmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0OgoKICBodHRwczovL2dpdGh1Yi5jb20v
cXVhbGNvbW0vcWVtdSB0YWdzL3B1bGwtaGV4LTIwMjYxMTE5Cgpmb3IgeW91IHRvIGZldGNoIGNo
YW5nZXMgdXAgdG8gMmJmNDg1NGU3OTI0ODgzMjIzZmNjZmExMzlkYmM4NzQyN2M3Zjc1ODoKCiAg
bGludXgtdXNlcjogY29weSBuYW5vc2xlZXAncyByZW1haW5pbmcgdGltZSBvbiBFSU5UUiAoMjAy
Ni0xMS0xOSAxOTo1MDowMyAtMDgwMCkKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KaGV4YWdvbjogSExYIGZpeGVzLCBoMiBn
aXQsIGdwcmVsCgoqIEZpeGVzIGZvciBITFgKKiBuYW5vc2xlZXAoKSBmaXggKGltcGFjdGVkIG11
c2wpCiogaDI6IGRvbid0IGRlcGVuZCBvbiBnaXQKKiBub2lkZWYgZml4IGZvciBncC1yZWwgaW5z
dHJ1Y3Rpb25zCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCkFudG9uIEpvaGFuc3NvbiAoNSk6CiAgICAgIHRhcmdldC9oZXhh
Z29uOiBFeHBsaWNpdGx5IHBhc3MgR1AgdG8gaGVscGVycwogICAgICB0YXJnZXQvaGV4YWdvbjog
SExYLCBwcmVzZXJ2ZSBzY2FsYXIgOm1lbV9ub3NodWYgb3JkZXJpbmcKICAgICAgdGFyZ2V0L2hl
eGFnb246IEhMWCwgc2VhcmNoIGZvciAubmV3IHZhbHVlcyBpbiBwYWlyIGhpZ2ggcmVnaXN0ZXIK
ICAgICAgdGFyZ2V0L2hleGFnb246IEZvcndhcmQgcmV0dXJuIGFkZHJlc3MgdG8gSExYIGxvYWQv
c3RvcmUgaGVscGVycwogICAgICBsaW51eC11c2VyL2hleGFnb246IFJlc2V0IGhseF9jdHggcG9p
bnRlciBvbiBjcHUgY2xvbmUKCkJyaWFuIENhaW4gKDMpOgogICAgICByb21zOiByZWNvcmQgdGhl
IEgyIGNvbW1pdCBpbiBhIGZpbGUKICAgICAgdGFyZ2V0L2hleGFnb246IEZpeCBkaXNhc3NlbWJs
eSBvZiBleHRlbmRlZCBHUC1yZWxhdGl2ZSBhY2Nlc3NlcwogICAgICBsaW51eC11c2VyOiBjb3B5
IG5hbm9zbGVlcCdzIHJlbWFpbmluZyB0aW1lIG9uIEVJTlRSCgogTUFJTlRBSU5FUlMgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMSArCiBsaW51eC11c2VyL2hleGFnb24vdGFyZ2V0X2NwdS5o
ICAgICB8ICAxICsKIHRhcmdldC9oZXhhZ29uL2hseF9oZWxwZXIuaCAgICAgICAgIHwgMTkgKysr
KysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vaW5zbi5oICAgICAgICAgICAgICAgfCAg
MSArCiB0YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCAgICAgICAgICAgICB8IDIxICsrKysrKysrKyst
LS0tLS0tLS0tLQogdGFyZ2V0L2hleGFnb24vYXR0cmlic19kZWYuaC5pbmMgICAgfCAgMSArCiBs
aW51eC11c2VyL3N5c2NhbGwuYyAgICAgICAgICAgICAgICB8ICAyICstCiB0YXJnZXQvaGV4YWdv
bi9kZWNvZGUuYyAgICAgICAgICAgICB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
CiB0YXJnZXQvaGV4YWdvbi9obHhfaGVscGVyLmMgICAgICAgICB8IDMxICsrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAgICAgIHwg
IDcgKysrKy0tLQogdGVzdHMvdGNnL2hleGFnb24vaGx4X2Fzc2lnbl9jb252LmMgfCAzNSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogdGVzdHMvdGNnL2hleGFnb24vaGx4X21l
bS5jICAgICAgICAgfCAyMiArKysrKysrKysrKysrKysrKysrKysrCiByb21zL01ha2VmaWxlICAg
ICAgICAgICAgICAgICAgICAgICB8IDIyICsrKysrKysrKysrKysrKysrKy0tLS0KIHJvbXMvaGV4
YWdvbi1oeXBlcnZpc29yLXZlcnNpb24gICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vZ2VuX3By
aW50aW5zbi5weSAgICAgfCAgNyArKysrKysrCiB0YXJnZXQvaGV4YWdvbi9nZW5fdHJhbnNfZnVu
Y3MucHkgICB8ICA1ICsrKysrCiB0YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5ICAgICAgICB8
IDEzICsrKysrKysrKysrKysKIDE3IGZpbGVzIGNoYW5nZWQsIDE4NCBpbnNlcnRpb25zKCspLCAz
NCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9obHhfaGVs
cGVyLmgKIGNyZWF0ZSBtb2RlIDEwMDY0NCByb21zL2hleGFnb24taHlwZXJ2aXNvci12ZXJzaW9u
Cg==

