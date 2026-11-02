Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A755606A329
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=TBTO0ODk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoG1-0007RF-V4; Mon, 02 Nov 2026 04:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFE-0007Je-PO; Mon, 02 Nov 2026 04:22:24 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFD-0000Wj-8A; Mon, 02 Nov 2026 04:22:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ea40klhgdc2thbwzaGSi4pPKAIFldLRqFHhD7b3fjgjUrhf8ot7l07LQh1t1BaANxAVyLFA9tPH/E4lNQBt41Fdt35AbKWNYmgJfOj8OrogSRIhKrsz//YBjh5YNVbXchDxjDRbc8E5kHhqtMKrT7+/oigniyCrTXSP0s/7r76gJVoR8vanRTQk1d9RSnZlYg1l+1L02BtGvGJmNN3B8KlQA9RcAPsir9eYos3fTmIgb0BJYXCbjV+4Uh4dQLv75VakefC4SrhYG6Dn5wzHwl+GRaR+9MwOAtX6Fiu37YmjP8Vba0yGBY1rwXRVUFkiHJru96oZd+KCCS+Qx8WTIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7ugJp5+EyBp63kk42bQjTmAv+ji8R96jAVECGk951U=;
 b=TI/IV033LtB2ByoyIinicgx3feMchU7XZo6ZALky7FSVFCxhYPRal9cSnHS40LoYXog7txAQmsdkRteGslImzGpcqVGxgEp6bal9RwrKCMO2efBodTh2y0K5gDCwz53x1ngWyqlWbH1Az4rsrB32O79zpfflGcOby7E7EpV97A1TCUoTkgtsIEbZEG3qThEYcK/zHe0OVzRg1if5fweuqwrgclIyU0aXvaXPJvcfptyBAtQ7Ng/85ZDNin9CkwapSgBEOK8dfs7ISqb76P1UOIRmCdr6PMIcW+pH9+UislSoR97LJkmxR3HYbgTrEFf7E+gpZK4LgPNVZxq/eIsdpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7ugJp5+EyBp63kk42bQjTmAv+ji8R96jAVECGk951U=;
 b=TBTO0ODk7THthPF6jOO+E/rNAETCq0Tsw1yfbQkcisub6P2cQs7H5lvBb7+Lsz/rz8DipKV2cRAAQjKmRvmQ0YtPfpkfO9lxBmHwMQLDDUkeofiJQB4s2spr+uDOIHYU6YobwuAd2placuVHopFzAVNtiAUG5peQFbWuKMLOJ5mFIRjkkUY4Iac2xLeR9RMaEVMXpHNsbSS2ARfz1UELtoKMkKJ6X7TYBr9PFTHRuxVtsn6NMaPSVbRNu8CjrteGGiSPm8TcuE4FCsm4kQGVZ0Z58YQm9uHlAumOE25k/7+31sZ2rVQX5+G3gpj4gks0kkRo8WMkp+uFCSh6lQxlOQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6333.apcprd06.prod.outlook.com (2603:1096:101:145::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:22:16 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:15 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "clg@kaod.org" <clg@kaod.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Tyrone
 Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v8 09/18] hw/arm/npcm7xx: Keep the automatic hub
