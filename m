Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E50C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 16:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZv1p-0000Vr-0n; Mon, 20 Jan 2025 11:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZv1l-0000VO-Tl
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 11:53:31 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZv1j-0001tE-7V
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 11:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737392007; x=1768928007;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=YgeEbi8NBg1Qgt7z4xaBjKIPTokE2EfY8kpJpvI9brs=;
 b=C0qDIbS8mZsU0uOuv6AVX+h1xCiO5npO8hcKZxhVuxHQLSyKOSfRpTEH
 Qpl/mIGGYOQ9e5rnldYnkZpdLeVktBA2rJVcdEQNZj2gKexuLYRZAIO7+
 TbrKSUOS6R3lEM2BHuiLk2B5qnGvdppUsoJgJsOWnY8vtPnn5T3O7TMqP
 27mu2rhlFYmbmOkyu9BlYIk9gRfPs0OvXO5OhK7G+4WXFkeONR4CxUFs3
 fkCSL9d9fvDd26oAA2USsNE+68AD5Rbcv99Js9Pb0bEayVFmv0e4tCGkA
 k9n/2UPwl8cEUBK9y+r5RWCqgLxzWZOQ9k9/3rvn2Q7yTLgGmJ0sMkOOZ w==;
X-CSE-ConnectionGUID: Ij0ek4D1TSm0Tm6fzC2EJQ==
X-CSE-MsgGUID: ATg6/ADBTAWho6ldaHnTXg==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="29122928"
X-MGA-submission: =?us-ascii?q?MDHUSW5msbd5c/3uni32qsWZAgITE6w/dGQxW2?=
 =?us-ascii?q?5BGne7JU1t+XDiyf4gqbUuej+n50Eu6IxCC6XJhE8VLfNRvDiLc4sv9u?=
 =?us-ascii?q?571Oib3Y8G7rm4aoxgXWeWGSfiCgYQDL870m9zOzMOE3guJw2Joa+Olz?=
 =?us-ascii?q?s3zZ4dTfm4mXGkUXQmc9W92g=3D=3D?=
Received: from mail-westeuropeazlp17011030.outbound.protection.outlook.com
 (HELO AS8PR04CU009.outbound.protection.outlook.com) ([40.93.65.30])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 17:53:22 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOHt/QWBH+xNNxdbUbnQ3bmNt4UAsatJcrdYWr8VrC4Jz+ju3B+akqt+mhmb6TTULRy94YUeFfpLowxUnKODrsgpT0l/dWHsEjRz/KyRToToBYl+OyAH0t3NVk66jgsbVN/AAzCzWo1qlnlxiAeTE8gL0P/NttHGy1+xO4wpjmhBA1txl27bqsySCuKATEPU88KZbJB1Wl1z5gG2MCwiX0EHKMRVAcDtmG3hEv/69xO9z9C/6AMmFeCEuzDJXju43m1Hl8RkjimF78a8xyDEL4UlA5Osfpum+E7znWGeShJ5rKTBfWYVuPF7K7xFYZWf2TsTNgUqvQ+DUFlb/z9fVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgeEbi8NBg1Qgt7z4xaBjKIPTokE2EfY8kpJpvI9brs=;
 b=XTCPsdZ28c2GMW39W3Qjaq0V0b6oFGBgpejz5j6qU+2EJOJ0O0rGUJO9XN/si/FGmEv/0GrKW+JuL9bUXqtfDO7OKKKkvhUifzg5YB3vEUN06juuz+667O8iXIN/plr6cDF3imKAGjtYejSX4+VPFeKim0CKwVb1qyKsYejIW4nHPd/7hLt6Nphb0gajp9ikM456g6Ll/iL5FZqUhF2CvaTOSVfN+fxrhy7/NKB+isLNLNvkMf1D8Zw63rhJ7AMj6cjF9vR7xdmN1VXnjvPjYLTJzDjivr1yUDRiAU98WDBET9DObyXbjnlxmG0+CR23CgZsjW5Z95zTEFcPTnC4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgeEbi8NBg1Qgt7z4xaBjKIPTokE2EfY8kpJpvI9brs=;
 b=EIi42XMwmmXsA8e2hOzTlfflvJLAT6SmPr7K/kdk1Z7AOmGNkFGqTuJMIEpyruMJ0cY42FakYDSesAvWTbdWY4ZNvYEsKZ/ltTDzaNeJxhLLL0y5q1QNX+FZhak8pUgijW8on7Rjhsk1UUys76bdv/jdVIOTqLNi+3PH/8ULDs5mUWOoC7CwHDCSWU+LGR/9caUnDS2DiFPt135eENyHwy4Zaa7SRaPoSTaCzuhWW3XXwj0CbG2K7qFNQycHafBXVRspwWmOxjUni4Gy7qMVEY5g/SY2LMmUqOeol4Ti3lOkShe+Lcnl6NOJsVAC5LJR+HqAMJ5+d1lLuCoXQBEPgw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GVXPR07MB10217.eurprd07.prod.outlook.com (2603:10a6:150:227::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 16:53:17 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 16:53:17 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw4M=?=
 <philmd@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/2] memattrs: Get rid of bit fields
