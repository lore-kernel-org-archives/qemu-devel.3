Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACC4E78D6F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNOK-0004nk-1k; Mon, 09 Feb 2026 04:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNOH-0004mc-KN; Mon, 09 Feb 2026 04:17:10 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNOG-0007Kt-Cc; Mon, 09 Feb 2026 04:17:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgqG4w4HS8eiozqcFlMQrmR+/VNxi4lTcyPgPI4S3TVhyL2gfeyZvw/RCRjQZ5utuxdQ3E3j0OaLdcSgFyk9jM+YSfvohBEhntJhDwrY5CohZtn1Yjm55SlcfydfPMvEu4YnUc9L+hastDdSHgW+y9Yi0jv+XsuVGqh44eg3KWGBArdrSJ1KHPSQyKeywvG8maIuJe5sMxYsFw9lwmTtHiG9ypx51avJJyPS/wb4pcLbg4gomEVPS/gCGCpITxUoP4LIBiBA3t0eQZr5Eryye8m++OpuCUDqM508LozccxYKSuje9IvhalxWKik7zdeLp90lOjD5Y0LRopxksUhrPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqnQ8AIJ+wAsb2dwMNcPSHGBFXE01d27V9qBZn9sxzA=;
 b=stsMAarI1QTlb17oI90cgI1UdhrYOl0zpS9qQN6QLfb7zl/jKX7WbrkXrBvFROqWu/qDh5lvRsqNI8GICpTpANkQCVDDTuP+UUMDvlsN8ms4MLzXxGXFSeyWBKYqqXZK6d0DjxQBfMqqYcrJwtJUaXARE0zrCC4v4iR4zHuGuUX1gmb62encGkxVQBZ/NmQNDZraRIULCySDsSZkouO06HYIarkoJSlXXDhDVWgZJcC7OTsByj/sLELe5ARxqu5M2TxlqObu+VMLKobnU4XnaMeVOwIS2OBAXDEKZXf0ncMLAa25dRHBCvsCk6x4F6BuL0YMXUFLvTtkuP1jYzw9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqnQ8AIJ+wAsb2dwMNcPSHGBFXE01d27V9qBZn9sxzA=;
 b=M4B8sXeCvl/qLoB2kMit5Bgq8cVxG7hoVXIGg9L7L4ok7rYdZjYO55FZSjNRT2AJm+gVf6zke19zWc+ORKCsqfZsQPbJEwsa5c6YB2BE/rnS1ImKKJLV6YbOzigC/uYMgqLygun7F6LO1YculAZ9VXGpIoUaIHqRJ3sNQqBT2HfWt25pMSk41bLJLZjxmgrXAY7Cdxt/uM9Gnc6B1MlebpxWN/WSDHQFZUkUmNfeoy0it4mvTTxQsSo4cnk2NRYEKD38TxEYObgin2w9Bp3qNBR0wCiCaBaLeoM39GFEe2Sd4dQf8AlHijTW8GHL496Ny4rJUU2v4tEGtl59ykModg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB7031.apcprd06.prod.outlook.com (2603:1096:990:6f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:57 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:57 +0000
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
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>
Subject: [PATCH v4 18/20] hw/arm/aspeed: Build with I3C_DEVICES
Thread-Topic: [PATCH v4 18/20] hw/arm/aspeed: Build with I3C_DEVICES
Thread-Index: AQHcmaTWn8zezypqcEyNOVHjGpVHFg==
Date: Mon, 9 Feb 2026 09:16:57 +0000
Message-ID: <20260209091629.823457-19-jamin_lin@aspeedtech.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB7031:EE_
x-ms-office365-filtering-correlation-id: df1dc422-323b-453b-5e32-08de67bbf948
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?eUH61hVyd6fG5dTNgeWa+evb7lX8x5DYxBn/Ulvw05EexRQ4UixTwiT0Xb?=
 =?iso-8859-1?Q?O7Ot7iyP+QFb3DIqn3otqn2etGjMWaoUKzTVdU4yZZKaNlvjwmDqSmS6Tz?=
 =?iso-8859-1?Q?T0DHlmRcR/8PEvj1drlJnKEbHHeSQjkzdVpRLz9GizgWqQDg1P+MNK7KK/?=
 =?iso-8859-1?Q?JxBx74SeXX+gU5l1pq65r4c6eZXJ3Xika6eDXQ6NY4O6a7xgWcLcnvcBG4?=
 =?iso-8859-1?Q?xOVAY2sC1OSfFbRSHo0uDTunHm7C/CoC92vfMVxNJY2M3AnxsXkbgxHRS/?=
 =?iso-8859-1?Q?vYmh+D6g0K3fKETooSjVd1kmHPty/VJMz4EcOi2uNKgFsv2bNRTF5j/6EN?=
 =?iso-8859-1?Q?HYQUVfxY5JIw8fO9Hb0oYI/DcU/yOLQzhwRup1TPOQ3gAZUatKd7CGC4IM?=
 =?iso-8859-1?Q?JDNEyo8VyuUmf+DHDA9rZLuvr5Wh8Z1OXohvp+uU1aNyG/zoT1oJW3kB6J?=
 =?iso-8859-1?Q?PFb8YhjNvmxKjdZZNosW2fekY8lerF8LKxnAylwaHscSEz7TUOXtq7KVpb?=
 =?iso-8859-1?Q?7OkAn+m2N6FNuyr5iwdq3jV3vKLg6557D231DqScedKH5dwDZPgM9EBjpo?=
 =?iso-8859-1?Q?sfWMZxWsHJTLOG+TnmTR81U9RrUoxO6S2d5W8Cp0I3c31tw+Skyp7T8JSs?=
 =?iso-8859-1?Q?9QfD0zBPfUJMHH5NP2eQKyZ/ou67NpggWMIE1Xd4xZvnAe/Hy/wVxou1PC?=
 =?iso-8859-1?Q?Oq/GTynZ8KFN44TkhnDFr5sDNPjLwLAqWwNmGn174FJsku6CHTSyYlWNCF?=
 =?iso-8859-1?Q?SC8YCly9scQ3XJRvx1YK9+gzbZ/sDfgR79NY+UVY1KVCFPnSppOIGf7ESo?=
 =?iso-8859-1?Q?Z7K4FeUzKjOmadA/N6lylviO1trWOjwijy2hRI609GV5dXq5fpHX2f8Otb?=
 =?iso-8859-1?Q?o0VbBA32cbAktEt4uvM2v8Gr/IFSYxZ8D7M1cT+vWwVNnkjSu6LlFhT9Nh?=
 =?iso-8859-1?Q?WS8+f3ANni/RMNm2Fr9PT8XxxFvNJi9yoNa8swmtz3+nrRCWScUi+4F6a1?=
 =?iso-8859-1?Q?PTNQdUQlMF8bXbi9t/+U9VBTEPXLc6r+PLwesd0QHz2fA+ggBfEJoB6pU9?=
 =?iso-8859-1?Q?MGSrwo2ltmIs7NWOBDb0qyVExjwGI629pkdqxR0XRk3tVIUAXeuHahxuUP?=
 =?iso-8859-1?Q?06W5vjWPh+B4HneQ0CZ82YNGfGUG6OY8QfedFQSFdwnFhebQcBfmAQo2eR?=
 =?iso-8859-1?Q?uSOYsSvpqF6oJzg6dWholHPpS5fUEJlVVnLrXM1cA8KSX0iNVRHCFauvgF?=
 =?iso-8859-1?Q?/jNFR/cEyeygBxaiRyepr7H4sMEUL8iPduLPrhAM1d7T6CwJuAp5l4nxPO?=
 =?iso-8859-1?Q?ZHKpnHEs6j2hEFuu1pfKh1qXO5flizlbfPUcHggirdRPPjiEXBpEN8CX2s?=
 =?iso-8859-1?Q?OaAy6/Uxy/8xO3bYXEEsNUDkmS3REI/3e/wJAHFCD/EFU6kNrK+NdMxsgl?=
 =?iso-8859-1?Q?4BQMD4NkjMe9FeBFeUsqspXfJyyKSdH8nrXIKJryl7hTGz4N0ZOC0ZLC7W?=
 =?iso-8859-1?Q?F2ubrjzt1H7Hwty+HJDJG7sNCbBQsKjthNnSU2RGYJRLcKas5ua/qJLzTV?=
 =?iso-8859-1?Q?Cnb+qQOkslIg34T8koDGP5UaXt8QkfcCfv3RPWMjEEvsHpC3Dh9YfGWm4D?=
 =?iso-8859-1?Q?USjgTJz7Xb9IflTAdLYutty4COKuIDJX+XvC35N1mb8iuQARrtvV9TzntD?=
 =?iso-8859-1?Q?lT9LGmdw7zLSlumnDqbLB6wD5pqLoUx9FAPR65F7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2yA8sJK+W7u5KWhhxzTEDhGvB5FLB9a07TC4AJqJnIcXAWykDnoGgQ2wis?=
 =?iso-8859-1?Q?EBB50Sf+TvegrziaqYWu7RpXPsmo6w+Ar6T17TfahM9cC+HgUdWz5nxf8p?=
 =?iso-8859-1?Q?nhF2C6ALI2ogHZiuB97jYoGfn60yQv6MiLDoI1CgSiuVZGE4lmxc37X3/9?=
 =?iso-8859-1?Q?gxU9jmkO1Z5fE5BHmw1HtLjU72bmpHH/G/uC+Su32K9gWGv1YZL6Wf/dRZ?=
 =?iso-8859-1?Q?lHQAFm+LC/KmgULAF/t2gpWywA//IT/4JjNF8ga16EbrBvLnMcjLolABnl?=
 =?iso-8859-1?Q?al4z4yWSfs+EptpywcAHzn7ywBa3NDVHy7NCcpFstOu+7uS6BMa8AIPqJc?=
 =?iso-8859-1?Q?U0vVaNr3sVd2vWCMqfeut6k0/g6XXCmg0dN4A/3JFHs5g6aJAkTQgqMlPR?=
 =?iso-8859-1?Q?Lt4nzTfYNj62Vxy5AX0HAUI68ujZ0vJlUk5+QrFPoTUzB1Nj5icXSjOyJj?=
 =?iso-8859-1?Q?LHQZnRRj+Pv7YslAJLfW/NNUYd4VEjtuMv96JxclxkA9lHwcNVPSynX8BW?=
 =?iso-8859-1?Q?4GPbRyXqRWdf0QeIsF0VQ4/j94VCtEuAn23o3RqmjXXu40gP7EmW5PRD4S?=
 =?iso-8859-1?Q?Q76oz2SJGHUsJA/SCGhURz33aCiM08EpZJ7m6WTaxKS7Utit7J0K72DvCj?=
 =?iso-8859-1?Q?t4yywuwKId574Hv8bLvA8XK6Zhz01DqgzGP1Wio1E6G7pqE9c1hHXot2z9?=
 =?iso-8859-1?Q?IErMYcpYMU97bOQlclBvoL5RVtIBy+lIp0lO6PqnIUFlfGM1BzpnqXxLsk?=
 =?iso-8859-1?Q?UBObRDPx25Vbnm60+UQlHKKCbs9K8ipjV9GQ+qqOP5PD6RIMdG4UCqUCs0?=
 =?iso-8859-1?Q?3efoDP1x8TNssHyQkfAYF0i2GsG2hcG288pbcjcurnZDZpFCv+FYvxG2Nc?=
 =?iso-8859-1?Q?mexnQpjm3ljdK4lsuUArRtLUTXIR91aAennVzrENvwwdG7K0ZSIwvjmEd3?=
 =?iso-8859-1?Q?WLtblHRWRXZ7FfXbfYdRBwynYswceA4j0I2h2IMTNQiLIZn+HkiPAauxAi?=
 =?iso-8859-1?Q?oe0KXoKcpqqimpjY6SluTUY7WD+8OdG0qMAblKTPkWVIJ7EzrHQBaV2MS7?=
 =?iso-8859-1?Q?VyXiCqFuHT3Pys578B+QzY5j86eNgmGoo/lKRureFQKG3kRIVlFC10PgNc?=
 =?iso-8859-1?Q?YjkVDRcRXZHNV3Rs/vtjEwLsr2v1oCekZ4nJwMzZo0IBZYw3YO+8+swem+?=
 =?iso-8859-1?Q?6zSkclB0pcT9p2G8RtwXhcK15hWB2XoVQd3csXs/zWUrz+Cg/POGxOx3iN?=
 =?iso-8859-1?Q?Ybj9R9geTbVJbpFpzJCw7IN2JD18ZPFnYJxGVFiXA/dtL9AzR1JqowF/1N?=
 =?iso-8859-1?Q?1WXYZB9NERAA+vq38Y72o/c1G3LqLHhCaN9vyVjEU/zFmniyl833hcjtED?=
 =?iso-8859-1?Q?8mpUoUZ47tc/i76mthtnFRheGjqUm0gx6zzsAxdeNCVY4vjUCX28gi37wq?=
 =?iso-8859-1?Q?6QGH8OLMFLjk/x4aKDa3Sm3kflB9b6dfJTV6eO/eKixLZWZN+75JPhWFK3?=
 =?iso-8859-1?Q?4a5rKoVV8udXJh07o1MEd7pyK/Th2xpUQp4UEavirVhYvT5PH6rHdGzUGG?=
 =?iso-8859-1?Q?rtMQLa2iQ6PVxCbS6hRHPxkmAnS/66Mf3xZJYyuXuv9BOKt4qULTOc3nLD?=
 =?iso-8859-1?Q?QrgE0/QTnzdXIQTa8p+wxBtYd3dXmWwYPJx9epWhJS86tzozf6tZVbBukc?=
 =?iso-8859-1?Q?Rhg978187dhzjnSSFWpqZ+yBtlcD0sin7rf/sQ1ipIwPBAOrVZx+me0PdX?=
 =?iso-8859-1?Q?i1+cUO23FDq0hhT/Y0K/3LA2LS3sPg3w2iw9A5KZO3lv2RKnIi/vROR2JO?=
 =?iso-8859-1?Q?RAqLqd+yaQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1dc422-323b-453b-5e32-08de67bbf948
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:57.1973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8VLjhwOQ97WPfpsDNuSOKo0AbBqWGeM6/PMtHz9XP0/o/PAB9eaqr1DSVw7077jafRRvIBQw4LTIgjKEH9rpUWViIYdlFMutzqzdWFcPsn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7031
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

Allows us to attach the mock I3C target=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/Kconfig | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig=0A=
index d545ecd712..3396a32fd7 100644=0A=
--- a/hw/arm/Kconfig=0A=
+++ b/hw/arm/Kconfig=0A=
@@ -547,6 +547,7 @@ config ASPEED_SOC=0A=
     select I2C=0A=
     select I3C=0A=
     select DW_I3C=0A=
+    select I3C_DEVICES=0A=
     select DPS310=0A=
     select PCA9552=0A=
     select PCA9554=0A=
-- =0A=
2.43.0=0A=

