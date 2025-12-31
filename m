Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C693EE6425
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Dec 2025 11:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vatvc-0008KO-2M; Wed, 31 Dec 2025 05:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vatvW-0008JP-OF
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 05:59:38 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vatvU-0001iK-F0
 for qemu-devel@nongnu.org; Wed, 31 Dec 2025 05:59:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhVWhX1bfm1dU9AeHDMH3o8qQbq32TouGQ7Sd6Pzg1aClJmolwCD5F0S/eT9a+vZnx+kxG4r5NsQu8A6kBlo5as+wDKrnalLW5lN6tMeaqg1WJJWj5DAIQ53N1ePrKfGnjwjnWFXpwci7c9UM3Fr/ABTLqo0/+EnxGX0yeFAr4ktTVUhYgeII85oLTcM4/DvKnTX5WqgIiLFTdXJiMlhXgjF4BMcV68NSoURAUFgvg78J35C6Db5RiS0PQgK+mSyOaF4KZ6Y8fhmsu6+iJGB53rmLNLcMIu5koKs6G/SyZtOgRxEaMO1oBVtS2MYBJXQAV8P5TUesIWpldHxA3Tp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuVUE2s6Z5vS+sQhP3Wre5rP0nh2px6KwivdwSwZRK4=;
 b=KnwoECbCFKnGgUnHDrEhGEZZpQdAbI21yJhd7NYf6mVY+1dyeLvNhpIqvREKZvz0iNTd3L6absgIiWivXiRe9qJpjEXoQsCREDRefPXBMz0B7qQBTLfSOpNxfG0Yfzb9J32VCRBG9svXdZLv3QAhF4PprHGux0QN9ZZPr23gQgZ96l6+ZYg1UZVJfqGvKxCY+w/LwwjxHU7Q3d6Wqao4O5uoAFVftHJ69br3sdiRBC2+BkBlTiLNjvbznN1faTCGGEM3kxB4liu4XcpJ8AhsdrcPjDJwHqxVJ7xtMObTSrT2ZoWj4lE/oB2Vw57QZD/hxEh9xO7i3Jo2FeIr5/Dfhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuVUE2s6Z5vS+sQhP3Wre5rP0nh2px6KwivdwSwZRK4=;
 b=OzwQnfELLUky9h+gUK8aM6exOqeaKUbBNinFW6mE1YVepxE+i54I4odVNNViQWGD4KBEfUM/kLSiBqI/E3oPoaqCAbrNlLmL7otDqF6aegfKO84CcJp2mBVb6qHygYr7fLc4UIuUAzWwF/pjFurz26ZsTk/j9Dt+nlxlU0KdOBFq/NfIVBsNOOwjyVKeY69mKjUdPfRmEW8C6XcyJb4Flqs0LADL8S7EJpSZXr3F88ELKN+76J4fINeTGC/gPNIHt7r7K7vxCqt+ILDyMMaxsyDHQ7j87MiOpEMGTwWwmz8s2WqpQCL4rw5xl8qFSYrRZ2wx145S1X6F/vorHX7Qxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by JH0PR06MB6920.apcprd06.prod.outlook.com (2603:1096:990:6b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 10:59:30 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 10:59:30 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH v4 2/4] vdpa: implement a statically allocated buffer for SVQ
