Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11724C55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpYZj-0007d4-98; Thu, 30 Jul 2026 17:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wpYZW-0007Zv-9H
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 17:45:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wpYZU-0002Hb-M3
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 17:45:46 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UEtpp01475446; Thu, 30 Jul 2026 21:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=vMJYW3+4pW72t1eDYeFdssASlm0/5JpSwdiTdmmZ1WU=; b=
 LlLFQgbxv1Zfz1o87yZ/8hMO4CB5CBHlO3krviT/mfQa7/AAWE/JE1xsCro/jdmR
 nBDWJ82zM9zoW8Bq/Pa8IJf99eWS6MRGzs56NCB453H98JjEUSoDNVPkt2U/qUhA
 08vJ06nMXusmhgf4LHkIlRkUxWzzZt1eg/x9PwCOZORC1yd47l7VGBnNvtbmlW4l
 KSmTUV5sALlbeMva01HkA+63riIoCtGICWF1ZD2BEEsedkw1Wtd0y4yCgn8a3MSG
 L1UeX411+VQadwM+yOXtj69UeOdnyJOYTMO//IKqLpCK6L8tLkkn8FKRDoIff8yd
 ephsFQ/XaIp+jtJgv5Ry6w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr5y0jxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 21:45:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 66ULeXKl038000; Thu, 30 Jul 2026 21:45:36 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010023.outbound.protection.outlook.com
 [52.101.193.23])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4fnhenqmxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2026 21:45:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apcSU6ZsV83wZk9lAdkfIxC85667JtJ8SYgcx+RNYOKo1OJjUQ4bMczdg9Hz6rQ3e2zyl+adm7J5XbvwtvBsKgBUM3rs/m2CRZfmO0m0nd4ATt3+b8pQaBuVb29TSmjfeLB321kuL68Knf4/hA/EPRB4Ga4RnQ7Yrujuxh5KHR3HDprSG6cJOEihFLho+F5tT35B8xPGipF/S5aQKZUpgKUOqoZGEz3sHM/YWcqeEvm+icg4lDboEt198Q8/8taH1IaC752SghMyiHP9U/BbakfmQI1zFBs++spO82wjl53e3CBsNQwt1DNqwht0uU9QRb8jcKZfkAgNF8y90GXlhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMJYW3+4pW72t1eDYeFdssASlm0/5JpSwdiTdmmZ1WU=;
 b=VkPHWkREG5eJ3/b7dpzGRg/X+jWjMPZcwsPIFGs59uGdilZ4TuSueg0ioYo4SFKzeC9GftqBbqTRMJnmkQXAi9Vb0OON4J7wf4fpf7K6K/0LIPX4QrHK0xJbXDWA4KDuYECfdCpEbm4CfXO7zBmWASFt8ochx9FGs4tW/KNjPXuV+DY5upZYeQ0a0k9ruuilubD8AwDk3VM9K8NTbzGn5eTGLHSGhmCPMsjDY1Ej+ig/dpn0QRCviPP0ILBz8/SBwFtP+JD6L3QyhU7MyNO0EPm4fkolP99yvTXkK9LEfFfTcelEWiblkVUYVUcPT26/zraH+s0tkpDv5I/pCPTWWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMJYW3+4pW72t1eDYeFdssASlm0/5JpSwdiTdmmZ1WU=;
 b=KVg9C6jIklHkoi2janPSiJ4zxR1t7Mw/OMuD30O7mQ5aGIzQcbaG4/JBrOLm07CB4S/nyO6z44E40fsW5z17N+3t/KkggXDhsQHulC9Wwmv5O0YzzEyobqnl5q3Bzz55Ipv/g0bUiSTNkybY8dXxFQ4jOzEB16GBmmtH4hcHJDY=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by DS0PR10MB7128.namprd10.prod.outlook.com (2603:10b6:8:dd::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.15; Thu, 30 Jul 2026 21:45:30 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.21.0245.012; Thu, 30 Jul 2026
 21:45:30 +0000
Message-ID: <bd81495e-522e-4954-b8ff-95e2b08f171c@oracle.com>
Date: Thu, 30 Jul 2026 17:45:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] amd_iommu: Return empty efr for stub call
To: Sairaj Kodilkar <sarunkod@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: vasant.hegde@amd.com, suravee.suthikulpanit@amd.com
References: <20260511123937.32743-1-sarunkod@amd.com>
 <20260511123937.32743-4-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260511123937.32743-4-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P221CA0045.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::17) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|DS0PR10MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 45870334-6145-46e7-5ea8-08deee83e014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: g+IHXpATBMVyS+5P0JEi6ZxJgzw2MFYo3nudPIES6yinLMRFhvmMotCxvrAUHK3iPs70Ilt1C19izByxi3SUZMfD+vMXNmovFmcpRhNoEV9Fq6bvnmClaEbqYVDnbjkxXrQH4bxRuwHaUp5tcrUhNnPQN0n6esO623fJmQTZ3giRUX9W1UN6yvJbbdeOZMTa/m3D+odcA2lVfgz7EnUw0xJqaBdthFDJxx2n4vdFMUWtsCUTZVXUAGPUrYMGSQnwzhYc8JLOjQgD8/FcbglXukwcCcpuBM8M3XsnDkgTQqZVvvUmeYe5oEYczyjQbpIWOTTdJFwl2m68FaDgzj2rlNSj1TW0iYD31+zidZn4OZOdYWvGgOJFEqNsTdRbFd8axAVwHkxDdPhIhaScolgVOoeCrz0KeEEErv4EqZdBpeNuQvtg8oQWTZi1itp8PVjyyPmPu9JD0JJFeSQyKKyYSWj5YRgXd50BZ+OEuSDri/Q5BIwK58dM3/kG0cwAL/0cmEPoxWywPcTh8g1BrY+kuj2AC68KPSgQDPKRxhu4Bf/BijKkyQjL3y1pE04r/CrQaPNcZ6yKB4kBNRsFkb/cSAM4utqyudQ1TX3HEhB+xS8OvluERRQr/Mw7IzaIt3+Hfi6xrAXVpmO/9TvSGCvZDU3ye3/IEqHF0u2cadT1FQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEk3Y1VQM2F6V2d6SHNmNGJRNXY2enRiMzk4NVVGd0RneEhRVEM3ZlpGV1N4?=
 =?utf-8?B?VVgrWUxPZHZQd2pQN1I1ODdEUzdReHpxY1FXa1U0UjFIRGxQalEwaFh4QlM1?=
 =?utf-8?B?eUdBTXBqWnBxWk52S0dSWDFlWVBFUjBJOTExY2JSU0xGUUt6S0paaGRzWDRn?=
 =?utf-8?B?ZXVQK2pLYS9SdzF4c1VISlVnNmtJVW5zMzBPalphUjMxeW14UVE4Q0pjdktV?=
 =?utf-8?B?ZHM0NW40Ykcza0VQbFAzNXBtU01LWnNxUm55Tm5UbXBWNUdmV1huN3ZnTksr?=
 =?utf-8?B?bStHV0w3UEVMRHlFY25aMVpKOVpvVWJ6a2NkMjZ1cnNjSnFUdEhDdHZGWVdm?=
 =?utf-8?B?Vlg1WjlhS0NCMkw1V1ZxeHo3YUZQUHh0OFRnUmpSdUFJSkhqRVRDYk45emxr?=
 =?utf-8?B?NDU5b3haTzc4VExxaTNKRFNvKzl2R3pRUHo2TlZETERWaG5wU0loS21paGJi?=
 =?utf-8?B?MVlublk5OWx0L3ZhZW1OWkg0NUdGTUJhTDNhc2Z2YTdpbXNZR3JGUUU4ZU5v?=
 =?utf-8?B?aVhBMC8vb215YlAvRmp4VG9qRGdSU0dZcVlXUDVJQ2NLazJ3Tld5SlhYQkYw?=
 =?utf-8?B?c1JZNW1CQ2laODd5RExDUXVaOEJ5cHZZWXdSWWwvT1h5UnRHVEVDYXhTRm1H?=
 =?utf-8?B?aFVTd29MZVJDc2NmWXpuNkk4c0ZNeVcremVMSm9Kb1M1TzNWejQ1SVBoU3Qx?=
 =?utf-8?B?ZXJhR0tCaWc5OG9zd3RZc2NZT1dLT1pXYVAvREZSTDRDNUYxNk9uZkxpRWEy?=
 =?utf-8?B?VFVJQThzdlVQWjVSS0I5VlRRRVErYTAvOVdOdm42Wmd6MXNNMjNrNzNKNHZq?=
 =?utf-8?B?UExEWGNmYXRSdU50NXNsZnphT1p6WEFabHNXUXNYTzB1aGVQbVM4aDFJUDBJ?=
 =?utf-8?B?eUNhZTRDQy9ia1ZCMjZGdzczbzJ4ekpsYy9iSUdVRllvY0I0c3JwMm1NSGU1?=
 =?utf-8?B?WDdlUDBjeWxwZFdvUXhRUndvaFFaR0d0Tk1lZWg5eXVDeTY2cU1LRldHQity?=
 =?utf-8?B?TEFaeFNROEJSaGpScEtjc0ZCaFR5ejlUVnNyQk1UOHJMQTZNZ1R4OWk5RUtn?=
 =?utf-8?B?OWJWZjJTeHFUeWpkblBRTzNDeHFHVm1QdWYva3oyQWJMZ2pOQkVaWjZQL2No?=
 =?utf-8?B?V2ZqZ004cWMrbloyTHplYUNONHpUV1N6T1VJN28yaytTQnVzS25xRjlELy9U?=
 =?utf-8?B?WnRveG1IdUQxcE9JUHBvUnRUcDhyVDJtRjNQYzJUMTJCM2FSSDlxY0xwVmtQ?=
 =?utf-8?B?Z0NaSkpFLzNBWlgvWGFJcFNPTTR1UVVGdGVmR2pOS3dpTUpGR2tqQ2J1YWhu?=
 =?utf-8?B?ZFJYT2dpRTdsVzgzclhpSXU0enlFSm93bjhYcWM5M0ZmU3B1QWR0blZBaFEx?=
 =?utf-8?B?MHlOY2hkOTYrbFRoVVR5Tkp4ZnkzaitXRmNtOUtFMStpZUtYYW5VSGR6U0l5?=
 =?utf-8?B?dCtsTjZBU0xoWlRwNTZqVzIzeDQyT2crb1BqdzVmcHdCY0dxTVFrQXpWV045?=
 =?utf-8?B?b2VscTNpMVVuUTdVcmF4cS9sem8zdUpBc3VQR3BTMkZBQXNDRERYQkxXOEww?=
 =?utf-8?B?aDZvS3NETlBmYnNUYVlXSjUyVUVtYzhoOTUvb3RFdGlFNDdhSnlhT3d1R0dC?=
 =?utf-8?B?MVJ1aC8zUEowd0lvSmc5ZnpJS1pFMk5wWnB2WVZ1OWI0N3Nmdk1hYVlBWnRm?=
 =?utf-8?B?b0hRUytiNFdlVW95Nk1uMGxnM1N0Tzl6UmVEaldTT1B5a2owT0RVOFI0SkdO?=
 =?utf-8?B?YzQ3Sko2TUlaZmtFdnZKNVhPOFZ2LzdNVHR0c2NJRlM3NGlIRmYvU2MydDJm?=
 =?utf-8?B?ZEl6OUdyL1J2S1Z2T0tXaFh0RGs1UlpiRkc1cG5JdzB0N1BYbGR5R01kVTZW?=
 =?utf-8?B?VWhpc25JdmxJak1UejJ4RytwL3l2N2VjS1NZb2xrblpiMkp2V1o2ZzAyTkdM?=
 =?utf-8?B?Q3N6bUk4VGV5dzQ4TFRCbU50c3Q1dDJibXI2V01qL01QTFJkRWJvaG1VRHJM?=
 =?utf-8?B?Wkg4VkZENVpnWUZWSW1LVzNqUTVkazJsTVRPdDFlOGhmaXMrb2s4TmhLWldw?=
 =?utf-8?B?dXpsM3JINXo5UnZ5N2dmWFBZa01MbWtId3RJbWNkVVNzWDVTM2Jhd3B4dFpB?=
 =?utf-8?B?cWdKa2JyQXhEOE5qUmNac1lHRldWUDB2bDJBRFBybzBIa3RmamRkUlVPeCs0?=
 =?utf-8?B?VG84M2IwME1rTzJldWpEQXBYZUNNV2FQOCtYUlZEMWVXbXB4bmpPa2kzaUJH?=
 =?utf-8?B?eFlIa28vcGZITTFaeGE3dTYxVE4xUUVOcm1VTG85ZVlJOXBYMU90ZityMzkw?=
 =?utf-8?B?MVgvSExKUnNoNDd4RThkekZJdjhiRG5MY1BHVTA0SDJkMEdXcERCajUzYmU2?=
 =?utf-8?Q?edTgHljrM3wMdbkM=3D?=
