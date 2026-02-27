Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9231039895
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4ac-0007yN-0i; Fri, 27 Feb 2026 15:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aG-0007Gr-0Z
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:13 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4aE-0006sp-Da
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:37:11 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RH0FIu1365555
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aoF+8J2llt32v4C4s338dYpdv01ITZWS7hOMYM+lGOI=; b=EMW56hTbdKFQtIE9
 4u9LQ1f9L5ocA9jloSLc12NmAvMWp79Op5f9MZgqtcOsfIOT9rKKSZ0K7EiTuRvz
 lPDXZAFxhVyFxdAU+3l7MELkpjjO2RH5y8pxACDjZ5IERURsYPsgEysTrlB3p++v
 QlfsQQmlUVRRZRmoauzgeJjfCiXA8nLBni1XKLr1nO8viiplENyTBlpz8U7Sb7UL
 JowCjp4jPXCcKkGkAK6ScZhhv72uaXKVUWFRhydKkvrGfJknVA6kqjdlRKlHIuK2
 Yl37x32YYWXMw/D4PTZE0WBZyQf/8ptRdZUbVXhvmQtOqH45YfZc19YiD+odUWnW
 azal7Q==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck9f01w71-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:37:09 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-679c5ed0942so38290547eaf.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224628; x=1772829428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aoF+8J2llt32v4C4s338dYpdv01ITZWS7hOMYM+lGOI=;
 b=AC0UxfJeE9wzfC6Ob2kjVo9p/578WKi8cEHMmNYJUiVi47sSM9yfombq0CRXGqW5MB
 Tx/2ApgzyIVoi5LnfUwSpW8Ae0UjMYZ4LgFfLxqcvIVjbbW1MXG5kpkdKTAx7AqovdQf
 2PetEr/BLVfZx0m4p1MXPuONhkaU3yPBYheqltFUGwis9YUSLHMYj2LXVJix1Tdjb2CK
 RwAq2cmECZojFxvqi2hzkj2tOuBKzVhClDSuwEG3IcYIvYBUNMVuK/hxIkUDJ0bCaDAq
 dxeWHTJYYlu9QRU94+eH0FpPh1z7NAMkSO1cP+OBXP6I3C8+sWQV5PSBSMIwAL5PiTts
 vX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224628; x=1772829428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aoF+8J2llt32v4C4s338dYpdv01ITZWS7hOMYM+lGOI=;
 b=HXkpCUB0wisaqiMvjYaAC7Wb/8z5mbvwNFYKz94qxE+YYZHLuwi9D+mAGxVT9KIXej
 eal4qXCw4vSBAcp/T6gikLgWR1jPkgVEvTuXt7SoG0dgBC85PjMlr7UMdHAPNzCu0FMM
 KiL8dfZbAoAfU3gLQJU7K/lP3TDLmsWQM6Q28DWvtcYByYQfNbGrdeT6krE7Th8im8YU
 X1bgqu5ybukVVm5AxwB2gF0DJLEeUWExdNOOUs0dqOmMe0FxMTLMFsFynw+iqUMzICLG
 MqVSeWYO7cbratslntu0b4yGTKwo9WstssYR2a5YAqnFTIwJjmZryX2u/qUm7ckjf3s7
 UMKQ==
X-Gm-Message-State: AOJu0YxCIzAnzYUHtzv02nITCSNwJUJyOGatw+uppCxpwn1HIjy7Cgt0
 gz/EO/79cfhHhf9w7Kp33io1Ec6iy++UO4TfVGR+UQb3bFTMKQZ/m/EQMXzCddIJOZkv6DbtMSk
 M6/WY5Ex9yJPdFSHy4EaUHYruELngG2Rz2UD77Jy2lpbbegz3wpESqk7Ex6sMiXYVWQ==
X-Gm-Gg: ATEYQzyliNdp3LeMVeOKENg4Ok1xblXN+oSDHgsZZAQrypUeQxgCAd3yMrmbiSA46GS
 hwCOvxKktVhfTOaAgOw7EkAJm8jCIYfSmzbDMyeTiqP1KK7oTF3bXOiBLjnnMA8JtId1WGS5Nw0
 zkupwAygCKBLF+KH1CnrSCujGJZANqRN8JyFS7buEpjWsWfT732MBCwXvfn3AK2lkKmJqvY8eOR
 FBsFo3B7ZH6jzud+VwjcCM82HS79PIG/4l1yreWrhcf6yOpFP0CYaTC+6wPQmnqdAOYaPsRaaWF
 zICvIlM67QGg+8fsyaqFCyCzndHtS2JcWVYSRF+9BqN6IpVVkpw5a779cfgo28FggYHptlPvBOq
 9ZMZx735bTpWWizx3C6J21cqZHHVLPxKf48engBahjcfS2yz68oFmF4pZBRma/kQ4axQPGw==
