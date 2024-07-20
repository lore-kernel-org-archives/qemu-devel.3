Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD43C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 21:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVHaz-0008Vz-Qd; Sat, 20 Jul 2024 17:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVHax-0008U6-6v
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 17:26:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVHau-0007o2-BO
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 17:26:22 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KLFYHX023636;
 Sat, 20 Jul 2024 21:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=G9vBRQEPxZ+QtlCo0Y1jjYdkkcyukjP+5CeUaLyZZ9Y=; b=
 WMXqbGoG8zxwszWLATWDxp5MGq+GikpCo4Z42baJoMKXO07/61i/VWqU3MXmObjH
 NS2hinl3e/ETwzRxOi1YpUfBLTpZLcgpNAnEN2V+EFNGFhLsJkYV1yoaKYOgE1cr
 WUDWwCZYAC6KsSsPfYEKiPeNthEg1H83tTSZxbuszC/yrmXX//sm7ShW866xDCgV
 Q+YWyDizYgbOFP+iy/PXZsU0KqgTkL/FW2w3Xf93DesijoKUwcTWtfuKEp+1/V70
 TMJqAb/VjE6q4r8ld3y+fpFpfuz8ddoCrBSk7FkXHdOpKqgNC8UyQpe9Jspbt2hF
 Ijfh7Ji/wlwKQW4iy88f3Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gn05g07p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 21:26:16 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KIMhJX024450; Sat, 20 Jul 2024 21:26:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3p609mb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 21:26:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nz2yI+M7PVu4Dm8I1e3hFBrXTtaczXDCMFNg5gaKo1v68yN4jPd676jNr0yGDr9e4bMvDrv68okOAyqlj2vBEE8Djk0OupJHX4I643pQGOoMGaqypHI6KU0C55jP9icWVGpph/LwVnC90FmzVV/ojw6+otdUdGxgu3HJ52gZyYcXHqeaN8T6Ny0ufYgfw8ER8DRbNQy4nrY1GkoZqtcjPvsj+ZQdBHYFkFGHgbG40Qgf+52NkOVwgtdjxQxSECWwKp65XdLvtxCtxp3Ey63yRGreZvC1AJCfOnS22gx6K/5Bd2SguC2Djzx3QNT0unE4qD6UOh31x3CztW0pWC3Ynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9vBRQEPxZ+QtlCo0Y1jjYdkkcyukjP+5CeUaLyZZ9Y=;
 b=QsECwIaOpbpaRvD/ch3eHGxqD8b4ovrNY82/JcgIon63BagtnEAxGen+REO9r54yew++QhTQkfaHVCvHpQrceVNyy8d1DJsCPTsNs5RJLP2JkBP9Hyh9mvLOMHd7p60ihMlh/ORvr2S2h0VBSTJAcnOeQnqbWDVumQlN9Lpgds5KbwO5Xh4YOH1Gkma4Uk9XcA836UDLu0BEMG2sPYs3IkMZHSIrUQ95NqA3lNJeF8DV5BsO5+8jgW6jJMIogysLdoQQbrWfXaklwSgJmKHTtYcWAuO/gtE1l3sfNFU8zAmQviBHrs54PID6smM8EyXRtXPt2X/IPc2AZ+Febbp4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9vBRQEPxZ+QtlCo0Y1jjYdkkcyukjP+5CeUaLyZZ9Y=;
 b=Ox7F7mZ+xUfwdmwEWGO3V3xyX9iynQj57D1l74YNiO77GktyqUqmNDksE4pseNSTUjiw7f7GpG6xjVu6xApnYLcnYw/YWyTA9KEHanUVQA1Hsnga+n6e1zjJ9rmp++pMpvt7MNbpJmzqbcEowbPSBTim7aNs6z1whikfdqli7RU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM3PR10MB7946.namprd10.prod.outlook.com (2603:10b6:0:4b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.17; Sat, 20 Jul 2024 21:26:12 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7784.016; Sat, 20 Jul 2024
 21:26:11 +0000
Message-ID: <4f6200fa-c052-4295-b71a-c6deca11db9f@oracle.com>
Date: Sat, 20 Jul 2024 17:26:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <Zpk7Mf2c7LiNV2xC@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zpk7Mf2c7LiNV2xC@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::17) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM3PR10MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 409d9996-6333-46ed-0d12-08dca90293fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVYrL2t4d0dsVk95dDFmcjUzNlBRM0lGZFBhcHhFSks2NTc4SHdjU1hmb0Jy?=
 =?utf-8?B?ZmpUU0RQYTNBZ0ljazBJWW9vRlJTbDd0TDBJQmU5bzlkNmxyRkFBTUtLYVpL?=
 =?utf-8?B?Yml5cDNpeW1IL2VSOTdaV0htTXpPWmZtcmd2dG1icXloUnlXa2lFaElnZ1Jy?=
 =?utf-8?B?WjlRYVdCQ1VaK3I2Y0FkbW9yQjhBMzR2SGlRVzNScmM1SC9wTlNxdHFtVG1W?=
 =?utf-8?B?bDBkWHZrbkF2WXdYbGhlZFBJSTNlSWlOcUNGQ3NDRnMrMktFQit5cDZKdWlU?=
 =?utf-8?B?anhQcnkvRU9adUlDay9mQXVXYWNxMm94S0d6cFhXcWlkakhjbXdsbWg4SnBZ?=
 =?utf-8?B?OWcxa3krVlE1d3JqTXdENGVlV1ZEMWlac00vbXlGWUMvTStyTWFSemdEblBk?=
 =?utf-8?B?QWczbnNVVU1ncys0L2xoVExqcG5RbGNycVV3NDBnREsxOGJRb0FMR0VMR0V0?=
 =?utf-8?B?SmNuVU5mOGdRYktWK1hwemFmb01lSktnd21kVkhmT1pmTjczSWRqc09tckJt?=
 =?utf-8?B?dXRXV09jbHp1MGVkalVtUXd0VG5NNXdwMU5uVWxzZU5CS2N2bzROaEo3L1FL?=
 =?utf-8?B?RXk0YWRVRGc0b1hkSHhtcHk0WWIrcTFSbzVRWGpVS0tQdzBGaHY5aUFadm1H?=
 =?utf-8?B?SlBEY1N4cGtDZXRkU3ZpendGd1JwVm1jVnQ1WFpiTUVxTkRHRk5kbmFSTjhj?=
 =?utf-8?B?eGpadkdoYWk5Y1lqcE5kZkMxSHZ4RXcvYndpdDJnSm9qL0g1am9GQk1tNytO?=
 =?utf-8?B?RUJUVmRBWi9oYU15YmNNWTBJZ0p0ZjNXcXRvNkJXcXJ2MVFJOE50TXliUUR5?=
 =?utf-8?B?WFdrWnhUYmhNQVQ0RnJoeXJOWW9XS3g4UDVzMmdKMVpjcXJtUWtuM25LY01n?=
 =?utf-8?B?dk4xVnB5SUhIU2F4ZUtucDJQcUh6SHJrdEp6dGpRZzE5QjVvL1JuK1RkdStP?=
 =?utf-8?B?OGkzeDRDb04rWEFHdkhtWGx6RlNHRDhsVzhiVVVNdi9NVURjVHdrUVZRc3BE?=
 =?utf-8?B?dmxlS05iR2wrY1UzUTdOSzJyTWh4YXJyRStPcUxGZGR3U1ltMFBTU25XcFIx?=
 =?utf-8?B?bjQyY2lYckUxNEx3aC8vdjZLQ1lTTitXMGFmOXpTWGp6SUZUL3Bwc1hDaTM4?=
 =?utf-8?B?R2M2QlVqK3lIREg0aUVKc2owL29nNnNUS1NWV2FxTVZhK0E4RkZES3FRMk1u?=
 =?utf-8?B?ZGlXbHpqeUNvZVV3cE81T2Z0QVVSM25wVXZ0MVpMdDZMZFV1YjV2bkY0aVNu?=
 =?utf-8?B?M05YMTgwZVBmUHRoSDFIdUtNd1FzRnV1aW5hV2dCanljaGhvQUlEeGxHL0dn?=
 =?utf-8?B?eFNrQ2d5TmFzWEg1SHhhSXd1dHg0bkZRRnpvNi9CU0dQSGdrZURaQXZjWjRD?=
 =?utf-8?B?elVJdHNWd3BUUUJtWjBveG1xK2lobDJzamZWdlFkRUtTb1JWZm5vMTR6YjM5?=
 =?utf-8?B?MVMwUUhiNk1VeHlDNWVtdDUzZmdvZVhlbGhaRGo2RW5Na1dUZCtVRTFTRmU2?=
 =?utf-8?B?RFJFUzdOcFpWNzc1NWdLVEFqcnp4ek1PYTNqZFJrT0dqNzhCYUtNSW9qblFE?=
 =?utf-8?B?NWVFbzFNWlpadWMvWkZCWDFSd0c5aWl2eXNCQ29VUFpGSDZzWm5vcWhmTXV5?=
 =?utf-8?B?LzhpYmY2b1d0bkg0cENyb0ZPL1NLSFJvL01DZXRPNzlLWitiaWdXZnFvKzRN?=
 =?utf-8?B?OGhnY2tJQ0lzbU1aSWNCN0RZU3RURFh1K2xCVWVtR2dyalpPekludjFXQ1F3?=
 =?utf-8?Q?NXaGi39DyXxrZjFVxQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVVOVzJzYzVKVW5ZWHduQktMVEJVcGJZVnhaTVE2NlNXZkthR0ZWblR5VUlt?=
 =?utf-8?B?MXB4a1Q4dVJoSEVHMjFVN2VVaVNmS21YeGgwVk9NdlorTjV1dTUrakVlUGM2?=
 =?utf-8?B?NEY2WisyUFU1anJnc1RLWWZ0TGNWTHhIU3h0MjQ0aDl3T00xVlVTL2djVUpq?=
 =?utf-8?B?SWk0RWVFQlhRRkhhLzQxbGlEODZaTTMrdjBnZUdhSzBjSjFSYXV5enVHNFhw?=
 =?utf-8?B?QjZ3TUlOYUpJaEVzQmpRZnFpTTN5K2N2Y0hubWdlQVoyQWp0QS9uWmMrQ210?=
 =?utf-8?B?MHVlZE8rTC85LytheEwvcHBhR21HZUpGK3FHVjFHZ0oyVjhpUmZ0U1MwV3Bt?=
 =?utf-8?B?RmpqdHZ6WFFHRGprYjlueExCcFRheSs2dG1peWh2SnRFK2Z5NitKYXpwVitG?=
 =?utf-8?B?c2VZYnI2SG1TTTZNTHo0WnczRjJVRUQzUHFncFJPenc0cEQwNExMRzZ2ZGhQ?=
 =?utf-8?B?N3FBZXRWdmRvekgvMUMrdElad2dLYjdjRXdpT2QrajNXaVJTZmJIU1BkYVV2?=
 =?utf-8?B?NzFTSXZnOWNOU3dTRW9PVE1hdWhyaFNWZWcveFJlRG84OXp4ZXJ5L2l3S3Mr?=
 =?utf-8?B?Zk5weitEWGRLZWJnbVkvdmM1UzJIdVZsQ0JjZXVMa21odExMU2JCaE4zeEkz?=
 =?utf-8?B?cUswQlNKQmI2U2ZtdXVNYmlsalYxMnVvRDluMFZ2MzdTelNCeWNYb2piMURZ?=
 =?utf-8?B?eE0rVjNONDlBQ0MrZW02cTRNQlFIRFdWQWROT1Z4QjA1YXVoN2c2cHp6a2dx?=
 =?utf-8?B?QXRGZ0dJWGkyUnoyclBXQ0lzbWU5QVpWVTRiVzNZY3I5TEU1bVQrUmZHSGR3?=
 =?utf-8?B?Z1RTb3pCMEFMWGJrVVcvaFBMT3FNbkRrVEREaEFoYWlnUW5JdHBhbVdVU1oy?=
 =?utf-8?B?a0xGczgzSmtaakV6YUtjQ3R5aUVaRmtCek02L3RKU3BrTGoyQllOT2RMSmkr?=
 =?utf-8?B?WmpJMnB6bHluTE1OS0pUTFptbkZhRWNudXhUZkZidmN1ZVhNZ3pOMU1ka0g0?=
 =?utf-8?B?RkU0OFJ3MDZZVWlJN2g2djk1MmpBOFpEVHF4cmQwY2NDQlNDOE1yVUFQWlht?=
 =?utf-8?B?NXVJSE1MYTRGNzBkNnR5V1U4TzgyTitPdlNLQnVlYXpqQWN1Wnc2bllaNDVL?=
 =?utf-8?B?RkZzZ3BpOXZUbXR5M2lSOUdQYXN1QUlkZ0RnbVJlTm1HMmM2S2xYb0dUYWx2?=
 =?utf-8?B?QnBHUlhUSHUrcmh6dUx0MVhYVnJkY1lFRVlSeVNXUHNlYnNhMUg4QnVFZUti?=
 =?utf-8?B?Vm84eW1jOUVkS2FYV21ObkhudWNsUmNIWUdkcVdVQ2txeGdjQno1L3ZXNkVl?=
 =?utf-8?B?S0RoSGVkOTArc3NIU1UrMG5LSlBmYml5aHMycWF1QjhvWGhGYU5HbVFPQk5R?=
 =?utf-8?B?YlZvbElyMVhmeGQrT2IvZWowbVUxaWx6Y0pQKzNkZnBuaTBTN1F5WTFYNlN3?=
 =?utf-8?B?c0xYK2h1NWk2Q1A3bm1OMnk5N1FmbWhYd0JFVEEzM0duTkZyTW9nQWlVL1p3?=
 =?utf-8?B?bXlMU1BxbENHcEdEWmVrVGtud1MwTFB5Tkx0N1VRRVREeEZZYWVTTDExNW1B?=
 =?utf-8?B?b01oV1pRQUV3RjM2Zkt3ajhJbUwyOWxrR0h4bmNLWDFkKyt5dUVpQjVVME9C?=
 =?utf-8?B?aWcyMk9pd0piQ0hFRWg1MTQrYkVJVGJXQTFPTXgweFVMTWpucW5tZnZyc2FB?=
 =?utf-8?B?cTdpZ3VyV3JRL3BNWWRCZ2hlWjVieGN6aFhabk1pV1U4Mm9Vek13OUJ1UnV6?=
 =?utf-8?B?NWtDTmpTWW8xNkR2UVNEU3FaMjBXZ2JqQnlKV0hSMEV4M3JUc2U3cXlrVklT?=
 =?utf-8?B?UHVNdDNQeUxFcUVITzRBMjdQM205SnArUW53ZlYxa2psZHRIUWxmOEk0MDZs?=
 =?utf-8?B?WWhIRjVWWmFXbWo4MXBkWFJ6eVNjVW95Uk1rcXBsRTg4Vk9XaXNUU1lVRCt0?=
 =?utf-8?B?M2JwTU9NQ05rMHVqWmdEQXp1bnZIYTFhRTAzRUMzYVJpaGVKUWJwaUFUL3d3?=
 =?utf-8?B?Uk04YVl5NVpUSXZWcW5HVkRLS0VPaGE4RXdSRHA4Y0Jicit5ci95N0ZCSGRG?=
 =?utf-8?B?eENvS1l5K1VnMThVZ09reXVQKzlBVE1YTHBoN3lRVVJsNnQvMXVRT2FncFBa?=
 =?utf-8?B?Nmt5b0hTcElyeE1UcTV4MEwraGdxWjNVOUMvckdzMzV2SldvbEg3VTlCTkN4?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: izIGGNmUJGfDnHEWwTLIpXfUfJ/HkW0eAZeYTzvqhx8t5KZ1z4NlIsIPaT3DMdEhozfEldW1kwILjvxhoveOr+P7hqzHlsW082YVvWH3RRDB2ckT73AVPysa0WnDtF5E/mIey9R4I32hmPu7XJjbwKgJawtlw2UiHPLFcJzHjXYePGsCXWlWyUbbSbOtSwsbj+7zsxz9fg6DCyIWe1MCLGd8BA60EjhUGRFvU8Hx09SLZRG2JkLrLA7rZtskHSvBaKn1SdhZVKplly3Td/nXjfgdQs/cMmt1cSY1+FcTIk8PZSK0niW1Dg56Uwk8/vMiEHpKT+A5G/25H7TTgVQgBvHUx6wBz53Rw/JGh3zJsdVJHMlmdqRU9LtAjAqr+2oeNQye6J8yA2SPCLIUrKWtFI+aMKF9EX5MFBlDZsUpTZ7jXJM+g9g35QupGqWk/TVPE651DXHt7UZsKP3i//nYPq5ON6pRAe6wuo5Nz8uL8YYLekHxGRIzY8DEXVOlWFjCEbLcZh/MIaC7dwyo3uPhMFNtwZKoFzyMoJv5FMTm8TZYDoe+WEsYci3k2dvqu04mFyogu5QVb/9288nmypAEe9gePo5q9YQW6w0/av7/ms0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409d9996-6333-46ed-0d12-08dca90293fd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 21:26:11.9204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykGsoLWxUAYEBr4UlZ91SiQ9jDOKMeJzxu+6A9/wHnxYjIbAAV7KEHAPwU6vB4Ul2nBBN5PAAkBpKVhInjSdRZVsRVd5NXpQhi25hhDgu4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_19,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200157
