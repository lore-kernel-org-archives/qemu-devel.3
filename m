Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A380C369D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 05:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Soh-0002Mb-Lw; Wed, 23 Apr 2025 01:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u7Soe-0002Lo-Ch
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 01:38:36 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1u7Soc-00065x-CZ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 01:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1745386714; x=1776922714;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+rBWwLccDnt+3M46adbZDiG48Ov/HlIQmH6rmQf1myI=;
 b=chLxpboGBoXd+knkmyLa5BprsiLuTmtH/RHVIYcgPtJq7xTzZZIdUJZz
 NOujurZPsz5erKrrMcmuEvtOgQnn9beFzaC465IFDPWJdxxEQRBKZRuij
 CZXA6rEpL0ZpS6KYyVMolQ1nTgnXP25D2Y5FxK9RcRxZFzmlg2g7dnCUP
 Wz4aiwRWPs+qtYsA0gABz2B0fFtRE4Xecybi+DkEVz5XXYmcQfax4TsNy
 z3qVH/dDzshaDbqI3WlZZSHG+MX4tSl3OYME5EcJPzgnKw3t5TL8JC//l
 ZJOiIhaqmIbv/srHZ03XjpqUvC89zNNsAVH+ReWMncuo5xlUWy6VKSvqB A==;
X-CSE-ConnectionGUID: lOv41cMuSb26LrwZBIm4jA==
X-CSE-MsgGUID: QTO4f3BOSweLsBeWLnZx4g==
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; d="scan'208";a="35542797"
X-MGA-submission: =?us-ascii?q?MDGGi+Xq5aebsQY8eqXWCRYzBGy8tjok30iBqU?=
 =?us-ascii?q?fOz9DkDyX3wLM3EwDuwMrV+jCeKL5/OdYSjzRzRyosI5scT2/Wj/o4Ub?=
 =?us-ascii?q?2h1zJedIio9mNGl05hsnmmjB9IsjJ9aAnLybfPI60ZVxErNUfH5hzc1R?=
 =?us-ascii?q?pWF1cIOBJGhggbfNvu9WWLyw=3D=3D?=
Received: from mail-vi1eur05lp2176.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.176])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 23 Apr 2025 07:38:24 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+Y3PkOPSUc33rcjoC0RyT4Je1Lla9apVWKC3Y5YDrvGib4o15wchUXkTOSViwYi5yNGA5fk5LkgSQVLSr0ItOvih1WaLCne6kzrXXW7q8EiVOoe+6unTvIp2xYay4IG1i67guNnwnrp5sPsjCF+UHEkEswVaxYoj+dFbxOreqCKbrjLXgT/Re3l/DrRWWmG5EDFcTzNE2+AUOBhF6DA8Hc5teQIad+r0mqsk+X0UfJiNTg2VA6ODN3cTu/Nl68XnX9NqWT5vBlG69sNPzHc+PpbmcRUXo+tEkIcTZQ8ln1GOjCDDAyjif95DMbtdfRDZOWttOz8XmF4t7G2DPStqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3vbbyDLOdZa1e+HZX/ppU9MU34FyxUfX/Bwbzx3RdI=;
 b=jQireLm6d6tS5H3/MHVxWccfioQEVlFMKN4DtrflJ+3nKDTextX0N5GYgyOWkgCTBNRTrOQlXL/uAoMWIJxdiD/KPGXwjX9o5im6c6tcyl8CQ03LrbIqLH0Rh3tb4RMni++45Nb9yOJmlyX7sOqVrx71KwAIzT9sHQHK/OwP17fP4+0f45+ES9WF1H628b/16jaqg8aUHXBM/DeDReKKA1LxCuVIus/Is6xecD/BB2twRO4yvcJTUJEkluPvcjxl3iMAyuswebB0KCB3vgZsorZHi5XkkK5L3eJ0Qj3MLi3eeeR61ddzmqMSQgMtVcyVcFehOBeFdvAkXi8YqH3YNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3vbbyDLOdZa1e+HZX/ppU9MU34FyxUfX/Bwbzx3RdI=;
 b=OIMCPutHsO5CcEIVuvaSNycSRmnbtjiEim891GWp8YsovQ2aYkSu/l01enNuoDwalJ3p6o6pXdkcibQu+5PQY8OzesQPgefL7tPUUdHlznc24ip37YETBDhbWNNYzzPxtAElBpeoHozlmltXj/vyi3SNDfexSi1B4tlNCecHH6YnaNHz8tjA6IjkBWdsTv7lsRwfPtn6f/ZHxEzrb5eirmjAxncNhWGq8g5FZoJnhjkVkOLZA9XjPtqsx+qEsfTYEtHljaR4qis6Sqigl7K6KaXnfmdiNESSdDpjanNKSrxWi4exRMGAJJeQw5az74f+AuGaFXYAmmxSaw4zh62Egg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB8516.eurprd07.prod.outlook.com (2603:10a6:10:35b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 05:38:22 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 05:38:22 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH v3 2/2] intel_iommu: Use BQL_LOCK_GUARD to manage cleanup
 automatically
