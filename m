Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D1FF43683
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfwF-0002Iu-2K; Fri, 17 Apr 2026 05:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDfwD-0002IT-8e; Fri, 17 Apr 2026 05:56:37 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDfwB-00022H-JV; Fri, 17 Apr 2026 05:56:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sckF2JAVW4IprT1oXhUA6x9mQpPjjPg+o1PYqlQp7ohkWUsANgyne5qnYmPCwKOiHLAJMf0N+xJYF0irJflMPwRClJ5yGIIvkp8ObzQyG6uAZUFm7ORO5ZHs1KwNLCgPCe1fx2PhndPW0YdLT1NVNFTqyC5hk6Lh9YT6+NXWPQMF56hkYtHr6UPNFqf/r66c8uOQwAxBJ4eRh04g13yEKWXVi0hhppdSj7crV+2XFw8ybNHes/4yNTfge5qPS7Dfrpl3wUSly2/o+4HVUwjdPmr1IIzhfKgeKQSelzl3NYndiMY/zc4WBEat6AvbkuBcp4PaS99l6yaDct/WpdATJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQLtMpt+7VfHfRkqVCiR4dBYipwyxshLSdVHrY+oyeg=;
 b=vhJbfnMvQdhSd/DFhG2mAvrEtDuYnIP4yHEGoU6whtsib1oDs/QnwTu5Cd3+qLkt1PzCHYk5pkmumNXiCuEIQZZtoVeu+V3wXHL7lRlPT+tGHi+1Pn0Wm1Chz9Wsm3FUf3iG44zzHIECojY0mn+/0S8KNh1X0G+/7WaDBmb7SF9X2B5W3xEOB3NUksW7XH4IRMkX5wkSL9esVZQdXHkMRzVu4kE8QPGvfXdCqPGiUnuzIKvHa/2F6L5DoDTtCLoBtL4S3kIOuIQba4fKOtVZMNBkXMUEI5TXLFM+Q7mO+Wf+8KcnQaoIQ4jOdHVsfDoLOcqQVp7qX9CmF8J9faDuWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQLtMpt+7VfHfRkqVCiR4dBYipwyxshLSdVHrY+oyeg=;
 b=QsF8qnR0/HWJ9cFBe7rgOpcdQsfL9hpgbQwWTL9fDlCk4Be+oRcMEDYphl7FehdXbFdPKfzeHWyKRB2AqtVuwZ2gnmM23RVps6ZGVcb4nNJgJ2aggvDpAd82zpuqInlWihfB32bMMqTK89wyVPU2lsUJOlx5Y3rDB+y7GfiKLyjBUS+5e4jl6omGX9Ld/OihskujWBg4PKCetn9I9ht3xzmPax8ZDF50OK5GgjPdKZZl99Ko3McoD7I079G/i9nQZXeX0UZdS/dTFzKm4KtVSSRNsbhLXqEqr/sk3FkmJyRf/Hr7JMfamaSZEhJOGuKJU0Dsd9KmkX6p//+LPWmqNQ==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by GVXPR09MB6976.eurprd09.prod.outlook.com (2603:10a6:150:1bc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 09:56:31 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 09:56:31 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>, "thuth@redhat.com"
 <thuth@redhat.com>
Subject: Re: [PATCH v6 3/7] target/riscv: Set endianness MSTATUS bits at CPU
 reset
Thread-Topic: [PATCH v6 3/7] target/riscv: Set endianness MSTATUS bits at CPU
 reset
Thread-Index: AQHcxdz7egpNESDMekSh2U2baJ4kobXTpYeAgA9vrAA=
Date: Fri, 17 Apr 2026 09:56:31 +0000
Message-ID: <e9d48570-c0d6-4ebc-a125-adc9d3b4506a@htecgroup.com>
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
 <20260406154935.144674-4-djordje.todorovic@htecgroup.com>
 <172ff713-a646-4a2f-880a-8d47a812c0db@linaro.org>
