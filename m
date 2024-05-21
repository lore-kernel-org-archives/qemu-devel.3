Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D08C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PHg-0007s3-Vz; Tue, 21 May 2024 09:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHR-0007fZ-Vi
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:54 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHP-0001Zt-OH
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297107; x=1747833107;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=FnPgbHkC17ljlEVDc30FuyLZ9hqEYmiwbjpX/Fru8IU=;
 b=FRGxHm9Kw5wTtUaMQLEqgFz5BCkIXR/UFIV3pZ7qD/4ZP70lTkNX/HTK
 zHCCFt5YHGw6B1jrSP3kUvrPk+bQ/mEZDy18OZPYG+TYCalDxE6JwmVaO
 F+WTqrpA6CwO53pM902qcYDorlbDa3edRPYVFDDwfmbe3o3OkZSF4LtHr
 CM9HlbOFbMdE8ODYGfgdaeqACYAJuK8ShQA0qWXatpytGlGSTravo3Q09
 L+CpJIQEZkfBbE+DznN5eBB2wc7B9+y/m/AdYUxAkvYFZOYe92YkLP7yZ
 2px5ZaT+wHl2z7Q1ld48X9yA6udvLITCaIWIko3kDiRBCrfyG9jm2HE5i w==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13004102"
X-MGA-submission: =?us-ascii?q?MDEj2JkUrBop8uMRj8lln2EQXWm4iilFzeZHCW?=
 =?us-ascii?q?qi2Ec5ed9pENb8IOm190D4CPe/XIX+FzqNdi/F4r2HHbgOHUosMBO/nQ?=
 =?us-ascii?q?mDBwOLGz7hfS/ikR7orEuL1fN7gUT5sdN/e3BrV8Xwgc7Wwtjj8L8g9r?=
 =?us-ascii?q?36pOAYTx0/0qgrtmjWWylbCA=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:44 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lz795raY1HEtpDEbbQi7qbiKkS4ftilrRj2TLrPXucniVPHI94vBmjxplFu5+Mjs+XZgGq5Kjjg+PpWqM4uxFIfXPMmczTGOj+2zKVlNRoQoUj54IpcPpCPrSbNC1omsdrI8Mc99nzdJ5z5Qt9D8kYfO0AsV1PkJD8UKnkHRxZVIJxqzLCe/AjgbqLrTgd+5hd8ngnjrLqxL77iJm5Oqy3tx5NoAh20tenUFTzHu34tjdMrzMmYUeMB8Q2POj3hdfrwFnDiVEzxXVQJ2ar4k5dsdCBqrUU/f4dfk2fBws7uNdZKjS8RpWrmSxWnpmI44GpK7TIeoYLdZYgh/CLdrxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnPgbHkC17ljlEVDc30FuyLZ9hqEYmiwbjpX/Fru8IU=;
 b=LtkBgud/A77Enhf+OPAZM7hgCRlnKtZT5WR3l5UUdGUXIDGOVAJaVrT74xoNCQb/yvHgY4XyplAEs2J20eyKxSGD8iCTYf0Ii5jyyXK8DnZHybVmURA4FInZFS5g/cmg+qYg85Co1PXrnWjc+EZl8nONjHpgABZPVuXqzkugIFciv6gU98zO1gbaGFtKMDV40NDqzU0MxNd6z3X55G4btYfAzxLMMfIXQnrQsBnvx4MmwjV/1a9CijKznnsydX95t+drhy5xSMh7ofIVL7hjJES3q1nw9iSqn1Dzf/J5mpd0GRpnIeG8uQoicf7rPzYIGnnq6YhvE/kkofQQXNpicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB8148.eurprd07.prod.outlook.com (2603:10a6:20b:323::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 13:11:43 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:43 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 08/22] intel_iommu: declare supported PASID size
