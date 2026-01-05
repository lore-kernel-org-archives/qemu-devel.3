Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1BCC2A072
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 03:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcbb6-0001G1-0f; Sun, 04 Jan 2026 22:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcbb4-0001FN-14; Sun, 04 Jan 2026 22:49:34 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcbb1-0000VW-7q; Sun, 04 Jan 2026 22:49:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vb992gvExIgoosQ9ub4A2gtuk7AxTKt+Jwy5daFKxLPuebbhV7gRH0KN6A9E5DXF0fA/e8K9ZmplUpvoheW6YeDyXdH09SjKpnnemTBuGq7RewaGi/L2RyBVSuZzA96/Rirz3LfQIEvwvGR0F5IUL2WPbgIOODU6+MeQZdc8gPG3iGSloHhWKPQQghYaZWzryjutAjg1J6S6RRBnRM8J4tzKvz/rrwSMN8jD30vCS8PTMKguw79+j+A54jhIWEHezLSqK2jzmbLw0Jm0MSy5ygjgq3QiF/F7kvW9JGnMj+ZHFo6hhct/X8ho/P3fltrnXK6/EqaI4en/y7of7XUKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWmg4elHq6YikpQ1nYeeW59pzvZLzIE5iZTdtZnu12o=;
 b=pYy8OPFVQ8sofhoO8y+TX3+Rr/vBBefnKwbx49RBywrs+8BDEgzWFJic2c1L/fxN3omhSkBcPbKScgIeru1eaxHzPxbCR8lvFyxH7a+T5EgQCU45dUbjjWZEQijkj4eC14fwmSI/3/hLuIucngn8IbUo/tb6fht8zyKqtxdCPTzKYgLd6hLNLLfmafBcdZT14fHJjFVrmdvrjLX7y4qWO2fk8GKg/1BQI6bXG7Hj1Rl1ysATlwbUiv4S3AX5//Yv2oiw+Af23+9NzZ5kuLiQTUdVNmtd6sLneJP+KJyjjMgLAswmiz618sQ2fSAR8w0VPE6F8h7Sl9RWCXcjDRcV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWmg4elHq6YikpQ1nYeeW59pzvZLzIE5iZTdtZnu12o=;
 b=KsNXc8u7Fz89hclzbHyQV3X4akCo9mCcC6RGvWkCQA36IUt+F+syk2LfyYNcge26mA9x5pCSWYXgn3Nbgo+Hon68yE3sGJScPBatbWBFPsBUEXYwTx17wL6JATWQ0S8u1xJky/s0QMAgKu7M1O+yhjxAlAWiQUVIByD0NGnYbQeH5JH/8IL50VFX4cMq9q0UEUo+KC3lWr4yjmo8gn5c/lk4Y4TD15H8K0/89ueoHWXkwGUaN4ysyWGNbo4jVV+ZMsySFNal+7JpBwDtnVTEyIUJ9FUKD2CKmbBK0Z8UsAN8BUh3hHwTu2tVUlLY5uWrdk4aED64vAoiUQa/XTrYIA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB7326.apcprd06.prod.outlook.com (2603:1096:990:a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 03:49:22 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 03:49:22 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joe Komlodi <komlodi@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "venture@google.com" <venture@google.com>, "clg@kaod.org" <clg@kaod.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH 01/19] hw/misc/aspeed_i3c: Move to i3c directory
Thread-Topic: [PATCH 01/19] hw/misc/aspeed_i3c: Move to i3c directory
Thread-Index: AQHb2/a3agfcCWR4HU+iVQfFXhGh17VEM8gw
Date: Mon, 5 Jan 2026 03:49:22 +0000
Message-ID: <TYPPR06MB82060A648C9205CC3FBA90CDFC86A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20250613000411.1516521-1-komlodi@google.com>
 <20250613000411.1516521-2-komlodi@google.com>
