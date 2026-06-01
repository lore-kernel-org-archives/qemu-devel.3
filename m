Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F176BCD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU2wQ-0000TV-3s; Mon, 01 Jun 2026 09:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU2wO-0000TA-8S; Mon, 01 Jun 2026 09:44:28 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU2wL-0000Qr-Oa; Mon, 01 Jun 2026 09:44:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqXejYZI7AhsdAFp6VRPdpOHwivhWWH9iJYgDxcGGD3FM1ZDaWoTdeo+VCvB/u0hFhwuZaHAyGduN5M+E0kJJgsaWOX/B3eKxpdz6KKSGWojXAiPD/psCq/X2UHBGfTLfa683U6bmbuYc5SndmLH9af14Jlm0kEwPSBB9TSGOKXPjoBHCesmT0NpN1QQm+r1cyQWxB2IRBA40g7Tfoy/TaJech4DTYve7fo8GBZbVg+en4PWMTBcnw1if0XKEKKvdYyEVOsYnNMcs26+4V1Vaja1tPBZYhYwI1UzzBqHaWRUDG11N0SmK/R3C7xB7ECFvkqphCNdvijZMfbnlxSdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYiZGf65lHB39m5WoIaj/hqwojACSk/GLpl/4NDTMrI=;
 b=IfQkI6lybF2Pua3V+yqM7+/REDjSUCDnD3B6HYFxcsHtjGScoyzlI5Jf3EZTP9KwO8CNIXmJxr51WYW7+3JbFx401OfNwg4qkkJ836BBUD/eaagc2GTGGGWbvuYhvvN4/ILlW4E2RikuQlwXA1X47pFXh2HkwscvY43ND+bIwesHfKIMn5Jwq05Vn+Vq442jRCvPyF2w2Mrk7ytiHh3GBdH/pQUjYM2ZeKexLqo2ufScCo0GceDbwOjCjFSAqFO9HOR5cG733spG3VA5a4Vqi4d0Zqv9ABAQUKlTQMyRdHHslCtLdjcYLkgQ59GwDTvN2J0WFVIDAaUfai0k8dZ/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYiZGf65lHB39m5WoIaj/hqwojACSk/GLpl/4NDTMrI=;
 b=ucVu0dXeweKREJW1mz4xYytOyodT9rVhhWfNp+JDi8Nr8B2Y90XGe7MfVV+81GKsmDRjnqBQdoseDf7qVkg9ntwlOUqXjsNIm4grRBlO/plOoxRSbdleTnG1JT7r8VnJj3j/RjDfnOH7K5yBvTOdsI4YdwW066wBJuEd+t1b0eKaRIP2IWJhVCzhZf7GSZS4VIH0ikHrsfcYxWnAlz4ZrwFylAv5TpagsD/O45eC1JkfMA3l8V20gNLKRwD+rzEwhzBefQ/wXCHCd9JAX8OnXpYgAczGOk9D0hrgwycxaR1bLvwJByxfbT3Z5i7gP+bBbH/2h4JFBNIEn9HbCrBYtQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 13:44:16 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 13:44:16 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 4/9] hw/arm/smmuv3-accel: Implement "auto" value for
 "ats"
Thread-Topic: [PATCH v4 4/9] hw/arm/smmuv3-accel: Implement "auto" value for
 "ats"
Thread-Index: AQHc7iaFhyhzhnPCekyqh51tt6KVerYpvOZw
Date: Mon, 1 Jun 2026 13:44:16 +0000
Message-ID: <CH3PR12MB754801D20C26D35EF750C43BAB152@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
 <20260527221631.612026-5-nathanc@nvidia.com>
