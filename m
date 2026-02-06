Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B752CEB28C8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 05:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voETl-0003a3-HS; Fri, 06 Feb 2026 00:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETi-0003Xx-PZ; Fri, 06 Feb 2026 00:34:02 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voETh-0007Vv-9l; Fri, 06 Feb 2026 00:34:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVAnkZSN/8c674QbE7xgAdSTTgU/JF8kleLca0ukLAifhYvC6jssggKlSxfDLaEfQAh2OEub4O0pyjVZzlK/y7bDm/GOyw7oWwp7c1nxywWINYWAPk+e+t5oArLVQipheZGKWi8bAfOAQMGMskCqayKwPjq0ivtCAnFV5FooJ9mj14D4vPN3Hk1frYcPi9wdCAcS8omRn8ZNhRDCaXPwnduO59SzNrIWlSLpBEip7s10NECYwcqrutdkQwoMaJnoS0+QAxWudp/17M8RFuw/Jd27aqBaDX6pQF0rZosGdGMWmcE2Rl5TYJxGJSvpFCHovLWWEVfapaPwZWe7G6sdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSZy9Of9sIdv3Tk3vJ/xdserGlvqusld2DETWj5LMho=;
 b=BxFPe18DPt95595YqNybloFJbktV7E8EkrQEA3j2NF0DU7tddfuMdrKKHCtep3nuc/xdBEIq/edVbDIadSr3fgr9h7R8MhthqYqLeWUn8nDmZGREqLkifPpD0exv3vfiVnMBA50ZHdiUdnwg0j2r/oDMLrir/jci1JPCkigTl90urFrAzJN76nqMaxvcr0LuHhvn+F6qLZZALZZ1Tzn3gF0/lxb+7KQhjK6ACGX3Z2Q6Xn2Xb+phn56FqB0R2g7meS3d3lIYKsqIUlhpKUO5EUVzKe3HLDMISMAkCG2nWVdEJyC0XatY0AR51byyLrMrGV3ywi/ZKbw8qr5kVVhhCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSZy9Of9sIdv3Tk3vJ/xdserGlvqusld2DETWj5LMho=;
 b=aJKHV2tf47yzRpaqgGmEMlcoq2cYVkLyGGP/C0ExdlvoXyrD/q6LCdtvk/VicUjr2GU72XMDHZPQuIcbBaTnKkbRenC8s4emZUeAAq1bGBcK+8Qu4U7lMNkD2o0I1lySjJVhJBOnK8Vch9mr+aXgCvi+bl5Ld+fnYe45FeTm6Am9WQFw03eIFQ/+rtEdG6eLrVGLe1fKSL6XTD8rXqqNIm4Kh9GZL2sJI2PODfCKfTh3+Zs+dWsfX5jPPR+lZho0gpwyDrTkOhD7F3xmE107lA+h6PddT0OPT+UxBuauzPcR0oBr7t4xEuxh2kP08hSnrIJ2GJzAw6u4RfJeAEuLvg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5504.apcprd06.prod.outlook.com (2603:1096:101:a4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 05:33:46 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 05:33:46 +0000
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
Subject: [PATCH v1 03/10] hw/misc/aspeed_scu: Remove unused SoC silicon
 revision definitions
Thread-Topic: [PATCH v1 03/10] hw/misc/aspeed_scu: Remove unused SoC silicon
 revision definitions
Thread-Index: AQHclyop9fRIyd78G0upRXHR/xWroQ==
Date: Fri, 6 Feb 2026 05:33:46 +0000
Message-ID: <20260206053340.3716041-5-jamin_lin@aspeedtech.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5504:EE_
x-ms-office365-filtering-correlation-id: 5407bdd7-d5c4-446b-0b09-08de65414c82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fDnAb/QcnbjdCRSx9HVLPjGJc/3s73giV4BlrppFfDt4r4MgESXDM7mo29?=
 =?iso-8859-1?Q?wNgjRg+URKQtvzKyf5mEmjCE1CiiMQVs5/UzGGXIjWCvMGn7WcDjgh4yHH?=
 =?iso-8859-1?Q?Nm6ghKzHCPQqjrh4kMPSBQda/6I4xwQZXDVboPc3W3Yjc6ttRrQNADo+eO?=
 =?iso-8859-1?Q?0qlcP+51tRshqYC5lCJSCyHoqzsgHHstz/2y9GVxBawRLZKuUe4yxceCh2?=
 =?iso-8859-1?Q?yySNoplQMrVNLilDa0ot6BB3etBGEGD1gpXz+Q0c/umGV8tbrlgLbH+Z7y?=
 =?iso-8859-1?Q?Fy5j0OYHpGrLszVyWjQvK+faHdPcqZpIm2n/AiD5Bm5ebhs390mcDtd2Lo?=
 =?iso-8859-1?Q?8dAG8RfzU+PXrWVmk4VvqUSa7lReoDpI1G/uVNZYKrzMZy2iHQwNPUZEZm?=
 =?iso-8859-1?Q?fnPY3UEv+yny0SoYPk6o5Eyqx1mLQHNAcB6I4732zo0GQov9ZYUX5PPV4n?=
 =?iso-8859-1?Q?/jKrc34z0UjglKNVkacCqCJipMfeuVup6/LnE/8MjhuJIY2u/47+65iAvx?=
 =?iso-8859-1?Q?3N7QXFDlYBbWAaf3MKK9GMxk8DBtC7Ycd9ONgTzWwRDngGKoaQ114Qv3XW?=
 =?iso-8859-1?Q?zBUbt1WuAt5UBPZLBC2/CfLhqNWb7eDGJhcBPCUOrXif3HVl6ObsYJBIv2?=
 =?iso-8859-1?Q?k6ZM1QkT+Q9RYnnGP18K0bmX0Zn89dIo2B353UhVkPls6YWAwYYihm9Mf2?=
 =?iso-8859-1?Q?KEj+Gf7lngyyMKvGm4V0IMDy0in+X3s3a+GUQ3YDjqtTnca2nCmXBzCQb3?=
 =?iso-8859-1?Q?1KIgIk7KaJ7HrWH4JT3B7LNaRVQG4T/ADdUfEZWs504QK2JzpVB5YvNeWd?=
 =?iso-8859-1?Q?XM153+2fJ7dvcVVlNfw1UMPA8toKg2m1APG49sDpIpvBeve6woSww7d6m9?=
 =?iso-8859-1?Q?LdZIB7Y3NNDD3eurGCKKA/xTAChght2ExkZYYHKL/ahVTfxpjUvncKqZrp?=
 =?iso-8859-1?Q?cjrhBVt1bJlklwtMTzVifAdM1xkgRbNN1ey9v3ISuUcUi+445z7plu+rFg?=
 =?iso-8859-1?Q?PrlR1/K9P4rrG0bJNRQ0sNIMYhHilPFJay2jHoNFz4zUF7zh2bpVNxDPw1?=
 =?iso-8859-1?Q?bTPgi+U6rqaQzrbuOWBnmWmbE96MjL8eV1oFi0ArcJta6Z/dWaq2fpbVg3?=
 =?iso-8859-1?Q?X0//gO+16b6hOvTGNGuGrMD6oZVkvtEyLsN1nNuC01VdJFgbxc/XRixSwX?=
 =?iso-8859-1?Q?owezbfNg8ognuEtLGo1rucxnybqp7R61ufhr/dojnpopKoqSR9vaJ4kgEq?=
 =?iso-8859-1?Q?Upg/jHW9H2nknX0LyQVtkmScYhewrrl2Rmi5O9633t9umTN53OThKsbNrc?=
 =?iso-8859-1?Q?PClshUSK96U7w4t+F34CyhdhjDR02fr2PUyhUeridJ8DC7OYLOpCS3yf/M?=
 =?iso-8859-1?Q?EhOTIWMXUWm/eDNcYw0E8wZY4BsCnNvZxVWbJL4ILAH7zEpk4l4VFPUB9L?=
 =?iso-8859-1?Q?+G4vrjaD8DYOGudEhaO+TEu5GisNmn0/5bVIVYRSJLQlXskuQ61H2XTuCw?=
 =?iso-8859-1?Q?chucupLAtb3YtSl5rqC643SWBj40xQZvYSVvEgzpNcvVxBgUXhIxIeHj9s?=
 =?iso-8859-1?Q?j4f7mfjxhD6HupskvdTMQpSa0qATf7o2GsPrBvMXaim2RFl1r+jK5icBrk?=
 =?iso-8859-1?Q?a5UkZjUuVBPcF551LRkpKFQV2zjZhICvbFLKRakjL8iRhf1P/1LPDFB8rV?=
 =?iso-8859-1?Q?ZAZy89Sw1KLpdmIniakQgILW9F/7Kfzz2MoFOyKK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?w2HQnm0VDo+Bh9qH3kBq/cYTJYod7YL8ViaBxaSFS7s1eGtwiH0s+yf4ga?=
 =?iso-8859-1?Q?ociqQSsoPxctGrZh52nMOaEOgOtHrcgc0ort1BBW0BGf08UUY+o8oib3SU?=
 =?iso-8859-1?Q?vpu9sSW1+2VB4CsDIlgus6Ls1/WOtl0H1ePuSp0nEAKG0GF9ajY+y7Zh2k?=
 =?iso-8859-1?Q?ZnfYPN76ffgJwGghN2306EqDF77AQcjObUGxK1la9VLo00+XU3bCdKys3o?=
 =?iso-8859-1?Q?mK+TlLBnlGIxK487PvxUMWoOyF/cmKbRQzmqo1yP+Tfyv+hwzGNjhzrbSE?=
 =?iso-8859-1?Q?kOmgrSHMit+jD088NzJD6RPFO8PbkNWYBlHYg81DnxFXMueuro51Jq39nz?=
 =?iso-8859-1?Q?ihxEqgzy29wsHCoxRfDuX2PZ/KBLciMtfIXGPZKzuz3Kxy/+QTK32MrXqD?=
 =?iso-8859-1?Q?HeU1X6tKiOxyau3EdMIOUtsjXINlw0J8ddmEx2cLAACIj14xwPBwzGrLP1?=
 =?iso-8859-1?Q?DT49e3vxDfjR9fmN1qRVdHKjT/r3Aqmxhmrr7k/BmfB+JeQNOkUWgkBooW?=
 =?iso-8859-1?Q?FVrg0vSxndjrtxbAf3zn+zyxJvynL7bDEC0+HZSnPuUa/ZjEV7+4l+ZbV3?=
 =?iso-8859-1?Q?gwPdlVfeB9mxBUDtptEZRWkpCzVvmzm5Xr8h0BJBR3o8UQdtgZdT+ewSRy?=
 =?iso-8859-1?Q?AkZ+vYEpX4rcsoCRwa3eyCbC0xW7JEo2+8phlW09q80gGVhvDu30k1QJF4?=
 =?iso-8859-1?Q?Tu2f5Gc2YxUXdev8ciM8rHQwVn7aMnorYwXwpe/LmFdJOPEJtHcM5WWsZE?=
 =?iso-8859-1?Q?aT8WLTh4Z2P1R1s05a5LJYhyCwygSyOTELhmRSpbQJWu6cJ0QY7p0OfzVE?=
 =?iso-8859-1?Q?J7wCzQyYyQaHrD9Z2aiyrGMB2x1qm1LYLrCfyzC0jRImrgyPG5Cfu1N3t4?=
 =?iso-8859-1?Q?RfiVb+HqN2SQ8yWKxHgTbat0t1CF+tRU31y2c51PE0PKYqvMiq1lJu5XTq?=
 =?iso-8859-1?Q?+TSbbcBPfc/aEewuHBpccyKGJCQ2PZEWXYp5lEEg9MoypAYd5JjNivpAT7?=
 =?iso-8859-1?Q?dtXOw1MsP7EodzWlgipVvf8dFdkuShyrip+UI8eQJNmdg6UQd/7fAuoT4j?=
 =?iso-8859-1?Q?ILvG3e6UBOn6nH4zT5Jwt+vjtkOtf8Hkh4nFAqWb8qQah0n9ytv6XVW73i?=
 =?iso-8859-1?Q?yBFygtyMnMEAY8HLUsTwsOB0mR+g7JTrqu6dwlnzz10jaQ/fqHS4G2k4yB?=
 =?iso-8859-1?Q?KbZilMzwWI44NxKqtaSSvRrlZYTlaQJWM3n2106w68vHYM2wBDyE/78wh2?=
 =?iso-8859-1?Q?EOhz4JrzAESe5WX+iLf9CLcwFu9zObnFkNwXupCIeAUUNsnfpI30gdThAr?=
 =?iso-8859-1?Q?dpa/WqU5IRJOlSbC/4rWL9iSnedw4rqXlUJrZ3J123BfvSKQ1JcpDQIz7J?=
 =?iso-8859-1?Q?Q9GzIgDpSbBP5ndizPYL9zxZ90ADopewRODAvjdoBu4yjilixXAuARFVqc?=
 =?iso-8859-1?Q?AbzJizYZ+u+L1YhxNfwUJy2uGSJSqcFIPynhMY/e0j5BR7brwl9UWDq1zJ?=
 =?iso-8859-1?Q?crhOz+DjcB18GIPDyHgSwfm7YwPn+xWaXtLZweItkuVLUQ9lfoe5I4rrFD?=
 =?iso-8859-1?Q?nnW8WOAG2VsYsL8D1vmxcXSHHlKgOA77ahX5ZXQNEvTghVoLOMrPBOTP6f?=
 =?iso-8859-1?Q?6tVjEptEWt2zMzF/J0Bm+X797IjEH101SvjaBta2tv+h0BIakTtwEmgy+s?=
 =?iso-8859-1?Q?CyRkamsSk4Lv2vy6LFcyBbxD/2S1bai+jU9CuaAjBcjHEP0naJn/ruAn2W?=
 =?iso-8859-1?Q?1bifIOVuncFJV1uZUPZMK8h6x8cONewBebB45V302/cch4fI/zEk4VUoFE?=
 =?iso-8859-1?Q?g2KtiuA5Lg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5407bdd7-d5c4-446b-0b09-08de65414c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 05:33:46.3783 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Jg970BVMbEdZk/2+huVeYlytiUwrTgWtEytncS0V3rxUhcHI4gFHAoeglft5spRSM5mOrjQzCYxPusCZo+6d2yI8Ro+Oqf/fJEpFo9R+V0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5504
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

Several legacy Aspeed SoC silicon revision definitions are no longer=0A=
used by any machine models or runtime logic.=0A=
=0A=
Remove unused silicon revision macros and corresponding entries from=0A=
the silicon revision table to reduce dead code and improve=0A=
maintainability.=0A=
=0A=
No functional change intended.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h | 10 ----------=0A=
 hw/misc/aspeed_scu.c         | 10 ----------=0A=
 2 files changed, 20 deletions(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index 9e28bd4d2e..313a79f2f7 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -41,22 +41,12 @@ struct AspeedSCUState {=0A=
     uint32_t hw_prot_key;=0A=
 };=0A=
 =0A=
-#define AST2400_A0_SILICON_REV   0x02000303U=0A=
 #define AST2400_A1_SILICON_REV   0x02010303U=0A=
-#define AST2500_A0_SILICON_REV   0x04000303U=0A=
 #define AST2500_A1_SILICON_REV   0x04010303U=0A=
-#define AST2600_A0_SILICON_REV   0x05000303U=0A=
-#define AST2600_A1_SILICON_REV   0x05010303U=0A=
-#define AST2600_A2_SILICON_REV   0x05020303U=0A=
 #define AST2600_A3_SILICON_REV   0x05030303U=0A=
-#define AST1030_A0_SILICON_REV   0x80000000U=0A=
 #define AST1030_A1_SILICON_REV   0x80010000U=0A=
 #define AST1060_A2_SILICON_REV   0xA0030000U=0A=
-#define AST2700_A0_SILICON_REV   0x06000103U=0A=
-#define AST2720_A0_SILICON_REV   0x06000203U=0A=
-#define AST2750_A0_SILICON_REV   0x06000003U=0A=
 #define AST2700_A1_SILICON_REV   0x06010103U=0A=
-#define AST2750_A1_SILICON_REV   0x06010003U=0A=
 =0A=
 #define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) =3D=3D 0x=
04)=0A=
 =0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 6829efa2dc..0edf9c1b16 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -555,22 +555,12 @@ static void aspeed_scu_reset(DeviceState *dev)=0A=
 }=0A=
 =0A=
 static uint32_t aspeed_silicon_revs[] =3D {=0A=
-    AST2400_A0_SILICON_REV,=0A=
     AST2400_A1_SILICON_REV,=0A=
-    AST2500_A0_SILICON_REV,=0A=
     AST2500_A1_SILICON_REV,=0A=
-    AST2600_A0_SILICON_REV,=0A=
-    AST2600_A1_SILICON_REV,=0A=
-    AST2600_A2_SILICON_REV,=0A=
     AST2600_A3_SILICON_REV,=0A=
-    AST1030_A0_SILICON_REV,=0A=
     AST1030_A1_SILICON_REV,=0A=
     AST1060_A2_SILICON_REV,=0A=
-    AST2700_A0_SILICON_REV,=0A=
-    AST2720_A0_SILICON_REV,=0A=
-    AST2750_A0_SILICON_REV,=0A=
     AST2700_A1_SILICON_REV,=0A=
-    AST2750_A1_SILICON_REV,=0A=
 };=0A=
 =0A=
 bool is_supported_silicon_rev(uint32_t silicon_rev)=0A=
-- =0A=
2.43.0=0A=

