Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B05C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWArk-0000xZ-J8; Tue, 23 Jul 2024 04:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWArZ-0000wa-V9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:27:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sWArV-0001VD-04
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:27:11 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N6BSOC010056;
 Tue, 23 Jul 2024 08:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=Xrsvu7fIiu3AEOopW8mKxeTbT58oJouLfUjPOG1wQC4=; b=
 GXXkWXVAkFT7cSaRDz/M75mamh7PXj1esYU8cqcVDrqs4guudltPLpS+hrvO+Lug
 SJUIGMz9IXyepY0FcdgO36Ygz5kyNjAVyeduzVcvzkkzIVQou2WXVknuDUVK10TG
 Dd+4suzzxTiVXNj1yIeMuajjEDwJuqjA8if3escdvvLv0y8nwW2kbVVKXADOitZ6
 QdR2mTjQt4HyosoJ0GWv3/4KbjKnpEZ7VAr7srY0zrDgRq5dRdjRR3+Rl9uK752R
 7999pBOM9tMBTxMN4wzhfC7xjPz5lDozREt3PZ7yn7eX4zjvRQiRyMIl2FJl+T6u
 ZhA6NjeLoi+XckJn3G3yTw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkqwggn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 08:27:05 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46N83dOx024641; Tue, 23 Jul 2024 08:27:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h2a13xj7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2024 08:27:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykzRJqf/fhadpL+yUP9t30y73yV/VL+QtCLN4F7TZQJN2GuPTJPbTus91yaITA/Tnl6i20BfZMA9xjgTq5HDT6BNeeCDkLo+WQdx3CE7kuMZupz8NQ987pwaxt2VwTvdU0e2znIvFG9fKAUSu2cr0XCzzwreq9WcuIgvRchQoI0mImCvY87mdQZtlO4kGnkChF98OOzLzJ8FPhJwoDHvVX1BrVYjHYBPhNYfGNMV+rHkhAt38iEcevx1+vVlSjxh/rbl/SN6EjqzmG4ACmvtG/A3Nti84ZuRVPByZaBO0Z6UkaGUsNwvQOfn/LU6VIcOSVNn/H6mXpenNKkFhXPzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xrsvu7fIiu3AEOopW8mKxeTbT58oJouLfUjPOG1wQC4=;
 b=P6efOEtew6GmfVJiEDEVaYIK0AGqtaNVerL9GJo1SPPju1X9LhI13VMZVYPwGGuXG73D12dOsS8cd+Nhigtvo5E2puqy7fktcwH9P24dOJMjBaKF02/V7tXJkL+xsnjFJr3p/N70zLWZXeBKibZpcnJha+mBQqHIYjYx5aR79WQ3fyCetXcX4fchVj8kkaxwuZye9MiYFvJChykQ03SNCJsg+kEHPJDHsP6xr8dvnkmjUMYaRM+hQF2tgaoac3vS1oioJedHzERUenY4Qcnujp+A/ufvr+6Ye/8u1G8P6mGmxAmMVGbTKcawW4N+1OzVaDzki3aTwvrd1OmnLdxpJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xrsvu7fIiu3AEOopW8mKxeTbT58oJouLfUjPOG1wQC4=;
 b=NXQpFBO26xw4IO73a8oc2Ox0YD2IUGhcDPtTXSEmfT9hCgZGiGII88TdTW3vSmLf0ky4bMt1xa/xpV06J58gyOBdAbXIEcMk+IbyGasVsUdlzNrtujEHORuw8guY5aFf2jGQvUP3mG9cYL4lU4XiSfi6BdFu09fejbLUemKnJGQ=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BN0PR10MB4821.namprd10.prod.outlook.com (2603:10b6:408:125::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 23 Jul
 2024 08:27:01 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Tue, 23 Jul 2024
 08:27:01 +0000
Message-ID: <2ac1d7ee-f679-4e38-880c-870d137c493b@oracle.com>
Date: Tue, 23 Jul 2024 09:26:49 +0100
Subject: Re: [PATCH v6 4/9] vfio/{iommufd,container}: Invoke
 HostIOMMUDevice::realize() during attach_device()
To: eric.auger@redhat.com, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-5-joao.m.martins@oracle.com>
 <a1cc917a-7fa7-43da-b7b7-1b69308400b0@redhat.com>
 <eae669f6-f24f-4573-9934-2c6fb5b364ad@redhat.com>
 <8405600f-ffa2-43c2-8e51-7b6674de11ae@redhat.com>
 <e0ad88d2-c78d-4d28-9655-08fd5a92fe2b@oracle.com>
 <SJ0PR11MB674475ED43B94625DC359AA992A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <79fde766-182c-41ab-b979-ceac088f4f54@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <79fde766-182c-41ab-b979-ceac088f4f54@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0029.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::19) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BN0PR10MB4821:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a4fb04-205e-4e23-eeda-08dcaaf13952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHhUZVNwd0dNRDJoNkRFTXRTQTQrc1FGYWl1NkFOT2VhN2k5dnhKaUd1L0dq?=
 =?utf-8?B?QzcxSWFHOURLQTBEVFo2RDZBR3QxeWkybk9xL1k0aER0Z1AzcEgzbXU2b2hl?=
 =?utf-8?B?M1NuWlNnWFo5MTBBZm9UZnFscUdTc3IvMGFOT2trT3VMakd4anBRY051UklM?=
 =?utf-8?B?QmtUcDNEY0ZBZjlSMjJnNTJNcWs1b0RpUFA3TUI2dkRWTVNBQ1YwdWUzaXRZ?=
 =?utf-8?B?Kzhvb0l0UDdRWjV4UDNaMzJEQnpFK3YyOVhlYldPZElHeGRXY2Q5cUVYeDNK?=
 =?utf-8?B?SmpKS3FLTEM2VHV1N1FWOVZpdXFMaUdick5DYUp3NFpCQWR3L2E5RW82YjNj?=
 =?utf-8?B?d3B2ZG4vbE1XNCtuU3FzQTFHQXVRL21HWndqM2o1ZzZUZzA3WE42NzhYWUtk?=
 =?utf-8?B?WENjdDFIY3VSV0ZFZEczSDFIQ0NmT3g1MXUrRy80bTVvMDA1MmNBUSt4c0Mr?=
 =?utf-8?B?dWlNdmRTK2hNV3krZHlWNkV1RitnVzdaVVBVK0FCT1E2YjQvWE13WXdKMUVo?=
 =?utf-8?B?VEkrSGNLZ0s5WnB6N0xya1R3QWY3dXh2bm1lUERzNzRsay9pb3dqVzN2TDBt?=
 =?utf-8?B?a3dnWFk0NDFFakIrMkVSQ1B1WGRmM2lQMnA3b0hkZnlhNDVLQXZQZ2tSSVpH?=
 =?utf-8?B?Uk9ycUxZR0FhRUt5Q2dHWGZHZG1SWTcxb1ZaOWFxTjFOaERXa3dHSEhrVlhY?=
 =?utf-8?B?eUlsRlJabVVYbnVILzgxczdQck9VbUpYR3JuYXlFOTBsRjhuMzhzeGthT1Va?=
 =?utf-8?B?bFJCck5xRkVYTjBPaHVzQ2VNSWtENmJuWCtzb2xReFFpZDhxN3I2Nkd0NUlh?=
 =?utf-8?B?WXlrOXorT2c3MllJNTNkRi9UdEJiTDIvaFIrTm5YT2ppZm5hUUNiZDN0czR6?=
 =?utf-8?B?K2NGUzg3WHh4MStkVDZMN2p0MmVWSXRTd01vbTExSDdkWnBEQ05oeU9Yd01x?=
 =?utf-8?B?OWhRcCt3REhnTUVSWHRTS2V4c0t0QjRsb05BTzU5T0hBdm1OSnA1V1l3OUI2?=
 =?utf-8?B?bnFwTi92d0FjeHlIbVM3ckhvUmRUaUhaWFJOUGk5cFpJdzlKNlBZeEhJU3NU?=
 =?utf-8?B?dVkxdXZNNGtZRU1tTStmSzI0THVyL3daenp1RUMvZm94cDVCZi9vdGQzZWda?=
 =?utf-8?B?ckx6dEVXVkZkZlF3c3cxbUE0QkNSeFg3MitFSy9UWWIrWURtMHlFbXhVMnJq?=
 =?utf-8?B?bDdkMTJhYThVdWR1OW1wNERzVTkycUZuZVFibzF4UWxwNDlqbkxnRDJCUk9w?=
 =?utf-8?B?ZHRmZWhNRG80ajdPaHBJYkpuZGxybVVBOWcrRW9ERm1mS2VWRjhueFI4UnhX?=
 =?utf-8?B?ejlDTmI4TS9OZ2pMcG93SS9NL0JJSm1nTkRONXZQb3NmWVB3ZXlVQmNVcUQ2?=
 =?utf-8?B?WmVhTStMUU5XU1pZOS9lcVo3eWQxcFNGaXU3NnF0NlUzSW94NlhCclpaMU1G?=
 =?utf-8?B?aStTQzRENE1ZSUgwb1ZYVittcVhEUFFBaktpM3FhcUs4bEtHa2VIc011VDFt?=
 =?utf-8?B?Z05aV2pSSk81VHloWGtxaTMzYlJ6S0pSRVBRTFRGYWNvUmxmNXMrUzM5ZEVS?=
 =?utf-8?B?eEFvVVlrUUJzeTRTeVhWMGprdlRPRDE5dHNQL0xuWThTemUyWHV5cGdwQUFX?=
 =?utf-8?B?Y0VaNXE1cEhpYnllVmVsK2pISGR3ZkNkenhmSGNRekNCdHYrNmExMTNBbUNh?=
 =?utf-8?B?MmhyWDNLTnlYeXRZZHJneXRITy9SMGJkZjQzMXI1M1FNNEREQUE4MEFyclVn?=
 =?utf-8?B?ZE8yV0MrNXlBOC9HS1kycWlMZzBNSFNXZ1BRVklia0VrRnlRM2dpYVBHeGlm?=
 =?utf-8?B?K3JlMGF6YUxNYkVYejkxdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE5ZOEtPejg1YlE3TW1ONTZzVERYSjB2U0ZGY3RXS2tiWU1adkloaCt4Nmdi?=
 =?utf-8?B?bTRqUWdodzFaWkpONDY0czk0eUlEQ0dZQ283bk95Rzl6MnkrMHJlOTZkSjFY?=
 =?utf-8?B?OFZoWTBLMnR4dHk3MXlIZm9FZDRJQzM2THp2VWFxR2xvdi9pZDMxeGR0Zmpo?=
 =?utf-8?B?a3ptQzl3WkZjNEJNa3RCRm43QXlOcVNGeERseW1IS1RUYUY2aWVOZnltU0k1?=
 =?utf-8?B?MWwyTkVaanZIbHlUemJyK0FxSmtLckRFZEhldlNPTmxkZFNvRHd3MEhqNE03?=
 =?utf-8?B?ZjVDOGRrZlc0c1ZRTkRKdm8xOXZ6WkE0YUFsVktWR1VCR0Z0RW5lWFpHSTF6?=
 =?utf-8?B?NUt5cFhPUnNxVW5vTFFsVFNHNkMxQjNFVU8weldPanF3RjIxbHB3VkFyek5C?=
 =?utf-8?B?YXh2SzdwMGhLZWEzWEk5cDBOa0JpY0pZWGl2SUNTUHZFYUhkVFlLMXRITUxs?=
 =?utf-8?B?WHJWWjk0ZU9kRU5DSVZCMkllVmtEL290cDFOdjl6NWJMUVhWaE5RWmIzRVkz?=
 =?utf-8?B?aVE0M2wyYnhOZ0xUc0w3QU5zUkUzN0FoZzYzcm5Pcm01UGdxaUovenl1NWFH?=
 =?utf-8?B?V3hZMGdlZ0pob0xjT2JQNFI1RFpGWjNWeW5qR2pCZVlOVWJnRmQ0cE5nMm5z?=
 =?utf-8?B?eTR5ZktXQ3dTUTNEMUp4UWFIcDE4dXdZeEF0MzQ2YWlCYkkxRVpMZFk2aFFB?=
 =?utf-8?B?UkZ4eDFnNUNEd1FUQVVsMFlSNmNETGtLa2h3K0JwWTRmRmJCL3I2WHJwa0tQ?=
 =?utf-8?B?MERCSS9NQThvZGRJVE9rcGk5WGNuZnovMUtocTFrM1djMHIzb1VTTnltQm81?=
 =?utf-8?B?TWZBK2R5Nk9aSHdRNTl0b21ONUJmSG9kbVNvMlJKOHg5Y1lvQUhHUUZxc2Vl?=
 =?utf-8?B?ZHdJYzFGeUN6YXowT3VzeVJYd2ErNTdPM1FoR0puK3pCOE8zbGZSblc4WDJz?=
 =?utf-8?B?WENNdEV3dVNDdjcxNUJERHB4MDN3dG5GNHJtZFVBSUpTL0J1VGREeHhsNEVG?=
 =?utf-8?B?aHB6MkdyTUJqMHlGV0lBU1dhbW1URFRleDlHT09JVXFUTW44Ri92OEl2bW41?=
 =?utf-8?B?cFdGd3ZoNzdmNFh3QnFoM3hEWnl5cWlrVzNxU0N3Q2d3MzMyT3B2NGZYa0FR?=
 =?utf-8?B?a3JKaXdLKzNrRDk3dVpIWEs0QXgwSFk2dGhlYTRGeUlLV3A0eVFiRmFVd25T?=
 =?utf-8?B?dStyZGk2bjF6amU0U1RCZ2RKM2VGU2tEdWthck94dmhKM1p6QXd4bEZpcnhI?=
 =?utf-8?B?OFpuaEdpbkpQUXRGTTZpQUpaeTZEMitRQTZsNmN6Q3RWTU8va3NEVnBuVzRp?=
 =?utf-8?B?YnFZWGxEdlB4SDcycXJxYW1WZTgzL2tEYUxHajJFVTVRSlZpMVc0dXAzeDFQ?=
 =?utf-8?B?cDhNR2g4TFI1ZU5HbWgreVVNSnVreFVhZnpJUGlwNUhZSVBYeUpJY2JBUTU5?=
 =?utf-8?B?S2YveDdoQTlKeGU4Z1lxTHhVekNFTmZKeW5sbXhDRmQxN1lqeGVhWXBENGtE?=
 =?utf-8?B?c2s1WEVIeU5JMU1IYk5vZkFVckI4WkxmMkxpOUxrOGw2Sy90NXZ6eTRPUkhY?=
 =?utf-8?B?Z1hnWnQyZkNjd2V3bW11bUhXc0N0RkdQMW5BNGVTeGFRT3BFWEdFK1pUdXRo?=
 =?utf-8?B?M25VZTZNK1U2b1hPU2UrRlgya3BXL3F5OElQV2lmVmNSRHNCK21jYW1Nb3ZC?=
 =?utf-8?B?Qk1iV2IrK3dlOG1US2ZOemQ1NU9yVzArcXpJS3Z2VW8xVVk5N0o3TkYxelVo?=
 =?utf-8?B?SmVGU2xlMVVoRkh0NEZmaEFyNTVCVXRvRzhvRXhVQm1BNjdvaEw3K21uWDFn?=
 =?utf-8?B?ZTZCdnRwVWJpMllUL3BuSE1FUVZRaUtLcXo2YnUvdm5rNzF1TUtKOGxHcjRM?=
 =?utf-8?B?cUZZSjlpSmhhRm5rQWVtbkFSUFVURkRCdTJiaG1hZUEzRHlqbUhQUVpCNXZR?=
 =?utf-8?B?RjM2Q1lPNHhLald1RlRpNjdnTHc2V2pLalFDeElFUVliRnVRd3ZtaW5GcGxs?=
 =?utf-8?B?eGZMS2FHRWdHZWc1Z3NGOGJOa1IxdEtlRmwwYWJJdHZmSEdJejkvYWVHZ0Fo?=
 =?utf-8?B?cWRNMUFyUVFJMmpyekRQbHFDRTc5R1o2WVF4WGRpNFhBSWMzY1NodzVKMkZh?=
 =?utf-8?B?SXNrYXZrZHZqOEhJaXREOFIxN20rQXlzblBvZDQrV2tRSW90VDduOTNhY0dR?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m3HXCT1D0x6lJXd5o3CgNKBV9mnai00/N+UNM8vumNuODEZSqR4RcUiF7S7yWgbKVjw+bKSU4nvZnKMnKgddr4ZH7buclfCAU7JHDRKLJJamttaw6g5910T5D6DuLYbXybJDZepnjYAA9zw5QsWT4em4N8pJmqyHVsOp+j+UIOztpjx7V4pflL/sAQeQsd1Tz53dTTu0cu6mEw3ckUtJaJJMEe6k+kEfGdmPDXB/ptJtxyUuTGJR6X3YySI28+f6flHTEPccbUhaIbpL0Hw33zUw4sXl3ZFIv80vTqA39BvuLE3Jri9kJVKwAln0rQkmvjeDf5KXXspMIX65HfJ3d+dLNN8DmV6am3v1ZUaMnEgfT7vggOLUeoenw2wW+93gswbXwA1sOqfxhfX29gkVRjgJ1nFVkgQ9TmH2fHleNHdsN5vmQ4RHe2B+fYhtFOz3JbQMaqttO8FMgWcf92NB3x75ko3/O/ay84K6bgIjl3GgWpsdlrgjNF1OEzCaB0Eobjqdk6L0RZSeMS+jsKtf6swhg8zjONZaM4VGgjH8QEff44UFX66h4p6nSk+H7ijfu+He4vN3GHvS8Zvi2oUqKjD+qQITbcOIr5EqmG/++wU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a4fb04-205e-4e23-eeda-08dcaaf13952
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 08:27:01.8092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vz1nTLPv7MOH8FA3f7P7fojfHQK7QCBFfczH36rweoN4BlDHr0cvKHXHcw9HeM2u0JGs5JNM3hFKd6L0y8p+uJ/q4egUc3gfc1qZxa7k3OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230061
X-Proofpoint-ORIG-GUID: YltRtNoH0x19ZCkL6i7XS-g3MTBrHJxl
X-Proofpoint-GUID: YltRtNoH0x19ZCkL6i7XS-g3MTBrHJxl
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

