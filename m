Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB68606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HMUgNlPT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FD2jwBGp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMZ9W-00022V-BU; Thu, 29 Oct 2026 19:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMZ9U-00021z-9R
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:03:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMZ9S-0004Ci-Il
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:03:20 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TLZXo11348808
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:03:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z2XigKAnuqhisUwFFhQcJu+UZdZq6svFntKehiBjvcE=; b=HMUgNlPTETHVM3Px
 f4Fl1HVPRuqJHLc29a9ajnGeFSxVNSP6nfkJ+45OoGwPoE7T6Y4r/Nl9ec2yNUu8
 qTPZFeR2UjL9BqxVc+CWWdYAVt2bHW8oXD/Orybtm9SI6QWwa5Y9xu2SIdQJxhSZ
 FDbnrQCm5YQQjc4DIxXqjqP7e3+ymVpY+wMuibxLE3nGW31IDwne/1fS17oODQ3K
 +7Brw7GoljPjDc3HEaZQeHene1KpmH7M+p32j1iz2xP9aIlaYkBMu/8m7zTw+fwF
 RRBvO+E1+J0Egl8G0IHORhyakeXbJUX7oK5QldjSoWvHI0DYnqJ3QHrgQf64mz4X
 2W1FFw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qg8pn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:03:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3552883bd19so695708eec.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 16:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793314996; x=1793919796; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z2XigKAnuqhisUwFFhQcJu+UZdZq6svFntKehiBjvcE=;
 b=FD2jwBGpOAG+uB5MABiLWlAyoE1fIwsRornxEnAKgY3TBUoDRKMJp72T+pkmdatSVo
 n/+KQzrQs/BsYIboBWM/Dij35ncMmzQfGvVnJDRYpx3V2LeRSpXM2SCUt9lo1z3Wy09R
 5sZHQ3SXyFcyyUqFo4hyq51lTOwgPvw/miJJNUBd6xkDKDc1Mr0A5RfQrd/iPJs8+evW
 3YAeuAkMqGhZnOcSfBB71/YkW2KSl63tkY4PY01tSRp24SPNa6j1wiqasgb58Ar93bkS
 CmhDM+STKSK/9HXLDw+MUchY/l5ZoXE3LaWzWmSVEszTr7jhWX0+Mz0OLnbS5snXxqbc
 oQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793314996; x=1793919796;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z2XigKAnuqhisUwFFhQcJu+UZdZq6svFntKehiBjvcE=;
 b=qmFdxUMDiXQ3R7Ddo6c3NDmy94ywmHVO2zMluW6pfss7Wagcb5nLsNIMEOVrPkdM+E
 9PZ1YT85BY36DzEfiOaNSbRmre+lDGqE0Czpwhc00YBlHuw/XewRRO0cMNL6L/RMgzM3
 72RqRneShGWZkNHMdqdMndVT8TU5LLtHwrvj/Zt7cuRhZVSzackp4Hk+oSwbkZ2XgCII
 //5b8Z7CqrmfzBsutQGGIdyiSHWAnbwbLMHfNVaDz2zukKwYUtJRQDA07wzI8FYrog8M
 364UvTT5mBKM0LOal/n+ZUXCu+2K3l2ItM/0Ywvu/SQQDP66RkNM/meq8LF7lC9JNInX
 JZzA==
X-Gm-Message-State: AFq9FYLRFTzSo1TNQDEggDeHTbh3eQBPdJXcfljCeL60LRJpVuOEq1Fa
 zzm6pkzGCUVWU2LmG0FV5MUKCv6Uqr+Rhj6XysB585iDX8O8SYHSPpIgY8jOS1OZik1QPB/fGrC
 LSz5VGGsSIHtj1Q8GARNZOrnipTh7eDWyyGXZlUfzRqUWQxwxuo5VuqmlE3S5EHyYDw==
