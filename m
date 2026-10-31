Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFD5606A321
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mMzVwH/+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D8dnclso
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMxvp-0004iZ-CX; Fri, 30 Oct 2026 21:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxvI-0004Yh-2T
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMxvG-00033R-06
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:30:19 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69V1C1Vr3333476
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oX/ZHVIcjqhzyeCr1FYnuvar5qlBDc9pdvHlJbA4ses=; b=mMzVwH/+Pf9c5LlL
 GHl7KWakd2y4jWPkz9yzrUeyV5tYX1bFbjzsTLDTYuB1y0qKTKkz4sfh4U6MOwar
 Gh9y7pSjVTWiL26FvZifOQ23uRxSAulE78os23BEA4sGNorwbIdUmIM2wEOFnSzR
 gikZAZOTSi7SGRtI44s016AGBHAv9+DclXI4b5uLmN9LmpW6Y74NMgZZva34eGDQ
 BdNZVodcdXMy+UmadlAoWc9qBg+SRhWjWZpTVfuGtsmVcP4IX5vqLVHRYmIqzLPS
 m8O0zMDYcxXHHG7fB8Pf355ESynZNW7aPxa8Fjp1VB0PsBsNQR8cnW5oIub6vM5O
 6en29Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x18j65-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:30:14 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso3145697eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793410214; x=1794015014; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oX/ZHVIcjqhzyeCr1FYnuvar5qlBDc9pdvHlJbA4ses=;
 b=D8dnclsoKptvOzOAsizvSr/BUdUTwLew3D4dmmm/DsSC31TEDe93Inz3ZgHtK2tty/
 FWMaRZj3DQRK+Q76rzcgJx6k/Dhx/q0r0JnmW6CBndbwjHJLslqH6TEc8ugZZsv80khN
 6o4BbhKpM7EQKZC5mLc5i7/28JABTF1qp41gKdwrweHCZdgvbOn6uAyg+0UTqjKTbpew
 si+vz2bVFizhxYw2GSzsKdORXRWWy5hPGbBLb5/xGe0dIYWmG7/MIELhC9mYcqBnXokR
 edyWoVyAgrMTIwPOR96KHhoObMKMUTtDbOkY1OAOWNP1ii+twgPBXbr6Mfto6LvdUMGX
 3I3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793410214; x=1794015014;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oX/ZHVIcjqhzyeCr1FYnuvar5qlBDc9pdvHlJbA4ses=;
 b=ZkFnimTlkl250Ze3KXtYr70nGpLdm072pQ4hcocsj8E5IdaGnXv6QC+sShefmDhS2M
 uxC2i0wOl4S8UF4i+yptDezdxELZ7W4500hzGDopnMsv1zVAkXGRyS4NIcoaVUkVIjZ8
 MTMka+hBdQa4iagenT7UHJ5redxzKxf/7WBNGES5bnpTAnw5LTwjQWgtoKeCnFg7gbwj
 ZYJ6wPJ8Ji2LDTR09V+12Omp0JZi9sqWCExfljP0V3Ks+//Rb9XvQCDGnB7RxRI89Mvg
 MkBVHzxfqhawHOn9oODPcR3mdyqavfUlST5vye6Okn6B+xl9nwWC4834oWnFhL3AHW+G
 uYIA==
X-Gm-Message-State: AFq9FYLoytzTammJppQGGSxsMncHQZjj9j7659aI1YT7ygj/OxNIl25U
 id1zk6e8vWJy1Whdcfr9orRvodJ1UcMRkyZ6qnLDZfPUouxumCUDsY/OsBOu+47/tqFZ7Oi2nb2
 SPbPdgYJOMU/dMpFy7gGa21TKKv7pFtYpH7l3Q83ZIW8hatSsX1+U4j/rDSGMkbAU5w==
X-Gm-Gg: AYBFou18FBdj5r8izqzCV1EJw5V/snfWuQAwpvYA+o9iCkFZYa7jpYHfCVg2BbEbAv4
 RmTQC9r0GBhzVVnkXd7Hq2gwC0Co2dkP6tBKifUjo/qxqlNH8FLarcpJPs3gQK6OF2tUCkD2KU0
 XoG3AjYLggQzmkYRWZ3bPhkVTDsUxZ6TifoC2x4yBdpZIG3EYwcdfCkLT/mQlRTKt93+tjFnTGD
 Z1aMofaU60Yc4uXJOWn2iaoHRE0JlEhXv4vMfo0ZM+T6XM7xVRadpCyiS2L0+Vckd5pCq6b9sUA
 lTm4gnTb2IFfZLeiGLdW9uDymIXnlVUUYxLPsYOyuRa7vKRPoU/xcJbdkVI9m5WuYZsmLCSfy3a
 quR/WnmKQdGDMfinG5yaHGpMsKVaMr639Sk3ykLON9e5PJfDf4snShHVlT+qXkN8b+uXbTiv7hy
 YhuSUjV+uxwHH7fQ1o10s8TA==
