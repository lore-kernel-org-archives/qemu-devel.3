Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EE7C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 15:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYnNJ-0006Od-Mp; Mon, 07 Jul 2025 11:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uYn1Z-0006Cp-3s
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:41:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uYn1V-0005ql-6J
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 10:40:52 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567BMN31027044;
 Mon, 7 Jul 2025 14:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=3IKsEimeJ9TwJIp2F3ihTlFiCC1IR43qLExr5ZBVkc4=; b=
 rSMwSt0bLPgsqmMwxBk2dY10NlesdElUssadKT1S/dVNUrL8ZBrO4tZpuG71FUkR
 DaDrUjDW+1KSJxvZSQ0yZlIMYzJdtMca1EYCFyBMexE+KcMD/Wp1tdz+MJ2pFz/F
 883JRMm7vNqz5zoSMBxAgJquj/UvhvH02ssgW+2erFv68KlBcAtkZXbSUkE6nS1B
 eEuhc9l7H6hyDsASwN21xmwcfPySBH/kkC/sgQvIX9jM0oILwbMf/ohnFv8ZDvwm
 a3ahMzFoA9eUTCW1I8F1yoHFAK4TSs1ykGqbuWfWwvhDXFUlThHoZ185QJz94XGB
 AeB5osnfeizKLMhcFjhQEw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rda18eq3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Jul 2025 14:40:38 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 567EVE6F023596; Mon, 7 Jul 2025 14:40:38 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptg8keky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Jul 2025 14:40:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5WgPN9yO6uLOmhn3aqsA9HSHKTBXWDoNrD7hGUrBmsLNFT3kTj7GzzScMp4AHhbwNC/f1qZRdryfSHkXdfo/K//8e2oKskJm19FlDzgZ8Fn+H5uiiemH/7eNDs5+5b6+gtTxvjSGKvoc0d0+bh7ZYp9RuOzQT9dYvVss2c2VxryxIwGNs2eGsXzXDjBlfMEYMg0e1tpx4xpu6baTEHQVqijsKUgzUW3D9ruQ8xg50+25GevL339gITlstBTTtuZgj5ktAS42UFwC+i7OEgR9O3vyNfuXdx181CnDbCYg0K2dkDmKGScD85GiKL4B4TyAsCyKZCFXzH1qcnfjHUKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IKsEimeJ9TwJIp2F3ihTlFiCC1IR43qLExr5ZBVkc4=;
 b=VP5TKlK16BrMgJggsCJCGDyIsUxIRoRjRA1ePWWCpfkYu5fQ2urUHEnfajFOMiIoklRu7lwq7n7FMvabsKpYy69TcACAfVRVGofP6fp/C/u4VvS8MpS/Cw21hywc7jESIP5t5gGIS7hfguG8/Dnq9+l8dbojbb+iQOOmSe3gI15gpjYuSx2wrCp40VM1nTnipmajbwFZxgKDMWCPckpeSGMzNbOs2BrLD8jG3pAoj1YPPJdk8IQYYgDwDIxoHMaDdEDYTzCVmJOS6TbcBQoZmK+3YpzIw2tltVLdOJNd14VVhCdCD4J9kEE+ooLIj1rEPyOHw09VJ4IzOu8ecgFX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IKsEimeJ9TwJIp2F3ihTlFiCC1IR43qLExr5ZBVkc4=;
 b=ER7e6KDdAMqSfTL9ZF88cd1VUtPYVIUQejNT1rK6FBJqYqTPbbR1r+cphGe3DWGLCO/HP08SxxBrrYxCAhjqi0Lv4QBVxuVYPNsKJcvh9tcMz7zYawtetqTzQsl4PktlPumH/YChj0x5pA+506OpBxMZOnaxBRT8HEYPwNzgxLQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB6216.namprd10.prod.outlook.com (2603:10b6:930:43::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Mon, 7 Jul
 2025 14:40:30 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 14:40:29 +0000
Message-ID: <282efc8a-c37e-4afe-8e1e-f28436e74efe@oracle.com>
Date: Mon, 7 Jul 2025 10:40:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/5] qom: qom-list-getv
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 devel@lists.libvirt.org
References: <1747057635-124298-1-git-send-email-steven.sistare@oracle.com>
 <1747057635-124298-5-git-send-email-steven.sistare@oracle.com>
 <874ivsno15.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <874ivsno15.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29)
 To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ed2675-15a3-413a-776b-08ddbd643859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmVHcWkrK29UOUpxUTErd3l1RFV1NVZZbFlQU2F6ODRoYmRESFhGa1AwQyt1?=
 =?utf-8?B?YnRYNC9ML3ZqMnpvMTd2Z0cwdXJRZ1BqWEttWVF3UG9zMCt5TmlybUZZT1Ar?=
 =?utf-8?B?Q2pxZ0NGUGNHYURwR2lMcGRKU3l5Z29VeGVuTi9hYUN3amVYQjdYMGdINjNF?=
 =?utf-8?B?Z1M3MDFZRjRNQldkQlA5eGZOeTlVWlU5ZWNsTjY4Zmp0YXR5c3JOSkxWVHlU?=
 =?utf-8?B?eFZ3dXhacDFxQ0xERnAwMGRuSmtPM0trOTJoNTJYYmVwL09iTTMwa2VyU0t2?=
 =?utf-8?B?dEtCV0hLZXBXWkJWU3Vua0RxSFVtUG5MQlV1QzZMeHFLMjR6OEFDTElRc2tx?=
 =?utf-8?B?b2J5TjNQVjBjeHBaSWlKWUFYelhGUHRFY3NSTVJZUm1WdnBVRjZ4NU5vVHdT?=
 =?utf-8?B?RVplbEtiSzVIQzdTVG83Sjd1YXBGTm9wZ0N0RTJiSWNCeDFwZVJMTkgvY0cx?=
 =?utf-8?B?Z050SU8vaDVLRmVqT1Z4VTI4bzd5bGtodFlDOTBEdTl3ZzVQK3dpaSs5OThJ?=
 =?utf-8?B?RFNiclZJZjIzOEplelFMc2tGQlhXMjN3ekdQUkwrWExjeHZXSWpjKzlCdnRp?=
 =?utf-8?B?empaWkxhQmtHSDMybk9uMFhxdWhyK1JKTjQ0bms3d1ZHaXBkVythRzJ3Z3Z2?=
 =?utf-8?B?dXZ4bWRSbDVOTVkvMzRudDVVekwzZkMxN0pnOHgvUmJqUzNPRTE4UnZTWFk4?=
 =?utf-8?B?VVZQK0pHbUp4aERqdENncDBUR1dkdDhLRjkwZzBnQ2dpZ09BbElFMEpDeGcy?=
 =?utf-8?B?bS81SDNaM3NKbHhSVXo2WHo1Ym04ako5V2diVkNEbXJoMDNPbFBuaU5zWnIz?=
 =?utf-8?B?U0tZb2hzL2lPMUwyZVd1VU1yekpwTVhpU2I5R2RDSVVQNndVRzlhVkF3VTFX?=
 =?utf-8?B?eDRxUzB6cU5yczZJbTBDT2N2TUtkSjFQWTEzTmJBV2hEZE81clhmOWVVTmR6?=
 =?utf-8?B?L0M0MHlqNDFsNVFkaVNBOHc3Y2xTWlRnOGtlR2NRMTVMaDVua3RyVThpNzNt?=
 =?utf-8?B?cStqOFhRWGcvMlBDazJkdGRlWWRGaXQwc01BLzd5U2hVR3ozRVNjSWVMdW9S?=
 =?utf-8?B?aHhLTVdwZkhWaVJIZkZIbUJ4VWNLSGhENWgzQXJSMkkxTVlmbTMvZkJMTUJp?=
 =?utf-8?B?bEY2c0J1cTN2NTZaWDhSL1VMaHpVUEF1eE9Nem5Mamo4V3hqU0VjbVV5dXdP?=
 =?utf-8?B?aU16dGtEVmdWWEd2SzdiVVFad2ZXdHR5L0poUEJ1Z3RQUWdUMmZFUmM5MnU5?=
 =?utf-8?B?UEtjUHp3TDVEOHppMjQzRXFRdGVTcis1T3ZwSGJGMkFYZFlIMDFDQVMwQ2VO?=
 =?utf-8?B?bVpOOS9NYUdvWGxSNy9FWmxad2d0SDFKUEZpQzVYemZMODRBSkNjMGlwQncy?=
 =?utf-8?B?Vnk4ZWlOQkRaQ0lIZG0wczArMlc1TUN2SzhaWjZqekEzeHNkQXJDYVBpWm92?=
 =?utf-8?B?WFRLWkVZZ2xqRldlMHM3TEd1aUMveDdicW1UL2FvbDRoL3dVcjZzL0Zjc2dr?=
 =?utf-8?B?OFZQUXlyKzVjTnk4eEpINHZKYm5KcTNEbDJpTDBZN3FKcGl3SWRub0RzZFRs?=
 =?utf-8?B?eXhBTzA5UjQ1R2w4MzFUcExHZm9jQUtqQ09tUVJkQUlMa0p5cHEvbDhmNG9S?=
 =?utf-8?B?MzhDR2gydzdMdCs1by9aTmdWd3NNRTAxbmUxOE5ESVUrWXprNjN1bFd2aDFa?=
 =?utf-8?B?SGxISStxS2NPeW13RUkxRXdzR0FhVWsyQktKa1FTdWN1OWp3MGFOdXIyYUNh?=
 =?utf-8?B?bDM2OXBRcnFaUFdBZVFmYjYwWG9uMG1vOXcwakRqWm9pQldRN3pXbm81bjQw?=
 =?utf-8?B?N09SYkdUWXJkVWZLTmdlQ1BhRXBsSnY0b0ducEZlOVFsdjMzdDlvM2xQdmlx?=
 =?utf-8?B?RSs4UE9aNTlaOStHMWRkVmhTNUtDRlFSWGNrSkVYOVgrVHJrSVZEeElRQU11?=
 =?utf-8?Q?UAhopmOeTvk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzVWTkUzVTMvTTlUVmUrNnRjVlB4SG4ySzVxMUhlblVrK2JFOFFwODdqZENh?=
 =?utf-8?B?RlJhUXk0V3AzZVVuYThETHNpVkg3Z3Y5L1NpSEV0YlJYeVkwM0pvWnhEN3BF?=
 =?utf-8?B?bUIzdFZsYXZ4dkhIQVhoL3ZpRjRUK1U0TkdiMTREbnJnVlZwU0J4UjlXSzRm?=
 =?utf-8?B?ZS9VMkM5MERManFrdVNqc1hCV0tjdDBDY09TV1R5NmZZcFIwbklTVDlCZy9P?=
 =?utf-8?B?aUxWYmkwNlYzbmFNeXR3a1lLMnhpL29IN21nQ01iMzdPcGp0M2YyT0c3L25D?=
 =?utf-8?B?OWE5Y0EveWNWMXNUMDNmSnVtMTE1THh1cXUrYkNqUEVraVdSK3UrRUswK1Qr?=
 =?utf-8?B?TWpCRGV2Y0k3U3d0T2srMkREWk8wT1ZyS3ErUFR5VFNXQUNVQlNmcER3OXVJ?=
 =?utf-8?B?WGMwK0F2eVJoRGR3Q1RKajVFUDZYQjlxRnNSMmg4RHQvVVZKc1FhZEpqd2Vt?=
 =?utf-8?B?S1JEcXpxUjNqUXJFYnZxL012UHZOdVNMR3ZKZC8vM3UwRzFEVzdPN2xYdVJM?=
 =?utf-8?B?T2kvT1gwekdYS0x1Sy9QTURPcHZGblJuQXhSeStZdVdRQnZtWlk4M216aTlU?=
 =?utf-8?B?VjZuVGlrVmZML2xzcWRscWRQTDhHOHhzVjR1bUxCdTJSbWVsVG9uUXE3Tkti?=
 =?utf-8?B?WFdQVmxEb2xvY29BK2RsYjlTL0VyeUxydEMrUnhHYmRWOUxDc0JOVHh2Z2ZM?=
 =?utf-8?B?NFpBUWZTVkN3MWswMnlocnQzNUZTK0NNQXBhWmIzMFk4T1JkMktuSFVSZlBj?=
 =?utf-8?B?blBhMzcyZ21Rd0Y1UXNtT3FBTlk1VEdPSWhCQlczdzFycUNEZnRVS25hb3lt?=
 =?utf-8?B?YXNWMmJabGhzSm5BTFlDS0hwUFI2ak5WOTVvZyt3dGp3TTUzMUkyamtZMU93?=
 =?utf-8?B?Tlc0ejdFSk9KZVcwdlo5MFhmc21zUFBvWlJTSkNRTXRZeUMxUmF4UW8xbmlp?=
 =?utf-8?B?cy9yTDg5NExBcE9ja3BlUXJRR1RRMVFncmNRNlVudmJSV2Vib1R2NnlVbnFw?=
 =?utf-8?B?UVdNSTF6T2VYWnVJNTZ1SnZNSkZoNk9teDlQSFBWY294MldWU1Q4K3EzSTdv?=
 =?utf-8?B?ckZLV05YVVZGVGNqNkQ4cnZjc0Y0RHR0T1FGWmF5bk1oMGhlUTJUYzE4WHJl?=
 =?utf-8?B?S3dnZExkSWw3OHc2SnErZDZTdkFVMUlHU2JTdU1DbExTU3VDdjh2clN0Nk4v?=
 =?utf-8?B?SFh4VlYyVUErQllFN3g3RDg1LzNraldSbUM2aDZreGNkakY2dkZyNFFsSGJM?=
 =?utf-8?B?aTNWNUVWQzdtQVZXVzZQNEg5TnVhMjdKbThHR2E0S3ZiditjQUgzM3NNMWho?=
 =?utf-8?B?NmY2R3RQNVBNNGdxL2lPYnhHL2MrUzNWSUVFSjkzVjVpL0FBZVduQTg0MUpx?=
 =?utf-8?B?M1NWUmYrQmdTNHBqT2ZuWlZCa0JRU2s4ZUVEQnhUQWpmRHozZ2svQ2JWV2Zj?=
 =?utf-8?B?YVNVQTQrZmR5TE1TQ2xHQlEzVEljMllvWDBMVElCRjY1SDYweDdTdEN0UnNq?=
 =?utf-8?B?bTlYellFaHRQdFE3WVFremlyL0g3YUtqcHNGY0NOam5NdTNSb3FmQUNVVmRV?=
 =?utf-8?B?ay9lNjRHcFBRUnVxN1dYeXFFSGxNU1J1OHZ2Qjk1WDF2OVk4c3pienN2bGEz?=
 =?utf-8?B?SnZIVW14Y25qZUJWZVcvSDcvbmoyV0JBT1ZCWWVMd3NNcjJsUTE2bjlwcGo4?=
 =?utf-8?B?cEFyQjBaZnpPbmVET1djK2oxZjhZMTdVVXBvbG5vRjJ6aWRIdE8wanFkd2cz?=
 =?utf-8?B?dSszS0JhSURxR0E0bDQ4bnZuYkJKZnBGVTJ2QjljV2luNlJqNkZpMkhaR3J1?=
 =?utf-8?B?aExLR3VoRmEyWGlDR3RrU1k4cWQrUUliRThPbU84a08yb2dhSjgrb2M3dG5G?=
 =?utf-8?B?cUwyWkY3dFNJdDJXMHc2aEptMFhoM21xRFY5ejlnd3RJa2xMOXl4U1RwWU5R?=
 =?utf-8?B?Q2QxSGh3ZDlEbkxLNTh1OWdMUHZZdnBRdUdIK3kyWFEvdkM0S1B0dHhsY2Iy?=
 =?utf-8?B?bDJjaHNVQWRtdTdCaTBjL2JUbXJXMmVEekU4VGRkeDdSSU9IMk40RzcyeTNX?=
 =?utf-8?B?eFZ4OEg4d2hYUWhRbUs2SFhkajJINVE5MW5wUUVDS2RmNHVSWjJ5SSt3UVE5?=
 =?utf-8?B?OUE4UWN1TWUzODFtV2JqZEtObjRtVnFnZUtpaC90MGdZTWNVNWdTMG9YUkps?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oiGCt/W3aX1QMCMAoDijO96us/MP2aHsqG/16uxr1ESPbg9Nhftuy+b0y29nDR3v01v5nYTd34Ivh7MhV7Osq1FUm3P16cKlz/WDh7cDnnJc770iBJZl3W2SAYx31dZrG+tfIIGNPC6UTs0iR9j7yewWYmnAIaAXbhYX/obj5B6MXIhEW8gN1c0dGWoIcaKnMBoOmGFgvdeuqSRbGqJPJM5lz3qkudMTkc0QiWfTg54MnwYnBPnj0NOGipkX9YN5TZvMYnGOvHkoWc9YFeKk4LWMOCMfhNniUoPf+ZTq+KJteAjvS26/MTfmsUYpsfHBhczB+JlUh1T9NgDezr8G1t7sPycKGK/kxmZdE9hBOCxhaDFqRIl9hHri4MR9YAC910E+vi/UOriMipZ0Okxn71BO+DgClwedDlKsr6KrlGGSw6YlMOwD27EHn/cBnARsYmS9zpy93PB1gTOvmQiPO0chVSK2wHNNcOtqvswDmazr5E4d/PPk5tWMzMJzASAwV7ctrXRiKS/iQYS9RGkqzA7BPPmhNhSpjSGY5VF/MGg9nUfCyjvJgNIzeCRmpHcROOlUTfESJSUVgSNaAQtR8ymDBq3JTA/dmib6/4SRMOs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ed2675-15a3-413a-776b-08ddbd643859
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 14:40:29.8161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uu3iO30LUXwBG9uAJJXeTjzVRCcY7zLvb7+fBhA4YyFNtOfCT55hDEInkEVrjT+V8ppX2e/n2y93no5kCulFJzJPhi7kj5PTmTcxL8GmQzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA4NSBTYWx0ZWRfXz3DzgIQUnEpX
 FLM7/wdcZO7lpnWRF1JRFm4UyBKnh8wFzqk+hvIYQ+MXkpibH7C7At42gCnxEUkoLUVTQBeVRc5
 niBougQHINVs7b6CxS+6+wckbUjE7/tk/7DlOjT5Su/FUilKuQE6cMP+ogcNs+cgYoAu6aqH/1x
 bErfRWcrBBW20IAQmYP9PRMAiwLRD14qtq8zN4IPVfVPPGyp1L0vWvO7nEpR69Esk0TuXbmqH02
 7IL8gHn08xAPgRz27+i1kKngKBq0sBpSWn7UBxLFh1YLzpDp6A1D4lema02OQqUeBec+EETVMWO
 vIBR/lZQB9buAbYRXC6u5eXeG/oVzdX6VLCScMKRshPjqD0kj3ONgguALN4cqfJ633HAUZinsbD
 O+lUB4Dp1LsuW8O4IrNTIRWVBOaZXIDpCZoq55wG5ZOvE4N5b29gIJCBZnGagmhB6AEKSpVJ
