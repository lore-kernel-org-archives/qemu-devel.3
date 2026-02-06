Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD89EECD9BC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCNq-0000Q5-GA; Thu, 05 Feb 2026 22:19:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNh-0000PJ-DH; Thu, 05 Feb 2026 22:19:41 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNe-0008F6-Gf; Thu, 05 Feb 2026 22:19:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DthHUx4MgFTJuUuLySX+E4hDIFNxV52pUGYa096aEcF9bfbfvNlOpd2ae6EGdlhfj6tuUYT/nBLBxzQbPXjgjRZzK+IED4W0Vc70aswyae4SFciasfvwsnKtRmtM0DdmxEuR4q6OWpgGG0B/OszlZ9nwblDsS1vYBEohpMuKwqtnLxsLE2yZf+3LZKQTOKqTujS4SgLOv8gb+4P4/HtPcYoXXEg1imdRZljhVxr96fQTFJqWjiaLQQcZ0x7u/AdhuvR0cWzgnZ8LFeUT4HKEmMQ4SS4Ro83gE+Mu4S35Cnq8LHIkr0iEo1qCPZg6kbzjsH2ncZm9JHYHEf5O8R9htA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABLPNFT0pgVNGc+Gs7SjCLQZfcB4InR41sfjRHG/dx0=;
 b=J8RZWfzzWh8wLoa7ClTRUx2ZoNH0ca2k5vTAC1TXT6pQ1iFaXXHlTl4NAwDWykACPm8EbtJF5qtQ7sQ0ubQ7znOMn/8OniXxg/jgn+OPfbVcIOK/aYNIKDNhBmaAyM9SfCA9y72WoVVRt+1Hl5DwDpwmcvvMfnwaCCeTnnvds+DH/lXMGSiK9HdmotMOol4/Ch7Px5uGGb947E2N4RoMuPnSZVZ2kKWc4eD7YSvjoXzkf9bmvCJxukRyuubdSQWWAg2XefdbgnYh8KuTgBqXqMfYvExkqaDD8dmpIrrfTvFlyCdVIeWARHbGZ5AO29agfy+rF2pOIPL52B4kPX+81w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABLPNFT0pgVNGc+Gs7SjCLQZfcB4InR41sfjRHG/dx0=;
 b=eNwjEd2mscxzzAHVfQxRkHfhjbnqSR4PuNkxoJ1Q48w6BhUwMsUNmlT0oESb06PAozjeMjWgtaA6nBskYej3WWVMw3llqLkoKk4kirPzznvlutJqfIuqiTM/qTtz2gHJwvzfZ19A8fUw/618BXcT79jQ+Y50B38+udX2lci3tCZM94/wqT/lkEM7ZKHrAkN0QwN1+6JBaYxcew+hUbDZP2nv3zJ81MkJ0By8nw11gpvZwqnJtSK66eS783HUZW0iU4GDA8PmGNfE5E3PADKDklr2hOSSxiXHX+t24XGS/pva2cthyUc0WNDhaYgcb9emZ6mbNCMJuYU+2ymK0DYjBg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5762.apcprd06.prod.outlook.com (2603:1096:101:ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 03:19:28 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:27 +0000
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
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v3 00/20] i3c: aspeed: Add I3C support
Thread-Topic: [PATCH v3 00/20] i3c: aspeed: Add I3C support
Thread-Index: AQHclxdmYyJyqQdIoUC/kDEZE0v29Q==
Date: Fri, 6 Feb 2026 03:19:27 +0000
Message-ID: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5762:EE_
x-ms-office365-filtering-correlation-id: 18bb3863-0b31-43ab-010a-08de652e893c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?0W516G7Ed5+5J9+Z7Q4OUCyxaXxTuMq+dhLVuFc7eGTK0mZYqA8mp2wRde?=
 =?iso-8859-1?Q?IIV7d2S2/+QhKHJsV3oqYiDxGqYg6d00PGTnauyPmkk4DKzb1uBOHX62dM?=
 =?iso-8859-1?Q?JKR82pVGUx+q0scXazxvrXG2bXNzUf7OYHrNfIzgnCYXwm8B9hx63Rwafp?=
 =?iso-8859-1?Q?4wP3sR6VJ7pY6mtZvbahfaWYmXQNZZk0/gwLh5lMP/szo2tx1P+zQ3UaOQ?=
 =?iso-8859-1?Q?wqF3XxjAd3qwgWRgWtQQ15o1pmOk7vmycWw8DP5b0s86dRnb4C4HN2/eZH?=
 =?iso-8859-1?Q?jI6DgQpjiih8908GylLMh4mpq+Nvg5R0vVSVrN2m9vi1wiJlj/+caRo7/Q?=
 =?iso-8859-1?Q?FbF+/tO3Niysm16QO+JGi/pFp+Y+MvcZ4SqlQD6ERzWvyNAKnfuLiWb/Iy?=
 =?iso-8859-1?Q?OYr7Fi03+t93ypgefSF0ZFIKgzt8667jCH8WE6wgN9KY07ZYljnYBtRv6Z?=
 =?iso-8859-1?Q?phCG3lrP1R/OA3tUy3XwXYUzJEGTabHeyKheT2X65sK+Gq7BzTzdBWXXdm?=
 =?iso-8859-1?Q?ofVh1jj6WiIlAINqKvzsUfmeqad7WLhIqdVXYuiROXYCvaxkV9ixRuiVXA?=
 =?iso-8859-1?Q?SRA6BnAEorYDSePJzhXwBg6O/BStU2x83PNdEbHzM2jPAltWwH/YnjE5p4?=
 =?iso-8859-1?Q?0koJufaLwstxpWRz89gBdAqFjq9rQACqPctQBnJdO7BbijQ91UbYo5ZNi3?=
 =?iso-8859-1?Q?bELL+kC6/t7cyk+A1/02qJFZsfpRpjQz23T3VZA4SWaUHVPVFVSxvhW/nW?=
 =?iso-8859-1?Q?099xpfpscvlTwyeosg1D5JEceCdhOuyqAdz40OZ0EuazJYR8OsiD8Y5xmT?=
 =?iso-8859-1?Q?G8PRAdraSwY/5aVGEU+wpfpiW978OKmms1JdcLeh0Ytl7Dnn6q/NIErpsF?=
 =?iso-8859-1?Q?7FuNEWRdRvI+wslplomi+OnpR5qRwytr+TG1wJhIfgo7THaNdEQlpONw0G?=
 =?iso-8859-1?Q?0Ejs2lEhoODWzLEmt1b5Vi3SLreZLGbxu8TuBLH9Rssw1J2wJlEH+Y9i8X?=
 =?iso-8859-1?Q?Yi8XF+Yctn+Wg6ElJ5fDwn0b2v+2ixC1PV8SpIZrSzU3NTjHOKRg0Kz3Qe?=
 =?iso-8859-1?Q?TLHh37A6mBI1+Q4Qq+IS0r1o4v7duMU+prfKzbOen70X5CenJc+qsr9cwC?=
 =?iso-8859-1?Q?dvjVTaoQr9o+dqE/VdL8YP3oK+5EZuTxYoZoFA1x9TABCIMFrw5UJ7yieU?=
 =?iso-8859-1?Q?YaDoAx+hbIasUQuB90ycqMJ03Oo9yYRjkrph9G//U5SaZxkBhaqL/PJfFz?=
 =?iso-8859-1?Q?G3bN+h56BUqvYmLy7hUGnJFziqlCU5M62HsXFXCzciyG8/ORJLGoZ1Z+IM?=
 =?iso-8859-1?Q?Z/LcWEZ6zk01JoHGhLsojgGHW3WYtl8/R6p0jl8DMc/MHHER1wLa/Qbk/q?=
 =?iso-8859-1?Q?iFCY8KDQSCFX30Q3XVy3Z2qhCdsd2/G/l9jVPeNidc4bUT174fpxsWIESW?=
 =?iso-8859-1?Q?TKHDcimj1wcanLRSOZNOfXoWSgrqgMtt6XjHwVQsDxVZu9M8XOnTNrzJuM?=
 =?iso-8859-1?Q?wHazehAYZmkgoPK8FpDwaH6NReYU+O9K79D1azfRy/1XG17oINoOs9AfL4?=
 =?iso-8859-1?Q?orFALPKEpcHZsNH1/1r72YOZTz3334zleU7H4GSjx9rKlRTV4ZwCJsjV0e?=
 =?iso-8859-1?Q?iRD8usto7eD2CHpFdQiqXNwPL60uDWnvs2rB7ZYXi12TBRKrxEkFFZlsMz?=
 =?iso-8859-1?Q?5k47pov1fGF/RSPd9G5JRziOOwHB6dHj8PqKgr9V?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WpTGZyefPBZjavWEjimuPPpGFKo8T3dXq1ffp+uwDSIo8dkor40Zj2EKsT?=
 =?iso-8859-1?Q?LNJ4+kRASJiyWBdtyWugqQCWeaIvRBoI3uNlFVUfGXEOr5AIb+qvazNOEC?=
 =?iso-8859-1?Q?sLNhEfMN+DQUYdD9W+UaqHxaB00ArWBfGrQQex3//QzaBYDmgH9fDy+uHB?=
 =?iso-8859-1?Q?Nbx1rp/JnKL5zQzsK2P38z5WtdB4H53YSRkGRcDojZpEKZ57qA6z2gRzz2?=
 =?iso-8859-1?Q?AHgiykSAb+5Y1Pzx8URlo9LhKDgZLY/p5Zex+OMSCR+MjpHG0rn6hK+CZZ?=
 =?iso-8859-1?Q?tRoR2pHbfYZ93L4csHjaEkRZlDedKue9o44aMt1qi/jwQpYG/CWRRpH+pH?=
 =?iso-8859-1?Q?9mN7ahVD45EI7cUp/KxCPoiOtSS1bQtaBzN1zNkDdBNwg4c2xT7dcoEiYw?=
 =?iso-8859-1?Q?QqJM+g0HpV+bpznGCFGy1Xly3izqcA/Uf5l8OrYY2IygcZ/NqV/5sGRC76?=
 =?iso-8859-1?Q?FEmSorE81CwB8a3EHHzFVvEzQYEkD8eqDxc+Eo1IWogcQdXbAhfIGY1BDP?=
 =?iso-8859-1?Q?jcmmRPLvq7/ihSQ915WBxmlSkAYe8rLh7B4Db5lM/yG33ydTZfeZGbixl9?=
 =?iso-8859-1?Q?RlmVgb6k3ch5uG7EUIvMaU+wtOLk9YYURsyT9ambGkU4MPtgymE/w5eq8t?=
 =?iso-8859-1?Q?woZ6wmvIeAmMvtUgG4H/PMBoUD+SWogpwcwfFPQHF0qwngPw4mxmWUn/PV?=
 =?iso-8859-1?Q?fBJmc650tSx1V9yN+a6x7q4nejE1EjduWGTJ2P0vMGfHa0lzsTGeZnfo5M?=
 =?iso-8859-1?Q?1IuVm5nSvPJeFidlt2Y027HTk1czNepHfklFZlgJp00DTxIwwCy3P8E+Fh?=
 =?iso-8859-1?Q?z2rYABOW0ORW4dYFEy31LuYnXcC9gyLzzz7VopWL0rkasdZg1i6gtXNcoB?=
 =?iso-8859-1?Q?UNRSEzzVgc5cJ4oZIsVQMZRmiVmTVFLV8+w7QSVrXM8V6idPjTVp32+vRU?=
 =?iso-8859-1?Q?g5QlDbwUzUdeM3gXt4rZMxiCxC55vM3lLqUCBhc09tYwLneeY2DBTHKb5V?=
 =?iso-8859-1?Q?ijoYi3G9k0vyUb/QveNX1WKt20iO8kYQozsVoiOfCxjvHjJDenZ/5wBQ+F?=
 =?iso-8859-1?Q?/yUA5W9TUtTzrL0ntjl5q3oo2br0iY7oc7GNFZh5pQfkyGN5K3ma+wsUsy?=
 =?iso-8859-1?Q?AjXHXwWXQZX0qPAWIj4n1+YkC/fvITObQEwcTpnkY0DQGZq3EEdKWzB4aj?=
 =?iso-8859-1?Q?VMHWHu3fWcxZtBtVGo/a2NaeUy6hCdU9sKBFGj8V08apJPk4LqWrX/rhyQ?=
 =?iso-8859-1?Q?5udunp6wWv24F+hnomvFpT/y5bv6nihJuyC64CMNkTJz0qWlwiy7d714mZ?=
 =?iso-8859-1?Q?kIKZudCImw8VqQTjnTk4mSyfPZe98wRt5w58jOLX9vrrujqKxifS1WIL9H?=
 =?iso-8859-1?Q?Yq3PZXK2wBkqsu54ELziyFNkcHvDZCFETPqsmOic0yHzMTHcAMa6PL82M7?=
 =?iso-8859-1?Q?DWbKxaiC37dGaVu1xCavFXBiiu/AI6cTTT42ciyzds73UUg1eCFxjOFaZ2?=
 =?iso-8859-1?Q?hntqcGlZPmWBRPXBzJ1mTOjJUq90IgfdnbRHPVShtxh6HH8QCw15I1Dzeu?=
 =?iso-8859-1?Q?o4o6nTQL0x3nUC2DzuO44I4bGOzeX0RBE2qt4+cKxuOnEQpSB/9bD4V7wL?=
 =?iso-8859-1?Q?LYzmpS3wj/rwvafCeVaJP4LSj4noTfPwLZvDkVwGhww5G4GMJxD/9LXs0H?=
 =?iso-8859-1?Q?6OQem1I8WLz2N5aCyIqqJtt/qDWp9lFGgm9Oeb6mq35zYDF2Z0dfW/1rF2?=
 =?iso-8859-1?Q?r1i6BV+Bs5yNo4z3mUickeuWMOX+BstL/EpdHzv/jJyaMuH7Vqx2xKSc0J?=
 =?iso-8859-1?Q?/0NVS2fIdg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18bb3863-0b31-43ab-010a-08de652e893c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:27.8066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njKDo8qgLaZ2d05KZLq/v6wkor0dvjXOoiP/4NmGRETfC+TGapJTWaYNwNVlOtWYcB5kFzrrGR8hGrvraKaKzTamqLGG32QMjig1SkGTtm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5762
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

