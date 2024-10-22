Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF39ED1714E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 01:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t33rC-0002Yx-Dv; Mon, 21 Oct 2024 21:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t33r3-0002Tu-OL; Mon, 21 Oct 2024 21:38:37 -0400
Received: from mail-sg2apc01on2071d.outbound.protection.outlook.com
 ([2a01:111:f403:200f::71d]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t33r1-0006TN-A1; Mon, 21 Oct 2024 21:38:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxz3OGi0U7HqNE/5/RZ4yFxW8NZbIwHjAt6YsRMA+PpCnjnt2bm/WFh+VSpwxPZDkffqeJwtMy9vz1gZXMZLqAEcUqgQgtU7WgnckcJ5dXbJj3eVdsl3PL/ebGonqWjN5J/1tXMNQxMGBWCA+qCB/kxBwVz5yzblHOc+MrhcTDdO/1IJ+iXJgt9vEzkpGSipQvKeWPvlZl0kH0sQVjQo6sbwGyzFhxv+3Je7RDWlRqW6Md8F+hQ+ALlRADw5xPugeVJ/j1gqhrHU0YkMKGRlaHe4dtTKUV7OwhiPC0Wu9Z+R9NzsTz2LxQ+xgoIs4phiDFo+Ja3EnTs4AYgVEBR8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPo8Vp3alrAWR2+nSusQDia6AzCGVh5scwVgyfRcFTg=;
 b=eu4UFoP/qkRL4v/VTnM0eRwsOn7DbH405THy6NSrk0vRBnhnq8BE93PH7w1n6JKTPKThcJomwLQfFY3NUP42OfEQoDoEQWk5BZ7kcC6mM2XjbzKCTXHFJvOYTTX1Q7x32L7+i/gSQ951X1KFkPlaHDfYcF6OcTdrO8LhI6pnvrD9pGFxcJ0yUZbQ39zJrRb+NGyTwu6mNDnAvn0NGpmWyEbdXtVOrgV8YV48mIdAzst8JxN2gsVi/XI8leeszWrgmQQMiGHPXkifvUytiory9lYo/aLegwiGdIIw61MQvjcAQUtajrKboGJLnHbJxdNazXJpiFTZqQr+nLdbXBSNHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPo8Vp3alrAWR2+nSusQDia6AzCGVh5scwVgyfRcFTg=;
 b=QSVqf7L5n+3cx5I/EGnLdIl9Ha2RKKn9f3SYRT5Ly3UOJIODYuswTF6onyVB6UdFnln+JiL9Ep/Q0utzA/U7UX46FgeKwOSZzU9Jg0Sm26Rzg8JnpCDdjx0mxRERsQGTatJAeyRS/noEdZMOtjVaVPdncPBtRrsrca6ZP/PoAg7i8MDHVotWshZSF0VoCrXS9UzJpJVcmar4vVuvwqyQnQDl1Y7dA4w6kYoN7p9dZckNLLPE3NhN8U7c3TaYxwCU7EHBLbXMr5SBuQKt7OXlMN22FzKDoj34k/a0lrKPXXzx81GMk7+Hzl8DSb+2eCQ33ERWfu/7DguDK1BxNw66OA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB6144.apcprd06.prod.outlook.com (2603:1096:400:341::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.15; Tue, 22 Oct 2024 01:38:21 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8093.013; Tue, 22 Oct 2024
 01:38:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 09/16] test/qtest/aspeed_smc-test: Introduce a
 new TestData to test different BMC SOCs
Thread-Topic: [SPAM] [PATCH v1 09/16] test/qtest/aspeed_smc-test: Introduce a
 new TestData to test different BMC SOCs
Thread-Index: AQHbIR77M19IsWTFnEycJAdnkZIi9LKRIyEAgADblCA=
Date: Tue, 22 Oct 2024 01:38:20 +0000
Message-ID: <SI2PR06MB50418E6553BC95BDCC71E4CAFC4C2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241018053112.1886173-1-jamin_lin@aspeedtech.com>
 <20241018053112.1886173-10-jamin_lin@aspeedtech.com>
 <c395abee-68ca-4030-953f-476b364df62f@kaod.org>
In-Reply-To: <c395abee-68ca-4030-953f-476b364df62f@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB6144:EE_
x-ms-office365-filtering-correlation-id: 28231dc1-1773-460e-e0f1-08dcf23a35a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700018|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?S1BLdFVrREFEZno1VXI1SHdvRmhuUGdLVndNUytMVmp2WTBLckN4cGxKYUVP?=
 =?utf-8?B?amNGZU5XQnh2dHFSTy8zZlc2eVgzYzlrQ0pLaU0xQy9mT1h2NkpCM0F5QjY4?=
 =?utf-8?B?WjJCd1Z1V0k4NzZqRlFqb2NrMnhPTW91UUw2SjFGL1JKMTI4MmVNU0oxeTZy?=
 =?utf-8?B?NFJ3b3lwWGxwUE5iMHEweHc0ZG9DZWJ2dm1mVmM4bE5xdEhPK1RsUEF3cW1Q?=
 =?utf-8?B?RzMrOVJ3Skw4NU9sbjFVc0UwZTRMKzUvTDEwVkhKVktTRzJMNzJZUE1TMXJo?=
 =?utf-8?B?UVpwR1J2Z2pRaTlzWXphQzAyb0N2ejZxSmVaTWZla0Mxak1WbXV1TTVSKzZV?=
 =?utf-8?B?YUFmeGowQXBNRERmcHhNK1VNTlR5WENNdW1lQ0RoYWtwbmdwVHlLNHdQc0dm?=
 =?utf-8?B?aDNOTWNFUGFWdk9MNXJkdUFQcGtseVFERzRVa2M0UGRpdDRCYjRuOVFSMzZF?=
 =?utf-8?B?b21LUGlqOFZIRUVlTFhhYTBzdWtLQUs5bFJYaTdnQWRwRm5hTU5TWDBIc2pP?=
 =?utf-8?B?REVvaEVsdjMzbUltVDRlQmtlUWtYdStnZHBOcU15UWx5MjRQc0k1RENWamlE?=
 =?utf-8?B?TDBINS93ZWpJWHNSZ0gyVkx1Qjd5MGhpd1RjYU9tYkJKeDh6NEtxMTkwRGYw?=
 =?utf-8?B?MDRsMnRYS2VpcEcxbWNwMWprZmoyeFBPTVBTQ3hIMmtlTUNXMFZIdkFYdFlZ?=
 =?utf-8?B?RjN2SXFwRWxKT0dxcG5uenNJWUhWQVIrQjRGZGhyOExYZW54V3BGNmttWERj?=
 =?utf-8?B?MWgwbWhTcVVMdkJzWldtWkhaMlozY1kwczlDek9nVGozeVRjN0N0c0s3QXZi?=
 =?utf-8?B?SEw0czQyRFBWMVdFZjhkSUg0cHlTVjFIcHNLRmtGU2Z4VStHTm1yR0w1MmpV?=
 =?utf-8?B?MUFPOEdHYmIxT0c2Y0FzckkrY1NicE9RUzBkQ0lscDlmRVRtb1JSQzJvYkVs?=
 =?utf-8?B?aSsxeFlJYmFVbFlEbWMrS0RsTFN5ZjBhTXFOZGphZE1JeGRUWUtkMlQ5ZUNF?=
 =?utf-8?B?ajh0dGhSVGdrbU1pb2d5MG9Da1hiR1FjcGZ5QmNpeWdqNEY1ODB4WFpLOERR?=
 =?utf-8?B?WDBjS1FOSG1tWTN5TGJueElUSHdhaG45VXhLTlAwLzVlZHlGQmtGdVZrMlpz?=
 =?utf-8?B?dC9TNm9qOFYxWm5ZTS9laENHU2NsWVpXVG5DZ0k4MTFNRU9ac2ludkNTM29R?=
 =?utf-8?B?bFhYQzFKd2RZcmQyS0VCci85RnI5RWpwSzRkWlB0c2NIN1g2WC9QZm40MEUx?=
 =?utf-8?B?Ny9uYnlwUmdrWnY0SVpiazBqNEdqWFVxY1M0WGJ4K0NtcWkwc0hmc0tkSGhl?=
 =?utf-8?B?K1JKS0RqRjRKVWZmYmNDRWFpQmtISFFjOGZFRklNS282d05FSlVrTUliemNk?=
 =?utf-8?B?NDhuemg3OWF1YmM1SkRHMkVvSGt4ODE5Y1Y5dE80dm40ZkpVN3M1Vi9OWlRv?=
 =?utf-8?B?aHFuUWhIbCttNjdvVXBuay85OEgvb05MRGxLRjR5TUtmaG5kbXdJWDBiQjJ4?=
 =?utf-8?B?ZHpQdVoyU3F0MFB1dEhNV0RzSGVFV0Q4TlBseXNqekU1czVYS1RHMjZUK0dQ?=
 =?utf-8?B?TXA0MzRlRFJUbmdXNUpqVTFjZHFGd1VuOHR6NUQxc0t4OXNoTHlEQmpoaUpk?=
 =?utf-8?B?SEhMaVluQmNzMzZsQW5ibkVFTk1uS3MxTFhrSGpyRURvdWZvNEFSN05Mbjdu?=
 =?utf-8?B?UGxOZ25zcUp3a3RiN2NIdmlaVTVTNXRFa00xZDFIa1ROeXptQ0dESTJmK3N3?=
 =?utf-8?B?MUdIa3FHdVlvNWdTQVMzZHlnbkNMOWN0UE00b245YVR1VEt0aXRUdnRvZWwy?=
 =?utf-8?B?Wk9ZekplTHZCN08rbnh1K2Q4dUdNV3I5U2tWVlpmSjU0TkEzdjUzbHBMS1dx?=
 =?utf-8?B?dGsxUVNxS1lPKzFDRzk3bE9lSEc1MDZGbVBLZjUyUXNBYXFKZmFSWTY4SFY2?=
 =?utf-8?Q?3vW/QQB2lsE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700018)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXp4djJwaStnSVVscDRKSUdQZmJXTElaSnRQOUNKdi9kSStSZ0FTRkljMTBJ?=
 =?utf-8?B?WDEzQ2FhbEdkbXRnWGVxd2MzTi9OUmtPZ2R5clgxcHdUbktrZFZyMzEwWkp6?=
 =?utf-8?B?YXNIM0tVRTdlcjVRLzN0OFIyZVZWN3VCSm9INEQ4S09tNGEyTDJTeDVPcmo2?=
 =?utf-8?B?VHFBUExrNnFjWVpKRDQ0Vit0aURzTkpPRStSUXF0dThhNENCdk5rbEs2bGhw?=
 =?utf-8?B?d2JaaFlqWFNoOWt3eGhUQTFqMi9Fc0ZHbjZaV3Byd2NseE5uR1B4WlFFMGMw?=
 =?utf-8?B?WTJXRFQxcUZwY0ViNTk0NkQ4TExBenlGcnpINlZ2OVJGWGEyeG1zOXFSVTdM?=
 =?utf-8?B?YTBzRnVHNlk5SXlSanZKd3lzeDF1MXUyOWszYnBqUHdXd0FLZWtvdGFlc0Mx?=
 =?utf-8?B?VS9TVTArZ0FjY1l5SEpUL20xeTBKbW5ianB2c0FvRTh2VHJQb3NlWTRxcUNk?=
 =?utf-8?B?UjdyUFQzYXFXOEZDeE1YS0lEblQvVmNEVlBMU1A4MTRSZWhGR3U1YVVPbDNx?=
 =?utf-8?B?U25HN1BVcTB2YjRNcHlNbGlidyt4SFJrUnV4NWRXSlQ4cWxsK3lJTXJXZzdz?=
 =?utf-8?B?ZVc3L0JqOW81NmZiT2xKT3ZkRXJENXprem0wN0lPUi81ejdmUnBYcWxKc1RL?=
 =?utf-8?B?QlloUHlpcFNTZXBoQStncGxlK3FUeWZLLzFTUjhPMWdUaU1PYTg3cnV3V0ZF?=
 =?utf-8?B?ZFQ2N3JuR1EyT3hPQm1mOVVXT0dhblZEeGQwWEdLcHB6NmdGWi9MMHNGWUt5?=
 =?utf-8?B?K0wwUzJZdHgwb0VibHNWMmU0UkN0Tk1RWVpib05EeWhaU1REWVBRMWpkU0R3?=
 =?utf-8?B?VmVUWm5abllnU0JhUmR1ejNpYXpNdlk0dk5lamgxNWkwa04rS2EvMmV5cnBa?=
 =?utf-8?B?VFVobldXSGdDT1UvekM1SzYwODc3Zk9GbkYrbmYyNlV5ZHc2K0NzbHBBV3BM?=
 =?utf-8?B?aUY3ajdtU0UzbCtpU0c4Vm40M0d0NGtIaUMwQzBKdUp6UGdVcWlxbkJCMjNz?=
 =?utf-8?B?VUtablYyVWdWZFM5NVNwdXZGblhmUkhXNlVGWGwySzgrN3RiRFc4RDV2R09y?=
 =?utf-8?B?a1ozSEw3RGRZaDNoVHVyRDBRcEZpUExHSUpsSlhIcDVDNTZrY2xCb3d5QVhi?=
 =?utf-8?B?Wkp5c2duWjQwSVVsQjBjWVpsZXo1MGtnVU95cC9lYUo3YnkyYWlNem9RUEJN?=
 =?utf-8?B?NGlvMGt0UGFjRDkvTTlTcU55TVVVd1pKd0JQTVJSZUtOaStYVzRyMDhvU3cw?=
 =?utf-8?B?R0xOWEhLUjFSakZOeWxDVC9VU0tNL2NrWnhiQ1l6RXFkN2hlT3J5SmtYbEJX?=
 =?utf-8?B?aXJTbTlhWmtPank4dGNKbmVCNmxIakltY2dHS1dJNFRMUEJXUmd2QVFVa1l5?=
 =?utf-8?B?QW54c0JOaThvcElvSEhudVZzSWVmbHN0ZVVrcDVoN1RhblNXV0VnRU1uUXpu?=
 =?utf-8?B?d0tIdTQ0czBXcXUxR3RKb2I2dE80MXU3QTU0YmNQRmN0cXFMcnF6SDV3ZUNq?=
 =?utf-8?B?L1Z4VWtYTks0Vk5qS0dzZWU4amdtTWFxYU9nZmJXU2Jnb3VFT055N1JMRFFk?=
 =?utf-8?B?VXpwTkI2bU1qODN3T1FHMEViMFZIc0IrUW1YRjFCYjZzQTFKcENXOGJ6SVFV?=
 =?utf-8?B?V3NQNkRpL255NFZoM0dUVVN5L00rU1ZwS2hZTXpLQ1kyaVZzZEdvWGYzZEsr?=
 =?utf-8?B?cHk0SDViZkVtQXY3RWZ3V2VaMkR0STVjeHdJL05iMlJiUFFId3ZaNkVtbEZD?=
 =?utf-8?B?SVc0bUdEeFlyazZiTlVESWVtNUZ4VVplOUdhbFp6U0g2b3BhTmRwcjJPRDlN?=
 =?utf-8?B?RzZuZ29tbVYrNDNHUDhoTFVPM3Qwa1liZDgrQjVtTEdPRnlVUnV4c1NpcTVG?=
 =?utf-8?B?QlpTb3hWb2VmNjZxbDV6dnBaMTBPd3ZEOXlubk5HQmpjdXBsOUJoMTF0WHpn?=
 =?utf-8?B?MzJZVjFSVzBnRkZHbXdrajY5QmtPTE9SVld3UHZXZCsyQmJIbzhqWkJaY0lt?=
 =?utf-8?B?d2xSeVNzZHN3eHNXUkJPcnZ3QUc3eVdCWS8rZTlNQzBHaEQvRU5jQU9sV29a?=
 =?utf-8?B?M2lBVDVnRnYzOWg0OVdmdCtVaDQ4VjVkd013Z3VUdHRtTVBhTTI3K1JoVDly?=
 =?utf-8?Q?SNJcU2d15apQoOA97ur9NTFYv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28231dc1-1773-460e-e0f1-08dcf23a35a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 01:38:20.1662 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6mZ6QqlsjGcoEn0QQnZx33E2zo6ds+8qmSF43fOE0Wss8C1OF0IVpA6qazTwW/wD/f1oT3GyLfB6vXwtnCtBCSeJd4dTmrSt3GfCD3fgWQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6144
