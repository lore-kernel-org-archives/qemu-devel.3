Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5536DCD37AA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 05:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLDZk-0005FK-BE; Fri, 08 May 2026 01:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wLDZh-0005EK-CC; Fri, 08 May 2026 01:16:33 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wLDZe-0007Tx-MW; Fri, 08 May 2026 01:16:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydpqLBw4kWSDqImmXESWgt2ENjsArr/oIN+0YlXS+ngHHqxl4JRxAgILSJiwbazI3BlAIJAVVJRCVWpIRwik7IL8Ox7vG1W+yAj9z13jU4CdJUUqTqpiEQl0Vmr3vlnCMy37TjPFNqMtMVC8Ms5voNaAGOSU0kLvHbx/BdhZ8N0Hy+x9ZpThVxvotzFgBK8UF6Pel/TvLdc2o5u0p5LNPcbbiyXi5gWWBDWVAUkLQxsPGYUCukB9ns2ypScvvBjtdrC/HklI9iz4mrVnUDeQG31zfE51/vNNvxaDERYXT8jJ9Seqv9w0ynqse1W2Gfd4aWAp0s5R0ie4R283eKKLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at7CwJWLkSICjdvnVr1yT+FYaUEDpsvsL1eSkzG9dmI=;
 b=hGq5zNxpmybUKdgOXtUXnsAlf2iq1FxLfJzFlrK3DUKi/cNgq/SYoMLCV8sjY77AhR4kH9g8iu+a223wulnA+2y22WZiJgR0lIru4MQ9k06NubCcvU/5aW3O4GSlT8oO4hQuxXi9KGmCeY7GqeTBWUGKaFP1XbZNk7ZfsByioJ2cwD4Q/fBQjNWzCZxRmqKw6nYS/EfATRvv/JABCJJBlQyvN6hKnaDTKSxGwDEmUm92S0u7fMN/ZIgkmDRZQYjGYKUlNyOQnPpp+P+/Gd/J9AEVwqwHmlqHT2TNudsZnK3XemszLYS4tw6w2fv8DIHVlyfzuNZlMn2tNGMiE1w6zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at7CwJWLkSICjdvnVr1yT+FYaUEDpsvsL1eSkzG9dmI=;
 b=GO4NjcFvDEZ75OWt4+0IyQ9rWGpPjOnBbu93Dbx6aB+xwk7qyx4P2gdBMiWgfLSmjjIDCh6YDThG60eiwEnVaHiAFeGFFW5eQbt1BMG/o+OOPFDjwMX2QwOwR3S5gkAdi1hPwdPk80/7R2hfRtlTLb16YCUUy3HEqLWJ114V8Cq24D1VqbbECSo4cVUAuLLg7YnYUiLzuCaOYYDAD74hUampTx//4MczxAG3oeub+ybBDos+vOZ7QiUnuWyD1ibCSq74JrbqaeZXvF6K4knhYMCIxj3xtq9AjkA/7L27J4UNsU6fZk4LCn5S/5neZN1v8Pg53H1164LV8i9oEOM1xQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by PUZPR06MB5885.apcprd06.prod.outlook.com (2603:1096:301:110::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 05:16:20 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 05:16:20 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 0/1] aspeed/hace: Fix mapped address may not be unmapped
 issue
Thread-Topic: [PATCH v1 0/1] aspeed/hace: Fix mapped address may not be
 unmapped issue
