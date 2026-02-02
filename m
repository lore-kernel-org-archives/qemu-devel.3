Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EB9E7DEEE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmufC-0003ke-P1; Mon, 02 Feb 2026 09:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vmuf5-0003gW-5z; Mon, 02 Feb 2026 09:12:19 -0500
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vmuf3-0001x6-8T; Mon, 02 Feb 2026 09:12:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pk6XEZvQUlPt3K2t6VZIY/BkszYju55zXk77dFQglxmUaes5a25ApmIpYwXUx5qDnTigxgS9sVkZsrD8GKsFuxkDbgZL19xDYZwq4AUNOF8/zgLIdTcbDVN42lL4rLrD0Su4yznJe7j2sEl8tPSTJJmSLvBtF199f9SyIaJLFytf3qWNrm+OIkbDLkavNoYCMRs1ACjrxgF2uihidVHjal2/XK7+tpLxQYJvU4d2qNxcd9nY3D0pea/lXBI4SyJQ3rjZrLWEd8QtuiQIIt6ApsJ1GmS8w5D3lraVYx1VL8ez9Q3zth0slm72rLP6yjohaEYdjyEdZItArKQPaa1xZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RIX0+efqh4QmVZ86vYUi6ZfmpYHPJ1d7g18LNvriPs=;
 b=XogRcYvjcYPZfDRyVYe6O0/V0xvL00+6I2/mwSO4u4lCpH6ESlNOSC4m5NIyd1UPYBo3AUl273m8vbAsmWHoYxerno7rgXv6iV0pFCb/V6GyWBNvVTPQaXuuiHgQdmAjIUjJtPr9WW99IEqlGGstPvxCizN+jWKJSplh79kUAjUQKuS1t4tyU/4TuM+AK1HgTFZtJoTRDpWh0AmInHkvf2Mn/ik5I76cSdI/Vjpf13gHLZ1KfrSMsBljnXoIAvkWEqZeRuXYXRWe/mWTwrS9Tzbs5WOpbdvADpGuFVdgGIAjOpKej5f0AI0olbhSs4CynOwN0z10xMiL6jlFHYTK0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RIX0+efqh4QmVZ86vYUi6ZfmpYHPJ1d7g18LNvriPs=;
 b=rrJADG7C/y6imXckBjMN6CCvBXnJb3rmATHYI5KroFfu0UN/+za1Z1mQi5pOHRdZ9l7mQa1k6fQQXMePIdug6isK5vme4nD6IDA9Q5LClBVPvhyR9YrkkiB/aWVV/2YffD3UxEc07ZAy+5U/FQQw36KabBMXSsWy+lDlG6FJHmESLE+mBACtHAJcuMCGr7ADTy4ud+TuUmSbWtnlAXZoyckGpkOTuCZo7u6ypL+5gc8e1p58lvfU8bx4hPayiDQuNhmu7OF6qWyMpjKnghGtYex+2fg5DItb+6M8GpC4IL7MP8Dms0f7uqNZyz5IUwuNwhCvYO8peb0tommTPupY7A==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MN2PR12MB4256.namprd12.prod.outlook.com (2603:10b6:208:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 14:12:12 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 14:12:11 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH v3 4/4] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Topic: [PATCH v3 4/4] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Index: AQHclEO0/ncc2YkbvEyLAvViXHG0YLVvbYZA
Date: Mon, 2 Feb 2026 14:12:11 +0000
Message-ID: <CH3PR12MB7548DB2591BCB7ABB47136D3AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260127103328.255382-1-skolothumtho@nvidia.com>
 <20260127103328.255382-5-skolothumtho@nvidia.com>
 <0bbdecdc-f997-4a3e-8023-f50ed629128f@redhat.com>
