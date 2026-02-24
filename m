Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084F2EFB7F9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6I-0001hw-D9; Tue, 24 Feb 2026 00:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6A-0001cb-3y; Tue, 24 Feb 2026 00:36:42 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul68-0001I9-CF; Tue, 24 Feb 2026 00:36:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VY4S4x7ohbs4anPcvkDEx+R7ek+3ThavEgYLL8vMUKFr7y2ztwdByAUySZWdL3Z7Bo5Az1188SZ++QbNXglYKrmNskSHH245//OnmT8kdDh8KFrB9QBCugbb2qc0W/PzY+dAXneHcpA6mnurjLAmCeL72b0R6L9rRGZ+7kJGgiuSC/PwY8RjhKHBc9RCy96YKtkJAuYl66A90bVjH0GxNPc2KL5Bun9JfAGr0jPSjFPTtghKJLM7bqFIsoj3lRGJ9N33wOXLyCObBQS/Ci5SL1qVvBdooR1cXZX1aWNjflFOqQvsYbR+qgA2gwj8MblxF12dKq3nnBt9/fdSnoepGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/AYuRkWP6BeUepikGanog70cRJ8IwLDIUKHi20W3No=;
 b=O4rSnbQFXZ8SunN7b5D45OscPZ9ll2OYM9s8Ml68/7txJcAltDsxU/k+bXvpUE1/DSGubGiGJs7hNTc6IYwuac+vw9DJIT40GCULDQ/OGOIJwISvdcZ8ZxaYmBbfkh3gyREOdzMK//pxcTeN3LrVkeD0fDE8S6PWhi0FbQpTCjJ4VtzE0NtCUPn3RfPDUt46zkaZYG8hiaWaNF3r/DpGO63D760pvnhh2UhnSWQMC4Uyk1zBPlaZEPVC85DULfh+ZhN0wXq7J0FbM3QbCGE3fqH5eXO6yUJi+8gtwSwTtRAPmgQKe+0Y5yYeLi23Ej1boNzWdqfhDeg6R98ANdFFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/AYuRkWP6BeUepikGanog70cRJ8IwLDIUKHi20W3No=;
 b=d1RpUXxMSE7B4OTZNH67Vf7TEsB1voblJTrG1gjUNY+U2KYlYn+i4doue00DHNXVbV5oAU3s6w8m2T+mOT0RRZJsWsiBod0lfroZn811JELjlaY4qyfwoZhktiUSLtdJtUArYzV7UtLsVnUUG98tpIsIg3Ma8wr++yO9U0M6HBL1bYJluiaysPuUTzoE8BXGY8vmJ8B5B2LoakDzcLVsyNfBUpbfsakhm4gNM8Q7YoaVakf5RNz2j7jWDj52GhaqkzPTo8h8sHzfpXV7SBWWbv5Ok0gEMfSHZtJxIoTObngRKZ2CzuIggYNsTRUlm5eo9vCfhc+rIVMUTGXB8cx+9A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5004.apcprd06.prod.outlook.com (2603:1096:400:1cb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:27 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:27 +0000
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
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Patrick
 Venture <venture@google.com>
Subject: [PATCH v6 09/22] hw/i3c/dw-i3c: Add register RO field masks
Thread-Topic: [PATCH v6 09/22] hw/i3c/dw-i3c: Add register RO field masks
Thread-Index: AQHcpU+FSuHVoeR16Eie5yPqSyFTzA==
Date: Tue, 24 Feb 2026 05:36:27 +0000
Message-ID: <20260224053613.589102-10-jamin_lin@aspeedtech.com>
References: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224053613.589102-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB5004:EE_
x-ms-office365-filtering-correlation-id: 06abd0e2-2169-4a28-220a-08de7366a814
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?DfoWJnVnm6QghIPKAJK+9B2gSImQ937WZ0uAgOf5DJRP1TtOORJ5k8gctX?=
 =?iso-8859-1?Q?jDuOVurarxHWJfuGSu+Ycllh7u2MzDHvKJzM5k/56t59/W4aN4j0ZlxdYU?=
 =?iso-8859-1?Q?Tevu40+hWuZZ6fE3NgGZQemgkRpFUHmr3qVhsAcvQU1gLPmWa49Tgym7yu?=
 =?iso-8859-1?Q?l326SLpx3wtyjJRFQVBRcqz1jtduq9NvljmET832OJ6hZWtZW+/FHqiuxq?=
 =?iso-8859-1?Q?DwVwyDQjWXZWfQivjrc3x0OTX6mn7J6Hx0CzpyT1XMQxCJZXKRa+YaqWXr?=
 =?iso-8859-1?Q?BYKOzDgwHAY2vlfd5yGJD6Bs74XTIxd+zk2yAe+dPT8hJ4phjmbrhxPRj1?=
 =?iso-8859-1?Q?eQqKDHXCVsW2B3tQpqaVgdhPmXDpnKDfOrsRX2FCKEoJtEAggexwuyVh7s?=
 =?iso-8859-1?Q?ZIALpor6kUNHWiKIkp+yN5g6MDEC5w54Wbyb+teEteK68ImYmMTMZNpy3o?=
 =?iso-8859-1?Q?fXqHpDNuKqhuxJZ7JBOh26UyS6bmzMWFJgVXzB7zJ8Jf+WeX6AjtVCisA5?=
 =?iso-8859-1?Q?QjtuZyzC8ST3OEeW5RdgSmApEIxmEGX/sQy+p8EfO9zPDsrKLzIM/7IU0V?=
 =?iso-8859-1?Q?D7OOiYci6EsWubjBuq8tOtrUzzFCYULeOVwuCAHqkCwqDe3+WDGyyvTQpy?=
 =?iso-8859-1?Q?RXJkWeFNLzscK2RoCJ1+/9TphxeuRtYl5zXDbKfH0gbzPHNOt82qYyka45?=
 =?iso-8859-1?Q?B2zs+d9X3T/CuKAXEwydoEQ6ey98c2yifhhNrvAgAF63tUgCHgDYCx6UxF?=
 =?iso-8859-1?Q?0xDOYGPNrb+RZC/7JEMfdxAUMttI+jk/poEsfHmMsbutyE0nFI+3XHgLis?=
 =?iso-8859-1?Q?9Dt3WFec711ImG/zRTfjR8tS1r70m4m8G4f6pNrF3Cyos+zqlIdNjlG1WO?=
 =?iso-8859-1?Q?fgsmmpu5ZeFRSLjJz6OUEIIYDSh9ItCJSW5Q6GdAUI9eXAju0ouBkeV+ZD?=
 =?iso-8859-1?Q?7h6dgWTBKtjWZCao2JlP73U725odHDhoVur4YEbGfaJG5/zpqHrAy23K4g?=
 =?iso-8859-1?Q?Tjt1zPyi7ocxcm8vU+ugIHnLSknpfCb8A7Bd+hAVmQbQHpfjYLHh6NQGp4?=
 =?iso-8859-1?Q?+UAMIeRH2ILkFErXCWG518SZb/92n5FPHt3iBX3/kKoGi73zxJDJ5deWhK?=
 =?iso-8859-1?Q?UEZCjZjixyj5/mTL8+VIFbbMpJwFHxrHe+YnQdWRXpuleB+gI65a6gwd9x?=
 =?iso-8859-1?Q?22GEjCSnQwXQKU1iE+3w7bP7rauNXOE+NcsiKphUJzhx8gBEAtiVU60FGA?=
 =?iso-8859-1?Q?ZaUG+DvOK2m1CizlT7+rgumgYyuzfsKs9OOZpDliCLPhufGG0t6UF1RLTT?=
 =?iso-8859-1?Q?qTxXZp8IEsA/aASD1vBfWqDy37sTMMx6RU6LBHY4LUgGVxTzxEf8+W387m?=
 =?iso-8859-1?Q?kQTDodtoSHUPpv8QHcs1ZVjbKnpott1wdO0Y6otZjqhjdHoA6cZXUu0gBY?=
 =?iso-8859-1?Q?+6CgwfOeryfj0Sme5d2zTxd6EcPdD99tXdjavqUsSHGrsleiNu8BCyYCJ1?=
 =?iso-8859-1?Q?uTvLeYNNIImd30sc5y3y/OO+iPcr2ohPtoQ0Y6p5mrnljzQP1gke6PvF7i?=
 =?iso-8859-1?Q?mkHxp52WS5q5XpLA4WXURXeYJv6/Kn4Ju267RZG7abBuPXTMRGcke2wKgl?=
 =?iso-8859-1?Q?/JphMEx+AtuD6b3BgicOroIcuU+WaxaanNNC0bm/pOHFDck1gUkM9+IgX0?=
 =?iso-8859-1?Q?fZhgT7v8TdBaNaD72Wn/vVA+TTjirhY1pdwxOxyd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?COEkI3FPHDqEtuH27x8ZiI5QQJWEwvC2fwFEE/kOfbt91Xep1cgwIdx17x?=
 =?iso-8859-1?Q?u9h7b/KgN6PxfA+8tJGId6M4ncFy+tdtRxVe2UgyjF7BEgfA6cTej5/efQ?=
 =?iso-8859-1?Q?R85M4Yl4lHwf8rNuVu/LiLQExvArSxVUEw2AJEdj17B66tloN8DV7UWC3F?=
 =?iso-8859-1?Q?MXojgi1nx6e2B6DvNJci3l1RblwwDxvA9he9Gi+b5W30GDJpuH/MYm5OhA?=
 =?iso-8859-1?Q?PxjRxYXL11SkQHCdDaBE1sujzUofqWtWNfV6pMUTsj3jX76pMH7yY+DFF7?=
 =?iso-8859-1?Q?fv9xWamgtRlVZ0zcqCifrZnBc5RVZtUJQWjYjdmZtWe1XHEZlFt2l7acPo?=
 =?iso-8859-1?Q?Xl7wq3d9FUGP75ljGUG7k0y3cvjIBp/Lj7xZJJwGNgbPCo9lCmLbJGEIQw?=
 =?iso-8859-1?Q?yLNgfBH/UwwMjA3k3raaPD+mMUf9uVQbH098Xl0ENS+OExAIF5doju5ZLF?=
 =?iso-8859-1?Q?P6/cMTI6QVjW5KavTo25fH/NjuuqiTsuoh5v5WM8VpZPqdjqaehIiN6EaY?=
 =?iso-8859-1?Q?+ZrB28sM6ZjpIdWWjzBS39Dx95KLuCFTpa/1NX5OcGL+ajcfy/2JvwTAoi?=
 =?iso-8859-1?Q?yBPaVGRZmcQbd8np0zxXUdS2i5rODkZspr0u1GYr0aVAQnPtnNiiXaucwc?=
 =?iso-8859-1?Q?hFbH05wVsSWFFq9t3gatbis2grZQTsNphre0eIQrS7yXUQlSgGzmhQK83Y?=
 =?iso-8859-1?Q?1dPgQjOHOmvBMZMaRgRSNhvX/CNm/mbyB+ruvqnPfm8k9YZkklCV0ntnCd?=
 =?iso-8859-1?Q?X8DzBlGiZikwykYKQVUCTj/PNj3x5+IPIE8VaYypAgDJY0YpUOzPCMkVd1?=
 =?iso-8859-1?Q?P5TwXFzdU0JEVzcsxIM+F2iJXgjSNebACjoa03euqv6Bo7ICGUlMzzRPso?=
 =?iso-8859-1?Q?kFh3dTHdlC5OmupK/rp+fg36cmgmsPo4Wp5H89z3fEHSb3hBkamQ7WfWxU?=
 =?iso-8859-1?Q?EJxQ5xb3JrN0SSte0ymhNVuN7giJIjWgF6gIHI7wVMvh8hf9lpqdimm59S?=
 =?iso-8859-1?Q?OEnrYNxUKAr+xFyHDjdgCAR9ek+K1rWStfQpVW1oW9p46S06feUHlAb9EC?=
 =?iso-8859-1?Q?anloobpn+hbAIuB8cfXZI50uOKSchrhgMaN++Ll+X9eBo+0yJyicFwYYSe?=
 =?iso-8859-1?Q?PVe2Hn9eQ6JRiddV7BS59MQ/669+7cMtnH/njEOoBfjkXdv9g8oRJCIa6B?=
 =?iso-8859-1?Q?amek3GU0JYg/Cn0PJj0t2Uuq2D/3jKnfByE1qZhn84Q5UC28gWjBh6lKQu?=
 =?iso-8859-1?Q?YRqGz6FfN4bV3EV9Mw5ZVMyWwuhg5diDo3Fi40j3FfO2FnGButzSmQe60r?=
 =?iso-8859-1?Q?Eh4Yh/gVS6KdmgML0cktOo9vYXgISQ6JgoBl1NROEfpUjOlqAcnO8yH2Xp?=
 =?iso-8859-1?Q?EWfc+vOWlg8ou8MGlAd8XpAYqcet45Aq9K1AT4LquxzK+5TpvCqI9NvuBw?=
 =?iso-8859-1?Q?fusEUPll0v8bInqLXMw+21+DTWtFk/+JK8G6Zc1X0pstURqU8cHSV2+MgY?=
 =?iso-8859-1?Q?O3Zt6lPXUvICMHjzJIZ+pZr7EEmdp2wjeyGA2OwlosJEFO5Q47xWrPq1hr?=
 =?iso-8859-1?Q?pHzkFr9Tbhh1w78MZryLPlSbXURDCB4cF9B/3YTQ431V+wB56zY9LEuciu?=
 =?iso-8859-1?Q?KKdGoS5+rTfEQhyBdVnoiyzUUViUJ7mPgO2ZFtM7NQunKynTI/DD50/4Zv?=
 =?iso-8859-1?Q?B8utvtQ7h61KBFMRUzwPS8m+8owlcu+V3/u3aT2YAo4Ksv5K0aXXJqSxJs?=
 =?iso-8859-1?Q?/NewY0rTkBGsJZyGygHfoi+/TY6k4q2Yxc33zp1AkTct16liKBnHclN48E?=
 =?iso-8859-1?Q?AgRDWEgzSQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06abd0e2-2169-4a28-220a-08de7366a814
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:27.6733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2d6fe2Q/7RJdvUY8Gz0UkB3AFknuAzBIRyk0uC2lO2d3ntQfo0EuK6qP7X6uicE2kvKF3MqULs4nQZ7wVnyzegt8+rLMrYAhXYU72IOFxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5004
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

Adds read-only register masks for the DwC I3C controller.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 40 ++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 40 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 28da6016a1..87c8f63da9 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -296,6 +296,45 @@ static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] =
=3D {=0A=
     [R_SLAVE_CONFIG]                =3D 0x00000023,=0A=
 };=0A=
 =0A=
