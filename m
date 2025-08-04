Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC0EC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uizVl-0002SY-Pb; Mon, 04 Aug 2025 14:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1uixGZ-0004Jo-O8
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 11:38:26 -0400
Received: from mail-m15567.qiye.163.com ([101.71.155.67])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fanyihao@rt-thread.org>)
 id 1uixGV-0003tS-H6
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 11:38:23 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ABUAMgAwJaUxka3oiXNZdqqv.3.1754321460973.Hmail.fanyihao@rt-thread.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCB2MiAwLzNdIEFkZCBTVE0zMkY0IHN1cHBvcnQgYW5kIFVTQVJUIGRldmljZSBtb2RlbA==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com web
X-Originating-IP: 61.191.146.221
In-Reply-To: <CAFEAcA-dXnERwbgfMpXc40rDSqFJLN-iNWWH8ZXrv-Ap1M+2Eg@mail.gmail.com>
References: <20250721201134.13270-1-fanyihao@rt-thread.org>
 <AJgA9AAZJYcrbcAf1ETElKot.2.1754115134548.Hmail.fanyihao@rt-thread.org>
 <CAFEAcA-dXnERwbgfMpXc40rDSqFJLN-iNWWH8ZXrv-Ap1M+2Eg@mail.gmail.com>
MIME-Version: 1.0
Received: from fanyihao@rt-thread.org( [61.191.146.221] ) by ajax-webmail (
 [127.0.0.1] ) ; Mon, 4 Aug 2025 23:31:00 +0800 (GMT+08:00)
From: fanyihao@rt-thread.org
Date: Mon, 4 Aug 2025 23:31:00 +0800 (GMT+08:00)
X-HM-Tid: 0a9875b51eed02f2kunma04d7ac313c13
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQhpOVhgeQxgZHUMYQ0xDHVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlNSlVKQkpVSk9NVUlJSllXWRYaDxIVHRRZQVlPS0hVSktISkhNSlVKS0
 tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
 b=asSZs1uhCZUINf7QHYnH+evuljvwKD4oB/pff6543XkxHDw193jteR5muzOuWtKzu/hO3P5YaGahUekQCtktlYO9s9Zu3cbVCbsVw2vtlhzwCwfHKJk/TLYIVOvccmAmCD0J2dQDCwhuG62ClhqFMQBsnC+im7lXpZmPGqOEjKmeXJIuZZvb5sodRwCOS95ueWPLXfd7htJIHdrADOQIlfRwo0wknkHjvgVAMT2ScLkNpfHvcyXhUvfiUi58+dNMSBGNo/6vkvleldHvMI7vkvqDieeJhz+819FkUClrxCMBpZ6yExNEuXFlBlUlMnWER5M9uDQploURprOFRIs7Kg==;
 c=relaxed/relaxed; s=default; d=rt-thread.org; v=1; 
 bh=7nZxZvhBYWWuDmVySIILL+ZgQi318WBRNRLln/0jYZE=;
 h=date:mime-version:subject:message-id:from;
Received-SPF: pass client-ip=101.71.155.67;
 envelope-from=fanyihao@rt-thread.org; helo=mail-m15567.qiye.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGksJm5ic3A7ClRoYW5rcyZuYnNwO2ZvciZuYnNwO3RoZSZuYnNwO2luZm8uJm5ic3A7Tm8mbmJz
cDtwcm9ibGVtJm5ic3A7YXQmbmJzcDthbGwuJm5ic3A7SGFwcHkmbmJzcDt0byZuYnNwO3dhaXQu
Jm5ic3A7CkJlc3QmbmJzcDt3aXNoZXMsCuKAlCZuYnNwO0ZhbnlpaGFvCuWcqCAyMDI1LTA4LTAy
IDE5OjE3OjEx77yMUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPiDlhpnp
gZPvvJoKT24gU2F0LCAyIEF1ZyAyMDI1IGF0IDA3OjEyLCDojIPoibrosaogPGZhbnlpaGFvQHJ0
LXRocmVhZC5vcmc+IHdyb3RlOg0KPg0KPiBIaSwNCj4gSnVzdCBhIGdlbnRsZSBwaW5nIG9uIHRo
aXMgcGF0Y2ggc2VyaWVzOg0KPiAgIFtQQVRDSCB2MiAwLzNdIEFkZCBTVE0zMkY0IHN1cHBvcnQg
YW5kIFVTQVJUIGRldmljZSBtb2RlbA0KPiBodHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAyNTA3
MjEyMDExMzQuMTMyNzAtMS1mYW55aWhhb0BydC10aHJlYWQub3JnLw0KPg0KPiBUaGlzIHBhdGNo
IGFkZHMgc3VwcG9ydCBmb3IgdGhlIFNUTTMyRjQwNyBTb0MsIGEgbmV3IFNUTTMyRjRzcGFyayBi
b2FyZCwNCj4gYW5kIGEgVVNBUlQgZGV2aWNlIG1vZGVsLiBGZWVkYmFjayB3b3VsZCBiZSBncmVh
dGx5IGFwcHJlY2lhdGVkDQoNCkhpOyB0aGFua3MgZm9yIHRoZSBwaW5nLiBUaGlzIHNlcmllcyBp
cyBvbiBteSBsaXN0IHRvIHJldmlldywNCmJ1dCByaWdodCBub3cgd2UgYXJlIGluIHRoZSBmcmVl
emUgcGVyaW9kIGZvciB0aGUgMTAuMQ0KcmVsZWFzZSwgc28gSSd2ZSBiZWVuIGNvbmNlbnRyYXRp
bmcgb24gYnVnIGZpeCBwYXRjaGVzIHdoaWNoIGFyZQ0KZ29pbmcgaW50byB0aGUgcmVsZWFzZS4g
SXQgbWF5IGJlIGEgbGl0dGxlIHdoaWxlIGJlZm9yZSBJDQpjYW4gZ2V0IHRvIGl0LiAoT3RoZXIg
cGVvcGxlIGFyZSBvZiBjb3Vyc2Ugd2VsY29tZSB0byByZXZpZXcNCml0IGluc3RlYWQhKQ0KDQp0
aGFua3MNCi0tIFBNTQ0KDQoNCg0K

