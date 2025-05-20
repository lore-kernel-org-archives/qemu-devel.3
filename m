Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97885C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHK3t-0002cV-Oi; Tue, 20 May 2025 06:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.milon@eviden.com>)
 id 1uHK3g-0002bk-QU
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:18:56 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.milon@eviden.com>)
 id 1uHK3b-0002vs-2z
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1747736327; x=1779272327;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=PiDgrq4GP6eYtrwk8fbvDjL3pKjY9JhNmddJc4j2Wxc=;
 b=iHvKysZ8fD2lwpM+OKL/nlFwAqjmdTmbikamc//oQr/2uNh0sDi4Gw2v
 sAI7qTNd2V4iGoxt3Q/FbKqSCMomAyxFh2Xen7JS+1t+1DVKohh29J1se
 RDGNPSguaesJWBh1sNsa1irmRnQ6dOcJbrn1KMRSogy88EGPgRFQYP2ld
 NSA1z74jw7t0py57ybj5Yr0fJF9l+7TORFYl/929CCXiQSX/rIWomDIiv
 CjlJXPatxpnl/z2VDNhcjl2G1J6DoCkdreWc//MuPyAoY82mJlPnOwAxi
 p1DEEQbvYul/ZPjjwEhBDLhy8gt4iTS2qZ3fDYwdcmq6/cyyl/fdx3y2j g==;
X-CSE-ConnectionGUID: qb2/aH35TJSoORTd/gU0/Q==
X-CSE-MsgGUID: RCnoUJECSa6J8LQaKXJOYQ==
X-IronPort-AV: E=Sophos;i="6.15,302,1739833200"; d="scan'208";a="37215759"
X-MGA-submission: =?us-ascii?q?MDEXUsHUUvcnFryQaYSjV93aQVakbDye6Lk9zN?=
 =?us-ascii?q?kx+YqpsQhu727TbVQs5MaRCAfAdqCNf6AyAFrYGvh8BYGJGLtzuq1X9W?=
 =?us-ascii?q?QRGI/FpRKr/UP1iB1W2wMHhSDLGsanipGS7Es7txH8oc1vKqJegCag1b?=
 =?us-ascii?q?pY7LN6DDYrZjVXeHnk9ftpwQ=3D=3D?=
Received: from mail-db5eur02on2077.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([40.107.249.77])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 May 2025 12:18:37 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzZ/qWcp4U/j1SHou/XzTDNlKlHdiRyBiQhGmMUvNFiNkBF20XFkwY5gccTN6rIPU03oHXxKgHs2KPCc/IeyezdR+uYuESKOfmNfEdz3xZhJbSdkG0yQzOQUhrtr/IK4yNuxodMEoGZxr6vwiYeSMs9WPIHxCPnb1s7oqzC3ikhSAiLsCM1qG+h6Mze22ZXxsjeiMJ90oSxFhWoYNHFSDmELS02dBr/tvDOJzE5znKXVur2jsgWXRZr3lE+DS6z4PYUARALJOSZ/avjaOIEPtjav0B29SGJX90QI8R/Lw8MEKPS4pSVJ/Y/04bVXdg/ir5un1tAeqjGsLwtxqUOnpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiDgrq4GP6eYtrwk8fbvDjL3pKjY9JhNmddJc4j2Wxc=;
 b=rAvl52xbtNju2Uj3G/sxeaLJ4gCVmhwkZcjov3W3FuWonljR3Izl8nt5R8TQVrqUAW5zd28TUAUrgQ42YcvCpazskIzgloL/mLSkiL1mul2bw4jobdmH4J9IVW6zs0lDwaQ68MVOB8ABIEdih29m/767ynSM19FQiJJVrDqok4shRQb6IxzX4oY2MmZ3Or8lxrrBWd5bgLMnqXSs4AClj09jyACYgbjwHiTP1dIubF9kyq2ffja9fof58mzDDUwKowv6rHbhShcMHgafAzRHO4hFKL31r2tIUERblYsOt5fhUvzbS82tMl+lJVBiIBikk7ROYHp+0hVWajDfTbEHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiDgrq4GP6eYtrwk8fbvDjL3pKjY9JhNmddJc4j2Wxc=;
 b=ME+ts/M15iXu9ZfejakR0tRURj5M3D2jGCvEm70YlyHiz+f62C5bHNNymwubQxVXWFLc/BaR2HB6UDnYrEpo+4e8E5bDScdxRISRVO2jnSgMTnXo27u3eFxx0/nVlwFNPppZXVE0AH+wJ8LGEZ2TdW2ZKBGOFkKBLl2AgGSPFf0tDwNeBeguPpdw2E+sz0dpsRpcQRBDxpXPaxsXKDM2qgPJMNVhtxr037R+GD7pB78FCkKytZYaIrTGtxFtK1jUe82paEeWzFDV3hI8Ry59GgOANzFTtdmfPneiQpgv8IkPpMTA3+/9srtVCjyvADH/jDeVn4eXKeOni1MR0t2zSQ==
