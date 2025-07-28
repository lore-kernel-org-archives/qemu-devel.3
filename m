Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEB1C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 16:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugQe7-0007jA-4W; Mon, 28 Jul 2025 12:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ugQdz-0007h9-RQ
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 12:24:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1ugQdu-0006op-AF
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 12:24:05 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SFflJJ022783;
 Mon, 28 Jul 2025 16:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=qBk/6H6FY/ao450Yzc1q4we28LPISjp0SmLyq3u0ZSg=; b=
 JnNdj+0g0qfz/wB0rrmSc8ohFAnGiWfkuxFdeRBZYh/gFZMwd11Zaoo4xwBxFLEF
 +431mpdVQRQyjngIqDESmBAX36rCnR48ERsrvSlYM56sasQVrknvfr2fDg63kr3q
 UMP8WAYW4h+yWvtw9wz5iJJyceneeT09Wv+vb1cAevUyNoqpYWipR6IaxnjOwB5N
 liXjrrUaXgrn3d1kKzrWhYbfiEZCgLnRjpazmVRgPKHVlahxe8TGfh1xVZ0WtiZZ
 U6ZsUd5BKvDzEIImY9alhBQyY65xmh4verynVS5Vu+d7EoYExzy46Q8jKKWo4yV1
 aGtqJGKGZvG1BaW4kJqoNw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q2dwu6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Jul 2025 16:23:59 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56SFdh81002467; Mon, 28 Jul 2025 16:23:58 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010052.outbound.protection.outlook.com [52.101.201.52])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 484nf8uhmu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Jul 2025 16:23:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1sITot0+mIGL20uhrSNeCaIU3sXpOzOBbKWkvH3wg8yXbA555J4vjCCMkVGKHPzTiJJq5NuYdDTSOFPVIbhOvmETcH8yy/q/YOm6G0o/736SEQySeQ7qdygCmRb150CIwcvlc7sk/neZ5YbRnKYlyFPFUI+K/r3TK+hVWgza6e59z2CreRK3wHy2sfw/pyL9Qwck1K7hUtfRBW93jDX2FrekAh+tNN9Dr6g1GqFl4xCCn0tRkgLuBoB4R3uHTrXjlO+rdc2mQCQpNiFq0u7GS0hBkIVC7pXAVq0o6187WU4PR9Gi+Yjnfv17i90nuSYKpUyRe26UGDTiB7eBD4d9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBk/6H6FY/ao450Yzc1q4we28LPISjp0SmLyq3u0ZSg=;
 b=vdHUZ+5zdbKRn2vjuNEPlus++E51JnDmbk/y+udJp+TjSBsKQTWBqjDzB4stO0fgWnk5RsuDpTalt6h7755sD/HGoHv/+oT9yvaJf84U0RMzecpIA+qDikqegUa7YuhJ+81yVDDM5m6zHGlI2D2509YVapaqSA7CdUkNybCyGVi8E1CMhP5HvkI3uVZ4+yu1/CJsTRSS2b68y5RWbb3AByFq8691GOOp0zoDf7DMm6zPAiNRBv0zLfhy4Lj2AkVko7dnOkV9BZzyebHi3OXE2Expyvwymy3J1Z93sQxFzO75BFc8aslB7qGISY6feez5clm/O+mdYUkrNBUa2kKbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBk/6H6FY/ao450Yzc1q4we28LPISjp0SmLyq3u0ZSg=;
 b=tOr5DiAwUtV279t+Tm9SIO21pPyQ9KLxMq+N9NkZig0hlHk9oYHz/Fn9pN8uZC8sJfHIm3DEpPv6QPLuIGRWNPeYWX85bMv7ajlJUiQe86z1QmPugAbr/Mbix55OpGM45eWPG6pETuOMB16W2pfE+WL4fmAoMEh/uiDluLx+pO4=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by DM3PPF545856187.namprd10.prod.outlook.com (2603:10b6:f:fc00::c27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Mon, 28 Jul
 2025 16:23:56 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.8964.023; Mon, 28 Jul 2025
 16:23:56 +0000
Message-ID: <9f6be5cb-60b8-4c13-a80f-800f409033f0@oracle.com>
Date: Mon, 28 Jul 2025 12:23:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com, jasowang@redhat.com,
 mst@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com>
 <CAJaqyWd7z-5cHojosMA5mrPQiD8Lz76zF=pmUrQ0cuuXvuSLzg@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWd7z-5cHojosMA5mrPQiD8Lz76zF=pmUrQ0cuuXvuSLzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR21CA0021.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::15) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|DM3PPF545856187:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7eb80e-e5aa-4494-fe7f-08ddcdf32631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0I0cmEwNmpLTE1CYWpBYkdKQU1qUkZTWlpjYTd1Ujl1Z25PM2YrZVhiU1Vt?=
 =?utf-8?B?NU45L0piNXAyWnQzTm1uRkhybU1XTmRZZWRvTGFPTnczck40MkhrWmhweEFG?=
 =?utf-8?B?aUc5dTAwM2swK0R1RzdJU1NEWmhCcHJwRUFrd3RQLysxQmJGbGszU1l6UXNj?=
 =?utf-8?B?OTloS1dTMXF5Mk9IMVhHSUpaZ2hTQTZhRDNLb0pISG1McTkyODBnNmttanNm?=
 =?utf-8?B?UDRwZmdUQVNEcDJoWFc4REFtWWVXb1EvVFFuQ1dIdEVrVitMMnFidEM0QjVQ?=
 =?utf-8?B?ZmNLQ1JlYWlCcXRvSU9XVWc3V3VMdTEwdCtmUHFUWnQ3TWRoakgveFV0eGIy?=
 =?utf-8?B?cktQRk9jMU1jYkdjd05sdk84dGVhMDY3MDU3TDZmYklJc2lmSkpZc0wxSFQr?=
 =?utf-8?B?cVAzY3Nrc3RyUWNzTStZVW9FcXM2em1ZQ09PUkhKMmIxb09tSDdhRHdQNzdU?=
 =?utf-8?B?SU1ManlLZkZYL2w2SzF5WE5KaC82YUwzVmM2R285d1FFOUxQdnY0TjhJUTVI?=
 =?utf-8?B?Vmx0Zy90c3BMS3NmYVVyY0k5MWh1N1hTRnJGWjgwUmZmQUJubS9YR0J3TGJS?=
 =?utf-8?B?emdmWC9QYVJ3bmtROTFXdDhQZjBmaHYyRmdFbzhOOTN6bXFqQVJoYkN0SG94?=
 =?utf-8?B?Q1dIUXZmYnlDMlhJQ1UzamRYNjNxajNBRDN5aEJpRE1SaGczNEptck5rdlhj?=
 =?utf-8?B?RzcvYmloSlIrQmEzMHVkMnpFK0pSSU55WUkySXJGNGh1UVBFYldWeXNsSnNR?=
 =?utf-8?B?bThvVU54UDA4eUZuS2hSN1Z3c01ZM3dtQ2FUREJYT3JnSzdwSkJ1QmRvMThv?=
 =?utf-8?B?Qzk5Wnh6bW42YTRNSGlOQnRTNDFUc3JDRnppYUplZFBObTg1M3dtWXUvQ1JQ?=
 =?utf-8?B?RCtwbDFNVW1rL01DZFpnUVlFeWxlQk1ZMUVHbUVHVmV0WjBIZzZRdGV6Ykxq?=
 =?utf-8?B?Y20xUXRDZjJmVGd6a1Z6SXdGNnUvdnZVY04wUnoyUzFOQ3JMd1VNMzg1Umxz?=
 =?utf-8?B?azI1bGVzS2dYWHc4NmpLU2M4V3hheWRqV0FDeWozNGNZMlNndnZsY3hyL2pD?=
 =?utf-8?B?d0hwcklseDlzc1BHYVVPU1QxWVFBaWtMOUc4c0RTdk5QTGZhNHZxdE1DN1hF?=
 =?utf-8?B?TDFMSUZnUWNSZUtKd2FBMW5hNDBJajBQdEt6MUJuWXA5L0htRW9GYjQwSjRP?=
 =?utf-8?B?TGhNRnpHWCtJWTVrUXFtNnJ0SWJnSEI5M2NRTnYvWjErYUxPdjE0MEpnQUFR?=
 =?utf-8?B?c25tSmtKNDZPVVpkME5XVy85SXRQZEUyMEZXaXpON3V4RmZMcnVGdHVQbXVz?=
 =?utf-8?B?TmNBdHRoZHNrbG5LWmF0alk1MHNEanU5V1V0ckNGU0w4eTY1YmpPejZyTXVu?=
 =?utf-8?B?MmhDUTRpQlZWTExzcDkxNGxJSmVBbkNDL2FiUGt1SnFla3JIL3huaHN2bFU5?=
 =?utf-8?B?Z25PSjA0OHJ6eC9wOHpTQXRCRVJPSDZXMFhtYmV1akgwcmxSdjViTUhKaWkw?=
 =?utf-8?B?cWgyTVpma2YwajFWZ3RpY2lGSThnS1pwZTV5U251UmhadmFSYXdIUWp0MkIr?=
 =?utf-8?B?ZjJSY0xGanFrVktDQnhVMFdrTFBPYkp1UlEwbDZnWFRtdTZ0T2R1ck52VEV1?=
 =?utf-8?B?Qk85SUdJdXp6M2o0TEJXRGh5OWlRKy9XTllpZUZFdVJNUEhGVDBTRVIwanhW?=
 =?utf-8?B?ZHp2ZTNoL2xpQndNOUtXLzAydkgyTHFkV3BtY3QvRkFNMldsQzZIZXFJcER5?=
 =?utf-8?B?WGErUXo5blZsOE9uc1lpaFZHQXNKR2pXTE9mTHBEc01CK2lRcWNEQWZrM0Ey?=
 =?utf-8?B?MG5mNUdnd0ZjWmdMM0Yrbm56c3ZxZE5BTzJ1NmVXZSt6bktPZ2ttd2g5blJa?=
 =?utf-8?B?NVJCc3VDL3Z2aFVyL0xpZHN0RUZodGdtUllqYUY0aUl3cXQ1YXJXUi95K0hl?=
 =?utf-8?Q?IJI4rOMkZ60=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWpPYytYQzJpWkljckhOeXlzVjQzZ1h6M1FETXVpd29LSENJM3RXUG1zck43?=
 =?utf-8?B?TXc4VlJhVFBQbk96ME1xODJ1eWZ6L3FFVDVzY25aS2dIanZ4bC9sajlTZjlK?=
 =?utf-8?B?UTZnSjJoNnBnaDNmajgybXhhbFZHRkVLZXFicFFHU05ZRGdqUHFudElSdnBa?=
 =?utf-8?B?ajFoZ2xFenZXNlpjbTQ4SnNuamd5dEhtdVIvQ0E2YXlYTDRHbXMvcVAvbS9I?=
 =?utf-8?B?Y2xodk1vUEZYZlNyUzJQc3dUSkdKTHpEVHh0cEhsYlBkVU5qWDUrejIxWUps?=
 =?utf-8?B?Nm1xWkphQ0lkQVhuOENMRzc4VEMyUnRzYThRRTFkd0s1YnlUVnhZc2VieSsz?=
 =?utf-8?B?UkRlYXRNZXdFaE5UMlNZSmh3OFl5UmRKT1NGWDdsK2M3OFROWkp0R2NRNSt4?=
 =?utf-8?B?VnFTNzBBbUZqZ09BYjNlVzhwNTN2Rmo2VUVhNjJKaFJUY1pUTmRTS0hQUTIz?=
 =?utf-8?B?aDRqSUY1VFNjbjdvS2JHWlRZR3JuemJrZVdMdE9jaFRQUkVOUDdraklQT2pU?=
 =?utf-8?B?c1FRWU53YXdzbkp5c3hweDVmTWZKYzR1N1FETnNhS2thRndUVCsxM05ZMnhV?=
 =?utf-8?B?cnpSQlF6Qkd1bkdEMFo1cGRaTlM1QUF1cm02ZVJTR2FvUG5qMkhRT2twL2Ns?=
 =?utf-8?B?WkhYLzRqanpDYklTTkpETWVGZjh0cytkUzF4ZGRENmh5eE5YVzEzWlRKSUZq?=
 =?utf-8?B?c2N4VHVCN1VCejdBUVNZVWpMQ0JuTkF3cFVRMUZETUVJUWpjU1JBdjdWK0JB?=
 =?utf-8?B?MXcxV2tIK1VhZUliSk1MVGFSTkFveWhuQmV2RzhZa051dFZrUGdIbkFiMzlL?=
 =?utf-8?B?dFUzL3FlbVZ3NzlidDNxTHJGYkFDajFpdXk3Y2ExN0QwcDkzZjZ2djlERGw5?=
 =?utf-8?B?SzZxSWRyMnpEL3h2bzk0ZC9KQXV1N0lkekFYeG54WDYzY0JKOExzK0N3Nitn?=
 =?utf-8?B?TnRsZnhqeiswODR3UXZ2dnFoaHlkeWNyWlZMTHBNbjRDTWZ6WHNiZStDdVlI?=
 =?utf-8?B?MEQ5QSs1N3VZSHNZZVhYTGxhRnRRNkpoZTU0NTI0a2Zld08wbFhWb3lYUEhT?=
 =?utf-8?B?ZnNWNGtDdXRJeEdoNHZWeHlhVk1WOTRZaEs0cFh4Z2hFYVh0cVU2bHVRNE5I?=
 =?utf-8?B?OXF1ditRZ2RlS1RMOTVOTEpDaXpqTDdFL09haFoyWEZPS2dyekdNRkY0MlJ6?=
 =?utf-8?B?NytKaW9rWFZ4OU84RFk1SEtkUVowaTM3aWtkV3MrMkpVNFdJZ1lydzB2Ympn?=
 =?utf-8?B?ZXdHRTNMMnladTBuUSsydnZwZ3pmejN0K05GWGZzY3dmbmYySmtVZ0xzeUk1?=
 =?utf-8?B?ZjczdnpTNWg2am0wbGs2c2xPNUJRYzlFSVorenNmMjZIdUZ6cnJTelNRWWNW?=
 =?utf-8?B?RFU4Rm5QZ2xoVVZkSzJ2TUhmVEg0WHZsRTFScTdxaXYvaGZIb1NMNDBtWjZE?=
 =?utf-8?B?d3AxVlVoL1c0STNyRjBCTUY4cmlHTmVZY2dDdzVhcTJHMmwxbE9ZdDZFTlZ4?=
 =?utf-8?B?ZVRCMXN6SitjU0RJYnVNWkF0Q01ZQTRFUUZ6M2I3cEVKaFhhSmNyK0xqRmZV?=
 =?utf-8?B?enBjd255SjJOYmVaUmtHT0FaWHg5RjE3bk80cjdIWkd3UEtzNi9QUzhSaWdq?=
 =?utf-8?B?d1JzU2EzcGFNNk1vUjVvYjFaYXlqbWlVMHg5dXZpVEJkV1ErTGtNc0RTT2NB?=
 =?utf-8?B?aWI0TlFCODJwY3VvbTVuVmlPNkpMRU9CbC9odXd2eUZwcDZreXdyZUxpbGVZ?=
 =?utf-8?B?V1gxWmtQVHdSYTFQUlVtVjV3bm1UU2VORllXanpqZ2lXZzVOQ1c0OFJkLzhY?=
 =?utf-8?B?SzNNN1E3Z1djRTF6ZFdLK3dPZjV6R2dkY1BIdlBidkRGQXdiZWtJUFRHZEIv?=
 =?utf-8?B?OHAwWWR1ZGlvME9SN214TDdwNnRLNy9OaWxoTWpWWFdZczF3WTBGR0VRamls?=
 =?utf-8?B?Tm0xTGlScWt4N3pEOHlHM0lEcjlrdE9GNzlFdS9nOHpCTjNhR2hFWTh3OEp5?=
 =?utf-8?B?SnZkNllCRGgwWGxMcksweGs2bnFvNG4yUjFlc2FGM3JnWTFJMThVcWY1NWtS?=
 =?utf-8?B?Z3JGK2UwSjFYSVlmajRuN0VCd0JqRU01ZVRpQkVacTIxdUJZTHVBcXdHZjBn?=
 =?utf-8?B?SVFEdENHM2FHdm9la0t0bjNLbnhSUzZmaWRiMUtVSlJ1TWFJVzJSRko2R2ph?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ztd6jumQjHuy6zGL8v83q4owtnazFD4BFmOtCPwHIPzPCRpxfV/NN/rizUJPQGQ5sbAcvLtaUtHbfCEBjAF6SDuXSOwcu635mkyF6VEVJKkLM+IZPdiMdTQsR9M42f55EPk57Z2hwE+C2sqoy42DfLsmlIyVnBCRQIEEt9FATFt2qlnc1M+rQNO+Q5lAGvf7frYobe1LISux767GJHNdl+c8WLFxOaUQpzWG3rXC9v/j/P87TxNCBHS+NHBLlxN7IlQPJp6n4kAcWRkE7At+lw0xbOdfp/XMLB8TRw74XFIrEGvIjVzThb+kQz5X9X1eT03sDjuMl8HAONyFAiN1ToifiNbTicilAE9jYlRP3DL3RCNT7dVgYV+gg2i4tn52ddaAOw8NYP0snksP8LYowFFmaMzTQiA/I9/ZKhqEON65FEmT5bptLZjZx1fxcBjml0rj/d8W2ynmKb+HqqwZ81wLuRZ3HO7DZZH5iVL1GHtwWqRutiY9IxR0dfg6t8Er61Y0lbTG+VCCW7281F6bAc+BXNwUpi9DFt0FBoLgQbAgdIJCsIdRX97K6a779ZCFyrKf73KuFVawkdrHZxuQWySCtwDoXpLuP82/G8qZDho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7eb80e-e5aa-4494-fe7f-08ddcdf32631
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 16:23:55.9844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZzzAPHXu9b8jS68j1sv3vZds1JQ3UxEKccetfkekIHLUuJ/AXIhL/iTfNambToyEJcqMZSrLNSZyepqFGReng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF545856187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507280120
X-Proofpoint-GUID: i1A03nCNSHRBETLmUzqlakmQa4lAmUGz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEyMCBTYWx0ZWRfX+baybzrHos90
 S9l3PRHOnzAZRcZvXt0ylA0j1oSA+3XrBaC3oIyliSiTREsUwIqV/fQ+Gm8jwXCQUSixTe1Pyvz
 Uk5t6xGplRe8w3Xkmho38VDKTTca43US3/3+JEl3qmBiLhdI4uFucHIp96JVUy5dZiKc9/66r8S
 5W3+qXPKVmjja3qNlMh7OLfIJuuLO7eVN5SICguT9XVdP4ObNcNvvZvfZl9bJT3lCJrMbkfsAJH
 AiEn9Gw40yqgFC7JXEQtI+4S2nwjYy/m4il+XoohFf4BBMjPuxPBmmz8ZHnrxdHl/zmQ/N9kcDE
 nvF/O82tufYMru2L5wINwQTZyfen6pRo1daFjQO22WeyUwqcGbtlfhNzEwq9JPWBs6QBDDJQXx4
 3lBtMpy1fdijdLsRJZ87eiMN///tXBYLwrsMXigRCdagbA8JW4mNl6+PX/wXSfGr18hYmbQ9
