Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB35F606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bull.com header.i=@bull.com header.a=rsa-sha256 header.s=mail header.b=akz9+4Ng
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM4v0-0005VT-Fz; Wed, 28 Oct 2026 10:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1xM4uy-0005Ua-1l
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:46:20 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1xM4uw-0005vc-8f
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1793198778; x=1824734778;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=t7t0yMWFAB0SkjxysNAii5hxwiCPulIbB1gOoQ4ipw4=;
 b=akz9+4NgWca92A0WvMhJNRKsCs6SpLwppr4+5S5WsdE+XfqtAYQmW+G2
 s1606kf7CoKsixjTMZ2HaL22sgnfUuYpB+84rul8RluM/lnm5mBlPuAXt
 PYX9xhzoxjF0uBez34o/LML+FcF293NTwbkj/GBUuCD5T+fPSuDuaz8u3
 NCSmd7pdC8YyRru7l7sHcb7udifbiF+8HynLACywh1iOsyAVUsBWZ2ZsH
 DspYbdigJA75/75DEJ2dwD6mq/8ERZvfFZsZt44n0THsIxe1MX8DYCAET
 8tGKuwZVFcJaUEBFlHmf2Zsbon5iPC3mMQ0fCPur1Ngj7bjcjFKUA0/xT A==;
X-CSE-ConnectionGUID: pjaO7lfyT2OTdySA5VOADg==
X-CSE-MsgGUID: rQPDGPyZQN24YLmFbDjRtA==
IronPort-SDR: 6ae20ab3_GjlsO4lL+GsUsxe6IN3H1xNMveq1B93a2SW1oJfPeVj3UEh
 EglLT+Mx++e7kuwbPxdhRjV0KJYjUKIVhRdIqIA==
X-IronPort-AV: E=Sophos;i="6.27,182,1787004000"; d="scan'208";a="49049393"
X-MGA-submission: =?us-ascii?q?MDH/MidBc2WdAg20qGFYmD+bdmkVzBE55rc5mz?=
 =?us-ascii?q?LWUCL1e5Mfz3fS9IjXyIvj1nWJM8zaZKjxZVx077eCMir2jg97OkTSQU?=
 =?us-ascii?q?QLU22XvFC5h6ZGJwXTVzi8MPBMwJyX6BP/yHfxWmIQaSvh9tkdzMxsdd?=
 =?us-ascii?q?8zwPHYk5/NNwp6mrUPJt57AQ=3D=3D?=
