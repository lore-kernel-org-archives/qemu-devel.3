Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720CFC79F9F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3VWW-0002Re-SE; Mon, 07 Sep 2026 05:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3VWU-0002R2-KP; Mon, 07 Sep 2026 05:20:18 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3VWR-0001gO-H3; Mon, 07 Sep 2026 05:20:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5clY+ekMx/XwowQPMRMIdZVELfm8mDPihB2miVTVGYIdcxlXsvgZvtZkMz6hARiNU5QzSpLEoQJy/cbBnHqfb2SesEeDp/LsWmc7orAj8ZJoDbNJ9oeJPm3QoN+ydF2G5NJS6yKeJrcZpO18E4+axXtxLZigYbxk4i0YoDL40oNmDQNpRm/NNj9Qwa6YDc6sIb45vwSheL1tCnmB9LN0URA3WQC3h1TxOLl/+0hE5wjwzysPYl8+QJJ/a2COr/MIrP+WM2ySqd4zITujJ2bahYS97dBjIh5aWrYosMgKOBVN3UGTIJtTVeZAAOv0pH7DTMRZglTKC8K7MUFq/v8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOtzIR7CElL1PysY9051ex7IjzzFbSbI2qDLIVYoUp0=;
 b=KjEpgZmvs+TIQQFFE4YePPqEkvLGWcUCK6Q8aNNXNudw9yY83PVhQJfVEdagQ22CYBvI6EwPEVsLi3/M3cPrVNW8qewaA4RAQi5hWo2PvqHNAK7algjaAFsSkxMalRZeG7rNhVtyWiQF6vq7mamfkNXMkJuimRPj1ujFjiSN71XbCagCj60bE1dvswFBBwWDH6ey2W7b4hoMWbmhWG/JrLisnz5yTOGQtnOmLLvRxbIoAlQvyBKcsxS36dhuvt72gJ/1cL8Nq80JpH0RHod/EEf20HYsk/RQoVd4xKS+Bk1JE7KGkRwgd3bD3Vi4j/rbQmT+pVWseyiss6rb/guSeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOtzIR7CElL1PysY9051ex7IjzzFbSbI2qDLIVYoUp0=;
 b=BXNWR8eaxkeaBQ9BXA7ac5xG2ZvblXycGzQ3Y7rKci6Xm9GPPG0SO7GMH5kIcrWzPbJcZ5ZIcsZ4TFmlBKbg5G3BuHe8YbyiHGrRlF4La/zozlyInol8Mb1NAVCjqDOQhmVzRcVi6yRlN+VLmYSl5/L/atLW9wrY6/vgjo3hjnkPx7f7rECZH+qf3tXKOiOL/Qs/7pKKaj7fro5wVoAyUB854m0Np7dmgXhcfX/1GHc9JUn43F61/gTrkPojkLkV4Aa3JVb+bF7V2hZWYxj0o3oloLZP0Ezk8MtQyFRVVqw+ydLkUN3DOZgES42D+Ehi7kca31e8DgZyFomR7Y9nqg==
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com (2603:1096:101:3d::12)
 by SEYPR06MB5301.apcprd06.prod.outlook.com (2603:1096:101:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 09:20:05 +0000
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c]) by SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c%6]) with mapi id 15.21.0382.012; Mon, 7 Sep 2026
 09:20:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 0/7] Add ASPEED VGA PCI device support
