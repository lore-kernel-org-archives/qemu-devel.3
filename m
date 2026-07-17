Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F39C44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkczl-0003PQ-Ld; Fri, 17 Jul 2026 03:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkczh-0003Om-BI; Fri, 17 Jul 2026 03:28:25 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wkczf-0002Bp-1L; Fri, 17 Jul 2026 03:28:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3SRJGYsfNMpnMc9qSYevZ8wvxqHyLscEzkrvVgoma+IhFU4yYulSYUL9iHULAmUlerfqT8tGJs0AbSj21pFfqziepsQFnfaLVZxUoXtcpMEsT6yGZ4ydSSwQoMThh0maYRlY+KIDxBL4dhV8+ekK0tpJYA9rPQumLtkC9bGziHUHBzm2CUYpSfulHLuG1IXDpdusKBhjcfyU9HH6C+wNGioQoNVKVcODS/mn8Zix1KDlxBqrH1rgwysw64oyeoOSD2s52mb7he0I5lqx2oofmj0f6hwfQQccQCX3gp4RYjnQ0yKZ4DywTtdBlM2BqKdlsOnSgXnQDhQ2+VnjF0fQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2psQdL27daeCWm+lLlga278MsKMMpVKLL/Mk8TmN1M=;
 b=CyWKy4Wl7SJRdqr1L8g0ZuleudAkzpDtpzM5cNvVYwf64GPtT5zJIbnrePdBzE3m6GgLT3vUQiT75Tdwv19n/70brm7f5ZDaX+Ol/hPlPG/nsiIaGR2sdXzO0T3cw9u8DINLhCFUW19CLli4LIo7spz1RNJro0pEYcvtWaF6h8BqlbGM5a4Q5xK0knSxnM3qtBJQYhDtEvtnKaErHYkXLMRjqsIKOIQ9hwdUhAZBDIlSX+qbDCnS+3T/Pzw5KEO9wGiRmlfZjgYIwOM+19V+iZi+tTUoyvw/Hp6OLYtNIKshHCU/WiFH559qVe27XriXYxOdTBrX2GcKYb3yQvPglg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2psQdL27daeCWm+lLlga278MsKMMpVKLL/Mk8TmN1M=;
 b=qtfpwuIeHcxgHGrgH8geBQhGrCX+giqeJVdgZy7ebZTZWMzNaKf/i6yOK5ZSfaFet5YOijFJB8lupZ3xgG+xS6h1y4Rw5JLfX/I7DrMal0n6BnM6zfCKh67AZvIQ8EpqMt2ajhvaEaNAGhKPZ2EF4k+hRVWiWv1Y3luotpreOQhlR/QUtO6cwHytiU/1qDpzHGSbE79ikZ07dQTD4NnTxxpv7TnUZ5OYui79LkAoELHRP3H/PCEePxQ0IipIyESTYtUsQUZxf7YkJAZnQmSdLk21Ak7Ew3ypKtkFstxYEiBq2K4zFyRuE/3q8sWYQzvFtw8iPUxW8WwK6vfoM4HOQw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by JH0PR06MB6320.apcprd06.prod.outlook.com (2603:1096:990:13::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 07:28:13 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 07:28:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 0/3] tests/qtest/aspeed: Add Data FIFO qtest coverage
 for AST2700 SMC
Thread-Topic: [PATCH v1 0/3] tests/qtest/aspeed: Add Data FIFO qtest coverage
 for AST2700 SMC
Thread-Index: AQHdFY4p4zH1qzsU5kaHZqwmbBZTIrZxT3kAgAAA4TA=
Date: Fri, 17 Jul 2026 07:28:13 +0000
Message-ID: <TYZPR06MB4980C3F9DE97234DC5124E37FCC62@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260717014701.1683876-1-jamin_lin@aspeedtech.com>
 <05a9b014-8e8f-44c8-beab-04816a0ca246@kaod.org>
