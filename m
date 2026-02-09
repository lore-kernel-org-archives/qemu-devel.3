Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4FBEF06EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 02:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpGbV-0007Bq-M8; Sun, 08 Feb 2026 21:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpGbR-00077j-3r; Sun, 08 Feb 2026 21:02:17 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpGbN-0004Rl-KI; Sun, 08 Feb 2026 21:02:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEJfZL9yL0DoSW3eW3v8VuCigoxFBi0DETbeyfXGADXx2deLwqoAiY4mFklZUfEPROkBJRWcQjgVdDG3NnYaR16t0XOaPynmVK1jcNOTpfglN3tVEm4tcdIxCEHYIl4xHkh8eF8UDN9yjXtMnRPL12fnFTg6Jem70qVqCX1UKbGV760GPNqcJjgrwqfi6bvW5MzMLx8wvGK2cDwA9EePKqzfeaK4TMBNC3aDR8/8l6U0tiOF2lL0qa4SDTdFTGa0bo1k3UpnUNfaTfNJYrVmJycL2V9cBfaTr/bcVkkr9072LF7FQgxaREa/2W61GCJff3LATEvUOt9y9TEl4G1NIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oacTDR1TpZiF4Tw6ZHFPuaUKgqETNiAkHPNvlindRkY=;
 b=q3NHf62ID7dbIjzUiSAQ0X3RWBCqAmSYsyMEFxbGUDxu5lVKGogHOtbF3abUDEFSubxMahcHwOFCu1JuRUYftBIzHwO8OfF3MaKqLmQw6dhDi724qPSKZPLG8VXJYhOOz8AjR0N50YKszsdtcrUv3UOYAbLUD0w5KaWzqprkGeohLu/cQXD8slETJkE9FUxljjr3IAdeYrG9/PGplQ4ikiMrWL1mdZChvk2FVV9Sg1RkDlhIU65nhp8mkkDzCiPzw1OJrG/qfXq4AfxLyD9IDw9gIjO0p8sDi7BsJHUrqjkG7PRCqqsfVp5R0m0JGhy6ZPPNr14Rt1dNu/yuYm1VnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oacTDR1TpZiF4Tw6ZHFPuaUKgqETNiAkHPNvlindRkY=;
 b=coMeWvnm9OY0O+p3MbSg01cnnGivwJ2MkQ1ZQrCU6M4pX7y00FSHbcKfzmM5hDXvmkjTUjo4JJlJNn7QpPIhhUYCZ+bM3RS/3IRy0eSKcnkgEhShaLbbcZSN/dLbZUQh2Ia2YEm37qG8/rvvbuZUXu2zONQuxPZk3iXE19Q5tFe3gdyoxSOBcgd3T5LxkT+7tBIsagATNRGZI1R8RvwVhcAn1NTD2JAImiMY3/iKJxw1Xo1/djTRukgdvXUTRatT0W8rblT2V61xjo/7XybhFYxHLR/kst+eyuhNFDDnxolZUaERnlNvQqS/d8yW8J04oBIDNehXjZY/d/SGk4NFHw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5270.apcprd06.prod.outlook.com (2603:1096:101:79::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Mon, 9 Feb
 2026 02:02:05 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 02:02:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v1 02/10] hw/i2c/aspeed_i2c: Increase I2C device register
 size to 0xA0
Thread-Topic: [PATCH v1 02/10] hw/i2c/aspeed_i2c: Increase I2C device register
 size to 0xA0
Thread-Index: AQHclyopCTDjMhIGHUuNVV2chvQZwLV1abWAgAQ295A=
Date: Mon, 9 Feb 2026 02:02:05 +0000
Message-ID: <TYPPR06MB8206CDA8BB8B49777541C144FC65A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
 <20260206053340.3716041-4-jamin_lin@aspeedtech.com>
 <ba061380-7377-4814-b0ff-2a95743fcb8d@kaod.org>
