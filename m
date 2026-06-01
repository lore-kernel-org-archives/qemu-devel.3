Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E5DCD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU2sV-0007jA-Vi; Mon, 01 Jun 2026 09:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU2sS-0007e6-QW; Mon, 01 Jun 2026 09:40:24 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU2sR-0007Ds-1G; Mon, 01 Jun 2026 09:40:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/nE9Qqs4PDUZhpO3Osnl3XN23dRlmFobCgydfzKfCzorHtVgfZ6xeZY5B3W0+er0ruMZ2nrLGUAn8YLPsn3xRtSebbcRKo0jfdFZDwdwJxDcOZaP7SiwPdWy8cYmY7+IBSS522MMrcB+lK8FgyYVsJOBQ6IkPnC+g2ul09xGD5awWeFp7Lmx5qxpaP5ZQ13xVX+qMARMjJOKkJH+9NEQx9GPPppX+vuqA+CLiWd+qVcyqRNBeQNpozaTaTWLXktjwBvOEc5b55ghc4fytY/TuA1weEYE837SVQDs2XpuraCwLkRR+8K9xfSkBq9z4Mx6B56U4YNIPVOYEXWAtP4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVOSQ+G3/Z3z1BrMPz2jV4zu4aNvC+OcT+sohMAATCs=;
 b=hbPP4tWSYLjMsf037MN7gjJaTFb1DXVdxVLBoo1OVgijRR4JoZD2WIQiW2TBGjIUzm0Yhi4R+pwzfMQHC9iclCoi2EmNMOgAigy+GF7ZcPtp+nPRUoGWCjvW9vnRyO8JwGpOUdKr6GfKwIZsdE+hC+JUZDU7WdzsXfkXzJlH8CalkxCikw8QyO4IQ272+8UJFHnspEQ3/SjhsnvSjowQ1jdlMXuO4PkrgZXwCPeESal07LcLvkaXrmLfBIm7eeYqzSrfMZg/s6HxY5Dopf6BEs/DNSV77cyQvvD2V/tl2ud95pq91VJQf4TGVI/eGll5PNDfN0P0HA3+kx+UA6ZTrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVOSQ+G3/Z3z1BrMPz2jV4zu4aNvC+OcT+sohMAATCs=;
 b=rcHPgOnWKR6nD72WfyhoSd6ItUFV/mTpQWC5S5fX9BrpAsu3/THH9B51XYcrnwRKnQqQ7/QFVRsmyxL3la8abX/Lzhqbrb1pBh7Np1Jiy4yjaTuDco5+wlSY1PGY6W8EKG+mVplR2i2kXCw3ZT9z+/Va6zqNCtcrDEe5qFAxJrWwSdjfQhicTrXedOoaqbXPo8S2t22bt37OgJqXXB/zh5PZSWBSrkuZTMsWU7narz6aKtSeF1qug9P4tnqJU/w27rWzgBm6FvzMPCXywGGMmx9TC5WOg7QJYXgEA1xoRGgvmrN98mHyyBkUoHSPnUrMob5YSUDIi3PCt3jkCmF1tQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DS2PR12MB9661.namprd12.prod.outlook.com (2603:10b6:8:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 1 Jun 2026
 13:40:12 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 13:40:12 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: RE: [PATCH v4 1/9] hw/arm/smmuv3: Update ATC invalidation check
Thread-Topic: [PATCH v4 1/9] hw/arm/smmuv3: Update ATC invalidation check
Thread-Index: AQHc7iaDcGyS/1ElF0OXmIGdVd1JsbYpu7Pg
Date: Mon, 1 Jun 2026 13:40:12 +0000
Message-ID: <CH3PR12MB7548CD679260979B3CD87064AB152@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
 <20260527221631.612026-2-nathanc@nvidia.com>
In-Reply-To: <20260527221631.612026-2-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DS2PR12MB9661:EE_
x-ms-office365-filtering-correlation-id: 3725e641-9c03-48be-e731-08debfe34e1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: lq0Fs7UuiUpCq/v07UnZRmcd657U2LOVFoRSXX6vCUZkOCHkISER4toYCpiLkOC+ZUohWTEhWo2xmYNcWGA26qM8FAyCK+OHjPnVRMX4YtY55T1ZMCitdpL6+YwN23XWAzUyfrAUL1bJb8iaFp257umt6KAXmpFjcft+VQdCjzVaEmcIwKcpz7WSKmGyDoiZeHFwe3mbJn31dzKaaRPSGyOJUQn9XjrU4K9hP8MgrHMiIjybUrY+jEo75lq+sLBidnYzzOvLxL/EfV1mW/Tjw1iXmQAjdxAyEwdCxEMSpsdlU8hGcV7IiPXGH76jZ2aOLY8opUS2ppw4TYWbsqPbEUbASE11jREmWn7pkm9IiUZRO6+490tXKmucUZkoR5eokpEIdPf3Hgc8VUPB5khx1oqlwxg9ARjhsxCJhcCAx5m2PC05qSnhiibtb0veuq2sChjxKDDu5OJ3Bh8dR+CFH7eQqK0U/HQNJj9iFMnFKy9c1QjMmuDVu/Oz+KU6s++Hm4Lj2U2SQjrtuyhQua6MyzXrY8+R3PESk+P6Ge1iQ9F0ZMSw71IaKeFZ9+PMiSXxhunUZ5xK5Hu/Wg8s5Bz3uMYmIzxBh4EkDlFGh99vhIxIhzDPLhSWFE/W0+nEe+ad9XMdzXnHiDJxAfzXJ1G3TaKxYsacPc6+ORl+7v01gOUm/OQhNNH72qQw8U0l32mFpB+WCOmsQFnL885JLKkFZx4fWDDFbnVTZubkFJUuN5ytyhTQW0zp5o7TFSe9i9A5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AiX7MOTb93cM9BjVMKyAEF8gKvjY97CXy/hHkTiQMQPeZ5/YOsaZrmQdvL?=
 =?iso-8859-1?Q?klPjSEiNENQ/mQpk0FkQmNXaoBh5cylS/QYogus2TBl20XVm6DoS9JAwxO?=
 =?iso-8859-1?Q?X9FJ+ErMB8YDa4PhMnoCZqc0ETbdnitvT0Ykhu1rUIll4TDLxPdh4Fg3t7?=
 =?iso-8859-1?Q?yWL2RQ4L+fsxn47e10Y/NKZhQV4j+I3R4tWJU2GJaLKFOYRsFkfu2yOjNg?=
 =?iso-8859-1?Q?9HBax+60/fWbtT5AC49VX6xmN2aE+dxefqy9EYOcnDnBNYnNVQEgXULQM+?=
 =?iso-8859-1?Q?s6pFgKrn7t7/HxTpklAMXY/BBbmMMTD4D+3Td2kafEw0AxTgyeotifMfh6?=
 =?iso-8859-1?Q?f8V/rTF8miMXs+HoUO0f1VKs7BR8F8ZzPG38yAaqxW2Kw6/DwlYvGSfb7Z?=
 =?iso-8859-1?Q?SEnThT4CNf0yRZbFSCSOOKtS84L0bIXIZ8JRgto15g6Y14bDeR6FCW1l69?=
 =?iso-8859-1?Q?SEzhOEAyFZ+rFAbpveg6JxfxOPxvBKsnLOD2zWF+280LPSAoft7mffnUEU?=
 =?iso-8859-1?Q?F0+YXLVk5aO/5KBVjNPOVJ+nT910UxxnadOaP9USwbwsXmHkuwZnEZAdki?=
 =?iso-8859-1?Q?V2BAAwOiKtfeL+MLYNNb4sPMKm1hdyihRZ/27g9pKGsAMGczENYKsto4Az?=
 =?iso-8859-1?Q?VBJZvHgZhputp+UOPcKZ+YX8c9lKbTYY/26U8AUOCCtO/eBlBkfiZHiuDq?=
 =?iso-8859-1?Q?o2fI5rBOdIwPCnh5y1X1t56T2+FKXm3SQzsp7NgS+D16GlbLfkNqKWvt5L?=
 =?iso-8859-1?Q?nJ5M0PBFMa5psp//iXasgnRY0ETNHVX1mHjCmR2paCmGeA922xIJJQQm5j?=
 =?iso-8859-1?Q?a1g6Tnhb38PStGHT93bz7fG03Rcv5rXCTIUOqA9NB/N7oSeRSM6BTDJTU2?=
 =?iso-8859-1?Q?B1Cx/8gdQ7tUgvoZ1CfnEvYF2FytUudMrGjaz/yQGjkVukXV032ELwsbaR?=
 =?iso-8859-1?Q?c1ILIa6SVYhOakivW4/TOKjPg3LKbO8WccgIATC1+OCI0QHxoapLDvPItf?=
 =?iso-8859-1?Q?JdekE2k1yEu+ljBdXr7SkHJul9Jq6ICnBK08iCfkfnzOGuwCGbNwp2tKRb?=
 =?iso-8859-1?Q?DQxUqACZJgy6/YyO/19B6XSqwz/4uhyHOlxGyeG+lhChRkFtQZ2eUFby0S?=
 =?iso-8859-1?Q?JfLjVIMId0qBkPtQtBjXiFsNyMAP1kdS46v4r0aCfXjhca2mEU9ub/d7Q5?=
 =?iso-8859-1?Q?mqyPO6yhrCKAtlqVvR7lP0e3zWjhBwJH81Svf3xjabS46TIIpBqs2mRzMy?=
 =?iso-8859-1?Q?Bo2/AV6njw0yu8P21FmVv/S9UiDCdOVuvMtiljQGMW7nXozvB/bhve3tLd?=
 =?iso-8859-1?Q?+7ZUFalZLNnvPcORVGBmf9nvQxueRgsJEldAvxZYVJ+dk0h5UICamNRf/j?=
 =?iso-8859-1?Q?11U3BzEBYRwFdIdRDyCgCSMLzl6FvJ/8MYK919ayMsnxoQWOtSN+zQQUOp?=
 =?iso-8859-1?Q?9jMmiy6yxMewaDXr2QaG7C/Xv996kPWtxzFMqej5ZI+Bp3XPFlm14EPjmR?=
 =?iso-8859-1?Q?/XeIBPdw11nysV/KQih/mCzCUjB2MXeujoj/2lRMT3P9S5OK2bU7+9XcI0?=
 =?iso-8859-1?Q?0lY/vE8zU/9y0nG1vo5Dl91Ga+nYN4bwP7hJTAiJuFnu8XWsA2ZaTzCnMQ?=
 =?iso-8859-1?Q?SLP89Fe3M8/wHj/DpubScLobKNddXd5jLGOdX/bvlbD3MQl8btWAHqOsMc?=
 =?iso-8859-1?Q?23N8ra2oogWnZez5UjjvM2GFTYqIMDf2a93ubKoLTK3PPV53/jmQnhmcsO?=
 =?iso-8859-1?Q?P9eqF2vgvHY+A2q+igFhV8nOhuVRm8bmVQCW17fx/iEp6vc0pXZ48Kz9BP?=
 =?iso-8859-1?Q?DJiHd9672w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3725e641-9c03-48be-e731-08debfe34e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 13:40:12.1804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FjTZNQosQrwxE9I2MIdfK93C/j4xVmwkB5esVnLoHu2doQ1E/KZdV/SikX18ZHf8b1sSBdyVPO0pXKRHUwrd8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9661
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
> From: Nathan Chen <nathanc@nvidia.com>
> Sent: 27 May 2026 23:16
> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Philippe Mathieu-Daud=E9 <philmd@linaro.org>;
> Zhao Liu <zhao1.liu@intel.com>; Matt Ochs <mochs@nvidia.com>; Nicolin
> Chen <nicolinc@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; qemu-
> stable@nongnu.org
> Subject: [PATCH v4 1/9] hw/arm/smmuv3: Update ATC invalidation check
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Use smmuv3_ats_enabled() to determine whether ATS is enabled for the
> guest when handling an ATC invalidation command, as setting the ATS
> property value to 'auto' will resolve to ATS being detected as
> enabled in the ATC invalidation check otherwise.
>=20
> Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>

With the tag change mentioned by Eric:

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

