Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E21FAD40E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFmT2-00083g-9I; Thu, 23 Apr 2026 01:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSm-0007en-LG; Thu, 23 Apr 2026 01:18:57 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSk-0003DU-R3; Thu, 23 Apr 2026 01:18:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyTAxQ7JC9r0w0U3Ng90Gr9FLz8QvZSYoEw2wURBGpZ1t0AdMjbLb5XqVHZoSlucJzfzVzddzWURS6sXYymIgQJ3y60og/Tzx9kJanckGtHOK/G23DhuiIViG0UzGpvsWUyoX6fjrc4nRNQjl+AmwvqFQ4YRNhTyBFuQiaUSwwGFBPWu/Lo5QYWXlgMhgHgpXuMLdSSqQbdRWQYVz8/Hcl5QzwQ/gz+BroL2zsIN9gE6NygMT7TwCRD3n7sZ4ZdIvwrVjMseTiiwNlG3lDyKmo9Vamr8Qn6cZ2YfBkAjFOyZCmh1Kx2dMiDAlmOt43ggjSEegWJmRZOM4JBatICUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdCqqwgGyyJ6ZpatzPh1q47FdstaGy6eGso1RaGeAJ8=;
 b=zF4TJyXULiIQ5jLk1iaxaSdUI3cbPRfMlpoP/N95HeQdIUuHSXPAGpgTa4P6fyFkbuF3PCDw2P1q0qFv7vqrRViYENqdpsUo7mUMYB7/iDSziBVwATmEaYEsjrsoRkHnw/nuClAve8oLOrxxLb8GKjmYTuSGVR7N6N/GjD0lgRpqaVnTku30teo9qak0P3TFhwtTpHTT30+gt2SuOsD+NoyVR5y+K8ORyo1eUecMKH6kzoE0D1z1lLs3G8NjgI+u2L0RA+sv0EHhICgL13/O3h2OH6rEYGGKueEfs+wM1tJ/soFhunqWHrHGBOF1xTlvhrIKlVZ1RGhMvgbJPOCBfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdCqqwgGyyJ6ZpatzPh1q47FdstaGy6eGso1RaGeAJ8=;
 b=nu7UYrSmPdhhaXBC7ZqBKQVHsGbCGmG9RMMavBPMdrV03OzBrMxPlEAHxAai460nT6ElfTE2VqPubyJNtuoNriHMV4927tH8qYsS7/8nH5SnOSm0yw/uG52JSooKGpKio9ljWwD7tZ15dMM8CBiCcQ12FgIwkiZKC0mLa+cYrCn/RMQ+fQt9A6Pt6AkfxxdNKvR/3Qk5GhzcJuFJv2l7eG/jEJ4BGqF8+IlYvbE72X/hJUcf5ijO/Biw3UuIMscefSMj6YZ/0efzLDCXPjdl90dUOo5jaX0OAt9QqSqGdKHJjbazddHEhVDQzaBFjngLz9zafrdsrFgedaIkBq+7Kw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUXPR06MB8534.apcprd06.prod.outlook.com (2603:1096:d10:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 05:18:20 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 05:18:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "farosas@suse.de" <farosas@suse.de>
Subject: [PATCH v4 12/17] hw/usb/hcd-ehci: Implement 64-bit iTD descriptor
 addressing
Thread-Topic: [PATCH v4 12/17] hw/usb/hcd-ehci: Implement 64-bit iTD
 descriptor addressing
Thread-Index: AQHc0uCZpFMCSv8lKEK9Jloeph3lDw==
Date: Thu, 23 Apr 2026 05:18:20 +0000
Message-ID: <20260423051804.362095-13-jamin_lin@aspeedtech.com>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUXPR06MB8534:EE_
x-ms-office365-filtering-correlation-id: 415e18fe-2f68-4841-55e9-08dea0f7bbd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: AqUCLWxGfExwhVsArDecuej9kRloLAVNV95U1G4S1XnBxe+LudoQ49OEnZjFkezH+NwQeamwNIsWpyX7rr+sKUN3Ay7b1SDmGd4A/israBD89/zwGG2PveKAZbOYh+T9UvREbpX6JTADMkkKjPifoo27cuBJkY12i6bKPPhByR062yP4uB0ozQvLplKBjHyJsnTyuaGAqcD++LlrZj9+HgG0Rwy87+qxxV4WCwED3PQQPztzF+NfHEuT7SHonCMDOfzsKCbRhOOsJMUlVZTO6LtPuuhOxJzlFDwBPKI44S652bLrrbg+LBbUOt1+zsQgZJpk6xYpMWeiKWEsghHYZtB1PdT0K0H+j4ZqOWv4k09ZK7YMfONuHwaKHRNUtKmU038yLSFc55eXAkwZ9EIYBp9JHAXEYBgrq6I0+34k+jSbO6OcRRH+rwUIcU/fvljejkmE2GpGm76PJmtciNndI+gLfl9YkHanIzRLFOGX157c6vErYUsI+0IPqozfSiUa6IGtxN06XFqIVJF4ie4fYBNSpHWVcehsB41s7ObC28sLqsljkPk+ZR5dlJmovLRs2YWVgLQxLbpkB+6sbfgZjNkjht6MkpieKaqefdJ1Q3L7cL/P1dYCLsIL59a3X7JX4FAPWMJYCtkbPRJj92y7MFV2Nuf/ZsSmWb0aFfH12DGGttGP2Ue76F5LfxD2VAicSIe40sFdy0A32mAAobgRR2qwHd3aXIy/fI2VAmL5X27GpCYwAkF28xVptDj9vAJ5sIQipveuxFEpdK5IEpiuYsi2ljzA9b2/zpCKAWZL9EB/lNyq5BXgtG8eM/NzLeYi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9q+37vBtogbxD22fLkS9JBi+z1enZIxHwj5zLhkIFMGcXLjceySujW1ehq?=
 =?iso-8859-1?Q?2XTSTBmSmNXf0kR31EGn2F28enKzSbLBTdhepe5zPmDSjstkPtf5GfKEG7?=
 =?iso-8859-1?Q?B8dJIVQNB+ZGMJlImnBXJdKuFJggmJWdCqqin8+HTxZQ5W3504boWp6juh?=
 =?iso-8859-1?Q?VBtsIuSFu1CoOqCn2PaqZhP/vTOba1C5w+A3VjEzdjAxkdL+fS5jawN9fj?=
 =?iso-8859-1?Q?jthJoiyg7hZ6+Z+SlH5y09Zpa5ZChs/+Cvkj+vCh1tVLAL19sAbR0DBrEH?=
 =?iso-8859-1?Q?O4ONOhqk5hecA7GgCOdU8FXcrLBOXiRPxNN4n7sZblxKQ+JClgc8kJzg3x?=
 =?iso-8859-1?Q?tVe421F0zaTV5bT2Sv19DtEYKUNG/Ji2+HuPkByEuFEnrpnZkM0sqhhnZV?=
 =?iso-8859-1?Q?YWpJResamg4odCgaawcszpMu4xvhkOjH8mrIIouv7G9rwJG33/uGX+49Qx?=
 =?iso-8859-1?Q?JIM69yRqHoxPs/bWyJ/3YctnxPzTu29DMmqfl7lHKimlkK2QTuQO/DbN7b?=
 =?iso-8859-1?Q?TtBc7rtq0/m4oXSsCCGTOKq8Gew2UN0M226dRltNDKXFLk6sSsrAcTi2ry?=
 =?iso-8859-1?Q?F2vDkGDQIAhR2zpba2y/nTFXdycJR+mdW5zRNYuOr3s5tOdjIx4PujL/ke?=
 =?iso-8859-1?Q?8yKiX/WuypHYI89W+hM7GTJ6sKw9133x3y52fcDDdA2yW8OlC5N8TSDedC?=
 =?iso-8859-1?Q?Qp72QSBrLyFPV6zHX8Duk42AzuhIvAzYDBE5Sa0KwgDeeYlvfHpGjHbJo7?=
 =?iso-8859-1?Q?jDpMBUPl131OWcsj2zBEBEe774kDfhOHjNKC8sEYbyB1x1Von8GfhI44K0?=
 =?iso-8859-1?Q?pRzBedj4/qaqVbZ7HOMPircrL/dxYrESDge1f89/pxomhRuA5kCvVcyHIJ?=
 =?iso-8859-1?Q?KAd+QsMGghTVpga/ZTjKWVz10Int/UkHkpfOYCYHNskEHM6NfXjH19fRe+?=
 =?iso-8859-1?Q?L3eMCL433RSJFHgAD2/dCfWcmHxP7D1eab6IvHmJSSvxsdB9qRk+AkwxuN?=
 =?iso-8859-1?Q?1RUGlfo8qKJWAa88YU0e3X58/naLWo85AyxhaTUf8SypwZo1EtSZeRBFgt?=
 =?iso-8859-1?Q?tQ1Y6cH5Rwwv1BIesLMnpdu5lqEShBBHNmhxtEOdL0j38sL7adsP34d3SW?=
 =?iso-8859-1?Q?y2fTx8ji6DR7EcygyGErO/DG34CCYs9HVg7NKGp/QCIZjsbXWYPsA2LKYp?=
 =?iso-8859-1?Q?PBlJUpg3M/DYbdogunCRLOCXuYmkecRZpQ8orWbM2uAfjPIODa5iUq+IpR?=
 =?iso-8859-1?Q?NEMWluqyWOdbKGzaf1ybc3ddviYPX8ny5qcASijlomAMuZeZVT78Nk1f6o?=
 =?iso-8859-1?Q?KoynJgi8iM2aN9YogdM69I+OTuDP8jZYJQtW0hblW2j38O2seHm51UspD5?=
 =?iso-8859-1?Q?P7ly6qxeqSIcH4EZxttpCCA6Qg1U670POC7W05sjrRJ9hJfxhfMnxlkpvz?=
 =?iso-8859-1?Q?iu5t6NTmcIRSAimXXDNVeLCf7r5BdunMJ7IEWvSaYfiz/2Y4rJZU3TIgW4?=
 =?iso-8859-1?Q?bR8NDVbwU8Xrhz9/ceqYWjiGJhk77fA/FECqF3d6h06BAtSaf4Vrg0uuT8?=
 =?iso-8859-1?Q?Zysrhzpr0hoWD2FsVcD6QK/sCaaycsj+/z1nRvGQ4WdThoUpWrckMpHoKS?=
 =?iso-8859-1?Q?mRBqTopeSPGXBbv0ks+EACL8q78mKhYr+Om7FpjlPsN34Bw99S638chCh4?=
 =?iso-8859-1?Q?oK5ujzQPn25liRJbVKk8theB4g+r3aHMGzu2k/E9sVR5orUlTE9I7HlZ+3?=
 =?iso-8859-1?Q?BYaz45469Tuf4pif48VB8O/+F5Ksm59HyUVTB6lewQUcH8OnVP3GFR8PWK?=
 =?iso-8859-1?Q?2b2geUhgbw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dmRwj0Rr7Y0TfE5CrmGvuz0hoF5f6RkwPkLBKM7WdQzsJJDJwHqxU9ZK24ZoKDl2dttqM+FhJosFNW8UEY2cHIwYO5FG3iSXBABkbqgpEbJ8o4VZC6IFzUR6/zeyTnjOt5g8+dqPNB+0916MXMHGbNzPdbufZ5pedrJKnJc3safFpTaLzdj1+fGJhfqVoap/EA+/4/sWC3Nww7cM5ndMY6j3dDK+tBllnlqZT7t700F47j2DYL50X+89dMWvXiu3DG9WS0WX+gnpZN+HznoJxaJ238mqBXHBUIW9vHxUzKdwATkiAh13i1f/dwODdZebUR0gt8OMXszW6EjTAvqECQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415e18fe-2f68-4841-55e9-08dea0f7bbd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 05:18:20.1939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4VaQaQ05hOlWID1u2/E13Jxd8kGLkWmSKcPa8ki0OECR7KMHyMTcGUaSStUmHiea50nujzR1X5LUbhv62CRbtZDaPQnwA+fxISF6tFfqvlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8534
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

EHCI supports 64-bit control data structure addressing when the=0A=
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,=0A=
the CTRLDSSEGMENT register provides the upper 32 bits that are=0A=
concatenated with 32-bit link pointer values to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
iTD link pointers are stored as 32-bit values and must be expanded=0A=
to full 64-bit descriptor addresses when 64-bit mode is enabled.=0A=
Update the iTD traversal path to use ehci_get_desc_addr() when=0A=
following link pointers.=0A=
=0A=
Appendix B also defines high dword fields for iTD buffer pointers.=0A=
Add bufptr_hi[7] to EHCIitd and use ehci_get_buf_addr() to construct=0A=
full 64-bit buffer addresses from bufptr[] and bufptr_hi[] fields=0A=
when processing isochronous transfers. This allows buffers above=0A=
4GB to be handled correctly.=0A=
=0A=
When 64-bit capability is disabled, descriptor and buffer addresses=0A=
remain 32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 1 +=0A=
 hw/usb/hcd-ehci.c | 9 ++++++---=0A=
 2 files changed, 7 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index fc66aacd9f..8e6a8cdfb0 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -63,6 +63,7 @@ typedef struct EHCIitd {=0A=
 #define ITD_BUFPTR_MAXPKT_SH     0=0A=
 #define ITD_BUFPTR_MULT_MASK     0x00000003=0A=
 #define ITD_BUFPTR_MULT_SH       0=0A=
+    uint32_t bufptr_hi[7];=0A=
 } EHCIitd;=0A=
 =0A=
 /*=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index e82e0f625c..43a01a796f 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1464,7 +1464,8 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
                 return -1;=0A=
             }=0A=
 =0A=
-            ptr1 =3D (itd->bufptr[pg] & ITD_BUFPTR_MASK);=0A=
+            ptr1 =3D ehci_get_buf_addr(ehci, itd->bufptr_hi[pg],=0A=
+                                     itd->bufptr[pg], ITD_BUFPTR_MASK);=0A=
             qemu_sglist_init(&ehci->isgl, ehci->device, 2, ehci->as);=0A=
             if (off + len > 4096) {=0A=
                 /* transfer crosses page border */=0A=
@@ -1472,7 +1473,9 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
                     qemu_sglist_destroy(&ehci->isgl);=0A=
                     return -1;  /* avoid page pg + 1 */=0A=
                 }=0A=
-                ptr2 =3D (itd->bufptr[pg + 1] & ITD_BUFPTR_MASK);=0A=
+                ptr2 =3D ehci_get_buf_addr(ehci, itd->bufptr_hi[pg + 1],=
=0A=
+                                         itd->bufptr[pg + 1],=0A=
+                                         ITD_BUFPTR_MASK);=0A=
                 uint32_t len2 =3D off + len - 4096;=0A=
                 uint32_t len1 =3D len - len2;=0A=
                 qemu_sglist_add(&ehci->isgl, ptr1 + off, len1);=0A=
@@ -1762,7 +1765,7 @@ static int ehci_state_fetchitd(EHCIState *ehci, int a=
sync)=0A=
 =0A=
     put_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &itd,=0A=
                sizeof(EHCIitd) >> 2);=0A=
-    ehci_set_fetch_addr(ehci, async, itd.next);=0A=
+    ehci_set_fetch_addr(ehci, async, ehci_get_desc_addr(ehci, itd.next));=
=0A=
     ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
 =0A=
     return 1;=0A=
-- =0A=
2.43.0=0A=

