Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B417CCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMI4-0005y0-JN; Mon, 27 Oct 2025 08:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDMHv-0005k0-6G; Mon, 27 Oct 2025 08:25:27 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDMHh-0003zM-JV; Mon, 27 Oct 2025 08:25:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCoq33DUgRiT0Ll01++6lq/x7sfITI64KY2nKyGPLGRRrXeAXYVx2yYTtJzi9dmttKrPvLHjoAjXBJUZx8Wml8EcElWrYKktsUwnBTMbsiBGEq0Kec1UwL2Ysr+1a3ooRa6+nVN5Ii4y5YfN2+sQYXI9CubgW2Qrp7uchJggsPD04g32enZ5ltA4KPghIjfGDQQ4sYOWYc4dIXQYa+SXgTZi2SuXvW4A/F/JQr4qkn/I6OUahXQdTkG3sVva/A5+J0i4Ik5n49tINSrTjxuYPG11Nn7y+kbbUkktjtKfvRkaJLCN55FcDPueHJUutzc7Wu/DKCQX2onqMiZgF9/mjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0PKNULZz2Hzk5i0/EI6OpgrnTGfU7iyWH6/tU9cp8c=;
 b=cpVxhGX4DImRGivadodU+31Fo1tT6PzJWROwEUNPF+Q56g7jJPba4KHi8dKAU2VasBGagUJjfpreV/vX+zUtMv1kCjEzEvJLlg6QdzZSWFlXy3ZS5xloSnmn0unzNrUP4XXsyM3BUCrbh0MvGi6yLrY3RBtRTXnWHNsSYOt5G4dCXAjjxLAyjb/c4Jl9e9rLmr4dEguXDTTx8WnuiQvnP+rd6iEkMO1hrE5ewSq/OsQHs8rBCSgf7c3Jbe1od8UD8uWxSwc42yy2lKlwe3YxSwBdnOj+VQx8bpn/r1mXGB6OTJbFQbBxUal+5n0eVtL83gTW9SaYB3mvrqUgzcBS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0PKNULZz2Hzk5i0/EI6OpgrnTGfU7iyWH6/tU9cp8c=;
 b=l97QYjzF8aI2Q0XbHmu6bqtHVhuHhjkLCQzKcsp5NER8oTw0TXyocrlnBQL0HHoQ+37ejfPyhTiwBE/IPhzeiBmC0OHmp3A/hs5hrxVDFyvAcWZNi0z0sES8tceXBNnQxULWvw/RNyFzaEVlPkruGxyLdq17rdDvfUroZyZI98PhQUVT2bVGzDhpnfd1+mgeltQ7Swy79yRb58TjWKHGWXsH2vgC4W7UIuBprry9xj+t0NB+n5hMVwZZS6XeEolYXuQpyYXwSY3fl24uXAc+MvOTcO/XCKB8Vc006Q83DG+nKSURfkxRiK8aWx1LRQfko3bUAfMsOqOI5JOmmgpwvQ==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 12:24:54 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 12:24:53 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 14/27] hw/arm/smmuv3-accel: Get host SMMUv3 hw info and
 validate
Thread-Topic: [PATCH v4 14/27] hw/arm/smmuv3-accel: Get host SMMUv3 hw info
 and validate
Thread-Index: AQHcRy71PA/MgQKh4UGAmorIYeppLLTV6seQ
Date: Mon, 27 Oct 2025 12:24:53 +0000
Message-ID: <IA0PR12MB7555C61C671F64057ED6B0C8ABFCA@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-15-skolothumtho@nvidia.com>
 <46292ce1-e930-4ae8-97fe-626ed2e4d3c4@redhat.com>