X-Exchange-RoutingPolicyChecked: sQVGZF7Ukh0RJRLjOABxeUJMXPPlSFKTyqS5ToZZIEDk8/cAWd2UlZ4FzzRTiwtVKlLtl/BS1tylukojRl2Ir9h4/YVzlhn9oPaET3O4bzwlMMFSg80uGVIFYAe+6v9uVjFX3gNzKt/sjMlxn7mJ4d0qqpiy95RNZ9oUejlUtjjoLyOi4TR9YY69rAebpW+lEE45E0Oz1J6uNqH1U7kVg+Ub35BP/c/A6j9OudYtr11/dadzItHA9kalTJYcwnEGxXPbyjAyxHuLT3X28GlYW7k9p86+zXTCLJ5BaaxhfjfqX1D3nAsVnU/MU7Ok0k2p/0AI++HUwPkRy1r05DMh5A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bUhUoqEMSCPV60skagTSeK5iG4lFfFbHcv9iWUQB3l0GbizH/pWdqgJ7KBbrDB9daOl6qIEiQ7oSY6FOshJzkuwrg3aNmlQjas3NFTR+7S8tPl0Gj1TnByh6d+kg5fRpxiMgttfaxNs0ece7lEOWkCK47j4EiLobLOREhq792el/+Mv2jGZxhP9Vy+lMijpxYEwRnAue5qK4F+PJXCgExlr5mc0YEfL2SgN7s5pGm5eWSrgyX/nONk0P7SC94ZbdRfLncQzaWKG18G/bBYsz72rllyjJYUsCIdewxprHYFgjp+GAkEtQvf2JRvpjsAXLgl3tnP4mfJjoP6FSraUfywBN1SeoLq1QfLFtx/Jo8DWMqGEQFmG/Kr8PfYUp2kJ+YfA+FjFqxfj0mNXj4rYdVICx/q9nvZaSs6bibsHqTtQ1P1fEPiDrzxbf1qI5wr8OetsBF9Lz/ORnGfM6OgJJX4v2SnC/KbtABLM9VF4sFFu6P2OLu/fMCTiW632Qag8CqBJhFXgSDTa32KJTMZ/nynn0WCFIs7k5vw2ymcEp9RvXf3XjzTZZLdGX9qe0gcxsPqmv6VUB7wq6GebRbpaK0hyHV6mt5QHBObaofSCCyqM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45870334-6145-46e7-5ea8-08deee83e014
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 21:45:30.2466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NO15HRKQ48L3MmTjAOwNBIjI0OMSZy0J9w+83F5zfifOZ2qm3EnZxp7Ww+8khd2dOVgwaYpraUCn/9myzOrP8Fh23FqRLg3AmGjxMpjdV9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607300156
X-Proofpoint-ORIG-GUID: fV7uZhDenNRETia5HO9YnPSXXd_7UVx8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE1NiBTYWx0ZWRfXxZH/5rlQIjU7
 K8A/DvZj3Pr+uSIHHD95Mz/KumCjvevc1UtfHQRJ4xHRhuEXX1Exn58qKnFLMgfvd02M2I4Cdzz
 8aUjUoWwhK+yRQESmMvlXmGMxfyva0BBpabxenJHt3pU/Cg4jOA0YlR1Qcqifh9WjnE3TtrY49r
 hYE1uMXraYv1gouSc27PbetbwVsXyw2y8Vv2nChJiVUKKadj2yPKQLhKWDjIPeiK8NtG2BAXFFj
 Sb6ZE+S+Tj8KUh4EQLWd8V4oxobN4DSoF4veM64tyRLv1Atj9KY9Xu48NRDLZqbLWalTiVX8xVr
 Ww6BXsZ9TCASanXWOMgTNflizhTHgmDKhaT/BV9u8JSW3hhbjBu2lLIX4kZoggX3hZZ38KMcDSK
 S1eeXvXNiaJaEe7kR80T2gDs8P8BgNLFiH6/uSmaVSzkFzjNRLiXMc27DspS7MUGyUa4jGz70rg
 MiFwRnVxtwfsWgySA9g==
