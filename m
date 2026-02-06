Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CE2E8B364
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCNr-0000Q0-F2; Thu, 05 Feb 2026 22:19:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNj-0000PW-1u; Thu, 05 Feb 2026 22:19:43 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNg-0008HM-Nh; Thu, 05 Feb 2026 22:19:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6i7LRUTmrc9HCGIdC6B8KUerizX8tCgZ9wp2at0Qs4yUG6Ndueiuj61209j9py7IJdVUiBwi4/cJnwAzxtbX/X+gbvAMDR9oNKLXBR4MPTVhjBY/txag1B76BvLQj6+f5kW7s1cbURH7veDw9gItp0kB1hZHAPZhDW/Xib6RhxZvpTh/UNxAR6tH6/ZSYOFLPMyhE6v8FRWzJEQCtbqF/Bd6bArY+mpJPJEuc286WcTl7HtLCaPOVeABB8dAVYZYbJBFbNBPk3KtbjY8gM5E472EWAaa0Vjh52gnBza+9hZ16Yhpif2Y0UDTnP5RWnoGgHEdWC87ZaYEXyOUVBe2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1VharO2tbWa39atTgLV0i8OCFEVINkKrMJYJa9qMlVA=;
 b=rucQDC61KUM/EqeAlB+qUu2P3ccLUIs3lz8LVQHtGjANOyV9A27zFxbMo4TaYdwK/OiVsrw2/lIN51Evgl3QE0lRxnPjic2nwUCCpPEZ36IPU0mkYo3f7DGtouzxqUAxcjn2SsUxs9hT4RNknLLzjQyViTVnBml3JTCFlIomqxCDWISaSujKQK+mUlZctRX6w+F7jD4+dQiTuUaoyqaKhHL5bQ4HEhxQONjlZDc++bBOGS3GNwOOiMFP+tzZjHV01MzRX9NxHwKbQHHdNtndLcQ1Dg7ZOINu1ZPjS+uQNERo/CykeRxzYS9erfrgKt1RgKyKYcBXfEh176zHfeG9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VharO2tbWa39atTgLV0i8OCFEVINkKrMJYJa9qMlVA=;
 b=Ts4E1pYj2rzC2eFdrXpry0A+1MFOyfiRJL28GIrwRr/gsEAasvLPrkylcG6Vx99Zjw4Qevf2OqqNxBYI231e9Vm+rOYAyxU2uzOgA2bcrqkxx6A8/mXZehZMTKzoZBgL7altPqRKcrHccxKMVfPpD4xK8P8eX/fdHl9k1JLERW6hTFoghnC8Gvyv3Uay8fals6FbTPQ+/E4m7ToX3kx1z8ylEZSc/2BlrXBMSr6v/dsLeZxwj63PFWL293OG3agKdygSq1Hloxd0kPBRUDOQJqjsCacJLz5ANu2tgrR0oQjvo1LmTbRQTr1BggtwBsnB5ZHuXyt2MFS59oimCSKv1w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5762.apcprd06.prod.outlook.com (2603:1096:101:ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 03:19:29 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:29 +0000
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
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>, Titus Rwantare <titusr@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 01/20] hw/misc/aspeed_i3c: Move to i3c directory
Thread-Topic: [PATCH v3 01/20] hw/misc/aspeed_i3c: Move to i3c directory
Thread-Index: AQHclxdnleJQsKDzIE6abQ/BqMo6qA==
Date: Fri, 6 Feb 2026 03:19:29 +0000
Message-ID: <20260206031926.3227848-2-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5762:EE_
x-ms-office365-filtering-correlation-id: 562237bb-4cf8-48c2-2b0c-08de652e8a07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?qtEFzeLeVKp4P9NeZb6Tp/tdPeJgf8BwQZvdkCNXCseOUSv1bFa3E5o2iY?=
 =?iso-8859-1?Q?nxxFeaNzkG6Ul4vnY9E3D6COkiwKlcqslHmdq1n4WZsrdDTDHuP+t/GPE6?=
 =?iso-8859-1?Q?OuXaDTfeJx6x50PiDCQD9qgZHjVngifz3uY5e2n1EmbM/XR1JJTap2lMNZ?=
 =?iso-8859-1?Q?UlG1F5xsalSz57Twp0iPuyvx5ydmmnCDS5E31NeGISu1G2C5pGYn1fZeSO?=
 =?iso-8859-1?Q?Gg2BqoAvNLRbqzUwEma0q5xehymxtUpN7FSUdCkTTciELxw/iangzo3PRi?=
 =?iso-8859-1?Q?Leylj8VmiF8vlH5cG7+S7ShjZGV3Qwiq+1I3rXNLk2HO9sx9dk4oj8cUop?=
 =?iso-8859-1?Q?3VlQK/ekL9dJbzffOpkJHmrTWi1vNzuVvnBzGzbFuErfvg4lLe2lCIFaT+?=
 =?iso-8859-1?Q?pgay29/oIR7wHtC1hpQV3aw5kbG8OOdPnYJp9Tk255IAVis+xZTtkB2Lty?=
 =?iso-8859-1?Q?Yxq1c3KuhD07L/lAeTY2IU8yBTSFPpMhH3Y0kK3LIpk2sAv71y23E/SNDN?=
 =?iso-8859-1?Q?2fB+DIFkd2TPTrm0EOboa5cG0JgEfX1k8Dq0PkmZh76hghefo/3Wo56z3M?=
 =?iso-8859-1?Q?gvJ0Axor0AoG8CzXh6nyw2CQa5IvRQAZfPVwC6KS9vHbv3Xr4UlKE7yQ4G?=
 =?iso-8859-1?Q?jHgh6do/3HnrqyoOHS0ljCgx2iUhQtvsg9Geha0r3DN9qI6hrbj9f7KlAT?=
 =?iso-8859-1?Q?d+AqBm7gi/w6QpWroGgkUa/C2m/oGiLIWsN225+zVFW0CS076mdXKAKQhA?=
 =?iso-8859-1?Q?OwLJsFQiKtsvTpxn06jLKU5MToBrQeLLOlJlpfjSCu2PStysdBEWr6wOnO?=
 =?iso-8859-1?Q?pvRH3AU1PGwKMg/e+S4R6ZQL6J/iknljzZav1R9OrvCWSHjL0aGV5G7Nxr?=
 =?iso-8859-1?Q?c8s+RZSNSPerau6TKT9IBpgrSR5g3qrPD+u8vuk7dew51pDw7ld8pLzMlU?=
 =?iso-8859-1?Q?DSlm+Lp0L7wdwHm8V1RoLdqE9ypbpq8C6JyKGo+2JP1M8mxcHup4GSuAca?=
 =?iso-8859-1?Q?tW0jEdslgwwlxMgYe532BRlS94LwqIdBcQ1GB8pAbejECrvqZPmFf974iM?=
 =?iso-8859-1?Q?6ny4x9ie4QvD161DTNQsgkywW1xe/cNbOO4goUYRStw/KjiyhmZfIdx4HH?=
 =?iso-8859-1?Q?IgwxjNGZLoHh63g94Lquu+3a0e8TLdaV3pFEtje/IogSxrM2pFXqdAMotn?=
 =?iso-8859-1?Q?BtZJQ+6jk9SoXgbUA5awdmjOcrPZqftUnz63x6XiISDO+bbFtCb/61Id1X?=
 =?iso-8859-1?Q?sMEMPodw6tm9xLnnkAz0kUI/PFZDQzi24TFdNo7chsnJxumKLsyabO0wPI?=
 =?iso-8859-1?Q?sONXfOwmwp7rHNcScU0NVofamk+6rCnIwKO/RM3v+/TvJXchO/+xJ9VEmV?=
 =?iso-8859-1?Q?J9Jy58Q96Ylwvim3KDOpsbn+n26mqq2Kka+HTAI1NUthOIBed1TF7XS3+Q?=
 =?iso-8859-1?Q?l8gwxWADmAraoaT1f9U0+Sr4xXOnTuPEdGoQETBnOTrfjYkWZqRWkTB+he?=
 =?iso-8859-1?Q?Wpr6MmGx4xjwS99eprZ4EivTqbyelnE5ngjkj+VBK6fLKTUAuvDGUMCz3E?=
 =?iso-8859-1?Q?x5wMo+Q1UsysvY09sH9645zvRWd5uHRw7a1rj88IX+lmLKsSp5xWzUOpsN?=
 =?iso-8859-1?Q?MqUpTgoOZFeKFfQ6hBeVUaBooAk26ctvz/xbRGRLcMURYve1JwUVMzP2AJ?=
 =?iso-8859-1?Q?AtmYGjciMinmkaID+cmONcaVgKbj3lDUzdTyaSyH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hu6l6j3V6fT0dIluvqaC2Rhn/WxHhpU3MFya4T0y9CqYLpvhahbj/biIeZ?=
 =?iso-8859-1?Q?gSMkDr0s0BBnC3MeDLpMNvbN29AyXat47sjZSeNGLfnLiaFOCj7V7FKxhE?=
 =?iso-8859-1?Q?IfsiObVnYZUUTPenk3ld8PIKn5+MJCWL7YQP2d/cRu7Mkpcyp2EVaa1mdd?=
 =?iso-8859-1?Q?9LnWAb5VMESfaIO0NZ1WIkFmEh5J77FyDA5XLltSrRlDHnHaG4VQ9l5vQX?=
 =?iso-8859-1?Q?IOqM4M788fTnjsKN62K5xU6manllfnY52qHUEyQar5ULnp7YZDT91URlWl?=
 =?iso-8859-1?Q?NRXR5QxlIm8kIKLnAjUNxuk8wo/UvJZtzQk4c3KX8tuGepvFdtryze74nq?=
 =?iso-8859-1?Q?wYTdH89im9RbGxIvCr+PP56hcqm52otrOLB4Ggcas3Z9kSUW0k0/9+DwJf?=
 =?iso-8859-1?Q?mOvJkFvBs6ABKViRUBjv+YGWW9gvELvlHcUjcHCydV05wCaQl/hkW1MMfw?=
 =?iso-8859-1?Q?VXcCT84w3oL5DkzLBYpwCQCCe37IOd0XzGouN803yWcbAuWWR4xmrBxS2N?=
 =?iso-8859-1?Q?7E+NI2ApGW+FLMSQvT3Z/eEaCFz8nt2Ttyg7lsQxDSrHK29jgcGMI+oAhM?=
 =?iso-8859-1?Q?jdYFzfD55v0xaEwLGtaoE1IGAjC++DK8EAnimgNgbYdry32btemUx0orWU?=
 =?iso-8859-1?Q?sBFATqTzN8guNS1haXA3Oq4uomIWWDlmjP9T2oJiHNu8iJ6UIX+yqBkIzK?=
 =?iso-8859-1?Q?WoGUoP7I0XkMBBCbfl9IqGZhJuCNOl1g/JLWyOs+9uvppqlGhyF4OmW7jF?=
 =?iso-8859-1?Q?x/svRNUOTnFaRHKkv9hPlniLfrXesuMQv3rxVQ1ZmawgETjubivcaZAnwy?=
 =?iso-8859-1?Q?g9qTyoN23uY8Rs2vqL43v8+3D8cCIQS/jVxYdxgSNotJEeP8EX7bWquYLa?=
 =?iso-8859-1?Q?o/bTSAC0oilye+O9GN6a+htkDCnlY4nqOgQV1Q/t5vwELctaIIcw75cnwg?=
 =?iso-8859-1?Q?DGhGY6SewrDmA9WXVgYZ5g4vbA5KeXGtS2vw+ppQ/zvokw0Uhygp85Y3XR?=
 =?iso-8859-1?Q?/K2/WGpQvnFObipf1nL7Ew0Uj+PvMKe3ROgFSH+Uji1c9Pt64BDPmLhwML?=
 =?iso-8859-1?Q?FOtNY7GMx9K9THxc/veYfmWby3ShtWzND0Sqbab4ie81lyAyzPkQ57iSfk?=
 =?iso-8859-1?Q?+s6XYH+fK7rK6RQpzEIoEFsfqN6zvFlH+TVeDHYfIwQyixFYvTIXEX6Jwj?=
 =?iso-8859-1?Q?+YE+AHOy3nMnAa7dUyw29oGxNa0tziYtnd9rhbDNvxj3Q22s3E+zs3JTj8?=
 =?iso-8859-1?Q?bjLplAuJA4yqmxSweGp00vB6L1LpSNzpWzCplHhqjZe1A6+sIkzUaka9Fu?=
 =?iso-8859-1?Q?QgF/S1f3pjRFjzQHXPOhz4Q+R5x1NbUDV2CRzSUUTzw6orzWxFqUmOQmBU?=
 =?iso-8859-1?Q?UgIRZucAjis/9vf9VraxDLdO37300HkGgCldZ14DVPVnONggmb8BRJF/iH?=
 =?iso-8859-1?Q?94DH7gYIvMYVLbWatFkaHOKqplK65C2uaF/OnFYyv2W4qx90wwHLAaNPid?=
 =?iso-8859-1?Q?qpiD64t4XIoVRnZrcDkbtoWS+iulqd5gN0x72odWuHhCM202W+HSTwP4r6?=
 =?iso-8859-1?Q?zXhoQXfGcBZ2UxaEq/y2UHTUDc+vzn9yFSY15uBXKfA44WGNyiCALvtbP1?=
 =?iso-8859-1?Q?IcCcpNjIjJ+WkN6YQO/xkcYcmWqHp2y2OcUMJtqmNhbBzneUsjGmm7aggN?=
 =?iso-8859-1?Q?KAHIMX4u8Kun9PBgCC8bC9nxoo8G77RvTIyNepGVjcExPWgRtLKtjuCVmH?=
 =?iso-8859-1?Q?XoHy15eJlfdudbeOdgiHQybDzAJM+e4uySMhyO1nezUJxHWQ22LvvSOLRV?=
 =?iso-8859-1?Q?oiyhfbHj4g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562237bb-4cf8-48c2-2b0c-08de652e8a07
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:29.1600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8FelOhSiZ0sin4HmYNut368NNmQxCQROES0qbUOWoRIr9Xq9073wAXXrTwTlTfbW901oMq39BXxcHjfJHIcGsf2DWA6D7ZucnNjMF+WKbmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5762
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

