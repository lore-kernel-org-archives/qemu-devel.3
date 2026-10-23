Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889A606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 04:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=HAcGs2i5;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=h1V8DZ2I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK6SZ-0004ZL-7H; Fri, 23 Oct 2026 00:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=749f58b73=Alistair.Francis@wdc.com>)
 id 1xK6SA-0004X8-B9; Fri, 23 Oct 2026 00:00:26 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=749f58b73=Alistair.Francis@wdc.com>)
 id 1xK6S8-0000RQ-E2; Fri, 23 Oct 2026 00:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792728030; x=1824264030;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=yXkeQbM1+3CcC9ynJR9wLFwrM/gha567v5irW0vzHiw=;
 b=HAcGs2i53RrpZm/zCLI6fUaGjr/ID0kviNAWaYElK1IvfXDvVb5GsrWi
 D1ylIm7J9jkYC3V6MEuWYjGw5SmjXEIdCV+Czh8m/18TYm/gZiDTQk0mv
 Gx48lVJ5/jJCjzbSi+znFU3Gm9eTDz50WKJmLZ3sER/MthBkNNsvfhW35
 6r2lNjwbFz260wwe30bdSM50VRDmPrWfiWZ21asaAdDj2pf44ZRgEJD3m
 l+Pz7fl9RInhdyM4yfzavs9g6mGvMKnyd+8beEYR9ymld2kQOpBzFcc1O
 Y04yUvh9Z2TewcHMisrJ53J3yPs/xoxklAFrgV7iKOiAktxnZ0w2ta+qw w==;
X-CSE-ConnectionGUID: Qm1QZxVQQDKaFjlCJ5Lasw==
X-CSE-MsgGUID: FIvfxwoUQ+qxRzpA732oJQ==
X-IronPort-AV: E=Sophos;i="6.27,173,1786982400"; d="scan'208";a="157195800"
Received: from mail-centralusazon11010048.outbound.protection.outlook.com
 (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.48])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Oct 2026 12:00:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWyyG8n/+VRndAJb/MDdD4wdTwksfL+2uIssA3v5/cdfo9w+l97SbtYrakhGLj8gRpjSaZoedrNADXw15x28cS6yWNKe+FVDtkcA3yZLIn3E5NY6A1xJcsKj41Q9fpg083g5gcqoiigsCsT8H11rwvqrEoMTqbOAA6EEWhEDgwsYOPOglE7a0s+b0UJsA0zBoywkzKsjn+7KJHuOPfrevJ/YFsAncYNyFn/+yhoFGME31aHhpMFVh0jImkr6hqB4VypmOeFhyV9uALVv3KtMIZFkvG76IVdPJgkTLu2WrW6laqHlIB6RZT3WlgjntFiZKxvw4rI0UPe9B9S3uVV2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXkeQbM1+3CcC9ynJR9wLFwrM/gha567v5irW0vzHiw=;
 b=faFeKH2ggWuOUS+UuM0gjfaiQswU1YRhTqBnB0COyIio3GspWnBZ4+2LIYU2eP30axtdzJ53oJbKrOyZM421blNLyNS9RUbP4zTL1fiTzMRNJYrp/NbhWRkM8cGKLWru8ln+DllKnYKKVHSZK56sFf9Vm6mLBPWRb4Z9K0aAVhTj4InkUL5SRhQ+7A81QrQYUEeksaTNW9b2FCEYi1cQI0Oht1LcXPzJMhKnY889ET7l8TokvdO/2A53OXZp6xSLogt0xdHOyYfANFaULo3gDowADbm20BiWab3hZXh44zDWO5TcBQq5Q72NbezZ8+GULmsC/ECsUSICiIuYITrIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXkeQbM1+3CcC9ynJR9wLFwrM/gha567v5irW0vzHiw=;
 b=h1V8DZ2ICNBCeIq4oQFdBYXzI266bzAt9vCs0GaUZ/Ojt4n881TxkTR8sJUHMK220G1q+aTbp1+uMPwHIz/9B0D9znHSQ71zW6Z669nUFKvhS5qa9Di7dl8VHdAfb3ttJOL9tSRsZasv0IDAnKJQ58orYVhdevnhcEmuiDoyvXA=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DM6PR04MB6329.namprd04.prod.outlook.com (2603:10b6:5:1e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 03:59:55 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 03:59:55 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] include/hw/intc/riscv_imsic.h: remove unused macro
