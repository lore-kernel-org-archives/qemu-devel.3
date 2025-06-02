Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F10C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 14:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM63r-0004Ce-9y; Mon, 02 Jun 2025 10:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uM63o-0004C1-RS
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 10:22:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uM63m-0002RX-It
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 10:22:44 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552C4WUn004599;
 Mon, 2 Jun 2025 14:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=jrDsG7zS65kn34vAetPxMhK41COOAx4opNtvkyTpPLc=; b=
 Y9AHo5awoxEbCWHoOlA6PZzg+58sH+wcD5omgpGq4848dFv7OHY6jqhtyrhi5YTR
 uqeE3Y2Sv2d0Lm/FLUiquXjkB3PRi2Hy5KoaGH6wTGMtFYOrxdW0Z7GdxSwzKmyj
 D3KaoENVearP6Xad1vgNd74rkTj2Zj/+K+Ka+AuTSciFutCe3QLHkKprjGFotbYB
 gklcncY4VNHOOouzAg5HjPzeB934Ze7gGW2nscHeBbUGy4tt5vJuMmXQlANsSBKn
 B9rhsfGFYhBrUeSnTCNolaxEEb9v1CYV45jGEQaT1jDw0eH17BYScR+5rYZ5+nFb
 cHXNBN47GsFEnfg7vJPlVw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46yr6far6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Jun 2025 14:22:23 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 552E1pFW040614; Mon, 2 Jun 2025 14:22:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr78a028-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Jun 2025 14:22:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYCmHZGooSysplza8FiOtxhx5H2AwZQu69EU1pbZmAPhg/ZQtKJqSpnSZ6lIiyEpVbuEDIdEEig8CYPvG6NF4IDQMZ4BJOq/SjIZD6liSa78utnZJ/drOGbpvJO0RBLgys+1z9uy3GcZGpK8C965WeKiWDaB+/pxLKyJbMqvnc4EWnXm4axs/wWgejrY2E/7hPUwNa+QlitkW9NPfNJABOl2FqC8saqTFL/8989jd3ijNcBFdzaXzkb+qGoADjbOTKDc/I++IZgSYwOuLihIG0QisfylZ5lStwpnzd83NLwL/CsTGggMETzq0aShR+08l16uUkRdKah10fPpVjSTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrDsG7zS65kn34vAetPxMhK41COOAx4opNtvkyTpPLc=;
 b=ScdEuh5aKfjtRjQdAwyix4IhNb7dozrsE/ryfS0EvC6CjE6mbA3vL/haLPit5mAeDbIBWuhWlphll2BTAhaVKTFd1Du0I3j2AGnU85dOnmRrea7nJzjSyDe1TZRpkMp/PhGVsOpNiuuvkuPG/9F+X5yNavocqU4Xl2QqD9V4rEsBkbS7OuwZd6/vDXxxQhooEaO/SomZ/qKypBSacby4WHipL6MtFX2Ar4MqX3v7Ex9K69hL5AUSS4RydCFryJ/VxZfKthG0Oa/gh9dzKBszL1G4azfY4aqC4t927Lc3LrTHAC1owxPqZoRlUmEFF9j5bYI6oxS0Fq1+BU+k7m8b7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrDsG7zS65kn34vAetPxMhK41COOAx4opNtvkyTpPLc=;
 b=ZhQHqn7Js5NekggmE+TKNASGHgP49PCgWriy8Ah2kVHakS9h3YVAzZ2vprO9fRePGCq78HpnO2lYAo+ocnDfx2ECxw35N5tTGG6gfvHr2z/drCzlxZaY0n/vai6U9pfxt5Q6NKCafV1Bsie7HL4BNVagpO6ua0WLbrp34cgTr9U=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by SA1PR10MB5824.namprd10.prod.outlook.com (2603:10b6:806:236::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Mon, 2 Jun
 2025 14:22:20 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8792.034; Mon, 2 Jun 2025
 14:22:19 +0000
Message-ID: <9c70e4d6-4b70-43cb-aff1-9e495a061ccf@oracle.com>
Date: Mon, 2 Jun 2025 10:22:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] acpi: hmp/qmp: Add hmp/qmp support for system_sleep
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 slp@redhat.com, eblake@redhat.com, miguel.luis@oracle.com
References: <20250528163545.2143-1-annie.li@oracle.com>
 <20250528164219.2247-1-annie.li@oracle.com> <87wm9ujxok.fsf@pond.sub.org>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <87wm9ujxok.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:208:32e::14) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|SA1PR10MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 98fd3005-7f52-452b-cfe2-08dda1e0e22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1RsQXJQV0ljSHJ3UHNLdXhoN2RDSDRtSlA2c1pzVXNocHBtY0t0SUlqejlQ?=
 =?utf-8?B?SlBXdWFWWlA2UVVldGVWa3NIR3ZGRDNrbllSZDgvVkgwK3ozYmNzQVhkVG9r?=
 =?utf-8?B?Lzl0UG0wWHcvbldlZVZic1NwMDBIV2pJTlVlaWd1MzIyU1pBQnB5ZVhpUFFU?=
 =?utf-8?B?M2RtY2Z0TkhMblN3TFFwOEw5ZFFzanNsaTN4VkJ2Zmw5Q1lIK2tDOU1IUUVF?=
 =?utf-8?B?bjZtbDhSRWNmY1hxNjVqVnBIQVo1RlBTNDVLOEV0bGgrV1J2ZGtZVzVhbFdO?=
 =?utf-8?B?Rk84SFJvWXRXU2V0RTN4blRlR1dqTVR6N0k2emxqMHpaYlhzYWdIZksrd0ts?=
 =?utf-8?B?V09zRmRBK25zdmlWVWNXeTh3Wkt3bnNHWUo2RE5uUVpvc3BoSHovbEoxK0ZV?=
 =?utf-8?B?UVJuYmFXc3BGd2ZjcjhuUk9rcW5vK1lZM0NOWE5SN0NxbmZ1dWpWU245UGpD?=
 =?utf-8?B?d2hkcTJCdUtVS3RDNUZQd1hFK3BvbGk3MHhFM2d5UG5ick1iODdkZFVlTHhX?=
 =?utf-8?B?SGxiQWI0SVBhTHZvbmYyR3Rrb2RhbUtJOThPRGRnaFdORVRqNmVjMzZBYVFZ?=
 =?utf-8?B?NjdzTzZ6VUphaXZWaGxaZXpld3NYUGtabDhwTmliSDFtZ25WOWFhYWpOZ1Jt?=
 =?utf-8?B?cGRPNnVNUGZWTW05R1JxQUE2N3FZRUxwRWM3TmM3eTRkcEl4UlNFWEU1UGow?=
 =?utf-8?B?WGpEcjVrQ2QwTjVSTlcrUHJQTEI5ekFMeC9jVnFHM2cxRDlId2FWbDRsR0g1?=
 =?utf-8?B?aW1UVjlMSFRnaStvNlNXRWlaSEc4ZDhnbFpCaE1nQzlPTGprVjdaYjZBdys0?=
 =?utf-8?B?aml0OFQ4cXI1RDg3TDJ5Y0JQNEMvYVhWUXRsL1Ryai95QnJZZVFSRDdWdUtz?=
 =?utf-8?B?YnlkaDV0TndsS2RvdGtQc052amQxbXJLQUZzY0ttenQyU2hoaWdWYVowY3Nx?=
 =?utf-8?B?RTBqamtoaW0xUnBTYzJJb0k3ZUpka3JKSjFuRzdXendyU214SXhvZm44TmMz?=
 =?utf-8?B?bHBEbi85aHQ1a0duWkZweEVKSlQwaEFxVUN6R1B0SFROMmlaTHd5SzdpVWFJ?=
 =?utf-8?B?Um9zRWJ4TUd1YXUrTDIreXZheDc3RXdTSGNDSE1CdEN6OFZiTmE0M0MxQjVM?=
 =?utf-8?B?TCtqR05Lb0ROeGhLOEdxWnRsdy9TczhRQTdzUzZQNHRvZmwveGczMXNFazZH?=
 =?utf-8?B?KzFjL21yOW9vcjYxc2ZpbzNONGE0S2FtekxDYlJ6VlAvVElqWC9iemxqN2lS?=
 =?utf-8?B?ckJDbFJtUk5sWmc1NUtnUUFWR0xUUmpqZ1pLWUdYVnZTL1FMOGRUMTRMN3hh?=
 =?utf-8?B?dnZvSER0eVN2UFZHT2JQdWJCK3R5NDc2dmEvUUVyMi9JcnlRcHVGYjE3RzRS?=
 =?utf-8?B?L3QzdUo1RmJYOGRWckFhRVh0eFpwR2U5MXd1cVUwQlBMb0JDK001dUdneVJt?=
 =?utf-8?B?U3JBYWtoVmowU3ZCTHdpMFltZzBpSE1MbWd4ME5UNTF0QjNLdEhMMmtmY3ZK?=
 =?utf-8?B?L2trSU1PeDdXRTFMWkpyWDBpMWxXeTQvdWVhMGpmWjh0dnNFS1J4Z1RWUk5G?=
 =?utf-8?B?bkFObzU2WVBLZ0hoS1I1dlgvblNaRVpSOGZwaWVlZjZZMzFPTGpQTG8wS1ho?=
 =?utf-8?B?WkY2dXBjbmZ3b1JyUGx4VThKN09mbEMzOFNCSHJSdml1ZlQ2eTJZeUkvQjYr?=
 =?utf-8?B?VnlNT2tCUlRWNmkzZS81eGp4eVdFcTU3RVM3b2RnOXNVcjRBUjM3N2F1V09L?=
 =?utf-8?B?ZWl4M2NpRXBVcFZnN1lFTHhrTW5KcU44Tmd0b2oyWitVM0k5UklCU0pTb0xo?=
 =?utf-8?B?Rll0WlhaRlJPdzhrUGpHMzd1cXRrVHdValJlWHVMRGJmUUZscHN2ajdWMUh2?=
 =?utf-8?B?Mm45aVJXb0pSNlZZMDhaZGVObTJ4YnFDTmlQVmpqaDZzQVJ2NFZvSElDaHhZ?=
 =?utf-8?Q?BFTrhw7n6Cw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0kyRHVaSjB5UDdIYWNNL2w5M0hyVzFLTnV2dzdFTW9uU2JFMlNXbit2cXdN?=
 =?utf-8?B?MkNzb3VmcTQxNGhjQWFQQitTejRoQkk0ZXpHaUxmblkwdE5yWlpxZHNveW43?=
 =?utf-8?B?QVZ2bVh3MnZJdWQzenlqeFNFWFoxdHk5aHFsUXhUb1lIdE9Gdmw4dDNBdEhl?=
 =?utf-8?B?b0M0OElrL1RHa2xhdDlZaVJIMk95eW9SR2VsRmpDQXU1N0RHcVQzSHBzNzN5?=
 =?utf-8?B?MWVGR0N0ek1OYkNUblpzbGlEd0g3QlpNQlVVL0FCT01mOTZFWFJEcE5lK3pM?=
 =?utf-8?B?NStOWGI3bko2b29jY1Y4NFdmNnhtKzB5U2wxNG11ak5BMXBuU0VBWGk4a0tB?=
 =?utf-8?B?QlkxbkM3TEJGQkJOZ29tdVFTekFhYlNEUFNsQTN1YzhndC9SMWMwdU81Q0d4?=
 =?utf-8?B?RW1EQWZmVUtqUGVDQzRueGxNelpYVUp2elNmODdwTUJrUHE3UU5VcmNzSVVs?=
 =?utf-8?B?aDVuNlFrZXlYWlNTcWVYWlVSZ2IvRHRRZ2NGQkJNVE9Cd1Vlck1MaEUzUHdt?=
 =?utf-8?B?ZFp5aFhJQ3NpZmNXWEJYSG9SdjBTNncrQ2ExcDhJMjFWNDY4THV2Z0RBZ3dq?=
 =?utf-8?B?K0YyZXArYXJoVEt2aXQvS1JHd2grSVA2akd6RjRzelJIY0crWGF3OFFMSUpq?=
 =?utf-8?B?eXVTWElNUzAyekRzSG5qUU9sVFJkeldBYTJLQzBnWitKeGk0TGh4RGVGckQ1?=
 =?utf-8?B?cGdpd1ZOeDJWL3ZibXN0SzNXc2VPTVFmU2JqWlBkSC9GbTkyVWRzVCs2clhU?=
 =?utf-8?B?ZEpvN09BeVBjdllxUEZJUG54NW92RGl6TktzNWhrTVNEc1NvandYeXQ4aVo4?=
 =?utf-8?B?RmlFaDM4WHhFMGQ1Y3dSY0taT0ErN2NWNng2T3hVVGVyK2ZsbjBLdjhYK1RN?=
 =?utf-8?B?Zkhsa3NDSW9EQnJLRmVoRzEzVFJZUkdxQWdMU3o2aE1Ha0xLSFBpR0VmWmtq?=
 =?utf-8?B?R3NnTGJRdVpJbyt6eUEwRnR6eHlCd2VIektiWHhBZ29zbXBZS204Zm5NYUYx?=
 =?utf-8?B?LzRLNWtnZ3NnNU1XRXlVdkV6T0JVZDIxSW1CejUybVVhTXpTZHAxUHM2SC9S?=
 =?utf-8?B?a0ZuaHhWS2NxUndGRnpzWGtlS0Y2aG1hUm83dmRJM0pabnB5U2VuMWhyY25P?=
 =?utf-8?B?N2V4ZG9ka0h2Tm1hMWJjaEpnZFhDdWdBemRWV09aV0dhL1pNNnZETkFDQzNZ?=
 =?utf-8?B?K1d4SUxiaEtQRlpqUllxYldDU0dMTHMwWXVPUDhjYTY1VE1JWkxVa3FRODhP?=
 =?utf-8?B?STFZU1NsVDdMZEJEaTZzclN6UHJ5RkVmd3BoTlRFYVZRME42UGcrajRVWjU1?=
 =?utf-8?B?K3Q2ejlicFc0RnFIMU0rMkpNMG5vUjYxNmRQUXNYVGRyTXMzeXA5T0Z0bjJB?=
 =?utf-8?B?SVZaT1VDeFBUdnRMcU1jaHlmL2krTy9Wa0IxOTlySXhtaU1MNndsZCtoQ3lI?=
 =?utf-8?B?L2JvV0o1QVYrRnNkc0JvK21Da0tOaVo0VHN1d3lQTlIyeUJiNlpiVDRDV1pS?=
 =?utf-8?B?OURob3Ezc29Cc1JYTjNTQ3VhN3cvUkRwdm1JWEY3RzZMenNkNFlVcTVZM0FZ?=
 =?utf-8?B?bE9PZmxXdml0QlhkMzR4YWcydTdOb0FIQnI1ZVl2elB1L09RUUtYZVZDZndx?=
 =?utf-8?B?NEtjRnIrb0RXZVlPUjJMSnNaNHdBcGlsN094RUpnaHF1NmRpWnRiNjR2NERs?=
 =?utf-8?B?MWVFcWx5TjFzOWFrUVZhSmJsT2VPZGhITzBya3pMYkI0RjAxU1BvRFRjNEM0?=
 =?utf-8?B?bmI4UTlSdFlxV3dnM2xLN3BhelNVSG9kTHhvZGtqNVNpZm54MHpJd3JsRldh?=
 =?utf-8?B?bEdQNHJubHRURTlIZDFwMlNidlNsbzJvMWQ2aUUwc2FkTFI3Y2JvcDFxL3VY?=
 =?utf-8?B?TWhTaUVqOFBXNVdXdjV6UTZHSTE3SktZSm9YcDY4aHM0bWRNZUpHOGNoWjF5?=
 =?utf-8?B?bkdSQUlRdjhlam5TWUI2eFJQMWFlZnh0VFlJWXNKa2czdHQ0L2VPOHZkRVUz?=
 =?utf-8?B?MmU5QXZyZlQyVENxQ3BmK2VyOFk1Z2EwblVBRmFLY3RiT3EvMkZpTnV3b2hl?=
 =?utf-8?B?RXJFT20zN1JnekVjWXkzRkFqV3ZSNDM0dDFKNUpYLzArSllNM1R0Tm5rWm85?=
 =?utf-8?Q?I+HJq7LXgkBlnMSwE0zGHeqLn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nbe8tQj1Kekt0jL/GG7ihGMKUrpBDh//nqc4A4xnM8ujUrTpStkU2fuqHhZYbUttS6dZEDFq8a6yAu3FuoaDOGNANotQULXgq9jIrtQdEB4ZQ6Hmt8w9ELnxD4eqAN+1JjoJoagf9wqHLF5HJcQ283HKKIgDoytPhRNbCSJxU6YZCiVn4d7vhxCb9aRP+9udUesKUn6twAZSXukUKgableru35/IvusnZM0TmjeRzZZRJVzGG/aqz9vSDuWyC4CuLzKLnEJIVNEecQKWa5TDsnF0kAPYrCeMtTOvYEr8f0O2jq1SnWyrM4MK9CaFfOG80uxnqOBZd5mVdwNeGKxfGbHQuXzplBNGptoRu+OVYQGYBfxJ45N09JvKRT9xkKF7K4PV9qnC1R1NP9F7jvkX/cZQW3ySRm2z1XcCJaiFG6fA6GAxfcQ1PmJ1F7bokk3vU/zUFU9NrBTTCS+BKICq1ECwj+u/yiRjbEq7/KPYrvYYdjdPOOfaBG3L8caubPGOGNKDyM5XRjhrI/B4DYLvX7SPD2YkOhUtsZnY2ofrwQAnBT/c2vYQoLVDvPdJIIgXzdhJyG422NiYXzD0jZtnt1R8m0fk99v1FcIaxUwBejA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fd3005-7f52-452b-cfe2-08dda1e0e22d
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 14:22:19.8778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKaiRkK5Z+Ag6H04jrI+ZZfxuFhUAXJyU6q+M7LAmjU5zYSm3JooF1y8Y0Q9KbFqkUUVPtMf6JbwQIBZNOiKjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_06,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506020116
X-Authority-Analysis: v=2.4 cv=G/4cE8k5 c=1 sm=1 tr=0 ts=683db39f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=rwYCaN6bB-bMODgaf0AA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: g10qvWII-IzEIDGYIE8znBCdN2YiUUjl
X-Proofpoint-GUID: g10qvWII-IzEIDGYIE8znBCdN2YiUUjl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDExNiBTYWx0ZWRfX65ZXssD6pQkJ
 LrpvNYjgmgO+koGvEzVWtrFlUUOA0STrSfLlNb6pfQuF3SfhmKa7LSg6JcGKCkPRZoI6lu0taiN
 Hj4UUcVLwwJ8NReNGga/g9OcBj/7Tp/9wK3m592SEjdViSdul15XXxxLPIBFao8qcDNDuswZLXh
 bopO2EqOprCoWY8thTUyYTjFCFN80FzveCPqd1LFBWfjzz9Mvd58xuw+4reydBXEGB0O+R1BX0o
 mHlvgMCZWbgh8Qwr4TOBB1LXRCAHmThJmMmxU9Pvjv1BuNtZ/+DZqibS4UOOLJwe/fMJI8R7via
 T4zmCGaXXfH5LhgewrscPztsNn3lFuf5YFAPyytijZCs2ppzeND/pWx+JOTfyw9j7XEzSRsYnem
 H6K1eWpkHD7RfnH++49NLmqW0tYVrIAYa5EZTARyvUF+H7RsVIkicfnfJXFhlNgaJORV0Cr5
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Markus,

