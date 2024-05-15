Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58352C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qa-0004bi-MD; Wed, 15 May 2024 03:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qI-0004XM-Ml
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:26 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qF-0000oJ-Aw
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757263; x=1747293263;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=9U8NReqWpaS6WMzQ4uEVQ6iKKTM2a3k2YHd6FNepzus=;
 b=m83wxokB+oYxatC3Pe8+yY0n1ir7T9vCvodtvzHtnkZVn6shQScp3PZd
 X/Zcm+itJcV0WD9BETMxfo9EVWAODoFxDTZfkINyoVuAE6YeWiNk+VikG
 jdAy0ETSt1o//NVNnjf47t1tQlBTULD0kn6abzdd76/d2rkvArbWLa1PI
 E0J+JR7GmqHr2pdj7cTLPEBMfrCJLRJBjhu/5y4sUi+GhzR0tMCQwYXOP
 ZzhLu8J6xSogOetSTkPHM42fSTGuA3Rfvqo9meD18/YD3lqGUFOKVUYDb
 LU77mjFX64x0KpF2OtZUEYmBl3gdQX+zR+nA8+7vAg4aGonv4bVviu+yL A==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12581794"
X-MGA-submission: =?us-ascii?q?MDGlluJ/98O0j2vwu7fZS51/kx2v2UWTZy1PMg?=
 =?us-ascii?q?qciebDbvZqgkPzhN9FW9p34KXR3Ia4rsN+OxbS7CjOGDVc7apfUuxwuC?=
 =?us-ascii?q?wGqZPMXymuPYL+aH7QDCExxHTLAbcbKAR/VbfhN1eXaJGoSyPAcUDCjO?=
 =?us-ascii?q?irgOOp+3jckof747d/hNIfmg=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:16 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO7CCowNHKvwUWWjoURfp7UlWcTwwNl6J91kB2ojt25gsl85A9bv8DGf/tYBp7dVTPacNC0i25HpbYo5QhyVcVJM07+Aye8mPC5F4Zxx8PbjnKXLd4dbpnnE5OVOYp4pe9oICrAOaiRfrR4rCI3ZksL7OxmjSvGPuyILv77JI65E/uAtBrwkM3WEc4Mie0uMKrQIhAYBpeCzTfcvs63ssrS1YU9TQ9sElNceeoaFdmq+NfDGS97AvfSARLWK8jPGsH5zeCZORI9f+3PDfHP0+HqrhZuj/8MCQdrasMBgZ3aXn2tGdOEjy+97NkSj/MNR6ZDm1b1BmZkfUd4+O8Kxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9U8NReqWpaS6WMzQ4uEVQ6iKKTM2a3k2YHd6FNepzus=;
 b=cJt1cygquSvtnVI3uSSroWA4kZL1OyGfTmZeezQJwmxweTkSIpW0hzq9vbs6WZ3f2AFvpTkovzusim4y1dpglncBhIWj4pEJo+L/8IMk70A2GyUGEEgHZy1tzgvcexeyx9hpSLwFwIs9Pe2domA/FPnOA9q1hapRCrLdOCVtAKRa94qxxgYvvMwGUKkeiYHLYD2CmfFbDWUf+Rv/vXb/EsXY4Dtd8RdQjyvTkon1YzDtw8yImxvJuFfyjzFZ138WGGjG8Y3m6fbGWzkJmw+NStkKEnKUdViYREhcQhEo1GW9kxrHofV0ZIJ6k3JW9edM+UYeXSkgWid46pHCFaoSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS5PR07MB9896.eurprd07.prod.outlook.com (2603:10a6:20b:676::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:14:14 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:14 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 03/25] intel_iommu: check if the input address is
 canonical
Thread-Topic: [PATCH ats_vtd v2 03/25] intel_iommu: check if the input address
 is canonical
