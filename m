Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16948D5B87E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 01:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVKLc-0007bD-1V; Mon, 15 Dec 2025 20:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vVKLV-0007ae-Cr
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 20:59:26 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vVKLT-0008Ii-5u
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 20:59:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqrE77oToynZssnRnIL+NV5sQxLJq74AhtIlP60+HqZhQxaWhQs4gfE1DeArvJ3ljUSqiVtnShzdYG40ijSGwM9lDuz7JgYdXiR+uM+YgjirWMFADRKkO5UHTnFKY/JhgBDoH8fPo4Sy/GaXAlL3JFrFHNW5VpbqFu/2SX9VHwoEde4Ne/nfsHLMZ5Cus81VqASVFBBKzWenC9DUYSmmN04VpTXOkzMsKZj2jMnvrZGLTpUmRZqXa40ABY5thoBHVKPMo1rstcoUONHSFRLyw2UUX1Uf1evwh8DzDE/vc3fY0j3pDOl7z7gxijZ71QdBeZZNS+Py3s4ocdfIQZ2fsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjUweiFv9rvz3uN50Vylytekpdpd3uMh2EpqODPxgv4=;
 b=gaYNwel92hHZtjDrnwxs0b5kiIQe4551MCtTK6ewlC8q9yDdC/y6chakvn9xMmBPhTuf6pYsOPppMPavGUhcsVvJ4tZQf5iW8x29xy5uisCCxIOy1ynFQ6GnCGXZAbZ8IP3Xxdfz3kK60gxPaOSGsTVSQ0UJh6JVdZqmNGKY5n9qaHE0TD1skC9WgnZniU0iqr3lT9m3KTbNO4jxRk9S61WUPtZ4j7xjYmP/KdHMDpuInwUzt9yDyPcC6UGdm3KJWlflRIk5Q8aVuPDJ8Avat+f5lJJu6gNOusCbuxaHqTgPjmwdrubXQWLfH3ZTw8I+DjBTneozt5tsT2TLdDxh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjUweiFv9rvz3uN50Vylytekpdpd3uMh2EpqODPxgv4=;
 b=N/Yz1FAg7aMMEvDTkC4WQrF0yMOhJyPafX7N7Oy/g9+uxhvDNSnG4CgoKG2aweXiVdX6e4oRu5XeL3YsRGd6WxAvbN4K0fIIueZ2yeKGyfK/qGRdOpQ+EsAdwv/cLLuL1l1/mEXSv8wmwFNI9Hgau2uxkJ1LUyIOKzP95fzUdhoN4XjzLsjcImmZ0Z4CxBpxT8VsWydVI8xeHI0YtkdCQ9zQdkbyXGakGAvR60iRKkdkdpFkpMs+pP18w4I498mFZcmaM9cb02C/KyW/bl2jW8Tlzr2CuKqstamWByMhms6CiTqZiHKxTGedhGm7slVPjiqcuoH9YeKGvDfSEcOpsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by SEZPR06MB5689.apcprd06.prod.outlook.com (2603:1096:101:9d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 01:59:17 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 01:59:17 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH v3 4/4] vhost: SVQ add the indirect descriptors to available
 ring
