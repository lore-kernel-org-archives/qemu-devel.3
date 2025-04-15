Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F3FC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 06:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Zcj-0005nV-El; Tue, 15 Apr 2025 02:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u4Zch-0005mC-64
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 02:18:19 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u4Zcd-0002n1-NL
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 02:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1744697895; x=1776233895;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=XRPmcAOU570EzFVj7gVDhBXjPRvNPIPszuzxVIco+r8=;
 b=UYiJrrzk05z43nAyzoRpusZ9R8hsxZesRtbFbQGdwpEkcp5A/1zrvSv8
 7nPfn+9UqErlxhq96rEfRyZEv4+dqnATAEwRu4z21FKl3PZ8JNQ8S7i4I
 qsavkaiQD0q67DIMuvuQkbL6lapusfNiNo8e2SNhR8Hv3NYhYU1CaVMpb
 PcGXVzqtA2IjiHRTYHa7nducJSFAZ25hAZvzSEBnhYLV5gXZW4Xgt7NjR
 +z8Rsu0E3cSY0roCoQNVTAhfZSRwo/Gs7rT0uYLrJKGYa6E9PFRj5668a
 OhbSr7DZAs6vgM1m9Z9yGOQ/706mJwy80o3ehlLdPsLMjzemBLAsiOzSs A==;
X-CSE-ConnectionGUID: lFvEzuvjRJqcuWOLuRPMpQ==
X-CSE-MsgGUID: rHIkiFMQTW2Q+oRNKIPM/A==
X-IronPort-AV: E=Sophos;i="6.15,213,1739833200"; d="scan'208";a="35063610"
X-MGA-submission: =?us-ascii?q?MDFfdn7oWygZ3Ar+RLo+qzMj1f1WUtZiJBY17b?=
 =?us-ascii?q?dL+yykigq/eanoYorua5G6h90v5E0ePXU97YpagnZR/zqG2JLyX6CE55?=
 =?us-ascii?q?ODRVW3r7h5LoAHD2AgrpH1PEy1RgOl4SUw3FJMo26mVfWY5jQxa65L0h?=
 =?us-ascii?q?Sb4oVUz7iqdJ2y/mJC6Up3Dg=3D=3D?=
Received: from mail-northeuropeazlp17013009.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([40.93.64.9])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 15 Apr 2025 08:18:11 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4Gu6WbfghtBVDo/l52NkJ+mFv5GYsbm2GJJ6tZ+/NvMVgaA34U0vhHxwR7tDp4rJa2TcdzDQm14fTjk75/P00N+mel3Sl4IX/w13cDQIkKf1yCTu7BxEIqP1cTZymfXPtIDY/PbsJzloYycpcoIhoNs2QnTVj1P9FFP8NbeKrex7TTojBczL84u01RlaMwE79ni3KAo1C0o3DOTrOt90FNSnTUVWTaDN+VQCZFT+6Rdg5yh4jSX5mCI48aTRfVM6y/CT9jejSN+EnTxahIsxP9ec5/dTLGxyfTZE9X0VrNthGXSmC/eWIM/7n507zkEP265OqMu8pihswrfH36P+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ur1RQ8OEJ0fh0HWDG9RrLzdlLXhZeUZLZS1C7T12Ih0=;
 b=cxnKLLgLeEXF+HbUwNP7gthE4kTeSVLAnGgyb7sIdrIkmDjz0UeY27biaHc8V1CwZbWVEcBAUvdS/b2AwA3i1dYw99PNe5vE4iEraUvWQmYMogiIL19+WEXGQkvX60EWAgeDTzqCQL05RzKwr7nCERC5OdMA51HY++J8bK2klDvD6ZznloDhYusqJ3gUosi2EMYrIWikhkdIQLY5jHgCJWflvin4kX8Xt4yW6lB/tk30j5NwmRdWCHspYkk7I0N6mEOG5tnBWsI9DNJy0be0NbyzaayiHMeTYJtKAQADZrVbdUUT99U9JaVqdRXkJ1bm63sbnYsUtgn7XRjhIj8Y+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ur1RQ8OEJ0fh0HWDG9RrLzdlLXhZeUZLZS1C7T12Ih0=;
 b=dRyQSQ+McsIdqk1s3BibC90zpHxIA/KWLhZTyw9rlRMHiP6vMeuu/EtoNoXAPgyQos0MSW8CWR6wuRRG5kEwCBxpClo6p+OgA0kRYGcAlmGB1BPF6YcK9hLyOVnaHVoW8tInU9lmlLXKWyC+EIH6Y6QPhHkFwNY3L1b8d3vBdY6skNPHSH8K9buQY+aNlZuJERCtBPpft2OJ3EaulfwRXYHDYmDeC4naIW82l1jq9ZuqnnrudLoGg9MpzUos6tNxt5Nl/Xo+xZbPFYLc8mEXGoZbnxPpTTaQYHJFHwS+vGFTf1OPQKv8s6xnKcUKucwobYuZS+127MeK1bi++XPpeA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7191.eurprd07.prod.outlook.com (2603:10a6:20b:255::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 06:18:08 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 06:18:08 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH] intel_iommu: Take the bql before registering a new address
 space