X-Proofpoint-ORIG-GUID: j0O-Xy4b1T69YdBtsQUB2KOOSezFHdKD
X-Proofpoint-GUID: j0O-Xy4b1T69YdBtsQUB2KOOSezFHdKD
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/18/2024 11:56 AM, Peter Xu wrote:
> Steve,
> 
> On Sun, Jun 30, 2024 at 12:40:23PM -0700, Steve Sistare wrote:
>> What?
> 
> Thanks for trying out with the cpr-transfer series.  I saw that that series
> missed most of the cc list here, so I'm attaching the link here:
> 
> https://lore.kernel.org/r/1719776648-435073-1-git-send-email-steven.sistare@oracle.com
> 
> I think most of my previous questions for exec() solution still are there,
> I'll try to summarize them all in this reply as much as I can.
> 
>>
>> This patch series adds the live migration cpr-exec mode, which allows
>> the user to update QEMU with minimal guest pause time, by preserving
>> guest RAM in place, albeit with new virtual addresses in new QEMU, and
>> by preserving device file descriptors.
>>
>> The new user-visible interfaces are:
>>    * cpr-exec (MigMode migration parameter)
>>    * cpr-exec-command (migration parameter)
> 
> I really, really hope we can avoid this..
> 
> It's super cumbersome to pass in a qemu cmdline in a qemu migration
> parameter.. if we can do that with generic live migration ways, I hope we
> stick with the clean approach.