In-Reply-To: <46292ce1-e930-4ae8-97fe-626ed2e4d3c4@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|DS7PR12MB8348:EE_
x-ms-office365-filtering-correlation-id: 6366c84b-39d5-452c-12ee-08de1553d55d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Nzg2a0tZa1FURTJoZVY1ditFUWNTQ1MvUS9lU1ZwRkg1OGxTVTJvVFllV09T?=
 =?utf-8?B?SXp0RElNRGpRamdpZmxUNkJ3eklRVFBJcUNhc3BKSUczODNYcjRVT3RxMjQ5?=
 =?utf-8?B?cHhqeEdxL1YrS1ZxUWgxMHZGTnRpODQyRHJ3SGRqSGRWaTlxTHRkS1ZoMWtk?=
 =?utf-8?B?WkJHZXd5RTZQbTYySHFTYmpQckpzUnBrQVNpdUFBREgyckFpbG53clByWko5?=
 =?utf-8?B?Tythc01GcWdlbGRTYWRJck5xTXpzaVRLZmRwOU1UQTZqU1hLcTFaMHUwTTQ2?=
 =?utf-8?B?b2xYb0RUSHJGWWN1VUNiZlNITjVxMHBITEg2MkZocC9oQ3Y4NmowR05Gclh5?=
 =?utf-8?B?dTZqTzNLK1B1cnZHNXJxVjFSSG9jbGJVWklaT296YzZLTUJyTFZoZjlIWkpH?=
 =?utf-8?B?LzhxekhoYnFCQXRqTTJ2OEJ0NWlyRlVweVlHWituMmpIakk3VWRMaUtyajFz?=
 =?utf-8?B?T2ZIZ0VxbnNqNTlzZW1QZ0RWQ3dhNUlBMXFCY3U3K3pNcnMrb3UyQ3cvT2No?=
 =?utf-8?B?emc2ajZuSFJkb2NxWVFkZklMeHVKYU83aDZaTHBTR0JNeE9TVklXSVZZaGw1?=
 =?utf-8?B?LzJxQ2xLUWMxaitub2d6dFpsYmdCQzFQdFlEZmoySzFMK0tBS0daSkk2V3pF?=
 =?utf-8?B?NlhtMDRrcUIzYWc0Z29ZMzhzZHkyQW41aXFIWFhjUHBDN1dURk9INk1vbDBj?=
 =?utf-8?B?UjZCUGNZSVFuT3FTOU94aDlGemhlVjUxK3JyTDRLdVJlZGJZL0VFQUt4ekVp?=
 =?utf-8?B?blhsaFdMZ1hXWVl0VFVaNWF1ejByUGNwUEM0UHdxRHhoekFHR1pNWWRBUjJY?=
 =?utf-8?B?OU1lc2VyY0FON1hyV0xLTDB5WGFFVUxyZC85Ym1zWXkyR01uRjFPUlhjMTN5?=
 =?utf-8?B?TmRON09jT2JQdjY1UUcxTDFGQWdFVlhKd1dNYXRiOGM5bzM0WnBlTk41dW11?=
 =?utf-8?B?a0RCdlRTcUtheng4akZzSkFOQnJzRTFObU1vTjB3ekJZVWJRODZYNjBOM0wy?=
 =?utf-8?B?elFSU2xCODdGNWFjaVRnWkNnNnZSRjFlVlZuTGJaVDJ3dm1LVzVhLzBheUM3?=
 =?utf-8?B?ckhWVUx4WGZ3WmVlQjE2QlR5aUdKZllPWXFpV2xWc04ra051blBHQU45TElO?=
 =?utf-8?B?U1FHb3JySXFqaFk0UjhmdVNVQlpmUmtUdWZ3WDlTekQrMFZWaHVoanBUYkZ5?=
 =?utf-8?B?a2xZMkdaYWlpejV0SlpuVHlYajBKV3hMOWYvTy9rWmFpc285L3NGdUh1bW5t?=
 =?utf-8?B?elBYblB3Tzd4U1FMMWlNUzg3azN4dWx2Q002d1IvQXFsci95cjZLNG1qek9x?=
 =?utf-8?B?RmhHNk11M3gxRTQ4K0VmNDRhYVZQWHJtQjZ1SlBPYXRCZmdpT3llYnRGWkkr?=
 =?utf-8?B?ZVlEeVVlV3VTZ1ZONjJoQ1NOeGUvQTBTTlNBbVYzNmpiN2J4YXg4Vm5keW81?=
 =?utf-8?B?NFU5SmtncG43a0NOc0lCUFMzcEJQQi81YTZpZmcrRXRkeStoY2JZUkc1Smtk?=
 =?utf-8?B?eWh1MnA3Wmx3UDF2SWR3RldZY0xGV2xSY1pKVUtjd1dvWXZjTGtyazFZSWRa?=
 =?utf-8?B?Mm0xWEpUYjEwQmJuTzk1dHhpeGh5Z0pFSThJUVZrdW9rUGdtb0FGeDNHS1R5?=
 =?utf-8?B?R1FvOWIrTTFwUkxCekRFUXRIRWducGFZT0NYai9GRWx0TnE1YmEya1NmZjR4?=
 =?utf-8?B?emQ1Z0pWQVF0Q1BwbGtsTXArSDZTWCttZ08zUGxQM2NkQkZuMVQ0RFFIcWNG?=
 =?utf-8?B?b3NpYUtvNllJVUxmS0pIT2NyVEpDZEVEWUFNbVJZZHpXVkh3ako2RTlmOWNZ?=
 =?utf-8?B?d2NLMHVyaktWK1NWTjM1RzMwUVh2MHQ2VWpmakd1MlVmZHRtaXY2ZzdjakpF?=
 =?utf-8?B?M05IU0RCN2M2Y3NsaGdBTk51SmpMN1huN1oyQTVnVy91ajZZUXlzZUJWY3o1?=
 =?utf-8?B?VUpnc3lyQTZHVVdVSHF1MmpQYWFHak5POUM5R1pHRHNlNHpzak45aVAxMkNu?=
 =?utf-8?B?MWNsc2FWclpjVFlrOFp2K0MyOGo1T2xXUWpnQ0dsMllOZWE5bVI0amNiNUND?=
 =?utf-8?Q?UF4fQq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUNaWFVINmRXR1FZeUNITWEva3N5SUk2MWNDZm44SC9TRGFHY1FqbVloQzIx?=
 =?utf-8?B?azRSS3ArYXg5N04zSkZVc0xOWlpmU0ZjQ2JMa2NWVnZWNk5VNUZHd3kyTzJW?=
 =?utf-8?B?OUlROWFkeEVBN3l0MlpVTlY1ZjBFd3NycG5CL0I3SGJURkJXNmd2UGlUTXBH?=
 =?utf-8?B?aHFBSTRvYituZTZ3UjEwakZKK203eVZuWUEzSW5wM3dBY0doaW13dndEVVUv?=
 =?utf-8?B?MXNtaWR4UzhkZVJwQ2h4UjJ1QVNxQ1IzUHhwbENnc3R4Y3BwTndLRXl3bjBi?=
 =?utf-8?B?VTJnekxRNDU2bDkrTEtTOTdXM2trWkxiVjBNTEhiZGtOZWRNMVFudUw3OWU5?=
 =?utf-8?B?ejFsVit3Ulo0OHFNZHZGZDhhN1dqcE1IS29rZFc2K01oLy83MXBmK1BqM0xB?=
 =?utf-8?B?dVhFT3luWTRwUEhFZjRRZlh5WUxZbEZNenlNbGhJZExzczZBY1cxN0VhM2FO?=
 =?utf-8?B?VVYxRzRtNTdyNlM5dC9Tdmc4cUplSndHNWIyb3BCZytXVzIybHNnc1dPeE5X?=
 =?utf-8?B?cXVxNUtXV2tsWkNieGhtYzh4UEZNbWh3WUpqZW1jaURFeWdXdFFNZitmL2g3?=
 =?utf-8?B?cURNYzNxT0h6R1krNXdUUS9BV1MvbkROd0dOQzR3YVRRUkRYTkpZK2Q3Y3gw?=
 =?utf-8?B?b3BLSkRtVlVacHp5ZnZteTl0STFVT2JsYm1ETU96NnVBM2tkalprZ3Q5YUts?=
 =?utf-8?B?d0krK1N1K0MxV0VaRzAzSERCM0NVSmtuYlB5cFNQajdFRDNVRkJYUXZBWFkz?=
 =?utf-8?B?VkQrSUp4QUFtbDZWdWlCbkJVeWFGRFZlZEExZHRMRjJjemloMC8ycER3T3k4?=
 =?utf-8?B?YkVMeDV4aVFhVThFT1k0MHkrSXpLYUdCd0FoVmw0NSt6QTZYUUxINzJnWXJt?=
 =?utf-8?B?QjZBL1ZHc3VuTGNUbGhKanlwSlpObDhuUUlWYVoyYnlFelFFV3g0b3hxVjNi?=
 =?utf-8?B?cVBoU2NnOTJWVnQxSXJnamppcWw2WlNUQ0tPSFdHMmZLdzFySTltRDQ1OElB?=
 =?utf-8?B?S1FGQmh0OGF1MjVadTlkc3RpQmRXb3RTNkpsMmlvY25Hc3RYYmZ1ZklqQ3dp?=
 =?utf-8?B?T3o0T0czMGVNczVVcXlzMDZ4UDE3Vm1Lb1NldnhESzU1bEd2dThqTExQUy8r?=
 =?utf-8?B?Y2x1aHQrN21DYS84N3daTUhJcU80dnUyL3RrWFBYRkFQakR0UmhjTGZxRTg4?=
 =?utf-8?B?MlpOYTU1cXF1WEtnV1FablA1bUIrNkJkTHZjYmhJS01uQlhqN1NublFDSlhY?=
 =?utf-8?B?dnVhbFlIMFJ0TVV3Sm5vY2lxTGZzcStvRmRIdExUV0VZR0ErRHkzU2NkUEQy?=
 =?utf-8?B?YkRpRVBEMHNTS2N4VTVTN1BzakF5T2JIYkV4QWlQL3VNT1pObG42OTd3bE45?=
 =?utf-8?B?ZXk0ZWxTSjFrK3ZFVU5HUDkvVW1BTkhtQllWWkQ0VWRIeTY1TUdxUHlidFFP?=
 =?utf-8?B?S21aQ2NtOUg5ODdpQWNpZzQvV1pmak02czlxMXFiMndCUjBxUjBHKzlMWTlr?=
 =?utf-8?B?Z3NxbnM4eUdVaVVJalZsVWRCamJxTVUySThCSHBheU52bjVmTUdUbGhqQ25P?=
 =?utf-8?B?SllhbHRscDl1ZFZWOWo5S2tiUE1pTnZiYThMSG5jUHFrejlVdFN6b3VDd0F6?=
 =?utf-8?B?dkQ4eUgvUDU3UEhiUGl0ampiam5NYTlUU3IvTFZTc2dDa0R2dWwzYk03TjJV?=
 =?utf-8?B?YUwwRGRGRkt0ajVNYWYyOTRuYXE5MitSWGxWNGZZTkpzenUxVmpyV3dyT2Rh?=
 =?utf-8?B?RkhYWVo0RDJQT2xzU0tPWFlINEZMRmZYY2tFdnBpVmdIS0RCb0c4V0kwR1VG?=
 =?utf-8?B?Q094QnZhNktxME9LWVJOdTJ5ZFltdHdOSUtJRWpvNjVPSGowb04zcTU2d3VC?=
 =?utf-8?B?UFlmT0EvZmFuOGVOUGY3QVpyOFlDcFRCd3d6S2RjY2pmZjE3OHMvbVkrWUsv?=
 =?utf-8?B?RE5WSDltVndOUnRwUjI2RTAzVW9acGw2Yjk0MUo3c1Y4NC9vN1pUZEx5UWhj?=
 =?utf-8?B?MG9WeVZUYkZhc3IzV2Q2RkQ1aDVSMW5MT3JxQVZqQlBFMTJTZVhneE5hVmJx?=
 =?utf-8?B?dG9oY0dEeSt4RlBEVThidU5NSzhlYmhuc1RLUHhyYUkyVVdRQXpjOXFLZHZD?=
 =?utf-8?Q?JQ95oFJ6csGmAElepwKDHxKmn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6366c84b-39d5-452c-12ee-08de1553d55d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 12:24:53.8973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ONH/ivErjUSXvbI7W0UobDIVv/MZBLuuFanty9hwaJgUXqIl0tPxqxw9S37lKmPp/oWMyReSzOjFd0CCu89RGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAyNyBPY3RvYmVyIDIwMjUgMTA6NDcNCj4gVG86
IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgcWVtdS0NCj4gYXJt
QG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnOyBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgTmljb2xpbg0KPiBD
aGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgZGR1dGlsZUByZWRoYXQuY29tOyBiZXJyYW5nZUBy
ZWRoYXQuY29tOw0KPiBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hz
IDxtb2Noc0BudmlkaWEuY29tPjsNCj4gc21vc3RhZmFAZ29vZ2xlLmNvbTsgd2FuZ3pob3UxQGhp
c2lsaWNvbi5jb207DQo+IGppYW5na3Vua3VuQGh1YXdlaS5jb207IGpvbmF0aGFuLmNhbWVyb25A
aHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbTsgeWkubC5saXVAaW50ZWwuY29tOw0KPiBzaGFtZWVya29sb3RodW1AZ21haWwuY29t
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMTQvMjddIGh3L2FybS9zbW11djMtYWNjZWw6IEdl
dCBob3N0IFNNTVV2MyBodw0KPiBpbmZvIGFuZCB2YWxpZGF0ZQ0KIA0KPiBSZXNldFR5cGUgdHlw
ZSkNCj4gPiAgICAgIGlmIChjLT5wYXJlbnRfcGhhc2VzLmV4aXQpIHsNCj4gPiAgICAgICAgICBj
LT5wYXJlbnRfcGhhc2VzLmV4aXQob2JqLCB0eXBlKTsNCj4gPiAgICAgIH0NCj4gPiAtDQo+ID4g
LSAgICBzbW11djNfaW5pdF9yZWdzKHMpOw0KPiBkb2VzIHRoYXQgd29yayBvbiByZXNldCgpPyBC
ZXNpZGVzIHNldHRpbmcgaWRyIHJlZ3MsIHNtbXV2M19pbml0X3JlZ3MoKSBhbHNvDQo+IHJlc2V0
cyB0aGUgY21kcSBhbmQgZXZlbnRxIHBsdXMgYSBidW5jaCBvZiBkeW5hbWljIHJlZ2lzdGVycy4g
VGhhdCBuZWVkcw0KPiB0byBoYXBwZW4gb24gcmVzZXQgSSB0aGluay4NCg0KWWVzLiBJIG5vdGVk
IHRoYXQgYW5kIGlzIHRha2VuIGNhcmUgZm9yIG5leHQuDQoNClRoYW5rcywNClNoYW1lZXINCg==

