Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E060F107BCCC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15DA-0007au-4O; Fri, 13 Mar 2026 12:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w15D8-0007aT-3o
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:18:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w15D4-0006FH-Os
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:18:01 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DDnnEh031987; Fri, 13 Mar 2026 16:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=q7CB2q7G3EO2Wbm/VVxdj9tQo6viDewQlVZX8bqboYk=; b=
 bIUOUJRbe61CdIU/nxbiQV7WqtqKCACD3+O4lAB54KuUmpAAPVZXOxvzygH20UYM
 4Y3X6chOibitVvBqBFhFVDCxUIUK3GnxFr5Q4ctAkY1DLW7CecZlF3qs8cF7S0eg
 2PCBnZmQZ5dT60lRqrRUY+pnpJ+Qucqz6i9FSy6bv+291M2HAubX1IgZjxJ3Wzx+
 M3f68G4w7LdYngCexB/iroaz3X3O+9ie7UGJPIMpMCLwXSADpz3cYoGs3AFTgsAS
 YkIUo9xuWXhDNLHLnQVBNYvD3sxL/9rCl3deTNbbkRMRWFtE4XD44nvdzvyYrZbB
 xGQMqDrCkAibvV1okfroaA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cuh4qu44g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 16:17:49 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62DElO1s013199; Fri, 13 Mar 2026 16:17:48 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cuh5evesj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 16:17:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIL4EYmainsYBL1kZwmqj/aU0ZKBn/slVT5XG2sa7ws/+D9CsJTrJB2+qB9bBEK3q3VgImyuBZ6xQE+mMnip9C+k66Ry5Tu3z6hgMBfXjqlfYEKbJ8yrX7I6BFOVHBSuQi1MyZGWn8aWoQduq/OPtF/JfSWVeLwnGLdZcSEljRgKIaBfrzVIMrEMPD8uAFa9mDSnJYrX+AmEanFXN80WOygfneQI7CS6oggJrBC7fooca4WLhXkI58sUyRfy8hmvKV1RFiFQRpeOBuT47v+tKFZhDwg7hyPjzVSuv616/UsY13XSERRmI7hLAbSRJuP3o7/TX4ZY6SJzvb5Koc6BYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7CB2q7G3EO2Wbm/VVxdj9tQo6viDewQlVZX8bqboYk=;
 b=BJ3npK5tvTLlG+wNPxfLcHUhow9zLt+F6vrORRo80AywZcfkaI1kz0K/XnQFES/MmeXpqzS1BSpNzmEf219ZPHLdcfg4x9648lp4vU3OEkX4gnYr/YyTH3C6+79BmkwHS2eHPVbN/iLsh50VpIqkooP2j/zfrDJwh9PZ+ZB3ajglRBWjLqlLYICynAtcNt4i3n5A6QtVBZpnjtPoZo3vRCxIJGN8051OdVWgFcs+LenFKjNgNQMzwMCGSP9qZmGLEUdiL5vQtx8n4mxj5w38EN6sTXyZeeUo/GhomjbCaYFRjN4ETC1Gr8Ga/ygR4qtpsSYiwjDbeeaz9RQnJlEQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7CB2q7G3EO2Wbm/VVxdj9tQo6viDewQlVZX8bqboYk=;
 b=TRJtq1r0bVo/NBQ+NOpJ2eaMm3ds0STma84Y4m3MO5Fi/WS6V2mZFJEzj5hYSs8dNx3mw3g8BJXuGSjXJFC73qGHPtiNmaOO0cuD0iFdtW0jhuqAzOpeC/iRcZJzl2EquPKWWbEyqznPDGKaqcF4Mdr46fOYDUb5h9t5QIyEgrQ=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by IA1PR10MB7471.namprd10.prod.outlook.com (2603:10b6:208:455::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 16:17:45 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 16:17:45 +0000
Message-ID: <e9d191dd-e988-49ec-844b-3267a837b5fb@oracle.com>
Date: Fri, 13 Mar 2026 12:17:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] amd_iommu: Generate XT interrupts when xt support
 is enabled
