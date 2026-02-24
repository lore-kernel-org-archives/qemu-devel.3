Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C3AEFB810
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 06:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumLb-0002QE-Fx; Tue, 24 Feb 2026 01:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLQ-0002Ib-RL; Tue, 24 Feb 2026 01:56:33 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLO-0005Lc-SW; Tue, 24 Feb 2026 01:56:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6PR5cRSSaq5V3NM5M3kISet2Dl9DMkeqRxz2AWRn+8TA8sGMIzcmGsKGRWhl5dYbf08sCXOhpOalLVFC4HDnoIPpZd9zhxUAUmzk4zE8XYDw6Z5VGUXnaVJ18dj/ABb5mQhb3bSEHx0UHQlDW6Y2evPvnDaZYq2NgLWlcPrFdO66FntJxyA9ZxXJvpcoRG7mB70mzVX+KeNPo+HLm+3dLLEHmtIOrTbZMqWCUopsT4uO2yNsUCVVAlH5G2w196wBhO5rl5dupFkbwkTytLDkW+7iDouQapKnms8X4Yoh0dVUUDBV0ythi5ppIneW/xAcKRtZkXOnvs2yNOZwmdZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAhaFt4rCfCt0CBFA240zsVvKXWCFcXbjAPPbhf/fCQ=;
 b=qj+zZXOEeq+TU9Wy4mjsgMOxq3tnMW99ca492it8N4xHsKy4lECp+pn84aoTwJKPw002PuL1g+wE4Knb2SsGcFeU8WueoiSiV4leoSJy/gLVPEdtG+nxTwUXn3BsJnwE4XVUyqanwEqJwA/u4MVqxoiItYy+vhBdPj8nWhc8YwanQ+dMpiG7xSkRx2PxxvY7CLoLs4kPEEKQr9IqgquYPS48YMwWTspNr/q2X6hlI+KQ6RtaqB6kjw3Vwkr6ijiKAE0sd5Di2tP0iCgRfBeSfQ7AmDYKWKaeXKrVAEUXXpj+v/lAYp8tAPk8tWkoi7i2tmItLnMcvKy0ri89aoW8bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAhaFt4rCfCt0CBFA240zsVvKXWCFcXbjAPPbhf/fCQ=;
 b=EZG2LrCz+cvJkIYk/ZQRwO5Af2ZX6SREKtw4oKtrfc5Q8n+MLJJKIWyLiGO2LtLxe9VsnHkTbf0x9IgY4cE7p2t+6XqiN2Tac0sClA5WOmd7hwebi36Du8yxyhGekyRbGsgJ1lA9dEiFvfvF8/3sBAgZi3h2zYxbbA5+M3iXOQ9qCQzZ/BOFogxw8E5JtWstznxk6lL/5EK3Bzpqn2nVtaaaRFOszC2DLqe/kuWdFuTSHX7JQKJrwXDctBrG/0z8zgKkNKb8V5aAxixb2dtezVNmW9JGq3pZ5b3SlF5ADJY8ejEdRw3u3dFce/JcOLPiWYqHYZxPtDjk/WMZzOTydg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 06:56:11 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:56:11 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?Windows-1252?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v3 09/15] hw/arm/ast27x0: Share FMC controller with SSP and TSP
Thread-Topic: [PATCH v3 09/15] hw/arm/ast27x0: Share FMC controller with SSP
 and TSP
