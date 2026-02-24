Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A61EFB7F9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 05:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vul6c-0001q6-0T; Tue, 24 Feb 2026 00:37:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6O-0001k8-En; Tue, 24 Feb 2026 00:36:57 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vul6M-0001J8-40; Tue, 24 Feb 2026 00:36:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkOkofB3uVL7Gm2+raIjw7clGzovccHXYtr0tP+tzIaP7M5d8d8fwKg1QmJ1h0g0ez1JumQmdSG7A4RRrPWmd/DgW5lWYDgKjmdPmkMsyThBUKnTIlInkfnRx0uRQKuTJckxm5ito04tC87w/4LO5B63VVwSXaGRDiTUQmrHOhrVwgIeFy6ER1J5emobn911zFFVdoF/wZgp6gvbQWO9cZbK4LLdYtYpMcvjjLvHiNqTazlL2kJReT9O+MJID9IlFlrGJa7GFyJ0xszSsZz1WWTKipi6E7QwWY97CQlX5FHT1yiIWBVt9880Z2qZcgs3ypwpg5ZfTDUMF26tFUmyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrDshy7VWeA9H+0OoW8EVb/iuPmeqQzByo2u6j5AVVQ=;
 b=JF3HZuqomSErql92a3bIp2uRqZWjBRiLjMY5zOgiZvSrWgQsQvB1f349k2J36prnQh/3NpkBBQPZFGwKBbYfy/j6ZLy6ltm7jljguagNd3XZ56lrtcsKlByh7sQ2wfmfMNtXWK7odkGAIL+8WpL8S3sHsWoXqEUYi97CrZOeQ/s7OJFPpLXpIYzo70ESJ3pep1RUr2r0QQLwDoBqWCGjPmVq5Bg6o9bTOcmvZlQ7SkFs2hklnwoLoXKuLGlec26Tqvb53ugltebHB8XTAvzqHKVCVnoQICfSXrcykePK1HphSGoCRKIdA9F+bGhrXmJ/CRCSmRmm08fB/w81KBYPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrDshy7VWeA9H+0OoW8EVb/iuPmeqQzByo2u6j5AVVQ=;
 b=awlxzTulXRY9y5bxMhIb1+xDP48/jq5yqDGXlfKtnpJapMhu3qGu6PfCdVFpP7kwf8aRjZNv1d6L6DzjGs/1AHlcXCZGEECBPoFOTCbHgZwYRZXET8732Ie2TKWXlcs00xL9ELPL7OEXjl9/9SWfelMLa7VwlCIQyieC25MnYGIDbQ38+pRpM3XCo59Vvokse+qq455VHc1jifBLrlvJdAfTxby3NfRVGNEhthuXd8WTDj9RGUuaRRlRVvkpv3ZGnLmgkxc7rdZzUZmUNvyUX+30bAznbkbCYvZGSzCLrmghfG7inwMArcmKTd5wYmU7vrGuxtc2H2flbsZeuDYiFw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB5004.apcprd06.prod.outlook.com (2603:1096:400:1cb::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:36:39 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:36:39 +0000
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
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v6 17/22] hw/i3c/aspeed: Add I3C bus get function
Thread-Topic: [PATCH v6 17/22] hw/i3c/aspeed: Add I3C bus get function
Thread-Index: AQHcpU+MQTo+JrG+AUq5k9y+Q0yMRw==
Date: Tue, 24 Feb 2026 05:36:38 +0000
Message-ID: <20260224053613.589102-18-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 8c6544a6-3a53-43bf-a8ab-08de7366aed9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?yLBNDzSgKNhhwkiqNoAkAPt1uLCQv5IER2UGgDIDUL5ee/O+W87roKIQjB?=
 =?iso-8859-1?Q?Md+sPDJncSgvUXkqRfVfWNTHrZr8GIB22bUS7NO63A3Pv1jeRMJZVfR9N2?=
 =?iso-8859-1?Q?RYrNl/m9o9PXlCrVzTiC/2NQ8YAj8P2rAiEkn8aJsLyfn7gn4TzE8YNeIa?=
 =?iso-8859-1?Q?v0x+wUU9o+37tzfmNHDzNrX9SBmbvkr6sMCu1lKDjBIfJNn9Ga6dfllwM+?=
 =?iso-8859-1?Q?g/DFluzRUdkHn4w4Epnfmz5C1EqBUPv4x1r5degjF35Vdd7gzQy2n10A0Y?=
 =?iso-8859-1?Q?zMzBMhO8AS4mGMWrK6ecK6HBMoa+w1fe6rTu5Lrk2RnBZ61ClzFSSEA8Nx?=
 =?iso-8859-1?Q?v2zXmA7YK5uiFBqWd5veQXLrpb2SZuhPOuxoZ3uYhXGmo22M1AYf0XxwZI?=
 =?iso-8859-1?Q?2679miA35JEoyoluHJrnPbxStAU7lZ/bkA45x37NCF31rjDzBgR8QAQTK3?=
 =?iso-8859-1?Q?4G7Qa9UqYfjpKePgmWTdRMFz7mofWYnDW9CoMyQar8zZ71FHgfUo6BeUQ2?=
 =?iso-8859-1?Q?Fxg75uuAbIM6ni3+0ntb5nbGruzs7tr/N+GeaNHbO2bOtoCVk6jbs9OUFi?=
 =?iso-8859-1?Q?5unfSEJ2XTlf3Cjzh5EK99eHF8E2JytJRCkrMogBQRbRKN2Mv7UIDaf6lK?=
 =?iso-8859-1?Q?70/Ht+ebWBZhdlhnSwNH+Imx4bWxBHpBr8HOuvi00bBPeSOZUMEeCcLV0/?=
 =?iso-8859-1?Q?wb1L5lGcnKgHmj8D1G7GMPizU5k9iRcRDBxmJiIfG2hUPcIEsYN8PgTnMp?=
 =?iso-8859-1?Q?1lTaGvWsdgpHcEFkUL+TjgmiiU90OzKPOawSutTiI+q0+OJYlvlp7wivej?=
 =?iso-8859-1?Q?mHbjWf8lAb7tcwXvmSbtqrYL73esUNTD80IW700cZPiDdMet48F9dP64Yh?=
 =?iso-8859-1?Q?8C9DjiONwYcnOzMGoK6ssrbYDa8Cd7G6sBVdNy6dYK3qWvG+UcyP8oCcV1?=
 =?iso-8859-1?Q?j3tVlxdWFO8c+Q5ooNUWCLYQzyO53kZEyME9pro4ol4u/aNVQetvd4taQX?=
 =?iso-8859-1?Q?o9I4NWr9FhXR8bYnNBpN5n3wJlIYg/adtnTwNLRGzcMGG4sExN8R4sxmEt?=
 =?iso-8859-1?Q?R16/RiE5MI+KXQZuAQ8uiNplcsjvafbm7kXGLS5WdSxiXKs/2BaTUgBkvK?=
 =?iso-8859-1?Q?r5WYEAZsTIF2adJgJjQVx85RVCUeDC0x6vGYcs+PPoEw+M4R6+syF8jk4U?=
 =?iso-8859-1?Q?TjzXGnJIw0XzTjvaHilyJI6MEQgQpGyHkLFB3tujG6pTxmSV7r2tawFOFv?=
 =?iso-8859-1?Q?f0vmNNm0GLWNo2XAeLnwvFl09dg4Oc/BlSt7T7bhOVsdhjNGh/IyqPo6ni?=
 =?iso-8859-1?Q?u3nKfX7BzkC58cm/P4WfAs5NlyZIlZY08TKTqKda20lnvQYrDtqz4nbkkE?=
 =?iso-8859-1?Q?x/amZtNK6B4XMiOjN6yPx18GT/IXykvUPqzkEyv/78tiZTSmwdbht1WoCp?=
 =?iso-8859-1?Q?QkqxyR/fdFG56RvBXO+R1VRU4TIiro5x7a5hQJ9qF3dweW/yFRvkur6ouu?=
 =?iso-8859-1?Q?SsBCx0tGgX03W2w7CbpMf0yf1+UTYycSwdw4cAh84azibu3RSxfi7cWPh/?=
 =?iso-8859-1?Q?6aFiDL9waguhDnuo/8RftgKGcP+0BJNuQc9VzfMlm2X6IlPoniGvf3ycDo?=
 =?iso-8859-1?Q?/KpZKz1qZKDYqrogx5mKTC5lbuBEGTUyLq1iHCaGVO6wBsjD2rCpChLtRB?=
 =?iso-8859-1?Q?Sdms5c6LRhp1NcZ6Ad5n/6GgzIU2KsvN9k6SDSyz?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TdFgb8ZSTZhDdEYKd66dbu2VTnruAccNjRVHS7RJKBjvUBjHyOO+u5MBVE?=
 =?iso-8859-1?Q?yNB5oid9Wi1UzaREHPfpy44HDNZlloGF3puidtlTRZqOO9wEAnXRe+bk0h?=
 =?iso-8859-1?Q?CaY96C+WsYV7HK4Zl3fSu/cqlXtlXWw047awvAd0RQIE+uSB1gmg8ARRXD?=
 =?iso-8859-1?Q?wGOqef6aIdbN/wvPLt9raPu9sX5IfGpqhPRw+OPNTE1KLjll6rnd1cdTxz?=
 =?iso-8859-1?Q?z9A9kQ4C7oQDHLIDfxikm2E9+EgnxdUtIwDu2ivuOCH4yNZ4IzBgzMua09?=
 =?iso-8859-1?Q?YkUkKqXX8Fy1jbLdXv1XlAkng+CVmXQS49+4Mi4NAALL3FL3izZP3XlGQU?=
 =?iso-8859-1?Q?5XzjQlOF5djsp6wYVkHPT7K+euzOmeU+k6bmmfgnHIH+a9P1gXMcJPhTZ9?=
 =?iso-8859-1?Q?E0q5s8xgSft66fbvrkHjfTm+SjXyXejAyDwPA1D6p0YByyJjq2RwZC/0hC?=
 =?iso-8859-1?Q?NKm7JEDcHiKdbPXPreUSaiezmYkbMaN66WCxMkyA5pMX7E/vGFXL4yD7pq?=
 =?iso-8859-1?Q?IZfT0gnksVMjXV02vyadF9IDByefgNcaSaEE+TEcgAyfPuL3R21JVUFDn7?=
 =?iso-8859-1?Q?G7rQwF4IT2CwDxKny+xC0RBlUiAwx+ebleV+Vx7XYz6wLER73PnElkoiTG?=
 =?iso-8859-1?Q?LsrzMmuDjN/ttXf2B0EtyfhXkV8GoSAxsxvAOyW7dZDxlOU4Ns0HYkG2uv?=
 =?iso-8859-1?Q?ChEm/0VBN85F8SE65K0sdKkUVTAm3mzyOiBv+5Jbg2qgvz+LB/TY4XOFJw?=
 =?iso-8859-1?Q?gVLBOeAgwRM6d2KKdVRU8G14CBZxGIdF2s2Ddgbt2MWU9mjwjHqpxP+827?=
 =?iso-8859-1?Q?x7Hn1ktHjtIahImSOx/HXNpwGCXQ9IVVwWa+UIqMXsld7j+Ag2cb92P+Eo?=
 =?iso-8859-1?Q?bE60lPTPTLpOdVmBnGmcx+pKoULIph+LDL7Xl/kNQCpmERd3jKcTpO+ouj?=
 =?iso-8859-1?Q?FQ5aIff1op6QDgpjZyYd91dEPgK+1v0tUmhg86GDjRrOZijPvminPKR9IZ?=
 =?iso-8859-1?Q?OU9FgZVyp1ODn0ixOuGDYDWXUAG1LJ8yfZbgqFBweN/gvHeZ/0xjY6t62G?=
 =?iso-8859-1?Q?hPxVF1y9SMXG7izHfyzs20oX+bm1mLM6sljk4gPxIsW2N1eKeSNzvqL4ao?=
 =?iso-8859-1?Q?NrZWXxz/+cpLxG0psG+IyJZpmhkf91TVJsGf65NiFGtny1iyCsqx0PL/ll?=
 =?iso-8859-1?Q?o9zzZYtgZPWpKqEPgEOYQKIMjOgPxcMm032ZYf3Kx2oCFtXMRUD5bG7gKm?=
 =?iso-8859-1?Q?j44B4mTwJOWvsFRDZ0zYhv61HwvygZPunhknZc+i+12jzhGpk5WCDSnWLC?=
 =?iso-8859-1?Q?lnBUgFEG1efQCVDf8xKyba7nhRrsP556YbxQ8l7YmYfTDPu3PetHJU//0P?=
 =?iso-8859-1?Q?dLcmalErm9MmpeTrKDQuHBpS+YWf50KyNNHkk0OLKspljr8NMomBUYPwp7?=
 =?iso-8859-1?Q?VY4WOYBtCC4gf1LCSIR7uJScLbOetLKMCpynoOsgjZttLxI6V3RX3sNE/2?=
 =?iso-8859-1?Q?NyV+CQXo4YFb0nJZHhHWIbu4lEGcBjJrBTgJjH7tnNJVcojaf3Q5uG+iwG?=
 =?iso-8859-1?Q?TqUJy6eujZ1rzp1RiT3OIi/t7WfGi7mmI/EgR+MDdIpkX589R2hZYurgmt?=
 =?iso-8859-1?Q?dQ/GJoZGJhgFw59H0xWMn6lWJiBE7wR6ZIxYlMgjusTHLyvsosONaZaZ7A?=
 =?iso-8859-1?Q?oAdjTB/gPzY5OwLPPoVRrf/8qAjTPiuOtEniTz7p6o4Ahsvo16t0CNvpDS?=
 =?iso-8859-1?Q?VF0TgObRPv4M0DwjQyu1nXBwdyeQAC6g0oUxlcc55aH1OklIh3VBQ4pL21?=
 =?iso-8859-1?Q?TqWJn7mwEw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6544a6-3a53-43bf-a8ab-08de7366aed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 05:36:39.0031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgPTSEYQX65wQWFxUQE46t3TDChYxDfwfXvjGTM0w1vUH5+JQoDIm41uoe0GzhONW9iBxUKIjEk3B4Y8zpwHOXptMrQu7VM0CYROg8TUHm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5004
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