v1:=0A=
  The initial patch series was based on work by Joe Komlodi <komlodi@google=
.com>.=0A=
=0A=
  This series adds I3C bus support to QEMU and adds more functionality to t=
he=0A=
  Aspeed I3C controller.=0A=
=0A=
  This implementation is a basic implementation that introduces IBIs=0A=
  (including hot-join), CCCs, and SDR data transfer. As-is, it doesn't supp=
ort=0A=
  multi-controller buses or HDR transfers.=0A=
=0A=
  First we add the I3C bus and controller model. With that added we extend=
=0A=
  the functionality of the Aspeed I3C controller so it can do transfers=0A=
  and handle IBIs.=0A=
=0A=
  Next, we add a mock I3C target. It's intended to be a very simple target=
=0A=
  just to verify that I3C is working on the guest. Internally, we've used i=
t=0A=
  on Linux to verify that i3C devices can be probed and can send/receive da=
ta=0A=
  and IBIs.=0A=
  This target is sort of like an EEPROM, and it can also send IBIs upon=0A=
  reception of a user-defined magic number.=0A=
=0A=
  Lastly we add  hotplugging support. The hotplugging doesn't do anything t=
oo=0A=
  complicated, it just adds the device attempting to hotplug to the bus. It=
=0A=
  is the device's responsibility to hot-join and go through the DAA process=