Date: Tue, 16 Dec 2025 09:59:07 +0800
Message-Id: <20251216015907.6662-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|SEZPR06MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: 3439d68b-a2ba-43e9-6e96-08de3c46b885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFFMNU1jaWV4bzQ1U3dVd1Q4amdueE40dlBHcEpBRHhoMmh6ZllhditLYjZJ?=
 =?utf-8?B?QWN2RTlpRU4weEx0UFhlNVZPemUvdER1cElOaHR5Tll6eTl1Uzh6azhBVmh2?=
 =?utf-8?B?SE9kMEh5WmNKVzdSVkZUTFhITDRQdXRtcEd1VE1QT1BoaTV5bHFON1dWRi9B?=
 =?utf-8?B?NjFIbVNkcmVpVkxsbm1YdGV3bk0wbzBLTjU3LzhFUWo0TERsUnluQzAzaEVV?=
 =?utf-8?B?WWJneTlFcEozaEp5YTdySEpDRXNZT2pKeDVDWmVNSXdzVUg5UU5vL2sxU0tT?=
 =?utf-8?B?SzlramlGVlNvSER0OFBnU1c0RUF5dytSMVFBTEZMZ3lyM2VKb0RyQlFTMm1P?=
 =?utf-8?B?UXdJZ1J4QUxhcWF4N1dYQklsa3l4TWwvU1g2NnVyL3FVUmNGTWlIbXlsdWEr?=
 =?utf-8?B?L3pXb2hVWlZud2x1NjVFczM0cFFYckdvVGVvR0p1OGRRbmp0bnJtQXBlaDF3?=
 =?utf-8?B?TzJTa0hsb2VzU1kzZ1pPbEdzK0J4bmdyY1FhNkUxZU0xMFBHMWM3dC91Mm5l?=
 =?utf-8?B?WEpaVlpnaDVHY3dFMTNDQVc1WHNBWjZXMUhsR0toTEJXM25mcDN5M1pJYTdK?=
 =?utf-8?B?RnFHc0ZZbXJqNkRFVkVRWDBMT29aZDhpWUMyTG9KRUxWSW9TUHhxNkN1Y21N?=
 =?utf-8?B?UE52d2hRR3VYSDJzUUhXZUQvQWd3T0xjZDhCK2hIUzlRc1c1WDhxWGZ2Zm4r?=
 =?utf-8?B?bEc4VlZnVUUveS91UEJwbGtWVDJUQjhCY2E4TDEycGZncitQalFwd01IKys4?=
 =?utf-8?B?L3RxQnZpaUo2SUtoWlZ2TEs4Smd3VHNzbk02RWtybWdVd2d5VnI5MkswMzJl?=
 =?utf-8?B?R3ViVWFuNjBJUUVpbHhNS0lZcmNScXJxQ01oUk5JQldzRXhnWFZSaXcwL1RO?=
 =?utf-8?B?eFFRNUd0RWpuRVVYc2ZISEliQ2ZVTVZ3UmJMRmZHNXdISHFxUFN0NW9Fd2Zs?=
 =?utf-8?B?MmViWlFSQUc0VHBITGtielFzRURHclM5L1lNREtINmp2OEZJY1YzTGFGMVRP?=
 =?utf-8?B?L3VoY2IxL3h5YnRLeWJHRTh2S2hnTW8vUUwvWWFFZzh1V0VpTnMrMmNyQ29y?=
 =?utf-8?B?NGJrdWdnUUZLd0pOSFBYcU5VTVR6VlZNUisyREptYzcrZy9HeFpvbnozVkRa?=
 =?utf-8?B?T0pFTzhPeVg3U2VlRlM1N3haMWVpYXM4cEpvWklFalRQYWZYM0U2QWVSMTly?=
 =?utf-8?B?cDM2R0hyODZ4UUx0YkxtRzRGc3ZqK0dHRDFCMm5DUEI0QmdDZGhHNlBGeWsr?=
 =?utf-8?B?WmVVaEpsVjlHUFJFaDZGR3dQeWRrcHhUbG90Mkx2bkkzQmFPUFZaVGNhRXRl?=
 =?utf-8?B?dWJvQURWVXJJbkZRZmhYbGxWMlNhek8xR1pkcHByTU9nS3BrWmI5NENRNGRW?=
 =?utf-8?B?OUVCYTgvVlZ2OUFldDkybi84cHlEenpTMElxWWQ5WkJpamZMVFVLRWd5ODhD?=
 =?utf-8?B?a2RYWS9TTEhiUnQ1bHlRa0lqZElVakNkZkRrSWRXRlNkcTZheWJGbXhhbEVz?=
 =?utf-8?B?QXBkYktiUHQ1NzBRSjZJRk11YW91NHpkVEJuWFR6elFjdjNYYnhScTZxMUk0?=
 =?utf-8?B?anN1TjJ0QzFaTTJYWUJ6RnJuVm9Eamw4RnpNKzA5eGlKNXd5M1JMWis5M1k0?=
 =?utf-8?B?N2xDejZmYk1Tdk1UbXlvaXBMQzZWbDJ4ZUZrV29DNnJTUEZYai9uS01HcTNt?=
 =?utf-8?B?Q1lacmpsRGNBK3JZTmthMVV6VlBFNU9yN1k1U1F2WVAxQWVYUWJ3RER6WU9u?=
 =?utf-8?B?eElIRnR3RmhwSUF6K25TQ2RZVGFhRjMzVW1BeWk1cC83SDd2Z1dxbk50M3lx?=
 =?utf-8?B?emZidTYzeUJVWXhTNERUWlVhRSthMzh2cG0yRytDYnZ3QzZMSi9UUVZLMWdu?=
 =?utf-8?B?U1lFYkFIN2NzeU81dW9rcExsRlljSWY1UGl1ckx4UVFQejh6aFFhbGhKZXRD?=
 =?utf-8?B?c09FTjQvT3RDNXhEa0pzTEY5YjFCSUNDbysvOSs3cU9tbmRJUlpsUTJ4K0lp?=
 =?utf-8?B?NTdoMHlDdEUvTmpmUkxKaGhmaFpnZHlNbFFqbzVDeUdlVHFvc1IralFXejZw?=
 =?utf-8?Q?I3RaD8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2RoUWhscnpON1BDUFA0QmhZMllpMU9zYmJSTUVZYjFHSzd0bVVGc1pNRzA5?=
 =?utf-8?B?bi9ia1VJRklVSmhTWDN1c0lVZUdjZWt3NEtLNUE1dU5STEhaTldIbGFLUXZq?=
 =?utf-8?B?YlZWOWJaa0g0RXNzTHNYY0FZNW8xejYyWUcyMllVcFRraFhNRG5uejRpRlBl?=
 =?utf-8?B?T3g2YkV6UkRmSTZjcFRRbDRBd25RMndPUHFuQi9zTzloMEhNWVE1NVlXOHJj?=
 =?utf-8?B?UENJbzc1NDVXV3VQeXVvZ3grRDlqaDU2K0dhSDdHYzBLbzhDNTlpNTE3UWJo?=
 =?utf-8?B?UDh0eHFqbkIzTmI0QjJpWm94dUVlRlhidEZKUUJJV0ZUSnhFTDhhWHlaVmJC?=
 =?utf-8?B?VkNEZmlKWUJJdHlpTnBOMVVNZ0pnQVlpV05iWEdIdDhVTm52LzNMRlFRZlE4?=
 =?utf-8?B?V1dONUJONk8yUWc0YnBqSzFKcEt5TTBVckZrc3lOZ21jNDQ2aEJYU1dCbmFh?=
 =?utf-8?B?YWRmREdLMlRYSGZXa0s1enFudUxNODNnbkNoYnhWZmkyYVBqbjQyVUFvWGsy?=
 =?utf-8?B?VFJ4SExIeElRWFMxNHQ5OGllNktLYmZtSk1JZGcybVA5cC9WZ1ZHb0prUEhS?=
 =?utf-8?B?MnJJNG5YVTliR0dRZWxRN0QraHR0eVZCYlpDUnFBNEhLc3JCeWlPcFdmQmI1?=
 =?utf-8?B?ejA4cUVYcXFXQ3Y5L2ZkYVl1alplWDJOVDZVNkVUaE5WeWpVeis5eGhta1VM?=
 =?utf-8?B?K3pnR3g1cjBNYkVoRDNkTkhIKzN0TllVNHRMaWdpdG45WlVoS0xnRkJ5SjlP?=
 =?utf-8?B?a0swQytkaGJ3Y3lCb0dPWFJQWkVDY2ZLaHBzRGZ3UmhLbDJ4M1V1Zmlxb3dC?=
 =?utf-8?B?aFlrQkhtYTM5N0FnTjU2V1BIVGZ6RG1IUHlWMnNxQmJ3ZUNhOVllSDljNXVo?=
 =?utf-8?B?Wi9KRDJDTVZKYWNWVng1SkpuV3JrNFR1RUs3VVFuYWVncXRmTS80bEtYaXNC?=
 =?utf-8?B?ODVtQ0wwVGxWTDFwdVZWWG1zRytjOHlhYmdaR1pxcXZZQmkxV2c4a3pyV2Mx?=
 =?utf-8?B?a0dYUkg2SGFjOVhXU3g1cm81WFFtdXZodEllQWhRazZpcGQrQWdSenVrT2pC?=
 =?utf-8?B?NTZ4ODA0YnNQN1o2S29IZWhBbHNldmlQUnBUa0Vld29qc3dnWWZLUWp0Ykdj?=
 =?utf-8?B?eWlvUGcvUkk2VlZiT1Q0WmltOXExU3RFSzZDdzlpNlhvaEpnUWxTdlhrU0Zq?=
 =?utf-8?B?WDF3TFN5UmVXaUNPOHpQV1JyTUdCaE9FVW5RYXVLVW0zSjlpbG5lUzVWTUVj?=
 =?utf-8?B?T1FiUXZ0RUpqUDZzbmZkTDdNL2ZyNGVsTGo0bkV5V3ZlM0hGRjkxNTJGQ1Ez?=
 =?utf-8?B?R0NPQ3cwN3FnWGk1YktwY2I4a3lzSVl5ekdDTTl3dDM3K0tVcVBQYmlVOWd0?=
 =?utf-8?B?V216NWYxbHpmTUVDUktGYVZZSHF3WlRoUVZhM2NxcVZydGdUQUxJTFJqby95?=
 =?utf-8?B?R3lXV2NkajFzcVI3NURselY1anJCaWZxckU5YWFhQkhLbjIwQVVXSlU2dmR3?=
 =?utf-8?B?M2E1TGw0TmpwYVc4TzVmRERlWUJiQVNTNzN6STY0K3dITTkxTE1nNERacDI5?=
 =?utf-8?B?SFhXMDcrT1ovZ0FtTllEbXhSTll4UWROMDNCNWNWUFJnNjJSc09zMEdCaVFu?=
 =?utf-8?B?ZU1lOUNwdFk3TUFybVZRRUtKVWxKUmFJcWJ6RzF0eFVOMlowNDF0d1BCdkl1?=
 =?utf-8?B?bWlHdTBBQ3Jzdnh0NXVQRGViUStPNk9BWlRNUDdMaFhyRzZSTnlJTE4xTzd4?=
 =?utf-8?B?MUVOcEl3RjViSkVtdFJGeHRRNjNCZDFsdVZsMkx1NVpGbnJuTUV4dTJMUGln?=
 =?utf-8?B?RHF3WEloWUw3VTlZdEE5THl2WS81QkhiZ1owK21EdnpCZS9uVkR6L2JjUmdq?=
 =?utf-8?B?OGxnM1VLaE1IN2FKaUYwblNFaVBEMTYzR2kwQjAxOUZySytPU0RZR2hKRjdH?=
 =?utf-8?B?akNNN00yQnFMalFwOHE1YlIraXoxWTNwL3VTQ0ZaNWUvQ2U3SzBhblNoUlNQ?=
 =?utf-8?B?bGRFelZwWDExK05EczJ2TEs4MFlIejlrV2UxallaNG9sYlhlRm03MXVsOTBo?=
 =?utf-8?B?MUxIWGx6bERHMXlXcXBDSC9pc3VocDZVOGMzMTNvU2xMd01CcU1jcmJ5R2tC?=
 =?utf-8?Q?Msqi42p2OPJu6y5MsYo7v+G9G?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3439d68b-a2ba-43e9-6e96-08de3c46b885
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 01:59:17.7162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itbE+EnRir0GRmo4kOPnh5WfrN/8PLMGuVfAv2YorztQ1S0GxS23DIWxVpGOzzmnzqTpuKN9VJip6m4Q8LG1Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5689
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=wafer@jaguarmicro.com;
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

