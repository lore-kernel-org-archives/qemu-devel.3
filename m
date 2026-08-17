Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9498BC5CFC1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvqHx-0004X6-KR; Mon, 17 Aug 2026 01:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvqHw-0004Wx-41
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 01:53:36 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvqHu-0004hN-KQ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 01:53:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPRBh4gdogrVIxXCUm1Ri542473ZO77hKWM0xtKzcLl6VdtkofxEeRDascKzCQy/iRIVTEHdiTtSZaDnY5+JFQtGLLLJtZbi8kRdL8tmkv/BIIW1FLDDeahxddeLRMc09p+jmzAuPFLCbyw9okWwTrJGU+t1ZeXxFI1IVVZfO87dWj1/cnOBSvaj2BsDHj37B75ISuM+Ap9FozTeLNw2dhiKgdQeZJfgyLE1ruCfDUTs1A+G9s4mWpCMM9zUVlcCO6IBJLoEWHUvDKNRDXXmdVJjmpJX2p4eTL0NZ2cjC6sPH1plUllWYyatHSTXEZ+7xqvrgLVQB/8DGkDQMCB+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IixTtTuFJ+H5+YkNDoahBQ5GeFJerO7SWIVvMW8jrg8=;
 b=Pf8mDVMBgTF/7quJC5B1v7YsH2TFnyG5W1ZOE2AigiIt+FGPTERUrwekZQhitxGd3DuBY1y5DKH3dzgm22SNZXIay+sKE9GphO9I8h3771S3FqyfpXvVXaKuu80Oc9YzE0WOFnIALy7UYRvaNMZ8dg5WwGgapuFYLh4xaCHgt6JklOIHVZfzs4mHG9PR6vYdcq/fM2/ODKaTVANSJqYGh8BWB8uc4T92wqQC3+IjKaArWtpDRXswo9rT4LYWZVRxIZvcbBqMnJbSJ4JckYLQ6to/mBMBO4RQcnHMO5ZxM45lVTCzkCdRjKmKNhwWQA2yI1T6uq9vMxUTYZjfeaj2pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IixTtTuFJ+H5+YkNDoahBQ5GeFJerO7SWIVvMW8jrg8=;
 b=gWBIT/lTq3ZuM0TvjDYwnfs4aA+ca5LCmbC21gERhi9mKEABxbVY8p3rr21LvVr1MVli6Zv7azg5SDXE55+dih4338gyTiA4RxaFH/kDxyKg3TigDODAIqRmHRZo7pYNzu5SfVKOyA3PvBkk/4d7Uprk0x2t/ZGmt+ZsMW/kvd3PgjdYHioX9YFwrQ7kuelFgg0c7pWZIs6UtRUsqGr99ZSGHR69euplFhkEtgx3f6lrlHZBxui2sKa2Mvrgvzixci9TLdJ0dYQQJy/R5PHVcqtSe/vzj0v9zO3oYXL9LfrbtHeWWfKVNcJj3UJQjKcqlovqRNlr3A0GsD07XpaNhw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYNPR06MB8880.apcprd06.prod.outlook.com (2603:1096:405:3c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 05:53:23 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 05:53:23 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>, "clg@kaod.org" <clg@kaod.org>, "clg@redhat.com"
 <clg@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@mailo.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 3/3] hw/usb/hcd-ehci: Handle get_dwords() failures in async
 writeback
Thread-Topic: [PATCH v3 3/3] hw/usb/hcd-ehci: Handle get_dwords() failures in
 async writeback
