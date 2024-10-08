Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CB7CEFC53
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 20:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syGqQ-0007Ia-H0; Tue, 08 Oct 2024 16:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1syGqJ-0007I0-Ci
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 16:30:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1syGqE-0003mv-L9
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 16:30:02 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498JtdMu015068;
 Tue, 8 Oct 2024 20:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=QQrHhVJ8LCjMy+RyDzym9eHLbeEhbqkWbt0JTHBP1MI=; b=
 gQyZy+uNO7BbCDxoXzIXDZzF8yBnA/3w81uL1IDCaBGODncQ6uErpwe8L6dW6uZg
 29u5J486hG9TP7GxtusHOVQaE5Z1xVHGpU20L8ZkEz/H8PByXMjeusABQ21jpkfT
 fg99PU6H1vi7aohiV973leLicQynU/GoEj5Vh3Vm/dT32s5DjXV2yvLc3V8vyaOI
 za7nZ7yjCjBF0BrAKTcwkT9IC2UeyjZOTZkJGa2u54EY5NWPv40Gg+RMHVKgawXa
 PHu62U24VBtOv6liK6HWOa3n1GtcGRS2IVZwK7Fsc/ufAlja9qiuJOPuIJfJchbM
 BsX/toEQ/+eiMOTbyLuPNw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dps6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 20:29:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 498J0rBX015263; Tue, 8 Oct 2024 20:29:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw7psaa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 20:29:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dke1RULwSvCLcqzeM9jhfLsQr3j17KJSHRTp7Zjdxh9TTIgoA8NCwPipylblhNbjK+mNkonYHhNTI4s0I0FBoTLIs8HYwjbxXkn6olrICSLCN8cO2YnT97OtqbZN6ty5D7RZXj8KHNhakpRPUL0FvtONSumCgffhGCT68meTXRIYLOJpLoY6QnBJ1zjRCoHYv3e0asMJ1NHeGJ4ToulShFe5VA2oqi1y6COvuXtcyxnX2t/EkzewlD/4/jzWqkSA38RBTpp5CYN04kcH1/fkjGBlIs9SnpvYsgjdMRPiYDGjlm3Zl5ezg3ZcGiVwQWokoSIR5x4NcU2Ifx4QxLezng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQrHhVJ8LCjMy+RyDzym9eHLbeEhbqkWbt0JTHBP1MI=;
 b=U7f7aBszS8BpAerty338Wo2opYXETSo5rGedzj9lspyWaeKmCjSst6INb96t+kFJaiL3IajfHccqiKHhmvfLMg9C9ts22ELZq9nWBMIfub5c9FF3isR5Fs9jZ8T42kKBnPod7t7nUoTqn75X9jTkqrFgw97+xn/hnGRTVl83J5wRGsVGBrk2hARWiqsZ9ytI8e0hsqojuOpxYp6nSijuu5E3NcEVCX5wKkhymkFrlux1KFgzvLqfG1Af2Acf2e9J7zBL/3zVNvTbeX4Kiqnl/GzrJxjdncdgqMBeQ1g/jU2F215NGlqX4GYPRsuvoVLGDcYZwc6Tupk4HndglMp/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQrHhVJ8LCjMy+RyDzym9eHLbeEhbqkWbt0JTHBP1MI=;
 b=XGjt05Yr0O6SJrJGtNF2D9UxSu6QBXFJ//jsqnUavaD1QJwUL2a3/xYEEZYK5JE9kN0PoSyflavZox1lWmgg1hthX6n3KGAy1xeiLWDTZCW6rMO/1wMXchsYMf8SH0e9H1lq0Ek6ixblMgHSS/rjuWCq1Yzvh++CEJJLgJJHHug=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH4PR10MB8145.namprd10.prod.outlook.com (2603:10b6:610:235::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 20:29:52 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 20:29:52 +0000
