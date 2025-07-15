Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8DCC83F2E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfOs-0002ty-QC; Tue, 15 Jul 2025 09:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubets-0002mH-My; Tue, 15 Jul 2025 08:36:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubetq-0001SY-8Q; Tue, 15 Jul 2025 08:36:48 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9Yp83007973;
 Tue, 15 Jul 2025 12:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Q5wQaS95BHaj4FjLNDeHLmuEFu/qbwN+xbnSaf0gNSk=; b=
 WZYj6X0IVqJOvM3Mg4bzaHjmybuWyHYWqOQ2i6JKPZkn36/55N7rl6KXmexPTGIX
 IrPFrIPrpEYhcVcK8+vwjvIrmaSbZG+/W29kRY4nvleHFlODCzI0rYy1d173Z1OS
 svk4O6mpNxyUS6hbCJ2hz38jIjaZn0A8ytKE60v3PR/tYUbTYVnorQEuvpJ2SHuF
 M1aLLPQsM3siULUkf3LVydgnjPLPWUhQtFxn43TSoR4TnzxfsqZQMzcBOEvBF+J2
 uuWJXRzZ7JqZNcrj6Dysy2lFuTS0RvAazlFpcA2HxFepiqy33zfjVt1amEza6xjr
 rtti8gEPfKf0y9YH+Fv4Hw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx7xrbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Jul 2025 12:36:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56FBHRF7024098; Tue, 15 Jul 2025 12:36:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue59w9dj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Jul 2025 12:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOnEAH17u0FJ70EtqHk9i2iF17JXhAlq4fgKTsMUWbXdrvHSSwwfdZVsVHglq5wC4iTd0GBQbnA0qGeHEMP+Es1voCGulrOvSr34bQcLHCJD1hToXCF3tpGCpiwB9csrM5ozFWkDDtuJ5kY/hEEddWNg5z9yIX1onZ1JuY2qlUtFw98l59wDI6jS8cW7cH5bINEM0cVaJHkREdf9HQylPtG5WV1AloBDMnQXLwApPLRJ5UUhFmy4m96TlCXlvKhjBCegLvuzvSEggG8Mn6Av+UjBiVUl+PwNtIjxDLKrNfgQ+GpLx067kQp625wko5/qsXqm/zA+yAFzGO3YMXD3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5wQaS95BHaj4FjLNDeHLmuEFu/qbwN+xbnSaf0gNSk=;
 b=C9R7NR2lMjTS8do98RGbwNA0ovG4e0SR8oVa6mg02CNEKI67e9sQfoMWIl79QgTNK8nUnE3A4MiIL7DaqHuNxmMbjmCpJtmZVOrO/4nYsYg6QYq6gZl0+4KHeejqfqnPGHiuRUUC3kbNPRj8xtjYk9ZqMBuIm4rKY10SHUVu+/VXB6wbVbORVffOH1SCySKyOzcDAAi1o3fuQd+zNgOUNG/c2cgo68EwH7VkhemgdSdIxIFlzniHull2ftmNr+dn8JpD//KjAUlhkqZSJmzxsUkqEQiy4w5f0cUodz9HsNZMLkwkrai9GUnNUIWGQOr6b0BjZSDfQM7wa9yLeOLm6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5wQaS95BHaj4FjLNDeHLmuEFu/qbwN+xbnSaf0gNSk=;
 b=eGtL0A0j4ImXt+KgTvJq76wWZLwc/lXVCab81rN6u3q5NAO05T646JyL/nRUQ+mUkMc2aOYxnDtfzFX5VnJvalb92nnhvAVWI2W3MhO+1xNMmc1YWBA72xD4uAVQMMOMCYmseAIozR6r3g53Kq5ed0OuzQBbEHlsQLktGtjkvvc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH4PR10MB8049.namprd10.prod.outlook.com (2603:10b6:610:240::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 15 Jul
 2025 12:36:38 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Tue, 15 Jul 2025
 12:36:38 +0000
Message-ID: <1d1da79b-b340-469e-b597-50633734ecac@oracle.com>
Date: Tue, 15 Jul 2025 08:36:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/22] vfio/pci.h: rename VFIOPCIDevice pdev field to
 parent_obj
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, tomitamoeko@gmail.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-23-mark.caveayland@nutanix.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250715093110.107317-23-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:510:174::24) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH4PR10MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: f898ac2a-b2b0-4aea-46d1-08ddc39c3de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUdqQzZjL2ovdFNMQUJJSnhJSi95MVA1SGhvS2xSZHN2SjJLYWlSTVgxR2tK?=
 =?utf-8?B?V0lsQjc0cXJtbTZDSGF2MTZ5ZnNHbEcyMFN2MFRYKzFIdHZhM0xzcUkvYzJ3?=
 =?utf-8?B?eDZ1MEt1V1YzZkpCYWQ3SStadnJGVExzSmM3V2VMV1BGaGNOTlkxd0xVcDNo?=
 =?utf-8?B?SVlYcE0vMXZLTUdBeVNmNENnc1dkVlZTTG1GOVZRS2pZeTNpdFYzNlhqSjNG?=
 =?utf-8?B?SkFjSGduZXdBRVl0ZnhpTFlNMTdLRXNsYjQwWG5jdS9zOCtyVWdUaEVhTnhn?=
 =?utf-8?B?c2JYUG5EbXFUMDJPc3RCOS9IS1lONm5iYnh2TU5mKy9sTk1UWjl6K0Fuem1I?=
 =?utf-8?B?dmJoMWJSRHVRSU9IeDlDUUFJS0EwWmpTVEk5L1JGUUJpRWdkYVlIOCtERnpr?=
 =?utf-8?B?WmhXczZNU3ZSMkNaQkU0T3NPaUxCT3pQRW1YdTRnMlVnYXRkMWV2Unprc0Fp?=
 =?utf-8?B?cStmVVlKdVpZVVRlVm1sTE5NSjFCNDBmU2ZBbVZNaDFwOHI3SFNtbXI3Tm44?=
 =?utf-8?B?ZXFCb004Sy9Ia2FVWGZxdm5EWU01WEhvWGF3bjcrTUFoM1FZOTUvZTlIMUNH?=
 =?utf-8?B?QVlZeUhpKy9lazF1TXo4cm9xZzZUNzNkaU1HaUc2RFpUK0FOQmgvZ2JkOHd0?=
 =?utf-8?B?TU83YlpldytKTDcrZlNwOElJYmZVZmhoazgvcEU3dkxBSVR3R0QreE1KSVdF?=
 =?utf-8?B?bXZMMStQdW5lWFJTaFRiOTFGRlVKOWpmSzNETHhDZXV2WEdvdW9Zb3dReGRV?=
 =?utf-8?B?L1IzVHJVb0tXNzdIbW9qdEl6bWQ5cUU0SitKMlBxTkdCWDg5QjlnbkxwcFps?=
 =?utf-8?B?bWFVazN2bmMwckZaay9vVjAwd3ZnT2VqWjlhcUhpc0hEVGo5QldOV2d5bXhn?=
 =?utf-8?B?MXliRVpYR2FsWWw4WURXWGwxSkFzeGEvZzVFNnFhaStJanFqQ21ZZ3k4blhw?=
 =?utf-8?B?YUdwZU92UXQvclIweVkrdTNCejJJRGtMdXprQ2RvVE1vUExRVHZEUzVISldi?=
 =?utf-8?B?Ym04QkpPc25obXJLT2dvUlpsL0ViUUduWWd0M0Z3Y2gwUXhJNE1sZkhwVmww?=
 =?utf-8?B?SUxTOXF1elZBTmMvRU1nQkZPYjZCV091ZXBKclBhRTJJQ29jU29wWEtmYXRr?=
 =?utf-8?B?SHVZNytkRnVGQ1ExTlFTa09Xem9OcTFIZmp0Ulp6Z01XN3dzL3c3NXRuK29R?=
 =?utf-8?B?MUF2ei85dmx2bElDM2R2MDA0cE80ZENmdlBjY3o2TEE0R3pYZGxvRkk2aWpN?=
 =?utf-8?B?ZEhBWGpXeGlNMW12U2VRR0JtcForemkvR3Z5bDhiRmZrNjdLSWN4ZXZqSmJv?=
 =?utf-8?B?cWhpMktpWU9RRnBiVXVUK2R2K2tkbHk3VmpVYWdSdDRrb09pMFBjY1hveGF5?=
 =?utf-8?B?WkpVQnJoMzJKbHNjT2ZhZXN2Zld2dDRRNGhzcnZNSDZKT01zZmpzWjVSTjdj?=
 =?utf-8?B?Ni9sRldGMDJLTU1vU0lyNGIxcnoxeExVOC80d3VsMGJHQ2tQdnpxU3JLcWRx?=
 =?utf-8?B?RDhicmIrQzMvNVJZR3NoWGpuKzBYbm4rcEl3NGVUN21OWTNEc05uSDBsWGg0?=
 =?utf-8?B?bUpaQVNWa1NtMUdvQXhxbG5BUHUxcHhTUDJ5QzFBWS9pSytwZG5jZDZwQ3pP?=
 =?utf-8?B?SXdmeHNielJkaU42bVVBM0szb05xeXQyaEJaRXVFNi9ZTUZhWVhJVG04TUVS?=
 =?utf-8?B?OXVQbWdubDh4VDU4b0ljS1JGRFd6OEJub0F2YWpLbkRiM1lHZmh1YmdnUXZs?=
 =?utf-8?B?eWxWUCtBQVlKZ2FJdHNVZ0hVVEdTOEtmZDkycEh5L1NXeFVzRmZNTGkzY0Rh?=
 =?utf-8?B?YVdaVkNFajlvcFZtZjhSSlJDSm5lUTVMU3VhNHpWSzR3TmlBQm42QXRma21s?=
 =?utf-8?B?QkpDaGFKRVhGWDl2dmd3UTVNczZFUm90TWN5UWdINmw4aUFaMU9RbGVvRkZX?=
 =?utf-8?B?ajF1T1pYdkNyU1c0ZzRjaHZHbXRGQmkweS80SnlEU3d4YU0xNkxtRit5WnpI?=
 =?utf-8?B?dGNjZm9JN2NBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG5UMVFNN2cvTFFGV2V0azRDN3cxTVRVMHIxUTZqNG5lRHdNb3c5TDZFVHJN?=
 =?utf-8?B?V3FlOTRoWi9tNTNtN1lDd0xKNEgxNWlkME5UQ1RqVWhaRnJPSFFWd1krWFdG?=
 =?utf-8?B?cEp5Y1RxQVF4S3Z3NHNvWVBKcDJiaUtDQ0dmVjROckltM0tXRElkK2thWnpL?=
 =?utf-8?B?TTVaQjdHKzRJeENtWUcrZlZLY21ndllVdEs0U3pMdXNVV01QVkF0Lyt4RzQz?=
 =?utf-8?B?YWhIVW16SVlRaVR0OGdtV0Fwb0M0VTd4Z1BEei9vUy9yQlMvdkhMOGFsVWFk?=
 =?utf-8?B?cGdqU3N3cG1mZnZIV1A3djhjTFB0Vk01RS9Zc1l4RzFQa2pjNGtFVVVpcEtW?=
 =?utf-8?B?V2o0bm9PY0xMcmRTR2FxdHRSdnh3WEpSQ3RpTndaUXVxT0xuYk5RZ0ZpeHhW?=
 =?utf-8?B?WnEvUlFrbEMyNXQ0Z0dFYmhUTEJpazRYakcvSkEreTFLUjZJemt6S2ZGWElV?=
 =?utf-8?B?MzY4MnEwZzhrVXBFUGk0ZnNvMUZSYnZsd2h5ajVRVlk2c1VlelYyRlBKazJQ?=
 =?utf-8?B?R09DZG1RbVNNeVo0cTZTdkx2MnR0WDNCT0xHSUNZTHkzWGprMTA1V042cHBE?=
 =?utf-8?B?V3d4a005czhDWXVZRkVZcG40K2VjMHcxbzVyejF5NFJwNnc2RUlGSFN3UXl1?=
 =?utf-8?B?Y2gxQ2tNLy9EY05wTzNXcnpOVmtLdmNpbDIvdHNkbDl1MVBFVkZYUDRPWlVR?=
 =?utf-8?B?Y0V4cGZJUlZlVmM0NllJZWNlZHBqY293Z3o5MVpMR2pMRHFZUy9ONFR1UU1C?=
 =?utf-8?B?ZGlPbFJWd29zVkNwNE13cktINjI0WlVpQTBaWnpKOTZ6R3NUT1poeHhSdWMw?=
 =?utf-8?B?S0JCOWdpR2hHb1RvenkzZFRSSXQ0SVkwY1Bra09YM3JDR1ZJNmZIZ01KN25r?=
 =?utf-8?B?YWxVakFwTytUZUVBdmphV28wdVI2WHNmRnpmU2ttNHd6bVFiMFlXY0hqMzEv?=
 =?utf-8?B?akpmanlXRVVNb3FKRGJvMzlGb0NwQXp4d2NBNGNFaFpyWlM0Z0J1TzRjS25H?=
 =?utf-8?B?b2hudWJYOGFnZ1V4bmVtZ0oyTmFrNmxFZHgydHUvam4rU09EcGo4c0dhaTdF?=
 =?utf-8?B?L1Q2aVhXd2FsMjNZTEdYM3RxS0xmNlVUN2REbWgvNGpOR1RXZVhEaUNLSWNS?=
 =?utf-8?B?UFkxWU53bFpRYVlLa0FaamhJNDREMDY5VWpxclFxQXRRUGhhTUZjNlVOMVdp?=
 =?utf-8?B?V1pXbll4VXdWR2p2MjlReE01QSsvUmw3SzdqQlJWc2lJUHd4NGVtUUNzWXUw?=
 =?utf-8?B?eXNjeUZrWFd4U0x0UXJORktrSWVTZWUzV0d6aWVwQ2R0KzlsRXc2Z3UxYzQ5?=
 =?utf-8?B?RVd2WHBPVnNUU3F5NXRxL0t1TGRjN2lpT0Y1S1g2QzRiazc3WjB4cHA1TjNj?=
 =?utf-8?B?ZU1RRVM2MlNuYlRqbXk4S3E1ZzJ6dHkwSzV2VHgybjB2aVlWMnJWNjNGTlIy?=
 =?utf-8?B?M1VpaDQrOThUU0ZoSmdiZ0txdE9NWitZYTBzOG16U09LaUFITkVyeERjdWdM?=
 =?utf-8?B?MlYvSDBBYmNXNzF1Yjd0SFMyNEV2cVV2b0JaWFlUK1puekYwY09wTDVQNkhI?=
 =?utf-8?B?WFIzOExzZnptdklYelNDbkRPM3hUenZYOHFMMEJpT1lvVHJ4cVhJLzZmaVN5?=
 =?utf-8?B?cHRZaUU3alk1VDJmYURWR29LNlNvRXRMNXJyWGw0eFJkL3NleGtRc25tMGhT?=
 =?utf-8?B?WFlEMDJMaERPaTFreVBoQkhmWnJJMW13aC92bFd3Ykg4ZU5EN053WVh1T1Jv?=
 =?utf-8?B?eXRlSXA5K1FIY0lGTGJaVm9CV0FQZWs2RW1LRjI3TlJUejFtdzU3M2hGQlB3?=
 =?utf-8?B?TTh0ZmFuV0FRZ3hia2YrWUMwRkYzSVVCK2pNeUhyNFc3eTFERDRydkxQR2dG?=
 =?utf-8?B?RXE1SzJtVjk0NUdVSERXTWJCQVBBbG8yQm9qR1IrWXNySWhWMlNnUEw0MGlU?=
 =?utf-8?B?SzR0UFFobzV6WVkzb2Jvc201Smo3RjZtVlNWbXNYNUg1eGZXcnhyYzZYeFJJ?=
 =?utf-8?B?cFMwWlRlbFNqL29pVHh6dGtQK2wzYnlaeWdaQkZoUVE3VEgycHZOcSsxOHdF?=
 =?utf-8?B?dm9kWTh4R3lORTJSeGxLcnk5Y3RoQXEybWdFV2N2ejI0NEx1MEQ0WkY1aTVm?=
 =?utf-8?B?L2lRMjdXZWkyR0lDT3p4WU44QUMyNncvdVQ3WjA3aHN2NFFsbS9UdzRVbUdB?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6wxxoOirSeFGaLi7zJi6tTKQF/7dfyZFiC1OIOYUf9dwmyDS+rFpOoJKt737Kj5mjbQW9A0bpcwmsIEud8PqpigYVR/TC/EiGn974G+FjoI1nXAy+X/f1AYkxxFlYbMuUp1ymM8bbx0l0W8d38SiMQiGoU0NkKLGUJy6IEm+s2ZC12kmKqh6mZA7+g+xgwX3hWkB9MPqXRVKxLrPpzq+tSwyP4c6auOtJEXnVP2faifrfpZ8ST2eWFvRY+aFr1qJjnM6MIvlqTsjx1g/wmdZb1K25rAyiBZMA4k0yt6HbXP74fk8nVUZbvLSXfGdj/9aeEf1ZiG5SNelfCpSOoCnIW99xB8TUYEh9P79ZPbepoSU//qqJmzrBFjufHEWnaUcWy2zo4ZTJF1TEn355OCkuIe+ETU1Lo8hJsXDZJM4vgBKyHSWQrQ0RmG7ZFNsQNVRWEub03VqTxP/r9nagJSbfjkY1864bTZj8iQBbmhTGdmgtraiVPKOcFDXJMJaDk1c43OKENoGLuqHAIiTBSUJsvoPTN/EaSyvEoMF1fJ3fvVR2bT4BXork7aXd+WLZY3PZcUGCU1cn9xcedVTw2UzVoAovNTOpG21FIS2fj0W2bc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f898ac2a-b2b0-4aea-46d1-08ddc39c3de8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 12:36:37.9577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/M2DSTU52M0VPvgpyGrLeSQFP5hqm50Yyuf3ioP1+Q45Lvkd/DReKkSFYGTdRvEFT3c7kCQXjDkOm7sl4h1s5duNz8G2l8pkyITS5M3O5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8049
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150115
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=68764b59 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=64Cc0HZtAAAA:8 a=yPCof4ZbAAAA:8
 a=h-vgAObcb9iobQtJ06QA:9 a=QEXdDO2ut3YA:10 a=AqYkckc_seYA:10