X-Received: by 2002:a05:6870:3044:b0:409:99bb:1eae with SMTP id
 586e51a60fabf-4162706478fmr2747951fac.53.1772224628444; 
 Fri, 27 Feb 2026 12:37:08 -0800 (PST)
X-Received: by 2002:a05:6870:3044:b0:409:99bb:1eae with SMTP id
 586e51a60fabf-4162706478fmr2747938fac.53.1772224628004; 
 Fri, 27 Feb 2026 12:37:08 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:37:07 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 27/37] target/hexagon: Add TCG overrides for int handler
 insts
Date: Fri, 27 Feb 2026 12:36:17 -0800
Message-Id: <20260227203627.932864-28-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfX9k7C/4Lb38Q3
 oYDVTo11tzJ0hJShSZt2TKlyw2m/ltEBnNMSnwrlzqEFm46rRSQrO+0NQNB+ZFnSbc7cg2r9lql
 6Z6wL5Qxrm5Pq2aHDRnVqZ76M6doubrw8ma2ltDu5KUnt3Tq11DyAqtdFB9Z8CDJt4Irr0aYyKq
 j0KopIGLcJbkDlzuqZErQmSw7cNArQ3s636LgX122B98lCeS4/N8KAmIB4ZJ0/11Xmh37LPevOK
 KcMD8TdxTvRdxcXcT9vRAywdJ0t4750u7jbW7gaN3PICT9EVDtokVLoFT3xdaPi5ECb9NanZLyv
 WcrINQNKjQnymOtclqAH/M/mwlyAamaWA27lWykOlVVeZ23i3P+4rDAyIZMraVSJL3PzgbtyT9Q
 SlOCnf23OpOG5u4jReGH+CGkyOqzspwrisK4RaT3FgzQG4LEHBSx/iyhYNJKRs5buZ+O+vPulIG
 ur8iqXkg/bFenkB/qjQ==
