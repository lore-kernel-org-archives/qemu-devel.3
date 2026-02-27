Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D611039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4a8-0006tF-0P; Fri, 27 Feb 2026 15:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4a6-0006sp-CH
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:02 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4a3-0006qp-Dp
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:01 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RH0HXw3944640
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N3opY5fPwfaoLumja3ySo6JzezpNfxkIXTil/1+MMug=; b=QhDPUjoXc4GprWbg
 57NlbbNkqlghiem19Yc01feAycJwjJnD8/9ktwD4LfGczXzjxEV+AvcdAihQUUqd
 xR+7rR0ZeMyZCnzKgsjKCFQr8QtsPh1Uiv6eecn3tQYPoY41Brobqmar3ugOv7Xc
 W1XgOliEPNMjkLGHZAZ0wbUhHacWB3OXAf3XPoiZeglW3UFYGWNxbolFkWmwlAYd
 ocdXKAtzJfWzf2T/e1YFFl7kz5l9+2jVXRE9yFs2qtJrOMCAhZFP/ywbuCaMbZY1
 IExkDOrRUbhQs8H+ZGN83F4Fv5VzBZJ1h0oCgIcJqvVX70WcZLhfrmY6pF5qU2gj
 qRhzDQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck73q2d6h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:58 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d498212845so14403067a34.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224618; x=1772829418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N3opY5fPwfaoLumja3ySo6JzezpNfxkIXTil/1+MMug=;
 b=jrpkBeBbD2xR5h9fQKotyu/R7XCey9I8xMQJD267pyblc8UNGI2s1P0FXn/M/EoZ9q
 P/v7wIp8HrhxOba+Qqll9752zekaN+hT0FRcO9h6/OjowHMshwisO60lPjRNCL1A4QIN
 K0/aEncPCxzCjtXBOCWmPkAz8tC7ujF5DkKG+cl4JXK/M2SYhxgQttIUz3vbcQsDg8Jt
 ZqJTIoXMswk9fdHFMUKVcObf1Eg9CWX1QntJsU5NNxKrJXU7BeCZ56WpwDfhKf3toNgj
 5O4s3vBsw4Wi+clpW3mfOa4WEP3snuiknESItF3Ff8HkEE7r+Qrha4J3PcKY224JMZ6L
 CDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224618; x=1772829418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N3opY5fPwfaoLumja3ySo6JzezpNfxkIXTil/1+MMug=;
 b=CFBCQHz+OrN4UsUHZuEOE0ATpmHYfuClkU9RiGdT9eLmakek8fcuNcv7ZFiwn7pPes
 eLjbUeK3nQB9WI7HsVEihkRSPZhHQvfCM3RaaRgW42b+UlVTUIn+MPQLRJCj+vm3bIiU
 KZleOtiee8LA5NS5UaNKQ7paEQAZdY5wbJ2B+DvYnxTwIU1cMuqsXaw/fwrfnkjEkOjx
 mtMi59KcN2rPuu6qyGHMwJNRdHCaY2QHFppHyxPg0xAuW/mS/8crwqf5V3gQViPuLRCa
 wYm6LxBsPsVfQFnHOSWjFhiOMZDwPZbgYiw/nhv3yK8e9BGBYd0nOckuR6CrA/IZP1Gh
 YeOQ==
X-Gm-Message-State: AOJu0YytNt9kvO7s3wHVo/2KoqKBIOMcu5C4fpZGHM9+sAHVUlNz1BV5
 0w+eBxFmtLWRT8oSP6Hi5eNGWznaonHArvAM3TRp6xwKEYYDp8kcUaiMA3ZTCh+j6GmiMcdsmyW
 JT79acKJrJiE2h6Z32hIe4s/xX3UZHI/q5UDavfT5ZSIDV8EmHDEzEORWOp4byyqj9w==
X-Gm-Gg: ATEYQzxhV2GC42ksJ5+V02L+oy8GoPxmERHyV7aAj1Z1L8wNbTv7lqpy6jVYxRVOjqO
 UIfXOUH53CU+wG7UlO/DEL+QHPWRIkYhw+w/nCuZnA8TYg+Jrzt6HWyrm64puaLwJ17Lr2/gJZs
 1WdjioVZPV/0WftbdOulPARI9E3UopNCqTLoinBjPJDAeEGoYdMBu8OYskOh0Zl/pcH6uEvUyNu
 YMDoKKNwk5meRG0rQr4d1vOYq9voZ3H2rfhpEu5KZ1QoGEn1HFl3zaTQ/4D/yrXGYp6I3SQ1X0I
 Y5qEi+IIkP2p65ne72NyEl3oaEqho7x4NgHy6JgSOcUEKjZ9qu6be7w5SZal9XK6QNI0g1BaFQR
 2MHOTgX4bmknHWUA297rjluSUtx6x9OGGlXsTkCOP61pmnW9D3Jio0LFY2nCTdTI3z0zj5Q==
