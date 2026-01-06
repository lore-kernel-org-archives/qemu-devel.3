Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B967C47BCA
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 08:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd2q5-0008Fb-TF; Tue, 06 Jan 2026 03:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vd2q3-0008E7-4o; Tue, 06 Jan 2026 03:54:51 -0500
Received: from mail-japanwestazon11022122.outbound.protection.outlook.com
 ([40.107.75.122] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vd2q0-0003he-QF; Tue, 06 Jan 2026 03:54:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMfq+j1h+AnqGeDQVBSaIgNB3+nuHRhhjVBmfM9dsNqOSB0TpEDlHHklQK8B78ZhDdVk6O7KDiUxU1YIC5G98eZ+yC1ksSrgDfj/WlXW+kuCXjpRw3lChJjDdxq7RaxuIbzJT8fmi+oZrgle80z2CA5jXLYHCs2UuRrdLb9MjezTAyDHxJGj3KH9ZlfIyCoBLQjhWtQ+Tk2H/4cyoC1u/7dBQ2vCUd2Hf58lxa78zxEB/3/vf4EewlMRMeCXzIfS5FZJ+0sqShWaO0FL47gVcdTctFTJygmukpulI2XscVXOxqgIZbT7skKgE8V/eduZi7i+2DkrNjjpJqazx6liyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Khqe5Xao1PYROgjODFkpU7jUHG+3eDCvaEOCfg91qck=;
 b=NKDWWkQVcHtoCMW2ibIN74iWjsyrhEgF/mud+rEzWvNlNgfLp+dxa44VPwIFYGQCqqqSyIyGBNrbGC7OnsYyOVFZb2IMAcH/g/Kbhrl5yB6xWvp5Eq5TMaQTn9SUv17f63g3n3QmY2HUUhjYy/S93xHpAidnkknQY+SveVzvcT8Gqf73Qm9N3EymFdk50wZcDUnP3yc8LeIecOniGtQ6RdL/ptWUSmImh9sHDZuTo/7DMqZbAjeCkXJs5j2KvJNbYC5kzWQ5cKWUI7v4GQzlo+Zd9x/q2xhIU7rRpcDtRif394QMfvZbXG3cSM3J/cWwVhQNoRL4oeH397JFmewBCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Khqe5Xao1PYROgjODFkpU7jUHG+3eDCvaEOCfg91qck=;
 b=GaNK3K21X8jBu8k8n9k5hR/YZlvy38QYjuHkuCyz3yd4OoMLszBXc4vQ4l+nqVA1BC45LruzEHgEk6p0uhZ1GoFgGV4qdtvRDFqMFVjxYSDkXHdm0oaaPeIh3huYKr0zEWOCVpHLJq8ZCzA9OikQPg9V5YDubX1mcFF1MnmimtAMqQAkpQdHcUuu2EBdpcF1psG6xLtc3VY/biYLIPOMUp+iKqXT65m9pos/vYj4/0W2k+sA/6ViuhG1jcxJKS6hCsoAtXMF89TaNMKS97JjB//EIzPyDA2f13vsYI0x/3mAayj5WzcF5Kws8R+3wPe8Ul7/8JfbF85VTjIG2lNolg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB6559.apcprd06.prod.outlook.com (2603:1096:990:2f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 08:49:40 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9478.005; Tue, 6 Jan 2026
 08:49:40 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joe Komlodi <komlodi@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "venture@google.com" <venture@google.com>, "clg@kaod.org" <clg@kaod.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH 14/19] hw/i3c/dw-i3c: Add ctrl MMIO handling
Thread-Topic: [PATCH 14/19] hw/i3c/dw-i3c: Add ctrl MMIO handling
Thread-Index: AQHb2/a/CKdmOA90xEWOd1bOSEjaPrVGGquQ
Date: Tue, 6 Jan 2026 08:49:40 +0000
Message-ID: <TYPPR06MB82061C921B6EE0DDE479706AFC87A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20250613000411.1516521-1-komlodi@google.com>
 <20250613000411.1516521-15-komlodi@google.com>
