Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF6CEB364A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEdm-0003UX-N2; Mon, 02 Mar 2026 20:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxEdk-0003Tw-9W
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:33:36 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vxEdi-0002EW-Dw
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:33:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGshY6+ACzloDp76dKdWC3W/6nAcpKHjAHdu2oJcuYI7YLBoO4FF7KhHnGtaEq+dRVDNTc6+Mpt/dbp4dz1kFSdnrr4QxxhcuJPHcc4+QrSUKjI8VWN19P9g+nBrR680eCVymbPrEd5oo5gL6usmmRJRi6bWt6dHg1taQMAjI7FyORSN1gG9BV50/ACelj5fp9IUE7aFlgtJkeGlOSipzYFBrsILyD2WrfrfrLR1jQLonVVIMDbLCXUcZH5SbFLOJbZddN9Oed+fL739TvaknqAtX6HNzUggwHk2GkTaG4jQrQbKQdAnmxL8pMaXNE8K5vGGdavz5BOpg1NZsdDUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Kntvg/V3aHOZQpayZFnF3ouGujiRPvjviQLqXow8U8=;
 b=nJtSsE2Xov2qPbAqKGPiXeQ4DKrTePgP/cbm45mpAbAXISsm5hlWaTAAblUZCfYyOkqw8FA8kfPaIwvIRdQNQtAZthAhhvC++Q1QKies+vmuQq3wJ8/QxGQgVNb7CbraXDUuCfjcEBGTM2WbUBNQBEPSRUSEoCKRU1PChTwSdJmJNghCKeswEXpB7iFcQsl+5VIS15nvrkPOjI9vnIXHKg4pIy540ENxJWvxaoCWiRDfbjpfSd1d5X5ZevXmW1leNJA+peYvuI4k2uJOh+gv3Z+WkQ8ralteeg/Hw0b1EEfQYm3D+o2/8d/7LzigQuThd8qc+lu8sRYWxDb0tIs9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Kntvg/V3aHOZQpayZFnF3ouGujiRPvjviQLqXow8U8=;
 b=D8Xn3shCxJ5BYyBkGqiKLLv0Z3SaNN06OmSJrpFiGyWtIT1YZkUtCH/zDrUmg/+DFdLhePwYi1XmS4rPGsImIJMaVvHjil2wk/lpAVfvQLI7rShST61oyHuO008GQwofVVALZCkZpGTs/sMJld/o4Zll+NJba3SRPpD7qK8Pl+Cv+OZcI4795j+wTz7o1ZHoCIyJnp66lk82klPFiDrUOf3CP91GZG2ee20AJac9RteAZ1GhAbeoSR9s9WmL+W/bMXIPhg8hUrfo1aQed/ttofzGGuymazx+oSHi8mw0CRciVrehziTI+tHWpvoFnsZyRXdPonbHqJ3VjkExSgB59w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSQPR06MB7973.apcprd06.prod.outlook.com (2603:1096:604:429::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 01:33:26 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 01:33:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "jithu.joseph@oss.qualcomm.com"
 <jithu.joseph@oss.qualcomm.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v2 2/4] hw/i3c/mock-i3c-target: Set num_sent in TX callback to
 fix trace reporting
Thread-Topic: [PATCH v2 2/4] hw/i3c/mock-i3c-target: Set num_sent in TX
 callback to fix trace reporting
