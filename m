Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3B6C3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 11:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPghl-0006OH-8p; Fri, 05 Jul 2024 07:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPghi-0006NM-H4
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:02:14 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPghg-0001Tp-Ql
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 07:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720177333; x=1751713333;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=pqwkHTle5zShwb1UCmzN30OIyPBuDlyHBRRNtdojXrI=;
 b=KtlUg61o4xBgsp771pGfLGfMsGbaUokSTYZVkFrclZjDf/0k0byce6a4
 /AFQubHaejnkCAflm9AvlCPkL69UeSzmlfpzO/nFcIU3Ax1BevxjowDDe
 r5FckWFTS0XKR3CUvRUNIGsJHBRu+CiCgAW0Nz7mxXdRlob1Ih2eVGGVc
 3qD3Sxewc3et2ShcEq8Z6ahvmyDwY5eRe4bnFeV7TmFWfCygKjXPG5Ruh
 lQk7SGmZTL02OxQXNOUj32/urmum4eVxcc4FTLJStm3nndkSyV50s4pW7
 R5f1LDFE9w82FYMEXlht0Xqs1doxmcizaMLmDnFJI9TfwWktL6vljRXj2 w==;
X-IronPort-AV: E=Sophos;i="6.09,184,1716242400"; d="scan'208";a="16056518"
X-MGA-submission: =?us-ascii?q?MDF81VNHdETT8m7DUYm1R9HzmQbRFpR8fLT/F8?=
 =?us-ascii?q?LkxX/MCI2D9ADG6pHXGr2A7hQDbAasZY1S9rgG0bewF/yzzrxiDiMN4n?=
 =?us-ascii?q?exmTYKGyb7FyhPZZ1QgSWF58Bnp79tRMmInaGOG5V/qBUcH2KZL0uU2r?=
 =?us-ascii?q?Eh3orgL67uNvnWFPbdWiijvQ=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 13:01:58 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4rLa4Z6fUS0t6UNSRAqXF/K1V+moAB/dSv3m36onN6ScJv74vKexUsxA1IjpERdAmsmnHgwVLXDsTJifVTacNih9qhlIQL/LCVdwQsyaxvBpFl1mFK3+ovztAKEByKLfI59kuXb6tPMW56LcAeRdMQaUelXrzLbWYsMpDvWIuvDhkIbbERa27MnEo+fe+Q4VH6Y4WhtyuDhem5GUcdcRrDEfaWEiiAMqoNsFj/toSMsOIaiYLbFgLFna2Q8m5R7wHlUjAOn3rw4l0PqkXcVJCWCQ60EScPhkeeJQxF8lx4dCZ9CWoLx0Z0u5MFQpkX3RgiGCctIp8eat6KhLN8wHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqwkHTle5zShwb1UCmzN30OIyPBuDlyHBRRNtdojXrI=;
 b=NSSDa9RtAqT2epk9AExU491oQ1iDF6nQdrMZ8VovPayGOuZPX0TnzNDSe5aWbphHDeQGv5P3JtEOGnMEN866OSoo+YsjxVNHnO8KdBdOCAl3UpakHtprhUGZ40IjIeg1Y5ZsIbNDXiCtlurGS0ytOwSzY54CDCgTDTDdngBXOHJof0nO0NXLYbnZUL5+RT/LDieLjIukJ+ppa+TyRhTMDjHqPFKlIz+T2IpEFULz/APvXFUCsKT9XTdEefrtyjMa7M0yIPkMsEXlgDemu4JYtjVM90Uq27/kHDTc2ROYSgT7NKapORbwbLbzPG7OE797L4Y91Z8pjUC9A04epo6Spg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqwkHTle5zShwb1UCmzN30OIyPBuDlyHBRRNtdojXrI=;
 b=Grgg6BmwVm7Dxp1YUghj0k+OKHaESzI5/HWL6cX3OiJ9raaCtr9t3Fn4F0bKUbTY/HQMPLzCO+AHwwibfVDn0Xrmy4i+PCbRx8OXHGwf6Ch+4krRWhGBs8Pmky4Tfyq2ky53eRlVuYwzL4Cn7gmJP7DmNglQqh7efnlwIEU8k4ONb27eDBlfevYBLqLC/IltpciJqbsRqKjMGCyRlH/1GdUV5DPrevv7NBWVgYuorfDJOR4pyHG9RSYzs4tthpgv9s25xOo/KNVWEg6Rze2iablElD9PIqF2eUaLnZxpI7i461uKy8WRoe1XwFiKEnv77MqvZeXNBZI+ViMw6cQcAQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7303.eurprd07.prod.outlook.com (2603:10a6:20b:259::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.11; Fri, 5 Jul
 2024 11:01:57 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 11:01:56 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v4 1/4] intel_iommu: fix FRCD construction macro