X-Received: by 2002:a05:6870:6195:b0:415:60c9:a41e with SMTP id
 586e51a60fabf-41627039d0fmr2877745fac.33.1772224617657; 
 Fri, 27 Feb 2026 12:36:57 -0800 (PST)
X-Received: by 2002:a05:6870:6195:b0:415:60c9:a41e with SMTP id
 586e51a60fabf-41627039d0fmr2877725fac.33.1772224617229; 
 Fri, 27 Feb 2026 12:36:57 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:36:56 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 18/37] target/hexagon: Add handlers for guest/sysreg r/w
Date: Fri, 27 Feb 2026 12:36:08 -0800
Message-Id: <20260227203627.932864-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX2nnEdNIQfmSz
 iwLda/9ieJtX5psvK0XbBqx27rGOAMJVBcXt2bQobMVEkF1tbYqAqMK59tQnGLqdWGAcbh75BYw
 4IUIa2tC81g2jAT43cLCW2J+V6IbwX1sfLCPsCCp3AAmfZKnJKuwtJkreH6OzaRpJX0NbABXXve
 pW4CRqW9t9N1q0e9Hp41jOOHEUYSGxxUekoSldDRV6m0tfK8xE+PaDTHlLc083LuBnt3nJhRe+w
 lJTObisbbBcaeoe/qcvhef6bHlNjGmV1vlhucnpQrW/R0Rxy5Kzfyd+0MtMg/wzXnUiCJyMgFSS
 RhxRfLhnIjFn1xZS1BTjPcPUNS+b3nvooK+d+kTUvvReMHFYsNT6mrhbMtad6jTswwBraA6Wxkd
 SVUeaRsg58rafbfVaCkpTElp19twVSNVBz4j4JDCewK5x2Al5ASSc2s0m8xSvgByy7wLhAgSCL3
 6o8+8gsgIiVt8cbBbVw==
