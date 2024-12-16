Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2194E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAgI-0005ll-7j; Mon, 16 Dec 2024 07:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNAgD-0005dz-P2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:58:34 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNAgB-0005ff-CD
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:58:33 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9MrkJ020262;
 Mon, 16 Dec 2024 12:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=I6/+nJ0N0Xf9Ui8R1OblfIotvnGZgChGog4bzqHQBuk=; b=
 oRgu95ecMJ1phmxAprM2bDX5EoT1kKdCwHC58Ft6jbfWXrsF+2zpZvnFOxzCkNMx
 jvxcXww5HPzLTJMh9Up7LKHTgSB3bAdbnKe2kQI87iNvTImm1EoE2pBOw7BuZSoX
 IvKhsmZl/UGMHOW83OyG3B1TgsjsG4Vp72IBnlEqD91UR0rIa0U9U5B81H9y3diA
 fFHdAFc31O6gGpYRmYfwrK+27tCyr9NERaXKwz3Kl3yWF+5OpYbAQ8c1HGzTWEt4
 HrqxP4l0ygnQD8jxspXsOiq6h9B+N5Mui0ZfCyka+lTET5umPRGm6EJ3pv6YwCQY
 9A26mIc1VFUDnC8fAD9jwQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h1w9b3pr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:58:29 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BGAxH8c032785; Mon, 16 Dec 2024 12:58:28 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0fd87jj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:58:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAXRBwJbiL6o5L56GlWRHOrf1U3qeDTs/l5hHcuHWetngK6/LMyVDJfppoLIgMPSbmpECirsJtfPtEcZRyS0j+RWUmpvFcZvE7j/FpbYtzsSDb8dk9JqTNIwG8giixa3nQ4eWYLqP6kmijvmjC9DMzym+3o3C3kZ/LaVLfcBlG7XS8J/PevyMxfCLb3xy/VKRWk1tHrFJUo79af8ow5fstSoUaS5VaE2Rccr6lWdvipDQJJ7V8VqPZl0bdOBx2n9rGAve/pWnaogUYF5aJqH/+v/f47ox4Rkx8oeKQw32qDhF353yJozL2N2/u3/7PGp62eTw6lYBl33LLT8UO7s8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6/+nJ0N0Xf9Ui8R1OblfIotvnGZgChGog4bzqHQBuk=;
 b=Kb4IGyxRe+1GF+rnEgCODjoTcr3hHgOzbWnsD4ySfhCHF5vKoX9eJTr00pntKVO2doyhX4ixd4fxfxr4qTl4OWfeipwJXJpco8KHxUEOhzDFnLosz/85bXFR+dRDPE1AdptcS+u+jtbZ9c0G79i1hT24Lnvxsedr8UatOBRn9OyK3jkqlXfG0KEGagXlQG5h6Skf2ZqwsStGM+uaGkW/8Oo0OOFFqdRuKgPGl0+67b2lpaoWXhBmEeTGrJRtbUtsPvu4pn7EeJhrZn1KVrvM/fuVEFPcVmOcHZlxIHgkKocuwCv3EIizvDMT2ZHV9rHt5j98VlNRiUEr19AwAdduuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6/+nJ0N0Xf9Ui8R1OblfIotvnGZgChGog4bzqHQBuk=;
 b=OExctwVFvNvMhhnQWs6hAxwMO8dUiYMQsXVCr5mzQWX65kKMM7ugI+f/l6JlppVmHyD7qDBQ277dupzYuYcDa+zzmCjNypKm99/4yeEeVexHWEK8YKv2HDcql7SeujGLBaXZxvui4gdEGQ/jPeM4KmVEQ7OmR7r/uV363MgtISM=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by MW6PR10MB7687.namprd10.prod.outlook.com (2603:10b6:303:244::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 12:58:26 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 12:58:26 +0000
Message-ID: <63d9ae9e-3d4d-49bf-95f3-fbb4f8335608@oracle.com>
Date: Mon, 16 Dec 2024 12:58:17 +0000
Subject: Re: [PATCH 6/9] vfio/migration: Rename
 vfio_devices_all_dirty_tracking()
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-7-avihaih@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20241216094638.26406-7-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0235.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::31) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|MW6PR10MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe6cf30-6fae-48b4-a9a3-08dd1dd15482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFpNVG95emttdDdpQ1FQaUYreFBkTFFsQ0NWRndnMlVHdjhIdCsrbmFSanUw?=
 =?utf-8?B?eFFEV0dUdkh5Z3YxOUZyd1paZTl4dGxkWVB4cXIrOU9yRmRtRnhxaXQ5RlVI?=
 =?utf-8?B?YU9OZ3ZBMWVJN2VHRVdXTERMSUR2bTFqcUpZWmNQWEpIR29TVWtwRHlTamRl?=
 =?utf-8?B?dnhxNmoxamJNT0NwT2tIcEM2SjlGNXM0UTFjV0ZxeUcvWnNOL1NpSFJqRzNy?=
 =?utf-8?B?WXZYZTczUk1tQUpaTnVaY2o3U3UzU1NUSGVCKzVJUjNzamdWS3dqQlllZnd6?=
 =?utf-8?B?cVdvRWVuRTJsQVNhamNBNndiR3cyYXNUQ2xRZ3lKRUM0bTZUZUc0Z3U0Q1Bt?=
 =?utf-8?B?RVUzZ092bnh3Y0xZUFRxbDlZalQrQ2JpM3VydnJITnlvVm4zU1RiNHFNYzdk?=
 =?utf-8?B?ay9KNmlqQWRzUFhRbDNjZndXSlRIa3RldkhiU0laNFF4b3JJUk9yNFRSOWdu?=
 =?utf-8?B?dC9aaWxYb04vSGU2MDF5L0ptRkl0K0l4SGNCUkFuOWpBU0I2Y0pES05Jd003?=
 =?utf-8?B?dDVlY2poczUvZjY1N3NkWnBzQ0M5Y2czdGtpNUpkeWZLd2k3Nk1yZHhRMGNZ?=
 =?utf-8?B?VU9vWG9ZOXJTcFdBZnVIUEM1ekpVYXRac0syYWsya0Fqd0Rza3FFbExjN1Fi?=
 =?utf-8?B?ek04OXhmRXh3NXB2eWRRZkRTaE1PQzBCV2ZHbk14TEVWL0dYZXJEL3BDd3hD?=
 =?utf-8?B?TmMzbndtUmg5UWpXUXFGMDErL1h3b2p6eUdpV2hIbmVPZlpEc1RwaG9zUjRZ?=
 =?utf-8?B?eEpIRFNSeWJDMm1zUlhTOGcwaDB6d2NZRDRIMjlJb01UWlpEckI0M3dXK25l?=
 =?utf-8?B?SzljZnBrS2JUaFJTVk1DUEIzV3dkY3dBbGNIcDE3ZW1sTE9xY3VwNTVYaWNQ?=
 =?utf-8?B?cnc5UFYzYm5pU0dQbXlNMlUxbjcvUmh1enJEdEJGR3ZFUEVxNnlYeUZaMEsr?=
 =?utf-8?B?QlNlblZrSmVQTWpFYWRCeUhXMVRLMkxodnNweEI1ZTh6Q0dNNCtGamo3VUdy?=
 =?utf-8?B?R2JVYk5rd0phRTF0dE45cG5sNzBJU0VhQVpHdTV2TThBVGFueVJkcUdaMExQ?=
 =?utf-8?B?aDFUbkQwNElpdzBxZXdYWG1CN0NWUFhIdndHdmErQlFCeG9tblFvY2pxSE5C?=
 =?utf-8?B?K0d3K2dOak9BNCtjWXAxQUFXVDJheGN3aGVqWFh0SDdiNUNZRjlLS1NPZFNM?=
 =?utf-8?B?RFE1T0VYYTIyczBUcjE3eWdRL25ROXRLVXJFUGVNNGhSQlBoTVpWbHJxdDdT?=
 =?utf-8?B?dzNHd2tpaXdPRVRnUy8wNFZoOHpteEZkTHFJQjc3ZDc0anhTaUMya3BFdmdT?=
 =?utf-8?B?dndiRlY1dFZHbnN1SlBHdm96dFg0SFpoVnpnNFlxWVdZNVR2OHIrSTdhQ3p3?=
 =?utf-8?B?UitBdFlNV3I1QUIyQlVoTnorbXh2L3MwK1FwV05IeWU4V0h4clR1QlBrU1lW?=
 =?utf-8?B?TnBma2NjRHBXaFNHcXNRcjl0SFVlVU92R0JWbExwUnVmRjQrQ2RIWVY3QlRx?=
 =?utf-8?B?MjA0SDFBRnFaM2dqa0F1amZFMzMramF3T0E5REs0eldHQzZWdzNyRHBseENz?=
 =?utf-8?B?U0l4Ty9YK0diM0I2ekZ0eEZORDUvR1hwN1VJUU55V3BPTTNqMm1hNjNpT04z?=
 =?utf-8?B?bUt4aVdIWUNISmVEaU84U0l0WFlJRnZPYmo1WlRWM3NRU2VJR1c4T3BSR1Js?=
 =?utf-8?B?ZW4zRFdKN202V05SaW9KamJZcGVMc1pGOGVmc3dnMjZuREk0KzBiNXFCZWdG?=
 =?utf-8?B?cERycEZOcm9uUk50LzN3NXhpb3J2Vytsc0MxZ2ZUM0gzL2wwRHVKQ3Nuak56?=
 =?utf-8?B?Z1M4ZU5rVWJRKzFZbUFUWlZkcHMydXZtSnVwTW1ONFhRV3JIUjBvTktpL0JU?=
 =?utf-8?Q?9lUw2hUuXxupt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUljVHRvK1I2dW5aL1pOOW5xVWEyZDNIZEFDVmMxcmdnVVBFQjQ0VDdvMUJT?=
 =?utf-8?B?alVUT1hrcTRFc3BidWU3V0dGTDMvNFRrWlh1U1BGWDFKRkd0L1BSKzBBN1B4?=
 =?utf-8?B?NEtTRlk4bUlFdjB2aWNDR3IvUUM2clRIMFJOTDVlbEVWTnhsVVhMcHNKV0ZT?=
 =?utf-8?B?Wis4eXJnTSttckhKMlg5YVVWWjMxWGNjVlhFUlRYV1lZbDlqVXloM2F3eFFO?=
 =?utf-8?B?Wm02eVpXdEhIamkxSW94am51ckNFQUFEbVJVUWUycjdNNENMRWxZeVBObTlB?=
 =?utf-8?B?WlhQNFVhb1MxaWZkbExhYkw0dVd3cm1oNVRBYmQ2NFBnWmFLQXlKYk9wdk92?=
 =?utf-8?B?VHBYMTZQRWdYdk5HNkpobGJPeW1FMTFYNTJtRTJ1bDFzWkFJa1RXby9KQUNB?=
 =?utf-8?B?QnlsWlhRdTdBOHpueHVtcUZKT0c4N3Y4ZXJuRFpIMG96WERkWENNYUJkTTM1?=
 =?utf-8?B?ZEVCc0R2UytZakZaVzViRDhseWpTTUEzSnRkMitDSEhBVy9BcWtIdjN0MkQ1?=
 =?utf-8?B?ajViZ3NDemtOV0dxeldoRnVKNjdQR1lVdERlNWdvTXBndmhhUjE0WCtmd2Vl?=
 =?utf-8?B?dVBpaklnTUsvc0gyM1lDVzVZK00wTThteEIwZ2dhUXJ0cWErTHJvcTRXMVlR?=
 =?utf-8?B?MVNRZGJ6ckI3eGVwVmMrZjBDcGV4VjZtRW9yMmh4eXFyZ1JBcVh0aVp5R1JP?=
 =?utf-8?B?WjIzYW9oeDM2RUcreU40aGw4eFZBSWZPS0pyTmovaml1Yk9HcmREaGR2OGNS?=
 =?utf-8?B?TUNDdTJkR21seEpGRC9qQlUzbUhsSERmd05LNnhPMGFZbEttMXVib25tam9K?=
 =?utf-8?B?Q2NSRWhKV05zQjVzL3U0aFpreDNVejZiZDF3V3pNak9LeGtUUUFJVFIrVytn?=
 =?utf-8?B?TVlIWmV0dFJhMURYV044SUU4UFZuTVFna2FhYldwWE1KaUgvbmRwdzVDWnpS?=
 =?utf-8?B?OUpxb09CNlp5WnhsbkJlcG81OXdZUVRxOVVIN1FqT2U5K0hBZTk2T1VZdnli?=
 =?utf-8?B?ZXluaEpxY3Z2N1JGUlhJYjJFWXR3b3doRGdWbGpIZENacHpwNnBsMWZ0YUg1?=
 =?utf-8?B?Ymp2T2pRUDFWR3N1Uld6NUsxU2NFMm15TEVwWlpmdW9mNzUyenhXOVk5ZjdM?=
 =?utf-8?B?L0U3STA3VngvU0ZLeVNiUHhCWm5FR1o3OFE1bnRXUWt3WkFraFY4eGNoc3E4?=
 =?utf-8?B?UVhkMGgvRndzT3ZTcnlKMGo1dkJETmdjVnpTM1lyN2hla3NrcENoNFo1c3U3?=
 =?utf-8?B?U3hwSFdlNkwveGZsaWFVS2RxaXZrdEVhSVYrcjRnUHI3dE5RMU5Jb1d1TGll?=
 =?utf-8?B?WnlINWh3cW9VSGUxZnlCaDBiWWRjcXFJOTVTb3dGNEluNll0Z3hyNGlPQmE1?=
 =?utf-8?B?Wjk0OE45OWRBcmRiRVA4SjFncnFUV3JFVUQ4NGpUR0JDbXpmNkxGZkRqRml6?=
 =?utf-8?B?aTFhN1RsNno4ZXliM2FEaVhFczFNMm9KZklrblZ3Ty9DSmRNbWtHbUN6UW1v?=
 =?utf-8?B?RlBORUJablNXY2lMZWQrcFZTWGNZK1dmUFpBS1l5eWNIYUh2TXZYUmxiUExW?=
 =?utf-8?B?WG9vc21wZmd1NTZUVVJKMlpyRDFMaEpKdWVyU0V0OEw1QzRYQmxUV3BzWnhw?=
 =?utf-8?B?MnViWE56MTZnUTRubUhCUE9iRVMwY0ZIUjFVc2lReHpibGdPREdHVUhKeWR1?=
 =?utf-8?B?SndnNEhBVnNBeW5MZGUyQnloMlpjdlRQdnNZZkVKTEVPcUZSMll1aU0wY1Zu?=
 =?utf-8?B?QXd2WTYra29KdkxHN2d3Yk40emxJZ1ZobmhrOEE3TUNPT1VySVZGdGRNSXB2?=
 =?utf-8?B?WE5HMG5VYTBTWlhDMmZhV2ZEcjJYNHhUNGgrdmdqTWhYdG56blFGSWcyUVpy?=
 =?utf-8?B?M0pENkhRN05PbDBQSnFxdG9DdDNuZ3BKeTZQaE9JVjFpSTk0NGduMEc2NWVB?=
 =?utf-8?B?NThqczZFbjBwOGRSSklERCtyckpEbDZ1NEt5ZTRZVy9HaUcxYjg3dzJ2SEJk?=
 =?utf-8?B?V3ZMZVNVOXV0WFBoOEhOdG8xRmlUaWZkb21waWhxNVBpTmc1dTAxczQwQTlB?=
 =?utf-8?B?VUFVZFVVQWFHTTBpckxhYUU3elZlTGhVbkFxcm1tM1lxS0hxa1JhVlVjcmla?=
 =?utf-8?B?TWhZZXBVUTZwU0ZybU9CYWRaRHY2TUQzM1MyUFd2VmZKUUJaUzhKM2txbFM0?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WQSyTfCw/W5tX+RjLBUyWlRtEWwSC6274v8d3mMCr1sai+byndK846H67UmuYXg45w8PZA5JnlqtiSTNZlm9W2l9YYJxZbB/poloKsiBnu8JvZ+FahfoSMGlZTWysno49MRadPEBtVGtlKnOnU5zPwiDVbnWSEvsuSRUuL/gvjYWKKdZLsiTRet4ghKZ26SqpbkvlpMfw69q3+LE9mclRDbRXC7NwzUMgFUWKtp8Y8wrm0n27JW5EcjMTXHuNbGMSxI+gN8B2KQBqPxwr9Xdf5uphlKsXOYkXk6ycTWKInpmV74E7A6vBUKg/K9fC+8UrPh28HKDuboQuIrNTJw3oKjbhiAtN3r/lMhA/cY2QcGyXlX8GykbtZMavVLusIcRWjTafMZZpsTgMZDo1Gz3eJcff+nMuOkK7qOR2DVmMbQj1MwgA9Mv+dediq2xJtmVXvWLEf93kgE1v7y6Sks5PLld2Tk5HVJfF28IH2mBYYlwMI5/VGKMpO0E7M6tmJ4jEYcNI5sDwopoGtBI08rKxfEMrgazP+cq6STlZlF2PdFPnSDwtcxELK3OjPajHbpVa80RshQ5S3bz+PE+DKomgJE1oSWHies9rNAp9vpDSGU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe6cf30-6fae-48b4-a9a3-08dd1dd15482
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 12:58:26.2092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmUzYhyDwplxKUlMN2EfLYvJyFt5hWAtjhxwF2KcVyYQMeGNis8ISa0qppkkeoJmNvjzwmC9bOuHmkJmISuoFrOkIR1UVCMnV5IJvJhM6ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_04,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160110
X-Proofpoint-GUID: t8aXYf68brvyEhliNvkkXyP6sNjNNPUs
X-Proofpoint-ORIG-GUID: t8aXYf68brvyEhliNvkkXyP6sNjNNPUs
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.13,
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

On 16/12/2024 09:46, Avihai Horon wrote:
> vfio_devices_all_dirty_tracking() is used to check if dirty page log
> sync is needed. However, besides checking the dirty page tracking
> status, it also checks the pre_copy_dirty_page_tracking flag.
> 
> Rename it to vfio_devices_log_sync_needed() which reflects its purpose
> more accurately and makes the code clearer as there are already several
> helpers with similar names.
> 
Yes! :)

> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 6e4654218a..dd8c5c52b5 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -195,7 +195,7 @@ bool vfio_devices_all_dirty_tracking_started(
>             bcontainer->dirty_pages_started;
>  }
>  
> -static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
> +static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
>  {
>      VFIODevice *vbasedev;
>  
> @@ -1368,7 +1368,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>          return;
>      }
>  
> -    if (vfio_devices_all_dirty_tracking(bcontainer)) {
> +    if (vfio_log_sync_needed(bcontainer)) {
>          ret = vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
>          if (ret) {
>              error_report_err(local_err);


