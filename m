Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E716C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5UC6-0004bD-QG; Thu, 17 Apr 2025 14:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UBl-00049h-3r
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:42:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u5UBj-0002yO-2Y
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:42:16 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGMpOd004085;
 Thu, 17 Apr 2025 18:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=0e8iCCXFPUmG+4zF8DtGp4WWOEF8/rqPEANE0lQDIH0=; b=
 d/MlmI1EX6nmym2zqWnfEmQbCI4e9jVIiOChsvdURt+js3fxuq5bIYJ4Bl6PVDMC
 rgrqeWZl8UPu28Mp44KRYYF/+MIruaLgyUG0BuV4abliHB8sQSM4LDv6ckqPf+Ll
 p6iutcJJsVJ3yLZvU4sDrkKIdQSi9r7tcLEVj+PqwQyIXbYc0/Hhm4AU3P+xC1x9
 gdZM50Zy2PI8Jhi/PcDntZIk6gNvWc5L067hmJ/O8vRquuWoKjXxMlbuR7OGwbMU
 xMhufhw9QGUnqKJA9JCooGNSIuk3E7weOTF29UM/SF1ZVk1Y+Tc+iJv9Z7XJ7VrD
 hKCL1w9t8uJt3REGtSVocA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4616uf79q5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:42:10 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53HH9rcC024692; Thu, 17 Apr 2025 18:42:10 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013062.outbound.protection.outlook.com
 [40.93.20.62])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d53w9xs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 18:42:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+yWcMWcs6VtbWyW6EV9FhIlo9ByOZr64WVv2WPKYP3W5BVVdFw3QsEp1wOOV+M/YFxFz11FDjuK1q6X3n95qHSCtAt+8rsPgKN1XICAS33riWYKRs4pTtryI6Z2X1LagbaTipNBsig/ssxD/A+h3Qc4I9yiRlPEUaqQEv6uXuXPoekAmXaD9QeKKUJgP9l7LIi98DPsBm7glnNxaKqY4hNkzbWoXT70EXsJB4KWajWDP1HljDwBd0snOKbwP7otCI9hoUAJQXIyiSpuxRGmbA2KYyt7I3vK84hctQUQ86L9lQJO3G0pME25R23W7ndDasBsvKj+xsFOZkFz6cYQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0e8iCCXFPUmG+4zF8DtGp4WWOEF8/rqPEANE0lQDIH0=;
 b=YBq4NKiwriwpZKEl2DdctOGtD8b3v/WS3OkOzW6Ci/PBhs53rQzyETFZjCMmMzVs0xOP2XcW25GOIcq04HWS+XlOsKU+/CGr5VjspoRuUjjSKH9EdqkYWTryHH6rcWpW39Nt8gN72sZwT+D79q34V1+c2GB0vkyfxd18pEK9IQvqE7Iks3gi6a6cwxzW1G53CRI2LC7UvkcXcaWnwayDu3sq3nAT6INQPu7IPsNDZosd/maOop+P0XwdNaqguZ1P/y4NTKhy5/i0zFdbseO/hPCu5kD+I1xLB2cxDTDIcxECTt+yRKJ8VKaZ75mV0viLhJx3rbgrnbufnRXx7+BMLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e8iCCXFPUmG+4zF8DtGp4WWOEF8/rqPEANE0lQDIH0=;
 b=BwmrP0zOaA6eG79aiveBTdLrG0/EVhIAD8nZdX2IZLjALnsfAFhB3/UuHvSMale01Coa56jtMgB2z1qneMy2dfFZBa7VPtFCmYP/LJfBv6fdYZuSaYJeFew0L9HdkYN0wN8KiApWCI40gy+EI4T3DzBdLemrUfvRKl+68XcpBNg=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by DS4PPF9FE99AC64.namprd10.prod.outlook.com (2603:10b6:f:fc00::d38)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Thu, 17 Apr
 2025 18:42:08 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 18:42:08 +0000
