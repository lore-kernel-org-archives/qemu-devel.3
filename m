Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0091FC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLIm-0001Aq-S3; Thu, 17 Jul 2025 05:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuxu@nucleisys.com>)
 id 1ucL4y-0006UW-Vm
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:39:05 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuxu@nucleisys.com>)
 id 1ucL4u-0002Ot-3t
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 05:39:04 -0400
EX-QQ-RecipientCnt: 2
X-QQ-GoodBg: 2
X-QQ-SSF: 0040000000000020
X-QQ-FEAT: D4aqtcRDiqRcMYJqMribwDcfWW2l8/zX+RYd2q+DLGU=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: 08fw80xXqqVpTJo68eDZxOatFOXQ/VwMQ2Oi3L4LrXY=
X-Originating-IP: 219.139.164.119
X-QQ-STYLE: 
X-QQ-mid: lv3gz6a-0t1752745114t970b4c98
From: "=?utf-8?B?bGl1eHU=?=" <liuxu@nucleisys.com>
To: "=?utf-8?B?QWxpc3RhaXIgRnJhbmNpcw==?=" <alistair23@gmail.com>
Cc: "=?utf-8?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Subject: Re: [PATCH qemu v9 0/1] target/riscv: Add Zilsd and Zclsd extension
 support
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 17 Jul 2025 17:38:34 +0800
X-Priority: 3
Message-ID: <tencent_69C9D55C68275BF255B786F3@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <175014178352.19565.9471325854234944512-0@git.sr.ht>
 <CAKmqyKPWDwi9XnzmdpKe5PN9uu+FFTTcuVNYgiz-GWV75MCWeg@mail.gmail.com>
In-Reply-To: <CAKmqyKPWDwi9XnzmdpKe5PN9uu+FFTTcuVNYgiz-GWV75MCWeg@mail.gmail.com>
X-QQ-ReplyHash: 3702011255
X-BIZMAIL-ID: 9748317292152879255
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Thu, 17 Jul 2025 17:38:35 +0800 (CST)
Feedback-ID: lv:nucleisys.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: Naz1YHCzw2jIwdMD1WV17tflx1/UYraJXf5wq8ht35ztWdzKyvZm9I3M
 4GqSPqWiTCagifUCsvRbKD/m8dTkmRt73vEk2FLAt+nEeeVA4QJXKmZSZW+dseTDeJMHsRE
 h8/5ElfdVyV8baMMNIumOYnD4SQsqyliVjFn5aHfuQJWYHLT7w/t2b4ljCgghiVW3/EMK8i
 1nKNFmXGC94MZT+j8Rx5GFubGWm8+VhOZ8ZRzNkxF5qlzbCR9hCEl0hOL2VtToZZ4UzBmYD
 KwA12IivVXM5sy4urItSJrNoYa3RxeNYviK7WJVXmyhBPb7WlNEMiq/TFIBtt+mfdzULFj6
 mi7SxbjzhIe0OsAs7wwB59FUAWAtLgaSmBQ+sg3i/b4uM9Rd/7p6FSsVi2eUa/ovUXd7nzH
 75pF3BmoLWNRSu4cRVkf3vyWVAAkVB0RBtyj+U2v+D/T9UKxU6NvYnYO95IzzPHOwYOJn8g
 hAr+C06bJkhkkMiJLnL0HTYhaRDgmmQRbuUBqhkvIfgdfmFW6S2+6yeYB2B/uqBGKXsUU9z
 gWTMLhE7YfCsdSx7rL0PSbCaRpvzqPnZBtieQLk7zUMA1jsr+bQM4lqlWSsdV12mbvuA4JS
 V8lyxfXi+UrN4qK173Zi7nW9vuv9/4GwS1y3lGklNunlVV6NvLht+qeGv+krvMVKnBD2gf/
 fJ21gp2DJLW3puFjzM5NtRoSajRbhutsaecxM2luGs/F4avS+48y7okHrL7+/ijV20v5Xsz
 8wsXi3H8SKZ+Z+EAVbg5o+YuXRZfhu1CZUqS09GLHPPb8FojaXN4Z7i/tdki305k+SRx0OR
 8BrhlxsJke5nMPQI7lGwr6B8M2/B2L+EEQ5/psWgMmQk1YSRpdyYPD6OnQ1Dj1XENymodUM
 et5pF9KhKAoyer8ZAM9dd8qfVPW/sPFTPyUZqejzSPhfX8b4Ywb6+JQbbMBdzp8iYWmndy6
 RxUyD6IJrW4wmmLWkmjarG3HSxLIgZjj/3X+tQlt4+PG19Ngn0FCU2NgSLq2gGsLzMlI=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
