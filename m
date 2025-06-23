Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36CDC7115C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 03:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTXml-00060K-FL; Sun, 22 Jun 2025 23:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uTXmj-0005zu-80; Sun, 22 Jun 2025 23:23:53 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uTXmg-0001gn-3A; Sun, 22 Jun 2025 23:23:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CwgAYD6OeixsHK9ktFXBYzLM6QhS1nFn+Nk7sbPc2IhuYVagAKiDWAlEUBfp9DsV4wMoHWC60z2ixV3LXWjz2fjc6c8o/JhZfKfGmiuTAP1+Ax2R8udYgwT+fInzmhQundrGPOGvcEKbO18mJRkj+0xsFBgpHJ93L7mrR0NNJNns+bRZwq6Ff4T/uPM+9drF7vu1A6+3/MjxVlj+ItYJFnPll1u1H+1jjZQC1e7vaqbOemFHtKfLxt8h1TA49YvGGrXPkk+uW/hkWb7Gw6USMMSK9XSXHe8+SHbSSXslwwLsjiPeG5ajbhwN2VksNuSU/bu8/1SLCWn4Ifnt0Hk8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJKCUvlDad2r5vnuiqY65HpkCxDd9jl7spVVKdHPiFw=;
 b=Dpz3sk/oDY68DcVPM3XEs4+wej6r8EFGT/9x18ECLTYKfX/ECi7m46xo0yw/5eHkQz20UKOHhfbnRR+k/ZuAfmOFkyrc5TNPcclKcs1OfPvClJKeYAkTRMXdrr1kZn6tN3+df0DKh4n2QmzdXNKZZ1iCxoYFjPULOAYAkVyNc5sJ1dKp4+9SHE+k9RWUBUcLZB6/ZhUcNyzGsXMx8Xu329TCvX28rcZ71OTPR1z2UrIQseghUgEmLNTPDD/Gu0RokVLRJBJ2UaQ+tHFKseqsvOEcaojrFa2bXO11XwC1IokqYCpbZdN+eFAB9WJKIVnogypR2Kykxl67NcuDM+6utw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJKCUvlDad2r5vnuiqY65HpkCxDd9jl7spVVKdHPiFw=;
 b=cfWci/iPZqkQGrTc6rUjutmr6SFYqRmXgnjk0SoZLPLkHjj6Qzs4wyFwSSooZYFGvL2FV5T9FimzCwnzaH66oe0C0ZKDvzdoztF7ObPby/2TkST2qQcRTFWiimZIFzxyLO/0S63zg8aR06e7AdU+U6igH+l7RWglUXuQ3VAlMZ9mSnqrQdsCymaqcWxohneW1j9RGdb0Fi1+ZRRFnF3NdD5w7oGePZwSwAtODmO4wcb0hz35V31UM5eCZsmv9oRMZHO/HpW1T59lhxTLDCkVEsI8fZ5MOA/dDWfVPNU5mKx0CiP+l101+/6VaEPAiZtdpYvL3L/2cMybE9qHMg9KoA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB6991.apcprd06.prod.outlook.com (2603:1096:405:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 03:23:38 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%7]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 03:23:38 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [RFC v5 0/4] Add QEMU model for ASPEED OTP memory and integrate
 with SoCs
Thread-Topic: [RFC v5 0/4] Add QEMU model for ASPEED OTP memory and integrate
 with SoCs
Thread-Index: AQHb4OUsPyuEB5TGgU+9NGrvGErWJbQLivWAgASPVMA=
Date: Mon, 23 Jun 2025 03:23:38 +0000
Message-ID: <SI6PR06MB7631674C7B714E76F25E78A2F779A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250619064115.4182202-1-kane_chen@aspeedtech.com>
 <7abd4507-46e3-4848-8f54-928998c64565@kaod.org>