This is no different than live migration, requiring a management agent to
launch target qemu with all the arguments use to start source QEMU.  Now that
same agent will send the arguments via cpr-exec-command.

>>    * anon-alloc (command-line option for -machine)
> 
> Igor questioned this, and I second his opinion..  We can leave the
> discussion there for this one.

Continued on the other thread.

>> The user sets the mode parameter before invoking the migrate command.
>> In this mode, the user issues the migrate command to old QEMU, which
>> stops the VM and saves state to the migration channels.  Old QEMU then
>> exec's new QEMU, replacing the original process while retaining its PID.
>> The user specifies the command to exec new QEMU in the migration parameter
>> cpr-exec-command.  The command must pass all old QEMU arguments to new
>> QEMU, plus the -incoming option.  Execution resumes in new QEMU.
>>
>> Memory-backend objects must have the share=on attribute, but
>> memory-backend-epc is not supported.  The VM must be started
>> with the '-machine anon-alloc=memfd' option, which allows anonymous
>> memory to be transferred in place to the new process.
>>
>> Why?
>>
>> This mode has less impact on the guest than any other method of updating
>> in place.
> 
> So I wonder whether there's comparison between exec() and transfer mode
> that you recently proposed.

Not yet, but I will measure it.

> I'm asking because exec() (besides all the rest of things that I dislike on
> it in this approach..) should be simply slower, logically, due to the
> serialized operation to (1) tearing down the old mm, (2) reload the new
> ELF, then (3) runs through the QEMU init process.
> 
> If with a generic migration solution, the dest QEMU can start running (2+3)
> concurrently without even need to run (1).
> 
> In this whole process, I doubt (2) could be relatively fast, (3) I donno,
> maybe it could be slow but I never measured; Paolo may have good idea as I
> know he used to work on qboot.