In-Reply-To: <0bbdecdc-f997-4a3e-8023-f50ed629128f@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MN2PR12MB4256:EE_
x-ms-office365-filtering-correlation-id: 88d024c0-b507-478f-4b0b-08de62650efa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MVFlSEJaUVFFQXhYL2hjQmRQZ0JzbUFVK3FjdklCQjhkTFkyb2dWa28wd25h?=
 =?utf-8?B?b01iWkpwZmxFeE1uSllqWHNRdTF4OHFGZUJoZzNSTGhUa2pCQXJXRjV2UzFG?=
 =?utf-8?B?dTVRQkRxbC83TjNGdTJpN1R4eDJDM0RGVG5sZHVzb2ZvbnR1SysrdlVsMGVN?=
 =?utf-8?B?dG9BN2lQZzEyZE4xcWFXT3BQZnRTY1c2MGhVQXYyc3R4K0Y2RFFNZ2ViTUor?=
 =?utf-8?B?bU1BWmtxSHo5U0RnSy9QbEpCQkNDR3B0cUQycUh2ekhQTmsva1ZzQjJDM0dh?=
 =?utf-8?B?WjdoSWl1Z2tnY2tlWHgvRXVTVDQxTFpWUURJV29VVUYrSFJQWnd5Vy9iRm94?=
 =?utf-8?B?UnlkNFVuWStaL1BpTHp6ZXRXN3JYOWhHMjg1eDJsMlg5eVorc1ZlYXJObmIw?=
 =?utf-8?B?dFVRYytncFJmQnBiRVpKRXIyQnRyUStzVmRCVVpXckZVQVFPeHA2NTg1YXhy?=
 =?utf-8?B?K3NjVjI4S1UrZThSL3dha2krYUFjK0JUcW11dzlLMzA3cC9vZm1Jc0RxQVVT?=
 =?utf-8?B?SGdXMDVza25sSDF0VTlVeUhCSXRJMzh6YUVscmJxTUlQeGxKSDNHYjF2MjZo?=
 =?utf-8?B?eGhRUVQ5Rll2UGpWb2hGWmRZTGM0UkpZNVV1OHdlOTJBVHRYU2NBRGhSb0xs?=
 =?utf-8?B?dXhyQ2toQm1TNlBxcUFYUm91cGo0QTdvaVFGOHRqcEd4c3paT0FJR0tZV3ZR?=
 =?utf-8?B?UFNBeEFGdFI3azlxV1Z6N3oxLzQ2TTFSVmxDaTAzU3lFMVZ6SGZoNjlwcjJ2?=
 =?utf-8?B?dFl1MmxERHpKY2ZTNE9EV2pGcFNIM1RKaDFseUpiR3VpalJFcGVjWkFYbnBt?=
 =?utf-8?B?bkFjZU1EeUxHblcxYTl4K2JxaVA3UmQ5b1FqL05LWlJNbWcwM1lKQi9tdjIy?=
 =?utf-8?B?RlF1WUJvQmRmbDFkRUwydW11M3hlY0RNMVJQL0t5M2dGeEx2L1pOS25xZzIw?=
 =?utf-8?B?WHliV2sySnpVTGVIVHZJY1Y2dEljU2dyamVrMytJN2Yrb001S2V0QnlBVkNI?=
 =?utf-8?B?V1NkQjBqMnByRGtDdThUczUwL3ZId3BCdVRVMnVCS1kwby9UalhKVnNpdzJV?=
 =?utf-8?B?Rmh2RE1LVmp6aTFzdWg1c0dnRkdyQjdGMW1IU1FtMWZPb08veXpJMWd1MXk4?=
 =?utf-8?B?a1k5S08zRjJ5Z2U1Zk9NOE11UWZveTBvLzFyOHN0R3AzbmN5VHplcERCOTE1?=
 =?utf-8?B?VjB5eVRxSkhGZmRhdWw0ZzZBaEtsSFBBdWZIWFZWNnVTcStuQWtSUWlzaUw2?=
 =?utf-8?B?UlRtZlFKTjBJaCtpZWN3SHA4dzNrZ2pDWWNwWWFWK2hXa0t4eGFEd0Z0ckZT?=
 =?utf-8?B?SFg5VUhtT3RyYXNpUGNyWjNMeWlXdjRVRUZPM1FGUlVsRDU4SHBzcGlrY0Fn?=
 =?utf-8?B?cEFtUjdEd1hMRUI5TzRBUHRrSXg0N1pnTnprL296aDRYanZVWTZURG5iQWxC?=
 =?utf-8?B?RDB4TDEzWUhmWWhjMEUxTEFmSThVNmptUHlMYlBNMFJCWlQweGxwd2dKMTJD?=
 =?utf-8?B?NjJOSnpzZWhhT1Zpd1pXSW9hdG8vRmc1SGZxYTJBZ25NR2NVUFFwRVBYdE4r?=
 =?utf-8?B?ZmhrN0lyWVNZRFB4c2JoVUd0cmRUb3EybHZWM0FOd0xRaXloTVVwR2grSjM2?=
 =?utf-8?B?TG96Qk1hQ21CTmdPdEw5a1BxZEFGb05IWkdDUXhyZHJXZ1RvVmxEa21JOGFW?=
 =?utf-8?B?WGR1VStHcGM5SmttcTRPcGNUaVY3UmswYXJkMUxqRHM4dEdHOGVubmhYR0pR?=
 =?utf-8?B?b3FySk5aM0FVVTVoRUNMczYxNlJSeU5vMG4wSkpsQ3A3ZFNvd1NwbWMzNEs0?=
 =?utf-8?B?UHVIZ1o1cTFyRlVNSlBzbnhrUVhVVXBoVERQeklsK1pVY1Q3MTlpM25BdWdW?=
 =?utf-8?B?ajVTTEdCUjFLY3NrYnhnT3RHeFBnbU1FMkdlVUNaSllLRjArdjhHSUlGbDE1?=
 =?utf-8?B?T3FOUE90bUtmbmttVEJBMTVRN2JQRWVRRmg0L24zZkdFTG1jQTVWT0JLQTk3?=
 =?utf-8?B?RXBORzhmVU1tN2I3UDRLVkMramZNM1RCdUFTS0NhTDNRWk1WTENCNjhNQ3FE?=
 =?utf-8?B?aHU4YS9XWlZ6amZuNW84UEM2dldoMWptUU5lL3F1b0ZnbmU3NlZGbWxWU0hM?=
 =?utf-8?B?a0tKcGJHR2UvczNmSGQyb2VaMWxNa1BiR0p6YVJhU2NGUFVYQ3phT2dhWjE4?=
 =?utf-8?Q?Lwwvh4FGOEtiQuUUb41VWVU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFNJeEhRKzNXR3paSkZNak95R3hUeC9HR3BjYXl0MjlLWHczRUpnbWlXUjdL?=
 =?utf-8?B?VVNPUjBFeWJvY0NsRFlBcm00QmR5YWlYSEs5Ynl2M3MvRnNIMnpDRzFLN0FO?=
 =?utf-8?B?bEluaWZ3MDh1NmszWUJoOU5IYVRsUkwxOWJqenJTTmlmWWF1K3BZdXFiVDNV?=
 =?utf-8?B?NFBrTCsyRDduS0VNSnVNRXA1L2RYaE5aS0h3cGFKZVdGTXlJcmo4OGd5Z3A1?=
 =?utf-8?B?T3A5QnlOaTY0OG1FdXd3WEU4eUJnZU5EQUxVaGdnSVI1c1lZRm8xaGxTc1lo?=
 =?utf-8?B?aUhmMkp2K0JSZ0ZKL2g4YUJsbm1VYVpHc0hWVDJ1QjhEZ3lsMEdRZzRtNmlm?=
 =?utf-8?B?UmJjZUVLeHBncC85d2lJQ3JjZkl0ZWEyaU14TzFIejIrM2ZicjRTcUZUU3d2?=
 =?utf-8?B?NkVSYnY5VFV0YVJjcVE0cC9admp6N3E0MFNsa0plSVV0cyt5anNIbzVSd1J1?=
 =?utf-8?B?TUR1SWRXS0VJZFFRVVo4d25xa0VFSDIzUWwyU25vTDV5V00rZlNFNUpyNVdk?=
 =?utf-8?B?cjJNckJIOG9VaUxablVLQSt6UHpGMXJWdTh5VVZoZlVsMnJtVncvT1k2NzBE?=
 =?utf-8?B?Q3g5TEQzYVU0UGVjTml3UHRiWEE4NlAvVFV4R0FoM3VlZjQ3aTdLMTRldW1l?=
 =?utf-8?B?U1hqck5LM3RFZ3RnbWRZaTBPUFY5aFlIM1VnYVgyckRwUklSNFNEZUdUb2Ny?=
 =?utf-8?B?ZEZLM29QcWllS1JJWWVNWTBrbFVWTWV5RmxZQjJ4bGJHTGdKcG40SDlPNnpl?=
 =?utf-8?B?Mm5KR0trdkxKeElibFprU0JPSkV5RWljMGQ5UkR6Y2QzK3JiRzJVQU1aOWhO?=
 =?utf-8?B?TmxORml3ZTBqTi9nTlQrVDIyYWtHNHMxSmlsMFhNL3EzdTNsb1NOT05Ra25C?=
 =?utf-8?B?Rkk4MUYvaHJsT0FQbXQ5bm9xTlQwbmxidkdxY0JPeDFCamRCRnp3cEdrdzhy?=
 =?utf-8?B?ZHhaaUZQNDd1MTNBZXQ3QWJZK3gvY1pRb3JLa3RGQmlRNndYWW8wSzg5OURq?=
 =?utf-8?B?aGEwMXd0UkhYYVN0Ylh0c00zM1NzTVZuWHBDTXA3eUh5amxtRUQxYVFXZ1B5?=
 =?utf-8?B?dFAvdkNwUU1wOUN1Y003bXI3aFpXeFljczJJQ1FzcnFjQXRiWEFOcEdnMjhz?=
 =?utf-8?B?QzBaeXZWQ2ZXYnY5dDVOZitESmJ1WSt4TExxbDJEbDRjbDBNN0JLZGY2dFdz?=
 =?utf-8?B?T1BMWUFKVHdKRTZSN2RqSVYzVFVuOXNvTVk4SW5kalFBbGdPWS9obU1uM3lO?=
 =?utf-8?B?TDlUQ2ovcG9WQk9oOU9uWXpYd1l2SHBzbFZBVXRiak9VMEJHeTF5WXZmOU1H?=
 =?utf-8?B?b0xJUTVEbnJGTWxBSkNXN0xUR2ZPZjM5bWw0VDRpRzNMZk1ucUJVd0g3bnhI?=
 =?utf-8?B?WlZwR3ozRTh2Vk82U2dVOUhkU3JhMDVsL1Y2cUhRUnJaTGRPaU1Hb05mdlpP?=
 =?utf-8?B?cGZuMXJvTzVya2J5eWxKQjc3SHN1ZjRtWCtuc0VHdmEveWVHQXpvcnl0SGJi?=
 =?utf-8?B?WjBIb0lNM3dndHpHdEtOa1Q5OEVoTTQ5dis3dWxablBlbnBSb3VQMVhkUHJC?=
 =?utf-8?B?cjROcmtjaVhxWjl4ZjdQYml5YXJPWWZYMjFDb2ZSZUpLN0ZTRkxnNkZoY2Nx?=
 =?utf-8?B?d1ByTTNORit3ZlpYWWZacmdpSDBKZC81VE9adUkxSFMrV1BIK25Fa2lZREJ2?=
 =?utf-8?B?a1ZOZWR5cnpvalFTWnBPbFVMZzFVbXY5R1ZzN293Q2swZnhtSEtjZnFNL2ts?=
 =?utf-8?B?aFlsY1hhKytJaWFKU2VtNE1LU2FUcUhsU1RjVFpyeWNHWmtRb1pEbmdha2lI?=
 =?utf-8?B?bVpiMjg3T3c3TGZ5SHA4ZnhBeTRlM2k1SEtyem0wL3VKeFZnNEFWR29OOWZP?=
 =?utf-8?B?dmpHQXVOZHB2akpraUJrZmt1RU1MV2ZwczlQMUtmcFA5bnhrcXFaeG5JRkV5?=
 =?utf-8?B?MUczNm5FZFFuQlF4cGFFc3lCc053d09jOVVJa3QzdExpSWU3MTFxVm45L0lX?=
 =?utf-8?B?TWNYejhkV0RpUHNGOXg5N3pnR3lRZnorQWwvaDV5MlNMRHZmK1VmUUh2UjU3?=
 =?utf-8?B?cVlzeUJZYXR2VGxBM3FhV2FCYWdNOERseHlwNFRDMmQzbHMwMXFtREdtZWNq?=
 =?utf-8?B?dzZUMWFlbnZkc2ZBR09SeXpPYjFlWHMxZjlobkx0a2ZUSFdLeFlHL0dqRi8v?=
 =?utf-8?B?amJPUG5Ob3BSemNUYlVDd3hXSDZ6NnNlaUhUZnlXVlA5b1ZRRGhTS1RUamdC?=
 =?utf-8?B?K0NRRTlINEtRQ09xSjNZRGtMa1JMdWlLZ2dwKzI2bGJrQXhwcnp4RDV6YWx2?=
 =?utf-8?B?TmNtSExNMHFySHpwL2VaQ2FvWXNHbkdsUnBnK1U0aXVsU0RNamlWdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d024c0-b507-478f-4b0b-08de62650efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 14:12:11.5393 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xp7jazmnbABUCgluxxQ8zx35/b2F91EpAwakGEe64IGMHQ5i6ghMXBXaGSKAuProGYiUPShcxg28mO0RXmj+PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4256
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwMiBGZWJydWFyeSAyMDI2IDEyOjU5DQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUt
DQo+IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZzsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgTmF0
aGFuDQo+IENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2NocyA8bW9jaHNAbnZpZGlh
LmNvbT47IEphc29uDQo+IEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBqb25hdGhhbi5jYW1l
cm9uQGh1YXdlaS5jb207DQo+IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOyB6aGVuemhvbmcuZHVh
bkBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRpYS5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNC80XSBody9hcm0vc21tdXYzLWFjY2VsOiBSZWFkIGFuZCBw
cm9wYWdhdGUgaG9zdA0KPiB2SU9NTVUgZXZlbnRzDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNl
IGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IEhpIFNoYW1l
ZXIsDQo+IA0KPiBPbiAxLzI3LzI2IDExOjMzIEFNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0K
PiA+IEluc3RhbGwgYW4gZXZlbnQgaGFuZGxlciBvbiB0aGUgdkVWRU5UUSBmZCB0byByZWFkIGFu
ZCBwcm9wYWdhdGUgaG9zdA0KPiA+IGdlbmVyYXRlZCB2SU9NTVUgZXZlbnRzIHRvIHRoZSBndWVz
dC4NCj4gPg0KPiA+IFRoZSBoYW5kbGVyIHJ1bnMgaW4gUUVNVeKAmXMgbWFpbiBsb29wLCB1c2lu
ZyBhIG5vbi1ibG9ja2luZyBmZCByZWdpc3RlcmVkDQo+ID4gdmlhIHFlbXVfc2V0X2ZkX2hhbmRs
ZXIoKS4NCj4gPg0KPiA+IFRlc3RlZC1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0Bu
dmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBody9hcm0vc21tdXYzLWFjY2VsLmMgfCA2MA0KPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGh3L2FybS9z
bW11djMtYWNjZWwuaCB8ICAyICsrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNjIgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9zbW11djMtYWNjZWwuYyBiL2h3L2Fy
bS9zbW11djMtYWNjZWwuYw0KPiA+IGluZGV4IGU4MDI4ZDRiZTUuLmFiNTdlYWU1NzUgMTAwNjQ0
DQo+ID4gLS0tIGEvaHcvYXJtL3NtbXV2My1hY2NlbC5jDQo+ID4gKysrIGIvaHcvYXJtL3NtbXV2
My1hY2NlbC5jDQo+ID4gQEAgLTM5MCw2ICszOTAsNjAgQEAgYm9vbA0KPiBzbW11djNfYWNjZWxf
aXNzdWVfaW52X2NtZChTTU1VdjNTdGF0ZSAqYnMsIHZvaWQgKmNtZCwgU01NVURldmljZQ0KPiAq
c2RldiwNCj4gPiAgICAgICAgICAgICAgICAgICAgIHNpemVvZihDbWQpLCAmZW50cnlfbnVtLCBj
bWQsIGVycnApOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgc21tdXYzX2FjY2VsX2V2
ZW50X3JlYWQodm9pZCAqb3BhcXVlKQ0KPiA+ICt7DQo+ID4gKyAgICBTTU1VdjNTdGF0ZSAqcyA9
IG9wYXF1ZTsNCj4gPiArICAgIFNNTVV2M0FjY2VsU3RhdGUgKmFjY2VsID0gcy0+c19hY2NlbDsN
Cj4gPiArICAgIHN0cnVjdCB7DQo+ID4gKyAgICAgICAgc3RydWN0IGlvbW11ZmRfdmV2ZW50X2hl
YWRlciBoZHI7DQo+ID4gKyAgICAgICAgc3RydWN0IGlvbW11X3ZldmVudF9hcm1fc21tdXYzIHZl
dmVudDsNCj4gPiArICAgIH0gYnVmOw0KPiA+ICsgICAgc3NpemVfdCByZWFkc3ogPSBzaXplb2Yo
YnVmKTsNCj4gPiArICAgIHVpbnQzMl90IGxhc3Rfc2VxID0gYWNjZWwtPmxhc3RfZXZlbnRfc2Vx
Ow0KPiA+ICsgICAgc3NpemVfdCBieXRlczsNCj4gPiArDQo+ID4gKyAgICBieXRlcyA9IHJlYWQo
YWNjZWwtPnZldmVudHEtPnZldmVudHFfZmQsICZidWYsIHJlYWRzeik7DQo+IGluIGNhc2Ugd2Ug
cmVjZWl2ZSBhIGhlYWRlciB3aXRoIExPU1RfRVZFTlRTIGF0IHRoZSBlbmQgb2YgdGFpbCwgbm8g
ZGF0YQ0KPiBpcyBleHBlY3RlZC4gU28gSSBhbSBub3Qgc3VyZSB5b3Ugd2lsbCBiZSBhYmxlIHRv
IGhhbmRsZSB0aGF0IGNhc2UuDQoNCkdvb2QgY2F0Y2guIFdlIG5lZWQgdG8gY2hlY2sgYnl0ZXMg
PCBzaXplb2YoaGRyKSBmaXJzdCB0byBjb3Zlcg0KdGhhdC4NCg0KPiA+ICsgICAgaWYgKGJ5dGVz
IDw9IDApIHsNCj4gPiArICAgICAgICBpZiAoZXJybm8gPT0gRUFHQUlOIHx8IGVycm5vID09IEVJ
TlRSKSB7DQo+ID4gKyAgICAgICAgICAgIHJldHVybjsNCj4gPiArICAgICAgICB9DQo+ID4gKyAg
ICAgICAgZXJyb3JfcmVwb3J0KCJ2RVZFTlRROiByZWFkIGZhaWxlZCAoJW0pIik7DQo+IF9vbmNl
Pw0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICBpZiAo
Ynl0ZXMgPCByZWFkc3opIHsNCj4gPiArICAgICAgICBlcnJvcl9yZXBvcnQoInZFVkVOVFE6IGlu
Y29tcGxldGUgcmVhZCAoJXpkLyV6ZCBieXRlcykiLCBieXRlcywNCj4gcmVhZHN6KTsNCj4gPiAr
ICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgaWYgKGJ1Zi5oZHIu
ZmxhZ3MgJiBJT01NVV9WRVZFTlRRX0ZMQUdfTE9TVF9FVkVOVFMpIHsNCj4gPiArICAgICAgICBl
cnJvcl9yZXBvcnQoInZFVkVOVFEgaGFzIGxvc3QgZXZlbnRzIik7DQo+ID4gKyAgICAgICAgYWNj
ZWwtPmV2ZW50X3N0YXJ0ID0gZmFsc2U7DQo+ID4gKyAgICAgICAgYWNjZWwtPmxhc3RfZXZlbnRf
c2VxID0gMDsNCj4gYWN0dWFsbHkgSSByZWFkIGFnYWluIHRoZSBpbmNsdWRlL3VhcGkvbGludXgv
aW9tbXVmZC5oIGFuZCBub3RoaW5nIHRlbGxzDQo+IHNlcXVlbmNlID09IDAgYWZ0ZXIgYSBMT1NU
X0VWRU5UUy4NCg0KWWVzLiBTZXF1ZW5jZSBsb29rcyB0byBiZSBjb250aW51b3VzLg0KDQo+ID4g
KyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIC8qIENoZWNrIHNl
cXVlbmNlIGluIGhkciBmb3IgbG9zdCBldmVudHMgaWYgYW55ICovDQo+ID4gKyAgICBpZiAoYWNj
ZWwtPmV2ZW50X3N0YXJ0KSB7DQo+ID4gKyAgICAgICAgdWludDMyX3QgZXhwZWN0ZWQgPSAobGFz
dF9zZXEgPT0gSU5UX01BWCkgPyAwIDogbGFzdF9zZXEgKyAxOw0KPiA+ICsNCj4gPiArICAgICAg
ICBpZiAoYnVmLmhkci5zZXF1ZW5jZSAhPSBleHBlY3RlZCkgew0KPiBCdXQgY2FuIHRoaXMgaGFw
cGVuPyBOb3JtYWxseSB5b3Ugc2hvdWxkIGhhdmUgYSBMT1NUX0VWRU5UUyByZXBvcnRlZCBieQ0K
PiB0aGUga2VybmVsLCBubz8NCg0KRnJvbSB0aGUgaGVhZGVyOg0KIg0KQW5kIHRoaXMgc2VxdWVu
Y2UgaW5kZXggaXMgZXhwZWN0ZWQgdG8gYmUgbW9ub3RvbmljIHRvIHRoZSBzZXF1ZW5jZSBpbmRl
eCBvZg0KdGhlIHByZXZpb3VzIHZFVkVOVC4gSWYgdHdvIGFkamFjZW50IHNlcXVlbmNlIGluZGV4
ZXMgaGFzIGEgZGVsdGEgbGFyZ2VyIHRoYW4NCjEsIGl0IG1lYW5zIHRoYXQgZGVsdGEgLSAxIG51
bWJlciBvZiB2RVZFTlRzIGhhcyBsb3N0LCBlLmcuIHR3byBsb3N0IHZFVkVOVHM6DQoiDQoNCkl0
IGRvZXNuJ3Qgc2F5IHRoZSBGTEFHX0xPU1RfRVZFTiB3aWxsIGJlIHNldCBmb3IgYWJvdmUuDQoN
CkFGQUlDUywgIHRoZSBvbmx5IGNhc2Ugd2hlcmUgdGhlIGZsYWcgc2V0IGlzIGZvciBiZWxvdyBv
bmU6DQoiDQpJZiBhIHZFVkVOVCBsb3N0IGF0IHRoZSB0YWlsIG9mIHRoZSB2RVZFTlRRIGFuZCB0
aGVyZSBpcyBubyBmb2xsb3dpbmcgdkVWRU5UDQpwcm92aWRpbmcgdGhlIG5leHQgc2VxdWVuY2Ug
aW5kZXgsIGFuIElPTU1VX1ZFVkVOVFFfRkxBR19MT1NUX0VWRU5UUw0KaGVhZGVyIHdvdWxkIGJl
IGFkZGVkIHRvIHRoZSB0YWlsLCBhbmQgbm8gZGF0YSB3b3VsZCBmb2xsb3cgdGhpcyBoZWFkZXI6
DQogIg0KDQogKg0KPiA+ICsgICAgICAgICAgICB1aW50MzJfdCBkZWx0YTsNCj4gPiArDQo+ID4g
KyAgICAgICAgICAgIGlmIChidWYuaGRyLnNlcXVlbmNlID49IGxhc3Rfc2VxKSB7DQo+ID4gKyAg
ICAgICAgICAgICAgICBkZWx0YSA9IGJ1Zi5oZHIuc2VxdWVuY2UgLSBsYXN0X3NlcTsNCj4gPiAr
ICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgICAgIC8qIEhhbmRsZSB3cmFw
YXJvdW5kIGZyb20gSU5UX01BWCAqLw0KPiA+ICsgICAgICAgICAgICAgICAgZGVsdGEgPSAoSU5U
X01BWCAtIGxhc3Rfc2VxKSArIGJ1Zi5oZHIuc2VxdWVuY2UgKyAxOw0KPiA+ICsgICAgICAgICAg
ICB9DQo+ID4gKyAgICAgICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCJ2RVZFTlRROiBkZXRlY3Rl
ZCBsb3N0ICV1IGV2ZW50KHMpIiwgZGVsdGEgLSAxKTsNCj4gPiArICAgICAgICB9DQo+ID4gKyAg
ICB9DQo+ID4gKyAgICBhY2NlbC0+bGFzdF9ldmVudF9zZXEgPSBidWYuaGRyLnNlcXVlbmNlOw0K
PiA+ICsgICAgYWNjZWwtPmV2ZW50X3N0YXJ0ID0gdHJ1ZTsNCj4gPiArICAgIHNtbXV2M19wcm9w
YWdhdGVfZXZlbnQocywgKEV2dCAqKSZidWYudmV2ZW50KTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAg
c3RhdGljIHZvaWQgc21tdXYzX2FjY2VsX2ZyZWVfdmV2ZW50cShTTU1VdjNBY2NlbFN0YXRlICph
Y2NlbCkNCj4gPiAgew0KPiA+ICAgICAgSU9NTVVGRFZldmVudHEgKnZldmVudHEgPSBhY2NlbC0+
dmV2ZW50cTsNCj4gPiBAQCAtMzk3LDYgKzQ1MSw4IEBAIHN0YXRpYyB2b2lkDQo+IHNtbXV2M19h
Y2NlbF9mcmVlX3ZldmVudHEoU01NVXYzQWNjZWxTdGF0ZSAqYWNjZWwpDQo+ID4gICAgICBpZiAo
IXZldmVudHEpIHsNCj4gPiAgICAgICAgICByZXR1cm47DQo+ID4gICAgICB9DQo+ID4gKyAgICBx
ZW11X3NldF9mZF9oYW5kbGVyKHZldmVudHEtPnZldmVudHFfZmQsIE5VTEwsIE5VTEwsIE5VTEwp
Ow0KPiA+ICsgICAgY2xvc2UodmV2ZW50cS0+dmV2ZW50cV9mZCk7DQo+ID4gICAgICBpb21tdWZk
X2JhY2tlbmRfZnJlZV9pZChhY2NlbC0+dmlvbW11LT5pb21tdWZkLCB2ZXZlbnRxLQ0KPiA+dmV2
ZW50cV9pZCk7DQo+ID4gICAgICBnX2ZyZWUodmV2ZW50cSk7DQo+ID4gICAgICBhY2NlbC0+dmV2
ZW50cSA9IE5VTEw7DQo+ID4gQEAgLTQzOSw2ICs0OTUsMTAgQEAgYm9vbCBzbW11djNfYWNjZWxf
YWxsb2NfdmV2ZW50cShTTU1VdjNTdGF0ZQ0KPiAqcywgRXJyb3IgKiplcnJwKQ0KPiA+ICAgICAg
dmV2ZW50cS0+dmV2ZW50cV9mZCA9IHZldmVudHFfZmQ7DQo+ID4gICAgICB2ZXZlbnRxLT52aW9t
bXUgPSBhY2NlbC0+dmlvbW11Ow0KPiA+ICAgICAgYWNjZWwtPnZldmVudHEgPSB2ZXZlbnRxOw0K
PiA+ICsNCj4gPiArICAgIC8qIFNldCB1cCBldmVudCBoYW5kbGVyIGZvciB2ZXZlbnRxIGZkICov
DQo+ID4gKyAgICBmY250bCh2ZXZlbnRxX2ZkLCBGX1NFVEZMLCBPX05PTkJMT0NLKTsNCj4gTG9v
a3MgdGhpcyBjYW4gZmFpbC4NCg0KT2suIFdpbGwgYWRkIGEgY2hlY2suDQoNClRoYW5rcywNClNo
YW1lZXINCg==

