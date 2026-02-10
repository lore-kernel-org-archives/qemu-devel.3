Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66ED2EA3F07
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 05:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpg1M-00037r-Gh; Tue, 10 Feb 2026 00:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg12-0002xN-Gv; Tue, 10 Feb 2026 00:10:25 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpg0z-0000Go-Mw; Tue, 10 Feb 2026 00:10:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fe7b0iQkrHHRQKzaF/LnLEzYiuvH3KNly4f1qSUKkxbQ7snP4g5+s8b+7/KnqDDr877jEs6eYPKFsrEmtxRf8yqnjVdM2lcjMO2tSS2+QUTq4FwjXZvVH6vR5KIPuFS6U5xaMbn/ahdoIkp85Udfb9UrI29wev0iD6Hrg/Ho0+Mj09yX9e7QF4mnWUjPWvoAefa80vA+C0Hr8b5+5By65i31S6K4CmKoO/a2uwKZj/+F+zzdoG63p0EXreq0F99diorNnKinaiNsPcHyO481LVsKlBsZe5m5phdXNF+hA0FIdF973g0itEoXTGsb0PJpzFqXeZzZ29QjqjtmPVt3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmGGY7ZM9SoPeO0QJbVngr0roo6kNCrGw7Kfg2vzK4w=;
 b=RKhgwlwIaMuofvhECpraANv1OqLevTEZFO9UD/k0BAygSRUhF63zDjLD+wjGnH5C6mgw0fOd9gvb2YFwkX75B/yD/ONRlkJcSPIHcqFN3xK/w1/eb58ZCuIccYEYY604iM8Yl0eeHNj++Ca3Fw3l7dbpOVwbZhGM0HuFL8Aw/EznHGJK21WbztE5G4ReAW1aFqPYz40gGo79GKQ7nMN+gRxGTRU+QJvG5Mvpa+g0kHC/qoxegfWcTDsqTKR7UDMgAcQUiGQuROS4BxV/nwDh69Jn/C7NtW9CD7rCOACYmtDzapoIU3bCjfzagTo6w5SdidpqoJCm7lqXeVyRLsDR5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmGGY7ZM9SoPeO0QJbVngr0roo6kNCrGw7Kfg2vzK4w=;
 b=m+L0HopXMbB3Jpsiuw0Amj/DNM2rz32ZXdZVsPB0Pnv48FtSFG1VnAcXkPLmRUbqB6DpppDuPE23dcUcF3YaIEWE7nXixvvFcZfHcGAZBrsSE8YVjp21ppBicQvhhHrYoJ4sUiM1hKkqU4jNeEYGqs1nnJfeBasfk8P1HYWHZGr5Wih8L/MRblA3zR8dbXMtZbc8zWK/uNuKL+Zv2sc6/sptPqRNFm4zMqF0NzZMOb4fy7H8cpIDEKK4DhzO8m2hwPgWP7afr/DL3I9TbumdLlmgeUiEucP7y+gOHR5M9zQWoC3H+QDrtszY8G7BYLh6uNk1InYG/I9RLK9aXMjcwA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY1PPF9851F8D71.apcprd06.prod.outlook.com (2603:1096:408::91f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 10 Feb
 2026 05:10:13 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 05:10:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v2 03/11] hw/arm/aspeed_ast27x0: Add AST2700 A2 SoC support
Thread-Topic: [PATCH v2 03/11] hw/arm/aspeed_ast27x0: Add AST2700 A2 SoC
 support
