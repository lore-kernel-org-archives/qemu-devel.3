Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF862C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 15:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Qwq-0001ik-EX; Thu, 17 Apr 2025 11:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.milon@eviden.com>)
 id 1u5QwR-0001bG-8a
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 11:14:15 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan.milon@eviden.com>)
 id 1u5QwM-0001qD-6t
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 11:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1744902850; x=1776438850;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=mgnFj1TulBpatT21W3yvC2qbH/atiiz7I1895tNNFWo=;
 b=HBlbb13sJaUJ7lAN+BI55jxbyt/3GyXUrohgok5iz5OMlBzvjEhsC9CB
 FcW+krTOn6yoXYClHav+I6ic/ij4U8R/5NgaV1yvG6idrP5KW01oVNlD1
 6Xc6N0C8zR7EUTVmch8imIvBL7iQB43Z3QFNnQ+bi4DjUqsSbIKIQnM01
 TBX755NzaXkoyyM8LFyos6I/hhbXm0NEi+z/m307vsIKoFpU4V4OuOU0U
 gz4Sd6IRbF9VyuZUQ8GnpWFqVq3SkXIvHjh1kxKhmK+6zZaIEDVaPBKEE
 V6r4hqXZWynwf1ASYioi51B6yA9p6m+szPCZr4eBv8jPFQYJjDa2EzqFp w==;
X-CSE-ConnectionGUID: SuTu+RpDQCOoJ67A4RYJ0g==
X-CSE-MsgGUID: 7zWae+FaT5SA831hARtXQg==
X-IronPort-AV: E=Sophos;i="6.15,219,1739833200"; d="scan'208";a="35247682"
X-MGA-submission: =?us-ascii?q?MDG5tSu7DoMiEvro8oXYNdJlEnxLeyfKFnDpmG?=
 =?us-ascii?q?3wjUFCkr6Rd3s2FSIxn4/OO2Npcm0ZwJY0ShdW1O6CjmLGuFfUfhY356?=
 =?us-ascii?q?Vl9tiR/fLm3I+JvILeYLtLqLri/tScnlqO7AxKdWEGAGb5Vl0zwuRSfc?=
 =?us-ascii?q?KPRkiZZegl0W2qIJcbKKNzVQ=3D=3D?=
Received: from mail-am6eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.110])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 17 Apr 2025 17:14:02 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oi6CG1gfPrm7kFM15UIv9yNlLyGBYgcL1fX9cAW7PJkZu3HU5vnVFlAXBf6Fy6nFwUcitIkQiqKiNFLnFGRZ2IAnUFV5JTBJnkUEqOyPNoMhTUmmkcpMVOWrHuSJAQH2aDFtPmgeT/X34UWPtY4WGZhB1CFQ1U9T2ggujs2YDRdYhWsMc/h/SJ/+a2PSzG73S3jJxpInIrUniJ5krjuorvwsqvr/4lotGPIWqdfTuO5uA85kZo2Rlw5fP8wmD6w22xvyFTALyccoDFqfEpEOORoQZGHxEniWzJQrg6kCb7Z1t36IrO+9DpF3C2v4vBz0OHFch+kG2PRnsfCyGN+RnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgnFj1TulBpatT21W3yvC2qbH/atiiz7I1895tNNFWo=;
 b=lLIeebNy6yG2pTGBdKM4heyUgsoT1rxPsVP19Nha9nHuCyJItZW8zrYLQtdosQj15k0YbQGzMsELYmFWO9Md+/SFYy2KOCd0jzCcYyKFSce8J8IwxprZfDKvgwXalTMxoLSB5NDTqXvH6xn3pfi6JsDJBklvFUTjbYwTh1N5nD6YuI/jIzMQ4NwLV52zbbJf8IK18iO2qaMqaoI7IrUeoYGdvrklXz1Z21J4Q10vX+TXx1Z/seDuaRsY9l+n4vNuUL0vaFI2c+WnDRMdUQNhLURUKOidAWsHTHEIw99M/Hvp9bBUTyWoOPsBDGUaA6S4KwTdpyfsNpruXYFgZ4ct1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgnFj1TulBpatT21W3yvC2qbH/atiiz7I1895tNNFWo=;
 b=WRG9FPdbBp7Y2eF7WPX1W3FP45am2ut3T+xtvqzRDw56epllKfXjsawt22qtFpU+GRn4lK4fE7GQiO4TklfSWQkQRDQ+BrQGhIlqZX3g6x7yKm+25BgTZkv8qnZ79OWvjJyZe9ExfVAxPXhb77bWq2/yNvf+wkcf/HLglQADcXvTA6sInz9As3gX2pXKWbFR0SexhkEs7vbAedTqgpJewoTIPYdOQSiIiaHBZbCCfjKx5zb9+z5AdPsrl5A3GBdEspuAd7AyRegaumyeJN/gFynP+3IhBXK2OyT+ZCzsweidwudIFEXBaG4uGDLa0hu1Ams/cKNtJKaopGBF8mrUTw==