To retrieve the I3C bus object normally, the order is Aspeed I3C -> DW=0A=
I3C[n] -> bus object, so make a nice wrapper for people to use.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/aspeed_i3c.h | 3 +++=0A=
 hw/i3c/aspeed_i3c.c         | 9 +++++++++=0A=
 2 files changed, 12 insertions(+)=0A=
=0A=
diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
index b8827d31d7..42c9eedd85 100644=0A=
--- a/include/hw/i3c/aspeed_i3c.h=0A=
+++ b/include/hw/i3c/aspeed_i3c.h=0A=
@@ -31,4 +31,7 @@ struct AspeedI3CState {=0A=
     DWI3C devices[ASPEED_I3C_NR_DEVICES];=0A=
     uint8_t id;=0A=
 };=0A=
+=0A=
+I3CBus *aspeed_i3c_get_bus(AspeedI3CState *s, uint8_t bus_num);=0A=
+=0A=
 #endif /* ASPEED_I3C_H */=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index 2700c5f4cd..bac8c55bb0 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -153,6 +153,15 @@ static const MemoryRegionOps aspeed_i3c_ops =3D {=0A=
     }=0A=
 };=0A=
 =0A=
+I3CBus *aspeed_i3c_get_bus(AspeedI3CState *s, uint8_t bus_num)=0A=
+{=0A=
+    if (bus_num < ARRAY_SIZE(s->devices)) {=0A=
+        return s->devices[bus_num].bus;=0A=
+    }=0A=
+    /* Developer error, fail fast. */=0A=
+    g_assert_not_reached();=0A=
+}=0A=
+=0A=
 static void aspeed_i3c_reset(DeviceState *dev)=0A=
 {=0A=
     AspeedI3CState *s =3D ASPEED_I3C(dev);=0A=
-- =0A=
2.43.0=0A=

