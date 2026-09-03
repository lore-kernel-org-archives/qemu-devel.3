Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9648C624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x292p-0002bb-QE; Thu, 03 Sep 2026 11:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1x292n-0002bH-QH
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:08:01 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1x292m-0005t7-6E
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1788448080; x=1819984080;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=IFTMhxvhr196ID9XV2/pORlC93kA2Mpi/3W/dALREYU=;
 b=t3948HVGtoo6HXzh6g5dzreRM4u4nW3dDjmzgh2L84FvYdBiW2OYosOg
 ZUyRVnTmx06kgQPMA//bBlxFsaTBgOJMufQHhHk66aF1heDfY9xbiVgmz
 T3lN/FAearwhm5eJFhqot+ymGLOG2KDtu802T89bAasvgVLHT/LUbFSdi
 nyR9YR4ru01nLMqMbYip4rtWHWLsFmhKfciVfCmKfZWiU2lTKlnDhszzi
 MQh2hJ2sSfnlHfSuWAIUSlT2lfvPwqcM2mD1uHyjaXfMhMvZJTWUZX1RM
 e5AEBu5BP+8V738cF9yqCcJhSqKFu2/GsVAjZoeRj9vTMylmFEx2g2SQe w==;
X-CSE-ConnectionGUID: O2O1Mkj7TXaVT80M8umhhQ==
X-CSE-MsgGUID: CIxuC4oARDCK4Fpa39JyxQ==
IronPort-SDR: 6a998d49_CfVoZZCM3LV7DNzIHFX4bKJKEzxAodP/Q9Ujoxp764YZ0FB
 D/A0iftgxWY6u6hCGsXLuBy30APySZ+J7ppxpJQ==
X-IronPort-AV: E=Sophos;i="6.25,260,1779141600"; d="scan'208";a="48705324"
X-MGA-submission: =?us-ascii?q?MDE7FF2NhTbNh9/ctbEki5d1NaSEQOn4DuOVaw?=
 =?us-ascii?q?Ju0GLzLlnuTPK6F3RreBzkHnhryfCSV4dhbO41aO7rlWYY29VTzVa71h?=
 =?us-ascii?q?qcS3cOpUVh6iNxSrUxLskxblY1rYnLDJkA6s8IAVVGcI/q+qdl/QCaI0?=
 =?us-ascii?q?I7uWNdWceW3qWpQD8H1x8bYQ=3D=3D?=