Thread-Index: AQHcmkuJGA0ek+Ji00Sq1XxMG9WgFA==
Date: Tue, 10 Feb 2026 05:10:12 +0000
Message-ID: <20260210051008.355149-4-jamin_lin@aspeedtech.com>
References: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210051008.355149-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY1PPF9851F8D71:EE_
x-ms-office365-filtering-correlation-id: 2589ed8f-2e8e-4afa-31ba-08de6862abc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?50KmFJsXWVOrNJhjk0oybZMg68OyfpWZ5Lj2UeOvAtXH8L33F96MkPbsMd?=
 =?iso-8859-1?Q?zTHWiwQd+v9ZjjMDBwEybrCEId5TNj+IU0sVRfRDDr4yd/8omrO//hoXmb?=
 =?iso-8859-1?Q?fyGrZhhKG6c9GqvxPh4zSjceKcon5L5wmZF31p3QecYMvQHN52f3grplbR?=
 =?iso-8859-1?Q?SOqHe7yjwEhbuT+cVkOG64kcdET+TCPeaNE4XxWwWSPXBDmjGs/9JhOFxb?=
 =?iso-8859-1?Q?w7ctQLLqzxONim3C5Xfj278DCj4RA+frkgB3nOSvvF5OxNxWyOd1nHQuYm?=
 =?iso-8859-1?Q?yKpI8LQvkTaXDOU6bP/flkP2qXd5174wArw271Oz8HX/zMSST/czy1qMNZ?=
 =?iso-8859-1?Q?Yd+r7ebpadHGeCMc0woC7G8t+TZ/2+er2sPkj1+2ykNfY+x+tIXck6n42I?=
 =?iso-8859-1?Q?lAx80Xf6aqszUcLaZm1nZvWpVXWVrczSRU6PUuBo5OC3I3BoHgH0yn522x?=
 =?iso-8859-1?Q?HxEZo7LNRnKcrN8hivQMlO6sOBpuTLEhqYjyekERg4bxk/vS/0lvtF3N5F?=
 =?iso-8859-1?Q?oYpprdSoPXjhVPu3ZSzRwY8QLfTStlrwNkTya4rajeLm/jvdjlnWq/nv5l?=
 =?iso-8859-1?Q?FwMNogUeg3TCykUt3lI82XUNvb/wcZEOUFIUF276jRQbAKVHx+nj+ulAer?=
 =?iso-8859-1?Q?8S2o4zM+FSW3ANWCjSl8bsMLV2sOUh7usbGXZ1llmpqDescuAo1jcp4do8?=
 =?iso-8859-1?Q?ucO0uKXLnTGbw1vMY9ZtX1B9vziXnqSKxGYVk5c/7zt/yZAFsQI93bLot1?=
 =?iso-8859-1?Q?mkvxSm/+YMIRp3t5By+EvCPuJHXp8EqAofS2rSUcgmrSfX1e+gumfBgtka?=
 =?iso-8859-1?Q?yP20PU+4tvVbJGRFgzU/sHvppuRjT/TiZfJ1dvstBSJu/VIYiDYSH0Ec0k?=
 =?iso-8859-1?Q?J3CmTmy4rPGsVOif/yZ/h/av6mQxzEhOZJWggpFIL3wfqhUGgkeZeqJa2Q?=
 =?iso-8859-1?Q?JiHyQGy6p/fJxekG/1ZqMjXav454fxSAK4cozIxn/II2mTYgAHNduTqImV?=
 =?iso-8859-1?Q?x6OQP5URb7g/oMZMbnQO8ltX/C7YD9bw2n4Sh5sSe3ue9XuUbV1fvplBdS?=
 =?iso-8859-1?Q?BdsxxYfXgXccEaiZS1UngIUzNjZuL6YIKlyX5uBuqf9aJ/Dclszky6ygER?=
 =?iso-8859-1?Q?vtGU8p8HAzWMUs4MYPp9xLIJAvb32d/6LhHJmWj4mmvMoc1UiehqZ9Q/Z2?=
 =?iso-8859-1?Q?1xVjDprrb2GPDr/VnGprYJXAS/SLHTRWBUDWOGnp/yUlwugfas4z6BXB7d?=
 =?iso-8859-1?Q?ynV+Ne/V2ZnijNJNMqj7dsxluk1RmHbbXhPDyNdSSz/rpQpSf9iI9Rish9?=
 =?iso-8859-1?Q?a80v0FCS6Ijobo6OMolp19D1JNoQ26l4+SLBtk7K5YNuGzgr3pLN3uWLbV?=
 =?iso-8859-1?Q?NNEut05AhN7akoa2zuYHzCSKrJjghfNrUZ+MnAuGxH6kQGotbv3WfZAiGW?=
 =?iso-8859-1?Q?bj23Vza8XneruIr46tIHo5fgZn8Fp6aEEE5Neh8CNvSgUNsXHMhBvKwkX6?=
 =?iso-8859-1?Q?nPSTXVSy4WWHLgO43vExM3BAZZij8wp/7tFbKP6YmDajne61iAYqxMkY07?=
 =?iso-8859-1?Q?x225On54QPLsVBn7xhhN6HotZvqg2CkEpsZndJqcYn1EbiV3o2IsLNcMcG?=
 =?iso-8859-1?Q?Sn914WnwcCKf3hd3PMHH9gnZvALe/2JsJcAs5wvPHJs2PSjlxZvee0R4xR?=
 =?iso-8859-1?Q?zebKwZSkN1VY/qOKX7LwUse41/Uyj9UYunSFHfPZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?coYMeyT173HWtfQjx9GD+x9kpGbe7oNqG1YLLu0c2ZnrYgVRLEDqhIzOiQ?=
 =?iso-8859-1?Q?i+bFmkf6DCWQDVp8b+XhpF7i2ysb9TB5JtrpXRQg3YEnfpQslOfIJHpaQH?=
 =?iso-8859-1?Q?AN8uXldxu0gqjpXIF1+TCTKz4jT3XsWdQBw1SMp1a7nbfB6c7L/9yL7pG0?=
 =?iso-8859-1?Q?h+/NucTvVu/ZeC8nXHdP5T/EIJx3pmc4bV43Ng5nJpdFi0VdXeMMDZCAAx?=
 =?iso-8859-1?Q?XsTinOvlOoDHVN7We1hRYVZA2nHBV4jj84+XuXafxM9hqGIoTG6SCK/qsF?=
 =?iso-8859-1?Q?OpupvQESljUbFlzo45zoTTRwknDnV1p1TPyR592tYMZ+fKr60yOhA9IBDC?=
 =?iso-8859-1?Q?m/8XmX7zhbHT3MsDQmuCysX6bYmx+w4JaSTRoTsQdCnO9Hpk+rmm98FYtL?=
 =?iso-8859-1?Q?e7bnA2k4j/cXkVT6D64+MA3RHtUgStKV0YuCGFXVPGepTjyfuzCd7ksjit?=
 =?iso-8859-1?Q?uyXCBPafW4XhLRpvht5xlAdHNjpY4Hz4/LfL1hxgsAo/cP8i8LF4R5uu8w?=
 =?iso-8859-1?Q?C791DjNnTcnEhyigtRBu4jTZVL3c1LRKKNSIOHTIx+3cz+/18GHsFb4MVZ?=
 =?iso-8859-1?Q?N4tgE01q3l9tq2/dcV0AzWQpV07ZW3/74OHGdyIAxJoaLzngRjn/a4i3Sv?=
 =?iso-8859-1?Q?8xaa+LudKOfh/o9MjLGDfl5SUqUulfCz3FtgYA3N3/h4Z8IxEdQKATVePK?=
 =?iso-8859-1?Q?BsTGnF1+32nhV+G+sBW0DxdXHTvJ4Jf51AdX+ePj3wyKTfEOjb9fmYfvkT?=
 =?iso-8859-1?Q?4a+tDu8h7XHuwv9MxxCKGr3ql4ZvrgeqDCS66t+ybQ9tOi5GXTV4yRIbsu?=
 =?iso-8859-1?Q?Ln6qKPEF5QjzjbZon23lZdr6Q2T5LB6d/HK9PSEluzcUzQT9McMmr4YC3M?=
 =?iso-8859-1?Q?BMbz3PbKqgZ8pMEp8VofFzlftjEB1sYrGa/DDYIMecYYSFjKPQ8Q+2cHkZ?=
 =?iso-8859-1?Q?gm3cRzPAWJL51lxdfT6BFTm+cJr10/jsqoZ6CLhzKB7/voY7DVTkzDCqeA?=
 =?iso-8859-1?Q?VNZ+FJ5yH5ANw6MfRCP34fAl5gTgJiJDEctlJewYQNsBeZQMP10tBmks1I?=
 =?iso-8859-1?Q?AluYH0D6eXZjxmVGLGPp9klcTsC6jHHpTix+rijOEdkFpsWT0I95o/rGu5?=
 =?iso-8859-1?Q?dHg+J5Y6Y4WVBsx0pp1skmYW+kBfbLFo7SDmH//jZoxQOBQUS5WS14IBRt?=
 =?iso-8859-1?Q?79flcBQIXpBcsYfyoeCUik4wK2JaE2gP852YmPJ8GiFvWt6MVKZJcaVf4K?=
 =?iso-8859-1?Q?LwZkwU6ciJnRBUmEDYUo4SI6kAi0FZuvUUU1Sr7x90wnVeIKlItNwW5klV?=
 =?iso-8859-1?Q?YRzuHoi+NHWNFiBi46DTsTfJOPVroxhyFDozUrPAq/f+USlWb9+T2iWiu/?=
 =?iso-8859-1?Q?bHyOHG0Wui6VALY+2Yp7POO3uIi/PbR5L8VroiJ4jvxE/lQx/dtnOzDm7y?=
 =?iso-8859-1?Q?x4GcsGt4sX6wtTdqUcpl0GqAiN9/6vo/HF9cEPsNkAustPpii/1R8K5VV1?=
 =?iso-8859-1?Q?EUjJQ0+mrEQLhKkgWz6qk83deLlfk8rncHfnMCzVL/FHIZLJSSJXhvBlTE?=
 =?iso-8859-1?Q?SiFMt/p+jFbw2VymnR5T7boYMAPgQ87xpkWEpglEavma9A2GKu+OwXCJrj?=
 =?iso-8859-1?Q?FjO02LncGyuueciYdwvr0qWsV94ge2p5AEdsVHZaqf205SjXAdiv5qlg7T?=
 =?iso-8859-1?Q?zdDo9T7hLOiof4ux09Md8Aa2dFW9K4pucHnMcZgIiN9a8BObQlAInCgOIL?=
 =?iso-8859-1?Q?SOiTRx8WQ5bcbr1iKuwd/xyMstzPlNgnTqPpGEWS5wOx6tdNpPq1jVnBns?=
 =?iso-8859-1?Q?ilvczOjpCQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2589ed8f-2e8e-4afa-31ba-08de6862abc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 05:10:13.0472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fHCDVyJPsCGqvntao/kds7auXmPQPq7j5zbZJF5Xt/7K+39Q4PQwMkMWp0Pj8Ntmhz6qKgsf9VoCAo8UisYOeHyBgWL+mZnrpBsYbGNVGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF9851F8D71
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