=0A=
  to participate on the bus.=0A=
=0A=
v2:=0A=
  Jamin Lin <jamin_lin@aspeedtech.com> has taken ownership of the I3C patch=
=0A=
  series for upstream submission.=0A=
=0A=
  Changes in this version include:=0A=
=0A=
  1. Added I3C functional tests.=0A=
  2. Updated patch 4 to refine register field definitions.=0A=
  3. Updated patch 7 to correct read-only register field masks.=0A=
=0A=
v3:=0A=
  1. Add Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
  2. Fix a typo=0A=
  3. Fix ASPEED mail server issue=0A=
=0A=
Jamin Lin (1):=0A=
  tests/functional/arm/test_aspeed_ast2600_sdk: Add i3c functional test=0A=
=0A=
Joe Komlodi (19):=0A=
  hw/misc/aspeed_i3c: Move to i3c directory=0A=
  hw/i3c: Add bus support=0A=
  hw/i3c: Split DesignWare I3C out of Aspeed I3C=0A=
  hw/i3c/dw-i3c: Add more register fields=0A=
  hw/i3c/aspeed_i3c: Add more register fields=0A=
  hw/i3c/dw-i3c: Add more reset values=0A=
  hw/i3c/aspeed_i3c: Add register RO field masks=0A=
  hw/i3c/dw-i3c: Add register RO field masks=0A=
  hw/i3c/dw-i3c: Treat more registers as read-as-zero=0A=
  hw/i3c/dw-i3c: Use 32 bits on MMIO writes=0A=
  hw/i3c/dw-i3c: Add IRQ MMIO behavior=0A=
  hw/i3c/dw-i3c: Add data TX and RX=0A=
  hw/i3c/dw-i3c: Add IBI handling=0A=
  hw/i3c/dw-i3c: Add ctrl MMIO handling=0A=
  hw/i3c/dw-i3c: Add controller resets=0A=
  hw/i3c/aspeed: Add I3C bus get function=0A=
  hw/i3c: Add Mock target=0A=
  hw/arm/aspeed: Build with I3C_DEVICES=0A=
  hw/i3c: Add hotplug support=0A=
