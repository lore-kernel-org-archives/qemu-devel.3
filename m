Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFD7C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 06:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW8mb-0004fK-QB; Tue, 23 Jul 2024 02:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sW8mZ-0004dP-3D
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 02:13:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sW8mV-0000Cm-Aw
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 02:13:54 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N6BU4u009446;
 Tue, 23 Jul 2024 06:13:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=Q1PexP3Se7nIM1/Kx40LWbwSzGXEs0tYKHtKLgec8Dw=; b=
 TrIEF+HkMOU0l9oYxQEUMsWLDDmQwituVDIs+HwXRT7tZAk/zMj7RxCduhO9Zvdw
 3kTfFIlzNRKv+5Kus4hoEDJpduifkJBRK3lgaAE4ANQ8+e2kQSli7Y1e9EouFzY4
 L1BULxQ6SGtxmW35U2li8byCHPcauraSdJEtSkTvAGdG0EMXv33/xcysR9smCpCq
 Iy99Y92SE2SOOIa/WdHais3c9Hj4kOjxMsBsj9zWylugkl4KirSLyanRxLGIJYYk
 h3lwMNWc52WHvqneZg3IKhHI08axqSici+3E1WP7ztRTZIUXuxDoxu5WOby8ST3+
 TEcaSsYEGB8r3WXSJM7qIw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hfxpdca0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 06:13:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46N5FOB6024953; Tue, 23 Jul 2024 06:13:46 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h2a0yvbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 06:13:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+0OCQpaaIXv8I+wo7OufNu9zt8U7Vt1+1ho+vQnEpgr87MIuGgw+zksXM6BZ+8X2VjBvjs/bei6roiPM1L4FgVko5UbfjP0hdI5a3wqQrDBUdcme9JXaai28FGSlN5rzR9NJRF/PUuHToaMyOvrEXl3LDQaMbYiv3utdBrvzQVJnDME3rfVFnFnJ5Qkp/ag4L2whNrtOPO9ikBiFBucmTYkLV40v7lTJJKREF3VLrfa+BaLh7oHFoF3DgkeD3MeJ45B+LJsghO89O/Q305Sjymw5oiD7W/eXkLOf0LY6mI+jZspnf/TQDCMvKpLYjFhlD+HlySONyKvw9us3Bo4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1PexP3Se7nIM1/Kx40LWbwSzGXEs0tYKHtKLgec8Dw=;
 b=IbJGu1tKPHxo019zXtiLpJ7/dWm9SBvMD3SJEhhGnL2vmghcn3mROjoEbprX6jKdStmNGIn6M8WnnrHIlUcOGed3ekxY7lFY8Vt2gc+pDpt0YgUB5roiVz5nAT5hyOAAgXV+W3ThM6/w7HtEdpj60rMV3BEjIFwdtY4FqE7W2GwMcIPLWWT4XYA5ucs1HwOJ3liK1DgXIxb1DAIxwQE74IsnRTNi/prWM2wApk/IK05v4ciFPsnJcT+52NZGvp7+UeahT1rmF3iy5j/oW74sCxoq2XUj/0wlfy59ncrFAq0OqayOdpeDSYP/W42vwlOeNi9z85G+cFxFKi41SA7+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1PexP3Se7nIM1/Kx40LWbwSzGXEs0tYKHtKLgec8Dw=;
 b=BzjiEr0eJYRxgt6tiwoQpaL6n+bmhzzc95faUTmzaRw+0RIHmMMrVH+0/L8IEswC0S3Bw8PC5w/RjTR7PtkgSlzhmNfIf+HYAF4ApFw5QVn0lZOmhlXzvWuY45rZiFkiiFmi52C9F5Gr+N0GTzy7GeWWMyFhD+eA0Glq5BLlHDc=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ0PR10MB5695.namprd10.prod.outlook.com (2603:10b6:a03:3ee::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 23 Jul
 2024 06:13:43 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Tue, 23 Jul 2024
 06:13:43 +0000
Message-ID: <88eaa782-9221-4fce-90ad-353487cae649@oracle.com>
Date: Tue, 23 Jul 2024 07:13:35 +0100
Subject: Re: [PATCH v6 5/9] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-6-joao.m.martins@oracle.com>
 <SJ0PR11MB6744237AD1896B5EFA8E045B92A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744237AD1896B5EFA8E045B92A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::13) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ0PR10MB5695:EE_