In-Reply-To: <20250613000411.1516521-2-komlodi@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB7326:EE_
x-ms-office365-filtering-correlation-id: 526b1e37-6615-4688-b220-08de4c0d69de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NFNCbEs1bWRvZ0xIcUtVNGpNSDR1a3VtaEY1eDNUMVRDQ21ubHpTY0dmTnRx?=
 =?utf-8?B?Ui9GNGdkZzNvbnJWRGJYZHMwUEcvUnNjTGplMlpGdVJFNDBYTVdia2NJVjBK?=
 =?utf-8?B?am5aTzZFL240bDEwQitFQUZlbFc5NHB5K1hlVDRNcGlMU2E4L0YzdlNYQi9i?=
 =?utf-8?B?RVcrZy81TGFXRUNzR2FGWllYOTRTS0lHeWxTZ1VkeWVXQjUvOExZenI0YWcz?=
 =?utf-8?B?amhrWFBCT1ErN3l4TjJzc0djWlNUa1RBOGV1aUYwTnRSV3R3bERRc1J4WmZV?=
 =?utf-8?B?VlJkUmpMK0lVTlRLcHVCbU01TE1uKzNkM29yaXhLbFZmYSs3d0hRZW1mV3cw?=
 =?utf-8?B?U2lWeE9uYzVaazRjbk5udmVyVU1nV0o0MWNrNitkMFV3SnlXeEtPS3gwYWti?=
 =?utf-8?B?bVNqbTRkNFlEVlhCcHlmK05BV1RQQ2tEUmg2NUtKVGJVdWZGYlRUdGtpK2c1?=
 =?utf-8?B?c1o3LzZ5WWM2WGxBUzZqQXlFMTdnVG5RYlBadnN6U3oza1hhdnJzQVFCelJY?=
 =?utf-8?B?UXBRTmRjYXdmd3dZcFViYzBNN1lTczlCeEc2Znp5ZDZvZENxK1JoTnVTRkd0?=
 =?utf-8?B?UTJxelBkSEN4bmJVZng0RVFKMUV2Y2hBb0JZQ0xLNWwxalFuM0x4cTVSSDU1?=
 =?utf-8?B?QjFEc29YblN0N1JwcG8zNDlQcDdVdUlSWUQwRUYwbU1Ebk9hV3dmMm8vU3Rp?=
 =?utf-8?B?RnkzZnRReGlDOXVaaEFZUzNpeFlNdCthcmJ6ZWJHV3VPRjk1dEpwUjBZYko5?=
 =?utf-8?B?WmEzbDhVWC95djFPTlpBRDZOaHkyakdkU1RiZm82dTQveG9UdmNrSiswQTRy?=
 =?utf-8?B?WUNnV3ZDa3ZTU1lNczhONjUyNVBPTGljaTNNbVpCU1RzSkRjQkJjajZkd2JK?=
 =?utf-8?B?UFJySkhFKzVLT0M1QWdkT1M2V284M2lYVThHZi9Va1dmSlRjSU1neGhkbmpG?=
 =?utf-8?B?bkxFdTRUbk1SU3NKQWhmeEZKaE80bGpkTVN2OWpoM3dBbWRvZzRRRXhhV2JH?=
 =?utf-8?B?MzBmQjYyU0NZby9TUDVaZk5yQzlmWFJQVnNPMnd3Q2FRYk1ZV0pYc1h4bllM?=
 =?utf-8?B?RkpHZzc3YnIyVUhSdmRBTFJHb0RjclZHRlR4b1RKYjNZRHI0NFozVVprUnhk?=
 =?utf-8?B?dmxjbmk3eXl4RFVLQmlsb2RmR1BGek51Nzh2dXdPTnNZa0tiOWNYVzFrNnBt?=
 =?utf-8?B?YnhGMC9oYVhZQ20rSUxoT1diWitqYVhZVEpmS1cyUXZDWERpNVdicE9sOVRy?=
 =?utf-8?B?Znc4VTVOajQyaUVPMmN1SlZwQzIzTGtxWktiR1o1MWdyOEdNMmVnRFdBa0JT?=
 =?utf-8?B?ZmlJQ3pFOG1WK29WTm1qdGoyODBtUG4rR1d4SWdJUXVZS2crc2lHc2c0V0ZP?=
 =?utf-8?B?ajJCVWt1eHhZL2libm4zdW4xRDZVdmtNWmo2KzBSS1FXMm1XQmlKWVdESzBZ?=
 =?utf-8?B?dXZKUk1rbmNPQWZhTnJVemxXMmROMks5TzJ3WjlkSzVBNjZibVphc2hDWVEy?=
 =?utf-8?B?NGhOVUFablJZNnNJQ3IyL2NRa0NPd1ZLbFhHMUcvdEw0d200MWR0bU0wZ0Nl?=
 =?utf-8?B?S3RwNW9DKzE1SHhkdG9KVlZLanI5bU5mcEpiUGliejh1LzgxclZNMnpLbGww?=
 =?utf-8?B?aStweTN3NDVpSHNXVjNZc3oxL011UmFVQk93MUs3ZmZ6TDJsSGJ0RDdzYWdK?=
 =?utf-8?B?TEh1WEh5dHRQdkpJVHlmL3Q4SEF0ZDZRQlFnNUl2RzFLQkZkc3UyeVhqNDRI?=
 =?utf-8?B?Wm1aZHdnUXRIakFrUXVhSVcyNDhIMjRJcHFha0MyYWFoNjZmL3dxQ3hTc25m?=
 =?utf-8?B?bWh6T3VkRkhGMFl5WE9YajAxRS9kaEFSOWc4T3V4MVc5MHlrZFQvajlqVHNa?=
 =?utf-8?B?VkdseGZkZWN1NzA1dW1mQ1JZODBQKzM3bFRlN0VQcTFqdkhyb3h4Z1JscStS?=
 =?utf-8?B?Sk9oaDZpWDRLUjBrUFFtbU1maVF0UnAxVzRFTUxYZHdraEVzdk5qT0R6Wjdp?=
 =?utf-8?B?YWRaRWNFcUJkYTBFRlNjQ1VGVk5CRHhjQTN3eTJ6STM0RGNpTXJyc1pTcmxJ?=
 =?utf-8?Q?HrXaRx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czF1MitjY0JBOWdkdnlvQ2hBTXdjWDkwZWNFZzlUOU9PSUhNNnN6QmZnTzJI?=
 =?utf-8?B?TEZpWEJjYUFHc1BUUHp2QU1KVkpwT0UwQk03MGlFNUtybUx6QjFsanN4bnFp?=
 =?utf-8?B?ZjhkSzl4QkFkb2l0bVRZaUJDZmJ5TXRDSVF6UUJSdnkyMStqMC9LdEZMVXJ2?=
 =?utf-8?B?eUhkSFpwUldyb29EWnljQStoR0pBZFBwZFBZeStRUnBLdi9rYWVuWExEYW1R?=
 =?utf-8?B?UUJlQm9pYVIwUmV4MFVCdUUvZFd2UEVKbWx4ZC8zRGpxVmZIMXJyaEhqUVR3?=
 =?utf-8?B?T0NQQ0hBTDJlRXdIUkV6OTJyRkhjSFVRMHNEK3Iwb2puWEVoRzJEYlRSN2FN?=
 =?utf-8?B?KzNGSjZHdDdVZEk2VUw2WlM0ck1wNUlTNnZvQ2E4Z0dLRENBaFNSYnFLY1hx?=
 =?utf-8?B?WWFLS1FqWGpHWFJUbUx2b01rQUpaRlRwWlI4cWNQMXU3dkU5T0p4b2lXRUk0?=
 =?utf-8?B?c3g4UlVJdEZqZkVnYTJidWNrN1FnVmFWT25GUmo5TGRXQ3oyRXphL3dlTHpo?=
 =?utf-8?B?RFYrV3ZscFo1LzJka21HVGdWRXFBclZWcHRmejdLL055OS9JZUtUdWgzZTds?=
 =?utf-8?B?UzQveGk2MFIxYXNPYUNQUE1tOEw0Wk82RnhnTWpFVXVoVytRWEcrbzVPR1Ur?=
 =?utf-8?B?L1dNZ2RWTzdGOXJDTDhNSjFvcDhxUWo5OWFZSk14Q3ZoY0MxOUNzWmNjeE1Y?=
 =?utf-8?B?VUI1cXJhWlBOUmNPUjRMZzcwVzFPR1Jnb1NCQzE3SXA2WitvSU5aTDRhTkpN?=
 =?utf-8?B?NFRXSklsZU56a3ZGZmZtSjVCa0dMbXppQWtFQUF5SFBMbVFQQlVaR1VsQ2Fx?=
 =?utf-8?B?MGdXaHRpaWpVVDg4RFN6aUswaHBVY2lBaldjUmNTQlRLRXlsRVlldHhPSElX?=
 =?utf-8?B?RUxYSmhLTXZIdlArWU9HOVFpWngrdUgxYVdWSVlZTURZaE9RaW9aYVZXcG9Z?=
 =?utf-8?B?d2YzbWw1TW1mT2ZjNlJPaUJ3U0QyL0xqQnV1c1NDSmRwN0tjN2RGSlpmTWNv?=
 =?utf-8?B?a2wvNWFkQk5sSSt5eWlMTnl5ei8wMFEyaWNuTUJBUkMyZ2FMQ0E5V0tGU29F?=
 =?utf-8?B?akhzL3VVMWVNcmRwYmlvNk9LeHFtem5iaytLSG5tTmNZYm5ZZCtBektCcVl2?=
 =?utf-8?B?cHZBSEp1WGg3U1orTzNad1Vaamd0Y0V1MmwxeWZYYklzTGtMRWo3RUZGVytN?=
 =?utf-8?B?cDd3N0hVdEN1T0haR0dzTnhnLy9oRS95RVBva05pUlk1REN0R2dTRE1ac25M?=
 =?utf-8?B?SFRkRmJ5RFhGN0EvL1I3UkliU2hLbG5pTGZCWlJIeWp0aXJPS2ozTHVYNlp6?=
 =?utf-8?B?UG9XaGdERitJSlZIVmNJcFk4MFJERStIZnVQMVV1a0xXK1orbHRKMXJmTUdM?=
 =?utf-8?B?MlBxQnJVam5WeURKT0R2N2srOGZHdGUwUStsV216ZUNKby9QZjlvZXc4b1o4?=
 =?utf-8?B?QVFXQUdxc2RJNndBVGtGRUtRci9NRjNaZ2FvNitWMkFEejgwR2RlRnFJTHZH?=
 =?utf-8?B?M1M2dUFzU3NmNHpTU0dpUDVEZGpMZ2x5aGx5bCsvTVkwUXd6SHhSaEpubkNj?=
 =?utf-8?B?WVhydi8zL244WUhCZW1nUHBXU3pxaHczdS9UQ2Zhc0JYLytwMDFwZkVZSVFa?=
 =?utf-8?B?OFhvMEhORml5SXFSYm9RUEk1MUIvWEFWYnpOWnY3UTBtdUJ1TGRJMVdEM3Jq?=
 =?utf-8?B?eGJsekVFZGhFT0lpUUJnc1dYY1V4NUZVbXNzS1B5aGk5ZVdwTi8zZE8ybjBF?=
 =?utf-8?B?WkhUbHA1YUt4c1V5TXpRRjRtb3FZZXhDV3gxazZoQndhbHNYWm93K2xZMSs3?=
 =?utf-8?B?bFQ2anpnZkc3QlpmQzYyZWQ1UHQ0a0Fudnk0UE51dkZzS3hUZ3FrbmRidHM3?=
 =?utf-8?B?OUMrSXAvMm1LZmxVRG55TWZwekliNnp5SzA2bjI0eVNpVUkyTjVrMmU5cGty?=
 =?utf-8?B?UmxLY3dXV0ZBSmFaS0hzR2hNaWJJMTQxTXNnam0zY1RJNGg4RmpyOGpuaVBU?=
 =?utf-8?B?SWx1eWJjNzU0bjRHNVFFL3ZrWE80WUFIdWRHK21Hb0ozQzMzb0M2V0lPaVly?=
 =?utf-8?B?TU1LNW53UmdNbnpEV2djUGxsd1N3by95OXBZYUhBYWd5OUpwdlFRSlN1bFV2?=
 =?utf-8?B?dUhSYXZTejNJbjRvTFgrTWdEVFdHSHl0WTdQWk5sblB1LzUrSzRGenRWWHZi?=
 =?utf-8?B?Qy9FSForcnRkMkduZXhndk1vbndyQUR4eWZzNS9PQmNnNlZubUNqOXlQV1o5?=
 =?utf-8?B?OWlGb2tKVWFnLy8vSUdCZGJ6aFErQXNoVnozZGNka1pLZ2xGM3RLdmI3OHVz?=
 =?utf-8?B?dk9IVVRZZFpnWFM3bGQ3WUVTbTNyS052alN6ZUJtbm1lSkF0Z0diZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526b1e37-6615-4688-b220-08de4c0d69de
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 03:49:22.7125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hx6ZvmmOP33ToBSXxxm3z9Xe6nG5WnV25jL8xDcx98sAG0+cOasVhVLO6otx2E62NCOQWJ4AutvpQ+Q5lKfeHyGXgjyBB8lIAU72a/G4Ezk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7326
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

