Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B81CEE6427
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 10:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vateR-0003Cm-Iv; Wed, 31 Dec 2025 05:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vateH-00037G-69
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 05:41:55 -0500
Received: from mail-japanwestazon11022131.outbound.protection.outlook.com
 ([40.107.75.131] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vateE-0003KD-R5
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 05:41:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0YzIoBfYFyQJEzUXEwjWvQ9aYaJCnYChDDWjeOStpGZRxqju5i13gTfKXnidq+yFl+1y5A1639z7vwhej5MjReIObf/g2nbS6blCOIcepTLM2dQ6+K2VxeD1ugSq6yu079K4ziUSkGE1TAqVfrPxT+sqHXx26CXqtZ0eg6XuCLp5ik+adoHn9nZHwZ+wWjSDhyMXI+XplamFmYQEXAOvi59+MY03MMDIG5zVv228vLFnBiBl7hM0+yA4mnOoGq3K+NSgpN2Ux2JIHwuonD5sXntecbyaNfcqzMJN/NabJwAFalJVAlMd8+skkOVV0TlWlwYSmC2z80oLwMukiRqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7EJBJVtf/L9o19mQlqdyBoVz2YW+swCWWGjWH8A6Uo=;
 b=yw+Cv7SZA0sQLGZdJjopGOpEVVoMzgqF4GlZDDtYuZQNE43gUZMCDSnlL7HSd2oJ8JSueFI8MtjNJa3e57MPBzo3nJRLKRQ4jeOyXZ2/L2DUHm2J+uG+Zr2DR9S8/tqUnfxYutzMUH/Yrw8SdBcPTQ5yGOnMIa5EcrqWM0a4eWvBjGK4qQ00Qqm97lWleG+OS8icSChsmKMr6MlOWf3y6QGBQMSbOe9OBCqSvDDj3h8DIML+fZ19qFrwTPmyf/fMTQtd/GPorYm0DJzqVPxX6hxI3B3q5gdGaaQyG49QYB6BB692NwU3/8C0hWT8nMZrNOia8oPUflTC09VsAbWzzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7EJBJVtf/L9o19mQlqdyBoVz2YW+swCWWGjWH8A6Uo=;
 b=ahDBu5xi7sMZIKfOmSlIT1/5i9Ki4mh9uVQPkrSmAx0hMXYKnn4q3C28RRi5s9uemQzp7BE9YuA9JrdvGlvJYbBAtaJeWuq3BlkwlSSO064tTqG+lh3XnGsSpCt7b2yljQ1Aa2VneonYylvuHbzgNsk3MWO6rhwVZVWgdWSIvSoaC2h5tmyQ+9Y+cX9dqeNqwXOD5WsRfi2FFwBpx8ufjc0PrCTm5PPlJEKoJMfeU6oalH0kZjxDd96q5A8qwd8b61LuwyBZ6NLTK6byNvD8UtNxIhy++Uy3LMMa8dk2fTgSr+6o4Cr5PKuU8vgRlw+f9mZQyzkpqy+3EXM7qrXZkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by TYZPR06MB6546.apcprd06.prod.outlook.com (2603:1096:400:458::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 10:36:39 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 10:36:38 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH v4 0/4] Add Split indirect descriptors for SVQ
Date: Wed, 31 Dec 2025 18:36:15 +0800
Message-Id: <20251231103615.9987-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0022.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:16::14) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|TYZPR06MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f94728-3354-4321-e503-08de48587ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU1veUJXMzJlYzhjMTdxd3pBTmZ6QkR0OGp0VE54QWgyQWthZ2h3dzJ2YlJj?=
 =?utf-8?B?RmQwUXZYOFRPa0N5a3MvVUtwR1RJUDh2SWZIaWVnVVBXQmVzdGxacm9QRkJz?=
 =?utf-8?B?Y29peWc4bjJocW9nVWdXZCtKWEZlMlJxUEpHZW9EMnR1Smd0RjFyZFNzbnpD?=
 =?utf-8?B?ZVVPNnBnbVhZYlY5WVhGRXY5Y3FNcm1GbEU2MXFxY3c0VTBpM0oxNGY0MWZT?=
 =?utf-8?B?SUhDSHVyOWlkckErV1J4eTNIV0dOeHlBNm5nVW5MRlFLQjVTSE0rVXEzUzI0?=
 =?utf-8?B?SlBUYVVnWms1bno0MnNlcGU4bDJQQlk5bE5vZTllRFdjMXA1dEtJMkNSVkVE?=
 =?utf-8?B?V1E4L09FZTlWYlU5ZHlqbWQzZ3RXek14d2VXNmU1Yks3alkvTEx2aDVyOHFU?=
 =?utf-8?B?U3BKeUhmUWhRMTR6ZVUybVFZdWdTczdtOTJ1cDdvS3R5ODFjMjJiSDkrS2t2?=
 =?utf-8?B?TjlGU3BoQklWRlVteUM1L3pKUmJ0elBLQ1AvWStoNE8ydGdPZkxrZVZuWHVG?=
 =?utf-8?B?Y1NPM3l5Yk1hR1Qvc3pzdlY1ckpTbWM2eHgwYWtBanVESHE3dHFCNVZKem9P?=
 =?utf-8?B?RklSNEVabDVsMHI4WllNck5UaVRNRk5jakpXSTRDeUhwTmoydWpTbzNmNGhF?=
 =?utf-8?B?V2JTSitqNmlMY3hZZ2pQUTJ4UFdpWTRmaFhBbHZoQ1A3THM0Rko3MzB0VXd3?=
 =?utf-8?B?NVRxcTFwMnFEZm4zcU02VkJmRzNYQ09mMWhhZHlXVUVVRXVRRTdtL0cxVCtW?=
 =?utf-8?B?cUsrV1RUbkthZzgrTkN5bjMxeC9pdWdialNza1hpdDhoampCYlNnOThQUTNh?=
 =?utf-8?B?b3k2UVlTTVFmSTBKOTlsejU1eS9IdWoveWdFckF1ZUJHNHB1N0RaVkJHbTA4?=
 =?utf-8?B?MVBTbklHSWVLeHRsN1diRjk3RGFkeXJmcEZuS0YrSHVualJ2ZDRSbFY3bGht?=
 =?utf-8?B?OFZBR2NKTExiMTdYVW1XRERUMklqa0dPc3lOWjc3M1Q5Q05sbzBmVVFyYS9D?=
 =?utf-8?B?MXZWMFBCcU5jYWlFZjY4ZVg1RUFEN2JXaVZwdjRlREZZM2dKeUxUd0xsMml6?=
 =?utf-8?B?alF3SzlVbkR1cnFRdCtjeW1tMmt2SHRyb0xKcnVRZG5JKysyYlZRYW9FVXNw?=
 =?utf-8?B?WFZPc0xDb1R1ZTJ2MkpoVnVBcm9XM2twbXZySEVMZzRPSy8vUWlGaE5CNDd6?=
 =?utf-8?B?bjhNWE1DWkU5NkFNa3E0T0d6bmRVcEN0amc0OXU2NW5IZ1dWN2xER0Fpb2Zp?=
 =?utf-8?B?Zkxwd0EvbERhZXV3bTlGNFR4YVh4RFZwRWhxWWtQUmJlRm42SVJBcXFvNStz?=
 =?utf-8?B?cTA0UUFyRWl4aTh5ZUt0RlkyNGJZSGpyRkVTRjBRR1RSMS8xU3llSmVkZVV1?=
 =?utf-8?B?U3dTOHBwcU9LNkIxRzBublYzWG5takNCWHFFMTdJcnJCK2kwc3BuWEdtQUtF?=
 =?utf-8?B?M0FiOHFFdytBRWVESm84Vm1PaTRwVEY4OEd2RVViL0M1Smt1ci9lUXlCQjRq?=
 =?utf-8?B?OTJNb20rbTJtbFNMRThvNUUzVVFoNW1IOWY4bFRXaUhjcExDNERsaWpoZWRV?=
 =?utf-8?B?Y29vdnRoMm9wUi9ua2Ztb0NjN01tQnBZOW9vaUZvUEZTTTNvTlo2Nm9FRFNC?=
 =?utf-8?B?WWRnWUVjY0ZhYlN3cW8rc1hlL3FOY2crN084MW1tbTZyb3VJNjVCU293MlpQ?=
 =?utf-8?B?ME9yQ1ZhOWtDc1ZaSFZXVlNyM0daRENFcmlsVGZGMU1WZm8rMnp6cURRMTVj?=
 =?utf-8?B?YXJwWld5UVJKdUVNQ3NxalpOR3lMMmtqcDRSQUludTVhZE1qcUtWeHA1Sm5s?=
 =?utf-8?B?VE83NzhGbGttRGhDSERvZkNlelhDNDBQTEpxbGdnNmZXTkovbHcyZXQvMVJr?=
 =?utf-8?B?VThNbGZmMnYxNGJEVmlwOUVQM3lSOEtiMW5FQ0VOZUgwUFN0YVUzbzJkK2JY?=
 =?utf-8?B?WlhpZ25GNGg4ZkIyeCthWlBBelNpTTBHRy82RTNZcFZjaExJcVo3cGdLSmpw?=
 =?utf-8?B?ZjdFYk53VHVaeVRMN0cvOFFYYS9WazFiUEg5WkNRb09tUVZlVEZ2c0hBY3dk?=
 =?utf-8?Q?XuMa+f?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnNoUEtnSCtMN3gvdXBhREpyWUxrMzRGSmdtVlA0am45U1ExVENBZFoybzBW?=
 =?utf-8?B?dnhHVEhaVFMvN1ZsMHlvWndXbEJQeWtub0tXU0NhYUtvTHVmUTl2TkgrYWkv?=
 =?utf-8?B?RVliT0cvK3hNMjFwMkxzNVkrNW5iZ1RlUUgwbzdUZHZlaE5OYzEzaXNpaEVx?=
 =?utf-8?B?V1k4bUhJVElPSDA1VzhHbkR2cVlzMmlpazdPZW1WK0hBN2NPd3hNbnRLV2s2?=
 =?utf-8?B?UUJHOERSZU1yL3RPNmtJSlhNOUpOdmxvY0p0dzY4MysxbUI4WWhMSHhlcDEr?=
 =?utf-8?B?NHNKdTUvZHRYTU04NjlOVGU0ZkQ3c1RncVFRc05xMWwxeGwvN2xDMkh1ZjVE?=
 =?utf-8?B?N1pkMGNRRWhxRE5idVd4aGEwM2ZRaGthUiswRFpGT1FHSVlQdXRGVFZETSs4?=
 =?utf-8?B?TTIrTTJEcTM0bU8xWVJ6Z2llckN0WkIyZFFOQ3AxM29qZ3hZelhjRThxNjYw?=
 =?utf-8?B?WDA2ZDFMMVlFZUtOdU12UWJWZ21ZbVY3SElQOWhRQjdBTXA2cUduNFZNRS80?=
 =?utf-8?B?TncyMFpDUGtDQy91N0ZkVHJSbjFwbkE3RVVwT0NFOWhMdjhYSlFkamRHZ3pJ?=
 =?utf-8?B?TUo3RGdabGFPM0Z1OGxYUFpRTUVud3ZsakZkajB5bEpqakRWMnNHQTB0bXl4?=
 =?utf-8?B?b1lXMkFiSDhWQzZzaXNMTGwrY2d4YnJtQTVlMkd2a1JSL3B6bS9jYXo4eFo3?=
 =?utf-8?B?T1p2N0Q3M1IyOFVSSDJzNkFRQWJPSTdrSjY3R2NkTmxQcnpON1VpZ0VaN1dH?=
 =?utf-8?B?aDVLcnFkeFpWNzVacnF6N2xrdnlrVU1sQjBwWGVyM3dUdkpJL1dEbTUwNENj?=
 =?utf-8?B?K2ozVlBTeldwdUc0bWd6eWdyamVQZFZNLzVCY3lCKzBHUXlXd2hrQ214Vlpm?=
 =?utf-8?B?RTY2WHhBV0RleFNxYkx1cnNDTzJPb2hQd2NiNmc5MUw4S0ZMb2xqWXRiM0t0?=
 =?utf-8?B?WWR6T2JYcTVoMFRQOFI2a0J5ZnYrbURzMm94MlQrRWtZZHN4YWFnR1BXMnJq?=
 =?utf-8?B?dTJNZWNibGlMRUVZd3ZjdWhIOWYzQnhGOGJHU0NyQkZXcU1ndnZpYm5Ka2p1?=
 =?utf-8?B?UlFlUWUwS20yckdwMDFpSHpjYktLYUVYcUE5TVdGT0J1VW1KUkRVejlJQjMz?=
 =?utf-8?B?MDZxbTh1Zm9CK3VON2JhT0Q3NjFnN0dEaDdOTm8zZ2ZaMkdYMGw1d29GYVZO?=
 =?utf-8?B?YlNxNmUwSVlLSDFjeEtWb0ZSbTlpQTFrT0hTNnNUeFMvS0d2VWgwUFZCNHdY?=
 =?utf-8?B?VEFKRWhtbXI2ZlRHeWpONXloZVAyZTZwa2ZraFhFN2lpbWJ4b1d2ZVEzOStq?=
 =?utf-8?B?R0xLVGdKVDdnNTQrejE2NzBPcTFnL0FhZ01FT1FQQUtKWHRhMCtwaWpvRFVw?=
 =?utf-8?B?VzArbHAwWXBGVkxlOGN1c0lYclRWRXBzQUJJQkhqcGVYd2RHdDBURVhwZEE1?=
 =?utf-8?B?cS8xNjhzT21PY0VqcHFCMmlkTXR4bjFvVnpIcitxbC9uYlpoWTJMR2Nvd2dN?=
 =?utf-8?B?M0FVSHZnVHlUQ0NuQ1pOdHB3YzB1MnVNOEVyZ1FhZmlBbFoxNnIwelVCTmRM?=
 =?utf-8?B?dm5iOGNSNlViWHp2M2cvR3diN0JmNkp2RlM3MERQWHl4QjRRWm5KcHpJbHQ0?=
 =?utf-8?B?RURwMzkvZzN1VStEbncyNHh0a05RS1UwWmtkbjVFNlhlY0dhcWdydjV3eldo?=
 =?utf-8?B?NE00K0xZVC9mYWFza2N5QTJhc0hMWkZoSHBFMUkyVmFEeDMraGJkWUE5RVZP?=
 =?utf-8?B?QmhEYkJ0OTQxT29YYW5qSWJvekJ4dk51NThyOGROcVVuVlNYd2xuRVpPTkJL?=
 =?utf-8?B?dkdzL2R2ckVEYVZobUpFTTA3WDNmdXhzOE5oaWxhbTdPL0NITXdLeVVNa1oz?=
 =?utf-8?B?dlRkVVloRGZFZ0VpY0VtTEF0RThVb2FsTlhSelkvNWtpMFRXMWFBQzY1bUl3?=
 =?utf-8?B?Z2lFNlF2bGdxNnU1c3Q5MXJLNmFUU0x0OWFSaEYxdTVCL080UDFheWdBb1lW?=
 =?utf-8?B?UWZDT1NEb3NBdlJjT1VHR3FkZDZkYkt0OG4waFhkZko3TXhmNDEzVEpmNlhk?=
 =?utf-8?B?MGpZdjltQVVkNEZxN2VROTR1TU5HbHQzVUdQazloQnM0eEE4dFdsQStLYU8z?=
 =?utf-8?B?UkdMVXE1SEZ4aFlqMVRJYitENXRmR21lbDNjdWtxdlArTnJldE54UWFBSTJ1?=
 =?utf-8?B?eEZ3ek5wTGcrYVJyMHozZk5HRXFYQ1BUTnRqbkFZN24yV2crN1NlcVAwTDRo?=
 =?utf-8?B?cjRSZ1dyUHU2VWJxNFR1TGI0b0V1SUdXR3FuVytTelljVDBmQU1ic0FwalJu?=
 =?utf-8?B?QytFNlBBNGJCdUZTK3hEaWxLZTVGYTlPZHZUZkdvTE1pWWt1NmN0QT09?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f94728-3354-4321-e503-08de48587ab6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 10:36:38.8428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfMFBKrbamwiEe+FHEiIjB0yQJ1LUNyyWh8MieUnmWG7esBKwghog9S8gvCfkrYQQ9Vyu1tsr2q7ONUZgryNyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6546