Moves the Aspeed I3C model and traces into hw/i3c and creates I3C build=0A=
files.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Titus Rwantare <titusr@google.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 meson.build                           | 1 +=0A=
 hw/i3c/trace.h                        | 2 ++=0A=
 include/hw/arm/aspeed_soc.h           | 2 +-=0A=
 include/hw/{misc =3D> i3c}/aspeed_i3c.h | 0=0A=
 hw/{misc =3D> i3c}/aspeed_i3c.c         | 2 +-=0A=
 hw/Kconfig                            | 1 +=0A=
 hw/arm/Kconfig                        | 1 +=0A=
 hw/i3c/Kconfig                        | 2 ++=0A=
 hw/i3c/meson.build                    | 3 +++=0A=
 hw/i3c/trace-events                   | 7 +++++++=0A=
 hw/meson.build                        | 1 +=0A=
 hw/misc/meson.build                   | 1 -=0A=
 hw/misc/trace-events                  | 6 ------=0A=
 13 files changed, 20 insertions(+), 9 deletions(-)=0A=
 create mode 100644 hw/i3c/trace.h=0A=
 rename include/hw/{misc =3D> i3c}/aspeed_i3c.h (100%)=0A=
 rename hw/{misc =3D> i3c}/aspeed_i3c.c (99%)=0A=
 create mode 100644 hw/i3c/Kconfig=0A=
 create mode 100644 hw/i3c/meson.build=0A=
 create mode 100644 hw/i3c/trace-events=0A=
