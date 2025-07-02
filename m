Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EA1C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX3BU-00065i-PK; Wed, 02 Jul 2025 15:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uX3BR-00065D-H9
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:31:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uX3BI-0002YO-61
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:31:53 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562HMsOo009960;
 Wed, 2 Jul 2025 19:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=4CDSin9N4Pdw1/n0I+5G9KNtErZzt/1QEqCJyAVqbHc=; b=
 m0b9n2orLHEB6qYDxBOhKNM65NaOSo8g8SWsJo7ypfLfdGZBuBYQaaqFkO3SFqKs
 0OaFYHzSEU0PMzRHKkvWmrOQOZ+EH4tRBZ04i2w89iWXYwgxttQ9o+mHwg5Tj7eC
 7CAV2IqWC9SCJ5r3QgMxtwSHDS7VvDbCizkLE+cVDYK6Cr8Ha24sJhThz/PBK3hw
 BawzxMNJVJSZ2ij19/gqO/XubbFzDW+/korkmUKmncXPwp8fjT+iJtjJE8TGhJV7
 9fi+w4t2Dy11+10CmYYjUL+DTDFM+FJ6uhAjXcfYh++wxtZR0CBwicCXPVWI5sg1
 D034H+pFs8bufULfP604UA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704fqtq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 19:31:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562I23uj019579; Wed, 2 Jul 2025 19:31:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubdu59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 19:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kd0ORLpSEO8D3I5/ZqKiXDp265hcUrD+mDelGbCqLK2dyufFvxg8wTDeFj0FTDJw/tv8gQzIb9EVoF90F7r/7gZk22tioGeN/GinX+DHUj1pSFMi+PTObbOktkZkDG65w0SvftS1SxUaVKkik+weoTQ3SR1BEdoA9QNRjeSFsZfQDNLXLdr2t9T1YoePTNafyhZNrgF33VZwQzCSQ7ARfWKm2eulQAsM6eCGTY5sx030HcCSIv+CbU3H4U/07MOWgu2W6zV1QBUEX5+JnkwE9gNpUil7WeSQkX2jb425eORHCFMwSaiM9CB2Budm907Vw317AbLiNlIDvErlJvcC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CDSin9N4Pdw1/n0I+5G9KNtErZzt/1QEqCJyAVqbHc=;
 b=vywo4AMxbBOusl8cIaNEwi/PgId07sxoN06G0dT+lbaIm5u1SwM2jl8foSi/rsd+tyq6MCT2gTsnkwa6N0x/tPvNWWAWvmaESDIJyLYbjvuDBX7HtpbiGSoP7aGNJEZWc/fjkk9DJa9vsLPvaVmINE7vmpx81wAhCh2mUPnRiowGTKGIq//PdMamaKMDou+zPnT1bjx8IFLbOAARbaw2PPEE5nhqKSgaY1dkEqK5d7yMLaUgEyZtT7UP5LPzgZOa9LJP3blioL5mZhV+cAMJCFilI9LYEEpNzHKvFA9o7r0tzXHIo9QllIpd5yhoXwWs93vDA8I7D8OZI0MUW6JUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CDSin9N4Pdw1/n0I+5G9KNtErZzt/1QEqCJyAVqbHc=;
 b=z1YtoV9BDElRNo1X4jzoNx8zUaiLLSO5TSsyf19aEsA7Yj9Eg9AcDDDdPcQkPuh0FkbPCAmlKwxuvgHIojNX7y4qIvS85SOzafKhuXxs7EeExrTTCoSXpC+VudxnqbIfI09HL2+eH2Tbdw4B9sNEmODDfg30uft/z87NWCj/gv4=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by MN6PR10MB8189.namprd10.prod.outlook.com (2603:10b6:208:4f8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Wed, 2 Jul
 2025 19:31:30 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%6]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 19:31:30 +0000
