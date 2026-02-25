Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4661AF5543A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4Ns-0003Dl-Np; Tue, 24 Feb 2026 21:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4Nr-0003Ar-8f; Tue, 24 Feb 2026 21:12:15 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4Np-0008Tw-PL; Tue, 24 Feb 2026 21:12:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kww6/V3bRwZpZ8esPDApOy2yXFNhI1Op9ks0Ai+MpxOHoVSmNMXhTTSSu2L6mEp+Fsx3LBSlN2163IRixQPmJ+yGC3Bad0/fm+0UF3ylBJ/6IU/ruuPOWzVSonn3qaSEVKK60teYGsgIlhjIyJMgtVCzSQKRNZKWm++evv3E1dIKqhy4dgsGKWSGsdY0hOfStNU/fJip/pj3gK8uNdNi65oapUfSWN7R0x4+gj4QBWbzSStlPunFKfE5jtSpZvuXBE8NU6nRI4Uu1SpVxXWVmGTHaiEYB+tCS1iAafX6+8om4wrL2qKy4YeqFPUg6cZc8UI+EPMA9vM5vgY4XFPVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3gYQnBAq34sWYxliQDOyox+onivinbcmbdCmRpnGio=;
 b=bRf1d7OqDKZokNkCki8Js+nUDrkGEpwxGqPCwhLDD638eJMgHivBbw0EdaTyakODTf52YJxADeKBFJH8/4ChdrJwbuC9J71HB823RT4aM+Q1fLfGa3qqEOULDq2uq66N+dBu2WE2tKg+QgNDay1Spl55imh+xTT6xfJF+WyIpWS285VRq6pTYpA26Cy4SPmH29hnvYcW1wlmgRTGzMCVmWMCBpdAQzEVKCMscmaYTKhagTXnirr5cwL0rMo2G4zZCy5oy9R7lmJRslYukV6oRj2fLcuEU/BddOHsfI3EvJWkeTrqMj0khKTcUIqpyLhCKikzrRjHAOEabpPGXegM2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3gYQnBAq34sWYxliQDOyox+onivinbcmbdCmRpnGio=;
 b=RJpVO+xEpaHj2g8+Ku3EdKi1Jmdx5fQK55PSp5ZwPlyvWJX1fXaiOkGZOBISK3iWZAvfa1oOssvqsm4yzCtTLeDG4/Xcnwb9iBawzwuprp8Uri64X47YQla8uk381hD1mfwMTOSQ4PeniUndtaKj/Xu5uNqc+Op2iU+4BT0prrrmXVBdbNPZJKzx0lyl0p4OKlb9BMjyTzYMAqPyUkq0ard9SABDXUaxw9hkWH2YBC/cWigBpH6U81QIF1XtiL+7pe02O4BADf0uxE8tXSYeo0deqU75nZYYr77b02DbU0ZXNoeKh/Nn55cx/gcFwlOrTRhpI3QbSpooJK03ePRGCw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6012.apcprd06.prod.outlook.com (2603:1096:101:de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:12:02 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:02 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>
Subject: [PATCH v7 02/22] hw/i3c/aspeed_i3c: Switch to DEFINE_TYPES() and
 align parent_obj naming
Thread-Topic: [PATCH v7 02/22] hw/i3c/aspeed_i3c: Switch to DEFINE_TYPES() and
 align parent_obj naming
Thread-Index: AQHcpfwhnmVwFgK2VUCptvaWcRQSHg==
Date: Wed, 25 Feb 2026 02:12:02 +0000
Message-ID: <20260225021158.1586584-3-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6012:EE_
x-ms-office365-filtering-correlation-id: be7d2832-d84b-4436-7816-08de74134417
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/kRN9qX9o7YqMfmn61AmMcmIG4YPbip9dN5ucRsoxFmcotcik+d06BsCl9?=
 =?iso-8859-1?Q?C2jOltsyu0yRAhF5vydS5RVdK1LyrdY9azCBWNZwA2EVicMHhrtVZ8u80n?=
 =?iso-8859-1?Q?U0/ylgvXU9Iv8fjRhjP6SBBrivZJ/VfFmVavw/N39CRaJBW3vbWIYpTViM?=
 =?iso-8859-1?Q?dtW4C8+LdTC3vTM071rUFP8x+T5ApLlDuwWDa5m7U31xB8nuzTG4yaBgf5?=
 =?iso-8859-1?Q?W+WEB6UyH3d/PS1NYEIYj3s+spGxcW9csXYKul6wN2u8S+8Xd/xUig7EvB?=
 =?iso-8859-1?Q?dBPXCI3un6MeU3N4hKes+hU/MiO1hFLZoil9lvrxgU62d0Q3XKcpK3pu0g?=
 =?iso-8859-1?Q?eDSvg4BrvmZgK3qzj1Dfj2YbfAeaaq+GHwbkLEgooeXchb/rgL0GoD7u2w?=
 =?iso-8859-1?Q?EBex6028ZUstVO0dyv2ycqJn1zo14E7qsIOoJ/I3tdeE1mg9qSk1PKS52O?=
 =?iso-8859-1?Q?V3jR5IBRZNxxnlq7pRJTslf09SwbwzP5TW1whCoYhw+DdQAfHTkj0+DLgA?=
 =?iso-8859-1?Q?Kpd9ZREs/JJc90PZkNLckjncPmOIP1NEv3Taff9nPHIgXhoNq638yqgvJG?=
 =?iso-8859-1?Q?vK8nm3cdL1qRvbeA4VQHIqnYRGldR2BMOIilTjcf24SKQM1fPFvVTgw+uY?=
 =?iso-8859-1?Q?1Q+wpZ8BVtoV76ulgH5kyWawns1UX6BeM4/iR/L1HaqIUWWmtbg0ZDizKq?=
 =?iso-8859-1?Q?WQiSw/GWKYTlg8/s2oqk6qkP13afNu5EtOCR+KKRA9F4uaHPH4gn4C7zar?=
 =?iso-8859-1?Q?Qmo0kROziHYA0Y3tAI/J910ksnF+5uJgw9L6agmCuBJY+9Hua2hjWu2BxA?=
 =?iso-8859-1?Q?r0LKn/c+ZwCBtTrZFahYZcJRKmzz2aQqzjAZGO5OAc/MoOjrccO8tDY63r?=
 =?iso-8859-1?Q?7SBPA1ZGqP8Cgr/g1LB6GjdS6wG69oLIwbpseusZzQugtcCrnQyuvNqkQn?=
 =?iso-8859-1?Q?yDxO73Imi3dJBwYs+F/LB/URUbLBk3fD2JuHHavxxMyBs+2sTeVRQ/TTgZ?=
 =?iso-8859-1?Q?kwl6aEkYVKPnKgK4eR8bgob95c7Cs+shaKkxnBP/KDqDNB5i4kmeZi+z+X?=
 =?iso-8859-1?Q?yGx2Lrr8JBDHnWzdN5ukPlJiOZbh+teWBiFsUc4lDRcNzGZFXDvssMyyco?=
 =?iso-8859-1?Q?iy7iMKylV/HP9AcqoATkTsQP7+bhQeMw0eTrF0MUfUvyBXkx4FOCZT/5ek?=
 =?iso-8859-1?Q?42HchLnvoo3CvudURlJKZ3dQk2TAyeUtXweg1tgLt1w35xq/Lttg84PFYg?=
 =?iso-8859-1?Q?cXusYCn6yEdL+RxV5W6aj7nFABlVaXUOYPpzqKUfIJW2VH+7tQdiSvhGxS?=
 =?iso-8859-1?Q?J2ui95flDPimOvuOZtkYLnCE4wnDa99CIG5bzt8Oia/ZpEw0KY66otHuiL?=
 =?iso-8859-1?Q?GH9iHt/IL6miRWdZkPvSmjka80p0Rf5nH++ggyGWLjhN+hZs6UJpIHuZuO?=
 =?iso-8859-1?Q?9vRM6qj26GsJd4CqG9AQtoymQn2/iJ+b0OoU+ocx2+4aeFTfxgqCQOWpfW?=
 =?iso-8859-1?Q?N+0OqiKXcRCdR7eB7SzpRKajgiJ2rbmTcNKXDwh0iraqnxwQcicFm4tC3c?=
 =?iso-8859-1?Q?HE1+ulzmKbNEuOb0dsXkabjbHqr+EFXYv0uLwK+8/RmCxtCdiqEs2zD07T?=
 =?iso-8859-1?Q?IWA++h8BQqqFKojogcDFxt60aM1m5wDC1WXyhz2GDy+DYfxCh6s0h+LqAj?=
 =?iso-8859-1?Q?LPmiOkuJlSw8sAzbHCkwzHR+nLvk+GjuurFwSM/x?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?D2CiQXHnQcxOWsbnCajYBHUnYcZ7R8pxw8dXt6Py1IqosWwkxvzKAUz4iE?=
 =?iso-8859-1?Q?gPzn88I+1RW2FagrhzVp94aM/nZc/Vj2y4XUj+Mm4jMGk3FPSlRRW6j5Ub?=
 =?iso-8859-1?Q?sNg3ipRRiglADRNShHfQPvVWeXc5roTyGWj5KpbQaism62fOt7fkRkNShb?=
 =?iso-8859-1?Q?pSUSQXc6mnSkd6PH6F07JxPkpkcqFhsunGMX/xIZuWjF32uTdOIUIvBJbd?=
 =?iso-8859-1?Q?dlv1uVnA8gpZ8FvG5SXSI9eneaOk6e2VZbs0MTRbk17R90DGVEQ/Y1awLZ?=
 =?iso-8859-1?Q?aV47FMkdNHH7cQc3lXvrgYuG0DaQkAw86vzR7hIx3l5TfBjhuh6EmP5ztz?=
 =?iso-8859-1?Q?/TJqNe/Zza4zvNh5rtFm6ZNm+Vh5MUUowtckzpbmfRtnHG/r5jva581TDC?=
 =?iso-8859-1?Q?HHEcvNeGMPM0EO4CYL8I9DrYosb/dApIucfYbn7RdGDizp508og/EzSkQ0?=
 =?iso-8859-1?Q?7bcEC+hi4PxrRqc5s8dL3AUs9OV5+q4/FpJb9/e19+kTFQjKibfn4Owdce?=
 =?iso-8859-1?Q?RBoOc38zRKkH9zE1gONfsMz6DzAMMcXlEdHg/YcE/K9vG/kx5xghKuLtZX?=
 =?iso-8859-1?Q?dd3L51v1jcy7tIJ+XiLGVadIWKn9m5iQCxIvAtoFsx0tm8I164KNBDT7m2?=
 =?iso-8859-1?Q?RXun9QoritHiM8Ugf6RzEUJQyTtE2JCHzTGKP5OswWfnjXs/fyYhC+M2Gz?=
 =?iso-8859-1?Q?WXFQOAA7H9EXWDUTA+QKvl+/SObBUbZOhdfhYGgdA3o4Q+17VeA7AcOyhn?=
 =?iso-8859-1?Q?sIHzvpAl60LjOKsMSYDamRN2lknQ+AZ04ksw6o7gn3JNfHa8xkMnyeiiFo?=
 =?iso-8859-1?Q?yyISuCXWpF4eZIxk6mNq1OuCA+Am1quMYQvZJM6FFBxHGqlOL3NL9horrb?=
 =?iso-8859-1?Q?fe4Hrc7jC4O+LI5wF7yNsheQJFpbmTIfeW8zyzDLeh/q3w2QPYrtFEtw+2?=
 =?iso-8859-1?Q?6vP/HSDKd1znQIAKwlQopElyKT/ylmECnuyWyhEmPI21U0YCoIbq6CqLqL?=
 =?iso-8859-1?Q?J2Kt8MMVnZM8yjJPjgCuQw3gOqOpa/fzD7ySuXqFRd/sJ2l40qCIa4guwr?=
 =?iso-8859-1?Q?oq4TygoeyxzPJAKXzikx1BegRXQ4vZgVZUmlRDOq22JI8opQFIxWdMCy09?=
 =?iso-8859-1?Q?pILqFquzJWspYDmcUXbLYpGRMX2y2QbIs+8eP1b20MbzLwO8eQa4AcLzUd?=
 =?iso-8859-1?Q?rYAFMO4WVbBW4nFu1O7hs/QP3jZph+AC6FAszyqJ642diKcmY8UaHuw1Hy?=
 =?iso-8859-1?Q?j8mEJgkHno09dxECovLoki6XFzwm+I9kUVE3aARCLLhcsLF6/0Qcq1csUZ?=
 =?iso-8859-1?Q?YhDeHmAdV89CP6wqS20jcbg/r+2N+AhNLmLo9f5ZAliAdK1P7DtDjGY8Uv?=
 =?iso-8859-1?Q?pzwwhwCQ3y2TQajl/rSHXwGuJFninBDUm0cVRFAcaofmdQp/kc9KpjkkTF?=
 =?iso-8859-1?Q?kCUyU0nvdwMB6qsEkwPdmN4RJaiy9gxf8GH+ZFSVqMSFfKP2bagSVn3KH7?=
 =?iso-8859-1?Q?svv0T4amWmSBPz5lRjgfW0Vez6hMPaLa3OlMQ1Wf3qR80E3+d6/fzmdIzI?=
 =?iso-8859-1?Q?mNn2tcvzTz8gv5CEi6aPP9uEPT7aNROyJMbsmCKyRomqrCxUXbniJsKTVz?=
 =?iso-8859-1?Q?gkeYiMM0Pfd37fF3SbiDKPKuEN5gvgkfxgdonWt+RjYVdzS/o7nuXH5dZG?=
 =?iso-8859-1?Q?CIDOXxfLGrui54gavZfjhjnUuYk8Nhql7H3ZV1HY+hmJB1Gxfz4rBS78if?=
 =?iso-8859-1?Q?lRetlz76dw7dWLz1rTebfmQYcNMumqUllmtZaq8zRziAQjZ1meIF45mBhk?=
 =?iso-8859-1?Q?BCQvefqIZg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be7d2832-d84b-4436-7816-08de74134417
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:02.8207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NEmt0C9IHwLpnBKHOcLOdnP14DLuRr3djE8sr8L+2uDQmmE2RsbR4ZergssnPw9LSIvsRBYKc5hGNkmdPe61Vqq15GIaNoTHhlpYXFJifQ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6012
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

Following review feedback, update the Aspeed I3C device to use the=0A=
DEFINE_TYPES() macro instead of an explicit type registration function.=0A=
=0A=
DEFINE_TYPES() is the currently recommended approach in QEMU for=0A=
registering multiple TypeInfo entries and avoids boilerplate=0A=
type_init() code.=0A=
=0A=
Additionally, rename embedded SysBusDevice fields from "parent" to=0A=
"parent_obj" to comply with the QEMU coding style guidelines for QOM=0A=
objects.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/aspeed_i3c.h | 16 ++++++----------=0A=
 hw/i3c/aspeed_i3c.c         | 35 +++++++++++++++--------------------=0A=
 2 files changed, 21 insertions(+), 30 deletions(-)=0A=
=0A=
diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
index 7a984e1f01..bd0ffc84ea 100644=0A=
--- a/include/hw/i3c/aspeed_i3c.h=0A=
+++ b/include/hw/i3c/aspeed_i3c.h=0A=
@@ -21,28 +21,24 @@ OBJECT_DECLARE_TYPE(AspeedI3CState, AspeedI3CClass, ASP=
EED_I3C)=0A=
 #define ASPEED_I3C_NR_DEVICES 6=0A=
 =0A=
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedI3CDevice, ASPEED_I3C_DEVICE)=0A=
-typedef struct AspeedI3CDevice {=0A=
-    /* <private> */=0A=
-    SysBusDevice parent;=0A=
+struct AspeedI3CDevice {=0A=
+    SysBusDevice parent_obj;=0A=
 =0A=
-    /* <public> */=0A=
     MemoryRegion mr;=0A=
     qemu_irq irq;=0A=
 =0A=
     uint8_t id;=0A=
     uint32_t regs[ASPEED_I3C_DEVICE_NR_REGS];=0A=
-} AspeedI3CDevice;=0A=
+};=0A=
 =0A=
