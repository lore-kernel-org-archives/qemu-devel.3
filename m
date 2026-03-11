Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9711CFD0648
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Dyo-0003pB-Gp; Wed, 11 Mar 2026 03:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxv-00032n-9e; Wed, 11 Mar 2026 03:26:52 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxn-00052x-E8; Wed, 11 Mar 2026 03:26:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=spLHKhDYY15er+9QPq7PkKHMpdvc/+LtSd1HT7nLwLuNt/89eIDbtPr165VdLE6imAqhVlI7dRdsDY0TeZkCHUBFzaNjIOMsuamYmx7lBjVW6JsAYgBNAmSnop3oaCrCdIFda7LeRu4CaZd4byG8ed5YlHsxxbVrEVIzzyjSgkrl3A5HkIzbk4hQcIA+HVXBLz72lIh04wIcNeWcL87rrfiBl0TM1DqNdEl7IIFDrqkBzmvwhQzpK/o/WiI9SyiJ4CusCClLBSfRhJs/Aas1TvF9howx0PzwXBkMombeOK7o+U+KEjqQvQv/2lL5riMKyYLTgLJIgFRPwBUfN0TkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3T8dQZVeqJq8bNvWUIg7p0P56UwNUWcekj8ijYJlSCg=;
 b=B6r0OqkOfo8L37gUI2zufTd3T1RxFqVLN2+Qe6UuyNGb/k/+v7CbJr6SWDET5TByMxljSoVDDXVZDtPH2qQsMAqy8NdnxN/j2+aBFM4XI3ERp+0X0MRy3TJwtjc3PGwQnrrfNbdWg1f1rN909YXqlsd4q/2Tc5YkWMONwk/nYC4De94ZYZZwZxRMbMiScXM07f9NQC9r553qBiQP+mGGLvGa07KxPOxd5UQ/DViV4zrgl/jZBTE5lu3XVnBV7b04aH91jXZ4cP18jUfuN1Mzph/2h1TXWkkBKYNWTiFdC+wxQ300L7csoE0KmGHt+hH9bUV9am6bGGwutXceh2q+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T8dQZVeqJq8bNvWUIg7p0P56UwNUWcekj8ijYJlSCg=;
 b=hpgMMQM7z4+AhSBhSvW+4h/o+lS/f5LjAu4xiQIo/UJL2927UHOKIRCJ5TlQvszf5RpGOhm1j1aMMijl/CPmh94UBWC42oQCu+jKHIGtywGFav/y7Pr9HnQ7AmREERjpU/TuFV39/8p6Fnuk3A/NA7HvanFocTr2qLtps2MVF4mlGy9iZWhRAtpv9gbiVYVYBIs3i3VZyH0PzXeJBrSef1gd4E3BTpFoRF77fpFLLhgm5sbFnpPWOo3XvT8zELrKr0YGueuny+ifqKdWhRitxiLmkzpb9mLdq+dZnPeV/gGt/7VyvAqEO5ms3ca+QwfaL5EAP4JECEm1nKyEzx/FSg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SE2PPFD6A65AC07.apcprd06.prod.outlook.com (2603:1096:108:1::7ee)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Wed, 11 Mar
 2026 07:26:23 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 07:26:23 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v1 06/13] hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes without
 64-bit capability
Thread-Topic: [PATCH v1 06/13] hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes
 without 64-bit capability