AST2700 A2 is functionally identical to AST2700 A1.=0A=
There are no changes to the IRQ layout, memory map, or peripheral=0A=
configuration. The only difference is the silicon revision.=0A=
=0A=
This commit introduces a dedicated AST2700 A2 SoC type by reusing=0A=
the existing AST2700 A1 implementation and setting the A2 silicon=0A=
revision accordingly.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 36 ++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 36 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 61790ea1cc..87dcb82e1b 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -1166,6 +1166,36 @@ static void aspeed_soc_ast2700a1_class_init(ObjectCl=
ass *oc, const void *data)=0A=
     sc->memmap       =3D aspeed_soc_ast2700_memmap;=0A=
 }=0A=
 =0A=
+static void aspeed_soc_ast2700a2_class_init(ObjectClass *oc, const void *d=
ata)=0A=
+{=0A=
+    static const char * const valid_cpu_types[] =3D {=0A=
+        ARM_CPU_TYPE_NAME("cortex-a35"),=0A=
+        NULL=0A=
+    };=0A=
+    DeviceClass *dc =3D DEVICE_CLASS(oc);=0A=
+    AspeedSoCClass *sc =3D ASPEED_SOC_CLASS(oc);=0A=
+=0A=
+    /* Reason: The Aspeed SoC can only be instantiated from a board */=0A=
+    dc->user_creatable =3D false;=0A=
+    dc->realize      =3D aspeed_soc_ast2700_realize;=0A=
+=0A=
+    sc->valid_cpu_types =3D valid_cpu_types;=0A=
+    sc->silicon_rev  =3D AST2700_A2_SILICON_REV;=0A=
+    sc->sram_size    =3D 0x20000;=0A=
+    sc->pcie_num     =3D 3;=0A=
+    sc->spis_num     =3D 3;=0A=
+    sc->sgpio_num    =3D 2;=0A=
+    sc->ehcis_num    =3D 4;=0A=
+    sc->wdts_num     =3D 8;=0A=
+    sc->macs_num     =3D 3;=0A=
+    sc->uarts_num    =3D 13;=0A=
+    sc->num_cpus     =3D 4;=0A=
+    sc->ioexp_num    =3D 2;=0A=
+    sc->uarts_base   =3D ASPEED_DEV_UART0;=0A=
+    sc->irqmap       =3D aspeed_soc_ast2700a1_irqmap;=0A=
+    sc->memmap       =3D aspeed_soc_ast2700_memmap;=0A=
+}=0A=
+=0A=
 static const TypeInfo aspeed_soc_ast27x0_types[] =3D {=0A=
     {=0A=
         .name           =3D TYPE_ASPEED27X0_SOC,=0A=
@@ -1179,6 +1209,12 @@ static const TypeInfo aspeed_soc_ast27x0_types[] =3D=
 {=0A=
         .instance_init  =3D aspeed_soc_ast2700_init,=0A=
         .class_init     =3D aspeed_soc_ast2700a1_class_init,=0A=
     },=0A=
+    {=0A=
+        .name           =3D "ast2700-a2",=0A=
+        .parent         =3D TYPE_ASPEED27X0_SOC,=0A=
+        .instance_init  =3D aspeed_soc_ast2700_init,=0A=
+        .class_init     =3D aspeed_soc_ast2700a2_class_init,=0A=
+    },=0A=
 };=0A=
 =0A=
 DEFINE_TYPES(aspeed_soc_ast27x0_types)=0A=
-- =0A=
2.43.0=0A=