Thread-Topic: [PATCH] intel_iommu: Take the bql before registering a new
 address space
Thread-Index: AQHbrc4nGIHWbw444Um4nXxoEvkhVg==
Date: Tue, 15 Apr 2025 06:18:08 +0000
Message-ID: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7191:EE_
x-ms-office365-filtering-correlation-id: 089a2efb-664f-42f8-1e52-08dd7be54a74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Cnr/MIPRwJ3a6DQpRPU5IXA0koUiorzIAmUOy3mGJvhWqt6nsVdhO4d4gZ?=
 =?iso-8859-1?Q?FCot0Nc93tJox39zvsSKKaACC7TKiMe1jyhhX5uGqZpMLh7wBMTK5qVYc5?=
 =?iso-8859-1?Q?BjT+wX1pN6ZOt5BXSkR2i7jC8299eac37o0XTLE3H04HNLimmOu1jW2sPp?=
 =?iso-8859-1?Q?aCGZNu8f21ChiC+AfSnS6XBlfBEM+4rrUNfhaNZihT+ifQXyyFmTHwaSYT?=
 =?iso-8859-1?Q?NS6rvTvmJRoIPP0l+gasIuz7j7CvWIIQyA668AWRP6pIV/crkZT+78eGdF?=
 =?iso-8859-1?Q?2X1Kfb04BClqg/lvfAgxUH6qCXcIiwMH/qADKUhe5Khd9+fU1I9lVfD8YA?=
 =?iso-8859-1?Q?jbj6QX90SimI+3KMxQVAhhnbJuG+EXyCTAJMkw3DjyKM6licnmLtw6rThu?=
 =?iso-8859-1?Q?cp+jF7CfxccSAguzDuHs6WIFbY7Q2WZyY9YUGj/E6vJPS7klpBWP/axf7N?=
 =?iso-8859-1?Q?suDIxQosAb4P65DKvVrbjoKk7Xl+81PqMEyfTX0h9mYbcbJneBfxEqlT2m?=
 =?iso-8859-1?Q?ho243W+FgnyZUjdabXRt5QXRPI9P1OXIg4n+MXE6zbScsdpxYDbe8gAVyy?=
 =?iso-8859-1?Q?NqNiebMKzQU9NZD3sFVGLJtvRHPUfT/edNz6Em+gtFWLDl/v+ARz/w43+w?=
 =?iso-8859-1?Q?jG3rOXyeCp74ATjmd53ETPmm34RQ+4EHsLGAB7WtSBDpfPJwEWevZ8Ew3w?=
 =?iso-8859-1?Q?aB/H6v/WcXrN7iv99X3mA0APzn5Q8CapJVLqAiZCrRZhRv4vm9zc/bkEjn?=
 =?iso-8859-1?Q?WgYhBuqRQ04Mg+reAbFVaQ72BsGQqZAfDYVKpcAnNlR6D32Fv9GDizc3e9?=
 =?iso-8859-1?Q?PbvjYiFG+fTQzaayDHLqe5Pdi7Fpd1O4M3irdnaAKhwL6FCMdMrjxjQCfI?=
 =?iso-8859-1?Q?BHL4acHzCFt9yyn2ZBlDlSZfLZCsNPfJ8Ny7coJsu4yRV9bCefhtipW59W?=
 =?iso-8859-1?Q?CoZjFfKU2J+j2ARXjKxsPjpCXKHaVIkPIUBbzPbDz/5EgaLoXQPa1s1LbX?=
 =?iso-8859-1?Q?hKkdu6PJ8pSvkrgVeqom+0lZGaZucaphYxJE3u9ECbVI9CyOnpTcjRf2S8?=
 =?iso-8859-1?Q?fNmluekF7Swl561mPQ6WQAqV3BwbywYGXbXdQoQmhCid79OQ8nSQBxLXZF?=
 =?iso-8859-1?Q?8Lk6i7k7q34nRLepX1hy4XyZ8PreuEGxcwRCw9ycfWo+FlIymgwP29R1qp?=
 =?iso-8859-1?Q?C1mQG5tH3gzR6KuK6qjmtTXtOBRZiUNTD9BIDWiirXsfeC9yOH1c2AiR7T?=
 =?iso-8859-1?Q?WbBeYXMRCdUd/Ku7emnhvLDBQ0bmlZzyiXTvOZRlt4MTmhOPLQnsPJmM73?=
 =?iso-8859-1?Q?2A5th9KexVVV78oQYuktO6wcyq5WVwo/RbIu9z/fcR1RZlt/AL9Au/9ml7?=
 =?iso-8859-1?Q?B2XrY14vQw9DCnj8HRbkw8eH3ZULe4ru2MlsbY3PNq45h2/mAkDoSKPcyR?=
 =?iso-8859-1?Q?R5YzV8b9Y0n624NRWGOcbcyy4w/anUrquijt0QFTXoqPj823frGX3ymVws?=
 =?iso-8859-1?Q?FDMmdgYWP1bFNP/lSNXgI/sbKF/xIn1mQ3Wef3FfAaebEldFbraa13HZTN?=
 =?iso-8859-1?Q?SH8paAM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OaCiDN1nplUeD9+ldiigZ8syNeR4Yf9L2P0PJszYVrl3Z9dojBMuQjNd9J?=
 =?iso-8859-1?Q?A5sYNZOmMRQjQNTejj88JBqjxoyi2iuACCH3o6hsWW5LSkMzmwkc1Dv0sk?=
 =?iso-8859-1?Q?ImRtGzZ+Or71YwTZmlbSvAG14iJ7HxUCGC5xU3rT3XaykwRWvCbxMQpFUf?=
 =?iso-8859-1?Q?kHaFBDGSBJetCtDkahR2ALpsoE0q5kTbTAzLLXpBOwyx4K47c/IDUdrRoj?=
 =?iso-8859-1?Q?KECh4TYcrPZ9x6KtnIj/hSyDyPd2dSoRsEt6EVzLndxHerjPEwvDUxvzkN?=
 =?iso-8859-1?Q?jm0Q9nWCGZHqjlimJnf5YPikS04Hr+Bemb+v4oN72o16e+omdoiY6ezil7?=
 =?iso-8859-1?Q?Ny/FU2JXauSZR3euS9Y65NDgaU0scpc3avUhjQeN6jbqPvNlRS7Ib4fI+1?=
 =?iso-8859-1?Q?gU4QJRenU2EfQh21wdMn2U47Rb0mT7+wtKt79d36QLbOXf9Nv3IZ+aEkBj?=
 =?iso-8859-1?Q?KsnbeyZqOXGYvwgv2XCOBbJhCfg7wZO+bKkMuQBPaFkSo5xPLXFT5gieER?=
 =?iso-8859-1?Q?vL5IWy5zmGettiWZoTnwRqFCwCgh0Ccl/9hpgd5XXi3fANn1LOMOyfjdYl?=
 =?iso-8859-1?Q?ecZZWqj90jGNsyzw52F6uBcmW25tgDOdxcy3UI9XcS5hg0hCUK7aGHTOYn?=
 =?iso-8859-1?Q?ftIR7VcWmqtS+EuW5hIAm9LOJHtrAmUbIPUPG7O1I/zTmImyrlV3GwBr9y?=
 =?iso-8859-1?Q?1TgjsmDHZ+iRZVaNaxdIT3wY7ZafIk96EyjssgERJKBDeO0J6akJBTOJz+?=
 =?iso-8859-1?Q?2Kj5xZ9tVqCcj9Vz2eSII7L/LPL4r/ZFD2xmlSsJbf9fKRe0HOrumN//iO?=
 =?iso-8859-1?Q?LRUuqk20DcS/6ISTsk54NLqzcppc5yrzO5tUuP+eBBNTtYyUg57tE9RClT?=
 =?iso-8859-1?Q?8jz0ylII5p/HTF4xwmVuSRTHnbno884TAXFVRsx0TeHnsNmrtUsRFYv1Ep?=
 =?iso-8859-1?Q?cKVNrlGDzn/IYC0dz0vT+9nJhB+iRZTK2MkdAE5oi8epOTWDe3IhUVFeiy?=
 =?iso-8859-1?Q?JhGBfbk72B047eC9B/viI0Zjfnazoer5jU2N9nPvoUki5jloBNnzB4T9ot?=
 =?iso-8859-1?Q?RCP7dIc+6NZt784SaSspyqBhLZBGCfM3aCzmMcm56cUcWJVmvi01CQkUVr?=
 =?iso-8859-1?Q?uTAWw/jHOKMLlD0jCAY2snS41dNWYWEh2PngFhhWEINLURMrTESmv0+dck?=
 =?iso-8859-1?Q?OIDSvAGnOc7XhZ5oohzwAelWTTMaE5XczYTsbHMJdBdLrc8UsdixdhYsC6?=
 =?iso-8859-1?Q?qN8hVDNOmaJ0wIrCFYEwuANHqypTU4FfU3Hz7urlTxSpyZRyLe+az6hBTT?=
 =?iso-8859-1?Q?+BfrtAOPLcM0Ah4ggUqut5Ozhgv57/iE84YGThHCkoMWST67WGRhik1ZPl?=
 =?iso-8859-1?Q?xZ0jWVehKZUXqnrT2RwHVaXMNeRUihAdt8rSn8+xnMplEN4dunIwvTuC9U?=
 =?iso-8859-1?Q?9dtdY70xrMKfLeqIom2sEvTMkEaptwZwaUWODq5X7gCgPIwVyAFburMVBa?=
 =?iso-8859-1?Q?4eRBNwSyX6JIkI3EsydFiymCU/zH5OHwLePzPOsNelqvo7h6md+hss5e2/?=
 =?iso-8859-1?Q?Vzi00Vqp2RFCN7LsPMPo6uLzm7NeM7yzS7m3aTC/jhainkzmalux5rMl7m?=
 =?iso-8859-1?Q?vlaD+nnRLPt2JeHvX8vIUp+VrraCTQfDmeL4IaLdcsOYtXvdBwf+HlGwaP?=
 =?iso-8859-1?Q?XSDxa9a0WQEcuAHerO0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089a2efb-664f-42f8-1e52-08dd7be54a74
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 06:18:08.2870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhomSwKUoHVoLhCSWztPopeBUS7XZdoNSBocKmQNPgU75IJNI9DzxeSn24yFsrukVYOl88GGqJrxyAP9zFYN28LCT660ziuWISOBcK4ZeK7LiEbMYgG0vW2LAztqVqbK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7191
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

