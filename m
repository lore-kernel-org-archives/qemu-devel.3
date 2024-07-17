Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B115C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 12:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU3vo-0007pA-Gu; Wed, 17 Jul 2024 08:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU3vl-0007fi-8L
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:38:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU3vf-0006v1-Fd
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:38:49 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HCUYkL015576;
 Wed, 17 Jul 2024 12:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=odf6F4GgnhpuezzoaDT1oX6Qj0Kn6LzVDrQ0iZnvxpE=; b=
 WsN5jgfDvQ9JCG5KjlY18tH02xdVitwGM4jMPfmQVBYyUfn598xe+4J2by0XJBdX
 fV8WkpgCW3EnjZcaIUhMkjR4fzZBUNjAHt6+ZvtEh/Gahq87ogWBD/64dgWavjlP
 1h+fv7POoGUCO4xe++oLrL392Jg0hSqwErs2TK4l6U5SZO7pdg/gfiRhoLnt+Il+
 bNfS1V9ZLmm4s8ug7bAtXHzWic05Ww7H0oXCxv629a5RYUtnPBIfBrp++aC5ZhkE
 EsqEADZ9GpY4pmyx5VdZZBOO8aqTYWpDxVBcC91Rdjf+eGQJwQiaf0AD+T+qdVD8
 t7KI9g6y5rDbDKAzYegjgQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ee1400rn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 12:38:40 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46HC070B031794; Wed, 17 Jul 2024 12:38:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwexa3y6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 12:38:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4nuQ6Bn3v6ARq191JlazeTEWRVekPH6Iam/flQ1i6ZgIXr/nnH7YFwMBDM0io4WqLgor5DrLgoxOEdtm96o+p3OHMWV9TcWH7sz8SFUOlHWwHz6yKK50iuAj6Bcz6qL8iDuD53qTByVKqklYr8jkVjxWP+eeqZdkNViQU48FtVUr8Jpkms+XMTFfjGxP09aLSviEShIBMxzsjubLGhJ9FPtJMnRroTz0fJ+u7AQkRvFcSRE0J+3YYvF75YmNPAupjAyTNHmIxqfKqsxA89lBHo0kv70iD2UrZsEFcrbWUAaQMYPFfKV4y2xoYEkRA+HUnEIU0VwCPVQeDPCAmF5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odf6F4GgnhpuezzoaDT1oX6Qj0Kn6LzVDrQ0iZnvxpE=;
 b=D5z27XlwJ5hySKQWZqrfZHIPERCWqSESzq3WrqHJDKjpuo2AuBlIFKDglZPzmuNIiajjzWmuWcpKx6Uql0G3N7kgnhvek9UeY9x3AqF8UkHwwZCNaN3RaFlF7TkohzMzDkaJaQtkXxddvt04ZfPNk43ll3Vc8JjZ0Tm1qy8BJJwz9RDrFQ/147S+Q+rV7h2PZdhD7+FhmQT8GY0QKAPiDqOwp3fBUq5K2dwlO80iOjmccPsKHkWM6nBlncGmjBiZ4TUTC9hGeQahyvBzAt0n0+KDDtd4UWYvitKi6KCySJG0c0gIP+QK9XGg83Ncz7jITysXuFR+Ud/eNuPcTKjjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odf6F4GgnhpuezzoaDT1oX6Qj0Kn6LzVDrQ0iZnvxpE=;
 b=ZPIeqSW5A9HD/BhUwRrzGEwfqd9/Ddm/jXVrVUUj3XHHg7jY3VGy5J553f2GKyCxuX7QpTeXy7y/Xmsh4L9eJF/NklxLButFsZ1jog9B1GbumGHPJOeONaCdfDRseVRrfCi8IGzlTQTqxpLY9987GSYf3ucWL6lMoVOj7x1L1dI=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 12:38:37 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Wed, 17 Jul 2024
 12:38:36 +0000
