Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85C6FB5E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 01:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Ix7-0002K2-VX; Mon, 16 Mar 2026 21:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w2Ix6-0002Jj-3Q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 21:10:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w2Ix3-0000TW-FR
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 21:10:31 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62GEe0hb1257306; Tue, 17 Mar 2026 01:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=rojZ7Kgfs+zz1KmAImYTFt5WqvCABIBRQAxPKkrhfeA=; b=
 ma79mTfJUM6xr/lB1m3DuWv1FmAVpsaqdOTw6Kp4Jg4M70/eaJ9UNKlVQB3Sja2j
 wIltLmNWhNs3dmOgiWeH5uEaClIAr1KaARQG5ZfMjBRXeEyDeMZ9DrtyTOt/GRmY
 0zsejCkRXrTdYxbNnyXuPNxW7NaNAIARoDrgMeCS8Gj/Y2KmbrIUU9fHO8o2jXug
 3H5E+cMoI5LWMgHuRSar3gYal2DknbYT/0+8MWZgbplmpI/uOI8jQCsEmyAkAh8R
 1r998KQG9AnQkgT2v1A/YlWacprORjdMFdvoEoRkizBIMNtLY3Xd0goa0eeerUF+
 WEBy0z0QdFCE7ksxD+kNeg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyj63aet-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 01:10:12 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62H010i3002789; Tue, 17 Mar 2026 01:10:11 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4cvx4km68a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 01:10:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTyJg/Q2pnQBw6hxawQGzQb7Gv6+aR7Vo++T5s4psuoLmVykYz9K3anJG5iNFzGX3w8xiCdhJxXpG1YaET94L8fVw9efxK/PFAhcgXvqM0IhqIwjRAFwrHh0/Drq/ub1kZzfUqRHXQbRjOcc/t9eik1tw5t3leRqBX1pM3IDuaV71lGsLLgLfWKnh1LYO0XPOo0Mg9kEQ3Cn1POCK2HnlLTEirmGX33yiQ7dR556KCNtTHWeZAHZqnQrWEUtepqaOFTyhmlPcQHQhxeqeWjLClsCdf8Dtm6UT37uaXwb+oSuMsodVCZz+3QWHBrAIdMhi+tbwlYm5Hi40jKore8xFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rojZ7Kgfs+zz1KmAImYTFt5WqvCABIBRQAxPKkrhfeA=;
 b=CmLU8O5rDit013//3QULPt0tS8rdLx4BBPc9kjeyL4RWMHGY9+MrOz6w1RLRXCXwlcqd4FF4U8pTpUGbzk2JAWKoAcbgNFVojuzRWsqRXgOoYWF7mXX6BUE0iSKMDGi9hAEeTCh8Fz0F8AtzDA5t9HlxCUiP0AhkrHwaWkOAfKOhCulNXygulHj1RHfsMnoSQzZWBFXj9g+auHeUclqzBgiluhohCv+kSkguOBZTz+ySAgKsEyeKt7yhqUfACUaX86MI3gSOAVFPiUfDziJV9VnDlNRdOTm6vIpvjgGrjoVxvChIIP7IoylodA6rSfsQAI3n+k448SBNcT8v3bpoHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rojZ7Kgfs+zz1KmAImYTFt5WqvCABIBRQAxPKkrhfeA=;
 b=olrZ0DkFESV/jCBehvypB/DbwonWL6gLDkythemyynay0voaocUPHYDhDBsUyI0KYXxxOceu8yK8hWZQbCTBeIKjzJb3BrAfOQsNLgZZ38iMc1aSdPNR6hWb/ki/snoDcWpJOCSpKpY3MZ70DK1JhDJLG8AgkdVkD06t+b7HlsM=
