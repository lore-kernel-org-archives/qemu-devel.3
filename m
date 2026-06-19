Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDA7CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waifR-0003rR-DW; Fri, 19 Jun 2026 19:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifK-0003np-RE
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifI-0007Pj-NQ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:26 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLXkoa1286035
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zeFyaaj9ezk3dMnLRJvqloiuq+fIgJ0YErhEi239GAY=; b=EZc2lijcUzgunSDH
 YKbJWMpolhmEMBGqqSXG8o/spFqLJAxil2Hi3GKGRQk3P5z0KaSoULYzWgkmdz55
 WlSDPqQiImMKvCWzSMZQpBMxBLjjeRQ1fubOm8YWTvzeel3xDFVQk4ugnsrQrlvm
 BiIFjZbTnMRtn5d0NyZ6ddL7X/tCqIEz3l8bl0i3AEMsY8aY3pzGcnl1xwgdtpJd
 inZiBsiVvAtpVUaYnGsFxP4DP6EFkz2s0YEkKZzkYE59oLdzTHmOnhPdR+hKZ2RG
 Q6xAQtxZvWM4Pr5eAJB6+Ut7JTgskHP5892FGG/qNQhCXpHQUjiiIm1DWnc2Udah
 7zD6Cw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evy72ka9d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:23 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so4715307eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911823; x=1782516623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zeFyaaj9ezk3dMnLRJvqloiuq+fIgJ0YErhEi239GAY=;
 b=Kr0ZMTFJ2m/aFVaAZBAH3jMD8pzf6PL1DZ2zDSEY3E0EM4UrL+EzvNGp8JqiNNjPMT
 tO5ixDXPCdbVM9qeCsC/NZje6wy7eKDdbgGMLRq7xopev0wMjk0vvwA50QrnPn2SZlF2
 U9+zc34/EFkt1CTWsk69/d4mYzRKlCdAvzLW9enx9Y5t/kozh5k+VV4hirPJR+/gRqGA
 lbfkxIcABZCKEW4ZDchvpK+XpdIun2KiuT0lG5+fXPD/Zpihf42zmRUWAkB+KiujoXzD
 xtnChAx+VlnzptBpEAW6rbDOeA0jCRVJbhTIBMGOvwmGvVpnLfvTDH7172jqt9MPZ1l6
 V3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911823; x=1782516623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zeFyaaj9ezk3dMnLRJvqloiuq+fIgJ0YErhEi239GAY=;
 b=E5Zbt+RVPT1FbhCfkXRb1/2W84FPHOccP+JXQbXBGBNGGxX/y+YG9M4N1wiwB49CjL
 XMGyIfx7TWfspaYEOIzcKeAbEE6V/DeeFgqrdvVYbxERUKcF5dTZpWhIpCAZVYYFKGoE
 qTsymVoj8YByZGdPfgQ+2PxBldckkxgFwHSPlV/LjkLE6RcAB5bvIQ2yaQbOdMJNy6X9
 wWa1hJW1QXgP87G7L2YHt7FMiXl9DMomDD8ihSjnu9U4csWNdtm4Gl/ILEA+Q1JEzR9I
 E/QZKypOCdn29PkWpsjs5D6YHV6trI7uSxbAA7e1+fyZUoLMYV43PUnDpjxwPytZdAiD
 Cm4g==
X-Gm-Message-State: AOJu0YxQ4l72ALmx5ahyMX6SLWrwg1czRFAI1w8dgqoUN15GAKddNUiV
 RYiXBPcxBu0AKnrlKFk1R8NaQ0y2VsWee7Q9Fj94p6VVfFnH3L+EMUgfaV9lHBcMq+KO9MXM/JI
 kqkURyzB7ZwEuU4hvVVEQ+R7KzZ7RddtyKiyvBNWD5OP7rk+4bmC9ynLn7A2lcUWY4Q==
X-Gm-Gg: AfdE7clAm6Z5q2WnXFsbpjd+0zytmSsYQ4GY/IExvOiOqKevmjdMBu8Y4nV21VANAWj
 0dj58jF0O1iJ0UuwXR625odqmkyhvDXjS8LAZnN3h78UnACVb0TDqGYySMznUMqpqZ+UZn/wxLv
 L7+EVHDFXYPkMY0V1IvU5VhcA5+P+HRYUBR1Yp3xhDzzYD0qQp/XgeFTY5mUVa+c8utwA9RwZ5f
 Nk7Wm5d9EqYVSO+kK+GaR9AeQLCFmQMCtOuxl+m4QD8JpNVnnsV1YZ5CbtiaVZOwsXQUXm1q6OF
 YAmT+pvhtEuxeSGsJAW0SETApJfW3R5z3fvtk/dr2QpvOAeLouPGqZ84fPNsW53BMopyNSSrUOP
 t5fkcr2xY52pUTiYHko9uouebQhFhDecXArI2i19oy2ZFTZjRDhd3a5jKmXU=
X-Received: by 2002:a05:7300:bc05:b0:30b:d344:abcf with SMTP id
 5a478bee46e88-30c0cd3bd41mr2564626eec.5.1781911822619; 
 Fri, 19 Jun 2026 16:30:22 -0700 (PDT)
X-Received: by 2002:a05:7300:bc05:b0:30b:d344:abcf with SMTP id
 5a478bee46e88-30c0cd3bd41mr2564592eec.5.1781911822070; 
 Fri, 19 Jun 2026 16:30:22 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:20 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 46/74] target/hexagon: Implement exec_interrupt, set_irq
Date: Fri, 19 Jun 2026 15:58:43 -0700
Message-Id: <20260619225911.159473-47-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX7shCZ5yec9iF
 ZYpOt6kdDppMULGrNJSfGwH7Omz7UL2aqrz57aeJm+sDS9fjJP85FSf0ucSt/A1Hz8aEz4JWG65
 A1/TKfMZ0ybhaGwL2Kvs8wK387xLnIKteDPNR/eJWxqSTapFn5aGshGRhcmAivLdWgc1tw4HzbJ
 bsd92me47fPBI2IjQvb8999pzPImAGXSZErUmj9IjB0NrrZarD/QCbadVmbLqcnVTHWPU0RXEys
 Sn4kk5cBbG8aYexfadfuFCJYP6jw63N61WZR7S8eFH4OzxWhPnCe/JPrxqvwuOVwhmjtNW8e7j6
 dhPTN1Xpj4gjXU07MvlluyIjZrx/wBkJQ4yEVddYoXosXxVAyk1H+iwVEaOCFRkcrqlWGE3itw0
 f90CG+d3PQAbtCwFOWNCIht9GzghvKe0aOO2S2jAbs7go86spEw0cv5hpLlG/XFdYSyOCtF2erf
 s/xSxDqhgf7XDHhO7/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfXxKXMYFWjRwAC
 RRpznolibYMbWEqmUms2MIesXAOsAauqNf+6uLTmcpv6PBKNavZjC4gCXFg2MWjBTrK0SJ3Jg6m
 a1feEMYyLs+gKQAaEDB/vZs+3q6Q/+w=
X-Authority-Analysis: v=2.4 cv=I75Vgtgg c=1 sm=1 tr=0 ts=6a35d10f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=GA9jbsKyPMLDJDmtv64A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: bZuD7nMwmRd-OG-3leq7pmSbGkoAgwrF
X-Proofpoint-GUID: bZuD7nMwmRd-OG-3leq7pmSbGkoAgwrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190226
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

