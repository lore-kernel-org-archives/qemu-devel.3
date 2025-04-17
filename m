Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF46C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5UCz-000747-IM; Thu, 17 Apr 2025 14:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UCw-0006k6-87
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:43:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UCu-0003DF-D8
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:43:29 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGMqMd027583;
 Thu, 17 Apr 2025 18:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=4gXx0qhchy/ed3+zNSEyGFcNbScWSBOhnVsCAWHrefQ=; b=
 eXUexVWGToRMLmHtpUg2esBNgPAo0PxSbHuhpMKtq+t7ozjfLI6mvKYr8Y70XUUj
 6zt0GgnUU1O8E7r8V3yUw3Vv0o5yt8Tghv8HQUg1HLb/f9iCX8Fr6XYMZLhAB876
 2I8hdaO/Ql2w+xzSuxfNzEJv8DK5tqwv9XbVcLqLzCqCwzU2sDOi+sASC1+SRWHD
 FEZmWJk8f/c4ISqduhEuyWwlAXcnVJgoRmgW30uKZchT4qBNQxXr7NipOASbcAcL
 lJ5ZwMTU0HegZf/uOsfMX7XS7pszFIboHc+JO7ZkxIxlqgopUl41EWaUA9ocw9dE
 OB8LfZkHMdpMzqaTRI6Uig==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4617juf5nm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:43:19 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53HGxlLr024657; Thu, 17 Apr 2025 18:43:18 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazlp17011024.outbound.protection.outlook.com
 [40.93.14.24])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d53wak0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:43:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tew01SoaSCf5aAdx5pTf8s7izEPiFhWOZdeBzYB6lweDAEb/3FFjCS3MJXqNxELOAYPnEpapEUS+aTM6Oa8LG3ZFeeg8beQaCIJoMMHkmOlMWyYimbCf8Mmcwl44bTSv0Co4IUsA63O1l+vc32LhNKSt0B0U+doz1Ir98fwbfXYLbe1H7oOf+FHsnZzMf6dq5wk4B8yYqcQzsJK2QM961ouT4p0G2bnLXIlFnTYxDlUgy3PslXwxDzzQAD3DHZM2lxzx56VcWZBv1ES9UPDyFndOEX+Mv2Ue/qT43WkHsNqD/cStp5FDwJt6jCDMKoagoN50/XNKwApaO2x2W2okIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gXx0qhchy/ed3+zNSEyGFcNbScWSBOhnVsCAWHrefQ=;
 b=Mu+4heCsdbztC/61Hns9T0CDBmy8URO3al3hddVfpLdddWjYLrQqrV4RW/6UJBzDp7JbNzrorM5LXkcSknNC1NEg63swyg0juecXgQ0Pfs9HlyMHxCqdcfYwUc1Nh0r+G6Yy8fO5/wQ8hC+YBQszohH0eIhih+yQ53ZWBeN/9m3M27BN720mn6/ikwPXnEYjh2jEVeP610dcEP1nWlVCU8toUix2AL0PpyQqiwfBzsde95xVKWKAfEdXb6bpNyjMT/HPA86n2Um9QtlxDClmrD9nz/bLrlAIwbSfW1oFKHsaRlTHLgyKG56wHZ+vJ7SreXxcj+bV9kcZBd9M2quyCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gXx0qhchy/ed3+zNSEyGFcNbScWSBOhnVsCAWHrefQ=;
 b=ljXeTgLx7Ku4VHFlDZotxOgtJuLjq1W1aN8kKx1Zly/foH0e1pjuGfK8WhJCeC/cXOgPk1M/4cAIk24jmH6oyJGNrMHihGOhWgP/W2cR2W9alYfJ1aP49JOEv4REy7K63Kpsm0BIGPfc7ldrNm9IbWRdeoNEDNxtTP0y074Y93g=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by DS4PPF9FE99AC64.namprd10.prod.outlook.com (2603:10b6:f:fc00::d38)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Thu, 17 Apr
 2025 18:43:02 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 18:43:01 +0000