Message-ID: <69bc738c-90fd-4a48-9bee-bb7372388810@oracle.com>
Date: Wed, 2 Jul 2025 15:31:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
To: Markus Armbruster <armbru@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 eperezma@redhat.com, peterx@redhat.com, mst@redhat.com,
 lvivier@redhat.com, dtatulea@nvidia.com, leiyang@redhat.com,
 parav@mellanox.com, sgarzare@redhat.com, lingshan.zhu@intel.com,
 boris.ostrovsky@oracle.com, Si-Wei Liu <si-wei.liu@oracle.com>
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CACGkMEuD7n8QVpgBvHSXJv7kN-hn4cpXX9J8UO8GUCzB0Ssqaw@mail.gmail.com>
 <87plg9ukgq.fsf@pond.sub.org>
 <50a648fa-76ab-47bf-9f6e-c07da913cb52@oracle.com>
 <87frgr7mvk.fsf@pond.sub.org>
 <dcbf9e2e-9442-4439-8593-dff036a4d781@oracle.com>
 <87o6v6muq4.fsf@pond.sub.org> <8734cimtqa.fsf@pond.sub.org>
 <1e58dd8c-3418-4843-9620-3819e9ee31f3@oracle.com>
 <87o6uau2lj.fsf@pond.sub.org>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <87o6uau2lj.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH1PEPF00013307.namprd07.prod.outlook.com
 (2603:10b6:518:1::14) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|MN6PR10MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 25f61f5e-e9b0-46e9-4169-08ddb99f0b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzdqMk5oVnhMTGRpNUsxOFgrV3FHL1NSUWpPbDdlaUJyRURmMmpSMUFLVXg4?=
 =?utf-8?B?cU5uRFRVT1I2bTFKNU1tUEE5TGJ5OXNiZ1N1WlBablIvdmlMaVRtRFVPNjB6?=
 =?utf-8?B?Y09xK0VaeFIrZ29uTEFnUTEyc2V0UjRKWVVuMUwxSHBUcXZQSVRUa3VuUXMy?=
 =?utf-8?B?VlFYRnFSNDdUUkJxa2V3SW95SGJLRXNiSHFyQkhRdlU0M1V3dElqYmExQ3h4?=
 =?utf-8?B?cDNVMEdBZHVQUjVzZ0tGY0hTVkFVUnhCQ3dsaHpNeE9FM1lmazdlcXN6YVZO?=
 =?utf-8?B?TlNEY3N2elhWUjlWekFRNWFiUXduN2h6WHBYSFg2eEE0Z3NhUWJTbW8xdVFV?=
 =?utf-8?B?REJFQXlWTVh1Y2FlZUZzdWNwMUNLQ2E3YWJ2OGJLQ0xubGRHVURiSVdwcDB3?=
 =?utf-8?B?NHRJS3VlSjQ5Z1V1cHhJaC81Ym04WGV2YmpqbTE2VjBCM212MldoSjBWczUr?=
 =?utf-8?B?Wmd5cWZpck1PRm1vRThncDBYV3ZBdlQwcnRYemVFU3RGS1gvRjQxS1ZjU0ZD?=
 =?utf-8?B?WDcyL3JGT0Vwd1dQbE1SSk80ZlRFMHhyOWlvQzdvcFYyU0R0Z242UjFkNVli?=
 =?utf-8?B?L0k5QUphMlBhVHdqaUpQQXIyNzVQd2VQNVY5VEJxSmZkc25sUUZNd3ZnSmh1?=
 =?utf-8?B?OTRDeHZ0RnJCZWJWVkpWcjN3RGU4UUpremZ2L0hzOVZsTDJic2lFZmtmMjZU?=
 =?utf-8?B?YVNIWXlsbzNEc1FRMlJOdktJYStQNFdPNW44eUxlK2s5U1hCUWdERDZHWmNE?=
 =?utf-8?B?R1YwSHNHSThvRU9XeGZXWDVPeVhhcVpJcnJLdU5DUWxYSnVQRWF4TWRoQ2R3?=
 =?utf-8?B?bmhYaHZta29FMFRMb0ZnOVk3c0JSNWROMXB3QWpFSFlmWGpuRWlNMkVQempV?=
 =?utf-8?B?V2ljdXpOb1hBL2xPUm9BYXFBaFdZTDlTdHhOZ05Cdk53MDZuZ0Rjc2hKcnJN?=
 =?utf-8?B?ZUhvNHdheXNvTWlpa1UwVVFMc0R3VnVYQlVTcTNPMk9sSXhKRVd5bm5BWnhx?=
 =?utf-8?B?b1ErdCtpa2dFVnUvZ3daNkMzQ0Q4cXlzam9wOGlhaG9pQzYwN2lYRFRDeHJR?=
 =?utf-8?B?ZjUvai9wZ1FRZXRFL0N4d21SRW51cjdjT1lsQ2Q2c2hMN0xDUEFWYjNiRDRm?=
 =?utf-8?B?ZVcvNjFDbzRaRmpFc1ZsNGI4S3NNR2M5OGRRU1QxQzJBOFYwRkVpZnd5NHJD?=
 =?utf-8?B?SUd2K0t6NFlxcVNsbk9jcEZ3MmUwTU1GR3FtS0NSUEZmTDRvQkNxUzdFQ2po?=
 =?utf-8?B?c3d5QmFOQ3FQWEpsNXFrYnBXVDlJcjA1U2R2UmdhR2YzQ2FhNDU1NEF4YjRI?=
 =?utf-8?B?bUJkMi9sVHlXemg5dXRVbTFHTEdySllMT0szL2dzdWxkeVJvTXk2eFBheHRO?=
 =?utf-8?B?NG4veXdJSXZtczUvVjRYUUdUUWZWQ0pBZGNGemRrdWh3aFM3YVl3Q29vNkF5?=
 =?utf-8?B?STl6aTlxSFF2WVZIM0R6RWUrQkZXeE1wSllxZ3hMSDU2QjBWNlFVOFZRMlNG?=
 =?utf-8?B?U2FybHdsaW5TaHF1Zkxac3htQThuTmhCM1lJMEFNeWxrdzl0OHRoVVJJaFc3?=
 =?utf-8?B?T1lmYUdIRi9RaTJFaitsVE9zT1JnR0VWZXZWTHpNekg2VG9OZUdpeHdCKy9I?=
 =?utf-8?B?VGxFaVg0aWJGRnRXdmg3OFNqSnQ3SStRaTdBTmpla2gzdGJiSHN0aGNxQ0Zk?=
 =?utf-8?B?MUREdkJoSHMreXNYYkZGNWtERXZqcktTVUFyRjNZU0NsTWk1NUZrTjAvSlI2?=
 =?utf-8?B?VXVXYVg3V3JRNGxESTNCUVBicVVlNXB5b0xTS0lmVVNmL253ZDlKNUQ1eXdm?=
 =?utf-8?B?dEJCeFJYM3B4WDZCZWUrUzZsNHpwaGI1WGNKbWtjRUMyaklhaTNiOGlXUjds?=
 =?utf-8?B?UEtVUSs1OUFwRWdMV294dG9weVFMVnRmTTMvemdEMUFVVzBETVFUVHQ4MnRa?=
 =?utf-8?Q?fkg4TFeaP3c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlBVQUpzNkdjTEl3RUNlZC9YTXl4cGo0Z0o5R0VPYmVUQ2JOUW9nak1tMy9E?=
 =?utf-8?B?b0Fpb0NrcjV2QmhQc2ZGLzNUSFFENTVxK0Q1UHlwRkh2RTY4UnloOTRxbEtj?=
 =?utf-8?B?QldxaC9Ra0oxWEdSVXVEN2dtRTdUaGhhMWRJUVpRNWE3dnN3amdhTy9aMW04?=
 =?utf-8?B?UFhQeDFQb0tabWhZSU1TYmVMdzY2bm11SzhHMDlpako2N1VJaTluWkNHeGR4?=
 =?utf-8?B?dmp5MVdrUkFPUitPbG1zN3B5ZjFJZTNZNnN4UWZrTCtjRVdyV3NsZG5uTnhC?=
 =?utf-8?B?U0E0VExDam8rbzVoQWJqQ1ltNWJ5SFR2Q1RCRklOalBLOThQcjZKUHUvOTBT?=
 =?utf-8?B?M3hrWU83K0NlQ0FiYzIvaTEwcDdYV0NwRWFueERTdGNYRzc2MWxqWTAydUN3?=
 =?utf-8?B?eFNCK21ONllLaDVzOWNBRzlRZjZ1Q3hiWlVldTdoV3M2MXFEbFcwZ3ljdG9Z?=
 =?utf-8?B?ZzF6OGt0TGJZVzBqVmRKWDh0Qmo2RzhKb083dGtGNE5mRk9lVWh4WWt0aFc3?=
 =?utf-8?B?cVdMZ1paUFk2M2Q4Y2VGaFlXOGdDd05sbzluUUZSNzNNanYwbU1OanZjYzg3?=
 =?utf-8?B?LzVKWDU0UVA3ZStlWXpPYzduTCtiOVhxbysvQ21NU1J3NElhR1BYTG1pQVFI?=
 =?utf-8?B?RDVNSVJGdzZwWVo0cVFYcTlibnE3SlNGclJCbk9iYWlOd3FHY0Z6OXI4NEMr?=
 =?utf-8?B?ZFllaHg2UkFFejNDUENhZitxU0pPbVBxbElIVGFlcENYTEpiRWJOZVFManRw?=
 =?utf-8?B?cWtNOTJ2dGtETnRPZnVJNGEwU24yTEptS1JFdVIzN1BDN09Udkw5YzFVQ0lP?=
 =?utf-8?B?UVZFNFBRZ2NScHYwUnNBRXRyc0pTQmdWMGdLRXp1ZE1IVHZnclR6TFhaaGs5?=
 =?utf-8?B?b3JiNitSY0VSdHVxNjdUNjR1Nlo1OUVCcTEwZk5zZEo5VWJXMzMvTEF3akdW?=
 =?utf-8?B?K0UyaTd1SmZaSHRoeTByajR2UVl6cVRtZkdhc1QwQlByRGIwdC9jb2hFd0Zo?=
 =?utf-8?B?T25MVlBhVGdyVU1Zczl6cHhDTkFGZlVWNng2allFNE1iRDAwL294dWJUNDhk?=
 =?utf-8?B?WjRCcUlpa1hFQzhrSDErWWNsSlF1RmJJS205WjdGaUN5S0dnbytXaVV1ZkZT?=
 =?utf-8?B?L3BWUXBEdFluS2ZaUHAyRmlHdENESUtrNVpFRnRTRkZiM25LUFVuOTJvOWYz?=
 =?utf-8?B?RXNEUmpCSjZnODV6MlYxQUNkWldURnJrOFRLY1o3K1ZEdFlkSjlUMVVYTDA1?=
 =?utf-8?B?UEpURWhaOUZybkV2eFVkZTBGdm44enlGWndzWURTSTZIVDdMOFRFSDF1a2J5?=
 =?utf-8?B?V0MrbFRrY2ZDNG83WnRuM1pzNS9jOHZQZzAvc1lEaEx3ZlpMQVhnbUEzM1Ny?=
 =?utf-8?B?S3NHa3lyR2xmRU1hZ1plbG0zMlZRTE1jK1YwN0FXQWVNcVRZTVFoM1pGWnJI?=
 =?utf-8?B?bFJwU01LY3p1blFnd1cwQjhKQzFjMXMxT1gxQXZwSEkvMHlwaCtTMkc0SU5j?=
 =?utf-8?B?N1NnSkQrVkI3TTBCcEF5SUtHeUk0SFFlRklncGhud0ZGUEpYci9ZMDJiNG1E?=
 =?utf-8?B?NExtcEM0S0o0ZTNXbFU2MS9SazkxeEt5dnJRSG9USFZYeG5jUTE1N1E3cnda?=
 =?utf-8?B?TnFHN21WNFpldEx4RVBteU9sNTArcVpnKzZvdG5qM1hBWFVRUnVEdEw4K0lG?=
 =?utf-8?B?MlVoMWpoc0FPdTVkOUpXUjE4UDZpWUlqS2d1YTdMN21CdGRGTGFacS9pODZr?=
 =?utf-8?B?cVpWQ0NXQWYvOVJMWGZ0cXY4dnNhN2VxbVBTOG9MNEZyejJCYlVYQi9Ccjgz?=
 =?utf-8?B?aVlLc25rdTVCN041VkMwQlVpQVR2UWNyWklBaHJnVlhKN3VCejJodlh6S3F4?=
 =?utf-8?B?RndwUjVLR3dhRHlPU1oyaHZxNFJEMlJEaDJ3S3htNmpsSFZkWE9EbzRGUkpq?=
 =?utf-8?B?cmYwZGJKRGMvWXJaa2xTOC9MN0Y2VVpPT1NPNzBrZWdiM00xbFN1c1lFSVFz?=
 =?utf-8?B?QzNSWEZuUXRwQWJpMHlzM1NaQUFNTVd4OWNMRXByUVlLMlhqVlFuRDVOaGMx?=
 =?utf-8?B?eU5CbDlaWGRZdFJnSUcvUXUxcmkrTVcyR3pEZHRlNE5hbGREVmVoMFdZRmNL?=
 =?utf-8?Q?lSnZpL3pwacwgqXulrOCIQB16?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b8raHTKQxAl7D0jHw+qzAXbmNA70qcfBWiup33PPKrSktHvDVfzzHgbzJKtQDepTpqjbPJjckj9uCEUDAEx8+6hAcKUYDEoZhh9B/LiI2LXHQxNyBvbdzXVagqDUYWAwtg+rfGp2VahcqQPXHGh++uPPsmgwRtN9bOO/o/l1I6qliWgRnkgN3oTa+dumR+EFC7Vz4f5TaJmIyNg39NtL4LI6EBmELyPu1RczbUzDjobEktkyykUdGMNcD6fwZRbr+cAXoiIhNHhji0bIHt0u2Lv7gRZZOjQSMIJzUp2tIvMp3Spx9NrBcZ4oyae81P0G54YiruFzqdkkOax36gkZAN06zjv4HivyF5aW2u8o6Un97u73Oi755Q3FeU/t3t7TgCQH6iKZXk4aM4xUl/u5jvWQqn6ntudahePSzZ0UeccN7URJpInv1F9fzLf+JUljllDuR9vhqonl0f3wGxpteMPkRM4/yL0A7vS8zaVsqREyNzL9qyjB7N3eitgqTROWKhlTKaGLufw83OUHWUDtfGS9ZraTHw1QZgEHGXjmhxR0hAxdrqeF0MGEs/dwEi4dRQVIMpFrvUd0Z5HikogjwyjEncuzYkHPp5P2vq/YKfo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f61f5e-e9b0-46e9-4169-08ddb99f0b70
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 19:31:30.3449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hk1VX9SZy7M17ZSc0ryYIwyy5MU5SGMox+YAcHDHYrXVmS9BHPpD4YrPsknUCG6c7j6OcLaoSqVmZDWEOxi+7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020160
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE2MCBTYWx0ZWRfX/xkspEWagrmo
 af5FUEvg1ndTF/L4soOmpmqieGGOo51kr/EMG+IRLvdeIEFL/sRJuaGtefWu//bjagJKB2/Kycm
 29x0IRJ09G9xxm95KckJeBPd9S0RnwoCIrxsL2BnpbarOoSJsxyjECBaDRmsB2Jt40jJqG9bAhF
 gTMX3Wkjmk7xoaz5zRfHF4Wr9iEZaZp+tkgC7dBM36GSvmIdYrx9UA5kwcuY5d1uA/yHHSfpILL
 Ul0MId2urMPIpB8WcOuPq1wIJKXCmn+jjhnOoFyXR2T/HHSgIE+e/VSqW+ekdPzVWV0ET8Xo9NY
 UrPcw/vw4qQY9s9YOYTjIweUrY0SF7UHPXnbx+EpKEvYMb3GmdEf83gA6NCa2yZIuqa9pLRxLmd
 GCWogFouL2qLO4PUU693m4BL3Z2K3My0C03ym5woVTKoWxU3cTVvYgcmdrlH2DUhDeEUeqRw
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=68658916 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=7vThU928YTnAr7tPiL4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: h6_dDr4BzjNTXogWpPsvOekLfWS3zcmd
X-Proofpoint-ORIG-GUID: h6_dDr4BzjNTXogWpPsvOekLfWS3zcmd
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 6/26/25 8:08 AM, Markus Armbruster wrote:
> Jonah Palmer <jonah.palmer@oracle.com> writes:
> 
>> On 6/2/25 4:29 AM, Markus Armbruster wrote:
>>> Butterfingers...  let's try this again.
>>>
>>> Markus Armbruster<armbru@redhat.com> writes:
>>>
>>>> Si-Wei Liu<si-wei.liu@oracle.com> writes:
>>>>
>>>>> On 5/26/2025 2:16 AM, Markus Armbruster wrote:
>>>>>> Si-Wei Liu<si-wei.liu@oracle.com> writes:
>>>>>>
>>>>>>> On 5/15/2025 11:40 PM, Markus Armbruster wrote:
>>>>>>>> Jason Wang<jasowang@redhat.com> writes:
>>>>>>>>
>>>>>>>>> On Thu, May 8, 2025 at 2:47 AM Jonah Palmer<jonah.palmer@oracle.com> wrote:
>>>>>>>>>> Current memory operations like pinning may take a lot of time at the
>>>>>>>>>> destination.  Currently they are done after the source of the migration is
>>>>>>>>>> stopped, and before the workload is resumed at the destination.  This is a
>>>>>>>>>> period where neigher traffic can flow, nor the VM workload can continue
>>>>>>>>>> (downtime).
>>>>>>>>>>
>>>>>>>>>> We can do better as we know the memory layout of the guest RAM at the
>>>>>>>>>> destination from the moment that all devices are initializaed.  So
>>>>>>>>>> moving that operation allows QEMU to communicate the kernel the maps
>>>>>>>>>> while the workload is still running in the source, so Linux can start
>>>>>>>>>> mapping them.
>>>>>>>>>>
>>>>>>>>>> As a small drawback, there is a time in the initialization where QEMU
>>>>>>>>>> cannot respond to QMP etc.  By some testing, this time is about
>>>>>>>>>> 0.2seconds.
>>>>>>>>> Adding Markus to see if this is a real problem or not.
>>>>>>>> I guess the answer is "depends", and to get a more useful one, we need
>>>>>>>> more information.
>>>>>>>>
>>>>>>>> When all you care is time from executing qemu-system-FOO to guest
>>>>>>>> finish booting, and the guest takes 10s to boot, then an extra 0.2s
>>>>>>>> won't matter much.
>>>>>>> There's no such delay of an extra 0.2s or higher per se, it's just shifting around the page pinning hiccup, no matter it is 0.2s or something else, from the time of guest booting up to before guest is booted. This saves back guest boot time or start up delay, but in turn the same delay effectively will be charged to VM launch time. We follow the same model with VFIO, which would see the same hiccup during launch (at an early stage where no real mgmt software would care about).
>>>>>>>
>>>>>>>> When a management application runs qemu-system-FOO several times to
>>>>>>>> probe its capabilities via QMP, then even milliseconds can hurt.
>>>>>>>>
>>>>>>> Not something like that, this page pinning hiccup is one time only that occurs in the very early stage when launching QEMU, i.e. there's no consistent delay every time when QMP is called. The delay in QMP response at that very point depends on how much memory the VM has, but this is just specif to VM with VFIO or vDPA devices that have to pin memory for DMA. Having said, there's no extra delay at all if QEMU args has no vDPA device assignment, on the other hand, there's same delay or QMP hiccup when VFIO is around in QEMU args.
>>>>>>>
>>>>>>>> In what scenarios exactly is QMP delayed?
>>>>>>> Having said, this is not a new problem to QEMU in particular, this QMP delay is not peculiar, it's existent on VFIO as well.
>>>>>>
>>>>>> In what scenarios exactly is QMP delayed compared to before the patch?
>>>>>
>>>>> The page pinning process now runs in a pretty early phase at
>>>>> qemu_init() e.g. machine_run_board_init(),
>>>>
>>>> It runs within
>>>>
>>>>       qemu_init()
>>>>           qmp_x_exit_preconfig()
>>>>               qemu_init_board()
>>>>                   machine_run_board_init()
>>>>
>>>> Except when --preconfig is given, it instead runs within QMP command
>>>> x-exit-preconfig.
>>>>
>>>> Correct?
>>>>
>>>>> before any QMP command can be serviced, the latter of which typically
>>>>> would be able to get run from qemu_main_loop() until the AIO gets
>>>>> chance to be started to get polled and dispatched to bh.
>>>>
>>>> We create the QMP monitor within qemu_create_late_backends(), which runs
>>>> before qmp_x_exit_preconfig(), but commands get processed only in the
>>>> main loop, which we enter later.
>>>>
>>>> Correct?
>>>>
>>>>> Technically it's not a real delay for specific QMP command, but rather
>>>>> an extended span of initialization process may take place before the
>>>>> very first QMP request, usually qmp_capabilities, will be
>>>>> serviced. It's natural for mgmt software to expect initialization
>>>>> delay for the first qmp_capabilities response if it has to immediately
>>>>> issue one after launching qemu, especially when you have a large guest
>>>>> with hundred GBs of memory and with passthrough device that has to pin
>>>>> memory for DMA e.g. VFIO, the delayed effect from the QEMU
>>>>> initialization process is very visible too.
>>>
>>> The work clearly needs to be done.  Whether it needs to be blocking
>>> other things is less clear.
>>>
>>> Even if it doesn't need to be blocking, we may choose not to avoid
>>> blocking for now.  That should be an informed decision, though.
>>>
>>> All I'm trying to do here is understand the tradeoffs, so I can give
>>> useful advice.
>>>
>>>>>                                               On the other hand, before
>>>>> the patch, if memory happens to be in the middle of being pinned, any
>>>>> ongoing QMP can't be serviced by the QEMU main loop, either.
>>>
>>> When exactly does this pinning happen before the patch?  In which
>>> function?
>>
>> Before the patches, the memory listener was registered in
>> vhost_vdpa_dev_start(), well after device initialization.
>>
>> And by device initialization here I mean the
>> qemu_create_late_backends() function.
>>
>> With these patches, the memory listener is now being
>> registered in vhost_vdpa_set_owner(), called from
>> vhost_dev_init(), which is part of the device
>> initialization phase.
>>
>> However, even though the memory_listener_register() is
>> called during the device initialization phase, the actual
>> pinning happens (very shortly) after
>> qemu_create_late_backends() returns (due to RAM being
>> initialized later).
>>
>> ---
>>
>> So, without these patches, and based on my measurements,
>> memory pinning starts ~2.9s after qemu_create_late_backends()
>> returns.
>>
>> With these patches, memory pinning starts ~0.003s after
>> qemu_create_late_backends() returns.
> 
> So, we're registering the memory listener earlier, which makes it do its
> expensive work (pinning) earlier ("very shortly after
> qemu_create_late_backends()).  I still don't understand where exactly
> the pinning happens (where at runtime and where in the code).  Not sure
> I have to.
> 

