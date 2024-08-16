Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1411C5320D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 19:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf2Hr-00023I-37; Fri, 16 Aug 2024 15:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sf2Ho-00021X-TU
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 15:06:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sf2Hn-00079f-2y
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 15:06:56 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GEZwOt002198;
 Fri, 16 Aug 2024 19:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=bK/QuznSY/3QiDpGtSMPRa
 PRCMVwLUyFA3st2Ug4soA=; b=ENbCyXCI1+GLqZWx1fSp+/vLf5qJWpZw8Nd/v2
 WIpLWRhGUPGMCBKfwCzp3fe8fslaHghsV7i74/hgEpG4bOaQpJMVZyH1FfvFEpd1
 g+yLhKEnNdpObXlpcvJsLyr4mlgJ5oAJNCxO4qbBogaCG2laOI8qkQtpDjOwquxx
 aitt6miDCYLLqF6GmcdOn/0CcVLuShpntkwj7kYAp16d+j01v4C40necgJf8BPeb
 19bdtfSVQpkrKrR6Hsg5Zd9s04UGolstt4z6N1M6s/dLEgHrJ/Y3f2n4ta89M9Ba
 KWDZpOfxeNyMA1dfOaOsBaovmAZEmxwBL8+kkVylc3JVQ1+g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4112r3wpgf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Aug 2024 19:06:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47GJ6mPl025080
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Aug 2024 19:06:48 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 16 Aug 2024 12:06:48 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>, Laurent Vivier
 <laurent@vivier.eu>