In-Reply-To: <20250613000411.1516521-15-komlodi@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB6559:EE_
x-ms-office365-filtering-correlation-id: 1905571b-aa21-4f7a-eff3-08de4d008769
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VWlOS05WMGlCejl2WXpSVTRpNFlCanJyY0E0ek8xaEk3dnFmN1d0YWUzQ3hq?=
 =?utf-8?B?REpqMmJJL3owMHgwbHU1b09ManJ0MXk4dzQ3T2lpYmlrL0pSbUtQeFhvL1lu?=
 =?utf-8?B?M1BSQjZRTTBUa0ZsM2U2RzlkSjI0Skg3QjNxUFFBblFmd1ZrUWc4cXN5Sm5R?=
 =?utf-8?B?VUFqNk9Bd0E1b2x3Z1VFYm41RTJ1WU9MRXMzWFZQbVJiamF0SW8rU2J2TkNs?=
 =?utf-8?B?K1ZvVEIrMENidmRCdTRBWlJadkw0SkJ0N2taQnc4cW5uTzdITjc4ZE9tZXpr?=
 =?utf-8?B?VnZqaDdOdkVZdmVuVDhuVC90dFBpNnNKWGhmUTJBVjVlQ1dLOGR5YkpWSkFY?=
 =?utf-8?B?V0VZQTVqLzFib3NvSVNJT0FvQmx5UHNSbUVBL0U0K1JRYU9yVmFTWmVyS2kv?=
 =?utf-8?B?VmlLOFU3Tys5MWVwOS9PaEJ1cTgvOXd1TzlqYlBNOTdOcEFlVlZTaWoxWmw0?=
 =?utf-8?B?MDdYSjVqSHFYZ3NQT2NTMDU0ekdsQk43cTVWN1N4OFVLYzRVc0hJa2EvdUN6?=
 =?utf-8?B?NFZmQWtJVEdiS3dDY2w0dmFqSlp4cTRocHRPb2diU09xQkNJT0dBRHVVemE1?=
 =?utf-8?B?eWVKYkhsUFN5dUoxeHFBQlI3UXpXdXY5N284aGFKaGJsbUlQYWl1VE1jaU4v?=
 =?utf-8?B?dmdrTjh3Z25hUVFxM0c1bjcrdks4dU92ckthZXkvYnpmdHgwMzhaRlhFTXNh?=
 =?utf-8?B?ZzJFeE9nZ285V0J5WGh6L283S0h2ZmE4WVZZRTZxNkROcTU4NlF6WTA0Ym00?=
 =?utf-8?B?bjd6M3YwbXpZVDNaK3JvRHdZSG5IaDA2M1gyd0VtUnF6aXEvWTArM1lud3A4?=
 =?utf-8?B?M3NsWkFieGlmWVRmaTBkRDFvUEdQWTFucmx3WjM2RkhwOGhmN1VsM2VjK3Zr?=
 =?utf-8?B?NWtQcG5XandJck10SmNvaTNpRW5xS1VVQTFVaSttZjg5K3A5Yk5FUVZOdnVM?=
 =?utf-8?B?WE9heG1pME0wcGdXSWI2N2FLSGFYa0orNEo5NzU0REVSSWRRWFN6UGxkcFdy?=
 =?utf-8?B?eUJVYmFmWDVEREJPZFUxVXFZWlJtL2xxcTdzMDhVRXRFU2krYk5ueEcrWklT?=
 =?utf-8?B?VG5tdE50VnMxY3RGWlNXNXZSYWpGT3h1cWtPVVVtZVBOVmhueGFWc3FjVXpa?=
 =?utf-8?B?UVU5UHhONkU1VElJU2pKWlc2bFVwczJOL1VpUFVKSGlMMzJiUi9zbmZqcDhP?=
 =?utf-8?B?Wmg2MEdQRk5tSEp2ZzgvWW9lQnlPMGhxMDRDVmg5Q05uSUVzZGtPWDk3REhs?=
 =?utf-8?B?cFpOVXg1ZjhuZWduUnZ5bnp0cSs4UEV1NmlpT3c3eksvSUlycWVZVkx5cWdi?=
 =?utf-8?B?bUhaclRpR1FyLzJ5TXpmN0dSb240ditjekMwY2txalZiVmRPVGNmQnlWWGJX?=
 =?utf-8?B?Umo1WE5XYmJEOThSR25QRHZwR05tZ2RnNkQ5SXh0YmpMUHJQWHNCeFVYWW5J?=
 =?utf-8?B?NVpmS09JSGRoU1psQmMwRHlGK01jTlcyQ0tqR0RLUGlLNERySmRYR0NPRUxj?=
 =?utf-8?B?OFAzbkRkeCtPWXZkYnhseHVzc0N2aW9ETHUrYXZIZm1VeW1lT1o2VENXTlc2?=
 =?utf-8?B?NVo4MDdlSEpGUy9oUXhkdEQxMDBFZXpucUdSVHBVdmJreW50dk1TdkVRZS9n?=
 =?utf-8?B?YWZMMmdSYll2MUlTWm5NWmYrV1Q1WHBZb3JSSldLaVVybTE0TFNqZmVSaUpL?=
 =?utf-8?B?L0pBMjVkUHVUOEFmTWRiMERpbXNySUE1UDBxOVhUTG1iaDdjWmJUd2ZzMjE0?=
 =?utf-8?B?TURFR1dCWTBrRXQwVEVDVktpY0NiUWRaOTdwMmpHRC9IaGVIaE93QkF1VjdJ?=
 =?utf-8?B?cUpyQW1pNVNUZHFyY3dtNVVwYm5WYWZmSFZEcWx5a1JLOGdBd2JvRUE5VnRF?=
 =?utf-8?B?eFFiUXIySnZ2SEFBNGxXbDIrbWtobWlWTEhWQ1NiTmZqWldCRGFBRmFvVHdP?=
 =?utf-8?B?M0pUQStUSVJLZmVTam5SWUlxbnUyUUpzRmRTZTJxWGxQNUhOYmRXWDdzNEhx?=
 =?utf-8?B?MVJvTVEwQlRjOXV4UWgrZkxieHFXNGEwRVJMWC9sajdwdjRBVXpNcnBVbnZ2?=
 =?utf-8?Q?TspGFW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkdJd3V2dDBNbU9ZSFNIY3lBL0l5S0tyWEwyODFaSm5lcE5CVGVTbzM2MEtu?=
 =?utf-8?B?Ykd0NFN2N25uclRvSHZIV2g4WDVlb2IvZ01GQ216czVSMU9nVi9EdHZkRi8x?=
 =?utf-8?B?QlJLVEVFbnBjWElXTEw3b0JyTmtLNUJjaENBUFd6ZjlBUmxBR05ZekNPVU96?=
 =?utf-8?B?akJhUzdwSWpHUFdFSWhwMnhSWUVlYklkQVVTZExHQXU1NUVlSVlQUUN2WCtH?=
 =?utf-8?B?a1RsOE1RYkN6NllMSHp5OEZpQVBOUWxBL2drMmVZVElZV0tEVFV2UCtyb3N4?=
 =?utf-8?B?VmVCMnBEeTk5RzRJNXpvOGlkU2RjMVIrUnMvR2NpMDRqRkx1LzJYRXVEU2JS?=
 =?utf-8?B?a0xBdGxhR3hUZm1lbTE0K2xQS0F1M1VSd3lVeUYrWEFraWVxODBUb050cTFC?=
 =?utf-8?B?Q21aL3NoT09rUUNtYkU4NnJsSVlDc3M0SWhtSnVsWmw4T0JKQzdTeVpKSDJG?=
 =?utf-8?B?Ymk5d0pGa0s5bElsamdrL3oyZlF4R2I3SUJyRG9VeEk0ckV6emtlK1pyVVJO?=
 =?utf-8?B?ZkJXTDBYdG5tZ3gzQlhyTG96N0hiSUdKRlRWNS9ibkFEWlRSUW1HNlUzVGt4?=
 =?utf-8?B?VmN2ajFzNExpaDZ4bzVBa0FzRnk4RUVJWVBSdjNWbUdWMXNWMitSQWd5VlNy?=
 =?utf-8?B?U21pcGhSODRpWENHZTFGZ0V5b2ZSbzRQYUdMa0ZpSWtrMHMyV1JRazVmbU1G?=
 =?utf-8?B?cVcwTTdaRFFtVnE0YjdEcTVlRy9CNFNTb3ZaZ1JJb1ErcGRtNjVzb0ticE8r?=
 =?utf-8?B?YWpJaGJ1S3gxZWFMUW9ZVCtIdklpNHI0S3NpVS9nOVhRMklrODU0dXZEdWdi?=
 =?utf-8?B?R3VpQW9iN3FjZFM3bDdYemNPcnR4YTNNQ1dJV2ZUbFNZNXpWUUN2WTl0bFJz?=
 =?utf-8?B?U2lFcVpIdTJiN0hOK3hGZFR0U3B3UmtZSllCd3VLSmYzMVR1Sm12OTFCUW4r?=
 =?utf-8?B?QVgvQ0FIeTVBaHh6b3lFbmJBSFpwaVBGOHltM1lvYm1CMWhBZExOcHM1dHpa?=
 =?utf-8?B?Qzc5ZE9OZU1aOXlwKzcyb0JaZUtzbjMvSUYwVExPZFdQa3VtblUxYnJlbnN2?=
 =?utf-8?B?bXVTaGdGZkpXRDZzay9EemVjTENUaEliNU1pZUJXdElMeGFtMjhZM3RybSts?=
 =?utf-8?B?ZUVnL3ZXNU1iOW9ob3VJZE9wQ2RXVkRVWWtZM0hVb1M1T2hINUZHc2JaV1lw?=
 =?utf-8?B?RzhiSE1DTDhFaDYzMUJxMVpUNWxmSDhNU0JQeE5tUEFZV2JHT3ZqQ1FYdGp3?=
 =?utf-8?B?QnphZXEyYWcwUHh0YzQrZFRmNExOM0RKbjFMR3VXSjROdDVQQXk0TEVjNEhz?=
 =?utf-8?B?ZG9xZ0ExSFJQTXZQVU1xT2cyc1l5SktuL0hNSTk3RnFZcHVBSUlsTjFpN2Jk?=
 =?utf-8?B?aDBadkVaMHh6QjRtc1B1VHRtazNJS1FheitDSUpYRitOd09XZGRka2VST3FS?=
 =?utf-8?B?d2ZzMHk2akU4NVowTjFHZjBvZ1pQbVlwdkJVTFhyUG5mbGoyUXU4cVF4KzdX?=
 =?utf-8?B?YzFZWlZ3R0tvR3ZsQnZuOVZ5QzZJcld2STBBNzVQTzB1YmtHUzJTeUdaTC9H?=
 =?utf-8?B?Uzl5UHhTMzhTY1NsRmVUSFR3NVp5dzVadGpoVnZMMkxNYURmc1MxYmNYQk1S?=
 =?utf-8?B?TW1KN1d5d3pwdlY4bnZFZ3dXSUQzOWtWck83ZjRQWnRzWWNpNWtqaHhXNVVD?=
 =?utf-8?B?SEwvZGZ0aFBtcTBhOUVrZFRQZTdXT0hTK3FtNWo3Q2d1c0ZsVTZQQ0NRWW1s?=
 =?utf-8?B?RG1CSlpLUk1Kei8yRjRQNldlM3huaHlWb3dhMmQxK091K0JOd2dRZnpSVkxQ?=
 =?utf-8?B?Rmk1TnVlbTVOZElscDkwb3JaVXIvQ2RuWlVhZ0lXbk1oWGVEZ3FpbnJ3TVIw?=
 =?utf-8?B?MVEyVnp3ZnlzVzVJL1dJenBOaWwvbFZ5cmZoRWpTRFh2MVJhcVZmLzZ4ZGtJ?=
 =?utf-8?B?STRDSEhUWDBRaVZCUHlzd3FmZmJZT3BHMFJ1ckkzMFhYcmdMZ1F0VmJKMWtu?=
 =?utf-8?B?SDJQVGdSV2h6bngxMi9MUVVaVGcwcGExdVZwUXQwTjN2N0VoejVDSGhIQ3l5?=
 =?utf-8?B?VmhLUldnWWQzN0Q5NDNBdVQ2YktpK0JhOHRBNlhuT2w3d0NnU2dsbTFaRnRh?=
 =?utf-8?B?Mm5VTkozbWRhRXkrOW5EUUlKOXN0MUNNS1VYYTZTbzBqd2xOMXJHUXZFb2Jw?=
 =?utf-8?B?YXZOQUlxMW1kYjB4dFo5OWhRUmY0QzMwVlVoUGl0SFdjMzh4ekpwY21uclhT?=
 =?utf-8?B?SXdFNllNZXZwUU9mNGs3Ty9PTHFJRkdpMG45cnh4YUVDeGlzWXdEZzFobEMr?=
 =?utf-8?B?Si9ZMDdLUUxFaW5tTHNZODdBUm5pVk1DRmhHOFBSTkc2SE1XWDZsZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1905571b-aa21-4f7a-eff3-08de4d008769
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 08:49:40.0228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UG/lLaFGNQ3j+U3n/i2c6hswVlM5ZsIYYuiLd8X3+onviaOVla/P/zuq2AgQZn+wBRbNV5lixbYfJ+6M+h7RBGcr3CWnOTzhVrbI1TsZKq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6559
Received-SPF: pass client-ip=40.107.75.122;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

