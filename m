Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB79E7DEF2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 15:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmvgd-0002NN-6t; Mon, 02 Feb 2026 10:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vmvgN-0002G2-A5
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:17:49 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vmvgK-0000L4-8p
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:17:42 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6128uXlr698628; Mon, 2 Feb 2026 15:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=il5XD1a4Flb6qfZi+W3eobuStvN3yeH4h7JUiyKP0Zs=; b=
 PSqlYq3qkFE+8EJH6NvtUpUqSvJOIlt33ppZji53W3VLrsRsGFezHM2r8GpfGBqW
 WaOVfAUvcSRHREM0R+q0eGHqYTXBGCxaDi1P8MFSH+VmmcWeZc9ZdNuVVFnmdwo7
 gMKC6nxZ/OLCF7Crc7P0Nd1TDXx0PBlZ9Tl/GLzWbgMJ4AoM+j+CtjcFq70J3Nnn
 vIJQfl464EZkTojoPNreHy7c+hWjRXaDrh04Xc6PRjvsY0vKRfdOCFdE8Q98Jwy5
 dxyEn5CAlSa//dAE/lk6kz7Js7I/bbz16+WKqFjN5YBX2zFm8LgciWUBSg/0KX5C
 rgRhoHsKBjBWLnHjdrDvaw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1axe2d8b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Feb 2026 15:17:29 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 612EthpL001397; Mon, 2 Feb 2026 15:17:28 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012055.outbound.protection.outlook.com
 [40.107.200.55])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4c1868hmkx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Feb 2026 15:17:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEEUOQwblzE5pD7LGbSDm4Hvt9QpjDcRAMhoGgTk8vWDdPB7yIIaVLfnsdSYw8Tr4l9ZlKLavnugUacjBpaX0oOS4NHgbwYbAI1vvAulhjik9RfP+TFiEvnBijMpc3rd7trUFu53USijYr7x79aQ9oM0QPY124yEf0u8UcuYdPm4q5qeDtGYAKw/edaIBKvfZ+yQdJYSKo+KM55T4dobG4C50ezq2C490PgNu8/JkvbIKFuNWQd4CQgLBxoMdd63I6xHUyuVbc+PVC2MZQZ7RfxMLGEBokAjdYPK3BJqtjXGt2HOCB5XDuMCwTugLisBCZZzdCNOLFoNGPuT4lAqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=il5XD1a4Flb6qfZi+W3eobuStvN3yeH4h7JUiyKP0Zs=;
 b=VQyqIIyDWZ30ZfeLd1kLcE8SNsh5RCISyaB/0zom82GKNjPnOGs3FEgjImtXyvE3+WJGlXrBQ/jCepaHrwlhGgP9Bpl0pkaZvsASA/eKYGqlZCuDvgKWaunJg4PTcsfsUbWiAGSyp6BOdnpCmH8slT6zsQy9Y+7ch1JgFvTb27dAx2NBf4rnXThmaxHTO7EUoe0eneHSUFPmPDv9xnaFsT+nrK08E7zzJHyVqy4ssMEADa2v8G4BnGftC35DXBW7WPRg4AXv1qQp78Dp5Bdcuoc7fmzq0KTgOfhEwhNtOAtMIuAyVNrUVgOy9UKdsOZ8Fsbnq3s4yO/n/0OkmHNZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=il5XD1a4Flb6qfZi+W3eobuStvN3yeH4h7JUiyKP0Zs=;
 b=U/8r+k8z7y6yxcOEPJqEGaEMb9IX+LPCmzUdeRzjZZh/m/hNuBFZ4yzqIdfUf5RBV9AVcZqDROEEH7W6SyKJAqqEcDfTp1AhDz/97KX8/87TkoY7WwqeTXsfBkh1TXRJ+k+ZZbmOci4uzYL79dyiwqB3gKk25h35focEcZXxf8U=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by DS4PPF80E5E852F.namprd10.prod.outlook.com (2603:10b6:f:fc00::d2e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 15:17:24 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 15:17:23 +0000
Message-ID: <0edcc43c-ac6a-4407-867a-4240982f49ec@oracle.com>
Date: Mon, 2 Feb 2026 10:17:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] amd_iommu: Use switch case to determine mmio
 register name
