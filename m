Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E730EC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwqK-00053V-73; Fri, 14 Feb 2025 09:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwqI-0004wE-07
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:38:58 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwqD-0000jO-L9
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:38:57 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtSa3001893;
 Fri, 14 Feb 2025 14:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=8UmXcQoNq1f0ELQBGb7wHDMOHBfKl5aJ4WurcP5OptA=; b=
 F6VWolqpURYnc+O2YvyaE1rkKqcPRnz9Do1HEaCYeMWKyQkNyrj2kwhKWvgibAOJ
 O91OsSds3diAyZ2I7INCYaisWKfvTrvNkuvKmQ7cLizedbk1RzGYEi9X6h3q/+r+
 i+PhVXCbSogcGC7XlAB8SjS3LDo8CwkZdP6AT5q8a1fYI/qSSu4VsiUFfCCmzjcP
 9mgqiZmLrljiutBI9Q/V+4vSgeLWIF65OH2ROdmfGyKjELNLMbyoe4XE+CjLBgd7
 IY2Qcge6iH0clNKtE1FGk5nY7tE6omNbjLhlCaGPnMX23BSWxTmJ+9jOFefZwJ5s
 tzlG7oSPJSf7l+MuJNYZ3w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qyuuf5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:38:46 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51EDe4tc001112; Fri, 14 Feb 2025 14:38:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44p633np6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:38:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eskCNQ9Pa9RXboVYpNGnGAwXcUITwbVfIBHQwNfW1JmPEUMdMgiJeMbZjlbKOKSxtz33mAGFZ7EOhRLtbY1NFR8tQXmYxvrHXEv8Fx8usC3zwrNhNuLD9PJhumeycoYbjPJoBG+D2ayETGG8xcLsjBrVn6J8BUrkM8R1GSvqYR5+vyn1tEarZ94dsJ+JFOlI5PRiG/rxyY8bFS4l6iblDLI8DTz/xnJhsmR3YucXqTiMymg1jgO5iLZmr1kmtpjZk8ri42pHj6PwXtU2e6XIpHi7TmJEBn3rimFfIFUElN09QZKeaX4BiPkqwkLG8W3hk4h7d78JYSRzeIAmFmbxkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UmXcQoNq1f0ELQBGb7wHDMOHBfKl5aJ4WurcP5OptA=;
 b=G3dXv8Ut3c9jYiJoYYRvY5VRvgBBWkHVwdQ3ZjWAkzbvd9TgEmSy0W+rja+Dauab554MpGEYcAjTAWWDxujOEDXBGrspO3QOkKEd7LrERG8y3M0IN0vd/z41IgViP9r8iqEz95W5ugXuySJIPIxk6T/nJAoBIzhguGU6g4f9Uf0C4WpC3dAthzCuO7aM7CGRu+gLEgARHM2Y6USwiYtri1iKhiwNUF8T8Vq0A7ep6keezx9LbjHYxxu/KGaXrvBVtMtGVZ1v6sX+8kY9X6xDema+7VsVLzJDIHE3xL7EKlCsfKvPN3xB7B1tUqSG+Wkp1YeNe5Lm6q+2fVzJ2nU+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UmXcQoNq1f0ELQBGb7wHDMOHBfKl5aJ4WurcP5OptA=;
 b=hrqmKzQ1ADo5XID9jy4yXihQohex380rrYzy9QKkBpJxdINNMsNr5wGZeHUpZZxZOK9YDYWk8zZBflFtPUbMmK7DeB3IqcnLeM46qXpkt3g7ilIj3IdLYk4Ru3xE6so2C6H10x1HMYKHKewU2qeQj8R5Lf1DLJAFZRNhdBDXUnk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB6555.namprd10.prod.outlook.com (2603:10b6:510:206::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 14:38:42 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 14:38:42 +0000
Message-ID: <52a6a93c-a6a5-47de-8a81-6da5d5612e4c@oracle.com>
Date: Fri, 14 Feb 2025 09:38:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 28/45] vfio: return mr from vfio_get_xlat_addr
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 "Philippe Mathieu-Daude\"" <philmd@linaro.org>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-29-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1739542467-226739-29-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0088.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::29) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: c3512872-25de-49f3-8a13-08dd4d054737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3pwelVaV0ZGdVlOc3FScGI2ZFRkRVZhdzVYcHYzMGZrOWswVzdvK3pwYk9D?=
 =?utf-8?B?M2Mwb0ZDQlZPQkJoVUtpQUd6Yk1aRGZiZEpBeGhCdFRXbUt3MTJ5dU40UmJY?=
 =?utf-8?B?OXFxNU1IUGkzVkY4cnRjR29McGY3WTVoWlQwaXF6aDZnMWxjNzQvTWZKK1U4?=
 =?utf-8?B?bU1hdTk3N1ZycGtMMUYyZUhpQmpWd2ozamFMeHJsOTU1VmZ5eUwzSGg1NGw4?=
 =?utf-8?B?SmRkUUdUU3FDQXhCeVlvcmJlUjFoaTZoKys0WXUxSXh3MmIrK0pDeUgxdllL?=
 =?utf-8?B?ekFwZTlKblFHYjY0NVkrek1KaENKK2xsVVdrRWZkUmJEQWVNa0doQ0xHTEl6?=
 =?utf-8?B?ZE5ITStxU1dZMEVwNkJFaG1xMFRiZG9jYlg5eThGaExESHg3NGVJOGxUVHhY?=
 =?utf-8?B?NlI4TzJkZ29nVm9aY1daekZpSVF3L2pwSG9Ba3R2TUl5VlVPYTFBd0FZemo4?=
 =?utf-8?B?RVFYYXVYOGxmQ1pUa2l5aXMydk5EZEovcXl0NHRnRi9NZEwzc3JudGIzZG1V?=
 =?utf-8?B?OXNMNUhtL3J3YnZYSWVHK1RUWlphZXJCRFRwRU0rTjhmOStrQVI2Uk5CdTJG?=
 =?utf-8?B?NkVHb2cwMWRqbkNFY2NzWlJURzJ0WE5zNWlNUVNVU0JpMUpSR0N5RStELzJo?=
 =?utf-8?B?ZVQ0OXpSWmdUN3gvRFh5TW96QzFuRVRwMDhTNU9BRHFRVVNuNnNEa3J2b3hB?=
 =?utf-8?B?RDg0S1B5NWJIVG1jOEVuS0J3c0RYZDdBSFl4MWM0WFBkNmRiNmFzd3A4NU5z?=
 =?utf-8?B?aWFOTCtqblE4WmJQaFdkbHlTaXdZR21VMmFIL3QzUEIybEYxMmJ2TkRNNStP?=
 =?utf-8?B?UDNycG5qT2lmYjlmVWJickQwVDYvc3BoS3k2QXJSc1BsN1JDMlZOZ1BFR2li?=
 =?utf-8?B?R2JBeDhrSXFIaUNlTEs4eTc5WktKOEJwMWptVmp2ek04WnlQWm96Rk9yYUlp?=
 =?utf-8?B?My8weFU0ekNUa0dFWFFhbG5NYk00VzdSOGZlNFh1aHVDVlFoajJlNjRoTGZu?=
 =?utf-8?B?cTl0UldlR3c0dWVndkZrKzAxTzZaVlk1Ykd5eTdhZ0RsN05VVlU0M3JWK1hy?=
 =?utf-8?B?K2xIa1NkU3RzdE9qVmkvYnJWTjMwRTZlUlM5WUF1UG1HOW5jUHo3VTBRK0RB?=
 =?utf-8?B?UlpWQlJ0SkxTQnV1dzl3c25VVUlrSHZRWDIxS1VNQTNxckE1WS9mSEFrL3BP?=
 =?utf-8?B?OHNTdkRPeGRJNjJML0JwbUVEK2JZU292N3lVOElnREl5ZU9MemJrYVgvWkhK?=
 =?utf-8?B?eEc3Wk1SSFdNdStHM1F3MmFrcUVDOXVpT1c3YnJqOVZpUjY4ZkhkMzgyTUhP?=
 =?utf-8?B?eFppQXVabnFqUTJ6cTRBd2pCNVdmeVpzZUNYUkR3T0d6dmFIYm1idGEzYkhI?=
 =?utf-8?B?NWJkNUUwaHoxWUw1aFBxRVVkWksrYVFqMXVRaVU2WEpnQkE4dStjclI1cDZq?=
 =?utf-8?B?aGpLYW1GK3RNWHJBYjNmbmhaemE0QzIxSWlqcXNIbER0NWs0MnNxNUMwT2hW?=
 =?utf-8?B?cVFwSCt2STdIUVlDWmdsTDlZN0dUMFN6SjhEZnZqTTUvRmcvZm0wM2I3Z0FL?=
 =?utf-8?B?S3dyUEtYTHRxZUdtZkdRSjI5blgreWR5MytmeUpxNGhnd05UNUU3SHgxTm5k?=
 =?utf-8?B?UWJ0Z0lPV3RYZ3hjeXNKVEVKQVNhMjVjUDNJTEd3ekR3eDBzK3RYSFNjdnQr?=
 =?utf-8?B?ekdBYit4RTRWMklKeEVzOFVXUG5MbVNnVllscHJxbWVaMElCZmwzU3FNMUlJ?=
 =?utf-8?B?bTBZY3dTVWwwVk9FN1hGaUpSUkJvcHp1ZHU0cDN4UGFtOFdNRE1GSUs1cEZo?=
 =?utf-8?B?TDdjMzZ6Zy9WOFhmVlVxWjA3OUlqdEthLzlGK2h3R2I0S2VFQWN4VHZkS1JH?=
 =?utf-8?Q?PtpeJTOX7XYx7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czh2YWxvbk12QjArNHVTQVpqSllsT0NYM2RDT2Nwb1Vzc2xLeTVzME1HWjRL?=
 =?utf-8?B?MGhBd3pjbWRQTUd4UlhBaXFCMnlodkxoYlpqMU9WUDNmV0pFK096TUhBWU1X?=
 =?utf-8?B?M0o4bkxCMFpTbm5PUHVDdkJHTlo2SVJXV3dXTzdIMW9zN2I4cGNDcjlOb1I4?=
 =?utf-8?B?ak1DUFoyNDA0Mkt5cUwrdXlsMStTZVAxdUhpcGx5U3ZRY2RnRTYzNWNpUnFC?=
 =?utf-8?B?WlR3aU1ZdzBjQWR2Q0RMK0tZU25RR1BEWWlhVUwxNVFOWWcxVXY2SUFQV2Y2?=
 =?utf-8?B?UHRPZ01NbnIwcDlmZUw2YnllNXkyTHBxMzhhTHMxTUdQNEgyYzEwQXFGNmRo?=
 =?utf-8?B?dVZwVk9FL3Q4aXVRVG11NjNoSUsyOTI5clJqdGdBOENDSEpxTCs1VzZ4dFd5?=
 =?utf-8?B?TGZHUnNZaVFLMU9hWFhjejZNbkY2b2dKRGZNNUtwKy9hejdWZzloVndaN1Ev?=
 =?utf-8?B?eUtIOFl3OTFhYkExS3hGQVdnSFpxTHFCWlc1U2gyYXh1d3pzaFFGdFliWmxT?=
 =?utf-8?B?Y0NnUHp5VzEvVVY1eVJrNzVTUjdQczVtdXdyYXFUemc3L0p2Y055MDhpYXp4?=
 =?utf-8?B?ZlhPMlMwOHdUME9oQ204V0xhNnhHczRYK2IyUW5PVnpLaS94SXdzUmh2OWFE?=
 =?utf-8?B?T1Jnbk01TjJadG9nSVNJN1hISXBoRjcwKy8yNkZ5MHBjY0RJdFRQSmVHQTVU?=
 =?utf-8?B?OENPQUhIbmIyZzlRVEJ3QW1Mb3hJMjJMcUVLZnVSRzV0ZnU4ZlY4Vi9ndnFH?=
 =?utf-8?B?eFlteVBiQkFNaEJSdDNBRDNWY0RRb3VxR1pnQVhXa2ZKWHovYWJ5QkQyZzlN?=
 =?utf-8?B?cmVLcVlYWEpSZ2FhWXpjSlIybUQ4a3MyMUJDcXJicUxGci9jMHlaTjFtNkMw?=
 =?utf-8?B?a2ZxWllxN1pzL2d2SHI5ZG9iUEd5b0xnaVZTTVFHUGVORmtkL1ZzVE5LMlNa?=
 =?utf-8?B?RDBOZWplcVB1dEN0OTl5NVVpSTRSbG1BR1EzRU1zdlFKd2E5WEI4MkNXRnhS?=
 =?utf-8?B?d3ZVTHFleEhrdjZHK3JLaWNQQTJqRnZjR2s5VE1lTzhldUhZdHlqa2FNVVRs?=
 =?utf-8?B?REcwNGJYMWVPY1hsbWZDZTJRUkxGbEpOZCtlL1FKTzlncFpDaE0rS09pTFpz?=
 =?utf-8?B?bFpGN0NBam91R3VKQitBakhMMGdFcWxkYU02MUtnTWQzUDkycUtCT0x0alN5?=
 =?utf-8?B?aGJMdWhGZ1ZGNTJSbjFxZTh0Z3dXNU9JcHdiMjl0MTE1Z3ZNdExsSWh2M3ox?=
 =?utf-8?B?b2d5clI2cXlWVW0zd0Z3Q1F4ODN6c1BGOFMramppSCsvNlBzUkQ3VFdwMmoy?=
 =?utf-8?B?R1JIUnkyNUszM3ZLaEZhNVBjUXU0OXlVblVWZ1d0QS9VaHIrUDhCVzU2b3Fw?=
 =?utf-8?B?dXFCR1d2ZWJPdGJ4cjFHcnN6U1F4Z3FJZkRNT1BqZ1Z0OGV6ZVFDazhZaHkx?=
 =?utf-8?B?Y0oyV21DY001OEV6NStoR0V1a2szb0tzV1Zmbi8xWVZveUZObWkyZ0NCWHJQ?=
 =?utf-8?B?cUF1N3RMelk0UzJoelZtSDVZRG9PZ2tLNXpYaSszL3UxYk11VTF1bzNxTFN2?=
 =?utf-8?B?cGMvLysxVC9HejlHSVhsdTNtWm1ERlU1dGNyS3VFdmU1UEVITzFkeDJBRXBE?=
 =?utf-8?B?MUprMThPMnNlREZOUDZpSzVpdkxReGZCejdhUXRKb0lYQzhEY1p5MjBIVGU1?=
 =?utf-8?B?N2pER0tyL3c1TFQ3dHdLUktEMERZWG0zZWkvR0ZGR1FmNlBYV09yank4ODd5?=
 =?utf-8?B?cFkxK3NsV1JhNlIycnZPZkkvdkhvaHJoVm9weHRzdzhTMVlqaEd1bVNyT2cz?=
 =?utf-8?B?QU1ROUxUTnpVM2RENGNMNkZsNTFTaTNRL0MwWG83cEFpSW01MCtrSjdJcmxy?=
 =?utf-8?B?bEdDUys2YU5jT0h3VmlaeVVHWDdOU25zRm9vSXlNV0VQM3F6NTJ4Ui9TWm1Y?=
 =?utf-8?B?QklReWJlVU9xUW45RytGUmtJcUducXQvbHVkRUhVSSs5c2J2dU43c1hXQmtp?=
 =?utf-8?B?MmdlOGJGZHZDejdyRmFubUZSTFJtM1EvK1Q3N0tlN3UrNVZHNzBSM1Z4UjN0?=
 =?utf-8?B?aWtrTW1YdFlwdnZsTG5CL0k3VzI2V2VueGI3Q1lrdER0cFJOd1Z1SE1ubkNq?=
 =?utf-8?B?Y0NkZ3REL3duZllOQnM2bWpudlBKeU5KMGFhRnI1WTAyRWp5ZzJ2MERMK252?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mKe8XJB6Gl+XL8wWf5+2Y42Z5txpi1PiPJbjp25GEDrwRfUKIf8QD7nz0s86528PCqTo5kg8Y3lbWaRLWIkVX894GLGkb7TGmGIPOf97ME5kYrX/BWCQ8nW+Rs2ZMxKLuLABuSg6qe/bvZtUn4Bzwtlomtoaz4fzN9z9AHc3SKZA0Y0lguhZ7+h8tUoFxUdzWbD4xVei+XbxAoN82af+dEYSSOw329Dit9C4DBoHoYif2dUTX84M6lvqdNQyvnJ7s5cvnu97ovbMujJdH9uLIp+EJ2y0BesP6q/51Xypxgvj+dzwRd1onMqSlUG7o2Q35Qh3yj+shOL9UzJ4NtMXJtKWphB0idRbG4UusXbb5u6N9/BfKI5lRGmzJXsq4CIeNQ5beWtnjFkFLcbvXYi8v6jHBFuhlBuzL0lN34sTNUHtVbVaOr6NoDdZJ/WyeKUtkQxF1Fstw8sju8vX0kWSp6VrLCJNv8NWEgYqnYMRhfqEyIshC1rw+mm+uW1lXlgvAnbuqoWEmd6/+kZBYV8bFWRdll874Y/z07ZlZx9taPEq7OYo+x7vkaRJAKrheY97YkEYzh2UnFJuaDTxAosUYKBqYMm9SAsOyorOA5cszKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3512872-25de-49f3-8a13-08dd4d054737
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 14:38:42.4203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgqaojFpgVwIeJgbBsDKm3DmyT8WFwBaK8i/Z5X1QF3Jp2k7t0+AzYQNamvLFJNLQ23QVfLmJSyjkNFEHD5o9uTKyVWk1DVayZWxrX2WU5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140106
X-Proofpoint-ORIG-GUID: S3aPWQRyGQ87Ra3r0F3rjHrkVTT1QJbw
X-Proofpoint-GUID: S3aPWQRyGQ87Ra3r0F3rjHrkVTT1QJbw
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