Received-SPF: pass client-ip=40.107.75.131; envelope-from=wafer@jaguarmicro.com;
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


This patch series adds support for VIRTIO split indirect descriptors.
The feature is VIRTIO_RING_F_INDIRECT_DESC.

Eugenio hs submitted a patch: vhost: accept indirect descriptors in shadow virtqueue
https://lists.nongnu.org/archive/html/qemu-devel/2025-12/msg00056.html
Therefore, this patch must be applied first.

The current svq implementation can read the indirect descriptors provided by the driver,
but it cannot use indirect descriptors when interacting with the backend device.
However, if a backend device implements indirect descriptors and wants to use QEMU
to validate its indirect descriptor support,
then QEMU needs to fully support indirect descriptors in this path.
This series is intended to provide that full support,
so that such backend devices can be properly tested and validated via QEMU.

Multiple buffers are used to store indirect descriptors, and each buffer has a size of ring.num * 2.
Each buffer has two states: FREED and FREEING.

When adding elements to the virtio available ring,
descriptors can only be allocated from buffers in the FREED state.
If the current buffer does not have enough FREED descriptors,
its state is changed to FREEING,
and descriptors are then allocated from another buffer in the FREED state.

When retrieving entries from the virtio used ring,
descriptors are returned to the buffer indicated
by the buffer index associated with the element.
If all descriptors in a buffer have been reclaimed,
the buffer’s state is changed back to FREED.


