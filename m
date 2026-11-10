Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E772606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=fj6PuP2D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQgHW-0008I0-5T; Tue, 10 Nov 2026 02:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHU-0008Gz-6P; Tue, 10 Nov 2026 02:28:36 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQgHS-0005V4-7N; Tue, 10 Nov 2026 02:28:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqHO/Ih84bvtl6WE1ZkmPGUB21kP2sC3E2zuvO4NZrehPFksztmoIcN3QsTlaDBNcwj0Cjpw7SNVnF2WNjktTtMROr9lDexcgOBxtWW2b5MNNbGypTzWeoEkZXcxm6QMQMHrpPNm4h49ncSMZlX+6t3Me/PTnxLYmQKbnbRK89XbtRyUczbWvYEstOSLMGGLpTdozT1ArbKSROeZrKXxtXSs2mEJpvQMEXI43cY16FDGPpLFwMZiTetS6Jr6dfMsqZCK30BdzDpYNpOsanf1i3gRLIbvcX04LY6Siosi83DMOoM8CAO7zeavHO4JwN71uQowZkMBZi2LXNV5XRyD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj/2vigSzOMTjwZE1Zv1BJTAOAeeqIkRx/rvgehnlEo=;
 b=cFvw7UEVuYGMBSkmLuQmwiicayotrYbz08vFVSYoQdMqsliaAQiMPvD60WjtYgn25y6Liw/3dKL7bmkd1ky63gb5XHPhH6jrDwy5LOrrDWi9he0Z7QT7dFNK44ShFcKzq1F+QrMrC9DYhfSYb9I4BiOTf1HWswGbz4cJwS5qbVhY5JAVcli3uUP1UhhQKPCoSQOlm19HJK/7gnYhca/1mzpxMEQATKFNBtdMcdUSQWejcL0F5KaiivuwqP15efapPtUFg1jvJWGxP5p7fmLGaGa3QzV9wKqDzHB8/wDfgcFe6xJXuDbIS6/Dw32pY4GHcDamqzxbiy9yJvD3inElrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj/2vigSzOMTjwZE1Zv1BJTAOAeeqIkRx/rvgehnlEo=;
 b=fj6PuP2DKI0k4jO5AeqJ//hpRhM4sHiEUbKEbP3Zc4f/b6Rn8pqZwSMDlKS9LXtUcoCiqcV6bo1qE77tJA+XzOXz4dDniabeRXqUz+oXKSAJDcCBTMNQmQuOrXkxmZ9Wc1mXvrR7OLHN69MKUy/CkoI/l8ZmhF3rdOsKW73FBo67vuBqK3tIqRM7vxY2cAO89tIqpRYTBQ+Pb3bj2NNLf+6A2UH5OJbpvqlaQgBpskymNARafDwwNuDoRo2Ey8W2eE5m7RrLtqz5qMyms+pgbwHVKVKQccSr0En0LmQL9QPbm7/vg+gtyy/IxaJ+ptdohnGyEvDy0YTUlim8Y4cCdw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8987.apcprd06.prod.outlook.com (2603:1096:d10:9a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 07:28:24 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 07:28:23 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "berrange@redhat.com" <berrange@redhat.com>, "junjie.cao@linux.dev"
 <junjie.cao@linux.dev>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "clg@kaod.org"
 <clg@kaod.org>, "junjie.cao@intel.com" <junjie.cao@intel.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Tyrone
 Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v9 03/19] hw/usb/hcd-ehci: Add an auto-hub property and leave
 it off
Thread-Topic: [PATCH v9 03/19] hw/usb/hcd-ehci: Add an auto-hub property and
 leave it off
