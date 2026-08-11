Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5FFC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtct3-0003hW-Sl; Mon, 10 Aug 2026 23:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtct1-0003g7-Gs; Mon, 10 Aug 2026 23:10:43 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtcsz-0004L5-S7; Mon, 10 Aug 2026 23:10:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fafu8wVMHRdXBw2MogweW0D2p0yqD1Bentg6TZcb5wI+DOS2twhniGOA2W+pjqbuuQoC0HcXBc0KDM2HmM1oXCbpHCIENIBH075vSAk80fWicxbgsrm2m0IqxnByibT22kBWXvTJlYfsPcRk4raZHfiQnwqDOW8NSaMmkRtcn1gs67ZxF5RNk5cyt0XhE3ZlcQmlzPiNv1NSxNFEPAL4CzAQ//JplGol161M640ofipqE3QNUp3vYxQgUJe/9DMiXAIyypAs9Q/xgL31O1PuAGa7L51797nnIwOhJOl1G6Y5ObrDvxzWbv++1neKfbrq8ovUL4pkAgNMwZmgK0E6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGQ/+xFR/giW1SFwG4tMs6nodar1OgiAKLomEI0Wzvo=;
 b=swQi3IO+eTo+JroEG/wBL0S36IkbG1iJiU6yVsIX/6hAO3xvljRM7hi4yL2M4dT8FBhUR3KraA/h1IPy+IlxleDrPiXzFFwLCW2c9qjXQZnxB0Z2oqDrNsCRYoJvjttgPy3RUPH2l83x6e0c/HuImk24faF6i+UnTlIIb+V4McGDnVFDjFANGXNZX9hF/ujDCLJDMTW85/fEN6on436BDwvd8A2NUr3WrckVnwpvf39+r7pvH5hFB/jdsLkEVCKIuqnSUybaX4ZDoZAnC3d58/h+/3ti3fKSZxOAiEL1JptNeCIWt5qN1qxKHWkra82McL6KP/kKWiJUZBJYMM6U8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGQ/+xFR/giW1SFwG4tMs6nodar1OgiAKLomEI0Wzvo=;
 b=jfn+Gw/uph7USd2ZFs2DnC1yy105xO391Z+WL+7b8YMiJhJziSNqN8M1lKYUtss98PojwXUmGHZ7K+JZaAVWDGI0bs+H0ZyIlcsyTErbSUtpx/eshHqshyuvVDRMhSTL6TtkAzDeFWgljNtc1lu1JQGbYisGU7A4du4p1KZ6kqxwiwVJBea6YyIz2Y/398S2ZM63Fk/GRqhIvC/NJBwx6ws3panXUGxGolJAi4EoFbCY0+RgQeFALZyiH4vz8VkXCY3hu9JjAiWcqdPj7vtTSU3oBlwynMpMJw5E2Snb+nJdDFuQzCCw7z6BChBZ+HN4zIOvGn16AocOfJ7icOMx2A==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5808.apcprd06.prod.outlook.com (2603:1096:400:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:10:31 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:10:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 03/16] hw/misc/aspeed_hace: Support scatter-gather mode for
 the crypto command
Thread-Topic: [PATCH v3 03/16] hw/misc/aspeed_hace: Support scatter-gather
 mode for the crypto command
