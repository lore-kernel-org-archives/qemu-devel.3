Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C07606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CXZaVryL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LQFY4XHi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMVPB-0000Su-0y; Thu, 29 Oct 2026 15:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMVOJ-0000IY-Ke
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:02:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMVOG-0003zS-Dl
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:02:21 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDBr01143729
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u8yiNDkqnjZl38GuOy00HzYVRZevoJ8QcX197xtfK6E=; b=CXZaVryLIPhwt21B
 KxgEEurVb2Lzk1uwPqrYpghDD4oZcnivClpZ5sVblNDz2VDrEHs/JUuBLIghtqhI
 bvc296Ixys9Rxg0drxxE4eNf03KkFeDzgrXNJ1dO0t0HQ6DsCppgQQdwqTZ5VEBI
 OC4o8XBSvUxPf+APdVTR+HObfL9dAm/u6FFqj4LqPagpg2FAZeZxO4xpeA4SMPB3
 /ia2Rd8ZusqQXwbMaFRcnPEShHBxrJUMuesiHpdCeW7ghshrXc6yulyusTsJdMW/
 5DtFuKJUgyOqik/dlYJ566oojZn5XTLOGgW7L+jJMH5yS7SqVmd1nXNzZfYCBl0v
 WQ5YnQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76cjugv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:02:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso36173eec.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793300538; x=1793905338; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u8yiNDkqnjZl38GuOy00HzYVRZevoJ8QcX197xtfK6E=;
 b=LQFY4XHiQhp38hTy7x1pcxBzeShQTGKK4PLaupJCA2dFvDHmB0IlERJXtuut44KGua
 DetRVDhOhWNwbgtOtpgjNpU/wX07OotNwQrR4KiUK0NvRhcZWnv9L11TN+cq3Q8bWmkW
 k9+9dJgX+NSuZFMtvGjGU3EuqV8m5Fkr/6qO59mhB9NpNMDePnIfw5XGCLWQVB+JmvqS
 DHT3OzyRRGRfP+jOA7S4vI2mpdNIpZQ2Gn6LPQ3MWbvQWZad+1gIolUKcKhgOBCiD8dL
 OUdPWcj3SC62DSd1pMwbiyUy+e0M0uI15lRLbbGwGfFsqhIZxwcv2jUZsbCwOE7EKsz1
 Tulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793300538; x=1793905338;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u8yiNDkqnjZl38GuOy00HzYVRZevoJ8QcX197xtfK6E=;
 b=ohYWvWrnwRs2Aop2WaxCSJLr74LGnTsbeMcxWpsBQRqE2whF9VG3ier6yG2RTsHzzB
 eAmgmU3trR43dIeHbsJ6x+/YdsuNu28/uCgglTNNHsC05yWHJ8ADLgElPv/bNZqzSxay
 sT4oTS6aPR0MqJ4WIIxxD/I7LzQbc6f3sz5PENFkf/c9hWvcDrHBKQ6MB+zjojh8q7QW
 3Yb8vPFM4Gn0vOW1+esnzbXA8B+7EXqxmdCSm+EXZ+EC95tW/nxjW8rvF8PCbxrf3+m7
 qMQmovnwlUyq1BlAXys+pSiUdjOmewp67tIvohwZF/cZnXz1v7aZYXpfjHi5A+wDAFwa
 ClPw==
X-Gm-Message-State: AFq9FYIeRPGei7XwL1PBsEZS3EgbtqtN6MxlwvPv/poq3B4wDPdynPBz
 YT9lmpAjBvDwXQUzjwRVPHaUSPxgch6wqOspJPxA59Md37j667p9Bfo7xn/GxqBQt+qCNbmq70o
 +u22GBqragwwRB4SCnJGoUS4nMzkxA5OklGRyu2nEavPY/gxQ8Arv9PhifeI8/3KK1Q==
X-Gm-Gg: AYBFou2ZpvtELsu3Ld8wjsdX5IUzhS2HPcBp4Z7oiEHgw3T5qXkw8cdW6guZyHqwZVq
 UAWYnDKsFJ9fA46H6z1xOgz+92zJRUsrfik3i2fuk8J8IOrV7ftxXdruxfMSJJE29uqi6dNaZ/G
 suiZAMuUR7fdvYIciExUKL9OtiF6C51GAMeLw+Un/sUmgO1qCQEWaMXjJ2BFLNGnoym8evyPSx8
 ZMCIBeE7a3BkozOp6pSm7NGbOnEQ21rxombcJiCK2ejYQDFjbnGQDlXE8YccJ+uT4dmFNpc0lTv
 uoiBU/pBKnY5brI9DXgareE0Bdb3UuE330ZTtaG/wRTCtREi1XPUh5mmQFec+HY1gaptXU4KsCm
 5Art0CgFsY9Z4xyqxyePnb0FjVAK5KGNo9qsHMNAVkdXy2YV+0Cxr4EXZBLN/SqLHetGr6Q13dP
 CawwVj/sl0XjP4oEQp7kJpRA==
