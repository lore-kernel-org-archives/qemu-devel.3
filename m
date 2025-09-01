Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AB3CA1005
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4Q1-0004yN-N2; Mon, 01 Sep 2025 09:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ut4Ps-0004xO-Nn
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:17:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ut4Pn-000863-Mr
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:17:48 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815fwW6000588;
 Mon, 1 Sep 2025 13:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=iVlTPHLUzaDU3UctKwCT90hpW3j+UD8yUYAUfBMtX3g=; b=
 K4t1shIbpDlJSCblzLZyphmt9KCOJbjGGB6Pi/lqbYWRN503LPYTfOjJJht6X3Ps
 HvdHv/yWWTBmWJ9/GDmt/ony3zo3zocrKwE90znZ37YnNjts42tMq8wrWm+widAq
 ePDxwDAsjbLWlPd/m1UoRDNx/9JE0aHDiCdusSaIksDp8h9fhCpHz/QASomanTXd
 3dfYtLVFwZQOrJQLUYQl+47Ha0OwM1JzWjvWQ1ii4iZjM09pVk27vQgyy1dU5qjv
 1r2o8fmETPJIct0yCtZn4ZDYFoqfn2qF6d30nPfbWI9OBKffjCa4G1GIxXTjkZgD
 +/8zgWGJ1FmYiuG/t+O8og==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmnaff8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Sep 2025 13:17:37 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 581C4ob2011711; Mon, 1 Sep 2025 13:17:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48uqre5tgw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 01 Sep 2025 13:17:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyxQloe0thHVioekXhvlXoEJSB3JUyPydmb+5wt9H03IZv4jf6S7y1LwjaEExTOK0DYqM7019mEwdtL5Bky0C3YHMY2c0KHFAtxoW9WcUE12vmbvquaA/iWB3T76p8lPjGVYiHVVY//yXLJfFGBTlwW9huDDUHimqL4HEYwvjtfgjoy26rJ0L5I7zwpAtS3Ray28kf99bRmrF8xiNHFdr7hVSlCa/jIKUdAMP1sa5jENFbQSjUzFZexDIj1wHImzjs58DN428ENsfFffthkOwGdSQuGi64Ev5/DITft9iqorSXsv/lvGJ59owa3Tsdk0180zXp1corH/tZXEMMsqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVlTPHLUzaDU3UctKwCT90hpW3j+UD8yUYAUfBMtX3g=;
 b=cu/2CCePT/baty/2pusmEt8yuSbmkEmwjq1+DUyivzBSEblkYbxlGJ1Lc628iU06VTAQwBB7GsBN2DH/FveEaRl2DMuMLTNITjouDXD29R1yYYV+QRTHgkIrIDx/xZsxEJERe+ohyHOD/+oWCinx0Wf//hA7LhCyrQYPm+Jyl7pvC55vJgUsQkUHEHhtRItfXecP0LkCAXCo4cL/bSvM8bxYGVnLLXJOh7POOiWZl7aOMfLnoHhULfDNoWiiSMiBKqAeDIy4mDZLRRbccuTd8AiphlXyaPu0+ELP1Zs5gPoGapzUw7b7sy24a6o2W5n+z5Nca4nyy787jBChT1mhkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVlTPHLUzaDU3UctKwCT90hpW3j+UD8yUYAUfBMtX3g=;
 b=NRssrvwnGcO+g6SNSz3LZodQ6kYO3NJXRsUQvj5XXv1hGp8tmmPn55alcUCzgB1KrWLezC43F6bIhryhgMgUXKbodXOg7aGFXnIAUbcuaNCVuYrYO9knIbu8hwlNvbbAlEkYCnZwMY3xG8mLDX4HeDPXzTeCFLzeHjtutWPJiwg=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 13:17:33 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.9052.017; Mon, 1 Sep 2025
 13:17:32 +0000
