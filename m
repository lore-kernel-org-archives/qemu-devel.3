Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC1BC369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 06:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u388q-00014O-E3; Fri, 11 Apr 2025 02:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u388Z-0000on-8q
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 02:45:16 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u388T-0000u7-Mt
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 02:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1744353910; x=1775889910;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=REPVQ9vI0sS/+qMZ4glxJmzR6YVKe+pGOIewWyc4Uns=;
 b=myAA82ElJVz3aNCKk8PLuqNmBjBlRsBkxdyXJ9VldsVazb4L3SXhmYUe
 gd4vZJqC1fPsOpOHfSnDbKRH3z1njx8U0DZFZaGFcS+U02HhTU7RWE2s6
 b1+LEKikFt1Qe/ZTb7w0YUMoO2jvWM+HejlJZHZqJ+Dz+qYWTIb9VhRf0
 mb75hDBdx9M3Fbga5AGj6Qbd+opHJY0cxngbnrVUChyzaQeClFHnQ1vsg
 d1scbfM123b0TTZE4upgzl903nBeOr9OD4598QzdCz9/HU9eHxofYaov/
 EDg4iaJLahtzQH3z5JW8XPwfm8AYcvl+UncA72VCR7VVcIgwD6kRRFqXU A==;
X-CSE-ConnectionGUID: vTUZdKcXRraRATf0v3sUxQ==
X-CSE-MsgGUID: rT52LG+zQ0GP/czrojztXQ==
X-IronPort-AV: E=Sophos;i="6.15,203,1739833200"; d="scan'208";a="34844029"
X-MGA-submission: =?us-ascii?q?MDFXQKqwNCPq7jjfBZ2vWwjebu4szBnx86OCrL?=
 =?us-ascii?q?AmibUZ04QbtbZsBx+wvjcNrvie6Me6KnaJmnDe5z/arHOgmz38C82E5I?=
 =?us-ascii?q?7vhUT4Dd5Fe8s6xNHSMAu8+bXW9MlzOH6s3IqWaV4QrNY8wT/vYM9K60?=
 =?us-ascii?q?+hAbqae8Uhl+LtwFNLjMRHoA=3D=3D?=
Received: from mail-db8eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.110])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 11 Apr 2025 08:45:01 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izHOXgmK6oHYeWkh+n3wWfJJWtg90Dr0nzR+0AYdK6j3h14p0opXCVV6/rVEWyypJtLhZZ2vivKMgV39gp+dwmW7Bo5DPBajxkbHU+ZCXJtaXqbCh6/U6KNHA7xM9R2cBlRdiqyKPNPSVY5CBGOCxuW6Lk1EqTtS7+nvbFPhFvf7vC5ETDvPi6baWQwHyFPsQyG/zRr3m4vmUFL1C3PQS+BifD1UJhs99SPRe6WYREaS7yhkQ3+oWuf0u/E0285I4N2qUr219fKSR/NsR31UThj2/wg34tXEikzN6BbZOE84hN35tQ7XhCvbQFOFf5/avxsD0ckBSYoH9a0TX9cB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REPVQ9vI0sS/+qMZ4glxJmzR6YVKe+pGOIewWyc4Uns=;
 b=FT9KZ9sR6+Tco7y6/03eeMQ4oKBT1FMDXJcValMjX1ZCS14z62wAjYrcvhEgU0wejxmiRijL7ob6Clm7fOWiyCU7ngRlswcvxPJgnh7kl7W7jpLYSczoHLasauyjVQSp3r58OjmdB1cCvQkVnqwEaiKSk3p8ENlolpg3e+nYQETA9Vja4Voz083SM6hfRZ2RpI6dhaZrFySayfB/VhK19a9wD/PsaUnVsJGC1lrA/Z11fgVyNl3KxiLGb7CJ+7I57RGKZPmh8s4vETh2W5HD3EBYka/VjqqkTQVOURxYhVCFJuAD0hKbYutmMGQY2x/h37TFjEeFbQGemRmchelm0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REPVQ9vI0sS/+qMZ4glxJmzR6YVKe+pGOIewWyc4Uns=;
 b=avQLrjj3E+nGf5uw4INdGF5YYarwn+t2DpWXt741VDfDiqh8Z2jjXPT000CDBrbEr0WRhxeLLk+1tWbCxuO9Ii7tmIRsrfMAcOE2SFYMIw18ZZZD2ZFcUiRuvP5SgJP2kYcHWFZG50gX78qxeEQzcFPY1ku2BixNLqDboqM9dR0zOFTGX/89AaTkKB9oSbRyIUiu9c2YCcKwlviqeI40+RLPTgFPoJHPUmr67+wk5vocnGeBSGLo/A7azcLGCMYlvhPdO/mE6dth1qS+c9+KqDzaQzCQYTdb9iSqFhHnxr700rd+rd+IAhGOhsr0NSLf2zxEEtFgQPbaZxFUgwY+8A==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS5PR07MB10131.eurprd07.prod.outlook.com (2603:10a6:20b:680::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Fri, 11 Apr
 2025 06:44:59 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 06:44:57 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
CC: Jiaxun Yang <jiaxun.yang@flygoat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 02/16] hw/intc/loongarch_pch: Modify register name
 PCH_PIC_xxx_OFFSET with PCH_PIC_xxx
