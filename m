Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF46CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIqR-0001UQ-Gn; Tue, 04 Nov 2025 10:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGIqP-0001Si-S0; Tue, 04 Nov 2025 10:21:13 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGIqN-0002ur-SG; Tue, 04 Nov 2025 10:21:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfVPq5fsscKcgY4fFnAFhBT2xilcUBKrJ5BiP8GAPnwxJcj47+hsKvJmOVtNaZqIgpC2IH1xJDKIUU7ERrFljIuwcGnkql1NlMYwv5ahp3/yZdWrhjYNNpusI2Z24Rka/EqmHdzJZ3Hue06IbVI+NDM0gG3eelxqruQmA4/LUAOu3trnH5DiZK5HoiTvqySx2zXnoWOmpVkBc0od1Q/0XXIFZlQOaKMJGaKsHxGWcz5sp1ulQV1QJz/bONVdoouBNKTBAe286GZUFf+Jc2nhSZ02Fd9GJgiSS2JspltlVxVCrtRTJjWD48+pmH4b7YXkNntNxGpl9zokD7W32bvjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQI+CpvFx1MP2sjVn/XSj9ql4ipq/w2+pwbqUPHAgmo=;
 b=Mv7XAeRJk+rK3zquPQaxuHPKm2gMBRvXdxNIKS3fOJcnXUHxeGTZl2at4i+NQOUQ1QC7qCkAr+PKTrl1Pzn3WoBAiXBOLlRLV8EEeWxDaoIfT7Ww41vT2FCh2qQ/8u0oNPOyfBRzTAixhxlCASK0o911ImSAwlCO5mhQXj+sOgxMk4lBoRyshuIVzEFc0rfy5OVkCKNvyCoHDZFSPiZIV1XkZITFrDjcqn/UfUTY8mx+xOeoMJ0CfD9y2oTqGpnZDP2sAX1xLxK55i2Attl7eARaivqRmcxsmXLXvc2rX4px5loKZxHNJghsOeMaGy8QH9ndAO24xmLZzcXV1pt+jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQI+CpvFx1MP2sjVn/XSj9ql4ipq/w2+pwbqUPHAgmo=;
 b=o5qIoAn6YjVTPa8rcUT55DF+S8wJQFUlsrfcFvd6jfTd6UgEV6NIsj6HHKjyxxLU1Z+KOGnZH2imPdFhS+aLLHp8tisMFe0mREh/8SCAVa+9bKOxnOrTOBjBjBnh1wgGuFaLC0wDcEdgn3uCrgevH1SFVfnuAHjUubZSv1lV4cWompO7DoCOxrrP7gj2+8/3qFQoFf2edjRyMGvIlGtjqf1waf/TztiqbG2PeskN7mTRnUAYwAHt94VE89CS5beIamtMr5VpYrGUQPWg+3RSTu7byFPhtfmxyvT4jvKCZJ6qGbEBLvDd4r3o745yePvtMipUHoiEvDN6lu1Mm0u4MQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 15:20:59 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 15:20:59 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Eric Auger <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Topic: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Index: AQHcTZUAOcFtPNqTvke2OSuQhL/9/rTikUkAgAAEzmCAAAPhgIAAAELQgAAFgACAAAGOMA==
Date: Tue, 4 Nov 2025 15:20:59 +0000
Message-ID: <CH3PR12MB754877D400D19E57AFB16D0BABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <20251104142052.GD1537560@nvidia.com>
 <CH3PR12MB7548E5E1A2DFE297C4C65E0AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104145157.GF1537560@nvidia.com>
 <CH3PR12MB7548379E64E7A12904B5BF7AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104151234.GG1537560@nvidia.com>
