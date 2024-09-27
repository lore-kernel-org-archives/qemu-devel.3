Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC85ACDD1AE
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 13:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suAyl-0003ho-J4; Fri, 27 Sep 2024 09:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9t9-0004WL-1s
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:16:05 -0400
Received: from mail-db8eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2614::701]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9t3-0001sw-T7
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:15:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gcx6i536fWePxNi19rHtWNKnkmPi2Lu84n6ueFvCBkXDUOWmVYNZKX8oyR5BnBnrEmtHyCVVTGDB1XHXVWFYSazgy+XxJewDDIiMvSnAOkSTG+FwhopXYlJflAqGIGncKUGLeTwQJ5gw7SBewf2fNbYwRmEoJdvkBeAl9ddokDyIUTxrHshBucSkDTCHQcp7CsbAa2UVNjQ5I4eqHlPoH8KVZLcnJc+n6CYvGmFdYeHrzU4mxR22yxJr2knDvdOQ5ltTn0Q79Mxi60tvceP+OCD9Y/A/xZA8DC76fv9CBe6LNbOFP6cVEo0n65aOeOsYVX4nspBj6b86aGob0bqquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VexHXUbSk1kmbzMo5QCshbB9t/4pIq5lxCTbUPWQdFU=;
 b=ieG0QsV5BDNWj052B2fBIB4L4ogdByplsXuF+dr2ENXq/+ir1EIobgrFqmh9mrbwi5F4PSZKQmdZuieVhRXoCXp7CLHFcst053yG71+y0CDhugVFpiyqThg/urMSi5pXfHEJP788TLLhI8Af4qz1lcWz3R2AXrCpKijmJRronukkIv1VTTkAwKAM8vl4vnQm9z8GuYz7ixONcKS/rCHKAyqimkD1YZhEJNLy8y2ocIcDdLVnzrKyQssGiy5wnL4D+IkjPuRFSL63/gVCrqe+tZGpC5j37MLupwB3bFhr+kKgRuHanoKIAxZOTVDuArcSc5ROryCDtfUzEsIv3nRYlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VexHXUbSk1kmbzMo5QCshbB9t/4pIq5lxCTbUPWQdFU=;
 b=Z4ZNCXYqcwIiC2/Mpkb8h0lHFtvwG1mLK4F+fGeR6ogz0LikBzFcjsM/uvD5nlyVYij3xtWHxhGXYupxX4hFxFHgFpRwFnLr8NsauqPl3JKyEObgaLxF8N0df4n4ZZtg2RfbeGkwF0IUsQ68pUwZWH+3JRvsJrLt8HZFiryrKmGjbn145dA+NjvSfplMejkkwhLyzCXEzNr5OF9ADCPZWf1rKEiv/bae5knD7U9qygKK+D7fDTjemK0J4Irl7Xd4tFnIbhmXyAdN8AH4T3qyCzkMflJocci5lO5I5WBIi469AwTz9/b9lHiH1lkcnUlgVG4p48JtyjYpvMS+/sHU6w==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by DB4PR09MB6621.eurprd09.prod.outlook.com (2603:10a6:10:3ce::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 12:15:49 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%7]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 12:15:49 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>
