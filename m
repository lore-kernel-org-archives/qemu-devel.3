Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54621D4A619
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 09:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggQk-0001wo-CS; Fri, 16 Jan 2026 04:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vggQh-0001ti-2f
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:47:43 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vggQd-0007zX-Ui
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:47:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUEefmZf7VqTkwbLuz7vNmW0GUqzCPQuKz9tQX6GvOuwkyKr8Jb9teFcp23ichFqIF+am09aF4pYzOgcTlgqAl004TJ6rzmFCKuYjE4XPEbKSOD4iXJWVdWOkCW0OeZt+Dgo4ReXcGYVlt9XLrhvzqnYgSYt01yAfDLeRimV/Strz9q2M5vUkGnSQHQl2SPMA6e9ML7P6kbWuKQ7xr/ZW26hSLI6TfDo4jNWjbcs9O7WorwutQdvyYlp4EIMFsOKNZPc43qrIVD2LQD5Xmiaifm2ksv896N2GJ5esBVmL9wnUnX/kFay9iGmq04R5w5c1s6JCh7vaihTeabBtC7fIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sg52vz+HKipTmP4B6Rv+GFy2H+O4H4WcYn2s1QWUzyE=;
 b=KjnDwy51UOm1jAr3crLKPEiUQ92IHtoXieInOoqNmbzmE4FvIaiVEqwldRI9WDYWUNZ5xhAX2MRNl4v7VaxTNnuViXckYwEnHlatvUhv1I1ibZSS0RsLqjIHsK3y9oz1FfMwiu+vLn37oBVjtHIq0au0Z/dq06xTaKQbfGr4PqCsYOLQd7jQRdFxQ2m5xYpkOpfLuucfw2Ph97Uyl0DGwq6d2jk82W2aD4Thi9fVZtO8/2BzkfK77or4c9aS3r1e3DWK31Yos3V5pHYaATrhq1rBVOAed26znLBx8U0C1mxTPFHfPfNxcx+523KKVRjGUFYIxJAJMcT097yw1hF7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sg52vz+HKipTmP4B6Rv+GFy2H+O4H4WcYn2s1QWUzyE=;
 b=c6BqIBBPKXfXorMp9zvX2Pb6q23Tb/KoxP/dYk//FKcz3GUYHrf7/eKCOKwqQcQ520R7rQD+rq1qQPC6/2jCuJwIGf+tQ7l2e+3GiR+V1XDe/PjMsj0zunf/TeooDqaDG2uZd+PO/mU1lDAWIU3w9xLaKxd6E4xtIxOJRRdOdRVhnO7sXItcW081EwNQXcWhH2bRYN1kIV3E+M+XKlVX6Epz9WvV4LI35dZlCz9r9T9jB0yV/rBnY+z0rKZAtV5uOp7R1BOKWXLJNVDI3T+VKgltwPyIGMF2jr2iCqqfg+1pB5RrBJyFkOJGLS3/5SJQl8ckMgmyy6Q823/IaUqBvg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB7118.apcprd06.prod.outlook.com (2603:1096:405:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 09:47:31 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 09:47:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>, Michael Tokarev
 <mjt@tls.msk.ru>, "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, "komlodi@google.com"
 <komlodi@google.com>
Subject: RE: [PULL SUBSYSTEM vbootrom, v2, 0/2] Update vbootrom image to
 commit 1c8e9510b22c
Thread-Topic: [PULL SUBSYSTEM vbootrom, v2, 0/2] Update vbootrom image to
 commit 1c8e9510b22c
Thread-Index: AQHchsGNdALvco5gGUOd4RKsZ1vP+bVUg9MAgAAE4gCAAALtgIAAANXw
Date: Fri, 16 Jan 2026 09:47:31 +0000
Message-ID: <TYPPR06MB820673CED855E75F3AC7BAFBFC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260116082431.3689035-1-jamin_lin@aspeedtech.com>
 <226f29f4-0017-4436-b14d-232b3ccf8d45@kaod.org>
 <TYPPR06MB8206FC043C61247FEC3BDB1DFC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <fec645ea-d998-459a-b3dd-b141ac49a6e1@redhat.com>