Date: Wed, 31 Dec 2025 18:59:13 +0800
Message-Id: <20251231105913.17998-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU0P306CA0085.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::15) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|JH0PR06MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ac30d9-f51d-4498-94be-08de485bac04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjdOdGh5THphaFE1WlRFUC9jeTVuMW9adUQ4UjRhTHVQZVdSdWhkN0Q0dnNW?=
 =?utf-8?B?U2RvbncvN2M0YTJ1TDU4eHFiSkVpa3gyM0V6V3ArdzdNR2xLRXU0aGhuY2NU?=
 =?utf-8?B?T0xsRXZTQ2tWWC9MVHRuZjlaS2RwcFJGNGlBNjQ3dFF5a294TkVrcksxUXRO?=
 =?utf-8?B?NmhPQVFNMGdZWjZNWDdzaGpWS0k1ZG5KdmtUQm9hdHlwcHpWVmt4Q0lyVWJV?=
 =?utf-8?B?THU2cEdlbEkzeTFSWjloQ1BZNCtSZFNmZll3cDBpNm9ySmp6elRraS9EMzBR?=
 =?utf-8?B?bUN0M0grL1ozZ1ZwY2liS0FsaVVtWDJjSkdoOWVuaC9NT1NBQk9zQmVmb2F5?=
 =?utf-8?B?RFEvY2paZjJncHB6clJ6a2N6MENPM3h6d1E4akl2b1daUXlCVVkzaVlqVWFB?=
 =?utf-8?B?NUU1RWdQclR4bVFMYnROcnVUcWZDNlZTWVlFT05YbzZPaUhUQjRxTlBtdmxs?=
 =?utf-8?B?Y1JHVUE0ZGhibHlpN0xLaGtURVM5NUNUMVJnd0NJL3FlbURVa0Z4NkZiSXEx?=
 =?utf-8?B?Ykt2akZVdWk0Uk84WHRZU0FNVnpETnNjTFNFNG01WHFKeGZMR3FTT0FWNWky?=
 =?utf-8?B?dXhyOXAxNzVSckk2a3ZEMEtFaUdNalJRTEtXZ0hjYnhsanNKeWpwMGEwSVZm?=
 =?utf-8?B?Sm5QZjdmc1prVlZDV1ROWDlxdGRkVm8yai9TR0R4ZHF2b3ZEWUdOamJpQWhY?=
 =?utf-8?B?S0Vyd3IwNktEMnhuaU9uOW12djhlNzhNTVpNM3JSb2Z5WjVRbWh4SVIwVmh2?=
 =?utf-8?B?MUovaENadS84QzZKb3d3V0VXVlJWUHc4OWhzSDBoQlNQSUY5dGtWeHpQNGZr?=
 =?utf-8?B?R3hielA1UUpWUnNSTWV4SWhOTTBPSmFIbjVrYjUzMTdmejVpQmVFRm1HK2pK?=
 =?utf-8?B?MkdsSzNwa3V2M3lwMzBadUJhZUpELzdvL0lBeS9KWS9VYTVZWTMrMG9Wellj?=
 =?utf-8?B?Q2dDcnVmWnNmSTBoenBCK3hYNUlnbTVqdjV5VEdPYmZRNW1mUDYyWjN3dTJt?=
 =?utf-8?B?dDJjcE5VZURhYzdoKzhWV01XcGk1c1lIODAzdmUxaFBEb0xLVnZBdWJBR3lC?=
 =?utf-8?B?eEtLd3lyNWY1RS9CUEZhSkNRZGV4TWNxWWROOWZJRVQ0Qmh5azk5UjF2djhQ?=
 =?utf-8?B?bDJuR1NrVnBxRnNOM0hpQjh1eU50S1BRUHBudXRRanJnNW1KanNuOXZQL3dB?=
 =?utf-8?B?SkVJRFF0TnUrRTVoSVVxSjZBRllJQS9RYzh1QWF6YXF6N0lGczhLdVN5cmdv?=
 =?utf-8?B?ek5mdHJNUnhRdVZvdEUvZlh3aW93bHkvaUtEWjI3dEY2U3VsWDQvUjhjVEp1?=
 =?utf-8?B?bFpaWmpHbVI1dEs2cjFOK2NQYjJTMCtHNWF3Uy8zU04rczlBWWFMb2lFQWNr?=
 =?utf-8?B?Rk4rS3V1SW1kTmVyUTQxc1N4VkdrYm5hbDdZK1cyMGxzL1daczRxTEdxWEtD?=
 =?utf-8?B?dlY2d1pIQkMzUDF0SFFCZEZVd09zS1hNN0tJcThva3NMSzgwWFlua1NFNG5t?=
 =?utf-8?B?b3VzOXo1NjRCbkRySUJyTkdZa2NWdEFZMzZSVkdKRHo3TFpyY3pVckxvL0RY?=
 =?utf-8?B?TDBrbXBwd1VIa2dnbStLN0VLZTNITlhZdjVOUzl2L1hKRkQrME0zcERDQ1pw?=
 =?utf-8?B?akI1UVJVM1FVUTF5RS8vTE9IbkNBL2tkTUYzRmgxK3c4amVQQkh2MzVRZGxi?=
 =?utf-8?B?ZVVCMURNc2prRmFmWGJ4WGNjcXBRcm9pSmdydllXbGlCcGNHMG5nTzY1VFpU?=
 =?utf-8?B?Ky81NFZwbk13SjB3VGQ0NEs3cC9oVmM4aXpSajJBT0RvYzExOXRlUDF4Q3RR?=
 =?utf-8?B?bGtsL252Z2U5S2NDS0JsVnY2N1NScHY4THFKWTBnakY0L3k5bys5WXJOcURv?=
 =?utf-8?B?bnVBY091cVJLRVlIZVJFdHRXVTdGYVNvODlKU3hST2NsU2VBTnhOT1E1SUw0?=
 =?utf-8?B?cVg5dGxpQnNkaXcxL01PVXNCT3FlQU5keWo5ak5JRkprSFlWR0Y5RTB2S0lw?=
 =?utf-8?B?bkJRaXd2dDBwTGc1SEtlUUtiK3poYzlkeHExNlk3V2ZoU25KRENISkQ5VzB2?=
 =?utf-8?Q?Re2ayb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0lBNDllRVQxRnJIZ0V6c1R0YWM5YythOG5TUWVPRWZRYTF3TisrU3Y2M0tk?=
 =?utf-8?B?YWo2cExENTJmZkZzYVBvcVY4SGJZQk13eGlIT3ZWcnRiclE2U01ya1VHOUxu?=
 =?utf-8?B?OHJTbXRDUHY0bytCc3lFODFSNU1ESUo0UkduNG40UGRqNW81Qk1CM3pBdkIr?=
 =?utf-8?B?SHdyYmlucS9XK0JmakZndHZWQzlsRHlJQkhBbzNZZS8rakNjcEhkSktiVW9E?=
 =?utf-8?B?LzVNVEg4a3pnclBuRjZxckNNdEMyZ3B2VXU0UWpoQkJyeENNaDNSdm5jd01I?=
 =?utf-8?B?aTJWQlY1ZnNLQTRBV1hRYWdjZkFOM1krTGJHc0VtZjc4RkhtTjFvK2ZoVUQ2?=
 =?utf-8?B?K2lQVWl6ODdhSEh2RTQvWkxFK1dIZDJHbG1UWHQwMUdpaWJpUGlWUVhBYkEr?=
 =?utf-8?B?R2JZOW5rQnFKbDJZbFVKd1hCcG03Zm9WQ1FBTi9qSmRJb2hpY3hHUUhmMjJF?=
 =?utf-8?B?RnArR1I0V2VKTS8vOWh3TzJ6MC8vYkhiekZMQThXY3RnN1hyN2NMalp4dFZp?=
 =?utf-8?B?aDFzYkVhbFl5Wi9uSkZzR1NxcHBGdEpOYjVIOXN3RHNTSGJWd3BOWU0zUFpW?=
 =?utf-8?B?bGp1eWwvU3NUMEtnVzRqc3JuNnJheUxIdk83NDd1TXBZSkY2aWJJVWQydlhH?=
 =?utf-8?B?N0kyUmJGK0FSWjZrb25HR3pMb3RUZW9Xc09TbzdaZE9HOTJtTDlwLzZqK0Rl?=
 =?utf-8?B?dFc0citIeTdsT3FPYXlMOVJIVnhNOHI4V0wwcDVzVHhtd1QrdTVIbGpUeUJy?=
 =?utf-8?B?dFpRK1hVaHdQamp5emhiSnBOS2R2YVRLQlc4U21mZEJnQ1U1NkNOL3ByaGZE?=
 =?utf-8?B?NEMwbm5SOFR0dmZkeWV2Ulk3Y2FFUkc5SWkwblVWWFVsK2ZmNXl1bVcrc2c4?=
 =?utf-8?B?aHE1Vzg0YUlXc2tTcmhWOVIxZk4vKyt3OWkzYk1OVUQ1bTlZKytENDlDNVRz?=
 =?utf-8?B?aS9hc2tFbFlGYUdUQUhDQ0RPLzVXY25lblQ0ZUVXNFhZTDZIQkprM25BZm5I?=
 =?utf-8?B?cVRlazJncHFsL3h3MlhnRUtkaWZPTHNPdmdyVGJMOEEyZW1nRkZmRDJkUGlr?=
 =?utf-8?B?N2FDbDZTbFdJTEQybWRYaG4zZGw3TVNJWFo4dTNTSmxXNWZXWTN6aWQxVnBq?=
 =?utf-8?B?T0RhUFZQaStVb3pkbWN3TTFsMFFtdW1wVjdJcE1Wb0ZLRGt1K3laZmVzRk1F?=
 =?utf-8?B?L3RsNUkwdi9lZ1JaWmtGOEV6eWlHbVFUSlFCM0hjdGFZS1QrVjd5ZTgrVERu?=
 =?utf-8?B?MEIvOGtQNVVscFNHUmRlUHlpRVF4WTNVOXVXcFZVWjEyQkNGTEhkMFFkbUNm?=
 =?utf-8?B?MDFVd0dHVmtvODVsekY1SkZzajNhNGJMd21ScFRqU2xFSGg5NjBsK05hVXFW?=
 =?utf-8?B?bE5BUHZjbDBEK3IwWVpyZmhTcXpUQUFFRHdFK201NXg3NmRDanhtdUFiSUw1?=
 =?utf-8?B?OG5QWnRpaWFIbGxYWE1qRkRNYkpxcDl1QW10cHcxUlBlelVYRUVYRW5aWk05?=
 =?utf-8?B?SEhsV2ZHbGZmdkpYQXl0dVNkZjhiaFoxVUpPNURuSUZGbzdITEVTbmNrRXRJ?=
 =?utf-8?B?TWFsK0o4UDZvTGhNMU1UV1hVSU5BYXJ5SHdZSnhzcUxWTFo4eG1KOHdwSzBV?=
 =?utf-8?B?d3Fwc1NhSkdkR2plTlFFellhOFpLS0o2bUNCVC9zM0N2QlhLOWlnWFJDNmRP?=
 =?utf-8?B?Vm14MzBFTW9BMTVTdjBlZkFkMEdjMzZ4K0hKam4ySitCbXQ5RjAzWnN3T2xp?=
 =?utf-8?B?cTk3OGw0cjFwbGVvTmNkSmFQUU5sbUJxT0laR3IxQ204akNYVThwN29CTlFI?=
 =?utf-8?B?SGV2REsxcVFtZkhhdnJ2U1FtU0x1cVR2K0k3VnptREtWUVRIM2dxZmxqa2xP?=
 =?utf-8?B?N1ZaaHZoTUkyYXArSlRCdUtPQ3FPL3JaaEhWWHp2d090akxmMzNza3NGUmlu?=
 =?utf-8?B?eGtweW01QVN6d0U1a2JsUUxpcndGWFBmSXp1SjNkUkwwMzJWUS8wdFFnbzI1?=
 =?utf-8?B?Q2dnZlZJNFZwajhVT01IdnQ1NzJaUk1aNjRCRStkbUtSbTkxWEZQeWNoZmNY?=
 =?utf-8?B?VlNzb3piOGNQZmE4Q2MrLzVBemdOUlJhL2drQkNDNFM1UVdxbzQ2bGFiOUVn?=
 =?utf-8?B?WGRYTkhRNnVSRzlFVWJUd2tZYXdoMWdiVjNtMlZXL3lwNC82VktkRlp4aGNK?=
 =?utf-8?B?cC9BZGIvTjY0K1Y5a0gzYmRVQUFJeUFYTlNkc2NySXgzQm9WWkZQVUtGb01z?=
 =?utf-8?B?b3V3eEExc3FkOSsxWDhiSmg1SUdnaDBBbEtYMTl4T0xqTTQ5cWkxeXdEYXZB?=
 =?utf-8?B?L3FZZE1tYjAxY3RUcmNINk1nOUZGQXB2cE5mWkpTbVRDVXk2MGlhZz09?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ac30d9-f51d-4498-94be-08de485bac04
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 10:59:30.1180 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHhgAfcs620DhFirBenloXK8k6zap6aM8YFM/shs/E4ICdWMBPLy6PBBoKRG9lyyfaZH30JF0inzQRDeuewPEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6920
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=wafer@jaguarmicro.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