X-Received: by 2002:a05:693c:88c8:20b0:369:f2d6:4108 with SMTP id
 5a478bee46e88-36a42401233mr5765249eec.10.1793410213551; 
 Fri, 30 Oct 2026 18:30:13 -0700 (PDT)
X-Received: by 2002:a05:693c:88c8:20b0:369:f2d6:4108 with SMTP id
 5a478bee46e88-36a42401233mr5765221eec.10.1793410212974; 
 Fri, 30 Oct 2026 18:30:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42952e1csm12170472eec.20.2026.10.30.18.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 18:30:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 10/40] target/hexagon: implement the guest virt insns
Date: Fri, 30 Oct 2026 18:29:11 -0700
Message-Id: <20261031012941.339141-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
References: <20261031012941.339141-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: tCfubY0daabj1q264AEPh-yfayXw3tFg
X-Proofpoint-ORIG-GUID: tCfubY0daabj1q264AEPh-yfayXw3tFg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX0+HNGhycVrma
 ESb8xjmDoI9WAYTImcaEqyUG+wPDVG719MdJydr/bXYCi9UqfT1pjpnKGmG81Fq/LVUbNqdHse4
 VIBognEI+wc+D9tvh0ayJkSP3OkKy66/rHSEuK9kZgTSkVYuGEJHSSHuGkn8ArQ84IvxP0ubk0H
 vtzEVuwzEDQ2qnfg0rHxeabEtrYiVpODLw6hApKY9al822NNDMZwx5/cdHNAmizPKiCEj4oYFY0
 US9bs8c1cbaSZ1EIv6pIPDi+jfeDa1JKYwC+684CBdT9R1OrYib0zDmjRqvh162HzJAGKalnCqT
 Ou0fkGGjzOrbDSIO0Cd+cJhXYRKrJqmknL9SpC/ZZqDaPPBRnlaZxdOMNRafwc44+zDKxq4lH8f
 LwC+GXZ5eVJyveWnEfX5cwsg4msg7Av7oW+nFkEXWSxv5DWSO3NajBp/OkXiA8UskO6/7zAVQu6
 zRug6hqb1EUkhiEy2YQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAwNSBTYWx0ZWRfX+HtGcGNiGTDl
 P977e4qaZSIBharIQvg3gAV5Kqwhqe8exN9GSpuCk5R2Ickx2ux6/fd2btXFAJ2A94kcvKejR0M
 RXZ/RqIIMjUkB8bSIQ0AmkSEcU3eXSM=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6ae544a6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=p0z7zY-Vz3QUpdWJbSEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310005
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SW1wbGVtZW50IHRoZSBndWVzdCB2aXJ0dWFsIGluc3RydWN0aW9ucyBTUFNXQVAsIEdFVElFLCBT
RVRJRSBhbmQgUlRFLgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJv
dXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4u
Y2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleHN3aS5oICAgICAg
fCAgMSArCiB0YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmggIHwgMzMgKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyAgICAgIHwgMjggKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSB8
ICAyICstCiA0IGZpbGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmggYi90YXJnZXQvaGV4YWdvbi9o
ZXhzd2kuaAppbmRleCA1ODdmNzkwNDE0Yy4uZGExMWJlYTJiMjMgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2hleHN3aS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleHN3aS5oCkBAIC0xMyw2
ICsxMyw3IEBACiB2b2lkIGhleGFnb25fY3B1X2RvX2ludGVycnVwdChDUFVTdGF0ZSAqY3B1KTsK
IHZvaWQgcmVnaXN0ZXJfdHJhcF9leGNlcHRpb24oQ1BVSGV4YWdvblN0YXRlICplbnYsIGludCB0
eXBlLCBpbnQgaW1tLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBQQyk7
Cit2b2lkIGhleGFnb25fdm1ydGUoQ1BVSGV4YWdvblN0YXRlICplbnYpOwogCiAjZGVmaW5lIEhF
WF9HRVZCX0hXX0VSUk9SICAgICAgKEhFWF9FVkVOVF9QUkVDSVNFIDw8IDIpCiAjZGVmaW5lIEhF
WF9HRVZCX0hXX1RSQVAwICAgICAgKEhFWF9FVkVOVF9UUkFQMCA8PCAyKQpkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vc3lzX21hY3Jvcy5oIGIvdGFyZ2V0L2hleGFnb24vc3lzX21hY3Jvcy5o
CmluZGV4IGI4OTZlZTFjODFiLi4yNzBhYTBjNDExZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vc3lzX21hY3Jvcy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3N5c19tYWNyb3MuaApAQCAtNzks
MTUgKzc5LDM2IEBACiAjZGVmaW5lIGZGUkFNRUNIRUNLKEFERFIsIEVBKSBnZW5fZnJhbWVjaGVj
ayhjdHgsIEFERFIsIEVBKQogI2VuZGlmCiAKLSNkZWZpbmUgZlZJUlRJTlNOX1NQU1dBUChJTU0s
IFJFRykKLSNkZWZpbmUgZlZJUlRJTlNOX0dFVElFKElNTSwgUkVHKSB7IFJFRyA9IDB4ZGVhZmJl
ZWY7IH0KLSNkZWZpbmUgZlZJUlRJTlNOX1NFVElFKElNTSwgUkVHKQotI2RlZmluZSBmVklSVElO
U05fUlRFKElNTSwgUkVHKQorI2RlZmluZSBmVklSVElOU05fU1BTV0FQKElNTSwgUkVHKSBcCisg
ICAgZG8geyBcCisgICAgICAgIGlmIChHRVRfRklFTEQoR1NSX1VNLCBlbnYtPmdyZWdbSEVYX0dS
RUdfR1NSXSkpIHsgXAorICAgICAgICAgICAgdWludDMyX3QgdG1wID0gKFJFRyk7IFwKKyAgICAg
ICAgICAgIChSRUcpID0gZW52LT5ncmVnW0hFWF9HUkVHX0dPU1BdOyBcCisgICAgICAgICAgICBl
bnYtPmdyZWdbSEVYX0dSRUdfR09TUF0gPSB0bXA7IFwKKyAgICAgICAgfSBcCisgICAgICAgIGVu
di0+Z3ByW0hFWF9SRUdfUENdID0gbmV4dF9QQzsgXAorICAgIH0gd2hpbGUgKDApCisjZGVmaW5l
IGZWSVJUSU5TTl9HRVRJRShJTU0sIFJFRykgXAorICAgIGRvIHsgXAorICAgICAgICAoUkVHKSA9
IENDUl9GSUVMRF9TRVQoZW52LCBDQ1JfR0lFKTsgXAorICAgICAgICBlbnYtPmdwcltIRVhfUkVH
X1BDXSA9IG5leHRfUEM7IFwKKyAgICB9IHdoaWxlICgwKQorI2RlZmluZSBmVklSVElOU05fU0VU
SUUoSU1NLCBSRUcpIFwKKyAgICBkbyB7IFwKKyAgICAgICAgdWludDMyX3Qgb2xkX2dpZSA9IEND
Ul9GSUVMRF9TRVQoZW52LCBDQ1JfR0lFKTsgXAorICAgICAgICB1aW50MzJfdCBuZXdfZ2llID0g
KFJFRykgJiAxOyBcCisgICAgICAgIFNFVF9TWVNURU1fRklFTEQoZW52LCBIRVhfU1JFR19DQ1Is
IENDUl9HSUUsIG5ld19naWUpOyBcCisgICAgICAgIChSRUcpID0gb2xkX2dpZTsgXAorICAgICAg
ICBlbnYtPmdwcltIRVhfUkVHX1BDXSA9IG5leHRfUEM7IFwKKyAgICB9IHdoaWxlICgwKQorI2Rl
ZmluZSBmVklSVElOU05fUlRFKElNTSwgUkVHKSBoZXhhZ29uX3ZtcnRlKGVudikKICNkZWZpbmUg
ZkdSRV9FTkFCTEVEKCkgXAogICAgIEdFVF9GSUVMRChDQ1JfR1JFLCBlbnYtPnRfc3JlZ1tIRVhf
U1JFR19DQ1JdKQorLyogVmlydHVhbCBpbnN0cnVjdGlvbnMgZXhlY3V0ZSBvbmx5IGluIGd1ZXN0
IG1vZGUuICovCiAjZGVmaW5lIGZUUkFQMV9WSVJUSU5TTihJTU0pIFwKLSAgICAoZkdSRV9FTkFC
TEVEKCkgJiYgXAotICAgICAgICAoKChJTU0pID09IDEpIHx8ICgoSU1NKSA9PSAzKSB8fCAoKElN
TSkgPT0gNCkgfHwgKChJTU0pID09IDYpKSkKKyAgICAoZ2V0X2NwdV9tb2RlKGVudikgPT0gSEVY
X0NQVV9NT0RFX0dVRVNUICYmIGZHUkVfRU5BQkxFRCgpICYmIFwKKyAgICAgICAgKCgoSU1NKSA9
PSAxKSB8fCAoKElNTSkgPT0gMykgfHwgKChJTU0pID09IDQpIHx8IFwKKyAgICAgICAgICgoSU1N
KSA9PSA2KSkpCiAKIC8qIE5vdCBtb2RlbGVkIGluIHFlbXUgKi8KIApkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vaGV4c3dpLmMgYi90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYwppbmRleCA5ZDk0
ZWVmOTZhNy4uZTJkODIzMzcwMWQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleHN3aS5j
CisrKyBiL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jCkBAIC04MjEsNiArODIxLDM0IEBAIHN0YXRp
YyB2b2lkIGd1ZXN0X2V2ZW50X2VudHJ5KENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBj
YXVzZSwKICAgICBlbnYtPmdwcltIRVhfUkVHX1BDXSA9IGdldmIgKyB2ZWNfb2Zmc2V0OwogfQog
Cit2b2lkIGhleGFnb25fdm1ydGUoQ1BVSGV4YWdvblN0YXRlICplbnYpCit7CisgICAgdWludDMy
X3QgZ3NyID0gZW52LT5ncmVnW0hFWF9HUkVHX0dTUl07CisgICAgdWludDMyX3Qgb2xkX3NzciA9
IGVudi0+dF9zcmVnW0hFWF9TUkVHX1NTUl07CisgICAgQ1BVU3RhdGUgKmNzID0gZW52X2NwdShl
bnYpOworCisgICAgaWYgKEdFVF9GSUVMRChHU1JfVU0sIGdzcikpIHsKKyAgICAgICAgdWludDMy
X3Qgc3AgPSBlbnYtPmdwcltIRVhfUkVHX1NQXTsKKworICAgICAgICBlbnYtPmdwcltIRVhfUkVH
X1NQXSA9IGVudi0+Z3JlZ1tIRVhfR1JFR19HT1NQXTsKKyAgICAgICAgZW52LT5ncmVnW0hFWF9H
UkVHX0dPU1BdID0gc3A7CisgICAgfQorICAgIFNFVF9TWVNURU1fRklFTEQoZW52LCBIRVhfU1JF
R19TU1IsIFNTUl9TUywKKyAgICAgICAgICAgICAgICAgICAgIEdFVF9GSUVMRChHU1JfU1MsIGdz
cikpOworICAgIFNFVF9TWVNURU1fRklFTEQoZW52LCBIRVhfU1JFR19TU1IsIFNTUl9HTSwKKyAg
ICAgICAgICAgICAgICAgICAgICFHRVRfRklFTEQoR1NSX1VNLCBnc3IpKTsKKyAgICB7CisgICAg
ICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgICAgIGhleGFnb25fbW9kaWZ5X3NzcihlbnYsIGVu
di0+dF9zcmVnW0hFWF9TUkVHX1NTUl0sIG9sZF9zc3IpOworICAgIH0KKyAgICBTRVRfU1lTVEVN
X0ZJRUxEKGVudiwgSEVYX1NSRUdfQ0NSLCBDQ1JfR0lFLAorICAgICAgICAgICAgICAgICAgICAg
IEdFVF9GSUVMRChHU1JfSUUsIGdzcikpOworICAgIGVudi0+Y2ZpX2FjdGl2ZSA9IEdFVF9GSUVM
RChHU1JfQ0ZJLCBnc3IpOworICAgIGZTRVRfRklFTEQoZW52LT5ncmVnW0hFWF9HUkVHX0dTUl0s
IEdTUl9DRkksIDApOworICAgIGVudi0+Z3ByW0hFWF9SRUdfUENdID0gZW52LT5ncmVnW0hFWF9H
UkVHX0dFTFJdICYgfjM7CisgICAgY3B1X2xvb3BfZXhpdChjcyk7Cit9CisKIHZvaWQgaGV4YWdv
bl9jcHVfZG9faW50ZXJydXB0KENQVVN0YXRlICpjcykKIAogewpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weSBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKaW5k
ZXggOTRlNzBiODY1N2QuLjBjNzhiNDA0NGVmIDEwMDc1NQotLS0gYS90YXJnZXQvaGV4YWdvbi9o
ZXhfY29tbW9uLnB5CisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKQEAgLTI4OCw3
ICsyODgsNyBAQCBkZWYgbmVlZF9QQyh0YWcpOgogCiAKIGRlZiBuZWVkX25leHRfUEModGFnKToK
LSAgICByZXR1cm4gIkFfQ0FMTCIgaW4gYXR0cmliZGljdFt0YWddCisgICAgcmV0dXJuICJBX0NB
TEwiIGluIGF0dHJpYmRpY3RbdGFnXSBvciB0YWcgPT0gIkoyX3RyYXAxIgogCiAKIGRlZiBuZWVk
X3BrdF9oYXNfbXVsdGlfY29mKHRhZyk6Ci0tIAoyLjM0LjEKCg==

