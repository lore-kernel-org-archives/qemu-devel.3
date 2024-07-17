Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86D4C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU14V-0003pL-Of; Wed, 17 Jul 2024 05:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU14T-0003oR-FX
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:35:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU14E-0003M7-E3
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 05:35:36 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H9UjtQ005693;
 Wed, 17 Jul 2024 09:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=gHfvCje5nRHgAM2F50hjQPVWPod9iQOB2yoN6XJKc/0=; b=
 cE7Aq5Vqq9y/N1vu1lPoJalw/dcD1ruk9NELwT3qGM9jqyR+7NkbP9qbnP7dNYJT
 LpcxmgteSxBWLCY60NwWhYueYnHqxXRk4uhklW0ZNXe5QZQjV3DMYSRG7G4ranno
 HqKSGl4zDTcP2OsKNMpg5SX+mNYXyF3Zln5KArBCs6bg2SbPLXDhP7pPYmHmg22P
 Qv3XPJJ7fwQ1mm8H/OJ+B+3U6rrfxL3y8Ofuk0A6KNGjknOIyFuVgQcXSIOnJ8OW
 TTQG992AeTio7gc5x0ppiv6Dy8pl49Gj3prlfhy+O6zTipZWsEKwK3qAUq98DaMc
 ox3DVnxSbZoYyXz6IAoarQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ebcp808x-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 09:35:17 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46H8Ri8I021599; Wed, 17 Jul 2024 09:20:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwet21dx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 09:20:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlFxh43T7DwhTOVe+Fdgw+1MJ0T7zkMZVClFiwH5t7k4BlPNXoYNZ5Pp0ZF78u/bo9/XeTuk3uEOnoISYeSxtyzYUK/hZP0UPJTcN+NBQXTsFQhEVmXgGN7UMOqx9JLUdwEoF0bKtYNmT7NUcvoc53TwsX5/CLJ+z96U4/gJRDkRpFtaIOH7jUOnP92qVpzIq74eYGxlN/Lf+WBwxKOATakBPZt5TNXyAV3nEWj/S9Zo+TWLZ8apLvO8xK7ANqI9vJDLHbfpoR+Gxx2WMYBrX9OMSw6DjApN0ZLTYtaIl9MXbCKSJwcu9RBoPSRW9rSd40MrV6kZCsjF3jZA7GCYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHfvCje5nRHgAM2F50hjQPVWPod9iQOB2yoN6XJKc/0=;
 b=rw7KCOTGmpkft5EhO0Td3PCg3A1KZa9zKy58ByC5qq9S4ch/uAGven28lNSK9Xqi8Xo+2DhCtrtePzrJyMG30+fuEbH6qHZYHJwX3WzeAgAe97/vb4xFy0yS4xT1OficeYp9KGs5xaGUGkiU9zH/1F+RGI/M3ZYsHLYGW2DaPrR9NEXfziV04HJtUeCMn2s3Ph0Cqqf8jSy+WM7brNUzVk1Rilk2ACq2q1uqlM+9dIA6P1FfMLDPwmbknEN7iK5FZtGnZU/6nVGUX4vNk00Xy2rqfoShsylwzCiI2GwX68LwSTFXgiatKj3lbtS4U6BHNkIeFlIwKJd3ZlGlfpet3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHfvCje5nRHgAM2F50hjQPVWPod9iQOB2yoN6XJKc/0=;
 b=ZNAJonLaFbljgaVoy9JvD/8PtiPwgSKEvUauKjtVmpt7qharbsl1K3Kxz6vox6WIImCO3kXzfY39N63MQHq2xjY7PqCGUoCtkr6llV4WSing+INuUgZFfBWDFpNp6wFkC4GChU6n7F3oXMZK9GnjW3VTSBeTWk1b59m+n8jW2EU=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SN7PR10MB7075.namprd10.prod.outlook.com (2603:10b6:806:34f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Wed, 17 Jul
 2024 09:20:11 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Wed, 17 Jul 2024
 09:20:11 +0000
Message-ID: <da65c43a-ddca-4d47-bfbf-274e8062c56b@oracle.com>
Date: Wed, 17 Jul 2024 10:20:06 +0100
Subject: Re: [PATCH v4 11/12] vfio/migration: Don't block migration device
 dirty tracking is unsupported
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-12-joao.m.martins@oracle.com>
 <SJ0PR11MB674456F8871EAC781732D0CD92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB674456F8871EAC781732D0CD92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0045.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::14) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SN7PR10MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 873c76b0-8dc3-4295-9ac4-08dca641a8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEM0cGx4NEVqT3lHVHgwWHdicFJ6d285VkJmV3BqaUNMUE5GR0F4T3YwZW82?=
 =?utf-8?B?aldyQ0VBYXNuRHdMMThGdWlUNmozTHJEUk1wOE9BVUlSb1Z3TjZ6M2VyK3hC?=
 =?utf-8?B?YkpSeUFGTExyQldVam5tRHhLelF6bmdtUStYdFYzOUdCZGlVOFNaVWJ4NGhB?=
 =?utf-8?B?MUF6RERCYlRONE9UUXdvZjFXblhmV0RMVVVaRnl5S01GbW92YklST0lxZHly?=
 =?utf-8?B?SnlCd2duOHpxV3RNWW13dk05M0JGbXQ1a0ROTnk4UmR0RW5RdW54dHRsc2tS?=
 =?utf-8?B?MThvek1scCtKamgxcTBwTkdxd09JdFMzblV2a1F0TVIzeDVtMUlPR1FmdDJi?=
 =?utf-8?B?RllMajR4UzFPTmlabGtTQk9zVmpVd0J1QzhpbkRFWXh1S1Budnh3SkplRjlM?=
 =?utf-8?B?VEo2cFpIZmJyOUxkYncrOWQ0N0hBK1hGT202Q1hWUUl5SHpvelUxclpQSUg0?=
 =?utf-8?B?MlU4MlJLNk5OTkRaSW5DZUhyT01kUEgxcHFvOHUraktkNXlMbnY2Vkdoem51?=
 =?utf-8?B?ZG1tWC9Yd3hPRXl6Z2w3bjNUcmpVMVdCd3AzWUpuQjZFM0hoandRSkhtOWVk?=
 =?utf-8?B?eHAwc2VzNHl1OUZCZnNUa0lUQ3VqcWwyTHVzSXlBWjd2MDZvS3dVRjJCNHph?=
 =?utf-8?B?UGJtM3RXRU9KV0diaXNSM2xaZWpPaVNYeGY3dTZYU3ZHVGlzbTVhbGt6YkI0?=
 =?utf-8?B?SGlmcTZtVDF4ajZrWmVFSlZYejN3Mk4zcFQzRTJUZEk3T0NlY3JJQml2Q2N2?=
 =?utf-8?B?YStXQTRqRGVSUlNTNmRMQVhvT1RhVk5CRXpXRndYRFdFdlpDRjR5UVY1bjJY?=
 =?utf-8?B?bVZualJjSTRTcGNlamNCTTZZU1pKTHhyeFo4eFphd0JQME5rRnFGWGxOdW9B?=
 =?utf-8?B?VUJIRVVyOENLTDNKUDF2WnNyTzZlMUVEVDQwRktZNU9leS9XYVpQdk9rdVda?=
 =?utf-8?B?WGEvOUovMzZ6NzBKZC9vVnB1cWRtcTk4RUQxWTBGbGgzTkQzV2VVNmFOZktJ?=
 =?utf-8?B?YldyQUkyblFmcC80TDBJWVNnc3k2M2VUbXpiQ1hEaFYza1R0MXpoMWR6dXk5?=
 =?utf-8?B?NUNoNk5IdzYya0RXeS9jSWZZNnlZbCt2Mkh5YWUrQVppK2RFclFyZ3lpMXZr?=
 =?utf-8?B?WU1mYjlaWjNzWEM3ZG9ZWmdwVG45aDlwMUQxRXYxOHEvZ0NsY09wc25JZ1NC?=
 =?utf-8?B?QnEwMHAxZ3hRcE1kMXFpT0JZcENLY1lIQ2tBVUJCWFNXaXRQRU12bCtuQ0hP?=
 =?utf-8?B?NzAwVkVvNEdGaGdsV056QkhVc0E4dGlGSUEwTmJ0S1hkcUlSdVlIY3lsQm5Q?=
 =?utf-8?B?aGFIMHcweVMrWjFXbUdvSURDUFhpbkVnd21BQkFJYW92WFh2OWhtV3JzUk1M?=
 =?utf-8?B?MUtuaGtrNkVOQzMxcnRnNU9DblA5WEpOeC9UOWNxS0NjU3d3TkdMMkIyZXBQ?=
 =?utf-8?B?K2FWOWlGSHJQeE1NbHh3NnkzQ2xQMXN5OFFUV0ZMTjJISjlaYXRaTTFPREJs?=
 =?utf-8?B?Mi82amhDYWlHV2hvTXZtQkFqM1NXeXB4YjhGRmZLRzZ6MDFNb1ltU3JPb1VO?=
 =?utf-8?B?RnFvNG9pV0U3dkJ6bnQxcGorVGlCeHlRQ0MrbVFKTzI2b2dSQVM5U1M5d2xw?=
 =?utf-8?B?OXo0Z3dLWnlpbjF2cWU2Z251Ui9iT3VwM3p6K2VqUkJRU1MzNmtnVzd6TXdQ?=
 =?utf-8?B?MDdXclduZWlNRm5CUUZQUlVDVW1xNEdDQk9hNkZLQkFkSUdoTE5SZHFqZnlJ?=
 =?utf-8?B?NWcwMXhxYTlmelhvU0dzQ2lnQWJJSEZ1eVhMQmNxU3FMZDNqZEFBd2liRFU3?=
 =?utf-8?B?UDF1Z0xTNTJLc0NlRVJnQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Lzl0Vkh1ZlRrT1JjU1ZwWjlBajVQWnZzQjdmUU5xdnVKUVZ4Wkd6N3p0dWlJ?=
 =?utf-8?B?bkV0aDBwQ3FVL0tIYS9OR244ZVNYTlF4bDBUOXR5SHU0VmRodUVrU3EvOVI0?=
 =?utf-8?B?aWFRWXdNQUhFeEdmYThVcUxTYzc5L1RLYTdTeEsvSjYveGR0a3RVVno0eGJy?=
 =?utf-8?B?V0dXem5MWlB1cTBoS1YzUzkzN1Roa1k2eWpLVzU0NkFWRk85eTRVWHczMjhy?=
 =?utf-8?B?ZXVHVUpnTnA0ZjRZVkFGbGVJb1BFLy84blR3YU1FVUs0Y0NzMzc4UERlTUZ3?=
 =?utf-8?B?YU1URU5SWXFaWW5Qc0tEK2IrZG45YjRpbUwyankvdkxTUlM3TWt0Q1BURlVp?=
 =?utf-8?B?L0NxdUozZGhmZGdiMDZCTzNQa1pyTUx2M3pmZlBGVEpBTEdXNWFTTENSd1lO?=
 =?utf-8?B?THlhZ29QenhrUDd3bEZodzJDWThWQWtnbHp4Z3pnWm5KOFRwVXNNQ3h0Mlha?=
 =?utf-8?B?ZUd2TkEvVGYvQXBsaTZaTmxFZ0plZWtkTHhtUDQ0WlEweVN3dlhHZ2dKdktY?=
 =?utf-8?B?dUJGTE5YTWZzRk5lK2JJdXNwRlEvRFpQcDh6dC96TWdmRUd6cUp2ZTlRaWkr?=
 =?utf-8?B?d3IyOFpMLzhDZEh3WTlrdFhwaUxmNlhrK2czcDB0Y3Q2QUNjUWFkb0d5SnFr?=
 =?utf-8?B?T0xudnV5OEZCc3dDQWlkeExtNzcrcTJjNjBVWTIwT2xXVktwUTRFQTFkZENH?=
 =?utf-8?B?SERrYy9UNG8ycEpiRGZpYXJzMUYvOWprWCtvVGV3eFhNSTRxNFdnN3ZpdXhW?=
 =?utf-8?B?SWtMWndSeXhxWmo2V0lKUThNMXRtdmFRbUp2Nk4zSEpXOC9wSUQ2bTdTZ2F0?=
 =?utf-8?B?bElScjBnZEgyakF1R1JMcGNabkNMeEQ1VjN4Mk90OHNKakpLTTVFNUZpNG84?=
 =?utf-8?B?UHpQb0tKa21DMHBEemttWFk0eHpoeFZwOEdFZWphc0JxN0JLaHZlck1zUjZE?=
 =?utf-8?B?S24reGZiL3RzaEcwNlAxZ3pnMVYxUEJIMkdGbXc4NFhjTUxMUnJQaE83VUJp?=
 =?utf-8?B?K2h6ZG9nRlZTUTRtWjloL2FKZkNTMks0bVVKbklEMkk0TmFNTDNna2o5RWl3?=
 =?utf-8?B?bzEwcUNPYXhBanhWV0JxOVdaM0RQdjhnYVlzckRaaDZzQTFUNEhWczFjTy9N?=
 =?utf-8?B?TnkvV2JhMWMrMml3MnZSVjZ4VjA5dDRMNDBpeFFwMEk0eEdWcnR5RUU0SlpI?=
 =?utf-8?B?NFJmNWhWZWJQaXZtUlNGd0llajNSeENLNW9uZ1R6VHJLV0JtNm9heEthNXl6?=
 =?utf-8?B?aUdTUlRMMWZSRXB1U3d5NFdZcWMya2wycW1hdUlhZGJheitFSFUvaEdyOHBz?=
 =?utf-8?B?MFBYNmZjeE5xQzlJM1poZEhqN1VvYjlwbnFlRkFiZWZmR1FQdEowblVnSDJr?=
 =?utf-8?B?alI5UlF0T241dGZxdHpEdjllL05YMGpsQ3RIUzV3dDN6YXRRMmI1YnJMSVVW?=
 =?utf-8?B?ZVZ4S0k5VWtndEZ4NWdBMFA4QXUzYUt2Z0NuUHpIS0p4VlF2NVVoZlZSRDdj?=
 =?utf-8?B?TExUWmNQMFBqd2t3NitBM21JUkFtQXRZRWZVM09uSjdGaytDbWN4eUF3VXlN?=
 =?utf-8?B?MlNDQXBsM3NTbFlDcU90eStVblFFZThmR0RwQ09tbGgwRTZRcEp1VCtmN24w?=
 =?utf-8?B?S3BYTEF0LzFneW9OVmFpdXUzQlJkQUJmTFd5ZkhIK3RQRXFObWpKbG42ZDFi?=
 =?utf-8?B?VkFVT0kxdnpjRFp6ZTB1a3U0b2lKRU9lcUlCVEZSc3J0cEtMWEc3c0p1Y2Yv?=
 =?utf-8?B?ZjEyM3pWKzd6ZDdYQldNb3FEbWI2b2hvbUJndW5rLzZLYTg5NzZ0LytscGF3?=
 =?utf-8?B?Yk54a0IxYmxCVWx4THozSEdGYWNTREdUNE5VNGdXbUFnQkRObkFlRmJQVzNt?=
 =?utf-8?B?dEdEMVk4Ylh0b0R3MGprSTRDcUhtMTBpSm9iU2hZNWdiMHVHckhZZEFMUDRx?=
 =?utf-8?B?KzJ3eDBESms2YjZZdE9ocXhXc2Q1akpQMXVLTmNyTFNsSG9EY2F0aEpBaWpy?=
 =?utf-8?B?YmFneEU5L0U4eTViTmJPN2dIRFhSLy9xQXA4STE4WE93VjhWb3duT3lQTklG?=
 =?utf-8?B?QlN4cm5OcmMyaUQyMzhKMUl3Z1RMcVg0Vi9Cd0lmVUQ3YllGR1FRRjRRMEVH?=
 =?utf-8?B?VnJ6L1Q5cGpIOE5rV0dBdFJtbHpEbWE1NlJ1d21ybW9LTGI5UjVpUG80VlND?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yX+uIqIBijaYUSLEhLUdz4UdZ4R0m7FS+C8x52zoyg6SfodLBXtP6h7C7QTDctxYgX+AGLIjqjlBxCLZ9dgru7abrEl9ioLJhg5PWpYAMJuyKkPnMc5uQrl/sN8HMlEz3HbR2rcOHlQNqNc51a6IXgPFEXx/Z0PpEWOwbWD5gWQlX+1NFBCbW79/eiaO8fs1iUiCOLwXjNgo1YcvvPmOUJ5/na6p6FrSbrkhojY8bSVVKIz2+LD3tuHGUD4vEA0MJD9lzdq4q1Wcg1tu99WORJ1ko3i1dwRIg/5ICQTqsy7AMrLs2KjXTqP4hasUy4wdbGPN9Q6JuqdkoE4Va+u8ohpUi1lYM9PSwIbFTVnRZnhlyrNrhGM+S4DQkIfngI5QqX5dwZ9LPrVgIwCd1knfm6H3/5rPtrcJQmPZ7gMhf3VnZ+OKX4GDiFs+W1D4TfHo48C9Z+DtQeWXdn1V5S20EhbYAlOi0Mo71idmEWVH26aubEonoKefHdcStHNSjkddoUaD22XYjpm+L3ZPR8C8q3+7fNruh+hqctl4+LYoLjmvDM7EtCwsVWNVunM6E8JZtlVXRGxrvq0G/mXnU0Nm2SfSd3cr9GhJZQqxuYs0BI4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873c76b0-8dc3-4295-9ac4-08dca641a8dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 09:20:11.8357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cygvK6+5kIoG7+QgvAiZizbS9CrSS8ljIdNApMc6gir1VQTcDGVvtrYfNrGvc1PszxTVlAvMPYWNH4tTKaK8P4fUFJJaXFUoHbWumtj/reM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7075
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_06,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170071
X-Proofpoint-GUID: o5W67uEHAzx1dCmJMTm6oyXOnHDK2JHr
X-Proofpoint-ORIG-GUID: o5W67uEHAzx1dCmJMTm6oyXOnHDK2JHr
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 17/07/2024 03:38, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: [PATCH v4 11/12] vfio/migration: Don't block migration device dirty
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
>> migration and thus enabling migration by default for those too.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> hw/vfio/migration.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 34d4be2ce1b1..ce3d1b6e9a25 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -1036,7 +1036,8 @@ bool vfio_migration_realize(VFIODevice
>> *vbasedev, Error **errp)
>>         return !vfio_block_migration(vbasedev, err, errp);
>>     }
>>
>> -    if (!vbasedev->dirty_pages_supported) {
>> +    if (!vbasedev->dirty_pages_supported &&
>> +        !vbasedev->bcontainer->dirty_pages_supported) {
>>         if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>>             error_setg(&err,
>>                        "%s: VFIO device doesn't support device dirty tracking",
> 
> I'm not sure if this message needs to be updated, " VFIO device doesn't support device and IOMMU dirty tracking"
> 
> Same for the below:
> 
> warn_report("%s: VFIO device doesn't support device dirty tracking"


Ah yes, good catch. Additionally I think I should check device hwpt rather than
container::dirty_pages_supported i.e.

if (!vbasedev->dirty_pages_supported &&
    (vbasedev->hwpt && !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)))

This makes sure that migration is blocked with more accuracy

