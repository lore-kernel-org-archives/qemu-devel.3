Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8B0D13C11
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 14:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkNPP-0008Kp-6H; Mon, 26 Jan 2026 09:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkNPK-0008Ei-Pa; Mon, 26 Jan 2026 09:17:34 -0500
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkNPI-0000Qv-Il; Mon, 26 Jan 2026 09:17:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pME7Y6jfOwa3PpUWBxjTGvWrHBG4X45ROVDcltvRxRs/acXYeXdvySGC7iZfnGhPRYS0eNaZ5FdNuwe78tbQfcYCwAi9VFuhUob75evQmQNLtKXKg3ApZGeH1aXzFDXBK6/SF9Q1aZ3hOeYOw/oaJOInHknCi4ttbwXJu6543Wv6qdKx2nJyX1jxgRAjjJRx2R4teyWsqgZNjn9bUqS0I3luKVdUrvg6hchoh/oaJ45OQaDGwpEWNAPjpUSBbKobOztznkCFt0pypsm41ie0L9wEakFWxCbDnSwtDCig+e+xfkNil+qPjGvBoda/WuPtcQDmd1JoDfJpkR/vomdt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRnJVVRPUY43/3WQafdiy4HCyqmB5p5T6JfmVJOyYKE=;
 b=QtFSi1rIONWs/3Ql0J9DoTBlb8gURuZVlfC6nnHLnhIrTaZQhGalWdrDw9icY2jTGK2i2tXpWktCEdL2C2BmJdWf4sITl73Pax3Cs57XLdn5Ezt5Dx/EfTfJjReeVPGrfdotN0qluzG5W7tZc8Yj6Q6KGz50RvmNH0VKMXQq2gIPYYjzQnl96S+Si/oT0KyZmFQpbAvjBNYHCxkWu/IARThLbSqAo2PcWoStLMxH4O1pX+YcsuoppZfx26IAHirIkk/QkgycxrT/mlKZ/72d6wLTVlMGEIu9vBskCmw7JS5FtNFheUfvEDCGvtI3c8/lBrpc7nv/F9paejzcT9NNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRnJVVRPUY43/3WQafdiy4HCyqmB5p5T6JfmVJOyYKE=;
 b=fSn4ogJGo1DYJAaZMMxYLfBSYho0gLc+cgaEqNfM94aHxmjjMqbJwYdWmdfQm0hhFYn5Ng8GfRRMjLpHL1px25H3X6uSr0Bhb9J6rLtGqoIFUp80Mz0kySRQDsnE39e6mJO01bRwsYryAOd4zROLvuoW7fo0Mw3b4RShVVP1kofcQc8FggetNcoPT/i0wBkdQYdYoQwZsKxjLTGIFXBOTJjT9NbstKK4GN7QLAYjUqWUxvAO9Km5M8biupPgjI0wkbQxyg0d8VPHWDVxdwVOYXfXFhchFs1YDBA4GfG5aQN6W5HUHt+lKih1DFItKajsLKyAYHByOGdmx3LOYKVFoQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 14:17:24 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 14:17:24 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v9 34/37] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
Thread-Topic: [PATCH v9 34/37] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
Thread-Index: AQHcjrGXmzNck6z4KE2b1d+H5kntgbVkW1OAgAAfmrA=
Date: Mon, 26 Jan 2026 14:17:24 +0000
Message-ID: <CH3PR12MB75481EF03A19B7DAFD9EA25FAB93A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-35-skolothumtho@nvidia.com>
 <a66aef84-ce92-4193-89bf-33651875452a@intel.com>