Thread-Index: AQHcqq27BCjm/UPI70axFquwN3Bi2g==
Date: Tue, 3 Mar 2026 01:33:26 +0000
Message-ID: <20260303013322.1297499-3-jamin_lin@aspeedtech.com>
References: <20260303013322.1297499-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260303013322.1297499-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSQPR06MB7973:EE_
x-ms-office365-filtering-correlation-id: 81798e13-34eb-4b4b-379e-08de78c4de13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 04cseiBU6ouc2AF3qgmGY3nNreq81OxgNmTYQ+t16JM6lPCSwmkHUSLIRkh1fH5XsS1iOwrbwULVLhFDdK+j/ol3z0TvokjtVYSKNmkohCa8Dz/bK0QG/qtgGyc9JWiCHUXdwLyV7f11k86n2mxDbqrTijx7+Zma650GC4TTOHI8rieu8DVUOpUZYcWnd7sa9wmDXJBnjH6EuYmZ5sxRSvhomrTM0gDWKi6cj1dhnx6fptNqu2YkPL/8n1W53O6VROxaYj/jGaq4F4AlqBWLZHjHsoDJYub+a5xIcmp/SZGbC2SCzcslyB3tuXJZ0jrpmtV2Loxy1i547kHkct6soxeAijkcB9khJTNSZ8lfoMQXqaXHfovYuaYaeHD+BeDVVymxCjQdWSZZr6k87u0JEuszwVzmO3jd2QZDAoUakdlMEAPrWiTYPj97RKjkQvWotWTsmMfsEocljtwDLozl/9C6yNcmLpBSXFd96Fxbse8wcUy3OgCuK/K+iqsUU9qD0iJeoe2wZE1bx2YaoUTh7TA2tUhOFW7BFsIpsBcOb/VEZaLBanTPqt+WagUGbrkcxyflo9A6wYxnQ2+guXJGYhUMElxWiGW5XrBirZhzse0mLFc9BtQwI9T/jszTNIfQO8fwYLOVA5priEmlR7oPgygrIhbOi+YkwP5cN5PiI91RSbsBn2WXXBaD7uYwgWUr/EpmLcoZ5EGsXDzK7Y5idmr8hZgfbgbHM6v7xf/CpLqkv1N/vNrTGh/r3i2/vnfqc8D1cJ0fW9WbWJnTCgMfkzXHQxxj3AvZIe+QdAEy2uU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Skxe/QAmWjPCVLaLe9n/G0eFUol02z0PeWguSHAJBX5+jnEzksgRvnYGAsyL?=
 =?us-ascii?Q?2+3h1GzhV6/FEgLKz0IDwz+wbOHFRaNAb6SuW5ZJSwBioQaOv1n1FqHQWMnD?=
 =?us-ascii?Q?5GJrZPrHhOuzsCOKSUhoBalcguC3pS9essqIBoX7lvstEvy4zWGxuOCifvCb?=
 =?us-ascii?Q?cwn0YGAWyZ9SjgBVHaSoY8uMqIbZgPcw67emQsW9/eW4TmmQEVuzg9tXsQdm?=
 =?us-ascii?Q?dgErTsasQJXFMlAcd+lWShcG0B1Uo97XIXm7EHGbfDBxhfgP+GSJNQYdVdYN?=
 =?us-ascii?Q?0P97fjyieiGHEE54dOiR9fr6y+gjhP+mBk4OHUQ9DVSyMzaGA2Hn21ylVXGs?=
 =?us-ascii?Q?rPyAqd3JOYXH6maO6Oj5pwlH+ggpScngtAnXhomj9KCv1ONh9HUyv1Tt9MsU?=
 =?us-ascii?Q?oOmoSuTC2Jptr3cJtx1k8HVuYNmfGfsNeWeRagzZX0to0INLudGu54yIzmo2?=
 =?us-ascii?Q?viYmUEijE6VbLmtiWN6KAdADTbFccx/1mI3MNxlmwWIuOjwLLa2q9bOFNLu7?=
 =?us-ascii?Q?pIyPnoshf39iVuZmC+lg+ATeiD2zRsveDtrsvqK41eeSTClxUw8cZjOLhndM?=
 =?us-ascii?Q?cun6sInWAlGyoMVRvmJmQX9O51T9biy/yfUdyfHIMkgEc2gdePJsl7dwDZYa?=
 =?us-ascii?Q?Ql/J7I2mo7eMvp6f/3zbMbzMdG/JVvEEWL/hqrwwFGat1u18zVhIxrzgr9wq?=
 =?us-ascii?Q?JnR+G8er5/qsTWbnIWRl5kiEIKwQq7vC90GiNOlujb3fA7nuwMFLjZF7zAbi?=
 =?us-ascii?Q?wC++4JLusteVBoDrOtjZ37jew6Bs98cZPUnYxo6SPvIGsIJ1dHOK0I2FyROb?=
 =?us-ascii?Q?t+rBqnXckFoOdtBWZLlescXAE0o2jlMDbDcvKqPUusPKf76ywN9z+19ynmYZ?=
 =?us-ascii?Q?PurSpG8zGAXpfjxZZoX00XVYlotfA1NMa+Qw+N+p6w+8DqrKbHebCvs7L38Q?=
 =?us-ascii?Q?g/CuMtHiydomlRa+zZ+QjxfXizgHeYsId0WCKGN0XydPwfMKwlHHqpPtMmIp?=
 =?us-ascii?Q?DF9osGbee6FLLUl8aBSt57bQ5vMz9n2VKcQtXlFcW+tjwpN0oFL7lyQ29TAV?=
 =?us-ascii?Q?/ZVXFvigb137Koy7n4wrMcLMCPoWpO4ooXgnrxwJa19U1/ga3T+GGzrui+yt?=
 =?us-ascii?Q?E3XVuIEekkYa+Oya2jKhBKktXDSXccyUNihnORFD+0dcsyNc/wH6Wt75jYWT?=
 =?us-ascii?Q?mvy7lFW15A7U+wepkH73m94dmXQtrh0CO6bgsue5cf5Rxn50Cqk1Pe6PkkgC?=
 =?us-ascii?Q?/cfBK9HdWkIaP79X0IagF8lA+Ik2c+5U0A8TRNnTCfrcRhECfqwGKRl8Pn9L?=
 =?us-ascii?Q?8lVxfMj6RM/6tSPzxqsGfztla0b0fgbERVqw8Pc7lH2qxKB7QqF7QIEWG3bX?=
 =?us-ascii?Q?1IHi7x5Tb/QS7AmpRcTOgp1bETsKI35AwLqLzrHlbF4Y4AXfQ24hwxim42nX?=
 =?us-ascii?Q?bRM+Op0Bt4Acp4oNllurC4Ha22Q7tuMvc6J/1vjbUSphm6xSKShZu1zwzff1?=
 =?us-ascii?Q?pKxZKWCzXC9Z7jdqW2OSwEUC5fwsL8Tx9c1dEpRJeXFLbfkkfYdQ1uPCtm50?=
 =?us-ascii?Q?ysSRmTCmWqSFn/HxxSKPhtG7hTK6E4nsJiQxXiPSqeFlWNrdOqXc0hKj6Uuh?=
 =?us-ascii?Q?JF9lAUxyyWStEdYKeul9hZ2Bt6D+Bn4Om7uk1IfwjUvnITs9VnDlSykaYtcq?=
 =?us-ascii?Q?SzxMHRRKDsIjIBWTj0QCJ/JrYiElH1g8eCwiA5W5jZ5GHHKZw/NBjvpA4QM4?=
 =?us-ascii?Q?8HE/8Eu3uQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81798e13-34eb-4b4b-379e-08de78c4de13
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 01:33:26.7595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J1cexOQxly8lk9cuWav07C+jnFprYj2UVqRhpcEO4ihDwbhsgQ7FwlkubGjeupyLCslSZpQaaEgSdVi+oaNG4qjp/tioPQd7xXWh4vUnDxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7973
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

