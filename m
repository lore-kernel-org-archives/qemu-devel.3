Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CF0ECD9BC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCOc-0001au-W0; Thu, 05 Feb 2026 22:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO4-0000Ui-M0; Thu, 05 Feb 2026 22:20:09 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO1-0008HM-Ue; Thu, 05 Feb 2026 22:20:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2A8xhMYZtCYL1abCQvLTi+4cyFJ3kb8XOeYZxb6r1mo1pLjf/hUtcJQWjR+8DFRln5L9gefOabHjVgtYfO6aBZcBdKh1RxJNmb0zI+0JCQd+Dh9lNryVYeH8HqF3QkvpYrDIUV4XbnKRSbnq+bLcvTw87Iq/CBTtACryjZZaBwb7Xgler91J4mRXdzgKMEtuVX7wKJZbT5Vo1UQWS3oyRk3FohKfsXRA7YTq4qp6rt7nBwh7auvPSMKv74tUipGS4aLyHnSmFjjqBKDIt8CmPy6Gof2UCc5gSiZLLsJzSIoVUTsLalXQAow5q03Re4nRhHBp9uxuUQhhAMLbfEsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3Vyh9nMfjUlddy2WHRpBAPuYAohqFPPdut9xn61tt8=;
 b=lUgCnuUyBBYeOY5Dm2w0K3BAgZDa9I9zwB78vNAtOwXTrcbeEsTCtS+9HkWeqH6gqW9VMGCICXUNRT+bWArH0cOnNDSYgFmoIw9L2YnjY7yxU0+l6M9U+o06s+4/iowo55/DRP8DI6qRosND3juNVOLJxa9v1V9Rjha6K9C3NY8mRPOsMjZAjZBDLSwPEunv8xnffqnCxxZnn3wN3LzVX/XcKsmMldSzVTRKbaBCOa+KEINS/Oto2AFfDuzanda9mGaSy6igZHExOvG928N6080olcIUSQhrrv9XXVaOEhotc/Yh/nuWVGYQ/gKKYGayRafVy6bZQz+RL9C561cJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3Vyh9nMfjUlddy2WHRpBAPuYAohqFPPdut9xn61tt8=;
 b=Ex7xC4lRDNOpJywM9bjQvsA5NyMoSNPJ+MLekBK1DI5FasVGI9OfLl4vcjDRzzJD5d/ALT/R8Uaia8lZ/HubgCsLrYzxg6Bh3e75rv+s5thQlwFV1ain13q5dv8dtSROudqwgjrp6teQ8EYQsZn1cfrCL5XWh+OEEoHCnnR7tVI20YhtfSDpkEN4ShFYvZ7RQRoFT4n90JQmxXSzjY9flIfaUWTRedpAPfQNTnTJ4L3UVyNf432qhD1fHW2O7Ejqf4c7D8Bnh0XIt3OzkKzufXCRGBfCt6oIvjnosUuVUkawmOWCluNKCUCPvoCKhiiRTdDtntHyADbn7O6IPdMc0w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5762.apcprd06.prod.outlook.com (2603:1096:101:ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 03:19:43 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:43 +0000
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
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>, Hao Wu <wuhaotsh@google.com>
Subject: [PATCH v3 11/20] hw/i3c/dw-i3c: Add IRQ MMIO behavior
Thread-Topic: [PATCH v3 11/20] hw/i3c/dw-i3c: Add IRQ MMIO behavior
Thread-Index: AQHclxdwS8nRR9ze6Uqk472dKK371w==
Date: Fri, 6 Feb 2026 03:19:43 +0000
Message-ID: <20260206031926.3227848-12-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5762:EE_
x-ms-office365-filtering-correlation-id: e811feb6-1d5c-4f0f-c47d-08de652e92a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?dRW5oG/z92wiayC1iIgGwAN2bBwePIsd4qNaZ6zVyzezLgi2UHlVtQ/YG+?=
 =?iso-8859-1?Q?DsNNKpt+zQH2ZWiH8WhhHUp08gTUlnY3ZM+X4ArqQixNVF+M3bnfqJNLZR?=
 =?iso-8859-1?Q?4yZIeODrBAT+ATl/zXL6tHBPrq1XFF/Ld4mMr5NOpRTMmKjG/sfLB48b4C?=
 =?iso-8859-1?Q?/DBRYPc30EvihKxod/l9KtI1EiUUbnOIQ20OnvzparD2U5DBQx7w3/1/PS?=
 =?iso-8859-1?Q?ziO4Irly7KuibXz36f6s24SHAFQP2+0jBb7aeEVH7I/BWy/aeqRCByzdJm?=
 =?iso-8859-1?Q?c+o4cAF967DR1PIvyyxucSEslt50zsTztRuNAburCN8JDGWxt9Cu9dNmWC?=
 =?iso-8859-1?Q?StvsDHBOKOZkRWcuOHYQdOgHaC4jklVNQ5nbQ3G2mGZcjEcD1D7Rp5wBW/?=
 =?iso-8859-1?Q?X4RPHULVx4zzLbFRxTANFRBiK7OsGrYOnFAsecNc17ZYT4nx76YRQOaNK4?=
 =?iso-8859-1?Q?WDtzSMGyCO+0N2ltC0ZjSxtdu0nNYWl8JNpjzNRJAMQ2iM4iZr91k3FtUM?=
 =?iso-8859-1?Q?qND3R9Mt4bYuUSb7OJZYVdfgZ2F2ZxLDzY8tm0uHbRVcSSktdRYuhO/GC1?=
 =?iso-8859-1?Q?aXvMigyOsAi9EXtuQBTVxGDtXjAXbfaSuap9iqs4bWZMLA+27qbkG2IJff?=
 =?iso-8859-1?Q?SGMu1yRDnU5dk/52wavGlfTrbs5IZV0h23nrSPb6Fc4Yi5ewcv7O+dkpRT?=
 =?iso-8859-1?Q?WT2R8r+LECkePO3mB0iv9brBMz05RyzP+JNol6hf9eHjIk3BU/QiSFEe7R?=
 =?iso-8859-1?Q?VfmEQ5BklN4aqBOdlp6PcvoZnGCVhBQ8xYWe8yRlUfF0oLzwesDqoXFf5A?=
 =?iso-8859-1?Q?HnayaTJNFrlmlxQVK5w8YMQNsuz4cquoYoQQ1vIEKejn9MmrJQ1kD2sHOf?=
 =?iso-8859-1?Q?/OIh3zgzNtpzAt6FZFzw78ubMuaImHvesFdh4MbTcOzWjesfqOTj6IzeKq?=
 =?iso-8859-1?Q?r5qVgoZ3DSCQr5vn4j24pd5Gz8IaXbv2alLJNFBP4rGNiuYf8kSiD+/aKZ?=
 =?iso-8859-1?Q?gZboiCHb0SpnSh8P+RCZuwpq8W3516KpQ8NcyzTLkP4yPmWUBO9m1kArw0?=
 =?iso-8859-1?Q?ZljTTgZaq3mL4HyzYVzftvLVUNCk3D+atjt9/EWLnkJz9Uzl/NuqdOv9Cz?=
 =?iso-8859-1?Q?EGunawNpp98VeLLTrQrNo0GNpfuS8I5CTirpGL78xcXgHZW1AQ1JyV964A?=
 =?iso-8859-1?Q?mmDa4h8ztjN3dhKtrsBZGrCKrSg+LAGO4o9084sArcOXXsnnXAwCdDOhMY?=
 =?iso-8859-1?Q?Y4VfcEy+dzA1DJCWZOAs1P6JeamNSjmvnRIZBbDM0k1EjAKrcouQeC8/tx?=
 =?iso-8859-1?Q?6AlOL5idDuyuNcTaqdPuYja2COWfmDsVBwRvhWTcSOk6QKAT1ibxA/3taf?=
 =?iso-8859-1?Q?SmEmv5/iP8YJovqF+U1XTJiRxtHeI36C7D4YMX9PMLClMdwvX6pe7tDV/q?=
 =?iso-8859-1?Q?xWZ62W+5MzYX+HqCRIptr1oChRffnh1OwYzCuSiWCsNNmod6d3ZPPUodAg?=
 =?iso-8859-1?Q?9oNAbYEAqMTnLSDZUex2o5Npf0M7S23kyGuWHOKhf15f1JXK1/01BkiRWa?=
 =?iso-8859-1?Q?X66d9niCyunOWTiWpaHy7U2v8JnDt31shT3kKbDMU5pMD9QzMq4yMjocvP?=
 =?iso-8859-1?Q?N+wFnauOcKskp8sd29Yt5cWvQTs8Q1amAaNF64L3xFaajvOU0beZsz+Irx?=
 =?iso-8859-1?Q?y1K5rpWtS3B+ampzmW8z9YK2nknVU+ZSn5F0mTJa?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GCzF9SBqVaKEVhcUVC0Y2qxSd9sgsJ2iWzWkI5S9NX+WVxixksYFmTjoyr?=
 =?iso-8859-1?Q?atc1gE0ro/f2hm/6v3nGNbFA+1q8ifzuMgrx32BG0nJpR1OeZ/2FOVfvXq?=
 =?iso-8859-1?Q?qeNfMO8O1Ti9xqxzdVR38AoL/ANy6PeF7osC9maz/etBSaIkHo2XMzy6RX?=
 =?iso-8859-1?Q?KCIBDeabmi/ZtAYJdw6PvehiJmLhbZg+xNIopXkjErgteVjDuhTqn2fkfN?=
 =?iso-8859-1?Q?uQ307LGjb1BGXNItMbbYzBkA3gTYab/vj3CDBRFBh+pExAX/FRJppvhn0e?=
 =?iso-8859-1?Q?zhzGfZiCFc+rUm1f1XpGPQXZPxK6IhGohw9oQeE5wXAH1t0ikmorn9892o?=
 =?iso-8859-1?Q?Mj4ndiw0PFvNq+Y1ykkDQSeoutD72WHjtstEjQPjRmQ6mKSm9T3TfMYZaw?=
 =?iso-8859-1?Q?wRLBP3sELezSpcEC5HeRVe49vXIAYSOfwbaPTca2UENrdTxchK0xaZ8PNV?=
 =?iso-8859-1?Q?NKF2gSv3MQJj4+SpZqJYRpX19TR6OUOKIhF6ylSzlNAgwFno22CJlFYSZo?=
 =?iso-8859-1?Q?1IkTAn8kmBna35rqA6GMBai66ZS0fh1LAAPhVegWBgkriiuyGG5y0/wZ+4?=
 =?iso-8859-1?Q?pjEIpx69y5ATBv2NV1OvQxiXX82LBIXRSH5HjNi5DD6GFub0uJrZQEQndf?=
 =?iso-8859-1?Q?gSX6E3NdsBIw4A4y0m50w7V7Zcas/T6sNQe7YsAuivijX/0UZ04W4ilR1M?=
 =?iso-8859-1?Q?a6fDMcKRNoOZma72XnuubyUjqfUY6sUVggC6NRSoaI6NaisGJziRL2e02y?=
 =?iso-8859-1?Q?qdXVg4jrCFK5Y213UM+8vBeT3o/bobl0i8IFBCrUC1+E1YcX2xwnpq3ClR?=
 =?iso-8859-1?Q?a5FqkYnzWV12KoM8E/Cpy4pF9gJJ0/vUhB3rHC3+X2PDTWjPgCX0aqbM3y?=
 =?iso-8859-1?Q?cRXVGAcAmJ9NcSSBwQROsor5UbIBcWpg/hwEjPn5hPrPTI5Dg+vGe7UGww?=
 =?iso-8859-1?Q?wepY2AT8vYftyVi0yWLzgT4MmA5yxLKmC/2soXmRvLCzuaBgjC6S7ZeCOJ?=
 =?iso-8859-1?Q?44dZ5+GfOC1I17pzoUYMdIi8/jg6UDr6bnIczvZf1+trkaGeVrYJ2SXuMO?=
 =?iso-8859-1?Q?10QmgEoT52SOft68NsEQyMWjGZh5t5PgPesxvRksGe2tYmvPHFo53JrZE5?=
 =?iso-8859-1?Q?QPsUM6D11h1mHNsFXGCl8FlaUH0fLYGLMR3q6UIoT8aqZELa3ApurxJMtE?=
 =?iso-8859-1?Q?ozlUtUEoEfWiEDbo4b/pU8RmycVN1kANG05zlzPNZjOSJ4TovUa7s5mrPP?=
 =?iso-8859-1?Q?OW0TsUPLGXBTjVCpzf4uvmo6Rtd2jYX6g2yKBbCvVTzkrwsFcJMoI/WCEH?=
 =?iso-8859-1?Q?XjGmObxmZD+qQfduQpKpmwF8N26YRZj7dtpRy/KOWIWzlvrhZuNNQBuuX+?=
 =?iso-8859-1?Q?KxeAMRIsqFIbeOBeY8YJKpA7G07ck7BW0HPRKayu6zg8ux6rHaggLQytUq?=
 =?iso-8859-1?Q?JwPDmXvUNgJosQuuhurYZ028o2hS71tKJFHaQHQAPr4FWXAkS1j9Q8t5Dr?=
 =?iso-8859-1?Q?LiItxY93I4eSHMj5ZZEgfU3lLvpK3WKemXbzXWo7GNlcbB3+3iN7vKv9G1?=
 =?iso-8859-1?Q?XqLaVELZsAxYBXWhlPzz/9FerLVivAeeKwXcohfSn75wH3llYOaOA6mlec?=
 =?iso-8859-1?Q?S34DbPRWgl4ljvU3SuWpMn+jBWZ4SVBNepSzyqPOmVs7nOLOdyqJom/AlO?=
 =?iso-8859-1?Q?i5B9NnpWpNjD/DtgOuifn8CLnDU4grgt/UE3yZURxNzZQT17/3DSHD8M9N?=
 =?iso-8859-1?Q?oOu64lBKtUW6PY61c7QEy4LGIQfOvHpSqoq1ofrYQg6A0g3nlliA8SBIA6?=
 =?iso-8859-1?Q?G5gvIKSbfw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e811feb6-1d5c-4f0f-c47d-08de652e92a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:43.6210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+Wwt4YMQwmRneYRdu04gXkvQ4mDdsJunrHNTAGTypPF02FOHvNiUBQolMOxJzN/VcFlhPvneYVgk/TpUQ+QVVcFAf9PfDVNA/MTTQidBAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5762
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

Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Hao Wu <wuhaotsh@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 56 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 9dc71aa3d8..bda8ab5d51 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -17,6 +17,7 @@=0A=
 #include "qapi/error.h"=0A=
 #include "migration/vmstate.h"=0A=
 #include "trace.h"=0A=
+#include "hw/core/irq.h"=0A=
 =0A=
 REG32(DEVICE_CTRL,                  0x00)=0A=
     FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)=0A=
