Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACABCD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 01:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPsAg-0006fV-NA; Wed, 20 May 2026 21:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wPsAe-0006f3-JW; Wed, 20 May 2026 21:25:56 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wPsAb-0002Lb-R3; Wed, 20 May 2026 21:25:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugXzGDdl2M+UDSdY7WfrSWyX/1iAwCwl/4/u6yDg5eQKQ+3FRNrDAjErGlBBWuKyldYt2UO0z/uYmYB6CE8WaQXjvLGehXckkL8Wqvv9be9kgsHg0WsKzx5ui5Lmd3ksAf6BqtoWpaCxvrBI3BxcZBd5+x6oBX0Oi6FpKKbv6Yvk4DH3A+7zn3w5J3mD95I9Jsh4+wVpDZ4gO2d3g8HvYa8bvU1YYbMyfJMJZ3T5VaHZFPH0KtPDSLbW0IPxLe05QAfvWQi8pyfB/lNC2FjN4iLJBRF4OVX0wsE06xEaGawoMF9SaghHqUVHCyazaKs4cny0NnDEyszwdu+cLhTKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzoTbiBHPBlfojKn61WVrnasFexi4p3A0ppdiC6wwPg=;
 b=lbrKdCyiu7ghYOgWxWyfiQIp5TU7RhLfFmo75lOjB1L26C3wlFid7vmsOn597PyXnkoMqKfV96y5XrOQadljqxNKayixvPzSuosnhJJftTnp4ZRX6achR1rafevzw7Y1RTbgvkZD+Tzw8q6wYtW2R2yntqeqVf6Ck4SYsrZdNeWXSO3M764IS0CmVFYkNxK4wBWIDmNMNrMK+rZp7bkFxajyRP55FFg3GA7DjEjyA5qnzsPE8qZqdAMR617P3POT+eFUZJAZdL3CTdsd/RM9hYL4hFh5QIqHk/0Q19bCpSmbOdHfPFfhwvN36QB+nLBwLIpUCoausPMEnwX1maDCRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzoTbiBHPBlfojKn61WVrnasFexi4p3A0ppdiC6wwPg=;
 b=RcoVqHiJm3qv2gWSDDRsbVXKwFHS8Ti6riyfSPURgeeFKe9HZxyJglZWHEFSKm6ISQd7IvdiHv46Vl18JnI82fGIl11+MpZjyjNvimIy9vRVoFPk0dtQCQAe6TKVZJ7R3dQvGGx+1VQkeJdceGB6ppgIf4PZwxJrU6fSDSnFXvk5JiJ1COWIM7mz90n65yevVDK+wKPiOeXVzJOeZJ91ynqH3PEkMoIW4ohiFYLlXrV2+LbFlNaqaGv7x8wcfJw7W8Qwn9vjugEBtPomwOqJ1jW1h4/0M42yHj8Mb4z2GQQLLReQAG5m6AtY9tK927+B67NMwcHXIxed6WNbdF4xIA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by OSQPR06MB7182.apcprd06.prod.outlook.com (2603:1096:604:290::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Thu, 21 May
 2026 01:25:43 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 01:25:43 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PULL 26/45] hw/misc: Add basic Aspeed PWM model
Thread-Topic: [PULL 26/45] hw/misc: Add basic Aspeed PWM model
Thread-Index: AQHclcGY0tgAGm13Q0G0/B/G/KCl17YXwMYAgAADgoCAAJAyEA==
Date: Thu, 21 May 2026 01:25:43 +0000
Message-ID: <SI6PR06MB763102E2FB6153F67B84F77DF70E2@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260204103136.1795455-1-clg@redhat.com>
 <20260204103136.1795455-27-clg@redhat.com>
 <2c9aa5d8-993f-4636-a07b-0a28dad1703b@linaro.org>
 <368273be-1685-40ab-aa91-7fd811c845d4@kaod.org>
