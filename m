Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01820C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 16:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmbgG-00049s-Lq; Mon, 24 Feb 2025 11:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tmbg2-00044o-NR
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 11:51:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tmbg0-00020X-Su
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 11:51:30 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OGXa8Y006892;
 Mon, 24 Feb 2025 16:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=QJJh5rKPDtpm0lYB2h8qKAfCaVKiAjSQCr7H6W2mUvo=; b=
 hInYHDA9ynEkTtAX1fI3fA7niniZxBMPfWWkfGpSZaWJOvDO0RVObSLDMAxP5e0T
 ZqHwhQGR5z8eS5X3BCGvM4DPSCucB1BLGfYLbOAZCmsJAW9JyTzGE1jLyuofd76+
 WPFbDyQ8pNKvZ7vDO+WgSOTSSr3ry+fw7Jb/CaSbh8+KhaS6i5zNt2AY/8q5CFX3
 IE2InNehfeZ0NT1bwQAOGMxl1tcA98i7ND6vBCMqlkAGjjcFbLySI7qvfY0bpBwv
 +X7fzCAG4WZqdDTyP/1yI0Oln+wXKlNDhPp6PT3BqvUE9EVQ6sY0T82QGhOYHnJ9
 oKL2oFZNsvk1YMDBouoMyA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y50bk1v5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2025 16:51:24 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51OFsV93007414; Mon, 24 Feb 2025 16:51:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44y51dx7c8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2025 16:51:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEPTj6PqDRCql+MQ9INtbIy/t+8sH/ekH0+yLVz29T3rk5zcfxon3Gvfch2Ba85O0ZonUv3jBlGeVdHHu0512/SQJ9frW0VplC/VTWF5ZX3/1lUSpucMRRxcUBavp23ATe/b1P0kdIbJyJNTn42AyAaLmV1SyIr2jjKfyMKy/iGVxs7vUm2vA0a8cfeOeTVAfkZviRwM2KN+aT0/9ureVc1zxElGtn4vSgQBSWjPo2hAoRs/Cw9q2Ejh9Zkosu7mOb9NovK/fdAUHKf98dJgdAaSCyreXJg6T1ZNQVui5B3/AdmMTT9vo/F+HxZiqtvBUcBcGpU+nxWNe6xsDDR6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJJh5rKPDtpm0lYB2h8qKAfCaVKiAjSQCr7H6W2mUvo=;
 b=Tpo1iixKmxq/1GjOJacSM9misUlHUPUD9r2Z9tYkDyzvJrP5ffSPeoMufKABaVVjocIP3kUmLBWS0WPpBcRFvAvNFfqLzU4fPPoa1dYzZMtgr+l1L6nIKXY7/MNggQxfz7bnBiFFfKwe8B9D/Oh5v+tnCkxXaHObeH+ESea7eRhzas8Zs/D5hu56JELDT42R1BnPLX0VFG4Rr5CsL1glAGcxtSXJNO1vtbI4LGGkjNHtJyumTHWtvkn61MGkOTo0sWoZvP5hznj1ABbkXsXF1GduNHsKHRvrSzRrDHKGNSdmYXJVdIt2EVzfzYR5Gr50LHdDbP7kK78/YBHNf3ueiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJJh5rKPDtpm0lYB2h8qKAfCaVKiAjSQCr7H6W2mUvo=;
 b=vILQeBrowaljlxikSOlLPEpnaQfECGEn3nm0FKyTHGT/De/QpM+sX1FgvNf1+YEyWYe0SpSqRUzGIxytMacnEHZCIuq8cAvlWf4PBFnSYW+pHU21R9n1ben6JKFbGvGlQdwixLbSTqMnoXujJWfv2P7z6EGqXUoMcxY5q4HpnbU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB6095.namprd10.prod.outlook.com (2603:10b6:930:38::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Mon, 24 Feb
 2025 16:51:17 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 16:51:16 +0000
Message-ID: <2b23cfbb-5526-4e65-98d3-7d338ba5a4e5@oracle.com>
Date: Mon, 24 Feb 2025 11:51:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 02/45] migration: cpr helpers
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-3-git-send-email-steven.sistare@oracle.com>
 <Z69xPYAJcOjlSpff@x1.local> <ee12d6ec-13fa-4e66-ba27-97fdb1f49f74@oracle.com>
 <Z7S0m1dnIv674huu@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z7S0m1dnIv674huu@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::32) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b2422a-09bf-410a-74eb-08dd54f3749e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDVoTmU4bS85S0QvTXEwQzVwT0Z3MklDLytXcGFhdU9YRFQyZEpicnJoNTRp?=
 =?utf-8?B?UldUb2REK0kvK3o0ZWU1d0tJMDR0UE9MWmRzRzZ2cFJ2eVNuSHFjUGhzQWNN?=
 =?utf-8?B?TTU5SWtLWDZPU0NGKytTazNzVytDOFovMDhGcXp0SXdwTEd4dFNSR3lCdVRs?=
 =?utf-8?B?Y2lpcFJrRDROaVJEZzY2Snc3bTNoMlprcW9aUnRGL2UxQXYrcmhETVhqUG1a?=
 =?utf-8?B?SXJod3RZZDJQb1I4M2xkMWRWWWtBcldRUWVKam1SU2JHbnF1enh0Z3UzRW40?=
 =?utf-8?B?Ry90R0MxZ2VKUVh0T21IQXdLOHIrS2pxbjZKbnJTOGp5dDJ3TmZqV3RXZHdE?=
 =?utf-8?B?M1VCU09WdUhvL2xzemVEM1VEQTNUbXBwVmpZNlNOUnhjRWZCMUFtR29yQUlZ?=
 =?utf-8?B?dHE3TTlBNGx2NEsxSVlBT0dFZ3VaWS9YU1dHWElVcjBlRkJsZ1luZnE1TVE5?=
 =?utf-8?B?bVE2QnBaS0V2T0crWnd1TU1uaUtFcjBocE84YlplRkxmaXUxaHZic3FWM3Za?=
 =?utf-8?B?NkxJVG1iUUNFMDRZQ3Q1TER4Y2ZIZlUxaWM1VXZ5Q0JVZG04ZlREUk1aYy9Z?=
 =?utf-8?B?TWZhNzFFUFJNTEpXaXpkUDBsVnZnZDRWcGI5cWltcWwwN09RSEZwbU4vMVow?=
 =?utf-8?B?bFJ6ZkZpRU9sbE5lYUVEd2ROdWFVMER3N1M0dEljWUM3N1BnaW1zMVlVODc2?=
 =?utf-8?B?MTdQd0M2M3QrUzcrMkZUVGlTejlhYmdlZU5tRnRtS2NpdFNSYXpTOGI1TnB4?=
 =?utf-8?B?bjNyR2N1Q1ozNHBUdGhaSVQyOUtzZ1c3c2sxWUNJUUxqajRNbXI5YzZ5ZlZT?=
 =?utf-8?B?MmpsMUIvTjVPSVdTdVUzd1RXb01xMjRkeG1kUHM0bGlkMllJSEV2NXRSMmNG?=
 =?utf-8?B?VUdsVHowNmlVK292S0d0TllLZXpVUFFDQjVhNklweWYyUktGM0M2SWMwalJ2?=
 =?utf-8?B?WUJSa1ptZXlTeC9QQ2hVSFpPWUpucCtBdTgxQW8rVmhTN2RLMll0a0ZLWFFt?=
 =?utf-8?B?amNWcERTWmZhb2JUb1p0alpST2tad0duY0d3WUJOVzhwY1dLM01QL2pqM1l0?=
 =?utf-8?B?QW9DUUFRVXdIT3BSN1ZicWRnV0kxR2RiVll4VWN5bldvTGl5cEJWZ1BhU0dj?=
 =?utf-8?B?dUVvZmdiU05TbGxRMWRLMG02YWc1ZWhnWFVMVXo0bm5sYkZlNW1idzlQRTU1?=
 =?utf-8?B?U0dRdGViSzg1cTU4WE5YYkFQMFVhTDRzL01nQlF4cWZkT21vYmxlUTNJV3U3?=
 =?utf-8?B?Z29rN1dySGsrWllERHJwZmpnVEdWOW1KZEg1VDYzdXZJeEdxMkNLbjRVT2JS?=
 =?utf-8?B?b0pYUFc3SDdXRlFuQlMySUJOS0Y4TUU3eTgyZWw0Q1puenlkTWs2bnE1UVRS?=
 =?utf-8?B?ZVpVODZLYlQ3c20wK2gzdUdLMHNybEw4ZlozRSt3Rmg4THNtYmc5RnNLNjZr?=
 =?utf-8?B?b0JwbzJtUkt2MTBkU01tSzFGb2JLK3UyMzJCRGRQbzc3cndvVWcvQWFuVEtk?=
 =?utf-8?B?ZEpUMVA1aWtxWEgxcFlzc054QVd1VlA5S1FJOU9jNitQc0V4NnkrYUk2MTRU?=
 =?utf-8?B?bTc2RUpjTFQvODdHcDVHVm42WWdIZGVNWjRRU3VLWFBYYUcyN0c5eTF5UHk4?=
 =?utf-8?B?QkdBSWtaOURDV01tNDVRb1Eyek93ZnJ0YlhZTUNyQ1liQnNreHdXTXVVeGpo?=
 =?utf-8?B?am4vTG1aaG84bHRnZ0pvN0MxNzhIbGFRdnhlQndlVHM1ZG9rRFRBZ0dic3hw?=
 =?utf-8?B?UkpyaUhsWnBHNEZJTm9Fc1hOdmw0c1RMWi9oOE84bHVUQ09KUUpHRWNQSUZk?=
 =?utf-8?B?NlVRZE44aFhFRmpUNnZFTGlaRldtQjlEcmo0SG82Sk9wM0k1VTY4ZFBEUHRj?=
 =?utf-8?Q?aGaHLaqln1pEO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm4xcmFNOVNXaStkcW15QlFLWlZ2NElxRmMzeW9qbGR5QzlRcVJndDMvekVp?=
 =?utf-8?B?bUNDVmQ4V3U2ZTU5VE1Zeisxb1I5SnYyeGdVa2wvV0xFTlpqRXNZOFhUaVhO?=
 =?utf-8?B?eUpkZWFGZXhuUlZQVit3Q2xQejFSWkprT3oxRyt3NGQ5QUhmQ0t2T0pQUi9V?=
 =?utf-8?B?SFBGR2pOWEkwdTU3dTI2VHBXM0Jyd0RJUzQwdGp1M2ZsTWIxdE52SWlmdDl1?=
 =?utf-8?B?TlNiMW0rMjIvSDA5eHRCb25mbU9hUDcxTHhlckZ4K1c5RCtsU3JJL0x4cmdn?=
 =?utf-8?B?anl6b3dsL1JxYXZjc3ZudzJMdUJDY3E0ak9LazhuSjRNcXNFdVZoRk1udHBl?=
 =?utf-8?B?clR6RnkrUjczZEF6WVBjaVMzcTVVRXlyYUNvK3VBeFlJZGFZa2xpNWJ3WVB5?=
 =?utf-8?B?VEVQSGw4bGVXTlhoay9jSGwyQkdOR2tDckhlVXJBbTN0eXY2VUxFRTdxLzZK?=
 =?utf-8?B?OWdpWEV1OHRONGZOYWJYbzlCU3ZaUC90d3d5Y014MHJBdXFaRXZyb1ZucnJz?=
 =?utf-8?B?K3k4TCtMYitIKzdSVmt1aEYwMFBveGYxRlZXTjZkaThNL3V2UDIyNWRnZ0dx?=
 =?utf-8?B?OUJaR2VBU0pmOFppZ0VwdjIyVWxXZmxlTzYwT2NsVEFWT280UVpnMFZ5ZUtE?=
 =?utf-8?B?SldnS283dnVUbVpnZ01vcTErZEVLRjlwVk45bEcxZHpLZnFIb2tMOCtxUjNK?=
 =?utf-8?B?OHB2N0lEWmRXM3dZcVhIWWhLcG1YVW5KSlNtdTBqTW1Kd1BKUUxnamZTdFZO?=
 =?utf-8?B?KzNpdUpUeHBOa09LYkNWYnMvWWFFQmhWRVhrSWhhUEFlZjJUZlBkZnllTW14?=
 =?utf-8?B?ZVlLamM2OUE3SnFqVCtUNlpSaFJpZks4c1NvOVhvMm56UnpFYWJPRnRUY2Js?=
 =?utf-8?B?eFJGWnhuN1hxYXJ6MmUxZFphY3BodlB6czhZYVg2YVNnUktENGQzT0Z5WjFD?=
 =?utf-8?B?dEo1dG5yNy9aVXVFemh4Tk1FcWFyVys2K3l2Qm5lTEU5NXpVcll3eFFoYUJr?=
 =?utf-8?B?U3huTUhyZ3dUbWNlMXJ0UDM1Y0RUZzJBOUdtOGxxTXBxaXo2VmUyeUhSeU5x?=
 =?utf-8?B?K2dIakNzT3B3ZlQwamhKODlnUmVmcEJVRzJSR0hJM0srRXFnYkI0enFRSUQz?=
 =?utf-8?B?VXM4VWF6bWFKRVlQNmdvYWI4aG1xUVpEZS9DMkhNMzhaRTBGMWdleXAvdjlH?=
 =?utf-8?B?WkRkc1BWb1hEa1p0VzFHYzN2K3JDT3BGQW8yU1BXcWtlMW8rZE5vNk94b0Y1?=
 =?utf-8?B?OE84K0Izdnk4THp3NWJ0bWF4dDloeDhROHJINkY0Z1RVOGlLREYybHdCSkVp?=
 =?utf-8?B?dCthYk1obnNUdzRUOERGR1FUdGxRaHRYcmZPNDhxb2FseXRnUjZSYjNkMTVU?=
 =?utf-8?B?TlIzNCtoSHpqSU8yYWY3V2M4ZUhiUDN1bDNoNjgzcGNLQ0xES0dXbGxnWkFL?=
 =?utf-8?B?NHN3NyswQmFUcjVERW8xM1dEZUFGZ2NlcmdzOHEwQ0Q4cmMzTkE3Y3Y0OVVQ?=
 =?utf-8?B?S2tlcjdsL3Z6aWVJUUxtZWxBZm5scTdlMEwrb1JUdXNwZm1tVnhBa2VZWUM3?=
 =?utf-8?B?dXQ5U3Vic2ZpL3NWNk1zVmM5QU5TeHF0SmZ4NlJoajJ4MnRMUHFHWlNTckFr?=
 =?utf-8?B?bmcyaUFRR0dYblpaUXJHZzVoREZkWnJlSEZrNEF5dHFzajhnNEtaeGloT3Uv?=
 =?utf-8?B?KzlSS0d6NElnU1JuaS82ZHZxeVhtQkJJU011SGJRMUdadmRSNXZrQmJXVXdW?=
 =?utf-8?B?UXdPb0hoQlNON3YwUXU2TG9Lb3JhSkVFTWJoMVBDUHVFK3p5OUxDd01jZDkx?=
 =?utf-8?B?cEVLM1RTZ0tuK3c4djFLc0FsaVFNKy9hSUdJOSt0OFBuTWVGaXA5UnlQbU03?=
 =?utf-8?B?SzdacFFCZkdLcXpWbUx4RkxIZ0l1Q0hXdklpYnlOL3hNelY0MHk0OWhyVUda?=
 =?utf-8?B?TFlOa1V1ODlLUEhITDRZb2R0c1pNd1VQK1JvdmRsYlVLbFkwMXZDY2RXZ1dQ?=
 =?utf-8?B?dE9BaU5EZGdHYTUwZDgyMW5VbmxKUUR0azhvVmhacVhXaXJJK0w1QWlTN3N1?=
 =?utf-8?B?WHh1TFB2RWxwSW11M0s5THgzNWtkTURmbTk5djBuaEdEUmFpSHNSd3BQSlNZ?=
 =?utf-8?B?RmZLYVdjZGRxejRTQzZxUnV2WWhRYTNseDJaSzZ3c1Z5ZHh0eWdRN3VFRTN4?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lj1YN2X5hRlOZFs09hl7RLCKbmRtEinOXEGgdeE3105Je90u8vYeDVNYO0fao5CKWw4SayP7IZxsDrVzZwkP9rG7Bx8iVGfAjrIUQzs430boMq9qFVdLZ3ewuhiXQxiBWdvUnApb/uN7v0G6EQKq8vDwbySzpqdADVPRAtLJik5gFdGRb6DHYPZ1+qD4xPADCqvVaSJC0A/YlBdSXdrQ2QtES3vqpXIEbELnLPU1iELyRrdopG5HMFoUUSGdMa5q1YQq7Tt+NJhV7cjr5FhhHvjknjt1JfWQ6PfV+woHdBkGBSVZ3NHDqlpaG3bzVp9ukduAN5rezipNxl9L+/GBANPvJH3WR3TGzqD0jxXshWyta/eex5bLBoByYu/C5QYITY92Nak0pOJ9k5zRlbNy5lN248Q7gB6XGTQSTpMeEVDXY4pwh1tTG+nvD0WnHRDbOVr3gfFjIPQO68OOmzVLwCYBmJ6bvCuhXzwVyoVWSzIVfgv39GJ1FRWVbie1LBFMRcB2p4eWdxR4sMj19VrMISoThlDEQ5e0O4U2PHEhg7QNrz6gt/VpaE6FxR5GGCkyCv10ASJhTxqaH/phRRdqtKKA86N0tff4PpnOM+deQ0U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b2422a-09bf-410a-74eb-08dd54f3749e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 16:51:16.8630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHbuNjCbH1ui5TsQGTmDg553YUqz+LHHrvRsYnleFfo99XbUtJ3m06PpWffP+yoDg9gCU/p8G1eediDXqQrvIi+oMeIsOuciqAFucUb3mXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6095
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_08,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240115
X-Proofpoint-ORIG-GUID: AuT15CfxuHwVZVPLGN2t55KqCKosJkpe
X-Proofpoint-GUID: AuT15CfxuHwVZVPLGN2t55KqCKosJkpe
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/18/2025 11:26 AM, Peter Xu wrote:
> On Fri, Feb 14, 2025 at 03:31:29PM -0500, Steven Sistare wrote:
>> On 2/14/2025 11:37 AM, Peter Xu wrote:
>>> On Fri, Feb 14, 2025 at 06:13:44AM -0800, Steve Sistare wrote:
>>>> Add cpr_needed_for_reuse, cpr_resave_fd helpers, cpr_is_incoming, and
>>>> cpr_open_fd, for use when adding cpr support for vfio and iommufd.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>    include/migration/cpr.h |  6 ++++++
>>>>    migration/cpr.c         | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 50 insertions(+)
>>>>
>>>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>>>> index 3a6deb7..6ad04d4 100644
>>>> --- a/include/migration/cpr.h
>>>> +++ b/include/migration/cpr.h
>>>> @@ -18,15 +18,21 @@
>>>>    void cpr_save_fd(const char *name, int id, int fd);
>>>>    void cpr_delete_fd(const char *name, int id);
>>>>    int cpr_find_fd(const char *name, int id);
>>>> +void cpr_resave_fd(const char *name, int id, int fd);
>>>> +int cpr_open_fd(const char *path, int flags, const char *name, int id,
>>>> +                bool *reused, Error **errp);
>>>>    MigMode cpr_get_incoming_mode(void);
>>>>    void cpr_set_incoming_mode(MigMode mode);
>>>> +bool cpr_is_incoming(void);
>>>>    int cpr_state_save(MigrationChannel *channel, Error **errp);
>>>>    int cpr_state_load(MigrationChannel *channel, Error **errp);
>>>>    void cpr_state_close(void);
>>>>    struct QIOChannel *cpr_state_ioc(void);
>>>> +bool cpr_needed_for_reuse(void *opaque);
>>>> +
>>>>    QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>>>>    QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>>>> diff --git a/migration/cpr.c b/migration/cpr.c
>>>> index 584b0b9..12c489b 100644
>>>> --- a/migration/cpr.c
>>>> +++ b/migration/cpr.c
>>>> @@ -95,6 +95,39 @@ int cpr_find_fd(const char *name, int id)
>>>>        trace_cpr_find_fd(name, id, fd);
>>>>        return fd;
>>>>    }
>>>> +
>>>> +void cpr_resave_fd(const char *name, int id, int fd)
>>>> +{
>>>> +    CprFd *elem = find_fd(&cpr_state.fds, name, id);
>>>> +    int old_fd = elem ? elem->fd : -1;
>>>> +
>>>> +    if (old_fd < 0) {
>>>> +        cpr_save_fd(name, id, fd);
>>>> +    } else if (old_fd != fd) {
>>>> +        error_setg(&error_fatal,
>>>> +                   "internal error: cpr fd '%s' id %d value %d "
>>>> +                   "already saved with a different value %d",
>>>> +                   name, id, fd, old_fd);
>>>
>>> How bad it is to trigger this?
>>
>> Bad, cpr will likely fail the next time it is used.
>> I suppose I could add a blocker instead of using error_fatal.
>> But, fundamentally something unknown has gone wrong, like for
>> any assertion failure, so continuing to run in an uncertain
>> state seems unwise.
>>
>> I have only ever seen this during development after adding buggy code.
>>
>>> I wonder if cpr_save_fd() should have checked this already on duplicated
>>> entries; it looks risky there too if this happens to existing cpr_save_fd()
>>> callers.
>>
>> Yes, I could check for dups in cpr_save_fd, though it would cost O(N) instead
>> of O(1).  That seems like overkill for a bug that should only bite during new
>> code development.
>>
>> cpr_resave_fd is O(N), but not for error checking.  Callers use it when they
>> know the fd was (or may have been) already created.  It is a programming
>> convenience that simplifies the call sites.
> 
> If the caller know the fd was created, then IIUC the caller shouldn't
> invoke the call.
> 
> For the other case, could you give an example when the caller may have been
> created, but maybe not?  I'm a bit surprised we have such use case.

It avoids the need to remember that an fd was reused, and test that fact before
calling cpr_save_fd.  And sometimes those operations occur in different functions.
Thus resave saves a few lines of code.  Trivial, though.  I will just delete
cpr_resave_fd.

- Steve


