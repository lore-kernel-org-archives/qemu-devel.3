Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96920E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 10:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM2e4-0005TN-5G; Fri, 13 Dec 2024 05:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=070864293=kenneth_jia@asus.com>)
 id 1tM2e1-0005Sn-7O; Fri, 13 Dec 2024 05:11:37 -0500
Received: from ms.asus.com ([103.10.4.142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=070864293=kenneth_jia@asus.com>)
 id 1tM2dy-0003e1-Kh; Fri, 13 Dec 2024 05:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=asus.com; i=@asus.com; q=dns/txt; s=asuscom;
 t=1734084694; x=1765620694;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bUc5hUoRy7tjpBsPVTjNCHU13wc9jzjxu6E5SxzrVOI=;
 b=OR2yjYqKFnKm013QLJaNLZnRrO63DY4brw/X+gEyNYwHmhWBH3kUj9ec
 9jSoaW5pmruL29jPesCdRWjfa9205kiVdpAy0g3R6NTWKoB/X6oQzJ647
 8lwL+a2tsZtlTg9m8cpc4TjYL4dFik+SfblowMyFmS13tOAbAKjiA9ZF6 4=;
IronPort-Data: A9a23:gdchC6xxYbShSwPSAvB6t+cfxyrEfRIJ4+MujC+fZmUNrF6WrkVTy
 zRNWTzQPKmLYWqmKdp/a97j8B8Av8SBz9VrTgBp+y00HyNBpPSeCIXCJC8cHQvLdZSbExgPA
 +byyDXkBJppJpMJjkr1WlTZhSAgk/vOHdIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/D3YzdJ5RYlagr41Ire8HuDjNyq0BsEs1o3Y+x8vVO2vxH527pEfcldh1OhKmVlNrbSq
 9TrldlVzUuAl/sZMe5Jp56gGqE8rh4+CiDV4pZec/DKbhGvPUXe2I5jXBYXQR8/ZzlkA7mdY
 TiC3HC9YV5BA0HCpAgSewADLhFsJqBGwa+dCle9tJej5VDka1K5lp2CDGluVWEZ0s9cKiRjx
 aVGbQ5VNVaKjOnwy7WhUu9hmoIqN9TwVG8dkig/l3eDXLB9HdaaGM0m5vcBtNs0rsNDG/DTe
 8ouaztmRB3bfgYJMVASYH47tL702CenKmcEwL6TjZo5xmKU/RZh7JqzYfDoJfy3R8VUuknN8
 woq+Ey8WHn2Lue3wj6K2nGlgeOJmjn0MKoLGbils/dwhXWVwWocDgBQUkG0ydGyjkGWQd9TK
 0UIvCEpqMAa7EyqStzxdxm5pneeuVgbQdU4O+8z7QCL/a7V5S6QHXAJQzJdZdcm8sQxQFQC3
 1mFhd72LTdovLCeTnSG6q2Jpi/0Mi8Qa2YfDQcLVgsM5fH5rY0zhw6JRdFmeIasg9joXD393
 T2OhC45gboVkIgMzarTwLzcq2vz/N6TH0huukOOBQpJ8z9EWWJsXKTwgXCz0BqKBNrxooWp1
 JTcp/Wj0Q==
IronPort-HdrOrdr: A9a23:pYU6fanoq64ICuvkpperFslB1yjpDfK73DAbv31ZSRFFG/Fwz/
 re+8jy1XfP5wr5K0tQ/+xoX5PwNE80lKQFk7X5Uo3SPzUO1FHEEGgm1/qH/9SCIVyLygc+79
 YDT0EWMrSZZjJHZITBkWyF+r0bruVvhZrJuQ6o9RZQpG9RB52IpD0JczpzWncGPDWuK6BJb6
 Z1vKd81kCdkVd7VLXHOpFEMtKz2OEi2v/dEGA771BM0nj8sdsbhYSKbySwz1MCVztUzfM4/X
 LYlhGR3NTTj9irjgLZ33Xeq4tbg8HgzNwrPr39tvQo
X-Talos-CUID: 9a23:INBc821ncqXZU7eOKUTDZ7xfA5sYQm/GwXfpMxWTJmRsE42/VH2I0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AJlpPlw/KKc3M1nRZHOS9kGWQf/dmxq7pOVodrbd?=
 =?us-ascii?q?Y6uO5agxNOTecqDviFw=3D=3D?=
Received: from unknown (HELO ACC-EX16-V03.acc.corpnet.asus) ([172.29.34.13])
 by ms.asus.com with ESMTP; 13 Dec 2024 18:11:26 +0800
Received: from ACC-EX16-V03.acc.corpnet.asus (172.29.34.13) by
 ACC-EX16-V03.acc.corpnet.asus (172.29.34.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.43; Fri, 13 Dec 2024 18:11:24 +0800
Received: from ACC-EX16-V03.acc.corpnet.asus ([fe80::3dae:532a:2ef6:9654]) by
 ACC-EX16-V03.acc.corpnet.asus ([fe80::3dae:532a:2ef6:9654%3]) with
 mapi id 15.01.2507.043; Fri, 13 Dec 2024 18:11:24 +0800
To: =?utf-8?B?J0PDqWRyaWMgTGUgR29hdGVyJw==?= <clg@kaod.org>,
 "'qemu-arm@nongnu.org'" <qemu-arm@nongnu.org>
CC: =?utf-8?B?J0PDqWRyaWMgTGUgR29hdGVyJw==?= <clg@redhat.com>,
 =?utf-8?B?J1BoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpJw==?= <philmd@linaro.org>, "'Jamin
 Lin'" <jamin_lin@aspeedtech.com>, 'Andrew Jeffery'
 <andrew@codeconstruct.com.au>, 'Gavin Shan' <gshan@redhat.com>, "'open
 list:All patches CC here'" <qemu-devel@nongnu.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0gaHcvYXJtL2FzcGVlZDogZml4IGNv?=
 =?utf-8?B?bm5lY3Rfc2VyaWFsX2hkc190b191YXJ0cw==?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGh3L2FybS9hc3BlZWQ6IGZpeCBjb25uZWN0X3Nl?=
 =?utf-8?B?cmlhbF9oZHNfdG9fdWFydHM=?=
Thread-Index: AQHbTS9dSL1vUYsQ8E2tdLoBmzCJz7Lj503A//+C4ACAAIj+kA==
Date: Fri, 13 Dec 2024 10:11:24 +0000
Message-ID: <44618918c6914e0fba8278799a9ecefc@asus.com>
References: <5f9b0c53f1644922ba85522046e92f4c@asus.com>
 <8af809d7-5fa2-471f-9fc9-eee482988894@kaod.org>
 <4c9f90399854448497317465c1e4cedc@asus.com>
 <c8d1bbed-907c-4590-befb-76d1da3052d4@kaod.org>
In-Reply-To: <c8d1bbed-907c-4590-befb-76d1da3052d4@kaod.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.68.200.222]
x-tm-as-product-ver: SMEX-14.0.0.3223-9.1.2019-28856.000
x-tm-as-result: No-10--17.318900-8.000000
x-tmase-matchedrid: qiJ73D9abaUfHU5fltg9RlY9XYa1m8xA1gfGMJv7tZKlddWrpn1WCNHk
 Kv/wPEiqwy4Dq7aKqvlgSiN/jyqWhajn9+B/16lAPmk8KY/lFC3towy3JnoUaASjtG4gy/zQXlY
 k1LO2pSPCR4j/jQndseIIoRYumX2/4winYAExk9DbtovkCBEknbsXVhBSg7Msl2KBmLXt0eqrl3
 h2e7KpHEQk60m8fcW+yrzRjZhtElOvngkjHjojpPe3el8uYlFT28gAxP/Ts6IH2l80MvY9heUo4
 N9PjSkTA/3R8k/14e0=
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--17.318900-8.000000
x-tmase-version: SMEX-14.0.0.3223-9.1.2019-28856.000
x-tm-snts-smtp: 53719522F27E15A48B76E96E8AE5E01BC7D093EED4D36741402F8AE47A523CB82000:9
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

PiBXaGljaCBRRU1VIG1hY2hpbmUgYXJlIHlvdSB1c2luZyA/DQogICBhc3QyNjAwLWV2Yg0KDQoN
ClRoYW5rcywNCg0KS2VubmV0aA0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6
IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+IA0K5Y+R6YCB5pe26Ze0OiAyMDI05bm0
MTLmnIgxM+aXpSAxNzo1Nw0K5pS25Lu25Lq6OiBLZW5uZXRoIEppYSjotL7nuqrkuJxf5Y2O56GV
5LiK5rW3KSA8a2VubmV0aF9qaWFAYXN1cy5jb20+OyAncWVtdS1hcm1Abm9uZ251Lm9yZycgPHFl
bXUtYXJtQG5vbmdudS5vcmc+DQrmioTpgIE6ICdDw6lkcmljIExlIEdvYXRlcicgPGNsZ0ByZWRo
YXQuY29tPjsgJ1BoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpJyA8cGhpbG1kQGxpbmFyby5vcmc+OyAn
SmFtaW4gTGluJyA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgJ0FuZHJldyBKZWZmZXJ5JyA8
YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgJ0dhdmluIFNoYW4nIDxnc2hhbkByZWRoYXQu
Y29tPjsgJ29wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlJyA8cWVtdS1kZXZlbEBub25nbnUu
b3JnPg0K5Li76aKYOiBSZTog562U5aSNOiBbUEFUQ0hdIGh3L2FybS9hc3BlZWQ6IGZpeCBjb25u
ZWN0X3NlcmlhbF9oZHNfdG9fdWFydHMNCg0KRXh0ZXJuYWwgZW1haWwgOiBFbnN1cmUgeW91ciBl
bWFpbCBpcyBzZWN1cmUgYmVmb3JlIG9wZW5pbmcgbGlua3MgYW5kIGF0dGFjaG1lbnRzLg0KDQpP
biAxMi8xMy8yNCAxMDo0OCwgS2VubmV0aCBKaWEo6LS+57qq5LicX+WNjuehleS4iua1tykgd3Jv
dGU6DQo+ICAgV2UgcGxhbnMgdG8gdXNlIGEgcmVsYXRpdmVseSBsYXJnZSBudW1iZXIgb2YgVUFS
VCBjb25uZWN0aW9ucywgYW5kIGN1cnJlbnRseSB0ZXN0IGFsbCBVQVJUcyB0aGF0IGNhbiBiZSB1
c2VkLg0KPiBXaGVuIHdlIHVzZSBxdW11IGZvciBzaW11bGF0aW9uLCB0aGUgcHJvYmxlbSB3YXMg
ZGlzY292ZXJlZC4NCg0KV2hpY2ggUUVNVSBtYWNoaW5lIGFyZSB5b3UgdXNpbmcgPw0KDQpUaGFu
a3MsDQoNCkMuDQoNCg0KPHA+PC9wPg0K