+static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] =3D {=0A=
+    [R_DEVICE_CTRL]                 =3D 0x04fffe00,=0A=
+    [R_DEVICE_ADDR]                 =3D 0x7f807f80,=0A=
+    [R_HW_CAPABILITY]               =3D 0xffffffff,=0A=
+    [R_IBI_QUEUE_STATUS]            =3D 0xffffffff,=0A=
+    [R_DATA_BUFFER_THLD_CTRL]       =3D 0xf8f8f8f8,=0A=
+    [R_IBI_QUEUE_CTRL]              =3D 0xfffffff0,=0A=
+    [R_RESET_CTRL]                  =3D 0xffffffc0,=0A=
+    [R_SLV_EVENT_CTRL]              =3D 0xffffff3f,=0A=
+    [R_INTR_STATUS]                 =3D 0xffff809f,=0A=
+    [R_INTR_STATUS_EN]              =3D 0xffff8080,=0A=
+    [R_INTR_SIGNAL_EN]              =3D 0xffff8080,=0A=
+    [R_INTR_FORCE]                  =3D 0xffff8000,=0A=
+    [R_QUEUE_STATUS_LEVEL]          =3D 0xffffffff,=0A=
+    [R_DATA_BUFFER_STATUS_LEVEL]    =3D 0xffffffff,=0A=
+    [R_PRESENT_STATE]               =3D 0xffffffff,=0A=
+    [R_CCC_DEVICE_STATUS]           =3D 0xffffffff,=0A=
+    [R_I3C_VER_ID]                  =3D 0xffffffff,=0A=
+    [R_I3C_VER_TYPE]                =3D 0xffffffff,=0A=
+    [R_DEVICE_ADDR_TABLE_POINTER]   =3D 0xffffffff,=0A=
+    [R_DEV_CHAR_TABLE_POINTER]      =3D 0xffcbffff,=0A=
+    [R_SLV_PID_VALUE]               =3D 0xffff0fff,=0A=
+    [R_SLV_CHAR_CTRL]               =3D 0xffffffff,=0A=
+    [A_VENDOR_SPECIFIC_REG_POINTER] =3D 0xffffffff,=0A=
+    [R_SLV_MAX_LEN]                 =3D 0xffffffff,=0A=
+    [R_MAX_READ_TURNAROUND]         =3D 0xffffffff,=0A=
+    [R_MAX_DATA_SPEED]              =3D 0xffffffff,=0A=
+    [R_SLV_INTR_REQ]                =3D 0xfffffff0,=0A=
+    [R_SLV_TSX_SYMBL_TIMING]        =3D 0xffffffc0,=0A=
+    [R_DEVICE_CTRL_EXTENDED]        =3D 0xfffffff8,=0A=
+    [R_SCL_I3C_OD_TIMING]           =3D 0xff00ff00,=0A=
+    [R_SCL_I3C_PP_TIMING]           =3D 0xff00ff00,=0A=
+    [R_SCL_I2C_FMP_TIMING]          =3D 0xff000000,=0A=
+    [R_SCL_EXT_TERMN_LCNT_TIMING]   =3D 0x0000fff0,=0A=
+    [R_BUS_IDLE_TIMING]             =3D 0xfff00000,=0A=
+    [R_EXTENDED_CAPABILITY]         =3D 0xffffffff,=0A=
+    [R_SLAVE_CONFIG]                =3D 0xffffffff,=0A=
+};=0A=
+=0A=
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
 {=0A=
     DWI3C *s =3D DW_I3C(opaque);=0A=
@@ -324,6 +363,7 @@ static void dw_i3c_write(void *opaque, hwaddr offset, u=
int64_t value,=0A=
 =0A=
     trace_dw_i3c_write(s->id, offset, value);=0A=
 =0A=
+    value &=3D ~dw_i3c_ro[addr];=0A=
     switch (addr) {=0A=
     case R_HW_CAPABILITY:=0A=
     case R_RESPONSE_QUEUE_PORT:=0A=
-- =0A=
2.43.0=0A=