Thread-Topic: [PATCH v3 02/16] hw/intc/loongarch_pch: Modify register name
 PCH_PIC_xxx_OFFSET with PCH_PIC_xxx
Thread-Index: AQHbqPiMEk+gEGqGrk+L6yISLW9qQbOeCISA
Date: Fri, 11 Apr 2025 06:44:57 +0000
Message-ID: <ccaaf5ff-9502-400c-aa32-562777d62af4@eviden.com>
References: <20250409023711.2960618-1-maobibo@loongson.cn>
 <20250409023711.2960618-3-maobibo@loongson.cn>
In-Reply-To: <20250409023711.2960618-3-maobibo@loongson.cn>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS5PR07MB10131:EE_
x-ms-office365-filtering-correlation-id: 85850c6a-4725-4dd2-9b37-08dd78c45fed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bElKbDUrblRmUEJnTHVCaG9OdjVPa29FQmphUTR0UVJOMlJNR3JMeEptWXJ5?=
 =?utf-8?B?ZEZTVXFrWk1KdUJ1ZFhrc3l4TXljVURIeDM0dG9CbEpRa1UzMjZNdGZaZWh2?=
 =?utf-8?B?aVNCTy9IMXpmMWM2dVk0ZEQ1a2pYRU5kblpPUzRwd1l4YWZSbHdEWTJkV2NX?=
 =?utf-8?B?MUxyY05zT3RhYVpDNi9GTTVUVGFOMWxGUS9OVkpyZnYwOG90R01uV3lFUFkw?=
 =?utf-8?B?UXRlQXJxU2dnUHZTVGxRbVhOcmp4SGdWTUVjcE0wRWxUKytodmx0SGk2NCs5?=
 =?utf-8?B?ZDhyM1RJaUlmUlBnMzlRVk9udFdHeUVNUVB3S3RXZVJubXFDeG1pdlhiM0hl?=
 =?utf-8?B?RmFTcXpmc09sd1I1Y0lHTzFaU3NGdTR3MWVtd2ExTmFGbHIzWEh0SUlhZXl2?=
 =?utf-8?B?T3pBM0tKejZtQk9POE9WTEFvV2k2SldVdlNNeDlGTlpBaWlMaW8xVUNvK2lR?=
 =?utf-8?B?S3h5WUZCOHNPdDhaMW4wME5yM2lONTVnV1VuaXFjOFNBNnhJRTl0R001cjg3?=
 =?utf-8?B?Y1dqWEZWMlVBUGZjdmhlNnYzL25MUGVzdXk3OVpDTGw1bktHM3pLeWxSVEtv?=
 =?utf-8?B?cWJ0dWhEREZ6SHJmZHg2U3kwWTNzUWVnbWd2VlByQ3JpWTZNNGo2Z0N3U2NT?=
 =?utf-8?B?bUxWdlBNWWo2UlVQdGFOSGVLdjhnaEhMck5XUVJaK1FTMlhDM0NrYWFwVTlz?=
 =?utf-8?B?VG90dTlSYVNQakU3RWUyV2VPSHdxQnB1aCtjQjVpQ0gvLzdRQ3lGYWQ5M3N4?=
 =?utf-8?B?bThCcStUTWJDSGRuNkZ5UUtXV3ZCWGZHb09XSVZrWk9iYjVzTXVrcG5RMi9W?=
 =?utf-8?B?Nmtmek5SeUsrTGFHN2JiVmNBOFk3R2Q0Ky9HZmNsbGtSYWlMQmhud2NzeHZI?=
 =?utf-8?B?NEpmWUdmWXZmUDlxZksyb1pBU1RnWWNrZm5zeEQ2WU5GTkxmdmlOSnRPMjdp?=
 =?utf-8?B?MG5aY1RML2RRbHBMYWxpTWlNVlY2LzhQY201cFNXbDErbEwzUW1YYW1ZRDFY?=
 =?utf-8?B?bUZhT2c3K05veEl5MDI0NkdPbEIxcWRSZjNhSkM1Sk80eEdHaDVRSUZkaTBz?=
 =?utf-8?B?SWNJMzByN2VUYkJOOERJN1Nla0pQdUd2bC9sSXd5UnRXYk94NHZKMFZSbG1Y?=
 =?utf-8?B?SVE3bThtc3RpY283d0V4cjhlQWVzaW1TZElWZm5haUx6K29WV0c4QlJXallG?=
 =?utf-8?B?eWdxd2NEckNZOWthTk15UFduUFdYYks2cndQdlFtVEVJSWdGU1Jac0NLVmRB?=
 =?utf-8?B?dEt2cDJveEsxZWVnZ3JYall0ZnpuN3pOWTJQclRtaFRTSUMwaHNZNG9Canlm?=
 =?utf-8?B?THJPOXZxVytJVDdhQnFCQU5kdnVtVGhxeHdwNDMxcUhmamdiM3FCY1FNdmhp?=
 =?utf-8?B?V2ZFQi9sZE4vRnhCRm1FS2VvamZZck9DWDVQUE1ydUpqREhTTUZxdXZQNHRQ?=
 =?utf-8?B?Y1ArU0hVVGhrSmNGd2dVejZ5ak92V3luSW9EMDN2NUlrWnFEK2w5aS9SNXdR?=
 =?utf-8?B?L29XS2ltR0ZLay9HajhMb2srRFJ1Y1l2T2dCb1NhbDBpS21RUWd1VDVhbVFX?=
 =?utf-8?B?WFZ3ZEdMbENlZVFodXlTTkg1WUtuTGZyUDF1NFJ0U1pEdHp3cEdqL1FlNFVW?=
 =?utf-8?B?TVN2SGZYTU5YQTYrOGFEMTNGeEpkbmd0N3o2K0RETmZXQkdtT05Qc0d3d1Nz?=
 =?utf-8?B?a1kxQWVjdTN6NVZGZ3djZ3ZxQXhDK3dLSUtEMUR5dEhnT3UvL1lZSy85OG9a?=
 =?utf-8?B?cWNrZDY0WVVaMHF4YS9jd1FBbmlubTlnUFMvR0hMbEpXNFlwazBMbFNZa3BF?=
 =?utf-8?B?NWFwV21qZUZSejJvemYvUTFjRHptbGFnenhkWExtT1NvOWtmc0lWazJ4YUpB?=
 =?utf-8?B?Y1lZZU5BTHRaaVNkZlBpaFk3dERVY01EWU93ZEJha0xnZTdJV3JLUkZQN1lZ?=
 =?utf-8?B?ZE00bHFGbldFMndXYkNLdFk2aG9meXZWQkNKNWVtTVNDNGJHd2QzbFpOQjhX?=
 =?utf-8?Q?I75PeFbGb4gTZc7jnHCPVRoDl8io4w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFVDMFg3a29SN3Iza0ExNUJSVGpZcEFFWnJtNHFEUE45MlZwYkNTSDEybWJV?=
 =?utf-8?B?S1NBT2QyVXlBTldJelpNYTE2S3VSVms2d2hsL1JUWCtCQWNxNXJXSm5IejN4?=
 =?utf-8?B?RnI1MUFiVGEyaGhiRTZXNVQveERHZEg5RndnYWtNN1lqbzAzdzViZTFONW5O?=
 =?utf-8?B?ZmFlMkRUc3psM1BDY2pBekFxNlZLSlBGS0VuY2xtV3FzOC9DRVZjV2x4ODk0?=
 =?utf-8?B?ay9kYW9zWVRGSzg5R2dXOGdxMGdmZElqdTIwMVZxSTNTSDRjZVAzNGJPakwr?=
 =?utf-8?B?a21HM2swUlZsTC9oOUR5TnpFUyt1UlV2WlpkVEhxdUdLVUZHZWsxcjVrcjgr?=
 =?utf-8?B?K2lJWU1xTnVvcEJMajEyV1VYSEs2Ky9HRSt2UW1kS2plbFdOb2VVVWV4SXgw?=
 =?utf-8?B?TjZUaFJnN20wOGxzSzJrSm9rbkY3citpdWhkaW1Ha2JKS284U3pGQXgzOGdM?=
 =?utf-8?B?dmdRWGkwZGQrNE5SOGxycnMzUytCaUR2L0k1QjdsZnJYNDY5Tk5aaXBTeHkr?=
 =?utf-8?B?NzBrVjQ5ajFlWFJUbHNDQWNKUUdNWC80ODkvcit1dGtKVnFQczhTOTBLdG1T?=
 =?utf-8?B?dGRhTE5MYUd1aEtPWGh1TEMzTm9CL2g1ZjRFY1R6cHdUcXQ3UW56RUdpU3Jw?=
 =?utf-8?B?OS94RXFMcmlvWDUrNC9NclZZWklEd2JmMmxHRXZHWTNybTVObS85ckd1TGpS?=
 =?utf-8?B?RHhHdk5YWTlWS1JiczBVTi9Saks1UWsrZXUvS0RkRTF3SUJ4SWphWUFNakdj?=
 =?utf-8?B?VEVZaENQRmVSOVk4N09pcnlidXRhR2VSKzE2MjMvbFBkOWJsOVBGVGRGM095?=
 =?utf-8?B?NUoxNWtNcnRlZTgxaVhwTWVPUEZQQUc2MHFGUW1sV2xCKzVtQk52dWs2ajRr?=
 =?utf-8?B?am5HaDlQTWwySThhdkxOV1VlWVA0YTdmK0t2OFA3em5PbHhFRStRNng2cE0v?=
 =?utf-8?B?NStpdVNLK0MvQ2FpR0dGdzdPVXJNeU9aNGVldjhNdzRyWk1Dd09IQTlOVjcr?=
 =?utf-8?B?NEYzUGZVaW9YbWhITTkwcjU2T1p5eHBkWXZUZnMvS1FBZ2M3MC9BbHc1Q0Jt?=
 =?utf-8?B?Q2dUWE15RDNQaFdYbzhXOWh3ZlVPMTFYUlczcS9KODVrRFRzKy9rNE9FMytC?=
 =?utf-8?B?TC9jR3dMcHBLTmJWWWtrSGVtSFNRcFZlM0c1RjQ5Q0UwSC9RVm9iNFZrbk5S?=
 =?utf-8?B?enNoUlp6TTdkQU5hTm5lR2tFWXhUdWNnMFI0MlE3QktjSmVOYW5DdytnOFNM?=
 =?utf-8?B?VUxFcDQ3Yk1tOU5KNGhHMzZqeVFDWTRBR3k2ZlR4QmFvdXAxRlFnUldoSHpi?=
 =?utf-8?B?TlNuU3VpQlBucldKS2dPNXI3RllHMEhqT2hHOFIzWWw5dlJxejFYYlBJMlJu?=
 =?utf-8?B?ejJ1Z3Y4NUdWUTBrd3g2ckZLellzVzV5d05PamhMRHJnZXBxNUp3OG8wNUVv?=
 =?utf-8?B?cXllRVBjSVl2bmh5aVQ2YldvOS93SDFUajkvWlUrTE00bWNBdTQ3TjFuNmZV?=
 =?utf-8?B?bk1xS3NWNVZsbW9yZVQ4dFJtSHZ0eVV5ZEJiZWVwRmVrZzhZelkzMm9scjFK?=
 =?utf-8?B?Y1ZycHBsWW9yalBhL3hPSnFzeUxnZEdmSzNhSWl4eGVlQnhiV29TeGF4NUZW?=
 =?utf-8?B?MnJZQU9QSkFiMitpUWZhNjNQZTliL2RBekJtWUo2d1N6Nk5NQWFkamZ2MXI5?=
 =?utf-8?B?cXB1SW02ajllKzUzYVhIQmVETG9peHZWeFpIWkRaeithYzJsTUNIMlcyS2JE?=
 =?utf-8?B?cUtaMDJ0WGFYM1ZIVURUNHlyWUltbzdWVmdscnpmZHpzNjllUEJtZ0NoME0r?=
 =?utf-8?B?OFl6TEhkb2JzOFhuTm52Y0lPT2Y5SjlwQTR4eWkxSHVWS0dCb0NCQlBxSk1t?=
 =?utf-8?B?M1RuakRHYVUwSGNtbVBwNnIxYnl6V1E2WmNBeFhDNnNKM3NNSXNFSVVxUXZC?=
 =?utf-8?B?cnJuVlRFUm1IUmUxOHd1a2QzRjBEN1l1YkFBQzZqeHVkdmZoTTRtQXJidFlk?=
 =?utf-8?B?ZFR1TWtSNGU3aHl1NlVWeEtqNVJsRWRwU1FuL1czN3lLcmZMWms4czc4M0J1?=
 =?utf-8?B?NjBwZkZHbUdncURPczRoYnNZOXBkVGRBTC9ER0pnT2tXMUZaOGZoQ0ZRTG4z?=
 =?utf-8?B?Tnk5Ky9VWEFBVUpZVHM3VnA3UkN5b0xYQ0FYYkdRT3F0MFZaSENkanJ3N1ZR?=
 =?utf-8?Q?g9J5W/nvEEAggPwloePofmY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DF2752BA046EB4AB98390D0098BB290@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85850c6a-4725-4dd2-9b37-08dd78c45fed
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 06:44:57.4661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNyFzAFXO11VCfGgnbcopntBNvbNAlkb7cylL6uxZkMZfq5JALmuv20zbta88FS86riGsqGhia65PIz8fe9UebbFo4249eB5Ib5v/EagULtNs1ifyg76+KqDG96LKoKS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10131
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

