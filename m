Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B76CCF2591
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 13:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLiHE-0000QS-Ad; Wed, 19 Nov 2025 08:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vLiGv-0000CV-M1
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:31:10 -0500
Received: from mail-koreacentralazon11023076.outbound.protection.outlook.com
 ([40.107.44.76] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vLiGs-00083e-Cj
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:30:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+DUIvEwWay6UNCjjHdlIEnmMhRCMCM4les7I6ojfbGMcZbUlMQZeosYT0Gt3BpxMcL0t3itJ6Cu8AqzniM5eOtgiqe1Ov35pSAIvSkj52xiwkv207BRqSel6+Wme16gSLm4NFipD2VmlXu7MI1y3QgYoEa+lBuA5BF4RPHF1A9Ltcfkkv+GSOzoBFx+4MiNKgKq+ZUjb/yKrVZpWXoe48ZFGCn70GW8MnPDdyS1U9krNxpHXa7avU9TuQTwhjb9K2CJwyAQR3CFzlFYI8vxgbMPP81TqB3c9YFcY0DlEUhuWxTt3NDgrvPssNQMHjeSPXM7r3M9Zfp4RHo5upZMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8p0tB2UirV8EybR9vfQNNJxkGMqcPWptQzKw6ScmWU=;
 b=og4KZVEdf56nXZRs6LNOfJyja2CEzILwlutS8z/e4iRU5Hs54IjDJEyp/AJXEF717IdNzSqAKLbXqIUnTfHdc0GSNHnv1i0VPMM+c0tIxV7WV+5T2ymxKEF4/I60rPH40kcnSYC2Toqfqa49mE4+OhHIs4Adu8efWBcrFV/rsYhc+4Xy6F4CBA6YcH9PxPri1bktVd+tO0e8KUV+Aw+SE5EqfmbJsA2WmR/lO75yLUFxTpZk9lhKKYnluuQjmXVryT9UKipj7iI9+ZHEnHsUhpBNhkZmaCrB4qFOKLC2fVg8/n9Fv4drFf/5JlaqaJdp7uil14QQ+czyCND9CE4Mpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8p0tB2UirV8EybR9vfQNNJxkGMqcPWptQzKw6ScmWU=;
 b=ceJGIFGq9je3+LPUr8RUAd+f8yMOPHDPLhDVLf26BjyiGQTuq80IyokCeRVGUpciqJZzdoD2XX0Q0eegqyx42PcjtjQFkeBTl3Z2DGS/yV84FHSV5t0HCFc5GE1qXL4lWcyHy36KXiNEOplHHUiTwEamf9OwR4IkKpT3V6mbLQYU3LPE721ToIavYVr68EF9ycPRuh5PP+M2PnMGDsFLAYmOwrcskS26lBEoGdhvWq9yMfOQYafAiGg5OkRO7n6cYcmozK7mXenFBwUyZ21JT13qmrU0uulhGhbYJgvdQkjJjS8B4/Lv/4vv8plZQdaLMRNgU41PAHoCvoCWh/DVfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by SE2PPF89892336B.apcprd06.prod.outlook.com (2603:1096:108:1::7e0)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 13:25:44 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9320.013; Wed, 19 Nov 2025
 13:25:44 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: qemu-devel@nongnu.org, eperezma@redhat.com, jasowang@redhat.com,
 mst@redhat.com
Cc: angus.chen@jaguarmicro.com,
	Wafer Xie <wafer@jaguarmicro.com>
Subject: [PATCH v4] vdpa: fix vhost-vdpa suspended state not be shared
Date: Wed, 19 Nov 2025 21:24:52 +0800
Message-Id: <20251119132452.3117-1-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:820:c::22) To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|SE2PPF89892336B:EE_
X-MS-Office365-Filtering-Correlation-Id: e1739fab-58ff-4e1d-5c00-08de276f243c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1p4YWFqcDBXaDdEKzhvc3grUEs0WCtZWU4vUGwzSVNhRmw3Z29GbkxPSE4x?=
 =?utf-8?B?MEdBTTVNdFRHc2g2Q3RTTXpCYVJtUFZQV0NOR3V2MVBKdFIvVjJHeFd4cjAv?=
 =?utf-8?B?dGVMUmpqN1RzNEprcWxVYXZHQWVuVnFQNjBPZUI1R1NFNlVOdUw3OTR5WjY1?=
 =?utf-8?B?cC9tQ0t0WGRobWZSbDlNTkhDYTZoeHhPY05yNzNMOHpFVEVNeldnRnlub3Zr?=
 =?utf-8?B?dVk5blVIeXFpK2duVWxheXI1TWErUmMrN3ZlcDBXQXFSYXR3TW1Jc0lwM1ZR?=
 =?utf-8?B?NXZrSStxODFKZmRiZm9rWitDUll4TWptMGVVaGM1cHM1TmlNcTk2RHlXZC94?=
 =?utf-8?B?U0prakI0QVY1b0dMNzVLWVRuK0VLU0NEaXJUa3hMN1ZxTjlwaTRjdFNBT1FU?=
 =?utf-8?B?eHdwWXZkUC9JVmhuQTNERXZJUDRPamxpMzh4MkpkelNXL3VFTCs2aFpGOXFF?=
 =?utf-8?B?d0dtRkprWEZJTkRGazhtMHJyRGVjMjVmTGxTVnI4SWU5bStyZzB5RXRTcWNv?=
 =?utf-8?B?NmVHWUk1Z2gyd3piZGdnSy9obXJMdGU3bE1yK0c5Z28zVHU2VjZ6NFZNcVlv?=
 =?utf-8?B?dlN2SjNNQWNINXVYYXJqM3Vobk9yaTV6ZUFLQWN0L2FaZ1ppR1p4eGRLS1FE?=
 =?utf-8?B?V1VTRDE1TTZCM1RFQWFqZWpvL3ByWDFMUTVmc0sxU2dqZG1kd0NLN2Yzdi9Z?=
 =?utf-8?B?bnd3YzhEOTFzc0o5WUhjNjZNMithSHZ2elI5OTRoZCtSMlNqWnJ2dEJKM1JO?=
 =?utf-8?B?TmRLYzJ2N251SWNFMmRmVVk5ZXFWcWkzbGRESmFyYlozNktya3VpdzBaSktm?=
 =?utf-8?B?Y1p1eUN3Y3BPOWNJRVpnbGJKcW9FWENmcWNRNVN2QXdrQjdWTTc3M2F5RVRU?=
 =?utf-8?B?WjlrcGl6d3NiVk1ua2piOHNUUk14SEk4d0ZOUWFKeG11dzl1VzF0UzlsclVR?=
 =?utf-8?B?L1VURzdsZng0LzZRTjMwU0NQN1M5S01ka3dUWWRuNjc0NjBXeHROY2RQZXc4?=
 =?utf-8?B?ZkFEVVhKYlV6WHZucjN0cTM4TkJ0eVphM3N0bnZiOVhnY2ZKSjlOdUJVaUJB?=
 =?utf-8?B?S1NyQUpvL2hyb1k0UFQ0bXRMOHVTNjlvUzBKTlJuZWlhb3dwN0ZOUmd5cE9U?=
 =?utf-8?B?ZGpwZFhuNWFKK2tiTU91ME9sODBZQ0h0R0wxS3J2S2UxTEdzZERUc2dnNkFq?=
 =?utf-8?B?T3FMRE94a1U5VThSZ1dMbDc2eGliemhJcjNReHlyYUpVcGJyTS80U29NNmND?=
 =?utf-8?B?c3FhV0NvWWVIVkJ1bFFFNGRJQkczeTJ0QndlRjB2VlFqYktaa3YycC9ZUFpH?=
 =?utf-8?B?eDJNckh2VHcrT1k1cVNmMDA1Y1hmU2IyWTBxM0xpWUM1WTRHcXpnYkZYTDZ3?=
 =?utf-8?B?Mmt4Y21YT1ZYcFBDWUd0VmJpWEJoYlpwMUV0VmV0VUs0OHhGK1JCZmxqNlFp?=
 =?utf-8?B?MVZWTmFGd1h6czRBUmJDZlpSdnVOV2FYMGo0OWk2SVFDQkovYmRwUjAzeTBY?=
 =?utf-8?B?c1BOcWU1TG9VWUxJL2tmaFU1TDVTOEVIMWgvTExTaVJRTDUrWG9xSTN3Qy95?=
 =?utf-8?B?bmNpdlo2ZWE0YTd5WDFGaGtHVTB5UWVlbC9xUXRycEtFMWZVaXpFZTdxRnhj?=
 =?utf-8?B?M3ZlM3o4OHU5RVV3aHRrTitIcWp1YlI0R0lWa1pSM3JlU3dQYlZ6RUtJcGpU?=
 =?utf-8?B?R3RvbFZrdFE1Um9xaDBsUG9nSTBJZXJHRjZuTHRjcHc3UFNya1FoUld4dExK?=
 =?utf-8?B?YWVFOXRKQkkwYy9NSVhFa3BlZExmdHlmU2F0NnRRc1dyNVBYOU5JVGtDa2N1?=
 =?utf-8?B?ck81MHp2eFdac0lCbnNEL1B2Z3FOZmdWQk1GK0pPRU1lbGpMNGpkQU1wZm0r?=
 =?utf-8?B?ZU9RNnE5RVEyWE5HYlN3cTYxZHQ1VlRJbUFITWNhVHB6R0V5VE45Y0FkbEh6?=
 =?utf-8?B?V1VWT21YWnJ4TWNOazJ6eWRzN3NWVGxEeXlNcjFSTERsMTNxTmxtWnp1Sldx?=
 =?utf-8?B?bDkyN1VzUE10VC9VTWZvYXV1VFpxMkEwUzNGd2g4OExzSmt4WVZkamtqRGYy?=
 =?utf-8?Q?9gUuqK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzVVb1dCa1hZdXNlSGZBZEg2dENkVU91VWtaY0U0ZUJrTmwyVHZCZkdpSi9r?=
 =?utf-8?B?SVVSOHUyb3ZadXhqZEkzQlZtUkwxMkk1Sm1zVVMxaDhPYXdHcjZyd2ttVFdy?=
 =?utf-8?B?amc3RTJIM0V5SEZvbGtyTUVCTGlhMG81RVU5d01QT1RUUHplSUhuSDRmMjJO?=
 =?utf-8?B?cHJ3YTNacXhyU3lTSklub3ZyaVNHNE5vQ3UrUGZaU1o2cjR5RG10bENUb0ZV?=
 =?utf-8?B?cWdTZjdIUlJjQXJEaEF0TDYxLzJiK0k1MjRaVW9jcCsySWloT2FjVXpQd0xy?=
 =?utf-8?B?T3RQVGszSVEyQ0UyaUgxWkNMdmh2enY1UElQZjgyZEZrNHg3ajQ3M1FFK2o2?=
 =?utf-8?B?Y2ttcUJOSldqQXozYllaOHhaSm1jcmJZV2tNVGVFNkFQVU1sK255bW5QWVNx?=
 =?utf-8?B?aUN3MFF3OGFKci8yK0tXQjk2akhjS3VsUjJOM2JweFRVdW85V1BCMlN4UUZx?=
 =?utf-8?B?WSs1Zldqc1FmS0hVYWxtWmhsdnoyaFNWdkthdlJaOWNKWTc3NmxXMFpnYTNK?=
 =?utf-8?B?MHFkSFRCR0tXenlRMWJvcHFRcS9ic3BDc0RxUlRMaWNKdTRPcVFKVkJsNHAz?=
 =?utf-8?B?ZEI4TktXemlZNU5KYzBTMDZaZnRIT0ZHQnZQL3lTUkNyclFzK284ZkllbWhx?=
 =?utf-8?B?L0Y1azRDL0NzS3loWUdjZVdUOUNVTXlhZURTZzR3L2tFQjZtbWNHS3lyQkJz?=
 =?utf-8?B?RVhpVUg0Q0ZNZmg4ZUpxaWVaNlU1N21rOWJXTXErYmpoZER6Vjg4M2JyYS83?=
 =?utf-8?B?NlB6UkF2bEo3Wk1UdklwVEZrUDRWZ3ZWSGZ3OTJVaHcyLzA2V3BEc2tURy96?=
 =?utf-8?B?L3hTODBxK1JDcFdNN3BPT1VpK01BVFhyeUdDRWJnSG0xTGppZmJZQ3I3ZnNz?=
 =?utf-8?B?RDc1N2dwN0Z2aVlXSXE4UGVnYWxDTzd4NmE5ZittWXlBdGhVemNlYXkxM1NF?=
 =?utf-8?B?dktCeThDaFpoMXJublFXNldjeHNHLzFIbXljTnhPT2FEZy96czB6VWhkSm9q?=
 =?utf-8?B?cGZmS3dFRmZhRXdsb3ZsenBVQ3NTbEsrQW5PYXlYcy9ES2tndHJpYi8wUFZZ?=
 =?utf-8?B?ZFdlODR2QkYzVHhtSFNUU3VFNkFvL1pveDdCS0hONEg2UGk5dFpWTzVJc0pQ?=
 =?utf-8?B?UGJnNGxUK21xaHFBVVJnMHNrb2RxcENET2NBV2JWbDBBV3FOcnhFVGxXWE1Q?=
 =?utf-8?B?TUNzOWN2UHU4VFZ3RVhxZGN0SG1LMjl4V3crZHg5Z2FJMEEybGI5MkdmVkNB?=
 =?utf-8?B?c01ZZ05TSThvandzRHpEMEdFR3lzYy83VjF1aW5udlNER09CeU5iWkpyZWkv?=
 =?utf-8?B?NndsUWF3eUdmN2VRc01xc2dLR1ZpZVVZMnhqL2RaallJN0gvbEhPSzRzNXRR?=
 =?utf-8?B?RE91WCs2eTNDNHNJdjloOFd6TGc4QWNTOFRYd0c5QmVEOVRSSzZXZWNNbW5T?=
 =?utf-8?B?djR5dkdHN3lya3Zrb2E2NHJsQ2V3TURJWGNxTnE3NUxRVGFRYmppcmczRlNT?=
 =?utf-8?B?cUlvdlhLTEFGZHRDRTZ3WmZXTGJmS0UxRmhFeGdGdGZZN3RYbWtyMzI3N3Nz?=
 =?utf-8?B?dzNGMURhVFkzUlhLb2s2N3NXTXhCWGd2aFlMb3dkalNvTUlIaXJ6SU1HMEJS?=
 =?utf-8?B?MnBIN0lxcXArWnpFNTB6RUdORHdBQU8xa2F4NHVvL2NSSFFLd2c2dXNWZ1Ev?=
 =?utf-8?B?VFNqcktEV0xBa1czUHdvRE9zemVMQkNRY2ZvRG1MZURqQTFOeGpGb1pYdVNs?=
 =?utf-8?B?M09WSGU5OGZncUFyOU1yVXF3TVdvMnBFMXVzelNuM1RrMndWc3p2dk85VEta?=
 =?utf-8?B?YW1oVGJRVURHSStacHBoSVQreXlpWkRBd1NscHovbzMzR29jNHRCblNmUzBn?=
 =?utf-8?B?L2ZBRE9RWGM0NGVmV25nYmFQaEFCdmIwMFRRbmxXcEhIakIrSnhMS0dKaXlY?=
 =?utf-8?B?bU1VcklvRFhmSXJJZ2VzUzhFQUVvNTk2bmc3Q01paEY4ZndYaG9WRDBjWEdx?=
 =?utf-8?B?VmJ6NFlJaDVPSW8zWWxURldPd1F0UW5yemdybmtITG95MDQ3RWgwN2ZqaGNQ?=
 =?utf-8?B?N3l5L1h5endueDdudDhJbVNRRDBzMDZpNkVxbWZadkQ3STBLN25adlIwOHps?=
 =?utf-8?Q?BZlp+TBzFiMbl/uH7dWQaoXEe?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1739fab-58ff-4e1d-5c00-08de276f243c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 13:25:44.2237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5v01g4oPhdzAdsZxTgBwywbEvNr0iGeNsMwNPwhWQvkZrJCc/vVOcv4gcIK6Xs9QqESZNBYu1LNC2eQo6B5cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF89892336B
Received-SPF: pass client-ip=40.107.44.76; envelope-from=wafer@jaguarmicro.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>

--
Changes in v4:
 -Add Acked-by

Changes in v3:
 -Update comments and add Acked-by

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
index 449bf5c840..80ff670e23 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -76,6 +76,12 @@ typedef struct vhost_vdpa_shared {
 
     /* SVQ switching is in progress, or already completed? */
     SVQTransitionState svq_switching;
+
+    /*
+     * Device suspended successfully.
+     * The vhost_vdpa devices cannot have different suspended states.
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


