Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76770C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWz4K-0004BH-23; Wed, 02 Jul 2025 11:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWz3z-000447-FY
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:08:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uWz3r-0001U8-CH
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:07:55 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562Biu2v016669;
 Wed, 2 Jul 2025 15:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=K0jIEHAq0KxRVd4T3xKlrj3rqWW8mbfEjOOg1fI8Qw8=; b=
 gj5jHX6W+v9z8eAb+z41rJUj9GlOojf+oEL/MUyLsAw3p9MuStda7opEOcItCrUj
 btLlrlB7LnE5D3qgnq1vOsCJVLY5HMg/AEJ714HYFqHyWRTQi0EbzyJ305pCUZne
 bHUWy9LUqrL0x6hyzThNhsmKTHvsJT8teWomt03Gw8PBotlGsUM98y1wWTPHVWVt
 72SEh2uSRihiLEfzfvTK3UsxwJ/2cWOZnMDG+ZiOCixpO3nxXt+jwVl7fkvalMf0
 9trq3NqoQ6UG+NSnCZPyKKOUMhDDE7x0AoNn9lDMBA+q4QrHG9WHakj+mafSoC1B
 Km+329RpMYvlaMmxIX3FtQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8xx74dm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 15:07:40 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562EZ04q027527; Wed, 2 Jul 2025 15:07:40 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubb1af-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 15:07:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdB8V2kYcr2BLh8UerABTUE3ShC8RXp+nPeqejtKL9Za0M716omxUX9Nzb3L4tVGPEVzG3y6CYC2O9JpZqPbdrHt0DMOOmh5z2k2UNNlAcraC+FpC2GYbjXv1yugm6tUD7k8U+wPn2HR/oSbEjOIoVAJU06lY3MKXIz5CQornzeUqDL8Q/f81G6glI2bQ+bQH1+5EWrOtGNsEIvUPy7Pfv0SeNmR1ok+izS8FPoZAzSl94C1pXaVpWST5Tl4w3NqvSKPXgH6VqkYRT9/WlNmidBQq2xokvxJQYJSa2jLt3RmXgI8nATMKtyGixzpbEn/FZ1D3IJQzLsZd9Z1r4zv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0jIEHAq0KxRVd4T3xKlrj3rqWW8mbfEjOOg1fI8Qw8=;
 b=Opv829SCdKxcstos2GwOdtlHv8mOmikA+CCyrBdWaLL7B/UugqI3lVFFaXJyrZcd+4WN73UFXPqNZT/4UMN5cvgvsNppubmO9x6lbtAKCHh69Mcv7FOWrkNye8sbA/U6m5ugMwrGMShcv4q/DpgyeiH4i1t7I6X6b7fl7+oXexJG8Jrx1UMO52YIJRrYHxflRpCerUiEowSd+o3hkheyjyJJTNj/REMR9f2nI0mGm9HIEB9Lqoq/fqdpEUzplSsIplkhgV8V14i3RxhobGSjGcQFPL5Hfiw5EgQORa/yPh/5HGeIM3TNEDDvlBR0l+uBDorP+A2s13Icgssh+GduXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0jIEHAq0KxRVd4T3xKlrj3rqWW8mbfEjOOg1fI8Qw8=;
 b=CjCEiQN/tXpedVC9GRqFwnEeybTwmLa0flKXPGP+OIMJBoqGh2KVZKF1COWXdUiVZ0ZvFVND6ZXfbQzy2hvpRTfyW8v13D7hWSMe4E+VZNC+1wgTNY8oYZqXO3zbGdq4fyyEUMj3+vJO5mtfLWUaXIPrK+9D0qzKxQb5o5Q0YnA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6457.namprd10.prod.outlook.com (2603:10b6:510:1ec::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 2 Jul
 2025 15:07:37 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 15:07:37 +0000
Message-ID: <9aa1d50e-48c0-429d-9c31-0cc851ab6dae@oracle.com>
Date: Wed, 2 Jul 2025 11:07:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 30/38] migration: vfio cpr state hook
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-31-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB9136990A7C183E88A5E3A9909278A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <735fa30f-e5f9-4777-8765-7b1436e26a35@oracle.com>
 <IA3PR11MB9136B9DC021B0D2B157BE4279240A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <IA3PR11MB9136B9DC021B0D2B157BE4279240A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:a03:505::12) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 773aa86d-5365-4b5f-eb91-08ddb97a2e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjIzY2g2TGNURmNXTGlGakJkS2JTTXRGOHRsNlR5Uy9tSFFGeHMzOWhldDhO?=
 =?utf-8?B?Z0VaRndkZGpHZS9YcTc4S1l3R0s2SFBaNDhuaWx6eVlGTTRIWHJlbmhocE5C?=
 =?utf-8?B?bndWaUhsc0lNUkUzZW42cXRNUnF4ZStVOFdGSHdnZ2hDak9QUnA3bWNSY2tZ?=
 =?utf-8?B?eVVqT3Bvc3IyTnZjeHRpd3FGczZnM25qODZUWmdSQysxaFQ5eDBsZVNHaDJN?=
 =?utf-8?B?ME9VTWhEYW85Ly9STU5zZCs2Z2gxWSthTjB3QXUxd1VTbmg4Y2tHakd0TkM1?=
 =?utf-8?B?VkMwZlg2cHkzTFgrM0dxZEd1US9DaDBscnRQTGwyZktORVM2NUQvZklObXpy?=
 =?utf-8?B?ZUtKRFFZQzlxa25yWXpIV3c0d1Jkc2JRUzdTcU9ZQjJHakhncHJGVVRPNDM3?=
 =?utf-8?B?TkpIRDJVblY4TkkzVURYZzZBMUllMDdjSnRpRCtBM3ZLMHliaXJvUy9nck1t?=
 =?utf-8?B?d0h5UEROOThjeFZJQm9WWCtMMzUrTTdyVk0zY0dyVXJ6TGNyRXlIZUpHbFc3?=
 =?utf-8?B?cVJPN1piQ3lRR1VRSnV6bU1lZTAvWlBKYTllMFBtaHA0S0JOQmZZajFFcmZu?=
 =?utf-8?B?T0JGUS9NNFVYTkFxMDRtKzRxdnUxejArMlkwdXVtQ3c1ZUN5aHpJZkpMdmhM?=
 =?utf-8?B?dTg0ZkJqWVplbVZ0a0taT3NFbzNrb0xZbVdIZi8wdGhVdDF1N0RqZUJsUWZ1?=
 =?utf-8?B?VEx3NzdENjlrUjZQcGpKV1k3WWJ5cHNpTkhCOVRHRG5rSVQ4d3d6bDFJa3ZK?=
 =?utf-8?B?Ri9zenJvVE5SZzhDUlpOSTVZcnUzbmNSQjZQNVBOOTJHT1hnTGJNQWVtVll2?=
 =?utf-8?B?S0lnbjZXQmZzWjZuSEtZbGJYRVJsQ0wyNTBtRjFPaHlac0FjRjJxNW1nL1U5?=
 =?utf-8?B?Zjc3SVM4NFRNZ0xGQVRrTHFVZStaZEdFS2xFbnZTQ1BmaWp3ZkJDVVF0dFZu?=
 =?utf-8?B?L2dhNmlIdkNrMXhwOEc0d2lycnpaWTNGcU5BYnVRQjFRay9LUHFXK2NKcGlx?=
 =?utf-8?B?TUdXSW1OVFV0T2xHVndhVnhPL0lUNUpjY2x0TEFodC83T3pIRmhsdlVXb3Nr?=
 =?utf-8?B?WXg3emVraklDRXdDdTljT0w1cFBBeXF6SllZanNmeERIMmswSDQxdlZxVjNh?=
 =?utf-8?B?eDFqTmJ1QmR0SXUxTDNua2RMV2NybWdQWi9qdmJsaS9wd2FqV0lyOTFER3RK?=
 =?utf-8?B?SjdzdlFHT0RQSHBEcFI0WHhCaXNhMVJZMGNqNU1lbFVzQ2VzRnFBMUY2am9B?=
 =?utf-8?B?QVhxS1Y0NEtxVzNLNnE5Q0tXQUN3cld0UTE2TkJ0WDhTQUxqZjZ2KzBGOHd2?=
 =?utf-8?B?WWloRFRnemRhZ2JiR015TU9oc095OEhIa3dvak1sYWdaUUdkUTFkNUFPdEhC?=
 =?utf-8?B?bGkySUVsaldhT3NPRGR5cnhHc09Ic1ZYYUNrTGJkdWptR291T2xHRkZiRUNJ?=
 =?utf-8?B?UG1UMVBnc1R2RnV2dUVsWTI3S0s4M3ArYWtINmpJa281eThraGtCUHg4Z0JC?=
 =?utf-8?B?SE1vaHh2TnJtNDNXbUZqRklma2Nub3NZbDNLWTRMRlpOcldmaGtCWXp4ZGNu?=
 =?utf-8?B?ZWRWMnk4SExSS0xlOXdBbVJXOVZsMnJURjZsY0xQcTZGVzA2Q1FPNVpsV053?=
 =?utf-8?B?WGd3WXB0aW1aeU14YVlKMjZHbEd0Zjd0T054eUhUVjFxM3pHUTV2MHN5NWh0?=
 =?utf-8?B?UGllY3BTZU1VbEJVNWZNM2dWQUpRZER4TTk3cDk0T1VIYXdZM0pXVDI1c3lO?=
 =?utf-8?B?b0ZVQnBWRTBSWWpzZ2R6d0sweTc3L29wei9tWEVPZWsvYjBnZFBVNnppdXhS?=
 =?utf-8?B?Ky9pbXdJQyswNmJtTEEzMzN4RDhIRmg0V3JwTVRsdE1WRXpZc0hkWWgzeXVr?=
 =?utf-8?B?eW15TTE4WncyOVE3aVJwdnhTaTFqT3k4UExHa3c4Y1NCN1BLMXlOK245U2ND?=
 =?utf-8?Q?/CuCi5chVXc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlEwYkRUTXpRS2t1RlF3VWpWNHpDMHRxTUpyKzIwcS9yMjJqRGE4Si85MEpE?=
 =?utf-8?B?N2VCbDNRVTkySXlwamZuTzExS0t3ZlRqdjlVanlRQURUN1hFK3JSaTRDQ3RP?=
 =?utf-8?B?aEF3Yk5ERDZCUWRFbXM1UUFpMWdTWUM1THJDY1I5YU16YmlIV3liMDNoTjJ2?=
 =?utf-8?B?LyttN2JZeEUvcUxCU2VZWEhTVmMraGJYRms1S2lmWUoyYythcUs4Nk96ak5x?=
 =?utf-8?B?TW1DeFE2SUdEQVMvMmtZK3BOeW45c2tZb1A3cytCdXFvTmVHU2kvMloxSTEy?=
 =?utf-8?B?N1VvM0hBb0V6OGRaa2JBdERZSzVqL1pobk1aV0ZuMlNmYnNNKzNOTjBMWDlr?=
 =?utf-8?B?RVI4SkNvR29KaVkyVnVZQXZ5WDhJQW85RzZQRmpWSTZUN3U5anZFOUlkelJE?=
 =?utf-8?B?UXFWMktNek53czZoQUUrcHozWXB0RUQxSmtkREdLRHNyb0hHejg4VWloa25P?=
 =?utf-8?B?YkFOMmFrWjN4aDRnT0JkZUlSamhXQjY5TkhqODVpM0FHcHhlQTdtcHlwWjdk?=
 =?utf-8?B?c1B4MVFvVWhKVXJxSWlKc3IyQXZHUEtuQnUzYWpXVmdLbGJPYmU4Ynp2KzBw?=
 =?utf-8?B?SVQvM2p2Sy9SUWc3aTYzL2ZvbWp3S2ZJQ3F0RWdjQW5kVVVocXdUamxHa2F1?=
 =?utf-8?B?TWZ5MkpKVmpGZDkvU0t3YmJ6b1BiaUw3N1k1dkFKYk9JQlFDeEVlajg1SllV?=
 =?utf-8?B?cWxTWml5aFFxNktnVGdrQ0wvMXpkUnZrV3VzWnYxMXZmcXBNaXlHZFJ5U2da?=
 =?utf-8?B?WlJqS3E4a0dkQUJYdEE4WkdKQlByYmR4Mk14Z1l6RDlPZVFodiszNUZCWmVp?=
 =?utf-8?B?S0RLRko4bkhoNE5yQWVTa0wrVm5lczVsRWZDUm8zbHRaQXNIMVNGcWVNQ0cv?=
 =?utf-8?B?bUZUOFhDTEJGRUJ4OTNmem53MlpTbjMvZmNHdk90UkVqUjNwbnRzN0t4ekNP?=
 =?utf-8?B?bVZNR0ZmZ0psWGlNVzZCRTlZbSszT3BDSm1kYi9FTHdMVi9oZ2c3dUtmbnlG?=
 =?utf-8?B?cGwvcDcxTXlWVDJZbVRTODVPVlQybjE1OVJpUGxOaVR0anFZVlhXRW1LYzZT?=
 =?utf-8?B?OC9sWjdwb1F3VThVVUtJTXlRUXV6b3J4cVAwWXI5ZVhLRFpDSC9iUmp6dVNj?=
 =?utf-8?B?VzY5VmVtMWRSeVlKSEpQWW1LSU8vVHI0QUdGcGpNaDdIZWFrOEQzK2N3V3Ju?=
 =?utf-8?B?V3AvUXFXSDdRdW1EVmpFdWR4NlVuSngyRm4rOTN2aDkwZ2JEVFZNSzlNTDBV?=
 =?utf-8?B?VWdVMFZGQVJBRjdxR3Jqb2lRdFZrYUR2UDVqaEdLWHBhTUxXQUJKTklzMmxG?=
 =?utf-8?B?MFZmb0djYVlwSGpXb0gxQ1dEUlpzR0kwMHNDQUE2cUVLbk1TbkxYUS9WS2dl?=
 =?utf-8?B?dnc4R2YvKzYwREhDWkJ2RDdmcndheXhLajlVS09haDRPdmRGVVltMDRNWk9o?=
 =?utf-8?B?ZlpsSUUwVjcza1lYNWpDSW5xelVCbWo1bUtsVzZEM2hVaDF4N212TmxLUHlt?=
 =?utf-8?B?d0tCcFgwYkRxd2xiU1dUek5LSUhHMmFZcGViczFTcHBDK25tZzdSZVpLWHlS?=
 =?utf-8?B?LzY0MklwdUxndTZkd0ZRUWZKYUdISXBUSHJ4RGxoajhKMmRoVUI1UngvcVdN?=
 =?utf-8?B?SW9QVkgwelZmTDMyVE9UTWJuc3lyLzVkaWd2WHNSdXVzTEpjN1R3Y1ZHWnAr?=
 =?utf-8?B?WkxnTExBY3ZMNlNWcmtPVkpoNjhsNEZ6MlJKZGI1ZDRSNkx5TlgwN0hTWGdp?=
 =?utf-8?B?ZG9WMmFSUkJQbHp0R0VkTU9abjBMVUkwNjB2c1lBRll2K1IvQU1RakpDRnJp?=
 =?utf-8?B?NHZuNWNMZUNXVTc1M090QURMemtmYXh4WjJWSVk3bTFQUmNwUGt0WEt4WEgy?=
 =?utf-8?B?VG04KzVIMFBpRGw1V053blpWK2E0Tjc4cGdJbENCdGVjanAwTVhwN3JDWFUr?=
 =?utf-8?B?SVdQTlh1M09LVzRpbUF3d0NKOHp2eE1mYUR1aVJ3YnZudHpWck1INlhyTzVm?=
 =?utf-8?B?bDhEdEdhOExHR3ZOcVVXUHkrUXd2UHZvaGlWdUg1YkhSc0tiU3h1SnZROFdj?=
 =?utf-8?B?elBOTld3VWlHalB0ZWJLa2lZUm9xaUlrV3dyaGEzZzRYUCtFZnRkOElZejZQ?=
 =?utf-8?B?OTQvcGQ5ZkF5bGFoVkJvemlSUWxtU0d4VndXc251U2RXdDFocnBlTlp4L1ls?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TtXChaGgzmgI/5KKafwUfEHOqxbH5mHk1V+ZYRtanMuNLbE0UDZbat3qmsgOmaEd7qUO91Eu6aZD7UXM+9dfNvbeCbSHpZV2GPB3DMevW3EN/XQ4/dMJs9q12xrA4XFiGQffThM1/0DpjhqJq/blzK0tgIbfXy+6WhQ+ChI4qtszrPh7kvRBZd22vc26y70Vjo46UZMsZCrPXqp6YsKzh1gxFHVIXohVoMKNc88jDqOyUWsPnuY3rUi0aOkC+no4V110dubMeXGO/QhVKYb6kXU2wBYZte7mxrpbMovYsZLYHuCWHSUCMrHZjqZClUFtpAqp4PoWrZTWJBe4vxySsBLij7Z/cIvIbwlyoqJiiB37exuXq5Tq0RPUEt8zqG1fqnvR6PkNDUkXpCTx9pkhNd/GTE4lfTxTnei8b2u8SegtZZEP3RVd8bL/xS5/szUZiSqxHogMSvAOusSOcQCW9dDedSZFdiOlT8Ui21xM7YeJuzaGA/piuSR+BLZlSSTCTAy42w20OmMtj7yT+9DCuyJsKEiLRSY5L2Mkd4PBmvMppdnfFLNELiX0sQGw9Lp57IgiOZXI0tMOBJQUh0KVFKzG9vrUFxS3rqQBOKRbACE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 773aa86d-5365-4b5f-eb91-08ddb97a2e3e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 15:07:37.2335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMt3WjYI4VZMWILYhfH0buSAQa6zUFFXkyYgdqlQj6HV9+kcCLK12qc8DJhfEDl3gGpR3eHioyntZU8hgMBzepMqkHyI0xDfFf5R7J8+vWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6457
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDEyNCBTYWx0ZWRfX7IFkRHspU4xj
 1MRE8Wy51iP5AfXM4XRVJDiRvcu7aGr/FyRgtdkarmu8exNEKF5+ov3ZO7HaWGTvLu2oM2BmXFG
 SA+xPMevrxDOeO/mQdCT0gV81hbjdzex+uHpiNwgCjmThlWHfaoT3S1ISMmfxEWZoitn2+3pXjv
 uEFr4nfZYnpMAOb5Xlgcfm1etC57v/8t1uqqiiMNjhpiZyXK4svmKWskYD/P8knowtNBwkcYJZH
 dhV0NAd3IgfvDIdUcNxXwn86cWfIac6PFqzNuH6jhxYUjIdw8w6pS8qPDnnshNCzGF+TBPTd7Uj
 oeN2eyCuRbRMT6RLPiJU9vQhqDTTnxSe8i/tdpx0I0UrHDKcLM/HvV+sAKseaWeo1UJtuuAfCMK
 vOzfqVbnOmfEqottRqgxlXcemCZ9n1V6i5mD72BW3Bhu/ifA+IF4IPWF7/AHXhTR8eso8rFi
