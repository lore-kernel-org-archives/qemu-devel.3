Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C77CCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 16:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v94E4-000229-KX; Wed, 15 Oct 2025 12:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v94E2-000220-Ep
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 12:19:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v94Dt-0005sG-2D
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 12:19:42 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FGC6Zp002086;
 Wed, 15 Oct 2025 16:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=G6aH0c9x+2UGOpeYN7IQrBDdbbF6U7T2JkuafzjHCEw=; b=
 hDMyTzULMZM62ZIQsw9HtyeMOT1q3PtiFniVmpD+hlPLOe+OsfWmL9Gg6FZTKwUT
 POcihXOTfVTcl7BnHF+Ab16PeG9H042nXmkM7DLOU0B0tyFrjs6UMVwQH0VNwbvQ
 Dc82eNZQWZM2oMQOoBJv1S0W9kaqjeOClI6TeX1IaJ3iEwGwJ0e3jJflrNRxoVeY
 7NSUBD6R6OXwqgtTnNDIbxvSzqIKW61Sjd78YDBkXmSCyXX+bjxVcm+prj61hMPX
 82OEp0vll66SH8mRg4QIZwhaIDo6VX66H5zkyA/kho71v3qPlPI3P01hb/y6Dvgh
 8/3njDLdEAn2xy1AXrSGgw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qeusy0qk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Oct 2025 16:19:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 59FEfWPa026298; Wed, 15 Oct 2025 16:19:20 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012035.outbound.protection.outlook.com [52.101.48.35])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49qdpaa5e2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Oct 2025 16:19:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X77sQkGf9V+LOBJu59MKYfPm80FTrulTHjygr2PBso99ejF73xARUZA7Z6rdEIt5dk7nRbzRxUdan3K4gw2padjLxl48JdCbVir3WEh5RsodAFWyg2o6DMDza1E5Lrd/0Tljoo9X2Exo/WcEUcdw9DUbnPgt2r73R/Wi/qc46qp9FXeQYhwL2U1lIMP2fLCOi9nXeLaTeQdSqYCLQCGFrc07Jqp+K0AKASJqyapxX6qidIiRmSNFmfLqBZL2VGTfowFEoq5Fb/JCEKqkGqkVkEfYhr1W6sBoGsBPZtyoWreUqxhC4BKV4D9ZYLhf8k6l5p8Ut5Xz4hJxe9pcO4wxSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6aH0c9x+2UGOpeYN7IQrBDdbbF6U7T2JkuafzjHCEw=;
 b=gCT8AEe9jpysIeGjytQNtPHufYmyYOCZPfgMamkTHHvc3421NveHyOVdxr4JTIQoX2LYK9p7yjsRJw0oAltsGCdX4TWDsBJV0QClLXmrT/TCail8+t9RuG5rthfSuSLQBTyT7mErAB8LIP1u2XBbFQc9GqcA+3uT4otqAl521J6bMFUA+6FXsNgW2XhnDbNlNdq3GzbN9VYbMJtA7OfTix0WROgdxb9arFE6RKdDNQdkFc3NlrrfNKkHBXAcPESnzVY2QvA6vtaCZ7hH++WLFQINNv9Ci7uBdOU4jsAHMuECO66TRi4vSnvMbNqjEqqyprc8G333Ievc51FTS+2XgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6aH0c9x+2UGOpeYN7IQrBDdbbF6U7T2JkuafzjHCEw=;
 b=scSLILd9y05Js+JEkfnOox6GpvKviiLO9ox8MRBzNp7G1VaEJtTjXZN65ewVez/Y5TJZrIFnIR4YGhG7jJiEiqkYCuUA1Wa7TNstZw4R+vPCJvZRkNwutHVGlZMQ8G1zlNp4hKso9ScAhQRuElDUOmQtvSbtSwYeSFKVLmVenaU=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by MN6PR10MB7422.namprd10.prod.outlook.com (2603:10b6:208:46d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 16:19:17 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 16:19:17 +0000
Message-ID: <93bdf7c2-bab4-41e2-8a77-6bad9d1546bb@oracle.com>
Date: Wed, 15 Oct 2025 12:19:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] amd_iommu: Fix handling device on buses != 0
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, richard.henderson@linaro.org, philmd@linaro.org,
 suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, aik@amd.com
