Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01C606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=V4F4AajF;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=EpELIfae
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP6iE-0005wv-If; Thu, 05 Nov 2026 18:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7622369f3=Alistair.Francis@wdc.com>)
 id 1xP6i7-0005wI-DT; Thu, 05 Nov 2026 18:17:36 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7622369f3=Alistair.Francis@wdc.com>)
 id 1xP6i5-0006C9-DU; Thu, 05 Nov 2026 18:17:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793920653; x=1825456653;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=S4SztWZLVaRsi7iJd2FBvZ0HtUGKm0qwlaHAQ4ERQm0=;
 b=V4F4AajFDQlwkdTg+EHIj1KGhcwikjdZFxrQ9YTB1fZSvycXmOhPHflQ
 ZUXKWdJhlMv3EQfclJV14hUzlDKKi4/8kr1KPqFaX51iSTEnstq942z+A
 1BmPWmyfIsTfmMURhrVSf4YaqBdA5eOZJaqjxCfaOR3QJ9qkZPvJ7H1D4
 r4+14/Y3BeY/v5XPkld5Gux86rWiA0/8sqbAJt3IB5T6zxNtu9szFkz7H
 xU+fttrjQ97wkEdjLG1Bg04AplQRgHB9pGgshvVVASoSgBI5sgVHbbKc0
 Yz33dENt+hvcykWw++ScaGX5RorP9pc4HP16UklX9KQIsif0I8aYSOx4Z w==;