In-Reply-To: <fec645ea-d998-459a-b3dd-b141ac49a6e1@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB7118:EE_
x-ms-office365-filtering-correlation-id: 85af216a-b02a-4d76-dcf4-08de54e444bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UTNsc1kvRE5lMy83Q3FCeElrRDlmcnY3Mk5wVm1VYVVWS1pEeXp5SkFrM0RM?=
 =?utf-8?B?cFlDeU8vZGJTNHZBNkxXYVJHdjMrRGU4L3NlbStiZ2FGUkFBMHJUVzVlUHA5?=
 =?utf-8?B?bzN4SU1DR1NabmcxaHNNbk0vd2VBOXJSNmxQUGRXQ1JlS2dqRHNid2loejdw?=
 =?utf-8?B?Q3BOVzRWYnNpTS95K2FyVEhMWmdCenNpWDZWMWtucFNNOFZnR3JGQ2dnajEr?=
 =?utf-8?B?eFRvdnVDMzhNeDliZGFOdkxqZG9PaTQ2bm1hNDNkT3JaTHRuTDZ4d3FDTjg0?=
 =?utf-8?B?MUw5KzJPWVFaZmtsVDNBMm1pNG9sNXo1K1BMUzh0UXh1elJWVTBOM0xITTJO?=
 =?utf-8?B?TmwwM1BsQXFNUUVSZWdUbHE5R2w5YVJsMTBFTk83ZUtrc0pKUVlXaTQ2eVpU?=
 =?utf-8?B?SU1RVDFRR3JBclpER1g4Tldpazh6b1FHbTd5UE1nRk82SDJTdkhCd2VyZUFM?=
 =?utf-8?B?cEppWHhNZEYvUFpQbFQweW1rRVljdWVmQUF6SllOdGxjbkZpdkRaeG1ldmJl?=
 =?utf-8?B?SmVsRU0ycDFrRWxVVUpRMDFMbjg4SkVvMzNvemlCMHpqZkc0Y2Z4VEFlVmlm?=
 =?utf-8?B?Q3crSmxyaXpyUm45MlU2Ylc1NDZaMCtHeFdyMkFWVC9lbzNBRGYrbk9GUDdP?=
 =?utf-8?B?SWhhYzVUaUNBQ3dscXRhZlliRWYvUWVZVWE1djE2cnRkdlVxbTJQT3QxRGgy?=
 =?utf-8?B?KytXaDhIcVBXSjRjTFJiQXl2RUlzK1BJUFl1N1BHcUhkc1YxWXVuc04zTTFo?=
 =?utf-8?B?WTM2RUhUOHVoWTFKT29ETVdVcTVaMzJvekRyZFNkT2R4bzRzSDdqT1BOa0Qy?=
 =?utf-8?B?OVJ4NzJzYnBqM3hKd2xweHcxNU15WUNXaVpDeERkRFY2NGVVMTVzNndKZHND?=
 =?utf-8?B?bUpnNFdKVWYyUTNESGRaU1lxT1IyZUVLVDYxeml3ZUxMdUdSME1sSWJMdVVN?=
 =?utf-8?B?N2x2MWhyVWFENUdBL2ZYWUZCZzZCamcyYnA2dU9tUDh5aDJXWWltSDUxa2la?=
 =?utf-8?B?NWFLVXE2eHNhdWJPWXBRcVlsSW9MYUREN3ZjVlJ1VkVFYkIzWFZNWGtQYTNS?=
 =?utf-8?B?d1E3aGV5RGhkdGpqa01RTzUwaXBUb0tXcUVoVnFhZ3pSNzF3RGthdm11Z2Rn?=
 =?utf-8?B?ektjT01rOWVCQnhaK3c2OENMVTBYMlhwUktDUXJ0dnhURXpNY2R3S2F0QWEw?=
 =?utf-8?B?ejZSQTFIQThCZVQxVUdzRzRPTklsOXlQZHYxM3F1S0ZldGxqRHo4anVoankx?=
 =?utf-8?B?OCtkbjVadmZEYWtJZlBMWmVpWmVvZ1EvNTNSb2I1QndPdDFLN0dCN3lmK2hn?=
 =?utf-8?B?TFY3Nm1URS9kZTJqSFBCWkdaTzNoZ0R0QUtxODJnaXFXUVFRZDh0R0dzMVpK?=
 =?utf-8?B?Q0Zlc2pzQjYyVko0ZjAweHpUYnFOSVlWRm9pcXJhZEZVOWl1ZVV2RTlQY052?=
 =?utf-8?B?allvcGMzOU85Z1pmZkhsZ202NVBpbzQ0NnE1YWFmd1lJR3RSU1lib0xvZUw3?=
 =?utf-8?B?OUgzdHRJREtQK1h1YTg1YXZMOGExSFh3TlJRRmZkT1c3L0dpMXdRQk5IZUhr?=
 =?utf-8?B?TzRjaWI2QjQ4ZU1oV0g1aklyaGhtZ1pEZ1laMWRQSERqVHoycFhyOE9kL1Uy?=
 =?utf-8?B?L0pCUk04dlVFcWY2T1Y4NlFDUDFmUktRdkY2b3l4Zi9qSE0zQXQxb2xZK01p?=
 =?utf-8?B?SGZUcUZoY1E0QUdOSmdVNTR5YXlvNnJzb1FMVzRKTThaaFBiSmpaQXhCTHc2?=
 =?utf-8?B?SnV1SEpjelM2K0NtTzJwVVk0SVNrdnBRaUVnM0I3b29Ua3NQNCtKcmZKcHo2?=
 =?utf-8?B?Qk5yZENLczg1S3BsRmw0T3lZQWdsanY0aGRIYnZ0RE9oYXNFS3JlZzVxNkMv?=
 =?utf-8?B?aHZ4VzQ2UGFNbnc1RTlKR3l1SG51T1UzU29NT0Z5T3hJM3Z2WG5ZVTVSbWhm?=
 =?utf-8?B?SWNJdG1QcCtiT0dZSDFMY09WcUNzVjhMWjl6UmpXdE5xMW02UjV0RGhyMlZx?=
 =?utf-8?B?SXNFaVlnWHdGN3BhQUN4Rm51Y2wrM01yQTV6akJWMUNIUTRCaFg2RE9TR0hh?=
 =?utf-8?B?Mkp3TGJESDJjR3hZV0oyRkVqSnFCS1ZGdUNxUDJTd3d1NmR2KzJXSkJSdUJQ?=
 =?utf-8?Q?B6MmNentb2Jbnq0CqEhrOhUNL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3c0YUZEWUZsUHZVZVpSdDBWbS9PZkcrREVvQnpCeHM1VW0ydjZXa2U3MVJr?=
 =?utf-8?B?L3VhdHEvUEpUdDd4VE9PYjNDV0h5ck5KenpFYWpaMUg3OEdUZVQ3TmJ1dFdV?=
 =?utf-8?B?TGFtSGdDT0tiUTk1UlQ3MFNpZSt1VXJJc0ZzT2xYWFUxcVJCUWZEbXQwQ2Er?=
 =?utf-8?B?c3NGSjZ5am1iVVhaa0lTeXNvbi9xelZGbER0N0c3Z2dMY1hHU1hPZVNrdDNV?=
 =?utf-8?B?TUxldFVLMUZUekNnVExzaFVONytUYzFhK2cwYm1GenN0NURWbWxxSitIN0Fw?=
 =?utf-8?B?SWpaT0NYSEc0bnM4TEY1Z0RaYklYYlBMT0VqSXAxOVR1SytYdjNoOG0wUjJD?=
 =?utf-8?B?R1B1T0VlbE5wMkxpeWkyaUhLaEZEVGRyc2Z6cURnR0wzV2JRaXlKb2VITWk4?=
 =?utf-8?B?cFFkSGdGNlp0ZFhkVm11OU85OVc3eVhzdFBKUE1ONi9Ia3NLQ1g1SDczV2NC?=
 =?utf-8?B?ckRIcXN6MVFnblJTWDZkaHAxSWJkU1lXZWxJdmdKWWM2b3ZDUDNzRE5PdW9h?=
 =?utf-8?B?NTcrS1RWeHR1bjBDQkR5SFc1ZU1GeXNIbXlacjdkNzA5dGVPOXgwaVA5S0sx?=
 =?utf-8?B?VVFTaTJoNWVwRnEzNld2cHRCYkZ1TXR2M2dWUnFMZG1HRzNONk44ZzZUbTVX?=
 =?utf-8?B?UFpQZ0V2TWs2Q01ZZkY2cWZpRnNnb2F1QldiZmlCYXJ4SFkzQ01Tblhudkhy?=
 =?utf-8?B?WnJPMlJFejlyN0ZseU4yZjB0M3Vsay9iMXUvMFlobmx3YWx0cndna0FPUHVz?=
 =?utf-8?B?WEk3akhJN2c4em42MjZweFAzZ1B0ZjlBMDlHK2xQS2tKRk5tZ05iVytyMDZK?=
 =?utf-8?B?QWd3bTJPWnkwN0pTTm9Gdk8xaGFUS1VQNityUkNaTUdoa3lES3ZnRmtBME1X?=
 =?utf-8?B?eXFlLzVXNVYrZlJVa2t4SWhhQ20zL080am9HblprNENMaTFlMUVxSm1vZFph?=
 =?utf-8?B?eFY0cUZ5allzbUlVNWJUYzNydjM2VzZpZjRvSFBZTlFyL2h4cTJFT1NwbFhG?=
 =?utf-8?B?eGp1ZzdMODJHYXU1NkNlSWtTVSsxUE5wYXFlVnQxUVU0VE5pUzF3d1g5WnNS?=
 =?utf-8?B?NEJvY0hqRXlVbFJaQnhNeG51bjdEU29LVkRINVU2TGdQamNubXg3Nk41QjN6?=
 =?utf-8?B?RUJXSzMvWE9IRXJsa2tHdkNsdlVNSHpJb2swdlF1ajdiV0d0dmtqNUdFSHE0?=
 =?utf-8?B?amdhQWtjMlNBODVCbkI3Rlh5blFldHZjbHFmRzN0MGMzMDM0Z2lXMkNqWW1H?=
 =?utf-8?B?UnQ4Zmd0R0NheUlJaXFPTlVNc2lmYURLcnlzYnVnZFdaRXFJYTJHSmhGTit4?=
 =?utf-8?B?b3E2QThZQTQ5VlZqWll5OEtibmhLTGJvQk9hMmRMeWgzV2w2VHZDaUpzcmRn?=
 =?utf-8?B?SW9TbzF1RTMyUGpKdG8zK3UyMGVEeHBCdXE1ZWZDVFJXdGl1amhIZWw2VS9L?=
 =?utf-8?B?TEpWc3JKdlNHR2JZckovM3k5eEMwSCtYZnhjUlhyelBGcUVrMFpEcFBtNm9v?=
 =?utf-8?B?RGNXT1ZhdCtuNDJKYjFZUDNZdnNjQXdGSUNvWHY2di82TGo0U0tnbUEzWlJB?=
 =?utf-8?B?TGJhYUV1d2puTzNsRnZJb0NQZ1d6M0VGT3UyNmdiT1daRnJvRkREVUtKbmFO?=
 =?utf-8?B?WC9NWnFSRi93UE5pMXlBaWFhWXZDQjFsSm5Qc05JMUJQZ0IzcEtVNXVFQ3pQ?=
 =?utf-8?B?dkptTVNldXVLL2J5WVpRMDRYK2lhdnVTRGMybGp5bTc3cXBDRzN2Y0lpRFc4?=
 =?utf-8?B?Z0FJenM4ZjNTVEtkRStrNFNKOXhUTE80Y3o5d0Q2dmJsbXdmME9sM3paV0pj?=
 =?utf-8?B?djJvL1ZFQVViMUVDT2tDVGxOdytBblIwMk5DcUlya09rMHFHdTFMekxTcXoz?=
 =?utf-8?B?YVREU1pWKzhMK1RIMjZTcTRWWmtpZHRHTG84VDgvcVlZU21pS0Q4RG5ESE1m?=
 =?utf-8?B?M1dQbS9ub1VrMlNmTndsY2Vkc3AxNThEV21MOVoyS1lYZ0JtcGxEQ1dsZ3ZP?=
 =?utf-8?B?Qld4OU8wZlBSRzBsVFVjbi8wVkdKQ1Q4Wk01MEVKQzZjbTJtb0lRQTJxRWZy?=
 =?utf-8?B?bW5NTVJNQ0JOK25HemUrdjF2aDUzTVIrUmFlY0JoS3FNd0xGMzI1Wnlhd0xR?=
 =?utf-8?B?WjU3blJ6OWMra2s4RnVyM3JJUlZycjI1cDFlNFM5QmF1ZE1kN2tCNnpSaHVw?=
 =?utf-8?B?NjdjSjFqaHZBNGcyTFNUeWx2Vis5UVQrNGdYY0lhdXdwTnM0S2ppMm96R0hm?=
 =?utf-8?B?OHNIUVVYanh1eXV3NEF0VnUwQ09oM1lZZXhYSUhQNDJ0R2VzaWFQdC9YZ3Nw?=
 =?utf-8?B?OWZqenNrbUdsREtLdCtIUlFJakhzc3lBNTBiVGRzTXZ3RW5vVy92Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85af216a-b02a-4d76-dcf4-08de54e444bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2026 09:47:31.4639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DWMR8F+m3U4d7wLUi5uKfqwOBO9ObqDOiUcr98cVtctu64iilmaAsVY2wTpF24EBdo/sJ+GgOwP7GgfZG81S23QugUgM/1xM+b0QurfrG4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7118
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUFVMTCBTVUJTWVNURU0gdmJvb3Ryb20sIHYy
LCAwLzJdIFVwZGF0ZSB2Ym9vdHJvbSBpbWFnZSB0bw0KPiBjb21taXQgMWM4ZTk1MTBiMjJjDQo+
IA0KPiBPbiAxLzE2LzI2IDEwOjM1LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSGkgQ8OpZHJpYywN
Cj4gPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BVTEwgU1VCU1lTVEVNIHZib290cm9tLCB2MiwgMC8y
XSBVcGRhdGUgdmJvb3Ryb20gaW1hZ2UNCj4gPj4gdG8gY29tbWl0IDFjOGU5NTEwYjIyYw0KPiA+
Pg0KPiA+PiBKYW1pbiwNCj4gPj4NCj4gPj4gT24gMS8xNi8yNiAwOToyNCwgSmFtaW4gTGluIHdy
b3RlOg0KPiA+Pj4gVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdA0KPiA+PiBjMWM1
OGNlZTE2MzgwZjgxZjg4ZmJkZTZiMTJmMjQ3YjM3NjgzOWUyOg0KPiA+Pj4NCj4gPj4+ICAgICBN
ZXJnZSB0YWcgJ3B1bGwtdGFyZ2V0LWFybS0yMDI2MDExNScgb2YNCj4gPj4gaHR0cHM6Ly9naXRs
YWIuY29tL3BtMjE1L3FlbXUgaW50byBzdGFnaW5nICgyMDI2LTAxLTE2IDA5OjMzOjIwDQo+ID4+
ICsxMTAwKQ0KPiA+Pj4NCj4gPj4+IGFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5
IGF0Og0KPiA+Pj4NCj4gPj4+ICAgICBodHRwczovL2dpdGh1Yi5jb20vamFtaW4tYXNwZWVkL3Fl
bXUuZ2l0DQo+ID4+IHRhZ3MvcHVsbC12Ym9vdHJvbS0yMDI2MDExNi12Mg0KPiA+Pj4NCj4gPj4+
IGZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0bw0KPiA+PiAyOTU1OGQxYjdkN2RjODI1ZmI4
ZTdjMDc0NDY0YzFjMzZhMjdiZTdiOg0KPiA+Pj4NCj4gPj4+ICAgICBwYy1iaW9zOiBVcGRhdGUg
dmJvb3Ryb20gaW1hZ2UgdG8gY29tbWl0IDFjOGU5NTEwYjIyYw0KPiA+Pj4gKDIwMjYtMDEtMTYN
Cj4gPj4gMTY6MDA6MDUgKzA4MDApDQo+ID4+Pg0KPiA+Pj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+Pj4gdmJvb3Ry
b20gdXBkYXRlIHB1bGwgcmVxdWVzdCB2Mg0KPiA+Pj4NCj4gPj4+IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPj4+DQo+
ID4+PiBKYW1pbiBMaW4gKDIpOg0KPiA+Pj4gICAgIE1BSU5UQUlORVJTOiBVcGRhdGUgQVNQRUVE
IGVudHJ5DQo+ID4+PiAgICAgcGMtYmlvczogVXBkYXRlIHZib290cm9tIGltYWdlIHRvIGNvbW1p
dCAxYzhlOTUxMGIyMmMNCj4gPj4+DQo+ID4+PiAgICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAg
ICAgfCAgIDIgKysNCj4gPj4+ICAgIHBjLWJpb3MvYXN0Mjd4MF9ib290cm9tLmJpbiB8IEJpbiAx
NjQwOCAtPiAyODU2NCBieXRlcw0KPiA+Pj4gICAgcGMtYmlvcy9ucGNtN3h4X2Jvb3Ryb20uYmlu
IHwgQmluIDY3MiAtPiA3MzYgYnl0ZXMNCj4gPj4+ICAgIHBjLWJpb3MvbnBjbTh4eF9ib290cm9t
LmJpbiB8IEJpbiA2NzIgLT4gNjcyIGJ5dGVzDQo+ID4+PiAgICByb21zL3Zib290cm9tICAgICAg
ICAgICAgICAgfCAgIDIgKy0NCj4gPj4+ICAgIDUgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4+Pg0KPiA+Pg0KPiA+PiBDb3VsZCB5b3UgcHVibGlzaCB5
b3VyIGdwZyBrZXkNCj4gPj4gQzZFMDk0MDA1NDIzMTVFODY5RUUzNTQ3NTE4RThEQUI4QUYxM0I5
NCA/DQo+ID4+DQo+ID4+IGFuZCByZXNlbmQgYSB2MyB3aXRoIGp1c3QgdGhlIHJvbSB1cGRhdGUg
Pw0KPiA+Pg0KPiA+IEkgcmVzZW5kIHYzIGhlcmUsDQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wcm9qZWN0L3FlbXUtZGV2ZWwvcGF0Y2gvMjAyNjAxMTYwOTMyNDkuNA0KPiA+IDQz
MzA3LTEtamFtaW5fbGluQGFzcGVlZHRlY2guY29tLw0KPiA+DQo+ID4gRG8geW91IG1lYW4gcGFz
dGVkIG15IHB1YmxpYyBrZXkgaGVyZT8NCj4gDQo+IEkgbWVhbiB0byBleHBvcnQgaXQgb24gYSBw
dWJsaWMgc2VydmVyLiBGb3IgaW5zdGFuY2UsDQo+IA0KPiAgICBodHRwczovL2tleXNlcnZlci51
YnVudHUuY29tLw0KPiANCj4gU29tZSBtb3JlIGluZm8gYmVsb3cuDQo+IA0KDQoNCkRvbmUNCmph
bWluX2xpbkBhc3BlZWQtZncwMjp+JCBncGcgLS1rZXlzZXJ2ZXIga2V5c2VydmVyLnVidW50dS5j
b20gLS1zZW5kLWtleXMgQzZFMDk0MDA1NDIzMTVFODY5RUUzNTQ3NTE4RThEQUI4QUYxM0I5NA0K
Z3BnOiBzZW5kaW5nIGtleSA1MThFOERBQjhBRjEzQjk0IHRvIGhrcDovL2tleXNlcnZlci51YnVu
dHUuY29tDQpodHRwczovL2tleXNlcnZlci51YnVudHUuY29tL3Brcy9sb29rdXA/c2VhcmNoPWph
bWluX2xpbiZmaW5nZXJwcmludD1vbiZvcD1pbmRleA0KDQpUaGFua3MtSmFtaW4NCg0KPiBUaGFu
a3MsDQo+IA0KPiBDLg0KPiANCj4gaHR0cHM6Ly9saXN0cy5ub25nbnUub3JnL2FyY2hpdmUvaHRt
bC9xZW11LWRldmVsLzIwMjItMDgvbXNnMDIzODYuaHRtbA0KPiBodHRwczovL3dpa2kucWVtdS5v
cmcvS2V5U2lnbmluZ1BhcnR5DQoNCg==