In-Reply-To: <a66aef84-ce92-4193-89bf-33651875452a@intel.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MW3PR12MB4489:EE_
x-ms-office365-filtering-correlation-id: e4910e58-eb56-4b96-9d8f-08de5ce5a082
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Y0ViRHB0ZjdGZ09rUFZjZ0ZBM3N5L05ZZ2YrV2VvSzVST2ZjZjFHV3BMdTli?=
 =?utf-8?B?Q3IvQ3QzTnkrTkNkaThFZjl6RGxEc0RHM3M5TnpGV2UzN3AvdWF0Mld3cTBx?=
 =?utf-8?B?aWhzRXU1WStVem5NVVhIT2hOTzdqbGpRM01CSVJlbHpVUS9ZeFUySXRoT1hK?=
 =?utf-8?B?d0FNZ2JrM0FNMFFyaHQzSEFwVlBJV3JVcjdJeC9MTGMwbko5anJvOW9yTS9I?=
 =?utf-8?B?aDZqRXZob1VnU1lzZHkvaGYwOFZNY0V2N2hxejFqUVpVMUgzYjNUZHkvVTQ2?=
 =?utf-8?B?Sm5lb1NnN05ld3F3MGgwQVFlNDJuS1JuR1kvSlF6eFRoaUs0WlJsd28ya2dN?=
 =?utf-8?B?WFBsaktBdzB0anM1a1NKTGpxajBJZ0NqMGQ3RFAvdVQ1NnNpbTJrZlFJYmJP?=
 =?utf-8?B?R2dUTjQzZnVFQ0xWbEFZOG5KeThEeHRueWNzamUwSzBrZkx6bzNEV1BnWTUx?=
 =?utf-8?B?ODBzanRmYitTMzZiSmZJRnVSd3gzRCt6QlZOM29aQlpJOUJvSWRwaVFOMkx6?=
 =?utf-8?B?dnhHSHJWbm9wSGswNVFoWkU0UGdrV3RteWdCMmVuU0FiQmp2VGwzVnBpNnZJ?=
 =?utf-8?B?N0hma2tRcmpDN3orYWZIWjNGSUYrZVJtZVZERTNWSjNaKzR1OHpzaElRZXdu?=
 =?utf-8?B?djhSWllsd0dWeUpTdWtON2liZisrOHJ1VTlYNFRvZnd4Y09sSjlDUzRnbGkw?=
 =?utf-8?B?Sjc3b2YwR0g3bnk2UHdWRW1lc2FNdno3UkZ6aHUzbE5yMkpHcWdoUlVGYmFL?=
 =?utf-8?B?QTJ5UnNrRzNQdzl0MUNua0RaY2VHcUlZQ3A0SXRiTFF1ZFdCYWtLVGttMmVN?=
 =?utf-8?B?NGRHZGlYdFh6a21TTmVmN2pSa05vcFFyeVJDZmZGSEZZd05ja0ljMElqeGRO?=
 =?utf-8?B?QkJIdWtvRzlPTU5YMlZvNDBkSjFTK3BrV0hZYkNnR3did2srRmdCeDhkbTdQ?=
 =?utf-8?B?QkVPRGdxalI1RHovakVBcFRVTldpYkFBM29NTWQyeklYbjhvRmlieXpGRVBP?=
 =?utf-8?B?S3M2MFFTM2RIWkJTTnBqTi9uaGNyS1VwZkdhSEcyWDVXMURhRWNVTDBSTHMz?=
 =?utf-8?B?REQrZzhQV3JvUWkxUk1ENTc2R3h1b0R0SU5ZOUtndzFwR0xvT2hsdHFEWWVU?=
 =?utf-8?B?NFFYUnlqdjhRbkl1aTh0M0tjZGFHZUZ1cGlISmdhMTRFeGtBK0Jmb3FyVkV5?=
 =?utf-8?B?U2dxdmlIRFNZUEV5bjJzc0hROFRSS2llLzJGaXc4ZDh2Z2FoZGdCSWxVRlVk?=
 =?utf-8?B?WmRodG1ndlVQNzU3NFEvakJmelJVdHQzSzBONE9RdVZKTDBuaklyUDJMY2Jp?=
 =?utf-8?B?NmowSDhuSjYzZktJZjU1UmNVUTJWYWNuOEd3ZXZIUnhGSUd2Y2k4MWRyd1Ft?=
 =?utf-8?B?MXRBaGhjRVRwT1VBTEdZWVZTdTJ5U3N1WUdJMTdTZVZWd1cveU1adEQ1OU85?=
 =?utf-8?B?bVc5eW1OYnVGakFWYWh6SHNnVzNKbFVwY01KeHV5dWFHVlNZU29HSTNEcWw2?=
 =?utf-8?B?Q1F5TU5SYTdoWllSa3pXSzZkSkZRSFhxemR3czVkcFBoalVkUm5rTjVOdStH?=
 =?utf-8?B?cVdqUGd4ejJ2TGo5TFpNNWlrbitxWWU0TFN0MzlFZjRGSVhyQXlIV0NlaHp2?=
 =?utf-8?B?QTBDRWtsaTZxeU94dHJVYnBnR3dwY1JhUy9FUE1IeUJMSTdFNUx1M0FyRFNP?=
 =?utf-8?B?TE5CLzZndUZQZHY5KzhDNW9BTzN5ak9hdUVqWTk5amwwcTdOVlhNOEtnSk50?=
 =?utf-8?B?NjNnTG9EWEdGeWx0WVVXbndzelNsQUtvanNlb3oxL0JUZ1ZTYklWNUsvV2Mr?=
 =?utf-8?B?OGtSZGJYeVRtejVtbktLa1p4TEFxejJrQ2g3dEs2V1J1S2pCZ1piR2Vsdm1p?=
 =?utf-8?B?UzNSUzBEbnUvd1JoanduMHRtOHZkMWV1dGcyU2FnOFhGWjh1YTNPMU50dFRt?=
 =?utf-8?B?Q3RDcDQ4MW5xamhLbXFHNGhRdVRwS0Z4dGtpcXpyR0I3Rmd5U1ZDRTh6RUpm?=
 =?utf-8?B?cGNKZEZTN0hQaWMwdG9iTU5vUnFoWVNxaGtXNHBqL3dtbEVzQVFzVUlOSVAy?=
 =?utf-8?B?SjRWcGZmVEl0KzlLdWtUZkhuVmg4RTJQbmJ1MEFoNWVFSVkxWXpHUzNUU2RW?=
 =?utf-8?B?a1dudmxURDU4bkIwd2tVQ3E0S0wySExIaUpYTkNEWmlQZ3A3VTBMeFVFNGdJ?=
 =?utf-8?Q?k0R01hZ7ApFKwYYbGDNrweE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXl5bmdneS9yMGdUK1B2UVBvU2pybk1URFAzK1ExRnhId0dENzJmaWZoMnZi?=
 =?utf-8?B?Mk5tTVlsdGZ6R3pPelUycUxNUytYWHdZaTVXS0hNanV3b2Jhbko3WU1TcWhZ?=
 =?utf-8?B?QVh4S1g3ZFFCYmw4Lzl3cHNFQmRUVlp3cHdkVkhYU0FFS3I4cURnOFY2bEJY?=
 =?utf-8?B?MldDbUpNVVliei9IYVZVS3krZ3R3RUFTU29NcUg1Mmh5R2hXM0lmaVc1UWVK?=
 =?utf-8?B?ckJpN3h3bG9YVmRZcityWVdueEkyOHRzNEl6Yy9LNzQ5R2poZGZ0TlFVdjRr?=
 =?utf-8?B?YUxwSyt1Ly9YamlrNzc0S2FBZG41MEJQZE41TStmVmR2Z1duWFZyT2FHNWxw?=
 =?utf-8?B?VkRxbGtNZG9CNnZYWVdqeTNzUUNhZTlRM3FBVHJqOGFnYUJPQktqaFQ0T0FB?=
 =?utf-8?B?TktMMHVmY3BSNzJNRW1JbU1OQTlETjZRUDRUV3o2WG93MEF6M3BERy9HRjB6?=
 =?utf-8?B?Q1VGcHNjUThZc0ZTMGtiYTVXUllySXRsNzUxanJoRkpkb1I5bUE3Q1lHQzRL?=
 =?utf-8?B?dDIwRUNwVjhhRUNjT1RjL1RNbkFwNnlZM2Mxck43cEE2LzFneGF5ZUxVOHF2?=
 =?utf-8?B?QW5LdjZKQ0xrUkxya2lpTHRHSzNST01XOHp2bW02UGJ5NC9ISW8rL2VVOGJi?=
 =?utf-8?B?ZUhDL1dUZWxHa2V0SWVkNzBmMG1QZTVmd3ZSY1dtUER0c284N1RFNTRvNVpz?=
 =?utf-8?B?WDhuakpKY001R2k3a0Y0YVVORnRvdWhYSDlpUHlRTmdTY3lrV1NiM0tBQ0Nr?=
 =?utf-8?B?TXhhTTVBMlhmSTZtNlRYblk2V2pwRWg2MVJQa3hMeWMvMmZpWVVsbURhZjZj?=
 =?utf-8?B?OGpEcFpCekxNaHJQK2lLWUxRR2gxTnNqSEUvdlFmTXB3dlFreEFKNHUrL2tv?=
 =?utf-8?B?V3o4MEh0S0lXRjdjMEZlS0FhZ2ExUjBXN21oVzIyeURHc3daLzFuZzRtY21u?=
 =?utf-8?B?UzZFdEcydzZQRVN5QTJGRW9lL01kRWpXb0pISy9HVEZsekgzM1ZHZ1NDVnYr?=
 =?utf-8?B?Y0h2V2ZoWDBnSXUrT0ZReGdUR2NnUEtkMWsxeTErc2U2Y3BxR0VhSEpjaDds?=
 =?utf-8?B?bDllQllsVTVrRDlWK3psMWZCSWZMb29BVTdEZjJqT090Q3ZaWVRDQlVEbVVB?=
 =?utf-8?B?T0lCdlRxNHpoa0FnVGV1SlF4WWRTOHFia0VXQlljRi9MRUpwanY0QXo0YUZL?=
 =?utf-8?B?cmQ3T25IS0cwUTAvS3lzUWJUZHp5eXNtZ0VaSmhpUzJsNEZvM0ZKV2U5cVdo?=
 =?utf-8?B?czJ3Rm5hQUFEb29aT1ZHN2dtVTZ1R0RzUDJxcnVnanBqcnp4ZXpSRHFpeG9q?=
 =?utf-8?B?RG54dTI5RWo5dDFKcGx6aTJDZ0t4RWdVNVFFRjJnbDNZQklIQ3RuMFR4OVdZ?=
 =?utf-8?B?eUFjK3FRZHlOa0ROMjFtak9INkFmWEJBUmZJNkZQSUNSeVdxL2pBQ0xweS9P?=
 =?utf-8?B?YkF3V1lleEUwK2VGTWdCKzgrNjYyTzU2TUg0N2E3QlRoNTZocmR2UlJlSGJ5?=
 =?utf-8?B?RUNFa2tnVGFMNXlHK0pyZWt4NE1lRTNsRzhGL1JwWWpCR1ZpL0N1WG1kMjFU?=
 =?utf-8?B?UlVmcmYzSWlSV1VIaFljOHZ6b2EvbW43cmVoeWRFOWprR1hGbUZoY1lpNU1U?=
 =?utf-8?B?bnRQOHVlc0JFODBtWnlaWm0vV2lHM1dpcWg2dkM4b0dzK1lsYkgzczhUY0Fp?=
 =?utf-8?B?Mk9aZnkzOUhoVEhBRW5FU1FHRi81WE5YNURWUUVDNjNWMFNpUnZSVTJOK1JP?=
 =?utf-8?B?TW5hT0hNM0o0ODZPOFl2V2dxSGZQY2hITm83bndQNW9McFlOcGY0eHZxeWds?=
 =?utf-8?B?QnFTZkpNUDB0VFFLSUFYTFc1UzZocCtMMHVSMjljelRVdWhDR3VkSm9iRUFv?=
 =?utf-8?B?b21sQzgvTDBDSUEycklMUlJQdkM2S3FtNSsvckt6SkpscnBXbnd2bXJmZGVI?=
 =?utf-8?B?NkdtZ3NicXYrNXlpQitOOEJOYnhnM1g3bFVZcE45Nk1Za01Pa1FhdUh1c1lQ?=
 =?utf-8?B?dzgrRGxjaFhlWlNaSVhjMndBVmhlTUZXRmJtM2EyZUJzanJON0t4YXVEZFI3?=
 =?utf-8?B?ZGpjYmp1MnNySU9pNXNiQ3FLYWI5RmRTcEEzZHB1UnZmVGRWNUVMbGF3K3N4?=
 =?utf-8?B?MGc0UmdJQ24zV3J3ZjR1RVNMQm5HSHdTbWt6Zjd5TE5Zb0FVN1NNZnhpbTFk?=
 =?utf-8?B?WkVnbzdaRndGMUt2Ynkzemx3NmJ3WUQ3ZXBWM0VwY2U3M09PcEFRQzZHTDNN?=
 =?utf-8?B?TUFUWlZQUnRjWEtuYWhCS2MyZ3hkcTFGT3owYWZOdGw1Z0RqZmtxQm9oeEFt?=
 =?utf-8?B?SU9XanBRL3E0eGwwandac0VRbmNDRm9yVnlYeVI5elorRGJhNVk3Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4910e58-eb56-4b96-9d8f-08de5ce5a082
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 14:17:24.2743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYNMP2vI+HYergOkkEEoCiUoKWWM/OVsqOYtNRQGCyXGQcD20e8u5oIkf/c9fM0AhIkNbJCds+YZHjfg+uQj5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

SGkgWWksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWWkgTGl1IDx5
aS5sLmxpdUBpbnRlbC5jb20+DQo+IFNlbnQ6IDI2IEphbnVhcnkgMjAyNiAxMjowOA0KPiBUbzog
U2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBhcm1A
bm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBlcmljLmF1Z2VyQHJlZGhh
dC5jb207IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dA
bnZpZGlhLmNvbT47IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IGRkdXRpbGVA
cmVkaGF0LmNvbTsNCj4gYmVycmFuZ2VAcmVkaGF0LmNvbTsgY2xnQHJlZGhhdC5jb207IGFsZXhA
c2hhemJvdC5vcmc7IE5hdGhhbiBDaGVuDQo+IDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9j
aHMgPG1vY2hzQG52aWRpYS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5nemhvdTFA
aGlzaWxpY29uLmNvbTsNCj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4uY2FtZXJv
bkBodWF3ZWkuY29tOw0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25nLmR1YW5A
aW50ZWwuY29tOyBLcmlzaG5ha2FudCBKYWp1DQo+IDxramFqdUBudmlkaWEuY29tPjsgTWljaGFl
bCBTIC4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkg
MzQvMzddIGh3L3BjaTogQWRkIGhlbHBlciB0byBpbnNlcnQgUENJZSBleHRlbmRlZA0KPiBjYXBh
YmlsaXR5IGF0IGEgZml4ZWQgb2Zmc2V0DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRp
b24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIDIwMjYvMS8yNiAx
ODo0MywgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBBZGQgcGNpZV9pbnNlcnRfY2FwYWJp
bGl0eSgpLCBhIGhlbHBlciB0byBpbnNlcnQgYSBQQ0llIGV4dGVuZGVkDQo+ID4gY2FwYWJpbGl0
eSBpbnRvIGFuIGV4aXN0aW5nIGV4dGVuZGVkIGNhcGFiaWxpdHkgbGlzdCBhdCBhIGNhbGxlcg0K
PiA+IHNwZWNpZmllZCBvZmZzZXQuDQo+ID4NCj4gPiBVbmxpa2UgcGNpZV9hZGRfY2FwYWJpbGl0
eSgpLCB3aGljaCBhbHdheXMgYXBwZW5kcyBhIGNhcGFiaWxpdHkgdG8gdGhlDQo+ID4gZW5kIG9m
IHRoZSBsaXN0LCB0aGlzIGhlbHBlciBwcmVzZXJ2ZXMgdGhlIGV4aXN0aW5nIGxpc3Qgb3JkZXJp
bmcgd2hpbGUNCj4gPiBhbGxvd2luZyBpbnNlcnRpb24gYXQgYW4gYXJiaXRyYXJ5IG9mZnNldC4N
Cj4gPg0KPiA+IFRoZSBoZWxwZXIgb25seSB2YWxpZGF0ZXMgdGhhdCB0aGUgaW5zZXJ0aW9uIGRv
ZXMgbm90IG92ZXJ3cml0ZSBhbg0KPiA+IGV4aXN0aW5nIFBDSWUgZXh0ZW5kZWQgY2FwYWJpbGl0
eSBoZWFkZXIsIHNpbmNlIGNvcnJ1cHRpbmcgYSBoZWFkZXINCj4gPiB3b3VsZCBicmVhayB0aGUg
ZXh0ZW5kZWQgY2FwYWJpbGl0eSBsaW5rZWQgbGlzdC4gVmFsaWRhdGlvbiBvZiBvdmVybGFwcw0K
PiA+IHdpdGggb3RoZXIgY29uZmlndXJhdGlvbiBzcGFjZSByZWdpc3RlcnMgb3IgY2FwYWJpbGl0
eS1zcGVjaWZpYw0KPiA+IHJlZ2lzdGVyIGJsb2NrcyBpcyBsZWZ0IHRvIHRoZSBjYWxsZXIuDQo+
ID4NCj4gPiBSZXZpZXdlZC1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4N
Cj4gPiBSZXZpZXdlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPiA+
IFRlc3RlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPiA+IFRlc3Rl
ZC1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4NCj4gPiBSZXZpZXdl
ZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29t
Pg0KPiA+IC0tLQ0KPiA+ICAgaHcvcGNpL3BjaWUuYyAgICAgICAgIHwgNjkNCj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgaW5jbHVkZS9ody9wY2kv
cGNpZS5oIHwgIDIgKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgNzEgaW5zZXJ0aW9ucygrKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2llLmMgYi9ody9wY2kvcGNpZS5jDQo+ID4g
aW5kZXggYjMwMmRlNjQxOS4uYWE5MDI0ZTUzMiAxMDA2NDQNCj4gPiAtLS0gYS9ody9wY2kvcGNp
ZS5jDQo+ID4gKysrIGIvaHcvcGNpL3BjaWUuYw0KPiA+IEBAIC0xMDUwLDYgKzEwNTAsNzUgQEAg
c3RhdGljIHZvaWQgcGNpZV9leHRfY2FwX3NldF9uZXh0KFBDSURldmljZQ0KPiAqZGV2LCB1aW50
MTZfdCBwb3MsIHVpbnQxNl90IG5leHQpDQo+ID4gICAgICAgcGNpX3NldF9sb25nKGRldi0+Y29u
ZmlnICsgcG9zLCBoZWFkZXIpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gKy8qDQo+ID4gKyAqIEluc2Vy
dCBhIFBDSWUgZXh0ZW5kZWQgY2FwYWJpbGl0eSBhdCBhIGdpdmVuIG9mZnNldC4NCj4gPiArICoN
Cj4gPiArICogVGhpcyBoZWxwZXIgb25seSB2YWxpZGF0ZXMgdGhhdCB0aGUgaW5zZXJ0aW9uIGRv
ZXMgbm90IG92ZXJ3cml0ZSBhbg0KPiA+ICsgKiBleGlzdGluZyBQQ0llIGV4dGVuZGVkIGNhcGFi
aWxpdHkgaGVhZGVyLCBhcyBjb3JydXB0aW5nIGEgaGVhZGVyIHdvdWxkDQo+ID4gKyAqIGJyZWFr
IHRoZSBleHRlbmRlZCBjYXBhYmlsaXR5IGxpbmtlZCBsaXN0Lg0KPiA+ICsgKg0KPiA+ICsgKiBU
aGUgY2FsbGVyIG11c3QgZW5zdXJlIHRoYXQgKG9mZnNldCwgc2l6ZSkgZG9lcyBub3Qgb3Zlcmxh
cCB3aXRoIG90aGVyDQo+ID4gKyAqIHJlZ2lzdGVycyBvciBjYXBhYmlsaXR5LXNwZWNpZmljIHJl
Z2lzdGVyIGJsb2Nrcy4gT3ZlcmxhcHMgd2l0aA0KPiA+ICsgKiBjYXBhYmlsaXR5LXNwZWNpZmlj
IHJlZ2lzdGVycyBhcmUgbm90IGNoZWNrZWQgYW5kIGFyZSBjb25zaWRlcmVkIGENCj4gPiArICog
dXNlci1jb250cm9sbGVkIG92ZXJyaWRlLg0KPiA+ICsgKg0KPiA+ICsgKiBOb3RlOiBCZXN0IGVm
Zm9ydCBoZWxwZXIuIFRoZSBQQ0llIHNwZWMgZG9lcyBub3QgcmVxdWlyZSBleHRlbmRlZA0KPiA+
ICsgKiBjYXBhYmlsaXRpZXMgdG8gYmUgb3JkZXJlZCwgYnV0IG1vc3QgZGV2aWNlcyB1c2UgYSBm
b3J3YXJkLWxpbmtlZCBsaXN0Lg0KPiA+ICsgKiBEZXZpY2VzIHRoYXQgZG8gbm90IGNvbnNpc3Rl
bnRseSB1c2UgYSBmb3J3YXJkLWxpbmtlZCBsaXN0IG1heSBjYXVzZQ0KPiA+ICsgKiBpbnNlcnRp
b24gdG8gZmFpbC4NCj4gPiArICovDQo+ID4gK2Jvb2wgcGNpZV9pbnNlcnRfY2FwYWJpbGl0eShQ
Q0lEZXZpY2UgKmRldiwgdWludDE2X3QgY2FwX2lkLCB1aW50OF90DQo+IGNhcF92ZXIsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MTZfdCBvZmZzZXQsIHVpbnQxNl90IHNp
emUpDQo+ID4gK3sNCj4gPiArICAgIHVpbnQxNl90IHBvcyA9IFBDSV9DT05GSUdfU1BBQ0VfU0la
RSwgcHJldiA9IDA7DQo+ID4gKyAgICB1aW50MzJfdCBoZWFkZXI7DQo+ID4gKw0KPiA+ICsgICAg
YXNzZXJ0KHBjaV9pc19leHByZXNzKGRldikpOw0KPiA+ICsNCj4gPiArICAgIGlmICghUUVNVV9J
U19BTElHTkVEKG9mZnNldCwgUENJX0VYVF9DQVBfQUxJR04pIHx8DQo+ID4gKyAgICAgICAgc2l6
ZSA8IDggfHwNCj4gPiArICAgICAgICBvZmZzZXQgPCBQQ0lfQ09ORklHX1NQQUNFX1NJWkUgfHwN
Cj4gPiArICAgICAgICBvZmZzZXQgPj0gUENJRV9DT05GSUdfU1BBQ0VfU0laRSB8fA0KPiA+ICsg
ICAgICAgIG9mZnNldCArIHNpemUgPiBQQ0lFX0NPTkZJR19TUEFDRV9TSVpFKSB7DQo+ID4gKyAg
ICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIGhlYWRlciA9
IHBjaV9nZXRfbG9uZyhkZXYtPmNvbmZpZyArIHBvcyk7DQo+ID4gKyAgICBpZiAoIWhlYWRlcikg
ew0KPiA+ICsgICAgICAgIC8qIE5vIGV4dGVuZGVkIGNhcGFiaWxpdHkgcHJlc2VudCwgaW5zZXJ0
aW9uIG11c3QgYmUgYXQgdGhlIEVDQVAgaGVhZA0KPiAqLw0KPiA+ICsgICAgICAgIGlmIChvZmZz
ZXQgIT0gcG9zKSB7DQo+ID4gKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiArICAgICAg
ICB9DQo+ID4gKyAgICAgICAgcGNpX3NldF9sb25nKGRldi0+Y29uZmlnICsgcG9zLCBQQ0lfRVhU
X0NBUChjYXBfaWQsIGNhcF92ZXIsIDApKTsNCj4gPiArICAgICAgICBnb3RvIG91dDsNCj4gPiAr
ICAgIH0NCj4gPiArDQo+ID4gKyAgICB3aGlsZSAoaGVhZGVyICYmIHBvcyAmJiBvZmZzZXQgPj0g
cG9zKSB7DQo+ID4gKyAgICAgICAgdWludDE2X3QgbmV4dCA9IFBDSV9FWFRfQ0FQX05FWFQoaGVh
ZGVyKTsNCj4gPiArDQo+ID4gKyAgICAgICAgLyogUmVqZWN0IGluc2VydGlvbiBpbnNpZGUgYW4g
ZXhpc3RpbmcgRUNBUCBoZWFkZXIgKDQgYnl0ZXMpICovDQo+ID4gKyAgICAgICAgaWYgKG9mZnNl
dCA8IHBvcyArIFBDSV9FWFRfQ0FQX0FMSUdOKSB7DQo+ID4gKyAgICAgICAgICAgIHJldHVybiBm
YWxzZTsNCj4gPiArICAgICAgICB9DQo+IA0KPiBUQkguIEkgd2FzIGV4cGVjdGluZyB0byBzZWUg
YSB0YWJsZSB0aGF0IGlzIHNpbWlsYXIgd2l0aA0KPiBwY2lfZXh0X2NhcF9sZW5ndGhbXVsxXSwg
YW5kIGEgaGVscGVyIHRvIHdhbGsgdGhlIGV4dCBjYXAgbGlzdA0KPiB0byBmaWd1cmUgb3V0IHRo
ZSBzcGFyZWQgcG9zLiBCdXQgaXQgbWlnaHQgYmUgb3Zlci1lbmdpbmVyaW5nIGFzDQo+IHdlIHJl
bHkgbW9yZSBvbiB1c2VyIHRvIGdpdmUgYW4gb2Zmc2V0IHRoYXQgaXMgZm9yIHN1cmUgbm8gY29u
ZmxpY3QNCj4gd2l0aCBleGlzdGluZyBlY2FwcyBub3IgaGlkZGVuIHJlZ2lzdGVycy4gQ291bGQg
eW91IGFsc28gYWRkIGEgY29tbWVudA0KPiBpbiB0aGUgY29kZSB0byBub3RlIGl0Pw0KPiANCj4g
WzFdDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iLzYzODA0ZmVkMTQ5
YTY3NTBmZmQyODYxMGM1YzFjOQ0KPiA4Y2NlNmJkMzc3L2RyaXZlcnMvdmZpby9wY2kvdmZpb19w
Y2lfY29uZmlnLmMjTDcxDQo+IA0KPiBXaXRoIHRoZSBhYm92ZSBuaXQsIExHVE0uDQo+IA0KPiBS
ZXZpZXdlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQoNClRoYW5rcy4NCg0KWWVz
LCB0aGUgaGVscGVyIGRlcGVuZHMgb24gdGhlIGNhbGxlciB0byBwcm92aWRlIGEgc3VpdGFibGUg
b2Zmc2V0LCBzaW5jZQ0KaXQncyBub3QgZ2VuZXJhbGx5IHBvc3NpYmxlIHRvIHZhbGlkYXRlIHRo
aXMgZHVlIHRvIGhpZGRlbiByZWdpc3RlcnMgYW5kDQpkZXZpY2Ugc3BlY2lmaWMgY2FwYWJpbGl0
eSBsYXlvdXRzLCBhbmQgdGhpcyBpcyBhbHJlYWR5IG5vdGVkIGluIHRoZSBjb21taXQNCmxvZyBh
bmQgZnVuY3Rpb24gY29tbWVudC4NCg0KSWYgeW91IGhhZCBhIHNwZWNpZmljIHdvcmRpbmcgaW4g
bWluZCB0aGF0IHdvdWxkIG1ha2UgdGhpcyBjbGVhcmVyLCBwbGVhc2UNCmxldCBtZSBrbm93IGFu
ZCBJIGNhbiBpbmNvcnBvcmF0ZSBpdCBpZiB0aGlzIHJlcXVpcmVzIGEgcmVzcGluLg0KDQpTaGFt
ZWVyDQogDQo=

