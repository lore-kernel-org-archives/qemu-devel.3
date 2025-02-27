Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C475C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:56:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbY2-0005H9-Nl; Thu, 27 Feb 2025 05:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXz-0005Ez-1F
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:55:20 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tnbXx-0005oQ-2R
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1740653717; x=1772189717;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BrG4y3xDgUJOKdvWUgQWbXUTo2tp+lMrO+qSWDscVRo=;
 b=OpWoC74lmR6x2lNYv0deQ5gMd0vrpPUAtzLXhtS+8Fkr/LT9JfauvuOi
 GsTAPEm87e//rG+WoBq4eE8s47g5cATCFiPFy4qax/gnwfjw1U2ZWbsfm
 wt9LEP2v8Sw9tr5iZWB/DFM2m/ZJrfz/jW5s3iHZiqbCN8BWablkXuTLM
 BUcNyd1jBHb+l/7bWqbKZ1EaJ+M8gj+Luv1kIo17YE22UMfiHhthSj9BS
 CXBx6qEYjC62V3BHAPAWDYAt4g0F+VBt21KRtG5FmUT/Ba0H+D5j3r1/j
 AiW/80KmKP2ssWbWxccWIDQpLevI1DSX2ubiMQi3sn4pVQZnZXNf4eJSy A==;
X-CSE-ConnectionGUID: HS1SXabVSfmRXLWQPjiYVQ==
X-CSE-MsgGUID: l2w9vF3uS42KCyPi6pYecQ==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; d="scan'208";a="33331860"
X-MGA-submission: =?us-ascii?q?MDFZ7LokZ0RlQ5fkn1Sq1dSTE2S7HOHsBW5VRr?=
 =?us-ascii?q?QXtT4LzungtCjHgPvN54DDYFvgeBhwO9ulkl2K7jT5+kxRpfiokwGSJ6?=
 =?us-ascii?q?w5DfbIbzucN/V+i9Pzy2AYwYLBjFUR469sRjebZAONvkzjRNnC83ZN98?=
 =?us-ascii?q?oYV867/NR/b1Gb51FNDZrDfg=3D=3D?=
Received: from mail-db8eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.110])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 27 Feb 2025 11:54:51 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7Rhsl791lsAKqn52lgftHd8rjX5wvDM2U7lnrqYW3OceX36iUC/O7I4guGhNa1mL/cKA/Lb8q0O1glgnLsBojArzjeMc3DcoJcndSiXI67l89WkMmOTPnK963VURo+jhNgEGy5IyecIP7pfwKYG395VYl2sDNS3WafKBe7rzKMQ1vM2vjtwtbZLUwYcFuwQLBYvx58MKvaJZSshHens5HLD0vo7VqTv6HvpMS68hjtdBjeRu6421XOIvUmUtJ2ppjYvgvA6NaIJSii5tOAOaBSmG9akHJkc0Cz2O2iZByO+O7NfTblAlT97sBkniZtPDXLPLoPtieE+E6ysfTB9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srhIn/WpdlVpAE2cNticNNYMCyk2sH0vssLZt9U3Azs=;
 b=hBh0AOWNPbDo4BKEOV2kpckLZ2ShF91mUEu914fpq4Wp06VVb37C1FpajEBfVmfzTbIyfpToxiICCZ83rm1qe2aPPkPeTYkWBgK1yZFPspPlxoKOg82mzsc3Q36pHqTHvM3T23X3UioUbgIRdY51EFIs+2XX9xgv1DiJQ7n22jMnQJSeq33Wb0eRc1S++jiu+FDBROBsgqzlNy/s2AotEBRP5ujQVxWakLu4cpDoiH8iHOIygOXQTHZbkNZYyAa5wtqCTVc3Ct9cTHdmOvkjf4MFXpsaDsStPRZK0lOKegp/WmyPCG8lgxIOmMd21MdkZlyrlDZgb2LcGYci1gGK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srhIn/WpdlVpAE2cNticNNYMCyk2sH0vssLZt9U3Azs=;
 b=RrK405ssbvZE2J4J7bGPDScMa9+StkrIqyNeOawjrx6B6TpciKj3QC6x8YOJ2k4o5e2qtjZrIx8Fsl8bJz6M3hYPauBb0SpdPh1Ph+YIF3wxFNfdWukXu0m+ueSAB7uHDMU9NIOPQrJidRI02Kj9l2sEqKgok475Z+GecfjoT9nRCCK4LYsx2sIVd2bwvzESAp5bir1Tr+Lo1ppqax6bUrXd6jGCtcePFFLJ7m6oDNjocdk70WxS5ipzfY50trbHiCkY5TJHcLQ2GO+pGfHXodyjA8lxq9FX6E9SATV5aY/wlSdN8980LSOX1IAqUehDfTbYarAp5gbuQ3fH8uKdKA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS2PR07MB9097.eurprd07.prod.outlook.com (2603:10a6:20b:558::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 10:54:49 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 10:54:49 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 17/19] intel_iommu: Set address mask when a translation
 fails and adjust W permission
