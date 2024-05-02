Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB01C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNI-0003f3-C8; Thu, 02 May 2024 11:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNH-0003dr-3n
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:31 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YND-0005yz-OD
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663768; x=1746199768;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=E2oyVReCNycO15PF5GywpqRq2wxJJlE+TmbfE5B4/k4=;
 b=et0dWkf4lh/o5PhG7C3lVEoemB8PCyoYG5kJ15FbQa5UHVOzqgNTb4bL
 3ss0g92fsu1mmU+yDPq1KDxXsAAYPD5xi66c9TVTgt2tR/dW42Yfu34Bp
 F+CheEkUXQ6qYToirBLxkWzWkswVNT4EMQM4s047hKsSITPJpO7QQwUY3
 BEMO/xnIjEzywUWLcTMqGbSeVrJxGEpy4lHjLnIj69nG/Ow3DmelimooZ
 Y6Tdl07gkLMHJ1NlumIua2yMqz6bJUWGdSgCJI+CLtgQ2cu2GapyryGIB
 0WyjG8KFc4HxSB5qJ7vCW2Idi11JMKF9o9Dxl0llWJbxhdLioOSnT/Naz Q==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11730667"
X-MGA-submission: =?us-ascii?q?MDEZqJ8AQz14cuTSg3bDFy0yEtYHFlxnDWtnjy?=
 =?us-ascii?q?Lgn7o5stfxqXUszR6pAsbfyl6ZapwNaA/8uOGN+kpBQkGFYUiCFW72Zs?=
 =?us-ascii?q?GQouA78b+8Q5EFBTvYxsta4iSv1eJwI0VFfEnpcOxfgoJ7PndXY+3s+d?=
 =?us-ascii?q?QL3jGGKYSzRXjg7m9YfD7gVw=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:21 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTLyFIp8deA+vkuKcl5779Ur+rZiGJ11ZgiV1QtWG8uuhzDiul3c8n84aszfesjIA6kT2Bcg552yz12v6oBuvjziz2sa9kv5gSR2C/soT005xDDaQenIQpONjRXof0FDlWocLmQ6Oxyn17mtmSuC3KoG6JzhKWZrEppI82dckgaPLp/4SHtb0zZBROaKcpSnbceL3CQVHWkba7FckG4YnjqlESoN+1mit65NC1AlwSmroWo+B9dl9JnozYGqOyMyYot9PL0ZXYYDlal6LddrZkcijfLv+uFUfWtiBEml4+VarqE27EJ+w4p95zGyWl/iKg3bqSKXVUSPMHqFGs5VyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2oyVReCNycO15PF5GywpqRq2wxJJlE+TmbfE5B4/k4=;
 b=aIjTf9OTf0ddPSEbxUdNn4sTJMd2YCq9VAazDfXIqU32mmR2AGH2AanUR+SMRbMDGciAeLdj9LVhlqtRCPMCkROzPdaIkZy9OhnnT1T9PoV4nQFAP2ZL9j06IvYi4PVhcrGcqreOiD+CsL5YzAZj9M4j2YoSSFonwmDo0OmiPA3/WpWmUGkuEmSwNThTaN6y5JHX6oKvgsjP038O0cW8lEMhqMPBWVsGohtktprmEE/9OUUlrCixpWg8WpoAaCrYRYQ6R3wBnYTmu3L/iKpNGG0yV6wwXAT6jdrGa1zQ7wEzG7cWxINEJr3k0mUOs2A+Caj/LJH1TCQxuA5vdzA45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7768.eurprd07.prod.outlook.com (2603:10a6:20b:351::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:20 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:20 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 16/24] intel_iommu: implement the
 get_address_space_pasid iommu operation
Thread-Topic: [PATCH ats_vtd v1 16/24] intel_iommu: implement the
 get_address_space_pasid iommu operation
