Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2973CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 01:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ067-0008Na-ER; Tue, 11 Nov 2025 20:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vJ052-0007lf-8y; Tue, 11 Nov 2025 20:55:32 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vJ050-0002pX-NE; Tue, 11 Nov 2025 20:55:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/5mvxJV/3Ldj+E6DPVKPWhVSjcy+yU0IlDZ+c1QDNj8OeHjv7vdlE3EmgBCSwbEBgMEZ2KLZZKu2PPUPD08mKauv4NpmYTeNYnrB/2Mlpznwi8H/qpveCQt3n1n9Mwv2Q/v5rxvMtOKqumyKQ2J8pHF1sXYRWBxMfwZWnxoAAh/Z9hLtAjHFPpwiji9/8TdBHNKpbnP7cEShrPIZgQyBuaYgNACmj5g/S5/xG/0jtfesUNO34x5FZcWNMnRoRlTseJT44eaqGYO2MZ1AIUuF9fDtZ0b0cRNmnfy8WytRASCz8E4hxi+jsZ0868r5+MVGOqck1EDQTpEiVbnAnXp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjnhQUosaIMZbUaR7Jbg0egaXdbZtmVDMv/kpG8fZuY=;
 b=yldX9lKTT27ZsHNHKId9aDvYcDhvSrM8OtDSKQJhEaPSbqc9K/KRRoa8uSXJNBtLRuwC4ZiltMjI/LFcsk8AgexAqqoQBGdV0WhT0eQROgBZ41RpMiIi3NDEWM2v8cKzoWdiOBPOlDI0MUauVZhI+h0Uk6XKuwMzIIzwOp1aeNyzefMk66UjCP9HTJB0TKfw+MgraQgtWTrO18E9YHqOzPcmA11ycmUZOrKOSAdwI9NX58AolyTOTF3QjK/7gf/E5d1XAX8qN3R527Q2bL/0bxEcW1GurUDZ2HctJNcEe5LQkx61+kFNzMowWjU0AezJH8KixgOzDE0NiVtExlQdzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjnhQUosaIMZbUaR7Jbg0egaXdbZtmVDMv/kpG8fZuY=;
 b=NkUDmSiWeKPlLb2BIMuwNJT7Ror5VT7h1qB10jKDcScmUS/yeyGpTW49T3hVdkdPbD2x2kyTwxlLtqAn9BbVXhbpFzPCs9T1u6/TxCNAAjqP5omms+xz2+469FELrt8/6efujemYE2rpB7wqe8GYPHjXsjoJssT6JhR4O4gFJMmhAsVdyxklL/OPyM+t97/sWJreH66RjfIgIZY/COASwGu3uPqA66Dz/BVP/z0DaFDk/G3Ebs7b14sc7wZ6ygX6m+FB2Nb0RHBBz85BzmSZ9HPp7FLBLllj7h5yQ5/lGkdBn2txHWlAKurdse+PDlgr7Op+lIESXxkJHrONtXHI8Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6091.apcprd06.prod.outlook.com (2603:1096:820:d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 01:55:19 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9298.010; Wed, 12 Nov 2025
 01:55:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [PATCH v1 11/12] docs/system/arm/aspeed: Update Aspeed and 2700
 family boards list
Thread-Topic: [PATCH v1 11/12] docs/system/arm/aspeed: Update Aspeed and 2700
 family boards list
Thread-Index: AQHcTvpMs3dB4nDkOEW2PLBf949/8LTt0mWAgAB+IoA=
Date: Wed, 12 Nov 2025 01:55:19 +0000
Message-ID: <TYPPR06MB8206A17DA5A6E00E9E304C5DFCCCA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20251106084925.1253704-1-jamin_lin@aspeedtech.com>
 <20251106084925.1253704-12-jamin_lin@aspeedtech.com>
 <482da412-99ed-4742-9c62-01f01d317068@kaod.org>
In-Reply-To: <482da412-99ed-4742-9c62-01f01d317068@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6091:EE_
x-ms-office365-filtering-correlation-id: 7cc7d29e-7494-431c-8d10-08de218e889b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?enFKS0JkRFQrV2tPeWZ4NlJaVDB5RWtKd0NNMXh2ajFqcDdRQ3BtWUFkNXpU?=
 =?utf-8?B?ZEg1b3I1T24wdGR1dFJjL3ROYjdFVjY2VHFESU1Ed25yanRqVG16Q1ptUDAv?=
 =?utf-8?B?eklOa05BVlJTY2RTcDNTR2g0QkhzcE5CL1M0UWVuR09WYmhlekxtbGVqVWhR?=
 =?utf-8?B?dHNKMkZlNUN0Z3R5cllKcVFFRVZrU1ZPZ1VPSzNGU2xzVmtVYkU2WXhwNG1w?=
 =?utf-8?B?d3ZqWWpDZ29Qci9oNlhRMXRGVldWZm9rUDBUSCtOaXFJajJNankvRGlFODFE?=
 =?utf-8?B?UGJTVm1RRUNRNktsalFFUDhnclo2TzZ3Q29lcFJUZmFqWHRXMUNQbjJqMEJj?=
 =?utf-8?B?L2pLWCt5MjNFL3VpR2FrcElRWVg0VFlRSHpLVFBaakhIMldudktGVGdMSk5i?=
 =?utf-8?B?cmY2ZnJOL0xFWVBKQmdkTFVyT0tiWnpDMGlRblhxc25VTDg3YVJnblRKYVBQ?=
 =?utf-8?B?UkpBMC9ndGFSVngycXlRVUlwdEFTTVlLV2FLcEliLzdidVF6R2xoMkg4d1ha?=
 =?utf-8?B?Q2xIS2s0UHdzdXJacWQrdVlaZzBUdWdlSmVSUlFHL3NPMXNXMzJsUzQrK2x5?=
 =?utf-8?B?bkZEcGFBUXJOM3Rrcy9Da3NBcmFUSlFubzFjaDgxOTA5MHR6MlFkTXZ1OUQ2?=
 =?utf-8?B?ZGdYQ3hkS3gvQXg4Nmk3YTd5SFV2azY2S3B0dE54VllYNzJkajloMzdoWEJK?=
 =?utf-8?B?Nm5ScXBNZ0FYd0k5MzRCUHNlWUlhTHVjSXVJcTlzM0p6a1lUdDU1dCsxaFJz?=
 =?utf-8?B?QUZtb3RrQTNua1lzZUgvK090L2R5VXNZaWhjZHdxcGx6bDNYZUhTeGk4K3p1?=
 =?utf-8?B?VHNtdCtQYWRaVWtKOElUdVcyR2JLYm9IazM0cVB5U0NXMkR6QmRsbndTYXUr?=
 =?utf-8?B?eTFmTjdmazIzSXN2dXRBVkJWakRQeGl2UGhEVTdsSVZjd0xJLy9hZjBwbHpy?=
 =?utf-8?B?NVUxdkxUVjZmRjZZWndGbnB0ZUh4RzBtZ2lzUU8zWVJ5M0VkR3hHQmwvcmdH?=
 =?utf-8?B?WjhITzBLZ3BzQWNsSUY0dW9uZWpYYjh1dXVlS3pPS3VQQTMrS1R0V3VSdGww?=
 =?utf-8?B?VjloQU4vL1hXRjQ1NXFXRmFtNnVxQ3VDQjR0NVg0SjlqREZPR1ZwdE82MjJQ?=
 =?utf-8?B?aWNDbTYvR0hsalZ4dDFIeVRNTEowM0JXb0hCbzNMQ1ZnMnplTkN1QnVETWZq?=
 =?utf-8?B?dEFPbHZscFZwdGpwNXU5bDIxVVZtYStET3dYcVhwclhMRzVQZVlTVlY2dDlS?=
 =?utf-8?B?YTdJSEh0SFZSazFIb2RGZVY5VEJRM05KSzUxMzdZem1GVU85WWlFaXBMUUtM?=
 =?utf-8?B?TXRhTXkrRXAvZXUvMW1lLzM4ZUFmKzgxb3pzbm5HQUhiR2FlS0FVaWJhT0ps?=
 =?utf-8?B?ckU3VGNTeVduUEZTKzQ4WjAveEtUdUx0NGxsZ04wYzNFZDJRS1VkWC9LSkhY?=
 =?utf-8?B?SDVBaFEyL0tyeGJrVlp3RVQ1YWU4MTBaeGJKRkxnNlBJT2IzcnVCWnRhMkFN?=
 =?utf-8?B?RjdqT1BudnVZaHBndGtyZWxJR2dCaTNWSGkzalBVRjZrbWcyeFA3bVRMNmc5?=
 =?utf-8?B?T0ZrZEtMbVBSdmo2VTd1L29qejFHRzhRS2NPSnlvUWxvTmh1Y3JKUHBRNFp3?=
 =?utf-8?B?eCtTZTR0bGZuUFh1dFBQaE9MSG9WZytqRjdoZXJJeEpYMDdRMUh1WVVWckFt?=
 =?utf-8?B?L003Yk9ESmpEdHhZVWRGNTBPNmdYMzNTbWpzeTdpeEhPREc2MmpheTEvZXVy?=
 =?utf-8?B?cTIyZHdxcmFYNE1tSmhRSWtnRDJ1RGZKaVQ2Wkt2MkZXa1NJYzhrTDdOL2pD?=
 =?utf-8?B?KzdrVmt4T1RFdmx4ZHlYWlk1Mi8rc2VLVW5qQ05IdXV1Y0o1QTlRZ09BaWZz?=
 =?utf-8?B?MURKcEd1bFJWVExHZ3V4RU5SdE1jci80MkJ1NHE4cFdNTkVkUDVMR0RnM3pt?=
 =?utf-8?B?TFpmcENvRTVuZjBCcFN5TlZKbzNLZUhpNThrMThaNloycTdsbmpZUHdLdUtU?=
 =?utf-8?B?YUpVOEl4Q2t5TGc4dmliQmI5VmFhc1dMSlNEVUhjSTh4dVFORlYwL2JpRTVC?=
 =?utf-8?B?OTNVQS9pOG5LS21zRk0xOWpuS2I4NldjWGJpQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVFIay9pNlVXeDRhSThoWVNNMFhJT1pWRkxIR29GcWRIem5yVHBmVUdncFlk?=
 =?utf-8?B?SU5POFFmbEZUUjRwVjVTQnNLVXlUNXVJWW5PTWVpQXZOUWNYa0ozMm5SVCtn?=
 =?utf-8?B?LzEvWGlZanRqUHNlMWhDV3VTdzAwUUNhblkvTDZUdm5WMlBlOTA3RkphaHBT?=
 =?utf-8?B?Q3hWNDRrWUk2UFF5TjVXR2JOMU9CYit2akZBSnZ4R05YaEhWRzBnQ1M2YXNz?=
 =?utf-8?B?WlFIcms0L1lRRlFaRHdPMUpweHpaYm1ZRUlXS0x5c205MjB6VVhid0lkSnpz?=
 =?utf-8?B?cm9GeFJMQUxwRnlqMGx6TlpGTW1TRVpxb0Qza0JQUDBjR0Y2VVByWW5aalE0?=
 =?utf-8?B?bnZ0UmR1Y1NWZWM2RFJOQVk2dTh2bE5yOXpheGE4US9NYmhlT0EwWHlaZ2xE?=
 =?utf-8?B?Z1JVSnI4Sjk0VkFOY3M0a0poK0ZaeW85N1AwUXo0bVVjaGROTzZkdW95VlZP?=
 =?utf-8?B?SzVxMm5QNnhHWFVhSE4raFgxMGNoRkVhTkFqUTZOc2VCWStNMTY4cmpDUnJ2?=
 =?utf-8?B?aytEaHNSRGUxMVVHQmlYNFprdVZXNzlJbkt3SEkxRjBEbFpPek5pQTRVVk5P?=
 =?utf-8?B?dlU0bWhwS3R4U1Vpa3p4OGJvV0NNVWw0ZTJuWHpjT3hsVCtQNFM5SEhMeWpi?=
 =?utf-8?B?bitWZjBNZEZ3anluQ0lrMnlHMmxsUjZsaERLQTFZajZlQzFBSGtOMDJMakdX?=
 =?utf-8?B?cXFNcXFrM0JhL0FOeTI4RUtsNzVKRzFrckRaczVENTBKVThncVRxSmhWeGUr?=
 =?utf-8?B?MGtIUDJRSkJGMTIxcFRONitGVlpMVndSL290Um1PWlJpYnRMdXAvNGVEek1y?=
 =?utf-8?B?ZXRBMTEvcXpxRjVNM2tLekJDY1FseXZJc25JZGlHQWZEa3IzSEF5T285dWtY?=
 =?utf-8?B?NENibERlV3BrQ1Z5cEJYSzlEQm9XZXpqNVpvdWlaM0NWVU95WnRGYzZQbXQ4?=
 =?utf-8?B?WWpUbmdBbGdJd2Y2K0FGUlVEMjBnWXNDWHFSZUxFTDlyQ1hiMFNQV2pqMWhu?=
 =?utf-8?B?eHhuU0UwQzVLR0RUOXE1bVp3SHNHUnZuK1V6aHZqNnRUWEMwT0JxVW9zVlRV?=
 =?utf-8?B?eUdNcDhvS21OSGlDR3F0cUM5ekxrNnlBL0dpbU53MWZTYVE4TmFsOWVFRkNl?=
 =?utf-8?B?bnpId2ZaRHZOeHpwd2VEL2NWWkpSZFRnMkg3OUNDbk9Dc0pqTkc2NGFkNGtB?=
 =?utf-8?B?L2lIZ05aOGF5ZkpXeTNUeEhGZDFDSFdTdjgxM1hqb0hNb1ZGVnhEdWthMkR5?=
 =?utf-8?B?WVYzM1l6aEJaQTl5RjJMbEY5OGJiQmtUeTVaSE9mQW91dHBJckRwQnZEazAr?=
 =?utf-8?B?YWliSEpXTFNZVHNxenh0QlpiZWlsenhtRmd3Ly9OUWZvU1FOQXRmRHpjeWVZ?=
 =?utf-8?B?cFMwbDYyNjdYZTVEdzY1aEtTVEZqb1VsOUx2NjNubGNHZjhyL2hLWmlSK3g4?=
 =?utf-8?B?MU9DOEdhL2FpeDMxNGszTVdtbjI1WG4xSU5hOC80cXJmV1hFTmhsU0lHaTZU?=
 =?utf-8?B?R1BVTUFZc3JMNHNhb2NlWGNYWm83cERtRTM0djR0MTM3QWdTc05pc2N0YVAw?=
 =?utf-8?B?TE9qa3I0UkpEM2J6bzZLKzkzcVBENTAzTjd4cHFYNnZ1MzFmV1NUMThxNEF0?=
 =?utf-8?B?bGlKOWJ2d3dhbjc1R1dMRHV6Q0pDVzZoR3NQN2tpSHQ2dUl0Sm9nRzRJRjhM?=
 =?utf-8?B?ZGRDWlllZTZ2aVJadFdQL0FLdUZmSWhvcmM1elROSzJXanZLbEZzNFMyQVJ6?=
 =?utf-8?B?R0R5Z1JNZDhhTkdDU21TaVI4ZTJ5NFVkN0hNZ1p1SVBIWWFrUmNzRFBtU3NT?=
 =?utf-8?B?eVM5YmE0SGc5UUE4ZFV1cVF2dWpxcWxmOHZIK2h5NGxmTWh5TU5Ta1dKNWRX?=
 =?utf-8?B?akt3Q00xditiemJlMXJvdTNKbGRiWjAwMHNEQ2JSRDg4YmFFQ1NMelpVSWRP?=
 =?utf-8?B?MENrMStQbzMwcnNJaEFNd3dCWFJuMEl2dEF1OW5XaDFnRXQ4blFNUlp5a0lm?=
 =?utf-8?B?UnM2NG1QSDRpcWV6L0NCOWNrdUw4d0o1UXUrRTFSaFJQQlVKYkkrWmcwdE4z?=
 =?utf-8?B?OHpTRU5xdTVENmZBNkpBdGc1dlF1dWFMV3hNeEg5dzhkdllSdHY5RFFJWnJX?=
 =?utf-8?Q?9gNGPfuo2H+rA2Kk1OSJylFUN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc7d29e-7494-431c-8d10-08de218e889b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 01:55:19.3896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QCQr+sKGQh/mTw+RkB0wBvlqE94dmDRr0NTRZQWrHRv+YCUcv0bg/g/OMtJn/lC/oVI4acuIcZgA3K1QyZEbVGRxInlVe5vMpr8M7POiKPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6091
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

SGkgQ8OpZHJpYywNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDExLzEyXSBkb2NzL3N5c3Rl
bS9hcm0vYXNwZWVkOiBVcGRhdGUgQXNwZWVkIGFuZA0KPiAyNzAwIGZhbWlseSBib2FyZHMgbGlz
dA0KPiANCj4gT24gMTEvNi8yNSAwOTo0OSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IFJlbW92ZSB0
aGUgYXN0MjcwMC1ldmIgZW50cnkgZnJvbSB0aGUgQXNwZWVkIGZhbWlseSBib2FyZHMgbGlzdCBp
biB0aGUNCj4gPiBkb2N1bWVudGF0aW9uLiBUaGUgQVNUMjcwMCBwbGF0Zm9ybSBub3cgYmVsb25n
cyB0byB0aGUgbmV3IEFzcGVlZA0KPiA+IDI3MDAgZmFtaWx5IGdyb3VwLCB3aGljaCBoYXMgaXRz
IG93biBkZWRpY2F0ZWQgZG9jdW1lbnRhdGlvbiBzZWN0aW9uDQo+ID4gYW5kIGJvYXJkIGRlZmlu
aXRpb25zLg0KPiA+DQo+ID4gVXBkYXRlIHRoZSBBc3BlZWQgMjcwMCBmYW1pbHkgYm9hcmRzIGxp
c3QgaW4gdGhlIGRvY3VtZW50YXRpb24gdG8NCj4gPiBpbmNsdWRlIHRoZSBuZXcgYXN0MjcwMGZj
IGJvYXJkIGVudHJ5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9s
aW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBkb2NzL3N5c3RlbS9hcm0vYXNwZWVk
LnJzdCB8IDQgKystLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kb2NzL3N5c3RlbS9hcm0vYXNwZWVk
LnJzdCBiL2RvY3Mvc3lzdGVtL2FybS9hc3BlZWQucnN0DQo+ID4gaW5kZXggNjMxN2MwZTkxMC4u
YTBjMDVhNmY3MyAxMDA2NDQNCj4gPiAtLS0gYS9kb2NzL3N5c3RlbS9hcm0vYXNwZWVkLnJzdA0K
PiA+ICsrKyBiL2RvY3Mvc3lzdGVtL2FybS9hc3BlZWQucnN0DQo+ID4gQEAgLTEsNCArMSw0IEBA
DQo+ID4gLUFzcGVlZCBmYW1pbHkgYm9hcmRzIChgYGFzdDI1MDAtZXZiYGAsIGBgYXN0MjYwMC1l
dmJgYCwNCj4gPiBgYGFzdDI3MDAtZXZiYGAsIGBgYmxldGNobGV5LWJtY2BgLCBgYGZ1amktYm1j
YGAsIGBgZ2IyMDBudmwtYm1jYGAsDQo+ID4gYGBmYnkzNS1ibWNgYCwgYGBmcDUyODBnMi1ibWNg
YCwgYGBnMjIwYS1ibWNgYCwgYGBwYWxtZXR0by1ibWNgYCwNCj4gPiBgYHFjb20tZGMtc2NtLXYx
LWJtY2BgLCBgYHFjb20tZmlyZXdvcmstYm1jYGAsIGBgcXVhbnRhLXE3MWwtYm1jYGAsDQo+ID4g
YGByYWluaWVyLWJtY2BgLCBgYHJvbXVsdXMtYm1jYGAsIGBgc29ub3JhcGFzcy1ibWNgYCwNCj4g
PiBgYHN1cGVybWljcm94MTEtYm1jYGAsIGBgc3VwZXJtaWNyb3gxMXNwaS1ibWNgYCwgYGB0aW9n
YXBhc3MtYm1jYGAsDQo+ID4gYGB3aXRoZXJzcG9vbi1ibWNgYCwgYGB5b3NlbWl0ZXYyLWJtY2Bg
KQ0KPiA+ICtBc3BlZWQgZmFtaWx5IGJvYXJkcyAoYGBhc3QyNTAwLWV2YmBgLCBgYGFzdDI2MDAt
ZXZiYGAsDQo+ID4gK2BgYmxldGNobGV5LWJtY2BgLCBgYGZ1amktYm1jYGAsIGBgZ2IyMDBudmwt
Ym1jYGAsIGBgZmJ5MzUtYm1jYGAsDQo+ID4gK2BgZnA1MjgwZzItYm1jYGAsIGBgZzIyMGEtYm1j
YGAsIGBgcGFsbWV0dG8tYm1jYGAsDQo+ID4gK2BgcWNvbS1kYy1zY20tdjEtYm1jYGAsIGBgcWNv
bS1maXJld29yay1ibWNgYCwgYGBxdWFudGEtcTcxbC1ibWNgYCwNCj4gPiArYGByYWluaWVyLWJt
Y2BgLCBgYHJvbXVsdXMtYm1jYGAsIGBgc29ub3JhcGFzcy1ibWNgYCwNCj4gPiArYGBzdXBlcm1p
Y3JveDExLWJtY2BgLCBgYHN1cGVybWljcm94MTFzcGktYm1jYGAsIGBgdGlvZ2FwYXNzLWJtY2Bg
LA0KPiA+ICtgYHdpdGhlcnNwb29uLWJtY2BgLCBgYHlvc2VtaXRldjItYm1jYGApDQo+ID4NCj4g
Pg0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09DQo+ID09PT09PQ0KPiA+DQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPT09PT09DQo+ID4NCj4g
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KPiA9PT09PT0NCj4gPg0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID09PT09PQ0KPiA+DQo+ID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0NCj4gPT09PT09DQo+ID4NCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA9PT09PT0NCj4gPg0KPiANCj4gVGhlIHRp
dGxlIHRleHQgbGluZSBhYm92ZSBhbmQgdGhlICAiLi4uPT09Li4uIiBsaW5lIHNob3VsZCBtYXRj
aCBpbiBsZW5ndGguDQo+IA0KVGhhbmtzIGZvciB5b3VyIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4N
CldpbGwgdXBkYXRlIGl0Lg0KDQpUaGFua3MtSmFtaW4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMu
DQo+IA0KPiANCj4gPiAgIFRoZSBRRU1VIEFzcGVlZCBtYWNoaW5lcyBtb2RlbCBCTUNzIG9mIHZh
cmlvdXMgT3BlblBPV0VSDQo+IHN5c3RlbXMgYW5kDQo+ID4gQEAgLTI3NCw3ICsyNzQsNyBAQCBj
b25maWd1cmF0aW9uIGZpbGUgZm9yIE9UUCBtZW1vcnk6DQo+ID4gICAgICAgZG9uZSA+IG90cG1l
bS5pbWcNCj4gPiAgICAgZmkNCj4gPg0KPiA+IC1Bc3BlZWQgMjcwMCBmYW1pbHkgYm9hcmRzIChg
YGFzdDI3MDAtZXZiYGApDQo+ID4gK0FzcGVlZCAyNzAwIGZhbWlseSBib2FyZHMgKGBgYXN0Mjcw
MC1ldmJgYCwgYGBhc3QyNzAwZmNgYCkNCj4gPg0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+ID09DQo+ID4NCj4gPiAg
IFRoZSBRRU1VIEFzcGVlZCBtYWNoaW5lcyBtb2RlbCBCTUNzIG9mIEFzcGVlZCBldmFsdWF0aW9u
IGJvYXJkcy4NCg0K

