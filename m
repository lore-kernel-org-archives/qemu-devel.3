Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAE9CD37B7
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMN8M-0002Cr-5b; Mon, 11 May 2026 05:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wMN7j-0001tD-93; Mon, 11 May 2026 05:40:27 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wMN7d-0001RA-Ch; Mon, 11 May 2026 05:40:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upfuABcYeelNswGb6lcn2qRwi9o0o3tArKGjkZZxvzMKYiTYU4MW/x/7V/rJTZevEuf2ubkHaiDiEZx4Yb0QYajo7aNe3xi9nJRIdfhTv801dEradRPRZxMPHQlSo1lp1mi5Emho3e54QfusX9abTkeSWmi7bLR/QLtBZ26zE0itqNGYztvKPx6cNGOTEcTUgn0gAd7VgOMYfXGMIZUxL+wdJ4yBNMQpOIZsYfltCjGHaRdSOPaPkXpUSOSITB5ZzmB/99gRv2ZrelW8CwJv1U22LV1k1KDQgrFLO573aE7W3sY1hdj/uZgEsqwBQNFdwIhEcwN3hVDKXsqFL16eqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSWTPWYOxHTX6l0cvhAcLKInV7KidfAXnh/bEmyHL94=;
 b=xAU10CPmZA52nMSjg/hh+7g7cOT+iUWdlV7EMRmwdIxnUvdobL2jHwyYcPHr/Q5UhTzahJKKXCppZE+YIpiD7c1TNYA7l8KkS/0wQeKdfSRaQ9Dbw+uWOH0h498jjZtplo/98mBDnx1cLx8dkLQxmYXskRXVihh9LuBfUlH0YNx+cOLXQvufoagetwIyfcyDWKIxRnRSYNjjQNRfYbzD8UfXgxvWNbL00nSJEWYyCS+r/kHSFakfJE3e9k1OspqmxOQx5tZ7eFX4NynK7Gnb7ohUTTvr+sJyNkCKNa9Oln7A6Sde0NBxVFdZVLqmtaP6FrWTxnShRlQss7g64r70lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSWTPWYOxHTX6l0cvhAcLKInV7KidfAXnh/bEmyHL94=;
 b=WzCi7zchVzZyu7WWwl7N0OO6HDvUosvxHOY8vezSgQO07bFiJIKkqxeEX6WrvnQd4yZbA0LqN/gQLWX6boBA7q+PbAGgN8h6PcJ1MELe/2UOeBPpV36j+rYBJxPdXj/Hl1ULXupgMNkAnMN0uhO2OpfrLjgC+b1DAMp2dlDfUFrW4LIMsRKONpDCxR69yFEfQFzhstYRnXR4WivZb6PrJJYlNDZYd2zHMUxiK1BXgol5Ov6Yzee89hBUZhN5D9x9DEyf07H6rtyUD+hn4B12yU2t6xLDB4QSlKcoVk24QmyBBhgzAE9Wnq89yAB/Qvp/pAS32NDdwNTwOzWFZibpxQ==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by DB5PR09MB8695.eurprd09.prod.outlook.com (2603:10a6:10:64a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 11 May
 2026 08:38:31 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:38:31 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v9 7/7] target/riscv: Add endianness test for RISC-V BE
