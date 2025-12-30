Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4DCE95A79
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 12:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaYke-0008JN-3S; Tue, 30 Dec 2025 07:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vaYkc-0008Gs-CP; Tue, 30 Dec 2025 07:22:58 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vaYka-0003xw-DI; Tue, 30 Dec 2025 07:22:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwoU/5NjatvtWGCxe8akdyxVps4vN92/s7hJxRCbghuMUjNW/K4FT/QEgKZMbf5k+j/trncqqE3/PLPNSn/5RuU69hRixuIxQweT/jPBPdHs0V7dUW3vFhyzhowRppa59VmmA9EV/FfcYbPKupuZllpTdtPVGvJcAAECED5N7KHJGhRXCRRpEBudbhHyqtb51XadubVP5bLZ9WhH01zH1sVrMqp7ix/x7tCyVlzMRooN+LZdwxhDTfx5kiFlxg73Rs3B4LG1exaHrJsoQ6+5z67cWxvzqDzVjpGH5r0xknLPwIiFho+QuccOOYBILROMl3es7UtDMrFB0Gq7OSUsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kV3QqnP6efSbLzFpwiAo9VSVqV92cON2yLiSvBEEZsM=;
 b=Cn1wyGc0MJ0w7a/EH4bKL89/v5Dd5XQ684xh7FUtYiSd4QipuZ4BjxpbZrtqikPKw2VoyGwCDl163n524mIfACENaIwXmdnXLXmxDiOo1YD3xWNdR5mewEGGsWhuYBOAh5vEu3ctF0kOCV8k6Vt/RJrSeyPk6nVH5jpvlWAI+rd0NO994KO/lpxvWfViBs/4jtW9mB6FsPJd1uBzagizW7+UlZWyooplhRUvEkusx3lJuRfMRwpXP5NW9pWu3BC+nwPGZHMAFggTDVzf/Wh/82bIPEJx+5sGvVXW6CRBzO4Mlz32Y2Zvh+5kBXMCV4a/ZsASZub6XcbggmQzwQBouw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kV3QqnP6efSbLzFpwiAo9VSVqV92cON2yLiSvBEEZsM=;
 b=WA+LvrG84LOmJ0isMh22crYbXxwYpPTIwb52vZh3Qoqimm9NUFOeFvmfCCcbH7SlKBej1OMEuwPpI7/Cw3xhrSkn6/O8uL365/6lVd0IG9kiiS0Gu1X59SzG/NaHtMMU3xsTerWy31Xlfw5HBgJDbzO/lTBVWoKX6r4FK/aGCuce+J3PcLoelcz8+9ha+uFEMAxyNjMo8KbSF3Zdu0yQNC0wxjWn2YNdkaFGLcQT/gxRATrRyIr8yTIH3Kk8TGlGqJrO9f2bvPoWyshA27KtBfe8nxKt3fhRWbO0KNuUxiAlqOcBfQDlfZt8Q0lsf5hZTRF3FRudfQctw2lN1gqNUA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 30 Dec
 2025 12:22:50 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 12:22:49 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v6 17/33] hw/arm/smmuv3: Add support for providing a
 direct MSI doorbell GPA
Thread-Topic: [PATCH v6 17/33] hw/arm/smmuv3: Add support for providing a
 direct MSI doorbell GPA
Thread-Index: AQHcWiEf+PaTPr3V30uUQF2zh8a+rrUcmaGAgB2+qCA=
Date: Tue, 30 Dec 2025 12:22:49 +0000
Message-ID: <CH3PR12MB7548B912419014985D455EB0ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-18-skolothumtho@nvidia.com>
 <52dc1984-da99-47bc-87f4-cc29cbe6b749@redhat.com>
