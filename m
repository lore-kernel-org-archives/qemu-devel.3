Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5C2C369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 12:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA6rd-0000X1-Pc; Wed, 30 Apr 2025 08:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uA6rP-0000S9-Ie
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:48:26 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uA6rG-0002Ng-S8
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1746017295; x=1777553295;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=3d2K4ai88/Nw03ek+Ck5RdBzRffQe8M0Tt6iuDFs4y0=;
 b=NS2y0j1xZhuhQR1ezhPuwpcXucRCqJP8xSZxEfZZ/+v5/PgP8hGBhCbG
 FqQnpnwIGMfjysDxJLzIglPdDVGk9ywcQzxJ0YrCkgfspclqLw8SIjWG1
 DPM9RCBV90fMTqLDnAHL9SBq5aCpMRzGTr/FYSoxKjVcq7yMYFJ9m4Svk
 bwu/srRx/u5rmpJ8M6E8I0NR4+PVdciqCNSjxplwZmIsJKY2MHjbWzQ2A
 Gq/0eNV1ZIgeDIFpFSGjs0jjs8QpHYxoibTyjB70T+vHPySmw9PUDuW14
 sAAhjMi6GtDkkQLNE9JfPbTAPXkP3pasSeF7mEPBi/rlSkthUa9dEPREd A==;
X-CSE-ConnectionGUID: jeE2aEq3Qlmdi9xnCyhpIQ==
X-CSE-MsgGUID: mQ8nX6QTQmeCNRXbIKgKCg==
X-IronPort-AV: E=Sophos;i="6.15,251,1739833200"; d="scan'208";a="36007735"
X-MGA-submission: =?us-ascii?q?MDGC5auuFjU3EkdFJgE/JME9XkllzbyScaqc/k?=
 =?us-ascii?q?fvfxTEXBqjnF9qDf2wu7/fymuWjcW1lFtMDa8DaNaxdRj4vKP4WizdA6?=
 =?us-ascii?q?UOLUkjwXE8o9sl/XkLOvy5rByjJ4ISKdHqyYONHnrRhg0p35T7oPGxoT?=
 =?us-ascii?q?XmeKO7X2O6EYgCtd+IfRHfcw=3D=3D?=
Received: from mail-westeuropeazlp17011028.outbound.protection.outlook.com
 (HELO AS8PR04CU009.outbound.protection.outlook.com) ([40.93.65.28])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 30 Apr 2025 14:48:07 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlR89wPB3eTyv4C7AYc/MvhnAP0QbiyFwYxvloY1MAYvncHh0Jr1qua8zNrpxTnACfyQEmAk3eWkOAfyZxYeueOtJOVLRb4ker/EMxJZSpx0QwCiWyHY7FRg7+rT+Vthxv+MPME0EDBpcaP7/594BOXNSo4eTBfmogr8uUHSRbrw++uvcv5VVlSIV8PaJkpQMDqiCZTxYk+Cnu80gmmGhpZ1Kn5p+48AnUXDl5y8AxXjwuFG9P/fCwXZsj5tX390lP31GxIDVIyXcl6ST+l5XgnfaWLQUG25z6juZP1Z+BVUYriPvTWLywDdrI+cwKIJyoIiy9sfaPWXzB1ovBB5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMm9AWIQ2cNA6AfJycb6qHXYHuJEpKody+FbJHbKtzw=;
 b=FLB8LQS7R/actmIhA3iS4OsXrEgd+zFYtyoJGbahX0Uo+9a40xCVPa8/EJCOYG4MI9bX8PL8o7nCIEz6kDChzO70oNFJ0AdniKaQSwzp81ZugV+O5DW7TW7I5sPEiTm/rkEgcjZxBH5trI5T+RD69H96DvrMybyPSdagopmMOibAp+XknNgVuMFo/nByJOoodJBKWa98o4hguShT13TuQPazOZUppytjZLhm6wbFQqx3iaAa0z+lCeAy1owiXu3ndxE5L5frgQuX5Bm3AUywiCcSXOd5zMZbsuQ94aEKx5IPWoTl7RG8hZzDpwq5ayghbh7rNMY9zLdnt/ElQiu5WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMm9AWIQ2cNA6AfJycb6qHXYHuJEpKody+FbJHbKtzw=;
 b=aqvsLGXvraOZlffLaCarpStMoTfBajjgh6dc632EnrSJIprfRerz4wQ7Osdh2erlQvEma71DI6bnzZ3FCukgCsa90rOEdKRnbLXXHLKq9cJsJmWkS+NdSfQU7HiSx86RCTHkNxzgKUnVZyiKEfHPsMblxK7B0nSEoqZS6O3KFZYIi98fbTcVnZiDgglP4S2rDpf+PfrgS0pRbQJ/C5RlzZhgNHZA3K0TnilHHODgTjZs4Zwl1xSN0FchSJaJCQyEM8vpD/bdK69OiZV+99UZLIIp/i8ARshn8m+VnBwMa/L9DD4+/uViSW/NWQM1SjnTd83C0oURGZo12sCDg6DTFw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB8449.eurprd07.prod.outlook.com (2603:10a6:10:36f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 12:48:05 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 12:48:05 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH v5 0/2] intel_iommu: Fix locking issues
