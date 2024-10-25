Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37D0D149DB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 18:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4OuL-0007fe-DJ; Fri, 25 Oct 2024 14:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t4OuK-0007fO-1r
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 14:19:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t4OuI-0004fO-3s
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 14:19:31 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PG0aJV017150;
 Fri, 25 Oct 2024 18:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=GmEZBhXllTI1KhuP7/LVREHqA3NI+dNSAAOmPxY1fYQ=; b=
 TB0x1MM6uDIG6FpVTDE6DjUehNYcsGrsY1gPjn358WgMlJgjS2g5+a0t0rDGN8kA
 XGhZHU2ck+0J21CwoS5RfSxGQcsL4jnO6r5/DwBMIC3Ze6qN+Gb81GHMjHYkkR/P
 LwIqhuYsqdeumxsjdc/5lASs9uqBqAL3X0I6PN7QNp5DXC/9D48hAeybdrfe+qf2
 g43K+yt2nTpmZYdfXdiTlDEgMpcHYbxKZgJAfA+Qa0fNmhNM1NhfFB7s5NBlGEvs
 sAmeIwrK0hcCqbGZ9SzxA1n1kVrUr4F74Id4O/XqtU8SyJW3A1xP0VUURB6XFTSS
 BFZVA906M7MFmVCPmxNVvA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55enf78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 18:19:26 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49PHfGGj039092; Fri, 25 Oct 2024 18:19:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42emh62xn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 18:19:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnQD1ic6hX7IyUaqLupGh7ye9GeboN4TeOtxLrRdIh4YfhJi6XekJjpjdjuhIQV/pcAqvQRvymv8RtmDMP3+L/gFsS4w84RT9jYWjs7sgOxjT+69ZdA2Fyp9cxnhHus/6JOgZnQ3uig+pFDQrx6mo7gkKNz8oYvrhnFEivznYuyvDoI8ck4gGMlXqyNlED47DdauE3JJhwl39C0WUWwbZzaJZXJRnXLAJeDE8LvrNPUELNhk9d/miGXawL8av5hAGvnGpFhmItrm3i1MPYm2mBR4aB6NoaZqfFmAzgmn/p1cBSz25YapAvvQPIlLJb/eHMl1oUJ5xGlXscP/9ivQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmEZBhXllTI1KhuP7/LVREHqA3NI+dNSAAOmPxY1fYQ=;
 b=TCKyYfVTQdC+PTymsoeL8/6y279gL3/NPvkMwjsXmQqysCOlew1fDJXq7v+qj3pi6urQPM6ISiuMjEZapcJi471j9eYdiaeVkC1AWB4hyOd02OeXVxLgHOZcfLPyqx+kZVq2QmkTe2qg8gYdLyJXKkyCmvHjUK0HxfV/GgJLl7Kn4HoXIXnnTaMqP/+j3YexJ/F7PWA316GtmfQvhXcU+31ubSAzSSgi+Y/Gll3j+hFMLV2eyxZ54dJC5mQETTQBKbqcb6CRhdJoF1et3Ho3zruMyF+N0mwY/5WSfV/kjk6us3efs/LIuXiChrECGFY5U0dbTu3Ry6yiomrO58zJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmEZBhXllTI1KhuP7/LVREHqA3NI+dNSAAOmPxY1fYQ=;
 b=d6R5kjEMj4tgph3fWHrmc5ZdmlzpwfVZPcmxgFLTTHlt78/DLa+oj0+i41RtCiFJzlqFwJ1D6GgRMJU/xI8Y5drN/ZaL9hVLUM+IUcbqS4MGTF+jPlQ+YIc4WHXildbajxKK0tBeHIUpTZitBowlA5McujOTRvlxsP3TnNubqjo=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by LV3PR10MB8009.namprd10.prod.outlook.com (2603:10b6:408:285::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 18:19:22 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 18:19:22 +0000
Message-ID: <74a34ee0-51a9-4f46-9d24-a8b97a2e7577@oracle.com>
Date: Fri, 25 Oct 2024 14:19:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: cpr-transfer with caveats
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
References: <87b1beba-4e03-45c7-b6ce-2772dcb117d1@oracle.com>
 <Zxu_MqXqm78v3zJE@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zxu_MqXqm78v3zJE@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN8PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:408:94::47) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|LV3PR10MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: a5364ba6-f688-4201-3afc-08dcf5218c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0hiYTlqV0lqL1RxNkkwUVNCN0x6Q1pBY25Va0ZhWldGZ0wwcFRucUdVOTha?=
 =?utf-8?B?bWxUTVJyVlp0bDJDL0ZhVVUxR2VEVWl6dW5xbXZiM0NMQnBybjlHTUlvVlFq?=
 =?utf-8?B?SUNySi9oNXVtaWNUemtyU3RXWXQ4WnBFYjdnaEZUV2U2cmtOam1KSkErMVMr?=
 =?utf-8?B?bEgzVjBWKzl2Sis5dUNva0dtM2k0TkNDNTIwVE9KcDZadGFRdjJjWk5SS3Zj?=
 =?utf-8?B?ejBHU0tWWFB5cDFjV0hwVmh2Ym5kSnBoM1MyMEljdnV0cmk1UndBSkNGa1k1?=
 =?utf-8?B?akl4cTZWSmJKOXhXR0NKSzd5eTZvTi9TaklmdkttczA1WjErZ2UvQkFBeWJl?=
 =?utf-8?B?WXJpM2hTY0I2ZnI5UWxVVnplUGcwQ1dKSXU5TkdtMG1vUmVvVlBVek41QlNB?=
 =?utf-8?B?YmFmdjk3aTd1Vy9mOXppNWVLUjM0RkFLQmNjYStYVm9iV2NYZVVRdkFMOVdl?=
 =?utf-8?B?Y1ZLbjM1eVliMkNFWnFGQm9TZGxHWWMvZ3dINlBVcVptUXBqbGZWZUlhMWlT?=
 =?utf-8?B?OGIyUXdIZGZnaGRydFdPcFYzdU5GbWhlaGZrS1hnbmprZWtiVjR3MnV2TW9S?=
 =?utf-8?B?a0dvWHpsZ2hqQmFEekt3K2ZOYVpsMGIzaU5YYkVSTFk2SXd2TUFYY0ROZ3pV?=
 =?utf-8?B?bmszb0Z2cHphRG9hYWJmSDNQSGxIMVlzZUl4OCt1SEtVY3FheGdSSnlqd20x?=
 =?utf-8?B?QThTNGlXVDhmZkdGK1J6MUtqVFF3bEJZSkM1SU1BRkJHbktNZk1IU1JrQjVv?=
 =?utf-8?B?dDRPUGJ1SVpmcUVrZTVkZzZsbm5mMm45ODVGa3lQOFcrUnBPRWt0YzJ5SGN1?=
 =?utf-8?B?VlBHSHZxT1YvQkJqenNWQzVjYkxCWVFBV25PalVpL2tMTU1xSGFrSDlpT0VH?=
 =?utf-8?B?ZVk1Y091YWdMVmJVbm1ZdVVSOGx1SFcxUHd3MDY3WXFUNW5xZGFaUi9FM1Bo?=
 =?utf-8?B?UFMzZzhtWlJqSU9pSzdzdElqV3BYSHEybjZLU3BnaU55S041Y05Sb2ZpNndN?=
 =?utf-8?B?aHhDK0pRWTVxQ2ZkMjEzNzdUWlR6OE5nWXZySDFhb1dwNnZScVdsaXQyWEh2?=
 =?utf-8?B?akoxUFZoS2w0eHFGSk1JT1Ewb2JsWDdXV1hGVlBUak1FbEMvM0YzVVdzQ2Uz?=
 =?utf-8?B?em0vTXZDb2FBMHhtNXhkbG9FU1lhclYzUXppa05pMVU4bWxVczJHTVFxMnYv?=
 =?utf-8?B?em1LcHFieFE2blZNWlY3Q1JPQXJqWEZKTWVpWXRUaGR3SXNLenlFdlBHWFRv?=
 =?utf-8?B?TWVjaFlodjZIdXVlN2x0Ylp2dzIwL1hacEpsc3RGNm82MVcwSHIzeVRRbTNa?=
 =?utf-8?B?RjF6QUNXSnB2VnhFd0NoU1JtQStJeFpVQjEvbkJQZjV4SERCTWo0L2pmZjE0?=
 =?utf-8?B?WjdOaWFNeWFVSFE2UGpmN3p3RnVKenhUWXNETDgzL1RFdUdoUDhTUGdLTENm?=
 =?utf-8?B?N1JrS2hxUTA4OVR0QXFUNlR2NksybTN6MUR2Z1M2b1NCa0NqVllVQUNEL3Zr?=
 =?utf-8?B?dGFhQktxTWwwd2JiQ2YzUjgrZUU3WFRGc2tuK1gwdTdrNFJCMjlPbSthYmY0?=
 =?utf-8?B?dXNwN2ZRN2dMMnc3WmF3VnpoRWsrVWVnMUt0TU1rc0poZFdselNZWjF4Skx4?=
 =?utf-8?B?QUlUMW9qSnJWQVl6Q0JJdmlXdm9mWm43Sm05ZEd3NGtkcGtDMTc0b2gwc2VW?=
 =?utf-8?B?UlJrWkVEb2lKMnBRNzVFWmpTb3pLRExLUTgyU2VFcXVFVTh0Z3orMnBJWlZq?=
 =?utf-8?Q?SVUIxPai0UbXXqlnlpwt6NqbLf//z3GnJA7p/M8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anJEY3JSeTBIazVwRG9LNUxhYU9heWlCV1NwSmVmS1M5V2M0dnlIVWNaNFNv?=
 =?utf-8?B?TUxUR2NEeUQxcjU0MXR6RnY1STIxSG91SitveDVsZXVBdDVzVGNvWUNYV0hw?=
 =?utf-8?B?dzlwcDRmSUpqblVNL0l1SHhSQnFSQ3QzcmJHU25lKzRJUVlCK0g5RThtbHVK?=
 =?utf-8?B?bjJEWVQrNWlwcW45US9ZNmoyN1FYaXUyZkxkZloyRG1jcjRUbEg3Yms0QXc3?=
 =?utf-8?B?WUU0WTcvNVMycUJxWjlqV3Y1dzJQaEhGMFZHL2V2OEhWZG9oeVFGUVNiV05y?=
 =?utf-8?B?aUJSZnhLekhMalN2YjN3allrVm13UXRlb09yMFlKbm1PMWZyeGZqR2xSSndP?=
 =?utf-8?B?Yng4Q21TMHBSSlFXZ3NSaUtQY2o0S1Rab3ZPK2NUMnB6Uk85Sk83NGp2Skla?=
 =?utf-8?B?Wm1KYXFjYVNINzk3aWluNHIyQW95UDZ0RmMzcm0xNk4vY2pVYjNmdjdDbGM3?=
 =?utf-8?B?bXV4Q1V3eXdDTXVJd2Vnajh5cVM5OE1RdHhaTXNxUVh4ZWNZODNNNXNPTldy?=
 =?utf-8?B?ZGVKMTI3NzEwdnBYY3VtMjZoSHFnMUpWaWNPU2JrWTkxMUVFL0djMVBOUEpD?=
 =?utf-8?B?ZXFLdFprYm5jYmQ3N040ZzZ6T3ZjMzcyQzRCQkJhSTVNeGhkMnpId2F2cXBh?=
 =?utf-8?B?d0lRek15VUdmMGo4eUJaV3Voa213N01MMzR2TnRZVnFrWlVYNVhpaXpLWmx6?=
 =?utf-8?B?VnU5SjBLc28wWnBYSXRJaFNXNmRvbG5qOXI0RW0yaGJ4YXg5TDJpQURBaW9w?=
 =?utf-8?B?Uk04dkpxemZMTTBkNGFGUVhucGQyV0pWNzF4ZmdsU281TlZSaFhPM0h4WmRS?=
 =?utf-8?B?alQySTExTVA3aFNZMnFUeVlZRUl3Mk9KK1lMcmFhdWtvazVxRFdHdGhhdVB1?=
 =?utf-8?B?cmpaVFVpKzdWYXBId2pQZnNzMHR6WEZpSTY3MEJCSW5QVGN5Z1dINlVEd29a?=
 =?utf-8?B?Wk02dms1b3RoYVUyMmd0Y2cvd2dFd0FtN21ZOWZtcUYwMnFEVXl6L2JJTDI1?=
 =?utf-8?B?OE5EVE9sR1d5ZWhURHgyTlRiZFlHZ2cvRGtYOXowbVpEL3ZFN2RFUGNENzZZ?=
 =?utf-8?B?a1pqYXBJQ2tQVWdtUjRuRTJpekF6QnJUbDJFUWtMajB0ZkdZajZJU0Zqanhy?=
 =?utf-8?B?MmdWZVVJZFhmNTZyWTEveEQ4R0ZkYlhDRkxwSE5uRFBBOFl2cVVkS1VoS3M2?=
 =?utf-8?B?cEZEcytXWG5sMWpxYUZjdFUwcSt6b24zL3dmMm4yUWU2dnM1cHpQRXlud1BY?=
 =?utf-8?B?dDlHcmR4TUVJSlVlWFUzMldqSE5vWkFCdlNrWGVhTzUwRlkwRnFDK0paVkdV?=
 =?utf-8?B?OHd3OFlackoxLzNjVFlseEpSV1Z6TUhIcWhEV3FXSW1BMEIyaTdtaUhpUXNJ?=
 =?utf-8?B?STdHMkdqUTVqaWRTUCtNNGVyTkwzSXdUVlUwN25BMEpXb3Bib2tYZjg4aWpM?=
 =?utf-8?B?Z1ZPZnJhcTJxM29sem15R3hjdFFYNG1mME5mMStENWloc05FTFcxNU1YQ21Y?=
 =?utf-8?B?N2ZKYk5Uc3ZNSERBMkpNcHhUZjIxd2hSUysyQy95OGlqZmNtV280TERLcjJk?=
 =?utf-8?B?b0x0enpSdEJkUFVCa0hNL3RuL2srWDZhQ3ZGMHlFWUZ3REt4VEUzLzRSeHBZ?=
 =?utf-8?B?bmpKejUwa0p6NDdJZXQ2RzB1N1cwdnlNZ3RKajFSVDVXVnZKa2V1eFVBRkpS?=
 =?utf-8?B?SWdCV2dFWGR2R1RqZWpmYTErVU0vdHJFTXRBN0lYeXExemd2Tk5jcFJyR25H?=
 =?utf-8?B?QzVnMUgwc1RiQVdUek9kZ21Ea3BmZTlBNnhTaENXM1NVUklnZ0xVR1dpM3V3?=
 =?utf-8?B?SStjcFRrenkybkF4RWZFVUZzT1ArRFNuanlpcDlKL3lFOGVXalhxNGpHMURO?=
 =?utf-8?B?UDNUclN6SWRRRlBGa0FaN3FTMWxlNVJTZ21ZL0xTWnBDZWNJZm9OTEQzS1B3?=
 =?utf-8?B?MFJJdWxMS09UY1VLYTJwSWUvVW1lY3pnUmh5T2JIbzVrcGN6M2VhV2NKUjll?=
 =?utf-8?B?UHBNTlJlYnhrYTRVNHRBNU9jNTBhc0V4QVljR0ZGb3FBQmJ0U1F3aUx4YjU2?=
 =?utf-8?B?bUtoSHh0S1R5UnFvV0E1Njd1SnJaTFFwMkludStoZG13Zk10SUxGOGZBZ085?=
 =?utf-8?B?aGhJczU0R0Y0U0VOSGMyeXZCT1dlUktyeWl1RU1QODRmUUVXakh5YzV1SUhR?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: czKEDqsI3oJwegU9GqqHyLOD6hhqg/8V9J5qBLuq/UHQL7NDlHvOVWdd5nCX4Ypq9YJNWu8LkH4Qc2SFMWHm6FTcsV8TPysLGzvIgwXjYMM9Emb+Nh8JyIwLWg/KEKex/GYhedSXQb66uzImlDagNnDxRkDjGi5C2awqq6aNGK8oqYek3tLTyYqKreikzysp9HCHVDhEFvVLYuT8P86fscTeN/k9pTWMcEm5UjdsuJOdHtvpmtrMqKXTTaVwaQyunmtrN2osmHRCKbvfsong9ecaXguiPGRgDxEAt74JiBVIHB7xvYABJRCqGPw5SZSW5TLGTcyY/XMvHonlEXjgDEnEPcTUruXX+IyBGNxQoTvucyrY6hoqNBW6h+CPHNDHlJY6hzyyBCP3Avb0WItWiwgxtdouXR/L+6T89MU5h37Mv0cmDxvGEYMSFjh1Rfn93EUJM91i08vrRunskeWw5CwPKz61M9HPbMKujmG064M3PfceAkgna8GlRS5IUmum1xZnTeK9X/Jymk7LDW5E30lk+VyWrb7jOadEzxkWmGq+ihYJQxMd9JJz5BjN76WaqXTdLBF5S/EzK5gVIPO/FkwEAAWOcpPJaDENqeoxnD0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5364ba6-f688-4201-3afc-08dcf5218c94
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 18:19:22.2230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYY4+pkNgr/uzNCyepNO/ceNDPq7b/liSuCKpHdlHz8VwQXBcI2CO5AeTKuhU6Q4HND339koO1NU3arkeTLyOLhJDy3wh1NW+Lcls6JRC34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410250140
X-Proofpoint-ORIG-GUID: WB9elnjlI0rKuguVF_-sIybTSOFtFsIQ
X-Proofpoint-GUID: WB9elnjlI0rKuguVF_-sIybTSOFtFsIQ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/25/2024 11:54 AM, Daniel P. Berrangé wrote:
> On Fri, Oct 25, 2024 at 11:01:27AM -0400, Steven Sistare wrote:
>> Hi Peter, are you OK if we proceed with cpr-transfer as is, without the
>> precreate phase?  Here are the problems that motivated it:
>>
>> * migration test wants to enable migration events on the dest.
>>    fix: enable on dest qemu using -global.  only for the test.
>>
>> * migration test needs to fetch the dynamically assigned migration
>>      listen port number
>>    Fix: require unix domain socket for cpr-transfer, or a fixed port
>>    number. Document it.
>>
>> * migration test hangs connecting to the qtest socket.
>>    fix: in the qtest code, defer connection.
>>
>> Document that one cannot set migration caps or params on the dest
>> for cpr-transfer.
>>
>> Document that for -incoming defer, mgmt must send the migrate command
>> to the src first (so dest reads cpr state and progresses to start the
>> monitor), then send the hotplug monitor commands to the dest.
>>
>> Daniel, are you OK with that last bit?
> 
> I guess it depends on what happens inside QEMU between reading the
> cpr state and libvirt being able to access the monitor. Libvirt does
> various things with the monitor during QEMU startup, before guest
> vCPUs start. Mostly this is around host resource placement/mgmt
> that needs to be done before the guest CPUs start.

When the monitor starts, there will be no difference in observable VM state.
The only difference is how you get there -- libvirt must issue the migrate
command up front, rather than issuing it after issuing migrate_incoming.

- Steve

