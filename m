Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417B8C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qe-0004cB-4P; Wed, 15 May 2024 03:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qM-0004Yp-IT
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:31 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qI-0000oi-Bb
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757266; x=1747293266;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=SJ1YCWl5qPAPbgtTpbIIOYagtuq+mMLnpiag2CWvi3Q=;
 b=pESl+BuWp7iJ826tKY5E9zFj5Xxe/W6U1+FVV5koEg/zrVLbh9OyOaKa
 nn/PSXi8hDaf9YBKTTfMmeglYZFhSinlMPgL1hR3n4BF6BptxjNFqUi3w
 y6En9IPyITmY2Qq3ULMp8vQp7xh1FEeByXOOqG6b/m9k+1dX+OiGEkWbf
 NQtYfkKlHbBYNL22ouAbOmUp//d1P2M8HkDghbjSSxZxY+hMzT+dQKCsM
 +MYuveIAYaLmLM5pVRzhw81iMayRNCun9nfhDTaOxmyJf5/9zRUEMwht4
 UnBCYTgDr0Y4CbCAohAbYcSfssz4BIWZVzUgAX2d1+y0541A5gdtD4HXu g==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12581800"
X-MGA-submission: =?us-ascii?q?MDHx4whN9SMVnaGGfYV6BBWX1XOENwqbVQjwRr?=
 =?us-ascii?q?3GMD/I9NpWYPl2iRmaeW0wcyCHKaOCzxu7/5290ykULNAyUTbFLU43x8?=
 =?us-ascii?q?ieiuo05xPzkASpAJ6jr+pBhK4rFNq0Wf6jWOOiDkQB2XbWbJBm0q5WSx?=
 =?us-ascii?q?sfcDXYUsC1+VCR+PxE4Ic/Jg=3D=3D?=
Received: from mail-vi1eur04lp2050.outbound.protection.outlook.com (HELO
 outbound.mail.protection.outlook.com) ([104.47.14.50])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:19 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajf136jKUmPKMI9P1Ijy17shvdhEFLSpYgfBehiDfwR0WKa4QqCJr/tcdJqCgwkM0d+C+bxDNFverjo2O88AMQV7pmOyT8KYWFwQYpUXeWJquUQJFHkS4I+f1GrUtc4E6YJpjxd4mziN0ZFqVlkYMu08IvDVwToyIZ3PCosl1WjcSgePIkOka6JP+ZQyjEMZJpI3nQrwERKmmnswFjal+6nlgCVcplLcbyPi9dx891kr+EgOgkh1xLlaXV1TzwkJ6Q0DPsoHW0Ok/t1+tqIO2aM4CMIEXqDIvmnQoR3IYOuhbcrzXcScaYBusutz5Qm26NDu1KZNeKVBUDgiYHlbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJ1YCWl5qPAPbgtTpbIIOYagtuq+mMLnpiag2CWvi3Q=;
 b=GDNmgWlAXCTXodH+jvvFc+dgUHj4mZ6+3oh7x80pPX6pSxQaj2OcweW9A60LNlnXDZuBi3Ga83UroOSp6cPfLxrYo4j5r2HpJbMFW6ChtJOyhgUQYfoXCWAvpfbEiJYmVR3XAjtJfPpluOKyMdaD7IuwYzNDnc3DgmQS7pGyjLobVNHDYUt/U0rgKQDXNAbUFy88RhzXXFk6fXe6NHtvvIS8c8qoKdOyyKW7I6ZWzh0DyttYCJeuGoJHzEZn1Aqg1ibRnDPH7PxDVPJbjSLq2tYOuezUzpHefreCqyR6QXfGG83zOnVP5u1BsGJf5O+knjTE+um3r1St3ut2zW/VTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6718.eurprd07.prod.outlook.com (2603:10a6:800:18f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 07:14:17 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:17 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 14/25] pci: cache the bus mastering status in the
 device
Thread-Topic: [PATCH ats_vtd v2 14/25] pci: cache the bus mastering status in
 the device