To: Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com,
 clement.mathieu--drif@eviden.com
References: <20260302115130.5903-1-sarunkod@amd.com>
 <20260302115130.5903-4-sarunkod@amd.com>
 <2c022a3c-f0e0-42be-a946-760a6e938de5@amd.com>
 <6bb7196c-3f0e-4164-ae3b-fd780c40c933@amd.com>
 <a04f4989-20b9-4bf0-b69d-350bd5982394@oracle.com>
 <a5fb1eef-2602-4333-ad9a-cd82f90c4d71@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <a5fb1eef-2602-4333-ad9a-cd82f90c4d71@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:930:89::27) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|IA1PR10MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e336e92-6c2a-4e07-f3e3-08de811c0f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: V3o+91UeDqe3JEnKh5h+CBlQxwTo0B1Z7UIOM16XS7r7W1qJ6jxaPPzaCFct9DkwjHw754q1JvdlS8VVCwuC2jVWHN7J4WTDrHI/voBDjRmaCzKTLKQCZhSbQQALUpcJC1gF+J/HZhguvkFaJsXR/mFhqP/qX2G26FqtYrNfOJV2PVCgFMBrXO1DRnfdCP3f9/GlwLlb77w5x/DkRfVh3/dhlRZDd97Tp8vYpuIOxtDPdSxhPvFntLTW9tGruQ0Qw3RI97wh77zzDVj3OXdISEiFIXiZo63JxFvPb0blS7Yq804P56YxCVjaf91lmJnWBWjgmvjZJ1zKwjCyypix7Ufq3zNrTvGXPboGubD+FOpydSRXccdxjg91ZzGd/SUpVDeNiCFYfwNaBk+XNB46q8vx/FZ/1BeOewF+LAg3t9eDheQWnrDqF8dtGJ6s+DBnAA7nVrCAPi5XOzROwCqOG2Jfsnvi2fj3UxG+3WIfrj/PR/SL/x/hywDxrJMsW/L88pbCXJD3OVUcHnyb5kpALF9stM4sk/yB+6G2241gu3F/2j91D+C5SCq5FqebZYGHIS6tIuPHazPfpGA8UYPlCKA3jmGNix+ovh00yJCTbjMZiYvQsOV/cniJ8UULQ0K4VIAMDZlyOHE94z+fq3XOQ34TfjTSwTCAtmzFGDk9sUWxMeOAOcRBrDNnsVTRoqADju1KMCbE0fOaospetv/weenqB0qr6kzh/gk0GBr4EbAGqRacDVvZ6OzD2lHXmH/f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3U3Z2hvZERQWVQ5UU5hYm5PYTFBdkdGTmlzYk5Fd2ZFdTVra1FOZ1I0akhT?=
 =?utf-8?B?S0pUd1k0NFE5NiszSG9yeWQ5OXo1dkVkYk1RRGNNY1hxQ1ZFMDB6Qi9HM2dY?=
 =?utf-8?B?d1FwMnZsemcxem12MmQ5SHVzNDJpT1VrZGRGQVlPY0FPby9LL2sydUhMYmx3?=
 =?utf-8?B?REJRYlMzbHlOUzA0UjB3WDVPRDNIRHpvQzNXZmRHNWRndWZBWkdDcXZWbE9r?=
 =?utf-8?B?T3YrMGNSU1U2MDBTUncrYmVOcnpWR3ZmaTRpMUtJYU00NW13NmkwenlIWHk0?=
 =?utf-8?B?UkR2d0xkdEYzKzZhNFB5NnpYTG16OGJvUFRVaGVodXFIMXZMY2pxVWRnaEFE?=
 =?utf-8?B?L0hyK3ByZ040Smdoa2t3dDY0alNqbTg5N1h5b2hOVXRPVzFKVXJKQkUrcjRX?=
 =?utf-8?B?QkNYcVNZWi8rTlhpTkxWZGFnOTFmQTZNMlV2TDI4cnFMUTV3UnpvQ2dXc1Jq?=
 =?utf-8?B?ME1DcVJ2eC94Vmdxb0l6NnVGOERWV2xFK2dpTzRveHJJc0doMlI5Tlg5cWlz?=
 =?utf-8?B?OG51NDFGcDBZV3VBcTJyd2dVY0VrcDl3OUt2VUc1U0c0NXl5d3JhWWFiTmtM?=
 =?utf-8?B?OVhWOVRaKzhyTjJrQXZ4QkgvUFJXWGdneG5jWU0zUEZ3ek9SaEoxM0tPckJs?=
 =?utf-8?B?L1VOWHduYy8rOGs3dW0ycmxKd1laYjA0OVVvdWthVjE0a2NicndUdDNLMUpj?=
 =?utf-8?B?L0JxSG91eG81eWlEMkExUFdTWUw4NkxQWnppaExXdDcvdEJLb0VrUnAxOGRz?=
 =?utf-8?B?NkVBNDNRcnJQOTk3TkpMZ0lybjdOakxVQ2NENzd4NjJ4b21YSGZMU0MyUEJQ?=
 =?utf-8?B?Q3R0QWY3KzM5Umx5NEw4all1eFFGZURjSy9nNFkyU0xVSXhkQ2E3RCtaTDV0?=
 =?utf-8?B?YklCY2RuSHdkRVlHeXhoRHdTeFdNVmQ4c244ZldBZDl5NlVXN09DU3lWekgr?=
 =?utf-8?B?alhsQ0FYWVRMTEY0d3pnV2FsSUhFRlliM0pyZmNhaElkY2hPNDV4a1VVdkRG?=
 =?utf-8?B?Y0x3REI3TENRamtZU3hSZGxwMlBkT2tXMGtCVTZXUndwYUJxUmZHU2V0RnIz?=
 =?utf-8?B?RUt1VEx6YjBGdEhNY1pqRDJLWWY2LzBTRnk0WTZkVGZ0dm9LTHRyeFpMN1pq?=
 =?utf-8?B?SGNDVy9YZW0yYkNkaWRoSGRrakZlODhmZ011aG52NVNPam1QN3hZdXlCYW5i?=
 =?utf-8?B?eXVaTHJtQ013YUhZYzZud1NKSHY5MVlWVDhLUWhEYXJ3aG4zTlZITWdPeUw4?=
 =?utf-8?B?a21kV2haTnBLTUhmNVpNWU9vb2xObmwrVEQrLzFSL3NlQVRrTUlUVU10Z1dG?=
 =?utf-8?B?TFNFdzVpWnpXYzlDYlFoOU14V0M4QlpUaUkweTZaRzFFWkd3b3h0OTBwUlE0?=
 =?utf-8?B?SnBOWU9aQkdHN05mbXBZb09leHpCV2daQUxETk40bXRQNHNWMzBYV2R3eTlD?=
 =?utf-8?B?L2pMSUQ3eWFkbTNqREJ5dzR6aVcyQ09uZWJGUzFaNm04cWUxQlk3bDdNT1lD?=
 =?utf-8?B?VEROQjRSYWh0OFlJSWhUeVRCZXRLOXR2NnRLS3Z2cUxmQjhiVjh0bzFJMjRW?=
 =?utf-8?B?L3A4ZzR2K3Z6Y0w4NzZsRVpSd1dDMjBHMXFYNjZWamtzck1WTDM0ZHdUOHlI?=
 =?utf-8?B?ZXcxNnhmSDUxYkUyZ0IySTVJejdMOHQvQjdoNTJpUE1BSzdiU1J2VUVCd0t2?=
 =?utf-8?B?djd1c2RETEhDcWN2MXhqS2VzZFF2V2x0a2YyN09UbE0rNTAwUGxQaHU4V2ds?=
 =?utf-8?B?Z0xWN2k2UlNjNnZnWkdZQW51ODFBZzBnRkZ2cFRFRUh1ZnlRQlJlaDBaaSta?=
 =?utf-8?B?K3JkSmZMWldwVWJEZUtlZ3Q2NVJKdGJkU09kSWtpOUN3L0xPcEdoWGpmaXhF?=
 =?utf-8?B?aHRwZUgyV3BpZzMwM1VCRVJ5aldNUk92M0J4V1NTVGpYQys0NFNPZm9XS0Qy?=
 =?utf-8?B?ZCtiNCtLcEs2NkFQdnl2RzZHSSthZkxtWVgxZm8zaStSUnVuUlBLTkZrZWxw?=
 =?utf-8?B?M1BWL3V3cWdFY0VUeURXQ2h5RnJTNklzYXFPSEdWVUszVm1kYjVJY0Z2K3dk?=
 =?utf-8?B?LzBlWGc0NXRiVnhvNHh1LzBocjh3dHhFWGxMTXZiaFlpajdmVFRnTFltTmE3?=
 =?utf-8?B?S1NubzRjeTM4dVFyUFlMNFZZMUpjNVdOeEo2UVNoNzRaZUVsdzZrQVVqUXpY?=
 =?utf-8?B?TzBtNDdZSDdwY1loUHBUQmoxaitZN0V5cGtiS3M3Y1dIRUkvcmR3d0NqM2xu?=
 =?utf-8?B?UmxzaWlwS3ZhbGJ2aFV1THZRR0J0b1dmNW5KNlBOdERsRnV3Tko2bW9HVUZu?=
 =?utf-8?B?TUl0RjhIY21DRzhZWjljV3BYR0x2RlZqVWNMYlM5MWlVWDJPZVdTMllwT2lE?=
 =?utf-8?Q?kEBG8WscwUJfjBVs=3D?=