Thread-Index: AQHappd+KiUrruFNmUS5CpwZ2UWvFQ==
Date: Wed, 15 May 2024 07:14:14 +0000
Message-ID: <20240515071057.33990-4-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS5PR07MB9896:EE_
x-ms-office365-filtering-correlation-id: 9bc55aa1-ccb1-472d-1d6d-08dc74aea0a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?NkNoVnV0TEhEOW8xK3N1MnRPcFVKK2JHTC9qd1Z5WXVOUXc3RW5wQW9tby9B?=
 =?utf-8?B?YmtUb290Q2p5bEIremQ5UjA2c0x2dXFIMGNDYmZZMHI2R0MxaUltbXFOdjND?=
 =?utf-8?B?WFpscTJZZnhuaEtjNkRTV3lTSFlaYkpMa1VhNlhJSFZ4Rlh2STVDR2gzRUxO?=
 =?utf-8?B?eTY0SmR2bDgybkFLK0tIVVV5eEdIdlZMWGxXaEQvcU1kYXp3YVhaYnFuOWJT?=
 =?utf-8?B?aHpXNDdsb0RDU3RicFZEZmtGTG9Tbjd5amFxdWtvYUkyeDNRN2xIT1JSeE1S?=
 =?utf-8?B?Z2pUR3QyRmdoZHR4UUZDNDVHZklHMGcwQ3RpdHpoS3dab1F2WmJpS0ZDTFRv?=
 =?utf-8?B?Y0hTT1UveUtYVDFXSUM5S0FlUjlmNC9yWlNwdDBOUzgzcXJoVytsNEkydGd1?=
 =?utf-8?B?d2ljakxySlp6VmxYSEpTTit3bTRPbk4yVnB3aWp6QnIxQm1xNXVoRmhZVDJY?=
 =?utf-8?B?bUxPK2lsMUxsRjNleFFWQXdoVEFrL3BoR0JnQWxMMXpTVFJISHU5aDBzMEhY?=
 =?utf-8?B?VXdoMWNiWUp6b200aVVCNXBmTDlXWGFiWktuSDI3YW03M1NUeE5oc2ZyOXBu?=
 =?utf-8?B?Wkh1SjRVeThxdkJ0R2ZnZUcwQ2QrazZpcUJkcFFkaEs2ekE5eWZqNFBtRDlq?=
 =?utf-8?B?QTBodDJsN0RLWW9vNHRwV3dCVTZ5UDh1cDZuWUdpa1RqNDRINmNvaHhuRyts?=
 =?utf-8?B?a3VDRjlXTHMzNmtVN1QwV0RtM0ZzTUJUdWc5R2tpYTc1MDhjK0hndW5kcXRC?=
 =?utf-8?B?L1gzTkRWdUVlVTFKZitBeHhyVHlabldBNDRJSU1zenExUzhHeHpvWnVYTERK?=
 =?utf-8?B?dldFUFpKRHhNcnl2TzdCMThkSndkNERLbTAzTHJiWUhLRHpPc1NTYnJqSFM5?=
 =?utf-8?B?b3FXbzVlNXdCN2lGYU9QUmNFa2RHSHA2L2NIdlNUMVV4YzRlOWNvQ3dyakNB?=
 =?utf-8?B?ZHkxK0FCT2xMcjNxZ1hkWDlGbXJLcllQQzl3MXZrTHh4NGw2TjZYajg0UVVr?=
 =?utf-8?B?bWFDVHVmcFVZemJxSXFwekNOV0F2cVA4czVYWXNxUC8raHZuTGVpcmNyRFZ1?=
 =?utf-8?B?K3lka1BJTjRpMnFFMHlBWWdBcSsxNUJHQkdlUUw5YldCNitxK1B4cUNXQmlx?=
 =?utf-8?B?WXJxTnhxeG9TMGlYc3NLVU1VQVNmR1J0d2RPZjJsd1AwS0syUWMrWkcydjJR?=
 =?utf-8?B?eFVIU1RwZlpyNUNIN0tNZ2lEcTBVZDZ6eG5rbEdFcGZSYzlSNFo5S29BKzNn?=
 =?utf-8?B?aVR6c2xIWjlaTExrNDNaZXN0dUl0QWwxZTZTY0ZlSWc3SC9OZXV3WGdCcWt1?=
 =?utf-8?B?VS96aEd2K01zZGZnNUZCTkplVUllaDV1UmJpVFFhZHNwdjlSYVgwS25MUWk1?=
 =?utf-8?B?RXpjZkNtMU5ZZUZTNHpENmRPbDlnQ1Y2bWtRUWpyL3RhQ2kxQkJoNVRTb1V2?=
 =?utf-8?B?eHd5UVJNQ0hadEx6elJxcUg4SmZoUGlBazZRbWIzUE9qWHZoYmpUbngwbnJr?=
 =?utf-8?B?VjVjK2F5VkM0VlhKYzMxeFF6TDJING1Ea1JhbDN6ZHoyRUhEOFdad2NxcmFy?=
 =?utf-8?B?WnhxSmlGNmtuOUdDeUdITDJHZUZlSmVSUHQwNWtEeDhxVzZYRGFsK1lKMFZx?=
 =?utf-8?B?alFneUVobXZ3d09oRGFnWTJyYU5jakpBU3loODZkUVRnVWM1V2llcmtGZkJN?=
 =?utf-8?B?RHNqbkdkSzNXdUw2bUwxVEZSTWZleGozSWsrUFJSQ256RHB6TGUxMWtuUzZs?=
 =?utf-8?B?ay8xRml4VUw5OWc5WTNhN0JReVNzV3VzY21zdU9GOWs4Zzhub3E1bTZYR3RI?=
 =?utf-8?B?UEdYM0M1R3JHODNFWTJCUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTFsaGo4bFJPVnZuL1lLZ1Q0a0dKYlcrZDllTUh0QmpQd3lpdXVpTHZCMXB3?=
 =?utf-8?B?QVU1dm9YUTA0OHd2RklweTllVmMzSTh1dk9nTzVTQlg4ZTZqaDNRdkdRYnNq?=
 =?utf-8?B?emtYRG5UTU4ybmdEbXZ3c0FtOE1zenpjYy9oMFJlcnFROHc0UHJEM0NMUmRu?=
 =?utf-8?B?eC9LNjgzRndqckVaaUtHQ2tEekxyeVhtYkxrTXdwQWtaaHMzNitkMk9Qdm92?=
 =?utf-8?B?eGhidW9YZlNNeURSdm9PTFY1bWZWbUU4b3RiTEJycCsxY0hDS3A4QzVCNGZk?=
 =?utf-8?B?bzV6VlExanVWYUFhL3VqUFB5RUtZc2RZYVNiT1ptRnRXQ3BwUjFiZ24wdFdx?=
 =?utf-8?B?RS9LNmVFZTlPbUc0eUIwcmw4Q29wS2VyQ3ROeVVNNXdFU1VUYXNkRnpieTNX?=
 =?utf-8?B?aHU3WWJEalE5M2tLemhnR3RnZU5XcktDbVN5RGxmRm1IaU4vdHZYNEdzMUFi?=
 =?utf-8?B?MGRHUGJkRkk4RWtBY21jUGVzdy9haVFmekd6N0dieXdmNGJRcnpTZTJ3c0pW?=
 =?utf-8?B?S1BHcDZzQnR4TU9EbUM3STdHMTJkdkU1SlorM0hSWDVDNzFIczRCakk2U2dK?=
 =?utf-8?B?amF4djVhdGhpNkFnMGJSRHNJcGNWRUhMd3hiZU9hR1R1U3VzTVBWSFRMcHFv?=
 =?utf-8?B?M2cvZWZJYlRXZXlFbWdJaGtXZm4xbEM0RzRYK28zelF1UEpLT1pDL1dweTBr?=
 =?utf-8?B?OGFJV1dmLzdTblpTNzNjdXhYTmorL1ludmI5SWp3Rk9JT0FEaGx3aytDVU5t?=
 =?utf-8?B?YVA2VmZna1RtNE1oZjdUTHZ3N2lmalhOOThMSFVNR1dYZ2xONGxpanFwejBW?=
 =?utf-8?B?YnNkdGk0ai9qOWZxTGxSSTEyaTNDUzZsZWd0TDQxMG1GYjJ4alZsaWFNcjhn?=
 =?utf-8?B?b2Q5LzB6VXgrWE83VEpIbzByU0xORmh0QWZpMjFhVk53QzlpcDNBcHZsQ3Z6?=
 =?utf-8?B?YXFsZWZmWVFRU1k4Z3NWYmhjUk5EZTUvQ0V2M2ZHakgyK3Rxb0hlUm5mdjNx?=
 =?utf-8?B?L0FHSUxqdE1VRWdpdktnbXpBdEZNK001NTc0UW4rd2FQMmsvbUozK0dSeGVH?=
 =?utf-8?B?RzJlaVRZVG1yTVRxT05yQXNjb3l5djQxWjV6QmRJZG1mTVNiMzFKSVBhNkds?=
 =?utf-8?B?RmMzem9nakZFQi93TGRuTXNJdGFjUGFsL1ZOdVowamp1TE5EeXkzbnBNZmdV?=
 =?utf-8?B?ell4MForS1hjbTBUcnBkcGN3enhvNEdMalpZQ2xqRnpIZUN6U0VRTnRiOHNa?=
 =?utf-8?B?RTd3Q1NvaCt0cmlmZTY4SmpQb0F3R1RZRDAyZG8yRHhvcm9yZUQ4MFlyNXln?=
 =?utf-8?B?MG9wcUhIM01VMGdGWjhSL042ejNtMHFwYWZCVGIvMWREV2ZvWWF0YVJzRVBm?=
 =?utf-8?B?eVBmME1zclVnRTYrOEVzVURRdVAwYWRid2hSVkd4dWl4RUk0dUQ4bC9rWDZa?=
 =?utf-8?B?ZWhUSzE1cWtleWJQcFhRT3NURFduZTFvcENZc2c5ZTNUWldZVUtVeVdYTjJz?=
 =?utf-8?B?NW5HS3dRNlMrOEZjSG8xNld1ZldOdVZ3RHo4NzhFa3psUUwremxjWkVEQ2Uv?=
 =?utf-8?B?Z0lXSndWRjI0YXVna3l6cXhROGU2dkVTcHkrQWZFY050d2h4Wmh3bEF4L1dl?=
 =?utf-8?B?QXRzVjlBdHVETW4yRTVmV3RJZ1NPTGlMOXJKR2pQWnIxMVJNd0daS0RtT0tz?=
 =?utf-8?B?YnBGZ1FBYkZhelFDeEs0TGdJcGVybDgzdXhkYlFvZ2Y1M3RoSHBiVEpldUth?=
 =?utf-8?B?ZGtSRnZ1a2x3ZzhGd2lyNjRLeGU2Uk9SOVFFNVpBMENpenJZZ2M0dEtUcDho?=
 =?utf-8?B?OVMzVWNzSE5TL0c1UElyZWJNd0MwaTJib2tsZlFvZWVOaVpYQndjbk9QcVVS?=
 =?utf-8?B?bkc2MTBIM3ZWN3h2WU9XT0JvUmR3cXJua2xRSzhTM3RralRxUVNsVzBPYWc2?=
 =?utf-8?B?THB5eW1neXIxWE5GL0NCbzNOM25XcUJzSVJnOXlBMGJSSWk3SFYvQm81d0gw?=
 =?utf-8?B?U0R6R2pDVGpFY0krb2JxVmhtbzNCdmJ4UGs1cysyMTEycmk1RE85YUloOU1M?=
 =?utf-8?B?N1ZKVzNmZUNReWUvTXNXNTF3NnVxakU3bXd0NHl3NFJveWZCQUZDeVBlS1pX?=
 =?utf-8?B?MWNkVGpHUnRGSkFaMjlVZGxXYW1CKzdIL3RaZHNSdlJ2SlVsMjFtL2dFRXRk?=
 =?utf-8?Q?fBSOzsR1QmOSeHiL/LXdd1o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C048B3095F86C24F9BA564AB5619A41D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc55aa1-ccb1-472d-1d6d-08dc74aea0a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:14.7333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aByEgcxOj8EIYo0JplJZLILyRvsmqYaB5H3cWMbdcmSWdYfUGpO90ez79FbnMcFUuwEYaX+DjdJbeWbD95HdnEUHFZ169SBg1wwxDaL73k3WCGBxsG6uzv7pNw0V/RVr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9896
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

