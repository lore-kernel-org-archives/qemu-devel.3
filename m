Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5E2CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 14:51:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux56X-0006zS-0m; Fri, 12 Sep 2025 10:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ux56U-0006lq-7P
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:50:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ux56H-0007uD-VB
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:50:21 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CEmF9C022823;
 Fri, 12 Sep 2025 14:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=OmGGi1q8L6VotGk1ePO559OQL5LuLNr+3Y+2AVy0xks=; b=
 NjcP9i6Jf8dWqdiQQWu8iyRIHbqpYF0ykwlI1lt6ejveDGSgnHrwdGdpCCSuElNy
 xEMnGlk20WZPMT53vG0wrKfb4MphbeWBQm1YVMTSy1FaNA2ULmri7EHyUsWRYe8s
 XlWQZ6cKOrGlAeiRQI1YKU1jnPwnzOscvWjVH3gWhKiEqv37gZcp3lUmoVs7dCrQ
 M+tvzNPTYp2zc8chQ7qIWup0KwHQe/70/H60wNG9b5Drw08430JgCUNsxt9JeWfY
 i5C4325Ab5eMDMFIvQxt2YE9WOYlt5bVv1n5Cu/VcpAHgWTzA7p2fvxNuDuz6KGV
 6jK3Ew5hteW1hDOjNKw7VQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921pegcp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 14:50:07 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58CEkV2m030745; Fri, 12 Sep 2025 14:50:06 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012010.outbound.protection.outlook.com
 [40.107.200.10])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 490bddwtpd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 14:50:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bX31H/6OV1W+FHeAq7C6AXuRPXQyxBCNSLlzmIwQt99Ksal/Wld2xZyViD6Snyi0o4kk/f8mGV1WKUbLhoqYu2mqw9fObOM+p+EZKgEBb/vt5Qn1HrRs1L86nVCOl2cUmuf3jFtdzhWn+//bjvxj+SF5iyHp3AcyQdX4VuJR2TyFpnaHhf6cJJ1dc0rL0Gy3d4ssKtiHU+Nw38UZ41URiqCl2khIK6LhjuO1hg5B6KgrRIIxGdnjL1uDkqakiI6ix+8sgXoZfX+4Gj7xA8wWNm1dcWA3tsYIM5Fgu9Bna2rfN+Ra+bq2Ogsyejgq63mK5DBY/IyQj60JYofeeT9TFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmGGi1q8L6VotGk1ePO559OQL5LuLNr+3Y+2AVy0xks=;
 b=Z9+hognmU8xcfO51g566w0ewmoLpqO+gYjSnZmk+1g7QWkiZeuLiZI+gdVFH00k+mO6kXjZIdVzc5XkopIFsl59zjyfPuCEPm9WoBZMCwhcullPkbUsQeTosncfkcOJ+aTemD2hjx0Akc6f+mzqG3sBAIOvC6zySpffEj//o6t5E1dN3khgLDlBlqAsWPKgSjmNuT/NWJ0z55KzqJGTi1YJgz9cp6JHDlIOc+lYrK2wAb0IAlbEnc9+bNJcLZHLUOSA/CRutklMnT6AcUsZhq2zx8ACDEhrDnF+BgAEmWLU4LDgTp1QfWyXpGEcSx0gYcZuw0nJKyOX5DpQ8ERx+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmGGi1q8L6VotGk1ePO559OQL5LuLNr+3Y+2AVy0xks=;
 b=f4OrziG537FW9A6v0hsWqTzoGNjPreunUzeXeJUl6V7SJYyGILHteKHN2RkfEytGK3FDARdNM2Y6nMVmsOLdXG+fwhgxKsOqOv72naMr+z7GuKPYFRYgdPtsJYblngfCILL+HeBtUO49p55L3FsrQmKmPKcQLSR/0rp/ngOU5z0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB5087.namprd10.prod.outlook.com (2603:10b6:5:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:50:00 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 14:50:00 +0000
Message-ID: <0239e0ba-b646-4b09-b84f-c0c90a908c40@oracle.com>
Date: Fri, 12 Sep 2025 10:49:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 7/9] migration: cpr-exec mode
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-8-git-send-email-steven.sistare@oracle.com>
 <aMBWjBGPnmz3rtwh@x1.local> <60f44830-d306-4dec-8f0d-65d3b32b3a2e@oracle.com>
 <aMB_stJSkPgHzug0@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aMB_stJSkPgHzug0@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR02CA0027.namprd02.prod.outlook.com
 (2603:10b6:510:33d::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4e86d7-fc01-44db-c623-08ddf20ba632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEl0ZEw5aDB5bUw3ODdhOTdMa2EvcTQycFlMUEhHV3pXMUVnWGwwbWpZVVlU?=
 =?utf-8?B?WTdiVEF5NXVSRDZUZUZmWkozVEJldkZ3WTIvci96N0xCVDkrMWZzUnpWbUZn?=
 =?utf-8?B?WVVEVE9JMDFKbWt5TmhEditvMnpxK0IzZUJvdk9OSWErYkM4VTk5QUs0dlps?=
 =?utf-8?B?OWpkZG5Od0FsY2JkMlhuajAzOFFWVGhRVHlzUTJNcmRsWkxkbTFxUmFJMWNx?=
 =?utf-8?B?MzhzdzEvbkVkUVdDVWl5SVlSZi9YdE54Tk5qVUZaTS9oa05ROFl6eDlsK1k0?=
 =?utf-8?B?MTdHR1FSMWdjZ3BNN3phcCtXaHM2MCtVdU1JVXRLYzE5dkhEMVBpOHpKK2sr?=
 =?utf-8?B?aWpTUnN6UG9HVW1Mek9SaTBiUWxibTYwT0J5SVVNNjFUM0Z3SUg4NDZOeStM?=
 =?utf-8?B?Q1ZPRUhjYkdadzV2SGVMYm5TRGJUZWVYUWhTanI1cU9kU0tINFpWdGRpS3Vs?=
 =?utf-8?B?SGFKOUVIRm9LYjRGQnVFemk2amFnRlBvYlJ5TXUwSSs0SE1TdFJNcFI2cUxX?=
 =?utf-8?B?Um1mZk5TcXl6SjFTUTczMDJiQnhMVmFVWm5WMk9EMit5YkNJWmdmVnpxYzRC?=
 =?utf-8?B?MVphbFZwc3RDMkh5dzI1SGpiUGtubVN5UFpxQUtvRGZMY2xhbERZQ1QxcURS?=
 =?utf-8?B?L3ZuQUhZamFZdVRidmZvOWlKbExOdWxXQVhLOFY4aXkxWmQ4UTVTQWZRZFQv?=
 =?utf-8?B?SStUdURtaDY1Slo4bUs2cEZQZ2JTYldqT1loV1JVK3N5SmJMbEpwTlBKVmhS?=
 =?utf-8?B?WUNLV2FuWVNLWFBJc1doZm9MNmJDN2UxVXhTSDZVa1ZTL3JXVlhXcTE0U1RP?=
 =?utf-8?B?UDVjY3g4OXUvc0x1ZGFHQlpNamVBcjFUWmdKdFV3cEF5Qzl6YTdXc0l2cktF?=
 =?utf-8?B?SDVXMDkyV0JuNW5qbEU4SVNBRmpGdVMwVW5Qem1Fa1UvSjF4T3FSQlhRb3dk?=
 =?utf-8?B?eHpjNitOWHNaMUhKRXMxQU8xOVBWOEF2UE0vY3I1NUozNmhXajAyVm5HajdK?=
 =?utf-8?B?OXZMeGZzZGYxRExsWG5URndIdDF5bkd5YXh0ZWZZNzU2SmdXdDlEN3Z5WVBS?=
 =?utf-8?B?MlkyVGQrWFhCT3dBQVVhWWpQQWRaMHpjT2xmcDJJVEk0QWFxWEtxcWFKNTNx?=
 =?utf-8?B?aDNDNVV3elY3NGViazFyK21Ua2Zrek55bkswcHM4b3pUc25BR2xpS0RxK1Zv?=
 =?utf-8?B?bndudTBVdFNac0d3aURwUE05SC9rMmZkYlozWWN4Ri9MbGVDZDZZeTVnSlgw?=
 =?utf-8?B?b1I0K2N6eXZya3k4cUNsT1hwYkFnVjNnYjdpTWdsL0xtclRmbVhuVlowTlZv?=
 =?utf-8?B?bkRJNS9QZEQrRzVDeWUxdFY1Rk9SSXRKY0pTcmZDYlQzdlNIbm0zdWI4OEM1?=
 =?utf-8?B?dHF3WGp3QU9vcDRsR3NwblkyRkJUNW1mV05kaHRIU1dLQnFZdVk3bmpSUlRQ?=
 =?utf-8?B?NTZTcVkwUHRVR3E2RFZ1NTM5ektZNlZzL293TURyUDMwRHFQZmJtZ1ppelhx?=
 =?utf-8?B?S1hLN0ptVWxNdmN3MXBKUHFoSHBuVm13UGdvVVUrWXpDUFV3dS82N21SWFFi?=
 =?utf-8?B?SFhhc1QzTFZoajd4MXRYVGg2U1Z5UnFGZlJVajY0aFpYeTlVYVdYRThINGlN?=
 =?utf-8?B?VXRBMjFZUS9sRUFTYkUyNXI2SmZnNXhGSXZHUVZXTDJIV2tKdGZUT3RaZVEr?=
 =?utf-8?B?bXJHVDhTSVZ1TGc4WU5lSXJYZ2thZnpFMHFsUTYvdFFGQy8weVJQeSt1c1pU?=
 =?utf-8?B?WEFtV0UwdENucmJDR0hHUU5kZWJrT2FmODNCM21TS00zVWQ5a3BobEJtTXBh?=
 =?utf-8?B?aExoVCsyUW1WdDJ1eU5PTlFjNk5xUWExcVVDV0sxMTN4dlhWekNScWQwSFc2?=
 =?utf-8?B?YXlabDVkUzRqS1grbDZTMHRIOG5WN09qajVYWmRiV3I1T3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjREcGo0M1o1L1Z1K0dMbkZqc3NaQ2I1SmFDL3pYRHhXWm52TXdNNzE4TFox?=
 =?utf-8?B?cktDOE4rMkJmYmNONmI1Y3BXVWQrKzlNcllkYmVKVXU1NUZwTnFFc2JvRzky?=
 =?utf-8?B?di9wRjZzem5WeC90azhxS1ByUThkTVR6aUp4Zm1WUW1JR2lUajNYcFNoNDNa?=
 =?utf-8?B?RVpRRFdyZFFWcEhYbkFVODl6aUo0NHZaeGNkV1d3M0dHV2hTWHI3WXlyRjZK?=
 =?utf-8?B?Q2V0Uy9EYlF1WElUcTZXZ1E3MDVCV1RMRGxVK29QK1RpbkRmWlFMWllwZFNj?=
 =?utf-8?B?cXJpamFZbWh6d05nVzI5Mmx2WUg4ajRBWFhKTGNlc2pOUFdBVXZNSUhqVVNJ?=
 =?utf-8?B?cTBxQVUwdVJScjY2UittczIzK1E1Vngzb2tBSmhYYnVyUk55dndWZmhmL3JK?=
 =?utf-8?B?TzhyRXpKR3dUbUFMaThjZ0Q4bEFRYWk0Z2ZYNFFiUENJeFBkZUw4Qk5hZzhG?=
 =?utf-8?B?bU5GZmJkSXNjVm5Vd2pOSlJGYVZBd3VoUzFwMk1id0xqR1JnU2w3TWN6UGZp?=
 =?utf-8?B?aXpzZ2FnT2Eydld1TStSR2dqSHNYUW1VcmJud3l6cEJnL3RDcnNCTDBrOWNF?=
 =?utf-8?B?K2o0TFJWcXk2K2hEaHZXS1JMaGhwMkE4TEJSVXl3Wi9BVW5uZ3hOQjU4VW1w?=
 =?utf-8?B?OENnTHZ1NDRKSlZJL0pqc3o1UExnWnR0aVVDOGZrMGtCZ1dmb0h5b0hKMS9Y?=
 =?utf-8?B?eGFINVM5SnBKeXFGQmRXZVR2NEVrdW41UEZ3ZDc0RDZ0SC9ieUtWN1NxVld6?=
 =?utf-8?B?VlY1cU9yaEMxTFIxVUsrOVoydlBUb2Q4bUhHbi9NYzVVY1V4UExiUm4ybndw?=
 =?utf-8?B?MWpQWTl3OU44bDJtZGtLNTZFcWJBU05yZ25DZlVvb1RweVdrMm5LaFRlYlhY?=
 =?utf-8?B?OEY2eTZXMWRON3hOdnJGZlo3U28wVEdXUjdSV05JMGR6aUVwVFV0UkwwelBB?=
 =?utf-8?B?aENYdkVuZHZJZi80OGQybEp0WU9ROUFEb2YyblcwZ3FTaTEzOXUvYnZTUGYv?=
 =?utf-8?B?M1lITlFrZy9xMTkrVGxaZ0VnYU44Z3J5blJ0bXVHQ0VrSm41L0c1d2grTlNI?=
 =?utf-8?B?WWhsT0Y0NnE1clhpenlGQW9LN29vQWJEKzVuMnVpS1ZXRnpVN0piZnBNaldI?=
 =?utf-8?B?N01IUGtqS1FqdGx6bGVGTDNLRlRMbVE2NE5zNGFxSFN4SHFGVW52U3l4Ujhq?=
 =?utf-8?B?Ymgva3ZYZElkZFN6Ukt2VVpHcUdldlpIaTZoUGtiZVQzdmxrMjhJejcxQ0xE?=
 =?utf-8?B?K2c2TVlsU2RnNnhzTm1yTFptYTdRMmJnRERRK1JJc05qbkRlT2duZ3RGTXI4?=
 =?utf-8?B?a2lyRy8wQkRDeFh6OENmSStTWFVIWEJuRXFwd2k2cjBudEdTaloxTk4xVXBq?=
 =?utf-8?B?bGxEVmgxZFpsVGZyclk1SlZqcU5sWXp3ejkzby9hOElETGlxMFZSWHI0OXc0?=
 =?utf-8?B?cmRVc3FrajhBdmpuVmlMWDh5bFB5UGdkcW1NLzZDMGR1Z3RpQXJUeldueGxr?=
 =?utf-8?B?NVlKTmpXNXZETTZmcVZiUS9RaVlJMFp1bmkzb0xRcitld1NUb25OVEJ2Z1Mr?=
 =?utf-8?B?emJkQVB0cFArelgvZzVBOU44SFA4MVZpNkxDVDBzNTBOTTlucWlnaXVGem9r?=
 =?utf-8?B?TTVIOHFCU1I4SjYvcjh2cW1Kc2VYdWdVZkRvTzV5MmpwL2NNYjRWd3ZtZ3ZK?=
 =?utf-8?B?L2l0emlWNU5LV1lwVC9wUmptVDRaQ2l1Q1lmeEVOdVNDbDlBU2tYaGYvUXNw?=
 =?utf-8?B?UXNWZkFYRHJZQUVkb0cxY1NMTXVyRVRuaVNZVUJRUW1SQ3VSaVVlVXJGN0Nv?=
 =?utf-8?B?TkVYUTNkNWhlRDQyUEVGNk9tcjgyRUxnOGticnM2a096KzZZZzFpUzExU1d1?=
 =?utf-8?B?YnhvTDBCM2dQMG1FQ05RODFoV2MxdEUvTlcyRGIwbkE2dmhsWXNhTlRRU3ln?=
 =?utf-8?B?Yzd6RmplaEhmQkhQOUp0ODBaTnFXVjdYT3F3dlBIcHRLeTY1dFNoSTNTSjZJ?=
 =?utf-8?B?ZzVWNEVDQ0ZLL2ZOM0tHWXNtLzZsUU1jSFJGN0dxVFVBNEM4TDZWTVNEWGFw?=
 =?utf-8?B?dmxyRktLUUxVUzViNzZOWGZkUVkvUkJuQzRrVnN2Qlk3WitlcmRVSDlvaVJD?=
 =?utf-8?B?VitpS0dwcDlXTmljbmI2MS9YakpLY2VIMjZPR0UxVkVnLzBsQkphbkxiRC9W?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nv2Np90UZ5J4Fh1tnX2n2mKJpEIa7fGuyi+/ks0SsRSL5/vTSK40oMRHu5ljdDhgOcfrcMO4O2Un5rOZ2HSx1mvYKtlfBGCdqrR9DMAAwX5XqHANPz4G8AxJpiZI2UHvofg4sfzXtTbvCadVQDjRGjHq7zZcygrbXTGjNCdjXVIUeBtG6dWCPWIOgwLKIOaRO7CBVd1cjr5g6N9bNqhqMDQTGEWlhE2/OV4jQdz9ZBpEEsdZ1VCiGPjdvtAmmvwXUNEi1BJjQ4gZNxrwatxCeyr1dp+kc3gxnt5R61zeb3RYoa1WuBs3Nedu5DsCFdghOFvVjZoBMB3aPdMvgbd0y6qWfte1gh3zjDBeuN7W0OAuobQOC/PCNKf9CBdLJekQ391mgBd9gPa/6xGYpWn7V0ISRsTvd2qEgeoGyliMCH+FNrB6Am4SP+GqRLUyZjq9bQk5sOuoGJhtK8LK//GNLVKcdM8gj/sYoNl33M61IMm72hM3LNYp+mZxa8ckLwUI6KmKzpXGfrDiRDzRcyMcuLbbAeJdRepZD12DI6/b9yGHN+OP4vRn9o4MX0gngwTgN/Ir+A5G6Rjb/btxqUT4bMmQFv3I90UoyOmhckbzIgQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4e86d7-fc01-44db-c623-08ddf20ba632
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:50:00.6589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkpZ2V2GQQ1XbrbxIG3Zhd3MMUwGr+SSg1etM5K2g1/+0+KYiuPU+dIOYNvtCW7DzWKwPa6sFECqNJ+G4XFbTBx+o6kiHZqnjlgNKOk8H4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509120137
X-Proofpoint-GUID: zKB0YdzyS1W8BpVtijPyJMgh2OHpIg7h
X-Proofpoint-ORIG-GUID: zKB0YdzyS1W8BpVtijPyJMgh2OHpIg7h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfX3pJBnV9iWxIH
 wnUEYfHTzLBIYTPqAO343lQOL9Q4fk66u4lRWJWwvw/W2GNEnzUHxBSRZR0gO1YO/M4UfT7e5sx
 mA4vN/s0cRvJaDnIhIIYdJrJDhodCANSKYdYEyE9pq+vfs/dVM8UF8hSBHPhhfvccabkMMrzBci
 pLOlsamR2KGOCTvsTFqFHm7KeFSs+ZMeW1EAramsQz1tnsgy+jheyyjHgttbKRV3V02v0qlMXF7
 P0sGP7GRYZV25+eCLN7Br7dE0LkeJOZ5jUheJnjfy2UQMkxSo00/zaIjs8DIrNaqcS+WU9qWAd6
 XbY+2xxASLOtM+XsOgm1RL8kCMGiZsUrJwuYUincUMT8M5UOz5vmTFtGharmRnLlaNIh7Qc7lTM
 s1VWDI7L
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68c4331f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=donITOIPcU3_ggj90i0A:9
 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 9/9/2025 3:27 PM, Peter Xu wrote:
> On Tue, Sep 09, 2025 at 02:10:14PM -0400, Steven Sistare wrote:
>> On 9/9/2025 12:32 PM, Peter Xu wrote:
>>> On Thu, Aug 14, 2025 at 10:17:21AM -0700, Steve Sistare wrote:
>>>> Add the cpr-exec migration mode.  Usage:
>>>>     qemu-system-$arch -machine aux-ram-share=on ...
>>>>     migrate_set_parameter mode cpr-exec
>>>>     migrate_set_parameter cpr-exec-command \
>>>>       <arg1> <arg2> ... -incoming <uri-1> \
>>>>     migrate -d <uri-1>
>>>>
>>>> The migrate command stops the VM, saves state to uri-1,
>>>> directly exec's a new version of QEMU on the same host,
>>>> replacing the original process while retaining its PID, and
>>>> loads state from uri-1.  Guest RAM is preserved in place,
>>>> albeit with new virtual addresses.
>>>>
>>>> The new QEMU process is started by exec'ing the command
>>>> specified by the @cpr-exec-command parameter.  The first word of
>>>> the command is the binary, and the remaining words are its
>>>> arguments.  The command may be a direct invocation of new QEMU,
>>>> or may be a non-QEMU command that exec's the new QEMU binary.
>>>>
>>>> This mode creates a second migration channel that is not visible
>>>> to the user.  At the start of migration, old QEMU saves CPR state
>>>> to the second channel, and at the end of migration, it tells the
>>>> main loop to call cpr_exec.  New QEMU loads CPR state early, before
>>>> objects are created.
>>>>
>>>> Because old QEMU terminates when new QEMU starts, one cannot
>>>> stream data between the two, so uri-1 must be a type,
>>>> such as a file, that accepts all data before old QEMU exits.
>>>> Otherwise, old QEMU may quietly block writing to the channel.
>>>>
>>>> Memory-backend objects must have the share=on attribute, but
>>>> memory-backend-epc is not supported.  The VM must be started with
>>>> the '-machine aux-ram-share=on' option, which allows anonymous
>>>> memory to be transferred in place to the new process.  The memfds
>>>> are kept open across exec by clearing the close-on-exec flag, their
>>>> values are saved in CPR state, and they are mmap'd in new QEMU.
>>>
>>> Some generic questions around exec..
>>>
>>> How do we know we can already safely kill all threads?
>>>
>>> IIUC vcpu threads must be all stopped.  I wonder if we want to assert that
>>> in the exec helper below.
>>>
>>> What about rest threads?  RCU threads should be for freeing resources,
>>> looks ok if to be ignored.  But others?
>>
>> These threads are dormant, just as they are in the post migration state.
>> There is no difference.  They can be safely killed, just as they can be
>> post migration.
>>
>>> Or would process states still matter in some cases? e.g. when QEMU is
>>> talking to another vhost-user, or vfio-user, or virtio-fs, or ... whatever
>>> other process, then suddenly the other process doesn't recognize this QEMU
>>> anymore?
>>
>> These cases need more development to work with cpr.  The external process
>> can be used by new qemu if the socket connection (fd) is preserved in new QEMU.
>>
>>> What about file locks or similiar shared locks that can be running in an
>>> iothread?  Is it possible that old QEMU took some shared locks, suddenly
>>> qemu exec(), then the lock is never released?
>>
>> Same as the post-migrate state.
> 
> IIUC the difference is "migrate" for cpr-transfer triggers migration only;
> another "quit" required to gracefully stop the src QEMU instance from mgmt.
> But for cpr-exec, it's attached to migration cleanup -> exec in a roll.
> 
> I'm not sure if things can be missing within the period.  For example,
> libvirt may have logic making sure "quit" runs only after dest QEMU evicts
> some event.  But I confess I don't have an explicit example of what would
> cause issues, so it's a pure question.
> 
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>    qapi/migration.json       | 25 +++++++++++++++-
>>>>    include/migration/cpr.h   |  1 +
>>>>    migration/cpr-exec.c      | 74 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>    migration/cpr.c           | 26 ++++++++++++++++-
>>>>    migration/migration.c     | 10 ++++++-
>>>>    migration/ram.c           |  1 +
>>>>    migration/vmstate-types.c |  8 +++++
>>>>    migration/trace-events    |  1 +
>>>>    8 files changed, 143 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index ea410fd..cbc90e8 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -694,9 +694,32 @@
>>>>    #     until you issue the `migrate-incoming` command.
>>>>    #
>>>>    #     (since 10.0)
>>>> +#
>>>> +# @cpr-exec: The migrate command stops the VM, saves state to the
>>>> +#     migration channel, directly exec's a new version of QEMU on the
>>>> +#     same host, replacing the original process while retaining its
>>>> +#     PID, and loads state from the channel.  Guest RAM is preserved
>>>> +#     in place.  Devices and their pinned pages are also preserved for
>>>> +#     VFIO and IOMMUFD.
>>>> +#
>>>> +#     Old QEMU starts new QEMU by exec'ing the command specified by
>>>> +#     the @cpr-exec-command parameter.  The command may be a direct
>>>> +#     invocation of new QEMU, or may be a non-QEMU command that exec's
>>>> +#     the new QEMU binary.
>>>> +#
>>>> +#     Because old QEMU terminates when new QEMU starts, one cannot
>>>> +#     stream data between the two, so the channel must be a type,
>>>> +#     such as a file, that accepts all data before old QEMU exits.
>>>> +#     Otherwise, old QEMU may quietly block writing to the channel.
>>>
>>> The CPR channel (in case of exec mode) is persisted via env var.  Why not
>>> do that too for the main migration stream?
>>>
>>> Does it has something to do with the size of the binary chunk to store all
>>> device states (and some private mem)?  Or other concerns?
>>
>> It was not necessary to add code for a new way to move migration data for
>> the main stream when the existing code and interface works just fine.  One
>> of the design principles pushed on me was to make cpr look as much like live
>> migration as possible, and cpr-exec does that.  It has no issues juggling
>> 2 streams, and no delayed start of the monitor. cpr-transfer is actually the
>> oddball.
>>   > It just feels like it would look cleaner for cpr-exec to not need -incoming
>>> XXX at all, e.g. if the series already used envvar anyway, we can use that
>>> too so new QEMU would know it's cpr-exec incoming migration, without
>>> -incoming parameter at all.
>>>>> +#
>>>> +#     Memory-backend objects must have the share=on attribute, but
>>>> +#     memory-backend-epc is not supported.  The VM must be started
>>>> +#     with the '-machine aux-ram-share=on' option.
>>>> +#
>>>> +#     (since 10.2)
>>>>    ##
>>>>    { 'enum': 'MigMode',
>>>> -  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
>>>> +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer', 'cpr-exec' ] }
>>>>    ##
>>>>    # @ZeroPageDetection:
>>>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>>>> index aaeec02..e99e48e 100644
>>>> --- a/include/migration/cpr.h
>>>> +++ b/include/migration/cpr.h
>>>> @@ -54,6 +54,7 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index, bool cpr,
>>>>    QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>>>>    QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>>>> +void cpr_exec_init(void);
>>>>    QEMUFile *cpr_exec_output(Error **errp);
>>>>    QEMUFile *cpr_exec_input(Error **errp);
>>>>    void cpr_exec_persist_state(QEMUFile *f);
>>>> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
>>>> index 2c32e9c..7d0429f 100644
>>>> --- a/migration/cpr-exec.c
>>>> +++ b/migration/cpr-exec.c
>>>> @@ -6,15 +6,20 @@
>>>>    #include "qemu/osdep.h"
>>>>    #include "qemu/cutils.h"
>>>> +#include "qemu/error-report.h"
>>>>    #include "qemu/memfd.h"
>>>>    #include "qapi/error.h"
>>>>    #include "io/channel-file.h"
>>>>    #include "io/channel-socket.h"
>>>> +#include "block/block-global-state.h"
>>>> +#include "qemu/main-loop.h"
>>>>    #include "migration/cpr.h"
>>>>    #include "migration/qemu-file.h"
>>>> +#include "migration/migration.h"
>>>>    #include "migration/misc.h"
>>>>    #include "migration/vmstate.h"
>>>>    #include "system/runstate.h"
>>>> +#include "trace.h"
>>>>    #define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
>>>> @@ -92,3 +97,72 @@ QEMUFile *cpr_exec_input(Error **errp)
>>>>        lseek(mfd, 0, SEEK_SET);
>>>>        return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
>>>>    }
>>>> +
>>>> +static bool preserve_fd(int fd)
>>>> +{
>>>> +    qemu_clear_cloexec(fd);
>>>> +    return true;
>>>> +}
>>>> +
>>>> +static bool unpreserve_fd(int fd)
>>>> +{
>>>> +    qemu_set_cloexec(fd);
>>>> +    return true;
>>>> +}
>>>> +
>>>> +static void cpr_exec(char **argv)
>>>> +{
>>>> +    MigrationState *s = migrate_get_current();
>>>> +    Error *err = NULL;
>>>> +
>>>> +    /*
>>>> +     * Clear the close-on-exec flag for all preserved fd's.  We cannot do so
>>>> +     * earlier because they should not persist across miscellaneous fork and
>>>> +     * exec calls that are performed during normal operation.
>>>> +     */
>>>> +    cpr_walk_fd(preserve_fd);
>>>> +
>>>> +    trace_cpr_exec();
>>>> +    execvp(argv[0], argv);
>>>> +
>>>> +    cpr_walk_fd(unpreserve_fd);
>>>> +
>>>> +    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);
>>>> +    error_report_err(error_copy(err));
>>>
>>> Feel free to ignore my question in the other patch, so we dump some errors
>>> here.. which makes sense.
>>>
>>>> +    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>>>
>>> This is indeed FAILED migration, however it seems to imply it can catch
>>> whatever possible failures that incoming could have.  Strictly speaking
>>> this is not migration failure, but exec failure..  Maybe we need a comment
>>> above this one explaining that we won't be able to capture any migration
>>> issues, it's too late after exec() succeeded, so there's higher risk of
>>> crashing the VM.
>>
>> exec() can fail if the user provided a bogus cpr-exec-command, in which case
>> recovery is possible.  exec() should never fail for valid exec arguments,
>> unless the system is very sick and running out of resources, in which case
>> all bets are off.
> 
> I really don't expect that to fail... bogus cpr-exec-command is more or
> less a programming bug.  After all, I don't expect normal QEMU users would
> use cpr-exec without a proper mgmt providing cpr-exec-command.
> 
> Adding some comment here on what the FAILED can capture (and what cannot)?

Will do.

>>> Luckily we still are on the same host, so things like mismatched kernel
>>> versions at least won't crash this migration.. aka not as easy to fail a
>>> migration as cross- hosts indeed. But still, I'd say I agree with Vladimir
>>> that this is a major flaw of the design if so.
>>>
>>>> +    migrate_set_error(s, err);
>>>> +
>>>> +    migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
>>>> +
>>>> +    err = NULL;
>>>> +    if (!migration_block_activate(&err)) {
>>>> +        /* error was already reported */
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (runstate_is_live(s->vm_old_state)) {
>>>> +        vm_start();
>>>> +    }
>>>> +}
>>>> +
>>>> +static int cpr_exec_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
>>>> +                             Error **errp)
>>>> +{
>>>> +    MigrationState *s = migrate_get_current();
>>>> +
>>>> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
>>>> +        assert(s->state == MIGRATION_STATUS_COMPLETED);
>>>> +        qemu_system_exec_request(cpr_exec, s->parameters.cpr_exec_command);
>>>> +    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
>>>> +        cpr_exec_unpersist_state();
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +void cpr_exec_init(void)
>>>> +{
>>>> +    static NotifierWithReturn exec_notifier;
>>>> +
>>>> +    migration_add_notifier_mode(&exec_notifier, cpr_exec_notifier,
>>>> +                                MIG_MODE_CPR_EXEC);
>>>
>>> Why using a notifier?  IMHO exec() is something important enough to not be
>>> hiding in a notifier..  and CPR is already a major part of migration in the
>>> framework, IMHO it'll be cleaner to invoke any CPR request in the migration
>>> subsystem.  AFAIU notifiers are normally only for outside migration/ purposes.
>>
>> This minimizes the number of control flow conditionals in the core migration code.
>> That's a good thing, and I thought you would like it.
>>
>> The alternative is to add code right after notifiers are called to check the
>> mode, and call cpr_exec_notifier.  Seems silly when we have this generic
>> mechanism to define callouts to occur at well-defined points during execution.
>>
>> Note that cpr_exec_notifier does not directly call exec.  It posts the exec
>> request.  It also recovers if cpr failed.
> 
> OK, I don't think I feel strongly on this one.
> 
> Initially I was concerned at least on some of the notifiers not invoked,
> which looks to be completely random.  But I kind of agree you chose the
> spot late enough so whatever should really have been done before an exec(),
> should hopefully be processed already, maybe while we do or around
> vm_stop() phase.
> 
> Feel free to keep it then if nobody else asks.
> 
>>
>>>> +}
>>>> diff --git a/migration/cpr.c b/migration/cpr.c
>>>> index 021bd6a..2078d05 100644
>>>> --- a/migration/cpr.c
>>>> +++ b/migration/cpr.c
>>>> @@ -198,6 +198,8 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>>>>        if (mode == MIG_MODE_CPR_TRANSFER) {
>>>>            g_assert(channel);
>>>>            f = cpr_transfer_output(channel, errp);
>>>> +    } else if (mode == MIG_MODE_CPR_EXEC) {
>>>> +        f = cpr_exec_output(errp);
>>>>        } else {
>>>>            return 0;
>>>>        }
>>>> @@ -215,6 +217,10 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>>>>            return ret;
>>>>        }
>>>> +    if (migrate_mode() == MIG_MODE_CPR_EXEC) {
>>>> +        cpr_exec_persist_state(f);
>>>> +    }
>>>> +
>>>>        /*
>>>>         * Close the socket only partially so we can later detect when the other
>>>>         * end closes by getting a HUP event.
>>>> @@ -226,6 +232,12 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>>>>        return 0;
>>>>    }
>>>> +static bool unpreserve_fd(int fd)
>>>> +{
>>>> +    qemu_set_cloexec(fd);
>>>> +    return true;
>>>> +}
>>>> +
>>>>    int cpr_state_load(MigrationChannel *channel, Error **errp)
>>>>    {
>>>>        int ret;
>>>> @@ -237,6 +249,12 @@ int cpr_state_load(MigrationChannel *channel, Error **errp)
>>>>            mode = MIG_MODE_CPR_TRANSFER;
>>>>            cpr_set_incoming_mode(mode);
>>>>            f = cpr_transfer_input(channel, errp);
>>>> +    } else if (cpr_exec_has_state()) {
>>>> +        mode = MIG_MODE_CPR_EXEC;
>>>> +        f = cpr_exec_input(errp);
>>>> +        if (channel) {
>>>> +            warn_report("ignoring cpr channel for migration mode cpr-exec");
>>>
>>> This looks like dead code?  channel can't be set when reaching here, AFAIU..
>>
>> The user could define a cpr channel in qemu command line arguments, and it would
>> reach here.  In that case the user is confused, but I warn instead of abort, to
>> keep new QEMU alive.  I perform this sanity check here, rather than at top level,
>> because I have localized awareness of cpr_exec state to here.
> 
> The code (after this patch applied) looks like this:
> 
>      if (channel) {                                            <------- [*]
>          mode = MIG_MODE_CPR_TRANSFER;
>          cpr_set_incoming_mode(mode);
>          f = cpr_transfer_input(channel, errp);
>      } else if (cpr_exec_has_state()) {
>          mode = MIG_MODE_CPR_EXEC;
>          f = cpr_exec_input(errp);
>          if (channel) {
>              warn_report("ignoring cpr channel for migration mode cpr-exec");
>          }
>      } else {
>          return 0;
>      }
> 
> IIUC [*] will capture any channel!=NULL case.

Oops, my bad, thanks.  I will re-arrange it:

     if (cpr_exec_has_state()) {
         mode = MIG_MODE_CPR_EXEC;
         f = cpr_exec_input(errp);
         if (channel) {
             warn_report("ignoring cpr channel for migration mode cpr-exec");
         }
     } else if (channel) {
         mode = MIG_MODE_CPR_TRANSFER;
     ...

- Steve