X-Gm-Gg: AYBFou39AtG73kuN5uaba2+8DDOFKddmkkgSnbbS6DIu+enj9AcFjJztOfNGiwCssGr
 uHKKkMGPdkKE4UAJjnetEho2FTcIzOH9Leo7O8gvY++iZOyFpUHLLmLFaFrt/K65io/1V8jn1/L
 6R1p8Fs5Qbsh/h/79T+CE65vNQ/tZhQY1qQULn8lobuLZQrD5+8n0/VNv7fhJtj10krKBgGjSSe
 WntM0qwaFjQTTe7tSb/Z5Xt3orxhLcubh+IewF3DdSrW9dHtni4tyRYdUCajpTCWOiEoH1xd0PC
 cjB2rhCDXLQua9Dz9Wf/EvGX4dxpR+e8zypOiPx9PTVdFCmiwTwFF3tkbNjKGKjvx01YTa7N3+l
 Gk3PrgZgJFjpY5iitMnEFuG90NVznPrDxZQEwefSvxrLU/rAxmuSTCR7emrxAv3ebkAC25QmOGQ
 OxladBFxEJQ8380S0ncsXQ
X-Received: by 2002:a05:7022:ea51:b0:144:c112:5f24 with SMTP id
 a92af1059eb24-1ac5b028d82mr682319c88.25.1793314995774; 
 Thu, 29 Oct 2026 16:03:15 -0700 (PDT)
X-Received: by 2002:a05:7022:ea51:b0:144:c112:5f24 with SMTP id
 a92af1059eb24-1ac5b028d82mr682274c88.25.1793314995030; 
 Thu, 29 Oct 2026 16:03:15 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm2034887c88.11.2026.10.29.16.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 16:03:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 1/8] target/hexagon: add HMX attrs, state
Date: Thu, 29 Oct 2026 16:03:03 -0700
Message-Id: <20261029230310.1632334-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
References: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 5YiFSR5XtfFlkcYHDeBNFcw2_PCN87fN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA5MCBTYWx0ZWRfX092iGxGOUk7t
 VIpynj9FipH6rFKgotQuMLh08aCHHvoHr4zJ++s8ul6vlPwNXRzmOJwbV/GC2tIW5p1u1taFMnE
 wg6QdvZrYFc/tvDhTGfg3KQ96eeFaFE=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae3d0b5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=eIqSBVWmwaVrM3dqyzoA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: 5YiFSR5XtfFlkcYHDeBNFcw2_PCN87fN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA5MCBTYWx0ZWRfXzv5McM+SAm2o
 D7Ll9AQZX/ID4/dRncQgfvHhmRPu0ff5E8l6IDkgYlwT0pMhMp3tAgHB17MXQu+FDkpA7f27QZu
 UbVrzD+Il4avUgVND4Cm0UesRGQNaMiEX0m7h8Zy86V4DDX+mubhLkDmEQlAY0iC4KS+jSrK4+8
 LTVIEl1XJplQ/7s4Ce6fjQUaWGz9UryLzG+04GnqX73m3NXEiuw6M7OMXym8iPwgEnhbLTad1au
 NqydrQcoyQV/wccjWo4s3WM0t5DrUnP6Z4jTH6R1lQk6ynp7nsg6T6MDfdEd+m4Q4Xj09vINP8t
 Dc+7UbtnzxvoIZ0Bo/YFa8RzwSL8KnAFS5iFzaqcyrFRkhvAly2Iw1BeBvhvhJWlHgc05BVJSVS
 LePsWjxXYfgdTdQkMCON+KZDyA9E3OSGzRpLISGq0sxnhu1U7zFe8Kn/a8IVzx/TCzHuao9MRQs
 nOIHHHYZeQRNNO1Iivg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290090
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

