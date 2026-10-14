Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F33BCC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH1HY-0000Yg-KL; Wed, 14 Oct 2026 11:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xH1HX-0000YY-Ag
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 11:52:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xH1HU-0001QK-Pz
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 11:52:42 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EDh9Lc3495528; Wed, 14 Oct 2026 15:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=xgoPOce4LI2eQYT0Q7JYcj0F06ZCD7DA+5sr15g90ak=; b=
 AnWAfUTsOgORYPRL49w7pCnN1RIw2uiKxA1+rryKxY7SGWId7pCSFvSJ7lMOudhd
 0mqNb+wLfxyHgqU54vpEeaUbP25pCrdft6MzAVfFsoxmDLJQ57unXvH7/xnEksfI
 vPolzXPzykBNmMvay78YV8OyrH/tGr1dghR7enC6v2mT/cyH5+9DpY/vPtpCnNFE
 o3xTsCxr3NmbomFRoYHhO6m9Na2vOgoPfLY1Qj57Y6Jpek949l9UbC6HsJ7PcxjM
 sBEPHHo+1oAwe0SdDSx5qkdiloAvsOLXUOdGR7PFvreObvlMzBexyt/UhcglihVu
 +uo3OPLc0F88KSmrpM/Vlg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dbkpgpx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Oct 2026 15:52:30 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69EFpNbv033113; Wed, 14 Oct 2026 15:52:29 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011032.outbound.protection.outlook.com [52.101.57.32])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btb3hau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Oct 2026 15:52:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UODFx2JxWL3tLcrpXZJOEaJtBIJqFGp7J/wnIu5hieL3aQP+FPPvo58+iTxMapxpKOT44KPpYE/6NVMSyry+fBudSGvjfLVbBd9WOmqk7+wiXu6P5PnfO9lWCheegfZD2jNmlKc/UcdGI0gk/HPorcKugUe3Mnrta/eO9Z0Zmxvh2mdukRQp0hlC7lh7OVMFqpzfsFSrpJZgbXh/wL0DDBHtyv4ION/GNaPJzmFrTaM2t+bVEhT55Vk8bZcJjb04tvRrTYL/555AIQWZebYWpnsX6ix+/q4WWyKfaeExGarSCCeFHPzyMGPeM3lv7q20p3QMv/UPoSMZhZ3jy1vIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgoPOce4LI2eQYT0Q7JYcj0F06ZCD7DA+5sr15g90ak=;
 b=iAJxUv9Y0pYy+0z0fW3lsJRpEfjxr6+Nlhkfzmqwem3km/I+3XRNfYpQu7J9CujbgOs3yxj+9myWr7N99cHH3FsEz90eT05XO8afalo97SllgZyIOTeskPL1jF3V8ELX8TfaGd7YhyR5qWpswRO61OX4UI5cgi4ZIqAJwZIUdV52mXc609zkH8nFAhdMF6r7aCoxXWLBcMzciij5GCFdu/TdXBj5FV1VZ4OEPTcJ7CAx2qu0wQZ2vxnA3zKGlH6UeD6YPoOudPGC52uRQCKSRhuTgGrcFxnNYInHma5EqFju8wEWpuqQkHdHwgaZxoKAjNZtjCCXLEN+wcSSP14hRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgoPOce4LI2eQYT0Q7JYcj0F06ZCD7DA+5sr15g90ak=;
 b=NPMgbA1/6HGR9/7ST3UGfga/ZLMV8rxjmzXJDtaWmaNxtBrO8CFWpaLIG+cnW4W2+p0vnj/yg7X0Tb6SRCoCwwQgnYyLihS+p6viI/eUgBZr60H2vTmjYxwmK2QTz/XbTIQRFpBYe+hJIV5uMz/z+B2euLXJ4LJbvvNM4NTCldg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by PH9PR10MB763117.namprd10.prod.outlook.com (2603:10b6:510:414::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.7; Wed, 14 Oct
 2026 15:52:26 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 15:52:26 +0000
Message-ID: <4b7de1ba-f063-43b9-9dd2-64d1187e488f@oracle.com>
Date: Wed, 14 Oct 2026 08:52:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] qapi/migration: add cpr-luo migration mode
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, david@kernel.org, imammedo@redhat.com,
 maciej.szmigiero@oracle.com, peterx@redhat.com, farosas@suse.de,
 mark.kanda@oracle.com, bchaney@akamai.com,
 pierrick.bouvier@oss.qualcomm.com, alex@shazbot.org, clg@redhat.com,
 yi.l.liu@intel.com, eric.auger@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
 <20261012235727.398133-2-dongli.zhang@oracle.com>
 <878q40eni8.fsf@pond.sub.org>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <878q40eni8.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0095.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::24) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|PH9PR10MB763117:EE_
