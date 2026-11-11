Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83BC606A32D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=qbTidVIp;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=NASFb6br
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR0Yr-0004IT-DV; Wed, 11 Nov 2026 00:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xR0YM-000494-7W; Wed, 11 Nov 2026 00:07:24 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xR0YK-00063p-ES; Wed, 11 Nov 2026 00:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794373640; x=1825909640;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Di64B2OCJcIZFF5Df+siMgvFu3DaIY7mpxNJZVLKBlM=;
 b=qbTidVIpCVB+dAgL4CCJJ8ZdDThuu8tAfLBuB0SdlW41tGMricLiJOv6
 dPppR+lqhcFYTxjUZaDz/nhqQjK2pnb7Pki5yc17mFMbX30h5vDqo+HrR
 A4S5ZEsIyqWfBRksOi1dm2emN41YgvkWmiyUcEwWzcGGJbCtloBqgJf5a
 Lsw5/2wJzsGDSMb9qw3LQJB7NCxCuOowAAtQPi7SJpF8Vokeufu9KQgtm
 5/wA46C0XOgrkdqYQIqcbI/QlCT/aQ9UaFcTxA7sR3Jgvs2jbPih/OGRQ
 mB6KkFnB+kMNULSuQqw/CldEBKsEFllYkmQd4qWr36rxuR3QSwf+YufCm Q==;
X-CSE-ConnectionGUID: WjmyLBfMRu6xZ+EArJ+hGQ==
X-CSE-MsgGUID: wVXO7iFkQYeKOBINIyXaog==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; d="scan'208";a="161577756"
Received: from mail-southcentralusazon11012036.outbound.protection.outlook.com
 (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.36])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Nov 2026 13:07:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emExH3NkD4+k8JydR9Or9YuQGSGKWiixloXsZI1PEDV5kEl6Y80hz6UBk+S04FYMbWyO9CK2XCiez/CVZ19PVZXM6p+zCMS8cbur+gzflpwhhJLaNhcFpLEHb0Pd56QNPvDr0QueE5cgFzG72CQWRUcwvMusJHe0Q9uN5u1+iyY7spQKHEmi7jmLXSDhyOYGjAGn9lPqlxNR53ga5jvpWvudx5ixrZ3mhPpZa+E/ufg97bGYXi/J6Y/e+pLpXgaJDHapGxywRIN45Yup9uDhbY3avGw24ZUggFZtrEfQmis/euwr2D3BSeGcQvAqszBnCjjXnO8UmiQJGuvDB+IbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Di64B2OCJcIZFF5Df+siMgvFu3DaIY7mpxNJZVLKBlM=;
 b=kIjw5zbAP8+mYukab3neEuioHeH5tGfzVGjZhdTPWfWcFbBIed2QWZmARCfNQgVHRLkZsfZ1rqsopxuqoXiAPJghKbOcguaIZclSwnfItVezmWUKa2zOX5AOa+i8cHqF24FNPPIbktNqt14RFsaFFSf9Q2qa/7t5xa2sytgTQAMHG4agunJsnhCrdQeXfq4lpjfvFjUj/rGNfsOh9E6vGsG45lZGP+nDFO4DKS8eRPMhh7NAT/I3qHu8r+hFZ7Nckh1CWED4AfwxzokDbSZxuWLoFE0k/DQjvbunLZe3uZ9+6s12HbDuoxp32Fe6GWKnXSNuyleA6UTf4GvRPekaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Di64B2OCJcIZFF5Df+siMgvFu3DaIY7mpxNJZVLKBlM=;
 b=NASFb6brzfwjf6xosiBPrhtnpxwYZRa/9uLXr3axx2T/5E1edNi2KXjvF1VFBDZO4Yl8VKF65LdeCNJ0bBcBdBhVUs4rMYdQ2mX3aKYN74PAQPyuo/w5OJilj1SdQPFCIZwGBo1xitEHiQ3vardR5k2gqrNAHNInxJLtMxYIjE4=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by PH8PR04MB994610.namprd04.prod.outlook.com (2603:10b6:510:706::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 05:07:15 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 05:07:15 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "palmer@dabbelt.com" <palmer@dabbelt.com>, "wang.yechao255@zte.com.cn"
 <wang.yechao255@zte.com.cn>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "liu.xuemei1@zte.com.cn" <liu.xuemei1@zte.com.cn>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v5 0/4] riscv: AIA: Add in-kernel irqchips save and
 restore function support