To: Sairaj Kodilkar <sarunkod@amd.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "mst@redhat.com"
 <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>
References: <20260129102814.4488-1-sarunkod@amd.com>
 <20260129102814.4488-2-sarunkod@amd.com>
 <85c7506f677e3a9145eb8be2212ee62c0b92169e.camel@eviden.com>
 <df3b9d64-b47c-48e7-a368-715a74989cfa@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <df3b9d64-b47c-48e7-a368-715a74989cfa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|DS4PPF80E5E852F:EE_
X-MS-Office365-Filtering-Correlation-Id: 59369f06-b08d-4ba2-e42d-08de626e2acd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGlRMkc3R2xRTUhBQkduYmx2aHNQbXczS2dwT0JrTHpWWGg5bXgyZ2I4eXBN?=
 =?utf-8?B?V2ZLZjhJeHdwaUhlN09qRmdBRFZwSHZBM3pTVmZvRUdPZmNidTlIbEdQeSt1?=
 =?utf-8?B?cDdWdnZyZjgxTWVnSFhjUS9qUzNFYWZjcERUR0NRN2lEdG5ZbWlIcVN1eEl4?=
 =?utf-8?B?WW0vZS8yWThMS2tic09Qb0ovcWVKZWU5MW5qVytzekxVbXZjc1FjS1JOTnli?=
 =?utf-8?B?RXpnTWZoRXpENk5hOWNCZFBkck44MVREdUpmek9QdGhxM0pyQVh3N3B0RWxF?=
 =?utf-8?B?KzFrNVRwYkRBbVlQS20xRUQ3cHhrR2s2N2dCdCtkelUzT2p1RWNNMTBFQ2lw?=
 =?utf-8?B?SEdRSnYrbjh0UmN4c2JzM1BMNmhhR3RmQWxPYjd2ajgvc1lpK1R0TnVBb1di?=
 =?utf-8?B?TEFCUmdmT25kbWx3SUR3a1Z0YmFhSmpRcWxaSm5KdnFESDg2bjd6bjdTNkhl?=
 =?utf-8?B?aTVpSXNPTEpqY2lEQTlkbW05dXF6WUF0WmJidUxIMFUrVS9xUmIrQ3dlYk5V?=
 =?utf-8?B?SWpOVVVPMGlzdWQ5TXMzRW1FZmM0eDh6TUFWMG9qa3c2bUZRY3hwWVcwWDY5?=
 =?utf-8?B?K29VYmhtTVE4YmJjaGNSOEdkWEpSN2ErdEF5Nit3S2JPeXhDZE1CdWFTNXFL?=
 =?utf-8?B?OHQ2RkpoVEdUMEZmM2gzVU9GZ2JaRlJ5S0dXdTN3NTczeVlLVkc0QXV2eWc2?=
 =?utf-8?B?Q3RMZVBXS21pRlE2N21ucWZwemwzZzVqZFpqZ2V5ZDBuWWN1UW9aZDBJRlQv?=
 =?utf-8?B?WU5LdWpEK0ZLRlRtakExWDljZFpiZkRLRnpzSFAwZVBaTmNocDY3dkRKTi9T?=
 =?utf-8?B?QWN1VkRNSWQveTJyV1V2M2QyRTdrWUVSZnRZSHFGd3ZwY0duckx5OTNkOWl0?=
 =?utf-8?B?dVhXM0Zpc213QUJyV2pOWERkdTRsR05vRXRnNlhKVXB4SWhJNk5mT3RxRlFn?=
 =?utf-8?B?YnJldmx3cTRHV3ppN29CRGlySW5ZWkNvdFZZZ3dLcXdKUWxraFI1K01ZbEZF?=
 =?utf-8?B?Vnl0cUlPejREZXYzZXBaTjMvMzEzODEyU1oyMmxtbmpnZzFIbk1ob1dpWU1K?=
 =?utf-8?B?ZHRxMVMvamNmZC9uNDc0cHdyRWxsWlZsVHB6azRwN1p6QzFnTW5DS05QKzR2?=
 =?utf-8?B?L01ncmFFenRQZ0JML0JDL3ppWXdiTTFqQ00xRGdHOTkzc1E0R2psQldzc3lJ?=
 =?utf-8?B?UmpHZmo0dnlLTTdydFpvWmpWTzZRQnRPbXM1d1dtaXFBTDRDVmNESVR5ZUxl?=
 =?utf-8?B?ejVEZEk0SkQxV3hpbldWLzRqTWdBNjZXRXZLaUxPQWt3aW1NNElXM0htL3B5?=
 =?utf-8?B?bkxPUnVxUUlFUDF1a3F1OE1hTlNzcWlhbmtVaG4rei8wbXNhK0thTUR2endl?=
 =?utf-8?B?R3ZHdXVHN3c0S3oyb3VmcVNDRFlKeGpOa1BBVWc1WGFackMwZkNwSzdFV1F0?=
 =?utf-8?B?WGlzNitkOFI4MGs3cGpKS2FYQ2o3NXJJcHpQeG5MTzNIbzc3cDlyTVZMbHNi?=
 =?utf-8?B?YUdrM1dkVmhGMjloR3pEclpuMzBZZnVUYlpNQTdXSHBwTnpXUjJMUTBubUlI?=
 =?utf-8?B?V0YxTktGWGhZWDFTVXE2a2dWenM0RzUxYWk5RXdXQ0d4MEpPdmF3dVZpODFw?=
 =?utf-8?B?akhMeWw1UmxwaTVzSzB4OUVHVDQrRFpneURKbXYzelVyMWdHOTVYbFZNWGw3?=
 =?utf-8?B?OERmRkFKbjZEK1lZNVZXZDVxck9QeGlPbkNUdzh0YWVTeUhucjRSOStxQVh1?=
 =?utf-8?B?UTZQaWVmQ1lDV2d3YTFFSlFBcmhoRUV2ZS9LaDJmZVppVDZwYjRpcGdnZ2hO?=
 =?utf-8?B?TGJJTjJTaE9WQ2dteDRjSnVvV1cyUVIxeW5kNFBSelo3NlZrMS9PbFpYdDQx?=
 =?utf-8?B?OFMxYWgyaXpBZExaeDd6N0NBZzMrekpSVkUwdXVzNy9tcmI3NzlmSndDZFdV?=
 =?utf-8?B?d2tIZjlzSFpCVGNGN3F2dnZlSDRCVGE0UUY0OFY3REZBUE5tZWxybUc5VG1z?=
 =?utf-8?B?TmtkNlB0T01jMjhHV3JObVRpS0lpYVRPbVZEaVhXK2dKVzdVR1B0OHpKNGg2?=
 =?utf-8?B?a2dPK205TTNXWkhUaVNJV2RsVU1FOVNpeVNHbEltM1Y2ZU1wUzIrWnNzYUN3?=
 =?utf-8?Q?UQ8Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTJOd1FmU3JxamZ5YW5rWDhwUFFtMVdVRUhMbGhJdWJtaHdQemhrTVphWndo?=
 =?utf-8?B?K2lmaXhkQ2RjM0JxdGRHUWR6RjZTSFlBdi9DdGdDRmNhME5rSkJaM2lyUGtz?=
 =?utf-8?B?M1BLU2srcUlUN2xWNWlMbHRlS082UVpPbXJNTExrU01ibEkvVGZWUmVpNEZm?=
 =?utf-8?B?bkZJaVF2ZnZYdGtIUkp0QkR4TUZGTVFYNGlUYTFZWjJnQ2RYSEt3QmMvcmR1?=
 =?utf-8?B?aTZYbDZDUklBdFJBSnBMZFdFVVYyNjRsOW1UMG11a2R0MHpzTVprd0VsbjNy?=
 =?utf-8?B?WSttYzFEYk0xSkpET2p1dWFLQVdMbWpXQUpDQzBTR2hQL0RXTzZQWlVWaDJV?=
 =?utf-8?B?MUsyZythalp1SzNDcUpLWlpnWm1Pa1J6ZTVrZitCVncyc25zZWp2TWpXMVF5?=
 =?utf-8?B?Unk5cFVXWngrOVlING5xZVVzRUdSLytUNnFpTHM1c1hOWnJSOHFvNlZWbXRu?=
 =?utf-8?B?UCtaS1pqVnpNeGRwN3VDZlNEWHl0K2FZRWUrVEhEbHRiVmwvUmpZOFF5VG1w?=
 =?utf-8?B?aHVsaGRuSzhraWFwbS80dnZlNTNkenk4b1d3MDVlcmhEUzRrYUU0RkRmNHQ1?=
 =?utf-8?B?cXlTd244ZGtRTlJXMEUvVHY3V0VjV0Y2dnJBNWg1QVRwRFpobHVmMlpXcG42?=
 =?utf-8?B?SW1kL3ZERW10MXhHT3l4cXVjQTBuWDhkY3FwdFFsZ3oxMnBhS3YzTW5yZ2RG?=
 =?utf-8?B?SEk5WkRMVDZMNUNuN1J5eDBVcTZEYk10S0V0UTkwU3hub3czQzhhV3V3MEgx?=
 =?utf-8?B?WjV2RHNBd3BQOUhZbHYybmJtWXd4LzJnOXVlVStTTUduRGJzbEpLR1BNQTJN?=
 =?utf-8?B?M253L3ZnL1JCenRvRUZkNUxqZTQ3S3BkeThtc2lyU0dhVXgvVzVBQk5VMzQ5?=
 =?utf-8?B?Znh1azJCMGFZQ1MvKzY5YnhJSnJWUURTM2huTWlXQTN6L2c3alc2M25XRUlu?=
 =?utf-8?B?TXM5Zkd6c1lwTURkdWFaaTZKVXBydzB0QmovWXhSWFhkZ3plNkduRVc5ekhJ?=
 =?utf-8?B?UjdPT1d6ZUxjdGFlY1dIOFVtSm1SZWc3Ky9RUGYvUEJDeGlZY01QeDkzakh0?=
 =?utf-8?B?SEp5U1dwSzFtTTVOUkN4U281TDVlQnc5cTkvbjk1UWlOeHY1YmFuT04rS1ht?=
 =?utf-8?B?TDM2K3Qrd1lpSG05UTN4RmErdWtGc2xJaTNUL3FxbU1WWTBFSEswaStjdGw3?=
 =?utf-8?B?WUtITE4xd2hPYi93VDkxOEU0bkxuRXpYLzJVbkV3QXE2SThzY2xheS9yRjl4?=
 =?utf-8?B?dk50YXlRVjJwY2RiZEpyWnc2TFArZGNlWnI1VUFiaFVFN2ZMVFhWM3YvQzYx?=
 =?utf-8?B?UWlCdkt4V1UwUFBGaU9Sd3BYYlJCRXZoREx1Q0xZVk1ZNzYxNVlUdUxHRmdv?=
 =?utf-8?B?cy8yb3l2NnB5RlJZMHNMd2tuNlFVTUtndnNvKzZha2VLYmpiZjJseURVbEh0?=
 =?utf-8?B?aGhBUDZndnYvMCt3anRHRmVGYnVjTlNJZnJ4SXJTRTljUnY2ZVdlajhmV0ov?=
 =?utf-8?B?Um5OblJ6ZFRXVUJUNHdHRmljSmpJZ0szYlBsTk5UTjFHTWhDYURPdkk4Vldz?=
 =?utf-8?B?NDNjQkJaRG94Qnh4QTlYNUFlTkZ1L0gvYzE4WkVyNnRDWEtWNDBMT2JSVENp?=
 =?utf-8?B?TDNGc1ZTNmprRXRlYXA5ZEdYN1VaRWU2cGpTQWlPNXdHQXY3MWdTaTZ6enNG?=
 =?utf-8?B?a1VGTElrRjZGdlM4UnlhaDg1a0JIemxLSzNXa0twZlBQb3k2UFhhaHlwREhs?=
 =?utf-8?B?Sk9yNmJJTFdSM0Z0VWxpWDA5ZnIwTHR3Ync0djk5ZTRGRi85cWgxMkhyd3NI?=
 =?utf-8?B?YVduMXplbEJmVTZIaVoxNXo0akZxQ1ByRlNOaGVEdWtJYTBYYmU4dU5PL2xY?=
 =?utf-8?B?ZGVuamtQT000WS9WcXdVRGk2NFM1SG5SbFVaYncxUjczRGtxRHIySlE3UVZt?=
 =?utf-8?B?bkFlcldOUW9IMWRKZW0yamV5R1JwWDVEelVBTG9WK3dmRGsva3h1eHYyRFF1?=
 =?utf-8?B?Y1pvR1VJVGJjZTFtYVdmcktUaklXWXlDSnl5akpXeVdyZTZsWGtMYzhJcENT?=
 =?utf-8?B?b2pCUFNnNmNtT2N4WHorTmFyNVFZZmtlcUlJRjdqUGNhVWhNaSt5eXNPbTdR?=
 =?utf-8?B?ai8vTXFrdG5vRVNLNlhENmZ0RXEzODNqZ000S09OdWRyTHJ3RzUxbTdtMUky?=
 =?utf-8?B?T1orQ2VxRWc5TWpvZ0prSTRFTDBoZ0k0dHBPdCtvVjBSd1hwRnZNeVZ2cTRs?=
 =?utf-8?B?eEw0bk8rMUw2RVpReUZDYVFkd1V1UklwODAvZTVYNTQ0LzVVZHd1MC9wQ3V2?=
 =?utf-8?B?VHh6OVUzM2Z4TXpsS1lhbDk2Um9SanJ3di8zRWpXcllBR2M2NTQ4RVlHcEd4?=
 =?utf-8?Q?DZLoPV7i7L9A0FAE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LL7zyby6oIyxdL6A3SdiDEY8Ob44DTvVpOIxxJTX+xoh7k56oHbCOHOaTXXbGNCqxZmzokBYGp4K3u/+3NEbanQJ0XshIpFwBYQjdOpnOVVOZPEEQ3XP72eY/MJn9EW2v2l6D8KvrMGbtu0/2EY3+OwoUA+EVtQ3xhCLHvV22c0fIavN2JEv8gRxFgaAfKk0IXQ3HyaWsKJjAZLXE1aE8Zd2F2646HTMP9ijlv/5cPfp+vSOPyviEJMAxY/TEBaWBNJ4ej8tf6kyKTsIEgV+9o7No86ArXSYoMNczOVSHLzsJyeTVQZYG+L3Y4OZBw08abUfmax7Tia5Y5j9GEHCWmTcT+V8cMBlGOjSo+TIAeWgEHCfxI3eZ55/ay3hlIoAXefj2O6JgHAoN3yA/0L8YYOiqZmQgTmftLIpUHLxKP8/0b96fdipvcq16ae8QznoKxULjqAsPG7I+23Vj6nWBq3QHTh9Jj/nUGtCddmCKaaoTA9h0LEUkaimBOlKc4/wtO43d1yk76e9G2byxdaYCLkrX98dnKqkakmdiFF/KEexVdfA66NGtOfx2BXQXAv6gQegpgQGrF9iDRQuI7nZxgq1P/2NR6CqtuKCCGgRLj8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59369f06-b08d-4ba2-e42d-08de626e2acd
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 15:17:23.8763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULOJDU6LeBGuYHNLgxCfbVBxQ7HjOhQfwcGpm7fyXi/L0zgM5T/mxo9rbDfX0S+COJbOCyV/cSPW6BktV1zEa+uwtxeQkN3CowiwFgnolH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF80E5E852F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602020120
X-Proofpoint-ORIG-GUID: UubKr-_h-mNwlQn0tSPZly_2MbxBgzxS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEyMCBTYWx0ZWRfX7ZPHauJK2rtJ
 BShZTxZbn9DeZz68OaDHnsMDGhUJfr1j7wnr4eoJ7+ia7e8Jh6Bk4GoOSyiPQ3vEBFQ1QnJrzl5
 JT16Z4eMwtiPGLut+XQ46CCorAu8UJOCziyNMszIrPi6FSvU8GcjiWEEvh46IF3pjM0e8aZMEu+
 nyxKNMfuCQy7pfWzkrkGCCiSGj0AXV//RGio0E11/XQutSfmX2+HfyM8xVeiAAnySbaVS6jxsLZ
 u1W4vlKigMt4f+Nsecg9K/HQ48wCf06NRBIsXzmZ8qrnpbX3QgpRPBtZlSSfMYkux6T5/s8IqYL
 9g6YbRq1Q3TkNog9kAC30UjpCVEfea/55vmYouYyFwEmcxGUOERVKP9PIbk4sKp49SCclKIao+p
 58e5DGIt3cJFKs5pADA4qpAXaKNbsxKzSffIJwEgdLVxkDdnGsCPJTO3rhnXzOS8RrUJ2hipFqQ
 sy75FBX/VLdye4c7sUw==