PiBTdWJqZWN0OiBbUEFUQ0ggMTQvMTldIGh3L2kzYy9kdy1pM2M6IEFkZCBjdHJsIE1NSU8gaGFu
ZGxpbmcNCj4gDQo+IEFkZHMgZnVuY3Rpb25hbGl0eSB0byB0aGUgQ1RSTCByZWdpc3Rlci4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEpvZSBLb21sb2RpIDxrb21sb2RpQGdvb2dsZS5jb20+DQo+IA0K
PiBSZXZpZXdlZC1ieTogVGl0dXMgUndhbnRhcmUgPHRpdHVzckBnb29nbGUuY29tPg0KPiBSZXZp
ZXdlZC1ieTogUGF0cmljayBWZW50dXJlIDx2ZW50dXJlQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAg
aHcvaTNjL2R3LWkzYy5jIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
aHcvaTNjL2R3LWkzYy5jIGIvaHcvaTNjL2R3LWkzYy5jIGluZGV4IGM1YWYzMzFhYzQuLjYxODQ1
YzkwOWYNCj4gMTAwNjQ0DQo+IC0tLSBhL2h3L2kzYy9kdy1pM2MuYw0KPiArKysgYi9ody9pM2Mv
ZHctaTNjLmMNCj4gQEAgLTM2MSw2ICszNjEsOCBAQCBzdGF0aWMgY29uc3QgdWludDMyX3QgZHdf
aTNjX3JvW0RXX0kzQ19OUl9SRUdTXSA9IHsNCj4gICAgICBbUl9TTEFWRV9DT05GSUddICAgICAg
ICAgICAgICAgID0gMHhmZmZmZmZmZiwNCj4gIH07DQo+IA0KPiArc3RhdGljIHZvaWQgZHdfaTNj
X2NtZF9xdWV1ZV9leGVjdXRlKERXSTNDICpzKTsNCj4gKw0KPiAgc3RhdGljIGlubGluZSBib29s
IGR3X2kzY19oYXNfaGRyX3RzKERXSTNDICpzKSAgew0KPiAgICAgIHJldHVybiBBUlJBWV9GSUVM
RF9FWDMyKHMtPnJlZ3MsIEhXX0NBUEFCSUxJVFksIEhEUl9UUyk7IEBADQo+IC01MjAsNiArNTIy
LDM2IEBAIHN0YXRpYyBpbnQgZHdfaTNjX3JlY3ZfZGF0YShEV0kzQyAqcywgYm9vbCBpc19pMmMs
IHVpbnQ4X3QNCj4gKmRhdGEsDQo+ICAgICAgcmV0dXJuIHJldDsNCj4gIH0NCj4gDQo+ICtzdGF0
aWMgdm9pZCBkd19pM2NfY3RybF93KERXSTNDICpzLCB1aW50MzJfdCB2YWwpIHsNCj4gKyAgICAv
Kg0KPiArICAgICAqIElmIHRoZSB1c2VyIGlzIHNldHRpbmcgSTNDX1JFU1VNRSwgdGhlIGNvbnRy
b2xsZXIgd2FzIGhhbHRlZC4NCj4gKyAgICAgKiBUcnkgYW5kIHJlc3VtZSBleGVjdXRpb24gYW5k
IGxlYXZlIHRoZSBiaXQgY2xlYXJlZC4NCj4gKyAgICAgKi8NCj4gKyAgICBpZiAoRklFTERfRVgz
Mih2YWwsIERFVklDRV9DVFJMLCBJM0NfUkVTVU1FKSkgew0KPiArICAgICAgICBkd19pM2NfY21k
X3F1ZXVlX2V4ZWN1dGUocyk7DQo+ICsgICAgICAgIHZhbCA9IEZJRUxEX0RQMzIodmFsLCBERVZJ
Q0VfQ1RSTCwgSTNDX1JFU1VNRSwgMCk7DQo+ICsgICAgfQ0KPiArICAgIC8qDQo+ICsgICAgICog
STNDX0FCT1JUIGJlaW5nIHNldCBzZW5kcyBhbiBJM0MgU1RPUC4gSXQncyBjbGVhcmVkIHdoZW4g
dGhlIFNUT1AgaXMNCj4gKyAgICAgKiBzZW50Lg0KPiArICAgICAqLw0KPiArICAgIGlmIChGSUVM
RF9FWDMyKHZhbCwgREVWSUNFX0NUUkwsIEkzQ19BQk9SVCkpIHsNCj4gKyAgICAgICAgZHdfaTNj
X2VuZF90cmFuc2ZlcihzLCAvKmlzX2kyYz0qL3RydWUpOw0KPiArICAgICAgICBkd19pM2NfZW5k
X3RyYW5zZmVyKHMsIC8qaXNfaTJjPSovZmFsc2UpOw0KPiArICAgICAgICB2YWwgPSBGSUVMRF9E
UDMyKHZhbCwgREVWSUNFX0NUUkwsIEkzQ19BQk9SVCwgMCk7DQo+ICsgICAgICAgIEFSUkFZX0ZJ
RUxEX0RQMzIocy0+cmVncywgSU5UUl9TVEFUVVMsIFRSQU5TRkVSX0FCT1JULCAxKTsNCj4gKyAg
ICAgICAgZHdfaTNjX3VwZGF0ZV9pcnEocyk7DQo+ICsgICAgfQ0KPiArICAgIC8qIFVwZGF0ZSBw
cmVzZW50IHN0YXRlLiAqLw0KPiArICAgIEFSUkFZX0ZJRUxEX0RQMzIocy0+cmVncywgUFJFU0VO
VF9TVEFURSwgQ01fVEZSX1NUX1NUQVRVUywNCj4gKyAgICAgICAgICAgICAgICAgICAgIERXX0kz
Q19UUkFOU0ZFUl9TVEFURV9JRExFKTsNCj4gKyAgICBBUlJBWV9GSUVMRF9EUDMyKHMtPnJlZ3Ms
IFBSRVNFTlRfU1RBVEUsIENNX1RGUl9TVEFUVVMsDQo+ICsgICAgICAgICAgICAgICAgICAgICBE
V19JM0NfVFJBTlNGRVJfU1RBVFVTX0lETEUpOw0KPiArDQo+ICsgICAgcy0+cmVnc1tSX0RFVklD
RV9DVFJMXSA9IHZhbDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGlubGluZSBib29sIGR3X2kzY190
YXJnZXRfaXNfaTJjKERXSTNDICpzLCB1aW50MTZfdCBvZmZzZXQpICB7DQo+ICAgICAgLyogLyBz
aXplb2YodWludDMyX3QpIGJlY2F1c2Ugd2UncmUgaW5kZXhpbmcgaW50byBvdXIgMzItYml0IHJl
ZyBhcnJheS4gKi8NCj4gQEAgLTE1OTIsNiArMTYyNCw5IEBAIHN0YXRpYyB2b2lkIGR3X2kzY193
cml0ZSh2b2lkICpvcGFxdWUsIGh3YWRkcg0KPiBvZmZzZXQsIHVpbnQ2NF90IHZhbHVlLA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICJdID0gMHglMDgiIFBSSXg2NCAiXG4iLA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgIF9fZnVuY19fLCBvZmZzZXQsIHZhbHVlKTsNCj4gICAgICAgICAgYnJl
YWs7DQo+ICsgICAgY2FzZSBSX0RFVklDRV9DVFJMOg0KPiArICAgICAgICBkd19pM2NfY3RybF93
KHMsIHZhbDMyKTsNCj4gKyAgICAgICAgYnJlYWs7DQo+ICAgICAgY2FzZSBSX1JYX1RYX0RBVEFf
UE9SVDoNCj4gICAgICAgICAgZHdfaTNjX3B1c2hfdHgocywgdmFsMzIpOw0KPiAgICAgICAgICBi
cmVhazsNCj4gLS0NCj4gMi41MC4wLnJjMS41OTEuZzljOTVmMTdmNjQtZ29vZw0KDQpSZXZpZXdl
ZC1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQoNClRoYW5rcywNCkph
bWluDQoNCg==