Subject: [PATCH 7/8] target/mips: Enable MSA ASE for mips32r6-generic
Thread-Topic: [PATCH 7/8] target/mips: Enable MSA ASE for mips32r6-generic
Thread-Index: AQHbENaeasAshFkTbkmP5utGs9GItg==
Date: Fri, 27 Sep 2024 12:15:49 +0000
Message-ID: <PA4PR09MB4864EE89F6DFF1C94C95D7C1846B2@PA4PR09MB4864.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|DB4PR09MB6621:EE_
x-ms-office365-filtering-correlation-id: 9972e7dc-edd4-474e-1a34-08dcdeee1f97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?uzh60UiUyqZOaC9DuF85Mkr9PWEoY+GWfbUxDxe4ttuIegFk0G+qduBWuH?=
 =?iso-8859-1?Q?6zm6+2uD3+YTkutYV0RbzhIf6IOKnX4E4vqg1QJr/2EaxO8p6oL5k/Iagn?=
 =?iso-8859-1?Q?TcFrSZrQpYQZqxxsWZvKoqSlHHN8Ofc0Qw1+HGiw8kdKj2HVYRTWkrpZiZ?=
 =?iso-8859-1?Q?jYBycJqt09a2rVpMo7whm1Nm6nmy/0BqpZ0oiw4EiL7mLmdFePMhFUiFhj?=
 =?iso-8859-1?Q?k9Dhm0/laKMtJXG2drTNMhbuU18pkbRvq3DLKSQxJLTEsVd7m1LkL7Z4DW?=
 =?iso-8859-1?Q?FVe7I9ODhkaLV44cy3T/67zplp/au3MsKWw4rlBVuKp90JFoNlZACx7qQy?=
 =?iso-8859-1?Q?M9ecp3MbNEpmSYQjjUXQ/PpYPGTg4eJiYw0I2wFzp7mCv2tlYa6x1MGqEc?=
 =?iso-8859-1?Q?KSLuSqScjRGz+OSwzDYENMAE2sgVBoshrkwC1jYsyxY/HXHZuRaDpGMCg7?=
 =?iso-8859-1?Q?ToSFtK1RZODdVB4pb8TqV8Kw/5zAirRWAoBJ+LVcdIi69alM7gmbhyBwvW?=
 =?iso-8859-1?Q?isTGicniyhedLlw+muRebkN0kOJhNVGiO3F3tzg0GRCn/Rx1/ZhWDtWHxN?=
 =?iso-8859-1?Q?ZHhe95ntiZvt64liGe4DFw9WskEz2XIr5BLopbVQru1IetpcTqb+Pe4XI3?=
 =?iso-8859-1?Q?oSLTTSK7u0lHIDH2KvPTZpJmnFUBjUNwQ2ovLSOBopwq5XNYuUOQ/AoWQ5?=
 =?iso-8859-1?Q?QXX87cl21UgMJpFmCCNlramBU6fZq+UaYxdLvIqEzhzFoKEWbsUz+wwBPT?=
 =?iso-8859-1?Q?DgeuCs0SAYjH6DnsMnyIiehd66HSUxwlorLBoR5iJbQuZfpI4psnVHfuIU?=
 =?iso-8859-1?Q?lvrRWPUTcyW2n12GW8qNGoenxBVxDELIPg9RMCWbz0lMH0UKV/Nb0ONdRn?=
 =?iso-8859-1?Q?r4P7KSHBZ4LZhUxnb/wUjcnEwmlEgQClt5Z7XUo3etTnVHBlsJSsmbOqh7?=
 =?iso-8859-1?Q?sKTSKw87W+seKBsWc3oWFEDPLx9/L0Dx1+LEGg5GnG8KtMVvtzi2bu6rQU?=
 =?iso-8859-1?Q?qlksHuTfLS0whwhBCwIgbMhP9pfnyAlYsoX83M/iSUCE556jUfqXvkxGZ5?=
 =?iso-8859-1?Q?1N461PJ5pmBCTvocZAY/y6lRlfBxOaFgcOz4lnSOS7gnBH1fkPJMlzIeO3?=
 =?iso-8859-1?Q?5EkxGKzw8mSUPe5OTQcr8o8qvnw+bhtBU/NAMCAmbg5T1CWsMdr3mWzun/?=
 =?iso-8859-1?Q?PcUh49jS/B1MBISryu9hXhVGI75Ct6hFjeldNGn0Xv/2bZC0xxsfHg8gOK?=
 =?iso-8859-1?Q?GvlLX7vPuBuZ16fnQuXsD5vWloAG1Fvixe/CXonEb+RFPMp0mQoYCzSsuL?=
 =?iso-8859-1?Q?kEIJdeApmXA7OJOOaxefrnJ7J7lQstibiKpnUwFut641ndfF5GRemd0zx5?=
 =?iso-8859-1?Q?v6EqnOvHghgkITNkqnRezAse5yaPvL67nkifQmdxl4g52xVdfou45iJ0a2?=
 =?iso-8859-1?Q?N0VwL3UCmDQ9lBPmmBv+4OEj9waYRExKWhvzbA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?W+7tsP9LPA/rR3SLMn51TUlNBnWjQ3SSvObmSdXo0WfiQIYa+tkHfNYvst?=
 =?iso-8859-1?Q?UBFQCy7cTWcJMpsWcdxZu9seEHnU9prbB/3uXJKa3o4r9kwkG3jfczPt5z?=
 =?iso-8859-1?Q?VDjvCuCpYXUEOvAumoaw4wB//tJIz3p0OkXI8rkLZh1J7HWCN7O948JMws?=
 =?iso-8859-1?Q?mv6QzG4u7uuOWvVObYFWitOn5MEAJTR6sIJa4C7jfTcXdhD30fB3xxQ0o0?=
 =?iso-8859-1?Q?/XPlcyMBdR38neEHdXTQK0NLZVNINxA6BROZDmESx+JH5R0CtzEqcOlphT?=
 =?iso-8859-1?Q?DPjh2juFzKY+wMJrqKuiNFq/bWAMRTFEPPMn66PRGMgSAExRjtjRqemoa4?=
 =?iso-8859-1?Q?Hv2aWjx+56pGzoCJue3QWaaZxkNW9SWyqLDq+tmBJZhfT6HlijhdQkgMNt?=
 =?iso-8859-1?Q?BJhxHgnOqexNVa+oCngXljdvBAjfqb9GWPktxej5MQIz7zC7AaGgUz7EMO?=
 =?iso-8859-1?Q?+MeoY9cW5eXROnI1Er/jCEHLPub+rWCYcW9VXwgDF8l4xSgXa09ayYcY2v?=
 =?iso-8859-1?Q?CJJEgaOriSA9iaWSNqfB/mWa3G8o9DXnhmGllz63K+w5mAcrIadgRa/618?=
 =?iso-8859-1?Q?yCYc75qTyAGtK2JnlsDXX+PQZT6s5g1jEuKGB1gxCtfBqvAx6AktyJl2kP?=
 =?iso-8859-1?Q?d0TfcKDjXPMK28jwnwmzYubeSp9lwBzOWzTFOawjs6HDozjTEQFzGqc7ti?=
 =?iso-8859-1?Q?pwGXbUFVZOcFg8HnJQFvbFuawfg2Gi2rZaU9BFBHvZXSrZvnX34y7ckOuo?=
 =?iso-8859-1?Q?e3s76q3l67ywwSxJUVvprUCdnByQlW52fBU1LzgDnbO2WfClaP6JJ2H66y?=
 =?iso-8859-1?Q?baaGBuRnGh0IHldsuivqn23K8CokBhy89SgJDmRDYTyexMlJChTRMOuQHy?=
 =?iso-8859-1?Q?wH6jkDvFKb2wwwJZKyRMbjb9OHhX6WDAJlEpJyde9vOwg7l3hd1OU6DtPm?=
 =?iso-8859-1?Q?7s/NdQ2JvLTc1vlzoz6z6Erp+pvkwOkSz1AQn+Aooksw/0Nj+zv5G3Z6Hc?=
 =?iso-8859-1?Q?H0YT+TSFD4kmeAVgmZ1kqGD952JxVAI1CvifhQdhmVyTiozg4NJiAxco+l?=
 =?iso-8859-1?Q?42D9X1SM2QqSSjEbVJih3UUbVHuQZLFhwqseaivSqa6CbU0qs6svqlLQ3Q?=
 =?iso-8859-1?Q?oDh9sxPWrCO+sObq/Ygk0tgXOKH/MnhLMBZP9K6kTQzgKL669c7KZZrXtV?=
 =?iso-8859-1?Q?07oEArEw7TlyUaYbkjYER0qKmkuzbZNi6NV0dQBMET6Di4sH1sDDgrWkxn?=
 =?iso-8859-1?Q?UmNClw004bmlNwYvPxd3tctCv2t5a9anll9+A80WM0+71kq/mk6ZKwiLbK?=
 =?iso-8859-1?Q?b4/+nU+eL5jRDO1Haa+m3NnV1OSmbIIrrfpLPtBJKlonkBJ64u/Fo3gVgP?=
 =?iso-8859-1?Q?1Ifj3PGlViqG1JwO0pdUtgAESfBK354EX04xYqJtVhgQtsS9JcmdDhZ+5r?=
 =?iso-8859-1?Q?/y6d+/Yg/WlNowc/jls62i2L0a80THe97So2TxTbvuEC3tbHqdaTUo48Bd?=
 =?iso-8859-1?Q?q9bVu5hDxQWCueTKfgL97dILGhYjCag4llKuEnJOs7mwRg7Y6JMeG0P40Z?=
 =?iso-8859-1?Q?HAdzPl9eJebDl2hAOn5tUosNZ7DptW3ezAFVpJPGb8R5f/toyOF/+Akd+v?=
 =?iso-8859-1?Q?3sVy4fZRTBPHEWZ+RBnNh2gjMcot8U07eDWjpOv71KFfKCkwMRsdJdTg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9972e7dc-edd4-474e-1a34-08dcdeee1f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 12:15:49.3271 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7lcmYGaI04/pmsv4SJ+FVj32gYUKgJjNj7WI+iL1LWPr78s7fLkh/r18C8IPQ5BvlcQUTIYUU3OWKKvrIBceJAwuLag2y0/ksnNC9Xi8fNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR09MB6621