Performance (pps) was evaluated using testpmd, comparing three scenarios:
1) fully indirect descriptors(apply this path series, indirect_desc=on)
guset<--------indirect desc-----SVQ-------indirect desc----->device


2) hybrid mode with indirect plus chained descriptors(only apply VIRTIO_RING_F_INDIRECT_DESC, indirect_desc=on)
guset<--------indirect desc-----SVQ-------chain desc----->device


3) fully chained descriptor mode(don't apply any patch,indirect_desc=off).
guset<--------chain desc-----SVQ-------chain desc----->device


The results show that the fully indirect descriptor mode achieves approximately 5%~10% higher performance than the indirect + chained descriptor mode,
and approximately 12%~17% higher performance than the fully chained descriptor mode.



The raw testpmd output is provided below.

testpmd configuration:
1) set txonly; set txpkts 2048,1024;set burst 8

  fully indirect descriptors:
  ######################## NIC statistics for port 0  ########################
  RX-packets: 256        RX-missed: 0          RX-bytes:  491520
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 74700761   TX-errors: 0          TX-bytes:  307543211008

  Throughput (since last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:       745609          Tx-bps:  18324096544
  ############################################################################


  hybrid mode with indirect plus chained descriptors
  ######################## NIC statistics for port 0  ########################
  RX-packets: 256        RX-missed: 0          RX-bytes:  491520
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 44153053   TX-errors: 0          TX-bytes:  202580423680

  Throughput (since last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:       674954          Tx-bps:  16587671544
  ############################################################################
 
 

  fully chained descriptor mode:
  ######################## NIC statistics for port 0  ########################
  RX-packets: 256        RX-missed: 0          RX-bytes:  491520
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 48458913   TX-errors: 0          TX-bytes:  212695989248

  Throughput (since last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:       665493          Tx-bps:  16355164120
  ############################################################################


2) set txonly; set txpkts 2048,2048,1024;set burst 8
    
   fully indirect descriptors:
  ######################## NIC statistics for port 0  ########################
  RX-packets: 0          RX-missed: 0          RX-bytes:  0
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 18193774   TX-errors: 0          TX-bytes:  93152122880

  Throughput (since last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:       683537          Tx-bps:  27997687072
  ############################################################################


   
   hybrid mode with indirect plus chained descriptors
  ######################## NIC statistics for port 0  ########################
  RX-packets: 0          RX-missed: 0          RX-bytes:  0
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 18948021   TX-errors: 0          TX-bytes:  97013867520

  Throughput (since last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:       646147          Tx-bps:  26466218232
  ############################################################################



   fully chained descriptor mode:
  ######################## NIC statistics for port 0  ########################
  RX-packets: 0          RX-missed: 0          RX-bytes:  0
  RX-errors: 0
  RX-nombuf:  0
  TX-packets: 15944245   TX-errors: 0          TX-bytes:  81634534400

  Throughput (since last show)
  Rx-pps:            0          Rx-bps:            0
  Tx-pps:       583981          Tx-bps:  23919889848
  ############################################################################

-----
Changes in v4:
  -Use a shared indirect descriptor array to store all indirect descriptors.

Changes in v3:
 -Fix code formatting issues

Changes in v2:
 -Use a static allocated buffer for the indirect descriptors 


wafer Xie (4):
  vhost: add data structure of virtio indirect descriptors in SVQ
  vdpa: implement a statically allocated buffer for SVQ
  vhost: SVQ get the indirect descriptors from used ring
  vhost: SVQ add the indirect descriptors to available ring

 hw/virtio/vhost-shadow-virtqueue.c | 433 ++++++++++++++++++++++++++---
 hw/virtio/vhost-shadow-virtqueue.h |  48 ++++
 hw/virtio/vhost-vdpa.c             |  98 ++++++-
 3 files changed, 533 insertions(+), 46 deletions(-)

-- 
2.34.1


