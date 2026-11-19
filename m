Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF325606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=pw8OgaaC;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=PgVa21/q
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAv8-0005yz-Pz; Thu, 19 Nov 2026 17:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xUAv6-0005xq-ME
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:47:56 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xUAv4-0004Gt-A9
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:47:56 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJFJUJF4078392; Thu, 19 Nov 2026 22:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=k+kvabfbPDn6952FGhw9U6BOnWJC4HbjuStbG63H3JE=; b=
 pw8OgaaCRX8tlFnPMPZKdedActznCeChGsh5l1GS+apybCqpKUupeXo3dToVhtVr
 0RX6wNybOfW6hn/CwPW/rIAZYJgpUnupI+0XxVA6k1SZM3H5Qu9RFVKFPanHgl7P
 hJdcb4BFu71QrVxnusKtSn8iZdX7vS5DmeHdhYSxHqAJxGBtjvOiuuogex9YAPWv
 Bdwi0kbBWmyVh+u0Fd1WTWGGgXjAL1k52Ebb8idBR2K5Y8XBDBL/ds8uerdNzEZl
 g+NCMT7UV/8ABwqKG1DRYG9QcvsDhM0luIeFc2HCYcIQcBZREol+QmAQO/nYq3JR
 fnnEUoZ6VyuUhByHlQC8ww==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j0ytrbvyu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2026 22:47:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11)
 with ESMTP id 6AJM9K062054943; Thu, 19 Nov 2026 22:47:45 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010025.outbound.protection.outlook.com [52.101.201.25])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4j27phxa4u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
 Thu, 19 Nov 2026 22:47:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXeB+FHwMTev2B72+rP48ms7xYyNWXldUmRoD6NGWEI3yWtHsoV3ogwoSJF99Tvg8MM8sF5DrJiECuDs4XCJIid3zKaqUR4OvcJIUMvsMKIgrjIlwNeXEoWmOVtufSFj+DWET43r07kgUi8wmTON1xLtfBnIUSrwlrsVVNqgDWd/zOdtxHNcUfVvmIab9ToLeZgX/aRYAugnBuevCfbe0EBY6wp18iL1osIZ0K95DVXTNKrs2/fL6lqqNnIV42e/7SA7a1fEwJIdBP3HkBdD3ccvsOQ48hBpm/nNV5z2R3+ujzuCnNTtRvDf69q/hzD6of2XDyNkWvqIXety1oIqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+kvabfbPDn6952FGhw9U6BOnWJC4HbjuStbG63H3JE=;
 b=PuPTD9pBa/iO7AjYsv53BlUzluwYr/ei/ItcHZ4IeIvksl88J95P4Q/H1nuZyapY4mW8G9GQPo+Hpc19becS+U79gUp9PZLSf9DtcGw4jBSBiTTQsSJWhUiMNYly4tyEjiPug8vhcvDzqGsELE+GAqGKanBi+exmQv4cb+iP4JBKqA/wxLwM3RW7GSnqtBjE25lFkkBgho+dv6ZG9/s1cvaHPe0LYOfP/smGyN0w+bztvvD2V/iyImSTCZ+XUZxY0OJFNSN0tWPWlXf61XKDEhSvNKafbmxv9dTl7RF4uUr1vEIHBIh1Z9tf+bnMSEabQS4zPMmbAUMvJ1WHhfrraw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+kvabfbPDn6952FGhw9U6BOnWJC4HbjuStbG63H3JE=;
 b=PgVa21/q7D3YsGeUDIuOI0awlF1eGWXvwGXIy9Ge1mScurr+NSxr4q6xDX28+Ese5acfXopXlIFbcZotAQN6b2+qfafrAnL9A7nG4g2HJQxGIshTwEYodykZnXFHhUX7au/nTPPlGi8ErKNQ3IA4C0zj6OvQyvxgRzyWCHUrscI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB5506.namprd10.prod.outlook.com (2603:10b6:303:161::7)
 by CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 22:47:42 +0000