X-CSE-ConnectionGUID: w/YCTWqTQROXZmtDnnZMkw==
X-CSE-MsgGUID: C3cpMeDJTHOB1AzHBVJa9g==
X-IronPort-AV: E=Sophos;i="6.27,197,1786982400"; d="scan'208";a="159949219"
Received: from mail-southcentralusazon11012014.outbound.protection.outlook.com
 (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.14])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 Nov 2026 07:17:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujKrKqMWAsIMIz4j2eU0fRPVE40+JJ6cJCk/tbRAiDlso503M5YyvjKG2WTVCYrhV2b2OTdYnaBTtsmTk6NwFDsdSAPOIaERmOJwnBUPeADc6zP3pP//gHI9Sw90kBXUSxXg/c75wl4BhTEKHCBCUdBSBvnTzyZLWT1CoUhcK35zOINu7q2pHKMFYqoE6F9TolaCGK+KbNmap9NGpFfOnacWMor2jzhP3HEUz5klBEVqGtCxMLGyQJhscankeFoIHfjWUhHwqkqz4jW/J76vwcgn5RPXV3cUrIi+1cekdhyT4+Lmw7SR7A/ihkmFz0668rCVds3+Gj4dTN9axtm/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4SztWZLVaRsi7iJd2FBvZ0HtUGKm0qwlaHAQ4ERQm0=;
 b=rkrkk9IWsIymgv2dYGZMJJwMlIIugU5ZzbRi094XjMtY7oDQ6HA0wrAzdGFyog+x90gjoeS4YVf5Yni5zY4YzGi2mdRQQrDfHVgt6OnDHHx2HE9FwZT4sXy2uwEz+sH+D3UTIdhYxtIgClZX384nBVdv/+cwbgYDCr4zkuyeOpNPpHx9EOk/GBb+3y2Q+6POidQ3BkPo6yi5dgn2Pre+w6ffILJuagvkFpauwWkzFwyRpQiUiF1NrWJ/K9wc+RiraKktsjEdhHhe3+v/XO+zADj1pz4h1qlGl9Lnqqg24GpVgRDrrhYNld8exijM0WfZkZyCHXan+KoZNZvnfuDeEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4SztWZLVaRsi7iJd2FBvZ0HtUGKm0qwlaHAQ4ERQm0=;
 b=EpELIfaeSvqmrV+8KjnWUjb49i+OD83QWJt63nGVW0FGSE6B6IUx3QUKRoXk8+afHGx9DEH7qWjd4LBJhI6FD1bN1TY6NGEeeQfnxt5n2qBnFrVBydNCBUCQxuPSFn98Q7Fwl5piaPwrq/SJspCulm5M39jS33r1elKwEB5hwdo=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by DM6PR04MB7065.namprd04.prod.outlook.com (2603:10b6:5:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 5 Nov
 2026 23:17:23 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 23:17:23 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>
Subject: Re: [PATCH v2 07/17] hw/riscv/platform-ref: Replace deprecated
 sprintf with g_strdup_printf
Thread-Topic: [PATCH v2 07/17] hw/riscv/platform-ref: Replace deprecated
 sprintf with g_strdup_printf
Thread-Index: AQHdbSSmfTtXBi7XYkWCPXRiMHtx8LcgHVUA
Date: Thu, 5 Nov 2026 23:17:23 +0000
Message-ID: <64f77c211572de8d53dcdf8ec1b3bbfb415e4071.camel@wdc.com>
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
 <20261105125203.40320-8-philmd@oss.qualcomm.com>
In-Reply-To: <20261105125203.40320-8-philmd@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|DM6PR04MB7065:EE_
x-ms-office365-filtering-correlation-id: 7d1436fe-ed92-461f-2c7a-08df3b92f29f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|10070799003|7416014|376014|1800799024|366016|18002099003|22082099003|261102123227099003|261022075727099003|261021123027099003|261028144727099003|56012099006|11063799006|261009223027099003|4143699003|261022105027099003|261026140227099003|261021121427099003|38070700021|10067099003;
x-microsoft-antispam-message-info: xH15NvTaKW0F1oI2kwpWV8A0eWMIsboJ/MxXCuBVKs9Hq81ZZ6mtTRexmJen8fYdWMKyFPRJDLBbDk+4aSKDJEgi40PRu+QW24mjBpuIrLRWTQHPd5AM9W+bY4yQ20mcJUvxIAWWQR9UOOX/YmIpoAqiVLsWimMJM+TWUUHN+LX0YAtej29b5p+7ZE8f7JVDMvAo20BRVebhfGKR5LNn/jM9DdWjGpfivZFjwFKfVW4uWl/dvxszY+FCDXIYjsled9HGH6DsomrHGkZcHOm+Cvfij1Lm+kS+nrxDVZQ/Gm5vY2X9CRSWvRwmTSKrgmdakKesoxLeW/ZTaBZE/4WWGsUTSGBp1RZ9Mwc9ACu6tBBWWPjywOV7RIyMeOS60LwCbkJuJ6Piz7PSt4qTmriDjKnGHukmcyCtvq9I4o0emTROsJ+P+p2JIlg0K9EHFASnX8n/GoNfuxKWT6VDTOQKRPiS5ixvcDjVXxeI24/XV8ihPCxm/Y9xEAFYBdXt9NQ1cX6Uz3wdEVy9E3FaG1ajbzSS6b9Rxab7HDfhxzYZD2hFCi+3moyoi2hVCRVBQlx9R3Cr6O1DC/GBOTO8Yx7qP/rlHf2s+HA4dEV0pATtNRGhf2t8tCPaDkv1yBhaDp5wZArETUhgtC7DQRIvY9ulN8jkQTDvhcWmreYLNri7aybfmnGyfVs/wS4jptuwFxt9TDi8wKaqevDaHQs0VfmwQQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(10070799003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(261102123227099003)(261022075727099003)(261021123027099003)(261028144727099003)(56012099006)(11063799006)(261009223027099003)(4143699003)(261022105027099003)(261026140227099003)(261021121427099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SytTWTBmejAxRTIydmNCY2wwV1ZSa2RNNUQreGYxTFl5TTdyckU0aG5mbmxJ?=
 =?utf-8?B?SUpvSHlxMzFQY0h4TkpxcUhhdE8xS0tkY2xRVUQ1dDVqMEJSODl0eFc3VUFH?=
 =?utf-8?B?SnkvR0JyVm5zb1BHMDVZYjg5ajRJZllCYjI5Mm1YbEtXSDZYRnlBK1VZcXdm?=
 =?utf-8?B?MXpLTXQ0Q0ljNUZneFdicXB2dmNGZjZGTTMzYWViOWR4M3lhclFGZzZNcnNm?=
 =?utf-8?B?amxaRnF1VzNuZzdCcWtoOGRIRndkOUZyVFVRSXJzZ0QxenJiazZtNFlsenVH?=
 =?utf-8?B?U0kwMlZ4czNNa1VRYktUSExseUpRWExYa1lPVURFSlEwQ0xWVlRwZXhiVlpm?=
 =?utf-8?B?ZXhsQmlRYVVnTlg1S0pLczhXYlk4WTN2a3RoOTdIV0FtdVdERUFJcTA0SnBU?=
 =?utf-8?B?WDJwZjFCSEtNbUJSMEhDY213NnNyVTN0VUNDdHF1NVJvVW5icXAwZ00zUFJ5?=
 =?utf-8?B?L3hzUDNMVHFSZ2twa0tReFkyN2RwYUl4V1k1TnhhRlhwZVVadUxQZUREQVA2?=
 =?utf-8?B?WVp4ZDJzZWRydmYxQ0tCZStyMEJrZHJkT01JdEt3UnNRalh6TDh4RS9lN01Y?=
 =?utf-8?B?eUpGYzJsT2VYb05wYUY2RFJUMEwyMkM2N1dEdmZVZExjT1VSb0pVckRmeVFJ?=
 =?utf-8?B?dVFzVFlGWlJFSzNlQkY5ZWllNlBLbnlOeG5vQVMyZnordVE5SmVTcEJNYmQ3?=
 =?utf-8?B?NWVFcXUvZ1ZQdmFtanI2aDExTWx5aTBLaUI3Tk1ROTc4YkhtNDgxKzNRVjd6?=
 =?utf-8?B?NVBWQWFPTVNJR1FMckRGZ3g0aW9BVWhzNUFRQ1FFendJUVBuZkhtT3kreWN2?=
 =?utf-8?B?WGNtejdiSTd3cDNwQUordFNUcndrT2hYTGtoaGZlQXYvWmtCTks4T1RkdkI4?=
 =?utf-8?B?MGJ1aUNFZVdWYlJJU3UrNk5ibjJDN09DSkxXeXp2WnJOdlFjcXBsZnZXUkVp?=
 =?utf-8?B?R2s0bkcvWWRNdTkwWGZPMU94cm5EaUlENGJXeHVtQUsvcXBCZXlac040WHJI?=
 =?utf-8?B?RTkwd3Jxa20yZlEwRHhuKzZjNHJhaVovcUFWRnRQMkxhc0R2SzdIci8xOS9u?=
 =?utf-8?B?N2tudXp4YkZ1VThnTDdKS1RwM29iSVc4Ylh4dXBINE5MMFpKUWM3RUFxMU1x?=
 =?utf-8?B?OE5XY2dheUY4eUE4VFYyeFI1eGxRc20yaGdOQnljWTlhUStVcW9XUitQWHVm?=
 =?utf-8?B?V29UcnZlNjRpMVpsdHpEZzRpU2ZwQk9lQzNmSjl0VTJ5S3lsNW52UnBHQ1JP?=
 =?utf-8?B?TXZKUmdBaEtwb1JTbzBRcHJsc3pCMTJyOUk2cFlnZkFidW5KU1hBeG95cUsv?=
 =?utf-8?B?bHBQV0RQRkFPQWdvalRyNGRLV0d0eGY5TjZPc3BKb1MxaVZ4MXkvcUsyN2d0?=
 =?utf-8?B?K2pGVFdKRDZPZ2I2SXNPMlUzaUNRaUxFSTV5WmlSUEJCeGlacmdFZThHTVg1?=
 =?utf-8?B?Tk1EVUtIL3JFN1JONFdJZTMwaFZ0N0MxbWpLVUlUZW9OazFRcG9pa2g2RXFP?=
 =?utf-8?B?dlo3aTJmMytFRkZNMkg1ZXVzdFhVdWlRV1I4VTFCR0I0OVlLN1BCY3YrQnY3?=
 =?utf-8?B?TVl2U0lOVHZHTUtTQzU0em1UZGVlSFRod2ZFWW5SRlZMeVBGbXRHMXBDSmlj?=
 =?utf-8?B?L05vcVJOTWVxRWllSGtrK0dIeFlud1RVVHkybGh6cnpNdy8yRzdnaHVKanBa?=
 =?utf-8?B?M0pYNnZlMU5CVjExT3FobXhKSUVjUzlOaEhxMDR6RTVEUlFtbUNEL1F1RzJF?=
 =?utf-8?B?VmUvS2Y0SHN1VFhZRnBnUTlDWkdRajI0eFdDSUhDWDdaSWFUM3pyaEF4bTh0?=
 =?utf-8?B?YkJDb01QcWdsK1hzVWV2VWZiaGNHc2tpQ0dSSUZVUXpwbkw4RzZBalVEQ242?=
 =?utf-8?B?TDJmN0Y3WGkzQ0hwdVdWZ0pHOUV3VjdmU2RsalhFVlprNjlzdGtSWng0NTE0?=
 =?utf-8?B?ZW5uWC8ySkNFd3ZXWXlEcDBUREFNR2MyS2U1RnZsd2FGWEY1ZCtEbmo2L1B0?=
 =?utf-8?B?a2U0VGk0YzhvNTdNY1gzL0x3TlBveGlyK2dKRVNTY2p5OWtKL3dBNW1lbFJr?=
 =?utf-8?B?bGpIbVlxVUFPTUFjUk1LUUlyZm5CQnlWaUJNUXNZVmQxWEhONU5jVjF1MWx0?=
 =?utf-8?B?OW53WXlldE1TZGdRZzlZWGZEMWljUkhMVUdlT1dETFNTbTFiRkx0b0kveGhj?=
 =?utf-8?B?NlZrWHVRTW95dkgvWTJOTmpja0l4djlaSDVESmpSd1ZDd3V3L055eVR5dUpw?=
 =?utf-8?B?amxJTWxUZ1cxaGpqZnFyNUhsekNTdStxWElzMEdWV1kzTmxoOXdyWjJGODNV?=
 =?utf-8?B?S3Nlc0tyTWwzNlZFbVpKaHlzOFlpWXR4VmRTZXUraWFaYVFJeUVPV2toUmZk?=
 =?utf-8?Q?UGIi2aqwqrtg2FZk+dnXJikQkw8Fgmp4mjjQHgYheyyvH?=
x-ms-exchange-antispam-messagedata-1: vWV5ix8J+gxMJgeZfHhjBVkEbFS5US2eOHo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E77B5191248EA84095338006419F84E2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hXXAq1BAClDgisp80WpP0TQ4o5Z0PQTrxd+8VeZedlmaj3gNhv1eLcGM/2dzJA+OY01kiyEUu+VipMRXPZ1q03Cdnb3Bt3U7W/U8iububRH1E1gCI4g3zxjcQ2NjGtPJNIBrzhQVTY1vqohEvWywMjNoWv1N5Zdty1UiPUKcNBEopIqOlcp8FElQoHPJi9agGzZwCuTQY7ksur+AurJn+rssWyQCUzXRowiGWynT/jMPlaBplLt9L1n1rQ7nsK4lIA2KuGima0M1goTI6ZeSveDbE26kX4Ms2uWnTgyRJi1EMA+kmx3nreNeh9rpsjQCkb8Vnr2aXSX+MCPfcT+Vgw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Kb0ZqFr3s/5OSjStOV0qDqk3++bc0NRiy0y06GdcoMGWkjdaIlOwmayVwFT8pyfCOMSxotmNbRekqX3IEVqM7cfnrKP641zQQ/6Jqa4vhLj+EpCAvdAnPMrxpRKbnNogBXELGMHRBtd4oZ3iEYaRuUGrEk27g4sG8gbXvfh4ScqHrEs0Gt89M7L0cpoHKXMIIokLHRuGCrHsGG3flYFJ5i7nY4pcn5ALwMrIvTuO6xLoc0gsBUATeETSf1kPbswR4kzsrS7mokVx63AOGg7FE9ou8fWU9Qw2CgoifomORdIEvTJMVQWY92+ObtOXfjh0HaoQOoo2yHMU9ftrC743en1zAzb+cGPsmMXzNPZJpjm2MpCKM4KxO43whEipSpGggflx/jrgYZK3GsMEEcETkgRCURpxyMylY/p/QzftbzyedgnvNwABqtYMd7lJnQuqFWd9B1ypqnysvW3dekXDF41sYQGj6bPw7KhUMQH3pMWtMvkRvSCAw8/+194hiIHf1ybxBjvXhVdaybK9Sa+rYkeO3uEk8PRRDyYAXh9fWz+kEm2LkoaDggYPaiuJF1NmmUJZmormDwp0kVaQbyiHDtgoWWv1f/uQwLscx5MCcwdFg4ScxcU7yKjYetI2xgOr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1436fe-ed92-461f-2c7a-08df3b92f29f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 23:17:23.1488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p98o1mb7rJOK/DhWrr6ft01HfgXsr8fYNSv9FRjpenihfo0CkkJ1+iq0BWiUq26DSbVesm2X8JRoG0tuRNpDeO4qlF/lAxwjvXECNmITkcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7065
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=7622369f3=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVGh1LCAyMDI2LTExLTA1IGF0IDEzOjUxICswMTAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToKPiBSZXBsYWNlIHNwcmludGYoKSBieSBzYWZlciBnX3N0cmR1cF9wcmludGYoKSB0
byBmb3JtYXQgdGhlIEFJQQo+IGd1ZXN0IGNvdW50IC8gZGVzY3JpcHRpb24sIHNpbGVuY2luZyAt
V2RlcHJlY2F0ZWQtZGVjbGFyYXRpb25zCj4gcHJvZHVjZWQgYnkgQXBwbGUgY2xhbmcgMTcuMC4w
Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAb3Nz
LnF1YWxjb21tLmNvbT4KClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5m
cmFuY2lzQHdkYy5jb20+CgpBbGlzdGFpcgoKPiAtLS0KPiDCoGh3L3Jpc2N2L3NlcnZlcl9wbGF0
Zm9ybV9yZWYuYyB8IDExICsrKysrLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspLCA2IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi9zZXJ2ZXJf
cGxhdGZvcm1fcmVmLmMKPiBiL2h3L3Jpc2N2L3NlcnZlcl9wbGF0Zm9ybV9yZWYuYwo+IGluZGV4
IDVmNDg1YjFjNzljYi4uZDc1YmQxNDY1YTQzIDEwMDY0NAo+IC0tLSBhL2h3L3Jpc2N2L3NlcnZl
cl9wbGF0Zm9ybV9yZWYuYwo+ICsrKyBiL2h3L3Jpc2N2L3NlcnZlcl9wbGF0Zm9ybV9yZWYuYwo+
IEBAIC02NjgsMTAgKzY2OCw4IEBAIHN0YXRpYyB2b2lkCj4gcnZzZXJ2ZXJfcmVmX21hY2hpbmVf
aW5zdGFuY2VfZmluYWxpemUoT2JqZWN0ICpvYmopCj4gwqBzdGF0aWMgY2hhciAqcnZzZXJ2ZXJf
cmVmX2dldF9haWFfZ3Vlc3RzKE9iamVjdCAqb2JqLCBFcnJvciAqKmVycnApCj4gwqB7Cj4gwqDC
oMKgwqAgUklTQ1ZTZXJ2ZXJSZWZNYWNoaW5lU3RhdGUgKnMgPSBSSVNDVl9TRVJWRVJfUkVGX01B
Q0hJTkUob2JqKTsKPiAtwqDCoMKgIGNoYXIgdmFsWzMyXTsKPiDCoAo+IC3CoMKgwqAgc3ByaW50
Zih2YWwsICIlZCIsIHMtPmFpYV9ndWVzdHMpOwo+IC3CoMKgwqAgcmV0dXJuIGdfc3RyZHVwKHZh
bCk7Cj4gK8KgwqDCoCByZXR1cm4gZ19zdHJkdXBfcHJpbnRmKCIlZCIsIHMtPmFpYV9ndWVzdHMp
Owo+IMKgfQo+IMKgCj4gwqBzdGF0aWMgdm9pZCBydnNlcnZlcl9yZWZfc2V0X2FpYV9ndWVzdHMo
T2JqZWN0ICpvYmosIGNvbnN0IGNoYXIKPiAqdmFsLAo+IEBAIC03MTYsNyArNzE0LDEwIEBAIHN0
YXRpYyB2b2lkCj4gcnZzZXJ2ZXJfbWFjaGluZV9kZXZpY2VfcGx1Z19jYihjb25zdCBIb3RwbHVn
SGFuZGxlciAqaG90cGx1Z19kZXYsCj4gwqAKPiDCoHN0YXRpYyB2b2lkIHJ2c2VydmVyX3JlZl9t
YWNoaW5lX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCBjb25zdAo+IHZvaWQgKmRhdGEpCj4g
wqB7Cj4gLcKgwqDCoCBjaGFyIHN0clsxMjhdOwo+ICvCoMKgwqAgZ19hdXRvZnJlZSBjaGFyICpz
dHIgPSBnX3N0cmR1cF9wcmludGYoIlNldCBudW1iZXIgb2YgZ3Vlc3QgTU1JTwo+IHBhZ2VzIgo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIiBmb3IgQUlBIElNU0lDLiBWYWxpZAo+IHZh
bHVlIHNob3VsZCIKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICIgYmUgYmV0d2VlbiAw
IGFuZCAlZC4iLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiBSVlNFUlZFUl9JUlFD
SElQX01BWF9HVUVTVFMpOwo+IMKgwqDCoMKgIE1hY2hpbmVDbGFzcyAqbWMgPSBNQUNISU5FX0NM
QVNTKG9jKTsKPiDCoMKgwqDCoCBIb3RwbHVnSGFuZGxlckNsYXNzICpoYyA9IEhPVFBMVUdfSEFO
RExFUl9DTEFTUyhvYyk7Cj4gwqDCoMKgwqAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCB2YWxp
ZF9jcHVfdHlwZXNbXSA9IHsKPiBAQCAtNzQzLDggKzc0NCw2IEBAIHN0YXRpYyB2b2lkCj4gcnZz
ZXJ2ZXJfcmVmX21hY2hpbmVfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIGNvbnN0IHZvaWQg
KmRhdGEpCj4gwqDCoMKgwqAgb2JqZWN0X2NsYXNzX3Byb3BlcnR5X2FkZF9zdHIob2MsICJhaWEt
Z3Vlc3RzIiwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBydnNlcnZlcl9yZWZfZ2V0X2FpYV9ndWVzdHMsCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcnZzZXJ2ZXJfcmVmX3NldF9haWFfZ3Vlc3RzKTsKPiAtwqDCoMKgIHNwcmludGYo
c3RyLCAiU2V0IG51bWJlciBvZiBndWVzdCBNTUlPIHBhZ2VzIGZvciBBSUEgSU1TSUMuCj4gVmFs
aWQgdmFsdWUgIgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAic2hvdWxkIGJl
IGJldHdlZW4gMCBhbmQgJWQuIiwKPiBSVlNFUlZFUl9JUlFDSElQX01BWF9HVUVTVFMpOwo+IMKg
wqDCoMKgIG9iamVjdF9jbGFzc19wcm9wZXJ0eV9zZXRfZGVzY3JpcHRpb24ob2MsICJhaWEtZ3Vl
c3RzIiwgc3RyKTsKPiDCoAo+IMKgwqDCoMKgIGFzc2VydCghbWMtPmdldF9ob3RwbHVnX2hhbmRs
ZXIpOwo=

