Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEA4C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 12:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl6dk-0008O8-AU; Fri, 15 Mar 2024 08:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ff@shokubai.tech>) id 1rl5eE-0005TG-MR
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:22:52 -0400
Received: from 2.mo619.mail-out.ovh.net ([178.33.254.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ff@shokubai.tech>) id 1rl5e9-0000N0-VW
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 07:22:49 -0400
Received: from DAG2EX1.indiv5.local (unknown [10.111.182.163])
 by mo619.mail-out.ovh.net (Postfix) with ESMTPS id 4Tx20S6Txdz1B5q;
 Fri, 15 Mar 2024 11:22:32 +0000 (UTC)
Received: from DAG2EX1.indiv5.local (172.16.2.21) by DAG2EX1.indiv5.local
 (172.16.2.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.37; Fri, 15 Mar
 2024 12:22:31 +0100
Received: from DAG2EX1.indiv5.local ([fe80::8db3:f8fe:2645:753b]) by
 DAG2EX1.indiv5.local ([fe80::8db3:f8fe:2645:753b%6]) with mapi id
 15.01.2507.037; Fri, 15 Mar 2024 12:22:31 +0100
From: ff <ff@shokubai.tech>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Mark Burton
 <mburton@qti.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>, "Alistair
 Francis" <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 "Edgar E.Iglesias" <edgar.iglesias@gmail.com>, Stefano Stabellini
 <sstabellini@kernel.org>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Don Harbin <don.harbin@linaro.org>, "Alessandro Di
 Federico" <ale@rev.ng>, Anton Johansson <anjo@rev.ng>, Song Gao
 <gaosong@loongson.cn>, Michael Rolnik <mrolnik@gmail.com>, Brian Cain
 <bcain@quicinc.com>, Christoph Muellner <christoph.muellner@vrull.eu>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Max Filippov
 <jcmvbkbc@gmail.com>, Francisco Iglesias <francisco.iglesias@amd.com>
Subject: Re: Any interest in the QEMU community attending DVCon Europe October
 2024?
Thread-Topic: Any interest in the QEMU community attending DVCon Europe
 October 2024?
Thread-Index: AQHabxTmtvFdRAal3UOLjdxfiBNTJbE4t/o3
Date: Fri, 15 Mar 2024 11:22:31 +0000
Message-ID: <9FF2104A-DF54-4475-99CD-0BCAA444F1C7@shokubai.tech>
References: <8734t4wuco.fsf@draig.linaro.org>
In-Reply-To: <8734t4wuco.fsf@draig.linaro.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; d=shokubai.tech; s=ovhex1078890-selector1; 
 c=relaxed/relaxed; t=1710501752; h=from:to:subject:date;
 bh=WpbzGZ+BKEsbU7Kmi9sVPInkwue4zko+FQv46RMabzw=;
 b=ry6BtBreaMYSGDqcDN40udW/jPV9dInQtH0FvqKEVSD/2kUlfC5ry42ISow0v6YJxrGEwTvQBcKZEg+BebbsAHATNuEJqasTWEzF9GrxL09agMUldNCLwgPch3xA0TR8xu6hmHR/ozlZJr4V+ld4NN7L6EFf/qnBsF9LsQEz4ZbXJHyW/xVseY7mVNmR35klwA4X89E2+2JZbGAKSgoloWHfTes2651Oxfuij+9/XcDAKfQ8uzJ8r0PxyIxbJ8X6XKvGnhAtvHwCGLbuGXG8pJgxvcN32bRTrc9stb6LI1HziiRVefVAJsG4iNJfYPzgO+SPyrLMZyvGf8DlC4lRhQ==
X-Ovh-Tracer-Id: 3421046868173045490
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrjeelgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufhtfffkfhgjtgfgggesthgsmhdttddtjeenucfhrhhomhepfhhfuceofhhfsehshhhokhhusggrihdrthgvtghhqeenucggtffrrghtthgvrhhnpeeftdehteeifeefueeitdeijeeggefflefghffhtdfhhfelvdeghfeffeefvedvieenucffohhmrghinhepughvtghonhdqvghurhhophgvrdhorhhgnecukfhppeduvdejrddtrddtrddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehffhesshhhohhkuhgsrghirdhtvggthhdpnhgspghrtghpthhtohepudelpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehmsghurhhtohhnsehqthhirdhquhgrlhgtohhmmhdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrlhhishhtrghirhdrfhhrrghntghishesfigutgdrtghomhdprhgtphhtthhopegsihhnrdhmvghnghesfihinhgurhhivhgvrhdrtghomhdprhgtphhtthhopegvughgrghrrdhighhlvghsihgrshesghhmrghilhdrtghomhdprhgtphhtth
 hopehsshhtrggsvghllhhinhhisehkvghrnhgvlhdrohhrgh
Received-SPF: pass client-ip=178.33.254.187; envelope-from=ff@shokubai.tech;
 helo=2.mo619.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 15 Mar 2024 08:26:12 -0400
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

DQoNCj4gTGUgNSBtYXJzIDIwMjQgw6AgMTY6NTAsIEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVA
bGluYXJvLm9yZz4gYSDDqWNyaXQgOg0KPiANCj4g77u/DQo+IEhpLA0KPiANCj4gT3ZlciByZWNl
bnQgeWVhcnMgdGhlcmUgaGFzIGJlZW4gYSBwdXNoIHRvIG1ha2UgUUVNVSBtb3JlIGZsZXhpYmxl
IGZvcg0KPiBFREEgdHlwZSBhcHBsaWNhdGlvbnMuIEFzIGxvbmcgdGltZSBkZXZlbG9wZXJzIGtu
b3cgdGhlcmUgYXJlIGEgbnVtYmVyDQo+IG9mIGRvd25zdHJlYW0gZm9ya3Mgb2YgUUVNVSB3aGlj
aCBoYXZlIHRoZWlyIG93biBzb2x1dGlvbnMgZm9yIG1vZGVsbGluZw0KPiBoZXRlcm9nZW5lb3Vz
IHN5c3RlbXMgYW5kIGludGVncmF0aW5nIHdpdGggaGFyZHdhcmUgbW9kZWxzLiBUaGUgd29yayBi
eQ0KPiBQaGlsaXBwZSwgQW50b24gYW5kIG90aGVycyB0byBidWlsZCBhIHNpbmdsZSBiaW5hcnkg
d2l0aCBjb21wb3NhYmxlDQo+IGhhcmR3YXJlIGlzIGFpbWluZyBhdCBsZWFzdCB0byBzb2x2ZSB0
aGUgaGV0ZXJvZ2VuZW91cyBtb2RlbGxpbmcgcHJvYmxlbQ0KPiBpbiB0aGUgdXBzdHJlYW0gcHJv
amVjdC4NCj4gDQo+IFdoaWxlIHdlIGRvIGRpc2N1c3MgdGhlc2UgIlRDRyIgdG9waWNzIGR1cmlu
ZyBLVk0gRm9ydW0gdGhlIHByb2plY3QgbWF5DQo+IGJlbmVmaXQgZnJvbSBkb2luZyBzb21lIG91
dHJlYWNoIGF0IHNvbWUgY29uZmVyZW5jZXMgd2hlcmUgc2ltdWxhdGlvbg0KPiBhbmQgZW11bGF0
aW9uIGFyZSB0aGUgcHJpbWFyeSBmb2N1cy4NCj4gDQo+IFRoZSBEZXNpZ24gYW5kIFZlcmlmaWNh
dGlvbiBDb25mZXJlbmNlICYgRXhoaWJpdGlvbiBFdXJvcGUgKERWQ29uDQo+IEV1cm9wZSkgaXMg
dGhlIHByZW1pZXIgRXVyb3BlYW4gdGVjaG5pY2FsIGNvbmZlcmVuY2Ugb24gc3lzdGVtLA0KPiBz
b2Z0d2FyZSwgZGVzaWduLCB2ZXJpZmljYXRpb24sIHZhbGlkYXRpb24gYW5kIGludGVncmF0aW9u
LiBUaGlzIHllYXIgaXQNCj4gd2lsbCBiZSBvbiB0aGUgMTUtMTYgT2N0b2JlciAyMDI0IGluIE11
bmljaC4gU2VlOiBodHRwczovL2R2Y29uLWV1cm9wZS5vcmcvDQo+IA0KPiBUaGVyZSBoYXZlIGJl
ZW4gYSBudW1iZXIgb2YgcGFwZXJzIGFuZCB3b3Jrc2hvcHMgb24gUUVNVS9LVk0gdG9waWNzIG92
ZXINCj4gdGhlIHllYXJzLiBVbmZvcnR1bmF0ZWx5IHRoZSB3ZWJzaXRlIGRvZXNuJ3QgcHJvdmlk
ZSBzbGlkZXMgb3IgdmlkZW9zIG9mDQo+IHRoZSB0YWxrcyBidXQgdG9waWNzIGhhdmUgaW5jbHVk
ZWQgaG93IFFFTVUgY2FuIGJlIHVzZWQgYXMgYSBmYXN0DQo+IGluc3RydWN0aW9uIHNpbXVsYXRv
ciBhbG9uZ3NpZGUgdGhpbmdzIHN1Y2ggYXMgU3lzdGVtQyBtb2RlbHMgb3INCj4gdmlydHVhbGlz
YXRpb24gY2FuIGJlIGxldmVyYWdlZCB0byBhY2NlbGVyYXRlIGZ1bGwgc3lzdGVtIGVtdWxhdGlv
bi4NCj4gDQo+IFRoZSBtYWluIHRyYWNrcyBhcmUgZmFpcmx5IGFjYWRlbWljIHdoZXJlIGVuZ2lu
ZWVyaW5nIGFuZCByZXNlYXJjaA0KPiBwYXBlcnMgYXJlIHN1Ym1pdHRlZCBhbmQgaWYgYWNjZXB0
ZWQgY2FuIHRoZW4gYmUgcHJlc2VudGVkIGF0IHRoZQ0KPiBjb25mZXJlbmNlLiBUaGlzIGlzIHBy
b2JhYmx5IG92ZXIgdGhlIHRvcCBmb3IgUUVNVSByZWxhdGVkIHN0dWZmIGJ1dA0KPiB0aGVpciBp
cyBhIHR1dG9yaWFsIHRyYWNrIChkZWFkbGluZSBmb3IgQWJzdHJhY3RzIDFzdCBKdWx5KSB3aGlj
aCBjb3VsZA0KPiBiZSBhIGdvb2QgdGFyZ2V0IGZvciBhIGludHJvZHVjdGlvbiB0byB0aGUgZmVh
dHVyZXMgYW5kIGNhcGFiaWxpdGllcyBvZg0KPiB0aGUgUUVNVSB1cHN0cmVhbS4gSSBzdXNwZWN0
IHRoZXJlIHdvdWxkIGJlIGludGVyZXN0IGluIHRoZSB3aWRlcg0KPiBtb2RlbGxpbmcgY29tbXVu
aXR5IHRvIGZpbmQgb3V0IG1vcmUgYWJvdXQgaG93IHRvIHVzZSB0aGUgdXBzdHJlYW0NCj4gcHJv
amVjdCBkaXJlY3RseS4NCj4gDQo+IFRoZXJlIGlzIGEgY28tbG9jYXRlZCAiU3lzdGVtQyBFdm9s
dXRpb24gRGF5IiBvbiB0aGUgMTd0aCB3aGVyZSB0aGVyZQ0KPiBtaWdodCB3ZWxsIGJlIGEgc3Ry
b25nIG92ZXJsYXAgYmV0d2VlbiBTeXN0ZW1DIHVzZXJzIGFuZCBRRU1VLiBNYXJrDQo+IEJ1cnRv
biBpcyBpbnZvbHZlZCB3aXRoIHRoYXQgYW5kIGlzIGtlZW4gZm9yIHByb3Bvc2FscyB0YWxraW5n
IGFib3V0DQo+IGludGVncmF0aW5nIFN5c3RlbUMgbW9kZWxzIHdpdGggUUVNVS4gUGxlYXNlIHNl
bmQgYSBtZXNzYWdlIHRvDQo+IG1idXJ0b25AcXVpY2luYy5jb20gaWYgeW91J3JlIGludGVyZXN0
ZWQuDQo+IA0KPiBTbyBpcyBhbnlvbmUgaW50ZXJlc3RlZD8NCj4gDQo+IFNob3VsZCB3ZSBkbyBt
b3JlIHdpdGhpbiB0aGUgY29tbXVuaXR5IHRvIG5ldHdvcmsgYW5kIGRpc2N1c3Mgb3VyIHBsYW5z
DQo+IGZvciBRRU1VIGFzIGEgbW9kZWxsaW5nIHNvbHV0aW9uPw0KPiANCj4gQW55IG90aGVyIHRo
b3VnaHRzPw0KDQpJIHdvdWxkIGxvdmUgdG8gaGVhciBob3cgUWVtdSBjYW4gcGFydGljaXBhdGUg
aW50byBoZXRlcm9nZW5lb3VzIHNpbXVsYXRpb25zLg0KT25lIGNhc2UgaXMgd2hlcmUgbXVsdGlw
bGUgUWVtdSBpbnN0YW5jZXMgY29sbGFib3JhdGUgd2l0aCBsaW1pdGVkIGludGVyYWN0aW9ucywN
Ck9uZSBjYXNlIGlzIHdoZXJlIHRoZXJlIGlzIHdpdGggbWVtb3J5IGFsaWFzaW5nIChjb3J0ZXgg
TS9SIHNlZSBhIMKrIHdpbmRvdyDCuyBvZiB0aGUgbWFpbiBtZW1vcnkgd2l0aCBhIGRpZmZlcmVu
dCBhZGRyZXNzIGZvciB0aGUgc2FtZSBieXRlKSBiZXR3ZWVuIFFlbXUuDQpPbmUgY2FzZSBRZW11
IGlzIGludGVncmF0ZWQgd2l0aCAgb3RoZXIgc2ltdWxhdG9ycy4gQW4gaW50ZXJmYWNlIHRvIGhh
bmRsZSBhbGlhc2luZywgIE1NSU8sIFNNTVUsIEdJQyBhcmUgcmVxdWlyZWQgdG8gYWxsb3cgYWxs
IHBvc3NpYmxlIGNhc2VzIG9mIHdoaWNoIHNpbXVsYXRvciBlbXVsYXRlIHdoYXQuDQo+IA0KPiAt
LQ0KPiBBbGV4IEJlbm7DqWUNCj4gVmlydHVhbGlzYXRpb24gVGVjaCBMZWFkIEAgTGluYXJvDQo=

