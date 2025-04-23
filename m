Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2384C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WZy-00035g-I7; Wed, 23 Apr 2025 05:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1u7WZt-000350-Tt
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:39:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1u7WZq-0007zy-W1
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:39:37 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N8fmnP023914;
 Wed, 23 Apr 2025 09:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=QuZZ3uNHQdjHN0ebl5epZUJYMaGcTHnqgjY36SkDcuM=; b=
 Q/MMKHbw2ug8+VynnOEaXjL9oMbLmCeeZwBttnTBOr/HKG90kpgl/Hd0gwzUaeuL
 edGL3EANRmHRRXvominDyF2SNfVvVQ7N1s5Xa9laR9lZ5A97LNkZWEol83gQo0Et
 ykp29Idd7vVefJjSOzekghCjAXAORtpLywECzmH6bREs78oHqUVGG33gTyyyEnJo
 b9PQZMH7GWmdneZfAmIXjEj3WT6A4r9XnAkcyIBFjnz/AZsPQAWveBT0/GNWlX7Q
 Ts90cgb/bw61EO/snxcPwVehZKdOoa4tO6PKlXewz8iG/aUjd02IVpW56zgngS5H
 EAlbCxjVtQg45XOzISKOqw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhe0uav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Apr 2025 09:39:31 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53N99GoL039229; Wed, 23 Apr 2025 09:39:30 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17013078.outbound.protection.outlook.com [40.93.6.78])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 466jkfcgsq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Apr 2025 09:39:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHnMEXYpfbDxYMJRpVZXJBab5+eIaEcFpehXqUH0aVRji0sUX+PzRgMZHyGBxyionhZH787TFmargUfPZwlGp3T9SPMOAC7IZoR5pyt2yue9Xa7l1tdzsQLZQrcXI12H0+6CW7LIXUoTj8/B3onEB9qH8sAoatdMx0flyq5wjt05YevdFgDRewJvbTUbeUE/41rAldoDDcNrwibtt0CWksNYVs5E3hSw46F1JfbLi2co0PYSfWRYDZ+cNnJRcJU7ZrmDxYHpgvEtkbEkR/sPhvdP9VzeFFFQoYrCGoAxg5osIBfTf/F9o2H91vxagrjEqD/A832/tUq+i6mPJmX9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuZZ3uNHQdjHN0ebl5epZUJYMaGcTHnqgjY36SkDcuM=;
 b=SN70pmG0KwZ4A1KnyVb0VYYNdaw32tJY1Asar1p8zYdoRDxoAScIZoRFC1rluDhDTrIovlLlROUcU4V2K8BngCbugNidroHA6Xop6inM2LyFjVUtDj6sJGUuXNzpT5ERlbgnopZeJZfJh7Ngxi05oRyTYii2Z2mvL1AfMmHvWHsKFGUTgL9FsIySioj91PCbqe/jCkfZiq8pY37DI8JrpBa6iZeNPJtLMyy5F17DJLqvC8qiy2+0wUUoll1382h4/DlEi/3SO+b/NTmMZvmvqmRTmSkVpQtZgMxRuTHFBYi/ad8Zl8Tdt5CfOrb++BqHzshNUeYKO2eUoBoL2jX87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuZZ3uNHQdjHN0ebl5epZUJYMaGcTHnqgjY36SkDcuM=;
 b=xusLhFJhGyO8aIuu6PL2vzQxgpBlV4tl/Ntih6OSnTVkJiQZi4r97NiCpQ8PPTTe2Z+gt675m6vxzR1JP1ieITyJbnIer3/p9PRtL/zLannTm/ECgz77cOMUZsRYLysbfyvvPHrWPKfGss/okK0e0XzVYkDaQXQ/EAqQtwJk3QU=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by MN6PR10MB7541.namprd10.prod.outlook.com
 (2603:10b6:208:46e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 09:39:28 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::dfc3:b0d8:d4e:5c3]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::dfc3:b0d8:d4e:5c3%2]) with mapi id 15.20.8655.031; Wed, 23 Apr 2025
 09:39:27 +0000
