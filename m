Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D23C3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 02:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0XAb-00061W-21; Thu, 03 Apr 2025 22:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0XAU-0005tn-SK
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 22:52:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0XAR-0006lb-F4
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 22:52:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341Oisg012629
 for <qemu-devel@nongnu.org>; Fri, 4 Apr 2025 02:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rOv9AfRtm4zcRad8q04n0pfTqeC4Q7o4V7dElaVWBUw=; b=VW0UqCy7dnER2rgR
 95dG1wJqlTy4CcBzajNoW+RqJ0aOMLumk3D3qcCn+YE2kjj/wv9QhSR5phrBfw2D
 AuTnKlZuKeE6/4TcihrWur6oiIdBLMEOV0gaKPJHNgcxrxJd3TBEWajC2Mt+YTnN
 VX7UuVZtY4T1SSEgBMqTl/HYeFYQ+t4AhZgizeSTnPqjh+sSyzHlzcnnYPc5Fx/d
 cNwLQvQlSCYLkRyZFFAiSWn+rXjEjgfoqodDD4FnX2evzh4biKumB/xQq0+ownkh
 0URLXJHZmxgmTLDxBN1DnTpr/NUFlg9eaVYDS8pLm07W8P805m1xPgsh0cobS8DZ
 HfYNsQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45t2d50gc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 02:52:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2254bdd4982so23388885ad.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 19:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743735144; x=1744339944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rOv9AfRtm4zcRad8q04n0pfTqeC4Q7o4V7dElaVWBUw=;
 b=M75HEWV032nFVkwrzVA3LStBa/OvkRssVtLd8OztFf5SmZ4qqTDqSPSqfAGmHIi31m
 MeIyVcXv8RJGIpjEran2fyuQNa8XPl90zabeUNjX51gS/rVX3ISEjnfuihCDD5JEL4RH
 yAXzSZ5sS1UgrLXPJp1VkmctezL6ogoydSmdXkKEOikBw1RtfbEzQSDp/x1GovKlAR6j
 PxHs2OVnpPM8kNBxUJ/ZDHTzWsKz8svVVKfhTQj3Ftw8gTV7wMGrbgtBDAUDLeT/wAaW
 /f1QvBeha04PrBWkRammDFfJAis0ZKsBai70bnDr3YcfidVraRcU6Jm2odmV9kIQjf1o
 G7JQ==
X-Gm-Message-State: AOJu0YwHvpjSh2lxZnUMe6pOWWjaaES1Tcj4+ppK1aBK5BpHcoJYMrJW
 dZ3O6zm25TSHC/M1kVSdT/rltrc0FMoa7aDq55rIXDRRaiQOePFW/gx/BIS81L8b+3y1Utps9BF
 R/SwQ/PTOBZOOwRv+1fr5dWIzm4g7QGEupc0JmvgMc83S5dbtMjt/SEyBe0jJ6w==
X-Gm-Gg: ASbGncvdTAp99r1xIkZuETQM1kGLTMpqy5uiSM92LMU3MPKEXfCwhL1/tOCc+TqwxG9
 vL6Od3sfzYF/RxZisXpTwfCCOA/BJUAZzW2KhYTbVWzgHQvn/SJSX/O1pgj+vQQ6qvFtRpaSCpv
 lWJXEdf18MuwjP+WbllQUT4WRr1EzI5J+Qi3yAmce1FquwfBnE8WoGaE469cEiXCGGkPLR4tReP
 iusHG5PiKtqMPybScueg7Ec+RiPnCA9PGIV9KwS4F8O/0sxSEDBHIkogbO2xahFTBswSOGxJEgf
 jleUuOZeXPdxhLeqo3Zo5nhSn7n13vsALlY4f7qhbLFLRe/2mX8aUkqrq1SnSE6O
X-Received: by 2002:a17:903:3d0d:b0:224:7a4:b2a with SMTP id
 d9443c01a7336-22a8a045ceamr21058275ad.11.1743735143769; 
 Thu, 03 Apr 2025 19:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdlVUFzpzBERZOOxUXiM88AYV8QE2fkZNgtVLPNeCyoE5rDxE1VGbB3VS5yoE60WxgNrVQHA==
X-Received: by 2002:a17:903:3d0d:b0:224:7a4:b2a with SMTP id
 d9443c01a7336-22a8a045ceamr21057915ad.11.1743735143194; 
 Thu, 03 Apr 2025 19:52:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785ea16bsm22014865ad.106.2025.04.03.19.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 19:52:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 1/6] target/hexagon: handle .new values
Date: Thu,  3 Apr 2025 19:51:58 -0700
Message-Id: <20250404025203.335025-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250404025203.335025-1-brian.cain@oss.qualcomm.com>
References: <20250404025203.335025-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 8EHkZeTEgaarjdxCr3a6osraeH6ECHtQ
X-Proofpoint-ORIG-GUID: 8EHkZeTEgaarjdxCr3a6osraeH6ECHtQ
X-Authority-Analysis: v=2.4 cv=bZtrUPPB c=1 sm=1 tr=0 ts=67ef4968 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=rPjZFjiy9LBZz0qYGpsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=432
 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504040019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