Received-SPF: pass client-ip=54.254.200.128; envelope-from=liuxu@nucleisys.com;
 helo=smtpbgsg2.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FROM_EXCESS_BASE64=0.001,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Pk9uIFR1ZSwgSnVuIDE3LCAyMDI1IGF0IDQ6MjnigK9QTSB+bGl1eHUgPGxpdXh1QGdpdC5z
ci5odD4gd3JvdGU6DQo+Pg0KPj4gVGhhbmtzIGZvciBBbGlzdGFpcidzIGNvcnJlY3Rpb24g
b24gdGhlIFY4IHZlcnNpb24uDQo+Pg0KPj4gTm93IFpjbHNkIGhhcyBiZWVuIGRpc2FibGVk
IGZvciB0aGUgIm1heCIgQ1BVIGFzIEMgYW5kIEYgYXJlIGFscmVhZHkNCj4+IGVuYWJsZWQu
DQo+DQo+VGhpcyBpcyBzdGlsbCBicm9rZW4gd2l0aCB1c2Vyc3BhY2UgbW9kZToNCj4NCj5g
YGANCj5xZW11LXJpc2N2NjQ6IFpjbHNkIGNhbm5vdCBiZSBzdXBwb3J0ZWQgdG9nZXRoZXIg
d2l0aCBDIGFuZCBGIGV4dGVuc2lvbg0KPmBgYA0KPg0KPkFsaXN0YWlyDQoNCkNvdWxkIHlv
dSBwbGVhc2UgdGVsbCBtZSB0aGUgc3BlY2lmaWMgcmVwcm9kdWN0aW9uIG1ldGhvZD8gDQpJ
IGhhdmUgcmUtcmV2aWV3ZWQgdGhlIGNvZGUgYW5kIHRyaWVkIHRoZSB0ZXN0cyB0aGF0IGNv
bWUgd2l0aCBxZW11LA0KYnV0IEkgc3RpbGwgaGF2ZW4ndCBmaWd1cmVkIG91dCB3aHkgdGhl
IGFib3ZlIGVycm9yIG9jY3VycmUuDQoNCj4+IGx4eCAoMSk6DQo+PiAgIHRhcmdldC9yaXNj
djogQWRkIFppbHNkIGFuZCBaY2xzZCBleHRlbnNpb24gc3VwcG9ydA0KPj4NCj4+ICB0YXJn
ZXQvcmlzY3YvY3B1LmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArDQo+PiAgdGFy
Z2V0L3Jpc2N2L2NwdV9jZmdfZmllbGRzLmguaW5jICAgICAgICAgfCAgIDIgKw0KPj4gIHRh
cmdldC9yaXNjdi9pbnNuMTYuZGVjb2RlICAgICAgICAgICAgICAgIHwgICA4ICsrDQo+PiAg
dGFyZ2V0L3Jpc2N2L2luc24zMi5kZWNvZGUgICAgICAgICAgICAgICAgfCAgMTIgKystDQo+
PiAgdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfemlsc2QuYy5pbmMgfCAxMTIgKysr
KysrKysrKysrKysrKysrKysrKw0KPj4gIHRhcmdldC9yaXNjdi90Y2cvdGNnLWNwdS5jICAg
ICAgICAgICAgICAgIHwgIDMyICsrKysrKysNCj4+ICB0YXJnZXQvcmlzY3YvdHJhbnNsYXRl
LmMgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+PiAgNyBmaWxlcyBjaGFuZ2VkLCAxNjkg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
dGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfemlsc2QuYy5pbmMNCj4+DQo+PiAtLQ0K
Pj4gMi40NS4z