@@ -335,6 +336,46 @@ static const uint32_t dw_i3c_ro[DW_I3C_NR_REGS] =3D {=
=0A=
     [R_SLAVE_CONFIG]                =3D 0xffffffff,=0A=
 };=0A=
 =0A=
+static void dw_i3c_update_irq(DWI3C *s)=0A=
+{=0A=
+    bool level =3D !!(s->regs[R_INTR_SIGNAL_EN] & s->regs[R_INTR_STATUS]);=
=0A=
+    qemu_set_irq(s->irq, level);=0A=
+}=0A=
+=0A=
+static uint32_t dw_i3c_intr_status_r(DWI3C *s)=0A=
+{=0A=
+    /* Only return the status whose corresponding EN bits are set. */=0A=
+    return s->regs[R_INTR_STATUS] & s->regs[R_INTR_STATUS_EN];=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_status_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    /* INTR_STATUS[13:5] is w1c, other bits are RO. */=0A=
+    val &=3D 0x3fe0;=0A=
+    s->regs[R_INTR_STATUS] &=3D ~val;=0A=
+=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_status_en_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    s->regs[R_INTR_STATUS_EN] =3D val;=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_signal_en_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    s->regs[R_INTR_SIGNAL_EN] =3D val;=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
+static void dw_i3c_intr_force_w(DWI3C *s, uint32_t val)=0A=
+{=0A=
+    /* INTR_FORCE is WO, just set the corresponding INTR_STATUS bits. */=
=0A=
+    s->regs[R_INTR_STATUS] =3D val;=0A=
+    dw_i3c_update_irq(s);=0A=
+}=0A=
+=0A=
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
 {=0A=
     DWI3C *s =3D DW_I3C(opaque);=0A=
@@ -348,6 +389,9 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offset=
, unsigned size)=0A=
     case R_INTR_FORCE:=0A=
         value =3D 0;=0A=
         break;=0A=
+    case R_INTR_STATUS:=0A=
+        value =3D dw_i3c_intr_status_r(s);=0A=
+        break;=0A=
     default:=0A=
         value =3D s->regs[addr];=0A=
         break;=0A=
@@ -392,6 +436,18 @@ static void dw_i3c_write(void *opaque, hwaddr offset, =
uint64_t value,=0A=
         break;=0A=
     case R_RESET_CTRL:=0A=
         break;=0A=
+    case R_INTR_STATUS:=0A=
+        dw_i3c_intr_status_w(s, val32);=0A=
+        break;=0A=
+    case R_INTR_STATUS_EN:=0A=
+        dw_i3c_intr_status_en_w(s, val32);=0A=
+        break;=0A=
+    case R_INTR_SIGNAL_EN:=0A=
+        dw_i3c_intr_signal_en_w(s, val32);=0A=
+        break;=0A=
+    case R_INTR_FORCE:=0A=
+        dw_i3c_intr_force_w(s, val32);=0A=
+        break;=0A=
     default:=0A=
         s->regs[addr] =3D val32;=0A=
         break;=0A=
-- =0A=
2.43.0=0A=

