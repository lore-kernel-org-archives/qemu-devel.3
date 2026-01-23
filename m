Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEA4D6CFDC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 06:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjAV0-0001Jv-JV; Fri, 23 Jan 2026 01:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vjAUy-0001JS-Hq
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:18:24 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vjAUw-0000C0-8I
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:18:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eu1ZzrRwrY5e+BnlPzt6z/m3gJEblgmEUoTRfRwIXX/NTYcVQ9NhSfp3X1Su1jaRH64V2UBOZAYNAcI0KifIHdVwsgfrfqUSuhoKqE+PaArbdt6LU9bJKV/LPJ13i9TS6tdNJs7qk8PfqPL0OL6WmSqw4cOJb2JPQEoZCNDeb45VsjsUR+5vQ8QPUgn5FLAcYWJhlvvB3oBVPCnvFnh8AOJJpHLBS5WwQmLzalDvSC+DpOenzvvtDiVNtX6+lLUwdXUxGX6iQuivZjNH+cq4514/9NYOLk7uCJtVwBQuKFF1ek9F6Pn8kgPXtJbgaUyotdBbsRRD2fU9GZxtYnq6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tag0nHIEjkLagx2fZaySijXpqoDZuxzw4YrRIcqTiI=;
 b=rY/BMJKD3zTfuP2x6dJ66ml3CV0J2bKA8BRj0mmbjWVZU5lj7SGnRzytz16kbEHubnKU5tggVjoFGAbqoARV5mEDQ3qMRwsUKYyYhVufsqYgqlJxn08j+xqYgXcG9HKLoQNwDSZ/pOOWV4P3vQdVFXFrNwmAG4PcBtFYdcjJlT80aMtPCzQbje/VI6fx2u1lEHZwM8XnLJT5l3vd0FLZTFTuEemApF9QcHEKMpAcxAzBE+9PQvcMSFaBqsiMHj7YWd5OtG6VAR6X31I4mjto1JNUALCKY0gjbx2/9BYRCVPWzR5Kyo6lNbN8kWB0L9EQfnAbILAIHXKP0hTFfn6xjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tag0nHIEjkLagx2fZaySijXpqoDZuxzw4YrRIcqTiI=;
 b=Ov8nlIAT7bZSE0T2xoeTK3LnTi8Wgdq8LaoOIU/jIrcvq0gJsauDdUXZnWmvtoP7dI2lBVLo3A01R+EA+26GcrVcv9/AOF75IFPldKCzDYaMBxsF0/ps1o/u9q5XQp6ySXNEO1Zjl/C4KEIx6QxUorFcOx8r/NqV+PYpRkZ9OO64gDcdWPQWVV8vwcns6vDG4buN4xfdImiH2zk7jC6EzNRJP2IY/zJRa9hcPOLP3NWssMTP5CjGw/OK8t9E10asMoaF+L+61EmFkf36MUInEaf11ClhQc4h/e601ox5Meav6NVoY3TIb85l2XZYn6lfnOaTBqsUc19+TSaqcMPRHA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SE1PPF12339C7D1.apcprd06.prod.outlook.com (2603:1096:108:1::409)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 06:18:13 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 06:18:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Michael Tokarev
 <mjt@tls.msk.ru>, "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: RE: [PULL 0/3] Update vbootrom image to commit 1c8e9510b22c
Thread-Topic: [PULL 0/3] Update vbootrom image to commit 1c8e9510b22c
Thread-Index: AQHchrn9D+vfYwM4mk6SyACbYX4WXrVUoqKAgAQSGeCABobxQIAAE6QAgAACFvA=
Date: Fri, 23 Jan 2026 06:18:13 +0000
Message-ID: <TYPPR06MB82067B5023CE08BB65C19EC6FC94A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260116073024.3485812-1-jamin_lin@aspeedtech.com>
 <ce304e18-b28c-4a85-a765-4a3f2680901e@tls.msk.ru>
 <TYPPR06MB82061980D169464392781CC9FC88A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <TYPPR06MB82063DC02D7CF460FEECBB47FC94A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <51858398-a366-4d48-8890-b8ef438bff4c@kaod.org>