Thread-Topic: [PATCH v4 17/19] intel_iommu: Set address mask when a
 translation fails and adjust W permission
Thread-Index: AQHbiQYF4tPCUB0tOUKNEerhRLF4GQ==
Date: Thu, 27 Feb 2025 10:54:49 +0000
Message-ID: <20250227105339.388598-18-clement.mathieu--drif@eviden.com>
References: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250227105339.388598-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS2PR07MB9097:EE_
x-ms-office365-filtering-correlation-id: d4a16d1d-521f-4509-1903-08dd571d280b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?PUQHtrxqCJEEXcVV0lvCCqtVzBMOtdd5r+9jxlYnHw9MYE5JOtHcZ1modF?=
 =?iso-8859-1?Q?GcK2GW3QWfYm84thwxSNEL4Zd2ea5ABSJRg+vXk65XhbhGr9U9spaG1dmj?=
 =?iso-8859-1?Q?1ZgPQ7VxsVm0KKEV/1alo4RhYXpanVTft1mpPthLYHMChE9LtebU8byive?=
 =?iso-8859-1?Q?h2xXcwWAF7CWWmVUfsc0wC/CKBqT27NSone21gS9c1fQ3fTXq2BUSxHdit?=
 =?iso-8859-1?Q?M3Lj5hbU3DdC/cM5tgRfhtgShtDuG011JnfiqYsEYcEbaQS3yX3cDl0G4p?=
 =?iso-8859-1?Q?Z/9EWpg+Gv2gn9WSdrTTLxdAhUgVmv3O1XITZJNyz/S6OrbU4TE4mN2hOa?=
 =?iso-8859-1?Q?ElOXvwgW2kHxOqfBqqCsM7i3e8rZodtNIXNGtxHFyrimRldmujxFop/62s?=
 =?iso-8859-1?Q?XfhdTHz2Nzg/vmZVhzvAG0tTcmQj/Ln2OCviMt6o2nbfMWMLYIFGOLAyy1?=
 =?iso-8859-1?Q?4aF4Rsg5imj7m9P1xmw1Gay0eezI98TsBBuUY7cq/BSTbnZUl+qtOnXFN9?=
 =?iso-8859-1?Q?qdwf487lhSAWJcTfeFWI3QX4bvXWvW+NLDeoD2d/BJfwg3agmEm1S/C7X6?=
 =?iso-8859-1?Q?PC/7FyM6bj17dDjoiO1j3PiiHpeJxMCIk9MP+k8gut9fV+d1l+5lM6ht0A?=
 =?iso-8859-1?Q?+U6gPRmi8RmUpsXTiT0JETLT9d4vT92wq7LsP0LjRAGdj4T89p2SbNKBFG?=
 =?iso-8859-1?Q?JyJYM+sSubuhtvMymcc+N/MA4/J7asMb6m+xLQPoWaPCJJZ0Szr6V0EaC4?=
 =?iso-8859-1?Q?dundkS3HgpImAd1MYp5lOpfpHAVMqqGl3nZOGeBj/EvnEyKlJ9ygf4YmD5?=
 =?iso-8859-1?Q?Q+DTn+6T/SI7mkbL4jP3bU72IG+zotlvwrAgjQ+TBMiDyGRasie4yyW+t6?=
 =?iso-8859-1?Q?Wjr2EkTr68XTJpwpGEY8NvKSOa57FsFztBfg9izUQOgH7WUV3i+3RmXoTM?=
 =?iso-8859-1?Q?rdRQ8skDrKraeK7dxP2lwpKcpN3jBUHzWQU87wgGnALmQ0LOHeNkI3EWGt?=
 =?iso-8859-1?Q?Vu87n9JdEQu9EaWWfqc2qTAWnL+v5nN9xJIC4iXfhch+woARAhvlIk0z1x?=
 =?iso-8859-1?Q?OK96vUBTe2OV++Mu0DXdFoPMZEwr3iOiD+DkSxsVimAgSPNIaNFebIYpWg?=
 =?iso-8859-1?Q?ZEeCiFVHeogU866o1VQXegEQ+vY/zEJ4qPWD551ef3jfCtCvXOJ78QmC1i?=
 =?iso-8859-1?Q?/VC+4RO5FQ7N1POFyDFrjPHwwW0HtBI4ICfk0JLfHmt0PGg70+jNYG5HAX?=
 =?iso-8859-1?Q?Ehmc8ScJ5u1PrNaFjyLJJJ6R5NC5qJF9SOjKEh5fxOYpuY2iLUnvl+YGaQ?=
 =?iso-8859-1?Q?g/nMGWLegeOseYmqChjq2iMq4QfkT6zQ8E35Dp7J46zHoxWnH+1cqXpB3n?=
 =?iso-8859-1?Q?oV4DQMBkQh5mCz9ZUzu/WjGmWxvWN1slgkJsfwecVzML9M8g5Y4Stm+vmt?=
 =?iso-8859-1?Q?37V9MD5AlyArTu2nTmz8myzI1GtlcGuB2NBQv+Fqs49KBVjdAU6lIf3E2O?=
 =?iso-8859-1?Q?OmkXW/metmsNGp4Ywx5O6v?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Dxgb/zHpk/OAFBeSrHTKpIa/zk09JqMjYvGEAXXhA2VAPUAF1IB3vZ+ZCU?=
 =?iso-8859-1?Q?jvf6Bm4XocB1fB6MfraiOXmLLuAbGUKcEmwF/oZK69LdINCtCTUPDJhjcn?=
 =?iso-8859-1?Q?zjtoCzWG3zbYbXBo7AMrXLui09o7TsoXQf+xbDj+8ABhNW88pe1nqCGOTA?=
 =?iso-8859-1?Q?oKQl9EENc4wkHXHofsjLC7NnxlPsmLq++XEzZdjBPx5cbFuiDT7U1Yif1H?=
 =?iso-8859-1?Q?3fS1gPAxJKsvJD8v+qarVHuCawKiyc89XrWTbEsXuNA2Jrvf72/SAuEspU?=
 =?iso-8859-1?Q?NjplgkLj8eMi9kaX5wknuOYcNMEoE37dO/gchFAdBmNjgTkC9KIil0K6xJ?=
 =?iso-8859-1?Q?kYBS96CUuPBeSOSGCFM6ORxGFzg0gm8ihUnlcCWdxeEONAZfyhYgAXzVbR?=
 =?iso-8859-1?Q?7VIAOKMXIzCEzfdoYCCP19wOkzZXqaMLOso4uHYyw1r14cXQykcguOht1z?=
 =?iso-8859-1?Q?8Cp6wPM20pSEaThOz1VUOYck2HUyRfkUGClqcWkGd7XP5uNa5eLvN4AEYH?=
 =?iso-8859-1?Q?1zSPP80LSPGqYqLEmSo3jQKOsB4NnSxIPHUHiOFi7j0/JgQqcEerhZSdFL?=
 =?iso-8859-1?Q?tEkQQ/05Bq2KJUidibQBQlHSnHcJzMzUA2MdQXPGsgtsmA1159r+tLyUR/?=
 =?iso-8859-1?Q?R6VL8uQN3TbnPkdjJLbsWt0G7BqUlow/364tUkztXR+3LKhIeevrU/CK/5?=
 =?iso-8859-1?Q?oqyXnZoY9tN+T+vUwUZS/xvmRk7TBq8O9oUwLAPs10QvNvrQUBJbcFXbrs?=
 =?iso-8859-1?Q?EEyKiPKYcDTl5GdFrq1nNKY3iP7XeZ3lM8jxFCtLwlfxwtTggUI3C+IP/y?=
 =?iso-8859-1?Q?oj75MEddqLhfXd8cZA/ECt3CizzOtU6YyH/rbK/OD0az63owfhq9+4OIxw?=
 =?iso-8859-1?Q?yy1ogMqM/PWwAwyZXU8WcUfpoWEIoH/FOC/RMQCwjkfheGSgDUFtyMgdtQ?=
 =?iso-8859-1?Q?3rW1ynQhWmikv6p9qrk2dDmOFUF0YIR9qVwxwTWZOpp5nkc+knhIeR3e6Z?=
 =?iso-8859-1?Q?rHuzmX3rSma/qdeLtiH8uxtkwfcolg49BE6HpyT+IlcBiWf8Vt8RTG+h83?=
 =?iso-8859-1?Q?9eRew2G4bBzIKXI0/p3xCLXykC9tOBjKslhnJUKRzqlUWtCbWA3plRxhux?=
 =?iso-8859-1?Q?tkMMBqOCluxuabYnzWMsACFJi/Hy2jxYb8XT6DekkhknxOxmou035rd+L1?=
 =?iso-8859-1?Q?Gk0nkx2oVUZoUNMbKj+aL2vDOwUf0Qfy9MHWs/UHLME/Tv5iCxFnmAOrcA?=
 =?iso-8859-1?Q?HUrBN2fPhFITtAHSB8jl8XcnQk/1vJZsXJxPUAX5L8VNKWT6sa4EIBP6sQ?=
 =?iso-8859-1?Q?ZHm/8ghVC4J4/Qfoetp7p/IGgxijBGUD3Yc9YXrLW45H/IJfWRBlsDFSBR?=
 =?iso-8859-1?Q?LZbwBigKpKtnyBsMUjLbmT6V7wA14ulPzgN5mjCN5d3ICTtwh/4lVKqGK3?=
 =?iso-8859-1?Q?fCflMJcAopFNYgP2rp6M6KBjBL3L8sshxYAbEL4ovYU3ubgVKrXsdxEtOg?=
 =?iso-8859-1?Q?PwPDFKTQ3q8ofOfOJkJ5kbVs9ERo6rlJc/lAfOx70aTWTfbnZIUmRN2bsB?=
 =?iso-8859-1?Q?p2RP2RgRoqaQ//U6Pq1nWLBzQDf9WMdKG1vssL+ILmOHn5Kn5XunBRnayH?=
 =?iso-8859-1?Q?zt2b9Na7fBShkz1qQutSBV2NRinwcCw0DqTJd9wx/7ye4FOwt3rkbzmF7d?=
 =?iso-8859-1?Q?4opAoRiTC3QYgPWUVk4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a16d1d-521f-4509-1903-08dd571d280b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:54:49.2137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIDuSq7FbstnAiIY7vkXXLLE/c/9rgZa69ymNlrv5Wapbkm+p1ZAfCNKtQkvZu3Rb1fSPsIgmaloiLQIe7zV/Xz0+GytaGDLNY45LcrJ5Rky9V6V/kh6oj+FE+j9zsBu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9097
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

