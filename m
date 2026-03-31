Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC2AFF60D3
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7SuZ-0006md-GB; Tue, 31 Mar 2026 02:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w7SuX-0006lg-9p
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:49:13 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1w7SuV-0008KT-2Z
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1774939751; x=1806475751;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=kUiAjz235FIeRz6xmqg1K29s5XOr+hPubr/saNNy+PM=;
 b=M3Too2LTnbMCMisTSZMXpvtFYnFOGhddNW2EuEHQnSn9wpMsZyE50HH2
 3F8N85+yeIfBD+wP6sif8DyGT8AwD92yHlz6fSmMFUig6KH3g3fn9UGME
 wO4YuNL8QFYQ18rDMj5bKojXN9t4NLnJ4U5iZ3ZDgKx1XiQTZAyzUl9Z3
 aRRH2bSNborblvwCrJmK8xOBt5V3Xfciv3ce5f3GnZYI5jxJFyP/nbP2t
 XRKKbN4pSBAY0Nogmn7Eal8ToL2ORWfLNbp3kBn+5U8vpwUqkKHMiMZ+I
 KVNKPF4Q0qQ25KdhgLif8ITeIjSvJMgxqtG06Izp6fuSkh+7LCyse8S3J w==;
X-CSE-ConnectionGUID: 9foMJXl1RAaqi0I8f+bBYw==
X-CSE-MsgGUID: KuGxqr5YR0SC5X7W3Yb4+g==
IronPort-SDR: 69cb6e61_S5mBiNFGQcTbowLCms2H3oJoFdPAOyg/pBWU103IOSXIssC
 zW3NN9dPWEF4DR61E2v6JXrJVBwo/0UALBT/hBA==
X-IronPort-AV: E=Sophos;i="6.23,151,1770591600"; d="scan'208";a="47294044"
X-MGA-submission: =?us-ascii?q?MDHPB/zrnGGMb6AWZ9kDH/FGorHJdwZFld7SD6?=
 =?us-ascii?q?suw3Z7x9lZtRqlO3zIM+OpMqqop8L6lyyz5IjydzPmMpi5CUcFsww0Va?=
 =?us-ascii?q?kQ2Cvo7vKViSoi68a+JUdWalgVGfB5j7Yqq1g0S27nGUpoRjGBDKIStG?=
 =?us-ascii?q?E0CGoE+JLxGnGqOaxOGj1zQQ=3D=3D?=