Thread-Index: AQHcsShdLGpD8fDkyk64iqNp0KDcww==
Date: Wed, 11 Mar 2026 07:26:23 +0000
Message-ID: <20260311072614.1095587-7-jamin_lin@aspeedtech.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SE2PPFD6A65AC07:EE_
x-ms-office365-filtering-correlation-id: d163c555-be17-457a-e691-08de7f3f7f8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 4SiwgsuB9z0W9t4lK7JRfMsW2KRgbCfUHAAzdOwdo43CH2vq64YZy10hKyMz5FzAdIb+ZPoruLzk0USH4A8w+7CgyxSESuZsTs1fq2VtLbTLW0PkU6sz2N/XwWS8lW1WdrmcUqaFC72JRETr4PtpjGn95tWUBdfRhwu4b6RRDu30at3Q1XnU+q12rmOgaJzZiiBGwkB05pMKcL2lcAPHZSvvCJDdLnZs53D02HJISsGkdl8rBf7bjw3HnyK9WNE5MI9ape5epCLzb3xE4WVJvf9DXZ6Yf+Vfd8eb8R+IPHv0Uh4N7+xmGx6joz01UPBDvk09DK9vBHshd9ZMhS8vBUQ+SpCkQ8PTG8V1YLHLLLFoWDSQRuATHfpEVqIZqfIGTVSCWOWdKsr56bdr1mnpk5utmXicglfGxV234Sz+69/54EsQKikrfZq6K0ZWTHkfi792Zc6Z/9/WY8KXQtLvE+wcBlIC0PitP+Vd+x7IcawN7rJ/OsqkEVyvT409ZmC0ggCj5V7iIulS3ddks6vWL97SGuDK0Wzpb1jkwgKJSAc0ReVbZXMSoSa46GWKLBVTva34Arx7FnqjPB9HBMK4WwO96bfuL8iG31bEKv6SVM1FE7UlR6wsB3K4WmAROa/lRmzypjrps7vSw7hYyT9jlAX2gB8Yr9QX21QNvZbRHFBlGYgd0BN8Tx3Vlfbd2JUubpMaRuvkX/NyQ/ZD1yXeMrSRAurGPi7zf1QZDUU5ffbrVTcX/QtNOmn0Gnh0Adzy69mzJsuIum02foGZr+RoPb53OosrlqGMlp9/bC5J1yM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?z0oclt68KK4eKPjSUbM2U3TKDFbGfGxl9EodSPhBRq3dJ0CO3N63X2n1Sh?=
 =?iso-8859-1?Q?0IOFq8gZ7zRgBI8cKNzzjWAZuUIeZc5vh4DKm7kT1jzJYfkuw1kpbxzxvd?=
 =?iso-8859-1?Q?625QSfah9nIB8vSfjWgml809va+QmwO1CslaF7eDVLwxSk6vKha4FOy4bF?=
 =?iso-8859-1?Q?mwOkulCubk7NGn154UfKMS8Zqf5P13HMgZL6c+346N14xHqOulIksGNi9Q?=
 =?iso-8859-1?Q?LEMz2XRBjALmw4FygKpEITGEHyYUiMU4h6BHMO8/wzUlyJFj2n5xPugg6v?=
 =?iso-8859-1?Q?AyAdMb30cePCYnY9sSqWJeQTtm5KSjcDGKGljACFGIqInoEQnP+KfJWgNF?=
 =?iso-8859-1?Q?qmyEjiYg5F0mKmO+55dnpTXvteeONAEyiRUQonCd7OUfqgbLGTWrMo+SS7?=
 =?iso-8859-1?Q?9hpoaydRBEMCdxrzWzJQslQD0rDxHz5BLTTczLdQzrxXFVYses+02uhu56?=
 =?iso-8859-1?Q?kqLT80qcelsJweHZGCiVYj/wO4hane1rVruUW8GhPjVCGg+pRsiefJiG0+?=
 =?iso-8859-1?Q?+DjyQXyphvtivITeJujZ3r9HUiXor/lpMBM7Sg6w76XP2CsfbCBwcMKxNS?=
 =?iso-8859-1?Q?WhV7cmrBjSzCFyfG4wZb/LAt3aw/M+TVX38QjI2QnOI3631McICjFecCNB?=
 =?iso-8859-1?Q?7QuMtjpPNlrxe0wXpB10yH1kl+6DXkXLjj9CpGWYIoWc1EQ30n4VjF+eSP?=
 =?iso-8859-1?Q?RgFo61dSpFlM7kjPrQnnjQVi1vQbLPNJZUoDmoH/ojPsQ/2uyT2vyZWyqN?=
 =?iso-8859-1?Q?GsdeIKX9vAJOcCM1PhJDT7a+Kx9oRxPenb/pSZoJVw1A0VsBjQJc/WaCHx?=
 =?iso-8859-1?Q?gcjcZ1SgfdNMt4j0YcizCs+kxifxEcmoFENTDIrF3gS6IyG3h4XtYc0OBr?=
 =?iso-8859-1?Q?stnuSAZgjSu8qBFHOMniK/Dm33exk7UosjwwAvltGAJcgUZOGGf9E9bezd?=
 =?iso-8859-1?Q?SZdUvNXJYxUKgF9YcVE86tJT7dqXji6H9GxFPjBTywfNaUYgkJ07yXyW59?=
 =?iso-8859-1?Q?nbG6uvpvjvd5byf2zOqrctAj7PzbjN8R9hYZNVtAfVm+wJin14LMVjDXwg?=
 =?iso-8859-1?Q?1YefAvaidFJUE4pplaYWwHl3IS4ErDOOMQqIOBWOQhONbdagiNiMAfsM9l?=
 =?iso-8859-1?Q?ONhICN/yfdQB0ghvZqjqCI7bzJwkhhFvXb4av8qarhBKU8OuGKFZ9Xtptr?=
 =?iso-8859-1?Q?IuCWzix83xSiImUZlG9kmQA3SsJLyo6zkvVPpUpqGwqkgwdJ1rzC0KaNtH?=
 =?iso-8859-1?Q?XUEaHgsJx6RnueWr2lQ3pnqlLySan5z2mMu3aTLfqU6yB3ZbEOFrebnsnR?=
 =?iso-8859-1?Q?gm1RF9ndL/1HTHfbErx4Yni7wNhULbwk754yvqVK7Bik4z7sNAOXXyyHWX?=
 =?iso-8859-1?Q?DoZKLCzMGHEbacAAmi+KrMJXy9uyiBtY4VJXwhQ2AA+gTQssy77Pnz+yuR?=
 =?iso-8859-1?Q?SaG7IbngwnIMER3G3fs7+kq6mOZajs+FZGKAE/W4OsZWfVQrNisXgQWnqP?=
 =?iso-8859-1?Q?KNL13amnvyDCuIHsf10cbIMC6QP4wtRffcitwKjQI1XZbXPhtZEbRe0w1N?=
 =?iso-8859-1?Q?Av79pJC/W0CxsvesyXtnoo0AXbmoS39ud3oeQs3Ps8iU78gIzNCxas7TXZ?=
 =?iso-8859-1?Q?EF21fxpkC7XkAREoAvA6C9KN3+WA9Lv7hF+Ag9VJyRgNL0SF/iflTGcnm+?=
 =?iso-8859-1?Q?3TwJkeHht6PdRq5uReG2qR5foR8c/k27S4i9IK9m898Kv0tWW00LQuitTB?=
 =?iso-8859-1?Q?qZNcMCt0Lyt4bmX+1LZAsK0uGClXww3o/1m0Hvsj2HVNGUR4TdDgS1fKLE?=
 =?iso-8859-1?Q?ll5bvO1d8Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sD3PA0YX/cRF3K+MJbMA7+x0Cr1B11AIIGagS/cfsCeS1mM3wdZYhNP8PR4DjJ3+gYSHAgROOKFfRvk9f2Ma4QsRPRVo51ybVmD2ed9kAzYS1FNa4O00eVtyDp4As151+jYN4iIRtV45tTuMZuKZDqjfQmovQyACsT14g++jECbT7oE7egb3wBx+oqB6Ovsw+9gJhpdG3hDINeIUdmIBlg8kwGRzNqkcQd7YuzuPyFADY8Ja0wzGTgM0YFldiD9f2fqntV4Sd3s05krT6nDowgfGpaErxP7figDAk5L5BUMeCYTVqfv6NjfjyM0N+O7cwso54Fe5hXd1ZsnBrakKlw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d163c555-be17-457a-e691-08de7f3f7f8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 07:26:23.1876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hp8XcejbXhA6UL96BqUNMgfNvqLpFvY7pmV8e6gTf+MuQALK+w8xODIQomD0l/HRYyqzh5ThpUkYfiP2ajb1njQ3zZgFzKK8HKait0IfJN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFD6A65AC07
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