Thread-Topic: [PATCH] include/hw/intc/riscv_imsic.h: remove unused macro
Thread-Index: AQHdYlH433P5rcgYqEuBohlzyv3P+7cKgUcA
Date: Fri, 23 Oct 2026 03:59:55 +0000
Message-ID: <ea8a482ab0c7d47906665d87dd9ffff502ad5c51.camel@wdc.com>
References: <20261022181957.21760-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261022181957.21760-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DM6PR04MB6329:EE_
x-ms-office365-filtering-correlation-id: b77e2f06-5383-4442-f918-08df30ba1930
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|19092799006|23010399003|261009223027099003|261021123027099003|10067099003|56012099006|261022105027099003|18002099003|22082099003|11063799006|38070700021;
x-microsoft-antispam-message-info: Q2BxkZBu+j79+DM8tlwSDkkR5nx52JXh0AB9XV9cTC4zuuLhcN4ASeWWny+ErKUmxPlali/KCZRZG7y/EdftqVzgZHdVxAQR0PNtgPV0tYZjngb6QBOC9GQUw2sr1/Dwx/C31KDAmcBcOdfzP2j8Z3vcNwXmjxu+Q9YWO8VsAY8C37fUZZa09prGuU4nUqg3f5n4ZEjY2z8weKL9gIo8DZvNT6wO4/+Hz1Xsx9I8+Q8acXM/NwCEl8Cj0B2NLo6i3oPyBdwk6zlOxqZLDW0aaaJ3BpkRoxbj/3PY4c2A9mklTK1AeA+ib0/3GuvnRRzXJZASty24RI7mveHye5hB64MbV5Ek56vuYsQec22BaeFOA6CLbusXLH2ATV7njLA2Pml8N+2eBLM1tp7WECf22jlpP3vYLxNuRa3rb5lAt3ofx9ux+VZDhqKnES2tXC0mcVrF/J1Vwg0eCdR1uMZbdeU9g9IfVJ7reipMAzvsxGeaBoogUWXQba03X6IMhI+JsCTvlICPbTyjuHqpyZTBExDnUTxcxXGje7mmXMZ7Qt8cMPkR4dikYjQukcR+WRhTWHBm2Dn8RmWaPRJUF1FdegMc+hdZlsDAcj0b1VI19ns3uEU5FvSffCHzkn9eKQBMyUkvQdyDiST+qTtknEnaTRy8CRCNCTDFEBR0QFJShOimIVYapf5qlxg7x9W85mODX39AnGGFFOC3uyWCDVPH4iKarFZG5O17lY6uG1+rHHI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(19092799006)(23010399003)(261009223027099003)(261021123027099003)(10067099003)(56012099006)(261022105027099003)(18002099003)(22082099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnFTUU53UzRodDhmWXU5bUpJWnFvRDRNRjJLSFBKUStkVzEyQXMzVjdqRmZL?=
 =?utf-8?B?VGtFdnlsTGo3QWxTbTFhLytxOVR1SU5pWlN0cm54cVc1RW5zR01vbm8xYld4?=
 =?utf-8?B?ZE5iTmFqNjVLb1ZRa2w3Mk4rd0ZtTWdOSmxPblZrWGt6TUlYeGF2QUoyamtX?=
 =?utf-8?B?S0NDR2FSNXFWbUF3ZHVRWWVaRXY5STQyVzZBUmZEaFpndW14UEIxcW1RWUIy?=
 =?utf-8?B?WVdMUENiQlp1bXVZSlEzbC9UaGloa2wyUWthd1NJODBLSlJvc3ozazhEdStz?=
 =?utf-8?B?T2xnK0dmQ2ZBb0pmQ2QvdDAweUhpK2NYV1JXWUs5ZjJCS2kwTjJXeGI3WjN5?=
 =?utf-8?B?czNwRWtsR0dIVnR0YjdjVDkvaTFLK251R3ZKaGpNdEc5eW1meFFla2VNRzJv?=
 =?utf-8?B?ZzR4YWdQcno0ZW9YTmFiQVgvTm16L2ptcDdhL0VNZWM1UTlHbEMwN1RpODhG?=
 =?utf-8?B?U2xKWTZJb1J3RXZLNjVxbWNrTXlxZ2grWGxUNmVqVVBTY2lENEg4QVBmb2xF?=
 =?utf-8?B?QStHK08zZHpmdCtzM2U5TUdEVjJDYnBDM0Q0V2tXcG9oc3BLYkRteUFwVWk4?=
 =?utf-8?B?TW94UjI1c29qTU9OSnNDclFHREdWeHF2QWNKUVlYRHlyZ0tWSTBDaVBoTUZN?=
 =?utf-8?B?VTVyZllCYlloa3FPb2ZrNFZ1NTFLUHVNNEpCVWR4bEZDQmFublkyTVhRbW5F?=
 =?utf-8?B?RytsVFQvNDRiT09Ob3o2ZkFiTmRsVFlad1ZtZERFUkJoODZYZXpXY1BBV0c1?=
 =?utf-8?B?WThpSE9tV0F3YVpNdUJWNWhvYStjQ2JzckplakxOc3pNcVFqVU1jMHVZTlBT?=
 =?utf-8?B?RHN5eU56SUxpdUJVWTAyRFUvcmlwdThwNlB6ZXZTVmZRckhHdTIwZ3JDMFlV?=
 =?utf-8?B?c2NKVWM4WVluUkx4MW10RFY4TFppNngva2h1T2k2RVZZZ3poVEJQcHhQYUl4?=
 =?utf-8?B?ZjVoZHRYYTJDOHo5azdpeHpvK2JLT2JsNitTYVZScFFRWXFPRlNUR3I1eHNx?=
 =?utf-8?B?aXRZRnpPMW1xUEgzd1hEZno5d0NLWk93QlJ5aW5qMnZCenBwSnYwbFhqUDN1?=
 =?utf-8?B?M29Md2JIR091UnZOVnlyQ1JWb2Znb2h5YkllWVFPUFJHaXJsV0R1bitaZjVD?=
 =?utf-8?B?YTZRWE5Vcy9QOENXdlNaVEY5Y3NCc0IzdU4wRXNIUldUVUtHWC9sd1hkVy9k?=
 =?utf-8?B?Qjc4VGZ0THJRazUxQURLVUM5Vm1IM1UxaUE0TEw5ZWs1VkpDZXIzUkJueW1j?=
 =?utf-8?B?bTNoVWg3RGlHZXVVTmVVVVFDelJXbzUxNTA0UDFhV2wxTUR1d3FlT3Z1VHBw?=
 =?utf-8?B?RzFYbHdoVWRPQWxpYXl4aWRmSmNlT3N1VjJBRklJbS9FeFFRZWRQZnRHTUNu?=
 =?utf-8?B?Zy9kYSt2ejZMVC9SWnhGVHlOZjV2YWZNUjduS1U5eC9JMXhuem1adFoyMTg0?=
 =?utf-8?B?Z2Y1SHF5Q1YwSmtXRTFIYjcyVGhMOHdENjF5TG9rS2N6SW1lRkg4bS93c29r?=
 =?utf-8?B?Q2MrWThRMldISENneXJURk5RN1hNOWtid2tpSDN3OVNLQU4yYmpqeEZPekdJ?=
 =?utf-8?B?UGV0WXMrNWxRczhSTW9ucUpvc2VPWW1xL2xleERTUTZOUkRZZ24rY0s2dXJv?=
 =?utf-8?B?Qi9Vc3Z4WW5XdlZSdm5WamNqQnV2ZGxWNGlDZ1FoYlYwMWRnSDI1VTBLUlRR?=
 =?utf-8?B?bHQzRlpsRlFyaWkwa1dpZVZBS2c0R1FKOHNhZHJvU2ExK1NibTRVNUEvZXFF?=
 =?utf-8?B?UjFtdktBejdVczMrMFFqUkE0Skh3UHYreDBCdXNncitHMXVhejRMSFZrb0Nl?=
 =?utf-8?B?U0ZRQVhRN1BqRG5Bc0hWV0kzQWFXdWJrTStZRklsVGJHY1R6RWJmWVZNSGtZ?=
 =?utf-8?B?QklHckoxeFZKN0ZGRFlCRGVKM3NRcnVIUHRMZHljWCtwVFlLV1Z2TU1jVkNh?=
 =?utf-8?B?MVMycXNkcUhGM2ptMjI2K2hTbGwrUmt1dThQN0hsRWpPbVRCakdTblZkTGdL?=
 =?utf-8?B?d0tKV1dyaVVRSjBPNitqcTZsaGlGeVBSb0xIRjRmN3FmSTB3OUh5TUx4VmIy?=
 =?utf-8?B?RUQ1dWFjUzB6ODNjUXVxWWEzejVaenREMWhsWC9pQ1NmazgzRFJHdmVaVGF2?=
 =?utf-8?B?MGNpR2lDTHBtQUNITE92djFQNUUvVWdYU2luYXM5amlRRHI3Ulkya1c1SXhT?=
 =?utf-8?B?QVJ5TEJROGREdnB1YTR3REwzNk9kRkFvU1hWcXAzZENLS3RkMU55SU1QVDBI?=
 =?utf-8?B?aitaZ0tWSEdaOE5LVnNRSDdORjBjWDJ6K1RNa1o1Zm9EaThsZDFnNDVYWjF2?=
 =?utf-8?B?WlhXVTlpVEpIOTdXSXZqTXVmVmM4Tjl4M3dlRUFSK2ZwOGtrb05vY01xNHZQ?=
 =?utf-8?Q?9adaABJviaUFBHvL6RLgWUxU0P4s0p6c1e6rIqBNLO8Qf?=
x-ms-exchange-antispam-messagedata-1: 0rvo7hiddBbq+DPhMNYJO+U57YgeX+XJBqo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F96A2A20041D8A4DB60C59EE42FFAF17@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PGakF7hFtRxlo8Z48pZZCgSiqpUEv7p/IpdurT8fzXOdKFFAoj57tgNAqDpkl5eAWpYsgmAYxX7WjpmluHa5AnNT4FcQheH2IGW1mkemWkgop/Kgn7ArZDgm00UmG54ca1YAOwFAqMryvvCjb1DHcthSWk7itpg/97Rt77X+gXX5GQen4S1/tvPPS8dVuOsU+652IQX/WuAri1i4oS1rKgStgOnBfvrAuhtSL7ysH/IL3so2+zHeZBwKh4TZYzCdVDQEAGQ7aV13fP5smO6Eh4rB5lF/VRV2rwnsZTQFBwt5aDJNFZ2cuuovKH+E7bpVoOBGtLL8JGHDneadB3DcMA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: W5pzfp2F4zIunf6QWWHLUwaoovs+GygFmXLzV0u5QOT5ijdofcxGO7RjFKiE/rHZE9TsR8wPiA5+5pf0I6M5ouBdZZT9B4ObcPbJ9HSDtV7DTi8d4QEfrk8ujKK6Y5js89ujRzmY89/Ue/cVGkr5Sk69Y8gYjpu6iM3kz+ny3dRMHi4Xnyh1V0yuEZCAND7tL6YVG0wd4laVxm36/BqHC80txsXkwZQltLpZooGre1RC9bkLhB7inDfWokmt3ZgrnmaCXYYtSrhZmbpj58PSrUdphD+a1CTs7t8F5sxulwbr4Esc3/3plNvpSQYwsGvF2RLroI0i+R6BeGFbXFllFXeOtoauFco+0cEODzOU+T+tzgUl3RQ0nV32xQwjW5JXACqyPELKboDDiXWaE42nyyF76LE4xqz17y/Z+UlozM2Ra8/LYpHlkuMmD28+vQV6EycgXGFzJdnZo4xRyxd7FZE5kg6v3QKqtySEhplS1Ag0tYAc9MWqlc5S/sXjl25s3TPIpHM4mCk6JskQUqPCuAGgtrST7aLYXnTBvxr0OSgFqSndtUjPdtXcblc3hdyPVcdqPnGp/h1dkZzjuQUIfoTIXFvDI6ODWDP6T6YFvZwvpaLrDwdugx4p1cIyM8GO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77e2f06-5383-4442-f918-08df30ba1930
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 03:59:55.4139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V58n5MBVgcVx5T+zD2Djq6TVYMdG0Evj8Bphr4hf4Tvi7DSaG5Vwr6w+Nto0wXw0IPUBRbcxSa8whmYVy/as7twxa+Wf0cX7lXJNx1GfPX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6329
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=749f58b73=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTEwLTIyIGF0IDE1OjE5IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gRm91bmQgd2hpbGUgcmVhZGluZyBJTVNJQyBjb2RlLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmllbC5iYXJib3phQG9zcy5x
dWFsY29tbS5jb20+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5m
cmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgaW5jbHVkZS9ody9pbnRj
L3Jpc2N2X2ltc2ljLmggfCAxIC0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaW50Yy9yaXNjdl9pbXNpYy5oDQo+IGIvaW5j
bHVkZS9ody9pbnRjL3Jpc2N2X2ltc2ljLmgNCj4gaW5kZXggMGExZGYxYzJmOC4uYzc0NDgzNjY1
NyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9ody9pbnRjL3Jpc2N2X2ltc2ljLmgNCj4gKysrIGIv
aW5jbHVkZS9ody9pbnRjL3Jpc2N2X2ltc2ljLmgNCj4gQEAgLTMxLDcgKzMxLDYgQEAgREVDTEFS
RV9JTlNUQU5DRV9DSEVDS0VSKFJJU0NWSU1TSUNTdGF0ZSwNCj4gUklTQ1ZfSU1TSUMsIFRZUEVf
UklTQ1ZfSU1TSUMpDQo+IMKgI2RlZmluZSBJTVNJQ19NTUlPX1BBR0VfU1rCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKDFVTCA8PA0KPiBJTVNJQ19NTUlPX1BBR0VfU0hJRlQpDQo+IMKgI2RlZmlu
ZSBJTVNJQ19NTUlPX1NJWkUoX19udW1fcGFnZXMpwqDCoCAoKF9fbnVtX3BhZ2VzKSAqDQo+IElN
U0lDX01NSU9fUEFHRV9TWikNCj4gwqANCj4gLSNkZWZpbmUgSU1TSUNfTU1JT19IQVJUX0dVRVNU
X01BWF9CVElTIDYNCj4gwqAjZGVmaW5lIElNU0lDX01NSU9fR1JPVVBfTUlOX1NISUZUwqDCoMKg
wqAgMjQNCj4gwqANCj4gwqAjZGVmaW5lIElNU0lDX0hBUlRfTlVNX0dVRVNUUyhfX2d1ZXN0X2Jp
dHMpwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0K