UmV2aWV3ZWQtYnk6IENsZW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQoNCk9uIDA5LzA0LzIwMjUgNDozNiBhbSwgQmlibyBNYW8gd3JvdGU6DQo+
IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGlj
ayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiBNYWNybyBQQ0hfUElDX0hU
TVNJX1ZFQ19PRkZTRVQgYW5kIFBDSF9QSUNfUk9VVEVfRU5UUllfT0ZGU0VUIGlzIHJlbmFtZWQN
Cj4gYXMgUENIX1BJQ19IVE1TSV9WRUMgYW5kIFBDSF9QSUNfUk9VVEVfRU5UUlkgc2VwYXJhdGVs
eSwgaXQgaXMgZWFzaWVyIHRvDQo+IHVuZGVyc3RhbmQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBC
aWJvIE1hbyA8bWFvYmlib0Bsb29uZ3Nvbi5jbj4NCj4gLS0tDQo+ICAgaHcvaW50Yy9sb29uZ2Fy
Y2hfcGNoX3BpYy5jICAgICAgICAgICAgfCAyMCArKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgIGh3
L2xvb25nYXJjaC92aXJ0LmMgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICBpbmNsdWRl
L2h3L2ludGMvbG9vbmdhcmNoX3BpY19jb21tb24uaCB8ICA0ICsrLS0NCj4gICAzIGZpbGVzIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2h3L2ludGMvbG9vbmdhcmNoX3BjaF9waWMuYyBiL2h3L2ludGMvbG9vbmdhcmNoX3BjaF9w
aWMuYw0KPiBpbmRleCAyYjkwY2NkMWZmLi40Yzg0NWJhNWU5IDEwMDY0NA0KPiAtLS0gYS9ody9p
bnRjL2xvb25nYXJjaF9wY2hfcGljLmMNCj4gKysrIGIvaHcvaW50Yy9sb29uZ2FyY2hfcGNoX3Bp
Yy5jDQo+IEBAIC0yNjMsMTggKzI2MywxOCBAQCBzdGF0aWMgdWludDY0X3QgbG9vbmdhcmNoX3Bj
aF9waWNfcmVhZGIodm9pZCAqb3BhcXVlLCBod2FkZHIgYWRkciwNCj4gICB7DQo+ICAgICAgIExv
b25nQXJjaFBJQ0NvbW1vblN0YXRlICpzID0gTE9PTkdBUkNIX1BJQ19DT01NT04ob3BhcXVlKTsN
Cj4gICAgICAgdWludDY0X3QgdmFsID0gMDsNCj4gLSAgICB1aW50MzJfdCBvZmZzZXQgPSAoYWRk
ciAmIDB4ZmZmKSArIFBDSF9QSUNfUk9VVEVfRU5UUllfT0ZGU0VUOw0KPiArICAgIHVpbnQzMl90
IG9mZnNldCA9IChhZGRyICYgMHhmZmYpICsgUENIX1BJQ19ST1VURV9FTlRSWTsNCj4gICAgICAg
aW50NjRfdCBvZmZzZXRfdG1wOw0KPiANCj4gICAgICAgc3dpdGNoIChvZmZzZXQpIHsNCj4gLSAg
ICBjYXNlIFBDSF9QSUNfSFRNU0lfVkVDX09GRlNFVCAuLi4gUENIX1BJQ19IVE1TSV9WRUNfRU5E
Og0KPiAtICAgICAgICBvZmZzZXRfdG1wID0gb2Zmc2V0IC0gUENIX1BJQ19IVE1TSV9WRUNfT0ZG
U0VUOw0KPiArICAgIGNhc2UgUENIX1BJQ19IVE1TSV9WRUMgLi4uIFBDSF9QSUNfSFRNU0lfVkVD
X0VORDoNCj4gKyAgICAgICAgb2Zmc2V0X3RtcCA9IG9mZnNldCAtIFBDSF9QSUNfSFRNU0lfVkVD
Ow0KPiAgICAgICAgICAgaWYgKG9mZnNldF90bXAgPj0gMCAmJiBvZmZzZXRfdG1wIDwgNjQpIHsN
Cj4gICAgICAgICAgICAgICB2YWwgPSBzLT5odG1zaV92ZWN0b3Jbb2Zmc2V0X3RtcF07DQo+ICAg
ICAgICAgICB9DQo+ICAgICAgICAgICBicmVhazsNCj4gLSAgICBjYXNlIFBDSF9QSUNfUk9VVEVf
RU5UUllfT0ZGU0VUIC4uLiBQQ0hfUElDX1JPVVRFX0VOVFJZX0VORDoNCj4gLSAgICAgICAgb2Zm
c2V0X3RtcCA9IG9mZnNldCAtIFBDSF9QSUNfUk9VVEVfRU5UUllfT0ZGU0VUOw0KPiArICAgIGNh
c2UgUENIX1BJQ19ST1VURV9FTlRSWSAuLi4gUENIX1BJQ19ST1VURV9FTlRSWV9FTkQ6DQo+ICsg
ICAgICAgIG9mZnNldF90bXAgPSBvZmZzZXQgLSBQQ0hfUElDX1JPVVRFX0VOVFJZOw0KPiAgICAg
ICAgICAgaWYgKG9mZnNldF90bXAgPj0gMCAmJiBvZmZzZXRfdG1wIDwgNjQpIHsNCj4gICAgICAg
ICAgICAgICB2YWwgPSBzLT5yb3V0ZV9lbnRyeVtvZmZzZXRfdG1wXTsNCj4gICAgICAgICAgIH0N
Cj4gQEAgLTI5MiwxOSArMjkyLDE5IEBAIHN0YXRpYyB2b2lkIGxvb25nYXJjaF9wY2hfcGljX3dy
aXRlYih2b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLA0KPiAgIHsNCj4gICAgICAgTG9vbmdBcmNo
UElDQ29tbW9uU3RhdGUgKnMgPSBMT09OR0FSQ0hfUElDX0NPTU1PTihvcGFxdWUpOw0KPiAgICAg
ICBpbnQzMl90IG9mZnNldF90bXA7DQo+IC0gICAgdWludDMyX3Qgb2Zmc2V0ID0gKGFkZHIgJiAw
eGZmZikgKyBQQ0hfUElDX1JPVVRFX0VOVFJZX09GRlNFVDsNCj4gKyAgICB1aW50MzJfdCBvZmZz
ZXQgPSAoYWRkciAmIDB4ZmZmKSArIFBDSF9QSUNfUk9VVEVfRU5UUlk7DQo+IA0KPiAgICAgICB0
cmFjZV9sb29uZ2FyY2hfcGNoX3BpY193cml0ZWIoc2l6ZSwgYWRkciwgZGF0YSk7DQo+IA0KPiAg
ICAgICBzd2l0Y2ggKG9mZnNldCkgew0KPiAtICAgIGNhc2UgUENIX1BJQ19IVE1TSV9WRUNfT0ZG
U0VUIC4uLiBQQ0hfUElDX0hUTVNJX1ZFQ19FTkQ6DQo+IC0gICAgICAgIG9mZnNldF90bXAgPSBv
ZmZzZXQgLSBQQ0hfUElDX0hUTVNJX1ZFQ19PRkZTRVQ7DQo+ICsgICAgY2FzZSBQQ0hfUElDX0hU
TVNJX1ZFQyAuLi4gUENIX1BJQ19IVE1TSV9WRUNfRU5EOg0KPiArICAgICAgICBvZmZzZXRfdG1w
ID0gb2Zmc2V0IC0gUENIX1BJQ19IVE1TSV9WRUM7DQo+ICAgICAgICAgICBpZiAob2Zmc2V0X3Rt
cCA+PSAwICYmIG9mZnNldF90bXAgPCA2NCkgew0KPiAgICAgICAgICAgICAgIHMtPmh0bXNpX3Zl
Y3RvcltvZmZzZXRfdG1wXSA9ICh1aW50OF90KShkYXRhICYgMHhmZik7DQo+ICAgICAgICAgICB9
DQo+ICAgICAgICAgICBicmVhazsNCj4gLSAgICBjYXNlIFBDSF9QSUNfUk9VVEVfRU5UUllfT0ZG
U0VUIC4uLiBQQ0hfUElDX1JPVVRFX0VOVFJZX0VORDoNCj4gLSAgICAgICAgb2Zmc2V0X3RtcCA9
IG9mZnNldCAtIFBDSF9QSUNfUk9VVEVfRU5UUllfT0ZGU0VUOw0KPiArICAgIGNhc2UgUENIX1BJ
Q19ST1VURV9FTlRSWSAuLi4gUENIX1BJQ19ST1VURV9FTlRSWV9FTkQ6DQo+ICsgICAgICAgIG9m
ZnNldF90bXAgPSBvZmZzZXQgLSBQQ0hfUElDX1JPVVRFX0VOVFJZOw0KPiAgICAgICAgICAgaWYg
KG9mZnNldF90bXAgPj0gMCAmJiBvZmZzZXRfdG1wIDwgNjQpIHsNCj4gICAgICAgICAgICAgICBz
LT5yb3V0ZV9lbnRyeVtvZmZzZXRfdG1wXSA9ICh1aW50OF90KShkYXRhICYgMHhmZik7DQo+ICAg
ICAgICAgICB9DQo+IGRpZmYgLS1naXQgYS9ody9sb29uZ2FyY2gvdmlydC5jIGIvaHcvbG9vbmdh
cmNoL3ZpcnQuYw0KPiBpbmRleCA4YzBjYzk4YzcyLi4xZjFjY2E2NjdlIDEwMDY0NA0KPiAtLS0g
YS9ody9sb29uZ2FyY2gvdmlydC5jDQo+ICsrKyBiL2h3L2xvb25nYXJjaC92aXJ0LmMNCj4gQEAg
LTQyOSw3ICs0MjksNyBAQCBzdGF0aWMgdm9pZCB2aXJ0X2lycV9pbml0KExvb25nQXJjaFZpcnRN
YWNoaW5lU3RhdGUgKmx2bXMpDQo+ICAgICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihn
ZXRfc3lzdGVtX21lbW9yeSgpLCBWSVJUX0lPQVBJQ19SRUdfQkFTRSwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3lzYnVzX21taW9fZ2V0X3JlZ2lvbihkLCAwKSk7DQo+ICAgICAg
IG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lvbihnZXRfc3lzdGVtX21lbW9yeSgpLA0KPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFZJUlRfSU9BUElDX1JFR19CQVNFICsgUENIX1BJQ19S
T1VURV9FTlRSWV9PRkZTRVQsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgVklSVF9J
T0FQSUNfUkVHX0JBU0UgKyBQQ0hfUElDX1JPVVRFX0VOVFJZLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzeXNidXNfbW1pb19nZXRfcmVnaW9uKGQsIDEpKTsNCj4gICAgICAgbWVt
b3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKGdldF9zeXN0ZW1fbWVtb3J5KCksDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFZJUlRfSU9BUElDX1JFR19CQVNFICsgUENIX1BJQ19JTlRf
U1RBVFVTLA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pbnRjL2xvb25nYXJjaF9waWNfY29t
bW9uLmggYi9pbmNsdWRlL2h3L2ludGMvbG9vbmdhcmNoX3BpY19jb21tb24uaA0KPiBpbmRleCBj
MDQ0NzFiMDhkLi5iMzNiZWJiMTI5IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L2ludGMvbG9v
bmdhcmNoX3BpY19jb21tb24uaA0KPiArKysgYi9pbmNsdWRlL2h3L2ludGMvbG9vbmdhcmNoX3Bp
Y19jb21tb24uaA0KPiBAQCAtMTksOSArMTksOSBAQA0KPiAgICNkZWZpbmUgUENIX1BJQ19JTlRf
Q0xFQVIgICAgICAgICAgICAgICAweDgwDQo+ICAgI2RlZmluZSBQQ0hfUElDX0FVVE9fQ1RSTDAg
ICAgICAgICAgICAgIDB4YzANCj4gICAjZGVmaW5lIFBDSF9QSUNfQVVUT19DVFJMMSAgICAgICAg
ICAgICAgMHhlMA0KPiAtI2RlZmluZSBQQ0hfUElDX1JPVVRFX0VOVFJZX09GRlNFVCAgICAgIDB4
MTAwDQo+ICsjZGVmaW5lIFBDSF9QSUNfUk9VVEVfRU5UUlkgICAgICAgICAgICAgMHgxMDANCj4g
ICAjZGVmaW5lIFBDSF9QSUNfUk9VVEVfRU5UUllfRU5EICAgICAgICAgMHgxM2YNCj4gLSNkZWZp
bmUgUENIX1BJQ19IVE1TSV9WRUNfT0ZGU0VUICAgICAgICAweDIwMA0KPiArI2RlZmluZSBQQ0hf
UElDX0hUTVNJX1ZFQyAgICAgICAgICAgICAgIDB4MjAwDQo+ICAgI2RlZmluZSBQQ0hfUElDX0hU
TVNJX1ZFQ19FTkQgICAgICAgICAgIDB4MjNmDQo+ICAgI2RlZmluZSBQQ0hfUElDX0lOVF9TVEFU
VVMgICAgICAgICAgICAgIDB4M2EwDQo+ICAgI2RlZmluZSBQQ0hfUElDX0lOVF9QT0wgICAgICAg
ICAgICAgICAgIDB4M2UwDQo+IC0tDQo+IDIuMzkuMw0KPiANCj4gDQo=