Thread-Topic: [PATCH v5 0/2] intel_iommu: Fix locking issues
Thread-Index: AQHbuc4dH+dO4qeI7EuJ1zAypjI1yw==
Date: Wed, 30 Apr 2025 12:48:04 +0000
Message-ID: <20250430124750.240412-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB8449:EE_
x-ms-office365-filtering-correlation-id: 30249355-e5d7-46f3-d00f-08dd87e54028
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?A5UjX5Y6MfOeJezevinIgk6UfTXgzGTzuzzCLpsWl2Fj3nvQ014XrC59Rg?=
 =?iso-8859-1?Q?iC4BoIhuASu0QtrHKdmjgZpFIsdbXEPD8cJE31gUv70rax3o4B41NjJLK+?=
 =?iso-8859-1?Q?svz4d0AJ9qWAG71N5lyE1eCZGaojDEldPJ7RCv563/ijlCtsjrNvHRBbge?=
 =?iso-8859-1?Q?t59tMuwge2L8V7RnKk4anHdF0EhXA53Cfca+TrO/gr3MCwafGWxi374Wri?=
 =?iso-8859-1?Q?UxI0aGhdm6H056Ee2r9+GZ1CM/A5+cQU2F5+sN5dJ3BOF6uHnhX7cMUz2L?=
 =?iso-8859-1?Q?T0qeP/WSS1RdSqkjHqlXGJg0DkUE1R7GkvAgssITtPUM12owoxhRFKobxw?=
 =?iso-8859-1?Q?xJ8vb/DLNetcX2HX7PNuRx6cIbpKZU8Nh2lXhL3XFp5c/TNZFgDgTmcja0?=
 =?iso-8859-1?Q?4uoXTOZJD4FocIGbMoTrf9PmEmKAAJFcaqV6t+i+S8U7fAR9nw1ZoIQLFd?=
 =?iso-8859-1?Q?7bLhjg2pKQOje4EHQPmi83zuNXCqnO5X9cslZradxjhdXSxDRtEAnElHEp?=
 =?iso-8859-1?Q?4cWpwU9W02QF78Z0nyu48/EA8nlw8fpkXWgk7Kfn/XNn1QCVjcopS6J96T?=
 =?iso-8859-1?Q?Seb8wAeTyswH2o9MIaS4DxepqjQrkb13fVTr77cYmNTnjgnAq9Zz5FeL6k?=
 =?iso-8859-1?Q?jo7XU4Ck8oUrvBiY87qPssqa/jJ+MHJyQHRHqHizTzp45Qr4H857ne453I?=
 =?iso-8859-1?Q?pGqrrZcrsrEBjo/D6cnGRRlG8snUiSlzprmMDIABSVl3Xx6BuCJz9YUob1?=
 =?iso-8859-1?Q?i7IbgCgedi9wseyY6SCw6IdTrx77fKlhHSKwQimNr4lW7qqja3dkvfY/C9?=
 =?iso-8859-1?Q?gvvWz9FQR/qFk2Nf0Puj1nS0CCK2Gyvkcipra1I6lp6gBmQdPTN5zkIzUI?=
 =?iso-8859-1?Q?kc9qlqaXWq/tGKw2X53Wcsm+05GB52vs6GPPoE0sG5wEkZSttwdm1ZDJOY?=
 =?iso-8859-1?Q?//hbNtM9AxVHlBCHHEMH0AAC96XvB10AKcNtmFDwElMqpC2sHl8bVhf1t9?=
 =?iso-8859-1?Q?2P/i+dSEulcJuMkRnIJRBKgYR11ySkdlw6LMS7j+WF6sjjDjYEwygg1jtZ?=
 =?iso-8859-1?Q?8IcurUg3l6PqiyV6mmbbMmG9dDKP4JC3PB/wOcuSi416JRStjZPq1GMOoR?=
 =?iso-8859-1?Q?VZ4TGxtH9ObS4RaONiToLZD/Adnj+Fc07sBQEoUBC7tyDFm2veUVVNRz84?=
 =?iso-8859-1?Q?X18yxX075w0XitWJzs5H8P3gTE/lKTsaRAP+gehAwc1qKn6aWtjW5tDiVF?=
 =?iso-8859-1?Q?EyPFk5jfk9tsXUZiq/C0ZSkYVeMVXXJV7oV2MomjJDzjrg0FvOBlpi+Xnu?=
 =?iso-8859-1?Q?gAfCCWytyOW99Pvkt7Kjfnj8tovOXuo37gjCmAdMZzjgQhmiNU0vDDlhu+?=
 =?iso-8859-1?Q?Szr6WlA2JutAC7x8xHadHW6YWzrr16JxxXrvZB4tS6qUe1nwi54BGoNvGQ?=
 =?iso-8859-1?Q?+uAxSULXcVTYZz3Dg0jnWs5PrH+PZIcuJm3/uN3KM1wbmSCO1b29djzCg+?=
 =?iso-8859-1?Q?Y7/XRjpXWvchw0WP6NEOWsMN/w1QKEYKz1YKiBeS6uGZ+bNGGGXfzcuFUC?=
 =?iso-8859-1?Q?CoE13aY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mLdqGKYI3TgY2JwkLMzwuA6S099fc4yK3mkabsDO2cZGzTCDSg1aRnT0Hm?=
 =?iso-8859-1?Q?BC1SCDr83PRcZAWUri8+VmruOqyt+DUlQrM9w7KYGwRP4j1U/Vl2mgNcek?=
 =?iso-8859-1?Q?i5AGHZaaWMgYQlbR0I350ndZ5/lu/nvYL/jjsC3SdfWgXnyIO3l0fwA9ex?=
 =?iso-8859-1?Q?+t6Ap4WPTCn4vL6g3fjR4+crwIQ5YKEFxeT/WzUDS270aODcwsbvErEN86?=
 =?iso-8859-1?Q?88jjcBVkKeplDOy7gGTwJ1Ac24d3zOZa9IRbhi0nQyQA2ET+ifGYUN4Ism?=
 =?iso-8859-1?Q?mEuGFtCortA0E1k7b7mOp/2dF2MNuf3PvOA2Wcrhh7uZke1MS4JXzcgP9N?=
 =?iso-8859-1?Q?j0/vj/9mY7luLTadV92Me3NdOIfPEwYtTLAqm3jCVwzyrfX/NKsGY5eeXt?=
 =?iso-8859-1?Q?nKu94MRLz91Rno3tnl06qKDDhtfWCtZmldUKbBn0/LWbzSzWj2CvsnYov8?=
 =?iso-8859-1?Q?uArTr9vCgHWbwaw7t+PjZ8wnnpE9vzoGjbUL7IF0JwnvkzPNza2W6VUe+s?=
 =?iso-8859-1?Q?u0zVuT4Tr0InhAT//jMdAThhNURyrxsZLpdV7K16sOwEN8O5AC9EPQW0lc?=
 =?iso-8859-1?Q?XCmIA8GLR0yYrBizEszyly0j1hEUYnzEV4cJk09JMQDTUVCwkxScYzry6s?=
 =?iso-8859-1?Q?hz95tbNonbEYkuHTv2eKSnKn9WxIAjcNK19kfOcT6WkqH/UvK15bkgw70z?=
 =?iso-8859-1?Q?rETYNZVKq3OZ+noSc10qD2SkC1iv5MJ93fFEr/91nyEHJP2tO8jGs6FaFZ?=
 =?iso-8859-1?Q?0c8k6GKn2EuZvFRBZRWueefJsoWthuQ58Fquyo2IDsd8L0KVMhF9NNmOi0?=
 =?iso-8859-1?Q?RF369Xg54vjZ3PdCd3CSrpnRFpQZj3DhmRxqwofNgGfNnH6pP7Vi5fGLLt?=
 =?iso-8859-1?Q?r+Vs1o7akK6vOE5tI9uPObh8qZ2myGvMPlnQFtfR57aDNYpXEbkpdFmypo?=
 =?iso-8859-1?Q?+UIRWhO+gpbE2Rx0VkMYgOi5Duv0QOKClCP88jzHenLO1DFs8uqkgrJDay?=
 =?iso-8859-1?Q?GKGtiNDHcgpD7lLjrG9tlE7B88kjv+hRWTIrqzPxzkIeer2gik06Aa4YLZ?=
 =?iso-8859-1?Q?p6t/Pre6WafB+tuA56bK+DlkAydRoDuxVdz+erZWFkL3HPfh9uGUk4KqtX?=
 =?iso-8859-1?Q?56rVoWnTbs0WJ0ACwoIgZWT1yIj7Vepte8IC94KEo1xhomc4VZofHzbdry?=
 =?iso-8859-1?Q?6M9RBblAxOqqEEyY5emtPQTALYTHnthd1utNw61MisrV/yhWbhvfuaiZYw?=
 =?iso-8859-1?Q?HOOhW8AL2+cO/FvI+tOXI3ubKTFbHUSojW2GU7ahwqIZUvVR7UUpV+CO3n?=
 =?iso-8859-1?Q?H5HYpT+zAOy0GBTSlzLhKTHKSaaa05vyXFNV5H5+C8NHr/7/ZDGa3lnmlQ?=
 =?iso-8859-1?Q?kz2tiLvv6LFCoiX3sIpCyZW8Klm0682hKucL6FjlLCVCJXxhSvPQBrqNn3?=
 =?iso-8859-1?Q?m6u99nhLFkp6dCRj1vS5vG/5TCbvkna+ba8xchjOXlk8WlmH3ASen62QpM?=
 =?iso-8859-1?Q?WNeUmSYHPIQOa1IEI0oo4Df43vncnQkjoLgHwul16iMjWzQNqozVHq/K7s?=
 =?iso-8859-1?Q?1lfLC9BGnoDhcJX3yj7ldoTvGgoU867NDB3Y1JC6UI6NHyaBlKS9ELv95B?=
 =?iso-8859-1?Q?ORlVZaBlKB6zgXXOrtYK2LQnJiKx1LH4gRuHxAvgPlO2UBCgD2rBwt+6B6?=
 =?iso-8859-1?Q?IRIp1kA6i5iOCnl6fw4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30249355-e5d7-46f3-d00f-08dd87e54028
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 12:48:04.9693 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9mEptCdH7ixlUBk/odYZTBGOeYzn9tRLpdj58awyGhzLLZXQwRrsdalG5YV8ZTxn+F2lWiB4nmnjFoRh/k2gaPRemaOyrLpuhVzEKLQniqYP7uynmsp22eBjyD24pfuc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8449
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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

This series introduces 2 fixes and improves locking style
consistency in the VT-d device.

Changes since v4:
	- Re-check if the address space is present once both bql and
	  iommu lock are held.


Clement Mathieu--Drif (2):
  intel_iommu: Use BQL_LOCK_GUARD to manage cleanup automatically
  intel_iommu: Take locks when looking for and creating address spaces

 hw/i386/intel_iommu.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

--=20
2.49.0