Thread-Index: AQHdLgy3ggyolHsi+ke7Ezp2a5QZpg==
Date: Mon, 17 Aug 2026 05:53:23 +0000
Message-ID: <20260817055318.3826428-4-jamin_lin@aspeedtech.com>
References: <20260817055318.3826428-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260817055318.3826428-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYNPR06MB8880:EE_
x-ms-office365-filtering-correlation-id: 11126d72-9f4d-4078-8b5f-08defc23d97d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: pWSn499r3P5kFlcjy13HnYl/tr8V/EhaI+ABWQ6kC6C/p/K33EidqgiMRpvgogUa9JIABsNR2dtSM0QRo1LM3xweRavdVFcaNMpN80iYRCwFaxRI7Pfm2Vekthmms3eyvEi1yY0F/zYgsg7yddcRuBq0iyje8zW520rEWI3b19Phd+3rYbo/Nzq0zYKh4uVDR+Mc6CuXSyASkKXJfMldyN/OzgkQdhI2oAWbTqJ+j+fCM1QzUowqkAWEUFmCQ9ou5G2KcRZUlvmVkT0oDLJ8ljrZOiAjclpo2olHXV8CncZkaHfjWx5lIYDLj8NA6BZD2Pb9PTkWrwO2ESEFVZTfZc7yhVZPAL0AV1DVQGMjzZkHiMUFzSAjFG3T3RVvNcUwg6JoXTIVV+8b31P2U1Q7cvb4CcbMOq4O0T3BZuep1iW2ymUr9Ess+AFx+CrjvW5yXjsp6qJ6sZzLcNYdPip4F5ZW+g13pUld70YXgnykq6oC6h5/bpzsBUwM9d6xXh5EQJR75RgwIgDKOXI9aFP5A5xiFbnF4NlkIFrSRvkI1/wMLETJV6+p7eY8IhVFo0RA/1qDitTMG02QFqy31uWbANNZKOfw9kiRYc1E86xfXxv2DYUO1mIBf5PfymyjPhnSRuCfS9XvjS+Df+LWpY3tIHg5MkxNBVTUwEl6YP0cyReHBt2JfvRgyTIPu496EWto3dXNqJusKAemR8JVKb6ejD2l+f1/AFqLgP1uXb0A1o0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(38070700021)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mimmo3nAX37qbOuBEtJNtkWHC1CKmzGw8ptYrndq+dntVUnc4w+489S7zn?=
 =?iso-8859-1?Q?HeOkAdRirpxdayOGnjFGlq3GI8rP6ZX+oPgJ6tX8xAl59QkbZFlw3ZpALE?=
 =?iso-8859-1?Q?arc16I3+JF+XJwFPjL8sAXbvrSpv4ATq8UwSNR+Kl9Vvq/Piq/aUwkEeuZ?=
 =?iso-8859-1?Q?443VZCJbsPshYUHeDXxM3YkaOX8eFrxb698IuATrQL7PXL1oHZYhn3kqvW?=
 =?iso-8859-1?Q?/teMHZYvjN41v9M3u79ivscReuW671EAUa8SiCXvjt9Kgt4iNHy+jyTn3G?=
 =?iso-8859-1?Q?DNVsiPrmAuv9daVO/vjeeVACQlkaRcDaG3zBDYPbbQ9d600f/0ZEHOTeuF?=
 =?iso-8859-1?Q?8f4hw0v7nLp4nJtmL4MClecfvV2V8lzn7iT7nsiWqE/e1NKkQPhNDRKexd?=
 =?iso-8859-1?Q?ivSzvw43zLw3Vz0mpzWH1h4rc20iGfo94RXks/bLSS7IGpW5A3M4q0qYYp?=
 =?iso-8859-1?Q?4WgFW93k5sH48fepxGQvVlQeljhjBPWmrrPQCL8AY4UBFyZX+A8LqELr8n?=
 =?iso-8859-1?Q?7VD4yOvfnCr05lGjbdA0tN/4r6HpJMfXz5yIJFhYo3WOIk7tbFb0c9WBuu?=
 =?iso-8859-1?Q?5tZDRJ1m8BhowsxWUZBWcXg/fTUQSNZSsUtt+kTaTVtPkpqZ8EjFXUMgsI?=
 =?iso-8859-1?Q?jDB9eoonJ9oWBui00ztYO9ut0fFR+NICoW0RXDTVNBdNyLrbkjqvbpll9i?=
 =?iso-8859-1?Q?GDh5UXSAOjlMqCVvFCOu3ZAKn2fUC6RtmX5BN34P6MvCEWFnxacZx6WGq8?=
 =?iso-8859-1?Q?UfWqLvX1wxRwTzeAStUdmsCxCP4nN2YS9M7kPLpwBPOhPvgHrPDYX44dsF?=
 =?iso-8859-1?Q?DeDwatMFJ71tqmEO5NrpCdROwfBBW6Zstx0+OV6MDW0icZ1SxQ9KLJ4S/W?=
 =?iso-8859-1?Q?Qx0BDQURnI9EkxyLXz9qIxd3B2PhYj7DAlu6NdmNdvnn2Fy/Rl5srgraFB?=
 =?iso-8859-1?Q?a8iFoCSKjs/8jBjQYnIbZCLFbpHI1ROF85txn4H8trPjegnB2JTfe12lAv?=
 =?iso-8859-1?Q?IR7G471bpJlU2vcJZuuYe0lU6i6axjIjputUiT69XAalQLTZkXqYH/egVp?=
 =?iso-8859-1?Q?cp5fA0nYv8xkm0nESF6OxYKV08y6CQHkbSBJKqn3aKEuBvHTXcXoKpR+c2?=
 =?iso-8859-1?Q?l4TzbkEb33I3V/hYzqiGU15ouxlaUIRXwWB/cNiLEMPQL7crdgsPw5G2r+?=
 =?iso-8859-1?Q?inVyHU9Wc9GUbwjL0TawHgHlduN/OaSfMqxYzqQ37Emj72tUSsZ8HWRzQt?=
 =?iso-8859-1?Q?wSk5OXIZ7Kz+XR/hGP/dF/miQ2aI9gX6t970Oq+Z+ghjAXwkZMFfrsFrUo?=
 =?iso-8859-1?Q?/Yf29b0OjLOVDuZ6a5M9MLpWO+uZw8e7mzcRWX1/ZTsR3hNY8RoUGIA8qw?=
 =?iso-8859-1?Q?voz3lbZlp3T4I+AlbxWY/grv6j/4MOn5kQWUW9M2+Rxfi4VTlF5PMZp6TQ?=
 =?iso-8859-1?Q?QnXMTP/izhyOfHldva7NS4l3cL0kZsQlBEfV97rh7gdoECoAdTepcMlD16?=
 =?iso-8859-1?Q?RHkUGWMWLk/r0l5eLRPZKERHTJznsFRpm0jYSdCiW9SoWttxx06Jw97TLA?=
 =?iso-8859-1?Q?T6OUFkLQu6gtXotHOJAMIl7Su2bDDe18H2xIbU77UfagqIDF/av+7FJTl+?=
 =?iso-8859-1?Q?r63L1hNYzGCefSYwdtXwRm1A0/0/GmVI7hrM+IzTsK2YbRRN/Snuwexf1g?=
 =?iso-8859-1?Q?g2Y1QL8ijxLwuovmV/M8vr95VNmWsDXKMvdDGzugn2qk2tyhJqxToBbXJB?=
 =?iso-8859-1?Q?KJGU1A2LECY7og69kcxi5X5gXGv4g8b973l4kkU3puEnoq+h0bfhBHzjnG?=
 =?iso-8859-1?Q?kloxFWIHaA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11126d72-9f4d-4078-8b5f-08defc23d97d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 05:53:23.5934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixSRJtIGtV1+qcADz1lpDCUZhR8sDOfVI5dtACVzSan7o2Gk45atvNqSQz6XIFgB4pq9vdQeD8olwUET1d/9jxKZOlBZ5Ey5Rm3vfZ5m5g8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8880
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