In-Reply-To: <20251104151234.GG1537560@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH3PR12MB8879:EE_
x-ms-office365-filtering-correlation-id: 6242ca57-2c8a-4ac6-a623-08de1bb5c229
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?oz9mt2rupx3pJlrMyb3IpLZ48FTcK/FT/+ASPFHRmp+4EzFS3hqsXblHaAjt?=
 =?us-ascii?Q?DZ3UxCOT+N3QcZMzU+UVe1DtbafDEGn3dH/sYO+ukQcWA9yHhkwrRjpEHuMa?=
 =?us-ascii?Q?TSMMfiJhnbXhIM+/NC4+UdD+pyZcLdzQ+jBTLkuXcc2Fql7bFFLg8+wvHzqj?=
 =?us-ascii?Q?Vt7ALoPuV/fs5pUvhaQs71HY8rY0SLbaKLpLpZoO6oFbFuxKhNn/lhXIBFqA?=
 =?us-ascii?Q?ClHlFFK37UllMrY/t3KEkJuR1wsavA9lHn6AGiztxAm+DW0XPEgrhhk2tOqF?=
 =?us-ascii?Q?Dn0vBIkiDei/JBwvAVaycXkuJielREfsB72hwjOosNle+5BctivDVztTQCEH?=
 =?us-ascii?Q?m27LyyNOMavFHURG+0ZastbZybE4c41cCR+0+ghVUkvyOAJF9fCYtSMUt93r?=
 =?us-ascii?Q?QCJtbfh+qps0rldh6MjlVgZz9KMkBZZBIHZy7VUi+qm/zKXmgK96IoZIKBpb?=
 =?us-ascii?Q?U+eAR5S5/bnuQpTo5m+Z5UQhwoTFB+pP1s6Tfd0sq8SfmYAbsLIveH8NsFpQ?=
 =?us-ascii?Q?5Oax8lEhEwylFkB+Y/j+fbb8KNake/s7JD+Hf9R5y5Dqo0MxGYjqI9NIStq2?=
 =?us-ascii?Q?yMRLkjcMJlqjzr2EPX7XrnFxGVQQ3Ig8/qtz6hy45fatCRjwgbmA+4oPHPAP?=
 =?us-ascii?Q?zXL6P+wW7GxHOCXkgkInjkqK30Ix47MCSjp5E7cVrptm0Y1LIt55otVS1vgF?=
 =?us-ascii?Q?Ttren7o0ea49iscDWBqgLs+wJtEL7ILqg+3MFF0Uqvy6/aJLmMbYfhyqihEO?=
 =?us-ascii?Q?jY+KGEwD2Xyf2ejGpBDXLi0hLS/GvtbfEIT7LtsfiMdtG03S/FBq8aqlRk6s?=
 =?us-ascii?Q?V5jPV61DwbuLOrtpSEmsgDMCngmej8qI5WB7wv7CmAA2EwlLfZtXdawAlr2v?=
 =?us-ascii?Q?miSba8xgICoIeTBqk12oCA8N1HjBDhnFILdqnz4J5cXUtNS410OnTcq09nsQ?=
 =?us-ascii?Q?IKp9g6KJRpgBgsFWC6hX634vUMedqoJbQRZCp+J+Q7GUB/RaHLYeDJd7XPaT?=
 =?us-ascii?Q?htqMDEzBPw8y5CGHQu0l42pdmOsYDOua7hTJndcNIGyJstfDhHJ0axv6Q/17?=
 =?us-ascii?Q?JMEilo4W/NCD/+bNEqHX1Fc0TYrjercASyaKD9f6Y1pT16g+fUMp9oRdbrzG?=
 =?us-ascii?Q?ceok6dFqdBH4lsPzkMoI7seAPG5cCq/PT5L6ktXuz2lt5WJ1Pm3w5/Tau8+p?=
 =?us-ascii?Q?1MP5jr+7eTLPe3IL+x2/Bwdcbh2fkt3bjKadIvzq3hSytslQyl4cKTaSo3B+?=
 =?us-ascii?Q?pneIkI3cjMqk5pfSnYCEpnfbMS3aEhvBHvwAJHwSKPq/jRqcZ+mb2RKs8MU2?=
 =?us-ascii?Q?As8gSnZXIQ7sxiSbp/4tfHoZ6RJAyPa5IHvqvC+d9hKFUAQJSWG/taUp4cUv?=
 =?us-ascii?Q?GsfMu9pGLiZGuUN4D4FUpzoLM6heVuaPZAEqfgC7ln5F0qSFq0SS3DJ83y9L?=
 =?us-ascii?Q?fmUofxBpLex3X+if6Bd6uwUqW5Rs9DP6HYk6SHQvsklU8zDpMllUeMGEJ3xe?=
 =?us-ascii?Q?4iMz4MLItln31iziGh2bcDP8GqSrZ+LWbVoc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uxMI3cSrVUVNORgg5xXp/bgYB6VVYl7RxF9YuqfrhHfQZ3+xhXJ+LPR4+oZc?=
 =?us-ascii?Q?4EirgTxNqElludOy/tEVlB6WmubgkoLGa7vM726tFi1rBslA29zDHZoD+bnC?=
 =?us-ascii?Q?KJNbdMYCJYvi82k8K0myqjITgKIzwhZX2sswKhbsoieiIgybKJnEzVFlIjMr?=
 =?us-ascii?Q?mnDAJ9wsmir/+xs+d2GE+WH7DnzlgDi4s2q7A1QN442iVPbgbeol9CRExMQ3?=
 =?us-ascii?Q?QuP7G11BGDstf1/E19LQaO+0zOcUYK+SP+/ozIJK2kSHeW4r+GvUfC0O2t4F?=
 =?us-ascii?Q?p1kRxLXbINXO6CstOZYsAojjiF45mJ+VrwcK7oxBwYGegFPQQyFn0YDcT5Ud?=
 =?us-ascii?Q?rbbrjb54quUxGnLKDrGv7fQyWZAQM7j7eteco15nHe7yfRwz7GGOaroORJtP?=
 =?us-ascii?Q?WIy7J6FtJ0ydBF9/qbgcsdFmUiVEBGkacFxTda7u0lugs8N+9S6Emp2Rg0RC?=
 =?us-ascii?Q?fC5Xagu1QEQdfp8lWviWFqdQ4PJ190qmEUFDv7Fqn5EP7O+kUpedGIgbaC6x?=
 =?us-ascii?Q?Z0uCEt25usN4Af+exh7L7DKlJ2gUViJF4SR6FKE6k55X+ZAjTtu/hE+aR/vE?=
 =?us-ascii?Q?gTPPnemPJOCQsVk06M4uqf+3V0RcEJKtrIxmyNmiK+o8x4BlZ90zHbUgOEcC?=
 =?us-ascii?Q?UjsJ1JwMxa6LtjKmqMWH/qjuYqRHrIS63Zu+EkHj8LvPuxgNxm/SRh+oF31e?=
 =?us-ascii?Q?ydGsd7EuJcQ4tD6064AwtBhMYpaBsVVfeyaXiWUepeMQLP1I6E9lEnDsO894?=
 =?us-ascii?Q?fWCMkIe5jwRewHhiCFJa8i8r8PuwrovPhUFyAqwxaRI12V0blKAuX5SnODYX?=
 =?us-ascii?Q?OYWBNefNPMCo+PMBe3qYOaImvgOtTGMsTnM2f4BUWgMccOrPNcRIeNP2ojT2?=
 =?us-ascii?Q?Voc5/PcOFkoJ92f0M7+tz77CWtiC0a6UYkEtho1O6NIn2l3Ufdu4N12TUIRw?=
 =?us-ascii?Q?pydyd3HRGFgRWZYQdmwPuU5cu9tjd9voSDfNOLKM4S0gYoveIRLRlp/jKK36?=
 =?us-ascii?Q?vqwyjXaLH0m4dOwWXOGTM87cCVAgO35YKnM8PDRYolrDnmIMqyQz8CeCUjFi?=
 =?us-ascii?Q?vDcRG1jnxNPfVN4+VzrYbD0tLETrDMc2dfkhyZvRgW1sBzNaIKQ3YavdZRmH?=
 =?us-ascii?Q?ipNnhjwUeiIIzGAjONrfpdWU1fQOx+EdQLWptLCgWgXdqDvH0FGgxwvpg3Ge?=
 =?us-ascii?Q?D659rUDN00TXzXzTXWy32HadliomnYmy+uM+r0cC9nbEEUf/YDCoEu+zZvyO?=
 =?us-ascii?Q?gAITmFbDeE00sVcCa2u9ut170095fy5zxSiLzeIgtfu3Ssk4wBqN+hjLsB31?=
 =?us-ascii?Q?mPQiofKMMG3TkW7d+EVoanCGwz+E+/L++pAQK6R/4a1eII9dBMaf25qXQKxg?=
 =?us-ascii?Q?AcAQ4rSzP8YRW76Y5TOfZ8OT1wVKmB+S1gp8Nq9E/VAaP3prk/TiBvio0yEn?=
 =?us-ascii?Q?HvPc9adFtFtkhP1FUdgTP3zyMVCNT/zntB4IDgJJlfp8F+jCMJ0axwhX9Pat?=
 =?us-ascii?Q?Hi4uVPoT6rx9HzZacykNdhznqwNXj8voLAF8WqWopvEVRdD80+lJ85TlO8X0?=
 =?us-ascii?Q?xWPAM6etjJ08RngsI24uIhwSV+i8+VUoHn3n6LIY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6242ca57-2c8a-4ac6-a623-08de1bb5c229
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 15:20:59.3622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJHdzJEJJEG5/Mf/lklg+TSu4D0klBrdRbCOkTT4G6yzpPL0Vy7ZMwynnsHRRffGbO/YmcpsZ2NibMqwDdWnug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: 04 November 2025 15:13
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: Eric Auger <eric.auger@redhat.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; peter.maydell@linaro.org; Nicolin Chen
> <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
> get_msi_address_space() callback
>=20
> On Tue, Nov 04, 2025 at 02:58:44PM +0000, Shameer Kolothum wrote:
> > > Sure it is trapped, but nothing should be looking at the MSI address
> > > from the guest, it is meaningless and wrong information. Just ignore
> > > it.
> >
> > Hmm.. we need to setup the doorbell address correctly.
>=20
> > If we don't do the translation here, it will use the Guest IOVA
> > address. Remember, we are using the IORT RMR identity mapping to get
> > MSI working.
>=20
> Either you use the RMR value, which is forced by the kernel into the
> physical MSI through iommufd and kernel ignores anything qemu
> does. So fully ignore the guest's vMSI address.

Well, we are sort of trying to do the same through this patch here.=20
But to avoid a "translation" completely it will involve some changes to
Qemu pci subsystem. I think this is the least intrusive path I can think
of now. And this is a one time setup mostly.

Thanks,
Shameer


