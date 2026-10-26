Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCED606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=NkBJ1S6Z;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=PnvPhmdH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLD7D-0002mW-6x; Mon, 26 Oct 2026 01:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLD7B-0002mA-U8; Mon, 26 Oct 2026 01:19:21 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xLD79-00005o-Sq; Mon, 26 Oct 2026 01:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792991966; x=1824527966;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=yHQbUikno3i1VFECkhUA7ondSdhBmJ5r4XjrcaF2yQE=;
 b=NkBJ1S6Z+s6DwAE8x/1e5uCNcqMHKMqkO1ZwHyC20rRh1R49plmMKfTe
 duYjm4vdtu5V6zV94OiHSdE439FBZVvR15foXi4iFcGF3lBC7UtluD6oB
 yQtOFmTSNlLBybnYl11DsiTs3B9oSc9pf7WQrDlvisuEeoOKcyiZJRwov
 wbfAqhn6+v9qp25EZcsiAprlyt8pk6R1Ug88NLIprwxNTwSjfeB+ZrTZJ
 QXRs5wFsXVI74bkObAeRn1MWG3/pxCAnv0H7L3vy/a9MdyDeQnijKUvCW
 B9jaDB6JMqWRDetfz12Y3w8Z5LNSDQbl9Bino966E5UKVP6YihkZvuUxT g==;
X-CSE-ConnectionGUID: x72kmBkNSJS8Xi01GcNp9A==
X-CSE-MsgGUID: 4R+R/L4SRsyJpxFF4xorVQ==
X-IronPort-AV: E=Sophos;i="6.27,178,1786982400"; d="scan'208";a="157380858"
Received: from mail-westus2azon11012058.outbound.protection.outlook.com (HELO
 MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.58])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Oct 2026 13:19:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUXQG3BiCqld7J4GSDYylU21lEoSb0EMD/js4tikUa3sg5/yovLovILjrtGyZKOvetQkgcII/qt6/ibREobkXa+KWC9E9mSykusFXN1fPWot8Vc6F4B+q4ilttLrNTNa9nxwCrcNMb9RCutB9HuUW1VnmNwFsBQGGIkP/zex3xuu1VNSyZTmTjXgn+5w0Y9TRUS/SAf8Q3H8nQIJPb0SxO9CPrwYJ+vNV37WTrpFg0LJBJR7s/7484Vy7vI4dsdI+kbwNsQzhCJB1Ppx0JLigRGfM2cujdvRBtq/ujNqSscIaCj+tFOstCHAYHvVrjv/06Yl1wAx9QApt8OKWRDPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHQbUikno3i1VFECkhUA7ondSdhBmJ5r4XjrcaF2yQE=;
 b=ZUUsAJho9UNg7l2tbFIeq8AQWuKuKQug410wkx6GQqtJuiDgT0mw2WH5lTCb579cjb27Qwbvcvz3ZfonkDX2mSNStn1Xzk1GBIO9vd/wdPlXmIK1ZNVcoKCOVECQKmDcXID+O2AuY6ym0TjG3sR16InRoOBFGIPM1vDob0Wi5qbbSoL3zpPNjgeqEg7jfX8CPEKrfwEyhzfgXvjKTPJRq7ogZP+HYqFeSDnSZDd0JGwArYGdNQedB/AxX0wtW2Syx63j7lOhnboZRxTLINe0UhViROxG2rsFdaX/J7QG/OcjyAlQsR+kKDm3Y42d2KZk35Byd0smx3OZA+mxu/Mo8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHQbUikno3i1VFECkhUA7ondSdhBmJ5r4XjrcaF2yQE=;
 b=PnvPhmdHywwW0VgSRznHTBwoHZeo/fAIr9ciTsVH8WRp0y/FV4mCQxic+CpWas2Rn+nTxhZ2oAaK7ZugOe1B8U2oQShAm7teL5tUlKvCAPf6mb8WnrFxAWZSdY889w432jMswfES7XbiC1ugn2h8AtjSZm+2+xkvDZM/dSgEutY=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CH3PR04MB8901.namprd04.prod.outlook.com (2603:10b6:610:17a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 05:19:13 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 05:19:13 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "anjo@rev.ng" <anjo@rev.ng>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "tcalifano@redhat.com" <tcalifano@redhat.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2] target/riscv: Fix CPU state access on big-endian hosts