Message-ID: <568b1327-6dde-41e4-a52e-f964ec226142@oracle.com>
Date: Thu, 17 Apr 2025 14:42:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 02/13] test/acpi: allow DSDT table changes for x86
 platform
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, alistair.francis@wdc.com,
 sunilvl@ventanamicro.com, ribalda@chromium.org
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411203159.2917-1-annie.li@oracle.com>
 <52e9a4fe-e29d-4368-b320-36e00243a080@linaro.org>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <52e9a4fe-e29d-4368-b320-36e00243a080@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0477.namprd03.prod.outlook.com
 (2603:10b6:408:139::32) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|DS4PPF9FE99AC64:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6778e9-e19d-43e0-8813-08dd7ddf8e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUhCRnB1ZzAwYVZ3N3BRMERxQTdVNW5meE5mQ0RJTDF6V1M1STdjZlM3NTN1?=
 =?utf-8?B?UFlYaXJNR1dUTGFoMVBHaXJYWjM3NzhTM1JFMG9IZXRNNGdZS25vNHF4SUFO?=
 =?utf-8?B?Z2ZlcFZoeXYyMlV5SGxudkhIZU5MM1pjdWVISzFKRkdWNlNMd1BiVEs1Z3F5?=
 =?utf-8?B?TXVzZXhwOThnazJHdUdEa0o1SjVXMytPMHBtVDk2WkVIdlNXQ2hNU1RXcG9a?=
 =?utf-8?B?cXpQSFNtZkxKNEFhZkdzZzBVSXFteStNWHhuS2c0KzFnODZ1QzMyRG5NWkIz?=
 =?utf-8?B?QlBpdVNQZzRlZHFOQzR1TDNYRm5WU3NIQzRsc3pkVHBrRjJET1E4d2hLb3N2?=
 =?utf-8?B?eTduRkdDSzFNSlFvNStybHBIdlZnZDI3UlYrdUIvL2VqMkRtbVlZeUM5dGUw?=
 =?utf-8?B?Q3F1dkJwYWMzVEp5TEkyVXEvN3FhM1pJaGhOVXpFR1ZLYXJFeEVUK1FKWlN6?=
 =?utf-8?B?a0lRVDFWSWxFSjk5UFd2MTZSaDdxekNQY1F6M25PVkdXdkFzNnJEai83NmZC?=
 =?utf-8?B?ZFJ2SkxoV3pJZ0xyTDFDNTZudmpFL2lSVTZ2NGUyaFRicW94V1FUYWRkcGJ5?=
 =?utf-8?B?eC9UK25VcHhQcUVjZWJDS3hPbGtmVnpBYmprWEtZRC8xSnBpOHpmbDljL3lI?=
 =?utf-8?B?dVJZcEljMEdPNnN4OVA3UTg3dXZUMTQwNnNPTDFLZjlxMUdXMFZKcnMxcVNw?=
 =?utf-8?B?d1RPd2RGdFBLTXhTb3pTcDROcWY2K3p4d1pIWmxyUk1IYlNMN2JEVHJjN3Yx?=
 =?utf-8?B?M1JqUUF0TlEva0x5bTdrZFBVLzNlODNzdEFWdHErYWV1SnRnZzBGcVc2SXpG?=
 =?utf-8?B?c2RVRWdJU2dPT1RuMmo1aVM5aTJrbVVyd1ZBUFBuQ2tCbW5PNnNkOU9YYkgv?=
 =?utf-8?B?V29udDdRWFV0dTI1VDBwa0kweWdNME5PMGgyTU5iYUZMM1laNVNpZHpxTEtp?=
 =?utf-8?B?bFBMcEtsTVJibVdTQmE0eUZmL1U1SlpOeU14WkVSV3NYaXhwTU8xQlRpYlhT?=
 =?utf-8?B?bzFsNWw2U2ZrS1dYVm42MFFPWmxwNzJTTWtmenZKWjR1MHljNEdFd1pDUWVZ?=
 =?utf-8?B?MC9sa0RBcUxqM01WNnRtU3dUTUJQK2RBVktmMFo2VTF1TkRLUUlENjZmbW4z?=
 =?utf-8?B?MkMxS3QyTlRZRVliV3I0dVlKN1NucG95OVVEMHlMcEZZZnlQRThvQm9La2Ja?=
 =?utf-8?B?OXBTSmw0aU5XTmw3YkxMMDM0TWhxc3FDKzJSVXlPTVFFcjMvYXJ2andqTVNT?=
 =?utf-8?B?QmpHcmNBL2wwRnRJcjlPazVjQ0hIRHlqMHZLa3M0eE5ZaUZqSkExWjJnVEk3?=
 =?utf-8?B?ZnBjZGVGY3BET1dxMk4rYnkvSDdFTGFzaTQwUzROV2Q5dHNNLzRpcWlZUTV3?=
 =?utf-8?B?TEd1UTNEZGxaeldadW54VStYMjZFbHRwcllDb05UWENZQ05WcXVaaFBqS2t6?=
 =?utf-8?B?Mi9JMVhkaWpkS0FMTmZGWlR6cUlxNEtOYUZUSnBKVUJjSDA4TWRGQldXSEVR?=
 =?utf-8?B?WWlYa1FUMms3anZOeDI5TjdSYkVmSnkyR1g2aVg5T3NucnpxUUVFUGM2OElL?=
 =?utf-8?B?c2Z1Q1F2YlE4S2M5RmtCcVZhMEY4RTVhclV4U0ZBc1ArbXg4SGpJOElFdDYr?=
 =?utf-8?B?NWs5d1JHV0hXQ2t6b1FrZ2ozYjByUDVCcGJFSy9ObkMyOUtBdXk0NmhBZkcr?=
 =?utf-8?B?YXRTdnN2REdsaTJxOUNzVGZQM3JtU0swU0VoQjJ4THRsWmtRUTM4T1pxM0JL?=
 =?utf-8?B?dGplZXFIN3hRL0huN2hraFhZWVBUOVFrcXZ5ZXd5Qk9SMmJyUndlV093RjFx?=
 =?utf-8?B?SEN4NENaRXNESXNtVG1IVWIzMGNWemdXdUZzZGlJaHhpT21Da1ZrdTBYSzY5?=
 =?utf-8?B?YlBFcmNuNlZrcHh3bHdUWGhGQzQzL29VcFNYREFiSnREc0RLdWxDUGhNVGMv?=
 =?utf-8?Q?NKsuwbaJHE0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEFFa0p0WWxTNlR2RndDVlBOcTZTaVBuSVZ0YzIyU2ZST0hGK1hOS3RpMmNU?=
 =?utf-8?B?c3hJdmQyUjYrNW81K2lDbEY0TE5pN3B6YWRVV0k3K3VTMHp2Rzc3d2xkWTdu?=
 =?utf-8?B?c3QwWm04a1hidWpNUnJDaHg3bzBva09nMXVRN2wwMndHU0lvSitKejBuMmhn?=
 =?utf-8?B?VGRTTDVVL1RkNFRrcXZQcEVkS2Njd2t6V2ZsdEFOZjJkd2tYYXE4RkF4Z0dM?=
 =?utf-8?B?eUlCZG1sTU42TE9keHNRM2J2SldaVXRsSThPa0VDSTB3Nit3YU5lTmdoY0kr?=
 =?utf-8?B?TUw2UGxQS0x1eGhTQ3NmQmh3V3VQdjduTXcrQzliQmM2UW1xWUVFQzlhNEEy?=
 =?utf-8?B?ZjdDV2d3VnRwdERhR1drMW1naytHcHk1NEJOQ0NLYkpENGNQZWlIUCt6M29u?=
 =?utf-8?B?cENVZ1lYblMyNWdrMXlONXF1L3BPSDBleS8zbEx2RnNhMHNqdmc4c3pyaE9P?=
 =?utf-8?B?TXNCVk0wM3QvcUtmQkVxSWlFZjVJMmRDeTlnTS9ZQjF3cm9LWWpzSXczWStn?=
 =?utf-8?B?cmhpT3lSb0pRQ0tUVDJrQ2k2Wk81MFhVYXAxN0hiN1hIem8vYXZzVjZvV0R2?=
 =?utf-8?B?WHVJRUtzd2xRR0VvR2xYVXdwdEtET3lqYkV1WUN3d1JqeUtDSHR6cmNuZ2Zz?=
 =?utf-8?B?MHdxU3RnRXV1dGdma3M2WTVBNWNTNjVER3ZDWDZwT2UvNUVIRFZmQWFrKzAz?=
 =?utf-8?B?eEx1cXZxSDAwZEZKbERiN3gzY3c4anZkMVVzM2pEeVJYallLVmpTWHpaZEtY?=
 =?utf-8?B?MzRlWHltL2Z2VlhYbnBJL0taZlRkejR4N2VVdzV3dms1Yml4QitxOVA2THZm?=
 =?utf-8?B?YmkxbjQyME1GdmpRVk5Ec3FSK0hOWnRwWDNmMjVMZG9sU3VaaWxEQkdIbEpJ?=
 =?utf-8?B?RWpwN09lZnBDMjJtY05pR1hNRFJzVUF2dFBMTE00VWVxMkxKRDRPdEwzaGJR?=
 =?utf-8?B?V0prLzk0UCtSbkFROVV3STN3dDZRNVoxTEkySzdNMlE0UUJTd3RHUldaaGRV?=
 =?utf-8?B?VkZPU1drWFlOczlMcTl0RHZtWU0zbUJFbHRmbm93L3R2WUpONmpPNzJ0aWg0?=
 =?utf-8?B?eEJ0QUttaFNuSW54UVUwaUF2V0xVMXU3bm1uL2paU2ZxTXQ2Z2NZdStkQmhS?=
 =?utf-8?B?ZURhVmtlT0ZyakhLSCtvVlMzUi9ISk5STVQyekU4NUFBeHBGT3RXdU10WFVL?=
 =?utf-8?B?TEE4WnFISXZtOFA0c1EyNWk3amlkV3VpRFBFQ0JhQUc1NFhLNURhSk9ieFNM?=
 =?utf-8?B?Y1hjT1prL05WRnU2M1ljSkt4UmsxczlIZTl1WXVyZHBXbmxKaG93ZEJvb3Fr?=
 =?utf-8?B?RVpKV1gwN3FwUXc3YjFzTHB2bzlFYlpoTDRpcStUQWpacTBmYUhTZWRBTWY1?=
 =?utf-8?B?UHJ4c2tKUExybHFvSXR6V3N6NlZIQ0RDS0xPditvK1BjY0JuQkM4WHBDS1Nt?=
 =?utf-8?B?RDEzOXZCWkdlb0dGVjBkeUVEbGptOXBEcDRROTlncFN3Y0J4aE4zaWNSMkNh?=
 =?utf-8?B?Wkl4RWlNYVRhOE1SN2FhMnNleHRKVnJSbmQ0azMwaWh1aU5FNnNGdXBnUzhC?=
 =?utf-8?B?VE10bVRxOHltdGkrbjJDbmswY0lHUUdiQjI0SmZTaU5GQkQwVTFhRUtGVUtM?=
 =?utf-8?B?Z0pnQXptUG5UL0dIbXE1T25WK2ZOTXA2NzlsbWttSDhJYkxYeU5uVW8yTlFp?=
 =?utf-8?B?OXZlZjRhdlArNllZRnlNM2VFWWw1MzlROEY5U0hEN3Rtek9IaktSdnlaa3ZD?=
 =?utf-8?B?MHJlSnBnZVRvZ3Z3SC9iY2ZVRU84WnhlUEgvQjc0NHFuK2czYUtld3hsQy8x?=
 =?utf-8?B?WFZqUEVCVnloNTB4QmtGaCtuZFJBajNlZWF0L25wR1dXeVVTZkxDN3JFRU92?=
 =?utf-8?B?NC9hdTBpbDgzOGtuTHBVQm1YY2owREJNOVRSenhnTUtGT3MxNlNGakhhRGhO?=
 =?utf-8?B?bFZNWWxmVmdGZytjbWZVa3VvUkR3bHpOdElOWE5COUt0bkxhSkU4S2V4Tkwz?=
 =?utf-8?B?TjFlZXlvR2RFa1BEbnhuRmNQM1FDWlQ4Z0FTOUpGL09rdCt2YkwveGV3UGRl?=
 =?utf-8?B?ZHlNTSs5dEdJWHZ6djRTSFBlMjByMksvQmx2anNQOUdISmZkVVlDWmJmN3Fs?=
 =?utf-8?Q?KiL3N4zM2x/mITeO33F9pIghy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zCLDrMww0QDq5y/BMIKxhrt9qgMv7wbHKJlf20YA/8x96dpoKq99tkozmiD7BYjfw8YATGlRoJZ1ZIr9WNrKrDNVXycSR4BlxGFsJKLQmmE8QAztrO+AcJJUO/pS+pmh4J0tb7999BVifP2SAgHQcihQypCob1MfXTZspsF9qLZizqvGQarrCAiZX6nySrmUcAuaj5Yn8qsCkvsYdciOXFIdL+DZ0RWVFX1Zz4frXi/N45zllBeE+v567nS0UD6HlPOFLbQaaYfL9RB6H4oSde+tchVyRtVSjZ7dOElwYaqv7EpXyhf/ffsFDRqI+D6eamIQ7z2/eKA+OtFWOFv47p1kULxaGnORswF4ZPQ3PFNYJ2CnwFcPJPsq4UH241QQjLHIJ5gz3zpj5wdq9wYSnAeXRLT+MF5ONLJSO8oq2hqqjZrl50JYsq4qdfNaRO0XfdJ8kJPjdXZdUlNrsX61jnAf+EL4os5SyyCy4G35OQMgsonRMbDuKHtO9bDQmt/gxybTRcF606aJhtaMjY5uI/6MU/i1noCTQcfk5aZvL8cWeevGteMjR7uItPnQ2kTAuFq/Ljadfw6NdAbQjQ9NmsF7AOE986dtcp89Sc2Z10k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6778e9-e19d-43e0-8813-08dd7ddf8e83
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 18:42:08.1328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKOg8YZwmyxjWqA4KcX31NKvV1x3hVt68jKvTe8cdobfHNxTmImqeMOq/gCJ/GOf/gVy49ABamzNLHoZSuS++w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF9FE99AC64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504170137
X-Proofpoint-GUID: 5ChElhvonrcttUcgu1mp2x3i_wNKw2_5
X-Proofpoint-ORIG-GUID: 5ChElhvonrcttUcgu1mp2x3i_wNKw2_5
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Gustavo,