X-Proofpoint-ORIG-GUID: See9CZXWU0XH3zqb4UECsYjUIQn4b_rx
X-Proofpoint-GUID: See9CZXWU0XH3zqb4UECsYjUIQn4b_rx
X-Authority-Analysis: v=2.4 cv=QfRmvtbv c=1 sm=1 tr=0 ts=68654b3c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=s3YPl9HNvKY4PzoCkmsA:9
 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/2/2025 9:39 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steven Sistare <steven.sistare@oracle.com>
>> Subject: Re: [PATCH V5 30/38] migration: vfio cpr state hook
>>
>> On 6/24/2025 7:24 AM, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>> Subject: [PATCH V5 30/38] migration: vfio cpr state hook
>>>>
>>>> Define a list of vfio devices in CPR state, in a subsection so that
>>>> older QEMU can be live updated to this version.  However, new QEMU
>>>> will not be live updateable to old QEMU.  This is acceptable because
>>>> CPR is not yet commonly used, and updates to older versions are unusual.
>>>
>>> I'm not familiar with migration, may I ask how subsection help blocking
>> migration
>>> from new to old QEMU?
>>
>> Migrating new to old will fail with an error message saying the subsection is
>> not recognized.
> 
> You mean old qemu supporting legacy container live update, migrate to new qemu supporting iommufd live update?