Apologies for the delay in getting back to you. I just wanted to be 
thorough and answer everything as accurately and clearly as possible.

----

Before these patches, pinning started in vhost_vdpa_dev_start(), where 
the memory listener was registered, and began calling 
vhost_vdpa_listener_region_add() to invoke the actual memory pinning. 
This happens after entering qemu_main_loop().

After these patches, pinning started in vhost_dev_init() (specifically 
vhost_vdpa_set_owner()), where the memory listener registration was 
moved to. This happens *before* entering qemu_main_loop().

However, the entirety of pinning doesn't all happen pre 
qemu_main_loop(). The pinning that happens before we enter 
qemu_main_loop() is the full guest RAM pinning, which is the main, heavy 
lifting work when it comes to pinning memory.

The rest of the pinning work happens after entering qemu_main_loop() 
(approximately around the same timing as when pinning started before 
these patches). But, since we already did the heavy lifting of the 
pinning work pre qemu_main_loop() (e.g. all pages were already allocated 
and pinned), we're just re-pinning here (i.e. kernel just updates its 
IOTLB tables for pages that're already mapped and locked in RAM).

This makes the pinning work we do after entering qemu_main_loop() much 
faster than compared to the same pinning we had to do before these patches.

However, we have to pay a cost for this. Because we do the heavy lifting 
work earlier pre qemu_main_loop(), we're pinning with cold memory. That 
is, the guest hasn't yet touched its memory yet, all host pages are 
still anonymous and unallocated. This essentially means that doing the 
pinning earlier is more expensive time-wise given that we need to also 
allocate physical pages for each chunk of memory.