In-Reply-To: <368273be-1685-40ab-aa91-7fd811c845d4@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|OSQPR06MB7182:EE_
x-ms-office365-filtering-correlation-id: 4619d916-95ee-4b9e-00d8-08deb6d7e07f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003|4143699003|6133799003;
x-microsoft-antispam-message-info: LczZ3L3ZY9IeriDnCZA/+adeIcVkh8eJUUYU+swwlUq1uW/t/Mt/RW2e2EgCcjtV8utKRi6YJjGNVvaC/07RPdS9JLLSbI0fMXkN++qTNKuReHpILCuJxg35st+OHPq4fyeKQa8A3g35sxWyZZO4S17a8qGRVnW/bQ/Szy+kPN9fUY2DhHoP1M1/MlkVmgzKehRtfvJRLQrXhtIIV9t2VU/ZfGadmUXwVIJHzLjeQsyDTN+aZ8O3+ZY6AWHO9I5z+atFyT0/CfZ+QSJX1HkecFeBsCs2yuKUEc1aPN8EPhEYL5uUiqFmTxdHJuZVcGpnxIQxLvut2VjNHc8Mi9KqdvBee1LVhxpMhRRW6u0MnZYhegOg9C+O3fZI3wvmLJoXt0g8NuLw6FbaqLI9UUisuYOV/Sat4SlCVeMZ0FTvc4r1p7wBOX6M9IlWcrV/nBiP3rSmbMB9U0NNXxKMPyN9KVmYsor27bz4KW850W3CPTHaFQFfmSmiN630ju0Aniga2ekm3gEKoK4HMcxIKWUHvL7dPhrJoQ7S/yUYe6Scsgt7j2jWL+qRQqp/PPCT9B0ILEvctZkjPUlX43RU/liwSg8+CT1yTt64HiRnNXOx/R67jv4G8LLLjgqR46NH07LRlGqm09ZXKJcKcu6WFqBoBUoijftyqxVkkz3LE8qOQSg08VhWTqTTfKjpzPteJrrJRFE42dXNh1T6Xid+1c9OFCVKcn5Xfm/iX92RV+n14ev0t9YKNLaUkr+U4Xxg1lw0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003)(4143699003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXBrL0pRYWFERTJBQytEck12ZWd3SDdoM0RhSVEvUHdRcTFIS0RDeVNTekNz?=
 =?utf-8?B?ZkQ2SVdEL1BZZkpGVHArNnd2NTUwaHBIQVBtNWFZWHV4ZVdBbGxzY3ZqcFVC?=
 =?utf-8?B?bzUvL1AxKzc4NjFUazUrNnBGdkRnczZuR0hiZnhpMW1KMlVTK0pUOG9aNGNQ?=
 =?utf-8?B?cGVFK2dKOTNaVm1pcDJvamw4ZWhYc2dOQXhUclFUbEtxMlZvUStzdzhYYUlx?=
 =?utf-8?B?OG9ZemxTVFBwMnRsdUVlS1JaRGgwT2hRZWdPMlJGb0xiNWRJa1paM1VHVFdu?=
 =?utf-8?B?WWU0M044SXVqRE5kTzhsN2c4emRNSTRqNVZWeEdDTEl0dDRQK0htYWozUllD?=
 =?utf-8?B?dlNGbEhIdkh6RXNxVFp5Q21KWEp5UEEzWU9TRnN2eXRJR3QwZmlFcU1vdk5k?=
 =?utf-8?B?MlJLdDhvdlUraUhwM2JvcWttT2ljbFdwTnJwSHVmMmZhdWJCdC9CRGFGSVk4?=
 =?utf-8?B?bTBRVlhBZzZjbGxWTFJ5MmVhUWtDeWxNRDBuS1l6YTdNem9WT0RyRlQ5TDBO?=
 =?utf-8?B?ME5MZmhxY1JTRVh4WHhUTzdHaVlmQmJTT1VvOEcyaXFCaHVZU3hhdXZhUit2?=
 =?utf-8?B?NTVraGtBbW1uRSsxd3gxZGFKK2M5b3RlOERoK0lZRXV0WUpLTWtHeDNMUmJI?=
 =?utf-8?B?R1hORDY5SDV0MUQ4eHFocmdOaEdyZjhaQWM0OHRzLzNWZFZtMVVsODg5SjVL?=
 =?utf-8?B?bWVtNVVvaVRKRDNIOXVLSWxqck1hbUJZa3NSU2VITUZGQWhrZGthbHpQTTda?=
 =?utf-8?B?T1NOTFh1Qy9VWXBtMTJqdUo2SWMvOHdvYXVYQkdGa3QySE1ndS9iQzNTS3Ey?=
 =?utf-8?B?YW5Wbi9pWUx3SmZjWWRVUlo2VzRaMlJjOWt2dTJxT0FtNkY5cVRxbDU1UUxs?=
 =?utf-8?B?NTJJQXRodzNtSUFtbWNFcEpQejlac0RWdm1vYVcvb1RzMVNWMWUyMnJkUExS?=
 =?utf-8?B?Z3IvTkJyWVFvbDlCTURmaVRYenZzd2JhMlNTdkhZTkRxOG03Slc2NFBUMThJ?=
 =?utf-8?B?VWdqVS9mRHlJQU51cmFDczExcXdaQ1NwcU1zaTRSZE8vZFpYZDkwZXFEWkhU?=
 =?utf-8?B?YWNmSy9lMGg5b0xhWHB1VGhuU00zVUcrNHM5dzMvWmpBZURiVmxoaWIrUjJ5?=
 =?utf-8?B?Q2V2eU5WcUN0YnRhMlRxTHBreThzaWE3WXVKSVVuRXlVR2twczc1T1FZRUV1?=
 =?utf-8?B?dExnU2VRTWVQU2ZSeGc2bVhzWnNwdG5IVlk0MzdHekFhdHJXQTRiOVEvVlgw?=
 =?utf-8?B?WFpyeUx1RUppblcvY1VQdElScUdQRHRxOUppUnBmMWdCM0FTbFZ0N2dZKzBG?=
 =?utf-8?B?WmFoYkNmMzBFRmxrMzRIL2hFT1ZUVEMyYmsxL0F2UU1CTnJjaFNiclNiMEQ4?=
 =?utf-8?B?WGcrSnQxZlF4UUhyMExVdlEzalF4dmFGMCtyVlJoYWJFbFdKcjAvWEtDQnM3?=
 =?utf-8?B?TXVmVWZaM01VbGdPclpmYXJGM3V5TzNxQ1pQOU9jNDJqN2VhWnpOQ3M3SDdN?=
 =?utf-8?B?U00xbEM2L2k3WXMvNnVZNysyY3czV0sveUpBOUh4N0FMZjRnTW9yam85bVll?=
 =?utf-8?B?SXhITnF4bFpmNlFySS82ZUVpb0FZSGxBNXFFNkpBMEp2RE1PU3duOW9lKzFk?=
 =?utf-8?B?Ni9EQjNlRWMydWNKajN2UHRQQlRDVGFkRW8wWFdyZWFVWU1qbFVjRE5VYUZp?=
 =?utf-8?B?RDI0VDRoZmFub3p6RTQrbnpNZ3l4QW12TXlSQUlySy9PN3BVeUlWWWdpTEVV?=
 =?utf-8?B?YjZpdkloOXQ1RVpYbGp2dElSVWZVdnlSVU1VRldDektNdll3cmd2MUpEU0Jv?=
 =?utf-8?B?OEd2MjVhTU94akVCSHZydFdFZnhOVmxoZzU1aFViQzJJSDF6K09aN1l2WWlR?=
 =?utf-8?B?RGh1Wmo1cjdkQlpSNDhFUDhDSDdkdlFJZGtIb0dRODBqNHdjZW9uaDB2NkF2?=
 =?utf-8?B?eEFhOVlFNGxFRmdQYktDL3VLa21UekoxaEt2eDl0MDNacmRJbHFKWkNhWWVu?=
 =?utf-8?B?anRPUjBGbHNTY0Q0VlVRUzE3TWthdkhjMkRtYUZBNEk4M0lrcGVDT0JXS2Fy?=
 =?utf-8?B?U1JDSlJIQTJ5aDBnMEY5LzdTbFpQYVJOU2hoczkyUFNmczBUclZIMDFibnBF?=
 =?utf-8?B?bDRyTVhOdFZtOFJZcHQvalJVL0twNmxOZ3ZFTG1JY2JBMFVjeW1GNVNVUXF1?=
 =?utf-8?B?bjhxOS9iTTdGbFI3dlRuaEdPdWZVbm56b1dBMUl1b242ZUlOSVV4QTFYQ0xI?=
 =?utf-8?B?RWN4WHFUU0YzcVdEanNwc0xwWjZQTWV3N3NTWEVyaXpsRVRZMGJaTDh5WWNW?=
 =?utf-8?B?dG5HYVcwMUZseEdqRDRwcS93eUxsdWZOWTdXUGcwT29DbWlNQTNRQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4619d916-95ee-4b9e-00d8-08deb6d7e07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 01:25:43.3392 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BLXEZVlmdYVdHpcB199IJDL5sd3hBgBTHnJ6E2vjqFPKse1UzsQwkcPXDX+ZrB1J6KnYIQFLOdbPxvhN+tyiXuClo//aIdxv6XhnE2sqFbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7182
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDIxLCAyMDI2IDEyOjQ0IEFNDQo+
IFRvOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+OyBDw6lkcmlj
IExlIEdvYXRlcg0KPiA8Y2xnQHJlZGhhdC5jb20+OyBxZW11LWFybUBub25nbnUub3JnOyBxZW11
LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IEthbmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRlY2gu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BVTEwgMjYvNDVdIGh3L21pc2M6IEFkZCBiYXNpYyBBc3Bl
ZWQgUFdNIG1vZGVsDQo+IA0KPiBPbiA1LzIwLzI2IDE4OjMxLCBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSB3cm90ZToNCj4gPiBIaSBLYW5lLA0KPiA+DQo+ID4gT24gNC8yLzI2IDExOjMxLCBDw6lk
cmljIExlIEdvYXRlciB3cm90ZToNCj4gPj4gRnJvbTogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNw
ZWVkdGVjaC5jb20+DQo+ID4+DQo+ID4+IEFkZCBhbiBpbml0aWFsIFBXTSBtb2RlbCBmb3IgQXNw
ZWVkIFNvQ3MsIGluY2x1ZGluZyBkZXZpY2Ugc3RhdGUsDQo+ID4+IHJlZ2lzdGVyIGRlZmluaXRp
b25zLCBhbmQgYmFzaWMgaW5pdGlhbGl6YXRpb24gYXMgYSBzeXNidXMgZGV2aWNlLg0KPiA+Pg0K
PiA+PiBTaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiA+
PiBTaWduZWQtb2ZmLWJ5OiBLYW5lLUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4N
Cj4gPj4gTGluazoNCj4gPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2
MDIwNDA4MjExMy4zOTU1NDA3LTQta2FuZV9jaGVuDQo+ID4+IEBhc3BlZWR0ZWNoLmNvbQ0KPiA+
PiBTaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+ID4+
IC0tLQ0KPiA+PiDCoCBpbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmjCoCB8wqDCoCAzICstDQo+
ID4+IMKgIGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfcHdtLmggfMKgIDMwICsrKysrKysrKw0KPiA+
PiDCoCBody9taXNjL2FzcGVlZF9wd20uY8KgwqDCoMKgwqDCoMKgwqAgfCAxMjANCj4gPj4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPj4gwqAgaHcvbWlzYy9tZXNvbi5i
dWlsZMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsNCj4gPj4gwqAgaHcvbWlzYy90cmFjZS1l
dmVudHPCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDQgKysNCj4gPj4gwqAgNSBmaWxlcyBjaGFuZ2Vk
LCAxNTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+PiDCoCBjcmVhdGUgbW9kZSAx
MDA2NDQgaW5jbHVkZS9ody9taXNjL2FzcGVlZF9wd20uaA0KPiA+PiDCoCBjcmVhdGUgbW9kZSAx
MDA2NDQgaHcvbWlzYy9hc3BlZWRfcHdtLmMNCj4gPg0KPiA+DQo+ID4+IGRpZmYgLS1naXQgYS9o
dy9taXNjL2FzcGVlZF9wd20uYyBiL2h3L21pc2MvYXNwZWVkX3B3bS5jDQo+ID4NCj4gPg0KPiA+
PiArc3RhdGljIHZvaWQgYXNwZWVkX3B3bV9jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywg
Y29uc3Qgdm9pZA0KPiA+PiArKmRhdGEpIHsNCj4gPj4gK8KgwqDCoCBEZXZpY2VDbGFzcyAqZGMg
PSBERVZJQ0VfQ0xBU1Moa2xhc3MpOw0KPiA+PiArDQo+ID4+ICvCoMKgwqAgZGMtPnJlYWxpemUg
PSBhc3BlZWRfcHdtX3JlYWxpemU7DQo+ID4+ICvCoMKgwqAgZGV2aWNlX2NsYXNzX3NldF9sZWdh
Y3lfcmVzZXQoZGMsIGFzcGVlZF9wd21fcmVzZXQpOw0KPiA+DQo+ID4gQWxzbyBwbGVhc2UgZG8g
bm90IHVzZSB0aGUgbGVnYWN5IEFQSS4gU2VlIGZvciBleGFtcGxlIHRoaXMgY29tbWl0IHRvDQo+
ID4gY29udmVydCB0byB0aGUgbmV3ZXIgQVBJOg0KPiA+IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11
LXByb2plY3QvcWVtdS8tL2NvbW1pdC9jZTc4OGQzNzQwZg0KPiANCj4gT2ggISBJIHRoaW5rIHRo
aXMgcGF0Y2ggaXMgZnJvbSAyMDE3IGFuZCB3ZSBkaWRuJ3QgcmVmcmVzaCBpdCB3aGVuIGl0IHdh
cyBzZW50IDovDQo+IA0KPiBTbywgeWVzLCBLYW5lLCBpZiB5b3UgaGF2ZSB0aW1lIGZvciB0aGlz
IFFFTVUgY3ljbGUsIHRoYXQgd291bGQgYmUgbmljZS4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMu
DQpIaSBQaGlsaXBwZSwNCg0KVGhhbmtzIGZvciBwb2ludGluZyB0aGlzIG91dC4NCg0KSGkgQ8Op
ZHJpYywNCg0KSSBjdXJyZW50bHkgaGF2ZSBhIGZldyB0YXNrcyBvbiBoYW5kLiBPbmNlIEkgZmlu
aXNoIHRoZW0sIEkgd2lsbCBzdWJtaXQgYSBjb2RlIGNoYW5nZQ0KdG8gdXNlIHRoZSBuZXcgQVBJ
Lg0KDQpCZXN0IFJlZ2FyZHMsDQpLYW5lDQo+IA0KPiANCj4gDQo+ID4NCj4gPj4gK8KgwqDCoCBk
Yy0+ZGVzYyA9ICJBc3BlZWQgUFdNIENvbnRyb2xsZXIiOw0KPiA+PiArwqDCoMKgIGRjLT52bXNk
ID0gJnZtc3RhdGVfYXNwZWVkX3B3bTsNCj4gPj4gK30NCj4gPg0KDQo=

