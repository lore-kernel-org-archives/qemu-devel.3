Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B730C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 11:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRV34-00049I-7F; Wed, 10 Jul 2024 06:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRV32-00048h-2T
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:59:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRV30-0001AE-9I
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:59:43 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7fTRi012014;
 Wed, 10 Jul 2024 10:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=3Qq4l+XZNO5qWR+uofU6wrOY5K1B442RsBMsEeDICG0=; b=
 Cp61MS2auNnpoBiIdF6CaYp6WfDZHX4AlXA/LL1ITu9pxHmiEHOCCLVBpN866zfZ
 1GhpYPLqvf/EinUquA7MtNE99jdDOkBhIko27GmowdX2Ch5lKuZiIrzfInW3yy9H
 cY+dW1TjZQVrIkoIOdLAbxm2ea4GDDRvzoHxggc+A6emNKQZwCu8gmT8ewLWpDZh
 uDAOKKmi41dPZ7mY5P6A0ujGGfzo4DzG9gR4yBRn6hMcbJlWoLB0tTWQ80oHyVGF
 OYuZ753OKJ0i2D+XGeRZH2ufqQGQ7GWX4gP/mtPtwMWHjiP76Iadb+joilay3mN8
 jsuTA6EwiAvoJIjZ9zkbww==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkceysu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jul 2024 10:59:37 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46A9qC2m007542; Wed, 10 Jul 2024 10:59:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407tu4kggd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jul 2024 10:59:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XS9hwgPSiBi4zcDod7crcYJzaeSZwAZ/30UP2WpFpkDU+sCS4/lse/dYJsWsz1tlKyFqXEEES/tTKAwLo3zt+qLFgK+4IsbU/bXShHpIEnaM5NZY5GXtcQtwqb/FZj2qa4sBtDOrw/W3KdGHuO2P/vyMkc5Ht4sb/pHfOzlml5IsZY9Cd+7qRB9c1RDcQKautnUyMCAcY38tP9KRIMBSowB6/mgy6Ht++3JR8+z6/WnoyydQfmY0cEGABt46cVXFahwAeB3ZAtje2wBtM0VRbg7Npkwy2YB49R27rPcNACo4PMeVfFojLx4BX5rha3vzKfnR0zzjNFSpBRkY9ZX53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Qq4l+XZNO5qWR+uofU6wrOY5K1B442RsBMsEeDICG0=;
 b=QGFGLRB+Qt3q9+9jfm3eWTSgghFKzno9FUd+AxAx2JcugtkUJrZKNsG6S6wxLBs7jlIvXjMP4jfLk6zfV7+fKEPxHgVdCaZeLpYxVf2HNK7jiHVck33027ZwrC87D28ADTJwSz0IkRK4sUkbz50dEt+SB/YJAdOmNBvP+NPiJKiWl3iwN1MWFKsNOP/jYszFm/McUkDTkvmF1bbKE6zaeWeUmeODLSmUJWNQ3NwL1jJcHYslcc6yA3xEjY6f4DfZMlFpUIoGTPldbsQj5Muin3QTCmUuRbn7RbeQ6LgRtev9UXijNg3dXT5xp2X6uDZ4y4qAxbYQoOPq8rSyoGHLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Qq4l+XZNO5qWR+uofU6wrOY5K1B442RsBMsEeDICG0=;
 b=Y63Ua62vfVbQHv5guRv+euPVCjMKzFLahmEJ6BIypfgylyOsQDa7no4qwarxzC8Fwwb09/z6fpDfETXXqVKvNhwQ0shrWLcakWVD0HAIPbZAE/Tp7+Enl6JuvrOLdp17UwSPDbz3fOfEyki/b+cIj4bVuL5xKTqbM08WvWLoJ1s=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DM4PR10MB6813.namprd10.prod.outlook.com (2603:10b6:8:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Wed, 10 Jul
 2024 10:59:35 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 10:59:35 +0000
Message-ID: <e6281062-8c27-48f6-a24c-b728b07c4053@oracle.com>
Date: Wed, 10 Jul 2024 11:59:23 +0100
Subject: Re: [PATCH v3 09/10] vfio/migration: Don't block migration device
 dirty tracking is unsupported
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-10-joao.m.martins@oracle.com>
 <SJ0PR11MB674411D22DA888BD5222B8AE92A42@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB674411D22DA888BD5222B8AE92A42@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0498.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::17) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DM4PR10MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf89cbe-3455-4775-2717-08dca0cf6252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dm9VQjdTYTJLRnhabXpHSk93c0RJdlJJYnJDZEpMQWIvOGUrZS8xb2hCYWRV?=
 =?utf-8?B?TU10Y1lTME1xbkFaclplRm5Eb0ZKUENtdUU3cHFranJzV3h4SXFBTFhjenlw?=
 =?utf-8?B?Y0JqWGVPY2lOZnRwLzNLQTdYTHhVWUlDU09CMmV6bTJFV3pVYkRpVzhhdHds?=
 =?utf-8?B?Mk8wTlRWb0d6YWVtU1NkWnlhb3h3SmwxbGx3TmZRWEx2UmQvQXpsdEplNkN1?=
 =?utf-8?B?YUFqbGJmaFJzQlI5M29BZVJJa1U3OTd3ZFd1YjlvRllqYWgvRmc3SUJEVmZR?=
 =?utf-8?B?bk1SUklrR1FDTU9CNURuaGpsc3dueUdTY1pXdDQyU2NpTGJ3WnFqRTNsczd5?=
 =?utf-8?B?TEFPWE9DZ0cxdVZnY1lod1N6cUtBcTZRcXpWa3ZUT201RUdrQWhvWnhsSWQx?=
 =?utf-8?B?dHZFQUJVVThCZEtyNmY4b29FMktiUmtDWHVha0tNWHlJNldyTlBSRStxR3Fy?=
 =?utf-8?B?WmI4d01mVTBEQ1JmZ2RpQi8zQ1UxQmRTZkFUNlI0VW1UR01LRlZLd29DeXU0?=
 =?utf-8?B?c1U4WS8rVzRnZ2J5UGtlcndLS1dWQ3QvN256UUF2ckdnYVd5ZEgyR3dQczRk?=
 =?utf-8?B?eWNKWVNMcTRzOFEwdnEyYXdsajFBbU5Ud3RQajlDWGNidVJhR05qL3NaK0Zi?=
 =?utf-8?B?SGw1dE4yL1VkWGg5aW1kT3RDdmJLcllnVEZ4RVhhT3NGdjN3ekFwUmhuNnJS?=
 =?utf-8?B?UEhxeEQ3UVhhUkxTYzFUWWt5U2NkQkVJaFRkVFlWaWd2U3p3eVRTSVlUcHI0?=
 =?utf-8?B?d0RVUXJBTjVZMXVrVVRjTnNyZjRJd2ZOclVGdU40Q3NYZ2toN2sxUTc5SmV5?=
 =?utf-8?B?UE1ZalcxbzJUTm1QMEpEMk5qZWQvM2hNWDBReHlNNTlDMFM4ekJMKzJ1akI3?=
 =?utf-8?B?NWIvZG1jaklmOUY2N3NucXByak03L1RtSThaN09tUWxsYmczOEs2V2ZOYlcr?=
 =?utf-8?B?UUxTY1FBT0ZFQzVYbVkrWnRzN3lMSURnNC84SzMzdm1SK05PNTdNc3dTdWVN?=
 =?utf-8?B?ZGFYNGZRRi9JN2xlTjh2Sklic0JrNHl3dXM0YVZiV2Y5dkpmZXA1c2UwNElF?=
 =?utf-8?B?eDhPRjRYdEdTcExiRERPcTZYcGM0aFlhaUZOVlRIWVRVMk5nbGFXVUdjd3I0?=
 =?utf-8?B?cGF0U3JBUXVYM1UxdmpqRUJWdHJBQjc1dDAwMWxZTjJQeU5jb3lVYUcxb3hl?=
 =?utf-8?B?Z2NiMHJhTnpFdm9GLzBlYldoei9pc3IrQkNMRlk2YjE3S0ROczNOWVJ6SHNZ?=
 =?utf-8?B?N0xEdHRkbDhWNHhrbXM5L3g0QitkTjQrd2lOSmd5Nkh1UnlQYTUwdFhLUDAr?=
 =?utf-8?B?d3JLcThiK2FtQ3RJM3dlNVFGS2ljWkxJV3NoRkc2b2h3cm50WDEwWGJJbnk0?=
 =?utf-8?B?RzRNUkZsOHFpaml1SEVPYzVmRTJyVnluTDMwblAyZVhaMGZ4ODRtOHpYd2pp?=
 =?utf-8?B?d1B3enNvRG1qK2ljajd4ZE9kY0ZVOTVoeXlVbHAxUStFN2JtUk9UZGwwZXZX?=
 =?utf-8?B?K2RyTG5XU0llR1VkMTVGblU4c3luVnordHhjYnllZm5UUGMyTXNCUWExTHQ4?=
 =?utf-8?B?dVdTVDUrMHZqNHVtQ1IzQ1RFaXBId2JjTnlkSzZHV3RsNUpYVGpNcE1aUlBs?=
 =?utf-8?B?NTFJY2JkY2doSkR0N294bXJjS0FnRHh1UEV4TFBTT1h2YjJUWURXTVQxbm1w?=
 =?utf-8?B?enNqZjhFcjg3NXpHcHZrYkE5ODFlR1VLRTFZYkQ3cjUrTmhXVWJOdFVKV1dh?=
 =?utf-8?B?dk84REhrVldxYThnanM1RThOKzYvWU5rQjRJZjhTRTJUTnRCRVZEK3psZEdV?=
 =?utf-8?B?cDFhUGFmQlorT0VFNUVuZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VSt3WVI3MlhZa2Z3QXpFVWthUUY5Um5vUVh2dWRwOGhzRjBVREpRd2VWVXUx?=
 =?utf-8?B?cFhPSW8rRXFBSkU1a3ZGOHhqK0JURkl6Q0Flb3lRVjBkRVVMVi92UVZjemdP?=
 =?utf-8?B?ZUhKLytrY3BxS3pvOVQ3Q21QZm00OFRHd0hTYUpZVHlYT0FkcWVuMzdhcmlP?=
 =?utf-8?B?QnJDRjMycVJNSGhzeG9OY1dDNGFUREZza1ZJVEFEbXlXRUlFVG9WVEQ0aFlV?=
 =?utf-8?B?emR4d0tRZFlqMFBmaUVFWkUyUFBUcG9naUM2aVBCNkZlTlMvSmtzazFEeWND?=
 =?utf-8?B?TWZEUG5iKzhsK1lVdnVsc21ZQUFMczk4WFRzWVNDd1BuWWdoM2ZnckpxdDhR?=
 =?utf-8?B?SGdxYzNXQ0x5anFzN1dDN1RjMS9DNWg1VmhGa090NmI5ekx5S1pUVUxCL3F4?=
 =?utf-8?B?OW1rcVBPUHBHLyt3NHcxd0tTMUlwdHVkQ2dwcFdPaXJmNHkwMDVFMTdLSzNo?=
 =?utf-8?B?Q2Jqc3pXOU9JOG0yVnRVSEJJNDJYQ1h4RHYzdmxKUGtsWG5Zc3c3OHhodEp3?=
 =?utf-8?B?ckZBWHRORm03WTBkK2tpZVo5K2NYZ3VOWUl4TUZrWlU3MXUwYnZrYkdxcHpp?=
 =?utf-8?B?T2RXVHAzcDgybGRvSlEvK3lVR3IyNkt5ZEYvWW04YWRISXFRQjlSaFhDc1oy?=
 =?utf-8?B?UXFlanh6cUNOeDZRWVhCbytOVVRWMFBSQndnQUFMczlzc1paTEQ5U1NCNCsx?=
 =?utf-8?B?cDhacGJGZ1h5NUJmbFg3MTZreUlFaXVtYmdhTE1kWkxpYzdTeTczcTgxK3Vu?=
 =?utf-8?B?THU3V1JNT3BJV3R1MGNIWUs2aFE0NjFCKzdTL1hBMXBIdVgvQjRTZ0RZN3c1?=
 =?utf-8?B?dUU2WTlJZ2tZNDM1WXFXdWFiRm14eldacFBWV0l0K1FhN0xQdFNjTEtqdWRi?=
 =?utf-8?B?QVdTakNsdkUvcG1BUG55ZXlwMDBtNTE4Y1dsdnh6clJ6eVBONGg1ajV6dFBX?=
 =?utf-8?B?N3M1cjVQWVVva3I5YWk1alNHT3VYMFp2U1QrQXhwb2gyczE5L0tVQmw0VTR4?=
 =?utf-8?B?bVJzZFVpaDAxRzQ2eFg1OTU2TGlwRmVKSnd5Q3dWbHcrRkhLUlpPSmgzSjJk?=
 =?utf-8?B?R09JSi9odGNyZEFhSGNsWnpQSjRZcFhRbnY0QmZPb085STdlc09Yak1XNkpX?=
 =?utf-8?B?SjhaS0VLV0Rwa1ZKR3BQenJsTUdJOExmN3hwSlNUb3RnZmZsTkxKbDhyNVpS?=
 =?utf-8?B?MFlBbDU0aEp2ellGc2hXTThiUU5DbzZkK1ZYMnk0aHk2UUlzb2R4dTNkdWZC?=
 =?utf-8?B?SGhYR3o1bnNEbEdkdG5nYmN0dytrRVhRY2RvSENwejFWOGpUM09oSDI2c21w?=
 =?utf-8?B?S3NUdThQcGFhb2QrQURMMlVUNW54QkxRWEV4ZTIvK0Y2QlVrQmVnTmJQa3JS?=
 =?utf-8?B?SzdFb2FOekUyUDJuYXA3THZDOVRMVllQRkNRT1hMR3IvVWVlLzgvQnRPOXlN?=
 =?utf-8?B?Vm9DRXIvWEpiRTRzWC85dVlOZlNTRGlDSjA4RmsvcmQ3OUYwNDREMDBHZTY1?=
 =?utf-8?B?ZEJNRnhXeVRLT2dzSEFsYnZZdjdmNktZZnJrQlVZWGJjbXhLd3F6dFZYR2pR?=
 =?utf-8?B?VDZtbk0zOEFLZlg5R01QTERid1BjRDBYNDc2VlhJdU1zK2JJVHkyWHdiZkpC?=
 =?utf-8?B?ZzdhNlIzbWREVlVvRTRHbXY3RGNlaWpWWVVuZHg1ZlR0cUM0R0dxcVJvSlo5?=
 =?utf-8?B?N0dtbEVMMXR4R2VVYTFZUmdDWGhvME5lUkk1bFN2RXNqUEpyaTE5ajB0K1h1?=
 =?utf-8?B?TlhubTgyMklBRzBVdlFpUENZR015WEdadlQ2SUpkSkhyZEQ3QmRQSXRPbzl5?=
 =?utf-8?B?bmhuWmtuMG5FOVlML0tsYjJObXdYdytMSHNndGZXSkx6azJRaGY5eU9ISlZV?=
 =?utf-8?B?aTFLS3hOK2hQRmx5YjJKM1V6bkhZVzkyS3pEMzJGWHNaV2J3L2ttc2RTcVFM?=
 =?utf-8?B?RXEvUkF1S0c3TW9YRU4vWllmeW5KVW5YYjlHakdrbDFpaURBRkJhTk92ZGdx?=
 =?utf-8?B?MWd6Zlc0bitKYkRzUFhUeTIybmZtYXZNVTJSYVBXS25mOUU5SWlkOWdPNkxY?=
 =?utf-8?B?UlcvSXg1L2lqQjBNMnNheVYwK3ZQbG9Md0J0SVlqbDBQSC85amJZMzVIVUMr?=
 =?utf-8?B?YXRTS2xNYk1FbHRwdHA1YURhdkZONVRPYmxNckVmcnNXN0ZkTzE2UWdBK29w?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Dc7exkQovRsgCYsLio61XZ6X9WVcPeaZUHc9VdbZ5GvwMhNYTIfrPw/arRh3sVQWdBZHxpheqdaOIcukbG9T3SfBkSXwcJAjugsUbNkpTkXzlsv3Y1CuleAN4NH1VRmOwg9BeXqmC2nrzfBTylvAGIFrWxcJuS7KepPCqcy5xgw9Mfhcn7Z6GjfdvDHHl0R1MfYHNVzsAJ4xC/EYPjSwAp+CM1XcfYlt20BBBja42Wok8aV0kOE2/fpalE78DhU0dwwAVtDABCHQXQLMIKz7dZm62lLtgftkJOM1FIseqcGOXBqfVA/Zk75QM82BFlWTy/7Tg+m9s7GHf8T+t6kWU3uJGvMAv+Gy7Nw2ZFl7kXp3UL1INcZVmB8+e6t9c9R6Msq2csg4cTPKkSahbXPgs2CPnta1yhksE+4JLyZbNX5rINXpQnp6egKvXrfzRdy+vCmYsUQmswbMDjrIAvAe0YegGzO4FxY9EQJXRlgOzMDqy2fXv1q87PG0eBgMgNsfZcfyxVS6KORZqz4OeIUtSB2D8Mfwo75h6MSzuRncozP+b3oLxzXkUyJsSExn+7fyElmkfoZh1zw6SIxcxXSfOZehgGWiUymcUvOYeVp+Qgg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf89cbe-3455-4775-2717-08dca0cf6252
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 10:59:35.0061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUZJ0WAWN3m8kEWHKWS48h2Jtgs+aPBrOwbuvwCfw1SA6TtkuDADl5AMqQ43zPdaNgFAXrCMake415fvZ83n9uCALRDeU555OI9i/9z7SFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407100075
X-Proofpoint-ORIG-GUID: 6hWJrRlf8rOTQUjOP-gUhgejs0AioG6X
X-Proofpoint-GUID: 6hWJrRlf8rOTQUjOP-gUhgejs0AioG6X
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 10/07/2024 11:38, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: [PATCH v3 09/10] vfio/migration: Don't block migration device dirty
>> tracking is unsupported
>>
>> By default VFIO migration is set to auto, which will support live
>> migration if the migration capability is set *and* also dirty page
>> tracking is supported.
>>
>> For testing purposes one can force enable without dirty page tracking
>> via enable-migration=on, but that option is generally left for testing
>> purposes.
>>
>> So starting with IOMMU dirty tracking it can use to acomodate the lack of
>> VF dirty page tracking allowing us to minimize the VF requirements for
>> migration and thus enabling migration by default for those.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> hw/vfio/migration.c | 6 +++++-
>> 1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 34d4be2ce1b1..89195928666f 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -1012,6 +1012,7 @@ void vfio_reset_bytes_transferred(void)
>>  */
>> bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>> {
>> +    HostIOMMUDeviceClass *hiodc =
>> HOST_IOMMU_DEVICE_GET_CLASS(vbasedev->hiod);
>>     Error *err = NULL;
>>     int ret;
>>
>> @@ -1036,7 +1037,10 @@ bool vfio_migration_realize(VFIODevice
>> *vbasedev, Error **errp)
>>         return !vfio_block_migration(vbasedev, err, errp);
>>     }
>>
>> -    if (!vbasedev->dirty_pages_supported) {
>> +    if (!vbasedev->dirty_pages_supported &&
>> +        (vbasedev->iommufd &&
>> +         !hiodc->get_cap(vbasedev->hiod,
>> +                         HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING, NULL))) {
> 
> What about below, this can avoid a new CAP define.
> 
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1036,7 +1036,7 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>          return !vfio_block_migration(vbasedev, err, errp);
>      }
> 
> -    if (!vbasedev->dirty_pages_supported) {
> +    if (!vbasedev->dirty_pages_supported && !vbasedev->bcontainer->dirty_pages_supported) {
>          if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>              error_setg(&err,
>                         "%s: VFIO device doesn't support device dirty tracking",
> 

From the kernel POV this is supposedly device specific, and the
container::dirty_pages_supported doesn't quite capture a case where the system
is less homogeneous (aka more than one hwpt where one has dirty tracking and the
other doesn't). So asking the HostIOMMUDevice sort of futureproof it (and better
represents the kernel interface). But I don't know of systems like this. And
furthemore mix and match of device dirty tracker with IOMMU dirty tracker isn't
supported in code, so for now I can look at bcontainer::dirty_pages_supported
and I'll remove the CAP addition.

	Joao

