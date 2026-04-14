Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F1EED7B8A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCYhf-0003ez-4C; Tue, 14 Apr 2026 04:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYha-0003bR-Vp; Tue, 14 Apr 2026 04:00:55 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wCYhZ-00060M-F2; Tue, 14 Apr 2026 04:00:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlWTj01EEVIgyBsSJcEgC4JYupCoXR93hdV/kHg/OOmE0UYiDsYLmGdLnKPpm3I453F+F7v1rlQTqIF5TTxh37EDGBBy4pMDaU4vBWiodVhEK5txLg+2b1xY1T3aB0yzw+I1wNpBLbMoEZXdBulh4MmVyug3VR/6RCmZKnvVjKNPLP+xLUNUU14m7srWnMRyw2YM7STEyBhkYk3E6yx1VzGea7GSwIIGz3m6qUKrd+4O2i6nR6yc4j8IbjQ99lb9LnvjF6klHNDX9yr1QHeMynfPzV9IXyOPrB7ZdQvNwctERnkpm4ST8yifvD+oZIvHA/3HUx1Bf3zG6HBMiWQIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZ5sfLjP2piHvgiFCrLkCqBrAP00iRQDxrNXwZJtM9U=;
 b=YM4xd/KhEhKm3GntzsxK6AXCBC+BEhXdEr9QAE+UnHd8cq2+Fe89n4uDdrawhPNbzfWhnpDVTs0oMTe0suowQ3rsLgQH97LyHGlTXmylQy+bAhhfIfWGYB10S6+GIOj+BgbNHguHJKiLYq+NUQ9P1Q76QNMull27Q47XqLCIWNmTcgqfzBzbOblXZzqnxlyg3TvYqEOC9sXUo++qnL/rUv6wIeWph40eisczccFVvJYcRWbMGjYS8iov+bd2iX7hP1IkyPmCtgbYBF767dTEQC8Bk4jnIyd1QtEwTkTnNR1x+X3u91oIn7rT5w+1ZLwzFbSSpp7NWcR79NnUePR/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZ5sfLjP2piHvgiFCrLkCqBrAP00iRQDxrNXwZJtM9U=;
 b=W3VOfTPEa7KoCPdbSwdE+2qaIM75ulsYkCWz4jw70l0iHTB+Aocb3CHvtKHCd9mmon8tXFL2EmK6f+IGGNCwdYfnsGH2O/pgb303o12j/QRmN9VFcs7Z20kEcmyG8INVs5hoR5mwp0eJBLv9i3s2eiNlsU72qRdVc/Jip+fkAkHD7oltWtAEGxckwAHYfy/6gCN7I04DtXt3CLgNEwj1eeQQ25+YlsR2YUZlRXprpT6NB0YD1CHPd7V7Rc4MEwN/pONs7KScieT1yBV4owzatD0qOZVhv7s2tOmZe1+RzyosEFY0UNWptt/lsj8gSoLWAqtJpgQwIlmylVbAvRBX4Q==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SI4PR06MB8423.apcprd06.prod.outlook.com (2603:1096:4:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 08:00:40 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 08:00:40 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v2 12/17] hw/usb/hcd-ehci: Implement 64-bit siTD descriptor
 addressing
Thread-Topic: [PATCH v2 12/17] hw/usb/hcd-ehci: Implement 64-bit siTD
 descriptor addressing