In-Reply-To: <ba061380-7377-4814-b0ff-2a95743fcb8d@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5270:EE_
x-ms-office365-filtering-correlation-id: ee9c679f-6d77-450c-dc3a-08de677f3935
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?Q0NJRzVkSVJWb1U5ZFNMaXNyRDNaZjRvcjRkYSswUlpQSDkzMy85aDA3TitF?=
 =?utf-8?B?K2pTNUE0b1NOTHFyRkZydGNYVXB0NDBFSFYxd3lvTXdHZ2hKa0VOOHBpeDZ6?=
 =?utf-8?B?WEhJOFJRVzhVUXAwZnRpdVpxdWNFN084bFg1eGt4VU4vUWN2TzRaSDQwa1ph?=
 =?utf-8?B?QzVQMUU4YmJ1REo2WTg4S1dtMjA2WVNNYVNpVXdKTzJTQzRsM3VXczJqUEIy?=
 =?utf-8?B?cUhXOUI1ZkdRTFVNeE1NZktYTXl4dEV1Nm5HSDA1cVJtcGZ5RjdyaHQ2ZTBR?=
 =?utf-8?B?QUxUMzVyZEsyYlpCaElqZHhNWS9qV1FDdUpxMmhTUUJJbTV6Y0dIOHA4S1hJ?=
 =?utf-8?B?QkpZU1pCWFlidHFZT3NhbSttdURXMWpVSFMvSlRhbXozTlBnUC93czg4Y2Qv?=
 =?utf-8?B?dUdOWFM5ZjVyMmRSblQ2T3hISllkOFFUYW01bzF0d0ViUCs4VXlPRVlsQmpD?=
 =?utf-8?B?Vzd3czFsd0VDdlI0aXAyK1pJencxN25Ld3BabXpuRnUyMUk1WUpYWHdpQmph?=
 =?utf-8?B?clNwNTFLdU9VSUxyeWg4RWFndHRSazFsZzdsYVF1akxwKzA5aWhKQzhaWFlU?=
 =?utf-8?B?bW5QOG5RR2R3Smc0eG5UYnQ3cXZ3ZnNLT01rb3AycjR0dDJRVjRrVkpCZzhR?=
 =?utf-8?B?aDFsMGltVStDeG00YzNmNGtSOWVWeHU4ckljSWZ2bU9ZSFk5dWRyS25iNTlO?=
 =?utf-8?B?dldzc3JyMVZTQysyVmhUN2NXS0VPOXFPV1JFWU5CeUFlaXA1eU1DTDM3RkZI?=
 =?utf-8?B?OWRqcTZVRTkramErTWl3dldFMXlpMVlQYThHMXdnQ2E3RGpJSlB5dHZEWlZV?=
 =?utf-8?B?ay85eWgxeWtiY2t6WmRZQmx3TXFOMXNZcnZFU25la3dQMWh4K0pJVDNXZ1dp?=
 =?utf-8?B?SjRIRDVCQlZNT2NFTVhEMnV3aDQwOVNZeTZVdG14SHdUL0VKckNVSkg2QVBW?=
 =?utf-8?B?R0p0RWhERmswd1ROSDJ4WXVLODBDSlRiTTVvNGVPZUZRbTVmWHkwOHk4U3F3?=
 =?utf-8?B?bzBhSzUvY1hwWlc0cHNTOGMwbS9FZ1Q1QWJuS1o2emkyNGJZZ2hzdEVpRVZW?=
 =?utf-8?B?bThaaDl4bUcvUEJobm1lYkMraVBSWXdYZmt1TUhWdXhMQ0Y4bkUwZXNmSFJv?=
 =?utf-8?B?ekdqVUxCTVRZMk9COHZOTWZJODE2SC9OdkEweHVsbHlQMGJCQU9VdFhGcnp3?=
 =?utf-8?B?cFFDTXZ5RWtaSkRtNE9OMmlXOXhlNk9EamVudW9aWkZ2TEVKQzZpbmpDRkE4?=
 =?utf-8?B?QTNxVHlmYVpWQkQ0ZFpuNjdoYi8xOWx0ZUdUOTRCR3lsZWVva2wwdlRiYjRS?=
 =?utf-8?B?ek92d3lnSG83Qm9wT3JSaDE5NXpZaUpRRm00K01KRXBjSzJsbTdiTXpTaEJS?=
 =?utf-8?B?ZEdydmpLUlFUem9mUG9uR1RMOCtDS0VQeVAwSTFVMkNNYVh6dFJyY2xwc0FP?=
 =?utf-8?B?bWQyekNNM1AwSGxMVkhkQVRURlhuTUFGTzZudUpMbG9rZ1ZBcEx4OTV6dmNq?=
 =?utf-8?B?em5NUWl2UmdjaDdTN3dCaE5VWTlGSzZjbVJSQWpPNjhPcFBJWjAvdVp0YlZY?=
 =?utf-8?B?L1FqT2VsSkxVeWx4S0VoVUtCbElKd2NGcTlNays4TUNoOGtNV0NlUmVnYVpo?=
 =?utf-8?B?SXUrdDBEbWpWTEJPU0daNEFsL0ZjdzFsS3FtQmpCZVdNWXFIUHoweVN1M2Zx?=
 =?utf-8?B?R2dHejNFaXNTTVB5Y0pUdW1hMkdIZmlXckd1Q2N6cDJFM1hTQTk1a1NaUFJQ?=
 =?utf-8?B?Z0doeW5iMS95TW9lQ3RIZlhaSTc2RDEwb0x5cU1teXhyOHFyc2VtWVBEa2Ey?=
 =?utf-8?B?bmhMM0IzNXZwQWtWYTRRNVdndEZ0NFFkN1V6bExBeGxPZHdINktxeWF0YzdX?=
 =?utf-8?B?cGZIeVB0Z0Fsd1JjNTJPNUtDcFRFOHYxNHhPdmVUSFFXQWp6djZSQUk4UWJG?=
 =?utf-8?B?WnpWV1M2ZS9qaFBrdHY0UDhsVkZNSmc4a0dDK1RDWU1mSWl0NVRrakx6WmNJ?=
 =?utf-8?B?MU9HbDUxMWE4RmZwWVZOTi84VDNEMGhlMG9HN0RyZDFFV1F1RUxkNzFGMGFu?=
 =?utf-8?B?azFtVDgrTExWL2VyNFNGK01xeDFVNjM1c1JKNjF5Y0luOHNtb21kM3NaZzdl?=
 =?utf-8?B?VkJTUHduZGpUVTVxWll2VWpYVkZYOFUwN0ZETzJqT2ZOek5yb3FLMjVEUTVV?=
 =?utf-8?Q?L/KR72WF8AnhxmRqvQPYOXCuY9/wWGSQrp74l/bwmXz0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sks0RDQzV1RzUWMraE56bDFtV08wZnRNMWpPNDVkb2RhNDloN05CaDl0RVRD?=
 =?utf-8?B?V2J3Y041VGtXeEZMNU1nMUVHZkVkTnNEV2g5cWxzUi9zenppNTBGQi9zSERJ?=
 =?utf-8?B?eHp0Vy9SR3FIRXoxaEhMbnF0K3A4MWlFNWYzMDBKMjRzaUhEU3ppUDZqSkU0?=
 =?utf-8?B?bzd1M2Y2SDRWNWhaRXFUazYwYitUOWtYajlyTk8vNTVFbDRoc3E3OUdRZ3Yy?=
 =?utf-8?B?NjdOemxIbXZ1NFd6bkl6aTkvbklRUEQ0R3l6UUl1Q1JXRjFMUTVsWXRJdmFV?=
 =?utf-8?B?bmQwQzJxa3BwcFZoMjhSN0JmMU1QU2ZPMitLcXF3c2U1R1NnOE1nV1VFZnhn?=
 =?utf-8?B?SWNVTzI5a1k5TXliWTVhQjgrZlVTZng2MFBZN25sYzBOTnN5a29ycE5BNGFR?=
 =?utf-8?B?Q3R5b3R2Mi8ya1lZMHJzZXNHMU5HZjRSRVhDSWd4aEo0YlFzcExWQlR0V2Ns?=
 =?utf-8?B?eEk2NFhINmVJNjkyeXh0enZ0cE9ITzVwcmNrdVFpY3pIeEZrSFA4ellRRmRH?=
 =?utf-8?B?SGVmQlhOa3J5RHBESVhyTjhpVW5KcmhZWUx1WnVFZ1VZZ3RYN3kyUkpQQXF5?=
 =?utf-8?B?TEVVNE9DSHZIY3FWVmxmWWJIcFVhU2x3ZVlhU1FSRHc4a0d0czltYzV0ZjBX?=
 =?utf-8?B?VXZPU2NzWDI1K1BhQ1pseGNNZncwMVBWelY2MmZUbFg4SC84U1pIQVNpdCtK?=
 =?utf-8?B?dSs1R2JoN0g5ckx6KzQycjhsNHYzUG9GZVFZS3pzT2JXWUJPK2VyWEZPM2g2?=
 =?utf-8?B?elZuZm82OUNscXg4V282UnpERVFmMTlKdHZJbG41a3V4elF5cHRkdzBWMy9Z?=
 =?utf-8?B?UHhNc2Q1d1NmNUtaNkdMeGxFRFdhM3hxeWw0cTljeFBySXBWYkdPM05QbURy?=
 =?utf-8?B?Q2IvdThHTXBJMUxvd1JSWnRYM0NNU0tTaEx2U29yQnNJQ3ppa3BmdXlBYm9v?=
 =?utf-8?B?RE52TXBuanFNTWhmSmlUdXJVUm5tRFFqTmtvMzNpalZhdHZzRDZwRVRpYVZJ?=
 =?utf-8?B?SjE1bmd4MGNEOEttN3doTTl0emppZGlBNm95UXNZVDZoMnduWFFwcnBnb2Ex?=
 =?utf-8?B?dFQ5UnJucDRhVXk3VzRnMFJwRThLb0ZUWlZYQk1YV0JFYVlvMENLSTFxOGhE?=
 =?utf-8?B?UzdOZ1g2cjdFZ2swOWp6ZHJ4cTQySjVmeDJkRTNrUXhVN2Z2eGx4WUZDNHNy?=
 =?utf-8?B?a1hqS2tqNnlEM0Q0bVI2QXJ1QzNibG5TaEU5Q3F4SEdzV0R3dlpxSkRURHE3?=
 =?utf-8?B?SVNadHRhNHROV2tOM1Iwd3hxN3NwNEdWcjFnaklGV1Q3dkY2NU45S2JPMGNZ?=
 =?utf-8?B?Mlp5U2hFdHFvajJqSEo4TW8rVi95d1krVWpkUXhjOXZLanl6OGdyWlBSandx?=
 =?utf-8?B?SEFJb1VqYmpmREZLR095QVY4LzlLS254Y3pIZ0NZRmNydUwvTzl5S25OWlBR?=
 =?utf-8?B?NENJMDl1OGdxcUdDN3ZaR1FiY1Rid01pdXl1WGNpTTRsL1IxaGtZV3dNNU1N?=
 =?utf-8?B?OVJNeGw0WDZKeW4wd3gyRHozVXZnNDdBaGtOMGNidzVBYlh1bUJXUDU3QlVC?=
 =?utf-8?B?YStSR3lDeTNHajhBOUtPVTdjM210VmJaVjYzUHRCYWFKUVYzT0cxUmcvKzdD?=
 =?utf-8?B?Qzl1MnAyVjJGaXR2QTdobXdQSCtZRE9wTEc5Z0NrT3MxSlVoTUNRZTVUcU9n?=
 =?utf-8?B?OVFmUHM2VUVndDNsV3gzNGtIRmtrQlVUcUZtSFhPM3BmR2xEaGtuakQwSXNi?=
 =?utf-8?B?QUI3by9iNnNjeTRsMkRVNjFKNktlbXRVWWl6bjdvRk5FNmtpbTNub2dRQTVr?=
 =?utf-8?B?WlJvWVdqWDJkaFVsSldMdUdQb2hsL1hwcm8xYmZISjlJVkNWdk9ldUdqdUlF?=
 =?utf-8?B?cXZqNHYyaXlGT055UWY0OGN4UVdLUW1kekptckIxZmdLeEMyY2VxZGkxQmRj?=
 =?utf-8?B?MEoycTJpNmlveE5wcGY1YU9sdEhxaGVucDNETDFkQVhhTnVCRkRpUUd1ek1H?=
 =?utf-8?B?czl1M0s4aGQzdjFqckk4SjZWT0NKYjVYdktscFkrNk1YcVpQUVVPL0k0Vy9E?=
 =?utf-8?B?TnRQci9MQ2JVczAvWkpvVXQxdnVGU1YrVEV6eTd1bGVYZ01HTnVWYjMzTkVD?=
 =?utf-8?B?MERhV3hUMWlnUk00S012bzN6K2lpaWxZNDArdTRtSWVpcUc4emNIOW14UjEx?=
 =?utf-8?B?by9tUEpUTFVDc0NaREF1V1B3VHM2d1dUelRoTUdrcURzL1J1TVJrMi9NNklm?=
 =?utf-8?B?ZGQ3aVJMdE1maFE0VXdyd1Q4L01BTGFkaGxhK1V4K2QvbWN6b05keFNXLzN6?=
 =?utf-8?B?RGgxaDJnY0hRcmJWcm1TZVVJS2dqQXpKeGFRRGkxd2Z4WkpCcFJ5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9c679f-6d77-450c-dc3a-08de677f3935
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 02:02:05.1241 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQ7w4f0dEWt+RwQPLTgUKDgUxsFdfczczadM/vYy5GR7I/WK1qogWSxrgrCGCJ88NlHYqSpKf9pjG+c3jryjSwL/NaO6dak/zhYqNx35+rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5270
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDIvMTBdIGh3L2kyYy9hc3Bl
ZWRfaTJjOiBJbmNyZWFzZSBJMkMgZGV2aWNlIHJlZ2lzdGVyDQo+IHNpemUgdG8gMHhBMA0KPiAN
Cj4gT24gMi82LzI2IDA2OjMzLCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gQWNjb3JkaW5nIHRvIHRo
ZSBBU1QyNzAwIEExIGRhdGFzaGVldCwgdGhlIHJlZ2lzdGVyIHNwYWNlIGZvciBlYWNoIEkyQw0K
PiA+IGRldmljZSBpbnN0YW5jZSBoYXMgYmVlbiBleHBhbmRlZCBmcm9tIDB4ODAgYnl0ZXMgdG8g
MHhBMCBieXRlcy4NCj4gDQo+IFdhcyB0aGF0IGNoYW5nZSBpbnRyb2R1Y2VkIHdpdGggdGhlIEEx
ID8gb3IgQTAgPw0KPiANCg0KVGhlIGNoYW5nZSB3YXMgaW50cm9kdWNlZCBpbiBBMS4NCkJvdGgg
QTEgYW5kIEEyIHVzZSB0aGUgc2FtZSBkZXZpY2UgcmVnaXN0ZXIgc2l6ZSBvZiAweEEwLg0KDQpU
aGFua3MsDQpKYW1pbg0KDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gPiBVcGRhdGUg
dGhlIEFTVDI3MDAgSTJDIGNvbnRyb2xsZXIgY29uZmlndXJhdGlvbiB0byByZWZsZWN0IHRoZSBu
ZXcNCj4gPiByZWdpc3RlciBsYXlvdXQgYnkgaW5jcmVhc2luZyB0aGUgcGVyLWRldmljZSByZWdp
c3RlciBzaXplIHRvIDB4QTAgYW5kDQo+ID4gYWRqdXN0aW5nIHRoZSByZWdpc3RlciBnYXAgc2l6
ZSBhY2NvcmRpbmdseS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8amFtaW5f
bGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvaTJjL2FzcGVlZF9pMmMuYyB8
IDM2ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNo
YW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2h3L2kyYy9hc3BlZWRfaTJjLmMgYi9ody9pMmMvYXNwZWVkX2kyYy5jIGluZGV4DQo+
ID4gY2YzYTAwMzk3OC4uZTE2ODJjOWJkZCAxMDA2NDQNCj4gPiAtLS0gYS9ody9pMmMvYXNwZWVk
X2kyYy5jDQo+ID4gKysrIGIvaHcvaTJjL2FzcGVlZF9pMmMuYw0KPiA+IEBAIC0xMjA2LDM3ICsx
MjA2LDM3IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9pMmNfaW5zdGFuY2VfaW5pdChPYmplY3QNCj4g
Km9iaikNCj4gPiAgICAqDQo+ID4gICAgKiBBZGRyZXNzIERlZmluaXRpb25zIChBU1QyNzAwKQ0K
PiA+ICAgICogICAweDAwMCAuLi4gMHgwRkY6IEdsb2JhbCBSZWdpc3Rlcg0KPiA+IC0gKiAgIDB4
MTAwIC4uLiAweDE3RjogRGV2aWNlIDANCj4gPiArICogICAweDEwMCAuLi4gMHgxOUY6IERldmlj
ZSAwDQo+ID4gICAgKiAgIDB4MUEwIC4uLiAweDFCRjogRGV2aWNlIDAgYnVmZmVyDQo+ID4gLSAq
ICAgMHgyMDAgLi4uIDB4MjdGOiBEZXZpY2UgMQ0KPiA+ICsgKiAgIDB4MjAwIC4uLiAweDI5Rjog
RGV2aWNlIDENCj4gPiAgICAqICAgMHgyQTAgLi4uIDB4MkJGOiBEZXZpY2UgMSBidWZmZXINCj4g
PiAtICogICAweDMwMCAuLi4gMHgzN0Y6IERldmljZSAyDQo+ID4gKyAqICAgMHgzMDAgLi4uIDB4
MzlGOiBEZXZpY2UgMg0KPiA+ICAgICogICAweDNBMCAuLi4gMHgzQkY6IERldmljZSAyIGJ1ZmZl
cg0KPiA+IC0gKiAgIDB4NDAwIC4uLiAweDQ3RjogRGV2aWNlIDMNCj4gPiArICogICAweDQwMCAu
Li4gMHg0OUY6IERldmljZSAzDQo+ID4gICAgKiAgIDB4NEEwIC4uLiAweDRCRjogRGV2aWNlIDMg
YnVmZmVyDQo+ID4gLSAqICAgMHg1MDAgLi4uIDB4NTdGOiBEZXZpY2UgNA0KPiA+ICsgKiAgIDB4
NTAwIC4uLiAweDU5RjogRGV2aWNlIDQNCj4gPiAgICAqICAgMHg1QTAgLi4uIDB4NUJGOiBEZXZp
Y2UgNCBidWZmZXINCj4gPiAtICogICAweDYwMCAuLi4gMHg2N0Y6IERldmljZSA1DQo+ID4gKyAq
ICAgMHg2MDAgLi4uIDB4NjlGOiBEZXZpY2UgNQ0KPiA+ICAgICogICAweDZBMCAuLi4gMHg2QkY6
IERldmljZSA1IGJ1ZmZlcg0KPiA+IC0gKiAgIDB4NzAwIC4uLiAweDc3RjogRGV2aWNlIDYNCj4g
PiArICogICAweDcwMCAuLi4gMHg3OUY6IERldmljZSA2DQo+ID4gICAgKiAgIDB4N0EwIC4uLiAw
eDdCRjogRGV2aWNlIDYgYnVmZmVyDQo+ID4gLSAqICAgMHg4MDAgLi4uIDB4ODdGOiBEZXZpY2Ug
Nw0KPiA+ICsgKiAgIDB4ODAwIC4uLiAweDg5RjogRGV2aWNlIDcNCj4gPiAgICAqICAgMHg4QTAg
Li4uIDB4OEJGOiBEZXZpY2UgNyBidWZmZXINCj4gPiAtICogICAweDkwMCAuLi4gMHg5N0Y6IERl
dmljZSA4DQo+ID4gKyAqICAgMHg5MDAgLi4uIDB4OTlGOiBEZXZpY2UgOA0KPiA+ICAgICogICAw
eDlBMCAuLi4gMHg5QkY6IERldmljZSA4IGJ1ZmZlcg0KPiA+IC0gKiAgIDB4QTAwIC4uLiAweEE3
RjogRGV2aWNlIDkNCj4gPiArICogICAweEEwMCAuLi4gMHhBOUY6IERldmljZSA5DQo+ID4gICAg
KiAgIDB4QUEwIC4uLiAweEFCRjogRGV2aWNlIDkgYnVmZmVyDQo+ID4gLSAqICAgMHhCMDAgLi4u
IDB4QjdGOiBEZXZpY2UgMTANCj4gPiArICogICAweEIwMCAuLi4gMHhCOUY6IERldmljZSAxMA0K
PiA+ICAgICogICAweEJBMCAuLi4gMHhCQkY6IERldmljZSAxMCBidWZmZXINCj4gPiAtICogICAw
eEMwMCAuLi4gMHhDN0Y6IERldmljZSAxMQ0KPiA+ICsgKiAgIDB4QzAwIC4uLiAweEM5RjogRGV2
aWNlIDExDQo+ID4gICAgKiAgIDB4Q0EwIC4uLiAweENCRjogRGV2aWNlIDExIGJ1ZmZlcg0KPiA+
IC0gKiAgIDB4RDAwIC4uLiAweEQ3RjogRGV2aWNlIDEyDQo+ID4gKyAqICAgMHhEMDAgLi4uIDB4
RDlGOiBEZXZpY2UgMTINCj4gPiAgICAqICAgMHhEQTAgLi4uIDB4REJGOiBEZXZpY2UgMTIgYnVm
ZmVyDQo+ID4gLSAqICAgMHhFMDAgLi4uIDB4RTdGOiBEZXZpY2UgMTMNCj4gPiArICogICAweEUw
MCAuLi4gMHhFOUY6IERldmljZSAxMw0KPiA+ICAgICogICAweEVBMCAuLi4gMHhFQkY6IERldmlj
ZSAxMyBidWZmZXINCj4gPiAtICogICAweEYwMCAuLi4gMHhGN0Y6IERldmljZSAxNA0KPiA+ICsg
KiAgIDB4RjAwIC4uLiAweEY5RjogRGV2aWNlIDE0DQo+ID4gICAgKiAgIDB4RkEwIC4uLiAweEZC
RjogRGV2aWNlIDE0IGJ1ZmZlcg0KPiA+IC0gKiAgIDB4MTAwMCAuLi4gMHgxMDdGOiBEZXZpY2Ug
MTUNCj4gPiArICogICAweDEwMDAgLi4uIDB4MTA5RjogRGV2aWNlIDE1DQo+ID4gICAgKiAgIDB4
MTBBMCAuLi4gMHgxMEJGOiBEZXZpY2UgMTUgYnVmZmVyDQo+ID4gICAgKi8NCj4gPiAgIHN0YXRp
YyB2b2lkIGFzcGVlZF9pMmNfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnAp
IEBADQo+ID4gLTE2NzAsOCArMTY3MCw4IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF8yNzAwX2kyY19j
bGFzc19pbml0KE9iamVjdENsYXNzDQo+ICprbGFzcywgY29uc3Qgdm9pZCAqZGF0YSkNCj4gPiAg
ICAgICBkYy0+ZGVzYyA9ICJBU1BFRUQgMjcwMCBJMkMgQ29udHJvbGxlciI7DQo+ID4NCj4gPiAg
ICAgICBhaWMtPm51bV9idXNzZXMgPSAxNjsNCj4gPiAtICAgIGFpYy0+cmVnX3NpemUgPSAweDgw
Ow0KPiA+IC0gICAgYWljLT5yZWdfZ2FwX3NpemUgPSAweDgwOw0KPiA+ICsgICAgYWljLT5yZWdf
c2l6ZSA9IDB4YTA7DQo+ID4gKyAgICBhaWMtPnJlZ19nYXBfc2l6ZSA9IDB4NjA7DQo+ID4gICAg
ICAgYWljLT5nYXAgPSAtMTsgLyogbm8gZ2FwICovDQo+ID4gICAgICAgYWljLT5idXNfZ2V0X2ly
cSA9IGFzcGVlZF8yNjAwX2kyY19idXNfZ2V0X2lycTsNCj4gPiAgICAgICBhaWMtPnBvb2xfc2l6
ZSA9IDB4MjA7DQoNCg==

