Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98923606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 20:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVEB7-0003xT-R5; Sun, 22 Nov 2026 15:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1112433017@e.gzhu.edu.cn>)
 id 1xVBWr-0007jB-Ne; Sun, 22 Nov 2026 12:39:07 -0500
Received: from smtpbgau2.qq.com ([54.206.34.216])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1112433017@e.gzhu.edu.cn>)
 id 1xVBWo-0004QG-R9; Sun, 22 Nov 2026 12:39:05 -0500
EX-QQ-RecipientCnt: 7
X-QQ-GoodBg: 2
X-QQ-SSF: 0040000000000030
X-QQ-FEAT: D4aqtcRDiqQ2hwknEHTU3mLwrm71ObIgm6i+WZlYK8w=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: VbBKvkypKsU93EpaEtmGrW/roinE5aGpkSG3ACw/fRg=
X-QQ-STYLE: 
X-QQ-mid: v3sz3b-12t1795369121t49247cc4
From: "=?utf-8?B?6buE5Y2O5oiQ?=" <1112433017@e.gzhu.edu.cn>
To: "=?utf-8?B?cWVtdS1yaXNjdg==?=" <qemu-riscv@nongnu.org>
Cc: "=?utf-8?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>,
 "=?utf-8?B?cGFsbWVy?=" <palmer@dabbelt.com>,
 "=?utf-8?B?YWxpc3RhaXIuZnJhbmNpcw==?=" <alistair.francis@wdc.com>,
 "=?utf-8?B?emhpd2VpX2xpdQ==?=" <zhiwei_liu@linux.alibaba.com>,
 "=?utf-8?B?bGl3ZWkxNTE4?=" <liwei1518@gmail.com>,
 "=?utf-8?B?ZGFuaWVsLmJhcmJvemE=?=" <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 1/2] target/riscv: fault shadow-stack accesses on
 non-shadow-stack data pages
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 23 Nov 2026 01:38:41 +0800
X-Priority: 3
Message-ID: <tencent_6A2419A93AE52BD1685CA916@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 2092384308925270356
X-Address-Ticket: version=; type=; ticket_id=; id_list=; display_name=;
 session_id=; 
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Mon, 23 Nov 2026 01:38:42 +0800 (CST)
Feedback-ID: v:e.gzhu.edu.cn:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NyuCELaSACDhYgOUPA5imuFJZiAyChP4fpr2ArZk9Dl7bMMhhxwM5SJO
 nopPEtwNkygFtkaG5aE4Blv23cRNnTyRMZcs0JS9lxyNq+0hxdvBFyRtJdkFGncHUCArh8P
 vB07v1aRO2VIHFNZHd9Pk+VV+k+uTxAlJGu6fMf7LSWa2Z9vIx45CjgAbCZVYgUKL6Hg4BA
 D+MgVBN/IaGI9S4zMDRXaie21nTZwN22FN6X8GtQg2rZPIw6d3SlvFk+hLr9MHJHOIRN2iE
 m4D6OkITM4VY39YJATI1YQ4bOHf/epff5NVk5sFXRSK0ZbHvDrWFLhZ7qbNFdJRqWwETfIH
 nErKA1R/e8ih9qDcccQabDkfGNTQisXHv3hPDzKp2XjyD5CKqTd63dhcJFWJjhVtTY7o0G6
 0+We/+9JFM/FH7oTL2diBeiRfLEhD9TAzvfGhtEkT+JmTh5nRZZ43bWYQ6+DFELIKLrasMu
 OrBReG35r5PUh39mhYNO8argbZKS9DFs8tMq7b8EbDhyrL+foOnPDAiVV7KqvYflzHUpvUy
 tpEsV5Go4ttKU4MZQw1+qt8Y1mWM60wm+T5vEq5/XLHM5eA42p8RopF0LTGIyyRLrP1fYMH
 ULOp0yn5gTsnBn85ClvLEb4L9nu75fapaJQFo+/LE4uSk7kWSkcP7mjRcgZSsLwHdpXBSbz
 EBSUOu6wwvsmDlBxaI2pa+flFLrhmO0rKg9GMsMgJ8UJowVFohojPHcP2Hwpz+6ZZdV7Xj0
 KDwnPnKs7tSOCdktd3Qe8fEhzz2TVgVt5zWyiAgA7EVh1fYziyRJIm24tCr8GYy+RRGAyhy
 1hQeOh2hubrDlTofqPiZHEBHZFr8JhHnvjd4/LSzwggWY1DR6ejPCeqNvxUc2ep/MMuxcyb
 DUypFyWALLVgFknKvsV1FH0frYo98Mm7pxpxhk3u9fdjNaltP76b/oybBBcsaP+oFbB2Tyw
 t0630upRTYkSUOMSieMWK1+Hf8fqq/F07ovx/8L+ByR5YNEDM7gAKt2xzpJyfqREzu58=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