References: <20251013050046.393-1-sarunkod@amd.com>
 <20251013050046.393-2-sarunkod@amd.com>
 <20251013041059-mutt-send-email-mst@kernel.org>
 <6fa9b33c-31ff-43f6-8ab1-8d200c832c94@amd.com>
 <20251014050023-mutt-send-email-mst@kernel.org>
 <c585b4c2-5bde-4aff-a3b0-370bae5e9c0d@oracle.com>
 <20251015032834-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20251015032834-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::10) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|MN6PR10MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee3b08b-5d05-4f1a-e102-08de0c069684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rytnd0ZYVFhSaEEzRGphZVZLMm1iTFltSXQySzlKTjl0V3FBMmlEN3JkaUxn?=
 =?utf-8?B?TjJsN0Y5YVNXdEl6cmd5WnQyYi9ITjRhZHdCRzd1S2RGKy9YN0REWm01QUla?=
 =?utf-8?B?K0R2MG1NV3p4WVNMRDJzNW0vR3FIVmtkSFhjK3hGcDk4Tzhtc3BLQUxuWUNk?=
 =?utf-8?B?ZGw3THlvU0lmMC9jRFdzM2NiRklrUlNmZ2hXdE5mY3hoKzN5UWJKUWdBVTg0?=
 =?utf-8?B?WE4zcTdMWmNKbDdOUkdqalB4L0h2VEJkOENHTklMMFpZcXQwNzlzUzNDQlR6?=
 =?utf-8?B?M3JVVTRWWDBTbWF3KzBrM3I3cG1PRG1sQVZubEFGd0Y1cFRWS1RWVmdTakhj?=
 =?utf-8?B?TGFCTDlOd1ArOWxjV1FkSFBDMG9kZzRYbzZFbHpmWXB2cXFXMzZTYkxCc2Jn?=
 =?utf-8?B?ek5TNXpMVlkxV3NyS1Vnd0lXM25mZ0w2Tml0R2t0WXhUd1dnSEZNTkRjVldT?=
 =?utf-8?B?b0FHT0Z0YWhwTDF1bmlSNHdaSmNKanU1cll1aTVhWjRMTXhwYTlrb0Nub3VI?=
 =?utf-8?B?OTFTQitaYXV4MmJVMEdkOFV0RndXVThFeXhwL2R2eEhJU3hnSDZKMFhDMHo1?=
 =?utf-8?B?Q2xnNjFYaUZhcUFRbWhwajJRcEhCVjBNd3lXb2sxNm5Qc1VtNUcwV3dZVDFO?=
 =?utf-8?B?Wi8zSDU5SWU5ckxXK081endETXR5K3dvUjk2dGxGaWRIWFJFeFdCTkkrcCtN?=
 =?utf-8?B?OTY2K0l4ckhOdDB2T1E2N0J1cnhJRGk1dk01VEVyN1ByOXBIVlBScHBqNUph?=
 =?utf-8?B?QWVMR0ozWUgvZGxMODFKRFNKWTAvNHZNRlNuMUFybU52M3Z1dU1oOHFkUEwr?=
 =?utf-8?B?aFNodXpIdkUzVW1XeFNweC9tRm4xMUYrbWcrMW81TzB1Ynpmak5COFVDYnpp?=
 =?utf-8?B?MmlXVkVhejkvNmxkOFk3d0JvK0NtZGhTYmxXU2ZMLzgxek41QktKZWN2djhK?=
 =?utf-8?B?alI2NzB6WExQekNrOUw1SEFmaWc2SVVkZEdEZXFGb1VDYzFhUW5DTmxKMlFk?=
 =?utf-8?B?YXBFcGJUNVN0QUxwZVJ2aUZiTXhVWndkTGdrSjZsWE9SOFl0RWJUVmRsQ0VW?=
 =?utf-8?B?MC9YbWRoMWRVeTNRV1JZb2RKTDg5S2tvT2ZhZjVOTVNEOXozZExtMWxhd284?=
 =?utf-8?B?dnAwR1duYWZ2aTlDNm9CYWJZenpRWGNOSW9IQ3V0bEt5cDF5dkdZK3VPNjAy?=
 =?utf-8?B?SmZZUEZnZXFQWG42WVJFYi83ZlBNdnFHamJyRzZjSzFLYjRWRDNGTy9oL0Iw?=
 =?utf-8?B?R1pET3hkMmZuaVU2YTJNdW1NRlJhSzB2c1daVzFucHhraGdjMTdFS1plekJN?=
 =?utf-8?B?eS9HNyt6di9GaHM2ZXZkVEdYWXN2bjc0aGUvOU9YRXI3cE41Q0cvM1doc1pq?=
 =?utf-8?B?S3Y2dm1BSGRoYk1GbGhHankzNWZ4UzA4YVBlY2w2WEpHWEdCVjZsQ2ZuN2pm?=
 =?utf-8?B?N0E2ZU9Ib0dsWUp3ZU00dm1FQWJQdjlxblZjdm96Q0VLSXhCd1lVVUV2R21m?=
 =?utf-8?B?ZDV4cTZhU0NoM3dacGhzTEhTMDE4ZXBVblRYUXIydmxTdkFZeTJPdXlKejlO?=
 =?utf-8?B?NDhsM3dIVEVHbmMzeWR4VGdHNDY5RlhLZnVpQ1E4WHdPVkNwLytDZzh2LzFm?=
 =?utf-8?B?bUZnaGl0aEFlTi9PY21wVzg3QnN6QmhkL1JBZjU3RzJSSmI0ejRxMWFKMkt5?=
 =?utf-8?B?OG9wSk1xOGFxMmc0bjdmYktaOXN5Wi9QV0NPMTh1ZVdla21hb1dJRWk0c0w4?=
 =?utf-8?B?SlFXcGVMeHBBdUo2VTRMZzRPMGduVTJTbjR2bEliK3pLZ0dKYnBtcnJOTXdu?=
 =?utf-8?B?K2M0VXpJaFFtWHI2NlJXN04waGVEQlhUaDN1TE5USlZONFlTZFJHTGkxblZR?=
 =?utf-8?B?QzhUTlp4VERqdzg2NXJTNzBRSHlsVjFxUnNsUVF3Ry9JYldrVElQdDVvWVll?=
 =?utf-8?Q?O7cEtnFVGVEO6bqvBnq7L0FmOmUUPz/U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFJHUE0wbmFsdWpzNUYwVTFUZlUwNEJxRFpJZksrZ0ljK2FGV3VKMUlsMnZI?=
 =?utf-8?B?aWF6YVJxQXplRVJxR3hTS2ZkWmJkaXRpWUZiZTEwSzdxSVVWQzB0cWFQTDEw?=
 =?utf-8?B?M1RoY1JXaXhXdjNVUnE0UXNWTnNZRDZlVXRtcDJIVzBFZmlJUmtvYktINlQy?=
 =?utf-8?B?UGdJU3lMUWQ5cTNXVlh1c1JnNG9raGgrY1ZBU3JVdk5pOGRDakluWEVLMWFY?=
 =?utf-8?B?a1hmU01iVDJjOWRZVkM0cTFjcmRLWUJXdm5rcXNNbDVuM28ybjcxN29pR2tB?=
 =?utf-8?B?VFkwWEQvVE0zZVhLRHdpbGl0ZzF6Y3NKVWhCOEhyTEJlRWRLOUVUSzFMbUp6?=
 =?utf-8?B?ZDNKeElDVFU1SnBIQUdGVEx1VG1lTVNIZHhVZlFSbzBuUUZPbFJSV0xNZXV5?=
 =?utf-8?B?SjhHbFlVeXVkUm9menFJSktMeFJGdGdybTVQVms0WWZvUHdaeEgvNlI0dzE1?=
 =?utf-8?B?QlkyM3FRaDRqTTcrZDlFMEk5NitNeEFXRDFwM2lXY3crelpLM3BFNHMwdDhT?=
 =?utf-8?B?ZWR3Q1huRm9IbzFVbU96UTlTZ2Y0TldlVTRyTnFjc0pKWEthZjdxd0M2cEZz?=
 =?utf-8?B?bXJpY3NmTGp3dWZDOWxYNXFaUXdGem43OGNraHNndTZOUHo0cjVpa3JRZkhz?=
 =?utf-8?B?Yi9OK1VDM0xEeVpOaGRqNlIvQ08rdDZEbEkvOFBwakdaMlpDYS9pZ1dGT2xv?=
 =?utf-8?B?QUMxcmY5dUZzb3kyNWc3RVlXb1hEMERlaUpwNEpiK1lnU3kxM3ZzakszUnNa?=
 =?utf-8?B?eHh1Q0FLRERSNEJueHhMRG45SjRtRkY1WDBBVnBzZEVMYVVYZjZBSWpCZXU3?=
 =?utf-8?B?bFN2TVZvZjNvL0pzajhvKzltbjNpYXQrc1dZZFpRb2E0cTIvY0FaekI3d1cr?=
 =?utf-8?B?UUNoVktDQ3B1WStDVi9IN2FBeEg5ZmlqVXM2V0lDZzVlWUsxV0hTM05MbnZP?=
 =?utf-8?B?Zi93RitBTE1jY29KWDNDRTE4RmNaZWpEdEFVcGRtYktEOFZlMUVYaWVXUURD?=
 =?utf-8?B?M0RSRFVGaElHMHJTQVZhU1M0K2RZVHprOFA0YzVubldqZmViWEFxak55ek5o?=
 =?utf-8?B?bkpWUlFrRVR5QWJIeGZ0aGtGczFOU1lSSGVDdFZ0THhTWDF2SWZ0MFpwQ1VH?=
 =?utf-8?B?QUROa0RMRFVPT3ZDZzdXaXZhQzBKTXAyTGhEQ1NJSU1RODQwQlhkUXRWRHVI?=
 =?utf-8?B?cmhObzY5eUFWWHNUYlFiMkpjbTRhTG5GR3FLZnZFTkFmbGx4RlhsUGRad1pF?=
 =?utf-8?B?MHN4T0JRVnArcVgyY3JFRERyNTZTKzAra1FhSW9RcTVYYnhuZ3JZQXBKWWZN?=
 =?utf-8?B?N2x0THZHV0g4RTZJU0c0cWNHSDN5bERhUXVvcTR6bWJqdGE0bGhacW94R3FM?=
 =?utf-8?B?WjU4dXR2SVRjNkMwYmpIeVhsR2Zyc1NQWkdFNEFWM3M3VlBMWGpGN0dFV0Jk?=
 =?utf-8?B?N2E4QTFsejV0clBkUFNjbmM5UnZDRmsyNlhXcTNmNzdSTm1kSUt3eWFlWkMr?=
 =?utf-8?B?bmREQlBld1l2Y0QwMFd5RHg5U3IrSldDbWExOEJOVUFTcGZnN2Z1TDMremxx?=
 =?utf-8?B?N2ljMUdUc0E4cG9OTnl3VVE3M3JEeC9pZTdkYWNIV0Z5ckVPbXhUTXVFaTZm?=
 =?utf-8?B?Lzdibm5MNkVrcHVwWjlBRDNWQVRlR1pPMWhYVnhra1dZekVTSUxpdHcvclY4?=
 =?utf-8?B?ZGtuTzk0T3pSRTZLWFV1a1QxK2hwc1YwSy82ZExVOTRhQnJtSGJ5dWZTNnlZ?=
 =?utf-8?B?L0lpbVo4ZUt5c0p6V1hOVGpiVklEQWZmeDRGR1dFcmZWbEpnNVA3eStKM2Jr?=
 =?utf-8?B?STFDdFg4NEt3WGJPVUZxTmM0d3JSbTBuQVFYWnkrOUszQm94ck1rYmR2TmRI?=
 =?utf-8?B?MGNxaG1IeVVQOHpRMi9UZEFZbVViWmFjbklOZGpCa25vUzFSMmI2bW91TGJt?=
 =?utf-8?B?Z2JjM3NWbnM0ODdYS0JRZUxJVkwwMFErUEZsQ08vVzEyOXU0OHd4OHNMeS9T?=
 =?utf-8?B?Vkp5WjJzclkxbHJBU0NUcTRTTDUxZkt1QW0xYWJvMFllejhOYnNkTVNTazlD?=
 =?utf-8?B?MGpMdjgva21wS0grdC9maFpoZ2xoMGY1L0hGQzlweEFtRlVmODhhdGZTc0cr?=
 =?utf-8?B?SXNQNUpsV3hEU3NoOEdkSkdLVmF5UVZqVE96OStiU3huL0tqanh2OG1yVmZ0?=
 =?utf-8?Q?O0g1Gf8OY33Md3VZkXq6A6A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RBIT8ftWbXubt+ZTn2hAT3TnI7/gYcWmnwDQ+Iu572H0cxPeGB5yCThJAtxyqAlWOZcqf8zUSXa7VtpmYBJpuoqkDjjqEnwTLA43jkWiES2PDNcJ85izWuW56svrpRhWuYBgj47dgxN8VAD4iOtuxgnqu/3Ew978f0c+oMQ9tGeVAR4DXrTCrIhOhbNERM3XbI4tWGmL/JZKgkC1XkSKw4lBRCOXF1/dvMupdT9FifMkX8tCpi/2YmBVHwh7HRZIS02pD5RZjVkhFfsmybtJT+8QwIpN8RmP9076rIeSdm7fzCJwVgoNRBuldq28zUXSJzdZnOxCAjayXMYLbVVYYBE/EwOsvF+jHzoihTqt8QY2zhv9hOsckOKVIm/YaoWGS+5jBeJhxHZyg4Ds+fcUbb0whNplpRS5Kn55rUgqJ/RXMqeLUo2sZcmwX6DwYK6u32X3SQy/VHbqWd+oQVC/V5lUEyBqs1WbWEgEhOzhoDzGoSwn2Sz8I2dORx0NJJXmr9HsmU2TKXoDWjqEX4a2cyw2gf9S+rdKPBugziBpJcWhmTNhv4wX4MNhgzhkKcdX5QuWmCewb3R7uPVaTNX8oMe7oxtST8dmb1tfwsMj/qs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee3b08b-5d05-4f1a-e102-08de0c069684
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:19:16.9941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDFzD+XOAbC8zMSU5gdEgd0zYDGYas+95KDrnxartk3eMPQwSqT9T3cZirkXtKJ16uGzTrv1JIyS1tTvPAKqTjZgAgp19KDxIKTm+GgQk9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7422
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510150116
X-Proofpoint-ORIG-GUID: ABeFRtpoDtsJu9BzT8z5v64bGBSmLlrQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX7XmnP7mAOot3
 t9MBdkinfFQtBgEUbbumAzsmOdZakSWaiXn1Me1eSgn4zIoSoPRit3MQoCuXhFOHGoX8dtnA11T
 BVdG6M1WkAiM5ikJwkA2TFmyptuUtNrYWFMR/BsoQOHc2CkOsYQV6gC3OGFOjIEVe7G5Cyw4TQK
 qV84P+fdWxhEw/8wE2SwV53p28Jh5WbMbeOdbMEE0nQxpDcq2QvYeWAjaDirsbwwwLW5dkQkc3V
 eK3TM6PvM2Sh37y+QRkdYDYrIUyPVXG1e0ktaYtM5G18cznLLk8X7+kKHLChNyeBk2Tw4C0AQtG
 d95cOtJwSG5mAV0Kde66E8nrmDZbUWuDKGr9fZsIOuwki3SQ2fgKM/rE69NKmaJD2kMB9JttdiL
 re7dIuAUSKglehdPTfg+fgEkLxoKiAOTu6btBgJA9F6jbZdl1EI=
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=68efc988 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=hunbe5pYdNfm-mRBePEA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13624
X-Proofpoint-GUID: ABeFRtpoDtsJu9BzT8z5v64bGBSmLlrQ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 10/15/25 3:32 AM, Michael S. Tsirkin wrote:
> On Tue, Oct 14, 2025 at 05:46:40PM -0400, Alejandro Jimenez wrote:
>>
>>
>> On 10/14/25 5:02 AM, Michael S. Tsirkin wrote:
>>> On Tue, Oct 14, 2025 at 11:13:51AM +0530, Sairaj Kodilkar wrote:
>>>>
>>>>
>>>> On 10/13/2025 1:45 PM, Michael S. Tsirkin wrote:
>>>>> On Mon, Oct 13, 2025 at 10:30:45AM +0530, Sairaj Kodilkar wrote:
>>>>>> The AMD IOMMU is set up at boot time and uses PCI bus numbers + devfn
>>>>>> for indexing into DTE. The problem is that before the guest started,
>>>>>> all PCI bus numbers are 0 as no PCI discovery happened yet (BIOS or/and
>>>>>> kernel will do that later) so relying on the bus number is wrong.
>>>>>> The immediate effect is emulated devices cannot do DMA when places on
>>>>>> a bus other that 0.
>>>>>>
>>>>>> Replace static array of address_space with hash table which uses devfn and
>>>>>> PCIBus* for key as it is not going to change after the guest is booted.
>>>>> I am curious whether this has any measureable impact on
>>>>> performance.
>>>>
>>>> I dont think it should have much performance impact, as guest usually has
>>>> small number of devices attached to it and hash has O(1) average search cost
>>>> when hash key function is good.
>>>>
>>>>>
>>>>>> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>>>>>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>>>>>
>>>>> love the patch! yet something to improve:
>>>>>
>>>>>> ---
>>>>>>     hw/i386/amd_iommu.c | 134 ++++++++++++++++++++++++++------------------
>>>>>>     hw/i386/amd_iommu.h |   2 +-
>>>>>>     2 files changed, 79 insertions(+), 57 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>>>>>> index 378e0cb55eab..b194e3294dd7 100644
>>>>>> --- a/hw/i386/amd_iommu.c
>>>>>> +++ b/hw/i386/amd_iommu.c
>>>>>> @@ -59,7 +59,7 @@ const char *amdvi_mmio_high[] = {
>>>>>>     };
>>>>>>     struct AMDVIAddressSpace {
>>>>>> -    uint8_t bus_num;            /* bus number                           */
>>>>>> +    PCIBus *bus;                /* PCIBus (for bus number)              */
>>>>>>         uint8_t devfn;              /* device function                      */
>>>>>>         AMDVIState *iommu_state;    /* AMDVI - one per machine              */
>>>>>>         MemoryRegion root;          /* AMDVI Root memory map region         */
>>>>>> @@ -101,6 +101,11 @@ typedef enum AMDVIFaultReason {
>>>>>>         AMDVI_FR_PT_ENTRY_INV,      /* Failure to read PTE from guest memory */
>>>>>>     } AMDVIFaultReason;
>>>>>> +typedef struct amdvi_as_key {
>>>>>> +    PCIBus *bus;
>>>>>> +    uint8_t devfn;
>>>>>> +} amdvi_as_key;
>>>>>> +
>>>>>>     uint64_t amdvi_extended_feature_register(AMDVIState *s)
>>>>>>     {
>>>>>>         uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
>>>>>
>>>>> Pls fix structure and typedef names according to the QEMU
>>>>> coding style. Thanks!
>>>>>
>>>>
>>>> This is something I am struggling with, because the name
>>>> `AMDVIASKey` does not offer readability.
>>>
>>> AMDVIAsKey
>>>
>>>
>>> Or you can update all code to use AmdVi and get AmdViAsKey if you prefer.
>>>
>>>
>>>> Maybe we can come
>>>> up with an alternate style which is readable and does not
>>>> differ much from the current style.
>>>>
>>>> @alejandro any suggestions ?
>>>>
>>
>> I should have pointed out the CamelCase requirement for the typedef on v1.
>> My initial reaction was: "do not use typedef" and go with the slightly
>> longer 'struct amdvi_as_key' instead.
> 
> Sorry, that's a coding style violation too :)
> 

ACK

> 
> 	Typedefs
> 	--------
> 
> 	Typedefs are used to eliminate the redundant 'struct' keyword, since type
> 	names have a different style than other identifiers ("CamelCase" versus
> 	"snake_case").  Each named struct type should have a CamelCase name and a
> 	corresponding typedef.
> 

I hadn't parsed the mandatory nature of typedefs for named structs the 
last sentence is setting. Thank you for pointing it out.

> the only exceptions we make is when we import headers
> from outside libraries to interface with them.
> 
> 
>> The style guide has a warning about
>> typedefs (which doesn't necessarily apply here), but IMO still better to
>> avoid it in this case were we are not really gaining much from it.
> 
> not sure which warning you mean, or why would not it apply.
> 
I meant the duplicated typedefs portion, which is irrelevant for this 
discussion I believe.

> 
>> If I were to use a typedef I would use 'AMDViAsKey'. After all, the 'i' in
>> AMD-Vi and 'd' in VT-d are lowercase ;)
> 
> Sounds good.
> 

Looking back at the precedent in the current files, I think your initial 
proposal of AMDVIAsKey is the best choice for consistency at this point.

So if we have consensus on the typedef requirement and the name 
AMDVIAsKey, I'd say the other new struct type introduced in [PATCH 2/2] 
must use the same scheme i.e.

typedef struct AMDVIIOTLBKey {
     uint64_t gfn;
     uint16_t devid;
} AMDVIIOTLBKey

AMDVIIOTLBKey is a bit awkward, but closely matches the existing 
AMDVIIOTLBEntry type, so hopefully that is not controversial.

Thank you,
Alejandro


>> But my opinion is to avoid the typedef altogether.
> 