Thread-Index: AQHcpVqoLT3TLepfyEqLMEaddPDyBw==
Date: Tue, 24 Feb 2026 06:56:09 +0000
Message-ID: <20260224065556.3847942-10-jamin_lin@aspeedtech.com>
References: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6109:EE_
x-ms-office365-filtering-correlation-id: e71a3867-bde7-4af0-6c1e-08de7371cb35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?Windows-1252?Q?lcF5fBiIB7qvMLHacUuoOpYpoF6Utu0E09ajAUCyiGnz3zRocC6Oo01n?=
 =?Windows-1252?Q?94L0SOKXXtK5l8pIuM/4UbZ5mTaECexqBP+hSDxe5S/wgCCVAkPzXdke?=
 =?Windows-1252?Q?SrY3kMdPcsj4xkh8uKJeLUFnY87eIBnlhmhcw1pAZOq0+FpsgzzolzXs?=
 =?Windows-1252?Q?SCZBhusB6oJI0Rn+ztWWIEF9W+7f6xcYR1/fIXqTeN9sZbeLMaF1M8UH?=
 =?Windows-1252?Q?ykkgQDr1ZWSORdV/7B9d3dTko1P//b6StZB8oob/jrtA2nfOARz3UbR9?=
 =?Windows-1252?Q?NseuH+SJQxeJj2XYmFnDD1WSsmDmF3bpJKl3fNcO3bDu/43MqQ9yJkb4?=
 =?Windows-1252?Q?t7XqdOqMGICWWpbhd/9gzhJRBRTYNpJMU1wywHR/tnjKX7Rgh8MEee/0?=
 =?Windows-1252?Q?NPgZ4Fn92A4cVTlSxTUSVX0eZ0J18twLWA7y2JnEKsqNj81yfsrlGxam?=
 =?Windows-1252?Q?jlqo6yG/PYzyzYlvOtVMvUd2vLg8BrVTh7fm+rW9neL7KPp1/cOfDzyw?=
 =?Windows-1252?Q?dNLboaSfvo08rfrKZVWhIkmbs+/PrTcDywc+ociEK9yjH4JL+0HB6PNB?=
 =?Windows-1252?Q?I1e6NktfwvqynuNyag3N0K1AZD86xIxk8nYV8hebfN41+cyOyk0mzyIi?=
 =?Windows-1252?Q?hA8vNl6f3z4FBa5hSjgUP9d0dMrXuUbBVsS3LQFU06J1p5YWlRnQH3FY?=
 =?Windows-1252?Q?3q/z59oDH3PMS4iM3tRe5/BGdgtqeCz0kK0FFJa20f5BeXpzv6QJdgRe?=
 =?Windows-1252?Q?x7pXPWGA9ldNzFhPwq9MYMDjP9PG6ohwTcE0kb9ZqDds8WZbGb7ynS7S?=
 =?Windows-1252?Q?ASy/U1EOqk8R8oblAXsrd/9nu6sDBqof/5i7gyEA0C0JPwMI/PPXviOz?=
 =?Windows-1252?Q?Oh7Pi75PHPr2i/HpyPz8MFQPDVimdRX3ksn3Z2DnSxzEp52Dl17lDj5e?=
 =?Windows-1252?Q?glw6jQUfOnZXM+JXEknTm56d4XB+IAYlsY83a2j9jzYcFQ0nk5nHxFum?=
 =?Windows-1252?Q?l/b7LXNkZpe7tbfs96PfY/NkV7MgXnQwiVoosm3vQV/yM/4Kreeg6Zet?=
 =?Windows-1252?Q?CFIDIrOm/QAhbF6tBGpD5irF5r3YcULfvGjJzAk4qk8VYjLg8He0iOo3?=
 =?Windows-1252?Q?U+uDV8kHMAmnfNl6ojfQ8rVkScK6XcLhl/fVFRi3iX5DW09YgJ+pn6/Q?=
 =?Windows-1252?Q?QiGjtm7kmTISk5b1a8P2ogQFLgNa294ffl9xKD+dj2XVXW0508yxGX1X?=
 =?Windows-1252?Q?fgRQNSH7IOV+wA+UdrcwnwU7w1IWJN3lyz7XXLBft+9y2vcsHyHC2N47?=
 =?Windows-1252?Q?ZOZ8S+DSSweJGC9zjL+zpBjxk/5TrvHlQjX3V9VFLEuKRFEzsQT/J9H7?=
 =?Windows-1252?Q?ljCM8VCgiwhKnqvWDPPT8UNeymxhVZdCVY82uNX6SaWZA5UCrryPAcN8?=
 =?Windows-1252?Q?BbxREtlGbXujso8UdnwoLhSyt88Cr8olV/SnaTt0VgmNXsH8ivAv1deK?=
 =?Windows-1252?Q?sxXslm6QywC00RAIB0pTEcnzpqYa2yaaehyC5J5KsjoLCN3USS0Jxrh1?=
 =?Windows-1252?Q?+EaZuB82MZFZXXFO4P/XcuX0cneaAnOwlY6H2lhHiIbhLzU5poih55eo?=
 =?Windows-1252?Q?YBa8KHlHfcuNqKl2h3/YMv0kTyDd83p6OdGCLZS7wjIJAfWvqBVZmrht?=
 =?Windows-1252?Q?vg5TBK2pEbYm8cbqBtVp8zCKasmciZ/csO3qSXUeMS/Pjwdsc5mWK2Yn?=
 =?Windows-1252?Q?XvCzVmEl7W9WirjiM2UjLtNIGv2lTSUIej6tgNIB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?xOimel6doDzpI52ZBsAddbYA310tT4/E5kkH7hSxVgOmiUswMV7/QE+w?=
 =?Windows-1252?Q?0zGUyw66g8bmp1BZ93b7KcV8y43yXEcnJUbGz3RUgyAlZsYae+f4Yji9?=
 =?Windows-1252?Q?GERIN/qm7kZup9T1cOFnO0AoaFpHdy60jRwG6bouBoBqByyCd6z4JKXj?=
 =?Windows-1252?Q?aCZ0m/wQo6PQNq61qPbZZyBkivVLJLp6F8gSsvxHJbBM3bsjJRoNlP7t?=
 =?Windows-1252?Q?mqnntqSgIGvEm8Pwy4asMFiVt73l7Jdqaidfb1QwOAkuIvpIOsFN71Ft?=
 =?Windows-1252?Q?2lpYrm4aPcLjKRs7WX//zS27FgDvOJtxE5bau4xPgoEbQxtlrNXyOrsC?=
 =?Windows-1252?Q?krkTmhtdm5YgTJwPjGHTu439P42fp1tVRjDRgBM5vSf4ThsJenHOO/Lh?=
 =?Windows-1252?Q?Lc4mLEQ1NyOJopmu8H0qxuXiuYs1bj244PubPNKiwDOTGkcVCwRy2Z8b?=
 =?Windows-1252?Q?oTg2p8ONVrZSg/qlNOCtfLk4iCbEZnY+eZua7meLoiKGFxOdn2KPxKGz?=
 =?Windows-1252?Q?+lh+7SlMvsn3k5C1mpLB67EhG8isG4lEWMbDSlsHAY5GPu49xhoS4Ki5?=
 =?Windows-1252?Q?jurFRI5xpHmjV3SnDW8eTSZUKpYh3nWzYRTfw33Dy8PmOuUUW9getLuK?=
 =?Windows-1252?Q?OU/jAC9fxAjUlXp5WpJxjOxya3qlIKr+cX3fYjnnH+PklYQSTUwv1viY?=
 =?Windows-1252?Q?ZzPT2XuTxzE/W2aa4Pas+ONqJ/Hgb+OtdEP8XU294+WtcDYR3rUCaIWV?=
 =?Windows-1252?Q?ajOHpe7r3z652qP7BEvAtZccux9vyLYtIIqTLPaApcW8FjcHrEuWCrrY?=
 =?Windows-1252?Q?afmUcbeeAvNJfdTgeSGpDI1wcStAr5bi5S9qixm7Xs2XovpkwXDe8Oa8?=
 =?Windows-1252?Q?A1H5EE7S/xhAyuF7C09ytMMBosbHfZirjhfvGHbbhViz37502HwvJAbm?=
 =?Windows-1252?Q?eLUSrAtTmtR+IAd6uXLnj8XWF8tVJcS2sgjJXBlUCqQR+L73iQb+74cQ?=
 =?Windows-1252?Q?LYBjW8kv/ZgyCmlm1qAj1RbmWr0//UcmHTfIJyiH+nUZcpijkiJrrWs3?=
 =?Windows-1252?Q?icHaYi5lrzsOL9GYk88w9mwD1sf+P8NzFPkw4DoMnU/ugRLfsP2iZa6Q?=
 =?Windows-1252?Q?F9hows9dOs8kTEEF+xaLfFj+ovpQghVsx6h8CaKN/1+lp7pfOplcJdJ9?=
 =?Windows-1252?Q?a/fBmu8+/b+ZFKMysBBHymK4wBIId0uLLMgmrjUAW2OcUUqEMphnEs2p?=
 =?Windows-1252?Q?YfM8i9jC1Yo5eGNSxiGxF0be227Fosx/KsFti6LTuB0e8yeemFnAY8+Q?=
 =?Windows-1252?Q?D2NhSmGeXPxS/rs9AIKSvyL2MqOXYFOYnzxJlFHdiqMMOvi/3MlNCwj6?=
 =?Windows-1252?Q?Z8ErJHJZikhcDDu9bI8aaCp73H+IugATiMzoxlTQ8mXoKoqftReHjDOU?=
 =?Windows-1252?Q?TGlEbhBCWdd2CCXo8/NtFS5R6l5MCJCeu3EPCqmETWOWwdp6kSFUVTRO?=
 =?Windows-1252?Q?mdk+3TxaAaxKUqMFUQAR0E/D/WKtDAtFnr1GfxrZwMXB/f8GpoeOHY7u?=
 =?Windows-1252?Q?88K/QI9Muz5bbp2J7lDjCywKlhTLZMQw0vcG3/JBhlu4SIAjT57z2djX?=
 =?Windows-1252?Q?rK6oErd/jHGdL02B+kaPN06hkkE+YV1InqjEOweKitAIHHKi4NHPJp3G?=
 =?Windows-1252?Q?BX60boE4kt8FGp8jDCCyyLModg+hBrDlnM1f0IVnxHII47Fpj75B9R/+?=
 =?Windows-1252?Q?SAGwOHqqBg/r9jKYlg0txgZ7fS8tfzLNEIcBDnjDxI7krompBGHFO+BZ?=
 =?Windows-1252?Q?puFLVLp6/ma1/SKgYtfvmwLJndPCDGIZnWjTjJmahEuSNTq8pRFWltJL?=
 =?Windows-1252?Q?AUyeFOWGA8uFWw=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71a3867-bde7-4af0-6c1e-08de7371cb35
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:56:09.8866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fzVwmygS5nTLCJhSJCSMxGBb7Lk67K33V4+RyD7Wf9zmpEXT6oK5vAGWZZS4DOFhD5lHkc6N3iWe6a0hMB6IU64Mfw2sjpsFkhzDyL4NRE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6109
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