Address space creation might end up being called without holding the
bql as it is exposed through the IOMMU ops.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dffd7ee885..fea2220013 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4216,6 +4216,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, =
PCIBus *bus,
     vtd_dev_as =3D g_hash_table_lookup(s->vtd_address_spaces, &key);
     if (!vtd_dev_as) {
         struct vtd_as_key *new_key =3D g_malloc(sizeof(*new_key));
+        bool take_bql =3D !bql_locked();
=20
         new_key->bus =3D bus;
         new_key->devfn =3D devfn;
@@ -4238,6 +4239,11 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s,=
 PCIBus *bus,
         vtd_dev_as->context_cache_entry.context_cache_gen =3D 0;
         vtd_dev_as->iova_tree =3D iova_tree_new();
=20
+        /* Some functions in this branch require the bql, make sure we own=
 it */
+        if (take_bql) {
+            bql_lock();
+        }
+
         memory_region_init(&vtd_dev_as->root, OBJECT(s), name, UINT64_MAX)=
;
         address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd-root")=
;
=20
@@ -4305,6 +4311,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s,=
 PCIBus *bus,
=20
         vtd_switch_address_space(vtd_dev_as);
=20
+        if (take_bql) {
+            bql_unlock();
+        }
+
         g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev_as);
     }
     return vtd_dev_as;
--=20
2.49.0

