Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D1EEA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjlr-0001Q1-UJ; Tue, 10 Feb 2026 04:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjll-0001FE-Gs; Tue, 10 Feb 2026 04:10:55 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjli-0004iv-95; Tue, 10 Feb 2026 04:10:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLPCpKEhfrP95urY/L5mc8CzQgFXshz8bq5SRR9DpMMe8vQVlmpe/AKFjPWwvTRM27BC+Ziu6zAkL23Rt4/JA9bdxUdV1S3i3cR8qbl0revMNZ7ycYLn/rA9OvxHzOBIc2Ajo8UtHE0yu8LDXSId+YbwuTQSaGQ+gYikIRfsP02zcT4WDTHRGOD/E9kIZb36iNBwxI9+PHqK8PhQW6FTubPmJUDxtfBImYzQUzysmbnl2f2BITDjdYTnbYuv8d8AgEjHmDcoUE4zdRrTV0qmynIAKgBASsMGsBs7Rl57OHZ08JvpAka2iggjPwcYFQqTUV4Ut4FkBODjiIcbWzBBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=690KXiimusrqeKtoA/hFuYYO5Wii11mzJ+niotnpX10=;
 b=nLJbsFy9b0ryRm/QxxJCT4CzBfmb36pWwla6Il4wx62J56kqQgwyIAiUnwEX8QVr7OACtdecZyqjSIn2L58uQ/q465gBdmIZxpfICUAMCdKgTz+k0YlHizWKjyi84X5GIcdmEA4iHx2GeHFCAp/2YtHouaEHsC3wcETerRJG8IwLHhzHaRkzZw6emBwUurjgy8iFN5fF3pQHtULiTUtDIcghQgrdCUssl0CHUS3Yp1oK8Jq4gTMVR2HxVdFngJrfe91FixCj/8JCIzSESS0QIQClAvODOHalAKzjO5N91+eTI0lwvVgL1l8Y1bFtSCILUDFGr+99K9u26CX0VIDyRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=690KXiimusrqeKtoA/hFuYYO5Wii11mzJ+niotnpX10=;
 b=p50HN+SHffm1zfs1+zUNKNIiY0pqfGK/l6oDqUg4j5ohFm+EL26sxr+tzL4/xvRG9Oj6udNDtZPzGkHk0cxxCh1UOf8MxjcVULWRYGkWm0/xdLjLTUe3An068v4NY0JQzOoEyASMAw3jvZURkglYqnVK97YQpqfhcugXXfvvh010HESeFv8s77s/5+2fRvaDYBWl1FxO6pYbK8+3UusVdGaL7Yiap+ETFg6Bs4XJfe9+GQwNwOWP91LtDBL4lEAZ1g23hPBM01WMl61HK4VjXP5Gn5/8QvnwpNmeYmZHaf6HdpZYi4tfZTRkmusanefUTB7gQodqdtbYYWtWhTAUvw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SG2PR06MB5216.apcprd06.prod.outlook.com (2603:1096:4:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Tue, 10 Feb
 2026 09:10:30 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>
Subject: [PATCH v5 07/21] hw/i3c/dw-i3c: Add more reset values
Thread-Topic: [PATCH v5 07/21] hw/i3c/dw-i3c: Add more reset values
Thread-Index: AQHcmm0aqOQxPsQk/0OO7zYNv/NgkQ==
Date: Tue, 10 Feb 2026 09:10:29 +0000
Message-ID: <20260210091018.1553489-8-jamin_lin@aspeedtech.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SG2PR06MB5216:EE_
x-ms-office365-filtering-correlation-id: be7f5c7a-fb33-4d95-e72c-08de68843ced
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Yd1Pk7daFmOqmyigHmdU4CUlLRzE85dksSwm96RYC9nJl92Dc3H2EOB8rh?=
 =?iso-8859-1?Q?bVy7CxAkeIK0u2yGz6iq4xtceRnf1nFz5YjxQecNljQTEIHVVyWbk0M3ek?=
 =?iso-8859-1?Q?VWLYGaSZ4FoUDdPBsVHc2iig0u/Wbq98U0N1xZ4LRRgC/fCythgvjwP2WB?=
 =?iso-8859-1?Q?G6p93nHxCvfgSVOhbjAODwdbnLma5X8sxeX40R/43ZyxIS6eKj3zpespLq?=
 =?iso-8859-1?Q?TF5VOeVXHV6hecHTnc30U1hxQqJ9yywwPEygmfzZpvYgH4X18vhd87t1jj?=
 =?iso-8859-1?Q?xtvdDZoS0e6gFXk4kPvUIpacv5y87eX8g7VOFrHt/tcwtf/wh6XTsrqlEV?=
 =?iso-8859-1?Q?SDXunsx4pY+UDtw1QtxRE9MmjXcbUIz5cQdEKcgoUGZ6G2XnoJyhD03lMX?=
 =?iso-8859-1?Q?fvKYVUWIi3xK278zYFou+o3MGD9U2L4IuoElcqbIjwdz8M8ZNzbxnkAIW5?=
 =?iso-8859-1?Q?tXhyu45fXGRaxWj5SqHzZ8cMlArOaCL4CZlvKCpgSC8g/xon6qVNnTsoY8?=
 =?iso-8859-1?Q?ZOo+ulwTJSreflBnlHa5UG/Il7XEnRAgrJ6WGi+pmYnMDRMbWk74BvBSX/?=
 =?iso-8859-1?Q?M3GS5fcMr7MziWCohG3EUIwaBb3ZxgBGmkGZx4qus1EEEXIwbBkPMlzGun?=
 =?iso-8859-1?Q?7KodU0A1fgXwKMsjLyckFtE4PtSvGjaSE+X3hnrC+MtesCjKtTxVsxx3Kq?=
 =?iso-8859-1?Q?2p4radgeU07f8U6Oh/DJkfFBwSx2RiS4/inNdKD42PdMsys8aS4EBXslIV?=
 =?iso-8859-1?Q?CdkC5r4WWVgbE8DI7o6TddPHvGPTqM2rZV7E0wdoDexb6UQ5jpMWRz73Qa?=
 =?iso-8859-1?Q?4fJfKcVyAIu1Qmm5fN1Cgs8j6yh217CBegHhkMtrByL7z5CBo0X3PB48zH?=
 =?iso-8859-1?Q?TJ5vh3fPqyVzb4/1uM/yiF0zGDO5C0DxIVrE+ci5U8sT8cQFV0cUIzNyWi?=
 =?iso-8859-1?Q?0O37i8olAcy4GBr7aaeaExAGdhyuI/ho2aOVc1n7fdNDuOvPtd3SMNFKEQ?=
 =?iso-8859-1?Q?2Zm40uFkRVqECbZCkzQS7x2RfFgL/KF4vQeCXf4uk7XAoE2MVAImh40ND3?=
 =?iso-8859-1?Q?wLFSSyPXmUYW5nE/3ub8a7WwStiNyX9KIXWJp7Z6FnEW+6xto2Z4vgyXj6?=
 =?iso-8859-1?Q?ijrgCG1x2RwB5c5zf/IsqtSxFNj9NNenhTkeW5ioCf0uQc0aOpSwdUyRGR?=
 =?iso-8859-1?Q?hS7cLvR1aWpIJymlnx9+nhgHTE4sNvmg0vcH+kxjnNzgxNnJaDiSfytUfZ?=
 =?iso-8859-1?Q?meI8Wgv8DAjSjKDD2n5S/Nzp0yLKZvmaRCyKEpjh7KY2IRMXNeXxTapCuW?=
 =?iso-8859-1?Q?LuFOYLIoghTIqzcWGrJ7aZ3FFjWNTHlOSsmS9/S+XS0lqUR42ltd6/9mGR?=
 =?iso-8859-1?Q?rXmnbIuOAFeAw1oZomsmsiJ2t3hXfwosqwv6U37vUKeGEHI5zzXB++NFjB?=
 =?iso-8859-1?Q?+9zk4bC88tcmdv3jOIQO32oK31t2pqTyxl+wFbZ8StuIIXGN1W1dsJr8W9?=
 =?iso-8859-1?Q?ZyfChX0TcSkPwk7pVORe0lznHLLsleN4BGEwb14nwRYiPQtSGjwJscZrPY?=
 =?iso-8859-1?Q?Yj3YorLQHnecIlfQJnD0LlwHbf4cMR5CgpSnoaroOTktUaN+n7km6Ke4oy?=
 =?iso-8859-1?Q?TnnwwwNCm/J2w3h3q+8zoNBYbXbkVsyRSjZfKwLIU9udJCM5Jhi0UJ3ldn?=
 =?iso-8859-1?Q?CeFjTrDzjn6vNsEUZ3dloKIv5+2BzPcg+fzd9qQC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U9KN7NU40M+FJ18pBmjKdvnbzsWXbbd6B8EQ6bkVmF4LomVwzvvPwANTj2?=
 =?iso-8859-1?Q?o8nfPX9O9IkxwRXrpQ7Yr9Su2aGwEKJfKEx4KdE6km0Y9MrujSjqeY9u1u?=
 =?iso-8859-1?Q?wio4L3AdpoVOPEJW9PnbJxyJy+VSnSD18/55KZxdhkeDbmUHdWMzEH6MkL?=
 =?iso-8859-1?Q?wT924zhXO7xu26AfmIU49XqOdXY7ydeQMjs9775/bL0hRH+eEDvdUZBKj9?=
 =?iso-8859-1?Q?lRozrbG/UN9Bu+71wLdChRBcbnxU54FA9g8ZP4+WzEsHfLa7iTmlS/9ct6?=
 =?iso-8859-1?Q?8Eagow+CpaOnpF16Q2cDNNujBjYC7bJqq3caUFwa50mgU7WoKHBQMe1TQP?=
 =?iso-8859-1?Q?LsgKn0/YCQyHlwib3KhYTJ66M/CnWIJwy2g0GKLXTzHuuF2KxRQqhqThTS?=
 =?iso-8859-1?Q?gnUkMdGniiwaWhpbeq1IPL5/RhNOUX+ItDT/CMbhlBMBYWcmVfE9HpHJye?=
 =?iso-8859-1?Q?N5iV/IT0622DShnaM0J3Ee/jEpl1zhuRNdebe+2YmAgXVVfYCbPJ/oL3jr?=
 =?iso-8859-1?Q?xtAAuEIpHkBm3ZLNOe4k4VddsOMdfDqc3v500YuSQoGpadJmL1JKIcA6kZ?=
 =?iso-8859-1?Q?0MiPq+sLryHXaTd/dNo8AYLcEtw7oLGB6hic2sIDS3J8A0Bu9fgOf3V1hD?=
 =?iso-8859-1?Q?9VUapJeNZUYzKm4AggwrHCzULhwkYRNRZxf7qxGBjQyBzgVsWR2MdwZdx6?=
 =?iso-8859-1?Q?S2x+fvA+Fy0Gl821U/pD0GcLLftXEx2gbyTRVvDApDD5XZNiOtoNjWUcTU?=
 =?iso-8859-1?Q?FXEJm/O6zAhf84xRrdaQxNZVV5XgZYlqoZsL2qA6bWkC3UkesG214pLPjS?=
 =?iso-8859-1?Q?pxHz/Tx2MZTGvyUx0P0f0yqGPT1XqCqxzkmxzv4NoiH44LdA7xr/byRnp+?=
 =?iso-8859-1?Q?m/ej0cSj2bbtiVZZ8fvDlNBimTf4QF9xy6F1OMqehBExWyLNU3GKyv+5qT?=
 =?iso-8859-1?Q?KNLqiuGX3CAv2a3ZFmia11FpAu/xZfaNa6FaOYMrNA/sW2jA4h4TAhobaf?=
 =?iso-8859-1?Q?M96iqScYevLUA0PwOJiDmbLNBuaOD00dLWMWfZsXfq/M0IW2K+pfKGOJq4?=
 =?iso-8859-1?Q?0Kvmg1bokyZbf4EIgX+J+WzYtnqabN5VyWcdF3A9k5ChA3ONqnykGF34ir?=
 =?iso-8859-1?Q?QsfvQPIoBusHfzV02xrSyAb9XVeKz8csOm7+6eSbPJftw2BRYf7R5dCC9I?=
 =?iso-8859-1?Q?bgIZ5XjqE+CrjKffPtHSSjt/XtwLkzWjlVtu8FiyKipR1zJE1FJhiV8m/W?=
 =?iso-8859-1?Q?pW9CnE9g9bvTWFCmXp6v8vfl8gqaphpPlkJPGR+Gg9/h7EI/465wjmdG47?=
 =?iso-8859-1?Q?XwWgs15nyyfcyZJHmDb66lI0DFw8T1XQCWj1jlzkecHV/ZHgp83TMbjugr?=
 =?iso-8859-1?Q?4x46yaIi/NO589uGUJ8YLUf5UwE1Y5gPUcGeenNXRQsYnzxolG3xrzOFv0?=
 =?iso-8859-1?Q?XHk6DnlVBJpk8VbkkK9oBKhZmpll/UJQmoZq99J7odGeQNSeuJWjnFqq5h?=
 =?iso-8859-1?Q?k0/56jJONtj8eoaxt9we5v4uZMiNSSEQ4VC3JNBTCjX/KHweNpD4ylq7mb?=
 =?iso-8859-1?Q?HTHw+7LSND9t+eoRgfQLgBtlvNXmcsDwwXdoZD3/aRs9j5ovZVfGT2+WcA?=
 =?iso-8859-1?Q?h3DrpU1IDzKGdGkVoHDlGltCMvu4tolxSpmi161asNYHBr/kr52pI3ryKY?=
 =?iso-8859-1?Q?WjueH4EUagYewhWkzZNHZS1dZ+GtcwJJDICUgRhutMG3u/ELzFXZSaHcKe?=
 =?iso-8859-1?Q?+xSMOc3qQGysklnT2VQl+mlnYzBJyY7YsdshkSVaIlw45ZdBdwwtldzMJP?=
 =?iso-8859-1?Q?IsvJvjksKg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7f5c7a-fb33-4d95-e72c-08de68843ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:29.9948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2OSgt7LTGZWDqk8EEm1rmzDkujjptJ1AGFyhYOo1eBNqh9ECcPSBZ4chZliYZgBADHshGKv8bvceQP2bIM0DA66hdO1HIH9n6/JMa0Tnoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5216
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

Adds reset values for the new registers added.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 20 +++++++++++++++++++-=0A=
 1 file changed, 19 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 48dde008de..28da6016a1 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -268,14 +268,32 @@ REG32(DEVICE_ADDR_TABLE_LOC1, 0x280)=0A=
     FIELD(DEVICE_ADDR_TABLE_LOC1, LEGACY_I2C_DEVICE, 31, 1)=0A=
 =0A=
 static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] =3D {=0A=
-    [R_HW_CAPABILITY]               =3D 0x000e00bf,=0A=
+    /* Target mode is not supported, don't advertise it for now. */=0A=
+    [R_HW_CAPABILITY]               =3D 0x000e00b9,=0A=
     [R_QUEUE_THLD_CTRL]             =3D 0x01000101,=0A=
+    [R_DATA_BUFFER_THLD_CTRL]       =3D 0x01010100,=0A=
+    [R_SLV_EVENT_CTRL]              =3D 0x0000000b,=0A=
+    [R_QUEUE_STATUS_LEVEL]          =3D 0x00000002,=0A=
+    [R_DATA_BUFFER_STATUS_LEVEL]    =3D 0x00000010,=0A=
+    [R_PRESENT_STATE]               =3D 0x00000003,=0A=
     [R_I3C_VER_ID]                  =3D 0x3130302a,=0A=
     [R_I3C_VER_TYPE]                =3D 0x6c633033,=0A=
     [R_DEVICE_ADDR_TABLE_POINTER]   =3D 0x00080280,=0A=
     [R_DEV_CHAR_TABLE_POINTER]      =3D 0x00020200,=0A=
+    [R_SLV_CHAR_CTRL]               =3D 0x00010000,=0A=
     [A_VENDOR_SPECIFIC_REG_POINTER] =3D 0x000000b0,=0A=
     [R_SLV_MAX_LEN]                 =3D 0x00ff00ff,=0A=
+    [R_SLV_TSX_SYMBL_TIMING]        =3D 0x0000003f,=0A=
+    [R_SCL_I3C_OD_TIMING]           =3D 0x000a0010,=0A=
+    [R_SCL_I3C_PP_TIMING]           =3D 0x000a000a,=0A=
+    [R_SCL_I2C_FM_TIMING]           =3D 0x00100010,=0A=
+    [R_SCL_I2C_FMP_TIMING]          =3D 0x00100010,=0A=
+    [R_SCL_EXT_LCNT_TIMING]         =3D 0x20202020,=0A=
+    [R_SCL_EXT_TERMN_LCNT_TIMING]   =3D 0x00300000,=0A=
+    [R_BUS_FREE_TIMING]             =3D 0x00200020,=0A=
+    [R_BUS_IDLE_TIMING]             =3D 0x00000020,=0A=
+    [R_EXTENDED_CAPABILITY]         =3D 0x00000239,=0A=
+    [R_SLAVE_CONFIG]                =3D 0x00000023,=0A=
 };=0A=
 =0A=
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
-- =0A=
2.43.0=0A=