Message-ID: <a6c21e9f-daf0-41cf-a2e4-7450568977c7@oracle.com>
Date: Wed, 17 Jul 2024 13:38:30 +0100
Subject: Re: [PATCH v4 08/12] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-9-joao.m.martins@oracle.com>
 <6001b538-c191-4a78-a3bb-3d57de1b64cd@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <6001b538-c191-4a78-a3bb-3d57de1b64cd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0006.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::12) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH0PR10MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: dcad1a13-eb1e-4745-09f1-08dca65d60d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVYxL1N0WUVnTXJ5N3pEK0pnK0U3M1h3YlZMR3AwWnpmeUJSSHpFUEJySWFp?=
 =?utf-8?B?U3E1RmRidDBhK1hWcnRaazlvM3ZPbFZqMlIvUnNxYWNGUWFXWGYwSXF5MWdS?=
 =?utf-8?B?N1M0czFWWjJBUVRHblM0Y0JKWE5nSll6NDVLakhXOTExMW9VbDJxNGlHU3gx?=
 =?utf-8?B?TkpzNUROaWtpcXA2N1NjS1NGQjZIeTNFQklONkdBcy9CWTM4OEhyL3N2Q2R0?=
 =?utf-8?B?bGFEQmNzeGxzbWJXNXE3UEhYbjlrdk45QVdWSlJIUGt5dVFpRyt4UkY1dDNW?=
 =?utf-8?B?U0QxL2s1TVQ5VTN4ZXZOVVNwYnNFeFJwK1pSblJxUE5PdFdENW52MWtqaGdF?=
 =?utf-8?B?Tm5WcTJOcjBWWDhnR3NqNW9OdWRJNWIxZURKUitvQW5wM2E4d0JrcjNTcDVN?=
 =?utf-8?B?RjcyMjFXeHR3dk9RT2Y0TWVzb01zazBlTllSSGR0ZkdnTWhhbUg5TnVoQ0Fo?=
 =?utf-8?B?eFlGbjJJODhOTTNkZklBSVNSQWg5ZVpzdEhkQk14a2FOQncyL1lSbEVVWE5U?=
 =?utf-8?B?enFrNXRQNnV4bkRhL0ZobklyK24zZTAzbUVVeXphMXFFaXhiazh4SVhBSDBu?=
 =?utf-8?B?RU45MVNxVlYxblZCTURQc2l5U2h5cnFNZTR3YUU0T3AwbncwWGh2amt2WGFP?=
 =?utf-8?B?bnhpbVgrMmVPQXNmZGc5NFlUcEtiallEdEJiWCtCTWNVbHZTMHhROGxRc3Zu?=
 =?utf-8?B?K3JNalFEMGVKLzQ5dDhhd1JFSUVoSTFEN1FZaFRUSkZNcjVTc0lxbGxTZGow?=
 =?utf-8?B?MkVPTUQyb2poUkh5RFR3RTF3NkdsMitLWS8zclVKYjNJanJpY2EyMStoQTc4?=
 =?utf-8?B?TUJoYm1lU0V2b2xzNyswd2lCdnFLaElZcVhpYmRML3ZCL3F2QlQ5UU40Y0Vj?=
 =?utf-8?B?MHBUNlhEVy9DUlAzUkVHYjdHNFdZc3ZSdkxiUUp2bVBncG11WVpYczcyYmJk?=
 =?utf-8?B?Kytob2tpdkF6UTJzb0t0bEpzUlNVQVZvVld1VTM5YmMxL0xLblhiV1dHbmgr?=
 =?utf-8?B?ekdRY0d0aENodVpnRzBTMnNyQk9HSzFRNVFDL3psN0RPa0xCL2VNOU9WNEdW?=
 =?utf-8?B?NWl5UXl6VkE2ellmU3A1YStWaldjMEw2dnFMWEllTVE2RFBlVzk1MkcrR3Va?=
 =?utf-8?B?aThCU2xxeTc1N1RTNk9PZDk5eG1vV3Nnc1gvVzNNUHZIR0pGMWttOEI1L0RE?=
 =?utf-8?B?SlQyUGEvTnJHU1BQblZIUVhIR251R0dMT0t0Y2ZVWHMxSWg5aHhNSHF3alhF?=
 =?utf-8?B?Qjl6WHFEZDBOOUxKQkFlSUZjQzJpWUpaRmIzWlZFcWw0VjFmOVJjUllFRzJN?=
 =?utf-8?B?WU1SaVRoYkFTbWU2VkwvTFA2bEdCZzIyYkw1UUhHQnRvRGRiM0pmOTN5LzZn?=
 =?utf-8?B?ejh5VEtqV3JQRjNtUlhjWVl4Y2pyWDBqcHQ0S2hObVdHdGxBQklJNHVvb3BU?=
 =?utf-8?B?cmZhQUc0TmtJWFBZclJRZjAwWnlNcDBnOXMvMUprSXNyRjd4TlJtaGNRUnNG?=
 =?utf-8?B?bHRyVE4wV2NsbmplaldkSE45dzcyNlBVUUZCVXU1Zy9LTG5lbVA0M0JNQ0RK?=
 =?utf-8?B?NmNWdHVzNjB0SFRyejc0bDRvODdWakxYdk9ScHFuL2dIdW1WNzJTdW43TVNM?=
 =?utf-8?B?NTFqU2ZoamlJUEVrb2QxZm4yM2Iyd2d4MjFCNXpmNnhjMWZBbWNxUkJJRTJ1?=
 =?utf-8?B?dnhZM2NYckRMTFVETXBFUVVqOC8vYnVUb2RBemlUb1ZmRnVOTVh3akswV0VH?=
 =?utf-8?B?MUhFV1BrMm9aYzhjME9XbUZNd1IrVkxRRDRtbDVZeFF0Nms4bTE0TjYxK1Qw?=
 =?utf-8?B?SklYYUxCc214bU1jU2F0Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3pzK01rSldyU3V4amwreVhEQUxpSlgrdlBtNlhZZTJMOWF2c09FZ00xVU54?=
 =?utf-8?B?Rk8rMU54THR1cXlZSDJMWll4THVhMmNEK1M3aWdyMDlGbXhoUTc5djVUb2dG?=
 =?utf-8?B?NmRJUGZtSWNOb2p0eVFLalNzdmIxYU5ZVVIvWkxJclhnZEovQlFJZXozSENJ?=
 =?utf-8?B?RFgwNng2RTdpYjQyMDliUjFMYTZnM2hTWUtJcVFkUDZPY0haVUp6WmdhRHJF?=
 =?utf-8?B?RWYwZDRvN1RycmhCRU94UXl6bjNPa1Q1RE1TSzlkaThwZEtBZHlWODFwQ2po?=
 =?utf-8?B?ZFJybEI3dUF1ZUU2ZTY4bm5Yd0FDVkIvdWNYM25EMGFmZHVMQ3A4WlBkb050?=
 =?utf-8?B?N1NPZnJVbENlZ283WUVYU2Z5dWVmVngxSERVZFp2dk5tT3ltWkRnU1MxN0ZU?=
 =?utf-8?B?cGFkN3lzcXlZWXlXaFpjZFF3ZWpLVENidEs5OWRRWUhTemdtenltVVVaOVVi?=
 =?utf-8?B?ZkN0LzY4anUrKy9wVWFuL1FPcFhaQXVVY1UzamNSQWVEUmFvVlZZd25GSFNF?=
 =?utf-8?B?U1krUHRiRjhHRjVrR3FjSzBnVGY2Tkp2eHVkbjhXTzk2L042MmZBSll5QWJI?=
 =?utf-8?B?NGxkQVpUM3YxUzZUcmk1MUxTM2d5N2tEZ0tKR0NnUG9PTkEydWJwUTVPalFF?=
 =?utf-8?B?L3ROcE5iUW5hdm82bVBneWdYSmJnMS9IWXhDZzBtTVZpS2VhQnVWYlRtY2JD?=
 =?utf-8?B?cHZ0NS9iVmJLV0cxUmd0OVl4eEdDdEVmdjNQMHA3QzVuY1FwZm1EWW5Oc0da?=
 =?utf-8?B?TXJTeURxZlJsVkluM1dSUFNVZTlQL2lGYUw3US9CTFJ0NGZnOUszV3FGTndt?=
 =?utf-8?B?S1lHQlZrWDR3VzFBSUFoUStkY09VT1A0VzVVa3VDRERnWHE1M05QU21IZE5R?=
 =?utf-8?B?V2VVWUk2QTRpdVdvOGJielorSkZ4bkVEVTVDWFVrR0dEemV1RkFnQnVoRnM4?=
 =?utf-8?B?WU9LTXdhdnBxSTZ4M3I4UkwyeC83b1VIcjBPdFdsanYzZk92R2ZtUm5xK3dQ?=
 =?utf-8?B?eTlWb2NaT3FEc0Fsb0kwWXY2ZkJzeENtMGpPaEpIdEJjWnFrdVR2UTZKblhJ?=
 =?utf-8?B?ZG1BQXVLQ1Z1aWdqdHd2MUhPaHlEZHpucHlpRVhuMSsxdEVaci82OG9wTkhL?=
 =?utf-8?B?MHJNaDJ6YUxwN1NBamlFR3J1Wlltamh3emNGdDNqVldDK0liTlRQc2swMkxK?=
 =?utf-8?B?YzFKd21vS3h3U1BUeFR3b1lXSkxtMXNxUUlQc21NcXA3b1VJQy9iZ1V5VVF2?=
 =?utf-8?B?UllJaUNudC8ydmYxMWdyT0UyZnBUNzhORFBWN0x0RURuOW9ZamdENDNuM0t1?=
 =?utf-8?B?TFN0TysyTUZhUVZsQlFIZHlLTVNKNjBMRHJURG40QmxyQlREdHJxM2k3VURV?=
 =?utf-8?B?WFB0YzgyNVNaV0RJQS9TZklkNUVSY0F0S2ZacXJoT0U2b01ITW1nQmZFdmIx?=
 =?utf-8?B?b1dLUUZocFl3dm5idUlER3VPalpNOEVxL25laGticytRSTlzZm03eGVqWXFr?=
 =?utf-8?B?S0lLenlvOHFORzhYbVhHVjFRbG5lKy85UUUrYmVFS0xETloyTGxDSlF4TE8r?=
 =?utf-8?B?OUpZMExRK1FPOVdrLzkyNCtONWVsSkNWRUl0Q1k4WVpUS1FBNngwMUdFcFZw?=
 =?utf-8?B?cWtsb2VkT3ViTmtwU0l0SEd0QUxCUS9qMWYrNTY5Q0tPdThQSXdjcnVqT3Vh?=
 =?utf-8?B?cjBJYi9tNXZyamJJV3J6RVl4dTJHa1RYcjVKSzJHUXhEd1EvRXFsQi9GNmtE?=
 =?utf-8?B?KzZpZ2ZhVlBHWlo3SS9tZVBvcWlKRG04MWlZNmp0TFVPRVJtc1BPMzZXWXNq?=
 =?utf-8?B?TCtTZENVN2N1SjFmMnJwMnFoMHdQc2thM1BadGFPLytSS0dWMElieWo4MHJo?=
 =?utf-8?B?eFhqTm8zWm9pR1FuWEtTK2VhSjJ5eU5vblFLbmsxS2VoeGFEQTMwMU14VUlx?=
 =?utf-8?B?andKc2EwQ1BlRWlpclpNZXF1VXJPNHFSdWNLaW84UDVmaUgrNkE1eGFTTms1?=
 =?utf-8?B?cmFXTmdZVUFIZHpDejRoZGxiZ2swRXBiZWo3ZDFobkVlcXhlUWZ6dVl1bXVi?=
 =?utf-8?B?QWtJMTNzYVZjSTdCQjdWR0NlQkpNSDVFRjlOdW1BMm1vOGZycmRRbVNxTzdV?=
 =?utf-8?B?dXFBeHo0cWFvOWlSUVV0OVMzd1IrQ05jWjFrbFc0MnFSUTB2by9VUTNCMWpW?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YwtTkEUwb0ZYauSdbEBUkE5aWApVqr9vr7wjcZzAGvyiLD8u3bVCqCDnFgvACGYiMTjFx2CZJMew1k7Cahbyf/5tGwqur3OS9cko5nUlGo3SjEa5Wz9+czrBTp87w46lcO4a+do5yesTVzUp+L2eEmyjrKrFMkZfYeJfSE/OmV27LtLQOcKT54srj6XWx5il+UwSKJdAUKdAWjwwf1Nw7ptusmZM4U6K0AO8MowGG5M/EyTY75+sourgC/aT0QkgJehdnjwh+6l5Q3as+edRG6FegS6iD/tGU3sFEPbm/o6iwv/Iz/J18lFJ8zEYKNw6F2gldtUKvD7zLJcXKupKpRx0Hc5uMjpA31cJZ4xgw+pygkZfThDKYn0wzPL4Umwe+ALfR4KqV5/qq976sI0yYgAkRi1W8Sg+smpgkNMbfp3HCD9kf054tYNOYBRa9kndpXHOgmyuyCtrEwbJnQV41ZOeu0An+lD/gLI+Oy6UIQ29H8c0fVGeH77Z7lLoYnS0HUAexfpcAVJpuh7qtSxJ14kt5lvUB5KhL2QyM5HaD18kv77/UulctAGiNKNpARabILw7NItM97ju1uCT9q4/YnMapsS91gJ3U4jAaW8TOIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcad1a13-eb1e-4745-09f1-08dca65d60d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 12:38:36.8999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAxobqeU0UojZWVNPQcrukcVitBaMTljhxg/LCf0XYATH28MHJ8hPqsWtyzg9QOBVm8TgGBgQDywo8Fano3FaRBwfCJYL3jlGKeVZEf5rFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_08,2024-07-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407170096
