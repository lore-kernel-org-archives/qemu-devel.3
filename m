Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826EEC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 05:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbZA7-0007SQ-3a; Wed, 07 Aug 2024 01:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sbZA3-0007OQ-Nw; Wed, 07 Aug 2024 01:24:36 -0400
Received: from mail-eastasiaazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c400::2] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sbZA1-0007Vy-Fs; Wed, 07 Aug 2024 01:24:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9IEZE7vfib49a/nimbgBSjoVFBnXmKuvkHbLt5QnXjdvtuGQpjhnnBWkD+bsWUz2FOhycFfAZe0AmZReKOLkKvZ/QYfWwVaCGBO3v/BQ9UPUTx3x7CCMT4F2FwFlvkg8+D/FASsPjLFznrpUWmyvNH0wUjnWmwZKV5zRFqYqg8eEi8hbsj5QsBd5GlRFIVLi6kBq0XARUoBtopLS1ZFY61mDc0MRr3pJwYRjks9/wHILVBKNIH68qiOErkidpXQSjuCM8Mu47yqd/wnikfTso785KjXwFU0KM7jNv8R7pRtfLODoclLqM8cQV1J4bHaAVHFz8wBW5YdEId3tK3BFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaLsyZFUQ59Beb3S2Cv2wnvvN8bWIK+2rucwDll7VJo=;
 b=Q0LSXgZwDBNymyf/gfJxxWUjmlle9cEdpKy4dZMqS/umSPjGin2KR5zl2kh1NfS3CVnmQt+PeS3ZpbZWQ24KjLFvBotpHrn2NqbTzzpjfuUkrNUy8VhtYfkdq4XTd9UUU2FbFoEDbSVHsqJNtXLvqEw93gfMYl3v3RdRcufLtNZskCKyGpbggzhhQBdzODX6aUgW5YkHOfiACGo4UsDO129U56RPC8GSfmovLjsYa/NcMT2O1/5CsyaTRVK5RwFzvwclRcvyq6v01NaPeRIjg9Qrw4neYEaXCoxZoHD4ymalOd4oLdad6BWj/Oo5LkfIXcqjONL2w3jQ5IfD/reklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaLsyZFUQ59Beb3S2Cv2wnvvN8bWIK+2rucwDll7VJo=;
 b=cfgfHVgrZZfP9E+CAixbtUGPUIVg8F6BoJeYzw4GDviuzBTzuZvegHroLBXDaNaSskKSED77h28JkOW+RRZ8Fsm5WVn8hbiE6N/Wtx4gPp3yJOfVawEggz4la82VlLirY6PmsnxzeZYAImU2zGhgw1PVaE8V3lSOTSEaSy1AtqYUphrVj9j243Gtz6ue65CuFzaAvUyH+ECVPLMscNQsOwoT+f5p7k4BatQD2GpvALphJb58LCiEcWBY+NYe46Kr2P4PejNL64iQBQkBpbKynNRnBnRyRoGp9REqkVjDuHq0WXyIjdEH9wuUJ2TZJlFjRcL/92mhPRSdYGXL0ZSrlw==
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14)
 by TYZPR03MB7060.apcprd03.prod.outlook.com (2603:1096:400:337::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 05:24:19 +0000
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e]) by SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e%6]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 05:24:18 +0000
From: =?utf-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alistair.francis@wdc.com"
 <alistair.francis@wdc.com>
Subject: RE: [PATCH v3 0/2] RISC-V: Add preliminary textra trigger CSR
 functions
Thread-Topic: [PATCH v3 0/2] RISC-V: Add preliminary textra trigger CSR
 functions
Thread-Index: AQHa2z8N65m+CRbsW0exZ+hITwnfAbIFLxwAgBYrZCA=
Date: Wed, 7 Aug 2024 05:24:18 +0000
Message-ID: <SEYPR03MB6700421A6AAA65C5F310ED99A8B82@SEYPR03MB6700.apcprd03.prod.outlook.com>
References: <20240721072422.1377506-1-alvinga@andestech.com>
 <CAKmqyKN2hnN+wQzx3bdcFjEpo1R_rW23mR9OiCE8goJJ198-xw@mail.gmail.com>