-typedef struct AspeedI3CState {=0A=
-    /* <private> */=0A=
-    SysBusDevice parent;=0A=
+struct AspeedI3CState {=0A=
+    SysBusDevice parent_obj;=0A=
 =0A=
-    /* <public> */=0A=
     MemoryRegion iomem;=0A=
     MemoryRegion iomem_container;=0A=
     qemu_irq irq;=0A=
 =0A=
     uint32_t regs[ASPEED_I3C_NR_REGS];=0A=
     AspeedI3CDevice devices[ASPEED_I3C_NR_DEVICES];=0A=
-} AspeedI3CState;=0A=
+};=0A=
 #endif /* ASPEED_I3C_H */=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index fff259ff66..e7cdfbfdbd 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -337,13 +337,6 @@ static void aspeed_i3c_device_class_init(ObjectClass *=
klass, const void *data)=0A=
     device_class_set_props(dc, aspeed_i3c_device_properties);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_i3c_device_info =3D {=0A=
-    .name =3D TYPE_ASPEED_I3C_DEVICE,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedI3CDevice),=0A=
-    .class_init =3D aspeed_i3c_device_class_init,=0A=
-};=0A=
-=0A=
 static const VMStateDescription vmstate_aspeed_i3c =3D {=0A=
     .name =3D TYPE_ASPEED_I3C,=0A=
     .version_id =3D 1,=0A=
@@ -366,18 +359,20 @@ static void aspeed_i3c_class_init(ObjectClass *klass,=
 const void *data)=0A=
     dc->vmsd =3D &vmstate_aspeed_i3c;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_i3c_info =3D {=0A=
-    .name =3D TYPE_ASPEED_I3C,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_init =3D aspeed_i3c_instance_init,=0A=
-    .instance_size =3D sizeof(AspeedI3CState),=0A=
-    .class_init =3D aspeed_i3c_class_init,=0A=
+static const TypeInfo aspeed_i3c_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_I3C,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_init =3D aspeed_i3c_instance_init,=0A=
+        .instance_size =3D sizeof(AspeedI3CState),=0A=
+        .class_init =3D aspeed_i3c_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_I3C_DEVICE,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedI3CDevice),=0A=
+        .class_init =3D aspeed_i3c_device_class_init,=0A=
+    },=0A=
 };=0A=
 =0A=
-static void aspeed_i3c_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_i3c_device_info);=0A=
-    type_register_static(&aspeed_i3c_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_i3c_register_types);=0A=
+DEFINE_TYPES(aspeed_i3c_types)=0A=
-- =0A=
2.43.0=0A=