Thread-Topic: [PATCH v1 0/7] Add ASPEED VGA PCI device support
Thread-Index: AQHdPqoR3IZRd9awgU+QWbqGcBahqw==
Date: Mon, 7 Sep 2026 09:20:05 +0000
Message-ID: <20260907092004.2590015-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB4989:EE_|SEYPR06MB5301:EE_
x-ms-office365-filtering-correlation-id: edc7cf73-8470-41f0-e703-08df0cc13425
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|921020|38070700021|3023799007|10067099003|5023799004|56012099006|18002099003;
x-microsoft-antispam-message-info: kHNWhHTtuQsiWPhdupGmXtsiVIVpwIxxmZ4VQTFlKJ+QeV/bmpZ4yxwtgc52Z+ZqQgjV7v75pi0exHrgdXYr4avv+I6ibFUQ70WUZ77BKtlH1KNu4dIRNGmCnRyZ1lt4SRNKOPFm4SEFggm1yhPW4vKi64M4hr0Tqf87XN2m0KwbEVIt4u8DNecHeoFCjrF/5QK10qJaDKncIrLSInqdCB1EF1qtosYCcwZW6LUc1cgkCTei/+CyLx6592paTEMMMb4X5+5O+DhpNMO+0zp4S6l8zq8bVP2pbUXexo1IQLug3NTW4C7jcQT04CXi1b6upu6Uz4wI78vGR8r67ncDpsA/v8CIgRiJ8Wqzi9XLKtb9t9ucOZXr2BEaKJ8NpsjJ8xC7BAHVPn3h3HnkJ3S/55np1x1IqOPKOTqz3uHPI8gSZBWIfcnzuJw9SySAr9M6pE35qtTWiSqAKDuSKsoU+SnVK0Y4Z8/jtYdKwV3W5x6yrqi13Ser8sFYCyIn7WP/3/kZhEqjT7/kmKDvPkrq2zasGjcZgkoLGWKiFh6ymZVFS0DXN/Eh94rt19d8FKLraGz4jB/wkzDY6aapyByDNQwK2kGYVA8ZvfeJSkxD2ptYSJ0lauKxz/vkGdykasqvlMmXpcyVrhOqjZcxWrTk7CL1YvdT5WOicIX6ErPGUbHQ3oMQ/Bpj7yflbeVp94Vn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEYPR06MB4989.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(921020)(38070700021)(3023799007)(10067099003)(5023799004)(56012099006)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ezlymR25efoiU0TEb7Urj1mundXsUQ8Ys33SnHo44MEPPX+pxCEzDDzJNH?=
 =?iso-8859-1?Q?Zoo/UNwKVUrvfYVI6XeoJv+2P7K4V4lYBUKyuoyF2acFUzckxty9IZldpo?=
 =?iso-8859-1?Q?JD0VEp4LuFrG0zOEIGqDPo8CXmFWJDnuY/uV+ochXX4oy4TpBJUn40Sxma?=
 =?iso-8859-1?Q?iZlHAGxW9M1axrS4hsm2a/dW/DsJOQC2r5A8a7PLhIyfXQ7px36908neNP?=
 =?iso-8859-1?Q?8w6zEGY5CjwyTOn1Gx12ZbbnAucj0MoQ1lqyKKGBaE2RsptSXYdPqSJgWY?=
 =?iso-8859-1?Q?krHcdOYZzunJSWsbyYCpuwbQ8q3A2+5/U4SG2EbvzCKX5Eh4qN+KpAm8JM?=
 =?iso-8859-1?Q?nVRJ98hbDuQtOKkJMk7M21EJYL75MbHrjHr/NtAR8Oj5I1AG0YZbEQeciK?=
 =?iso-8859-1?Q?Cps4tR9NeCkz2oZNjm3l3p4IA7pvA32VQRbhCNsVLj7CNKhFkIU42N2ni5?=
 =?iso-8859-1?Q?FRJD2aAg+d2KeH1JoaduSqVwlqmy2703UhzefFjMJC7nzuqXw2jnLwr1fO?=
 =?iso-8859-1?Q?nlAicQ4XcDyzHIb2xJ4cE33UPcYccACHChIGKO0nVXpcsN996rhDbR09C6?=
 =?iso-8859-1?Q?GPQpfNmZ6Ak9q5qZ4p6CZW1oABEGDa0irj1dhnbkY2DKNyGCkLffp2HJZG?=
 =?iso-8859-1?Q?ZG2NP2eDQtmZvjXZthZvM1eSZXO8FMI4p7LbNZw/ZoMqEnGWka4EGPh908?=
 =?iso-8859-1?Q?mZqvF1aL/3JBo4SqLTAk73cp1B9Pxf8KeYyp/5YSWykl4iegvrriqTyU6I?=
 =?iso-8859-1?Q?8SggQ5Eiwy1sKD99QVoZY1gsBma6an87jcRYv1NSy4/PeK5wH988VyuyaM?=
 =?iso-8859-1?Q?25TvThDczNh7vfHWx+rA56oF82xRaF/zbN6uWnv2FXziYS/YI49C/Jl+c4?=
 =?iso-8859-1?Q?pVNhBA0cv1Ub/TXAFMV9cD4vMGgbB55OFItNnTk392CSS3fEZhMalAtWaE?=
 =?iso-8859-1?Q?A4Vf7Au1NxCdBXw1Lt40pQ9S1vQWbw0jm6IVl2JdqLVkaivuUh9/PmwP7i?=
 =?iso-8859-1?Q?my0s78C3Ku48FGpU6P99AduqhC7dQMmiJfXMLXTgqlt8/jsCRUtN1nhrTX?=
 =?iso-8859-1?Q?qQA1wWlZlygpLfJw683QFBM1PbJtbORrmnbv0fDzen3Cymjlydf8Z0umLa?=
 =?iso-8859-1?Q?4encDgnERuKq0CA4xyLvT4+TNydOfFmm8+DnQ2Zzw3h87hf/DZRoiPxNnv?=
 =?iso-8859-1?Q?A0UbWrizxqY80r0IBrBLdMqBn4uCAR9bBTZb8JGBu7ieiSlxr2NCSIn4CM?=
 =?iso-8859-1?Q?Ccoi35o7CGHIpymW+FPmAazhZEJGKdsDN5AuaPkwFlNMY3CohEx7/P4m3G?=
 =?iso-8859-1?Q?XfsUuJhRLqc89xSl3aYFL3ywX/3eLCeFl+XkBvrCqHgmGcHS5NZxd8R6m3?=
 =?iso-8859-1?Q?pY6Ig3BEj7yK/JY8kOLOQ6hxy/PD4ae5oSWooba7/D8iE9p8hP/6kJx0gA?=
 =?iso-8859-1?Q?qiRssLsFeXHVweywzXnrLTVFtucGDsEeoQAItEEdbdS1UVmOdhkf1Djjx/?=
 =?iso-8859-1?Q?AExA4ThC35+Y2Pxd/UCTspG3uyJeS/x0PjaKkPbffrwXeWTJLBHlAhyggf?=
 =?iso-8859-1?Q?YYjt5hbbXOz2TxgQWR8W4NrDh3f4SIB4eh5GNb6ryOwADosZYYyM5GoDGs?=
 =?iso-8859-1?Q?AeItcf3xuqZBRNPikrfJRmKULZjlA8erYXQTWcx8h+LrU1uY7L2cGDTRWn?=
 =?iso-8859-1?Q?eBnKU+N3fA9U7/w0C5sXHt7ABPPVUblEf+bu0M1KOw2N9tyJQl5T8dP64w?=
 =?iso-8859-1?Q?445kjc01LdKVFN4iLR3FOYG82vKYjq3PN1UUkGH1t+TU9MaUpYokrRMzRo?=
 =?iso-8859-1?Q?4T5Q7jpVww=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IxJ5fu89sUuIgDtDufv7dLCjVo3A3J8IzVtSyTLP9ThHUSkAOIq4j9MCe977C/mg2OWeLvo11wHAvH+RLre0cgYAfVAk2OeINWIYOWw5RBkG+CHoSq8kc9hhe2ctGs+Y+DSXsp/EsoS8idqEDU1xrp89L6oY6BLH0updPeJVIYu7isOYv8uBQEDaFeShr+1vNSAME6jlmM6MuDYct9qLob9bdyTiLxHSHCs8lZTzZDZE1YfeAnfwJza8/gZteLqAMbMk6us3kRbhavMbQTx1u7ZnS6ynM4cZp02cQ5MBY/ysHaKdj0O3GRXm2sUSvduOERJ7jOlAt2vl+FsYIrjWGQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB4989.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc7cf73-8470-41f0-e703-08df0cc13425
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 09:20:05.2447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQYVCLHM34jW5XrG1K5txRsYGHOKXwjJwIrVWVKkaWfyJ3bdcFOumFY4xJvuVSUbRP0EAZDDWLU97bbu2Bo6d7SbMDRuiM+7IzKYz3pAX3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5301
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