Received: from DS7PR10MB5056.namprd10.prod.outlook.com (2603:10b6:5:3aa::8) by
 LV8PR10MB7918.namprd10.prod.outlook.com (2603:10b6:408:1f8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.25; Tue, 17 Mar 2026 01:10:08 +0000
Received: from DS7PR10MB5056.namprd10.prod.outlook.com
 ([fe80::c28d:941:26d1:51c7]) by DS7PR10MB5056.namprd10.prod.outlook.com
 ([fe80::c28d:941:26d1:51c7%2]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 01:10:08 +0000
Message-ID: <48aa9dfd-ae09-4e06-ae79-e51be47fa4a4@oracle.com>
Date: Mon, 16 Mar 2026 21:10:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] amd_iommu: Support Generation of IOMMU XT
 interrupts
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org, mst@redhat.com
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, vasant.hegde@amd.com,
 clement.mathieu--drif@eviden.com
References: <20260302115130.5903-1-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260302115130.5903-1-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR15CA0002.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::29) To DS7PR10MB5056.namprd10.prod.outlook.com
 (2603:10b6:5:3aa::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5056:EE_|LV8PR10MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9b9714-cc89-4242-acc5-08de83c1ed76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: COB5BdOlrLzpptyIWuxD3FM0Sk813Tn3p9rdpCU1PlsJRZETEUC9pYEeSttUIXFdgVRtFPRZIiOLg9Zs2CdG2u3dQI7pMR8pVPWWs0HxVtmgY1xklZNwavWoRJHr74EXfeo5RUaZhS1jC4UV2Hx+sMCfzv1JZbqrR2fcs99UJaOq9c0n9vuXQBi0TEo0v+aStmy3++oREcMcyR6kZ5A5XiGNcac5+Rtzu3Q61qhrI3QzZaIOU3gMhHR2RG+fS9NGYyulHotxgjB2besGqSyDRjjaOBDsYHyCNTVN4c6IhOjRFtRfk6XdnVrhqZaMpdf5kVngGNj8gA/faRXW+TU4sVIzsrjen36t7DOeegm8XbBq6MtslQ9Iwb+2laz9jQTItNzibVIHf57e3D87dr27G9g9/VZyIC/TPft+vgYXNvgiT8zKH+BgzPGBheamRx06dEHbRWQw4Z6bz9oryO412xxDclaRIjCLIutJ3rboBAqTH4EMYFKoIvOJ2kOtohQx/Kj6FLSa+V6VU5TOmbyMm9Lo0ju+00u0OCibmiokR01wtQpHmOJZ7wOXEJtSSKW7/+8h01DhGDEZj0lFVgYcUgiXQmGb14eV6pb4U93rILL47J71VHfd1NALDtChJc9LC08bwnDvV0SHzgvxRnTWsSWjC2pegiAkNK9NYQSXluNgYIwi6jjvowqxHzYGnd9e/+3/o7WDsI4Ztgf8CofVsW/jB3Uc0sL8FOkP+EfKpnaQmtLI+iQQAklSGs2cBEIN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5056.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTJ6aHRsQ1JPQW1WbkhZSERIcm4vL3lzMlZUR1VpcXF4ek5Ra3hUN0QxbHZB?=
 =?utf-8?B?TXVRSzB6eVpGVE5mdTcweFRYZkdhSnVaSnFyZ2VwenpoREZJdkxVZzkxUjl0?=
 =?utf-8?B?bzZUeXNTRVA5VkZ6Z01yR0ZvRVYzeVIyOGo0ZW8yNlFFRm1GMVY5Qm5HbU5T?=
 =?utf-8?B?R1hyek9uRitWWHNGRlVIK0pNWCs3aXJSQks3TnUwZWFiT0I0V2tmWHlxa1I0?=
 =?utf-8?B?MzZzLzYvNk5jcGhZQWlvNVNJcDFicXlNME1PY2Rwb1dZNENSV0N1OVhDUW5P?=
 =?utf-8?B?YWZLWFBJbnRXUytpbWlhaXM4Wk1TSVFHeUhsdHFxUm1GLzJ2U05xemNHZkFG?=
 =?utf-8?B?amVmek5ITjNUVERxcEtGclRId2FHR0R2Z3J4T0tpSjY1N2E4RlZlTEtQZjhn?=
 =?utf-8?B?aHJ5U3NSWUxUNFFhT3lQYW0venF1OGdGYkl2dVVqU2Q1QlF5UzdOUTkyd0hq?=
 =?utf-8?B?akZLeURyRURhSUhtclVlblUyQkFobWlETTllbjZPelQ5QTArY3ZSakZ6Z0hB?=
 =?utf-8?B?bzNnbWhmK3lGOVBMQW9iRGhaQ0JvM1ljNlZ6ZFAvaWVoZms5eVlhUEtxZ05F?=
 =?utf-8?B?MU5sZG9YT1JpVkdtR1dDV2ZqRXhpUWZJOVRiMU01ZkdIMEJvY2FnLzFoL1ov?=
 =?utf-8?B?K2VoaVZCZlQ3VTBVVzIrdWlLeitSSmJtTXlYQURUanpDSFgxb3Rxa0M0ZjdS?=
 =?utf-8?B?VjBWa3BXRHQ4OTEveW5GRkQxOXNKNnhWZkVSdmRHNW9KWE5Mejc1a01wOTZE?=
 =?utf-8?B?L0hVNUdaU2xQdnI5VGh5bHZldU5NQmhNd3l6clRDaVA3cnFmb3F6MThmUmdX?=
 =?utf-8?B?RzJvNnhFbmR6UlEzR1pVOTlTQyswQ1Y4Q0d3WWxHQllZL0YwVnV1RUdIek8w?=
 =?utf-8?B?WG5qN2dWbk1rSjJ1eWJmdjNBVUNuRHVJek4vbWtXN1ljZWh2alUzZUM3YkxD?=
 =?utf-8?B?NXB2U3daVkMxNDJDWG1jK094UElGVmFJb1BtR0dVUk5pMUFNUCtpR0VDeEI4?=
 =?utf-8?B?cVlFTkR1b0VyMnQvV01RQnNXNTBRKzJTSStWWWt4VVNodGJvTk9YdFZpNGkv?=
 =?utf-8?B?cTROVCtweG1VYjc2cWZTSHlTMzFqeXYxUmVqTTF2MnNwalhLeUhHV1Vta0ZP?=
 =?utf-8?B?VkFMQURENGlPbGZCeUpVSXBBdW9qUXovQjV4YjgyT0huSG44MWZqMGZFaXJx?=
 =?utf-8?B?emVTOTlEbTQzeEZ2T0NyQUZPdmFBejJqY25oNzRtcWZXTzdsenFFV1h1elEr?=
 =?utf-8?B?WlJobnduRzVoejByVnpqdDRib3ZFRk5tWGJDdkl0VWxSMGtnWWhZOEtmd08z?=
 =?utf-8?B?NU1iejlkek9RS1hYbDIvSFJOcHFiakJYdHI5UHFWY0ViWm1MbkcyYmkvVVpK?=
 =?utf-8?B?YzNyaHFYNnoxbnpjd0FlWkcyQVkyQVdGYlJQRlVwVkdTYUh1YW5oTEtGU3Vs?=
 =?utf-8?B?R1RBaXo2YjIvQ2I5dnJxbEtrN3BZZ2NqZks5Nlh2TmlOaFpncVppVEVQdjkw?=
 =?utf-8?B?Uy81WjlsNVAwWm1Wbjh0blBwMm9JQnNpLytCNjY2RVp2YUVibkhZcXphWm9I?=
 =?utf-8?B?S1BSUCt6ajJtUURNT01yTERiMnNwVXoxcUVGbUFxY1QrWEphK1ZudW9RZi9E?=
 =?utf-8?B?b3pVOGJyTVgyUFZqTGdmNUlTZWkyOWtFMzdaMkJ0a1NXWXlwVk1qSEk4aHBu?=
 =?utf-8?B?SEFVYXhWZ2ZubEk1UlpQOGVsbHh0WFhZenFGZWkyZ01TWktLZUxaM0Y4WTZV?=
 =?utf-8?B?Y3pNZDlEcHVJSG0rSEI0UGFKRXphSzg2ODR3YVZsL2JFK3dRWEZsZ1JFWEpF?=
 =?utf-8?B?YzRobXU2RWtTaU94RVp1UzBBQjJkbmh3d3J6Q1Zna0p2R3FZaWF1Y2dnSk15?=
 =?utf-8?B?Z1dJSlVENUNtWStHMHo4VUNQb1VvREk4alk0NUZZU1N0aUZReWtrS1JUNlFh?=
 =?utf-8?B?bTVaK2ZRRC92WWlGRG1TNmNMQk4wK2FiUjNUQUtwZWM4Vm94R1huNmNMd0lB?=
 =?utf-8?B?TFVRZmhVM0R2Q2l0Zm1TejlYYlNvNU5oMFdBQmRzK2YreEpjSHBDWGVoM0J5?=
 =?utf-8?B?dHNFUkY3TTJCcUh6ZXErUUhNa0lXMXh5ZkM3SjQxT1lVUk8rRWFySjF0SlVG?=
 =?utf-8?B?YnVJYjMxWmFrUy9RMWRYTHA0a1ZscjkrSHpvbldkU3Rnb3RMZGNoVURJTnZR?=
 =?utf-8?B?aTFnQWV6R0RsVU1UY3pBY3hLcFdUMXQycWc2VTN0Y0NwbEoranpGcVF1ZkZT?=
 =?utf-8?B?Mm1CdHVYYktGSFlDdGluWjNoTWF5QlRlUnRla213MHgrZzEyUGVvbGlCbSt1?=
 =?utf-8?B?aTlGc0t4YXdRZU5sT3YwNDFZdjIyb0dGWFRMSGRRaDhlUjF4YVVDTVpEVCtt?=
 =?utf-8?Q?rkuxBymC1DSA003s=3D?=
X-Exchange-RoutingPolicyChecked: f7G8m9fSYrnHM3+FVYBqZ3QjAz0dG44ej3RVVc/D8j3ihcBv8bVp8vdKKBUWYie5iiH6LkLl7+HiJiMVU/xyNAoQ9nlb8W1ntBFUXGb4nNMdHecHjbPMdv75qs/FWPk2n3SwJOGtjd0LAZ4N6ikQU2AAsaYBtUpluU/VPwpfCLqGG8bmRgwJg/Us+2DPZHk9N2yD6lDLNM7AK6OdEtfZoLbkHXsaj/qPD2E4/fWUk4tfvQCBRA83xcA3msUwAa7y9uJl8Un+8RbI70RHeZTGvR2dJXGQW0srx3YKfEPqgvVRc0nc+1UGlkMo1FAN6iotoVBxMjWgmSsDyjIm6jYbiA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qjBLmlZT34IrQvNN01H8QF7riVIWEtYtTpIXHZPD1kDhO5/tK6Re9pLd89vfSmGHO4sR42fQQHihwoB+TN6yWyGIYLnRXrnF8u3gWKCeNg/DTQAZKpdtQkqOF1OxMAQj9ET5MIxbCRQHvycv44llbaACZuB2nLP/l+CrON8bmbJZudaFTpB6M63YUggIJBR4Tj/gEA9OkfegtxKQPAi81rKbCozmMfOqKWaYeOfhjghvJrfXDjt5Bdxc+v/G4cG2WkvtNNZhtJz/uA3oif7zgghMdtOyVBHhuY4Ft+1SRAT6kIg0fUuDiYZaVYvS8fyD0wsWTblRkhsuHhEL17pHvyXWq+ii/9EqJfCxeKVpgiZK85YpACTW5BQVibRtx0eMwXSjIQdvbFyGsPFH+F8EtVthQWRzmTyM4Wob3sGPjC9SN56lpOzOTCbQrmUQiMbz8AFg0TGqPtI1TeCf0vPDTBNriiGWMSUg2zc6f5ZwrmoYyvBKIDptUunLuRUzLZ3DDilBVbrrGMh9kTl4raJ7w7vX8dk/FaT6S4Ps1zY4MwkDuC8F9iJ8N0eqS6ak1rkVH5cOtKSuXafD2xozzTGBvlR1VFuvui/IwF3SIzrCu4Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9b9714-cc89-4242-acc5-08de83c1ed76
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5056.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 01:10:08.1295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76iC+GJmX5YefQNFFMZvd8nROQJYZQMU1+xCwAMCxU+WOwGOQH9vEixi9gSOr1vZ+qPeXX/b91ZjoizeePLFhSMbkHscGGy1B8qyaKhz5bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603170007
X-Authority-Analysis: v=2.4 cv=LKFrgZW9 c=1 sm=1 tr=0 ts=69b8a9f5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8
 a=zd2uoN0lAAAA:8 a=ijMo1SeDTBgOp0OomOoA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12272
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDAwNyBTYWx0ZWRfX0yUf+c2uXtOh
 mV8EZI8KwZT7wHoFfJDATSyrfcGiSaOTLpiLyxlczM+I2908qgUmdV5U3pppe3Qydmhctj44+g5
 fGWO4rCJaLXF5OMnUZbzCY9f+w/y7FtQ4P7Rd3lv1B8+AeaeDaSuRQ3nlWf/JCg5dVPFEyaeq4l
 IWJym4G1mU0A2KTHIOwzlBBq/T1ukA19h2Ii/Pxp9aQTfKuXkM8KtHY9wkwW3CpgoyzaduoIUfC
 XM7ye8SfgsgWH1KFBpHxWFJ7bjaAKKL72NekhrrCRnHMQXtecW8KrXhKFL+Zz64vaIbucA2IzOK
 /pQkChtXfrHV7e+xA97HNNfU44cg9qz/i6CrkPjwsrREuH23hiWyem/chFNMczn60w6Zi7pJZii
 wRhqPRuRWP72AbyQaGOnMN7MxDnod+G0t6n+S18JLZAb4YC0kioT5PnjgBSFCHnUiepOt2c6ZwO
 zB1al670AMR2Ro3gNh3bV1H/XOd4HSDHmZPbmXFE=
X-Proofpoint-GUID: lzXFi1UvzGC2vSOQyFByCdly2MqJ0-2E
X-Proofpoint-ORIG-GUID: lzXFi1UvzGC2vSOQyFByCdly2MqJ0-2E
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Sairaj, Michael,

On 3/2/26 6:51 AM, Sairaj Kodilkar wrote:
> AMD IOMMU uses MMIO registers 0x170-0x180 to generate the interrupts when guest
> has enabled xt support through control register. The guest programs these
> registers with appropriate vector and destination ID instead of writing to PCI
> MSI capability.
> 
> Until now enabling the xt support through command line "xtsup=on" provided
> support for 128 bit IRTE. But it has few limitations:
> 
> 1. It does not consider if guest has actually enabled xt support through MMIO
>    control register (0x18). This may cause problems for the guests which do
>    not enable this support.
> 2. The vIOMMU is not capable of generating interrupts using vector and
>    destinatio ID in IOMMU x2APIC Control Registers (not supporting event log
>    interrupts).
> 
> To overcome above limitations, this patch series introduces new internal flag 
> "intcapxten" which is set when guest writes "1" to MMIO control register (0x18)
> bit 51 (IntCapXTEn) and adds support to generate event log interrupt using
> vector and 32 bit destination ID in XT MMIO register 0x170.
> 

Thank you for your work on this series, and being responsive to all the
feedback.

I reviewed this latest round later than I should have. I had mistakenly
marked the soft-freeze date in my calendar to be later in the cycle, so I
was late getting to review/test this last revision.

A case can be made that this series should be merged even after the change
freeze, since it addresses a potential correctness issue with the interrupt
generation, and the cleanup/refactoring/migration components are supporting
this fix. However, given where we are in the cycle and the fact we have not
seen any crashes/problems directly attributed to the XT support, I think we
can defer to 11.1, and merge once the window opens in late April. No need
to resend the series, it is already in my staging branch.

I'm including Michael on the direct recipients in case he has other
preference. I have the pull request with this series ready if there is
need/opportunity to merge earlier.

Thank you,
Alejandro

> -------------------------------------------------------------------------------
> 
> Changes since v2:
> https://lore.kernel.org/qemu-devel/20260129102814.4488-1-sarunkod@amd.com/
> Patch 1:
>     - Delete  amdvi_mmio_trace_{read,write} and AMDVI_MMIO_REGS_{LOW,HIGH}
>       definitions [AJ]
>     - Move MMIO_REG_TO_STRING definition inside amdvi_mmio_get_name() [CM]
> Patch 2: Improve commit message [AJ]
> Patch 3: Improve commit message and comment [AJ]
> 
> 
> Changes since v1:
> https://lore.kernel.org/qemu-devel/20251118082403.3455-1-sarunkod@amd.com/
> Patch 1: Return string literals directly instead of copying [AJ]
> Patch 2: 
>     - Update commit message [AJ]
>     - Introduce new subsection for migration compatibility [AJ]
>     - Update comment [AJ]
> Patch 3: Use ga_enabled flag while setting xten flag [AJ]
> 
> 
> -------------------------------------------------------------------------------
> 
> The patches are based on top of upstream qemu master 07f97d5da04a
> 
> -------------------------------------------------------------------------------
> 
> Sairaj Kodilkar (3):
>   amd_iommu: Use switch case to determine mmio register name
>   amd_iommu: Turn on XT support only when guest has enabled it
>   amd_iommu: Generate XT interrupts when xt support is enabled
> 
>  hw/i386/amd_iommu.c  | 144 ++++++++++++++++++++++++++-----------------
>  hw/i386/amd_iommu.h  |  25 ++++++--
>  hw/i386/trace-events |   1 +
>  3 files changed, 108 insertions(+), 62 deletions(-)
> 