Message-ID: <e8d3573a-46b4-4317-bc05-44643409130e@oracle.com>
Date: Thu, 17 Apr 2025 14:42:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 03/13] acpi: Support Control Method sleep button
 for x86
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, philmd@linaro.org,
 zhao1.liu@intel.com, Jonathan.Cameron@huawei.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411203406.2930-1-annie.li@oracle.com>
 <326d52e6-c0ce-4f22-ade0-6f0bbbe3717b@linaro.org>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <326d52e6-c0ce-4f22-ade0-6f0bbbe3717b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0458.namprd03.prod.outlook.com
 (2603:10b6:408:139::13) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|DS4PPF9FE99AC64:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b07879-1315-4b09-b971-08dd7ddfae92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnVaeGpsdit3OS83SzR1R2JRQmVpdThJSVFCWFFsajdiM0tiK0J2TE45V0Ny?=
 =?utf-8?B?cEt1QW56TnNsbHNTT3ZtMFBpY0t3YldINUJHeTVTbTJsMTVMd0U4WUdiQUdz?=
 =?utf-8?B?ZEZDSUoyU0Q0RU1UK3IrYkdBa1M0aDMyQ2ZpS1lUL1dmQVZjWFp1azk4R1hK?=
 =?utf-8?B?S21MREZrZXEvSEtjQU43WWt2VktmZU1tdTg3MHg2Tm5TSzBSVGJHZllmZHdt?=
 =?utf-8?B?d2oyYURSVjdRVmdNcGhEZzZ1WC9iNkw2TjlCYnRDUU14MnlYSUdCZVlnRjdp?=
 =?utf-8?B?WFBKeHhRZG1iNVBYd0FjVzJTcGp1d25wcWRsK2pGemxZMkk3SXVjTWEydTJ0?=
 =?utf-8?B?SUt1TGh3TzRNblFadnZGR3B4aTZMVzBXUlhyY2lvT2pTZVN5aUUvcS9yR21y?=
 =?utf-8?B?bTVUVGtCKzVnQk1CaG1jSHlhdktPenlQdXE1WkxkTnBxY1lyY2VhM2NDY1Js?=
 =?utf-8?B?V3JmdGpiMHpSaksvd3FmRXJ6S3NtNWsvdFNORzFpWk5HdmxwTTkrWWw0anAx?=
 =?utf-8?B?bnUxZWZoOEsvaW9rQUNKcUJTSm9Qb1FyYXdFeU00bXZqYklYWUR0eHNiVTZ4?=
 =?utf-8?B?dnZJWDVGT2hmQkVtbWhxN2tXZnpoRkpYUEF6UEtiVUZub2RDSTZSUG83OFhz?=
 =?utf-8?B?YW1aRWR5QUV1eW5obkN6WE5mMUlEZ2ZtQmlhQXJuRWxxbGo5VTllWTVkdHNH?=
 =?utf-8?B?ZTl4cUtiZTN2Q3EyRU9GY0VBQ3cwMURTTmNDazcvcUJrUE4yTksvR1lCa1l6?=
 =?utf-8?B?ZGtQYjU4RTNnU0Vicys0b283YmhLSUVTVGdTSWttSkNQc1RJVGtDZ3FaL0ZH?=
 =?utf-8?B?Ukk5UURxS2szTUNnSXBmR3pNUW4rMWt5U243dnZidWRXZ2VlQkNDSWNZM0p1?=
 =?utf-8?B?bHJ1WTduTkJTT3VKaDZOcncyVXNSVzQ4VW5zRUhsZ04xQklpaW5pQUk2bHI0?=
 =?utf-8?B?Y294MjBZSSs3bG90VnVXQ2ZFS2FqNmgrc1NJY0ltdmZKM1RSYlliQzNSNDU5?=
 =?utf-8?B?V0U0ekUrZzZTWjlQM1g0NW1NS1djQWNjVmhuR1NsUjNTZFNTVHQ0TVlSTmMw?=
 =?utf-8?B?QVppa2ZiM0xGNGxTaXhvNEc4alpUQUlmVUk1N0hqODlWVnl6cXhIZGtmNzNL?=
 =?utf-8?B?YkNMdjA3Q1VsUHRROXhaSWhhNUxIUFZaU3JWbWJaOERlZ2taMDMydktxZE1a?=
 =?utf-8?B?RHFzSnlqRXI5b0JiNnZGWXVUdFRnZDdYNVNTMURxbHVIRjZtWlZNcnZmcHZ1?=
 =?utf-8?B?U1RlejB3U0NySEh5eGUzVnRtTk1Ya2F5MDA2eW1iRStpUi9wbXBSTUUzRlRI?=
 =?utf-8?B?dlM5R1NNS25LQkVmUEhaUVBUVGRNajdYY0RnQUZGb2RyR0t1NHNSZXdIWGJk?=
 =?utf-8?B?TzdDYkYvME4yL2xxL1FjSG1pMkNseEFrejRWdTFreUo5Y1d4WFFYWExlS0Mw?=
 =?utf-8?B?TGlTUm9lNmQvbTVPUGFGOEFodGg1TnMwNWJxdnVTNmUrS00xdTJoNVU4ZEky?=
 =?utf-8?B?c3l0Ynk2M0MvbHI0YTFTdCtvclU2TFNvNzY5cENlaHpTUW45V01VZTVtbE1T?=
 =?utf-8?B?dm80a1B6OGlic1VXa01RTjB6SVB1azNOQk5TNE9lb0ZoNXBPcUpraGptMitS?=
 =?utf-8?B?eFRGWDBuamdOVWxESGZ0YXB5RFlaWG42QWJRQzgwdG9kTGg5cm1PU01LRTE4?=
 =?utf-8?B?V0pkK0MxK1Zkek9aeEN4bzgyR0NMaE5pZytLYkQwdVVoakdsemg1OW9vbGZ1?=
 =?utf-8?B?UjdIaWtGMGJmeHNZTVJ3M08xV3kramJjY3MraVZrYzNUSHQ1M2Z2VXNOWHdS?=
 =?utf-8?B?OXlkc3h5V0ZTQSt6S01lNXNLRysxWUlWaXF2N2hlczJJNmhPSjQ4WWMvdzRI?=
 =?utf-8?B?TUFBSHZRNEVXbWwzVFdPS1E3RDVqSENicEFNY243QWx6eDRVRGVxNytLNWh4?=
 =?utf-8?Q?+7Tlg9dmqlM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmh5V3Y2eVp4V0NLRW1heVhBWnJtVGtiNUQ1ZlAyUkcyY2xoUXhuc0tmNldK?=
 =?utf-8?B?dmkyYTZKTmo3VEoveTlpOGNXdWl6NDY3MmM0N0l4NUhpSlZsUjJSdlZiTHgr?=
 =?utf-8?B?VlFkY3d6a2w3OHpnOUFVRGQ1VUUzdzZRNzZlQzFGa1MxaFhucERhTVVzUW8r?=
 =?utf-8?B?VjU3dWh4cERXWC9SdTZWS05OemRoZVAyNml4NlBkd04zRVVBVC9qSm1mV0xI?=
 =?utf-8?B?ZmlJZFlYTi9rTloyOG9iSVhDR3hrVTN6S0VsOGpCQXltNnRYWHZCQkxRZWZU?=
 =?utf-8?B?ZnM3YldLQlk2c1JpNjJLcG5ZaGFxY1FXU3NZNE9xMFBJdGVta0lZNE1kQkRp?=
 =?utf-8?B?S0dDbmFFaVdIWUhQR3FhWDJOeXdjaWRlbVY2RW5vazduN3BXVjE1d1drcXJ6?=
 =?utf-8?B?ejlCSU9OWUx1N0xYQ0pzS2lwS2lOVi9QWUQwalAvNFNtNlZPbjZYQ3oyY01v?=
 =?utf-8?B?Q1FUUXIwckd3ejl1T08wcWU3aW9oV3o3cG5neTVMaEpQNWVpYS9qTHFwb3o4?=
 =?utf-8?B?eGxka0JrSVV6Q2V2bXl2K2hlbFhpbXFRdDdrWFBsYzdoTHpKbytnOHNQMjg3?=
 =?utf-8?B?WTI2WWNwVW9QTmNSQ09RY3ptM0t6VDBuMVF2bEttV1V5L0MvVHJEWmtmVVhG?=
 =?utf-8?B?RmdCanFHUDlKTWZNRiswQitGSGxyREpFWGhiRnhqL3oxVVF6UGJydW5WUlp4?=
 =?utf-8?B?dVdOdlZEZnE4STVDaXV6bXdrNmlCZUxMSVRUOGJQbXhsZGsvNWx6ekJjLzh4?=
 =?utf-8?B?VkJ1eG5NLzIybklxUm5UdDMwRWowSUYzNmg1dkdYVzk5ZUowWHpnNm1ETFI0?=
 =?utf-8?B?WnJRcXZvNE9zaWJYYWUyNXFOMHlYS0lYZzR1Wk9hY3FmNmZRWTdRUU1ZSFNU?=
 =?utf-8?B?d2JmbGVwazRPb0ZtcUdpSDlRSmR5RGgrVnpaeGkrNWxIZ0U0NGdjM29iOXNs?=
 =?utf-8?B?NXgwU0RBUGJpeDhMUlNXNTNRSUF5cmVTTTZnOGhlWFVWT2ZFbXZzb1MvdUFo?=
 =?utf-8?B?T3JzVm9TZzF2WFNIMkpjejJ0NHg1eWw5bE5ZeGpOVHR6M0pISnR1QjloRUFQ?=
 =?utf-8?B?NkIxd08rY2R0Umg2eC9KQUljdnRxeFNSWk1zdWVYd2tGSXR5NWFiMUlQNnpp?=
 =?utf-8?B?dVdpUHN0Z1NEOTZqS0Mxcm1uNmtwc0JjQlBaTXN5cUpKa0FsYktHRmNBanpO?=
 =?utf-8?B?bGdaTFRPTDB1R1JOc3cxMFFBdllwT2JuZll2YWNlbGd4b1MrUnBIK0VTUjVm?=
 =?utf-8?B?dTQzZi9aWHhXMXFpZ2Y1TWhnTVBQc2NxT3dWd1luMDU3MTVmTnNrSThNVVRZ?=
 =?utf-8?B?ZHBrd1ZTMmJmQSthV3YrcGRKdXl1bFZkY3I4MW5SMmlOanBLQWF0WGt2SDE1?=
 =?utf-8?B?VmhUMVFWQlN1NmFHV3ZiS3VGQitqWWxHa1VDMmtKWmRjMWR1NHk2SjJzZktv?=
 =?utf-8?B?V1lYZUlkVnlRaGhOUHNGQ202N09EYklrRUVKaE1OOTF0SisrbVdhUHNTeFZH?=
 =?utf-8?B?bDcvM0Jzd1hwZUR2OHFPclg1KzBOd0t0dzh5OFhOcVg0VERhZ3Qwd2g1emRv?=
 =?utf-8?B?ajJLTlFLNUdnSGZSZTFwM09HSEt6UW11NUxTU21NVjNtRmVTcWFyOW1uMTJY?=
 =?utf-8?B?cjZhajZ4N1ZDY3dhcHpQNnNmcThCQ0xBbUZVMnBnQW1LZHpDVzFGaUJhWSto?=
 =?utf-8?B?ejVNZEV6N245c2p1NkxNdDFaM3g5dHlwUHNvSDF4ZTF6ejNVNncvbUZPSWhI?=
 =?utf-8?B?ODhLWFRQc3R0Z3pFVWxvWncxa3NSMWpNelNjb1pweVFDcGJhcXBTd0NMVzcr?=
 =?utf-8?B?VGFPOFFPaEIzZzNKMUpHaDB4OEFrb0RScjJrZFJVc1VsbUpua0hMZWZpenBz?=
 =?utf-8?B?NW52QlIrV2VPMTZKaElEUjlrWnNXd1pJTVVyMWF1Qk14bHRNUTdKYi9zTG03?=
 =?utf-8?B?YW9UUkthRkt6ZTBORTZHanZ5NWhmR3dSekJLaFFCVVVrZ0JoRTZ5eGpSVkd6?=
 =?utf-8?B?NTFHaVNPZmludXdSU1E5Z3dDVFNodks4a1BRNGhzS3NHODFTd0N3akYxazdu?=
 =?utf-8?B?SjVyakMrZ09NdzdTYThJYWRUSGdyeERZVGtaZ1V6a3MwT0hSdmFpQWdSK1RM?=
 =?utf-8?Q?rGbSz8UGBIa6f+MayUkJqMGRB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Iawz9ZqkcUasXQeGFnvZ1SCX4uZKm+JzTKws6wp9CupM4d+zSW+5N92IWW8tdtO/GsYNME3jx0TXCPsxUMQJDJbWcp0rRowUHlr4jBM1Ku8SBXTnLRzcq/PvFenyeWsDTfR4Hjh05BbOTEcoERRAFMxZlj8Lcnvdlb5BOiiUJev1p16Ljs9BokmCUPrfOECMSvUHJxtvTCd55p0Zw6pTMti+2Tg3v6Il4EY1/xLeVWtSBGbR+S7vhdriBRwR45uB7sqYK6rqU/2BWp/3MokgNcY06OgBMVIRw9Z5IUk2Q6mpUV/kSb6kTyjCseB9ZMKjuhHPxBMy7PZfY+++1s8zd4SV57wsw2JDJPfVvDzkthz2zkaAu1Ak7Ccp3mjxu/7Kn/3vsrLytSBOG2ah8xdizl/b5e1Z0ASM7LKCZcgQIJ9X66MuRzjGlcyShhfH0w4zFnL0CzwGhRdrjd63/+4RNOF/YFGkkdrNrALGBPOckE9IBrhkpQ+gPBQgw1Gr/s2edIBrgydFiQ/evir1MY9s6WVbbFE/r4SMLmSGq8B/mNd3jpqjsozoR3M7Cg2YgJos1RVbqXihSR7RL4XSDRoBjUP46J2PCH1W3qoUXc6pFTw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b07879-1315-4b09-b971-08dd7ddfae92
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 18:43:01.8919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKVsNkGYF9Shg9kAxR9WdiQ9g/cENhPte/KpHViE5kBFNF1nk+S4Dziy3PVfBYrp4N6kPkGqoGENvivCHxJgDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF9FE99AC64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504170137
X-Proofpoint-GUID: -rBanufq8tRIWpdn3EjYyg41R9bxNhHi
X-Proofpoint-ORIG-GUID: -rBanufq8tRIWpdn3EjYyg41R9bxNhHi
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Gustavo,

