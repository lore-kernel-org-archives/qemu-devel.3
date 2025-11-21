Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE11CFC516
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcj3-0000Bx-BN; Fri, 21 Nov 2025 20:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad.schwarz@siemens.com>)
 id 1vMbSE-0005wD-PG
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:26:19 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad.schwarz@siemens.com>)
 id 1vMbRn-0003Gb-HX
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:25:59 -0500
Received: from VI0PR10MB9012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::13)
 by PA2PR10MB8550.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 21:06:45 +0000
Received: from GV1PR10MB8993.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::21)
 by VI0PR10MB9012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 18:41:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obtoQ//ZexlGT7dGOJloHhSU4WUGJf5SpBp31St70KGaTVHBT3CAi+/hkDoS/GISIXJFXQ0iWZX7VHz84/+VlMFcCOc+pnlKm3Q6G98dWb1O+rjE2JdqPWtFN3RDYXCry1O2GhIEFN0KRFg+6xq91+cFWYgc2GuAKGFMl8jfQkVtQyYOav4T0a2eNdxZX5Yzj8ZQ6+3sIjsZKvyTmEBJH9Z/+fcS9HCvgAhYbVNMOJ/j0yVHuoBFqHKk0M2sCWtbqqxnWNo3qQOfURxu4ABP+IkhRe4UCpFWL9vpzeswokAixIrylbYeKaJ8s3Hp6IWJyaqa4ZweeVzKtjeA07VnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aH1NQ/dkUO/x/b5BhJ/4AVm/KlGWu46PeEh5eV0RbU=;
 b=xAMQw+J7tQlpCYxGPjC9JH51jfyhSTNtbCSgeESUfKnyHTQl+qXeFOfL4RRLLcnbi0yGThgqS4qC44+VQKO2phFhYtNIl1F8H0jQnER4QpIpHf8HQ4hxENx1CEP9XmHK52sSB8FDV29SzbWN+6vQgFN60J/6Rt5xEdtF2ywpJE6mAEjetBATp9oU21CPdLij8p/8sjyg+3sdIu+AkbBnzw3HaWscUwv6yiTYWyyF/+9uZ9MZ328A0ty+EY1aNLWM2or879WJClF9Z6NzR1zNXjzTmKneglLGoNHuG/GxKmviWEmz25wfwJkQ4KTHSZfhwNLgX9STEGwFAU+pVMq+oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aH1NQ/dkUO/x/b5BhJ/4AVm/KlGWu46PeEh5eV0RbU=;
 b=rTIGc0Hj8OOGblXSUk6NiSi56bl7xUCnwYoNu7f0dby8Ywppbn03UFXNSXZVcSopJ9Z0+cyyZC3XhQheWPKfX78OXuA7/5Jsl/I4zhnL97aha20NzK77dBhA57OCvKrtFmFJxdRtYSar2upL718tDWsHSThyP0x3ez/eoDDGdJRwpU2IzWHDlelaCNwNuDDhYmPJaco9gvOCoGB2ejPdWc9vaWpszFmGMIiw/IecMjrAvARBo6BvbMrTlCTRj3SwBXhrcjytkQtM9pnYsYHLPCK6PnG29zfmVED4t+TM/I8Nvi63ebdgpQ68gfRgy+u40rSvTibkl8N0OFSmh2K8Ng==
Received: from AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:33c::13)
 by GV1PR10MB8993.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 14:57:11 +0000
Received: from AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::214b:9b1d:acac:e64b]) by AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::214b:9b1d:acac:e64b%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 14:57:11 +0000
From: "Schwarz, Konrad" <konrad.schwarz@siemens.com>
To: Paolo Bonzini <pbonzini@redhat.com>
CC: "philmd@linaro.org" <philmd@linaro.org>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/1] scripts: Changed potential O(n) file size calculation
 to O(1)
Thread-Topic: [PATCH 1/1] scripts: Changed potential O(n) file size
 calculation to O(1)
