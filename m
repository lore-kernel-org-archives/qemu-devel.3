Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B184C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 00:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sik37-0005Rx-0T; Mon, 26 Aug 2024 20:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sik32-0005Fk-1k
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 20:27:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sik2y-0007Lw-St
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 20:26:58 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QJGvqL028312;
 Tue, 27 Aug 2024 00:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EoRrBs91NHzmdqGoEluM0xCsTAV5X2R/4j3BqrgYVzc=; b=H1Qglk2ZETaDjGGM
 DPcO3g9rbeQ+JExlV2zgLlLctBNo2CQNwKQ65A2ItmgQLfmoEhrmWNjAtskbuC01
 7ArbS9h6e4SHzDf1RC4dsjtVgX5U7y0NSZNHhljAVCRW07lAT6nxANqfDKBkUrkO
 cx3ITXQuURdFVPGcSMVSrXWEqEFWOaRBoCeWnKuu+/wEnlzQ5AAuFvn3j0VtYLZQ
 mbQ6c3rT9HemLxXmM1xIsYVaAmPdTeOHYiYoqmvzHe8fg1MmRLx93YG4PVJ+H4ho
 OzUIzs4m4DkIZp7W7oZfcj+uGujxE3OQuw0E+euhmb38MdOvAfaMe27pwplMx9ku
 bsJI9w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 417973n8sa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Aug 2024 00:26:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47R0QpkN026032
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Aug 2024 00:26:51 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 26 Aug 2024 17:26:51 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>, Laurent Vivier
 <laurent@vivier.eu>
Subject: [PATCH v2 1/2] target/hexagon: rename HEX_EXCP_*=>HEX_CAUSE_*
Date: Mon, 26 Aug 2024 17:26:30 -0700
Message-ID: <20240827002631.3492200-2-bcain@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827002631.3492200-1-bcain@quicinc.com>
References: <20240827002631.3492200-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: hl9PNtia7g1Eud1ep8vmi4oPtlJnIzTr
X-Proofpoint-GUID: hl9PNtia7g1Eud1ep8vmi4oPtlJnIzTr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_17,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 impostorscore=0 mlxlogscore=563 adultscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270002
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