Thread-Topic: [PATCH  v4 1/4] intel_iommu: fix FRCD construction macro
Thread-Index: AQHazsrARhZLqun5JEis8sZiKlyPAg==
Date: Fri, 5 Jul 2024 11:01:56 +0000
Message-ID: <20240705105937.1630829-2-clement.mathieu--drif@eviden.com>
References: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7303:EE_
x-ms-office365-filtering-correlation-id: 5bf0e129-ae69-499c-a499-08dc9ce1e300
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VmJFRUpuNlVMODJjeE5xUjNCYTQwa3UxakN3SjJ2WXJ4LzN3bytlVmZSeUVH?=
 =?utf-8?B?QWlKalNLckdKSVJkR0tXZFQrRlA1RktlZnduQ2dBZXFJTEdvbGFRNmk1THlx?=
 =?utf-8?B?dGlFNlp5OXJvUVA2V0d4REt4QnJRb0RValZDTW04VVpybDY5ZEFQajA3eUNJ?=
 =?utf-8?B?Zm5Jb1dXUkNBK2xXV0xnN0VkWFFDSjcwQlJFNGJoSzJmTVNtYnp5UXErM2k0?=
 =?utf-8?B?UUFoV0NiNVRrWEZxUk01NHVQRUFybk4xSE9rcWw4TDVtdzZ6UVYvUFVwL0pS?=
 =?utf-8?B?c3FoMFVkUDZXMjBmYmRGb3kxWWpSNGdJQkNjQWdIZHIwQ3ZZd2ZSMlgya3hW?=
 =?utf-8?B?ZkdWSFlkdHVRNzU4YnlUaUpYVjJLS21HditYemJ5NnJ4cFNEcXU1ZXgyc1VF?=
 =?utf-8?B?VHlNL2xDbWthTEQ2dlZvTXVlRE5Cc25WdVdpWmFtZTFrNkZvL29LVWcyeUVI?=
 =?utf-8?B?b3NFUVdydi9xNEhCaThtRG94TUZkNHdmTVZpVWVEZnYyczEzSlFvTjh6SzdK?=
 =?utf-8?B?cGdTcTZ2YjJ2MFZGdzIvd2NsTmZiM2xsSXN0STVyUlh6bG1kd3BreGVXWUVp?=
 =?utf-8?B?dy9oZnZQeWFuYmxvM2MyaEE3RlhnL0Y5UUtQQ25IWkFvdmhMcjd6dm52REF2?=
 =?utf-8?B?UzhrcXNzaW5CcEVTakQ5MFZhRGhEQUJNOXN6Wk1wUzNOOWtTQ3drdGNrNkVh?=
 =?utf-8?B?ZHo4M0NudlFiN0JVeUJJSlZpcU9tcTlWWmRnTkVIWFA5VHpqK1BQM0F4Q2Nj?=
 =?utf-8?B?ZENFNnRqMlovVTRudXkxQmx2YmNrYlI4RWNJU1ZSVzNCbmY5NWpqSzdlOFZo?=
 =?utf-8?B?TEpqNmlydDRCMDM5NEZubmtRdjZoemtLZEtRRnNEWSs4SGprTjRaOG8rT0hX?=
 =?utf-8?B?eWpwMGNUeXRKMTZEMTg3N200eXcrbFhNNkI0VkF4Q08vZTd4UmgrM0J4Wita?=
 =?utf-8?B?MjRyVTEyYy9adWxqVVFYemE2RWpIM2sremlqSGVsc0FGcTFTeWlEbTB6WGh5?=
 =?utf-8?B?cWVGR04vY3JRZTlFRWhYZTFwOURoeHR6RFBxazVBNUtQWmppZWNYbHFCbWdD?=
 =?utf-8?B?RE5nRklXT2VRZlFWdGpwWGpaOVhVRnF4TmlvejhBL0N5QklpelJpajFhV0dy?=
 =?utf-8?B?RzJKb25tVGlTdlNLOUN1L3hxQkcySEppYWl2RHZMck5uVWtieks3dWQ2KytW?=
 =?utf-8?B?VXY5L2xDR3hGbTJ2bDByNW9pUC9Xem02dXk0dDJhczRRNXNCK2ZjTy8zYVZ2?=
 =?utf-8?B?WlRLRGQrWDNpZm1SemJCMWlYcHcwSURRblFGWE5CVXlUV2x1dE01VUlZTG9O?=
 =?utf-8?B?dnlxOFpyV1NOdkVlTEswRUhISGZ5eUtrblNEMTlYYkducGZTNzJDSkEvVFRx?=
 =?utf-8?B?alU1Q1k2Rkx5ODRqa0k2YWNscmlqZHNaLytMNi9nZ2lKVWc2SmgxL093ajlt?=
 =?utf-8?B?QXdxV3EvZWpEREpTblhnZTFGaTgwd3h1TlhvVVU5dm0weWxnWU9IVFZFdEEw?=
 =?utf-8?B?Yk1ERS83aXNYL0pVMDhaenVOSEF0azRrbDk0WWVlMFZ2SCtYQlZDNFdIQTAr?=
 =?utf-8?B?a0l5aXoyRzVtQTFLSWVRbmVNbGswZTJoTW1DUUxlemttOEVyMmQ0Y3hpMUNv?=
 =?utf-8?B?VnhVYUVIZWJERld5MC9jTUwxQWZlRyt4KzRtTkxuMm5zTjZ2TFI1V0lpKzVK?=
 =?utf-8?B?YzZVTFFlUDF2b2luZmU1N1FtYUJoY0ZHUXRJM2ZUaHNoRVJweTU5emN5b25X?=
 =?utf-8?B?U3lSZ29OMUNOSVJPdk9FYlFpMm0xL0JGVU05a2JxUk84QXN4UFNPSjMrZ0lx?=
 =?utf-8?B?M2g1VFlVTnJHdkNHOU12ckhHckRHSTIvVVhVU3BaMnFxdUYzMkNaaXdxcUN2?=
 =?utf-8?B?dG1rUHN0TWNFdk1nbys5c3F1S1lmbE5kMUsxN1NKRHdqM2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUFhOHlyODRWK24zRVVrR05sRWlqQi9UeHhCSlA2Y1UyS0RPSDNuQ1R6MndX?=
 =?utf-8?B?VnVMV0Z4aThkaDZZSE9BVkdxT2o5ZWdHQ2lTZUlmOWozN0JENTczcU11Skdi?=
 =?utf-8?B?ckxxNjkyYURZSUl3ZW1Wa1RxRy9YMnh6MUtveU12cmI0ektJUWVxTXpsTTRi?=
 =?utf-8?B?WitFNHdtUVcyWm44UzRsaE4xOWdPWjkyS05iUkpCUHRnODJVNkRBUnRtbDdk?=
 =?utf-8?B?dHNDMjZKbTJXNkZDT09Qb1YwWlZUOG4yNDgyZjZPbWN1WGhER1BxZnFzUUVv?=
 =?utf-8?B?VVRLUVZVcGs4V2s0RVhreUFkU3p3eFhwbW5IazFmanQyTjRPU1ZWYTVwTWtZ?=
 =?utf-8?B?YTJNdGxrdWdqOC9XMlJORm1zQ2FOSGFoRmpRSTlwbmd1WmpzMU9BL0hKQzAv?=
 =?utf-8?B?dmZpQlhtWWE0MVVqcHBxS0hhVnptWGRKVlc4RGJqZnhzWmdFbmozVnoraWNn?=
 =?utf-8?B?Zit3VDNEMDR6ZWJUQjNkb282bHZtSFI2MWVUMTZya3g2SFU2YU41MjcrWHlD?=
 =?utf-8?B?ZUt5L2RBZlFNazVkei9TWmNreEZvOEZvZm5iMVRDVU96c1cweTJ1OS80V3Jj?=
 =?utf-8?B?TndaUVppMnR5Q3N3ZHVuUEtIcXgzSDZUa1FpMDNWOXRrQndUNU1yUXlGeVpw?=
 =?utf-8?B?ZFpLWVVsY1FRSVlpM1RFNjNiSVM1Z2FuUENLcmFxd0pGVTZlc3c0TzN1Qk1r?=
 =?utf-8?B?NVh3ZHBabWtyaXRXbDVqRUk3OUlnMFJvbmlxdHpobGtrMnI5VXRRUlFBdHZL?=
 =?utf-8?B?eHJ3K0tsQStEWlZlZFlyZWxsYndWWFgwK25xcHVya0lwbnVSSFZqSlFNbE9t?=
 =?utf-8?B?R0JxMThyNm1lek9Ub0VIZThRQzUvUitwd29qZjdsOFN5cXBUREh5elB0V3lF?=
 =?utf-8?B?dnZhWG5EMnVvaFVsZXpScUFuYnBxSnc3Y25QZjFPblhxZ0s4RnpmZ2Vpay9u?=
 =?utf-8?B?K1FRajZndWtIbmpZem1vWlVSWnBIREpaQVBhQjJWYlhHd2lCSXNlS00ybGZE?=
 =?utf-8?B?anJUZlY4TDN6b3JjRHBiQlFUdjNqMlNid3JoRHpWTGhheFJiVXZINWhVcWFv?=
 =?utf-8?B?bWxEMXh6azZ2Z3ZmbFovSnNmT25jaWlnaS9OQzc1b0JuR1h4alplR2pNYVlm?=
 =?utf-8?B?M0JacnRBQVB2QXJDS1FNVVcza2hXdzJGNVJaQllBOFd5YzBzSHZEQmhrVzhX?=
 =?utf-8?B?bmRNUkN4VWtsSHFWSEZTbks0U1FKVEE4bldERXhrcTFxb1hsZ0FlSEJQZTNp?=
 =?utf-8?B?ckQ0MVF1SnVyUHBORXkyaGhPOEFkS2puVE5KZGlUNTA4TWhNdWRNeGdLSXdy?=
 =?utf-8?B?QUYzcVVyQVQ4eUhKT0tCTEZ1alcvcWRXSXlSYXIvUWowQ1A0WlNVVk42Ti94?=
 =?utf-8?B?cDR4NjJPQ2pkcjFBYXh3bVdyUW81dHlmSWZqdWcxbmtNUmtjanIyc0RCZGov?=
 =?utf-8?B?enIwUHBxRW9UaGQrKzJPTU1TSUtEMldYTDZTVXhqTW9nQm5zR2NmdFRmOEpH?=
 =?utf-8?B?M0ZWQmlGOTJYcC9OQjl5aHZuSnUzTW0yaHNhdDZxaUdnY3pSQnV4OHNLUEpk?=
 =?utf-8?B?SVpZNHF5cVIwMTY3NHdlSGgxcGhkanVYSkpoczYrSnFTRWpJRU9jQkcyVStR?=
 =?utf-8?B?L0FVSjlHbmZjMWFzVTRPNUZSZXF6L1Rka3R0R1A2MllDTDVFZEpzbTJKYUpK?=
 =?utf-8?B?NHd0Q3pyeEJmTWZrL2dJWVNXZ3dacVFvYkV6VDBLOG9oWW9RQmtSTURwVU9i?=
 =?utf-8?B?U29tYzJJK0UzbGViOVo4QXBNWnAwaEZ5dks4OVB3a2h4NVRBWXVHNWxIanpu?=
 =?utf-8?B?ZE9HZGt6MHV6Z3F0Si9YTGhvQVBJb240ODFMQ1RsSk9yL3JGdVZZNS9yckl0?=
 =?utf-8?B?TzlxbW9HUGxmVHN5R1NIVHRPWXNpY0JCbTI4czNpYkdKeUtqbDJ3MkQ2OFN1?=
 =?utf-8?B?V1RnWFhqdkdNMnY2aDVScTk4OHdOSFZGeFdIWXRvUXlpRjJiUGpYNU9tNmQz?=
 =?utf-8?B?Qnp6TEV5MCtYaVZmU0w1SWtwMDJFTUp4ZmFZYmdzakQ5c1I2enZvWE5meCtU?=
 =?utf-8?B?UXJNQVp6Q3BYZ1pUaWtGajNNRTVCOU5vMFNTeEZNNTczRmlibWhHdDh3Y2Vs?=
 =?utf-8?B?K2JqUXp4b0FYU1hBQnN6L3ZBaXpUSEo5bXlzSjQ5V0ZHUDlmNVZRMmNvTCth?=
 =?utf-8?Q?VkLWX692Hb/O+SPONe04lxg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0EBB6BF01E30A4E8C0CA5DFFC71CF0B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf0e129-ae69-499c-a499-08dc9ce1e300
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 11:01:56.9537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9C1uPOXehEW7YKHzXo4VgdMTlsM5hlWE+ZZG2vB5F8pf7IBzBvN80uQxNq1F3jw4Q/Y6gzqNKUluL+v/LLG6N5idWWVRDFT99qb0OHEk1Vmnh8uq0W21zzErNnXJ8Zh3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7303
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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
bi5jb20+DQoNClRoZSBjb25zdGFudCBtdXN0IGJlIHVuc2lnbmVkLCBvdGhlcndpc2UgdGhlIHR3
bydzIGNvbXBsZW1lbnQNCm92ZXJyaWRlcyB0aGUgb3RoZXIgZmllbGRzIHdoZW4gYSBQQVNJRCBp
cyBwcmVzZW50Lg0KDQpGaXhlczogMWIyYjEyMzc2YzhhICgiaW50ZWwtaW9tbXU6IFBBU0lEIHN1
cHBvcnQiKQ0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50
Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NClJldmlld2VkLWJ5OiBZaSBMaXUgPHlpLmwubGl1
QGludGVsLmNvbT4NClJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5A
aW50ZWwuY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgMiArLQ0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0t
Z2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQppbmRleCBmOGNmOTliZGRmLi5jYmM0MDMwMDMxIDEwMDY0NA0KLS0tIGEv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmgNCkBAIC0yNjcsNyArMjY3LDcgQEANCiAvKiBGb3IgdGhlIGxvdyA2NC1iaXQg
b2YgMTI4LWJpdCAqLw0KICNkZWZpbmUgVlREX0ZSQ0RfRkkodmFsKSAgICAgICAgKCh2YWwpICYg
fjB4ZmZmVUxMKQ0KICNkZWZpbmUgVlREX0ZSQ0RfUFYodmFsKSAgICAgICAgKCgodmFsKSAmIDB4
ZmZmZlVMTCkgPDwgNDApDQotI2RlZmluZSBWVERfRlJDRF9QUCh2YWwpICAgICAgICAoKCh2YWwp
ICYgMHgxKSA8PCAzMSkNCisjZGVmaW5lIFZURF9GUkNEX1BQKHZhbCkgICAgICAgICgoKHZhbCkg
JiAweDFVTEwpIDw8IDMxKQ0KICNkZWZpbmUgVlREX0ZSQ0RfSVJfSURYKHZhbCkgICAgKCgodmFs
KSAmIDB4ZmZmZlVMTCkgPDwgNDgpDQogDQogLyogRE1BIFJlbWFwcGluZyBGYXVsdCBDb25kaXRp
b25zICovDQotLSANCjIuNDUuMg0K