PiBTdWJqZWN0OiBbUEFUQ0ggMDEvMTldIGh3L21pc2MvYXNwZWVkX2kzYzogTW92ZSB0byBpM2Mg
ZGlyZWN0b3J5DQo+IA0KPiBNb3ZlcyB0aGUgQXNwZWVkIEkzQyBtb2RlbCBhbmQgdHJhY2VzIGlu
dG8gaHcvaTNjIGFuZCBjcmVhdGVzIEkzQyBidWlsZCBmaWxlcy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEpvZSBLb21sb2RpIDxrb21sb2RpQGdvb2dsZS5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTog
UGF0cmljayBWZW50dXJlIDx2ZW50dXJlQGdvb2dsZS5jb20+DQo+IFJldmlld2VkLWJ5OiBUaXR1
cyBSd2FudGFyZSA8dGl0dXNyQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgaHcvS2NvbmZpZyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8IDEgKw0KPiAgaHcvYXJtL0tjb25maWcgICAgICAgICAg
ICAgICAgICAgICAgICB8IDEgKw0KPiAgaHcvaTNjL0tjb25maWcgICAgICAgICAgICAgICAgICAg
ICAgICB8IDIgKysNCj4gIGh3L3ttaXNjID0+IGkzY30vYXNwZWVkX2kzYy5jICAgICAgICAgfCAy
ICstDQo+ICBody9pM2MvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgIHwgMyArKysNCj4g
IGh3L2kzYy90cmFjZS1ldmVudHMgICAgICAgICAgICAgICAgICAgfCA3ICsrKysrKysNCj4gIGh3
L2kzYy90cmFjZS5oICAgICAgICAgICAgICAgICAgICAgICAgfCAyICsrDQo+ICBody9tZXNvbi5i
dWlsZCAgICAgICAgICAgICAgICAgICAgICAgIHwgMSArDQo+ICBody9taXNjL21lc29uLmJ1aWxk
ICAgICAgICAgICAgICAgICAgIHwgMSAtDQo+ICBody9taXNjL3RyYWNlLWV2ZW50cyAgICAgICAg
ICAgICAgICAgIHwgNiAtLS0tLS0NCj4gIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCAgICAg
ICAgICAgfCAyICstDQo+ICBpbmNsdWRlL2h3L3ttaXNjID0+IGkzY30vYXNwZWVkX2kzYy5oIHwg
MA0KPiAgbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDEgKw0KPiAgMTMg
ZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkgIGNyZWF0ZSBt
b2RlIDEwMDY0NA0KPiBody9pM2MvS2NvbmZpZyAgcmVuYW1lIGh3L3ttaXNjID0+IGkzY30vYXNw
ZWVkX2kzYy5jICg5OSUpICBjcmVhdGUgbW9kZQ0KPiAxMDA2NDQgaHcvaTNjL21lc29uLmJ1aWxk
ICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaTNjL3RyYWNlLWV2ZW50cw0KPiBjcmVhdGUgbW9kZSAx
MDA2NDQgaHcvaTNjL3RyYWNlLmggIHJlbmFtZSBpbmNsdWRlL2h3L3ttaXNjID0+DQo+IGkzY30v
YXNwZWVkX2kzYy5oICgxMDAlKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L0tjb25maWcgYi9ody9L
Y29uZmlnDQo+IGluZGV4IDlhODZhNmEyOGEuLjYxYjhiMmExNDIgMTAwNjQ0DQo+IC0tLSBhL2h3
L0tjb25maWcNCj4gKysrIGIvaHcvS2NvbmZpZw0KPiBAQCAtMTMsNiArMTMsNyBAQCBzb3VyY2Ug
ZnNpL0tjb25maWcNCj4gIHNvdXJjZSBncGlvL0tjb25maWcNCj4gIHNvdXJjZSBoeXBlcnYvS2Nv
bmZpZw0KPiAgc291cmNlIGkyYy9LY29uZmlnDQo+ICtzb3VyY2UgaTNjL0tjb25maWcNCj4gIHNv
dXJjZSBpZGUvS2NvbmZpZw0KPiAgc291cmNlIGlucHV0L0tjb25maWcNCj4gIHNvdXJjZSBpbnRj
L0tjb25maWcNCj4gZGlmZiAtLWdpdCBhL2h3L2FybS9LY29uZmlnIGIvaHcvYXJtL0tjb25maWcg
aW5kZXggZjU0M2Q5NDRjMy4uNDI3ZDBmMDI3MQ0KPiAxMDA2NDQNCj4gLS0tIGEvaHcvYXJtL0tj
b25maWcNCj4gKysrIGIvaHcvYXJtL0tjb25maWcNCj4gQEAgLTUzMCw2ICs1MzAsNyBAQCBjb25m
aWcgQVNQRUVEX1NPQw0KPiAgICAgIHNlbGVjdCBEUzEzMzgNCj4gICAgICBzZWxlY3QgRlRHTUFD
MTAwDQo+ICAgICAgc2VsZWN0IEkyQw0KPiArICAgIHNlbGVjdCBJM0MNCj4gICAgICBzZWxlY3Qg
RFBTMzEwDQo+ICAgICAgc2VsZWN0IFBDQTk1NTINCj4gICAgICBzZWxlY3QgU0VSSUFMX01NDQo+
IGRpZmYgLS1naXQgYS9ody9pM2MvS2NvbmZpZyBiL2h3L2kzYy9LY29uZmlnIG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0IGluZGV4DQo+IDAwMDAwMDAwMDAuLmUwN2ZlNDQ1YzYNCj4gLS0tIC9kZXYvbnVs
bA0KPiArKysgYi9ody9pM2MvS2NvbmZpZw0KPiBAQCAtMCwwICsxLDIgQEANCj4gK2NvbmZpZyBJ
M0MNCj4gKyAgICBib29sDQo+IGRpZmYgLS1naXQgYS9ody9taXNjL2FzcGVlZF9pM2MuYyBiL2h3
L2kzYy9hc3BlZWRfaTNjLmMgc2ltaWxhcml0eSBpbmRleCA5OSUNCj4gcmVuYW1lIGZyb20gaHcv
bWlzYy9hc3BlZWRfaTNjLmMgcmVuYW1lIHRvIGh3L2kzYy9hc3BlZWRfaTNjLmMgaW5kZXgNCj4g
M2JlZjFjODRkZC4uZTU2ODIyZjkyOCAxMDA2NDQNCj4gLS0tIGEvaHcvbWlzYy9hc3BlZWRfaTNj
LmMNCj4gKysrIGIvaHcvaTNjL2FzcGVlZF9pM2MuYw0KPiBAQCAtMTAsNyArMTAsNyBAQA0KPiAg
I2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4gICNpbmNsdWRlICJxZW11L2xvZy5oIg0KPiAgI2lu
Y2x1ZGUgInFlbXUvZXJyb3ItcmVwb3J0LmgiDQo+IC0jaW5jbHVkZSAiaHcvbWlzYy9hc3BlZWRf
aTNjLmgiDQo+ICsjaW5jbHVkZSAiaHcvaTNjL2FzcGVlZF9pM2MuaCINCj4gICNpbmNsdWRlICJo
dy9yZWdpc3RlcmZpZWxkcy5oIg0KPiAgI2luY2x1ZGUgImh3L3FkZXYtcHJvcGVydGllcy5oIg0K
PiAgI2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCj4gZGlmZiAtLWdpdCBhL2h3L2kzYy9tZXNvbi5i
dWlsZCBiL2h3L2kzYy9tZXNvbi5idWlsZCBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAw
MDAwMDAwMDAwLi5lYmYyMDMyNWNiDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvaHcvaTNjL21l
c29uLmJ1aWxkDQo+IEBAIC0wLDAgKzEsMyBAQA0KPiAraTNjX3NzID0gc3Muc291cmNlX3NldCgp
DQo+ICtpM2Nfc3MuYWRkKHdoZW46ICdDT05GSUdfQVNQRUVEX1NPQycsIGlmX3RydWU6IGZpbGVz
KCdhc3BlZWRfaTNjLmMnKSkNCj4gK3N5c3RlbV9zcy5hZGRfYWxsKHdoZW46ICdDT05GSUdfSTND
JywgaWZfdHJ1ZTogaTNjX3NzKQ0KPiBkaWZmIC0tZ2l0IGEvaHcvaTNjL3RyYWNlLWV2ZW50cyBi
L2h3L2kzYy90cmFjZS1ldmVudHMgbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAw
MDAwMC4uM2VhZDg0ZWI0NQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2h3L2kzYy90cmFjZS1l
dmVudHMNCj4gQEAgLTAsMCArMSw3IEBADQo+ICsjIFNlZSBkb2NzL2RldmVsL3RyYWNpbmcucnN0
IGZvciBzeW50YXggZG9jdW1lbnRhdGlvbi4NCj4gKw0KPiArIyBhc3BlZWRfaTNjLmMNCj4gK2Fz
cGVlZF9pM2NfcmVhZCh1aW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGRhdGEpICJJM0MgcmVhZDog
b2Zmc2V0IDB4JSINCj4gK1BSSXg2NCAiIGRhdGEgMHglIiBQUkl4NjQgYXNwZWVkX2kzY193cml0
ZSh1aW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90DQo+ICtkYXRhKSAiSTNDIHdyaXRlOiBvZmZzZXQg
MHglIiBQUkl4NjQgIiBkYXRhIDB4JSIgUFJJeDY0DQo+ICthc3BlZWRfaTNjX2RldmljZV9yZWFk
KHVpbnQzMl90IGRldmljZWlkLCB1aW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90DQo+ICtkYXRhKSAi
STNDIERldlsldV0gcmVhZDogb2Zmc2V0IDB4JSIgUFJJeDY0ICIgZGF0YSAweCUiIFBSSXg2NA0K
PiArYXNwZWVkX2kzY19kZXZpY2Vfd3JpdGUodWludDMyX3QgZGV2aWNlaWQsIHVpbnQ2NF90IG9m
ZnNldCwgdWludDY0X3QNCj4gK2RhdGEpICJJM0MgRGV2WyV1XSB3cml0ZTogb2Zmc2V0IDB4JSIg
UFJJeDY0ICIgZGF0YSAweCUiIFBSSXg2NA0KPiBkaWZmIC0tZ2l0IGEvaHcvaTNjL3RyYWNlLmgg
Yi9ody9pM2MvdHJhY2UuaCBuZXcgZmlsZSBtb2RlIDEwMDY0NCBpbmRleA0KPiAwMDAwMDAwMDAw
Li4xZTBjNGVhZGYwDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvaHcvaTNjL3RyYWNlLmgNCj4g
QEAgLTAsMCArMSwyIEBADQo+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1v
ci1sYXRlciAqLyAjaW5jbHVkZQ0KPiArInRyYWNlL3RyYWNlLWh3X2kzYy5oIg0KPiBkaWZmIC0t
Z2l0IGEvaHcvbWVzb24uYnVpbGQgYi9ody9tZXNvbi5idWlsZCBpbmRleCBiOTFmNzYxZmUwLi4z
MTc4NmYwM2QwDQo+IDEwMDY0NA0KPiAtLS0gYS9ody9tZXNvbi5idWlsZA0KPiArKysgYi9ody9t
ZXNvbi5idWlsZA0KPiBAQCAtMTIsNiArMTIsNyBAQCBzdWJkaXIoJ2RtYScpDQo+ICBzdWJkaXIo
J2dwaW8nKQ0KPiAgc3ViZGlyKCdoeXBlcnYnKQ0KPiAgc3ViZGlyKCdpMmMnKQ0KPiArc3ViZGly
KCdpM2MnKQ0KPiAgc3ViZGlyKCdpZGUnKQ0KPiAgc3ViZGlyKCdpbnB1dCcpDQo+ICBzdWJkaXIo
J2ludGMnKQ0KPiBkaWZmIC0tZ2l0IGEvaHcvbWlzYy9tZXNvbi5idWlsZCBiL2h3L21pc2MvbWVz
b24uYnVpbGQgaW5kZXgNCj4gNmQ0N2RlNDgyYy4uNGE0MTcxNjYyNSAxMDA2NDQNCj4gLS0tIGEv
aHcvbWlzYy9tZXNvbi5idWlsZA0KPiArKysgYi9ody9taXNjL21lc29uLmJ1aWxkDQo+IEBAIC0x
MzAsNyArMTMwLDYgQEAgc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX1BWUEFOSUNfTU1JTycs
DQo+IGlmX3RydWU6IGZpbGVzKCdwdnBhbmljLW1taW8uYycpKQ0KPiAgc3lzdGVtX3NzLmFkZCh3
aGVuOiAnQ09ORklHX0FVWCcsIGlmX3RydWU6IGZpbGVzKCdhdXhidXMuYycpKQ0KPiAgc3lzdGVt
X3NzLmFkZCh3aGVuOiAnQ09ORklHX0FTUEVFRF9TT0MnLCBpZl90cnVlOiBmaWxlcygNCj4gICAg
J2FzcGVlZF9oYWNlLmMnLA0KPiAtICAnYXNwZWVkX2kzYy5jJywNCj4gICAgJ2FzcGVlZF9scGMu
YycsDQo+ICAgICdhc3BlZWRfc2N1LmMnLA0KPiAgICAnYXNwZWVkX3NiYy5jJywNCj4gZGlmZiAt
LWdpdCBhL2h3L21pc2MvdHJhY2UtZXZlbnRzIGIvaHcvbWlzYy90cmFjZS1ldmVudHMgaW5kZXgN
Cj4gZTNmNjRjMGZmNi4uZjcwNDU5YjNiNyAxMDA2NDQNCj4gLS0tIGEvaHcvbWlzYy90cmFjZS1l
dmVudHMNCj4gKysrIGIvaHcvbWlzYy90cmFjZS1ldmVudHMNCj4gQEAgLTI4NywxMiArMjg3LDYg
QEAgYXJtc3NlX21odV93cml0ZSh1aW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGRhdGEsDQo+IHVu
c2lnbmVkIHNpemUpICJTU0UtMjAwIE1IVSB3cmkgICMgYXNwZWVkX3hkbWEuYw0KPiBhc3BlZWRf
eGRtYV93cml0ZSh1aW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGRhdGEpICJYRE1BIHdyaXRlOiBv
ZmZzZXQgMHglIg0KPiBQUkl4NjQgIiBkYXRhIDB4JSIgUFJJeDY0DQo+IA0KPiAtIyBhc3BlZWRf
aTNjLmMNCj4gLWFzcGVlZF9pM2NfcmVhZCh1aW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGRhdGEp
ICJJM0MgcmVhZDogb2Zmc2V0IDB4JSIgUFJJeDY0DQo+ICIgZGF0YSAweCUiIFBSSXg2NCAtYXNw
ZWVkX2kzY193cml0ZSh1aW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGRhdGEpICJJM0MNCj4gd3Jp
dGU6IG9mZnNldCAweCUiIFBSSXg2NCAiIGRhdGEgMHglIiBQUkl4NjQNCj4gLWFzcGVlZF9pM2Nf
ZGV2aWNlX3JlYWQodWludDMyX3QgZGV2aWNlaWQsIHVpbnQ2NF90IG9mZnNldCwgdWludDY0X3Qg
ZGF0YSkNCj4gIkkzQyBEZXZbJXVdIHJlYWQ6IG9mZnNldCAweCUiIFBSSXg2NCAiIGRhdGEgMHgl
IiBQUkl4NjQNCj4gLWFzcGVlZF9pM2NfZGV2aWNlX3dyaXRlKHVpbnQzMl90IGRldmljZWlkLCB1
aW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGRhdGEpDQo+ICJJM0MgRGV2WyV1XSB3cml0ZTogb2Zm
c2V0IDB4JSIgUFJJeDY0ICIgZGF0YSAweCUiIFBSSXg2NA0KPiAtDQo+ICAjIGFzcGVlZF9zZG1j
LmMNCj4gIGFzcGVlZF9zZG1jX3dyaXRlKHVpbnQ2NF90IHJlZywgdWludDY0X3QgZGF0YSkgInJl
ZyBAMHglIiBQUkl4NjQgIiBkYXRhOg0KPiAweCUiIFBSSXg2NCAgYXNwZWVkX3NkbWNfcmVhZCh1
aW50NjRfdCByZWcsIHVpbnQ2NF90IGRhdGEpICJyZWcgQDB4JSINCj4gUFJJeDY0ICIgZGF0YTog
MHglIiBQUkl4NjQgZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaA0KPiBi
L2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCBpbmRleCAyMTdlZjBlYWZkLi4wNzI2NWYyNmNm
IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L2FybS9hc3BlZWRfc29jLmgNCj4gKysrIGIvaW5j
bHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oDQo+IEBAIC0yMyw3ICsyMyw3IEBADQo+ICAjaW5jbHVk
ZSAiaHcvdGltZXIvYXNwZWVkX3RpbWVyLmgiDQo+ICAjaW5jbHVkZSAiaHcvcnRjL2FzcGVlZF9y
dGMuaCINCj4gICNpbmNsdWRlICJody9pMmMvYXNwZWVkX2kyYy5oIg0KPiAtI2luY2x1ZGUgImh3
L21pc2MvYXNwZWVkX2kzYy5oIg0KPiArI2luY2x1ZGUgImh3L2kzYy9hc3BlZWRfaTNjLmgiDQo+
ICAjaW5jbHVkZSAiaHcvc3NpL2FzcGVlZF9zbWMuaCINCj4gICNpbmNsdWRlICJody9taXNjL2Fz
cGVlZF9oYWNlLmgiDQo+ICAjaW5jbHVkZSAiaHcvbWlzYy9hc3BlZWRfc2JjLmgiDQo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2h3L21pc2MvYXNwZWVkX2kzYy5oIGIvaW5jbHVkZS9ody9pM2MvYXNw
ZWVkX2kzYy5oDQo+IHNpbWlsYXJpdHkgaW5kZXggMTAwJSByZW5hbWUgZnJvbSBpbmNsdWRlL2h3
L21pc2MvYXNwZWVkX2kzYy5oIHJlbmFtZSB0bw0KPiBpbmNsdWRlL2h3L2kzYy9hc3BlZWRfaTNj
LmggZGlmZiAtLWdpdCBhL21lc29uLmJ1aWxkIGIvbWVzb24uYnVpbGQgaW5kZXgNCj4gMzQ3Mjlj
MmEzZC4uMTg2ZWZmYjg0ZiAxMDA2NDQNCj4gLS0tIGEvbWVzb24uYnVpbGQNCj4gKysrIGIvbWVz
b24uYnVpbGQNCj4gQEAgLTM2NTEsNiArMzY1MSw3IEBAIGlmIGhhdmVfc3lzdGVtDQo+ICAgICAg
J2h3L2ZzaScsDQo+ICAgICAgJ2h3L2h5cGVydicsDQo+ICAgICAgJ2h3L2kyYycsDQo+ICsgICAg
J2h3L2kzYycsDQo+ICAgICAgJ2h3L2kzODYnLA0KPiAgICAgICdody9pMzg2L3hlbicsDQo+ICAg
ICAgJ2h3L2kzODYva3ZtJywNCj4gLS0NCj4gMi41MC4wLnJjMS41OTEuZzljOTVmMTdmNjQtZ29v
Zw0KDQpSZXZpZXdlZC1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQoN
ClRoYW5rcywNCkphbWluDQoNCg0KDQo=