In-Reply-To: <52dc1984-da99-47bc-87f4-cc29cbe6b749@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MN0PR12MB5740:EE_
x-ms-office365-filtering-correlation-id: 287adcb7-54b5-4375-7500-08de479e25dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Z2NBTGhLaDk5UmJlanJFeGFoZjNYTEV6cGFKajhZdUQycEE1Z0VvUDc1aG94?=
 =?utf-8?B?RU1sTUkvNEk1TzExMDdDMUkzdGEyZmp6T0VqU2pCTzkrVkhNWEkzYWhwbHdm?=
 =?utf-8?B?ZzNkRnBCRUVPYmsyeWhUS3BsOFNZMWlhK1ZIa0JQbi9mVzlVTXBKbDlnMy9N?=
 =?utf-8?B?TGM1TkxRQmJJZ0RVSlUzYUZ6UmttcWpUZklSbXlQZ1lsSGpuTnNoVEFxVm9w?=
 =?utf-8?B?ZGpuVlRIaXM0b21PVzBXd0ZIR0J0VTBVVGNyZ0NEMGVoTVVaSXhsdzBESU5j?=
 =?utf-8?B?OXdRNjhJOTJMVkRJTnRmU25qc29tNXpnMHVmazFaUzhZL2FkUG0zTkh0QUkw?=
 =?utf-8?B?WGhSOS9QamxndjBKTWZlWVhYZk9PVU9Fa2tnc0RDWnlPV1p3eFM1ZXhORzBG?=
 =?utf-8?B?SGwwTXU5RDMxelZKajFrZWIrVVREaUU4c3A0Y04zQWczdEI2YVFiOStBVmRC?=
 =?utf-8?B?VXA0cXJKU0NtcWVyUDBmV29tU2VOMHh5c0NIWTdNc0FNY256aFluSUxUQi9u?=
 =?utf-8?B?ZnZPYmowRTI3bXFSUzc4OGJ1dmk5Q3JwcVJUQVRLNUM2b1EraStyQ2lkMnkr?=
 =?utf-8?B?alNDTWR4RDA4YldjNXhEUWJPcnM3LytyYXUrL0FabDRYRzRlNGFGZ0h2aUo2?=
 =?utf-8?B?NU5OTmprUVJGZWRXZmJnRWJXL2pxQklRSHBzbFJhbzFQT21MTjB2M2VDMGdW?=
 =?utf-8?B?L1RZb0Q5Nld4VytOVGE3d21kRUxyanFXY3BJS0Y3L2ErUS9WR083T0lvR3VB?=
 =?utf-8?B?RHpqZTgvb0RXUzZQK1Y5SzJlajdOYmthNS9rd0Z2ZmlDK3o0MzhkU25rcGpQ?=
 =?utf-8?B?UEN2MmRLOWFiYVhxdDk4R2h5MWxRc2ttaXMwNDViZGQyM0JyL1dmU3h5cjdN?=
 =?utf-8?B?NVZpU2hDYzhGUDJKb3BLWThqZG94TlQ5bFZqZStMZmJDNmR4Qms5TDFuYUhQ?=
 =?utf-8?B?NVF6UGNCcUdldE51K0dqeHIraTRFaXlPalBJYkxxZlV2Qll1amppNE5QUHRy?=
 =?utf-8?B?VUtIcnZhaC8vM1hRSnA2UE0vV1ZxYUt0akFlUnRKMlMyb3RObjFMUEVxWU44?=
 =?utf-8?B?RVQ4elcrNWdLN0NueXdsT1JBTkdVZUtiY1lkd21pSFkrZG9mRHc4QTBObGVp?=
 =?utf-8?B?bHBDbVlJQ3l2T1hTWDZTSTRZR1gvT3NwRlZ2Ky9DWWFETzNWUVFzcHdzbURt?=
 =?utf-8?B?WXRMeUVaR1FTQUNoZVd2VGxEWDZuMmlpcld1V0Izcjl4V3JuWm5QWXZtVEo5?=
 =?utf-8?B?Y2hRSHg1Y2xsRUY5R2s0cVJiTnJBcGM0cXhnTlZnN3M2M0JwbXJldEZLS1hJ?=
 =?utf-8?B?U2g1eHZXT0s4MjIxWnBGSW93c1ZySGNnT2Y1YWtSQm9UTE9qTFVQQjRrQk56?=
 =?utf-8?B?bnZ0dWhkUm15R1dSdW9HSUc0eUxGL3BVKzJCKy9iNzdqb216R3YvdzBwWXNv?=
 =?utf-8?B?b1pabSthNnV2bnFVTTlYWERkSUxsYTJwdnZhci9zbXJNSFJlNTUway9MamNL?=
 =?utf-8?B?NWhDSElnZFpJTnQzenJoRUxUUGh3dTBFalZJSWN2aXlLVXRiUlAzN0pUMlBX?=
 =?utf-8?B?cjlCWTZHWmE1anFQYmpSdm5sdzVDblFNZ0hXajZjRGJ1WXVWUVViYTVQQ1Zj?=
 =?utf-8?B?N1VjN21zczU5T1lnWE8yU21sdjhCQ2hBclFyclFWa0k5OUlYMEo1YnlYSEtU?=
 =?utf-8?B?aTEwSGRQMDB2ay9HdXRlZUViZVZuempRakZuWVdHQ3dienhXcFBDWWh1a01p?=
 =?utf-8?B?UWpzN1QxTzZxcnI1TzZWalhiaU5wZVBCcDgralNoeWtOU1VXbjlqMzRsMmpZ?=
 =?utf-8?B?dFBIUWpYN0dZQStJUGxic3ZJWkI0c2FoQ2tJK0dOczdoTzJxL3JDSG1MaElD?=
 =?utf-8?B?V29sZUJObFRlRW1EcTZPb1JiNkVUYkxleXJhenNRa1Vwa0hRZE1UTENEaVVR?=
 =?utf-8?B?VmhFTzUrODBheG1rS1NpSUUydXZYNkRiTi9mS1E5djhyR2loR0hJRGZNYWVZ?=
 =?utf-8?B?ZkpKd0RaaTdCeEljY1JXVk1FVTBkZXcyVEFxRG5TbCtvRjhMSzZMdS9PbTJv?=
 =?utf-8?Q?o7iSbj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R09GR0dkVkJsT2ZqVnl0OTdjV21Ddk00TWZMMC95cmJKWTNIT1FYTHpWTjV6?=
 =?utf-8?B?S3IwWXVqSXhHRWk2TDFrVzJnMWQ1TzZrRHpoY2FMSDVrdW9YVysxSjU4THhW?=
 =?utf-8?B?VW1pWklNTUlQMFZTejc3ODB4Wm5zeFhvb2U5bWQrdElqTTlmRytic0M5Z2xB?=
 =?utf-8?B?L0w4Z3dYaTNUWTRaZm9IYjZEdG56L0F4djgrcHRKbms1NWkrUkRzREpxWkRj?=
 =?utf-8?B?emR3VFQ4K1V2MnR4Z1A3cnYvNmU4NE1kazE3WTZ4bDNublFqNHBzamJmV25j?=
 =?utf-8?B?YUx3Q0tYd0VwNU5iL2pSNXkza2Iydlo1eEk5aFg2T2ZNWFFsWGNLU2J0V0lz?=
 =?utf-8?B?YkI1UVJOTXNIem45dVRPa2pHcDZHL3lGUnk4OHpadnc2UXp1dFRLNzF2aUFI?=
 =?utf-8?B?YmlpL0ZKN3pPajdUS21Jb09RYmFFOGRWYkxBQnYyUFkxaCtraE1ZSUZ3dzcw?=
 =?utf-8?B?SGcxQVFEdHpRK2daQitzYVhDTXFkNEptZ3YyV2lYR3cwZks3SndvalhXWE5y?=
 =?utf-8?B?Qm5QRHNmR2xhQjZqQU9nNzZaMGU2dFcxRTB2ZkZGcGhLMmptSFNQZzZLSXk3?=
 =?utf-8?B?aUF0L01qcDlnUXJaQ29RVUt6ZzhiUTJTb0NLOFNmUUxUUEFCNWY0bDJVRXJq?=
 =?utf-8?B?blR1Z29UN0d1MkhWZGZNcjBFb0ZZQU8rZGdQaXk1SWRsZnJqb0w2TUo2SUQw?=
 =?utf-8?B?WWdxczVaT1ZMYlVrMmEwek93eUkveGlrSE5BbFdPclRqN1F6akM1Y0txenM1?=
 =?utf-8?B?RW5PdWpjK0NwNmlzczJmM0JDMGJFemlRTkp2S1lIdjBZN21Uc1NINHoyUWFu?=
 =?utf-8?B?UnRBK0tmUFVob2JkWDR4SmE3emFWSEYveXFkRHRzMGZDS0VwOFphck1FVDhF?=
 =?utf-8?B?RkE5YlJ1RjExaC9RZ3hoUTUwTzQxWCtSVnVhZ1dZRXBPcEhYMVhzZmVJTTFY?=
 =?utf-8?B?YUY4TXNQNHFtei9HaHBpYjlBbTI5MnY1SGdoTzExak4zQlpQZFBtNzJGOGp0?=
 =?utf-8?B?dldlT2xPQ3gwSTJNSW9rZkJuWHh0Z0VhOGVMbEFlWTg4VWtwYmhHaGZSWE94?=
 =?utf-8?B?VkZjUDNJdXVCYmliOWdLT3MyNHhUOXlBdmhNaVJlSVhNOWd6eHZmcXAzdm9q?=
 =?utf-8?B?akFJL3NpTHZiVm1ZYzdHRDlmekthemdseU1zckV5d0oxTTluaXhTNzJSZDJD?=
 =?utf-8?B?S3RWb2VjWXBmNDRSVGZxaTQ1RjcrR2RIVEJ1UG5NRmgxTTlHN25XQUdGZnZo?=
 =?utf-8?B?aklLNlZKV1RIdEFURXVpdnluaUd1TUM5YkpMODNrTkE3eThvTllaTVZtUzdh?=
 =?utf-8?B?bHBIMEk4K0V6RmxpR2ZSUE01QUkxT0RrM1ZHWU9xbklJM002Z2lwNU9sbUlN?=
 =?utf-8?B?OEZrVVIzMmhrdkxsbXVhVTkyWmgreklJWnpOV21ZUStlcndESUo1Z2RjMUJI?=
 =?utf-8?B?NDRFM1VFdWE0YTc2bXpJblBRSEVRV2orZFNQcklKSHV5OUltZmRrVG1tMnI1?=
 =?utf-8?B?TnRmVG5ZUHQ1Rm82eS9QZFR0OThGUVIzcjQwbTBOaFg4dFpmMlNPN2hFQ2hI?=
 =?utf-8?B?OHpRR1FPbU1JWWF2M3FJMW4za1VEVjRYUmwxa1ZCVFBVMFQ2WHF2NGxoV1Nv?=
 =?utf-8?B?b2xtZGkyVjNxT0xVODBmaEtqb3U1TDZDQ0s0T3VGZVFTVjdta1RIZkZ5NGhB?=
 =?utf-8?B?bEc3SFZ5VDAxNDZZZFRmTDFiUG85cElkSzFna1htL01EOHJFaXE5ODZacUlJ?=
 =?utf-8?B?UlU3MmU3enA0WlBwczJKN2JjQ0k5cVpkaVIweDFKNk5lNktkL0E1NEtQR092?=
 =?utf-8?B?RlFBODQ0bjg0ZnVxc3RxcE1rc0paR2hCRDVmOWtodDNMMDVsMlp5T2djQmlQ?=
 =?utf-8?B?QUNyYThkL2FWaVV5dkxxcmdMZWdmeDdySlNFaHdjaVZlbTFucUFXRGYyTms0?=
 =?utf-8?B?Wm5CdW0yWmFWdXBBWmNNbUVnWmJuOXE0M1RlVFN6WWJqQ3NiaGVyYUhscWxs?=
 =?utf-8?B?dG5mVEFRNnFwQnJ0WmhreVNCQ1BYUGp1Ukw4d3RudDFDcDFBTWxrT1NzbVJX?=
 =?utf-8?B?anRQMUxZbTB4dGZJQkliV2tob0RmbGgxY1JqOHM0NkEyZWcvRm5nRFJXL1ox?=
 =?utf-8?B?UG13dTJucjVZMmJzbnU4WThmak9tOXFrcExTc01lZWJkTDdIQXJxUEZSZ0dV?=
 =?utf-8?B?Z1FPTm1SMGVENU40U2hKUURPeVhzWFhrcWVTdkNQQTEyUk9NKzdqdHVYRGNr?=
 =?utf-8?B?djZkTHRmZzhQTlg5d0FyeGg0OXl1VE00Unc1cGFueUdWa09UUllUcHJwNVF0?=
 =?utf-8?B?WUM5RnJGQ3dRTnkyQys1eGdJZU9NRnVmZ3E3cWNiK3krUFhmeWE4QT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287adcb7-54b5-4375-7500-08de479e25dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 12:22:49.8366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p8kHgpzQtyjqnx45g9yhZtBnckkRaBga2QrPWyvndifrpvXfFef+WX1l63MZvSecGbkqPWY+I0BHYZS+Zd3cYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTZW50OiAxMSBEZWNlbWJlciAyMDI1IDE0OjA0DQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+IGFy
bUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IGVyaWMuYXVnZXJAcmVk
aGF0LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBHdW50aG9ycGUNCj4gPGpn
Z0BudmlkaWEuY29tPjsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgZGR1dGls
ZUByZWRoYXQuY29tOw0KPiBiZXJyYW5nZUByZWRoYXQuY29tOyBOYXRoYW4gQ2hlbiA8bmF0aGFu
Y0BudmlkaWEuY29tPjsgTWF0dCBPY2hzDQo+IDxtb2Noc0BudmlkaWEuY29tPjsgc21vc3RhZmFA
Z29vZ2xlLmNvbTsgd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207DQo+IGppYW5na3Vua3VuQGh1YXdl
aS5jb207IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFy
by5vcmc7IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsgeWkubC5saXVAaW50ZWwuY29tOw0KPiBL
cmlzaG5ha2FudCBKYWp1IDxramFqdUBudmlkaWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY2IDE3LzMzXSBody9hcm0vc21tdXYzOiBBZGQgc3VwcG9ydCBmb3IgcHJvdmlkaW5nIGENCj4g
ZGlyZWN0IE1TSSBkb29yYmVsbCBHUEENCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlv
biBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gMTEvMjAvMjUgMTQ6
MjEsIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gQWNjZWxlcmF0ZWQgU01NVXYzIGluc3Rh
bmNlcyByZWx5IG9uIHRoZSBwaHlzaWNhbCBTTU1VdjMgZm9yIG5lc3RlZA0KPiA+IHRyYW5zbGF0
aW9uIChHdWVzdCBTdGFnZS0xLCBIb3N0IFN0YWdlLTIpLiBJbiB0aGlzIG1vZGUgdGhlIGd1ZXN0
4oCZcw0KPiA+IFN0YWdlLTEgdGFibGVzIGFyZSBwcm9ncmFtbWVkIGRpcmVjdGx5IGludG8gaGFy
ZHdhcmUsIGFuZCBRRU1VIHNob3VsZA0KPiA+IG5vdCBhdHRlbXB0IHRvIHdhbGsgdGhlbSBmb3Ig
dHJhbnNsYXRpb24gc2luY2UgZG9pbmcgc28gaXMgbm90IHJlbGlhYmx5DQo+ID4gc2FmZS4gRm9y
IHZmaW8tcGNpIGVuZHBvaW50cyBiZWhpbmQgc3VjaCBhIHZTTU1VLCB0aGUgb25seSB0cmFuc2xh
dGlvbg0KPiA+IFFFTVUgaXMgcmVzcG9uc2libGUgZm9yIGlzIHRoZSBNU0kgZG9vcmJlbGwgdXNl
ZCBkdXJpbmcgS1ZNIE1TSSBzZXR1cC4NCj4gPg0KPiA+IEFkZCBhIGRldmljZSBwcm9wZXJ0eSB0
byBjYXJyeSB0aGUgTVNJIGRvb3JiZWxsIEdQQSBmcm9tIHRoZSB2aXJ0DQo+ID4gbWFjaGluZSwg
YW5kIGV4cG9zZSBpdCB0aHJvdWdoIGEgbmV3IGdldF9tc2lfZGlyZWN0X2dwYSBQQ0lJT01NVU9w
Lg0KPiA+IGt2bV9hcmNoX2ZpeHVwX21zaV9yb3V0ZSgpIGNhbiB0aGVuIHVzZSB0aGlzIEdQQSBk
aXJlY3RseSBpbnN0ZWFkIG9mDQo+ID4gYXR0ZW1wdGluZyBhIHNvZnR3YXJlIHdhbGsgb2YgZ3Vl
c3QgdHJhbnNsYXRpb24gdGFibGVzLg0KPiA+DQo+ID4gVGhpcyBlbmFibGVzIGNvcnJlY3QgTVNJ
IHJvdXRpbmcgd2l0aCBhY2NlbGVyYXRlZCBTTU1VdjMgd2hpbGUgYXZvaWRpbmcNCj4gPiB1bnNh
ZmUgYWNjZXNzZXMgdG8gcGFnZSB0YWJsZXMuDQo+ID4NCj4gPiBGb3IgbWVhbmluZ2Z1bCB1c2Ug
b2YgdmZpby1wY2kgZGV2aWNlcyB3aXRoIGFjY2VsZXJhdGVkIFNNTVV2MywgYm90aCBLVk0NCj4g
PiBhbmQgYSBrZXJuZWwgaXJxY2hpcCBhcmUgcmVxdWlyZWQuIEVuZm9yY2UgdGhpcyByZXF1aXJl
bWVudCB3aGVuIGFjY2VsPW9uDQo+ID4gaXMgc2VsZWN0ZWQuDQo+IA0KPiBUaGVyZSBhcmUgbXVs
dGlwbGUgY2hhbmdlcyBpbiBvbmUgcGF0Y2guIEkgc3VnZ2VzdCBzcGxpdHRpbmcuDQoNCk9rLg0K
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9A
bnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGh3L2FybS9zbW11djMtYWNjZWwuYyAgIHwgMTAg
KysrKysrKysrKw0KPiA+ICAgaHcvYXJtL3NtbXV2My5jICAgICAgICAgfCAgMiArKw0KPiA+ICAg
aHcvYXJtL3ZpcnQuYyAgICAgICAgICAgfCAyMiArKysrKysrKysrKysrKysrKysrKysrDQo+ID4g
ICBpbmNsdWRlL2h3L2FybS9zbW11djMuaCB8ICAxICsNCj4gPiAgIDQgZmlsZXMgY2hhbmdlZCwg
MzUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9zbW11djMtYWNj
ZWwuYyBiL2h3L2FybS9zbW11djMtYWNjZWwuYw0KPiA+IGluZGV4IDY1YjU3N2Y0OWEuLjhmN2Mw
Y2RhMDUgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3NtbXV2My1hY2NlbC5jDQo+ID4gKysrIGIv
aHcvYXJtL3NtbXV2My1hY2NlbC5jDQo+ID4gQEAgLTM5Miw2ICszOTIsMTUgQEAgc3RhdGljIHZv
aWQNCj4gc21tdXYzX2FjY2VsX3Vuc2V0X2lvbW11X2RldmljZShQQ0lCdXMgKmJ1cywgdm9pZCAq
b3BhcXVlLA0KPiA+ICAgICAgIH0NCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgdWludDY0X3Qg
c21tdXYzX2FjY2VsX2dldF9tc2lfZ3BhKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludA0K
PiBkZXZmbikNCj4gPiArew0KPiA+ICsgICAgU01NVVN0YXRlICpicyA9IG9wYXF1ZTsNCj4gPiAr
ICAgIFNNTVV2M1N0YXRlICpzID0gQVJNX1NNTVVWMyhicyk7DQo+ID4gKw0KPiA+ICsgICAgZ19h
c3NlcnQocy0+bXNpX2dwYSk7DQo+ID4gKyAgICByZXR1cm4gcy0+bXNpX2dwYTsNCj4gPiArfQ0K
PiA+ICsNCj4gPiAgIC8qDQo+ID4gICAgKiBPbmx5IGFsbG93IFBDSWUgYnJpZGdlcywgcHhiLXBj
aWUgcm9vdHMsIGFuZCBHUEVYIHJvb3RzIHNvIHZmaW8tcGNpDQo+ID4gICAgKiBlbmRwb2ludHMg
Y2FuIHNpdCBkb3duc3RyZWFtLiBBY2NlbGVyYXRlZCBTTU1VdjMgcmVxdWlyZXMgYSB2ZmlvLXBj
aQ0KPiA+IEBAIC00OTYsNiArNTA1LDcgQEAgc3RhdGljIGNvbnN0IFBDSUlPTU1VT3BzIHNtbXV2
M19hY2NlbF9vcHMgPSB7DQo+ID4gICAgICAgLmdldF92aW9tbXVfZmxhZ3MgPSBzbW11djNfYWNj
ZWxfZ2V0X3Zpb21tdV9mbGFncywNCj4gPiAgICAgICAuc2V0X2lvbW11X2RldmljZSA9IHNtbXV2
M19hY2NlbF9zZXRfaW9tbXVfZGV2aWNlLA0KPiA+ICAgICAgIC51bnNldF9pb21tdV9kZXZpY2Ug
PSBzbW11djNfYWNjZWxfdW5zZXRfaW9tbXVfZGV2aWNlLA0KPiA+ICsgICAgLmdldF9tc2lfZGly
ZWN0X2dwYSA9IHNtbXV2M19hY2NlbF9nZXRfbXNpX2dwYSwNCj4gPiAgIH07DQo+ID4NCj4gPiAg
IC8qIEJhc2VkIG9uIFNNVVV2MyBHUEJBLkFCT1JUIGNvbmZpZ3VyYXRpb24sIGF0dGFjaCBhIGNv
cnJlc3BvbmRpbmcNCj4gSFdQVCAqLw0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vc21tdXYzLmMg
Yi9ody9hcm0vc21tdXYzLmMNCj4gPiBpbmRleCA0MmM2MGIxZWM4Li5mMDJlM2VlNDZjIDEwMDY0
NA0KPiA+IC0tLSBhL2h3L2FybS9zbW11djMuYw0KPiA+ICsrKyBiL2h3L2FybS9zbW11djMuYw0K
PiA+IEBAIC0xOTk4LDYgKzE5OTgsOCBAQCBzdGF0aWMgY29uc3QgUHJvcGVydHkgc21tdXYzX3By
b3BlcnRpZXNbXSA9IHsNCj4gPiAgICAgICAgKiBEZWZhdWx0cyB0byBzdGFnZSAxDQo+ID4gICAg
ICAgICovDQo+ID4gICAgICAgREVGSU5FX1BST1BfU1RSSU5HKCJzdGFnZSIsIFNNTVV2M1N0YXRl
LCBzdGFnZSksDQo+ID4gKyAgICAvKiBHUEEgb2YgTVNJIGRvb3JiZWxsLCBmb3IgU01NVXYzIGFj
Y2VsIHVzZS4gKi8NCj4gPiArICAgIERFRklORV9QUk9QX1VJTlQ2NCgibXNpLWdwYSIsIFNNTVV2
M1N0YXRlLCBtc2lfZ3BhLCAwKSwNCj4gPiAgIH07DQo+ID4NCj4gPiAgIHN0YXRpYyB2b2lkIHNt
bXV2M19pbnN0YW5jZV9pbml0KE9iamVjdCAqb2JqKQ0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0v
dmlydC5jIGIvaHcvYXJtL3ZpcnQuYw0KPiA+IGluZGV4IDI1ZmIyYmFiNTYuLmVhMzIzMTU0M2Eg
MTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3ZpcnQuYw0KPiA+ICsrKyBiL2h3L2FybS92aXJ0LmMN
Cj4gPiBAQCAtMzA1Miw2ICszMDUyLDE0IEBAIHN0YXRpYyB2b2lkDQo+IHZpcnRfbWFjaGluZV9k
ZXZpY2VfcHJlX3BsdWdfY2IoSG90cGx1Z0hhbmRsZXIgKmhvdHBsdWdfZGV2LA0KPiA+ICAgICAg
ICAgICAgICAgLyogVGhlIG5ldyBTTU1VdjMgZGV2aWNlIGlzIHNwZWNpZmljIHRvIHRoZSBQQ0kg
YnVzICovDQo+ID4gICAgICAgICAgICAgICBvYmplY3RfcHJvcGVydHlfc2V0X2Jvb2woT0JKRUNU
KGRldiksICJzbW11X3Blcl9idXMiLCB0cnVlLA0KPiBOVUxMKTsNCj4gPiAgICAgICAgICAgfQ0K
PiA+ICsgICAgICAgIGlmIChvYmplY3RfcHJvcGVydHlfZmluZChPQkpFQ1QoZGV2KSwgImFjY2Vs
IikgJiYNCj4gPiArICAgICAgICAgICAgb2JqZWN0X3Byb3BlcnR5X2dldF9ib29sKE9CSkVDVChk
ZXYpLCAiYWNjZWwiLCAmZXJyb3JfYWJvcnQpKSB7DQo+ID4gKyAgICAgICAgICAgIGlmICgha3Zt
X2VuYWJsZWQoKSB8fCAha3ZtX2lycWNoaXBfaW5fa2VybmVsKCkpIHsNCj4gPiArICAgICAgICAg
ICAgICAgIGVycm9yX3NldGcoZXJycCwgIlNNTVV2MyBhY2NlbD1vbiByZXF1aXJlcyBLVk0gd2l0
aCAiDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICJrZXJuZWwtaXJxY2hpcD1vbiBz
dXBwb3J0Iik7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiANCj4gQ291bGRu
J3QgdGhlc2UgY2hlY2tzIGJlIGRvbmUgaW4gdGhlICJzbW11djMtYWNjZWwiIG1vZGVsIHJlYWxp
emUNCj4gaGFuZGxlciBpbnN0ZWFkID8NCg0KQ291bGQgZG8gSSBndWVzcy4gSSBwbGFjZWQgaXQg
aGVyZSB0aGlua2luZyBwcmVfcGx1ZyBpcyBiZWZvcmUgcmVhbGl6ZSgpLA0KYWxsb3dpbmcgYW4g
ZWFybHkgZXhpdC4gQnV0IHByb2JhYmx5IHJlYWxpemUgaXMgYmV0dGVyIGFzIHRoYXQgd2lsbCBj
b3Zlcg0KYWxsIGZ1dHVyZSBtYWNoaW5lIHR5cGVzIGFzIHdlbGwoaWYgYW55KS4NCiANCj4gDQo+
ID4gKyAgICAgICAgICAgIH0NCj4gPiArICAgICAgICB9DQo+ID4gICAgICAgfQ0KPiA+ICAgfQ0K
PiA+DQo+ID4gQEAgLTMwODgsNiArMzA5NiwyMCBAQCBzdGF0aWMgdm9pZA0KPiB2aXJ0X21hY2hp
bmVfZGV2aWNlX3BsdWdfY2IoSG90cGx1Z0hhbmRsZXIgKmhvdHBsdWdfZGV2LA0KPiA+ICAgICAg
ICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICAgICAgICBjcmVhdGVfc21tdXYzX2Rldl9kdGIo
dm1zLCBkZXYsIGJ1cyk7DQo+ID4gKyAgICAgICAgICAgIGlmIChvYmplY3RfcHJvcGVydHlfZmlu
ZChPQkpFQ1QoZGV2KSwgImFjY2VsIikgJiYNCj4gPiArICAgICAgICAgICAgICAgIG9iamVjdF9w
cm9wZXJ0eV9nZXRfYm9vbChPQkpFQ1QoZGV2KSwgImFjY2VsIiwgJmVycm9yX2Fib3J0KSkgew0K
PiA+ICsgICAgICAgICAgICAgICAgaHdhZGRyIGRiX3N0YXJ0Ow0KPiA+ICsNCj4gPiArICAgICAg
ICAgICAgICAgIGlmICh2bXMtPm1zaV9jb250cm9sbGVyID09IFZJUlRfTVNJX0NUUkxfSVRTKSB7
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgLyogR0lUU19UUkFOU0xBVEVSIHBhZ2UgKyBvZmZz
ZXQgKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICBkYl9zdGFydCA9IGJhc2VfbWVtbWFwW1ZJ
UlRfR0lDX0lUU10uYmFzZSArIDB4MTAwMDAgKw0KPiAweDQwOw0KPiA+ICsgICAgICAgICAgICAg
ICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAvKiBNU0lfU0VUU1BJX05TIHBh
Z2UgKyBvZmZzZXQgKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICBkYl9zdGFydCA9IGJhc2Vf
bWVtbWFwW1ZJUlRfR0lDX1YyTV0uYmFzZSArIDB4NDA7DQo+ID4gKyAgICAgICAgICAgICAgICB9
DQo+ID4gKyAgICAgICAgICAgICAgICBvYmplY3RfcHJvcGVydHlfc2V0X3VpbnQoT0JKRUNUKGRl
diksICJtc2ktZ3BhIiwgZGJfc3RhcnQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgJmVycm9yX2Fib3J0KTsNCj4gDQo+IElJUkMsIHRoaXMgcGx1ZyBoYW5k
bGVyIGlzIGNhbGxlZCBhZnRlciB0aGUgZGV2aWNlIHJlYWxpemUgaGFuZGxlcg0KPiBhbmQgc2V0
dGluZyBwcm9wZXJ0aWVzIGFmdGVyIHJlYWxpemUgaXMgc3Ryb25nbHkgZGlzY291cmFnZWQuDQoN
Ckxvb2tpbmcgYXQgdGhpcyBhZ2FpbiwgSSB0aGluayB0aGlzIGNhbiBiZSBtb3ZlZCB0byBwcmVf
cGx1ZyBoYW5kbGVyLg0KDQpUaGFua3MsDQpTaGFtZWVyDQo=

