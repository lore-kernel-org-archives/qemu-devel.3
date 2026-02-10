Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DFAEA3F15
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 08:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjT2-0005Gi-4q; Tue, 10 Feb 2026 03:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vpjSu-0005G8-Cm; Tue, 10 Feb 2026 03:51:24 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vpjSp-0000pp-Lk; Tue, 10 Feb 2026 03:51:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruIc5YUv6KfWxv/70GFhdqXfCCLckdzPFIwVr9SgVVjYDa4iDOO6E6pEMLqtAcnc0ji4xU8PLBCK3HHEhBW7N0p3mrgipk9mZYHFFz2wWgG8xzgs56waVptfp7KX7BY/TqCdMh+xN0Eg/PH197UEJQl+c5YBu3vNM9rtVeCnvwKHROka2DgaiiJTaLEHs+CepeAMSrJ3bbwUEMYeaYQZxVi6jvUw7UHjpcFUuXrsR79wex3YsIR+wVnyu3GZy1+mdqvhCmF5obpjXr3MxrS4SgB9uNG35hhvvh9Wrk87mX86E7mpaANeQMCJWGWFtj1I53f40dnRxz+Inuva1AtbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnOkMaMzEJQY44h0pnpnf6GEK0Y3m0/ezPSznVqhj+I=;
 b=E2kVkeR6do4HEFcuAHzpzIHnSlw5PwcZGxXUsc3bNu2dIDK6qhmkt7Ja+EOGLUKF14RCPwHCl/ty8f2AwPQORj6YxT4izdm2AfNUjBRgpggqRT9a3yZPUKMdTMbOiI4mulqfWgxWALMuCon65IAE9piasn6tlL9/ey48DTBGZimJieaOolRGvBFCYU503Gr0PReYS/iVrlRvbH3yOdIe3wm8roS1rLNrf4oBYacSAjkabASyc7MnRWxXe//vFcobJv9+athaO+7hCDOBEe/OK5KOFBsodmom9SQqHhF0n8SKVMvOcTzdCNgN2VFzHJFjEXFLOwnR2zRwH8lRiydsxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnOkMaMzEJQY44h0pnpnf6GEK0Y3m0/ezPSznVqhj+I=;
 b=DXrU+gFrMtULbYuxIOFfBQDUzy9+upZUvLYMcquR8uQ7/X7q8FzAecA9Owrb3yqzf6krhPdK34He1vQ23yBHa59wqIxHfubq9mcdGJjDHMou2uFnMq6VMVUIWL6ttfD0wUp8Q8giLvESpk85AZtrQJa77N95G9OyU/CVsYtv1l6WlrG0JcZMh+hzwd1qe0m9gthwrEmDlmAUSc5wUET9amd24ixqjCqGIWorSJG562cCoIV3ipKLvKcA8O4dafY9RUiucH9fYjPC9P8V4FJtmxJeNof3MEDLuaFs9TuAVHF4GYZfCG3lgP75zzbGI7b7qcd9Mh98yOSCig7VMI/I7Q==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV8PR12MB9644.namprd12.prod.outlook.com (2603:10b6:408:296::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 08:51:10 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 08:51:10 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH v2 10/24] hw/arm/tegra241-cmdqv: Emulate global CMDQV
 registers
Thread-Topic: [PATCH v2 10/24] hw/arm/tegra241-cmdqv: Emulate global CMDQV
 registers
Thread-Index: AQHcl3fpE5/SjX5CpEeRiST1qC/aGbV7BhIAgACfYVA=
Date: Tue, 10 Feb 2026 08:51:09 +0000
Message-ID: <CH3PR12MB75480DD532BC21E77C6A65D7AB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-11-skolothumtho@nvidia.com>
 <aYprcoyITz1GuPbF@Asurada-Nvidia>