Thread-Topic: [PATCH v9 7/7] target/riscv: Add endianness test for RISC-V BE
Thread-Index: AQHc4SGLlSK0wiAET0q8nxgomS+AYg==
Date: Mon, 11 May 2026 08:38:30 +0000
Message-ID: <20260511083819.206216-8-djordje.todorovic@htecgroup.com>
References: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|DB5PR09MB8695:EE_
x-ms-office365-filtering-correlation-id: f0a04f33-59c7-4ffa-527c-08deaf38aebe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: c30EEZunkxBxwzndXeFXNsU8cWh5rv7/JSTwHq3xyY/8Nh3VldwiY/gdVZvBnG4QIrrcT4t+c/LJyOCxq8TR4aB7CYv0Zr9ODuna9ydrgTQKzO5EzI9ydDamEIC+j3KgvDlhO1UaNtLK193e5ZTeVJSj3OmqC475v8+mme81HZKgevAxgILHy3jer19H0AeBnR1gksnU7y33ZSF8+8lD2txJ3IzHE9EhOCLdWBqSHvwn2Za6grdl4V2RoZeUOjRcs/mZde0blSFFfGQT+9DBa4NSuk0eGonYGrX9BpGK1LJ21SvUxPeYuE4F4zuokQoRwIfEO99g9lRrg2RW9xeEFQ24EkXVzgkKe2S4ZW7WS+vTm77lqbJWcBkaCjrDpagN/wf6dIg4QcH1B9TC09hWdeHoShBuimqbLWCZga/GhtiNbZYR7MUTCsJYLOD9tv1K4cF7Z47XIYZaJiSU659YLPq9JYTijURTOB9amI1PxaydKAQ1Kbw05KpwGn3539fNfhTvTiLl3niye9+TbX1It66Nkv2VYeBtzStTuoUa1yvg6fNORmLSchkCiEnxFODUwuIoiU2/yEJG1oID/eXw7l0Ul4jturMQUahFwHujuU6IXvZjtrKKHKPDr4yKmBm/Mq1bm9H0n1AAnwXibXdqPdVrbSkzLvbHi1a5v0kXB98EeRFOn1sG3qPOUUEUVkrbNK/T+29YPh18C9Xht/aQq0/jdX7ug6rRK66+FC17smkk7t+ck+1P+pV1/XIhH6Uc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NG5VQXFFZzIwT0FENys2cGdGVGZrNU5aYjFMVjBLU1k1L3plZUI4YU1OUEl3?=
 =?utf-8?B?cHUwOGtHODV2MkhOa1luSGhIcGNhUjhOb0doN0lLMHh2MFMzaTRUekZVc3J1?=
 =?utf-8?B?KzMxVHQxZGt1ZUtjM1NZbWNPMkFVK2xPdlBkTEVjbXBhdHVOSWo5dEdEYi96?=
 =?utf-8?B?M3pVdDhSMnh5NU9pUjRiTDhDSHdxaWVmc2ZXYVg1eDVraFRHOXMrL0NRbmhV?=
 =?utf-8?B?SEhMbXVCYzBHd1A1Z0NxUTliU2xDdlpHcGNnRnI3TFEwQk1TekY2OTZYWE45?=
 =?utf-8?B?eFRMbmcyTHhBSWlKb2JzREZ0OE4wYi9hQzkycFFxdHV6NDVsZ3lWejQyWGZI?=
 =?utf-8?B?Zm1TbVNVeVJjaTV4R1ZwMnJUeSsvVHFLcmpReFJLNlFBRVRoMnZRUWhxeHlo?=
 =?utf-8?B?Z2hkZzNzcldGWGxkN0lacHg1UUsvZVBDSWVxQituSDZBdXBuMGUxSExVdTZJ?=
 =?utf-8?B?MmZ1SHhWSmQ4WVJPMGJwMnJYNXY1RGI5L3U0TDdXZlozaWR5aDQwSytCYVNm?=
 =?utf-8?B?WHduaWVNUE1VMDdCQVNoTGFqM3MvQVNiMnVISG8rekJ4K0ErR0RRdk5PZG1H?=
 =?utf-8?B?Y3hPYm9mK0NIK3R1a0RmWmJqcjJHbTJuZTlkUkdYT2IzQ3lhTi8zZkNMbWh0?=
 =?utf-8?B?Um14YUZYcCtXb3Zyd3hTVHpyUEt2eDNRNTM0S1dRUGY0Q2p0aDVQK1NoQUF5?=
 =?utf-8?B?Yk8rRURHSytSdjNkRjNWYkpZYSsvd0dJTXEzS2hUZldIZkpyQmVPTXphbnlq?=
 =?utf-8?B?N2g0cURaMlFzaGIzcW9hTHNJZFRhbGFLcUhTVW1NblVFWnRvY0NJYWpEOGx6?=
 =?utf-8?B?OVZoU2FQVCtnU25sVWU5aXpGdFhpTncvNjJ4ZXRodjd2eEQ5NEhKR3h1ZnFo?=
 =?utf-8?B?RUFYZGZiOER1NUxZT2dTUXlhaS9jOUtkTjlYd2FCQjdzVWZHZUg1cVZRSEdN?=
 =?utf-8?B?NGloZUZNSE9mbklWRHRBUG92eWx3VFZNeGlnTXpoNS9XUVJQL3lqb3czV2Vm?=
 =?utf-8?B?a3RSa0hhQ3JPdktPV3RnTVNPTXpxSENhVndaMmppejFkNlY5OEY2YVhKd1No?=
 =?utf-8?B?eXYxSnowb3BjbTgwcXJXUmdPRXNsZTB2b2NRMHUrc2dmSCtUNGVYVmErSzNX?=
 =?utf-8?B?TSsvOElDS2wwNHc3bXRxaHNzaUxxQ0pPL0tzQkE1L1hUTTNiWk80SncxSndl?=
 =?utf-8?B?dHNGNDRWck4wZVRXS2VZMm8vS3dkUDdvQ1FkZjFVWVRTc0IwU1Evd2loWExa?=
 =?utf-8?B?VnZ6UFkrZFV6RVRvQmhFbjYxdUdJb0RkNUJib0N2Tzloa1hKcXVKb3FJYkcr?=
 =?utf-8?B?RmFGdDVUTXc3cmsybU1pRURzWWsyOHMxdDZoblJhQ3VQU0MxUVVBYk9KUlNK?=
 =?utf-8?B?SWVZWlFoUHYwNExYUGlrdm9LQnNvRzNad0RncjBDZi84WmkxLzJpUmsyakFZ?=
 =?utf-8?B?VVF2SW5IamZSSm0yUHc5eVVoVlRpZ1RHY2UzVllCN0doZmw2T0x5dmo4OUpy?=
 =?utf-8?B?dmpuL0NPcG5wTytaSDZWVFhaZEdHVjlDemw1OGcxYlJCSGhSMmV4NUJIRDF6?=
 =?utf-8?B?WTN0UDdwZ2QvTklOdzJ1aHl1dEIzS1F2Tks0Uzc3TzB5YWNiNHZuY2JhTk5i?=
 =?utf-8?B?R2l0ejJBbjN2cXRuNlhaczdhK0dxbCtiRG4zNW9zYUhaekhWK0lLWUtGcEJF?=
 =?utf-8?B?MGhPcU9hN0lDRG9TK3paanJBR0hYQm1Vci9ESTdESXlkTUdSQlpYckUxRHRQ?=
 =?utf-8?B?QlFCTDlOb21SSGhDY3BYeUFRSGp0allaM0YySEtoeitacEFZbHEvWExHa05X?=
 =?utf-8?B?RkFqa3dkSUEzSTlMSExTdlBjOEZJMVRWWlRsUkRNVlA2ZzNjSlhtdVdJTTFy?=
 =?utf-8?B?VkF6M2NTWHBhUWdVWE9lbEtIbEhhY3dQUFdqdlljaGRBRDIzNWlNN2ZlLzNO?=
 =?utf-8?B?UzN0cjhmYkd0NWNEdHJEWllFM0FFRlliMU1NcU1QWDlXTjZVQjhOMmIwaWEr?=
 =?utf-8?B?RHNUcXpobWxuY3VwSkRSUlBaYmczZUF3eXJSQnMrMUhDZmZNNVBTWC9HNTVW?=
 =?utf-8?B?TDFMRldOeTJSOXBKeVF4TUw5VGxSWkZ1YVB5NFN6MGEzSXJjeVRQTE5SSXkv?=
 =?utf-8?B?RkE1Y1crdml2OHJMcWZISkpnUm5hU3JsKzZvc3A1STlSUVVjcTNmd20rck1N?=
 =?utf-8?B?elJRVWhWU2hDY3F2ZkNpdjBoMEd6eStqT09icDZNeUJmMlAwejMvZGRyOU95?=
 =?utf-8?B?L2dPMDVzRmVFSzZ2Slh1eE1UZVBEOG4yWGtXdEtxZDNMckYyVkJ4VHdrclZl?=
 =?utf-8?B?SmM1c2ZlTktqVjZLUzZZelRLUzF2bHNVcU5VUHpUVWF2OUpLY29YTndwSHJR?=
 =?utf-8?Q?tFxrHaXll3/AZVLuhaV2rxP3lQNlhA7P+IAku?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <925BD31033CEC24F89726ABF8EA2147F@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a04f33-59c7-4ffa-527c-08deaf38aebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 08:38:30.4023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3DFA5yDhIiy3fcCSSqSk1AKlF+G1ZTaY5oMGetRwwIzB0HwAFrqV97IMz3081QfeQrAj70OMoIV+3k+ETuBEF3kdEGKdx+FrxvRM9HGmmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR09MB8695
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