Thread-Index: AQHappd/gqJL+7/DAUC7s2Qdjeq8ZQ==
Date: Wed, 15 May 2024 07:14:17 +0000
Message-ID: <20240515071057.33990-15-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6718:EE_
x-ms-office365-filtering-correlation-id: d893a9f5-e861-4dee-a7ef-08dc74aea263
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?M1R3L0Nxd1NmVTlhS2J0aFFUaFZyMWR1cE51MFArRjN5NkpUT1hpL014czlS?=
 =?utf-8?B?UGZ2TU9DVG5Yd0hjT3RJYUh3UWdFRHpVakRKVi85V1RYMEljMERaKzBZeVFO?=
 =?utf-8?B?RUFaWTJ2aXhsQ0V0SkF4Yk9WSnRnVnlhcGNYMS9nSmNMRnJNYWk5QVh3blBz?=
 =?utf-8?B?OHpkZjZLdUU1WHVFVHFNcmxXUW9LRHlvZmNWa0k1SEtEcjQvb1NyZm1DaWkx?=
 =?utf-8?B?RXgyOGh2SmxnTXlWeWFOZTVocjhuWE1UeGN2Y3o3LzAyK2x4YWJSSFdmQTN6?=
 =?utf-8?B?YmVDcmtLUGs2LzRIajBFOFdFaktaL2VwaTRacCsyWmJmTCtvdG9tQ1Vkc0Zs?=
 =?utf-8?B?YlNkNGdJMForcjJZSUxpVjhvQ20xNXVmeGRzaG40MmgyM201Y2lQeTRhYmQ5?=
 =?utf-8?B?ZzZTbHdybG5KN1BZa2VHaFEyNmZWSU1RQWQzLzVpbzZOUlFDV2VqLzRGQlY5?=
 =?utf-8?B?czYwN00vWkJpcWV6ZEt3dUtVY1REWk1TbTlHdVh0RTQvbnNoYjliWXEzemZV?=
 =?utf-8?B?U0xKa1FjN0hSZjJsVHlkd2YrTDd4aEw1MXhPMEI0RDd6UTVYT1hLNG5qTGNu?=
 =?utf-8?B?c3o0M0w3WVRaMHE4ck5nNnN2My9uQURwbkFsbkpkcmJjRm1OQTc1UEFLYmN5?=
 =?utf-8?B?RUJoN0pKY1dHZHQ3Wmt6cmxpVUN1RXRwdW1ldm92cUFhRzc2VDNWcm1Gdmhl?=
 =?utf-8?B?b283c0RlMkxVY0VLMlAyS3ZnUmlMZkpDM2Ntb2J1bTdoSFRwdlNQc1liVlhI?=
 =?utf-8?B?aS9lN2VBV0lxa3Y0eWZkR2VHSFhtRE5SNkRCTEcxcTNNbHhtVXdaWEdkOEtX?=
 =?utf-8?B?OHZhNG0veDI5MjRsdk1oTjhJUTZEVTNUcnh5V3FjNXc2Um1xR2FsTEhjNkRq?=
 =?utf-8?B?andBVFI1ZDNQbG9JbXpyaG1qOVJKQnYvYlhpUFJhQmdpMUs3SjFiUUFVVnRj?=
 =?utf-8?B?dHhjMTZtSEE5WWZaNENiSmFoOUd3RWY4RlJwMVJrOE5VT0U2ODB0SEpubmVL?=
 =?utf-8?B?eTBjUmR0dzVBZXJpcEhPbFZKU3BnZ0FNTHhnaVhSS245aUFJSU0vRmFyNHhT?=
 =?utf-8?B?eFJtTzlvYlhWT3crb3BsRWlDUy9wKzRCcFZkNDRnOVNvMEZUNnZJdm1WMUJV?=
 =?utf-8?B?YXRnTWxpMUhjQXM1THpWUmRTREthS00wZWV0VXRBUmVtT2pqeUFrL0JoQWxj?=
 =?utf-8?B?YUFKS1RZaWprMlMxMTZVUHhJTUUyZkJDbDJNWkpPNkd1dVlUTi90Z1MwZTcw?=
 =?utf-8?B?Zi9TbEVFZXQzc0hhbHFjWU16Rmx5OWpnd1dyTXNjTW13bE9pYXRHa0JPeEk0?=
 =?utf-8?B?aHcvVWczOWJ1aE9IcXZCSUVLS0V6b3NqcmlnREpGb29kWTFIVnJrVkgzRXNw?=
 =?utf-8?B?dHdOTWt5a0ViZkM5TnVkU2x6QzhMOHpXbC93ZjVUVDVZN0s1YldBb2ZFOXZV?=
 =?utf-8?B?dHFxS0Z1VmtFb3g5ZExKSzE3K0dKbkhkWnN3UHVoL2RQNWpvdjVOdm1sVmcv?=
 =?utf-8?B?dnl5dDJ4eHg4R3JBUTF5R0s0bkJ0NFpMWWJzeHo2NmpqNk9RMVhLeUl0NHZq?=
 =?utf-8?B?bzFGV24rbGF6ekN0WXR4WkUwa3lJdk1PSHdNaFlQRGxDTXd0TlNibUwxNTBt?=
 =?utf-8?B?WmNtbm9qZHdmUXRnYW8zajlQSWVTYVQ2cG1YZzhSVnViS01GMWtGZFFPV3hR?=
 =?utf-8?B?ZUM0NUN1QnBwKzEzUGdvcnVmNnRjR1lZRzljZW9WN09rRitKcXNUVVdENjQ5?=
 =?utf-8?B?c1VhYUZrRHJpR3NVSHpqZlhtMytyRnArSzNxRkN4RHVuRldOc0VTNVNUeVhj?=
 =?utf-8?B?SUQyNWEvMk1iMXB3YlR6UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWY5OHRoOXd0d3FyeUJ0L2w2VjYrbVZMRFNMRmEwT3kzZW01K2FrcCtqU01U?=
 =?utf-8?B?c2FxU3pSM2cwWk5lckdNNXZFNHY3WVJDVGI3a2gxN1ZPZk5pUWZ0a1pqYUdu?=
 =?utf-8?B?di9hYWRLMjJhQnlua1NxWnZ6Mm00MVZ4MGtWTjVpNkd3RXBLWXdobHFxeFJU?=
 =?utf-8?B?LytnTjN2N3hEYzhuQ2E0di9zQXlxVURWRVQ1Q3FzL3A3Ylc3eFVwSC9mKys2?=
 =?utf-8?B?eHN6S0hmVmtramZHSFRNTXFTejYrVjZVa3htQXVndGxRTjdCbTEzY2VNSUkw?=
 =?utf-8?B?REFWaVVSQVRGVnlRclhOZ0oxUk04OGU0cE1QNWV6TEhBTG1QQjlVQmpObmVG?=
 =?utf-8?B?clNNMExIZFQzWHkranVKV1ZNQzFKamd2V1FkbmN3bzQxczFtbnh0RU1PWUpP?=
 =?utf-8?B?Y1MwVUd6YThDeWlkWENGcEVtTzZYR2FJQjJUVkJocEd2aEtTblcxQk5hSll5?=
 =?utf-8?B?Zm1uWndJZlJqNmhYTms3Q1Q3bEFWQVBhaldJbTRXaTJpbndDQTlaZzZoYm0z?=
 =?utf-8?B?V05HL1drSk1jcm1TZkhDWHVzMjRpYlNWRkFnQjNTUVNtWG5VL254RTlPRXZR?=
 =?utf-8?B?bEJIdU9Cc3ZsRTZERXpLRm1McWlkeklvOVc5eWV2VWZPWWpYQkgvTEZEUTRv?=
 =?utf-8?B?UGRYZU9aUkJscFZab2tOWFlJY3hGUjRxRk5UVGRPSGJudVl6aVRLQndrT0xO?=
 =?utf-8?B?engxU2JQQ1N0L2ZDUHo0RFAvTHUwWXlubFE1RnFNUzc1c0xyUmxueEdiTVNM?=
 =?utf-8?B?dElnM0Z2Y01jRWhvS1Y0WXhzSzBuZktXWTRaRkllbEQ4NTR2bVFmL2tWUExo?=
 =?utf-8?B?bzBWUGlmdU11OVNYSjhYeUJxQkxCaTFZOEc2OGNOTkZWQnFEOTRPcTFnNXRq?=
 =?utf-8?B?ZnhzZ2pBT2UvRHRQWmQ1YUEyUnplNVduVFd2cGRTMVdGUmJaeVh1T0s4ZEVo?=
 =?utf-8?B?dUpuaHBlQlhES05uTmJtRU5vUFZVZVZkbm1zNkxuMEhYaXQrRUpXYjNzUjFJ?=
 =?utf-8?B?dlNTMmJZcWJSQkl6SHdFaGhVMktPekpwREwvdWh4L2ZFRkZ5dzJMdHphR2c3?=
 =?utf-8?B?WDFoZXRVNEMwZElmQTlydFRBUitWUE9wemgrS0NjS05WTWRDM1F1WmIwOEZB?=
 =?utf-8?B?SWtIWDM1dzF3YVBlSU5XUnJiM3o3QkZ1YnRLQUdiQk9ZTkNxZ3ZQKzBDeXZ5?=
 =?utf-8?B?WG9qd1BiRGhJN09FSkh2YmtZVjd6RGc3MUxqRmJCdVN3QlVBQjZKN2NidDJB?=
 =?utf-8?B?a3UxNFNDY0FKLzY3bVpVVGV4SGtwTFVWaFRQRmVBRUR0bG10TkkxUVBIYUZv?=
 =?utf-8?B?V3oxYTRGVnR6a09DVnJsWDkrTGFUTWVJYjg5dXRJeGg2Z0tKdXh2RE5jUEZq?=
 =?utf-8?B?eU13bEZDbjY2cit4WUpXRWFIOUdRNXh2a1k3QldOMStlTm5rNXNUUjRLRUNa?=
 =?utf-8?B?SVppQzJFUGgvMlFCWkhrT2psQ2xjMEhzTkoySzYzd00yZmFOMEVjWUw3d0tM?=
 =?utf-8?B?bWlYWmszZCtmeVVRdjJMUFVSN0N0bFp3TUdwUnlzeXR6dXVZSWRKaTRITkFZ?=
 =?utf-8?B?VUFqSEgxNG5SbG1zckpWTURVMnVINlE3b0dnVjZIWUR0a2RheHk0YUZJTGlh?=
 =?utf-8?B?M2NqdDAyYVFINmpXckhlUk5HMDJDUndBUEQ5cVNVV3drbGk5Uk1IbUxqa3RL?=
 =?utf-8?B?Q2NTWFkzbnBUeDZtLzZ2TWN5bVgzWll3cnY0djYvaGhOeXZNSkxpWURpa1NC?=
 =?utf-8?B?bXpINml1OE9qdzFkbmZMSW9OZURMVXRSSWEzdXBGVDRocDRxTDFsckgvV1Rp?=
 =?utf-8?B?YlBjSDZKUmwyb3VjTGNVanNZelRjSmRJMjBJK2xlcnROWWFaRkdUSW9sY2d0?=
 =?utf-8?B?MUFlVTdOeHliajdrVU5vOFJyNTgxWWdlU3BxWDRuWVNYU2svSHlNV0txR1Fr?=
 =?utf-8?B?R25MWmM3SXA2dk1ScjYyV2lJczh1ZkZCNG10L0VreWdpQkN4Sng5UHJvY2ll?=
 =?utf-8?B?bVhOYmdFdkVuNklvZTQrS0pnaW1yM1kzVTZtVVdpbkZZT0plTEJ2SC9DN0ty?=
 =?utf-8?B?SzFGcGU3enRDK203MmFSMFZObndNZ0JRK0tJWkdoNFZna0lvOEVNOVo1UmtE?=
 =?utf-8?B?a2EzeDZ5azBRTU41ektiRjRFa1pzOG9CU2JRVTlTLzB2V2Jaa3ZTd0lac3o0?=
 =?utf-8?Q?KadCoyDYOHyNacdBx76hAao=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <921FC55D6BC800498C420BF87A923D17@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d893a9f5-e861-4dee-a7ef-08dc74aea263
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:17.4443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGzeTpUmP0lHsF5qXyxYDBj6joEKFJ552y5WQkPdBYMgIc8UGO4k8pmUSi90mJdz2xUyRNm6EMieeHeLNhHzqDGG/mNk5hMEXSc90sjezifmZORmS+d5wmPblnIx9xc7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6718
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9wY2kvcGNpLmMgICAgICAgICAgICAgICAgfCAyNCAr
KysrKysrKysrKysrKy0tLS0tLS0tLS0NCiBpbmNsdWRlL2h3L3BjaS9wY2lfZGV2aWNlLmggfCAg
MSArDQogMiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2kuYyBiL2h3L3BjaS9wY2kuYw0KaW5kZXggMDQ1ZDY5
ZjRjMS4uZTVmNzJmOWYxZCAxMDA2NDQNCi0tLSBhL2h3L3BjaS9wY2kuYw0KKysrIGIvaHcvcGNp
L3BjaS5jDQpAQCAtMTE2LDYgKzExNiwxMiBAQCBzdGF0aWMgR1NlcXVlbmNlICpwY2lfYWNwaV9p
bmRleF9saXN0KHZvaWQpDQogICAgIHJldHVybiB1c2VkX2FjcGlfaW5kZXhfbGlzdDsNCiB9DQog
DQorc3RhdGljIHZvaWQgcGNpX3NldF9tYXN0ZXIoUENJRGV2aWNlICpkLCBib29sIGVuYWJsZSkN
Cit7DQorICAgIG1lbW9yeV9yZWdpb25fc2V0X2VuYWJsZWQoJmQtPmJ1c19tYXN0ZXJfZW5hYmxl
X3JlZ2lvbiwgZW5hYmxlKTsNCisgICAgZC0+aXNfbWFzdGVyID0gZW5hYmxlOyAvKiBjYWNoZSB0
aGUgc3RhdHVzICovDQorfQ0KKw0KIHN0YXRpYyB2b2lkIHBjaV9pbml0X2J1c19tYXN0ZXIoUENJ
RGV2aWNlICpwY2lfZGV2KQ0KIHsNCiAgICAgQWRkcmVzc1NwYWNlICpkbWFfYXMgPSBwY2lfZGV2
aWNlX2lvbW11X2FkZHJlc3Nfc3BhY2UocGNpX2Rldik7DQpAQCAtMTIzLDcgKzEyOSw3IEBAIHN0
YXRpYyB2b2lkIHBjaV9pbml0X2J1c19tYXN0ZXIoUENJRGV2aWNlICpwY2lfZGV2KQ0KICAgICBt
ZW1vcnlfcmVnaW9uX2luaXRfYWxpYXMoJnBjaV9kZXYtPmJ1c19tYXN0ZXJfZW5hYmxlX3JlZ2lv
biwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE9CSkVDVChwY2lfZGV2KSwgImJ1cyBt
YXN0ZXIiLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1hX2FzLT5yb290LCAwLCBt
ZW1vcnlfcmVnaW9uX3NpemUoZG1hX2FzLT5yb290KSk7DQotICAgIG1lbW9yeV9yZWdpb25fc2V0
X2VuYWJsZWQoJnBjaV9kZXYtPmJ1c19tYXN0ZXJfZW5hYmxlX3JlZ2lvbiwgZmFsc2UpOw0KKyAg
ICBwY2lfc2V0X21hc3RlcihwY2lfZGV2LCBmYWxzZSk7DQogICAgIG1lbW9yeV9yZWdpb25fYWRk
X3N1YnJlZ2lvbigmcGNpX2Rldi0+YnVzX21hc3Rlcl9jb250YWluZXJfcmVnaW9uLCAwLA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnBjaV9kZXYtPmJ1c19tYXN0ZXJfZW5hYmxl
X3JlZ2lvbik7DQogfQ0KQEAgLTY1Nyw5ICs2NjMsOCBAQCBzdGF0aWMgaW50IGdldF9wY2lfY29u
ZmlnX2RldmljZShRRU1VRmlsZSAqZiwgdm9pZCAqcHYsIHNpemVfdCBzaXplLA0KICAgICAgICAg
cGNpX2JyaWRnZV91cGRhdGVfbWFwcGluZ3MoUENJX0JSSURHRShzKSk7DQogICAgIH0NCiANCi0g
ICAgbWVtb3J5X3JlZ2lvbl9zZXRfZW5hYmxlZCgmcy0+YnVzX21hc3Rlcl9lbmFibGVfcmVnaW9u
LA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBjaV9nZXRfd29yZChzLT5jb25maWcg
KyBQQ0lfQ09NTUFORCkNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmIFBDSV9DT01N
QU5EX01BU1RFUik7DQorICAgIHBjaV9zZXRfbWFzdGVyKHMsDQorICAgICAgICAgICAgICAgICAg
IHBjaV9nZXRfd29yZChzLT5jb25maWcgKyBQQ0lfQ09NTUFORCkgJiBQQ0lfQ09NTUFORF9NQVNU
RVIpOw0KIA0KICAgICBnX2ZyZWUoY29uZmlnKTsNCiAgICAgcmV0dXJuIDA7DQpAQCAtMTYxMSw5
ICsxNjE2LDkgQEAgdm9pZCBwY2lfZGVmYXVsdF93cml0ZV9jb25maWcoUENJRGV2aWNlICpkLCB1
aW50MzJfdCBhZGRyLCB1aW50MzJfdCB2YWxfaW4sIGludA0KIA0KICAgICBpZiAocmFuZ2VzX292
ZXJsYXAoYWRkciwgbCwgUENJX0NPTU1BTkQsIDIpKSB7DQogICAgICAgICBwY2lfdXBkYXRlX2ly
cV9kaXNhYmxlZChkLCB3YXNfaXJxX2Rpc2FibGVkKTsNCi0gICAgICAgIG1lbW9yeV9yZWdpb25f
c2V0X2VuYWJsZWQoJmQtPmJ1c19tYXN0ZXJfZW5hYmxlX3JlZ2lvbiwNCi0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKHBjaV9nZXRfd29yZChkLT5jb25maWcgKyBQQ0lfQ09NTUFO
RCkNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICYgUENJX0NPTU1BTkRfTUFT
VEVSKSAmJiBkLT5oYXNfcG93ZXIpOw0KKyAgICAgICAgcGNpX3NldF9tYXN0ZXIoZCwNCisgICAg
ICAgICAgICAgICAgICAgICAgKHBjaV9nZXRfd29yZChkLT5jb25maWcgKyBQQ0lfQ09NTUFORCkg
Jg0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBQQ0lfQ09NTUFORF9NQVNURVIpICYmIGQt
Pmhhc19wb3dlcik7DQogICAgIH0NCiANCiAgICAgbXNpX3dyaXRlX2NvbmZpZyhkLCBhZGRyLCB2
YWxfaW4sIGwpOw0KQEAgLTI4ODgsOSArMjg5Myw4IEBAIHZvaWQgcGNpX3NldF9wb3dlcihQQ0lE
ZXZpY2UgKmQsIGJvb2wgc3RhdGUpDQogDQogICAgIGQtPmhhc19wb3dlciA9IHN0YXRlOw0KICAg
ICBwY2lfdXBkYXRlX21hcHBpbmdzKGQpOw0KLSAgICBtZW1vcnlfcmVnaW9uX3NldF9lbmFibGVk
KCZkLT5idXNfbWFzdGVyX2VuYWJsZV9yZWdpb24sDQotICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKHBjaV9nZXRfd29yZChkLT5jb25maWcgKyBQQ0lfQ09NTUFORCkNCi0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJiBQQ0lfQ09NTUFORF9NQVNURVIpICYmIGQtPmhhc19wb3dl
cik7DQorICAgIHBjaV9zZXRfbWFzdGVyKGQsIChwY2lfZ2V0X3dvcmQoZC0+Y29uZmlnICsgUENJ
X0NPTU1BTkQpDQorICAgICAgICAgICAgICAgICAgICAgICAgJiBQQ0lfQ09NTUFORF9NQVNURVIp
ICYmIGQtPmhhc19wb3dlcik7DQogICAgIGlmICghZC0+aGFzX3Bvd2VyKSB7DQogICAgICAgICBw
Y2lfZGV2aWNlX3Jlc2V0KGQpOw0KICAgICB9DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9wY2kv
cGNpX2RldmljZS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpX2RldmljZS5oDQppbmRleCBkM2RkMGY2
NGIyLi43ZmE1MDE1NjlhIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpX2RldmljZS5o
DQorKysgYi9pbmNsdWRlL2h3L3BjaS9wY2lfZGV2aWNlLmgNCkBAIC04Nyw2ICs4Nyw3IEBAIHN0
cnVjdCBQQ0lEZXZpY2Ugew0KICAgICBjaGFyIG5hbWVbNjRdOw0KICAgICBQQ0lJT1JlZ2lvbiBp
b19yZWdpb25zW1BDSV9OVU1fUkVHSU9OU107DQogICAgIEFkZHJlc3NTcGFjZSBidXNfbWFzdGVy
X2FzOw0KKyAgICBib29sIGlzX21hc3RlcjsNCiAgICAgTWVtb3J5UmVnaW9uIGJ1c19tYXN0ZXJf
Y29udGFpbmVyX3JlZ2lvbjsNCiAgICAgTWVtb3J5UmVnaW9uIGJ1c19tYXN0ZXJfZW5hYmxlX3Jl
Z2lvbjsNCiANCi0tIA0KMi40NC4wDQo=