On 4/17/2025 1:30 PM, Gustavo Romero wrote:
> Hi Annie,
>
> On 4/11/25 17:34, Annie Li wrote:
>> Add Control Method Sleep button and its GPE event handler for
>> x86 platform. The GPE event handler notifies OSPM when the
>> Sleep button event is triggered.
>>
>> Signed-off-by: Annie Li <annie.li@oracle.com>
>> ---
>>   hw/i386/acpi-build.c | 22 +++++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 3fffa4a332..4be3595e5a 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -40,6 +40,7 @@
>>   #include "hw/acpi/acpi_aml_interface.h"
>>   #include "hw/input/i8042.h"
>>   #include "hw/acpi/memory_hotplug.h"
>> +#include "hw/acpi/control_method_device.h"
>>   #include "system/tpm.h"
>>   #include "hw/acpi/tpm.h"
>>   #include "hw/acpi/vmgenid.h"
>> @@ -1359,7 +1360,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>                                                        NULL);
>>       Object *q35 = 
>> object_resolve_type_unambiguous(TYPE_Q35_HOST_DEVICE, NULL);
>>       CrsRangeEntry *entry;
>> -    Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs;
>> +    Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs, 
>> *condition;
>>       CrsRangeSet crs_range_set;
>>       PCMachineState *pcms = PC_MACHINE(machine);
>>       PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
>> @@ -1465,6 +1466,25 @@ build_dsdt(GArray *table_data, BIOSLinker 
>> *linker,
>>       }
>>       aml_append(dsdt, scope);
>>   +    sb_scope = aml_scope("_SB");
>> +    acpi_dsdt_add_sleep_button(sb_scope);
>> +    aml_append(dsdt, sb_scope);
>> +
>> +    /*
>> +     * The event handler for the control method sleep button is 
>> generated
>> +     * for notifying OSPM[ACPI v6.5 Section 4.8.2.2.2.].
>
> Typo: Section 4.8.2.2.2.2
>
> Please use the form "... OSPM (ACPI v6.5, Section 4.8.2.2.2.2)" for 
> citations.
>
Ack
>
>> +     */
>> +    scope =  aml_scope("\\_GPE");
>> +    method = aml_method("_L07", 0, AML_NOTSERIALIZED);
>> +    condition = aml_if(aml_name("\\_SB.SLPB.SBP"));
>> +    aml_append(condition, aml_store(aml_int(1), 
>> aml_name("\\_SB.SLPB.SBP")));
>
> Why not concatenate with ACPI_SLEEP_BUTTON_DEVICE here and in the 
> conditional
> above it as it's done below for the Notify()?

Make sense.

Thanks

Annie

>
>
> Cheers,
> Gustavo
>
>> +    aml_append(condition,
>> + aml_notify(aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE),
>> +                                    aml_int(0x80)));
>> +    aml_append(method, condition);
>> +    aml_append(scope, method);
>> +    aml_append(dsdt, scope);
>> +
>>       if (pcmc->legacy_cpu_hotplug) {
>>           build_legacy_cpu_hotplug_aml(dsdt, machine, 
>> pm->cpu_hp_io_base);
>>       } else {
>

