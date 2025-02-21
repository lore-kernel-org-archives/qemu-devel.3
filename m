Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A005C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlO4V-0004Xo-Er; Fri, 21 Feb 2025 03:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4S-0004W5-Jz
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:40 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tlO4Q-0005jR-Qx
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740125259; x=1771661259;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tTPC7x09d/JU2UNVzXQW4tNA/ojv9FQmKpl+PJhHHRY=;
 b=MaGDsiMUwiXYykv7ZwHQAT3/3taYymT7JbnngXPftm8jcslc2qmSrLKx
 aFFCfpQFjiqqeJCYkOPgCi+q3ys0fEIkUXzMVItXxrw6BZ4e+EOBWGlw6
 X1E/xtwy4mhWlEqeoqJ79UG8p+ZjN4HD8oQBhO6xbh9mhjc7X8UfosAlr
 0Nd2A2yD3nTfaLTl+mDr45Kd+JGa4Z6JasGK4TnNgSKwdD6O4bOZewwgq
 wn+qKygB98wDLD2htZGRMS0XHvYrW0sllkDl13QFor+SZVBH9VAxVmS/d
 adEDrxXf/F4KzxMkBmFJSjB5JLawA03hzLQBf2CNVqP6vDc9cZ8omH/J3 Q==;
X-CSE-ConnectionGUID: KBDQSR6GSkCIFVDo0S5+KQ==
X-CSE-MsgGUID: TF7yqZ9OQ8axFTpgKo66KQ==
X-IronPort-AV: E=Sophos;i="6.13,304,1732575600"; d="scan'208";a="31382209"
X-MGA-submission: =?us-ascii?q?MDF7IGBJPUif0Fizoe1Mk4i6p/Xl0OEizrZgH9?=
 =?us-ascii?q?dHZ+W2LxlYsKBhj6FheXC5mnE21z8fL69Ut1/wxoEQs0lfuEhBmmWc90?=
 =?us-ascii?q?zacGf2y2ZV0ZBEtSyjtoCp4E/UHQVxlZjL+w6RWs4UcPzE81vFbEsjXY?=
 =?us-ascii?q?QgACY1kp+doTHDCzcUY20SBQ=3D=3D?=
Received: from mail-db8eur05lp2106.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.106])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 21 Feb 2025 09:07:36 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TN/7Gkw+nVSFsk4kavc/+zun9QKSyMoBrc3U80LOzVTFyIJZIBUr/0i3Xgswn95KJkHafpHN/CMysJXVfbnc/8Kphz7/zAKtWedL60j2JWLvFt0PCuF8Mu1pAhfqVonvAh31IssRhYfQpa0oy1cChHvWEZPrj8dbWG5VyIotewmyqiF6V840e2wAznF46iCe4VXIR20IFfrXlGEXHNmVta6if0nFVB8G5vvDeWqiylvR0Se9SWD/oi/AuXEdDDaTbbHjlHT4AubiFXWIWEOibd8FMI7zTUXlFXgtmCV1GmSFuwraQFdEf+YkWL8ASi04SqirHksydbYezV/SlDWN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86uCvdGZzOooKIlDZ2DFXfgs7JqKRdpzpFrzYIXH/p0=;
 b=Ebc28O9519uStdl56c8GR21PFfprRyzXow7y52/h6fDaBAbmseI83iJpgU1h2LIA6/UH010r31jlzZg8VJMSQphutmIqeXeZuQi4zjQc3PQk1JbONEv7eFNWJ9P2JTmRilatexrUGRdzp3SmLJxrniBadQO+I66T6Kvia9t9JsZruvcJNN/zG3BI2OKTpwUGSVOmZ63dscAp3GdqBmX1mJpXOC7sBD3kJYcfc5i3yXyvJ9ncZWgZgmRAKiAsXa60rgjHhkrNN/olua/kU1bW/atbYpnUjgjmuXMHXvoqFDEzRhqLVi8kqX2XfP7/PDzMIYwr9UYBW+xafm9pYFgGBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86uCvdGZzOooKIlDZ2DFXfgs7JqKRdpzpFrzYIXH/p0=;
 b=TXwoBxzXnbYvrRPj1HSKS61SuP1No+AAmFac56xK8V2VCyaqoymp448NnhWVoOF91PIPQwnwMLemNedb1Oybaer2pcRx4GiqcOfyv8UJMnwxmc81tepFP6KkhUXNFHAFC2h92nU3y4X54LIUPvvsnE3fzOBlJFYWQPbtd2ipKEx02nhRjb04gxs/Vfx2G/ZPVOauvnxtY/WfKFSwvdDTnuecEPuefAAO6GYv9HRAYqukwg8hInWYZjOL4uPxykJmSZoViwD5+Rp8tbwPRjYiE2J4w/IGDyLns6gmAuxt2nBOsqR+aBNRh2JsSrdDPQ5m2/Yu+H98TqOjMIWcy7341g==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PR3PR07MB8162.eurprd07.prod.outlook.com (2603:10a6:102:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 08:07:34 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 08:07:34 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 06/19] pcie: Helper functions to check if PASID is enabled