On 4/17/2025 1:29 PM, Gustavo Romero wrote:
> Hi Annie,
>
> On 4/11/25 17:31, Annie Li wrote:
>> list changed files in tests/qtest/bios-tables-test-allowed-diff.h
>
> nit: List

Will fix it.

Thanks

Annie

>
>
>> Signed-off-by: Annie Li <annie.li@oracle.com>
>> ---
>>   tests/qtest/bios-tables-test-allowed-diff.h | 42 +++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>>
>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h 
>> b/tests/qtest/bios-tables-test-allowed-diff.h
>> index dfb8523c8b..a1047913af 100644
>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>> @@ -1 +1,43 @@
>>   /* List of comma-separated changed AML files to ignore */
>> +"tests/data/acpi/x86/pc/DSDT",
>> +"tests/data/acpi/x86/pc/DSDT.acpierst",
>> +"tests/data/acpi/x86/pc/DSDT.acpihmat",
>> +"tests/data/acpi/x86/pc/DSDT.bridge",
>> +"tests/data/acpi/x86/pc/DSDT.cphp",
>> +"tests/data/acpi/x86/pc/DSDT.dimmpxm",
>> +"tests/data/acpi/x86/pc/DSDT.hpbridge",
>> +"tests/data/acpi/x86/pc/DSDT.hpbrroot",
>> +"tests/data/acpi/x86/pc/DSDT.ipmikcs",
>> +"tests/data/acpi/x86/pc/DSDT.memhp",
>> +"tests/data/acpi/x86/pc/DSDT.nohpet",
>> +"tests/data/acpi/x86/pc/DSDT.numamem",
>> +"tests/data/acpi/x86/pc/DSDT.roothp",
>> +"tests/data/acpi/x86/q35/DSDT",
>> +"tests/data/acpi/x86/q35/DSDT.acpierst",
>> +"tests/data/acpi/x86/q35/DSDT.acpihmat",
>> +"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
>> +"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
>> +"tests/data/acpi/x86/q35/DSDT.applesmc",
>> +"tests/data/acpi/x86/q35/DSDT.bridge",
>> +"tests/data/acpi/x86/q35/DSDT.core-count",
>> +"tests/data/acpi/x86/q35/DSDT.core-count2",
>> +"tests/data/acpi/x86/q35/DSDT.cphp",
>> +"tests/data/acpi/x86/q35/DSDT.cxl",
>> +"tests/data/acpi/x86/q35/DSDT.dimmpxm",
>> +"tests/data/acpi/x86/q35/DSDT.ipmibt",
>> +"tests/data/acpi/x86/q35/DSDT.ipmismbus",
>> +"tests/data/acpi/x86/q35/DSDT.ivrs",
>> +"tests/data/acpi/x86/q35/DSDT.memhp",
>> +"tests/data/acpi/x86/q35/DSDT.mmio64",
>> +"tests/data/acpi/x86/q35/DSDT.multi-bridge",
>> +"tests/data/acpi/x86/q35/DSDT.noacpihp",
>> +"tests/data/acpi/x86/q35/DSDT.nohpet",
>> +"tests/data/acpi/x86/q35/DSDT.numamem",
>> +"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
>> +"tests/data/acpi/x86/q35/DSDT.thread-count",
>> +"tests/data/acpi/x86/q35/DSDT.thread-count2",
>> +"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
>> +"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
>> +"tests/data/acpi/x86/q35/DSDT.type4-count",
>> +"tests/data/acpi/x86/q35/DSDT.viot",
>> +"tests/data/acpi/x86/q35/DSDT.xapic",
>
> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>
>
> Cheers,
> Gustavo

