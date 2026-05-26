Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1B2CD5BCF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 05:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRk81-0001af-MO; Tue, 26 May 2026 01:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRk7p-0001Xj-Ub; Tue, 26 May 2026 01:14:46 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wRk7n-0004w2-8c; Tue, 26 May 2026 01:14:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKTp6ykJVwf/UMzGbMfoROhv1tOJEuFRPfmYPidWfBsSVYHGjl49yIfrVM85YAPy6vUNSc6JMlkzdE/UAIdeNWkLYZbIuq/t6m5QtvA0v3xuOcW979lTYWWRSpnbmESQFeqlxuiFfPtO+UPcYsr/ykZCyhOTNAvHcCeMQCzgZIhjRHTyCpWxwVYpos2MHh/ZVakK/sM82VaYk51lr9NXBNb97wvyhaNFAny12p9YGFAbxxaU4N/zDRQ7iuy6DMBriO82fCXl7kdJX+4yMojkStMWSJuEJzMj61Z7u3xbmREmVvzf+an5nVVSe157SU+vtGChYm3iI1U5WjDKVtDVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1lovzQkkSM+PV26+3k98guF9qnRB5GvUQgowoB5Q8E=;
 b=SWjs+8HN7T+eFi/7D749E61MXGtUqT6Tgd/0LCPmvWkd3Y8zPbUG95z2tWwobIURSbbO09f4nGux3tx4H8FeFMK0THTbBrp5fnuynjaP5DoB0qQ8/g4zSfZ+XO7fJZ74CwkEreWJJ4tpD/y+oMIFFlcmZU9ClbG+2WEtabu64s6rp2YmKPCUK+j+GqqsX8cqPpBoxQnFcamt6pNC0OxQK9+hgbqYUsEi6mIiPr/nqWiFlUHEjnSO+ZrqAXspcId8y1j5dZrcVpf5q5veaAc/yO9ww7iauK9izI3yVq461Rke9KKBy5MKf7Cq1Sesy34loSt+oE8vpxQQ34a2stUNmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1lovzQkkSM+PV26+3k98guF9qnRB5GvUQgowoB5Q8E=;
 b=LtCxu3PmWVZpr0WfSjAFH7tCltxcO9C8iNJHM1F0Kx/X0J1E13A5eLp5NGOorGXaxIYlC1WNKfwcnILWPa69fICW7MtlLhR9uMqMQw8P6RyfwGaeCVQctxshRw9GfFIpYztBGjm+k22ni8dybkcHlebRHhwabpy+280bofqOclHwn7ELBR0WR6+GjvhvDPX83QuEVLgjotiL07Fus5viDBnHzY5+yIw9AKTBfhQbw/NWwV8obE3EQJf/79x2JOJMAq5MagBL7YHDWY1syPx/1OlJfKZXDbVSheaPx5idRwPzGcONcZPMfSqcq3VA8COF/bcKAu4J0hEbkScbDK6s8w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5482.apcprd06.prod.outlook.com (2603:1096:400:287::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 05:14:33 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 05:14:33 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Kane Chen
 <kane_chen@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Joe
 Komlodi <komlodi@google.com>, Nabih Estefan <nabihestefan@google.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 00/23] hw/aspeed: Convert Aspeed devices to use
 Resettable interface
Thread-Topic: [PATCH v1 00/23] hw/aspeed: Convert Aspeed devices to use
 Resettable interface
Thread-Index: AQHc7ADBTVFYQA+5Q0qXUei6Cq1nDbYeKeNAgAGa0YCAAAAzwA==
Date: Tue, 26 May 2026 05:14:33 +0000
Message-ID: <TYPPR06MB8206D1FF1AE00706FD371E82FC0B2@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
 <TYPPR06MB8206D1D6B283918E5FDC9172FC0A2@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <5207df68-1010-40af-a369-ac4b8a11e57c@kaod.org>