X-Proofpoint-GUID: LmpVhgbCfkeJDO6cTEaG670E9V-B5-Sc
X-Proofpoint-ORIG-GUID: LmpVhgbCfkeJDO6cTEaG670E9V-B5-Sc
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

On 17/07/2024 13:27, Eric Auger wrote:
> Hi Joao,
> 
> On 7/12/24 13:47, Joao Martins wrote:
>> Probe hardware dirty tracking support by querying device hw capabilities via
>> IOMMUFD_GET_HW_INFO.
> this is not what the patch brings. GET_HW_INFO is always in place.

Yes. This is my mistake in squashing things as there was some shuffling going
around on how we do GET_HW_INFO. and didn't adjust the right hand of this sentence.

I'll rephrase it.

>>
>> In preparation to using the dirty tracking UAPI, request dirty tracking in the
>> HWPT flags when the IOMMU supports dirty tracking.
> this is what the patch brings.

Right.

>>
>> The auto domain logic allows different IOMMU domains to be created when DMA
>> dirty tracking is not desired (and VF can provide it) while others doesn't have
> don't

Right

>> it and want the IOMMU capability. This is not used in this way here given how
>> VFIODevice migration capability checking takes place *after* the device
>> attachment.
> Id on't understand the above sentence
> 

The whole paragraph is meant to emphasize that we don't know if VF dirty
tracking is supported because VFIODevice migration state hasn't been probed
*yet*. And so we can't pick VF dirty tracking vs IOMMU dirty tracking at this
stage when using IOMMU_HWPT_ALLOC_DIRTY_TRACKING flag and hence we always use it
if IOMMU hw supports it even if later on VFIOMigration decides to use VF dirty
tracking always instead.