To (hopefully) show this more clearly, I ran some tests before and after 
these patches and averaged the results. I used a 50G guest with real 
vDPA hardware (Mellanox CX-6Dx):

0.) How many vhost_vdpa_listener_region_add() (pins) calls?

                | Total | Before qemu_main_loop | After qemu_main_loop
_____________________________________________________________________
Before patches |   6   |         0             |         6
---------------|-----------------------------------------------------
After patches  |   11  |         5	       |         6

- After the patches, this looks like we doubled the work we're doing 
(given the extra 5 calls), however, the 6 calls that happen after 
entering qemu_main_loop() are essentially replays of the first 5 we did.

  * In other words, after the patches, the 6 calls made after entering 
qemu_main_loop() are performed much faster than the same 6 calls before 
the patches.

  * From my measurements, these are the timings it took to perform those 
6 calls after entering qemu_main_loop():
    > Before patches: 0.0770s
    > After patches:  0.0065s

---

1.) Time from starting the guest to entering qemu_main_loop():
  * Before patches: 0.112s
  * After patches:  3.900s

- This is due to the 5 early pins we're doing now with these patches, 
whereas before we never did any pinning work at all.

- From measuring the time between the first and last 
vhost_vdpa_listener_region_add() calls during this period, this comes 
out to ~3s for the early pinning.