We'll see, but in any case these take < 100 msec, which is a wonderfully short
pause time unless your customer is doing high speed stock trading.  If cpr-transfer
is faster still, that's gravy, but cpr-exec is still great.

> For (1), I also doubt in your test cases it's fast, but it may not always
> be fast.  Consider the guest has a huge TBs of shared mem, even if the
> memory will be completely shared between src/dst QEMUs, the pgtable won't!
> It means if the TBs are mapped in PAGE_SIZE tearing down the src QEMU
> pgtable alone can even take time, and that will be accounted in step (1)
> and further in exec() request.

Yes, there is an O(n) effect here, but it is a fast O(n) when the memory is
backed by huge pages.  In UEK, we make it faster still by unmapping in parallel
with multiple threads.  I don't have the data handy but can share after running
some experiments.  Regardless, this time is negligible for small and medium
size guests, which form the majority of instances in a cloud.

> All these fuss will be avoided if you use a generic live migration model
> like cpr-transfer you proposed.  That's also cleaner.
> 
>> The pause time is much lower, because devices need not be torn
>> down and recreated, DMA does not need to be drained and quiesced, and minimal
>> state is copied to new QEMU.  Further, there are no constraints on the guest.
>> By contrast, cpr-reboot mode requires the guest to support S3 suspend-to-ram,
>> and suspending plus resuming vfio devices adds multiple seconds to the
>> guest pause time.  Lastly, there is no loss of connectivity to the guest,
>> because chardev descriptors remain open and connected.
> 
> Again, I raised the question on why this would matter, as after all mgmt
> app will need to coop with reconnections due to the fact they'll need to
> support a generic live migration, in which case reconnection is a must.
> 
> So far it doesn't sound like a performance critical path, for example, to
> do the mgmt reconnects on the ports.  So this might be an optimization that
> most mgmt apps may not care much?

