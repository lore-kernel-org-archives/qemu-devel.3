Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB10D49C69
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 07:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlj6x-0006H7-JY; Fri, 30 Jan 2026 02:40:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vlj6w-0006GT-6T
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 02:40:10 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vlj6t-0003d1-Km
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 02:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1769758808; x=1801294808;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=F1E70zMnmdfQg4wdif13aicJiMIKo5bH70ZsBW/Tfjc=;
 b=V/Pb44L/ZWPZj06aOWXXtHvwf/q78KBS+J19Jjr0BYqHJAhpRS2+NY7j
 O0HtXQXOPwg4TWXpRkIFGdWfX/U2kneFH5Id3syLnfTDz6Rvhdv7tLbV2
 urm93N+So0U2rOy8ZGP6P6QM9qorBqfbcGLMdBntY+hQcrQ38TvvyBfNI
 mnrj2bZrROCtwC8QoyGs46pXj9n8qvl0Hj3TltW1v3zyU7yabxM65P6Di
 UMQsoSMfAfKsgbJeJ7ixWBKWwnxnMR+hjkQ+M8ycDgB7iCH7YGJ2Ou43K
 rwdBR81a3DGV4o/uCMZ0R/0QNCbFI6aLuCAqpIAzLyfVVuTbJ83lNH/gM Q==;
X-CSE-ConnectionGUID: 0coAiokOQn2o53oSaMDymA==
X-CSE-MsgGUID: vTObUZjSSU6HW2bQHkyUbQ==
X-IronPort-AV: E=Sophos;i="6.21,262,1763420400"; d="scan'208";a="48236292"
X-MGA-submission: =?us-ascii?q?MDFGSV/JOpC/RCdllmZ8h3S2gVgYz8ef9vB2ft?=
 =?us-ascii?q?hzX8OVINdfue75TWfPbkbaVI0bDHMM+AAErC/7MyU/ImlslBbEQ52ZrT?=
 =?us-ascii?q?HtU5RrDCbw5lDx4s3/sH3tD7W+m4+gFJ4ozywHHkyunvfBrEPOnCaAAw?=
 =?us-ascii?q?bhUSBtGxM+nlchEgb0aCpt6g=3D=3D?=
Received: from mail-westeuropeazon11013039.outbound.protection.outlook.com
 (HELO AM0PR02CU008.outbound.protection.outlook.com) ([52.101.72.39])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 30 Jan 2026 08:40:02 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SN4VlTdIM0BU6tfDyJx9d5FMXHoddjYst5BAhc2jukwgnedG4G+zb8P/KwnjGFGTGVSSrYa4k6Fk46YX3NQ+91X/43BKaYi67nKKINCMxaoSpJ22wSQxlzs8+tozxaNuKNh3qrqHmuJN9BK8OfmTxkxMKUlhebUajP7NPk2hMbGt9yBW93U+R1+gjRkF6hp9sZvYiKDi9v0UwMM5HAgZzDMNEYmV41mt7MnlxmOgo8W8cBL/dI95Ii59hgtAoIeyHMadT8rUe8uFo/LtFdhXQBLLQYxlznQidEIIWL+QK+yp56LblPl05rzX00p7PqjKBqEGSJ0Yno0otSllRmX3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1E70zMnmdfQg4wdif13aicJiMIKo5bH70ZsBW/Tfjc=;
 b=NebI7pxkqGy2xMF5b9+iLpN799SLvbWjdO39zMtpIBNdrgEiSBR2/OSyfk875VtIT75JzQA5U8QILuWvI4wH460O4AjfUTKcDzAeYHSX6iuFXW/rK46FVVNeBgdMdKXG8ZYOqSJA10357jcB3qFnAnG0urC3oGGibCkPWS6MaOKdudS3no6+f9uH5wesOxJGJMm+NnnEFIdojB4G6GHQ7hQlSlyj7/BIpSDYTx+3Y/jSZSYNrr9xiTbjV20R2vwGDKq3BqUhHrYD/VeEYQUvtQ0JSLM9NBFW6v/jVQpOOige3wpaFZRqehlTqCiqr8SGa7wLw4KfFPHSZmX/PQoTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1E70zMnmdfQg4wdif13aicJiMIKo5bH70ZsBW/Tfjc=;
 b=YQeQMKBq0/d9rRzcPHovKj1jfoYo/4vgwtYcOpgYyFLZO0NNKqVS4ia/1u1we0236QqjkEjjF1sgBF2N1SI7oAIB3Cgrjo0sKxAaMFQoGpEXO6paoobAMjJia38uT4+svDkPHKnHvA6d2lSW0r2cFhSJt0kOw8nTZKoCPyBa/ci/joQssuk7cbZJkphZqfXIwSicb/W66vg86rzWt4Dhb3kJYfX/U/ghA4L9rDdpkfY+PILIIGqDugiGNljwOSs+vpXY4i3izh6BWj9V8Ey+JsU78yFAQ8/u2ZEFbZP5zkFFqoL5MurCpW4xhQGFA1Llwcq+C66xJcVQx8kZRH5dNQ==
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com (2603:10a6:102:c0::19)
 by GV2PR07MB10531.eurprd07.prod.outlook.com (2603:10a6:150:2a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 07:39:57 +0000
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::2277:7f64:468a:9393]) by PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::2277:7f64:468a:9393%6]) with mapi id 15.20.9542.010; Fri, 30 Jan 2026
 07:39:57 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Sairaj Kodilkar <sarunkod@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alejandro.j.jimenez@oracle.com" <alejandro.j.jimenez@oracle.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: Re: [PATCH v2 1/3] amd_iommu: Use switch case to determine mmio
 register name
