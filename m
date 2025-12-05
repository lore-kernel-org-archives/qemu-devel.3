Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B8BD2CDF2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 01:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRKeU-00016v-VN; Thu, 04 Dec 2025 20:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vRKeK-00015Z-0o
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 20:30:20 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vRKeG-0001Vk-MU
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 20:30:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=buB1LpVLi+V+Psde5B/g27Z3FthBfxXz+mpv/4ETempjLrnOMrDLgi8yZYZHxScAXjD4xwQFJ1ArbvOX1+7iHm5XuLvOkELx2F6kKfO8IcuIUb6gfw2f1Wk9vULWw8Zyf784Aky4jNk+nsUeDGVvWSa3+5jO1R5ZBjE06hV3l2y+YPHzTOEebcFHzc7ALzlhj0nT2XoZt/oUrNXZ78fWEZykwtIWSgZ56182o0Ru5fhMoGOK2QWZhGF9grGMtya6LQrUYw2AA+oqt1ygoE7XpmdT+kzcCZvGq5sJWwLKO3/B/aCa0lV90Q6Wl/P0+ho4yBEaEh5EdWl3g/vRvuqw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYrDbfz1tCDkJOvZkH6+5qBZLTWOC9JZ5UVu19Onc6U=;
 b=iwL1MYrV4Jtw94WwirNvw18gBQN9B5R7hgzsCMSXrTokpA1K8ijwmMcFljgFysqaLoEP3p286qdgbXXvvCLilwmCo6zD02HPJmgsSaAwKm/4rC/6aPnOfO22ZMVuZc2hA0Nva7ZyBTbb3s2HoMM/dUIcP0nXkmfj/f6+M8gqUHyX92BhTQzVKNdmLBir29CHhsTCcI2zjJNQWoSDPcJNbVhYbOZP36pW66pJq+vt7xIODWkJDqNLJE9fzc8yq2KdpJrK0XJvSkpyFQtwTyjh/jooAorenFsVNBmefquYoR4GfZuHYRtu3gGM6d3PHlv0JZJI1mJMPpjhH48XQIIuXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYrDbfz1tCDkJOvZkH6+5qBZLTWOC9JZ5UVu19Onc6U=;
 b=BKygQ2Ti+6ifG+dTfYldanhXuMJCVPGpzX/9qa0eQr3reZDgJh4jBBfSOlz7MhijkElb+FxF9TMsjvWy3IrTfuwFL2k9tSPc1oqoDIq/5KTLQbb4umcMEpLp+fIPwes0SME3ALZKnSCu4CJEUunptKAW8wRhlxvyajytl+uhfXxtHyRZKqOHgea4YLVHvNoZcm9FmfTNVwtyjppXXPcEOQjz3xi5DTFBaWz2YZPbPJpxe7eCI/E+4iutxOsdLOAgqvCWqPKQneJpsH1u8XdSIhp3N4xHYNmD+ArSy/ZMFGOzfag6fI+Q1HMF+9ASH4elPcazY8sY5wetjRDW9jk1qA==
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by TYUPR06MB5928.apcprd06.prod.outlook.com (2603:1096:400:35f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 01:30:07 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 01:30:07 +0000
From: Wafer <wafer@jaguarmicro.com>
To: Jason Wang <jasowang@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "eperezma@redhat.com"
 <eperezma@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "leiyang@redhat.com" <leiyang@redhat.com>, "sgarzare@redhat.com"
 <sgarzare@redhat.com>, Angus Chen <angus.chen@jaguarmicro.com>
Subject: RE: [PATCH 0/4] Add Split indirect descriptors for SVQ
Thread-Topic: [PATCH 0/4] Add Split indirect descriptors for SVQ
Thread-Index: AQHcZPD5WkV7e0JOJ0WPp/8vzdvjrrURHROAgABRDfA=
Date: Fri, 5 Dec 2025 01:30:07 +0000
Message-ID: <PUZPR06MB471395120934B469F9315B12A2A7A@PUZPR06MB4713.apcprd06.prod.outlook.com>
References: <20251204073750.8953-1-wafer@jaguarmicro.com>
 <CACGkMEtsPO+aAk2cMCE75_RjWFGedHdfMr0NmX5hR7MQophJfg@mail.gmail.com>
In-Reply-To: <CACGkMEtsPO+aAk2cMCE75_RjWFGedHdfMr0NmX5hR7MQophJfg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB4713:EE_|TYUPR06MB5928:EE_
x-ms-office365-filtering-correlation-id: 4a8a87ab-5988-4788-ba8e-08de339dd2fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UnhxSzkwcjk1SWg0ZWRZbXlJQk4rQ1BsSmUwQytLR2RUVnFpOUcvZVJtaG9S?=
 =?utf-8?B?dnlZSUtHYmtTTnBOUFNjWVEzWFpuT0F6cEhVYXovZFBJSG8rRzFkWFpHemxP?=
 =?utf-8?B?V1F2TGZoYjMyRDhTbHg4TVY5aGZieWM1eElNc21vY0tWeWNqTU1vZ0djdC9F?=
 =?utf-8?B?Y3dMOUU0ZjNOSkZ6QVZKN1Y2azJmQnFvU0txNk9ST1ZSM1YvSDVCM21LVjFL?=
 =?utf-8?B?OE1Dem44RE1RcHVBOGt5Nm1lOWhXbjgzM0IrbGc4Z2huRmFCZGJKYU5DMVB0?=
 =?utf-8?B?WVJ4Z3I1OHcvT0xNMnlMOXlCTUFtL05rd1BjTkZmK1k1YWZBeEdaT1dpRVR6?=
 =?utf-8?B?ckR3UTI2VzZuTU55US9CWVM2Vk53c3Jxd0F4T0xqU3pEMDNxK1ozdkNwWXFZ?=
 =?utf-8?B?SGNva3F6WTd2MFV3eSthVndMYUdpY1lqeVFQUVBHU0NhT2tkV1FicUdUTklK?=
 =?utf-8?B?Q3N6cnNpL001UU9qNlJHVGx4ZUhNZDEzTmlKSE0zSFA5YzBCVHM4ZlliTWtD?=
 =?utf-8?B?cHI1akIxT05EamVWWk5tSzBFQWVEU3BSeDdBQ2VjcjdxaWc0SUZsNzlGa0FN?=
 =?utf-8?B?RzhsYXAzY2dadU1nSW5HN0hLaDI2WmhJZ2V4aUZZaW9TblE5NTk5SHM1MWNy?=
 =?utf-8?B?b0RXVTl5SFh3TEJ6MWVQQW80N0RvcmVZUlViMGorSDlKUDl4WHNhWTlONE5H?=
 =?utf-8?B?czVabGUxbEFKcllBZGhYaXZpRDZRbnEzV0xGK3JxK0tBaUFBbytxTGFIZEFE?=
 =?utf-8?B?VHMza1JRcVIvS0U0aGtpTXhEaUkrK1BXOWhxTVFXd25XaWRHa0Z5NXZJeEdB?=
 =?utf-8?B?ak1SeUlka3QzYUxCRlZjTUJDdEtQN2dNMEZ4RmhpWnRKOE5MVVk5aDE1aUNu?=
 =?utf-8?B?MHlrSHBhQmF2dzRWeEU0MmFLY00rZkFDd1pxelNVRlRsa25qa09iQzB2US9i?=
 =?utf-8?B?aGpjaVMxVzB1bm12eS9qUzVXQTU3YkhFdnc1ZWRhUis5RzhXL01FSU5iOXFO?=
 =?utf-8?B?K2w0MzIwTmZzMDdvTFE3eXFURmdndkFXV3FkL2pMY0lMTGxPcUE3UXNkeWFP?=
 =?utf-8?B?UzNMZHBGdEo3Q0tDL2IzTEo1Q2U0MFJqcHpUUUN1VW1PbGpTUjh5alFwSG96?=
 =?utf-8?B?dHZHRy9ZdXI1bWFYWVZrV1ZuM0txMVhvYWlEN1VXNVBNdGdiOFJMUXo2bVJ3?=
 =?utf-8?B?LzQ2eXMyR1lhcGdEb213TTRkTGNGdTlCdmF0RjllTFZITTZFUzlDNzlxR283?=
 =?utf-8?B?dElzbUNRSUpnRjFIcUdreG1vM1dwT0tJUERzTG52YlhnZzBzOVQyaTRpWGkw?=
 =?utf-8?B?Y3JjT0hXQXNHWFp6NU9JVnprMWZlVzZtdDdxNzUwTmphKzU0RmNJTzhHdDlE?=
 =?utf-8?B?YnIzN0VNRkJXMklhY2Jpd0M1Q3pMUFZNejNJVjFoKzNvczhMOC83OXdHYkZB?=
 =?utf-8?B?N09jekVWdWhsSGc3dEQ3SEx2NWtEVmNWWllQTVR2dzVINzhMWmQxVG8vM3N4?=
 =?utf-8?B?VWprUW9jdXU3SThoSnNRTkpCN0s0d1A2Q2JsWitpSGc5YlhiTHBJOVVxdnoz?=
 =?utf-8?B?UWpwTUIzRmdJWWNxbGpCazdpZmg4NnBuTm5RcnJVWGFqenZTMGxRUzVxcTdq?=
 =?utf-8?B?dzdZVVhDSWp5QXJtNEZrQXFUTHRlV0hHV0ZsRGh5ams1VXhRN3kxN0Z4dGRQ?=
 =?utf-8?B?bWlJemlUTkg5MTZ0UEwxODJXMHNwbWN3djVLYjFhU2k0aDZaRTdGZExzendU?=
 =?utf-8?B?SjEyMmhGYnkvdDVxN2JPOHpRWGhCdk1JMUwrUjhpRE5KWGxPclVIMjNtdVgr?=
 =?utf-8?B?Y0RjTlFHejRCdFBHdDV4SUNtMUNVb0xkSWRCMU5OS0Z4ZTRYZk5MSEgvUkJ5?=
 =?utf-8?B?TEdNN2ljaE45aFpYcTg0NnFaUTZjR3QzSEFDak9DNUEvTjVxeFg5emw5WXYy?=
 =?utf-8?B?Wk9samFHN0dBeTdTNkZZd3pFOU4zSWcxL0piYS82RnRaLzFSS2R6dmY4U01t?=
 =?utf-8?B?VGM3dlVKODNudFdIQUhuOFQ5WjRYQ0RROTk3Ry9FcEZISkl6UVRJNENQc0Jl?=
 =?utf-8?Q?HD4DMn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTRmeEZNb2hVUHo1N0NNM0NLVmZSVTMyMU4yclAzbWN4VElvaXlkQy9CM2pk?=
 =?utf-8?B?UXo4M0ZnMXlhWnlHbUptdEFJbzZJZHhwMGNhUCtrbEUrT2ZLS0FpSHRLWU10?=
 =?utf-8?B?RVZOczM5STBvYWNicnU3bm5IUmQvc0lFamxLWGZoYTVrbTFTZ2JGWDZkUDdn?=
 =?utf-8?B?dWYxK25oLzlZTHJob1RkYXV0UVlLOWp5Mmkzb095T0tjdjZjaFlQRnl4ckR0?=
 =?utf-8?B?NG1XcnhCYnhYOVNLcnBXWE9jcytCNzZJZHZiNWh6MHBtK1BZUzEydGZkUGpo?=
 =?utf-8?B?S2ZIOHJERDNNalBteFZDaWwwNWxjOWpFaEVvTWZoRGRMTmFoUHJuZDEvQkFR?=
 =?utf-8?B?Y3ZaSXRVRkU0T2dnWnFPdHRwSXJRaXVGUEM3Z1RmQ0FJNWNXdEY4OHdOV20z?=
 =?utf-8?B?elBkQk9jN0JlVVpqR0YvUTNKS0Q1Mnp5aFNHcFBrSGduL0RSMmh4a2d2R3ZT?=
 =?utf-8?B?c09IMTV2Q013VjNxYk00ZDZLdDFHK3pGWjNvQmhiakpqZTgybkZGdW5OU1R0?=
 =?utf-8?B?eUJDWFNVTW1OV3BOOW9YL01HR0dHVmw1NGVlTktXRGN3NTlaTzhjR3BoODVD?=
 =?utf-8?B?VFQyOXNDVW1hV1gwQURyOFUwZXFEamREbWJUOWswR3M3OHUyTWs1emZXZE9R?=
 =?utf-8?B?dG1IVE11MUlmbmZ4QWhzcnJ0eWVsMFJLU0RMVHp6OW9sNzlCZE95UkxLVVVU?=
 =?utf-8?B?ZldTelNUNEZKazNodHpDNGtIZFpKWm1ESllqOGk5MWQ4aG83Mnl0b1lpRXNQ?=
 =?utf-8?B?TkR2R2k2eDcxRzk5alpXeHlnbHhHbUdIOXllNmQ4YjdLZy9ZbG9tVHN6ais2?=
 =?utf-8?B?TC84WGQ4REdzajlOMjlieit6cjk4cVA1QVY2SFFRUjh5ZTlvRUdrdFhZRDBi?=
 =?utf-8?B?ZXQrWDFRNm94YzVDM20yRnNtTVhlaEVldDkrV2RFRGt5TXdrcUFXSGFJZ0lD?=
 =?utf-8?B?bmlZRnFsWFF6Y1o5YndXRDl2eUttaHVMbzZuKytvV1hzUmdyQ1ZiQUM1Wmg1?=
 =?utf-8?B?eEFGOW1memlCQ3k4ZlZFS0I3YWhmUHZJeXloRUZ6aTlZZUpKTURSSVN2Y3dR?=
 =?utf-8?B?TUhpcURwekg1QWdKMDRVam54YVFFWHZtVGZPalZLT3RuRXBYMDM3UFA2ZjRN?=
 =?utf-8?B?MUJERW40Zm5OalpxZjdhL0N1U3A0SXVuMjlvb3phRHlaNnNrVHpKZGRVcVMx?=
 =?utf-8?B?YlA1cmt4MFdKZ2JDU21VcmRWWEgwYnRXZ0t4YkxRN3orN2FLVUtzM08zNnlV?=
 =?utf-8?B?WWdINkFBaWx1dW50ZDZuMHkzYWYvb2hPbllCaWRob01wWi84SWJlcldoeVZw?=
 =?utf-8?B?S2grcUZQdEpWWFcxaGNKOXpwRHVGOXpMcmdENTRTU2tBUWMvb2gybjJBR0FO?=
 =?utf-8?B?ZEVTN29GTyszUTlWb0lYNG0yVkU4ODFNWGlsOXB3TXkxNDU1bXMzbVNwU1FW?=
 =?utf-8?B?S0FTYzFoOVBxWE11WnA3cHE1RmYrRlNDUS9jRW5SL0RlZDZiYzFyN28wR2NP?=
 =?utf-8?B?b0ZMR3NtcXJPNDJncng3REV4U2c0UGxoUWpVT2dOMkJaK0NpSXlVNHlmbEVK?=
 =?utf-8?B?cU96VkIxYXZmR094WkZiK2V2T3F1aHlEa3ZEUlZpL1Y4S2lqTnVPRmlzbmhw?=
 =?utf-8?B?OVM3YWVLeHFtRjJLNUtnMzVVNW4vRGZKT1FDcGo3elplSnJVZTF4ZklrMHNp?=
 =?utf-8?B?L2Jmdk1HYkkxMExZejVXV05aUXE2TC82TzdDVi8yQ0V2bTRlZmRKMUtTelRW?=
 =?utf-8?B?U0ZwNXUrQ1poWXl4aytoWGdlSVpXUDM2Rmk1Qmh3NEx5RWh2VGJVZUo5T1Iy?=
 =?utf-8?B?RENDQWV2WUZEL1JqaFF4bE94b0lGRUc0T3RkdVpMYWduQ2d2NzRXdzZ3SXBn?=
 =?utf-8?B?dkVYaUtYU2Frd3YxSWw4WU4zWVhVQ1d4QkdnNWt6Qmt6QjdXY2VRNUZuZG1v?=
 =?utf-8?B?Y2l2QmxsREtKRGMvWTZ4ZnVBaGgwajVIVUdDS3ViR2ZUQm5zUjZ6eW1nM2Vk?=
 =?utf-8?B?elZqWVNkbUNER3kvODlkYmdCRzFoeU1jaXhnKytHaDVRbFFMS3pscXdWRG5L?=
 =?utf-8?B?a0gyWlk1empSd0hXQ0REdFYvOU9tNm00anFpOCtKOGtSeHdOaFlJaTk3K05V?=
 =?utf-8?Q?M7unSy3LKTXuwzD/ZLasa+jcB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8a87ab-5988-4788-ba8e-08de339dd2fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 01:30:07.5663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfvoJGY4ZAY0w6gyFhXqya//u/bISuBl8ZpSroPxxzI/2EIqiUDwGOZ8EtyBy6IqdfQWSaVHN1GpsKoqxaSc+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB5928
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=wafer@jaguarmicro.com;
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogMjAyNeW5tDEy5pyINOaXpSAxNTo1Ng0KPiBUbzog
V2FmZXIgPHdhZmVyQGphZ3Vhcm1pY3JvLmNvbT4NCj4gQ2M6IG1zdEByZWRoYXQuY29tOyBlcGVy
ZXptYUByZWRoYXQuY29tOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IGxlaXlhbmdAcmVkaGF0
LmNvbTsgc2dhcnphcmVAcmVkaGF0LmNvbTsgQW5ndXMgQ2hlbg0KPiA8YW5ndXMuY2hlbkBqYWd1
YXJtaWNyby5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC80XSBBZGQgU3BsaXQgaW5kaXJl
Y3QgZGVzY3JpcHRvcnMgZm9yIFNWUQ0KPiANCj4gRXh0ZXJuYWwgTWFpbDogVGhpcyBlbWFpbCBv
cmlnaW5hdGVkIGZyb20gT1VUU0lERSBvZiB0aGUgb3JnYW5pemF0aW9uIQ0KPiBEbyBub3QgY2xp
Y2sgbGlua3MsIG9wZW4gYXR0YWNobWVudHMgb3IgcHJvdmlkZSBBTlkgaW5mb3JtYXRpb24gdW5s
ZXNzIHlvdQ0KPiByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBz
YWZlLg0KPiANCj4gDQo+IE9uIFRodSwgRGVjIDQsIDIwMjUgYXQgMzozOOKAr1BNIFdhZmVyIFhp
ZSA8d2FmZXJAamFndWFybWljcm8uY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgcGF0Y2ggc2Vy
aWVzIGFkZHMgc3VwcG9ydCBmb3IgVklSVElPIHNwbGl0IGluZGlyZWN0IGRlc2NyaXB0b3JzLg0K
PiA+IFRoZSBmZWF0dXJlIGlzIFZJUlRJT19SSU5HX0ZfSU5ESVJFQ1RfREVTQy4NCj4gPg0KPiA+
IEV1Z2VuaW8gaHMgc3VibWl0dGVkIGEgcGF0Y2g6IHZob3N0OiBhY2NlcHQgaW5kaXJlY3QgZGVz
Y3JpcHRvcnMgaW4NCj4gPiBzaGFkb3cgdmlydHF1ZXVlDQo+ID4gaHR0cHM6Ly9saXN0cy5ub25n
bnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMjUtDQo+IDEyL21zZzAwMDU2Lmh0bWwN
Cj4gPiBUaGVyZWZvcmUsIHRoaXMgcGF0Y2ggbXVzdCBiZSBhcHBsaWVkIGZpcnN0Lg0KPiANCj4g
SSBtYXkgbWlzcyBzb21ldGhpbmcgYnV0IHN2cSBjYW4gcmVhZCBpbmRpcmVjdCBkZXNjcmlwdG9y
cyBldmVuIHRob3VnaCBpdA0KPiBkb2Vzbid0IHVzZSBpbmRpcmVjdCBkZXNjcmlwdG9yLCB0aGF0
J3Mgc3VmZmljaWVudCBmb3IgbWFraW5nIGl0IGNsYWltcyB0bw0KPiBzdXBwb3J0IGluZGlyZWN0
IGRlc2NyaXB0b3JzLiBUaGF0J3Mgd2hhdCBFdWdlbmlvIHNhaWQgaW4gdGhhdCBzZXJpZXMuDQo+
IA0KPiBUaGlzIHNlcmllcyBjb3VsZCBiZSBhbiBvcHRpbWl6YXRpb24gb24gdG9wPw0KPiANCj4g
VGhhbmtzDQo+IA0KDQpUaGFua3MgZm9yIHlvdXIgcmVwbHkhDQpSaWdodCwgdGhlIGN1cnJlbnQg
c3ZxIGltcGxlbWVudGF0aW9uIGNhbiByZWFkIHRoZSBpbmRpcmVjdCBkZXNjcmlwdG9ycyBwcm92
aWRlZCBieSB0aGUgZHJpdmVyLCBidXQgaXQgY2Fubm90IHVzZSBpbmRpcmVjdCBkZXNjcmlwdG9y
cyB3aGVuIGludGVyYWN0aW5nIHdpdGggdGhlIGJhY2tlbmQgZGV2aWNlLg0KSG93ZXZlciwgaWYg
YSBiYWNrZW5kIGRldmljZSBpbXBsZW1lbnRzIGluZGlyZWN0IGRlc2NyaXB0b3JzIGFuZCB3YW50
cyB0byB1c2UgUUVNVSB0byB2YWxpZGF0ZSBpdHMgaW5kaXJlY3QgZGVzY3JpcHRvciBzdXBwb3J0
LCB0aGVuIFFFTVUgbmVlZHMgdG8gZnVsbHkgc3VwcG9ydCBpbmRpcmVjdCBkZXNjcmlwdG9ycyBp
biB0aGlzIHBhdGguIFRoaXMgc2VyaWVzIGlzIGludGVuZGVkIHRvIHByb3ZpZGUgdGhhdCBmdWxs
IHN1cHBvcnQsIHNvIHRoYXQgc3VjaCBiYWNrZW5kIGRldmljZXMgY2FuIGJlIHByb3Blcmx5IHRl
c3RlZCBhbmQgdmFsaWRhdGVkIHZpYSBRRU1VLg0KDQo+ID4NCj4gPg0KPiA+IFdhZmVyIFhpZSAo
NCk6DQo+ID4gICB2aG9zdDogYWRkIGRhdGEgc3RydWN0dXJlIG9mIHZpcnRpbyBpbmRpcmVjdCBk
ZXNjcmlwdG9ycyBpbiBTVlENCj4gPiAgIHZkcGE6IGltcGxlbWVudCB0aGUgaW50ZXJmYWNlcyBh
bGxvYy9mcmVlIGZvciBpbmRpcmVjdCBkZXNjDQo+ID4gICB2aG9zdDogc3VwcG9ydGVkIHRoZSB2
aXJ0aW8gaW5kaXJlY3QgZGVzYyBvZiBhdmFpbGFibGUgcmluZw0KPiA+ICAgdmhvc3Q6IHN1cHBv
cnRlZCB0aGUgdmlyaW90IGluZHJpZWN0IGRlc2Mgb2YgdXNlZCByaW5nDQo+ID4NCj4gPiAgaHcv
dmlydGlvL3Zob3N0LXNoYWRvdy12aXJ0cXVldWUuYyB8IDIyNA0KPiA+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tICBody92aXJ0aW8vdmhvc3Qtc2hhZG93LXZpcnRxdWV1ZS5oDQo+IHwg
IDU3ICsrKysrKystDQo+ID4gIGh3L3ZpcnRpby92aG9zdC12ZHBhLmMgICAgICAgICAgICAgfCAx
MzAgKysrKysrKysrKysrKysrKy0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAzOTUgaW5zZXJ0aW9u
cygrKSwgMTYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQoNCg==