> Eric
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  include/hw/vfio/vfio-common.h |  1 +
>>  hw/vfio/iommufd.c             | 12 ++++++++++++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 2dd468ce3c02..760f31d84ac8 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
>>  
>>  typedef struct VFIOIOASHwpt {
>>      uint32_t hwpt_id;
>> +    uint32_t hwpt_flags;
>>      QLIST_HEAD(, VFIODevice) device_list;
>>      QLIST_ENTRY(VFIOIOASHwpt) next;
>>  } VFIOIOASHwpt;
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index d34dc88231ec..edc8f97d8f3d 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -246,6 +246,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>          }
>>      }
>>  
>> +    /*
>> +     * This is quite early and VFIODevice isn't yet fully initialized,
> so what's the problem exactly with the above?

I should really say 'VFIO Migration state' here (see previous comment)

>> +     * thus rely on IOMMU hardware capabilities as to whether IOMMU dirty
>> +     * tracking is going to be needed.
>> +     */
>> +    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>> +        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>> +    }
>> +
>>      if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>>                                      container->ioas_id, flags,
>>                                      IOMMU_HWPT_DATA_NONE, 0, NULL,
>> @@ -255,6 +264,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>  
>>      hwpt = g_malloc0(sizeof(*hwpt));
>>      hwpt->hwpt_id = hwpt_id;
>> +    hwpt->hwpt_flags = flags;
>>      QLIST_INIT(&hwpt->device_list);
>>  
>>      ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>> @@ -267,6 +277,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>      vbasedev->hwpt = hwpt;
>>      QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>      QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>> +    container->bcontainer.dirty_pages_supported |=
>> +                              (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
>>      return true;
>>  }
>>  
> 