>>>>> I'd also like to highlight that without this patch, the pretty high
>>>>> delay due to page pinning is even visible to the guest in addition to
>>>>> just QMP delay, which largely affected guest boot time with vDPA
>>>>> device already. It is long standing, and every VM user with vDPA
>>>>> device would like to avoid such high delay for the first boot, which
>>>>> is not seen with similar device e.g. VFIO passthrough.
>>>
>>> I understand that hiding the delay from the guest could be useful.
>>>
>>>>>>> Thanks,
>>>>>>> -Siwei
>>>>>>>
>>>>>>>> You told us an absolute delay you observed.  What's the relative delay,
>>>>>>>> i.e. what's the delay with and without these patches?
>>>>>>
>>>>>> Can you answer this question?
>>>>>
>>>>> I thought I already got that answered in earlier reply. The relative
>>>>> delay is subject to the size of memory. Usually mgmt software won't be
>>>>> able to notice, unless the guest has more than 100GB of THP memory to
>>>>> pin, for DMA or whatever reason.
>>>
>>> Alright, what are the delays you observe with and without these patches
>>> for three test cases that pin 50 / 100 / 200 GiB of THP memory
>>> respectively?
>>
>> So with THP memory specifically, these are my measurements below.
>> For these measurements, I simply started up a guest, traced the
>> vhost_vdpa_listener_region_add() calls, and found the difference
>> in time between the first and last calls. In other words, this is
>> roughly the time it took to pin all of guest memory. I did 5 runs
>> for each memory size:
>>
>> Before patches:
>> ===============
>> 50G:   7.652s,  7.992s,  7.981s,  7.631s,  7.953s (Avg.  7.841s)
>> 100G:  8.990s,  8.656s,  9.003s,  8.683s,  8.669s (Avg.  8.800s)
>> 200G: 10.705s, 10.841s, 10.816s, 10.772s, 10.818s (Avg. 10.790s)
>>
>> After patches:
>> ==============
>> 50G:  12.091s, 11.685s, 11.626s, 11.952s, 11.656s (Avg. 11.802s)
>> 100G: 14.121s, 14.079s, 13.700s, 14.023s, 14.130s (Avg. 14.010s)
>> 200G: 18.134s, 18.350s, 18.387s, 17.800s, 18.401s (Avg. 18.214s)
>>
>> The reason we're seeing a jump here may be that with the memory
>> pinning happening earlier, the pinning happens before Qemu has
>> fully faulted in the guest's RAM.
>>
>> As far as I understand, before these patches, by the time we
>> reached vhost_vdpa_dev_start(), all pages were already resident
>> (and THP splits already happened with the prealloc=on step), so
>> get_user_pages() pinned "warm" pages much faster.
>>
>> With these patches, the memory listener is running on cold memory.
>> Every get_user_pages() call would fault in its 4KiB subpage (and
>> if THP was folded, split a 2MiB hugepage) before handing in a
>> 'struct page'.
> 
> Let's see whether I understand...  Please correct my mistakes.
> 
> Memory pinning takes several seconds for large guests.
> 
> Your patch makes pinning much slower.  You're theorizing this is because
> pinning cold memory is slower than pinning warm memory.
> 
> I suppose the extra time is saved elsewhere, i.e. the entire startup
> time remains roughly the same.  Have you verified this experimentally?
> 