From: wafer Xie <wafer@jaguarmicro.com>

allocated and initialized when creating the vhost-vdpa device,
and release the indirect buffer when vhost-vdpa is stopped.

Suggested-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 28 +++++++++
 hw/virtio/vhost-vdpa.c             | 98 +++++++++++++++++++++++++++++-
 2 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 2481d49345..f80266fc03 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -708,6 +708,28 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
     for (unsigned i = 0; i < svq->vring.num - 1; i++) {
         svq->desc_next[i] = i + 1;
     }
+
+    /* Initialize indirect descriptor state */
+    svq->indirect.desc = NULL;
+    svq->indirect.iova = 0;
+    svq->indirect.size = 0;
+    svq->indirect.total_descs = 0;
+    svq->indirect.enabled = false;
+    svq->indirect.current_buf = -1;
+    for (int i = 0; i < SVQ_NUM_INDIRECT_BUFS; i++) {
+        svq->indirect.bufs[i].start_idx = 0;
+        svq->indirect.bufs[i].num_descs = 0;
+        svq->indirect.bufs[i].freed_descs = 0;
+        svq->indirect.bufs[i].freeing_descs = 0;
+        svq->indirect.bufs[i].freed_head = 0;
+        svq->indirect.bufs[i].borrowed_descs = 0;
+        svq->indirect.bufs[i].state = SVQ_INDIRECT_BUF_FREED;
+    }
+
+    /* Initialize desc_state indirect_buf_idx to -1 */
+    for (unsigned i = 0; i < svq->vring.num; i++) {
+        svq->desc_state[i].indirect_buf_idx = -1;
+    }
 }
 
 /**
@@ -748,6 +770,10 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
     munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
     munmap(svq->vring.used, vhost_svq_device_area_size(svq));
     event_notifier_set_handler(&svq->hdev_call, NULL);
+
+    /* Reset indirect descriptor state */
+    svq->indirect.enabled = false;
+    svq->indirect.current_buf = -1;
 }
 
 /**
@@ -765,6 +791,8 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadowVirtqueueOps *ops,
     event_notifier_init_fd(&svq->svq_kick, VHOST_FILE_UNBIND);
     svq->ops = ops;
     svq->ops_opaque = ops_opaque;
+    svq->indirect.enabled = false;
+    svq->indirect.current_buf = -1;
     return svq;
 }
 
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 7061b6e1a3..a1f4e501e2 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1142,8 +1142,27 @@ static void vhost_vdpa_svq_unmap_ring(struct vhost_vdpa *v, hwaddr addr)
     vhost_iova_tree_remove(v->shared->iova_tree, *result);
 }
 
+/**
+ * Unmap indirect descriptor buffers for a single SVQ
+ *
+ * @v: vhost_vdpa instance
+ * @svq: Shadow virtqueue to unmap
+ */
+static void vhost_vdpa_svq_unmap_indirect(struct vhost_vdpa *v,
+                                          VhostShadowVirtqueue *svq)
+{
+    if (svq->indirect.desc) {
+        vhost_vdpa_svq_unmap_ring(v, (hwaddr)(uintptr_t)svq->indirect.desc);
+        munmap(svq->indirect.desc, svq->indirect.size);
+        svq->indirect.desc = NULL;
+        svq->indirect.iova = 0;
+        svq->indirect.size = 0;
+        svq->indirect.total_descs = 0;
+    }
+}
+
 static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
