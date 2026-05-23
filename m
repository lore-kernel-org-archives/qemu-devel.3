Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4A4CD5BB1
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 19:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQrsv-0005qy-Nd; Sat, 23 May 2026 15:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wQrsu-0005qW-2u
 for qemu-devel@nongnu.org; Sat, 23 May 2026 15:19:44 -0400
Received: from mail-northeuropeazon11011024.outbound.protection.outlook.com
 ([52.101.65.24] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wQrsr-00082M-Vm
 for qemu-devel@nongnu.org; Sat, 23 May 2026 15:19:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDrwLoLucPIA0k5BkOcD5wI2ZLzIeG5R6caGU0Ozolx2lNsFojwkx/kiWFqqWCuesegYv7JVVuUJKO6Q78iWyi9/+49TGTgam35Jf13hIQJWfMdFSwpORHFkHHNLg3RFQetVKM8gNCzcfORZQ+9uLk/XFu+UX4OnvNEZ9Aje5EN2kn3wY4gSp7e0A/OLuYDmleKNJc5gAQS6x0cpl/gfnzTCDrWltGQf+ayYRmaUVAF8cMLToCXATllVSbExMxXyS9HU7CisXuTCBsLfGdJEHyfyrmbzOpePathi7OHmgBDZGLJukSulV0yhOQ9bkTOc9SK5BsC6qU05bx35e4YRhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cXlvkGKum2FDaTgyXDttjm8YaXIs5zXyt5rQ2Am3Hg=;
 b=fTJPxVipyYafT2hvf17EAbxyUwLbtosT37cpQLz4POaIJ88NCk+a6ZWZrufdNZU0XxRfWBYbm5K2JrS4HsxDsp0VcCjKe9Hw7breEF7TmnX3q1iA6QCEtCzJaDMMv//rlVdDEtxheWTuhU5rMIj2EWboVwTlyCeMa0xVuboo4RGSfWS5lyDdOXGC+fQJGMfSw/ISDIRo+Nl4reNXitMfskP39YaxTFnVBLRnnNCN1iYNz+Lik8eiCo1GbsfwuM6su/Twx0sGudyU09hvEU7vp6fhj1N6eITYQaOiOfkwmUcn5qk4xEtYvSNlaQf8tcHC0xWglc4dhrlPrQWqln9VBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cXlvkGKum2FDaTgyXDttjm8YaXIs5zXyt5rQ2Am3Hg=;
 b=G4vugAnLHSTEbCMMeWaXyiAeOswZovVwLnLeyXAKc6wdJ3AxAANGEYiksPmaOY9ojsBUHbokk9NCoZyGt3aBtIQh0KHeJAmSvIlwrTv5Sxqa0Y52PNDnpMEpaEX+RHY326jpmzad9GvQxenWpKD9tYp9qdc4xxLt9Q1mr2YhosKoP+FkDkECFGVWkEy6lbAQUuwccQePlTkoPUfXaK6X8C5+ii9kxnYIZdvq4DLobEQj7Uj8wR+USukLCsygAN/02umTzBY/CFIvRCZzaVWec7erqgGN+WISG7QVQ6zDb7WVwQi+J7fbadFQumGzgKYIjs58o0RiN2FNzBspUVf01w==
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com (2603:10a6:208:6e::32)
 by GV1PR04MB11038.eurprd04.prod.outlook.com (2603:10a6:150:211::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 19:14:34 +0000
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b]) by AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b%6]) with mapi id 15.21.0048.013; Sat, 23 May 2026
 19:14:33 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "shentey@gmail.com" <shentey@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Alistair Francis
 <alistair.francis@wdc.com>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>
Subject: RE: [EXT] Re: [PATCHv1 6/7] hw/arm: Enable Cortex-M7 AMP boot on
 i.MX8MP
Thread-Topic: [EXT] Re: [PATCHv1 6/7] hw/arm: Enable Cortex-M7 AMP boot on
 i.MX8MP