Rmlyc3Qgc3RhZ2UgdHJhbnNsYXRpb24gbXVzdCBmYWlsIGlmIHRoZSBhZGRyZXNzIHRvIHRyYW5z
bGF0ZSBpcw0Kbm90IGNhbm9uaWNhbC4NCg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGll
dS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2
L2ludGVsX2lvbW11LmMgICAgICAgICAgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCiBody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAgMiArKw0KIDIgZmlsZXMgY2hhbmdlZCwgMjMg
aW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcv
aTM4Ni9pbnRlbF9pb21tdS5jDQppbmRleCA4MGNkZjM3ODcwLi4wZWNmMDBmMzdhIDEwMDY0NA0K
LS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMN
CkBAIC0xOTEyLDYgKzE5MTIsNyBAQCBzdGF0aWMgY29uc3QgYm9vbCB2dGRfcXVhbGlmaWVkX2Zh
dWx0c1tdID0gew0KICAgICBbVlREX0ZSX1BBU0lEX0VOVFJZX1BdID0gdHJ1ZSwNCiAgICAgW1ZU
RF9GUl9QQVNJRF9UQUJMRV9FTlRSWV9JTlZdID0gdHJ1ZSwNCiAgICAgW1ZURF9GUl9TTV9JTlRF
UlJVUFRfQUREUl0gPSB0cnVlLA0KKyAgICBbVlREX0ZSX0ZTX05PTl9DQU5PTklDQUxdID0gdHJ1
ZSwNCiAgICAgW1ZURF9GUl9NQVhdID0gZmFsc2UsDQogfTsNCiANCkBAIC0yMDIzLDYgKzIwMjQs
MjAgQEAgc3RhdGljIGlubGluZSB1aW50NjRfdCB2dGRfZ2V0X2ZscHRlX2FkZHIodWludDY0X3Qg
ZmxwdGUsIHVpbnQ4X3QgYXcpDQogICAgIHJldHVybiBmbHB0ZSAmIFZURF9GTF9QVF9CQVNFX0FE
RFJfTUFTSyhhdyk7DQogfQ0KIA0KKy8qIFJldHVybiB0cnVlIGlmIElPVkEgaXMgY2Fub25pY2Fs
LCBvdGhlcndpc2UgZmFsc2UuICovDQorc3RhdGljIGJvb2wgdnRkX2lvdmFfZmxfY2hlY2tfY2Fu
b25pY2FsKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDY0X3QgaW92YSwNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgVlREQ29udGV4dEVudHJ5ICpjZSwgdWludDMyX3Qg
cGFzaWQpDQorew0KKyAgICB1aW50NjRfdCBpb3ZhX2xpbWl0ID0gdnRkX2lvdmFfbGltaXQocywg
Y2UsIHMtPmF3X2JpdHMsIHBhc2lkKTsNCisgICAgdWludDY0X3QgdXBwZXJfYml0c19tYXNrID0g
fihpb3ZhX2xpbWl0IC0gMSk7DQorICAgIHVpbnQ2NF90IHVwcGVyX2JpdHMgPSBpb3ZhICYgdXBw
ZXJfYml0c19tYXNrOw0KKyAgICBib29sIG1zYiA9ICgoaW92YSAmIChpb3ZhX2xpbWl0ID4+IDEp
KSAhPSAwKTsNCisgICAgcmV0dXJuICEoDQorICAgICAgICAgICAgICghbXNiICYmICh1cHBlcl9i
aXRzICE9IDApKSB8fA0KKyAgICAgICAgICAgICAobXNiICYmICh1cHBlcl9iaXRzICE9IHVwcGVy
X2JpdHNfbWFzaykpDQorICAgICAgICAgICAgKTsNCit9DQorDQogLyoNCiAgKiBHaXZlbiB0aGUg
QGlvdmEsIGdldCByZWxldmFudCBAZmxwdGVwLiBAZmxwdGVfbGV2ZWwgd2lsbCBiZSB0aGUgbGFz
dCBsZXZlbA0KICAqIG9mIHRoZSB0cmFuc2xhdGlvbiwgY2FuIGJlIHVzZWQgZm9yIGRlY2lkaW5n
IHRoZSBzaXplIG9mIGxhcmdlIHBhZ2UuDQpAQCAtMjAzOCw2ICsyMDUzLDEyIEBAIHN0YXRpYyBp
bnQgdnRkX2lvdmFfdG9fZmxwdGUoSW50ZWxJT01NVVN0YXRlICpzLCBWVERDb250ZXh0RW50cnkg
KmNlLA0KICAgICB1aW50MzJfdCBvZmZzZXQ7DQogICAgIHVpbnQ2NF90IGZscHRlOw0KIA0KKyAg
ICBpZiAoIXZ0ZF9pb3ZhX2ZsX2NoZWNrX2Nhbm9uaWNhbChzLCBpb3ZhLCBjZSwgcGFzaWQpKSB7
DQorICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgiJXM6IGRldGVjdGVkIG5vbiBjYW5vbmljYWwg
SU9WQSAoaW92YT0weCUiIFBSSXg2NCAiLCINCisgICAgICAgICAgICAgICAgICAgICAgICAgICJw
YXNpZD0weCUiIFBSSXgzMiAiKSIsIF9fZnVuY19fLCBpb3ZhLCBwYXNpZCk7DQorICAgICAgICBy
ZXR1cm4gLVZURF9GUl9GU19OT05fQ0FOT05JQ0FMOw0KKyAgICB9DQorDQogICAgIHdoaWxlICh0
cnVlKSB7DQogICAgICAgICBvZmZzZXQgPSB2dGRfaW92YV9mbF9sZXZlbF9vZmZzZXQoaW92YSwg
bGV2ZWwpOw0KICAgICAgICAgZmxwdGUgPSB2dGRfZ2V0X2ZscHRlKGFkZHIsIG9mZnNldCk7DQpk
aWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdV9pbnRlcm5hbC5oDQppbmRleCA5MDE2OTFhZmI5Li5lOTQ0ODI5MWE0IDEwMDY0NA0K
LS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQorKysgYi9ody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmgNCkBAIC0zMjQsNiArMzI0LDggQEAgdHlwZWRlZiBlbnVtIFZUREZh
dWx0UmVhc29uIHsNCiAgICAgVlREX0ZSX1BBU0lEX0VOVFJZX1AgPSAweDU5LCAvKiBUaGUgUHJl
c2VudChQKSBmaWVsZCBvZiBwYXNpZHQtZW50cnkgaXMgMCAqLw0KICAgICBWVERfRlJfUEFTSURf
VEFCTEVfRU5UUllfSU5WID0gMHg1YiwgIC8qSW52YWxpZCBQQVNJRCB0YWJsZSBlbnRyeSAqLw0K
IA0KKyAgICBWVERfRlJfRlNfTk9OX0NBTk9OSUNBTCA9IDB4ODAsIC8qIFNORy4xIDogQWRkcmVz
cyBmb3IgRlMgbm90IGNhbm9uaWNhbC4qLw0KKw0KICAgICAvKiBPdXRwdXQgYWRkcmVzcyBpbiB0
aGUgaW50ZXJydXB0IGFkZHJlc3MgcmFuZ2UgZm9yIHNjYWxhYmxlIG1vZGUgKi8NCiAgICAgVlRE
X0ZSX1NNX0lOVEVSUlVQVF9BRERSID0gMHg4NywNCiAgICAgVlREX0ZSX01BWCwgICAgICAgICAg
ICAgICAgIC8qIEd1YXJkICovDQotLSANCjIuNDQuMA0K