Thread-Topic: [PATCH 1/2] memattrs: Get rid of bit fields
Thread-Index: AQHba1dKUKMIvxf7hE+i3hibS42/FbMf4NoA
Date: Mon, 20 Jan 2025 16:53:17 +0000
Message-ID: <99397e13-e74e-45e0-8f2a-6d045407bc81@eviden.com>
References: <20250120074258.2204342-1-zhao1.liu@intel.com>
 <20250120074258.2204342-2-zhao1.liu@intel.com>
 <CAFEAcA_VAOU+p_BC5bpnk2GKa5piywjf+yhFTh=-3O7TGut+uA@mail.gmail.com>
 <Z458D/RuBQ8Kq0al@intel.com>
In-Reply-To: <Z458D/RuBQ8Kq0al@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GVXPR07MB10217:EE_
x-ms-office365-filtering-correlation-id: a9a25d6d-50b2-40c7-b0a0-08dd3972f022
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NEJyT25wQ2hDbE1FRS95Z0F2clFPL2E2dlBzN3ZOSWVMeVdNTktvODJlV1dZ?=
 =?utf-8?B?cmhYOThQWjd2SFFsczNuYVFpT09QR0NMc0ZwMiszbUxpaEFxRkdvTXNROVZX?=
 =?utf-8?B?Rnp6STd3clR3VnlaN2xkcWpjem5aWXp1eGxxRzJXTFBuVWcyUkR6eTN4L2FS?=
 =?utf-8?B?VFlPR085THd1YkdONVVpaDBWNE1kNm9zN0ljU1FEQWpvRHdnall0TnJoeE1F?=
 =?utf-8?B?UWxCTSttTDRaUkExWWNaTGdFRnI5dGgvMk1yUlVwMnlhRGpNdko4c2dIbnZD?=
 =?utf-8?B?dDZvUC9vdDNlaEdpTVYrcTcrRnFYVVROMjRhOUhPaTNnYk1vRE5PTEJxTUtp?=
 =?utf-8?B?cDZBdVdlMEV4MGJ3bTJNWm45Z0FBNGpXWFpkUkxpa1BDa0ZGM21XNEU0cW1N?=
 =?utf-8?B?MDFEYW05QnpFdDBhQ3JpU3pVVGRONExKVVhwU0luYmNsNVFTVUFUaUdwY2xB?=
 =?utf-8?B?YlZJbFZ3SXhMSXE4VHpwMkFRWWNWRWNRZ3h1K2ZQcjd3Tjk4b1QzMlc3YjBO?=
 =?utf-8?B?Y3dkU3VUY0JMamk1RHJ6L0thN01nMXJyVVdUQXowcDM2c3J0WmRIcjl1TzNu?=
 =?utf-8?B?NXBrQWNjcjh1dTFwRGp1WmJjWlJxQ3hPRVlHNnB6Z29jam9UOWREWVZ0Slh0?=
 =?utf-8?B?WnRkQTB6ODR6VUl0cDdZZ3NCdE1PZkJKSzB6MTRvajIrNGJhekM3STF6R2dj?=
 =?utf-8?B?ek13end1TW5JOEF5cllLZUMvTGN4OXh2akdyWkQxdkYyR3dtM0FMUllOYmgv?=
 =?utf-8?B?RnMwY2t5dlFlYVlPcDBob3BLeGs1K3Z2WHh5cGt1U3QwRUNvclNVRjlxVE4v?=
 =?utf-8?B?TW4vU1l3TnQveVhrZTIyUS92OHJYQTlwWWlnYnRSMWc5ZDR2N28xZEpNbzFQ?=
 =?utf-8?B?VExEVjF3WHRMd0l6dFVBTGpRODY2OUUvR3JYaGVVWWVUekRsTlB2aUZ2bkdV?=
 =?utf-8?B?K3ZnNjNZZ05wNjl5elFzRTNoeFlnWmZZeHRpd28wakZ0aFJvcFNQTjlvbWsw?=
 =?utf-8?B?MnMyTVZ4aFR0bVp4NHlIeVgvR1FINUJEbWVSYlBqV2FlQm93QndXelpHNUU4?=
 =?utf-8?B?ek1xMU5RTUdRYjlZUFlRd0tyMnNBd24zemlrdEtOaTVibldtZGlxQ203UlEy?=
 =?utf-8?B?bnBiR3ZHTzBoZFF1WExzS0FyR2RlYnZVQ0dRNjQyQlFFMGJ1dndPRVBMYkNT?=
 =?utf-8?B?a0xFMWZkT1hxWVR4ZUNpRmZpZGk4Vk9OUEp0K1daNzVsTUZrTGNTZUkzNWp2?=
 =?utf-8?B?alJaV2RoNS9wTm9WQmVmbUJBR004MTN4QU9mcnVTbDloTDVtb1g4Z0xoYnJO?=
 =?utf-8?B?Zm1uY3BxVCtJaTV6NHpvRTY1VTJKeXd2UUJES2wvTWdXMmRVbDkrOElHeFBR?=
 =?utf-8?B?bDJvRXc5U0NYN3FhOXVVTUo2SGlMVlI4ZHVOTzY0N01SUThuL2NGL0Vxcysw?=
 =?utf-8?B?YTd3R3IwQXZkMFVxdHE4cnBLdnVhMEFrdFhOTDdjbUhETDlUREI2TnB2MkFP?=
 =?utf-8?B?dU5jNDhCdUFNZzQvckFaRGszSDFIM2NEWnVqdzFlejVaQnl0VlIvQnlTZDB4?=
 =?utf-8?B?eTlzZ1o4OUl3Nmx3TElKOENtVTBhV2R5SEljQ09meS9ROHczOWRHS0hCcE5J?=
 =?utf-8?B?K2VIT2swUWIxbjVWanI0c3JELzZtRGNJL01kUkNQUnlKTExBQjlVVmdPQm4x?=
 =?utf-8?B?SDlvVFlRaEV2ZjRUTjA5KzRPK2k1S0xZR0dJenRmcVNYdnZ2dFJUa3pORGV2?=
 =?utf-8?B?UWNTRHpzVmdzeXlKdGgvRDMrMVA3cmZDRVhCY1haQ2c4REFpVkgzSTgzTGJI?=
 =?utf-8?B?cWh4TGh5WVNQMG9LYkdoaHFEN2lOMVRwVDhUaHgyemQ4MjdPUmxJTmRaYmVk?=
 =?utf-8?Q?UjH8f3ziDZ3Wl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFR0Z3BUUHRhcXBnTDkzcWExd3V5Wlh6azJ3ZTJScVZhV2hINFdmRDlWSEM3?=
 =?utf-8?B?eHJGRXh5UStlV0JTbHp2Y01lWm1LQlVvQkd2VStCQXYwYVM5VGxJMnE3TTVV?=
 =?utf-8?B?TWdsTzhVWUowWk1PeUZMMnY5TjQ5VFh0Q1RLUmpBbWJHa2RkdFZzOXN4aDZh?=
 =?utf-8?B?c1VyOFg1Z2FMTDJkN0lHT1JDRUM0c0R5ZFRNRzNjZC95bmJsNGFXQ0tEYkY4?=
 =?utf-8?B?TmEweWR5WEo1YjliSk9MSU4rejUxYi9PRXBRYWRWZTlPbTJMUXlBeUtUTHd4?=
 =?utf-8?B?OEFpd1BnZkdzU2Z3T3R3bytMTDNPYVM5SkoyK01yMG5jeGV5UFViQjFkbEZq?=
 =?utf-8?B?YWluTldsR2J3ZWc3bHhKRDkxUlBOTHJieDdYS20yUDBXNmhxblFSTkNFbUFK?=
 =?utf-8?B?TnRVc01pMjBlbzI1R29sdkY5TGkzZ0tKenFOOWtVdXgwUXVCSUNLL3NpbHRC?=
 =?utf-8?B?b3E5NGU1K0JJOWhVN0pXb1BWT3d2eVBJQnVvR3Z6L1JVUXg5S2E2QnFScUwx?=
 =?utf-8?B?MFBhVTNOODYrcTNWeVZoNjM1TVdVbjJUcUpwVFowRWZaV3NOWTZwZmhoMW5I?=
 =?utf-8?B?VFRuUnliVnlDbnAyL1BncFpRQWtHL29RcmU3RW5TclBhcGNOMmprbXUycDhm?=
 =?utf-8?B?SzYrYjVUYjA4VnNsSUlMaU9QRk1QNStUVFBOMnZkUTlIcEUrSE5BOWJsZjBG?=
 =?utf-8?B?QnNEc3A4Y285UndOaG5Bdi94RWt6SmEwYUE1T3NZZmMrcEpUUnhGL1d0NXdL?=
 =?utf-8?B?UGRONkhvZUwrTzVCQTlPZVlZWXYxOHBTcUl6bkxmOFlhUURCNWZYSWhMZURi?=
 =?utf-8?B?Tk9CMXJxNTJWWW8yemRqRzNVUTlLVi81bldXSzc5b1VnVFRQc2hkbE9sS1ZS?=
 =?utf-8?B?Q0srVnRSdUxmZ3hHS0gzZEtkbXZ1aE1pdXJienJZdGgxVGRiWlI5bWNzRmlM?=
 =?utf-8?B?VHBEVFBEZU9kUW0vcUVET29YVy8zTmg2TG9kVGUwZ3FQYXRrMGlSSndPR1lp?=
 =?utf-8?B?M1VydUdGRWlKeDdrT2txRDdGMGtZdEloSkNQclU2NHc5VDhQVG1IUVBzc0Fu?=
 =?utf-8?B?U0xBU3RyeVpNOE0xTDhUelZMdm5xZDVPSFR5MHY5ZFRCTTFTS0ZHSytjZHFz?=
 =?utf-8?B?dmx1UHIvbWlFUXRpSHYvVlUydVNvMzhXZ0Z1L0R1UCtwbGF0a1NoOXhWVVpR?=
 =?utf-8?B?WlZXZk1mandUQWFRaVlsTWFPMEdzQWFVYmRacFdtNVB6eFZLeWpCS25mRG1Q?=
 =?utf-8?B?VlAvclBpZDhQYjBhdDNTYk1ZRHZqSW9kR0x3dm5xVzkwZzlWVS9Od1ZZbFQ5?=
 =?utf-8?B?dm1wVGhZajJNMGJ6bVZEaVM5TkNRTTdLKzJYWVR0M2xLcTNrWkhLZXhOM2w3?=
 =?utf-8?B?QTFESDQxQWZqK25nVEhVZGhKcmQ3UC9qdTJYOWtWVC95WkQ5ME91NXZScUg0?=
 =?utf-8?B?VXM4MmJ2RGFvVlNLY0hjSy9NcUs1bGNaWHkvQVpHOTNuc3hORHRtWWNUQ1JU?=
 =?utf-8?B?S1dLYWZ0V3VHalR5b1JrSFJoY3RwWGlnNjFmc0d4WDJhanZPT0VFamZ6VWtL?=
 =?utf-8?B?KytjR3I0U1dVU29WYUo3YWpBVVo5cUdmRU4wUkdEMkxhVzlxWDd1NFNxb0Y5?=
 =?utf-8?B?Vzd6Vk9KMzVVNXBxR0lLZjNrN1FUckk1VmxrNEhRVE41cTA5TXF1NUMxbWNt?=
 =?utf-8?B?WWVoc2h3SDBPRHF3MisvU2pVb1hDNnhnUmtTa2psMzFRbDlGNkh3dVR4cEpw?=
 =?utf-8?B?eGRkNHRBRTFrMTMrL2lrbHJIbS9vU2tjMDArK21WRHdiaU1XNC9ka0ZIREor?=
 =?utf-8?B?N2FRb3VJcDVYMHUraTl1YXkrOHhTQmFFeWRGZ3Y5ZTlRWi9RUk53WWZJVFhw?=
 =?utf-8?B?S1Z5VThXb3MzZWt5Tk14a0RNeHRyWDdhZllsc1VGbGdJTkFzZVo0VGhyM1Jk?=
 =?utf-8?B?V1o5K1N2eE9oUVBtaG1La3BBZ0hza1AybWxLemZwWG1vc05SS2N2M3NUNVZL?=
 =?utf-8?B?TEk2Wis5ZHBjQi95UUVScU42UGFybHZGdFl5d21sNGlrYjF0WE9CZ0RTTk5U?=
 =?utf-8?B?VlVuQm9JR00vbElTdTVpS1FQMGhoRFY5REx1Wkk3ZzdNK0FHbGFkeEZjMlhP?=
 =?utf-8?B?Kzhkb1I3QkIzZDIweHhEQjMza1dDLzdsVkVIb2JRbmlyYkE0cDNXc3JnQktY?=
 =?utf-8?Q?KjSRLmdcnQZ0P9mw2lJfqk8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D641DA18A373B442A7415C4DEF122256@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a25d6d-50b2-40c7-b0a0-08dd3972f022
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 16:53:17.4080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U9CsoH08mqHowYY/2U/TZuGWCc4xU0X1eFiXgFmtzWec49f0BzlfkN7LSqbDtLZ0ajvtRsCHMD1+gMRl4m7qjBGeqlvPHg+xDZz77BGthq67VC1Cl9qn2faxPLhR8+FK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB10217
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

