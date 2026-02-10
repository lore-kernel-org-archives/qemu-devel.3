Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF74EA3F2E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjlh-00018A-HC; Tue, 10 Feb 2026 04:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlZ-00017O-5T; Tue, 10 Feb 2026 04:10:41 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlO-0004ip-8o; Tue, 10 Feb 2026 04:10:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDJWUK9Y/L+mT/Rl9SGtQzKw3AhtTrn5ReFbJBEjtj5ri9PxroexzNnMF1LvVRmScnLID+S6iKelFcbJi9KbLynWtYezxXbEn+AO1w8/vIowJhfSAmk8uKz3wcMmIE1hcf89VOPVMdA7ybN5y9VmhxcabvDsXwGhJqZSWq7f3u3NctIpggBQd3RCMOK82APUy51Ykq12I99VTbGPZZTFQ8DNIPES00vmaLuVmLmB6B1+3BeM7m1sDiNB63s8IE73Cjmy/ePss0iisZ9mw+zBimU+J2TDTKcYuC3RA0dMv5hg+UuFXWwj8WwXEt14aWPYvpXktoWM7OVV4IvIJt7B2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEpfO0DLa1savDwcVNWyahHfyq1KX1vbr+n0ISgfBnE=;
 b=Fn802bxKFTNLa3jsSCQ9txgjsG77lm94NLg2guGy0eA8UC9Diz4xae1UPYIgBgUZ97Vh3roNho9B5P5q9vI2gl/v/4OVv/o5Db5eBjxOLPbhAZEH9e+qBysGpufEzjunp/gux0dFOFSowakh8VB1imra7m7kz78O+a1jMMzvZKpfpFPbxXebCl3mXPfpCRil9QZmjw8EX0wGMqne6+gSqKG2EarE3Xog1Kr1KK0rs6MLrhpbKon2rvjJpgjaeUKidiofc0t8VVpXw2u0Y31fpXikOqDzYImi7grbv07ccBlbs9fi3quE+G+5BKaM0iEG37aytB3caDgqfnSr7NiSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEpfO0DLa1savDwcVNWyahHfyq1KX1vbr+n0ISgfBnE=;
 b=nN5cUBfe+04Bq/6t9fUlNCc6dOIxvKGQ+hQR5/JnzS/JyXxTR14RvzHqeEKDi7eLwH6DIOiGV/hQNoj7d5UG/4R5Z9REtMa52FvRR53Oj0Nfr93d4ecmhiSgY3AmJ8tOd1wlUTZyGRsc2guxuH208PNV/4EfS5s4IIqqjUpH0f+8xD+wMjZWR0pRfWi5135A3Ca5Bmd89/L6dM0xiQV3U61YQzl9YS8dGZqLVOPQOzMsYhGvp00lV3zTgFHpVojRaDpD4A7uUm62uoXgRd4O2vCUa0zN2DpK7hAcclsvRSbUjF1O5YvtiqsRCjSlO2q7rt7PWfYq1lhe8ZabyO8Dmg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SG2PR06MB5264.apcprd06.prod.outlook.com (2603:1096:4:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:10:22 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:19 +0000
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
 <nabihestefan@google.com>
Subject: [PATCH v5 00/21] i3c: aspeed: Add I3C support
Thread-Topic: [PATCH v5 00/21] i3c: aspeed: Add I3C support
Thread-Index: AQHcmm0UcQRs4EPMvkyppE8BhlWZ8w==
Date: Tue, 10 Feb 2026 09:10:19 +0000
Message-ID: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SG2PR06MB5264:EE_
x-ms-office365-filtering-correlation-id: f087ddab-ed06-41f9-db9a-08de688436b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ig6IkK+jGTTgpbOs+v26dq10IJlKZ/pdJMGjoFlnam9Q34bollP331z7nq?=
 =?iso-8859-1?Q?RKxJ934su/gh+/w/dTtKyb4Mi0BAbkd5Gbl0jUDeib2aVXYWU+TWXcU9Tx?=
 =?iso-8859-1?Q?MCezwaJGwx6YcLvIhIFOg2WkMuvq+uepELozDEsXt6fDLlD+Cnws5dR6Xn?=
 =?iso-8859-1?Q?PQYPoXS8fFIwBxFQ/4sRT/eoRqFOgNqcOUm49eo8iZ7eL4PEYf/Fw6Zjxq?=
 =?iso-8859-1?Q?Hs5cpRJNUCFNi2OmsLm5yEXhSHFLXatxEcd199pYAyLHzmt6eHUGt6+YdA?=
 =?iso-8859-1?Q?7bGynZhLV4h/8ZgOmrBoGu52p+bkF7qb2/7Snd/OF5uq35KSRWi37519Mb?=
 =?iso-8859-1?Q?cAvz6VPviKflKGwFeXXUCYxl3mmHVmdDrb8f4ZN9LNloH0KqwkIXAmi5wA?=
 =?iso-8859-1?Q?sno4+aX8HWDcjxeiAS9owqcAnxS+r7MgHcGCrzHfdhCwbFTCuFVhP1zGQU?=
 =?iso-8859-1?Q?fgwIoZGkFRCjMmvTwziaN5nx6idufM6n99J1/v46WmKP2IE4gCAExgZf97?=
 =?iso-8859-1?Q?Wdvv4z9rvr3Iv1KZAPPVX4EO5UmgpbigPm/PM4fvE2g+9VpuLVbT/gB7Ao?=
 =?iso-8859-1?Q?gnoIGpy4YBZ2AEvM7f5ehA9w7TvZn90t5DpRgY8QwhhREgvDOfom/aQy4Y?=
 =?iso-8859-1?Q?ceIoQgJ8+38tCHkf8suluEs15pau1VLkA+iJd7touPbLvG18bg4pEiVPnO?=
 =?iso-8859-1?Q?XX042bWNcyLwavHa/cgfypBwaawKgay9bgXoAFxjPkWN/bWDzZvoS4ls1c?=
 =?iso-8859-1?Q?soADybBi7AI3n+lGb4u5oZmiVLb1FduTM7ZSX0U0Ss0zVqakW4N2Efiqkb?=
 =?iso-8859-1?Q?LVLtQpm4qog5lkdfff7+D36+4yWkjq02WbR29xGIM32xKndHzeFq9PtFdO?=
 =?iso-8859-1?Q?srCOs3joAikGHJui8gXJ/g9ed23fLbQAsEYgeQkBikFKTCFudsbwljazHk?=
 =?iso-8859-1?Q?pqZ0thSiEtlIDbvVhapdKg/aV79+UIC8kIy6JRsClPo9egFceOtaXo0HBB?=
 =?iso-8859-1?Q?Xs48Lr/xusFfP+BIHiknA7LuVa3YB/p+tV/vQJywmtQJaY1B7G7bi6D7Xp?=
 =?iso-8859-1?Q?lZC2qMlZ8geRAaE81vInYfJ4CiJgyEueK0f/rELKffWRgH2U4mu2SE2kkF?=
 =?iso-8859-1?Q?8hCpZQJb34wp1fTshU5MGz34YP/22EC1cjJdi4M04Wd7yMMwg82Qy3Ly7e?=
 =?iso-8859-1?Q?WTKZbEIuShcnmPOsa/rfTHmDjNMBdYwRZ/YL3pjHtnBcdd7m/3aK+SiKlt?=
 =?iso-8859-1?Q?6SkyMpi28rVgGd4OrLHxLTr+6XwTrj+k0Cs5JkIEKi9K+ucLVsOxBOqrWX?=
 =?iso-8859-1?Q?nwAgAWiv1EvFgSru1PMpAo6v/oY6Pb1h0CvqlWK7fDa2nh9Q4c6IThLSWZ?=
 =?iso-8859-1?Q?Hgr+BXRgOMlTrfzPli+BirJuL2NYLZaN5DeFKlTDssfi4I3Lo8xtDlC0w/?=
 =?iso-8859-1?Q?awsCag5+N+gqNQQ0c9tYqQavFut6fewHXe4si7gUWd6/NKhmHhPxZjSRiJ?=
 =?iso-8859-1?Q?GMxRmVMFioH4xf/5qU8dCRzzxQ+2ZZnjEecaaOwVHihE1pW4vI2Y3HSfBf?=
 =?iso-8859-1?Q?c+44bfgQh3aHSyRe+7cHq8g4hODTD594cNGmn9VjqdRu51XytbVPxHad6S?=
 =?iso-8859-1?Q?pdnOmDtO5F/riAN8wMX2Ir6F1P6iXEwX+GsfpKQcwPtSr/s9Vw03Lg0fKx?=
 =?iso-8859-1?Q?+w3QjzTHvweqF3sYgTxmDJTjJrGosr72svBGjTbF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0KhFlIXrENLixYWs+YwiCadJOikpZyBWZY8gFTnJpievZn+gByBgnXHcZU?=
 =?iso-8859-1?Q?jy/wWtw9JKk4MgXpXG6XX95NmLYTiikA7n/sxnfnuUladUXYf/sSEb7tdQ?=
 =?iso-8859-1?Q?I1a2BdgQWb+jA03Kk7SpCzxckOvRyfUZg/x4o+quuAGuQazWA8YXK2Ihr8?=
 =?iso-8859-1?Q?oyhy3/QkL4qUhrcUKcE0ETjILIC0BpPc/UFgDcPLgjRxHFf7Hx/4WLLiLt?=
 =?iso-8859-1?Q?vzp0zZ4LxxOjmU/73SajMh9hs9h/f/rJRO1bKIJRYlExzIfFYSK2CEhMjz?=
 =?iso-8859-1?Q?r+NbHFeyp3NcV2ky34LlU583fAu3CmnSyWz1YwrcREPHSvy+NuCwchdVhs?=
 =?iso-8859-1?Q?iEIN+FlgtF2b3EV5ikvOG+YoH0h1dX2asEZ82zbVsp05DHFHU6QzQ5HhLU?=
 =?iso-8859-1?Q?agiSkk3XyvgN2+4p4CJq7cBJPEDTLXcVakiEjd+F6jPkSzHXQa38eSofv4?=
 =?iso-8859-1?Q?C/R9F70dPM4VehgMiV3+nBc6SiWo3QmXqbtgjRIUnA183/A7+hnHxGm5Yj?=
 =?iso-8859-1?Q?DTZTe280YZc4xvpAphPi+tRyQkVp9OQADs9/Y/j0hJkpY8Qov4j/GQaEgL?=
 =?iso-8859-1?Q?n1ZmNMv2JGk8Dj6rV3lRyYnJ8hjRK4kUNwFluffsggo7XMuSPUUYzWuA4l?=
 =?iso-8859-1?Q?C64Jb9lsKqB+M8KEAlzqTZdOEaNQ0k2+EIvc1071UCsGvmu7E5zTYdMzzH?=
 =?iso-8859-1?Q?l52hdDw3pVs//d0eMpJf9cA8MT4lKr/QijaHR76JW8vsCKMyYF3CGl7/WC?=
 =?iso-8859-1?Q?qz5hZkiYbSS/2hO2YFdkI1LHyWNhYHZJnPz0tZPF/GTo1p91d4Jmc9zDTs?=
 =?iso-8859-1?Q?d/6cHTvMI3hG2zKbplVOZxOvFDtrsBW7qjkYJgq6pPx8BoD93mcUR1h8cz?=
 =?iso-8859-1?Q?GGNYSUwgMzY/GRTmc57214NbqFIS7X+BtKhujBXnMN6mUNd/emLdHf7pkB?=
 =?iso-8859-1?Q?uk+60YZw2YIYXLR56jubm5HsQ2n9/n/tN641hOwuUP1wjyecgskKUaODQK?=
 =?iso-8859-1?Q?jD6k9XJN1EW09R83fWTF5A+8wcRhmOmi/h8E4QSC7m5KxOBS83ix1B2/Ll?=
 =?iso-8859-1?Q?J/DfcfisW3zBnYAHw3Cj3BSlDEO/mq/M6+wI/fNKC8S4wr5NHOyapaPRhK?=
 =?iso-8859-1?Q?HMRmZL37D9jpU8SEBSZMcNWeSmZNA93hj5n+GFw7orsc94Dp8Sdwm5aGmX?=
 =?iso-8859-1?Q?pz8esJrsnczu0W/HF1v8XSCuCtUq9vul1wG/keI3zoS8/Nis6kPuqk7Ddy?=
 =?iso-8859-1?Q?3++fsKB1BMy5WNrvLRX2eN70pI7Vuy4QkYZsbn94H5ZUAkJltPyf8GgMUI?=
 =?iso-8859-1?Q?/a7qausJC1uftz9wzhkmi5B4q9qF67QUfflPQA52/75A0mUJuScbYxkJZP?=
 =?iso-8859-1?Q?srZVpmLN4fZdgKgAW43I1Lt5wSKt+jzX4TaNyeBtqpXdD8CDBYHw0Nlmn+?=
 =?iso-8859-1?Q?9all0uXxCmBplCDkeuM+jUhrR71Gm3wnd8h2YYoQICWk1gD1ADMSQK2058?=
 =?iso-8859-1?Q?fIsV4baPwCl/e5i42kMenyboEq/1rrwqt+Je3Flzge2tge481fvJudNQ8I?=
 =?iso-8859-1?Q?w1uJ2s/s00cvaO1M3Nbz5H/I5vUKdR1svpFPt6zZPs39Emy0snru7vl3Qb?=
 =?iso-8859-1?Q?ctEIOz7kyufeyTwJ80OoaD6/ANHFbW7QVI80IIJ+t7+PVcE2/hX0+yO2PM?=
 =?iso-8859-1?Q?8MBt6KMgt/Gx1SEMpoIr7EKK0AzOhmzB+63ZGQlb4kzET5/oxUkZTya603?=
 =?iso-8859-1?Q?/4JLqodNRg4lXJ+Ww+UPPHaYWfdzzdDCCWtCD8ppqqZUf3sZFcv0DKWxB/?=
 =?iso-8859-1?Q?LhQqJm9xFQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f087ddab-ed06-41f9-db9a-08de688436b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:19.5872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5wVX1XNUeQ2YZy3noecJpt+SyXfVU1Bc8vmG/aI2Eglnxkl3FGbKMkHP9pQfHtOV7rNaAN8EeILJsKWCxpVcrnkBCvBCvuXaHZ80BDEeQV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5264
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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
v4:=0A=
  1. Add Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com> at the end of =
each patch.=0A=
=0A=
v5:=0A=
  1. Address review feedback by updating the I3C bus and device to use the=
=0A=
   DEFINE_TYPES() macro instead of an explicit type registration function.=
=0A=
  2. Rename variables to `parent_obj` for the parent object and `parent_cla=
ss`=0A=
   for the parent class to comply with QEMU QOM coding style guidelines.=0A=
=0A=
Jamin Lin (2):=0A=
  hw/i3c/aspeed_i3c: Switch to DEFINE_TYPES() and align parent_obj=0A=
    naming=0A=
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
 include/hw/{misc =3D> i3c}/aspeed_i3c.h         |   31 +-=0A=
 include/hw/i3c/dw-i3c.h                       |  199 ++=0A=
 include/hw/i3c/i3c.h                          |  277 +++=0A=
 include/hw/i3c/mock-i3c-target.h              |   52 +=0A=
 hw/i3c/aspeed_i3c.c                           |  258 +++=0A=
 hw/i3c/core.c                                 |  664 ++++++=0A=
 hw/i3c/dw-i3c.c                               | 1862 +++++++++++++++++=0A=
 hw/i3c/mock-i3c-target.c                      |  298 +++=0A=
 hw/misc/aspeed_i3c.c                          |  383 ----=0A=
 hw/Kconfig                                    |    1 +=0A=
 hw/arm/Kconfig                                |    3 +=0A=
 hw/i3c/Kconfig                                |   15 +=0A=
 hw/i3c/meson.build                            |    6 +=0A=
 hw/i3c/trace-events                           |   48 +=0A=
 hw/meson.build                                |    1 +=0A=
 hw/misc/meson.build                           |    1 -=0A=
 hw/misc/trace-events                          |    6 -=0A=
 .../functional/arm/test_aspeed_ast2600_sdk.py |   12 +=0A=
 21 files changed, 3710 insertions(+), 412 deletions(-)=0A=
 create mode 100644 hw/i3c/trace.h=0A=
 rename include/hw/{misc =3D> i3c}/aspeed_i3c.h (53%)=0A=
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

