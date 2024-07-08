Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B96FC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQrEt-0005Gl-NI; Mon, 08 Jul 2024 12:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQrEr-0005Em-7K
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:29:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQrEp-0004Eh-7i
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:29:16 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468GMVWu023949;
 Mon, 8 Jul 2024 16:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=2o9pkhJQGEy9Raxybnp1YJYL2j5vFNujVRxL4kQKs4A=; b=
 RhkyUpNuqcl08w0wm3g+2pHb8k0X4m6xHQFcRljdi3ZWskUp6lgdwiJCQFXhAoxM
 R8/gx8XTT0PSlk1uwLe+M3ynuSJpU2/DKeBS/Vn+L4besWMrV+xkJ88+K+Soo95s
 aB37ZFFzIw/FPdz9YYOBJSOsmoFZ0z7JbZbX9gJdEfvkmGU4ZPggSCreEfdAy3jv
 Qoe5A0xfhzU6LZMtPssg/sv7lcaU0eqA2BYDYuOHIiqaTRjS/bf0VGEKfZFuNRdi
 i+syqZFJvAsEzmt4h6ebzFLM9nda2jEE7AVpsWoV0kKSybsJ0B6C4S+VQeNWwSUp
 CReQmMXFyJSPQIhxMYUHNw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcb1yh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 16:29:05 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 468GMbeI007417; Mon, 8 Jul 2024 16:29:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407tu1w5g8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 16:29:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHGTBm3d2UvtJXqitY+Y+U4EEqEwgXh013ffIuekYDT1GumZ77B/MMV6QI5ir9ihsDF84pg7H0JmCNdU01nl9zDa7CU1dWpbWJ+BgTvZotScfRSZSqEizrbCXl1kA5bPnofQqV8YEKJbjU72CE2HMZ0jRgVFY3IbPxd03/nviZwnal3al+5aBpy5WY81ouYakpEK9M8RMET/bo/vSAqSxCLwp+BaeMKjSDKn0ZcwAgLhKkxqQM+xabQD5CWeXhUH3Fv/rGaiBpTjVuPUor+CdISexYfX2rn9rIPoPoPlHF8lbOrmOJ0p9SXGQF7sIwYnHjkHqUViCGlzvUOKYFkCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2o9pkhJQGEy9Raxybnp1YJYL2j5vFNujVRxL4kQKs4A=;
 b=KgwIPw+Wd7bGOT5W3zKHBF+2WN911lpD0SzRCH5weZwVb25SBqzK/YmJE15qPne+meYKjZ+bePlKw7pk19eA470rVzD5ob21T7ja97/U7d/a69jRX0s3KORHZHURl1v2y+mnRt2BQ3zu1TEkZWLvzjcEc6y+TyNw2t9l5zElBjvweAfEb6Xdwgw7ACZ9M2L9RUZBaylnqdJYKyp1nfWl3GMZqoZdkcHTrNVcS7wm+Xf3v/3db4m0nhu1yjnNNmCRYYhGtsCdZvx+c+qbUF+XXsyt7QMhRV5rjQHBGe0hThLNoXBP1aiz/aYcW/L36EoJdvWfqpyQwkGmxt9j3MLJZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o9pkhJQGEy9Raxybnp1YJYL2j5vFNujVRxL4kQKs4A=;
 b=QuZnW2fas06wk2yQzHc2T4uu/Rhu/yH2LpX/tUT7QcI/vhk8oUq+kLkUwJfCcgZNBRWps2hLJE085KzJoVQW4rXMhW6gCGA2i2gRYg61gipJ9SWODNzSAqu/8B73Qw40dhka1MXTUr6VKxSZdUtHYkEA6nizkSFA3tS2k2pkOic=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH7PR10MB6530.namprd10.prod.outlook.com (2603:10b6:510:201::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 16:29:02 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 16:29:02 +0000
Message-ID: <64beda37-3eaf-4053-b658-eb46dd5bebe0@oracle.com>
Date: Mon, 8 Jul 2024 17:28:54 +0100
Subject: Re: [PATCH v3 03/10] vfio/iommufd: Return errno in
 iommufd_cdev_attach_ioas_hwpt()
From: Joao Martins <joao.m.martins@oracle.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-4-joao.m.martins@oracle.com>
 <5420483f-03cf-4383-be73-e3a8ec2a4378@redhat.com>
 <e57d4d48-0908-46f5-a2de-615c4c1edb5b@oracle.com>
Content-Language: en-US
In-Reply-To: <e57d4d48-0908-46f5-a2de-615c4c1edb5b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0143.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::19) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH7PR10MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ee2525-9a72-4b7c-a7c8-08dc9f6b13ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3NTcU5ZWW1zQ1hwUXBxZk14dFZkWTM5ZUNYdDN0eDB5VmRSSmJuR1JRa3BT?=
 =?utf-8?B?RENpRFNSRUJtMWRVVnVYdVBwY2xNbmtHcXd5bjlJcFdYMzlJZ3N6TUY3b1JC?=
 =?utf-8?B?dlpBYlhNd2g5ZWdlNzlWS21wcmJqUkNpbDdNM0Z1aTFONk1vMHhSYjlsbTgz?=
 =?utf-8?B?NDQ3NXNPVS80SVJQUHV3eFU0cXlDZGZTUysxNFdPWmE4aWVDYjBTdW05UERq?=
 =?utf-8?B?T0E1dnBKZ2Y1c2lXMTZ1YkJUQTdiR0x1M0JtYXVNUC9qR05FaTQ2OGpXTXpC?=
 =?utf-8?B?VS9jazRlV0JMS0Noc2Y0dUw5TXNoRHRYVFhqMm5sQkg0MGlQTjZCR0c5aUdD?=
 =?utf-8?B?RUhtT0NpcFR3SFVEWG4wYVQyOFRtNys5L0NnK2hjTjJoMTFNUk5OMjFsK3dx?=
 =?utf-8?B?MSthWDMxZSthODhqaWJhS0dhK2pGamg3Q2ZWeGloZWtmZG1ISDZLVDhhNEtG?=
 =?utf-8?B?ZnZjU0tnc1JUWVI2dHZXcm4ySEp4eThMbE5YeDVBa1Bpb3dKOFptZHRnb0JQ?=
 =?utf-8?B?QXJqWGZodkVOb1dNdjBTREJYNUFBRThkWlVEWHM5bHI0MjBQMk4rRVUvQm5T?=
 =?utf-8?B?U1VJaTE1VGllNG1QUXpXK3Z2R3VQa1hQTzErUFhkMU9yVGYremxMeWVnSlMr?=
 =?utf-8?B?UitjTFJQVjI1UU9zZVZDOHFIK0xmVFRzWStEWkpMUG1XMlRqdS8vby80eFlY?=
 =?utf-8?B?K2t6RHQvdVZFV0ZVelhSVHAxRHFReTdOSUZycHp3TGtIaFNRNUR2Tmcvb3d1?=
 =?utf-8?B?TkhGRFN3enF1NTF2dnBNaTUvbWRtd3YzczNVdkdMYWdCNGg0RWY3K0wyR2w5?=
 =?utf-8?B?dUtOVlZ1VWxNakwxV09VRFVuS1c4WkNPcDcwbzExLytpWGhLRVRLOC9UMUNv?=
 =?utf-8?B?U1hlVHc1UUYvNFZvZWpQcVZmcC9QbmFQTmtKdVVEZERhZmV3eFpWSEZ3OVhG?=
 =?utf-8?B?NEhKVWJBU3JaRVhxRDVuR3ZtdkhteitZbk1CZHJtMnByQmNLcmF0UjNDOHRa?=
 =?utf-8?B?L0hhQVJHYnRKenRJVHpJMXFmNlEvcWd4Mm52bGNFR3l3bTI3KzZkMjJSSTFP?=
 =?utf-8?B?NUVCU2p2RVdXWEtOeWpTV2M3T2lnMkRRTVV4Q0VMYkhGYlN0ak5oR0JPLzhX?=
 =?utf-8?B?MTlKbmxnUXFMWUJMQ2tPMjFPV3l5aE5FajNFWDdiSURPY1RuOEFQMDVkSlZP?=
 =?utf-8?B?VmdWRmFrRkM2TkR1K2k3aHVpZmFMcDhPNWNXVEZ4UENHZUpaa3Vua2RqZ1U3?=
 =?utf-8?B?aEdDUDlTUmxJMXkyRmZDOVZTYXJDZDdJWDU3NTU1KzdiTzdMNUVXZnJoM2tk?=
 =?utf-8?B?d1dJQnN0QjJRdUxYcFZVMWIwQ1ZoV2hDZit1bVAzKzloaXdhbmNTL2lMcjlu?=
 =?utf-8?B?aXlJN0tWR2svcXVTb2NZS3hIQ0lJemthVHVLNzBJc2czS0N1OFlQNmdhNFpY?=
 =?utf-8?B?WTBXME14d0lRVnZSVzNjT0l6T1FiUXFPMGpuWUZNdlh6bU5vWlJpZ2hrT1BD?=
 =?utf-8?B?dmg0c3VwWnFNTlBycWQ2cVBpdDcwQmR6NUxlMGlsVGtDeVE2QjFVa3NCRzhW?=
 =?utf-8?B?Wks5RnlodDFQTFRhK1RWQTVBZEliL2FGdmVsWkwwdWlySGFLeEN2RjVpMGxW?=
 =?utf-8?B?OUtteXdmTk9Nd0xZaG0wOW8xbklVV002dGxvdzM2OHpFOWtEVWxWTElvYUZE?=
 =?utf-8?B?TnhaNDF2NUdRL2tEZEczekZJRGRyVWdMd05LdzZiWXBvK2luZUJhY05MbXE1?=
 =?utf-8?B?cythYzZMVHVJUHE1c3g3N3VKY1Nnc3FXeXhYS0Y2OU5rRm1tSVdNVGRCWDVQ?=
 =?utf-8?B?K2oyOW9FbjNGa2l1N0ZJZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elNDK0haSkUwK1VlaVM0c0RoRC9FaEhEYndvVC9FK3VXQWcrbmVqQzdxcHV6?=
 =?utf-8?B?dlJZMXRsNWZxZ3cxb0dpSitEZzZQK2EyRVgwNW95dWlGSlUzYkRBVWhOaWFx?=
 =?utf-8?B?eW5PZ0ZTK1RpUWQ5eDlOb3NybSt5NisxL3N5QUxkN0VSbXRwc1U2RlpibE5J?=
 =?utf-8?B?Tkc3dGlYZTkzQnVrVWc4VzFzeDhFOFJkYzRkVHkzV25tZk9Oc1haeTZVMnli?=
 =?utf-8?B?RFRkcFBHMUVWNEI5WW9yQUtsaUVQc1AzVEVrdUlhaW9lSXJMc0tPWkFENW80?=
 =?utf-8?B?aVVFK2lWY2sxclFzVHcycFdwQjBZM3N5MXArcDdlczJiNnhFU1VuaWx1NmR2?=
 =?utf-8?B?ZXNYZFV5YllnR25oK3ZuNHNpNENnQlQ2OUJTU1ZrZEJXb0w2dUVIVGhiQ3pY?=
 =?utf-8?B?K3kzUDFJUnd5MFhzeVR3bWJrUm9VR1hVSmdDdm1hYU02dW9HY0dHY0NHL05I?=
 =?utf-8?B?ajRZQWlHSllKWGR5bUMramdvQjFzQU13cklWdlp2T240d0ZKdjNYeWpOTGR2?=
 =?utf-8?B?ZmJJQ1NLS21rcENzTU4yOXM5N1kybmxMQzB1UlNBRVl2YTRGaWJXN2JKWmFt?=
 =?utf-8?B?M05vNlFzaGUwYTlaRm52NVpTRXlkNVVYc3l4REpzSXZOT3A2YkRrTkVpNXVQ?=
 =?utf-8?B?dHBNZTVaUWNFYlp2VHJwT3VqUVozTk12MVFoZ2tMYTAxL2UreGpHMnBhd241?=
 =?utf-8?B?WTFQcWcyd3VjUWJTemRxYUNxRWZvaWloTElQWCsvaXcwM2dQUGZ6SDBsMGJT?=
 =?utf-8?B?MDVsZmVaMlVpVENua01zc3VjSVRDTkltYmZzQXZLOUl2UVNJOTRHWGRWQVNE?=
 =?utf-8?B?SkZlMmo5bkl1RXBaK21rOUN2QityUFZpazZXemZsMExiL2RIem5nYzhnUjRi?=
 =?utf-8?B?K3VVYlVXdkEvcWZLQUlSa1VxUUNaVVo0QmlmbDFYSHFzVm9wUnZ3ZlhiKzg1?=
 =?utf-8?B?Z3pMVEIyZUt3eUczSWpjV0ZCWThBeUtENkNvdWpCdk5qRHlPa2hheGo4QXNk?=
 =?utf-8?B?V053TjNHTHA0ZHdzQlJWb0J0UE1rS2JCR2VhNkkxWWlFc2xsMnRQbkVTcjV0?=
 =?utf-8?B?Z2F6bXczT1VDKy9tMXhOSXJHMmlMdWpYR3RRbDl3YWptNEFBUmQ0SEFIRWhq?=
 =?utf-8?B?Y25HWGFRRTJRVFlxRldrYWIwOWxkRkJQeElmRmFmaS82NlBxRitxdDdpa2dN?=
 =?utf-8?B?ai9PSTZnanVBd0cxUTVMQjlPREFJOEtxMzNmbi81TnFBVTlLWC9jdlBwWXRz?=
 =?utf-8?B?YlMrMEVFN250VFdjVHhVc2MzTVZkc3Z2aUZyZGJydkpXRE8vREFiZlJ4ekoz?=
 =?utf-8?B?d2lJcnNYZjR5c090Q09IM3hSbjE4UkdTRk9JYjltbzdHOEphd0tydmJrVTly?=
 =?utf-8?B?RVVGYWFkQmVlWi9rakg2cEtuRHJLYWdNOUwzL1A4YmNiQWlKeDlkd21CNGpW?=
 =?utf-8?B?THNwUmF4b1RxL2trNUZzS0JQV0pYMXFKdS94dUdYUit6SVVnb2QyRXh0WFhM?=
 =?utf-8?B?SVJCZW5UNHRQdXAvZ2hiLzkzdWpYYUlWTEpFbHFaTjBCWmhDM2RzdTliTzNK?=
 =?utf-8?B?WEo0U25VYUF3aEpSMFhMcnNWTFlSS05TQUE2bGJPVjNCZk5ldnFvL3RRQ1c0?=
 =?utf-8?B?L1RiNXF6S0ZQQ2tYK1ArZG4wZnlLSjF6QVJmaGUwOXFwbldhVnlEYzNabkpQ?=
 =?utf-8?B?eFU4U0JYM3JmQmJUYnFvZnB4TnFBdHN0MlR0YlVHS3dIczFaV2xzSVhSYkVr?=
 =?utf-8?B?SXF5WWF3VEl4OFBPeC9yaTZrMFBGMTVMMFJRRG1UZWRLaTA1ZFpUbDhQWFNy?=
 =?utf-8?B?VVhTbEFjU0JKR3Z3eVVGOUhOeS84K0s0N2xDT0R3Rit3NGFYTXJiNWswcVVz?=
 =?utf-8?B?S0hQN0E5dzdxOHhxSERvczAraWt2dVhrdHdMWVZvY1VvL2RUd0UrMGpHZ3JS?=
 =?utf-8?B?ejN4bWRhaXlTd05KbEZ3cTRzdEdJQ0dRQlF4NERvcFM0aE1ienJ5cDJPcS9n?=
 =?utf-8?B?dDNqR0Y2enBRS1Q1TXgzUFdrajE3TkZNTkd2K1M4ci9yRjZGYmN1bmJBMGpu?=
 =?utf-8?B?UWpERm5qYklMVDgrK0FmKzNoSkJEekUzMzdNZkhhSHltNFQxVFVqSU1laS9w?=
 =?utf-8?B?a1N0UG5jeFNPWDQ0Sy9TbWNWcTQxN0w4M0FaV09ZRE85RlhmY2VKdnI4Ym1u?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tWegfNtlLm+acv650iftgaziAjb6TcolE1ryK6pXbK+uJIB61PfvRlf6XcGQlUygxoYgE991Lhw7whDngIBI881hurShg/o+FT+cp6TSYbNW61oSbDEngPbjnJEn4z0QFDRLQHH0AMGgvcGlYr0OT7DdyTI54K46aygWinbacaiFQ7d9sFU1d0FcT2FJwDo6aYQo6T7EsPIHOC8AY0k2xrCEXaeWfxPQH17Bz9bhr1GOSqfOfHfI+CcsTT6s8EOUShuUaCTqoztBtyY5FuEZv9CnMpZRYDB+qmiUGmFFW6TCfhMP6CfGT4Av7tv2ucWZx2jopjDT2WelyxfzZ20hLygITU8+s+AzfSS0yNXbu3PJb/RMwNoC+2DAGg5X8Vxrx0heYj0+28Z1cxn/Hr7qniipVCS6epSC2orwh+QJ5k4aJH5m+9EBoQc5h4Effh6iYiPdSP1dyFRzrRBWwdwu4n/7xiWBuWu2GcJFRvuS+qMoM0YKZPEYAuino0bgZKkSgTd5BzWMNDKbhxnKOoeHXDNSAjRSKhYyHsXYM0Vody5jQPmb4XDDP8I7aqUcR6LnPOQBg9xMNSaoSR61ypToYuJ6Y882BpWDeZi6ClDlQC0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ee2525-9a72-4b7c-a7c8-08dc9f6b13ba
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 16:29:02.3493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vR8kT72WgctpIi7mxQHgVaPoY91V8rVRNuoH3CF1QJPinCh4OdeUKxm5PYPeQAAVnonOPbg7dEU0yenMM0ZxwAhsRkJQotdUQC85zXhinF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080123
X-Proofpoint-ORIG-GUID: -RkEHToPTcqyAXlkXy-1sL1Ya86o7fM2
X-Proofpoint-GUID: -RkEHToPTcqyAXlkXy-1sL1Ya86o7fM2
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

On 08/07/2024 16:32, Joao Martins wrote:
> On 08/07/2024 16:28, Cédric Le Goater wrote:
>> Hello Joao,
>>
>> On 7/8/24 4:34 PM, Joao Martins wrote:
>>> In preparation to implement auto domains have the attach function
>>> return the errno it got during domain attach instead of a bool.
>>>
>>> -EINVAL is tracked to track domain incompatibilities, and decide whether
>>> to create a new IOMMU domain.
>>
>> Please leave the return value as a bool unless there is a very
>> good reason not to.
>>
> 
> Error* doesn't store the errno, and thus I can't actually test the number of
> errno to know when to bail to the next hwpt. Maybe the commit message wasn't
> clear enough there. But not sure if we have an alternative here? Or maybe Error
> does store errno, and I totally missed it.

Or I can just use 'errno' and keep the same return value as bool. But I didn't
do that because we are purposedly calling error_set*(errp, errno) with the errno
value that it felt the right thing to just return it. Also, considering how hard
the code in util/error.c saves/restores errno in all the helpers.

	Joao

