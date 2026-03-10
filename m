Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95693FD4F11
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 18:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w01S5-0004eT-Or; Tue, 10 Mar 2026 14:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1w01S0-0004e2-63
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:05:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1w01Ru-0000ny-BG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 14:04:57 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A9paOe1719464; Tue, 10 Mar 2026 18:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=AQsL2LLIggA/xSAoL201ZdQfJiXAbbVFZUFHsdHQeWI=; b=
 bJNqM+c560pK42z2wZ4+daTz5SkjMcMjJXsBgOMsE/ITrxTtkLO5hqtkdgkY7QwA
 417WUHfbygcTU6dKyR2Cacu4xRJXc2S772Vx4Vjp5eyTmvf2v7H0U9253CPNApBI
 QsR0G3hqgvknayb2dBfYgXtSmRgF9xvYy13hKbnpXotZIfWxWRAKNO6ebTyakmbD
 lKh7cmF9fBJIvptlnpe2ggecWP5EMTqhkrjhTX6umwp4w2BlL8QLYP7UhTIPuFnz
 l3sDk37hJfyoBYIgsWHchde8Q4xZlqorunhF4CmYrkDwjFr7sNA3ghsQJ5l+w6C2
 zWQd+GMSxSSRXtp5dQmijw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cskyp3csr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 18:04:50 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62AGRAKr020396; Tue, 10 Mar 2026 18:04:49 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4crafefes6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 18:04:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H22rtSSXNaqLz5wmvq7NFEzAjPdjDyK1EKw7H3b35tNIum28ghbfCW3Dfy+e6tUhETv4A4OK0cYjbf6Szi70fSnyAzZQN8PfzhSzWZ4AGrRPy4DT4yaAoMd7V3LGeXbBTYefMW9M9YbWDq2DNVJ/lxlFRpwWnbk9xG4ToAyCofL5d6D3w2eIouUecj3j9XZEN4gn3RVIuqAAslDEGWjuHx7jgfvvgqJT9F+jGZgf1aSfpcbjStIqy/NucQLKOA58csvoDWlaT4QkE1tnZC7g/sZQo9DXYrobOCs87H1/1A2qnp+ftxF80YY/BI7AIA4TwhYXmjaOCw+bzrteYSTDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQsL2LLIggA/xSAoL201ZdQfJiXAbbVFZUFHsdHQeWI=;
 b=SIcixEV6vu3DAOOyFY4PuGonsBHi/5YzjGobt+yAyNON2Ckh3p48dSCq7J3H3VjRO6vYn3rrv67GJCVOojbikBivamBpqgjFs0TpnfskEM8o5vJv9/HSUCb2mg7Z8wKFjHHYEaYnZQwloVj0wGCPU6SOlRSNMGXAhQFEMRWE7s5QSGNoplOqrMbcCDPFNVPPPf75/PXnFK8MrVKdmj9kun3ve6G+I290Mb+9l2XDNXSjYgMMuMQpzYG1GtC41TtJLy2bqu/j2e4ul9Wiils6Wks6NLDAR0gpWpOVuuqqbpFApBW7RmJqv5e++RMTDd7PuynYTGZLj8DftEgRizBlTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQsL2LLIggA/xSAoL201ZdQfJiXAbbVFZUFHsdHQeWI=;
 b=du5yarcHlvT0DaeEBqWg0oNm0qdiwUqH+j7u2geCsfpv6DpH8/zhFesziY+8hldTyQd+kj1n2GA35xfZ7wTElNM8dpNwWsnteEoPFrxGezdInhuz1ZGcvp7tWfQLo/wTJVEkc91u637xFYKo8zOcUPMjCAf+/HgtUO7Zt4iNvdo=