Thread-Topic: [PATCH v3 2/2] intel_iommu: Use BQL_LOCK_GUARD to manage cleanup
 automatically
Thread-Index: AQHbtBHtXFr+lwkn/USAl0t+2SqEuw==
Date: Wed, 23 Apr 2025 05:38:22 +0000
Message-ID: <20250423053742.65401-2-clement.mathieu--drif@eviden.com>
References: <20250423053742.65401-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250423053742.65401-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB8516:EE_
x-ms-office365-filtering-correlation-id: 719bd358-29a3-4634-ae86-08dd82290fe4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ss/NptnfNBg6uJyLnFvbMzm7AjTb347zHQyUxOPDnUGOYH/Tcdc1TqUhFO?=
 =?iso-8859-1?Q?qRacBE9SGdZM6d7B774EvvB1Pt9Rn4LDEqZjef8Oi/j34pGDOnHdcivVIL?=
 =?iso-8859-1?Q?usZn+jV56Rd48H02QR3JUUbbUWCXwRARwb/3xma+353CmTWb5q/Xka4te/?=
 =?iso-8859-1?Q?6vzUgxQ8ItX0zfcUvLPkP2Z1kJY73QKPmV50Y0oJYUXWvevM099ePuzhD0?=
 =?iso-8859-1?Q?NpaJWRMZ8y2YqHFWxEkuy74Bwik6JL+mMI5HVuQNtrEpGu+au/oqOP+s8U?=
 =?iso-8859-1?Q?fQgHF1pBg359Vicqur2x/c4SWwyOn8/2oG4VGCEGe60sJgbMEHRk1g/rMd?=
 =?iso-8859-1?Q?dx5UTi79G7T9xF7eavv2MZQtI6ZgtWYp+wq4+kkYCVJyCtPUkKxzRz+EIS?=
 =?iso-8859-1?Q?mJkkh4Mz7Z7FDB1+y4dFVkA2zetq0TrwMiQNCj0BLo9GCRjRVZxLohXgp+?=
 =?iso-8859-1?Q?e/xvX9cMX+mc/qXoTdwXA/93WbS/qtYcp8fspU6sDXMLDSMLa6olbUrlCN?=
 =?iso-8859-1?Q?V+6BkDCCtz1HodEXknojgNYHv4CkWhUKibYUUHgEM+JVTF3Rst2KzS7But?=
 =?iso-8859-1?Q?7cbBpt7OA3J+BFEJxDZrcGfoUiqXpUMGoI0L/fagUKzXEyaEzcVIRgHdQU?=
 =?iso-8859-1?Q?YjYOZf0W4NNcP4EuETk6nVfGk2DCr3HMZBQJ2TvdsmK4Wh6ef1H3ccYjbk?=
 =?iso-8859-1?Q?fPsmj8N+uEI/THFBV5aLrJ913IAonESOUks5/jZDkbWJ9SVw5IXBmkSwkS?=
 =?iso-8859-1?Q?uXkiRJp72yK0/PoZu0+UuVjcE0U4JWnRE+yWho9drQ0YfsfrvSub2l467L?=
 =?iso-8859-1?Q?o72dWyaI1O8P+CbPfqM8skKLG+CLAVIsg9x/oXS9B+i1bhRTs7ym/l0i5i?=
 =?iso-8859-1?Q?slTXVcnPney6069Ju0Y5afdWbidGoLGj6Kbb36jKzO2S9UuWqMCwfCoRXA?=
 =?iso-8859-1?Q?pUnh4yWV/irrE+MtNsHb0sKS8R4FV2hM8//xhGLf8odexZzpbFmK/UQrrr?=
 =?iso-8859-1?Q?UNBa8566z+xHhm6o7hYLSC52vwUspO4bjDvZeYhCOqIh9hfkrpyMHQTpar?=
 =?iso-8859-1?Q?+oJS/0ellCf1Lo6nmV23pyWLxXeQ8bO11vDVlP+3ND7N+/IMGyvf+VWLLo?=
 =?iso-8859-1?Q?erlNyPE6quma3lECa9VOWlOAlERUMOzdJgnFNjAgdMPhpviy3a2xSXYPn8?=
 =?iso-8859-1?Q?//PbjJTPzv8XQcERdrGoyYoJxE+W4YkroyPoBsOkuISwjWrCjMekA5ungE?=
 =?iso-8859-1?Q?v9uZuRJQnoMF97Gn5lL86vu2weNmDtqmB12mpWPdyvVh+dPqg7vpWGW4fG?=
 =?iso-8859-1?Q?5ttiKDDC5HnK5Y5z4/7gAT6MvKpGaSc6mi+pHjboLXQ6bLo1PEMd+kRXk2?=
 =?iso-8859-1?Q?4JM0vuZdhSQFmynotPvmJlb/wTdTV6z3FXqvEl/idSd5VRAGP3mMwXymfm?=
 =?iso-8859-1?Q?hgWXyD6TVDhuHht2DYkFKRTZTKfQNEfL7JTBzxeSMqI/jPe8MMI690kFfi?=
 =?iso-8859-1?Q?tvPmR0HNk1N8+kaR5dk/kjCVL+MJ3HLKHUWxzllrsJ4Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rlhiB08rl43h506czrIT18Pm+Gexw/J+00ExhXJHP4iwa87GOrx8J71Y+8?=
 =?iso-8859-1?Q?aecqxl4SYbMlkhx9UlXTyaONsIVQz6nypMiYBo1lPpWR61yqrNLhBq59Ai?=
 =?iso-8859-1?Q?WpYkudXJ0SHdsPu3cqk9bEzpNiThyXR/PmGLYh5yOggIqWEqTrF/Jt3sCp?=
 =?iso-8859-1?Q?djgiCACXDrbP46kRpsMY92oKz11YeZ6cbpxunztWIwsAAWZ70bQagLa2pB?=
 =?iso-8859-1?Q?qdIxGXUbt1v4iCrj/dlHQQO3Z7Mco4IycEOKkxO5bOOJQf02VEK/pI3Gxb?=
 =?iso-8859-1?Q?hp12UwW6K1IAkF9sCVXwpDYPGf2ZlDRo+zfbOKvt0PDeZoPLQkk1iNyL2e?=
 =?iso-8859-1?Q?B3ygtRbBQDewnGqtIAluk2RbFwIU/+KdWapiO81VpJGKNBd4NvMCnn8JnT?=
 =?iso-8859-1?Q?ab0cDmos5fw7cs52IiO1rJKjhrYKrPGVWiLlSy0hpi1pIJl6YVBwHANiYu?=
 =?iso-8859-1?Q?Sfu0PWmYftrbgHk9BbSFFPEr7cuHZkToNqrogl+5lauBsBzFmgKxhUWQRz?=
 =?iso-8859-1?Q?bnUVUszPII9/HDEsxfG/E4wJ+xXenESeqH2b43jyZLiJK1OdAnfoMCcWIn?=
 =?iso-8859-1?Q?jGDLdecnqwdBvHgmPPwI3yAlyfkyQZTfqCBjNoukKCDq3uLMFlszp3ONgm?=
 =?iso-8859-1?Q?NUqAH9m3B2Ss+0pQSN7kelHIJ7ZafinXZmkrXq5UM9KQ26NZOKxGlRKelJ?=
 =?iso-8859-1?Q?gWFV/8rmrfsxGRENg38ZAaN4a23mdeT2Ebsn7XsodarcnUvhzAakYKfcb3?=
 =?iso-8859-1?Q?ex48kf05tJgKt9mQr74HyISjNkU0NKAdwbdDnHHywOl/khJzadXv8MIma/?=
 =?iso-8859-1?Q?GBbn0nC3672jw0oPnbQUrEeXnbeMZD//vHl33GqzDaIwPTt76LtWPysVO6?=
 =?iso-8859-1?Q?Uv3XXa1O2eL6rZf3tQ0kRkYVdBpQ9WQ0azhwzHjB+fs4nW1PQnN2jzCLCo?=
 =?iso-8859-1?Q?tqTrdYktpqb/WYa1Kp+30OLe3M4UX6KQrrXVSadvb2bpdiGW2bNNUGMNcw?=
 =?iso-8859-1?Q?DXFoCtuPTrJm5JeT++YwRUePMDPW/7Sxqu2FcErgfTzcJfkV/Efstrc4zg?=
 =?iso-8859-1?Q?2RZ3s9+DOpvdBqPwt1sR3phNNBSFruPGyPP3GkDuWyS3gA5tEo9ZDIzRda?=
 =?iso-8859-1?Q?tdKMIChnR2PBY0YKFcFMVPyVZtEFcEl1OzQDoC1BrHFXDlDGh19uiN6gCD?=
 =?iso-8859-1?Q?0IceBrsR1bb43lf4Tip2IqAlqlHH1tyGuXPTinVF0I3Cal5Dn6Exi5MqIL?=
 =?iso-8859-1?Q?mdQ06Hkn7Ocy7id4hrDdMgHZwPvFKqXQz1QInQKqhhv723bfv4qTO05JH4?=
 =?iso-8859-1?Q?HmVpIGumDiSY7648KGRgfLDzM5pItubKvGabBp6Cj+ZxWZvF7b/biR9bK3?=
 =?iso-8859-1?Q?+UEjPvbeIvdMLnGUWQ1CITpMYxzu5dF7NOvP6A5d6RO4vPJf5lq5UjvCeP?=
 =?iso-8859-1?Q?ncoa8GmE2+9ql1P1Yc81cwNFUvkhre8Urrkf9/GHTGmRYdtwCvTcMmteAO?=
 =?iso-8859-1?Q?7JzLxJC+6SoTLLpij0bJg9d+dZdqFD55JVstbP2aTjtbUQl5N4wr5fxgX7?=
 =?iso-8859-1?Q?dE/J2Hf4G4d3i2WjYcMgtbMU+StS+uLp9SoYDIwimgHcnE1aC07b5kReWR?=
 =?iso-8859-1?Q?IR8+VWTv5wvHBf6i5fapjDPFDK2T1YwM3Y0qOlv2xiqGKH4KkdvBBbW0EB?=
 =?iso-8859-1?Q?duWYqGUeyhxySNkf21Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719bd358-29a3-4634-ae86-08dd82290fe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 05:38:22.7818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WmNmALqpVi10jqF1bD/0+tE7cz/EsxwzD0e3aKgh/asn0mXSSLO3SmcBLGdUWl6d+nFZW6Nqf6TiDsd7A6vD9sQqXNfmwB5EMKs4bqTSwB060ACGsdYsqD1n8rQVQgAg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8516
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

vtd_switch_address_space needs to take the BQL if not already held.
Use BQL_LOCK_GUARD to make the iommu implementation more consistent.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index cc8c9857e1..b7855f4b87 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1728,8 +1728,6 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
 static bool vtd_switch_address_space(VTDAddressSpace *as)
 {
     bool use_iommu, pt;
-    /* Whether we need to take the BQL on our own */
-    bool take_bql =3D !bql_locked();
=20
     assert(as);
=20
@@ -1746,9 +1744,7 @@ static bool vtd_switch_address_space(VTDAddressSpace =
*as)
      * from vtd_pt_enable_fast_path(). However the memory APIs need
      * it. We'd better make sure we have had it already, or, take it.
      */
-    if (take_bql) {
-        bql_lock();
-    }
+    BQL_LOCK_GUARD();
=20
     /* Turn off first then on the other */
     if (use_iommu) {
@@ -1801,10 +1797,6 @@ static bool vtd_switch_address_space(VTDAddressSpace=
 *as)
         memory_region_set_enabled(&as->iommu_ir_fault, false);
     }
=20
-    if (take_bql) {
-        bql_unlock();
-    }
-
     return use_iommu;
 }
=20
--=20
2.49.0

