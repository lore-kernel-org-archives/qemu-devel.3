Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3410C10F285F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AzN-00056U-VR; Fri, 27 Mar 2026 13:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1w6AOk-0006Bk-Q5
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:51:03 -0400
Received: from mail-westeuropeazon11020098.outbound.protection.outlook.com
 ([52.101.69.98] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1w6AOf-0005GW-6e
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:50:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IuuOpn2lZ0bbhpQOX5LUMqpw2VjpfCKJOdyQ0oxduB0tYIkvphKvVvDxIeio18ZcJzzRfBkBAyaur4p4/XwjHrJBUkYwc+t/uZO6bSd8HBFTO6XMwWoz9q50Fwx612YjiEFps1WOpfXoPuGqg81rvfz2AGBCSsVtkvZzuZzgGysjlB6l5F/mryPApie8yCPSvCKayDYK3J6se9uoJbPVOjgmjn2sAN7RwLTPujqgWYZZcK5n0Jxcf0hnyDUiaKlpbJpF1qbyB8AM/0blFWVGsvvcHCyUodrAQw4j3vEARZ8KqZqULi3wvw8MptfET3r8KEp2jtCkO8EOADpD+0dzNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2wzPoaUiOSCbEa3CwztCALJVz3mOXXoLOqc6SA7wnM=;
 b=nPErHRTHasnKaHjxD8SVfWMvZWFmvu5G6b/XCq76aDwXGff8JdpHFIEtMbdGuSoOdWdhVXlrS6PnhWiubPGZWB54IqAXQAWr4bHEaPPwtGPqVoVYSh3ghRmksj5GnQeRwvMT8oFI748vuaXWPZGf8IaRCtuNCuiHXvbbNgZ3xWVVy38UbGzQ20kiWWZQz9J04Vu68m8EQrpUO0rc+0r3JvQAV9kKHNGVv6Mgzem4h7w87MSgqP4FtYTS/DBoOi/4osfZPcjltdG2cwnB2WW1CvUd4Q0sWLCWKPnD0nPykW3Fw5aVeW4T+7nzzT0sgKjznkv+whQHewOa+kFkP77t5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2wzPoaUiOSCbEa3CwztCALJVz3mOXXoLOqc6SA7wnM=;
 b=YrqZJfYaGWHL9QZMqym0FIRmRUJJspA6HBAJKqsp1mrZEURYnpAXbu+zmQMMe+wJ0PYS4Zgp6K6zX3XsTd3XM+pGI9uwFpjocJQVR6spkZs1t9JgQFWtAvBAYTDDlEcwCBSn7T8sAVAazEOlzoHYt7XE+gfjticLDJn4WHjpOfi4SzsKPY/d+lvNNYWp4+UXgEv0B0RodFPKHDhLBh5FXJPE2WjFnL0bnBnmGYKKIewEbJJlO2T82z+MklMZhDFUFX29b/JG1+AXS2b1+V2Y+kkghLFoTX6TQhOXhzTWwhqqqA9xjaSHa6moF7/L4j6A3q9J1e6mdil8MMNtdpe2Iw==
Received: from DB8P190MB0714.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:125::20)
 by AM7P190MB0712.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 16:45:51 +0000
Received: from DB8P190MB0714.EURP190.PROD.OUTLOOK.COM
 ([fe80::6b04:e38f:74b4:1b00]) by DB8P190MB0714.EURP190.PROD.OUTLOOK.COM
 ([fe80::6b04:e38f:74b4:1b00%4]) with mapi id 15.20.9745.023; Fri, 27 Mar 2026
 16:45:51 +0000
From: Anton Kuchin <antonkuchin@nebius.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>, NB-Core Team <NB-CoreTeam@nebius.com>
Subject: [PATCH] tests: don't build audio tests when no audio drivers are
 enabled
Thread-Topic: [PATCH] tests: don't build audio tests when no audio drivers are
 enabled