X-Proofpoint-GUID: t1knQkXiSx-4TptFW2QSzRw8lmdZDXtd
X-Authority-Analysis: v=2.4 cv=bIsb4f+Z c=1 sm=1 tr=0 ts=69a20075 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ncxFUDX8U6Z2rYVbhVQA:9
 a=QEXdDO2ut3YA:10 a=rBiNkAWo9uy_4UTK5NWh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: t1knQkXiSx-4TptFW2QSzRw8lmdZDXtd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270181
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgVENHIG92ZXJyaWRl
cyBmb3Ige2MsfXN3aSB7YyxzfWlhZCwgaWFzc2lnbntyLHd9LCB7cyxnfWV0aW1hc2sKaW5zdHJ1
Y3Rpb25zLgoKClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21h
aWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29t
bS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaCB8IDI1ICsrKysrKysrKysr
KysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL2hlbHBlci5oICAgICAgfCAgOCArKysrKysrKwog
dGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICB8IDQwICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCA3MyBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMuaCBiL3RhcmdldC9oZXhhZ29uL2dlbl90
Y2dfc3lzLmgKaW5kZXggMjQxMGFjODJjOTYuLjdmMjIzZmYzODg0IDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfc3lz
LmgKQEAgLTcsNiArNywzMSBAQAogI2lmbmRlZiBIRVhBR09OX0dFTl9UQ0dfU1lTX0gKICNkZWZp
bmUgSEVYQUdPTl9HRU5fVENHX1NZU19ICiAKKy8qIFN5c3RlbSBtb2RlIGluc3RydWN0aW9ucyAq
LworI2RlZmluZSBmR0VOX1RDR19ZMl9zd2koU0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9z
d2kodGNnX2VudiwgUnNWKQorCisjZGVmaW5lIGZHRU5fVENHX1kyX2Nzd2koU0hPUlRDT0RFKSBc
CisgICAgZ2VuX2hlbHBlcl9jc3dpKHRjZ19lbnYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19Z
Ml9jaWFkKFNIT1JUQ09ERSkgXAorICAgIGdlbl9oZWxwZXJfY2lhZCh0Y2dfZW52LCBSc1YpCisK
KyNkZWZpbmUgZkdFTl9UQ0dfWTRfc2lhZChTSE9SVENPREUpIFwKKyAgICBnZW5faGVscGVyX3Np
YWQodGNnX2VudiwgUnNWKQorCisjZGVmaW5lIGZHRU5fVENHX1kyX2lhc3NpZ253KFNIT1JUQ09E
RSkgXAorICAgIGdlbl9oZWxwZXJfaWFzc2lnbncodGNnX2VudiwgUnNWKQorCisjZGVmaW5lIGZH
RU5fVENHX1kyX2lhc3NpZ25yKFNIT1JUQ09ERSkgXAorICAgIGdlbl9oZWxwZXJfaWFzc2lnbnIo
UmRWLCB0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfZ2V0aW1hc2soU0hPUlRD
T0RFKSBcCisgICAgZ2VuX2hlbHBlcl9nZXRpbWFzayhSZFYsIHRjZ19lbnYsIFJzVikKKworI2Rl
ZmluZSBmR0VOX1RDR19ZMl9zZXRpbWFzayhTSE9SVENPREUpIFwKKyAgICBnZW5faGVscGVyX3Nl
dGltYXNrKHRjZ19lbnYsIFB0ViwgUnNWKQorCiAjZGVmaW5lIGZHRU5fVENHX1kyX3NldHByaW8o
U0hPUlRDT0RFKSBcCiAgICAgZ2VuX2hlbHBlcl9zZXRwcmlvKHRjZ19lbnYsIFB0ViwgUnNWKQog
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaCBiL3RhcmdldC9oZXhhZ29uL2hl
bHBlci5oCmluZGV4IGExOGNiOWY3OWFkLi42ZDE0ODQ2MDM4NSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vaGVscGVyLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaGVscGVyLmgKQEAgLTEwOSw2
ICsxMDksMTQgQEAgREVGX0hFTFBFUl8yKHByb2JlX2h2eF9zdG9yZXMsIHZvaWQsIGVudiwgaW50
KQogREVGX0hFTFBFUl8yKHByb2JlX3BrdF9zY2FsYXJfaHZ4X3N0b3Jlcywgdm9pZCwgZW52LCBp
bnQpCiAKICNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQorREVGX0hFTFBFUl8yKHN3aSwg
dm9pZCwgZW52LCBpMzIpCitERUZfSEVMUEVSXzIoY3N3aSwgdm9pZCwgZW52LCBpMzIpCitERUZf
SEVMUEVSXzIoY2lhZCwgdm9pZCwgZW52LCBpMzIpCitERUZfSEVMUEVSXzIoc2lhZCwgdm9pZCwg
ZW52LCBpMzIpCitERUZfSEVMUEVSXzIoaWFzc2lnbncsIHZvaWQsIGVudiwgaTMyKQorREVGX0hF
TFBFUl8yKGlhc3NpZ25yLCBpMzIsIGVudiwgaTMyKQorREVGX0hFTFBFUl8yKGdldGltYXNrLCBp
MzIsIGVudiwgaTMyKQorREVGX0hFTFBFUl8zKHNldGltYXNrLCB2b2lkLCBlbnYsIGkzMiwgaTMy
KQogREVGX0hFTFBFUl8yKHNyZWdfcmVhZCwgaTMyLCBlbnYsIGkzMikKIERFRl9IRUxQRVJfMihz
cmVnX3JlYWRfcGFpciwgaTY0LCBlbnYsIGkzMikKIERFRl9IRUxQRVJfMihncmVnX3JlYWQsIGkz
MiwgZW52LCBpMzIpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3Rh
cmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDhkNjA2MTBiM2Y5Li43NGExMzVmYzdmZiAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMKQEAgLTEzOTEsNiArMTM5MSw0NiBAQCB2b2lkIEhFTFBFUih2d2hpc3Qx
MjhxbSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIGludDMyX3QgdWlWKQogfQogCiAjaWZuZGVmIENP
TkZJR19VU0VSX09OTFkKK3ZvaWQgSEVMUEVSKGNpYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1
aW50MzJfdCBtYXNrKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKK3ZvaWQg
SEVMUEVSKHNpYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBtYXNrKQoreworICAg
IGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKK3ZvaWQgSEVMUEVSKHN3aSkoQ1BVSGV4YWdv
blN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQo
KTsKK30KKwordm9pZCBIRUxQRVIoY3N3aSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90
IG1hc2spCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordm9pZCBIRUxQRVIo
aWFzc2lnbncpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBzcmMpCit7CisgICAgZ19h
c3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordWludDMyX3QgSEVMUEVSKGlhc3NpZ25yKShDUFVI
ZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3JjKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFj
aGVkKCk7Cit9CisKK3VpbnQzMl90IEhFTFBFUihnZXRpbWFzaykoQ1BVSGV4YWdvblN0YXRlICpl
bnYsIHVpbnQzMl90IHRpZCkKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit2
b2lkIEhFTFBFUihzZXRpbWFzaykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHByZWQs
IHVpbnQzMl90IGltYXNrKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKIHZv
aWQgSEVMUEVSKHNyZWdfd3JpdGUpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcs
IHVpbnQzMl90IHZhbCkKIHsKICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwotLSAKMi4zNC4x
Cgo=