Message-ID: <67c521a2-6a9a-4b2c-9f6b-4bd28d9f32c6@oracle.com>
Date: Mon, 1 Sep 2025 09:17:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, si-wei.liu@oracle.com, qemu-devel@nongnu.org,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 jasowang@redhat.com, mst@redhat.com, boris.ostrovsky@oracle.com,
 Dragos Tatulea DE <dtatulea@nvidia.com>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <aJOCiUPp0dckmgAn@x1.local> <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com>
 <aJTU641465aGKWRU@x1.local> <0cf99747-443e-4a29-a0da-64012548a994@oracle.com>
 <aJnydjxFzKwVzi7Y@x1.local> <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com>
 <aJpm4-JfmevsI7Ei@x1.local>
 <CAJaqyWfAnH-Lca3zmQTiR2wtaryKUo2KDKa=s5pcuAO9E6Efsw@mail.gmail.com>
 <aJyb6n9Vf4BhHqpb@x1.local>
 <CAJaqyWdUutZrAWKy9d=ip+h+y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com>
 <59317419-e832-4590-ad4f-cfe7d21e8fd4@oracle.com>
 <CAJaqyWfc3G5NLnxqXvZFxw2aRnVvOcZbLds5LHzcdoLjVGmOsw@mail.gmail.com>
 <c5b97e10-a8bb-4d59-b509-734eab7d5be3@oracle.com>
 <CAJaqyWc-vKsqs2boiktJn_cO3fSVk=-EfP3G8QN-z=n59VCoHA@mail.gmail.com>
 <4f067326-6c80-4768-886b-2b819e7184d3@oracle.com>
 <CAJaqyWcNdPyrAmRMBgdEk3o4AR1kK6ZiHWdY6q4MuwvGgjub8Q@mail.gmail.com>
 <f143a9a6-56b5-43a8-bced-bec7c7be8a2d@oracle.com>
 <CAJaqyWdRgbuEgWA8OcCfvgJ_ZC-OKHg2oGkirXkfaG2QBankpQ@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWdRgbuEgWA8OcCfvgJ_ZC-OKHg2oGkirXkfaG2QBankpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0390.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::35) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f7b443-0443-48bd-0b1f-08dde959e8bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXFITGFIb291NzdLV21BaFgwSHVGV1Z2dlJweEkvNEZrY1ErblB1cHdxSUFO?=
 =?utf-8?B?WkZWdW5tZGlVSmVMVHJxRFRxZ1Z1a2c2ek9nUjFhbGxzRzJPNlNoN1JVbkJN?=
 =?utf-8?B?V3NmelI1SGs1Y3ZkRUFoMjVRcmpLa3FmaEg3RnJHZmlPSUVZZUxuSVY5bE9L?=
 =?utf-8?B?SW13bkk3a2xOS1dGTkM5UVowRjBhb0tIcHVzYUYvVkNHamtxN1VmSlA5WjBF?=
 =?utf-8?B?cmp5K1FlZlJHVTQ3ZnVLdGpsazVzMmJYQXZMT21XZVAxSGt4dU9TUFJoaE9t?=
 =?utf-8?B?ZFRKQlJ3ZlFqQmM0SWhWSGRWYngzQ2RGd2NQREhHdG5sSWlyTklCYmFuSkNm?=
 =?utf-8?B?ZnBCZTN4TXVnSlFpZWE0cE1Vc0phcVprajZ2Tk5pQzJLMFRMMEpoQzl4OEkr?=
 =?utf-8?B?eTJLQXpndSswaWw5aTNXS2RodUt2R253LzRPMHRkZmtVb2dwWi9JWWdQVGlq?=
 =?utf-8?B?b0tjYkJDUGxBSHRmZ1YweVl6U0lMaWpqVzZZUlUxRGt0K1VNR1g1Q21MVWd0?=
 =?utf-8?B?cFBCRkErTDFxNjFWWXJ0NVFkamdXRXR6aTU0eWxldWpjSCtFT0JUOG51UnBw?=
 =?utf-8?B?c1lUYVByOG13THpRQjVXVEVZNldhVnpUZ3FZbytJdSsrajR6Q0ZXeXViOE1h?=
 =?utf-8?B?NnFSMVJCMXc1NGtERFJZOVJvV1dKYWhTd3E5MlVVNjBPaHdBcE9wdEltL3dH?=
 =?utf-8?B?SEFJbzJhSFJVNVFudU5XUjA3OE4yMEFJODZOWnNXNFAvNFZNcmwzaHdJRUJD?=
 =?utf-8?B?cFVtRnN3ODVza1k3RFJPdlFWb2c5Y0xmTzl0UElrNGJjZjVBcC8wd2ZuRXNq?=
 =?utf-8?B?STN0L2FMOHVHbzQvaWtDOXQzWDQwdU1CVzlBREYvN2JkL2VCWUFFdGVOcFlz?=
 =?utf-8?B?a3J3bXJxR1RwdGx4RUpndVBhNTR1cGNONVo1a3l6KzRocm5OajNhMXFYeDZJ?=
 =?utf-8?B?YUc1WUhiOE52RUZncEJ6MStnVjM4cXlINVBXMVgxNDZpVmNscHhPekM1RmJp?=
 =?utf-8?B?bzVKd3JSNFhKNEZmRGsyL1pyVmpua1M5b2xwUWFySy81OEJWWVlnbkhJTVFz?=
 =?utf-8?B?a3YxWmovdTd1eVdBbUUxZGJSaGowYVVkV3RiR0NOQkVSU1JNb3pPKzNwaHU3?=
 =?utf-8?B?dlRodHU0UHJ3MkVFN1pYYnVRQU9QQ3hwSnpqTi9aYUtSTFlSTlRNL04yVmx0?=
 =?utf-8?B?UWtkdWEvNTdzV2kvZ1ZOd0ttU3JsUEQwczJ0eWNnc05yamJIUHh0Vk9HZ1c1?=
 =?utf-8?B?VHVpanNDOUxZcFAvUTlkZlJ0eHhnV292SU5xSFVWMHcrQzBIYlFlUmErOWJx?=
 =?utf-8?B?eFl5UTQ0QTJZdlRoVU5YbkhEUjRXQjZjSzBGRjN6TDUxTzRxTnErdlFBS1pH?=
 =?utf-8?B?Qk9lOHVlWmRHODF5U3djQXJNbGRZM3BkWkdnSkg1b3U2R1UvZm5KZm03elVM?=
 =?utf-8?B?MkpuZ2dvZUQxaTBkYkMrdGdKcHQveWMzZ2psdFkxTkxFanNBOG9yaDFhcE4y?=
 =?utf-8?B?c1hGQ3d2ZWgwcGJSb0VWWTJmMVpoQkppdVJTQTgzV21Tb2FPNmtyVVllMHpL?=
 =?utf-8?B?NWkvZzcwMkpRdXhTdlFIQndWU0JNa25RQ0JaeVlzUGRmMHNxbFRLYXJzWVNv?=
 =?utf-8?B?Q2docWNSeWpqS01VNDdtLzNkaXRpMXowWVFpUFk0OFNiY2tYeldQaVhRSjhH?=
 =?utf-8?B?czhtSHdGbzVocHBYdk1Bb0loRGVnSmlGQU1ybUY2UHhXc1lqaGJTUy9tYUtG?=
 =?utf-8?B?bnFWNUZ2alRMbnZnd3RWSGRKVWlPQk5OVTJwQVIrRE5lS0JTV21JRm8zZ3RH?=
 =?utf-8?B?Ym4xL2JIYTZlWVRqMmw3dE5iTkgrcXhjYk90eGVFYktjNG9KWTZsd00rTkNs?=
 =?utf-8?Q?9qlxo6NmDtSvw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODZyUzN3U2w2VTBKc3dldU4xajYrWTlzbmlsVEpRREwrYmx1blpadVA3QTY2?=
 =?utf-8?B?RWFDME5mR3FQQ1pzT2k3WldTN3pUV21TTzhSRmxJMG15Rmt1U3lLV2p4RU5n?=
 =?utf-8?B?K2srTU9LekNpS3FESGp4em5yeWlMZk1wN1VMWDlwK25ZS096K09uRHIyRlJN?=
 =?utf-8?B?OFFNMzZ6NTZtRjlTWVUvcEN0Y0IzREJmOU12YlA0K2gvSmtFanlQcFBGZFJG?=
 =?utf-8?B?MkNTdXN2M0sxY3VJWHZYdjQwWE5DbkJVWW5uQ21pS3o5MWlObW9KQmRnNm0r?=
 =?utf-8?B?Yjh0SEVVU1RhVHlXU1RINENIV0MwVFlxQ0dtNWZXa1pOWURKNVEzclgxS2dh?=
 =?utf-8?B?ZUN2VlB5SGEybUprRDg3cnM4a1ZtZUVyTmJjRUpQSnBkTmVtYXh4TjFHVGFs?=
 =?utf-8?B?NEt6TlgxUU1XY2dTY1lTYXhCUS9FZmQ4Tyt0YVJFY0dHUHNCNURkalJqQ2NT?=
 =?utf-8?B?UzJHTDhzK0NXMUErd1pCTDFiQUtpYzFoTExRd3B3YWMrS0ViTEdGVjJXTC9F?=
 =?utf-8?B?VHhuU1Y1bDNzK3J5Tmg1WU1CSUdpVzlZaVVSQ2xxcUJDM0ROVENzb0VaZ1N2?=
 =?utf-8?B?N1Vrbm5yZFRqTEdMcmxidHdOYi82empiVTg2S2pXYjZIaHUrcHFzdVAvWWJ5?=
 =?utf-8?B?QUJ0b29PSExXUEo0bkxNTTlORFhlRkNVckQxQVBrSnhxUVoxTjBtMEtWZmRC?=
 =?utf-8?B?ZGZIQzZQaXN1WHZKQ1F5eWFtM3BYeHozZVExN01CWEo5c0JZYzVocEhOUkFu?=
 =?utf-8?B?Q2IrYXEyVC9pcC9zOTRYYnpPQkhpbFRNL0Fkb01wTStBNXdwbjJ1b2hGL3lY?=
 =?utf-8?B?NE1WK0wrWXpXMHc0VFRaSDFQbFVCSXdnVnpTT2JPS0NKL1JSN0U3VUU5bHdz?=
 =?utf-8?B?dll5K1J3Y2d6dUQrNUR1dHVkSUNHalRjdy9IZHp2ZXdGWU9QUWNBQlc4ZkNu?=
 =?utf-8?B?ZDJRRDZXczFLL1ZaQXlickNDS1NGNUVGalpiUk5OWW5YUkdiall2bDZScW9H?=
 =?utf-8?B?N21WMUpFMlMwR0pOWFpsaGNraE1EblNBaFBVQW41anBkcnVzVEN6TGhzUWpS?=
 =?utf-8?B?UnFVRzFoVVFkK1Y0cTFJb0d6dy9FUm9hWllqWEFZR2FhY1ZCeFZ4S3RRRG1l?=
 =?utf-8?B?cURwNHhkaDVaeHF4VjBjdzNBa1oxUzBSZFV0THlUcVRLRXNXWjlnWWNvakk1?=
 =?utf-8?B?ZU1UbDFLdUk5OS9xR3BQdzRjS1ExbTh6MUJDUUFrREJiRjFjOUpwRHhVTE8v?=
 =?utf-8?B?WUFEakE0ZVFzQnlKc0ROdkpVeG8wTy9RRmo0T0NKaURvSnBGNUoySGhrWVM3?=
 =?utf-8?B?K09NQ0F0VnVhM21WZVhvRXFnT2UwRkx6WjBuOXVjTGhJMnpTSm5qRUlzdVRx?=
 =?utf-8?B?c09iQUE3aGVXR2V6K0dpdUhWUDM2c1lNdlZXU1JSNWI4cE9hRlJKOFRnQ3h1?=
 =?utf-8?B?RGhEUjhMNk9OMTFUK21qQk85dEVlQmx2RFgyUWptQXRUeFgxQ3NVMzZocEZu?=
 =?utf-8?B?S3JsMXF5ak5uWXNXVHo2OE1TdnVkelFYMndVMWRENG1OaHhWRkFjZkhLT3Mz?=
 =?utf-8?B?dWdrVStsa2FoUVZ1ZWEzV0toZ005NFhJcmJCbElCM2hHTThPMnQ4cGJrTWVi?=
 =?utf-8?B?VGFXdzk0bVhaV3d4YnlFaHIrU2xKZUp6RGw3dVEvU2FXcDVPQmtqeEJlU3I1?=
 =?utf-8?B?WURmQ3VHUldDbGhMR3ZFaXFlR21LdmlYYXhVUFg2azVGdUhhcVFIREpueGRT?=
 =?utf-8?B?NG5HRWRiaXdBRHRQTWs0emlDR3lDeGN3U1EvcUV4aWM4UnVCV0NEeUI5Y3d6?=
 =?utf-8?B?UmpTc09qKzM3bURwK2RUeWpSSXc5TUgwN2ZOTmx2OTBPdU51MzBvQlEzN3VI?=
 =?utf-8?B?aHZKdUlTZUM5WFAxaTlNQjMxZnZZc2k4c3l6Ui9uVWdOenc3a1o2U3gwVGUz?=
 =?utf-8?B?MHczSnBlNHRTNWlUVitFZTFWdnZvOHE2TGNRU0RraFBvOXh0bThOTm8zYkNF?=
 =?utf-8?B?eVBXcmlMeWlCRmQ0dm16RXNDTEorQ01ESTFHdTFsNG5vWEsyVkU0OHFHclBF?=
 =?utf-8?B?RHF3dUtNVVdaVHhMZ1p0a29NdGNsNXhqZGNtc0pQYStNYjdteC81MHM5dlI4?=
 =?utf-8?Q?ScZSKHLX/HvcY/GGZ2akDp+Q4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wnMz91HBirCn/ws04e7NtrKAh1aa3Bn7ZRgxdgXEvthZiicP72OyaHO1TkMnRljgqXHmrFIOK09Rn8EmYBudVzQ+TAUVBwrR5suAOflqkD9VaIBWe3L2YUdA86VhMAUCa2ReDrD/9R9IHqnlp2fNtS9Oaigcj3bQivclMPu3PNwBepvo0SK7fMva12oFVhzRPiw/s50KonAFKFN++6STcHKqMbbqQoaTmU8CpsxII7+5a3r6Eh6TFZGYqgyKIebHoiGtg1t3C/VQ2PtpO/WzpNn0nAPUXODGYMQdI5Lmg0MTtbh+GhT3qqq6eMQvUBI1mFyAZDw6igCTMGpVWT8QsdQOw1ZBYQ0DKvDWvXSh252NyLfPkdo6getGmJXNcpOBk7RhgMhZGENNcgDzXD+qIpihOwN0npBTKHYCM6CZIj30S36rjXXb0B+8WF7H9KuxdYy7IHQRYO4Lvg96tcddCD86CHDWSChwz/CFqWlhNvt5vce+lmGgcda2vWeBUPtw9Zy1sOXUa3Kyj2l01jIhW0LP3hzLjSpJQL0L/n6E8FP+ReIit8S28GblRZvdHBZFQ5/xNoSFeMoMhyo+kiK1KC2Qs89fC+NZBnVBUbet1q0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f7b443-0443-48bd-0b1f-08dde959e8bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:17:32.8769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqZEvGMG35DQfxdykILjUr9QM9EshfXjRwHa8ZCeZEAEMzRheJFIrEC5cQhkkLFAm5QI6O86+WFQmiGBH9+Hlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010141
