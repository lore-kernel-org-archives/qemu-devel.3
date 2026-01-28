Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E110D35660
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 01:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkuJN-0006I1-Ha; Tue, 27 Jan 2026 20:25:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vkuJK-0006Fy-MT
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 20:25:35 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vkuJI-0001wh-Sr
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 20:25:34 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60RNEYJo744707; Wed, 28 Jan 2026 01:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=jkBhiblsvUPtGlrHKhfSLmBVyyjlbA+dpoh3jf0ESFM=; b=
 FQg+QcFEvXQUnFeJffO5M+yhVZo+I5OjpoQbDE0p7Rbplooh+tsySUghPsq9nx7r
 IF3ctLL3T3xAfFI7g2sdADM4Q9ifoo2UoTV4XNZybx2ayYwINt23yhVofkYep3kQ
 h0nPG2JvHV/nx7vwrRTfS4K+SFH1CXM3KsFTBN/zNdA0U9mCnH5QR09qPS6N3AjN
 0qJylpu11QF7xrkCMAGu2uS+idSKLTFNJmQcoXIeWZfktaxGxd9XfEa/mWfr7283
 tDUazg5B/9XtYHcBnOBfi0V0opijojGbHD19NoUnrTYLtxR0WIyzz/vsKoY2Xpzv
 RZC45HYrgqsDBv8kYPkvHA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by5t687tf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Jan 2026 01:25:21 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 60S0UbN6010031; Wed, 28 Jan 2026 01:25:20 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010031.outbound.protection.outlook.com
 [52.101.193.31])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4bvmha8vts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Jan 2026 01:25:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0q3ygjrEkAsGUk9VA3AAFfTFw6oGE593EEF2DDHdjzXyYBcEJbbsKQtgKNWjy2p0LBfw9cLyi6BbJ9Fa6JLVabKftP1c3TMKB8EATE2iRvRxkj2q0f62kRZj4artHgDjoByf9UmOBmIU24Cl/hyjM06UV3IKLTpkngIal02OJRgxDms1/9JaJzI1aFPVrdpQHDNtRRLwmE/DmPXH+SxH6S2oRa25uUrR1QRW/Y7QPSU/ipmT46onAISklSC/4oHjln4gSJyLrCY3o2NOkn+F/Sk+wZ55AopwzcUXAAESsbqk5LkyAYufef4lGa+M73GTw2aEK7knlJ3Oz6gYKwBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkBhiblsvUPtGlrHKhfSLmBVyyjlbA+dpoh3jf0ESFM=;
 b=jbTdSkzEegB5wJSjpicVhnFFTvWvfLP4jjg0BzeWrXR4lPb57vuzSdP6QBcKfY5znlCI56l6r0AJOYUFYEGfTUfQduvRgUNCNYfXeiUK6XX4HRv7qgFM3SAtJD987Qb8EYzU0fYeg8DBSwOvUJ2w1sg1JCXAs9THvqAUB4AG65i/Ze/W9X4dJft3GjCud7oEF44AC7P0hcCrd6W6EJZx7qZ+NZv+E5cxwBtF8G6q9wev/le876Iw9kHiNX83SeyQY2j26u5wg6Ncv49kGEzF3uMal1L/No2he9QrPnrfzVq7Y1OHxd8e00CpWXZXVZataWq09k8aAYp86PxgN//0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkBhiblsvUPtGlrHKhfSLmBVyyjlbA+dpoh3jf0ESFM=;
 b=mCFEEBvDCqr55lIQPqkVqx0z4KylhkRo7/UogelxozN/IUDJY32m5oWpX6BHOADz7btdhmAS8lBgtZcSiQz49LujpnGbktszYuO5l0Q8OzlnZ5N5m69a24YYyknxSqVmycfE1V8solAV5MtMqphnDqTI7MsiXHGHX82prhUdGaU=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by DS7PR10MB7347.namprd10.prod.outlook.com (2603:10b6:8:eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Wed, 28 Jan
 2026 01:25:16 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9542.009; Wed, 28 Jan 2026
 01:25:16 +0000
Message-ID: <804a631e-1690-489e-b2fb-5ddded3efaeb@oracle.com>
Date: Tue, 27 Jan 2026 20:25:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 2/5] vfio/iommufd: Add amd specific hardware
 info struct to vendor capability
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, vasant.hegde@amd.com, suravee.suthikulpanit@amd.com
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, cohuck@redhat.com,
 seanjc@google.com, iommu@lists.linux.dev, kevin.tian@intel.com,
 joro@8bytes.org
