Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1503DC87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 12:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulRUB-0006Sv-Fq; Mon, 11 Aug 2025 08:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ulRU3-0006MW-Bm
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:18:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ulRTy-0005o5-AO
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 08:18:34 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5uF9W004974;
 Mon, 11 Aug 2025 12:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=hhBHfC6h/FxeJMF5DY91eebHMQzgsctVINVd8tCLMB4=; b=
 sNXXXvCMceKm6hbnKs2T8sT2WclzKt3HN6131eo1R5FCIj54RSERYB28lq4eifCh
 6Fg7cRqIOvLs67T5HQOf5/cGsm4S0KWoIMuMEB+3uf3mFGEC/No5Xjgv0Bq8NK4x
 l4XxkDeT6x8fgaYTWLfpGY1FPLkNqH5zPym5pSROMFUt1uES1rWfivnrYYfCg0XS
 Z8Bre0OlVGsqcj99ZSOmT/bOCZrnKvp+NNDkB/IixEDhHCNgtqOnlvQ7WAi0pmXO
 saOakkO1U4HxGP7WM0ExxL7L/nMmWPAgYAuap0BaIXWMSl7XKpL9gyPif6XO4N/K
 8HqnTBIuUBP0M/KpRWN4cg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4abwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Aug 2025 12:18:23 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57BC60le009846; Mon, 11 Aug 2025 12:18:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvseuejm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Aug 2025 12:18:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXnd6ITGAt37UtEyWIZXwt9TSQP6CeJhwa9gyqn2e61d+7/ZWDhlXdHkOrfwfD5iOAEgvVPRpunyqnb8kWmzydNTJG/O4NOVU8B160fxDkmpZf7VLnbPl4ju8K50ZeZG8hnCjkM/eED5dy1+CbujHH3ccbeXO9CmySTNhs+rgJxhyQ7wxpqMziE2qlJ/f5+mXK9z0Io7Simbgyq2v40fT+XL7aB0oNBSoqx/t1ODN94UWXFEAPnC5J2tS5tFYI+CAXOk1eAI+PtCRchDzVGy8pLWyNpXp2tgN7c92Q+8dGC5lysppDXpw9nbZTH8AUIqQiFQkDJaC+2jkrMan2cqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhBHfC6h/FxeJMF5DY91eebHMQzgsctVINVd8tCLMB4=;
 b=SNhfdbeSHBYsYx2lORGKcg6ANl1K+Dk6GffmKsAgNMuLMhTj7OCtEeeh3HClfrJ4C+eSsLwJ7pLYOBjF5yZ65i2M19B2h1a4MiDogtO1PAf3kmDmVcItu+v4IQrt1xSBYTiFtU5++Qwi4o1FH41JQ7ceNZZhcrrT3IMNM99boZdQM7Ym+2+m8KBA+9eY3Nm550UK59pQOUqWON19NLpaPSIu5Pk8CTkNu79NqpZY/TFLUl8qTp5rnoENHOxzbhfyU1KUKseXBvd9n21amjIco+W0bMhP2vgEKlHNFnE0jVs6gkS3Af5DasA54lVEQ5xh+MiLe9vRrGmmuxmVnn0VOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhBHfC6h/FxeJMF5DY91eebHMQzgsctVINVd8tCLMB4=;
 b=BNxfT74LV2hVsjLuh+3FBWbknv2rvN9K0pcflp6xSuHYDp/AmpMsYjeORUVbSX9otBtBEIdgIDt/wd1RXCcd4pdfc1heTvj4tZ/fndzCgbG7xzYFMRmIWkCFGtHJC8JIHjF5Ta+oLQrq2sWVnupW4mUHRdVijiPohK/EeVQz/+g=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by DM6PR10MB4220.namprd10.prod.outlook.com (2603:10b6:5:221::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 12:18:20 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.8989.018; Mon, 11 Aug 2025
 12:18:20 +0000
Message-ID: <5a8bb5ef-c500-4fac-b5fc-566408ae8ffc@oracle.com>
Date: Mon, 11 Aug 2025 08:18:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/6] migration: Add virtio-iterative capability
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-2-jonah.palmer@oracle.com>
 <874iuihyxd.fsf@pond.sub.org>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <874iuihyxd.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::18) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|DM6PR10MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 059e03f1-dd6e-4fb1-b56d-08ddd8d128dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVNyTFJzSzJwdFVISy9KOU5nVmNjUTdrSkNTeHFtamIyeCtXVGwxaXdhUEpD?=
 =?utf-8?B?clhCZEFFaWhpRStOSm0zRkdMSU9hb3JFclZpU3ZBbFIveERrL3FtSU5JcDVa?=
 =?utf-8?B?dXpNSGI2aXBSN2FZbmltaWY3ZkpwZjBOQ2hWU1AzcEZUUmxvVG9KVnFES0dK?=
 =?utf-8?B?YlZsQTViVVNVaUF1WEFqQjA5OGQyWkwvM2M0bFgxb2NXeDdSWDV3UnZzOG9D?=
 =?utf-8?B?dXFoNkFHMHM0OGMxOWYxTnNQOGhxK3hwT1Y0WFBybldvRFJtMUFYMEsyYytz?=
 =?utf-8?B?ZG5BYUtIUklZY0NsQkNjcHNSVXBCbVhpYUxmY203WUN4b2Q3SjNDNGRlSGl3?=
 =?utf-8?B?R1JTTzBDWDBuMmtjY0h6dEovK1hYdVBHWlRncWtab1dUbm0wM0dZMXZTOVBP?=
 =?utf-8?B?Vm9XVGRsc0QrblE0dDJvTkZUc1ppWnVieG05d0toTVBOQzdhRkVuSzZYQ3BN?=
 =?utf-8?B?VnpLTlh3LzVLZ1AweEQ1ckQyZlloRFdrRUdyWDg1bWlDSXNqeCt2WFhyRXdR?=
 =?utf-8?B?L3NKdFRza05GSWxQUDRiTURodDBZbXQ2WnIzdlQ5Ynl6WkVsZm5zSVd2cFVM?=
 =?utf-8?B?Z2dOWTREMk9iWmxuQ2cxOFdpSVNvMk4vNHNBR2JEK0RxWHZRemFUQ3EvdnhN?=
 =?utf-8?B?U3UvWE9DeC81Q1o1dElFYU5iWWlJYU5SNDdPSjFvMTNzREI0dVZHV3R1bjdX?=
 =?utf-8?B?UVBMOEcvUkxXWmVFbHJ4MVpYQXlXRlJOUWdoNlBRSk9WYmk3NnRJaWdraXR3?=
 =?utf-8?B?ODRTMnlvWENJNXFjcFFUeUFWY3B1bXY3K2VUWlh2SjBSRjIwQ2d5VTRZSVpO?=
 =?utf-8?B?VjJ2YlNXOGk5cXR4UHBVblpMcHR4ZmhXRm90MzlKa2sydlAzTDVaMmoxRk0r?=
 =?utf-8?B?S1dpbnBlc0l2eXVRN3hUQ2JNQkQ1ZUgvSlpsUFpObFFDUlJWbHJ1cjE0VW9p?=
 =?utf-8?B?MlFvRmsvRE4veXBxSjlRM0VBK3U3a2IyNkYwTWY3TlF3T1VUWCt2OHJ0ZzA5?=
 =?utf-8?B?d2FCWEVRQVlSd2xZS3lIVDlVc1hGZkVPNGcyd1ZkTCtTc2J5R3NZUGd5Umds?=
 =?utf-8?B?cFZWMXMvWXl1UFF3dGNrZEc0c1pzOC9IQlV2NS9TQlNQN2M4TjFIUVRIMTNE?=
 =?utf-8?B?NUVyZWxqM1pBeUJoMml0c2JuS3NrODRPSzRBdUtYVSsvdk84blZuWnVCVmVZ?=
 =?utf-8?B?UVlGQllRQ205NTN0UmF1eTFzTlp3VmhrbkhBZWM0aENzY3Q3cnhDN3d4cjc4?=
 =?utf-8?B?QTB1TnJtcDdrZjJQMEQrL0hVMlJIYnc5eHdDQlNqNXJtNHM1UGovSWdlakFF?=
 =?utf-8?B?MHZSVXIvcnp3T3RoZEJQdjV1ajEyMWhCR0tqOWgrOFdWUG5RL09iaVhXNS9E?=
 =?utf-8?B?VVdhUVRYWTBTV3lJR3VuQmRHVVBZMkg3bFBjMHpLenhBMk1GeU5GL3BzQlNa?=
 =?utf-8?B?TnFBVlp1WUd4ZDNwNW5HcXpsUmR4VjdCWnBOQS9kOW1EWmtiRUJWWm9neVdz?=
 =?utf-8?B?RFg0YVVZenFHbkI3b1pPeTBtZmRyaGNsT1pHMHl4MG0vSEZ0TzB4b3U5QU5y?=
 =?utf-8?B?T21nbzU4YlBKZlpleTd3ZjRVWnNtOWYxM0g0L0h0UTZ4cS8vSXVsWG1Td1ZB?=
 =?utf-8?B?K0JIZ2lVS0V2VlkraDJpbGIvYzdQMTQrYjB3SkxNUjBhZTBwb1N4SGpqTWEx?=
 =?utf-8?B?ZXB0NXVLZWtxbEZ3SThibHdsRkV0Q2xSN3ZvNzhoSTVwckF2TmNGamd1ZGlQ?=
 =?utf-8?B?UXI1MVFXRHgvdko1a0FTSC8yWGFnMDIrTXlXbjdpQ0pzNlFYOGFDb0dqY1FH?=
 =?utf-8?B?S1RkVkZCbGt1Uk9pY1FGcVpVZDZVZkV2cUQ4Ny9GVXowcWtlUHpjTFRrYTYy?=
 =?utf-8?B?cWkxVm9ENjlTTjlVYWxSZnJuWk0zUE1xSUxEU2FHS0NKSVBGaUJlL1Y4c0xu?=
 =?utf-8?Q?M2HRqJrhlYs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2gwNm94L0d4M1ZrYno0UDh6NWt0SUQ3MmVUb3p0eGw4OTF0STBrZkFLTnpH?=
 =?utf-8?B?MVV5NFFFbWg0MitPV0d3MXFCT3FWVlhvV2lvL1N2NFlzYktKWlZidVZiM1Vq?=
 =?utf-8?B?REx0ckRTSkN3ZzlLR09qTE5YRkZwUFQxeGFGT3VGTmVwaTRJcXBZSDFaWmlX?=
 =?utf-8?B?bFFmZjB1enhHd3hJQTdoNHRBaXlBQ0Y3b25OK3E1ejdzanE4cTNLNmFpQk9E?=
 =?utf-8?B?eGZadjk3U3k2RGtjVk5MZDZQWHBUMWwzdkFJY0NlSGNWN21mQ3ZpMm1FNnI2?=
 =?utf-8?B?VTRhVDJydCtnRGN4WWl3QktleEdXazBZZE0vOVo5V1V5a2Q1cllMUkJlcFh3?=
 =?utf-8?B?NndkRks0Y3pFZ0dJelpCaUUrTnZ5TDc4SG41RDRwSENxaitwQUIzTnNlRi9H?=
 =?utf-8?B?OXRvV1FpeDdPU0JlYWUwTElqSlVvR1AzMjlEeXdWT1ZFS1p0TFhVSmR2VHpK?=
 =?utf-8?B?TzBERWpJOXVTV0lsTUFSb1VXVnIwVGtMZHRvZ0NHTTMrZXhjRnlxcHgxK2Ru?=
 =?utf-8?B?MisrL0VmSitTaGRrTlBvSXFKcjBJUTVMdkFJK05NSVJKUzhnMHNlZGNKMU8v?=
 =?utf-8?B?ckE5bUVnbERSTTY0citVZGdTRmRYN1A2ay9Vc3N4cnlBN0U2WitqNitxc2Nu?=
 =?utf-8?B?OFcxa0N1V1Q3M2RlSXUycysySUxtdDkwbjNpdkt0dzY3c2JoaTMrOFNibkdU?=
 =?utf-8?B?MVZnU2dnYnM3a0IzRzZoYUhxRWZjRUZ4a3J6YUorSzF6VjBxaXNiOWZYRlU3?=
 =?utf-8?B?b05vOFljbWM3enBiYWZSNVkwbHl4VXRkcFpsNFpMNisxZUx3bmhJSXNqaVJG?=
 =?utf-8?B?YnB0S2lwS3VuU09ZdGQ2dnNBY1VKQWdvMERJMno1STFKc1NLTFhwb01tUUVj?=
 =?utf-8?B?RlNqcTRhR2YzR3hUblZXQ090dVY4NFd3c0FTTmJicmdOQ2xqMG9ienVBQzRa?=
 =?utf-8?B?VWUzdnJBblM3ZzNGRk9yRmp5TnNOTmp2TGRWL0djejMxZ0daSWFHbVlkMkpH?=
 =?utf-8?B?WEx4Nmxxa1lMQjRkZzBrZmVWTjU0enk1U09OMmx0RVR4TkhWODVBMVVmNTVk?=
 =?utf-8?B?YnBvNm9SRXp4Nm1Uc2tDeGFCN2hQbUIwd0NjM2JRYnovRDBST2J2VFdKeDlO?=
 =?utf-8?B?L1VtNVpxM3hpNlRpaktPZlgvRWFaMHhCbS91RjZnQ0phTmVwWGY3TVZnTDcw?=
 =?utf-8?B?VVNWYTkvN3IyUHBiSUJyTTcxQVQvRVIzM0ZXZ1FLRDdQRGJVRUNCNlF1Vitj?=
 =?utf-8?B?VldsZlN4U0FYSmpyK0tzd0ovdkMwYWRmaStvTFdoMjAySGxQcjZqYlBPbzdj?=
 =?utf-8?B?RFdtTExqbUVVNmwrNms1ZEs5WTM1VjRuVTBJcUxxS1hFZzdJTHN6cnNKTm5q?=
 =?utf-8?B?SC9WdisrMUJDWUR2bE43eHl1THQrMFhWVDdDbVNwSURhUUMvV0FSZmJ1Nnk2?=
 =?utf-8?B?eE15QkpGTDRKWXhKb2hBMlIzK1EyKzVlUVFjSWRKN3VrcDNRVVNvejMwb2lT?=
 =?utf-8?B?amxhb3Fva05ubFlnTWladnlxMzdScFJza3Z2R25Ra1BNS1pjdWNUQldyQmxG?=
 =?utf-8?B?MnhBODA4Y2lxaWd1M3ROR21wSjAyTzgzUkZxOW5GQjAvU1FIZzhNbDZHUDlC?=
 =?utf-8?B?aE91QU5lbzlhWlVmWlN1SUJ0enA1U0pIVUJXdk5aRldxSUtBeEYzZnBRZlln?=
 =?utf-8?B?dG5XanFLQkdGR0pjV2ZtVk5vdVl0MWplN1VkKzZTc2E0V1VpOEhOeVZpNmpL?=
 =?utf-8?B?dTNYVVQyUkdQS3dYMXdybEZ5ZXJzQkFOZDM1RGFxY1liYzVsRUF3RFNwMWxP?=
 =?utf-8?B?dTYrd3Z2eUs2eEx4S0dDcXpRbmhTYmE0TThLS2hiclN3VlJmYkJ3MmxnOENY?=
 =?utf-8?B?SkZNUzV6Q0RGTy9PRUo5M2d0UFFZODYydVFETkRLMmVmdCtxMWx4QzJMMTBK?=
 =?utf-8?B?RmZlZHB2b09yc1dFT1F5UUNSRjltYWNKN1hNQ1JQRXZ1MDNjQlpqRXNCTkJY?=
 =?utf-8?B?TmVGK3FPQXlySXVOcUpaUHloR0Z6cnM2Uk1OUk42VnZjUlVmdm5JQ2xFeXN2?=
 =?utf-8?B?QW5LYU1iT0ZGT2tKTlI4MFBudFVHMlU3eU1JMWZ0Qm54QkNIZHpndC8xc0Vk?=
 =?utf-8?B?SWpjd3JMS2V6djJaMkN0ZGQzQ0FsT1lmUWRURFZVWDY1UTcyUEttaHplZWVu?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fO3LNuCE3NPkJBF6zxNHNliJ743Rai9+MulUBDKLRwLCYdhlJv12KJP3lFz49+72elwyMMQRh+3ErgQeX9Zgww7ekN/xU9/9I1Gj10MxAOKf2JsuRW1CO4wE2msnVImmvtU+O2YVBtIRT3A5vz7ZbOctIUZR3VnhgYazDNj5KwrOpGCe0mEpwZ63OEjLvw41+nNvtjOGJwmrGTgkJqJNpzqjDIbGTzQ3glpbXGjwUZljAW2WNSsvi/RdRin4mn7HW8YosGZSSUGJS6AjcNsd0dvQuhiiLugFzNjwNB43elVXd05uovOfac9uuHnf5guLlDwXEDdCcGafKs+bsYdJqXYcY/1AePgRo6mcX1SqcV3ulP0Kjkzo6jUmu5ZTP3j0LWmIsDei6u/YvlwF/Hi0us29VSWoRmXdnOBkYYBrTXXLmc4FeaEWsEYSKTPQRLFHaOU/hQY07fKxWTzlz2F9OmfQtHLAiWFYOt0hDDOBthz8RiOtPdY1tfr0YIxlhwNeN8O84xb5F1Dtqm4EgTJOy2weXwNmacxcvVRHBI9BtChrQ+Kz0ZgYdCBHjXstGIegAWPVmXWTEZy8z9aBIka19XJzGKB8r6MIwuaeygQ8vt0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059e03f1-dd6e-4fb1-b56d-08ddd8d128dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:18:20.4781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1XrFa94WndygnBPqpMwcDQcZ3xVYhqzS96HxuC4++QmUV5VmEXdg3ejibtr6uxoiajHeDL+krE5egdUpSg9sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110080
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA4MCBTYWx0ZWRfXwIaMDeZaWVng
 ufVZ/Z9Igx8dwSEqMHPp7C8DH8rC0OyzDKo64XBombmWBgiNkeLxsOA8I561AQRvyHqGLJb6Nt1
 rVXklNly8ctkML8oWYR+x1a+BIW/1wYgpc6u48aoXqIB1CWW47u2oPm3XBAAgjfevcRFhZCI0lM
 I+zqf+M5hSO3InEH6pQjXX0sWmoyDKC8AGMgVphwo8YmWme/ocxO69Iq7b/W31FRtmyaaQLNSvZ
 guBECJb3qQcsjGwi7O/gpLwAbpq5CCfmuJ2Lw9yT+z7IfHZKLpTZ0rwiiS71U/pJjSzaV6E83ST
 prAvhdSMEAwmeyyvtniYKLIIREMfk/n7kWmXeAUtK82U2R+a8OHCt3pxjkmPOcczJYpY2bR48ZH
 SFOVTL+mM286kSSP9Zv1PZAVh/oFWz1w829/1Gs/tgIX39hG04ifT5g7he5vTxkdG1Rli2Qx
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=6899df90 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=MOUG9t0Y_k2js8D6lzgA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
X-Proofpoint-GUID: cec_cR0Llm7zqQi9mNsOzUS2IwbCP5mh
X-Proofpoint-ORIG-GUID: cec_cR0Llm7zqQi9mNsOzUS2IwbCP5mh
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 8/8/25 6:48 AM, Markus Armbruster wrote:
> I apologize for the lateness of my review.
> 
> Jonah Palmer <jonah.palmer@oracle.com> writes:
> 
>> Adds a new migration capability 'virtio-iterative' that will allow
>> virtio devices, where supported, to iteratively migrate configuration
>> changes that occur during the migration process.
> 
> Why is that desirable?
> 