On 23/07/2024 09:24, Eric Auger wrote:
> 
> 
> On 7/23/24 10:20, Duan, Zhenzhong wrote:
>>
>>> -----Original Message-----
>>> From: Joao Martins <joao.m.martins@oracle.com>
>>> Subject: Re: [PATCH v6 4/9] vfio/{iommufd,container}: Invoke
>>> HostIOMMUDevice::realize() during attach_device()
>>>
>>> On 23/07/2024 08:55, Eric Auger wrote:
>>>>
>>>> On 7/23/24 09:44, Cédric Le Goater wrote:
>>>>> On 7/23/24 09:38, Eric Auger wrote:
>>>>>> Hi Joao,
>>>>>>
>>>>>> On 7/22/24 23:13, Joao Martins wrote:
>>>>>>> Move the HostIOMMUDevice::realize() to be invoked during the attach
>>>>>>> of the device
>>>>>>> before we allocate IOMMUFD hardware pagetable objects (HWPT). This
>>>>>>> allows the use
>>>>>>> of the hw_caps obtained by IOMMU_GET_HW_INFO that essentially
>>> tell
>>>>>>> if the IOMMU
>>>>>>> behind the device supports dirty tracking.
>>>>>>>
>>>>>>> Note: The HostIOMMUDevice data from legacy backend is static and
>>>>>>> doesn't
>>>>>>> need any information from the (type1-iommu) backend to be
>>> initialized.
>>>>>>> In contrast however, the IOMMUFD HostIOMMUDevice data requires
>>> the
>>>>>>> iommufd FD to be connected and having a devid to be able to
>>>>>>> successfully
>>>>>> Nit: maybe this comment shall be also added in iommufd.c before the
>>> call
>>>>>> to vfio_device_hiod_realize() to avoid someone else to move that call
>>>>>> earlier at some point
>>>>>>> GET_HW_INFO. This means vfio_device_hiod_realize() is called in
>>>>>>> different places within the backend .attach_device() implementation.
>>>>>>>
>>>>>>> Suggested-by: Cédric Le Goater <clg@redhat.cm>
>>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>>> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>>> ---
>>>>>>>   include/hw/vfio/vfio-common.h |  1 +
>>>>>>>   hw/vfio/common.c              | 16 ++++++----------
>>>>>>>   hw/vfio/container.c           |  4 ++++
>>>>>>>   hw/vfio/helpers.c             | 11 +++++++++++
>>>>>>>   hw/vfio/iommufd.c             |  4 ++++
>>>>>>>   5 files changed, 26 insertions(+), 10 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/hw/vfio/vfio-common.h
>>>>>>> b/include/hw/vfio/vfio-common.h
>>>>>>> index 1a96678f8c38..4e44b26d3c45 100644
>>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>>> @@ -242,6 +242,7 @@ void vfio_region_finalize(VFIORegion *region);
>>>>>>>   void vfio_reset_handler(void *opaque);
>>>>>>>   struct vfio_device_info *vfio_get_device_info(int fd);
>>>>>>>   bool vfio_device_is_mdev(VFIODevice *vbasedev);
>>>>>>> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
>>>>>>>   bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>>>>>>                           AddressSpace *as, Error **errp);
>>>>>>>   void vfio_detach_device(VFIODevice *vbasedev);
>>>>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>>>>> index 784e266e6aab..da12cbd56408 100644
>>>>>>> --- a/hw/vfio/common.c
>>>>>>> +++ b/hw/vfio/common.c
>>>>>>> @@ -1537,7 +1537,7 @@ bool vfio_attach_device(char *name,
>>> VFIODevice
>>>>>>> *vbasedev,
>>>>>>>   {
>>>>>>>       const VFIOIOMMUClass *ops =
>>>>>>>
>>>>>>>
>>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>>>>>>> -    HostIOMMUDevice *hiod;
>>>>>>> +    HostIOMMUDevice *hiod = NULL;
>>>>>>>         if (vbasedev->iommufd) {
>>>>>>>           ops =
>>>>>>>
>>> VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUF
>>> D));
>>>>>>> @@ -1545,21 +1545,17 @@ bool vfio_attach_device(char *name,
>>>>>>> VFIODevice *vbasedev,
>>>>>>>         assert(ops);
>>>>>>>   -    if (!ops->attach_device(name, vbasedev, as, errp)) {
>>>>>>> -        return false;
>>>>>>> -    }
>>>>>>>   -    if (vbasedev->mdev) {
>>>>>>> -        return true;
>>>>>>> +    if (!vbasedev->mdev) {
>>>>>>> +        hiod = HOST_IOMMU_DEVICE(object_new(ops-
>>>> hiod_typename));
>>>>>>> +        vbasedev->hiod = hiod;
>>>>>>>       }
>>>>>>>   -    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>>>>>>> -    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod,
>>> vbasedev,
>>>>>>> errp)) {
>>>>>>> +    if (!ops->attach_device(name, vbasedev, as, errp)) {
>>>>>>>           object_unref(hiod);
>>>>>>> -        ops->detach_device(vbasedev);
>>>>>>> +        vbasedev->hiod = NULL;
>>>>>>>           return false;
>>>>>>>       }
>>>>>>> -    vbasedev->hiod = hiod;
>>>>>>>         return true;
>>>>>>>   }
>>>>>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>>>>>> index 10cb4b4320ac..9ccdb639ac84 100644
>>>>>>> --- a/hw/vfio/container.c
>>>>>>> +++ b/hw/vfio/container.c
>>>>>>> @@ -914,6 +914,10 @@ static bool vfio_legacy_attach_device(const
>>>>>>> char *name, VFIODevice *vbasedev,
>>>>>>>         trace_vfio_attach_device(vbasedev->name, groupid);
>>>>>>>   +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
>>>>>>> +        return false;
>>>>>> don't you want to go to err_alloc_ioas instead?
>>>>> hmm, the err_alloc_ioas label is in a different function
>>>>> iommufd_cdev_attach().
>>>>>
>>>>> may be you meant the comment for routine iommufd_cdev_attach() and
>>>>> label err_connect_bind ?
>>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>> C.
>>>>>
>>>>>
>>>>>>> +    }
>>>>>>> +
>>>>>>>       group = vfio_get_group(groupid, as, errp);
>>>>>>>       if (!group) {
>>>>>>>           return false;
>>>>>>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>>>>>>> index 7e23e9080c9d..ea15c79db0a3 100644
>>>>>>> --- a/hw/vfio/helpers.c
>>>>>>> +++ b/hw/vfio/helpers.c
>>>>>>> @@ -689,3 +689,14 @@ bool vfio_device_is_mdev(VFIODevice
>>> *vbasedev)
>>>>>>>       subsys = realpath(tmp, NULL);
>>>>>>>       return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
>>>>>>>   }
>>>>>>> +
>>>>>>> +bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
>>>>>>> +{
>>>>>>> +    HostIOMMUDevice *hiod = vbasedev->hiod;
>>>>>>> +
>>>>>>> +    if (!hiod) {
>>>>>>> +        return true;
>>>>>>> +    }
>>>>>>> +
>>>>>>> +    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod,
>>>>>>> vbasedev, errp);
>>>>>>> +}
>>>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>>>> index 5e2fc1ce089d..2324bf892c56 100644
>>>>>>> --- a/hw/vfio/iommufd.c
>>>>>>> +++ b/hw/vfio/iommufd.c
>>>>>>> @@ -403,6 +403,10 @@ static bool iommufd_cdev_attach(const char
>>>>>>> *name, VFIODevice *vbasedev,
>>>>>>>         space = vfio_get_address_space(as);
>>>>>>>   +    if (!vfio_device_hiod_realize(vbasedev, errp)) {
>>>>>>> +        return false;
>>>> Hum sorry my previous comment was targetting that place. I think
>>>> unrolling is needed up to put_address_space
>>>>
>>>> so effectively this does not match err_alloc_ioas but I guess we would
>>>> need another label
>>>>
>>> You're right. We haven't yet attached rthe device and that's what
>>> err_alloc_ioas
>>> would do. Adding another label not sure would make things cleaner given
>>> the
>>> ordering requirement. So maybe this instead?
>>>
>>> @@ -482,7 +483,8 @@ static bool iommufd_cdev_attach(const char *name,
>>> VFIODevice
>>> *vbasedev,
>>>     space = vfio_get_address_space(as);
>>>
>>>     if (!vfio_device_hiod_realize(vbasedev, errp)) {
>>> -        return false;
>>> +        vfio_put_address_space(space);
>>> +        goto err_connect_bind;
>>>     }
>>>
>>>     /* try to attach to an existing container in this space */
>> I was confused though Cedric and Eric both ACK this change. Don't we miss the iommufd_cdev_unbind_and_disconnect() call?
> Hum yes you're right. connect and bind was done. I thought this was done
> later. so err_alloc_ioas label looks good
> 
It seems you were right the first time.

I definitely haven't got coffee yet.


