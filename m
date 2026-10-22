Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E3B60A3814
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fj1NBCny;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dZk5MOfq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJxb1-0006HC-Fb; Thu, 22 Oct 2026 14:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJxa2-0006BH-Eq
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 14:31:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJxa0-0002cz-Ib
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 14:31:58 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtSc0387583
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HH0OoexitI9I4wIBBsFHRBvPau94eWbdbLKDtFWOYtQ=; b=fj1NBCnyAfvSYeoN
 Me8TPE8iU22cmedMdJH1oF/UnGQSPWzxAKgCpsqBYfoEbfmCYI0lvwPOF+iX6hkM
 5t2TcNxPYHASAY1zHMXJ49lCMnlh66boV92LREh0VemS4kJD0LtMBniiOI4AB5P1
 a51Wnp6bPHSuCE0n4fZKOUJa/QyFzrLk0O2HMbE2+ZUjZZgr6ohj9MXIX1qicWLU
 AK5jrz8nzu4Q2IRQ9qPLVY2e3qZcvyElGTqcLJ+uaVRheQGsNbBCANJn50oSfbfE
 rw1yyVwWaBLsE2KFZpXPFawReYeL7iRscwAwTBKrqFD4X1JwmB1zkKQLH94g5Tt8
 LhzrAw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq42sq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:31:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-351788121cfso393814eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 11:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792693914; x=1793298714; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HH0OoexitI9I4wIBBsFHRBvPau94eWbdbLKDtFWOYtQ=;
 b=dZk5MOfqxRTNF+WThwWpIUgPrSgsVpn8w8w0XUnkJK6XeGHGMOiES8Fn4h7Xn/S20b
 s6u/iSI32tc9IYfYPfUfUtAp+SmcQ+e98VnRrZFhZj5VUOKp0JQy1blWRSKtltESlkaY
 Gm8zs8x5ES76gGxp1GaZcOZcXy6B400wUo+Mja3qlEuHJn0ysOe9U4X5CzCJqQqqQnHS
 1bi/br9kRmRId33/89XDQVXzJgqjZePG9DLbF/VXVsUwRMQsJBY87zJU4qoRwz1+Gszq
 CaPtPTBdOuFJuSGMxFJdOhwgGDIDE0gdtJZ0KpglIGwRMgaLYXqUaJgT5vcrTPwhWr2F
 L6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792693914; x=1793298714;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HH0OoexitI9I4wIBBsFHRBvPau94eWbdbLKDtFWOYtQ=;
 b=qgiuOmTVpn1svbJQ60qrABr8/5jmru14vD8w7SpniBwCjNjZexd4DusCGgINBe6zDR
 f97nUusY0wXbgUaP4i2ZWerztX7nH1jVX6Up4AvLuleCTTp0URtI+9oBTaP1MkVwkbTo
 PzF3WFOnQFJW7vauZIPMcU2EiCTskcrevTtyyfqnt2vyr4czlpjoGYxd9vbIJGJWqGmk
 7NSoaEleSxumjGLr37SBACWQXS5Q4LtwlCmJ6Xk//+63ek39LUoG9nKTh0e3uJwTBsVE
 Irpz9LbaauYEAzxAqZPUnrIXRxiP8jLRJnObZZLFuKWun+D4hB3g6/nr/r45pLk+6O2+
 Ooeg==
X-Gm-Message-State: AFq9FYKrDdnXAG4Yq4txEKBWf4ZDdG+5x4MQfRXRt7jz3QN4qpV/M9vg
 fJCygryVnqP4ggDmDMpVuL/RbgRwyAl5PlkDrGfrV/73wJUIq0vJfFTCaYGbtyZvvxm3N3uK3xk
 SUj/vEzRLSWdDehCAjGH+a4rrJsV3fAKbCcDFqy48KAcopWfAXa6jweAuKi8yVxPnwQ==
X-Gm-Gg: AYBFou1uEPQDjNr2G1B0WZnKrVWYdn3J3fMe1qgzVEv1NREdW9XPrq9Oj+SWguvEfTI
 S9TM+VxF/VixH9j0Lc5pRARIvWHMoQ08EszzQ9v3c42PGqXe1zI6Fw9ct4I12Y85DEZAe8T1syh
 pNtn7gPN1RvZqkqb8KbXyD8PyGbPTPu9syyTq2W3e18SajhFdvI8p28sGvujAG9reyiPmn/7gTH
 v75nzYJZiNQPZTlMWhS7XSmPaqxjUGXf6PrZr7HArhz4zYG9l1H5nv08rBEOmXqVocxElOs1SDY
 DG1Be5NLVCm3CWI8Al5/0GWbZ3XOt4dcc6KUf/oFzvtRXb/VHVeosxP7phXZ3zrY31TFL5sE+QL
 wLHsxgqgAABt//1/iiKd6zjM6gJk3oJ9/U4J1zg6kFpGNZX3l