Received: from DS7PR10MB7129.namprd10.prod.outlook.com (2603:10b6:8:e6::5) by
 DS7PR10MB4896.namprd10.prod.outlook.com (2603:10b6:5:3a0::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.25; Tue, 10 Mar 2026 18:04:33 +0000
Received: from DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::c649:a69f:8714:22e8]) by DS7PR10MB7129.namprd10.prod.outlook.com
 ([fe80::c649:a69f:8714:22e8%4]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 18:04:32 +0000
Message-ID: <dfd42414-4877-40ac-8d9b-5fea64844a55@oracle.com>
Date: Tue, 10 Mar 2026 11:04:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/nvram/fw_cfg: update bootorder and bios-geometry
 before launching
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: joe.jin@oracle.com, philmd@linaro.org, kraxel@redhat.com, armbru@redhat.com
References: <20260225220556.11049-1-dongli.zhang@oracle.com>
Content-Language: en-US
In-Reply-To: <20260225220556.11049-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::32) To DS7PR10MB7129.namprd10.prod.outlook.com
 (2603:10b6:8:e6::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB7129:EE_|DS7PR10MB4896:EE_
X-MS-Office365-Filtering-Correlation-Id: 037c4319-35cf-4601-0e45-08de7ecf7b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: zOLYcgYlqcP5gW9+yw1jm/x8bzUEvJsn5fNk97LvtUIh7d8ex1yqjP6RRZbRKaSfgXyT1nkscM/95NlNO6ADFFGdhG72SrpmVfltE7jGcWj+3jmtXYbdOfCl4k95wIK+5diVpbeEv+VJ+2v2DVoCpxa5LkMDMjZJaUqsTmn4YYgWCXb2RTL09HgeizsGJARAlR9Eyi+oZEJvMmMTeQZkTvsEC8spbxn1UO9HS0RXpL6vgA0LTb8fRwF3gf5aCwfFrziofnDhJBtbW2EHNFFrwYuyE56Kr38Wc87IhQLodXIbY/dgn5Q1hiB0Ow+bCx0KTBrfAKmG6oZrhSmY7/nFZ/157aJk28wjr60GKrsyFGgjNG4ff2DWDmbTNNiK0CTTMLgvwJzDR+iu70IL7Kdl43/C7/FoOsRaPLQMIx6WvQzfyqlb8ar8TFXMsAPd+HL8OLT1mdooGKAB2Olm2vpeQynCNEXp0z9rPjir67DPYI7ZTkEw7VlDFUr5L4DPMA8Cw4DYAfqXuopS0LJlokr7HkQhFcigYE0T16R64n9bHtEwQWYxSgrgG3f7RcSv911pe2Xuw1HLJpk5HRkt5nTsD5tgh59AgvaFj8hatCHaN0uqX21NjGg8xIZIOjp6CjMI+MikzzvosuH5JQpMRmAeKdgSMjJfC2+nonNV45cJ5mDCOFrxOqUa3FxtIzTeB/2z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB7129.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWF0MVgwQ0tFSlVmK25EYlF5dTNOL2xGR25VMEUxOHZ2cUJXZzRTWXMyYjNW?=
 =?utf-8?B?WC9XRnlVaWQyRkdaQ1JadURVLzZqWWErZm1QRTlXRHB3SngrNk1leTVKWU5p?=
 =?utf-8?B?OFR0U0xaTTkzQjQvTEJuQ2NtVndoeWwxN2dqLzNTSE8wYjJ5VWpYaTJKMzVu?=
 =?utf-8?B?RjZsN1BYdW5mdndRR1g5djBYT1JxSDBwZHRZeE1NcTgyUml4cTB1L0g2SFFL?=
 =?utf-8?B?UkNXWjFYZjdNbUMwaURhVGV4dmFGcGZ5YlVBcmhiaElsWWh5UmhKTzNSRTVa?=
 =?utf-8?B?NHRmSDRGOEZ5b0pQV0gvaXk0ZTI2Z0FvMW1ZWS84WndMYlAwR1grc2dPUXIr?=
 =?utf-8?B?cmxrTmlOZnppS1grdTFvSmNNdHcvQytyWVBrYlNHeUJrS0dWc251U3hlNXFa?=
 =?utf-8?B?RE9QbnZJNFpOM3ZuOFB1SkxNc042OCtWeWlFcVdGczhyTEFPWTF4RU9TZld1?=
 =?utf-8?B?aXFhT2VYSGo4ZVYxeGhkOHgrd21HT2dkdW5qWFZtUStlMHlUeGVhMHlxRDNC?=
 =?utf-8?B?T25HWWs0WjVZeHN0UlpWZWxRcWRudHpVd0JRVCs1WnRTd2V2TkY4TWx4S0tK?=
 =?utf-8?B?UTE3Q2VmSW13ZXBJOUJZa2lHRml1NkJDU0dUL2NHQ01jNFZKTzVzK2lHTWtW?=
 =?utf-8?B?QmdpU0Irb1BKUzgrWGx6cDlMUUh5VHVlUFRTTllNbVRuMGh2OFNrY3J0TktV?=
 =?utf-8?B?NS9NL0xYV1JZMUdOMGRpTndRN3RtM0l6dSs3WTcxNy9vRXNvL0tPQkZxUEdH?=
 =?utf-8?B?bVhKWmpNbnZETFVJV2cyYXJKOVd5MkY3LzlZR0ZPVVdPRE8vTEZqSk9Yd2VQ?=
 =?utf-8?B?M29pTUU4VHJyc0E1cFdxMkdZVkRSamFBNlZjZ3dGQWRpYTNtVmZsVFU1RDBn?=
 =?utf-8?B?Q3hWNk1QUlpDc0tsdmFMVE5EaUNyb1pzS21iME1wK3lFK0FsNU9kVlVqclVH?=
 =?utf-8?B?c1FCVFZyMmg5cE5JU3BYM2pRMXpCMG1yajh4VkNTWmJQZWU1eTJOWW1HbEU2?=
 =?utf-8?B?V05yTWhzVmdLYUs3ajEzd1RCM0FJeFRrWlVaN2dmR2IzVzY3VGJPNVEvOE80?=
 =?utf-8?B?VDdRQlNCVEZROEUvdURldHpmM3dTZFdBUzdMUGZMejRjR3BocjdEZ25UTnRa?=
 =?utf-8?B?UERaR2RLL04rdnZxaDJZVTNRd1UxUTdlWDUrTnMyWWlWcmdFZUpjd00wLzND?=
 =?utf-8?B?TjlMVzl5THJ4TDBoR3QwMzh2UERObVgrRkVmbzBFWWFzSnB3Q1lobVZ3UTgr?=
 =?utf-8?B?ZHBIZitYWEhWUTBTdnVEMkVRcWhncFBlSlhjWExLS2JaL2R5UnkwVWg0Yk5u?=
 =?utf-8?B?eGJjSi9IbFBaNUR4cXhDekFWNnVTcXZISVZpcEV1ZUVwL256aFdQdnpoTmdj?=
 =?utf-8?B?Q2cxdFRRMCtWWTVQdUpGSUhhOTR3aEdEZTNhYnNpTFJtemp5RlBtbFZVSVVh?=
 =?utf-8?B?YkQ5V3MrbFFROWhKeW5zZFNjOEh3Ny91SUlqR3NCZkRuYkVLYVM0ZWdkcVV3?=
 =?utf-8?B?K0JxTklFcEkzb0NOZ08xdTE1czB3blpsdTdhbSsyT0w1MDhac2VNNU1uV2xh?=
 =?utf-8?B?dHhUUC9CK25jTUFNQWtKUkRiWUdqZGNCekVOZU0zRjMwKzdwSS9BZk1kOU5y?=
 =?utf-8?B?cWFzaWViTE9NMWxiaDk5aElmQXlqZ1Y5UGJOU1lYK1VvaDlTYS90bnlwd0lj?=
 =?utf-8?B?Y2FRclloZUYyL0ZST0t0cmYzbHNpVVhsYmJWNVZQd0hqRXNZQmJzKzd1cjBN?=
 =?utf-8?B?Zk1DdkYxMVF6QitiWTBPZUNsbWdTaDRyNGF4V1NVN2Z2dFV6N3Y3LzVCbWZ5?=
 =?utf-8?B?R2gvV0gwMHlRbjRaVmdIb3gwakVvTHlFR1pmRkJiY1U1cWo2bFhJQmFtL1hn?=
 =?utf-8?B?R0FCaXRkRlhmOG1aNGZTSXl4NkQwdEVMOTdZcXN3Wkt6Uzd1UHIwQ1pOd2ow?=
 =?utf-8?B?Y3NYREpmdG1rU0RFUlI3NklVSWxtakE0TVo4MU5Mdk9ZeXpVNk5sajBQWldJ?=
 =?utf-8?B?VWRIMld2SmVQV0Y5ZzRBdk1HOCtWNCtTQTUrYTR3bm01VXdiVmt4Z1lMSW9B?=
 =?utf-8?B?UmVTemJ5RitTODMvVnFJaDRUVkpjZFpnSHczZzVVUGJsTFY0YUJhZGp4dVVt?=
 =?utf-8?B?WXZXSldjS01hdXZDVDdESnlhdWFsUWt0R2dwT0dVVU50eG55OW8zL2lCSExv?=
 =?utf-8?B?Z3RjRXRCUVNDRE9sb05DSDdBb3RaQ3Zwd1p4N3pkZVhicDRHL1EvY0F2T1NZ?=
 =?utf-8?B?cVVTdHhuYU9BNTdiS3IrTUpFdWQ5VWJKSndLSHMzeG40YjBEZURUYkJKUCty?=
 =?utf-8?B?TnRSdFMvUUl5WHlSNk0vR3ZkZTg3c3phOFEzZWJ5RS9DeW5qMkYyUT09?=
X-Exchange-RoutingPolicyChecked: jGPzAA/FwV42aFSliu3SxvHnA094eGilGnPr0+MieI25nQ/qumIjXXZuuEGjsTGDMa9+AHp3BI97i3eb6MqBkhf7qosXaOER+6iibJbbeI461e3QudZcFcXrtO76X9PvfDG2z7ZYP8wNU6+yxP8GQJ8B49cZFmZrTT1MYxcx7msB1Nc7idFx/9+jgMEzRzU5Ja802JZjvcf/TUGIcDWYoCRv9eC8zNOTSv21KroNw0YXcJWT//U6EV3Rd+CRLdWfiGtnCw1SEFlB4uoXGc+OATApxik119ltv12Jz2FJVZIdrm9k2OF4jQ7BII9Tt2nPDvN8v5LMpVsXnlFrOD+X4A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /CVT0hv2/vbaWexCvx71ZJFtvjlJvvz/Fv/T6+rJVSteaxFDxVBMc7VE5JIxvUver44ALEMaJrBR0fLMCkAy96X33BQ3ep3O8m79IDIyy404q3AUT0+zqGlIEIzBQsrGZ3v5C9PGVNKliPLfj4Y1C51sAfK5Or/tpNQIafII2JWHBDuRznTQGCSgRu46wXJ4hT1hOb8CJhU7Qf4P+C52HU6ZNSVRoVJPdBZpFb9rt3P6a9eHqXADbDcQSlulL5bU+3l3RNZ2GhWVsrfdr5N4u5On0JaMJd6u4AGUAVUsvhB+JnlFtpgL9kS9vLmgnROdtA1kGMj6mg4IhgnhRIZMPKSxjnEEWkMLWPoILgOb+dncqLmdcd/uxKDrSN0FGPFU8i1CniYKDDnmYURedqRO/D6rxMH7ztz1iVnaJ+qZMHDOWLZc3BMHHfdh69Xi22gTdQIC5YNMqIj0vKOMDiBEPIg2CidsP3/RzOxCEsd6jllRm+JHrSZtSFpVpca+oVfbDg319g3qGWhdu8llzt3Ci8B29bQ1lUvqM5JejTWdXMHzQ5yjisrTTzElQ0eAtPFRwxnE47uGZyIU68mGcgaedg/dGZuEhJ95ltbyhwpeprU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037c4319-35cf-4601-0e45-08de7ecf7b12
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB7129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 18:04:32.3812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqKp1tw2BkXjSG6UQAdYYIVYfgCBHxYKcjx3z3nSW/rMRmDyUb3VPXqAuwaOa1W2a8Yaj8rEV74C5Cuv5pWPNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4896
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603100157
X-Proofpoint-GUID: OmkZMn3btCIMIpmUvn5Ai3xspiSOsqFR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE1NyBTYWx0ZWRfX7EGIDPCVhRlt
 cEkUh0KmqPqtBE3EkiGoVlOjc+Mmx7VcWQjVwOVUoGlDzLQpaTeAVU+sD7+/4p0543OXur82aSg
 lt2VNzwOhRwYdiTvG5NoLMLbVk9DNTlZpCUSCIKxnjuNYQYeilw6mhOseu4lQnlDxRppXeErKvX
 EsyVFuu6HnUhSj5wUWzuvpXiSnHTMumE3Pel/pPIEtjau4DlY1nqN09lfImLzju9dAs2mQlV9WK
 ztLX2zwP7jF2gG4J8tJpn8oMWlV6ZawzdU18v/pPRViHWfA5SWkzWRv2EuO8arTcP1K7ztZ1hWb
 fy1uQz9LtQ1c62947eyt4PmyrvKbbmAZBE804Ck8KNa2Wlbd1gk7lmCQ9lXEUKHAQfda7YFyfyx
 Kf7IjLLMmTEtcLI++LB6wCOVWc06n9Z/F4eG2JEcL2x7VVCsjZzBAWkwmLe4K3ShXbOtaORROti
 sI5wdlHF9ozcYx8HlyMXsV5KI9cqzsNL2JBLakng=
X-Proofpoint-ORIG-GUID: OmkZMn3btCIMIpmUvn5Ai3xspiSOsqFR
X-Authority-Analysis: v=2.4 cv=XP89iAhE c=1 sm=1 tr=0 ts=69b05d42 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=Hnm2Hy9fAAAA:8 a=xDyOQ7S2AAAA:8 a=TdK_jTFjuJnqRUCGmiIA:9
 a=QEXdDO2ut3YA:10 a=qByqzKpv1oajCkFmDuv_:22 a=xG0zjm5BtbRCg84i2bc1:22 cc=ntf
 awl=host:12272
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Ping?

I implemented the bug fix also with an alternative approach (v2) by adding a
runstate transition notifier.

[PATCH v2 0/2] hw/nvram/fw_cfg: update bootorder to fix SeaBIOS bootup failure
https://lore.kernel.org/qemu-devel/20260310170712.46336-1-dongli.zhang@oracle.com


In addition, I sent a bug fix to the SeaBIOS mailing list two weeks ago, but it
still hasn't appeared at:

https://mail.coreboot.org/archives/list/seabios@seabios.org/latest


I have copied the seabios patch below.

From 1ba4f0ac64a2f03327f3d79bce90122dfbf44e93 Mon Sep 17 00:00:00 2001
From: Dongli Zhang <dongli.zhang@oracle.com>
Date: Tue, 24 Feb 2026 16:25:40 -0800
Subject: [PATCH 1/1] boot: try one disk after another until system boots
 successfully

SeaBIOS relies on the "bootorder" provided by QEMU to determine the boot
device order. If QEMU does not configure "bootorder", SeaBIOS may instead
prioritize disks based on the order in which they are probed.

In that case, only the first disk may be tried. If booting from it fails,
SeaBIOS may move on to other media rather than attempting the remaining
disks.

As a result, if QEMU provides an incorrect "bootorder", or if SeaBIOS's
probe-based ordering does not place the boot disk first, SeaBIOS may fail
to boot from the intended boot disk.

Below is an example demonstrating how SeaBIOS can fail to boot due to a
QEMU bug.

1. Create a QEMU instance with a virtio-scsi HBA and keep it in the
prelaunch state. Use SeaBIOS rather than UEFI.

-device virtio-scsi-pci,id=scsi0,num_queues=4 \
-S \

2. First, attach the boot disk, then attach the secondary disk.

(qemu) drive_add 0 file=boot.qcow2,if=none,id=drive0
(qemu) device_add
scsi-hd,drive=drive0,bus=scsi0.0,channel=0,scsi-id=0,lun=1,bootindex=1
(qemu) drive_add 0 file=secondary.qcow2,if=none,id=drive1
(qemu) device_add
scsi-hd,drive=drive1,bus=scsi0.0,channel=0,scsi-id=0,lun=2,bootindex=-1

3. Start the VM from the prelaunch state. QEMU doesn't update "bootorder"
due to a QEMU bug. SeaBIOS attempts to boot from the secondary disk only
once and then stops. As a result, the VM fails to boot.

The symptom is not reproducible with EDK2/UEFI boot.

While this issue needs to be fixed in QEMU, enhance SeaBIOS to try each
disk in turn until the system boots successfully.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
The QEMU bugfix has been sent to:
https://lore.kernel.org/qemu-devel/20260225220556.11049-1-dongli.zhang@oracle.com

 src/boot.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/boot.c b/src/boot.c
index 5c37daf..84743a6 100644
--- a/src/boot.c
+++ b/src/boot.c
@@ -1000,8 +1000,14 @@ do_boot(int seq_nr)
         boot_disk(0x00, CheckFloppySig);
         break;
     case IPL_TYPE_HARDDISK:
+        struct bios_data_area_s *bda = MAKE_FLATPTR(SEG_BDA, 0);
+        int i;
         printf("Booting from Hard Disk...\n");
-        boot_disk(0x80, 1);
+        if (bda) {
+            for (i = 0; i < bda->hdcount; i++)
+                boot_disk(0x80 + i, 1);
+        } else
+            boot_disk(0x80, 1);
         break;
     case IPL_TYPE_CDROM:
         boot_cdrom((void*)ie->vector);
--
2.39.3


Thank you very much!

Dongli Zhang

On 2/25/26 2:05 PM, Dongli Zhang wrote:
> QEMU maintains disk boot order and geometry information in the lists
> "fw_boot_order" and "fw_lchs". For example, boot order is derived from each
> device's bootindex value.
> 
> During system reset, and only during system reset, QEMU updates the
> "bootorder" and "bios-geometry" entries in fw_cfg based on the contents of
> "fw_boot_order" and "fw_lchs". After the guest VM boots, the firmware
> (e.g., SeaBIOS) can read the boot order from fw_cfg and boot from the disk
> at the top of the list.
> 
> The reset handler fw_cfg_machine_reset() is invoked either implicitly
> during instance creation or explicitly by the user via HMP/QMP.
> 
> However, users may attach or detach disks while the VM is in the prelaunch
> state. Because there is no implicit reset when transitioning from prelaunch
> to running, the "bootorder" and "bios-geometry" data in fw_cfg can become
> stale. As a result, the firmware may be unable to locate the correct disk
> to boot from.
> 
> Here is an example that demonstrates the bug.
> 
> 1. Create a QEMU instance with a virtio-scsi HBA and keep it in the
> prelaunch state. Use SeaBIOS rather than UEFI.
> 
> -device virtio-scsi-pci,id=scsi0,num_queues=4 \
> -S \
> 
> 2. First, attach the boot disk, then attach the secondary disk.
> 
> (qemu) drive_add 0 file=boot.qcow2,if=none,id=drive0
> (qemu) device_add scsi-hd,drive=drive0,bus=scsi0.0,channel=0,scsi-id=0,lun=1,bootindex=1
> (qemu) drive_add 0 file=secondary.qcow2,if=none,id=drive1
> (qemu) device_add scsi-hd,drive=drive1,bus=scsi0.0,channel=0,scsi-id=0,lun=2,bootindex=-1
> 
> 3. Start the VM from the prelaunch state. Because the "bootorder" and
> "bios-geometry" data in fw_cfg is stale, SeaBIOS attempts to boot from the
> secondary disk only once and then stops. As a result, the VM fails to boot.
> 
> One possible workaround is to require QEMU users to explicitly issue a
> system_reset before starting a guest VM from the prelaunch state, if any
> disks have been attached or detached.
> 
> Another option is to address the issue in SeaBIOS. Nowadays, SeaBIOS
> attempts to boot from only a single disk. We could enhance SeaBIOS to try
> multiple disks in order until boot succeeds.
> 
> Another option is to update "bootorder" and "bios-geometry" everywhere
> disks are attached or detached. This may require identifying the relevant
> functions across multiple device types, such as SCSI, NVMe, virtio-blk, and
> IDE.
> 
> This commit fixes the issue in QEMU by ensuring that "bootorder" and
> "bios-geometry" are always updated when QEMU transitions from the prelaunch
> state to running.
> 
> Co-developed-by: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  hw/nvram/fw_cfg.c         | 20 ++++++++++++++++++--
>  include/hw/nvram/fw_cfg.h |  2 ++
>  monitor/qmp-cmds.c        |  6 ++++++
>  3 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 1d7d835421..6f60abae65 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -965,9 +965,8 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
>      return true;
>  }
>  
> -static void fw_cfg_machine_reset(void *opaque)
> +static void __fw_cfg_machine_reset(FWCfgState *s)
>  {
> -    FWCfgState *s = opaque;
>      void *ptr;
>      size_t len;
>      char *buf;
> @@ -981,6 +980,23 @@ static void fw_cfg_machine_reset(void *opaque)
>      g_free(ptr);
>  }
>  
> +void fw_cfg_machine_reload(void)
> +{
> +    FWCfgState *s = fw_cfg_find();
> +
> +    if (!s) {
> +        return;
> +    }
> +
> +    __fw_cfg_machine_reset(s);
> +}
> +
> +static void fw_cfg_machine_reset(void *opaque)
> +{
> +    FWCfgState *s = opaque;
> +    __fw_cfg_machine_reset(s);
> +}
> +
>  static void fw_cfg_machine_ready(struct Notifier *n, void *data)
>  {
>      FWCfgState *s = container_of(n, FWCfgState, machine_ready);
> diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> index 56f17a0bdc..8aace1d4a9 100644
> --- a/include/hw/nvram/fw_cfg.h
> +++ b/include/hw/nvram/fw_cfg.h
> @@ -351,4 +351,6 @@ void load_image_to_fw_cfg(FWCfgState *fw_cfg, uint16_t size_key,
>                            uint16_t data_key, const char *image_name,
>                            bool try_decompress);
>  
> +void fw_cfg_machine_reload(void);
> +
>  #endif
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index 0c409c27dc..dfeb80d1d9 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -32,6 +32,7 @@
>  #include "hw/mem/memory-device.h"
>  #include "hw/intc/intc.h"
>  #include "migration/misc.h"
> +#include "hw/nvram/fw_cfg.h"
>  
>  NameInfo *qmp_query_name(Error **errp)
>  {
> @@ -112,6 +113,11 @@ void qmp_cont(Error **errp)
>              error_propagate(errp, local_err);
>              return;
>          }
> +
> +        if (runstate_check(RUN_STATE_PRELAUNCH)) {
> +            fw_cfg_machine_reload();
> +        }
> +
>          vm_start();
>      }
>  }


