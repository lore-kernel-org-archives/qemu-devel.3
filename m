Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DD4C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9U-0004zp-NG; Thu, 24 Sep 2026 21:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9H-0004vf-WE
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9G-0005sM-7H
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:51 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1l5G43752788
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UcbuxiNRh2vRWLCprc+pkvyNs2H5Ke2qOfxESW0PV7A=; b=YmP1Ln00UqzTTv0M
 8yss+I3mSVSGTii2opnrClVN1YshxUpgUu1HJR2LBTn5n5wStuGKlgGvwk/7Uban
 2ECouj2WWDko0Vcp7S8nBAISJNfhJY19Jgew6TpwTYV6YAkoQZf/mZaF+DWw76wO
 xrq9k2JV0bSItRGhgns8hFy3e1k/qkURGEJOXvij1eqISS7ZvukDOrJSAL1ksQie
 c6Ospfy4PGP0qX2vd60xKs6gOdI4+x9YPXyc+bW57b6u40SZN3uGuXYD8k38X2DI
 6G05SfXvQgM4T7iRosD1CPNZmQZWGPbtgv2HuQJy7307H4m8MHW5CRlGvQvzgyQr
 ztOwow==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw5q8tcmw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-331b2ec616fso1392583eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301288; x=1790906088; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UcbuxiNRh2vRWLCprc+pkvyNs2H5Ke2qOfxESW0PV7A=;
 b=dOidZ9CmqGZvjfSK+BfYYdqLvF3n29x8g4AkH3TYWfo8EOK41kdSQSGLdkZcd7pEdz
 VS8I5ZFR3LUkYqy+/sL2MDd51vJvbDoW59jPb+phFJkcwBmZD7fy1GaIKFJ1ACtnRePo
 jXSgKdLBu+c/gb0Q0cPQoHVoz8vnL6F/qwOMB7/9SBz55Yh8jJxwEAEMlbNM+ugU3mVF
 eXL5A9VJ5GP1+Ybp43ILEHo2F8bDQ/FUWFoZp5EARF0qtIWN3yXoj1PHbfWFPpvMRRMT
 orCNU1lSou2T5dXMcI6CWWKwyquLTnmOhkM2aXpi5+3lIbUHXEBNaeMjLPbrazgWFXBv
 Do/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301288; x=1790906088;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UcbuxiNRh2vRWLCprc+pkvyNs2H5Ke2qOfxESW0PV7A=;
 b=deuFwyaBpmbUFNQGMXVpjtAJk/6GEsTri0TlTIiQ/LxszHEg07dJ4n6xazaH0HadP4
 6FmNb9/fxPGoeyBHCNjU6DsvErj1Ub2alveRAHU2EFooG2jBRC56mb//0yrpzEWf9YGf
 7ohkArchTFUKiuTJq1WWW57VUPJzEQCHmw/bBtnur/tRYc86LGzVIJ0qoTJE43NE9Jsb
 UoO4BfN893+2Ik2+LiFCfXKXD8KFDRFTPLCJTYZCGhPxzi/uLPblylEm479owZZnvnJP
 vyTT5Bq8m873lQwkjA5JBWPchSYCCX+MamYBVvX83sRgu0dB2XaFVoSDBRJ5UHwI7Wje
 As3g==
X-Gm-Message-State: AFuF++mv6kPCnBi2VOa/Hj76SM4XGssDw6sdhqKoDIh1BAk8HdELO5tE
 qoamcr6yDaiiq0QVzakePkmChMEn9P7I8B7wAYzTWdynIuZHXnwIlvuFi4FIlQM6edAQAEHNMC/
 v3BBwxkOY/7C5K3mKDJUA94gvy/oQ89rTrnxWfVr58hfb6pyKGBOcrgaKwOaIBq/0IQ==
