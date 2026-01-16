Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30957D4A5E8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgfJJ-0005Nb-LB; Fri, 16 Jan 2026 03:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vgfJI-0005NN-4v
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:36:00 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vgfJE-0003tS-Pp
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:35:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5MR7DkqlBzt1MK8DIW6bdxBvMpdDt8rRR0mIBfMrGFW1wapOQGdsdtEiASrxr4GTDioQwhlRgmtnPwJqnJyML3KGZf8uR38b5WwyENcAXRitF5t7cxbhdjIUAtSFtvzRbDDdy24qExbj+hlW4CoOTOJNxXOgwi52CQy9rCeb4qLtjP2xHDAQZQQyoi3ILb1UdJH0c9P4PhhaA6xc42WHJma0cV+/jQcQQhi0UdemZFy+TKVpONfUtF5ClxtlrsNYSK59AjoAFnAwtZjdg9VhINdIrrmMRqU21XoigpPTEc867lou751H7OJIXEnTmCdah2wIanCgIgCX3cDw2BrSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9/ztXuGDndmABu5zU05a8QIaxsEIbmxxPcN1fjxwhQ=;
 b=KvnM4518brVa5XTu0z5+UZX3Tkln3ZqBt5bjJMSaLcT74ADIHDBZd6qabZJeWTcnmpA+H4x0iFovjXVoGwTTOTyQscDITaFOT/Uq71I4weTCa8xiepuipwbhuz3olEMznogo1ihmPuO4bV3ZplxwRFoqMHIpZ2RMT3QFr1epDCsfbjkgy6ojHeH0J630w3AN5Tf5hgs/XKK32kgvjA44jaN22k7oJWmgRrEk6Lw+JuvF3ycoKxqfcYHB0sD+tswYwzbv38itKa09Z2RZROp0yrqghzcF5SDb2gJZVUzb0DglUujCl9DU6is43l392fHTXNtaQ3J5j4+DaYSh3vCizQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9/ztXuGDndmABu5zU05a8QIaxsEIbmxxPcN1fjxwhQ=;
 b=LpRhho1P/yQXX5tKX+X+TrZGlts8KJ/sR5h5bmkGQwQrOach3GbEDQ+mtQIIP2dFkY2S3fNDGGjXa5m8pnmY6uWjM7xbutP10S8vIkcz+twALiR4rLJDLT707jPxaNeuR02Lnzi2AGyDP1RwytuQmtvp8jS+Ox/L5qgOBvAZXitPA/gCR8Agx6JStX2ZsloxznybXkTIG6pbHvnMTG7n1GEtuQEaP94HYDTKZdJLrrRqlVftVWRhqTYvO1aAiwjw8T0NQ6y6Je0BBQHB/ktSJCkySPUx28BVxrs10n/9Zd5zcSlXmQ8hYUff8BQhK9pl+POb6F2khKu4h86UZbIJLA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SG2PR06MB5108.apcprd06.prod.outlook.com (2603:1096:4:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 08:35:48 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 08:35:48 +0000
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
Subject: RE: [PULL 0/3] Update vbootrom image to commit 1c8e9510b22c
Thread-Topic: [PULL 0/3] Update vbootrom image to commit 1c8e9510b22c
Thread-Index: AQHchrn9D+vfYwM4mk6SyACbYX4WXrVUbUgAgAAK3gA=
Date: Fri, 16 Jan 2026 08:35:48 +0000
Message-ID: <TYPPR06MB82066CBB500DE20B4DA7C0FFFC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260116073024.3485812-1-jamin_lin@aspeedtech.com>
 <0cb553bd-793d-400d-9856-ffdbada35682@redhat.com>
In-Reply-To: <0cb553bd-793d-400d-9856-ffdbada35682@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SG2PR06MB5108:EE_
x-ms-office365-filtering-correlation-id: 5f8926dd-550e-4d94-a326-08de54da3fc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?aEJTKzAvamU0aU1JZVJPYU0xUDJnbkNLdXUzeTBuS1U4RS9sczlBNks2YjlZ?=
 =?utf-8?B?RC9jbllQNWpkQnUyNDdkVzJ6Wm1ONHU3dExZVmtISHYzcVM1TmYxS1ZLdTU4?=
 =?utf-8?B?RVhTTjVZcXVKM2QwclA3SDNoZWhUWEZBclEvZ1pmQXd6cy9kN0VheStwdTdI?=
 =?utf-8?B?SUZNM3NvOWt4SFEwazVjUUhuMWJRSnFsRmYyK1BRTmR4dUIwUlJEaXpTbVJl?=
 =?utf-8?B?Q2NuNlEvdnB6RGtQKzMyK2pZOFVHUXVQdmNEV1FPcjh1SjhFdEhjQksxc2dF?=
 =?utf-8?B?S2ZyaEdwODBQcVBkU3NnRng0QmtiNDVuV0pHNlQxL1E5MC9sNFNnRHBZWWNy?=
 =?utf-8?B?NXVWeGU1NGs3ekJ2YXA3QW96R3BQYlRHNGgzalRJR01NSEQ4MWcxQ0NQRkR5?=
 =?utf-8?B?MEVreWtPMTZOSmtSWXY3VUNQR01SWWVtSVozN3RUSDZsdTQ1RVh3d0tLSTY2?=
 =?utf-8?B?ZmlJWERKd1RyOW1kL3lnK2NJaWFjTlhIOXJLUlpaa2U4SXlmL3BFRHl5WHFv?=
 =?utf-8?B?ZkFrbE9EQXVvSU82NEFYcFVaelRVd1VJalpYSngyaEltUkdXdUx5cytLbG9Y?=
 =?utf-8?B?eTdGMHdMK3hJKytXTDFSK1Bua0ZybFdoQlFlSVZHS3VVenBZLzJvZlN3ZkdO?=
 =?utf-8?B?UHVBRzdjWCtUK3VYQkd6Y0tHNVNYSmlvdjlIY3BZZWdkVnlNMDE4cUpBMWZy?=
 =?utf-8?B?ZDIwSmJScnNlMk4rSjJXSnRLM1Q2SGNYQmNKSy9xRG91RlZyOU4zVUNqcDk4?=
 =?utf-8?B?T1pncmJ0WVRSaTU1em90SGRzekJEb1NCZEd3ZG9rVXA4aTNWZm5XS21YTEtM?=
 =?utf-8?B?Qm9hRzlYQ0dtQXdMZDFTbFBIbVB3dnhpRlZ6N1RZQkMxSzhic295SEQyUGFq?=
 =?utf-8?B?RDVwbjBtdHJ6cE9hTi9FU2J3WWxPeTlWM1JUUVdKUEVXMVdKd1VoNkRBQWo5?=
 =?utf-8?B?alZ1QkV5NjJxbnZDS0M4M0c2ZmU0aUhqOUtxZ1NHWDhVbHpMdElMYmM5SWVv?=
 =?utf-8?B?bXZSVkFlbnJOMFJjYTJkeTh4VFRLbmtmWGxLam9sUTFQS1I2VGp1dzB0UzZK?=
 =?utf-8?B?N3UySEE5OWFVTnR0aDFHTXI2cnNXTFdpeXBNNjJTRWRKc3E5VTVXL1NSeElw?=
 =?utf-8?B?aWdXTForclRrSzQ2cFZGYkZSdnZmbEVEMmw2WDBEZG5zSGpnV0xtTXI4Z2VC?=
 =?utf-8?B?MHRUSHNjYndYSmRSWGpuKzN2Z1F2OWJwMVFaM25wN3lZR1FzajN5MW5LblM1?=
 =?utf-8?B?RnY5QlZjMTViZW9uSE1MYUVqbDBnaTFjY1RuY3VsVmlpTlFCcGtleExiTWJ4?=
 =?utf-8?B?Z24yUUlBS0lDNlEvdFROSFFydEo3OXFWem44YjFPd0pJRXNBR0ZqMTB2WGE5?=
 =?utf-8?B?MkFzQnlGT25tYXZJekxhTUd6b3dMdGNnRDhLUDMwZzcrb1BodC9lYU9RZkZV?=
 =?utf-8?B?c2JhY1lHcFdtOFp2YVU3NmRsY01BRzN5VXU2ZUdabE8zVndXblJpUFJTWjZj?=
 =?utf-8?B?ck9neFJtN2pyN1JDTXFNOWhQVGZnMXcwdEZnUWwvNis5ZmNpWWxRRXFpRjJ1?=
 =?utf-8?B?a2tkMlAyZTN0bFgrcU45amlReE1XZkFhTGpNRFphbHBQaW5ldDZYNFBmYzll?=
 =?utf-8?B?bFZsdVNJMHlPWEY0STZYSzN3NjNNK2FLVWtuZ0pMTi9Md3VLZ3c3aldOM1ll?=
 =?utf-8?B?aUdQd2k2VHlxUktQbVZSRE5SWDNjcE1tVDBrQ1FFTVJ2eGJXTmlxeTNhS2g4?=
 =?utf-8?B?KzBQU0FkengzdVZlS0Vncm5LYlBPRzVwMmxwcUdhRVV3aEVYL2tWbzZVVU5z?=
 =?utf-8?B?Z2xBTE9qWWI5Q2JtT0t4ekNvTnNBaVpRTGFENFVWZjFJTE5QWnk1cWNDczdQ?=
 =?utf-8?B?TExMMSs5U0xLZUg5UC9tSDRnaTNqQ0pxREUrVERmdEZnQktwYjRSUkRKeUhx?=
 =?utf-8?B?SklPamxVZHJwZGZLb3RuL1ZJMXUxb0lENm9MUHN0aHNBWXZGeDVWTEJLUHE5?=
 =?utf-8?B?c1JCb1FaNGY3SFYvZFR0dGMySXFCZnBvaWdPRXRYTkxQQkZGZWxFTnBjUURy?=
 =?utf-8?B?aUVKR25wUS9wcFl2KzR3MFNNN3hJdXliYmxLUTNvZzZMcndEM0oxc2dZZlJv?=
 =?utf-8?B?ZitKUk9QOWVadXQyUzJ1aXZKaGNXTi95MHBaNGN2VDZoVlRxaStRVkd4azFl?=
 =?utf-8?Q?ZCKLa0JZPR4nGrugKuvMmMs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3FtWG5lZll5Y3VqZWhKYjR1L2tzOVBGZWRkRVBDc3FDdUpZMFJob1NqMzVt?=
 =?utf-8?B?bTBIN3pRRXBZdjQ2ZnRjV1pXa041SFBsdFdTSnEwSVFDN0s3Rm9SU2puNzgy?=
 =?utf-8?B?MHZmK1BwTkZlWnpaUUFWNEVEN2c4K1J3bHNYNFZnY25KWTZtT0FlQStYYk91?=
 =?utf-8?B?c3N2RTk0R1c1ZTFocmx4T1g5TWlJd1FVbldrVGRJU1lpMTRNdjVhVmp1dkFT?=
 =?utf-8?B?cEJBUDZSUmNyTkE5UGM0ck9pU0NMK1FXRVNvMXVpNUxZTnBaMTlubVBFWEdF?=
 =?utf-8?B?Yyt5K2o1SEtXbkhQcngzMGNsYVVRN3FsZ3l1TTRoRjlmK05ZckwrU0hPWmk3?=
 =?utf-8?B?QUtaWmJqWkZTcktQRXEyUTR4bXlKNTBZUkpBQVZKWDB1bjNmYmZlYW9Yd1Vh?=
 =?utf-8?B?WXRnMTVWWVljalY0a3UreGt6L0dncTFORCtuM0dLTUIvZmV0OHJhUHg2VDFW?=
 =?utf-8?B?LzhSRytNN25rK0R5UjBWWnMvN2JJOStMdFMyMkE0ejlSQURpVFU1VlNYaG85?=
 =?utf-8?B?bEo1ZHp0Y3FyTzVlUGNIOGVWUENQRTRaVCtjNzZzMjlsMmNPRXhkaUJyazUz?=
 =?utf-8?B?bHVLMmdTdEhiQ2I2TURFREF4Q0c3cE1oTk81ZGRXdjM4aDFBeUl1dS9qcVhH?=
 =?utf-8?B?dWpUSkxrSS9NSjZZWndWQmFaN01Kcm5SSTNlN2F4ZDRCUEhaU1RMZEcrK053?=
 =?utf-8?B?VFIweE4yVUtrUlUyTDRRT09CTEpLL0ZZZytGT0t2eVJQb0JTNXYwVzdYS0Jn?=
 =?utf-8?B?MEhubkRSNXBwMWMwSEVUREF6VzFYTEF4UVNFSitnYmN3Tk1vdCtZSTU1bTR2?=
 =?utf-8?B?N2lwbTZRT0E4aEJuNmlsbllTNDljdHlHMUwzb21ud0RPZC9hZXltQi9GeGdO?=
 =?utf-8?B?bjh6ZWx3dlpHZktXT1N5b3pvM0hSanRDRFNEWW1TQm5PdjBsZE0zWVN0QWJ0?=
 =?utf-8?B?dlBNRGdiL2VSZzk3MkZlWG45NW1RdjVBRkdOK1NDQktGTVYwN3NHNHBsb2Fl?=
 =?utf-8?B?V3JNeUIza0dUQjZNczF4M0pZUjY4UGw4c3JwVFNBd1l6eFZ1MW0vV1ExbUVj?=
 =?utf-8?B?dVUrWkZ3VTdwVGx3eXNwNDZiUjhkSkFPZjlONlBUQndUd3hqU0ZxNTZyZFZi?=
 =?utf-8?B?aWtkRGxaUUN6V0dWNVVSWW5kY3Foekx6MXlJSXlMUk96UURudGtJMjRYY1h2?=
 =?utf-8?B?Q1lXeGxDK1RyTlZnYlg5YU9jaWpRb3piN1A0bC8wUTZCUkduamdxckF6VE9G?=
 =?utf-8?B?eVhzUlkrdFR4bHFTUEZ5M3MxUjB4ZXpxbGh6VmdrazBhT1lwcEpCUnVpeE13?=
 =?utf-8?B?YkJwbitZNmpFQ2xWK1dKNkhwWnpZL1BSWWlRM2dZMEZlUWNnaXFwYTF0cTVE?=
 =?utf-8?B?dFdPN2hzVGhTM05KRXkxYW15ZWQrbVZ3ZVI0TDJxL05SMmlyeEhDRmpTY21O?=
 =?utf-8?B?SGR5NUdPVjcrZGFjeEkySkhycHMrZkVsWDlBK1QwQXRpcWhYeGttSmNVUFRv?=
 =?utf-8?B?TTlhTnRGNGd6RmVoenV3Y0J0eEQ2N1pXWjgrY245eDV4ck1RbXA0aldiZ3lj?=
 =?utf-8?B?dy90U2E0SjZmT3VyTEp2TUhkeFB2MWlNZDhTMGJucUVYZ2VFekFNWUs4RkNN?=
 =?utf-8?B?WFAyVmQ1Y1FjVnhQK3YzbjRvalcxcFFzQXNmOElBdE1MWnhmbmw1MWlRWEdh?=
 =?utf-8?B?QTgvUzZDR2xWUlZOUk9hYzZvOGRsVWNKMG5rZEVNWStlU1YzWXZVbTdrdlN3?=
 =?utf-8?B?NE11RjladVNMN3BlM2ZhY3RPZm1BdVphekJKQUVHek5vRFpiTWlOcklOZnM0?=
 =?utf-8?B?RWtlNHRrMWx1cnZxZmdFYU0wVzg4bmlBandKT1RrRVJHSk5LMVArTnlYbVM2?=
 =?utf-8?B?MXltbnRYYXQ3dVJRbk9tNWFZSWpzdVNqV2VuaVZ0N2phUE5iUzg0bzJqMll6?=
 =?utf-8?B?QWdUR0ZONnZWL2dnNS95T3lUVkVWTFgyU0t0U2VQa1RLSjkrK1I1Ykt0bitV?=
 =?utf-8?B?T2RnNU9ZZVJvMzBCS0pKYmV2Z0ZEdmVtbitZaHBXZGNZZTdCbjVnbVYwZ1c0?=
 =?utf-8?B?b0YvRDEyVFBON2ZyaW5sdFB0UG8zNFgvRm9qTGQ1Nzc4SVc5VVN1UzRxSG9m?=
 =?utf-8?B?MmpmaFo4eDhNamR2YXFFWUlvSk5QalkreUZiM3lGcng4eVR0YjhyTzZDTGxH?=
 =?utf-8?B?b0g4Y0sybGhmWTRsbzdHWVR1cWNrQXlOSlZ5b2czemVWczZZV3BiWHlMVWJm?=
 =?utf-8?B?amlCNmZwZWJSazIrNzF5UUJHNm13N2ZIUHBtcG1mSVRBMWVsUVVRdnBFSzVm?=
 =?utf-8?B?WnE4TW1RTFRtWXB4TUxxeHlUWXR6bXNNZ0MycGUxcFRwWEFVZ1pBQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8926dd-550e-4d94-a326-08de54da3fc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 08:35:48.2360 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2V67O1eF+R6Hf5ZL/yITKZ3842dmoQWFNXzUA9mq/LdEUkORu3zvawEUZOr8mFiVGKdyT+PvwKizZ5baCjEMpJIg0nkuCttvh7HcgvQXIes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5108
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUFVMTCAwLzNdIFVwZGF0ZSB2Ym9vdHJvbSBp
bWFnZSB0byBjb21taXQgMWM4ZTk1MTBiMjJjDQo+IA0KPiBPbiAxLzE2LzI2IDA4OjMwLCBKYW1p
biBMaW4gd3JvdGU6DQo+ID4gVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdA0KPiBj
MWM1OGNlZTE2MzgwZjgxZjg4ZmJkZTZiMTJmMjQ3YjM3NjgzOWUyOg0KPiA+DQo+ID4gICAgTWVy
Z2UgdGFnICdwdWxsLXRhcmdldC1hcm0tMjAyNjAxMTUnIG9mDQo+IGh0dHBzOi8vZ2l0bGFiLmNv
bS9wbTIxNS9xZW11IGludG8gc3RhZ2luZyAoMjAyNi0wMS0xNiAwOTozMzoyMCArMTEwMCkNCj4g
Pg0KPiA+IGFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KPiA+DQo+ID4g
ICAgaHR0cHM6Ly9naXRodWIuY29tL2phbWluLWFzcGVlZC9xZW11LmdpdA0KPiB0YWdzL3B1bGwt
dmJvb3Ryb20tMjAyNjAxMTYNCj4gPg0KPiA+IGZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0
bw0KPiAxMDcyNTNkYjU4ODZlYzljMDE3M2ZmZGNiMTY3MWE1MTY5NWEyMGQ1Og0KPiA+DQo+ID4g
ICAgcGMtYmlvczogVXBkYXRlIHZib290cm9tIGltYWdlIHRvIGNvbW1pdCAxYzhlOTUxMGIyMmMg
KDIwMjYtMDEtMTYNCj4gMTU6MDk6NTMgKzA4MDApDQo+ID4NCj4gPiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gdmJv
b3Ryb20gdXBkYXRlIHB1bGwgcmVxdWVzdA0KPiA+DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+DQo+ID4gSmFt
aW4gTGluICgzKToNCj4gPiAgICBNQUlOVEFJTkVSUzogVXBkYXRlIEFTUEVFRCBlbnRyeQ0KPiA+
ICAgIHJvbXMvdmJvb3Ryb206IFVwZGF0ZSB0byBjb21taXQgMWM4ZTk1MTBiMjJjDQo+ID4gICAg
cGMtYmlvczogVXBkYXRlIHZib290cm9tIGltYWdlIHRvIGNvbW1pdCAxYzhlOTUxMGIyMmMNCj4g
Pg0KPiA+ICAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgIHwgICAyICsrDQo+ID4gICBwYy1i
aW9zL2FzdDI3eDBfYm9vdHJvbS5iaW4gfCBCaW4gMTY0MDggLT4gMjg1NjQgYnl0ZXMNCj4gPiAg
IHBjLWJpb3MvbnBjbTd4eF9ib290cm9tLmJpbiB8IEJpbiA2NzIgLT4gNzM2IGJ5dGVzDQo+ID4g
ICBwYy1iaW9zL25wY204eHhfYm9vdHJvbS5iaW4gfCBCaW4gNjcyIC0+IDY3MiBieXRlcw0KPiA+
ICAgcm9tcy92Ym9vdHJvbSAgICAgICAgICAgICAgIHwgICAyICstDQo+ID4gICA1IGZpbGVzIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+IA0KPiBGb3IgbmV4
dCB0aW1lLCB0aGUgc3ViamVjdCBzaG91bGQgYmU6DQo+IA0KPiAgICAgW1BVTEwgU1VCU1lTVEVN
IHZib290cm9tIDAveF0gLi4uDQo+IA0KDQoNClRoYW5rcyBmb3IgcmV2aWV3Lg0KUmVzZW5kIHYy
IGhlcmUsIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9xZW11LWRldmVsL3Bh
dGNoLzIwMjYwMTE2MDgyNDMxLjM2ODkwMzUtMS1qYW1pbl9saW5AYXNwZWVkdGVjaC5jb20vDQpU
aGFua3MtSmFtaW4NCg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KDQo=