Thread-Index: AQHdKT73kKilrD2aRk2r2PXvpe+JEg==
Date: Tue, 11 Aug 2026 03:10:30 +0000
Message-ID: <20260811031025.2784489-4-jamin_lin@aspeedtech.com>
References: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5808:EE_
x-ms-office365-filtering-correlation-id: b6e7c5ab-f017-4794-768c-08def75619fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|56012099006|18002099003|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: uqCIT4BE+rETJbOkumqmSmw0Vz+ovZjzNjFN1u1S9P0ofdnBpP9+9UMAGoZqCuHdQNufOt//3oVtOsfbqroHCCnptJ+cHHr7uk1lVF3WhNDum6f/XedJI1iwjBounFIAn5ixKHuCSkLZdWNmmqu51BgBS4KEDjKpNoGcYeyVIpCnblVy44oEMh+uejRXu6g3EUK/o3wXOfQniuuRhyd9sJanlrcxk1/NjySuyEKMIr8M8NHXsj0K+i0azJEish7yQFoNPZLNVfG9FT+CANaX5rxa0O114eL9j8rg0OWdv64WqJpEW+1PXEhpj0SuAVraju8sxSybjrcNjEoloORQEcLSzUfJTQckHd1Luzqz/SZ9CjlFO3Tt6demd6lVKFEoIzrVwrkQ2DhytpDh8iSzfYZkd6pyfo1aIC7QWdRwQbz6R3I1+1TWBxJnu+IeFXG/G2+1Mvy/WLvVNZw7uearLDFr6vSJ1JsjH3WHLPlS8w5RWiNC5p/YbAgolZFmPGzBkr0lP0M8JOkiUzkh+qP/0ZdK2beF9FHGFrn2SZs1ZwswwZM/YCCj4PSzrqfLIEAqrJK4yvXzRxw++7MOx5AS15qtK0dvyzfMSOOtVtpTV7RYGXznhUE8V2m/ZGNI/2IbwJza5ck9goHF5so5nxxI/s1Oo1XbKaOsv1R56jnFVoGgZRiShD7xtVykPh+n/iF6E7XhU1Vf6Vk7Gf7uEYFCPwb2K2erUZMnqe0vGIuGZDltTcYNlatV1sh+rMUcM/Tf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(56012099006)(18002099003)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dxdayeCj9zZ590TzJQaozJevZVqBo6G27xB8AsAwKAVIaSeiSvUvyJ9Zl6?=
 =?iso-8859-1?Q?lR8/InaDQsEeYZRqIYUpuTXRG7OMiVSlytGrAoapaPjpJvscazMocftIGL?=
 =?iso-8859-1?Q?VuuliE5Cebjq4/FgLskx50zwv0Oyx6/xyaxnMgq80mEPtUEx2VVtX+K5Ce?=
 =?iso-8859-1?Q?DyFo5IkkpdG6def/qscYmZDqcmk0iCIxhyWOBhM2Wdeoa4GChMzAT+xbgA?=
 =?iso-8859-1?Q?aIvjgTML9N5oOIVK2x+EKt+Iz4wDZjG+L5ewy1SyaaeY2lt/MoNkd7wyEc?=
 =?iso-8859-1?Q?J8RzcY7VUtbwdOuHaucRG8fKW3nzZo2bdjx4SAvhKc3l2mg4rxqIYsnOZt?=
 =?iso-8859-1?Q?2p8zKq3gx+amFDrjuwQID+0PS+W082g3FTxd8dUJ3TdED6WHlO7o/70Gdv?=
 =?iso-8859-1?Q?bT35sDOBNmgEMQO+VKDGbdk/qseiYFdmBdYKcUG6ZPnlfna2wQTvd5sa7X?=
 =?iso-8859-1?Q?Gfo+7RXOjEAybhH06qHKUfsouB/TgrSlrnKSXi+YJdVxMHUcxOCvM8B4t1?=
 =?iso-8859-1?Q?Y1fES+awe7zvXUKps8F/v0Wrxjl0OPKvpI4usGWtdGuYJmL+k+PnZeMFEx?=
 =?iso-8859-1?Q?cPrBokxM9hVhC78U27c7Qku67zWMDfLZ+/nrLyy4Sa5bhXShbWEymuoAGT?=
 =?iso-8859-1?Q?mIMfZCFjS7xNc2X8I/n/BZ47stp7biqWHYICOEk6t4yUQqnSY5mhIjJgNT?=
 =?iso-8859-1?Q?RNUdXJd0l1WJMoH/E9W8N5EhfIROc0t7lYhT/NZg/dBNbzNyzWvA9pb/ut?=
 =?iso-8859-1?Q?/SfSoQNDEz5KXqVekQXbdM/uBFdJPGHnCIof5vb5cXRyV+m0/KgT84wwwm?=
 =?iso-8859-1?Q?DiYMiix4Z19ZvJV7j6HzeyXV5xBGAV6s81AA6ayWRPBnRmr6PVoP+3ZhdI?=
 =?iso-8859-1?Q?t3MC+OuuC+Ong6oKcKbeUEBbO86ehZPbjKqMJQZoR9CxwvbSRgfrHb3CE2?=
 =?iso-8859-1?Q?EqsUwrBYE1PVZl5CCwLQEq1JNTekY8HvNnTmLi479LSI26FDxsFeusy05p?=
 =?iso-8859-1?Q?WWyV/yyh2jjWIkPypo6qTUysZGr6Hxwu/uFlTK2WJ89EH9buPCu9IRski8?=
 =?iso-8859-1?Q?K2yawDZ1qhDlr+Uk2y7iPOJweLn9+0XDw9gr7rv2VgPUSNDK3Dy2jASvx3?=
 =?iso-8859-1?Q?a4yfso7/Gruu3an+ZcLOh6LFJj4piCwIg5RILpEEEtxY2b6uQroIq5cki1?=
 =?iso-8859-1?Q?C9Rk8CRqfJMjR01fxmH1CEs+s5OGebV5Y556tbvxeZQjhWxu+ydY96IJXZ?=
 =?iso-8859-1?Q?aVzlc+PKehEHjmztleojZazeDGm6x2vjNdHLzxNlGsb4XrY5POuRRz5vCz?=
 =?iso-8859-1?Q?w0g6RmSrl4N6D8GUjp2d1oig6VSXiLBNl8JujHYXEfL7tpk2+f2rTg6FZM?=
 =?iso-8859-1?Q?FSsVKNp8sLfX/YB9bPL8Z7nTqvgxjghPDseRJhi8xePOAQSm9JWDxg5GK5?=
 =?iso-8859-1?Q?QVDdKJFhPqYyBUNvJuGer+2d7QnjHGAE02ZeGyfMHoGJjZRsULa8viB7Dm?=
 =?iso-8859-1?Q?lXGP8URj3sZcuIPTRx9WFVPxiedOJkQEb86zTf9ZH+605Rewdo3zy7Pqb8?=
 =?iso-8859-1?Q?Estaovgi5CDIKFdkClaM3Nd3fSHupC/U+tG76cm6MGtFw7098oEcAYlk1Y?=
 =?iso-8859-1?Q?U6WZzlW+ujPJz1HUbfOFe+KQGtkYQvgyXqn3Qxv3blWVPUflPgJ0rsj53Q?=
 =?iso-8859-1?Q?gcUgXwtm4U2YNJjMNGPT+qbRyrT4oa4EXQuXTqK9iMvpj9vnMUGZov8G8n?=
 =?iso-8859-1?Q?0s2o3ehAAfHGKwxbWZMQyt5LSPMjUvMwgNEMpQBNGJcANp3hJeQaiMUO6i?=
 =?iso-8859-1?Q?RASXD7Zcig=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QXZa5qCrXgpWDg6HXmK9xgaFuZdv6tke2UI22aVu/ssMbNct2onYA0d3tG/sFJGQIoEMGWKcoUPYlepGHcyFFI0nfAQpV2MDyuhONZ6jrXkGgWEdaSroqUm5tnKCAxAA8WrpF8SK2P0RaJLHrM2BTpINpv12Jz+/ULKxy1975Oi1Ce/Ld5cQKNpBJ/+KIZxx5mK+Cvd8lEaaZR/BYYjnXpcBWu2dKZuwZcHXUeRMVK3UNWyFcJ73aGdGYFtnRu90kuABLWj0iqrGEZOveQa0J9KGlTJZ2UEnLIFVD1OxSUmY9oYhDuh/bKyIVdf/dxvS7b252NG9RmvzRsS3Yajyow==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e7c5ab-f017-4794-768c-08def75619fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:10:30.8228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uImO6CiSzYJ0D8dxzfu3tEAWThKtJAsL8m+E54RkkW6ytcLUty/DxtT4aUWeyLk3x6beJVrUi45PyQuGFL+8V3sD+Y4sXSeDrfCR5FlVPc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5808
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