Received-SPF: pass client-ip=54.206.34.216;
 envelope-from=1112433017@e.gzhu.edu.cn; helo=smtpbgau2.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 22 Nov 2026 15:28:41 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGVsbG8sDQpUaGUgbGVhZiByd3ggc3dpdGNoIGluIGdldF9waHlzaWNhbF9hZGRyZXNzKCkg
aGFuZGxlcyB0aGUgVy1vbmx5IChzaGFkb3ctc3RhY2spIGFuZCBSLW9ubHkgZW5jb2Rpbmdz
IGZvciBaaWNmaXNzIGJ1dCBoYXMgbm8gY2FzZXMgZm9yIFJXLCBSfFgsIFgtb25seSBvciBS
V1ggbGVhdmVzIHdoZW4gdGhlIGFjY2VzcyBpcyBhIHNoYWRvdy1zdGFjayBhY2Nlc3MgKGlz
X3NzdGFja19pZHgpLiAgVGhvc2UgZmFsbCB0aHJvdWdoIHRvIHRoZSBub3JtYWwgcGVybWlz
c2lvbiBwYXRoLCBzbyBzc3B1c2gvc3Nwb3BjaGsvc3NhbW9zd2FwIGZyZWVseSByZWFkIGFu
ZCB3cml0ZSBvcmRpbmFyeSBkYXRhIHBhZ2VzIG1hcHBlZCBWfFJ8VyAodXNlciBvciBzdXBl
cnZpc29yKSwgYW5kIHNzcG9wY2hrIGNvbXBhcmlzb25zIHN1Y2NlZWQgYWdhaW5zdCBhdHRh
Y2tlci1jaG9zZW4gUlcgb3IgUnxYIG1lbW9yeTogYSBST1ArMS1zdHlsZSBnYWRnZXQgdGhh
dCBwaXZvdHMgc3NwIHRvIGFueSBSVyBwYWdlIGNhbiBwdXNoIGZvcmdlZCBmcmFtZXMgYW5k
IGhhdmUgc3Nwb3BjaGsgdmFsaWRhdGUgdGhlbSAocHJvYmUgVDExIGV4aXRzIDB4NzUgImZ1
bGwgcGFzcyBvbiBSVyBwYWdlIiBvbiB1bnBhdGNoZWQgdjExLjEuMykuDQoNClBlciB0aGUg
WmljZmlzcyBzcGVjLCBzaGFkb3ctc3RhY2sgYWNjZXNzZXMgYXJlIG9ubHkgcGVybWl0dGVk
IG9uIHNoYWRvdy1zdGFjayBwYWdlcyAoYW5kLCBmb3IgdW53aW5kIHJlYWRzLCByZWFkLW9u
bHkgcGFnZXMgLSBhbHJlYWR5IGhhbmRsZWQgYnkgdGhlIFBURV9SIGNhc2UpLiAgUmVqZWN0
IHRoZSByZW1haW5pbmcgbm9uLVNTIGxlYWYgdHlwZXMgd2hlbiBpc19zc3RhY2tfaWR4LiAg
VGhpcyBhbHNvIGNsb3NlcyB0aGUgTVhSIHBhdGg6IGBpZiAobXhyKSBwcm90IHw9IFBBR0Vf
UkVBRGAgbXVzdCBub3QgZ3JhbnQgYSBzaGFkb3ctc3RhY2sgcmVhZCBvZiBhbiBleGVjdXRl
LW9ubHkgcGFnZSAocHJvYmUgVDMyOiB1bnBhdGNoZWQgZXhpdCAweDU5LCBwYXRjaGVkIGZh
dWx0cykuDQoNCkFsbCBwcm9iZXMgaW4gdGhlIFppY2Zpc3MgY29uZm9ybWFuY2UgYmF0dGVy
eSBiZWhhdmUgc3BlYy1jb25mb3JtYW50bHkgYWZ0ZXIgdGhpcyBjaGFuZ2UgKFNTLXBhZ2Ug
cHVzaC9wb3BjaGsgc2VtYW50aWNzIHVuY2hhbmdlZDogVDQvVDUvVDggcGFzczsgcGl2b3Rz
IGZhdWx0OiBUMTEvVDEzL1QzMS9UMzIgZmxpcCAxMTcvODkgLT4gMTUpLg0KDQpGaXhlczog
NjY5YjQ4Njc0OTVjICgidGFyZ2V0L3Jpc2N2OiBtbXUgY2hhbmdlcyBmb3IgemljZmlzcyBz
aGFkb3cgc3RhY2sgcHJvdGVjdGlvbiIpDQpSZXBvcnRlZC1ieTogPFNFTkRFUj4NClNpZ25l
ZC1vZmYtYnk6IDxTRU5ERVI+DQoNCi0tLQ0KIHRhcmdldC9yaXNjdi90Y2cvY3B1X2hlbHBl
ci5jIHwgOSArKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQoN
CmRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxwZXIuYyBiL3RhcmdldC9y
aXNjdi90Y2cvY3B1X2hlbHBlci5jDQotLS0gYS90YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxw
ZXIuYw0KKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9jcHVfaGVscGVyLmMNCkBAIC0xMzQ1LDYg
KzEzNDgsMTUgQEAgc3RhdGljIGludCBnZXRfcGh5c2ljYWxfYWRkcmVzcyhDUFVSSVNDVlN0
YXRlICplbnYsDQogICAgICAgICAgICAgcmV0dXJuIFRSQU5TTEFURV9GQUlMOw0KICAgICAg
ICAgfQ0KICAgICAgICAgYnJlYWs7DQorICAgIGNhc2UgUFRFX1IgfCBQVEVfVzoNCisgICAg
Y2FzZSBQVEVfUiB8IFBURV9YOg0KKyAgICBjYXNlIFBURV9YOg0KKyAgICBjYXNlIFBURV9S
IHwgUFRFX1cgfCBQVEVfWDoNCisgICAgICAgIC8qIFppY2Zpc3M6IFNTIGluc3RydWN0aW9u
cyBvbiBub24tU1Mgbm9uLVJPIHBhZ2VzIG11c3QgZmF1bHQgKi8NCisgICAgICAgIGlmIChp
c19zc3RhY2tfaWR4KSB7DQorICAgICAgICAgICAgcmV0dXJuIFRSQU5TTEFURV9GQUlMOw0K
KyAgICAgICAgfQ0KKyAgICAgICAgYnJlYWs7DQogICAgIH0NCg0KICAgICBpbnQgcHJvdCA9
IDA7DQotLQ0KMi40My4wDQoNClRoYW5rLA0KTG9va2luZyBmb3J3YXJkIHRvIHlvdXIgcmVw
bHkh