X-MS-Office365-Filtering-Correlation-Id: 33547c19-1b8e-4b9e-2a75-08df2a0b2513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|7416014|22082099003|18002099003|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: zpvJgOoqs3e13Y7rQkrfu+RY5zlV/CDWMBD2x3+ciF5gwUoBY20vfwW2OkaxGmf3uqDaavRnWIJBv6XOp8OYzQrcEIw0pxStgoT6PrQzrY2TerPdqC+FhHW2y/4eaQUcCGOme1XvcN9JoHdYprZzBu/xoJVne2L1gnMnYiX0YnZa9COJs9O7et09H8mBDeYPPwV5Rnzy5uUdlgI6oIpSavqTf+hxa81yvlv9oZqadCRi1EJed9YyUIZ9SC6vyXZIGQt/E1N0EX1Sa/HbE/iLA+0hV9lPTlzJUdM82+p/OCFkN3xvBSBG9tF9Voapa+IYSjYFbvUGMOfqmbVHHVP6TVVan+r2tkk/KmKlOh3TbaN9d3M+UGvWONa8tQV4QCzslU3sUFXvFPbxUSDTpKvxRXm+NCXTJxCvs48heODqcTcwV3Saje89zImDTm63ZUc3BfWox2Z5rN7cjRTANmqsTge8uHbkjzeyGxZebJ67Smf9njP51+zwxXVFElGIUN9VuVRUX1UNf4adwZ43zmNSyN9QFne9T2qixD9iBM7wNZspqzfQ3kvCXn1feoAWNY0PdJuYX8pKvdyhSr59pJ8/rDnZbSbAtcoMeKzJN7/J7ffoZqmv4jEs6250vVTBXJ1Nj/zUXPJmxyOg9GaEoDMC1IB13AV0LPTvMKUqN6ClCJk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB5506.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnN3R3dVRHRXWlQ1MElYT2Via2VHNnVMa3FveGtrNHB4TTFFTmdrdGl4OUJl?=
 =?utf-8?B?VXhwTWtBUkp2cWVraEREalo0Z3E1Z2ZWTTVDZHpBZjd2Ry8xc0tES2pUZVZF?=
 =?utf-8?B?c3M1K1lEWi9jMmFJU2tYdWxGOHVJelVOMk56MkY3TFltWldMT29ReFFUTzBt?=
 =?utf-8?B?UjdKdzd2d3IwY3d3L3ZpMkxRRnd4aTdPQU1ZWnBZSHNzbk8yNzZWaThvVzBS?=
 =?utf-8?B?LzdxR3FlbmgwMFQ5YTVQZXJMOUpoMHRhemVsRWNLWWhTcVZzQ2dVYXZPU2Fs?=
 =?utf-8?B?K2sxeExXZTVqMlZUUjhFVEN5aDJBZkF4Yk5mWklqT2EvOEMxNzVqYmpMWThJ?=
 =?utf-8?B?OGZjTFhLc0ZxeTk3Y1NyckZWbDJPWERKMDNUSG5uQVJhSzNOTG9QSVJ4NzJj?=
 =?utf-8?B?R0tVRVYrN095YWhpSllsdGpCdU9KL2E2dkQrdlhkME5ISFhlMGpxQ2lOeWV4?=
 =?utf-8?B?RHFpR0w5cThmT3Q2bXg3QXZsMG1Vbjl3SlFkeEZHUG1mZGIydTB5M3VlamRq?=
 =?utf-8?B?Qk8xbGhVMndodkhXU0dVWVRhWCtjb1JnckZjK0VNaW9hK0w5NE1zSjU5b3B3?=
 =?utf-8?B?VEk0YnZuekorVThIRWpBS28vWDRyeHB0dE8xZzh6RGZzRXFrNGNHWU5xWU1Z?=
 =?utf-8?B?OHFTUTNFZmJ6MWlTWjd5Wjc5cVM3c0IrL0xsUGtSRDdnUWxFSGlMR3llY0tv?=
 =?utf-8?B?Mm5yL0V3NkI0WjdRL3RHUi9SWDFjajJBWFVhbGxYTmIxQkdIUEQ4MWpWNlJD?=
 =?utf-8?B?RTBOdXgrSzFxSGc3dFJiU2JUUkdPeTRiVEFWU25sT0xkQ2ZDcnJRb2NsdUQ5?=
 =?utf-8?B?c3NvVFc2bzlLcFlzUWVhVWUxZUlNN09BWEwwRTVHa3k4VGcxWGJGTGsyNkxy?=
 =?utf-8?B?MlNlQlpKL2tIaXdOUEp5ellUL0pyZGxUTWVlQ1RUSG9TRk5SYi9TYzNaL2FM?=
 =?utf-8?B?cW5tVklJYzNTV01oS2hkcWF4SWhZajRoNmUwcGg3QS9DTjFUbncwUjN3MEdY?=
 =?utf-8?B?dmp2NjJJS0wrRjYzWE5tYWgyMWdSMGNydWVzNU5FQXFOQ2JhRXFTbUU4Q2dN?=
 =?utf-8?B?KzdzYW8yQnArVjEybEtPTkR1cWFGVk8wdk42cWMzdTZaTktlMlF1TFVuM0w2?=
 =?utf-8?B?cTFqd3JuTElFQUptZUsvOS8rNDJPdUpMUDRCVmI3OHRrNVNSMk1LZm4yWUhN?=
 =?utf-8?B?UlZhTlpRTnZjVzM3cXRGS050RnpYR0liNWVBNXVaU0F6a1FPaURyVUlPYVU5?=
 =?utf-8?B?MG1BRG9MM1hrRUFudUsvd1FOM0lneDFndWNzRmVIMjZHRlV5TktPZVFOdk9z?=
 =?utf-8?B?cFJEMHNYb2pjU1d5SkhEaG5jeWhaSlVaekZlVlRqbmZheXk5QldrY3AyZ1Bz?=
 =?utf-8?B?OHlySEZ5OTFhSzBFN3llT3lROWlvNDZmK2VtSFNmQUtFWE83cUlxbklhYmxP?=
 =?utf-8?B?SUdHaEhXNnRpcUVOcXJNMGFsT0ZhVHNNdGtaTmgvUktVdnRhNHpjTzBNUWpH?=
 =?utf-8?B?WVpNcDFqRzBza1krdGdITzErOFpUNjJSYWFTRmNDTW9aYVg2N0dFVTVidkh0?=
 =?utf-8?B?TDJ6bFZZSTRqYnRnOFNHSzJmS2gxY1ZFK3BDV2MzS0ZPS0hNWTRrWEdST1gv?=
 =?utf-8?B?Z0lBWXMyU2pGMHFkVVJMVmFobmlmeDdlYy9ORU9XbkdPV2k4YXh1TEMxRG5G?=
 =?utf-8?B?ZlJNRCs3aFdzUkRpbm14bFlmY0hialpRcEgyWStSSTNsZ21waXZialhPNGZX?=
 =?utf-8?B?LzJhaFFldW5JOXlnOTR5aGNVQzZsL0dqMUNKdFcydmVFVW51anJVdStQSVl6?=
 =?utf-8?B?Mzcza0hjNWhqZ042ZzMwMDBzTnhZNjh5dko1VnZNQ0dJcnBWVis4Ym42WW1P?=
 =?utf-8?B?VVlzZklBbFoxQTVyZFZFQnBiTVBDMllZRW1XUklHdkZ6MGtsOU1OL1ZkQ2No?=
 =?utf-8?B?Z1J3VmVNdDI5a3AzckVOYXVNV29rWTVWYnBGemZ5WDUzSVk2TjhmM1pRcGNI?=
 =?utf-8?B?R3lEeWRxNGlVcjBYcU5pS0FhQkxuWURoeDFZMlZDaEpiZ3plcVZDelZ6a0lj?=
 =?utf-8?B?R2dRRnFvMFNZakZnSjNSc2JLeGIxLzM0RzdQUWJHNGJYK0NHeWgyb3ExS3BP?=
 =?utf-8?B?Q3V4R21KVjRzVEs4WG04SENuYllGQStCR2E5UFRpK0xvbXhzRlZxaW4xMzdT?=
 =?utf-8?B?V01WUCsxTjIycko4cEFXK1BrN0ZxRFZieFkySWFCMU55V092M3c4SHBnVmp4?=
 =?utf-8?B?ZjlTNXpYNklVZmhwV3JlMTZicXpTYlpHSGZtQklmR2hJZUN1bG5KNTFGdjB4?=
 =?utf-8?B?SlowaW40M0JYNkJIMHlNUXdnREl2L1VIalBCYkRDRlVtVllsTlhmdz09?=