Retrieve the target buffer from the indirect buffers by index,
add the elements sent by the guest into the buffer’s indirect descriptors,
and update freed_head and freed_number. If freed_number is zero,
or if the current buffer’s freed_number is less than the number of elements,
update the buffer state to SVQ_INDIRECT_BUF_FREEING.

Signed-off-by: wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 257 ++++++++++++++++++++++++++---
 1 file changed, 235 insertions(+), 22 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index adee52f50b..c6064fb839 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -189,36 +189,246 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
     return true;
 }
 
-static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
+/**
+ * Write descriptors to indirect descriptor table
+ *
+ * @svq: The shadow virtqueue
+ * @sg: Cache for hwaddr
+ * @iovec: The iovec from the guest
+ * @num: iovec length
+ * @addr: Descriptors' GPAs, if backed by guest memory
+ * @buf: The indirect descriptor buffer
+ * @offset_idx: Offset for write position
+ * and next field (0 for out, out_num for in)
+ * @more_descs: True if more descriptors come in the chain
+ * @write: True if they are writeable descriptors
+ *
+ * Return true if success, false otherwise and print error.
+ */
+static bool vhost_svq_vring_write_indirect_descs(VhostShadowVirtqueue *svq,
+                                                  hwaddr *sg,
+                                                  const struct iovec *iovec,
+                                                  size_t num,
+                                                  const hwaddr *addr,
+                                                  SVQIndirectDescBuf *buf,
+                                                  size_t offset_idx,
+                                                  bool more_descs,
+                                                  bool write)
+{
+    bool ok;
+    uint16_t flags = write ? cpu_to_le16(VRING_DESC_F_WRITE) : 0;
+    vring_desc_t *descs = buf->desc;
+    uint16_t i = buf->freed_head + offset_idx;
+
+    if (num == 0) {
+        return true;
+    }
+
+    ok = vhost_svq_translate_addr(svq, sg, iovec, num, addr);
+    if (unlikely(!ok)) {
+        return false;
+    }
+
+    for (size_t n = 0; n < num; n++) {
+        descs[i].addr = cpu_to_le64(sg[n]);
+        descs[i].len = cpu_to_le32(iovec[n].iov_len);
+        if (more_descs || (n + 1 < num)) {
+            descs[i].flags = flags | cpu_to_le16(VRING_DESC_F_NEXT);
+            descs[i].next = cpu_to_le16(offset_idx + n + 1);
+        } else {
+            descs[i].flags = flags;
+        }
+        i++;
+    }
+
+    return true;
+}
+
+/**
+ * Add descriptors to SVQ vring using indirect descriptors (dual-buffer)
+ *
+ * @svq: The shadow virtqueue
+ * @out_sg: The out iovec from the guest
+ * @out_num: The out iovec length
+ * @out_addr: The out descriptors' GPAs
+ * @in_sg: The in iovec from the guest
+ * @in_num: The in iovec length
+ * @in_addr: The in descriptors' GPAs
+ * @sgs: Cache for hwaddr
+ * @buf_idx: Index of the indirect buffer to use
+ *
+ * Return true if success, false otherwise and print error.
+ */
+static bool vhost_svq_add_split_indirect(VhostShadowVirtqueue *svq,
+                                         const struct iovec *out_sg,
+                                         size_t out_num,
+                                         const hwaddr *out_addr,
+                                         const struct iovec *in_sg,
+                                         size_t in_num,
+                                         const hwaddr *in_addr,
+                                         hwaddr *sgs, int buf_idx)
+{
+    SVQIndirectDescBuf *buf = &svq->indirect_bufs[buf_idx];
+    uint16_t start_idx = buf->freed_head;
+    size_t total_descs = out_num + in_num;
+    hwaddr indirect_iova;
+    bool ok;
+
+    /* Populate indirect descriptor table for out descriptors */
+    ok = vhost_svq_vring_write_indirect_descs(svq, sgs, out_sg, out_num,
+                                               out_addr, buf, 0,
+                                               in_num > 0, false);
+    if (unlikely(!ok)) {
+        return false;
+    }
+
+    /* Populate indirect descriptor table for in descriptors */
+    ok = vhost_svq_vring_write_indirect_descs(svq, sgs, in_sg, in_num,
+                                               in_addr, buf, out_num,
+                                               false, true);
+    if (unlikely(!ok)) {
+        return false;
+    }
+
+    /* Calculate IOVA for this indirect descriptor range */
+    indirect_iova = buf->iova + start_idx * sizeof(vring_desc_t);
+
+    /* Add a single descriptor pointing to the indirect table */
+    svq->vring.desc[svq->free_head].addr = cpu_to_le64(indirect_iova);
+    svq->vring.desc[svq->free_head].len =
+            cpu_to_le32(total_descs * sizeof(vring_desc_t));
+    svq->vring.desc[svq->free_head].flags = cpu_to_le16(VRING_DESC_F_INDIRECT);
+
+    /* Store indirect descriptor info in desc_state */
+    svq->desc_state[svq->free_head].indirect_buf_idx = buf_idx;
+
+    /* Update buffer state */
+    buf->freed_head = start_idx + total_descs;
+    buf->freed_descs -= total_descs;
+
+    /* Move free_head forward */
+    svq->free_head = svq->desc_next[svq->free_head];
+
+    return true;
+}
+
+/**
+ * Try to get a freed indirect buffer for use
+ *
+ * @svq: The shadow virtqueue
+ * @total_descs: Number of descriptors needed
+ *
+ * Returns buffer index (0 to SVQ_NUM_INDIRECT_BUFS-1)
+ * if available, -1 if none available.
+ */
+static int vhost_svq_get_indirect_buf(VhostShadowVirtqueue *svq,
+                                      size_t total_descs)
+{
+    int cur = svq->current_indirect_buf;
+    SVQIndirectDescBuf *buf;
+
+    if (!svq->indirect_enabled) {
+        return -1;
+    }
+
+    /* Try current buffer first if it's in FREED state */
+    if (cur >= 0) {
+        buf = &svq->indirect_bufs[cur];
+        if (buf->state == SVQ_INDIRECT_BUF_FREED) {
+            /* Check if we have enough free descriptors */
+            if (buf->freed_descs >= total_descs) {
+                return cur;
+            }
+            /* Not enough space, switch to FREEING and try next buffer */
+            buf->state = SVQ_INDIRECT_BUF_FREEING;
+        }
+    }
+
+    /* Try all other buffers */
+    for (int i = 0; i < SVQ_NUM_INDIRECT_BUFS; i++) {
+        if (i == cur) {
+            continue;
+        }
+        buf = &svq->indirect_bufs[i];
+        if (buf->state == SVQ_INDIRECT_BUF_FREED &&
+            buf->freed_descs >= total_descs) {
+            svq->current_indirect_buf = i;
+            return i;
+        }
+    }
+
+    /* All buffers unavailable, fallback to chain mode */
+    return -1;
+}
+
+static int vhost_svq_add_split(VhostShadowVirtqueue *svq,
                                 const struct iovec *out_sg, size_t out_num,
                                 const hwaddr *out_addr,
                                 const struct iovec *in_sg, size_t in_num,
-                                const hwaddr *in_addr, unsigned *head)
+                                const hwaddr *in_addr, unsigned *head,
+                                bool *used_indirect)
 {
     unsigned avail_idx;
     vring_avail_t *avail = svq->vring.avail;
     bool ok;
     g_autofree hwaddr *sgs = g_new(hwaddr, MAX(out_num, in_num));
+    size_t total_descs = out_num + in_num;
+    int indirect_buf_idx = -1;
 
     *head = svq->free_head;
+    *used_indirect = false;
 
     /* We need some descriptors here */
     if (unlikely(!out_num && !in_num)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Guest provided element with no descriptors");
-        return false;
+        return -EINVAL;
     }
 
-    ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, out_addr,
-                                     in_num > 0, false);
-    if (unlikely(!ok)) {
-        return false;
+    /* Try to use indirect descriptors if feature is negotiated and total > 1 */
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
+        total_descs > 1) {
+        indirect_buf_idx = vhost_svq_get_indirect_buf(svq, total_descs);
     }
 