Message-ID: <e5d8b482-151e-454e-998c-ad967d9e530b@oracle.com>
Date: Wed, 23 Apr 2025 10:39:21 +0100
Subject: Re: [PATCH v2 2/5] vfio/iommufd: Move realize() after attachment
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Donald Dutile <ddutile@redhat.com>
References: <20250423072824.3647952-1-zhenzhong.duan@intel.com>
 <20250423072824.3647952-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250423072824.3647952-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0353.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::16) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|MN6PR10MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: e31d8fd7-3c52-4840-01e5-08dd824abd31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejM1RHB3M2RTbVFwQnM2SDh0MXdsSmkwcnd2NWVwcGQzQTc2dEhCdVl1UzBX?=
 =?utf-8?B?SWRCd1F5RDlmdDRjSDFKa3BocTZHSVhtT3k0ZHpYU1NPSmV0bU1HL01Fcm5N?=
 =?utf-8?B?K3JsR1JiQWFISnlvRUxKSzF6NjRTYkJTVjM4SFhUOXBKQWNqUGJQM0NZazNh?=
 =?utf-8?B?ZXl3K2RPaU1aanQvbGVtYi9YYzZMbHpjOGVMZEt5L21zYXJBSkVXcVBBSlhX?=
 =?utf-8?B?WEtzWUJQa2dRN2hWblpVMktyL0g5cXh5c3p0dk9Idi85dzJuQzlYRzcrWDla?=
 =?utf-8?B?SytZOW5uYnA4dEJ6UUF3RVpYZThscjZOQjFGbHlQN2puOGdZTTRnckdjMXpD?=
 =?utf-8?B?UGY1Y21Jb3N1c1ozOW51SlNxRk0yQ2EvUXdHb24xbFFZcnd4KzhmcnA4MVd2?=
 =?utf-8?B?eGU0UDJBa3VaNWpGUm5NeS9GeHZWbnVDM3VPQnBTdVNQZi9aRmxIWGtubXZ5?=
 =?utf-8?B?bGVMUElISFNDY1kybUZBOFlRRnpsSW5UWjl1a2tjSHlxSlNraHZobm52emxk?=
 =?utf-8?B?dVJVRXFLZzRrVEZqOTN1K0c0VGRhdW5aNzdXV3ZVTHVabHg0WFg5YlFjTFNQ?=
 =?utf-8?B?cGk3cDExQXRBUGVSMkFZOWNUTGRtTkdUQXdRVU1FSDFFSG1XalQwM09wRU0r?=
 =?utf-8?B?WW9lSFBFV3dQbERXT3poWXpySjRDUGZXM3IwaVIyQ3VQVDRwYU5SUEZNSGNr?=
 =?utf-8?B?cnpKZmw0Mms4Z2ovVFVZTi92TWVmYTluTlRNYWZqaElFQjJKZ29IQy9pdkpp?=
 =?utf-8?B?SkduZ1hzQXFLQmwvT3hRZEpXVzdHNDMveHpTaHhkcGpRQjZtYkpoZGs2K0Iw?=
 =?utf-8?B?TFY0Vyt2Z0NSa0VPazB2RmJTSzNOaDFJakRuMXdBL2VkVmZ4NVFFVU9YVjJK?=
 =?utf-8?B?YzRNWXZzaWtiZW1mV1g4UnFDa0ovTG55aWFiaTRERlIzQXNSeW9lUFpxd09n?=
 =?utf-8?B?T0VzQzJJbGY3V0lCVlg3TjZZQUpNUHdydzErTEJnOFBDdG85dlFXMUgxZmlO?=
 =?utf-8?B?T3dMVHJKVkZUVlZIeE9EYVpHQWVpZlBxcmtGZGJ4S0RBRk5tcjQzTll5a3Vn?=
 =?utf-8?B?STA2OEg2SU1YWFZkNW5DMHBTS3lTeERic2pReUNwUnZUOWJmdXRxN0EwVUdJ?=
 =?utf-8?B?a3lvbHNCRzd2UlhUNkNlUUZXYnhnSUFFMFNoclNPL24rZU1pOUgwaXdsRTZp?=
 =?utf-8?B?dEdrcFFRSGMwbEpkMDdhMEkrbmdXRXhVUDdiTVJaUXBCV3gvZU9QL3hadU1J?=
 =?utf-8?B?VlB2Rlk0Z1lLcmoyVmhaTXA1TXhzSy9HbytqVEhmNytRY016ZTI2ZU1xTXJ2?=
 =?utf-8?B?aVdjU0N6VkcxQ3J1TG40U2lDWE9NNGNVeW53LzhyOStvZjM2UWMwaWRZZFZT?=
 =?utf-8?B?aGpuenJnc2d5Uy9vdHN5aVRGZzN6Ukh2am4vRlNSRUNGZUZlRDNiQkZYOHpO?=
 =?utf-8?B?WkM4WlZkaTBEZUgzMTg4WW14VmtjdlU0dTk3QlhtWVhiNGg2UFExV1p1MEVO?=
 =?utf-8?B?Y0VGcFVkL0wxeDhmaWRza2RGUFE0dGhIRUJRQkk4SHoySEFlMUs5d3pQbHN1?=
 =?utf-8?B?RklwTUdZd0Nzc3ZpSUNmREtjWUZXMG1qaEdaYWQ4bXRFVHBhcHpUKzVpc1N0?=
 =?utf-8?B?cGg5ZXM2cE9vTHhKTkpqZmF2QmtDNW5NUVVyRW9zOS9CRHF3QmxYUzkzczFn?=
 =?utf-8?B?NjgxSnBhcVpnZFVaUXcrWVFxdWhXMFl4MXV6RVVzekppWGJ5S3Z5UW1rRG5U?=
 =?utf-8?B?TUNpOU5aL3hudGEyUlI1QzZ1MlhSZUNlUlIyWkgyeTlKc0N6YmhITUNycStn?=
 =?utf-8?B?TWRFN08vVkpvUjVQZ05nVlNHaTRrb1FHM3RHazZMd0xiaEx6OGxrR1JFOThM?=
 =?utf-8?B?ekpyM2JWV0JFaU80WlFxOTlHNGltTHlZOWZpdHZVSHh6VnQ5UEZvL2FRK0ZP?=
 =?utf-8?Q?gKD7VaavVVo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amdtcmRETlQ2bkRXQzRGWkR0MVNyN2p4WjhmOXoyd2xUY3JQcDRHZmtlN29t?=
 =?utf-8?B?aHcwdXpFY1RwQnVKeXd6Ym5aRlRrQ01XaERLVldHMXF3VU02cXVZK1YyVVYz?=
 =?utf-8?B?ZWpkaU8zdVFFSXprUzdQWEQwMXFJYXZPQS9FTWc3Z2RCZ1l4QUN3ZVlUQ0J6?=
 =?utf-8?B?VmduT0c5UnRJZ2MwOGJkMmV0aXZKQlRneUFtRnRGWkxaVGRqQk5iNjZ0K3Bl?=
 =?utf-8?B?YkRGQjcyYUFocjk3OFBjdEJYQ01YNnAvaWx0bHY3TWs4eEtpVVh6c1FjMDlN?=
 =?utf-8?B?L3BjeDFBa1dtU0lNOURXQUZxeDFvYWU1YWpNd05TWmJDVEtCNnE0ZjRqZ3FR?=
 =?utf-8?B?VUgwS0JlRDcyb2VnejJRWDZoWW4zZ0tJWlNaZ25aYnFvTUpOVmNWNzFZSlJS?=
 =?utf-8?B?dkxCMGRJcFpEUExUQVBES3hSMGlER0JQMVgvR2kzdTc5dm1TV0REdUV3UjFi?=
 =?utf-8?B?Y2lXZGM3TGp0S3MyUkR3N0NSQm41TkRuYWJ5WkRIeGlreE1IS21UdjNRR1lE?=
 =?utf-8?B?eGtydlhSczVvTzdrWmhrRzZaRDdVV2JTQ3RLUDFJMnRuN0p5N0JTcXJQRjRH?=
 =?utf-8?B?ZDJpYjF6UnIxQU05bjZQVmZXM3RxNkxGdzZ6Yjg4Qis1NG94ZG5Ea1hHeWF2?=
 =?utf-8?B?NXZWb0Z1WkErRkE3enZTaEhrK0IwU0lGVUVBL0czNDQwbFh0MG45OFBRMlJY?=
 =?utf-8?B?Sm9MNW1XcHFUUVE5MEtGRTd6SnZyOHdHTWhXYy9vRGZ1OCtITFBiUDU0b0Jj?=
 =?utf-8?B?cFlLaGZBaWFWVi9rZDdYUVZpOVhYcmlBbFFzS3lGWGZtZ3llS2dXRkZDZDBU?=
 =?utf-8?B?SG9QdDduaU1WQ2VOTlF2OFN4SHM0WUVUYk9wOHExampEZldQU0EwZ00rMFRH?=
 =?utf-8?B?cithMmVsd25CMGtHcjBJb1d0Z0tncnZ5ckc3d1FqNC9Ob0hZZ1RXSkJHSG1k?=
 =?utf-8?B?N2Z4OEpJWDNYbURzRHdROHlFTFRLK0VpQWFNSGgyeW9zUUhWeFRzR2lITzdR?=
 =?utf-8?B?YlBXbllxV2xOZG9wa2JsZG1oVW1VK1kxRzRsbGZ4WDlhVXVuQkc5WXdhaVNz?=
 =?utf-8?B?Zy84UlZxSGYrUVNQRnFocUR2Qm0vRTZJVDRzUWhDa3RPaXowZGVDY3BRN3d3?=
 =?utf-8?B?UTFCSjZyMkdQS29PeDdiaktqRlBPb1JvdnZ1NGVvQUVKQlhnbFl3WW9WMHZk?=
 =?utf-8?B?T05rWFRNVm1ielJJZEZ5SiswMkdHNlZFdkVvTGZTcUhOblVmT1JySXo0S1lx?=
 =?utf-8?B?UGFiR0J4b1FuTVd2dENtN3YwVUdSaGJIejN5VWtONXg0T1ZqV1psaVZldlhG?=
 =?utf-8?B?c0ZWT1RqT1pOVzgvUUJ4cHJCVmJsbFJ2bmpVOUVuQlo2LzBjeGljYitNTXB4?=
 =?utf-8?B?Y25LcVZuaUVadDdPNTVsVGY5WHhSNjVyT0JaNXJNOG1IcjhCTlB6VjJuK0ZQ?=
 =?utf-8?B?eGgxZ0JtTWJ3bVplV3lZdGxlV3JueExUMHRjRTRac2kyMTh0VjkyQVZNNlNS?=
 =?utf-8?B?TjAwQWxib0tRUHcvWlJvU0VhQVdzeXI5UFBaWk1rQ2plK0sySElYQWZncWY1?=
 =?utf-8?B?ODZUMXAvRDVobTY2dDRGQ1puOHJXNUp1NDRKYVZsSS9rT3dzem0wV3ltbkZv?=
 =?utf-8?B?VlpId293c29NeXBZZW4xNm54ZFl1amt2MEtVWTdzRnhDb04xdHZPQ1hwcHcx?=
 =?utf-8?B?RExFK3RvMnhWc05mRkViY3BCai85S1BCSjk1VFJzSzE2OEQ1aUR6YUxvWVhJ?=
 =?utf-8?B?UzBBa0VRMVRRbDlMbGc4V29BanFrOTdVU2liNnUwbUlPbEtDMGlyVXE4bVZC?=
 =?utf-8?B?RjNYYk5NcEU0ZDNiWVJVVldXWUxpNXdCL0UyNXR3RXgxaU9IanYxeEJNLzZQ?=
 =?utf-8?B?RHNLWVcwZ3FCdStoU01OMUZ6OS95QmNwZXkwLzdUbjBuNmJERTZ6b3l4ZEpj?=
 =?utf-8?B?WkduS0RIQjR6a1c3YlNMSDJsd3NBZ2FiVFZuY1Fla1FHblE3TnhDN2RpcjJ5?=
 =?utf-8?B?RDQ4YlhRbmo5WURLQzJYaGw5cUFMdTlNYlBmRVZyeXhPSEhvLzRzMytmVkZH?=
 =?utf-8?B?MXhZaVVRK3Z6SEVLMHFHR3ZJUXArSnpzWnNOOVNTaXRKQSs0SnlWYUZDZ05G?=
 =?utf-8?B?SFlSc0lpV2lHaTBJVFdMWnB6Y3RsTDBYNVRyZFhiN3dvNkdKWWFWRFdyOWtC?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MZqGJ6Rq7qvC+WbKIUragRZpATKJxdrimKMzUsA0CwinFxju82maRPnt8G0pCPHUICyXAmn1sSI7/yNFhfoG6+VyXmOq1LNfMjAJdwBZNCWok3j3xXHK4DVb+cHLsV6yyx7q5gvQmyu+Kb7XnnAxEH7BGQTpj5jxUtWzdSxkqIKpD6tl+kY5M4zd1AWsxHwKdLvhpLeTRnKtXQ7pK0wnG51ER9LGYL2KWzMOG1LV0JTB8WSsVYaNR8NWG6R9OL+IPtCPM8BsPK4dWZ/QLa2AyJuNZ5kLOjpFdYliV4F3b4ebXEKVJr3ef7CdZJu/8FvJ2wAaOVa3O0CODOnGXjVcW+t0TL0YeuREjS1Ne6zzCZRH39G6ALTBf3dnX74qoIy/ARAYOIudZO7wTL+kDMQYTAwxpPEAcNO6oGvl+1V60YiILI8jA6PQJdtcWadARiWGNZ3p+e0tcWvNKyvWh9okSaeRjvNldiXraYpfVtiaIEeHgHAAGOWdWVNwUVigbLg2wkt9UMnF4gPtwqc40v8WitIIgLqBjWEZevsEJu6Gib1+quMCvNLj2MutTVpvWKIrjnxWft86gqmfolwcNl6muyvrkUgiBAaURLOjJFmJ1nE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e31d8fd7-3c52-4840-01e5-08dd824abd31
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 09:39:27.8977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D6p/dFtAxhqsuUL6A/G03uayiZuMIph4hz9IVAH531532jEogoJnnxZtLNTbphJM4UAAjzCmYLPrRr4n8WsqauVyCPkexHROYP5qjlPxJLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_06,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230065
X-Proofpoint-ORIG-GUID: v4NkhOh9cuQVRkvrl8dQNXxspSDKOMui
X-Proofpoint-GUID: v4NkhOh9cuQVRkvrl8dQNXxspSDKOMui
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2NSBTYWx0ZWRfX1y1KuTgHIII5
 zmQELYJ/wlxQ0dS2w6kf4oB+tY8svLSf4r9VS32b5ToMY7l60gukvH++v+4jSceiN7YEI5UR3cC
 SuKcsdn4T087ptWgltmUi3x5H31+71Z9xElrR761SVu/dTd2V/j/Gxm+Y5EiUiZqFae6dePBOph
 UunZGohUHSqfz2NPIs/4Hz4x0hqQnjgxTtXgTtZjRwr0cWILpV4jcV39NxD/hOXXS1sPVhlLnrt
 tT/e5cGpC2aXYQaOKTdetvymHWyGMDnxSF1kvfmB2H2eHKG96OyDP9cF9pMhCZdx/IMNAMgXiqc
 i0G0u6uYReYzPVfcakNPpBoNGcxM/kAxXAiUuMMP3tlohOso4oRe7f341eEoqJ2noPJTH+VKDEn
 9cMjKb7d
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

