Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7585FC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 05:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9GoH-0006V2-Bj; Mon, 28 Apr 2025 01:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u9Gni-0006Sv-MC
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 01:13:06 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u9Gnh-0003tH-1w
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 01:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1745817185; x=1777353185;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HzL4LvuinUD18kk5FLWji/0iUHhZCS/PqnfwsprGir0=;
 b=CfHmxht2gAjYRwNPJ5Sa5wylGipyYW3lS63vATtOambETWbJGM2+h+X6
 5UOwraJm8Uf/xUsnTk4hGSU44FEQGaQl7FhguxcvV9rGOyMWcOyRjR8nT
 CxEEOH3QDZ85uhiZ2h/p6TwPfZTYhnHogiERpHQqFW9qaI/bhI57Rol1L
 BUjgfZnsOK77kxIL5TTJyUqaTCs2hndVU73lSS4gEL6aACz4oIvtG8tXo
 j4jwTkDTRetwKLY8QpPCThLuOtxD6uAiqBjxz9cAQ1BlAU1sThJh3JoLq
 TfsZ1dPDTyYXkVi51nJKw3s5UXmd7h0SX8/TFr+lhCSlPTiimC3CRwNUq Q==;
X-CSE-ConnectionGUID: UPI5pYnYTG6QTc+i6uypEw==
X-CSE-MsgGUID: 0Bw0kpVRSwiECBXH0FVS6Q==
X-IronPort-AV: E=Sophos;i="6.15,245,1739833200"; d="scan'208";a="37932142"
X-MGA-submission: =?us-ascii?q?MDHUHlM/hn8jc4w5LdId8QyOIBvJctQwsy4jFl?=
 =?us-ascii?q?P9hzWFSArvuZ3IUgCVb0rz6ErH7LPCa8SuYlVYI/SRs9dWuVrIevht18?=
 =?us-ascii?q?FbEICCBN3NqpbXg96+oJrIIECqEH4/MZVLw/lpDdcXYLYM4HM3Zl+97f?=
 =?us-ascii?q?0VF/pdYo5jyplrtPNqjCfWeQ=3D=3D?=
