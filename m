Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB9FD4A609
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgera-0007lk-R8; Fri, 16 Jan 2026 03:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vgerJ-0007eg-OD
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:07:09 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vgerG-0005Za-60
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:07:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIhLvH/KmcL1zbTybLCTRpyJg1QGM6PL9VwvJVctFj2zYmTHWy15zUiC8NSbi9qMZ1GJvz+5EJ1TtuUL1LtJHtesYioev3tNoKED+m5Wg9+kgHifFuqFVAWm8jDtPZ7QtnCiv0YRNhFfbItash2JHqcopUps35613LyPnP8mNbTVCSAJjFFIS5WeeqeflWM+2MSNfZ5p14LTFELuDA+mej9lUy4PIS4NsCokfQYMR43glk0WkhjPlZTKepOYaTh7IZ+/sTDFW8cddK7AOwSHjaZp0H8qnMN875bw7O/kjH2nO9gLWxX2HAydJnb3cSI/M1bwNFeb3a09Lm3vTxd1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EJcBQRKEv4udLBaTGkZVrXOjgIgVx+eHnfwJjmiNfA=;
 b=Az9BTYfDQJxaaG3CSIYH1TLTJgroULFsMjkuIo0KtkYpRwkFV6MeLBAqBAppz2OVQIpW7cMVpOHiqPHD1NqqkyuSfyX3kEx3qEnJxL8EI2qQKdzL/M+cE/glWht4OLeeCRRddpMX+gATXIY5XbTVZ01yX90pUjFILgJo5cCAtak2rpXKHWHxeJ8CX6q/ozhXOA3dOm28ZKBFO68xjqpD7kHwyJHYXog1P/wVkrNxG8ATH3pIlMeg1kKm0+HmqXG1D1mmydVCHsuU31UCsFpbJj3nEE+GbXwgHKRI8DrCIvmO7b98MxdM76H9zdIsL7g1Mxb6v3M0qsvde886L/1iog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EJcBQRKEv4udLBaTGkZVrXOjgIgVx+eHnfwJjmiNfA=;
 b=KX8MZSbXbfgNniiO9AvgZvSS/B1MrsYlYGEs6JmJsW/iXmcDmGsy4NQv3BsZKsWamt66IQTUiWb5/Lc95IoNPsHeyOLm24mXzZgttdkNQe7BmY2MlQ/k2gcMygXzDU5J/UbKOq4vAOXWkX0k6FyRDf5Kg/13cxQUsaiihMCe3uL5scQ9nvZtIPVMDXmLpMxNHy42n2z1ttGqauK3goRHZzL//8jp+UUFUNgzpTH+fmFAgzXGISF/6t053xUU6OjavMeS0kYoZG19WMMBSV3yosOkEEQmOoJSMlaDMTM4yjN+2y6UqPOmqBf4FQ+KLTZchryC5r6U7qfqJSTyq0wBCw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by PUZPR06MB5852.apcprd06.prod.outlook.com (2603:1096:301:f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 08:06:55 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 08:06:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, Hao Wu
 <wuhaotsh@google.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, "komlodi@google.com"
 <komlodi@google.com>
Subject: RE: [PULL 1/3] MAINTAINERS: Update ASPEED entry
Thread-Topic: [PULL 1/3] MAINTAINERS: Update ASPEED entry
Thread-Index: AQHchrn9gjfMWj9UXkKOD2njLLo67bVUbeuAgAACRlA=
Date: Fri, 16 Jan 2026 08:06:55 +0000
Message-ID: <TYPPR06MB82066683127BC7E649CF3D6DFC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260116073024.3485812-1-jamin_lin@aspeedtech.com>
 <20260116073024.3485812-2-jamin_lin@aspeedtech.com>
 <b747f454-58f4-4f21-9e43-db3b7a43c1b5@redhat.com>
