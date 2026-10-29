Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC62606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=dby78CS1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMJhp-0005Pf-0s; Thu, 29 Oct 2026 02:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMJhk-0005PH-Qy; Thu, 29 Oct 2026 02:33:40 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMJhi-0004ju-Ju; Thu, 29 Oct 2026 02:33:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJvbWe3PprFTYp8gDVk4cAle1IiMgtZou+BGklpbwyRaFcey11JsBJtpEaDqjw1knGA7n7znh9hV+61weTMHoyj5VmyllzAXsGd+vYXACKVhqu9uvpjcgf7MM9O4OyrwnjoVO945FXYt0FlNf+oXpmMwfPvCFsf42TohDUOhNj0YpPIE51vyooov81r2FTglpSe5FKP7R4puiP//IulMCx1lYuHgHh8DmBJagAwlE8ZdZkV66zALFI1KZTBTE0/nJKdyUzOfVQvOy1CRmQqt8qAcndNK5lAKsdqlGz1Vz4zj3nqcBZgHX5qvW8/PC+PhQ2zMolLKEE3GI4Pao2IZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfYAK+0Lt0zDBc+o1QJBPOg0jbY4SaBxanFgT/caDy8=;
 b=F7Qs/7zsgKEoWWw6CiKE+UKMmouV80TAeTuq1MAIW5G1TZrPvatJhKpL3UKr2ZPm6nk5JGkiM858S0D91hBkfXNApPlAA6zzpEdrCoNAdXpfy9UVibzrbXXuakgp0bhwv0jmjMfcAouqonFVzGJmiAsXfap2XPlvCrhTvWQDhazOArpKZl0OYeEGx8MGXnT8t5HPq6d3dSaGEX6l3v4hw+iXWz/ZnYeal1fC/Bfz8bxtdR0w6aw4IeanwCA0tmcbHVqLdU97koZs5829Ni1rAlFNRU1BqEGCEh0SIKxSvm/XGfHsJ0TnkCK2EOrxP1hrMp277jy59dX3HIewFpa97A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfYAK+0Lt0zDBc+o1QJBPOg0jbY4SaBxanFgT/caDy8=;
 b=dby78CS1Qx0SXAsPp0R5jn/b8A9pfCd4cyemFB2nt1BspJzmH+5gFKgd7WP2tWb8p99Wri1zC8GcH4rlRCdfOe/wxRe3fUadRLU+gngQbwBQ7b6k/L5FV5yUOOCz4AZIhvWIvnBANdnb4/4HAp86Pe4e0UcELXKf/Ugadv8qoTBjKmV0iVtXbe5UEOYgV5RiGue7/e6wHnlKp9YFV/jpRmbhKJNJeCe8fGobPHJRj6v4XhUEHtkVCcQ2BQKIMRO9koCe3tjHYAiP8vf9WQkZc4UCmS0R834O/AZ2/mZSlaQKFyquwH1OVpsPVyHUHAIiAmAx+Q1MtWDhgY2+fPzaeg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by OSNPR06MB9213.apcprd06.prod.outlook.com (2603:1096:604:494::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 06:33:31 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 06:33:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Timur Maksimov <gessingate@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: RE: [PATCH v2 4/6] hw/i2c/aspeed: fix buffer transfer in non-packet
 mode
Thread-Topic: [PATCH v2 4/6] hw/i2c/aspeed: fix buffer transfer in non-packet
 mode
Thread-Index: AQHdZky2/95pPIU7nkuaAUSRDZXVPLcUD8NA
Date: Thu, 29 Oct 2026 06:33:31 +0000
Message-ID: <SEZPR06MB736293095EFE3149F167A71DFC6E2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
 <20261027-aspeed-i2c-nonpkt-fix-v2-4-07deed1dff60@gmail.com>
In-Reply-To: <20261027-aspeed-i2c-nonpkt-fix-v2-4-07deed1dff60@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|OSNPR06MB9213:EE_
x-ms-office365-filtering-correlation-id: 3159cc8f-6598-4ce2-89ce-08df35868cce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|22082099003|18002099003|261028144727099003|56012099006|4143699003|261022105027099003|261026140227099003|261021121427099003|261021123027099003|10067099003|261022075727099003|261009223027099003|261009221227099003|38070700021;
x-microsoft-antispam-message-info: 8pYHJWzlSbtlRux9LC85xmAavngG4LwV5KYr0aof+MlbM/x+jpKgxWfwgmzrcZV3pd1jCcqT12wdnqVHYuDSBIWrHBpTHkSsW9+kTGUHFJmBAbifxAs9KbYX/Ad0CXgIxZ3YvTAlLg2TdEKKC6J+XI8+b0VDV3IWTB5DQ9Py42Vi6h8h3TRC04FxjvIdGwL+X2a/IZFA0vs/ikqFzc1/EHUdbIgW5Yu6qsaP7oXeVt3r/6FdjybYDCH7d1PA5Qplwg5U+ruC2uJfnVY+l8BcBZebWB1RqqZGpxAGN2mruCF8vSvQjgaCv8VE4jHK2XxF0z+dgoeCglEzNwvWfRiV+XsgSy8MIR//5OjMdDgcfxTSZBURz+9r3T0MJpaXU05BInUx5PvNSR+/1A9fsIFRPzRGLV5l0nziyKakaw4ualpfsnIscX8MKugWx0T95cDseFlv5gDk7Gwy+dUR7iwaxkwwl34Hb8tru1S8NYZBXWfSyG3nypPrhcvnbUvOR+oUmVqO7wfFyraWG4IC1jl9QlVJhLbVIR9hLyexCR55MSu0UTQ4KTm1wFTQ6XpSGL6MiTKzTRRXUwBizpaz2ogk7Kav93KdmRrUOaeoOk0ihoJJMb6i3f3xP1QsRjDJDK7+OfP50pjBOhChVk234yQlG37R1ORUKQykOqVOv5nTIDf30V/XCPT6/IDp8CwHgKWrMTgpGgIgaLk9MHzNFzQfy9tbVnlzYLHINwv1vuLuyvM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(261028144727099003)(56012099006)(4143699003)(261022105027099003)(261026140227099003)(261021121427099003)(261021123027099003)(10067099003)(261022075727099003)(261009223027099003)(261009221227099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajhybXNEc0R0cVFoc2NmdndIbllxdjQvVE5PTit4ejVGK2VRTHV5Wk0weGl2?=
 =?utf-8?B?OEQwdWVwMU9NN2hqUTZReHczY0dVYVZkWWZPa2lTcVB0NnJ2YjVpK04vWVFp?=
 =?utf-8?B?dUkvV1pNQkZwVStrTFBxYnV0SnVEdHJ6eTJVc2wydm5zN2ZFT3ZrQ25lVllF?=
 =?utf-8?B?dlluSW9OaVRnV3BkZmJTOXArSnlEYXo1Si8vRWJhbFQ1Q0VXYWUzN040Nm1H?=
 =?utf-8?B?THRrNDhycVF4RjlvakNqdTlxemZJNEZWU2RoN0xBQ0FZQ3J4K3ZWSFQvYWht?=
 =?utf-8?B?MDVNNVFDUGNRSmZKQUVScWNvSUUwVTJ0SE1EUjBLNkdqbklramFPcEM5QVYw?=
 =?utf-8?B?Nk9ZN3E5amxKSWZ5c25wWjBOWkdWbi9wV2sxMHpQT2VwZ1I4ajFRSUxSdTFs?=
 =?utf-8?B?V1hJNTg2ajVnSFd2clJYQ01iUHNPUzhNVC9BMjcvRW1Neng4SjkzdzByWlVC?=
 =?utf-8?B?L2VhWlBRc0FVTVFpV0NuNG1nOEJZRlJZd2c3VTJ1OHh1RkVDQWVJSEtvZlJP?=
 =?utf-8?B?YzR2V1dNTHNneWFNWmQ0ZDVITERLWDl3NFkwSWNxRWtxa3JjZnhHRm1oN1hv?=
 =?utf-8?B?Vm9kaU45Q0xGZDErUUsxRGQzeUxJTE1NZWN5a1BCdlpKRVpJcWtXcXllR0Fn?=
 =?utf-8?B?eEhFQUdTaUtnODF2OW96S3QrSTFnVWdWMjV2em5oMlV4eVB0b092N1N6S1U1?=
 =?utf-8?B?djgzaEI1NzBuK2k3NXFoY3lKaXRBZEk3MTR3Y3pld1dxb3BvZS9WWHdsb1VO?=
 =?utf-8?B?bWpoQzlqSHdVcXZ2QjU2TjIrQ0NNQ3BOSFlCU2ZsSmR5bC9SditJNklaWEdz?=
 =?utf-8?B?ejNWSTZIQ2FUVHRCNisvRFNLNFFrMEVqWXorZlRXSExtQm4rem9ub3ZqRzlM?=
 =?utf-8?B?QTY5YmdjM05Ybnp3eXZ1Y2VQY0VNcnZvR281Nms0eTJ1YkkwYlowYWRIZVp4?=
 =?utf-8?B?ZHY0V1FmUFFEU24xWWxGU1lQaWkvMEZzS2FaRFFQbFdoT2RQOUJEV1hsN2Fp?=
 =?utf-8?B?K2JzMlZEbm5pZi91MnVxN0VJMm1nYWp1cUR3ZXpzSHpjT2VxK1QwVmU3alhV?=
 =?utf-8?B?R1M4dmFuOGFtUVdtQlpneUcycFpnRkVzcDF1Z2poWUdJM0V5RWhxRTRjUEo5?=
 =?utf-8?B?YWdGKzgyVVRRVXM2ZGRESFNYT0cvcTkwdVpVWFEzVmVJZjkxbkhGTlpaYkI1?=
 =?utf-8?B?YmllSnExbjFjNUkvaUthZVVVMUF3SktoZTR2RE5FVWNBM1owSGJrNXpwVUVh?=
 =?utf-8?B?SnB5ZC9OWk0zTVdOOFUybnE0RktvNWlldzArTWd5RVJ5R0QveHVIOUUvL3VQ?=
 =?utf-8?B?R29TT3A4VUd3L3BIcEk2aW9lTXIyQTlBOVZVR3l5Unh2LzhuUUM3K2J3MEsr?=
 =?utf-8?B?OVdJdG1OWGlZbm5FM1hvcnhoeEh0N0Q5Y0JBTlZLanNFTGVoU3BYQ1FKTmZ6?=
 =?utf-8?B?VEcraG51ejdTZWRQUTljNzZISDMzQndwUjFTRmxDY3F2bEVGd1V5dW9HQXI0?=
 =?utf-8?B?a1Y1UXEzaDJFblVXREJCbWtGVW9SOGdlWnlrQ09KWUlscHo4TEtibm5VcGtv?=
 =?utf-8?B?Y1NuQlU1TXV5alBFRzhEVXd1bkF6VHlGZFRiV3lIanpnY0tNV0VzakU5dUtj?=
 =?utf-8?B?TWVMejRsWmlpYWEwQXg1YmNtZ0VXSXNmUEhCWWdVVnAzNDJ3NGJkS05ibDhS?=
 =?utf-8?B?d01Za0xFajQyOXhXdDk4VHh3NUUyVEVtS0x5T1ZhOERNNm9scUxQLytvOXVn?=
 =?utf-8?B?RjRSMnlXb0JZNFdHVVZCMURONHdvRXVmLzZaM3BrY0FTbHp0azRWY0FaWHFL?=
 =?utf-8?B?KysvRHg5NUllZ0hCL0d2dWRRUmx4SmdIekRQdEtXSEZ3dGFXQTZ4TFpoKzVJ?=
 =?utf-8?B?dUNDSnV2aHh6c21WSmVSeHRiZkJPOGVnTTJWU2h2Ykc4bWNsODMxU3Z0SUly?=
 =?utf-8?B?YUxWZ3I5YkJ5STVLeVdnNE5kWC9Gdjk5NmFOWjF3MExxZ3BCbUJNRzQ0OERx?=
 =?utf-8?B?b2FweDRaQk9YZnVVdXNIMDhlaDI3SmpWQnVmakVNNU5PTFQ2eS9YN3F5czlD?=
 =?utf-8?B?TlZvaTdKSGRLSzdtekxvSTExbjhxMWd3a0RYbVZIMGhjL1Y1dWJOTjRna21B?=
 =?utf-8?B?aDRrY0N6RytSWFJzazZzS1hFR0dvUDBGODFuNXFSQjB6SFA2Mzdwb1h6enBF?=
 =?utf-8?B?RVF6Z3l0RnErcnVMMm5Ld0FqL0tZdzVlZC9UczJIY0pDVEVVUFBvd053Vkpj?=
 =?utf-8?B?MXoxSksrZUJkZjJka1NSZmJsL1hsOVpMdHkzb0hMNy9tVkcrQ3YyVjJtUzFH?=
 =?utf-8?B?WnAvV2RRM0I5SDhiYk51KzBpS3U4UGhnRTQrVHhpS0lmdDlsL2hYUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bycwWPWkfnLK5k7o+JJoryGANktzXbIJwzyyW6ZQVj0q5G5lcIOx6KUO216c5T3do7UDRwKbUwTz+D1/MYnFxsktZpbY6BAkQdhjoSJ+pyUsXEwUTheMdeboqarrloBQ8Dk//8MxLkqP6Wg64FNwJisEFwjUrVUrE9e29AxD28McIT6y/nYjuExjbBuEC0bnAStb2Yuk9QvJmxRb4siiyfoH9xEN4NE5ZYQgM2dJ3bJH2YTtAeZeXZfOqwe1ATGzK+94MQd3obd6c6q6UygfCupame0b+Li5dlYUcB6fYBWuckP+boYyaLz7frss28+xDPXsk+4k1gFl6jSI0qmhxQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3159cc8f-6598-4ce2-89ce-08df35868cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 06:33:31.3596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5eVcV+DQuH0f16Dm2IsWge5rb7PVgYnCUq+dzR0N/Id3FgGHPFlQdjNdqPgHFfz3DDY2Sc9fRaRpNBd2dMT6dELrDF4ULiKzCPdW+vEDEoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB9213
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgVGltdXIsDQoNCkFzIGZhciBhcyBJIGNhbiBzZWUsIG5vIEFTUEVFRCBMaW51eCBkcml2ZXIg
dXNlcyBub24tcGFja2V0IGJ1ZmZlciBvcg0KRE1BIG1vZGUgZm9yIG1hc3RlciB0cmFuc2ZlcnM6
DQotIGkyYy1hc3BlZWQuYyAob2xkIHJlZ2lzdGVyIG1vZGUpIG9ubHkgdXNlcyBieXRlIG1vZGU7
IHRoZSBhZGRyZXNzDQogIGlzIGFsd2F5cyB3cml0dGVuIHRvIHRoZSBieXRlIGJ1ZmZlciByZWdp
c3RlciBiZWZvcmUgU1RBUlQuDQotIGkyYy1hc3QyNjAwLmMgaW4gdGhlIEFTUEVFRCBTREsga2Vy
bmVsIChuZXcgcmVnaXN0ZXIgbW9kZSkgc2V0cw0KICBQS1RfRU4gZm9yIGV2ZXJ5IG1hc3RlciB0
cmFuc2ZlciwgYW5kIHRoZSBhZGRyZXNzIGNvbWVzIGZyb20NCiAgUEtUX0FERFIuDQoNCkhhdmUg
eW91IHZlcmlmaWVkIHRoaXMgYmVoYXZpb3Igb24gcmVhbCBoYXJkd2FyZT8gV2hpY2ggZmlybXdh
cmUgYXJlDQp5b3UgcnVubmluZyB0aGF0IHVzZXMgbm9uLXBhY2tldCBidWZmZXIvRE1BIG1vZGU/
DQoNClRoYW5rcywNCkphbWluDQoNCj4gU3ViamVjdDogW1BBVENIIHYyIDQvNl0gaHcvaTJjL2Fz
cGVlZDogZml4IGJ1ZmZlciB0cmFuc2ZlciBpbiBub24tcGFja2V0IG1vZGUNCj4gDQo+IEluIG5v
bi1wYWNrZXQgbW9kZSwgdGhlIGZpcnN0IGJ5dGUgb2YgdGhlIHR4IGJ1ZmZlciBwb29sIGNvbnRh
aW5zIGEgZGV2aWNlDQo+IGFkZHJlc3MsIHNvIGF2b2lkIHNlbmRpbmcgaXQgYXMgYSBkYXRhIGJ5
dGUuDQo+IA0KPiBGaXhlczogOTYxZmFmM2RkYmQ4ICgiaHcvaTJjL2FzcGVlZDogRml4IFRYQlVG
IHRyYW5zbWlzc2lvbiBzdGFydCBwb3NpdGlvbg0KPiBlcnJvciIpDQo+IFNpZ25lZC1vZmYtYnk6
IFRpbXVyIE1ha3NpbW92IDxnZXNzaW5nYXRlQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBody9pMmMv
YXNwZWVkX2kyYy5jIHwgMTEgKysrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvaTJjL2FzcGVl
ZF9pMmMuYyBiL2h3L2kyYy9hc3BlZWRfaTJjLmMgaW5kZXgNCj4gZmY2ZWY2ZDIzYS4uNTEwNzU4
ZmI3YSAxMDA2NDQNCj4gLS0tIGEvaHcvaTJjL2FzcGVlZF9pMmMuYw0KPiArKysgYi9ody9pMmMv
YXNwZWVkX2kyYy5jDQo+IEBAIC0zODIsNyArMzgyLDcgQEAgc3RhdGljIHZvaWQNCj4gYXNwZWVk
X2kyY19idXNfcmVjdl9kbWFfcG9vbChBc3BlZWRJMkNCdXMgKmJ1cykNCj4gICAgICBTSEFSRURf
QVJSQVlfRklFTERfRFAzMihidXMtPnJlZ3MsIHJlZ19jbWQsIFJYX0RNQV9FTiwgMCk7ICB9DQo+
IA0KPiAtc3RhdGljIGludCBhc3BlZWRfaTJjX2J1c19zZW5kKEFzcGVlZEkyQ0J1cyAqYnVzKQ0K
PiArc3RhdGljIGludCBhc3BlZWRfaTJjX2J1c19zZW5kKEFzcGVlZEkyQ0J1cyAqYnVzLCBib29s
IHNlbmRfYWRkcikNCj4gIHsNCj4gICAgICBBc3BlZWRJMkNDbGFzcyAqYWljID0gQVNQRUVEX0ky
Q19HRVRfQ0xBU1MoYnVzLT5jb250cm9sbGVyKTsNCj4gICAgICBpbnQgcmV0ID0gLTE7DQo+IEBA
IC0zOTEsMTEgKzM5MSwxMiBAQCBzdGF0aWMgaW50IGFzcGVlZF9pMmNfYnVzX3NlbmQoQXNwZWVk
STJDQnVzICpidXMpDQo+ICAgICAgdWludDMyX3QgcmVnX3Bvb2xfY3RybCA9IGFzcGVlZF9pMmNf
YnVzX3Bvb2xfY3RybF9vZmZzZXQoYnVzKTsNCj4gICAgICB1aW50MzJfdCByZWdfYnl0ZV9idWYg
PSBhc3BlZWRfaTJjX2J1c19ieXRlX2J1Zl9vZmZzZXQoYnVzKTsNCj4gICAgICB1aW50MzJfdCBy
ZWdfZG1hX2xlbiA9IGFzcGVlZF9pMmNfYnVzX2RtYV9sZW5fb2Zmc2V0KGJ1cyk7DQo+ICsgICAg
dWludDhfdCBwb29sX29mZnNldCA9IHNlbmRfYWRkciA/IDEgOiAwOw0KPiAgICAgIGludCBwb29s
X3R4X2NvdW50ID0gU0hBUkVEX0FSUkFZX0ZJRUxEX0VYMzIoYnVzLT5yZWdzLA0KPiByZWdfcG9v
bF9jdHJsLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgVFhfQ09VTlQpICsgMTsNCj4gDQo+ICAgICAgaWYgKFNIQVJFRF9BUlJBWV9GSUVMRF9FWDMy
KGJ1cy0+cmVncywgcmVnX2NtZCwgVFhfQlVGRl9FTikpIHsNCj4gLSAgICAgICAgZm9yIChpID0g
MDsgaSA8IHBvb2xfdHhfY291bnQ7IGkrKykgew0KPiArICAgICAgICBmb3IgKGkgPSBwb29sX29m
ZnNldDsgaSA8IHBvb2xfdHhfY291bnQ7IGkrKykgew0KPiAgICAgICAgICAgICAgdWludDhfdCAq
cG9vbF9iYXNlID0gYWljLT5idXNfcG9vbF9iYXNlKGJ1cyk7DQo+IA0KPiAgICAgICAgICAgICAg
dHJhY2VfYXNwZWVkX2kyY19idXNfc2VuZCgiQlVGIiwgaSArIDEsIHBvb2xfdHhfY291bnQsIEBA
DQo+IC02MzMsNiArNjM0LDcgQEAgc3RhdGljIHZvaWQgYXNwZWVkX2kyY19idXNfaGFuZGxlX2Nt
ZChBc3BlZWRJMkNCdXMNCj4gKmJ1cywgdWludDY0X3QgdmFsdWUpDQo+ICAgICAgdWludDMyX3Qg
cmVnX2ludHJfc3RzID0gYXNwZWVkX2kyY19idXNfaW50cl9zdHNfb2Zmc2V0KGJ1cyk7DQo+ICAg
ICAgdWludDMyX3QgcmVnX2NtZCA9IGFzcGVlZF9pMmNfYnVzX2NtZF9vZmZzZXQoYnVzKTsNCj4g
ICAgICB1aW50MzJfdCByZWdfZG1hX2xlbiA9IGFzcGVlZF9pMmNfYnVzX2RtYV9sZW5fb2Zmc2V0
KGJ1cyk7DQo+ICsgICAgYm9vbCBzdGFydF9jbWQgPSBTSEFSRURfQVJSQVlfRklFTERfRVgzMihi
dXMtPnJlZ3MsIHJlZ19jbWQsDQo+ICsgTV9TVEFSVF9DTUQpOw0KPiANCj4gICAgICBpZiAoIWFz
cGVlZF9pMmNfY2hlY2tfc3JhbShidXMpKSB7DQo+ICAgICAgICAgIHJldHVybjsNCj4gQEAgLTY0
Miw3ICs2NDQsNyBAQCBzdGF0aWMgdm9pZA0KPiBhc3BlZWRfaTJjX2J1c19oYW5kbGVfY21kKEFz
cGVlZEkyQ0J1cyAqYnVzLCB1aW50NjRfdCB2YWx1ZSkNCj4gICAgICAgICAgYXNwZWVkX2kyY19i
dXNfY21kX2R1bXAoYnVzKTsNCj4gICAgICB9DQo+IA0KPiAtICAgIGlmIChTSEFSRURfQVJSQVlf
RklFTERfRVgzMihidXMtPnJlZ3MsIHJlZ19jbWQsIE1fU1RBUlRfQ01EKSkgew0KPiArICAgIGlm
IChzdGFydF9jbWQpIHsNCj4gICAgICAgICAgdWludDhfdCBzdGF0ZSA9IGFzcGVlZF9pMmNfZ2V0
X3N0YXRlKGJ1cykgJiBJMkNEX01BQ1RJVkUgPw0KPiAgICAgICAgICAgICAgSTJDRF9NU1RBUlRS
IDogSTJDRF9NU1RBUlQ7DQo+ICAgICAgICAgIHVpbnQ4X3QgYWRkcjsNCj4gQEAgLTY4Niw3ICs2
ODgsOCBAQCBzdGF0aWMgdm9pZA0KPiBhc3BlZWRfaTJjX2J1c19oYW5kbGVfY21kKEFzcGVlZEky
Q0J1cyAqYnVzLCB1aW50NjRfdCB2YWx1ZSkNCj4gDQo+ICAgICAgaWYgKFNIQVJFRF9BUlJBWV9G
SUVMRF9FWDMyKGJ1cy0+cmVncywgcmVnX2NtZCwgTV9UWF9DTUQpKSB7DQo+ICAgICAgICAgIGFz
cGVlZF9pMmNfc2V0X3N0YXRlKGJ1cywgSTJDRF9NVFhEKTsNCj4gLSAgICAgICAgaWYgKGFzcGVl
ZF9pMmNfYnVzX3NlbmQoYnVzKSkgew0KPiArICAgICAgICBpZiAoYXNwZWVkX2kyY19idXNfc2Vu
ZChidXMsIHN0YXJ0X2NtZCAmJg0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICFhc3BlZWRfaTJjX2J1c19wa3RfbW9kZV9lbg0KPiAoYnVzKSkpDQo+ICsgew0KPiAgICAg
ICAgICAgICAgU0hBUkVEX0FSUkFZX0ZJRUxEX0RQMzIoYnVzLT5yZWdzLCByZWdfaW50cl9zdHMs
IFRYX05BSywNCj4gMSk7DQo+ICAgICAgICAgICAgICBpMmNfZW5kX3RyYW5zZmVyKGJ1cy0+YnVz
KTsNCj4gICAgICAgICAgfSBlbHNlIHsNCj4gDQo+IC0tDQo+IDIuNTMuMA0KDQo=

