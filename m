Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3354FCCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 12:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6pTl-0001NZ-EI; Thu, 09 Oct 2025 08:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1v6pTg-0001ND-1b
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 08:10:37 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1v6pTO-0000K2-P4
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 08:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1760011819; x=1791547819;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+TblyALE8m+VoqZBn1L/4PCW7cyGAUd8KvJ7wJZZVqE=;
 b=leyme2iKutrEuX26ALys24XJ3KWGZSViASmlrcG2WLjxiKTEQoWPh9TD
 vvfAKJXOHqc6sHzAdb/KAp+0Utexw/wI75x+GLzPdnAZr/6SCqVEmSY+U
 DMzmRigibRUkTpA0CnlnlsALCPhPwE3kLzVj40pBP9fvKgirfGZtFla8D
 M18QQmKA6NMVfO1AYq6iHfF4ocuNEOL5phmWTO585X1BovthY7SdEo/4T
 Dlnsm/FMIKs7XitwqIj/Lb3wD2JV8lqxNDJFhCYJBOdRXfYIkm8aXTeON
 QsHlHc7WPLebGG4C9/El441edG54+nyaTGUC0amiZKdzt9HnbKfF5MBif A==;
X-CSE-ConnectionGUID: 2qDwNxLRSEusk2aVlTK13w==
X-CSE-MsgGUID: /lEULGA4RiO6dtD+EOInPg==
X-IronPort-AV: E=Sophos;i="6.19,216,1754949600"; d="scan'208";a="43692293"
X-MGA-submission: =?us-ascii?q?MDF0yQh4HkkTTASRRAg3CnfZGjG7YUKbN9nah4?=
 =?us-ascii?q?A4Z/DXkI+lorgXKwTCWjpls51/rzHAFMEbVmpPL/w+0Rspau0rl69Ghr?=
 =?us-ascii?q?enm/mxlCi9qqSnRHVSUNDjB59rJVQ0tvltFJK1rhy84FZ3XW51/puQvz?=
 =?us-ascii?q?5D+SNz3KEWaqIX0EhCIjY06A=3D=3D?=
Received: from mail-westeuropeazon11010068.outbound.protection.outlook.com
 (HELO AM0PR83CU005.outbound.protection.outlook.com) ([52.101.69.68])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 09 Oct 2025 14:10:05 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbbYTQ5w2tJR1ftfn6VHbxm+QvTPDehBU0vNQcHOWhOl/EKJkJSur94NMaZel6Ektju/Nvtchsm+zhYvAVuM6irQFxNYMSpYuSVdL/1roqPRN0UvvVdEZzlkvSoP7HsRbAcvw4op++XBTgEt4oeLy9N+03dSlTXT0JlVEQ69yp104kpCDHo6TL8xF9szw9eyKtt1JbHxmQZ5RgGB18dpRuFjZWu6YsiGdrjuB++1U+/f4BP9BdECxzscgfukuBIrm3Sm8DkituIrDZiDBOsyp1juX/RoQLHa6nExKyei7G6rhh7XJ854XcMecYXR+OdKV+k97H+x2b35gLIKbOcw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TblyALE8m+VoqZBn1L/4PCW7cyGAUd8KvJ7wJZZVqE=;
 b=zFjIM/y5XYdrJG2Sgnw9M+Q2ONAh+4yK+aKl66XGb9Ix8IDDpqd3tJ02OLn5+9Sgc7j+RVYgXRdbmSGNco7TsBURLGhfWR2ZTsGRh+nA/vLXbVBoynRJr2JSVpMn3YWnCOmUT3VxR1hF3TkXDhBzD+V9aPWR/+xECJvKRfI+31GOlXIMKWfZwz+cjAhb5sIhvd7esluWKjtGL69I5Eyqx3awSFE9NOQ87EQDAjpEOqQkplqJvMSeR+/3Q8gEB5+V6eI3gWxVEeiFdkjz2Yzk2DPAccKe+I1GS3YBNnDFT2e1jo7gP5ZdX9Z6eb1ug4lwuz9MAnKXBShRDXI2vkhnyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TblyALE8m+VoqZBn1L/4PCW7cyGAUd8KvJ7wJZZVqE=;
 b=aE6sFmrIAjmqN7cjHAfoZJmJ60viyzHxn7sUido60VCyGsZFPeWWohFFtnBrsOOy2EKcL96zAW4URoofUWnXv3HJ3PsJe3VsGTSGc96PaoGASGbenN15/sTaUhBWwn1dM1UuFdVxponDg++t4Mov5UC39piuR4q+0/YZCx77LV8cWnoSjXOHWlwwE1t+yD3E8wAKk7B++SKf9Ds9I3IXqF+ToawAqpBeDrgdNIUVb4yp+zZh25Xiub1j+Uv1Q43vlkCLqGJDnt0tFT5epboiB0b8lrSAUOcxDlufhwFkxPJVaSI9b5cs6RfDOXuXNpSF6s8m8Xk4pIK84NheQvmOrA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAXPR07MB8338.eurprd07.prod.outlook.com (2603:10a6:102:231::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 12:10:03 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%5]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 12:10:03 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Markus Armbruster <armbru@redhat.com>