In-Reply-To: <51858398-a366-4d48-8890-b8ef438bff4c@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SE1PPF12339C7D1:EE_
x-ms-office365-filtering-correlation-id: 0b0eab0d-701c-43a0-1c35-08de5a47308e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TGtFT1ZuUFA3azRkQXA0Mk1kanJ3dEV2Tkd0WGtrakg2dzhiK3JDNzh0cDk5?=
 =?utf-8?B?RGoxVXZUbXFMZk95dm9aSitMa1hBQjJlcmkzNTR4bUU3L2h5NVp0VXF1a0dI?=
 =?utf-8?B?clNJWkloMld0U0IyQ1RBaXNlMzFxMkFLSzk0S2c4bnRtVy9zN0JMOGJrTDNj?=
 =?utf-8?B?Mk9NWXRMOFlETndhaE13NTNHci9lVWVxTXgvekRKSmsraTI1dkJBN082ZHlH?=
 =?utf-8?B?aVFnSWVreFdIOFBsa3N1RlM3TW9kUTZibWNJcjBJamc0OWRFUmJXanpJMkMw?=
 =?utf-8?B?V3JaQkM3SlNENHFWV2dYWmIvMnIxSnd2RS9uU3NNNWd3RnZ3VkJxMWk4YlFz?=
 =?utf-8?B?RE1sSSt3S3pOSWlQSER6TTg1V1BrOHZDZUxPWTRyQ1gvbHY2L1diby8yS2gw?=
 =?utf-8?B?RzNSTkhGUEozTjNVV2IwZkJGQTVyMmxoSUJjMDRwZ2lveGNiNFVDZEsyQk84?=
 =?utf-8?B?cW9pRWE4RUhiekJTdWtoeHFOTkUxdHJzelMraWFzbjBtQnEydHpSaW1qYlB1?=
 =?utf-8?B?U2Q1RnNEM3lQcTF6L0w0RERScmFIcnY4cGtsZ1Byb3NSUlF0eGFFZGp4QWZ4?=
 =?utf-8?B?aVpBM0JSSjJ6Z3RtZXlQWmlyT3FXWE41WjJheSswZFVmd0ltYWc5d29ld2ls?=
 =?utf-8?B?N2VIM2NsYVdlaEtBbTUxV3c5VGlLL2h6ckpEVXltdGxNZVJVTFVqcHV3NnBG?=
 =?utf-8?B?SjZEcUtnYkVmL1FLS3BtUVZ5QUtmd2tIb2NjWmFnbkltRlR5VDlYbkx2T2dU?=
 =?utf-8?B?cUREd24wZ2lZNmJVVENGSDU5b3pRdVA1QThxaUczYUFLNmVPUUIybEdVa0o1?=
 =?utf-8?B?RGtpaklWd0tjZ0dWTFI2QUFUajBYaXJlQkYzLzR3NUlPQkhnc3lyc2xCNVNv?=
 =?utf-8?B?b042a3ZuN2l5STdJV3JiNEVMeWtTQ3JuN1Q1SXpoT2dJd2ExcC9SOVdhYXZu?=
 =?utf-8?B?VjdtcmlQNW1pTzRibU5zSFNzbVpwaGZ2TitRQzJYSzRIN2VCcTk4dENIZUR4?=
 =?utf-8?B?ZXFGRWxYREp6eldiVktNOTcydGltejhLVmhhM0tMOVAvaXZUL2M3SGkrOUwr?=
 =?utf-8?B?aWpUNXRuNmd1V1NPVzJnTHI4MUtsdXJXM0FsYVdVRnI3Zkl2NTl5NWpEZ1JZ?=
 =?utf-8?B?Tzk0Q3laUWdua3Y4VjRhNDhreUJlb0x5SlVxNm9UaTBPMVQyVHp6dDJwQUJ0?=
 =?utf-8?B?MFJoVllKZStzMWVjc2dhODRyYnBnOEdoRm9pU1RCVHJyL1JIZERMbnpzMUxn?=
 =?utf-8?B?VTFUUHdONlJURjVpMER5YUlZQUNLRlExY2VZaU9yQXQvaUFiTGlIWHdreUQ3?=
 =?utf-8?B?d2pNK01SR2RjYk1mRE1GVEVORlAxcWlUSmJQS3p4Sjh2YnJzMklSSGdacld5?=
 =?utf-8?B?MHpHV1hrZUJuMHpJL0QxVE5XNHJFZjVKczBoYXp6bTQ4NE9NU1VFV2dGZHIv?=
 =?utf-8?B?Y1ZtSHEwQldEKzhWRnBYb0szY2lpZmpwM2lETUJTYkZYZHA4R1FPSklWM0sw?=
 =?utf-8?B?bnlqTnZvdjJVSCtQblo2clF1ZmFXRDBkNTM0NElERkJZMXpsckxhQVZiOXVy?=
 =?utf-8?B?MWlRb2dLZ3hSaGJOMnZGSEZ3aHY3a2FES1d3ZjZWY3FmUzByOEN2dmpaTjR1?=
 =?utf-8?B?RWdZaWFEcDJwYXVVREFaZkdlZTF3RjZDUDV1Wi90Ulo4LzNiMWozSlBzd2dE?=
 =?utf-8?B?Z2plMHVLRE1LWW9ZZk4yU0cyZVNGVjlaOW16NnZPNmRXU1pzK0R2QjAvdTBP?=
 =?utf-8?B?T1V4OUZIYjJjb04vbDZvQldtNzNnRStXUFFRSXZwdnM2NDVZb0pmZUkreVI3?=
 =?utf-8?B?K2J1bkJ3S1VxR1k4NnF6WG5FYlJlRkJGLzlxaTFnaHlQMXVNWVNBMGJwV29L?=
 =?utf-8?B?LzF1Yy9iWnBCQUhIUmpNd2tnamdLMXkzU2Y4dmczZzFVTWlpUXVTODZESXd1?=
 =?utf-8?B?S2VlZnBaNWlGMGlva2VVM3g2ekowbysyK2YxRDN4Y210dHA1ajlpZ2ZvdURO?=
 =?utf-8?B?RWdhSmNKeUhQOTlKZ1FHYmFaMEZjYWdBWkc2ZWdzUHVqeGJ5K2kwNitiRUFl?=
 =?utf-8?B?Uk5hSXlkS3BLREw3bHdhWWI0WnBqLzVCMEJSU214eWJxMndzM1NreWRqMUEw?=
 =?utf-8?B?WjU2Mjg4SWliRC9ZU2pQTE5iNk55REdnMzFoekx0Qm51NlduUUVCTG4wWWdF?=
 =?utf-8?Q?uVVF/v7vKe1Tkm2znW5cuZQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODFSUlJiSzY5elRWb3hqVHl0MmxPUW1WTm1OTnBueWs1MzlaUkR1d2RNb0Nn?=
 =?utf-8?B?REZWNGdGdExkK1Z3K0hPYnlCUUN5R3J0SHBra0hiUjFSTmJuSi9tTWxWNkFB?=
 =?utf-8?B?SlpsbWhoWGJYMFFtQkk5dWhyWW5yamJONWFKcFhmeDFnbEh3cnlzL3hnenVh?=
 =?utf-8?B?dENKRG8xakR6bHdZcnNqek12MWlpWTBkY25KYjFiK0FLdzc4K1pIalpoTmtv?=
 =?utf-8?B?bjdpTFBUYVZaYVpkclVIVGhTSVQ2OThhNjV3Q3NjbTdLNndVbHZrR3FjdGYz?=
 =?utf-8?B?QnlZY3hNRldoVUtSemVLY05DUU9JYUpiSXJDTWpJMWxXbXJhNEp2L0RuT0V1?=
 =?utf-8?B?a0JGem5ja1ZHMk03VGJtSDZhY0tFekUzdFFlL1JFajRCZXdsbW9pZ0lxMWMz?=
 =?utf-8?B?cUlzSDNDNjN1d1ZNdkJkVENGS3l4cVFLdkZ5Yks2dUlIZzdFdEZucC9vZ1p4?=
 =?utf-8?B?V2haM3JoclNXaXNZRnNTYUxjdUR2UTZMMEhwQzljUVVoTU9zN0J0cUp5TEdz?=
 =?utf-8?B?YVhKOGtPOEI5VlNjemZLeXRlUEFNNEEwVW5TSUwzZU90VGpVZS9KNnF1NTU1?=
 =?utf-8?B?RFFsM0ZIUjBrdnUzQlFxUlV4Z2RFQWlVUG52YkpVNmtoU0hvcEtlZ1h3QTlx?=
 =?utf-8?B?Z3FrSHJrSy9lM0JsZHA5blk2WkxaMGZzSkxRWm1ZVEh1L2oxZGhzZkdtZFlZ?=
 =?utf-8?B?M0ZPbytsTkFFVmg5UStkYjhIc0tOWEg2b0ZkeHd6MmNIdkpNTG5paHZvS1FH?=
 =?utf-8?B?NlI0WWwyaXRIM3MzcHFhZXl6UHlJeDNUQmdSVTY2N050N3gxcnk4c3RKTURm?=
 =?utf-8?B?bkxDRzNnWmJoaU95WEY0a3FSYXl1RXFHdVpIT1ZQQW1lRXFXb2R1SWdyTWw1?=
 =?utf-8?B?VEtTdm02WGJDNTYwOW1iblBoMUJ0dmJxMHVocVVWMHM4aWJ6amZpMVBNSFZv?=
 =?utf-8?B?ZVhrK0JWWXAyM3F1VFNZMm9LUDk2YnE4aFBwQk94Uzd2d3F4a01ZVDZaWHFx?=
 =?utf-8?B?OEFHM1NMaS9iMDd3K2FlTlBZZ2VTUS8wNXdvWHlEUyt2cmxlcXc4ZkZXZFdu?=
 =?utf-8?B?ZjBlaVdmaHVwSWx5aGpMc3ZxQkIzdS9pYzJtejZDUFExaWRwY081V3hZZ3J1?=
 =?utf-8?B?SjZTMXNjZ0tYZUZOWldZekN6L2xVaGljN2ZtaHUvdEdTTWt5ODdqWU40bkZu?=
 =?utf-8?B?L1pZa1RiNUFlSkRBNVlLcUNNeHUwVHEvQ2xRUTMvNDdWbXZxdXlsZi9UL3c5?=
 =?utf-8?B?OGxpcVR4SEx5TFVvNU4wNGgrNXpVZW1aQ3dROU8zM0ZNMUpsdmdDa25qb3Fl?=
 =?utf-8?B?U0d5U1l5WmEwc09RMmFnZE5uQjVHcGZ5MFhKSnUzNjhsOStCUW40ZnR6elRG?=
 =?utf-8?B?czVYdXlrTG1iS1c4RmFNYWMvVVByekx6YWlJUloraUxvQ0RSQ2VQTCtqZDUr?=
 =?utf-8?B?MmJvYVRNZ3VSekZ2bjlFMXZBSDVOMHRlUkNkYVpuWEh3SmJjTmRxMXo5dUJi?=
 =?utf-8?B?Q3hnMVc5WkRsUFgvc0xVYkc1L1VncUg1Qk8xTjNnSjIwZmwrM3NlY01pMmdU?=
 =?utf-8?B?MnV5Nmh6UEdMdDFRUlJwcFUrdlhwcnFUTDYzNEZsQmg4T243d2lwWWRJRmo5?=
 =?utf-8?B?NktiOHhUcE9ySUdNUFZiR2Rpa0VmeCtocXZ0MG5vRVQ3aEpkT3ZrV0Z5TzZv?=
 =?utf-8?B?azlJTGhoSXluV0xzd3dyTkRGMWVvaXh6ZnVQUHY4YUdlaVYxeFEvenZJNnpm?=
 =?utf-8?B?VUlESmFaWHgvd212UCtyN3I0QjhUUldqY0o0TlVBNHdwanJYYS9MVThXRnll?=
 =?utf-8?B?aGxqRGFZVkJLSlpHK3dMM3JiVTVWNzc2NFlDRUJsVlpTWUlnL2JUV0FUdWlR?=
 =?utf-8?B?bTBJU2tyMHR0bXpBaE01cWFSNklUTVQvRGtqVW5nMlhUQzRKVW9uTkg0ZjQy?=
 =?utf-8?B?RTZKellWbFdJekNLZVY2L296aDRKVXhzdjhtY3JMdTVPUmErcFNhVi9rSTZo?=
 =?utf-8?B?OUFUcDdsYVJVdWU2VUt0cEthckRQSnp4QVF4Y3B6U2dQYmwzK2tlc0Y1aThM?=
 =?utf-8?B?TDZUTGxOcWtuL2hwdEVaR1dNZmNqUzF6TGY5WmkxZlhnWFFSc0tFZE01cnR5?=
 =?utf-8?B?YzFqSHg4dzlWMzFranRXZVl3UnhEeGFOT0dRTTk4bGhSZWFocTJKd2IwNUZ3?=
 =?utf-8?B?UE9VdTdaRit3V1ppbmpoMEdMUVhlSi8xVGZNYlZGV0pCZWdMM2VpdVdtTzY5?=
 =?utf-8?B?Zk44eGRoNWp1UVFzK0FtSHhoWC9Na041clI3T2s5YWJGalZyZHB3YkZWTzFB?=
 =?utf-8?B?VnZ0K1E3RW1hQ1JFN2hpR3JSMjB4ZWJvYVpKd2FmWW9NOHBlOWJZdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0eab0d-701c-43a0-1c35-08de5a47308e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 06:18:13.6493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2+IjKcNjAl65FsKXgGPl9niQYF67/i0UojuRIFG4G2N2cT0V9ZwmsErrgIpQpjJZMV4E1CezbVmmjn0/osyP72/wsuzYcsiDAck4lnKhvz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF12339C7D1
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgQ8OpZHJpYw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEPDqWRy
aWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAyMywg
MjAyNiAyOjA2IFBNDQo+IFRvOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47
IE1pY2hhZWwgVG9rYXJldg0KPiA8bWp0QHRscy5tc2sucnU+OyBvcGVuIGxpc3Q6QWxsIHBhdGNo
ZXMgQ0MgaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BVTEwg
MC8zXSBVcGRhdGUgdmJvb3Ryb20gaW1hZ2UgdG8gY29tbWl0IDFjOGU5NTEwYjIyYw0KPiANCj4g
SGksDQo+IA0KPiBPbiAxLzIzLzI2IDA1OjU4LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4gSGkgTWlj
aGFlbCwgQ8OpZHJpYw0KPiA+DQo+ID4gRG8gSSBuZWVkIHRvIHJlc2VuZCB0aGlzIFBSICh2Myk/
DQo+IA0KPiBJIGRvbid0IHRoaW5rIHNvLg0KPiANCj4gPiBJIGFtIGN1cnJlbnRseSB3YWl0aW5n
IGZvciB0aGlzIHBhdGNoIHRvIGJlIG1lcmdlZCBzbyB0aGF0IEkgY2FuDQo+ID4gcHJvY2VlZCB3
aXRoIHN1Ym1pdHRpbmcgdGhlIGNvcnJlc3BvbmRpbmcgdXBkYXRlIHRvIHRoZSBBU1BFRUQgU0RL
DQo+IHYxMS4wMC4NCj4gDQo+IEkgcGxhbiB0byBzZW5kIHRoZSB2Ym9vdHJvbSB1cGRhdGUgaW4g
dGhlIG5leHQgYXNwZWVkIFBSIGJ1dCBJIGNhbid0IHRlbGwgeW91DQo+IHdoZW4uDQo+IA0KDQpO
byBwcm9ibGVtLg0KSSByZWFsbHkgYXBwcmVjaWF0ZSB5b3VyIGhlbHAgYW5kIGtpbmQgc3VwcG9y
dC4NCg0KVGhhbmtzLUphbWluDQoNCj4gVGhhbmtzLA0KPiANCj4gQy4NCg0K