X-Proofpoint-GUID: fV7uZhDenNRETia5HO9YnPSXXd_7UVx8
X-Authority-Analysis: v=2.4 cv=A6Jc+aWG c=1 sm=1 tr=0 ts=6a6bc600 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=zd2uoN0lAAAA:8
 a=yPCof4ZbAAAA:8 a=EdtI61k60ghVUAyOQqwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE1NiBTYWx0ZWRfX6g784PacGBS/
 plHDnrEOIcJB9GPXLC6jbQ8usw5QbogP7DEktUeaXOXHvzmurDqqfFtmBS6PWLfwSomTP0WREJG
 sDXW64aBFUNypEmJpewBqjjpm7V02CJxQi3Y7KXIooC0pmVCmeV4
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 5/11/26 8:39 AM, Sairaj Kodilkar wrote:
> The stub call should not return normal EFR as it is used as place holder
> when actual AMD IOMMU calls are not available. Hence return 0.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> 

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

> ---
>  hw/i386/amd_iommu-stub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/amd_iommu-stub.c b/hw/i386/amd_iommu-stub.c
> index d62a3732e60f..fb36dee903ee 100644
> --- a/hw/i386/amd_iommu-stub.c
> +++ b/hw/i386/amd_iommu-stub.c
> @@ -22,5 +22,5 @@
>  
>  uint64_t amdvi_extended_feature_register(AMDVIState *s)
>  {
> -    return AMDVI_DEFAULT_EXT_FEATURES;
> +    return 0;
>  }


