Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03B4CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 13:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4fyC-0002Bu-PT; Fri, 03 Oct 2025 09:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v4fyA-0002BO-6M
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 09:37:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v4fxw-0004hH-GW
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 09:37:08 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593Aiefr014690;
 Fri, 3 Oct 2025 13:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=0i1lyguoCz1ToxkEmc6W5vD9DqIipT8OwjylvrJ8rRY=; b=
 rDn0TbWjGDYyD1VpIPT2BM0Cda70j7/1YWVA9DrAhzm5MmWBCrWaP1F0ScK8vgoS
 QBjWlTZ8YBCq8hrPUX6CzO3r3YQTBZC189jxKu8cRuX9ivGy0KK0UgIugKgwC/A5
 u4RzSvNgL4VEjJgyka2jSc4SDdvvHf9ZVa0vJ3KmaQW4bpNXEze3FbHfheAlUdQc
 B3eEqu/TkYc/PBFva1plO09FjzRxWk6FT9pPxPiqnXmZa7oS0phL6pLJnqAk+ti7
 WvPpdU/X11BTfd+zEN3lvAgz5NdSf4IBQnvL/eOXYvzmY8wjqfd4L6u/aTCAKjfW
 1P8T64QNoDQZGV0+iabA7Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49jcbbraub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Oct 2025 13:36:45 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 593CoC4t021525; Fri, 3 Oct 2025 13:36:45 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013050.outbound.protection.outlook.com
 [40.107.201.50])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49hw109dvv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Oct 2025 13:36:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lfc0i6vLXxc4zHHIX843rXLBFEbvXFaxrQRXxh5y8U0sjOPT6VwKoa7IIoblH0Ib6lp6fZ4Gd5XCjDG59jo05Ijwbhir9AFcZWqq13GzGz7H4gTz0e27o4IB4yT8kgPhCImJbJmIFXUcqSNos8q+Gf0uJVDTmaCaFc6tK8GYkZvhPg18CCj50ZjcO7aXQOVJ2p8N5ZLxxTU2nlBA6X0uq+gO56InkiYhmDNAST3M9kltmRqs8mcy6LjDWuVdwiyo4rnJ4Vprh3r7WP9MpJyecomOF/eHz6DBCZ/0aG1I0aIqD451Lw1HD4UI6PS/M7fkFeO5N1faXqcko1j/VsOatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0i1lyguoCz1ToxkEmc6W5vD9DqIipT8OwjylvrJ8rRY=;
 b=COKGaLT5RzL1dekz1aozb1NdJejzbi/eApBON1Z6zFo0TdSDSw1XDnkang92fjRKJcTa1ArXr2JOogP3nY20jZPLPNC5zZHc71dGKHiMAiib3ISsr8hvvaQChhHaBCGBmnrsgAzadJ4ayy/dzqtzOA87euvP2GTGYxSPF93o17ClEiNpltByMySFl/CmTCytFLqNA5XGrx9I5vAEP5060MyRtbIxymgndp0iT1342FLw5kEY5zHa6O8ZffwAnEUO97ny4d+8ofTm3o7a3ddd4EJl4GygW83v/qdXpw81rESTuqZlB5ptxvKEUXiNCtjyoLvzt6ozOfBUoo3VbXxlKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0i1lyguoCz1ToxkEmc6W5vD9DqIipT8OwjylvrJ8rRY=;
 b=xYSnySHtRut98Ou33lXZP4m04P7DVVbri80VAaOHK3oOOEGDmb7S9b4oJloq8w8PgDPOBJJ3J6HpMuBwcdCXOyhfqP8YconUN8p/KnJFj2vC86hR2kxnwDmZtB8q7Pc032Aah9KvVE7dVyH4zIs5Ub+byoYic0Yc+ufXOTgyPY0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB7473.namprd10.prod.outlook.com (2603:10b6:8:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 13:36:35 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 13:36:35 +0000
Message-ID: <0cb3ef33-4459-4f65-9a2a-89b486064038@oracle.com>
Date: Fri, 3 Oct 2025 09:36:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/19] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
 <aN15cNEwH4HBt7NU@x1.local> <c7ae8d4a-05ee-48fe-8edd-77dffecf2c32@oracle.com>
 <aN2JE0D44AdV-qK5@x1.local> <b01c7919-43ae-4bc6-97a3-6f739ec1ee34@oracle.com>
 <24c7cf7d-8b7f-4341-8a47-e157c16a7cf4@oracle.com> <aN_Le6Fuzz1uPUnC@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aN_Le6Fuzz1uPUnC@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::11) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 86882a64-9217-4eb4-1730-08de0281df50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWRWbUZzcythQ3JsYk16TzBYQjhoTmR5ZWJOdmcrU0F6Q2xaNjFYUk5Ib09L?=
 =?utf-8?B?Q01hQkJxeFJpWm1lbFlhN0szMWtPUURSVFM3MEFKRldwVnp0MGFwR0NvUi81?=
 =?utf-8?B?OTJXTTBybVNaS282MXJraGk5ai8yOFNoZXJFTkJ3cE9FZk5UbzJJby9aY09z?=
 =?utf-8?B?MkhmRzB2cFpaRlJ1Rjc5M0lycGhkV01uUktMbXA0QjBPMnRBVHRqK0hvRGN4?=
 =?utf-8?B?NHc4VXF1dzFZVnBDODEvcTg1TEdQeTFnWERySXlyRFhHWC9OYUlKTUoxVXU0?=
 =?utf-8?B?Mmh0S3B4M09BR2FKU211QXFVcXFZaUNCT2dHemdTbDNOUG5RbjdnMkE2TzdV?=
 =?utf-8?B?Ty9IL2M4aytIdUw5UGdQK0U2M0N6MmhsWXNIQ2NzRDZrVkZHSGw4TXVEZVVT?=
 =?utf-8?B?MUdDRWsvazRPMlVHV25jNGJ4QzRCczFoazJQcmE4dFQ0Y2R5bTQ1VU4zczNS?=
 =?utf-8?B?T3ZndGRKU050L2JsMy9aZDIweVN1QU9wNEl3ck96Mm83Nk5iY0hSOHV2Q1BP?=
 =?utf-8?B?emhURXhWbU5jVUdLRVhRdDIxaDNTWld1ekdzUkNMNzJBckpZNGhteEZxYlZU?=
 =?utf-8?B?VzhUbHBCYjEwSld0emRac2dnU0ZRNGpGNzFEbFBJZTgvVzFDeWJQUnBXTjM0?=
 =?utf-8?B?L1FNcGhnYnRBdzMvRk83R0w1UG5BdkQvUGFtMk15RkJocG9ldVI0cFFXRndD?=
 =?utf-8?B?R25FdGNEZ2lJTGtXYW9jOVl4U1p6RVo3aW41RnhLOUJQRHpqUW5leGljdEFW?=
 =?utf-8?B?dDkxNUwxMi9jUzFreER5MXFxaTBxbjNqcEs4UWdpSXJEMmp2UlFYemE1TUJW?=
 =?utf-8?B?OHczSlRKU25CZVFXeDgxSHhUNmM3MHJsbHgzL1lpSFZ6ZDFvNDh1cm4yVE1u?=
 =?utf-8?B?WHBYb1hnTllpdk5SNXJNbUdHcWttZllBeXhvd1YwWk12RnFub1JlZ3dDb2tE?=
 =?utf-8?B?bFVzeGhNOVpWVlZtb3c3L2hCYjBTTkNNVnV6SmdxYlJDZHNwY1phbmE5WDE4?=
 =?utf-8?B?MTJGVFZaTWZVdmZBVG1rQUFONC9scW81QXNmdEQ4aEhEMVJEMkxBd2NwcVJw?=
 =?utf-8?B?bWN5aVpqaDN6YUtjY2FNNTZzSHZaZDNOSDA2NS9OQjFidlpnQ1BFQVovRWFG?=
 =?utf-8?B?Vi9NTG5KVnBDUTkwM09zUHFMSXloV1FjTm9jOEQ2ZVZheWdDRVIyNHVPSUpU?=
 =?utf-8?B?RUI4dlUzYUY2ZC96UktXemRZZWpQV3lHSDZwdWFpMlJZaHM3QW4rS0ZVb3dq?=
 =?utf-8?B?blRIbEZGY3ZxUTFpNEdJOG9pU2VXS2dncDBZaUhSbGdRd3ZHeElpUUZwblVy?=
 =?utf-8?B?VWxXTm10aWhXNWdUNlQ5UVBLUm9rZ0lxYVl0TFFkQkpjRGNVMzYrc3NlQXMw?=
 =?utf-8?B?VGkxbkNYRGdHbk1rZ0tSQ3pSRmk2dUM4YXBtZnR4NjF2OXZmZkZKL2FkRE9q?=
 =?utf-8?B?RVJHeHgrNkg1cGNMV1E0RVZKbzh6TUdpbklEbWlldHBhS0xyQ1BsdmYvekNx?=
 =?utf-8?B?Mjl4QlRwU0RtdDNaczJmdE9xSXFHR3dwYzE5NS8vdFVzMkVNbHRaRUFkZ1Y2?=
 =?utf-8?B?SmNoR25Ud2tqZ0ZZTGpvY0ZDY0Q0Wkw5TllEU211U2g5dE51ejAzRVZuSzRi?=
 =?utf-8?B?VE1tV1pWeW9DRjJMWHgvREZoUzE0STNGN3MrSkQrdHQ3d2VxSXI4dkxHVURH?=
 =?utf-8?B?NjhqYnkwTWtTM3VVOSsvOFNhRGNLQk1EVjZXWFhhWkdSSndHVG9GL3U4SmdJ?=
 =?utf-8?B?NlpURDlTdWhqZ1VtckNPUjdDZjFOclB6dDJVQi9vU2tpQ0Q1V09nV0dCOC9j?=
 =?utf-8?B?clBINmR2QVdMeWhJWUkwckc0WjJzTFRmNGxDMTlMYjl6YnYwT3F6cWpRU0NZ?=
 =?utf-8?B?Zm5SSy9ORzNIVmxZa04vMFRTQnNyOU1vK1lPbTc0MmpnNnZMVEpLczhIcGZT?=
 =?utf-8?Q?qzIHsSY3/Pthsu6jnGJVetSQeK4fKLpH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3IyTGRjOWY1UXJUdHRpZSt6YXl5K3ErcHdqNmFTd1dLTmtUaUh2SkgybU5x?=
 =?utf-8?B?bzhOY2FqN1RHbEZEbFBMU0NKMzJzakgwL0V6TE11V3I3NGthSW9TcWxuWERU?=
 =?utf-8?B?ZDNLMFJpSkVwWmxyaEs2M3lTdU5PaWZUcGIwNW43cUhOVldscTA3SzVMam1W?=
 =?utf-8?B?NHZxN2pQSWVobXlLdXdjaGw2SUozUEQvQ1BwZGJ6UlRyV1RwdUFGMkZPdWgz?=
 =?utf-8?B?azVwWFBWRXMwZitTZGxlNTJPRTVpS2MvQUZoM2I4bGI3NWU5enpHd2o3aVF3?=
 =?utf-8?B?REJwYkMzNk0xY0toR0VqanFXZ3U1ZVhxbWlnQXNUT09iZHArTTQ2WS9KL3Zz?=
 =?utf-8?B?WFpCTE03L21UQTg4VldzVUJ2aEFnN2hMaDE2Vk9LVjRoOUVtWXRqa1ltMjdD?=
 =?utf-8?B?SC90aW40UXVDWDJYdzZYbzRJMkdKRUhtSlVLYmswSS9ENjFSOTdaQ09rUDVV?=
 =?utf-8?B?d3d5ejU1d1B1TnZRSGJiSHM2eUplQWNOeHI1VzFiQnNZUENuZlo3dGllaXR1?=
 =?utf-8?B?emV2UzMybHZNZURwSlpKQklCY05DRFpWVi94NlhDMFplTXRPNUFTQmZjQXdq?=
 =?utf-8?B?bW5nbVRRVWxPSE5PZ1FwSFY4QzRzNksvVzgwWWlDQjJhWExURzdoYkFGeXBK?=
 =?utf-8?B?MHg0b0Y5YVFaWVVpbWxOUWJZVFhIK1lseTVzY04rTWk1VDRxVnc4OFNhZDZP?=
 =?utf-8?B?WisxR1ZWTVVpZ0FsZFVGaCsrenQ3aFBQYXhybWFUM1JSUEhGSmlkYlI2Mmtr?=
 =?utf-8?B?RkRmMWFxalNka1IxVkdoUVdDSlloSk0yek0rMnZQZ1dsZEx1WXJxeTRLVEpu?=
 =?utf-8?B?aEJnSlFjZkhpdld5cGVqTkJ4dEdlYVo4MC9zbnh5NGZDWTY1bzJiNGpsVGVv?=
 =?utf-8?B?NnduM3BKS3hzSzlsaFNwSFZIY1pYc0J0ZU9aK05hZFh0aDUzenJENXN2QWdz?=
 =?utf-8?B?bHE5ekJUVGpyS3dOUmhGYXFCd1VQbUNSMlpIYjFMOGxXNHRXS2F6cmxoZ0dm?=
 =?utf-8?B?TXFUdXN4Z2dwb29XOEc5akVCNTl0OWxIbUdFREc0L2J3dUc0UW9mRTJrbnQ4?=
 =?utf-8?B?RkFPRVgrdW5PODR2c3l1UEtXRkplUVBMZytsUVlNQ3Y3Q2pma2Z6QmR3b2l5?=
 =?utf-8?B?MWVPSTZRSVZNUXQ1WXdsVU0wSHdiTExBT0dzZGxtSThRNUMveXcvRnlKL1Er?=
 =?utf-8?B?ZmhyRzE0dU5rMEc2TVdySnRoVUtwYkUvSmJ2ZzdBcldqek0zOWFNWDRtRXBY?=
 =?utf-8?B?UmtEeUtlaXdvT09ENmdoM2ZFNnVtM0VqeXBlWHUvSUlvdDJ5UW4ybFhvdVha?=
 =?utf-8?B?WkVsYTNhTDNQMDFRdTJzR1dkTmIxejNORUFNT2cwWTk3cjZTbXkzQXZrZ2ZH?=
 =?utf-8?B?YXUxQ0VQb2l4cEtlbFdzMENBRWZxU0w5QXA3SDFwaUZMbi93T2cyOHJqSDFG?=
 =?utf-8?B?SjJuU1Z4SDhvWmVXN01Oc0tORGFiVldkU2E0SzRhRjdHNWlOWmVOUXp4ZHpx?=
 =?utf-8?B?cTV5b1ZSeUVmMWQ3cUFqUTdiUUsyVE9VV3dheTFtSTRpdXZqbW9GLzJ2QUNG?=
 =?utf-8?B?dHVxWGY3UENhV0FpTUR6a0pLMFViUG1Nc0NIUDZtYzBDOTUrSDNSS3Q2dFlW?=
 =?utf-8?B?QW9YOGQ1ZWVEU3lub2VHWlVTNXVTNk5SR0VBYlFCeUppemMxSGtRQ25kU1kz?=
 =?utf-8?B?TnI4eXFPRVJjaHVXK1Eva3JyTTJQeDNCSTFkN2VhOGRVMTdVOE5kZUM0WWYw?=
 =?utf-8?B?ZFJXeEgxdVppblNidmNrNk5rRmdQV0pRZVBvY1hiVnBidit3TFp6NUNRS0I5?=
 =?utf-8?B?NkYreTRFSmo0N1JSTDdCS2RqaFJzc0ROWXNiV3ptRmUvRWllTTdmUlJhaGF0?=
 =?utf-8?B?VGRMdm10UUdRM3VRODYwOUxxM2FYcG5RdE0razRLTlBaM3o3cHdmenh0RVk2?=
 =?utf-8?B?REovQ3AzdjloSnNJSmN0WlFqYXFTTkUybGc3WlA2TkdsT2luZkJwUjRpYzJJ?=
 =?utf-8?B?WDcyR3N3SStiNVl6VFhldC9Kbnp5a2FFcHEyc3VIbzZZa1o1TFhKVXRtNldW?=
 =?utf-8?B?N250TzZpbER1TCswNnErRlBnRVczRDBwekJiUTBzc2FzekhBR1ZKMVd5aExI?=
 =?utf-8?B?YytPQXdGSGpMcDh1RjFaSkdIWk9BdkRNQzhVWEtWODJuaC9RdlhyTUVtOTIy?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PtC5O4sUTcBEKvU9gnpOaEV4M4NPxadt1zn1J7cHPDP5Q5FqibH0FDgPvDImFHgYcyNtWKgkDfPP6VcxCwVzglgPsseFRSAeD1MqPRQ7jTRAHHzcuMew55neYaFqzeLfKT3FjjAzu9Mcgm8hUkPP4RgpxR2pjb6PgjHpUqLY/xWvIEgkwDhivWXAxYdJSRVJZus2GrifhmTBQcEnpMaviwjl8Veg4lDrr5Z9gEx0oG6fp2LzgsAe474FQoDWcwrlakz+zGDf3X6AlZGM76U3JQKtyZxcHBDg4feccWnWQGpAruNKmh1ryo+vwbXDtUobTce1GMsJZmSTLAiJ2OAg9slLSRtvWbIcl/RrJXLx2G4ZLAsgQP0aBRtAqkUvqPGkyB1dkfhYvV6+meD8InqhbkKreKm+MMP4t9yETQfWWzO2NFU/xidm253g88CusKnxJTSwHwmx81J4uDo84W7fkKahNFpRkyRmAnyCHGhYHB4rbxe8mK+ymIhf2xmPRA+eEtYc2hGA1ZHnN2OQorhjvxn1IjcBsYGUr16QhNLLy6x+sG+fH+be2hqFcJCXtteMknCXxk2lD+V6PRqYWQcTZ3fN8Gp8cl9Bt/s7hcUldzI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86882a64-9217-4eb4-1730-08de0281df50
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 13:36:35.8091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jb4l0Mnk5EbPZLq5huLA5ob/Lkf+GSuDp+F6Vpxu0EUoumpVqMrAhmzwmGfIRBBbnVY/Kjbw5T3AaUC19OPQekSsr32A/vICOwitZxYvgU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7473
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510030110
X-Authority-Analysis: v=2.4 cv=bZpmkePB c=1 sm=1 tr=0 ts=68dfd16d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=BOnV4B-JFWrwl1Yw-zAA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDA3OCBTYWx0ZWRfX7WM+SvNbaHwh
 Qj7MJy8K98VQCCQwQ6JpfRMqHQCDPxUrGsEc2gZcRvObaswdS36YYNW+zOuxNHJVHlSFAUp4IM1
 nR8vOXaynNi40aJq18b/2jLtfvlB9nB655SIRMzmY72zjo/RsH6wPUiS/mRl8+1vwgPgRmgMMw/
 EvWwZiON4yus6kOZ2+j/UfZ3dwZAiYQF5U+9yQR2pk6rwXxJAnWM3zAL3F4YYN6MzmyFm+gH2Km
 6Rg8NYKSiix531CzJjkabbSFvL+rptyPbdEtU230A+CKrjv9sZOcaoKlBDhsWrcBXcApgt6oiG4
 JdLhdPIU/5oktlrtb/E6VTKI2BKxBZCH4vFnsyyNEypU9K4dTffPpEnh3+fRi+bmmVXtsZwjeQn
 vJUU1MunhWh2ZqvtpXY+u2bCvGJdvQ==
X-Proofpoint-GUID: EhJZ0kFcBsYhOp6n0mMCBPgFRN0h3M3u
X-Proofpoint-ORIG-GUID: EhJZ0kFcBsYhOp6n0mMCBPgFRN0h3M3u
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/3/2025 9:11 AM, Peter Xu wrote:
> On Fri, Oct 03, 2025 at 07:36:50AM -0400, Steven Sistare wrote:
>> Hi Peter, do you need anything more from me at this time?
>> AFAIK I have addressed all current issues, with the snippet above, and
>> with the new 0001-vfio-cpr-exec-mode.patch attached earlier in this thread.
> 
> I got everything. As there's some dependency to Fabiano's pull that already
> sent, I'll wait that to land first to send the migration pull.  It's likely
> easier for Richard.
> 
> It should be early next week.

Thanks much.
And FYI, Fabiano's pull landed.  I just pulled and I see the test patches.

- Steve