Thread-Index: AQHdcOURQRQvtWCCn0ujjOevmcXOVQ==
Date: Tue, 10 Nov 2026 07:28:23 +0000
Message-ID: <20261110072818.2883349-4-jamin_lin@aspeedtech.com>
References: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110072818.2883349-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8987:EE_
x-ms-office365-filtering-correlation-id: 537d1002-73ff-4155-4153-08df3efc343c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|10067099003|921020|38070700021|56012099006|261102123227099003|261021123027099003|261022113327099003|261021121427099003|261009223027099003|261026121527099003;
x-microsoft-antispam-message-info: iNl8Zqc28n1GQb9l1rtcOUAXLtw5aDU1mRh2mznafm8K+4Lys+hUUliOrQOX+eWqaWhC/cJ9akUZHRoQJSUS4vGs+v8G4Qx5jKlODIqwcq2eWMLmRbwGJdVUm0tSN5pgTiy3j7BhyIIB1jw+RoQIsJOrYRLbXe1vWpEhsZfEYgEL+yFUwQJdjazQBEGKW/286qcOBRIreFAvF4aDvSH1uQQGmNd/uppguhkV/JGolGsfOPZavG7gCgnX2iIunB+JGuPnGQwZ2UzpXa73YJezHnUDMnW2VKVG8CyiY0N3HzlM5zsRAKPuTzvTCAmVKc+TjFxM0b5uO4mycoVVAmSL3SSCPHhU1EIc4ER1RQYhItzKqMi53iibw8rZZeGqssv3oBIoTnYdjy9ChAC64W34GHK9p5zaD6lg7QlnFNaTV+o8uXZ49jmUorsdOOR4A4Qg8UeTWO0wjwK2fVGp1srh+bZM5GuUv7/rUj7pqYdc9EWbbftST5vg06WWuQKzH/IaOBZGSACvPrF07603Xl17JVMY9JKyzOzMpDo8NrxgT6pkH+caUSZq6kfbTw3rvX4jsE2TZCM2yjiKlKfwC0n+5sKkRdVMFYmesZLu2NqvL1/QVvXMRzVzxK8m3tCYz1uzxpCl1muMCgBidfrG/C/tx2/MuRO2za9RayNi7NImU566Xrlxm7pPhSu9q7VKsoQWb48Mcc+tDg/+ry7cEN5KG8FKfPE2XTZEZUmBNx0UJjQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(10067099003)(921020)(38070700021)(56012099006)(261102123227099003)(261021123027099003)(261022113327099003)(261021121427099003)(261009223027099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e8gNlQownkrMDI/eVJjIt5eH7VpGFeYQNbNM6R+28iBhe1Cz3F0tdcZvOF?=
 =?iso-8859-1?Q?M9m/Gkhs60Q2CL3VFXyQphybKiaR2Mnu4Q6K0DYo/Fp/3K/nZLks/Fuxyc?=
 =?iso-8859-1?Q?3jTD6Slqet7bJG8yPqc3MV9u7vIdd9nAyUJtMhc96FzdKfp8E7PwWG2n6b?=
 =?iso-8859-1?Q?clYTKuvXSSCUVXy22hGysV8YzpbgDKL+M9pJXfvlvnwPSIjtwwA6fqAmDx?=
 =?iso-8859-1?Q?EJ8nqbBXLybsgHPbuYzxyhh14fBAWNAnQ3zxY+P3fUqJUXTl73IDmqh7iG?=
 =?iso-8859-1?Q?Jx7MhNrfJJCLdD4XtnrueqiF3ISr/B0iYL6C09wLT/6lhwBkLq+QiO2Ib6?=
 =?iso-8859-1?Q?4vYzFtfa8oAgG8BukORPczazs9vONKxxo0nsFkmY3pZmThG724CfKIHaLD?=
 =?iso-8859-1?Q?1xr/fWz2AkU524GuOy8k9hFJAZ6t7sPZlXJPjcC5uiryk0sNJvscNGCV7b?=
 =?iso-8859-1?Q?lSr2y0Hyzck1mVvaLJWFY67EzmuO5l2igThmfpU6pb4Xw1SWB70OS2nl2o?=
 =?iso-8859-1?Q?2BgPYLGp60V3uKXQr6uW9Xja9qYM5k+I63dwu/H+AvWOWSzhCW2qoIOS9B?=
 =?iso-8859-1?Q?wDwzXdhhUHqq/VQO7ibf8vNSDxWFjsW+6YNiDWsI5LapBVxuzO7N4Yk8Hi?=
 =?iso-8859-1?Q?X5OuU8SoSMn3ke48s6IWSEtt+ba9nKJGPbzj3AVamvZzdcccP2CbQ1Mwd1?=
 =?iso-8859-1?Q?uko3kyIyQbbeJSNXV8GAbJrCstq9Kps+WmWLW9zQfgFRJmFrK0XtcI/7c3?=
 =?iso-8859-1?Q?XWvoB80p6nM4VIaqxfkJVHPzmbqzQtFv7/ji+2bMl9vYs0WffzfC6Fv/3h?=
 =?iso-8859-1?Q?pdee6MsnbeUWwwW23V/p9Ud43DLm9vWFjBu+oOEeUNQR97aj97z+Kz4GIA?=
 =?iso-8859-1?Q?Qkr+ybk12KUrXcq7z7mC5KHI2qVkfUYgA7GL7CbPrpGO9CCBPBLwfNdfYH?=
 =?iso-8859-1?Q?ytyOdLD14GQ2jQp4+ANkgijKo2tePyw5w6D+RNED8x/WPtc6XnNAePysD1?=
 =?iso-8859-1?Q?8v3MCuF9KYY+wBULUdMfUOaakYRi53T/6InnAKGRaL+GxqejULehYqyav5?=
 =?iso-8859-1?Q?nwWQB2w1Uw4YVlra7dMxi/Bo4k0HSB2eBHnI4TEEGLbyxHP6QDyKTWm4rh?=
 =?iso-8859-1?Q?+6gFAqeMMtBSoiRi9q+/D2b5qhkPBy2rHrCfzwNZfT3SXwe8Z704FieCco?=
 =?iso-8859-1?Q?iT1On/D9SL+THigCUnZDGpD30DLaa3uem3sOIyyuLI/Hn8g2sMhKT7yfkh?=
 =?iso-8859-1?Q?ML4lcta5FMqy7ZwpUd245FzQW6uw2lJFY9aSsx3eTs2/RQqPnxo6PZHABK?=
 =?iso-8859-1?Q?rxESZQwyuM64M90sY2otTmsEpcOf2me/euHkCh45guCX+4ms8/ozEog3gK?=
 =?iso-8859-1?Q?w1LM0LCfTG6kpCfYB/wMrEUd5fi+XTRnsFd8HRWeaboKfZLVlK1eX879Pr?=
 =?iso-8859-1?Q?AB1VUHn8Fy9gdtdh3YFfCRKqqT8uY5c85VJXV01AgGaoDgAkWnCmLkZPRf?=
 =?iso-8859-1?Q?LIjRGZVHQ9IOKPBft79Op9ClZSYKBGN5I2Epdcq53983R8SlaJflX7GSDY?=
 =?iso-8859-1?Q?2tKw3Qwir5gpWA+WlU6thfERdPh3P1sUuysisKHfuGsQ3yaknonSNrsPhZ?=
 =?iso-8859-1?Q?Mb8ffiFJp+laZmSCeZ9H1Jm6aDYDbRzy6zfDCBY3wChPaIHwPff7Dl/EkR?=
 =?iso-8859-1?Q?/iLAYTBvbPgyDM2L2rpMzf1fWc76+WjcOK7uVmmiQPJhYFBwBodWed2wbj?=
 =?iso-8859-1?Q?Z1gm/LDWXjSDJyZb6IP5T1Mq4cJQgOkhiDy1hZ3rNjMIyZfpdP/MU3z36F?=
 =?iso-8859-1?Q?cgKfLVjJmQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rJx/DWYbM+uBcZ1ks+wKqGKytmCV4A+EY18+iA5ZeuCRJspnatnoFRKGdvpwIIYmdnY4W5mtwURZR9sNTC4cxDzaBoi11N6OkN/o0YXccsyvNsFtW7kRR4xxtB1oJ1WkqLKNW7fzYS7FchZ36qLUbMQkTgjLe73V0m/7Hc6S9KauZ0nmX1tU5Wu3hACSLT1Qecqz77Yrgf9izA96cXrJMMSUU9ymGHvFKe7ju6ntDdKCVSgCaTJfvb8EJnCwChn73NstQD5W/UjTQi3ahkXr+R94DQv7Ilp9GZWJtyNYBZQXnSps/CZGjF+KnK5Ctd5oRCjYOrktk0vCfh4jr99iXw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537d1002-73ff-4155-4153-08df3efc343c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 07:28:23.8500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfRldrvsJdVlJ/tMIQHwx0y7fN0SapambmhpAh8FoYNO2DeRvc71SHDMkCCR5W78IpmuKilgjqHQckhU29RrJIDbAgjtkX6rxc/QhG5b5Kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8987
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add auto-hub and leave it off. hw_compat_11_1 turns it on, so an older=0A=
machine type keeps the hub it has today and a guest saved by an older=0A=
QEMU still loads.=0A=
=0A=
TODO: Move the entries to hw_compat_11_2 before merge. The series=0A=
goes into 12.0, so 11.2 is an old machine type too. hw_compat_11_2=0A=
does not exist yet.=0A=
=0A=
Suggested-by: Gerd Hoffmann <kraxel@redhat.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 4 +++-=0A=
 hw/core/machine.c | 2 ++=0A=
 hw/usb/hcd-ehci.c | 1 +=0A=
 3 files changed, 6 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index b5ac9c8670..db9db537ff 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -269,6 +269,7 @@ struct EHCIState {=0A=
     bool migrate_fetch_addr_64bit;=0A=
     bool caps_64bit_addr;=0A=
     uint32_t ctrldssegment_default;=0A=
+    bool auto_hub;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
@@ -336,7 +337,8 @@ struct EHCIState {=0A=
     DEFINE_PROP_BOOL("caps-64bit-addr", _state, \=0A=
                      ehci.caps_64bit_addr, false), \=0A=
     DEFINE_PROP_UINT32("ctrldssegment-default", _state, \=0A=
-                       ehci.ctrldssegment_default, 0)=0A=
+                       ehci.ctrldssegment_default, 0), \=0A=
+    DEFINE_PROP_BOOL("auto-hub", _state, ehci.auto_hub, false)=0A=
 =0A=
 extern const VMStateDescription vmstate_ehci;=0A=
 =0A=
diff --git a/hw/core/machine.c b/hw/core/machine.c=0A=
index f8f5b01117..0103038cad 100644=0A=
--- a/hw/core/machine.c=0A=
+++ b/hw/core/machine.c=0A=
@@ -43,6 +43,8 @@=0A=
 GlobalProperty hw_compat_11_1[] =3D {=0A=
     { "sysbus-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
     { "pci-ehci-usb", "x-migrate-fetch-addr-64bit", "off" },=0A=
+    { "sysbus-ehci-usb", "auto-hub", "on" },=0A=
+    { "pci-ehci-usb", "auto-hub", "on" },=0A=
     { "base-xhci", "auto-hub", "on" },=0A=
 };=0A=
 const size_t hw_compat_11_1_len =3D G_N_ELEMENTS(hw_compat_11_1);=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index f371e567f3..29b85869c3 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -2636,6 +2636,7 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev,=
 Error **errp)=0A=
 =0A=
     usb_bus_new(&s->bus, sizeof(s->bus), s->companion_enable ?=0A=
                 &ehci_bus_ops_companion : &ehci_bus_ops_standalone, dev);=
=0A=
+    s->bus.auto_hub =3D s->auto_hub;=0A=
     for (i =3D 0; i < s->portnr; i++) {=0A=
         usb_register_port(&s->bus, &s->ports[i], s, i, &ehci_port_ops,=0A=
                           USB_SPEED_MASK_HIGH);=0A=
-- =0A=
2.43.0=0A=

