Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069CFC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRe-00080V-K1; Tue, 02 Jul 2024 01:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRc-0007yV-Ec
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:48 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRZ-0006V4-1n
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899565; x=1751435565;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=30mWL99EU/bKEd4mW/PXJAURbObnxCCAckkShhac82U=;
 b=QHp6Uaic75IewZJFCO6NwT+Z3Qk7cR70AGQLHQNT8v46QM0JxIL5deZX
 FfVsNJfwWnuXUzEic8fVZujebhW6pFI9Lti3FjV7zqMpBKU/UZa/pC5lk
 BFVkAIAuITzUkUwlTJx4ho6OlzUFn1ebKWQG67oFk+1NWr7Ugp9V/XtR8
 kcBM0RuITlu2nScpLeqFnLh7dCSiCsHPjkROYdjSVqKLDi6NjX8sWKCtq
 vyIhcRnsij/cSoo7psafWHVxQUoY01Em130ncFb0giROo+lIoNew9GUeo
 NRXxe6iZIzjoxcCCXeNoFaRqjRrBU8/TR0ay/vclfmGAYwZP/Q9vS/Jfm w==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15721596"
X-MGA-submission: =?us-ascii?q?MDGDSU3g5kD10kDibOoNvR6hO2a7hyU4EGG/wy?=
 =?us-ascii?q?vkiq68zxZ/Wg2hTId13a7K/HxXMpYitY8l8KxpE0vH80hbXUzcmGrqIl?=
 =?us-ascii?q?KySPIRqjDfgZWJXmvD7rRgkS2Qy8iRiBCABQdjWzN6FLx314KoWTdXUc?=
 =?us-ascii?q?VgF/sqLCLXFEmILIThQVGjyA=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:43 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCoxLz/9xfS47CWC7YMXbZXdixz2YxCoStpSbU7JLu637KmFXGIcNyVkGv+BA7RwexF0jxxCDElGmsssdGkW13R8iWQlBdUxmWJM+0dmLtnHPYLchbsNi9ukvoCMpeotV91/S2HwHriFXR4Zf8JfTOaLLFttcF6WUYwKGN8h+plhq+zpweY6XPiZPMMexUGpjRfSuHtrK1VJ8clkLoits3JxJx7cVToolQOZXhNF5nOqu4HmwotTHC3SDSWFLv+B6dXCsu4c78Pbyz0h2bJIIuyY+nCsyprsxj5PHW/lREzIq5I14DGDCYVpT1IFTh7drKg4Pa3VjxGGIc0tL/yhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30mWL99EU/bKEd4mW/PXJAURbObnxCCAckkShhac82U=;
 b=O3Aq0HRNxEef6qDjsZKDiAximTm+JkBO0j7J0WHzpzJjQnikPhH3DeYiH8oEb39U/oh7IiWJrJ5hRTqACt1i86zo7OasScKmYC/pHJC1o9Fj/X9wxkMFsROC/Ux6KOf/S3wUYpXfG9r1wYC8fEfm6DTvs2Edf7VzokNkFI9+shAP6DTwp9eLCIj4q4WNmSaI1jlXNN/ovA47yAMYViXoQEITqG46sQYgYsVvQsiBBm+aDSF2SLmv+oWOxo/zTOsWkL2xpJPcrSSuEWvNDhtJ+rxPo7/5XAYLzH1NAN8K/MVju2VjvdAAd+BfAU5QalGzVhxE6WNY0EsBr4K42yvBKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30mWL99EU/bKEd4mW/PXJAURbObnxCCAckkShhac82U=;
 b=Nmkb03BPLWDV0FkIzo6okYn1ShwbfIOFeJ47IdK5MWzbc1Kzt9t/1A7apSu/USdKxHhEyEq5UAfoBi1d5IoT/ZBE2Nwy9WHM7fivxddwsCCMLH/mCnltyZVJ/nTU+DFg8EDKoW7l/Sib0YpwAlSfMypSGo2kKkpy7R1w9AlBaT55Y+r7ZO1oHHQzctcl7Phj74GBJu/BZzWQoRdXK2FEU6FHYBiGCJICQEILS0G7aIGalnYe9uA98xzGHFigzdmMsLy2LMYAWNNJWWNwwmMMZbEFKbHYNcOnnQUwJScdffPyPi2/MGgt10wLOD4+8W9qSSXGL0o6j7m7sRcLe6zDTQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7080.eurprd07.prod.outlook.com (2603:10a6:20b:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:42 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:42 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 16/22] intel_iommu: fill the PASID field when
 creating an instance of IOMMUTLBEntry