Message-ID: <c0983e7c-b857-46fa-a6ec-82215829bbc7@oracle.com>
Date: Tue, 8 Oct 2024 13:29:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/2] vhost-vdpa: Implement IOVA->GPA tree
To: Jonah Palmer <jonah.palmer@oracle.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com,
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com,
 boris.ostrovsky@oracle.com
References: <20241004124445.3802090-1-jonah.palmer@oracle.com>
 <20241004124445.3802090-2-jonah.palmer@oracle.com>
 <CAJaqyWd7c6ZU_4Hk_Wo79Ghw_LRxxjmvXUvZrASKE6WSWZcytg@mail.gmail.com>
 <e3108f34-f951-47d6-ac41-cbbc045a7bd1@oracle.com>
 <CAJaqyWcmjnPaAFGvE5=2e19wuAxOr2=AHX1y-dj70+49sdQh7Q@mail.gmail.com>
 <a1711695-9d0c-44f4-b799-1879404581d9@oracle.com>
 <CAJaqyWfYvD0nEYU9UgKzYgUo5JzuFu3PBKNEkDrM0BE0Ek5LfA@mail.gmail.com>
 <5ebfd766-c8b5-4fb3-86ad-17a74212ef5e@oracle.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <5ebfd766-c8b5-4fb3-86ad-17a74212ef5e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0034.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::47) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH4PR10MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6bbd52-26bb-4380-b60f-08dce7d7f6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0h2TU5lUVpHUzlaZy9kMnZOMTBvbzNHRTY0czErRE44MlNWbVN2dUl3SkFV?=
 =?utf-8?B?WWRvRzNQNDR4SDFGMGVQU2d5bmxpRUtFaDVrUVRZZklQS2l3R1lpVUVES1Vl?=
 =?utf-8?B?WVVQUXNjS0F4RmF6Mm9qeU8xeitXM24rZmwxc0RjcFluWkJiMmpHa2h3Vjdq?=
 =?utf-8?B?WDZCenkrb1dQcjk1dm93dmVkMlRmcURzWHB6aEF6Y2h6Qlo3MERGZ0ZzNlEr?=
 =?utf-8?B?RWV4TmQ1STFzTVhEaVlPeityN0NUVmFNajd3S2VyZjFRa1h0WE12ckpoRTBl?=
 =?utf-8?B?SVJTTTY2eHVnb2pIRjk5SWlzQlZnUXpQOFVsdHRGV1JjZUtLQU5sVXUzcDMv?=
 =?utf-8?B?TEZ3Wi9UQlJEUy9wS2JQS0Z4R2ZneldrMkpTdElMYlBkUmk0dFB6K2NtUUNw?=
 =?utf-8?B?clQwbm5qSHJHbjg3YjBhMENhcDd5VjcwbDNONDNmTjRMRDhBbE4yRWJjeCtm?=
 =?utf-8?B?dWdIelk0VnRBTkR0QkpaUDd6U3dXZzdHNXN5cUhoY3F5Qy9MZUEzNzU3ZVpF?=
 =?utf-8?B?aW1YdUxoRFFZUFQ4V1RSZWtEWm1YazVtMDEwalhuVDF6cDBqQzRKdmlOdVhv?=
 =?utf-8?B?UlhhcXBpZWFDYkY5MEFZQ2JaT3Z4RjYzMHR4eGE2M2xXa0ZrUW50R1FaMFJP?=
 =?utf-8?B?SU1xakljbmdNZmdSSVNxN0g4blVkVzMzWVRRclErdFNIWjN1V1pNY3Zqb0lz?=
 =?utf-8?B?YVhxNmM3VDM5dXYvZW8zb1l6YkpoSWlyS0htSTFtOE5KRjRpY3ppeXZTeEYr?=
 =?utf-8?B?dVQvVm5LMkFsODVWazA5MWJFN0V3aHVvQ0swYkNISzFYb3lDRy9mZWVmaU5l?=
 =?utf-8?B?Vm1oWE5GVmdDZ1FQMHh2MHhpNXdYU21ieUk0bXpySGxUVTFvRWo5NEVmb3BT?=
 =?utf-8?B?S1BMUWo3UlJ6cXF5d1R6Nm5wbENmVXZ2cmpJYUR0Nzhub2llVDI4T0szMjdY?=
 =?utf-8?B?bE80aUJGQWZNNkZNWklLeVUrL0tHUElNRmdxVStmQmRKdnI1UEhjNEd0eVZw?=
 =?utf-8?B?QXJKaytqZk9CWFU5em9KY2NnVmNIS0VCS1c5TlNtSGhRWmN1bVdlcldFVEFW?=
 =?utf-8?B?d3drVFpaaXZiWlg4MGhDTmliNDFHRW5XR0tYbmlmZzJBNzl2OU8rMEt5ZHlD?=
 =?utf-8?B?MEUvVHFZY3NDOHpEREpPYWFBWjZUa0tFQ25WejFrSWJvS0I3b2tHL1ZEWDBI?=
 =?utf-8?B?cmNBdGxwTDB2bkxwR3hnSFpEb2NvUUpXN3RTaXVsdHhjVXVidm9tRU0vNFhi?=
 =?utf-8?B?REJ4R0FGMFFXVTNsT2Uxb3NRelJIa0RlVS9lNXphcno1Z0Z1Q2tHUmdaNkV6?=
 =?utf-8?B?UFdoWVdWQys3RkZYeE5xd1FTaUFwZExHbFpNTHZhVWUvOE1tVVdDaGlxT0VB?=
 =?utf-8?B?RllhVnR0bW1TMmtscDUzbmFNdmpuSWd3TS92S1BIUzZzNU1FeEpwa2kycWE4?=
 =?utf-8?B?U1JCYStmMWkzRDhGK1ZlVWVQaE5GSC9ScE1zUSt2cTY3eVZidnJwaDhzR3F5?=
 =?utf-8?B?R1lybnFuUEJVQ1p4aGlsZjNhYTNpdElpREFzSmFQbDAwdFA5Nnp0blEyVG55?=
 =?utf-8?B?c1k0UUd5UklkS0RoZncvNkpjbE9LaEVveWlRRGhQUk51eW5RZ1BDTk5WZnc0?=
 =?utf-8?B?bEp6d05uU1FvbURwNThMUFc0eWtiMXIwb2x6bUp4RW1McmJCaXluT1k1cE11?=
 =?utf-8?B?NGd3M3ZKN1JPLzVyQ3UxYXloWnRYMmJreEkvUnJWVC9ZY205bmdieXJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnc2YjdWeVVYY2VwZHdvZ1l0c3RqUll0R1JuQVE5VGlwNVF5SVBxSDVhZDVQ?=
 =?utf-8?B?ZFF0VkFFS3NCQlJLTm9yUzZ1Ui9zV0dkd1c5OGl3NUZuU0FCK3UrbHBNV0ZX?=
 =?utf-8?B?ZjYyZzZ3Ym5XV2JhdnF2QXV0SVcwajhSSzJ6aDZUakJSQS9Mdmp1bEV3Zkxw?=
 =?utf-8?B?TWxGbTR6a1RZUmxSTHRGMjBuOFVvTnN0dndDSVhtQjJyNWJlWWlZTHhDeXdk?=
 =?utf-8?B?eVFxOEEzYkx6VDgvTEo0eVdwRThpL1YwSnRIZ0FuWnR0SnlhWTdiZjFOSDZI?=
 =?utf-8?B?OFJsSjFON0pKWi8wZTZKcGNJZFk2ZzBPOUJrREZkWkliL3FCU3F6QjhodCt4?=
 =?utf-8?B?bkczWmViYWVBbnhwZ0V6dVF2b2lBNGU1aVlkNUx0ZDZyZ3ZGWHc0aTlKdmpo?=
 =?utf-8?B?anhzb09WNmxrQU1rTmZIY2g5TENSUzhIcytyOWYxSzB0d3BVT3pSczNJdnl2?=
 =?utf-8?B?L0JXZ1Vya05hSnJva20ySTd5TEdoMFg2Slk5MVgxM1dNVHprTFBBZ045ekJt?=
 =?utf-8?B?ZEZlNEQ2OWVORkJpc3h2dEpTaXRaSUJoQ0duci9KNEdKdWhOS0VxbWY5SSts?=
 =?utf-8?B?ZkNGeU9UMldWVkNlM2lKNUg2UW03NnBUaWNuUVE4bUpYY0VhMkkzUHV6Mzc1?=
 =?utf-8?B?eW16YWpXT2RZK0ozS2RYenVERzdIbEYwYTkvVkVvNnNsZmlheXlGSW5tRkEx?=
 =?utf-8?B?MUVvUzNQaTJ0TUQxSXdTTUNLNGpvS1ZRMmFMcnEyRmljMU1OQTVKKy9IWEc0?=
 =?utf-8?B?MmdLY0JZYjNTVGZUc3RHK2M3bld0NW4wTnl6NlNBdzlva2RseHA0c1VGRXd4?=
 =?utf-8?B?Vm9VemcvQkRTcXlSZ2pRd0RXVmRaUWtEd0wxdlJaZEhmODE3Zkp4dllHc25n?=
 =?utf-8?B?L2lGYjJpMDVVTnJKU3hLcE94bkVsOEk4aDBZQjVCeThDRlk0RnBPaFBOT1F5?=
 =?utf-8?B?YW9EUWUxUFBDL1puRWxWWVBwRklzbVM5a0RVQlZJTkhlQUhHdDZJS3RMQnlD?=
 =?utf-8?B?Q0hWZWovZjlQa1ZOcS8xSk9UTmZiWEE2OXJaR0ozSE1CTXY5NGxwdGR4S1FN?=
 =?utf-8?B?by9pT0RBdjFFa05jTTNpa3Aybld4K09lZURlM2VOYUQ1bE5UVDZmUnBVdU9z?=
 =?utf-8?B?NXBzMkpCdzZQajhKOGVFVkhNYlJOSWxLMjZsWUtRa0NLZEl3TEVpQkoycjBp?=
 =?utf-8?B?cVZZQVV4YkdpL1pNeHVNZUxjWGN1bG9QN3VMaUNGaXRMcDZGNEVyUU0yeCtt?=
 =?utf-8?B?ZVhOKzNIOG82YTBVUk0yWVVVMnF6THloQ2tES2FJUFFEM2RhYUZ6cXhVMWNu?=
 =?utf-8?B?anJZZXRDU1ZJZXlzSFVqZG13cG9wRW9ZY2lJSEx5WVNMSUhFKzYwb2IvNTVH?=
 =?utf-8?B?cFgrR1doQ1h2MjI4dUdnRlBvcEM2TGxSWU90Y1lHUndiNkxVdjdpUTk4S1RH?=
 =?utf-8?B?bjhsTHV6bXVieFNzWkJPUlZDK1JxQjY2K0NpOXk2WU5Ubzc0NXRPbkRDWVlo?=
 =?utf-8?B?VWR6UTdDcVdVdWpEVzZGSmZvNEVBY3JKTjZ1c2wvbkVVSnRudVVVVW5Va0s4?=
 =?utf-8?B?R0MxQ21NdThENGFucUhXY2RRcUx4a1JseVk1NWFxNFNzVW9Kd3Z6Y0EzUm5q?=
 =?utf-8?B?M0RhYll4bDBoYit5YkNSV1lCSzZoZlA1RWtZSEt4RHpWQmZ2eCtoYlk0dTRY?=
 =?utf-8?B?NGgxWkJmSk1JTFVDUUhNWHdPV1VyV3BIbWxnZFowN0ppT1pZdE90ZzVhUW5L?=
 =?utf-8?B?ZjdKL0lQNjR5Y0xuNGRHMmZsYXhHL0hlb3dabVAyNlZhdER3YUdTUUUvK3pZ?=
 =?utf-8?B?R0xqNzFaam5FWnBJS3Yycll5MmppTGRmd0NieDBxTmorQ3VkWkUyVVh2UHRN?=
 =?utf-8?B?QStTQ2F5b2tmL1pKTGREOGwxdm9GTFQ4Z0RuWnVmbVlDckJONkNXZzl6NVRB?=
 =?utf-8?B?V2h3WlFuUTFLdnVrS0tjOXRMZTM1Qlp5WGM3NUNqTXFuUGt5N2k4QkRwNHRv?=
 =?utf-8?B?TFA5RHBIbFQ2MXRKRmh2T09BZVJLcC9YcjhJWVNwNmpRZzdzVlF5eWNNWk1E?=
 =?utf-8?B?RVZQK1E0NTcyYkJyWm5aN1Y0Rjh0c3ZqYnBnSHNhT0VzTjh1NHZERllBZGcr?=
 =?utf-8?Q?tlW2dKFn9b84R4xkZpx68uqBj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sxcbw4s+fIwS70jdJ6ta5L3b2MJWyiG0bJHkrvv4QcA1FWI5hcjVPazk3FZiHn7aDwJfTerSMessXKY9wzFcjrlShIZzxrxbhu2jVqNyPWBt8rDvX8WZ5yZ5h2vQNit9ESlEICIZ0a6X+CKDh3SUDe4khk83D5I4DPzN8or7hMtgs1ofzvdCzsifFPaRSVl6KD9Ykd5/j/20iV3qdFWA5RnsHQwZxw0G4UIkDjbuC1l8kpbYU1tLvN/6nqwPrcbjRZu4WvW/mnSd17Q5wKaFEDxO6vR5TdO+RXUG07IaLO/5GGvApxNXuGFcLq4aUvDBdUf6n1Tnf3yU1uLa2aPQ8dMQ/Fr/gx2htXV7GFC8LBoLEIlAIOnOqyjcFSONKW9/OYJlaiIFahk6yM4nAISytlQhYiFk2Voebcq5uU7qPO5kxrbn4kzNbVL1UTqJBrtM6rWrCN63LRQ+uQ7qtZrK26tXtusU73TIZvBgWbltn1V3S7hXVnAPk71ltxHUh3bdqQ7slSpZT+QY6xHUaEaww5I/5ZdimM2d2bmweFU1uVvJshzrcZSZvUxygSTJ4z4PglgkAm1oH98Tg2hHlG99AcMVjVncIIYyRtQeeB3b1gY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6bbd52-26bb-4380-b60f-08dce7d7f6c9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 20:29:52.5345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0jOyBgBxMSK4/sB5+KyfiAZaVaKD02GldoeNauQucm1/vpxN/yd0RBtOHI8aU0kAre3807lWK227VWIsH7O/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_19,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410080132