mock_i3c_target_tx() did not update *num_sent before returning.=0A=
=0A=
Although some callers may not directly use this value, i3c_send()=0A=
passes num_sent to trace_i3c_send(). If the target TX callback does=0A=
not initialize *num_sent, the trace output may report an incorrect=0A=
or uninitialized value, leading to confusing debugging information.=0A=
=0A=
For example, the following trace was observed:=0A=
=0A=
  mock_i3c_target_tx I3C mock target write 0x12=0A=
  i3c_send I3C send 0/1 bytes, ack=3D1    (expected 1/1 bytes)=0A=
=0A=
This happens because *num_sent was never set by the TX callback.=0A=
=0A=
Fix this by setting *num_sent in all return paths,=0A=
including the IBI magic handling case, to accurately reflect=0A=
the number of bytes consumed.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/mock-i3c-target.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/mock-i3c-target.c b/hw/i3c/mock-i3c-target.c=0A=
index 875cd7c7d0..b99709a08b 100644=0A=
--- a/hw/i3c/mock-i3c-target.c=0A=
+++ b/hw/i3c/mock-i3c-target.c=0A=
@@ -70,6 +70,7 @@ static int mock_i3c_target_tx(I3CTarget *i3c, const uint8=
_t *data,=0A=
 =0A=
     if (s->cfg.ibi_magic && num_to_send =3D=3D 1 && s->cfg.ibi_magic =3D=
=3D *data) {=0A=
         mock_i3c_target_ibi_timer_start(s);=0A=
+        *num_sent =3D 1;=0A=
         return 0;=0A=
     }=0A=
 =0A=
@@ -86,6 +87,7 @@ static int mock_i3c_target_tx(I3CTarget *i3c, const uint8=
_t *data,=0A=
         s->buf[s->p_buf] =3D data[i];=0A=
         s->p_buf++;=0A=
     }=0A=
+    *num_sent =3D to_write;=0A=
     return ret;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