In-Reply-To: <20260527221631.612026-5-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY8PR12MB8067:EE_
x-ms-office365-filtering-correlation-id: f699cfeb-0d01-4164-3d18-08debfe3df8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|6133799003|56012099006|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: Dz8ErbVxbdsmeudUZEar72lyfnrWOtnOUDfkS0hsu6chkmtvmrbjF6esjFqiosuLEa/oOGMsLstjvgqy2X7+O05q3jNIzPql5p0Ws15FkODbKQfmwi5qHWIwj1m8tbcjI/DOIyVLdaX0nQIsh/vjROpNP87EQ7b36RPZ6mt/oxEy4OUnhcqtsXT6XJDngSy4Hn+kbIQQbmvENcWD/KRoKxHpRV+ftifes69Dx+HKTPwjT8s6yGt7if6JLfbMbAA1hRrfPXOaAF569pr/T06eVRsHxx+Zl9HyWYc7r8tWHD6t9Ff6kznAXXdqzSlwRwekvit7QXUeddn7cS/Iogp8V/ptIkMkmsvn9wUQiSvwwN1hI6+oNu/ZUGzOK7AJoOsFdV7sSbi9grx4ecX5ME/4zokGxzdy3BwbhGlGwmFTFapcakALnAiQ9erPwa7Fb6h4B0VPLyBwhcndL65hrhhMBLT//wJbCepgCh1NLhqeukM2uKMQxLrSJhT6JM9hv8TnV82yHOIncurPX413ejIRzkbN6Oka2rr+MtcKIPCH9VnhPpkf8STSTjkVBgX3QzPe2/sPIAV7zcvP/bBm6SCMftPUDnbuJXTZlwXJ4usbeF5XmaHmGj4ukWdduouty+0BZfm9Cs69PSSKCuX4WOjXDrD8f2X9aH+h5OWTt0kJkpGUNqCm7+qLcKI0FECL4ihw9g4wLYj1KluCMmqEHdacYh3vbO1o2PwgSlqMAp1fj0zqlqkoDSOCP9FnoR+ORDgj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wYhwMp0U5t6V06PtrK+qXXrKwtur+p35mSo0q2Q7KOXUiRFZDyU0V/QeFr?=
 =?iso-8859-1?Q?acT2B/j39nBNS4TXuweDrEzE0mvPbmFObAGjtMFXx2xRsJK3qnmEHJE37Q?=
 =?iso-8859-1?Q?feOHTMrRDqZ305U52ixbCHXvbDo/V/dvY6b8JlYXlb6eURXLQRyntkix4M?=
 =?iso-8859-1?Q?gy70OsJ8FXyIYf2lBkoLyjes7bLC+cMZOzM5m8cfkobAE+TbgGxnIArMm3?=
 =?iso-8859-1?Q?q8W0xhMe8YtejFrLfr85nLRVZWsRs+KyRLbfO59tqU5wJDrdoj06yVR6lA?=
 =?iso-8859-1?Q?RzaESDXUKuLGD1qeuQ4vGA/2eINZAtKMcc1yW4TkW50IjX0BTFj5uEEI65?=
 =?iso-8859-1?Q?0VyuRQYhUt520YupjcK6uj4UNBc8HKKs/BZ+E95/ioI0muky6jEXF/b5EX?=
 =?iso-8859-1?Q?tVw8zmw3OKL3yy7DnmQcp4ThnNXjjzOvejXTguy5UrLTi2hCDNKkZC7yJL?=
 =?iso-8859-1?Q?FngSEuaj/yTUkY/ZSASWkHsuKCUCd49MroyHFek5wab46tC4PsGLm+vlPj?=
 =?iso-8859-1?Q?YfD95Z8UDtlLNiluyvzghU7XFwiMqTFrKSrlz6Ngnpuu8PQ+LUcyqMg352?=
 =?iso-8859-1?Q?1JMamQctZM/MPdcVB6hoK3BGCx2ndGxHdux4ElYmFxN46mXnPr18fwIE3N?=
 =?iso-8859-1?Q?TDglt3PDwBBn3lGmi6cTtcHHw9Wtd/BGZgq9mPQln3rJ43Y+BWUWJxRpdW?=
 =?iso-8859-1?Q?+SK8crBzHGXqHqWCvSQoOC/Z4OHAwCPGrPqvs9dwLN8yvU/kdztsTCD+yQ?=
 =?iso-8859-1?Q?x5Af5wlZMBrWHCReJyBnwB2StOgyFbGASrfhX3LX6gKFIWeQyF8s5DgYC1?=
 =?iso-8859-1?Q?TsWy9y6+eqkrgkT1cNtgtH4SROdONf6GdYNMex9j12ywA/sK6AED6rR4bD?=
 =?iso-8859-1?Q?3TSdjnyaB4i4ewIrorYqvr++NJHGkeSV4wslCDZnMk4rFm+38cPMDQ1S0C?=
 =?iso-8859-1?Q?ayCfXzrnut9r47iVAibyJF7YXcA/7OB+QPOOllvj9dhQMbNaqFwYzwQXh2?=
 =?iso-8859-1?Q?OljBR6B7Eh+5AhzK040cEmsPLpg4FbJv3AjFhp11LirwQFCxBz+cd0x/eL?=
 =?iso-8859-1?Q?MRjAQo3q96cH6DH/+PL0sWssXc8rYB0Ib1tg1XQCBoYNo+QddZGG8pQOie?=
 =?iso-8859-1?Q?P/qjphNQlOoK+F05DolW/f+mVA1A6BJqimIyr3KU/T9GY86tZmvhn2l8JI?=
 =?iso-8859-1?Q?dDE1Q1y3V+r8I6gB2wZVHfwr1gycfa1POoefOi6qlaTwG93Ocw1r3gshRs?=
 =?iso-8859-1?Q?tt36GG3F7y8Bgp/M+QG1QtpOoHQMWBtr9DYwNhkYkwGevy+2CdbAaa67V5?=
 =?iso-8859-1?Q?ylD+JE0q2Eq7QP4bRLW4qHUsz+KR/c4d0k5AYL6SbMM4jzrhQnUBkHE6m0?=
 =?iso-8859-1?Q?28C9N3saKwUIpYBlLyqKafvG2Q+CLbf/Ua2TFtd5YZvMllJuSbc8g8+eCW?=
 =?iso-8859-1?Q?4ByjzUJyp4RvEzWr4ZnZ8EqNy7Z5QbKgLkdiulmp6aT7Kteo2c2F6d+A/Y?=
 =?iso-8859-1?Q?JdpyV871Tq9ttA8tJJGPREsPmJAp4xl3M7Z2d1/ZZNBaG9oHg+wJE2V1W2?=
 =?iso-8859-1?Q?YcuatW+QsWjcAtQTmHLGz2r+SLMgFRo5Lt95inWacdMT83yIHFG3QIIi0M?=
 =?iso-8859-1?Q?ZLhzbVvuY7kq++AoL909Axl3UP06b499NcWs1O7fxdHcrsXy0OFcelotVT?=
 =?iso-8859-1?Q?65hALnRGnUxsTtVtT8GPKolIuWrbLV5jzgaBCbPXtWO/rCpC1oOQ+nqX4q?=
 =?iso-8859-1?Q?9QyKSw58uotIK9HJQYiSceZHpXGzZ5Y1EOlckRFA5ko3KC8oGGmmiZAJ57?=
 =?iso-8859-1?Q?fy+D/BxoPQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f699cfeb-0d01-4164-3d18-08debfe3df8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 13:44:16.1863 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pyfCr5QEncHTA4lFS/ixhqf2rTLq3I1CWHJbmxAcyx9ZaGK2kgh2/wudK9CTcmHHwyC6LefjyZvgmAQMT3AwZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
> From: Nathan Chen <nathanc@nvidia.com>
> Sent: 27 May 2026 23:16
> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Philippe Mathieu-Daud=E9 <philmd@linaro.org>;
> Zhao Liu <zhao1.liu@intel.com>; Matt Ochs <mochs@nvidia.com>; Nicolin
> Chen <nicolinc@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nathan Chen <nathanc@nvidia.com>
> Subject: [PATCH v4 4/9] hw/arm/smmuv3-accel: Implement "auto" value for
> "ats"
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Allow accelerated SMMUv3 Address Translation Services support property
> to be derived from host IOMMU capabilities. Derive host values using
> IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.
>=20
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