In-Reply-To: <CAKmqyKN2hnN+wQzx3bdcFjEpo1R_rW23mR9OiCE8goJJ198-xw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6700:EE_|TYZPR03MB7060:EE_
x-ms-office365-filtering-correlation-id: 9736382f-74c5-4111-78d1-08dcb6a12fd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R1JQWEhRU0hIa1l1dkVPUTVTNGo1b1BUdXFZLzl6bUFUdXBFQ2lPN1gvUTRF?=
 =?utf-8?B?U2FJUCtzcHdFZ2k0dko5ZUVvaHMxWkVvdHJ3RWJGS0U0S3V6WFJtUjhBNFZY?=
 =?utf-8?B?QzdIcC9lMEcxMnpBTzM2VUV2SXBSTS9FZldyVFdWbE9NZkVkajNubTJma0l6?=
 =?utf-8?B?VGZic2U5bDZUaktSa1RTMWxtNksydTNpYW55U0JoNm9ka3NXN2ZmZUo5QktO?=
 =?utf-8?B?czFhdkpDQWF5T011OVR1R1pJMitQZjVSY1NvU1IrY3pyK21Yd05IenZxMlQy?=
 =?utf-8?B?aFUyT05LcFN3eHhHWTJyZ0xBN3IvNTBKNHp3Vnp1aWNxd0pHRFpOTy9KZDZi?=
 =?utf-8?B?S2g0S1NmRENRVXRXUjVNVSt0YWN1QVlBRDdLMGxHSHRueUJyeHRDVW4rbHVN?=
 =?utf-8?B?bG43OFhJVFBkanpiWExXa0NjeE9RZklneUEybHVHMnJrbHpLYS9ENWttK3Qw?=
 =?utf-8?B?SmZUQllRS2s5UVIzZHZtS05HUjM1MmJUK0RCWWpUTjJuL04yT2RQa0lMUkNy?=
 =?utf-8?B?YnNPeEM3UmlxOE5VT3Y3b21UWldGN1lVai9BcUhvcU8veWRQM2tmU3VwRzVZ?=
 =?utf-8?B?RUNuVXVBeTZnS2RHZlNQUXZzZjYzVG54OFFQcVlUTjMvTW1lVHp4L2kxY1o1?=
 =?utf-8?B?Q2VlMmpVY2VIbmd6elVIZzJwb3AybDhmODZXUGkraE9ReXpQMGdrR0lJQU00?=
 =?utf-8?B?b082aDB0Z2l3MHhWcDhNQStIOWpMeElKVkk1OEZBdjB4cmw4UzM5T09TeUJO?=
 =?utf-8?B?K3ZnTnFRR1BidWdjbElrK3lhM2t1eTlOdi9yZGhlelc2UGpla1BqZThoS1d0?=
 =?utf-8?B?NE1mSzRjaC84c0IyWVFVQWpqT3hJbmp5MnlGbXlhYkpEWkxKekk3RUhBQVR0?=
 =?utf-8?B?dmY0bXVNM29QZkQ1TmNhU1E5MkJwNjl6UWxkWktRTlRoeExsZERrZS9Hdmxk?=
 =?utf-8?B?YStQVWZIV3AyUzVNRnhPN0hPYWZkRG9TZHM4OTFGaHBFL1hSbHB3ZzJBczRN?=
 =?utf-8?B?VE81cnptdC9kQkJpZ3lQOVRIQ3pRbVZjbVNYQVd4U21Rb3BTN09xaXF4dHpv?=
 =?utf-8?B?MCtmUVlLcmtURFFjMzFxclR1cS9NdkVYajExeTVtTW9jSjRaUU1uME1vaUd4?=
 =?utf-8?B?NkE5ekNPNDdvOWJ5Z2l3YURpWDFjK2I2cDR5VGkvcUpYZzEzUnc2Z2NEcm9l?=
 =?utf-8?B?RzlySGdhbVRYVkZpYWl0ZXVTenVxVWtzMEZnNTcxbk9NRW5PYTBmelpwTHdR?=
 =?utf-8?B?TzZGNzVueUIyN0xSRTNLV3VOM29sMjBaNjE4eXRzVEpuOEM4bk9haTZtQlBa?=
 =?utf-8?B?WkF4ZU5BOHdmM3NTUnJXeUJpY1g4TDh5MzJaaG5qSWp1cmVtOGxpRUVTQUlK?=
 =?utf-8?B?WWtLRXZsalBJTGJHbS9NS09jMkJBZHpnRW5oVkhTLzUwVHlvaVZvVFQvWnkx?=
 =?utf-8?B?aVp6Z2lxQThYdlN5d2J5cGNLYjVLbjFSMXBidy9KQ1hJZWk1RCtsS1RORGZS?=
 =?utf-8?B?QWJJajQ3aGRXeDdhWEFTeisyUWx5VkZ4ekpUMldaZVo5SEQwZ0pEV2NGc3Ex?=
 =?utf-8?B?SGsrdU9oSWd4RTMxcFZyamg3ZDkzb2FlbGJRdWtwbVh5anJsNjkzUlNId3p0?=
 =?utf-8?B?NmR5cGIvSjVpeVhuTmVNR0NOZnhVQTdWejl5U0VrejlZeHFVaStsQ1M5K05n?=
 =?utf-8?B?Tms2L2o2N0YxV1g3MHVWVVZCcktPYm0zYjFLcUpicjBqc3k0Y09TcGEwaHJr?=
 =?utf-8?B?ampzZDl1K1d0VUwxQ1ovM0x4aHpHS1V5azdvRENZOFQvMUJFaEhQaHBLa3JT?=
 =?utf-8?B?UDRTOFR6S2dOMENyZVBBM3BKMklTMk9HVTFFMk1rWmp1b283b01PbWxmUkM2?=
 =?utf-8?B?bEsxZG9MSjlnNXNUVU01UGpaRFMyMUJ3ZE1PSHUxUVV6cXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR03MB6700.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1pOMUs0cTNiOWs2MnBmYmhBQ2lQck5MbEV5ZFd5S0N5OWlNdllWYmNBOVJ4?=
 =?utf-8?B?UlB3NFdJazExTEJvaStsUWlZRlFPTTN2czNnMWcrYUNYL1RGRmIwcE05WFZQ?=
 =?utf-8?B?SDBwbzl2aWJ6YW1lVGFBdWFjMS8xVUlUdnAzN0h0dVBBeGxzVXVCdk1aa2tI?=
 =?utf-8?B?aHViWGhuTDA0bldRK3ZYYWZ5Q2pxcmRLekkwYlFCNGVoNDU3MUJQNlo5enRh?=
 =?utf-8?B?SkhRRWVpRk5XWk15c0E3blpoQ1JsRThueEFLNXoyLzNaQnVrZHJTS2xUNkVT?=
 =?utf-8?B?TmdkbTdVSDhENkYwekd3TnBlakNBaUNBaWZxT2xVZkdkekttTy9DeTZKbVJZ?=
 =?utf-8?B?WEhuRDAvVHZvSUxDblo0SU53WURtZHB3OGkyWFJuRWM5ZGRMUzcvREFLZWx6?=
 =?utf-8?B?UUZzMEEwVjBtaFlLcjFkQVNYSjg5Nm1QdTN3a0xEVDErRnNOM0FFWDROTXNw?=
 =?utf-8?B?U0N5MmQxbmVPSE1paSszUkN2b0JCWmgxSWRla2llUzgvM3ZVS042cW1DTzFJ?=
 =?utf-8?B?WWpJVzRLVTVVcVA5SDJ0d29RNEc1eVl6ejBHNnY0WEl6QTFzNkxOdDRkRkt5?=
 =?utf-8?B?ZXVJYWcraVo5VTE3QVc3aW9USU9BTy9KM2Nwemo4bEw5bWdPenJTZ1NFUkdi?=
 =?utf-8?B?RHgvdC9rMU5BTExFbjRVT3NvMjM2MmsyaGlSRUJSWFVST005WVc5N2d2VzBK?=
 =?utf-8?B?Yk1HQzgvSE1LMzZyRDZXVnF6NHFpdnR6R0grbFBvcHN1NlU1Tko4Q1U1WWpZ?=
 =?utf-8?B?QmZCTUlLSDVMNUpsQWJkRmpYdk5wSzlicE4wZjlReE43ckFoTTh4QlB3MFlx?=
 =?utf-8?B?TFc3REtTRG11T0ZUcWFGdzFsOEtzdlBlZGxTWlFONzFzM3VqMDA1NEhZZ0xY?=
 =?utf-8?B?NWlMNHFneUUzS1NpekZ0VG9oVXlXdTZWV0lkUVdobjRvcXc4SGx6WVZTTkV6?=
 =?utf-8?B?eGtac1M1aE1XdG1NZG8rYlRxbXdZbGViVEY0Y3hqZkUrRVJSLzM4MEl5SEVo?=
 =?utf-8?B?c1lhYUdyMWgrTU81SFBGM3pLcUdYMGJmbnM4VCt4OWFPcmtwblZLZ0d0S1Yv?=
 =?utf-8?B?a1FpcUFBeDkwK3JLT1M2bk5mN1NhSnRwSXNRYWhGZjg4SXRoTXRaZFNCMXdR?=
 =?utf-8?B?NVJpWTBpN0gxNll4R1A4WVNZS2tVYlJjc29BUmRrOGpUMVgzMkNFbzg1Qmda?=
 =?utf-8?B?U1ZnY1NvSEN0c0pucnFjMGdPTlpYN2RqS3gzUHdVT3EzZSt5alhqd3Q2WlE3?=
 =?utf-8?B?NEpsdWd3ZzhDT1ZrTHJpRmpYaTlwdHB3Y1g5disyeGI3YTRmODVUTUJ3TWtv?=
 =?utf-8?B?ZXhmaWFFUzUxKzhEZ2RyM1B4ejNaTHlOYjNyQ3ZieWRiZUpEckVoOTFlSU5C?=
 =?utf-8?B?c1VzbDNQRXF2R2VwQzd4V2FVSEhqVEtNbVA4TkpLeDJSelE5amQ2bWdEdGx0?=
 =?utf-8?B?NlcvSmVITFY3cVpMQytmUXJ5K2NkTE5zY0hpOWU0QnpiRkxiSlhCQTJ1MCtv?=
 =?utf-8?B?NFFWMFRJWFBYYXg2OVJHaUZkZkNnSitNb3VsOWhONUR2aUVMUkZ5T1Mzd0M2?=
 =?utf-8?B?VVAwMk5SNDBGZ2tWVEJ4cmF3WXFON3lxY0FPeFBKSVlGdGVxWlVjSXBYblYz?=
 =?utf-8?B?b2FqM3JOWXZ5ZVVkWVh2Q1JsQ09ObndtMS9BbjRwK2poemhhZWc4OGxYYjFL?=
 =?utf-8?B?SE55YTBxVFJqV2lpR1NORlh1NXZEU0hKWkZOS0hUS2wxaXFHUkhHMnpINlV3?=
 =?utf-8?B?RG9zNmxWQWNBM3RoWlB0cDYrWHNGbStwMXNPRTY0VVF0bTFPcTQvcUpTVG1V?=
 =?utf-8?B?Zm9yZ0tFVzlXNm5ZbXl4R1VKanI5Yi84OVhqK25uQjg5dko3dVVWS1ZCWURO?=
 =?utf-8?B?Q3l0TzN4TmwvQ1Z6WDc1SnMzMTlnWWZmU3N3bTgrMlpVM0xtSnk0NDZmZHo3?=
 =?utf-8?B?a0tDK3RJT1RTKzlyM2QxVHBUVFIwcDk3SXo5cVlTZUFqSGJoNlRKZGtUSDdP?=
 =?utf-8?B?Tkw5R25FcDh1bXhUN2lKL1o3RTMvTDZHblNxS2o5YUtRRzdTczB5M2diQTUz?=
 =?utf-8?B?bEFPdlFMR0lLaXljVUZhd3VWU0tXRXdSdE1BNEJNaFdqN20wNE9sWDVUK2lO?=
 =?utf-8?Q?lLAzg/FPqk5H2SZZk2250hj7N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: andestech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9736382f-74c5-4111-78d1-08dcb6a12fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 05:24:18.7934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HAUG6DX/4zVr2S4LHKoDTPmmfvgw3cn8WY+w4PzLZ3oHn2iNFGj87dgkkPIk50RHdD1+3+ZwtXmcYptby+NXzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7060
