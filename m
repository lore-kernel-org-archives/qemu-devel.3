Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C161FEFB48
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 12:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvwxa-0001zD-NZ; Fri, 27 Feb 2026 07:28:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvwxY-0001yY-PC; Fri, 27 Feb 2026 07:28:44 -0500
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvwxW-0006Jw-SH; Fri, 27 Feb 2026 07:28:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXtPca3kalHH3oNqpiCeLgQWaxOK7XNQOEwtGnz+uDSzErBMnQMOgGzxvvdq5A27QWZls4dRx7BNema2Ifa47kT4jnDLND2/lrjzxhC+tEEZ4au0j9DIm9LZEuIHNHU0EtviBsiR3hqK/uUqlSTqlpByMYDXrz4txFarenQEV4hZr23Kq1pzDHyBNrqv8yNUaki9xVF8S3jhUJUPkAo8B1CldLjWIIxxIdw/8L4/bNLLgezCLS7ThbRD6CBNhYYztQYN9bpGd+9QlKzyvIdk/8aI+D/7nlyg0DBEmWIiDzU4nvstjdKPzu4jtUarnttAKlL1rpDmWIpXf+MVV3KGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96CW2LsZX3nNx9RQo9d+82DyPmmbCeNaEnnsepK+9R4=;
 b=OBqQo6A5OB3aUXuhThz1CX4DXR39gK0kp2m+WTLp+SXDpjZ5Vo27Xu3vIGoQt97aJrWtbK4PbCLe3ckuY7PD/iVPbJ4Vp//gERvKg6gtPxg0e1m7VsOPHlQU0uhxvHU2geohtUW9vOpu0NwL4IihLKXNmKjFr2OIXlBItkkglybdZXyzhw3VNOkCAnO3V5JJcQxONOGDfSBWxwt7GX2qVs3LWzzzaYgMfXpIlZzlNx1e5WHpNHfGlq01NsXtE7Tu/vCBxWqjC/ypSRRSXqtXniKcuZ9L8lfSl5XPTY0RgKE0cFFR0Vy3z5pjODxwyGdYS0UWwtonJz4ELFkWrtu72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96CW2LsZX3nNx9RQo9d+82DyPmmbCeNaEnnsepK+9R4=;
 b=WenPG1S+6r+xud5QSzW2CdA0UacnY7NrXesUu4HekeUlKd3pXHswaUd6vCsLymk3T7PQXWeI8qYMONsdmHhIQr89XUvjymKjdAI5SFgAr4dX6tM08RMMD+JAFx87lmA9B4L+hyd8OIz3nmpYFPrMW9ritWExE8nwWORKLlvgk3sGFGYmsM36IluJEjMNQc2SUWcrwOQ8EV9gGA9Akri+WyVtxALy6XhZNWW7TWZ7U1S6t42MKo6o0uTUn2lgQzbjd7K72KaSymlOx2/SdnJwBdJkXXIbIrIESMfrwinFs25eSMDKem0E0oNEAgiI8hfq6WmOSK/hD+zkBZ+Ekk3nbA==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by GVXPR09MB7066.eurprd09.prod.outlook.com (2603:10a6:150:1b7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Fri, 27 Feb
 2026 12:28:32 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:28:32 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair23@gmail.com>,
 Conor Dooley <conor@kernel.org>
CC: Mohamed Mediouni <mohamed@unpredictable.fr>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>
Subject: Re: [PATCH v2 00/16] Add RISC-V big-endian target support
Thread-Topic: [PATCH v2 00/16] Add RISC-V big-endian target support
Thread-Index: AQHcpkBaA1l4l1CIU02NL47xpBxJMLWTSjoAgAJY6wCAAATbgIAAE2KAgACOxoCAADKBgA==
Date: Fri, 27 Feb 2026 12:28:32 +0000
Message-ID: <3b98f46c-4fe6-46a3-84c6-9448accf71c9@htecgroup.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <A02120BF-779D-4B2C-B29D-A9CB044EA895@unpredictable.fr>
 <CAKmqyKO6ioRt+h_tZrudbriv-QDVsOG1LNJ+GFQJ3ZO-fEhjiA@mail.gmail.com>
 <20260226-hangout-satin-fd7913f18f2b@spud>
 <CAKmqyKNST9ExmpcFE3iejmzZZRtMNSiVXkzfUK4GhhcketrCEw@mail.gmail.com>
 <35add848-6875-49c2-afd0-d5a1ccdbcd3f@redhat.com>
In-Reply-To: <35add848-6875-49c2-afd0-d5a1ccdbcd3f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|GVXPR09MB7066:EE_
x-ms-office365-filtering-correlation-id: 50440796-5b37-4dfe-767a-08de75fbb843
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: 48KUG8yoUGzpGqIuWcQs9xlL3xzrhGIcPuMjI279t2rAyq+cvPOSbp43LsXlj5RIqO55YZCKj45jF6cLQMnm82MG1fIJ2OoNiT+vgy3rdQ35wU7X12nZn1NjcEd2NHGq5vph4iAEMU4yIiwiAEI+ne+O5h23CYppJSTYT++ImJ/zGSz8qj64y6BIRNpdzyf3JwbpptV1ayrc+32TWDMtamEQleVUnUXrUXpAKxgInk87dL7tIanYFvTCr1c89+GfWQYFjH3i+5vidGHjRqeyMIZgK13/YSmWK247jbDUvAbU//edeJVHXuqjsWhOAHJksTL6Xferkxe+wFAXxu3JQmfFKsqfQ/ZlsgUjb/jrF2lh1JHwBOTtZZ5UyD3TFNJWi5sV+2jhhyBv9wkFHwSDDLjctMwm86to2Zw85wYayl3lHzI8ESoFkRkgySn+AmMizq3n6456idnc6PYHbFG5GVJ1UkSbRN9ZLn/2M/JkSVYhJIPqTSUNPxq/npCO7TdKk8s9+euxwhh1scDGcaT/4+uiPaW3f3LSSqpGPEVqvElpVHhwelNJbqztLQ9qWZ0e6P2jQJjFzN1YioSnxvjS+pWovNa7rLOPgKA2djhI4b0obTYjuXnq69MW0w4BXcwvm01UxGh9qehGcEl7JMk4VrR3nTpUs1IU5ebFz8yzdxdc8wGT6snaTZPF4/epI0aypWzWrtVnPytVN0GyJvBd0JZFSF71W4wLutAAx/gxUtBhB6xOQs8ql4WGsbxWxcfa
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blFkcFRXNnA1VEhHb0xRRnEwYUJxNUVKbklGcFBtUFBZbDQxeXRmbDA5RUM1?=
 =?utf-8?B?Z2E2R0E5NXZzM3Y3SVJqclRVdEx5MlRHTGE2RlFDRC9ZK2pJb2cyMERTTUZK?=
 =?utf-8?B?V1NxNVRPK1I2R0ZtbTlJRGtRQ2NLcmUxSmMwVGtPR2EwZVhnaEt5L2Nkckkz?=
 =?utf-8?B?N0RmL3VGQ2ZwSDJMeDQvTGtvR3BwUml1RTdKbmZhVXo2cE5rcWZ3VXFpbkZJ?=
 =?utf-8?B?dDgvY0gzOUpqMjhCNS9yMzV6QUppbndJdkJVYW9aeU9mbUtPZnlNNEs4TDlU?=
 =?utf-8?B?WFU1WmMxdDdvK01UcUxXaUlzeGxWWDFSWVVKemNETS80dzNXNUZieEdxc2tW?=
 =?utf-8?B?NFY2SFE3Zy9PNDRkbGF4V1hkYjBqaGlnOVcxbWNNRlRlQWhBcitVK2NUV21T?=
 =?utf-8?B?ZEhFSGVVZ21ndFc3R3djL2ExRVpwN3d6UE1iK2xidFhORjBVL0ZSNXJDOXhH?=
 =?utf-8?B?SkgxcmJJcTF1c3dNT0VFR3BJVk4wL1FXdHFWT2hTemMyTFh5NWJ2UjBWZytJ?=
 =?utf-8?B?bnhQZDdBUXZiMUFLSGZWQWlYWkppS1dLckxMOGNaMDVkKzlDb3p2ckdNMUUr?=
 =?utf-8?B?V3FwQTRNTnpyUEltN3J0QkMvRlhlY2crOUw4dVJWT1dRS3praThSbHJGUmNF?=
 =?utf-8?B?N1JPb2xSYzh4Rm9uK1dEV0tGV0dtRTkyY0QxVENLVDZFaVUrbTJ3K3drZnM1?=
 =?utf-8?B?WTBremtuTlNkalNQbDJwbUJvUDZpWjNZVE4wN1dCZ1BWY0tQMnFob1BmbWNt?=
 =?utf-8?B?QWlLSkg5MUdua2NpdUVrWDl0Slh2WG9IYk5XeCtweTI1MUpmdlkzL1V2c2NG?=
 =?utf-8?B?U0k3Sk9ETnJzYUVsK21HS21VRFdrSk01Ykx4L25FTzg1T3Robm9UZ2RQRzRE?=
 =?utf-8?B?N05JdHkxK2hpcXRZS3JkYWYwWWVSUjlzWm9YZ3RxYURxaVhYbFpoc1J1WUY0?=
 =?utf-8?B?Rm40S2gwcGw4Y05NbktGNkdXNHJoUlZYMmZSWFFlVmN1aTl0cGJIRkw5U1FU?=
 =?utf-8?B?L2tyL281cEdPdzNENFRxOEl0d0xsc3E3Wm9uUzJBSHBRVDhVWHdDK1FqTXNK?=
 =?utf-8?B?anozQ2R5WGpDd3c3V09IVGU5a20rZTQydjFROU1OL2hUS0VUcWQyOGZ6cFEx?=
 =?utf-8?B?SWxiaGRzbGorTDh3K1RIbUZ3MEcrV2NHb0p3Ky9kdGdFSHIrckM4Mk5FdERV?=
 =?utf-8?B?alJLWkJrdTJJK2MzT1I3QktMaWt6RUYrb3VuSlRBT3EyTzhLNTZlTWtBV3Uw?=
 =?utf-8?B?ZmdNUDZTYlNOMjFIUEF3a2I1amx3Q0s3YjNVY0xVZkZlUkNQRDVpOFRzZTVp?=
 =?utf-8?B?UmRKOVNTZml5T0VEeDVXQ3hIcUVTc0FsaFpZb2RGT0JBbS82MXN0ejliWGpD?=
 =?utf-8?B?UFk2dlJHblp5ZkpwNWtVdXNNQnpkSUY2MXdtQUZ3ZDh5bXRVd2lPUlZVdlRZ?=
 =?utf-8?B?dU9la3UvVVdRTUlXT1lyTnI0YjRUb1J4N1NadnZFNnBTamgwOHBVS2Z6OE8w?=
 =?utf-8?B?YUlxK0JBVE1JVHlrc3dEVkg2VWIrRU9OQVY5bVBGMVNyQmNPOGh5djZnSnQ4?=
 =?utf-8?B?ckp6WTBha05BdTIvZWtjU2ZGb1JDeWhmamQwR3J6c0R6TTBud2lrWFQxRXNQ?=
 =?utf-8?B?cVZSS2RieVNiUFFLd0ZyZ1Q0VVo2VUJwaEkvRXV6RDdWRlZ5VXk5TGkzeUVl?=
 =?utf-8?B?ZHNSZjZXY3NvRWQ3QjNIVWNpSTU1MlJjMXVTUE1adUh1T1RMNmFGTk9ZQXBU?=
 =?utf-8?B?ZkV1NUFzUjQzQTVRSkdCMGhHN1p5RUhQNlJFVDU4UFdmS0g2Y3pPbjFwWXFw?=
 =?utf-8?B?RW5mMlNLbGNzZW9OMTlmSnhWczVleTROMkYraDZoTDFkYW12OGxpOU1uZnMy?=
 =?utf-8?B?ZEFrV05udTRxSzNabUo4RzFQY29IQjUyWTN5MkxzYkFTY1NWNE5UTjlvbGow?=
 =?utf-8?B?cnJFaEdCT0QrWTUrWFBSWVk5OWNydEsvN2UvTjNlOWl1UW9xcmRCNzVqODdW?=
 =?utf-8?B?Wk0wWE1yZ2Fvd2kzbTRHNC9RNFliWjdGL2hwMHFCemNnaVZUcmR3SXNqWHRQ?=
 =?utf-8?B?SE9ndzhiYnVHSDYvblVSUXZnajdtcm1Xd0JTU2tKaE9tK3MvM1AzMXc2Wllz?=
 =?utf-8?B?cllIUldGdUlUQzY1ckQvSnNrdkZlNytoOXY4aGJ1YVdEN0RYR3ZMbkZEc0lh?=
 =?utf-8?B?cWE3cW9tRE5zcXFPVFQ5Y3hXWHAyNm1JSncxd09EZG5vRkVLL3JkNis3bkZS?=
 =?utf-8?B?R0dnY1hBSm1GbHA2UHI3MTVPeld0dEZzckZDRG9IZHF6LzhVdVNjemMzbTFh?=
 =?utf-8?B?Ynlpc3ZYTTRhQXpTM0drMEsyUkdaQXN4bXFsamlwcnY0TitDaC94SGhhWGFP?=
 =?utf-8?Q?rOxSvwmVGn45xdZ93ix1p+F/BbkQrQWkUQbr4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9FEAB0B3F90BB4191BEBB1B2123D16B@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50440796-5b37-4dfe-767a-08de75fbb843
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:28:32.1263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6f5l4wsmiwZmyzMYm3+bF5xtxL9ua6qLzdjykCO4+/wGD5JqcbVAOwLYvuBRsyTS6UIksDfkyT7dX0zCXaiRzd4ijO4B1b3LKl/6RWHFKQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB7066
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQpPbiAyLzI3LzI2IDEwOjI3LCBUaG9tYXMgSHV0aCB3cm90ZToNCj4gQ0FVVElPTjogVGhpcyBl
bWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyANCj4g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUg
dGhlIHNlbmRlciANCj4gYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gT24g
MjcvMDIvMjAyNiAwMS41NiwgQWxpc3RhaXIgRnJhbmNpcyB3cm90ZToNCj4+IE9uIEZyaSwgRmVi
IDI3LCAyMDI2IGF0IDk6NDfigK9BTSBDb25vciBEb29sZXkgPGNvbm9yQGtlcm5lbC5vcmc+IHdy
b3RlOg0KPj4+DQo+Pj4gT24gRnJpLCBGZWIgMjcsIDIwMjYgYXQgMDk6MzA6MDBBTSArMTAwMCwg
QWxpc3RhaXIgRnJhbmNpcyB3cm90ZToNCj4+Pj4gT24gV2VkLCBGZWIgMjUsIDIwMjYgYXQgOToz
OeKAr1BNIE1vaGFtZWQgTWVkaW91bmkNCj4+Pj4gPG1vaGFtZWRAdW5wcmVkaWN0YWJsZS5mcj4g
d3JvdGU6DQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+DQo+Pj4+Pj4gT24gMjUuIEZlYiAyMDI2LCBhdCAx
MToyMCwgRGpvcmRqZSBUb2Rvcm92aWMgDQo+Pj4+Pj4gPERqb3JkamUuVG9kb3JvdmljQGh0ZWNn
cm91cC5jb20+IHdyb3RlOg0KPj4+Pj4+DQo+Pj4+Pj4gVGhpcyBzZXJpZXMgYWRkcyBiaWctZW5k
aWFuIChCRSkgUklTQy1WIHRhcmdldCBzdXBwb3J0IHRvIFFFTVUsDQo+Pj4+Pj4gY292ZXJpbmcg
Ym90aCBzb2Z0bW11IGFuZCBsaW51eC11c2VyIGVtdWxhdGlvbiBmb3IgcmlzY3YzMmJlIGFuZA0K
Pj4+Pj4+IHJpc2N2NjRiZS4NCj4+Pj4+IEhlbGxvLA0KPj4+Pj4NCj4+Pj4+IFRoZXJl4oCZcyBu
byBMaW51eCBSSVNDLVYgYmlnIGVuZGlhbi4gTWF5YmUgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvIGlz
IA0KPj4+Pj4gdG8gbm90DQo+Pj4+PiBzdXBwb3J0IGl0IHVubGVzcyB3ZeKAmXJlIHN1cmUgdGhh
dCBpdCBjYW4gZ2V0IHRvIExpbnV4IHVwc3RyZWFtIA0KPj4+Pj4gKGZvciB0aGUgbGludXgtdXNl
ciBtb2RlKT8NCj4+Pj4NCj4+Pj4gQWdyZWVkLiBXZSByZWFsbHkgbmVlZCB1cHN0cmVhbSBMaW51
eCBzdXBwb3J0IGJlZm9yZSB1c2VyIG1vZGUNCj4+Pg0KPj4+IE9uIHRoYXQgZnJvbnQsIEJlbiBw
b3N0ZWQgcGF0Y2hlcyBmb3IgaXQgYW5kIExpbnVzIHdhcyByZWFsbHkgcmVhbGx5IA0KPj4+IG5v
dA0KPj4+IGVudGh1c2VkIHdoZW4gaGUgYmVjYW1lIGF3YXJlIG9mIGl0Og0KPj4+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LXJpc2N2LzA2NmQ3MGM3LWIwYTctNDVlNS05MzM3LTE3OTAx
YmM5NTY2NEBjb2RldGhpbmsuY28udWsgDQo+Pj4NCj4+PiBFdmVuIHdpdGhvdXQgTGludXMnIHRh
a2UsIEkgZmVlbCBsaWtlIHRoZXJlJ3MgYWJzb2x1dGVseSBubyBjaGFuY2Ugb2YNCj4+PiB1cHN0
cmVhbSBzdXBwb3J0IHdpdGhvdXQgbWVhbmluZ2Z1bCBzaGlwcGluZyBoYXJkd2FyZSB0aGF0IHJl
cXVpcmVzDQo+Pj4gYmlnIGVuZGlhbiBzdXBwb3J0LCBiZWNhdXNlIGJhc2ljYWxseSBldmVyeW9u
ZSBlbHNlIHdhcyBhbHNvIG9wcG9zZWQgdG8NCj4+PiBhZGRpbmcgaXQuLi4NCj4+DQo+PiBZZWFo
Li4uIEkgc2F3IHRoYXQuDQo+Pg0KPj4gQSBmZXcgdGhvdWdodHMsIGp1c3QgYmVjYXVzZSBMaW51
cyBkb2Vzbid0IGxpa2UgaXQgZG9lc24ndCBtZWFuIFFFTVUNCj4+IGNhbid0IHN1cHBvcnQgaXQu
IEJ1dCBJIGFtIGhlc2l0YW50IHRvIHN1cHBvcnQgQkUgY29uc2lkZXJpbmcgdGhlIGxhY2sNCj4+
IG9mIGVjb3N5c3RlbSBzdXBwb3J0IGV2ZXJ5d2hlcmUgZWxzZS4NCj4+DQo+PiBUaGVyZSBhcmUg
YSBidW5jaCBvZiBjaGFuZ2VzIGluIHRoaXMgc2VyaWVzIHRoYXQgY291bGQgZWFzaWx5IGdvIGlu
dG8NCj4+IFFFTVUuIFRoZXkgYXJlbid0IGludHJ1c2l2ZSBhbmQganVzdCBpbnZvbHZlIGNoYW5n
aW5nIG9yIHVzaW5nIGhlbHBlcg0KPj4gZnVuY3Rpb25zIHRvIGhhbmRsZSBlbmRpYW5uZXNzLiBJ
IHRoaW5rIHRob3NlIGNvdWxkIGJlIHNwbGl0IG91dCBhbmQNCj4+IGdvIHVwc3RyZWFtLCByZWR1
Y2luZyB0aGUgc2l6ZSBvZiB0aGlzIHNlcmllcyBhbmQgcmVkdWNpbmcgdGhlDQo+PiBtYWludGVu
YW5jZSBidXJkZW4gb2Ygb3V0IG9mIHRyZWUgcGF0Y2hlcy4NCj4+DQo+PiBUaGUgY29yZSBCRSBz
dXBwb3J0IGlzIGEgZGlmZmVyZW50IHByb2JsZW0uIEJ1dCBpZiBzb2Z0bW11IHdvcmtzIGluDQo+
PiB0aGUgZXhpc3RpbmcgYmluYXJpZXMgdGhlbiBtYXliZSBpdCdzIHdvcnRoIGFjY2VwdGluZy4N
Cj4NCj4gRldJVywgaGF2ZSBhIGxvb2sgYXQgdGhlIGNoYW5nZXMgdGhhdCBQaGlsaXBwZSBkaWQg
aW4gDQo+IHRhcmdldC9taWNyb2JsYXplLyBpbg0KPiB0aGUgcGFzdCB0d28geWVhcnMsIGhlIG1l
cmdlZCB0aGUgYm90aCBlbmRpYW5uZXNzIGZsYXZvdXJzIHRoZXJlIHNvIGl0IA0KPiBjYW4NCj4g
bm93IGJlIGhhbmRsZWQgaW4gb25lIGJpbmFyeSEgSWYgeW91IGRvIHNvbWV0aGluZyBzaW1pbGFy
IHdpdGggcmlzY3YsIGl0DQo+IGhvcGVmdWxseSBzaG91bGQgbm90IGJlIHRvbyBpbnRydXNpdmUu
DQo+DQo+IMKgVGhvbWFzDQo+DQpIaSBUaG9tYXMsDQoNClllcywgc3VyZSwgdGhhbmtzIGZvciB0
aGUgYWR2aWNlLCBJIHdpbGwgdHJ5IHRvIGZvbGxvdyB0aGF0IHBhcnQgZm9yIA0KcmlzY3YgYXMg
d2VsbCENCg0KVGhhbmtzIGEgbG90IQ0KRGpvcmRqZQ0K