Thread-Topic: [PATCH v2] target/riscv: Fix CPU state access on big-endian hosts
Thread-Index: AQHdYrdB0dQdGDkxQUqgsYEcI8Z837cPTaMA
Date: Mon, 26 Oct 2026 05:19:13 +0000
Message-ID: <4004f5bb91ed04773551477c7b1d6a93ff7f11b4.camel@wdc.com>
References: <20261023063025.8827-1-anjo@rev.ng>
In-Reply-To: <20261023063025.8827-1-anjo@rev.ng>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CH3PR04MB8901:EE_
x-ms-office365-filtering-correlation-id: 84683004-4582-43dc-cd3b-08df3320ac4e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|19092799006|38070700021|11063799006|56012099006|261009223027099003|261022105027099003|261021121427099003|261021123027099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: kQuliWOqbIaZMlL3sxvgWuD5mNupmdjFGiIr+TCSgiRAKrO++m9DqaJOjusp9JjfxSrsAYrzclmBecIA8krmlKUKNEGhUn2C+YPjpY7I9IS63sGti+5kSfZr1KZReVP3HxX1+m88Sy3pmWFnGwV0kC5y5zP8dQJycgG92eC0EpcqRRH+yjWgcKQRm3ZcLq1O6AS8apOBMnSsMin2llBQdwSbw8ohRCLiqMKfFV56l/L6aRQBvIjEQ4AQ7Jw7WJ/yfG2leEJ28s9IoJL8kkRlHf7sofLY6WcrS5vQ38UG3sy4YeByBetI9wv4HP41uWnOJc6LJv38Kb5ASKVIMKbBfEVECE7UyTJbWloaeisTDpIasT0tAltffn1BGbctTprYXldvvwPISjLPozmNU1YP4SY/peBCSmtPcW7ImfxLKqolXVZ+MzCy5CHH6Zy0o51tr8uqVaulJLdgTMR57lUA48LqVktYjqTc6eW2Dfe+5oe1ji3nWlf2i7WT6jULM9FHLGLPQW/TXbXfo3QqFQepCLomtGfm977+l8Z3WcMBf0BWA7vWjZmvGW7piVmYWpl0qtVqvfda9+3tMq+CVWKkfpqU9Hya/Y8zswKXVy19arwN7uRJC5cNMf5ubqygAUUTQauExEChqzOQ7mllW85W/CZqtarcOV2+hlxAGR7FKzZQB3dgFStxpfBCyL8t6PJ29KcJYVzCQybkvmKIIy7jVx6p3mYsQxIf8y5REQ1ydjk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(19092799006)(38070700021)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlNlTDRUc3lneVBjVEpPTnB5QkRMd0txMFZBRVdENVdFbmtLYll1OEtZRXFQ?=
 =?utf-8?B?UXF0K2hpTk9LYTdmdlhNK2JNcU5FV2UzcnNHc2wwSGJRQjJUYlhyckVkUWFu?=
 =?utf-8?B?ZmRXMUZXZXBpK2xoMjdKTU1ZZVFHQVBtVklMMjhnS29NM0N1VWYwQ1JQQzRa?=
 =?utf-8?B?dFlKVFBtandiVDErK29nTE9YZ0x0VFRqK2Jma3pyRy8zZ29sVVB1K2dwQXh4?=
 =?utf-8?B?cFdDOGsxZ1c0Q2U5dFdUREVKZm1ZKzVFTFhiZkNjNGZRTU5jOTM4UDU2bC9Y?=
 =?utf-8?B?TWhDM29HbkVrcFpYdlVYeEpxM3ROaGt4emJjTGovcEVOSHdMZ1EvdERUYnZ3?=
 =?utf-8?B?aHU1N3U1VFJWUm1HalAwbW1LLzNVaWlZemhJYkxyK2pOdkptNDFBcDN1WmpF?=
 =?utf-8?B?U1BNU1JHVXpJVW0wbXdLTDBkWkpPT04vdU1GbmdVMkFqd1pUNVVxVjlkUzBX?=
 =?utf-8?B?S05Xc3Y5YWRYV3FsSUVPbUE2aUpGMVcwRU1SeHh1R3o4Nk8rUnZ1YjNVeXVj?=
 =?utf-8?B?WVFkRElrUW5VUG13YWk3bXhZNzFoTWs2b0JkVGIvdTFtVEVmR2hhUTVIZlBU?=
 =?utf-8?B?bUdHcnRlMGJ6Zjh2U3d3VE9iNkMxUHJxWWV6WWdtYy9qSWZLbHJjSFVrNmty?=
 =?utf-8?B?ZFN5ZXRLeldTQTdTYnVKUE92ZXZNUXJyQ1MwMVBjY2lyMjdwZGNkUVVGZnY0?=
 =?utf-8?B?U0xBNnpVckltZVlYTDBKQ2hkQ296UmNyTFZ5cEdjSnBGYjZKem1XZk1ycFk3?=
 =?utf-8?B?UStPR0ltaTlaK3UxcjJmUC9KUXR1OUhUV0ZCc2lPeGpZRnBBQ0hFZjk0U3FS?=
 =?utf-8?B?Q01GeGViME05eDhXZ1lVaSszeUFBVmEycnhRYW51ZTdEWERTTEFLR05uRlV0?=
 =?utf-8?B?djFuZTVsOE1SVkFoZUhPbGoxcFFFbEV6S0t5ZFVsQUZTWmdqc2ZlMlU5U2lh?=
 =?utf-8?B?TVFmMVBJN05BN0VGQW5vVEE5UmVrTy8yQ1hwM0xrU01sVU9Ed3IxQ1RjdkZR?=
 =?utf-8?B?RnFHQWlQM21oUEpYbnRGQzdOODVJZGpwbGNsZGFLVDJMcUJnVHEzUHRCM0tn?=
 =?utf-8?B?QkdXUVpqdzYrQWxiZTEwbk1sSng0OElkSkQ1ck41cTdMMk1YMTFNN1FvUzlV?=
 =?utf-8?B?bnIwbGlMYmNZaHJ0dDRubzF0VUtnTTdkY1ZEd0tNOEdDRHBnUTA3QkZzclBW?=
 =?utf-8?B?OWR6WjRzVXhJaXBTYjZBaVJEeElKY05iMGxjMEVXT2JLeCtmZ2RiTWZGYTRh?=
 =?utf-8?B?cGJKZHB1aS9ML3VWd2dHb1JDWUFWUHE2djhyNWMvZ1NpUkpYeHJoOHdFckpx?=
 =?utf-8?B?QUEwSUFHOU1RZXhWWDcrOGVTT0V1VGhvMWQ2ei85eHdBOENGK2NZR1AvdUd5?=
 =?utf-8?B?NENUM1Fyem9DZDVzWWZCcUxmOG05ZnhZZ0ZTSzJTOWpNQXBRSzZaNXl0Q3dN?=
 =?utf-8?B?aWZOU2FjdjhGR0daOEFuRjRWYU10TEs1bWNnYVRsdHk1aVFtdmo4TkRidHRq?=
 =?utf-8?B?b0lHRVVQeDcxU2FHdjljTUJWMWVOYkZkQ1B2RTJiYVhQTUYvMlA3VE14NjQx?=
 =?utf-8?B?V3pOSVB4OWxVMzdKUC9BU2RaRHBhNWVHNnl5eXpQM29hTW9UaTVKVlNBZzZm?=
 =?utf-8?B?VkZmRFBTTDhFTGNMRE9VN2J3bkNpc2RLSERIc0ZZNDRjVFJaZ1lkNGdUeUp1?=
 =?utf-8?B?OWhjY0ZoZ0pNcHgydytBRUJqTjBUN1ZvSSthanhmcXVtd3lyOHVlUEZ3TUpa?=
 =?utf-8?B?akVyYUxORy9ScWtQVmZLbStkRE51N1hwcDhsS2VkMUNtaHNHSk5KV1VuVkVV?=
 =?utf-8?B?QThiT3BIa2M5eWU5RkhjcnZSZjZoNm9MOWtUTEk3TlB5dTlZMnFIRk5RRWU1?=
 =?utf-8?B?THZsZXFNYVBsK3FoSkREVHE2SStmNHVGc3BLUUUyU2Z0NGZtVGl2WThXMVhV?=
 =?utf-8?B?Vm1WM0MzQ2k1elBhNkNTUUdNYTE2VGJkN21qOWpOYk53Mng5aFZjRzFSVGJG?=
 =?utf-8?B?WDBLdDNwYVZCMEZmSGMvc2R5UStFMzZFd2Fxd1R2cHFILzBWSGZQcjdQRlhW?=
 =?utf-8?B?UlBoNW1YbFBFV3lGQlU0Ry9YbWlrdkJ3OForaUlKNEJWaUpzRER3SzlpRGJx?=
 =?utf-8?B?V2RXZ0lSMkdyOEtMVW9od3RnU2U1Y0FldSsxNFA3ZTdVREpCdmc2NVJRd2JS?=
 =?utf-8?B?MGJ6RWlQUEVvU1RRMVZLbnphVkVtQ2UxckhtWUNGeWlNSmZpOGI4ZmIxV1ZF?=
 =?utf-8?B?MzQreDgxVHhJSUxYWG1aUnlBQUhuWjJ6dFdKU2tzaGh6UjV4b3lEYzFTb01i?=
 =?utf-8?B?NnFEZXM1OXpYNGxOY2s5eFF1VkJmUFhhM3N6U3ZERUYwaFZHNmhTZmhXV2tK?=
 =?utf-8?Q?DScyApdr1kymO2HNS9SsF/jSFL6GK+y0mnlB35+/9MRRk?=