Thread-Topic: [PATCH ats_vtd 08/22] intel_iommu: declare supported PASID size
Thread-Index: AQHaq4Bs2yEvb1zyt0O4idZ0yyytdg==
Date: Tue, 21 May 2024 13:11:43 +0000
Message-ID: <20240521130946.117849-9-clement.mathieu--drif@eviden.com>
References: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB8148:EE_
x-ms-office365-filtering-correlation-id: d7b47cd2-a6f5-469a-cd0e-08dc79978f4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?OExvaEpzMEVZL3IwUU5JNHlTRm5vUnhSZHJySFVHSk43T3B6WkloRzcrTU12?=
 =?utf-8?B?UU1JbHpDaVlBR0ZuS2lBOXBEUDAwUSt0RDVZbW5FSkk4dnBtU3lUQk1DNnlk?=
 =?utf-8?B?SzZFb1lJR0crbWc0ak5DczNqTUNwNnFiMWJwdGFTQmpISUNqWGtncWdZQlV1?=
 =?utf-8?B?SFVpODRYUmxBYXErRGRFYnJSWmJuVTNrTUltYy83bUFLMGsrRTlqQnIzSGtp?=
 =?utf-8?B?WGs3eFpWb0luc1E1dWduUlIwQ3JnWHkrNWdBMVcxQk1oUXFONUkrY2pvWmsx?=
 =?utf-8?B?LzNEelIxUWZvK2lVTVlXV0ZZRGdtN2ZBTmZqVzFTdTBpWCs5NWFqVWhDTDNl?=
 =?utf-8?B?RC80Y21ZTTJMWXlaQ1JXSVJPSlNUc21vMmJvL2F2d01LcTJnOWVZdWpJQ1VX?=
 =?utf-8?B?YjVneWlrSDZJUGVhTS9STVZ4bU1GSVpUZFo2UWVCZnRTdmFGRXFNci9xUHkw?=
 =?utf-8?B?QW9wNVpRdUg5U1N3Y3pVc1BPSC9ZazU1Vjh3NFIyTkt1UmdXUklmT3I5S1V3?=
 =?utf-8?B?SElpYVk3S3RVWE8zYUpNMnRMTW53T3pHdG42SGtLdjkyNFBIUkNHQXhGKzBa?=
 =?utf-8?B?QytTOG5tMVlYNnRRQ2xCeFF0STNSZlI0UFFQV2ZxVHFhbGR5RGRaUnoyK040?=
 =?utf-8?B?SWxDajR6a29PNzdLWTdMMThIcURMcFlKU2xLTGYyUjVXZGZadi92d1FGZ3k5?=
 =?utf-8?B?UUY2aWlrdTlGbkJaRysxUDFhZGtDQktKRU9xZHk3dmRCdW1Uam1Ra0NaMmFm?=
 =?utf-8?B?SU1rVVhaNjN4YXdMT0FNam1Rak5ZS1RlSlJNUUp3ckFvU3djQzI3SjAwQ2FD?=
 =?utf-8?B?RGo2aldvTXRhSklEZnVrS3dhdkYzZ3dKc21iYUVxUVh6am41anlLTjJjR2Vq?=
 =?utf-8?B?d3djY0hweWdVNmQ5Sms3blh6bEZPV2R3YU42WlVPcVB4YTAvZytSUEJWdWJ1?=
 =?utf-8?B?OTN3bGdMK2Evb2xDZjZIQXBzMS81dU5Qb1hmUElvQUhPekZiL09icDVvaCti?=
 =?utf-8?B?aVY1NWQ1dXd6YXhZeDkyeGd5MWtIbmpyWVZwYjRmK1hQQ3htb3dPOFhtbmUy?=
 =?utf-8?B?K3ZPaWx4WGUycGRyL3RUMkJDL05vaWpjTkJLVWpTeTB2ZXdmTEprR1FaZTc0?=
 =?utf-8?B?aUpBMHZyUVFKMzhmT21wRE9XZ1lpaytYQVRMeS8wOWgzazg0YVNvcGRZTDdT?=
 =?utf-8?B?TUp6L1V4Q3RqSUJRM0pEOUhMb0JOZGdEWmhwd1pVUm1rY0pkUFNobWRmdjRv?=
 =?utf-8?B?MDZrbW9VdllWbXJXQSsxSW5rRjhvb3hFZzh1am0xOEZFVDNCMi92Y3hmaFFR?=
 =?utf-8?B?NDBhajQ3K0dEVHdLSlRLSThIRjZLSTVFRmU5U2JteDF6aTN2NENGL2R6WmVk?=
 =?utf-8?B?RlpHeXlRVEJMenN1WWlkeGM5NElGcjBQOW83M2lKOE5QZ0IxSXU0T21DeEJO?=
 =?utf-8?B?WWtrUFJlR1hOdEtoeG9vQ0JMWmp4dmxPVC9MK1o2QUN4UUEyNzZGdmlETXQ1?=
 =?utf-8?B?YUpKVGNmQVRYcXhxQlBTa0prNElXY3RTYXFHSGpqK2FHNEMrVmdtUFNLSXNh?=
 =?utf-8?B?SDJZZjFYdFh4UktIRmdnL3oyN0NwdmdSR21Tb0o1MEJ2TDVGM2pIVW9ES3hj?=
 =?utf-8?B?NW05OWVPVUVlWC9IOTYraFZzRnF2ZmNKcjNqTG1Sb1VnakxydHA4ZWQrMVI0?=
 =?utf-8?B?RU55WXdkS1pELzd4SW5PVmVHMkh0OStxdzVFYzA4VkhHQW1pdWZjZ3NsaVBv?=
 =?utf-8?B?aExEaWhVTEdoUU53UVY4ZTl0dzhuVWd1NzdGYlJtSXJMWVpmSkFnL1VkRy9T?=
 =?utf-8?B?TE0xbXZmd0hEU0ZNamRldz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3FJNWJTbnJqQjJtMG9jVnZ0Q1IvVHlzSVRScjRBeGp3c1ptSEVLVkxaSVQv?=
 =?utf-8?B?c2JZb2N1c09kZXRJU1JGbUQzdE9ueXRkK0dVV3JFNTlXdFJoY3pnNytEUzhB?=
 =?utf-8?B?UUdicEc1d2FmZ0ZGakdlZVNNckttTXpzRTNaL2lIcWtKeFprM3JwZTNMVXQ2?=
 =?utf-8?B?KzkvM2hvaGdGTlZ4WHJtbWtlV2gvUWl6YWhGdnlMRjFvUkNEd0IrV3U4bE1G?=
 =?utf-8?B?SjdFY3VXa3REWEsvalViZ0JNRGs4QUFlZ1EvWll6Q0hSalp5dWtvUkdCZ2lI?=
 =?utf-8?B?ckNxbWxDQ1ZKekdmMW9JMWZCUXp6NHFVNk8rNkhjbkhuZTFrc21VZVBWbXJ1?=
 =?utf-8?B?SllXMlJ2SXREWEltOU55SFVRMDVqWVVvemI3eUY0RHVGSGFudlBjc0d0OWdJ?=
 =?utf-8?B?MTJ4eW9kTEltNW02WmY2VTlqR0ZNTjMrRXhzYWUwNDdFRFF2UXZTWjJ5SFFz?=
 =?utf-8?B?R1FPRm05UzlPcWRqd3FkWkRCOHpPWUZOdjc4c0dibkt6YTVRdXVGQytQNDhO?=
 =?utf-8?B?QjJuVUZZTGdqcm1tVjFxcVZjak5wWFAyR05laG9lVFE3MHkwQ05PTWRvMEI4?=
 =?utf-8?B?VEhQMTFMQVBBQ2dFS29zMnQxV0h3RnMzdThYODdVZk1DUk9sdzZ5WVFZa0tU?=
 =?utf-8?B?VFpnc2U0c2F2L2V2ZEV5c2h3WDgveGFuamxWb3U1VmczUmczWjBNbG96Z1d5?=
 =?utf-8?B?RHE4aDl2Vnlnbk5vakRYcVJkLzhuM2JMYWhrUW9vOTNGdnlEZGJKK0tmVkgy?=
 =?utf-8?B?eHdoOVJ1djB3d0d4VlowQ0tyOHZ1cUVtb29SWkl3b1VOSFpEck42Zy83V2tY?=
 =?utf-8?B?d2w2Q0J4NUUvcVhFNGlZVUp4RytZV0NXc2xZbERudXpVK1pPRk95cDRHVThi?=
 =?utf-8?B?RzZ6eEIzU2pDOXB4UWQvVTJpTDdZUkQ1OFF3dlF0UTkvalNENFYzZkNIdWRN?=
 =?utf-8?B?WGpZKzQ4TUZsdnVLamNNV3l4SlYwMitHMTNMYTU4VS9yWVdJL3poQjQ2Slda?=
 =?utf-8?B?MXlveUhWcXV3aEpkV2hoTTFEU0kwbHR2SmhKdFVVaEFUb1VrNjFqMjRjK3JQ?=
 =?utf-8?B?dUNPSnpEM2Irem1QT1RwSUNDMEhtTjNUMmVOVDRzZExRK280c0kxc1ZSaHdh?=
 =?utf-8?B?MkNnVGRvbXFQalllVXFMQW0zdUVzU2FoMmZSMkpjMnJ0VzM0Y1hnZnZkWHR6?=
 =?utf-8?B?ZVYybjJGMGVZTGlSUk5rTjNWLzRNem9Zc2M1OFcya21FREt6U2NvRHptZlda?=
 =?utf-8?B?Z0JhcTBjNldZdG5IUW5PbXFDWU5yVkExQWtPYXNJcnZUMTdkT3V4ZFdkZ2ow?=
 =?utf-8?B?TVRwK0VGNHJ1WThsMzhvNEFjMVhPRE1FN2VJSWVZbElISkFib3FIckllY3NI?=
 =?utf-8?B?MGE2Q1hnS1piMlBtK0EzUFgwZ0hZVTl2Ym1xVmZzVWRGNi9EM0V6bGVZazVh?=
 =?utf-8?B?ZW56WUkyYklEUHFnVzI3UGxlWDVFQ3FScHd6UFZIMFZmMmU1bmNwclVTdXhY?=
 =?utf-8?B?b0lWM2krcjVaem5iY0p3ZTR3TDdmZ0cwK2tjSlNDWlNiempHK3hDV201TzV5?=
 =?utf-8?B?WHpPNGpwQjlUV01SQUYxSTZiclR2SG1mT213cis3NXVXYzBmOU0wQ1YzTTQx?=
 =?utf-8?B?ZlJaanBQRzFpcW5sZG9oMTdIS2JMUlFhbHEzOE02VUFrc0wrdFNFM3I0V1dz?=
 =?utf-8?B?eWFaRXdpTHpmZzdTRTR4ZHZzV1BTNlpXWDdUL0hCR2FwOTdlb0MrV0ZzY21y?=
 =?utf-8?B?VXBSQmcyS0ltZzN1RFRSZ1ZXc3RuMlk5dkRWejFDc2EwcHV0K2ZmckJ1QVNy?=
 =?utf-8?B?enE0VWZubVNzZXdxNGx0VGlJUFRZMjllekVVTmhEN1B5MmxuVXBSa2JVei9U?=
 =?utf-8?B?b3NsU1hZaGNKbXI5WGtKQ1lqa2h0OFl2UkFHUHlKZkhSZW93dnRlaHVYdm82?=
 =?utf-8?B?cDh5bGJ1eWJHUnlHZlM5bWk3UDYzdFAzM3pyNVZSOEpmd0puZ1hLR0RYdlNv?=
 =?utf-8?B?RmZlYUNkOHcxMFJSdzNVdTdselR5eGpKQ3pPNWFteUNBeStFMDBiTTZ5WDJr?=
 =?utf-8?B?M0t3UVhIVU9mS05sNnNwSmlubHk2Q1ZIVUozSWg5Q1l1cHVSS0Izd1FpVldX?=
 =?utf-8?B?Y2hMMDFQaHZEUkM3YW9ZZ1lZZ3JmZlNld1ZqdXVONUwxczk1cHJDLzRySzFk?=
 =?utf-8?Q?3GfI0g+iIhv0RLwwKjqomuA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CE2E44260B3C64CA8DD1EFE3E8F669D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b47cd2-a6f5-469a-cd0e-08dc79978f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:43.0530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYq8OjzzHSyK12DNRmdq/b5vKWXxCJj0ECHFtMXea4YQbRfpCBVl3g1ndGlmKsw5+BLC3CltOKj0zXeVAwlgQFM7XQj8nBOSvtH4aik7q2Uqmjn1zSJRC7bFYYu9exfK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8148
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCAy
ICstDQogaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgMSArDQogMiBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggZjcxYzA0ZDM3
MC4uN2Q4NmEzMWJlYSAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpAQCAtNTgzOCw3ICs1ODM4LDcgQEAgc3RhdGljIHZvaWQg
dnRkX2NhcF9pbml0KEludGVsSU9NTVVTdGF0ZSAqcykNCiAgICAgfQ0KIA0KICAgICBpZiAocy0+
cGFzaWQpIHsNCi0gICAgICAgIHMtPmVjYXAgfD0gVlREX0VDQVBfUEFTSUQ7DQorICAgICAgICBz
LT5lY2FwIHw9IFZURF9FQ0FQX1BBU0lEIHwgVlREX0VDQVBfUFNTOw0KICAgICB9DQogfQ0KIA0K
ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaA0KaW5kZXggYzlhNjczNTg1Zi4uMWIwZDg5NThhZCAxMDA2NDQN
Ci0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdV9pbnRlcm5hbC5oDQpAQCAtMTk0LDYgKzE5NCw3IEBADQogI2RlZmluZSBWVERfRUNB
UF9NSE1WICAgICAgICAgICAgICAgKDE1VUxMIDw8IDIwKQ0KICNkZWZpbmUgVlREX0VDQVBfTkVT
VCAgICAgICAgICAgICAgICgxVUxMIDw8IDI2KQ0KICNkZWZpbmUgVlREX0VDQVBfU1JTICAgICAg
ICAgICAgICAgICgxVUxMIDw8IDMxKQ0KKyNkZWZpbmUgVlREX0VDQVBfUFNTICAgICAgICAgICAg
ICAgICgxOVVMTCA8PCAzNSkNCiAjZGVmaW5lIFZURF9FQ0FQX1BBU0lEICAgICAgICAgICAgICAo
MVVMTCA8PCA0MCkNCiAjZGVmaW5lIFZURF9FQ0FQX1NNVFMgICAgICAgICAgICAgICAoMVVMTCA8
PCA0MykNCiAjZGVmaW5lIFZURF9FQ0FQX1NMVFMgICAgICAgICAgICAgICAoMVVMTCA8PCA0NikN
Ci0tIA0KMi40NC4wDQo=