Subject: =?utf-8?B?UmU6IFtQQVRDSCAyLzNdIG1haWxtYXA6IFVuaWZ5IENsw6ltZW50IE1hdGhp?=
 =?utf-8?Q?eu--Drif_emails?=
Thread-Topic: =?utf-8?B?W1BBVENIIDIvM10gbWFpbG1hcDogVW5pZnkgQ2zDqW1lbnQgTWF0aGlldS0t?=
 =?utf-8?Q?Drif_emails?=
Thread-Index: AQHcOOsXjLE7dAO95kChCZs00r4Jg7S5uT8A
Date: Thu, 9 Oct 2025 12:10:03 +0000
Message-ID: <46477b945bee1b9aeb9b952c5722daee5f88414d.camel@eviden.com>
References: <20251009070512.8736-1-philmd@linaro.org>
 <20251009070512.8736-3-philmd@linaro.org>
In-Reply-To: <20251009070512.8736-3-philmd@linaro.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAXPR07MB8338:EE_
x-ms-office365-filtering-correlation-id: 5f34dee4-1824-474a-a010-08de072cc71f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?RmEwbHpHTGdlR2FTMThBOTdwRk5wNXJQQXpUbC81bFdlaUFjNDM2eHhuR0F0?=
 =?utf-8?B?RTFjMzRtYWFaQ3JGbkIvV0FDQlZCalNlLzBTNm5uempyUmRmTEw3dytHalVD?=
 =?utf-8?B?N0JlTkFyeVhVL0FSdm9KZ3BWN3RhblRYSVVsUnJJOW5MS1ZaYlQxYVByMkl3?=
 =?utf-8?B?Q0t5SlF4b2dqVUY4eGJrZzh0K2Q4Q0RzUDZEK2ZYaFNxeFRrdGNyVVI0U0xa?=
 =?utf-8?B?YzZXV1JMaEJJT2RwS2pIS0Fub0U1WFloVStQY2tGa3p4Z0VWVkxjdHdTUXdq?=
 =?utf-8?B?M0UxdXpSclBCeDJQVHF6RGlGZFNnc0ZSZExkR1d5dE81Kzdid1hJVmpoZ2Jw?=
 =?utf-8?B?NGNlMkRKZkt5SFovdERHK042dVdmYXpOd2drR2NSUnQ5b3RmS3REZmhTN1hN?=
 =?utf-8?B?Q3VUNk5vbTNrcTZBaTBKWTJNeUJETU15dzJzT1JPV0s5WmFtU0JrZ1htcFBN?=
 =?utf-8?B?dG9mMjBMU1Z6NjRVVlpFMExxMzc1Q3BJeTRGRGI3Tng4M3NNeHRvRm5GeHZp?=
 =?utf-8?B?aHhlWDV2THBZNVF2NVMzSlZqcDNVUnBWVjR0Y3lKMzVINjJqNXJNMG9pYzFX?=
 =?utf-8?B?YWtocUJkQi9yeDFNbEZZZUxlcmNmamRBci90SXQvSWEveFRQS3J2Vkp6MVRl?=
 =?utf-8?B?QWJQNmh6VWc2MmJxRHV4RFc1c1pkZXZDMFd3bWtNeTcySVlHdU45b1o0Vllz?=
 =?utf-8?B?YlpGdTBEL0RVRm9GempvWmtielo3Z0hPNTcyNE4rVWozNFlDc2J1eEVGSjE4?=
 =?utf-8?B?cHM0WWJTbXNLUEVBdlJjU3dkODQzeEZBMFI5aFFYZmp1R2xmTUxlMlFJbVFi?=
 =?utf-8?B?R25odWJlbUpiQy9TM2NzdFBQbG8wZTgrcGhFclN1Qk84clQxTDcyWWRSVFNX?=
 =?utf-8?B?ZWlacmM0ejVaM1p0TW9qL2hGZ01Xb1V3T1NzdjcvQk14MElHRWx4Uk5oMlNt?=
 =?utf-8?B?Q3psZ3huNHlZcTBMOS9PT1NzQWc2MlR1SGxwZWxEZUszdldjWlhNVEdKUFRN?=
 =?utf-8?B?V1hCMHMvYllpWkd2QXE0ZmhSc3IybXFRYThlbnIrMFp1SnYvOGJGTE0zSDBa?=
 =?utf-8?B?Q09veVdsQ1haZkp4aE9tNm9iaDczV3N2QUJzSFNmaENocGhXYkpuYUd5SVNF?=
 =?utf-8?B?alltN1J6MElWS0l6RWpFL3dxZElwa214Q1ZSTkVHRWpEMzhyb0lHbjgvaGcy?=
 =?utf-8?B?bzVnMzNwcDA1dXNBS01PUTNyZzlJVGIxa2hwY2dCaVZ4aGJPNCtldlVzQTZl?=
 =?utf-8?B?cnhSaU0xNVF2STlOVmRCL0Z5TTFYU2lyV3dGUENnbzRiRE1ZWVdtRmNKL3Nk?=
 =?utf-8?B?a0RmUjNmdkxNU3JpdmxySC9EMUduendYZ1BxLzlzNWlaOWtGK0pvY0UydWZl?=
 =?utf-8?B?OHYwbEE1OVFUTk51WUxlNnpLWkpaV0drTDRUcFJ1clowWGk4VkpVb0JkTHR2?=
 =?utf-8?B?M3VtTTVIYTJNcU1wWkpETHlpcVpsV1lPOVB6QXM1RkNaVGJ3NzBhRDIrNHpl?=
 =?utf-8?B?Ujhzd0dvNjdnYTJrVDB4OVo4cW4ySUphMlk5SnJKdnJCUE83TmRyWUo5djVF?=
 =?utf-8?B?eUFvZzg4UHg1aiswY2lvT0FnTTM3NWhkN3dOUUFtNVlWYktOdFMvRWhyVnRS?=
 =?utf-8?B?cFdmUUpXdWExTGZMejN0RnZTdld2ZWE3RXVGM3lvN0ZFZGpYSU1xS3FpeUU4?=
 =?utf-8?B?cDF0MjFrSUIxYWtHeXlYSXFwZXozODh0MGVLb0VGYkJRd1JyaHk1dmxJTWdo?=
 =?utf-8?B?TDd1S2JoYlNJTENLSjY0R2RFMGQvdkhMSnlldW1NT0ZJQm5WK2lURXRpL2l2?=
 =?utf-8?B?Q0krRGV6dHdwNGlya1l0VzhXOWlqN0tmR0w1QXQvWjF1M05tTjJta2xxbGRp?=
 =?utf-8?B?a2h1eHBLcHVHUndFK0UrbUF6NXNjVmUvNGZldkdvOHpadUVTMVNKVzBYZlha?=
 =?utf-8?B?RlU2cit6aVBpTUpwTmpGK2IydEV1dzJyanJaNkNTdWFESnVGVGM3dmY2eWZS?=
 =?utf-8?B?MExUTm9xays1WjBaMzZvdjNEVmtRaGtiQnBvZmtRWERHSHFkN2ZYNkUrWG9U?=
 =?utf-8?Q?gREmbJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qll2Z3FJQ09aUlhZKy94dGt3YXA1Z0dQUHUxRXBzdjhkOGdSWmJBalNUb0N1?=
 =?utf-8?B?TkNoN1NIbkVvSWlSMXJjSmk1bkYwWVdyU1dGQldVVG1icDBkZWt4ZW1ZeHA0?=
 =?utf-8?B?ZEJOY3Y5c1VMU0t1RDBXRmt3OHhVV1A2emh1Ym5vbkNxOFR0WCtkYUhLNVI4?=
 =?utf-8?B?MVJsa05qdWg3eGcwWjlBRWxpK2dwRHR6NGVqc2UyYWh5VlpVc3JvTGdEN2Qy?=
 =?utf-8?B?VXk0R25na2R3a2NXZ1gzMmd2NnNzZ2lJMmVqZ0VjSFpROUo1VkFnZEdoZjhO?=
 =?utf-8?B?d1ZMdmFLZ3lXZXIyNFl3MEhTRlFLV0tqYnBOZm9lZGZjVWRibTQwVFF5dDZX?=
 =?utf-8?B?cXpnL0YwNXcvenl1MzlwbWFwNHdTbXVSWmZoakw0dldsRndlOEFSdEZ6alFi?=
 =?utf-8?B?RFlpNGFSNDAyWUVyMCtvVXpjYjd2MWlscUQycDNJUXd5RWZqb1UvajduWHZP?=
 =?utf-8?B?emphQmR2NUJNMmsrTlZEcDFnaTdqT3Y2bzBjUTJtR0c2ay9nREU0clRlRGw3?=
 =?utf-8?B?eEpuQ01xL2ZCTGVXclJCVXJKbThWdmR5QXN1VG9lQkJXWVRKWXI0V0p3TE0x?=
 =?utf-8?B?TkZBS3NXVHc1SE9DblFnemJqWDhPK2psVHh0ajJyTGZtSDRGMnFraHNCRVRI?=
 =?utf-8?B?SlRzMWN0OWY5SzgwQVdFbitiSWJCVUU2WXFYZk1GR09lSG5kL1gzdlk3VUpX?=
 =?utf-8?B?aW8vRVBlZGwxbVRUVnVhZHp3dWJ5SWpvOW5xb1pyNVlKUWpYNEtvSXNxbnVn?=
 =?utf-8?B?aExtRWFlaWhrWExYZm5ZRERpenlaL3J0R2NPS1l2UTVNdjFuOEYxaGl0dGJQ?=
 =?utf-8?B?b01KUXpRblNuakFUZHhlaFgrUGNkM0NFN1lFRTR4T3FrYXBWNUVGL3ZLSFJ0?=
 =?utf-8?B?K1IrYlptd0R5RkNhVFpYOGlnQXQvUjZDQnRScmJzY2VZOTVQVWN1V3YwMFlC?=
 =?utf-8?B?c3V1ZGs4ODN1L2svUkJuSVpZTVl1ZGI4TDQrQnlpZy9JcGkxRFg0VnJiQ01D?=
 =?utf-8?B?bmZQcmJDTWMwQkpUVXEyN3dtTnY4ajNIZnl4V29tZmRUbzRwOS9ZMGs5RHFi?=
 =?utf-8?B?a1BJNmhzcnNnenhNOGVpY1B2U2ZjSWxVcVNINmNUaVl5aEQyNFdxNXpkS0Ur?=
 =?utf-8?B?TjVlL0dmM1MwNDBZTnp0dWIvMGtHR2hjKzNlWDg3UllJL0Y2TlVCV0VxQ1Rs?=
 =?utf-8?B?NkZMUlFOWE8yMldFNEtKMzdhSVhybjZyMnVtZTF6dDR4UFU3UVhGajcvY3Qx?=
 =?utf-8?B?UXBUei9FTy9CbzVPMG94NitueDRQQVZYSEx5SjU2ZVFxaGRkUFdQZDdCNS9h?=
 =?utf-8?B?YzNJQVAwcDRyWTNXY2k3b0NzOUtOQUQzM2hNblhlL3hIOUpYK1h3NmVhT2xs?=
 =?utf-8?B?OHZHKzQ5M3I0aVFXTnEyNXV1T3Y3ZE5zMlhDMlRSUk9QNkNCdXJYVlc2d0Y4?=
 =?utf-8?B?UUgrUEwrQ1ZSMWFzU1RTUWh3U0lXQXVVRUZLckgrbEZGYVM2Ky9nMEtKRUVD?=
 =?utf-8?B?cHhGVUdacjRMdUFsMktLSng0QitwQWF1L0NvaU92eDJsZ3I0dHIrWnpaeUFs?=
 =?utf-8?B?YUlscjNkNWlRN0loZnJ6UENjZi9FTEVmTktNNXNxSE5NRHRoeEtPYnFnemNZ?=
 =?utf-8?B?QlI0bkRwM0dpQWpnMTVwaG45NkxDLzA4V2gxL1UrRWM2c1plSzYxSXRXc2ll?=
 =?utf-8?B?Y3ZJZWdMZGVtbmxwdmJPSnllMlR5bjdlZnV4K0lVc291TnhiOGlLNGR3TWpu?=
 =?utf-8?B?VytwbEpUcjlreU9WVUJDMUw2UDl4TlBwOXkwWThFK2ZxNGdsalBtQjBpSWQv?=
 =?utf-8?B?ZUxuZHR5NGlzc1NxY3VjOSsrMzc3WGUrL0p2YmxVOERjMU1DcU9UczBPc1I5?=
 =?utf-8?B?UnoyNDFvbDdEL3JNSlJRMHJ6YlBBNFpRODdya0JRY01BSFJ5SEVwRitENnNV?=
 =?utf-8?B?ajZlR1JTWTArTUpsd2djWFd2SUhlYUMvWlA4c1hOQzdFU2gxTnRqVnE4TlZs?=
 =?utf-8?B?Vnc5ck1PWG1hdGUzYnYweVBsRDJHcnA2TGt2V0NoTW9NYkg4UjhOSWlhc0sv?=
 =?utf-8?B?MXdTeFFFOFF1aGR0dzFzV2VLVHlreTNYY3RYRS9Wbzl5bCt2NUs4RzlTaDdL?=
 =?utf-8?B?UGJ2ZnZVYUFZR3l4TW5DeUZKem0ybnVhNm9kVktxVnRtYXYvV20yVmFCUVhT?=
 =?utf-8?Q?xueBhhbgrr2eiI9Sxqbvucw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <337F2A23B40D8B468B2577D1A245505C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f34dee4-1824-474a-a010-08de072cc71f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 12:10:03.3865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: peks8Tqotr6QD5BgXtzwjMRA/QS0L3DIxA5FtH652PdJCy2Ra74uZi2Is/Nqbn8GFuy1KXr78TQw/hYyq+in3y5IWAhNyPd7hlSrLrWtyC2MLBEGvu9qyerdzUq0mzMH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8338
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