X-Exchange-RoutingPolicyChecked: qE0iY/dd8nBJNjj8Lo3VuedsEiMK/9FbaYmV/0z4yGPjOfIsQL/Vjaup/jr1NlvBh/lLW1gwySiAqUyUBrObsbWQDbjQfz7i8ugH0m1JAbI6cPPxMDpI99iJYPRMMb4wrmFH1VVIFa/wBHbggMyH9CIpxcWJX67Zl6qY2WgBEXmuEzC3dzQ9SrOsVFfw9RFNPD5gDJJympqecDYyxRsx/To4VUTIHWFgjNu9Ges4SWAslW5Vj7b3TYHsrw/gKAtlA0mvwWgj4ICy9sPIbtwbZvWB3GDKHxediOUrejT9ZAHCS1Osx8UANAkgR8kFrXyXnNXwEx2Ye6wLvRL5f6FPrQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HMeB5m2GYtdqqhDDtykvvxXLxqvB1sbFEN4ENyDNVedO7NKTbThLy+tInC/u96S/6RQMh3bSP/TMkvEFraCTDcb7vQVhmmhcO6dDIYC3pkD0hBas2Txe4AoKQPDmZPHc17MZZHi9jDACFqJfZAx2TD8V9GOu3TvWv2mO3jZh/akz/k6LSzpOeceXgQeVvelqwKX3nCZKkuKOblqPvM/6ylfkFtRBkvFuIRRWyBLvOfSuIrSGEpQg8GfwfDzPvV0kwgiztktq5da/kDJNV3McL/Gwc+S7rEP4+b9QjXcn3J7QDwh/esAnTBP42LOmXey3EdyO2lVOC+XZxcvdGQYM69Jh3nZU0r2T8Bh3KtVarDjM650qaB9fUJz4j7G3mzOvi2aEHAxS87Lzi8zkTV0btgR5zIVigEM6J9U0ReI4QLSA1uaHxynQ2yvrjPfVvCXF7cvA3HKrIF+RiMRvvrorhc0WK2dQ6dchnm/DnGB5pgGTRLvUJPW+K9XHaMVYPZ5YOiCGf33RlVU6Bdx2kulCvvb/5V3GXqEmAohnWq/P1ybHQe1n5k3MMsUfHCd7AaZpIn1733cdZKr1NE7yoYKnL3A/F6mIPTXzzTSr+3kI6/4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e336e92-6c2a-4e07-f3e3-08de811c0f8e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 16:17:45.5100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSn2CXt6UaM7KxE4TGsecIFur3G5fLp8guyIXBPfnl/nRCFIWCSeLiITL0TywuJrRtHlOCGM58xFjjL6Rv52NIKgxccDcCuIDIryZQrHR5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7471
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603130129
X-Proofpoint-GUID: P6iNs9AY3fD4RSdrICjPCdRUDzxMemUM
X-Authority-Analysis: v=2.4 cv=ZdsQ98VA c=1 sm=1 tr=0 ts=69b438ad cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8
 a=zd2uoN0lAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=060fELy1m0cITPQaWN8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P6iNs9AY3fD4RSdrICjPCdRUDzxMemUM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEzMCBTYWx0ZWRfX3ybJvJPRwdht
 MNSCEgllgJtvi5nMFmSjolK5nrhWA6rVL5fLg/cws2VAotN1DoSl4Cj/JMB3fvDCAHuLriEeclp
 ASV0iJiMyjUHSkDfNFOeEvKFi8sli3IHiBoj0VNMWzCsXUKzWu09T9d9wq/NB3eprzE69IPWiW/
 ku8JW5eobwaGcB9CG0E5C1zU2+8xJxiLh+bDeMYVZVBM6fZjtQFXpnbdtMBhh24iMy6bq6489wT
 t3fhAny8fLc0kObPBihEB/lxrkDqhnOyxSlQdKEeh52qJ8a96jDbqGGBOaR+TMoC7qLSLchlcz+
 3bi6Ar9cWP5/kGSJ7ICQ1xOkX+shmeGjwXoK94VeoJYTSlTczPaxlTIiBFFws9HjsSjE79/42e5
 ngkXLO9Toss1KruTa4zKZF7Zhu/1WQTbCO0NXMZ2To542ByqCF0RqgsrV2OAezb7biB7ofx7DlW
 jlTEiKsbvqUBWQN+zfQ==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/13/26 1:20 AM, Sairaj Kodilkar wrote:
> 
> 
> On 3/13/2026 5:46 AM, Alejandro Jimenez wrote:
>>
>> On 3/3/26 4:55 AM, Sairaj Kodilkar wrote:
>>>
>>> On 3/3/2026 3:17 PM, Vasant Hegde wrote:
>>>> On 3/2/2026 5:21 PM, Sairaj Kodilkar wrote:
>>>>> When MMIO 0x18[IntCapXTEn]=1, interrupts originating from the IOMMU
>>>>> itself are
>>>>> sent based on the programming in XT IOMMU Interrupt Control Registers in
>>>>> MMIO
>>>>> 0x170-0x180 instead of the programming in the IOMMU's MSI capability
>>>>> registers.
>>>>> The guest programs these registers with appropriate vector and
>>>>> destination
>>>>> ID instead of writing to PCI MSI capability.
>>>>>
>>>>> Current AMD vIOMMU is capable of generating interrupts only through PCI
>>>>> MSI capability and does not care about xt mode. Because of this AMD
>>>>> vIOMMU cannot generate event log interrupts when the guest has enabled
>>>>> xt mode.
>>>>>
>>>>> Introduce a new flag "intcapxten" which is set when guest writes control
>>>>> register [IntCapXTEn] (bit 51) and use vector and destination field in
>>>>> the XT MMIO register (0x170) to support XT mode.
>>>>>
>>>>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>>>>> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>>>>> Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>>>>> ---
>>>>>    hw/i386/amd_iommu.c  | 47 ++++++++++++++++++++++++++++++++++++++------
>>>>>    hw/i386/amd_iommu.h  | 17 ++++++++++++++++
>>>>>    hw/i386/trace-events |  1 +
>>>>>    3 files changed, 59 insertions(+), 6 deletions(-)
>>>>>
>>>> .../...
>>>>
>>>>>          /* update the flags depending on the control register */
>>>>>        if (s->cmdbuf_enabled) {
>>>>> @@ -1732,6 +1762,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr
>>>>> addr, uint64_t val,
>>>>>        case AMDVI_MMIO_STATUS:
>>>>>            amdvi_mmio_reg_write(s, size, val, addr);
>>>>>            break;
>>>>> +    case AMDVI_MMIO_XT_GEN_INTR:
>>>>> +        amdvi_mmio_reg_write(s, size, val, addr);
>>>>> +        break;
>>>>>        }
>>>>>    }
>>>>>    @@ -2382,6 +2415,7 @@ static void amdvi_init(AMDVIState *s)
>>>>>        s->enabled = false;
>>>>>        s->cmdbuf_enabled = false;
>>>>>        s->xten = false;
>>>>> +    s->intcapxten = false;
>>>>>          /* reset MMIO */
>>>>>        memset(s->mmior, 0, AMDVI_MMIO_SIZE);
>>>>> @@ -2452,6 +2486,7 @@ static const VMStateDescription vmstate_xt = {
>>>>>           .minimum_version_id = 1,
>>>>>           .fields = (VMStateField[]) {
>>>>>               VMSTATE_BOOL(xten, AMDVIState),
>>>>> +           VMSTATE_BOOL(intcapxten, AMDVIState),
>>>> Do we need to increase the version no?
>>> No, because we have introduced a separate subsection, the older and newer
>>> qemu are compatible.
>>>
>> I thought that was the case because the changes will still be part of the
>> same "release". I don't believe we guarantee migration compatibility
>> between random/intermediate commits, but...
>>
>> If we are going to follow the guidelines strictly then I think Vasant's
>> observation is correct. The patch changes the layout of the subsection so
>> we are in the same scenario that lead us to include a subsection to begin
>> with.
>>
>> Because the two new values are still part of the same xt support domain, I
>> think it makes sense to keep them in the same subsection and the simplest
>> way is to do:
>>
>>   static const VMStateDescription vmstate_xt = {
>>       .name = "amd-iommu-xt",
>> -    .version_id = 1,
>> +    .version_id = 2,
>>       .minimum_version_id = 1,
>>       .fields = (VMStateField[]) {
>>           VMSTATE_BOOL(xten, AMDVIState),
>> -        VMSTATE_BOOL(intcapxten, AMDVIState),
>> +        VMSTATE_BOOL_V(intcapxten, AMDVIState, 2),
>>           VMSTATE_END_OF_LIST()
>>       }
>>   };
>>
>> That change is on top of your current patch. There seems to be precedent
>> for this based on my search in the git log. If you are ok with this
>> approach let me know and I'll apply it, no need to send a new revision.
> 
> I am not sure if it is really useful here. Because without this patch
> xt-support will not work and migrating from vm which only has first two
> patches to the vm which has all three patches does not make sense to me.

I agree it doesn't make much sense from a practical standpoint, unless we
are bisecting a migration issue, and we don't want to fail between these
two commits.
But again, adding a new field to the subsection does change the payload
that is sent "on the wire", and increasing the version like in my example
above is the minimum change that keeps it all fully correct for migrations
going forward (just like we ensured when adding the subsection in the first
place).

> I think we should treat three patches as a single unit, let me know what
> do you think about this ?
> 
I considered just moving the creation of the entire subsection to the last
patch, but I think it is unnecessary. The approach of incrementing the
version ID above doesn't have any downsides other than little additional
complexity, and it is the "technically correct" way to do it.

I don't want to introduce new subsections, since that has basically the
same effect as the method I proposed, and it makes more sense to keep all
of the XT-related fields in the same subsection (appropriately named
"amd-iommu-xt")

So unless you have any correctness concerns, we should go with my initial
suggestion (actually it was Vasant's). I get the usefulness is limited, but
it is the proper way to do this based on my interpretation of the docs.

Thank you,
Alejandro

> Or we can do something like [1], which introduces new subsections
> for each capbility.
> https://lore.kernel.org/qemu-devel/20180119050005.29392-1-
> sjitindarsingh@gmail.com/
> 
> But this makes sense only when you can use each capability separately.
> 
> Thanks
> Sairaj
>>
>> Thank you,
>> Alejandro
>>
>>
>>> Thanks
>>> Sairaj
> 