Thread-Index: AQHanKWAk9uYkE5wSkm3TNSa/hRJRg==
Date: Thu, 2 May 2024 15:29:20 +0000
Message-ID: <20240502152810.187492-17-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7768:EE_
x-ms-office365-filtering-correlation-id: 802e0276-0916-4017-8e9d-08dc6abca32d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZVRxRHQ2bWoya0E2bWdaUTQ3dWUxT2tIN01SUXZsUnMyd3p2c1gwOG9OR3N2?=
 =?utf-8?B?aXdYYisyZFppekE5S0xLR3ZZYkZaSWwyUDQ3aTFibXBEWnBQWE9EOHliblp3?=
 =?utf-8?B?VXRZYVR6OVdLa3RibWdkMlhYdmY2S3dWeDhYWTlCbm5VUzV5OC9mOXhRNmZn?=
 =?utf-8?B?NjlESFJ4MTNaSzZ4MWFuK3Z6L0NRZytlZldFU0QxY0JERk0xNEJ6ZHdROHV4?=
 =?utf-8?B?bVRWcURJVnF3cnFUaFJIVHV5K0EwYm9BMFE2aU81aGtpdU1NTFNhaDhzMG43?=
 =?utf-8?B?YnNoQ1VsZUViMFhNMTV3NmxsVWxmTjJzN05iTVNDTTNNdlp3QnVMcG0wRnVk?=
 =?utf-8?B?QkZDWk5LbDM0RjRnSUNnNDJMczdjUENvdUIwd0hDT0d1aU55TlQrMWR3VURa?=
 =?utf-8?B?eVpSTFBoY3RsTmRnNENHWlpxeW93dHpBbWhYMllUbTI1TUhSVXI0MzZEckFi?=
 =?utf-8?B?OVVyVVBhNmFvbU55emVuZnFGQlIycWE1cisyQjZuRjcvWmwwejZ0YXY4eVVl?=
 =?utf-8?B?UGpaaDgxT2Y1UEdaRzF2Q3pUMktkQlpCZFY4cFB4VjdzN2lUVi95emlaMHFO?=
 =?utf-8?B?S1REN0k2OU05dlRzYzZQcm9weGlCUjNVY0FiL3h4RkxSMEwwQ3NhL2NhTXZM?=
 =?utf-8?B?TXZpTDMyZVQ5K2FQUjNZRmtwSnJHU2dNTDFiekNjRnI5TnExL2RTa1A5NnB3?=
 =?utf-8?B?MFc1SEhnTTlITm85bDRzVml5cmNreTFPeCt3N3A3S3RZWUw0cTBmOEtWTlgx?=
 =?utf-8?B?amdQLzVhdW1SSTJqeXZQTytpNmdTU3RIakY1T1FPcmJaOWc2TGUzNjVHdVNz?=
 =?utf-8?B?NFREMkVndVBHc2J0VUtDNTVsYitYUWVTczk2RFU4UlpjYlJJNUZ2NFVMcU9U?=
 =?utf-8?B?UVAwN2V3bVBXTTdSWlJFUXpKbTlsNVI5SWU3RCt1VE1pUGFQcXRtbGdYUnB3?=
 =?utf-8?B?NjZKMUNWVTRVc3FLSy85c2c0dUVhaURaUnlTUndZWXRYTVVWZjlCYkFqbnBa?=
 =?utf-8?B?ZXduMCt0U1JxODUzTlZ5eXhGRGhnZkxDbVhITzZjTlRURWU1UXZucVZCWlAy?=
 =?utf-8?B?eDBQa1lHMDBLU0RneFV5MWRvcXVxUXFYbWZDVGt6RDJhOWVTSFpZY3BxWHR5?=
 =?utf-8?B?aWthSFdOMHhIZlk3N1dKYVdFSlZNVGtHMTNXSkwxc2hwYThkMnNZcDNBaW1l?=
 =?utf-8?B?MHZoLzI2dGZtYldndVNlUFVnNGdQemRBMzFtdkhSNlhqcEdWRmdTdjlmUSsy?=
 =?utf-8?B?VkRNb3BYUS90cStlU0NaSzU0ZEFEaU1xY3RhSWlVVG16UTduemtiOGtOWnpC?=
 =?utf-8?B?bGU3Vk1rNjdlVG1NKzN1bDBucEMzMWpDSmtkYUpNQ3N3YjJWUEZwTjg5V21x?=
 =?utf-8?B?S0pnaDIzVVdwWTdPbU8yYWJNN3ZSU2NWR1VGWHJSZkMrL0haRnNKdDAxWVc3?=
 =?utf-8?B?N0hjOTZOUmpSVjhENk45c0w1bzJMeVVCa3pOVzhhV2FaZmdiVjdlSk9QclZr?=
 =?utf-8?B?Vy9wUzQ4V2ZNUkwrT1JjQ1NUQWV1WjZjTVg0SGhlbElPdmVDSFIzVUJlai92?=
 =?utf-8?B?bVIwZVZUd2hRcG45TUdVUytvcEp5RDN2ZnVLMTJjODFoOEZaUVlyQjhReUNK?=
 =?utf-8?B?Z1RuMmo3dTRxcC9XNjkzUmNLK2dSTFBlKzJCSTBMOUpaZGVsRHA2dnl2OHQ5?=
 =?utf-8?B?emtsNG1HWE5UbzBIalcwWjFTRHJ1MVJTcE5SQ0NUTzgzVDVtQzBmMXdQODhj?=
 =?utf-8?B?allPR0ZVdXhieHJDd0l3cXZ1TWVha1BwTzZUOS9kWkdrZGNvTFV5K0dqMVhJ?=
 =?utf-8?B?TzVZd2kvT21PWC9PM1JIZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2hjNHROaEFQM2JlbE9JQkt6NElYNHNxempkZ3pPSGVKenQvKzVmazllQWh0?=
 =?utf-8?B?bFpIcGJWNUZOejFTQWpyczEyWG9UVk5oM05CTnB2b0NXUFA1S2dKeHRTTmRY?=
 =?utf-8?B?OTVlYlFJTnRKc1p0ZytCWjFMRnh3ckxPMEJLem5CelQwbUNSM3MvYmFNS2FN?=
 =?utf-8?B?N1ZIUFZXVjY0K2VvMUlUcDZWK2NRZjZ2dUpPUVBrOW1uUlRqdGZWVUs4Qy9V?=
 =?utf-8?B?bWxDY09PQndSWWpPbHQ0SXdKejRDVFphWlBjcnRjOWZEVkdtR2xWQzZlallO?=
 =?utf-8?B?ZWFSbnRqMUF5SVBtUVdLdHdZQnBONnBkOVM0RzdqL0REaTRhSjNzTXJvdDFE?=
 =?utf-8?B?MWo2ejBPVEdDeW1LdG9NblJheEt6V2NreTRleENIVkNpRUM2YlJZRlJqYTg1?=
 =?utf-8?B?OTltR21MdU14RC85UjdGZ3htNExoUVFDN1FQUGpQVkpOV2xJVWhJVmxSN0Yr?=
 =?utf-8?B?c0JyS1lsMC9SOFgvVGxiN0JVb2laT0lnemhVUGdlQUlnbHBmMGdXL3VraTBJ?=
 =?utf-8?B?Tkk4QlNqaXdXOThxTGJXczlNTDMvYXViZ2hMTnAyRDFHcnBmOWlRa0FvVjRU?=
 =?utf-8?B?OXA2L3haWG1YNDZOSlFEMFpzYVJ6VEZYU1FyUVg0MlFWNTMvZG5CSTZwK1BE?=
 =?utf-8?B?SnIzT2RSQThHc0pvVWYxOFdleG9hMjZRbjJsbHh3RlVNRVlRazRmZDM5NkZX?=
 =?utf-8?B?eU00ZE5Bb01PUnRJQUMzeWY2TVMwSFR5VENVTFJ3Z1E5UVQ1cnYvejNobW1C?=
 =?utf-8?B?WXJGQ0ZpeFhEUkdGNThzUU01TmVPbE43M2NCSnVQR0I4dHcwdTFya2ZPNmdo?=
 =?utf-8?B?OHFHMWhKWVNSNWU5cklpOFNWWHdaL2VjSnAvOEVoQXkxNVBDUFJDdXV6dVp3?=
 =?utf-8?B?ay9GcGRWbm10QTNHT0tiQ29mRnVLQVkyZXVOcWJ0RnR1bjFKMTVQUHZXTXk2?=
 =?utf-8?B?ZXhoOWxnRnhyeEZPZ2FSZVVBVy9JakpUcEZwdkw5bW9xV1ZrMmwyVjNJYzli?=
 =?utf-8?B?VjlNaE03VzNKaVJxRDZ3YXErMkRxR2cwbmZMSlVuVHlQeFVCUzRQYVJtTWx1?=
 =?utf-8?B?Zm9EdG12TURsL1ViWFFKTFEwWTFBYzRUMkgyT3Zva3EvR2w5dGM3K1VCRWoz?=
 =?utf-8?B?Y0pjL3NnVjdMeGR4c2ZtMWFFV2EvTTFmQzRIL3ZBdU9TY2RvWEZjay9ORlJS?=
 =?utf-8?B?VG5XcEdHeFE2M3Y1cVB0MlJWdnB6RThiaFV4dFBkUFV1QTR3UVB5Ym0wbEdz?=
 =?utf-8?B?STFkMkRqZFdzcmppZUN3azZ2RmVpM25qVFRJREN6dkp1UjR1S2lUTHovbzZm?=
 =?utf-8?B?QXkxU09YWFRaWFFjeUxDN3dLSDRZN3dEWDc2ZTFqbmVSaldvWHlKQUJHREJ5?=
 =?utf-8?B?OXJHVDBhRTZwR1RaM1luaStjM1BzUFJxK3ZFZjZuZXQ0czdVVUZIRUhhU1Rm?=
 =?utf-8?B?K0pBR01FcDdkbGlRcUwzTTlUUVNiZFJSbGtjSmVyc2JMWm1YOFhJZG1nZWxT?=
 =?utf-8?B?VFo2VGlpQndiMkVoblhyQ0dsWkNYNU5mTk1BNnZpSXF5TGRtVFZXNk9vajVx?=
 =?utf-8?B?VGVubnU4Kzc0SiswZnNOVEhDakFTQlM2ZnB5NTFDNVBuOHNISTJQMTYyQmNM?=
 =?utf-8?B?Z3FFOXlJZThDRGRxcUt4ZWpXUDJLQy9FL2Y5cWRtK0VwR1MrbjJrNUU3RjVy?=
 =?utf-8?B?aWRiUmNHVjJ1blFUUDBNa2cwVGpuZEVXQXdYYTNlM3p4b0hNdFZxMjhmQTBo?=
 =?utf-8?B?dmRzU3BNc2Z3Y3A0cWk4OVRvY3RqRkxjbFQ0MkRjUDJjRTRpVU1SbEkyVVJu?=
 =?utf-8?B?UVhqTDhjajVKb3BvT1BSanNxVGkvUXNqQmp6U3RHRmRFT2xwMVhVRDF6UVdH?=
 =?utf-8?B?NVhjV3I3Y3F4L0Q4U2dNRGcxamI4cjdtOEo5V2NiOU53aklaRnNkNkp0TTFs?=
 =?utf-8?B?KzkzeXl0diswMlpSYWgwNkxRNEYyeitIZWlYcE5sNm9hdWsybjY2Y3g0Q2Z1?=
 =?utf-8?B?dGJIbW9QY0FUcXBpOGVnSC9IamNIMVZRR0Y4NVkxSGdpWnVBeFVrUGhuaGtr?=
 =?utf-8?B?K0MyRkk2SENsUEJHMStkTnE3aURRN3lGajd3N2ZlZmZ0QzRQR3RSU2Z0eGNt?=
 =?utf-8?B?MVNJTE8vV3FnLzA4d25KbDVjTHF0TENzRzJvTUdiVW90ckNNUnoyREg1ZXVV?=
 =?utf-8?Q?glKVOQDI7l5DVtKGInl5tms=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B95F4E780163A45933357B178439382@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802e0276-0916-4017-8e9d-08dc6abca32d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:20.3775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GS3LOLPbNmPrxCpSf3rmdizM5cvOTy2Z+Lf/MQ54VAScW9r74kRqjg/FrnBZSq8HSE6vgIENZp1aLW7TkAu6DXMYX6czbh0I6Wq9PaUBndBrfo/N/dR8JDl1uJJD4UVo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7768
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICB8IDEz
ICsrKysrKysrKystLS0NCiBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCB8ICAyICstDQog
MiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpp
bmRleCBlN2MxYTU1ODJhLi5lOWZhNDhiMzc4IDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCkBAIC01NDMyLDcgKzU0MzIsNyBA
QCBzdGF0aWMgY29uc3QgTWVtb3J5UmVnaW9uT3BzIHZ0ZF9tZW1faXJfZmF1bHRfb3BzID0gew0K
IH07DQogDQogVlREQWRkcmVzc1NwYWNlICp2dGRfZmluZF9hZGRfYXMoSW50ZWxJT01NVVN0YXRl
ICpzLCBQQ0lCdXMgKmJ1cywNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQg
ZGV2Zm4sIHVuc2lnbmVkIGludCBwYXNpZCkNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQgZGV2Zm4sIHVpbnQzMl90IHBhc2lkKQ0KIHsNCiAgICAgLyoNCiAgICAgICogV2Ug
Y2FuJ3Qgc2ltcGx5IHVzZSBzaWQgaGVyZSBzaW5jZSB0aGUgYnVzIG51bWJlciBtaWdodCBub3Qg
YmUNCkBAIC01OTgzLDE5ICs1OTgzLDI2IEBAIHN0YXRpYyB2b2lkIHZ0ZF9yZXNldChEZXZpY2VT
dGF0ZSAqZGV2KQ0KICAgICB2dGRfcmVmcmVzaF9wYXNpZF9iaW5kKHMpOw0KIH0NCiANCi1zdGF0
aWMgQWRkcmVzc1NwYWNlICp2dGRfaG9zdF9kbWFfaW9tbXUoUENJQnVzICpidXMsIHZvaWQgKm9w
YXF1ZSwgaW50IGRldmZuKQ0KK3N0YXRpYyBBZGRyZXNzU3BhY2UgKnZ0ZF9ob3N0X2RtYV9pb21t
dV9wYXNpZChQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLA0KKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgZGV2Zm4sIHVpbnQzMl90IHBhc2lkKQ0KIHsN
CiAgICAgSW50ZWxJT01NVVN0YXRlICpzID0gb3BhcXVlOw0KICAgICBWVERBZGRyZXNzU3BhY2Ug
KnZ0ZF9hczsNCiANCiAgICAgYXNzZXJ0KDAgPD0gZGV2Zm4gJiYgZGV2Zm4gPCBQQ0lfREVWRk5f
TUFYKTsNCiANCi0gICAgdnRkX2FzID0gdnRkX2ZpbmRfYWRkX2FzKHMsIGJ1cywgZGV2Zm4sIFBD
SV9OT19QQVNJRCk7DQorICAgIHZ0ZF9hcyA9IHZ0ZF9maW5kX2FkZF9hcyhzLCBidXMsIGRldmZu
LCBwYXNpZCk7DQogICAgIHJldHVybiAmdnRkX2FzLT5hczsNCiB9DQogDQorc3RhdGljIEFkZHJl
c3NTcGFjZSAqdnRkX2hvc3RfZG1hX2lvbW11KFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGlu
dCBkZXZmbikNCit7DQorICAgIHJldHVybiB2dGRfaG9zdF9kbWFfaW9tbXVfcGFzaWQoYnVzLCBv
cGFxdWUsIGRldmZuLCBQQ0lfTk9fUEFTSUQpOw0KK30NCisNCiBzdGF0aWMgUENJSU9NTVVPcHMg
dnRkX2lvbW11X29wcyA9IHsNCiAgICAgLmdldF9hZGRyZXNzX3NwYWNlID0gdnRkX2hvc3RfZG1h
X2lvbW11LA0KKyAgICAuZ2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQgPSB2dGRfaG9zdF9kbWFfaW9t
bXVfcGFzaWQsDQogICAgIC5zZXRfaW9tbXVfZGV2aWNlID0gdnRkX2Rldl9zZXRfaW9tbXVfZGV2
aWNlLA0KICAgICAudW5zZXRfaW9tbXVfZGV2aWNlID0gdnRkX2Rldl91bnNldF9pb21tdV9kZXZp
Y2UsDQogfTsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCBiL2lu
Y2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQppbmRleCAwZDViOTMzMTU5Li5iYWM0MGU0ZDQw
IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCisrKyBiL2luY2x1
ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQpAQCAtMzI1LDYgKzMyNSw2IEBAIHN0cnVjdCBJbnRl
bElPTU1VU3RhdGUgew0KICAqIGNyZWF0ZSBhIG5ldyBvbmUgaWYgbm9uZSBleGlzdHMNCiAgKi8N
CiBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9maW5kX2FkZF9hcyhJbnRlbElPTU1VU3RhdGUgKnMsIFBD
SUJ1cyAqYnVzLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBkZXZmbiwg
dW5zaWduZWQgaW50IHBhc2lkKTsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
bnQgZGV2Zm4sIHVpbnQzMl90IHBhc2lkKTsNCiANCiAjZW5kaWYNCi0tIA0KMi40NC4wDQo=

