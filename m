Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404FFD172CC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 06:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmnsM-0002T7-6O; Mon, 02 Feb 2026 01:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vmnsJ-0002Se-9y; Mon, 02 Feb 2026 01:57:31 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vmnsH-0002r3-5e; Mon, 02 Feb 2026 01:57:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DT8WntRQX/eBfGQ2BeE6I8LMiI6Axfq5g5x12olyFlj+mUNApAOqnZHUTF2+lD74notXFyzI9TVUrKyZP60OlrPDHUlTdurqhAZeaymjgQG4iZFep9XtqFJPndCy3FeWXiHYlRkn+zLRH6g2NBflHV56zTtl84eNf+drqHLBDwzMZvfikJBkA8THIQB1nebSHAqcnzS5Jstrr4USSL8IORdVGSeOk3zAOEr456moz5ZgnmN2n6hFlug93cyDO/QfJmUzz8wtdLGsdLqkfXSUs7k6BR59MhZovSn1/uv9+VRxNThRhUzKptdOUEmNxzR49Qz+CjkLP9YUqLwev3B6FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/4ySy03P2UPXZIANSqSj6NW/zickOMWK71M6zp17Ns=;
 b=RA1xlWw7KxkClRuL7vkcMq6sKt+Pd06aA765uBre0/Vxxqic1JGOU3PWRNxEQ7WeEv4lCTO9zMreXPGSSDLZXVwda2YP94lCsbedvA8RaXEmNLe7IXzYb6irQXtQcGycx+ypTOAxLh8NMpWrBxhRAkN4MXOYn0JR23omyNLVrb5x6as9ECWemdfQUnlgv5/TqDgNiMuQXtpQBmgljMOLwx+cZtwgI2d/Con4Xql9WCGKpk9qqkS+Hp3X64yrQ1kvV/fEKvTS0w5C4q0xkUDM238av3TMXOf/SvLaMk8+pfD9/+UlIre8y5QbPi8sGkADgez2Scof+xn7FBJYsGONQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/4ySy03P2UPXZIANSqSj6NW/zickOMWK71M6zp17Ns=;
 b=g1C2rhDu3GbrkinZQ4qNESn+QBZDB6kYglgqsFAyg/Ek+8LaC7VQzf8FuOIXVR6rQ9/PSBJtp+doDp0YiHgqlaTaWD/DABjb050fwpr/I3cTqsGLfU1z0yc0bhFdjwvNTGLhcGQagROcQXEJ/UOv+pin6FmLFWT+ow0X8lXRpVZvFIIj+MGgd19szhV9tU+cDyRulOTmINxHeUEst0iQmof2imgsayvlRErIJAYOWuyjLmA5ItfFrZ/4/CD39tyLkEa9X2zjQFguSQvOWxGfSXnFFiEaLVz83XwIyKwXui+p0OGxp/6jg4pnyv1BSBVXhBpRCQCWitW4nJceicDeOQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5452.apcprd06.prod.outlook.com (2603:1096:301:ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 06:57:20 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 06:57:20 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
Thread-Topic: [PATCH v1 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
Thread-Index: AQHcie9SKTdPnCSFkUWsdzq93BR4GrVkMO6AgAFQ/ACAABFPgIAAPRoAgAk8RIA=
Date: Mon, 2 Feb 2026 06:57:19 +0000
Message-ID: <SI6PR06MB763182A3E4BC0C6ADC0555CEF79AA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20260120092939.2708302-1-jamin_lin@aspeedtech.com>
 <20260120092939.2708302-5-jamin_lin@aspeedtech.com>
 <588fa41c-a5ff-455d-b64d-b36b986ee781@kaod.org>
 <TYPPR06MB8206FD6566DFDE3BA513FBFDFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <TYPPR06MB8206F928E28C7FE78BA9E3BEFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <TYPPR06MB8206F3CB33A135C5AC246E2CFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
In-Reply-To: <TYPPR06MB8206F3CB33A135C5AC246E2CFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5452:EE_
x-ms-office365-filtering-correlation-id: 2702d9f0-0d7a-4f06-3b08-08de62284f37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?dXhPMTl1VFFkR1kwYndnamJDMjA5WEEwa01iYkdORWlCcEx0UUhOM05iWFdF?=
 =?utf-8?B?Mm9ER3AxMllxdlRXRi9UOHhielRlNmk0UnA3dU5ac2NWVDV6SVRtZGhrcWNm?=
 =?utf-8?B?d1BjeG1sd014aU53WStiZ0ZCTmZ0bU9tSWlvRjVFUmxORWxjU1d4WVJOR0dU?=
 =?utf-8?B?VlhIbnA1Mml5QmM5TExhdkJqUFVxaUdGdVROcnoxR3ZEWlBYeUVSMGZtb0NG?=
 =?utf-8?B?RFhibUNEVW9pMFhUWjJMbWE1TmQ2WmhVNUY5OTR2a1pwMEE1REVIWURROU5S?=
 =?utf-8?B?MmRuNHRiSmtTcGxLa0IvMnpSak1ndWFEdHZxOHNSL0NLOG9FaTVwd3RLLzVE?=
 =?utf-8?B?T2lPTmlPTGVDVURhdzZncjFjNlRDZE9STWoyaDRXeE40UDA0YWphS0FiVWJO?=
 =?utf-8?B?Vnl1Q0o5MXZNaXBJT29jRnhHdm9BVWxxMk5KcW5PS2pnUld6Sll6OGhwNmdj?=
 =?utf-8?B?bUI5c3VSWkxSQzhGRGhVbFZmNTQxbkdvOU5iYlpSRitDekJoeER5NHI5K3Nw?=
 =?utf-8?B?TG5hTU9PQndDSmNlVWVkQno2NWM3MFFtUmU5UFFPSklUT1hGUENxSk0yTlV2?=
 =?utf-8?B?dXgyQnVhV0loZWxQdnlyWS9CMW1NZVBwOEFhVFpMeTV3WTRmY0VaUTd2d29v?=
 =?utf-8?B?L2xiMVVhK1lqWXFoVWx4TW1JbWcxNW0xMFNsMXI5S09sUk40cjBUZmxMZlNC?=
 =?utf-8?B?WDhHRlpHT2Z4Y3dOWFROUTlnYzdDeWlvZTRhREJsZnlpaEVxcFd1WVEwdDRP?=
 =?utf-8?B?MW83QnM5TUVMcktJdkRYUk5FR1l0SWl3c3VWdDNVWGZ4Q3BaKy9ibjY3czZY?=
 =?utf-8?B?MlpFSWVrdTJLWUxrVHFUSkx4V25wNFlTbUcrWU1sSEpYQVlDUktyY2ZGcWMv?=
 =?utf-8?B?WGVLell0RXpzUWw2TEJXUkJ6eE5iRlI1eklOcnZ3dUc2Mjc5Q3puMU9jcThB?=
 =?utf-8?B?QzdiTDV5bm1PWjRaZlY0bXczZnd2emZIUFA1cmtUL2ROK09DaFFCUTlqaGYz?=
 =?utf-8?B?M1JHeHNaTVk5ODBDMWRwUElrcFo3V0Nvc2hiSVpxY2Nkd3RoeVhZVTliSDVp?=
 =?utf-8?B?ZFFMWnZQNHBndGFteDBLTlZrZHppb0xxdWsrYm5DZ3BxN2ZCOFgvNEx5UGpy?=
 =?utf-8?B?dlVJelpmRXIrYStrWExkMVRjSjRmUVNtOE5CWDJhQjd6OGlabjlIa1Jra1l2?=
 =?utf-8?B?UVJxTS9VdGZYVTM3NVVkblpvYU1Rekd2bHVlN3V0cE9JajJFclc5bmxqZTJB?=
 =?utf-8?B?SWdNRWVud0d1WngxTWxQVndNMFR6R0JRYTVKeFc3SFhZTGZlZHNWNlVzQ2hC?=
 =?utf-8?B?TnZHSXBnZ3lGWklwczdONGZKRlR6NjN6QTViNlMrYU95MVNFWUhiMlRRZFND?=
 =?utf-8?B?T25OVlFvRldHWmVkN2k5TkNBc2gwbmNPYytTcVlXbzNtdXljci9Kdm5PVUJO?=
 =?utf-8?B?Z0h3WlZCSnp1bUFuU29aNWliV1E0OVk1OGFEWnhWQUJUdEFPYnBwbU5wUlBl?=
 =?utf-8?B?MXRoUlB1NXdwZURiUFhya3hEcFd3ZDExNCtybWQvdVQxRUxrSytWN2VQb2Nq?=
 =?utf-8?B?bEMvdlQzdVhsYmUwWlUrMmJoMkJtdXNSL042RHNMNExEQnZ2MnNyMkNCOEph?=
 =?utf-8?B?bS9wVG9xL2ZmblE0djNCaXZSM0lyWURIcDlUWTNISjk3REUzVTQ4b0NQQytV?=
 =?utf-8?B?bmpJOXpYZDNKK3Rwc3RBbXU0NitNRVNYVWJJZWRLNVFxY1hIb0N2T0FJa29F?=
 =?utf-8?B?SkcrNDdlUk16cG5Wekc4VUp4eDRnWnFYMHZsdEdNd1dKSmlCalJuUjI4TWpi?=
 =?utf-8?B?VXphTExLNmNaRzFXVGlkVnZlUUdwdjZpaFR2M3d2U0ZDbTNPMldEeVJGN0F3?=
 =?utf-8?B?WFlHbVFDUjVyNVZrTVlLUks3RUZrMVJSa2xqRTVKSjJNaE56V3l4TVBKaUl5?=
 =?utf-8?B?TlFXaUU2RXN2RmU4M0NUUGZOR0VUY3M3NlRXQ2RHQ1ZLUzlYS1NLbE9BUU1J?=
 =?utf-8?B?cFBjeDJRRWcvTUE0OW1TTGpVWXZyZ2VXRWdnZ1dFS2dIMGJBZ2tZTUhybG5J?=
 =?utf-8?B?cVUwai9Bc1NHYlluOExONmgxM0UyT1RNaXVnR2N4UDVtYTVtNFQxTHNXU0Rt?=
 =?utf-8?Q?O74U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEFFSjFZbmxnalFQamxvNVRXcnFZUGxJSjZOaDNlZWpCNXgwVDdqd3FMemdr?=
 =?utf-8?B?VnFiNlN1eitXVzlXVXAxZ1lURlRIZ2tyOHVDbnpPVkRpeTByZHd3TTA2L1ZH?=
 =?utf-8?B?bFVsZVRNOWRPQ1IyZ0o0REZZT2EvZjQ1N1d3WGhaeU81VEptVEM0M1BkcTNr?=
 =?utf-8?B?d1JReFZiMWMwdmdCSk1OV0g4dk9nWHNuSVBrSFdOem9rRUVMbnRWS1MvSmR5?=
 =?utf-8?B?UDNZcXhpbjd2ZENSS2l2SHZuekwxQTRIcUZ0enZlckNhRE5URTlvMkpDZVJ2?=
 =?utf-8?B?SG1XbE9CL1E2NlowNkhwaWtLWXkyQzQxdExLQVdhaHh5a0lvc1R0TEZFbmFj?=
 =?utf-8?B?WUpXTlJkVUd0di9wREU5TWdvRGVMb1doWlpXTDEyUFBFVGVZK0ZjbGQ4N2tN?=
 =?utf-8?B?V3lUZWk1ejVrTUlQbUQ0a21rem9wSkp4eEdxaEpFT0pJdngzeVFrQk1hV05y?=
 =?utf-8?B?STJ3cThRTVR5UVBxeGw4Sk1xS0VFTFg4NVp2SXZZQ1g1Z1VIUEpVR3F3bTVW?=
 =?utf-8?B?VWJoYW44bVdxd083cVA1VDUyVGRUa05hQ2VlbVBmcytudFRIQjZEcGhqYXBW?=
 =?utf-8?B?K2hDeTN5UHFBRG9LTTlHMXBCSE9RZTVjZjk2a1NHNElFb2NldkNHTEluZUt5?=
 =?utf-8?B?SFZRUGs4MEJ3cUpzSWlnd3JqWUt4MjB6TmtWSlNCVHRSeXVWcmdOODdNbzBz?=
 =?utf-8?B?ZExMTW1xdXdTU1FQc0IxbzRwSFhmdVpuS1loaEg4SGpFazdoZDFzdHdjbXhW?=
 =?utf-8?B?TzFreGF6ZFJveU9jWWVGSGI4U0ZaU0NieEpvZkZZTVNwZUdxRHFDeVgrYVNr?=
 =?utf-8?B?RHBveTVXQWlacFBnRmxPVUw0RzBRWjh5OHduRDFrUkJ2VDFlcnNpY1U5bVlF?=
 =?utf-8?B?enZGR2Y1bUdwYTdwb0dwRkR5TGZlNVpxT05oR0dSWHJyRWdvNjJvTU40YnEw?=
 =?utf-8?B?YkJTemhJMVpKNDBiZ2kwRlhEeEN1RE4yVnY0M3J2THdZS1pEV0lMN0lXMUJ0?=
 =?utf-8?B?b0NvMzJ0Vk9uaFJYWGc2L0NFTFBBZ0dXbFk2Nnp3MFhsNlYra0hPWS9KYS8z?=
 =?utf-8?B?eDhmNnc5UjR6dFdLdVIxaUVrbWJXS2Y0RG1DV3lQWktBNG9qUCtYQWR3SDZu?=
 =?utf-8?B?d0RtbmpmY21mWm8yOEFESEp0emJRbTQ1aGlTNGVNUzg5aWprV1VOdzM1YUZn?=
 =?utf-8?B?YmhJYTZ3aFd0dFA3VHVEbjllRDNwVW9kdEZrSzNyQ083dFZwc2FiN3RSVzF6?=
 =?utf-8?B?dWR6aytGUmk2Tnd2KzJybi90cDBydXhqeXVLc2NFZklrVGJZSERXOEFjK1hw?=
 =?utf-8?B?bHVKNk9Na3oxK1hlYmI0MWdTRGI3SnpQM0FwQTl0TGV2QzVnTDgxYkp1UDhL?=
 =?utf-8?B?K3VzT0E4Wk5PaFRFUkNSd3cxc1dYY3Z1cDk1VUtvTzBFdkY4UG1xUVQwZ1pF?=
 =?utf-8?B?YnFjM1JURGh1UUxNUUhucHV5NVl6dUFyOVVmWGwzQUFJbkVhU0Q5RlVzVFNX?=
 =?utf-8?B?cjVNZXdvazc4ZjFiczcwNlZQUlNUaVJ0dTQydlcycVlER1lQWTRVNlJBWitx?=
 =?utf-8?B?V1NOSENQVUxQNnAvdldBMkxZaVZQdXNObG5nZjVpaTJFeWRXMUt3VEhEWGJP?=
 =?utf-8?B?bXZXRkprWlVidHBFVzhEZThwbGRpbnZjRkdJMnZXYjNQWkxrenA0VmVsOUFs?=
 =?utf-8?B?Mk1lY09uWDYxUXdEdjVoZzRUNkxQSktLSDVJaWlCK1B0RzF5cllnZktEa29U?=
 =?utf-8?B?Uy8xekF0eWJlaWJEMFZQMnZlVGpNNEhidmxaY09Ia215R1VBa0w0M1RDMG5U?=
 =?utf-8?B?TEJ5WFJaNUJLT0kzT3JOQ0NKRmo5anhZZDM4QzdEMGpIYWtveHdndlhHRXU5?=
 =?utf-8?B?ZjQwcXBleVBsdGY0U0VmVkp1Z3MvN2ZqVUhQemRYZkZwOHpHMmREdGRWcG1R?=
 =?utf-8?B?aDNkUjhGZ21EbmRhRVBiOHVFbVUrL2QxeHV4ZlJrbTJXUVYrL2Q0bmk0YWEy?=
 =?utf-8?B?c2ZrMDRBZWhqU0NkenhBSjVEZ2VjVjl1MkVFL1p4VFc5U0JJLzBYRDdxQjFB?=
 =?utf-8?B?K2ZBaDdPcDFDSUZmajZHYVMzaXk0ZDlHam91TXZkcWo2Z1kwYzhKU3hwWDg0?=
 =?utf-8?B?aEg1QzVJS0RjY0pBOWJMNk5BeWVFVTBjdVB3VzJFZitmTFlTYWk2aS9NbHp3?=
 =?utf-8?B?RUZENFA4SGxJck92TXJkeEhoS1FOcmtHRjg5VCtxcDFYbEprWSs2dmlyNnpQ?=
 =?utf-8?B?Q0NnTm1GMlhuMjFPUHgwQk5INFpCMWR6QjJQWHRtL1ZIVXV0TjBrZDduV0M0?=
 =?utf-8?B?UDJSRzkxWjZxeHBFUXBuOXM4T3ZFZ0g1bXFZLzcrU1d5d0ZzNFFVUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2702d9f0-0d7a-4f06-3b08-08de62284f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 06:57:19.9997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWIG4517Ovr0jT9cKD8guR97WTNzksP1X+yjr9U74sj5VFY0Q8c0QjsR+FdV7k0hhGY91Sx9fv6YBYq3hnE1FxpJSj11LM5naTyZWBVuJCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5452
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW1pbiBMaW4gPGphbWluX2xp
bkBhc3BlZWR0ZWNoLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAyNywgMjAyNiA1OjQ5
IFBNDQo+IFRvOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPjsgUGV0ZXIgTWF5ZGVs
bA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZSA8c3RldmVuX2xlZUBh
c3BlZWR0ZWNoLmNvbT47IFRyb3kNCj4gTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEFuZHJldyBK
ZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+Ow0KPiBKb2VsIFN0YW5sZXkgPGpv
ZWxAam1zLmlkLmF1Pjsgb3BlbiBsaXN0OkFTUEVFRCBCTUNzDQo+IDxxZW11LWFybUBub25nbnUu
b3JnPjsgb3BlbiBsaXN0OkFsbCBwYXRjaGVzIENDIGhlcmUNCj4gPHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT47IEthbmUgQ2hl
bg0KPiA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYx
IDA0LzExXSBody9hcm0vYXN0Mjd4MDogQWRkIERSQU0gYWxpYXMgZm9yIFNTUA0KPiBTRFJBTSBy
ZW1hcA0KPiANCj4gSGkgQ8OpZHJpYw0KPiANCj4gPiBTdWJqZWN0OiBSRTogW1BBVENIIHYxIDA0
LzExXSBody9hcm0vYXN0Mjd4MDogQWRkIERSQU0gYWxpYXMgZm9yIFNTUA0KPiA+IFNEUkFNIHJl
bWFwDQo+ID4NCj4gPiBJIGNhbiByZXByb2R1Y2UgdGhpcyBpc3N1ZSBpbiBodHRwczovL2dpdGh1
Yi5jb20vbGVnb2F0ZXIvcWVtdQ0KPiA+IChhc3BlZWQtMTEuMCkgSSBhbSBhbmFseXppbmcgdGhp
cyBpc3N1ZS4NCj4gPg0KPiANCj4gRHVlIHRvIG91ciBtYWlsIHNlcnZlciBub3QgdXBkYXRpbmcg
REtJTSAoRG9tYWluS2V5cyBJZGVudGlmaWVkIE1haWwpDQo+IHNpZ25hdHVyZXMgeWV0LCBJIGFt
IHNlbmRpbmcgdGhpcyB1cGRhdGUgdG8gaW5mb3JtIHlvdSB0aGF0IHRoZSBmb2xsb3dpbmcNCj4g
cGF0Y2hlcyBhcmUgcmVhZHkgZm9yIHJldmlldy4NCj4gDQo+IDEuIFJlc2VuZCB2Mg0KPiBbUEFU
Q0ggdjIgMDAvMTFdIEFkZCBTU1AvVFNQIHBvd2VyIGNvbnRyb2wgYW5kIERSQU0gcmVtYXAgc3Vw
cG9ydCBmb3INCj4gQVNUMjcwMA0KPiBodHRwczovL3BhdGNoZXcub3JnL1FFTVUvMjAyNjAxMjcw
OTI5NDMuMzczMTYzNS0xLWphbWluLl81RmxpbkBhc3BlDQo+IGVkdGVjaC5jb20vDQo+IA0KPiAy
Lg0KPiBbUEFUQ0ggdjEgMC83XSBVcGRhdGUgZnVuY3Rpb25hbCB0ZXN0cyBmb3INCj4gQVNUMjUw
MC9BU1QyNjAwL0FTVDEwMy9BU1QxMDYwDQo+IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDI2
MDEyNzAzMjM0OC4yMjM4NTI3LTEtamFtaW4uXzVGbGluQGFzcGUNCj4gZWR0ZWNoLmNvbS8NCj4g
DQo+IFRoYW5rcy1KYW1pbg0KPiANCj4gPiBUaGFua3MtSmFtaW4NCj4gPg0KPiA+ID4gSWYgc28s
IEkgd2lsbCB1c2UgdGhpcyBjb2RlIGJhc2UgYW5kIGFwcGx5IHRoZSBwYXRjaCBzZXJpZXMgdG8g
cnVuDQo+ID4gPiBtYWtlIGNoZWNrIGFuZCB0cnkgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZS4NCj4g
PiA+DQo+ID4gPiBUaGFua3MtSmFtaW4NCj4gPiA+DQo+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4N
Cj4gPiA+ID4gQy4NCg0KSGkgQ8OpZHJpYywNCg0KV29ya2luZyB3aXRoIG91ciBJVCB0ZWFtLCB3
ZSd2ZSB0cmFuc2l0aW9uZWQgdG8gYSBNaWNyb3NvZnQgbWFpbA0Kc2VydmVyIHRvIGVuc3VyZSBE
S0lNIGlzIGNvcnJlY3RseSBpbmNsdWRlZC4gQ291bGQgeW91IHBsZWFzZSBjb25maXJtDQppZiB5
b3UndmUgcmVjZWl2ZWQgdGhlIGJlbG93IHBhdGNoIHNlcmllcz8NCg0KaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9RRU1VL1NFM1BSMDZNQjgxOTlGNEIwMDY5RjkzMjYwMzQ1ODVENkZDOUFBQFNFM1BSMDZN
QjgxOTkuYXBjcHJkMDYucHJvZC5vdXRsb29rLmNvbS8NCg0KQmVzdCBSZWdhcmRzLA0KS2FuZQ0K