On 6/2/2025 5:32 AM, Markus Armbruster wrote:
> Annie Li <annie.li@oracle.com> writes:
>
>> Following hmp/qmp commands are implemented for pressing virtual
>> sleep button,
>>
>> hmp: system_sleep
>> qmp: { "execute": "system_sleep" }
>>
>> These commands put the guest into suspend or other power states
>> depending on the power settings inside the guest.
>>
>> These hmp/qmp command are in '*_*' format, it is intended to do
>> so to align to existing 'system_*' commands.
>>
>> Signed-off-by: Annie Li <annie.li@oracle.com>
> [...]
>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index a6b8795b09..3efaf82f7d 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -361,6 +361,26 @@
>>   ##
>>   { 'command': 'system_reset' }
>>   
>> +##
>> +# @system_sleep:
>> +#
>> +# Requests that the guest perform a ACPI sleep transition by pushing
>> +# the virtual sleep button.
>> +#
>> +# Since:10.0
> 10.1
Good catch.
>
>> +#
>> +# .. note:: A guest may or may not respond to this command.  This
>> +#        command returning does not indicate that a guest has
>> +#        accepted the request or that it has gone to sleep.
> Please indent like this for consistency:
Nod
>
>     # .. note:: A guest may or may not respond to this command.  This
>     #    command returning does not indicate that a guest has accepted the
>     #    request or that it has gone to sleep.
>
> The same note on system_powerdown additionally has "Many guests will respond to
> this command by prompting the user in some way."  I guess you did not
> copy this part, because it's not true here.  Correct?

Very likely(but ignored indentation).

Don't recall clearly since it has been a while since RFC V1 patch :)

Thanks

Annie

>
>> +#
>> +# .. qmp-example::
>> +#
>> +# -> { "execute": "system_sleep" }
>> +# <- { "return": {} }
>> +#
>> +##
>> +{ 'command': 'system_sleep' }
>> +
>>   ##
>>   # @system_powerdown:
>>   #
>> diff --git a/qapi/pragma.json b/qapi/pragma.json
>> index 023a2ef7bc..285ce82e9b 100644
>> --- a/qapi/pragma.json
>> +++ b/qapi/pragma.json
>> @@ -23,6 +23,7 @@
>>           'set_password',
>>           'system_powerdown',
>>           'system_reset',
>> +        'system_sleep',
>>           'system_wakeup' ],
>>       # Commands allowed to return a non-dictionary
>>       'command-returns-exceptions': [