X-Proofpoint-ORIG-GUID: tpV3ptpJkflRr5EeV0lK_r0tDfwCuHRB
X-Proofpoint-GUID: tpV3ptpJkflRr5EeV0lK_r0tDfwCuHRB
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/8/2024 8:40 AM, Jonah Palmer wrote:
>
>
> On 10/8/24 2:51 AM, Eugenio Perez Martin wrote:
>> On Tue, Oct 8, 2024 at 2:14 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>
>>>
>>>
>>> On 10/7/2024 6:51 AM, Eugenio Perez Martin wrote:
>>>> On Fri, Oct 4, 2024 at 8:48 PM Jonah Palmer 
>>>> <jonah.palmer@oracle.com> wrote:
>>>>>
>>>>>
>>>>> On 10/4/24 11:17 AM, Eugenio Perez Martin wrote:
>>>>>> On Fri, Oct 4, 2024 at 2:45 PM Jonah Palmer 
>>>>>> <jonah.palmer@oracle.com> wrote:
>>>>>>> Implements the IOVA->GPA tree for handling mapping, unmapping, and
>>>>>>> translations for guest memory regions.
>>>>>>>
>>>>>>> When the guest has overlapping memory regions, an HVA to IOVA 
>>>>>>> translation
>>>>>>> may return an incorrect IOVA when searching the IOVA->HVA tree. 
>>>>>>> This is
>>>>>>> due to one HVA range being contained (overlapping) in another 
>>>>>>> HVA range
>>>>>>> in the IOVA->HVA tree. By creating an IOVA->GPA tree, we can use 
>>>>>>> GPAs to
>>>>>>> translate and find the correct IOVA for guest memory regions.
>>>>>>>
>>>>>> Yes, this first patch is super close to what I meant, just one issue
>>>>>> and a pair of nits here and there.
>>>>>>
>>>>>> I'd leave the second patch as an optimization on top, if the numbers
>>>>>> prove that adding the code is worth it.
>>>>>>
>>>>> Ah okay, gotcha. I also wasn't sure if what you mentioned below on 
>>>>> the
>>>>> previous series you also wanted implemented or if these would also be
>>>>> optimizations on top.
>>>>>
>>>>> [Adding code to the vhost_iova_tree layer for handling multiple 
>>>>> buffers
>>>>> returned from translation for the memory area where each iovec 
>>>>> covers]:
>>>>> ----------------------------------------------------------------------- 
>>>>>
>>>>> "Let's say that SVQ wants to translate the HVA range
>>>>> 0xfeda0000-0xfedd0000. So it makes available for the device two
>>>>> chained buffers: One with addr=0x1000 len=0x20000 and the other one
>>>>> with addr=(0x20000c1000 len=0x10000).
>>>>>
>>>>> The VirtIO device should be able to translate these two buffers in
>>>>> isolation and chain them. Not optimal but it helps to keep QEMU 
>>>>> source
>>>>> clean, as the device already must support it."
>>>>>
>>>> This is 100% in the device and QEMU is already able to split the
>>>> buffers that way, so we don't need any change in QEMU.
>>> Noted that if working with the full HVA tree directly, the internal 
>>> iova
>>> tree linear iterator iova_tree_find_address_iterator() today doesn't
>>> guarantee the iova range returned can cover the entire length of the
>>> iov, so things could happen like that the aliased range with smaller
>>> size (than the requested) happens to be hit first in the linear search
>>> and be returned, the fragmentation of which can't be guarded against by
>>> the VirtIO device or the DMA API mentioned above.
>>>
>>> The second patch in this series kind of mitigated this side effect by
>>> sorting out the backing ram_block with the help of
>>> qemu_ram_block_from_host() in case of guest memory backed iov, so it
>>> doesn't really count on vhost_iova_gpa_tree_find_iova() to find the
>>> matching IOVA, but instead (somehow implicitly) avoids the 
>>> fragmentation
>>> side effect as mentioned above would never happen. Not saying I like 
>>> the
>>> way how it is implemented, but just wanted to point out the implication
>>> if the second patch has to be removed - either add special handling 
>>> code
>>> to the iova-tree iterator sizing the range (same as how range selection
>>> based upon permission will be done), or add special code in SVQ 
>>> layer to
>>> deal with fragmented IOVA ranges due to aliasing.
>>>
>>
>> This special code in SVQ is already there. And it will be needed even
>> if we look for the buffers by GPA instead of by vaddr, the same way
>> virtqueue_map_desc needs to handle it even if it works with GPA.
>> Continuous GPA does not imply continuous vaddr.
>>
>
> My apologies if I misunderstood something here regarding size & 
> permission matching, but I attempted to implement both the size and 
> permission check to iova_tree_find_address_iterator(), however, 
> there's a sizing mismatch in the vhost_svq_translate_addr() code path 
> that's causing vhost-net to fail to start.
>
> qemu-system-x86_64: unable to start vhost net: 22: falling back on
> userspace virtio
>
> More specifically, in vhost_svq_add_split(), the first call to 
> vhost_svq_vring_write_descs() returns false:
>
>     ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, in_num >
>                                      0, false);
>     if (unlikely(!ok)) {
>         return false;
>     }
>
> Maybe I misunderstood the proposal, but in 
> iova_tree_find_address_iterator I'm checking for an exact match for 
> sizes:
>
>     if (map->size != needle->size || map->perm != needle->perm) {
>         return false;
>     }
The permission needs to exact match, while the size doesn't have to. The 
current iova_tree_find_address_iterator() has the following check:

     if (map->translated_addr + map->size < needle->translated_addr ||
         needle->translated_addr + needle->size < map->translated_addr) {
         return false;
     }