In-Reply-To: <aYprcoyITz1GuPbF@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|LV8PR12MB9644:EE_
x-ms-office365-filtering-correlation-id: 10529971-745e-4bdf-0663-08de68818973
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gXm3Rm/cXKpwCQkWC3ppha/w4VXACTPAjxXUXPyeIq17OO7f5IEemDHA2pHy?=
 =?us-ascii?Q?j/hRGvZy6v3Vo66PEqsRNuKVPmN0oBAfVpsd9DyT4K4OMbPN7rQsEKmhpI+G?=
 =?us-ascii?Q?GssxZJzhjQZ8/7ld/BDxKVRtGlF/i4WlaZqnzu8SHBO/uju8+m6IZGUgwS7e?=
 =?us-ascii?Q?q5dCySaokqUQt5jI+1jGadBGBbiWJAgNXg/gaCtI4qKxsAD78aJUny80OwRr?=
 =?us-ascii?Q?UssKZGRnzpnBIdvC0uBgLr5w0IPV/iWvi7fHPrOlI7CZCuKcIRdJ/FSUyhaP?=
 =?us-ascii?Q?2wxiYvlsx3/zH1h4HUkxwDE/P6D+KKH/y1N55i0Pc1sDQISlNJ/TdBqvTjAY?=
 =?us-ascii?Q?g0vkbOq3CK0jhs7GT6dkA80rOxo3J1W2TtzUWDu5Zl9Ub8w4VAAZsURxJBgz?=
 =?us-ascii?Q?zS+D5PQuFInnhoSjENNCM0BKMkz7bn0p/Bzxdkj3DJgVXkuX6ANN4VhstsgY?=
 =?us-ascii?Q?5Y4nCHd1fPq0qmjsKt4Be9hFnXuxtYJLX0ic6lpVg+esbx96KvnfCyd35tH0?=
 =?us-ascii?Q?8Ss4+HDY/avsmKACg+sQXd3At2ME3y6O/sygxHdQzVJrEIADNfFjp42Z4phQ?=
 =?us-ascii?Q?6isscUNvh6wgIdAvifgHTQRuU9IFwL4ZF5kqwCPGTtyDMz8Xc9jYGQsKyhOL?=
 =?us-ascii?Q?sInbDnNZPcZ9hQ9h4SQ6TbqbYFSG9+PSlKI+2TNmfb4AeSP7S7wssXFcoVqu?=
 =?us-ascii?Q?921OnP7ejsPIHnO5R6CL/JCsDzO2c6+Nu86LDcKcM24YSnxLHWJnueO1aHzU?=
 =?us-ascii?Q?U8bx97g6DDaw788hYy049So11hIhImeb6aif7JRgmpAv9pqhGMIRu8wvEwJ8?=
 =?us-ascii?Q?4LEVJkMLucBPWpgC0GEaGPBdr1YcMlUVS6ra9ICjsd0Fsp5icQZCQwEhDnof?=
 =?us-ascii?Q?K9KWuAdPKc+hOgSBSC5pdtah0VUgtfynBXepNDWJWvlJC3LlxyHsqfgE43Zh?=
 =?us-ascii?Q?XEEOj1y9HiPYUJHf/0uoQ5pFkvNesUW9xyyl2b6yvYmCqzRsU7djTaa14axW?=
 =?us-ascii?Q?RNtU5Kg3uy+o8IcOPkNEVIPhA0HWFVL7HXXngwo5JDse5VyxjBXa3ups3JdY?=
 =?us-ascii?Q?UXLAc3vr1azdoEweA4Azo/+xVIPQqGBq7q3s6Ue2Fx999YHdlrtC6qyxLjA0?=
 =?us-ascii?Q?08DRtLdrZ8lXbVk2843BQVFAOtfjJcUMYklqdpiRT9Y40TsnbihLPgJzmRtu?=
 =?us-ascii?Q?NdnhUoqJg2mGlBP+kzdgaFDCvbdpGxAYgtRhonnmK7LOsMLOg/0mSuYbvrcq?=
 =?us-ascii?Q?5UU/qHQLiB/L+HudNHabIY/RA1+pcfA3RMhHtHqbAhTWDj61El6iRhyov4xi?=
 =?us-ascii?Q?95oRqmsleURw1m071GlgKaIrd+Vn8xcdMGQ87sKJdalnk6PwrvnFStwRYbFE?=
 =?us-ascii?Q?l9jFy1gVMHwuhL95uDgBx/r7JwbIIQazKOtViQ3v6QohtTnBUCs2RpqQK4KB?=
 =?us-ascii?Q?lyPAm35n9AdVwwTi7EIUic4DdtwB9FtxcF8ubt1GdRuEkQDy5yxPxIMdZ1nH?=
 =?us-ascii?Q?KgCs7l4F+MGnPrCIkv8sT29BeOAaVFA8uF5u/fC1HLDRI6MPauCwlMY2ZGem?=
 =?us-ascii?Q?BDZPuXvoKuk3OdkC7ogP1+WBRkSKpKTNn6FKo4yfz+fwbH3aSPDeCMpIT2nG?=
 =?us-ascii?Q?IYhmrF6inVcK9fNYYiLv1rA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XCRzDvBPUoIwBwDjx+ZSykl82LN/kgv6EBStDtL0B4Ae+mQSIziRF8Lca9Kx?=
 =?us-ascii?Q?kEvlGpVtwil189vzLEEabY4NdAES9iYWj4i1WHwif06WT2TofH9mWy8tuVpV?=
 =?us-ascii?Q?dMqMfYUMTojxEkkF2MSivtvAq30SToYQ4IVijTUDz5D3apypRcQONGlUhwNz?=
 =?us-ascii?Q?tX4loAJwnxF1qWX4JYfrjNUkgoemOei4Vmf6PgwA+hp/QNpwdNQ2mZKE1hI5?=
 =?us-ascii?Q?+pza/KBlbwHLqiC7jOF3e8AdEnTbWl+QgfZSCpQEzOkxRDiu6a1+CJ3T4/xC?=
 =?us-ascii?Q?/xu8xpGEJP3qx7yh9x18FRPyuEHBm9Qz57clsD2ebmjC4ktjc1/6DNUvr6m/?=
 =?us-ascii?Q?s1SyUs3TcQaOlIfQ8ZaTuKqCN3Q8WolsvYWGVtyKt01xaaYzzrE0w5g68NlQ?=
 =?us-ascii?Q?97RYd9zy0PTEZXLmqvyKOdfyjYWF/f4cW+PSQ0RASUpEc4jUDYqKQVC24Mbm?=
 =?us-ascii?Q?9sw5gCFIWzvAmXC7QvfEfMm3qcxGIqsD7MNnfTkL/Oq7fr8VSXO2dWHRLrw0?=
 =?us-ascii?Q?4AxA8yAuvV9wJ5QT9TW+fwy4JdM+jchs0zMPqx2mSGsoY576Fml/NcDaEoEc?=
 =?us-ascii?Q?jRDQp90sTDIhga2Rw2e9aDv5BusefGU5UmWo4435ho/GCEhzX05YItbvdb6k?=
 =?us-ascii?Q?ZJOvVwHKA2niL8s5cTxrIcshN/xqTiTbqEAxtB2M+t9xy/HdnYK0/mr1STOR?=
 =?us-ascii?Q?YPj3rq4WYw2aj/6dqiGJFlF16ayMwrudDUaH0mb5NhJ3S6ktKIQcGRhydwJw?=
 =?us-ascii?Q?ka7rWXq9E8I3uimupsF+5S6Dmu+/f47RqAZSsvMsZpdiB1MLl1QeX6qi0fcf?=
 =?us-ascii?Q?LjYkAUhDliRRR0lfAC6aPAN2afzybSECvIjIB5RC71z2+wWGzeBFe7FEt3nn?=
 =?us-ascii?Q?jDxavw527cXRfGVIm30NZAHJEcAY7DyqhpTMpjCeodoEWdRfOn/+l72aOenb?=
 =?us-ascii?Q?FIyws8TvmksoS30uItxzI2BEJNWLctBD6QPOlweQzfRNRlGVyr6UJs3jZ4tI?=
 =?us-ascii?Q?/Q9zy7BAcMTiX/sUqgYAx6OBSEqnT1/8WSSaLL2+IBCtpNsTiaXKOi7NSWVA?=
 =?us-ascii?Q?6RjMGobzbU3g/lWyof4t2fje59ZFgRZZ3qEzF0g0j1k1WG3XyFXRpoetNwMh?=
 =?us-ascii?Q?j+yTr35gnenYzW/kgeqaJez6P174DqXgPC4dNhn59/SE2Dd8DNdAVPqb8k2W?=
 =?us-ascii?Q?YnJ8ZS6djzXDWacP8X0/7Jlh4EYIZIixyBGPurKLK06N37EQzQjtqK65cgu3?=
 =?us-ascii?Q?cER9GF2ya5ZTOTsZducbs0pt4lFc+lQHQbFQHPdOg6iU18ji4lv6rfGxn3QM?=
 =?us-ascii?Q?va1Fyv4H5RjBsNVBk3NHyNLKpAqaZMQvirtRWZEhzdbPq/PiLB8DrqNixKxi?=
 =?us-ascii?Q?Tl87LGkNY0tiFvAjCnhMW9Q97bNrI5JXcu9Gw6NVYDJ4/spKTFkr+ZFeiZdv?=
 =?us-ascii?Q?QxnHyHS8lte58D+Ah0LV0jZVMz0orBEL1W6a8siFqQCCiZj/EbeYPFY20Kzk?=
 =?us-ascii?Q?WYHzJAEBy/tNxDhGmjo4ZpCHa3iOkrq9bTxylMFJUKDkbMaYJAM48u3qLpJX?=
 =?us-ascii?Q?zI/YwPwm1+B7NcHaTuFoa987AR7TlgsP4OqVoxZmD7uyD0rJUH8fZ5qOBVdl?=
 =?us-ascii?Q?Hn9HwIvKh2cFOsRaisE9n/DPg0SXXcof9f2vS9aUC7nMH/HBuMVvrAwirHV3?=
 =?us-ascii?Q?WNdb+3WqVHy337QgtXHQdlg+Zk5SxI5WfesOeXaR8VSGwR8iph6DTz4NNDty?=
 =?us-ascii?Q?jdbpt9FKVQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10529971-745e-4bdf-0663-08de68818973
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 08:51:09.8674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZrDw6A3115YmbND+6TxGPLYhKe/EENNhG40g7yP6Dj6NU/vrFekJDJd+kI9EQWfRARdwKHGgCdO25s5i2NCG5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9644
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 09 February 2026 23:19
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; clg@redhat.com;
> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH v2 10/24] hw/arm/tegra241-cmdqv: Emulate global
> CMDQV registers
>=20
> On Fri, Feb 06, 2026 at 02:48:09PM +0000, Shameer Kolothum wrote:
> > +static uint64_t tegra241_cmdqv_read_vintf(Tegra241CMDQV *cmdqv,
> hwaddr offset)
> > +{
> > +    int i;
> > +
> > +    switch (offset) {
> > +    case A_VINTF0_CONFIG:
> > +        return cmdqv->vintf_config;
> > +    case A_VINTF0_STATUS:
> > +        return cmdqv->vintf_status;
> > +    case A_VINTF0_LVCMDQ_ERR_MAP_0 ...
> A_VINTF0_LVCMDQ_ERR_MAP_3:
> > +        i =3D (offset - A_VINTF0_LVCMDQ_ERR_MAP_0) / 4;
> > +        return cmdqv->vintf_cmdq_err_map[i];
> > +    default:
> > +        qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%"
> PRIx64 "\n",
> > +                      __func__, offset);
> > +        return 0;
>=20
> I wonder if we'd still need to implement VINTF0_SID_MATCH/REPLACE
> registers as it's a part of HW spec. They don't need to associate
> with anything but register cache alone to support MMIO.

Ok. But I was thinking Guest should not be allowed to configure it as it
belongs to hypervisor, right?

>=20
> > +static void tegra241_cmdqv_write_vintf(Tegra241CMDQV *cmdqv, hwaddr
> offset,
> > +                                       uint64_t value)
> > +{
> > +    switch (offset) {
> > +    case A_VINTF0_CONFIG:
> > +        /* Strip off HYP_OWN setting from guest kernel */
> > +        value &=3D ~R_VINTF0_CONFIG_HYP_OWN_MASK;
> > +
> > +        cmdqv->vintf_config =3D value;
> > +        if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
> > +            cmdqv->vintf_status |=3D R_VINTF0_STATUS_ENABLE_OK_MASK;
> > +        } else {
> > +            cmdqv->vintf_status &=3D ~R_VINTF0_STATUS_ENABLE_OK_MASK;
> > +        }
>=20
> To emulate the HW perfectly, VINTF_EN =3D 0 might have to disable
> the VCMDQ feature, i.e. deallocate HW_QUEUEs and munmap page0.
>=20
> Otherwise, guest could continue using the vcmdq "hardware" after
> disabling it, which doesn't make sense.
>=20
> This means that HW_QUEUE allocations would have to be delayed,
> until VINTF_EN=3D1 and corresponding VCMDQ_EN=3D1.

Ok. Will add that.
=20
> > @@ -59,6 +129,36 @@ static void tegra241_cmdqv_write(void *opaque,
> hwaddr offset, uint64_t value,
> > +    switch (offset) {
> > +    case A_CONFIG:
> > +        cmdqv->config =3D value;
> > +        if (value & R_CONFIG_CMDQV_EN_MASK) {
> > +            cmdqv->status |=3D R_STATUS_CMDQV_ENABLED_MASK;
> > +        } else {
> > +            cmdqv->status &=3D ~R_STATUS_CMDQV_ENABLED_MASK;
> > +        }
>=20
> We'd need to do something about this as well. VINTF/VCMDQ should
> not be functional when CMDQV_EN=3D0.

Ok.

Thanks,
Shameer

