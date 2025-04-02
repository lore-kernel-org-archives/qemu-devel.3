Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F0DC36017
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzyBn-0007H1-Et; Wed, 02 Apr 2025 09:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzyBP-0007F3-CR
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:31:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzyBI-0005An-3Q
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:31:06 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532DN10R017878;
 Wed, 2 Apr 2025 13:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=2qzlFUM0N8wAFjR7ktsE9CLlotxzUfOaGR8PKyoV/hM=; b=
 KjiUIdwdv5tV3wrGI/8RtJbTPYHNdCVLrsatrAmL8l77MJELp4rk3NEhjYvA4cIb
 vtf/t2/TRKfwqYbB0YEuGwpPd+PZe4kjhPtL7QDOiM5WhwokJA/Iyy/gHdoFo6g/
 GaWaJTe+tyaWrFTEpM/VDgB5PjAFjO4Plqd+bTVLs4DoyE9puOpk6K8lQehf5Juz
 XrYp+J0Ff2t+QXQmLQSDBGEURT+oZZzhdN+lSpQaPykHcikj2aU9ooDLVyNUf3Qw
 5oqCGUreyBI51Ghdcl1/lHtiJq5r9hNfbt1xjG1EPel4bKvJLttyqSjvN6muSFIE
 uEzUf8W8MJaJk/kl04OCjw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8fsarah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Apr 2025 13:30:53 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 532D9GMS010718; Wed, 2 Apr 2025 13:30:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45p7agwn5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Apr 2025 13:30:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eITKmtqHDhRyu54DMg9MT3yLHhWcCfP482R3T7nD/706pnHmTyHmL6iwent3ylzaOsNRnZWXRn5qtBtIcKKvQGxLnheHYmH+VhY2x1/k4Tw54G8Ba0F8r+kwU301sJwg/rE1Z8UO4mQEXUkN3twRsBRIfiuuVsf/AcybF86RZD3frX+Ukd/L1yuXmWak94ZuLS1hn9dFISWGcQaBOCvf4XgNvhpF1lItfaeoiuDNaBCk9f9GL6Bzion/4H/a60PnKk+tG1I1LrkUub7p9+7cwMq9bMNfMTFzJUvqVVvNJrI2r1VZEbHcxDi3K6YQExCQrgQGGDttLLRGQFE8Y55RAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qzlFUM0N8wAFjR7ktsE9CLlotxzUfOaGR8PKyoV/hM=;
 b=AvpitXzkAzo5tuM4ku+xrF4DaHF5jDe5vWW/bV8qvyt2U/ffniMg4PxkKGnIZfRaPjB/mYdMTyyO1CJuvWl5PDz5VcXdgACcmh89oiaA7awsur98WlER588c/Wc7bcapZjUfUOnFqSgV+X9zPbZcp5H2d7g3r4c6xVEruM6FYG92K0Pfx/0nwFEg+pFNLPKqh0nmNNbdrRkgHXKpHgyMtVoNcrSkbsZ/v0Q+0TMWyY+rj7l8PeblzAKZ+QEp8jrB/DT8JdAsl+JrolQqgY2gcdocAOQ+OQ8cvLTGB+ZaC4acYbgTqWi8zpL49G6qbAmCj8po9sGpHo0x+reLh3AEwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qzlFUM0N8wAFjR7ktsE9CLlotxzUfOaGR8PKyoV/hM=;
 b=PGVtaPSuqNd6ax4u7Dsoet7bbpGQJ4S4h9iyE9oj6TbVPi2OZYoW5MPlJWkXF46EjsWO/50wJbUCi7+ex6weROz+Ie+9kLCaC7Wj8Qx+w+1xXN3l8tuQTD3l8e5beWXXxvDC37a0hwGpnKausWDkEjdzmGnPyKy0FnpW5+tT8d0=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CYYPR10MB7673.namprd10.prod.outlook.com (2603:10b6:930:cb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Wed, 2 Apr
 2025 13:30:50 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8583.033; Wed, 2 Apr 2025
 13:30:49 +0000
Message-ID: <de994bfc-e2ec-4e32-a6b4-3881f3027e05@oracle.com>
Date: Wed, 2 Apr 2025 14:30:44 +0100
Subject: Re: [PATCH for-10.1 v2 26/37] vfio: Move dirty tracking related
 services into container-base.c
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-27-clg@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250326075122.1299361-27-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::6) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CYYPR10MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: 407fe8cb-ad68-4adf-48a9-08dd71ea94b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NW1vcWxISDlOWEJ2S2ova1hBeDQ0M2UvZ29IMjU2Rkd6MzQrc1lYRWpQQ3k1?=
 =?utf-8?B?Y0xvS3ZtQVZOcmVTOHltNVJVakJWVXhMcGlXS1FGaHNBZjBEbTNPcGdhTFdM?=
 =?utf-8?B?V2FnMHo3OVFCZXVhL1c3WEhIZDZTQlRlaEp4RXZCU29XclNTM1FDc1d3c3RG?=
 =?utf-8?B?bElJbjZWSlZxNVhSelVVMXZQQjdIdHByVFY4QzNEdWdnTElBeS84a1IwTGZp?=
 =?utf-8?B?SklCbHhNZnB2a0R0ZW5rVDVhTXprSDFUZzJlLzlLcGJLcjgza2g3UWtOY0Iw?=
 =?utf-8?B?RVV5emQ0bTJoZ3dQcW14eHBURDkrM1ptbjI3cms1dk5hQmRSbTREdXUyZGVT?=
 =?utf-8?B?ZDA4c25BZDFCbFNxZlpVMFVNbjg4WnVSZzJuWUlkOFozL2g5WWdEU25XVGY1?=
 =?utf-8?B?UVZobEp6OTVuci85Uk0zTE5xUm9iWGswTW5rZkJsT29wbUFZdjE4QUMvN0lP?=
 =?utf-8?B?dDR2a0o5ZG5aQkkzQlZmREVtSE5hNlJSbUhLQVY1eU95T2VMK3FqL29xTjFU?=
 =?utf-8?B?OHVNbzFRVStwc3NxRC83OGxaZ0l2L083VDMxeFkvTUN0bEt0Ykw2TmR3QVNz?=
 =?utf-8?B?cHpkNWJ6K3pwUHBQSGpDb2VwKzQzVWNoU1NtQTUya3BTR1BicWZLZXFkNnda?=
 =?utf-8?B?ZHUwK2QzWDd1RkxGU2lMWkhUbGdQSzhrN3UzTlZpMHdCdER5VUgyY3QyWFpZ?=
 =?utf-8?B?VHk2VWtuaFAyNlREYkZSR0lKaWt1WXlEdWZybG9QbnBxaHVhTWZxbzJIbE0z?=
 =?utf-8?B?YjV6R3pnZGlVR0g3Skg5dktHTHk3ZS9GanlaU2RURUlTMGduRmNNY2FOU29X?=
 =?utf-8?B?akZnQUpPL0ErakgzbzZ5YkdZQSs2UXRjVVQ0UlBrVnFPT216cmFoVjNjcWtQ?=
 =?utf-8?B?ZmJIcE4rNDBVYjRaVXc5SnNwRG1IODhKZEo5YlVGUWJjbStPWURHVFZUckkw?=
 =?utf-8?B?Zy95Rm5CRHB4L055SWxBeWJTek45bFAyNjRsS3hESmJublFBaTFpQktZVWVS?=
 =?utf-8?B?bDdLaVpzckZiSCtMaFZNRzNIVjg5S2lRSkk1c3ZZVmZVTHBhakgrTGEzZnli?=
 =?utf-8?B?VTh0NG9BQlIwb3pDbldXZm1WajBmUm5ESldMSU5ua1Znc2krMEwwU1FpUVgw?=
 =?utf-8?B?K2lzVVdDK0dEZThjNkN6ZXNtR3YyKzhJblU5dnZZM1VwblRlU3R1UWh4TE5K?=
 =?utf-8?B?QngrUDI5RzBodWk0V1hydTgwSXhud2ZnY3V5eDQvUTZCdWVNK0ZubVp6b0h4?=
 =?utf-8?B?VStpYm9pYXhOWTZIS0E2WktyeHRuTVFiMUY5MENHVTcrbWszQXJLMHZMYWVh?=
 =?utf-8?B?T2FqdDF6MXBMRzM4NlBWd28zZUNhK0NUZzVPb2ozU0d5K2ZZUGFYZTVPYUJ3?=
 =?utf-8?B?YXhubE1VN2FLekgzcHgvR2xVYW4ra1RkUHdNVEhnUGhzaW9US0RIcU9qMEJr?=
 =?utf-8?B?c0hhbmpDOFp0RG1kZ3UxMmdtQ0NaeUl4dnhDZkZ6QVpid0JPczg5Q1Y1WVda?=
 =?utf-8?B?NEZ2bUtGTVUyVUp3cWZYYkZKVUJSVy9tbHRmelR5Y3lPYnloN1ZzbGRTbGZK?=
 =?utf-8?B?aDEyd3NaK01GUmdmRVpPMWRkYnQ2VWVHMURuVVBSZStLajFPMiszY2JGdFJN?=
 =?utf-8?B?RTVnTG0ySFMxMWd2MmVEZ1dZWGlOUG5iWmFtL1AxY0FVdEp6TnppRm5xVExK?=
 =?utf-8?B?VDA0MW5OUk9hYURNQk95NmtDUHM0aUJMYW4wRmF2QzA0T3pMVzQyM2tsR0pH?=
 =?utf-8?B?MmJrYzdQMDJaMEZjTmxxYmU2bng2QkpFWEt2OHhqeGwwK3VlTDNXU0xKb3Yr?=
 =?utf-8?B?YzRQZmhUS3Fqc0lxZTc2aWl1amt4NVBJSGo2QUVramVEeEVDclR5UWxVNHl0?=
 =?utf-8?Q?rDvQ3rOquHR5m?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWd1dWovV2dKdTlQVElIeDJ4Qi80L2hveXRmUnM0MHByeXJ4OUh2cEVUZ0NH?=
 =?utf-8?B?cE55M0ROMXJFTEpHNWc0bkJxckFURERGZkpBT29sWTFrdUp3bGdUbllYc2oz?=
 =?utf-8?B?SjhLTEZHM2lNcm44TzFDL0k3VnJyT1lZWDVINmZXWU9OUkpENmVWekMyejY2?=
 =?utf-8?B?cEFqVXJlSDRwci9jZ1NBKzd6dVd6RGo4eE9sUURwc2l2TzJOSWZkaEpaWWJL?=
 =?utf-8?B?cE42SUFtRmJzQlViVkR3d0ZWZGhKMU9kbFRTUkZaTUVDTE1aZGxnUEREN01G?=
 =?utf-8?B?b014YlBuZXJ1SjZVU21reUwwenZObnpUMDNDS2xuQnRRM2JrQkwxcVZuUnZB?=
 =?utf-8?B?TG81TWN0L0VZQmdOdFQ2UEZ0NmhTdG43T1c2T3pxKzRET2RoQlNUa1UrQmlN?=
 =?utf-8?B?R3U2dm5tZ3dBWG1meThaT2hHbTFCZTFHRjR2UjRMZnErampQdG1UMy9peHRM?=
 =?utf-8?B?UmRaOW45d3pnNUx2eHV2Y2t2U0wvWWx6QWp3elpVTUpCZU9jSVgvRE0zOExG?=
 =?utf-8?B?a2JOVWtsQUhNYm45QnZkam12Q1VIbjRhYkV2b3d0cGEyZmhCNU5YYkxBWmEy?=
 =?utf-8?B?V0U4cHVaVXA4elZzbXo2NC9QUmZzRmVURG9pOFFsUFJDcTNOVGVqb3ZqTTN6?=
 =?utf-8?B?Lyt3K0NCOVBZWUlIZUZGeWlOdE9ab0cySGUvYUpuWHZ2TjJMNThuSWF5OFFn?=
 =?utf-8?B?dWFueUt6NjRubFpGdDc1WWZEMFR0SStaNFFmYlkzYlFEcmlXelRpRVYzWGs1?=
 =?utf-8?B?WVBXMkdlOHJjY0dZbmMybWxEWG9lcmtMN05XQlgrSE5paGRYNG9XYnlJWWFF?=
 =?utf-8?B?RnE2STVObXo5V1BJV2FqbVBsMmxBOUd3TU9qWkFsUjJJSVlLWUl3eFlhUmN3?=
 =?utf-8?B?YkRKRmV0L3RDdE10UENzWURFMWV5SHg3UHAxK0VnTEZQUmZjRXJKTWY5Z0I4?=
 =?utf-8?B?LzhOcVcwSWVWZFYwNkhVTjJQcXpCeUVFU1Zud0tvMHhXZDFmUTkrZUU5aElE?=
 =?utf-8?B?TFlvMDZXbUMwZTB2Nk4xMHRtUlFyOFhJSzB3cThNWnI5OG9rdHljQjlIdU4v?=
 =?utf-8?B?RWEra2NXVjFqWkdqeGNtL2hmMkExR0h6bEhHNWxyZVZMNFl5ODcram42MVRn?=
 =?utf-8?B?bHI2MXZVa2ZZSHo0dWJLK2dYbWN5NURlOUpCbjBoVEtrM3JJSHpkbVlIWCtT?=
 =?utf-8?B?c2JzeWhSSDlsOGg1OGsxTHU1amg1UklEM3V0enVKcitzcGlDbTB6cGYzOGQr?=
 =?utf-8?B?bk85dDdNMlNhU3NzZ1dxeC8rR2tkQlhCQjZ6TndhQjc1bUJsSFkzSVRMOUp3?=
 =?utf-8?B?QWMvUlFEWFVLdUkrc1N1ckVWMmxBNXVtNENzNWFrRVVONEpTeWpQeXd1Z3kx?=
 =?utf-8?B?UnNPM3JlckNwQk9wWTlkWmFsWEdwODhLYzhBM3hyenJjME9qZGlOeU1kNWVU?=
 =?utf-8?B?dTRXY1JLajhhbFhweVgxTHV2UWllQ08rUE5URFBTZ1IwWGgxOVRFajNKSzM1?=
 =?utf-8?B?UWJ6SkpUdVBaTkkvVm15aUlDS1g5SnE1cytTcy9iOWVTazNpOFNiN1ZnVk0x?=
 =?utf-8?B?RjE5ME1XWGR2QUhQTi9yNUV2bVNwOFdWNTI0QVRFclpzbkptTmtOcWNmYjMv?=
 =?utf-8?B?SlI4VmUvVjhlZWJRWU8za1FuNUtqWnZyc2NIRy9SamhpMkFZRlVkRFhvMlRr?=
 =?utf-8?B?bTlKalVvaktmdWROaGZ6WHNGKzRwYmlQWDQ0SURIZFRjUW1HRUZhbU53TC9G?=
 =?utf-8?B?ZWFrNnhKMnU2NnVQS21LOW9jQ2xiTm1lc09yNkNJVjQvSzY3VUhRR1NUZ0FJ?=
 =?utf-8?B?STA3OURiR1ZYSUNLOFl5eGx2bldyUnZWRnlvaFRScmlVZlZnS1I1OVpmLzZo?=
 =?utf-8?B?V3FjSnZlL1EvZ1RWRERueWtFZmptRVdpd1JrVGUzL2RSdlVwaERtKzltbmEy?=
 =?utf-8?B?Qk5rbktNYTBsdHhuTStFeDZFZCttTm5nVGZxd0k4T0lsekczZjFZQjZFd2dw?=
 =?utf-8?B?WXRwMnByQkdXRk14dUNxL1k3b1cwNEZnaVlBN0FaZmx1U1FKWHNrcjVwYk5C?=
 =?utf-8?B?SkVhT2ZWMDc5VEFzTkZHZDBkQkY4Vmk0dmo5RG5mYUhFRnV0TGc2MW16VUpt?=
 =?utf-8?B?RWpGalRRSUkwYm5mZ0tKMmt5Wm5FbnB1a0pCRzduVjFPUEhWcGZGbHFIUXdl?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uQbAkpbQdqk/guVfuMYGFKEAuCdEAyyOVeTiih2FXQtjjw8pA9gs9SIrGMPbjUenOWxYUEx1r2k9lSiO9ENU3JwZujnZd3R+IW7NJ0MhkputBpwRTISujen+af42KePAtFLey13BjQZ8FSMJYb9s/O557BBznPnHis6PtoiCOzZMt/53a/b89pNaEa4HhFnwVSuzU6Q/N+OMvcg1Oy7KqcKqdR6gJ0n8WwkhzpcvwmR4Go+HolGCdtEaAwdCvUY5b5M6oyOwF8qpplaI7XQa8zl9vg1pCZSG1tmLhjEaC12pFytkqxKEjxDBqeztc4ecmEBV1bYK4fPrEnvLbqRdcjhu8bkBzzGLkEgkQPuuoKh3bZ024NlHBjuBWb1KlMj6+5J3cMiQBAfsvnt6bT0QDNkWO/uXvoKjgrjIxpDoLlsX2+YfXPzg7Szo0AT9bZZsnHv0QHsqteCjysCg1SPqLdB4j1aoWNiX2RmibYzdqDbF+hX9kbZeMGRcJVFylSljuNTV80KJn22r2TqtnpozZpOc7nM3WqasDLSbanC9u7ppzCHtweCf0yxLcmxM6NGvdzSXf9N86Kp/eZumJYaDmU5BdeAtrlHhO/Ux8WQ2NMY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407fe8cb-ad68-4adf-48a9-08dd71ea94b4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 13:30:49.2654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xkc81iXZBHvdb89prqx9wFtFqSHcaMcCC+5Us9eYx6JXhGSKbLokFiCJuHyKM9Pv/DtdhjJVcIPfXSDK214xG8r1ll0VFNk2tsfa6LZhdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7673
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504020085
X-Proofpoint-ORIG-GUID: WcglpVHenInXWWZpgEf-3ePpAaN0gT8d
X-Proofpoint-GUID: WcglpVHenInXWWZpgEf-3ePpAaN0gT8d
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.01,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 26/03/2025 07:51, Cédric Le Goater wrote:
> Routines of common.c :
> 
>  vfio_devices_all_dirty_tracking_started
>  vfio_devices_all_device_dirty_tracking
>  vfio_devices_query_dirty_bitmap
>  vfio_get_dirty_bitmap
> 
> are all related to dirty page tracking directly at the container level
> or at the container device level. Naming is a bit confusing. We will
> propose new names in the following changes.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  include/hw/vfio/vfio-common.h         |   9 --
>  include/hw/vfio/vfio-container-base.h |   7 ++
>  hw/vfio/common.c                      | 130 ------------------------
>  hw/vfio/container-base.c              | 138 ++++++++++++++++++++++++++
>  hw/vfio/meson.build                   |   2 +-
>  hw/vfio/trace-events                  |   4 +-
>  6 files changed, 149 insertions(+), 141 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 8b300e7768fb61af881f6a8b7eeb75dc84c98ac3..a804af9f651f0916ca06b3f4f009381eea385ba0 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -141,15 +141,6 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
>  bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type);
>  #endif
>  
> -bool vfio_devices_all_dirty_tracking_started(
> -    const VFIOContainerBase *bcontainer);
> -bool
> -vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
> -int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> -                VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> -                          uint64_t size, ram_addr_t ram_addr, Error **errp);
> -
>  /* Returns 0 on success, or a negative errno. */
>  bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>  void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index b33231b94013e0b535b77887109a97f9128f1c15..8575cdcb587dfe803808d452c7dc6c81241a47cf 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -91,6 +91,13 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
>                                             bool start, Error **errp);
>  int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                     VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
> +bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer);
> +bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
> +int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> +                                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
> +                                    Error **errp);
> +int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> +                          uint64_t size, ram_addr_t ram_addr, Error **errp);
>  
>  GList *vfio_container_get_iova_ranges(const VFIOContainerBase *bcontainer);
>  
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index e62bb3818c55a789e81fe50cebf7c6693228db31..85dedcbe5933c55c6fc25015d3701aba43b381a4 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -52,27 +52,6 @@
>   */
>  
>  
> -static bool vfio_devices_all_device_dirty_tracking_started(
> -    const VFIOContainerBase *bcontainer)
> -{
> -    VFIODevice *vbasedev;
> -
> -    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
> -        if (!vbasedev->dirty_tracking) {
> -            return false;
> -        }
> -    }
> -
> -    return true;
> -}
> -
> -bool vfio_devices_all_dirty_tracking_started(
> -    const VFIOContainerBase *bcontainer)
> -{
> -    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
> -           bcontainer->dirty_pages_started;
> -}
> -
>  static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
>  {
>      VFIODevice *vbasedev;
> @@ -97,22 +76,6 @@ static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
>      return true;
>  }
>  
> -bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
> -{
> -    VFIODevice *vbasedev;
> -
> -    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
> -        if (vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) {
> -            return false;
> -        }
> -        if (!vbasedev->dirty_pages_supported) {
> -            return false;
> -        }
> -    }
> -
> -    return true;
> -}
> -
>  static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>  {
>      return (!memory_region_is_ram(section->mr) &&
> @@ -1010,99 +973,6 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
>      }
>  }
>  
> -static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
> -                                          hwaddr size, void *bitmap)
> -{
> -    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
> -                        sizeof(struct vfio_device_feature_dma_logging_report),
> -                        sizeof(uint64_t))] = {};
> -    struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
> -    struct vfio_device_feature_dma_logging_report *report =
> -        (struct vfio_device_feature_dma_logging_report *)feature->data;
> -
> -    report->iova = iova;
> -    report->length = size;
> -    report->page_size = qemu_real_host_page_size();
> -    report->bitmap = (uintptr_t)bitmap;
> -
> -    feature->argsz = sizeof(buf);
> -    feature->flags = VFIO_DEVICE_FEATURE_GET |
> -                     VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT;
> -
> -    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> -        return -errno;
> -    }
> -
> -    return 0;
> -}
> -
> -int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> -                 VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
> -{
> -    VFIODevice *vbasedev;
> -    int ret;
> -
> -    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
> -        ret = vfio_device_dma_logging_report(vbasedev, iova, size,
> -                                             vbmap->bitmap);
> -        if (ret) {
> -            error_setg_errno(errp, -ret,
> -                             "%s: Failed to get DMA logging report, iova: "
> -                             "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx,
> -                             vbasedev->name, iova, size);
> -
> -            return ret;
> -        }
> -    }
> -
> -    return 0;
> -}
> -
> -int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> -                          uint64_t size, ram_addr_t ram_addr, Error **errp)
> -{
> -    bool all_device_dirty_tracking =
> -        vfio_devices_all_device_dirty_tracking(bcontainer);
> -    uint64_t dirty_pages;
> -    VFIOBitmap vbmap;
> -    int ret;
> -
> -    if (!bcontainer->dirty_pages_supported && !all_device_dirty_tracking) {
> -        cpu_physical_memory_set_dirty_range(ram_addr, size,
> -                                            tcg_enabled() ? DIRTY_CLIENTS_ALL :
> -                                            DIRTY_CLIENTS_NOCODE);
> -        return 0;
> -    }
> -
> -    ret = vfio_bitmap_alloc(&vbmap, size);
> -    if (ret) {
> -        error_setg_errno(errp, -ret,
> -                         "Failed to allocate dirty tracking bitmap");
> -        return ret;
> -    }
> -
> -    if (all_device_dirty_tracking) {
> -        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> -                                              errp);
> -    } else {
> -        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> -                                                errp);
> -    }
> -
> -    if (ret) {
> -        goto out;
> -    }
> -
> -    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
> -                                                         vbmap.pages);
> -
> -    trace_vfio_get_dirty_bitmap(iova, size, vbmap.size, ram_addr, dirty_pages);
> -out:
> -    g_free(vbmap.bitmap);
> -
> -    return ret;
> -}
> -
>  typedef struct {
>      IOMMUNotifier n;
>      VFIOGuestIOMMU *giommu;
> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
> index 2c2d8329e3cf0f21386cb0896dd366c8d0ccdb60..2844c5325efffade43022bfb517a43ac372c4125 100644
> --- a/hw/vfio/container-base.c
> +++ b/hw/vfio/container-base.c
> @@ -10,12 +10,20 @@
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
> +#include <sys/ioctl.h>
> +#include <linux/vfio.h>
> +
> +#include "system/tcg.h"
>  #include "qemu/osdep.h"
> +#include "exec/ram_addr.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "hw/vfio/vfio-container-base.h"
>  #include "hw/vfio/vfio-common.h" /* vfio_reset_handler */
>  #include "system/reset.h"
> +#include "vfio-helpers.h"
> +
> +#include "trace.h"
>  
>  static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
>      QLIST_HEAD_INITIALIZER(vfio_address_spaces);
> @@ -143,6 +151,136 @@ int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>                                                 errp);
>  }
>  
> +static bool vfio_devices_all_device_dirty_tracking_started(
> +    const VFIOContainerBase *bcontainer)
> +{
> +    VFIODevice *vbasedev;
> +
> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
> +        if (!vbasedev->dirty_tracking) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +bool vfio_devices_all_dirty_tracking_started(
> +    const VFIOContainerBase *bcontainer)
> +{
> +    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
> +           bcontainer->dirty_pages_started;
> +}
> +
> +bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
> +{
> +    VFIODevice *vbasedev;
> +
> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
> +        if (vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) {
> +            return false;
> +        }
> +        if (!vbasedev->dirty_pages_supported) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
> +                                          hwaddr size, void *bitmap)
> +{
> +    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
> +                        sizeof(struct vfio_device_feature_dma_logging_report),
> +                        sizeof(uint64_t))] = {};
> +    struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
> +    struct vfio_device_feature_dma_logging_report *report =
> +        (struct vfio_device_feature_dma_logging_report *)feature->data;
> +
> +    report->iova = iova;
> +    report->length = size;
> +    report->page_size = qemu_real_host_page_size();
> +    report->bitmap = (uintptr_t)bitmap;
> +
> +    feature->argsz = sizeof(buf);
> +    feature->flags = VFIO_DEVICE_FEATURE_GET |
> +                     VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT;
> +
> +    if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> +        return -errno;
> +    }
> +
> +    return 0;
> +}
> +
> +int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> +                 VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
> +{
> +    VFIODevice *vbasedev;
> +    int ret;
> +
> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
> +        ret = vfio_device_dma_logging_report(vbasedev, iova, size,
> +                                             vbmap->bitmap);
> +        if (ret) {
> +            error_setg_errno(errp, -ret,
> +                             "%s: Failed to get DMA logging report, iova: "
> +                             "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx,
> +                             vbasedev->name, iova, size);
> +
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
> +                          uint64_t size, ram_addr_t ram_addr, Error **errp)
> +{
> +    bool all_device_dirty_tracking =
> +        vfio_devices_all_device_dirty_tracking(bcontainer);
> +    uint64_t dirty_pages;
> +    VFIOBitmap vbmap;
> +    int ret;
> +
> +    if (!bcontainer->dirty_pages_supported && !all_device_dirty_tracking) {
> +        cpu_physical_memory_set_dirty_range(ram_addr, size,
> +                                            tcg_enabled() ? DIRTY_CLIENTS_ALL :
> +                                            DIRTY_CLIENTS_NOCODE);
> +        return 0;
> +    }
> +
> +    ret = vfio_bitmap_alloc(&vbmap, size);
> +    if (ret) {
> +        error_setg_errno(errp, -ret,
> +                         "Failed to allocate dirty tracking bitmap");
> +        return ret;
> +    }
> +
> +    if (all_device_dirty_tracking) {
> +        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> +                                              errp);
> +    } else {
> +        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
> +                                                errp);
> +    }
> +
> +    if (ret) {
> +        goto out;
> +    }
> +
> +    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
> +                                                         vbmap.pages);
> +
> +    trace_vfio_get_dirty_bitmap(iova, size, vbmap.size, ram_addr, dirty_pages);
> +out:
> +    g_free(vbmap.bitmap);
> +
> +    return ret;
> +}
> +
>  static gpointer copy_iova_range(gconstpointer src, gpointer data)
>  {
>       Range *source = (Range *)src;
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 1f89bd28c13dea55bcfff476ce99d51b453d8533..9c8a989db2d4578e97d864c5fd8bcba125eab66a 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -1,6 +1,7 @@
>  vfio_ss = ss.source_set()
>  vfio_ss.add(files(
>    'common.c',
> +  'container-base.c',
>    'container.c',
>    'helpers.c',
>  ))
> @@ -19,7 +20,6 @@ specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
>  system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
>  system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
>  system_ss.add(when: 'CONFIG_VFIO', if_true: files(
> -  'container-base.c',
>    'cpr.c',
>    'device.c',
>    'migration.c',
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 9fee7df8764978723f79dc60d3dc796777278858..d4cd09cb0f93485fe06984346f6ac927603c5745 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -106,9 +106,11 @@ vfio_put_group(int fd) "close group->fd=%d"
>  vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
>  vfio_put_base_device(int fd) "close vdev->fd=%d"
>  vfio_legacy_dma_unmap_overflow_workaround(void) ""
> -vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>  vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>  
> +# container-base.c
> +vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
> +
>  # region.c
>  vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
>  vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64