Subject: [PATCH 1/3] target/hexagon: Rename HEX_EXCP_ => HEX_EVENT_
Date: Fri, 16 Aug 2024 12:06:17 -0700
Message-ID: <20240816190620.1418311-1-bcain@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: cbGoIqboWp0iuNzGUzR_MLocQXeipuHK
X-Proofpoint-ORIG-GUID: cbGoIqboWp0iuNzGUzR_MLocQXeipuHK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_13,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxlogscore=500 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408160135
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Q2hhbmdlIHRoZSBuYW1lIG9mIHRoZXNlIGRlZmluaXRpb25zIHRvIHJlZmxlY3QgdGhhdCB0aGV5
IGNvcnJlc3BvbmQKdG8gdGhlIGV2ZW50IGNvZGUgZm9yIHRoZSBleGNlcHRpb24uCgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KLS0tCiBsaW51eC11c2VyL2hl
eGFnb24vY3B1X2xvb3AuYyB8ICA0ICsrLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5oICAgICAgICAg
IHwgIDIgKy0KIHRhcmdldC9oZXhhZ29uL2NwdV9iaXRzLmggICAgIHwgMTQgKysrKysrKy0tLS0t
LS0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCAgICAgIHwgIDIgKy0KIHRhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5jICAgIHwgIDYgKysrLS0tCiA1IGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlv
bnMoKyksIDE0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvaGV4YWdvbi9j
cHVfbG9vcC5jIGIvbGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMKaW5kZXggZDQxMTU5ZTUy
YS4uZjlkOWFlNTE1ZiAxMDA2NDQKLS0tIGEvbGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMK
KysrIGIvbGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMKQEAgLTQyLDcgKzQyLDcgQEAgdm9p
ZCBjcHVfbG9vcChDUFVIZXhhZ29uU3RhdGUgKmVudikKICAgICAgICAgY2FzZSBFWENQX0lOVEVS
UlVQVDoKICAgICAgICAgICAgIC8qIGp1c3QgaW5kaWNhdGUgdGhhdCBzaWduYWxzIHNob3VsZCBi
ZSBoYW5kbGVkIGFzYXAgKi8KICAgICAgICAgICAgIGJyZWFrOwotICAgICAgICBjYXNlIEhFWF9F
WENQX1RSQVAwOgorICAgICAgICBjYXNlIEhFWF9FVkVOVF9UUkFQMDoKICAgICAgICAgICAgIHN5
c2NhbGxudW0gPSBlbnYtPmdwcls2XTsKICAgICAgICAgICAgIGVudi0+Z3ByW0hFWF9SRUdfUENd
ICs9IDQ7CiAgICAgICAgICAgICByZXQgPSBkb19zeXNjYWxsKGVudiwKQEAgLTYwLDcgKzYwLDcg
QEAgdm9pZCBjcHVfbG9vcChDUFVIZXhhZ29uU3RhdGUgKmVudikKICAgICAgICAgICAgICAgICBl
bnYtPmdwclswXSA9IHJldDsKICAgICAgICAgICAgIH0KICAgICAgICAgICAgIGJyZWFrOwotICAg
ICAgICBjYXNlIEhFWF9FWENQX1BDX05PVF9BTElHTkVEOgorICAgICAgICBjYXNlIEhFWF9FVkVO
VF9QQ19OT1RfQUxJR05FRDoKICAgICAgICAgICAgIGZvcmNlX3NpZ19mYXVsdChUQVJHRVRfU0lH
QlVTLCBUQVJHRVRfQlVTX0FEUkFMTiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYt
PmdwcltIRVhfUkVHX1IzMV0pOwogICAgICAgICAgICAgYnJlYWs7CmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDc2NGYzYzM4Y2Mu
LjNlZjJlNWJmNGIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS5oCkBAIC0xNDksNyArMTQ5LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGNw
dV9nZXRfdGJfY3B1X3N0YXRlKENQVUhleGFnb25TdGF0ZSAqZW52LCB2YWRkciAqcGMsCiAgICAg
fQogICAgICpmbGFncyA9IGhleF9mbGFnczsKICAgICBpZiAoKnBjICYgUENBTElHTl9NQVNLKSB7
Ci0gICAgICAgIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2VycihlbnYsIEhFWF9FWENQX1BDX05P
VF9BTElHTkVELCAwKTsKKyAgICAgICAgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJyKGVudiwg
SEVYX0VWRU5UX1BDX05PVF9BTElHTkVELCAwKTsKICAgICB9CiB9CiAKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL2NwdV9iaXRzLmggYi90YXJnZXQvaGV4YWdvbi9jcHVfYml0cy5oCmluZGV4
IDQyNzkyODFhNzEuLjVhNzFhZjI0NjkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9i
aXRzLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaApAQCAtMjMsMTQgKzIzLDE0IEBA
CiAjZGVmaW5lIFBDQUxJR04gNAogI2RlZmluZSBQQ0FMSUdOX01BU0sgKFBDQUxJR04gLSAxKQog
Ci0jZGVmaW5lIEhFWF9FWENQX0ZFVENIX05PX1VQQUdFICAweDAxMgotI2RlZmluZSBIRVhfRVhD
UF9JTlZBTElEX1BBQ0tFVCAgMHgwMTUKLSNkZWZpbmUgSEVYX0VYQ1BfSU5WQUxJRF9PUENPREUg
IDB4MDE1Ci0jZGVmaW5lIEhFWF9FWENQX1BDX05PVF9BTElHTkVEICAweDAxZQotI2RlZmluZSBI
RVhfRVhDUF9QUklWX05PX1VSRUFEICAgMHgwMjQKLSNkZWZpbmUgSEVYX0VYQ1BfUFJJVl9OT19V
V1JJVEUgIDB4MDI1CisjZGVmaW5lIEhFWF9FVkVOVF9GRVRDSF9OT19VUEFHRSAgMHgwMTIKKyNk
ZWZpbmUgSEVYX0VWRU5UX0lOVkFMSURfUEFDS0VUICAweDAxNQorI2RlZmluZSBIRVhfRVZFTlRf
SU5WQUxJRF9PUENPREUgIDB4MDE1CisjZGVmaW5lIEhFWF9FVkVOVF9QQ19OT1RfQUxJR05FRCAg
MHgwMWUKKyNkZWZpbmUgSEVYX0VWRU5UX1BSSVZfTk9fVVJFQUQgICAweDAyNAorI2RlZmluZSBI
RVhfRVZFTlRfUFJJVl9OT19VV1JJVEUgIDB4MDI1CiAKLSNkZWZpbmUgSEVYX0VYQ1BfVFJBUDAg
ICAgICAgICAgIDB4MTcyCisjZGVmaW5lIEhFWF9FVkVOVF9UUkFQMCAgICAgICAgICAgMHgxNzIK
IAogI2RlZmluZSBQQUNLRVRfV09SRFNfTUFYICAgICAgICAgNAogCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9nZW5fdGNnLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmgKaW5kZXggM2Zj
MWY0ZTI4MS4uOGEzYjgwMTI4NyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5o
CisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaApAQCAtMTM2NSw3ICsxMzY1LDcgQEAKICAg
ICBkbyB7IFwKICAgICAgICAgdWlWID0gdWlWOyBcCiAgICAgICAgIHRjZ19nZW5fbW92aV90bCho
ZXhfZ3ByW0hFWF9SRUdfUENdLCBjdHgtPnBrdC0+cGMpOyBcCi0gICAgICAgIFRDR3YgZXhjcCA9
IHRjZ19jb25zdGFudF90bChIRVhfRVhDUF9UUkFQMCk7IFwKKyAgICAgICAgVENHdiBleGNwID0g
dGNnX2NvbnN0YW50X3RsKEhFWF9FVkVOVF9UUkFQMCk7IFwKICAgICAgICAgZ2VuX2hlbHBlcl9y
YWlzZV9leGNlcHRpb24odGNnX2VudiwgZXhjcCk7IFwKICAgICB9IHdoaWxlICgwKQogI2VuZGlm
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5jCmluZGV4IDRiMWJlZTNjNmQuLjJmMTg3YzZjZWIgMTAwNjQ0Ci0tLSBhL3Rh
cmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5j
CkBAIC01OTEsNyArNTkxLDcgQEAgc3RhdGljIHZvaWQgZ2VuX2luc24oRGlzYXNDb250ZXh0ICpj
dHgpCiAgICAgICAgIGN0eC0+aW5zbi0+Z2VuZXJhdGUoY3R4KTsKICAgICAgICAgbWFya19zdG9y
ZV93aWR0aChjdHgpOwogICAgIH0gZWxzZSB7Ci0gICAgICAgIGdlbl9leGNlcHRpb25fZW5kX3Ri
KGN0eCwgSEVYX0VYQ1BfSU5WQUxJRF9PUENPREUpOworICAgICAgICBnZW5fZXhjZXB0aW9uX2Vu
ZF90YihjdHgsIEhFWF9FVkVOVF9JTlZBTElEX09QQ09ERSk7CiAgICAgfQogfQogCkBAIC05Njgs
NyArOTY4LDcgQEAgc3RhdGljIHZvaWQgZGVjb2RlX2FuZF90cmFuc2xhdGVfcGFja2V0KENQVUhl
eGFnb25TdGF0ZSAqZW52LCBEaXNhc0NvbnRleHQgKmN0eCkKIAogICAgIG53b3JkcyA9IHJlYWRf
cGFja2V0X3dvcmRzKGVudiwgY3R4LCB3b3Jkcyk7CiAgICAgaWYgKCFud29yZHMpIHsKLSAgICAg
ICAgZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoY3R4LCBIRVhfRVhDUF9JTlZBTElEX1BBQ0tFVCk7Cisg
ICAgICAgIGdlbl9leGNlcHRpb25fZW5kX3RiKGN0eCwgSEVYX0VWRU5UX0lOVkFMSURfUEFDS0VU
KTsKICAgICAgICAgcmV0dXJuOwogICAgIH0KIApAQCAtOTg0LDcgKzk4NCw3IEBAIHN0YXRpYyB2
b2lkIGRlY29kZV9hbmRfdHJhbnNsYXRlX3BhY2tldChDUFVIZXhhZ29uU3RhdGUgKmVudiwgRGlz
YXNDb250ZXh0ICpjdHgpCiAgICAgICAgIGdlbl9jb21taXRfcGFja2V0KGN0eCk7CiAgICAgICAg
IGN0eC0+YmFzZS5wY19uZXh0ICs9IHBrdC5lbmNvZF9wa3Rfc2l6ZV9pbl9ieXRlczsKICAgICB9
IGVsc2UgewotICAgICAgICBnZW5fZXhjZXB0aW9uX2VuZF90YihjdHgsIEhFWF9FWENQX0lOVkFM
SURfUEFDS0VUKTsKKyAgICAgICAgZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoY3R4LCBIRVhfRVZFTlRf
SU5WQUxJRF9QQUNLRVQpOwogICAgIH0KIH0KIAotLSAKMi4zNC4xCgo=