In-Reply-To: <b747f454-58f4-4f21-9e43-db3b7a43c1b5@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|PUZPR06MB5852:EE_
x-ms-office365-filtering-correlation-id: 2ed5cc80-da73-4094-1f6b-08de54d636ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?a003bkgyRTc5aXc5WHplZEZYMldRanVWbUMwNXpsMGdadU84MzY0b1FVT2tm?=
 =?utf-8?B?bFV5YUtacVR5MDBlYzNkaEpRcEZ3RjdVdk9yWTd1ZGJYTmFNbmtIbXhOWHQw?=
 =?utf-8?B?RFNTQ0J6Q1plZy90NWJMd3NCeGoveFUwMTh2MzJsbW1PZGJaY1RwZDFYbE9u?=
 =?utf-8?B?S2lZbnJ0WVZzdTJNUUV3eEM1Qyt4VDlaUkJXampPa2NOU2NOcDhzRnc4eThU?=
 =?utf-8?B?ZUpENFV0YVVCMUhUMGNUamtIVGtoVHZ2WGpxQWNZM08rQ0JIdk4wQys3N1NK?=
 =?utf-8?B?d0RwQW15azdIYUlLanZyMWhWMmJmcEpnVGZkQzZhTjI5MkZYNHV6QXJvVkd5?=
 =?utf-8?B?UElzTGFLNjhHbFhoK2p6T3VZSHlVcjU2a2FkSkNDcXUvWGd3ZlVzd0NCaGxo?=
 =?utf-8?B?RnZBYzMyeWI5cHhYOTdqcTB5NUdCUUVtRlA2SEVJTmFheFF2YThZQ0tYaERi?=
 =?utf-8?B?M0JKaENpbkIyckJyaUI0cCsrdjhkRjFLbTJyZFBpTmh3UVZKSnNBaUdHd2h6?=
 =?utf-8?B?dHpVMlg0NXVtaHpzTXp3ZjNaZ0YzczJncmdvZEdVTElkdlZFYzVoOGJWSDcr?=
 =?utf-8?B?clFVN0tpY0JVZy9mOGNNM0ZDdmpyckZKNTBvSkVsUjNtbWUrV1NuTXo3YlVH?=
 =?utf-8?B?Mkl2cDFJOGhvQSsyM2lMNzN6L0ViTmJXcE9sb2UxTzZEaXF5NDBXc281MUN1?=
 =?utf-8?B?VDNrWU1Tb3QxNys2TzhEVDRrUk11Znp2cDlYMTRVVW40K1NieCtFdlB0bytW?=
 =?utf-8?B?alA4ZFh5VUQ3SFR6ZnFoMkU3cFZnbDlWVEhoc2sxZHBGYi8wZzFzTTZVVVd3?=
 =?utf-8?B?MEp1cVFKa3hPVG00dU9veTlEa0ZlM1Q4Vm9aS3pnRHdFMmFZaXF2QlpFMTlC?=
 =?utf-8?B?Nk5lRWpxWndmQ1FUREVUeHNqTlRtZG53a2gwR3lVUXQ3U0gwUHM2MFdOUGFZ?=
 =?utf-8?B?Z2xzaUxxSWtUQ0hiWkdGVzJEUjJCZENzQ1B1RHhwQkdFb3kzMXZreEpmR2Vl?=
 =?utf-8?B?YnJTK0NTd012WEUzUHdaTUluSUlNN1dVUXVTYjdrd1pXYmtneE9hYjhRNWtS?=
 =?utf-8?B?Rnl1T3dWV3IvMkd6SVlOdURXTXhBSmcwRVlNSFhkSXdTSDZLNWZVcHVuUW5p?=
 =?utf-8?B?Q3VreE5PczN5STR3UVhlc1NzOWo4ZWZEbTQ2akhCYnlNMXE2R3pDUmZwRlpE?=
 =?utf-8?B?bGtDaFVUNWVxK2M0OEUxSmhXSFExRlVSRHFka2FWOHdPV2NRNGVua1RHaUY2?=
 =?utf-8?B?OWNtSlo4QWd4a3d6SWYxNkFlcm9FWU1QUFFIWWc5aE9nRFJWeWxPb0lNWnBW?=
 =?utf-8?B?U1kyWE9tWDdvTFRKVHpCMjZNVEhHaW93UTZHK004TnpwSGZpb2ZSYVE5cmw1?=
 =?utf-8?B?V0dqZ3FHQ2pmVW1iNVV1RGl4d0FUeWdVNlF2Sk5QWUt3a0s3YmNRdk91TVh4?=
 =?utf-8?B?VHFFbmhUUWxxZENJekZuamlzbExKamFScWZ3R3V6bCtRR1dQNzVhMlFnWmNU?=
 =?utf-8?B?OHdObS92elBNbHVyS2c2dnpZZUh1UC9sSE85ZUNIUlppREkyN3Rhd0tXczRn?=
 =?utf-8?B?ZXhacTBCZ0pVOFJsMDBaNXN1VkdpZ0RHbXBkbytyUVpoOFZTRXdUMXBHcVhO?=
 =?utf-8?B?QzRoWHNWL05mVXMxUTBJcTdIVURTcjNHdzI1R3R6N0x2OVhweDA3QjR4ZDdp?=
 =?utf-8?B?M0lHWWd4bzErQnhZVVdsaERuS1ZSY3VraTBLb3FWYmIxT3NUZXdGa2JwMGdV?=
 =?utf-8?B?N3dmd2xJa0srL1NkMVZzZDFPUkQwQ3JzL2xnUmRUa1ZDeDJMbHZ5ZFRyeHhK?=
 =?utf-8?B?b0xUNjlnM2NzbFFqeHZEeDkyd2o0SkR3WFpqMTVSM1ltNU9FUzNLRE5aYzdv?=
 =?utf-8?B?UWZZV0cxeEZzN1cvTjNJWHA5Sk1oS2xpMmhKUUh4WjB2Yjh1UG9LYWR2WGUy?=
 =?utf-8?B?bGVYaHgyT0FIbFNDZGRkdlRXeWJob2FneXZJTm5pdEJmWDBxQTgxMHo1NFpn?=
 =?utf-8?B?alF4WTRLNFlqWWI4alZENVVWV3hEN0hYbHUvQ1lvVFJheFNkZjcrN2pGVUZh?=
 =?utf-8?B?RVpKUG91R2NGSmpLc01VWUNKTW96MnViUjBHcm9pS040V3VRNldXTzhCS0JF?=
 =?utf-8?B?QkgzZkZKL2hFSHdqRjBFQ3VrYzloTVBXb2FuTElIc3VaT05VVGlvUTd2YUhC?=
 =?utf-8?Q?Qwxc+ISK9TuGEydE+q+1gVc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmlsNDR2TjlJSXdKSnd4L2R1VlBVQ2JnTjVlc0d1a2JrcC80NGc2YmVLeito?=
 =?utf-8?B?MW16VDl3TkFBYjJlMy92NUFxbUc1b3IrbWlUbTZqSVptcndkeEZlaGF6eENT?=
 =?utf-8?B?c3dveDB3SmJGRzM0M3M0SlFvank1bmFNZDFJR0x1M3N6TlR2cDU1TEVGYUF6?=
 =?utf-8?B?bURwWjNPOUUvS29FaG5NMGU1eXdWVHNkbEZmWnYwOFhud2RYWUcreUsvSjFo?=
 =?utf-8?B?WkhhbTBoclpXNWx1SitrSVFEenA4eGt3OU9NVFB0M0lVVzlhbUZaN0NwZFNX?=
 =?utf-8?B?K3ZrYk5nS0ZnRWI2N3BlMWtvR2Z0ejI4WGpJUmdWbU13RmMvSWE5WEhDK1B2?=
 =?utf-8?B?SlZHdXNOQjFMdTRhUTYxMGJUeUFNYjF5K0FnMDRNY2trTHlZaVNZUFRMbVdX?=
 =?utf-8?B?ZkJKSVFYdGpaYnQvbzBTV0h1Wnl1UW9QY2NOZG9SeG14cUlmeHh3c1VHVHdE?=
 =?utf-8?B?WWlOMWVrREpweUdBb0NuQkxKS1RpUXB2UUR0K3Y4dlAvVnNrUWVTQTd2eHFG?=
 =?utf-8?B?WVRYUHZFMnNVem1lYUFleFJmUVhENzR2QmxDWVk3RUNHUWovM2lkdTA4clNB?=
 =?utf-8?B?UXpDQkRoNFNVODlsdThUNy9lT3hvalZQNWZyRzVrYnY5ekFBRCtHTTlUQ2Y0?=
 =?utf-8?B?UDM2dGw2R0xpWGVSTjV2cjNBcTVlKytFcVhIdjBaWjVtM3JBM215VVl1Z1FZ?=
 =?utf-8?B?VW1XNHdTTnQvcFlQdU9WQW9rVkRBK09RQWRUMEJGVlBpa0NDYkFMQjk1RHFt?=
 =?utf-8?B?WlBWMGhpbHFxTElIQStETzV1UngrZmIxSTBoMC81SnU4K2xqdy81akdNeWRT?=
 =?utf-8?B?RG5wemJ5alJwN0p6SEdRcTZRMEJta2c1YXFlQWlBL0dkMTFEZVpjNE1yODRL?=
 =?utf-8?B?bnA3c0U1Ti9lSUNHVFVnN1pzcExkcGJUYnozTmxzU3h1c3V6N1NaalQ1WUVK?=
 =?utf-8?B?ZG5DTjF5bzczbGpIZnhpd3VqRDR5TjdjU3pSbW5BQ1pWaHc4dE0xRm9zYXBM?=
 =?utf-8?B?VFRQQkREUXFBQnIrYkZITkhQOUgwYjc2ald1RmNQVEYzb081T2hXczU3Z2lr?=
 =?utf-8?B?UmNxWDRXc3pjRDdJak40TGRacmdYZFhhaEM0aXpaWEM1UlY3aWt2UENvUVE5?=
 =?utf-8?B?VUs3SE5WUlhBaVUrZ093a2lUTFFodWFBUEc4MEo0WEt1TlZ1VFpPK0JYWkE1?=
 =?utf-8?B?Y2k1UjRleEpjcmd4UGV1M0Nmbm5talAvZE9nK21iMmVhVkg1Z1VlbWJsTDdK?=
 =?utf-8?B?bzFUVHVZUnprM2lWbkZ2WERXSUhyTzRxeHc1VVZ2bFZZODZ0L0JrOXVrZWQr?=
 =?utf-8?B?aDVQNUpvMGxtTzFyTWh3K2JUU0wzZHVHblhZMHN4TVZwV3ErbFhtSGE0ZXVM?=
 =?utf-8?B?OVFvbWU1U212WjBWREtGVzJNNThEa2ZPS3ZhYTZUYlRtc3E1RXJMVWV1czFx?=
 =?utf-8?B?WWJySXBXRGpPRkRUNDJDZzIySXliU1lGTHdyTkNHRDkweUl6c1FNa2JWN3VG?=
 =?utf-8?B?WDZ1TnRlcU9nZDBpdkN4TUNtY2lwaFhOMHZrdUdZR1dmUzUvZWpLNXI3N3lM?=
 =?utf-8?B?RDRtVDZhWUVSZC9qWHBkZmVNcEN6KzI0VTVZejV6UzJ2UFMzZVVqell6dnJW?=
 =?utf-8?B?UVowMGEyU3lDTlJ2ZXNvVjBCWWxkWFBPSFc2REZ6TFZsQ21ENkFqdndRUHhr?=
 =?utf-8?B?Y2dLVTZ2Wk9WdXdIdzQ2L2JQeENjV0lHNHhnYWZzNUFBcU9SY04rVmdEWGxB?=
 =?utf-8?B?Sm5PT2JxaXlQaldaYXBSSytpVXY5TGZST28xU2ZvVW9xSGVWVWVIR0pxdjJq?=
 =?utf-8?B?dEdDbGtsWGluQkJIT01CZVU3bDV4TlByNVlLTkZPL2gxb3BjQjNMeUJoYlZW?=
 =?utf-8?B?M0NBVmxDam1pdDZEcFY3T2pqeGFhUjMvb0pyTjZFdG82ZStDdjBXWGkwTmNI?=
 =?utf-8?B?QXZqd3gvck05M003ZjI0OTFMUDdHSW1GZkVXVFNQeTZUbTk1ZGxzdVphWHJU?=
 =?utf-8?B?enNoZ21jN0Z5ZHZ4bmJ3Vi9udjBwSjdvaXpCRzBjV1VkUHZtL0dTQjNzSEFJ?=
 =?utf-8?B?S0pPVllvemtvVXlJZGFmQzdtZExzUEoydXhMWXJzK2lRem83YXRDRHlsdWpK?=
 =?utf-8?B?azMvbWovblBZcStTbmMxaWwySU95Z3lhTnhJdUNLdE1vdUtSRkJIM3NNUnBB?=
 =?utf-8?B?ZUoybWpoRW9kdjVyaE00akhhR2VOZWF3Y2RnSnRHeDVYUmU3NXBycnhMVG4x?=
 =?utf-8?B?cVFNclVON0VnRnNoQ3dKYkdKdDZ4TThuU1dGMnRZdzdEbDYzYVRyK2U5M3M1?=
 =?utf-8?B?MzFrbTg5TkpPUXJVMkxJMFZ3UExFT1diK2VUODc4NU0yanppMkt3Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed5cc80-da73-4094-1f6b-08de54d636ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 08:06:55.2288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /nHwlFeNJ8uHyCYvmvToe0Cp33A6hPudysykvjoTJ/STaU/Rz8sTVZmvUu9W9/5Mp76LNrQWBklSIfJ5vCe3qmUd6wQDc+OAbmOAmdK27fI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5852
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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

