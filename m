Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43658606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 20:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVEB3-0003wt-Jq; Sun, 22 Nov 2026 15:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1112433017@e.gzhu.edu.cn>)
 id 1xVBp6-00033Z-Kc; Sun, 22 Nov 2026 12:57:56 -0500
Received: from smtpbgau1.qq.com ([54.206.16.166])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1112433017@e.gzhu.edu.cn>)
 id 1xVBp3-0005d2-Nk; Sun, 22 Nov 2026 12:57:56 -0500
EX-QQ-RecipientCnt: 7
X-QQ-GoodBg: 2
X-QQ-SSF: 0040000000000040
X-QQ-FEAT: D4aqtcRDiqQmn+bQ1sq0MHNQoQe2rvdbouS691+rhTo=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: 4Saved4ZB/vmjHkfeWUcITHBnfbHu8z8mX3sTlE9p/c=
X-QQ-STYLE: 
X-QQ-mid: v3sz3b-12t1795370246ta2651796
From: "=?utf-8?B?6buE5Y2O5oiQ?=" <1112433017@e.gzhu.edu.cn>
To: "=?utf-8?B?cWVtdS1yaXNjdg==?=" <qemu-riscv@nongnu.org>
Cc: "=?utf-8?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>,
 "=?utf-8?B?cGFsbWVy?=" <palmer@dabbelt.com>,
 "=?utf-8?B?YWxpc3RhaXIuZnJhbmNpcw==?=" <alistair.francis@wdc.com>,
 "=?utf-8?B?emhpd2VpX2xpdQ==?=" <zhiwei_liu@linux.alibaba.com>,
 "=?utf-8?B?bGl3ZWkxNTE4?=" <liwei1518@gmail.com>,
 "=?utf-8?B?ZGFuaWVsLmJhcmJvemE=?=" <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH 2/2] target/riscv: reject shadow-stack accesses in Bare-mode
 translation
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Mon, 23 Nov 2026 01:57:26 +0800
X-Priority: 3
Message-ID: <tencent_5AA0FF1F62236004454D3317@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-BIZMAIL-ID: 8485356787373935717
X-Address-Ticket: version=; type=; ticket_id=; id_list=; display_name=;
 session_id=; 
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Mon, 23 Nov 2026 01:57:27 +0800 (CST)
Feedback-ID: v:e.gzhu.edu.cn:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NG7xP+P+sy64xPeC6rQ3d+fzn/aaKS001KiaVicjSzoXRWqGGmq10/Cq
 3XQrStiUDP8TNFYw36kgmOJo0v97fvKsydsRS56keZxFrDwOlurGK2/FSjsudY0Ou6Z7ZWf
 wZKmpI3jGN+CgyT4c7a3H93L9n/KkAvp92hVpzSKQqofFUTj2FFdP8iWBssZSpK5bd2brN5
 FfgEQJUZ1X/6PEZ3TIE1nJ7OdS6anmPAGkfB1IgVgsNx/v2BTB9DL3CKW7xsvoZo0Rcr68V
 7ir9wHEvX6KzbgLkIOCmPLbcXe5/Ba56RX+/VKQwAkQriXW00FLvKovqIRo7jyTRPWJ6XrP
 1dlaqMLTpv2SgcbAXOJiJ1UUoQ0swuF3oMQD9qyXVhXqz8bWqKTWIuidYAv2V4D6J4TUZc6
 ejXFwNvqkNLBqymQDy6OX6kwdetbb79n+RCjIrJu0dLFiO6Rb2dBYouOKqGCPdWtBbh3JDx
 JIykoto6wGY4yZPDehlvKzkzLW9E8QPx/Xig+4Pm1ffdyesoygtv/NXB22NYhhqYHY4CeDX
 3dgOB2Eqmsn7E7gKQ78eJeZey721ETPeUtn1WWTxSpOpD/ulrICPrR6ZwVsBTU8+OY6dpoE
 oF+mH0Tdo8E+wa169zAMNhF/5hvdIxaiMsXbItPgKuYXLSvNra8Ze39pc9McRqJ8BcbABgi
 LGyi/dXN/KxIDgYelTG0axUY0sg3KqIXA5V+2KQWuUCxpqbssLSgbgmlRFLaIcI8Qvc5RWj
 NlscVZzG4PzCBtaIjLTFf3ZnZjLX2K3P45JVH38irBf/DoB6ifpazQICKmPqI/T9vq5P4zQ
 9OAJ9h5HZIu2AmLtpE6ikRE6IJA5t4mcdr/9+bMpUQdWga01mcLHrbXi1lRwRbFlxzDIyfD
 Zzum0/nJI5mM56aRXXLVORYkS6THhhwgeZkENrUiptuyyEV0kci+dbOngTKblMbRvpKE4nw
 Kp/fR6iMqXmCJESHUD3Kb+4c0J4HtziDw1/1fjcNDvDyQJMseWxh2bmeCUXHdG+QuvifwBu
 s6DXiwXI1xkYSEiaM9
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
Received-SPF: pass client-ip=54.206.16.166;
 envelope-from=1112433017@e.gzhu.edu.cn; helo=smtpbgau1.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

