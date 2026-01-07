Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EB7CFD63D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTy2-0006iV-IL; Wed, 07 Jan 2026 08:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1vdOgA-0002Y5-Bh; Wed, 07 Jan 2026 03:14:07 -0500
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1vdOg7-0000f4-I0; Wed, 07 Jan 2026 03:14:05 -0500
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4dmLQh4WDjz501bd;
 Wed, 07 Jan 2026 16:13:48 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
 by mse-fl1.zte.com.cn with SMTP id 6078DXRk060114;
 Wed, 7 Jan 2026 16:13:33 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp04[null]) by mapi (Zmail) with MAPI id mid12;
 Wed, 7 Jan 2026 16:13:36 +0800 (CST)
X-Zmail-TransId: 2b06695e15b0e32-0b053
X-Mailer: Zmail v1.0
Message-ID: <20260107161336108RbvgIEJ1pww_fKZtMreFp@zte.com.cn>
Date: Wed, 7 Jan 2026 16:13:36 +0800 (CST)
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Subject: =?UTF-8?B?W1BBVENIXSB0YXJnZXQvcmlzY3Y6IFJlbW92ZSByZWR1bmRhbnQgbWFjcm8gZGVmaW5pdGlvbnM=?=
Content-Type: multipart/mixed;
	boundary="=====_001_next====="
X-MAIL: mse-fl1.zte.com.cn 6078DXRk060114
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 07 Jan 2026 16:13:48 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 695E15BC.001/4dmLQh4WDjz501bd
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 07 Jan 2026 08:52:49 -0500
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



--=====_001_next=====
Content-Type: multipart/related;
	boundary="=====_002_next====="


--=====_002_next=====
Content-Type: multipart/alternative;
	boundary="=====_003_next====="


--=====_003_next=====
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbTogeWVjaGFvLXcgPHdhbmcueWVjaGFvMjU1QHp0ZS5jb20uY24+DQoNClRoZSBtYWNybyBN
TVVfVVNFUl9JRFggaXMgdW51c2VkLCBhbmQgaXRzIGRlZmluZWQgdmFsdWUgaXMgaW5jb3JyZWN0
Lg0KSXQgc2hvdWxkIGJlIE1NVUlkeF9VKDApLCB3aGljaCBpcyBkZWZpbmVkIGluIHRhcmdldC9y
aXNjdi9pbnRlcm5hbHMuaC4NClRoZXJlZm9yZSwgcmVtb3ZlIHRoZSBtYWNybyBkZWZpbml0aW9u
IG9mIE1NVV9VU0VSX0lEWC4NCg0KU2lnbmVkLW9mZi1ieTogeWVjaGFvLXcgPHdhbmcueWVjaGFv
MjU1QHp0ZS5jb20uY24+DQotLS0NCiB0YXJnZXQvcmlzY3YvY3B1LmggfCAyIC0tDQogMSBmaWxl
IGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1
LmggYi90YXJnZXQvcmlzY3YvY3B1LmgNCmluZGV4IDkwYjNlOTUxMDUuLmUzODk5YjQ5ZWYgMTAw
NjQ0DQotLS0gYS90YXJnZXQvcmlzY3YvY3B1LmgNCisrKyBiL3RhcmdldC9yaXNjdi9jcHUuaA0K
QEAgLTE3Miw4ICsxNzIsNiBAQCBleHRlcm4gUklTQ1ZDUFVJbXBsaWVkRXh0c1J1bGUgKnJpc2N2
X211bHRpX2V4dF9pbXBsaWVkX3J1bGVzW107DQogDQogI2RlZmluZSBSSVNDVl9JTVBMSUVEX0VY
VFNfUlVMRV9FTkQgLTENCiANCi0jZGVmaW5lIE1NVV9VU0VSX0lEWCAzDQotDQogI2RlZmluZSBN
QVhfUklTQ1ZfUE1QUyAoNjQpDQogI2RlZmluZSBPTERfTUFYX1JJU0NWX1BNUFMgKDE2KQ0KICNk
ZWZpbmUgTUlOX1JJU0NWX1BNUF9HUkFOVUxBUklUWSA0DQotLSANCjIuMjcuMA==