X-Authority-Analysis: v=2.4 cv=QMNoRhLL c=1 sm=1 tr=0 ts=686bdc66 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=jAX77Vw3n8nvGF-l-hAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Nv5Y9qr5sV_aZ_7ca0fmlDmBVfThU4xs
X-Proofpoint-ORIG-GUID: Nv5Y9qr5sV_aZ_7ca0fmlDmBVfThU4xs
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 7/4/2025 8:22 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Define the qom-list-getv command, which fetches all the properties and
>> values for a list of paths.  This is faster than qom-tree-get when
>> fetching a subset of the QOM tree.  See qom.json for details.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   qapi/qom.json      | 34 ++++++++++++++++++++++++++++++++++
>>   qom/qom-qmp-cmds.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 74 insertions(+)
>>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 94662ad..dc710d6 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -62,6 +62,16 @@
>>               '*value': 'any' } }
>>   
>>   ##
>> +# @ObjectPropertiesValues:
>> +#
>> +# @properties: a list of properties.
>> +#
>> +# Since 10.1
>> +##
>> +{ 'struct': 'ObjectPropertiesValues',
>> +  'data': { 'properties': [ 'ObjectPropertyValue' ] }}
>> +
>> +##
>>   # @ObjectNode:
>>   #
>>   # @name: the name of the node
>> @@ -158,6 +168,30 @@
>>     'allow-preconfig': true }
>>   
>>   ##
>> +# @qom-list-getv:
>> +#
>> +# This command returns a list of properties and their values for
>> +# each object path in the input list.
> 
> Imperative mood, please: "Return a list of ..."