Thread-Topic: [PATCH v8 09/18] hw/arm/npcm7xx: Keep the automatic hub
Thread-Index: AQHdaqumID06mim1t02tHdx0pgsQmw==
Date: Mon, 2 Nov 2026 09:22:15 +0000
Message-ID: <20261102092201.1729245-10-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6333:EE_
x-ms-office365-filtering-correlation-id: 951d9524-7c82-4a90-009a-08df38c2c921
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|921020|38070700021|56012099006|261009223027099003|261021121427099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: sDxZcu6GIqOObRAFleptD1z7eEhmHs8esImPR2o912MarTfq6ot+NXEJDAYV/aGXj4DnCqvBDCaZ7L59XdDn6Gd2khFsUv/vSLB8hXJHmDhoBKadpfBsNTcUNRBYm4efInADx6o+xSCqEL2nqKLkbvHTkJNUA6HfAtX3ardQVL1A+UnJOah2S5pItoSrGxq8XCqSs2tu+d4Ak+0cq4fV1KMPjYo7PEHu+MePM1BiltEqI3VAYVFgRNc5d/zvyYrs+5x/0+PxcfQfyucbxyqhr3nS7nEZJg/O6vhxd15u7tLQTXwWrhtHp1qWvm2Ik1o3ZmM1WQseb2JzAcj9oxMmagI+4hVfIpJb2Bw5HV8IiiUuKq7wvWOcgQTFsqx5wqq/pR2hgTqVcDadtckpDTCBANeNu7ozSdX0GDMzYYRicOgvuAIHzblnNHnY1jpN09mDTVOSiu3apaWFNTsabu1hYqIe5D62TO3ztX987Jj9V8aYGpYgi+8ebscg09kN/ptOmsf+S8nq9jbkqzr5Dx67XN2oHsK1sKYlVW/PURdrs3TpETjnFDv696gqL72JcF2NW21ljHr8qD8O9SXv+DLVABOV0SQpg2A/BnicLI4e/PZj1O/APpeoI/JI0mESiE0MOMCWCpPDKCfKIRXD9M6XVCZEnOwybCmSkOYmcsCzGtW0Mc928k8mf7aXo3BN1cyuXlKuKSfxg+n63vfngbzk9PHJyuFycghO9NmjujqZ2xl0bSD0WWXzhhVAx8Crd8Nq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(921020)(38070700021)(56012099006)(261009223027099003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2GYl9b+J24KAsdAfAEazcVYEgDgNn6H4q4ZDJN+wjeHvX+i86v/tIpqpyB?=
 =?iso-8859-1?Q?8hxNTVLv5eCQlderDGG1pYh1V3DkqPKRndEYayF/6lC6/7/pKRpOSvtVsB?=
 =?iso-8859-1?Q?n7m9NOxVMBWpCTEbLR/wszhtI6nPSekmDMN/AA0KHGwDp2y5LEeikAgmTG?=
 =?iso-8859-1?Q?rzzZI5bb2/G/aKf9rJ1oh1akPWJb/XBoOVGTrLofhPFLIKwllqVJ4LubnG?=
 =?iso-8859-1?Q?CuGFmEjplxOQPqTuvkxn6+cuh7Zdg2WaqfyKrVWepRToUwV5lEpRTmurSm?=
 =?iso-8859-1?Q?njqp0MxKtFDm8oKRRmwQ5qOF3a/6LRDi6NaxpQCoIx/bF7kZjbTWBhiVem?=
 =?iso-8859-1?Q?3Qj+uQELPFRG2o0eD7ADeoaCnn2q79hlg6F0GXC5Ah0h+9GVVnDMak9szf?=
 =?iso-8859-1?Q?VJV7LS5+EAtKyGHAa2FvFNiHV4M6zBxM9ECczIuCNCXPSygKY4vR3DA955?=
 =?iso-8859-1?Q?rmRRsmQGO1/ah0f2eVEm/ZBR0/TQ8K0Nfl4zEXhgGd/pkG/k6hlL642b2U?=
 =?iso-8859-1?Q?lxIalU4xg4u64KNiBSgtbBc73QYCSf+pJmVtfTEZ4CyF0W89aj3xlCxs1r?=
 =?iso-8859-1?Q?oRBKAKFAHW++Yr8LMg0smVq+0lB+9Mft1VSNGhtYoXhDkKlt0OJznDwldc?=
 =?iso-8859-1?Q?lqeEybXm3RH59A3sibZlVN8f3eOXsy39d+ESEpZ9r0QerVNKmwP+W0wxju?=
 =?iso-8859-1?Q?KcOeADUYjZhZ5Z2wH0rVShYByMWVOWydYiqNNCo+jEdaRKH32mMR1PgiKS?=
 =?iso-8859-1?Q?ALFconlnATMsAhO9wVUglz+91XjUBJmM2GPFcCLD3JlSrqoKl/xMDzzFiv?=
 =?iso-8859-1?Q?IHV8v4wLZ4k4K3KqD9nwkz2LF0tLjHFXb/iaD6SoeTdPcE0Jau2JvNrBE/?=
 =?iso-8859-1?Q?+lZU5LFgj6IlyHGK7FfP8m7luGXwZ71HduF1i3p1wNhlgSNjpLcOwOsRz8?=
 =?iso-8859-1?Q?2JXURgRjlOSnUeFbpWBF+iQ8GNDjxygUmp977sl5bB3wOpCyylvTNH7NNl?=
 =?iso-8859-1?Q?DDYqzKzlt2I4BUUvSTrBVgIB2A+2ek0udEWqTHbQFXhT69yvKTb3Srd/gO?=
 =?iso-8859-1?Q?hZuT8chbEqKnxI7wBAM9kA3ElPcyXIhUFiDI1AR9NmQV8VjO94X02UA81P?=
 =?iso-8859-1?Q?bqXxUP5I3QCJY5/XuB5UciJ5b4IMr/VxrdCgRJsZREfUdNa8yRB3t9Ln74?=
 =?iso-8859-1?Q?nmiMLpIIHrLAgsH7TOg0P/ubzcnjWRwh2PO4HhQ7C6hEEwj8Pur0TxovvH?=
 =?iso-8859-1?Q?QzN1z0vy38E4xGiMmK7FAkOJUZbP8ccoxcHmTufAvYdvHHLxLNg0hkSEJh?=
 =?iso-8859-1?Q?OtIk/yt5fWKcEoFlf9KNRn+tecsGkF+Q6dI3xtpCiou/PFicZENmggYQZx?=
 =?iso-8859-1?Q?HxLE0ATJ92l2YXqEdTdyTTyu9rIny4f64CeoQyWe7R6B/wUFJMggxBtmGb?=
 =?iso-8859-1?Q?O/n15n4BNAkjVNbx2UsK+dPafyhle4o2388VCDoh3CH0IrHMVMorUT3MOM?=
 =?iso-8859-1?Q?exiqVv6A6GtPwvlCpp8/xnLHDEwYOeoDe37Kr90jC/4DIP/D+V9yE2Lf4o?=
 =?iso-8859-1?Q?W5Z5Ks/eOgOepkLh1QwoCc2Q/QrutZqj0qOzknCViISXyN6id4iaXJkdnS?=
 =?iso-8859-1?Q?iX7QW336ueCsiaPTtmYueE4xys+FHwAVDOxcZpnxF5ZHuBnfB6m33D5kKp?=
 =?iso-8859-1?Q?2hAFr12sG5YrdMyqDYL4Vp2kDp5D2cqXvPpl4GXoRlf2W+r0Y9if6HQLda?=
 =?iso-8859-1?Q?W8lOu2HHIgB9Y0x9XNvCXgBjGmTpzTBcxyeC2r3wxuLKJ+bJlfQV/gDktC?=
 =?iso-8859-1?Q?kOicU2lMWw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4DgmIJlnu6Dni/o1FZAyOKGhJDDdjVZR3r/cw4AqPr450QuYeagb+CyNZB2qjS5C7LplOoBtH5ghX69Hz7CB5OORO1MQQVHDpRycUgBQlkQUqDWjN/zRDyTXlAJR4GKlnzfjNVbtwTwf17cx1WKgTzbdKj4tX5jGfgHBE81dUp9VHph1wxZV1kZfKpC8oqzwpK89arvSzvjGv9uDTorSwxnWbWNvGUTkvTv79wSPAyB901+TonE9cqMfconBnVMyiWWVad+6sSYclFCmf1aukgj/FFP/G5332uJt4oZFT4P6nXQvs3rFgG8I3rv0ilfl+7x0dI5dBpSRIj9p2Lv7MA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951d9524-7c82-4a90-009a-08df38c2c921
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:15.9018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2h6LT/YnFpFfG4WpRpexhxpNezjx2GtBNzJP08g6rxEyIYUzIKlGK0J6qc0jm75Sb32FWQ5CNo3IdKdtjz1hrHuvk8mcYK/oMWl5cO8KF1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6333
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The OHCI companion has one port, so a second device only fits behind=0A=
the hub.=0A=
=0A=
npcm7xx has no versioned machine type, so compat cannot reach it. Turn=0A=
the property on here instead. The companion shares the EHCI bus, so=0A=
the EHCI carries the property.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/npcm7xx.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c=0A=
index 695f30a0dc..3f5b33d7e3 100644=0A=
--- a/hw/arm/npcm7xx.c=0A=
+++ b/hw/arm/npcm7xx.c=0A=
@@ -628,6 +628,8 @@ static void npcm7xx_realize(DeviceState *dev, Error **e=
rrp)=0A=
     /* USB Host */=0A=
     object_property_set_bool(OBJECT(&s->ehci), "companion-enable", true,=
=0A=
                              &error_abort);=0A=
+    object_property_set_bool(OBJECT(&s->ehci), "auto-hub", true,=0A=
+                             &error_abort);=0A=
     sysbus_realize(SYS_BUS_DEVICE(&s->ehci), &error_abort);=0A=
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci), 0, NPCM7XX_EHCI_BA);=0A=
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci), 0,=0A=
-- =0A=
2.43.0=0A=