-    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_addr, false,
-                                     true);
-    if (unlikely(!ok)) {
-        return false;
+    if (indirect_buf_idx >= 0) {
+        /* Indirect mode: only need 1 main descriptor slot */
+        if (unlikely(vhost_svq_available_slots(svq) < 1)) {
+            return -ENOSPC;
+        }
+
+        /* Use indirect mode */
+        ok = vhost_svq_add_split_indirect(svq, out_sg, out_num, out_addr,
+                                          in_sg, in_num, in_addr,
+                                          sgs, indirect_buf_idx);
+        if (unlikely(!ok)) {
+            error_report("indirect error, out_num %zu in_num %zu "
+                         "avail index %u head %u",
+                         out_num, in_num, svq->shadow_avail_idx, *head);
+            return -EINVAL;
+        }
+        *used_indirect = true;
+    } else {
+        /* Chain mode: need total_descs descriptor slots */
+        if (unlikely(vhost_svq_available_slots(svq) < total_descs)) {
+            return -ENOSPC;
+        }
+
+        /* Use direct (chain) mode */
+        svq->desc_state[svq->free_head].indirect_buf_idx = -1;
+
+        ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, out_addr,
+                                         in_num > 0, false);
+        if (unlikely(!ok)) {
+            return -EINVAL;
+        }
+
+        ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_addr,
+                                         false,
+                                         true);
+        if (unlikely(!ok)) {
+            return -EINVAL;
+        }
     }
 
     /*
@@ -233,7 +443,7 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
     smp_wmb();
     avail->idx = cpu_to_le16(svq->shadow_avail_idx);
 
-    return true;
+    return 0;
 }
 
 static void vhost_svq_kick(VhostShadowVirtqueue *svq)
@@ -249,7 +459,8 @@ static void vhost_svq_kick(VhostShadowVirtqueue *svq)
     if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
         uint16_t avail_event = le16_to_cpu(
                 *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]));
-        needs_kick = vring_need_event(avail_event, svq->shadow_avail_idx, svq->shadow_avail_idx - 1);
+        needs_kick = vring_need_event(avail_event, svq->shadow_avail_idx,
+                                      svq->shadow_avail_idx - 1);
     } else {
         needs_kick =
                 !(svq->vring.used->flags & cpu_to_le16(VRING_USED_F_NO_NOTIFY));
@@ -274,19 +485,21 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
 {
     unsigned qemu_head;
     unsigned ndescs = in_num + out_num;
-    bool ok;
+    int r;
+    bool used_indirect = false;
 
-    if (unlikely(ndescs > vhost_svq_available_slots(svq))) {
-        return -ENOSPC;
+    r = vhost_svq_add_split(svq, out_sg, out_num, out_addr, in_sg, in_num,
+                             in_addr, &qemu_head, &used_indirect);
+    if (unlikely(r != 0)) {
+        return r;
     }
 
-    ok = vhost_svq_add_split(svq, out_sg, out_num, out_addr, in_sg, in_num,
-                             in_addr, &qemu_head);
-    if (unlikely(!ok)) {
-        return -EINVAL;
+    /* If using indirect, only 1 main descriptor is used; otherwise ndescs */
+    if (used_indirect) {
+        svq->num_free -= 1;
+    } else {
+        svq->num_free -= ndescs;
     }
-
-    svq->num_free -= ndescs;
     svq->desc_state[qemu_head].elem = elem;
     svq->desc_state[qemu_head].ndescs = ndescs;
     vhost_svq_kick(svq);
-- 
2.48.1


