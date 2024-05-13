Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F30EC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 19:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6bMX-0001a0-06; Mon, 13 May 2024 15:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6bMU-0001Vj-RD
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:29:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6bMT-0008P4-A0
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:29:26 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44DJ1B0w025459; Mon, 13 May 2024 19:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BgWCXdyst3juafh9e6s/VOyjjjMFwN+YvT0W/0yV2pg=;
 b=HkRU1Hfx7qv+xIFuDwXnuQh3hrXP3g8JpSuKZoALs3dF6s839+Rw42FqU3Jn9U6crtHN
 Yepo78z4leXHKuYB1uxL/s9BuHj2zwnzQkyyNpr9PJjmelJLgh8WqHO7Ay/RuCxjcGm6
 epIfODgV4L2gOwyBhuqEBO5i/OTZV9UnYkWx//kdHnnJ0hxyWiVRvDFkDS54IkRFx8Gi
 eLXsB4v6hvLaEDbWzA2SriXskVydNvg2s3GrwA0Uc9EkQnYeKfCg1kKzwiqm8T056mIX
 q4BN0U2kwdufbqe4sI+egFrd5nz22dk2bPLMyo0inhX8BDzJhO0zG8YDOswcDDrhCjTS lw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3qgv08sj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 19:29:21 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44DIDZ7Y017476; Mon, 13 May 2024 19:29:20 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3y1y467wfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 19:29:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S02w0lDLQ1KxEx6+UdCSz2UVeqMPnPWJGEA/xzdracmzaect9d4NFOsMI6hZuUN4nP/yFXuwuZTBHeRfbYJxIMWasGrPMRrUcodYxS5XG7Ef94Y1fGDptg6rEEnrEXFur3zIo3MLTKM0axZ1e6Iro/icgi+u3o3bkXGjqbg2wyiGZ4pmQ36kuBjumJMne7+M0BR1gte6mawcGLTuokzuuReEqkzX5EFxqGmk8nJD1VvEgkiqnGvp1MZlBBRQ0u6toU5uXtld87FQdPU2dAUhqASV3AdetmTS5Biijaw5/cRXESA2Urc7rDzoOLG+sZecqOqRUgklARZQPKh4h+oqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgWCXdyst3juafh9e6s/VOyjjjMFwN+YvT0W/0yV2pg=;
 b=Oqmc7KLmGxPGkym8aRYbwPiRvBmBWekBTjS1LaE94jOt1pRbWnOVngghFSZ5UlJEDL5mmqcRUU2qms3+b0auDxpll2oBvEhLvJcSqASvRke4pTZk7PmwleUijXtJEVDg78GzrwK9Q/qiPg2valLyKpYjHNBGbvFgNo+cxfYIx7KjmeVYXhMjXa+PchbezzoMp3fiu92BvnZ9R0K3kniiX2VdUXyHX7+2dgecLP3UFxiJ9aOioheqmLaxQVr1JkWWJm58/sD/NOTeyLTKd87aZyQfdcO7AaMM+59Eca+ttRKnRU09XJHufzGQtlbdFkSrVFy0PLLxdpWusyxJYO+SDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgWCXdyst3juafh9e6s/VOyjjjMFwN+YvT0W/0yV2pg=;
 b=vS6r+bVCoDSmylgJ5nsFuUDSGxn428ZrcDPOY8xrsyUxB/Y8au9DKd+pftufUVMIqkPLrV9QpSBgWGPWt5E+Z3rYzi/kD7feshqFYbHevUUpFAdoBzmj7UOH4DbTsy+y4scvPbuPR4KCNAU7wdjSTypxxM5G9gYvcUb2hriZ2Hk=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH0PR10MB5756.namprd10.prod.outlook.com (2603:10b6:510:146::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 19:29:17 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 19:29:17 +0000
Message-ID: <3a942d56-7af6-4cba-bc3b-93e9d24f6791@oracle.com>
Date: Mon, 13 May 2024 15:29:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 22/26] migration: ram block cpr-exec blockers
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-23-git-send-email-steven.sistare@oracle.com>
 <87ttj6kgo8.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87ttj6kgo8.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0036.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::49) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH0PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c2e062-8aa4-478c-f08d-08dc7382facb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUNnL3ZKV1gyTW9vNVFDUVdKbjlHQ3ZzYjQvREUyc0I5eTBnK0hsWWtVTEdl?=
 =?utf-8?B?L0gwQkVVUStQYkJ3WmNaR1dWampyVjd3YWxleTBPT1YyKy95OGJrV0owVlhN?=
 =?utf-8?B?VFZqRnZjeVZMay9NMWNlTjBOUTM3N2N3YVRLWm14b3dPRU5mWFRxTGFiRmd0?=
 =?utf-8?B?ZjRQNzV2b1k2eENKYXUvcVRvSEhXZ2o3aWdYc2dFMGlrRUllNEFBbWcvd2J1?=
 =?utf-8?B?RDJDSlo2ODYwbTlwQXNCakl6TzVJMjlSeUlwYWFKOERvb1ZOdUt5aGFKY012?=
 =?utf-8?B?YVQ1dTU4V1ZiaWR6OHV4NEZFNkY2TmZwQmlvWHhuZGJ5cDJXY083UFlrNC9P?=
 =?utf-8?B?Zk1lTWxVTlZDMWlpVG9nUFNUSTBSanc0VUl1eXIxTFcvRDVIaTVWUFFBcHRW?=
 =?utf-8?B?QmxYenhUNXRmSTRsZVJ5c3R5c3hoZGpVWGZIRksvTUdPeXNNWHhLTmFTTjUy?=
 =?utf-8?B?WmV0S3ExOGYrajlZVFpvVXdMLzdHTU5Pb3RsMVdnR2FZcjZTd0dsaE1CanhD?=
 =?utf-8?B?bnVDcGZNd0V6c1NGY1BDYmN1ZVVzMVZ5aFQ5US94MmRSUkh6aFhDaUwzMk4z?=
 =?utf-8?B?N1FIUXl0K00yRG5ZVHdGOVBqTW5OVUNtRkNIL0h1bGlNTWU1czIwem04ZS9N?=
 =?utf-8?B?ekR0WGtsMWZWbllyS1NXdHorai90cnRKZE9yV3F3cVRtaTRMWjA5eDZRNUk4?=
 =?utf-8?B?enNIckZtSDBORnRnelJuRmZaNnNEa0JCWHZTZmFZVFlhZ3ZWOVFLYk13Y1JU?=
 =?utf-8?B?K0Z1dFlocFhxaURpUTRlV2FMZE5STXRreWhyQnNBSFVTK0NsY0l1S3BqTDIr?=
 =?utf-8?B?ZURBc1c3Y0d5TWoyNXRjaVc0YUpWbzA0dmhMdEkzTWNoTFlIYjhTbXVtRzlk?=
 =?utf-8?B?czJ0S1dOMlFRL25Sc0xZQ29nOHVDOEg5aWRaRnFLODdRTkdpM21wMXhkRjRH?=
 =?utf-8?B?Wk9Fd3VhZ2RVUHl5bEk2NXhOT1JBb01xQ243SnRHai9laEdJdnY0RTVGYi9L?=
 =?utf-8?B?TVhtbnkwQXRReGpGcUZSaS9YdnM2MkRpcEU1Tk9MeFViOG1jUnpoY3didWFG?=
 =?utf-8?B?RTFlcEZsbE9WdXBVQVBMMEcyWDMwaFpkQnJjakpjUDNHU21pZlFKTEh4VmRt?=
 =?utf-8?B?VzR6MlNsUXhORFNEY2VrOTNxb2Q3akZkMWFXMmgxTDdhSWRtN0pqMWtDM1V3?=
 =?utf-8?B?YlpaZGFSRFU0dmdWNWNlL0tCUmxxUExRUGdYa2FkQWY4Sjh4NnNjS21UUnpx?=
 =?utf-8?B?T2F2bkg2ZWw2eFVocy9Jc0ZWR0d2aUlSZDYzK3J4UmpsWmMyNVVkZjJtbmN2?=
 =?utf-8?B?dUxlVVRtSWk1ZC9TZ05Bdm9KZWZtUG0xb2JRSGxVMnJtU1JjWDJNUit4OVVW?=
 =?utf-8?B?NC9STTcrSnZqbGNjcDUyT1lTcDdQSmh0OC93WlhQdCtyS2FHaVIxTndNK1R1?=
 =?utf-8?B?NnZ3Tlg4WndkVGZHaEdMaDhWWW1yc0FDR2RzaUVUejB0b0FOVmE0VTRULzYx?=
 =?utf-8?B?NmIvRUhzUEJ1c2FjNThOWDR3bXgzN0llMW82dEROQWc5YkQ2bXZXUkxSUDhW?=
 =?utf-8?B?ZG1BSVZ0TGN3dkFoRFBySkZDMktBRDk4My9MK2FDN1d4ZEgzb2N4VHVsNXcz?=
 =?utf-8?B?UlV4VWpJZHB1aW9Rb0dIWFNjMGY0dVJGR2VaTGdoUC9seE85TUxKT1JsaTFM?=
 =?utf-8?B?Q09Xcndmc2VuV2tDaTJ4WHlYYWd3TkRLdmVXR1Bia3BoYnJRTDJQZXdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW5XNXJncEdDRG4zd2JJSGFwcWlqSDdNU3FlSWQ5WDc1KzhTcE5YM3dYTWh4?=
 =?utf-8?B?dm5SckU3SFFWZnhsOXdXZStnZXBFblZKS1NmR0pXeXdxRHBRY3NTVENHT3pn?=
 =?utf-8?B?MU5hTUNCRzNqbnc3V0l0MG5UVzVqbndzVklQRGFLUEczZkoydXo5Wm5BWU1V?=
 =?utf-8?B?N0pCcjkxRmR2MURtdzhHV2IzUnR6N28yYUg2Q1ZQa1JRY0FHWkpCWWFxdlNx?=
 =?utf-8?B?TDdtNVMzc3d5UlV3L01SNnJuanpwVERmL1ZOOUlyWHVraGhvSVlxMi9zZ3hp?=
 =?utf-8?B?TGt4TDE5Q0NKTXlTTXIrS0RubGZnZFV6UkpIb2xSWEtNR3JmOXBvY1ZUWEpR?=
 =?utf-8?B?MjFBRUoyQVRCOHJ0ZUJaOWpZMnhRUWpNcHVEc3dpWCtCL0wrcC8zaWxNcWZm?=
 =?utf-8?B?U1ZOOTBORlRJMmJpZTE1Zmkva3ZHckNHOGJXWXJ2cWpUVUJ2WTR2dEtMSTlj?=
 =?utf-8?B?bDVMcWFXRFNLS2kyL1lyMHBiWTk2aGhKQjNtK2c4akJER3NlOHFvZ3RtYnY4?=
 =?utf-8?B?SktYb0w3a3lnMkJ4WWNQNS9BdG9DTktSSjhwSWY1Yk1LS3ErdDZ3OTNFMVNB?=
 =?utf-8?B?VWZjS09UK3lzdElheG12bW8zRGJaa0xEcnpZdGZtczZobzR1b0tYa2p1NGwr?=
 =?utf-8?B?eGZ4UTdIa3dpQ2dnZkdzT21LS0JKeDlDQ3MxUVRJUG1KTmx1NFl3WmdCMEl4?=
 =?utf-8?B?cUd5bFUyYU8raHgwMTBMbXVHeE1hL1ZJaXV6d2xITEl2enk2Ni9wMmY2TTJr?=
 =?utf-8?B?SHhUL2dORm9JVjZrekF2OTJWa2w3dXE5dDZ4bUpCbExJVmZYRjhtR01OZ05r?=
 =?utf-8?B?b1ZFREdXU0c4bUcyQkpZbERkMlZiazlET3FuT3Y0UzBjbUV6alRpemJuZU0v?=
 =?utf-8?B?S3J6ZjA2YWxlMXdmanJyNGtMalM5WE5RSVNGbnptZjU5eEZtcEQ5d1F1Mncz?=
 =?utf-8?B?TEx4SFl5cXpudFhSa2NHTlRwRWZ0SW51aTFuV210R0pvNEtTRU55My8yY3Y3?=
 =?utf-8?B?TW5oS2JEaHZIamhsN0R4dHNDRlJacnNhTS9MKzYrUSthZ2QweFhlZ29TdWg0?=
 =?utf-8?B?cTc2bDR4QkQ1UUhSZEw3aWpoVnliQXFaWUJwSjVZNUt0SUNjdGhYTWQyVDBt?=
 =?utf-8?B?SFZadkpIMFllUjN2UVM0aWhiZlBLQm54WEJ0OVo0a2FBZkVXbTVScExqWFI4?=
 =?utf-8?B?WXkrdVJiYkdnenZ2Q00yc1JBU0gzbHIzRFpYUldSbk1ncVg1ZW1QVE1CMUlR?=
 =?utf-8?B?NHRyWnFXb1A0SjcwdHlxZzVMNGpFbHU1SUVhWVYyR2F6aGlmVTNqTUFVMmxn?=
 =?utf-8?B?TzdWblo1MG5yRHZQWERjL2RnZHRDNmNUYzcwODhvQjJ5dVUrT0dYMFRCVkhG?=
 =?utf-8?B?d1B6VGNVemxsdFpucGIyL3hPYitQMFNtU0Y4Mkl0dktUWGZONXlKYk5McEhv?=
 =?utf-8?B?UHU1ajRjOWNWSWx5cUZ3b3A0MzlQanBMc08yNzBlbUFIQ2krR0FMSjlpMzhk?=
 =?utf-8?B?QmhjVCtZVGl6S0phTzBXZEozKzc2K2lKZXFrRzQxV0NJQlBYRkpVOFk2dnpV?=
 =?utf-8?B?ZE9TTnhielE5QU1qcUIrM0xUUUoxSmJVbEdEckwwQ1dwN256SFo2M0VoTEky?=
 =?utf-8?B?K1VCUG5YTGtNRkY1R1lyQUtGSmRuMlBSa0NhblNtN0RCY2wyVjRiTDZzaHl2?=
 =?utf-8?B?Y2VCbEFySGJLb0lmVmMwVDZpbFJaMHpQYU00UVZ3K2Fmc1FNVFpUMHM5MFZG?=
 =?utf-8?B?MzlEY1dScmU4QkZuSTd1VFdNYXJNRzdPOGw4VGJHNkJGd0xyMEcwZ2EyL2sw?=
 =?utf-8?B?UnIrZC9vVURrNWIyMjZHTWxWZDFwVjdvU2FWZHlpUHRnQUNPaVBRdmJhckpa?=
 =?utf-8?B?VW9LTkhnNnFtaG9PMmJ2K2VDUHp0N2trblU4NDNDK29SLzljQ0xWQzZ4M2to?=
 =?utf-8?B?WGRqamEvWjBjcFJCTzV5UmNMblBhb2VnRVFkYWZjeXhGQXltL294UHhmeSs3?=
 =?utf-8?B?eVdZeSt4WEZ0OTVudFFuRnl1MDBmTnhVWC9jR2I0RHJsczJaRHlwTTdwaFFW?=
 =?utf-8?B?UGV6dlZvMmxwb2xYYW11SzFKM3lwZTIwa2FoaWpJKyt6Vk9Ec2QzenRkalox?=
 =?utf-8?B?c3haS09nZzNsWXJ3b2VPK1JvRmZ2UHIzNm1YdVZ5TGt6N0lGaTV1VGRyRXNQ?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nMQjKZv71WK5okQvTe/GYC1nstGC1hUyA26g1HYgVe1wfKrpND9VdrOKVBmlciwVD9vQNzkT+irPANzI/IPzB2J4XYrWPmM9uWbK3sR0GB0IgLdSOyhMoMhR7uAxllf3th8X/k0MWqT2FrOORSohvv0UGUNIC8AJ+r0ekGAcNS0GDuDev28NTLGMi4aPhzR5R+yhNImfeMWDvjDSEttGtjvgU8MrcQBFgg3x//8oE+nFYtXsq8vPpbH60SwLc/K63uBXpl8pE1QwTL3ZbUrf3HhWXTJa3jeEDfa1WL4o7Q+7HMvX590Bi74Lv1ny90qXfzSllMPyQP+nS1alx+7utQ5N9wT8KcM788bTA8UOaPOviUwtYfXq7h5vMVejDxiXpVO1PvGYO/6Lvc+fPUw2V1J0P6fVVn21Vz0vBBliqPStJbNgB4W84DZtqy/nsb2kqWeirkOeBKxq+VI/zQyZR8NTaI9haC9GXaLV+0yUbtBnOKytj+9lXLvrT1sFc25Cr1S2R82cAmbyVHuWywk8V2w8vxy9N9eDIGK/plctbKTHcV1gjoP4bdN79HLhstlEwvzfwJH0fHhH3jvfWv4JAkJV7y6RuOhmexTIAqoF+Qk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c2e062-8aa4-478c-f08d-08dc7382facb
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 19:29:17.1641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMN9MLz3tPorLlDxDfzU5awO/6Dg0uKUXFtIaXsjXh/JPKJjpXsYLQxw5SFhjEsCemwPtLhMwKLDl3223J2ji4h1oMSnf+mom1qKj2zZJRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130132
X-Proofpoint-GUID: y57Tt4Ud_iP_ZxgMear8lkXdf6Dcx1Iu
X-Proofpoint-ORIG-GUID: y57Tt4Ud_iP_ZxgMear8lkXdf6Dcx1Iu
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/9/2024 2:01 PM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Unlike cpr-reboot mode, cpr-exec mode cannot save volatile ram blocks in the
>> migration stream file and recreate them later, because the physical memory for
>> the blocks is pinned and registered for vfio.  Add an exec-mode blocker for
>> volatile ram blocks.
>>
>> Also add a blocker for RAM_GUEST_MEMFD.  Preserving guest_memfd may be
>> sufficient for cpr-exec, but it has not been tested yet.
>>
>> - Steve
> 
> extra text here

Will fix, thanks - steve

>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 