Received: from DU0PR07MB9114.eurprd07.prod.outlook.com (2603:10a6:10:406::7)
 by DB9PR07MB8958.eurprd07.prod.outlook.com (2603:10a6:10:3c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 10:18:34 +0000
Received: from DU0PR07MB9114.eurprd07.prod.outlook.com
 ([fe80::cdae:718c:ad4a:7357]) by DU0PR07MB9114.eurprd07.prod.outlook.com
 ([fe80::cdae:718c:ad4a:7357%2]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 10:18:34 +0000
From: Ethan MILON <ethan.milon@eviden.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 05/20] amd_iommu: Add helper function to extract the DTE
Thread-Topic: [PATCH v2 05/20] amd_iommu: Add helper function to extract the
 DTE
Thread-Index: AQHbuwgx15evNiCIBkSORm+O8LSnhLPbaoYA
Date: Tue, 20 May 2025 10:18:33 +0000
Message-ID: <8e6cdfc0-2c6d-4785-ae49-d0b108e48923@eviden.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-6-alejandro.j.jimenez@oracle.com>
In-Reply-To: <20250502021605.1795985-6-alejandro.j.jimenez@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR07MB9114:EE_|DB9PR07MB8958:EE_
x-ms-office365-filtering-correlation-id: e07afd9f-4e1a-40bb-9b92-08dd9787ad4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K3hXclZTOG5RZVVucklGVnhPZkU0bjFkTENVN2Y5UmRBRTN5TkFYRTZzcGt4?=
 =?utf-8?B?SkVvaWVXRGVLZWN5U3RKSXpnMzJ3alg1QU9ObkxYVGZINEFZY3pBcEd2RkFE?=
 =?utf-8?B?YlBsWjg5UXdpUFJlNkRPd2gwMGowMC9mY2crNHVaTWxVdWp1OHFrVmoranpw?=
 =?utf-8?B?aGxpYW5WWldTVTl5NlpOeHBod0ZZd3BMbll6NW5YU0NDV2VqRE1BUlJRL0Ux?=
 =?utf-8?B?UTJ4bWZxZU13S2pnQm9GTWdTaWlXQ0dUeGNkVlRML2cwcXhHOFp5WCtiRVFU?=
 =?utf-8?B?bVVsZEhtMGovbmpFa2FhUWlvYng4VVFsL1JYVWNZQmZwSm9iT0dOcENsZ3dD?=
 =?utf-8?B?ZXdrVVpjMmxtUmhIOUpBdVZXSjRTL0M0WStSMGpUNkhXcDByZk9KSDFST25z?=
 =?utf-8?B?TkNKOGQ1MVBkWU5iSHg5VDlpcFFxZ3Bzb3FPNlNzSHZVTXBLOFYrM3BvYVRV?=
 =?utf-8?B?VEdBdmlQRG52cjA1Z00rM3JqamZVelRiM2VEY0VVL29YM0JGL0VJOTI0TmpD?=
 =?utf-8?B?cTljQjlYNUd2Y3c0akpyR2FwbFRZZ3djY1Y0TmROREIzTVZMZ25KWWZlSVhr?=
 =?utf-8?B?TWJHa1V4SnVva3BSdGpsaGRLaEVmYktZeFdJQ2JUaGdsYTBrVlZMeHdGZjNq?=
 =?utf-8?B?WW05WFkzMkMvODI0T3o1dWEvMW03N3JYaDkwdXkwMFBCMTBxM1lra2dOSDdy?=
 =?utf-8?B?U2tiZlYwYWFuMTlHSzh5VVdESDdqYnZ3ZEhjTHh6RUNRSVVjZFgxL3U2cHU3?=
 =?utf-8?B?WXE2Nm4rZnljd2hKV3kvNVczZ3lhNGQ3OUQxbzN4NGMrNTRKZThMaVdDQnJX?=
 =?utf-8?B?ajV2M3dVZ0I3VUZjZXZsN3llKzFvdUFYT1UvRXBHdkJXSS9HWXpmOWk4NVUw?=
 =?utf-8?B?cWlmOUdJMzRiaVNEQ0trOGpoeWY3enRrWUVnLzRlMkVuQTVjcXUxN0tTREdN?=
 =?utf-8?B?QUJ3RThYVll4alp6QS9kSFNWdDhBOTNBWnRUK1d6ZGVpREZtYW91Yi9yaTFH?=
 =?utf-8?B?UGpHeVVHNEp6VkZjbDlJenV3YjQwcTU0Nk1zSmw3ekRvUm5aeUxCbGR3M05j?=
 =?utf-8?B?bS96ZDBOVzExMTFaUnpKaXdHMGdoZGR0SnhmWUFya3FOVzdDTlAyeG1Mc2dU?=
 =?utf-8?B?U2ZINThiWFYxU2VYZ3FlWmxXUmNLS3g1ZzNheWk4M2R5cWpHeHo5WUtvYWta?=
 =?utf-8?B?RXJqSXFMdVdlQ2VGVU9lZ2hoTWpNdHExcGxyVGhpbnRSV0N1NHBJallBNnV0?=
 =?utf-8?B?R29INjNvWTlTZ0lnTTd4cWJCeWQ5VWdXRyt0Q0p5dzlVN0FVQnJGYURnWEJ3?=
 =?utf-8?B?Um50OFBRZjZwYWdQU08vejJFeHVIOFpNdEorZzFqS1htUENLMjZQd0tLUTlE?=
 =?utf-8?B?N0p6SDFFQkg1dTB0M3ErZmhKN2psQkxwN0Y2OUpwVmYyek9ha09oUG5jbmVi?=
 =?utf-8?B?bFF4RHlSdlJ1eDFUWDN6VlpvTHFLZXJhelBacDFEUVVJN05QTGFYbE9idlJ4?=
 =?utf-8?B?Y2RpQS9sc0JQeDhtZFFjTUF3REx0QTZDTGo1Ym5JcDFmRzQxWld6S1ZYdlBB?=
 =?utf-8?B?czdDU0I0cjFDaTErTUMrYWR0ODltRXdOeGlwc2hrc2dndVIrV0N4cWtKSFZ0?=
 =?utf-8?B?SmhXZndocFkvTXpoYUtIYUdsQjd0aU9OS3hEQ1VCSUcwSnZFZ1dmWkYvTi96?=
 =?utf-8?B?dDBrcElDcDViMkFiNUIrbnRGN0N0Wkk3Kzd2NlpWbHNQdHNHc3lCZEZYSm5L?=
 =?utf-8?B?K3Q3ejh2U3QzZmc4TThYK0NMSlY1ZDFXNjZSL0d4Ym5EZHR5eSt5UzI0aHNn?=
 =?utf-8?B?aEVyNFpNUzVNQUFRbDNCN2NBVWpsTzRYWURHWDFCY1Y3SEhoclNuWG9WMS9O?=
 =?utf-8?B?L2ZHZFlQUEl4S1AvUUNLVHpkaldmbEFvS1Z0NEt4VjlRcnhPaWpMQXdrSnFr?=
 =?utf-8?B?L2pUMTF3Qjc0Wkg3ZzRGeUtPZXBYeVh3YUNzVWJEaDdRcmY2S0Q2QnZtcWdS?=
 =?utf-8?B?S1NOOUR0WU5nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR07MB9114.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?am54WUdlMEFJWnNKN2h2dit2RWtPc2hOS2d4MVJHcjB6dkN1Sk9nNnNJbENK?=
 =?utf-8?B?bGdLWHdMWm41UFJ4L2VBMURScXhKM1JTcHkwdUx6WENzR2V3ekkvaC85aDda?=
 =?utf-8?B?UC8wa0IrdHpEbE92ZkRRb21UQW8vaEVydFA2YUQwQkM4YWE5cVYxYUsvNGN0?=
 =?utf-8?B?c2FGVHRsMDQwTGpNb3ZuYmlMdVdsRjJ0MDd0Zk5UT3I2SlI5WmdqazNUUmtP?=
 =?utf-8?B?cnpIMXJaR0I0dk9DcURIVWFOd1Vrem50ZXpwYTJtQjRzUldvRmJRZlRhZUp4?=
 =?utf-8?B?WGJoUWlhbm10UWcvK09mSVlncDB5dkNTT2RhYzVMeFIvejB1ajhLOWJpd3dm?=
 =?utf-8?B?U0tiSStEOGVUeUJacU4rYXBPY0FsU2ZqVDhCSktMeVFWRG4rVXF4V2p3UDVv?=
 =?utf-8?B?MzhGY0NpU0p0NmhUV2NDZ25HTHAyNG1Veld3dVh6RVRwYkpNOU1CcGxkSjk0?=
 =?utf-8?B?Q1k0bGpUejltU2YwUTZGSVhpWUFES1l0em5qVGFDdURYQWFvV2UwSWQ0dzFF?=
 =?utf-8?B?bDNJZzhXNkdvdXFlbDRuVnA0SVU3TnFTcVRROVlmc2M4WG43R2puU0NVc2tO?=
 =?utf-8?B?Yi9KdU1yMzJSRnU0N0J5enJqTzZCNTBsd2JUVkhJZGNZaDJEUDFkYTR1S2NG?=
 =?utf-8?B?amVNN24xUUI1cVFPditxbE5FYnk0b2xIRURBd2dqUUV6ZTRQMmVmWTNzRmhx?=
 =?utf-8?B?WFRQdUVxb1dRNTJzQ1RYamd6TjVxVlFnK29Kb3ZzWFNMQkh0cDkwUkh6d3ZC?=
 =?utf-8?B?c1NpLzZTZ1ovZGxtWGEzMFAyWXd1Z2s5cnpwODBVNTAvOGJQTXBSdFgrQS9X?=
 =?utf-8?B?ZThieXNVbXZOV2pJUG01V1hiT0VQUW1kQ2FMc3RXTEFLNU1yYnlRUGFIRldw?=
 =?utf-8?B?OVVuSUVhdzNaUHBzbCsvK1VxQ3RscEhtMkRrME1kSzdtbDJZcUNKbFRVZmlG?=
 =?utf-8?B?YjhybmI5TjIzd0NiTk4rZ1VSbVNwM1BxMmdDdDRmQmMvTi93Z09OcHN0QSsw?=
 =?utf-8?B?RklGdnd6SzhHSjR3OWtkVFMxeUhVRjNqbjEwWkd1V0xZUW83UVlKU05rNkg4?=
 =?utf-8?B?VTA2bjZJaWM2R1BPV1FkdWhBM1ZrR2ZlRmtwaE1KUElraDZpV2grTGI0bnVm?=
 =?utf-8?B?V0UvQ2c0c0NZc2pLTUxmVDNlM0FEWWhLRkxKVGszQk1TUVdBNzhMTlppbGxh?=
 =?utf-8?B?ZkhtdEpraFZka3BCZVFYd0Fma2ZpMW11UHN6OVo1a0J0Z3hQZHg5Rk5VSCsz?=
 =?utf-8?B?RjhNRTZESkw0ZzZPSmpGc01qbVFjRDc1Y0NJaGU3eHRwOVU4bFhBS3YzQmxS?=
 =?utf-8?B?V2Y4YkJ3NUJ3enpFZko0NFozSDdlemZuSytyR0tySUdicGZ1c3pCakliNGpl?=
 =?utf-8?B?dXRYb1NnR0xDdEk0REVSWjJtRzBVZEFDcVdJVWhPQTBLRkU1TE9PRlV2Y0t4?=
 =?utf-8?B?czhVYTMxM1NaeUtxUDdtMW5LWjRSdzRlYlp1N1lwWUlNQjJySUZ5Z0x3NTZk?=
 =?utf-8?B?TnVORk82NUQ0S1BYemJFWFpydFlOZTA4L1NFOHduTC9saWhmVWRMRUsxUmNL?=
 =?utf-8?B?b3NmOVF4UTZJaXkwSWdxV3J2ZUZCbXdVbDl4d1ZzQ1hJbFVHMzRvblMwalZj?=
 =?utf-8?B?dkFGWlR2L2pqZWM3WHFmSXMxZGNuSzNGRStyZ2t3bXRVOVkzU2tZd1pwNzZU?=
 =?utf-8?B?bzlPTjgxeWIrTWlJMit0RUJqNG5TSS9ONTIydlhOOUxWMEFsc0tKUlV1ZmZw?=
 =?utf-8?B?NHcxb205MFhscU9qazByc0xMdWZqYmc5Y0hGSEltSW5BdFZMTCtBWDlRWFUv?=
 =?utf-8?B?Q3pKWjJRQUE2NzBtZkcwS0VmUWJaUUJtcDFHQ2JnZ215bUt4aXJoZlQ5K2h6?=
 =?utf-8?B?Qm9WLzl1UmhUcFphc2xMUFJMMDdrSS9GWjhGL0ZKaVpWNnBoZVR5dmZZaTBJ?=
 =?utf-8?B?Q1VxMTZpTzZRNmFGUzNocHJBZHlrbmVRSjlSNEtlaUc3U3AxeDNyeDl1amN6?=
 =?utf-8?B?T3J1RlpVT2ZiT1RFY25vWVRUa1haV1dhdFFQQ3djN0pXeG5neit1amhBSGhG?=
 =?utf-8?B?ZWVMWXl5aXVITThxZTlyL1BnZUVOcytFYUlxcWg4QnI0bW83eE5QZGR0ZGRn?=
 =?utf-8?B?blNOdVk0bGdRZklZc3dmT1Y0dDFDcGZBWmZ1cEU1QlllZERjSTNkc3B4ZjlO?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7907DE94CBB0E6499FAB89946CDDB8CA@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB9114.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07afd9f-4e1a-40bb-9b92-08dd9787ad4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 10:18:34.0128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yfm+buy5WmLGRRbj9jk1HkJcqgT48AMY66QmdiOcd3dEAKk0nsZGwKeynI/sr5A7FStxdtPWyEe6HPAdyXx/hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8958
Received-SPF: pass client-ip=80.78.11.83; envelope-from=ethan.milon@eviden.com;
 helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGksDQoNCk9uIDUvMi8yNSA0OjE1IEFNLCBBbGVqYW5kcm8gSmltZW5leiB3cm90ZToNCj4gQ2F1
dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxp
bmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IEV4dHJhY3RpbmcgdGhlIERURSBm
cm9tIGEgZ2l2ZW4gQU1EVklBZGRyZXNzU3BhY2UgcG9pbnRlciBzdHJ1Y3R1cmUgaXMgYQ0KPiBj
b21tb24gb3BlcmF0aW9uIHJlcXVpcmVkIGZvciBzeW5jaW5nIHRoZSBzaGFkb3cgcGFnZSB0YWJs
ZXMuIEltcGxlbWVudCBhDQo+IGhlbHBlciB0byBkbyBpdCBhbmQgY2hlY2sgZm9yIGNvbW1vbiBl
cnJvciBjb25kaXRpb25zLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxlamFuZHJvIEppbWVuZXog
PGFsZWphbmRyby5qLmppbWVuZXpAb3JhY2xlLmNvbT4NCj4gLS0tDQo+ICBody9pMzg2L2FtZF9p
b21tdS5jIHwgNDUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2FtZF9pb21tdS5jIGIvaHcvaTM4Ni9hbWRfaW9tbXUu
Yw0KPiBpbmRleCBkZmY2ZjA0Yzg2NTEuLjUzMjJhNjE0ZjVkNiAxMDA2NDQNCj4gLS0tIGEvaHcv
aTM4Ni9hbWRfaW9tbXUuYw0KPiArKysgYi9ody9pMzg2L2FtZF9pb21tdS5jDQo+IEBAIC03Nyw2
ICs3NywxOCBAQCB0eXBlZGVmIHN0cnVjdCBBTURWSUlPVExCRW50cnkgew0KPiAgICAgIHVpbnQ2
NF90IHBhZ2VfbWFzazsgICAgICAgICAvKiBwaHlzaWNhbCBwYWdlIHNpemUgICovDQo+ICB9IEFN
RFZJSU9UTEJFbnRyeTsNCj4gDQo+ICsvKg0KPiArICogVGhlc2UgJ2ZhdWx0JyByZWFzb25zIGhh
dmUgYW4gb3ZlcmxvYWRlZCBtZWFuaW5nIHNpbmNlIHRoZXkgYXJlIG5vdCBvbmx5DQo+ICsgKiBp
bnRlbmRlZCBmb3IgZGVzY3JpYmluZyByZWFzb25zIHRoYXQgZ2VuZXJhdGUgYW4gSU9fUEFHRV9G
QVVMVCBhcyBwZXIgdGhlIEFNRA0KPiArICogSU9NTVUgc3BlY2lmaWNhdGlvbiwgYnV0IGFyZSBh
bHNvIHVzZWQgdG8gc2lnbmFsIGludGVybmFsIGVycm9ycyBpbiB0aGUNCj4gKyAqIGVtdWxhdGlv
biBjb2RlLg0KPiArICovDQo+ICt0eXBlZGVmIGVudW0gQU1EVklGYXVsdFJlYXNvbiB7DQo+ICsg
ICAgQU1EVklfRlJfRFRFX1JUUl9FUlIgPSAxLCAgIC8qIEZhaWx1cmUgdG8gcmV0cmlldmUgRFRF
ICovDQo+ICsgICAgQU1EVklfRlJfRFRFX1YsICAgICAgICAgICAgIC8qIERURVtWXSA9IDAgKi8N
Cj4gKyAgICBBTURWSV9GUl9EVEVfVFYsICAgICAgICAgICAgLyogRFRFW1RWXSA9IDAgKi8NCj4g
K30gQU1EVklGYXVsdFJlYXNvbjsNCj4gKw0KPiAgdWludDY0X3QgYW1kdmlfZXh0ZW5kZWRfZmVh
dHVyZV9yZWdpc3RlcihBTURWSVN0YXRlICpzKQ0KPiAgew0KPiAgICAgIHVpbnQ2NF90IGZlYXR1
cmUgPSBBTURWSV9ERUZBVUxUX0VYVF9GRUFUVVJFUzsNCj4gQEAgLTQ5Miw2ICs1MDQsMjggQEAg
c3RhdGljIGlubGluZSB1aW50NjRfdCBhbWR2aV9nZXRfcHRlX2VudHJ5KEFNRFZJU3RhdGUgKnMs
IHVpbnQ2NF90IHB0ZV9hZGRyLA0KPiAgICAgIHJldHVybiBwdGU7DQo+ICB9DQo+IA0KPiArc3Rh
dGljIGludCBhbWR2aV9hc190b19kdGUoQU1EVklBZGRyZXNzU3BhY2UgKmFzLCB1aW50NjRfdCAq
ZHRlKQ0KPiArew0KPiArICAgIHVpbnQxNl90IGRldmlkID0gUENJX0JVSUxEX0JERihhcy0+YnVz
X251bSwgYXMtPmRldmZuKTsNCj4gKyAgICBBTURWSVN0YXRlICpzID0gYXMtPmlvbW11X3N0YXRl
Ow0KPiArDQo+ICsgICAgaWYgKCFhbWR2aV9nZXRfZHRlKHMsIGRldmlkLCBkdGUpKSB7DQo+ICsg
ICAgICAgIC8qIFVuYWJsZSB0byByZXRyaWV2ZSBEVEUgZm9yIGRldmlkICovDQo+ICsgICAgICAg
IHJldHVybiAtQU1EVklfRlJfRFRFX1JUUl9FUlI7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgaWYg
KCEoZHRlWzBdICYgQU1EVklfREVWX1ZBTElEKSkgew0KPiArICAgICAgICAvKiBEVEVbVl0gbm90
IHNldCwgYWRkcmVzcyBpcyBwYXNzZWQgdW50cmFuc2xhdGVkIGZvciBkZXZpZCAqLw0KPiArICAg
ICAgICByZXR1cm4gLUFNRFZJX0ZSX0RURV9WOw0KPiArICAgIH0NCj4gKw0KPiArICAgIGlmICgh
KGR0ZVswXSAmIEFNRFZJX0RFVl9UUkFOU0xBVElPTl9WQUxJRCkpIHsNCj4gKyAgICAgICAgLyog
RFRFW1RWXSBub3Qgc2V0LCBob3N0IHBhZ2UgdGFibGUgbm90IHZhbGlkIGZvciBkZXZpZCAqLw0K
PiArICAgICAgICByZXR1cm4gLUFNRFZJX0ZSX0RURV9UVjsNCj4gKyAgICB9DQo+ICsgICAgcmV0
dXJuIDA7DQo+ICt9DQo+ICsNCg0KSSdtIG5vdCBzdXJlIHRoZSBuZXcgYW1kdmlfYXNfdG9fZHRl
KCkgaGVscGVyIGFkZHMgbXVjaC4gSXQganVzdCB3cmFwcyBhDQpmZXcgY2hlY2tzIGFuZCBtYWtl
cyBpdCBoYXJkZXIgdG8gcmVwb3J0IGZhdWx0cyBwcm9wZXJseSBpbiB0aGUgZnV0dXJlLg0KSXMg
dGhlcmUgYSByZWFzb24gdGhpcyBjb3VsZG4ndCBiZSBoYW5kbGVkIGlubGluZT8NCg0KPiAgLyog
bG9nIGVycm9yIHdpdGhvdXQgYWJvcnRpbmcgc2luY2UgbGludXggc2VlbXMgdG8gYmUgdXNpbmcg
cmVzZXJ2ZWQgYml0cyAqLw0KPiAgc3RhdGljIHZvaWQgYW1kdmlfaW52YWxfZGV2dGFiX2VudHJ5
KEFNRFZJU3RhdGUgKnMsIHVpbnQ2NF90ICpjbWQpDQo+ICB7DQo+IEBAIC0xMDI0LDYgKzEwNTgs
NyBAQCBzdGF0aWMgdm9pZCBhbWR2aV9kb190cmFuc2xhdGUoQU1EVklBZGRyZXNzU3BhY2UgKmFz
LCBod2FkZHIgYWRkciwNCj4gICAgICB1aW50MTZfdCBkZXZpZCA9IFBDSV9CVUlMRF9CREYoYXMt
PmJ1c19udW0sIGFzLT5kZXZmbik7DQo+ICAgICAgQU1EVklJT1RMQkVudHJ5ICppb3RsYl9lbnRy
eSA9IGFtZHZpX2lvdGxiX2xvb2t1cChzLCBhZGRyLCBkZXZpZCk7DQo+ICAgICAgdWludDY0X3Qg
ZW50cnlbNF07DQo+ICsgICAgaW50IGR0ZV9yZXQ7DQo+IA0KPiAgICAgIGlmIChpb3RsYl9lbnRy
eSkgew0KPiAgICAgICAgICB0cmFjZV9hbWR2aV9pb3RsYl9oaXQoUENJX0JVU19OVU0oZGV2aWQp
LCBQQ0lfU0xPVChkZXZpZCksDQo+IEBAIC0xMDM1LDEzICsxMDcwLDEzIEBAIHN0YXRpYyB2b2lk
IGFtZHZpX2RvX3RyYW5zbGF0ZShBTURWSUFkZHJlc3NTcGFjZSAqYXMsIGh3YWRkciBhZGRyLA0K
PiAgICAgICAgICByZXR1cm47DQo+ICAgICAgfQ0KPiANCj4gLSAgICBpZiAoIWFtZHZpX2dldF9k
dGUocywgZGV2aWQsIGVudHJ5KSkgew0KPiAtICAgICAgICByZXR1cm47DQo+IC0gICAgfQ0KPiAr
ICAgIGR0ZV9yZXQgPSBhbWR2aV9hc190b19kdGUoYXMsIGVudHJ5KTsNCj4gDQo+IC0gICAgLyog
ZGV2aWNlcyB3aXRoIFYgPSAwIGFyZSBub3QgdHJhbnNsYXRlZCAqLw0KPiAtICAgIGlmICghKGVu
dHJ5WzBdICYgQU1EVklfREVWX1ZBTElEKSkgew0KPiArICAgIGlmIChkdGVfcmV0ID09IC1BTURW
SV9GUl9EVEVfVikgew0KPiArICAgICAgICAvKiBEVEVbVl09MCwgYWRkcmVzcyBpcyBwYXNzZWQg
dW50cmFuc2xhdGVkICovDQo+ICAgICAgICAgIGdvdG8gb3V0Ow0KPiArICAgIH0gZWxzZSBpZiAo
ZHRlX3JldCA9PSAtQU1EVklfRlJfRFRFX1RWKSB7DQo+ICsgICAgICAgIHJldHVybjsNCj4gICAg
ICB9DQo+IA0KPiAgICAgIGFtZHZpX3BhZ2Vfd2FsayhhcywgZW50cnksIHJldCwNCj4gLS0NCj4g
Mi40My41DQo+IA0K