X-MS-Office365-Filtering-Correlation-Id: 954060ec-834f-4c7d-2a7d-08dcaade9a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tkh1dDJIQWVmR0diNGQyci9iYkhNaFlYUVA4N1JBUnJWWnUrc0Yvem5IV21X?=
 =?utf-8?B?WUtHc2ZlQVhTWTdNa1NRV3pUd1FDMUNHakl5ODV2aEhCd1dnUWlvYVkvdEE4?=
 =?utf-8?B?RHRhd09nSmRTdEtDWTBKT2JZVllCQVFUN2szaFA1RmxLaUF5V0ltL0JHN3E3?=
 =?utf-8?B?SDJpdER1clpQSTAxNWVKNnBibUFkMmRjUm5DbFhZeENnWHNSNGtjZU5oRnRT?=
 =?utf-8?B?VU93Y0txUTdxTGQ0bkhraVR0SDk0L3lUNHBoMmdyRnR6UmcwWXZmNDBBSFB1?=
 =?utf-8?B?S25qalpXaDl4R0lTYUswM2RVL20yN1hTR2ZWUTM3c3Axd1NpeFNMWTlwblVi?=
 =?utf-8?B?dDZFSlQ1N0FnSnlDS1RSdm41WEFUOHFIQXkrT0IzbDl5SmdUbkNaMDkrOVI1?=
 =?utf-8?B?dWtkS250aE51RmN3R0Npd2xtOTlTOEJtaytFODFTMnpwenB3c25MamdyWnUz?=
 =?utf-8?B?bHBja01OUGRYSnBxdGtJYndNSGFEQ2xJQm81VnBibTVPQTJLT0FCaVE0NVM3?=
 =?utf-8?B?a0o2enZvU0FZNFFnOWlQdHRLdHVWYWw5RkZOUlZXUTcrdkJhVVlwQ3ZrVVkr?=
 =?utf-8?B?cjIzM1d0bUxwVmo4dUNLS2lydzJtSW0vZ3EwcitkWEk1NkxHQ2dPcWtwZmV6?=
 =?utf-8?B?N1ZMMy9MTE1IQW9PSkRFVnorMXRSRG8vRkpYS252Uk1IMTZseExudHBpWURR?=
 =?utf-8?B?TUFFOHhTLzd2Q243UjY3RlJMKzQ0NmQxMkhJbkxwNzhOOUMzaVRFQUZDVnIz?=
 =?utf-8?B?RWM2S2FFeVlTd2trVnQvZGRkbXBWcFRCTkZ5SGV1WTlNUGtqZTVJUFpsNXN1?=
 =?utf-8?B?WnF4eWo1dlJ4NzZTOFltOTNYazYrdHV3eEs1c1VNOC9DaGRzRmNGaVFRdWZS?=
 =?utf-8?B?THRJaFNpZXVmbmtHbzZqNHJuTHhEeGs5UEo5aFk3RTgrQndxTWlVSEcxTUhF?=
 =?utf-8?B?aEJ2NEw0SHVzMEs1VUQyVWVURCthVnVsWUdETlRkajBZQU1YRTlKWHc0dnZk?=
 =?utf-8?B?SEI4SDlZNTJDVWYvR0VJSW01M0NMWnMxOFNkYTJCQ0ZGSnRSd2lLMjZmb2Ux?=
 =?utf-8?B?NjVJVU9YMDVGMkJsVDlkS0g0cEtiTVNRY2dGR2JBczk0S3d1VGFURm92MTgr?=
 =?utf-8?B?L2F3ZDlhV2Naa0o1OS9Nb0hZdC80UjdCS0pWM0UzNTM3dmxSUHNCbGZSK2RI?=
 =?utf-8?B?ZFM3M0JrN1dEdFdXSnZTSCttUzFEUk1NN0pzZ0M3L1M4VzdTTWFGamx2UUpm?=
 =?utf-8?B?MnlWdzlwTlAyVnI2Qy9nbWdrUUt4NWVmb2FkV0d6TUxwcGVxOUhxS0Rhbzgv?=
 =?utf-8?B?aTNZRVhrYmtFaFl4bU1vMjJzb0F2M1k3aitlaTJXYlZaQkFLRnNCZTVBb2cw?=
 =?utf-8?B?L2xTMGpOeHJ3cGQrenZKRjZmZThxV2l1WWNwVEFwbGtOYmdQOFpFZnIvaTlq?=
 =?utf-8?B?UmdEYUVuZ3dRTTdRdmZWbG96QUkwd3hwOTJrM2NFYVA2OE9Od2ZKMWdrUUNo?=
 =?utf-8?B?QTZ5RWtkZjBkQ2RWTEhTTmI2L1QxdzZWOWZaYlNTZ1VjNEtVWDY2TVE1TGJm?=
 =?utf-8?B?d0NUclNSd3pmc0lxbTRtbmcrQUhxblNDZERFVTl5MHhjTG11aEdMbUtNZkFl?=
 =?utf-8?B?eGxnREpQMzFoV1U3ajRRcFNuMFN1aXRkSncvallrYUhBNXpPZ1k1MER6anhU?=
 =?utf-8?B?LzQxUnVWV2dEQ0dXUi9ZOEYrQUVuSXoycGlTd0VwZVZZRzV0TGFTdC9zM212?=
 =?utf-8?B?SE9nN3pNMDVnUGZlRDBmSEs5bDJBTk9MZW5jaVY0UThXK2x3WEo2aXNKOVRZ?=
 =?utf-8?B?Vks5Wk9GMDc3R2t2MjNlZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWFnUlF0bVp4SmM0czZETHFqekJZZ1ppbEhVMzZsYStKRDJPb01vRGlLblpw?=
 =?utf-8?B?TXFkN0ZkUmlhRFdyRUNuaFMwNmlWcnN4OHhYWVBGNUhRUzdxNkNxTTBlamJ6?=
 =?utf-8?B?SFpUbVhiK2RDenRJaFArblRaUnRBdm1YejNHTExtc2VIL0xURC85VzdOL3E1?=
 =?utf-8?B?amNLMEdJeitIRXhVb0N5T1JEQ2NUbVpCUEpTbjJ1UHVBQnBaUm1YMCsrdURN?=
 =?utf-8?B?U3ArQVdYcTd2aXlsWnJrZkI3eno5YVRkNEhpUytIKzMxd1ZrL0E2aUZUWFRS?=
 =?utf-8?B?dlY4Z2JDNVBlbjRNMS9jeERYMHhFSC92R252YzlQdElPWlZsNWZDYnYwQVNq?=
 =?utf-8?B?b0xyQ0h3MmRUQ2xpcTNyVDZGSXRHckswVC9aWDhmN0MwanQwbWF5Z1pWcHBv?=
 =?utf-8?B?Z2tNUnJmdnhHWklmbFp1N0lGNER0Zk1mNXB3eFZRdlVldXFKRWFSNTN0Qzhl?=
 =?utf-8?B?U2s2aXlrMjBPQ0d1MVhlWXEwcE1iV2NxOEFGeEdhSTFiZnNsZ1YycldUVGlS?=
 =?utf-8?B?dTZWRWxvbG1YRncxaU8rRDVTWmprdWhCQmkrWHRXcmtkMXNhT2JsdlNvYTlQ?=
 =?utf-8?B?TkJFNTR6T3ZZV1d6bXdCUmNkQzdDRUp2SExFeVpUcnNDMm1rMk9mRng3Mloz?=
 =?utf-8?B?V3B2bWpaOGhralNrVHF4eUIwS1RxclJqMjlIZ0NIYzA1YVMxc3IrbzFRcUhV?=
 =?utf-8?B?VXNJNDRHekdvZ1BRVXRvNDRiWGx5dGxZeHRySEs1SnZrNzd3RWVySXZRV2JT?=
 =?utf-8?B?Ym9jL0hhVHJtUldOcVp2RytYWU9nZm9UY2ZpeEorNDlvMi90eksrOFdad1Js?=
 =?utf-8?B?TG1Hd3NMTE9rWElKakVtSFhBUlZURkJFOTYzRkJqY21PNTRMVXluR1RXVE90?=
 =?utf-8?B?d2J3VlVlTW9wbUJONjcxd0lYUjYzYWVFUDNKeDBhZ2FXM2YwZURLVk1wS2tJ?=
 =?utf-8?B?dGhBZlFGcVRaOE1yZ2VRVnhvSXAzQ1drRjl6dUJQQm1GSzNpWFNRK2FYWDJk?=
 =?utf-8?B?bVpYMzBiVlFvRC9BNFJFcXNjV0R3TllObVJUcXhEaTUveTM5YWpSdzQrYnY1?=
 =?utf-8?B?eE0xeERNSEU3L1IzdXdLUUs2KzVWdVpTQ2hQeHRQZ1UrWWltK2ROVUthRTBy?=
 =?utf-8?B?ODVHY3B1NzNFWVpZd1YzcXZZZlpNRDJnS2V5d1F6dDAyeTBhRFNtZHo1Z0JW?=
 =?utf-8?B?UVNyeFZ6NXZGOE5EcW1RQ20rM05LQTYrdmxmQXdvSXFyOU5qZlpxQlllNStX?=
 =?utf-8?B?azI5VG1XZlZEcmQrcVBWNytZWWg2czMvTHBNa01qZXV4K2hKYU1WR0NDOGgv?=
 =?utf-8?B?blRKbmNJNHR3cGhiTXVmWklRZS9XZkdzZjFyK21sZ1hsaVJUbDJZYkN2L29T?=
 =?utf-8?B?TU9NVThaMzdkMXBaQkErckNPRkZLSElHcGIxaWx5NU5YR3pteGFLNkVESTI5?=
 =?utf-8?B?amt5WGJZVXpjRDMwV2RzcWJhYU1rMzJzYWV0UGdCeDhNSXJWaEkrelg2SGRT?=
 =?utf-8?B?Q1ZOQkkrTTJMalZMcmtuUkpLa2NwNGE5UGhmZ0xLYkNxV0V0bHZqWSs4M1lt?=
 =?utf-8?B?eFdYZDZ3bEkzNWd5eVdNNktOdEdzbm1qc0lIL0JQRDFkalNteXhhOGFXUkRT?=
 =?utf-8?B?dDR4T3dHSzFHSEwzb0VoQTdzeXg3N2NhZno5RXlRZDZuL0QwUU50dlNJR1Uz?=
 =?utf-8?B?Nlo1Zm81Qktyc2I5MkFxTDJ4VGJmY1lkUGN5RTVjVytFeTNlMkswZG9aNU1L?=
 =?utf-8?B?cEhueUg2MEVXVUxYRHNZRlphWjZjYW9MM1pSUVFBMjc3VWtqQVp5R0FQZndI?=
 =?utf-8?B?Rkg1dno4Mk9RRVlOZ2lMZU9iQi9qeWt5YlNSc0tzMFBQNnFEZHRCUUdreDRz?=
 =?utf-8?B?REVVKzVBQnVLSWYzNVljQVh2NEtBOGhoNXlET2JjT1lIWlZhcHovVFVrU3Vj?=
 =?utf-8?B?dDJBKzZyeXdpS3U2OHhMMGU2dVVzY1dxRSszVncySC9uM0NWWFl0Skw5S0JT?=
 =?utf-8?B?QjdySjYrU0R1Zk5rTHBEQjd4enJjcW5nK1hNcDBiOExKenRwdTVUK1d1Z0hy?=
 =?utf-8?B?aGJYd1BIRzliSDBPUEN1ZXArc1Z3Z3dVNWc1SVBkM0xURDlnY0M0V0NvY3d3?=
 =?utf-8?B?MlUxQlF3REg0V3Njb2dhNFNablVjNU1IZWduT3NwTlRUdFhNbGNDcnRJTWsz?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1xypAY9k6wk40JItxc/VPLYzO0FHg6Ypj3HHLgpqOn0HqhZzfMBCrWgad/MQGFLtbCjGwZKIdqMWvv4j+HNx/aqco9p6uSXLO4CGH2ISUqIrgBYhs8J5UeK3kOta4x6iDtNCiwOJVrAFyRH+sD6YO9+0ESvdFpbbA+n8UD1UZ6iHVVP4GWvpOtrv3xj2qQIV36bpnXmLUvYAhm0JOGnWF7omPwhjggQsAn6pCFt2BTeBI9e+xJERciNLUS9NnFt2h+m8ExX+kBryikhUJzJFVyx5Zah112cdUwqB2ik/VgIzQpPYDFQhlJmZyH1qQbrEDWvXNu0abh4ewrtyNBcbn88Zb1fu6lyzK1TyDfLcX0NThhIqYkthPMs9GxPhfFRuLskrMJO1xogzUiao/SQZDtKkqUvqBqnmNLQs0WC94qho0I1/CSk++MnCZPa2AIaEWhoJs8MB7E34Jyrqbq+0AAhzeoLr+kFWpWW88QexWlRhi4SMSZT4A43Nn1uN+A5dmroqLEYiZp17E6dTcqb4WZuVtCtPq+SzdDJrbl5bfeNuHpcgZyNlZxBJOL8KjCKFVyva7/Av6xblmwujbjRtLkb3y5zzDBhJKapQe3+rQ9A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954060ec-834f-4c7d-2a7d-08dcaade9a65
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 06:13:43.1822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9ZBJ/uVgOHk2g0A+HXl0YKPz6wM93gGMAzPV/KZIk8hcCpdb8FF+uy2j210I/VzsGErVQTaZZTtliXvfm/eQm2MbiHBH5jqSAH4hyUmy1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230044
X-Proofpoint-GUID: 9PdjN9Z74Colfj3kl5dLY2DTuCng5dS8
X-Proofpoint-ORIG-GUID: 9PdjN9Z74Colfj3kl5dLY2DTuCng5dS8
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23/07/2024 06:11, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: [PATCH v6 5/9] vfio/iommufd: Probe and request hwpt dirty
>> tracking capability
>>
>> In preparation to using the dirty tracking UAPI, probe whether the IOMMU
>> supports dirty tracking. This is done via the data stored in
>> hiod::caps::hw_caps initialized from GET_HW_INFO.
>>
>> Qemu doesn't know if VF dirty tracking is supported when allocating
>> hardware pagetable in iommufd_cdev_autodomains_get(). This is because
>> VFIODevice migration state hasn't been initialized *yet* hence it can't pick
>> between VF dirty tracking vs IOMMU dirty tracking. So, if IOMMU supports
>> dirty tracking it always creates HWPTs with
>> IOMMU_HWPT_ALLOC_DIRTY_TRACKING
>> even if later on VFIOMigration decides to use VF dirty tracking instead.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> include/hw/vfio/vfio-common.h |  2 ++
>> hw/vfio/iommufd.c             | 20 ++++++++++++++++++++
>> 2 files changed, 22 insertions(+)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>> common.h
>> index 4e44b26d3c45..1e02c98b09ba 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
>>
>> typedef struct VFIOIOASHwpt {
>>     uint32_t hwpt_id;
>> +    uint32_t hwpt_flags;
>>     QLIST_HEAD(, VFIODevice) device_list;
>>     QLIST_ENTRY(VFIOIOASHwpt) next;
>> } VFIOIOASHwpt;
>> @@ -139,6 +140,7 @@ typedef struct VFIODevice {
>>     OnOffAuto pre_copy_dirty_page_tracking;
>>     bool dirty_pages_supported;
>>     bool dirty_tracking;
>> +    bool iommu_dirty_tracking;
>>     HostIOMMUDevice *hiod;
>>     int devid;
>>     IOMMUFDBackend *iommufd;
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 2324bf892c56..7afea0b041ed 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -110,6 +110,11 @@ static void
>> iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>>     iommufd_backend_disconnect(vbasedev->iommufd);
>> }
>>
>> +static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>> +{
>> +    return hwpt && hwpt->hwpt_flags &
>> IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>> +}
>> +
>> static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>> {
>>     ERRP_GUARD();
>> @@ -246,6 +251,17 @@ static bool
>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>         }
>>     }
>>
>> +    /*
>> +     * This is quite early and VFIO Migration state isn't yet fully
>> +     * initialized, thus rely only on IOMMU hardware capabilities as to
>> +     * whether IOMMU dirty tracking is going to be requested. Later
>> +     * vfio_migration_realize() may decide to use VF dirty tracking
>> +     * instead.
>> +     */
>> +    if (vbasedev->hiod->caps.hw_caps &
>> IOMMU_HW_CAP_DIRTY_TRACKING) {
>> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>> +    }
>> +
>>     if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>                                     container->ioas_id, flags,
>>                                     IOMMU_HWPT_DATA_NONE, 0, NULL,
>> @@ -255,6 +271,7 @@ static bool
>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>
>>     hwpt = g_malloc0(sizeof(*hwpt));
>>     hwpt->hwpt_id = hwpt_id;
>> +    hwpt->hwpt_flags = flags;
>>     QLIST_INIT(&hwpt->device_list);
>>
>>     ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>> @@ -265,8 +282,11 @@ static bool
>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>     }
>>
>>     vbasedev->hwpt = hwpt;
>> +    vbasedev->iommu_dirty_tracking =
>> iommufd_hwpt_dirty_tracking(hwpt);
> 
> Don't we need to do same if attach to existing hwpt?
> 

Nice catch!

Yes, we do need it e.g. we will need this fix up fo this patch

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 92b976464283..833a7400486c 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -305,6 +305,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         } else {
             vbasedev->hwpt = hwpt;
             QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
+            vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
             return true;
         }
     }