Received-SPF: pass client-ip=2a01:111:f403:200f::71d;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDA5LzE2XSB0ZXN0
L3F0ZXN0L2FzcGVlZF9zbWMtdGVzdDogSW50cm9kdWNlIGENCj4gbmV3IFRlc3REYXRhIHRvIHRl
c3QgZGlmZmVyZW50IEJNQyBTT0NzDQo+IA0KPiBPbiAxMC8xOC8yNCAwNzozMSwgSmFtaW4gTGlu
IHdyb3RlOg0KPiA+IEN1cnJlbnRseSwgdGhlc2UgdGVzdCBjYXNlcyBhcmUgb25seSB1c2VkIGZv
ciB0ZXN0aW5nIGZtY19jczAgZm9yIEFTVDI0MDAuDQo+ID4gVG8gdGVzdCBvdGhlcnMgQk1DIFNP
Q3MsIGludHJvZHVjZXMgYSBuZXcgVGVzdERhdGEgc3RydWN0dXJlLg0KPiA+IFVzZXJzIGNhbiBz
ZXQgdGhlIHNwaSBiYXNlIGFkZHJlc3MsIGZsYXNoIGJhc2UgYWRkcmVzcywgamVkZXNjIGlkIGFu
ZA0KPiA+IHNvIG9uIGZvciBkaWZmZXJlbnQgQk1DIFNPQ3MgYW5kIGZsYXNoIG1vZGVsIHRlc3Rp
bmcuDQo+ID4NCj4gPiBJbnRyb2R1Y2UgbmV3IGhlbHBlciBmdW5jdGlvbnMgdG8gbWFrZSB0aGUg
dGVzdCBjYXNlIG1vcmUgcmVhZGFibGUuDQo+ID4NCj4gPiBTZXQgc3BpIGJhc2UgYWRkcmVzcyAw
eDFFNjIwMDAwLCBmbGFzaF9iYXNlIGFkZHJlc3MgMHgyMDAwMDAwMCBhbmQNCj4gPiBqZWRlYyBp
ZCAweDIwYmExOSBmb3IgZm1jX2NzMCB3aXRoIG4yNXEyNTZhIGZsYXNoIGZvciBBU1QyNDAwIFNN
Qw0KPiA+IG1vZGVsIHRlc3RpbmcuDQo+ID4NCj4gPiBUbyBwYXNzIHRoZSBUZXN0RGF0YSBpbnRv
IHRoZSB0ZXN0IGNhc2UsIHJlcGxhY2UgcXRlc3RfYWRkX2Z1bmMgd2l0aA0KPiA+IHF0ZXN0X2Fk
ZF9kYXRhX2Z1bmMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xp
bkBhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIHRlc3RzL3F0ZXN0L2FzcGVlZF9zbWMt
dGVzdC5jIHwgNTQ2ICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAyOTkgaW5zZXJ0aW9ucygrKSwgMjQ3IGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4NCj4gPiAtICAgIGZkID0gZ19maWxlX29wZW5fdG1wKCJxdGVzdC5tMjVwODAuWFhYWFhYIiwg
JnRtcF9wYXRoLCBOVUxMKTsNCj4gPiArICAgIGZkID0gZ19maWxlX29wZW5fdG1wKCJxdGVzdC5t
MjVwODAubjI1cTI1NmEuWFhYWFhYIiwNCj4gPiArICZkYXRhLT50bXBfcGF0aCwgTlVMTCk7DQo+
IA0KPiBXaHkgZGlkIHlvdSBjaGFuZ2UgdGhlIG5hbWUgPw0KPg0KDQpUaGUgZGVmYXVsdCBmbGFz
aCBzaXplIG9mIGZtY19jczAgYXJlIGRpZmZlcmVuY2UgYmV0d2VlbiBBU1BFRUQgU09Dcy4NCkZv
ciBleGFtcGxlOiBBU1QyNDAwIGRlZmF1bHQgZmxhc2ggc2l6ZSBvZiBmbWNfY3MwIGlzIDMyTUIg
YnV0DQpBU1QxMDMwIGRlZmF1bHQgZmxhc2ggc2l6ZSBvZiBmbWNfY3MwIGlzIDFNQi4NCkJlc2lk
ZXMsIHRoZSB0ZXN0Y2FzZXMgc3VwcG9ydCB0byB0ZXN0IGplZGVjX2lkIG9mIGZsYXNoLg0KV2Ug
c2V0IHRoZSBkaWZmZXJlbnQgZGVmYXVsdCBmbGFzaCBtb2RlbCBvZiBmbWNfY3MwIGZvciBhbGwg
QVNQRUVEIFNPQ3MNCkV4OiANCm4yNXEyNTZhIGplZGVjX2lkIGlzIDB4MjBiYTE5Lg0KdzI1cTgw
YmwgamVkZWNfaWQgaXMgMHhlZjQwMTQuDQpUaGF0IHdhcyB3aHkgSSBhZGRlZCB0aGUgbmFtZSBv
ZiBmbGFzaCBtb2RlbCBpbiB0aGUgZmlsZW5hbWUgb2YgdGVzdGluZyBpbWFnZS4NClNvLCB1c2Vy
cyBlYXNpbHkga25vdyB0aGUgdGVzdGNhc2VzIHRlc3Rpbmcgd2hpY2ggZmxhc2ggbW9kZWwuDQoN
CkJ5IHRoZSB3YXksIEkgc2V0IHRoZSBkaWZmZXJlbnQgZmlsZW5hbWUgb2YgdGVzdGluZyBpbWFn
ZSBmb3IgQVNUMTAzMCwgQVNUMjUwMCwgQVNUMjYwMCBhbmQgQVNUMjcwMC4NCkFTVDI1MDA6ICJx
dGVzdC5tMjVwODAubXgyNWwyNTYzNWUuWFhYWFhYIg0KQVNUMjYwMDogInF0ZXN0Lm0yNXA4MC5t
eDY2dTUxMjM1Zi5YWFhYWFgiDQpBU1QxMDMwOiDigJxxdGVzdC5tMjVwODAudzI1cTgwYmwuWFhY
WFhYIg0KQVNUMjcwMDog4oCcInF0ZXN0Lm0yNXA4MC53MjVxMDFqdnEuWFhYWFhYIuKAnQ0KDQpJ
IGFtIG9rYXkgdG8gc2V0IHRoZSBmaWxlbmFtZSBvZiB0ZXN0aW5nIGltYWdlIGJhY2sgdG8gInF0
ZXN0Lm0yNXA4MC5YWFhYWFgiIGZvciBBU1QyNDAwLg0KDQpUaGFua3MtSmFtaW4NCj4gDQo+IFRo
YW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCg0K