X-Proofpoint-ORIG-GUID: i1A03nCNSHRBETLmUzqlakmQa4lAmUGz
X-Authority-Analysis: v=2.4 cv=A+5sP7WG c=1 sm=1 tr=0 ts=6887a41f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=iz2yyBAMNl1AwP7UiEgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 7/28/25 11:30 AM, Eugenio Perez Martin wrote:
> On Tue, Jul 22, 2025 at 2:41 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>> Iterative live migration for virtio-net sends an initial
>> VMStateDescription while the source is still active. Because data
>> continues to flow for virtio-net, the guest's avail index continues to
>> increment after last_avail_idx had already been sent. This causes the
>> destination to often see something like this from virtio_error():
>>
>> VQ 0 size 0x100 Guest index 0x0 inconsistent with Host index 0xc: delta 0xfff4
>>
>> This patch suppresses this consistency check if we're loading the
>> initial VMStateDescriptions via iterative migration and unsuppresses
>> it for the stop-and-copy phase when the final VMStateDescriptions
>> (carrying the correct indices) are loaded.
>>
>> A temporary VirtIODevMigration migration data structure is introduced here to
>> represent the iterative migration process for a VirtIODevice. For now it
>> just holds a flag to indicate whether or not the initial
>> VMStateDescription was sent during the iterative live migration process.
>>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/net/virtio-net.c        | 13 +++++++++++++
>>   hw/virtio/virtio.c         | 32 ++++++++++++++++++++++++--------
>>   include/hw/virtio/virtio.h |  6 ++++++
>>   3 files changed, 43 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 86a6fe5b91..b7ac5e8278 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -3843,12 +3843,19 @@ static void virtio_net_save_cleanup(void *opaque)
>>
>>   static int virtio_net_load_setup(QEMUFile *f, void *opaque, Error **errp)
>>   {
>> +    VirtIONet *n = opaque;
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
>> +    vdev->migration = g_new0(VirtIODevMigration, 1);
>> +    vdev->migration->iterative_vmstate_loaded = false;
>> +
>>       return 0;
>>   }
>>
>>   static int virtio_net_load_state(QEMUFile *f, void *opaque, int version_id)
>>   {
>>       VirtIONet *n = opaque;
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
>> +    VirtIODevMigration *mig = vdev->migration;
>>       uint64_t flag;
>>
>>       flag = qemu_get_be64(f);
>> @@ -3861,6 +3868,7 @@ static int virtio_net_load_state(QEMUFile *f, void *opaque, int version_id)
>>           case VNET_MIG_F_INIT_STATE:
>>           {
>>               vmstate_load_state(f, &vmstate_virtio_net, n, VIRTIO_NET_VM_VERSION);
>> +            mig->iterative_vmstate_loaded = true;
> 
> This code will need to change if we send the status iteratively more
> than once. For example, if the guest changes the mac address, the
> number of vqs, etc.
> 

Hopefully we can reach a solution where we'd only need to call the full 
vmstate_load_state(f, &vmstate_virtio_net, ...) for a virtio-net device 
once and then handle any changes afterwards individually.

Perhaps, maybe for simplicity, we could just send the 
sub-states/subsections (instead of the whole state again) iteratively if 
there were any changes in the fields that those sub-states/subsections 
govern.

Definitely something I'll keep in mind as this series develops.

> In my opinion, we should set a flag named "in_iterative_migration" (or
> equivalent) in virtio_net_load_setup and clear it in
> virtio_net_load_cleanup. That's enough to tell in virtio_load if we
> should perform actions like checking for inconsistent indices.
> 

I did actually try something like this but I realized that the 
.load_cleanup and .save_cleanup hooks actually fire at the very end of 
live migration (e.g. during the stop-and-copy phase). I thought they 
fired at the end of the iterative portion of live migration, but this 
didn't appear to be the case.

>>               break;
>>           }
>>           default:
>> @@ -3875,6 +3883,11 @@ static int virtio_net_load_state(QEMUFile *f, void *opaque, int version_id)
>>
>>   static int virtio_net_load_cleanup(void *opaque)
>>   {
>> +    VirtIONet *n = opaque;
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
>> +    g_free(vdev->migration);
>> +    vdev->migration = NULL;
>> +
>>       return 0;
>>   }
>>
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 5534251e01..68957ee7d1 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -3222,6 +3222,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>>       int32_t config_len;
>>       uint32_t num;
>>       uint32_t features;
>> +    bool inconsistent_indices;
>>       BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
>>       VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>>       VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
>> @@ -3365,6 +3366,16 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>>           if (vdev->vq[i].vring.desc) {
>>               uint16_t nheads;
>>
>> +           /*
>> +            * Ring indices will be inconsistent during iterative migration. The actual
>> +            * indices will be sent later during the stop-and-copy phase.
>> +            */
>> +            if (vdev->migration) {
>> +                inconsistent_indices = !vdev->migration->iterative_vmstate_loaded;
>> +            } else {
>> +                inconsistent_indices = false;
>> +            }
> 
> Nit, "inconsistent_indices = vdev->migration &&
> !vdev->migration->iterative_vmstate_loaded" ? I'm happy with the
> current "if else" too, but I think the one line is clearer. Your call
> :).
> 

Ah, nice catch! I like the one-liner more :) Will change this for next 
series.

