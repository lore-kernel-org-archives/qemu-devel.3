Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C58CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 07:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLFk1-0003G7-IB; Fri, 08 May 2026 03:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1wLFjy-0003Fg-6m; Fri, 08 May 2026 03:35:18 -0400
Received: from mail-japaneastazon11010065.outbound.protection.outlook.com
 ([52.101.229.65] helo=TY3P286CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1wLFjw-0005iW-I4; Fri, 08 May 2026 03:35:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfhJDozN+MXV7cpfrh9nx/K0FoU+RYKNIqQItTEGpP1zQrKNbE2d9VmaU1zdIMYkdJ9JF4RLs2+vzcxCr8OreaZwF6sTHPCMvUWPVrXsMCCPXZj9g9sTElHQfpgxrNb5wI9+EOc7dEN6Y/bZVLYCnpZYqNoHmTVCD1FawIvfcjUMxiCzOoeCuhmStV0UtmA8e5r3pTlQcJL4meVnbj/NFItqOB82nG2JGH3SormIstlBG8NgsBx8WY0vjoQ8fRU+zGS6SjdHOQvXK5UzwdebBBBeUpsLYcrQJvAoPEXhuQe18ZqgTOW522cl2kuPXt8q/AERaHz2/F5W9CVUR72m5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4G4YHRETMO+bNqI7UrkWxq9c7oor+C4LI8oMsi+Wuo=;
 b=tvcW06aYyc3BC5W9fWrKm67c6rAlI92Dy5tu1xdVvRnGXS1YUFSZ/wJA9QNmPk79kUbgV3IDlCFFl4m4T411AlFML8WWwI3+DEqruBt4Su8tmnJHjRnlXI+lyGDecRKtPUlIdkAoNv080+cWgUz3VVAOu1LTM4IPHPHWTR1xHS213vIY25xR1QtabOU19j8zUKOuukBHGxXzmkx11ghowM/YzsJLPDDm/TVvHnowvKELrsd94iJNoLADO+hgyZSotO9xhPmVYQ+flBOWTSypl11Xr2/rZwDlXkMtzlLlZrR+c2ugks7hLTT17vJAmQa1T5JxKvvRkYGm9zrWzjo78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4G4YHRETMO+bNqI7UrkWxq9c7oor+C4LI8oMsi+Wuo=;
 b=YTqCmMGYmmobmQbzkQ6zeDoDt8CD+uCWClLIWyxAsEVlchiRKcbdUDfAsaJgHU4ddAmqFigiver/eQVEfJRr+LR0kOZZ06XqwEWoO3Fm6adBONhXaCtr8TsxUHZ3i9gwqXU62nHyG/mN2JNdXFLqw848rdRXJqwlfNwY96YZArzrp9B9cROqfOCITtUPI/7iHFMWvHViSl/7V1srYFmVUrZPYcUNK+9r8aqoMHCFWr1kK1qw2necEWDTml4Q+e4W89l/iOoGQfmN8Fxlitge5697DDjhlTloQ0ZMpQ73eSEQhQWsckwagfEvs9aUiMVb+0nLUDtPCZNeoVJxcdUB3Q==
Received: from TYRPR01MB13806.jpnprd01.prod.outlook.com
 (2603:1096:405:218::10) by OSZPR01MB8354.jpnprd01.prod.outlook.com
 (2603:1096:604:16f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:30:07 +0000
Received: from TYRPR01MB13806.jpnprd01.prod.outlook.com
 ([fe80::ab07:de7b:8259:7c17]) by TYRPR01MB13806.jpnprd01.prod.outlook.com
 ([fe80::ab07:de7b:8259:7c17%4]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 07:30:07 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "integration@gluster.org"
 <integration@gluster.org>, Zhao Liu <zhao1.liu@intel.com>, Yoshinori Sato
 <yoshinori.sato@nifty.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Milan Zamazal
 <mzamazal@redhat.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Mark Kanda <mark.kanda@oracle.com>, Glenn Miles <milesg@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>, Ben
 Chaney <bchaney@akamai.com>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
Thread-Topic: MAINTAINERS entries that aren't S: Orphan but maybe should be
Thread-Index: AQHc3VAteipPymrKEkeelZx+AN2lBLYBAROAgAK9R4A=
Date: Fri, 8 May 2026 07:30:07 +0000
Message-ID: <5326b854-fcea-4af6-a479-792888a94a4d@fujitsu.com>
References: <87y0hwbvbp.fsf@pond.sub.org> <aftEt2S-Oxq93b_s@x1.local>
In-Reply-To: <aftEt2S-Oxq93b_s@x1.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB13806:EE_|OSZPR01MB8354:EE_
x-ms-office365-filtering-correlation-id: fa8ab853-41db-43b9-55da-08deacd3a13a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|1580799027|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: cMlrwG71QjBKPxQRMnexFSKYxXkBiOV5vMUz0BK5hhbzei7PsJqbIcLz+0lLdQpzLE4sptmwq5qHSaqGRjiy2kLyo6y4wjb9hAPSLHoHxh9QLtwqUhnA34rvjgyx4cXHoOhif+rZZDClP+YZjI2t5b0+QMWYd2H6d8yGHi/gYAi/TbE+O2TxEUDRPHo4K3dDfs91tbDkuoAYJW5wa8nD0muLvg3kFUAebQe4aJ7gh58MbHO+ufw59R/bFHzExOHynvF+YyJRBAfnX/q1l+cHyymTw8K8M0LZgc8NUj5plHiwUfK9y+i8TKExHOfPa95D1IJSmCSvZ0cMgsHkRZdqnXaRMr3Qmp4P+B2T70G45M0DRbMh4/sBjJuOwh1t8lHkKPl02eQ7eYU3A6r0WFWfL6U6OMUFoYMVzUJw1ahCo8UB+4kSHB6KyKww4lPJ2CUmfKDm+BGRk3MOruS9hZM4WtKv2gMM+z4nirC6an9aiONum7o4JLx6rjs7HyEtdslpCB7ako5hLvHf4NHQV5sJ6C0x9REQ54bAatuwSY5cGU3+53RwW7e5XKYALyNmn8rCg3kSLv7GxDWhLVBgFTUYGNkty3WPgle6A2s9Q76KR0Pa3fPLZyWCJYgU1gzxG4N8gPXZH67DQQ7fquUCqNCTN8qFRDDrWc6wHed+zACjs4qBb8Y8j6AWyq3SqVf0Wx4T9KObRJfuNK8lQVpR8ZuTDGKtIsEWTd5/xHKSV6nfhMBArL3qEpSEwk3j1SsduE8y8ruBrNqg3CWntZ2UEfh/KA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYRPR01MB13806.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(1580799027)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUI3U1p1NEZBc0NHVnVsaS9BSU83S3RYSWtFZ0ZpRTgrTlFOQ3dtOUtDcDUy?=
 =?utf-8?B?OWlNUVg1bHRzeEFIaUl0eGJNTmVsQTFINnZhYmdEMklWMUh2VkcxU0RSVG03?=
 =?utf-8?B?Mkg0ZVdQbHdnUXp6SUROUStHQzlZUXNjRWR4Y0xYM3lTdG91eVUyalpUL0x4?=
 =?utf-8?B?N1ZBUkhWbTc4Z2ZGRm4zWGRaTW9TYnArUTJmSHQ2dUNYVWZtZHRCYk43WCtT?=
 =?utf-8?B?NFlIS1Q4WVlYQVoxOXFsOU1WTFRqMFMzS3FCOHFVekZNNjQ3bWZIRjZld1NV?=
 =?utf-8?B?R25jNlNZakMyelZKY2E1Z3g5SWxWSC9jQmtiemhJeDlvZ3hLcktCWWFqWnZM?=
 =?utf-8?B?MEpLbG5mc2RyRlBpWXREUlRKcjdsREtITzM2RGhTSHB4dTVua0o4TzRNTWVx?=
 =?utf-8?B?THJ3cFo3bDdaSjJtbWpDZFVGK2NXMkJhWm4weWVoQ0F2NllNS0RPRTVoMGZt?=
 =?utf-8?B?QisyZUlUUXIvSHFFKzl1QjlHZnh1QlhPOCtoaEpSYThjQ09IZmt3MEcydWZL?=
 =?utf-8?B?YTE4blpYc0pwaDhMODl4enN2ODVXVXpHTlhrUi9UQi9sbnRieG9GNUp0SXd3?=
 =?utf-8?B?QUNkNFRZdmdnTDRxWm1TZ05zdEQwVy9Cd295V24zTTQxcGlOaHFEK1BvK3Yw?=
 =?utf-8?B?Q3c4VmtvSGpudDZXS2lvMXFZS2NzdiswUUlVTEJtaDlZUlFvRngyY0tYUHhw?=
 =?utf-8?B?OENDZjdhMkd3dTdrWm1PclF3OEp0THczOVppb2NLaUtHazZrMzVCd0dXbkxj?=
 =?utf-8?B?VHIwZ1duQnhJQjdRa3dXWmFSLy9yM2Uvcnp3Z0VoOWNvSlFRUHR6UXRyRHNL?=
 =?utf-8?B?OXk0M3dRS21vL3NvdGNhQ3MxRmorazZ3dWhXbUwyNFowYUszMWZYcnRzUC9T?=
 =?utf-8?B?WTg1WjFaRFlNb3U5SFpLaUZwKy9QVm9GUEhhOWxBTWFFMVNZdUtuN3NpUmVU?=
 =?utf-8?B?R3JGUFNaNXM3aWpzOHlwVVkzNk40Vm9YL2lFY21ORUxtLzhwekU1Nm9tanUz?=
 =?utf-8?B?V2hTZnJsVDNzYTlha3hPbi9Vb1dZckh3RTNBaVFsa1BuQXExR21rRXBzL21L?=
 =?utf-8?B?MTh1eUlrY0theUYyeEtXNE5yRTFDL2NJNUxBb1YvbXVldHBMbmpJZWp4M0JH?=
 =?utf-8?B?MHlEQ0wyQjlRcXRISDJ4OUVTcUxFU2JkeUtEMURFY09RenI2cHkxSVF5cFVR?=
 =?utf-8?B?am5vNUZGc3JJTkF1UXBscFY4SkRLNEtPaGVPbTRGMjZoWmZWc24rL0lYU0Ra?=
 =?utf-8?B?TE1FRXk4T1publk5SVBNdTlmc0s1OHYwQTFWU1ZNTHJEQ1gyTFhFTVNKSHQw?=
 =?utf-8?B?ME1OengxVUtrK1BLc0pnejJFWkcxUzhqZGdxWlRmU0ZyMnc0a0hKYkR3QWpy?=
 =?utf-8?B?eVo5UDVja1hWNnlGQjlpN0RySHpZRlFvTUdpRktRWEp6Y3N1RHBjRWxUZEpI?=
 =?utf-8?B?N055cmdrdkZUWVZuUHM3dVpFdVhabXIrUXhwTWNmNSttaFVwTTgzSXIxMWlk?=
 =?utf-8?B?MUpISlhOZW84SHM0Y2p1ZTg0eHpEK2tucDhiZlIxaitURVViOWkxZHEzMnox?=
 =?utf-8?B?cTdGRzFPMHJHOGdxcENyVmxRNVlqVWlqMHhxZTVBN2RFeTVoYXV2WjZDa09C?=
 =?utf-8?B?TzlqRTVkYjFLU1BFYStuUmFSbFFaMkdoY3pwWXV2cVJwSHdWSW5ISVNQTE8z?=
 =?utf-8?B?U0dScU4yT3hHMXAxQUNJb3NZeXZRUFJxdi8vdE1wSkVoR1dXTVRVVGlOaTlV?=
 =?utf-8?B?cTF4eE1xcTVXMDNLYVYyZGRKdFh4WWRlaU1TTWIwbkVXQTdnaXY1Y3pMY3ln?=
 =?utf-8?B?Yll4OGZaSXVBUE1odTg4V0RabXVFTnFiVmlUcHlHTHJDY0lMbi8vQnFtZ1Qy?=
 =?utf-8?B?Z29CajNMVUE4b0NrZmluWmFMVS9WZHFOLzc3OGhhdjJKdlNxeUpENjZtUVps?=
 =?utf-8?B?TEcrcmlGSExWUEJIdEcxZXdIdHpLd3k5QUtuRTAzdkUvLzcwc0dLMnVaQ09J?=
 =?utf-8?B?M3Vya0dMbzJHcDgzUXQ1RWE3Wnkzai96cVg3Rk9aNzJMckZQRFByVHhKQ2Vx?=
 =?utf-8?B?K0pDaVNRMmNyTThWK2NidnptMUxxcHRTYThXcGdFTWNpaThxdnJhaWdxVE9N?=
 =?utf-8?B?R1hrSnRObFdhZXluTXFZMXVoRTloVVVqb0R2SmlFOUpnMWR1ZEI4NVcxa3BE?=
 =?utf-8?B?Q3lpcDdVVnBzNHlyR1gvTTdJbTZoZ0ExZ0kxRi9IVERNZHJETDNTMllvK2FU?=
 =?utf-8?B?ZVhLV1h0dU1Dekd5eDFNUnU2MGlkZ2N2U0V6SUZrU3RTNlpPNG5FbXZPRjVx?=
 =?utf-8?B?aWFMRzFzYy80cWNNVDlNMlNWY0J2Si9LL0NwazYvMEtOTE9kOTZIQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A218405ED80E84E8EF530E49B562614@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YdNd51YHzSkZ1tjW/A+oeQs4xdHNuKfeIbOKYTFJxlRcDsDWbXedJjWp0Jy3+xKP9qoI9hYavUXGhB8K9d/uGXQ5pq2vlQ+RznYghDuxJbqEHThYUPh3pjH9MkGygR1bgB7k8lOBqWXRTpbG++wJ+BSvP7JjwknK3qrUVmy/kzaMqsMhioYDmHXQqNPO5sGjRDGJk/7kD3eAX9pndEOZSidJbFbYx+MjRnUto5Z6Lk3h7xNrGnCcaiD/6+WLepofLt9NFyHHnjcOooMAmpn/EZ4cwPBTb4LB6Kvv6DKBczQF0y4JEM/9knf8LiyXGffjOt8FOaX76MN2aE31WR+ZPA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13806.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8ab853-41db-43b9-55da-08deacd3a13a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 07:30:07.6141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9LBPfbWT/77Z2LlQGpkuKwLuMq2/j7kqnwKiu+Q6gf3C6Eo2elIkXwoG43g5SQz8beC9dNFrWayNjO30MvSwcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8354
Received-SPF: pass client-ip=52.101.229.65; envelope-from=lizhijian@fujitsu.com;
 helo=TY3P286CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

DQoNCk9uIDA2LzA1LzIwMjYgMjE6NDAsIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBXZWQsIE1heSAw
NiwgMjAyNiBhdCAwMjowMTo0NlBNICswMjAwLCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4+
ICAgICAgTUFJTlRBSU5FUlM6Mzc0NjogUkRNQSBNaWdyYXRpb24NCj4+ICAgICAgUjogTGkgWmhp
amlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4gICAgICBSOiBQZXRlciBYdSA8cGV0ZXJ4
QHJlZGhhdC5jb20+DQo+PiAgICAgIFM6IE9kZCBGaXhlcw0KPiANCj4gRm9yIHRoaXMgb25lLCAi
T2RkIEZpeGVzIiBzaG91bGQgc3RpbGwgYmUgcHJvcGVyLiBJbml0aWFsbHksIEp1YW4gd2FzIHRo
ZQ0KPiBNOiBsaXN0ZWQgYW5kIGl0IHdhcyBnb25lIG9ubHkgYmVjYXVzZSBKdWFuJ3MgbGVmdC4u
DQo+IA0KPiBaaGlqaWFuLCBkbyB5b3Ugd2FudCB0byBiZSBNOiBoZXJlPyAgSSB0aGluayB5b3Un
cmUgdGhlIG1vc3Qgc3VpdGFibGUuDQoNCg0KVGhhbmtzIGZvciBvZmZlcmluZywgUGV0ZXIuIEkn
ZCBwcmVmZXIgbm90IHRvIGJlIHRoZSBtYWludGFpbmVyLCBidXQgSSdtIGhhcHB5IHRvDQpjb250
aW51ZSByZXZpZXdpbmcgcGF0Y2hlcy4NCg0KDQo+IE90aGVyd2lzZSBJIGNhbiBzd2l0Y2ggdG8g
TTosIGp1c3QgdG8gc2F5IEknbSBzdGlsbCBjb2xsZWN0aW5nIHBhdGNoZXMuDQo+IA0KDQoNCkl0
IHdvdWxkIGJlIGdyZWF0IGlmIHlvdSBjb3VsZCB0YWtlIHRoZSBNOiByb2xlIDopDQoNCg0KVGhh
bmtzDQpaaGlqaWFu