=0A=
diff --git a/meson.build b/meson.build=0A=
index 8c6c0a9a32..d20ec383df 100644=0A=
--- a/meson.build=0A=
+++ b/meson.build=0A=
@@ -3602,6 +3602,7 @@ if have_system=0A=
     'hw/fsi',=0A=
     'hw/hyperv',=0A=
     'hw/i2c',=0A=
+    'hw/i3c',=0A=
     'hw/i386',=0A=
     'hw/i386/xen',=0A=
     'hw/i386/kvm',=0A=
diff --git a/hw/i3c/trace.h b/hw/i3c/trace.h=0A=
new file mode 100644=0A=
index 0000000000..1e0c4eadf0=0A=
--- /dev/null=0A=
+++ b/hw/i3c/trace.h=0A=
@@ -0,0 +1,2 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0-or-later */=0A=
+#include "trace/trace-hw_i3c.h"=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index b185b04186..d7b3647ca1 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -23,7 +23,7 @@=0A=
 #include "hw/timer/aspeed_timer.h"=0A=
 #include "hw/rtc/aspeed_rtc.h"=0A=
 #include "hw/i2c/aspeed_i2c.h"=0A=
-#include "hw/misc/aspeed_i3c.h"=0A=
+#include "hw/i3c/aspeed_i3c.h"=0A=
 #include "hw/ssi/aspeed_smc.h"=0A=
 #include "hw/misc/aspeed_hace.h"=0A=
 #include "hw/misc/aspeed_sbc.h"=0A=