>> +
>>               /*
>>                * VIRTIO-1 devices migrate desc, used, and avail ring addresses so
>>                * only the region cache needs to be set up.  Legacy devices need
>> @@ -3384,14 +3395,19 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>>                   continue;
>>               }
>>
>> -            nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
>> -            /* Check it isn't doing strange things with descriptor numbers. */
>> -            if (nheads > vdev->vq[i].vring.num) {
>> -                virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "
>> -                             "inconsistent with Host index 0x%x: delta 0x%x",
>> -                             i, vdev->vq[i].vring.num,
>> -                             vring_avail_idx(&vdev->vq[i]),
>> -                             vdev->vq[i].last_avail_idx, nheads);
>> +            if (!inconsistent_indices) {
>> +                nheads = vring_avail_idx(&vdev->vq[i]) - vdev->vq[i].last_avail_idx;
>> +                /* Check it isn't doing strange things with descriptor numbers. */
>> +                if (nheads > vdev->vq[i].vring.num) {
>> +                    virtio_error(vdev, "VQ %d size 0x%x Guest index 0x%x "
>> +                                 "inconsistent with Host index 0x%x: delta 0x%x",
>> +                                 i, vdev->vq[i].vring.num,
>> +                                 vring_avail_idx(&vdev->vq[i]),
>> +                                 vdev->vq[i].last_avail_idx, nheads);
>> +                    inconsistent_indices = true;
>> +                }
>> +            }
>> +            if (inconsistent_indices) {
>>                   vdev->vq[i].used_idx = 0;
>>                   vdev->vq[i].shadow_avail_idx = 0;
>>                   vdev->vq[i].inuse = 0;
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index 214d4a77e9..06b6e6ba65 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -98,6 +98,11 @@ enum virtio_device_endian {
>>       VIRTIO_DEVICE_ENDIAN_BIG,
>>   };
>>
>> +/* VirtIODevice iterative live migration data structure */
>> +typedef struct VirtIODevMigration {
>> +    bool iterative_vmstate_loaded;
>> +} VirtIODevMigration;
>> +
>>   /**
>>    * struct VirtIODevice - common VirtIO structure
>>    * @name: name of the device
>> @@ -151,6 +156,7 @@ struct VirtIODevice
>>       bool disable_legacy_check;
>>       bool vhost_started;
>>       VMChangeStateEntry *vmstate;
>> +    VirtIODevMigration *migration;
>>       char *bus_name;
>>       uint8_t device_endian;
>>       /**
>> --
>> 2.47.1
>>
> 