Based on my measurements that I did, we pay a ~3s increase in 
initialization time (pre qemu_main_loop()) to handle the heavy lifting 
of the memory pinning earlier for a vhost-vDPA device. This resulted in:

* Faster memory pinning during qemu_main_loop() (0.0770s vs 0.0065s).

* Shorter downtime phase during live migration (see below).

* Slight increase in time for the device to be operational (e.g. guest 
sets DRIVER_OK).
   > This measured the start time of the guest to guest setting 
DRIVER_OK for the device:

     Before patches: 22.46s
     After patches:  23.40s

The real timesaver here is the guest-visisble downtime during live 
migration (when using a vhost-vDPA device). Since the heavy lifting of 
the memory pinning is done during the initialization phase, it's no 
longer included as part of the stop-and-copy phase, which results in a 
much shorter guest-visible downtime.

 From v5's CV:

Using ConnectX-6 Dx (MLX5) NICs in vhost-vDPA mode with 8 queue-pairs,
the series reduces guest-visible downtime during back-to-back live
migrations by more than half:
- 39G VM:   4.72s -> 2.09s (-2.63s, ~56% improvement)
- 128G VM:  14.72s -> 5.83s (-8.89s, ~60% improvement)

Essentially, we pay a slight increased startup time tax to buy ourselves 
a much shorter downtime window when we want to perform a live migration 
with a vhost-vDPA networking device.