X-Proofpoint-GUID: bU1EdoQqYq7ZQIakEf5kNq1spLW9J-nM
X-Proofpoint-ORIG-GUID: bU1EdoQqYq7ZQIakEf5kNq1spLW9J-nM
X-Authority-Analysis: v=2.4 cv=Of2YDgTY c=1 sm=1 tr=0 ts=68b59cf1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=Y3rzNsqlXCekOf_hOBEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX4kOjG+q25374
 6lCUii4IbfVfiAMf2rrsPYN7K5Imj6lEdAj0IBOVvz/DZfWZGSytLO55BQy0uLnqK4BqZTnbVVH
 jD/FZVVul0AG95EJk/bEAicVitDNHuxwtYwfZFNFaWMeHC/pR++Kjz6aeXgWOP8YNJJPWZ3mIJm
 5TBIcJdhFD4y0NCPYCY6gMxZatc0j8FBB7bGfHM4QdD3wrQ1RTp7UtYxQDwBzYknxxEJ3BYbrJy
 Q6VWX9CjNhy1UquysSvGY3Ra1PS3lmcEKn9kNerlCB3bbWoHdi9MViaOgXd6htCIgpYxBpOsnCD
 fum85d9ijR1Iv5uhDZM3IatSbl//j/qDki8wEE7b9TFKCdeLlyPU/pc2IDKAV3cXg9btJ+18jvr
 1aHyuXixdblYcr835Jtby/qyUcf9pQ==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 9/1/25 2:57 AM, Eugenio Perez Martin wrote:
