Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4311061B0F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7EYQ-0001iE-HG; Mon, 30 Mar 2026 11:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1w7EYE-0001hv-RU
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:29:15 -0400
Received: from mail-norwayeastazon11023074.outbound.protection.outlook.com
 ([40.107.159.74] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1w7EYB-0004e4-Of
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:29:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6DqU79h17rmDClGv18srMd5/EckzQeA7DemuZwZuRwxmZyNzi6BDoTFFdGa6FHDzLeg2hbcgK3EVi14W6sULzYr3OZZe9MdHNbhmDjlUfiDfgfiTHj2MvEIuzfA43iORxExK/zRUNDadVxLe0R5P0WHjW63UA0rp006IUlwg0aKs9vX2WexCO4ZR2Mx3kTApnGTG6uZcsRFpBow1KlCkb6FFkY1jQ6r6LIbUQ0gdKiV53R0NiyRZTzadFv+mNFX7oPsLDDogcEVsrB0DzkQ1ijuGLPk0ycomzEA36186FVR6Udh75SQAGZ4W7bTmfFd2t2WwrIdq1iCo/44ogD7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rzaz7ZY6ue6f7vFcMRaOfPeq9u/hpsSKlN421iqQlBQ=;
 b=skvlMRWYaGoSVsPJ2OyfJ5o25Diy/0LFsV694M4NoMQuMU/IUK1VykQefJ8MI3fqwgHSqN57fRNZmvr968IkUEhtNJEscvfBJi0H6ggVq4kWtQljYvwxs4y6XcjPTqZH3X9sci8GuCTH112PFRpqpCELuuqUTU+G1PqoPw5BDCm3beMF3zYtrV4vvblAq0jCeR/YoKhtQr7+K7YnuuE6DEfQmb9riwH0mRSpzJTwUeUTlwkhXT0LlLDPSz7x6P7KKfG9P/a3F2oGZoI4/WXJFbTQIA/6F96X7Kp7gymLNJurfhMNiBqlz/rOCjb9QA6ugRe9LtMDrMeF+9b+VGCK+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rzaz7ZY6ue6f7vFcMRaOfPeq9u/hpsSKlN421iqQlBQ=;
 b=MuMQopOhIy5KQZAGlu2fmtKxB85iAEyzCWWYCLfrjLluLmAg9FwHQN7Z1MHXvz1PdSYY3ZkwFz8qD+mF7HDu3o8oTfPrIeGgBpbDVzR4mTcZ/wdPpPhTOD1Ry9i9dIwwIrrWYREHkD+q+p+H/H7uyKVv6CQmhROB4XMW6CNweIzirSdBsVk1UBLK5ze/kykxsqiw2y3HHdUQSZBFa9wIEqW/qGYjOwxmCvWN9ZtTCF1XpnEHOFrdXp7n3Hmf0cCkPi/Q3TWx6cNMUWs7htCZQ/kE3cOtKZt4S4jw/zZcw7PLbMSThe6Ehrbs5RO8FgAOyXw/iA2+Rd6GbxAkHfwG2w==
Received: from DB8P190MB0714.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:125::20)
 by AM9P190MB1026.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:264::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:24:07 +0000