Received: from PA4PR07MB8599.eurprd07.prod.outlook.com (2603:10a6:102:270::5)
 by PAWPR07MB9733.eurprd07.prod.outlook.com (2603:10a6:102:381::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Thu, 17 Apr
 2025 15:14:01 +0000
Received: from PA4PR07MB8599.eurprd07.prod.outlook.com
 ([fe80::ac7b:6299:6e01:df7c]) by PA4PR07MB8599.eurprd07.prod.outlook.com
 ([fe80::ac7b:6299:6e01:df7c%7]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 15:14:01 +0000
From: Ethan MILON <ethan.milon@eviden.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "santosh.shukla@amd.com" <santosh.shukla@amd.com>, "sarunkod@amd.com"
 <sarunkod@amd.com>, "Wei.Huang2@amd.com" <Wei.Huang2@amd.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH 10/18] amd_iommu: Add a page walker to sync shadow page
 tables on invalidation
Thread-Topic: [PATCH 10/18] amd_iommu: Add a page walker to sync shadow page
 tables on invalidation
Thread-Index: AQHbr6tOWeU2oa/f2kCILqYbYvVr2A==
Date: Thu, 17 Apr 2025 15:14:01 +0000
Message-ID: <480ab3bd-e34c-4c12-b9b7-99ef754dcb85@eviden.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-11-alejandro.j.jimenez@oracle.com>
In-Reply-To: <20250414020253.443831-11-alejandro.j.jimenez@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB8599:EE_|PAWPR07MB9733:EE_
x-ms-office365-filtering-correlation-id: 2094e105-001d-4ffa-1346-08dd7dc27c0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?S1k0Y2I1cG54MDIvM0RzNW85bnkvSlRjYnlhVFhhY0hJbWY3M2NIOWtUcGxQ?=
 =?utf-8?B?SjJ2R1ZyUXo0L05Nakdqc05ONUFZZGZTb0k0dW5TeXhVUm8zNGw3bmVkVU1Q?=
 =?utf-8?B?VU05a1RpLzJhNW1OLzVZaDFTU3dOM3ZJdml0d2pqbmhVUDVJcHd5SHcrdFBm?=
 =?utf-8?B?ZnhuMy9SR1RkZ1RLK004Vmo0QkRlMVZLVHhsT0QxQlVUbWRHNHV0ZjZuZ21M?=
 =?utf-8?B?Y2ZlcmhrN0s0MHh1YnRpSVlTNFFWZGF2RENRL3BJTnF2SlA2MlQweGlIaGZX?=
 =?utf-8?B?NlJ1YnJnMVhrekdUSlpSUTlGRVBSWUpMQ1FRRkxwZCs4OE16U2lYYzdTelpW?=
 =?utf-8?B?U0xneGRIVEFDU1pSUE5oSTM3VU9GMmdpNUdhelBBa0hDYXF6d2xnYXlBRTRI?=
 =?utf-8?B?a3lnNjcrekJCUmR3elF4OFBJeDRUa1R6T0JBejhWc3kxNHBTZDMxK1FnQTBD?=
 =?utf-8?B?WC8rQ0ZTaVcwa3dKaGtCYThFMFV6am1KSVpiQm9WQk5IT2xhWG42ZkpTTHpU?=
 =?utf-8?B?eUlRUEN4QTVaK1NLWkdac05rdUl2Ly91enYvR24xODdkOHFpQnE2TnZNcGxB?=
 =?utf-8?B?bHFtRGhCTzd0WkcvOGNxMTRKME9PU3BPdStTaUxpR2ViZG5VQ3VZN2FMTWRP?=
 =?utf-8?B?anloejZoYTdjK2lDbms3TmZJUTkxTGZxTjFLVDFjOVA1cEMvbnpueVFtdFdj?=
 =?utf-8?B?QnVvMUp2UWdIOWpqanh4Rk52L2EveURrZ3EwR3N1eTBVNFVRRFRPMDlaandr?=
 =?utf-8?B?UFZJR2h1VjhPYmpJaE1MczlUcDNHY1p5R1EraHBrV016QkJFMHRLRmJFc2g3?=
 =?utf-8?B?TG1qTjVrV1VvQWxiVWJENzgza3B5TlUwcG5TdGxRRk05eERPU3VqTjRaWitJ?=
 =?utf-8?B?Z01wYkJkc1VRY2M3bm81TnhPZUZGY3NxTlZDaU5lcVY4QjBabk5wYjhScktH?=
 =?utf-8?B?cWZ2WmcxejlodmhPNUY4MHhIL0tjTEtLTmtYQml5ZS9PbktzMVRpbGJyQVQz?=
 =?utf-8?B?eHljNkh0Y2JuNlB3SlRCU3Y4UHMvL1VMUDRNdzI0MzgzR3QrWllNbUtkZXF0?=
 =?utf-8?B?WGYyMTUweWJyeDJ4RUU0L09aWWEzYmRGUDU1eTFIUkZNNDd5T1h6NG1kSnBJ?=
 =?utf-8?B?SEhUTkJreVlWWnlBbUd0UlZYVDJYTDVNVlBZcGxkZElNT1E3c3Y1RTRZYzVp?=
 =?utf-8?B?Y0JDWFBkWC9Jb0RHaDhoRitjamxFRzRrdm1FalFFbE9yd3FGYUI3eGtkWnl0?=
 =?utf-8?B?N1BPd2llNldUTUJRbFJUS3laQ0IwTHZNZEdzMnpmOFdQTXc0aC9GWWFxTUc3?=
 =?utf-8?B?WXNLL2Z1MzJ4Z0xSZ0s1V3NIZzVyQmdVRjg4K1RmcFp1d3FRb2c3TXdBSUZl?=
 =?utf-8?B?dW55cG9YM1FxcjBRNzVHaTdJcXlTKytBRG1PMWM2U3Z2bHVVRi9Fb0phVUFm?=
 =?utf-8?B?bGsyWlFGM3B6MmEwb2VJZ0Q5UWtRenRPTmpOMTZ5NXNSZTFhZ3FxQTNoK21M?=
 =?utf-8?B?VjZqR0VtLzBxOEp0cE1iMldubk9GU0ZKclJTVTBSSGF0MHBjZy9IUHVhN1JY?=
 =?utf-8?B?MVlmNGhGYk15UENJeU8vMWVUdGZONWIvMEFDMlNNWVhQSzBMN0VOLzNoL3h6?=
 =?utf-8?B?aWljamFGV3puTi85eUpHQmQ4QXBqdHhpT0EwWVpUZUh2R2l2SENENmRNY1Yx?=
 =?utf-8?B?aXNSVHJTS0hnM2ViV2VSd2wxdzNZc1lPS2xFU2Rrc0lCUkpPTzRsN3ArM0Ri?=
 =?utf-8?B?OU5jRVZVaGluenZKSHF5RDZJNEpuamtydm1uRjFmQ2xDdzVlYURiY2dHVTE3?=
 =?utf-8?B?dnQxcFBVeVhlZjlieUMzY1ZoYU5xM0ZaclE2ZlBETDVvNnZOUHZEblg5ZVYv?=
 =?utf-8?B?TkJ2TElYSFp1Nm12a0FwcWs4WURYc3RKNkFaVEJFRDNvcC9DSzh4bS9ESTlz?=
 =?utf-8?B?YmE2NytqTGdUSkRsRjFLellONEpzb3VldFNpSjRacXplczA4aDFmdUlmNlJZ?=
 =?utf-8?B?WGZpZmQ0VXBnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB8599.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmtTVVg4aUgrYlNPSEMwbmsveEVsN3gweHEraHd3dWFJUElwUTF5TXAxSHdn?=
 =?utf-8?B?MVBiVTJBejlQOFFmYUIzcWVFc2pkaXY2Q28vQ3VVdGR1eVpYbm42NWc1TVM1?=
 =?utf-8?B?eTNDU1NqTTcxZEcyM2ZvRG03V0M2alcybnF4QjRsUUtMSmVBY20vZUxJSmtw?=
 =?utf-8?B?QzdlZ2J0L092bFZ1bWJVZkU1bVR4TE1lemhtNWd6NUlJU3Nza1kxK0NEYzQr?=
 =?utf-8?B?dVpiYlJzRWdiYTJmMUJzN0lTbHFoVEVxWjNWajl6OEhENkVWRXdRVzhPQmtS?=
 =?utf-8?B?Wm1NN1lLQnBNVThmVmloT1RnRDBJcW5pNXVqRUlkcWYrQlpWS0g1UG1JRi9C?=
 =?utf-8?B?TllpL0xPR0RMSU1TdTVpamNleFVtTnJva2lFR3Y2SWZqckRjbTBZeWZ2dVBF?=
 =?utf-8?B?dkdJVTZ2cmVYTnkvVVZmTzFLWDJVdExaZUNPWmNHUGFkSXJ0T21jU2N1UUFp?=
 =?utf-8?B?VEQ5MWlvaHpRV3ZaTTFHOXh4dGluV3U0MmNXb2tzUXdWYy9RWTJrNy9oT3VC?=
 =?utf-8?B?enUzOThDZmxIaU1vdDRlWUM2RnRiNDNJVjc0Q3A3UzcwMk11WnZaSExFREFz?=
 =?utf-8?B?Z2RGZ3lqTUhOU3RjYXBPUUF6ei8zL3R1NHlJMk5vVTk0UjJtWUpudXdTaUdh?=
 =?utf-8?B?ZmF3Z3FldXl0ejZWZDBkVXU4WlFNbmg2L3dPU29UckVLdzhFNEdXb3FoSjJq?=
 =?utf-8?B?RHp0NjNpdTRveHBHNjRoZjI2dGh1VlBJaFF5dWxqUmJUc0R0eFNTNEFRblhj?=
 =?utf-8?B?Z2l0MG1uck5ibUdQNXlyVXZqSnJTT0RtbmVMTCtjdy9iTnZpeVZ4eTlFRGRC?=
 =?utf-8?B?b1REbTBVSmd0UlE0azkvblVmd2pYWkhzL2gvYlAxZnhNUjlQL1pjY3BhL0JY?=
 =?utf-8?B?NXRFa2ZpT0FuWld4NkZUcWdmRmd5V3ZUTHVaV1JuZ0RvaHlMTnRmMEJKcU9X?=
 =?utf-8?B?OGt6TjIzbW5xYUtHQ2ZQb2hlSjVSZmM5Q1hQclc5Y3oyb3dyTG42R1NpK1E5?=
 =?utf-8?B?YWRyeVQrRk9hclM2R2E5Nm1XVDVkbjBVM2dKRTEyeHJoNzhoUThOclFNekE5?=
 =?utf-8?B?YXprYmZET2tTaHJsTW56YStOaHROc2UrZDFGSkdHTmZMMG9zQlVYYWNoSzY5?=
 =?utf-8?B?N3dkcTRIM0NFZnFQOWdkL0NaK2xlN0hXYTRRMFdZNkFWeFJ2Q1o1dUIwKy85?=
 =?utf-8?B?ajM3eG9tRnRsamRqOUJxYUtQWEQ2WjcvQWg4UkRtUDJPTTBHdnU1c0M4Tm42?=
 =?utf-8?B?eDN5alpmNTRoaE5GS0xZRU1ydWwwMU9yLzFxeWcvRm9wUzJwU3pQcEJGM21N?=
 =?utf-8?B?SFRyR1BRalFvR0lzaFNQRVM5NTBTNnhrMnQvZkNYc2lpZUgrdUdTTDNJVHdm?=
 =?utf-8?B?bWJPbkdGVjFOTnUyRjk1WFB1YU1YVnZOTDVzd2ZHYmJ2QVBZb0hvNTJEbGxm?=
 =?utf-8?B?ZEdocUw1c3dVblN3T0RIeTFkRkY3alVyK2NMbmVKZHRpaXBraWJBakc3U2Zq?=
 =?utf-8?B?aTJCK09ZdzRPLzNiakN0bUVFenR4UFVwQ1dIMTVTMDYwQzRUVzZFSVJsbnVB?=
 =?utf-8?B?RG5PUEh1TUFRMG1FbmNhUUVVNG9FZGhWaTd5TUxmSUZ5RnZvQjZmekppa2c1?=
 =?utf-8?B?MHlXQnJyTEtHcU5aeVhnelBBMVg0a0VZNE9XaUN0Yjg0N0FmYTRhZ1dDUVM1?=
 =?utf-8?B?VWRzNW9Yb3RHdWkwL1VUL3daUUl4NHZlQU9UdndDcittZEcxYWRiQmZMZUF6?=
 =?utf-8?B?WTVaUy9xOXpiRnRibnh4Ny9GTGI0eVN5STFPNEZVaXlNdTB6dndpdnZSVHUy?=
 =?utf-8?B?U3J2d2xLK2hlcTA0Z2wxUHE2VGtUck5DMnNycFh2dFZ4WkNKMFF2ekM0YU1K?=
 =?utf-8?B?alRKUDFLUGFtM2JqL3hCMnBkTHFZemxUYkhMeFJFSUJ5SU9OU2ZlWloreFpE?=
 =?utf-8?B?OTQ5bzBOQkI2ZVZEYmlRa2paKytzVVJrbGNnRFU3djNlT3lrWnNTMS9udFRZ?=
 =?utf-8?B?aWdJdjlxTjZiUGM4UWxPQkQvV0tPMjRBcDUyMjhnQko0eTc2NG5vWHdvdnBr?=
 =?utf-8?B?elVaemtiSW9mbnp4ZFBZUFdScExYOTZoY1gwSzdhTVBzeWd0TWIrZHlhdFFG?=
 =?utf-8?B?UmMrV01SeUl3TVF6RDBkbWtPclNhQXo0Q2tOME5YMG9PZXFoNllRQTRoMzNx?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45CD9A4322D5C041A2242DF460708616@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB8599.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2094e105-001d-4ffa-1346-08dd7dc27c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 15:14:01.4414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbPC/f8G8O7Z5EKzQWKMx7bX7XarJQVIUh7yZe7F8QP14Eaym2OShYeoDO0juNTFOEoJtoqdBEkxJ6kOUDmcaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9733
Received-SPF: pass client-ip=80.78.11.83; envelope-from=ethan.milon@eviden.com;
 helo=smarthost2.eviden.com
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

SGksDQoNCk9uIDQvMTMvMjUgMTA6MDIgUE0sIEFsZWphbmRybyBKaW1lbmV6IHdyb3RlOg0KPiBG
b3IgdGhlIHNwZWNpZmllZCBhZGRyZXNzIHJhbmdlLCB3YWxrIHRoZSBwYWdlIHRhYmxlIGlkZW50
aWZ5aW5nIHJlZ2lvbnMNCj4gYXMgbWFwcGVkIG9yIHVubWFwcGVkIGFuZCBpbnZva2UgcmVnaXN0
ZXJlZCBub3RpZmllcnMgd2l0aCB0aGUNCj4gY29ycmVzcG9uZGluZyBldmVudCB0eXBlLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQWxlamFuZHJvIEppbWVuZXogPGFsZWphbmRyby5qLmppbWVuZXpA
b3JhY2xlLmNvbT4NCj4gLS0tDQo+ICBody9pMzg2L2FtZF9pb21tdS5jIHwgNzQgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NzQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvYW1kX2lvbW11LmMg
Yi9ody9pMzg2L2FtZF9pb21tdS5jDQo+IGluZGV4IGQwODlmZGMyOGVmMS4uNjc4OWUxZTliNjg4
IDEwMDY0NA0KPiAtLS0gYS9ody9pMzg2L2FtZF9pb21tdS5jDQo+ICsrKyBiL2h3L2kzODYvYW1k
X2lvbW11LmMNCj4gQEAgLTE2ODgsNiArMTY4OCw4MCBAQCBmZXRjaF9wdGUoQU1EVklBZGRyZXNz
U3BhY2UgKmFzLCBjb25zdCBod2FkZHIgYWRkcmVzcywgdWludDY0X3QgZHRlLA0KPiAgICAgIHJl
dHVybiBwdGU7DQo+ICB9DQo+ICANCj4gKy8qDQo+ICsgKiBXYWxrIHRoZSBndWVzdCBwYWdlIHRh
YmxlIGZvciBhbiBJT1ZBIGFuZCByYW5nZSBhbmQgc2lnbmFsIHRoZSByZWdpc3RlcmVkDQo+ICsg
KiBub3RpZmllcnMgdG8gc3luYyB0aGUgc2hhZG93IHBhZ2UgdGFibGVzIGluIHRoZSBob3N0Lg0K
PiArICogTXVzdCBiZSBjYWxsZWQgd2l0aCBhIHZhbGlkIERURSBmb3IgRE1BIHJlbWFwcGluZyBp
LmUuIFY9MSxUVj0xDQo+ICsgKi8NCj4gK3N0YXRpYyB2b2lkIF9fYXR0cmlidXRlX18oKHVudXNl
ZCkpDQo+ICthbWR2aV9zeW5jX3NoYWRvd19wYWdlX3RhYmxlX3JhbmdlKEFNRFZJQWRkcmVzc1Nw
YWNlICphcywgdWludDY0X3QgKmR0ZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaHdhZGRyIGFkZHIsIHVpbnQ2NF90IHNpemUsIGJvb2wgc2VuZF91bm1hcCkNCj4gK3sN
Cj4gKyAgICBJT01NVVRMQkV2ZW50IGV2ZW50Ow0KPiArDQo+ICsgICAgaHdhZGRyIGlvdmFfbmV4
dCwgcGFnZV9tYXNrLCBwYWdlc2l6ZTsNCj4gKyAgICBod2FkZHIgaW92YSA9IGFkZHI7DQo+ICsg
ICAgaHdhZGRyIGVuZCA9IGlvdmEgKyBzaXplIC0gMTsNCj4gKw0KPiArICAgIHVpbnQ2NF90IHB0
ZTsNCj4gKw0KPiArICAgIHdoaWxlIChpb3ZhIDwgZW5kKSB7DQo+ICsNCj4gKyAgICAgICAgcHRl
ID0gZmV0Y2hfcHRlKGFzLCBpb3ZhLCBkdGVbMF0sICZwYWdlc2l6ZSk7DQo+ICsNCj4gKyAgICAg
ICAgaWYgKHB0ZSA9PSAodWludDY0X3QpLTIpIHsNCj4gKyAgICAgICAgICAgIC8qDQo+ICsgICAg
ICAgICAgICAgKiBJbnZhbGlkIGNvbmRpdGlvbnMgc3VjaCBhcyB0aGUgSU9WQSBiZWluZyBsYXJn
ZXIgdGhhbiBzdXBwb3J0ZWQNCj4gKyAgICAgICAgICAgICAqIGJ5IGN1cnJlbnQgcGFnZSB0YWJs
ZSBtb2RlIGFzIGNvbmZpZ3VyZWQgaW4gdGhlIERURSwgb3IgYSBmYWlsdXJlDQo+ICsgICAgICAg
ICAgICAgKiB0byBmZXRjaCB0aGUgUGFnZSBUYWJsZSBmcm9tIHRoZSBQYWdlIFRhYmxlIFJvb3Qg
UG9pbnRlciBpbiBEVEUuDQo+ICsgICAgICAgICAgICAgKi8NCj4gKyAgICAgICAgICAgIGFzc2Vy
dChwYWdlc2l6ZSA9PSAwKTsNCj4gKyAgICAgICAgICAgIHJldHVybjsNCj4gKyAgICAgICAgfQ0K
PiArICAgICAgICAvKiBQVEUgaGFzIGJlZW4gdmFsaWRhdGVkIGZvciBtYWpvciBlcnJvcnMgYW5k
IHBhZ2VzaXplIGlzIHNldCAqLw0KPiArICAgICAgICBhc3NlcnQocGFnZXNpemUpOw0KPiArICAg
ICAgICBwYWdlX21hc2sgPSB+KHBhZ2VzaXplIC0gMSk7DQo+ICsgICAgICAgIGlvdmFfbmV4dCA9
IChpb3ZhICYgcGFnZV9tYXNrKSArIHBhZ2VzaXplOw0KPiArDQo+ICsgICAgICAgIGlmIChwdGUg
PT0gKHVpbnQ2NF90KS0xKSB7DQo+ICsgICAgICAgICAgICAvKg0KPiArICAgICAgICAgICAgICog
RmFpbHVyZSB0byByZWFkIFBURSBmcm9tIG1lbW9yeSwgdGhlIHBhZ2VzaXplIG1hdGNoZXMgdGhl
IGN1cnJlbnQNCj4gKyAgICAgICAgICAgICAqIGxldmVsLiBVbmFibGUgdG8gZGV0ZXJtaW5lIHRo
ZSByZWdpb24gdHlwZSwgc28gYSBzYWZlIHN0cmF0ZWd5IGlzDQo+ICsgICAgICAgICAgICAgKiB0
byBza2lwIHRoZSByYW5nZSBhbmQgY29udGludWUgdGhlIHBhZ2Ugd2Fsay4NCj4gKyAgICAgICAg
ICAgICAqLw0KPiArICAgICAgICAgICAgZ290byBuZXh0Ow0KPiArICAgICAgICB9DQo+ICsNCj4g
KyAgICAgICAgZXZlbnQuZW50cnkudGFyZ2V0X2FzID0gJmFkZHJlc3Nfc3BhY2VfbWVtb3J5Ow0K
PiArICAgICAgICBldmVudC5lbnRyeS5pb3ZhID0gaW92YSAmIHBhZ2VfbWFzazsNCj4gKyAgICAg
ICAgLyogdHJhbnNsYXRlZF9hZGRyIGlzIGlycmVsZXZhbnQgZm9yIHRoZSB1bm1hcCBjYXNlICov
DQo+ICsgICAgICAgIGV2ZW50LmVudHJ5LnRyYW5zbGF0ZWRfYWRkciA9IChwdGUgJiBBTURWSV9E
RVZfUFRfUk9PVF9NQVNLKSAmDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHBhZ2VfbWFzazsNCj4gKyAgICAgICAgZXZlbnQuZW50cnkuYWRkcl9tYXNrID0gfnBhZ2Vf
bWFzazsNCj4gKyAgICAgICAgZXZlbnQuZW50cnkucGVybSA9IGFtZHZpX2dldF9wZXJtcyhwdGUp
Ow0KDQpJcyBpdCBwb3NzaWJsZSBmb3IgdGhlIGR0ZSBwZXJtaXNzaW9ucyB0byBiZSBtb3JlIHJl
c3RyaWN0aXZlIHRoYW4NCnBlcm1pc3Npb25zIG9mIHRoZSBmZXRjaGVkIHB0ZT8NCg0KPiArDQo+
ICsgICAgICAgIC8qDQo+ICsgICAgICAgICAqIEluIGNhc2VzIHdoZXJlIHRoZSBsZWFmIFBURSBp
cyBub3QgZm91bmQsIG9yIGl0IGhhcyBpbnZhbGlkDQo+ICsgICAgICAgICAqIHBlcm1pc3Npb25z
LCBhbiBVTk1BUCB0eXBlIG5vdGlmaWNhdGlvbiBpcyBzZW50LCBidXQgb25seSBpZiB0aGUNCj4g
KyAgICAgICAgICogY2FsbGVyIHJlcXVlc3RlZCBpdC4NCj4gKyAgICAgICAgICovDQo+ICsgICAg
ICAgIGlmICghSU9NTVVfUFRFX1BSRVNFTlQocHRlKSB8fCAoZXZlbnQuZW50cnkucGVybSA9PSBJ
T01NVV9OT05FKSkgew0KPiArICAgICAgICAgICAgaWYgKCFzZW5kX3VubWFwKSB7DQo+ICsgICAg
ICAgICAgICAgICAgZ290byBuZXh0Ow0KPiArICAgICAgICAgICAgfQ0KPiArICAgICAgICAgICAg
ZXZlbnQudHlwZSA9IElPTU1VX05PVElGSUVSX1VOTUFQOw0KPiArICAgICAgICB9IGVsc2Ugew0K
PiArICAgICAgICAgICAgZXZlbnQudHlwZSA9IElPTU1VX05PVElGSUVSX01BUDsNCj4gKyAgICAg
ICAgfQ0KPiArDQo+ICsgICAgICAgIC8qIEludm9rZSB0aGUgbm90aWZpZXJzIHJlZ2lzdGVyZWQg
Zm9yIHRoaXMgYWRkcmVzcyBzcGFjZSAqLw0KPiArICAgICAgICBtZW1vcnlfcmVnaW9uX25vdGlm
eV9pb21tdSgmYXMtPmlvbW11LCAwLCBldmVudCk7DQo+ICsNCj4gK25leHQ6DQo+ICsgICAgICAg
IGlvdmEgPSBpb3ZhX25leHQ7DQo+ICsgICAgfQ0KPiArfQ0KPiArDQo+ICAvKg0KPiAgICogVG9n
Z2xlIGJldHdlZW4gYWRkcmVzcyB0cmFuc2xhdGlvbiBhbmQgcGFzc3Rocm91Z2ggbW9kZXMgYnkg
ZW5hYmxpbmcgdGhlDQo+ICAgKiBjb3JyZXNwb25kaW5nIG1lbW9yeSByZWdpb25zLg0K