References: <20251118101532.4315-1-sarunkod@amd.com>
 <20251118101532.4315-3-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20251118101532.4315-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0071.namprd17.prod.outlook.com
 (2603:10b6:510:325::28) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|DS7PR10MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b3501d-887b-43eb-047f-08de5e0c1798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkcrV1p4REZPT0RIQ0l5MFFwOFBnWEV1eW5ESlUzbXpLRWl0N3NGeWVkVmtl?=
 =?utf-8?B?QlArTmdJc3FCMUFUbTdrZEY0UVQweUp2VGlkUFNkdy9FZzBEMXUvWnRldDlU?=
 =?utf-8?B?cS9xQmp1azNneERka0src05IaDZvakFQUzU4aFovNFR3cTFacENFdFpBcWdS?=
 =?utf-8?B?KzE2YlhBMTd2SnhES0o5MTB2WVBxd2VwQ2F4MVNzWXhURDZFbXR3NGl4WUln?=
 =?utf-8?B?UG5HOGpqMHYxbnppRklRZzh3TXZNNDc2OU42WU1MQ215NDlCWWNEekRZSS80?=
 =?utf-8?B?RktVNFdvZ3dqSmthMzJvL1AyU1l1Z0p0M2pheldNTE5Md1pxck9tLzJhZWRH?=
 =?utf-8?B?TW1rZlRXdGdUS3hZSHNtaE45MkxHekZVbFNPdnNNbFBJRTN4WU40Y3lJVGNX?=
 =?utf-8?B?WVFzMDZNWnZiSzdLNmZuaXBpMDV5aGRtSiswTXc0ZnhuQ045UDdVTktNTXhD?=
 =?utf-8?B?QWVSSEFFaEp4YWVCOTdjN1RLY0Jjamc1ckpkZGt6TTA4eVk5V05EbmhzVUo1?=
 =?utf-8?B?YjJhdXJPUlBzeWVrZTZrdmRHVjhJcmthdUhyWnVaaGhkbHQ1dFlNKzE3VHJG?=
 =?utf-8?B?NVhjRDJqSTBlb2RFNXRMWmRrdUNiSy9zYnFmZWlpWHFIWlRIMU1vNHI2eWoy?=
 =?utf-8?B?UHJaWTlVZEQrcUZWL1huS044NGo5L1JxM1c2YWp4T2N3eVc3RGJ3cUl2SURs?=
 =?utf-8?B?c0p3QlVBZFpGN0lVUlRlREwxS1Z6a2N6b1RIQkhDWkJFaFJJMm1veHdJeEJW?=
 =?utf-8?B?elFrK1YxNTA5OEFCL0lEeHZiaExXMWdUUlUramRZTi92UG5UT2d5Zi9EZm04?=
 =?utf-8?B?OWtQUGhCV1pwOWVYZnNqcCt5TnpvWkYzYTlsZFJsYVRTK1ZrRncyRFBrOTdh?=
 =?utf-8?B?eEp5dkRpVUF4N0hGaE0wSHJ1MXI2WWFHbHVzNjMrTWN1Z25sLzJJWVRRdUtM?=
 =?utf-8?B?ckJCVEZPZ1dZVzR0SFZ6bHg3TlJpMU0xZkUxalpISXhBUVNBd1BJRTlCdU9U?=
 =?utf-8?B?N1B4V25oT0dHcHFHc0E5Q3o1dVEweG5CVGR5WTFUYU5qdEM5ZEdhUzdnR1Zt?=
 =?utf-8?B?YW12cjlUelovVDNDU3NLUGtDMGlpcEpMZzUwbnZQQ1ZEZktzN2hqVWgrV0Nl?=
 =?utf-8?B?QzRFUUFZaW1jTVB6b2tnYzJ0MmpRWjdzMGRsV2FsMTM0bktyNlpFZktsQUZW?=
 =?utf-8?B?QnM0cXp3MkdsZGNTQzE3cVdRcC80ckxtbHhtOVhzZzdpMkR4N1Jsd2RXaXVG?=
 =?utf-8?B?UUszRksxL1JqNWI4MnhtMVZzRm44U2owc3VzVGhtRDdoQ2c0cnd6VGFjVEYy?=
 =?utf-8?B?ckozZ0ZubitmUHAxdlZ5czlvaE5OdG5JWEZ3Uit2b1czTldQUmVPYVJHbG5O?=
 =?utf-8?B?dG9Hb1RyUThjQ0NFRlZnSnN6Z21kVGt6Zjd6YzNUUExaNEp1WGdqb3pYTjAw?=
 =?utf-8?B?d2J3U2xiNVpONDh0VHBaVlhWK1hFYWJVeHJYSU13bXh6MmJxR2VlVmdCUEVZ?=
 =?utf-8?B?MUNOTnk4cGZrNmhOMmhwNHl4ajR0VkZQVWVTNWVvZ1RUYVZvck1JZ3pWQStL?=
 =?utf-8?B?dWFJdmE0bEJmN0pRak54bVNSRWFaRnRKeUxNYkQwd0Fpb0xXVko5cDI2bVph?=
 =?utf-8?B?YlRqL3FqRUlQL1dlRW1wWDhjdG5ibiszK1RJeEg4TzVURmpQWSs2cGtmcnUx?=
 =?utf-8?B?NmxKMnJSU2dyYUtJR1REcS9IUkVEOFpJckZySHMzRXVKYlQ1empvRXFhL1lw?=
 =?utf-8?B?NFZtenQ3TVZRVjlhUWc2bXJnWDBYeHVwb0pHeEVEd0lKaHpZREpqWmZWYitt?=
 =?utf-8?B?Wk5VZWUwOEhBZWtxMm42eEZDbHpsdEp4NnZCVE42MGdRb3JCWHBCNHMrQVMx?=
 =?utf-8?B?RmVlZTJiOWtaZU5wbGJxK0svRW1YSDd6bHA2d1hqaHRRaVFoSHpldVU5Ujly?=
 =?utf-8?B?L0RGNlZEZU40dXdkZVdoSnRMWWRPTm5hKzRzWnUwNFhlTlpiOVlBbUdnNHJH?=
 =?utf-8?B?ZE1EdlRYZE5BZFI5cE9xczRxZDQ0QVJWbG5rZFFPUSt1SCtjZjNBZzE0VW9r?=
 =?utf-8?B?ZHN3STRGYjhYM0NReFJ0Rmcyd2Rld1cvUVFET3hNbE5KZHViS0xBbGZUbHBq?=
 =?utf-8?Q?Fr9Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3EvVUJUamFRYmNCVVduMi9EMjEyLzFHUHY1RTdWWEt1M3Eyb0t2ZmtlVnBP?=
 =?utf-8?B?aGcrclRYVWs0Y1ByOUI4SlBKWTdVZEFnb29aTHY3RGUxYit6QUphWFpxM09X?=
 =?utf-8?B?cGZQcmx2RG9hbTBtSUZWWXNBbUk2OU1Qekcya2NISTNnVkg2Zlkyd0V2d2dY?=
 =?utf-8?B?YVk5K25YRlg1dHd4bFVSeWI0VG1UcDhvdXFUZWQ1ZDAxMUMvSGtWTS9QSzMy?=
 =?utf-8?B?MU4yNXVhNDdkRU1ENjZFU25BeGI0eDBEcFdBNE9QWlM4Z1ZpeDYvVG90WUJO?=
 =?utf-8?B?aW1rK2ZNZGVPN0svN1QyQXdMb2lOa1hDRGJFU3dvSlRmbEFxeWk0TVZtYW4x?=
 =?utf-8?B?U081OWxJa21XS3UxaURTVGFlOXVtby9xMUFDZFc1Skk5NDVGUG05VGIwQ09Y?=
 =?utf-8?B?SXBYNTVvZzVVbFhScWJpZ0d2UzB4N2pvRWx3elpwMzlMa2FBeDg4dXEvVW13?=
 =?utf-8?B?djBRRTV5T1pYalpDQ2F3Y1dFaklmV1pkSS8rRnVoSFNpRXhlb3FNTzhWQ1Fa?=
 =?utf-8?B?d2ViMURiZ3FjWC85aEdjM0h6US91SnV0cm9XZ3ZCVnlLcUdkK1FpZVVSMDhv?=
 =?utf-8?B?SDBMTU1mamVCWEFaYWdqcFpIRWx0NHVROXBacG5BTXFsZHlQSHNvNzg0U1FE?=
 =?utf-8?B?OTNPbWw1ejZWWXV2a3piMVNndllxSVJkUXdwNk54YmcrbXpjWTJIRzBWQ09o?=
 =?utf-8?B?bjdYMkpTQXEvRDFPd1R5QWZicWljSDhpcitjNy9LVkUzQXJKRGVCY2Jad0dN?=
 =?utf-8?B?d1dhOHE1TExNWWdxd0JoUUd0SDNxQ0lHNi9QWUlMVERBTTBkU3JZYndLT0c0?=
 =?utf-8?B?dWtvRUZVeWpJWll1TlhhRm8rRisrWjE5RHgwRkVuTGx6ckM5ckdsUGdYSG9v?=
 =?utf-8?B?SXowc09FUzI1ekhRRmtaTDBHdTdjNXgvM1M4TDFGYnp6V0wzZVFpbmJkWldH?=
 =?utf-8?B?K09vK01TZVBuanJtck1rRzlheGdUbC9zMHdaM0hrTDNPTEZ0dzJYdkpkTUs5?=
 =?utf-8?B?WG4renlDbDlSM2lvd1hiMkZCbUJpVlZYU0pNcFhJMld3R0ZHV2Z4dktKM1JT?=
 =?utf-8?B?M2NqcDZBUFlQQmYxVTNsN3NiYjVuVnpBckdBSFRpSVA2eWhMRWMyTXhTTnNW?=
 =?utf-8?B?SjRWNllyTVdpQ21mZkNvQnhXN0p1SHZYZW1hZUNBaGlLdnhYeVVUcWVEUVZP?=
 =?utf-8?B?SkhQaGZQdnFUNElHYkgyTkN0M1ZGR3NiNzJ4RTFIMnhuTlF0U24wWEI4K3Jo?=
 =?utf-8?B?NGtPclY0WGZVUlhtdHFuZXd3UEw0dkhDc3V4aXBxenhHYkpiR0dqQWF4QUJr?=
 =?utf-8?B?dGNwV3JvYjhRSHpiU1FNdFJHKzhCaGlRU29pVVp2cjN1Z2dLSlpTcTh0Nmpm?=
 =?utf-8?B?V2NPdFY5MXlodFZLajI0SG5KUE9aMURSZ1pLVTdGVm14RXZQcjVWS0Q4bDJv?=
 =?utf-8?B?b29SYUFuZFczQWFhTWV1L0ZJcU1zSGNndzhTY3h2d2o0R3lIbFBPUVZyNkZj?=
 =?utf-8?B?VnY1aGdnZmZOaldGdjhBWG5hRGNTM1lGVkdac3pXUk90UkV1TDFCWGg0eE5k?=
 =?utf-8?B?SmdTQjRsRERaQ3dsck1zdUFSd0ZrVzJncWhqbThuUlpEcE12VVNjazRCa25r?=
 =?utf-8?B?dXlXdkhkdCtwUEIwM1A3UFBQL2Nnc3krYjB4ZnZUbjVDSjdPTy96ZWE2akhz?=
 =?utf-8?B?a1dNcWNDNzJ6Mzk4VlVaNU40N0YxaHl3dzUyQWFUZGxXZ0tGUGlmaEhSU3dC?=
 =?utf-8?B?U3N3V1dSMUZ3MkxsdnZ4d2c2ZFVuMVBtL0R6QS8wOFlKY3QyUlBqYk5US0VW?=
 =?utf-8?B?djErY3ZlanB5R1FqR3ZYakZQRDMweGZBamZVZ25WN01PMW5QaEJrNDltNWtv?=
 =?utf-8?B?eEwzbEljZnNTYXg5cDkrYkpGY2dHYVY4MUxlR2dJSkZOUC9scmR1b1dDY2hY?=
 =?utf-8?B?dzJBVzJNN2xBcVd2VE5Vc3BiNzlEVlVvaHhOMCtwZTJSejQyRnZ5M2RMVWRU?=
 =?utf-8?B?MkJKbE4ySHp2djZJbXFnN1ZXMnYzS3RYb2c5akpncWdGZTRuTUVVMndiWlFk?=
 =?utf-8?B?WTBndnBYMUU5VXdwNnQvbHVWVG5CYVBRVll6bFlQZzEvVFJzMmdvNThIcHB5?=
 =?utf-8?B?YVlnMGVVdXB3enYvZ3JGQVVMSEFTNStOWlhMQzBXTkJPdmZNYXdsTjExZzYr?=
 =?utf-8?B?RFBGbEJNS1pGWnRSU2dwQXZzU2x3K0FBc0pjcWVyVHdEOVJCNDM1T254YmhD?=
 =?utf-8?B?dENXQXFaRnFnMGlIci91cUdNWGVxR2tEUnVTVFNXeEswaE5OU1VqL0U4alc2?=
 =?utf-8?B?WitmUDI2SnI3VmFSMlRZMnk2VldobTZHRUIvQmxFT0lNcmpPa1ZJdGJNbmts?=
 =?utf-8?Q?hbRPtWxs5Dz9sHk4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Opex7frgcKJEKW7ARrIykQCz4s6RRRe9fLq0ktWyW1Uf0G17J+gA+5tGqcUg7CPpm4ChWxuRdVxgbKCLF/zKSPuhvqhWQ3iY/NU5++v6tIUlqEn0orfMkTd0kJQwfq9Qjr+kXGEBZQZz31thmfGgmgPhnwRgrZhVOFWSXZduiAoCKlEuiw1iKkbT008+FupLqlmu0Vyi93Iz4LMuAdhn90CxY2jvtJXvkf9mfG5ZQrKKFRBkoC7N6vBiLuhnoSfVkXoMD8QvhwKuwrZwnOfV7/P8hAgIxFMRcFtAUYd3P2s1uIpB4s2kOBvwelHNKyWHL/LvRUrrcL/gY6b0XNf6RN5oCyUFtALPKL7NNki3mgJHGTv3E3uKDfXD/nBongiUj6+fikrxAEGwewb1lfP/K3ygtLNEC3ZRbn0OuVoAdLWomLvVjeSbXSVGD87KmazWOZapjQo3wmcNR+byvhVo2fxNiIdh8f/cYcQaQnbl0ZczDtpyrX6+xvA+vshNcBv25NxWWevz63Q5mw0a6fyJUF4DzUw8x7zS+qhMzV6Viq81rJfEwaRkuUh4QwwZXBRW1vJsYxEPYSRXDfnOCj5x97YN4k0y5gZVO9/4996Oxjo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b3501d-887b-43eb-047f-08de5e0c1798
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 01:25:16.3488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: es/PLE0BGb1wsKdAjwV8ln0C9aeeyYRiKCkz4sVeGUL/v/gooeOpregFnhHH6ix7jrpe36oPWovYD/FkAOyeEVUH0W3CMzsvliH6VMh21+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601280009
X-Proofpoint-ORIG-GUID: pBAVSCdn-Ya-CQVns43cHOe8QDDMY4ei
X-Proofpoint-GUID: pBAVSCdn-Ya-CQVns43cHOe8QDDMY4ei
X-Authority-Analysis: v=2.4 cv=IIcPywvG c=1 sm=1 tr=0 ts=69796581 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=UdYjARD8uERa6NymEwoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDAwOSBTYWx0ZWRfX0j8QgKtkulWy
 iTu86iQlx4hwISwcAWAh4p/8cv0KCP0Dp+H59QBuN5GgR7ixBbjGQuRsGHgI3TcZV35jLBFglHM
 L6sf/zxmw0hvnPwbj9riuyKhNcNzSGgKoipwptRvqSKEd6uzrkW5xkY4NXOFYFq3mGmcrMnAk67
 YlM4XLuG67gW43ECjJOJ8cdbf5ITup6zdHadpjWlzK4x8hwshQnlgm3gK+bC774Gl+Ktf0ow82M
 LIx3FsGhtsEAUR42OBEvdvzgxQhH4JlGuS15cep4G4EWFXmrEzhh8AF1RSBlgUnHOOXF+ydLueE
 3RbsU9dKLGJ+5ghIZv5u3DFEJ7KINE+eoDwIAKymjlVHje9epa3F5jyH+NjDCVd4D5msmU3jI9Y
 tQ6wwJtkO7SopzwJtEw0B3cr11UFbmgoQbPaBo1ddbpQBWKbyn6YIKYxHiNQgfMOioD2eU/s5LH
 4xcqgv/biimzwTh7dwQ==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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

nit: Capitalize AMD on commit subject line?

On 11/18/25 5:15 AM, Sairaj Kodilkar wrote:
> Update the vendor capability structure to have `struct iommu_hw_info_amd`.
> AMD vIOMMU can use this to determine hardware features supported by the
> host IOMMU.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>  include/system/host_iommu_device.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
> index ab849a4a82d5..cb1745b97a09 100644
> --- a/include/system/host_iommu_device.h
> +++ b/include/system/host_iommu_device.h
> @@ -20,6 +20,7 @@
>  typedef union VendorCaps {
>      struct iommu_hw_info_vtd vtd;
>      struct iommu_hw_info_arm_smmuv3 smmuv3;
> +    struct iommu_hw_info_amd amd;
>  } VendorCaps;
>  
>  /**