Thread-Index: AQHcy+TJsvA3WkppfUCywuNmErKtaA==
Date: Tue, 14 Apr 2026 08:00:40 +0000
Message-ID: <20260414080025.3005916-13-jamin_lin@aspeedtech.com>
References: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260414080025.3005916-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SI4PR06MB8423:EE_
x-ms-office365-filtering-correlation-id: e5db6c5c-84c9-4bfb-057c-08de99fbebc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: D0kQkdLVLg9vU3+AFkw4EKKQorJ+JOMVMoGcfMNmloEf5Z8zJ7BbUGv3ulRFdfEnNmGsMYECbF4i6JY+0FQeL+YennMrpNPqdJ7Wh5VEHx7QYS6aGfwFsZB01d+DrjJ24nHqFgbMGrDB9/XswNHNoAYMI1jGZtNmizz2Zc+JYEb9F0Y/yfe4S0VgoL1hkNVYWTJ0HrCjOQH73eamaEqa3Kr7mqvszn3Lf6Do3vpVkYaQAOHrT8qj6yaLWn3idb0/eHRPk3PZlzKJMCMEGZ3+otkd6WT4hiVKr91GkEMLWfaU9sJZogn1SojOB3vPxsPfVLJBPWE3UroakYvr/0TuF5hmiQqbvnpomt/flM7RBArRDQv0x/wTx/nQwlgPs5x6yEbEEaOycxORDnO6PsIhRux3u48mGjC779RuvvyBKA8/mfHn7inNfrdSwG4Czn9p0tTiA8nX2T6C3HhIUidlx2v1s3MdwIlVLiseiU56sMSCGsB5VY7pdO9iHzyFRpjV9x4A7mviGduSKH7wR+gYb8gGy/ysYGj29/6FomfgnWIltwIP4ERg2FAe8ylA5COgEbHagUd7zJpMJQu23t35S1Lu+kjDf5I0/hybgFLcMC8WVasKCq0T/DeCpN0SAeosfciLRvbqa11c24SnVRVVTp9ZU4BTX7ZfNPu2GAqSwe+xE19l/aWfcHc8IwTfEES3z+jLjCmmgu7l+Xo9d11WtiEeTzg4dj+YXHD7GDw5ZafUQBUww2E/mEP9zjIbI2d0JLbzex0voTz6M+F+Lv+VdjaudkL2fbrljKMjo5AT4RA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/1eKU/ralP1U67o35w6fiIQAISBXqqmVF8CU1MxnhUnOGVcb7kN/GimMQv?=
 =?iso-8859-1?Q?BAPkALEIzKNcdwPLDD7O3g5Gqh66LvvOzpKhjhvmmzUj77UfUys/8QvFnz?=
 =?iso-8859-1?Q?ajGYpvWpwsseNU53u/WjOd9Xkkm5FccKFzzsFBc3rcBzDFGJH8AIWRKbbt?=
 =?iso-8859-1?Q?xP0QBajzODjn+th0hxLXXZoN0IcZ2wVPY2U/VRKaa9sUuxWpIPZUbzqZET?=
 =?iso-8859-1?Q?xhA7WsEyf2e7Eqwe9VIwczoGGSHfCjslDTHsKdnD6ZMjsme5ETmDOJRyJu?=
 =?iso-8859-1?Q?1I34DEGyXyDsvpUh6Vz4zKvCYpo+LdT6girQioqxhb/pplR7OL2iufGhCJ?=
 =?iso-8859-1?Q?0gNCNchL6AT1/o2+LTOffLzCRyhShlMLL248Q7c0B0fXsEWjKiTFb0FK/K?=
 =?iso-8859-1?Q?qlo7Udvsi98gdfRTbu6hPvbEEGOVtF/yqqRldoPZ7PpQDQZgh0qDnSD7su?=
 =?iso-8859-1?Q?7cW/NEIFQlFyRvMmQ/e+28FoZuaF5wzyAunT/PG7EYLba8SrdCYQ5UV6Y3?=
 =?iso-8859-1?Q?OXT4toVRAOrTAnh84f5lviYFrmUPJ1rwzE1S47+nnI74GOeakMwDgR9PyG?=
 =?iso-8859-1?Q?lEDnT2/U4B98I8Qdhzl7jEDA5EuhlPrXN1vK+8d9GP8JuXahCmHwqCdT5o?=
 =?iso-8859-1?Q?lR7tvmzKu4zqv2yltOWmRepBH6qznSbZpILOoAHOKReOpaQ4lQqmCVl4iy?=
 =?iso-8859-1?Q?Itj4rtGQu23VypN1Pg0HBK0mLv/furfyQqRSEf3lK6Rzd+q/IhAHWu6231?=
 =?iso-8859-1?Q?kkx5SBsmLIIDfM4PGkyi6sGASuTJU9/PIWYtBfFZnzzd+Y3ft7UwXFx5SW?=
 =?iso-8859-1?Q?rV/fjY7m52C6RpzbZIo2ZZ8ylzIp7yV63SbDDr94stppmRza1in2figHem?=
 =?iso-8859-1?Q?NodGeKfzluNLnsXfrVPXlcZSxDJRoQSPrOKsOqOh5Qbp6YOZiQMM2AyFOh?=
 =?iso-8859-1?Q?MKtThkQE8JeewyW6pOws4g/Nibzjtso3iD0EHRLt1VXsHxwJ+ls1dRI2Dg?=
 =?iso-8859-1?Q?bcS6avhNB2JQm2ZBmXaCyacYvvlozrPme8yP10hwtRDoP/dscumfh/tdHi?=
 =?iso-8859-1?Q?QVCsbS7OGwEJnmlWwneYh90TG+3E93vUItO73YeeFGKLsjhmDCHF4JSCam?=
 =?iso-8859-1?Q?aQ2cW2mwcXQ+GOMYL1mu2cDnsdBe/r6sp8XqI2zCWRWCE/BC1iHIPZYUHF?=
 =?iso-8859-1?Q?iH38gJQPcYaNq8ZVEoN/jD5vf2P5BZUCHvWSUCFgmJA2TCkaIqJJkutC5y?=
 =?iso-8859-1?Q?T5lnXiXaVxBWVbAk5AWA3HMDSmdNJ4G8f1IWaOjQH9SvM2Kgs0v5wqIir1?=
 =?iso-8859-1?Q?Oxv3y3RDaiPBEQ0tJbCBmRkZwZNVARLhGXsH1XEx/xyxDo3QN1X9jD3YYf?=
 =?iso-8859-1?Q?uGdxGSjVE3TnTTonLpfOeo6qP2vi1pTK/3bpxU6n2eZkH2UzFQU96whdzf?=
 =?iso-8859-1?Q?t9ABjjOw/ONb5TdkFsg53HlCRsMJUEIDAVVzrWjnCKwbJDXgUj2tmiHIEN?=
 =?iso-8859-1?Q?oWCZzFZbKhQCHbkysfgDk/uxz9Agcz/mJvDL8rmPBzg7VSR2Zh7YOyJ6ju?=
 =?iso-8859-1?Q?QlUvEd5miUKXq4OCjrWuJHsxyXhEqucqOM2yO3HwQstDDz6yh0Yz9Gr0sQ?=
 =?iso-8859-1?Q?Q/4JbFnfTBjEKm6F2uiPwBz9QFOVm7zlIg2pPJFOLgAdOPzh8wI6ozAycG?=
 =?iso-8859-1?Q?5vmYFWkvlPfHKNLBZLm2JYGWxe6sDBanpzkueGYQsv028oeF7vbYpOJKKf?=
 =?iso-8859-1?Q?5KxSi8OGNn6BJthaMp/8IkaZeNqeDweTnWwEym/DAz+si7ADRY8q5Ve7VG?=
 =?iso-8859-1?Q?ucqz41p4Lw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AjNyjvSgoAmG12jzZfngi4teh5bkoaVdRWjNfexnw404ShrOCTm+tt89J71I4V1hN9PvG5GSUyRjadEdEX2EIzRntmPHRFN120wCcztjx82Y0RLtgfbaDiwpzqf5vr/CVtJzgb66Lz+DJC02JQBbjuKJ96ynjg+DeJGFNU967lQa0Oo3UGryGivUQrJnkT9op/NxMIo/lMARI9s2D/t9RRmNAHVfx3Nduxr5t+JvzZX7SK/jC+jNy44YEEDMrKVH3c1TzybyM317XV2MVQagwgb6nqQ6H2Uw63W/36XTAmj+BSC9sot3czot1APLzPoQY0Yt+Ss4r8ttkGuhDQNdog==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5db6c5c-84c9-4bfb-057c-08de99fbebc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 08:00:40.4635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gb3kjt7FTwxCVg7dsAc54wIdGQn/bgHnQwHGGIMxrhtfGdUD9YC+I4C5MAplBSx26BZ+JqULZxmUsKpPbsZGqEw7iMRlS+jK4/td0+GV0lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8423
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