SGVsbG8sDQpJbiBWTV8xXzEwX01CQVJFIHRoZSB0cmFuc2xhdGlvbiByZXR1cm5zIHBoeXNp
Y2FsID09IHZpcnR1YWwgd2l0aCBmdWxsIHBlcm1pc3Npb25zIGZvciBldmVyeSBhY2Nlc3Ms
IGluY2x1ZGluZyBzaGFkb3ctc3RhY2sgYWNjZXNzZXMgKGlzX3NzdGFja19pZHgpLiAgV2l0
aCBzYXRwIGRpc2FibGVkLCBzc3B1c2gvc3Nwb3BjaGsvc3NhbW9zd2FwIHRoZW4gb3BlcmF0
ZSBvbiBvcmRpbmFyeSBwaHlzaWNhbCBtZW1vcnksIHNvIHRoZSBzYW1lIFJPUCsxIHBpdm90
IGFzIHRoZSBwYWdlLXR5cGUgaXNzdWUgaXMgYXZhaWxhYmxlIHdpdGhvdXQgYW55IHBhZ2Ug
dGFibGVzIGF0IGFsbCAocHJvYmUgVDI3IGV4aXRzICJmdWxsIHBhc3MiIG9uIHVucGF0Y2hl
ZCBCYXJlKS4NCg0KVGhlIFppY2Zpc3Mgc3BlYyBwZXJtaXRzIHNoYWRvdy1zdGFjayBzdG9y
YWdlIG9ubHkgb24gc2hhZG93LXN0YWNrIHBhZ2VzOyBCYXJlIG1vZGUgaGFzIG5vIHBhZ2Ug
dHlwZXMsIHNvIGFsbCBTUyBhY2Nlc3NlcyBtdXN0IGZhdWx0Lg0KDQpGaXhlczogNjY5YjQ4
Njc0OTVjICgidGFyZ2V0L3Jpc2N2OiBtbXUgY2hhbmdlcyBmb3IgemljZmlzcyBzaGFkb3cg
c3RhY2sgcHJvdGVjdGlvbiIpDQpSZXBvcnRlZC1ieTogPFNFTkRFUj4NClNpZ25lZC1vZmYt
Ynk6IDxTRU5ERVI+DQoNCi0tLQ0KIHRhcmdldC9yaXNjdi90Y2cvY3B1X2hlbHBlci5jIHwg
MyArKysNCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQg
YS90YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxwZXIuYyBiL3RhcmdldC9yaXNjdi90Y2cvY3B1
X2hlbHBlci5jDQotLS0gYS90YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxwZXIuYw0KKysrIGIv
dGFyZ2V0L3Jpc2N2L3RjZy9jcHVfaGVscGVyLmMNCkBAIC0xMDg4LDYgKzEwODgsOSBAQCBz
dGF0aWMgaW50IGdldF9waHlzaWNhbF9hZGRyZXNzKENQVVJJU0NWU3RhdGUgKmVudiwgaHdh
ZGRyIGFkZHIsDQogICAgIGNhc2UgVk1fMV8xMF9TVjU3Og0KICAgICAgIGxldmVscyA9IDU7
IHB0aWR4Yml0cyA9IDk7IHB0ZXNpemUgPSA4OyBicmVhazsNCiAgICAgY2FzZSBWTV8xXzEw
X01CQVJFOg0KKyAgICAgICAgaWYgKGlzX3NzdGFja19pZHgpIHsNCisgICAgICAgICAgICBy
ZXR1cm4gVFJBTlNMQVRFX0ZBSUw7DQorICAgICAgICB9DQogICAgICAgICAqcGh5c2ljYWwg
PSBhZGRyOw0KICAgICAgICAgKnJldF9wcm90ID0gUEFHRV9SRUFEIHwgUEFHRV9XUklURSB8
IFBBR0VfRVhFQzsNCiAgICAgICAgIHJldHVybiBUUkFOU0xBVEVfU1VDQ0VTUzsNCi0tDQoy
LjQzLjANCg0KVGhhbmtzLA0KTG9va2luZyBmb3J3YXJkIHRvIHlvdXIgcmVwbHkh