In-Reply-To: <7abd4507-46e3-4848-8f54-928998c64565@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB6991:EE_
x-ms-office365-filtering-correlation-id: 8b855506-5ea9-4dc4-ef47-08ddb205588d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WUxNRG5ncEMvVEZxWUs2Q3lKS2N2RjhtUWlaVFQ5aDI4WlBsbmxHdVg2RmI4?=
 =?utf-8?B?K3dMOTFVM2lOUG5CdnBVRjRUTkU2ZFA2T3lNZTJLQ2M5TnM1UHBEVUhZc2tW?=
 =?utf-8?B?N1dKNkpENEZkVlVrb1JIckplbDRoVVlBZm1rcmV6NFc0MmpLcEdRcllSRUc2?=
 =?utf-8?B?bEhCT3p4NVB0cGRBakRQM29mb2pMZWhOanRCdVVPeXpPSzh2MHpsMDIyV0NV?=
 =?utf-8?B?bFNkd2NLbUtIZ09raE9MaEQ2a3E3NVVzU3dsSTNoR05IV2Uxa0Y0OFVvTHF1?=
 =?utf-8?B?cGk5MWt4ZHVnSHFFd0tOVFl2ODZNUW0xZVU0V1FTSFBYN1BzNkF2WnJhTUdW?=
 =?utf-8?B?OHJPTC9NVHR6NEp0NDRnSzluLytwMExYazJpbzhMT2hHMlkzUEI2YXV6UVdu?=
 =?utf-8?B?ZlJtWlRuMWZMNU9ENVZsOHhPTWlrM0JyL2pQK2srbnVzN3BDUUIyTWs1ZWNH?=
 =?utf-8?B?N2Rmc1ZaQ1dWYTNYQlZVRWFmV3cvRDJINlVHbjhNVEorRjJHNDlhdHlnS2Np?=
 =?utf-8?B?UjdrNERlYnBSTzhqTStSTmdtVjk4SUFDTlh6ajAwL2Z5V3lWaldMUEY4QllF?=
 =?utf-8?B?b21qekdYUFFweHJYVUt3a3RBV2l4dlZsdjNDNUxsdDNlOTZpUXJsaEFMMlB2?=
 =?utf-8?B?b1E2cFVFalFvQ0RyL3MyK2JGa3VVVU9uSXFNOERpZDNpeU5NcGt4WkRIbHpz?=
 =?utf-8?B?L0FqTlpTdzlHa0NOVjh6QWhQWEJMNGtBTHdzUmMrWVRBZHFxR1ZnNkdUUFRO?=
 =?utf-8?B?bXhxTFZNTis5MFVWLzBpQzR5bjJGVG5lUGgvbWFpTVJ1eFk2dVlkUzV1WHJG?=
 =?utf-8?B?U1JKL3l1R0Q3ZHZXZ2JBcjV3UjZyT0pUNEdkSDZYZFZobWtaNDNWc1FhczFB?=
 =?utf-8?B?aFdwbzljUCtxTExXbGlOaGpPcFVMM29IZ0xIb1pHTDBMb3JZcVpHSjg5VTdj?=
 =?utf-8?B?Tk4zOTNUWWdHTkdkYXg2Y1FlWWxhdDN0bk9XQWV5WlY3Z2haNUl3eVZGMDdz?=
 =?utf-8?B?bnRLVzNCanJRdkI4WE0waW82NXExL0thZWxuNzBtcGxOcGs3aWZuOHd2NG9x?=
 =?utf-8?B?TWVwYmxSZG1YMU1lanpmekZHNFBCK3ZBV0VXWmRmbDFPSytKODdVZk1tbS9n?=
 =?utf-8?B?TUQwM2hSZWxnTEpLeVAvKzh4emIwNjFHaXlKc3BLRmFhMnhnS09naWk5aEcx?=
 =?utf-8?B?ZS8xbmdtMkI3eXRkd09mMlpsQkphcmc2dTFITVhDYUljWi9HRGxHS28xVTZB?=
 =?utf-8?B?dHZNOUtMcjNUa0I0bjRCNzl6ZFZxUzdnREZCdUtWck85YUIvWXlwV0pUbzRH?=
 =?utf-8?B?QVpjTXgzTmsrdXFjeEVBdCtORi9yNVNORWMza1hJVWUwb3JNVWVyYzc1YmRn?=
 =?utf-8?B?TkFDUER1Tkd0VHhBVzhVQTYyTmIwazUxSUdXeUZIUXdZOHRlT3ZRUkJQTnlm?=
 =?utf-8?B?V1NDSGgxRDgvdGtkTnJua2kxNXpqaFpLbHh5eE5yN1Uwem95UXpNUnFidSt4?=
 =?utf-8?B?eWJLdGlFSndqcFlpS3dqTW1RMzZ3SU41OFI0YVhzdXRLNzJhbHFyU0lGbm1Y?=
 =?utf-8?B?ZjNPbTc2NXdoSDEwQVZHSTJJc3ErQ21Jcm9CTjhvRG80ZUZLR2dDb0dzeC9D?=
 =?utf-8?B?TktKcXkvUElQNGlucDZOM2IrbDJnUGlRQUdUU2xSOGl1Z1VySDkyWWN6QTBG?=
 =?utf-8?B?cEpBOE5QajhEZWJ0UG44aTJlbkJ1cTJZVHVDZGlGTGNRTEYwekRsc29kUjZI?=
 =?utf-8?B?d0hvMnZFSGlaVzFSRVNCQVNWeTQzOCtqVEJYTW1qK3NSMXBKVmpETnAwY2FO?=
 =?utf-8?B?MmxwSWROVEJDb3puNHUvRWNVY3Q3VHZYdkwzSlU5M1FnVHpXd3ZNK0xleGRL?=
 =?utf-8?B?MGtxY1NMU3ZjOXZFaHdGZUI0QndKTmlQcUJQMkhjKzU1aGExV0hDSEo4MnND?=
 =?utf-8?B?STRUaVRKVGc4MjFyYjgydnZWMDJ5cVAreUtIYXFCZ0cwTkRmcnVnalBKck5Z?=
 =?utf-8?Q?gobJ/md6NxUqe2Jexh34PbEXjHi46A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVFwLzYzdVVXNmhoenZaSVhXa3UwVXFhY3NFNURnUkFFY1ozZUt5dmxaVVRn?=
 =?utf-8?B?VWUyMUhPQi9VTzZzTDFQeEdvUElleUNxaEFhbHg4NmJBN1gyNGY2Z29ZamRR?=
 =?utf-8?B?SXNHeUlWeXBWZFlWMVI5NUhCSG9obWJlbVc1aEZSZ3MvZTZUZXpoamF1WDJQ?=
 =?utf-8?B?amJCM3RIcTZpY3JiTEFEK212djF4YU5xU1kvQm5FNVduMHFBdndKMGcxQ0Ex?=
 =?utf-8?B?STZGSUsvMFplMTFGcXBkb2lDaERodU5LcnhTdVNzQ2ZuNHd4Y1JDbFpJeFpq?=
 =?utf-8?B?VUVmZmFLS2RtZ2ZVT2dwL1owVmo2OTVZR1RQeWhFdTNSbGdVbms0NDQ1MVc2?=
 =?utf-8?B?TzB5WEhQa0pReXprRUwxU1ZlZ1JuV2xUeHlVWThnTEpSK0FYdDlCZWhTeE9F?=
 =?utf-8?B?TXVNTjAxMmhHblVQSFA5aGVlS3JHQUhEM2k1bk4vemR3NkUzMDBhbVkwUXBN?=
 =?utf-8?B?cUZsTjRtWWZReW10Y3BHZEJDc01Rdlg4Yk5zR1VhaVpBN3hwNStFdksvRnZ1?=
 =?utf-8?B?Zjhxc3djek9MUmE0ZDNLQVo3MmFkTEZYTDh6SmpuMFdDempEVFhDalZDVklN?=
 =?utf-8?B?bzF2cmlMT1czSEU4My8zS2gxeU13WUd6amlOdnhobTVkUXR1Zi8zbnVnM21m?=
 =?utf-8?B?MDcrOU84NGttQTZQc2NsUWZ3WGk2RWFDVkxKRVk0OE5WZ29CZmM5SmVSOFEv?=
 =?utf-8?B?b2Z1cmlKcnpoRSs3M09mYzJHVkt2eUtlaDV0ZVNmQVpMYjhBS2F6aWhURmpQ?=
 =?utf-8?B?cEo2ZGJRbW9GbFdyOFB0b3Z0RzF6WHE3QkJldSt2S1orQ0dZUVBWQy9EMXN2?=
 =?utf-8?B?enhSZm85TWVTQkd5a0JwK1JCb2xjUGlSOThaendwcHZPSXJlZ0c0VHJLN3JH?=
 =?utf-8?B?SWljL0VTWUY1SGs2SmRlZXMzdkZ3U3ltTnBGV3RiTmNySFJTV29Dd0Q2eUZR?=
 =?utf-8?B?cFRvdU9VanZnOTdSZ0VRSFVNc1l6dm5tbUVqaGs1NXZKRzNELzdvOVQvWmJ1?=
 =?utf-8?B?TTB2RHNEVG5LbHc4eUdPT0Vrd1NPTk1aRXhnanRZYzkrYWJxTXRGbk55SFE3?=
 =?utf-8?B?VHBJSTB4bGhNS2xiWjNtbjlCbUhNSzM4cm1QSU1zeG1rVlVQdE9vK3JKR3Fm?=
 =?utf-8?B?UFQrMmpULzdIcDk2VzdidWlSUnBsV2FCR01jNzJ3SlN2OVlHSm1jNzliUVht?=
 =?utf-8?B?dFk0YTYzR0xmQW5XM1VHajd0NDI2c3piQUdMRHpPR0ZxWmlGS0w0N2xLbWcy?=
 =?utf-8?B?RHRNd1JyekF5aWhJay8xQ3RBdk1zMHN2WXQwUmZHcVBzcU9YampubW9VR01X?=
 =?utf-8?B?em51cTJhVVFCTGRGNGtjNlZyZXNHWWZlTW1hZlhNSGZoVTJleld2VzR5b2Nw?=
 =?utf-8?B?MmpncE1Zc01CQzVOM084S0szVVRZU2NkaXN6bWphMjlhaFNHZThNdmVaZG1G?=
 =?utf-8?B?emEyRzdvOGp2Y0x6M3hWbThtVUxBRUVPaTlvU1pKMU9rU2tOQ1R5cjFuNmhq?=
 =?utf-8?B?WUFFSk9sL2dxNWVkcUZNMGVqMWh3aTRNK2ttLzNoclppQ2RhYlRUQ3Npa09P?=
 =?utf-8?B?aDdQTGRwMitsbU5tNFIrb3FGWVVwU3hmdGRBL01NMUlndDQ3Vk52WHA2Ukk3?=
 =?utf-8?B?Zk45OVdTS2UzcU5DaitLS0dRd25ZWktaMXVJQlZjRHd2Z0VUaTlDbUtTS2dk?=
 =?utf-8?B?Ylcxd29md2xRd2gya2JUbzNwbkt3bm0yN1gvOXYwOXcyMmRlU0grVElOMGZ5?=
 =?utf-8?B?QXNZWTNmQ0VOU1dtK3BsUE15UEZ2OGI2cFlHVXd2eVRiTlg4SlVGUE92bFd4?=
 =?utf-8?B?TTNFNzB4d3hxemRtK3orMmg1cG9ybG5nbklNNEp3aXYrbUhoNzNpRlVZaFI1?=
 =?utf-8?B?c091V3NNWSszRkRMLzRkaFR6Wk1Ja3V3Z0NpUS83NU1hVENWWk9yYVVuZ3FL?=
 =?utf-8?B?eE1EVDBoNnNINSt3bXZ6WnhpSStGN2pzOUdjN2M2ZEcyRlhsVzdoSjQxeG5w?=
 =?utf-8?B?ZDRMVEdrQTQ1KzlwR0lRWGJoeGdNYk5rc2dkbTVSQk52UnZxVmN0R0lZV2hB?=
 =?utf-8?B?VWszMmIya0h5aVVCbzhkWm5MUEFNNE9QU0JEcDZKK1Azb3MrNzRKSXUxNUh6?=
 =?utf-8?Q?y7E1b2h6ugk7hIGjlU/0R1XGU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b855506-5ea9-4dc4-ef47-08ddb205588d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 03:23:38.6132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQ22RTjyEZqE7xTbQKd0BvZiHj9N5G862RH62ZGeRBw4mL6n82mHLuQjhhD1diF9cMyp3VeA4QR8w0U9441Q/Egna5IgglITI/j4LwVRwBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6991
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KU3VyZSwgSSB3aWxsIHN1Ym1pdCBhIGZvbGxvdy11cCBwYXRjaCB0aGF0
IGluY2x1ZGVzIHRoZSBmb2xsb3dpbmcgY2hhbmdlczoNCg0KMS4gSW50cm9kdWNlIGEgbmV3IE9U
UCBtZW1vcnkgZGV2aWNlIG1vZGVsLCB3aGljaCBwcm92aWRlcyBpbi1tZW1vcnkgc3RvcmFnZSBh
bmQgaW1wbGVtZW50cyBiYXNpYyBNTUlPIHJlYWQvd3JpdGUgdmlhIGFkZHJlc3Mgc3BhY2UuDQoy
LiBJbml0aWFsaXplIHRoZSBPVFAgbWVtb3J5IGRldmljZSBhcyBhIGNoaWxkIG9mIHRoZSBTQkMg
Y29udHJvbGxlci4NCjMuIEFkZCBjb21tYW5kIGhhbmRsaW5nIGxvZ2ljIGluIHRoZSBTQkMgdG8g
b3BlcmF0ZSBvbiB0aGUgT1RQIG1lbW9yeSwgc3VwcG9ydGluZyBib3RoIHJlYWQgYW5kIHByb2dy
YW0gb3BlcmF0aW9ucy4NCjQuIEludHJvZHVjZSBUWVBFX0FTUEVFRF9BU1QyNjAwX1NCQyB0byBz
dXBwb3J0IE9UUCBtZW1vcnkgYXR0YWNobWVudCB2aWEgdGhlIFNCQyBjbGFzcyBhdHRyaWJ1dGUg
aW4gdGhlIEFTVDI2MDAgU29DLg0KNS4gQWRkIHRyYWNlIGV2ZW50cyB0byBmYWNpbGl0YXRlIGRl
YnVnZ2luZyBhbmQgdHJhY2luZyBvZiBPVFAgbWVtb3J5IG9wZXJhdGlvbnMuDQoNCkFzIHJlcXVl
c3RlZCwgdGhlIEJsb2NrQmFja2VuZCBpbnRlZ3JhdGlvbiwgdGhlIG90cG1lbSBtYWNoaW5lIHBy
b3BlcnR5LCBhbmQgdGhlIHJlbGF0ZWQgYWxpYXMgaGFuZGxpbmcgd2lsbCBiZSByZW1vdmVkLg0K
UGxlYXNlIGxldCBtZSBrbm93IGlmIHRoZXJlIGlzIGFueXRoaW5nIGVsc2UgdGhhdCBzaG91bGQg
YmUgYWRqdXN0ZWQuDQoNCkJlc3QgcmVnYXJkcywNCkthbmUNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gU2Vu
dDogRnJpZGF5LCBKdW5lIDIwLCAyMDI1IDE6NDQgUE0NCj4gVG86IEthbmUgQ2hlbiA8a2FuZV9j
aGVuQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnPjsgU3RldmVuIExlZSA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kNCj4g
TGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2gu
Y29tPjsgQW5kcmV3DQo+IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpv
ZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+Ow0KPiBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFl
bXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6QWxsIHBhdGNoZXMgQ0MNCj4gaGVyZSA8cWVt
dS1kZXZlbEBub25nbnUub3JnPg0KPiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2gu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyB2NSAwLzRdIEFkZCBRRU1VIG1vZGVsIGZvciBBU1BF
RUQgT1RQIG1lbW9yeSBhbmQNCj4gaW50ZWdyYXRlIHdpdGggU29Dcw0KPiANCj4gSGVsbG8gS2Fu
ZSwNCj4gDQo+IE9uIDYvMTkvMjUgMDg6NDEsIEthbmUgQ2hlbiB3cm90ZToNCj4gPiBGcm9tOiBL
YW5lLUNoZW4tQVMgPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPg0KPiA+IFRoaXMgcGF0
Y2ggc2VyaWVzIGludHJvZHVjZXMgYSBRRU1VIG1vZGVsIGZvciB0aGUgQVNQRUVEIE9UUCAoT25l
LVRpbWUNCj4gPiBQcm9ncmFtbWFibGUpIG1lbW9yeSwgYWxvbmcgd2l0aCBpdHMgaW50ZWdyYXRp
b24gaW50byB0aGUgU2VjdXJlIEJvb3QNCj4gPiBDb250cm9sbGVyIChTQkMpIGFuZCBzdXBwb3J0
ZWQgU29DcyAoQVNUMjYwMCwgQVNUMTAzMCkuDQo+ID4NCj4gPiBUaGUgT1RQIG1vZGVsIGVtdWxh
dGVzIGEgc2ltcGxlIGZ1c2UgYXJyYXkgdXNlZCBmb3Igc2VjdXJlIGJvb3Qgb3INCj4gPiBkZXZp
Y2UgY29uZmlndXJhdGlvbiwgd2l0aCBzdXBwb3J0IGZvciBib3RoIGZpbGUtYmFja2VkIGNvbnRl
bnQgYW5kDQo+ID4gaW50ZXJuYWwgZmFsbGJhY2sgYnVmZmVycy4gSXQgZXhwb3NlcyBhbiBBZGRy
ZXNzU3BhY2UgdG8gc3VwcG9ydA0KPiA+IHRyYW5zYWN0aW9uLWJhc2VkIGFjY2VzcyBmcm9tIGNv
bnRyb2xsZXJzIGxpa2UgdGhlIFNCQy4NCj4gPg0KPiA+IFRoaXMgc2VyaWVzIGluY2x1ZGVzOg0K
PiA+ICAgIC0gT1RQIG1lbW9yeSBkZXZpY2UgaW1wbGVtZW50YXRpb24NCj4gPiAgICAtIFNCQyBp
bnRlZ3JhdGlvbiB3aXRoIGNvbW1hbmQgZGVjb2RpbmcgKFJFQUQvUFJPRykNCj4gPiAgICAtIE1h
Y2hpbmUgcHJvcGVydHkgd2lyaW5nICh2aWEgIm90cG1lbSIgYWxpYXMpDQo+ID4gICAgLSBBIGZ1
bmN0aW9uYWwgdGVzdCBzdWl0ZSBjb3ZlcmluZyB2YXJpb3VzIGluaXRpYWxpemF0aW9uIHBhdGhz
DQo+ID4NCj4gPiAqKltSRkMgbm90aWNlXSoqDQo+ID4gVGhpcyBpcyBhbiBSRkMgc3VibWlzc2lv
bi4gV2hpbGUgdGhlIE9UUCBtb2RlbCBpdHNlbGYgaXMgbW9zdGx5DQo+ID4gY29tcGxldGUsIHRo
aXMgdmVyc2lvbiBpcyBwcmltYXJpbHkgaW50ZW5kZWQgdG8gZ2F0aGVyIGZlZWRiYWNrIG9uIHRo
ZQ0KPiA+IGRldmljZSBpbml0aWFsaXphdGlvbiBmbG93LXNwZWNpZmljYWxseSBob3cgdGhlIE9U
UCBpbnN0YW5jZSBpcw0KPiA+IGNyZWF0ZWQsIGNvbm5lY3RlZCwgYW5kIGV4cG9zZWQgdmlhIG1h
Y2hpbmUgcHJvcGVydGllcy4gQW55IGNvbW1lbnQgb24NCj4gPiBRT00gaW50ZWdyYXRpb24gc3R5
bGUsIGxhdGUgYmluZGluZyB2aWEgbm90aWZpZXIsIGFuZCBmYWxsYmFjaw0KPiA+IGJlaGF2aW9y
IGFyZSB3ZWxjb21lLg0KPiA+DQo+ID4gSW4gcGFydGljdWxhciwgSSBhbSBzZWVraW5nIGlucHV0
IG9uOg0KPiA+ICAgIC0gV2hldGhlciB0aGUgY3VycmVudCBub3RpZmllci1iYXNlZCBjb25uZWN0
aW9uIGZyb20gU0JDIHRvIE9UUCBpcw0KPiA+ICAgICAgYXBwcm9wcmlhdGUsIG9yIGlmIHRoZXJl
IGlzIGEgcHJlZmVycmVkIFFPTSBpZGlvbSBmb3IgbGlua2luZw0KPiA+ICAgICAgcGVyaXBoZXJh
bCBkZXZpY2VzIHBvc3QtcmVhbGl6ZS4NCj4gPiAgICAtIFRoZSB1c2Ugb2YgIm9wdG1lbSIgYXMg
YSBkcml2ZSBhbGlhcyBhbmQgbWFjaGluZSBwYXJhbWV0ZXIgaGFuZGxpbmcuDQo+ID4NCj4gPiBB
IG1vcmUgZmluYWxpemVkIHZlcnNpb24gd2l0aCBhbnkgcmVxdWVzdGVkIGNoYW5nZXMsIGRvY3Vt
ZW50YXRpb24sDQo+ID4gYW5kIHRlc3QgcmVmaW5lbWVudHMgd2lsbCBmb2xsb3cgYWZ0ZXIgcmV2
aWV3Lg0KPiA+DQo+ID4gRXhhbXBsZSB1c2FnZToNCj4gPiBgYGBiYXNoDQo+ID4gcWVtdS1zeXN0
ZW0tYXJtIC1tYWNoaW5lIGFzdDI2MDAtZXZiLG90cG1lbT1vdHBtZW0tZHJpdmUgXA0KPiA+ICAg
IC1ibG9ja2RldiBkcml2ZXI9ZmlsZSxmaWxlbmFtZT1vdHBtZW0uaW1nLG5vZGUtbmFtZT1vdHBt
ZW0gXA0KPiA+ICAgIC1kZXZpY2UgYXNwZWVkLm90cG1lbSxkcml2ZT1vdHBtZW0saWQ9b3RwbWVt
LWRyaXZlIFwNCj4gPiAgICAuLi4NCj4gPiBgYGANCj4gPg0KPiA+IEFueSBmZWVkYmFjayBvciBz
dWdnZXN0aW9ucyBhcmUgYXBwcmVjaWF0ZWQhDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gS2FuZQ0K
PiA+DQo+ID4gLS0tDQo+ID4NCj4gPiBDaGFuZ2VMb2cNCj4gPiAtLS0tLS0tLS0NCj4gPiB2NToN
Cj4gPiAtIFN3aXRjaGVkIHRvIG5vdGlmaWVyLWJhc2VkIGxhdGUgYmluZGluZyBiZXR3ZWVuIFNC
QyBhbmQgT1RQDQo+ID4gLSBFeHBvc2VkICdvdHBtZW0nIGFzIGEgbWFjaGluZSBwYXJhbWV0ZXIg
dXNpbmcgUU9NIGFsaWFzIG1lY2hhbmlzbQ0KPiA+IC0gQWRkZWQgZmFsbGJhY2sgc3VwcG9ydCB3
aGVuIG5vIGJhY2tlbmQgaXMgcHJvdmlkZWQNCj4gPiAtIEludHJvZHVjZWQgZnVuY3Rpb25hbCB0
ZXN0IHN1aXRlIGNvdmVyaW5nIG11bHRpcGxlIGluaXQNCj4gPiBjb25maWd1cmF0aW9ucw0KPiA+
IC0gU3VibWl0dGVkIGFzIFtSRkNdIHRvIGdhdGhlciBmZWVkYmFjayBvbiBRT00gaW50ZWdyYXRp
b24gYXBwcm9hY2gNCj4gPg0KPiA+IHY0Og0KPiA+IC0gUmVwbGFjZXMgYmxvY2tkZXYgYmFja2Vu
ZCB3aXRoIG1lbW9yeS1tYXBwZWQgQWRkcmVzc1NwYWNlIGFjY2Vzcw0KPiA+IC0gU3dpdGNoZXMg
ZnJvbSBgLWRyaXZlYCBDTEkgb3B0aW9uIHRvIGBvdHBtZW1gIG1hY2hpbmUgcGFyYW1ldGVyDQo+
ID4gLSBSZXN0cnVjdHVyZXMgdGhlIE9UUCBkZXZpY2UgdW5kZXIgdGhlIFNCQyBpbiB0aGUgUU9N
IHRyZWUNCj4gPg0KPiA+IHYzOg0KPiA+IC0gTWlub3IgZml4ZXMgYW5kIHJlZmluZW1lbnRzIG9u
IHRvcCBvZiB2MiBjb250ZW50DQo+ID4NCj4gPiB2MjoNCj4gPiAtIFNlcGFyYXRlZCB0aGUgT1RQ
IG1lbW9yeSBpbnRvIGEgc3RhbmRhbG9uZSBRRU1VIGRldmljZQ0KPiA+IChgYXNwZWVkLm90cG1l
bWApDQo+ID4gLSBSZXBsYWNlZCBhZC1ob2MgZmlsZSBoYW5kbGluZyB3aXRoIHN0YW5kYXJkIGAt
ZHJpdmVgIGJhY2tlbmQNCj4gPiBpbnRlZ3JhdGlvbg0KPiA+IC0gTGlua2VkIE9UUCB0byBTQkMg
dmlhIFFPTSBwcm9wZXJ0eSBmb3IgY2xlYW5lciBhYnN0cmFjdGlvbg0KPiA+IC0gSW1wcm92ZWQg
bWVtb3J5IGJvdW5kcyBjaGVja2luZyBhbmQgaXJyZXZlcnNpYmxlIHByb2dyYW1taW5nIGxvZ2lj
DQo+ID4NCj4gPiB2MToNCj4gPiAtIEVtYmVkZGVkIE9UUCBsb2dpYyBpbiB0aGUgU0JDIG1vZGVs
IGFuZCBjcmVhdGVkIHRoZSBiYWNraW5nIGZpbGUNCj4gaW50ZXJuYWxseS4NCj4gPg0KPiA+IC0t
LQ0KPiA+DQo+ID4gS2FuZS1DaGVuLUFTICg0KToNCj4gPiAgICBody9taXNjL2FzcGVlZF9vdHA6
IEFkZCBBU1BFRUQgT1RQIG1lbW9yeSBkZXZpY2UgbW9kZWwNCj4gPiAgICBody9taXNjL2FzcGVl
ZF9zYmM6IENvbm5lY3QgQVNQRUVEIE9UUCBtZW1vcnkgZGV2aWNlIHRvIFNCQw0KPiA+ICAgIGh3
L2FybTogSW50ZWdyYXRlIEFTUEVFRCBPVFAgbWVtb3J5IHN1cHBvcnQgaW50byBBU1QxMHgwIGFu
ZA0KPiBBU1QyNjAwDQo+ID4gICAgICBTb0NzDQo+ID4gICAgdGVzdHMvZnVuY3Rpb25hbDogQWRk
IGludGVncmF0aW9uIHRlc3RzIGZvciBBU1BFRUQgT1RQIG1lbW9yeSBtb2RlbA0KPiA+DQo+ID4g
ICBody9hcm0vYXNwZWVkLmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAyMCArKysNCj4gPiAg
IGh3L2FybS9hc3BlZWRfYXN0MTB4MC5jICAgICAgICAgICAgICAgIHwgICAyICstDQo+ID4gICBo
dy9hcm0vYXNwZWVkX2FzdDI2MDAuYyAgICAgICAgICAgICAgICB8ICAgMiArLQ0KPiA+ICAgaHcv
bWlzYy9hc3BlZWRfb3RwbWVtLmMgICAgICAgICAgICAgICAgfCAxMTcNCj4gKysrKysrKysrKysr
KysrKw0KPiA+ICAgaHcvbWlzYy9hc3BlZWRfc2JjLmMgICAgICAgICAgICAgICAgICAgfCAxNzkN
Cj4gKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgaHcvbWlzYy9tZXNvbi5idWlsZCAg
ICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICAgaHcvbWlzYy90cmFjZS1ldmVudHMgICAg
ICAgICAgICAgICAgICAgfCAgIDcgKw0KPiA+ICAgaW5jbHVkZS9ody9taXNjL2FzcGVlZF9vdHBt
ZW0uaCAgICAgICAgfCAgMzUgKysrKysNCj4gPiAgIGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfc2Jj
LmggICAgICAgICAgIHwgICA4ICsrDQo+ID4gICB0ZXN0cy9mdW5jdGlvbmFsL21lc29uLmJ1aWxk
ICAgICAgICAgICB8ICAgMSArDQo+ID4gICB0ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYXNwZWVkX290
cG1lbS5weSB8ICA4MiArKysrKysrKysrKw0KPiA+ICAgMTEgZmlsZXMgY2hhbmdlZCwgNDUyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcv
bWlzYy9hc3BlZWRfb3RwbWVtLmMNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3
L21pc2MvYXNwZWVkX290cG1lbS5oDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvZnVu
Y3Rpb25hbC90ZXN0X2FzcGVlZF9vdHBtZW0ucHkNCj4gPg0KPiANCj4gSSB3b3VsZCBsaWtlIHRv
IHNlZSBmaXJzdCBhIHByb3Bvc2FsIHdpdGhvdXQgYSBCbG9ja0JhY2tlbmQgYW5kIHdpdGhvdXQg
YW4NCj4gJ29wdG1lbScgbWFjaGluZSBwcm9wZXJ0eS4gUGxlYXNlIHJld29yayB0aGUgc2VyaWVz
IGFjY29yZGluZ2x5Lg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiANCj4gDQoN
Cg==