--=====_003_next=====
Content-Type: text/html ;
	charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBjbGFzcz0iemNvbnRlbnRSb3ciPjxwPkZyb206IHllY2hhby13ICZsdDt3YW5nLnllY2hh
bzI1NUB6dGUuY29tLmNuJmd0OzwvcD48cD48YnI+PC9wPjxwPlRoZSBtYWNybyBNTVVfVVNFUl9J
RFggaXMgdW51c2VkLCBhbmQgaXRzIGRlZmluZWQgdmFsdWUgaXMgaW5jb3JyZWN0LjwvcD48cD5J
dCBzaG91bGQgYmUgTU1VSWR4X1UoMCksIHdoaWNoIGlzIGRlZmluZWQgaW4gdGFyZ2V0L3Jpc2N2
L2ludGVybmFscy5oLjwvcD48cD5UaGVyZWZvcmUsIHJlbW92ZSB0aGUgbWFjcm8gZGVmaW5pdGlv
biBvZiBNTVVfVVNFUl9JRFguPC9wPjxwPjxicj48L3A+PHA+U2lnbmVkLW9mZi1ieTogeWVjaGFv
LXcgJmx0O3dhbmcueWVjaGFvMjU1QHp0ZS5jb20uY24mZ3Q7PC9wPjxwPi0tLTwvcD48cD4mbmJz
cDt0YXJnZXQvcmlzY3YvY3B1LmggfCAyIC0tPC9wPjxwPiZuYnNwOzEgZmlsZSBjaGFuZ2VkLCAy
IGRlbGV0aW9ucygtKTwvcD48cD48YnI+PC9wPjxwPmRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3Yv
Y3B1LmggYi90YXJnZXQvcmlzY3YvY3B1Lmg8L3A+PHA+aW5kZXggOTBiM2U5NTEwNS4uZTM4OTli
NDllZiAxMDA2NDQ8L3A+PHA+LS0tIGEvdGFyZ2V0L3Jpc2N2L2NwdS5oPC9wPjxwPisrKyBiL3Rh
cmdldC9yaXNjdi9jcHUuaDwvcD48cD5AQCAtMTcyLDggKzE3Miw2IEBAIGV4dGVybiBSSVNDVkNQ
VUltcGxpZWRFeHRzUnVsZSAqcmlzY3ZfbXVsdGlfZXh0X2ltcGxpZWRfcnVsZXNbXTs8L3A+PHA+
Jm5ic3A7PC9wPjxwPiZuYnNwOyNkZWZpbmUgUklTQ1ZfSU1QTElFRF9FWFRTX1JVTEVfRU5EIC0x
PC9wPjxwPiZuYnNwOzwvcD48cD4tI2RlZmluZSBNTVVfVVNFUl9JRFggMzwvcD48cD4tPC9wPjxw
PiZuYnNwOyNkZWZpbmUgTUFYX1JJU0NWX1BNUFMgKDY0KTwvcD48cD4mbmJzcDsjZGVmaW5lIE9M
RF9NQVhfUklTQ1ZfUE1QUyAoMTYpPC9wPjxwPiZuYnNwOyNkZWZpbmUgTUlOX1JJU0NWX1BNUF9H
UkFOVUxBUklUWSA0PC9wPjxwPi0tJm5ic3A7PC9wPjxwPjIuMjcuMDwvcD48cCBzdHlsZT0iZm9u
dC1zaXplOjE0cHg7Zm9udC1mYW1pbHk65b6u6L2v6ZuF6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxi
cj48L3A+PHAgc3R5bGU9ImZvbnQtc2l6ZToxNHB4O2ZvbnQtZmFtaWx5OuW+rui9r+mbhem7kSxN
aWNyb3NvZnQgWWFIZWk7Ij48YnI+PC9wPjxwIHN0eWxlPSJmb250LXNpemU6MTRweDtmb250LWZh
bWlseTrlvq7ova/pm4Xpu5EsTWljcm9zb2Z0IFlhSGVpOyI+PGJyPjwvcD48cCBzdHlsZT0iZm9u
dC1zaXplOjE0cHg7Zm9udC1mYW1pbHk65b6u6L2v6ZuF6buRLE1pY3Jvc29mdCBZYUhlaTsiPjxi
cj48L3A+PC9kaXY+


--=====_003_next=====--

--=====_002_next=====--

--=====_001_next=====--