x-ms-exchange-antispam-messagedata-1: q3vSc1z4OHmu9aPaJt9wuA04gDbEVu0ii/c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2672BE3A17EF7B4BAEA80D8AF95869C5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5FNf3qMv8emZKhw1DJaQ0eFTFkNPXnnwpWiumdoDbNY5WZ6J5nonaZ6F+CJ+8bHY3zFaq2qxLwCUcsgadvsTPngu/sCSsaSoO9+bbVNG8jjFGqemLGV/qUXRg24JGHEESj1S0l1MS4t45gYt4LUvY4MmUGm7WeNx+isP+3RE752Q5eh0bmmm6IfBb/AFMEzQDDGXYlmX/Xf/eNGzwczLE3IWU6RmXKND31VbNb6vdlvfEjtcghuXyTrJOOSBd86tdVeHiIA62HvIfobMVGa6PpHbzvJb5ZqCWQnXMFcxtcZsCNOGZME+K0DJYIjhQ+08635qCjak33LNMlkb7ql/SQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QOXb8vqfLlug99SnTzKv65N/bGOzGiS419WZFfPJi4xpgPaBLispCK/PQXDDNgCL6Ul2BOD/ZacYKA5p3jXJV0p1DiWRZLf8QUyNmX4knIf6eHLNGNWJjRsDiZWRmenlWSvE34U/sQXUiV14zODDeAHqUmrlHfYKLVqg/tVD0pQeU/qoYVq5ioIHNM2rp83dN7/0nIPsmcAjisJY/eDpbJLq95/liT+GEjHBIN6uQrppY3jQDPJjz8L6MlEvwHlNgdUkdfOXfTrSOIuutPlmcBcyx+qfpz1+sjlTaNSgow14Sd9sxayMldYtqzrO3AClB1SCBqVctux1pAJenDc81jVOK01bdZICQz4839Qiy6mSpGZA1xxkTCoeIRPBuN2AvhGG1ytS4MCVokT3ELmTnLKe2UFfthk9vxXOKCdbQZQ26M3WWhtr9bf3GfL8ePsrWKYJmb+KCNYNbU9xmiAMEJssjLpZ19Ga8oR2djItHcTFmmhm3Rak25GJaW6YhOCQnli3ZqhQ/3qNoslkwfCabdJh9sjHtbWJuXxqIKKmMbnbRf22TYVD5pi16kT+84ARdfbtzcC1e84uUQOx5wUL96RWFIdf0DmDPBQcwypPto27oQBGX/UPRuLXIAgkYurf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84683004-4582-43dc-cd3b-08df3320ac4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 05:19:13.2549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: puiDLw0lqq4WeeDtv28eMmenLnWzR3I1JQtsfs/LNqmuAqUfE4tlZUTENrlrL5Ucu/8swjARZqxJcXLxXimN7S6Rua+5bL343MuX19CmiaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8901
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=752564754=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTEwLTIzIGF0IDA4OjMwICswMjAwLCBBbnRvbiBKb2hhbnNzb24gdmlhIHFl
bXUgZGV2ZWxvcG1lbnQKd3JvdGU6Cj4gbXN0YXR1cyBhbmQgbXN0YXR1c19ocyBhcmUgdWludDY0
X3QgYnV0IGFjY2Vzc2VkIHRocm91Z2gKPiAKPiDCoCB0Y2dfZ2VuX1tsZHxzdF1fdGwoLi4uLCBv
ZmZzZXRvZihtc3RhdHVzKSkKPiAKPiB3aGljaCBvbiBhIGJpZy1lbmRpYW4gaG9zdCBydW5uaW5n
IHJpc2N2MzIgaW5jb3JyZWN0bHkgYWNjZXNzZXMgdGhlCj4gdG9wIDMyIGJpdHMgcmF0aGVyIHRo
YW4gdGhlIGxvd2VyIGJpdHMuCj4gCj4gV2lkZW4gdGhlIG9wZXJhdGlvbnMgdG8gNjQgYml0IHNv
IHRoZSBsb3dlciBiaXRzIGFyZSBtb2RpZmllZC4KPiAKPiBGaXhlczogMjg0ZDY5N2M3NGVmICgi
dGFyZ2V0L3Jpc2N2OiBNZXJnZSBtL3Zzc3RhdHVzIGFuZCBtL3Zzc3RhdHVzaAo+IGludG8gb25l
IHVpbnQ2NF90IHVuaXQiKQo+IFJldmlld2VkLWJ5OiBUb21tYXNvIENhbGlmYW5vIDx0Y2FsaWZh
bm9AcmVkaGF0LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBBbnRvbiBKb2hhbnNzb24gPGFuam9AcmV2
Lm5nPgoKVGhhbmtzIQoKQXBwbGllZCB0byByaXNjdi10by1hcHBseS5uZXh0CgpBbGlzdGFpcgoK
PiAtLS0KPiDCoHRhcmdldC9yaXNjdi90Y2cvdHJhbnNsYXRlLmMgfCAzMiArKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyks
IDE2IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL3RyYW5z
bGF0ZS5jCj4gYi90YXJnZXQvcmlzY3YvdGNnL3RyYW5zbGF0ZS5jCj4gaW5kZXggZWRlOWMyNTYz
Zi4uNzliMGY0NDRlZiAxMDA2NDQKPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL3RyYW5zbGF0ZS5j
Cj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy90cmFuc2xhdGUuYwo+IEBAIC02OTMsNyArNjkzLDcg
QEAgc3RhdGljIFRDR3YgZ2V0X2FkZHJlc3NfaW5kZXhlZChEaXNhc0NvbnRleHQKPiAqY3R4LCBp
bnQgcnMxLCBUQ0d2IG9mZnMpCj4gwqAgKi8KPiDCoHN0YXRpYyB2b2lkIG1hcmtfZnNfZGlydHko
RGlzYXNDb250ZXh0ICpjdHgpCj4gwqB7Cj4gLcKgwqDCoCBUQ0d2IHRtcDsKPiArwqDCoMKgIFRD
R3ZfaTY0IHRtcDsKPiDCoAo+IMKgwqDCoMKgIGlmICghaGFzX2V4dChjdHgsIFJWRikpIHsKPiDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPiBAQCAtNzAzLDE1ICs3MDMsMTUgQEAgc3RhdGljIHZv
aWQgbWFya19mc19kaXJ0eShEaXNhc0NvbnRleHQgKmN0eCkKPiDCoMKgwqDCoMKgwqDCoMKgIC8q
IFJlbWVtYmVyIHRoZSBzdGF0ZSBjaGFuZ2UgZm9yIHRoZSByZXN0IG9mIHRoZSBUQi4gKi8KPiDC
oMKgwqDCoMKgwqDCoMKgIGN0eC0+bXN0YXR1c19mcyA9IEVYVF9TVEFUVVNfRElSVFk7Cj4gwqAK
PiAtwqDCoMKgwqDCoMKgwqAgdG1wID0gdGNnX3RlbXBfbmV3KCk7Cj4gLcKgwqDCoMKgwqDCoMKg
IHRjZ19nZW5fbGRfdGwodG1wLCB0Y2dfZW52LCBvZmZzZXRvZihDUFVSSVNDVlN0YXRlLAo+IG1z
dGF0dXMpKTsKPiAtwqDCoMKgwqDCoMKgwqAgdGNnX2dlbl9vcmlfdGwodG1wLCB0bXAsIE1TVEFU
VVNfRlMpOwo+IC3CoMKgwqDCoMKgwqDCoCB0Y2dfZ2VuX3N0X3RsKHRtcCwgdGNnX2Vudiwgb2Zm
c2V0b2YoQ1BVUklTQ1ZTdGF0ZSwKPiBtc3RhdHVzKSk7Cj4gK8KgwqDCoMKgwqDCoMKgIHRtcCA9
IHRjZ190ZW1wX25ld19pNjQoKTsKPiArwqDCoMKgwqDCoMKgwqAgdGNnX2dlbl9sZF9pNjQodG1w
LCB0Y2dfZW52LCBvZmZzZXRvZihDUFVSSVNDVlN0YXRlLAo+IG1zdGF0dXMpKTsKPiArwqDCoMKg
wqDCoMKgwqAgdGNnX2dlbl9vcmlfaTY0KHRtcCwgdG1wLCBNU1RBVFVTX0ZTKTsKPiArwqDCoMKg
wqDCoMKgwqAgdGNnX2dlbl9zdF9pNjQodG1wLCB0Y2dfZW52LCBvZmZzZXRvZihDUFVSSVNDVlN0
YXRlLAo+IG1zdGF0dXMpKTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKGN0eC0+dmlydF9l
bmFibGVkKSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGNnX2dlbl9sZF90bCh0bXAsIHRj
Z19lbnYsIG9mZnNldG9mKENQVVJJU0NWU3RhdGUsCj4gbXN0YXR1c19ocykpOwo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHRjZ19nZW5fb3JpX3RsKHRtcCwgdG1wLCBNU1RBVFVTX0ZTKTsKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0Y2dfZ2VuX3N0X3RsKHRtcCwgdGNnX2Vudiwgb2Zmc2V0
b2YoQ1BVUklTQ1ZTdGF0ZSwKPiBtc3RhdHVzX2hzKSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdGNnX2dlbl9sZF9pNjQodG1wLCB0Y2dfZW52LCBvZmZzZXRvZihDUFVSSVNDVlN0YXRlLAo+
IG1zdGF0dXNfaHMpKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0Y2dfZ2VuX29yaV9pNjQo
dG1wLCB0bXAsIE1TVEFUVVNfRlMpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRjZ19nZW5f
c3RfaTY0KHRtcCwgdGNnX2Vudiwgb2Zmc2V0b2YoQ1BVUklTQ1ZTdGF0ZSwKPiBtc3RhdHVzX2hz
KSk7Cj4gwqDCoMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqAgfQo+IMKgfQo+IEBAIC03MjYsMjEg
KzcyNiwyMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbWFya19mc19kaXJ0eShEaXNhc0NvbnRleHQK
PiAqY3R4KSB7IH0KPiDCoCAqLwo+IMKgc3RhdGljIHZvaWQgbWFya192c19kaXJ0eShEaXNhc0Nv
bnRleHQgKmN0eCkKPiDCoHsKPiAtwqDCoMKgIFRDR3YgdG1wOwo+ICvCoMKgwqAgVENHdl9pNjQg
dG1wOwo+IMKgCj4gwqDCoMKgwqAgaWYgKGN0eC0+bXN0YXR1c192cyAhPSBFWFRfU1RBVFVTX0RJ
UlRZKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoCAvKiBSZW1lbWJlciB0aGUgc3RhdGUgY2hhbmdlIGZv
ciB0aGUgcmVzdCBvZiB0aGUgVEIuwqAgKi8KPiDCoMKgwqDCoMKgwqDCoMKgIGN0eC0+bXN0YXR1
c192cyA9IEVYVF9TVEFUVVNfRElSVFk7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqAgdG1wID0gdGNn
X3RlbXBfbmV3KCk7Cj4gLcKgwqDCoMKgwqDCoMKgIHRjZ19nZW5fbGRfdGwodG1wLCB0Y2dfZW52
LCBvZmZzZXRvZihDUFVSSVNDVlN0YXRlLAo+IG1zdGF0dXMpKTsKPiAtwqDCoMKgwqDCoMKgwqAg
dGNnX2dlbl9vcmlfdGwodG1wLCB0bXAsIE1TVEFUVVNfVlMpOwo+IC3CoMKgwqDCoMKgwqDCoCB0
Y2dfZ2VuX3N0X3RsKHRtcCwgdGNnX2Vudiwgb2Zmc2V0b2YoQ1BVUklTQ1ZTdGF0ZSwKPiBtc3Rh
dHVzKSk7Cj4gK8KgwqDCoMKgwqDCoMKgIHRtcCA9IHRjZ190ZW1wX25ld19pNjQoKTsKPiArwqDC
oMKgwqDCoMKgwqAgdGNnX2dlbl9sZF9pNjQodG1wLCB0Y2dfZW52LCBvZmZzZXRvZihDUFVSSVND
VlN0YXRlLAo+IG1zdGF0dXMpKTsKPiArwqDCoMKgwqDCoMKgwqAgdGNnX2dlbl9vcmlfaTY0KHRt
cCwgdG1wLCBNU1RBVFVTX1ZTKTsKPiArwqDCoMKgwqDCoMKgwqAgdGNnX2dlbl9zdF9pNjQodG1w
LCB0Y2dfZW52LCBvZmZzZXRvZihDUFVSSVNDVlN0YXRlLAo+IG1zdGF0dXMpKTsKPiDCoAo+IMKg
wqDCoMKgwqDCoMKgwqAgaWYgKGN0eC0+dmlydF9lbmFibGVkKSB7Cj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdGNnX2dlbl9sZF90bCh0bXAsIHRjZ19lbnYsIG9mZnNldG9mKENQVVJJU0NWU3Rh
dGUsCj4gbXN0YXR1c19ocykpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRjZ19nZW5fb3Jp
X3RsKHRtcCwgdG1wLCBNU1RBVFVTX1ZTKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0Y2df
Z2VuX3N0X3RsKHRtcCwgdGNnX2Vudiwgb2Zmc2V0b2YoQ1BVUklTQ1ZTdGF0ZSwKPiBtc3RhdHVz
X2hzKSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGNnX2dlbl9sZF9pNjQodG1wLCB0Y2df
ZW52LCBvZmZzZXRvZihDUFVSSVNDVlN0YXRlLAo+IG1zdGF0dXNfaHMpKTsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB0Y2dfZ2VuX29yaV9pNjQodG1wLCB0bXAsIE1TVEFUVVNfVlMpOwo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRjZ19nZW5fc3RfaTY0KHRtcCwgdGNnX2Vudiwgb2Zmc2V0
b2YoQ1BVUklTQ1ZTdGF0ZSwKPiBtc3RhdHVzX2hzKSk7Cj4gwqDCoMKgwqDCoMKgwqDCoCB9Cj4g
wqDCoMKgwqAgfQo+IMKgfQo=