To be frank, I wasn't sure if having a migration capability, or even 
have it toggleable at all, would be desirable or not. It appears though 
that this might be better off as a per-device feature set via
--device virtio-net-pci,iterative-mig=on,..., for example.

And by "iteratively migrate configuration changes" I meant more along 
the lines of the device's state as it continues running on the source. 
But perhaps actual configuration changes (e.g. changing the number of 
queue pairs) could also be supported mid-migration like this?

>> This capability is added to the validated capabilities list to ensure
>> both the source and destination support it before enabling.
> 
> What happens when only one side enables it?
> 

The migration stream breaks if only one side enables it.

This is poor wording on my part, my apologies. I don't think it's even 
possible to know the capabilities between the source & destination.

>> The capability defaults to off to maintain backward compatibility.
>>
>> To enable the capability via HMP:
>> (qemu) migrate_set_capability virtio-iterative on
>>
>> To enable the capability via QMP:
>> {"execute": "migrate-set-capabilities", "arguments": {
>>       "capabilities": [
>>          { "capability": "virtio-iterative", "state": true }
>>       ]
>>    }
>> }
>>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   migration/savevm.c  | 1 +
>>   qapi/migration.json | 7 ++++++-
>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index bb04a4520d..40a2189866 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -279,6 +279,7 @@ static bool should_validate_capability(int capability)
>>       switch (capability) {
>>       case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
>>       case MIGRATION_CAPABILITY_MAPPED_RAM:
>> +    case MIGRATION_CAPABILITY_VIRTIO_ITERATIVE:
>>           return true;
>>       default:
>>           return false;
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 4963f6ca12..8f042c3ba5 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -479,6 +479,11 @@
>>   #     each RAM page.  Requires a migration URI that supports seeking,
>>   #     such as a file.  (since 9.0)
>>   #
>> +# @virtio-iterative: Enable iterative migration for virtio devices, if
>> +#     the device supports it. When enabled, and where supported, virtio
>> +#     devices will track and migrate configuration changes that may
>> +#     occur during the migration process. (Since 10.1)
> 
> When and why should the user enable this?
> 

Well if all goes according to plan, always (at least for virtio-net). 
This should improve the overall speed of live migration for a virtio-net 
device (and vhost-net/vhost-vdpa).

> What exactly do you mean by "where supported"?
> 

I meant if both source's Qemu and destination's Qemu support it, as well 
as for other virtio devices in the future if they decide to implement 
iterative migration (e.g. a more general "enable iterative migration for 
virtio devices").

But I think for now this is better left as a virtio-net configuration 
rather than as a migration capability (e.g. --device 
virtio-net-pci,iterative-mig=on/off,...)

> docs/devel/qapi-code-gen.rst:
> 
>      For legibility, wrap text paragraphs so every line is at most 70
>      characters long.
> 
>      Separate sentences with two spaces.
> 

Ack - thank you.

>> +#
>>   # Features:
>>   #
>>   # @unstable: Members @x-colo and @x-ignore-shared are experimental.
>> @@ -498,7 +503,7 @@
>>              { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>>              'validate-uuid', 'background-snapshot',
>>              'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
>> -           'dirty-limit', 'mapped-ram'] }
>> +           'dirty-limit', 'mapped-ram', 'virtio-iterative'] }
>>   
>>   ##
>>   # @MigrationCapabilityStatus:
> 


