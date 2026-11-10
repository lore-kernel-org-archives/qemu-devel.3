Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C50606A325
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=oC0iQiwT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgHZ-0008JS-E2; Tue, 10 Nov 2026 02:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHX-0008IR-1e; Tue, 10 Nov 2026 02:28:39 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHV-0005V4-2P; Tue, 10 Nov 2026 02:28:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1fP/ArXKv+nCIT+w9jgZDGh2dZN0+Im7Omg1l2v94nGYJwtUxpQjTjxRgtsbTq+xgXU0aSkExIL0mKWGEvvZ+YPpjw57DRQScGuEAih8WC/SYlPSvM6fAaRUtE6+eVeDGAYkZkmRzRTkxcjyQepLWVlq7RDki4J0GMwd2i0yudXE6b/GU+WDXdI0+gtUTvh2a+2UKqV9NpWDLc7EKn0qd5zQcBWMo+sn9++7S6v+vuqxJ2/ELSlqBgT4JP4W23StJ6Hf0g3eei7+BeWLqCiCYNsl1iNFtgyiQKi9zutrmnLzqSim76IxV+CSqqMixyliJ1aD29+jCR1a/cequOxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vQWGbEtGscPdmHA2ADzQG0gFnAv52CUriCVqN3tajs=;
 b=cc71tyy0xkgQESw2mkaq2f8pbCJOXZwI9EneETrkzhLgYkkgSpFYoJtIKIRzs9VZaJ6Kr33Pw6Ky/WY08DgGyF9FDq6RAikrdf0fUN51lNk0RyDvDXTFUtZ8IC/QESaSjzaxKfmJeuDk72vlvNEV6DR9KlCkoUXD+PrPQRNmyU9gelQW6Bdibb/lwgS7bkWLu/GngxzmQeWbRbhdnTqp4DK40lStmDT6fTxcaJFwCFTB+6C2GfjjvWMdsy+TG2BKEdSXxYcxnSo04thhMvlF0W+G/EXg7ccJYsxm3NXihsa37hYlRIlekmgCvhDkVAt8Rp6YzYZBpLhiznS9aepZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vQWGbEtGscPdmHA2ADzQG0gFnAv52CUriCVqN3tajs=;
 b=oC0iQiwTLn0IaLV/3VHepJQHzXhcgOQ5A/x8zi4fK+QE3oNRkEyFj7UJklUMs2VOiRJvnddJVBzldaUYsrU1FXJav/48z3Fnxb5DE6ofYYtE5g57v/MvIMVNqxBmrDKompV3WIAHJNry0jrDCpLtMy8bJrUxID/NXmtXO8DlEEow1sZnEfnystc2cK2nxvcv1J8GZ7gtV30mGLVajF4F67Kliio5YNNA9y1lfAz4qc8QQobAoJB86DqOmM2eTi8lrlYvBosiZtnUoRhKWm41P+A+2AXgSzf2lnwiDOR4nKbaglbPL/0eqjBBwgyZd1X8m2vjP4jZ5dg0qZuJHoh+tw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8987.apcprd06.prod.outlook.com (2603:1096:d10:9a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 07:28:26 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "berrange@redhat.com" <berrange@redhat.com>, "junjie.cao@linux.dev"
 <junjie.cao@linux.dev>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "clg@kaod.org"
 <clg@kaod.org>, "junjie.cao@intel.com" <junjie.cao@intel.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
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
Subject: [PATCH v9 05/19] hw/usb/hcd-ohci: Add an auto-hub property and leave
 it off
Thread-Topic: [PATCH v9 05/19] hw/usb/hcd-ohci: Add an auto-hub property and
 leave it off
Thread-Index: AQHdcOUToE+IwdinPU2SGrliqKVNgQ==
Date: Tue, 10 Nov 2026 07:28:26 +0000
Message-ID: <20261110072818.2883349-6-jamin_lin@aspeedtech.com>
References: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8987:EE_
x-ms-office365-filtering-correlation-id: 4a1c67aa-b9b3-46f2-1f00-08df3efc35f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|10067099003|921020|38070700021|56012099006|261102123227099003|261021121427099003|261009223027099003|261026121527099003;
x-microsoft-antispam-message-info: e+EP5aiVJoMCY6+oL/wRqDbNzDfgR6kaHxJBRgKP20emnEyozzNsW/u89koLceCgkpmdBjZg0XRPDqaQT1RvAfyUVSNl4fzubc1ku8nf5F/mCBa10gYliVK4pDCxvxA8/AlblHuPFsL5C7jlVPWK4gbmaG9CzJevY+IuhwxjIXns2H/2qwBwjMs/CqKrg643K5eT9PI7KVJU78KWEEKfXNh/aclmCcGeW6e7p3KQrz6VNZewB3vdbj+XQEOlmvs/3Bl8BhrEZzASoDtKU/r9gQAK0GVVcT/ytkdQYAgVr/xFFdqIIEoFG4k3fxZ8JIcFuHOyq8ZVOtO551ijjT/kw7ptJEjDAjmXhtWC1ekhyn6/mxLhTMSkTGm+z5O+qdL/9Wg2gS1DQUbPpfym+QFN9YqRtNBk7r9eJ3E5avYK3wa3WxcSaRnDJ23E957ERBbhGRT3XAUwTh9dzl4yLiOSTbpXCtjSpgnlxDMJtwm7JwKUgc5fYHzAtpKsKlZOXFi9sAyLDS7fPITTjJb0ETLSNNjQdO8/oQM8P5pFROi4Dwm4DaR5EPU6QDBvbSQLLb6sB6J638lgzTqJ7GorK448a9i6GtVJCAhdHTXJAtc4jNLwvsG1iKQVsRiM5ri5Qd3SzvunnODSTWw07MIfLBVj9T3CykQMmXbkvqnc2lsuJfZ9/s4lYKq71apUno+gd8PGxg1rWbwqEhiVouw6I5nQw31+eRZvZETq/pAtvW06UQAEX8lN91y1AJ9ToGtCNMKe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(56012099006)(261102123227099003)(261021121427099003)(261009223027099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VEidfjyG2e6iOBJP0wEwO415h6w3oWtI5DQHSddDSP+EodRK2abZhlqRGq?=
 =?iso-8859-1?Q?PJYpxxpZDnKMX7yjGwXBgg1XCJwjyJ4+hFOrbh7JoLZeZM4Q5sVjLVac56?=
 =?iso-8859-1?Q?ZIroWSnLEUA/uPRsccFZf42H5mqa39T92yE4uR99VgislzDJnGvTxz/apy?=
 =?iso-8859-1?Q?C51KkNP9/Ek4ICemH89MKZswW8XoK59zWSEdp6D0wuIWzL9AAxwRh4vEvd?=
 =?iso-8859-1?Q?SA5fPtfNCl9Ajz5r1yxQFvWLmF5SSFEWbGQdIOEu9p0gWvvlnNGl1QI2XK?=
 =?iso-8859-1?Q?RlVlvlPlzcQrr/wYpBuGhwXYqV410+d0DIg0GpjsWKjIp6FXjaKJZEBMkm?=
 =?iso-8859-1?Q?//duvbpD6NCkZYGbRiwqlF/4dYbZ/JYIERG9Mq23BJ3ycuOhktSypmgjSB?=
 =?iso-8859-1?Q?4MQ/9ut9sqri2bF6cpxZqpDnLHH567eDlecSTlMeJZJxCVSle1uen50QHh?=
 =?iso-8859-1?Q?uKPVRR37Z9mSEzFfQ+JYzOXUqexQnm/InkhoH0o+ZKhf1uMK5rFvtstmpJ?=
 =?iso-8859-1?Q?iIwyuebWBu1q2t5BbsGKV4j9fSyM1GNnqjvOymvH8USKeL2GqYstpVRVNC?=
 =?iso-8859-1?Q?WxlrtTU5qrOr/l7qKQJXnxbYTRVDYd98B+LUHZm+JNh4vX08zJL0VJD7Rz?=
 =?iso-8859-1?Q?/oPyFIj2qMrnZC3sd1ZECe/vI94KmTcrnzZfOJZfnwI45auKWfi5GNroAM?=
 =?iso-8859-1?Q?ADpZXMRNR3022MskEmFKsofpBY+FHAiKPZqr9sUgYwrRprjDJClqkOEI7n?=
 =?iso-8859-1?Q?+JIpXunXJ03QBGxkrWYNXlnHYLSLPR+j3fnJqtIDvF7H2dASG4pC/n8lVk?=
 =?iso-8859-1?Q?vEio0JG00cMBFPqPDwisPiS6bP1Kntat0lpPKgwtLUk9Not0yVO935slUd?=
 =?iso-8859-1?Q?HLpjMZyFuN4WQDMOhMmVOcgDbaOjt+0fiWJtfheMlCR8sf0rHwRgbY/xMA?=
 =?iso-8859-1?Q?DMMtXidQjQq0f+h7FfLM+5OIyWqFPxmT10clFB3WQmPlapiR7oGdUmj/v9?=
 =?iso-8859-1?Q?tNExV1r/qY5zn+VR8RBMsoCfKr2fVQ4McalNdYEV8svxETzniXcTW/NKWb?=
 =?iso-8859-1?Q?OCYBiWoJmWoWvvH7YwsfWn5TfHccoFr1XCHPmjKv1aDkKtVLFWtpfFr+S5?=
 =?iso-8859-1?Q?swoDbZxWpkl+QwhniaePVbkUUuwwdAm1Eg+CAge3UrSk/DM5wN3UwV8wpU?=
 =?iso-8859-1?Q?zTVsMz44soCpl5KFGkpr2URnYIyzP3F4Wz9Z3ICXpJnMbtQ7mWL0ngVTuC?=
 =?iso-8859-1?Q?Z1YNs9StCKsf8rKG3ETZ0SaLEibG8f29VyuxWzdD0SaBbxMHTkL1y1AkIa?=
 =?iso-8859-1?Q?wnnWk+ZfMj3z2Znzo48z1KoSzP7fqJ8sqBtznSxt2sQIW462Q1xtz+/6Qi?=
 =?iso-8859-1?Q?dQM++e2qLy/NgL9lyFGCx63hJ5oIeCeuZsbCs/MeH7QZ+30xz011s/bXfu?=
 =?iso-8859-1?Q?DA4vZyutTwM/3My9dwbvDhT+eO/8qhIdSBjzQACNE6g7BGcm9geUIQxB8q?=
 =?iso-8859-1?Q?AsdmCpMx9khGYoCsyN1hFbVJppVrqe26ocIzag6FhIjik5UNE3SPQ0XaBS?=
 =?iso-8859-1?Q?bdsgTyyj0XRDve7jsqbKyG3dE145bYbiwgSkXoA6mLgTd4XRo9TmDZ7649?=
 =?iso-8859-1?Q?K8MduCvcH1wJ5KXQQA7YPfaVu4pg8Y5EodIWHxixA2RyTvFVLLkgx1fqLf?=
 =?iso-8859-1?Q?g0cDtlyNNV3q/qd2SoorPk1vi43oJiPjsjVhc8ee8xtrIGndP/SIsXeu/p?=
 =?iso-8859-1?Q?8ueJINVy971gLJZjLIkP0pFK+E6jpa9/IpY3nPQYOD7JRyJADmgoC8xbzF?=
 =?iso-8859-1?Q?kyTzVnV0PA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oIvP/kX7fdEORsaYp1IEnnOJ0i1LDls5so/d1U149KuqaWuKRCs8icP+zxEblkOo2+kvlxPHg33vvRUIYq5jAclAvxh1otH/9jqycuUnYMAbdJXVsFWaowk9jLfi/JZHGKuFgGDH4+m1W5bQfqmiBvYCSSVwcBX61jRyv772y+kZThyFdt0Q3m+uSAoA3XkjVSNWHkJPsmPMKE1Zv5UxyuMBngB3XbxcuwPZfR6IhX7EEIrlDr4cfbyfucpMh8SOmsXAXGdwGe6vWwGnEPYlGk6f8b/ZOv/I8gbSOKVDEALvLGM7FSvl+SXVGV2hfr0yVjenqoXrLWvfojQkwWe51Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1c67aa-b9b3-46f2-1f00-08df3efc35f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:26.7150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ng4mRPJbfi47q4FyzpQ4P6WIhPgBl+51DyaQxk9/BWzywC6BloR9uY7064GHIosdgwVKXzd9QLGLbw9idM7q4JecmtyeONHMwgbEALCmUQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8987
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add auto-hub and leave it off. hw_compat_11_1 turns it on for=0A=
pci-ohci and sysbus-ohci, so an older machine type keeps the hub it=0A=
has today and a guest saved by an older QEMU still loads.=0A=
=0A=
pc87560-ohci is its own PCI front end, not a pci-ohci, so it defines=0A=
the property itself.=0A=
=0A=
A companion OHCI adds its ports to the EHCI bus instead of making one,=0A=
so there the EHCI property decides.=0A=
=0A=
TODO: Move the entries to hw_compat_11_2 before merge. The series=0A=
goes into 12.0, so 11.2 is an old machine type too. hw_compat_11_2=0A=
does not exist yet.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ohci.h        | 1 +=0A=
 hw/core/machine.c        | 2 ++=0A=
 hw/usb/hcd-ohci-pci.c    | 1 +=0A=
 hw/usb/hcd-ohci-sysbus.c | 1 +=0A=
 hw/usb/hcd-ohci.c        | 1 +=0A=
 hw/usb/pc87560-ohci.c    | 1 +=0A=
 6 files changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/usb/hcd-ohci.h b/hw/usb/hcd-ohci.h=0A=
index d079f8d24e..43240622ef 100644=0A=
--- a/hw/usb/hcd-ohci.h=0A=
+++ b/hw/usb/hcd-ohci.h=0A=
@@ -98,6 +98,7 @@ struct OHCIState {=0A=
 =0A=
     bool big_endian;=0A=
     bool consistency_check;=0A=
+    bool auto_hub;=0A=
 };=0A=
 =0A=
 #define TYPE_SYSBUS_OHCI "sysbus-ohci"=0A=
diff --git a/hw/core/machine.c b/hw/core/machine.c=0A=
index f79337e7d7..22d2b83459 100644=0A=
--- a/hw/core/machine.c=0A=
+++ b/hw/core/machine.c=0A=
@@ -47,6 +47,8 @@ GlobalProperty hw_compat_11_1[] =3D {=0A=
     { "pci-ehci-usb", "auto-hub", "on" },=0A=
     { "base-xhci", "auto-hub", "on" },=0A=
     { "pci-uhci-usb", "auto-hub", "on" },=0A=
+    { "sysbus-ohci", "auto-hub", "on" },=0A=
+    { "pci-ohci", "auto-hub", "on" },=0A=
 };=0A=
 const size_t hw_compat_11_1_len =3D G_N_ELEMENTS(hw_compat_11_1);=0A=
 =0A=
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c=0A=
index 70c9e9ac4f..11c754a948 100644=0A=
--- a/hw/usb/hcd-ohci-pci.c=0A=
+++ b/hw/usb/hcd-ohci-pci.c=0A=
@@ -112,6 +112,7 @@ static const Property ohci_pci_properties[] =3D {=0A=
     DEFINE_PROP_STRING("masterbus", OHCIPCIState, masterbus),=0A=
     DEFINE_PROP_UINT32("num-ports", OHCIPCIState, num_ports, 3),=0A=
     DEFINE_PROP_UINT32("firstport", OHCIPCIState, firstport, 0),=0A=
+    DEFINE_PROP_BOOL("auto-hub", OHCIPCIState, state.auto_hub, false),=0A=
 };=0A=
 =0A=
 static const VMStateDescription vmstate_ohci =3D {=0A=
diff --git a/hw/usb/hcd-ohci-sysbus.c b/hw/usb/hcd-ohci-sysbus.c=0A=
index 4f51eebccb..69f38b9fce 100644=0A=
--- a/hw/usb/hcd-ohci-sysbus.c=0A=
+++ b/hw/usb/hcd-ohci-sysbus.c=0A=
@@ -61,6 +61,7 @@ static const Property ohci_sysbus_properties[] =3D {=0A=
     DEFINE_PROP_UINT32("num-ports", OHCISysBusState, num_ports, 3),=0A=
     DEFINE_PROP_UINT32("firstport", OHCISysBusState, firstport, 0),=0A=
     DEFINE_PROP_UINT64("dma-offset", OHCISysBusState, dma_offset, 0),=0A=
+    DEFINE_PROP_BOOL("auto-hub", OHCISysBusState, ohci.auto_hub, false),=
=0A=
 };=0A=
 =0A=
 static void ohci_sysbus_class_init(ObjectClass *klass, const void *data)=
=0A=
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c=0A=
index 5e5fe41f47..2c25829b76 100644=0A=
--- a/hw/usb/hcd-ohci.c=0A=
+++ b/hw/usb/hcd-ohci.c=0A=
@@ -1987,6 +1987,7 @@ void usb_ohci_init(OHCIState *ohci, DeviceState *dev,=
 uint32_t num_ports,=0A=
         }=0A=
     } else {=0A=
         usb_bus_new(&ohci->bus, sizeof(ohci->bus), &ohci_bus_ops, dev);=0A=
+        ohci->bus.auto_hub =3D ohci->auto_hub;=0A=
         for (i =3D 0; i < num_ports; i++) {=0A=
             usb_register_port(&ohci->bus, &ohci->rhport[i].port,=0A=
                               ohci, i, &ohci_port_ops,=0A=
diff --git a/hw/usb/pc87560-ohci.c b/hw/usb/pc87560-ohci.c=0A=
index cc00f6e936..66c1e62d48 100644=0A=
--- a/hw/usb/pc87560-ohci.c=0A=
+++ b/hw/usb/pc87560-ohci.c=0A=
@@ -296,6 +296,7 @@ static const Property ohci_pci_properties[] =3D {=0A=
     DEFINE_PROP_STRING("masterbus", OHCIPCIState, masterbus),=0A=
     DEFINE_PROP_UINT32("num-ports", OHCIPCIState, num_ports, 3),=0A=
     DEFINE_PROP_UINT32("firstport", OHCIPCIState, firstport, 0),=0A=
+    DEFINE_PROP_BOOL("auto-hub", OHCIPCIState, state.auto_hub, false),=0A=
 };=0A=
 =0A=
 static const VMStateDescription vmstate_ohci =3D {=0A=
-- =0A=
2.43.0=0A=

