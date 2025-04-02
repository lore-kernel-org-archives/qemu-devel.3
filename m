Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBB2C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzyT8-0006hU-KH; Wed, 02 Apr 2025 09:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzySM-0006dN-My
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:48:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzySK-0003HF-8d
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:48:38 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532DN2Wl021713;
 Wed, 2 Apr 2025 13:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=NRbz0/7gZ0s9sx7bfy+Dv5CTOJUNucgcRDaxlc/25Jg=; b=
 ht2o/jPuOE09hAb8lTuTcFjq5/FpB8TFYkMHBZ/IaclS6I03P31L0LGI2ckzgNEq
 nkpc1Ir7U5t26OgQ/MmSsWA27JBm7538ZYIQ+3bUKDQyZffMpcbodkbWqZhj5pW/
 18Y9ez9yYlbl014dm3d7MTFWDYMvLZi+BWqn9fktxpm6cwf4p64QIe2ykE8YqUCT
 aDbVSAhnCtEBSq95MI0VSXwpdCn6/V6b9Y5MLoy6i9E4YbE4Ann+oPtP2i3APUmj
 PATmYpv+MlVJ66WvrMGCHdq1p+dJc42QVGXbOVBmZCtNaZy93uI+UBRXup1SQBgq
 hAxExdMbUQ/LteBsYkip7A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8r9j6qt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Apr 2025 13:48:32 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 532DN3uI016845; Wed, 2 Apr 2025 13:48:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45p7aaq1nx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Apr 2025 13:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwRayA+pw4uiBGX36EGNbI4iu2HafZOEXPxeYe4E/kUT4Ux3y7ibN19HQq2IsXUjxtBhn5hO0L9tRc9w3DMr5ETagiHWYkiW/f8/6ofo/VM6YZFLPua5raewisq6fzK31khkU0aiCarQkiL9D3/CfB23vYMoScgMi1hrC8h/GeaPCl+PYw5gmGhnha6jyNyMZ3Rah3NJ4IAeZU49uPU6si/pGbcNICQuyyaqAjIvvxAxBtTqdzjNPMpL7zFJUANsLCHSn7ETLfij1Zmgv0rj1m5zYEN3x0WslpUTb7bKa8DvFGKgyp2XxXIB5G82YK8uZdRpOGLgH3xtWv+2imtqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRbz0/7gZ0s9sx7bfy+Dv5CTOJUNucgcRDaxlc/25Jg=;
 b=O6vTVek7CiYoVPkeAgIigLkmtXtrHStAXiU5rGYnDIraB8G5R+3ODo3JQzcpGcUo8ii89jzz4MEZ7Bz9QuK2L1WnoUqiobCZUFJpJlV1/OEaLsgT/8UyHMlrdsYvUSMw8LwvP8k35s2uSSFqglkqil+wKSZoYhzg1RwuBPdppLvb7i3lb1FN3wWg9gd5rvovhWB/mF+8SEx2n4b0o4+HkSmPnkyajL+21SHu3zQK4QO7Ztxbb9zh98eiJ6od9iqeEmjh1UTUYW37db2h3SY6fn6TZy3gjlQ+f+gcdAYmPoSy6HAfXh4OXsnstm/uJT+NJx8qIsq0507nqCMi33b+qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRbz0/7gZ0s9sx7bfy+Dv5CTOJUNucgcRDaxlc/25Jg=;
 b=oa5VEFTL/igva05H8itmec57FNxb02HlAGaXsxkPW6Q93uxZx3aAtOcnMKK6zUmcdm2+bedfu4fhlpImYACv2S3M3XV8CpwstaqNf6U4ecksUmiknWeLddnprNYVnPIV5osgyB3Ohp/zZgNbkHl2BgeR3Nus+K3KG8F2TMfSDRc=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH0PR10MB4613.namprd10.prod.outlook.com (2603:10b6:510:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Wed, 2 Apr
 2025 13:48:29 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8583.033; Wed, 2 Apr 2025
 13:48:28 +0000
Message-ID: <2d6783fd-60be-4da4-8d9e-782bce15a776@oracle.com>
Date: Wed, 2 Apr 2025 14:48:24 +0100
Subject: Re: [PATCH for-10.1 v2 32/37] vfio: Introduce new files for VFIO
 MemoryListener
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-33-clg@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250326075122.1299361-33-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::19) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH0PR10MB4613:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c71afd3-1d91-4ae8-eaa8-08dd71ed0c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3phczFhd0tZNGV5SUVUZHRJa1k0TG1mZHRoYmQvUWJKc3BVbGw0YTZjQ2Jx?=
 =?utf-8?B?MFhQMmsremtGbTlMbWszZmlkclJlOFZhSGlvMU5oY2RhWnAwWTlsQ2hnOGtT?=
 =?utf-8?B?UE04bEF0RlFHUG5uNWovbUVUNHpncnl6M2ZPRllQR3RTYTI3d1pTNERVNFhJ?=
 =?utf-8?B?dnNzaGx3T1Vac0luV2RmS3AwNGZxUG1POGxrdnJwM3BUdzR4TlV5THpWVndB?=
 =?utf-8?B?WEFxNUZFL0dYcFA1WTBTTE9rcnZIbTltRGdmbDVLakFnVXpXME1GVFFWNzZC?=
 =?utf-8?B?bGdienpDS2ZkYXJqQXk5QnBBUUd2MDFRNUwrUWRXZjM0ZmFmeFZ4Ymt3TDhC?=
 =?utf-8?B?N2NnSTZPalFSS0ExM0NFVStNVy9PMXBXYlJHdzgvOUZGWGR3M0hncmRVdEJs?=
 =?utf-8?B?YXdSaU01Sngxa0JYQ3pKM0ZDWDZXbHhYaHV1TjcvRnYrV2JneVRhb1FFRmht?=
 =?utf-8?B?cmMvblI5Y3dOVXg3KzA0b0dOV2VnL0lIOG1hZG9LVFNiOGI0S3N0dVVhTDVi?=
 =?utf-8?B?aGZxR094Z3R0aGhGZHJDRkhNV1JHMnh3SVdlM1NlYjdpNGtNVTlmVFFiODZF?=
 =?utf-8?B?ZmE1MXI1WElvbnErZ3hOczd0VzNIVmVJRHExMW1MV05aM0NMQXNqdTgyYnZw?=
 =?utf-8?B?KzhSczJRRkg1bThCU096UTJMc3BYc2dKdXkxWUJjbFFCZHpHaFI1M05pYmZa?=
 =?utf-8?B?NW1Fb0JuelRRRnFTQkhsVE0xT2RRRFA2amJGWnlIeWFZSlo5WlpielRpKzN6?=
 =?utf-8?B?TWN1VThCNkRKcEtPbVhxa00wWHN5M1dZYjhLUnRXeEsyY2dsMXpjYjVVV0lI?=
 =?utf-8?B?T1R1WDMzbm1Yek9QVWhsZytxVzN5M3k3Sm1xNElmcWJxME9mRWdiN2d0N2FZ?=
 =?utf-8?B?Znd4SVB0eVlsbGY2VzA1Nm9QZ0pNTzhNRjUvYUpvbWd3aWZodXczS3NSc1Z5?=
 =?utf-8?B?UE5mQUUvY3VCeXJvNDZlaVpBWkZlakxqdmg2dGFRUTF1STVWKzNpQ2xiVFVI?=
 =?utf-8?B?VzBOejRlNWZ5Y0FsUFY2MGdQOWJheTJHVUNCdWtjWFFwK04zcTh1Qk1HSkhC?=
 =?utf-8?B?TW0wVHNncjRUVnp5VUxCalk3c0JqWEF2cW9aNzZqUDNGZUxBbFhPdFZmc0du?=
 =?utf-8?B?MTFUUUM2c1RaME9jRjJ1RlIxZk9hNmk5b0YxeFJTRDRFSzRyR0RUNVJieDNP?=
 =?utf-8?B?aXRtcnNLdFRZN0VpVXRDYmZRRkwzU0plQnpMYWNISnh4L0FrUHM0djVLa3lP?=
 =?utf-8?B?NnNZTjFSMG9wOU82RDdMSU1lbXhVWUFCY0JQZ2FJWEhNMzRCZzFpd1RwaGxV?=
 =?utf-8?B?V2dzVXlEMmFzRkRTRzhhaHVXZEcwdWhkaGZIOTlGR3lETnpXdWxFSTM1UmJu?=
 =?utf-8?B?V1NKanpESXlKNEZiSFFsVlFQL1V5VDBUM1UwZHJ4WGhObXk5T1RkSXVQd1ZC?=
 =?utf-8?B?cGZnSWE2aytOR09mMk9sdGVMZjQ5dXRsSC95NFlRY0hsQTd6T2xIbmxKV1Jz?=
 =?utf-8?B?dElsalVDd1pzYm8raU9pK0FKeXY3aEJYaHlCZ3lvdWRaTTU5OURmenNnMTEx?=
 =?utf-8?B?ZGdoUnE0VXFyMTVNV3FsUUhBS2E5TzJ4aHhiRzMzbG5hVzhWaDNrcVFaTG9i?=
 =?utf-8?B?RWxIRmtZcVl4SUZXR09XcjlPN1RwUjFLUVlNZG5hUlBhYXQwaFNybTkvWkd4?=
 =?utf-8?B?YWROczJzUENmRjlZYlg0THg0K0I1UkVFdG1UWHFqSTZQQ2p6bTNiRlgyOHF6?=
 =?utf-8?B?bW1ocjdlcFJEdlg4bzZPTEM5d1pUQUdKTDV3TkgyVURnRmlCeEFnbis1c3NG?=
 =?utf-8?B?ZUxuOTcxblZBQm1DRmNJRGRycWVseVkvUi96YU5hRUt1RFJNbEwxT2RUR1dS?=
 =?utf-8?Q?5PwCI2/kobdTq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEY5TkJCaXRmK1l6WVN3MC9rSWF4eGNuc1QyRXhzaHJHL3p3d1NuUXZPbExO?=
 =?utf-8?B?YXVCMnJSekhkV2N5RVUrM1BhQVdIeVNucUdEY1ZhZDZURk43VEYyU2ZOaGpr?=
 =?utf-8?B?VHh2dHRCYjAzOHJYQStFQU5XUlVZT3kySndGY2xic1NjbnczSGxTVHl4dXlF?=
 =?utf-8?B?NkxhZXJYMnF3T25ja0ZuOWFPSU5uMWNSTS81ZnYwSHlXQ0tTQTlZeldreVYz?=
 =?utf-8?B?NTJBNXNJcVN0bjM1dGJzdXhTRUcyZHBOdXkwRmZ2d0JTN2NianVKaWJZNVFY?=
 =?utf-8?B?RmNuUTIyYTR5WFJJWmRjT0d1TitLTlhrNzYwNmpiZGFoVUgrN1JOVll6ZWtn?=
 =?utf-8?B?cGc1MWRmbFVGVXl5aFFnSEhaNUJXbi9BemRhUnZ2MVZPSmFxdVdWNDMzOXBw?=
 =?utf-8?B?VUF2ZXlSQ2ZXbDFkS1VsUGdIZ2RKOFF6STNJN2dhRFA2ZFRlNTBJVnB0WUEx?=
 =?utf-8?B?dnJXcXNkeVdnaGZUYUhsM1VyYlQ0ZlM4eDZNcDc1ak5ZaFA2SjExMEdnSHcw?=
 =?utf-8?B?SmxUazltRFB4aUdid1N6aEtBWmJRRVNma0huWm03NURUdmVJYldhMkdLbERh?=
 =?utf-8?B?NCtZLy9RWTd1S1VJejY2TVdJQUZwK0dWL096YWR3TnBkTXFJbUxOVzVIVzRk?=
 =?utf-8?B?YkJLajFMVmtNY01JR0d4UVNKN2w5SG1jcVZiRFpnTWhkSTZRZ0JMUlZCaU5K?=
 =?utf-8?B?ajRwMnc0MitDdkdCbjRVV083MVNtQkZYUHJHZytkdG00NDZjcndvV0FYOWNt?=
 =?utf-8?B?OXNKMW1Vc1NtNEc2V3RjQlZNQUVlWVcxY1lkWElvUDRZbGJROXhWdkN1NTcv?=
 =?utf-8?B?ekhnZm0wRFlDR0s5LzFDM2hxTzZWanRsV2JQSWhPUExtdVQzMDJuc2pGdW95?=
 =?utf-8?B?NzlFMzRubjZVdDBaWjR6K3ZhdFNTNnB1Q09yZ2VZdFAvbUloREticitwb0t0?=
 =?utf-8?B?VVdhYmZqK01IdXN4STVoQlBEWXlYcUJscEViN0VoQWNyQmN4MXNBL0ZaY0hn?=
 =?utf-8?B?bVJoUnFValIyMHFKdFFxaVFrTjZpWVdxa1ZoVFBzbEw4Q0d3N2FtekNDVTVa?=
 =?utf-8?B?MkZvc290NHZzL01YOUxVd2QrMDFRVmduRFFmU1pZWFpVU3l6V2haR1d6a214?=
 =?utf-8?B?UEd6ekJEcVBRRjBiZkNOaXZJd3NDblpab2xyMXA0MFFTKzNYWHVoZllRYVFD?=
 =?utf-8?B?SndKdzMvTjNGK1ErTm1DWHZmS1ZNQ1lyRDJqdysxSmlUSm1yc0hxa3g4Yi9L?=
 =?utf-8?B?VkhnZCtUUUt0OVFVbTdJZFBWZXhrbDlqY3dyS2NmRHdxVTVhaDZ0eHhzejNk?=
 =?utf-8?B?SHg0aVk3UEYzWS9WcFpDVzYvVHhXeXBlZzVVOTd1R0RHU2d3MFZZRHpVUU5T?=
 =?utf-8?B?b2R0K05xY2Q1czZieWJHVUhLTDM5OXdRTWI5dlRhS2ZKMTBHNDcrekRyUXNq?=
 =?utf-8?B?THZlOW5EUzFqKzl6aDNkaUJPT2hFY1QvUjZ0RnZ4MmZwT1gyNi84QXJMQ1cv?=
 =?utf-8?B?cDRVbzl4eGdSYXZ2RWY1REUxb1J1aEVzeldiTU1taXpkY0RhVkd4ZE9RNmlN?=
 =?utf-8?B?eXdaUHcvNkhhNGFHaW45UVBWZ2Evd2kyNUJYbGxrYjBDR0VzWW15RnhZZWRy?=
 =?utf-8?B?RERyOFVpQkNIMzYzcm1vQ0s0T0tlMmhMT0dwY2RvMVEyUis4dkF6TEdIZ2Qw?=
 =?utf-8?B?b3RMN1lHendHUjVGMU9DWDA4aFJkcEpwdnRmWmt3ZHBRbUwxbHoxQ1ZJdjhy?=
 =?utf-8?B?U01OSHAwbE1kbXZtSGtvZGhkWWtDNnVYS3d0UGY5UmNnT3JOSnZxODBjZ3hm?=
 =?utf-8?B?N1Q0aUg0aHgwSVR6czUxVjk1NWlZRDN1WDJqOUp4SlplRHlUUkczU2dSTHA3?=
 =?utf-8?B?MUxUSDFjUEZhWGczR1MyVjdMQyt5RlBYYTQ1MWV0TnJpQzBkS1hZY0l6Y2lq?=
 =?utf-8?B?VkcyMUFsWUJYYStiV2hQdWhsRFV3elJwOFVobTdVY2FnNStPZHdIaEE4L1Na?=
 =?utf-8?B?aTNSeUhMcExpcWRQUmx3S05vSEl5RlI2dTd5L2V5UnVZRm1hSWorSXZwUklG?=
 =?utf-8?B?MU94dytTRDhTVXZKRGhHenMrU2pWUU9lSWNMV0xTcUdudnhFMnJEdE9iWDhR?=
 =?utf-8?B?NC9HSVdBNnEyVGFBdXZYYlF2NEJuZ0I4YXF5emNFR3ZqWmEzTThaNzFJa2gw?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PriAtoXoh29S1njwBWI9Rkpxc+SyaaVcDgv4NWv4jWGCCIaujnTCCCcwZJd0ZsFkwe/Pw6AOLTdG+1tbRKbAPprjwFhwdGOxbKI6oYhic91jmLnFBRFx6Ry5oJ0tNJ4WPvIRGCcNuEYHqMZdt+7c7++0o/qv9gQnqQ7sdRa7Dg6EoSK4YxkY22olkwBgipYcpVa2dG+v1pVw7wF/4KjXqGsd7gdejhXJAdp1XVHwWqkU/qpOTxN8X6pfSLVTcmUMU1zWZ4nESIsyUqixB7ORWvml7Odv65qxbn79wOTiyR9Z5pKjnG30zSTuXDZLt2L1iS/GG6Ok9AQCVZvsG6VN/lcWi6quIeIx5ysZ4H7QmmQksOx+Uku4kXcrlcRFM7l2UF1toGrsxqJ1Mn5GbE/VEpFtUgFK8VkPGiNut7DSS3FMuqIM87f2K4ap11RdVH0/wVClY8vWP+SECSmxZr6LuDhJN1g80+jWWnKjQwCk1abCVwjmZarY1yw+CBixTkSr2eYvkUD5fTkWVBBfui9bpQJygxmzxaaMJTrkVx53/nnuhewxJv5+6g4LpU2ZKM7ftgEcbAs9xM7nE17TxgZUcJuIohgkmFtyKqtfNqcMS4I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c71afd3-1d91-4ae8-eaa8-08dd71ed0c52
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 13:48:28.7993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AISaB6HwxxE/vt9hOAlOrasex8Bovj4C+a43zVjW3rFBVPVWF7ZkLqmTUNdT6kzOaqUom1DYUFI7+ORn9zfTulBP/pu35birRMaRre9QnOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504020087
X-Proofpoint-GUID: GckEMFv-hN0YeO69-EpSzvrh8pRTuRew
X-Proofpoint-ORIG-GUID: GckEMFv-hN0YeO69-EpSzvrh8pRTuRew
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 26/03/2025 07:51, Cédric Le Goater wrote:
> File "common.c" has been emptied of most of its definitions by the
> previous changes and the only definitions left are related to the VFIO
> MemoryListener handlers. Rename it to "listener.c" and introduce its
> associated "vfio-listener.h" header file for the declarations.
> 
> Cleanup a little the includes while at it.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/vfio-listener.h          | 14 ++++++++++++++
>  include/hw/vfio/vfio-common.h    |  1 -
>  hw/vfio/container.c              |  1 +
>  hw/vfio/iommufd.c                |  1 +
>  hw/vfio/{common.c => listener.c} |  0
>  hw/vfio/meson.build              |  2 +-
>  hw/vfio/trace-events             |  2 +-
>  7 files changed, 18 insertions(+), 3 deletions(-)
>  create mode 100644 hw/vfio/vfio-listener.h
>  rename hw/vfio/{common.c => listener.c} (100%)
> 
> diff --git a/hw/vfio/vfio-listener.h b/hw/vfio/vfio-listener.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..93af6747b28955f038454a335b361787f8364a3a
> --- /dev/null
> +++ b/hw/vfio/vfio-listener.h
> @@ -0,0 +1,14 @@
> +/*
> + * VFIO MemoryListener services
> + *
> + * Copyright Red Hat, Inc. 2025
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_VFIO_VFIO_LISTENER_H
> +#define HW_VFIO_VFIO_LISTENER_H
> +
> +extern const MemoryListener vfio_memory_listener;
> +
> +#endif /* HW_VFIO_VFIO_LISTENER_H */
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index a804af9f651f0916ca06b3f4f009381eea385ba0..4ab6e18d3c798ab379b98a0a16504814ec0556b1 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -131,7 +131,6 @@ VFIODevice *vfio_get_vfio_device(Object *obj);
>  
>  typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>  extern VFIODeviceList vfio_device_list;
> -extern const MemoryListener vfio_memory_listener;
>  
>  #ifdef CONFIG_LINUX
>  int vfio_get_region_info(VFIODevice *vbasedev, int index,
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index c74e08e531a501313cab27c57728a8c940d975be..acebb53dcb1b829d31cc31d9f7f2cc9599f952eb 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -35,6 +35,7 @@
>  #include "hw/vfio/vfio-container.h"
>  #include "vfio-helpers.h"
>  #include "vfio-cpr.h"
> +#include "vfio-listener.h"
>  
>  #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
>  
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index a5bd189a86d70bd11ecb80384ac145a51979322b..7488d21215b6eee78c9c51cfb227d9c8c59c4978 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -28,6 +28,7 @@
>  #include "vfio-iommufd.h"
>  #include "vfio-helpers.h"
>  #include "vfio-cpr.h"
> +#include "vfio-listener.h"
>  
>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
>              TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
> diff --git a/hw/vfio/common.c b/hw/vfio/listener.c
> similarity index 100%
> rename from hw/vfio/common.c
> rename to hw/vfio/listener.c
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 9c8a989db2d4578e97d864c5fd8bcba125eab66a..bccb05098ce18968caaa4d5d8dec3df0852d0398 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -1,6 +1,6 @@
>  vfio_ss = ss.source_set()
>  vfio_ss.add(files(
> -  'common.c',
> +  'listener.c',
>    'container-base.c',
>    'container.c',
>    'helpers.c',
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index aa0ba695fa38f7767bf506ec604046101186e7d4..ddb1bcc24a9cdc405713ca04d4ecc3d4a923ec42 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -89,7 +89,7 @@ vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
>  vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
>  vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
>  
> -# common.c
> +# listener.c
>  vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ 0x%"PRIx64" - 0x%"PRIx64
>  vfio_listener_region_skip(const char *name, uint64_t start, uint64_t end) "SKIPPING %s 0x%"PRIx64" - 0x%"PRIx64
>  vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"


