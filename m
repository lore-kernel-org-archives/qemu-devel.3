Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD029C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 10:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBtfn-0004uD-Vf; Tue, 28 May 2024 06:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sBtfk-0004tj-10; Tue, 28 May 2024 06:03:12 -0400
Received: from mail-sgaapc01on20707.outbound.protection.outlook.com
 ([2a01:111:f400:feab::707]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sBtfg-0002V0-4L; Tue, 28 May 2024 06:03:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxJ6YeV09hfLIKNkDd0eEexJXKw0y56zKaRXe/bITYIuzSW4OgkoCuXQnBkiCNUXyAKJvdNbdwhOY4+MB0JLMaJ8jTkQu1QlQwy2QGPnbyJcDcWIzFQdhOWmOurZsyvISCG1nHHkudn5Fd/+9C/8Zdh9LynKm+383UOpxXBk4XjtYkYnEDoWjLcV7GDmrs6ha2y+JQIgPLyoE0etbvWfcYIHbusdkY0iNEIZLoOruN+eqyJrVCBC+XzmPvWZDSHKCbTNAGVsHqq1JyVpNRVyHuDi9+nfHNJs72bWYDFAdm/b65qXXYI7DtTHltGKvqTnsC4IhSZpamHPSrzejRZ7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNx++QnT8OpMUdG6Bijs77XyhPw76RLLzLFNUIiEIvc=;
 b=d3lbM/3T5d4Z51SX4OblNcK3jNCcpwdotXYsJG9/GuRZveJY3tmYhPnCWdbPZNnTauK3QJadNtX5eoEemglcknDCshcVPbUOts1tRHcXlalzkWSB9APs3s4Y3cL92lv9ES5/vT44S3isUKrkpCNPHCxZaBipFMuGecV19eA27vXPHQQQWjsTuRtM+bbcdLH/j/3eSQm78hMyjkBTZuuojy/BiEDEyjJcFvfhihMDsLlJlXEcMjFQF9B2ldgZeLJ8yyYsurgAFbup/+B3snRc5Y8mfX0iH9WZeXa7soRBOWfjVJkAt1Jr02UunMJQtao3BeAcf7dH3DZ10o0FoePT7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNx++QnT8OpMUdG6Bijs77XyhPw76RLLzLFNUIiEIvc=;
 b=iCqLC4qJFeRb01MUCs0sb1fWRRcFdi9Sdnmgq+hciz/ofIZwLFuhGVOnorX/++v97jLtNAzMbXClIDDLzTo7Xp7IGgr2WODjrlXETYR1kVgrsQJHXf94AdptHelQUDQgZ73sECOXgA2YSjWpa2E/8pMXkAbon8K5U2Kcg/5hoJuHWZICaQ/Dx74zbkytXzUqFb/GlrS6lNhAUbZ6y4tIE2QdBaBwbXDvXUkg4itUa1uQuYoDmjRoHvq91O8vdHudLk2XyF3as/tJwricYaFCXmmQVrydVXCdwLovxJlH/mCv87Etmrw5T5G46MJQ73YRTRQvT4sV+u/vSH1tbtWMJQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TY0PR06MB5005.apcprd06.prod.outlook.com (2603:1096:400:1ae::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Tue, 28 May 2024 10:02:56 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 10:02:56 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Cleber Rosa <crosa@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>, Steven Lee <steven_lee@aspeedtech.com>
Subject: RE: [PATCH v4 00/16] Add AST2700 support
Thread-Topic: [PATCH v4 00/16] Add AST2700 support
Thread-Index: AQHasAw9vuAr/T43PEue8t3w9svr7LGsamWAgAAAoaA=
Date: Tue, 28 May 2024 10:02:56 +0000
Message-ID: <SI2PR06MB5041C99C448D21D6DB8D8053FCF12@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
 <f2c66f47-af78-436b-968c-c267e84b9a18@kaod.org>
In-Reply-To: <f2c66f47-af78-436b-968c-c267e84b9a18@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TY0PR06MB5005:EE_
x-ms-office365-filtering-correlation-id: 0272cb5b-99d2-454c-4bb6-08dc7efd58f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|1800799015|376005|366007|921011|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?NUc5SFUwY2l1ZENMMWYxdFlONjl0SStFd0JRQ1ord0Z6bVNmcVNTdTlSNHc1?=
 =?utf-8?B?TzVBQWZSdFhWdVdac0hObE90blJjYzJxSURueiswSFlkdmYyOW11SVo3cWdT?=
 =?utf-8?B?dFZMckVwTDJpcGh4YjZMWWNVOEZpV2VOaEFKRUtRR0txOUVPNEFBRHQrZ1pw?=
 =?utf-8?B?Tm1ueHBGL1RpVGNjelhVaVNnV2hKWnNFOFZnR1lHQkNZekx4dUY3R1ZraGxK?=
 =?utf-8?B?eXB2V29yN0RaemY1UytzN0FuT3htMmRTTUZTNWFxMWg4UEhJZnM2N1RpWFp3?=
 =?utf-8?B?RWJIZzJpYUhLMExBOWRXaWg4SU5GekZFeUljdkhNVGNJWjFRRFovWmd2Um8v?=
 =?utf-8?B?MXVIWlVoMTYrUG80Y01KV1plU3JIUEFvdkhLYi8xamswZVYwNjNUQWpDM0pM?=
 =?utf-8?B?YkdJaGY1OFpCVnpWaG1OY3lvK3NTbzB5ZjNxaHZJQlM3a0tTa1FpWjNpTVFX?=
 =?utf-8?B?U3pCNjBUc3pRRUJqNUVyQk1KUE1EbC8vVmIzQ2RGUXUvcWdWVjQxNjRLVnJQ?=
 =?utf-8?B?VUcyUjA5b1BOMjQ5cHB4T0NEcnRsRERwbGs5d21obzBSM2ZqME1KMk9DcVZO?=
 =?utf-8?B?VGtsQjFWbzlYcnpuWlBLUFh2Sm9BQWU5d1Y2RmVkZ2VxUUEySmRpby8ySVlL?=
 =?utf-8?B?SUxzUTRUa0FBRFdJV2NuellPclBKU0E4T0VEWWZvSnNkWXI2YW40VThPMTk3?=
 =?utf-8?B?Y3VNbk8yeEhXakJQaVdxY01zNUxtbU8yc0tzTUd1L0dnOThzYUV6K2pPaGFy?=
 =?utf-8?B?YnRPTXhhRnFwcHI3Q0JuZ2czbVJDNGdPT3QyeUxLK3JBMEQySCtkdHZHaENy?=
 =?utf-8?B?QjNGR0QvYnFTY29JL1luaVgwNWJKcnRNaytrRkV4T1BFVVovdkkrY3lrNExw?=
 =?utf-8?B?M3NJYWx5SkFYWUlpSlkreHNrL1d1dVVkM2RxMjEyZlN4aldmMjlUdmYySzJp?=
 =?utf-8?B?aGtHeVN1bzNzazBJVEF3bEQ2YjAzZ01MRjZaZjVLQm5ocWQzaXhsYXNlWFVO?=
 =?utf-8?B?d3VwNlhLT1M0cDF3WWlkdngxOHljMWNjcG93WW1xMXlUdDZ3YzI5NkgxZVVn?=
 =?utf-8?B?Zm9RcnJEUUE0Z1hSdHlxY0FBbllUeHBuM09oYUtrVjlmajRhSE9LeDZoMkU0?=
 =?utf-8?B?eUhHZExnZlFwZWJxYzBhc3A1KzBrVXZHU0dzV0V2cVpIMitoR0NOYWJQTVNP?=
 =?utf-8?B?TlFPZ3F1RXl0WEQvWGRCYWQzYXl5RFVEK25aOTA3djhVNGN2WTAxTm5sNFZw?=
 =?utf-8?B?dUlNMHBFamt5QkRnSnM1NXZncS80MW0wR0psSkRNWHlvQk8zUEVBcVB6L1FO?=
 =?utf-8?B?ZnpQL1FDVXh4d0VwcnViL2RhbnFDV3c3Q1hsZnlVbmJodGZCY0JnemlHdFBB?=
 =?utf-8?B?TDZtaG1WSDhyc0FidndPL1ZDUndXUG5wdVFDTXlPYkcvNEJlazFna2hMbCsw?=
 =?utf-8?B?czV1TlZ2dUVYOEVOdEZUV1M3UU54V0dCWmRzOHd5OTVyTjdjMkZzbEt4UUM0?=
 =?utf-8?B?YlVLWmR4aXBHK2o2YzAzbExvSldlSkVCTWZJb0VCdGZQOGlBTDFFdGk5Y20w?=
 =?utf-8?B?YUtSQ24rNWdPeXlnU1I1RHpyaUIreHRvd3pUNDhyVWd3Uk5WRE1DQTdXMlVS?=
 =?utf-8?B?TWh2UmpGWFF1QnBvOHI0TEZ4Q0JqNDQ4TS81UWNHemhlWlppZWlFYVlEaHhu?=
 =?utf-8?B?MjZRcnFQZHZoM0RDS0QvcFUrSWM4Tm5XWk5EY0pKMjgyNUp2c3Y4UG1sM2dm?=
 =?utf-8?Q?R2/hANCP+FaVsn7q30=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(376005)(366007)(921011)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0JqdU1EQ2RaSzVtYkpXcVEvMjVIaGZsRXBCbnB1aU5BVlExVkREV3BOOHFm?=
 =?utf-8?B?aFZhOFBUYm50R3NSVHc5Y3JxaTFuOEpXRjllcXZab2JkdW4xSllRNUNJSVdx?=
 =?utf-8?B?a0JuRWVBRlZYdnVja1FnTTQ3WE4vTDZNWkRSNUpiOHhiZkxPc0h4bEN5b25I?=
 =?utf-8?B?ZkkyTGMxQnF0emVSU0pVKzVpNWY3MlRabnVJcEVnVUVodVlvTjV6UUpSZ0dk?=
 =?utf-8?B?aDFweE4vNU1vWk4wakt2T0o5S2xjMEpLdGluKzlaWUxudWlDS1p4VjlKZ2lI?=
 =?utf-8?B?ajNFaGQwQjdVTm9pSSswUXRRdkErNlNLRXR0cTJweDNvbjRUM01acU9DRytD?=
 =?utf-8?B?MU9hWHVjVm9sdTEvbGtQeEN5SUJYeHIySmcySjZBY3pJQkowSWl3YjZtZWRo?=
 =?utf-8?B?L3IrQ0dTY085QitSdm02eDJ3ejd1cWFDSUxrY2wzbEhoK0g2d1NzVExkOVpi?=
 =?utf-8?B?TXhDYklUUkdJTmhWbStqQWFNZEsxNC9lN0pua3ZUQTIxR1FTeFRQcXA4RE1K?=
 =?utf-8?B?bFN6ZzhsVFpGZng1VEZRN2xoL09OVm9yUSt1aHVBWlVxTEVDbG9BTTNGRFhx?=
 =?utf-8?B?Z3R1WHZlWVpjbEYzQmFTdy9uUEVoUllXc040aDVGNnRNQ1NObnVsU1BEWWov?=
 =?utf-8?B?eE1TcjlqQjBCSjRGTnlIK0p2L0ltWUIwdUg3SnBjaWh2dDVRWi90YzEyZDJl?=
 =?utf-8?B?WDJrcWdLVzh5eUUyYldDVWRhVTFKRG0xVFM5a0M3UEZVeWIzYnBLRmQ5RG5I?=
 =?utf-8?B?YUxLL1cvN25CamI0bkJjVmZQRWhaRUpRNFVsVjhESXl6a3JWWEZlVG51SlZ6?=
 =?utf-8?B?Y2ozdldSNHVlcWxOZEVNS3B5dVJnRENmT1lhWGtwL2hpOVlTZVVGZ25kMHlm?=
 =?utf-8?B?L3hqdUhMRTBRTXlXMHNaemJlTXc1bEQ2ekZUS3cwMUU3WUttOFEvVzdpdkFY?=
 =?utf-8?B?N0FJcGJUb2p2V0l4R3RQT1hyYWlHTndnQUJ4NUtrbDlDenpVdjgrVzkvMW1y?=
 =?utf-8?B?ZXB2anArckJmLzZJSDdVc2YwY0xmMThJU3M1Umw1QWhycnFKRjh6VTdFQUVa?=
 =?utf-8?B?WHhHalFNcHZrUlVkTkFqa3RhQVk1ZlErVHVuUndoQlhmK3hZS2Q2Z0x1eEJl?=
 =?utf-8?B?MEtDMTJpRWdBWXE3SktuM05nZWVLaHpnMTVSTHM3S2FXYWVaeDA2MUpPUExU?=
 =?utf-8?B?Mkg3WWVianlPNjcrTkVMc3RJYjQ3eGhHWVNVdXQrS2V0MTlUVFgvMlJhWlFF?=
 =?utf-8?B?MXkrZHhQNEZ0ZnprM01tSWZ5MGQwNjlGOHhxTVdOWmF4VHl1aDdxN3F3cDBJ?=
 =?utf-8?B?YitFSGEvYlBQMDdtU2R6U1ZTek4rVnhIelZua3NGYVhlUndGdVFoNjFHTUpJ?=
 =?utf-8?B?SGJweU9SWnhrVkFlYytDaGtkbFlMNVJ0VUpibWhuZWIwS2dlV0krWUxQNUdX?=
 =?utf-8?B?b1R4UlA3dlNYQmhFTElWQXNtWWhaRGJhcDloelJmL01WcG9INzgwbkxIUVNk?=
 =?utf-8?B?N3o0ZWVNVGpUVHJDNVZYcWlaMDVCazVNdnJURGVIdk5oVkZGQWFKUVd3Y3FV?=
 =?utf-8?B?bjJ2d213ODdJN055bzI0d3RMelBGOTZQN2hjc2JCM2FHSG1iZmc5bER5anVj?=
 =?utf-8?B?cndnME82aENwSVVNM3lXK3pRblBLTFdUdzUrcFhXa1JESk91YWEreTE5dUpq?=
 =?utf-8?B?MEh3czAvMnY0VVZPRkswYWRhYWVWc1RHbDk3MlltNGpVa1ZIdVpVeWpMTUVx?=
 =?utf-8?B?ZlVNNDkwTlhMOWlCUlo0OHA4MXlxMkIrcWtXbWp4bXQ5cGZXT1V0TWlNSDYw?=
 =?utf-8?B?NnBrRys4ODFXcnl2anYyeHZ4UzdKeFhEbk1RZ2o3bE1WUnBuUzhPbEZ5YWhE?=
 =?utf-8?B?TDI3ZWRVZWpyVEt0WkRvdEdxKzJsbXE1bWtZbStIamdsM0x5NTZsWW9acEZv?=
 =?utf-8?B?NERzd1A5NGtXcTJ6Z2lVK2xrM1pSeWNLeStmNkorZjQ4aEtCc2pkMk4yNkI0?=
 =?utf-8?B?bFMzakxDOFBSRDNrSnBsQTFwT05vVFVkek5wRm5QWERHaDNXQkMzNFZvT1JN?=
 =?utf-8?B?OEpDNk14VXR4KzFnVnNoMlQ3d3JERStIK1Qzd2lUTW1VRS9RSkE2cnhFOGdi?=
 =?utf-8?Q?Kfvje5Veny7H/8/UxT6src8bV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0272cb5b-99d2-454c-4bb6-08dc7efd58f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 10:02:56.3817 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQ18IuynnQhSp4/uW5vJvqhmPyg6Cjsba6oB59Wkph3B6eY9yQntXR8nFUOOoNGqE7s6H4AtlOBoB7uLDymWtKJWScFrRy01xhJBmI6xwd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5005
Received-SPF: pass client-ip=2a01:111:f400:feab::707;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQ2VkcmljLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEPDqWRy
aWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAyOCwgMjAy
NCA1OjU2IFBNDQo+IFRvOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IFBl
dGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IEFuZHJldyBKZWZmZXJ5
IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+Ow0KPiBKb2VsIFN0YW5sZXkgPGpvZWxAam1z
LmlkLmF1PjsgQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXJAYWxpc3RhaXIyMy5tZT47IENsZWJl
cg0KPiBSb3NhIDxjcm9zYUByZWRoYXQuY29tPjsgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBo
aWxtZEBsaW5hcm8ub3JnPjsNCj4gV2FpbmVyIGRvcyBTYW50b3MgTW9zY2hldHRhIDx3YWluZXJz
bUByZWRoYXQuY29tPjsgQmVyYWxkbyBMZWFsDQo+IDxibGVhbEByZWRoYXQuY29tPjsgb3BlbiBs
aXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3Blbg0KPiBsaXN0OkFsbCBw
YXRjaGVzIENDIGhlcmUgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0
cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT47IFl1bmxpbiBUYW5nDQo+IDx5dW5saW4udGFuZ0Bhc3Bl
ZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwMC8xNl0gQWRkIEFTVDI3MDAg
c3VwcG9ydA0KPiANCj4gSmFtaW4sDQo+IA0KPiBJIHRoaW5rIHlvdSBzaG91bGQgYWRkIHlvdXIg
c2VsZiBhcyBhIFJldmlld2VyIHRvIHRoZSBBU1BFRUQgQk1DcyBtYWNoaW5lIGluDQo+IHRoZSBN
QUlOVEFJTkVSUyBmaWxlcy4gV291bGQgeW91IGFncmVlID8NCj4gDQpBZ3JlZS4NCg0KQ291bGQg
eW91IHBsZWFzZSBhZGQgbWUsIFRyb3kgYW5kIFN0ZXZlbiBpbiB0aGUgTUFJTlRBSU5FUlMgZmls
ZXM/DQpzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tDQp0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbQ0K
amFtaW5fbGluQGFzcGVlZHRlY2guY29tDQoNClRoYW5rcy1KYW1pbg0KDQo+IFRoYW5rcywNCj4g
DQo+IEMuDQo+IA0KPiANCj4gDQo+IE9uIDUvMjcvMjQgMTA6MDIsIEphbWluIExpbiB3cm90ZToN
Cj4gPiBDaGFuZ2VzIGZyb20gdjE6DQo+ID4gVGhlIHBhdGNoIHNlcmllcyBzdXBwb3J0cyBXRFQs
IFNETUMsIFNNQywgU0NVLCBTTEkgYW5kIElOVEMgZm9yIEFTVDI3MDANCj4gU29DLg0KPiA+DQo+
ID4gQ2hhbmdlcyBmcm9tIHYyOg0KPiA+IC0gcmVwbGFjZSBpc19hYXJjaDY0IHdpdGggaXNfYnVz
NjRiaXQgZm9yIHNkbWMgcGF0Y2ggcmV2aWV3Lg0KPiA+IC0gZml4IGluY29ycmVjdCBkcmFtIHNp
emUgZm9yIEFTVDI3MDANCj4gPg0KPiA+IENoYW5nZXMgZnJvbSB2MzoNCj4gPiAtIEFkZCBBU1Qy
NzAwIEV2YWx1YXRpb24gYm9hcmQgaW4gQVNQRUVEIGRvY3VtZW50DQo+ID4gLSBBZGQgYXZvY2Fk
byB0ZXN0IGNhc2VzIGZvciBBU1QyNzAwIEV2YWx1YXRpb24gYm9hcmQNCj4gPiAtIEZpeCByZXZp
ZXdlcnMgcmV2aWV3IGlzc3VlcyBhbmQgYWRkIHJldmlld2VycyBzdWdnZXN0aW9ucw0KPiA+IC0g
SW1wbGVtZW50IElOVEMgbW9kZWwgR0lDSU5UIDEyOCB0byBHSUNJTlQxMzYgZm9yIEFTVDI3MDAN
Cj4gPg0KPiA+IENoYW5nZXMgZnJvbSB2NDoNCj4gPiAtIHN1cHBvcnQgNjQgYml0cyBkbWEgZHJh
bSBhZGRyZXNzIGFzc29jaWF0ZWQgd2l0aCByZXZpZXcgaXNzdWVzDQo+ID4gLSBzdXBwb3J0IGRt
YSBzdGFydCBsZW5ndGggYW5kIDEgYnl0ZSBsZW5ndGggdW5pdCBhc3NvY2lhdGVkIHdpdGgNCj4g
PiByZXZpZXcgaXNzdWVzDQo+ID4gLSByZWZhY3RvciBpbnRjIG1vZGVsIHRvIGZpeCBzZXJpYWwg
Y29uc29sZSBzdHVjayBpc3N1ZSBhbmQgYXNzb2NpYXRlZA0KPiA+IHdpdGggcmV2aWV3IGlzc3Vl
cw0KPiA+DQo+ID4gVGVzdCBWZXJzaW9uOg0KPiA+DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9xZW11
L3FlbXUvY29tbWl0LzBjMmEzODA3NDgzYjRlYmUzNjBjZmE0NzVkYmZjOWRmDQo+IGQyDQo+ID4g
ZjZkMTZkDQo+ID4NCj4gPiBUZXN0IHN0ZXBzOg0KPiA+IDEuIERvd25sb2FkIHRoZSBsYXRlc3Qg
b3BlbmJtYyBpbWFnZSBmb3IgQVNUMjcwMCBmcm9tDQo+IEFzcGVlZFRlY2gtQk1DL29wZW5ibWMN
Cj4gPiAgICAgcmVwb3NpdG9yeSwNCj4gaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1D
L29wZW5ibWMvcmVsZWFzZXMvdGFnL3YwOS4wMQ0KPiA+ICAgICBsaW5rOg0KPiA+DQo+IGh0dHBz
Oi8vZ2l0aHViLmNvbS9Bc3BlZWRUZWNoLUJNQy9vcGVuYm1jL3JlbGVhc2VzL2Rvd25sb2FkL3Yw
OS4wMS9hc3QNCj4gPiAyNzAwLWRlZmF1bHQtb2JtYy50YXIuZ3oNCj4gPiAyLiB1bnRhciBhc3Qy
NzAwLWRlZmF1bHQtb2JtYy50YXIuZ3oNCj4gPiAgICAgYGBgDQo+ID4gICAgIHRhciAteGYgYXN0
MjcwMC1kZWZhdWx0LW9ibWMudGFyLmd6DQo+ID4gICAgIGBgYA0KPiA+IDMuIFJ1biBhbmQgdGhl
IGNvbnRlbnRzIG9mIHNjcmlwdHMgYXMgZm9sbG93aW5nIElNR0RJUj1hc3QyNzAwLWRlZmF1bHQN
Cj4gPiBVQk9PVF9TSVpFPSQoc3RhdCAtLWZvcm1hdD0lcyAtTCAke0lNR0RJUn0vdS1ib290LW5v
ZHRiLmJpbikNCj4gPiBVQk9PVF9EVEJfQUREUj0kKCgweDQwMDAwMDAwMCArICR7VUJPT1RfU0la
RX0pKQ0KPiA+DQo+ID4gcWVtdS1zeXN0ZW0tYWFyY2g2NCAtTSBhc3QyNzAwLWV2YiAtbm9ncmFw
aGljXA0KPiA+ICAgLWRldmljZQ0KPiBsb2FkZXIsYWRkcj0weDQwMDAwMDAwMCxmaWxlPSR7SU1H
RElSfS91LWJvb3Qtbm9kdGIuYmluLGZvcmNlLXJhdz1vblwNCj4gPiAgIC1kZXZpY2UNCj4gbG9h
ZGVyLGFkZHI9JHtVQk9PVF9EVEJfQUREUn0sZmlsZT0ke0lNR0RJUn0vdS1ib290LmR0Yixmb3Jj
ZS1yYXc9b25cDQo+ID4gICAtZGV2aWNlIGxvYWRlcixhZGRyPTB4NDMwMDAwMDAwLGZpbGU9JHtJ
TUdESVJ9L2JsMzEuYmluLGZvcmNlLXJhdz1vblwNCj4gPiAgIC1kZXZpY2UNCj4gbG9hZGVyLGFk
ZHI9MHg0MzAwODAwMDAsZmlsZT0ke0lNR0RJUn0vb3B0ZWUvdGVlLXJhdy5iaW4sZm9yY2UtcmF3
PW9uXA0KPiA+ICAgLWRldmljZSBsb2FkZXIsYWRkcj0weDQzMDAwMDAwMCxjcHUtbnVtPTBcDQo+
ID4gICAtZGV2aWNlIGxvYWRlcixhZGRyPTB4NDMwMDAwMDAwLGNwdS1udW09MVwNCj4gPiAgIC1k
ZXZpY2UgbG9hZGVyLGFkZHI9MHg0MzAwMDAwMDAsY3B1LW51bT0yXA0KPiA+ICAgLWRldmljZSBs
b2FkZXIsYWRkcj0weDQzMDAwMDAwMCxjcHUtbnVtPTNcDQo+ID4gICAtc21wIDRcDQo+ID4gICAt
ZHJpdmUgZmlsZT0ke0lNR0RJUn0vaW1hZ2UtYm1jLGZvcm1hdD1yYXcsaWY9bXRkXA0KPiA+ICAg
LXNlcmlhbCBtb246c3RkaW9cDQo+ID4gICAtc25hcHNob3QNCj4gPg0KPiA+IEphbWluIExpbiAo
MTYpOg0KPiA+ICAgIGFzcGVlZC93ZHQ6IEFkZCBBU1QyNzAwIHN1cHBvcnQNCj4gPiAgICBhc3Bl
ZWQvc2xpOiBBZGQgQVNUMjcwMCBzdXBwb3J0DQo+ID4gICAgYXNwZWVkL3NkbWM6IHJlbW92ZSBy
ZWR1bmRhbnQgbWFjcm9zDQo+ID4gICAgYXNwZWVkL3NkbWM6IGZpeCBjb2Rpbmcgc3R5bGUNCj4g
PiAgICBhc3BlZWQvc2RtYzogQWRkIEFTVDI3MDAgc3VwcG9ydA0KPiA+ICAgIGFzcGVlZC9zbWM6
IGNvcnJlY3QgZGV2aWNlIGRlc2NyaXB0aW9uDQo+ID4gICAgYXNwZWVkL3NtYzogc3VwcG9ydCBk
bWEgc3RhcnQgbGVuZ3RoIGFuZCAxIGJ5dGUgbGVuZ3RoIHVuaXQNCj4gPiAgICBhc3BlZWQvc21j
OiBzdXBwb3J0IDY0IGJpdHMgZG1hIGRyYW0gYWRkcmVzcw0KPiA+ICAgIGFzcGVlZC9zbWM6IEFk
ZCBBU1QyNzAwIHN1cHBvcnQNCj4gPiAgICBhc3BlZWQvc2N1OiBBZGQgQVNUMjcwMCBzdXBwb3J0
DQo+ID4gICAgYXNwZWVkL2ludGM6IEFkZCBBU1QyNzAwIHN1cHBvcnQNCj4gPiAgICBhc3BlZWQv
c29jOiBBZGQgQVNUMjcwMCBzdXBwb3J0DQo+ID4gICAgYXNwZWVkOiBBZGQgYW4gQVNUMjcwMCBl
dmFsIGJvYXJkDQo+ID4gICAgYXNwZWVkL3NvYzogZml4IGluY29ycmVjdCBkcmFtIHNpemUgZm9y
IEFTVDI3MDANCj4gPiAgICB0ZXN0L2F2b2NhZG8vbWFjaGluZV9hc3BlZWQucHk6IEFkZCBBU1Qy
NzAwIHRlc3QgY2FzZQ0KPiA+ICAgIGRvY3M6YXNwZWVkOiBBZGQgQVNUMjcwMCBFdmFsdWF0aW9u
IGJvYXJkDQo+ID4NCj4gPiAgIGRvY3Mvc3lzdGVtL2FybS9hc3BlZWQucnN0ICAgICAgIHwgIDM5
ICstDQo+ID4gICBody9hcm0vYXNwZWVkLmMgICAgICAgICAgICAgICAgICB8ICAzMiArKw0KPiA+
ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgICAgICAgICAgfCA2NTUNCj4gKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiA+ICAgaHcvYXJtL21lc29uLmJ1aWxkICAgICAgICAgICAg
ICAgfCAgIDEgKw0KPiA+ICAgaHcvaW50Yy9hc3BlZWRfaW50Yy5jICAgICAgICAgICAgfCAzNTUg
KysrKysrKysrKysrKysrKysNCj4gPiAgIGh3L2ludGMvbWVzb24uYnVpbGQgICAgICAgICAgICAg
IHwgICAxICsNCj4gPiAgIGh3L2ludGMvdHJhY2UtZXZlbnRzICAgICAgICAgICAgIHwgICA2ICsN
Cj4gPiAgIGh3L21pc2MvYXNwZWVkX3NjdS5jICAgICAgICAgICAgIHwgMzA2ICsrKysrKysrKysr
KysrLQ0KPiA+ICAgaHcvbWlzYy9hc3BlZWRfc2RtYy5jICAgICAgICAgICAgfCAyMTYgKysrKysr
KysrLQ0KPiA+ICAgaHcvbWlzYy9hc3BlZWRfc2xpLmMgICAgICAgICAgICAgfCAxNzcgKysrKysr
KysrDQo+ID4gICBody9taXNjL21lc29uLmJ1aWxkICAgICAgICAgICAgICB8ICAgMyArLQ0KPiA+
ICAgaHcvbWlzYy90cmFjZS1ldmVudHMgICAgICAgICAgICAgfCAgMTEgKw0KPiA+ICAgaHcvc3Np
L2FzcGVlZF9zbWMuYyAgICAgICAgICAgICAgfCAzMjEgKysrKysrKysrKysrKystDQo+ID4gICBo
dy9zc2kvdHJhY2UtZXZlbnRzICAgICAgICAgICAgICB8ICAgMiArLQ0KPiA+ICAgaHcvd2F0Y2hk
b2cvd2R0X2FzcGVlZC5jICAgICAgICAgfCAgMjQgKysNCj4gPiAgIGluY2x1ZGUvaHcvYXJtL2Fz
cGVlZF9zb2MuaCAgICAgIHwgIDI3ICstDQo+ID4gICBpbmNsdWRlL2h3L2ludGMvYXNwZWVkX2lu
dGMuaCAgICB8ICA0NiArKysNCj4gPiAgIGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfc2N1LmggICAg
IHwgIDQ3ICsrLQ0KPiA+ICAgaW5jbHVkZS9ody9taXNjL2FzcGVlZF9zZG1jLmggICAgfCAgIDUg
Ky0NCj4gPiAgIGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfc2xpLmggICAgIHwgIDI3ICsrDQo+ID4g
ICBpbmNsdWRlL2h3L3NzaS9hc3BlZWRfc21jLmggICAgICB8ICAgMiArDQo+ID4gICBpbmNsdWRl
L2h3L3dhdGNoZG9nL3dkdF9hc3BlZWQuaCB8ICAgMyArLQ0KPiA+ICAgdGVzdHMvYXZvY2Fkby9t
YWNoaW5lX2FzcGVlZC5weSAgfCAgNjIgKysrDQo+ID4gICAyMyBmaWxlcyBjaGFuZ2VkLCAyMzEy
IGluc2VydGlvbnMoKyksIDU2IGRlbGV0aW9ucygtKQ0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGh3L2FybS9hc3BlZWRfYXN0Mjd4MC5jDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvaW50
Yy9hc3BlZWRfaW50Yy5jDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvbWlzYy9hc3BlZWRf
c2xpLmMNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L2ludGMvYXNwZWVkX2lu
dGMuaA0KPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfc2xp
LmgNCj4gPg0KDQo=