diff --git a/include/hw/misc/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
similarity index 100%=0A=
rename from include/hw/misc/aspeed_i3c.h=0A=
rename to include/hw/i3c/aspeed_i3c.h=0A=
diff --git a/hw/misc/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
similarity index 99%=0A=
rename from hw/misc/aspeed_i3c.c=0A=
rename to hw/i3c/aspeed_i3c.c=0A=
index ac6db214ee..fff259ff66 100644=0A=
--- a/hw/misc/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -10,7 +10,7 @@=0A=
 #include "qemu/osdep.h"=0A=
 #include "qemu/log.h"=0A=
 #include "qemu/error-report.h"=0A=
-#include "hw/misc/aspeed_i3c.h"=0A=
+#include "hw/i3c/aspeed_i3c.h"=0A=
 #include "hw/core/registerfields.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 #include "qapi/error.h"=0A=
diff --git a/hw/Kconfig b/hw/Kconfig=0A=
index 9e6c789ae7..c53f94d96a 100644=0A=
--- a/hw/Kconfig=0A=
+++ b/hw/Kconfig=0A=
@@ -13,6 +13,7 @@ source fsi/Kconfig=0A=
 source gpio/Kconfig=0A=
 source hyperv/Kconfig=0A=
 source i2c/Kconfig=0A=
