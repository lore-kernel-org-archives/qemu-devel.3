Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA2BC43638
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIA-0003wV-Cm; Mon, 29 Jun 2026 09:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHK-0003dG-OI
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHJ-0006FB-3r
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:02 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASvi32603468
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zeFyaaj9ezk3dMnLRJvqloiuq+fIgJ0YErhEi239GAY=; b=eGKZA5yT9SkKblm4
 KSlEl04QRh3Yz0rEcJk/QJbCl4KQy2SnVYbCXBZWNrVeGemUfRFykhbe4M4xadE4
 2M2XLQh1JrxJ/WO7Ida8gLzRyw3nhE4HfScPLdAEUyNC9ailwJdWAMq/0EfzZcqm
 6pNEwWDHkp2QS3Pt8klWXLOQeQQlk4a1iSP+jGgIBwVOcCOxlNz1BQNiz4OdrKtU
 ww8sHXYo9cck3xKhGOcEW1OLfazdbGha7u9WWSTah5zdRKrnzZMlr6SrTlxuaKeN
 vGbYZOn1/ftp4z7sxYia1TNYzVAoQbZfSKqVf3TvxdD8JFDNguTf0sWul8dtaWk4
 G22+Mw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq892mr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:43:59 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88fc985a65so1615540a12.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740639; x=1783345439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zeFyaaj9ezk3dMnLRJvqloiuq+fIgJ0YErhEi239GAY=;
 b=Vhxj34iZDUvRcdHghAh1zQmoV87lWz4thgeR3E0d+FVBd898zIJUggGgUDSyQEa1Iu
 lmK1OPE9UZUesHmauF2vrsS/IK8OGpwErInH7A+9WFONFh8mMXyEsqRb62bNCJ7d6vK0
 RO7HkliBLMy5RL0f9pDVaXny3QrXgHgNgPvnfST9/vNz88M3O5mboGaLfuMzpV/Gs4hR
 f9pYMaLRBZAt7Q+rTo1xBoTif+jRIFK+tSU5nsph+68y2qJ+82tGOpikax38M2FkVjjU
 zXwwH9tQC+evi0qvmjkkdpRKD1pf4UFTFUZfznn8MwXbHdnHev5UoG+4UP7Uk/itq0IQ
 yzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740639; x=1783345439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zeFyaaj9ezk3dMnLRJvqloiuq+fIgJ0YErhEi239GAY=;
 b=k7qTnih7Cwrf0vjjk/tgR7kAAkBEaN1lnjUfzrwY0udTuiX/przXJcjp3CwFwEs+0e
 cU/rg2FKRZ12gaGSfG9+sq2nVTwTwtdfQ8Pzhrl24AaYJ8wHeuv7Wn3SxEKO8bjdeAur
 FkMbw7QZ23EhgbxqLrYOjVcT+446Ygjtzqgv8LRFkyAlJAqoap9nV4dY9hviHyNtz1cl
 8x1msXdY6nkKJPr1mGCNGNfUJnVvqSvHfzSkhT8q10Z66nGznGWdwvZG7lyMCAsajd64
 SN3pNPFxJJAxn6SFajiY6m7kXBQixCs1lVmDTFS3MK8EtcYTmqgiPfvJ4ljCGrimnAd9
 S68w==
X-Gm-Message-State: AOJu0Yw5ByOp1+jWM9YYyvBfiXkascGJBiVcMNk1SAAS3FGTu5heoOSX
 5wPXQgqPzzAwdcC9eDFLzlX57btZ4na/VphkM5k1zVC6/kHoVQ52rrHuvO+cGQ+uSpLank4T4rZ
 YvsB3RkiCvLCeCgPFPvvKztKRyHISa60HVbd9CoOV+JQ9dC9WHodlQF+HawkrrqKvgQ==
X-Gm-Gg: AfdE7cnX6iKBQpwoWPFq3CUOrt3B5ePv24t0PUrwIEvrxmJrA83lLHJi164Puv2cEN2
 oMSqlAe2kzLkZnq02OACBOLlaqW58YyPCAZMj9CJTdwoxcBY6pbI44v7w7CRNX1xZ4r9SXjjNZB
 LAF3LajkWCIyRIDZMNo/p5BVrcmawDgSgjogA4y1Mi9pcL6i+c2wqrXlHJP1NhsFse6NF7ZLYNh
 9sfLfBUyWqxKx1M+PUTTuwzZCxCtuOWBaxQvPDnKH8jZlPJLELjooLppCGtxG+zUpdKVdBFSnYu
 /7gTbSst0tyctR3f/TY48h0hTZQVjscOKNMgclf4JjH9AL1ChxEbbjf9A6fx8RXGjaL+o17OWK5
 EvgQvrS/T1e3bbFA85TF/5G3U8Z+FaY9VD5tEo9jbzozQf+Okeg6cYzQUVTM=