Thread-Topic: [PATCH v5 0/4] riscv: AIA: Add in-kernel irqchips save and
 restore function support
Thread-Index: AQHdZPOqewKSTobltkGoyMOLhbF+8bcoayAA
Date: Wed, 11 Nov 2026 05:07:15 +0000
Message-ID: <9a1fb27312850b3366b71c6f73a8309d271a0d56.camel@wdc.com>
References: <20261026024048.630015-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20261026024048.630015-1-wang.yechao255@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|PH8PR04MB994610:EE_
x-ms-office365-filtering-correlation-id: 79b1c636-f2e0-4a53-d034-08df3fb1a731
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|23010399003|366016|19092799006|6133799003|261009223027099003|10067099003|4133799003|261028144727099003|261102123227099003|261026140227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|56012099006|38070700021|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: uFnRvmHkmtL3gwQGF9yrfJ76s42WnmZzSGMyOnKRk29O9b/LfQHNV897ieGuufvKUW0cfjZDs8CAe68vpJQ79gDXY97U3qln+LC4AfIV1Di0OisFW2rRTvAJt2ZcODu8E1a4qqBXEfU5wypcxeobu18eA/cXJjAVopxv2+oqqAhLLWI0vNxX38xDeEJdHe6jdA9DDZW/zfPyQyt3ryV4ndCocIg4Qw0nZL3uPJUUjiRYr2pxtItRaVV4D6hkxOmpqE835K6OJIIiBV4WhLCjfbpHzZGwc3+J5ohnToNlp66kOHbIQ37PpGOmr/nd7O0B4pL/MFiuoF1yDnw/dx8h6Qb9wbCXUbV3VhDZja+vAPc4iB5ItKmjROr2+1jM/kwPuItPCa+78rMIpMnoHW0fO/uXFLjZ3JA+2F7Ox1F3IXKNDfnS/JsKbECXLvgfHpIC0iCPZYinXfP88BGOLy1OHnTHj5A7eCbcNhBWn9ehyXysrvZAVjXEHoSdZyfrbb5/hIfgEl6klO+qQ3vuSQML+Tx/E+8axdqa3BCpeRq5CqsG1ffNTWYDuYN5xaQyc56T9VJxPAbOQIK3VHDUpQIcspNEXxiTWQolA1cdgqWMS+Vwb6WWtUMVtwhQBxK7g2aEQyk71mQYgDxyiF6eRlo+xnjRlGXF1yDEU18zAxj/7o4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(366016)(19092799006)(6133799003)(261009223027099003)(10067099003)(4133799003)(261028144727099003)(261102123227099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(56012099006)(38070700021)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVZ6UUUrOXRkMTdndExYdnpJNzh0WEtoMHNDN2tHbHBlZkljcHZxbmpJRjUv?=
 =?utf-8?B?ZjdjNkZVUmxqTGpBeEhpclpBZ1VraUtHdjFhUmdFdG1RaDh3S0NJQWt2emxP?=
 =?utf-8?B?SjBiaWUyM0FKSmFiWE1PVDFjWnVVNHhrZ1lyTWZNd3JRd042R3p1VzhWcmhs?=
 =?utf-8?B?NEs1Wms0dTNTbkFTeVh0aXY2MXQ0TlRkTk5ZNFRsdSs1Um11VjBzWXJJUk1L?=
 =?utf-8?B?L0hBMEc0YnJ1Q2RUVnFBdDY0aWNFWFlCQjl4VGhaVDJwaGdBNTFmYncvSFBI?=
 =?utf-8?B?NlhaV0diVGlrNWtKZEphNmxVcnVEaWp0WlVOSzc0c1BSL0pveFNGdHptekVG?=
 =?utf-8?B?T0pUMXVkOHM4Smc4VHM2OEpUOUwzeHF6UC9udUkrWHlYMXVTbWVCMFNmSkdy?=
 =?utf-8?B?WTY5T25STnY2RUVIZUxEdTN0MXByNFIzZGVRWW0zakFMay9Qa2N1LzNLcENa?=
 =?utf-8?B?clV5RitUeDhLRGJrN1JLUjVUbVM5U1o1aEFGMHBscFpwMzUrZXVRZm9RQ2tU?=
 =?utf-8?B?bzMyM3Y4STNWQmlrNDVyVUVMV3pvTWRHdm42djJlVEdwNWxiczFhb1ppVFBB?=
 =?utf-8?B?UDFOV3B5dTNFV2c1QzJtMzFJU2htb3B0cnQwZTVrQnIyTkI0UE51L1h3M0Mw?=
 =?utf-8?B?Y0t2QUtFTngxcEVvS0RSclQ0ZW5ycmM4Vm9hbk9kcjI2b3lLaTdKdWZCdzZG?=
 =?utf-8?B?SUZFZCtDSGsycThnN3h5ZnhRcFVaQTg2Q2xiUFBkVmdwNGpoZCtRWXZCcHUz?=
 =?utf-8?B?MDBtWlg1NXMrNzJaQi8rckNRc0liTE5pbFRWYkNQOUFWU2ptYjhZOG1XK3lx?=
 =?utf-8?B?YzZ0RU9NYkZWcVJ0OHEwdjNXVXVkYXJramRuQmpjRlVZQldMRUUxc3FXeUxY?=
 =?utf-8?B?YkVRNU9zUEw4OUhSZFl5U3JlWDhTazlCcWt5Rys5N0Zpck9nSlJkdDA5VlVD?=
 =?utf-8?B?SEYrcHk4TExyTDl5MXNRQWtWNGt2bytCSk5wY3A2RS9QcUpqcUNZL1Z2U1dW?=
 =?utf-8?B?MWFjNEFvR0h1MytSNmZsakVZanpIc2ZqMU8rNkJiNG9ETHE0NWZ6cFVXQk11?=
 =?utf-8?B?MllIaTNXaWVLQ2FjTWpzTW4xY2xXOEtlR1dYbjZtdXhldkhNdDZza0g3cm96?=
 =?utf-8?B?UG5mcElwWGdqQ1dzdjVsOGUwUzZSaXc1eFdrSC9yVlMzTkpjaDRNYlpyT25H?=
 =?utf-8?B?TVRLdHkwNlorU1h3cXNoVTVOQ0hJYitxQUhxb2FHYnR3dDlOdWRPZ2RWVDd5?=
 =?utf-8?B?cDNqTzRQSTlueFBJUlhFS2F5LzhLYmJDajJOVzZSNEwzc0UxU04rNmQyemc2?=
 =?utf-8?B?WXRMQXViOGx2MlF2bXRkK0l5WmFYb2h3RTVNeWw4WXhwQXNtcjJkazgzSjRm?=
 =?utf-8?B?cFJsMWc0em1ZNC9FM0gyWjNUaU1vTC9GdjZ2QVA5cW1wNURJUS9YeFdrRVMz?=
 =?utf-8?B?WkZLYmZRdDhiRHhraFpPbHFmaUM2MGk5V2xtT2Y0U2M2eHNkS3FuemdaeDNt?=
 =?utf-8?B?dkljblM4c0cvSDVwMUVOZGFhV1hBL05Udko4NWwrOVdsaHVXaXlmcUt0a2R2?=
 =?utf-8?B?Rm1HcWdLUHdrVTBzMzB3SXdMRFEvU2tmRnIraEVsQldFc3grdHNWRG9JZFpL?=
 =?utf-8?B?V29vN0d6SUlZVXVRbFhrTXc0N0h0SHluOEI2cHNXU0F5ZHJYWmgwSHRpVW8z?=
 =?utf-8?B?YVlIRUdGdTdBZm9zQTM3TE1RVWc5d2RZNTFmeUhxeDZIVmVHL1BSQjNKSlp2?=
 =?utf-8?B?Zy84RGtmSElQdk8waG5OOGE5NUFDaDRkN3ZEcC9BZHpwLzlDcVRGYy8vSDB2?=
 =?utf-8?B?WWwrNU9BbkZJTmxVb2drTThtWTg3U29lZ09MSmVjbHp2NW16Q3lmbldyY0Yz?=
 =?utf-8?B?Q3AyUm1Wb0doQjJZRjl1ajVKZHlRTFQ0RXc3S0dWcnhJV0V5VDgvMk51T1dM?=
 =?utf-8?B?RnBVVkRxTjlaNDhBR0FqUnBBUVRnRU9rSjZDYWdBWThkTTBlRy9GWTVmdmhP?=
 =?utf-8?B?UTlnTVpIamhGamtxaHNVdkVJUERaRllsbmZxWUdNd2p6VU5oejlvaTkyMnp5?=
 =?utf-8?B?RlQ2b2ZlNWRPVVkvblBscXltSm1YU0RHYklMczlZRDhscVhHalRhSGJVTkxX?=
 =?utf-8?B?dTNzcDhBVHVNMmcxM1BiaXVtZ1NvNDF6dkdtZS90K1R6ZWlrTlRWQ01LL1ZE?=
 =?utf-8?B?Z21aQ3A3ejNySGFrcEZNNGJjMUI3cXZ2UkdYR2tyMlJUWjdURjFmSnplTUNP?=
 =?utf-8?B?aSt1L3M1WDlmemJMT0NvSjk1TWViYmJ3YnEwOHZPWGNSSm05aG1vSVdGTTcz?=
 =?utf-8?B?UmtOOE5XTUhsTnFUVXhrTkV1bHk5c1FvTGpad1B3Rm1zUFZsZFd1QkI1MVI5?=
 =?utf-8?Q?JG4NsHzMf856pFm1x5XAC77GjFC2H1Wo67ie8fED8g0tl?=
x-ms-exchange-antispam-messagedata-1: LMormypJDDiFxEq2O/J9cci1LTB/oug0fUg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F80F2CD315DB7A488D4A6E6ED870D8E1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VmFK14OT4Ub7zaq8RNal01gRroPHgiwKmREIEvXlRJ203Odvf8apge51maCURNV5kb3hzBexIxX+T7nJpxI79Mbztxm8SFhg73qmljtlorwgonji+cav8r1nlEgAt66WB8SMvNspc8NFQ1h/s1F24DhW1tK/3gSB12ReeMGY2wXLEhDB8MvYmACc7DhR6/pBPSMeLpwIS/nICBoUAqwvmyrOAPhcY6yhOwOQ+YKNurx+vHrY3kxIMWIP//HghzF06ZS8lppVhy51zVL2CQUD3iW3OV2hmDKnz2v1djVV3/TF4oPUNTjiUh8Txw4xmLLjg4CaP6T2mSguHoZ/llNJWA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TKXkQvJ3yWbVFhb9glusTAQcShe2k2kRXKBFHdk9OumD4NIpHF2mbwnX7yby5yzRQIGseYfs71o2eiwD4nMsgFK1dx8yK7NwDTN8VM3OB6ylcqTlSIKX/FNCUa9ITTUR7wWnXfTA/irq/X3/0YiIZRlIstnphpAODxBjCJbi+Rhg10PTfl/luHI1NpxIupXYwQfkLKS85/qszjGba0xtCSElLn1MBhgJctxEQ02WPXb/jmxpRkfVDxNjDgku2GGDIp7/JS4jaUOC+PCcK2VLyMbptGyJ07Jv4br4eQ5IgArKeKXh9dY3rDNXr9y/Tg2oMDuwhpddjfs8rwKLnEeMI2MKvYTtqNGn/p5YEUkpJhRV7gAbNxdbAGou2QAmMwtDb2YrAzHh+eRXpEWaz6JGUuZVlIUW1TbgKcmPvZwXHOjHWEbOjSu9f2P6K7lUuhgAGYEwh5x2YJEuGgqveQjAq0JMDyqRC4gYY0nwNJ/rP96qKU1TxJ9vN3lqE/AdP7dMvVr+arw/7NuWNgOkCl6mpIHo6m/o7NnSlJ9+zOHyQYNB/EdluNgLh3P1iLvf3tayMXvs3QYIc9Ss2E4V+Y5BqM2alRb+29jEELtE2beOhQQG+JGmftkwRWXc/YO1gFeU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b1c636-f2e0-4a53-d034-08df3fb1a731
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 05:07:15.6541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjCZe/yQF7Rx3Kpt9Sr10PKWmg2A7C8l4c3YsUvueIgHi6F8s8+szNsYMKZ6WuyA4rwugZpRu5BDVkHmtfBKxqkBgb+fCMDNMaQHwUWziIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB994610
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=76810307e=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTEwLTI2IGF0IDEwOjQwICswODAwLCBXYW5nIFllY2hhbyB3cm90ZToNCj4g
VGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciBpbi1rZXJuZWwgQUlBIGlycWNoaXAgc2F2ZSBh
bmQgcmVzdG9yZQ0KPiBvbiBSSVNDLVYuDQo+IA0KPiBDaGFuZ2VzIGluIHY1Og0KPiAtIEZpeCB0
eXBvcyBpbiB0aGUgcGF0Y2ggZGVzY3JpcHRpb25zLg0KPiAtIFNwbGl0IHRoZSBub24tUklTQy1W
LXNwZWNpZmljIGNoYW5nZXMgaW50byBhIHNlcGFyYXRlIHBhdGNoIChwYXRjaA0KPiAwMykuDQo+
IC0gRHJvcCB0aGUgVENHIHZtc3RhdGUgZGVidWcgZml4IGZyb20gdGhpcyBzZXJpZXMuDQo+IC0g
TGluayB0byB2NDoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MTAy
MzAyMTIzNy40ODYwOTEtMS13YW5nLnllY2hhbzI1NUB6dGUuY29tLmNuLw0KPiANCj4gQ2hhbmdl
cyBpbiB2NDoNCj4gLSBGaXggYnVpbGQgaXNzdWVzIGluIHRoZSBUQ0ctb25seSBjb25maWd1cmF0
aW9uLg0KPiAtIFJlbmFtZSBzZXZlcmFsIGZ1bmN0aW9ucyB0byBtYWtlIHRoZW0gbW9yZSByZWFk
YWJsZS4NCj4gLSBGaXggdGhlIG1pc3Npbmcgc2VjdGlvbiBmb290ZXIgcHJvYmxlbS4NCj4gLSBB
ZGQgcGF0Y2ggMDQsIHdoaWNoIGZpeGVzIGFuIGFzc2VydGlvbiBmYWlsdXJlIGR1cmluZyBzYXZl
IG9uDQo+IMKgIC0tZGlzYWJsZS10Y2cgYnVpbGRzLg0KPiANCj4gLSBMaW5rIHRvIHYzOg0KPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwNjAyMTQyOTMwMzAwcXRPTnk3
UDJEa0RNNDBCWF9UM19BQHp0ZS5jb20uY24vDQo+IMKgDQo+IENoYW5nZXMgaW4gdjM6DQo+IC0g
UmVtb3ZlZCB1bm5lY2Vzc2FyeSBjaGFuZ2VzIGluIGJpdG9wcy5oDQo+IC0gTGluayB0byB2MjoN
Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDMwNTE3MTcyOTI5MVp6
ZnhtcVo0OFAyVGJ6OVRHQ3RTVEB6dGUuY29tLmNuLw0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4g
LSBBZGRlZCB0aGUgQklUU19UT19VNjRTIG1hY3JvDQo+IC0gQWRkZWQgdGhlIG5yX2VpeCBmaWVs
ZCBhbmQgZHluYW1pY2FsbHkgYWxsb2NhdGVkIHRoZSBlaWUvZWlwIGFycmF5cw0KPiAtIFJlcGxh
Y2VkIHRoZSBDT05GSUdfMzJCSVQgbWFjcm8gd2l0aCBpc18zMmJpdCBib29sZWFuIGZsYWcNCj4g
LSBMaW5rIHRvIHYxOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYw
MjI3MTgwMTA0Nzk0WXZXOVJiMklfa0FHelVydVpMMTFRQHp0ZS5jb20uY24vDQo+IA0KPiANCj4g
V2FuZyBZZWNoYW8gKDEpOg0KPiDCoCBpbmNsdWRlL3FlbXUvYml0b3BzOiBNb3ZlIEJJVFNfVE9f
VTY0UyB0byBiaXRvcHMuaA0KPiANCj4gWHVlbWVpIExpdSAoMyk6DQo+IMKgIHRhcmdldC9yaXNj
di9rdm06IGNyZWF0ZSBrdm1fcmlzY3ZfYWlhX2FjY2Vzc19yZWcNCj4gwqAgaHcvaW50Yy9yaXNj
dl9hcGxpYzogQWRkIGluLWtlcm5lbCBhcGxpYyBzYXZlIGFuZCByZXN0b3JlIGZ1bmN0aW9uDQo+
IMKgIGh3L2ludGMvaW1zaWM6IEFkZCBpbi1rZXJuZWwgaW1zaWMgc2F2ZSBhbmQgcmVzdG9yZSBm
dW5jdGlvbg0KDQpUaGFua3MhDQoNCkFwcGxpZWQgdG8gcmlzY3YtdG8tYXBwbHkubmV4dA0KDQpB
bGlzdGFpcg0KDQo+IA0KPiDCoGh3L2ludGMvcmlzY3ZfYXBsaWMuY8KgwqDCoMKgwqDCoMKgwqAg
fCAyMDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gLS0NCj4gwqBody9pbnRj
L3Jpc2N2X2ltc2ljLmPCoMKgwqDCoMKgwqDCoMKgIHwgMTgwICsrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLQ0KPiDCoGluY2x1ZGUvaHcvaW50Yy9yaXNjdl9hcGxpYy5oIHzCoMKgIDQgKw0K
PiDCoGluY2x1ZGUvaHcvaW50Yy9yaXNjdl9pbXNpYy5oIHzCoMKgIDMgKw0KPiDCoGluY2x1ZGUv
cWVtdS9iaXRvcHMuaMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+IMKgbWlncmF0aW9uL3Zt
c3RhdGUtdHlwZXMuY8KgwqDCoMKgIHzCoMKgIDMgKy0NCj4gwqB0YXJnZXQvcmlzY3Yva3ZtL2t2
bS1jcHUuY8KgwqDCoCB8wqDCoCA3ICstDQo+IMKgdGFyZ2V0L3Jpc2N2L2t2bS9rdm1fcmlzY3Yu
aMKgIHzCoMKgIDEgKw0KPiDCoDggZmlsZXMgY2hhbmdlZCwgMzU3IGluc2VydGlvbnMoKyksIDQz
IGRlbGV0aW9ucygtKQ0K