Received: from mail-northeuropeazon11012044.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([52.101.66.44])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Oct 2026 15:46:11 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wX2B937jBEs58qMH0LvCuzb2nGj3bJnVfFm7mqBK4eMhwepfRtpJmP3oRTDlEBUGpBKxdsjJfJN+dKOG6TZHOeMjg9FTr9HWke5tIyQ0S+uz3oW71l1pYHMpYIs6ZWdW1vSw++LQB5I5fo17DZKAMxrlesLnKckFM79UhQedHw/9IyJEvWUDHA5hRpa39x8bshudL1JZpWw0jkZLNma12g7y/Yqk8vWJ5kZ1XwpNr9Jkth+pWaDNlLKvtJNkSgSqdxWa6sgYXHgM3pDkCb/jQ5oB4KyctFr6N6T73+m+SzBMX0OZ2ZDJ+CemWGxkld34W2fKM0CW73LXJzgkD9kdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7t0yMWFAB0SkjxysNAii5hxwiCPulIbB1gOoQ4ipw4=;
 b=gyPiuxnM2p6douIxgIvPSbe2VjT5mdRYVxO8mqGGJ07Ndd9/khNBDBYMUnb/h8tKBJpjw3Ltwo+45JD33lGUQR2UXmRLKEDyMBcwvqiBBCOMAP5AQOqYyvYYtfPmQi2aTSxyTOMXtppgE5dBYLbykixzjyZL/RH+xbLDk/U5934ZzKCfwmKeoOC3IA4ZpWfqwPT4uIVSwtI5URcMo+3jXtrZ3EePAhaggoZSo+3TISA7XtCOjjJ2mradlz/6K7NWO1DZFEBASdodO47F+CO+stcJ0D7+E1h4Li3Cmnw65Hq58iOx5PgVdhEPPr2KsMUJMzOs1xb1GLQMuqdGSXburw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS4PR07MB8681.eurprd07.prod.outlook.com (2603:10a6:20b:4cf::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 14:46:09 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 14:46:08 +0000
From: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "odaki@rsg.ci.i.u-tokyo.ac.jp" <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "mst@redhat.com" <mst@redhat.com>,
 =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?= <clement.mathieu--drif@bull.com>
Subject: [PATCH 1/2] pcie_sriov: Rework the assert statements checking region
 numbers
Thread-Topic: [PATCH 1/2] pcie_sriov: Rework the assert statements checking
 region numbers
Thread-Index: AQHdZusRiM30oKG3DEStgmFe8Zy1Vw==
Date: Wed, 28 Oct 2026 14:46:08 +0000
Message-ID: <20261028144539.691098-1-clement.mathieu--drif@bull.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bull.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS4PR07MB8681:EE_
x-ms-office365-filtering-correlation-id: 73cbe20f-4f4e-444e-b860-08df350233e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|38070700021|11063799006|56012099006|261021123027099003|261009223027099003|261021121427099003|10067099003|18002099003;
x-microsoft-antispam-message-info: Dqgqq+1wYg0B7aepuD3aG93A3vO+guBUbk03j+3OQ2N8Zs5D/35QPCsfCZtqsIlvLoXd01udXJbBo8kyV8vGZleGT93ch8fRA7Hra/3k21vOdm4GCKmFJ1TPbMWYLwWU6I+VuJkfpk70udM7Aa0M46wF65o+IfMa7ynrd+1JlDcBSSK1gMItaUbpu6+PQv9Kqhkj9nw7vsIMnNKZ2EG8T/k6ZJIyRKukMcNzFw7KNJ+bChq9t3+yLa7FwROsp8YSwlVQRnxypCNYfZg8dgn6c2p5IG0/mND1HvvlUwCBXoT2ofFnAFJ/Bbk6TwmeCZSfqSTjn2qhAFzPIqHG/bmPRKkvPlgltPFB9JCRC1sZZZYFh1bNcL4gZRk7xx424+/2mMjc2BfEkuR1SniSp+IND8YEEGxBfXNZUEkOYUF3Wn8Dpu1g7RCxhrMDwnluEoP57+OwQb7uuiWRWg0r8NwC/hJ7BQAx94JKAoGmVGj5cKMkKkjKxXOEIFYU/+524xPlh8h36SKxSALJRCGD7jnC8K/1QZflG6QP5J5+TGpUfo9gBjDmzbEV2rSYETPR2yF7b7LvqAS/vD8kHQ6V9veMEJOhLIIOTBLHQ07Yi/yUrQbsNl8JkCN2e7Jx40NyPsTC8q2m+7V1nfXsTtb/NA8UGF9+U313ihs3XxIJqjyyrOG29nM1vWurp4E/QzMmK+zDUiwewffVzZ/6TuIOrmdJtntK7Jj/KuOeocuMSWZNtMg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261021121427099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVhTSGl6V1FoK1VoWU9LRm0wUzM0SXJxVEI0VjdaVGgvT2craWNLL1JuM3Uv?=
 =?utf-8?B?cGhkZEg2UHR3a1VrVlE1K2hHQ2pka3hSNXB6Um1tc29NeUN3TVZDVlB3QWdp?=
 =?utf-8?B?dG5HTFRPZ1N0VDVpQVNNUWpDajRHUXU3aFY5TkVhYThZTmFPa0s3RzgvbUla?=
 =?utf-8?B?c21KclNHMmVPa2E3SHJjM1V5Tk91WkRSNVIvUFMwZkRoQ2F5SWJ3U3pmZVJQ?=
 =?utf-8?B?RlB1NVo5bUVxY0pXejc0Zlk0K2JFQUJ4UzYvc3hRRmljZXFCNEdJV3FQMVlT?=
 =?utf-8?B?Zm83bDJtM0V3QzdmN3pNSkpsWWhtU2hMeG5FUXNXbjlHNURDZ3hCS2Nkd0dw?=
 =?utf-8?B?TWpRUnh4MCtKSTVnNGJ2R21QNzd1NzdDaUlvYXRtUk5JYWYrd0REL2t2Qkk1?=
 =?utf-8?B?cDdVOTNRNzhiZ01xN3N1YkhxZGo2NzliUVc0UFdMT0xBVUsrSUlYakFSdDVm?=
 =?utf-8?B?NUtnRTVpMFpiZXRsWDQ4ZmV0clI0d0psME1MOFFLcE5obERhejN2ZW5Icy9N?=
 =?utf-8?B?Qnlld2ZnVTNFYXBydnlLQ1BhZmlGelRTTUlLOFMvMnlrNDRsMGJVekNoK1Bu?=
 =?utf-8?B?WlBXZkhNVkRNR3Q4V1Q2VEM2WW03dXNkWVRiMG5sWktnb0JkQnpmcEEyeGl1?=
 =?utf-8?B?YTBjT2huOWh0T2dCeVA1UUMxcTArZU1vN05xZGRpWFhHazBzNnI1V3NmT1RI?=
 =?utf-8?B?c05hbmdMdlZNRVRQdkpOZXBCMWx1RmgzVGFaaDBCZXYxdXQ1TjNhK2pzeWMr?=
 =?utf-8?B?cnBnSXlzelFZMERIZXc5eklVTGNyc1BBK0hIcWhzYjNNNDNDKzhpcWhHYzFN?=
 =?utf-8?B?b1hHbHoxTXc4Sk5hZFl6Tm5YN053Zi8xRlRvc3EreEhzbFFpazJlTEVMOXVO?=
 =?utf-8?B?eWlFVk4xZlAzQTFkZXNlcjgvT3ViWkNPNGJGZGJNRTNqVFkxVXpjekZXZTA3?=
 =?utf-8?B?RzNRclFobHZDMlR4VlZlMkg0U2I0TzNYTVE3cHpPa0x1L0crSEs4aWlDNStl?=
 =?utf-8?B?WmFNckkwQWxCUE5tVGtMWks0U1p6M1VwMjA3UGF4ZFRLYmlheUkwQ3BNZllq?=
 =?utf-8?B?bWVkS1FSdnBaLytHS1NQM1QrVjZBQjVvWUs5RnM3dnhOZ1AvVXhQbHBCamZ0?=
 =?utf-8?B?Ly9XOEp1WjNUcVBTeDhya0xFRTdUNFo1WGM0MjdwYkpGY1h1YzVSdW9RWGMx?=
 =?utf-8?B?UkhYR2FQQXg2dDlHU3BwaG9La3cvQll5aGhrblA3dzZBZGZrQWZoQmJoRHhi?=
 =?utf-8?B?cnpydzQ5bjdrenJKTlhnc3VGUXlFejNKZW9jNHZFVlhyVWVGUTlFRzl2akcw?=
 =?utf-8?B?U2RsWnZ3RXBXU3lQTUc3cU1CcmdrZFpYTTFISldQWmpzdk9NZ1J4MGUrRlVD?=
 =?utf-8?B?b1V1M3VmR1Frelg5emFncVJNdVpRRHFkUWtNSDBUelpCK0xKVTkxU3d2ZXcv?=
 =?utf-8?B?eWF3cXFvdUUrWUN6Rm1PUm9Ja3ZrRTRWbzJpSFRTR0YxQ0o5K3B4emMzV3d4?=
 =?utf-8?B?VjA3WU5TOFlQbmZEeFZPbUcrNUIvWGRUM3NTZjVuVnJEZHpxaUxaU3d5Q045?=
 =?utf-8?B?SysranBEM2NKdmh6YXRoT29aSkUvNnR0c2ptc1Bsd2tSSC9ud1lDTkRBWTFF?=
 =?utf-8?B?bmxsV3RHMDF3SGRBQWpYUnZpUTN6bWhYVmhPd2NJbkRDYUIxcGQ1Z2tPM0t6?=
 =?utf-8?B?L09rcWh2ejFCNElhWUF1Tys4STRzMkpqcVErcHhBbzBBeXdiQjRJL3ZtVFho?=
 =?utf-8?B?dFpGdHZHQ1NUWHVNYjR4TTBCMTVnR0t6ZnZaZFVRRlUrbExKUnkxcDduNys1?=
 =?utf-8?B?L1MwcTR1c3ZZVVNXN1pheGZQbzRMdkJiY2Zua2d3amJqY0RCRzNpckg1QlBz?=
 =?utf-8?B?MWxiZzNFQ0wrb2dIbDM0blRaM3M2bmFxdmxTdTRGcytVVmg4YW1mcFRRd1ha?=
 =?utf-8?B?Umx5WkViaTA2WCtib0I5TVBUZ01qREFvNVBMYVZXSzhaSW5JdmhWQUI1RnVT?=
 =?utf-8?B?alBiSmg3YXFvZVE2cGZ4NVhreGJUSnFDMGpwcXZsL09uZVdlNUNOTjBMbFpt?=
 =?utf-8?B?RTRYVkdDUUhDVEtSeU9OcWU4Q0dOaHZyaS9ZVGMzd1Vpc2pxenNzaHZzQjdH?=
 =?utf-8?B?QkRpUktVbkNXeU1VT2tMTWtzQytsY1o4c0xWUVBkQU9RN0pHUFhrQWs1aU5U?=
 =?utf-8?B?VDFJQU91UnlQeEhGcG5iMmpYMllXb0hTUDU2SnZzUktBUHBDclI1WmhTajIw?=
 =?utf-8?B?WFJKUkFCcE5JbHlwejBWMGVjWWxEQXJ5MEJxU1V4U1JqNUxlQmJpb1ByNEdy?=
 =?utf-8?B?MnZTTExDUHAzMEMrcE8wQ1A0ODVSSDI0a2hwYXZiM215QmlobXN4d3Z3aDIx?=
 =?utf-8?Q?x6MRIKOD9Uz1QCvw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 43kkyawhcxFl5SaskpwvZ+ZoEziw9X0KQBzAsdo60SO5BRtPYz4FN46YixcNSO5/tssb7s0bM33kBRkRNvHkdcOV9hgXL+KL2fxT0NlHBqAC/mT8Sni9OdPqxsWLSHEVodT1zmnR0Jp9Ef/fQ4ZI7dr/uTHDPoF+0op8vy0vsqwx2sBxhM09mensa28s4RhECz2F/N9NN4NtHSQ65VJudv3wceVUUfoVx7SWOI2VthIkpwHDrHKASl5JKlQpKP1HgodnwJeg7RNi/c9Qqy9g5m+3MS71kmgu+ftvu4hUCLcJn35Zg3Ld/SVosb3udx7Ez/lUYxGPjh4wpSO45CSMwA==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cbe20f-4f4e-444e-b860-08df350233e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 14:46:08.6675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DM3tW+YTMpCH5dXW+9r0qg52lmUC3QQcC6FZ/e2YpUmS8ac98D/EUIosSmypQaRe+8dY4lPPeoi27/7LEQdjD+BmPUltcKuHIhlqoNhsQsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8681
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

cGNpZV9zcmlvdl9wZl9pbml0X3ZmX2JhcjogUENJX1JPTV9TTE9UIGlzIGFscmVhZHkgb3V0IG9m
IHRoZSBTUi1JT1YNCnJlZ2lvbnMuDQoNCnBjaWVfc3Jpb3ZfcGZfaW5pdF9mcm9tX3VzZXJfY3Jl
YXRlZF92ZnM6IFJPTSByZWdpb24gbXVzdCBuZXZlciBoYXZlIGENCm5vbi16ZXJvIHNpemUuDQoN
ClNpZ25lZC1vZmYtYnk6IENsZW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGJ1bGwuY29tPg0KLS0tDQogaHcvcGNpL3BjaWVfc3Jpb3YuYyB8IDMgKystDQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
aHcvcGNpL3BjaWVfc3Jpb3YuYyBiL2h3L3BjaS9wY2llX3NyaW92LmMNCmluZGV4IDZhNzQ4YzM2
MjYuLmU2ODkxNDM2ZDMgMTAwNjQ0DQotLS0gYS9ody9wY2kvcGNpZV9zcmlvdi5jDQorKysgYi9o
dy9wY2kvcGNpZV9zcmlvdi5jDQpAQCAtMjMwLDcgKzIzMCw2IEBAIHZvaWQgcGNpZV9zcmlvdl9w
Zl9pbml0X3ZmX2JhcihQQ0lEZXZpY2UgKmRldiwgaW50IHJlZ2lvbl9udW0sDQogICAgIGFzc2Vy
dChzcmlvdl9jYXAgPiAwKTsNCiAgICAgYXNzZXJ0KHJlZ2lvbl9udW0gPj0gMCk7DQogICAgIGFz
c2VydChyZWdpb25fbnVtIDwgUENJX1NSSU9WX05VTV9CQVJTKTsNCi0gICAgYXNzZXJ0KHJlZ2lv
bl9udW0gIT0gUENJX1JPTV9TTE9UKTsNCiANCiAgICAgd21hc2sgPSB+KHNpemUgLSAxKTsNCiAg
ICAgYWRkciA9IHNyaW92X2NhcCArIFBDSV9TUklPVl9CQVIgKyByZWdpb25fbnVtICogNDsNCkBA
IC0zNDQsNiArMzQzLDggQEAgaW50MTZfdCBwY2llX3NyaW92X3BmX2luaXRfZnJvbV91c2VyX2Ny
ZWF0ZWRfdmZzKFBDSURldmljZSAqZGV2LA0KICAgICBkZXYtPmV4cC5zcmlvdl9wZi52ZiA9IHZm
czsNCiAgICAgZGV2LT5leHAuc3Jpb3ZfcGYudmZfdXNlcl9jcmVhdGVkID0gdHJ1ZTsNCiANCisg
ICAgYXNzZXJ0KHZmc1swXS0+aW9fcmVnaW9uc1tQQ0lfUk9NX1NMT1RdLnNpemUgPT0gMCk7DQor
DQogICAgIGZvciAoaSA9IDA7IGkgPCBQQ0lfU1JJT1ZfTlVNX0JBUlM7IGkrKykgew0KICAgICAg
ICAgUENJSU9SZWdpb24gKnJlZ2lvbiA9ICZ2ZnNbMF0tPmlvX3JlZ2lvbnNbaV07DQogDQotLSAN
CjIuNTYuMA0K

