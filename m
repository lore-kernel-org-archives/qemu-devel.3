Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17A4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 10:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1setxA-0004Uj-J3; Fri, 16 Aug 2024 06:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1setx7-0004TU-TF
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 06:13:01 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1setx4-0002HF-7N
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 06:13:01 -0400
To: "Michael S. Tsirkin" <mst@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Gao,Shiyuan"
 <gaoshiyuan@baidu.com>
Subject: Re: [PATCH 1/1] virtio-pci: return RAM device MR when set host
 notifier success
Thread-Topic: [PATCH 1/1] virtio-pci: return RAM device MR when set host
 notifier success
Thread-Index: AQHa7LI5llKSHEXN00eCXTiFzBl+lrIprzpd
Date: Fri, 16 Aug 2024 10:12:44 +0000
Message-ID: <a73618bee263452485e31c1261cf9a05@baidu.com>
References: <20240812122027.65600-1-gaoshiyuan@baidu.com>
In-Reply-To: <20240812122027.65600-1-gaoshiyuan@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.192.129]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 10.127.64.14
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=220.181.50.185; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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
Reply-to:  "Gao,Shiyuan" <gaoshiyuan@baidu.com>
From:  "Gao,Shiyuan" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

cGluZy4NCg0KV2hlbiBWSE9TVF9VU0VSX1BST1RPQ09MX0ZfSE9TVF9OT1RJRklFUiB0aGlzIGZl
YXR1cmUgbmVnb3RpYXRlZA0KYW5kIHZpcnRpb19xdWV1ZV9zZXRfaG9zdF9ub3RpZmllcl9tciBz
dWNjZXNzIG9uIHN5c3RlbSBibGsNCmRldmljZSdzIHF1ZXVlLCB0aGUgVk0gY2FuJ3QgbG9hZCBN
QlIgaWYgdGhlIG5vdGlmeSByZWdpb24ncyBhZGRyZXNzDQphYm92ZSA0R0IuDQpCZWNhdXNlIHRo
ZSB2cF9ub3RpZnkgaW4gc2VhYmlvcyBtYXliZSBjYW5uJ3Qgbm90aWZ5IHRoZSBoYXJkd2FyZQ0K
YWNjZWxlcmF0b3IgYnkga2lja2ZkIGZyb20gcWVtdSBub3RpZnlfb3BzLg0KDQpUaGFua3MuDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2FvIFNoaXl1YW4gPGdhb3No
aXl1YW5AYmFpZHUuY29tPg0KPiBEYXRlOiBNb24sIDEyIEF1ZyAyMDI0IDIwOjA5OjAxICswODAw
DQo+IFN1YmplY3Q6IFtQQVRDSCAxLzFdIHZpcnRpby1wY2k6IHJldHVybiBSQU0gZGV2aWNlIE1S
IHdoZW4gc2V0IGhvc3Qgbm90aWZpZXINCj4gIHN1Y2Nlc3MNCj4NCj4gV2hlbiB2aG9zdC11c2Vy
IGJhY2tlbmQgcmVnaXN0ZXIgbWVtb3J5IHJlZ2lvbiBiYXNlZCBob3N0IG5vdGlmaWVycywNCj4g
d2Ugc2hvdWxkIHJldHVybiBSQU0gZGV2aWNlIE1SIG9mIG5vdGlmeSByZWdpb24gTVIncyBzdWJy
ZWdpb24gaW4NCj4gdmlydGlvX2FkZHJlc3Nfc3BhY2VfbG9va3VwLg0KPg0KPiBJbiBzZWFiaW9z
LCBpdCB3aWxsIHVzZSB2aXJ0aW8gUENJIENvbmZpZ3JhdGlvbiBBY2Nlc3MgQ2FwYWJpbGl0eQ0K
PiBhY2Nlc3Mgbm90aWZ5IHJlZ2lvbiB3aGVuIGFzc2lnbiBub3RpZnkgcmVnaW9uIGFib3ZlIDRH
Qi4gVGhpcyB3aWxsDQo+IGV4aXQgdG8gUUVNVSBhbmQgaW52b2tlIHZpcnRpb19hZGRyZXNzX3Nw
YWNlX3dyaXRlLiBXaGVuIHZob3N0LXVzZXINCj4gYmFja2VuZCByZWdpc3RlciBtZW1vcnkgcmVn
aW9uIGJhc2VkIGhvc3Qgbm90aWZpZXJzLCByZXR1cm4gUkFNIGRldmljZQ0KPiBNUiBpbnN0ZWFk
IG9mIG5vdGlmeSByZWdpb24gTVIgaXMgc3VpdGFibGUuDQo+DQo+IENvLWRldmVsb3BlZC1ieTog
WnVvIEJvcXVuIDx6dW9ib3F1bkBiYWlkdS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEdhbyBTaGl5
dWFuIDxnYW9zaGl5dWFuQGJhaWR1LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWnVvIEJvcXVuIDx6
dW9ib3F1bkBiYWlkdS5jb20+

