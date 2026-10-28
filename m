Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D39B606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=ECORXsCG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLuY7-0004r5-Se; Tue, 27 Oct 2026 23:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuY4-0004pL-PZ; Tue, 27 Oct 2026 23:42:01 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLuY1-0005d0-1e; Tue, 27 Oct 2026 23:42:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Es5FtdmD1s7nRyOG7oyiqNKE0lVTKmAJ2VWBDgTJk55q926i096dIfeDtGGdnHuii52zALvt79ID6bNIMC3kNu54FKl3N3i6qfhyy6t3d4v7AmLMwJAhN8su72A4wx4QPPlluvoIKm+U2PAQG279vC6i9S0+ucHznCrYhNVkSYWX7tcSVFtHwei9mrydiUbLDPDhyFrp0mIiQ5Puz7FWw7r06kY4Msq1TycbWA9BNVGE2mEm4RCv0LX8gQ77Lmz1bscKVKOjK2Uc2EupyGBQTECFbPSEMoJnZtt9Ji4NTJPiOJ7dIQoLtt/mLA404gWqaDOPQ0EcIsyGt7a9/dhppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXB7T15x4QB2HBRA99ZwLSnKG45JeUluvy0j4wSnxP4=;
 b=H43yi9eeWtvplWNa366YYL+Dmavjhw7Yj9X4VGql/u6lzx2ZqQClwDY6zjqORsAz1V+zJIVGVdB2RistciYnOZI7V86NTkx0mweUJN8fDWO5lLwIDnZ2/vioNa2uudrFpGBGEs8/qqY7FJtmOLlv0HEIkYaQUbkmCXNn3Qyy4dMw578dvBghmIhhjkQIqbsx8iMYbUJWRmWM4uBQ8ztCzs8jMNc3vKCXFeh/gKR3j/s6Uqt8fYFybyzn+wLTeYmZ/ETRz8S2PguJks79e7cwbvRw6p/NIt5e8mu/x+jymtUquGFXYYv2vqmOlsJnMHEkUfsFmzRUzaY7n0DU5OsFxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXB7T15x4QB2HBRA99ZwLSnKG45JeUluvy0j4wSnxP4=;
 b=ECORXsCGB4FvwNJ1YC4JdUv8gHJDppLd98/rNw9ph6bIPGGUPqDpuUoZJw7z2yAAe+5/7OuLqCRQU2piU8yXIpFX1KseMah08WZejOwyc9ik+ofVwISKTeTURHq1v1fb67xPmskFDTgFBSDjulXw1LV1nFiQeR090C110bhe7BLtjob4BNNo3MUR3n4vDK8HMN2UPNuND58UXQmd7t3LTo2sX3NYb4BTBpK3hbGxbvAdnz9OmIdFTiUVUDvzFeRvI0OV3+Qi/KkCeBXuXoah9YHorySME+iD7+bDG8V9m7uukqDjLY0t9ziHiEBHDrNdeet/4LZM4wruOjKA9qmZAg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY0PR06MB5469.apcprd06.prod.outlook.com (2603:1096:400:27f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.7; Wed, 28 Oct
 2026 03:41:48 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 03:41:48 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v7 6/8] hw/usb/redirect-server: Implement bulk and interrupt
 transfers
Thread-Topic: [PATCH v7 6/8] hw/usb/redirect-server: Implement bulk and
 interrupt transfers
Thread-Index: AQHdZo5CCWAyOFUsKE2rVSZb021dPg==
Date: Wed, 28 Oct 2026 03:41:48 +0000
Message-ID: <20261028034140.367393-7-jamin_lin@aspeedtech.com>
References: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY0PR06MB5469:EE_
x-ms-office365-filtering-correlation-id: 28692217-eaba-4cfa-87f4-08df34a56559
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|5023799004|56012099006|261022113327099003|261009221227099003|261009223027099003|261022105027099003|261021135927099003|261022115727099003|261022075727099003|261026130827099003|261026121527099003|261021121427099003|261026140227099003|10067099003|261021123027099003|261026135527099003|261021130227099003|261021133027099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: rP1UstAbqJE/aVIQlCo9cXGMj6TUOOF4N01yn7nf2Yeo7KHdwAdHVH/sMPwJEZ33RrRvhptkmL1e81VYvITr9Tmwbol77Itj0/EUer+kubPSv434vXRmjWqHpzAK3DSXgoHRAXKTIqdZ2P9CAAXvpEIkmnyUtud0spKYHPOzHttnTHszs1vcJelG/hPpdsYCzQGtvXHmywM4YjMAx2jntL/ZJnU2lCIoznSXNV3+K9VMc+X84mCWG62t5FViEB7SXmgydTKtadebzsyVtE/62UMGCg4ti1TfujBy2+MrWQ0rwZT5msFC/1fHVYrBIhoBAbJ4/5ywZwjWbSusRHxAsRwDtTP8j3DvuAc1Qmvn6i/u2pmtlO5hn5amEjgum/MOcJRi079lccuRlKD9jLF16jab000+j+ZGzp0XfAX/qAkY9xLfl73MF3NVim7kkRhH+GmR7UV13XXGsmLTd6JcAHBKIAfuQfFq3p4zXXRQnLAtNyX37X0R36g4xEKZVS0E7sk3qw4KK9egvOekyptszFIcysxcbj8G9UZ1agRmqBlI6BdAgEV7tpMK5BSeKrY07EPY97FEXnJEBD8Pwcsks/xE8NYfvTqjD0oXaHzdbB3AGraDClYUX7yrFLBc5OTZk4nVc0JJ4FffOH1pOHV97v2gi00wsEXAeSoFp3fot5koL7mH8D3uN0+GkcQW2nXgn6Ej94z1NaK1wbQuTO2pyOgr8bPpMg1WDdRp2suU2ek=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(5023799004)(56012099006)(261022113327099003)(261009221227099003)(261009223027099003)(261022105027099003)(261021135927099003)(261022115727099003)(261022075727099003)(261026130827099003)(261026121527099003)(261021121427099003)(261026140227099003)(10067099003)(261021123027099003)(261026135527099003)(261021130227099003)(261021133027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?taK14AUBUmZ205mJ6UJjlZlcQRziyr9xeE44ffKTRekh1Kk9pZ94tgDjFJ?=
 =?iso-8859-1?Q?8aW5TyonbApJHo4XIE1uSbzX2qctoL2Cvwr8esEe+qcwdBIwOyCnZ92jwO?=
 =?iso-8859-1?Q?FAQ2AyQdVOLR++XTRVXteYbD7U8RANM1c8fGEpgFFq6Yzmc7siNu+9tFKB?=
 =?iso-8859-1?Q?Mf+N/IUxAcAy6rOmjkXLOLXLUbCQngA1i8IsATVjl49HLotE9xN35ppHhm?=
 =?iso-8859-1?Q?eHih97cnButRg5hsYoimQ2EQE10+Dg7KdXhRK6vNr1qxKsbLjle7DIQ4KH?=
 =?iso-8859-1?Q?o1SzAQRTdN5Xl5y3p6N50kqs1nX8tiPOZ1tFO444j5iQuI9zUVywIVkYF4?=
 =?iso-8859-1?Q?X3icYHI/2AIPc1qzH2EiWKb8kt1JmBwvo/d75zjFhpow3TA961Nvcp90UJ?=
 =?iso-8859-1?Q?TfizOnKE67eaAdcg32Ap+Gbl4GyhXl1drzoLv+EmfT4WhHIBCVR3slLrE7?=
 =?iso-8859-1?Q?w0T6vKVS5PS5dOfVZKDEep5nlplVlE6uFsnrd6Lqm6gSDbi73f3/Ps6OEu?=
 =?iso-8859-1?Q?79N9ROZyAF7jzTiuerltSrD6kkxhGuqpl82V14Ru4qfD5n9qrQV0iuRYiU?=
 =?iso-8859-1?Q?kTt45e8rf9Q47koJ+pgdCHBB1gyW79BgT19a498zmz5VhOrVz2law28sRS?=
 =?iso-8859-1?Q?lI3HWEuGNDQqNvIN+iOulxkn6rGpxUdprhi0GK8zM+KeRVBwd9P9zI35Uq?=
 =?iso-8859-1?Q?rg7WEK9NGsXiJmwn4r3WL/xJE2gNwhuYKTrXwL/UnAt2ETf5BvHV9cP+J8?=
 =?iso-8859-1?Q?2I8qX9F7MzJXZiYz/w2XRknQlR36atgFQKqRtwjv1QZ/g9ngEgyMMAyjIi?=
 =?iso-8859-1?Q?A6k5WNr9biKO47QWax0s2Msu+9R7VI7UvbrliybE7QPsDvH08bB9W7WvTn?=
 =?iso-8859-1?Q?Arnu/VoI/dKbGCqCpJnPpPGvc6TOWZ2ElHBdU5cvgrSIiIeCZgCCrvuV+I?=
 =?iso-8859-1?Q?9p19rzvXJFFPZMMAlhXcvoHmgHNpRPztzCnCkGlyOkvCy8SFAoSfEm52Iu?=
 =?iso-8859-1?Q?mQ2RIO+tOG9ZPWa3zYgj8JPz1i0JVmUJ43S97DM4rjauJ+HCN2rx25ejVO?=
 =?iso-8859-1?Q?gYKyoNuMP1reElp33Xx9s8XGxi2QVKOwv795XnngbNXV3GchPRy/ayeBTZ?=
 =?iso-8859-1?Q?WHo1KkV63t/A90JasffvzUJB5jd6RZy/IR08wOUIUMVb7y/8tIwAsZlxWC?=
 =?iso-8859-1?Q?rXuo+RXc4L4/mEpbaG4iz3vA76dgA4OfyNw31/4kPmkQqB9+ashwsWRz7x?=
 =?iso-8859-1?Q?g68YT7PCBLqwZQP2TPCl/ICT118jxKPXFe3T/tzrSnwPDB89KWUF1Iaw/X?=
 =?iso-8859-1?Q?kyqZEceMltt7rZXevS6S/uzHLcKUDv6PNEtq9KzwallooMefvWx1kbL4kK?=
 =?iso-8859-1?Q?74u0ZWMA3PLYU7R0WN7Fh6J5Wcz6VPWvAG9khBXaAoYvgS6O1f96jFvc4U?=
 =?iso-8859-1?Q?VFOX22/sBmFbu4H15fV9QzwLEbsjE6/5HhYCqC3IykAoatzDqZPJWWMZjy?=
 =?iso-8859-1?Q?nISwIGaTNFJmPMvXedCaOl3nKUBk3Agcd/ty3LnfstyMhrJgjOjAopdEcz?=
 =?iso-8859-1?Q?/QQxV6RMnul3uVJ4THsChSL8C/LHDUdZZPiHvtIa+iTLx1sfMP9jrIVtHL?=
 =?iso-8859-1?Q?a6rUc6nyUEjdtTkoxjPuLoZYsiezC1KXO9dHAHt4JHy4zE1uyP+qA4IDIe?=
 =?iso-8859-1?Q?Alw6o6zrGVhZ6cr2GXYN3PZqiOQFJ6hixGxEPXADV5Ly2eNhwZ7qriJ1uU?=
 =?iso-8859-1?Q?JpFM8o3yU32u+wahchPWlfDI+BPVNPMXnPz005vaZ47gYxSJ5dyEHVhm9u?=
 =?iso-8859-1?Q?NQhyyO5xgg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28692217-eaba-4cfa-87f4-08df34a56559
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 03:41:48.4239 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e9rfATUjvBKA92ov9mmrBpRz6c8V8Sx3C0JNoB4Wsk6X/WpX1QtVxan9EUhy6ebK5JUftIr38pWd8MDfooST9pbQVgPNf1HW4KDL+ljz7xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5469
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

Send bulk and interrupt packets to the device and return the result to=0A=
the host. Each one is a request and an answer, so they reuse the packet=0A=
tracking and the NAK handling added for control transfers.=0A=
=0A=
A bulk request carries a 32 bit length, so the host can ask us to=0A=
allocate up to 4 GB. Refuse a request that big. Do not answer it with=0A=
fewer bytes instead: the host counts the bytes it gets back, and it=0A=
resets the device when some are missing.=0A=
=0A=
Advertise usb_redir_cap_32bits_bulk_length. We already read and write=0A=
the high half of the length, but without the capability redirect.c=0A=
asserts when its own guest asks for a transfer larger than 64KiB.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 239 ++++++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events      |   6 +=0A=
 2 files changed, 244 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 61ac5473e5..7eeb08ecd7 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -90,7 +90,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SER=
VER)=0A=
  */=0A=
 #define USBREDIR_SERVER_RETRY_MS 1000=0A=
 =0A=