Coverity reports that ehci_writeback_async_complete_packet() ignores=0A=
the return value of get_dwords() when reading the QH and qTD.=0A=
=0A=
Handle read failures in the same way as QH and qTD verification=0A=
failures by freeing the packet and returning early.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Resolves: Coverity CID 1685236=0A=
Fixes: 2b3de6ada5d ("ehci: writeback_async_complete_packet: verify qh and q=
td")=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 10 +++++-----=0A=
 1 file changed, 5 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 5187ecc7e4..f371e567f3 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -527,11 +527,11 @@ static void ehci_writeback_async_complete_packet(EHCI=
Packet *p)=0A=
     /* Verify the qh + qtd, like we do when going through fetchqh & fetchq=
td */=0A=
     memset(&qh, 0, sizeof(qh));=0A=
     memset(&qtd, 0, sizeof(qtd));=0A=
-    get_dwords(q->ehci, NLPTR_GET(q->qhaddr),=0A=
-               (uint32_t *) &qh, ehci_qh_dwords(q->ehci));=0A=
-    get_dwords(q->ehci, NLPTR_GET(q->qtdaddr),=0A=
-               (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci));=0A=
-    if (!ehci_verify_qh(q, &qh) || !ehci_verify_qtd(p, &qtd)) {=0A=
+    if (!get_dwords(q->ehci, NLPTR_GET(q->qhaddr),=0A=
+                    (uint32_t *) &qh, ehci_qh_dwords(q->ehci)) ||=0A=
+        !get_dwords(q->ehci, NLPTR_GET(q->qtdaddr),=0A=
+                    (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci)) ||=0A=
+        !ehci_verify_qh(q, &qh) || !ehci_verify_qtd(p, &qtd)) {=0A=
         p->async =3D EHCI_ASYNC_INITIALIZED;=0A=
         ehci_free_packet(p);=0A=
         return;=0A=
-- =0A=
2.53.0=0A=