Implements the behavior defined in section 10.2.3.5 of PCIe spec rev 5.
This is needed by devices that support ATS.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d3772d8902..b9b5d492f5 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2100,7 +2100,8 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *v=
td_as, PCIBus *bus,
     uint8_t bus_num =3D pci_bus_num(bus);
     VTDContextCacheEntry *cc_entry;
     uint64_t pte, page_mask;
-    uint32_t level, pasid =3D vtd_as->pasid;
+    uint32_t level =3D UINT32_MAX;
+    uint32_t pasid =3D vtd_as->pasid;
     uint16_t source_id =3D PCI_BUILD_BDF(bus_num, devfn);
     int ret_fr;
     bool is_fpd_set =3D false;
@@ -2259,14 +2260,19 @@ out:
     entry->iova =3D addr & page_mask;
     entry->translated_addr =3D vtd_get_pte_addr(pte, s->aw_bits) & page_ma=
sk;
     entry->addr_mask =3D ~page_mask;
-    entry->perm =3D access_flags;
+    entry->perm =3D (is_write ? access_flags : (access_flags & (~IOMMU_WO)=
));
     return true;
=20
 error:
     vtd_iommu_unlock(s);
     entry->iova =3D 0;
     entry->translated_addr =3D 0;
-    entry->addr_mask =3D 0;
+    /*
+     * Set the mask for ATS (the range must be present even when the
+     * translation fails : PCIe rev 5 10.2.3.5)
+     */
+    entry->addr_mask =3D (level !=3D UINT32_MAX) ?
+                       (~vtd_pt_level_page_mask(level)) : (~VTD_PAGE_MASK_=
4K);
     entry->perm =3D IOMMU_NONE;
     return false;
 }
--=20
2.48.1