Received: from DB8P190MB0714.EURP190.PROD.OUTLOOK.COM
 ([fe80::6b04:e38f:74b4:1b00]) by DB8P190MB0714.EURP190.PROD.OUTLOOK.COM
 ([fe80::6b04:e38f:74b4:1b00%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:24:06 +0000
From: Anton Kuchin <antonkuchin@nebius.com>
To: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann
 <kraxel@redhat.com>, NB-Core Team <NB-CoreTeam@nebius.com>
Subject: Re: [PATCH] tests: don't build audio tests when no audio drivers are
 enabled
Thread-Topic: [PATCH] tests: don't build audio tests when no audio drivers are
 enabled
Thread-Index: AQHcvgjgUT1oTb9j8kWtDX5sFatTp7XG30GAgAAENICAABZuyw==
Date: Mon, 30 Mar 2026 15:24:06 +0000
Message-ID: <DB8P190MB0714A01F3BAE878AA0F7888BDB52A@DB8P190MB0714.EURP190.PROD.OUTLOOK.COM>
References: <DB8P190MB07142E1BA8DEEA8B2E41D5B2DB57A@DB8P190MB0714.EURP190.PROD.OUTLOOK.COM>
 <CAMxuvaygbUf3eS+r-6=dxiZfHp5KrD7_QLhhnTf7KHfxU+CjPw@mail.gmail.com>
 <CAMxuvax+1omtWMs964yg1ZgFrHn_f2JP98540hY8uPfD-HF8Mg@mail.gmail.com>
In-Reply-To: <CAMxuvax+1omtWMs964yg1ZgFrHn_f2JP98540hY8uPfD-HF8Mg@mail.gmail.com>
Accept-Language: en-NL, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8P190MB0714:EE_|AM9P190MB1026:EE_
x-ms-office365-filtering-correlation-id: 0976abe1-0767-4b67-e649-08de8e706236
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 9Uz8IWplqf8mJCnYOoduSePwQwfpCbcv3P/cb0+oewUn3Al/lMVwz9C2Oqyf6JZKWeQzyBtJZIg7plBMmnHXSL2MISTYirlHvFO8Ky3aciDqc7MpuFueENLCV7ZHTOI/FzZZfDyxLtIg/pE1ndTc6mQHK5xGDjUlSs3FjHCTWWDWCtRZZNEhTmOja0TVznGmBOjn8FAvYXT/ZdeU5CCV4HaD5B/7PHmxgW/Ep0e/IsGGBRc6EDNptlxnO74IS4Jo0LmQLSqrEtV4lrBSBtgKGqM6VnZ5SP80ZHj/chdY1bKQ222iiXuI/9smwjYYtK8tCJJ3NJIZzmtkF17UwwTAQZ+hQ77r8TenfsoNXVgLYo8YNCsqxSBgP7Z4sjmZ1mppTuXZ58+RU7CyTxH+pHhqTwruxOUYrjUAu11TCADu/DWNtuwc/01xBW++phXk1ho5iab8ICbda+URJzxx+amH9DAAyEGxKrc0uO7Sns3kx0fmRmowYJOkOu7oe4SsbQskI9Qu5MqPKgL3FLRlWfKoE8dSGmczwvDatp6/p1jhpWVC298NhKNWhA4Gy6CJeeP2q0kr/O59CquJmVAbA4QGKmg8O0Kn5ffrO8aJVVG18c54jKIjr57CF9eepP7ZHMDQrn3KSZTHOUThf/SbnulED5G71X+ps24lFrj9m1Pmt30aFvymGZn/90hw8an+YpzoV2V43pf9TKXo71s3bWe1uD7eBroeiMS3WytIsq+TGc7o6ZqyNKqh1dz2pl7Dr9wWUDp+pAV+w09Vdju/F+dN0eo4PoRnSMNCgZ5HLM3qxqU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8P190MB0714.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?o2GH0txyr919MxCzh/AGEETZU+rVQR+l3p7AJO8nRCqNcbD5FsB5lwY80+?=
 =?iso-8859-1?Q?L7XogpIRWiWgyn2OS/dx6jBBjqtGXdKYIQwoLo4P0LkFrlip1zIwBs9RDW?=
 =?iso-8859-1?Q?9OxYiZeh8S7joAFP0juvGOKjux2evzHWwr5Us3glXCGpFfrSPDc4eguhtm?=
 =?iso-8859-1?Q?bXDfQ+VA3CGaWXtgjaXJb7Nrk4QZqKUOeJ+y2iOgFbFdJYrnJGpKNfOf+c?=
 =?iso-8859-1?Q?uHgylVNzbQV4fCTELr+TE7V0T2f2Ciirj5Hg4fxU+E/UFL0B7rfR9S09K/?=
 =?iso-8859-1?Q?kGMpESY9jrdUnJdBmJ4lGmnhNWXXRZEiPSDLrG/jI2xrKLAsK3iq+WWBuI?=
 =?iso-8859-1?Q?Ewx+3NF7LdwRCUQEWf/UuKymW54GSNaiD2swPbeh6W3nxrovF59Q7ioT7r?=
 =?iso-8859-1?Q?cDYSip7IjUtlIebVyS4baSqBcP2+4t+FEXT1GkDw/3tegr5kJxyofaMx3t?=
 =?iso-8859-1?Q?CKIUQuZfPbTllFsLEmTIChOYbjc4fJPuo1Up+hwGVeBjn4i7qcx3o1vB9S?=
 =?iso-8859-1?Q?lAJkWOYS9wh+ItqqXvq7ZplbBK811wJGq73ZOgmuRsmj8XughYtmOmLOYd?=
 =?iso-8859-1?Q?DrFeYlclcO+7wy+qQsAkFN+OwvhN+KKtI61AqHB9QLfIeGHUiv1OAoDi9s?=
 =?iso-8859-1?Q?HAJ4+ZRMw48za2XA8L+x5P1h05olYKpzvHG+t9ob8gniIExyJLi1tmnoYq?=
 =?iso-8859-1?Q?0IpcHqp9t5om/QVFIquMvsQJb/Zwq/T4MktSy0585Xl4VprsTbdDFkFatY?=
 =?iso-8859-1?Q?ZIlbFoyJ7ZoX88LeGA261ZdGF1oROQFBWYWKYq+YkYBwQEnTMxA0lCr9Ks?=
 =?iso-8859-1?Q?Z5pAHgXoj8SbTW4rxGN9jAZwHFyBB3CgpGmnlpErJmJJb2RoaltdGhbW1k?=
 =?iso-8859-1?Q?NwiiR2ukLpdWmMKdZea0iY0Yr8xeIAqb/MX4MjiJidcnJz4ipZYRON42Am?=
 =?iso-8859-1?Q?Ps9NhEJmDP6BXWPik9cnHRA92H/7Pw/PVXj9GHCHiC+vglVDiLgZdcKAfn?=
 =?iso-8859-1?Q?TT6DUnApT3rR0K8T4EeqiHdoxusXAjJGgDdheBPBWbqpIxc4KGY29iEby4?=
 =?iso-8859-1?Q?0dEwq0xWHEhAHs9cTOBfzJuWVofwauzpU0eINSMhPUJ8LK2XxaL+jgy+gs?=
 =?iso-8859-1?Q?FaHWFrkluH1eCve8AlZoKWJ6tzMTBViXtUCI3LXBwvTjvfGJRdOzN6hioP?=
 =?iso-8859-1?Q?gM0V4cyuUJhWxp57PHUT7zIr2FqVOZTI46+AMlz9TUQjaQzYe2hhkIRbdB?=
 =?iso-8859-1?Q?N3ncXi21wk2nFsSg0vPJ/TUqyzBLlhnctAa2fxJTdfd2p0la+7XvlfDveQ?=
 =?iso-8859-1?Q?0A+B4prEk2KJ2eIzW0rOre4WsvRktlPPxuUW/u1MVLiKkJGXomtdTQ6hml?=
 =?iso-8859-1?Q?xsZ4U0UVwF0yMM40gCgiEGU4B/Xph4lxhWTJG6fkKrmx1zXFE0cgJW7sIi?=
 =?iso-8859-1?Q?Cx+1fadx9LrL4zQ60IsQ/DrvYDJHA7q+HlITYO1Div3LWgqRA43CaNC9/p?=
 =?iso-8859-1?Q?Xe4OXcuAjcvxKcjd22gEmrZB1eHTKRVphNjHocP652nG4PI/FRtt9qddsZ?=
 =?iso-8859-1?Q?Rsv5JTaesP94Wx3I/rlRfB7MnftM6Fuk/0IBMYSEEew7wbnqNNGIWH/Qob?=
 =?iso-8859-1?Q?Xk/99HY+gkOTCO+FT86Zo00r+5YcZXUY46unhmWMPNUE3f5R3IpbMIrBwB?=
 =?iso-8859-1?Q?fwWNSXPMOSKzAHk5WZdxUU/L9Wv9brV0lbPEyqafecx8a4F4hc7E8NPn4c?=
 =?iso-8859-1?Q?47q/4nNyQLwCZ9lW4Vo6F3O4/qrOFlmWw1ygid7UWz49jaI2I6D/sYth35?=
 =?iso-8859-1?Q?LC4+HuiICv8tuO47CZfuazyFkeo5/PHMlFMfrTUGJbdRQS6ljnPQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P190MB0714.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0976abe1-0767-4b67-e649-08de8e706236
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 15:24:06.8232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WuNECd00a6kwMcokhWGYnmCNtOVkwkHT5eCn/LZ48clCDuALknOnPfEu+DmaTV8H7iymHmU3kbXHuQ84mCAsRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1026
Received-SPF: pass client-ip=40.107.159.74;
 envelope-from=antonkuchin@nebius.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Marc-Andr=E9!=0A=
Thanks for the quick review.=0A=
=0A=
> From:=A0Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
> Sent:=A0Monday, March 30, 2026 12:27:29 pm=0A=
> =0A=
> Could you check if this is good enough and resend:=0A=
> -if not have_system or audio_modinfo_files.length() =3D=3D 0=0A=
> +if not have_system=0A=
> =A0=A0 subdir_done()=0A=
> =A0endif=0A=
> =0A=
> =A0modinfo_dep =3D not_found=0A=
> -if enable_modules=0A=
> +if enable_modules and audio_modinfo_files.length() !=3D 0=0A=
> =A0=A0=A0=A0 modinfo_src =3D custom_target('modinfo.c',=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 output: 'modinfo.c',=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 input: audio_modinfo_files,=0A=
=0A=
I checked this and configure passes, but then build fails with:=0A=
=0A=
FAILED: tests/audio/test-audio =0A=
clang -m64  -o tests/audio/test-audio libqemuaudio.a.p/audio_audio.c.o libq=
emuaudio.a.p/audio_audio-be.c.o libqemuaudio.a.p/audio_audio-mixeng-be.c.o =
libqemuaudio.a.p/audio_mixeng.c.o libqemuaudio.a.p/audio_noaudio.c.o libqem=
uaudio.a.p/audio_wavaudio.c.o libqom.a.p/qom_container.c.o libqom.a.p/qom_o=
bject.c.o libqom.a.p/qom_object_interfaces.c.o libqom.a.p/qom_qom-qobject.c=
.o libevent-loop-base.a.p/event-loop-base.c.o tests/audio/test-audio.p/test=
-audio.c.o tests/audio/test-audio.p/audio-stubs.c.o -Wl,--as-needed -Wl,--n=
o-undefined -pie -Wl,-z,relro -Wl,-z,now -g -O2 -fdebug-prefix-map=3D/home/=
antonkuchin/src/qemu-upstream/build-with-fix/..=3D. -Wformat -Werror=3Dform=
at-security -Wdate-time -D_FORTIFY_SOURCE=3D2 -DVENDOR_UBUNTU -Wl,-Bsymboli=
c-functions -Wl,-z,relro -Wl,--as-needed -Wl,--start-group libqemuutil.a su=
bprojects/libvhost-user/libvhost-user-glib.a subprojects/libvhost-user/libv=
host-user.a -lnuma /usr/lib/x86_64-linux-gnu/libglib-2.0.so -Wl,--export-dy=
namic /usr/lib/x86_64-linux-gnu/libgmodule-2.0.so -pthread /usr/lib/x86_64-=
linux-gnu/libgnutls.so -lm /usr/lib/x86_64-linux-gnu/libpixman-1.so -Wl,--e=
nd-group=0A=
/usr/bin/ld: tests/audio/test-audio.p/test-audio.c.o: in function `main':=
=0A=
/home/antonkuchin/src/qemu-upstream/build-with-fix/../tests/audio/test-audi=
o.c:588:(.text+0xff): undefined reference to `qemu_modinfo'=0A=
clang: error: linker command failed with exit code 1 (use -v to see invocat=
ion)=0A=
=0A=
I think that's because "executable('test-audio',..." is outside of conditio=
nal block and it doesn't work with "modinfo_dep =3D not_found".=0A=
If I move "executable('test-audio',..." inside the block configure and buil=
d work but I'm not sure if this is what we want here.=0A=
From the structure of the original patch I assume that test-audio is suppos=
ed to be built even when enable_modules is False. Does it?=0A=
Or should we build test-audio only when modules are enabled?=0A=
=0A=
--=0A=
Anton=