Received: from mail-westeuropeazon11010010.outbound.protection.outlook.com
 (HELO AM0PR83CU005.outbound.protection.outlook.com) ([52.101.69.10])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 31 Mar 2026 08:49:05 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFYMAUK47iskVV/zMTvDuSKe5ewZb7I/+UWk3lt1KHYBvcWxf2EHz+UoqZLqtWzkacD6O9kN0uIuzXo0AWG+hNsFwt/SwQqpaaVZ5rSWZ4Rp8Vd065DE3FjNNdL3O/pZGstYZKMYQL496dfxj4hwdpl6AtLewzARUlefBbTfGDv7qMuclQX8dyXNU66OFfUxNFtgqE/t+kdL70fCfXGt+WSv+GXqGU9OwPnsoi3glIu/GpMkbo2kU3Gyg+Wtq7InZL3cAW6XEQhBH5Hlx7xncuCx4JyM+SZvgcqyr17HpUg0ROmPj2hR3WDooe4QUtYePaNvsm7WPAwkheWSgEutkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUiAjz235FIeRz6xmqg1K29s5XOr+hPubr/saNNy+PM=;
 b=HPSPyvnYlw+sV97dAtUXl7x9jbJLunCYlx+7ZZlQtOreDe6PmA5PjZ4FUQcmKCWN2L8qHVI2kM026rr4h4a5n3Kfxqqu3ssP5xIjI/HkGKixhGZw7yG23rJekR4G/N4+yC5QY+fqCKvPh22kwAjcVPIp4HdLtrK8KDSgOD9diL3mmm5pYoM7ke+6taUleAl+cYFCoGAxcF5kvGVlhBrZRQPh/7hLBvG+zP57ndBiQV+ydy5gBDI/4YWt/6K+ByOqfRoLHqRgmAgdFej6RbWqH06Ok8I4ggt+AtVb5BEnoFauPrrXzwLz7JWaS6xXsARomvgkYx/PvFqidqlgHCxVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS4PR07MB8557.eurprd07.prod.outlook.com (2603:10a6:20b:4f8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 06:49:01 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 06:49:01 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: Re: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Topic: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Index: AQHcrRucl+8w3w8Tvkaf2W6HYfy4KrW1kwGAgAASeoCAAT2GgIARd4iA
Date: Tue, 31 Mar 2026 06:49:01 +0000
Message-ID: <bdc0f51e1496c841a4f3392ec3e775e6a69b57e1.camel@eviden.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-12-zhenzhong.duan@intel.com>
 <1b2b191e2f9f1315c883ed2de4fb9644a01c8713.camel@eviden.com>
 <IA3PR11MB9136F0D294E9FBE576E0CF91924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <IA3PR11MB9136B3C106DDF70856F27FE6924CA@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136B3C106DDF70856F27FE6924CA@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS4PR07MB8557:EE_
x-ms-office365-filtering-correlation-id: 9c8d0996-c8ed-4f8e-8880-08de8ef19793
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: MT2a5O+xk2wsTJyArUHkHKlo5LOV6ZjQC4ETVEVNBxqL2K0wSoCy5e9bZ0mkXTd8pZ6Qo80QUCWlPNGWo26yEl68pD/WPkiVkltAndPadmhaAQ/33Ca54zyLFgaW01EgPKRw0KLRqryKTlQSGWzYUEGhCmZO4BfIirWuaxlUs4SIMJgAfwAAaQFwRxvVeiNfuoItUy85f4KW6yO2UHM3UcylkyDL+pa0FUpHWaojn/uv5zy/YnUX1FXTxmU4XwgI0mdQP2VIj8NdHRz61lge7cCvPlzt2nrAJQ6hTTdzvpiJATgoD284w7kK/jMsujcA4IgUgEHPt1Vi+T2X+rbmK+I/RFLNGEWkcgZKurhijVykmgf/f16mMw9SGcDMgqu2Rl8Rw/HQ2Iwa3akw6ouReZK4v2sdwm/lruUcmfCPS71TgZCLzeTsMhaw7jIJe48/JFrs9F7IHwOgWsYHKc9Reg1RxySQ1vYExKxM9IH2CXYtzi5zHafNF1Rjf3M3IGJ1rCUAYsoJchenTu9JSTaqcat/cZxR41lW6TEQVigKmgHE7+dbClpgi8OXWlMW5+nZ0AyvYjDTWBDrx1IjADsYQ0HvIQqLmff2JDJjs2Fkei+MLOqyZ6tBfDbBYxE1pP8MquGVChvvjxDJHh+ieywFoG+93wCWBP6g6DbLsapWQST5qxEbMFyDWNtBT6L50Ka8JSsR5myJgNIHceX4wP2igPJMrMni3aRLOLqVJcQz1MWn1K3QKbcRLheDsf2SyzCP2VKr4wJugdS8K/j4/0Unpz3l/rUmG5lD7M1vkTb9POM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzVKdTdVOGdUQ2I2RFM2QmxIaEY3d3dIV0Z6RVdwelR3Zkh0d2wxdUV5QWN4?=
 =?utf-8?B?SmpIY3dDQytHbTV0QkVDMTdSeVpUOXhUK1hzeGVsY0VPR0tQanhDT3pZUUhw?=
 =?utf-8?B?eUZRcnp1SVozSlBCblhESTFZczVLTng4QTg4emJrOUovVHVVMmZzRnV6RFJp?=
 =?utf-8?B?bFhWSkswdVVNcmIyUitUQkVpdjlIM0QvUk1McnhUSVlNSkphR3NaUUdXSFdl?=
 =?utf-8?B?L3Q0eU5mUEVuNTZqRjI4V3pSdXZLR2lZWXBrRkpDODhyOFpac2hQMEJwbHQy?=
 =?utf-8?B?aXpjdVdMRWNwN1VIaTRRQVFIMUdGR1cvNXhmU1k2UXdueEdtd0pHNFhCMktQ?=
 =?utf-8?B?MGQrYlVQaW5jMzdnSHRVMUpCaDNJcjVIR1p2SHZqUzhOdnVZVVpibjFnNVNI?=
 =?utf-8?B?M3pYeXNERDBkVWtOWCtnQkhTM3c5ejZQZ1p1dXFUQTlNZ0gyZ1hqZmlMR2Zy?=
 =?utf-8?B?dGl1Ry9DMS9vNC9ZRm1SVnVjTGRJdHRPR0o2dTc0Z1ZtR21mNHNiMjNndWpF?=
 =?utf-8?B?RHNsT051cjRreitSU0NjeGNkb3NTd3o0QTVWWjJqSFJKVWhacHk0VkZMcitr?=
 =?utf-8?B?L1YzQU5uUXBKS3BXTkR1bVozSFU5UGdKYXoxTDFVY0UwTmRGdEwvUStjRFhR?=
 =?utf-8?B?SFJoaXNienlUSVd1RkVOZG9QMWdsU3FKRWJ3WUo0eGlyTEdENDJ0MXBsUnBN?=
 =?utf-8?B?VmpNaG5UZzc2YWNpUWNyWmdiV1JkajBqTkNyU1BxUWE3THFLYk92aGRKdzdN?=
 =?utf-8?B?SEFlakJEZ2t4SGZKM213eHpoSkNaeGdYRHBZU3VKSWFXVExCc1NPdHpNNTZs?=
 =?utf-8?B?dXIyM1dtR2F3MFJhY2cwMEwvYjB5NXFjQXk2elVrL1pNSnlSeWVsK0RMcjVZ?=
 =?utf-8?B?S2hyVUFrVDh4THdaaVNrWGEvak1QNjFjSHByVzlVS1dzaVcvQVZNRzNMMFJ1?=
 =?utf-8?B?MjJ1QTVXQllkZzlVTXNkemtjaU40MHZWMzZlSzBPZlZsNDNrVENGMW1lYzFv?=
 =?utf-8?B?emt4U0l3WjRxc3VnbUI5OHFyUGtwZGNLZjJQeENSektPT1pTMFd6ZWRDb0RH?=
 =?utf-8?B?OTNMbkZlbm5uSWUvZ29UWTgrbjNKeW1rM1R5SktpWlBqaTF5R2ZXZkFiNStP?=
 =?utf-8?B?cC95dG1PNWhxdk9UQ2pnTk9aMVc5QUp3cFBGTUtxcmgyWnp4bzlwbDlIcUlK?=
 =?utf-8?B?emxsUThEanB0QnRkZzNremtDQzI1Q0s1cVVGSjkvSzFqSmtNQmEzZ1RGbSth?=
 =?utf-8?B?dzJacVAxMmJnenJnTTF1c0VIU1ZMcEtvR1d1dUNmVDBBdlZZTERNcE1tdnlP?=
 =?utf-8?B?QVFWWlZoaXFNQ1JyL0txcDE5VXRzR2x4Y3UxYnBzRUx0ZkVoOEJnZGRtVnV3?=
 =?utf-8?B?aTBNK2tyV21pSE41RXE3SUxJaEl1VDA0c0duelFIMmxYWnJkSEdwcmF4aWlX?=
 =?utf-8?B?aHF3M2t2VytGMXdLaDFZaTlyQVF5K1lwdWhIN2ZlNm0xSTRmUDJUVDFhZ1FX?=
 =?utf-8?B?RFFiUUJBZkJ4ZTNyV2lSTG1UVFM4Tjg1b1FCRTdESVI4THh1UTFob01YV1dh?=
 =?utf-8?B?TUZ1U2oxOVZqeGl0M3BuTzBMUEkvelMrTEEvcEZKWlFFN0pJRHFacDJ1N1VV?=
 =?utf-8?B?MHlQY0todlkvSjFMcTYzdklEamg2QU04Y0dzSVJ1TGY5NXBaUGtEekE2Zzlk?=
 =?utf-8?B?Z1ZZT285emlqRC8zTGY3UTVzMHI0ellMRGw1cFNobXh1VmVsM2lJdGkrQWNB?=
 =?utf-8?B?T2xsSWliclVJQzJsRkJtMmEyUXc4VUI2b3NkdVZiL0FuR2tvcFhWcXhMOGtt?=
 =?utf-8?B?WURsUGVMNSszbGVhOFpkMFRFaHU3d3IrN3RrRlNjbzdCRmw1cE5ZUVg5K3RR?=
 =?utf-8?B?c3VSRDVkVXQrSUVGZHFGSFplanVMQUJUSUcvUDljRmRFZFVqMk94dWYyNXJo?=
 =?utf-8?B?S3RhVVVIdFdiZ0dQcnRqVmJyNXZvOVk2dmdhcVFZZ0lCVlRIa2NaNnlKZDVF?=
 =?utf-8?B?WndFdnRxOFRlVVh1NEhyR2tMYXU0Y3MzcmdOSFRDSGswV090c1hJdHlUMk1P?=
 =?utf-8?B?RXNqdGFrdHRxR3ZHU3NjYVhKbmtTMFRVN3VaYTVMQ2JSZXdJaHQ4ZlZvWUVN?=
 =?utf-8?B?M3hQOUp1NWtpL2ZaWU4yWmF0d3RSbFV4VkZKZFN5K0pxbXQyb2p4YjRnYURa?=
 =?utf-8?B?REtTN1duZWFLR016T3JBV2RVVGhaRzNISkJmRlAvSDR3WHhuY2dUVThMZVJ1?=
 =?utf-8?B?VXRBeFNBQkNWRW01NnNqamgwRkZzeDd1cGpZbXFRM0RwY2FzK2FHa3RtQncy?=
 =?utf-8?B?ckUwTkI5TUlYanllbmw0Mzc5cVVucTY3QlpvamxJTnNzOFNKZERiOURwS1B6?=
 =?utf-8?Q?arrxxh71rQNo3OVzkL8LOS1Cq+/F2kxWnqCeD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED8EF633D78A8F42BBED369FF99537FF@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FFjQ2zC9jJLtx1UfWpjivxV7e4SCYAQjKPBKBSwvzaYI2gEcehZHsiIpGiwfP22+TE0WDE2EsedUnjyaawWGJJX/nb+/4fT/dA8naUNR5bIKcsTFk1VV9OHLR+qBxbHrO53PRaCZ727Z8dpMn7m8BkxAjy1QOxLqpQKl58DG8GdmksvBDajpC5T1waycwzLCGIqvtutCqmGfKNAJx65/GXBug70XZBoFNS26wCEMh1fPnl3kR1F/6YRt/aEZ4ZSjb2rX6pIgE1cxHyK4JCslI8ccx1nkhQTiRqWmc2HUyloEg2OGLi4jU3dUHw1n59hEJneYWKiuBNPigTw4qI8Mtg==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8d0996-c8ed-4f8e-8880-08de8ef19793
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 06:49:01.3610 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zFe6d9/02SYsGeUG0JX1dHX2iPdklerrkEGrV/VNVsANPvSkgyH0BB2OyfRKeSteUipThj112AYWmlaocIAhxrYtrhyDABI74VXkGqy1jIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8557
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost2.eviden.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

DQpPbiBGcmksIDIwMjYtMDMtMjAgYXQgMDQ6MDQgKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90
ZToNCj4gSGkgQ2xlbWVudCwNCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gRnJvbTogRHVhbiwgWmhlbnpob25nDQo+ID4gU3ViamVjdDogUkU6IFtQQVRDSCB2MSAx
MS8xM10gaW50ZWxfaW9tbXVfYWNjZWw6IGRyb3AgX2xvY2sgc3VmZml4IGluDQo+ID4gdnRkX2Zs
dXNoX2hvc3RfcGlvdGxiX2FsbF9sb2NrZWQoKQ0KPiA+IA0KPiA+IEhpIENsZW1lbnQsDQo+ID4g
DQo+ID4gDQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQ0xF
TUVOVCBNQVRISUVVLS1EUklGIDxbY2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tXShtYWls
dG86Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tKT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjEgMTEvMTNdIGludGVsX2lvbW11X2FjY2VsOiBkcm9wIF9sb2NrIHN1ZmZpeCBpbg0K
PiA+ID4gdnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2FsbF9sb2NrZWQoKQ0KPiA+ID4gDQo+ID4gPiB2
dGRfcGlvdGxiX3BhZ2VfaW52YWxpZGF0ZSBjYW4gYmUgY2FsbGVkIGZyb20NCj4gPiA+IHZ0ZF9w
cmlfcGVyZm9ybV9pbXBsaWNpdF9pbnZhbGlkYXRpb24gd2l0aG91dCBhbnkgbG9jay4gVGh1cyB3
ZSBjYW4gY2FsbA0KPiA+ID4gdnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2FsbF9hY2NlbCB1bmxvY2tl
ZC4gSXMgdGhlcmUgYSByaXNrIGluIGNhc2Ugb2YgY29uY3VycmVudCBob3QNCj4gPiA+IHBsdWdn
aW5nIG9mIGFub3RoZXIgZGV2aWNlPw0KPiA+IA0KPiA+IA0KPiA+IEdvb2QgY2F0Y2gsIGhvdHBs
dWcgaXMgcHJvdGVjdGVkIGJ5IEJRTCwgYnV0IGlmIGFuIGlvdGhyZWFkIGNvdWxkIHNlbmQgUFJJ
IHJlcXVlc3QsDQo+ID4gd2Ugc3VmZmVyIGZyb20gdGhlIHJhY2UuDQo+ID4gDQo+ID4gSSB0aGlu
ayB3ZSBjYW4gYnlwYXNzIHZ0ZF9wcmlfcGVyZm9ybV9pbXBsaWNpdF9pbnZhbGlkYXRpb24oKSBm
b3IgcGFzc3Rocm91Z2gNCj4gPiBkZXZpY2UNCj4gPiB3aGljaCBkb2Vzbid0IGNhY2hlIGlvdGxi
IGVudHJ5IGluIFFFTVUgYnV0IGluIGhvc3QsIGxpa2U6DQo+ID4gDQo+ID4gQEAgLTU0MDEsNyAr
NTQwMSw4IEBAIHN0YXRpYyBpbnQgdnRkX3ByaV9yZXF1ZXN0X3BhZ2UoUENJQnVzICpidXMsIHZv
aWQNCj4gPiAqb3BhcXVlLCBpbnQgZGV2Zm4sDQo+ID4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1F
Tk9TUEM7DQo+ID4gwqDCoMKgIH0NCj4gPiANCj4gPiAtwqDCoMKgIGlmICh2dGRfcHJpX3BlcmZv
cm1faW1wbGljaXRfaW52YWxpZGF0aW9uKHZ0ZF9hcywgYWRkcikpIHsNCj4gPiArwqDCoMKgIGlm
ICghdnRkX2ZpbmRfaGlvZF9pb21tdWZkKHZ0ZF9hcykgJiYNCj4gPiArwqDCoMKgwqDCoMKgwqAg
dnRkX3ByaV9wZXJmb3JtX2ltcGxpY2l0X2ludmFsaWRhdGlvbih2dGRfYXMsIGFkZHIpKSB7DQo+
ID4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gwqDCoMKgIH0NCj4gDQo+IA0K
PiBBZnRlciBmdXJ0aGVyIHRoaW5raW5nLCBJIGZvdW5kIGFib3ZlIGNoYW5nZSBkb2VzbuKAmXQg
cmVzb2x2ZSB0aGUgcmFjZSB5b3UgbWVudGlvbmVkLg0KPiANCj4gQnV0IEkgdGhpbmsgdGhlIGlv
dGhyZWFkIHNob3VsZCB0YWtlIEJRTCBiZWZvcmUgY2FsbGluZyA6OnByaV9yZXF1ZXN0X3BhZ2Uo
KSwgIA0KPiBiZWNhdXNlIGl0IGlzIGEgZnVuY3Rpb24gY2hhbmdpbmcgdnRkIGRldmljZSBjb250
ZXh0LCBlLmcuLCBQUVQgYW5kIFBSUyByZWdpc3RlciwgIA0KPiBwYWdlIGludmFsaWRhdGlvbiBx
dWV1ZSBhbmQgaW90bGIgZW50cmllcy4gV2Ugc2hvdWxkIGFsd2F5cyB0YWtlIEJRTCBiZWZvcmUg
Y2hhbmdpbmcgIA0KPiBjb250ZXh0IG9mIGFueSBkZXZpY2UuIExldCBtZSBrbm93IGlmIHlvdSBo
YXZlIGRpZmZlcmVudCBvcGluaW9ucy4NCg0KRG8geW91IG1lYW4gdGhhdCBldmVyeSBlbXVsYXRl
ZCBkZXZpY2UgdGhhdCB0cmlnZ2VycyBhIFBSSSByZXF1ZXN0IHNob3VsZCBob2xkIHRoZSBCUUw/
ICANCkknbSBub3Qgc3VyZSB0aGlzIGlzIGEgdmlhYmxlIHBhdHRlcm4gYXMgdGhlIGluaXRpYXRv
ciBwcm9iYWJseSBhbHJlYWR5IGhvbGRzIGFuIGludGVybmFsIGxvY2sgIA0KYW5kIHRodXMgY2Fu
bm90IHRha2UgdGhlIEJRTCB3aXRob3V0IHJpc2tpbmcgZGVhZGxvY2tzIHdpdGggY29uY3VycmVu
dCBNTUlPIDovDQoNCk90aGVyd2lzZSwgaXQgbWVhbnMgdGhhdCB0aGUgZGV2aWNlIGFsd2F5cyB0
YWtlcyB0aGUgQlFMIGJlZm9yZSB0YWtpbmcgIGl0J3Mgb3duIGxvY2suDQoNCj4gDQo+IFRoYW5r
cyAgDQo+IFpoZW56aG9uZw==

