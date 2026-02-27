Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1AAFEFB51
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4Zo-0006m2-Q0; Fri, 27 Feb 2026 15:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zm-0006l7-Bb
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:42 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zj-0006nN-R2
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:42 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RIejrL373359
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NLem7dzS2/UxKAytBWCpP9voigW0PRMqSjkapE2L9Co=; b=n6nEx4dLECFUpR42
 EOTxGEckr3RNgabX3B+tlsiwEImotvZSy3JIXtYWSh+g6NaGdgyQ17kw7x3uYOFO
 rJ/6/0VTyl7PUPllpvjLetfBX9O3fplMtwBg1AB6jjbgq7sWL8RVyiG2ECIT1U/W
 MixKX8j+NyUG3aqBvMX/jD7Lj8Bp/aa89PRipOMpXV1lyY/wp0QFrkzlQqbxAiYm
 cV6UTaNJZ5jlSOggXZRPPaEnlQrwNkG+90RXj2jsX3UEUEEE1WbX+6ZaGSbRrfyA
 rPJ2KT7xTSnEQnW2b9OTqrFPPqW3h1DAyYwof/dDuq4mus1DuiD7DOjyAIJDcM7j
 gVDhBQ==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckgrtratj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:38 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-679c6ef1538so51004384eaf.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224597; x=1772829397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLem7dzS2/UxKAytBWCpP9voigW0PRMqSjkapE2L9Co=;
 b=cH25hPO2mCmsaJFrUyYuK10mPEa5IPMdNaqbdxN1wOMby13j+rjyrDoHIabmhev34U
 dXpdIt+b5smfk/m7m+iWpN8hrosEUi9+rDu1GYJlAU5X7zArWApK23TMDhgRLQBgEjq1
 YuNdFdlsLhpOdFKixwezlqKd1anYteMJShCDYyDQ904Gu8J2F+Ds0Nf1X7KgcSemjn+V
 789K0B1qzKvEt5BALUv6N7Ba/kPCA3BREPU04sHg8YN78v8P2KCIH+LxS4DxfywLw3/8
 WHHOlrlcXKvy3MpuKG6tDS5TfunIK2DD2bziA9VGt9CeREILAXHP2mwUSxybAL+A0EaO
 XhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224597; x=1772829397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NLem7dzS2/UxKAytBWCpP9voigW0PRMqSjkapE2L9Co=;
 b=m+hCnEu0Mhi0F835OIzvICEpHQxirXPrHXKLM3RHvtD7ftV+sFrR6I86Ay1U0aKw0v
 cxk5AdA3fnTgxRmetoUocTsGJUi5jCmhyEiTon0xG2cQwYoneQ54UYMyPEGwo4dYx+GS
 YeOaM019MFRIrjpN//g3RP8OI3r98t40TBYRasfaWSkpAHyEPpz+i/db+VprKj76wD94
 zxJAg/BZTnUwxh1bSi/Ei4eh/S2xyRiBk+5iFZmBkxdEBZg4/3Jickn2sJYNXO+iV16E
 bPxJtLTywwNn7WVGjDB8TpLgIaUW4FrnQoY3VxU0RP5q6CcKmfr1ePz72WaCvArMTP6/
 OgoA==
X-Gm-Message-State: AOJu0YzJE49I1wcbcuQ1DwrsGWU2+cnFZlv/AHDLGOzonEspuz47nONv
 4NMtXCOfA+sdUYhpCTiwswVVkJeuLtnZUC/TkYdmiddeTANdHH/nSarl1vqBPr/LCLPE6vmmUjH
 eRDhNZ9WHaUXvqbxnfMcP6ESR5J2A/D2AeCVPCdwYWaPwqUffCJIMjzreGK602kMAYg==
X-Gm-Gg: ATEYQzznDhPZuTdyTw7BrwhUBFPJcY0E7RdRdqRRkIbiWIJM37y/Q/UftjND/33qRD9
 9v4CVCpO0kU0octqa6/rRDnBkgm5GagTmN4+wuiqWIhOUd6MqkcN0MciJtzPs2ShPqbC5nwdmyA
 JaiVC1K90zMTIvrPTYiMvOYpO1yh17eCzN1eupfuA0dMMB7AzIaBGumPmMUdt0/znf+VJaYMfPH
 hAI1nqjby315Mu7kaBLhruPVjYFbdGSNoR3L3nX0svP0gACWoqEkOI5D5n7xgG7RbHeLaTTrWVw
 akZuOcvuZAm3UAERH4c40y3YH1S2Sq+llUz2msO7ZZE26rIntD4uLtQYJ8g6/MxoWgrar5vgl8c
 I52XkXX9UnpRH17QdQvaTqnbcOIIu63XXjLR4gWlpTivGanB8sKobGYUZjQewErPh1HTXYw==
X-Received: by 2002:a05:6820:f031:b0:662:f61e:75a8 with SMTP id
 006d021491bc7-679faf7f00emr2703055eaf.65.1772224597521; 
 Fri, 27 Feb 2026 12:36:37 -0800 (PST)
X-Received: by 2002:a05:6820:f031:b0:662:f61e:75a8 with SMTP id
 006d021491bc7-679faf7f00emr2703029eaf.65.1772224597124; 
 Fri, 27 Feb 2026 12:36:37 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:36:36 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 02/37] docs/system: Add hexagon CPU emulation
