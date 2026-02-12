Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A6DEDF020
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 03:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqNHM-0005Hy-L0; Wed, 11 Feb 2026 22:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vqNHI-0005Ga-I1; Wed, 11 Feb 2026 22:22:05 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vqNHF-0006jH-SZ; Wed, 11 Feb 2026 22:22:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvnQNliRKeCNXmrR2xciB70nU/E21Bl47aFadASloVq6a6O+DjAvAEe/okddyQ4oPkhy6KLsQUaIWIIEhgQ9S38IUot9QV7N0Xrri7jBUac5Hrx/vLXtoBrbQbuqXXdiGgA4lZvR35nTHOEFIGUU34YQyPvfUxv8aal2XcrHj8AnQRA+YMlqG7iRcA4FQRhC0cxaCNtz+pTNDwYbOgTxznU6TWh2RglaqWDQhcGT7cxwaVunZrboQoiGqWSAS/jDM3nS4pyt56v5odxepqasqiLKrhInO4Bv3ejAzMOouifmJ8o4G9YNmRZ0n7Reody93uRK4zATdsYuqaZ3zEi5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLal33YhXSMJY52c+YTXEEyKuloL+Iw0e47rnxONxHo=;
 b=NoEvO3ftOgwcfcU3ALYvBj53mRNEDnf409ZWW6lDTUGogGZ6v00oMgM5+07ukjxozFcXADA+LIl1FqMPZtvE+R2CLx/0f6m4jeeuzYsmPlehDrbqBc1zSJZHqVi3jz9Kua6Vbzuv31MKpeKKhulk3njOx5PFg1PW6fwqW///FYvnELGEUPrQ/wBnEhtwNYxfQ+OX1QytBMJ10MRKK/LTUV8NdgW5Zm610Tp6YWzYuvKsBaSfC2VYCilVcmiwbcT7LR1SM1MhsOgCba782cy8TDQFCipK0ldvt7RqsIUPEDmMYnNDgz61LBn75n/7ZSbkUNuFPrV6aej2XntgEMrJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLal33YhXSMJY52c+YTXEEyKuloL+Iw0e47rnxONxHo=;
 b=GB7PmBqGeOSzdszAs8916vLA/41bGmwwm5u4eknzbwoN+qkU1UDKEUc32rIZxfpFJkTsSQkuEy0+9Kwx7eGUcO1BpSEcl2SHAf+FzeDKezenJuH6+Rm9840blqNT4NcG49f/Qa10jStAbMAAmeQNb8UB5RLNsEpAQIJU6uEgGWjvafh7aEBDc2sYX/xysMCkuUM8ymdI/37UalxAVE9RxlXDvqBpk4WXViqls3omOVHgEeIfu/nlw8GTPhgAsb+uIXbDJOoZvQNa4O2N1TrTfPNZD0Ls2UCSYYiN6JuIssKaXSB2rvo6aAYUnXjSBhg7sGHrUBDqebKttXHlALJERA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYUPR06MB6219.apcprd06.prod.outlook.com (2603:1096:400:352::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 03:21:48 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.017; Thu, 12 Feb 2026
 03:21:48 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>
Subject: RE: [PATCH 2/2] tests/functional: Add SDK tests with Linux 5.15
Thread-Topic: [PATCH 2/2] tests/functional: Add SDK tests with Linux 5.15
Thread-Index: AQIpBOUPy2iFv/sdIs6REcjZolIFYQIambgOtNS+siA=
Date: Thu, 12 Feb 2026 03:21:48 +0000
Message-ID: <SI6PR06MB763191210BE6C170375169CFF760A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260209065044.239378-1-clg@redhat.com>
 <20260209065044.239378-3-clg@redhat.com>
In-Reply-To: <20260209065044.239378-3-clg@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYUPR06MB6219:EE_
x-ms-office365-filtering-correlation-id: 8c4fbed7-5be4-40f8-44a8-08de69e5db63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?utf-8?B?VUorY3FaOUpvTkdZRHBtRHRkcmdQckUvc0Q2R2hpVm1yeS93RTc0TDdMM3JL?=
 =?utf-8?B?cVBRazFONktxNFE3NUttUkNmY2ZOYXdmSlN5NUFxSDl1M1l5SkFaQmYwM1N3?=
 =?utf-8?B?TzJ6Q1ptOUtoQnR2V01hSWhFMjVZeTNoSkJYNllzRkswcENDbEtIWW9iRVZ5?=
 =?utf-8?B?VDYwNmc1STh4d3pucS8yVGFnMCs4YzM5MUhFdFhUek41c2dPNEg2b2VzNy9w?=
 =?utf-8?B?SFV3cVpjS3N3aGZsZmlQRHh4VmtIazhxWTRkS3d0TWJTZ3NYSDhRcGFTSTYy?=
 =?utf-8?B?VEwwakZnSFBTbkVXdUpZNmlpYnFURlBYRHFzUzZJZjJjNFZlMHJHSUZiZzFu?=
 =?utf-8?B?UDR2dWZIM2R0c3RwQXd4aktNa3BYVXhpcWllVy9STzBoSEtMODFudk9YTGJi?=
 =?utf-8?B?azBZM2h1a3ZBc01VL1lFN2RMQ1RhUVdySzlHQXlWMWJmdEtKb1pVV01XY01V?=
 =?utf-8?B?OFRySnEranZhSXdXdUpGNHpNdkxSZmV4blUrRCtSTVlwWCtIU2V0ZnRmMEtR?=
 =?utf-8?B?TGhiYTM3SFFvUUhUY21reXVlR3dHQ1hSWUhUU0JoK1RDbHgvTHZTSk1neDIw?=
 =?utf-8?B?OEsyU1VJWW9ia2xHRmhueDh5SmZDTnJOVWhsdUhSZUIxLys5dzUvS1RZYlZl?=
 =?utf-8?B?MFJGRTdsaGxPd2M4ZHZlWkdnbTJvbXdOVGVWQVVPS3RJb1lVWlNkNXkxT3Fl?=
 =?utf-8?B?ZmYxaVJKUCs3a2ROU1pKQ0V2d3NvZDRwUTRIRjdobHhhV1VWLy9hT21ydEJ2?=
 =?utf-8?B?VFF6L0IvRyt4RXU1V0VHSTFHUUZCQ25IdFRDdjRZN1pHNkNUcnpnSFdwczdz?=
 =?utf-8?B?a0ZucUo2bEVHVmtPRGFLTThCYWpUWlowZ3cwTkNUendWajlpV1FoNStjVHJJ?=
 =?utf-8?B?QmFQd0U0VWF2NWJ0Wm9lSVF0RVloeE1YM0JDcXRsblprNlJQRXRhUnM2SjhX?=
 =?utf-8?B?Uk9vZ2p4ejRBazFoYllpMnJzVXNRbDArZ1JFdHRTRFJTVjMwQXc4T1U3L2xE?=
 =?utf-8?B?c1hqN0hmQjRSZ0lqWEZEQms2L2dSdlg1TENhd3JNRUhnNm5YcjNLK3RCMEFt?=
 =?utf-8?B?UHU1MERCelpBREFhTmhvTW5tZUwvcU96YVVkNmlObDF1RHZBeTFUWVNhMnJH?=
 =?utf-8?B?ZXErM0JRSXJXblRjVlVOWGgzb2xhRVlkbzlLb1d3Y0hNK2dsR1JrUHFMMVUv?=
 =?utf-8?B?cVNHZFIyci9XdnRCYmp0VzB3VTU3c2JJQktpNFlleTQzU2JXeEF4UUtnRTh3?=
 =?utf-8?B?WWkzYWllL20rbHJhdkxHbGZEQ1BjZXhDdy9hczdGNnRGY1dHdmhmSGdEWnlV?=
 =?utf-8?B?TElQaU1EQlF1Tm85cG5qelhkNyt4WE5qN0VYMUlQM0RQektnWjF0aXFtKzRu?=
 =?utf-8?B?U0FQZDZYdWwzcWpJR2JYdFZvRGJBYzQ3dDNNNzE1ZnVJVlFhL2NSZEZNdmNq?=
 =?utf-8?B?RkVZZnRvdHd6QjJsUnozZmpMZU0rSkpQUE10bXNCTm1mQ3JGM1lYb2grOW1R?=
 =?utf-8?B?WmtpcXhETitGTnpnRjBiSW9XdWhzcmZ4V05vMEFjR1k5YzE1TVdHTUdwQmRq?=
 =?utf-8?B?SEJWMUJZK2VaM2Z0OC9uSWdXQzJGa1A3SDVlMDFxVkJUMEN0cFA1WWNuN3dB?=
 =?utf-8?B?U0ZIL3ltNDNhUUZidFdQUzY3d0VHelNyTWNJUGhjV1AwTjEvVUd0MGYzK0RO?=
 =?utf-8?B?M2NFcEVMTm41c25PMDVMaHNZOE1DNkFSblhUMW80aityZUxjWTh3andGVEt3?=
 =?utf-8?B?bGRrQ3VwaC9ONjRUSmZ0MzdmUEN0K3RkTjdYeENpcXJRMm5PRnZOeTgrNFZZ?=
 =?utf-8?B?aW0vTThROFZ3NXJuRmVmbTFBVzlOR3FuRHZkcy9UajBaNUJrMFplT2FlU0F2?=
 =?utf-8?B?YjRoWG83eCtRUWFzQXZZZmYwb2RBTnNhbXV1NTRBMjByK1ZRSGJTUjRaSEk5?=
 =?utf-8?B?RCtiNDBYYm9rUStUMVc4WHlXM3dMb0IzYXdmZWpmNlJoWURHNHk3blE2Lzhp?=
 =?utf-8?B?VGh6UkZNM0hhenY1eDdXTWg0eHpSTnR6ZDVLeXU5MjkzMTA5U2krSC9pdERE?=
 =?utf-8?B?d3JjLzlIUGI4SzI5YVNXTm53ZkJmbGZJS0ZQd0hnY29Scmp1VWRaS3VWODBY?=
 =?utf-8?Q?PL9o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(13003099007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2hoaTl6TzRGbG9mTzRKM1ZNVE5JUjEzTW5RMWxvN0tWeXVhaVBTZzJ0RWNF?=
 =?utf-8?B?SEJvNWUySUpoYTlGekdpQU55VmljbXRFeExyV3NmSEh5Y3FNb2xFUzQxMkRI?=
 =?utf-8?B?ZVo3UExJa1Q2MFY2WVpPTjB6K0kyTjlCS2pnTjFPc204K21WQi94aDB3d0Iy?=
 =?utf-8?B?WGppVW9PYjgvbGkzaklQTVRLbmdhbkZOOFZGNXlhbHNyRFpxQmVXbTNHS21t?=
 =?utf-8?B?TUk0MFZJL3k4QnFFYm8rWVJnTHVpZzlLOFlscWg0QkllUmliaTA0K0RnWFgy?=
 =?utf-8?B?cHk5S2dEcmtIakcxVnVkdVZJTkNYSnFFNTZHYnRERnk1OXRUT0F3Nmh3NGpW?=
 =?utf-8?B?YWM3OEhLVUpCdzB1cEhBRkFhZHhsNk5qTjR3c2lpSDkwYUttZkRVeDZDNVVZ?=
 =?utf-8?B?STdpUTFvQlBpUVRzSE04ZmtmVzQvd0ZpeU5VelhBSUR2RytZZk1LbFU4NzZZ?=
 =?utf-8?B?MmFxbzFTUWlYQ3dKNGJ1MGdsaVdDbEFsTkNnN1dtM1ZwT3lmamtZOStLYW5w?=
 =?utf-8?B?MXhvYTJERjgyQ0R4anQ5MkcyZ2o2TTNyaTZJOXhKRktsYTh3bGIvemdpWC9q?=
 =?utf-8?B?dys5STlPRzlpRWpSWUhGajdXNFJFek1zcUdoN2krUXcxWnI4MWRUSDM1T2dJ?=
 =?utf-8?B?djd2ZkRBVmFSYjJRU2NreUJrQnF3bzBvR015VmlINFRGVW1KS0FseXpEeGd2?=
 =?utf-8?B?SnpCdkRXcHdKanM5dXY5dEcvYkJneE14QTMrcVE1YWkweHNmZ3ZHcmV0T0w4?=
 =?utf-8?B?VzdKZGlFWkFvUFlRNG9oZFhhNmRRc0NIeXRnc1BFOVFBQlpGOEMwR1I0NmU4?=
 =?utf-8?B?MHhqVFBtYWVSUTZoNmczdEtBQmR2cGRXc1NqUHVsRnFuemxNWHRzWjBKUTMx?=
 =?utf-8?B?VVEvQ3MvRVgyVENjSHp4a3huVGdFR3BIMzM4QnpqL1VRcldPbG10YVhpMEpR?=
 =?utf-8?B?ZmpuVnNaUU84MDdySUpudlZVLzRlbWxrUVpOZVc0STg4bmVCbWlVTXQ5NGhX?=
 =?utf-8?B?VWdiYUxuaWVwWXRFeDA0UGQ1ckNNWEVZS0dmWEtpZmpEVjVJUEF4RUJBdW5E?=
 =?utf-8?B?bk5OcDBYM1JNVTlKL09Dam54ZnpRQmY4aU1XOXlsTjk4ODZONGhRT2xSclMr?=
 =?utf-8?B?TXRZS1VQMTFnUVhOc1dFWVBaZVNpUXJGRkljSlZTa0hoaTEza2Z5a3VyMDdZ?=
 =?utf-8?B?QlBsSTJ5VU03SXk4UWE2cGZHeGpwTFVvenRBSTgxcjJpcmwveVUvNTVWV0Jp?=
 =?utf-8?B?VS9IOStGMVk1cGNnbmFxZUFyUGE1NkdnWWZGeGtUQkhYQVZhVXFsdFVXOVNv?=
 =?utf-8?B?NXpCbS9jSGMzcVgzUlI3NWorVGtwY1NzLzFOR1NVM2JkQmJFb1l0NTVRd1FB?=
 =?utf-8?B?Rld1STNPTEdKckdQRUZWWXZtQnl5M1FXQXBhVTlXU3lWN3Y3K1ZRbzhNck5S?=
 =?utf-8?B?VWl2ZW9uUXVXVEdJMXBLaUdVRlNNRFpnSHN5c2FmSzFQMzQ3SC9JdnV5eUdX?=
 =?utf-8?B?bkVxa1ZZRU5vVXZndnVueDRnZGxRNmlhaWhBQSsrZiszOWo5WFl6ME0zdHJO?=
 =?utf-8?B?Rjh1MytWVXhKK0hPcTlqQS9haWdDWFlnU1ZkUVFCb1B1a2NPdUpjd1dSVTR2?=
 =?utf-8?B?eDdlclpxWDVnS1J3TEcxSlNISkFPNEYrSlNYbEU5SjNEbndEVFI5SnYvMlpL?=
 =?utf-8?B?eHV5RHFWYTBrVGI2cUtPTjhXT2NaSzJJSEs5cEhaQnJEYmNQNWdjQ1dzeWk2?=
 =?utf-8?B?Y0prK05MMERvaG5SMHRTdTgzMEcxRGRlQXRtOTE3ZUZHc3hTSW1laXZKNnJ5?=
 =?utf-8?B?UTUzSTN5TDAxc0JMbFIzcXk1Y3pPSjZROVoxM29RNzJPZWlwWDJwNkk3NEZW?=
 =?utf-8?B?WERUU3hRNHZRYmZjcmwxY2tURWQzWWJkNDhPSlFEVi9SSVNuN1N6NjdxWnBi?=
 =?utf-8?B?ZS8wN0czQ1ZYdysvSmZTb3k0QnFDWlJDYjRLa2t5czQrbk1YM3lZOWloQ1d1?=
 =?utf-8?B?YmU3TmEyUXA2UEUyZjF3eEl2QXhUM1laNTJ3bjdDQTFRR3BKV1pGY3IzaWpW?=
 =?utf-8?B?WkxNQVhCRk9sQlY4RlluNFZKVXNrTmttS096M1E2b1o4TFRPR2QzUUQ1VW5K?=
 =?utf-8?B?azMwUDlnL0NZSkRjN3NlWkM0RkNDeWs0Um5LSkMxeWhQV2xoMEI1aVQ5ZkZi?=
 =?utf-8?B?a3I5STZnbExEREVKemJsVDdXRzQwQ05ZWWdRRkcrM2ZyTFdLeXZmYklMaUJK?=
 =?utf-8?B?NlRIZEtxQ1l3Tm1qak5hVzhnOGxjcUNheEZiR1YyQzN5M3ZneUQwT2hlWnBt?=
 =?utf-8?B?UGR5RnRiZFJ1cWRuZi90N0RlbXJmL3lHUTZxcEZXNlNYbXc3WS9iUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4fbed7-5be4-40f8-44a8-08de69e5db63
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 03:21:48.1076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6F1UdabdXsfrsaJU0dOMx2BO9NBSYtnU4oESt+uqzlVqluN2afOXIARx242lXth8lukoKE06yY3XJurDjXwSQa+EED1R35EU0f84J6F8ra0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6219
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBxZW11LWRldmVsLWJvdW5jZXMr
aW1wb3J0ZXI9cGF0Y2hldy5vcmdAbm9uZ251Lm9yZw0KPiA8cWVtdS1kZXZlbC1ib3VuY2VzK2lt
cG9ydGVyPXBhdGNoZXcub3JnQG5vbmdudS5vcmc+IE9uIEJlaGFsZiBPZiBDw6kNCj4gZHJpYyBM
ZSBHb2F0ZXINCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSA5LCAyMDI2IDI6NTEgUE0NCj4gVG86
IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS1hcm1Abm9uZ251Lm9yZw0KPiBDYzogUGV0ZXIg
TWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZQ0KPiA8c3RldmVu
X2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kgTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEphbWlu
IExpbg0KPiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQW5kcmV3IEplZmZlcnkNCj4gPGFu
ZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+
OyBUaG9tYXMNCj4gSHV0aCA8dGh1dGhAcmVkaGF0LmNvbT47IEM/ZHJpYyBMZSBHb2F0ZXIgPGNs
Z0ByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSB0ZXN0cy9mdW5jdGlvbmFsOiBB
ZGQgU0RLIHRlc3RzIHdpdGggTGludXggNS4xNQ0KPiANCj4gQWRkIGZ1bmN0aW9uYWwgdGVzdHMg
Zm9yIEFTVDI1MDAgYW5kIEFTVDI2MDAgbWFjaGluZXMgdXNpbmcgdGhlIE9wZW5CTUMNCj4gU0RL
IHYxMS4wMCB3aXRoIExpbnV4IGtlcm5lbCA1LjE1LiBUaGVzZSB0ZXN0cyBjb21wbGVtZW50IHRo
ZSBleGlzdGluZyBTREsNCj4gdGVzdHMgYW5kIHZlcmlmeSB0aGF0IFFFTVUgY29ycmVjdGx5IGJv
b3RzIG9sZGVyIGtlcm5lbCB2ZXJzaW9ucyBvbiB0aGVzZQ0KPiBwbGF0Zm9ybXMuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IC0tLQ0K
PiAgdGVzdHMvZnVuY3Rpb25hbC9hcm0vbWVzb24uYnVpbGQgICAgICAgICAgICAgIHwgIDQgKysr
DQo+ICAuLi4vYXJtL3Rlc3RfYXNwZWVkX2FzdDI1MDBfc2RrXzUxNS5weSAgICAgICAgfCAyOQ0K
PiArKysrKysrKysrKysrKysrKysrDQo+ICAuLi4vYXJtL3Rlc3RfYXNwZWVkX2FzdDI2MDBfc2Rr
XzUxNS5weSAgICAgICAgfCAyOQ0KPiArKysrKysrKysrKysrKysrKysrDQo+ICAzIGZpbGVzIGNo
YW5nZWQsIDYyIGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9mdW5j
dGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNTAwX3Nka181MTUucHkNCj4gIGNyZWF0ZSBtb2Rl
IDEwMDc1NSB0ZXN0cy9mdW5jdGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNjAwX3Nka181MTUu
cHkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2FybS9tZXNvbi5idWlsZA0K
PiBiL3Rlc3RzL2Z1bmN0aW9uYWwvYXJtL21lc29uLmJ1aWxkDQo+IGluZGV4IDE3NWE4M2EyYWNk
Ny4uMmY1MzhmMjlhMmRlIDEwMDY0NA0KPiAtLS0gYS90ZXN0cy9mdW5jdGlvbmFsL2FybS9tZXNv
bi5idWlsZA0KPiArKysgYi90ZXN0cy9mdW5jdGlvbmFsL2FybS9tZXNvbi5idWlsZA0KPiBAQCAt
NSwxMCArNSwxMiBAQCB0ZXN0X2FybV90aW1lb3V0cyA9IHsNCj4gICAgJ2FzcGVlZF9yb211bHVz
JyA6IDEyMCwNCj4gICAgJ2FzcGVlZF93aXRoZXJzcG9vbicgOiAxMjAsDQo+ICAgICdhc3BlZWRf
YXN0MjUwMF9zZGsnIDogNzIwLA0KPiArICAnYXNwZWVkX2FzdDI1MDBfc2RrXzUxNScgOiA3MjAs
DQo+ICAgICdhc3BlZWRfYXN0MjUwMF9idWlsZHJvb3QnIDogNDgwLA0KPiAgICAnYXNwZWVkX2Fz
dDI2MDBfYnVpbGRyb290JyA6IDQ4MCwNCj4gICAgJ2FzcGVlZF9hc3QyNjAwX2J1aWxkcm9vdF90
cG0nIDogNzIwLA0KPiAgICAnYXNwZWVkX2FzdDI2MDBfc2RrJyA6IDcyMCwNCj4gKyAgJ2FzcGVl
ZF9hc3QyNjAwX3Nka181MTUnIDogNzIwLA0KPiAgICAnYXNwZWVkX2FzdDI2MDBfc2RrX290cCcg
OiA3MjAsDQo+ICAgICdhc3BlZWRfYmxldGNobGV5JyA6IDQ4MCwNCj4gICAgJ2FzcGVlZF9jYXRh
bGluYScgOiA0ODAsDQo+IEBAIC0zNiwxMCArMzgsMTIgQEAgdGVzdHNfYXJtX3N5c3RlbV90aG9y
b3VnaCA9IFsNCj4gICAgJ2FzcGVlZF9yb211bHVzJywNCj4gICAgJ2FzcGVlZF93aXRoZXJzcG9v
bicsDQo+ICAgICdhc3BlZWRfYXN0MjUwMF9zZGsnLA0KPiArICAnYXNwZWVkX2FzdDI1MDBfc2Rr
XzUxNScsDQo+ICAgICdhc3BlZWRfYXN0MjUwMF9idWlsZHJvb3QnLA0KPiAgICAnYXNwZWVkX2Fz
dDI2MDBfYnVpbGRyb290JywNCj4gICAgJ2FzcGVlZF9hc3QyNjAwX2J1aWxkcm9vdF90cG0nLA0K
PiAgICAnYXNwZWVkX2FzdDI2MDBfc2RrJywNCj4gKyAgJ2FzcGVlZF9hc3QyNjAwX3Nka181MTUn
LA0KPiAgICAnYXNwZWVkX2FzdDI2MDBfc2RrX290cCcsDQo+ICAgICdhc3BlZWRfYmxldGNobGV5
JywNCj4gICAgJ2FzcGVlZF9jYXRhbGluYScsDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlv
bmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNTAwX3Nka181MTUucHkNCj4gYi90ZXN0cy9mdW5jdGlv
bmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNTAwX3Nka181MTUucHkNCj4gbmV3IGZpbGUgbW9kZSAx
MDA3NTUNCj4gaW5kZXggMDAwMDAwMDAwMDAwLi40NjRhNGU0Mzk2MWQNCj4gLS0tIC9kZXYvbnVs
bA0KPiArKysgYi90ZXN0cy9mdW5jdGlvbmFsL2FybS90ZXN0X2FzcGVlZF9hc3QyNTAwX3Nka181
MTUucHkNCj4gQEAgLTAsMCArMSwyOSBAQA0KPiArIyEvdXNyL2Jpbi9lbnYgcHl0aG9uMw0KPiAr
Iw0KPiArIyBGdW5jdGlvbmFsIHRlc3QgdGhhdCBib290cyB0aGUgQVNQRUVEIG1hY2hpbmVzICMg
Iw0KPiArU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4gKw0KPiAr
ZnJvbSBxZW11X3Rlc3QgaW1wb3J0IEFzc2V0DQo+ICtmcm9tIGFzcGVlZCBpbXBvcnQgQXNwZWVk
VGVzdA0KPiArDQo+ICsNCj4gK2NsYXNzIEFTVDI1MDBNYWNoaW5lKEFzcGVlZFRlc3QpOg0KPiAr
DQo+ICsgICAgQVNTRVRfU0RLX1YxMTAwX0FTVDI1MDBfNTE1ID0gQXNzZXQoDQo+ICsNCj4gJ2h0
dHBzOi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9vcGVuYm1jL3JlbGVhc2VzL2Rvd25sb2Fk
L3YxMS4wMC9hDQo+IHN0MjUwMC1kZWZhdWx0LTUxNS1vYm1jLnRhci5neicsDQo+ICsNCj4gKw0K
PiAnNTczMjI1NWQ0NjE3ZDk4Yjc2YmJiYzExNmQzMzFkNmFjODk5MDZmYTIxMjk2OWViODIxM2Zk
YzRhZWE4NjQ1DQo+IDEnKQ0KPiArDQo+ICsgICAgZGVmIHRlc3RfYXJtX2FzdDI1MDBfZXZiX3Nk
a181MTUoc2VsZik6DQo+ICsgICAgICAgIHNlbGYuc2V0X21hY2hpbmUoJ2FzdDI1MDAtZXZiJykN
Cj4gKw0KPiArICAgICAgICBzZWxmLmFyY2hpdmVfZXh0cmFjdChzZWxmLkFTU0VUX1NES19WMTEw
MF9BU1QyNTAwXzUxNSkNCj4gKw0KPiArICAgICAgICBzZWxmLmRvX3Rlc3RfYXJtX2FzcGVlZF9z
ZGtfc3RhcnQoDQo+ICsgICAgICAgICAgICBzZWxmLnNjcmF0Y2hfZmlsZSgiYXN0MjUwMC1kZWZh
dWx0LTUxNSIsICJpbWFnZS1ibWMiKSkNCj4gKw0KPiArICAgICAgICBzZWxmLndhaXRfZm9yX2Nv
bnNvbGVfcGF0dGVybignYXN0MjUwMC1kZWZhdWx0LTUxNSBsb2dpbjonKQ0KPiArDQo+ICsNCj4g
K2lmIF9fbmFtZV9fID09ICdfX21haW5fXyc6DQo+ICsgICAgQXNwZWVkVGVzdC5tYWluKCkNCj4g
ZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDI2MDBfc2Rr
XzUxNS5weQ0KPiBiL3Rlc3RzL2Z1bmN0aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDI2MDBfc2Rr
XzUxNS5weQ0KPiBuZXcgZmlsZSBtb2RlIDEwMDc1NQ0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmY0
OGRhMzAxZDU2Nw0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvYXJt
L3Rlc3RfYXNwZWVkX2FzdDI2MDBfc2RrXzUxNS5weQ0KPiBAQCAtMCwwICsxLDI5IEBADQo+ICsj
IS91c3IvYmluL2VudiBweXRob24zDQo+ICsjDQo+ICsjIEZ1bmN0aW9uYWwgdGVzdCB0aGF0IGJv
b3RzIHRoZSBBU1BFRUQgbWFjaGluZXMgIyAjDQo+ICtTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMC1vci1sYXRlcg0KPiArDQo+ICtmcm9tIHFlbXVfdGVzdCBpbXBvcnQgQXNzZXQNCj4g
K2Zyb20gYXNwZWVkIGltcG9ydCBBc3BlZWRUZXN0DQo+ICsNCj4gKw0KPiArY2xhc3MgQVNUMjYw
ME1hY2hpbmUoQXNwZWVkVGVzdCk6DQo+ICsNCj4gKyAgICBBU1NFVF9TREtfVjExMDBfQVNUMjYw
MF81MTUgPSBBc3NldCgNCj4gKw0KPiAnaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1D
L29wZW5ibWMvcmVsZWFzZXMvZG93bmxvYWQvdjExLjAwL2ENCj4gc3QyNjAwLWRlZmF1bHQtNTE1
LW9ibWMudGFyLmd6JywNCj4gKw0KPiArDQo+ICdlY2UxYTkzNDA5NTM3ODkyOTc4MGYwM2U3ZDA5
MmU1NjJmNGIzM2IyODQxYjgwYWQ3YzNkMTJhODU3NDRjMGY2DQo+ICcpDQo+ICsNCj4gKyAgICBk
ZWYgdGVzdF9hcm1fYXN0MjYwMF9ldmJfc2RrXzUxNShzZWxmKToNCj4gKyAgICAgICAgc2VsZi5z
ZXRfbWFjaGluZSgnYXN0MjYwMC1ldmInKQ0KPiArDQo+ICsgICAgICAgIHNlbGYuYXJjaGl2ZV9l
eHRyYWN0KHNlbGYuQVNTRVRfU0RLX1YxMTAwX0FTVDI2MDBfNTE1KQ0KPiArDQo+ICsgICAgICAg
IHNlbGYuZG9fdGVzdF9hcm1fYXNwZWVkX3Nka19zdGFydCgNCj4gKyAgICAgICAgICAgIHNlbGYu
c2NyYXRjaF9maWxlKCJhc3QyNjAwLWRlZmF1bHQtNTE1IiwgImltYWdlLWJtYyIpKQ0KPiArDQo+
ICsgICAgICAgIHNlbGYud2FpdF9mb3JfY29uc29sZV9wYXR0ZXJuKCdhc3QyNjAwLWRlZmF1bHQt
NTE1IGxvZ2luOicpDQo+ICsNCj4gKw0KPiAraWYgX19uYW1lX18gPT0gJ19fbWFpbl9fJzoNCj4g
KyAgICBBc3BlZWRUZXN0Lm1haW4oKQ0KPiAtLQ0KPiAyLjUzLjANCg0KUmV2aWV3ZWQtYnk6IEth
bmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPg0KDQpCZXN0IFJlZ2FyZHMsDQpLYW5l
DQo=