Received: from mail-francesouthazon11011029.outbound.protection.outlook.com
 (HELO MRWPR03CU001.outbound.protection.outlook.com) ([40.107.130.29])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 03 Sep 2026 17:07:52 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eI6Wv76ExStpPrLVJLcIC1kT7c4itMN2iO3xFfWo1fxwm5wY3heoamkwQ+tCQbS1sJerUy+kVJiBvXx/03G+rcGLukLERowITld2kgDyvdqFdgawD34QFjQuFIJGYTjvgCqsxzPLeblSlH1uJVFuCu2h3Rl7qeej9LV7C0b1XWKEH0Ow6DRSr45O4NWgxZyECRJ30Jtu1MA8S/W3BNjauDSBsvdZNBsyrEtMUfvn1iuIwX0DaL/e7Z4TivCQmW9L/Yg+LJxJ/gsmGK83qmCJgbqvJI1pJXcXw7wzuMRCOFdbk5cUhURuD5Eaa09ZF1y0mjEu4dpNoGO7uyWYEHZs6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6Rr1+JN7IQ72UxOkn1I2K8ZEJGGRdaiE4o5wUJozZs=;
 b=q7au1+2Z9QChOVWHubOi4ERAN64Z0w5D/TbMfPktV7mw1Ou3PBvu107QFvkxFLiIj/ahEhwXTULtjA0wclvHIXffIEZ50lVtq17axR2yF9ODwj+1fmbMkd/PiJPu4a1V9d1mp89DdyhyxQStJMZc2/CLNABxzAxOhQ+WQ8gYwGtd47b+B7xa290JXho7WYNOMgjLkR9Cd8Cfo918cVwpUFuM2x9zfRTh74OR/+mH/lNGWtOFmGxdHDWSp00jER3S2I05VqT2H+aRWfitTozeg3oPYiWf/fLb45SVcgB3ux6soZzwg5BVSYLzfTzH5TfqvgTC4F/gRbg82bqZdzV3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR0701MB7038.eurprd07.prod.outlook.com (2603:10a6:800:19b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 15:07:48 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 15:07:48 +0000
From: =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?=
 <clement.mathieu--drif@bull.com>
Subject: [PATCH RESEND 0/2] intel_iommu: Fixes for FSTS
Thread-Topic: [PATCH RESEND 0/2] intel_iommu: Fixes for FSTS
Thread-Index: AQHdO7X7Y4gjCj1YX0aenVILevTlTQ==
Date: Thu, 3 Sep 2026 15:07:48 +0000
Message-ID: <20260903150649.2281104-1-clement.mathieu--drif@bull.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR0701MB7038:EE_
x-ms-office365-filtering-correlation-id: 64a31265-d79c-45c6-d721-08df09cd1de3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|6133799003|10067099003|56012099006|11063799006|18002099003;
x-microsoft-antispam-message-info: zzdKYIyb7Jp3wEOpDqYGUbauPmqe9ZS18l3jWQ4KQ7i0unZiUk/FhUP29UZ2RqFSWZmBGR6zI5t6lDQqo+q6d48TP5iXpEd80PJQy/xvaZJYyjjAgMNEyCSvCX+g7YiH1FtOjuylUh3pnd/r9RfiXVi4AROwsg7GvqmVKFKCv/yQ2v6OfbyDUaBCRZ2/ODuAmAmH1FUdmT7I4Wd9h9pNJDBcp0nKZToRcaVj0Dy+ImnbKerC82GAm/55JWtsW9ov/ZvvAjUFBZxVBEHFY8ayJFDHY7c+YWuXdYl5YKKeEXbdN8xjMIFdgcs81FRnPqpZiGQwzRg5JBsbeSO4ObeINfelqL9GrvYuRHMEefUchmS98+k9g7LMeGlb2IEXxJoHz5hYFVCLOFtvJxy1NAc6pDvLWUVHyE7mVaQzkUel8WQHJ9Qs6+KFvTiptBaZJxltOr2wZ1/A0xa6RSUAqqtxCV6S2XiM0DqIEWWtMBPY/3yBcr1oSJa9lLQcbxJrqC3x7M3IsAILxxfAobVRkpIw4tgfBYR9nhWAiaFaH5VQgmeqQH9kYjS6sirpFXRKYYRdbY9w++34fPcCITfMaVDjVR9UV3y/NH6IJ5qRYkX/zTkUWsZI36frjpmpb4D7OP8hwbumRZPC1jEvGHPAIT9XqZcvra+phxLy8/GoYZA0bZheLbuumT6HoCicrtWl6rjCWqNnDf2B5bpQtGAyRvekgy5mNm6ReLSLHqwrVOsggQY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?suiTzgT7xIdzMMO1h2skvFqkjzCkSrL42l8SwD0BG8PCC+v+KtFfv0QPqo?=
 =?iso-8859-1?Q?aQQ9nj8nOBbMZU7UtuE9pKbhz7E2BtBPDPsb+QZfaoXwz9HMVTDSMkRj9t?=
 =?iso-8859-1?Q?LphCESa9mvHrvUFO8fOHFmFIelvYNPVzHCYDzS+qlMAVJ7Q6XQHa7TLdja?=
 =?iso-8859-1?Q?rscZ6TnmsAgyxaIKqnPTyQLGvJxF9z3e9no6owjlKgv56pRyorhekUuPGR?=
 =?iso-8859-1?Q?wOkHA0MaBpyyo4P4BpMXZW69M1O0qBv52MxLrXFObjI0JAorZotM4Cm+LV?=
 =?iso-8859-1?Q?ys4mYRCrBWMU8gDbglXBgbo9ctyhXd8NaALwe2ynufhCiInJDiXDl4rHyg?=
 =?iso-8859-1?Q?i8ofvgzyrc8bSylAMGF1k35GV6Y1u3RgMfbExAa4opC7vjjdPvD/YowTH+?=
 =?iso-8859-1?Q?YmWy/ar8KyqCdZjnNPBbCLnF7hAuNm+2vOtQ7QeYf4+CswMEcw7YgInG7q?=
 =?iso-8859-1?Q?2HtilpFp1HPvmTk8Hg0aOBZ22/Tu+gVS865MDnKQuk9rF8pZuHsIUVE/Tn?=
 =?iso-8859-1?Q?QpUryi1oP1Rv0CPxuIHJtg4Yls/VlhrAO4ytA1wa/fBae+K/sJx09jYZi2?=
 =?iso-8859-1?Q?frSsOmvptudZYrOyTsW9YdK49rW8EH6nyo6LbQGKACb2hBC0VuxxIHuWQZ?=
 =?iso-8859-1?Q?ReRYH3fL95dlM78K0ghYKtIDwqzIG3c2MwK7Qzxfuc18H8BuEmVOtLUxd9?=
 =?iso-8859-1?Q?1lB0Z/lXczDQtzYna3h6Nfw2A2O+Wm641GCoeoYwVL4x6Ku8ViL/akELo/?=
 =?iso-8859-1?Q?CMuZVpIZ9q0mBkXEiqIFlksGuNMF1xDX0PKizN+0bG7PM2OmIEHkzLA+m2?=
 =?iso-8859-1?Q?hI3W+I/1xRHpO4QrYEDuvOR8QRUQb743F9R5QMlf/bJCeageVKjN/ykJhN?=
 =?iso-8859-1?Q?jKf24YQKClW12ddLTmy2zl9go8C/F+nLvmnFlHYAbpOJFC4iTwp75wZp9+?=
 =?iso-8859-1?Q?e3hFNZ6JSM6GWq0kFB4lywr9T8PizuBbik7A9SkLwb9p7xPmYjQHpVPHeU?=
 =?iso-8859-1?Q?AjvT+06cZgalF7nEIA0aesHDKAfSM0/gGttVquBd9xi43YZoYF/fXd9Wqh?=
 =?iso-8859-1?Q?VecFr0xVk24a+VAwzgE1WysvsX0JUit1qqADUFZfBtR+43aVrux/kroC8j?=
 =?iso-8859-1?Q?wpTyPltMvKTySjqu0sDyzHl2CWR2gDa+tb7u7bzzTBfLu/0Z5wbNMR8S52?=
 =?iso-8859-1?Q?hJIct5UOz3n9GeuAmPtS2q8UpPRA7BeUnM9+rBg3z2zqOzLhAr1vFzyOBL?=
 =?iso-8859-1?Q?wtHp5MQ5WF4fZSC/o7p6enBv+cEYkI7f4MR53HjKiFjwZ5nokhYVVPtk2J?=
 =?iso-8859-1?Q?zSVsurGQ9G+89Aa1VLK2/Klv8Gy6/lZzs/1Z9RBw5a4qRXF0Llp62qcL66?=
 =?iso-8859-1?Q?pi2kMB4gmWClx4MLBAFsnz8mDZMMsa7QeR5HklQXvcrNQfnnkbw/KtFS8w?=
 =?iso-8859-1?Q?AaAOYv1S+v3ta3x1Idvr9mgS7IpsPVb45P0gpG8aUcMdFJoxCH0bf8kcOt?=
 =?iso-8859-1?Q?Ncf1jUsixTTO4dSQARKSPH5HsCLjarRZgn20Lvs5zLhDyZ2LUPJ1r/aIEB?=
 =?iso-8859-1?Q?vfxnt+G7Z/kPVTSE4CC09fNU2XHx1YlsugEGsguC+5z93xT1jltWzxeeBt?=
 =?iso-8859-1?Q?1G5FVWEfjkIf5lYlb4O7W+zqP/jAW7ZrACVc1T8HYIGkLYU5qhb5T01NEM?=
 =?iso-8859-1?Q?tQ3FuMXz4tlxlnq0DbsY+vIGD6N31uguyaOOJ91jG8rKEOwQhTncpTvx8q?=
 =?iso-8859-1?Q?hBeRscx27O4TYBjWFQce4Bl/yMJ6siyFm7bzAPttG7zfbD0Ha+WAoJofwm?=
 =?iso-8859-1?Q?Z08MWhc/Yeicwe+H+5cyh4SsdgmfjTRyw9h7MyY4ZL4C46tbaXxk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QOUPCNQw7I9kqeVSZKXcbcHvQBvSfoyyibZjeZe5Njo+TX0bD8nOrp4R+xMJnu31bKSSQX8vtMjLs41ZT3EVjmWyDooJeM2pwGzI8q0rjEGMkV3q5W9HlFWu7LRW30y/dE1OfSgh3opzkhpVznpV0VszqaLykX2FtJBGMlu/LMSY0LzthxtIxv4srrPE5XE7nWIQfbHOuNb6Tw3OamMER2ZRvYEiAcdrRpLJFS//qX0Na1LGuBXg/1BQeaXZJAtdbRGOaUlaZQCSC6oeozCHa/na+Y+5JPZKtRLjJSi1q8TyQj0fr9B4Dfja5V2gpD7NX35H9deYSWRWnILVeOYk1g==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a31265-d79c-45c6-d721-08df09cd1de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 15:07:48.3439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Tn30/JjT+jXGyxWPKs2HYLtm1WaEyAgG+/K8s/Pd1X6lVw0/Ox078jQ6QHM2wS5lk3SX6kchWyg7cc1ngDIPFrSXtMYv0SW3xvILg9OrUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB7038
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series seems to have been lost since we approved it.
Resend for integration during the next round.

Clement Mathieu--Drif (2):
  intel_iommu: Only set dirty bit when PTE exposes write permission
  intel_iommu: Always write all the flags passed to vtd_set_flag_in_pte

 hw/i386/intel_iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--=20
2.54.0

