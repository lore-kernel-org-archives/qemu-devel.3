Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66094C02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvmh-0004jI-11; Mon, 20 Jan 2025 12:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmc-0004ds-L3
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:54 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tZvmZ-0000Yv-Ce
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1737394911; x=1768930911;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YMoWfnZMWfI82l93VsVdxFOZSPZMyQ5sjcppm9XKXHI=;
 b=qqEkZhNEqlWR17nCaaHZL0t4N8IOVRbsfvt1H3GvKVjPsUV/8bydGOBO
 D38IMy2OouN4Lezm0982B63xjxF6RSPauvVIKlW40HVMWCylF/JbbTYGI
 p2B2q4LaEt0l6iQKUuiGg660QjbOpGv6z5NeaE0dyOrxwBR2eZOyH+dB5
 0G3kCn5C2U/4jpAJcrxgUW/1NAsNd86In9Kka2v/OuMGSci8FRkm8Gv8R
 /zOumjdM+bQAP9QVv8P76dA6E9eoE07yhI83ukPn/z/3bHErH7QpTnpiH
 /iBKwkfI5z/nqtFSiwVcXdGi+va4oxiUEb4ShMigVOsjzV31SS3eHBpM0 Q==;
X-CSE-ConnectionGUID: wOR4GZ0QR8+JydJWYz+Z+Q==
X-CSE-MsgGUID: PwXdLVw+RGuhYf8Rc/o/bA==
X-IronPort-AV: E=Sophos;i="6.13,219,1732575600"; d="scan'208";a="30291722"
X-MGA-submission: =?us-ascii?q?MDFwS7EzwZ0/GqQfpjUE5NU3KzO3kblVwk0PDM?=
 =?us-ascii?q?rLWunapABapFPWvISHUXuFF/DdEYiVYrgfsUIa41I2Ck02Y75yNl5iDj?=
 =?us-ascii?q?PZuB/sGkZcB67jbpyrNryRHhL6uTr50NIwWQdd5I3SXVKJT57hAc0DpW?=
 =?us-ascii?q?pm1leT/GhJoMR2XrBkM13QEQ=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 Jan 2025 18:41:50 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=offBvemCE5qCuiiGDF9DQajQReTw+mKhaonFEGlkoeUrzUYI0DaXtGPPKJfP5LxuEe5InenPJZypAFxS+Xi0TxPCL0PAEd4VfdpBc8ASTMzguw11HyU7DJhh3pNHF+njboimDR9C+LJeeoOM+lSrQXM0K7E2axThQkl95DZDZ5ggTuaJfYaOwyUUi3I2e8yhssgRlGexsJ2q++lN985lEfFAG/jj97nhMOC1F7/gL/KFsAEspPkFjOXICx14KjGlAWZWUWQBVjcPWLHHnhSD4ahlKCBJfHTEeSRD+GiYrU5to1zj2wEvlLqGDwbW8XxyxwQza1ZZSwwg5r+e8nlv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUpzAwgWrTnHfWavIWbZfjsz9cTvu8hVyOJRd8nEh7k=;
 b=KPIt731ygVddahYP4fFgkshjOaNgUBtEZ7oCTdPD0Smp6ZJ4p35bxv18/iVUdN+nV28uqVTxmqjesK+T4Dllov8bYWoccXY+I5Z+MEBt0dSoChQTpdFPc/eLvWCrZKEw5nA346bdrKlDYjGtP7SNqjuk58MUIEnyxOAMs1jIycIQsYiX8VdyL6qQHv6tzOnUOKsCXt10/FMvDdkcHrWR937gHQdracX7IOSUPO9oIXA68L5HLiEoA/ETyAAJEFOgumABMKAUaE052CksZU0iqkD7K89fQClslS7/BBawKM38BpRrF+VSKVRyrO6cALO5hrlW2f4sxAemLd0TbE862w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUpzAwgWrTnHfWavIWbZfjsz9cTvu8hVyOJRd8nEh7k=;
 b=I29CktFgNjBdIC1w86BVkmovrTzwj7CHsO+qa4+37lJPlHHQSRwMqOpoIYVqAqIlt6i0T8Dh32SZX0wuQoZ28tS8w1OSwKxJI0GC7peirm/4usRFwjmmefC513H7obaFmpF4+DRT+torqgWYPx/yJkTInoWEywZ5FoFZUz9SQZ0L3bLbtajllIQ9Kx64sPLhJe3Drn29ADV+70vQiH7dQp3XAMPTNIICZEGhm2NgHUIOzppFZBSaNzt3KDikiDBq+CHQmjCPjxgaEoMjsn8lw0gO8LeL1V2/nnyuD9Pn4fyTqQgmVYeIrDBVLSUa/Bg1DsJvc68xj2Ib4KsGi1pkaA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DBBPR07MB7548.eurprd07.prod.outlook.com (2603:10a6:10:1eb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 17:41:49 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 17:41:49 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v2 10/19] intel_iommu: Implement the get_memory_region_pasid
 iommu operation