In-Reply-To: <172ff713-a646-4a2f-880a-8d47a812c0db@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|GVXPR09MB6976:EE_
x-ms-office365-filtering-correlation-id: d043d8db-2b88-4f41-584b-08de9c679a0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: acKBYtgu3tWGWGrEUpfy2Tb7fyFgeqGxXGySIdlH5Bc7uM2P1zQ5XdoxCE5DgorO3gC0uokAdPLIJkLot7L8FmzFI0AEZaWGJr+qgAT27NfAD2+B6m0qHFJxsIC88S08HOe/iWOVVAdldJZ/kIb8fvPtrawqZIzroBaVZtHoKa/spRRl6Ca2PwgkCYN3MnqoI4anuuNsst1vEL0bcoqec2KmIRMKj/aJdjGtxVhvdSgevT3dmzopooRLnkPW9xjyGHb3ABAy2B7GPC6JgdsiKmYpA6LMOjRkGcmLCO8aR4eHeX/F3spoIeOuYqgXtHzpwm1t1g600GUeFliF66y9tPdFcTeDMc3HVAC3nZogyRK7hWfHxlFtOUux2ETGckIGfvyThLrb8a1iXj02qTiztEfepC6NSm1u2v+1wO6yWF0oDRI9Hc+Ikh7PxpAk1h3X+n5IfpZ+eboko1xooG+Dgr8n4VSnQTvanenLbGzxK0RVOn5Eky3ARenPvcm/u/DkHFk/ES8y7f74Zqd9Q9MgBj84l3IdQnTz+my0qt3IyrTTgdKRenttTeYmoUQnIUs/TTjun3fpewE5cp/h9enDnE5XRzGuGK7HA73GPFY+CEiKYm5rrIKeEzh85pFlN7kzULy5+Z/fr5ghxQJOyaL6KeAEM+VB7YzxhXOWDJF3yHdkHynDWf5R2y55yi6P5hdz3l0Q9+8oS7x1oHBZQLHkWd/YguKJkEv9CNlbemNJP9F4qUaXi1k6GJnI6ugcI4UAqvUtLGNXJwk98hnjSwbHyZ+IiNcT19qKp09TCgfsEK4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEE3UFBxTW5WWFRMY2xnVlZTcy9yNGRFVnpWN2VkK28xM2JwNVlud1huK0lm?=
 =?utf-8?B?UWlqQmUyTFdCL09aVFhlMVo1NzZlOGNGUVEyWEF3bU1RZFZHUm14YzNZSVRZ?=
 =?utf-8?B?WUh4cThUWUZrNmFRbTAraUd4dk9aMWxBUnJCSC9BK0kyZ0VIK25pZnVqdktH?=
 =?utf-8?B?Y25aMmRKUHhicnI3UHdVc1RyekhuaXZyL2RlNUN3K0dVRERURW0vK1ZDZ2oy?=
 =?utf-8?B?elpqZGRCaHMwWUZrejkxejlORFhtc1FzcnBjL0xDUnJXTFpYbWYzamx4MFNF?=
 =?utf-8?B?TkxId0RxN0FON3JWRk92Mm5XZ0NnbmtlL25aMkJuU2dhbEp0SS8vZ1lNUExp?=
 =?utf-8?B?NzZVeGt0VUJyRnNXaDBmY05sZnMrTnQ0V2VVU1AxVUFQTEFlclg3WDNQcEJX?=
 =?utf-8?B?bmpCOHVqcU1mVENmbVB0V1h6REswblZoWFNnZnFCL05qTi9OeVlIcmpJdExR?=
 =?utf-8?B?MTZkNlg2c1JqdnloWDl5d1E3d04wN3NDSUIzNE1Yd0U4SENid0pkQWV1QTNw?=
 =?utf-8?B?NzA0amg3T3hQeEhkVDUxcFZxYnNadFlyOVY2aC9tbFE3S3RiU0JvUDFjbGxw?=
 =?utf-8?B?Q1F6eDVUbjZNZWcrcGRmbUUxRWtKYmpJdGVQZEJpM2lNZkY3WDliVTNZSnYw?=
 =?utf-8?B?NWxqZ3BzbTN6MzhpRnBKSnZGV2xZQ0wxRXVabjRsdWo2UHVKQ0pYR1Y1a0dI?=
 =?utf-8?B?WWhmS0dUMDlGcU9iY0hmUUV0Y25HVERZRzZWaW0vL3pON0ZpSmRQdzEvOE5K?=
 =?utf-8?B?MEpMeXdEYVpVSlIweDVDdHFpK0FVRUJLWURRQklaOVM1ekRhckxEbmpRcUpp?=
 =?utf-8?B?TlN1a2UzYUNya0x1MmE0L3JDbDRlN1NJbGFDQjZxdjVsLzhlemV3N01JK0c4?=
 =?utf-8?B?WW1DbFR6K1ZoK0RzdUNMYVlXd0cvb1NnUUV0LzYyaEhOeW5KL0hsSi9hMVNj?=
 =?utf-8?B?cXVmS1NKQlFMNEhRYllEK3lDRk5XWTZ4clNwYXRSQUhmVklZeUNKaEtNSFRz?=
 =?utf-8?B?QWhpN29nOUhhaWQ1bldqSmZSbTZLYWNnWTFpbTQ4OHBHOEtwZTE5R3lPSHVY?=
 =?utf-8?B?TWRYV3ZtSG1nT0xyemVKZDhXazY2bWhIUVBuOVlpemFwN1NJMjBWRGdsbUxM?=
 =?utf-8?B?Y2pIMUtOc09mU0VvNXRZTTBZUkc3M012d1lYOHhiM1ZPNlpmS0hZNWhuTllI?=
 =?utf-8?B?akN6OGNDNHJjZUJ4RVNrQ20yTGJBOE40dmhRemRmRGVmUlBraDE4OEQ2Tmox?=
 =?utf-8?B?NDlaMnQ3c0x2QWlMK0dLSlk2L0lDV3VCMGsvSGRxSG1MZ3lKOFpMK2NMd0Uw?=
 =?utf-8?B?enpRbi9RbXplV2dZR2crd1FNZ2NwUFJubVA5SHVLaUhiVzBpaFpqYnpnaGVF?=
 =?utf-8?B?ZjhicHF6YkZyVk54eFhGU3NMdFlEZ2JpMFJTdlVvcll2SXdMRStDTnlGMDhu?=
 =?utf-8?B?VS9xU3NaNTZvYVNFTDBhbm5LUzM1UzdQMER3OCtGbEdwKzFlRnNQUjlkajFo?=
 =?utf-8?B?VElKZ0RRSllYMHhoMzkwN1RlMlBzRW0yUHZkS3NGMzZRdWMxWDlHZ243QmJI?=
 =?utf-8?B?bXZkL1hZeHI1YU5TNHVrUjZweXpIdU55enk2bTFGbXFDY2o0MHQrZXVCVi9G?=
 =?utf-8?B?MTZzUXd6SGtyUlQyUFF0UDlRR2VTZHlkR2FwSm5zb0tHa0FiOWw3RHFjUzF4?=
 =?utf-8?B?N29RdElocHdsMGhBY1AvTjg0ZkltWUd2aS9EZzd0TDh6U0JSUjZJdDlvdkUv?=
 =?utf-8?B?SUtPa0t6L1BCbjNIRDV2WnpsVGpsOE1Mdk95MnBOWmNZdk1WZ1l5bHRZcVdk?=
 =?utf-8?B?N2thdTB3bXpVLytxOVVOY2JSaTVnMy9CZEQwZ1VvL05BNmpWMnNXamlyMERt?=
 =?utf-8?B?S0M5N2IzNFJVcDhrYVNKRnFRV2NRbFJZUzB1MWdiNm13cm81YzkwdkRCak8v?=
 =?utf-8?B?R290VkhEeUFBbjBTbjk0SCtabkZwQTI5RUl3aW1XOEhRRU9OZTUrSUV4cENl?=
 =?utf-8?B?K0VHbkNtRU1LSHZTTVB3clVYSGtRTVd2TWswamlBRUFGU1ZuWWZhRklJdCtX?=
 =?utf-8?B?Q3o0ZzllUXNybkszU3JGaHBGTDF1YUYxZzY2L2NvdTFVdEtud3RTTjhOM3N2?=
 =?utf-8?B?MENQU1k1dDlXZStDYVRJYThkVUtFVkhCcDk0V1NtamV3TEhkM0Z5a1ZCSldV?=
 =?utf-8?B?OUNVQmtnUjJ1MVkrM1NTcnVoSlZaZ0kzVGt3ZUQ1TDdRUGZFcUYwczNrVmE3?=
 =?utf-8?B?QVpuWTFqbnJPS3ViazdFRVd0UXBxZzUyaU40bFd6ODJDZDFBekNPcWhrZTdW?=
 =?utf-8?B?amVObDNUUnJlbTROV2RGcUwxc1J3NDJseVhMZFdIRGtUYldzYTJRTEhGN2Q0?=
 =?utf-8?Q?Y1F+6gFTVkplKEWCWRpKsI2llabKCIiVzsIkH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D24A372FAFFCE46AC393DB3BB2E4AB0@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d043d8db-2b88-4f41-584b-08de9c679a0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 09:56:31.3149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECkp1Z/3PtWEP5UuodLWLKMdHkmkixJs4ihVFoBbLwTktQBFW5kR/gmBBSZXK+Tes1vzXErIOqY3PG0hI73jVYjSa4efkB3Tsg3XqArGcww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6976
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