+source i3c/Kconfig=0A=
 source ide/Kconfig=0A=
 source input/Kconfig=0A=
 source intc/Kconfig=0A=
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig=0A=
index c66c452737..8344b9769f 100644=0A=
--- a/hw/arm/Kconfig=0A=
+++ b/hw/arm/Kconfig=0A=
@@ -545,6 +545,7 @@ config ASPEED_SOC=0A=
     select DS1338=0A=
     select FTGMAC100=0A=
     select I2C=0A=
+    select I3C=0A=
     select DPS310=0A=
     select PCA9552=0A=
     select PCA9554=0A=
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig=0A=
new file mode 100644=0A=
index 0000000000..e07fe445c6=0A=
--- /dev/null=0A=
+++ b/hw/i3c/Kconfig=0A=
@@ -0,0 +1,2 @@=0A=
+config I3C=0A=
+    bool=0A=
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build=0A=
new file mode 100644=0A=
index 0000000000..ebf20325cb=0A=
--- /dev/null=0A=
+++ b/hw/i3c/meson.build=0A=
@@ -0,0 +1,3 @@=0A=
+i3c_ss =3D ss.source_set()=0A=
+i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))=0A=
+system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)=0A=
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events=0A=
new file mode 100644=0A=
index 0000000000..3ead84eb45=0A=
--- /dev/null=0A=
+++ b/hw/i3c/trace-events=0A=
@@ -0,0 +1,7 @@=0A=
+# See docs/devel/tracing.rst for syntax documentation.=0A=
+=0A=
+# aspeed_i3c.c=0A=
+aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRI=
x64 " data 0x%" PRIx64=0A=
+aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" P=
RIx64 " data 0x%" PRIx64=0A=
+aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) =
"I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
+aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data)=
 "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
diff --git a/hw/meson.build b/hw/meson.build=0A=
index 1022bdb806..e05dc4864c 100644=0A=
--- a/hw/meson.build=0A=
+++ b/hw/meson.build=0A=
@@ -35,6 +35,7 @@ subdir('dma')=0A=
 subdir('gpio')=0A=
 subdir('hyperv')=0A=
 subdir('i2c')=0A=
+subdir('i3c')=0A=
 subdir('ide')=0A=
 subdir('input')=0A=
 subdir('intc')=0A=
diff --git a/hw/misc/meson.build b/hw/misc/meson.build=0A=
index d304a98498..96b6705b7d 100644=0A=
--- a/hw/misc/meson.build=0A=
+++ b/hw/misc/meson.build=0A=
@@ -135,7 +135,6 @@ system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: fil=
es('pvpanic-mmio.c'))=0A=
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))=0A=
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(=0A=
   'aspeed_hace.c',=0A=
-  'aspeed_i3c.c',=0A=
   'aspeed_lpc.c',=0A=
   'aspeed_ltpi.c',=0A=
   'aspeed_pwm.c',=0A=
diff --git a/hw/misc/trace-events b/hw/misc/trace-events=0A=
index d6af2fcf85..b88accc437 100644=0A=
--- a/hw/misc/trace-events=0A=
+++ b/hw/misc/trace-events=0A=
@@ -293,12 +293,6 @@ armsse_mhu_write(uint64_t offset, uint64_t data, unsig=
ned size) "SSE-200 MHU wri=0A=
 # aspeed_xdma.c=0A=
 aspeed_xdma_write(uint64_t offset, uint64_t data) "XDMA write: offset 0x%"=
 PRIx64 " data 0x%" PRIx64=0A=
 =0A=
-# aspeed_i3c.c=0A=
-aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRI=
x64 " data 0x%" PRIx64=0A=
-aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" P=
RIx64 " data 0x%" PRIx64=0A=
-aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) =
"I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
-aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data)=
 "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64=0A=
-=0A=
 # aspeed_pwm.c=0A=
 aspeed_pwm_read(uint64_t offset, uint64_t data) "read: offset 0x%" PRIx64 =
" data 0x%" PRIx64=0A=
 aspeed_pwm_write(uint64_t offset, uint64_t data) "write: offset 0x%" PRIx6=
4 " data 0x%" PRIx64=0A=
-- =0A=
2.43.0=0A=

