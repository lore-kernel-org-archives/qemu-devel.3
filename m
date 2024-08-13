Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E30C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 21:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdz4M-0006nn-U5; Tue, 13 Aug 2024 17:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sdz4J-0006l9-QD
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 17:28:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sdz4H-0007Th-PB
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 17:28:39 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DJBVxs023104;
 Tue, 13 Aug 2024 21:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=mRqM1AxTxB1Qs7cADE58tNPPRIMHY6kTIx+sCrJa8Y4=; b=
 AjH0fS287nU6GGdtkOTxWrCmIHr7XknzE85ucGXXvyTeGYI4/XCGrtlFiizqQPqd
 xWZUj/tuW66ZA1JOkcWP2nZw0q/Jv8QVi4F9f5fvLjQw/nTEOQhX4hvvTzawW1Ay
 YLQm2CNZJUVMFJgIONmEPVqubuPrttCqiYx9fmAbMhl5sJVHEdroYKd2SgabbnDC
 4FRp45LGIeKJisZgFdBwHzvQHvJK7TeT/RkjhpPbAeDnEP6fEexcfLAWKVwJ7dMS
 ujaQweQFKwuGFiaZ6Z744vy6K7tyWFgPIjUzirbktHc4l3qFmbP68x0SvpDfpGBL
 LlEKGrx2x52j+8FL+6kEfQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0396wah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Aug 2024 21:28:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 47DJnhJK003693; Tue, 13 Aug 2024 21:28:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40wxna391a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Aug 2024 21:28:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgSO36T7Hyd4nhRty2msT6a7Kxo5kR2SDAAIJpTN96uXXdmihTidhqTp8TaouTWxfg6BJzjM+HwKjZutpoYTTsfNizB33oTWrq/1AurS6UsguAS4DXpSAYbpPCUVSSMlSgIn37iD+QknWOdrpC+QJxJLrRxEPr38RZyK2a9s00//UCVYXUQOiFkKNzgdQLh82x011DE7MQV6Yc1mL45ryM3n/30iSyJXK6UD4BCRjstOeprVHMSR9zFEORye0KOtWQg9s1+QDvw+pkD62comHO/Lmfex1JcmSKVk9c8JFgULstkLASOp9DtEQPdBK7XIbxUkNStSVAMmgU3Psi/15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRqM1AxTxB1Qs7cADE58tNPPRIMHY6kTIx+sCrJa8Y4=;
 b=bEFmV67vIeH6MEuUxMzheSaYdGL4gwQGxRnIqm/oY1NefrbxQD2RZAlkX4MuashTl08RjvztReCXgZPT7/XUf/CFIYfPKdxjjIB2b1CJwbbEBieEkCdQOGDOzC6eZFDNFHXetsX4QVvEAduCNzPGaAsbUsW8qZMoTISXCzGyq5TFuOq6EbCOqp3H5IxNUv5ePUfV4yDpyey+7EPPIbKgmYtdrTN5D1JI2oh6dUxbL++L5W3bFyZ7PEUg68yXxubhzdHC+sqbWb/TOAAtTYqjgCgLi859kMl8/IOdUXfikVsq77US5nBg+kwvy0YX7lZZflF9E97bjyi0LYt1evBDkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRqM1AxTxB1Qs7cADE58tNPPRIMHY6kTIx+sCrJa8Y4=;
 b=TEoy2ci8LHAw9k9AQZ2YrURXva35kJ0d58plRb+371bZopnToH/12p0ei9F5JR1O99bfWOsW+T9n3Frcy4z6GXyb4ASkPPQ5AgQ4ptaDtbWA/PppveDKp+HiLcK9I55VdR/nwh2wo7e7LYyNY7/kginWnMWIHpO+30gaxVtoEz4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BLAPR10MB4898.namprd10.prod.outlook.com (2603:10b6:208:327::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Tue, 13 Aug
 2024 21:27:58 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.7875.016; Tue, 13 Aug 2024
 21:27:58 +0000
Message-ID: <9ed72d1b-6a49-4331-b4f1-b4ef653b3d44@oracle.com>
Date: Tue, 13 Aug 2024 17:27:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 6/6] migration: cpr-transfer mode
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <1719776648-435073-7-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1719776648-435073-7-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::27) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BLAPR10MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca2e339-407c-4e47-5c63-08dcbbdecd56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RktObDFES2RudWdMSnp5ZUFienUvaHp0eEdrUnp6TExDSWFnbVZRTUFDT2lx?=
 =?utf-8?B?MGVaZFZRWTFNcm1aSGFjelJWWnUxc2Q5VE5oR3U3cXdhYlMwSDQvRTExajFN?=
 =?utf-8?B?UU5ZcmxPc3VZNzhzOUNadDVUUDU2UG0ySTBha05iL2RrbXJBbUtZRUF5N0dS?=
 =?utf-8?B?YXZJRFkvMGxmMU1HbEV6citTRGdZbzZaalZ1dXJiaTJFS2ZFcThmOGJzRnc2?=
 =?utf-8?B?cUMyUGpkclpveVFsZHp1YXgzOUpXRHk2Wndxb3JvYnJRVmVqWUtwdkx0L1NJ?=
 =?utf-8?B?M2d1NW5HNk1tWVFBaUg3cG8zOTkzbXd1VmR6enFUcUNjLzd5MEk2aDhmTzVG?=
 =?utf-8?B?c24vcDh6cldZVlhJUWVaVlAzQ0d6aG1leXBjaVJSSjE4eHExQ2xBQXA5R2J6?=
 =?utf-8?B?enFmOGZqd05jTEVGRjBGcG1kODg3cEF2UFdSRVJhbzBTbUtBZlQ0ekUxWEZx?=
 =?utf-8?B?NFI3MTNoZDR2ZC92bzQvTGtidC9ESXFiVU9VVVY1amYwTEgySXcwSUNXQ2o4?=
 =?utf-8?B?bURDVTg0MkR6UER6ZlZkZnA2S3l2Zmx2NTRBWWN4ak5iaHl6bGs1aFUrNmZ0?=
 =?utf-8?B?ZjVuaXFFQVhOTXYrMFZxcHZ1RWR2aFlVakhyMFVOVGZWMUtqWk53MlRibFp0?=
 =?utf-8?B?ZzZzRTFJb0VxbTg5UnVuZi93cGE4dGdwdWFhR1BLN3N6bmVxUGR1SnR4a21Y?=
 =?utf-8?B?bGcvL1lYRFlDWVRUSEpZVFlSV0VNYm9NVGx0THMyeVZ2L1FkeG1kUmY5bXFG?=
 =?utf-8?B?cm1jTnVqYk53OUM0R1RvN0xSUGllUUp1RFpBMzN5T2hSYnN5eDN2bHE0Y0pL?=
 =?utf-8?B?SkZ6dDNhZVR0ZEhxR0ZCbG1wNjl1ditIZndXNDZaS2lzajdUQ2ZPRVpNNFdp?=
 =?utf-8?B?Tm5reUpEaGRxb2FTVktyZTJGMkdoenViWjVpc0F1WFkzbzE3eXlXUlJXc2xL?=
 =?utf-8?B?TGZ0bG5iZlVLNWZHSnFybFZhK0ZVRlM5Z1hlLytaR2JyNjZSVnBqcDk2d2xQ?=
 =?utf-8?B?K3FHNlFCNUNBR1l4ejVBSkxLTU1RVE44bmdYNzNiM0FaM09TcTV2d2twMTl2?=
 =?utf-8?B?ZXhlRDVTK1JTSjVLd0VsUElEUmxtcHBGWWFtbk43TTYvZVBGZkVCbzlmcXZU?=
 =?utf-8?B?dFNHT29BTmVkYnYvcnF0OFJUTExGMlgyQlM4aDJWRjZ6KzZTamYrN3BIZ2lk?=
 =?utf-8?B?d1VPc0dEazl4eUhnbGpwOTErRWlQaDRTUEwvSjQvdmE0MXJxZ2N4RDBlVGMx?=
 =?utf-8?B?N0tyR09PVkx1aGpiV1ZTUFcraktTakJhVTAzM0hsVTZCWHJBaE5NR3Jrc2Jt?=
 =?utf-8?B?RVBjTEVzeWJVcTVmcWpWTUc2ak1Ed0o5T3JQdHNJR0RuUGpvVmtPWEIvdTdn?=
 =?utf-8?B?SUI2Z1J6bGYxZ0VYK3F5Mm8zM2ZCUk11cC82bHAyMUxJQmExL2h3MkVZVS8z?=
 =?utf-8?B?emFEUWdadzFnVFZYVWNjVElWK1BqOFJjU1I0N3dtODJ1dkNDWjhDYnZGV0RV?=
 =?utf-8?B?cTc5UFpaZDFkRTJpdHVxdTQ0cXduaUY5NE1wckNOOGNpdzd1TVRTVEx6YXRl?=
 =?utf-8?B?YXgrcjJJMVlwRWtnYndKQlU4dkNOVk9KVWswbVhqcGV2UVhlb2pJUEJEMXpP?=
 =?utf-8?B?b01YU0paMkk5SG5tZncremtQTWNXZVBLNDB6RW5UdGo5Tm1xKzBpYUZvREM2?=
 =?utf-8?B?QlJJNmFXV0V5ZldiZDdLdXByaStqVFgvbXpqdUhTRjFWUURTcGRBMHpIVC9W?=
 =?utf-8?B?WlRIRm93ZmJCb1lFUDJ6eTJram10bHhndURLNU9mdWttYWdRc2lMcTZaV0py?=
 =?utf-8?B?SlNOMGg0bVZ5RWtDMEI3QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjVJaGliZ3F6Y1ZKNnhUcnNXaW9XTExhTk04VjhFS2l1b1ovZ1FRTEVyU0VQ?=
 =?utf-8?B?WU5ZK3dWZkNLRlRSZlB2R2ZaeU9rSCtPcUxCbE9CcXd2L1hkMEFRV0pJT0Mz?=
 =?utf-8?B?RW1aU1V2R3FHeEpvdEZWNHNKMFV0VGJtZGI0YnlnMkMzMm9SM3RzbDM4d3Jo?=
 =?utf-8?B?ZFNQQklKNUZSUkppdytueUxOcC9qbWxFc1JXSFQ1QzJyYVFiZXl2TEhLZG5q?=
 =?utf-8?B?QzRkeDlxKzFlenZUZnFLWk1FcWJ5cjV5WlgyZVpoUzVpMFFsbnRVTDJzb0ZO?=
 =?utf-8?B?alppYWJ2dy84a3lJNzFOSHVQQ3FuTUkxQS9TQkxwZjZiUWUzbEptSTdRM0xX?=
 =?utf-8?B?citlcjlxY2VTb2lXNmsveno5M3podlF1WElpNjMrVjJYb0FnNC9PU0Myc282?=
 =?utf-8?B?NEUrY1U3NlNrV1M1N1hSZ01MaG83UlVnREVZTndSWndLeUpIV293U1hVRlRS?=
 =?utf-8?B?VDdaOHJvTDNvT3VUSGJlUXpUQTlRd3lXQ0lnckZaY3BHOFkrWHg0ZHFDbmxW?=
 =?utf-8?B?WUJZMExBT295NmMwMGhlYytmQVN1ZDFWY2RkdXBVTFoyRm4ybmRKTlFOUURj?=
 =?utf-8?B?T3RsMEVhWEFmUmxaYXYyeDJ3dTBubkR1T2FpcGRITHhOSXNOQ2JENHVtVGM3?=
 =?utf-8?B?dFllTjFqeDRSRWRPVnVKL3JZSmgwZ0s0YzZmRUdIWUVrNFpwUU10RWFjaEZV?=
 =?utf-8?B?dmxNbHlVOGdwTjg3aENEQk9qZTBEU2FwaVV3R0J1cjdpQVVHY24wMXZRSktI?=
 =?utf-8?B?VzBNWE9ibGtQdHhMZnJTWU1ubmlxdTI4UjM5b1BxVUpqcVpIRldBUndiaUhS?=
 =?utf-8?B?bFFuS3Npb0lEbFRrQnhhVzU5eWM3T1Z5d005UFIrVDBBd0orMEE3VWx6L0Yv?=
 =?utf-8?B?T1d4KythcXYxdXlpc0dibVpOazRnak1FazdWdzF0aThjRWJPVXlOWEFzNjB1?=
 =?utf-8?B?NGtNMkFoQk4xSFZHS3BVRE1IamNPWThBd0JIK3ZMc1JudDNzSFpVWGk4YU5Z?=
 =?utf-8?B?OWIvV2VseFA2U0NMZHI1YnhjMTYxeFN4OEZjdkdYQUl0Z09mbkphZzBFZ1Vx?=
 =?utf-8?B?dFRoWlJwWWhGUEc0cEdlZUg0TWd6WGhaVUwvbjk4Sjk0Ukh5NXhQak1pNzJO?=
 =?utf-8?B?ZFlnMmUxYWU4c0J3TnR2Nk1SWHdrS2taWkpvd3AraXdzazZDYkJxTE9OWUM5?=
 =?utf-8?B?dGYzVXQwdHJsQnNEMmRoQ2ZzZGZsckJ6OUFyYklDdTdJSFVqcU1JbGRWeEcr?=
 =?utf-8?B?VUQ3Z21OeVlBWGJFUUNKMy9wMHJyWWU1WUhQV3B0YVJyVWpFaGVGMzNKTm9i?=
 =?utf-8?B?Sys3bFhHdld4L2Z2UnJDby9IcXNDRjVIMHAxQkIyaTFBaTUyUjg0M1czMW9X?=
 =?utf-8?B?Z0xlb1pMQTMyS085OFlMajlVNjlTeTZvaUx2bEpEYkUydklFdVFzeE1lOVJU?=
 =?utf-8?B?VlBjcWE2c0ExSC9DUzNkVjdMUHpXWW1IOERkTXFJYnpGKzNUUTRsbFI1Q3dZ?=
 =?utf-8?B?NnZIdlBGYlgwMmVxVDBzSlZaWW1kU2duVWRWR3BOYU9RKzIzMWh1YTFqbDFh?=
 =?utf-8?B?bU5vZmR2RkZyMW14eVlKdWpzdHJBQU43REx1bGt6bngxbEdUbUczUlBUV0Rs?=
 =?utf-8?B?ZWNwM0d4TnRPbnJuSnUzTCtSRVJqS3J4dFVycUVpaHB6VG5UWWtYb3o4MWZ4?=
 =?utf-8?B?dWxUdlI5N1hHWnBHa08wWG1RVll1R1ZQUjBHbGNlSXR0Wi8vdDVBRVFZTys3?=
 =?utf-8?B?b09sNno0ZTZYUm1kY3l3eFI1djh1NUF0ck5uRzZHY2kzeEFaL1RMVHJCdFY0?=
 =?utf-8?B?OXhQL3huT3pNSFNhWUNEakk0ZUp2V0hOcUdTdkt2clBCN0FWYkN4enFBd25J?=
 =?utf-8?B?MS9Zc21pSm9aUHlGbUJyR2ZkeUhKV3pWWGhhbFJUa3U0NnFsR0lTKzRXcTg4?=
 =?utf-8?B?VlU4cnRyUVdqbFh3VGhUQXplS1RxekRrRWdJbDZZVGs2c3Y2eFM2NW96T2k2?=
 =?utf-8?B?R3ZIdzc3VklxMVo0STlvamVXMDV4U2VURXN3NzQxWXQ2dVk5OFFpcDVsbmhJ?=
 =?utf-8?B?VTdsQXlJckcreWxZRzNsQWIwME9WMjIxUkZTa2xQWFhMT1lBZ1QreTZIbmEr?=
 =?utf-8?B?a1FWMXY2Ky90cUxaektpdXF6N1VOOUJEUFA4OCszKy9JSWtYbnhjQVNVZFhI?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XiSlJouYm1UWY5c/E2JL8lVQnsSSrB8IXYfWxE65r2dQF67nrLllNPpUlVyTfKSC73dktZG0I85b9CQkm5X9ZiizzzpDrOHFfkeVODSvGBTO+GdJl9jkY1cSmI1DwbtI1Dx6QwNE7vOgwfZ5H16lOFsgWG6hMJ8U+X14UxdQblHOcASFWKNfz549ywuHEyD4MQKzSJrohFASnGNELEZi3J4T4H4sgdnOIhrjjazTl/F1udoa/GMAFkXvlDRZTZO/VAe09gumRmgNoWy1E4CtifFaCeAos06/3k2BW6s5G7Eug6HBtVV8dgy6TPcCHKjcYIo7WauQ9X+ApMl17eI0oCLx0yBvne6gOEPyRZShwZeQOjwToHRgkNc4e8tpcoPHMvJg6nggeyhjnrTARLiho8TAkKM7h1IdhQfw+N+NZ/RnksoYc+sIGyIHVV5v6UaLWzYgl+UCgXHNlmU/hT5Jkcu2b+EL/E6wKFZGoagUyU91J9BSV+JkxDiNwZ/YBk6M0eRhzIu4v7HkSRFpowAhlts/UCgCSE9bMw7jWn2Jd1PpWs6D8cY1iJkgDvL/kfmkH2JF0Ddpw8e/kqZAfUIUDvhCnkzEjeLJ2icoORcAHtg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca2e339-407c-4e47-5c63-08dcbbdecd56
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 21:27:58.3720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHlkSMXx8MP1tO8nYFEyJn97758REiBzJhmsLz8UFIJaKxsXqZkap14VBS4H4CBL+7syCnPrMWfCdc8jUgfrOy4mLKP7l1aRHt8YXrXBV8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_12,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130156
X-Proofpoint-ORIG-GUID: XQ7ZU8g_Qy65ZfVr4vWUKzlEt8b05koU
X-Proofpoint-GUID: XQ7ZU8g_Qy65ZfVr4vWUKzlEt8b05koU
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/30/2024 3:44 PM, Steve Sistare wrote:
> Add the cpr-transfer migration mode.  Usage:
[...]
> @@ -2144,6 +2158,29 @@ void qmp_migrate(const char *uri, bool has_channels,
>           goto out;
>       }
>   
> +    /*
> +     * For cpr-transfer mode, the target first reads CPR state, which cannot
> +     * complete until cpr_state_save above finishes, then the target creates
> +     * the migration channel and listens.  We must wait for the channel to
> +     * be created before connecting to it.
> +     *
> +     * This implementation of waiting is a hack.  It restricts the channel
> +     * type, and will loop forever if the target dies.  It should be defined
> +     * as a main-loop event that calls connect on the back end.
> +     */
> +    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER) {
> +        SocketAddress *saddr = &addr->u.socket;
> +        if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET &&
> +            saddr->type == SOCKET_ADDRESS_TYPE_UNIX) {
> +            while (access(saddr->u.fd.str, F_OK)) {
> +                usleep(1000000);
> +            }

I now have a proper fix for this handshake in my work space.

- Steve