Thread-Index: AQHcWXoCyaQlcz8AKEufgNoVu9G9F7T9EQiAgAAYBqCAAA3KAIAAAwVA
Date: Fri, 21 Nov 2025 14:57:11 +0000
Message-ID: <AS8PR10MB4680AA357EC1813BAE370DFC8AD5A@AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM>
References: <CA+kmUXafV4PPo2t+P23g9QRXHjaH_XBke3DjzbvciqBtw+i-OA@mail.gmail.com>
 <3a9faadd-165f-4d18-af04-211f9edab518@redhat.com>
 <AS8PR10MB4680FED05DB882C0C7751E058AD5A@AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM>
 <CABgObfb89UUyha3xz5d2MihRkg2WKBTpUOiNMA5o8oPE=MBMyQ@mail.gmail.com>
In-Reply-To: <CABgObfb89UUyha3xz5d2MihRkg2WKBTpUOiNMA5o8oPE=MBMyQ@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=48654b43-5805-41b3-b47c-0dcbb64f1baf;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-11-21T14:52:07Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB4680:EE_|GV1PR10MB8993:EE_|VI0PR10MB9012:EE_|PA2PR10MB8550:EE_
x-ms-office365-filtering-correlation-id: aebea28b-ffdf-4c84-995d-08de290e3ffc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?KzhWNWlROXhjcGtDajRZbHp0Qm9tRy9pMlRGeFUxSWc1MEI0ZkVNenRkd3Jp?=
 =?utf-8?B?R3dYTldKQkZZU2Q2OG5PU1RSODFsckhYVHBBWHhDSUl1MnFlNEdJWXZ5RWRx?=
 =?utf-8?B?c2JuZjROM3BYMWdXdXVucWZYS3BnMFlvUDcrM1FBcFUva1VCeXdvcnhnL0g2?=
 =?utf-8?B?S2dtaU9qaFd6R1grQVJPU0RieDlCOGxzNDBjMEtzOEV6QjRxc285clhNVjc2?=
 =?utf-8?B?WUUwc0JsVjg2b2RaQ3JYYWRHWjQrNGJCZ2w4b2RpaHh1LzB4NnZCUmxaT3FX?=
 =?utf-8?B?S3ArN0FNejc5MjRsaDRaRVJtbGtYdXIvbTFwcGFCUWFlZGtxR2o4TWI5bmtx?=
 =?utf-8?B?YTlYd3Z0TVpEV2NyWm5sTWNuV29DRmNlc0VGaktQcUxzUitVYStuR1BtYW1u?=
 =?utf-8?B?aUhJNU82QW5majJxb1hvbW1GNXNTcGFVYXFBMDN0b3YrMG9UQ2JWSE9jV3VO?=
 =?utf-8?B?a0NONVJabmJVTDA1YjRqNW5qZVlSOHRadHk1dWtGZURJSHlMVEhIcGxqNnZi?=
 =?utf-8?B?R01jaHhIRk1RREsraFhwbDlGSTZXVUNaejFEUm1PL3MrT2RlNGlnaDRkclFS?=
 =?utf-8?B?cklMZWUyc1lYdTlDanVtOHpDVDVORkI0OUR0YXFtZTBINUprZXN4MWhzczly?=
 =?utf-8?B?anZYWHlxMzNZR2tXeUdwNW5YYWJjeDJiUG9nWnJRV2xUUXJhUTc1UDE4Z2lU?=
 =?utf-8?B?UUZMakFJeUd1VjJpUjJrR2M5Ni9ka2kwK3lQQ28xZUw1NzhUMUpIY3ZQSE54?=
 =?utf-8?B?SHN5d0tUNUlORlJaTWNDQUZJOFE2MlJMOGhrMDUzUUlZRFNRWmNSZE4vMlFB?=
 =?utf-8?B?NGZVbU9mNXFmci9DMzRjS25NQ1ZDOXBSQWhYQ01PQ2IxSW5NMlEyRUhTM0ha?=
 =?utf-8?B?Y0JUcmlVTWI3YXdIb3pXSTZSZ21zOGEzUzZKYmxjb0kxc2Q0cGsrZkdsRjlO?=
 =?utf-8?B?VjBYN1VNN2hxamE1YlJ3ekxDWTllMWtQc1VzL20zV3pXMENmQjJRbEhmRkc3?=
 =?utf-8?B?STFVMitYb1VJOE9ZTVQwdmRpMVNGUkdhaXBLcnU5QS8xWEtSY1dUSXZJbXR0?=
 =?utf-8?B?RzFUYjdzOUExQ2srS04yMDgwYnJzYWdIaWtVMWJjYnNzUkxoV2N4akIrOW03?=
 =?utf-8?B?UTVXMDFEeVpDK2NpUzdyKzZtK1lUVWpxV25lNFgrUmswZURTcU9jYmg2K1dR?=
 =?utf-8?B?OUkvOWQ3S0t3QVFxNHYwc29nQUllZDNmMUpxcFFPNGxia2xyS2hCUDErbXVJ?=
 =?utf-8?B?Nmk1cXJPVVJrbm1aMm4vTG05R1YvZmJpUHBkY21XOFVkTGZlU0xIM3k4alda?=
 =?utf-8?B?T3MzN1JkYUFYbWUxd2c1QUpnZXZ4Zk1pdFBaUzdmYk5lTk5CdWpOaHNKVTIv?=
 =?utf-8?B?ekJWQStqckZPZkZxTWkxYUxEVjJEcmlVVWNhZmExR2Y4MDZaZGlUaldHNExV?=
 =?utf-8?B?aXdFdXZrYjhueE1tZVdNRVU4ZTYzUTdzVXkvR0x0M3FCQXBDRlFuWnROWnc1?=
 =?utf-8?B?cmlmL0g0ak80N3dxWWhyb1VKZWZ2b2NBWDFlb2xxZndUbldHVzBnS1FVQ205?=
 =?utf-8?B?cjJRMmhYdUpsV0tENFAzbzVkY0gxaWQrdUcrVkoxbkhBWFRLTDk0TmEyeGhF?=
 =?utf-8?B?U08vUW9JYnQ5d2ZrMTJuZjJQTkk2OUN2T2VCandSWUtZRFRCdWxRSTl0SU9J?=
 =?utf-8?B?clhxOVp1ZnRBNXQ3UFpOTVZnNW9oenhSS0MyZy95VUFZWWFaYWVWSWlmeEc1?=
 =?utf-8?B?VFh3MjdacU1HQXBwVjRXN0ZLLzJhZXo1NlE0YVV3SDF5Mk1NL294cVBpejJn?=
 =?utf-8?B?ejRMZ0U1Z3dYY2t2N2VOZzVpNTNCcTE4UmpzcFlSNmFjUFJueHFYR1dONGg0?=
 =?utf-8?B?S2VDQXh0MDgrTE1GNXJBMk5VQVBzbzhNMzF5QnlQQVV4dU55SUphL3ljeWNh?=
 =?utf-8?B?ZTBqSjd1aHhjTWE2eXprNGd5WmNOSkVNMmkyTzNpb0N0a2g2bG5LMDVpVWxn?=
 =?utf-8?B?TUxlc0N1R0k3VmhGZWN1SE10R1d3a1Q0eFk3Z25LTVNNZ0JLbUUwcURHMzBV?=
 =?utf-8?Q?4rL37F?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk5sYk1nSWRDVnBwUnN2OWlDSHRoMlprWEtTREY4eFJ1VFNVNVZxL0g1UVUx?=
 =?utf-8?B?NWJkUnNVdGg4ZFRVTW5yWlFqNnBLeVZ1YisxcXRSRjhDZ2swK1RsZ1E3RFcz?=
 =?utf-8?B?VzRyanJ6NDJWVTQ3Yk5uZ0VHUi8zLzFkck9JNDFNa0FlWWc4VTlLZ2k2ZWdZ?=
 =?utf-8?B?N3Vnb0xidVNxUVh0WFp3NVB0OTZacjVZMzc2Y1o0VGRSekE1d2JLOVNqMVE5?=
 =?utf-8?B?Tkl0d2ZLRlM2bnZYUW5pZmJmY3VOVnN6U3hIVG5HZTlOaEVQR3FPeHN4blBU?=
 =?utf-8?B?aXdiR1dUTDlvZmFnVjhQK00yMStVUXo1QkVRdUxIL1ROTXArNWdDMDh5K0gr?=
 =?utf-8?B?Wm1UdWNSN2E5eFJtRDJhNVRaanczNXk1cXRmSDhvZlhGSkhqSXNBWDNKV0h5?=
 =?utf-8?B?dDdVTGQzZDNFc0NDa3NjbTJTTFdFSk5abVdxTy9Sc2FVUEV4SUdOQlBpWjNW?=
 =?utf-8?B?MnA1OUxVUlJCeDNibDZyU09rYStQZGVxV3dZalQ0YXRGd2p1Z3FveHp2NGFJ?=
 =?utf-8?B?ZW1LQ1F3YkFuNGIrL3JzT0s4ZWpvZStWTS9rdFJXclFlZHFuZzVVUmpyRmsv?=
 =?utf-8?B?cGovTEtjZHMvN2hHUTUxbExhdDlGR3FYZlF3M0RCQktCNXAvSmtpN3ozU3FV?=
 =?utf-8?B?SlIrMTBhODczQ2tBbTkwVkFYWnc5RmhQVUU0U0FjR0tONk5CR0VPMks0L1Ja?=
 =?utf-8?B?MURVYWI2VVVMMFgrejlXSDVMWllLaXo0bTFJTUZGS2ZuaHJmZ2hVV0VJV3hE?=
 =?utf-8?B?Q0VVbjYySkIyT1IrMS9zMXBnZlMvTkgycVZsK1k4dk83Nnh3RmR5MVRaL21r?=
 =?utf-8?B?bStxRGV4K0NaQ3ptVyt2ektWY3lTTFhEVGJNbkF0aklrZWVrZjdVVExtY2xI?=
 =?utf-8?B?ajZPSjF0L1RCVjNWTCtFV0V4dkFCT3ZUdkdqcVZRUkdHMFRtMkNpSTduVWtv?=
 =?utf-8?B?b0hWajR2MlNiOWhwaFZtZnZUK1RKN1pDUlNudUZKZjdObXNKYXNPampTZnU1?=
 =?utf-8?B?UGRvWm9Cazk0cHZaZThKcFdSRjg3NjlNbElncWNTeG1yWEdhbnVUbXZRMEJw?=
 =?utf-8?B?b1k0Ymg5Zk5lR2hCRmVIamNIRDFrS2lhN3dZT2RYbUE4dDBCSTZSNW5KY3BP?=
 =?utf-8?B?cDluMU8wWmRObjg3a1YrUWY0ZFR1aGxYcGNjdkY0TVZPcHdMV1dWcmRvME9M?=
 =?utf-8?B?QVRBMlVyRVArRXB2MXJlYVpadUMvb2FCQVZxVGI2ZkhpNXdHdHB5OXd3Mkh4?=
 =?utf-8?B?d3V0NkxJd2sxd3IzSUJoWXZMbHQ4UnM1SjZzUjBoY0xCMW4vZ25tbUIwWmNm?=
 =?utf-8?B?dldHR3lFdG5hUERWelFyNGtQaHEzTVN2VFpBdXE1MVplZ2txWUhrTzkzYkVP?=
 =?utf-8?B?eEpabEZjSnFHOUpVK0FsRkZpaDR6dDY0SnZ6eTY2SlZHVGMrNnZRbENMZXN4?=
 =?utf-8?B?SGlmdWZFSnByUnA1RUpwa3JBRjcvb0xqYnNqRnBGeXhuazFmRmlacGRhWklU?=
 =?utf-8?B?a3hiOFlub2hTSXNNeW5vZVQ1Yms4emltRFdFWU5ZWHJDa3lTeldiNWVrRWdi?=
 =?utf-8?B?U2FzSllESko4enBjbW9qMm1jcm1GblVsVWRFZEVsbS81b3Y5OHFUTFJSY3dM?=
 =?utf-8?B?RUJ1bmQrNlBnSi9wUnpKUTZwSk1LRi8wR0RCbURVazdGL0p1Uzg5N1h1RzZJ?=
 =?utf-8?B?MzBqdm85Njl0MTg2YXNpQXd5cHhvaHRGMjJ3dFlRZFljc1Q3cHA3cHp3WTF0?=
 =?utf-8?B?b0RIbkEvK216VFptTVJmV29PbTQzbkdhRWRTMy9qc2I5bHNmcDJRVkE2Qlpn?=
 =?utf-8?B?R00yZ3lyVDlLcndtRjMyaHdXc0EvQVRFTTZIY2gwMzRSS3N0NFUySENnd2d2?=
 =?utf-8?B?KzY2aWpRelUxTUtFcTdzeSt1dElyMG1JNXNmZnltWWlWWDNBaXlmNzM2b1dn?=
 =?utf-8?B?a2xZNm9jMGJwY3o4eklPOTlQbmVzeTlHb3F2WmZ3SjJHaDhzSkJMcFJtQmFn?=
 =?utf-8?B?S3g5T0FKVllibzRweXpCZzBmbldWa1pZRlBoRWdvNXJiVFZlbUlSdm9NeVJQ?=
 =?utf-8?B?d3JMTUhIL2JIUVpOYTg0dDF3K29YazlzTFRUY3NoNGVHYytCY3VWK1dROVgw?=
 =?utf-8?B?RWxPdGlQN3ZwWHQxS3ZFUXVjQk9oT0dGTWx2UmdLVHhwUG1VOW5nVis3cEU4?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aebea28b-ffdf-4c84-995d-08de290e3ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 14:57:11.2580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P6LMmMH3QREFKm6MixxR11Luo7G9ejLEsh+zaErxyyih/1H0I2LKFfaR0bHpdDQfAPcIsJBflbSDFstS8cH6zQNEgocbYHnQxEedRRaLpVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8993