Received: from CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4]) by CO1PR10MB5506.namprd10.prod.outlook.com
 ([fe80::da72:a0a9:5f18:cda4%6]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 22:47:42 +0000
Message-ID: <8141310b-c6df-4e22-852d-12c765cc2a34@oracle.com>
Date: Thu, 19 Nov 2026 14:47:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] migration/cpr: introduce cpr-luo mode to support
 KHO/LUO
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, david@kernel.org, imammedo@redhat.com,
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com,
 pierrick.bouvier@oss.qualcomm.com, alex@shazbot.org, clg@redhat.com,
 yi.l.liu@intel.com, eric.auger@redhat.com, zhenzhong.duan@intel.com,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 armbru@redhat.com, eblake@redhat.com
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
 <95d4d77e-7b30-463e-96a1-6add4495e451@oracle.com> <875wxvs2na.fsf@suse.de>
 <avyqPuj7jz3QKM7K@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <fa74f48d-dfd2-4336-8ea2-a53d46004e72@oracle.com> <87se0yq9bw.fsf@suse.de>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <87se0yq9bw.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P220CA0031.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::14) To CO1PR10MB5506.namprd10.prod.outlook.com
 (2603:10b6:303:161::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB5506:EE_|CH2PR10MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: b4af954b-3af4-4e31-5e51-08df468f1edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|261022075727099003|261021123027099003|10067099003|56012099006|4143699003|261028144727099003|261026140227099003|261021121427099003|261022105027099003|261102123227099003|261026121527099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: GQa4z+fszeTEgDqiJMeiywXn7QoBJOUlzUUXkrtYYmEfe2kID42mVYWP6+jKOBLZdII9uYoWHV01r215RsLrHxxe5Tap4eKTmc3gMyqNnnLmYGYZuFmfC9lZkCeNTUOzNHU4qRoXsJshFjwoeO0ADCXAmOQ+daSSTX8iKuqGycGoAgK2NCtuTgy8HmxLcVc2P0TxMVoaBIaIsBrW/3ALrF4rlZvkHLgtWVxXX33w2xoAyXgN16eVrCWZHYjm52F8b6VcS1HeVNsCGmGRm86iik8Lodit+YgCM+LP2YHxQlW4szvcFY3ej4C+pyx+Jljy2efy2A57VpQ59GP0zI3DrFZ7IDeBh7Aw/B4AW2GHJ/gbjP5lHcYbkqNTzm8SARa/cEHISqs+CikUfYSDMtbn5HI4zRUgLfwkS/uUYpC6rQGx26kgYvIQBcB15IXE0Fw357UapKY0uHYhHkcyoGnu1ZUhjgUXmtZzpvABN7wmiJiKX9UdQxiFaUlWWgTAFM5pKg4s1cglr4qh+BimpxbGRgrFGqJSAu+C9PePB/3vMqWEB4gm9+SdpMWECb8ocqbtDzYv74G2iJIc0ls0RZoogBpb9buFUsdj281A687gs99TQzvU6sxoROGMtC5LM+lqG7yz8UHc+oVaxtjDBg+ZnsYVy/Owie5R/j2/S/wLUKs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR10MB5506.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261022075727099003)(261021123027099003)(10067099003)(56012099006)(4143699003)(261028144727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261102123227099003)(261026121527099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFBTNVlJeGZHNzNnanh3L0dCazVCSHh3UkRNdWZ4ZmhmQW4vS1ZnK3ZLSzVC?=
 =?utf-8?B?QzRMelFWU1A1SlBXeXRJT0xzb2hEZW5kbStxQVNpUlZGU2dwQzF3Vm5WaDZB?=
 =?utf-8?B?Wno5WmFwVlU2QkZkZm9Ebmw0RFRVdzdWeTM5dWJxRWhneWhTWGNRR3E0ZHFI?=
 =?utf-8?B?WlhsZFk1MlBoVjFuY1Z4QTMrOEtBWjluYjVKUzNzNTd0SlhaYWVGU2RteDFj?=
 =?utf-8?B?OXBaM1ltOVY3L3BjMytQOXhYWDE2VWVNdUlTWGVpZ05Pb2w0UFZsUlZzd0wr?=
 =?utf-8?B?YjlQU2RRTU9xQnA0SU8zbmw0K0lPRXVEYVEzVERKL3BVTlJLVHpKOHBmQTV1?=
 =?utf-8?B?VGgxMnhrQmE0K0lIVEVXZjdYMjRXdExtT0doL25JVkZPRVpRajBIeXNidnor?=
 =?utf-8?B?ZW9mK29JZ2U4MFZzNWxWblZJdi92UitWcmxxUlRpaGhIQnoyWmVZL3phaCtU?=
 =?utf-8?B?UklIMWRWSGJFRmRXc2dBQmt0ZWpHTTNlUFp5eWpHcWo0Nmtjb3BRRFcyMnM3?=
 =?utf-8?B?S2svMmM3cjUyZmU5aU5MSlJhWGJ6aEp3Qm5OYklWbUxEMG53bEQ4bis3VlpO?=
 =?utf-8?B?OWpJRm5JYzRyN2xEV3J3WEFudk9pMmozR3FNWWprbHJjWnFaYVlGMEFVNU5y?=
 =?utf-8?B?SXBsMjdVbnNUQmZXS3BaeWJCbCtPWFVRRFNNaHhPZzRzMHJqZ1M4SHZZQkRk?=
 =?utf-8?B?SlNQSkFTSWY3dkZKd2RDMVZONCs5YTRJcXQ1MHRTb0didnVyZ0lJbWExcXpG?=
 =?utf-8?B?Z2VXOURaNFJtb1ZCN1dFNzM0YngrSThSb0hLd1dZa0RpUkI1UHBDeUxaRHQ1?=
 =?utf-8?B?MEkrYzhJRnhrZGs3Z0M2Ti9KZytqQW9GNmI5alhRTlB2bGJtTHVFSmxRSWtV?=
 =?utf-8?B?MkNyTWFXbTgvVWVTSHZBR2FTUEZteTNxRHNrVFJmNjVtZ3VvTlJxbGdYdTYw?=
 =?utf-8?B?U0JqUWFYUVZCZFJ2aHM0dDFIdG40OEUzWFhGYTIzSExieGRSSXpHbWd1cGxl?=
 =?utf-8?B?WmVNTm8yTXA2N2o4TEhXdExtSWIyNUg5MTl3M0xPUjBWV29sYkJ3SUlCaHAx?=
 =?utf-8?B?OWlHVXN1RlVESGVGd2ZyVmVIRmVtZWF3bWRwZmdYUWtEa3AraVhxQnlQeDhX?=
 =?utf-8?B?cVJEQWJOajdBdkdIcDdveHdUQXR5OVM4TU9FR29hZUVYSDhJWTlRa3M0RVRH?=
 =?utf-8?B?WFBSTkNaVTBCVVBpOUprQ0drU3Frb0pMN1J6OTZSeGh6eE5NdmltYnRlTloz?=
 =?utf-8?B?ZWlpbFpsdkk5enFDcFc1ckVZWUNZZlMrVEw4REdHTWNLR2xVSi9wWXU4Z25K?=
 =?utf-8?B?ZVU5aGtSMXRsV1ZrZlhacmMyQzNBNWp6d01HY1pWNmpSb1pCY0M4WTlwNFRz?=
 =?utf-8?B?U1N3NzNXeGNTMVRtdG53c0lxaVZ4WklLZFhtdnRGTVhweW44UG51N21PL01G?=
 =?utf-8?B?TE1TeGdpOVBGY2x2Q2c2SGRGTGM4bUl3dWcvWjNJS1NXYVZCNHV6aVQyQzZV?=
 =?utf-8?B?S0EzNVNGOXFkc3pTbVorZjdOTVRZNEJidXF5eXlPOU50TGVGd2V2YlhMUUJX?=
 =?utf-8?B?WW1SOGJKRXg3MGFhYkQxQkU4YlpjY01JWi9wNmE0M3l5ZmJ2bjRlVmFzdHh4?=
 =?utf-8?B?ZE8wWWdGdVRTcmE4Wjc2SGMwbFBmVzRqRkYrVzR4YW1hZDNtYlFOV0FPVXhy?=
 =?utf-8?B?b0JKY0hkcUEvdDRHWTZLeEhDUnlqSmlHVExobnZjUnBPUHRYbC9jejYwczZ4?=
 =?utf-8?B?d2FPN21vQVprTXIyd3FQcHBCQ3lyZ0txMEZqR0xDdEY5SzFRaExyQlNCWVhU?=
 =?utf-8?B?L3RrMlEwV1ZvbCsyUUpxNGZTby93cUdaOGtsWFVCSWtuWmxqZUw2MVhrcjBW?=
 =?utf-8?B?QzVjWTBkSVYxMVhvVnJYQWIyY1Uwa0NBTUJvR0d4cCtkV3Zpa3ZOaEdkMnho?=
 =?utf-8?B?YXdoaUdqOVlqcWUwenhtRFVScTFuK1FuN1pwdFFvbGdKSVhCc0s5OU1XMmh1?=
 =?utf-8?B?cDloRVZ2Nm5XMVNnYkgvS0VDOERoY1ZVNWpiNFRvR1M1V0llOGx3S3loRXV6?=
 =?utf-8?B?SnUxSnRnN0o1ZkhQV3ZDWGRPcnR1VTBQUHdNdG1hR0g0cUJHbjJpNXNQNzFh?=
 =?utf-8?B?M3ZWTE4vcWdlRWhPa3AxSlladE5EenJDMjF5ekFjcDF4SVNiaEJqL0Fwc2hP?=
 =?utf-8?B?Z3B2QzVrY1JNTFN1anhMMmQ4NFJiMjRHK0hrcFVsVFBqekVvKzVTR09DMHE1?=
 =?utf-8?B?WU9Eb3pBZ0ZpYjdyUGpyc21GRmk1VGJ1UUFqcmhOZVBTSmpBc1R3WnpaSGlQ?=
 =?utf-8?B?VzM1VUZwVVdMQWNVaHdSSHRkb3dsb2xsa0RhVXREQlhLdU54Uktxb3BPSXdY?=
 =?utf-8?Q?Q9+lBad+IFfyH2UE=3D?=
X-Exchange-RoutingPolicyChecked: ogSiELdzTR2h8NzjbhFinjBktAuOttpSdHG7Ui1x6m5X7U7wsobokMF2B6cqB+SHXTi8vPXBKtisTtbwAQaJJIjYoKGPxFBarsmtWQemRgf/eYTOEZx9t7QD4ub1nxKlSRS0cj/q8UrrwTXqqaUK7jy8k/K5fuoH0JeJzXOpqjWWlX4VTHoEyOpatHXo1K6is8WHxKCPyDU/f4ybub6sobmQQ2TzHS4nuFd04Re/1Qwr0dDdwx6NPbrdxreZe87Kx7wg0098zQY4i0oi72VgyDbjR9J9A+8fuO45gj+7t1ge81kyo9GL+GmceaMUOqSHJ6h8722FQddCOrPoecAQ/Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JCCgSNaGQx3se1TU3YkraDXJRs2Th2zctcx1fFVTFDL5VnVkNpEwYzvHgnZtoffnFNaIRCGwCkB++t8GAowRj04EcRY7pRDN+VXxHCa668odvovoe7n6EImoAh5zkAXlX83uv6lTMnWa4wWgGaSL5kNT8q9hFBO/PGYZo5g1Hzp4gI/ginQ4ruSAyxlKQk0i30C20MgHlQOFT4txViZvw5EEyUZXU9ijA3ifw4N0OrPx/p/Aip/oHxUYCyxCEMpFXq76n/8GuoTa3kzSmPhNQPFfiuH9b6gk0+0WPoN9bCdF7sd04iAXHZzOn2rSon4ROIRb6vRzXgqOgc9EWFcGTjJsIv4UpUoy9HAOM50ZrtqUc4pbddPMWH/iWCs3pAQBt3MjjWhil03Y+EijNHR4P67UP4h8RFFaCfuhqpvptuBFQetXg+Ouif+DOIm6iYtrL/g8dhfrN5cOcf5uo1cKIWiqGUsKUotVf3s6iMBKcc/tZTeX552UDokvWF2b3Jb9T6hbxWqJz+vBfPwmpLP5wdLupQogC7bo0MDBm7AHJxlIcHXxNlzj8VgjDiParoQf/2S4E4mBW+pFBPoVXXT4uulSXEYDmkYlRime2FznIIY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4af954b-3af4-4e31-5e51-08df468f1edc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5506.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 22:47:42.3042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y54nYZe2gMgS1gSkqBhKBBL5MSAU3pG6n6qqhShpZtUIGxpFL3a3UIeVhwt39Z27JR9W8U/q2f0GZ1LcVp2mcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611190091
X-Authority-Analysis: v=2.4 cv=f+Ldl+yM c=1 sm=1 tr=0 ts=6aff7c92 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=tAKBABXEhLkWl1_B2i0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-GUID: gLsEDTmzs5K9RDe36z4XA6j_L8dPSEKd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA5MSBTYWx0ZWRfX2zoJ6juY05jh
 jrQoQAHcMmuHKUgEvi8aGIFiQ9E2JFAohqPThQ+pjVps2ia83N+CXe0k8W8R+9EXtjsof3e9aaE
 t5SN0CsiEnkBVYHSl5VsaePubF0tSAjk72J4RK8DPgHw7Od0/nKqICo7I4TNYB7phGchJCHZ5h4
 4rd2ODtTefvLeB6rD82OTwWbiHsXLVSlT9w8Fu/rzeL1TfBHeORRBAq6hsLM3/1m72HoLmhGxcL
 XoYKxJMO8vZPpAK9oP36ztJGBYy8i2VlYFQQuQVeD64SID/nJxdd1vmWcCNFaTW6L0eku4Vnj+G
 c7tra7YQB0TUpiy9f+E55qApnApPbBgWwZamMF58ZI3WsFl3iv4mgHSiKTvYGlBLgLAH+X0sipM
 1zSwusFleXXqNaVHNQhLESEsKEiNSkDQeh0dTGHVCxYYAJBwuBOWdP6sfHf4D+a1yIgCp5fZvKy
 5bYtJbnzypEXXTBs3NVlj3q4hQbBTggfYhdxFrvE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA5MSBTYWx0ZWRfX+3GpeeEChzN3
 exbX+BpHe+y1O5GJqbVORnqZRfdqDjP2I//X5btRcddAl7vCYLhC6IjtxdZInD0QTO2Zv2+T9qO
 Ili764X/SHvnAUWhAwtYXW1eJWyTl/2zzndSbTzvj6xdE/qgFDqF
X-Proofpoint-ORIG-GUID: gLsEDTmzs5K9RDe36z4XA6j_L8dPSEKd
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Wed, Nov 18, 2026 10:32:35AM -0800, Fabiano Rosas wrote:
> Dongli Zhang <dongli. zhang@ oracle. com> writes: > Hi Fabiano and Peter, > > On
> Tue, Nov 17, 2026 11: 25: 50AM -0800, Peter Xu wrote: >> On Tue, Nov 17, 2026 at
> 04: 01: 45PM -0300, Fabiano Rosas wrote: > Sorry for the >>
> 
> Dongli Zhang <dongli.zhang@oracle.com> writes:
> 
>> Hi Fabiano and Peter,
>>
>> On Tue, Nov 17, 2026 11:25:50AM -0800, Peter Xu wrote:
>>> On Tue, Nov 17, 2026 at 04: 01: 45PM -0300, Fabiano Rosas wrote: > Sorry for the
>>> delay, we're all swimming in slop these days. The only > feedback I have at the
>>> moment is that this feature needs tests. What's > your plan in this regard?
>>> 
>>> On Tue, Nov 17, 2026 at 04:01:45PM -0300, Fabiano Rosas wrote:
>>>> Sorry for the delay, we're all swimming in slop these days. The only
>>>> feedback I have at the moment is that this feature needs tests. What's
>>>> your plan in this regard? Can this run with nested virtualization? Or
>>>> perhaps is there a way to mock the kernel interfaces and ensure QEMU
>>>> does the right thing even without them? We don't need much, but the code
>>>> definitely needs to be exercised somehow.
>>
>> Thank you very much for the response and suggestion. I will follow this to make
>> the feature more robust.
>>
>> So far, the only way to test it is through kexec, which not only takes time but
>> also isn't friendly to unit testing.
>>
>> Based on my understanding of LUO/KHO, with the latest mainline Linux kernel,
>> once the fds are preserved, there is no way to retrieve them until after kexec.
>>
>> Therefore, perhaps we could implement the LUO API functions in QEMU through an
>> ops interface.
>>
>> 1. The first idea is to implement an emulator so that the ops interface can
>> support both the real API and a test API. The test API would talk to the
>> emulator to emulate the preserve/retrieve procedure.
>>
> 
> Where does that emulator sit exactly? Because the problem of
> transfering state will be the same as in 2 below, no? Since QEMU source
> needs to exit.

The emulator can be a daemon built from the QEMU source tree. QEMU talks to it
over a Unix domain socket.

For cpr-luo, there would be two sets of ops:

- The regular ops use /dev/liveupdate to preserve and retrieve supported fds,
including memfd and potentially VFIO in the future. I actually did some
experiments with the PCI/IOMMU/VFIO LUO patchset and was able to preserve and
retrieve a Mellanox PF from QEMU.

- The test ops use the Unix domain socket to create sessions and preserve and
retrieve fds. This simulates the workflow for QEMU.

This would let developers quickly test the QEMU side with different devices
without having to kexec or reboot.

For example, I often use live migration to a file to validate QEMU devices.

I also use live migration to a file, reboot host, and load from file to simulate
live migration between two machines with different tsc frequencies.

> 
>> 2. The second idea is to implement a set of test ops, with QEMU launched by a
>> parent process. The source QEMU could preserve fds, and the target QEMU could
>> retrieve them through the parent process.
>>
> 
> Something like migration-test as the parent process sounds easy enough.
> 
>> 3. The third idea is to implement something in the kernel to emulate a quick
>> switch between outgoing and incoming fds so that we can retrieve them
>> immediately after preserving them.
>>
> 
> Anything in-kernel would have to be part of a larger LUO testing
> approach I think. Otherwise we waste effort. I don't suppose the kernel
> side has any sort of selftests (or similar) for this?

Based on my hands-on experience, I need to do a kexec reboot to test the full
preserve-and-retrieve lifecycle.

> 
> What can we get from /dev/liveupdate in the host without having to
> kexec? On a quick look, I see systemd has a test-luo program, I wonder
> if they have a way to test outside of a VM.

Based on my understanding of the latest mainline Linux code, new sessions are
added to luo_session_global.outgoing, while sessions from the previous boot are
added to luo_session_global.incoming. There's no way to switch between the two
within the same boot, so we can't retrieve a session after creating it.

I am not very familiar with the systemd code, so I asked AI to check it. It said
the luo test in systemd doesn't try to retrieve the session until after a kexec
reboot.

Thank you very much!

Dongli Zhang

> 
> One other aspect aside from the normal functioning of the feature is how
> does QEMU behave when the host doesn't support LUO or the configuration
> is not quite right. Although easy to fix, those issues tend to be
> numerous when the support for a kernel feature is first implemented in
> QEMU. A test that doesn't access the host at all might miss those.
> 
>> Options (1) and (2) seem better. While (2) looks easier to implement for quick
>> unit testing, (1) would be better for testing with arbitrary devices and
>> configurations in cpr-luo mode.
>>
> 
> Let's understand a bit better what the options are, but we don't need to
> do anything fancy, we can improve the testing as the work evolves.
> 
>> Thank you very much!
>>
>> Dongli Zhang
>>
>>> 
>>> Apologize from my side too on being slow, I'm going to start reading mails
>>> on the list this week, but it'll still be slow, together with other things.
>>> Just to say, this one is on my review list.  Sorry again.
>>> 
>>> -- 
>>> Peter Xu
>>> 
> 