cc memory reviewers.
The series is here:
   https://lore.kernel.org/qemu-devel/1739542467-226739-1-git-send-email-steven.sistare@oracle.com/

- Steve

On 2/14/2025 9:14 AM, Steve Sistare wrote:
> Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
> region that the translated address is found in.  This will be needed by
> CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.
> 
> Also return the xlat offset, so we can simplify the interface by removing
> the out parameters that can be trivially derived from mr and xlat.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/common.c       | 21 ++++++++++++++-------
>   hw/virtio/vhost-vdpa.c |  8 ++++++--
>   include/exec/memory.h  |  6 +++---
>   system/memory.c        | 19 ++++---------------
>   4 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index c536698..3b0c520 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -246,14 +246,13 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>   }
>   
>   /* Called with rcu_read_lock held.  */
> -static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                               ram_addr_t *ram_addr, bool *read_only,
> -                               Error **errp)
> +static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, MemoryRegion **mr_p,
> +                               hwaddr *xlat_p, Error **errp)
>   {
>       bool ret, mr_has_discard_manager;
>   
> -    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
> -                               &mr_has_discard_manager, errp);
> +    ret = memory_get_xlat_addr(iotlb, &mr_has_discard_manager, mr_p, xlat_p,
> +                               errp);
>       if (ret && mr_has_discard_manager) {
>           /*
>            * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
> @@ -281,6 +280,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
>       VFIOContainerBase *bcontainer = giommu->bcontainer;
>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
> +    MemoryRegion *mr;
> +    hwaddr xlat;
>       void *vaddr;
>       int ret;
>       Error *local_err = NULL;
> @@ -300,10 +301,13 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>           bool read_only;
>   
> -        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
> +        if (!vfio_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
>               error_report_err(local_err);
>               goto out;
>           }
> +        vaddr = memory_region_get_ram_ptr(mr) + xlat;
> +        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
> +
>           /*
>            * vaddr is only valid until rcu_read_unlock(). But after
>            * vfio_dma_map has set up the mapping the pages will be
> @@ -1259,6 +1263,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       ram_addr_t translated_addr;
>       Error *local_err = NULL;
>       int ret = -EINVAL;
> +    MemoryRegion *mr;
> +    ram_addr_t xlat;
>   
>       trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
>   
> @@ -1269,10 +1275,11 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       }
>   
>       rcu_read_lock();
> -    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
> +    if (!vfio_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
>           error_report_err(local_err);
>           goto out_unlock;
>       }
> +    translated_addr = memory_region_get_ram_addr(mr) + xlat;
>   
>       ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>                                   translated_addr, &local_err);
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3cdaa12..5dfe51e 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -209,6 +209,8 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       int ret;
>       Int128 llend;
>       Error *local_err = NULL;
> +    MemoryRegion *mr;
> +    hwaddr xlat;
>   
>       if (iotlb->target_as != &address_space_memory) {
>           error_report("Wrong target AS \"%s\", only system memory is allowed",
> @@ -228,11 +230,13 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>           bool read_only;
>   
> -        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
> -                                  &local_err)) {
> +        if (!memory_get_xlat_addr(iotlb, NULL, &mr, &xlat, &local_err)) {
>               error_report_err(local_err);
>               return;
>           }
> +        vaddr = memory_region_get_ram_ptr(mr) + xlat;
> +        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
> +
>           ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
>                                    iotlb->addr_mask + 1, vaddr, read_only);
>           if (ret) {
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index ea5d33a..8590838 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -747,13 +747,13 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>    * @read_only: indicates if writes are allowed
>    * @mr_has_discard_manager: indicates memory is controlled by a
>    *                          RamDiscardManager
> + * @mr_p: return the MemoryRegion containing the @iotlb translated addr
>    * @errp: pointer to Error*, to store an error if it happens.
>    *
>    * Return: true on success, else false setting @errp with error.
>    */
> -bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                          ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager, Error **errp);
> +bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, bool *mr_has_discard_manager,
> +                          MemoryRegion **mr_p, hwaddr *xlat_p, Error **errp);
>   
>   typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>   typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
> diff --git a/system/memory.c b/system/memory.c
> index 4c82979..755eafe 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2183,9 +2183,8 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>   }
>   
>   /* Called with rcu_read_lock held.  */
> -bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                          ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager, Error **errp)
> +bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, bool *mr_has_discard_manager,
> +                          MemoryRegion **mr_p, hwaddr *xlat_p, Error **errp)
>   {
>       MemoryRegion *mr;
>       hwaddr xlat;
> @@ -2238,18 +2237,8 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>           return false;
>       }
>   
> -    if (vaddr) {
> -        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
> -    }
> -
> -    if (ram_addr) {
> -        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
> -    }
> -
> -    if (read_only) {
> -        *read_only = !writable || mr->readonly;
> -    }
> -
> +    *xlat_p = xlat;
> +    *mr_p = mr;
>       return true;
>   }
>   