QWRkIGZ1bmN0aW9uYWwgdGVzdCBmb3IgUklTQy1WIGJpZy1lbmRpYW4uDQoNClNpZ25lZC1vZmYt
Ynk6IERqb3JkamUgVG9kb3JvdmljIDxkam9yZGplLnRvZG9yb3ZpY0BodGVjZ3JvdXAuY29tPg0K
UmV2aWV3ZWQtYnk6IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPg0KUmV2aWV3ZWQtYnk6
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCi0tLQ0KIHRlc3Rz
L2Z1bmN0aW9uYWwvcmlzY3Y2NC9tZXNvbi5idWlsZCAgICAgICAgfCAgMSArDQogdGVzdHMvZnVu
Y3Rpb25hbC9yaXNjdjY0L3Rlc3RfZW5kaWFubmVzcy5weSB8IDU3ICsrKysrKysrKysrKysrKysr
KysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9lbmRpYW5uZXNzLnB5DQoNCmRpZmYg
LS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvbWVzb24uYnVpbGQgYi90ZXN0cy9mdW5j
dGlvbmFsL3Jpc2N2NjQvbWVzb24uYnVpbGQNCmluZGV4IGI5OTZjODlkN2QuLjU4NzEyMTFlODkg
MTAwNjQ0DQotLS0gYS90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvbWVzb24uYnVpbGQNCisrKyBi
L3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC9tZXNvbi5idWlsZA0KQEAgLTExLDYgKzExLDcgQEAg
dGVzdHNfcmlzY3Y2NF9zeXN0ZW1fcXVpY2sgPSBbDQogXQ0KIA0KIHRlc3RzX3Jpc2N2NjRfc3lz
dGVtX3Rob3JvdWdoID0gWw0KKyAgJ2VuZGlhbm5lc3MnLA0KICAgJ2Jvc3RvbicsDQogICAnc2lm
aXZlX3UnLA0KICAgJ3R1eHJ1bicsDQpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9yaXNj
djY0L3Rlc3RfZW5kaWFubmVzcy5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X2Vu
ZGlhbm5lc3MucHkNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwLi45ZTBi
M2I3ZGI1DQotLS0gL2Rldi9udWxsDQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVz
dF9lbmRpYW5uZXNzLnB5DQpAQCAtMCwwICsxLDU3IEBADQorIyEvdXNyL2Jpbi9lbnYgcHl0aG9u
Mw0KKyMNCisjIEZ1bmN0aW9uYWwgdGVzdHMgZm9yIFJJU0MtViBiaWctZW5kaWFuIHN1cHBvcnQN
CisjDQorIyBDb3B5cmlnaHQgKGMpIDIwMjYgTUlQUw0KKyMNCisjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQorDQorZnJvbSBxZW11X3Rlc3QgaW1wb3J0IFFlbXVT
eXN0ZW1UZXN0LCBBc3NldA0KK2Zyb20gcWVtdV90ZXN0IGltcG9ydCB3YWl0X2Zvcl9jb25zb2xl
X3BhdHRlcm4NCisNCisNCitjbGFzcyBSaXNjdkJpZ0VuZGlhbihRZW11U3lzdGVtVGVzdCk6DQor
ICAgICIiIg0KKyAgICBUZXN0cyBmb3IgUklTQy1WIHJ1bnRpbWUgYmlnLWVuZGlhbiBkYXRhIHN1
cHBvcnQuDQorDQorICAgIFVzZXMgYSBiYXJlLW1ldGFsIFJWNjQgRUxGIHRoYXQgZGV0ZWN0cyBk
YXRhIGVuZGlhbm5lc3MgYXQgcnVudGltZQ0KKyAgICBieSBzdG9yaW5nIGEgMzItYml0IHdvcmQg
YW5kIHJlYWRpbmcgYmFjayBieXRlIDAuIFByaW50cyAiRU5ESUFOOiBCRSINCisgICAgb3IgIkVO
RElBTjogTEUiIHRvIHRoZSBOUzE2NTUwQSBVQVJUIG9uIHRoZSB2aXJ0IG1hY2hpbmUuDQorICAg
ICIiIg0KKw0KKyAgICB0aW1lb3V0ID0gMTANCisNCisgICAgQVNTRVRfQkVfVEVTVCA9IEFzc2V0
KA0KKyAgICAgICAgJ2h0dHBzOi8vZ2l0aHViLmNvbS9NSVBTL2xpbnV4LXRlc3QtZG93bmxvYWRz
L3Jhdy9tYWluLycNCisgICAgICAgICdyaXNjdmJlLWJhcmVtZXRhbC9iZS10ZXN0LWJhcmUtbWV0
YWwuZWxmJywNCisgICAgICAgICc5YWQ1MWI2NzVlMTAxZGU2NTkwOGZhZGJhYzA2NGVkMWQwNTY0
YzE3NDYzNzE1ZDA5ZGQ3MzRkYjg2ZWEwZjU4JykNCisNCisgICAgZGVmIF9ydW5fYmFyZV9tZXRh
bChzZWxmLCBiaWdfZW5kaWFuPUZhbHNlKToNCisgICAgICAgIHNlbGYuc2V0X21hY2hpbmUoJ3Zp
cnQnKQ0KKyAgICAgICAga2VybmVsID0gc2VsZi5BU1NFVF9CRV9URVNULmZldGNoKCkNCisgICAg
ICAgIHNlbGYudm0uYWRkX2FyZ3MoJy1iaW9zJywgJ25vbmUnKQ0KKyAgICAgICAgc2VsZi52bS5h
ZGRfYXJncygnLWtlcm5lbCcsIGtlcm5lbCkNCisgICAgICAgIGlmIGJpZ19lbmRpYW46DQorICAg
ICAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWNwdScsICdydjY0LGJpZy1lbmRpYW49b24nKQ0K
KyAgICAgICAgc2VsZi52bS5zZXRfY29uc29sZSgpDQorICAgICAgICBzZWxmLnZtLmxhdW5jaCgp
DQorICAgICAgICBleHBlY3RlZCA9ICdFTkRJQU46IEJFJyBpZiBiaWdfZW5kaWFuIGVsc2UgJ0VO
RElBTjogTEUnDQorICAgICAgICB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oc2VsZiwgZXhwZWN0
ZWQpDQorDQorICAgIGRlZiB0ZXN0X2JhcmVfbWV0YWxfbGl0dGxlZW5kaWFuKHNlbGYpOg0KKyAg
ICAgICAgIiIiDQorICAgICAgICBCb290IGJhcmUtbWV0YWwgRUxGIG9uIHZpcnQgd2l0aCBkZWZh
dWx0IGxpdHRsZS1lbmRpYW4gQ1BVLg0KKyAgICAgICAgRXhwZWN0cyAiRU5ESUFOOiBMRSIgb24g
VUFSVC4NCisgICAgICAgICIiIg0KKyAgICAgICAgc2VsZi5fcnVuX2JhcmVfbWV0YWwoYmlnX2Vu
ZGlhbj1GYWxzZSkNCisNCisgICAgZGVmIHRlc3RfYmFyZV9tZXRhbF9iaWdlbmRpYW4oc2VsZik6
DQorICAgICAgICAiIiINCisgICAgICAgIEJvb3QgYmFyZS1tZXRhbCBFTEYgb24gdmlydCB3aXRo
IGJpZy1lbmRpYW49b24gQ1BVIHByb3BlcnR5Lg0KKyAgICAgICAgRXhwZWN0cyAiRU5ESUFOOiBC
RSIgb24gVUFSVC4NCisgICAgICAgICIiIg0KKyAgICAgICAgc2VsZi5fcnVuX2JhcmVfbWV0YWwo
YmlnX2VuZGlhbj1UcnVlKQ0KKw0KKw0KK2lmIF9fbmFtZV9fID09ICdfX21haW5fXyc6DQorICAg
IFFlbXVTeXN0ZW1UZXN0Lm1haW4oKQ0KLS0gDQoyLjM0LjENCg==