aGV4X2NvbW1vbi5weSB8IDI3ICsrKysrKysrKysrKysrKysrKysrKystLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkK
aW5kZXggNzU4ZTVmZDEyZC4uMjQyZGVlMzczMSAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFnb24v
aGV4X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CkBAIC0zNDks
NiArMzQ5LDEyIEBAIGRlZiBoZWxwZXJfYXJnKHNlbGYpOgogICAgICAgICAgICAgc2VsZi5yZWdf
dGNnKCksCiAgICAgICAgICAgICBmIntzZWxmLmhlbHBlcl9hcmdfdHlwZSgpfSB7c2VsZi5oZWxw
ZXJfYXJnX25hbWUoKX0iCiAgICAgICAgICkKKyAgICBkZWYgZnJvbV9zdWJ0eXBlKHNlbGYsIHN1
YnR5cGUpOgorICAgICAgICBpZiBzdWJ0eXBlID09ICIiOgorICAgICAgICAgICAgcmV0dXJuIHNl
bGYKKyAgICAgICAgcmFpc2UgRXhjZXB0aW9uKAorICAgICAgICAgICAgZiJ1bmtub3duIHN1YnR5
cGUgJ3tzdWJ0eXBlfScgb24gZ2VuZXJpYyBSZWdpc3RlciBjbGFzcyIpCisKIAogIwogIyBFdmVy
eSByZWdpc3RlciBpcyBlaXRoZXIgU2luZ2xlIG9yIFBhaXIgb3IgSHZ4CkBAIC0xMDcwLDExICsx
MDc2LDIyIEBAIGRlZiBpbml0X3JlZ2lzdGVycygpOgogICAgIGZvciByZWcgaW4gbmV3X3JlZ3M6
CiAgICAgICAgIG5ld19yZWdpc3RlcnNbZiJ7cmVnLnJlZ3R5cGV9e3JlZy5yZWdpZH0iXSA9IHJl
ZwogCi1kZWYgZ2V0X3JlZ2lzdGVyKHRhZywgcmVndHlwZSwgcmVnaWQpOgotICAgIGlmIGYie3Jl
Z3R5cGV9e3JlZ2lkfVYiIGluIHNlbWRpY3RbdGFnXToKLSAgICAgICAgcmV0dXJuIHJlZ2lzdGVy
c1tmIntyZWd0eXBlfXtyZWdpZH0iXQotICAgIGVsc2U6Ci0gICAgICAgIHJldHVybiBuZXdfcmVn
aXN0ZXJzW2Yie3JlZ3R5cGV9e3JlZ2lkfSJdCitkZWYgaXNfbmV3X3JlZyh0YWcsIHJlZ2lkKToK
KyAgICBpZiByZWdpZFswXSBpbiAiTk8iOgorICAgICAgICByZXR1cm4gVHJ1ZQorICAgIHJldHVy
biByZWdpZFswXSA9PSAiUCIgYW5kIFwKKyAgICAgICAgICAgZiJ7cmVnaWR9TiIgaW4gc2VtZGlj
dFt0YWddIGFuZCBcCisgICAgICAgICAgIGYie3JlZ2lkfVYiIG5vdCBpbiBzZW1kaWN0W3RhZ10K
KworZGVmIGdldF9yZWdpc3Rlcih0YWcsIHJlZ3R5cGUsIHJlZ2lkLCBzdWJ0eXBlPSIiKToKKyAg
ICByZWdpZCA9IGYie3JlZ3R5cGV9e3JlZ2lkfSIKKyAgICBpc19uZXcgPSBpc19uZXdfcmVnKHRh
ZywgcmVnaWQpCisgICAgdHJ5OgorICAgICAgICByZWcgPSBuZXdfcmVnaXN0ZXJzW3JlZ2lkXSBp
ZiBpc19uZXcgZWxzZSByZWdpc3RlcnNbcmVnaWRdCisgICAgZXhjZXB0IEtleUVycm9yOgorICAg
ICAgICByYWlzZSBFeGNlcHRpb24oZiJVbmtub3duIHsnbmV3ICcgaWYgaXNfbmV3IGVsc2UgJyd9
cmVnaXN0ZXIge3JlZ2lkfSIgK1wKKyAgICAgICAgICAgICAgICAgICAgICAgIGYiZnJvbSAne3Rh
Z30nIHdpdGggc3ludGF4ICd7c2VtZGljdFt0YWddfSciKSBmcm9tIE5vbmUKKyAgICByZXR1cm4g
cmVnLmZyb21fc3VidHlwZShzdWJ0eXBlKQogCiBkZWYgaGVscGVyX3JldF90eXBlKHRhZywgcmVn
cyk6CiAgICAgIyMgSWYgdGhlcmUgaXMgYSBzY2FsYXIgcmVzdWx0LCBpdCBpcyB0aGUgcmV0dXJu
IHR5cGUKLS0gCjIuMzQuMQoK

