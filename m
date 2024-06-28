Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B94C30653
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 03:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN22X-0007mz-At; Thu, 27 Jun 2024 23:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sN22U-0007m3-SA
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 23:12:42 -0400
Received: from mx22.baidu.com ([220.181.50.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sN22S-0005yB-BB
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 23:12:42 -0400
To: Igor Mammedov <imammedo@redhat.com>, "Gao,Shiyuan" <gaoshiyuan@baidu.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>
Subject: Re: [v2 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Thread-Topic: [v2 1/1] hw/i386/acpi-build: add OSHP method support for SHPC
 driver load
Thread-Index: AQHayQfjqB1yzA8L7E6Vor5BZay2krHcflTx
Date: Fri, 28 Jun 2024 03:12:27 +0000
Message-ID: <b6ffe7071028472facd148623684d720@baidu.com>
References: <20240625035224.13019-1-gaoshiyuan@baidu.com>,
 <20240627154548.74a969c2@imammedo.users.ipa.redhat.com>,
 <6d033738d79d4b9a83fe216679f8e587@baidu.com>
In-Reply-To: <6d033738d79d4b9a83fe216679f8e587@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.200.78]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex08_2024-06-28 11:12:27:173
X-FEAS-Client-IP: 10.127.64.18
X-FE-Last-Public-Client-IP: 100.100.100.60
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=220.181.50.185; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PiA+ID4gdGhhdCBPUyBjYW5ub3QgZ2V0IGNvbnRyb2wgb2YgU0hQQyBob3RwbHVnIGFuZCBob3Rw
bHVnIGRldmljZSB0bw0KPiA+ID4gdGhlIFBDSSBicmlkZ2Ugd2lsbCBmYWlsIHdoZW4gd2UgdXNl
IFNIUEMgTmF0aXZlIHR5cGU6DQo+ID4gPg0KPiA+ID4gICBbMy4zMzYwNTldIHNocGNocCAwMDAw
OjAwOjAzLjA6IFJlcXVlc3RpbmcgY29udHJvbCBvZiBTSFBDIGhvdHBsdWcgdmlhIE9TSFAgKFxf
U0JfLlBDSTAuUzI4XykNCj4gPiA+ICAgWzMuMzM3NDA4XSBzaHBjaHAgMDAwMDowMDowMy4wOiBS
ZXF1ZXN0aW5nIGNvbnRyb2wgb2YgU0hQQyBob3RwbHVnIHZpYSBPU0hQIChcX1NCXy5QQ0kwKQ0K
PiA+ID4gICBbMy4zMzg3MTBdIHNocGNocCAwMDAwOjAwOjAzLjA6IENhbm5vdCBnZXQgY29udHJv
bCBvZiBTSFBDIGhvdHBsdWcNCj4gPiA+DQo+ID4gPiBBZGQgT1NIUCBtZXRob2Qgc3VwcG9ydCBm
b3IgdHJhbnNmZXIgY29udHJvbCB0byB0aGUgb3BlcmF0aW5nIHN5c3RlbSwNCj4gPiA+IGFmdGVy
IHRoaXMgU0hQQyBkcml2ZXIgd2lsbCBiZSBsb2FkZWQgc3VjY2VzcyBhbmQgdGhlIGhvdHBsdWcg
ZGV2aWNlIHRvDQo+ID4gPiB0aGUgUENJIGJyaWRnZSB3aWxsIHN1Y2Nlc3Mgd2hlbiB3ZSB1c2Ug
U0hQQyBOYXRpdmUgdHlwZS4NCj4gPiA+DQo+ID4gPiAgIFsxLjcwMzk3NV0gc2hwY2hwIDAwMDA6
MDA6MDMuMDogUmVxdWVzdGluZyBjb250cm9sIG9mIFNIUEMgaG90cGx1ZyB2aWEgT1NIUCAoXF9T
Ql8uUENJMC5TMThfKQ0KPiA+ID4gICBbMS43MDQ5MzRdIHNocGNocCAwMDAwOjAwOjAzLjA6IFJl
cXVlc3RpbmcgY29udHJvbCBvZiBTSFBDIGhvdHBsdWcgdmlhIE9TSFAgKFxfU0JfLlBDSTApDQo+
ID4gPiAgIFsxLjcwNTg1NV0gc2hwY2hwIDAwMDA6MDA6MDMuMDogR2FpbmVkIGNvbnRyb2wgb2Yg
U0hQQyBob3RwbHVnIChcX1NCXy5QQ0kwKQ0KPiA+ID4gICBbMS43MDcwNTRdIHNocGNocCAwMDAw
OjAwOjAzLjA6IEhQQyB2ZW5kb3JfaWQgMWIzNiBkZXZpY2VfaWQgMSBzc192aWQgMCBzc19kaWQg
MA0KPiA+DQo+ID4gcGxlYXNlIGRlc2NyaWJlIGluIGNvbW1pdCBtZXNzYWdlIHJlcHJvZHVjZXIN
Cj4gPiAoYWthIFFFTVUgQ0xJIGFuZCBndWVzdCBPUyBhbmQgaWYgbmVjZXNzYXJ5IG90aGVyIGRl
dGFpbHMpDQo+DQo+IHFlbXUtc3lzdGVtLXg4Nl82NCAtbWFjaGluZSBwYy1xMzUtOS4wDQoNCnNv
cnJ5LCBpdCBpcyAtbWFjaGluZSBwYy1pNDQwZngtOS4wDQoNCj4gICAgIC4uLg0KPiAgICAgLWds
b2JhbCBQSUlYNF9QTS5hY3BpLXBjaS1ob3RwbHVnLXdpdGgtYnJpZGdlLXN1cHBvcnQ9b2ZmDQo+