PiBTdWJqZWN0OiBSZTogW1BVTEwgMS8zXSBNQUlOVEFJTkVSUzogVXBkYXRlIEFTUEVFRCBlbnRy
eQ0KPiANCj4gT24gMS8xNi8yNiAwODozMCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+
ICAgTUFJTlRBSU5FUlMgfCAyICsrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUyBpbmRl
eCA0ZGRiZmJhOWYwLi4yODA0NmI0NTdhDQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvTUFJTlRBSU5F
UlMNCj4gPiArKysgYi9NQUlOVEFJTkVSUw0KPiA+IEBAIC0xMjQ4LDExICsxMjQ4LDEzIEBAIEY6
IGh3L25ldC9mdGdtYWMxMDAuYw0KPiA+ICAgRjogaW5jbHVkZS9ody9uZXQvZnRnbWFjMTAwLmgN
Cj4gPiAgIEY6IGRvY3Mvc3lzdGVtL2FybS9hc3BlZWQucnN0DQo+ID4gICBGOiBkb2NzL3N5c3Rl
bS9hcm0vZmJ5MzUucnN0DQo+ID4gK0Y6IGRvY3Mvc3BlY3MvYXNwZWVkKg0KPiA+ICAgRjogdGVz
dHMvZnVuY3Rpb25hbC8qLyphc3BlZWQqDQo+ID4gICBGOiB0ZXN0cy8qLyphc3BlZWQqDQo+ID4g
ICBGOiB0ZXN0cy8qLyphc3QyNzAwKg0KPiA+ICAgRjogaHcvYXJtL2ZieTM1LmMNCj4gPiAgIEY6
IHBjLWJpb3MvYXN0Mjd4MF9ib290cm9tLmJpbg0KPiA+ICtGOiByb21zL3Zib290cm9tDQo+IA0K
PiByb21zL3Zib290cm9tIGlzIHVuZGVyICJOdXZvdG9uIE5QQ003eHgiIGFscmVhZHkuIEkgZ3Vl
c3MgaXQgaXMgZmluZSB0byBoYXZlDQo+IGR1cGxpY2F0ZWQgZW50cmllcy4gRGlkIHlvdSBjaGVj
ayB3aXRoIC4vc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCA/DQo+IA0KDQpJdCBhZGRzIGJvdGgg
QVNQRUVEIGFuZCBOUENNN3h4IHJldmlld2VycyBhbmQgbWFpbnRhaW5lcnMuDQoNCmphbWluX2xp
bkBhc3BlZWQtZncwMjp+L2NvbW1pdC9xZW11JCAuL3NjcmlwdHMvZ2V0X21haW50YWluZXIucGwg
Li8wMDAyLXBjLWJpb3MtVXBkYXRlLXZib290cm9tLWltYWdlLXRvLWNvbW1pdC0xYzhlOTUxMGIy
MmMucGF0Y2gNCmdldF9tYWludGFpbmVyLnBsOiBObyBtYWludGFpbmVycyBmb3VuZCwgcHJpbnRp
bmcgcmVjZW50IGNvbnRyaWJ1dG9ycy4NCmdldF9tYWludGFpbmVyLnBsOiBEbyBub3QgYmxpbmRs
eSBjYzogdGhlbSBvbiBwYXRjaGVzISAgVXNlIGNvbW1vbiBzZW5zZS4NCg0KUGV0ZXIgTWF5ZGVs
bCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPiAoY29tbWl0X3NpZ25lcjoyLzM9NjclKQ0KSmFt
aW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+IChjb21taXRfc2lnbmVyOjIvMz02NyUp
DQpOYWJpaCBFc3RlZmFuIDxuYWJpaGVzdGVmYW5AZ29vZ2xlLmNvbT4gKGNvbW1pdF9zaWduZXI6
MS8zPTMzJSkNCiJDw6lkcmljIExlIEdvYXRlciIgPGNsZ0ByZWRoYXQuY29tPiAoY29tbWl0X3Np
Z25lcjoxLzM9MzMlKQ0KTWljaGFlbCBUb2thcmV2IDxtanRAdGxzLm1zay5ydT4gKGNvbW1pdF9z
aWduZXI6MS8zPTMzJSkNCnFlbXUtZGV2ZWxAbm9uZ251Lm9yZyAob3BlbiBsaXN0OkFsbCBwYXRj
aGVzIENDIGhlcmUpDQoNClRoYW5rcy1KYW1pbg0KDQo+IFRoYW5rcywNCj4gDQo+IEMuDQoNCg==