Thread-Topic: [PATCH v3 06/19] pcie: Helper functions to check if PASID is
 enabled
Thread-Index: AQHbhDepdMqBvKBdQkOQrrksc1y1yg==
Date: Fri, 21 Feb 2025 08:07:34 +0000
Message-ID: <20250221080331.186285-7-clement.mathieu--drif@eviden.com>
References: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PR3PR07MB8162:EE_
x-ms-office365-filtering-correlation-id: fa3303e5-7028-4a7a-0d20-08dd524ecc72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?brd2A3IvSLU7utKG+v5JBPqk7V0Co6rCektlPVwUvYHg2/ypZ/N+ApJIyl?=
 =?iso-8859-1?Q?EKP0Q1QMiY+ZXMYWeZ2G8RB83g4riRwVkYXWvtY2h2UAE6cb/U0NJCbTvu?=
 =?iso-8859-1?Q?+ZkmpiqOT3hbWQAeVa/6q43XuMrvGN1rOtY8AU3WXIxbeO1IDGep0pdfBe?=
 =?iso-8859-1?Q?8HBXnp429T8l/FuGt6zp74ibQea/Q6YhsgLe9PPYu/CMHN2gEjVLTCRF0R?=
 =?iso-8859-1?Q?z6ElwD6BbqZ/ICrK+yO29gf44WqC5ihp9cqzkWk1dLUnE7uLOxVeghAsW7?=
 =?iso-8859-1?Q?ue9RX4ImQk4/CPFb4rN5M12hbhjTRx4/8Ry5KHUunKuslhPGRD1Y2367wQ?=
 =?iso-8859-1?Q?Rwf2vhO+wjirG2HJXUOHgaE7KRTg53rlHJBbmvIIRF/8RfYzL9TvcblDtW?=
 =?iso-8859-1?Q?OiJOBpcsKZJM0gKgsHQUtS9MywkVU0hrdsO6jc14FoL+VMv3hvMuMP9w2j?=
 =?iso-8859-1?Q?61YebwHFMbEV463T4urP1Xg9duvi3F8CuITEPRIf9unpxZYpQEuQX/XDaS?=
 =?iso-8859-1?Q?pcx93PPT7JMqw3gAOaqS5maSnTshiZCJjD+x4FW/Lr6p8Knw2jMGy6RHSf?=
 =?iso-8859-1?Q?MieQTeulNeFEtsBO3jFOrRU5HfuWDmN8AUs6lTnPHGKVMxj3l7JlmZH5WX?=
 =?iso-8859-1?Q?XYEeb4yVMcEkcal/JvW4aHJtYn0dk3RU6i/N+SR8X9Agognp56tLK5TGk7?=
 =?iso-8859-1?Q?OpRvc2f1vwXI3YkDGtSUF+b/mRIb9iyrUB1E6a4SovlHxbiLRYRwFNuXXV?=
 =?iso-8859-1?Q?xa7otppOvYY7fYQcXxLLEggKcaoYOCbFMoPEZsQXWOZAUt17sM+QRC0yh3?=
 =?iso-8859-1?Q?l0XKaRTv8YBVSa/FtCAEDLiATDCK+tJvFX2kag0s9MRKg77NWaLAxruPoC?=
 =?iso-8859-1?Q?kwylomJlslH1OAGmi4VhQ9yXFbUbn1qctGaGXJXj+Xl6oejT+ZnYuuBN4g?=
 =?iso-8859-1?Q?wXR3o5wmJCkvhzzpOnxlcorTHHqP4DIypAxlXNccSDQgckJ4AAQaZgnqTa?=
 =?iso-8859-1?Q?uZzA4aBhd0GaulAYDPU8O0Q2aCOgOd/f4xL5qcWZVPv+In3nnSwOTmuk4P?=
 =?iso-8859-1?Q?/eFDEmCY3rfBVpRyjtu/vxKML8KduzQ0aHbO9ocXQfsNw+yxrkRN3Cs46j?=
 =?iso-8859-1?Q?m4QtpVslwf5OX321P4cA3TO+tKRwkXN5YLuLfiCQnCSFtYwc4n3VWTmgaD?=
 =?iso-8859-1?Q?sQJUwdCVTWZnhzbDzRBrT8S/70bt0vQvPJ6lQR5TfOz8D4paQ4IPUnkvsE?=
 =?iso-8859-1?Q?Cub1NoZY//19RJTAzH7xrQ9AG92KEH7xB3xQ4zpaWDWYlbdPR94VMaCowr?=
 =?iso-8859-1?Q?cAr3jvMB+OjBN3ohyOxgvemUhlPYZ4NuGVg2tjK0ZwG2HYwwZcpWfRn7g7?=
 =?iso-8859-1?Q?ujojUUy8E7M9Ua5/JNTmBEIOuvRp4qwlK/7JJ6opka4fLEJwHXv8ZuIzMC?=
 =?iso-8859-1?Q?Ic1b0jEgCztvqXbi3oKw72mzMzTY1hILaolQZWaErD8jPtlxs5wkG4VPBo?=
 =?iso-8859-1?Q?8mfLGNjcAVNWpFfUTSNMjR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xSHV2JLmGVzjFhF4j8XE72dqv7BBtOUweRE3sNbihivQIJAIwVP37o6dCc?=
 =?iso-8859-1?Q?kD+/1q0wRgl3q7ohXF9t2Z2YV2gTo+KFWlgFef5SJnV5QNVoFT1L6aO+Rh?=
 =?iso-8859-1?Q?RD2PiRS2c4YJdggCDOTlZQydGTSBS7SC7NJpjFcQX6Hwh/k0E4mFuskanF?=
 =?iso-8859-1?Q?5Asmk7CXioGS4hOQz5hzW3b7fz+BKn3vNPqqGc/EFL8CZIFH5GGmGr6tR4?=
 =?iso-8859-1?Q?t8gsi0CmWaOnM2RSX08r6Yq9qj5rKGwIz0ZLRAMRP5aWocMWDKlz77Sn0d?=
 =?iso-8859-1?Q?ZtUGUve4KpyDCQ7TZzORFQ9Co8PBQcZZwop1x+rLLwAi65O2WIamoKaOR2?=
 =?iso-8859-1?Q?ggEfkE18jby9t0blKkxbuVZWi15DfeNHZ/pzZgueMJtqZoar5QScijJPb8?=
 =?iso-8859-1?Q?PQ+Dx5Z5a/QVQua1ebGLbu8RmlmsiJBjuqbl52RpkoFlwWIuR6YlTdNByg?=
 =?iso-8859-1?Q?qnf4yJn5rsxK7DT/U4xQHmVhKTj3BWOvC/BDrGP4CKE9U7t35BfFhKbkEO?=
 =?iso-8859-1?Q?F0cMTi/bBvxVj25qfzWkibGN7rsiPxXZKbj2zIbnpjepqHVqSz03kJqYE0?=
 =?iso-8859-1?Q?MIHoHY2i11fSF8kXTVxGvXgTDQUfL4a8d6YK7e2OqBSAPKKZwxQ4+DD70O?=
 =?iso-8859-1?Q?X7UJaSu+vcTSPpyxBCkcOQqSTOPlwPdfxd8mfx0ASHfkMeEL2xw8rOvi/i?=
 =?iso-8859-1?Q?4YlpaYuUyKALAc4zBAwaC9beKJnvU5jztjC6s32i8LeO4xhB6wCjlpK8/1?=
 =?iso-8859-1?Q?0p2/ksZdMYh6DHsMUz+BsWy+enILbLzHTTKkqMbON5c6h4qwv2i1aOyIaH?=
 =?iso-8859-1?Q?gLJcAhn+S5ZTgi40KFMzqLcKBa2ayKo/8aB9FXNBe8mp/r7nLCSQvQAcYV?=
 =?iso-8859-1?Q?2POKAPN+Al53DLF/AwmhJ84kAOmOY2K545gDWbGnS9mMOXvBZy+PJ987Qj?=
 =?iso-8859-1?Q?fjs0eua8Jpl0PIfpmhnO5IdJ26wh9fa+f6NouZ6N8kSZZSqyBx8v3nVdbx?=
 =?iso-8859-1?Q?G4fcpsheZ1kyCom8PmyPaWLMPiWmlzx70bYfAC6YW0f1IsALkn70sUQ5Wc?=
 =?iso-8859-1?Q?Wilayt1s1bQtFd7GZVxamJHlfQAXi1AxJ9KR2gx9TLESRzOcrPgJ4v5pGh?=
 =?iso-8859-1?Q?+Se4fqtg2+Vf3U0mm/hVeR5JqWiD901jsJBSEwWw4hZgUWDCn4Gsc8sH1K?=
 =?iso-8859-1?Q?0KjSBYkqs8xyIQ09EAvMOuoULgdyCf9spnSxjzvLq4TCPKE6LMp9u1T6aR?=
 =?iso-8859-1?Q?vFRbRcgNkVIzKE4khiUOySFiS5m3IWp4WFY1RVXUMssIL+YGXp+Om3MBR9?=
 =?iso-8859-1?Q?kdPqxwzlPOVz1UgdRPU1oQ6uX8ufgmuEs2RbFasAWZzExludSzEaf316A9?=
 =?iso-8859-1?Q?K6zQ9H7OutjPVBm6LoxlzrsMvWI66lmIXvHI//VZljxWBqh0Im337h9+O9?=
 =?iso-8859-1?Q?nqKPvHdUrWXRa2JN/iHIdAakHj0SKnzmYMz4Tiy4L8vJQukRwnWJPw+YW4?=
 =?iso-8859-1?Q?wxNbxHPkPHVh6WfeXBIS/R+83Hkrsu4E37LyHpBeBrSTeap3HKrFRdihqc?=
 =?iso-8859-1?Q?aVeckKNqpfOfDlPx+VPPu69AqBfJbPzoVFdDRYQohV9L+565PJPgm2hR/d?=
 =?iso-8859-1?Q?5nHLZkq9cQmGE9opeZ4u0an2M0YJC5n/l3M9iyqCHBc5lWihK55gILXYJZ?=
 =?iso-8859-1?Q?N9GEl+kPXgO2Z2Nlkts=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3303e5-7028-4a7a-0d20-08dd524ecc72
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 08:07:34.7287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xy7Wx4Htg6spwueWgR+YNLmgXAuoO7rSl1WVfLnUS8RA5CE/swL03aHdPVdz3ZZUsfD+B92p0VpD7DJpFuDRg+7owUDFG4wN2UDsInEFBrBEGVCTJcI2X/et3s3axWyD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8162
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>

pasid_enabled checks whether the capability is
present or not. If so, we read the configuration space to get
the status of the feature (enabled or not).

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pcie.c         | 9 +++++++++
 include/hw/pci/pcie.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index f42a256f15..8186d64234 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1238,3 +1238,12 @@ void pcie_pasid_init(PCIDevice *dev, uint16_t offset=
, uint8_t pasid_width,
=20
     dev->exp.pasid_cap =3D offset;
 }
+
+bool pcie_pasid_enabled(const PCIDevice *dev)
+{
+    if (!pci_is_express(dev) || !dev->exp.pasid_cap) {
+        return false;
+    }
+    return (pci_get_word(dev->config + dev->exp.pasid_cap + PCI_PASID_CTRL=
) &
+                PCI_PASID_CTRL_ENABLE) !=3D 0;
+}
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index aa040c3e97..63604ccc6e 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -156,4 +156,6 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *ho=
tplug_dev,
=20
 void pcie_pasid_init(PCIDevice *dev, uint16_t offset, uint8_t pasid_width,
                      bool exec_perm, bool priv_mod);
+
+bool pcie_pasid_enabled(const PCIDevice *dev);
 #endif /* QEMU_PCIE_H */
--=20
2.48.1