X-Authority-Analysis: v=2.4 cv=KL9XzVFo c=1 sm=1 tr=0 ts=69a2006a cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=YS0KV4ZxTOLzYV__0jkA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: IMIvd3Ch15zpfC9B7bNorc84S0t_oYFH
X-Proofpoint-GUID: IMIvd3Ch15zpfC9B7bNorc84S0t_oYFH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGlzIGNvbW1pdCBwcm92aWRl
cyBoYW5kbGVycyB0byBnZW5lcmF0ZSBUQ0cgZm9yIGd1ZXN0IGFuZCBzeXN0ZW0KcmVnaXN0ZXIg
cmVhZHMgYW5kIHdyaXRlcy4gIFRoZXkgd2lsbCBiZSBsZXZlcmFnZWQgYnkgYSBmdXR1cmUgY29t
bWl0LgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0u
Y29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jIHwgMTQ3ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNDcgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbnB0ci5jIGIvdGFyZ2V0L2hleGFnb24v
Z2VucHRyLmMKaW5kZXggOWViMjFkYTZmM2UuLjkwOGY3ZTVlMmU1IDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9nZW5wdHIuYworKysgYi90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYwpAQCAtMjMs
NiArMjMsNyBAQAogI2luY2x1ZGUgImV4ZWMvaGVscGVyLWdlbi5oIgogI2luY2x1ZGUgImluc24u
aCIKICNpbmNsdWRlICJvcGNvZGVzLmgiCisjaW5jbHVkZSAic3lzX21hY3Jvcy5oIgogI2luY2x1
ZGUgInRyYW5zbGF0ZS5oIgogI2RlZmluZSBRRU1VX0dFTkVSQVRFICAgICAgIC8qIFVzZWQgaW50
ZXJuYWxseSBieSBtYWNyb3MuaCAqLwogI2luY2x1ZGUgIm1hY3Jvcy5oIgpAQCAtMTIwLDYgKzEy
MSwxNTIgQEAgVENHdiBnZXRfcmVzdWx0X3ByZWQoRGlzYXNDb250ZXh0ICpjdHgsIGludCBwbnVt
KQogICAgIH0KIH0KIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitHX0dOVUNfVU5VU0VECitz
dGF0aWMgYm9vbCBncmVnX3dyaXRhYmxlKGludCBybnVtLCBib29sIHBhaXIpCit7CisgICAgaWYg
KHBhaXIpIHsKKyAgICAgICAgaWYgKHJudW0gPCBIRVhfR1JFR19HMykgeworICAgICAgICAgICAg
cmV0dXJuIHRydWU7CisgICAgICAgIH0KKyAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfVU5JTVAs
CisgICAgICAgICAgICAgICAgIldhcm5pbmc6IGlnbm9yaW5nIHdyaXRlIHRvIGd1ZXN0IHJlZ2lz
dGVyIHBhaXIgRyVkOiVkXG4iLAorICAgICAgICAgICAgICAgIHJudW0gKyAxLCBybnVtKTsKKyAg
ICB9IGVsc2UgeworICAgICAgICBpZiAocm51bSA8PSBIRVhfR1JFR19HMykgeworICAgICAgICAg
ICAgcmV0dXJuIHRydWU7CisgICAgICAgIH0KKyAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfVU5J
TVAsCisgICAgICAgICAgICAgICAgIldhcm5pbmc6IGlnbm9yaW5nIHdyaXRlIHRvIGd1ZXN0IHJl
Z2lzdGVyIEclZFxuIiwgcm51bSk7CisgICAgfQorICAgIHJldHVybiBmYWxzZTsKK30KKworR19H
TlVDX1VOVVNFRAorc3RhdGljIHZvaWQgY2hlY2tfZ3JlZ19pbXBsKGludCBybnVtLCBib29sIHBh
aXIpCit7CisgICAgaWYgKHBhaXIgJiYgKCFncmVnX2ltcGxlbWVudGVkKHJudW0pIHx8ICFncmVn
X2ltcGxlbWVudGVkKHJudW0gKyAxKSkpIHsKKyAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfVU5J
TVAsCisgICAgICAgICAgICAgICAgIldhcm5pbmc6IGd1ZXN0IHJlZ2lzdGVyIHBhaXIgRyVkOiVk
IGlzIHVuaW1wbGVtZW50ZWQgb3IgIgorICAgICAgICAgICAgICAgICJyZXNlcnZlZC4gUmVhZCB3
aWxsIHlpZWxkIDAuXG4iLAorICAgICAgICAgICAgICAgIHJudW0gKyAxLCBybnVtKTsKKyAgICB9
IGVsc2UgaWYgKCFwYWlyICYmICFncmVnX2ltcGxlbWVudGVkKHJudW0pKSB7CisgICAgICAgIHFl
bXVfbG9nX21hc2soTE9HX1VOSU1QLAorICAgICAgICAgICAgICAgICJXYXJuaW5nOiBndWVzdCBy
ZWdpc3RlciBHJWQgaXMgdW5pbXBsZW1lbnRlZCBvciByZXNlcnZlZC4iCisgICAgICAgICAgICAg
ICAgIiBSZWFkIHdpbGwgeWllbGQgMC5cbiIsIHJudW0pOworICAgIH0KK30KKworR19HTlVDX1VO
VVNFRAorc3RhdGljIGlubGluZSB2b2lkIGdlbl9sb2dfZ3JlZ193cml0ZShEaXNhc0NvbnRleHQg
KmN0eCwgaW50IHJudW0sIFRDR3YgdmFsKQoreworICAgIHRjZ19nZW5fbW92X3RsKGN0eC0+Z3Jl
Z19uZXdfdmFsdWVbcm51bV0sIHZhbCk7Cit9CisKK0dfR05VQ19VTlVTRUQKK3N0YXRpYyB2b2lk
IGdlbl9sb2dfZ3JlZ193cml0ZV9wYWlyKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSwgVENH
dl9pNjQgdmFsKQoreworICAgIFRDR3YgdmFsMzIgPSB0Y2dfdGVtcF9uZXcoKTsKKworICAgIC8q
IExvdyB3b3JkICovCisgICAgdGNnX2dlbl9leHRybF9pNjRfaTMyKHZhbDMyLCB2YWwpOworICAg
IGdlbl9sb2dfZ3JlZ193cml0ZShjdHgsIHJudW0sIHZhbDMyKTsKKworICAgIC8qIEhpZ2ggd29y
ZCAqLworICAgIHRjZ19nZW5fZXh0cmhfaTY0X2kzMih2YWwzMiwgdmFsKTsKKyAgICBnZW5fbG9n
X2dyZWdfd3JpdGUoY3R4LCBybnVtICsgMSwgdmFsMzIpOworfQorCitzdGF0aWMgY29uc3QgdGFy
Z2V0X3Vsb25nIHNyZWdfaW1tdXRfbWFza3NbTlVNX1NSRUdTXSA9IHsKKyAgICBbSEVYX1NSRUdf
U1RJRF0gPSAweGZmMDBmZjAwLAorICAgIFtIRVhfU1JFR19FTFJdID0gMHgwMDAwMDAwMywKKyAg
ICBbSEVYX1NSRUdfU1NSXSA9IDB4MDAwMDgwMDAsCisgICAgW0hFWF9TUkVHX0NDUl0gPSAweDEw
ZTBmZjI0LAorICAgIFtIRVhfU1JFR19IVElEXSA9IElNTVVUQUJMRSwKKyAgICBbSEVYX1NSRUdf
SU1BU0tdID0gMHhmZmZmMDAwMCwKKyAgICBbSEVYX1NSRUdfR0VWQl0gPSAweDAwMDAwMGZmLAor
fTsKKworR19HTlVDX1VOVVNFRAorc3RhdGljIHZvaWQgZ2VuX2xvZ19zcmVnX3dyaXRlKERpc2Fz
Q29udGV4dCAqY3R4LCBpbnQgcm51bSwgVENHdiB2YWwpCit7CisgICAgY29uc3QgdGFyZ2V0X3Vs
b25nIHJlZ19tYXNrID0gc3JlZ19pbW11dF9tYXNrc1tybnVtXTsKKworICAgIGlmIChyZWdfbWFz
ayAhPSBJTU1VVEFCTEUpIHsKKyAgICAgICAgaWYgKHJudW0gPCBIRVhfU1JFR19HTEJfU1RBUlQp
IHsKKyAgICAgICAgICAgIGdlbl9tYXNrZWRfcmVnX3dyaXRlKHZhbCwgaGV4X3Rfc3JlZ1tybnVt
XSwgcmVnX21hc2spOworICAgICAgICAgICAgdGNnX2dlbl9tb3ZfdGwoY3R4LT50X3NyZWdfbmV3
X3ZhbHVlW3JudW1dLCB2YWwpOworICAgICAgICB9IGVsc2UgeworICAgICAgICAgICAgZ2VuX2hl
bHBlcl9zcmVnX3dyaXRlX21hc2tlZCh0Y2dfZW52LCB0Y2dfY29uc3RhbnRfaTMyKHJudW0pLCB2
YWwpOworICAgICAgICB9CisgICAgfQorfQorCitHX0dOVUNfVU5VU0VECitzdGF0aWMgdm9pZCBn
ZW5fbG9nX3NyZWdfd3JpdGVfcGFpcihEaXNhc0NvbnRleHQgKmN0eCwgaW50IHJudW0sIFRDR3Zf
aTY0IHZhbCkKK3sKKyAgICBUQ0d2IHZhbDMyID0gdGNnX3RlbXBfbmV3KCk7CisKKyAgICAvKiBM
b3cgd29yZCAqLworICAgIHRjZ19nZW5fZXh0cmxfaTY0X2kzMih2YWwzMiwgdmFsKTsKKyAgICBn
ZW5fbG9nX3NyZWdfd3JpdGUoY3R4LCBybnVtLCB2YWwzMik7CisKKyAgICAvKiBIaWdoIHdvcmQg
Ki8KKyAgICB0Y2dfZ2VuX2V4dHJoX2k2NF9pMzIodmFsMzIsIHZhbCk7CisgICAgZ2VuX2xvZ19z
cmVnX3dyaXRlKGN0eCwgcm51bSArIDEsIHZhbDMyKTsKK30KKworR19HTlVDX1VOVVNFRAorc3Rh
dGljIHZvaWQgZ2VuX3JlYWRfc3JlZyhUQ0d2IGRzdCwgaW50IHJlZ19udW0pCit7CisgICAgaWYg
KHJlZ19udW0gPj0gSEVYX1NSRUdfR0xCX1NUQVJUIHx8IHJlZ19udW0gPT0gSEVYX1NSRUdfQkFE
VkEpIHsKKyAgICAgICAgZ2VuX2hlbHBlcl9zcmVnX3JlYWQoZHN0LCB0Y2dfZW52LCB0Y2dfY29u
c3RhbnRfaTMyKHJlZ19udW0pKTsKKyAgICB9IGVsc2UgeworICAgICAgICB0Y2dfZ2VuX21vdl90
bChkc3QsIGhleF90X3NyZWdbcmVnX251bV0pOworICAgIH0KK30KKworR19HTlVDX1VOVVNFRAor
c3RhdGljIHZvaWQgZ2VuX3JlYWRfc3JlZ19wYWlyKFRDR3ZfaTY0IGRzdCwgaW50IHJlZ19udW0p
Cit7CisgICAgaWYgKHJlZ19udW0gPCBIRVhfU1JFR19HTEJfU1RBUlQpIHsKKyAgICAgICAgaWYg
KHJlZ19udW0gKyAxID09IEhFWF9TUkVHX0JBRFZBKSB7CisgICAgICAgICAgICBUQ0d2IGJhZHZh
ID0gdGNnX3RlbXBfbmV3KCk7CisgICAgICAgICAgICBnZW5faGVscGVyX3NyZWdfcmVhZChiYWR2
YSwgdGNnX2VudiwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjZ19jb25zdGFu
dF90bChIRVhfU1JFR19CQURWQSkpOworICAgICAgICAgICAgdGNnX2dlbl9jb25jYXRfaTMyX2k2
NChkc3QsIGhleF90X3NyZWdbcmVnX251bV0sIGJhZHZhKTsKKyAgICAgICAgfSBlbHNlIHsKKyAg
ICAgICAgICAgIHRjZ19nZW5fY29uY2F0X2kzMl9pNjQoZHN0LCBoZXhfdF9zcmVnW3JlZ19udW1d
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhleF90X3NyZWdbcmVn
X251bSArIDFdKTsKKyAgICAgICAgfQorICAgIH0gZWxzZSB7CisgICAgICAgIGdlbl9oZWxwZXJf
c3JlZ19yZWFkX3BhaXIoZHN0LCB0Y2dfZW52LCB0Y2dfY29uc3RhbnRfdGwocmVnX251bSkpOwor
ICAgIH0KK30KKworR19HTlVDX1VOVVNFRAorc3RhdGljIHZvaWQgZ2VuX3JlYWRfZ3JlZyhUQ0d2
IGRzdCwgaW50IHJlZ19udW0pCit7CisgICAgaWYgKHJlZ19udW0gPD0gSEVYX0dSRUdfRzMpIHsK
KyAgICAgICAgdGNnX2dlbl9tb3ZfdGwoZHN0LCBoZXhfZ3JlZ1tyZWdfbnVtXSk7CisgICAgfSBl
bHNlIHsKKyAgICAgICAgZ2VuX2hlbHBlcl9ncmVnX3JlYWQoZHN0LCB0Y2dfZW52LCB0Y2dfY29u
c3RhbnRfdGwocmVnX251bSkpOworICAgIH0KK30KKworR19HTlVDX1VOVVNFRAorc3RhdGljIHZv
aWQgZ2VuX3JlYWRfZ3JlZ19wYWlyKFRDR3ZfaTY0IGRzdCwgaW50IHJlZ19udW0pCit7CisgICAg
aWYgKHJlZ19udW0gPT0gSEVYX0dSRUdfRzAgfHwgcmVnX251bSA9PSBIRVhfR1JFR19HMikgewor
ICAgICAgICB0Y2dfZ2VuX2NvbmNhdF9pMzJfaTY0KGRzdCwgaGV4X2dyZWdbcmVnX251bV0sCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBoZXhfZ3JlZ1tyZWdfbnVtICsgMV0p
OworICAgIH0gZWxzZSB7CisgICAgICAgIGdlbl9oZWxwZXJfZ3JlZ19yZWFkX3BhaXIoZHN0LCB0
Y2dfZW52LCB0Y2dfY29uc3RhbnRfdGwocmVnX251bSkpOworICAgIH0KK30KKyNlbmRpZgorCisK
IHZvaWQgZ2VuX3ByZWRfd3JpdGUoRGlzYXNDb250ZXh0ICpjdHgsIGludCBwbnVtLCBUQ0d2IHZh
bCkKIHsKICAgICBUQ0d2IHByZWQgPSBnZXRfcmVzdWx0X3ByZWQoY3R4LCBwbnVtKTsKLS0gCjIu
MzQuMQoK