-                                       const VhostShadowVirtqueue *svq)
+                                       VhostShadowVirtqueue *svq)
 {
     struct vhost_vdpa *v = dev->opaque;
     struct vhost_vring_addr svq_addr;
@@ -1153,6 +1172,8 @@ static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
     vhost_vdpa_svq_unmap_ring(v, svq_addr.desc_user_addr);
 
     vhost_vdpa_svq_unmap_ring(v, svq_addr.used_user_addr);
+
+    vhost_vdpa_svq_unmap_indirect(v, svq);
 }
 
 /**
@@ -1192,6 +1213,74 @@ static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
     return r == 0;
 }
 
+/**
+ * Initialize indirect descriptor buffers for a single SVQ
+ * Allocates one contiguous memory region shared by all buffer segments.
+ *
+ * @v: vhost_vdpa instance
+ * @svq: Shadow virtqueue to initialize
+ *
+ * Returns true on success, false on failure.
+ */
+static bool vhost_vdpa_svq_init_indirect(struct vhost_vdpa *v,
+                                          VhostShadowVirtqueue *svq)
+{
+    uint16_t num_per_buf = svq->vring.num * 2;
+    uint16_t total_descs = SVQ_NUM_INDIRECT_BUFS * num_per_buf;
+    size_t desc_size = sizeof(vring_desc_t) * total_descs;
+    size_t alloc_size = ROUND_UP(desc_size, qemu_real_host_page_size());
+    DMAMap needle = {
+        .size = alloc_size - 1,
+        .perm = IOMMU_RO,
+    };
+    vring_desc_t *indirect_desc;
+    Error *err = NULL;
+    bool ok;
+
+    if (!svq->vring.num) {
+        return true;
+    }
+
+    /* Allocate one contiguous memory region for all indirect descriptors */
+    indirect_desc = mmap(NULL, alloc_size, PROT_READ | PROT_WRITE,
+                         MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+    if (indirect_desc == MAP_FAILED) {
+        error_report("Cannot allocate indirect descriptor buffer");
+        return false;
+    }
+
+    /* Use vhost_vdpa_svq_map_ring to allocate IOVA and map to device */
+    ok = vhost_vdpa_svq_map_ring(v, &needle, (hwaddr)(uintptr_t)indirect_desc,
+                                 &err);
+    if (unlikely(!ok)) {
+        error_report_err(err);
+        munmap(indirect_desc, alloc_size);
+        return false;
+    }
+
+    /* Store shared memory info in SVQ */
+    svq->indirect.desc = indirect_desc;
+    svq->indirect.iova = needle.iova;
+    svq->indirect.size = alloc_size;
+    svq->indirect.total_descs = total_descs;
+
+    /* Initialize each buffer segment */
+    for (int j = 0; j < SVQ_NUM_INDIRECT_BUFS; j++) {
+        SVQIndirectDescBuf *buf = &svq->indirect.bufs[j];
+        buf->start_idx = j * num_per_buf;
+        buf->num_descs = num_per_buf;
+        buf->freed_descs = num_per_buf;
+        buf->freeing_descs = 0;
+        buf->freed_head = 0;
+        buf->borrowed_descs = 0;
+        buf->state = SVQ_INDIRECT_BUF_FREED;
+    }
+
+    svq->indirect.enabled = true;
+    svq->indirect.current_buf = 0;
+    return true;
+}
+
 /**
  * Map the shadow virtqueue rings in the device
  *
@@ -1299,6 +1388,13 @@ static bool vhost_vdpa_svqs_start(struct vhost_dev *dev)
             error_setg_errno(&err, -r, "Cannot set device address");
             goto err_set_addr;
         }
+
+        /* Initialize indirect descriptor buffers for this SVQ */
+        if (!vhost_vdpa_svq_init_indirect(v, svq)) {
+            /* Non-fatal: will fallback to chain mode */
+            warn_report("Cannot initialize indirect descriptor for SVQ %u",
+                virtio_get_queue_index(vq));
+        }
     }
 
     return true;
-- 
2.34.1


