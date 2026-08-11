Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A25C5B569
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfYL-0007Hf-Gu; Tue, 11 Aug 2026 02:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYJ-0007HA-PF; Tue, 11 Aug 2026 02:01:31 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtfYH-0002cm-3g; Tue, 11 Aug 2026 02:01:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIKoRi+3ZrgMoRY4ZfzwzXGEXn+pfjFVoiUEZAyEFCx4zCg8E+A7pvybNvA2G6f+JrLdz3t8pnnGCSf6EFfm2ovfoKsH+ZK5M6z19t6X73EXoQTKShAPQm1rF4JmSYpa7++Afcg/AiYxpv6RTM2Bwg3f+eA3cDXMS5jDOa8N8uFZfP+sxcce6zL2tOZw+h9796eUNEHfosb9Q+Ef7MTGc4VuJm3KAMTMf3C/PJtkNiN5Yo0K50thl1liJLSXdofDO4fuhLV1oaPiqObzhQvd9gy5AzfFMLb3+ht/fXNBECGQXYIs78bs2NFNQAqODQ+SvSdSF8kwX2EbC2PkpMkazA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55XH+r11OUgYEIxi02MZKqdljXIh2A2BmiH6m5Di1x8=;
 b=Zj33o6HATyp5PcZX1Tv9+LtVNy3P4cGNtFNF5btVrjH4LtoIRTw38kfR3Ag+vKBs0F0C28cv5d1tFH03uNFDxUQhNnZcuoNSio+uOpCp7VNyzHtE4bjU/6MewKeuiMF/3jkZEA9qLAZvBi84GeDCuG+RjHz2FRPyktQDm1FYpUpBRqDmeFWDf9cGjyrW9S8ZxwbkMxGPpCUm/0CGk/P1e+ZFl6mul8JRZ5rcEDx8/6xVcicb9fncKtAta3JELOzpIbN+9/AbgKZRAvtf+lcMDSDkl3DULnEK+N4K0KO9DD9Gy8Qoutg2pX1By0KFB0/zmfV4RnXjzKU2rx8XrHhiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55XH+r11OUgYEIxi02MZKqdljXIh2A2BmiH6m5Di1x8=;
 b=o70CIQ18c0ocolDqV32/fx57K1WG7GlkFQW8HnlEexib4TULs/dseuZ77cTBV0NbUiWald9neGdr/uCw320K13WBcqM1ApoU4Yn4d8Ckecs528xL/jnZpAanAEpAO2peXiljn8pZkNfv3IBX8kd94v3Ip8XCgGzXyEpzLY6C27aoWaXH3JkcWk/bo+UGhwrXmlXv2T5RBKYS2Lstvi4nrfoxK3RY0qD/6defPUfyHrpP/y9IjK93RF5/+tivE3RUX6X9uSJIjqbgn0PEs9r+6zfrG4qUbNaMNoeAVRo1UPir7rvxzXAehq/FWfEGPOC1qKQTVUj9R3KRj+yCdUAAqA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SE2PPF7489084AC.apcprd06.prod.outlook.com (2603:1096:108:1::7da)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 06:01:17 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 06:01:17 +0000
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
Subject: [PATCH v4 00/16] Support the ASPEED HACE crypto command
Thread-Topic: [PATCH v4 00/16] Support the ASPEED HACE crypto command
Thread-Index: AQHdKVbS6nzNtdxeR0a6Ly6JSlg4Rg==
Date: Tue, 11 Aug 2026 06:01:16 +0000
Message-ID: <20260811060115.1849266-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SE2PPF7489084AC:EE_
x-ms-office365-filtering-correlation-id: db4f99ae-2141-4976-a164-08def76df527
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|23010399003|56012099006|10067099003|18002099003|38070700021|921020;
x-microsoft-antispam-message-info: nJOu5ZWOSumX/6xfz1cRYRmNxlja2zBNRsyjUKUp8wQPm2dln+KO7NV4MyfXmub2WEqWZp+tLl0NGf5kH+iHlfBCT5APQAd4skWZ9TArzaVei2k+arkw4To5u/y5EdwYyuuxGWTN4aSBd4V6MOAc3/oDTyhYZzKI6sWnsCusjxlNAkk15/VHkkQft38HyFuAw77rdyrmOvPxk0mEi2tnwTyOm0zUyPNL/SLsE9xvXLVQoXWBNr34KWwkOg8m/vuvLAc/xuoUuvmQ2roK73IfFPznn1BrRkZ2uSNIVUByjCwu5LuJZdWiNeVriA8n0gHU/XZHi2kGWqAp3zFCcVXlACbiXNJafU3jvWc0Yt3/yBCdHYnqjg5d1N8YLpHEZVzYjjasYhNxAcE5yNlUR0k8GHprTfD8IJ0htDgcZp4RLLoTLl/twwo9x8SXHy9xc1rDx+XkGHm8iwQslW9VLnKvJ+SPBBFGvtmSmTWXjM8R7Yed9AklO87J5dANNlqafMQhCkx72cDin5PcmNP+snsjMWjKX67b74jXfrkkvR8mL3jIfohnp3jM+on80/XpyknMHMdC4Be99hD8XY+vemqYwpVOmgQkipyUYBjzUaxDcBJNfvW5l0KNrspyOabgI2Q1KUZZIODV/1lyrp/KkOoXA1rJR7A5B2YSXxk4a00i/OF8FqZVQ0TjVrxqKyAlVOpKgtsVyBTd6sgFBhsHa7vMZx/xeQqrKAe+QOwYUi/MCaOX4IsoeCIj2s+BuUhe/pi0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(56012099006)(10067099003)(18002099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7n9jQQ5p4hWE3S3Knx/oUWpg+viHqk4oCH9yasFapennyoCHILIyIiGPwp?=
 =?iso-8859-1?Q?6C724gLC0dIBIsdyMTHzQlyVDEiUM3zuhDTDJZawcHas4aA8SlfqWl0nDN?=
 =?iso-8859-1?Q?rgFJiBjk9OEyTjN4f6rwBIoknDDc2kFQ9EqaGyhY0uvA6lQkMswM5Ib3IU?=
 =?iso-8859-1?Q?FP+vKgTmmU2W/0PaHgQgfS/OjkDAIFPEMbx+bU5V9NDHvpXNJXFvxjP9DH?=
 =?iso-8859-1?Q?szuojhNRNBaY5S4/kva/wJE8XIzmWavhaDwGb2Yr3bmi7jrAFhRLDMOSwn?=
 =?iso-8859-1?Q?XftGnjRB5Cs1h5mMGcDueMD9bxRc5XjEm4XhRNTvQia3v/ZOHiNLVKH9ZP?=
 =?iso-8859-1?Q?F/6A8j08QuvxTcR8Wj8k0ewVZ5nMm3RG6n9QEkqiOQYrQklKTF86662BAB?=
 =?iso-8859-1?Q?qLkG9fEeF8PWUEPYNbM3uDWOqXojahg/DQd5/YEm992J0gC/FaBy/p2fDk?=
 =?iso-8859-1?Q?tyHkzw8vM9/Eg9k8IE5QcEn0va8I+HJmL8AqsxtnUmyYD6JfYEuFuPozaL?=
 =?iso-8859-1?Q?qnXS7IYaY3TfrsmW8vziNWwD2w9+Qu2VWxow+K5zSkNjqADU/m7qG5ZYQF?=
 =?iso-8859-1?Q?q2e1pfiOSrBoZIrmAUJVI9RlLPKH9bXXLKoY/yCNRd2XkWpCbg5spBHfL/?=
 =?iso-8859-1?Q?C/B/cui3bQulgAToLIZat8+IW4U9uBhtCRVupPks9pqL1zb+7sCEJkN7N5?=
 =?iso-8859-1?Q?CHqowYYyqXq3ujV9K/NWgn/erpgPmrmebiLRNEhr8L55cg+XuhxXU792Oc?=
 =?iso-8859-1?Q?csQxuQacYEvWKXAaSBwvB6PcS2aN7wpqEZQgV0I+tgpr4t0iUsbGLp1np1?=
 =?iso-8859-1?Q?QoEG/+MeZCHIZDhuNHZx4eQmPZAhxmq6t8jjB6RjphfjWukDn4YnGAA4WA?=
 =?iso-8859-1?Q?FY9L6IzauzKK5/64RUc07GNUEI5R53m1e+v9WA3mwNxn3DkhIBeu8J52KB?=
 =?iso-8859-1?Q?5QDhan843/140qRDBS+HDvwSfAHsHUt9A/auqmDCk2QEPbxwzN+YOtBUce?=
 =?iso-8859-1?Q?C5tfpi1o/VkyapFFH8/ZVXIS0xdb+7P4QFzSv8Z4gdJIlereNp8t4dXM2T?=
 =?iso-8859-1?Q?10nR2Fv9yhUtLDWMAQEWS/JFW3wClC4c91J/Q4x0qM+C6jFn/PrDVPOzxv?=
 =?iso-8859-1?Q?1S1bhutDKYMpcD8mPbU22a9bg7Wbh2w2NYRNBg+QvsJ90hKepEByTEB4Yq?=
 =?iso-8859-1?Q?sTJIpcSnbcpVCeDNMrp2gvJwNaVcCHxHLdxBdRKzY4Dgr6O1qd5xoOtRsT?=
 =?iso-8859-1?Q?i84vyupmDKlQPU8IFNdVKzqEZc6xAjZdYhuzku/ecwaQ/IZIiB3zrOK6Xt?=
 =?iso-8859-1?Q?tDvRnI5xQk7xQAme98XlkuYfQ/0AGdwqvl112dy1QfUDLkGGe4Y+rFxCBl?=
 =?iso-8859-1?Q?tazqoWono9BqY8oTEbgd51n0tSemO1hsSDNhHXD56EyaeWEZy6JZc1VNsE?=
 =?iso-8859-1?Q?xB3tYuoWsk9nuWr1VBPSt/YCNialc7XY1TJN3JeZ79w5UceBH7JbVj7ndG?=
 =?iso-8859-1?Q?TBRMydLSqmCt+ULuf/+qralL9QxPaT0mtrUyNl9vZRB0FIjVvs4tS9w2JT?=
 =?iso-8859-1?Q?3pzDh9JE0nLrcMYDtYQWnfAh9XHvYwHJIDg6XszJMwj0qG7Mv/2c46Bx3R?=
 =?iso-8859-1?Q?cvNYCGCctdjQQccMS9gtOD6Gt4xZZjF6HAMnwoDzA3I5C1m7YcSJe/4dIi?=
 =?iso-8859-1?Q?Yx7Y/ftH/thtrJdn04mqcUpkfYu2bWbFGqkwHZvVR+/52+2awYLEFAnEZP?=
 =?iso-8859-1?Q?7V37Pi1B5p5hVFLlbHtBJh8qzTmzlJvsFnecs0o38Pck0Q4Xwne2vrMl0R?=
 =?iso-8859-1?Q?I03t6rOt+g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JRw7Wx+nO5qlfS52kOi42t4U4FL1vFcuDdTVwKaDJdyKMtIIboVvR6exN6lcTF1BDlTFELV29hUTA85SShFlhAyTAFm1xJuqXXMffaiuPxD6OC2DOpNie1aXvhFzHAkuw92saEHZGrmhwPfyWWOWLLeJmHpbVH21yqzHDuqqFwjA9LGgtMGmMp+SNnWbjd43MRKAExHxsQq6eKfXh0W74v+CY1+AUqv6FYCPONW3hD0H5gKG+KgF0PygP2Dd3ijPCvaG2sSLNA9pf0un+bmC8VTwJjacDtE2qCfKLMwyTPSJPi1sJFm2eMsGp4ztS+Ol2+1o6GKCm1YbBLuxMvZq6w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4f99ae-2141-4976-a164-08def76df527
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 06:01:16.9418 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lD+EBdYobZwPijG+5OOCuZs0EOw0kjeDYVCFZm7PUJ8OHHyAKoaYqWTyDlH/bj8vrSdiZaz6waQmUW310FrodnX8AZJLn4VJY//YZ9bLKEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF7489084AC
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The ASPEED HACE model only emulated the hash command; the crypto (cipher)=
=0A=
command was stubbed out. On the AST2700 the kernel runs the crypto driver=
=0A=
self-tests at boot, so without crypto emulation booting floods the log=0A=
with failures:=0A=
=0A=
  root@ast2700-default:~# dmesg | grep "self"=0A=
[    6.078446] alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=
=3D-22)=0A=
[    6.079295] alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=
=3D-22)=0A=
[    6.089924] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes fail=
ed (rc=3D-22)=0A=
[    6.090629] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes fail=
ed (rc=3D-22)=0A=
[    6.100134] alg: self-tests for cbc(des3_ede) using aspeed-cbc-tdes fail=
ed (rc=3D-22)=0A=
[    6.100416] alg: self-tests for ecb(des3_ede) using aspeed-ecb-tdes fail=
ed (rc=3D-22)=0A=
[    6.100576] alg: self-tests for cbc(des3_ede) using aspeed-cbc-tdes fail=
ed (rc=3D-22)=0A=
[    6.101411] alg: self-tests for ecb(des3_ede) using aspeed-ecb-tdes fail=
ed (rc=3D-22)=0A=
[    6.152954] alg: self-tests for ecb(des) using aspeed-ecb-des failed (rc=
=3D-22)=0A=
[    6.153701] alg: self-tests for ecb(des) using aspeed-ecb-des failed (rc=
=3D-22)=0A=
[    6.180101] alg: self-tests for cbc(des) using aspeed-cbc-des failed (rc=
=3D-22)=0A=
[    6.180747] alg: self-tests for cbc(des) using aspeed-cbc-des failed (rc=
=3D-22)=0A=
[    6.206437] alg: self-tests for ctr(aes) using aspeed-ctr-aes failed (rc=
=3D-22)=0A=
[    6.206910] alg: self-tests for ctr(aes) using aspeed-ctr-aes failed (rc=
=3D-22)=0A=
[    6.215313] alg: self-tests for cbc(aes) using aspeed-cbc-aes failed (rc=
=3D-22)=0A=
[    6.215698] alg: self-tests for cbc(aes) using aspeed-cbc-aes failed (rc=
=3D-22)=0A=
[    6.227173] alg: self-tests for ecb(aes) using aspeed-ecb-aes failed (rc=
=3D-22)=0A=
[    6.228027] alg: self-tests for ecb(aes) using aspeed-ecb-aes failed (rc=
=3D-22)=0A=
[    6.276878] alg: self-tests for gcm(aes) using aspeed-gcm-aes failed (rc=
=3D-22)=0A=
[    6.277541] alg: self-tests for gcm(aes) using aspeed-gcm-aes failed (rc=
=3D-22)=0A=
=0A=
This series implements the HACE crypto command: AES/DES/3DES in ECB/CBC/CTR=
=0A=
over direct and scatter-gather DMA, and AES-GCM with 64-bit DMA on the=0A=
AST2700. It also adds GCM to the qcrypto cipher API (gcrypt backend) that=
=0A=
the AST2700 path needs, plus qtest and unit-test coverage.=0A=
=0A=
With crypto emulated the self-tests pass, the warnings above disappear, and=
=0A=
the temporary 'cryptomgr.notests=3D1' boot workaround in the AST2700=0A=
functional tests is dropped.=0A=
=0A=
Note: the GNUTLS crypto backend does not support AES-CTR mode.=0A=
=0A=
v1:=0A=
  1. Support the crypto command in direct access mode=0A=
  2. Support scatter-gather mode for the crypto command=0A=
  3. Support the AES-GCM mode for the crypto command=0A=
  4. Support 64-bit DMA for the crypto command=0A=
  5. Test the crypto command=0A=
  6. Drop the AST2700 crypto self-test/model workaround=0A=