The EHCI CTRLDSSEGMENT register provides the upper 32 bits [63:32] used to=
=0A=
form 64-bit addresses for EHCI control data structures. Per EHCI 1.0=0A=
spec section 2.3.5, when the HCCPARAMS 64-bit Addressing Capability bit=0A=
is zero, CTRLDSSEGMENT is not used: software cannot write it and reads=0A=
must return zero.=0A=
=0A=
Add a capability check in the operational register write handler and=0A=
reject guest writes to CTRLDSSEGMENT when 64-bit addressing is=0A=
not enabled.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 9 ++++++++-=0A=
 1 file changed, 8 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 9e82328116..d7a0917caf 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1106,7 +1106,14 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
               "      is enabled and HC is enabled\n");=0A=
         }=0A=
         break;=0A=
-=0A=
+    case CTRLDSSEGMENT:=0A=
+        if (!s->caps_64bit_addr) {=0A=
+            fprintf(stderr,=0A=
+                    "ehci: write to CTRLDSSEGMENT while "=0A=
+                    "64-bit addressing capability is disabled\n");=0A=
+            return;=0A=
+        }=0A=
+        break;=0A=
     case ASYNCLISTADDR:=0A=
         if (ehci_async_enabled(s)) {=0A=
             fprintf(stderr,=0A=
-- =0A=
2.43.0=0A=