X-Gm-Gg: AYBFou1O5KnPWHPPNZCYWWuISJZrePBjWxgnTp0EYRW14VVchanogSHdNrNVDD35a2L
 TSta2fPWeVsHq0nk7zx3MfAEOa38PH2fa89Kk9Edut8u73nJatKOAQuV/6+Ezel4m/OWGA6fEN7
 CK7LzSdfI9JoXygpN3690UJgI5db/fFSEyb+dOJDBWF+abO8TVgAT/Wlf0/JyThoiEiaHjP22yu
 i52noR8r5a84m4E/oWWINJIViWvGUekhxi+KnAMcGSiYi10BcoPGQ9oYCMV6x1WpyIB4B/Rrbry
 TqC9TxDlB+375QWt3XlCCQXf9LaXBsyNynwur4RwIxdxgd4UxzgtpkUKp+vza0HfJMcKnRzGcid
 kpTHG3+P2oqwhstQmJpx6l5K35zK1YP6F6B2eZZG3sbWIbbc=
X-Received: by 2002:a05:7300:f282:b0:33b:e973:90cb with SMTP id
 5a478bee46e88-340034bb1fcmr3411047eec.26.1790301288268; 
 Thu, 24 Sep 2026 18:54:48 -0700 (PDT)
X-Received: by 2002:a05:7300:f282:b0:33b:e973:90cb with SMTP id
 5a478bee46e88-340034bb1fcmr3411028eec.26.1790301287669; 
 Thu, 24 Sep 2026 18:54:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:54:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 08/40] Hexagon (target/hexagon) Check for greg multiwrite in
 analyze_packet
Date: Thu, 24 Sep 2026 18:53:57 -0700
Message-Id: <20260925015429.2579174-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX6FMhi9NkApnB
 pWsCAXk1xPj4VEPGjzwsIS10uzDb6yR6LQGib4vKS+YoAcE2IgHrMHq7YGioFiVKGeqwqX5pHmX
 JjPLtoHzoTuGJ0cur8WpJyKpAXXUz0Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXwyXPFjVHiLnH
 Tf0j6pmGxzGfaHTuhz0EsWYUhV3imw7p4turRyKEtCAMc61vdlDAvbusBf8+xkMFV5SZeQdLBiz
 /qCkszvJtGPEa7L6v55HtulaXULmW+niptY2p5r2uAbtEQhByaFr0CybDQfffTOB98ljBDZc6Qu
 B7pzNRBwDo1GUMtnms01HjK3CnM26MI9AMMgL+xdxtMzsAce2/R3jo2sAIkr4IQPaP9AFIbQarm
 PkNCTUWmgN3OP0CptHR76MLna4b0UO5ir2GcoOTt4QR8cA01ii6nQ/bV3bZVQvBtbvymcX9ph8b
 +qFR+jqiNvcNv+ngd5sHUFLq3+1SNIKnuGwIaz2hoITp/WzB5NI8xaPAAVO4B39U6SS0K/PPQ6f
 1m9AoOVNZIvv/vjbUQsbEs1lxvKZRgdrUuc/OIO5PyDC53bO/vq5mYcurgw4A9eN+0dDw8j6hG2
 rv2oXS1T3Ywep+BgBSw==