Thread-Topic: [PATCH v2 10/19] intel_iommu: Implement the
 get_memory_region_pasid iommu operation
Thread-Index: AQHba2KV0OH+x6FBOUW1Iip7kCrRdA==
Date: Mon, 20 Jan 2025 17:41:49 +0000
Message-ID: <20250120174033.308518-11-clement.mathieu--drif@eviden.com>
References: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DBBPR07MB7548:EE_
x-ms-office365-filtering-correlation-id: b6e90198-b308-4c74-04ac-08dd3979b7a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?c4f0R5yEHUoiR48HhiysjwlstpIWF1GxP4tCo7ea9QsQ8GgSK/kTMRpNKo?=
 =?iso-8859-1?Q?KwKRRTQ4txC2qNjfuBVmpH7h8mr7XPnoRLavhJWhSc1k7eWc2H5HEsuHn6?=
 =?iso-8859-1?Q?2bmitafb3ujG+8ggGpDJII+Ka8/6a9iFDi4gJvrPT8n7HsDXWBUtdtp/Ab?=
 =?iso-8859-1?Q?+uymGUj/l9ZYrYjsAM2dexuGWkVSWuINbQ0Nza0AYK9fxwpyO37P3ft7GE?=
 =?iso-8859-1?Q?bstEejvCx0C2NN04G+vUL2Jta15PHSXtfrvHUtq1nSl0hcNt/J+kHc3pGf?=
 =?iso-8859-1?Q?9//amMP8orCUkNXeGM5rDB6W4tXoGdmoJwzlOVLHqaHvr28HB3PjR8hx6U?=
 =?iso-8859-1?Q?wYKJzAvJV3L6WuJ0lqzcaXkOlZJmznA29p6t7mOS0octSOxNizTru+BCb3?=
 =?iso-8859-1?Q?0qKyP0cRQ79OOHxGT5ynd8zgkxCPx80UQULubV8pcJdYNCgf3BTTKBujQG?=
 =?iso-8859-1?Q?y/lwT40aVfhSYhcUMcDKe2cszCEpllorlnUu75hn2RyuwQXIKkWwOJGrci?=
 =?iso-8859-1?Q?fz5s9Fi/4cAkHM27YaaTvNZU8S8DNQYQRDHNpy+Yt5/YuaClmv/OC2iV7G?=
 =?iso-8859-1?Q?YYrC0kKcBAIKfmZcO/03Vpbx9fMVJ0+aE04XcVed8cUtK/rOhqZ/Owkm2e?=
 =?iso-8859-1?Q?7hpg7JHD+wbafXBJN/bGsqjK38K0IZofgGICMGv7S4EgvkX4yYxKXc4tu/?=
 =?iso-8859-1?Q?6ltHlnIf9Q6Nv9TU4O9YQ/ZwOwL2ye7ThYTkSpF0bC5/1/bIj8TslSRcYg?=
 =?iso-8859-1?Q?F95HW3l2ZZPa3te9wiBazmplY7leOoIVuVwrMAXCMkl8HzCu8757J0/1X/?=
 =?iso-8859-1?Q?dSxuse+D9NRgGtrEWuSfE/gHChOeZJPqGXsyxtcdnWNdQW1cSzFJPcNfTp?=
 =?iso-8859-1?Q?wxqRJjmq7EdoEA70Ax1dq27PTu/Mw5JbiShRWU+dLCqd3GNBSBlwnNXL7c?=
 =?iso-8859-1?Q?D0Flljx5MVSIjaD/MyLrF/9b2aVH8JbO5dbq29H0od5pA6qZpBqwcFJPLu?=
 =?iso-8859-1?Q?91BUGJ0eiRNir4SdMu5vcTQb+kUKBp4NdxuuEDXolI6wTU0LjrJ2eg41CL?=
 =?iso-8859-1?Q?B5td4eqrGgRuLHisO7BfwwbGRvASM86EjHlZq7To+EQs5M8wr2qbLtA2w2?=
 =?iso-8859-1?Q?VdEa6Yo29+JhaYtRARnmG6Y5wcSe7UI/SmNJS3UaYo7wPTvBOFAuqZ3mk8?=
 =?iso-8859-1?Q?5uu8WfWw79Dff8zg92nksM/gE7AAP2qrkrql6JBSkUE8EUR49rZRgFJI/D?=
 =?iso-8859-1?Q?G3bzDoOwvtm3Slno3S0kT3oL6uOp+je2EM6AZxUYyKHhFbiRcs5xmweO71?=
 =?iso-8859-1?Q?azS4ajUtpVjVaNYbybsTJ+cp+DUdeKS809n9u7OlExmIMetYWbLOuPGjWH?=
 =?iso-8859-1?Q?bDLMBofEPH2LYUtFDCtOJragxRq2b0LU1cMrv7odwu9ig44lcAJ7b0Pk3T?=
 =?iso-8859-1?Q?BQPOEX7iJPlEmV9no+5dp9unpGKlubPpOUReNSnBbshSM8rGuQfArjPonw?=
 =?iso-8859-1?Q?4pq0uvzKrtYmE09gCn/jKw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ihu3iL0/l6mK+QJpTzRQQ1nv/VGb5O0Dx6jXSkZrP84wHmZ30xUq2YIEWy?=
 =?iso-8859-1?Q?dRSO2RdZHYnpl5MY6PyEkziqsvQje5IbSqBu8YTNPlifgE4w0MJVqTRFt5?=
 =?iso-8859-1?Q?RcZwbeCtMsydqFt4ViljNR6owWAANjKDTUVM3svEx3d2P9eDU5htFSODZT?=
 =?iso-8859-1?Q?bqHdzRReZ+uXBZ3KVU7073ySzjKrNtd485J5x09JkSkxMa1KhzeFgk7f9J?=
 =?iso-8859-1?Q?cq8Aphr5pnoirmW5twfyZ4vzFbzWfCU09U8n/+rxOtdbWiwcxgBFQCI4n2?=
 =?iso-8859-1?Q?QhDnMdc+5ilKMp8Iw6Qg+jIe5xAl7/qNmwUHR2NsGQTTrOD/TIePJjM7gC?=
 =?iso-8859-1?Q?ncrqraEN4jtuOD1wf1zspAamNBse28AZZv1RKRhmzaZenJ8QtK49umdj2P?=
 =?iso-8859-1?Q?efXlRewjvUxyyujD4IBB2bTBH04hDv3G/E7i1qVBeNdtnEfn2whm+KX/uU?=
 =?iso-8859-1?Q?MwaFrv5H/kJRLhOz/LeTt1VmewrMqlVAri+RefHkt2WcYpcn2LTVaeEB7Q?=
 =?iso-8859-1?Q?xh1GNo4sZL4RI0j4ubgTLdrNslrW1ZKOik+Brs57Kf0cmZ8BCSsf8Mn1yd?=
 =?iso-8859-1?Q?m48nOM+/l3F7Zx6FaVro3R3CVjHVBEtubMd/xaI8HkasOihQ6aThYqOenz?=
 =?iso-8859-1?Q?mjQBBWWHFUeK1AtvNAPKDVq4gzStsk1Oss+XtDil0YHPbBwU2r9OUiWmJJ?=
 =?iso-8859-1?Q?NnclezY+2l1KQe1SZDF1MtP4MIEuyxxD55Nw0Gxmy2ug71GV+K4tBhuG6X?=
 =?iso-8859-1?Q?bayFnv4+cNomTFTOAGSNYxSqAX55T1K3zoTuoj9M3G9NZokHSQ/TYetg0X?=
 =?iso-8859-1?Q?I0JFib+75Tfwh+HBbeLW5zpnWy3ONxxOiqn/0pctWOkegLDyC6yTn28Xqi?=
 =?iso-8859-1?Q?tsATWEIRN/Kcf02y5ZxtPMMfJu5Pn8TFLlljuJfRb6ZeJLJcXtW7pFMuhi?=
 =?iso-8859-1?Q?piKB9OFlVyWbnx2PmADv10677kecaoiVrJ4vODmmybM3qiiu8xMpPi6HFO?=
 =?iso-8859-1?Q?fER87JYKueaUmdpOTBv+Lc2vYYaiab80VkQ6wRI+38WnBfjNsEJYCwBPYN?=
 =?iso-8859-1?Q?y7nTKBHeBXJKUAH9dp2jB8wcS5E1GM4Xou4txMKJuuxpTYNNZCowjF5LXb?=
 =?iso-8859-1?Q?BpOUi9nvqzEhL7sin92JA3CxLXCaewan3m7g3dESK+ByBPsNaIOq0wD0KL?=
 =?iso-8859-1?Q?isVwWvOD8AXKHHhzhcKISp3pz8JxmFWQg3SE2ADGRv6weoejXNEXReG5Gr?=
 =?iso-8859-1?Q?ph7a1Qyf8YxLEGRmZW2udgEkpncVyN5ebLX6kU3Dj8FgkFk3ZbNsPinp7q?=
 =?iso-8859-1?Q?7WgdHEmcAMvibnSGtsUsyY5Rsi6SZNgY3YboAJEEN0kmTP5XIV8czOJT0Y?=
 =?iso-8859-1?Q?x9F9On/iBpZ06bzwPelczy7Nkx3p/WBqZEZU3vmePVMjYU0+q+1tDMqYoG?=
 =?iso-8859-1?Q?Vr0i2fse0Xi9wXgnighk/f36YmKhlDdE3ka91bcsDuI8vN8CTXCLvZEG6s?=
 =?iso-8859-1?Q?vOCC4t8LdnW0hduBmuF7TmpRVSwbdCTVzbZL1I5tRxsHR06rcisY1eeWm0?=
 =?iso-8859-1?Q?FSQuspRKOmSvpEDg9xtTa9uCKipcSQNXg+MvAP68mxTKyoQIerYAplAGoH?=
 =?iso-8859-1?Q?5v495ohOYWa5Ox3Qe2T+QgdbPRJ1uewiQNfyXKnK2yJ22wIWbQAjmRQOHL?=
 =?iso-8859-1?Q?yRjFPwI3Y4GMUp5ZR/s=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e90198-b308-4c74-04ac-08dd3979b7a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 17:41:49.0584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JBaG520gDRAlKnUssHh0k6LSuyASSc3gSCPtM0A/WyXuNA/HW1kcG+cEasnIqSCgnIjSLCW+XBQig66IUJz4tKFZbR1xgvEs022FdROkjsMyEDYS2dqVO5rhCw7Bq8Hz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7548
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c         | 17 ++++++++++++++++-
 include/hw/i386/intel_iommu.h |  2 +-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c58e18a56c..021834c41f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4202,7 +4202,7 @@ static const MemoryRegionOps vtd_mem_ir_fault_ops =3D=
 {
 };