> Your stated reason for moving the pinning is moving it from within
> migration downtime to before migration downtime.  I understand why
> that's useful.
> 
> You mentioned "a small drawback [...] a time in the initialization where
> QEMU cannot respond to QMP".  Here's what I've been trying to figure out
> about this drawback since the beginning:
> 
> * Under what circumstances is QMP responsiveness affected?  I *guess*
>    it's only when we start a guest with plenty of memory and a certain
>    vhost-vdpa configuration.  What configuration exactly?
> 

Regardless of these patches, as I understand it, QMP cannot actually run 
any command that requires the BQL while we're pinning memory (memory 
pinning needs to use the lock).

However, the BQL is not held during the entirety of the pinning process. 
That is, it's periodically released throughout the entire pinning 
process. But those windows are *very* short and are only caught if 
you're really hammering QMP with commands very rapidly.

 From a realistic point of view, it's more practical to think of QMP 
being fully ready once all pinning has finished, e.g. 
time_spent_memory_pinning ≈ time_QMP_is_blocked.

---

As I understand it, QMP is not fully ready and cannot service requests 
until early on in qemu_main_loop().

Given that these patches increase the time it takes to reach 
qemu_main_loop() (due to the early pinning work), this means that QMP 
will also be delayed for this time.

I created a test that hammers QMP with commands until it's able to 
properly service the request and recorded how long it took from guest 
start to when it was able to fulfill the request:
  * Before patches: 0.167s
  * After patches:  4.080s