=0A=
 meson.build                                   |    1 +=0A=
 hw/i3c/trace.h                                |    2 +=0A=
 include/hw/arm/aspeed_soc.h                   |    2 +-=0A=
 include/hw/{misc =3D> i3c}/aspeed_i3c.h         |   22 +-=0A=
 include/hw/i3c/dw-i3c.h                       |  201 ++=0A=
 include/hw/i3c/i3c.h                          |  277 +++=0A=
 include/hw/i3c/mock-i3c-target.h              |   52 +=0A=
 hw/i3c/aspeed_i3c.c                           |  261 +++=0A=
 hw/i3c/core.c                                 |  669 ++++++=0A=
 hw/i3c/dw-i3c.c                               | 1864 +++++++++++++++++=0A=
 hw/i3c/mock-i3c-target.c                      |  311 +++=0A=
 hw/misc/aspeed_i3c.c                          |  383 ----=0A=
 hw/Kconfig                                    |    1 +=0A=
 hw/arm/Kconfig                                |    3 +=0A=
 hw/i3c/Kconfig                                |   15 +=0A=
 hw/i3c/meson.build                            |    6 +=0A=
 hw/i3c/trace-events                           |   47 +=0A=
 hw/meson.build                                |    1 +=0A=
 hw/misc/meson.build                           |    1 -=0A=
 hw/misc/trace-events                          |    6 -=0A=
 .../functional/arm/test_aspeed_ast2600_sdk.py |   12 +=0A=
 21 files changed, 3730 insertions(+), 407 deletions(-)=0A=
 create mode 100644 hw/i3c/trace.h=0A=
 rename include/hw/{misc =3D> i3c}/aspeed_i3c.h (63%)=0A=
 create mode 100644 include/hw/i3c/dw-i3c.h=0A=
 create mode 100644 include/hw/i3c/i3c.h=0A=
 create mode 100644 include/hw/i3c/mock-i3c-target.h=0A=
 create mode 100644 hw/i3c/aspeed_i3c.c=0A=
 create mode 100644 hw/i3c/core.c=0A=
 create mode 100644 hw/i3c/dw-i3c.c=0A=
 create mode 100644 hw/i3c/mock-i3c-target.c=0A=
 delete mode 100644 hw/misc/aspeed_i3c.c=0A=
 create mode 100644 hw/i3c/Kconfig=0A=
 create mode 100644 hw/i3c/meson.build=0A=
 create mode 100644 hw/i3c/trace-events=0A=
=0A=
-- =0A=
2.43.0=0A=

