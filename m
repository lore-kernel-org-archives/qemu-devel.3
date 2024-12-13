Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6525AE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 09:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM2II-00025u-CO; Fri, 13 Dec 2024 04:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=070864293=kenneth_jia@asus.com>)
 id 1tM2IF-000252-DV; Fri, 13 Dec 2024 04:49:07 -0500
Received: from ms.asus.com ([103.10.4.142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=070864293=kenneth_jia@asus.com>)
 id 1tM2ID-0007fL-7Z; Fri, 13 Dec 2024 04:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=asus.com; i=@asus.com; q=dns/txt; s=asuscom;
 t=1734083345; x=1765619345;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZBzLZSkUBRK8jeGbKSWmNvoq7xXyF5AQsM8nAn9lZPQ=;
 b=0IN8q/Uib47rE9iPTx8t59ku37dtJqVMgTVkphy4dBoshDWMdLS71YQD
 0zoeL/XJRfwxbdOEXknfdkskT2XW21xu9ucbvvI+Z6PjSrNvFLj9kP00I
 6SzqPFY9YHfJ8U6GoCjGSiNePCemK82a69te//HNp6jMnPUYwgaQzne6h g=;
IronPort-Data: A9a23:9lawd623skKmybnxkvbD5ftwkn2cJEfYwER7XKvMYLTBsI5bpzVSx
 mFKWmqPOa6JNGH0ft9wYd+zp0IAuZCGzN9lHVQ6qSg9HnlHl5HIVI+TRqvSF3rJd5WcFiqLz
 Cm8hv3odp1coqr0+0/F3oDJ9CU6j+fTLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsenuWEULOb828sWo4rw//bwP9flKyakC8VuFU4ecdKsDf2/5XCJMlHTU0ZByKQrrh8RoZWd
 c6apF2K1jqxEyMWNz+Quu2Tnnvm4lLlFVPmZnJ+A8BOi/XZz8A4+v5T2PE0MS+7h9gV9jzYJ
 RokWZGYEG8U0qPwdOs1aQVEOCxhF658pITIIl2mt8u39U/HfC65qxluJBle0Yww081cREx+r
 KJdFmhUKBmIjKS9x6ijTORwwM04MdKD0IE34y46i2uIS616B8maK0nJzYYwMDMYhc1IG/vCZ
 /0baDNHZQ/deFtEPVJ/5JcWxbv22yWjK2AwRFS9oJpu0XePyjZL+6XXGfPIWMOMYtt5txPNz
 o7B1yGjav0AD/SUzTWt8XuriqnIhyyTcJsfEaD9/+RvqFuUwGMVFVsRT1TTifK9hWakVt5fI
 lBS8S0rxYAq9E2vS9XVWxy+qWSD+BkGVLJ4EeQ/6Qe6zqvSyw+CHmUJQiJMY9xgv8gzLRQj0
 FOTkszBDjtjvbaST2mB7KqfsXW5Pi1TJHJqTSAfTQIDy8PurIE6klTESdMLOLe4i8CwFTzuz
 jSiqi84iLMOy8kR2M2GEUvv2m324MKYCFVpoFyONo640j5EiEeeT9TAwTDmATxodu51knHpU
 KA4pvWj
IronPort-HdrOrdr: A9a23:BNb7v6h75ob+OYsA/5eJP9SNtHBQXk0ji2hC6mlwRA09TyXBrb
 HIoBwavSWatN9jYgBHpTnmAtj0fZq8z+8G3WB/B8bAYOCLggaVxcRZnO/fKl7balnDH4xmpM
 VdmsFFYbWaZ2SSz/yKhTVQeOxP/DDzysCVbJDlrkuFIzsHV0gq1XYBNu/SKDwPeOBpP+tDKH
 LHi/A33QZJWhksH7mG7jlpZZm9mzWE+aiWHyLvSXQcmXqzZYHE0s+HLzGImgobWylChawv63
 TBjmXCl9SemuD+1xvVzWOW8JhMgtvmzbJ4dbyxtvQ=
X-Talos-CUID: 9a23:mrXQ/mCpoMDocCn6ExN76GUZBeomSCHmw3T1Okm/LVxrSbLAHA==
X-Talos-MUID: 9a23:sV4y4QS5XCiMduvwRXTptGhQK5tu2Z6FFXokuIgkpM+jKwBZbmI=
Received: from unknown (HELO ACC-EX16-V01.acc.corpnet.asus) ([172.29.34.11])
 by ms.asus.com with ESMTP; 13 Dec 2024 17:48:52 +0800
Received: from ACC-EX16-V03.acc.corpnet.asus (172.29.34.13) by
 ACC-EX16-V01.acc.corpnet.asus (172.29.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.43; Fri, 13 Dec 2024 17:48:48 +0800
Received: from ACC-EX16-V03.acc.corpnet.asus ([fe80::3dae:532a:2ef6:9654]) by
 ACC-EX16-V03.acc.corpnet.asus ([fe80::3dae:532a:2ef6:9654%3]) with
 mapi id 15.01.2507.043; Fri, 13 Dec 2024 17:48:48 +0800
To: =?utf-8?B?J0PDqWRyaWMgTGUgR29hdGVyJw==?= <clg@kaod.org>,
 "'qemu-arm@nongnu.org'" <qemu-arm@nongnu.org>
CC: =?utf-8?B?J0PDqWRyaWMgTGUgR29hdGVyJw==?= <clg@redhat.com>,
 =?utf-8?B?J1BoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpJw==?= <philmd@linaro.org>, "'Jamin
 Lin'" <jamin_lin@aspeedtech.com>, 'Andrew Jeffery'
 <andrew@codeconstruct.com.au>, 'Gavin Shan' <gshan@redhat.com>, "'open
 list:All patches CC here'" <qemu-devel@nongnu.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGh3L2FybS9hc3BlZWQ6IGZpeCBjb25uZWN0X3Nl?=
 =?utf-8?B?cmlhbF9oZHNfdG9fdWFydHM=?=
Thread-Topic: [PATCH] hw/arm/aspeed: fix connect_serial_hds_to_uarts
Thread-Index: AQHbTS9dSL1vUYsQ8E2tdLoBmzCJz7Lj503A
Date: Fri, 13 Dec 2024 09:48:48 +0000
Message-ID: <4c9f90399854448497317465c1e4cedc@asus.com>
References: <5f9b0c53f1644922ba85522046e92f4c@asus.com>
 <8af809d7-5fa2-471f-9fc9-eee482988894@kaod.org>
In-Reply-To: <8af809d7-5fa2-471f-9fc9-eee482988894@kaod.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.68.200.222]
x-tm-as-product-ver: SMEX-14.0.0.3223-9.1.2019-28826.004
x-tm-as-result: No-10--24.342000-8.000000
x-tmase-matchedrid: EF5z2ETDrAcfHU5fltg9RlY9XYa1m8xA1gfGMJv7tZK1GZp9GnkU8y67
 ox+QMz1gAHg/HS2tqGjosUIDPdsTU2s7XhibDX9dUlO0zoIcpU6exJFd1f8r+3NxS8QcqzsbLqc
 Doo8mZno2c+sa3AtBUqeeKmVKb44CvEQ3AnZS8ITipEa3UDsZRA2LmwHT7i+nX7YFvCOGcWk+ly
 66+9jDJLAjxeuur58TI89VAyvsIp0yVLl90PKZQro2KXQsvVZSVPQ3cbOrxNL/GDyR80F454XVe
 AzWzPHrEiKTmSPOUFcC+EBKhxaceufMaGeNZQ39WZxYhPYYrMlBqFX02wvtDw7PBVWyPtn/9NFK
 rIIXgXw9NEjD7ulfbyQWr8B5J1Z+zEhV/IuzF6L6KF0S1zktZ+5zvRYCQLoV30z/E8e/OqLjEt1
 EiGuYH9FETOOg+TX0tH3PC6sB1AhdXCl/d5Ej2xqsS/8jaA/K1c04BDYxKLaa4ymjlcrDbznxJq
 un3snzhyRlPlpuvG6bCOivU2HrCzJJUfUG/qfc
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--24.342000-8.000000
x-tmase-version: SMEX-14.0.0.3223-9.1.2019-28826.004
x-tm-snts-smtp: 02D2D8B39B737C5B81FB6C2E50EA4C39DC9B2B62D3690B2A6EFE7FFFC0A270682000:9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=103.10.4.142;
 envelope-from=prvs=070864293=kenneth_jia@asus.com; helo=ms.asus.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  =?utf-8?B?S2VubmV0aCBKaWEo6LS+57qq5LicX+WNjuehleS4iua1tyk=?=
 <kenneth_jia@asus.com>
From: kenneth_jia--- via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

IFdlIHBsYW5zIHRvIHVzZSBhIHJlbGF0aXZlbHkgbGFyZ2UgbnVtYmVyIG9mIFVBUlQgY29ubmVj
dGlvbnMsIGFuZCBjdXJyZW50bHkgdGVzdCBhbGwgVUFSVHMgdGhhdCBjYW4gYmUgdXNlZC4gDQpX
aGVuIHdlIHVzZSBxdW11IGZvciBzaW11bGF0aW9uLCB0aGUgcHJvYmxlbSB3YXMgZGlzY292ZXJl
ZC4NCiBUaGUgY3VycmVudCBjb2RlIGRvZXMgbm90IGFsbG9jYXRlIGNoYXIgZGV2aWNlcyB3aXRo
IGluZGV4IDUgKGxhYmVsIHNlcmlhbDUpLg0KIEFuZCBldmVuIGlmIHRoZXJlIGFyZSBtb3JlIHNl
cmlhbCBkZXZpY2VzLCB0aGUgbGFzdCBvbmUgKFVBUjEyKSAgaXMgbm90IGNvbm5lY3RlZCB0byBz
ZXJpYWwuDQoNCkFkZCBkZWJ1ZyBpbmZvcm1hdGlvbiB0byB3YXRjaDoNCg0KZGlmZiAtLWdpdCBh
L2h3L2FybS9hc3BlZWQuYyBiL2h3L2FybS9hc3BlZWQuYw0KaW5kZXggNTU2NDk4ZjJhMC4uNzg2
ZGY0NTBlZCAxMDA2NDQNCi0tLSBhL2h3L2FybS9hc3BlZWQuYw0KKysrIGIvaHcvYXJtL2FzcGVl
ZC5jDQpAQCAtMzY5LDYgKzM2OSw3IEBAIHN0YXRpYyB2b2lkIGNvbm5lY3Rfc2VyaWFsX2hkc190
b191YXJ0cyhBc3BlZWRNYWNoaW5lU3RhdGUgKmJtYykNCiAgICAgICAgICAgICBjb250aW51ZTsN
CiAgICAgICAgIH0NCiAgICAgICAgIGFzcGVlZF9zb2NfdWFydF9zZXRfY2hyKHMsIHVhcnQsIHNl
cmlhbF9oZChpKSk7DQorICAgICAgIHByaW50ZigidWFydCAlZCBjaGFyIGluZGV4ICVkIG5hbWUg
JXNcbiIsIHVhcnQtc2MtPnVhcnRzX2Jhc2UsIGksIHNlcmlhbF9oZChpKT9zZXJpYWxfaGQoaSkt
PmZpbGVuYW1lOiJudWxsIik7DQogICAgIH0NCiB9DQoNClRlc3QgY29tbWFuZA0KICAgICAgICB+
L29mZmljZV9xZW11L2J1aWxkL3FlbXUtc3lzdGVtLWFybSAtbSAxRyAtTSBhc3QyNjAwLWV2Yixm
bWMtbW9kZWw9bXg2NmwxZzQ1ZyAtbm9ncmFwaGljIFwNCiAgICAgICAgLWRyaXZlIGZpbGU9Li8k
e2V2Yn0uYmluLGZvcm1hdD1yYXcsaWY9bXRkLHVuaXQ9MCBcDQogICAgICAgIC1kcml2ZSBmaWxl
PS4vZW1tYzEuYmluLGZvcm1hdD1yYXcsaWY9c2QsdW5pdD0yIFwNCiAgICAgICAgLW5ldCBuaWMg
LW5ldCBuaWMgLW5ldCBuaWMgLW5ldCBuaWMgXA0KICAgICAgICAtbmV0IHVzZXIsaG9zdGZ3ZD06
OjI0NDMtOjQ0Myxob3N0ZndkPTo6MjI0Mi06MjIsaG9zdGZ3ZD11ZHA6OjI2MjMtOjYyMyBcDQog
ICAgICAgIC1zZXJpYWwgcHR5IFwNCiAgICAgICAgLXNlcmlhbCBwdHkgXA0KICAgICAgICAtc2Vy
aWFsIHB0eSBcDQogICAgICAgIC1zZXJpYWwgcHR5IFwNCiAgICAgICAgLXNlcmlhbCBwdHkgXA0K
ICAgICAgICAtc2VyaWFsIHB0eSBcDQogICAgICAgIC1zZXJpYWwgcHR5IFwNCiAgICAgICAgLXNl
cmlhbCBwdHkgXA0KICAgICAgICAtc2VyaWFsIHB0eSBcDQogICAgICAgIC1zZXJpYWwgcHR5IFwN
CiAgICAgICAgLXNlcmlhbCBwdHkgXA0KICAgICAgICAtc2VyaWFsIHB0eSBcDQogICAgICAgIC1z
ZXJpYWwgcHR5IFwNCiAgICAgICAgLXNlcmlhbCBwdHkNCg0KT3V0cHV0IExvZzogDQoNClFFTVUg
OS4yLjUwIG1vbml0b3IgLSB0eXBlICdoZWxwJyBmb3IgbW9yZSBpbmZvcm1hdGlvbg0KY2hhciBk
ZXZpY2UgcmVkaXJlY3RlZCB0byAvZGV2L3B0cy82IChsYWJlbCBzZXJpYWwwKQ0KY2hhciBkZXZp
Y2UgcmVkaXJlY3RlZCB0byAvZGV2L3B0cy83IChsYWJlbCBzZXJpYWwxKQ0KY2hhciBkZXZpY2Ug
cmVkaXJlY3RlZCB0byAvZGV2L3B0cy84IChsYWJlbCBzZXJpYWwyKQ0KY2hhciBkZXZpY2UgcmVk
aXJlY3RlZCB0byAvZGV2L3B0cy85IChsYWJlbCBzZXJpYWwzKQ0KY2hhciBkZXZpY2UgcmVkaXJl
Y3RlZCB0byAvZGV2L3B0cy8xMCAobGFiZWwgc2VyaWFsNCkNCmNoYXIgZGV2aWNlIHJlZGlyZWN0
ZWQgdG8gL2Rldi9wdHMvMTEgKGxhYmVsIHNlcmlhbDUpDQpjaGFyIGRldmljZSByZWRpcmVjdGVk
IHRvIC9kZXYvcHRzLzEyIChsYWJlbCBzZXJpYWw2KQ0KY2hhciBkZXZpY2UgcmVkaXJlY3RlZCB0
byAvZGV2L3B0cy8xMyAobGFiZWwgc2VyaWFsNykNCmNoYXIgZGV2aWNlIHJlZGlyZWN0ZWQgdG8g
L2Rldi9wdHMvMTQgKGxhYmVsIHNlcmlhbDgpDQpjaGFyIGRldmljZSByZWRpcmVjdGVkIHRvIC9k
ZXYvcHRzLzE1IChsYWJlbCBzZXJpYWw5KQ0KY2hhciBkZXZpY2UgcmVkaXJlY3RlZCB0byAvZGV2
L3B0cy8xNiAobGFiZWwgc2VyaWFsMTApDQpjaGFyIGRldmljZSByZWRpcmVjdGVkIHRvIC9kZXYv
cHRzLzE3IChsYWJlbCBzZXJpYWwxMSkNCmNoYXIgZGV2aWNlIHJlZGlyZWN0ZWQgdG8gL2Rldi9w
dHMvMTkgKGxhYmVsIHNlcmlhbDEyKQ0KY2hhciBkZXZpY2UgcmVkaXJlY3RlZCB0byAvZGV2L3B0
cy8yMSAobGFiZWwgc2VyaWFsMTMpDQpjaGFyIGRldmljZSByZWRpcmVjdGVkIHRvIC9kZXYvcHRz
LzIyIChsYWJlbCBzZXJpYWwxNCkNCnVhcnQgMCBjaGFyIGluZGV4IDEgbmFtZSBwdHk6L2Rldi9w
dHMvNw0KdWFydCAxIGNoYXIgaW5kZXggMiBuYW1lIHB0eTovZGV2L3B0cy84DQp1YXJ0IDIgY2hh
ciBpbmRleCAzIG5hbWUgcHR5Oi9kZXYvcHRzLzkNCnVhcnQgMyBjaGFyIGluZGV4IDQgbmFtZSBw
dHk6L2Rldi9wdHMvMTANCnVhcnQgNSBjaGFyIGluZGV4IDYgbmFtZSBwdHk6L2Rldi9wdHMvMTIN
CnVhcnQgNiBjaGFyIGluZGV4IDcgbmFtZSBwdHk6L2Rldi9wdHMvMTMNCnVhcnQgNyBjaGFyIGlu
ZGV4IDggbmFtZSBwdHk6L2Rldi9wdHMvMTQNCnVhcnQgOCBjaGFyIGluZGV4IDkgbmFtZSBwdHk6
L2Rldi9wdHMvMTUNCnVhcnQgOSBjaGFyIGluZGV4IDEwIG5hbWUgcHR5Oi9kZXYvcHRzLzE2DQp1
YXJ0IDEwIGNoYXIgaW5kZXggMTEgbmFtZSBwdHk6L2Rldi9wdHMvMTcNCnVhcnQgMTEgY2hhciBp
bmRleCAxMiBuYW1lIHB0eTovZGV2L3B0cy8xOQ0KKHFlbXUpDQoNCklzc3VlOiANCi9kZXYvcHRz
LzE3IChsYWJlbCBzZXJpYWwxMSkgaXMgbm90IGNvbm5lY3RlZCB0byBhIFVBUlQsDQpVQVJUMTIg
aXMgbm90IGNvbm5lY3QgdG8gYSBzZXJpYWwgZGV2aWNlLg0KDQotLS0tLemCruS7tuWOn+S7ti0t
LS0tDQrlj5Hku7bkuro6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+IA0K5Y+R6YCB
5pe26Ze0OiAyMDI05bm0MTLmnIgxM+aXpSAxNToxOQ0K5pS25Lu25Lq6OiBLZW5uZXRoIEppYSjo
tL7nuqrkuJxf5Y2O56GV5LiK5rW3KSA8a2VubmV0aF9qaWFAYXN1cy5jb20+OyAncWVtdS1hcm1A
bm9uZ251Lm9yZycgPHFlbXUtYXJtQG5vbmdudS5vcmc+DQrmioTpgIE6ICdDw6lkcmljIExlIEdv
YXRlcicgPGNsZ0ByZWRoYXQuY29tPjsgJ1BoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpJyA8cGhpbG1k
QGxpbmFyby5vDQo+IA0KPiBTdWJqZWN0OiBbUEFUQ0hdwqDCoMKgIGh3L2FybS9hc3BlZWQ6IGZp
eCBjb25uZWN0X3NlcmlhbF9oZHNfdG9fdWFydHMNCj4gDQo+ICDCoMKgIEluIHRoZSBsb29wLCB3
ZSBuZWVkIGlnbm9yZSB0aGUgaW5kZXggaW5jcmVhc2Ugd2hlbiB1YXJ0ID09IA0KPiB1YXJ0X2No
b3Nlbg0KPiANCj4gIMKgwqAgV2Ugc2hvdWxkIGluY3JlYXNlIHRoZSBpbmRleCBvbmx5IGFmdGVy
IHdlIGFsbG9jYXRlIGEgc2VyaWFsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2VubmV0aCBKaWEg
PGtlbm5ldGhfamlhQGFzdXMuY29tPg0KDQpDb3VsZCB5b3UgcGxlYXNlIHRlbGwgdXMgYSBiaXQg
b24geW91ciB0ZXN0IGVudmlyb25tZW50ID8gSSBhbSBpbnRlcmVzdGVkIHRvIGtub3cgaG93IHlv
dSBmb3VuZCB0aGUgaXNzdWUuDQoNCkFsc28sIHBsZWFzZSB1c2UgImdpdCBzZW5kLWVtYWlsIiB0
byBzZW5kIHBhdGNoZXMuDQoNCkFueWhvdywNCg0KRml4ZXM6IGQyYjNlYWVmYjRkNyAoImFzcGVl
ZDogUmVmYWN0b3IgVUFSVCBpbml0IGZvciBtdWx0aS1Tb0MgbWFjaGluZXMiKQ0KUmV2aWV3ZWQt
Ynk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCg0KVGhhbmtzLA0KDQpDLg0K
DQoNCg0KPiANCj4gLS0tDQo+IA0KPiBody9hcm0vYXNwZWVkLmMgfCA0ICsrLS0NCj4gDQo+IDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvaHcvYXJtL2FzcGVlZC5jIGIvaHcvYXJtL2FzcGVlZC5jDQo+IA0KPiBpbmRleCA1
NTY0OThmMmEwLi5kOGNiMmQxNDI5IDEwMDY0NA0KPiANCj4gLS0tIGEvaHcvYXJtL2FzcGVlZC5j
DQo+IA0KPiArKysgYi9ody9hcm0vYXNwZWVkLmMNCj4gDQo+IEBAIC0zNjQsMTEgKzM2NCwxMSBA
QCBzdGF0aWMgdm9pZCANCj4gY29ubmVjdF9zZXJpYWxfaGRzX3RvX3VhcnRzKEFzcGVlZE1hY2hp
bmVTdGF0ZSAqYm1jKQ0KPiANCj4gIMKgwqDCoMKgIGludCB1YXJ0X2Nob3NlbiA9IGJtYy0+dWFy
dF9jaG9zZW4gPyBibWMtPnVhcnRfY2hvc2VuIDogDQo+IGFtYy0+dWFydF9kZWZhdWx0Ow0KPiAN
Cj4gIMKgwqDCoMKgIGFzcGVlZF9zb2NfdWFydF9zZXRfY2hyKHMsIHVhcnRfY2hvc2VuLCBzZXJp
YWxfaGQoMCkpOw0KPiANCj4gLcKgwqDCoCBmb3IgKGludCBpID0gMSwgdWFydCA9IHNjLT51YXJ0
c19iYXNlOyBpIDwgc2MtPnVhcnRzX251bTsgaSsrLCANCj4gdWFydCsrKSB7DQo+IA0KPiArwqDC
oMKgIGZvciAoaW50IGkgPSAxLCB1YXJ0ID0gc2MtPnVhcnRzX2Jhc2U7IGkgPCBzYy0+dWFydHNf
bnVtOyB1YXJ0KyspIA0KPiArew0KPiANCj4gIMKgwqDCoMKgwqDCoMKgwqAgaWYgKHVhcnQgPT0g
dWFydF9jaG9zZW4pIHsNCj4gDQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7
DQo+IA0KPiAgwqDCoMKgwqDCoMKgwqDCoCB9DQo+IA0KPiAtwqDCoMKgwqDCoMKgwqAgYXNwZWVk
X3NvY191YXJ0X3NldF9jaHIocywgdWFydCwgc2VyaWFsX2hkKGkpKTsNCj4gDQo+ICvCoMKgwqDC
oMKgwqDCoCBhc3BlZWRfc29jX3VhcnRfc2V0X2NocihzLCB1YXJ0LCBzZXJpYWxfaGQoaSsrKSk7
DQo+IA0KPiAgwqDCoMKgwqAgfQ0KPiANCj4gfQ0KPiANCj4gLS0NCj4gDQo+IDIuMzQuMQ0KPiAN
Cg0KDQo8cD48L3A+DQo=

