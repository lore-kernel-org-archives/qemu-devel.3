Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D01CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 06:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHGHy-0008NN-I9; Fri, 07 Nov 2025 01:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vHGHw-0008NE-5R
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 01:49:36 -0500
Received: from mail-japaneastazon11023126.outbound.protection.outlook.com
 ([52.101.127.126] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vHGHs-0002ey-Vj
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 01:49:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suMMUTcJeT+QQArQG273f5CBJWjH9hTHAv3WICznkyN9CUhA0WgCcMJL2Apg+K8jfTGH1UgH1dncEmSVwFocwTS0vNcJy0FPdu88tPlYaTa/zLZVX6kTN9/f5b3ezmPKgcGVlN7c8H/IYQ9yyMg5U1w04TmaaT2+DrhMVit0EG+RJ7qXnr4/QlWXRmvhBkXNdH3z8uSHNehSEHLvNHxrrULI+9ghgpkw5CKLbgdJdDAfnG+zO2frTYQGoxV/h5i8BSB2B/wbi81/n4QdP4DB6PEQM9zC+CgnbcKcRVrkbKc/R5DVjz0EQ7tu2P8j1cThVbs5tzj0XuoXyuKa5qaWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27YpYWI1GX3CQpGQvCW3ZQINjtLHKUSJpPiWFLZdptk=;
 b=kgFIJ5q59g9FSuuShA75pKu+rPPrmoehH2kUdflJMs9v4YmV1M18LMH1S6HPi2a2FiiX2tQEAFXH7zoQWEpMOyejhFJKHy9UtJ9lgySh1iRd+A5YMwXxyLl0aQZ3V1BRyOzu5GwtkFUFXFZsIHMSt4ms9fjZqAvMY8FMuXU6x+KRIoivkQw3ugISdH56udfHCYeh+4opXvzw1Vtu5Lp5oXmHWTb1F92RqEBqm/5azyrUbdv0X5rlD83lcTPXm5pJlnXFkGJVY0DjqyS/7tskJRYNUgq0fTooCQgxVMulcngBAGN1qZSPdEG4sMsGQR/wz4WTjUFJFIFV763LYawF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27YpYWI1GX3CQpGQvCW3ZQINjtLHKUSJpPiWFLZdptk=;
 b=OJOpuYhpFMEHWn85vogObamcpdqG4aE6anWeu0fyAraTp2pyEwKTfDDZYMqUqWjyqaNo/RqSGbPJz7Eg+kWLjl3M/iYhHJ00wfpjRxn6i74SOr10aHjSAiAMoC1IfQ2UsEuoI+jRGKFCrlPNkPy7Hw9SSSAG0IKccMADss8VFmH4x4+84HMAsCtk9hW/C2JO7DZ2dXBM/+WhyBCxs5B8hCKhVOljX+ngeUxdNWfw7igdY7mj4WnDtW+dD2LKRNi8pGMILYr2SlrptVurk6sW4FVSPxnXIf6AGhp5du4DXRGcGCyrf3ePh0xLbP2Ck0aZHwuA+8N+6RrJ36/ESC/S1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by TYQPR06MB8086.apcprd06.prod.outlook.com (2603:1096:405:2fa::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 06:44:18 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9275.013; Fri, 7 Nov 2025
 06:44:18 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: eperezma@redhat.com,
	mst@redhat.com,
	qemu-devel@nongnu.org
Cc: jasowang@redhat.com,
	angus.chen@jaguarmicro.com,
	wafer@jaguarmicro.com
Subject: [PATCH v2] vdpa: fix vhost-vdpa suspended state not be shared
Date: Fri,  7 Nov 2025 14:43:20 +0800
Message-Id: <20251107064320.4633-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|TYQPR06MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8a9dc6-acd7-441c-76d0-08de1dc91315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGhpMjA0WGJQQVdFSHlkWER2MFpBTjhOZ0V6S05mZ003OGd6Nkk1bGg3L3pH?=
 =?utf-8?B?VjdmTldaN0I2ek84OHpZN1AxSlAzQUQwb0xmNjE3MHNDRzJzaFo2ajc1eWJm?=
 =?utf-8?B?bDM4TE1YV1Y3ak05M2IzSXg2cG51MVpzMVUrUU1IZGdMaGlONEJSa0V0L1FG?=
 =?utf-8?B?Vm1pWElhSHBkUnFOandtWE5IZTJUOEJRbERFKzRaSGNlRFVhQS9Vd1BZY2gv?=
 =?utf-8?B?SjhiM1RPYWFiZHJKRVEwemw1a2dUYjZxM2V6cVBlUHpDZ1dFTWNaZUNyeVZp?=
 =?utf-8?B?STNaZFBxc2tnYjV3V28zMEwxVzF3SDF5QmZxcnhHQm5TNDVsSERXTHgzN1lF?=
 =?utf-8?B?WjZxTGxtVll2WlkySUpad1U1bVI4RENQQUJ5NnV2cEFZbVJkT1dvdGgraSty?=
 =?utf-8?B?LzhnODNwVXphRzkzTHZJUU1JU3FwNktiWnJIeHp2OHd0ZThCWU5nWWEwY0Jp?=
 =?utf-8?B?SG1CQmRzQXEzSk1xdUw3QjZpeXdONDZkMmtNTFV3aVB3Mmo5MDlBRzgwS2hi?=
 =?utf-8?B?dlRERGJKWGZHVTZNODRrajB5bzM4QlJtSkhnc1E5L1RZMC9raDBjdzltYXVH?=
 =?utf-8?B?Ny91MFdzK3dwZTVsSnhMMjR0Mkt0dldHa2cvMFBHbjk5em5NMnBnNXNqRC9W?=
 =?utf-8?B?QU1DQ3NoajFQNEg3elZOaXZHNVdtamYzbjExTEJpVEt2NE04dEFrWGpqQ3Y5?=
 =?utf-8?B?TGlRZFpBV0YwTW4reGpYOWxEclFZYTNRR1AyNDZJZUVKc29seGx1cU5GeGkr?=
 =?utf-8?B?bmIzcHdCUkNGVVBrWmJsWHJhYmFBaG5jSmVKWVRUOS9LTUx4OTBSQUNnYzk0?=
 =?utf-8?B?UmswR1doMlZ3a014UEQ3VGZFcE81VHdoUGQwMzBpOTIzd2dEaTY2REJGU3NW?=
 =?utf-8?B?OGlDV3RpejZmNlAxVzJldU9jdlk2MXBwTjVPbU9XVmFKb1Z2ZUNIZGNHSG5k?=
 =?utf-8?B?eFN3N2kyeGt1MVE3bFpHalNwZHNEaHAwdnRKQ0RsR3JINlM4cEVWT0Njbyt1?=
 =?utf-8?B?MnVlc1U1L0pWajE3QXoxdmRTT3NaSkZIZ3JhUGtEejdtZUtGVS9WYUl0UjRo?=
 =?utf-8?B?TlI4c0hDZXBBUkI5cG1Lb2lMVEw0TE8xYTJFWmJuUTZUUnZlamFxWGhySWg5?=
 =?utf-8?B?SXFSTUgwMkc4aVk5cFZEaHNIWVlOQzNsejVLbUUwckpPSXF0elhOUXBhaVgv?=
 =?utf-8?B?UytJTEd6S3VuckNWOEJlREx4M2ZDYzlvUlBwMTQ4Y3JWRGFCWllubmR4N2I4?=
 =?utf-8?B?eFJMUVBaL1Q3Mi91b0RVYWc4S0grSGJYeDA2L2RSRkwvYVBETGI2UUNQRENT?=
 =?utf-8?B?N0M0S3pYeC90YnNuRE9SUUpvaWxFeHF2aEZuSHFUQnp6cUFaQ0JsKy95WnFM?=
 =?utf-8?B?YzJxOTN1ZWVlTnlQaldJay9oT0cxb1hIYnhUZWtCa1dLUVlzYS9wSEZLOURV?=
 =?utf-8?B?bTRCS0hKaklPc0RITU1kMzBSbm1zbDN5OFAzZ2Nzdm0rSGFmQkc4L3RNTXJh?=
 =?utf-8?B?RC9ycGtoMHVBV0E3ckovZitsdVNzUlh1YmNzZldMUFB4K1FRRW9BMmRDdG5G?=
 =?utf-8?B?OHkva1ZlMDFod0pYU0N4bW5lSkZCcEtVMnIvNVJqQlM2NmtBNjlhRG9aZjha?=
 =?utf-8?B?emYwRm4xdzZvRkRTM0g0L3N4UXFXMmcxd0hVMnkzb3N5UExNaFJUdTg1N0FN?=
 =?utf-8?B?NWhDR3lRV3pITDdsbStHd2pNRG1MdEU5cEhNbzVxOS9NaGFxN1ppQ1NkdFA4?=
 =?utf-8?B?NGxPd1d3Vzc4eVI1Rkwrd283VEFHUWl3TmNSajBVM0Nqa0JWUDJpL2FuYXJ0?=
 =?utf-8?B?b2VuWGdjRXcwTnN0Q2Z0QVF0U0psNlZUUldjQTYyUkJwUjQ3dUNib3ZhQlpw?=
 =?utf-8?B?K21IZXMyLy9KME85Y0JHY1cwd01BVUVBVkh4RlRJUndOWmJLOVNEU2xVYjA0?=
 =?utf-8?B?d1NuWDhHVEZEaGpoVmxkYXZ1Ymxpd3Zqd2J0M1pkMVhQSXc2WGQ0N0hwV0di?=
 =?utf-8?B?cjVRRGw4dk1MM1F6bExDMit4eTd0NmhZNWY0NG02SG5uK2dYdzRjZ0N3b01D?=
 =?utf-8?Q?IxmfKC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGs2VXBJRTBKcUgzaG1XRmdvOWRtSDdOT21RQitDRG9jMmtVZFVsSk10QTFW?=
 =?utf-8?B?bjRPNmZDeElZNTBWcEJNTFV5VWQ3c2dldUFIdE9MaXFEcWJHMk8wYmk5enJ3?=
 =?utf-8?B?WDVxWmMwaGpxMFh5N21sdlVJdXRNV3NsdmRwZU1zUm5zdEM5YnhpZ0hoK1RS?=
 =?utf-8?B?bzZVV2xWNGI1cmRxTmNWc1BzcFQzY3p4RVMxMEtyclpLQUFxVzQ2S3g1SFZH?=
 =?utf-8?B?Qlc2UW1aMlhLdXlZR01aY3h6RVhHQXdLcmZkZFo1OEtwMnBBNWtoY1B4STZi?=
 =?utf-8?B?cllpY1FOYW9raXlOZmtNUWZ0OVUyQXd3ZVMyNmJGc0R0QVNYd3diWjczZ1Rv?=
 =?utf-8?B?THZtcnltWUhaMm5vT25QZ0Zjc1hWQlp2OVRhWlh2ZjRlQ1RqK1FiTVk4QS8v?=
 =?utf-8?B?Q1Y1c3N5VnhmMzd2Z05rOWZhZXhWaDZIaXJoeEk0d2t3VG5yWi9iNzBCY2Q4?=
 =?utf-8?B?UnExM1VKZXE3TWpEV0xZSEpBalhUUGQrUG1COUtTZmhvZ1ZFYy8xS0NYL25h?=
 =?utf-8?B?SEpPaWZneGlhbHU5b2xibDZkaUJrdlR1NGdJcDVUWG0xWEhBL0xzMDc4K1JE?=
 =?utf-8?B?eXlaNkx1bitFRW1NM1M5cS9TdHlmaTcrTXRwcmF2VkYwTUt6R0w0bUdmSEF3?=
 =?utf-8?B?VW81eStkQUJvMXdaU1JTR0xVN0VhSDdOUHVKOFlyKzRUWi9pVVEvbmJCNW9z?=
 =?utf-8?B?S3dOVEc3dUlhM2poMHpMdFJiWmd5MWp4WkhMaW9MaHhtY3RHWWgvUGtQZGV0?=
 =?utf-8?B?NnlGNmorcHJVS3B0WWdxSktNQm5xRUJMK0JhRW40ekk4RXhxS05BRHhMOThQ?=
 =?utf-8?B?Q2NlMDQrRDdhakt3b1luaUhnNDlVajlHeCszQTJSU3dTN0I2Y1NxdmxXckZ3?=
 =?utf-8?B?RnB1b3lMR0YxTUEwZi9kT2NXUlV6ZVNpbzdRSnNHd2IrNUlWQWU3aEkzVmJr?=
 =?utf-8?B?bjl0RzFxSzE3Vng1RVV0LzliSm8rU1dtRi9oZUhCYWJRZWJEZkl1TzRULyti?=
 =?utf-8?B?U1JTcENwbVhVRnFiekM1MlFBb1QxMWxmNVJ5MmZmQzM3RmVpZzlpTTdqaEFa?=
 =?utf-8?B?UjZZWHpKMEpjd3hZUHh2RFMyN3NVWndwK0JLQkl5VG0vd0JFbWNzUTF4bFNh?=
 =?utf-8?B?RU1hSHU2Z000T1VkSG1CSkpVVzRMSFdDYUlpOWxPOVdYdDQzY2R0SzBHOHFU?=
 =?utf-8?B?SlNaRUlaTk41KzJLM1hMTGYxRFZSYkRWaDNKdnhaTHNRYmRNdGhoMjBJektX?=
 =?utf-8?B?SERLNG1uRWhYRnQvdzZPYllyTVdIMjR0OGFZb0JwT2R2dnArV1hZbGZWNWhC?=
 =?utf-8?B?SFJ2S1luQzFUSVB1L3kxbUlrYXdFQmpYQkNIRndhVUMxZUFlakN2K1htY21y?=
 =?utf-8?B?ZEpKcEQyaXZkZHVsN3dNS2Qyc2c2MURRc1IrTUhlTStZeHVKTC9aRmZrYUdi?=
 =?utf-8?B?c0NXWVY0NGlyU0dLd1JOaS95Y0hpakQvL1hPVlZyc1VRSjNhTUZXN0hwV0Ix?=
 =?utf-8?B?TVNNazEyNHQwMjMrWENjYTcrK0VRZ2dxVERBVE55ZlhTWXovSk8vcDFlU09R?=
 =?utf-8?B?a2Y2dkRPa1NsS1Y3QlAvdWpFbHQzYWtJb3g3Y3V4QWNVUEhUSWQybGRmODB2?=
 =?utf-8?B?K043WW4rbDZ4Y3c5VWNtWXdGY1ljVVhFSGZwVUlzWjBCWUprMnJXVmtIRHFV?=
 =?utf-8?B?WW12RVNmSXVTd2tBT2NVWFYrMFNBQjdnSEZhSE5BZUVJTDBCWkczMUJyUE5v?=
 =?utf-8?B?VVZHK0RldkZQL3IralNzdjNwc0MzYmxuTFFCcFVFcU5IVnNjeU9Hb2s4Y1BC?=
 =?utf-8?B?LzZpeUZpUHlUa09UUkQzeTFjQmlaN1RsNU1tbFcyNEJqbDYvVHJ1RndxZ0ov?=
 =?utf-8?B?NTMzbE8wUzVuTU1NUE50K0FkZ0dQbVM3MFZ6bEs3YWQ3bExhNEdDR24xa2lq?=
 =?utf-8?B?WnBDRFNQRk96cjB0RjFsQitqWG94WVVHZkpqM1gxNWoyMG9VZkh2VTlLNkk4?=
 =?utf-8?B?QmJFamswTVoxWmwrdnd2QVNxNUxmQWVOeEw2Wk93QWc4dFlBZmIvWHp3OHpC?=
 =?utf-8?B?b3BZZHNyeXZLNEh4cUdjdzlWT0JCYm5abm1QUk1EMnA2Zm96SFlDNC9Kb0pr?=
 =?utf-8?Q?mrWUmXLcxJwytDn2UiMDgOp5q?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8a9dc6-acd7-441c-76d0-08de1dc91315
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 06:44:18.1376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uz86R0U7L5/MM1Kcgw1Mto7uAg24Vb9O/iS/1hMLq4GJxHm2EvwzU7/Kci0dvE4kWrQ7RNPVhSXBiQ6hvR3D6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8086
Received-SPF: pass client-ip=52.101.127.126;
 envelope-from=wafer@jaguarmicro.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

When stopping a vhost-vdpa device, only the first queue pair is marked as suspended,
while the remaining queues are not updated to the suspended state.
As a result, when stopping a multi-queue vhost-vdpa device,
the following error message will be printed.

qemu-system-x86_64:vhost VQ 2 ring restore failed: -1: Operation not permitted (1)

qemu-system-x86_64:vhost VQ 3 ring restore failed: -1: Operation not permitted (1)

So move v->suspended to v->shared, and then all the vhost_vdpa devices cannot
have different suspended states.

Fixes: 0bb302a9960a ("vdpa: add vhost_vdpa_suspend")

Suggested-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>

--
Changes in v2:
 -Move v->suspended to v->shared
--
---
 hw/virtio/vhost-vdpa.c         | 6 +++---
 include/hw/virtio/vhost-vdpa.h | 8 ++++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 7061b6e1a3..2f8f11df86 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -905,7 +905,7 @@ static int vhost_vdpa_reset_device(struct vhost_dev *dev)
 
     memory_listener_unregister(&v->shared->listener);
     v->shared->listener_registered = false;
-    v->suspended = false;
+    v->shared->suspended = false;
     return 0;
 }
 
@@ -1354,7 +1354,7 @@ static void vhost_vdpa_suspend(struct vhost_dev *dev)
         if (unlikely(r)) {
             error_report("Cannot suspend: %s(%d)", g_strerror(errno), errno);
         } else {
-            v->suspended = true;
+            v->shared->suspended = true;
             return;
         }
     }
@@ -1481,7 +1481,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
         return 0;
     }
 
-    if (!v->suspended) {
+    if (!v->shared->suspended) {
         /*
          * Cannot trust in value returned by device, let vhost recover used
          * idx from guest.
diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 449bf5c840..6ad371f424 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -76,6 +76,12 @@ typedef struct vhost_vdpa_shared {
 
     /* SVQ switching is in progress, or already completed? */
     SVQTransitionState svq_switching;
+
+    /*
+     * Device suspended successfully.
+     * The device can only be suspended once, so it needs to be shared.
+     */
+    bool suspended;
 } VhostVDPAShared;
 
 typedef struct vhost_vdpa {
@@ -83,8 +89,6 @@ typedef struct vhost_vdpa {
     uint32_t address_space_id;
     uint64_t acked_features;
     bool shadow_vqs_enabled;
-    /* Device suspended successfully */
-    bool suspended;
     VhostVDPAShared *shared;
     GPtrArray *shadow_vqs;
     const VhostShadowVirtqueueOps *shadow_vq_ops;
-- 
2.34.1