X-Authority-Analysis: v=2.4 cv=F5hat6hN c=1 sm=1 tr=0 ts=6980c009 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=qswjA0XFHVuSjYt3sDoA:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UubKr-_h-mNwlQn0tSPZly_2MbxBgzxS
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 1/30/26 3:04 AM, Sairaj Kodilkar wrote:
> 
> 
> On 1/30/2026 1:09 PM, CLEMENT MATHIEU--DRIF wrote:
>>
>> On Thu, 2026-01-29 at 15:58 +0530, Sairaj Kodilkar wrote:
>>> This makes it easier to add new MMIO registers for tracing and removes
>>> the unnecessary complexity introduced by amdvi_mmio_(low/high) array.
>>>
>>> Signed-off-by: Sairaj Kodilkar <[sarunkod@amd.com]
>>> (mailto:sarunkod@amd.com)>
>>> Reviewed-by: Vasant Hegde <[vasant.hegde@amd.com]
>>> (mailto:vasant.hegde@amd.com)>
>>> ---
>>>   hw/i386/amd_iommu.c | 65 +++++++++++++++++++--------------------------
>>>   1 file changed, 27 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>> index 789e09d6f2bc..62175cc366ac 100644
>>> --- a/hw/i386/amd_iommu.c
>>> +++ b/hw/i386/amd_iommu.c
>>> @@ -35,28 +35,7 @@
>>>   #include "kvm/kvm_i386.h"
>>>   #include "qemu/iova-tree.h"
>>>     -/* used AMD-Vi MMIO registers */
>>> -const char *amdvi_mmio_low[] = {
>>> -    "AMDVI_MMIO_DEVTAB_BASE",
>>> -    "AMDVI_MMIO_CMDBUF_BASE",
>>> -    "AMDVI_MMIO_EVTLOG_BASE",
>>> -    "AMDVI_MMIO_CONTROL",
>>> -    "AMDVI_MMIO_EXCL_BASE",
>>> -    "AMDVI_MMIO_EXCL_LIMIT",
>>> -    "AMDVI_MMIO_EXT_FEATURES",
>>> -    "AMDVI_MMIO_PPR_BASE",
>>> -    "UNHANDLED"
>>> -};
>>> -const char *amdvi_mmio_high[] = {
>>> -    "AMDVI_MMIO_COMMAND_HEAD",
>>> -    "AMDVI_MMIO_COMMAND_TAIL",
>>> -    "AMDVI_MMIO_EVTLOG_HEAD",
>>> -    "AMDVI_MMIO_EVTLOG_TAIL",
>>> -    "AMDVI_MMIO_STATUS",
>>> -    "AMDVI_MMIO_PPR_HEAD",
>>> -    "AMDVI_MMIO_PPR_TAIL",
>>> -    "UNHANDLED"
>>> -};
>>> +#define MMIO_REG_TO_STRING(mmio_reg) case mmio_reg: return #mmio_reg
>> Hi Sairaj,
>>
>> Shouldn't we define this inside the mmio_get_name function and undef it
>> after the return statement?
>> I think it would be cleanup to make the scope of this a bit smaller as it
>> is specifically written for this function.
> 