X-Authority-Analysis: v=2.4 cv=SYRi5fRu c=1 sm=1 tr=0 ts=6ab5d469 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=WlL1PF4r9FF6NL-e66oA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: bMraXquQWfWtTttv4jFSKGWHPCNSJUCw
X-Proofpoint-ORIG-GUID: bMraXquQWfWtTttv4jFSKGWHPCNSJUCw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KClNpZ25lZC1v
ZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJldmlld2Vk
LWJ5OiBNYXJjbyBMaWViZWwgPG1hcmNvLmxpZWJlbEBvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdl
ZC1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2Zm
LWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmggfCAxMSArKysrKysrKystLQogdGFyZ2V0L2hleGFnb24vdHJh
bnNsYXRlLmMgfCAgOCArKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5o
IGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKaW5kZXggYjZjZGY1MWMyMDUuLmViMGQxMGQ2
ODZjIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAorKysgYi90YXJnZXQv
aGV4YWdvbi90cmFuc2xhdGUuaApAQCAtNDcsNiArNDcsOCBAQCB0eXBlZGVmIHN0cnVjdCBEaXNh
c0NvbnRleHQgewogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCiAgICAgaW50IGdyZWdfbG9nW0dS
RUdfV1JJVEVTX01BWF07CiAgICAgaW50IGdyZWdfbG9nX2lkeDsKKyAgICBERUNMQVJFX0JJVE1B
UChncmVnc193cml0dGVuLCBOVU1fR1JFR1MpOworICAgIERFQ0xBUkVfQklUTUFQKGdyZWdzX211
bHRpX3dyaXRlLCBOVU1fR1JFR1MpOwogICAgIGludCBzcmVnX2xvZ1tTUkVHX1dSSVRFU19NQVhd
OwogICAgIGludCBzcmVnX2xvZ19pZHg7CiAgICAgVENHdl9pMzIgdF9zcmVnX25ld192YWx1ZVtI
RVhfU1JFR19HTEJfU1RBUlRdOwpAQCAtMTA1LDggKzEwNywxMyBAQCBzdGF0aWMgaW5saW5lIHZv
aWQgY3R4X2xvZ19ncmVnX3dyaXRlKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSkKICAgICBp
ZiAocm51bSA+IEhFWF9HUkVHX0czKSB7CiAgICAgICAgIHJldHVybjsKICAgICB9Ci0gICAgY3R4
LT5ncmVnX2xvZ1tjdHgtPmdyZWdfbG9nX2lkeF0gPSBybnVtOwotICAgIGN0eC0+Z3JlZ19sb2df
aWR4Kys7CisgICAgaWYgKCF0ZXN0X2JpdChybnVtLCBjdHgtPmdyZWdzX3dyaXR0ZW4pKSB7Cisg
ICAgICAgIHNldF9iaXQocm51bSwgY3R4LT5ncmVnc193cml0dGVuKTsKKyAgICAgICAgY3R4LT5n
cmVnX2xvZ1tjdHgtPmdyZWdfbG9nX2lkeF0gPSBybnVtOworICAgICAgICBjdHgtPmdyZWdfbG9n
X2lkeCsrOworICAgIH0gZWxzZSB7CisgICAgICAgIHNldF9iaXQocm51bSwgY3R4LT5ncmVnc19t
dWx0aV93cml0ZSk7CisgICAgfQogfQogCiBzdGF0aWMgaW5saW5lIHZvaWQgY3R4X2xvZ19ncmVn
X3dyaXRlX3BhaXIoRGlzYXNDb250ZXh0ICpjdHgsIGludCBybnVtKQpkaWZmIC0tZ2l0IGEvdGFy
Z2V0L2hleGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwppbmRl
eCA5YWQ0N2IxODM4YS4uYmNjNGE2ZTZlZmYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC01NzcsNiArNTc3
LDggQEAgc3RhdGljIHZvaWQgY2xlYXJfcGt0X2N0eChEaXNhc0NvbnRleHQgKmN0eCkKICAgICBi
aXRtYXBfemVybyhjdHgtPnByZWRpY2F0ZWRfcmVncywgVE9UQUxfUEVSX1RIUkVBRF9SRUdTKTsK
ICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogICAgIGN0eC0+Z3JlZ19sb2dfaWR4ID0gMDsKKyAg
ICBiaXRtYXBfemVybyhjdHgtPmdyZWdzX3dyaXR0ZW4sIE5VTV9HUkVHUyk7CisgICAgYml0bWFw
X3plcm8oY3R4LT5ncmVnc19tdWx0aV93cml0ZSwgTlVNX0dSRUdTKTsKICAgICBjdHgtPnNyZWdf
bG9nX2lkeCA9IDA7CiAjZW5kaWYKICAgICBiaXRtYXBfemVybyhjdHgtPmdwcl9tdWx0aV93cml0
ZSwgVE9UQUxfUEVSX1RIUkVBRF9SRUdTKTsKQEAgLTYzMSw2ICs2MzMsMTIgQEAgc3RhdGljIGJv
b2wgcGt0X2hhc193cml0ZV9jb25mbGljdChEaXNhc0NvbnRleHQgKmN0eCkKICAgICAgICAgcmV0
dXJuIHRydWU7CiAgICAgfQogCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyAgICBpZiAoIWJp
dG1hcF9lbXB0eShjdHgtPmdyZWdzX211bHRpX3dyaXRlLCBOVU1fR1JFR1MpKSB7CisgICAgICAg
IHJldHVybiB0cnVlOworICAgIH0KKyNlbmRpZgorCiAgICAgcmV0dXJuIGZhbHNlOwogfQogCi0t
IAoyLjM0LjEKCg==