X-Exchange-RoutingPolicyChecked: Eq205VW7Bp8WzHP1ZNX92X+tezxCqyACEy7hdZ98GszXqAdooKoQRjizXYR1/pwE16s/cIHWs+A0snk4PMJC+rdlaJwoSRsFzzIEyDdmUb2pJrLHJOfq/w1yYQrwVoPIo61Jll3yDor70Alqu+qSLnmFKT8+Pb7lxX4R5mN3lOW648HtuMDjIRWgZ9p4eNz0EE/bcl/GoV9GoqBSTCTrSpI/z6hl63AWWhGqHBmJVRuXLDeh1g2Bv2cii3RBMMYGSZlT9Z/xvAsmSV9n/HsKRa0g+WQKI+SNhHdjv5rkXDG4X5VEj4jPKN6eeC2wSCV0ltoIX0PPEUBeAW5cB8Tqqg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0H/AlTjISpKKmYs8f2aeXBluXoqsvfTS+pGa3yzGOALYdw8yuqf5DkFulnrRsm+Q02w8he65QSikl8XV2O7XJVG0vCFCsg5zrAaRo6XfyhpaQ3hIzOJixYapExA22CCb0SjTditFG9MNltxM0gnvOn57YVdYxE+MPNFPuOcp0SkO3Fsb+2OxIHkaOCzos/mdbnD3Kt8P5aGbf3PGri8TkTmgdJfohOp5uAoATyDNr1bYbJSVPPvqjgnfLrRNZ4i2ShlP7+M3GBhNJIpVQ909dign9LZ5ucTZP+vkqSxuP+CDKJmw5YeF6gcs8yKRbxmlvSSnGJwOFA27Xai2t81Az39mHzbDTY2PfKSiWD1pBWABsfeoEo1I4eQkl51/CLRSoNf0/Xi21AqQtZ9Bl01wHW5FybxGG0Sd2UOC8j8cBrv77VE1rJadpEtJhMCa1WILRT41fhV0dRvqNalRUj7KGwLGPzMd2Rp4h6qLtjsYXJW6THsAThFZ32MLsHYTZO95QLjvrwj6bRgXf/HTjXfdmJb32uvI3zWXe7p9G6H+HwwGE45KuPXCx8QpirjXnG/t959tn5VzuURGArAqnnmL61nVkr5x1A79q6kfjLAJUc4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33547c19-1b8e-4b9e-2a75-08df2a0b2513
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:52:26.6389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+fFU/1USM/1AJwgXcfODdMPy1LI1EgchxPL/HTMf7CWUkOWJHJM0Bqap4vMJDpi5TQ3cFeuJS2vvj4Nc8KDkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR10MB763117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610140063
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6acfa53e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8
 a=MAe68zAGLkE3gBGoLqgA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: 5cdirk9GTjjplLICBp867az4ZJctl_rg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2MiBTYWx0ZWRfXxEPhYWmJWnLG
 gkw3LMHQOR0VPBJusfvJqOSNKTCHq3Z4JgWJF1bT6jiTB+AcOgikknIKHXMJZ+X8C/89ECd15nP
 d4h5ffB34st1iDEV0QClNdWmcoQ5ec8cWMYTqgZTyWIovCoQl39U9TtMtwuCOD1dAxAiZs/4gO3
 xH70a1Q2wydcpE4Y2h+pOVzIQrtxpmi8065yzrMSyQfMptva7YgSINl0mMIAJf0daD0J/bCqE/2
 W9kdu+GKXVd70rcZMzsHgx1xtLSEqL7aTD3rRyNAsL1Nn/x5N5/0NlSlJDRaXhaF/6y7Yf+glpE
 BN2j92iCtngh5EUgHIQ0942acMV+c23xm0XqB0aUCkxB0uyEh+BHfIHkixRKbaat2eXvBKTcwJZ
 IMxKA1L8HpctvGDKO28iM2l+Zr0T1iVkFcM0QxQ4lP+gOnmmZr4eUAMKe+ZExiFBvuZLOm+p/op
 8BdAd2BvWhuN3SyikxA==