Received-SPF: pass client-ip=2a01:111:f403:2614::701;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Sep 2024 09:25:49 -0400
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

Enable MSA ASE for mips32r6-generic CPU.=0A=
=0A=
Cherry-picked 0186e83a0613e90aff6d4c12c91cdb080d695d37=0A=
from https://github.com/MIPS/gnutools-qemu=0A=
=0A=
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>=0A=
Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>=0A=
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>=0A=
---=0A=
 target/mips/cpu-defs.c.inc | 8 +++++---=0A=
 1 file changed, 5 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc=0A=
index 9428ece220..19e2abac82 100644=0A=
--- a/target/mips/cpu-defs.c.inc=0A=
+++ b/target/mips/cpu-defs.c.inc=0A=
@@ -478,14 +478,15 @@ const mips_def_t mips_defs[] =3D=0A=
                        (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA)=
 |=0A=
                        (0 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP)=
,=0A=
         .CP0_Config2 =3D MIPS_CONFIG2,=0A=
-        .CP0_Config3 =3D MIPS_CONFIG3 | (1 << CP0C3_BP) | (1 << CP0C3_BI) =
|=0A=
+        .CP0_Config3 =3D MIPS_CONFIG3 | (1 << CP0C3_MSAP) |=0A=
+                       (1 << CP0C3_BP) | (1 << CP0C3_BI) |=0A=
                        (2 << CP0C3_ISA) | (1 << CP0C3_ULRI) |=0A=
                        (1 << CP0C3_RXI) | (1U << CP0C3_M),=0A=
         .CP0_Config4 =3D MIPS_CONFIG4 | (0xfc << CP0C4_KScrExist) |=0A=
                        (3 << CP0C4_IE) | (1U << CP0C4_M),=0A=
         .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_LLB=
),=0A=
-        .CP0_Config5_rw_bitmask =3D (1 << CP0C5_SBRI) | (1 << CP0C5_FRE) |=
=0A=
-                                  (1 << CP0C5_UFE),=0A=
+        .CP0_Config5_rw_bitmask =3D (1 << CP0C5_MSAEn) | (1 << CP0C5_UFE) =
|=0A=
+                                  (1 << CP0C5_FRE) | (1 << CP0C5_SBRI),=0A=
         .CP0_LLAddr_rw_bitmask =3D 0,=0A=
         .CP0_LLAddr_shift =3D 0,=0A=
         .SYNCI_Step =3D 32,=0A=
@@ -499,6 +500,7 @@ const mips_def_t mips_defs[] =3D=0A=
                     (1 << FCR0_S) | (0x00 << FCR0_PRID) | (0x0 << FCR0_REV=
),=0A=
         .CP1_fcr31 =3D (1 << FCR31_ABS2008) | (1 << FCR31_NAN2008),=0A=
         .CP1_fcr31_rw_bitmask =3D 0x0103FFFF,=0A=
+        .MSAIR =3D 0x03 << MSAIR_ProcID,=0A=
         .SEGBITS =3D 32,=0A=
         .PABITS =3D 32,=0A=
         .insn_flags =3D CPU_MIPS32R6 | ASE_MICROMIPS,=0A=
-- =0A=
2.34.1=0A=