No, more basic.

Even with no vfio devices in the VM, qemu 10.1 will send an empty
vmstate_cpr_vfio_devices subsection, which qemu 10.0 does not recognize.
Thus live update from qemu 10.1 to qemu 10.0 will fail.
Live update from qemu 10.0 to qemu 10.1 will work.

- Steve

>>>> The contents of each device object will be defined by the vfio subsystem
>>>> in a subsequent patch.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>> include/hw/vfio/vfio-cpr.h |  1 +
>>>> include/migration/cpr.h    | 12 ++++++++++++
>>>> hw/vfio/cpr-iommufd.c      |  2 ++
>>>> hw/vfio/iommufd-stubs.c    | 18 ++++++++++++++++++
>>>> migration/cpr.c            | 14 +++++---------
>>>> hw/vfio/meson.build        |  1 +
>>>> 6 files changed, 39 insertions(+), 9 deletions(-)
>>>> create mode 100644 hw/vfio/iommufd-stubs.c
>>>>
>>>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>>>> index b9b77ae..619af07 100644
>>>> --- a/include/hw/vfio/vfio-cpr.h
>>>> +++ b/include/hw/vfio/vfio-cpr.h
>>>> @@ -74,5 +74,6 @@ void vfio_cpr_delete_vector_fd(struct
>> VFIOPCIDevice *vdev,
>>>> const char *name,
>>>>                                  int nr);
>>>>
>>>> extern const VMStateDescription vfio_cpr_pci_vmstate;
>>>> +extern const VMStateDescription vmstate_cpr_vfio_devices;
>>>>
>>>> #endif /* HW_VFIO_VFIO_CPR_H */
>>>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>>>> index 7fd8065..8fd8bfe 100644
>>>> --- a/include/migration/cpr.h
>>>> +++ b/include/migration/cpr.h
>>>> @@ -9,11 +9,23 @@
>>>> #define MIGRATION_CPR_H
>>>>
>>>> #include "qapi/qapi-types-migration.h"
>>>> +#include "qemu/queue.h"
>>>>
>>>> #define MIG_MODE_NONE           -1
>>>>
>>>> #define QEMU_CPR_FILE_MAGIC     0x51435052
>>>> #define QEMU_CPR_FILE_VERSION   0x00000001
>>>> +#define CPR_STATE "CprState"
>>>> +
>>>> +typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
>>>> +typedef QLIST_HEAD(CprVFIODeviceList, CprVFIODevice)
>> CprVFIODeviceList;
>>>> +
>>>> +typedef struct CprState {
>>>> +    CprFdList fds;
>>>> +    CprVFIODeviceList vfio_devices;
>>>> +} CprState;
>>>> +
>>>> +extern CprState cpr_state;
>>>>
>>>> void cpr_save_fd(const char *name, int id, int fd);
>>>> void cpr_delete_fd(const char *name, int id);
>>>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>>>> index 60bd7e8..3e78265 100644
>>>> --- a/hw/vfio/cpr-iommufd.c
>>>> +++ b/hw/vfio/cpr-iommufd.c
>>>> @@ -14,6 +14,8 @@
>>>> #include "system/iommufd.h"
>>>> #include "vfio-iommufd.h"
>>>>
>>>> +const VMStateDescription vmstate_cpr_vfio_devices;  /* TBD in a later
>> patch */
>>>> +
>>>> static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
>>>> {
>>>>       if (!iommufd_change_process_capable(be)) {
>>>> diff --git a/hw/vfio/iommufd-stubs.c b/hw/vfio/iommufd-stubs.c
>>>> new file mode 100644
>>>> index 0000000..0be5276
>>>> --- /dev/null
>>>> +++ b/hw/vfio/iommufd-stubs.c
>>>> @@ -0,0 +1,18 @@
>>>> +/*
>>>> + * Copyright (c) 2025 Oracle and/or its affiliates.
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "migration/cpr.h"
>>>> +#include "migration/vmstate.h"
>>>> +
>>>> +const VMStateDescription vmstate_cpr_vfio_devices = {
>>>> +    .name = CPR_STATE "/vfio devices",
>>>> +    .version_id = 1,
>>>> +    .minimum_version_id = 1,
>>>
>>> Is there difference if version_id=minimum_version_id=0?
>>
>> No.  Some developers add a new VMStateDescription starting at 0,
>> and some starting at 1.
> 
> OK.
> 
> Thanks
> Zhenzhong