This series adds support for the ASPEED VGA PCI device found on AST2600=0A=
and AST2700 platforms.=0A=
=0A=
The longer-term goal is to support the video path used by BMC KVM=0A=
applications. The planned implementation consists of three stages:=0A=
=0A=
1. Add an ASPEED VGA PCI device so that a host system running in QEMU can=
=0A=
use the ASPEED VGA device as its display adapter. This series=0A=
implements this stage.=0A=
=0A=
2. Back the VGA framebuffer with shared memory, for example using a QEMU=0A=
memory backend backed by /dev/shm/vram. This allows the framebuffer=0A=
contents produced by the host QEMU instance to be accessed by another=0A=
QEMU instance emulating the BMC.=0A=
=0A=
3. Add an ASPEED Video Engine model to the AST2600/AST2700 BMC machine.=0A=
The model will read the shared VGA framebuffer and emulate the video=0A=
capture and JPEG compression path used by the BMC.=0A=
=0A=
The intended setup runs two QEMU instances on the same host machine:=0A=
+-------------------------------------------------------------------+=0A=
|                         Host Machine                              |=0A=
|                                                                   |=0A=
|  +---------------------------+                                    |=0A=
|  | QEMU 1: VMM / Host Guest  |                                    |=0A=
|  |                           |                                    |=0A=
|  |  +---------------------+  |                                    |=0A=
|  |  | ASPEED VGA PCI      |  |                                    |=0A=
|  |  | device              |  |                                    |=0A=
|  |  +----------+----------+  |                                    |=0A=
|  |             |             |                                    |=0A=
|  |             v             |                                    |=0A=
|  |  +---------------------+  |                                    |=0A=
|  |  | VGA VRAM            |  |                                    |=0A=
|  |  +----------+----------+  |                                    |=0A=
|  +-------------|-------------+                                    |=0A=
|                |                                                  |=0A=
|                | memory-backend-file                              |=0A=
|                v                                                  |=0A=
|        +-----------------------+                                  |=0A=
|        | /dev/shm/vram         |                                  |=0A=
|        | Shared VRAM file      |                                  |=0A=
|        +-----------+-----------+                                  |=0A=
|                    |                                              |=0A=
|                    | read by                                      |=0A=
|                    v                                              |=0A=
|  +---------------------------+                                    |=0A=
|  | QEMU 2: BMC               |                                    |=0A=
|  | AST2600 / AST2700         |                                    |=0A=
|  |                           |                                    |=0A=
|  |  +---------------------+  |                                    |=0A=
|  |  | ASPEED Video Engine |  |                                    |=0A=
|  |  |                     |  |                                    |=0A=
|  |  | - Read VRAM         |  |                                    |=0A=
|  |  | - Capture frame     |  |                                    |=0A=
|  |  | - Compress video    |  |                                    |=0A=
|  |  +----------+----------+  |                                    |=0A=
|  +-------------|-------------+                                    |=0A=
|                |                                                  |=0A=
+----------------|--------------------------------------------------+=0A=
                 =0A=
   =0A=