Thread-Index: AQHc3qnODjnafroHF0aYs2O+Fxx0jg==
Date: Fri, 8 May 2026 05:16:20 +0000
Message-ID: <20260508051619.3887383-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|PUZPR06MB5885:EE_
x-ms-office365-filtering-correlation-id: e94255fb-afc2-4a43-3839-08deacc0f0cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|38070700021; 
x-microsoft-antispam-message-info: F4IGHl1kHOtYpUse4XumGio/UhxgQ/T7kiVbvJpQWEyJNiwNL2L4ydHDy+53/NGRJMUDBKeknDyCeDI4OArT/HooUfpxb/VfdW7G4mkgT7ZL4E6JIS0K/mbgrLNzyRZHHPuRF1WlwbW9A9YCZsHwpuu27/TTnUz2dvbcu/qgyZmPOBXzy3RyZvifTJwp6v66m6Dr3lDTod7O5SKMKI1epKr5/6HqpxrIlmAdEXU9qlLjkyzNzw5HOS0AEvmOuL3UyALEOxtTy9yq7yEHLFQTeQtpRWmcDZKKrUZU+Cyu2OUZ06sf5RZE3d5OJq6PxxXrC4ZR4KhmwkbIQgb0/a5R9t639FPR3BO4G0UzCkci9txaSReT8TDvIHm15iBqNpd+ObdCB8LKixUUQxzUj/YX6pxpc43ImU6ToesfAliXP+eNg/OVNV/NvwWE9YjU2xIxF/XrciweQklEekSTj8HGhZGxGqbie2fwhHWN60fIiloTXrbv0crymaG3FqH5aSSQp5EmLAqvKo+qRCJjCTAYXWUdbXpYUHsyXunFNSCRsNN7AAMsPkmxq2xC0eHfUcBwLhcrNwNUxBvusgeU0auwFH4r+cPu9UUJLeNrteU0Tu1Pp2ndn82pM7Nlbjpg9XHR61fFRfb2VQfxMiXroQ7J45gGGK5ZFqtiihyncFhEwAfwp1qqZelDtqR4Fqcvn+Sth/9+hwE21jL2Bo0+NHfx2A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2tgpiHuJsVsw8vgQHB7EJVezq5X+t79OMUo/CTRoahP6hvQq4Gc1ivmiBq?=
 =?iso-8859-1?Q?LMO8uUfFyitls7iTivsyccS6+fSevh42iI/3vKC5IhGu3aTV/ySywBDLER?=
 =?iso-8859-1?Q?T+UFY073qYfYbE1QixEt9sAiiK7tVEmJgHsPLVGOmInAWY0rezberMuLMK?=
 =?iso-8859-1?Q?JMQzuI5THpe3aUK6/QKCcSeKtDqJpwJLyPkofl20NvZQXK9HucKtEB+qb+?=
 =?iso-8859-1?Q?/c6/Z/JsBmpMBDfxEwHG6s3oUB858VO3Ck8h5AC52j7SFPTeLAyPy95Tab?=
 =?iso-8859-1?Q?6zzIrqMtTFRMtLj3/r81ANyXwBsEjfFBUj4tvZGjDjnxPvxajrh7D5MVm6?=
 =?iso-8859-1?Q?6/nRLa7EMyJaPnuO/Kcm0H8PGZKQGlKDIuextNKmVDmdLm84dnk6c/+cHk?=
 =?iso-8859-1?Q?wXMBFTVp9kSTDeFU52a6X69zdSp/aNkfbAViSZot8bN6vjp2ACbJQwdqGc?=
 =?iso-8859-1?Q?n/9wIlx/qFTIoNEK1u5wIY0R+8MM5oyoeBPktyanYVEL9g7HAr4aGRVQho?=
 =?iso-8859-1?Q?UNLBunk3jsuV347769aPy2LyZoYpvK6tBdzKBJGPU0trLg5KdQIVQat58S?=
 =?iso-8859-1?Q?aFtEzObXnkjpYU1CqHrBSdJk9vrAf3YZn/v6EN8FSxu6gIA5+OX1HUc40o?=
 =?iso-8859-1?Q?FpdDpoNKMqUJbmHbdU4EZ3NpNXEFTIwqd3wQpmToXOWpuG0H+CPUt8shI3?=
 =?iso-8859-1?Q?Ti4/hDlm8xiHifZ7g30qP6PNtGj+ELEeuW2KmWm1DHCODQy1v/mFzPRR32?=
 =?iso-8859-1?Q?qX4WBCn2LHEfg9lRqsJ4eb60hGChI06+0eryUtUEYYNfLTcHcRb19GmJlb?=
 =?iso-8859-1?Q?qGGLtoGess57odjy0r38IX1w7v775YwiGCu7gz9yAtbe89Hcf4MyLq6Am+?=
 =?iso-8859-1?Q?UU6j7IYuF5tu7miRHAsb1JCMnqCd5Yet+jmIyxPkmqDKLIEO0ce19RKg8j?=
 =?iso-8859-1?Q?NiFRSDGwqUJjM+RuOfo1PcWpdOHnWCM1sCrHSFXYH0cGUTHGs+pSP6+2VJ?=
 =?iso-8859-1?Q?kTO2ZLHcZIlrF4MkutF8OOF5oCmK0SS8WidqvSldGVGdFPktuP9fhyPp9D?=
 =?iso-8859-1?Q?DDSZ0Gb+ZdAGfzeHUkVzsju6D9cDeGdNi8b8x98XlqbpS/I4PWSI8EkDcb?=
 =?iso-8859-1?Q?VAVxdPhUHtcqzKF4DAOAtJE1R0waLuyhmC0mQGrFsq3Cti5u6bG5fUq/Ex?=
 =?iso-8859-1?Q?JoTkVLTuxUlS3cgwmi6ohbSVegEPE9wJBKbOHhpDW1wCR6Cdx3x6Cz/7UH?=
 =?iso-8859-1?Q?Ow29rfNXVuO9NfyWXfYMnoG877U28zz2BGUJO5Ta/TsxioiNAuk9WGlOuV?=
 =?iso-8859-1?Q?jK3JLxFNiKaj1W9xjyE0oe0oHLzQnKJnFWyRLjEJ0h7J15LZ1cbEgbbCwb?=
 =?iso-8859-1?Q?534V/crRIjW9Vpv85k5rK9V+8tCQLLtUucKNBmvi/vv5iJDlVc0FlscavI?=
 =?iso-8859-1?Q?Px2Mk2nrZ4G76mSbUaYMpEmAB9VPOLCrU55/T7A1Sv4BEyGDYvkG5VwnkK?=
 =?iso-8859-1?Q?GOMFnJhrdj+HrLgJWXp8q74eXiK16d4ndqim2Dz3HhHrAIxxK/a2YmQFiy?=
 =?iso-8859-1?Q?Ta0NdLgUVBoeAyZIT9z7uQGIMQtnuY4xAcGDNRQAn05jROp8UejhMBl9Tl?=
 =?iso-8859-1?Q?D5q0xUK0uNphEnyx7dgs6TtdbyE6RT+GEjJ3nDoRN8qWhxDMxcthztj0UR?=
 =?iso-8859-1?Q?B3axoSBSOktTEOYrY6OpbGmMM1x6QBIJGzxOg+PJRVqIm3b3SCMo4TfELY?=
 =?iso-8859-1?Q?8sop2xglJoBpg4tSf1unuIAuz3D4MJECk9YQhraxt+X4v0rOA9FhaxQFG2?=
 =?iso-8859-1?Q?cdSL99+S6A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: A8JbntFe/3hPFBfs/rKONX+EsUNqQKkUGv/FADi8iS8nD6PL3qSoEeQS5Q9p8PgrrssYdEdUuD5mkFVBVs3EQT12KJMKfscI0DiCjC2EtiqQvgQDIRgWCKDozvU6+/Y4Jj3jDRySJYooEYWtX2Ai8pcGXmKxF2mz5zxgWjic0Xu/SgkapVjPOBPj6/3apBI/AHFbgw07e3AUmLKr8alHBCZWEcOKlRSBeuHwicIbp8R9GXw0ICTDyuA1mCWVivjDAj9QS0P0al0uEclE/JF4cDC/AkoqKsU5KAiAt4nZIWNX0wLm0df9Xjlx6ZjOp6wukPLF2G5iniQpjy9m+a+H7Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94255fb-afc2-4a43-3839-08deacc0f0cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 05:16:20.6372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUzVutql9uFZxv6QYYFPs3wM2Sf9sFTw6vFKbDNOZZllBYqJ0/c1kZqbcwzHYNLquJl8fVHhyK5zUilAh/Nn28YPYexoYqzv/vLB+1NLN9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5885
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Dear reviewer,=0A=
=0A=
The Aspeed HACE hash flow may leave DMA mappings active when an error=0A=
occurs after guest buffers have already been mapped.=0A=
=0A=
Several failure paths return early without unmapping previously mapped=0A=
iov entries. This can lead to stale mappings and resource leaks.=0A=
=0A=
Fix this by introducing a common cleanup helper that unmaps all=0A=
previously mapped iov entries before returning from error paths.=0A=
=0A=
Additionally, track the actual mapped length of each iov entry=0A=
explicitly. This is necessary because some hashing flows may apply=0A=
padding during processing, and the resulting buffer length used later=0A=
in the flow can differ from the original DMA mapped length. Using the=0A=
modified length during dma_memory_unmap() may result in an incorrect=0A=
unmap size.=0A=
=0A=
Note: this patch series is based on =0A=
https://patchew.org/QEMU/20260504213421.710035-1-clg@redhat.com/.=0A=
=0A=
Best Regards,=0A=
Kane=0A=
=0A=
Kane-Chen-AS (1):=0A=
  aspeed/hace: Fix mapped address may not be unmapped issue=0A=
=0A=
 hw/misc/aspeed_hace.c | 63 ++++++++++++++++++++++++++++++-------------=0A=
 1 file changed, 45 insertions(+), 18 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