X-Received: by 2002:a05:7300:ff42:b0:369:f231:4707 with SMTP id
 5a478bee46e88-36a42225abdmr333432eec.5.1793300538120; 
 Thu, 29 Oct 2026 12:02:18 -0700 (PDT)
X-Received: by 2002:a05:7300:ff42:b0:369:f231:4707 with SMTP id
 5a478bee46e88-36a42225abdmr333404eec.5.1793300537454; 
 Thu, 29 Oct 2026 12:02:17 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a98f65sm480598eec.28.2026.10.29.12.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:02:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 4/6] target/hexagon: implement the guest virt insns
Date: Thu, 29 Oct 2026 12:02:06 -0700
Message-Id: <20261029190208.1169519-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029190208.1169519-1-brian.cain@oss.qualcomm.com>
References: <20261029190208.1169519-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: z-LYgF0mQgVbzzz3iC0pHJpCBZldcfDH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3NCBTYWx0ZWRfX1Pa9kUyTrN+i
 9uHXEYjwtI7Q6e/XOCGU2sV2PH9bSaIcFr2bfRwXK+6LiW0D25FjLQywhbXYpAV+PTOgEpRLgcP
 TM46kUNqqBqayBnnS7WlmfYcyurpvILwlkccZ//u6G6IGWbkg0zfPDKdaPXG7HYjWLwbI9JMRKJ
 kpyVuIIXxqdnP1qbRtCiYRils6RGgnlZ/ADmf2yL+MHwDNhXqTxDgybHz8fsbAYTNqZzwiElq5f
 irsaaDzs5JRawNF55mBqz6q0tocDBjrvVzWMpFMxtZRMXSYo0+4Wb+itiJTJqrU6xnoUdHyWGPX
 uVfNOpB2p44+jjo0oJ+LBvr0Yu3SRl/eOVJkAZ9iPi0sVZlk1h6F1YXlE1BwbPRjqekuAVCHtiu
 J6jvSB7CKWjaEOSAOJ/274NdHj6IjxoRdVTak27/tGy4oY3Tj6LWqMo7gDOQGNGaNEV1+orVl8t
 lfppGAufUDuS9EA2PrA==