In-Reply-To: <05a9b014-8e8f-44c8-beab-04816a0ca246@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|JH0PR06MB6320:EE_
x-ms-office365-filtering-correlation-id: 570378f5-6b71-4dbc-112f-08dee3d4f633
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|22082099003|18002099003|4143699003|38070700021|10067099003|56012099006|921020;
x-microsoft-antispam-message-info: B6WHVe0pJXJxBm/2J0A3Lwovg63HC7gyn1In+dQF0jjP6Am8UOMit6nirDy6srrjYLTLZr/1no7BOl8ZKxTd1JXVddJaQL7TDTOBAK/kXbWhONIVU7ex+JZX+CCWzVKVfMeu/rgXlVtJU0Jwa/maM1wlDgd0fpB9/OQQsAU0GwApkzguV9WjXhv6gTnklvYnMpGSXTPwTwanGLGBu9OFL41fHI3pv+UtgcvGGkTHoU5y6YWMZXZ78TJOrf2KUrEPngm6bkfLeqghadCxBAI+9Wl03vswt56u3yhlVrgQGXPslGG0zXOAXeUwGsTLGjG1ueZkoxlYZMVEDCMx4UuxKn260eBsQCS+fSSovolXjM5zSL6/CS6vCaMsgGq/ZY8oUeHORVP3k1906VdIEB/GQFuhoP3YIH7qpvxVuJrUD+N/5KbPqYbpz5yxbVpAD+NykDpzrdDvUKW11G24QsKGBx832CLkigChQ8AFrVf23isS5bnTTcs66Xx1G5P5It01BkmDCLH03PoJ+xi+QBoyB48CTm4y1BN0sjcnk8W5lYMhGKlPN8pG0t3eKzuvW7dVWvHkCIaCdWxR6ik71B+aP6UvtH1jnUZSZW5BakIe4+3ROopJNPzD2ip0F3BX/lFj/5FQezFZKVobG/RSmzY97YNSpKOEa9n1yMiNHvph7uOgbgUU/QM6wIhXSfIr6KqsFzZvNKuALbgbXdWcXYXeqCkYi/mUzG6afShd1hDhN2ko68gVhXLS0ViRjqPK0HYj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(4143699003)(38070700021)(10067099003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDFKdTZac0FZNlJmQ2pwUDZDMkJBbXVSTG9ZUjRaNFZMMTNOUm85cnhSblVl?=
 =?utf-8?B?STg4dS9LSThuWTlBTE1BSE91NkZxTWJQV0pCRTNzNU1SK1JxSGh0MXNuNHoy?=
 =?utf-8?B?dE9KZVRIcWIvSGgvekttNGluSXlKZDBlZ3I0cGVTK0t3QVZobmZ6ZUYrRThQ?=
 =?utf-8?B?SG9FMjh6MzhZTUMzWmg5SmlPOENYS3crNCtDTnV5M1lSMHdLdHJNMlJkT2cr?=
 =?utf-8?B?TmlIWEtTUDNUREQzRXAxc2FkQ0hKVVJSc3BhM1FNa1NINlJnL3N4K3RiTkMy?=
 =?utf-8?B?L2R3YjlLRTBaempGYWxwWEdnamIvb0JrU2czVDljbXBEUENPb1ROK2p4Wk05?=
 =?utf-8?B?V21iL2JTSlhVY2NHQ3NmN3B3WHNEaFBndktycjZGRldlYjZGMVFEYVRGM3Ry?=
 =?utf-8?B?ZnBVN0MxcHJqaFYrSDFRTGZWSzdUM0VFSW1CU3JoMTN4cHFvQ2RoaDRkQjlh?=
 =?utf-8?B?VUk5bVl1SktzTnY1eUFVc0xJdHptWnQ2TmFORlkzOTdhMU9vcWhzLytSaTFO?=
 =?utf-8?B?YXJGZk1SSlpTUzZkbTN5dktVU2tBWmZ5cW9SMzg5dGRlMTRxd0lKcnh1elpk?=
 =?utf-8?B?VDlrNlZYczhzT1hlVzE2ZC9OcitTUzhab2Q2RlREWWkwMmRrSUF3Smx3dWdW?=
 =?utf-8?B?UnVKdUw3NXlTenUxVThqRHpxS05FeHR1cUQzZUtZVktPMHNEZFFrNDF6NGpT?=
 =?utf-8?B?VFBUR0xJbXlBcmZmdm1COVkwR2dkbjRRZ0tGMVA1ODVtMUYveUhHaGQ5a2ll?=
 =?utf-8?B?UlFBb0NTczNBUEhVWW5nTGUwZVZvQzhKdzFHVkZLeE96ZElUMkJVQ3ZzVGtW?=
 =?utf-8?B?ZVhPZGc1dXFVNVpka281Z20ycnY1c0VMdkRJM1JBRWZ3ckE5TE10SDhIejJa?=
 =?utf-8?B?MnhVWHpPN3A4bFdZMnNpcVpGc3VDaUM4Um9OaDJwVkVvSVAyMmxEQVRob3Fn?=
 =?utf-8?B?WUtZUTNkcGRpTGhSNjgySmhQcWVydW03Y2IraWVhNGJpSTJGU01OQ0dMbEtO?=
 =?utf-8?B?VEZjcVVwM2l4SWwyS3lYb01pdU5IdldSMEVocmhnYmpqZnhmZmxKdFZCWnpu?=
 =?utf-8?B?NzZyNXNDUVg3UEFHdlpQQXg4blMzeW0zaXJjVEpjYXpWNkdJdFhiaktndUl6?=
 =?utf-8?B?cVI1ak85amMzS0RObjlOMWMyS3I1b1JNKzZVTG5BTlUydHpYNWtiNi9kOEFm?=
 =?utf-8?B?UEpPbDF2dHMvUG5BbHhZVkEvcWRJVXZkRXJCRnNlWit5RUFKMmpzdkx3Q20w?=
 =?utf-8?B?dWczN1hSQXRKTnlDcDBvM3JzeWNCYkl4ejR0c2xnTHdtdHdWb1dGWDdGWGFy?=
 =?utf-8?B?cWhEVWlnOXdaZUFkR1lmWXVnNFZWc2VJdW9QV0RIN3lNOUdFRis5cXJmaVRn?=
 =?utf-8?B?Y3lzdDlFeXV2c2hKaXBaVnNjVzBGWmZMQ01oVUlXUExKbUtHclVHVC9DR2Z1?=
 =?utf-8?B?SFhYNVZHQUV4TzhJMU40amhteVhrZnlFUElScVdta0lOSW1lNlNyMlR3ZG12?=
 =?utf-8?B?K0djU0JURkJZZmZabnZ5UHZ5VWtNUk5DRlRBUDJRZzN1UGs4eTlqMHNZcUE2?=
 =?utf-8?B?d2gwUUdtcENZVWk3Y2JIWTdFSmJ3UWdlL3dhOS8ydTFpOWR1bHh2MXJSTkRp?=
 =?utf-8?B?VDJKRVpFQkl6WTBtRWZWYmhJRkkrdktXY0k1ODEzZWp3VjFxck1ONktqYllx?=
 =?utf-8?B?SDJoTE5FREdWbThHTXdMcVJoKzNrbG1DbE5WUk1zODMvaWMxb0tSRVpzeVpL?=
 =?utf-8?B?RTVUSU9WbmtTTGpOUnVpcGhuTmRLVENuV0llcGszMitYWFExWnZiSmtRUTk0?=
 =?utf-8?B?Ym9JVFBCUW5teGFQenJYOGE1TmFBNTlhdWYyTElvdHFOMUxQSW00WUJNNHQ2?=
 =?utf-8?B?YWc0NHlldGpIdWxUemhNWGMxMlVUZlovdkpST1NBYXRJR2ZYWS9VQzFuY0dB?=
 =?utf-8?B?V3ozNmc2VjhadWxGWTNFODJhV0NDTUlsTlZLeStPa245VUt4TTVHamIzRGN3?=
 =?utf-8?B?YVdpcUNleWtLWFZFcXRLTXdsbDZCVGZiN3N3YVk2VkpXU1pMTGhLV3daMFFZ?=
 =?utf-8?B?b2NpR05wQnQzc09rckpRM3FPZ0RTdGlWVjJRc0E4K3QzM2ZrWDRSVmdraDNi?=
 =?utf-8?B?NjVNYzc5Y3QraldKRnllMENrR2xPYUhXUDJ3ZzBtb0V2RUpicS9PbkdZdU5j?=
 =?utf-8?B?ODcwMmxNeVJDTDJtcC9jSjRvam1OYnBXL0xTMzhrY1lMaUdYNDF0N0dwREJC?=
 =?utf-8?B?UkZVQWR4ZXNDS1o3cEI1NE1OSEdRMC9DbTRNc0E1WXh1Y09qN0UreWs1WWJy?=
 =?utf-8?B?ak5DcFZsaWZqcjlmR3NtN0ZYdTBhS1BtYThJK1MwdnRBZUZNTlBhQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dDL3AJLs8vX8zR+8LDd474do3WLCNr6KhZNF+qe+0mb87DAfwgmAn9wUPdJR0gKa1J0cbFzAJLTVeV+QSGy7hvYXaLe1qmJfjflO4WkR7gWnm8R7jLaKZ8PSrIKcDgmG6SbUyJwpsWTgmoE0f0O6eDCG186Wq97SNyc/rGJgOXYK9zctnLHygh0xNxFNpxAyiVRFEAVLehUGqmVIUaE2W3BnjD8sFcmqf2PM0U4H2qX7dNpw/lXjhPRWCKh5ZqVPjupV9dh1Rgrp/8PRLED9hEPnubAmwNN9RanInEkA58BotGV/ueKftfuD1g2sSue+uRMNy84Stb2hUQF2CLgqPA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 570378f5-6b71-4dbc-112f-08dee3d4f633
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2026 07:28:13.5923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cp6/zFMrldjGEFNekl4gsuxju3fzZtg3mH9MZc0mLMSryQzdIfa9uV8WgUsRl6GnzTqNBwKKoWDjLSC10y0rD4Th6Ad3688aBcxGoSwtFhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6320
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
aWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSAxNywgMjAy
NiAzOjI0IFBNDQo+IFRvOiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IFBl
dGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUgPHN0
ZXZlbl9sZWVAYXNwZWVkdGVjaC5jb20+OyBUcm95DQo+IExlZSA8bGVldHJveUBnbWFpbC5jb20+
OyBLYW5lIENoZW4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47DQo+IEFuZHJldyBKZWZmZXJ5
IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkNCj4gPGpvZWxAam1z
LmlkLmF1PjsgQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXJAYWxpc3RhaXIyMy5tZT47IEZhYmlh
bm8gUm9zYXMNCj4gPGZhcm9zYXNAc3VzZS5kZT47IExhdXJlbnQgVml2aWVyIDxsdml2aWVyQHJl
ZGhhdC5jb20+OyBQYW9sbyBCb256aW5pDQo+IDxwYm9uemluaUByZWRoYXQuY29tPjsgb3BlbiBs
aXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsNCj4gb3BlbiBsaXN0OkFsbCBw
YXRjaGVzIENDIGhlcmUgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVlIDx0
cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwLzNdIHRl
c3RzL3F0ZXN0L2FzcGVlZDogQWRkIERhdGEgRklGTyBxdGVzdCBjb3ZlcmFnZQ0KPiBmb3IgQVNU
MjcwMCBTTUMNCj4gDQo+IEphbWluLA0KPiANCj4gT24gNy8xNy8yNiAwMzo0NywgSmFtaW4gTGlu
IHdyb3RlOg0KPiA+IFRoaXMgc2VyaWVzIGRlcGVuZHMgb24gaHR0cHM6Ly9naXRodWIuY29tL2xl
Z29hdGVyL3FlbXUuZ2l0IGF0IGFzcGVlZC1uZXh0DQo+IGJyYW5jaC4NCj4gDQo+IFNpbmNlIHdl
IGhhdmUgdGltZSwNCj4gDQo+IENvdWxkIHlvdSBwbGVhc2UgcmVzZW5kIGEgdjMgb2YNCj4gDQo+
IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYwNzA3MDYwOTE5LjM1
MDYzNy0xLWphbWluX2xpbkBhc3ANCj4gZWVkdGVjaC5jb20vDQo+IA0KPiA+IHYxDQo+ID4gICAx
LiBBZGQgRGF0YSBGSUZPIG1vZGUgdGVzdA0KPiANCj4gUGxlYXNlIGFkZCB0aGlzIHBhdGNoIGF0
IGVuZCBvZiB0aGUgcmVzcGluLCBtYWtpbmcgc3VyZSBpdCBhcHBsaWVzIG9uIHRvcCA6DQo+IA0K
PiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDcxNDEyNDYyMS41
MjI5NDgtMS1jbGdAcmVkaGF0LmNvDQo+IG0vDQo+IA0KPiBUaGlzIHNlcmllcyBpcyBhbHNvIGFw
cGxpZWQgb24gdGhlIGFzcGVlZC1uZXh0IGJyYW5jaC4NCj4gDQo+ID4gICAyLiBDbGFyaWZ5IFND
VS9TQ1VJTy9GTUMgZmllbGRzIGFyZSBzaGFyZWQgd2l0aCBQU1AgU29DIHRvIEFTVDI3MDANCj4g
PiAgIDMuIEJ1bXAgdm1zdGF0ZSB2ZXJzaW9uIGFmdGVyIEFTUEVFRF9TTUNfUl9NQVggaW5jcmVh
c2UNCj4gDQo+IEFuZCBmb2xkIHRoZXNlIDIgY2hhbmdlcyB3aGVyZSB0aGV5IHNob3VsZCBiZSAh
DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KV2lsbCByZXNlbmQgdjINClRoYW5rcywNCkphbWlu
DQo=