AST2700 provides a single FMC controller shared by the main CA35 processor=
=0A=
(PSP) and the SSP/TSP coprocessors.=0A=
=0A=
From the PSP perspective, the FMC controller is memory-mapped at=0A=
0x14000000=960x140000FF. The SSP and TSP access the same controller through=
=0A=
a different address window at 0x74000000=960x740000FF.=0A=
=0A=
This change allows the SSP and TSP SoC models to reference the existing=0A=
PSP FMC instance instead of creating independent controllers. An MMIO=0A=
alias is added in the SSP and TSP address spaces to map their FMC access=0A=
window to the shared FMC device.=0A=
=0A=
This ensures consistent FMC state across PSP, SSP, and TSP and matches=0A=
the AST2700 hardware design.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_coprocessor.h | 2 ++=0A=
 hw/arm/aspeed_ast27x0-fc.c          | 4 ++++=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 8 ++++++++=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 8 ++++++++=0A=
 hw/arm/aspeed_coprocessor_common.c  | 2 ++=0A=
 5 files changed, 24 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index 4a50f688ec..8d45c0b9bc 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -21,11 +21,13 @@ struct AspeedCoprocessorState {=0A=
     MemoryRegion sram_alias;=0A=
     MemoryRegion uart_alias;=0A=
     MemoryRegion scu_alias;=0A=
+    MemoryRegion fmc_alias;=0A=
     Clock *sysclk;=0A=
 =0A=
     AspeedSCUState *scu;=0A=
     AspeedSCUState scuio;=0A=
     AspeedTimerCtrlState timerctrl;=0A=
+    AspeedSMCState *fmc;=0A=
     SerialMM *uart;=0A=
     int uart_dev;=0A=
 };=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 38c5d06077..12bbefa825 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -161,6 +161,8 @@ static bool ast2700fc_ssp_init(MachineState *machine, E=
rror **errp)=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "scu",=0A=
                              OBJECT(&psp->scu), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->ssp), "fmc",=0A=