The AST2600 and later crypto engines drive the source and destination=0A=
through scatter-gather lists (HACE10[18]/[19]) rather than the single=0A=
contiguous buffers used by the AST2500 direct access mode. Each SG list=0A=
entry is a length word (SG_LIST_LEN_LAST marks the final entry) followed=0A=
by a DRAM address, matching the hash engine layout.=0A=
=0A=
Add a crypt_prepare_sg() helper that gathers the source into / scatters=0A=
the destination out of the bounce buffer by walking the SG list, and=0A=
select it or the existing crypt_prepare_direct() from do_crypt_operation=0A=
based on HACE10[18], mirroring the hash engine's direct/scatter-gather=0A=
dispatch.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_hace.c | 70 +++++++++++++++++++++++++++++++++++++++----=0A=
 1 file changed, 64 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index 0f35d74137..646ff50476 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -608,13 +608,58 @@ static bool crypt_prepare_direct(AspeedHACEState *s, =
uint64_t addr,=0A=
 }=0A=
 =0A=
 /*=0A=
- * Perform an AES/DES/3DES ECB/CBC operation in direct access mode: the so=
urce=0A=
- * and destination are single contiguous buffers (HACE00/HACE04) and the I=
V/key=0A=
- * come from the context buffer (HACE08). For CBC the resulting chaining I=
V is=0A=
- * written back to the context buffer so the driver can continue the chain=
.=0A=
+ * Scatter-gather mode: the source/destination register points at an SG li=
st=0A=
+ * whose entries are a length word (SG_LIST_LEN_LAST flags the final entry=
)=0A=
+ * followed by a DRAM address, matching the hash engine layout. Gather @le=
n=0A=
+ * bytes into @buf, or scatter @buf back out when @to_dram is true.=0A=
+ * Returns true on success.=0A=
+ */=0A=
+static bool crypt_prepare_sg(AspeedHACEState *s, uint64_t addr,=0A=
+                             uint8_t *buf, uint32_t len, bool to_dram)=0A=
+{=0A=
+    uint32_t copied =3D 0;=0A=
+    uint32_t sg_addr;=0A=
+    uint32_t sg_len;=0A=
+    uint32_t entry;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < ASPEED_HACE_MAX_SG && copied < len; i++) {=0A=
+        entry =3D address_space_ldl_le(&s->dram_as, addr,=0A=
+                                     MEMTXATTRS_UNSPECIFIED, NULL);=0A=
+        sg_addr =3D address_space_ldl_le(&s->dram_as, addr + SG_LIST_LEN_S=
IZE,=0A=
+                                       MEMTXATTRS_UNSPECIFIED, NULL);=0A=
+        sg_len =3D entry & SG_LIST_LEN_MASK;=0A=
+=0A=
+        sg_addr &=3D SG_LIST_ADDR_MASK;=0A=
+        addr +=3D SG_LIST_ENTRY_SIZE;=0A=
+=0A=
+        if (sg_len > len - copied) {=0A=
+            sg_len =3D len - copied;=0A=
+        }=0A=
+        if (address_space_rw(&s->dram_as, sg_addr, MEMTXATTRS_UNSPECIFIED,=
=0A=
+                             buf + copied, sg_len, to_dram)) {=0A=
+            return false;=0A=
+        }=0A=
+        copied +=3D sg_len;=0A=
+=0A=
+        if (entry & SG_LIST_LEN_LAST) {=0A=
+            break;=0A=
+        }=0A=
+    }=0A=
+=0A=
+    return copied =3D=3D len;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Perform an AES/DES/3DES ECB/CBC operation. The source and destination a=
re=0A=
+ * either single contiguous buffers (direct access mode) or scatter-gather=
=0A=
+ * lists (HACE10[18]/[19]), addressed by HACE00/HACE04; the IV/key come fr=
om=0A=
+ * the context buffer (HACE08). For CBC the resulting chaining IV is writt=
en=0A=
+ * back to the context buffer so the driver can continue the chain.=0A=
  */=0A=
 static void do_crypt_operation(AspeedHACEState *s, uint32_t cmd)=0A=
 {=0A=
+    bool sg_mode =3D cmd & CRYPT_CMD_SRC_SG_CTRL;=0A=
     uint32_t len =3D s->regs[R_CRYPT_DATA_LEN];=0A=
     bool encrypt =3D cmd & CRYPT_CMD_ENCRYPT;=0A=
     g_autoptr(QCryptoCipher) cipher =3D NULL;=0A=
@@ -631,6 +676,7 @@ static void do_crypt_operation(AspeedHACEState *s, uint=
32_t cmd)=0A=
     size_t iv_offset;=0A=
     size_t blocklen;=0A=
     size_t keylen;=0A=
+    bool status;=0A=
 =0A=
     if (len =3D=3D 0) {=0A=
         return;=0A=
@@ -684,8 +730,14 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
t32_t cmd)=0A=
     src_buf =3D g_malloc0(len);=0A=
     dst_buf =3D g_malloc0(len);=0A=
 =0A=
+    /* Gather the source into the bounce buffer, per the selected mode. */=
=0A=
     src_addr =3D s->regs[R_CRYPT_SRC];=0A=
-    if (!crypt_prepare_direct(s, src_addr, src_buf, len, false)) {=0A=
+    if (sg_mode) {=0A=
+        status =3D crypt_prepare_sg(s, src_addr, src_buf, len, false);=0A=
+    } else {=0A=
+        status =3D crypt_prepare_direct(s, src_addr, src_buf, len, false);=
=0A=
+    }=0A=
+    if (!status) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Failed to read src, addr=3D0x%" HWADDR_PRIx "\n=
",=0A=
                       __func__, src_addr);=0A=
@@ -714,8 +766,14 @@ static void do_crypt_operation(AspeedHACEState *s, uin=
t32_t cmd)=0A=
         }=0A=
     }=0A=
 =0A=
+    /* Scatter the result back out, per the selected mode. */=0A=
     dst_addr =3D s->regs[R_CRYPT_DEST];=0A=
-    if (!crypt_prepare_direct(s, dst_addr, dst_buf, len, true)) {=0A=
+    if (sg_mode) {=0A=
+        status =3D crypt_prepare_sg(s, dst_addr, dst_buf, len, true);=0A=
+    } else {=0A=
+        status =3D crypt_prepare_direct(s, dst_addr, dst_buf, len, true);=
=0A=
+    }=0A=
+    if (!status) {=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Failed to write dst, addr=3D0x%" HWADDR_PRIx "\=
n",=0A=
                       __func__, dst_addr);=0A=
-- =0A=
2.43.0=0A=