SGksDQoNCk9uIDIwLzAxLzIwMjUgMTc6MzgsIFpoYW8gTGl1IHdyb3RlOg0KPiBDYXV0aW9uOiBF
eHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVu
bGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IEhpIFBldGVyLA0KPg0KPj4+ICAgICAgIC8qDQo+
Pj4gICAgICAgICogUElEIChQQ0kgUEFTSUQpIHN1cHBvcnQ6IExpbWl0ZWQgdG8gOCBiaXRzIHBy
b2Nlc3MgaWRlbnRpZmllci4NCj4+PiAgICAgICAgKi8NCj4+PiAtICAgIHVuc2lnbmVkIGludCBw
aWQ6ODsNCj4+PiAtfSBNZW1UeEF0dHJzOw0KPj4+ICsgICAgdWludDhfdCBwaWQ7DQo+Pj4gKw0K
Pj4+ICsgICAgLyogUmVxdWVzdGVyIElEIChmb3IgTVNJIGZvciBleGFtcGxlKSAqLw0KPj4+ICsg
ICAgdWludDE2X3QgcmVxdWVzdGVyX2lkOw0KPj4+ICt9IFFFTVVfUEFDS0VEIE1lbVR4QXR0cnM7
DQo+Pg0KPj4gSWYgd2UgcHVsbCB0aGUgcmVxdWVzdGVyX2lkIHVwIHRvIHRoZSB0b3Agb2YgdGhl
IHN0cnVjdA0KPj4gd2UgZG9uJ3QgbmVlZCB0aGUgUUVNVV9QQUNLRUQsIEkgdGhpbms/IChZb3Ug
Z2V0IHdvcnNlIGNvZGVnZW4NCj4+IG9uIHNvbWUgcGxhdGZvcm1zIGlmIHlvdSB1c2UgJ3BhY2tl
ZCcgd2hlbiB5b3UgZG9uJ3QgbmVlZCB0by4pDQo+DQo+IFllcyEgSSBhZ3JlZS4NCj4NCj4+IEl0
IHdvdWxkIGJlIGdvb2QgdG8gbm90ZSBpbiB0aGUgY29tbWl0IG1lc3NhZ2U6DQo+PiAoMSkgdGhh
dCB0aGlzIGRvZXNuJ3QgY2hhbmdlIHRoZSBzaXplIG9mIE1lbVR4QXR0cnMsDQo+PiB3aGljaCBp
cyBpbXBvcnRhbnQgYmVjYXVzZSB3ZSBwYXNzIGl0IGFyb3VuZCBkaXJlY3RseSwNCj4+IG5vdCB2
aWEgYSBwb2ludGVyIChvciBkb2VzIGl0IHJhaXNlIGl0IGZyb20gNCB0byA4IGJ5dGVzPykNCj4N
Cj4gTWVtVHhBdHRycyBpcyByYWlzZWQgdG8gOCBieXRlcyAoeWVzLCBJIHNob3VsZCBtZW50aW9u
IHRoaXMpLg0KPg0KPj4gKDIpIHRoYXQgaXQgZG9lcyBtZWFuIHdlIGhhdmUgbm8gc3BhcmUgc3Bh
Y2UgaW4gdGhlDQo+PiBzdHJ1Y3QgZm9yIG5ldyBmaWVsZHMgd2l0aG91dCBtb3ZpbmcgYmV5b25k
IDggYnl0ZXMuDQo+DQo+IFRoYW5rcyBmb3IgdGhlIHJlbWluZGVyLCB5ZXMgaXQgaXMgY3VycmVu
dGx5IGZ1bGwuIEkgZm91bmQgSSBtaXNzZWQNCj4gYSBjb21tbmV0IGZyb20gUGFvbG8gWypdLCB0
aGF0IGhlIHN1Z2dlc3RlZCBvbmx5IGNvbnZlcnQgYHVuc3BlY2lmaWVkYA0KPiB0byBhIGJvb2wu
IE15IGJhZCA6LSgNCj4NCj4gSXQgc3RpbGwgcmFpc2VzIHRoZSBzaXplIHRvIDggYnl0ZXMgYnV0
IHNhdmVzIHNwYXJlIHNwYWNlLCBsaWtlOg0KPg0KPiB0eXBlZGVmIHN0cnVjdCBNZW1UeEF0dHJz
IHsNCj4gICAgICB1bnNpZ25lZCBpbnQgc2VjdXJlOjE7DQo+ICAgICAgdW5zaWduZWQgaW50IHNw
YWNlOjI7DQo+ICAgICAgdW5zaWduZWQgaW50IHVzZXI6MTsNCj4gICAgICB1bnNpZ25lZCBpbnQg
bWVtb3J5OjE7DQo+ICAgICAgdW5zaWduZWQgaW50IHJlcXVlc3Rlcl9pZDoxNjsNCj4gICAgICB1
bnNpZ25lZCBpbnQgcGlkOjg7DQo+ICAgICAgYm9vbCB1bnNwZWNpZmllZDsNCj4gICAgICB1aW50
OF90IF9yZXNlcnZlZDE7DQo+ICAgICAgdWludDE2X3QgX3Jlc2VydmVkMjsNCj4gfSBNZW1UeEF0
dHJzOw0KDQpEb24ndCB5b3UgdGhpbmsgdGhpcyB3aWxsIGJlIGFuIGlzc3VlIGFzIHNvbWUgZGV2
aWNlcyB3aWxsIG5lZWQgdG8NCnN1cHBvcnQgbW9yZSB0aGFuIDI1NiBQSUQvUEFTSUQ/IFRoZSBQ
Q0llIHNwZWMgYWxsb3dzIHVzaW5nIHVwIHRvIDIwIGJpdHMuDQoNCj4NCj4gU2ltaWxhciB0byB5
b3VyIGNvbW1lbnQgYWJvdmUsIHRvIGdldCBwYWtjZWQgc3RydWN0dXJlLCBJIHRoaW5rIEkgbmVl
ZA0KPiBwdXNoIGB1bnNwZWNpZmllZGAgZmllbGQgZG93biB0byBvdGhlciBiaXQgZmllbGRzLg0K
Pg0KPiBUaGUgcnVzdCBzaWRlIHdvdWxkIHJlcXVpcmUgZXh0cmEgd29yayB0byBaRVJPIHRoZSBv
dGhlciBiaXQgZmllbGRzDQo+IHRob3VnaC4gSSdsbCBnbyBiYWNrIHRvIHRoYXQgbWFpbCB0aHJl
YWQgYW5kIGRpc2N1c3MgdGhlIGRldGFpbHMgYWdhaW4uDQo+DQo+IFsqXTogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI0MTIwNTA2MDcxNC4yNTYyNzAtMS16aGFvMS5saXVA
aW50ZWwuY29tL1QvI204YjA1ODc0ZDYzMGUzZWM4ODM0NjE3YmFiYjk3YjMyZWMzYjM5ZmNlDQo+
DQo+PiBJbiBwYXJ0aWN1bGFyIHdlJ3JlIHRhbGtpbmcgYWJvdXQgbWF5YmUgYWRkaW5nIGENCj4+
ICJkZWJ1ZyIgYXR0cmlidXRlOyBzbyB0aGlzIGlzIGFuIHVuZm9ydHVuYXRlIHJlZmFjdG9yaW5n
DQo+PiBmcm9tIHRoYXQgcG9pbnQgb2Ygdmlldy4NCj4NCj4gVGhhbmsgeW91IGZvciB5b3VyIGNv
bW1lbnQuIEluIHYyLCBJIHdpbGwgdHJ5IGNvbnZlcnRpbmcgb25seQ0KPiBgdW5zcGVjaWZpZWRg
IHRvIGEgYm9vbC4gV2lsbCB0aGF0IG1lZXQgeW91ciBleHBlY3RhdGlvbnM/DQo+DQo+IFJlZ2Fy
ZHMsDQo+IFpoYW8NCj4NCj4NCg0KVGhhbmtzDQpjbWQNCg==