Thread-Topic: [PATCH ats_vtd v5 16/22] intel_iommu: fill the PASID field when
 creating an instance of IOMMUTLBEntry
Thread-Index: AQHazEQNQYz3PeHS6kG65cht4wNBcQ==
Date: Tue, 2 Jul 2024 05:52:42 +0000
Message-ID: <20240702055221.1337035-17-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7080:EE_
x-ms-office365-filtering-correlation-id: 7bec113f-f8ef-424e-623e-08dc9a5b3061
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?L3JZcGNwamdVM1VCaG9TUWVkSjFIMzdiYW1ScUVjckpqNXFVMXV2SHh4U3Jl?=
 =?utf-8?B?MTQyN0xtWmFrVEFaTzNXK0VWNDB2OHR3Z1F1Y0pudFJ6UVliUlRhTTJtNWRT?=
 =?utf-8?B?aG1uY3JBdFZ5dlZ0bFJVbFBoaHBlRFJmYjhGYUs5TUJ0cDlzZ0tuSFJTdzhR?=
 =?utf-8?B?L3IwL1Q3WVFWWHd6UHVkcVRDQzBUZ2poM1VJU21rOWNTNHFVTnIzZlFFMzV3?=
 =?utf-8?B?aWpEbzdYK0c3Rmt1QVdnY3dBVTVEMXA1VlRKYk9oNU9jTXFXcXNCVTYrZHJq?=
 =?utf-8?B?SnJFNWY1Y2FxTzVMbWo1aGNjbUtGcEpZREx3R0tRS2VPYnNFbVlCb1lMTUVP?=
 =?utf-8?B?a3JJMUhUQWdLYklEOEQvZll0L2xZMVd1dWlZT0RhdG9QUFZpdDNiczM5eDA1?=
 =?utf-8?B?VGsrbTNuek1GYjRRdm1pMzk2S0ZveEJwUlVPbEhKMDUrN1l2SnNKTWtMYkU1?=
 =?utf-8?B?Z0htTjR4bmVuVm5uN09qaldXR3VkZ0ZQdEZQNlA2S1YreDdQNE16VlhiZjJJ?=
 =?utf-8?B?Ujd0cDl5cWJNV0cvZUFJWFRhbXBZaFFFenVaNVVJOTFYUUtiSXUrZk92NlYy?=
 =?utf-8?B?ak5lUW16aFRuU0ZScVRPTmhwN0hiSWtqRlRucmF2K2FiYWlmaG1aNVptM2JR?=
 =?utf-8?B?WkJ5UDFIWE1ZaXZnNU5xdW45amhUTWNvSGQwOGN0dDVYc1lybjRuWGIvblRE?=
 =?utf-8?B?V0JqOFp1MGZQV1JkQ1B4c24rNWt1dDUvVG82bnJZRSsremZCK2VEODZEVWE1?=
 =?utf-8?B?dXRsbzNYTTBVV0NzK3dmbktlWVVNT1lqRktzWHEwRDk1c1N0b1ZDT0VReXZl?=
 =?utf-8?B?S0l5dmF6VkVGWHFuWk5ZZ1JtNG4yS09YbUs3OG4rSkZYa1U3VCtLU3FudFhm?=
 =?utf-8?B?Q1habEJkNmRTaDVHUjIzWDVib0RNOURFcTlLQmZmZkZPMmpmbnRQYjNoQkRJ?=
 =?utf-8?B?SE9jRmhGTmRDakczYm5pN0NSODJGbkE0Sk1SckgrSVVNeFUzaVg0TVdrbE00?=
 =?utf-8?B?dUEvRVlNenBEZ0lzKzlDRUJaQVdsNzB4QXNZUHNwN3g4VzVzcWRzTkU4eWdB?=
 =?utf-8?B?UGk0WTM3cXJWMjI0N1J5SmJUalZJTW9WZ0pJUHl6a3djaktoS3I5bXhqZFM0?=
 =?utf-8?B?bWpoRXp5dW96eXZ0Nko2S1E5WUU0Z1pPRkUvNEhjUm5PeWpHcjVZUXdwTUJi?=
 =?utf-8?B?Skx1c3VIWmJTY1FhckxWczJpdWdndHlDWWNCUzhqVWMwRk1NWnIvaE8xb1Fr?=
 =?utf-8?B?TU1jU29Qejg1enJNZ2hUR3RhR1hESDFscHcvOGFOMHBpNXJydmVYZXdLR3Ur?=
 =?utf-8?B?YnU5WGxsTkVTQ3N5RTE2bW95dEpIeGpTYVF5YklDbFFpY0dGajlJYnl5YVNM?=
 =?utf-8?B?T25OS2NaSDZScFFNcmQ3Vm1TMkIxMjZhS2cwNGdETFBXNGRDWFJJY3JZK1BH?=
 =?utf-8?B?T3ZoUXhqZHF0YkdOL1hWS0YzZ2xhMlFPbE5rN1hOUWJTc2xDclJid3V0ZG1K?=
 =?utf-8?B?YXlzdjRtUnVmcC9lNGlXQVVGOFJXOUhydkcxVm1IcVMzNWpIODVpbWZTa1hE?=
 =?utf-8?B?c2dZWWliNDBJWm9uL2VwN3AyaFUveUJVME9xaHIzUnE4dHZuQnNXbU9lYlBq?=
 =?utf-8?B?M21ZZE93TVpTWXJIcG5yRlRLM0p1WnZxN3FHR1I5K1N1cWxPZVZDaXVyM0d5?=
 =?utf-8?B?YU92RlpjU0d3SjFWVzd6NCsrUzFLZkN4eVpwdVpNeEVHWm51Ujh3RVhuYTVS?=
 =?utf-8?B?T2hWZHQxd3RpM3NDa25xazRmSGlDeWJhaThId080VVFFTG11SG1qR3FyTkYx?=
 =?utf-8?B?OHZXUXpvYnJDclU3L0xRMjhwR2hhN2ZCV3RQK3Q2ck9ONXg0a21weW11WGUr?=
 =?utf-8?B?cDZJWUhmTE8wR0ZwUzhmdzQzSGZERW55d3diZi9oOUp3RUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eis2UXNTRE51YWYxM2RleGd3SlRZOS9JK2NjOENHL2Vma01SRVppc3FaNC9L?=
 =?utf-8?B?Q3cxYVBJZXlXbVpEa1oyQWwzdXFpclBWWjVicEdnRFg4a3Y0R1B5N2Z6QkhT?=
 =?utf-8?B?eGpSblZWdzM5cjhkM0xBTG1nV3hGOE1YdUZ5ZTlaL2VySW9wQzRuVWl4d1BN?=
 =?utf-8?B?emF4T3o0T1hia1UrV1IzVlFUMjJWTjhIdHhJMTBWMzljVmFzQ2NWUk54VUJi?=
 =?utf-8?B?NTJpVDBsZHBWbmtRK2dvZEZvRDQwZ0xxSm9tMG1oUDBLUHJzc0pvNlc0K3ZK?=
 =?utf-8?B?YWI0U2hYSXhxaUlRL29MYi8rQ290OTlDNEkrUUpyOW45RFVtL0NhMlIwSUNC?=
 =?utf-8?B?bkViRXVMRFNlWHBPTjdUNnFHUGdMMk9hRFZYZ3pxbkxoVEZudE5FbjhXU2Ux?=
 =?utf-8?B?azNzWU83RWRXYllvRTZmMjNWbW9Fc3Q5Ym9EOGJwQWNjRUQ1QUR2cVg3RXVF?=
 =?utf-8?B?Lzl1QVhoR2oxVHdXRmZrc21DU0dzbHd1WnJxMmpzK0VBVXc1NlVFZVd5dXFV?=
 =?utf-8?B?ZndIUG5LbnNCUWpVcWc2U1hmNzdaRURYTnpJSmJzek5tTWpwRXpwN1JNMTFP?=
 =?utf-8?B?b0pOaGJEUkg0NkRlOXUrQ3RxR1dhb3dGVnpYNk1mT0NaQjJhM0tQRE1xalpQ?=
 =?utf-8?B?dkhHTm43RjZDTDg4cGNFcU9xM2NxT0VDazJMaThXWWJEc1NIc2pTSG9NeXBQ?=
 =?utf-8?B?UHNMMHBvUHBIcDBOaUFjOWJXTkFZYXZnV1d4QkQ5Mm1DWUViQTlyb3o3Wm9y?=
 =?utf-8?B?bStHSzBXMjRwNmw2Qk5OSmp0VWF4MmgwQU1XYkhYWmloVG1pdWZaZ0EzamlZ?=
 =?utf-8?B?cDFBVjE3dUwyQm9ZYks5dWNFcHo0R2tyRlJLdGViZk84Ujl0cm9wMG04WmlF?=
 =?utf-8?B?NTBmQnk5ZGpWMGdZZFB6YmJ0NGNLQzdVVUdZajdDa3cxSDI2emN5QTV1YUNR?=
 =?utf-8?B?WlZaNG4zZVFha3FSSFNRaVJaMkhYd0dUMTh1N3k5YTJoQkM4VjJ0WDV3ekU3?=
 =?utf-8?B?cmJMTmF6aE8vZklFWHVsVGFzV0RwK0Z5RGxoSWhXWHZwcFRnSzhubDIzbEk3?=
 =?utf-8?B?RG95OVA1dDA5WWF2clg2bmdmUWY0R1dtMndWbWUya0x5eFZDcTNDeUhTeHVM?=
 =?utf-8?B?UVgwbUhmUHhSZlhHSFlXTGw2NWxxVDRCUGh1WkgwemcxeTUrVThGMXo0cXdr?=
 =?utf-8?B?em5sTzZQNlBJWnBkKzl6eHFtMXV0WWYyY21wM1FDcTBkM2xNYmdqYWMzdEZZ?=
 =?utf-8?B?QkFmbmwwTmhHdmNKTTBJeks2cVlxNHhYR0xZTWxjZHBISEpja3ZMU0JUeUt1?=
 =?utf-8?B?OUlTNmlIQ0RjVmwrR0QvQU0vSXpuUm85UWJlWXJQZGVFYlpRWm1IZjZVdUI4?=
 =?utf-8?B?MHNKeDhCMkJDVzhoZ3VRRGlBQXNoRmFsV0dJbW5FV3F1ZHhmeGdZZHZlRFlR?=
 =?utf-8?B?MUJmQ1VRVkduMEE5T2Z5emZRTmlNbWNHL0FOdW5WSFFSRzlvMEZ5NW5VcG9O?=
 =?utf-8?B?cURsNFlPTTRnZEFNU3pjOHE2eUF6ZnhQODE1eC92VmJCb1RVV3FSOFY2QXJP?=
 =?utf-8?B?bGY1YWlpRWlmN2xFcXdNVVFRc2E5cDVXN01lU1N1MWNvaEdOcEM4REU5THIw?=
 =?utf-8?B?VGlZYi9UcjVESHFjK1lGTlhMSUZGbFBkVTJaVlRmYU1LbGFMbDg3U1JqckFm?=
 =?utf-8?B?ZUk4aW1pWEFmL2NkZ1hBcW1vTVN1OVBJYVpNc0VGTXIxazJLckY5ZTlDT0M1?=
 =?utf-8?B?eDVaR1lpSS9jVlVRcjdjRW1CMkZoYm1sZlVXVmFtUGhiRXN4K1NXTGFYUEVh?=
 =?utf-8?B?ZU9uZDRkZ0xTU3IrMEs2ZjVWamwvNG9ZLzVBd003SU1JWnZ1TnVQcjBqMjZp?=
 =?utf-8?B?RGNZMW5WN2hQTm5VUkprNHZ2c1V2ekJ1ZEY5SG13Q21INHY5a1VVenhzbW5C?=
 =?utf-8?B?enI0YU51YTBSbXVjUGhsc2dkYXk5blNEbG9BeVcrcUVZVE9vbWJUS2FZSy9U?=
 =?utf-8?B?OVhuMnhIWGxHbmV1ZlF0M3MwY3JTNmF0MUtMdW45UHRBM2piUmdqbEhmV3dG?=
 =?utf-8?B?d2NLSEtRSnJSREVXM3JNSXM0TlFENHhsdnkydmI5Y1VMQVhUWVZ4eGxZTFBY?=
 =?utf-8?B?OGZiZFZCMEhndVBJZGMxNEFHcGU4aFVqenJmL0pmWXFuZmh2c0t2MHZ4N1l5?=
 =?utf-8?Q?RF+GGtVT3qw/uEb4J7v95js=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A64D841B770834BBB77DBBC9210C4FF@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bec113f-f8ef-424e-623e-08dc9a5b3061
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:42.3775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLJ++DSFComEYZWvxKbAvfnJpQrS/P8AtoqObrEiv8tN2UA2DN7h3tpzuEjXfFs+PHqyMrXu2Tu4MoXTEQN3fRKXVqXNZtmJNmbwJEXokP5YmrAmXOxsnjvRbSZAusJn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7080
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwg
OSArKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1n
aXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4
IDJlNGY1MzVkZDEuLmY3Nzk3MjEzMGYgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11
LmMNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KQEAgLTIyMTAsNiArMjIxMCw5IEBAIHN0
YXRpYyBib29sIHZ0ZF9kb19pb21tdV90cmFuc2xhdGUoVlREQWRkcmVzc1NwYWNlICp2dGRfYXMs
IFBDSUJ1cyAqYnVzLA0KIA0KICAgICB2dGRfaW9tbXVfbG9jayhzKTsNCiANCisgICAgLyogZmls
bCB0aGUgcGFzaWQgYmVmb3JlIGdldHRpbmcgcmlkMnBhc2lkICovDQorICAgIGVudHJ5LT5wYXNp
ZCA9IHBhc2lkOw0KKw0KICAgICBjY19lbnRyeSA9ICZ2dGRfYXMtPmNvbnRleHRfY2FjaGVfZW50
cnk7DQogDQogICAgIC8qIFRyeSB0byBmZXRjaCBwdGUgZm9ybSBJT1RMQiwgd2UgZG9uJ3QgbmVl
ZCBSSUQyUEFTSUQgbG9naWMgKi8NCkBAIC0yMzI4LDYgKzIzMzEsNyBAQCBvdXQ6DQogICAgIGVu
dHJ5LT50cmFuc2xhdGVkX2FkZHIgPSB2dGRfZ2V0X3B0ZV9hZGRyKHB0ZSwgcy0+YXdfYml0cykg
JiBwYWdlX21hc2s7DQogICAgIGVudHJ5LT5hZGRyX21hc2sgPSB+cGFnZV9tYXNrOw0KICAgICBl
bnRyeS0+cGVybSA9IGFjY2Vzc19mbGFnczsNCisgICAgLyogcGFzaWQgYWxyZWFkeSBzZXQgKi8N
CiAgICAgcmV0dXJuIHRydWU7DQogDQogZXJyb3I6DQpAQCAtMjMzNiw2ICsyMzQwLDcgQEAgZXJy
b3I6DQogICAgIGVudHJ5LT50cmFuc2xhdGVkX2FkZHIgPSAwOw0KICAgICBlbnRyeS0+YWRkcl9t
YXNrID0gMDsNCiAgICAgZW50cnktPnBlcm0gPSBJT01NVV9OT05FOw0KKyAgICBlbnRyeS0+cGFz
aWQgPSBQQ0lfTk9fUEFTSUQ7DQogICAgIHJldHVybiBmYWxzZTsNCiB9DQogDQpAQCAtMzY5Nyw2
ICszNzAyLDcgQEAgc3RhdGljIHZvaWQgdnRkX3Bpb3RsYl9wYWdlX2ludmFsaWRhdGUoSW50ZWxJ
T01NVVN0YXRlICpzLCB1aW50MTZfdCBkb21haW5faWQsDQogICAgICAgICAgICAgZXZlbnQuZW50
cnkudGFyZ2V0X2FzID0gJmFkZHJlc3Nfc3BhY2VfbWVtb3J5Ow0KICAgICAgICAgICAgIGV2ZW50
LmVudHJ5LmlvdmEgPSBhZGRyOw0KICAgICAgICAgICAgIGV2ZW50LmVudHJ5LnBlcm0gPSBJT01N
VV9OT05FOw0KKyAgICAgICAgICAgIGV2ZW50LmVudHJ5LnBhc2lkID0gcGFzaWQ7DQogICAgICAg
ICAgICAgZXZlbnQuZW50cnkuYWRkcl9tYXNrID0gc2l6ZSAtIDE7DQogICAgICAgICAgICAgZXZl
bnQuZW50cnkudHJhbnNsYXRlZF9hZGRyID0gMDsNCiAgICAgICAgICAgICBtZW1vcnlfcmVnaW9u
X25vdGlmeV9pb21tdSgmdnRkX2FzLT5pb21tdSwgMCwgZXZlbnQpOw0KQEAgLTQzNDQsNiArNDM1
MCw3IEBAIHN0YXRpYyB2b2lkIGRvX2ludmFsaWRhdGVfZGV2aWNlX3RsYihWVERBZGRyZXNzU3Bh
Y2UgKnZ0ZF9kZXZfYXMsDQogICAgIGV2ZW50LmVudHJ5LmlvdmEgPSBhZGRyOw0KICAgICBldmVu
dC5lbnRyeS5wZXJtID0gSU9NTVVfTk9ORTsNCiAgICAgZXZlbnQuZW50cnkudHJhbnNsYXRlZF9h
ZGRyID0gMDsNCisgICAgZXZlbnQuZW50cnkucGFzaWQgPSB2dGRfZGV2X2FzLT5wYXNpZDsNCiAg
ICAgbWVtb3J5X3JlZ2lvbl9ub3RpZnlfaW9tbXUoJnZ0ZF9kZXZfYXMtPmlvbW11LCAwLCBldmVu
dCk7DQogfQ0KIA0KQEAgLTQ5MjAsNiArNDkyNyw3IEBAIHN0YXRpYyBJT01NVVRMQkVudHJ5IHZ0
ZF9pb21tdV90cmFuc2xhdGUoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11LCBod2FkZHIgYWRkciwN
CiAgICAgSU9NTVVUTEJFbnRyeSBpb3RsYiA9IHsNCiAgICAgICAgIC8qIFdlJ2xsIGZpbGwgaW4g
dGhlIHJlc3QgbGF0ZXIuICovDQogICAgICAgICAudGFyZ2V0X2FzID0gJmFkZHJlc3Nfc3BhY2Vf
bWVtb3J5LA0KKyAgICAgICAgLnBhc2lkID0gdnRkX2FzLT5wYXNpZCwNCiAgICAgfTsNCiAgICAg
Ym9vbCBzdWNjZXNzOw0KIA0KQEAgLTQ5MzIsNiArNDk0MCw3IEBAIHN0YXRpYyBJT01NVVRMQkVu
dHJ5IHZ0ZF9pb21tdV90cmFuc2xhdGUoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11LCBod2FkZHIg
YWRkciwNCiAgICAgICAgIGlvdGxiLnRyYW5zbGF0ZWRfYWRkciA9IGFkZHIgJiBWVERfUEFHRV9N
QVNLXzRLOw0KICAgICAgICAgaW90bGIuYWRkcl9tYXNrID0gflZURF9QQUdFX01BU0tfNEs7DQog
ICAgICAgICBpb3RsYi5wZXJtID0gSU9NTVVfUlc7DQorICAgICAgICBpb3RsYi5wYXNpZCA9IFBD
SV9OT19QQVNJRDsNCiAgICAgICAgIHN1Y2Nlc3MgPSB0cnVlOw0KICAgICB9DQogDQotLSANCjIu
NDUuMg==