VGhlIHZhbHVlcyBwcmV2aW91c2x5IHVzZWQgZm9yICJIRVhfRVhDUF8qIiB3ZXJlIHRoZSBjYXVz
ZSBjb2RlCmRlZmluaXRpb25zIGFuZCBub3QgdGhlIGV2ZW50IG51bWJlcnMuICBTbyBpbiB0aGlz
IGNvbW1pdCwgd2UgdXBkYXRlCnRoZSBuYW1lcyB0byByZWZsZWN0IHRoZSBjYXVzZSBjb2Rlcy4g
SW4gSEVYX0VWRU5UX1RSQVAwJ3MgY2FzZSwgd2UgYWRkCmEgbmV3ICJIRVhfRVZFTlRfKiIgd2l0
aCB0aGUgY29ycmVjdCBldmVudCBudW1iZXIuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxi
Y2FpbkBxdWljaW5jLmNvbT4KLS0tCiBsaW51eC11c2VyL2hleGFnb24vY3B1X2xvb3AuYyB8ICA0
ICsrLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5oICAgICAgICAgIHwgIDIgKy0KIHRhcmdldC9oZXhh
Z29uL2NwdV9iaXRzLmggICAgIHwgMTUgKysrKysrKystLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9n
ZW5fdGNnLmggICAgICB8ICAyICstCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICB8ICA2
ICsrKy0tLQogNSBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2hleGFnb24vY3B1X2xvb3AuYyBiL2xpbnV4LXVz
ZXIvaGV4YWdvbi9jcHVfbG9vcC5jCmluZGV4IGQ0MTE1OWU1MmEuLjQwZGI1OTYzMDEgMTAwNjQ0
Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jCisrKyBiL2xpbnV4LXVzZXIvaGV4
YWdvbi9jcHVfbG9vcC5jCkBAIC00Miw3ICs0Miw3IEBAIHZvaWQgY3B1X2xvb3AoQ1BVSGV4YWdv
blN0YXRlICplbnYpCiAgICAgICAgIGNhc2UgRVhDUF9JTlRFUlJVUFQ6CiAgICAgICAgICAgICAv
KiBqdXN0IGluZGljYXRlIHRoYXQgc2lnbmFscyBzaG91bGQgYmUgaGFuZGxlZCBhc2FwICovCiAg
ICAgICAgICAgICBicmVhazsKLSAgICAgICAgY2FzZSBIRVhfRVhDUF9UUkFQMDoKKyAgICAgICAg
Y2FzZSBIRVhfRVZFTlRfVFJBUDA6CiAgICAgICAgICAgICBzeXNjYWxsbnVtID0gZW52LT5ncHJb
Nl07CiAgICAgICAgICAgICBlbnYtPmdwcltIRVhfUkVHX1BDXSArPSA0OwogICAgICAgICAgICAg
cmV0ID0gZG9fc3lzY2FsbChlbnYsCkBAIC02MCw3ICs2MCw3IEBAIHZvaWQgY3B1X2xvb3AoQ1BV
SGV4YWdvblN0YXRlICplbnYpCiAgICAgICAgICAgICAgICAgZW52LT5ncHJbMF0gPSByZXQ7CiAg
ICAgICAgICAgICB9CiAgICAgICAgICAgICBicmVhazsKLSAgICAgICAgY2FzZSBIRVhfRVhDUF9Q
Q19OT1RfQUxJR05FRDoKKyAgICAgICAgY2FzZSBIRVhfQ0FVU0VfUENfTk9UX0FMSUdORUQ6CiAg
ICAgICAgICAgICBmb3JjZV9zaWdfZmF1bHQoVEFSR0VUX1NJR0JVUywgVEFSR0VUX0JVU19BRFJB
TE4sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT5ncHJbSEVYX1JFR19SMzFdKTsK
ICAgICAgICAgICAgIGJyZWFrOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90
YXJnZXQvaGV4YWdvbi9jcHUuaAppbmRleCA3NjRmM2MzOGNjLi5jYjgwMzhkN2E4IDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAt
MTQ5LDcgKzE0OSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjcHVfZ2V0X3RiX2NwdV9zdGF0ZShD
UFVIZXhhZ29uU3RhdGUgKmVudiwgdmFkZHIgKnBjLAogICAgIH0KICAgICAqZmxhZ3MgPSBoZXhf
ZmxhZ3M7CiAgICAgaWYgKCpwYyAmIFBDQUxJR05fTUFTSykgewotICAgICAgICBoZXhhZ29uX3Jh
aXNlX2V4Y2VwdGlvbl9lcnIoZW52LCBIRVhfRVhDUF9QQ19OT1RfQUxJR05FRCwgMCk7CisgICAg
ICAgIGhleGFnb25fcmFpc2VfZXhjZXB0aW9uX2VycihlbnYsIEhFWF9DQVVTRV9QQ19OT1RfQUxJ
R05FRCwgMCk7CiAgICAgfQogfQogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHVfYml0
cy5oIGIvdGFyZ2V0L2hleGFnb24vY3B1X2JpdHMuaAppbmRleCA0Mjc5MjgxYTcxLi4yZTYwYzBm
YWZlIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHVfYml0cy5oCisrKyBiL3RhcmdldC9o
ZXhhZ29uL2NwdV9iaXRzLmgKQEAgLTIzLDE0ICsyMywxNSBAQAogI2RlZmluZSBQQ0FMSUdOIDQK
ICNkZWZpbmUgUENBTElHTl9NQVNLIChQQ0FMSUdOIC0gMSkKIAotI2RlZmluZSBIRVhfRVhDUF9G
RVRDSF9OT19VUEFHRSAgMHgwMTIKLSNkZWZpbmUgSEVYX0VYQ1BfSU5WQUxJRF9QQUNLRVQgIDB4
MDE1Ci0jZGVmaW5lIEhFWF9FWENQX0lOVkFMSURfT1BDT0RFICAweDAxNQotI2RlZmluZSBIRVhf
RVhDUF9QQ19OT1RfQUxJR05FRCAgMHgwMWUKLSNkZWZpbmUgSEVYX0VYQ1BfUFJJVl9OT19VUkVB
RCAgIDB4MDI0Ci0jZGVmaW5lIEhFWF9FWENQX1BSSVZfTk9fVVdSSVRFICAweDAyNQorI2RlZmlu
ZSBIRVhfRVZFTlRfVFJBUDAgICAgICAgICAgIDB4MDA4CiAKLSNkZWZpbmUgSEVYX0VYQ1BfVFJB
UDAgICAgICAgICAgIDB4MTcyCisjZGVmaW5lIEhFWF9DQVVTRV9UUkFQMCAgICAgICAgICAgMHgx
NzIKKyNkZWZpbmUgSEVYX0NBVVNFX0ZFVENIX05PX1VQQUdFICAweDAxMgorI2RlZmluZSBIRVhf
Q0FVU0VfSU5WQUxJRF9QQUNLRVQgIDB4MDE1CisjZGVmaW5lIEhFWF9DQVVTRV9JTlZBTElEX09Q
Q09ERSAgMHgwMTUKKyNkZWZpbmUgSEVYX0NBVVNFX1BDX05PVF9BTElHTkVEICAweDAxZQorI2Rl
ZmluZSBIRVhfQ0FVU0VfUFJJVl9OT19VUkVBRCAgIDB4MDI0CisjZGVmaW5lIEhFWF9DQVVTRV9Q
UklWX05PX1VXUklURSAgMHgwMjUKIAogI2RlZmluZSBQQUNLRVRfV09SRFNfTUFYICAgICAgICAg
NAogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmggYi90YXJnZXQvaGV4YWdv
bi9nZW5fdGNnLmgKaW5kZXggM2ZjMWY0ZTI4MS4uOGEzYjgwMTI4NyAxMDA2NDQKLS0tIGEvdGFy
Z2V0L2hleGFnb24vZ2VuX3RjZy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaApAQCAt
MTM2NSw3ICsxMzY1LDcgQEAKICAgICBkbyB7IFwKICAgICAgICAgdWlWID0gdWlWOyBcCiAgICAg
ICAgIHRjZ19nZW5fbW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBjdHgtPnBrdC0+cGMpOyBc
Ci0gICAgICAgIFRDR3YgZXhjcCA9IHRjZ19jb25zdGFudF90bChIRVhfRVhDUF9UUkFQMCk7IFwK
KyAgICAgICAgVENHdiBleGNwID0gdGNnX2NvbnN0YW50X3RsKEhFWF9FVkVOVF9UUkFQMCk7IFwK
ICAgICAgICAgZ2VuX2hlbHBlcl9yYWlzZV9leGNlcHRpb24odGNnX2VudiwgZXhjcCk7IFwKICAg
ICB9IHdoaWxlICgwKQogI2VuZGlmCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xh
dGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IDRiMWJlZTNjNmQuLjRkMDNj
Y2JlZDEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC01OTEsNyArNTkxLDcgQEAgc3RhdGljIHZvaWQgZ2Vu
X2luc24oRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgIGN0eC0+aW5zbi0+Z2VuZXJhdGUoY3R4
KTsKICAgICAgICAgbWFya19zdG9yZV93aWR0aChjdHgpOwogICAgIH0gZWxzZSB7Ci0gICAgICAg
IGdlbl9leGNlcHRpb25fZW5kX3RiKGN0eCwgSEVYX0VYQ1BfSU5WQUxJRF9PUENPREUpOworICAg
ICAgICBnZW5fZXhjZXB0aW9uX2VuZF90YihjdHgsIEhFWF9DQVVTRV9JTlZBTElEX09QQ09ERSk7
CiAgICAgfQogfQogCkBAIC05NjgsNyArOTY4LDcgQEAgc3RhdGljIHZvaWQgZGVjb2RlX2FuZF90
cmFuc2xhdGVfcGFja2V0KENQVUhleGFnb25TdGF0ZSAqZW52LCBEaXNhc0NvbnRleHQgKmN0eCkK
IAogICAgIG53b3JkcyA9IHJlYWRfcGFja2V0X3dvcmRzKGVudiwgY3R4LCB3b3Jkcyk7CiAgICAg
aWYgKCFud29yZHMpIHsKLSAgICAgICAgZ2VuX2V4Y2VwdGlvbl9lbmRfdGIoY3R4LCBIRVhfRVhD
UF9JTlZBTElEX1BBQ0tFVCk7CisgICAgICAgIGdlbl9leGNlcHRpb25fZW5kX3RiKGN0eCwgSEVY
X0NBVVNFX0lOVkFMSURfUEFDS0VUKTsKICAgICAgICAgcmV0dXJuOwogICAgIH0KIApAQCAtOTg0
LDcgKzk4NCw3IEBAIHN0YXRpYyB2b2lkIGRlY29kZV9hbmRfdHJhbnNsYXRlX3BhY2tldChDUFVI
ZXhhZ29uU3RhdGUgKmVudiwgRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgICAgIGdlbl9jb21taXRf
cGFja2V0KGN0eCk7CiAgICAgICAgIGN0eC0+YmFzZS5wY19uZXh0ICs9IHBrdC5lbmNvZF9wa3Rf
c2l6ZV9pbl9ieXRlczsKICAgICB9IGVsc2UgewotICAgICAgICBnZW5fZXhjZXB0aW9uX2VuZF90
YihjdHgsIEhFWF9FWENQX0lOVkFMSURfUEFDS0VUKTsKKyAgICAgICAgZ2VuX2V4Y2VwdGlvbl9l
bmRfdGIoY3R4LCBIRVhfQ0FVU0VfSU5WQUxJRF9QQUNLRVQpOwogICAgIH0KIH0KIAotLSAKMi4z
NC4xCgo=