Received: from mail-northeuropeazlp17013009.outbound.protection.outlook.com
 (HELO DUZPR83CU001.outbound.protection.outlook.com) ([40.93.64.9])
 by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Apr 2025 07:12:55 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gsze1UXCEJaIKEAopGYW3TZNk78UdY2NsGKaB677uDFMKNhgbj62FMrPAfg9Sdayz2/17X3VBLHyCHJ13WVFS+qmskeoQIUPEjuyVl5lw8MQxk19eREeBmcs1cAGcMhVYWWMt3X6gT6KHI7ifIYpjCwSl/cY2vArSr84OBOp1/z/MbzMnnsESaMBIEKGg4MevdzNiJ/6Bw9nBam3Yv+IDE7/aRoQja8gWkDOx1x4KpGBTFE3OEYtToT3HflG+oyh42cyQQKt5nE28vNL6/ODne0fMZ+YT/Cd+17qMxkqjiYS2ITUKVgH9DU16OP6p9BUKl0VFpBWQVYMvv9oRSpSTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9R1StYdnKqfE1N4pNHnY8WbGGb1Fh3240stUPWYpCk=;
 b=J3llhcuHxDzpb4cYstorNdnkmuUwOvlHiImqvHr5H0ZfzVRe0OZZJEJlz++noxmKl0AWXe9KehJCt8UF73uuwW2NeWn0wIjIWACrAUG9/ymW5T+FYsePBq3IWJo3WYPMxb4gwyzT8sKW6tN635pJbQqY+zY1bt3mrhIdEjNov7attnAdrl2LHd83skNtB5rRAndsM0dG0+1ixuXAUMxTe+XQnsm+jIa6eBJFMKcWfW0JMwzOt1UQedrzrUVOykmnTK9NrjK8RzglCN/fLdcY8VBDUNpqlj0EG0dgOC1WY4QJ6/RedKwEzBxj4VM02qtjXRLpunebXRwElX1MCnIZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9R1StYdnKqfE1N4pNHnY8WbGGb1Fh3240stUPWYpCk=;
 b=a0lce7cpNlmyWtoQLRkhKjR1K4aQ1/Xym2WCvAG5E+QodkCqxanIwZLM9EZkVVZHYsLafI1Urc6FfD4WdOGFoAh3STasFcg8cpSXW3k8HGj4MvOnyg0pJTlK7SYCCUfsU4Y/SEueXbLVfjRkyC9jc4u6S1m/enAVzya9fx/7EoUvFxx/NoXaiEGbv4pHDO9AJH4DVC/2j9hR2TSvTvn83STWEVnbaQN1Jk7wqtXw/yuyaQY6t52FOGVh1uYX5wuoj06Ikke9FIgZnDWq49owf0t5L0MTCuvlrQmb3fmI57J1GZQaNp6NBvSnAUAvjIn2wOjMdhWd6qumj1QtYdmFxw==
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com (2603:10a6:102:c0::19)
 by PAVPR07MB9240.eurprd07.prod.outlook.com (2603:10a6:102:315::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 05:12:53 +0000
Received: from PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::2277:7f64:468a:9393]) by PA4PR07MB7613.eurprd07.prod.outlook.com
 ([fe80::2277:7f64:468a:9393%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 05:12:53 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH v4 1/3] intel_iommu: Take the bql before registering a new
 address space
Thread-Topic: [PATCH v4 1/3] intel_iommu: Take the bql before registering a
 new address space
Thread-Index: AQHbt/wyL66k2ImJnUil8akSFGck2g==
Date: Mon, 28 Apr 2025 05:12:53 +0000
Message-ID: <20250428051235.10767-2-clement.mathieu--drif@eviden.com>
References: <20250428051235.10767-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250428051235.10767-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7613:EE_|PAVPR07MB9240:EE_
x-ms-office365-filtering-correlation-id: 313e2a0a-188a-44df-6efd-08dd861354a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?sggR0ReP7we1UDXbnZmrdHGJ5xeePcFcCG6Kk0FHSAVNrYu7ruj6NlfaSD?=
 =?iso-8859-1?Q?7UcsbliBYGWAqBMl/oOTfSon2vBofHfq1E5x6yox27uGy8VZ/ibP6QkMiZ?=
 =?iso-8859-1?Q?+hiaYBbydlCIximluM/fWtmLAAR57x4LCvb6y1T4uclgBV+HSB3eiZIPwP?=
 =?iso-8859-1?Q?ZnmiV42h79s/IWw3jh0uJGwVtgUdQoUKL5apODP4DBVARoNVQE0kvcVtL6?=
 =?iso-8859-1?Q?QN0PxJED939EqZVdBof8JEvtQ364SSeV13vhK1LnfU2Vg5KNNPZsHNjwJW?=
 =?iso-8859-1?Q?4M5trFBzA1FwVxSQ93U78VzII6+YOkS/nZdocTTmZSnp9DishAfH//GUq8?=
 =?iso-8859-1?Q?kUXsBT1x8JY5HG9Rgy5CzZ4NvnBob9PV/1GNijTMa/FSuOomXEVjtoSfLZ?=
 =?iso-8859-1?Q?OPAiIVli1SaAHeB4YwqTVCZQflOXZ7qQxAm2+LYGjDanvyV6OgLrxo1/IQ?=
 =?iso-8859-1?Q?aoHsufeAH3PUhJBKoZfyrf7v95Dev2djaKPUxjjzLznWrbeAIDESOUWqe2?=
 =?iso-8859-1?Q?wZJOxwWQxCEN+FtLqANQlPp6McdybdCvwUBpM74TDOmLpkpp286BTpWLBI?=
 =?iso-8859-1?Q?aHLRli69EJG9gT0rJnUzejoY68ojhK24iR1ih3JCtEd2luCk6xQjKXpODP?=
 =?iso-8859-1?Q?6AiLY5oNEkviOw+aSZ9PTQ+5j3TLv3PvCgoi/fWyCzDxs4r/URyPgit1E1?=
 =?iso-8859-1?Q?u6d8z5kA4cglAc1UQ8U2KchEzOfrAYOlNoVknV6SaxmTb1J+tNEZp80fhn?=
 =?iso-8859-1?Q?VZMFjLZFuwltKb9rGIG0ZuCosMz1PKB5p6aV1U3kMoWHelpTr/3P7cAi0+?=
 =?iso-8859-1?Q?NePp3wiGM51We5oYxCkv0sxZxHac3i0GYpT8DNBauTmx9ITfjzmeHqEpci?=
 =?iso-8859-1?Q?fVJrqMHofEp9rrEbHEA9j3qm5Z0xji4xtfUT5Emon0kVGSVG0IWwePLkJO?=
 =?iso-8859-1?Q?ydG7DSuQ8cf2626jnqLxZ+e6wGJKuzn15Mos0ifQY7I0o56U7B5cXhFXrr?=
 =?iso-8859-1?Q?lRjB1aVFHIxNIC4ZCRIsu/uWqcLxCCEJIXVxgf/knZT118UOe349Pie/Fw?=
 =?iso-8859-1?Q?jb+Ueq+ktb/qCMGmbkXpNlVo/W70PnwCb3p+H2vc6zg+KGqyyQsoOZOh8c?=
 =?iso-8859-1?Q?p+DJJaV+6FPNf77zTrUGmNHi32C2F/S5/cQMJK7kPUXCbbjggTiW+JJGR4?=
 =?iso-8859-1?Q?6g0THTpX175I6txx7agJh+swTm+WUyiFJk3gaSTpRj0/3/zqWVakgYg1ql?=
 =?iso-8859-1?Q?z64213AmkTcNQ/B8qwXc86t49vEqPxzOkBtKWFDwe3TwaQ2ZgnZS0Xs8TV?=
 =?iso-8859-1?Q?0lZooS30j1PgOjX7vnF/s3t5aChzglFrLYUT18jIXFy2F4czkro4rLqY27?=
 =?iso-8859-1?Q?qMTJI4l4nmKfrTt6J4TBWt2tIDm1nz+ODrzzNOtSB5pcvuDjAmnkSLulGE?=
 =?iso-8859-1?Q?N72BguWJmEH/x88ikV5iUZ0C+1rh0obf+CA4vldoLdPr+Cny7cznTwPTtE?=
 =?iso-8859-1?Q?SwYUPJZbO+3q0Qxcy852hYSk5XHvmZR/El8QGFH9R4hfibxjORLi3p/9v5?=
 =?iso-8859-1?Q?uWuGyM4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR07MB7613.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9V12gFOzkExnwxFfLRCDNjS5693UJbu+Pq+8XuKVfpYlsjsPZWj5lUMwi3?=
 =?iso-8859-1?Q?i12ffyfe9gdo9s8Vvb6ndi/O4u4o8HDpVaTNijmKJOVtUSB+sCi3tOXrw7?=
 =?iso-8859-1?Q?9NaU9g4MAn8P8Qu+JSgt5YU6UUQpUSUjAgrepQAZUhHPx6ACpCIjcALWfu?=
 =?iso-8859-1?Q?DbpEpBTWPsZlIlHClm7+OCRGkKZfx7K3SR186WAvKvHE+SW14AsPdORcUW?=
 =?iso-8859-1?Q?mt6zVh1rF+zQvSxtfrUWXYE5kPq9j2OouWHSo3prx5CuVHpy4bA9MlJisW?=
 =?iso-8859-1?Q?tbaTUrMEsqIEkUMV2jP7itQX1tg/fx1mEs5mNUdQSJDaze3z+RxnfPv+7R?=
 =?iso-8859-1?Q?SwfjEAoKZblInjU4g6gshp+s1u7tiyTVBrHN8L58bx/68aXgfET6GKorM2?=
 =?iso-8859-1?Q?unk79JOesv51G8P42MplNp7+apHbsnJU2j/0CQELhgoYID+KMFkSjXgHtb?=
 =?iso-8859-1?Q?1E/eK9KWMvIPM9W1Ks1grCOCmRpg5uOdgMritZuVeLTuB+4aMLQZ38b16Y?=
 =?iso-8859-1?Q?zpAmZHUNpGGq/nv3p40yEAG2rQloFAPx1dKwZO5zLdDr383TsfjxeQL4/Q?=
 =?iso-8859-1?Q?D8F/CxKZnvjjRdx1pZJqhqrDgZGawUeN/NUxNVVxEVTb2FC6imCr7FYyz4?=
 =?iso-8859-1?Q?W0BLRowyxk1eyEylzU9HJgUda/+1VvuG87NI9nLNnQfJ0Nh4I5+8JfLCDQ?=
 =?iso-8859-1?Q?gMBerqAMjJQ+Y/vRgUxm3lOfN2Y7SZrvk52KfV7FUHtun24G/qwQMFXF58?=
 =?iso-8859-1?Q?jwc9wf8HcZJCNM191YoL4PnbYUvgUxtrVcDbDf96GjTF0ZtqOZDKqxjisf?=
 =?iso-8859-1?Q?xfr9NMbaCKNHJwSieHMX3+wNQOsGZ+e6NRdCZNuuIxg/xHDJ+YwKk6rFk1?=
 =?iso-8859-1?Q?kUNbql69OZN/6HjW7N7VzMZuTmDc32HGJGQMElL64yUkMfKmEKY0o3ss/c?=
 =?iso-8859-1?Q?tsGDF54YHxVdCW4csVmf7PZw2BJmDROz4xorpNzBomyhNRUqBbu0vSekUg?=
 =?iso-8859-1?Q?n1QexYvwqunV4k4/qxun1g43iXXHgS42AtV+19W6QV2gpCaxyUaZH3gLHc?=
 =?iso-8859-1?Q?nZsYlz/mJEJogGWxpyGPskNuFKyCyeigs0KvKdFHs12H3LmfPsnmEB/3ZK?=
 =?iso-8859-1?Q?MRmhy8j1DtcT2Wa3VC8URCOpcgRZkSjO1FUaemkYQNMjHA+8qskLSMedQb?=
 =?iso-8859-1?Q?uYwCxr278kJJo67yVEGGu0LCT/4QjMzwFUL5ra1ee2fpSdmErA1TS5WIFY?=
 =?iso-8859-1?Q?eG4mNeBTb/l09F//37GvPePnrUvlNXsnTLOxVJp3Jl8IPbDHUy5ImuCDM4?=
 =?iso-8859-1?Q?DqnDsq6Ugg53d8hQweBsRKmRj4gN6e7twBVS/+8SrR0jpobsM+nskgFXFL?=
 =?iso-8859-1?Q?T4OBNVi3H1YF2fdx7c0oWWqp6Rc2pQj/MWL/bmnlfOe7xqQPeeHSxqkuod?=
 =?iso-8859-1?Q?jldNKGkzE0Nn8YNrFrcpACbWf765Ww7sYuCmALceLqAg67yk0ttX+qn9va?=
 =?iso-8859-1?Q?rra5l1wfTmw3BdD5jQMa2FAEnTcfb5K7Nxk1dRsVF7bfboeANzdF5Ud0QY?=
 =?iso-8859-1?Q?GtBOUUuvDeQvL5v6tFig3sz/fg70RzTpRKDtRy6DT7zCStDhwWMS6wn41a?=
 =?iso-8859-1?Q?AKEyrqrOpQqXNmxZOE+k376JzwB599wkV8xrIE7JPyOqv0RkLLFuxSE81Y?=
 =?iso-8859-1?Q?20SLV0J3Qa+Ru2xleK8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7613.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313e2a0a-188a-44df-6efd-08dd861354a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 05:12:53.8861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2GGJM++I0dwg+vQWJhhOlWekPiPPnQYK5tdjhTH1DT70/T3faENR3YjHATEIaTXYd4riUUCEaM0I3NBI8sItqV5kHbH4rWnQH2fjR/uQzEhHCpXUc1DoDQO7ZVViE52U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9240
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

Address space creation might end up being called without holding the
bql as it is exposed through the IOMMU ops.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dffd7ee885..cc8c9857e1 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4238,6 +4238,12 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s,=
 PCIBus *bus,
         vtd_dev_as->context_cache_entry.context_cache_gen =3D 0;
         vtd_dev_as->iova_tree =3D iova_tree_new();
=20
+        /*
+         * memory_region_add_subregion_overlap requires the bql,
+         * make sure we own it.
+         */
+        BQL_LOCK_GUARD();
+
         memory_region_init(&vtd_dev_as->root, OBJECT(s), name, UINT64_MAX)=
;
         address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd-root")=
;
=20
--=20
2.49.0