Thread-Topic: [PATCH v2 1/3] amd_iommu: Use switch case to determine mmio
 register name
Thread-Index: AQHckbuhwnACAUD54k+BDa8L4HO0jg==
Date: Fri, 30 Jan 2026 07:39:57 +0000
Message-ID: <85c7506f677e3a9145eb8be2212ee62c0b92169e.camel@eviden.com>
References: <20260129102814.4488-1-sarunkod@amd.com>
 <20260129102814.4488-2-sarunkod@amd.com>
In-Reply-To: <20260129102814.4488-2-sarunkod@amd.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7613:EE_|GV2PR07MB10531:EE_
x-ms-office365-filtering-correlation-id: 05021558-73b3-42b0-3c67-08de5fd2c487
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?Y0ppc3FMelYydzRYYW5FZlRHZ0pib1laWTZHdk80dm1lelFwTWxXRTBXdVpJ?=
 =?utf-8?B?Q2VSOHJRY1F0TUw2aCt4VkJwTEw1SG5KQXRoQjRIMDBKdjhnSFdBTE5zRnEr?=
 =?utf-8?B?ejY2NFNOY0d2Mkt6TTFyQUhqMXBFVkErMDA2Yk81aVdUZ000SnlyMTNpVUZu?=
 =?utf-8?B?MXFza3N3dUtKWE9MUENhNkswMW43cHJyWVZjRkZkaXZCNGI2TGkvUXQrSTNK?=
 =?utf-8?B?MnNPb3FDSVV2YmdCUHlyZS9rV2NRQ1Boa1FGTElGZ0ZYSVd6YU5nZEVJd1g0?=
 =?utf-8?B?czVpYmk5TW9zK3VPUlhLV1MwaVI5dXAyYzFiK3VHbWlOeU9WQTBsLzZpa0Zh?=
 =?utf-8?B?WlJPbnNkMmwrTzNHYUxIc05WVE10ME9YejVobTZHQXpCV1pLUUZIaE9ZVno5?=
 =?utf-8?B?YlVwR01iT2MrdnloK2ZhTmNLdzU0VVJKN3NLaUpLRjlFV2hmRHUyZ2w5d09O?=
 =?utf-8?B?bXpIVG9vSlZkNGQ3N3dHdU0rQUZmK0Z6cXgvYjh5NlErWVJ6N1ZjVzlXL3Rk?=
 =?utf-8?B?QWhUS2hkTlBmaVFxKzRNbHMvZXhpK3A5WXNLdjIweVVWWDNhMThpZWJBRUt2?=
 =?utf-8?B?anVCVU8zdVl1bXpxUDRDWlh4VzV1QnFCQVRYZitPc1dWOUUzQWMvNkVKSURC?=
 =?utf-8?B?MnU4RktpdWdWaFN6bGEveThrY3JJd3dRYlVyejdIK2dQcGRzeHlzK1FiWTB2?=
 =?utf-8?B?RGk0ZzNiM3VFMEpROVRwWFEvNWNZUVBZaStsSUljWUxXeEJGemxzY0lrWUtV?=
 =?utf-8?B?UVA4eGs0YWRyMEdBNEVEQXlUUkNEdFJybzR1ck1BYTRGRktMbjdUdUNRQ0Vk?=
 =?utf-8?B?SWkwTElCSytxZ2VSelNVWGZheUN0RjlCQlBCUXFyTkhiQjJjK3VwZER3eEJu?=
 =?utf-8?B?SDhZOWVWT2hnTFk1azV2RVRCblJjdXlHbGVoZVRGaThLeXUxMWFxb3A0aTVG?=
 =?utf-8?B?cE4ySFNXbm1YRWJ1WWV2ZEE4djM0Qk1VdDVHR2t5TUM2NEdHejdrbjhCbVhn?=
 =?utf-8?B?YW1xMzNXWnFDeFcyMU5OM3JEa1VaL3pIazViMW5CT2doSDM0ZHZOMG9MN3pq?=
 =?utf-8?B?VmhJRGIwWEZkVmhUZHRkU01aallNdG50YjdDY1lUTWJOMUlWQnBEd09sNmRv?=
 =?utf-8?B?U21UbkVtM3R4TnVHSk5ZUFVlWHYxQS9jaFhMVHc1alFEVEswNTU2elQrME5O?=
 =?utf-8?B?blhTTVFZYURNN2k3WTNuTnZxa2lIc09Nb0VjOXNWTHZjUmxZYm5zYVZNRE5s?=
 =?utf-8?B?dnZzWGRvT0VDSEdJdHl4SzVaU1BEMDVXZnhkTmM3a09yZk9WVS9LaTZPSTdl?=
 =?utf-8?B?Uk9xMXJ2MmRqR3dXZExyN1R1M1JHcVg3OUVGRE1QVEh6eW9ucE5LOUQ2LzBn?=
 =?utf-8?B?RWt5dnkwV05ZeTBLaWhKZWoraDBXSFpPQ1NTYU9UU203alQ0SVIyUWdlSTNQ?=
 =?utf-8?B?eUtUejUwS2tlRlpNUjd4Y095Q1BrcFBHbVVpUHlSek1MMXBLWWc1SlZKWi9m?=
 =?utf-8?B?eE1yRUpoMXZRVWt6dnU1MlRKK3R4SUROejJmT1JKUm5kdUI2aTNjSEhPOUpV?=
 =?utf-8?B?aE5QTjVUNFlCZlRDRFo4QXFQbzFKWk1Malc3c0tISXhEblk1TVE4V1U0NElE?=
 =?utf-8?B?YW5JQUp0QkViY0Z4VC9ZZFZaNzJxOHplRVVjWm0zaEY5MGRxZHpTbEdBQnQ4?=
 =?utf-8?B?UDBNS2FTTTVodWR6R3dTbzJ0Um8xaUYrUWZ6TDBTOG81RXhVaDNma1NTQWha?=
 =?utf-8?B?bXQvNGdHN3ZnQlZBUlNzb0Mvak1BalRuN1gvM0lMTVRLaDZ4Tnp0WktUbkd4?=
 =?utf-8?B?OU5pejZMcTRjRURvUkF4NXl6VzB3K0Nkc2hKTS82Tm5PNUxSNXFpdGswcTMy?=
 =?utf-8?B?cE1BS0R2SkVlbExHNmZ6YkZyVDRFWk51b3lJcysrZU95Rzd1UEhMVHRHOCt2?=
 =?utf-8?B?MWx4bHprdVBrTjBpQjk2ZmZiMXdXK25VaVJzZzQ2elorRmNLTllNN2RzVjIz?=
 =?utf-8?B?T0x6ZmJicmZwVFQ0ZDN1bmZYc1FaeEV5TThweTVORjVOb1pjRFZwbzBKV3A4?=
 =?utf-8?B?Snk0ZzBwZnRqS0tFdTE3U0d6WURkbVlYSTA5T0NkaC92bEkybWJ4MkZLNVJM?=
 =?utf-8?B?dGJEOWFLUER4TzlSS1pJUjB0UmdYeE96ckNBbXlwZ2hXSUt5WXZ6aU5xNmdF?=
 =?utf-8?Q?2r+bUiM/0INAms2Yz4mxOV0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7613.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWRucDhmcUk5V1NmcHJDL05mUGFxMWcxU0tOU3hMRGxHSFNCTGQrVzN6ZERN?=
 =?utf-8?B?bzF2Tm1DQ2crMXFITUJyT2d2Qm8yV0dVNEpqSHd5NkZHOTJmR1kzL2tZNXdt?=
 =?utf-8?B?RzlicnR4bklhN2Fhc0p0ZVlySExDRDQyTExjKzJkamV2Y3dVS0ZBbjk0Y1lT?=
 =?utf-8?B?ZWQxWGVLVWVwbWpqMlVFN1hRS1JmN3RZZkxqL3JGYW5qOU9GaU9xUFBPUHBX?=
 =?utf-8?B?VUI1a3hUTnRxOUQxV1JSZjBqWmJOVndlaFZpQ1N1eUlxdzBTcjQ3eE8rb1FL?=
 =?utf-8?B?YzNTWXJyL2NnT2VpWER1dXpGdVVmWmY4RXp5ZXZseXc1WXZSaS9tUFRkcFRu?=
 =?utf-8?B?VmIrOWt5SEk1SFEwVlRDN2toS0tIeEh2L1Vrd1lUT2hHS0N5ZzFIbXUxVFh1?=
 =?utf-8?B?VCtCQzl3Y2dqOCtJeGdZdkFGeWlaU2xialRZOUliMmNWS0pDWXZpemJscS93?=
 =?utf-8?B?U3Jmbk9IeWNUNmtacllIZUxCSlNyMmpHZ3NZU2tkWTQ5Y0pkTk5XZUVwQkJa?=
 =?utf-8?B?aXlnbTFPTlZCUHVkeFpmY1gxY01ZZno2azQzbHc0OWpOblZBMTk4S1d3QzI5?=
 =?utf-8?B?TVlCODBaei9ST3c3eitKdE0xUW4vcGpFbGlqMlBlNDlCYkxYejNCeFJFTFhJ?=
 =?utf-8?B?SFFFOHZTaWdtMzNKZ1FSNXFUZUtIUzlKRTdEUllmYjIxRExaOEpvSG9NeGNH?=
 =?utf-8?B?aVVsV054d0hLN1huRzZGM3VBTWlOSTMrOWZ5Y3N1dEFEVi9JOVlSZTZBbGdx?=
 =?utf-8?B?ZnlCdnlQWndzc0pQbDlaQjl5enNqWmNGNzNyYTZDODAzbm9kWHIwdWcreDdT?=
 =?utf-8?B?dk5pTG13MHlNN2FPbDVlK05yNmpaUk1HZXhJZGtWNTJNRzBidXVlbzR1Q0c1?=
 =?utf-8?B?VDZsNysxakZ1SVRJQ3J2bWs3R3p3SUdYUjUxM01oYW9XMjU0Y2R1UWRrK2Rq?=
 =?utf-8?B?UTFxYjA1b0N1bytHdUNSTGdjQ1h1dU5JRGJWalRHdzNmKzd4QXA5OVJvOUhh?=
 =?utf-8?B?QTcwaG5FU2s5QW5qdnJWUTZ5c3d6SEdCTjJjcG9GUXFvSTFtOXBwWEJkanM2?=
 =?utf-8?B?UzVMZjhHdnk2azFEOGV2TW94UTVOaDd6NjhyUDk2NmdsQmRCUEdtUWFDcjJj?=
 =?utf-8?B?eW1SdnBSdFh3VnNQbFhxNTAzNTMyUVE1akdyM0hIMkY0Ti81SDBhL2pKU2V4?=
 =?utf-8?B?UHJ6aDRmSk1DWnRudE1GczRSQVc0NS9vRHhmbjBFQkxSZzN5b0w3VS9YWkEy?=
 =?utf-8?B?OWpNWVhwRkJ1b05YK0hNYWVmZVppV2svdVdRMmcvQ1YvVDNaTmk4UmsxRlE4?=
 =?utf-8?B?TXUvb2Rkamhxa0lLd3Y3WHZYOVZBYzNDQnpGak5GbEhVRHliSFZHaVA3bGRn?=
 =?utf-8?B?U0RldHVxazZjemNWWjB2UndoREZRWURtNXQwVlpZMXRiQ3pLK3A1TGRweFNa?=
 =?utf-8?B?N2NONTRhc3FUNng0VUF6dDBtTHZ5UEo5bHB2RElxYlUvKzEvc3I0VEtkUCsv?=
 =?utf-8?B?OElaL3NERVJ6ZFVuYlFGN1VQMHJ4T0pPUm0xRFJZUk5PekhsWnF6emJqK05J?=
 =?utf-8?B?bGZSdVc3TGZseUFtdTJlV294VGZaNWdxeWpKWlFtOU90cytFZnR0SDJINzE0?=
 =?utf-8?B?NVdSeEtxb2xhbVpkS044ekZIbXVpRklKbzFGUTR5NiswRVNNMzVSOXhZbDZQ?=
 =?utf-8?B?OWd2dm9uaFN6c2dDYys5VEk5Wm5EM0lPMDdLb3oyM3NHVkJuRW5aNnU2RFdZ?=
 =?utf-8?B?N3I3YTV6R3FtMUJ2VGdHU1lNWVVkYWYxU3N5c21WMi9CeTl3MTNXRFNIa1Ra?=
 =?utf-8?B?M2RsNWVKZjR0K0JTVytCWGF6LzdUK0N4SnhPWnF0cUxlbC9MM09MNHNvei8r?=
 =?utf-8?B?aHU5TzRBdXJPWGNkZEl2Znd1VUdDZW0rU0dxUkk5anY0ck9sU2ZtRFNhT0ZY?=
 =?utf-8?B?U2crWUJDb1N1Yk9ieVk1U2FUMVRibzdZNlZOY3djUm5ZKzNzclowaW0xZ29s?=
 =?utf-8?B?SnBCa1k2d3VtM3dNWkFjQ25lQ3pjU05GcU5Hczh6aHQxd3EvSlpvK0FGQWU2?=
 =?utf-8?B?SlhYTk9NaWliWVFaT1M1Mm8wb0ZXc3E5VjkwTkxkVXVXMEFpdGhmQWFCdG9w?=
 =?utf-8?B?Qm1NZ3ZVVVlya3dVSDJ3NzVzUzgxQmhmYkRKeE1YVXNXR1V1ajF4Q3h3NytN?=
 =?utf-8?B?Tk9mT1BiUTBrZzVhbjRzclBic3J0RFJBVGNNU0IvVGRFSXVOTy9VL3BlbVVa?=
 =?utf-8?B?NU1ESDBpd3JWdkxGamV6cHFRZnYvUFJVRk9kbXNaMzExMnJuV2ZkdlMzYjVo?=
 =?utf-8?B?VURKU3MwTkJ1bHJINi9iZHRyRjBrWk5nWUxmckRMbkZNeHdBdVdCNk41Tktz?=
 =?utf-8?Q?Nb94KYc0ItQGB9GZ0xFetPbiZif+ahmNeWQZH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DA4C018094C694C92FA15AEC7E1F85B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7613.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05021558-73b3-42b0-3c67-08de5fd2c487
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 07:39:57.7707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S5Hy2pxJBrwFwT3Laebd/uocev5FJb1CsPRcJ1t40V6glWZ3wpSdu75F/zVARZ+aOVX8bTnzTpDJAYXoiftk7cIEV9aiAlZxXNiamIsg+B6zk8zGPnrZ0DQa3pCWARd4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB10531
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIFRodSwgMjAyNi0wMS0yOSBhdCAxNTo1OCArMDUzMCwgU2FpcmFqIEtvZGlsa2FyIHdy
b3RlOg0KPiBUaGlzIG1ha2VzIGl0IGVhc2llciB0byBhZGQgbmV3IE1NSU8gcmVnaXN0ZXJzIGZv
ciB0cmFjaW5nIGFuZCByZW1vdmVzICANCj4gdGhlIHVubmVjZXNzYXJ5IGNvbXBsZXhpdHkgaW50
cm9kdWNlZCBieSBhbWR2aV9tbWlvXyhsb3cvaGlnaCkgYXJyYXkuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBTYWlyYWogS29kaWxrYXIgPFtzYXJ1bmtvZEBhbWQuY29tXShtYWlsdG86c2FydW5rb2RA
YW1kLmNvbSk+ICANCj4gUmV2aWV3ZWQtYnk6IFZhc2FudCBIZWdkZSA8W3Zhc2FudC5oZWdkZUBh
bWQuY29tXShtYWlsdG86dmFzYW50LmhlZ2RlQGFtZC5jb20pPiAgDQo+IC0tLSAgDQo+IMKgaHcv
aTM4Ni9hbWRfaW9tbXUuYyB8IDY1ICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSAgDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDM4IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvYW1kX2lvbW11LmMgYi9ody9p
Mzg2L2FtZF9pb21tdS5jICANCj4gaW5kZXggNzg5ZTA5ZDZmMmJjLi42MjE3NWNjMzY2YWMgMTAw
NjQ0ICANCj4gLS0tIGEvaHcvaTM4Ni9hbWRfaW9tbXUuYyAgDQo+ICsrKyBiL2h3L2kzODYvYW1k
X2lvbW11LmMgIA0KPiBAQCAtMzUsMjggKzM1LDcgQEAgIA0KPiDCoCNpbmNsdWRlICJrdm0va3Zt
X2kzODYuaCIgIA0KPiDCoCNpbmNsdWRlICJxZW11L2lvdmEtdHJlZS5oIiAgDQo+IMKgICANCj4g
LS8qIHVzZWQgQU1ELVZpIE1NSU8gcmVnaXN0ZXJzICovICANCj4gLWNvbnN0IGNoYXIgKmFtZHZp
X21taW9fbG93W10gPSB7ICANCj4gLcKgwqDCoCAiQU1EVklfTU1JT19ERVZUQUJfQkFTRSIsICAN
Cj4gLcKgwqDCoCAiQU1EVklfTU1JT19DTURCVUZfQkFTRSIsICANCj4gLcKgwqDCoCAiQU1EVklf
TU1JT19FVlRMT0dfQkFTRSIsICANCj4gLcKgwqDCoCAiQU1EVklfTU1JT19DT05UUk9MIiwgIA0K
PiAtwqDCoMKgICJBTURWSV9NTUlPX0VYQ0xfQkFTRSIsICANCj4gLcKgwqDCoCAiQU1EVklfTU1J
T19FWENMX0xJTUlUIiwgIA0KPiAtwqDCoMKgICJBTURWSV9NTUlPX0VYVF9GRUFUVVJFUyIsICAN
Cj4gLcKgwqDCoCAiQU1EVklfTU1JT19QUFJfQkFTRSIsICANCj4gLcKgwqDCoCAiVU5IQU5ETEVE
IiAgDQo+IC19OyAgDQo+IC1jb25zdCBjaGFyICphbWR2aV9tbWlvX2hpZ2hbXSA9IHsgIA0KPiAt
wqDCoMKgICJBTURWSV9NTUlPX0NPTU1BTkRfSEVBRCIsICANCj4gLcKgwqDCoCAiQU1EVklfTU1J
T19DT01NQU5EX1RBSUwiLCAgDQo+IC3CoMKgwqAgIkFNRFZJX01NSU9fRVZUTE9HX0hFQUQiLCAg
DQo+IC3CoMKgwqAgIkFNRFZJX01NSU9fRVZUTE9HX1RBSUwiLCAgDQo+IC3CoMKgwqAgIkFNRFZJ
X01NSU9fU1RBVFVTIiwgIA0KPiAtwqDCoMKgICJBTURWSV9NTUlPX1BQUl9IRUFEIiwgIA0KPiAt
wqDCoMKgICJBTURWSV9NTUlPX1BQUl9UQUlMIiwgIA0KPiAtwqDCoMKgICJVTkhBTkRMRUQiICAN
Cj4gLX07ICANCj4gKyNkZWZpbmUgTU1JT19SRUdfVE9fU1RSSU5HKG1taW9fcmVnKSBjYXNlIG1t
aW9fcmVnOiByZXR1cm4gI21taW9fcmVnICANCg0KSGkgU2FpcmFqLA0KDQpTaG91bGRuJ3Qgd2Ug
ZGVmaW5lIHRoaXMgaW5zaWRlIHRoZSBtbWlvX2dldF9uYW1lIGZ1bmN0aW9uIGFuZCB1bmRlZiBp
dCBhZnRlciB0aGUgcmV0dXJuIHN0YXRlbWVudD8gIA0KSSB0aGluayBpdCB3b3VsZCBiZSBjbGVh
bnVwIHRvIG1ha2UgdGhlIHNjb3BlIG9mIHRoaXMgYSBiaXQgc21hbGxlciBhcyBpdCBpcyBzcGVj
aWZpY2FsbHkgd3JpdHRlbiBmb3IgdGhpcyBmdW5jdGlvbi4gIA0KDQo+IMKgICANCj4gwqBzdHJ1
Y3QgQU1EVklBZGRyZXNzU3BhY2UgeyAgDQo+IMKgwqDCoMKgIFBDSUJ1cyAqYnVzO8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBQQ0lCdXMgKGZvciBidXMgbnVtYmVyKcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICovICANCj4gQEAgLTE0ODQsMzEgKzE0NjMsNDEgQEAgc3RhdGlj
IHZvaWQgYW1kdmlfY21kYnVmX3J1bihBTURWSVN0YXRlICpzKSAgDQo+IMKgwqDCoMKgIH0gIA0K
PiDCoH0gIA0KPiDCoCAgDQo+IC1zdGF0aWMgaW5saW5lIHVpbnQ4X3QgYW1kdmlfbW1pb19nZXRf
aW5kZXgoaHdhZGRyIGFkZHIpICANCj4gLXsgIA0KPiAtwqDCoMKgIHVpbnQ4X3QgaW5kZXggPSAo
YWRkciAmIH4weDIwMDApIC8gODsgIA0KPiAtICANCj4gLcKgwqDCoCBpZiAoKGFkZHIgJiAweDIw
MDApKSB7ICANCj4gLcKgwqDCoMKgwqDCoMKgIC8qIGhpZ2ggdGFibGUgKi8gIA0KPiAtwqDCoMKg
wqDCoMKgwqAgaW5kZXggPSBpbmRleCA+PSBBTURWSV9NTUlPX1JFR1NfSElHSCA/IEFNRFZJX01N
SU9fUkVHU19ISUdIIDogaW5kZXg7ICANCj4gLcKgwqDCoCB9IGVsc2UgeyAgDQo+IC3CoMKgwqDC
oMKgwqDCoCBpbmRleCA9IGluZGV4ID49IEFNRFZJX01NSU9fUkVHU19MT1cgPyBBTURWSV9NTUlP
X1JFR1NfTE9XIDogaW5kZXg7ICANCj4gK3N0YXRpYyBpbmxpbmUgIA0KPiArY29uc3QgY2hhciAq
YW1kdmlfbW1pb19nZXRfbmFtZShod2FkZHIgYWRkcikgIA0KPiAreyAgDQo+ICvCoMKgwqAgLyog
UmV0dXJuIE1NSU8gbmFtZXMgYXMgc3RyaW5nIGxpdGVyYWxzICovICANCj4gK8KgwqDCoCBzd2l0
Y2ggKGFkZHIpIHsgIA0KPiArwqDCoMKgIE1NSU9fUkVHX1RPX1NUUklORyhBTURWSV9NTUlPX0RF
VklDRV9UQUJMRSk7ICANCj4gK8KgwqDCoCBNTUlPX1JFR19UT19TVFJJTkcoQU1EVklfTU1JT19D
T01NQU5EX0JBU0UpOyAgDQo+ICvCoMKgwqAgTU1JT19SRUdfVE9fU1RSSU5HKEFNRFZJX01NSU9f
RVZFTlRfQkFTRSk7ICANCj4gK8KgwqDCoCBNTUlPX1JFR19UT19TVFJJTkcoQU1EVklfTU1JT19D
T05UUk9MKTsgIA0KPiArwqDCoMKgIE1NSU9fUkVHX1RPX1NUUklORyhBTURWSV9NTUlPX0VYQ0xf
QkFTRSk7ICANCj4gK8KgwqDCoCBNTUlPX1JFR19UT19TVFJJTkcoQU1EVklfTU1JT19FWENMX0xJ
TUlUKTsgIA0KPiArwqDCoMKgIE1NSU9fUkVHX1RPX1NUUklORyhBTURWSV9NTUlPX0VYVF9GRUFU
VVJFUyk7ICANCj4gK8KgwqDCoCBNTUlPX1JFR19UT19TVFJJTkcoQU1EVklfTU1JT19DT01NQU5E
X0hFQUQpOyAgDQo+ICvCoMKgwqAgTU1JT19SRUdfVE9fU1RSSU5HKEFNRFZJX01NSU9fQ09NTUFO
RF9UQUlMKTsgIA0KPiArwqDCoMKgIE1NSU9fUkVHX1RPX1NUUklORyhBTURWSV9NTUlPX0VWRU5U
X0hFQUQpOyAgDQo+ICvCoMKgwqAgTU1JT19SRUdfVE9fU1RSSU5HKEFNRFZJX01NSU9fRVZFTlRf
VEFJTCk7ICANCj4gK8KgwqDCoCBNTUlPX1JFR19UT19TVFJJTkcoQU1EVklfTU1JT19TVEFUVVMp
OyAgDQo+ICvCoMKgwqAgTU1JT19SRUdfVE9fU1RSSU5HKEFNRFZJX01NSU9fUFBSX0JBU0UpOyAg
DQo+ICvCoMKgwqAgTU1JT19SRUdfVE9fU1RSSU5HKEFNRFZJX01NSU9fUFBSX0hFQUQpOyAgDQo+
ICvCoMKgwqAgTU1JT19SRUdfVE9fU1RSSU5HKEFNRFZJX01NSU9fUFBSX1RBSUwpOyAgDQo+ICvC
oMKgwqAgZGVmYXVsdDogIA0KPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuICJVTkhBTkRMRUQiOyAg
DQo+IMKgwqDCoMKgIH0gIA0KPiAtICANCj4gLcKgwqDCoCByZXR1cm4gaW5kZXg7ICANCj4gwqB9
ICANCj4gwqAgIA0KPiDCoHN0YXRpYyB2b2lkIGFtZHZpX21taW9fdHJhY2VfcmVhZChod2FkZHIg
YWRkciwgdW5zaWduZWQgc2l6ZSkgIA0KPiDCoHsgIA0KPiAtwqDCoMKgIHVpbnQ4X3QgaW5kZXgg
PSBhbWR2aV9tbWlvX2dldF9pbmRleChhZGRyKTsgIA0KPiAtwqDCoMKgIHRyYWNlX2FtZHZpX21t
aW9fcmVhZChhbWR2aV9tbWlvX2xvd1tpbmRleF0sIGFkZHIsIHNpemUsIGFkZHIgJiB+MHgwNyk7
ICANCj4gK8KgwqDCoCBjb25zdCBjaGFyICptbWlvX25hbWUgPSBhbWR2aV9tbWlvX2dldF9uYW1l
KGFkZHIpOyAgDQo+ICvCoMKgwqAgdHJhY2VfYW1kdmlfbW1pb19yZWFkKG1taW9fbmFtZSwgYWRk
ciwgc2l6ZSwgYWRkciAmIH4weDA3KTsgIA0KPiDCoH0gIA0KPiDCoCAgDQo+IMKgc3RhdGljIHZv
aWQgYW1kdmlfbW1pb190cmFjZV93cml0ZShod2FkZHIgYWRkciwgdW5zaWduZWQgc2l6ZSwgdWlu
dDY0X3QgdmFsKSAgDQo+IMKgeyAgDQo+IC3CoMKgwqAgdWludDhfdCBpbmRleCA9IGFtZHZpX21t
aW9fZ2V0X2luZGV4KGFkZHIpOyAgDQo+IC3CoMKgwqAgdHJhY2VfYW1kdmlfbW1pb193cml0ZShh
bWR2aV9tbWlvX2xvd1tpbmRleF0sIGFkZHIsIHNpemUsIHZhbCwgIA0KPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhZGRyICYgfjB4MDcpOyAg
DQo+ICvCoMKgwqAgY29uc3QgY2hhciAqbW1pb19uYW1lID0gYW1kdmlfbW1pb19nZXRfbmFtZShh
ZGRyKTsgIA0KPiArwqDCoMKgIHRyYWNlX2FtZHZpX21taW9fd3JpdGUobW1pb19uYW1lLCBhZGRy
LCBzaXplLCB2YWwsIGFkZHIgJiB+MHgwNyk7ICANCj4gwqB9ICANCj4gwqAgIA0KPiDCoHN0YXRp
YyB1aW50NjRfdCBhbWR2aV9tbWlvX3JlYWQodm9pZCAqb3BhcXVlLCBod2FkZHIgYWRkciwgdW5z
aWduZWQgc2l6ZSk=