QWRkIGluc3QgYXR0cmlidXRlcyBmb3IgSE1YIGFuZCBzdGF0ZSBkZWZpbml0aW9uLgoKU2lnbmVk
LW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRh
cmdldC9oZXhhZ29uL2hteF9zdGF0ZS5oICAgICAgIHwgOTIgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jIHwgMTMgKysrKysK
IDIgZmlsZXMgY2hhbmdlZCwgMTA1IGluc2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0
YXJnZXQvaGV4YWdvbi9obXhfc3RhdGUuaAoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2ht
eF9zdGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vaG14X3N0YXRlLmgKbmV3IGZpbGUgbW9kZSAxMDA2
NDQKaW5kZXggMDAwMDAwMDAwMDAuLjQzYzhjYmQ5ZTA3Ci0tLSAvZGV2L251bGwKKysrIGIvdGFy
Z2V0L2hleGFnb24vaG14X3N0YXRlLmgKQEAgLTAsMCArMSw5MiBAQAorLyoKKyAqIEhleGFnb24g
SE1YIChNYXRyaXggZVh0ZW5zaW9ucykgU3RhdGUgRGVmaW5pdGlvbnMKKyAqCisgKiBDb3B5cmln
aHQgKGMpIFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzIHN1YnNpZGlhcmll
cy4KKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKwor
I2lmbmRlZiBIRVhBR09OX0hNWF9TVEFURV9ICisjZGVmaW5lIEhFWEFHT05fSE1YX1NUQVRFX0gK
KworI2RlZmluZSBITVhfU1BBVElBTF9ESU1fRlhQICAgICA2NAorI2RlZmluZSBITVhfU1BBVElB
TF9ESU1fRlAgICAgICAzMgorI2RlZmluZSBITVhfT1VUUFVUX0NIQU5ORUxTICAgICAzMgorI2Rl
ZmluZSBITVhfTlVNX0FDQ19TRVRTICAgICAgICAyCisjZGVmaW5lIEhNWF9OVU1fQ1ZUX0FHRVMg
ICAgICAgIDMKKyNkZWZpbmUgSE1YX05VTV9CSUFTX1NFVFMgICAgICAgNAorCisjZGVmaW5lIEhN
WF9BQ1RfQ1JPVVRPTl9TSVpFICAgIDIwNDgKKyNkZWZpbmUgSE1YX0FDVF9DQUNIRV9TSVpFICAg
ICAgKDIgKiBITVhfQUNUX0NST1VUT05fU0laRSkKKwordHlwZWRlZiBzdHJ1Y3QgSG14QWNjRnhw
IHsKKyAgICBpbnQzMl90IGRhdGFbSE1YX1NQQVRJQUxfRElNX0ZYUF1bSE1YX09VVFBVVF9DSEFO
TkVMU107Cit9IEhteEFjY0Z4cDsKKworLyogRlAgYWNjdW11bGF0b3IgY2VsbCBzdG9yYWdlOiBJ
RUVFIGJpbmFyeTY0IGJpdCBwYXR0ZXJucyAqLwordHlwZWRlZiBzdHJ1Y3QgSG14QWNjRnAgewor
ICAgIHVpbnQ2NF90IGRhdGFbSE1YX1NQQVRJQUxfRElNX0ZQXVtITVhfT1VUUFVUX0NIQU5ORUxT
XTsKK30gSG14QWNjRnA7CisKK3R5cGVkZWYgc3RydWN0IEhteEFjY1NldCB7CisgICAgSG14QWNj
RnhwIGZ4cF9wcmltYXJ5OworICAgIEhteEFjY0ZwICBmcF9wcmltYXJ5OworfSBIbXhBY2NTZXQ7
CisKK3R5cGVkZWYgc3RydWN0IEhteEN2dFN0YXRlRnhwIHsKKyAgICB1aW50MTZfdCBkYXRhW0hN
WF9TUEFUSUFMX0RJTV9GWFBdW0hNWF9PVVRQVVRfQ0hBTk5FTFNdOworfSBIbXhDdnRTdGF0ZUZ4
cDsKKworLyogRlAgY29udmVydCBzbG90OiBvbmUgRlAxNiB2YWx1ZSwgb3IgYW4gRlA4IGJ5dGUg
cGVyIHNwYXRpYWwgaGFsZiAqLwordHlwZWRlZiBzdHJ1Y3QgSG14Q3Z0U3RhdGVGcCB7CisgICAg
dWludDE2X3QgZGF0YVtITVhfU1BBVElBTF9ESU1fRlBdW0hNWF9PVVRQVVRfQ0hBTk5FTFNdOwor
fSBIbXhDdnRTdGF0ZUZwOworCit0eXBlZGVmIHN0cnVjdCBIbXhTdGF0ZSB7CisgICAgSG14QWNj
U2V0IGFjY1tITVhfTlVNX0FDQ19TRVRTXTsKKworICAgIEhteEN2dFN0YXRlRnhwIGN2dF9meHBb
SE1YX05VTV9DVlRfQUdFU107CisgICAgSG14Q3Z0U3RhdGVGcCAgY3Z0X2ZwW0hNWF9OVU1fQ1ZU
X0FHRVNdOworCisgICAgSG14Q3Z0U3RhdGVGeHAgY3Z0X2Z1dHVyZV9meHA7CisKKyAgICB1aW50
NjRfdCBiaWFzX3Jhd1tITVhfTlVNX0JJQVNfU0VUU11bSE1YX09VVFBVVF9DSEFOTkVMU107CisK
KyAgICB1aW50MzJfdCBjdXJyZW50X2FjY19zZXQ7CisKKyAgICB1aW50OF90IGFjdF9idWZmZXJb
SE1YX0FDVF9DQUNIRV9TSVpFXTsKKworICAgIHVpbnQzMl90IGFjdF9yczsKKyAgICB1aW50MzJf
dCBhY3RfdHlwZTsKKyAgICB1aW50OF90ICBpc19mOF9vZGQ7ICAgICAvKiBSc1swXTogRlA4IGFj
dGl2YXRpb24gcmVhZHMgb2RkIGJ5dGUgb2YgcGFpciAqLworICAgIHVpbnQ4X3QgIGZwOF9vZGRf
c2VsOyAgIC8qIGN2dCBSc1sxMV06IEZQOCBjb252ZXJ0IHdyaXRlcyBvZGQgKDEpIGhhbGYgKi8K
KworICAgIHVpbnQzMl90IGZvcm1hdF9vZmZzZXQ7ICAgICAvKiBTTT0yLCBETT0wICovCisgICAg
dWludDMyX3QgdGlsZV94X21hc2s7CisgICAgdWludDMyX3QgdGlsZV95X21hc2s7CisgICAgdWlu
dDMyX3QgdGlsZV94X2luYzsKKyAgICB1aW50MzJfdCB0aWxlX3lfaW5jOworICAgIHVpbnQzMl90
IGZ4OworICAgIHVpbnQzMl90IGZ5OworICAgIGludDMyX3QgIGNoX3N0YXJ0OyAgICAgICAgICAv
KiBwcmUtY29tcHV0ZWQgY2hhbm5lbCBzdGFydCAocmF3KSAqLworICAgIGludDMyX3QgIGNoX3N0
b3A7ICAgICAgICAgICAvKiBwcmUtY29tcHV0ZWQgY2hhbm5lbCBzdG9wIChleGNsdXNpdmUpICov
CisgICAgdWludDMyX3QgeV9zdGFydDsKKyAgICB1aW50MzJfdCB5X3N0b3A7CisgICAgdWludDMy
X3QgeV9kaWxhdGU7CisgICAgdWludDMyX3QgYmxvY2tzOworICAgIGludDMyX3QgIGRZOyAgICAg
ICAgICAgICAgICAvKiBvZmZzZXQgdG8gc2Vjb25kIGFjdGl2YXRpb24gY3JvdXRvbiAqLworICAg
IHVpbnQzMl90IGdyb3VwX2NvbnY7ICAgICAgICAvKiBjaF9zdGFydCA+IGNoX3N0b3AgKi8KKyAg
ICB1aW50MzJfdCBncm91cF9zaXplOworICAgIHVpbnQzMl90IGdyb3VwX2NvdW50OworCisgICAg
aW50MzJfdCAgbWFjX2N5Y2xlX2xpbWl0OworCisgICAgLyogRGVmZXJyZWQgQ1ZUIHBpcGVsaW5l
IGNvbW1pdCwgYXQgdGhlIG5leHQgY29uc3VtZXIgb3IgZW5kIG9mIHBhY2tldCAqLworICAgIHVp
bnQzMl90IGN2dF9meHBfcGVuZGluZzsgICAgICAvKiAxID0gZnV0dXJlIGhhcyB1bmNvbW1pdHRl
ZCBkYXRhICovCisgICAgdWludDMyX3QgY3Z0X2Z4cF9wZW5kaW5nX2FnZTsgIC8qIDEgPSBwaXBl
bGluZSBzaG91bGQgYWdlIGF0IGNvbW1pdCAqLworCisgICAgLyogRGVmZXJyZWQgYWNjdW11bGF0
b3IgY2xlYXIvZmxpcCwgYXQgcGFja2V0IGVuZCBvciBuZXh0IGFjY3VtdWxhdG9yIHVzZSAqLwor
ICAgIHVpbnQzMl90IGN2dF9hY2NfY2xlYXJfcGVuZGluZzsKKyAgICB1aW50MzJfdCBjdnRfYWNj
X2NsZWFyX3NldDsKK30gSG14U3RhdGU7CisKKyNlbmRpZiAvKiBIRVhBR09OX0hNWF9TVEFURV9I
ICovCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYyBiL3Rhcmdl
dC9oZXhhZ29uL2F0dHJpYnNfZGVmLmguaW5jCmluZGV4IDk2YWQxZmQyZjhlLi40MzlhMjY4YjU5
MSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vYXR0cmlic19kZWYuaC5pbmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vYXR0cmlic19kZWYuaC5pbmMKQEAgLTIxMCw1ICsyMTAsMTggQEAgREVGX0FU
VFJJQihIVlhfSUVFRV9GUF9PVVRfMzIsICJIVlggSUVFRSBGUCAzMi1iaXQgb3V0cHV0IiwgIiIs
ICIiKQogREVGX0FUVFJJQihDVklfVlhfTk9fVE1QX0xELCAiSFZYIG11bHRpcGx5IHdpdGhvdXQg
dG1wIGxvYWQiLCAiIiwgIiIpCiBERUZfQVRUUklCKEhWWF9GTFQsICJUaGlzIGEgZmxvYXRpbmcg
cG9pbnQgSFZYIGluc3RydWN0aW9uLiIsICIiLCAiIikKIAorREVGX0FUVFJJQihTSEFSRURfRVhU
RU5TSU9OLCAiU2hhcmVkIGV4dGVuc2lvbiBpbnN0cnVjdGlvbiIsICIiLCAiIikKK0RFRl9BVFRS
SUIoRUFfUkVHX09OTFksICJFQSA9IGlucHV0IHJlZ2lzdGVyIG9ubHkiLCAiIiwgIiIpCitERUZf
QVRUUklCKEVBX1BBR0VDUk9TUywgIkVBIGNhbGN1bGF0aW9uIGNhbiBoYXZlIGEgUGFnZSBDcm9z
cyBTdGFsbCIsICIiLCAiIikKK0RFRl9BVFRSSUIoTVBZLCAiSGFzIGEgbXVsdGlwbHkiLCAiIiwg
IiIpCitERUZfQVRUUklCKFBBSVJfMU9GMiwgIkZvciBhc3NlbWJsZXIiLCAiIiwgIiIpCitERUZf
QVRUUklCKFBBSVJfMk9GMiwgIkZvciBhc3NlbWJsZXIiLCAiIiwgIiIpCitERUZfQVRUUklCKEhN
WCwgIkhNWCBjb3Byb2Nlc3NvciBpbnN0cnVjdGlvbiIsICIiLCAiIikKK0RFRl9BVFRSSUIoSE1Y
X0NWVCwgIkhNWCBjb252ZXJ0IGluc3RydWN0aW9uIiwgIiIsICIiKQorREVGX0FUVFJJQihITVhf
RkxULCAiSE1YIGZsb2F0aW5nLXBvaW50IGluc3RydWN0aW9uIiwgIiIsICIiKQorREVGX0FUVFJJ
QihITVhfQ1VfU0NBTEFSLCAiSE1YIHNjYWxhciBvcGVyYW5kIiwgIiIsICIiKQorREVGX0FUVFJJ
QihITVhfQkxPQ0tfQUxJR04sICJITVggYmxvY2stYWxpZ25lZCBhY2Nlc3MiLCAiIiwgIiIpCitE
RUZfQVRUUklCKEhNWF8xMjhCX0FMSUdOLCAiSE1YIDEyOC1ieXRlIGFsaWduZWQgYWNjZXNzIiwg
IiIsICIiKQorCiAvKiBLZWVwIHRoaXMgYXMgdGhlIGxhc3QgYXR0cmlidXRlOiAqLwogREVGX0FU
VFJJQihaWl9MQVNUQVRUUklCLCAiTGFzdCBhdHRyaWJ1dGUgaW4gdGhlIGZpbGUiLCAiIiwgIiIp
Ci0tIAoyLjM0LjEKCg==