This aligns with time measured to reach qemu_main_loop() and the time 
we're spending doing the early memory pinning.

All in all, the larger the amount of memory we need to pin, the longer 
it will take for us to reach qemu_main_loop(), the larger 
time_spent_memory_pinning will be, and thus the longer it will take for 
QMP to be ready and fully functional.

----

I don't believe this related to any specific vhost-vDPA configuration. I 
think bottom line is that if we're using a vhost-vDPA device, we'll be 
spending more time to reach qemu_main_loop(), so QMP has to wait until 
we get there.

> * How is QMP responsiveness affected?  Delay until the QMP greeting is
>    sent?  Delay until the first command gets processed?  Delay at some
>    later time?
> 

Responsiveness: Longer initial delay due to early pinning work we need 
to do before we can bring QMP up.

Greeting delay: No greeting delay. Greeting is flushed earlier, even 
before we start the early pinning work.

* For both before and after the patches, this was ~0.052s for me.

Delay until first command processed: Longer initial delay at startup.

Delay at later time: None.

> * What's the absolute and the relative time of QMP non-responsiveness?
>    0.2s were mentioned.  I'm looking for something like "when we're not
>    pinning, it takes 0.8s until the first QMP command is processed, and
>    when we are, it takes 1.0s".
> 

The numbers below are based on my recent testing and measurements. This 
was with a 50G guest with real vDPA hardware.

Before patches:
---------------
* From the start time of the guest to the earliest time QMP is able to 
process a request (e.g. query-status): 0.167s.
   > This timing is pretty much the same regardless of whether or not 
we're pinning memory.

* Time spent pinning memory (QMP cannot handle requests during this 
window): 0.077s.

After patches:
--------------
* From the start time of the guest to the earliest time QMP is able to 
process a request (e.g. query-status): 4.08s
   > If we're not early pinning memory, it's ~0.167s.

* Time spent pinning memory *after entering qemu_main_loop()* (QMP 
cannot handle requests during this window): 0.0065s.

>> I believe this to be the case since in my measurements I noticed
>> some larger time gaps (fault + split overhead) in between some of
>> the vhost_vdpa_listener_region_add() calls.
>>
>> However I'm still learning some of these memory pinning details,
>> so please let me know if I'm misunderstanding anything here.
> 
> Thank you!
> 
> [...]
> 