=0A=
v2:=0A=
  1. Add AES-GCM to the nettle and gnutls crypto backends=0A=
  2. Skip crypto tests for cipher modes the=0A=
    compiled backend does not support, via qcrypto_cipher_supports()=0A=
  3.  Check qcrypto_cipher_supports() before running a=0A=
    crypt command and report the mode as unimplemented when the backend lac=
ks it=0A=
=0A=
v3:=0A=
  1. remove the duplicate CRYPT_IRQ_EN definition.=0A=
  2. remove the unuse CRYPT_CMD_DST_SG_CTRL definition.=0A=
  3. Drop "Drop the AST2700 crypto self-test workaround" patch because GNUT=
LS=0A=
     backend does not support AES-CTR mode.=0A=
=0A=
v4:=0A=
  1. Add GCM tag mask=0A=
=0A=
Jamin Lin (16):=0A=
  hw/misc/aspeed_hace: Support the crypto command in direct access mode=0A=
  tests/qtest/aspeed-hace: Test the crypto command on the AST2500=0A=
  hw/misc/aspeed_hace: Support scatter-gather mode for the crypto=0A=
    command=0A=
  hw/misc/aspeed_hace: Support the CTR mode for the crypto command=0A=
  tests/qtest/aspeed-hace: Test the crypto command on the AST2600=0A=
  tests/qtest/aspeed-hace: Test the crypto command on the AST1030=0A=
  crypto/cipher: Add GCM to QCryptoCipherMode=0A=
  crypto/cipher: Add setaad/gettag for AEAD modes=0A=
  crypto/cipher-gcrypt: Implement AES-GCM=0A=
  crypto/cipher-nettle: Implement AES-GCM=0A=
  crypto/cipher-gnutls: Implement AES-GCM=0A=
  tests/unit/test-crypto-cipher: Test AES-GCM mode=0A=
  hw/misc/aspeed_hace: Support 64-bit DMA for the crypto command=0A=
  hw/misc/aspeed_hace: Support the AES-GCM mode for the crypto command=0A=
  hw/misc/aspeed_hace: Enable the crypto command on the AST2700=0A=
  tests/qtest/aspeed-hace: Test the crypto command on the AST2700=0A=
=0A=
 qapi/crypto.json                |   4 +-=0A=
 crypto/cipherpriv.h             |   8 +=0A=
 include/crypto/cipher.h         |  36 ++=0A=
 include/hw/misc/aspeed_hace.h   |   1 -=0A=
 tests/qtest/aspeed-hace-utils.h |  20 +=0A=
 crypto/cipher.c                 |  32 ++=0A=
 hw/misc/aspeed_hace.c           | 461 ++++++++++++++++++++-=0A=
 tests/qtest/aspeed-hace-utils.c | 693 ++++++++++++++++++++++++++++++++=0A=
 tests/qtest/aspeed_hace-test.c  |  18 +=0A=
 tests/qtest/ast2700-hace-test.c |   9 +=0A=
 tests/unit/test-crypto-cipher.c | 240 +++++++++++=0A=
 crypto/cipher-gcrypt.c.inc      | 101 +++++=0A=
 crypto/cipher-gnutls.c.inc      | 154 +++++++=0A=
 crypto/cipher-nettle.c.inc      | 128 ++++++=0A=
 tests/qtest/meson.build         |   6 +-=0A=
 15 files changed, 1886 insertions(+), 25 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