X-Proofpoint-GUID: z-LYgF0mQgVbzzz3iC0pHJpCBZldcfDH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3NCBTYWx0ZWRfX99f95PHahyUE
 6kmXHE3RSCwDtWcCFz04z2a6/bXugJqc1sgyd3k4aTyMwAdICVGGzx/rhE1NqtU0fZ9kZPlKWrQ
 KAGZy+PaDNWGbao9ORVuK8O2kVeUBr0=
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ae3983b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=p0z7zY-Vz3QUpdWJbSEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290074
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SW1wbGVtZW50IHRoZSBndWVzdCB2aXJ0dWFsIGluc3RydWN0aW9ucyBTUFNXQVAsIEdFVElFLCBT
RVRJRSBhbmQgUlRFLgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleHN3aS5oICAgICAgfCAgMSArCiB0
YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmggIHwgMzMgKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyAgICAgIHwgMjggKysrKysrKysrKysr
KysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSB8ICAyICstCiA0
IGZpbGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmggYi90YXJnZXQvaGV4YWdvbi9oZXhzd2kuaApp
bmRleCA1ODdmNzkwNDE0Yy4uZGExMWJlYTJiMjMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29u
L2hleHN3aS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleHN3aS5oCkBAIC0xMyw2ICsxMyw3IEBA
CiB2b2lkIGhleGFnb25fY3B1X2RvX2ludGVycnVwdChDUFVTdGF0ZSAqY3B1KTsKIHZvaWQgcmVn
aXN0ZXJfdHJhcF9leGNlcHRpb24oQ1BVSGV4YWdvblN0YXRlICplbnYsIGludCB0eXBlLCBpbnQg
aW1tLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBQQyk7Cit2b2lkIGhl
eGFnb25fdm1ydGUoQ1BVSGV4YWdvblN0YXRlICplbnYpOwogCiAjZGVmaW5lIEhFWF9HRVZCX0hX
X0VSUk9SICAgICAgKEhFWF9FVkVOVF9QUkVDSVNFIDw8IDIpCiAjZGVmaW5lIEhFWF9HRVZCX0hX
X1RSQVAwICAgICAgKEhFWF9FVkVOVF9UUkFQMCA8PCAyKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vc3lzX21hY3Jvcy5oIGIvdGFyZ2V0L2hleGFnb24vc3lzX21hY3Jvcy5oCmluZGV4IGI4
OTZlZTFjODFiLi4yNzBhYTBjNDExZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vc3lzX21h
Y3Jvcy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaApAQCAtNzksMTUgKzc5LDM2
IEBACiAjZGVmaW5lIGZGUkFNRUNIRUNLKEFERFIsIEVBKSBnZW5fZnJhbWVjaGVjayhjdHgsIEFE
RFIsIEVBKQogI2VuZGlmCiAKLSNkZWZpbmUgZlZJUlRJTlNOX1NQU1dBUChJTU0sIFJFRykKLSNk
ZWZpbmUgZlZJUlRJTlNOX0dFVElFKElNTSwgUkVHKSB7IFJFRyA9IDB4ZGVhZmJlZWY7IH0KLSNk
ZWZpbmUgZlZJUlRJTlNOX1NFVElFKElNTSwgUkVHKQotI2RlZmluZSBmVklSVElOU05fUlRFKElN
TSwgUkVHKQorI2RlZmluZSBmVklSVElOU05fU1BTV0FQKElNTSwgUkVHKSBcCisgICAgZG8geyBc
CisgICAgICAgIGlmIChHRVRfRklFTEQoR1NSX1VNLCBlbnYtPmdyZWdbSEVYX0dSRUdfR1NSXSkp
IHsgXAorICAgICAgICAgICAgdWludDMyX3QgdG1wID0gKFJFRyk7IFwKKyAgICAgICAgICAgIChS
RUcpID0gZW52LT5ncmVnW0hFWF9HUkVHX0dPU1BdOyBcCisgICAgICAgICAgICBlbnYtPmdyZWdb
SEVYX0dSRUdfR09TUF0gPSB0bXA7IFwKKyAgICAgICAgfSBcCisgICAgICAgIGVudi0+Z3ByW0hF
WF9SRUdfUENdID0gbmV4dF9QQzsgXAorICAgIH0gd2hpbGUgKDApCisjZGVmaW5lIGZWSVJUSU5T
Tl9HRVRJRShJTU0sIFJFRykgXAorICAgIGRvIHsgXAorICAgICAgICAoUkVHKSA9IENDUl9GSUVM
RF9TRVQoZW52LCBDQ1JfR0lFKTsgXAorICAgICAgICBlbnYtPmdwcltIRVhfUkVHX1BDXSA9IG5l
eHRfUEM7IFwKKyAgICB9IHdoaWxlICgwKQorI2RlZmluZSBmVklSVElOU05fU0VUSUUoSU1NLCBS
RUcpIFwKKyAgICBkbyB7IFwKKyAgICAgICAgdWludDMyX3Qgb2xkX2dpZSA9IENDUl9GSUVMRF9T
RVQoZW52LCBDQ1JfR0lFKTsgXAorICAgICAgICB1aW50MzJfdCBuZXdfZ2llID0gKFJFRykgJiAx
OyBcCisgICAgICAgIFNFVF9TWVNURU1fRklFTEQoZW52LCBIRVhfU1JFR19DQ1IsIENDUl9HSUUs
IG5ld19naWUpOyBcCisgICAgICAgIChSRUcpID0gb2xkX2dpZTsgXAorICAgICAgICBlbnYtPmdw
cltIRVhfUkVHX1BDXSA9IG5leHRfUEM7IFwKKyAgICB9IHdoaWxlICgwKQorI2RlZmluZSBmVklS
VElOU05fUlRFKElNTSwgUkVHKSBoZXhhZ29uX3ZtcnRlKGVudikKICNkZWZpbmUgZkdSRV9FTkFC
TEVEKCkgXAogICAgIEdFVF9GSUVMRChDQ1JfR1JFLCBlbnYtPnRfc3JlZ1tIRVhfU1JFR19DQ1Jd
KQorLyogVmlydHVhbCBpbnN0cnVjdGlvbnMgZXhlY3V0ZSBvbmx5IGluIGd1ZXN0IG1vZGUuICov
CiAjZGVmaW5lIGZUUkFQMV9WSVJUSU5TTihJTU0pIFwKLSAgICAoZkdSRV9FTkFCTEVEKCkgJiYg
XAotICAgICAgICAoKChJTU0pID09IDEpIHx8ICgoSU1NKSA9PSAzKSB8fCAoKElNTSkgPT0gNCkg
fHwgKChJTU0pID09IDYpKSkKKyAgICAoZ2V0X2NwdV9tb2RlKGVudikgPT0gSEVYX0NQVV9NT0RF
X0dVRVNUICYmIGZHUkVfRU5BQkxFRCgpICYmIFwKKyAgICAgICAgKCgoSU1NKSA9PSAxKSB8fCAo
KElNTSkgPT0gMykgfHwgKChJTU0pID09IDQpIHx8IFwKKyAgICAgICAgICgoSU1NKSA9PSA2KSkp
CiAKIC8qIE5vdCBtb2RlbGVkIGluIHFlbXUgKi8KIApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vaGV4c3dpLmMgYi90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYwppbmRleCA5ZDk0ZWVmOTZhNy4u
ZTJkODIzMzcwMWQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2hleHN3aS5jCkBAIC04MjEsNiArODIxLDM0IEBAIHN0YXRpYyB2b2lkIGd1
ZXN0X2V2ZW50X2VudHJ5KENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBjYXVzZSwKICAg
ICBlbnYtPmdwcltIRVhfUkVHX1BDXSA9IGdldmIgKyB2ZWNfb2Zmc2V0OwogfQogCit2b2lkIGhl
eGFnb25fdm1ydGUoQ1BVSGV4YWdvblN0YXRlICplbnYpCit7CisgICAgdWludDMyX3QgZ3NyID0g
ZW52LT5ncmVnW0hFWF9HUkVHX0dTUl07CisgICAgdWludDMyX3Qgb2xkX3NzciA9IGVudi0+dF9z
cmVnW0hFWF9TUkVHX1NTUl07CisgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShlbnYpOworCisg
ICAgaWYgKEdFVF9GSUVMRChHU1JfVU0sIGdzcikpIHsKKyAgICAgICAgdWludDMyX3Qgc3AgPSBl
bnYtPmdwcltIRVhfUkVHX1NQXTsKKworICAgICAgICBlbnYtPmdwcltIRVhfUkVHX1NQXSA9IGVu
di0+Z3JlZ1tIRVhfR1JFR19HT1NQXTsKKyAgICAgICAgZW52LT5ncmVnW0hFWF9HUkVHX0dPU1Bd
ID0gc3A7CisgICAgfQorICAgIFNFVF9TWVNURU1fRklFTEQoZW52LCBIRVhfU1JFR19TU1IsIFNT
Ul9TUywKKyAgICAgICAgICAgICAgICAgICAgIEdFVF9GSUVMRChHU1JfU1MsIGdzcikpOworICAg
IFNFVF9TWVNURU1fRklFTEQoZW52LCBIRVhfU1JFR19TU1IsIFNTUl9HTSwKKyAgICAgICAgICAg
ICAgICAgICAgICFHRVRfRklFTEQoR1NSX1VNLCBnc3IpKTsKKyAgICB7CisgICAgICAgIEJRTF9M
T0NLX0dVQVJEKCk7CisgICAgICAgIGhleGFnb25fbW9kaWZ5X3NzcihlbnYsIGVudi0+dF9zcmVn
W0hFWF9TUkVHX1NTUl0sIG9sZF9zc3IpOworICAgIH0KKyAgICBTRVRfU1lTVEVNX0ZJRUxEKGVu
diwgSEVYX1NSRUdfQ0NSLCBDQ1JfR0lFLAorICAgICAgICAgICAgICAgICAgICAgIEdFVF9GSUVM
RChHU1JfSUUsIGdzcikpOworICAgIGVudi0+Y2ZpX2FjdGl2ZSA9IEdFVF9GSUVMRChHU1JfQ0ZJ
LCBnc3IpOworICAgIGZTRVRfRklFTEQoZW52LT5ncmVnW0hFWF9HUkVHX0dTUl0sIEdTUl9DRkks
IDApOworICAgIGVudi0+Z3ByW0hFWF9SRUdfUENdID0gZW52LT5ncmVnW0hFWF9HUkVHX0dFTFJd
ICYgfjM7CisgICAgY3B1X2xvb3BfZXhpdChjcyk7Cit9CisKIHZvaWQgaGV4YWdvbl9jcHVfZG9f
aW50ZXJydXB0KENQVVN0YXRlICpjcykKIAogewpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
aGV4X2NvbW1vbi5weSBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKaW5kZXggOTRlNzBi
ODY1N2QuLjBjNzhiNDA0NGVmIDEwMDc1NQotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9u
LnB5CisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKQEAgLTI4OCw3ICsyODgsNyBA
QCBkZWYgbmVlZF9QQyh0YWcpOgogCiAKIGRlZiBuZWVkX25leHRfUEModGFnKToKLSAgICByZXR1
cm4gIkFfQ0FMTCIgaW4gYXR0cmliZGljdFt0YWddCisgICAgcmV0dXJuICJBX0NBTEwiIGluIGF0
dHJpYmRpY3RbdGFnXSBvciB0YWcgPT0gIkoyX3RyYXAxIgogCiAKIGRlZiBuZWVkX3BrdF9oYXNf
bXVsdGlfY29mKHRhZyk6Ci0tIAoyLjM0LjEKCg==