X-Proofpoint-ORIG-GUID: xFXE-7g_k1MJzOw-JWkMfgf6h_gmfZrP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDExNSBTYWx0ZWRfX3VOfsQVy5HVC
 peY2l4c3PFw/ToEMYJf2PWnrk00SSHBzxNa0zeshOOG8qL8Sf4hzFgygASBY8UwKeBnkQ4IQS56
 BF5EbAWm0XDwZ/RIH9EwzE+Z+S8PcvTjQ36US3YousnvyYi8pxCbNq+Q7/qGlGd9sgCmV+K8J9w
 iudrxfWjvJRYeDjfx1PZT1Vnk8aP9c/phobYnm3z/PgTZKiVj9VFHn2+Dmo1+KqHaODATqeLO4+
 zervCaqd4dV9kft7VmkMo4IAYTCQI9Chl/fQuvZtj1Wg+QY2vJUrXI0Ho9jaPMQlgo7u6vi6aUc
 QVbe5EFG2CxLngNnxg2xmTG/hM9OJpWSq1Bfml0qDbbCrj+dDHv/Iw2/X0jAtb5HbJBy80j8qb2
 w+M1VkrN/JCwUmFfki/Rc5JFELdNngYkKB0g36OZGV66UthLPSB1UNoZQq4GexM1sm36fWML
X-Proofpoint-GUID: xFXE-7g_k1MJzOw-JWkMfgf6h_gmfZrP
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/15/2025 5:26 AM, Mark Cave-Ayland wrote:
> Now that nothing accesses the pdev field directly, rename pdev to
> parent_obj as per our current coding guidelines.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Steve Sistare <steven.sistare@oracle.com>


