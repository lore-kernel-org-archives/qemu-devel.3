Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B0EC7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 08:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRnir-0001Mh-L4; Wed, 18 Jun 2025 04:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRnip-0001M9-9w; Wed, 18 Jun 2025 04:00:39 -0400
Received: from mail-northeuropeazon11022085.outbound.protection.outlook.com
 ([52.101.66.85] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRnig-0006Dg-KJ; Wed, 18 Jun 2025 04:00:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGex8YZigHhh007rckbpnu+1gXAkVbgUfYHKVRJo+RaPp7hj6EQ/EYBOQhTs8FwdE7ObHOioDVUWY37w7dQYR0l/+/0d38p4LtZLst8F1vsEg59xHBSBQB38neEOMUPVAuEdTFrdcH3M/xRGKlxxBQEVfgZmwDeLDQghoY0Lt/H8BFgZ5F0HVpwcVTvi7lc7hRsfBrMYVBH644i/LIbJCO2PDr04GpkJ5thk79/uKiAbUp6LHgYR5Uxzn+jOSHKl6gRE2yp/bcjmX3i5xditXOtYFW4nOI6C4qBtOlZw1/St7i2tMT6M7Q4doI0S+QV6ue8ZkScRkns/lVnqfqBEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxYpU30fQTjWFWs9bT8I+t8hN7K9Lb2nnaaJmceCSDI=;
 b=gnp65XJyWxEphcF/Vp5vMLvocdFeJp+pXGsiSUpQIeTaiH91/mwpw//IukQpmh4DhJDxNQCxisrKAXqrmbKkjaVfC41AIdlGkqfIR05qk6KjKRS+433lM0+OyBsSinYn4LhkTYm2wwsRTz29LtwxP1qlBBnKn2IA9LiN9By4QOClCn2+q08JyQU6j7kJYmCQKiL3xtpOC0LC7NRtAFq+7P0TOus4kr4z+KKF8FewPvMcgAhv5VKm+hRX5koF+LUnuxR53EeN0c2FrZn3WRKTwQMHCB7ESxyPH4Yrl084DU+HImAeA+xcxnGDsXoMtN/el8LzReBKyaFG16hePDRQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxYpU30fQTjWFWs9bT8I+t8hN7K9Lb2nnaaJmceCSDI=;
 b=Fp12OaxLorBgHinCA7fj52cxeH36rjLdDBym/S+rvSELRWDjnxv4tc6k74Kih+2VcDD9LmRNlHCAAAWLT7W7HjQVGVi3EHcUk79vTWv8YUrXKnatTWXPDkQmOwipRhgGX8jglgYdkalvQXZ4d9ylHYCfwsFUWwfG3gHx2rK+C7Wi4qoBWCH/Pq/q8dq3TobdgJP2a3VjKqG6EMzPqxAoUJjS9WAPHCKV8n9I8MICP4nPsxJJF8MndDyvevDUJa8RtQvKwhkdyfGO7qTQk15h0iH9rfakoRDcYhLhNYLZpP+km42Ly49TlZHcikqeHGT5dI2TVWscTQJSWGL76nRfiQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AM7PR09MB4230.eurprd09.prod.outlook.com (2603:10a6:20b:11c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 07:55:23 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 07:55:23 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "cfu@mips.com" <cfu@mips.com>
Subject: Re: [PATCH v2 0/9] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v2 0/9] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHb08AAl5hcaytutEa6PQm7OHafYbP8UeyAgAxTQwA=
Date: Wed, 18 Jun 2025 07:55:23 +0000
Message-ID: <69ad6d40-981d-46ef-a8ca-58b118890cea@htecgroup.com>
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
 <CAKmqyKOPahax+3EYvrsV1_+S22exmt2JmctU_wtKSJShwABBwA@mail.gmail.com>
In-Reply-To: <CAKmqyKOPahax+3EYvrsV1_+S22exmt2JmctU_wtKSJShwABBwA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AM7PR09MB4230:EE_
x-ms-office365-filtering-correlation-id: c518b304-d6b7-4d79-4dd3-08ddae3d7adc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?c1Q2amZsWVRFcTBhLzBGc1BSYjVmbFIvVjFNUEI5aXYrdjk3aHpVL0ZUb2xS?=
 =?utf-8?B?YWh6NkVHYTRLVmpkSG9PZ2NMOHc2NlMrMDNtWXZjY1ZGVlBaRTJHTFRUbDRO?=
 =?utf-8?B?cHUzTXZ3MFNTbnRoTVZWY245MjA5WnQvbmVuMVBLQkZValNvdVVnRlFWRHB4?=
 =?utf-8?B?ZXlKTG5QeGJmYUZicjdiVDlRTCs4MklRZ3B2M2JHM2hOMDRzcGwzNDhpbXR6?=
 =?utf-8?B?NzBxOWhPanQxMmJOTS9tK1FzVk02b3dEdFJMUXRPcW5BMWgvbWo1YWFRelJR?=
 =?utf-8?B?OEV3SENmUE1vcFczMmd3RUlxdVEzMG1QZmJCb3lzVlJnU1BoN2tpajlGdU1R?=
 =?utf-8?B?aEdQUlU5RjNUbWtnUXdnYkhUeEtsdU9YL0lOczZsRDI1M0pXNnoxODlPdHV6?=
 =?utf-8?B?ZzJsS1FuU0s5dldaNDRNZ0pJOExZR0FSK2xvZHhtdFUyeUUrMjEwMkJNcVFM?=
 =?utf-8?B?VFAxakpYWFkzSmpGZXM4M3gzTkNQU0RsOVdjVUNqbDlteUMwbkl1d0dIRzFt?=
 =?utf-8?B?bW1aVnVSOHZKdk9NN2JQN0hhOXVONjlhVC9kQzFNUTAzOStXRzREWXJXRkRM?=
 =?utf-8?B?dW5MMzYwbVUvK0FsN0xnS2hKOXRPL0JlWGcrVy9oVjdtOEFTUCs4a2JXMHFm?=
 =?utf-8?B?c241bWM2TzBzanZXRWpxOGRQQ0R3dXR5S1dTUkVWanpXcmNOSHNtellnNWs1?=
 =?utf-8?B?NFNpNjdMcnh0V3o5RnVMRkFuaHhFeWdud1k1MEN5emdTeUlXaWFZQ3FDZkdJ?=
 =?utf-8?B?N0tEYWgzQmpDaVk5NVRJZXpEOUgzbVRVd2w0dlQwRHZqZVhORFpHdW0rT3Nm?=
 =?utf-8?B?NFdSZjJuYXRRZ2d1c0xDK0xudXlXSUVrcmlqaTdiNit6UDZmcWJJbzh1WGtD?=
 =?utf-8?B?TWRycGgzazREaU5OQklQeFlpUDZMbW1QN3h0NGcvY3dIckhoU2I3aS9yaGNC?=
 =?utf-8?B?eDZ0dTBEWk9hVjZrcXladjNsR2RoVEswdC9YY0hjWjREemJ5S1MrWjJkRDhV?=
 =?utf-8?B?cm5oVzZWWGN2YnhMSndtLzVQeURrOVFicVUzNkFUTDBHQk9SWXZ0ZTl4WjZt?=
 =?utf-8?B?dEt6YzNqOU9rSDFIZGQzbFBIeWRvcFhyM05BaVRTK3RpWGdWU25Ba0IwOTI4?=
 =?utf-8?B?NkQ1UlVqUFFqM2o5NkdjTUJrUHlYb0pwRG5pOUtRUEd6Ui9FamMyVFBwSVZT?=
 =?utf-8?B?SS84dTJ4dDlCdG9hSENIR2tDa1g1aXpiRXAvN2dPNkt1TTNSNlFxZEVTMVlX?=
 =?utf-8?B?cEVCT2NxTk1oR0lDQlViMGRxK1V3OWllWkRmaHlZZDNSQTV5SWUydTlTdll1?=
 =?utf-8?B?M05QSHZ6bHVhT3VtVnJwK0s1RWlLU1l0eUpxd0hjY2VObkNDeHRUK09mT1pL?=
 =?utf-8?B?NW1VYnNCcFNwWVEvb2lhRU9IWmt6c3AxdFdmOE55bG9aTkI0R0t6WTlYaWxo?=
 =?utf-8?B?VjV3aFJ1VmVWMU5jY0ZtbG4ySFZWK25vZWRpL2V2aWxEaHdUYVhoTVU0NUtT?=
 =?utf-8?B?TERNa3p5U2RxejFmVnhKelRidm1DNnhCdmVBMGF1VVdPRnJuSkd3eGU5d3hw?=
 =?utf-8?B?YlhGOHpZcFVLMXd4NENSVlQyY0FYOXlyWnQwU1E2U0JPZ0d1T1NzaUFrQndC?=
 =?utf-8?B?YlppRU1jNVdlblJocHQxWHd5K3QxQ1pVbDg5QUQ4MWZTWWtpSHJZTFNXaTdW?=
 =?utf-8?B?eEdQYXVkeUNjRlQ1d2RhYS9LRXNjMjg3WitTVGlpT2F0NWV3bnhiN0xaR2h0?=
 =?utf-8?B?UWJjUUpxaVRoS2dKa3hIb3VSYWJzalJvbHQ3QXBDRGlUQnU1b1hrd25WZUxT?=
 =?utf-8?B?eTM4OFV4bmltRWJ2Q0NhaGRzdlBKWWtOV1RVY3lCd0hpOXZYQ3k4UzFySW1M?=
 =?utf-8?B?L1AyYXVEc1VWanY4VnBGNE1VWFJhakoxU0JFdEpVL3NXN2I2Rko2Y3FUVkU3?=
 =?utf-8?B?Y0RiWmYxYitFWmpjMFZ1eGNIdTJVbkc4UlpDaFg1WGxCejNNcGlTZUJES1FD?=
 =?utf-8?B?dyt6MnY5bExRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnhyTTkvMXdmQmU3K01vTGJ0cVpoTmE0WjkwSE5QUnB0b2hDR1V2RHNFTjZ6?=
 =?utf-8?B?WHRyQkJIVG5wUnZaSGZWbjhGMDN2SkcyT1NSVkdBVzNOM1VWRnFwZml6YUhl?=
 =?utf-8?B?U2YycHZkL01WdlZET29HSVVrcGZueXVsVTVlZzlOMUZndTNJaTRISVMxVXhV?=
 =?utf-8?B?aC8rYTlGS1pFSlJtb2luM2tLcXlPYzVTZ1BMK2hWL2tYWk9uVHowUkw1MnlD?=
 =?utf-8?B?b2c5MFJKU2FFRU9nZnJ6emx3a3UraGVRUWpESkN2QjJwQUdUWkNUWlhULzcr?=
 =?utf-8?B?bmtaOVhrc1JKTW8rdklpeCtoRVZROWQ5cXkwakV3VkVMcjl1MmZZTTlRKzB4?=
 =?utf-8?B?TDEzclUxSkN5MGl3ajdiRFVaenJKZnN4ZlZROGVsMUpQeEh2TXRpaG0xZjN2?=
 =?utf-8?B?bzFReDg5bHdjVUw1eXpJd3NhcUxURXpubU1nOHJTZlFWZUhoejF5T1hzR0RE?=
 =?utf-8?B?UmNjQ0hDQWpjbzZYdkJYLzkvY1JBb3hjQVZ4ZGF3d0FUWTRLaURQNmY5cysz?=
 =?utf-8?B?dXlHUTR1ZkVHQmxWK0JYOG5tSnlWNHBsRDRhd0labm9obzdMenJydEhHdkt4?=
 =?utf-8?B?RjR5VFRoQ2dyWEFOQS9jTlUyR3dGZnJlNmFIb2FCaEhySEdnSmVRQnF5cEUy?=
 =?utf-8?B?N3RVSFlnaVZEYk85UXlGdW9tVlRzeEdaUGdkdkc0U1RzU3RQbVRLcUZuTWx1?=
 =?utf-8?B?cWRwb0xvMk1VdEJFRnhLR1FMOEl5S21xcVQzOWVMWVBtL0E0c3NyZFVNSE12?=
 =?utf-8?B?Qy8zQVMwUkhoUmM4WTE2VUZCM0ZLSlkvSzN1b0Jjd2lNMDkrL0xaMG5DRDln?=
 =?utf-8?B?ZWFHYVcyTXdmU1dRMUhieTdhOXlGSjJ4MTFOL3J1SlNtZkl4U1VnUW5wcDRD?=
 =?utf-8?B?RUJvei9YeHNsVmJtbkxOT1dvWVBITENDNnNQV3I5Rng5N0h6Y3krcGdRQVI0?=
 =?utf-8?B?UVRsQzdRck5kUVFvN0NQdEMvaVF3OXE5MDFPMVlaTHJ1dHlXaHBiR0xBMjFT?=
 =?utf-8?B?S1RxZjIyT2N3ZllmczVpd05FSHRXcGhFUnE0TWY4WjhTcDZPemsxSEhTWG5G?=
 =?utf-8?B?alNBdFpOMjhuMDcrTWREQ0tPVXBlUTRWRy9lb1VBQ2dEak1ZT1NlMVpHUEZM?=
 =?utf-8?B?V1liN255aXJFVG1tS3E2MzRkR2xkOWplaWw3eHk5RHJWcVBvblUzY1VOYTVz?=
 =?utf-8?B?T3AvWFVtaUdlOGRKUWtNVmhWTHo4eVRSRk1pYTBISi9LOXZkOEEzaUgrc2Z3?=
 =?utf-8?B?cTJSR3VBRERBeXh4ODR3ZGNzMDFhdHdYbkhDME9mRVM4UjRoV0JOYkRINHJ1?=
 =?utf-8?B?aFVGcDFJNHFLUWhRYjVQRXUwVjk1M01QUFhWcitsWnY2K0UrdTBsdklzYnZT?=
 =?utf-8?B?dFpnaHRWVmpnNnNLRUlBVE5ja3pyUko0SU45K1l4T0tlOFVjYWhVNjMxSE9Q?=
 =?utf-8?B?MysrY2VTTVlVTHkrSmZlNVNoTUZpZTFpdjZ6VGdBQW9KZXpwTnIzbnIxdjZE?=
 =?utf-8?B?ZTNHU2RwT2h1N2Y4S0dYUXlTUmhSRVRCd2RaOEVSQm9YY0RsY1RNWkNtbzdh?=
 =?utf-8?B?bmEyVG5hVEl2V2Q1bVRGNHR1cVM5cVhxYkIzLzhlNDVYdjhuaHpJQXlYcXlx?=
 =?utf-8?B?T0tFNE9xais2cmpWa2ttaS9aaWg1Rk1WcG5WNm96OHZQQ2NNQWZCdEZidXor?=
 =?utf-8?B?QVJHUHhWcHMxOW1iNllXVlFxYzZONXNMNGExUDhoN00rWThYMHI1TnlkNS9x?=
 =?utf-8?B?QTNDVmtJa01laEJiNEMzbEZjbjdFNFE4WHpsdGRQMWN4OE9RUDIrQ3FHYkZw?=
 =?utf-8?B?ZUFIdzN0MXJ3MFZVU2Y4RFJTV0RZSWx4bFFjWUwwY1JLNmczU2lEZ3VmN1dK?=
 =?utf-8?B?RWFjNS9mVitrVDI0cFlNcmljSG50SVF5UXdyU1huWDVaMkkrMUpKOTFHWHh4?=
 =?utf-8?B?Nnh0RzR0QTdzSkpOaDZYN3VPZ0YvYmRlRm1WTU8vQTR1UTlQYzU0Y2NkRFF1?=
 =?utf-8?B?cmNjV2ZwVjdJeDRPazM0YnA1cFpabTJ5U1lzbksxMGpXTldhc29jeWZNeE9M?=
 =?utf-8?B?a05ZL29kbmRFRGozZmhUS3N6ZURtblNXM2dMT0NiYlFWOGZJdXVkdDNGNzFU?=
 =?utf-8?B?bEJIV1JibGlLTnF6S1luNEp1NThSY2hoOWhmcWFCUjY0U1lKY3dGNzVWYndM?=
 =?utf-8?Q?PrbSxack4fw1V3o1vB/Lx7A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <941855DC62236344B024BE13A02BFC0C@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c518b304-d6b7-4d79-4dd3-08ddae3d7adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 07:55:23.3952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFADjhNdEOJYrWaeMpVKL2x6gWD65vJv9uaj9DOzyspEqhrIQWx07i6c9PhoVUvF8qlvPvsQaE7vjooaJvS2BM9O4Z7sHaVf8pTjipAHqWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB4230
Received-SPF: pass client-ip=52.101.66.85;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQpPbiAxMC4gNi4gMjUuIDEzOjQyLCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiBbWW91IGRv
bid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGFsaXN0YWlyMjNAZ21haWwuY29tLiBMZWFybiB3aHkg
dGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50
aWZpY2F0aW9uIF0NCj4NCj4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0
c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250
ZW50IGlzIHNhZmUuDQo+DQo+DQo+IE9uIE1vbiwgSnVuIDIsIDIwMjUgYXQgMTE6MTTigK9QTSBE
am9yZGplIFRvZG9yb3ZpYw0KPiA8RGpvcmRqZS5Ub2Rvcm92aWNAaHRlY2dyb3VwLmNvbT4gd3Jv
dGU6DQo+PiBTZXZlcmFsIHRoaW5ncyBpbXBsZW1lbnRlZCBpbiB2MjoNCj4+ICAgIC0gQWRkcmVz
c2luZyByZXZpZXcgY29tbWVudHMNCj4+ICAgICAgLSBTaW1wbGlmeSBgdGFyZ2V0L3Jpc2N2L3ht
aXBzLmRlY29kZWANCj4+ICAgIC0gUmViYXNlIG9uIHRvcCBvZiBsYXRlc3QgbWFzdGVyDQo+PiAg
ICAtIEZpeCBjb2RlIGZvcm1hdA0KPj4NCj4+IERqb3JkamUgVG9kb3JvdmljICg5KToNCj4+ICAg
IGh3L2ludGM6IEFsbG93IGdhcHMgaW4gaGFydGlkcyBmb3IgYWNsaW50IGFuZCBhcGxpYw0KPj4g
ICAgdGFyZ2V0L3Jpc2N2OiBBZGQgY3B1X3NldF9leGNlcHRpb25fYmFzZQ0KPj4gICAgdGFyZ2V0
L3Jpc2N2OiBBZGQgTUlQUyBQODcwMCBDUFUNCj4+ICAgIHRhcmdldC9yaXNjdjogQWRkIE1JUFMg
UDg3MDAgQ1NScw0KPj4gICAgdGFyZ2V0L3Jpc2N2OiBBZGQgbWlwcy5jY21vdiBpbnN0cnVjdGlv
bg0KPj4gICAgdGFyZ2V0L3Jpc2N2OiBBZGQgbWlwcy5wcmVmIGluc3RydWN0aW9uDQo+PiAgICB0
YXJnZXQvcmlzY3Y6IEFkZCBYbWlwc2xzcCBpbnN0cnVjdGlvbnMNCj4+ICAgIGNvbmZpZ3MvZGV2
aWNlczogQWRkIE1JUFMgQm9zdG9uLWFpYSBib2FyZCBtb2RlbCB0byBSSVNDLVYNCj4+ICAgIGh3
L3Jpc2N2OiBBZGQgYSBuZXR3b3JrIGRldmljZSBlMTAwMGUgdG8gdGhlIGJvc3Rvbi1haWENCj4g
VGhhbmtzIGZvciB0aGUgcGF0Y2hlcyEgVGhlcmUgYXJlIG5vdyBzb21lIHJldmlldyBjb21tZW50
cyAoc29ycnkgZm9yDQo+IHRoZSBkZWxheSksIHBsZWFzZSBzZW5kIGEgdjMgb25jZSB0aGV5IGhh
dmUgYmVlbiBhZGRyZXNzZWQNCj4NCj4gQWxpc3RhaXINCg0KVGhhbmtzIGEgbG90IGZvciB0aGUg
cmV2aWV3IQ0KDQpEam9yZGplDQoNCg0KPj4gICBjb25maWdzL2RldmljZXMvcmlzY3Y2NC1zb2Z0
bW11L2RlZmF1bHQubWFrIHwgICAxICsNCj4+ICAgaHcvaW50Yy9yaXNjdl9hY2xpbnQuYyAgICAg
ICAgICAgICAgICAgICAgICB8ICAzMyArLQ0KPj4gICBody9pbnRjL3Jpc2N2X2FwbGljLmMgICAg
ICAgICAgICAgICAgICAgICAgIHwgIDEwICstDQo+PiAgIGh3L21pc2MvS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKw0KPj4gICBody9taXNjL21lc29uLmJ1aWxkICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4+ICAgaHcvbWlzYy9yaXNjdl9jbWdjci5j
ICAgICAgICAgICAgICAgICAgICAgICB8IDIwNCArKysrKysrKw0KPj4gICBody9taXNjL3Jpc2N2
X2NwYy5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjI1ICsrKysrKysrKw0KPj4gICBody9w
Y2kvcGNpLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE1ICstDQo+PiAgIGh3
L3Jpc2N2L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDYgKw0KPj4gICBo
dy9yaXNjdi9ib3N0b24tYWlhLmMgICAgICAgICAgICAgICAgICAgICAgIHwgNDg5ICsrKysrKysr
KysrKysrKysrKysrDQo+PiAgIGh3L3Jpc2N2L2Nwcy5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAxODcgKysrKysrKysNCj4+ICAgaHcvcmlzY3YvbWVzb24uYnVpbGQgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgMSArDQo+PiAgIGluY2x1ZGUvaHcvbWlzYy9yaXNjdl9jbWdjci5o
ICAgICAgICAgICAgICAgfCAgNzcgKysrDQo+PiAgIGluY2x1ZGUvaHcvbWlzYy9yaXNjdl9jcGMu
aCAgICAgICAgICAgICAgICAgfCAgNjkgKysrDQo+PiAgIGluY2x1ZGUvaHcvcmlzY3YvY3BzLmgg
ICAgICAgICAgICAgICAgICAgICAgfCAgNzUgKysrDQo+PiAgIHRhcmdldC9yaXNjdi9jcHUtcW9t
LmggICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPj4gICB0YXJnZXQvcmlzY3YvY3B1LmMg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDI4ICsrDQo+PiAgIHRhcmdldC9yaXNjdi9jcHUu
aCAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDkgKw0KPj4gICB0YXJnZXQvcmlzY3YvY3B1
X2NmZy5oICAgICAgICAgICAgICAgICAgICAgIHwgICA1ICsNCj4+ICAgdGFyZ2V0L3Jpc2N2L2Nw
dV9jZmdfZmllbGRzLmguaW5jICAgICAgICAgICB8ICAgMyArDQo+PiAgIHRhcmdldC9yaXNjdi9p
bnNuX3RyYW5zL3RyYW5zX3htaXBzLmMuaW5jICAgfCAxMzcgKysrKysrDQo+PiAgIHRhcmdldC9y
aXNjdi9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0KPj4gICB0YXJnZXQv
cmlzY3YvbWlwc19jc3IuYyAgICAgICAgICAgICAgICAgICAgIHwgMjE5ICsrKysrKysrKw0KPj4g
ICB0YXJnZXQvcmlzY3YvdHJhbnNsYXRlLmMgICAgICAgICAgICAgICAgICAgIHwgIDExICsNCj4+
ICAgdGFyZ2V0L3Jpc2N2L3htaXBzLmRlY29kZSAgICAgICAgICAgICAgICAgICB8ICAzNSArKw0K
Pj4gICAyNSBmaWxlcyBjaGFuZ2VkLCAxODM3IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygt
KQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvbWlzYy9yaXNjdl9jbWdjci5jDQo+PiAgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBody9taXNjL3Jpc2N2X2NwYy5jDQo+PiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBody9yaXNjdi9ib3N0b24tYWlhLmMNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L3Jp
c2N2L2Nwcy5jDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L21pc2MvcmlzY3Zf
Y21nY3IuaA0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9taXNjL3Jpc2N2X2Nw
Yy5oDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L3Jpc2N2L2Nwcy5oDQo+PiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc194bWlwcy5j
LmluYw0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L3Jpc2N2L21pcHNfY3NyLmMNCj4+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9yaXNjdi94bWlwcy5kZWNvZGUNCj4+DQo+PiAt
LQ0KPj4gMi4zNC4xDQo+Pg==