X-Proofpoint-ORIG-GUID: 5cdirk9GTjjplLICBp867az4ZJctl_rg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2MiBTYWx0ZWRfX/DDDVdABfVux
 Mbvq7L0ybos5sdUmqlVBLGbd4xQEzWCr58qkQvWsk76Lf7SoKR6Idm23fB/2JUWqoh/RuEjhkT5
 5PAIBBkNFJgD0qdrQJ/F4syuN+1Uom4POsOgUd18Hwwc/VcbMFic
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On Wed, Oct 14, 2026 12:42:55AM -0700, Markus Armbruster wrote:
> Dongli Zhang <dongli.zhang@oracle.com> writes:
> 
>> Add the cpr-luo migration mode for CPR through the Linux Live Update
>> Orchestrator (LUO). Subsequent changes preserve CPR state and RAMBlock
>> backing file descriptors in an LUO session across a host kernel update.
>>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  qapi/migration.json | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 889a9b89c2..ab117c3897 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -712,9 +712,18 @@
>>  #     with the '-machine aux-ram-share=on' option.
>>  #
>>  #     (since 10.2)
>> +#
>> +# @cpr-luo: A CPR mode that preserves guest RAM backing file
>> +#     descriptors and CPR state through the Linux Live Update
>> +#     Orchestrator (LUO) across a host kernel update.
>> +#
>> +#     This mode requires Linux with LUO support.
> 
> Pardon my ignorant question: host or guest kernel?
> 
Host KVM kernel.


cpr-luo is more similar to cpr-exec (assuming VFIO is not involved).

cpr-exec (same process across exec):

- RAMBlock fds are preserved across exec(). The metadata is transferred to the
target via a memfd passed through an environment variable.
- The device state (i.e., virtio) is transferred through the main stream (i.e.,
a file).

cpr-transfer (two processes):

- RAMBlock fds are preserved and transferred to the target QEMU via a UNIX
domain socket.
- The device state (i.e., virtio) is transferred through the main stream (i.e.,
local TCP).

cpr-reboot (across reboot):

- The RAMBlock is always reconstructed. It is just a matter of whether to
save/load the memory data, depending on whether x-ignore-shared is enabled.
- The vmstate (i.e., virtio) is transferred through the main stream (i.e., a file).

New cpr-luo (across kexec/LUO/KHO):

- RAMBlock fds are preserved and transferred across kexec to the target QEMU via
LUO/KHO, identified by a LUO session and tokens.
- The device state (i.e., virtio) is transferred through the main stream (i.e.,
a file).

Thank you very much!

Dongli Zhang