Perhaps.  I view the chardev preservation as nice to have, but not essential.
It does not appear in this series, other than in docs.  It's easy to implement
given the CPR foundation.  I suggest we continue this discussion when I post
the chardev series, so we can focus on the core functionality.

>> These benefits all derive from the core design principle of this mode,
>> which is preserving open descriptors.  This approach is very general and
>> can be used to support a wide variety of devices that do not have hardware
>> support for live migration, including but not limited to: vfio, chardev,
>> vhost, vdpa, and iommufd.  Some devices need new kernel software interfaces
>> to allow a descriptor to be used in a process that did not originally open it.
> 
> Yes, I still think this is a great idea.  It just can also be built on top
> of something else than exec().
> 
>>
>> In a containerized QEMU environment, cpr-exec reuses an existing QEMU
>> container and its assigned resources.  By contrast, consider a design in
>> which a new container is created on the same host as the target of the
>> CPR operation.  Resources must be reserved for the new container, while
>> the old container still reserves resources until the operation completes.
> 
> Note that if we need to share RAM anyway, the resources consumption should
> be minimal, as mem should IMHO be the major concern (except CPU, but CPU
> isn't a concern in this scenario) in container world and here the shared
> guest mem shouldn't be accounted to the dest container.  So IMHO it's about
> the metadata QEMU/KVM needs to do the hypervisor work, it seems to me, and
> that should be relatively small.
> 
> In that case I don't yet see it a huge improvement, if the dest container
> is cheap to initiate.

It's about reserving memory and CPUs, and transferring those reservations from
the old instance to the new, and fiddling with the OS mechanisms that enforce
reservations and limits.  The devil is in the details, and with the exec model,
the management agent can ignore all of that.

You don't see it as a huge improvement because you don't need to write the
management code.  I do!

Both modes are valid and useful - exec in container, or launch a new container.
I have volunteered to implement the cpr-transfer mode for the latter, a mode
I do not use.  Please don't reward me by dropping the mode I care about :)
Both modes can co-exist.  The presence of the cpr-exec specific code in qemu
will not hinder future live migration development.

>> Avoiding over commitment requires extra work in the management layer.
> 
> So it would be nice to know what needs to be overcommitted here.  I confess
> I don't know much on containerized VMs, so maybe the page cache can be a
> problem even if shared.  But I hope we can spell that out.  Logically IIUC
> memcg shouldn't account those page cache if preallocated, because memcg
> accounting should be done at folio allocations, at least, where the page
> cache should miss first (so not this case..).
> 
>> This is one reason why a cloud provider may prefer cpr-exec.  A second reason
>> is that the container may include agents with their own connections to the
>> outside world, and such connections remain intact if the container is reused.
>>
>> How?

chardev preservation.  The qemu socket chardevs to these agents are preserved,
and the agent connections to the outside world do not change, so no one sees
any interruption of traffic.

>> All memory that is mapped by the guest is preserved in place.  Indeed,
>> it must be, because it may be the target of DMA requests, which are not
>> quiesced during cpr-exec.  All such memory must be mmap'able in new QEMU.
>> This is easy for named memory-backend objects, as long as they are mapped
>> shared, because they are visible in the file system in both old and new QEMU.
>> Anonymous memory must be allocated using memfd_create rather than MAP_ANON,
>> so the memfd's can be sent to new QEMU.  Pages that were locked in memory
>> for DMA in old QEMU remain locked in new QEMU, because the descriptor of
>> the device that locked them remains open.
>>
>> cpr-exec preserves descriptors across exec by clearing the CLOEXEC flag,
>> and by sending the unique name and value of each descriptor to new QEMU
>> via CPR state.
>>
>> For device descriptors, new QEMU reuses the descriptor when creating the
>> device, rather than opening it again.  The same holds for chardevs.  For
>> memfd descriptors, new QEMU mmap's the preserved memfd when a ramblock
>> is created.
>>
>> CPR state cannot be sent over the normal migration channel, because devices
>> and backends are created prior to reading the channel, so this mode sends
>> CPR state over a second migration channel that is not visible to the user.
>> New QEMU reads the second channel prior to creating devices or backends.
> 
> Oh, maybe this is the reason that cpr-transfer will need a separate uri..

Indeed.

- Steve