OK.  (I followed the style of qom-get and qom-list).

>> +#
>> +# @paths: The absolute or partial path for each object, as described
>> +#     in @qom-get
>> +#
>> +# Errors:
>> +#     - If any path is not valid or is ambiguous, returns an error.
>> +#     - If a property cannot be read, the value field is omitted in
>> +#       the corresponding @ObjectPropertyValue.
> 
> My comment on qom-tree-get's Errors: section applies.

Will do.

>> +#
>> +# Returns: A list of @ObjectPropertiesValues.  Each element contains
>> +#     the properties of the corresponding element in @paths.
> 
> Again, ObjectPropertiesValues is an unfortunate name.

See other thread.

>> +#
>> +# Since 10.1
>> +##
>> +{ 'command': 'qom-list-getv',
>> +  'data': { 'paths': [ 'str' ] },
>> +  'returns': [ 'ObjectPropertiesValues' ],
>> +  'allow-preconfig': true }
>> +
>> +##
>>   # @qom-tree-get:
>>   #
>>   # This command returns a tree of objects and their properties,
> 
> I find this command *much* simpler than qom-tree-get.
> 
> qom-list-getv treats all properties the same.  References, whether they
> are children and links, are the same: a QOM path.
> 
> qom-tree-get separates properties into children and non-children.
> Children become nested ObjectNodes, links remain QOM paths.
> 
>> diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
>> index b876681..1f05956 100644
>> --- a/qom/qom-qmp-cmds.c
>> +++ b/qom/qom-qmp-cmds.c
>> @@ -90,6 +90,46 @@ static void qom_list_add_property_value(Object *obj, ObjectProperty *prop,
>>       }
>>   }
>>   
>> +static ObjectPropertyValueList *qom_get_property_value_list(const char *path,
>> +                                                            Error **errp)
>> +{
>> +    Object *obj;
>> +    ObjectProperty *prop;
>> +    ObjectPropertyIterator iter;
>> +    ObjectPropertyValueList *props = NULL;
>> +
>> +    obj = qom_resolve_path(path, errp);
>> +    if (obj == NULL) {
>> +        return NULL;
>> +    }
>> +
>> +    object_property_iter_init(&iter, obj);
>> +    while ((prop = object_property_iter_next(&iter))) {
>> +        qom_list_add_property_value(obj, prop, &props);
>> +    }
>> +
>> +    return props;
>> +}
>> +
>> +ObjectPropertiesValuesList *qmp_qom_list_getv(strList *paths, Error **errp)
>> +{
>> +    ObjectPropertiesValuesList *head = NULL, **tail = &head;
>> +
>> +    for ( ; paths ; paths = paths->next) {
> 
> I'd prefer a separate variable:
> 
>         for (tail = paths; tail; tail = tail->next) {

OK.

- Steve

>> +        ObjectPropertiesValues *item = g_new0(ObjectPropertiesValues, 1);
>> +
>> +        QAPI_LIST_APPEND(tail, item);
>> +
>> +        item->properties = qom_get_property_value_list(paths->value, errp);
>> +        if (!item->properties) {
>> +            qapi_free_ObjectPropertiesValuesList(head);
>> +            return NULL;
>> +        }
>> +    }
>> +
>> +    return head;
>> +}
>> +
>>   static ObjectNode *qom_tree_get(const char *path, Error **errp)
>>   {
>>       Object *obj;
> 
> The implementation is simpler than qom-tree's, too.
> 


