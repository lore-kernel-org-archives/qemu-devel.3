Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E409DC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 09:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2o6Q-0005ob-VG; Thu, 10 Apr 2025 05:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1u2o6P-0005oK-19
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 05:21:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1u2o6J-0001lH-8i
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 05:21:40 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A9H1kh007553;
 Thu, 10 Apr 2025 09:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=HmadqNxlnY0taOdV5T/XniTXq0hWiRiCP8o9rh7JJrc=; b=
 kirzJCMAfLLfrKV2V1TIYPSxjXUFQkaW1t3sD2Cyc53jda7n81jw+aAkO3puHNkz
 ECqDBXN1ACGeAeIbCPrD1ykZ5i8w0g6F9G7hbfMD5MQc3FVhfIHI10b9/YU9FTse
 zogGei9vz++TDeIn1ykZoWkYAlKVKga9t28JM3cTJzqqCABM37zSQw7Kxye4YlaL
 bvAIYQDimndt869BXcYGpo736bGlJgbcJCRZkSgG6AbhxrbDS3rP8Srna6XMensE
 qgdJ3z7ev+dgv+8vLxBGMhuRERHsHreVy0/1pBCzjyuKlL0rq+0J6ATsRaiSrlVC
 YhuRIkkN54ncgys+UgQSfg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xb7c80aa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 09:21:27 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53A8TKmG023844; Thu, 10 Apr 2025 09:16:22 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazlp17012036.outbound.protection.outlook.com [40.93.1.36])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttyjatyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 09:16:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoL2eERh7F3O2KVJiV8bJEAUqI3gm22IFi/gHQkJngojB6Fq1TZKIWXz621WeeFTgd1p8DxOTSsQ6b7JVScugB7hHZUAqZW4ixr0DqkDTs6M5s5ZItsuJ8zpID2xqheij0+sZrUNymO7SmHGNHT9NRfDC2cGsjkRzeA/IQo+DGz6dB4bXUw8efmunxakoxslzSXpcODELDWYYEQP4tyzb980T2qpAaqrlazC4Q2clKi2XP8RMz5WhXi/zqMRPkRLNADo1boS7RPFYFQgPrjJARJIkOzsw9uzDh+l2GqigU46R5lzh3yt+sjaaz6C8q1uttFZOzKuNMaAtcrXbvAxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmadqNxlnY0taOdV5T/XniTXq0hWiRiCP8o9rh7JJrc=;
 b=SxAY+NtJLqTHZ6ISTbbl17ZByWDFm3/rw0hsJFa4ovllUjdycmVEcR5tIoFYoNhS9WKbFIlYFmyiREd5u8Z5QGoty/xhvS4ESXlWrUHHQeNijeKzqPtkrzUJM8nPn/HAyocemeoSw7/DAz2/9jMc3P4VvtRVkjTIic0YH7A/9sWdlSJj4FgB/gRpPzM07WvmW0Bw4Lbg8gLPrrdWjTh0cB4k6jWJ7C3JE0AMB79XU0wiTN5CsBOWfCBQc2UE1u4QEmp3+t8tWPHhMDArfT7nK57EH8G7aVAVscqE+Q3ujDh10t1VRzoAqhpMpqBqadaovrE0wtVf7Y94OtuBlOKu7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmadqNxlnY0taOdV5T/XniTXq0hWiRiCP8o9rh7JJrc=;
 b=BRsDkr99SsmfpyOgpRCrRGZn3lbYY0tEl7bzdXF5P9uJ/BUAXtHjEpY9GKVKPOjJLCEdwQENucP12gfhGqGaA1JqpDcEZYm8fxqZUWTV4tP+E64rEp0sNHYDrPqUZfTkYEcYHFAJrTYG10bAr+oLYMo2maoQX4usgds+L7EdlXU=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ0PR10MB4430.namprd10.prod.outlook.com (2603:10b6:a03:2d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.25; Thu, 10 Apr
 2025 09:16:19 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 09:16:19 +0000
Message-ID: <df779e3d-4fe1-4cf5-8b5f-efc5f618d3be@oracle.com>
Date: Thu, 10 Apr 2025 10:16:14 +0100
Subject: Re: [PATCH 2/2] hw/i386/amd_iommu: Fix xtsup when vcpus < 255
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: suravee.suthikulpanit@amd.com, alejandro.j.jimenez@oracle.com,
 philmd@linaro.org, vasant.hegde@amd.com, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250410064447.29583-1-sarunkod@amd.com>
 <20250410064447.29583-3-sarunkod@amd.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250410064447.29583-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0205.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::12) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ0PR10MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: baf28b88-58c0-4ac9-b512-08dd78105a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVdQazcxK1lMNGYyWUMrSHRnQWJ5cUhvWU5kcjRvMW9LMTFpTkFoUCtZbHI3?=
 =?utf-8?B?czdpS0pUN2FtNmJCNWt4TDljQlBURmluNEhwWlpjcHdjRkFXSVExbGtncFpH?=
 =?utf-8?B?N1pLVTNFUkNTc0tZSnBKa2Nua28rNDJ6OTdnajZGK3Q0b3pKYUFibXZ4aUlm?=
 =?utf-8?B?WFBVT2FndjlVcXpReHJ3M1FPalo1aUZwZTMrOTNEb0hRbHp4WXdVd1NqcDZh?=
 =?utf-8?B?aU4rY0lLd3VhTEtwMisxeDV6WExqakJBUURzRThlaEZ1cWx2b2x4MzdaeWxv?=
 =?utf-8?B?WDBNUjgzUjdRQzV6VDgzNzZvYTIrdHA1QUVaVGhxYnBQMDV2d2hYVENtQmZM?=
 =?utf-8?B?bmJBdGFRbDVQbzFhbUxIWGFabUlGRHJrZE5mZUZabmp3ZmFGWk55MWVVTVRW?=
 =?utf-8?B?ZWFUZlQ3dGF5MnpvOFZuS3F1SHlyMGlsYVIrZWVRNUZ0cjJJOXpGbW40YTFw?=
 =?utf-8?B?b2E3bEowcCtaYTVuTC9tb0hML3lIOVUzUlFHdHluUFp6Q3JHRVJPM3ZvYzIr?=
 =?utf-8?B?N1pUSGRKU212VE1mVjNTYktDcUVGeWNUdzdOT1pudTVZZUhVY2IzUVBqT3h3?=
 =?utf-8?B?UHlyNFE2bFEydGs5OWMvNy80NGpkWWdYWE1ycWhSVXBKYXpqV3lSM2h3ZDJw?=
 =?utf-8?B?c2tuV3hJU3FlU2lsdXVGa0dEc1hhdnpBUHo4d09VTG9Zb3hKdjBZVFRwSDJq?=
 =?utf-8?B?NXVBQXdOMzMvZy9hcmZvYlpCZU53Qzd3UUhsUDJRSXB3Mm4yQ0hycG44OGR6?=
 =?utf-8?B?UXpyY3gxZkxQeHRrMk1SckJaMUZSbG1oUHI4VU1TWkRycWltaVRsbWhHc0Y3?=
 =?utf-8?B?OTZKVGplRWhLSG9TN0ZqRUlKMHJRdUlPdHFUYTJHN0dZTWtqY3NoMmVqdEky?=
 =?utf-8?B?QzFsVU05SE9KYVBnc3B2K25DcUJKYkZEQzEvZit6R09PL0JsODZIVlZUZXJx?=
 =?utf-8?B?dUVIaEordzRxRkNtQTZwaXI2Rmd0My9Vb2ExRDNBVWlyNlJSdlhnVTJDSXBY?=
 =?utf-8?B?NDhMcGtOYnBNODhDL1kxWmJ5NUlWVjBrUklwOUlzUzJ5RjJsV0hkZXdHdmYx?=
 =?utf-8?B?b1MzWTNWVS9GSVFqMkpyRHdLcDNSY3hURzBRYjJ1eG55bWhSK1VHMU45alhB?=
 =?utf-8?B?OXFoam5aK2xDTG1HTWpqOTNlKzNvQmhoZ1VYV1lhMUJvejNseXFZbTBhTGhS?=
 =?utf-8?B?VWtESEFST3BrK0lrK05qMnZhZnowVHVZaW5ZZ3MvRy9lRXlYeEZpY2c4bEt5?=
 =?utf-8?B?bHlUdDlmb0lqeDVPMytQTzJBVVlCN3pWbzhQZWQwT1gvM1ZDZ0p1U2J0OTl1?=
 =?utf-8?B?Q1lZaEFRaG9sZy8wbVpYOG1DUTN3M2dWUWJYUU96bXltZG5yV3JIRUE3VFVP?=
 =?utf-8?B?WkJFMlFzT2tzeHIvQVBFOGhtaThidWlYQURiWStQdzdOQW1vQ1pkaHRyaGt3?=
 =?utf-8?B?WkxmQVhnYlJDUHJLZHl3MDl1TlpsRCtieGRiQWhKZyswMVBXSnA2YVgxSmVk?=
 =?utf-8?B?YWFpS0NFZUNVc3RrT0hiaEs3NzZFS2VWVnNzT24wSVdFL2ppNXRrM1FqZ0tu?=
 =?utf-8?B?N0ljMTJ5cU9mM0tMK3crZ08vQkRpZFRaNkJ2ZENFcWpNbjJJVHpFM1FZRmdt?=
 =?utf-8?B?U3RUNTR0UFBSMGZjSU5iTTZwSTlFeU1hUy93U3A4Z0xsSlU3REdQL1M4ejEv?=
 =?utf-8?B?VUpseUd0bWJ0bmNyUlJhWURNUHR6ZmxWd3dhM3NCOGFteTNoNzZVMlNpTnpw?=
 =?utf-8?B?MkR3WnI4UWxmK3VyNzhvV3M1d3hPaklFVmtlWi9tSXVnS2hiOTg2QWcydmll?=
 =?utf-8?B?TmNUQmI1Z2hYZG1idEx3RVpudVdVdDZNLzJSekpLZk8zV0ltL0lTR01HNFYz?=
 =?utf-8?B?SUVlR3RHS1ZHMjY5YjV5dHNMRVorN0dtdFlzM2lMMzg4bDA3OW9za0Q0TjZI?=
 =?utf-8?Q?YPFsZw0enMw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJFbDdycW9FaVZSc1VJV2luSitWSnFXVVBXZENBbEVWakxoUDdNcjNKaEEv?=
 =?utf-8?B?bEU2dk1yWWljaHB0UU9YYU8wV1dqeFVZK2JOZlQ1ekRZOWJjUGZPNjlKQ2NH?=
 =?utf-8?B?eGpxeTliVXRmYXhoeEovcGtyZ1pEQ1ZIZ2lkdnFDeVhqY3diQUtWcnp4ZHlz?=
 =?utf-8?B?RzJTRkZGbmVBYnY4NjFxTGZzb3V6Z2dJbXAzY0dZdWJaT01jNjhOcDdka09I?=
 =?utf-8?B?MTVuSDlPNmdjOWZadDhmdDQxa1R1R1RtVFRXaUV1LzR0ZGllb2NWV1NURUhP?=
 =?utf-8?B?WEROb3FyTm5kVUZSamM4ZVdRMkJQMU83OUNTdUZoNDRLRmY4ZE84NmVpcXRa?=
 =?utf-8?B?S05GQVc4bTg0RjRBR1hnQmpXNFd5eHpHRytpMUc4SDhBeU95VXVTNHNBM2d0?=
 =?utf-8?B?WG5VWFdDZGkyeXJ5eGU1ejd6MzdLNDk1TEQ2NFlBeWg5YWdua0hoTU12YkVV?=
 =?utf-8?B?TzZuNEhPVTVzZFNMTnJkdTVwQlVOOGt0c2tOR003c0VNYlgzTVFOREptRFdK?=
 =?utf-8?B?dVpiV3hwakFDVzBGM0JWblM2YllFOGFXVTdTY1V5bUpEbWdZU2E2U2k3Ym4z?=
 =?utf-8?B?VkhsRjRoSFl1c3A5azVkQ3F2ZE1PM3J3L0MzUncvbE51M3E5NVVjUkNhMWRT?=
 =?utf-8?B?TmRiY01iUGd0ZHkrVWJyQ29odU40cUYyYzNUMC9DOTNnTEU2Q0grVVVEQjVy?=
 =?utf-8?B?OERWYWVsMUczZ2Y5eUFncTczeEl5N0tOWGdCaUxHOSt6b2hKWjBZWWRKOGxD?=
 =?utf-8?B?SU4vcnhuRmwrWXRhNmRRQ0M4YVo2bi92NU9pM1RRSjFBSkhHMFVmS0lQekdH?=
 =?utf-8?B?Z3o0dUFhUHgrajRBaGQ2MklBQ2xHOWY0MnU4dkc4eS8wUW1xUHIrR3pBL2Nz?=
 =?utf-8?B?WjVYYWQrOWtYNUpKUVloaG1iTEhIMmI4VHRodm9USEZLbXpVUnlOWkJUZ2o5?=
 =?utf-8?B?RjJtMlFOd0JMdkVacE13M0ZlOEYwclRyMDc1dzczUE9mSlhIQXA1eWk4MUxl?=
 =?utf-8?B?N3ZFbFZiY0dKdEhWbEYzMEpVMndKZWlhSEhiV1VCSi9rcHhpdWFwWUJyOTNN?=
 =?utf-8?B?UjlydHJUM0hWZWw4UENPRjY3aWxORFlDS2pxWWZ3NkJZbWFmeERUaG94VmlP?=
 =?utf-8?B?eWFSOE9RTTZIUkV5N0N3dG9KU0RyUitKR3cwdmwvZmVwRkZjU0kxSTlQcGhS?=
 =?utf-8?B?OGtHT3ovS0RodDBjYXhYRG56U2d6M3ZJYTFCbE50VXpMU1hOTzdiRDN5Qzd1?=
 =?utf-8?B?THpmVDIweGNndzJjc2hhNnpiREJNdEU2eHd1RlJUOWxDcXlxNW5Qa1JPS2dq?=
 =?utf-8?B?UVpyRVFrSmJQQWlLeWxsR0daaU9OenBhcnAxSmtQdWpJMnJubTJLUzJSZ2lX?=
 =?utf-8?B?M1hzTldKQXVBTk5vSXRCM1BUd3F5alp3eWE4amtGbUFNd29GSEY1K0tBdm1X?=
 =?utf-8?B?bmxBRU9rQXF3WG5FZXZxSVlmRTQ3ejQ1OUc1WlZVQVc4U2pqOHkySWkwUHhG?=
 =?utf-8?B?VmhITWhmS3pLOWFoaXFSVVFzaHRpemNWWFBHOVo0eVhpdXpKK3NCVzlWRHFB?=
 =?utf-8?B?ZEx3WmVuS3JZQXRZSmx1QUtXbWpHTk12VGpGUmNPOHlKb1VheUxEK1NsbFBm?=
 =?utf-8?B?VUc3eTdaci9WM1BIZjM3eDV6aXh2YkNHWUJjaEwzYjRrR0Iwd1VGR0JmWkxk?=
 =?utf-8?B?Zk5zaThUd1FDMVZHRi9VZ21Oc3VFVzVSZEY5ME43bGMxNFNsazF6WlRFRGdN?=
 =?utf-8?B?N05BMnh1VUJvVDh3bTZYN0pwMURjUFNZcHp0T1BJdFRacnkvUXZ2RHZzSXY2?=
 =?utf-8?B?ZXBGVnZTZGVZRzJENTBWbW1QeFRpOWJBQkFIVjl5aDkvL0w4K1FCdnY3N3gw?=
 =?utf-8?B?WDFwVWQzV0hTMmVJelh5VFZhRU1ZaXFJZEJ3N1R0R3ZUMTVhbGlCZ0oxZGpP?=
 =?utf-8?B?NlNCU0dVTFlhWGIvd0JJREd1MndYb3FET2I4RGswV1oweVVSV1ZwK3pUTjRG?=
 =?utf-8?B?d1VSaTdRY2U0ZG9JT3pXQUs1cHdXVnFmWllHTTZwb1AyZlJyUllNVVNoUlg3?=
 =?utf-8?B?c3JId21yZlBaMzQxZVdtcTVydksyU0VtNEdRcGdSYi9YNWo2cENOd3J6ZGNZ?=
 =?utf-8?B?VEtSZGc5S2FDVEV0ZDloZElCQSs5dGxTUTBDRFVQY1NjLzBtYTRTU3dpQVVP?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8BZ2QEvOsqIkMRALAmb/arKtItBVKs8rp0AJEWYvMnqhsBsxlqTCmYSjxMxeKHUL7DWw9FZ2unZDBMeXZvvTT34xoDNLK35Jl5feo8BrptXxwwjT4oycVA9gXw3tMCk0mFv/zAAFqWTQD6p8iDaF/X3X+wO7/QyIFgycNdfAlfOGbdP3umgr5rCeQVp5Sh2N1rxXdLv0vri0/KZ7Iy+unvj1aZsWMphhsydHEOssOG78BVVJm2axvkEDbvgg8dF9h6l2kV4K80+GMfKhit44Kee5QjsLCAP8GG8twfYK0ArqvFKdfVgTr+fhaQfXcTYqVdB8+rMdXBf/RCLpFn9CRfmWx+U/7cGzC97yA20Ythof3rvgkntvCHDHeKshDUUdCrM8m11Reab+P0u5nflnKmyvWr8roj6ISbKAViczZOB+UZuAt22YsdSRPFQSrsJBAxZgNYVhcqOLkajeBg4EGUjbwJwc4/7PPYD33ZaEyYkw3Vw66DmGhh4oUp90iu8fcd+BsmGfOwZXM1EKRBV4FHA37WUm59M3JMCtVHMNQkL3HJykNXTRfYXWT+F5EDh6UuMtDt++jJmf1UagM1Lv+N1zVS0FuJrVGYegCYX3wLM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf28b88-58c0-4ac9-b512-08dd78105a8f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 09:16:19.3762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iw9+e8ZE95/mYNeDhELBRrrp1rjC4u9yYqZImVviQYSmhNoKuC6npcgTVfpBd6NCNp5qjF82hqWj5scwS6d9WjCHGgqQLkYjWAoSXFDe3EQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4430
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504100069
X-Proofpoint-GUID: WtI1hfs21grBBYzfkOKWENL3FNxOn53F
X-Proofpoint-ORIG-GUID: WtI1hfs21grBBYzfkOKWENL3FNxOn53F
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

+x86 maintainers (you forgot to CC them)

On 10/04/2025 07:44, Sairaj Kodilkar wrote:
> From: Vasant Hegde <vasant.hegde@amd.com>
> 
> If vCPUs > 255 then x86 common code (x86_cpus_init()) call kvm_enable_x2apic().
> But if vCPUs <= 255 then it won't call kvm_enable_x2apic().
> 
> Booting guest in x2apic mode, amd-iommu,xtsup=on and <= 255 vCPUs is> broken
as it fails to call kvm_enable_x2apic().
> 
> Fix this by adding back kvm_enable_x2apic() call when xtsup=on.
> 
> Fixes: 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM checks on XTSup feature")
> Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/i386/amd_iommu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index df8ba5d39ada..af85706b8a0d 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1649,6 +1649,14 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>          exit(EXIT_FAILURE);
>      }
>  
> +    if (s->xtsup) {
> +        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
> +            error_report("AMD IOMMU xtsup=on requires x2APIC support on "
> +                          "the KVM side");
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
>      pci_setup_iommu(bus, &amdvi_iommu_ops, s);
>      amdvi_init(s);
>  }