X-Received: by 2002:a05:7301:9a8d:b0:35f:f0:8edf with SMTP id
 5a478bee46e88-3674d84d2aamr6924551eec.13.1792693913869; 
 Thu, 22 Oct 2026 11:31:53 -0700 (PDT)
X-Received: by 2002:a05:7301:9a8d:b0:35f:f0:8edf with SMTP id
 5a478bee46e88-3674d84d2aamr6924521eec.13.1792693913223; 
 Thu, 22 Oct 2026 11:31:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d8f8eaf9sm44962eec.16.2026.10.22.11.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 11:31:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v4 02/11] Hexagon: add v85 CPU model
Date: Thu, 22 Oct 2026 11:31:38 -0700
Message-Id: <20261022183147.1535585-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022183147.1535585-1-brian.cain@oss.qualcomm.com>
References: <20261022183147.1535585-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: A1WE6waRB4gm40xDIrQl5IsGD1vPnLmk
X-Proofpoint-ORIG-GUID: A1WE6waRB4gm40xDIrQl5IsGD1vPnLmk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3MyBTYWx0ZWRfX5H9SGaNdXCXT
 PLDOoAJOtxBAPiCHRdAxOorsVRgV8pg5eAXPvhwi/fJ6P0c9LOGrmeKWqYvVoMeMtLNljthe2/V
 ziQ+L9LezUhFkaP/ipd/d5PGyE5AVG4=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada569a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=6RDhHJMOdHl8aUYkYD8A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3MyBTYWx0ZWRfX97fC8utlRQIr
 B/zsFlz0xyeHvjp4yOfOwzTqKnQoNbUV9yUNSfrBY6n8qpbnTHg0Ea2OUamlulsEgVaVtF5PnfT
 B5k1FuXtp43upjjWPK33+/Id/BOEm5oalHQAVzIa07VgIZgGbEAYkwkJ9QpqRMgTMmKBAN1T+vC
 ytnXrMPjYMyG8rZ/GhQUzckMREsT2zJrixatV1TP9YcgQ1KLGr2WVbk9Kb+V+WBiDne20mbAbyo
 8kYEyYZMd5bKJYbXCscWYzrmxFhk7aLCdj6A+IqJWcTe3mRHy0OozhBWjLHrGHoHWmMzxmz21Eb
 4pcHWDnT2SBZ5Tbwo0ud2ZVXBRaiNirsWQIlGigETm7HyL+gmOvtOZCcpIeZJIBmqmo0PVUtQIs
 LslZbLH6IzkzBzcYbh//Ro9LCFqeVl00QPJ4sY/KuG0N/xw4LHKtVpCrbDc7tk3DUnWkpPv/HLV
 cccbKxEDvKUeubfK+Zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220073
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFs
Y29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBkb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QgfCAyICstCiB0
YXJnZXQvaGV4YWdvbi9jcHUtcW9tLmggICAgICAgICAgfCA0ICsrKysKIGxpbnV4LXVzZXIvaGV4
YWdvbi9lbGZsb2FkLmMgICAgICB8IDQgKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAg
ICAgICAgIHwgMiArKwogNCBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0IGIv
ZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0CmluZGV4IDEyMzg1MzExYWE0Li5mYjU3
Yzc3YWU5MCAxMDA2NDQKLS0tIGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0Cisr
KyBiL2RvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdApAQCAtNiw3ICs2LDcgQEAgSGV4
YWdvbiBDUFUgYXJjaGl0ZWN0dXJlIHN1cHBvcnQKID09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09CiAKIFFFTVUncyBUQ0cgZW11bGF0aW9uIGluY2x1ZGVzIHN1cHBvcnQgZm9yIHY2NSwg
djY2LCB2NjcsIHY2OCwgdjY5LCB2NzEsIHY3MywKLXY3NSwgdjc3LCB2NzksIHY4MS4KK3Y3NSwg
djc3LCB2NzksIHY4MSwgdjgzLCB2ODUuCiBJdCBhbHNvIGhhcyBzdXBwb3J0IGZvciB0aGUgZm9s
bG93aW5nIGFyY2hpdGVjdHVyZSBleHRlbnNpb25zOgogCiAtIEhWWCAoSGV4YWdvbiBWZWN0b3Ig
ZVh0ZW5zaW9ucykKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS1xb20uaCBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS1xb20uaAppbmRleCAyYmZhNGQ1ZDBmYy4uZDRjODQxM2RlZDMgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS1xb20uaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUt
cW9tLmgKQEAgLTI4LDYgKzI4LDggQEAgdHlwZWRlZiBlbnVtIHsKICAgICBIRVhfVkVSX1Y3NSA9
IDB4NzUsCiAgICAgSEVYX1ZFUl9WNzkgPSAweDc5LAogICAgIEhFWF9WRVJfVjgxID0gMHg4MSwK
KyAgICBIRVhfVkVSX1Y4MyA9IDB4ODMsCisgICAgSEVYX1ZFUl9WODUgPSAweDg1LAogICAgIEhF
WF9WRVJfQU5ZID0gMHhmZiwKIH0gSGV4YWdvblZlcnNpb247CiAKQEAgLTU1LDYgKzU3LDggQEAg
dHlwZWRlZiBzdHJ1Y3QgewogI2RlZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y3NSBIRVhBR09OX0NQ
VV9UWVBFX05BTUUoInY3NSIpCiAjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjc5IEhFWEFHT05f
Q1BVX1RZUEVfTkFNRSgidjc5IikKICNkZWZpbmUgVFlQRV9IRVhBR09OX0NQVV9WODEgSEVYQUdP
Tl9DUFVfVFlQRV9OQU1FKCJ2ODEiKQorI2RlZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y4MyBIRVhB
R09OX0NQVV9UWVBFX05BTUUoInY4MyIpCisjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjg1IEhF
WEFHT05fQ1BVX1RZUEVfTkFNRSgidjg1IikKIAogT0JKRUNUX0RFQ0xBUkVfQ1BVX1RZUEUoSGV4
YWdvbkNQVSwgSGV4YWdvbkNQVUNsYXNzLCBIRVhBR09OX0NQVSkKIApkaWZmIC0tZ2l0IGEvbGlu
dXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyBiL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMK
aW5kZXggM2E2YmE0ZTEzMDQuLjlmOThhZDhmYjg2IDEwMDY0NAotLS0gYS9saW51eC11c2VyL2hl
eGFnb24vZWxmbG9hZC5jCisrKyBiL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMKQEAgLTEx
Myw2ICsxMTMsMTAgQEAgY29uc3QgY2hhciAqZ2V0X2VsZl9jcHVfbW9kZWwodWludDMyX3QgZWZs
YWdzKQogICAgICAgICByZXR1cm4gInY3OSI7CiAgICAgY2FzZSAweDgxOgogICAgICAgICByZXR1
cm4gInY4MSI7CisgICAgY2FzZSAweDgzOgorICAgICAgICByZXR1cm4gInY4MyI7CisgICAgY2Fz
ZSAweDg1OgorICAgICAgICByZXR1cm4gInY4NSI7CiAgICAgfQogCiAgICAgZXJyID0gc25wcmlu
dGYoYnVmLCBzaXplb2YoYnVmKSwgInVua25vd24gKDB4JXgpIiwgZWZsYWdzKTsKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggZjIw
ZDZkZTZmNjMuLjFlM2RmNWQwZDAzIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYwor
KysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtOTM0LDYgKzkzNCw4IEBAIHN0YXRpYyBjb25z
dCBUeXBlSW5mbyBoZXhhZ29uX2NwdV90eXBlX2luZm9zW10gPSB7CiAgICAgREVGSU5FX0NQVShU
WVBFX0hFWEFHT05fQ1BVX1Y3NSwgICAgICAgICAgICAgIEhFWF9WRVJfVjc1KSwKICAgICBERUZJ
TkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjc5LCAgICAgICAgICAgICAgSEVYX1ZFUl9WNzkpLAog
ICAgIERFRklORV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WODEsICAgICAgICAgICAgICBIRVhfVkVS
X1Y4MSksCisgICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y4MywgICAgICAgICAgICAg
IEhFWF9WRVJfVjgzKSwKKyAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjg1LCAgICAg
ICAgICAgICAgSEVYX1ZFUl9WODUpLAogfTsKIAogREVGSU5FX1RZUEVTKGhleGFnb25fY3B1X3R5
cGVfaW5mb3MpCi0tIAoyLjM0LjEKCg==