=0A=
With the complete implementation, users will be able to view the display=0A=
output of the emulated host through the OpenBMC KVM web interface.=0A=
=0A=
This series adds the following devices:=0A=
=0A=
- ``ast2600-vga``          Aspeed AST2600 VGA=0A=
- ``ast2700-vga``          Aspeed AST2700 VGA=0A=
=0A=
The size of the framebuffer aperture is set with ``vgamem_mb``, 32 MiB by=
=0A=
default. The device comes up with the standard VGA BIOS; pass ``romfile``=
=0A=
to use Aspeed's own option ROM instead, which can be downloaded from=0A=
=0A=
https://www.aspeedtech.com/support_driver/=0A=
=0A=
For example, the AST2700 VGA device can be used with an `aarch64=0A=
virt` machine as follows:=0A=
=0A=
  $ qemu-system-aarch64 \=0A=
        -M virt \=0A=
        -cpu neoverse-n1 -smp 8 -m 4G \=0A=
        -bios edk2-aarch64-code.fd \=0A=
        -device ast2700-vga,vgamem_mb=3D32,romfile=3Duefi_arm_2700_vga.rom =
\=0A=
        -drive file=3Dnoble-server-cloudimg-arm64.img,format=3Dqcow2 \=0A=
        -device qemu-xhci,id=3Dxhci \=0A=
        -device usb-kbd,bus=3Dxhci.0 \=0A=
        -device usb-tablet,bus=3Dxhci.0 \=0A=
        -display vnc=3D0.0.0.0:0=0A=
=0A=
The disk image is an Ubuntu cloud image from=0A=
https://cloud-images.ubuntu.com/. =0A=
=0A=
The output goes to the VNC backend on display 0, which listens on TCP port =
5900,=0A=
so point a VNC viewer at that port to see the screen.=0A=
=0A=
=0A=
v1:=0A=
 1. Add ASPEED VGA display controller=0A=
 2. Add the hardware overlay cursor=0A=
 3. Add the 2D graphics engine=0A=
 =0A=
This series implement goal 1     =0A=
Jamin Lin (7):=0A=
  hw/display/vga: Allow a device to report vendor specific blanking=0A=
  hw/display/vga: Move VGA_HPEL_NEUTRAL to vga_int.h=0A=
  hw/pci: Add the ASPEED VGA device id=0A=
  hw/display/aspeed-vga: Add ASPEED VGA display controller=0A=
  hw/display/aspeed-vga: Add the hardware overlay cursor=0A=
  hw/display/aspeed-vga: Add the 2D graphics engine=0A=
  docs/system/arm/aspeed: Document the VGA display controller=0A=
=0A=
 docs/system/arm/aspeed.rst |  37 +-=0A=
 hw/display/aspeed-vga.h    |  61 +++=0A=
 hw/display/vga_int.h       |   9 +=0A=
 include/hw/pci/pci_ids.h   |   1 +=0A=
 hw/display/aspeed-vga.c    | 945 +++++++++++++++++++++++++++++++++++++=0A=
 hw/display/vga.c           |  11 +-=0A=
 hw/display/Kconfig         |   6 +=0A=
 hw/display/meson.build     |   1 +=0A=
 hw/display/trace-events    |   7 +=0A=
 9 files changed, 1067 insertions(+), 11 deletions(-)=0A=
 create mode 100644 hw/display/aspeed-vga.h=0A=
 create mode 100644 hw/display/aspeed-vga.c=0A=
=0A=
-- =0A=
2.53.0=0A=