> On Wed, Aug 27, 2025 at 6:56 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>>
>>
>> On 8/20/25 3:59 AM, Eugenio Perez Martin wrote:
>>> On Tue, Aug 19, 2025 at 5:11 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>
>>>>
>>>>
>>>> On 8/19/25 3:10 AM, Eugenio Perez Martin wrote:
>>>>> On Mon, Aug 18, 2025 at 4:46 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 8/18/25 2:51 AM, Eugenio Perez Martin wrote:
>>>>>>> On Fri, Aug 15, 2025 at 4:50 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 8/14/25 5:28 AM, Eugenio Perez Martin wrote:
>>>>>>>>> On Wed, Aug 13, 2025 at 4:06 PM Peter Xu <peterx@redhat.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Wed, Aug 13, 2025 at 11:25:00AM +0200, Eugenio Perez Martin wrote:
>>>>>>>>>>> On Mon, Aug 11, 2025 at 11:56 PM Peter Xu <peterx@redhat.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
>>>>>>>>>>>>> This effort was started to reduce the guest visible downtime by
>>>>>>>>>>>>> virtio-net/vhost-net/vhost-vDPA during live migration, especially
>>>>>>>>>>>>> vhost-vDPA.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The downtime contributed by vhost-vDPA, for example, is not from having to
>>>>>>>>>>>>> migrate a lot of state but rather expensive backend control-plane latency
>>>>>>>>>>>>> like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN filters, offload
>>>>>>>>>>>>> settings, MTU, etc.). Doing this requires kernel/HW NIC operations which
>>>>>>>>>>>>> dominates its downtime.
>>>>>>>>>>>>>
>>>>>>>>>>>>> In other words, by migrating the state of virtio-net early (before the
>>>>>>>>>>>>> stop-and-copy phase), we can also start staging backend configurations,
>>>>>>>>>>>>> which is the main contributor of downtime when migrating a vhost-vDPA
>>>>>>>>>>>>> device.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I apologize if this series gives the impression that we're migrating a lot
>>>>>>>>>>>>> of data here. It's more along the lines of moving control-plane latency out
>>>>>>>>>>>>> of the stop-and-copy phase.
>>>>>>>>>>>>
>>>>>>>>>>>> I see, thanks.
>>>>>>>>>>>>
>>>>>>>>>>>> Please add these into the cover letter of the next post.  IMHO it's
>>>>>>>>>>>> extremely important information to explain the real goal of this work.  I
>>>>>>>>>>>> bet it is not expected for most people when reading the current cover
>>>>>>>>>>>> letter.
>>>>>>>>>>>>
>>>>>>>>>>>> Then it could have nothing to do with iterative phase, am I right?
>>>>>>>>>>>>
>>>>>>>>>>>> What are the data needed for the dest QEMU to start staging backend
>>>>>>>>>>>> configurations to the HWs underneath?  Does dest QEMU already have them in
>>>>>>>>>>>> the cmdlines?
>>>>>>>>>>>>
>>>>>>>>>>>> Asking this because I want to know whether it can be done completely
>>>>>>>>>>>> without src QEMU at all, e.g. when dest QEMU starts.
>>>>>>>>>>>>
>>>>>>>>>>>> If src QEMU's data is still needed, please also first consider providing
>>>>>>>>>>>> such facility using an "early VMSD" if it is ever possible: feel free to
>>>>>>>>>>>> refer to commit 3b95a71b22827d26178.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> While it works for this series, it does not allow to resend the state
>>>>>>>>>>> when the src device changes. For example, if the number of virtqueues
>>>>>>>>>>> is modified.
>>>>>>>>>>
>>>>>>>>>> Some explanation on "how sync number of vqueues helps downtime" would help.
>>>>>>>>>> Not "it might preheat things", but exactly why, and how that differs when
>>>>>>>>>> it's pure software, and when hardware will be involved.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> By nvidia engineers to configure vqs (number, size, RSS, etc) takes
>>>>>>>>> about ~200ms:
>>>>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/__;!!ACWV5N9M2RV99hQ!OQdf7sGaBlbXhcFHX7AC7HgYxvFljgwWlIgJCvMgWwFvPqMrAMbWqf0862zV5shIjaUvlrk54fLTK6uo2pA$
>>>>>>>>>
>>>>>>>>> Adding Dragos here in case he can provide more details. Maybe the
>>>>>>>>> numbers have changed though.
>>>>>>>>>
>>>>>>>>> And I guess the difference with pure SW will always come down to PCI
>>>>>>>>> communications, which assume it is slower than configuring the host SW
>>>>>>>>> device in RAM or even CPU cache. But I admin that proper profiling is
>>>>>>>>> needed before making those claims.
>>>>>>>>>
>>>>>>>>> Jonah, can you print the time it takes to configure the vDPA device
>>>>>>>>> with traces vs the time it takes to enable the dataplane of the
>>>>>>>>> device? So we can get an idea of how much time we save with this.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Let me know if this isn't what you're looking for.
>>>>>>>>
>>>>>>>> I'm assuming by "configuration time" you mean:
>>>>>>>>       - Time from device startup (entry to vhost_vdpa_dev_start()) to right
>>>>>>>>         before we start enabling the vrings (e.g.
>>>>>>>>         VHOST_VDPA_SET_VRING_ENABLE in vhost_vdpa_net_cvq_load()).
>>>>>>>>
>>>>>>>> And by "time taken to enable the dataplane" I'm assuming you mean:
>>>>>>>>       - Time right before we start enabling the vrings (see above) to right
>>>>>>>>         after we enable the last vring (at the end of
>>>>>>>>         vhost_vdpa_net_cvq_load())
>>>>>>>>
>>>>>>>> Guest specs: 128G Mem, SVQ=on, CVQ=on, 8 queue pairs:
>>>>>>>>
>>>>>>>> -netdev type=vhost-vdpa,vhostdev=$VHOST_VDPA_0,id=vhost-vdpa0,
>>>>>>>>              queues=8,x-svq=on
>>>>>>>>
>>>>>>>> -device virtio-net-pci,netdev=vhost-vdpa0,id=vdpa0,bootindex=-1,
>>>>>>>>              romfile=,page-per-vq=on,mac=$VF1_MAC,ctrl_vq=on,mq=on,
>>>>>>>>              ctrl_vlan=off,vectors=18,host_mtu=9000,
>>>>>>>>              disable-legacy=on,disable-modern=off
>>>>>>>>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> Configuration time:    ~31s
>>>>>>>> Dataplane enable time: ~0.14ms
>>>>>>>>
>>>>>>>
>>>>>>> I was vague, but yes, that's representative enough! It would be more
>>>>>>> accurate if the configuration time ends by the time QEMU enables the
>>>>>>> first queue of the dataplane though.
>>>>>>>
>>>>>>> As Si-Wei mentions, is v->shared->listener_registered == true at the
>>>>>>> beginning of vhost_vdpa_dev_start?
>>>>>>>
>>>>>>
>>>>>> Ah, I also realized that Qemu I was using for measurements was using a
>>>>>> version before the listener_registered member was introduced.
>>>>>>
>>>>>> I retested with the latest changes in Qemu and set x-svq=off, e.g.:
>>>>>> guest specs: 128G Mem, SVQ=off, CVQ=on, 8 queue pairs. I ran testing 3
>>>>>> times for measurements.
>>>>>>
>>>>>> v->shared->listener_registered == false at the beginning of
>>>>>> vhost_vdpa_dev_start().
>>>>>>
>>>>>
>>>>> Let's move out the effect of the mem pinning from the downtime by
>>>>> registering the listener before the migration. Can you check why is it
>>>>> not registered at vhost_vdpa_set_owner?
>>>>>
>>>>
>>>> Sorry I was profiling improperly. The listener is registered at
>>>> vhost_vdpa_set_owner initially and v->shared->listener_registered is set
>>>> to true, but once we reach the first vhost_vdpa_dev_start call, it shows
>>>> as false and is re-registered later in the function.
>>>>
>>>> Should we always expect listener_registered == true at every
>>>> vhost_vdpa_dev_start call during startup?
>>>
>>> Yes, that leaves all the memory pinning time out of the downtime.
>>>
>>>> This is what I traced during
>>>> startup of a single guest (no migration).
>>>
>>> We can trace the destination's QEMU to be more accurate, but probably
>>> it makes no difference.
>>>
>>>> Tracepoint is right at the
>>>> start of the vhost_vdpa_dev_start function:
>>>>
>>>> vhost_vdpa_set_owner() - register memory listener
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>>>
>>> This is surprising. Can you trace how listener_registered goes to 0 again?
>>>
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>>>> ...
>>>> * VQs are now being enabled *
>>>>
>>>> I'm also seeing that when the guest is being shutdown,
>>>> dev->vhost_ops->vhost_get_vring_base() is failing in
>>>> do_vhost_virtqueue_stop():
>>>>
>>>> ...
>>>> [  114.718429] systemd-shutdown[1]: Syncing filesystems and block devices.
>>>> [  114.719255] systemd-shutdown[1]: Powering off.
>>>> [  114.719916] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>>>> [  114.724826] ACPI: PM: Preparing to enter system sleep state S5
>>>> [  114.725593] reboot: Power down
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>>>> qemu-system-x86_64: vhost VQ 2 ring restore failed: -1: Operation not
>>>> permitted (1)
>>>> qemu-system-x86_64: vhost VQ 3 ring restore failed: -1: Operation not
>>>> permitted (1)
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>>>> qemu-system-x86_64: vhost VQ 4 ring restore failed: -1: Operation not
>>>> permitted (1)
>>>> qemu-system-x86_64: vhost VQ 5 ring restore failed: -1: Operation not
>>>> permitted (1)
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>>>> qemu-system-x86_64: vhost VQ 6 ring restore failed: -1: Operation not
>>>> permitted (1)
>>>> qemu-system-x86_64: vhost VQ 7 ring restore failed: -1: Operation not
>>>> permitted (1)
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>>>> qemu-system-x86_64: vhost VQ 8 ring restore failed: -1: Operation not
>>>> permitted (1)
>>>> qemu-system-x86_64: vhost VQ 9 ring restore failed: -1: Operation not
>>>> permitted (1)
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>>>> qemu-system-x86_64: vhost VQ 10 ring restore failed: -1: Operation not
>>>> permitted (1)
>>>> qemu-system-x86_64: vhost VQ 11 ring restore failed: -1: Operation not
>>>> permitted (1)
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>>>> qemu-system-x86_64: vhost VQ 12 ring restore failed: -1: Operation not
>>>> permitted (1)
>>>> qemu-system-x86_64: vhost VQ 13 ring restore failed: -1: Operation not
>>>> permitted (1)
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>>>> qemu-system-x86_64: vhost VQ 14 ring restore failed: -1: Operation not
>>>> permitted (1)
>>>> qemu-system-x86_64: vhost VQ 15 ring restore failed: -1: Operation not
>>>> permitted (1)
>>>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>>>>
>>>> However when x-svq=on, I don't see these errors on shutdown.
>>>>
>>>
>>> SVQ can mask this error as it does not need to forward the ring
>>> restore message to the device. It can just start with 0 and convert
>>> indexes.
>>>
>>> Let's focus on listened_registered first :).
>>>
>>>>>> ---
>>>>>>
>>>>>> Configuration time: Time from first entry into vhost_vdpa_dev_start() to
>>>>>> right after Qemu enables the first VQ.
>>>>>>      - 26.947s, 26.606s, 27.326s
>>>>>>
>>>>>> Enable dataplane: Time from right after first VQ is enabled to right
>>>>>> after the last VQ is enabled.
>>>>>>      - 0.081ms, 0.081ms, 0.079ms
>>>>>>
>>>>>
>>>>
>>>
>>
>> I looked into this a bit more and realized I was being naive thinking
>> that the vhost-vDPA device startup path of a single VM would be the same
>> as that on a destination VM during live migration. This is **not** the
>> case and I apologize for the confusion I caused.
>>
>> What I described and profiled above is indeed true for the startup of a
>> single VM / source VM with a vhost-vDPA device. However, this is not
>> true on the destination side and its configuration time is drastically
>> different.
>>
>> Under the same specs, but now with a live migration performed between a
>> source and destination VM (128G Mem, SVQ=off, CVQ=on, 8 queue pairs),
>> and using the same tracepoints to find the configuration time and enable
>> dataplane time, these are the measurements I found for the **destination
>> VM**:
>>
>> Configuration time: Time from first entry into vhost_vdpa_dev_start to
>> right after Qemu enables the first VQ.
>>      - 268.603ms, 241.515ms, 249.007ms
>>
>> Enable dataplane time: Time from right after the first VQ is enabled to
>> right after the last VQ is enabled.
>>      - 0.072ms, 0.071ms, 0.070ms
>>
>> ---
>>
>> For those curious, using the same printouts as I did above, this is what
>> it actually looks like on the destination side:
>>
>> * Destination VM is started *
>>
>> vhost_vdpa_set_owner() - register memory listener
>> vhost_vdpa_reset_device() - unregistering listener
>>
>> * Start live migration on source VM *
>> (qemu) migrate unix:/tmp/lm.sock
>> ...
>>
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - register listener
>>
> 
> That's weird, can you check why the memory listener is not registered
> at vhost_vdpa_set_owner? Or, if it is registered, why is it not
> registered by the time vhost_vdpa_dev_start is called? This changes
> the downtime a lot, more than half of the time is spent on this. So it
> is worth fixing it before continuing.
> 

The memory listener is registered at vhost_vdpa_set_owner, but the 
reason we see v->shared->listener_registered == 0 by the time 
vhost_vdpa_dev_start is called is due to the vhost_vdpa_reset_device 
that's called shortly after.

But this re-registering is relatively quick compared to how long it 
takes during its initialization sequence.

>> And this is very different than the churning we saw in my previous email
>> that happens on the source / single guest VM with vhost-vDPA and its
>> startup path.
>>
>> ---
>>
>> Again, apologies on the confusion this caused. This was my fault for not
>> being more careful.
>>
> 
> No worries!
> 


