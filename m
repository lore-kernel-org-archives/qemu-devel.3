Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D719BCD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY3W-0002i3-6j; Thu, 11 Jun 2026 01:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2y-0001jV-PG
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2v-0002kn-Ni
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GPjT3835129
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=; b=LmdZ4LIwp6oNfg7A
 BDvS6osx9UVJpDzbdMC9suLIqTxkZoTsygBWjLjnvfTeDkX/0ej2SGh1rWbQIutt
 XMDO+Ek/RHi4h94aeCVD7NFhyK/gmU/fJsps/7Ju5Dsn0kdfHkaKK1WEEX/uCgCw
 lRckTAUeYhU9c+6HyDEjzhHgafCgPFRGa1XanV0vPmGEfR6zjtA43uSsLei1tjmL
 xerl5898dU4XYcZOdJbefHYEaOUeHxehDsPhNPqD3aZnjbz4F7xqrH+CRbqWxJH+
 Ra3aDyTPME/1r/J61CAzavLsyzUpkY3IdRofJ/XwKJ7Xiu30c2GlNRSArLb8IKUF
 pRnwfw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6thspg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:28 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so10602749eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781156008; x=1781760808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=;
 b=AijAevaNwKeZFIeTz9X5huxuBJh/7Xiz51cHDB1IPB4N9RWoY8YGBUABnGUBcRR5oo
 vNa70hEgbQidQQO1AiNGB8eOXCYjvikOdNJDPIHNzr58m72uQQokRKKN/dWvWHqqyPU4
 NeODdZsStJvkuqeeVXRbP6cdlTob62dXRIeQqf9uGlmnXZcUFN5DlPcPOowAczkZBMz8
 NBkIQg+3WiztEPw37RqtWAlgcFDI7mMzFNSQZh3Kn/qHd03ZMkF+jN/pFy492PaQ+1Dq
 IocnCELQte8PuntbemSx9b70q06M623ya1yTQPptqcJICheKUtFD7Vr3YJOFyk+HOE/e
 Holw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156008; x=1781760808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WSxBtQ42d1TB+r/kba+VA2NNeVAZKwGKrYR4H+pwBnA=;
 b=PafYFQtoLt9MNNvCaPjBTmzQGt0EY4nD/cs675zuMl+ChXrImTrfJv6R6IuDWAindN
 YABS8Zf7QFm+rtu4b7fQGWFXil+ok087j+GKyXVnBpABBgZ1PRNHlNrlwfcZ+g0xmocz
 TXsYcZAnVQvZdRX1YfW1/fqQUDGFFPSWky0ECmQcoMYexkCw9WgW0I7B2ZATj78+JWbY
 W/lV/aG9a2uFnTI7+/vOYZ4UE5BMe+0W0LClIjDMfuP1ZSeu0dRzyKcvwdt7N6YXca6E
 uiBhZAFlVFdDM3jpACYzcTM50nPFMSSjkLtcOsbxf2KZKDa/735tM//OkeJx75fCZjB5
 8KLQ==
X-Gm-Message-State: AOJu0Yw+k2AckcmqJVvjXU9w4rv9p4Db14S1xjF8cfCD9V6Qno2P6aZ0
 dNFsO/6REP1n5DeM24qPQ8RuS4naqatKaUrwJAcL262JZtSfnkC4/4sNZS9Tn6mms5YfVTDDCLr
 KoCucmEc3GoDTLtbaE9TBJKjkvXBALa+UzQvG6GFquOqCfiuAYYWJJYSRjSUlqKB7CQ==
X-Gm-Gg: Acq92OEo6um5uL1ZXdZP2vKnh99Zy1Ulprff6PZJe+LmCEazgZbJhnP9mn6wUW/84ZN
 hfuIebnUNNXuzQC1VFkhv1xaxu9CY+ke9QEVDmkyRl5zJaxZR3tnXHICFtEbRbRIjHBHBy0P/QG
 k2CWaMB6amnwecSsQ0x6EspOsUT+BLrj5aXNX67qGICfCLm7fR9vZPoeNslMs4S9ol9XsBmlPHj
 bpfvKrtA9RpcGL4ungnnVU+LzAgWkdzxfawUP82rBq6jfEFMKXfAqyU3iOvvbbKNR1Z7svRrl2c
 GIS+OR1EfJAK2QVvg//wgnLcOWyvCZRl0JctQzqFkoCZgjIjia4Xh2Zgobrm5ALcPX9SYrQqsmv
 ljn0sAtFsQXuTapXBlPXVclkRblpEGipEwOXSCkcuKxZ7m68U6wsDHSdsSwgl/esKQF5iWhix4H
 cuqhzp
X-Received: by 2002:a05:7300:b209:b0:307:43ff:f32e with SMTP id
 5a478bee46e88-30804bc1af6mr946431eec.32.1781156008161; 
 Wed, 10 Jun 2026 22:33:28 -0700 (PDT)