DQpPbiA0LzcvMjYgMTY6MTIsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBDQVVU
SU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRp
b24uIERvIA0KPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IHJlY29nbml6ZSB0aGUgc2VuZGVyIA0KPiBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0K
Pg0KPg0KPiBPbiA2LzQvMjYgMTc6NDksIERqb3JkamUgVG9kb3JvdmljIHdyb3RlOg0KPj4gV2hl
biB0aGUgYmlnLWVuZGlhbiBDUFUgcHJvcGVydHkgaXMgZW5hYmxlZCwgc2V0IHRoZSBNU1RBVFVT
X1VCRQ0KPj4gKFVzZXIgQmlnLUVuZGlhbiksIE1TVEFUVVNfU0JFIChTdXBlcnZpc29yIEJpZy1F
bmRpYW4pLCBhbmQNCj4+IE1TVEFUVVNfTUJFIChNYWNoaW5lIEJpZy1FbmRpYW4pIGJpdHMgZHVy
aW5nIENQVSByZXNldC4NCj4+DQo+PiBUaGlzIGNvbmZpZ3VyZXMgYWxsIHByaXZpbGVnZSBsZXZl
bHMgZm9yIGJpZy1lbmRpYW4gZGF0YSBhY2Nlc3MsDQo+PiBtYXRjaGluZyB0aGUgUklTQy1WIHBy
aXZpbGVnZWQgc3BlY2lmaWNhdGlvbidzIGVuZGlhbm5lc3MgY29udHJvbA0KPj4gbWVjaGFuaXNt
LiBJbnN0cnVjdGlvbnMgcmVtYWluIGxpdHRsZS1lbmRpYW4gcmVnYXJkbGVzcy4NCj4+DQo+PiBB
bHNvIHVwZGF0ZSB0aGUgZGlzYXNzZW1ibGVyIGNvbW1lbnQgdG8gY2xhcmlmeSB0aGF0DQo+PiBC
RkRfRU5ESUFOX0xJVFRMRSBpcyBjb3JyZWN0IGJlY2F1c2UgUklTQy1WIGluc3RydWN0aW9ucyBh
cmUNCj4+IGFsd2F5cyBsaXR0bGUtZW5kaWFuIHBlciB0aGUgSVNBIHNwZWNpZmljYXRpb24uDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogRGpvcmRqZSBUb2Rvcm92aWMgPGRqb3JkamUudG9kb3Jvdmlj
QGh0ZWNncm91cC5jb20+DQo+PiAtLS0NCj4+IMKgIHRhcmdldC9yaXNjdi9jcHUuYyB8IDEwICsr
KysrLS0tLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHUuYyBiL3RhcmdldC9y
aXNjdi9jcHUuYw0KPj4gaW5kZXggNDUzNzMwNWRmZS4uZWVkNWFmZDI3ZSAxMDA2NDQNCj4+IC0t
LSBhL3RhcmdldC9yaXNjdi9jcHUuYw0KPj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5jDQo+PiBA
QCAtNzE2LDYgKzcxNiw5IEBAIHN0YXRpYyB2b2lkIHJpc2N2X2NwdV9yZXNldF9ob2xkKE9iamVj
dCAqb2JqLCANCj4+IFJlc2V0VHlwZSB0eXBlKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZW52LT5tc3RhdHVzID0gc2V0X2ZpZWxkKGVudi0+bXN0YXR1cywgTVNUQVRVU19NRFQsIDEp
Ow0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4+IMKgwqDCoMKgwqAgfQ0KPj4gK8KgwqDCoCBp
ZiAoY3B1LT5jZmcuYmlnX2VuZGlhbikgew0KPj4gK8KgwqDCoMKgwqDCoMKgIGVudi0+bXN0YXR1
cyB8PSBNU1RBVFVTX1VCRSB8IE1TVEFUVVNfU0JFIHwgTVNUQVRVU19NQkU7DQo+DQo+IFlvdSBh
cmUgY2xhbXBpbmcgZW5kaWFubmVzcywgd2hpY2ggZG9lc24ndCBsb29rIGNvcnJlY3QuIA0KDQpO
aWNlIGNhdGNoLiBGaXhlZCBpbiB2Ny4NCg0KVGhhbmtzLA0KRGpvcmRqZQ0KDQo+PiArwqDCoMKg
IH0NCj4+IMKgwqDCoMKgwqAgZW52LT5tY2F1c2UgPSAwOw0KPj4gwqDCoMKgwqDCoCBlbnYtPm1p
Y2xhaW0gPSBNSVBfU0dFSVA7DQo+PiDCoMKgwqDCoMKgIGVudi0+cGMgPSBlbnYtPnJlc2V0dmVj
Ow==

