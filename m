Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076ACC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 17:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaHEb-0004ky-7N; Fri, 11 Jul 2025 13:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uaHEX-0004kT-Hs
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:08:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uaHEV-0008Je-7s
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:08:25 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BGmbRI001043;
 Fri, 11 Jul 2025 17:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=NTJh0ML2eS58Z00IJhOXmb8H2Gvo9DJWUm3l2BNBMzA=; b=
 UKYZ68HYTZfGcPp8i5IHbqfTABRtcHj8sENPnBIiUJxG7xnW4M2fIawfK6OoHhr/
 LnZD7X2lMPyhvEIkg4G8SkalDtmNrDcfyaggl3HPSTh+rXfQiq10iBH4M+/8NF7s
 CHKiy12mDlZ2MSRg0yu/Fq8bTHr0BAVeLOBwHrq/HiQ5QLZzqk0joNcUetXJ7mO8
 AoAI0dd5U62YCy1u51BPD00R0WaOiHa7+hlcS9ZnsJlPsqU6bAOx/fV5eX0Kd15l
 3jZHha6kyPSlZDcktjhR2Ype2QQcS3S+ASREgauzGZhrMW0TP6ZMdzkfaZqPplJC
 eCPRKmpXLjBRjS3otx9iVA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u6edg1bj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 17:08:16 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56BFfjdl013997; Fri, 11 Jul 2025 17:08:14 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptgduff2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 17:08:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xanYe4L6/z/8pp4L8o0EPkC+oHn/7ta/C9mtoRUl1wrF3ZChhbBgR6Nsps78c86iXz/xqA75oFy/XAbhejeCJyeMiyd+aygibAJgQKtItwFWgMe9P3kCFKhFiinyq08iHEwugZUnxUYaBq47wtrVO8a7OsLPdkG2jbYlCyv8PuMFGYL1Xkc5JitzI8eaFGPLYHi1l+XqvtrbIjrUgfmBVTN9AW12/oK1TAQmrldiCvJSgkQqUB4H/VG8kr8mqWee0UULC1/j45sv+sMzPnLj7WuxNvPI3ZoHBuJrrov2SguObzg5UVwzWy/lWMYMDlQ7wfgJuAuWCe9oIw42EfKRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTJh0ML2eS58Z00IJhOXmb8H2Gvo9DJWUm3l2BNBMzA=;
 b=CERkxQ0mZqipMWhxcFuEa0qvRS3RzlKd980/3sCfSkOXnuEkStqn4YU1CyIeFTeasyDI/J2Zz5yE1u6TUWwpbXZvA7Fly7x9p44Lo3pPMfVaKkmWqkd7hdGsBS+3TR6a3ocEmFzNz3QOg5C8tujdbUnLRxUK3BpoOkji/xLpu211sfspjdr7YDYG0p0MZE2w0bl0S5ehJtrhGnZA1kJyki9s0ymDgtF6DrPLg8ho9VmdY48BmL8ZB9A/w5ScZzp+r1fLS5JAS2MCxpMQyQIB/WVQXeiKfRJsxz7Uzz6g+ZTC/SX6HLMPyqeuNx9yZD/X25OKdZ7mkfOZaOGZezFmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTJh0ML2eS58Z00IJhOXmb8H2Gvo9DJWUm3l2BNBMzA=;
 b=Xj0eZRH8F0HjRWE7VNNJBvKjs/yjNPT0lu4g39UT6C88aSxFX06Fo2ZKJ4ibny1nNlDbU/C6EjjUglafgnPpxsrB6IVz99eRhcb5I76FRK/drhiogx9FyFHWQrIYWj6fiYADo0yczuNSDWVSSugoHMkswIWpI6WRlVpokLYJ7AA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BY5PR10MB4194.namprd10.prod.outlook.com (2603:10b6:a03:20f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 17:08:08 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 17:08:08 +0000
Message-ID: <dc8d4159-2ede-4d40-a6b0-f09f5db4a044@oracle.com>
Date: Fri, 11 Jul 2025 13:08:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/3] python: use qom-list-get
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>
References: <1752164694-215567-1-git-send-email-steven.sistare@oracle.com>
 <1752164694-215567-3-git-send-email-steven.sistare@oracle.com>
 <871pqmwzqr.fsf@pond.sub.org>
 <a84a1482-4ba4-4520-b875-9b3a9a879868@oracle.com>
 <87ms9au0xv.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87ms9au0xv.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0120.namprd07.prod.outlook.com
 (2603:10b6:510:4::35) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BY5PR10MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 651c335b-4120-4136-9da7-08ddc09d825c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amRySEs3UUpKeFRNcXNQR3djbklPQlY3b0R6VlBQTkwzRlRGVktRaTdsQmlz?=
 =?utf-8?B?dGQxdGdFVTMyWHRHOWJPZTZoRFp4VnBodi9tNFVZMExyT0tSYUJOSlVSNmRs?=
 =?utf-8?B?TXRHWlRCUk9SaTBnUVNmd1pkRDkvTUt0V2xOaTYrRmxadEpoSVRPSFVsY3li?=
 =?utf-8?B?YVdFaTBtSm94RHFZTnYydkswOUxiNXpoVW5CWVhtYlBZT0dHclBudUdJakRz?=
 =?utf-8?B?ZE43VmdDemhvY2U5dXdWeDlXaVQyYjhvbDYwc1dwNGxTR2k4SVhjOTg3ZzJL?=
 =?utf-8?B?SHd1dTFSL0p0VkZpaGRpejJkUGNxeHRrQnN5dVd0aFlNUFFHUGxPeWJrQ0ph?=
 =?utf-8?B?NVdpS3pmMjVjcTlQdlY4TEM3QWpFZjlMc09kQlM5R29QWDdxbmtrRXlMSmJx?=
 =?utf-8?B?MzF1TDRhVXBzMUxHWE1haUtVVi9IVGkxSGMxMHBVSTJaTDB0RlhoOUdvaGpQ?=
 =?utf-8?B?eUJ5ZEpOVzlHdWxEd0xNYXpBaEdpR3MwbWpFOTRjcmtuanFSN0wzd3puK2x5?=
 =?utf-8?B?UHZZVDdXcTdNSXNIMWtlRXJhaDRnenJqaWxXQmxoRUYyLzh0bXE1azNIMFc5?=
 =?utf-8?B?SlhmVGZpU201SkRNZjB2US9ZVWdVTjE1bHdpSnhtVkt4V1NrQm1NdVc1MFo0?=
 =?utf-8?B?alA5R1JRWjU4a1pWenFWQmN3N2RodE9lRjRsV1VVa29LZHgreTNlVEUxNjU2?=
 =?utf-8?B?NkJEbjJZaHk3QW5GUVBDeHp3azByWjl2QzNFRCtOSmNHeTJ1Wk43T09YTUtm?=
 =?utf-8?B?SmlZV0dhcDZra1ZlSkhzSHVGTnJaWDErUXZCSldBL2J6QW8zTVNFZzk5NVN0?=
 =?utf-8?B?UUNrQ2dHZzU3WnR2bGVBS2FBWmpLQ1Z2ZEM5MVI3N1RXTmpkVmExNXVxS0xK?=
 =?utf-8?B?V2tQMW5BZ2ZIMEtjekRoRXU0YWQ5RkdvUTJ1UUNBVERSekFmVGxqd00yRXJF?=
 =?utf-8?B?YXZNeVQyMzhHNGJFcXB5MzVYREphV3VZYUt0KzIwOHBCVjRmNFd0a3FpVHI0?=
 =?utf-8?B?TWVlWWE0anZKZ0VvWE1FRzJVQko4T2ZsbjVMVmhKdFZTMytjV1hOZTY1YnFJ?=
 =?utf-8?B?eHJYSHU0NzBDZlZ5U0VrRTA2RnQ5TDd5WkxKaSt3RHVJKzJEdkZuaGhRU3dR?=
 =?utf-8?B?Z1J4MUFvTStMZERHdkk5UGZMQm1pNDhyK0NqNDBUUXZiVUVvaDJmWkcvcm9x?=
 =?utf-8?B?c2x0K1p0b20zakJqb0dhMHNURHdhUlhDWHlqNnBMNFRzZXVEU1RObGdybEZy?=
 =?utf-8?B?b3ViSDlkRzErVUJSZDdGR2VRZzUyV0pNb2g2RURuZGZxd1ZUWVg0YlZ2eFl0?=
 =?utf-8?B?dnZpTHhJS1ZxaEo0RHF4ZmxNOE1kMzJoSDNzT2VsQmlNd3dMNy9zdjk2MC8v?=
 =?utf-8?B?MW1EZ0k1a3hBdVY1WlFmdERCYnhPUXNFNDgxV0lrVGVyakZhd0NNUWtUaVNZ?=
 =?utf-8?B?Y3BzVzhkQ01yMk00bEo3VjVJcWtLekIxV2R0WVRLaU1DTFpGUWt1elY1TEti?=
 =?utf-8?B?WWt6RzhzUFo3YTRCYXBzeVdsN2wzZ3FNWTdoVlR6bzc0cWc3UzFWWGNPeG5t?=
 =?utf-8?B?WUZrR3lJa3hrU3lIZjhVdnFqendScDZuVWdsOERCTUhBRDA1UHdVdGJEY3Z4?=
 =?utf-8?B?WXFXNDlBQWNkTWRNN0ltV2VSelY0eTJTUVB0VXU2bE5QVmJoaFVsRGVJZXR4?=
 =?utf-8?B?TVI4dXZuRDZoWHpFTDBad1RJcVBvalJwVFJUZjdIRTJERTRidCtRSDRMYW5a?=
 =?utf-8?B?V0Mrd1hkQVFqaVlFem1sSTJqZWlyakR3N2xnNGJWY2pNVjZweThNMENaWG5X?=
 =?utf-8?B?ekc3L09EQ2V1RWFyekFWdzJnc3ZFUnArS2Uzd2MvUG5hT3hPZnhIYmdCcXMx?=
 =?utf-8?B?SHpXSzVncGRYOXhwRUhMZkFOYVo0K2s5OE12alhBamMyVHpDZ3lNcHhzSUZB?=
 =?utf-8?Q?Hg7S2iWzgwM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjBCeTl3dGRQTGVDeWFTTHljcksvMnFiRHBjbUc5UTZ6S0thcHJLaFZudmxJ?=
 =?utf-8?B?STFLSk4vVFVmem85S0UzSnQ4K0MrQUxOc2ZiSUc3dE5wN29GeDdiSVZXMWlm?=
 =?utf-8?B?SzAxSHhFSktsQWh3VzQwQ05NbzBUSW1JOW8wb1pKZmVrOXlxcVBvdGx4VnNP?=
 =?utf-8?B?UmZtbDBtTTVkalBPRXJkNnBRM1Zwcko4SHBJR0Q5ZHZacE8yeGliL3JoU1Bo?=
 =?utf-8?B?V3ZJZWY3K3lOTXF0TW9VRVd3L2VJQ2dFcXBIVUJsK24rT0U0ZUIzUmNLbUt0?=
 =?utf-8?B?aUhmdTV4U0ZYKzZ1K3BJNzhDWk1UTzVRT3phd054NjBZd1NsNEZpc1pYUFRk?=
 =?utf-8?B?ZUVyY1pPZ05xd1ZkYmdjMGp0bGJISzk0VDdreEx1UWt2UytYMWRrcnRqeU1u?=
 =?utf-8?B?SGlPeU41d0ovbjYrTFdlSDlmZHlOaDREYVJuSHVwZTg4bHcwWGVrUHZ0Q2Zh?=
 =?utf-8?B?WVA0SUJlM3lnNWZNVjdNSlFKR0dPWVhCMDZqVUZHS2JUTVpYTWxkQjU2OFBz?=
 =?utf-8?B?SExGTE1waFR5ZitRMHpYSXVFQWxLUWllb0swbXNEMWxXWTdKYUV6c1V5NG4y?=
 =?utf-8?B?TGdJaVcrK3p3UjdHWnYzdm9BdkF0R2dLVkVQZ2U4Mm1uUzc0Rm12V1RXTHRp?=
 =?utf-8?B?cEhpSkt0T29CcUZhbkpXdnJWRHE4RGtFckNsVUwrdmpWSFRpNUNxNWJDS1VY?=
 =?utf-8?B?em8rdUJ4TEttZExGd3UrQ2FyTVBrNkdUZUFLYVZOU2ttWWhoTENhZXFwWCtO?=
 =?utf-8?B?T3Q2OFhpVE5pV1MxNWFwSWZHeHNEM0RKekRpcmpHd0NwSHVBQU41RW5SaGhC?=
 =?utf-8?B?RUVLSGxOZUpLVGYwOUYxckk1UEw5R28xVWMyNUhCSjJPczRtQjBBUmxDTGVj?=
 =?utf-8?B?bUs4ZTF2NndBb0xnUnNtTUJUQkFoeTFYMmVSUDdBSUlOVFNGVWNLUFRqWHAz?=
 =?utf-8?B?aW1BOVlaNFpYT1JvTjBGeXIyVldjdHpoeFBXTmpiUTdlanYwaGdFQjVYWUJO?=
 =?utf-8?B?MjlzdStSTFhBL2hnZVAzU0hHcjNrUVg0emIzeXhLZ2RkVmFabHBRelhTM2Mz?=
 =?utf-8?B?S2NCUXVHbDlHYmwzRitGV2V5NzdTamZLdVA2MjdrTDA5aGZGd2REZ0JLUFB1?=
 =?utf-8?B?ZGZCYkhuQkpqbDRpMkpxR0o2LzMvb0o3WjN1cHlOR3dacjlCTXVxWkwwVEFH?=
 =?utf-8?B?NnBGVG91VDNTa3JrYWtxOGowT0ZxOEVRbUhLRFk1cTVwL1RGV2QrSG5HRFhK?=
 =?utf-8?B?VWh6K3c1K3FDTnR0Y1g2VlFQUk9ncVduS2l1ODRpTDdOdkpnT3M2dXVJWjBM?=
 =?utf-8?B?WWdMYTVzcWhnUWl3VUFkcStrZEtOMTRPbWY0QkI3RnNQdk1NOHJvYm5DWngz?=
 =?utf-8?B?TmFiZk5vMit2WkE5RE9XMk05VElQajV3VWp6clFjL0RndXZrdDdJWGNrRlJo?=
 =?utf-8?B?cXE0Y0c4disyd3ZJUE9FMHFPKzQySk1UVUZyc1ZoTVBUUUdlOUNMRjYrSzA3?=
 =?utf-8?B?UTBhT2pVWmQzN1l2bERjV3FwVU9RTlVUeU55UGNpaG9aWFpEOTBNaFJtRFh6?=
 =?utf-8?B?MyswRVNYQittZ0VNOWxzWDBQeU9abnl0RkQ1Q0dFcDhCWFJiMFNtUjhBcDBB?=
 =?utf-8?B?dmpXbkRwa2xqWG1iWmEzSkhYMHVWUkJSVGgydXpGWlJuOHNYNk15OVBSWUVM?=
 =?utf-8?B?bGZOdEU4eFJVeCtaUGlLdTZXSEVDOUVTd3kra21UbnNzNDBzSUFPekVMKy9v?=
 =?utf-8?B?ODNFM1VuZHhRQ3lUaXc4eTU4OWdsbmk3V2xnWFBldWFXcWR6YmR3d0dPcXFl?=
 =?utf-8?B?OUdhaXlod01TRTJwQUhxOXpnS1QrSUhBc3lRNHNsTWQ4cUZJdWI0OFVlZG1v?=
 =?utf-8?B?bTNxTnh2OFFXQXhxeTU5a0FTOTZxbVhKb2M0L2FOZVFaVWxMUTlZN2x3MVVJ?=
 =?utf-8?B?M3A4MGM0Y0Z5ZGR4dlZxaWFObk1jcXAxVmFvWG5TWmdxNEZBaUx0TnMvSFpT?=
 =?utf-8?B?dEFKZnJCd0lpTlMrMXBtenpwOHhrcjRhOUZzMWtSZDYzRUtpVkFTelE2MXBR?=
 =?utf-8?B?a0hYNHdLZjk2ZWRRblVxbU9ibGQrK1A0VXVwR2lQd05FWlAxU3RqQmF0N1hN?=
 =?utf-8?B?RTNXQW55bEIwNTdZNjdBZWY4RnB3VExwTThSQWdoYk9CMjY5bFhpVTRwbDkv?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MtrS+m+EGzT6D+2DQxF2qBVobKzTrYu6j9zumAMFpt4DbWGkDGWfHaqy4w+aXvkxhEbfdA44htvJt3zPdmIhMlUxPAEje/qa2320vyamoBHci1dUOweR4WRq+3hEWo3IxnDey7Ys1p8qd2OV25IRc3rtLqChXfdl3VO64IJn80BFEEI3eSZTwDzIS6vreKx5MSR5yZ8bVCbRJNMQYDuW6xbc/Qt2Z24BT8S3jVx72nyEQEORXipJWQzL8shKeVI9axwoVnDahJ1fKOlzbk1ReNCD/Eic2iiEVd3kXuWIxkZet1jnMkVrNT5ZVl1bSGencyn7KAMMagU5u4Qh4tewQgKxuvzrXfD24QPU56QlBIkiwGCt2x6wEtiv7ZEgvYR1bsL+OlrWNf9t0LJ34r6vLkKp2hrYb0FjFpaEjtYvWewzEOvUYa0P8r21OGe9AQrhdd5JST3xIV4qlhdD4Uexk2MRpHXVWLJVQGdsCo3hbExe7AyO7oWaEXWoYNRXLignocqo0gvZ2jrZ+9VragGuQ5ZAkwyf2l7XdZ7zZQ9giJ0bERle2SVGqQHFyV1/x9Zd6mU3WiG7KrEFZm4TTfP7QgGTihsk8WTN4YDWKTA9mIE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651c335b-4120-4136-9da7-08ddc09d825c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 17:08:08.7439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MH1Bi9UAibVCxloTH1SBD7c3lwma3RlDVQbzUxZCXnT0DLIuZAbskSechEjQPVTH5g8R/HeDyf1aBEdAx3qT2RbZUlwz3bROkRIM/YRENA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4194
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507110125
X-Authority-Analysis: v=2.4 cv=RNezH5i+ c=1 sm=1 tr=0 ts=68714500 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=4xpN2H3N8j9PmCVnCSAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12062
X-Proofpoint-GUID: EZmbPSnunL8spmnviEGgLwUhTDv7wYAy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEyNCBTYWx0ZWRfX0Iu5GAMvI9Ca
 njhm0kqYIZ4/iyEo7klGEdIoQUpXs311M7lrzG9BxAkGD2/KR9WWLLdPZSjG4N+18DoBc1Xn/AN
 G5kt0OsuhrE42o0+W8HCskSuqsYoWY8Lk3U/ZLkUwl6VswExmpkVA4XueTocib/oU9UlTOPlQsW
 i7UgZmD580LfzeHATuC+1eH+BmD9MlLYZAuRfshGFquH1kw+KPcai73yClOG7Gvm6rcPiXPXY5L
 vWJK/7susl9jHjcYgL9oWPdyHocXORMzVnl933YSsak+ifVdxIaUE8i1RBw0yEWcWHk2dsc44Xw
 l6/Ah/T2AFFCYeF8EnUAM8ZmEUvWAwwVw6xUN8bUoVMVl6TQBr8SWxYs0HgT1siYDblKMsjX3Fg
 YG0HAJzrBte054QnDGB7krOZcS6ZWn81YFQtJNzXZv/j1cRRU+UhGs5sUt92G1K2pS+CHwJE
X-Proofpoint-ORIG-GUID: EZmbPSnunL8spmnviEGgLwUhTDv7wYAy
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 7/11/2025 12:50 PM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 7/11/2025 10:47 AM, Markus Armbruster wrote:
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> Use qom-list-get to speed up the qom-tree command.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>
>>> Quick test...  Differences in output before and after match expectations
>>> (see appended diff).
>>>
>>> New version:
>>>
>>>       real    0m0.446s
>>>       user    0m0.062s
>>>       sys     0m0.017s
>>>
>>> Old version barfs a stack backtrace (appended), and is ~18x slower:
>>>
>>>       real    0m8.176s
>>>       user    0m0.395s
>>>       sys     0m0.126s
>>>
>>> Did you see the stack backtrace, too?
>>>
>>> Regardless
>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>
>> Thanks.  Do you want a tested-by credit, or is that too little testing
>> for you to stand behind that endorsement?
> 
> Tested-by: Markus Armbruster <armbru@redhat.com>

You can add that when you pull V5 into your tree - steve

> 
>> I observe the same expected differences.
>>
>> My test did not backtrace.  Must be a different VM.
> 
> Let's not worry about it.
> 
> [...]
> 