On 23/04/2025 08:28, Zhenzhong Duan wrote:
> Previously device attaching depends on realize() getting host IOMMU
> capabilities to check dirty tracking support.
> 
> Now we have a separate call to ioctl(IOMMU_GET_HW_INFO) to get host
> IOMMU capabilities and check that for dirty tracking support, there
> is no dependency any more, move realize() call after attachment
> succeed.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Suggested-by: Donald Dutile <ddutile@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/iommufd.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 2253778b3a..f273dc8712 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -500,17 +500,6 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>  
>      space = vfio_address_space_get(as);
>  
> -    /*
> -     * The HostIOMMUDevice data from legacy backend is static and doesn't need
> -     * any information from the (type1-iommu) backend to be initialized. In
> -     * contrast however, the IOMMUFD HostIOMMUDevice data requires the iommufd
> -     * FD to be connected and having a devid to be able to successfully call
> -     * iommufd_backend_get_device_info().
> -     */
> -    if (!vfio_device_hiod_realize(vbasedev, errp)) {
> -        goto err_alloc_ioas;
> -    }
> -
>      /* try to attach to an existing container in this space */
>      QLIST_FOREACH(bcontainer, &space->containers, next) {
>          container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
> @@ -585,6 +574,10 @@ found_container:
>          goto err_listener_register;
>      }
>  
> +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
> +        goto err_hiod_realize;
> +    }
> +
>      /*
>       * TODO: examine RAM_BLOCK_DISCARD stuff, should we do group level
>       * for discarding incompatibility check as well?
> @@ -606,6 +599,8 @@ found_container:
>                                     vbasedev->num_regions, vbasedev->flags);
>      return true;
>  
> +err_hiod_realize:
> +    vfio_cpr_unregister_container(bcontainer);
>  err_listener_register:
>      iommufd_cdev_ram_block_discard_disable(false);
>  err_discard_disable:


