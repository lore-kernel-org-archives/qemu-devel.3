Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F5D606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=J35tcffE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM06u-0004sY-Ob; Wed, 28 Oct 2026 05:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xM06r-0004rf-HG; Wed, 28 Oct 2026 05:38:17 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xM06o-00083q-N8; Wed, 28 Oct 2026 05:38:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seScWvinwKTmhrsHOBtaOA3rL5IjDEgm4tJvSGSSYinc9dr8gFaOBtSBEpohsQDBvHIdC9qk6NCUcePwcPh55yuLsOuDNl3KR0tohjC8hSBWd6HDBcabpr0GeTSdPyrogoigG5VnvIJ3mlG/dR3KETPEvnpb7gqkiubhIkUrWc/zUPw8EGqWhcfvdkfJIejBSuTU0ZOoFw+lfvdtLvBId67SkkOZaleEM5N+LBD/qfAery2qm7vEhVyrTvEPp/kYKa+q1DfUxLvRextMV1zgJi4K/+oKQAFfx3j6cljBvyAYG/r3yF17t9/YTDE2xuTi5ejRcWhvEVaPRaYZ5h2t6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mic1snW0xfrCrpu6AFUfQq+x/6HaSmR4h0Q7qSbYKQo=;
 b=ZSudDVxgtPSO2zjYX3auQfcdrlCVzVAsL++fbANETI0cDKEOj8lgCLyDDIzIflw10+D1UoQ+ubJnKhs7b8pwDUXiAUvhg/RIYI7DWb+8xQ39O2ugrlFLGqHFemY9sLrpGOeEtCqqhzjr36f/Z1p3uirpB0shryWGV/xIXm5l7HIAdmyYMb3kwYnGr7Ji/ps6YO3e9WMTMKa2yB8h5yaF8gf8m5UTTkyMpRfY6xe44ELuKbOzAN6vCU5eE092kZ5f2Mn481RjV2VuuqrpGOrQCN+QU5CXbnW50haowT4e2X3gRwYTcd5XEMD9NZoMemI2fR6XT/gfnwZn0BmY+jfGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mic1snW0xfrCrpu6AFUfQq+x/6HaSmR4h0Q7qSbYKQo=;
 b=J35tcffEDu2Slfuxc6qRY2E273b/3QBKX7JzWYGxUdwaUDWVBb7gkSXyiY0nLsd9Ag0NgS53kY5HxyJcV2otVQP/Z717iTRP+VRcjX5c+vrndiVNTNMX7muMpK1bcsPUum4IvgCIb7rDPe2uL2rVSGJLmN7dCxEH+wtqIMVwMY1BML6yOnkCObrXhda2SziAySEVy1PYWwFArC5KcanJ+oPqOOXC0ok3CE1AlhCKOyZbiuvpsoJnkIbw/F/zmhOrZkHMAKyfLBxF14Aq9XICnWnbUUZMaHhF4pIlA6GmaTs0ykzkdPpCKRCIx0H+DxpiVg8EljkAYI4oefbNDRN4BQ==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SG2PR06MB5264.apcprd06.prod.outlook.com (2603:1096:4:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.7; Wed, 28 Oct
 2026 09:38:06 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 09:38:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, Alistair Francis <alistair@alistair23.me>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open
 list:Block layer core" <qemu-block@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1] hw/block/m25p80: Add Winbond software die select command
Thread-Topic: [PATCH v1] hw/block/m25p80: Add Winbond software die select
 command
Thread-Index: AQHdZsAJ30ae8CE4DE+9JmgbWwSCrA==
Date: Wed, 28 Oct 2026 09:38:06 +0000
Message-ID: <20261028093805.2433018-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SG2PR06MB5264:EE_
x-ms-office365-filtering-correlation-id: d68438b4-e7c0-44f3-c687-08df34d72bb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|56012099006|261021123027099003|261026121527099003|10067099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: UxnyLqavHu32dp5RGBRPJBjtDHB0uADaTmLVVS0pBmwItn4V9uLyhswlI3K2gA6XHTpvJeuwNNFLBogSV2b4hWmFw1PBHc2eZ8XKIh6l5+Eqt8EcT/HsozHacFluLfVR9MhjnV9l/JdVc/PIxOjwr9369kZL8ySAfbnPXMOwfovyvfqbxCPUqYtNVNwpWdvzbnFl5V4vabekwpH49d5aUEzksOB44Dqx/QzTk23DxF58MkweQvw61pJQQWdJ7T2HoPDYb3lLIM3BsCnqA8rOw0yuSvMlsvl2NMgkYzX1ucVtRCd0gcOLVjHu5roPL3cZDHhf20OcZisSbuDKy3cHXaihHU3WK9MOqvFklajegQhWm3O6zlilGlNhSoNLFybn7SBcKzHEl4SEyUCNoEz7FGm1pT5vfn+oBTEOfkwv7L3y4YfCDm/V44G8Ty82zf2IXtlgCudp1PMnVp4/VJ0GQmAxKtjtRc4g9Hl6vDHa+vAnol9pObN6gFnWBJrGEn/DTmkpFmt2vf800JOEoaSQMMFqQQragpogJk4IlDLSqxUhANUa7YNPDe7Zsj8ueGfYtuwIE/qgo3XXVaFx0NtjQTVkc4SvcYzAcw+DXZswlTTY/gVk3a65EauPNmcCSwp+NH+46Uuy6w9qyQrOdg+C7FeJ1Mu8sD8jInbxcOa3RzLB1ptj92jpfZNpUNIOlg2aRO/rocOssmxnLWvOMoniLQ2IMCk5cU9bD4NW/blR84w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(56012099006)(261021123027099003)(261026121527099003)(10067099003)(261021121427099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7+2KTxNW2GP2w6cw6cHH705cLgvm2aE72xA+3rIfPbJONxe7ad6N3/zKh85+?=
 =?us-ascii?Q?6poeQSFhqwMea+IeMTcWpDizxYZFd7CJZiWmc3XEpEHKDkGmYUK/itF7G9/p?=
 =?us-ascii?Q?+r94VNC2z0kgXodlVnNJkrmeHy5YnyDCimJSCmWMgkSa2+XOzPTQBuurubz4?=
 =?us-ascii?Q?MbSKxXluoTr90l39YBwvkCVawMUFLcyOSgJl5WrMZ+jcZunczxO56PjRT1sz?=
 =?us-ascii?Q?1D0GHhleI+iUhaSsHNwPFFCPmMaYpJUQIsCs5EluKMYRhjueaS64e9k+dKDY?=
 =?us-ascii?Q?PaSWKU7sdLGxvoWlStAOyRLN02X4mCEuXn3pEM1OmBkbh0Gf4xJLdyofjKCR?=
 =?us-ascii?Q?kaFbZ2MsktUYxGz0bBMay2FzlVUUrjiZsCwqlk8vP/75KJIFd9yrCLkonapj?=
 =?us-ascii?Q?RmeBFHAJvi51CJGNYv7q50qv7Bb4No232s0fyDu4gkdYMSpPcJ5XWBSjYYOq?=
 =?us-ascii?Q?yA2biLeCLbh9SKOZurDtrC11xqJyB1mz7z33O0PTQp9uvVWxwJxnt6mRD8T5?=
 =?us-ascii?Q?nKuK9hv5TFYY+r6plD2gzS/t4dOd9cJNUbel2lAAP7EeCYaXNakfGDBGjerb?=
 =?us-ascii?Q?guYdiDY8aaR18sIhNHrKttO0UxtxK5kBE+c7uOcys/7RF5T+Yy75fGLviZgp?=
 =?us-ascii?Q?kVGsQgnGTxptv5nw8f5XK9BA7xrY0T4DrYqG0Udt7omsKdbfCtDvODwpDfdc?=
 =?us-ascii?Q?xLJwPoOpZUV6K974BzY8qgwWbeFxoS46gfVCvJwNoafnDHy09Ho0/i71Yvkl?=
 =?us-ascii?Q?LOYnujsBLPTf6UKZQYFN937iDFKlrcgUXENLfAoagqgeU+8RWwRjtbMyKaoJ?=
 =?us-ascii?Q?4eUBslRFEIacEDszvooFoZcxD/mF3anX2QIcJbxszG39VY35zc95phnY5jUG?=
 =?us-ascii?Q?nlwebYoF1qnC5Z8o9XUxhbwiJyfBpyUk0LVdbm11CClJBk81KL149CL1yGYu?=
 =?us-ascii?Q?XpSycs0B5Aa7HVNHYJk7NhWPviqMfAJq2ont7BnTgVxts3uwLxHrT0jBfG/3?=
 =?us-ascii?Q?o4vyS/+MiZX/ABfjyIo4WipagBKGvg7KttPhdDJzLyaP8NZK/zrCUkz/kRRI?=
 =?us-ascii?Q?NlFbis3xdjceG+98Fdf1ZI8rWjFut6pN4td/IztzJl2OP9HxqKG9h01aydUd?=
 =?us-ascii?Q?nTwUBlYtOVzAQnXeMAjyOJ+8Zt/DrTn0nKdtpbo18TE7/zVVhezUy9ne0wrv?=
 =?us-ascii?Q?kSuzL4f120p5WAsQRP/mdIc4wFVPShY9iKEzjxzPl6vbXSCjsMI2tbXaP6eT?=
 =?us-ascii?Q?ZlpRdUOfM4LeFD2e2eaOYLG2m9mb+bX4Y5oWYmPp1+N10SB6lDv22L8OkO+t?=
 =?us-ascii?Q?109iaRw5Tdh1yrp5W8HhpWp037CQ1Zh6+6kbwAARzmtW1H+1eMOELdZkdx8w?=
 =?us-ascii?Q?xndYWWMQRH08dKoocVnTwOgfjyTsYVlG55yo27qUO5qfcHcfGKpjP5xl7MZS?=
 =?us-ascii?Q?/Br0XLGnpN75cwCD6V0jtJyWMzWifr5JKJN4brlubSFXILAbm79r65YUifUi?=
 =?us-ascii?Q?2Vg7D76Fz8pwN97zvDkcimRTjGsb4n7vYVRC0wPLh1OMMVriQ6enxcQU+Ibi?=
 =?us-ascii?Q?YFpc+WecnDFK9vR99XGWwAMDF23K0XW2jzhEFbazg524sNA6xJm0u5oNpMMU?=
 =?us-ascii?Q?Jr7H8SYiJ2NuF+2kZCQpX7mx5tY0zHbrN9AUNTqcesmbi80TAMQ5Uk//DPGS?=
 =?us-ascii?Q?e3Yg+rS2OMokFzXc9QWr2HW8Qwer+2ArdKtot3IMEMxOxyeAHq0SKtufeuA3?=
 =?us-ascii?Q?HYVqkAY1uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68438b4-e7c0-44f3-c687-08df34d72bb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 09:38:06.5415 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lYhjkZTr3TD18YEb2MY2GfIBHksoc54advkBwUvDORI6Honz0K/Hsw1ywf1DxHD+XABqRdoGF9kqBXcWDukbY1EgnyAksTa4zWVE/2+8OVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5264
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Newer Linux kernels support multi-die Winbond flashes such as=0A=
W25Q01JV. When polling the flash ready status, the kernel sends the=0A=
Software Die Select (0xC2) command followed by a one byte die ID for=0A=
each die, and then reads the status register of the selected die.=0A=
=0A=
The m25p80 model does not implement this command, so running with=0A=
"-d guest_errors" keeps flooding the log with "M25P80: Unknown cmd c2"=0A=
messages whenever the flash is written or erased.=0A=
=0A=
Implement the command for Winbond devices by collecting the one byte=0A=
die ID. The model stores the flash array as a single contiguous=0A=
storage and only has one set of status registers, so the selected die=0A=
does not affect the current design. The die ID in data[0] is not used.=0A=
=0A=
This commit only fixes the "Unknown cmd c2" log flood.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/block/m25p80.c | 19 +++++++++++++++++++=0A=
 1 file changed, 19 insertions(+)=0A=
=0A=
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c=0A=
index baf798c6b5..528df57e5a 100644=0A=
--- a/hw/block/m25p80.c=0A=
+++ b/hw/block/m25p80.c=0A=
@@ -451,6 +451,11 @@ typedef enum {=0A=
     WEVCR =3D 0x61,=0A=
 =0A=
     DIE_ERASE =3D 0xC4,=0A=
+=0A=
+    /*=0A=
+     * Winbond: 0xC2 - software die select (multi-die devices)=0A=
+     */=0A=
+    DIE_SELECT =3D 0xC2,=0A=
 } FlashCMD;=0A=
 =0A=
 typedef enum {=0A=
@@ -1479,6 +1484,20 @@ static void decode_new_cmd(Flash *s, uint32_t value)=
=0A=
             s->state =3D STATE_COLLECTING_DATA;=0A=
         }=0A=
         break;=0A=
+    case DIE_SELECT:=0A=
+        /*=0A=
+         * The flash array is modelled as a single contiguous storage,=0A=
+         * so the die ID is collected and ignored.=0A=
+         */=0A=
+        if (get_man(s) =3D=3D MAN_WINBOND) {=0A=
+            s->needed_bytes =3D 1;=0A=
+            s->pos =3D 0;=0A=
+            s->len =3D 0;=0A=
+            s->state =3D STATE_COLLECTING_DATA;=0A=
+        } else {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "M25P80: Unknown cmd %x\n", val=
ue);=0A=
+        }=0A=
+        break;=0A=
     case RNVCR:=0A=
         s->data[0] =3D s->nonvolatile_cfg & 0xFF;=0A=
         s->data[1] =3D (s->nonvolatile_cfg >> 8) & 0xFF;=0A=
-- =0A=
2.53.0=0A=