+                             OBJECT(&psp->fmc), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
@@ -193,6 +195,8 @@ static bool ast2700fc_tsp_init(MachineState *machine, E=
rror **errp)=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "scu",=0A=
                              OBJECT(&psp->scu), &error_abort);=0A=
+    object_property_set_link(OBJECT(&s->tsp), "fmc",=0A=
+                             OBJECT(&psp->fmc), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 4a9c8c1406..8efaaacb8f 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -26,6 +26,7 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
+    [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
@@ -255,6 +256,13 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(s->uart), 0,=0A=
                        aspeed_soc_ast27x0ssp_get_irq(s, s->uart_dev));=0A=
 =0A=
+    /* FMC */=0A=
+    memory_region_init_alias(&s->fmc_alias, OBJECT(s), "fmc.alias",=0A=
+                             &s->fmc->mmio, 0,=0A=
+                             memory_region_size(&s->fmc->mmio));=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],=0A=
+                                &s->fmc_alias);=0A=
+=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl)=
,=0A=
                                   "aspeed.timerctrl",=0A=
                                   sc->memmap[ASPEED_DEV_TIMER1], 0x200);=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 6c0f166a34..b7ad828528 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -26,6 +26,7 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
     [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
     [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
+    [ASPEED_DEV_FMC]       =3D  0x74000000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
     [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
@@ -252,6 +253,13 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(s->uart), 0,=0A=
                        aspeed_soc_ast27x0tsp_get_irq(s, s->uart_dev));=0A=
 =0A=
+    /* FMC */=0A=
+    memory_region_init_alias(&s->fmc_alias, OBJECT(s), "fmc.alias",=0A=
+                             &s->fmc->mmio, 0,=0A=
+                             memory_region_size(&s->fmc->mmio));=0A=
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_FMC],=0A=
+                                &s->fmc_alias);=0A=
+=0A=
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->timerctrl)=
,=0A=
                                   "aspeed.timerctrl",=0A=
                                   sc->memmap[ASPEED_DEV_TIMER1], 0x200);=
=0A=
diff --git a/hw/arm/aspeed_coprocessor_common.c b/hw/arm/aspeed_coprocessor=
_common.c=0A=
index a0a4c73d08..c57fae86a4 100644=0A=
--- a/hw/arm/aspeed_coprocessor_common.c=0A=
+++ b/hw/arm/aspeed_coprocessor_common.c=0A=
@@ -32,6 +32,8 @@ static const Property aspeed_coprocessor_properties[] =3D=
 {=0A=
     DEFINE_PROP_LINK("uart", AspeedCoprocessorState, uart, TYPE_SERIAL_MM,=
=0A=
                      SerialMM *),=0A=
     DEFINE_PROP_INT32("uart-dev", AspeedCoprocessorState, uart_dev, 0),=0A=
+    DEFINE_PROP_LINK("fmc", AspeedCoprocessorState, fmc, TYPE_ASPEED_SMC,=
=0A=
+                     AspeedSMCState *),=0A=
 };=0A=
 =0A=
 static void aspeed_coprocessor_class_init(ObjectClass *oc, const void *dat=
a)=0A=
-- =0A=
2.43.0=0A=

