Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7BDD4A609
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgeS6-0007gJ-Ki; Fri, 16 Jan 2026 02:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vgeS4-0007ex-Be
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:41:00 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vgeS1-00083B-B4
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:41:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDqedCWCFsE9A7asI0HHWM1sy70CblveihC9+PfysZLuTjoCXQ/7B4STVOJn8ImWUyxrQ91px38fSt34ruTJHd+TIPWftn6S5AVq4woo0p+Gln14ahbtD/qAHQVnx092VaAFV1en0O6iBhYaRVc5V46xclSOOLXZ3Ni+YREn7TH6bzst7OyxIUjGuGGprgw1a7zg2GwtJ9rjXvdr5QHmnWSgVKTyLDj9dWu+3RkHj1jP9BnGGpE/QCwvJRGhymqeccrmvPsDoLRA03dND5rsxAmWQV0dp0rOgFNI+uTbzLZQH97upyx8SdJvGyO48Kr8zSgx9Ac3yqiUzH/S+h82yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=baNEdSyWE4as49SL8wOdSTKKQUmF1haoLfyqqlx2VgI=;
 b=PsfLrR5tspIiUGEorZ4KGfJareYWnGui7fvJegb1hAAbYl5VvNd2NUtbHSIfgoaF0+6jCiN3HCg0aCu2NSJ94b2/EvRf1HuWkNZmiWBpS68GZph/CBWVpNBChewhdcOvPclzcgFlGvxE8/cTY07+n+Kk+apvSKqVR0P3FcK2cssUr6tT/jBlIIBMvp7WlRDPkNdfZ0Jxt/zFTU4tJ813xPFpVrN3ykPwMYQpENgI1g1GTdZpBt6FdN9Yf5FhiBIWJ20zFaKyqyABnXMR4BkSFfQKaUVl7fB4QN3gh0LHX2mnaPumsH5jfFHNyzcPIGWHXrAnMKuzgFJeKTjZ3xij9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baNEdSyWE4as49SL8wOdSTKKQUmF1haoLfyqqlx2VgI=;
 b=n1xDMKg3Hd2zJ90tcIhkNZpb6rzo4iyXuikxL8Bw81ZyEcfEeph8NBvpjxbDcnGS6W6o/i3Um92wFGWGte3MT5qOCFyuOuNnuJdChmXPOL7Pcxd67jawjaxxY3ew0hmRat35mE0hJv9gURszXeLl3lreULL0TGFvd0CgZQZKaNoCXQHBOZzKyG4FuwsgiIpbSvF9gIInXsAEhr8uhivm9l0TSKa0dJamZiaETVmezolA7q/KZoZEoB2qZnWDUkJik2okVzBxu41rnanlodwjNxdjWxcjjocVQhjlpT2SGCENfO/AE0kkoK+wtNJBgufM7H6YbbzIoxcyFJUA8chXgQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI6PR06MB7148.apcprd06.prod.outlook.com (2603:1096:4:250::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 07:40:47 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 07:40:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Nabih Estefan
 <nabihestefan@google.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Troy Lee
 <troy_lee@aspeedtech.com>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "komlodi@google.com" <komlodi@google.com>, Kane Chen
 <kane_chen@aspeedtech.com>
Subject: RE: [PATCH v1 1/1] pc-bios: Update vbootrom image to commit
 1c8e9510b22c
Thread-Topic: [PATCH v1 1/1] pc-bios: Update vbootrom image to commit
 1c8e9510b22c
Thread-Index: AQHchcf4AeTU1f63gk6KDympXQdmeLVTadwAgAAAgQCAAJOH4IAAQriAgAAn6dA=
Date: Fri, 16 Jan 2026 07:40:47 +0000
Message-ID: <TYPPR06MB8206370E45E78812598BB1D4FC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260115023758.3600447-1-jamin_lin@aspeedtech.com>
 <20260115023758.3600447-2-jamin_lin@aspeedtech.com>
 <CA+QoejUkn14qq49A5RF5iVUCrcdBN077Ce0FZSw8sWAQ+vU3EA@mail.gmail.com>
 <157bdec0-64f9-43b8-b42c-cf29a34d083b@kaod.org>
 <TYPPR06MB820664D78B0B4F5A780822B8FC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <14e4bfb8-9458-4f75-a479-878ef8d286c0@kaod.org>
In-Reply-To: <14e4bfb8-9458-4f75-a479-878ef8d286c0@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI6PR06MB7148:EE_
x-ms-office365-filtering-correlation-id: 8af9dc3b-c566-4c4a-1c02-08de54d29036
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?Q0ZsL3N4cHNoM011eUdQUHlvR2xQTW9MTXliZE9tZ3BHN2xBTEVJODVpQnZa?=
 =?utf-8?B?c3RPMDc1N2pVTEdvdTBFVWJvZ3JnZnQxdkc3NkdYNUdTSmVEVm4wNHUwM2JB?=
 =?utf-8?B?cGZqYlRna3FKQzRtVy8weHRZVWViMnF3WUk3cTBSSWtvMkoxTTdOVnVhb21R?=
 =?utf-8?B?TnBxSG1GYkRhVHVYU1ZIL2txY1ErYlNhb2hYYitxbXJncVUzcEQ2b096c0pQ?=
 =?utf-8?B?QnZtQXBkZFVSa3o3V2Q2UGFtdnE2RTJWRHlvSXJBSHlTeGNJT0xWRHB0Y1A0?=
 =?utf-8?B?VURaU1BoU1R6alkwT0pWUlZaa3NZd1RJZzVhdFo4MFRPNmxENmZMTGF1MFR1?=
 =?utf-8?B?WW9Rd0NmMHVDcDZsRXJGakh2b3NFUGs4L3dqT21qUDU3cXBTUldjaDNjQW41?=
 =?utf-8?B?Sll1ZDR1SmpqQ0xvL3YwOUhJd01pMHE4S2RGVHFIR1VmcGwyR3dIeWhBODQz?=
 =?utf-8?B?WGM2TVVKRDJZWGNkY2RoUExjWEJGWHBnU0l5RUVRSUZ1bjlLTUFJbzByK01J?=
 =?utf-8?B?RTR1QmVzNitWUjJIR2M2TEFPb082QmRQUkdyb3Q5UW9WdktGYit1eEt4by9H?=
 =?utf-8?B?NHI0NjlobjdLOHh5LzN0c3RpaUJKY25zNm9ENW9yQldnKzhJSUk2WXlXVExY?=
 =?utf-8?B?dXJaUm1qYzVZV0N4M0RmQlF6TFJUVFhtSTViZ28wTW1FQ09GTVBuUnFOZ21I?=
 =?utf-8?B?SENFN0FrbS9HNXdsbncza1FvYUs0a3RrM3AxVEtQZmpUMUYrc3dEMkRkbU4r?=
 =?utf-8?B?Q1ZOa1JiZ21OQStkS3JJVkV5NmZGMXRDYkdtWlZTTE1SNjFUQnhhcFA5NjVx?=
 =?utf-8?B?ckNxSzJFQTgrdkZLYnVVYWtMZUZVM1Q0bzViZ0F3R0NGdlZMY01ra01LRWZ0?=
 =?utf-8?B?ZGZSUVdlVTROSThiQ3QzMmcwRHhlQUtrQUxkUUFMcEJrekw0MGhFT0RQS1BQ?=
 =?utf-8?B?NDBBYldKMytRdE80M3VzWGk3ZEJ6UkY0SUUvY1k2T0phS3hyTGN2OEdoS1Zs?=
 =?utf-8?B?dEZZOFIxbXhCWlByUmxIMXA3UzlyMnNZVGVnNmE2ZjNxamd0Z013UVRxZVNj?=
 =?utf-8?B?LzhFY1Bad3cvUWkxdEp1aHRWTTdCa1NkYnJwbkJodGwzendqaGRiZ3Z3a1Zt?=
 =?utf-8?B?QTVVYjZwd0IyVnBHWElCcE44NXFlaXpGYmg0U2tvNndPTE9Wbnkra3dqbHFZ?=
 =?utf-8?B?dVlna3E3SGF4MkxxMU5sSVJvNll3K3g0K1A4b21MN20rTUVtV0tUNTJtYSsx?=
 =?utf-8?B?MURzeElXaVpIZHhTUzJOTDRneDFLd1dUZisrN0NTMTZZUkZ1V201QUxoTmVo?=
 =?utf-8?B?RWVTbWdqYlJZYk55T3gralVkTjJmc1QvSlVvQUVBZzR1Z0QrN0NmdXJad042?=
 =?utf-8?B?NytCVStzMldLZVFpNm5yYituU2h6bUVnVUh6MFk5eVpwZTR2WDVxdmtMUjhl?=
 =?utf-8?B?QnZBTjlyRE8zSU5DT2lVaWhWcmZNRGNaZkdkUWN5WE95bEp1eDRqd0YycTZt?=
 =?utf-8?B?NjhTOEo5Y1pjY0VZYktqVWtWd2FzNG1OZysvOHM4VVIrK2xESEZVMlBGQ2xq?=
 =?utf-8?B?QnJQMjd5ZWpvMlhXejNiTHpNN1ZxRUdDWXNSNG1zeVZNaENUTUMrTXFTOGYy?=
 =?utf-8?B?NFdxZWx2eGtwMi9RbU5ZMFNzcnNMcXN3VkxPc2E2TjIzM3NYOGNWREZOS1Jh?=
 =?utf-8?B?RWtsbFZkODBaVW1NSndNREkwN21UWXFweVlDRWQ2bzNoVW93RUVFL2RFZEdv?=
 =?utf-8?B?cURVNm9JQkJicXB3ZUF4VkNtVk9Lemx2WGhkckRaMnhtK3k5eFV6RXV4ZFJv?=
 =?utf-8?B?OTZNSXhMTHloZUlTUk8ra1RLSWVCKytPL0tXYnVFU2ZKU2JUUnRpU05VQ0hP?=
 =?utf-8?B?TjcwVjhUdHBXRFJTeTFmWUhSdi9kSEhTTFBVVlViOWlDTHlZZDI1bWExekZq?=
 =?utf-8?B?bkgvNG1VRUxac0Vlcjlvc2gxOFRJRXNuM2QrSHdoYkhsRVRNa3VBWG15VzZ3?=
 =?utf-8?B?YkVqTm5BTS9HYUoxeDN2SGtOZUdTaG5lckM4VTJuMG9SQzQ5MnpOSzVzTk0w?=
 =?utf-8?B?MWNJTlVmek0xMUhNc0dBTE9WRHFSdkc0TlRCRzF5TWhKaHpVa1hIOTNhUW9j?=
 =?utf-8?B?WkE1TUQ5c3doTEIySEZKVzcxb1VTYUpJdFdLdDN3NXh5ZjN6cU9DNVlncnZG?=
 =?utf-8?Q?ZupPeuRSWNz1NSLezLXX1Eg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWJmQ0NGbHlaMTBmcnFJdk1xOXlKK1lyNVFQaFEvWGNYNkkxQ1J0ckt5WDVT?=
 =?utf-8?B?K1g3ZVJMcUZBQ01Ua2tRNFF1U1Zpa09LNEtka1dyMXc0aVhpK3ZPSWd4NjEw?=
 =?utf-8?B?VXpxaXpLVTUzdkRRdFNYVzNodGltNSt5cThQU2wyK0FXSXc0Q0NWYjdpdGgr?=
 =?utf-8?B?S0J3UVBXYU95M01ybFczUTNEd0RrVCs0RENDU05pTEN1dkFPV241SHdYZytm?=
 =?utf-8?B?emYzenYyelVOMit0SElwODNxNU9rWVlMTmh5cjVyTHVZZHJYa3BmeCtUMVEv?=
 =?utf-8?B?N3FpM2w1cXo2RCtyU2Y2VWpBQVNMcStsUStqZHFqNzRRd3g2WEJZN05kYUxl?=
 =?utf-8?B?OW1rOGk4c1NpZFlOVmVRdTAwbVVqbm1FUmtmNFJ6TUVZeUVDY3BFRUlWREp1?=
 =?utf-8?B?Ky9Vc2FoL0NsMnl1dERPNUYxcXdoaVZXa1J1bzgwRU1QZVpSVEdUVjZjblBV?=
 =?utf-8?B?dERmT0wrSGRyMGt5Q3VJV20xbm1qNmZPdUtrbTU0R1ZmWGh3Z3JzRW41cXFT?=
 =?utf-8?B?ci8weEdVQlBuVWdXU3cyYmg1NkJ6dURJL204clpvOEJIQU1wbFJFRlYzQ0Jo?=
 =?utf-8?B?VTRpb0ZiTVNqd0lTNys2d2dwQzVteWQ5Z3RKQ0lLN3BYL3pEMFlwQ2pBMXhF?=
 =?utf-8?B?Ull0dEx5dmU2VVpxSXNYUkNOcE5uc0JjeTVsbVhTMzRTVEJxQUtHbGpPVi9P?=
 =?utf-8?B?MU1FbFJ0MHFiZWZTYnZtZ1lDNnJxQlREMkE1c0RiMVVZdU02dE1UVmNWaERy?=
 =?utf-8?B?QU5lWDdGcFAxRURTZ2F3aEJtWDJPU3BTTnA2STZHeHBaWGJPcjFMUVQrRjlh?=
 =?utf-8?B?RW4vWE4xNldhMTJOa2lMWE0rZksydUp3Z0lRWkZGUzJqQWJUNkIzTWRHMERI?=
 =?utf-8?B?U0pZdHJCNnQ1Z0lzN2lJeE4vbEtQaFpQSzhyL3JYR205aHcrZncvWjJPSkxM?=
 =?utf-8?B?Z2d5QzNabTUxQnQ4SHJ4MmZKZlNWTDJLNVJhdnpYekRpK1JwRDB4dGNpU2cy?=
 =?utf-8?B?eFk5TUorMEhXaGpHNFVtMWhER0R2bTNBMS84aDZnVWQyK1R4WDVtSHhMUlJY?=
 =?utf-8?B?ZmxYOEhZRVlkNGF6TEo5TGMyV1B0V2NMNEhQYkZNTVNGY3F3VVp0dHBybVNh?=
 =?utf-8?B?NWVUSnZycmJxd0IyczFQNDZZY0VLQzVJc21YVmVIMXNwNXJoc3NEekhhb3RV?=
 =?utf-8?B?QjR5Q1RJRnV6bDhaTEd3bi9zaXdXZEl5NStVWGhaNDVFeDhMUGdoNXlTOUhG?=
 =?utf-8?B?VWdTakxqU0xpaW03RkEramMzQTZFSmhkMmR2dU4wVDhnSTN3TlAvSHJwallv?=
 =?utf-8?B?aE9BNWFNaXM0WndEUDFqaktKd1JCTTNsZUJHR3hRaDQ1N2VNWk9rR0NnL2VK?=
 =?utf-8?B?bHRtZ2RWektiVlUvOGFEcDM5K3daMHNiMDRDZVFMclhaOEY3TXRjKzJZTm1m?=
 =?utf-8?B?ZDBibmRUZnBUdDBvZzRLTVR2SmU2ejZ4ZDR3cm5veHMrY2pMSm1ESEZHVmg0?=
 =?utf-8?B?dEdNZ0xteGExbEwxTUVRbjdsWnFJQkFkL2hjL1NsMHFvdFlUNEpJbUI2NkNz?=
 =?utf-8?B?dS90OEpoc1ZQSkNSYnhGangwT0w3Nm80eTRSOFhRKzNqd3ZpZFdBUWZCK0Ux?=
 =?utf-8?B?cWdSb3Q1RnFLMTIzMXlvaGh5V1dwVVlOVlU5SzVvNkpHNGFGZGxGZ1hPNklT?=
 =?utf-8?B?VXdUWFJEeUZhbzFsNTFpdUlPWTFCalZMakF4U1MvMEtwVGxabFdKa1V6VEJY?=
 =?utf-8?B?Wm9CVGtrenBHOW16MWk2NG8yanRkOVZ6UktDZ2h5NE1FVitQbE1rVjBtdjlh?=
 =?utf-8?B?WCtKYURzVTQrb1FFT2tiOStpNXNCWjZnbUV6K3I0ajRidWNNRENoYUdUcjhH?=
 =?utf-8?B?cCtSdGdyU0tTTG8yZloweGNOYVgyRVQ4eE9RRWZIN09vaHBSSGdqam55b0pK?=
 =?utf-8?B?SlNrWXhUY0dCd2UyWDdjQTI0bjhWbDdxNjhpSXl0NEVkV1NwRU9uM3hYTEtq?=
 =?utf-8?B?a01vRHExamY4QVhwZ2JlOVFyUnp0ektVakRveFh4Yk5XOFRDVzBSOHVZNG1C?=
 =?utf-8?B?S1dUZVg2dyttK0Njb0VmL2NPTGF4Mjg1WkZUWXJ5M0hIV3JaVC9UOTZkRUQ5?=
 =?utf-8?B?eDg5akNNV2JrTnVoWlJNUkZWYVIvelNJSkIwUVNPL3hxbWhldXVpWUV3RXFk?=
 =?utf-8?B?TnhhbEJCc3RRc1c3VWt0NXYvMEhodDhwak9aLzlUYklpOFBXMk9KSHVVeUtB?=
 =?utf-8?B?Yk5CT1VLaGFGdjF4eVJjcDkwYXBGc2xtdnhUVU5NeWo1TkZPbDFMZmVJUHdF?=
 =?utf-8?B?WE1qcHg0eCsrZzF1TVdMU2orNlhtNUllU2IwRWYvWkhoQzVLWWxoZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af9dc3b-c566-4c4a-1c02-08de54d29036
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 07:40:47.2481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJeq2F7LqiVYHFjw+bsoouaZcNR320kWGRsTx7XM7cg74XViLWFwVuQ8vm/vvImtugzn/O4akLWYBTNzBD228xuD6MJ9EnzytRNX3mD1qHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7148
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8xXSBwYy1iaW9zOiBVcGRh
dGUgdmJvb3Ryb20gaW1hZ2UgdG8gY29tbWl0DQo+IDFjOGU5NTEwYjIyYw0KPiANCj4gSGVsbG8g
SmFtaW4sDQo+IA0KPiBPbiAxLzE2LzI2IDAyOjIwLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4+IEZy
b206IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+ID4+IFNlbnQ6IEZyaWRheSwg
SmFudWFyeSAxNiwgMjAyNiAxMjoyMSBBTQ0KPiA+PiBUbzogTmFiaWggRXN0ZWZhbiA8bmFiaWhl
c3RlZmFuQGdvb2dsZS5jb20+OyBKYW1pbiBMaW4NCj4gPj4gPGphbWluX2xpbkBhc3BlZWR0ZWNo
LmNvbT4NCj4gPj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnOyBUcm95IExlZQ0KPiA+PiA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+OyB3dWhhb3Rz
aEBnb29nbGUuY29tOw0KPiBrb21sb2RpQGdvb2dsZS5jb20NCj4gPj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MSAxLzFdIHBjLWJpb3M6IFVwZGF0ZSB2Ym9vdHJvbSBpbWFnZSB0byBjb21taXQNCj4g
Pj4gMWM4ZTk1MTBiMjJjDQo+ID4+DQo+ID4+IGhtbSwgSSBkaWRuJ3QgcmVjZWl2ZSB0aGUgaW5p
dGlhbCBlbWFpbC4NCj4gPj4NCj4gPg0KPiA+IEPDqWRyaWMsDQo+ID4NCj4gPiBJIHVzZWQgdGhl
IGZvbGxvd2luZyBjb21tYW5kIHRvIGdlbmVyYXRlIGEgcGF0Y2ggdG8gdXBkYXRlIHRoZSBwcmUt
YnVpbHQNCj4gdmJvb3Ryb20gaW1hZ2VzOg0KPiA+DQo+ID4gZ2l0IGZvcm1hdC1wYXRjaCAtbyAu
Li92MS1wYXRjaCBIRUFEfjENCj4gPg0KPiA+IEhvd2V2ZXIsIHdoZW4gSSByYW4gZ2V0X21haW50
YWluZXIucGwsIGl0IGNvdWxkIG5vdCBmaW5kIGFueSBtYWludGFpbmVycyBhbmQNCj4gcHJpbnRl
ZCB0aGUgZm9sbG93aW5nIG1lc3NhZ2U6DQo+ID4NCj4gPiAuL3NjcmlwdHMvZ2V0X21haW50YWlu
ZXIucGwgLWYNCj4gPiAuLi92MS1wYXRjaC92MS0wMDAxLXBjLWJpb3MtVXBkYXRlLXZib290cm9t
LWltYWdlLXRvLWNvbW1pdC0xYzhlOTUxMGIuDQo+ID4gcGF0Y2gNCj4gPiBnZXRfbWFpbnRhaW5l
ci5wbDogTm8gbWFpbnRhaW5lcnMgZm91bmQsIHByaW50aW5nIHJlY2VudCBjb250cmlidXRvcnMu
DQo+ID4gZ2V0X21haW50YWluZXIucGw6IERvIG5vdCBibGluZGx5IGNjOiB0aGVtIG9uIHBhdGNo
ZXMhICBVc2UgY29tbW9uIHNlbnNlLg0KPiANCj4gV2VpcmQuIE1BSU5UQUlORVJTIGhhcyA6DQo+
IA0KPiAgICBOdXZvdG9uIE5QQ003eHgNCj4gICAgLi4uDQo+ICAgIEY6IHBjLWJpb3MvbnBjbTd4
eF9ib290cm9tLmJpbg0KPiAgICBGOiBwYy1iaW9zL25wY204eHhfYm9vdHJvbS5iaW4NCj4gICAg
Rjogcm9tcy92Ym9vdHJvbQ0KPiANCj4gV2UgZG8gbGFjayBhIE1BSU5UQUlORVJTIGVudHJ5IGZv
ciBBc3BlZWQgOg0KPiANCj4gICAgRjogcGMtYmlvcy9hc3QyN3gwX2Jvb3Ryb20uYmluDQo+IA0K
PiBDYW4geW91IHBsZWFzZSBzZW5kIGFuIHVwZGF0ZSA/DQo+IA0KPiANCj4gPg0KPiA+DQo+IGZh
dGFsOiAuLi92MS1wYXRjaC92MS0wMDAxLXBjLWJpb3MtVXBkYXRlLXZib290cm9tLWltYWdlLXRv
LWNvbW1pdC0xYzhlOTUNCj4gMTBiLnBhdGNoOg0KPiAnLi4vdjEtcGF0Y2gvdjEtMDAwMS1wYy1i
aW9zLVVwZGF0ZS12Ym9vdHJvbS1pbWFnZS10by1jb21taXQtMWM4ZTk1MTBiLnANCj4gYXRjaCcg
aXMgb3V0c2lkZSByZXBvc2l0b3J5IGF0DQo+ICcvaG9tZS9qYW1pbl9saW4vdXBzdHJlYW0vcWVt
dS92Ym9vdHJvbS9xZW11Jw0KPiA+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZyAob3BlbiBsaXN0OkFs
bCBwYXRjaGVzIENDIGhlcmUpDQo+ID4NCj4gPiBBcyBhIHJlc3VsdCwgb25seSB0aGUgbWFpbGlu
ZyBsaXN0IHdhcyBzdWdnZXN0ZWQ6DQo+ID4gRXZlbnR1YWxseSwgSSBzZW50IHRoZSBwYXRjaCB1
c2luZyB0aGUgZm9sbG93aW5nIGNvbW1hbmQNCj4gPg0KPiA+IGdpdCBzZW5kLWVtYWlsIC1jYyBq
YW1pbl9saW5AYXNwZWVkdGVjaC5jb20gLWNjDQo+ID4gdHJveV9sZWVAYXNwZWVkdGVjaC5jb20g
LWNjIC0tdG8gcWVtdS1kZXZlbEBub25nbnUub3JnIC0tdG8NCj4gPiBwZXRlci5tYXlkZWxsQGxp
bmFyby5vcmcgLS10byBjbGdAa2FvZC5vcmcgLi4vdjEtcGF0Y2gvKi5wYXRjaA0KPiA+IC0tbm8t
c210cC1hdXRoIC0tc210cC1kb21haW49bWFpbC5hc3BlZWR0ZWNoLmNvbQ0KPiANCj4gTG9va3Mg
Y29ycmVjdC4NCj4gDQo+IEkgaG9wZSBteSBwcm92aWRlciBPVkggaXMgbm90IHNpbGVudGx5IGRy
b3BwaW5nIGVtYWlsIDovIFRoZSBzYW1lIHRoaW5nDQo+IGhhcHBlbmVkIHdpdGggYW4gZW1haWwg
ZnJvbSBLYW5lLiBXYXMgYW55IGVtYWlsIHJldHVybmVkIHRvIHlvdSA/DQo+IA0KPiA+IEl0IHNl
ZW1zIHRoYXQgSSBpbmNsdWRlZCB5b3UgaW4gdGhlIC0tdG8gbGlzdC4gRG8gSSBuZWVkIHRvIHJl
c2VuZCB0aGUgcGF0Y2g/DQo+IA0KPiBZb3UgZG8gbmVlZCB0byByZXNlbmQgZm9yIGFub3RoZXIg
cmVhc29uIDogcm9tcy92Ym9vdHJvbSBuZWVkcyBhbiB1cGRhdGUNCj4gdG9vLg0KPiANCj4gQWxz
bywgZm9yIHVwZGF0ZXMgd2l0aCBsYXJnZSBiaW5hcmllcywgZm9yIEZXIHVwZGF0ZXMgdHlwaWNh
bGx5LCB3ZSBwcmVmZXINCj4gc3Vic3lzdGVtIFBScyA6DQo+IA0KPiBTZWUgYW4gZXhhbXBsZSBm
b3IgYSBTTE9GIHVwZGF0ZSBmcm9tIFRob21hcyA6DQo+IA0KPiANCj4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1MTAyNzA3NDQwNC4yNTc1OC0xLXRodXRoQHJlZGhhdC5j
DQo+IG9tLw0KPiANCj4gU29tZSBkb2NzIGhlcmUgOg0KPiANCj4gICAgaHR0cHM6Ly93d3cucWVt
dS5vcmcvZG9jcy9tYXN0ZXIvZGV2ZWwvc3VibWl0dGluZy1hLXB1bGwtcmVxdWVzdC5odG1sDQo+
IA0KPiBQaW5nIG1lIGlmIHlvdSBuZWVkIGhlbHAgc2V0dGluZyB1cCB5b3VyIGVudmlyb25tZW50
LA0KPiANCg0KVGhpcyBpcyBteSBmaXJzdCB0aW1lIHN1Ym1pdHRpbmcgYSBwdWxsIHJlcXVlc3Qu
DQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhlcmUgaXMgYW55dGhpbmcgaW5jb3JyZWN0Lg0KaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L3FlbXUtZGV2ZWwvcGF0Y2gvMjAyNjAx
MTYwNzMwMjQuMzQ4NTgxMi0xLWphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbS8gDQoNClRoYW5rcy1K
YW1pbg0KDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KDQo=