VGhhbmtzIFBoaWxpcHBlDQoNClJldmlld2VkLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxj
bGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCg0KT24gVGh1LCAyMDI1LTEwLTA5IGF0
IDA5OjA1ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gQ2F1dGlvbjog
RXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1
bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IERvIG5vdCBsZXQgZ2l0LXNob3J0bG9nIG1h
a2UgZGlzdGluY3Rpb24gYmV0d2VlbjoNCj4gDQo+IMKgLiBDbMOpbWVudCBNYXRoaWV1LS1Ecmlm
ICANCj4gwqAuIENsZW1lbnQgTWF0aGlldS0tRHJpZiAgDQo+IMKgLiBDTEVNRU5UIE1BVEhJRVUt
LURSSUYNCj4gDQo+IGFzIHRoaXMgaXMgdGhlIHNhbWUgcGVyc29uLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPFtwaGlsbWRAbGluYXJvLm9yZ10obWFpbHRv
OnBoaWxtZEBsaW5hcm8ub3JnKT4gIA0KPiAtLS0gIA0KPiBDYzogQ2zDqW1lbnQgTWF0aGlldS0t
RHJpZiA8W2NsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tXShtYWlsdG86Y2xlbWVudC5t
YXRoaWV1LS1kcmlmQGV2aWRlbi5jb20pPiAgDQo+IC0tLSAgDQo+IMKgLm1haWxtYXAgfCAxICsg
IA0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
Ly5tYWlsbWFwIGIvLm1haWxtYXAgIA0KPiBpbmRleCBmMmY4M2U4MDYxZi4uYTUxMGI1ZDY4MWYg
MTAwNjQ0ICANCj4gLS0tIGEvLm1haWxtYXAgIA0KPiArKysgYi8ubWFpbG1hcCAgDQo+IEBAIC0x
MzcsNiArMTM3LDcgQEAgQ2hlbiBHYW5nIDxbZ2FuZy5jaGVuLjVpNWpAZ21haWwuY29tXShtYWls
dG86Z2FuZy5jaGVuLjVpNWpAZ21haWwuY29tKT4gIA0KPiDCoENoZW4gR2FuZyA8W2dhbmcuY2hl
bkBzdW5ydXMuY29tLmNuXShtYWlsdG86Z2FuZy5jaGVuQHN1bnJ1cy5jb20uY24pPiAgDQo+IMKg
Q2hlbiBXZWktUmVuIDxbY2hlbndqQGlpcy5zaW5pY2EuZWR1LnR3XShtYWlsdG86Y2hlbndqQGlp
cy5zaW5pY2EuZWR1LnR3KT4gIA0KPiDCoENocmlzdG9waGUgTHlvbiA8W2NocmlzdG9waGUubHlv
bkBzdC5jb21dKG1haWx0bzpjaHJpc3RvcGhlLmx5b25Ac3QuY29tKT4gIA0KPiArQ2zDqW1lbnQg
TWF0aGlldS0tRHJpZiA8W2NsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tXShtYWlsdG86
Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20pPiAgDQo+IMKgQ29sbGluIEwuIFdhbGxp
bmcgPFt3YWxsaW5nQGxpbnV4LmlibS5jb21dKG1haWx0bzp3YWxsaW5nQGxpbnV4LmlibS5jb20p
PiAgDQo+IMKgRGFuaWVsIFAuIEJlcnJhbmfDqSA8W2JlcnJhbmdlQHJlZGhhdC5jb21dKG1haWx0
bzpiZXJyYW5nZUByZWRoYXQuY29tKT4gIA0KPiDCoEVkdWFyZG8gT3R1Ym8gPFtvdHVib0ByZWRo
YXQuY29tXShtYWlsdG86b3R1Ym9AcmVkaGF0LmNvbSk+ICANCj4gLS0gIA0KPiAyLjUxLjANCj4g