So essentially it does make sure the starting translated_addr on the 
needle is greater than or equal to the starting translated_addr on the 
map, and the first match of the map range in an ordered linear search 
will be returned, but it doesn't guarantee the ending address on the 
needle (needle->translated_addr + needle->size) will be covered by the 
ending address on the map (map->translated_addr + map->size), so this 
implementation is subjected to fragmented iova ranges with contiguous 
HVA address. I don't see the current SVQ handles this well, and the 
reason of iova fragmentation is due to overlapped region or memory 
aliasing (unlike the GPA tree implementation, we have no additional info 
to help us identify the exact IOVA when two or more overlapped HVA 
ranges are given), which is orthogonal to the HVA fragmentation (with 
contiguous GPA) handling in virtqueue_map_desc().

How to handle this situation? Well, I guess Eugenio may have different 
opinion, but to me the only way seems to continue to search till a 
well-covered IOVA range can be found, or we may have to return multiple 
IOVA ranges splitting a contiguous HVA buffer...

Regards,
-Siwei



>
> During the device setup phase, vhost_svq_add_split() -> 
> vhost_svq_vring_write_descs() -> vhost_svq_translate_addr() -> 
> vhost_iova_tree_find_iova() -> iova_tree_find_iova() is called, but in 
> iova_tree_find_address_iterator() map->size & needle->size mismatch. I 
> inserted some printf's to give more information:
>
> ...
> [    8.019672] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
> [    8.020694] ahci 0000:00:1f.2: flags: 64bit ncq only
> [    8.022403] scsi host0: ahci
> [    8.023511] scsi host1: ahci
> [    8.024446] scsi host2: ahci
> [    8.025308
> vhost_svq_translate_addr: iovec[i].iov_len = 0x8
> iova_tree_find_address_iterator: mismatched sizes
> map->size: 0xfff, needle->size: 0x8
> map->perm: 1, needle->perm: 1
> vhost_svq_add_split: _write_descs fail, sgs: 0x7fd85018ea80, out_sg: 
> 0x7ff8649fbb50, out_num: 1, in_sg: 0x7ff8649fbb60, in_num: 1, 
> more_descs: true, write: false
> vhost_vdpa_svq_unmap_ring
> vhost_vdpa_svq_unmap_ring
> vhost_vdpa_listener_region_del
> vhost_vdpa_listener_region_del
> vhost_vdpa_listener_region_del
> vhost_vdpa_listener_region_del
> vhost_vdpa_listener_region_del
> vhost_vdpa_svq_unmap_ring
> vhost_vdpa_svq_unmap_ring
> vhost_vdpa_svq_unmap_ring
> vhost_vdpa_svq_unmap_ring
> 2024-10-08T15:12:22.184902Z qemu-system-x86_64: unable to start vhost 
> net: 22: falling back on userspace virtio
> ] scsi host3: ahci
> [   10.921733] scsi host4: ahci
> [   10.922946] scsi host5: ahci
> [   10.923486] virtio_net virtio1 enp0s2: renamed from eth0
> ...
>
> This is with similar Qemu args as Si-Wei's from way back when:
>
> -m size=128G,slots=8,maxmem=256G
>
> There are also some error catches with just the permission check but 
> it appears the vhost-net device is still able to start up (when not 
> matching sizes also).