Received-SPF: pass client-ip=2a01:111:f403:c400::2;
 envelope-from=alvinga@andestech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
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

SGVsbG8gQWxpc3RhaXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
QWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIyM0BnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgSnVseSAyNCwgMjAyNCAxMDo0MCBBTQ0KPiBUbzogQWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by1
5ZOy5ZiJKSA8YWx2aW5nYUBhbmRlc3RlY2guY29tPg0KPiBDYzogcWVtdS1yaXNjdkBub25nbnUu
b3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbTsg
YmluLm1lbmdAd2luZHJpdmVyLmNvbTsgbGl3ZWkxNTE4QGdtYWlsLmNvbTsNCj4gZGJhcmJvemFA
dmVudGFuYW1pY3JvLmNvbTsgemhpd2VpX2xpdUBsaW51eC5hbGliYWJhLmNvbQ0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYzIDAvMl0gUklTQy1WOiBBZGQgcHJlbGltaW5hcnkgdGV4dHJhIHRyaWdn
ZXIgQ1NSDQo+IGZ1bmN0aW9ucw0KPg0KPiBbRVhURVJOQUwgTUFJTF0NCj4NCj4gT24gU3VuLCBK
dWwgMjEsIDIwMjQgYXQgNToyNuKAr1BNIEFsdmluIENoYW5nIHZpYSA8cWVtdS1kZXZlbEBub25n
bnUub3JnPg0KPiB3cm90ZToNCj4gPg0KPiA+IEFjY29yZGluZyB0byBSSVNDLVYgRGVidWcgc3Bl
Y2lmaWNhdGlvbiwgdGhlIG9wdGlvbmFsIHRleHRyYTMyIGFuZA0KPiA+IHRleHRyYTY0IHRyaWdn
ZXIgQ1NScyBjYW4gYmUgdXNlZCB0byBjb25maWd1cmUgYWRkaXRpb25hbCBtYXRjaGluZw0KPiA+
IGNvbmRpdGlvbnMgZm9yIHRoZSB0cmlnZ2Vycy4NCj4gPg0KPiA+IFRoaXMgc2VyaWVzIHN1cHBv
cnQgdG8gd3JpdGUgTUhWQUxVRSBhbmQgTUhTRUxFQ1QgZmllbGRzIGludG8gdGV4dHJhMzINCj4g
PiBhbmQNCj4gPiB0ZXh0cmE2NCB0cmlnZ2VyIENTUnMuIEJlc2lkZXMsIHRoZSBhZGRpdGlvbmFs
IG1hdGNoaW5nIGNvbmRpdGlvbg0KPiA+IGJldHdlZW4gdGV4dHJhLk1IVkFMVUUgYW5kIG1jb250
ZXh0IENTUiBpcyBhbHNvIGltcGxlbWVudGVkLg0KPiA+DQo+ID4gQ2hhbmdlcyBmcm9tIHYyOg0K
PiA+IC0gUmVtb3ZlIHJlZHVuZGFudCBsb2cNCj4gPg0KPiA+IENoYW5nZXMgZnJvbSB2MToNCj4g
PiAtIExvZyB0aGF0IG1oc2VsZWN0IG9ubHkgc3VwcG9ydHMgMCBvciA0IGZvciBub3cNCj4gPiAt
IFNpbXBsaWZ5IHdyaXRpbmcgb2YgdGRhdGEzDQo+ID4NCj4gPiBBbHZpbiBDaGFuZyAoMik6DQo+
ID4gICB0YXJnZXQvcmlzY3Y6IFByZWxpbWluYXJ5IHRleHRyYSB0cmlnZ2VyIENTUiB3cml0dGlu
ZyBzdXBwb3J0DQo+ID4gICB0YXJnZXQvcmlzY3Y6IEFkZCB0ZXh0cmEgbWF0Y2hpbmcgY29uZGl0
aW9uIGZvciB0aGUgdHJpZ2dlcnMNCj4NCj4gVGhhbmtzIQ0KPg0KPiBBcHBsaWVkIHRvIHJpc2N2
LXRvLWFwcGx5Lm5leHQNCg0KSSBzYXcgbGF0ZXN0IHJpc2N2LXRvLWFwcGx5IHF1ZXVlIHdhcyBz
dWJtaXR0ZWQgdG8gcWVtdS1kZXZlbCB5ZXN0ZXJkYXkuIEJ1dCB0aGlzIHNlcmllcyB3YXMgbm90
IGluY2x1ZGVkLg0KUGxlYXNlIGFsbG93IG1lIHRvIGluZm9ybSB0aGlzLiBUaGFua3MhDQoNCg0K
QmVzdCByZWdhcmRzLA0KQWx2aW4gQ2hhbmcNCg0KPg0KPiBBbGlzdGFpcg0KPg0KPiA+DQo+ID4g
IHRhcmdldC9yaXNjdi9jcHVfYml0cy5oIHwgIDEwICsrKw0KPiA+ICB0YXJnZXQvcmlzY3YvZGVi
dWcuYyAgICB8IDEzMg0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
DQo+ID4gIHRhcmdldC9yaXNjdi9kZWJ1Zy5oICAgIHwgICAzICsNCj4gPiAgMyBmaWxlcyBjaGFu
Z2VkLCAxMzggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IC0tDQo+ID4g
Mi4zNC4xDQo+ID4NCj4gPg0KQ09ORklERU5USUFMSVRZIE5PVElDRToNCg0KVGhpcyBlLW1haWwg
KGFuZCBpdHMgYXR0YWNobWVudHMpIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBhbmQgbGVnYWxs
eSBwcml2aWxlZ2VkIGluZm9ybWF0aW9uIG9yIGluZm9ybWF0aW9uIHByb3RlY3RlZCBmcm9tIGRp
c2Nsb3N1cmUuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHlvdSBhcmUg
aGVyZWJ5IG5vdGlmaWVkIHRoYXQgYW55IGRpc2Nsb3N1cmUsIGNvcHlpbmcsIGRpc3RyaWJ1dGlv
biwgb3IgdXNlIG9mIHRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGlzIHN0cmljdGx5
IHByb2hpYml0ZWQuIEluIHRoaXMgY2FzZSwgcGxlYXNlIGltbWVkaWF0ZWx5IG5vdGlmeSB0aGUg
c2VuZGVyIGJ5IHJldHVybiBlLW1haWwsIGRlbGV0ZSB0aGUgbWVzc2FnZSAoYW5kIGFueSBhY2Nv
bXBhbnlpbmcgZG9jdW1lbnRzKSBhbmQgZGVzdHJveSBhbGwgcHJpbnRlZCBoYXJkIGNvcGllcy4g
VGhhbmsgeW91IGZvciB5b3VyIGNvb3BlcmF0aW9uLg0KDQpDb3B5cmlnaHQgQU5ERVMgVEVDSE5P
TE9HWSBDT1JQT1JBVElPTiAtIEFsbCBSaWdodHMgUmVzZXJ2ZWQuDQo=

