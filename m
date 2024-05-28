Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571AAC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBySk-0007Rq-IJ; Tue, 28 May 2024 11:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sBySj-0007Pp-5A
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:10:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sBySh-0008Tb-1B
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:10:04 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44SBn3m8019465; Tue, 28 May 2024 15:09:58 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1; _a=3Drsa-sha256; _c=3Drelaxed/relaxed;
 _d=3Doracle.com; _h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3D0bue+JtAt1lTFt60UO/EjhYUvYimH60oP9RNikvGg5Y=3D;_b?=
 =?UTF-8?Q?=3DDsx11WUcbG9Xt0OsTGf9TDmZ51wQ4j06nVa4NmMHgEqdoBA78xtmBX4dqvlk?=
 =?UTF-8?Q?6KTQB034_BJoJ4cVvOszjdhmeoPtBcKGL7lfZZDPF2jHyk5X/N1dCNYZ2OnqhXF?=
 =?UTF-8?Q?znohqSpW4hbe/W_ZmRi7DhEDiXe6B1EOt9YIAy12tKPgLY2IfF9fR1b75tHPFIt?=
 =?UTF-8?Q?6VBdJJq1PFT760tZc4ST_1HSTJuSECS9SEiCsBKgW7qGjknCnpHTvQ0jBBMlnCD?=
 =?UTF-8?Q?3Wcj61IY+rWhvmEEBJ4S76ln0D_MAK+jYnMpiAc97+9K5QNI+a/Z371Y2Ds+NoZ?=
 =?UTF-8?Q?mBFruXFSgIEyNoQytJsOxSOSdSNqWpcJ_mw=3D=3D_?=
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j84hev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 15:09:58 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44SEoHGf037795; Tue, 28 May 2024 15:09:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3yc50x10u1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 May 2024 15:09:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPHyyhhuEVWCJIxfFL31yNoA9AHLu3zjBTQI5jZV/4UqmncgFqgmpBPIBFA2SxME6xlOW1ZoKh6NcHLbAqcqfxfccqe/elDHJ9Ta1vR0bna7HTl13Qbpsp8Yjrbw9jHRulLm41S7Hz6fE6xNehFobRbu7nNWReC3GUWjfqMSMBigzTJP89fJd0Ho9InitTr0BJ8bB9qfxJAc2yfoynFSiAvMNTEMTt3IZrLMZTRmTWKdegjXfa67FtckJcBsHtBM7pVaoYxW/bWb8RrFIjCl3lC8aIRrxYPFF+69SH1a0qrf1/TmEhzLVtrIPA1kv1P7icUFiclbnJm10xkXtRbbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bue+JtAt1lTFt60UO/EjhYUvYimH60oP9RNikvGg5Y=;
 b=oXH8pUt2q/wa+YVSOR9t8mPAtKhXenUqiUqhTulqIKIAtOnIdvN+PNI3d3+DExi0OHypibJcAAItWYcU/yp6MxJJcp/Dtv6EqWniekMTJRYqaWh1FwwnsWDE1J2svnb1nLA1jrCSE9WFSk7a4dhcg4AfoLYw8ZQ0cn1weKEC+SOabDxpj9kD5CuOW8Lz65ZsoZin73dAAJfZ1nFbL18/gC7G1Ililocylwvr96qfzlIUc3njlOvBW0Gbn8IvsZv4FjGefU46wI+TVDoH7J5cexsxDiHtH6x4/RSfYkKgC3LRKvQ+zs1YowiiJWYDFcsB9xNUZOu0jxXxWe0ReynbaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bue+JtAt1lTFt60UO/EjhYUvYimH60oP9RNikvGg5Y=;
 b=lHb+utBUVZ3XzpDI1avXoCKr3jIYfVXXdWpXxv8nOfQqev31ffI59FVa3NtiEYhyE+uHs7lPXPPE3k9EShFp5Neo/iJMydVkTdsK/Jk2uNE52DoDTazisJykBf6MPjcM6h2VIJqeKSuwIY9kFQnnfClVWAZf67n+wWq4wQJ9xoQ=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM4PR10MB6717.namprd10.prod.outlook.com (2603:10b6:8:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 15:09:54 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 15:09:54 +0000
Message-ID: <daca5ee5-87a7-4a07-8161-d5e133c9443d@oracle.com>
Date: Tue, 28 May 2024 11:09:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 05/26] migration: precreate vmstate
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-6-git-send-email-steven.sistare@oracle.com>
 <ZlTOCLFNF894T46U@x1n>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <ZlTOCLFNF894T46U@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::21) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM4PR10MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 8436d811-7dc0-4c0a-2541-08dc7f283ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azFlM2d1bmtta3JuVklFa3JtTnJZRGhab0RtNFVZbGZYeWRjbGNiaUs0K05Y?=
 =?utf-8?B?aDE2TkhXd1Zra3RsUGNEa24yaEo0UHdydWp3a2U0ekMrU1ZqcS9OelpubkVk?=
 =?utf-8?B?MkpWZmovVEEyUmRJTU9DR08wNjRiU3pkdDh6SHR3OW9uMDJJS3R1UXNIUS8r?=
 =?utf-8?B?ZUtWcFliWWl3R0lrMFBhUHhJRUxxSFZGTVRuN3I2b0ZDZUF5UHNCZk44cUhG?=
 =?utf-8?B?MEtFRWZ0U2JIV2pnSWJmc1pDMTZDd0JVZG9jZlFHdFVmRjFEbHVwRUpjdXpV?=
 =?utf-8?B?bnZRTVpsSjJibUF5NStyN2xMQnZhTzRnc1FuUVR6OWhFcGx0WE51SEZ0RWE2?=
 =?utf-8?B?UkJrcHRUdEVxbDdsNzdTVkFXWWljbnRqQ2N5Nk9QR3ZvTUp3clJxZTVOYy9Y?=
 =?utf-8?B?STZVRUxYNEVPUUltVG1IZGlYTUdpTUR2U0pJcnc2dXJOVDNTOUY1SFpveGhR?=
 =?utf-8?B?REJkUTNLODd1ZFpiekd3NEdHRjg4SWlKTEROZnVHLzdueE1LTzdoSUtKWmxn?=
 =?utf-8?B?OXBNVjRta0xKNi8zbERxbEFtcXJoa0JVamUydTg4ZHJpdTc0TThQb0g5Y2sz?=
 =?utf-8?B?UnA0blNsWG5rMUZiWkx3RDZtQ2xSU3gvRGNJNjRST2xBYTdwaFRVNW5oVjB4?=
 =?utf-8?B?S2RYRmNsVjErOE9hbGlHWE5JUG1sUXdBeEY1cFVFUTBYMnRCeEVrcGVGeDRV?=
 =?utf-8?B?eXFqVGt0NHBxeGc2Zmt6a0cyTzk0OWx4dkJXZHNNWXowOUxjWmpYZExteTRR?=
 =?utf-8?B?RUp3cHlzbGdhQVdMT2NHTWdLUVFuRE1QWUExdnBtL0p1QUFZZHFEL3kzMTVz?=
 =?utf-8?B?WjVrdEtrOVBVd0VWRTE0dVJUQzI4TGtoTTJCTXlUblYvMEN6b2d3ZGVvZGli?=
 =?utf-8?B?NzgweHBoZGZudWtGTGNEMmFFZnpFdXdralp5d3IrUi9GaDlsbjgwT3d5UkFh?=
 =?utf-8?B?Rmp1QTY3c2NyWHpTQkJ3ZFJkdW13OVY3VDNDajlFWTA3eTdBc29oQ1AxOXpt?=
 =?utf-8?B?QXg0WCtZT1RnUkVzSUUrZVpDd1VXaDh2S1JiWUEvaXR0ZUVPQlFHZTM1clZs?=
 =?utf-8?B?WnRISFFmcjRGdnNoMVlmdlJYZmxqM3N4bzUyVFA2REE0RjlITXNiNUh6QXdK?=
 =?utf-8?B?Snc0SG9IcjJhODBIbFBOaTdmMnN3WUdKdEpaSXpWcVY5Mm9lbThocEFGZG5E?=
 =?utf-8?B?b1hTaUVYT1U5YitjOVBHd09ZZGdzQk1tV0drbTRUUW0yaFFYZ1dWeC91RDFy?=
 =?utf-8?B?VjhYMWZEODRHcGUxK0dWMWJsOEJCV1NhRjVMZHZCU2psakU4d1ZsYlB0eUFW?=
 =?utf-8?B?dWx1a2RXL25TVkcxeERyZHhGRnZXMzkyM3RocUJHRWdNcnZublpoRWxxd0Zn?=
 =?utf-8?B?elY3TG1tM3Y5NEFZM2ZoN0ZVd082aFRMcnF6MnMvTVNzOTE0cEtEQmNJbGhT?=
 =?utf-8?B?NVZVR2o2dnVkMkMwdWpmbFhCUUIyQ21LS1VNQmNRUEJIenBWN01uc1JBV3R3?=
 =?utf-8?B?dkxxSXM1RXBJeCtPRmlzY2lMZXA1MTFHS3FmajJGZ0ZzNWxnTFlQSEZyaUk3?=
 =?utf-8?B?VWRSU1VLcGc1cG8zMDA1b1U4aFZCWXc2UHo3MDRJb3d5RDNQOWlqamloN0E5?=
 =?utf-8?B?YTU5R1VnRUEzdEZzK3lJMnZFczdiVFhOUlVLbHBtTzUzRGFFUUhCRzZ1Q0hB?=
 =?utf-8?B?MnlFalhFZmV3V3IvNG1zMVdkZnc4SlhpdEVJUzd5SU9xMjZYTHM3dmRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djRXUm5zL3FuNUpFMnBhVE9xaU1zZW5XakkwUFJqa3NsNXNtMi9mbnNHeE1M?=
 =?utf-8?B?QldMMW1kcTExeGlJS2xac3Y0VHhsbWVKdVI3c1pUdGVydnhkVHVUVjhKMUZm?=
 =?utf-8?B?Z2J4UHdUK1JrMWxGNVNnQ1dXbDZ2b1dabGtGdlJEa04yYmlhYnV2Mm1waDFT?=
 =?utf-8?B?dnErU21XbUFFd0pCRjlCTTJwNzhGRGVEQTNVa0Q1UTZNWURTdlRCUXA5NVZL?=
 =?utf-8?B?N2tqQVhzTmFoL0NoZzc2YXd1eElSQWlqYnRucmJTWDBPS2pJV0ZxQVBqUUk0?=
 =?utf-8?B?dTRwY1k1bjRKOFM1OWo0ZTFIUXhRcnBqOTJiV2NaTGo5YXREYzB1SElUTmRj?=
 =?utf-8?B?TVVNRVk2cWljdy9Hb2V6T2NPRi9weCtVN0REdDVKK1ZkcTZuL0lzTEs0NFdM?=
 =?utf-8?B?b3JpeGtUdFNselo1WklUVHdTOXI4RjdRb2psa1pvYzJXZHN1SUVzc0x5c3VP?=
 =?utf-8?B?RGtMUE8xWEo2bStVU0docllMb1NOU3dmditHTzVnOE8ydWF1Rk0xc3VOUUEw?=
 =?utf-8?B?eDRxSk1iaG5RR25rbHNITHdCVFBkcXNvVDJ4dzNOYUh1bm9TZUhQa2h1dk5J?=
 =?utf-8?B?aTNlV0d3cXZ1RXFZSmtlVjRUUm5SeE1penc3dlhwQ1IwcWJRei9VN0cyZ2pu?=
 =?utf-8?B?OFplTzl6N1Uxd1ZRSkNrWlAyRFFwcFBIRnF2Z0pMc2c4KzhQUjZxVHF0eHVQ?=
 =?utf-8?B?WjcwSU9PQjc1TmRKdnhMUmQxVXRBRUFXeTVTRkFYQVArYzg4Zk9rQkUrTUtv?=
 =?utf-8?B?ZjIwdDBKSENDcEZ6dWVZcm5UbTZJTXpTdDVUbFJ5SVp2dmJndzBNUFc3eW1t?=
 =?utf-8?B?b0NvNTRYUUd0Tm8ybmNDMG11alI1YkxXV1dvQXFsd0d5OXQ4QmVLYURadWtF?=
 =?utf-8?B?Tkc1ajlBcmIxaHQzNERmd1NvcEhJRWtra3lQaHF1cEpzWk9TVDBwRGRxSDlD?=
 =?utf-8?B?eXdlbUwzdFArVGlVdS9BalpULzJLa3ZudnFMbldmNlZiemFDRFVwRm9kRnFZ?=
 =?utf-8?B?ZWFrdTEzKzI3RmI3MDFCRmJLQ0pTb3ZkM1NxWU0rcXluaGJLVEtYS0g2UzhN?=
 =?utf-8?B?aW50RTVRQ1dOWCsxT2Jtd2RNOXlvUmVPRUNIbDlEVmtoSWxYdldUQ0VtVWlu?=
 =?utf-8?B?dmtSVEJPdlpMOFdsVld4U1l4L2hYT2FlMjRpTnpzYStYbm5GWUFnRVBDUjVo?=
 =?utf-8?B?Skh1NjRSdVppUTFLejNhZDIrVkZFSXVMaEhhUmxwL0NPQjBJUTlIb1I0Ykhv?=
 =?utf-8?B?SnhUTEg0bENQTUphaGNzbTlZRWN4S0pmb1VQSk15Um9ON0xaSkRmcHh3VzNQ?=
 =?utf-8?B?aGc5TzBxUGVKQkJCVEl4U3VCeG9Eemd3Z3NTenRjU3FoZ3BRZWo0RXhrbjV2?=
 =?utf-8?B?MmlFNDFPaisrTCs1M2lxbXcvRHc4eVBkcmxZMUIxV1RYbytCdEhIdDAvekY2?=
 =?utf-8?B?WXp1NHVEQlIzZzJMemFqZGZiOVBOL3VETmpIN1dLSUhmS1FrVTl2MUN0WDE3?=
 =?utf-8?B?K3VDQ1VqNk53TFpLUVQ2ektSamp3Zm1UU3JFNzFsc0ZOTWZIZGVZRXZtajBv?=
 =?utf-8?B?c0F5bG9FTWFhdTBldXFpZ2xXWUE2Ri9PRUZiVlpxZ0lCQ29jVlAwZm1tQ1do?=
 =?utf-8?B?c3Ava3lKU3hQYWhocTJmVjdQaVFNRnBIMXZzT2IxY1d2eGs5c0FjN25LUThK?=
 =?utf-8?B?dDBYVlpGY1hSUHNSZmcvMXJrZlRwVU9XdkdkWlNyMG5zYzk3TmNiQ241RkxN?=
 =?utf-8?B?ZldOTnNkdVBITTlOQzBHWGp1ZzBXT1g5TzFVSVNxY3FmbExpSDZOTTd3WVVx?=
 =?utf-8?B?Q1IzYU5TYU1vRkNRdGRBMXcvdGZwOG1UOUl5TmJFSURld2JrNC84L2M1a1Zj?=
 =?utf-8?B?Y3h2YjB5bEZrZ3l5N0VLZWd4RHFteTNDcEFScitQOGgyRHdydU9heTFQTDNW?=
 =?utf-8?B?RU1FanNySWp5ZmQxeVhDTm1xYWNZbXJSNUJHVVFJdlVOUm1yY2k2Q2dPWGE0?=
 =?utf-8?B?dzBXNDZ0YnpQTzU3SGw5QXNzUSsxZ1JySUF4a0xFb1c2Vk1wamZDYmgyZFdF?=
 =?utf-8?B?dUk2WFZiTmQ2VGMwaENmR1ROdjcwZlF3b1hyL1RuWG9DUThFekJMVXVNckIx?=
 =?utf-8?B?ZlA5K0FZUFQwNlF2V2pJMCtPSy9zZnYzNU8xdVM2cFNxQXVpaVR4M0RTN0tm?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LBxFejC4W+Y711nm8Gc099+VEHYW1zR9LuVMYrT4i+LxHE0VfsbCG7CigbmnE3W2haJRdD0pzd7JwT4lFy2PrcLvrdEYeMY+ncaWPXb4oUJgSaE9APzqVs1TIgBMWHTqNLp6sN05Wr8r0ioVj6O07J4apFIE65OhmCsBQxmhnhHleakhfo4qYGqfjTFAg1dKkhfH1/Z6sGBgLrTVwQaQ1Hb++h75GRsKmZS47GHusvTF3Ww+JzbQ/fj/sb/S/YwjBp7+CKucDfSP/3UPAN+dsisAIzKd/i6gggTyacZ2fLToIySqqle3RthrNrWvtCoVfhj+KsGMYi0AG5yPW7PT0zRR13ydU9H9XZ+tnajq99bVp2vqMCCJeqcXCxnfOsPjcsncMo5Fr74qmgLUfyoJDDaCyyUQry2nPDLN8mSy5MehM+0wGZ0FbqbjM/mnuP2wpvgMlXyPQUQgx0srMaxmf46y7Qs0DYeGBMXhMR4VugOza9su0ODvYOH+pIXAKSQUJvDcxmdgNBxGAT5SX7J8d+d6m/6XlgQU1oDmvuFQIAMAOJQDmKAUiFdCiCQdxTEGhqEl+CwIf2mm52oKTcE2dcdq0uIISfEjAqfBV1lkrT4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8436d811-7dc0-4c0a-2541-08dc7f283ae0
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 15:09:54.4145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RzO2/HHkPiIiu8fhVCs0/7qGdJzTg4PFPM0VVKEc6tOeK1GzPD9+aGCkfDHlprmxE6dKGkr8VJhUTrpaI0gBYaBdKi6DrBvRKJgjxIEuGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_11,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280113
X-Proofpoint-ORIG-GUID: cuYRX9YHFIU7mz-vwWWY2ew731r3WQ02
X-Proofpoint-GUID: cuYRX9YHFIU7mz-vwWWY2ew731r3WQ02
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Steven Sistare <steven.sistare@oracle.com>
From:  Steven Sistare via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/27/2024 2:16 PM, Peter Xu wrote:
> On Mon, Apr 29, 2024 at 08:55:14AM -0700, Steve Sistare wrote:
>> Provide the VMStateDescription precreate field to mark objects that must
>> be loaded on the incoming side before devices have been created, because
>> they provide properties that will be needed at creation time.  They will
>> be saved to and loaded from their own QEMUFile, via
>> qemu_savevm_precreate_save and qemu_savevm_precreate_load, but these
>> functions are not yet called in this patch.  Allow them to be called
>> before or after normal migration is active, when current_migration and
>> current_incoming are not valid.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/migration/vmstate.h |  6 ++++
>>   migration/savevm.c          | 69 +++++++++++++++++++++++++++++++++++++++++----
>>   migration/savevm.h          |  3 ++
>>   3 files changed, 73 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index 294d2d8..4691334 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -198,6 +198,12 @@ struct VMStateDescription {
>>        * a QEMU_VM_SECTION_START section.
>>        */
>>       bool early_setup;
>> +
>> +    /*
>> +     * Send/receive this object in the precreate migration stream.
>> +     */
>> +    bool precreate;
>> +
>>       int version_id;
>>       int minimum_version_id;
>>       MigrationPriority priority;
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 9789823..a30bcd9 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -239,6 +239,7 @@ static SaveState savevm_state = {
>>   
>>   #define SAVEVM_FOREACH(se, entry)                                    \
>>       QTAILQ_FOREACH(se, &savevm_state.handlers, entry)                \
>> +        if (!se->vmsd || !se->vmsd->precreate)
>>   
>>   #define SAVEVM_FOREACH_ALL(se, entry)                                \
>>       QTAILQ_FOREACH(se, &savevm_state.handlers, entry)
>> @@ -1006,13 +1007,19 @@ static void save_section_header(QEMUFile *f, SaveStateEntry *se,
>>       }
>>   }
>>   
>> +static bool send_section_footer(SaveStateEntry *se)
>> +{
>> +    return (se->vmsd && se->vmsd->precreate) ||
>> +           migrate_get_current()->send_section_footer;
>> +}
> 
> Does the precreate vmsd "require" the footer?  Or it should also work?
> IMHO it's less optimal to bind features without good reasons.

It is not required.  However, IMO we should not treat send-section-footer as
a fungible feature.  It is strictly an improvement, as was added to catch
misformated sections.  It is only registered as a feature for backwards
compatibility with qemu 2.3 and xen.

For a brand new data stream such as precreate, where we are not constrained
by backwards compatibility, we should unconditionally use the better protocol,
and always send the footer.

- Steve