Thread-Index: AQHcvgjgUT1oTb9j8kWtDX5sFatTpw==
Date: Fri, 27 Mar 2026 16:45:51 +0000
Message-ID: <DB8P190MB07142E1BA8DEEA8B2E41D5B2DB57A@DB8P190MB0714.EURP190.PROD.OUTLOOK.COM>
Accept-Language: en-NL, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P190MB0714:EE_|AM7P190MB0712:EE_
x-ms-office365-filtering-correlation-id: 03e3e9fc-2890-4801-f3fe-08de8c204e45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: YsW1fAj8T/nT5BSSUSn2dnc41bUbAZM9egg8l+P2nttWk4dWYLHcF67bVKoQ7FVG6J0kKWPqRscaITwVq68PMtY5texv5zwv7bzdVR03fFRZYzIudQLy6jEGTIUvcFMyV73IJJUSgR2SsEKPtprDhF8T4uQK+K8gJlrvGcvWveovu/zm9jvfXeJ2uiEfwdnlfSoY88RvSSUBMovLzfYTaN7IbHJyTwnPSM2Z0EY6L3SsyOQsoFQF8FqwSM5kJ6gIQBoNLFkJDgIaGlG9+ys5I06KI6aUDYuqlnzKEJiPFn5Wse6u3hgwLV3N9B79mXR/39wTthD4sM9Hy9o2PHDAHp/XltMa5O/10k3Kt9AfhSaKHISkba7/fygaPUSIU1H5F29xe9kA4DfAHnAxDeVM2bYoHi+dFmT0dKCxg0pL4xBXsUZu0us7Apvdd5MjSkliJKRrCETkp7/5wb5D6LCJtOsPcEAvYvl0vexyyFCi5gJ1EWfCEPgJBKbWG1mYUNwyykCwwSSw44Nsho9LKXzBrUxbVJQ6Y68ga3zIVIp0ZvLv/4dc3EH1hIycANUX44pteDYqe3283Csw2Wqm7EfQfEyiYhPOGn/sqdG9vSDif3kI63VFn8xUQydAbMkxlvAaeFCiOjyyJDjoQApvNZW+mJoxeaAe6dgCUPLaSPo9nGbyFSRv1KfFET2HT01eVtBN8DStjTzjTefOSlKVzh2xhIfW4fg+ti43HWFJVnibFJOIEgqkIUrHwEEXXH6YQEWJn+gUhwEW6wsksRsnq79lco4t5qOmBlonamJd137ABBw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8P190MB0714.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?axBf+7VU4xDyDB4AH24XDFa2dTrxCL2Xs7jcq1qZ3W3lB9maHghNz0+9/g?=
 =?iso-8859-1?Q?fcMDaLLm9EFmDaknXakxpKFWnwGnkcHF9fFdSkrkk37F5rvjAfscdjDoYW?=
 =?iso-8859-1?Q?Y3l9hxQnxOX91afodmnwWlysHXs9zTc70he0YXG78qEbll0y/5LLjGI5/U?=
 =?iso-8859-1?Q?HPtJ5rip1qoJUJxo82tRBsBjG9GvwnXKtjbSYJuF94qlWAoTznOtvD4ti5?=
 =?iso-8859-1?Q?FisCmw7qnLeYkyI71vz5zA1DTGd7qDpB0TMnGm4QWLHRIWnsw/9Kb+ixqg?=
 =?iso-8859-1?Q?8jPcJYZyQppt72ro/U8U2zpldvfd7Vsl9mVEf2dZb8pS5n8FiapwpxLGcx?=
 =?iso-8859-1?Q?CEauVRKuwiDbHDEckmZq9+qPymRHLSiAp6kIgOAhaSSoS9O7N9wBO6ICIA?=
 =?iso-8859-1?Q?ymRY+N6D3MxbWlFJcZ8QhcTsV0SMjN/pKoVvapCqqjjX5LgR4M93EZGq72?=
 =?iso-8859-1?Q?2Elehqhg7sZ3J6D93wXgyUtrKtD6Qzoqa+WdajlbEM5moaXl/i3HCyoLy0?=
 =?iso-8859-1?Q?qOLocXiP7zHF+83ZSm4+qkwKvOmhhA2aTwsuf2u13wd52zM4/ijRD5DusN?=
 =?iso-8859-1?Q?8sRiuiZ83kqs5+4pn3kd48qMsd397UrHYD4d3LRZYwjCRyg0By8mWrLbpe?=
 =?iso-8859-1?Q?bwHbO3ENDFERF5kP4YHhZ51UKD6M+vRQQ7pALFEfiiHNwLxdVBpqIB4z6m?=
 =?iso-8859-1?Q?bdnP3oTeN/435qofJSDjKBRankaFOnoJqLZuOmRgMDjjBnAZc19DMTixDc?=
 =?iso-8859-1?Q?PSjt+rp5Q7NdFrATDtYZtkKrmNlf0co35vB7lIZt+j2JttXeoA614kYI/o?=
 =?iso-8859-1?Q?6+k3UkHMG5LqL6VtdPVjuXVq5Bwkqcu+qH85DPuDf89EjCfVZN1/Zf8Z/1?=
 =?iso-8859-1?Q?2dye6zMUYt9QOLndIjajQ9ZWkXMkybrVY0HZsIPNSG4Hw3OnYVah5fw4Vn?=
 =?iso-8859-1?Q?zxI6dSAJARc6387hj5eNw4kGJXLyAX8vChjwhL3hedbWymrdvDO6XR+ssm?=
 =?iso-8859-1?Q?h2Gt8eTVmDUj7Kwj08lBUaHSTyq2DKiO8+ZaHCr0vbCWVltj5yuw+Lgk2z?=
 =?iso-8859-1?Q?INba+HRJOxWwyrXz0pmgH13POirurpCRuqoQKvA/reNeOx3lunDSxCdrZ3?=
 =?iso-8859-1?Q?5zab3OqF6dZeFGl2khPEdxJfi1qJt2tkQ3pqxoLj0SkGjrjhfOmNuP4UEt?=
 =?iso-8859-1?Q?/gCuT9aE760Nc1C2WfG8ogMhFqoISQ/UXc+kT74+jYJFW2wbYJvuXCPp4i?=
 =?iso-8859-1?Q?9CjaS1rRUfZ3JKiHOSbvCuwIooRi5wFsHBuMgQHISiQtLSOkqPg/aapL6y?=
 =?iso-8859-1?Q?75sVHf2quVlcnvkxlbms7XyL/GTS/qpxkRp2WfULWVqyIG/wx0IEnPB4D7?=
 =?iso-8859-1?Q?yRMKqsFzteHePkMnj7d5ftFYDA+nEPcQsmosAxYN8p1D4rvNW6zcSqrMlW?=
 =?iso-8859-1?Q?zc2oOVqYRm+/tr9lfWeVUhE1yhwvgqnE2Pn6BDhckdDa6XDKf+JqbSpgdX?=
 =?iso-8859-1?Q?vSrO4nwp2ggPhsTcRnw+yEKRUYjYuF3mmgMN4dm/1fQZHzPEOf/FYZhiFy?=
 =?iso-8859-1?Q?+wK/8uYf1WOUlHmyM72ZTUdYNi4m46kYVGVktWI54u7Y3RJ6GP3QtzG2fg?=
 =?iso-8859-1?Q?kGh7Y3RZNvur7ehMimKtOBz2ydLrbGhtjd6tTJtxx1yE/Ua/eYyc1eSQN7?=
 =?iso-8859-1?Q?dpChNf4ibpJy+suiJfgqnI4fohChu1567/H3vlhhPGBW+rC9cVWk21YOPN?=
 =?iso-8859-1?Q?ppgGzUvSaFDIb+bcPwetDicpnXQpX9+D8mY35lazIdQjYg3O8LgWXrHKi0?=
 =?iso-8859-1?Q?cuaswkmbfaHgF2jI9Xxpuw8/SUtSN6+W9bsdqM5HZuV9PxT3C53W?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P190MB0714.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e3e9fc-2890-4801-f3fe-08de8c204e45
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 16:45:51.2899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vRpnVWuZeSxh3NJV4Y1m61kBC1BEw9aj7B7DLUyeOtFaarGVeSU1WzUtTmE2lTjLch+l8py6WpISVgvir50Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0712
Received-SPF: pass client-ip=52.101.69.98; envelope-from=antonkuchin@nebius.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Mar 2026 13:28:52 -0400
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

When there are no audio drivers configure fails with "ERROR: Command=0A=
cannot have '@INPUT@', since no input files were specified".=0A=
=0A=
Fixes: 3220b38a8d ("tests: start manual audio backend test")=0A=
Signed-off-by: Anton Kuchin <antonkuchin@nebius.com>=0A=
---=0A=
 tests/audio/meson.build | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/tests/audio/meson.build b/tests/audio/meson.build=0A=
index 84754bde22..322755b880 100644=0A=
--- a/tests/audio/meson.build=0A=
+++ b/tests/audio/meson.build=0A=
@@ -1,6 +1,6 @@=0A=
 # SPDX-License-Identifier: GPL-2.0-or-later=0A=
=0A=
-if not have_system=0A=
+if not have_system or audio_modinfo_files.length() =3D=3D 0=0A=
   subdir_done()=0A=
 endif=0A=
=0A=
-- =0A=
2.34.1=