Thread-Index: AQHc57jbaEcYVpBeuUeHqK00YGqtBrYV4jkAgAAAlACABhuLQA==
Date: Sat, 23 May 2026 19:14:33 +0000
Message-ID: <AM0PR04MB4370F4FD3CBBF074F41FD12C870C2@AM0PR04MB4370.eurprd04.prod.outlook.com>
References: <20260519175635.3245229-1-gaurav.sharma_7@nxp.com>
 <20260519175635.3245229-7-gaurav.sharma_7@nxp.com>
 <28c31997-b4db-436c-bff7-12ead07254fd@linaro.org>
 <2aaa4dfc-cf5d-4381-9c77-d78679819ba7@linaro.org>
In-Reply-To: <2aaa4dfc-cf5d-4381-9c77-d78679819ba7@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4370:EE_|GV1PR04MB11038:EE_
x-ms-office365-filtering-correlation-id: 609deabf-0263-4208-a2a0-08deb8ff8616
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|19092799006|366016|38070700021|22082099003|56012099003|18002099003|11063799006|6133799003|4143699003;
x-microsoft-antispam-message-info: zvPxhtTy7KtaOvV4z5OEo5V9t/2yeqbCZHIaM07h/oUBKPobH7WstRldlKLZwG+5wmkCbPtaND4FwGInNRiTfBJYK8uwADdp0dlnvjRmfLx2HDG+D725nHwJvwoBWVTw8DkENkrxxUAkakKHEmdfsmJfpo0eiU/bpKv50zBCX1sJS7wEkKGwDW6ocNAnfUG80H34U6pcmr8Ni8/9rXHqW2+17ni/RWDzBX+CFTk78xxK4NXlg4TsUkz4Ndb5zc3SGzKnQW0JBUIc3cA3ALqCFTkufKosuhBxWWzwf1lJK8JyHdORX2wVRvm2TKviAAuL0A0nGLa2rnFYF3bg0jKA0c5441lCmtO0yeT9BQCdX412k3B4UrV63WnMacqTRPozL0mZn3dM2yRd6xA9BPHEKTkEWlBsFbLqYJCaCYD3U4DA48YtUTkZ02lEY+bGzFH2kgwDMwp80GnroqqtOkQsfh7RXpxSiWJSQdSZFU3AoTFcvrWd9gfFEIIVexWKvjX2z4OjmiQQSTeAa4RfVD3O/iEhEXrvVXfJKPIIT6EtX17M1HN0xLptikOTwHi740oqB4IS3/TMgPp+L6pLlZ13k5+Zn8fT3cYk8BOHJhZ7MRf8WIU94BCfJrJWFnmciIbdD95/h9QKd+/B20LTKkmGVHl0CV80FAPqKYCDa0aTPY513HVNsnPsE39+fTVeUPzGuJRNPvB7t3Z6scQhEQggaNmZiu/oQOMJCruQ96AabmlGTmgCx9rWd7gw31ucVkNa
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4370.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(38070700021)(22082099003)(56012099003)(18002099003)(11063799006)(6133799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkJHbUV5T1VhN0VBdHArSEVWNVFQZ1FHRWVRVzRBL3ltQ0k0S2Znb2VYZUFq?=
 =?utf-8?B?amlMMVlhbmNMRkVkdERUMUZ4SDRQdEtvTFBvNjAzalcyck9jS0kzQXdHZkRm?=
 =?utf-8?B?RG5FcHFJditMdTVCcXUvR1loVzBieDkwUzVTU1RHa3lkcUlRUnZUNFVxbFFk?=
 =?utf-8?B?RHpSYUdqbmYxU09LbHdadDkyZ2tzd1E1eHF2WHdqOTlhMUxjaURxZ0VubEE4?=
 =?utf-8?B?MXhIQVprZy9UcUJzbDBEOUErdCtrcVA2MDdrTXVSQy9PdVNuVnQxN2NGTUZO?=
 =?utf-8?B?Zk5QL3R0T3pWU3VRR0F1Z2lYTjRPTnBaVmhLd1lHRHlxSElObStpbnMyWGc3?=
 =?utf-8?B?V0Z3dkZEVFV3NW96eldlbHdnSWtPQ2JmVFpubndMTDJ0K1V4TGFnK0puVHFI?=
 =?utf-8?B?R3pUUXIwMHlHTE9zcTM5VzkwMC9XbGk1UXJFUkdiUksrUXMrR29IaDdOWXBj?=
 =?utf-8?B?clJjMWtuU0F2dVZxOGY2ejR5SUZIRGt2MUlEMGh3SXZua1Z5dEQ2cjNjdlZo?=
 =?utf-8?B?cTc3SGJNT0Vzcll2RktvaXcvWU90M1FLd0JNcjJKVkJyUEVHY1g0Tjd3UE1l?=
 =?utf-8?B?dkJCd0NyL0ZpbDY3dFdlczdNMEd3TCtueU9XRUJ0bGdqSUMwMTZMTnA2aUd3?=
 =?utf-8?B?TnVqUytxRUpzclAwbHpZYTFobjA2N2lVMGtDZjBMajZYNU1wZC8rSkdBSVZr?=
 =?utf-8?B?M252T2tlOURuaFBCMVpNQ1ljNW8xR0V5N3ZvY0pDaVp3Y3dUTU9wTjU0bHdM?=
 =?utf-8?B?TGMvbDkwYzhkeUg5d3p0TzZSQ0dtaVQzWXM2dE83aVdVOUpxUExZY2dUVU80?=
 =?utf-8?B?aGd0YlRCQy9KR3U5THhUeWpCNWlPWDB3VkdMMEFOQ1VmMjNvdW1LWFJPVzdT?=
 =?utf-8?B?TXVvczFFaWV3WFFFUW9kMzBrMW02WmI2WEJtcTFvalNNTENHYkZjMTd1Tm9L?=
 =?utf-8?B?UlNzK1dtaGFkQ3lOTUs5Nng1WUlCTWxxa2ZmRVF4cHB3cXRXQ0Jxb2lkMURY?=
 =?utf-8?B?ZWpKTVgySzVrYllTam02UCtMc0ZwaURqbzB4dkR4aG94b2tsSFNoWGFaNWtj?=
 =?utf-8?B?dUh4WkxFRjNSL0NYYjhMc09wdXIyVGQwbStvdHpyVWIveDUyUzB3SFVyZUE3?=
 =?utf-8?B?RHcrMUFmZDR3cjBZUjFnVzNyUEtDa1UvbWloU3RxU1FzT3pJbnZvbVY1TDFt?=
 =?utf-8?B?UWxQemM1U2pGY0JOVXpLN29uZUJqTEpLcnNITHR4KzE5L0k3R1FKamNLL1Bh?=
 =?utf-8?B?cmJybUsyUWx6Y2JsR1BWeG9aZC9hd1paR2ptaFVJRUEyd2VWdW5mc3NWMlFI?=
 =?utf-8?B?bFd4TkpiU2d6ZTlTNGt0dFQxaVZ1WG5sekkwWEM1YlYvZ0NGT3NvaE1WYnZX?=
 =?utf-8?B?VTZHaE54YWxTc1J2UEZWN25qQVVlSlo1bmtoSmIyT2NGWE9ZRVhiRm5PSlM1?=
 =?utf-8?B?U1V0dWlxUUY5TnJ2c3ZGazZ0V2xpY2VzUWtBVGdJaWdHamVITDcxcUQ1b0RJ?=
 =?utf-8?B?WmpNYUZCcktGNjh0R3lpWElUVHZ1WXFCdisrUnowTzZPY0ZlWncwOG1zZjc4?=
 =?utf-8?B?V3dVNDkzWk1DWXNYMEJ1ZFFLemhmWTdhb3pWcER0eHhhRU5xaWtNV1Y5cjlq?=
 =?utf-8?B?MTJSOXRWTXhiU0ZuMjV6bDlMTGZ1VjYxWnVJakVJTnNVakI2RVlKQmpGNWxz?=
 =?utf-8?B?aTJtSER0YVdqK0tUamZ6YUJPMjIyd0RQZm1FVzJid2VFNW5sOE9uZlVUOU9v?=
 =?utf-8?B?b3B1dXpoY3dCd25ScWQ3enRUbGFKNElFNFhXYTh0TGFMSTlIZE1KN1QxNWQ3?=
 =?utf-8?B?UDBFaVQrU2o1Y1hzdFJ0OUpZQ0hYV0VaUGZYYXp3SU1yc3EwYXZtMnZ2SWgw?=
 =?utf-8?B?SW16dTJ6R0hHR1EzeUlqQ1Vsenk4Q05acG1nbHV5Rk9ZN3Bya1pUeGZIYzJ6?=
 =?utf-8?B?aEF2a1FsbGZBSUZ4OVIrRVhPcVIxbjY5MDE2R1lOZy9LQ3JwdlVFeEZ4KzBL?=
 =?utf-8?B?YVMzK2p4ZWhFMjlRSWo3WXROY0RRMHRtUExMUS92c200dUdMODRZdDcrbjFx?=
 =?utf-8?B?OG9qaW90d0pFb250ZGVPQm03RkpKcnRxOEN5bUNkaVVRWnNjZWFzU3lWQklm?=
 =?utf-8?B?NjZKQnNGSTcwemJvUm8xbGhrdkNBQ21GUW1PNlBlSUhoWDNZZys0MUdRVWJH?=
 =?utf-8?B?SUx6a21sMHNaYnFNK2JTMHRLMFBaK09QL09uUStpaWJYOWhXZVVUdmUvSE5S?=
 =?utf-8?B?QzVHMVZ5dUxQZFFWRi85dGJsMzRNdmg2YktNRktsQWxjU3dzNEdySjhCZzNM?=
 =?utf-8?B?TzdSYWUwSnRUZEpFRlY3cUFNZk9tV3FONXJTSHZ4MzRWZ0t5em1hUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4370.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609deabf-0263-4208-a2a0-08deb8ff8616
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2026 19:14:33.8920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7XI9ElTGqiJrf9gQOrlPN3HT5IQl5utEfB1mU+oJ6oF1BwJNYnEithSffTcWjA7C7+mxYhp7mjgU3y/1n7rN4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11038
Received-SPF: pass client-ip=52.101.65.24;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMCBNYXkgMjAyNiAwMzoxOA0K
PiBUbzogR2F1cmF2IFNoYXJtYSA8Z2F1cmF2LnNoYXJtYV83QG54cC5jb20+OyBxZW11LWRldmVs
QG5vbmdudS5vcmcNCj4gQ2M6IHBib256aW5pQHJlZGhhdC5jb207IHBldGVyLm1heWRlbGxAbGlu
YXJvLm9yZzsgc2hlbnRleUBnbWFpbC5jb207DQo+IFpoYW8gTGl1IDx6aGFvMS5saXVAaW50ZWwu
Y29tPjsgUGllcnJpY2sgQm91dmllcg0KPiA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0u
Y29tPjsgTWFya3VzIEFybWJydXN0ZXINCj4gPGFybWJydUByZWRoYXQuY29tPjsgQWxpc3RhaXIg
RnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPjsgRGFuaWVsDQo+IEhlbnJpcXVlIEJh
cmJvemEgPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+DQo+IFN1YmplY3Q6IFtFWFRd
IFJlOiBbUEFUQ0h2MSA2LzddIGh3L2FybTogRW5hYmxlIENvcnRleC1NNyBBTVAgYm9vdCBvbg0K
PiBpLk1YOE1QDQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVh
c2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50
cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0DQo+
IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+IE9uIDE5LzUvMjYgMjM6NDUsIFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiA+IEhpIEdhdXJhdiwNCj4gPg0KPiA+IE9uIDE5LzUv
MjYgMTk6NTYsIEdhdXJhdiBTaGFybWEgd3JvdGU6DQo+ID4+IENvbmZpZ3VyZSB0aGUgaS5NWDhN
UCB0byBib290IHRoZSBDb3J0ZXgtTTcgY29yZSBhbG9uZ3NpZGUgdGhlDQo+ID4+IENvcnRleC1B
NTMgY29yZXMgaW4gYW4gQXN5bW1ldHJpYyBNdWx0aXByb2Nlc3NpbmcgKEFNUCkNCj4gPj4gY29u
ZmlndXJhdGlvbi4gVGhlIE03IGZpcm13YXJlIGNhbiBiZSBsb2FkZWQgYW5kIHN0YXJ0ZWQgZnJv
bSBMaW51eA0KPiA+PiBydW5uaW5nIG9uIHRoZSBBNTMgY29yZXMgdmlhIHRoZSByZW1vdGVwcm9j
IGZyYW1ld29yay4NCj4gPj4NCj4gPj4gQ003IGJvb3QgaXMgbWFkZSBvcHRpb25hbC4gQSBHUFIg
SVJRIGlzIGNvbm5lY3RlZCB0byBhIGNwdXdhaXQgaGFuZGxlci4NCj4gPj4gVGhlIGhhbmRsZXIg
dHJhbnNsYXRlcyB0aGUgQ1BVV0FJVCBpbnRvIFNUT1AgYW5kIFJVTi5JdCBmb2xsb3dzIHRoZQ0K
PiA+PiBjbGFzc2ljIENvcnRleC1NIGJvb3Qgc2VxdWVuY2U6IGluaXRpYWwgU1AgYW5kIHJlc2V0
IHZlY3RvciB0YWtlbg0KPiA+PiBmcm9tIHRoZSB2ZWN0b3IgdGFibGUuDQo+ID4+DQo+ID4+IFNp
Z25lZC1vZmYtYnk6IEdhdXJhdiBTaGFybWEgPGdhdXJhdi5zaGFybWFfN0BueHAuY29tPg0KPiA+
PiAtLS0NCj4gPj4gICBkb2NzL3N5c3RlbS9hcm0vaW14OG0ucnN0ICAgfMKgIDg2ICsrKysrKysr
KysrKysrKysrKysrKy0NCj4gPj4gICBody9hcm0vZnNsLWlteDhtcC5jICAgICAgICAgfCAxNDMN
Cj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+ICAgaW5jbHVkZS9o
dy9hcm0vZnNsLWlteDhtcC5oIHzCoCAxMyArKystDQo+ID4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAy
NDAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+DQo+ID4+IEBAIC03Miw3
ICsxNTUsOCBAQCBGb3IgaS5NWCA4TSBQbHVzIEVWSzoNCj4gPj4gICAuLiBjb2RlLWJsb2NrOjog
YmFzaA0KPiA+PiAgICAgJCBxZW11LXN5c3RlbS1hYXJjaDY0IC1NIGlteDhtcC1ldmsgXA0KPiA+
PiAtICAgICAgLWRpc3BsYXkgbm9uZSAtc2VyaWFsIG51bGwgLXNlcmlhbCBzdGRpbyBcDQo+ID4+
ICsgICAgICAtZGlzcGxheSBub25lIC1zZXJpYWwgbnVsbCAtc2VyaWFsIHN0ZGlvIC1zZXJpYWwg
bnVsbCAtc2VyaWFsDQo+ID4+ICsgLw0KPiA+PiB0bXAvaW14OG1wLXVhcnQ0IFwNCj4gPj4gKyAg
ICAgIC1zbXAgNCxtYXhjcHVzPTUgLWdsb2JhbCBmc2wtaW14OG1wLmVuYWJsZS1jbTc9b24gXA0K
PiA+DQo+ID4gTm90IGEgYmxvY2tlcjsgSSB3b25kZXIgaWYgdGhpcyBpcyBhIGdvb2QgdXNlIG9m
IHRoZSAtc21wL21heGNwdXMNCj4gPiAodGhpbmtpbmcgYWJvdXQgbG9uZyB0ZXJtIEFNUCBtb2Rl
bGxpbmcpLg0KPiA+DQo+ID4gTWF5YmUgd2UgY291bGQgdXNlIGEgbWFjaGluZSBwcm9wZXJ0eSBm
b3IgdGhlIE0gY29yZSwgYW5kIGtlZXAgdGhlIHNtcA0KPiA+IGRlZmF1bHQgdmFsdWUgdG8gdGhl
IEEgY29yZSBjbHVzdGVyOg0KPiA+DQo+ID4gICAgLU0gaW14OG1wLWV2ayxlbmFibGVfY203PW9u
IC1zbXAgNA0KPiANCj4gSSBtaXNzZWQgeW91IGFscmVhZHkgYWRkIGEgbWFjaGluZSAnZW5hYmxl
LWNtNycgcHJvcGVydHkgaW4gdGhpcyB2ZXJ5IHNhbWUNCj4gcGF0Y2ggOikNCj4gDQo+ICAgc3Rh
dGljIGNvbnN0IFByb3BlcnR5IGZzbF9pbXg4bXBfcHJvcGVydGllc1tdID0gew0KPiAgICAgICBE
RUZJTkVfUFJPUF9VSU5UMzIoImZlYzEtcGh5LW51bSIsIEZzbElteDhtcFN0YXRlLCBwaHlfbnVt
LCAwKSwNCj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgiZmVjMS1waHktY29ubmVjdGVkIiwgRnNs
SW14OG1wU3RhdGUsDQo+IHBoeV9jb25uZWN0ZWQsIHRydWUpLA0KPiArICAgIERFRklORV9QUk9Q
X0JPT0woImVuYWJsZS1jbTciLCBGc2xJbXg4bXBTdGF0ZSwgZW5hYmxlX2NtNywgZmFsc2UpLA0K
PiArICAgIERFRklORV9QUk9QX1VJTlQzMigiY203LXZlY3Rvci1iYXNlIiwgRnNsSW14OG1wU3Rh
dGUsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNtN192ZWN0b3JfYmFzZSwgMHg4MDAwMDAw
MCksDQo+ICAgfTsNCj4gDQo+ID4NCj4gPiBCdXQgSU1ITyBldmVuIGJldHRlciBpcyB0byBhbHdh
eXMgY3JlYXRlIGFsbCBjb3JlcyBsaWtlIG9uIHJlYWwNCj4gPiBoYXJkd2FyZS4gSWYgdGhlIE03
IGlzIG5vdCB1c2VkIGl0IGlzIGp1c3Qgc2l0dGluZyBoZXJlLCBjcmVhdGVkIGFuZA0KPiA+IGhh
bHRlZCwgbm90IGRpc3R1cmJpbmcgYW55dGhpbmcuIFBlcnNvbmFsbHkgSSdkIHJhdGhlciBub3Qg
YWNjZXB0aW5nDQo+ID4gYW55IC1zbXAgb3B0aW9uIGZvciBzdWNoIG1hY2hpbmUsIGp1c3QgcmVw
b3J0aW5nIGFuIGVycm9yIGlmIHVzZWQgIkNhbg0KPiA+IG5vdCByZXN0cmljdCB0aGlzIG1hY2hp
bmUsIGl0IGlzIGFsd2F5cyBjcmVhdGVkIHdpdGggNCBDb3J0ZXggQSBhbmQgMQ0KPiA+IENvcnRl
eCBNIi4NCj4gPg0KDQpIaSBQaGlsaXBwZSwNCg0KU2luY2UgdGhlIGVtdWxhdGlvbiBzaG91bGQg
YmUgYXMgY2xvc2UgdG8gdGhlIGhhcmR3YXJlIGFzIHBvc3NpYmxlLCB0aGF0IG1lYW5zIHdlIGNh
biBhbHdheXMgbGVhdmUgdGhlIE03IHJlYWxpemVkIChldmVuIGlmIGl0IGlzIG5vdCBiZWluZyB1
c2VkKS4gV291bGRuJ3QgaXQgYmUgYmV0dGVyIHRvIGF2b2lkIHBhc3NpbmcgJ3NtcCcgLCAnbWF4
Y3B1cycgb3IgZXZlbiAnZW5hYmxlLWNtNycgaW4gdGhlIGNsaSA/IFdlIGNhbiBjb25maWd1cmUg
dGhlIGRlZmF1bHRzIGluc3RlYWQuIEEgc2ltcGxlICJxZW11LXN5c3RlbS1hYXJjaDY0IC1NIGlt
eDhtcC1ldmsiIHNob3VsZCBzdWZmaWNlLg0KDQo+ID4+ICAgc3RhdGljIHZvaWQgZnNsX2lteDht
cF9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkNCj4gPj4gICB7DQo+ID4+
ICAgICAgIE1hY2hpbmVTdGF0ZSAqbXMgPSBNQUNISU5FKHFkZXZfZ2V0X21hY2hpbmUoKSk7IEBA
IC0yNzcsNg0KPiA+PiArMzY4LDIzIEBAIHN0YXRpYyB2b2lkIGZzbF9pbXg4bXBfcmVhbGl6ZShE
ZXZpY2VTdGF0ZSAqZGV2LCBFcnJvcg0KPiA+PiAqKmVycnApDQo+ID4+ICAgICAgIGNvbnN0IGNo
YXIgKmNwdV90eXBlID0gbXMtPmNwdV90eXBlID86DQo+ID4+IEFSTV9DUFVfVFlQRV9OQU1FKCJj
b3J0ZXgtYTUzIik7DQo+ID4+ICAgICAgIGludCBpOw0KPiA+PiArICAgIGlmICghcy0+ZW5hYmxl
X2NtNykgew0KPiA+PiArICAgICAgICBvYmplY3RfdW5wYXJlbnQoT0JKRUNUKCZzLT5jbTcpKTsN
Cj4gPj4gKyAgICB9IGVsc2Ugew0KPiA+PiArICAgICAgICAvKg0KPiA+PiArICAgICAgICAgKiBX
aGVuIENNNyBpcyBlbmFibGVkIHdlIG5lZWQgb25lIGFkZGl0aW9uYWwgdkNQVQ0KPiA+PiArICAg
ICAgICAgKiBzbG90LiBJZiB0aGUgdXNlciBkb2VzIG5vdCBzcGVjaWZ5IG1heGNwdXM9LA0KPiA+
PiArICAgICAgICAgKiBRRU1VIGRlZmF1bHRzIG1heGNwdXMgdG8gdGhlIGN1cnJlbnQgLXNtcCBj
b3VudC4NCj4gPj4gKyAgICAgICAgICovDQo+ID4+ICsgICAgICAgIHVuc2lnbmVkIGludCBuZWVk
ID0gbXMtPnNtcC5jcHVzICsgMTsNCj4gPj4gKyAgICAgICAgaWYgKG1zLT5zbXAubWF4X2NwdXMg
PCBuZWVkKSB7DQo+ID4+ICsgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsDQo+ID4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICJDTTcgZW5hYmxlZCByZXF1aXJlcyAtc21wICV1LG1heGNwdXM9
JXUgKG9uZQ0KPiA+PiBleHRyYSB2Q1BVIHNsb3QgZm9yIENNNykiLA0KPiA+PiArICAgICAgICAg
ICAgICAgICAgICAgICBtcy0+c21wLmNwdXMsIG5lZWQpOw0KPiA+PiArICAgICAgICAgICAgcmV0
dXJuOw0KPiA+PiArICAgICAgICB9DQo+ID4+ICsgICAgfQ0KDQo=