X-OriginatorOrg: siemens.com
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=konrad.schwarz@siemens.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBCb256aW5pIDxwYm9u
emluaUByZWRoYXQuY29tPg0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDIxLCAyMDI1IDE1OjQx
DQo+ID4gVGhlIHNjcmlwdCBpcyBkZXNpZ25lZCB0byBiZSBjcm9zcy1wbGF0Zm9ybQ0KPiANCj4g
U3VyZSBidXQgaXQncyBub3QgYnJva2VuLCBqdXN0IGxlc3MgZWZmZWN0aXZlLCBhbmQgdGhlIG9w
dGltaXphdGlvbiBpcyBhY3R1YWxseQ0KPiBxdWl0ZSBjb21tb24uIEkgaGF2ZSBqdXN0IGNoZWNr
ZWQgYW5kIGl0J3MgaW4gYWxsIG9mIEdOVSBjb3JldXRpbHMsIEZyZWVCU0QsDQo+IE9wZW5CU0Qs
IE5ldEJTRC4gUnVzdCB1dXRpbHMgZG9lcyBub3QgZG8gaXQgZm9yIHN0ZGluLCB0aG91Z2guDQo+
IA0KPiA+IFRoZXJlIGlzIG5vIGd1YXJhbnRlZSB0aGF0IHRoaXMgb3B0aW1pemF0aW9uIHdpbGwg
YmUgcHJlc2VudCBvbiBhbGwgcG90ZW50aWFsDQo+IHBsYXRmb3Jtcy4NCj4gPiBPVE9ILCBpdCBp
cyB2aXJ0dWFsbHkgZ3VhcmFudGVlZCB0aGF0IGBscycgd2lsbCBhbHdheXMgYHN0YXQoKScgdGhl
DQo+ID4gZmlsZS4gIEl0IHdvdWxkIHNlZW0gcHJ1ZGVudCB0byBhdm9pZCBwb3RlbnRpYWwgcGl0
ZmFsbHMuDQo+IA0KPiBQYXJzaW5nIHRoZSBvdXRwdXQgb2YgImxzIiBpcyBhbHNvIGEgcG90ZW50
aWFsIHBpdGZhbGwuIEluIHBhcnRpY3VsYXIsIEkgYW0gbm90IHN1cmUNCj4gd2hhdCBoYXBwZW5z
IGlmICRpbWFnZV9maWxlIGhhcyBhIG5ld2xpbmUuICBNYXliZSB0aGlzIGlzIGJldHRlcjoNCj4g
DQo+ICAgICBscyAtSGRvZyAiJDEiIHwgew0KPiAgICAgICAgIHJlYWQgbHNfaWduMSBsc19pZ24y
IGxzX3NpemUgbHNfcmVzdA0KPiAgICAgICAgIGVjaG8gJGxzX3NpemUNCj4gICAgIH0NCg0KWW91
IGFyZSByaWdodCwgSSBmb3Jnb3QgYWJvdXQgdGhpcyBjYXNlLg0KDQpBIHBlcmhhcHMgc2ltcGxl
ciBzb2x1dGlvbiBpcyB0byB1c2UgYGxzIC1IZG9ncScsIHdoaWNoIHJlcGxhY2VzIG5vbi1wcmlu
dGluZyBjaGFyYWN0ZXJzDQooaW5jbHVkaW5nIG5ld2xpbmUpIGluIHRoZSBmaWxlbmFtZSB3aXRo
IGEgYD8nLg0K