Date: Fri, 27 Feb 2026 12:35:52 -0800
Message-Id: <20260227203627.932864-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=C8jkCAP+ c=1 sm=1 tr=0 ts=69a20056 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=2pVdXvZyqgCw3DkElpQA:9 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: EU__QdDsZF1j2svAaE0CDvy5J7qffi7u
X-Proofpoint-ORIG-GUID: EU__QdDsZF1j2svAaE0CDvy5J7qffi7u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX0o01vyH2Cl0C
 +mUMVcgoeTWWBSPybufqHntbwaWiUTFVHNNZqnKNwXoRVywTTjAMak4h/isIj2A0mS3U2uiAM9e
 5AdVUy3oGZVGb0Op8+MAkVkjjVOtg4IeirUDNvaRzVB4iiRhDZifLO8505IePjb1WMWiUBrKywq
 aGnfrmPjaVNlJpAAlIy5eETyVrCDIJDP7jfrBdKC/NjQUqIg4DAOQ+vGDgBwpwBzvVpV33poUAw
 Q4NJ+QmyLt6nqnYxQewmeTn+7sdULX75jK3Ymn55jAeuoq7BSsFh4sITY8DlKU7rl/OyJPDo321
 rLW9BeFD3jO6axdjLNPg2yeA2l8A4wNTWmf56JilAPdpIBacwD5dck/MrTcY/YpLe/dOTvcT9ro
 jMonBjYemq3dTk8coY/QDrz7KxEKlCn2Ru2p1zisDjY7fHTohyPd96Q2nh+YIXsP+Cz1WjptDcG
 8ApY1p98C1FmaGVbivg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIE1BSU5UQUlORVJTICAgICAg
ICAgICAgICAgICAgICAgICB8ICAyICstCiBkb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5y
c3QgfCAxNSArKysrKysrKysrKysrKysKIGRvY3Mvc3lzdGVtL3RhcmdldC1oZXhhZ29uLnJzdCAg
ICB8ICAxICsKIDMgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdAoK
ZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKaW5kZXggNjljYjZiOGE3YjUu
LjM4Y2NlYTk2YjkzIDEwMDY0NAotLS0gYS9NQUlOVEFJTkVSUworKysgYi9NQUlOVEFJTkVSUwpA
QCAtMjQ3LDcgKzI0Nyw3IEBAIEY6IGNvbmZpZ3MvdGFyZ2V0cy9oZXhhZ29uLWxpbnV4LXVzZXIv
ZGVmYXVsdC5tYWsKIEY6IGRvY2tlci9kb2NrZXJmaWxlcy9kZWJpYW4taGV4YWdvbi1jcm9zcy5k
b2NrZXIKIEY6IGdkYi14bWwvaGV4YWdvbioueG1sCiBGOiBkb2NzL3N5c3RlbS90YXJnZXQtaGV4
YWdvbi5yc3QKLUY6IGRvY3Mvc3lzdGVtL2hleGFnb24vY2RzcC5yc3QKK0Y6IGRvY3Mvc3lzdGVt
L2hleGFnb24vCiBGOiBkb2NzL2RldmVsL2hleGFnb24tc3lzLnJzdAogVDogZ2l0IGh0dHBzOi8v
Z2l0aHViLmNvbS9xdWljL3FlbXUuZ2l0IGhleC1uZXh0CiAKZGlmZiAtLWdpdCBhL2RvY3Mvc3lz
dGVtL2hleGFnb24vZW11bGF0aW9uLnJzdCBiL2RvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9u
LnJzdApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uMzZmNTRmMDU4YWYK
LS0tIC9kZXYvbnVsbAorKysgYi9kb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QKQEAg
LTAsMCArMSwxNSBAQAorLi4gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXIKKworLi4gX0hleGFnb24gRW11bGF0aW9uOgorCitIZXhhZ29uIENQVSBhcmNoaXRlY3R1cmUg
c3VwcG9ydAorPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KKworUUVNVSdzIFRDRyBl
bXVsYXRpb24gaW5jbHVkZXMgc3VwcG9ydCBmb3IgdjY1LCB2NjYsIHY2NywgdjY4LCB2NjksIHY3
MSwgdjczLgorSXQgYWxzbyBoYXMgc3VwcG9ydCBmb3IgdGhlIGZvbGxvd2luZyBhcmNoaXRlY3R1
cmUgZXh0ZW5zaW9uczoKKworLSBIVlggKEhleGFnb24gVmVjdG9yIGVYdGVuc2lvbnMpCisKK0Zv
ciBpbmZvcm1hdGlvbiBvbiB0aGUgc3BlY2lmaWNzIG9mIHRoZSBIVlggZXh0ZW5zaW9uLCBwbGVh
c2UgcmVmZXIKK3RvIHRoZSBgUXVhbGNvbW0gSGV4YWdvbiBWNzMgSFZYIFByb2dyYW1tZXIncyBS
ZWZlcmVuY2UgTWFudWFsCis8aHR0cHM6Ly9kb2NzLnF1YWxjb21tLmNvbS9idW5kbGUvcHVibGlj
cmVzb3VyY2UvODAtTjIwNDAtNTMucGRmPmBfLgpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vdGFy
Z2V0LWhleGFnb24ucnN0IGIvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0CmluZGV4IDVm
NzA4NGE2YTA4Li40MTZiOGY3YmU3NiAxMDA2NDQKLS0tIGEvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhl
eGFnb24ucnN0CisrKyBiL2RvY3Mvc3lzdGVtL3RhcmdldC1oZXhhZ29uLnJzdApAQCAtOTgsNSAr
OTgsNiBAQCBpcyBub3QgeWV0IGltcGxlbWVudGVkIGluIFFFTVUgaGV4YWdvbi4KIEhleGFnb24g
RmVhdHVyZXMKID09PT09PT09PT09PT09PT0KIC4uIHRvY3RyZWU6OgorICAgaGV4YWdvbi9lbXVs
YXRpb24KICAgIGhleGFnb24vY2RzcAogCi0tIAoyLjM0LjEKCg==