+/*=0A=
+ * The bulk length field is 32 bits, so the host can ask for up to 4 GB.=
=0A=
+ * This is the largest transfer accepted.=0A=
+ */=0A=
+#define USBREDIR_SERVER_MAX_BULK (1 * MiB)=0A=
+=0A=
 #define USBREDIR_SERVER_CTRL 0=0A=
+#define USBREDIR_SERVER_BULK 1=0A=
+#define USBREDIR_SERVER_INTERRUPT 2=0A=
 =0A=
 /* Which message answers the host when a control transfer ends. */=0A=
 typedef enum {=0A=
@@ -113,7 +121,9 @@ typedef struct USBRedirServerPkt {=0A=
     USBPacket pkt;=0A=
 =0A=
     /* Kept for the usbredir response. */=0A=
+    struct usb_redir_interrupt_packet_header intr_hdr;=0A=
     struct usb_redir_control_packet_header ctrl_hdr;=0A=
+    struct usb_redir_bulk_packet_header bulk_hdr;=0A=
 =0A=
     /*=0A=
      * The IOV points here. IN data lands in it, OUT data is copied in.=0A=
@@ -546,6 +556,66 @@ static void usbredir_server_ctrl_complete(USBRedirServ=
er *s,=0A=
     }=0A=
 }=0A=
 =0A=
+static void usbredir_server_bulk_reply(USBRedirServer *s, uint64_t id,=0A=
+    const struct usb_redir_bulk_packet_header *hdr, uint8_t status,=0A=
+    uint8_t *data, int len)=0A=
+{=0A=
+    struct usb_redir_bulk_packet_header resp =3D *hdr;=0A=
+=0A=
+    resp.status =3D status;=0A=
+    resp.length =3D len;=0A=
+    resp.length_high =3D len >> 16;=0A=
+=0A=
+    usbredirparser_send_bulk_packet(s->parser, id, &resp,=0A=
+                                    len > 0 ? data : NULL, len);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_bulk_complete(USBRedirServer *s,=0A=
+                                          USBRedirServerPkt *rp)=0A=
+{=0A=
+    uint8_t status =3D usbredir_server_status(rp->pkt.status);=0A=
+    bool is_in =3D !!(rp->bulk_hdr.endpoint & USB_DIR_IN);=0A=
+    int actual =3D rp->pkt.actual_length;=0A=
+    /* Only an IN transfer carries data back. */=0A=
+    int len =3D is_in ? actual : 0;=0A=
+=0A=
+    trace_usbredir_server_bulk_complete(rp->redir_id, rp->bulk_hdr.endpoin=
t,=0A=
+                                        status, actual);=0A=
+    usbredir_server_bulk_reply(s, rp->redir_id, &rp->bulk_hdr, status,=0A=
+                               rp->data, len);=0A=
+}=0A=
+=0A=
+static void usbredir_server_interrupt_reply(USBRedirServer *s, uint64_t id=
,=0A=
+    const struct usb_redir_interrupt_packet_header *hdr, uint8_t status,=
=0A=
+    uint8_t *data, int len)=0A=
+{=0A=
+    struct usb_redir_interrupt_packet_header resp =3D *hdr;=0A=
+=0A=
+    resp.status =3D status;=0A=
+    resp.length =3D len;=0A=
+=0A=
+    usbredirparser_send_interrupt_packet(s->parser, id, &resp,=0A=
+                                         len > 0 ? data : NULL, len);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_interrupt_complete(USBRedirServer *s,=0A=
+                                               USBRedirServerPkt *rp)=0A=
+{=0A=
+    uint8_t status =3D usbredir_server_status(rp->pkt.status);=0A=
+    bool is_in =3D !!(rp->intr_hdr.endpoint & USB_DIR_IN);=0A=
+    int actual =3D rp->pkt.actual_length;=0A=
+    /* Only an IN transfer carries data back. */=0A=
+    int len =3D is_in ? actual : 0;=0A=
+=0A=
+    trace_usbredir_server_interrupt_complete(rp->redir_id,=0A=
+                                             rp->intr_hdr.endpoint,=0A=
+                                             status, actual);=0A=
+    usbredir_server_interrupt_reply(s, rp->redir_id, &rp->intr_hdr, status=
,=0A=
+                                    rp->data, len);=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
@@ -612,6 +682,12 @@ static void usbredir_server_packet_complete(USBPort *p=
ort, USBPacket *p)=0A=
     case USBREDIR_SERVER_CTRL:=0A=
         usbredir_server_ctrl_complete(s, rp);=0A=
         break;=0A=
+    case USBREDIR_SERVER_BULK:=0A=
+        usbredir_server_bulk_complete(s, rp);=0A=
+        break;=0A=
+    case USBREDIR_SERVER_INTERRUPT:=0A=
+        usbredir_server_interrupt_complete(s, rp);=0A=
+        break;=0A=
     default:=0A=
         g_assert_not_reached();=0A=
     }=0A=
@@ -1023,6 +1099,121 @@ static void usbredir_server_get_alt_setting(void *p=
riv, uint64_t id,=0A=
                                USBREDIR_SERVER_REPLY_ALT);=0A=
 }=0A=
 =0A=
+static void usbredir_server_bulk_packet(void *priv, uint64_t id,=0A=
+    struct usb_redir_bulk_packet_header *hdr,=0A=
+    uint8_t *data, int data_len)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    int idx =3D usbredir_server_ep_index(hdr->endpoint);=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    bool is_in =3D !!(hdr->endpoint & USB_DIR_IN);=0A=
+    int pid =3D is_in ? USB_TOKEN_IN : USB_TOKEN_OUT;=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServerPkt *rp;=0A=
+    USBEndpoint *ep;=0A=
+    uint8_t status;=0A=
+    uint32_t len;=0A=
+=0A=
+    /* The host still waits for an answer, even to a request we refuse. */=
=0A=
+    status =3D usbredir_server_ep_status(s, hdr->endpoint,=0A=
+                                       USB_ENDPOINT_XFER_BULK);=0A=
+    if (status !=3D usb_redir_success) {=0A=
+        trace_usbredir_server_refused(id, hdr->endpoint, status,=0A=
+                                      USB_ENDPOINT_XFER_BULK,=0A=
+                                      s->ep[idx].type);=0A=
+        usbredir_server_bulk_reply(s, id, hdr, status, NULL, 0);=0A=
+        usbredirparser_free_packet_data(s->parser, data);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* IN: what the host asked for. OUT: what the host sent. */=0A=
+    len =3D is_in ? (((uint32_t)hdr->length_high << 16) | hdr->length)=0A=
+                : (uint32_t)data_len;=0A=
+=0A=
+    /*=0A=
+     * Too big. Tell the host the transfer failed.=0A=
+     * Do not send back less data instead. The host would see the=0A=
+     * missing bytes as an error and reset the device.=0A=
+     */=0A=
+    if (len > USBREDIR_SERVER_MAX_BULK) {=0A=
+        trace_usbredir_server_bulk_too_big(id, hdr->endpoint, len);=0A=
+        usbredir_server_bulk_reply(s, id, hdr, usb_redir_inval, NULL, 0);=
=0A=
+        usbredirparser_free_packet_data(s->parser, data);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    ep =3D usb_ep_get(device, pid, ep_nr);=0A=
+    rp =3D usbredir_server_pkt_alloc(len, idx);=0A=
+    rp->redir_id =3D id;=0A=
+    rp->type =3D USBREDIR_SERVER_BULK;=0A=
+    rp->bulk_hdr =3D *hdr;=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, pid, ep, 0, s->next_id++, false, false);=0A=
+=0A=
+    /* OUT data comes from the host. IN data is written by the device. */=
=0A=
+    if (!is_in && len > 0) {=0A=
+        memcpy(rp->data, data, len);=0A=
+    }=0A=
+    usb_packet_addbuf(&rp->pkt, rp->data, len);=0A=
+=0A=
+    trace_usbredir_server_bulk(id, hdr->endpoint, len);=0A=
+    usbredirparser_free_packet_data(s->parser, data);=0A=
+    usbredir_server_submit(s, rp);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The host sends an interrupt_packet. It is a request: interrupt OUT=0A=
+ * data to write, or a single IN request to answer.=0A=
+ */=0A=
+static void usbredir_server_interrupt_packet(void *priv, uint64_t id,=0A=
+    struct usb_redir_interrupt_packet_header *hdr,=0A=
+    uint8_t *data, int data_len)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    int idx =3D usbredir_server_ep_index(hdr->endpoint);=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    bool is_in =3D !!(hdr->endpoint & USB_DIR_IN);=0A=
+    int pid =3D is_in ? USB_TOKEN_IN : USB_TOKEN_OUT;=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServerPkt *rp;=0A=
+    USBEndpoint *ep;=0A=
+    uint8_t status;=0A=
+    int len;=0A=
+=0A=
+    /* The host still waits for an answer, even to a request we refuse. */=
=0A=
+    status =3D usbredir_server_ep_status(s, hdr->endpoint,=0A=
+                                       USB_ENDPOINT_XFER_INT);=0A=
+    if (status !=3D usb_redir_success) {=0A=
+        trace_usbredir_server_refused(id, hdr->endpoint, status,=0A=
+                                      USB_ENDPOINT_XFER_INT,=0A=
+                                      s->ep[idx].type);=0A=
+        usbredir_server_interrupt_reply(s, id, hdr, status, NULL, 0);=0A=
+        usbredirparser_free_packet_data(s->parser, data);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* IN: what the host asked for. OUT: what the host sent. */=0A=
+    len =3D is_in ? hdr->length : data_len;=0A=
+=0A=
+    ep =3D usb_ep_get(device, pid, ep_nr);=0A=
+    rp =3D usbredir_server_pkt_alloc(len, idx);=0A=
+    rp->redir_id =3D id;=0A=
+    rp->type =3D USBREDIR_SERVER_INTERRUPT;=0A=
+    rp->intr_hdr =3D *hdr;=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, pid, ep, 0, s->next_id++, false, false);=0A=
+=0A=
+    /* OUT data comes from the host. IN data is written by the device. */=
=0A=
+    if (!is_in && len > 0) {=0A=
+        memcpy(rp->data, data, len);=0A=
+    }=0A=
+    usb_packet_addbuf(&rp->pkt, rp->data, len);=0A=
+=0A=
+    trace_usbredir_server_interrupt(id, hdr->endpoint, len);=0A=
+    usbredirparser_free_packet_data(s->parser, data);=0A=
+    usbredir_server_submit(s, rp);=0A=
+}=0A=
+=0A=
 static void usbredir_server_filter_reject(void *priv)=0A=
 {=0A=
     trace_usbredir_server_filter_reject();=0A=
@@ -1046,6 +1237,24 @@ static void usbredir_server_interface_info(void *pri=
v,=0A=
     /* The host should not send this to a device. Nothing to do. */=0A=
 }=0A=
 =0A=
+static void usbredir_server_alloc_bulk_streams(void *priv, uint64_t id,=0A=
+    struct usb_redir_alloc_bulk_streams_header *hdr)=0A=
+{=0A=
+    /* We do not advertise bulk streams. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_start_bulk_receiving(void *priv, uint64_t id,=
=0A=
+    struct usb_redir_start_bulk_receiving_header *hdr)=0A=
+{=0A=
+    /* We do not advertise this. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_stop_bulk_receiving(void *priv, uint64_t id,=
=0A=
+    struct usb_redir_stop_bulk_receiving_header *hdr)=0A=
+{=0A=
+    /* We do not advertise this. Nothing to do. */=0A=
+}=0A=
+=0A=
 static void usbredir_server_cancel_data_packet(void *priv, uint64_t id)=0A=
 {=0A=
     USBRedirServer *s =3D priv;=0A=
@@ -1086,7 +1295,9 @@ static void usbredir_server_cancel_data_packet(void *=
priv, uint64_t id)=0A=
 static void usbredir_server_send_cancelled(USBRedirServer *s,=0A=
                                            USBRedirServerPkt *rp)=0A=
 {=0A=
+    struct usb_redir_interrupt_packet_header intr;=0A=
     struct usb_redir_control_packet_header ctrl;=0A=
+    struct usb_redir_bulk_packet_header bulk;=0A=
 =0A=
     switch (rp->type) {=0A=
     case USBREDIR_SERVER_CTRL:=0A=
@@ -1096,6 +1307,21 @@ static void usbredir_server_send_cancelled(USBRedirS=
erver *s,=0A=
         usbredirparser_send_control_packet(s->parser, rp->redir_id,=0A=
                                            &ctrl, NULL, 0);=0A=
         break;=0A=
+    case USBREDIR_SERVER_BULK:=0A=
+        bulk =3D rp->bulk_hdr;=0A=
+        bulk.status =3D usb_redir_cancelled;=0A=
+        bulk.length_high =3D 0;=0A=
+        bulk.length =3D 0;=0A=
+        usbredirparser_send_bulk_packet(s->parser, rp->redir_id,=0A=
+                                        &bulk, NULL, 0);=0A=
+        break;=0A=
+    case USBREDIR_SERVER_INTERRUPT:=0A=
+        intr =3D rp->intr_hdr;=0A=
+        intr.status =3D usb_redir_cancelled;=0A=
+        intr.length =3D 0;=0A=
+        usbredirparser_send_interrupt_packet(s->parser, rp->redir_id,=0A=
+                                             &intr, NULL, 0);=0A=
+        break;=0A=
     default:=0A=
         return;=0A=
     }=0A=
@@ -1143,6 +1369,8 @@ static void usbredir_server_create_parser(USBRedirSer=
ver *s)=0A=
     s->parser->hello_func =3D usbredir_server_hello;=0A=
     s->parser->reset_func =3D usbredir_server_reset;=0A=
     s->parser->control_packet_func =3D usbredir_server_control_packet;=0A=
+    s->parser->bulk_packet_func =3D usbredir_server_bulk_packet;=0A=
+    s->parser->interrupt_packet_func =3D usbredir_server_interrupt_packet;=
=0A=
     s->parser->set_configuration_func =3D usbredir_server_set_configuratio=
n;=0A=
 =0A=
     /* The parser calls these directly, so they must not be NULL. */=0A=
@@ -1154,12 +1382,21 @@ static void usbredir_server_create_parser(USBRedirS=
erver *s)=0A=
     s->parser->device_disconnect_ack_func =3D=0A=
         usbredir_server_device_disconnect_ack;=0A=
     s->parser->interface_info_func =3D usbredir_server_interface_info;=0A=
+    s->parser->alloc_bulk_streams_func =3D usbredir_server_alloc_bulk_stre=
ams;=0A=
     s->parser->cancel_data_packet_func =3D usbredir_server_cancel_data_pac=
ket;=0A=
+    s->parser->start_bulk_receiving_func =3D=0A=
+        usbredir_server_start_bulk_receiving;=0A=
+    s->parser->stop_bulk_receiving_func =3D=0A=
+        usbredir_server_stop_bulk_receiving;=0A=
 =0A=
-    /* Capabilities: 64-bit IDs, connect_device_version, ep_info sizes */=
=0A=
+    /*=0A=
+     * Capabilities: 64-bit IDs, connect_device_version, ep_info sizes=0A=
+     * and 32-bit bulk lengths.=0A=
+     */=0A=
     usbredirparser_caps_set_cap(caps, usb_redir_cap_connect_device_version=
);=0A=
     usbredirparser_caps_set_cap(caps, usb_redir_cap_ep_info_max_packet_siz=
e);=0A=
     usbredirparser_caps_set_cap(caps, usb_redir_cap_64bits_ids);=0A=
+    usbredirparser_caps_set_cap(caps, usb_redir_cap_32bits_bulk_length);=
=0A=
 =0A=
     /*=0A=
      * In USB the host is the side that starts every transfer; a device=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index d63156a930..5ec5127efa 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -417,3 +417,9 @@ usbredir_server_nak_park(uint64_t id, int ep) "id %" PR=
Iu64 " ep %d"=0A=
 usbredir_server_nak_retry(uint64_t id, int ep) "id %" PRIu64 " ep %d"=0A=
 usbredir_server_ctrl_complete(uint64_t id, int status, int actual) "id %" =
PRIu64 " status %d actual %d"=0A=
 usbredir_server_ctrl_refused(uint64_t id, int status) "id %" PRIu64 " stat=
us %d"=0A=
+usbredir_server_bulk(uint64_t id, uint8_t ep, size_t len) "id %" PRIu64 " =
ep 0x%02x len %zu"=0A=
+usbredir_server_bulk_complete(uint64_t id, uint8_t ep, int status, int act=
ual) "id %" PRIu64 " ep 0x%02x status %d actual %d"=0A=
+usbredir_server_bulk_too_big(uint64_t id, uint8_t ep, uint32_t len) "id %"=
 PRIu64 " ep 0x%02x len %u"=0A=
+usbredir_server_refused(uint64_t id, uint8_t ep, int status, uint8_t want,=
 uint8_t got) "id %" PRIu64 " ep 0x%02x status %d, wanted type %u, it is %u=
"=0A=
+usbredir_server_interrupt(uint64_t id, uint8_t ep, size_t len) "id %" PRIu=
64 " ep 0x%02x len %zu"=0A=
+usbredir_server_interrupt_complete(uint64_t id, uint8_t ep, int status, in=
t actual) "id %" PRIu64 " ep 0x%02x status %d actual %d"=0A=
-- =0A=
2.53.0=0A=