I agree with the above. I think it is a good idea given the ad-hoc nature
of this macro to keep the definition and its usage together and undef it
right after to avoid any confusion.

I was a bit reluctant when I proposed the macro because it affects control
flow (the kernel coding style frowns on that even if QEMU doesn't
explicitly forbids it), but I think this is clean and easy to parse:

static inline
const char *amdvi_mmio_get_name(hwaddr addr)
{
    /* Return MMIO names as string literals */
    switch (addr) {
#define MMIO_REG_TO_STRING(mmio_reg) case mmio_reg: return #mmio_reg
    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE);

[...]
    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
#undef MMIO_REG_TO_STRING
    default:
        return "UNHANDLED";
    }
}

Sairaj: if you don't want to sign off on this specific pattern, I can send
a patch for it and we can review it separately.

Alejandro

> Hi
> I think this is probably okay as its unlikely to cause any issues in future.
> 
> Thanks
> -Sairaj
> 
>>
>>>       struct AMDVIAddressSpace {
>>>       PCIBus *bus;                /* PCIBus (for bus
>>> number)              */
>>> @@ -1484,31 +1463,41 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
>>>       }
>>>   }
>>>     -static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
>>> -{
>>> -    uint8_t index = (addr & ~0x2000) / 8;
>>> -
>>> -    if ((addr & 0x2000)) {
>>> -        /* high table */
>>> -        index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH :
>>> index;
>>> -    } else {
>>> -        index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW :
>>> index;
>>> +static inline
>>> +const char *amdvi_mmio_get_name(hwaddr addr)
>>> +{
>>> +    /* Return MMIO names as string literals */
>>> +    switch (addr) {
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_DEVICE_TABLE);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_BASE);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_BASE);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_CONTROL);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_BASE);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXCL_LIMIT);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EXT_FEATURES);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_HEAD);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_COMMAND_TAIL);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_HEAD);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_EVENT_TAIL);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_STATUS);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD);
>>> +    MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
>>> +    default:
>>> +        return "UNHANDLED";
>>>       }
>>> -
>>> -    return index;
>>>   }
>>>       static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
>>>   {
>>> -    uint8_t index = amdvi_mmio_get_index(addr);
>>> -    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr &
>>> ~0x07);
>>> +    const char *mmio_name = amdvi_mmio_get_name(addr);
>>> +    trace_amdvi_mmio_read(mmio_name, addr, size, addr & ~0x07);
>>>   }
>>>       static void amdvi_mmio_trace_write(hwaddr addr, unsigned size,
>>> uint64_t val)
>>>   {
>>> -    uint8_t index = amdvi_mmio_get_index(addr);
>>> -    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
>>> -                           addr & ~0x07);
>>> +    const char *mmio_name = amdvi_mmio_get_name(addr);
>>> +    trace_amdvi_mmio_write(mmio_name, addr, size, val, addr & ~0x07);
>>>   }
>>>       static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr,
>>> unsigned size)
> 