X-Received: by 2002:a17:903:324f:b0:2c9:ae0b:61e3 with SMTP id
 d9443c01a7336-2c9ae0b64e5mr75896985ad.2.1782740638911; 
 Mon, 29 Jun 2026 06:43:58 -0700 (PDT)
X-Received: by 2002:a17:903:324f:b0:2c9:ae0b:61e3 with SMTP id
 d9443c01a7336-2c9ae0b64e5mr75896765ad.2.1782740638395; 
 Mon, 29 Jun 2026 06:43:58 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:43:57 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 50/77] target/hexagon: Implement exec_interrupt, set_irq
Date: Mon, 29 Jun 2026 06:12:05 -0700
Message-Id: <20260629131232.2487780-51-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: sJajVEn2Qv-B9LqFjtLwDfidxCDbNGJu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX6ruWI0cOIm3r
 oRLvulrdkJdhBvKfKQPlH2s7iSeyG6zl8MwZSkhYKyyQ/MaeUGaY1o/cY1QZzX++kzDewJ1oeK8
 fuCI4oWLlXwOsMDGentq1aIMvQ2nISU=
X-Proofpoint-ORIG-GUID: sJajVEn2Qv-B9LqFjtLwDfidxCDbNGJu
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a42769f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=GA9jbsKyPMLDJDmtv64A:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX7tdhl9PBz3F2
 5077a2iXe7HNwk0UwgEZn0zBNY59UUx7KSDWEnmuxB3Yaimuoe3ZtbJl8aizMPIOg7KTtgmLxhm
 0z6NNyWWkoDNHT5ufdO4CAjAK80DZPyTXAWJwrgH+UUld/j3kUM2z/9i8InZPPl1Ogf24Sn1rQI
 YsyWMaKY7etMM7D0g+3mB/7QLLsbLSp0JJRqTraKnMvw6sfvJZcK28uB9VQQnqvElxf47oqpb4H
 wOMM7R/9D7AK70mB+BIESoVDDc7QgLnUXkJTsxZQ5tVQcgELwJcq9prEYgvMGxati5QLNkClXGe
 lSEQMu57Gj/j0G69Ip/GMDlFjfP89BYRV71mO4cqnJ6Lt7WIfuGPXpI5IlXlq5iaACHpNLQ72rT
 VxtWcxkf5VpUY7vCGRK/sB2vqBpEUS8ectgZqv5qQCFMTzCc6IUQYCWYsKA/VnPaX9WYaqopliN
 QolgCVWT0qIhr875Pkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290114
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgODQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBlYzBjYTNlZTY3OC4uMGQ2NTUx
ZGQ1YjYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL2NwdS5jCkBAIC0xNiw2ICsxNiw3IEBACiAgKi8KIAogI2luY2x1ZGUgInFlbXUvb3NkZXAu
aCIKKyNpbmNsdWRlICJxZW11L2xvZy5oIgogI2luY2x1ZGUgInFlbXUvcWVtdS1wcmludC5oIgog
I2luY2x1ZGUgImNwdS5oIgogI2luY2x1ZGUgImludGVybmFsLmgiCkBAIC0zMSwxMCArMzIsMTIg
QEAKICNpbmNsdWRlICJoZXhfbW11LmgiCiAKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2lu
Y2x1ZGUgIm1hY3Jvcy5oIgogI2luY2x1ZGUgInN5c19tYWNyb3MuaCIKICNpbmNsdWRlICJhY2Nl
bC90Y2cvY3B1LWxkc3QuaCIKICNpbmNsdWRlICJxZW11L21haW4tbG9vcC5oIgogI2luY2x1ZGUg
ImhleF9pbnRlcnJ1cHRzLmgiCisjaW5jbHVkZSAiZXhlYy9jcHUtaW50ZXJydXB0LmgiCiAjZW5k
aWYKIAogc3RhdGljIE9iamVjdENsYXNzICpoZXhhZ29uX2NwdV9jbGFzc19ieV9uYW1lKGNvbnN0
IGNoYXIgKmNwdV9tb2RlbCkKQEAgLTMwNCw2ICszMDcsMzYgQEAgc3RhdGljIHZvaWQgaGV4YWdv
bl9jcHVfc3luY2hyb25pemVfZnJvbV90YihDUFVTdGF0ZSAqY3MsCiAgICAgY3B1X2Vudihjcykt
PmdwcltIRVhfUkVHX1BDXSA9IHRiLT5wYzsKIH0KIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZ
Citib29sIGhleGFnb25fdGhyZWFkX2lzX2VuYWJsZWQoQ1BVSGV4YWdvblN0YXRlICplbnYpCit7
CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gZW52X2FyY2hjcHUoZW52KTsKKyAgICB1aW50MzJfdCBt
b2RlY3RsOworICAgIHVpbnQzMl90IHRocmVhZF9lbmFibGVkX21hc2s7CisgICAgYm9vbCBFX2Jp
dDsKKworICAgIGlmICghY3B1LT5nbG9iYWxyZWdzKSB7CisgICAgICAgIHJldHVybiB0cnVlOwor
ICAgIH0KKyAgICBtb2RlY3RsID0KKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUt
Pmdsb2JhbHJlZ3MsIEhFWF9TUkVHX01PREVDVEwsCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZW52LT50aHJlYWRJZCk7CisgICAgdGhyZWFkX2VuYWJsZWRfbWFzayA9IEdFVF9GSUVM
RChNT0RFQ1RMX0UsIG1vZGVjdGwpOworICAgIEVfYml0ID0gdGhyZWFkX2VuYWJsZWRfbWFzayAm
ICgweDEgPDwgZW52LT50aHJlYWRJZCk7CisKKyAgICByZXR1cm4gRV9iaXQ7Cit9CisKK3N0YXRp
YyBib29sIGhleGFnb25fY3B1X2hhc193b3JrKENQVVN0YXRlICpjcykKK3sKKyAgICBDUFVIZXhh
Z29uU3RhdGUgKmVudiA9IGNwdV9lbnYoY3MpOworCisgICAgcmV0dXJuIGhleGFnb25fdGhyZWFk
X2lzX2VuYWJsZWQoZW52KSAmJgorICAgICAgICAoY3MtPmludGVycnVwdF9yZXF1ZXN0ICYgKENQ
VV9JTlRFUlJVUFRfSEFSRCB8IENQVV9JTlRFUlJVUFRfU1dJCisgICAgICAgICAgICB8IENQVV9J
TlRFUlJVUFRfSzBfVU5MT0NLIHwgQ1BVX0lOVEVSUlVQVF9UTEJfVU5MT0NLKSk7Cit9CisjZW5k
aWYKKwogc3RhdGljIHZvaWQgaGV4YWdvbl9yZXN0b3JlX3N0YXRlX3RvX29wYyhDUFVTdGF0ZSAq
Y3MsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IFRyYW5z
bGF0aW9uQmxvY2sgKnRiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb25zdCB1aW50NjRfdCAqZGF0YSkKQEAgLTQxMiwxMCArNDQ1LDU4IEBAIHN0YXRpYyBpbnQg
aGV4YWdvbl9jcHVfbW11X2luZGV4KENQVVN0YXRlICpjcywgYm9vbCBpZmV0Y2gpCiAgICAgcmV0
dXJuIE1NVV9VU0VSX0lEWDsKIH0KIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitzdGF0aWMg
dm9pZCBoZXhhZ29uX2NwdV9zZXRfaXJxKHZvaWQgKm9wYXF1ZSwgaW50IGlycSwgaW50IGxldmVs
KQoreworICAgIEhleGFnb25DUFUgKmNwdSA9IEhFWEFHT05fQ1BVKG9wYXF1ZSk7CisgICAgQ1BV
U3RhdGUgKmNzID0gQ1BVKGNwdSk7CisgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52
KGNzKTsKKworICAgIHN3aXRjaCAoaXJxKSB7CisgICAgY2FzZSBIRVhBR09OX0NQVV9JUlFfMCAu
Li4gSEVYQUdPTl9DUFVfSVJRXzc6CisgICAgICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQs
ICIlczogaXJxICVkLCBsZXZlbCAlZFxuIiwKKyAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNf
XywgaXJxLCBsZXZlbCk7CisgICAgICAgIGlmIChsZXZlbCkgeworICAgICAgICAgICAgaGV4X3Jh
aXNlX2ludGVycnVwdHMoZW52LCAxIDw8IGlycSwgQ1BVX0lOVEVSUlVQVF9IQVJEKTsKKyAgICAg
ICAgfQorICAgICAgICBicmVhazsKKyAgICBkZWZhdWx0OgorICAgICAgICBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOworICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9p
bml0KE9iamVjdCAqb2JqKQogeworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgSGV4YWdv
bkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUob2JqKTsKKyAgICBxZGV2X2luaXRfZ3Bpb19pbihERVZJ
Q0UoY3B1KSwgaGV4YWdvbl9jcHVfc2V0X2lycSwgOCk7CisjZW5kaWYKIH0KIAorI2lmbmRlZiBD
T05GSUdfVVNFUl9PTkxZCisKK3N0YXRpYyBib29sIGhleGFnb25fY3B1X2V4ZWNfaW50ZXJydXB0
KENQVVN0YXRlICpjcywgaW50IGludGVycnVwdF9yZXF1ZXN0KQoreworICAgIENQVUhleGFnb25T
dGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7CisgICAgaWYgKGludGVycnVwdF9yZXF1ZXN0ICYgQ1BV
X0lOVEVSUlVQVF9UTEJfVU5MT0NLKSB7CisgICAgICAgIGNzLT5oYWx0ZWQgPSBmYWxzZTsKKyAg
ICAgICAgY3B1X3Jlc2V0X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9UTEJfVU5MT0NLKTsK
KyAgICAgICAgcmV0dXJuIHRydWU7CisgICAgfQorICAgIGlmIChpbnRlcnJ1cHRfcmVxdWVzdCAm
IENQVV9JTlRFUlJVUFRfSzBfVU5MT0NLKSB7CisgICAgICAgIGNzLT5oYWx0ZWQgPSBmYWxzZTsK
KyAgICAgICAgY3B1X3Jlc2V0X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9LMF9VTkxPQ0sp
OworICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICB9CisgICAgaWYgKGludGVycnVwdF9yZXF1ZXN0
ICYgKENQVV9JTlRFUlJVUFRfSEFSRCB8IENQVV9JTlRFUlJVUFRfU1dJKSkgeworICAgICAgICBy
ZXR1cm4gaGV4X2NoZWNrX2ludGVycnVwdHMoZW52KTsKKyAgICB9CisgICAgcmV0dXJuIGZhbHNl
OworfQorCisjZW5kaWYKKwogc3RhdGljIGNvbnN0IFRDR0NQVU9wcyBoZXhhZ29uX3RjZ19vcHMg
PSB7CiAgICAgLyogTVRUQ0cgbm90IHlldCBzdXBwb3J0ZWQ6IHJlcXVpcmUgc3RyaWN0IG9yZGVy
aW5nICovCiAgICAgLmd1ZXN0X2RlZmF1bHRfbWVtb3J5X29yZGVyID0gVENHX01PX0FMTCwKQEAg
LTQyNiw2ICs1MDcsOSBAQCBzdGF0aWMgY29uc3QgVENHQ1BVT3BzIGhleGFnb25fdGNnX29wcyA9
IHsKICAgICAuc3luY2hyb25pemVfZnJvbV90YiA9IGhleGFnb25fY3B1X3N5bmNocm9uaXplX2Zy
b21fdGIsCiAgICAgLnJlc3RvcmVfc3RhdGVfdG9fb3BjID0gaGV4YWdvbl9yZXN0b3JlX3N0YXRl
X3RvX29wYywKICAgICAubW11X2luZGV4ID0gaGV4YWdvbl9jcHVfbW11X2luZGV4LAorI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCisgICAgLmNwdV9leGVjX2ludGVycnVwdCA9IGhleGFnb25fY3B1
X2V4ZWNfaW50ZXJydXB0LAorI2VuZGlmIC8qICFDT05GSUdfVVNFUl9PTkxZICovCiB9OwogCiBz
dGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9jbGFzc19pbml0KE9iamVjdENsYXNzICpjLCBjb25zdCB2
b2lkICpkYXRhKQotLSAKMi4zNC4xCgo=