=20
 VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
-                                 int devfn, unsigned int pasid)
+                                 int devfn, uint32_t pasid)
 {
     /*
      * We can't simply use sid here since the bus number might not be
@@ -4719,8 +4719,23 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus,=
 void *opaque, int devfn)
     return &vtd_as->as;
 }
=20
+static IOMMUMemoryRegion *vtd_get_memory_region_pasid(PCIBus *bus,
+                                                      void *opaque,
+                                                      int devfn,
+                                                      uint32_t pasid)
+{
+    IntelIOMMUState *s =3D opaque;
+    VTDAddressSpace *vtd_as;
+
+    assert(0 <=3D devfn && devfn < PCI_DEVFN_MAX);
+
+    vtd_as =3D vtd_find_add_as(s, bus, devfn, pasid);
+    return &vtd_as->iommu;
+}
+
 static PCIIOMMUOps vtd_iommu_ops =3D {
     .get_address_space =3D vtd_host_dma_iommu,
+    .get_memory_region_pasid =3D vtd_get_memory_region_pasid,
     .set_iommu_device =3D vtd_dev_set_iommu_device,
     .unset_iommu_device =3D vtd_dev_unset_iommu_device,
 };
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index e95477e855..08f71c262e 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -324,6 +324,6 @@ struct IntelIOMMUState {
  * create a new one if none exists
  */
 VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
-                                 int devfn, unsigned int pasid);
+                                 int devfn, uint32_t pasid);
=20
 #endif
--=20
2.47.1