EHCI supports 64-bit control data structure addressing when the=0A=
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,=0A=
the CTRLDSSEGMENT register provides the upper 32 bits that are=0A=
concatenated with 32-bit link pointer values to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
siTD link pointers are stored as 32-bit values and must be expanded=0A=
to full 64-bit descriptor addresses when 64-bit mode is enabled.=0A=
Update the siTD traversal path to use ehci_get_desc_addr() when=0A=
following link pointers.=0A=
=0A=
Appendix B also defines high dword fields for siTD buffer pointers.=0A=
Add bufptr_hi[] fields to EHCIsitd and use ehci_get_buf_addr() to=0A=
construct full 64-bit buffer addresses from bufptr[] and bufptr_hi[]=0A=
when processing split isochronous transfers. This allows buffers=0A=
above 4GB to be handled correctly.=0A=
=0A=
When 64-bit capability is disabled, descriptor and buffer addresses=0A=
remain 32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 1 +=0A=
 hw/usb/hcd-ehci.c | 2 +-=0A=
 2 files changed, 2 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index af8c080c60..6406f536e8 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -109,6 +109,7 @@ typedef struct EHCIsitd {=0A=
 #define SITD_BUFPTR_TCNT_MASK         0x00000007=0A=
 =0A=
     uint32_t backptr;                 /* Standard next link pointer */=0A=
+    uint32_t bufptr_hi[2];=0A=
 } EHCIsitd;=0A=
 =0A=
 /*=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 5d61b1dd64..24133af9db 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1791,7 +1791,7 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int =
async)=0A=
         warn_report("Skipping active siTD");=0A=
     }=0A=
 =0A=
-    ehci_set_fetch_addr(ehci, async, sitd.next);=0A=
+    ehci_set_fetch_addr(ehci, async, ehci_get_desc_addr(ehci, sitd.next));=
=0A=
     ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
     return 1;=0A=
 }=0A=
-- =0A=
2.43.0=0A=