In-Reply-To: <5207df68-1010-40af-a369-ac4b8a11e57c@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5482:EE_
x-ms-office365-filtering-correlation-id: a47f6fc8-c5bb-4e0d-ce8f-08debae5ac2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|18002099003|22082099003|56012099003|38070700021|921020|4143699003;
x-microsoft-antispam-message-info: 7ckm7sbNhNWaA3Cxu5b5EQK0jJHj9AHx78ODv507EPUEplbKMd4SrnlrzVRfQ0grWjiJI7SaHWuomuaZ5rXJEmb2ope0th1EqeAUTD4Bza6+Mw+QWjXaFNzWJ8L7hM8pY2P7vojQuEW/LRmUTaLyXHPwzQhmUzv8/ZPPtOiAluzQkNYyb6edW1ivl/U2vdMb9B9/jGHQ//jNfPRnQEkFir3/0esBVXF1MYTn+qq8VUjpW0209CAPWRfCBZx9nMq6gLVjwr76MedrMVSRrFIykV6lUfp2pn/vp/S7RAHyt0CrLuu/YauCasYNJR7EUWHjdggaaBBzhHUr1NP8ZgbgPOjouiezAfk2t/pADpIrDypIY4yNk6xleqVIdC6dsL6LqU8Gzwtg+wS1yoJK5Gn6rpee8X2ds+oKGb7a4PQnhYE4PQ/W366YZZHH33d9ra4EQ+FmR8fMtuI9XHDNTCLY0vIr8cYU+SqR3nRsvrsbFQhsxubiyVwvrZyjaWWUqsEBJyrmbs4buCpMHTXjdtNBvC2xCkLB2xGrEqgiy39pjl7D8G3m0LX9EdkbyltM9AzN9w6u2D8Cwvc0RM0CVgSZY2CKG6wFXRRYVquMcz055CVml3YjzKmgS74k6EchJRybqk/fTUwdKhqzQanmpe/TsFPMRmXK6WKCaYDaTM+ZkIrkKeyWFPOQ21y+CfA406et8/LehY2eWgluJjxvYJKYnTYS8BcWkucQVjRfsrkbeFuA00rbQID/8JGbccAt1wEKMuEFUgaDRlr5iUT8yuj7YQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(18002099003)(22082099003)(56012099003)(38070700021)(921020)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2d0Y3E1Q1V2eXducVIvMVlrazZUYmdVZHpFOHYxeVZ1cldKTkV2U25mV21O?=
 =?utf-8?B?VFhWbVNHbFp5cTNaTitPSUxteDVIdFFkQ2cycGZlZVVFckY1d01adjRHbUtV?=
 =?utf-8?B?bkM3YXFwRHQrS2dsMENpdUxWb1EyTUZ4ZldjbFl4ZnVGbFFGTU9xcEdUYjRm?=
 =?utf-8?B?MzB0K2tsS1BsSTVnMWNDV3ZoUEVWRGlzY1pUYU0wb2Z2RHJDZlp4SkUwMFlh?=
 =?utf-8?B?VTArek9uQjJXNlN4OEtVVC9WeUtZS2lvNkFYUHRkc2EvMDZBN2EyVVpHK0pK?=
 =?utf-8?B?REFQZW1XK2c2amdDWVN4bmRKaEx4ck5ZMkk5amJON0Z4WFFwUEFjWHIyVHZ5?=
 =?utf-8?B?enluVTBOMDJ6SW41bm5neWZ0M3JDMWFuZFhua2kxdUlNc1FpWTFYcFNOQnJV?=
 =?utf-8?B?NjdVblFsdnlMbWxmRHpjd2dQRUtxZG1KY3NlL2hVUTBDTm4yODRNV1liZlFx?=
 =?utf-8?B?Y3NiR29iR3BiTnF6cHhDSGdkMTlVbi9uZmk1c084VmpENXRlNHFXRDlSdXYx?=
 =?utf-8?B?NEdEU2ltaytEMUVBRzcraVdTdHFlMHpwSE1FdVZMdXRaa2dmRVlHL1JkdkJG?=
 =?utf-8?B?Unh5RkY1SUxoUkdrZDJlcmljdG1SVTlGNi9lNnJUSHJPbjFBbnR1Q1M4L2ZE?=
 =?utf-8?B?QmNXUW1BaW5acndSeVpIOFdReTJLbGN5ZWpMZFd5WjVCMVJEdlk0MEduMUZl?=
 =?utf-8?B?aWd1NDlPektxcVYvNjhsaE9zZFNJWllUWVNXS0NGdTFJcXljZFQ4Wm9QY0Vl?=
 =?utf-8?B?RWYxMXpxelovNHlwMFI1dHRhY1lRRFI2ajNtQ1ZwbWhMeDZjVk1QVVZaM3NN?=
 =?utf-8?B?ckpIRFA0OHpwanFEc1hyM2VwclNyUE5MUldiYjlObkxyT3lkb1pjODg5QkNI?=
 =?utf-8?B?dmEwaWt2cWh3bFNtaWMydVVudFBlWDlaZW9LR2ZCZ21kV0dWeUh5VFkybnUx?=
 =?utf-8?B?OW0wUTVqYlBRVWM3S2x4WUpreW1BSXQ2REpWamR6SGR3TlhnQklkS1VZZTk0?=
 =?utf-8?B?UXFGa3JMS05NdUp5d2taZkFrLzc2VkFHUDU4bVhVZnZldnNZVzRPSzllMzJk?=
 =?utf-8?B?a1FyZDRDRXF4SkpaMkhMSFhFeWExNXh0MkZtZFJrM2NReHdUUzk3SVBEb1BT?=
 =?utf-8?B?dm1PdTN2NEpkOWdiMlM5MWI1cnlDelFDcTVqeFNYWWEyd3FnSUk5NzRHS0ps?=
 =?utf-8?B?Y2puOGJFZG1aR2lDeTRob2xNMk1TbzRjelpUNXhkeFV6L0FzTUFjb0h4cGg2?=
 =?utf-8?B?Q1BUbjVyZEI0azFUd3hFMEdkWlNrZExBTk5JQjNpNVVqQU5Uaitkb01DY2Rq?=
 =?utf-8?B?TDVnOWxYRlBETDlmS01mYVE3dGZUbFg3VXFrRkZmTkxRWUFYalFOdDRQeTR5?=
 =?utf-8?B?VVp5ZGd4bVN2WU9XbSthbnJQK0lKR1hVR1U4UEljRERjeVR0aEY4MjFqVTEw?=
 =?utf-8?B?eEF5bTB0SkwzVU1kZ0FRQUU1MlBPZWkydkFuOHV0TkNUQ1YwdGZwbDdrUXU3?=
 =?utf-8?B?aXlmZklNUkFqYmNqUFh3Y3Y4RVY3aVc3eW5DWmQyR2V5Mm52cklLRW5yYzhh?=
 =?utf-8?B?OWJ2TlQ3WC94VW9kOGVZVWdob1RLUHcrYmxLZUl4YjZ4aVVZZkYyQkFWRkti?=
 =?utf-8?B?c28vdDhJVFZheUtQT2N5QTQyTFVLZkxObFVVYzJSY2s0NTFnQmxXV1V0aDNL?=
 =?utf-8?B?TC9ENWZyZjBTYy9sRDVCOUNGV2drc3VZcTY5RUR2WGt6TW9UTjEzRVNQSGJJ?=
 =?utf-8?B?dXRlWldIZm9lVjhXeFdwK0pHWlFGK2pzWnZrcGIxVmVIbFl1UktGSERhUW5u?=
 =?utf-8?B?em5uWXFZaVozRnpza05hRTE1MUtiVzJSMDhHdjJRcU0rWW82NFJMaEpZalNh?=
 =?utf-8?B?am91MjBaeW1oVjRWQkg0NzVPbW15TTBrRkt2dzR0ZThraitxLzBPVk9xeDdx?=
 =?utf-8?B?VlVHOGxvOHM4L2M0MXpnVFJoU28xN2dvYWhvTVVMaC9EU2k3c3c3MnFEUjB1?=
 =?utf-8?B?T3crZWxhNzdQQnR0MWxtMDNKa05MNUJqYXQxaG5TblJ3ZUNTeDhibkNaVUZy?=
 =?utf-8?B?VTNWejNrYXJoaDFLWG9uZjNqWldpb3J2UXlCbHNHbEVod3BnTDhSbmhFWmVK?=
 =?utf-8?B?Qi9yUGZsZEdLVE5yS0VhZHRtSktBRVY2SVJPdnhvdnBLQVFsRU9RRmFkS0RY?=
 =?utf-8?B?L2pWQmpPR3hia0VPeG1nbEZ5QUZOdktPMGRsYzZ1TkY3OTJVQUNMM1E3UUs4?=
 =?utf-8?B?T2JFdTM0K0orTEkzbUROVVdJUVF3dFhKekxwZzhjdzBRR05UY1Nreisydys4?=
 =?utf-8?B?b2h6MWhibDZNWWNnNlRYdlZ4bitubldqcFpnSHNaZXpWbVZyRzAyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fWOcY/3YyTEjQDVxW9tWlPvQ775c5+sl9Q5BceMlR56hoZx7n5QmMjh/po5X/wCdvR7fsyvWGLt/lbTdNMpzCBX4vQw/dTyIj0YdPsn4jW9UQ0YjqkfKa9zvEED+JfXDzpk6CFC8eDluP40B4owZBFW6xvWTPtwE6BDg0YxtWZRp5sMLE3hTOgENzRZDLfqGNIj34cSzjZF2wWfOICHhVBMQ76URVuaZwUHbJdIY8k88IFp8Shlm3yoziVLseUf1Z606s6htY6JdZIAHZPUPcjZbS57gWsWwbRWZxAjoILaid08kR+VmJCBYGOR8lL3hEYwPcI6br28Z6dOjfAO2Sg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47f6fc8-c5bb-4e0d-ce8f-08debae5ac2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 05:14:33.1616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TjjbfXWdZQ5vKAqZrHAtE4oKN/cZqkm2UTu1nO/ZAR0++2iibpaghz7GGpRbP9qy1A/vUevET0QBkmnIy++K8xC5mxp/jHussNwp5xHm5x8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5482
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUdWVzZGF5
LCBNYXkgMjYsIDIwMjYgMToxMyBQTQ0KPiBUbzogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVk
dGVjaC5jb20+OyBLYW5lIENoZW4NCj4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVy
IE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47DQo+IFN0ZXZlbiBMZWUgPHN0ZXZl
bl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95IExlZSA8bGVldHJveUBnbWFpbC5jb20+Ow0KPiBB
bmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5
DQo+IDxqb2VsQGptcy5pZC5hdT47IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyQGFsaXN0YWly
MjMubWU+OyBOaW5hZCBQYWxzdWxlDQo+IDxuaW5hZEBsaW51eC5pYm0uY29tPjsgSm9lIEtvbWxv
ZGkgPGtvbWxvZGlAZ29vZ2xlLmNvbT47IE5hYmloIEVzdGVmYW4NCj4gPG5hYmloZXN0ZWZhbkBn
b29nbGUuY29tPjsgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT47IG9wZW4NCj4gbGlz
dDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hl
cyBDQyBoZXJlDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+IENjOiBUcm95IExlZSA8dHJv
eV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDAvMjNdIGh3
L2FzcGVlZDogQ29udmVydCBBc3BlZWQgZGV2aWNlcyB0byB1c2UNCj4gUmVzZXR0YWJsZSBpbnRl
cmZhY2UNCj4gDQo+IEphbWluLA0KPiANCj4gT24gNS8yNS8yNiAwNjo0NCwgSmFtaW4gTGluIHdy
b3RlOg0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggdjEgMDAvMjNdIGh3L2FzcGVlZDogQ29udmVydCBB
c3BlZWQgZGV2aWNlcyB0byB1c2UNCj4gPj4gUmVzZXR0YWJsZSBpbnRlcmZhY2UNCj4gPj4NCj4g
Pj4gSGksDQo+ID4+DQo+ID4+IFRoaXMgc2VyaWVzIGNvbnZlcnRzIEFzcGVlZCBkZXZpY2UgZHJp
dmVycyBmcm9tIHRoZSBsZWdhY3kgcmVzZXQNCj4gPj4gY2FsbGJhY2sgcmVnaXN0ZXJlZCB2aWEg
ZGV2aWNlX2NsYXNzX3NldF9sZWdhY3lfcmVzZXQoKSB0byB0aGUNCj4gPj4gUmVzZXR0YWJsZSBp
bnRlcmZhY2UgYnkgc2V0dGluZyByYy0+cGhhc2VzLmhvbGQgZGlyZWN0bHkuDQo+ID4+DQo+ID4+
IEJlc3QgUmVnYXJkcywNCj4gPj4gS2FuZQ0KPiA+PiAtLS0NCj4gPj4NCj4gPj4gS2FuZS1DaGVu
LUFTICgyMyk6DQo+ID4+ICAgIGh3L21pc2MvYXNwZWVkX3B3bTogY29udmVydCB0byB1c2UgUmVz
ZXR0YWJsZSBpbnRlcmZhY2UNCj4gPj4gICAgaHcvbWlzYy9hc3BlZWRfcGVjaTogY29udmVydCB0
byB1c2UgUmVzZXR0YWJsZSBpbnRlcmZhY2UNCj4gPj4gICAgaHcvbWlzYy9hc3BlZWRfaGFjZTog
Y29udmVydCB0byB1c2UgUmVzZXR0YWJsZSBpbnRlcmZhY2UNCj4gPj4gICAgaHcvbWlzYy9hc3Bl
ZWRfc2JjOiBjb252ZXJ0IHRvIHVzZSBSZXNldHRhYmxlIGludGVyZmFjZQ0KPiA+PiAgICBody9t
aXNjL2FzcGVlZF94ZG1hOiBjb252ZXJ0IHRvIHVzZSBSZXNldHRhYmxlIGludGVyZmFjZQ0KPiA+
PiAgICBody9taXNjL2FzcGVlZF9scGM6IGNvbnZlcnQgdG8gdXNlIFJlc2V0dGFibGUgaW50ZXJm
YWNlDQo+ID4+ICAgIGh3L21pc2MvYXNwZWVkX3NkbWM6IGNvbnZlcnQgdG8gdXNlIFJlc2V0dGFi
bGUgaW50ZXJmYWNlDQo+ID4+ICAgIGh3L21pc2MvYXNwZWVkX3NjdTogY29udmVydCB0byB1c2Ug
UmVzZXR0YWJsZSBpbnRlcmZhY2UNCj4gPj4gICAgaHcvbWlzYy9hc3BlZWRfbHRwaTogY29udmVy
dCB0byB1c2UgUmVzZXR0YWJsZSBpbnRlcmZhY2UNCj4gPj4gICAgaHcvcGNpLWhvc3QvYXNwZWVk
X3BjaWU6IGNvbnZlcnQgdG8gdXNlIFJlc2V0dGFibGUgaW50ZXJmYWNlDQo+ID4+ICAgIGh3L3Rp
bWVyL2FzcGVlZF90aW1lcjogY29udmVydCB0byB1c2UgUmVzZXR0YWJsZSBpbnRlcmZhY2UNCj4g
Pj4gICAgaHcvZ3Bpby9hc3BlZWRfZ3BpbzogY29udmVydCB0byB1c2UgUmVzZXR0YWJsZSBpbnRl
cmZhY2UNCj4gPj4gICAgaHcvc2QvYXNwZWVkX3NkaGNpOiBjb252ZXJ0IHRvIHVzZSBSZXNldHRh
YmxlIGludGVyZmFjZQ0KPiA+PiAgICBody9zc2kvYXNwZWVkX3NtYzogY29udmVydCB0byB1c2Ug
UmVzZXR0YWJsZSBpbnRlcmZhY2UNCj4gPj4gICAgaHcvaW50Yy9hc3BlZWRfdmljOiBjb252ZXJ0
IHRvIHVzZSBSZXNldHRhYmxlIGludGVyZmFjZQ0KPiA+PiAgICBody9pbnRjL2FzcGVlZF9pbnRj
OiBjb252ZXJ0IHRvIHVzZSBSZXNldHRhYmxlIGludGVyZmFjZQ0KPiA+PiAgICBody9pM2MvYXNw
ZWVkX2kzYzogY29udmVydCB0byB1c2UgUmVzZXR0YWJsZSBpbnRlcmZhY2UNCj4gPj4gICAgaHcv
d2F0Y2hkb2cvd2R0X2FzcGVlZDogY29udmVydCB0byB1c2UgUmVzZXR0YWJsZSBpbnRlcmZhY2UN
Cj4gPj4gICAgaHcvbmV0L2Z0Z21hYzEwMDogY29udmVydCB0byB1c2UgUmVzZXR0YWJsZSBpbnRl
cmZhY2UNCj4gPj4gICAgaHcvZnNpL2FzcGVlZF9hcGIyb3BiOiBjb252ZXJ0IHRvIHVzZSBSZXNl
dHRhYmxlIGludGVyZmFjZQ0KPiA+PiAgICBody9ydGMvYXNwZWVkX3J0YzogY29udmVydCB0byB1
c2UgUmVzZXR0YWJsZSBpbnRlcmZhY2UNCj4gPj4gICAgaHcvYWRjL2FzcGVlZF9hZGM6IGNvbnZl
cnQgdG8gdXNlIFJlc2V0dGFibGUgaW50ZXJmYWNlDQo+ID4+ICAgIGh3L2kyYy9hc3BlZWRfaTJj
OiBjb252ZXJ0IHRvIHVzZSBSZXNldHRhYmxlIGludGVyZmFjZQ0KPiA+Pg0KPiA+PiAgIGh3L2Fk
Yy9hc3BlZWRfYWRjLmMgICAgICAgfCAgNyArKysrLS0tDQo+ID4+ICAgaHcvZnNpL2FzcGVlZF9h
cGIyb3BiLmMgICB8ICA3ICsrKystLS0NCj4gPj4gICBody9ncGlvL2FzcGVlZF9ncGlvLmMgICAg
IHwgIDcgKysrKy0tLQ0KPiA+PiAgIGh3L2kyYy9hc3BlZWRfaTJjLmMgICAgICAgfCAxNCArKysr
KysrKy0tLS0tLQ0KPiA+PiAgIGh3L2kzYy9hc3BlZWRfaTNjLmMgICAgICAgfCAgNyArKysrLS0t
DQo+ID4+ICAgaHcvaW50Yy9hc3BlZWRfaW50Yy5jICAgICB8ICA3ICsrKystLS0NCj4gPj4gICBo
dy9pbnRjL2FzcGVlZF92aWMuYyAgICAgIHwgIDcgKysrKy0tLQ0KPiA+PiAgIGh3L21pc2MvYXNw
ZWVkX2hhY2UuYyAgICAgfCAgNyArKysrLS0tDQo+ID4+ICAgaHcvbWlzYy9hc3BlZWRfbHBjLmMg
ICAgICB8ICA3ICsrKystLS0NCj4gPj4gICBody9taXNjL2FzcGVlZF9sdHBpLmMgICAgIHwgIDcg
KysrKy0tLQ0KPiA+PiAgIGh3L21pc2MvYXNwZWVkX3BlY2kuYyAgICAgfCAgNyArKysrLS0tDQo+
ID4+ICAgaHcvbWlzYy9hc3BlZWRfcHdtLmMgICAgICB8ICA3ICsrKystLS0NCj4gPj4gICBody9t
aXNjL2FzcGVlZF9zYmMuYyAgICAgIHwgIDcgKysrKy0tLQ0KPiA+PiAgIGh3L21pc2MvYXNwZWVk
X3NjdS5jICAgICAgfCAzOQ0KPiArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPj4gICBody9taXNjL2FzcGVlZF9zZG1jLmMgICAgIHwgMTQgKysrKysrKystLS0tLS0N
Cj4gPj4gICBody9taXNjL2FzcGVlZF94ZG1hLmMgICAgIHwgIDcgKysrKy0tLQ0KPiA+PiAgIGh3
L25ldC9mdGdtYWMxMDAuYyAgICAgICAgfCAxNCArKysrKysrKy0tLS0tLQ0KPiA+PiAgIGh3L3Bj
aS1ob3N0L2FzcGVlZF9wY2llLmMgfCAyMSArKysrKysrKysrKystLS0tLS0tLS0NCj4gPj4gICBo
dy9ydGMvYXNwZWVkX3J0Yy5jICAgICAgIHwgIDcgKysrKy0tLQ0KPiA+PiAgIGh3L3NkL2FzcGVl
ZF9zZGhjaS5jICAgICAgfCAgNyArKysrLS0tDQo+ID4+ICAgaHcvc3NpL2FzcGVlZF9zbWMuYyAg
ICAgICB8ICA3ICsrKystLS0NCj4gPj4gICBody90aW1lci9hc3BlZWRfdGltZXIuYyAgIHwgIDcg
KysrKy0tLQ0KPiA+PiAgIGh3L3dhdGNoZG9nL3dkdF9hc3BlZWQuYyAgfCAgNyArKysrLS0tDQo+
ID4+ICAgMjMgZmlsZXMgY2hhbmdlZCwgMTMwIGluc2VydGlvbnMoKyksIDk4IGRlbGV0aW9ucygt
KQ0KPiA+Pg0KPiA+PiAtLQ0KPiA+PiAyLjQzLjANCj4gPg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVz
DQo+ID4NCj4gPiBSZXZpZXdlZC1ieSBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNv
bT4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBKYW1pbg0KPiANCj4gDQo+IFRoaXMgZW1haWwgZGlk
IG5vdCByZWFjaCB0aGUgbWFpbGluZyBsaXN0IGZvciBzb21lIHJlYXNvbi4gQ291bGQgeW91IHJl
c2VuZA0KPiBwbGVhc2UgPw0KPiANCg0KUmV2aWV3ZWQtYnkgSmFtaW4gTGluIDxqYW1pbl9saW5A
YXNwZWVkdGVjaC5jb20+DQoNClRoYW5rcywNCkphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4gQy4N
Cg==