X-Received: by 2002:a05:7300:b209:b0:307:43ff:f32e with SMTP id
 5a478bee46e88-30804bc1af6mr946416eec.32.1781156007721; 
 Wed, 10 Jun 2026 22:33:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: Add implicit sysreg writes
Date: Wed, 10 Jun 2026 22:32:43 -0700
Message-Id: <20260611053249.3918491-23-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX2HfDzzwX6dJl
 Yes33nmjJKyDjfcqtl+C/g8kNSjSaE4OqyKDcizzxTOPb9lt9Z0k3x8onZIZvaXi8rb6U1MqCCG
 jh4uf21Nz2Jj/p0jsYifxpN3TrOCPRwNPWUPPEXoFcMgZH7vbPBYQ+9Xzmwq1IIly70VinvDM1J
 km64654dCWWODE+U5YjzcGrUo1TJ/DBLhxA0QOGvzZqvO4EmMAzM+3AVpLA1LFkMi1HNlOIVCa5
 FRXUzPJsYJLTJibFMMZ+Qkqbhk2+7+3vMBeHceYRH+JH14uuwvPoaGqWIzkoHBAo2cQERKAOI2H
 uS1KjstX24pFiqxnMVQ8LdnYXcU5fS/6lz106Dhmb6UsPKsKb9jXRqaAAzf0/jOgg/+dk989YsZ
 rP+F2a+S0dSpSpNUZrwQ851VoO53PUMtaBxa1xhw8HsW5sb/RIlm/retfxdiTVSvw4BxjnTUlim
 u4RG/LJymx2J0MgdBcg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX0zumkspzsKBG
 xbKAW+V74/NqQ8/Orat64OK3zkn1TLlFBhWiUD5en4IZpVwU0j+bZpm2q9n9IHHa2zMdqyUtJfa
 35zyMQtFARxuFlNuYqncu6GEUiUWR1g=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2a48a8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ySlkKLH3HnL0fBWr2zQA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 1Z_t9uKzv_384cx8U4OgSDOVqCtbAGqr
X-Proofpoint-GUID: 1Z_t9uKzv_384cx8U4OgSDOVqCtbAGqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110052
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5jIHwgMTYgKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2Vy
dGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGY0YTM1Mzk1OGZmLi5mNTQ1MGNlZDdkZSAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
dHJhbnNsYXRlLmMKQEAgLTQyNCw2ICs0MjQsMTYgQEAgc3RhdGljIHZvaWQgbWFya19pbXBsaWNp
dF91c3Jfd3JpdGUoRGlzYXNDb250ZXh0ICpjdHgsIGludCBhdHRyaWIpCiAgICAgfQogfQogCisj
aWZuZGVmIENPTkZJR19VU0VSX09OTFkKK3N0YXRpYyB2b2lkIG1hcmtfaW1wbGljaXRfc3JlZ193
cml0ZShEaXNhc0NvbnRleHQgKmN0eCwgaW50IGF0dHJpYiwgaW50IHNudW0pCit7CisgICAgdWlu
dDE2X3Qgb3Bjb2RlID0gY3R4LT5pbnNuLT5vcGNvZGU7CisgICAgaWYgKEdFVF9BVFRSSUIob3Bj
b2RlLCBhdHRyaWIpKSB7CisgICAgICAgIGN0eF9sb2dfc3JlZ193cml0ZShjdHgsIHNudW0pOwor
ICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMo
RGlzYXNDb250ZXh0ICpjdHgpCiB7CiAgICAgbWFya19pbXBsaWNpdF9yZWdfd3JpdGUoY3R4LCBB
X0lNUExJQ0lUX1dSSVRFU19GUCwgIEhFWF9SRUdfRlApOwpAQCAtNDM2LDYgKzQ0NiwxMiBAQCBz
dGF0aWMgdm9pZCBtYXJrX2ltcGxpY2l0X3JlZ193cml0ZXMoRGlzYXNDb250ZXh0ICpjdHgpCiAK
ICAgICBtYXJrX2ltcGxpY2l0X3Vzcl93cml0ZShjdHgsIEFfSU1QTElDSVRfV1JJVEVTX1VTUik7
CiAgICAgbWFya19pbXBsaWNpdF91c3Jfd3JpdGUoY3R4LCBBX0ZQT1ApOworCisjaWZuZGVmIENP
TkZJR19VU0VSX09OTFkKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJ
Q0lUX1dSSVRFU19TR1AwLCBIRVhfU1JFR19TR1AwKTsKKyAgICBtYXJrX2ltcGxpY2l0X3NyZWdf
d3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TR1AxLCBIRVhfU1JFR19TR1AxKTsKKyAgICBt
YXJrX2ltcGxpY2l0X3NyZWdfd3JpdGUoY3R4LCBBX0lNUExJQ0lUX1dSSVRFU19TU1IsIEhFWF9T
UkVHX1NTUik7CisjZW5kaWYKIH0KIAogc3RhdGljIHZvaWQgbWFya19pbXBsaWNpdF9wcmVkX3dy
aXRlKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgYXR0cmliLCBpbnQgcG51bSkKLS0gCjIuMzQuMQoK

