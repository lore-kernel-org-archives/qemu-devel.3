Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1F6CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 15:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNYGq-0007Q1-Nz; Thu, 14 May 2026 11:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNYGJ-000768-Rn; Thu, 14 May 2026 11:46:14 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wNYGH-0003uC-36; Thu, 14 May 2026 11:46:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuO+DqVWYHbWdqCZ02u02FJI44Znlj8fRwfO0a3niljqOGfvK1nt2pDN+dMXFfCDyZ6OGqtsyuIrNvBO8GDjOqN2yICeRl8KFqhPZcb5QHLFNIriLXVIiKQ1o1u2fcGpWYoB4zOtoEmlcCsDYg8Wf6ETGgOgL17cctped6AXb0orNjQghp47gqeym0TI70W+UgsRR8YIjGToXwm+qvOf34KZ1CHIdp4N3JgyP4AYjSmyp64nSA2IhhfNsPS9VMWL4c2hBjwxtu8STlt89BbbGKVwFnxQ2gcxwSPDH4qw2p/1ofQafnb8p32rsS9G7/48L/F3hxNEeUBFm+KhQZbCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjrtBNMvwhIXI6ueUzoFsYBxt6+0DgOHXtI5Nvp9tJE=;
 b=Z6++IFkDnnzaYVr+f2SyZDX44zg/mMyfxiebIw9Lco6fFsZxIugHp2I6E8PU6itTBZ99GQeq+LwesbLT1ZMh4AzFrW9mJw8ZX1bmqEiS/ZBWVbTNSxH9b8gy5/JNiS2apAww6mfK8ON6BRrGEMbwlvojYlsdvfH568bbbR5OMsx22jx+gfKAE7w6o55dJZLNiLdN2i5zmRtJX/zS3JtUeHveJFlz199K6OI1NWTZFeV8HkuO7WYZuTEFSD04bJ8ao6yDRZ13Wy7OnvqiARJtJpnftsV2AZzD3lJvhdbSRfAZYkJczhwvNEq1AjRcYGSlouU8MX3jprI54lNLgg+U7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjrtBNMvwhIXI6ueUzoFsYBxt6+0DgOHXtI5Nvp9tJE=;
 b=L4KZA7zwCe/H4LKj3Eoc7VWrvJ0zUBXA+318eGMnQp0hGD9phXrPJ+LpSrt3HfeEUDxA9XhFoq/tx4hdQyJ30osLixk+vS0bhcF7SGtMp6FWSuNbYNZhZYwp+ilUETYIasSOzKHW9Rg5+vqrKWt9j1amBBNzSJfMIgd/wJ9IOKMGKiUo42QoOC67VyZoH2FcduE1J4gC3sZ8zmPFf6fS9VLJQ/USoHzlPpY88uLjjOxN8cDe55/rIMZifGmRpwUxIVmOhEzsOpHybO+uXlbm1GPFDOsz5qVzzm3iFbY60R3W/Y3IVlbZgn4kXVCtH3gaCAdT5zvMaDGo2Le0FBgpHw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Thu, 14 May
 2026 15:45:56 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 15:45:56 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v3 6/7] hw/arm/smmuv3: Set default ats, ril, ssidsize, oas
 to auto
Thread-Topic: [PATCH v3 6/7] hw/arm/smmuv3: Set default ats, ril, ssidsize,
 oas to auto
Thread-Index: AQHc4kaN+4XHgoTd5E2gQedpKngDSbYNrOJw
Date: Thu, 14 May 2026 15:45:56 +0000
Message-ID: <CH3PR12MB75481623DC20A03B6550C7DAAB072@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-7-nathanc@nvidia.com>
In-Reply-To: <20260512193520.3109172-7-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM4PR12MB6085:EE_
x-ms-office365-filtering-correlation-id: dd06d767-41f3-49b2-5e2b-08deb1cfe354
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|38070700021|11063799003|4143699003;
x-microsoft-antispam-message-info: 8LPmnPckoFY/IQiZmyJUfb5WYJToWAOLcOBVSd237gPd04+5d1nwm4ge0eXMfBs8/J+mhsmDGWlxsCgAW0MAEcKAzYyxB7iYVAwLulD9rTF1OpUVj0eG6yHQY6Hz5TFtUgnxPkfzjcvoAAXqoBX+1q9j3k1Bp55Jlld7Mg2fUMSYSv5ewk+AYUxtkjntvYBBl4GSx0US1w/yNbPbzvfhzwbvb/wkdu6XEFzb6vqzxkVyMO4zIcLvDX0C3fKbQYVzTC/OjgZC2s7bT4HMLHXbguCX8eWccZlQn1x6m81fPjWszoN4UFnEnb1q9xysIIi/JogXYg19LOznTyr2Bfb1p3QV4zauJk4oXbylce7Yys2MG8tXdXjnx8cY8od2KokCELUe48q95A14NkrC3JpMSr3hy7WWl4G9DtIl/8KlTAQZMAu+Ux/3Nxm7ooMzJfcsjJCVk7nW4q1xU5RA/pibfvB+AEVSOF6ofGupJ7HQbk9uYibbEwKn+48d7sepsPPDvlbS0pVYh1TacIhaCRiBzXW1i2KL1tEEiylitk/jaM3R3xJ0D/HWJGZw2cXUmKqCv0LeEyrlN2PEeqlfTRewhouoPDl/pJWNzIUcnjzE9w/bUGnwOQjalgMFk+eR7/JrYspOYOJz6QJMSK+5qtAQbEQrHQQN7aWYp9FqxLvWIhs8i6QB4p0MneTfiXVzTkTvrNSJjNeqEWE12SEPiK9nkk32Bf9AiMxG7aRwTPm/TNtcIzrSLY9g74tfhGUeIyN9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(38070700021)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fLBShDWXDDj2ihoqt+yk/LsJJNXnUtwInD2gx+ccG3idxOpik3U/k7KhFi?=
 =?iso-8859-1?Q?2eL3+JtSdabM9kQV5HAIHWb4cZ5RAq8/dCgu0izKRb/M5ji0mDBw0v++//?=
 =?iso-8859-1?Q?sYV+gCxBPTI1OZT0HR4i4R6j2ahfUQI0Ovozu37hVS4v7xXl4XGHDNJkzk?=
 =?iso-8859-1?Q?8/TGLwqe2vXBx+kg7b47cZYYmR12Zo9iO74SNoTtHshNUZxoyk4EhdUhY1?=
 =?iso-8859-1?Q?oLP2moz1NwzS/7HWc0UR0c70mbD7xy1shXnAJm85gF99ZJoiJ55rEK8jw+?=
 =?iso-8859-1?Q?eb3xy/hxR1gM2VDJG3emzexZP5ZWOLUtgGtpfQeCNppcLzHN3N+P/ODAer?=
 =?iso-8859-1?Q?WFZQ3pR3fCK4XLkWrwEs2r+hWeeCGHGG/S5pkGjYGY5RQbVBHa8T7+nlQk?=
 =?iso-8859-1?Q?0ZBIZAvN0c8wlSyScYVPZCqvFMsGKCFCJ4kZ7Mb2L+oAbklgCTaDcpTWer?=
 =?iso-8859-1?Q?RUevEtZeYvU5MtM/Ab84Rsv9wAXpJPIcOOOGo8Xd5yzFdZIA4UZfXU9UaZ?=
 =?iso-8859-1?Q?MbhyK2OaXJ1LytI5OKt8VuItPVBvw1PkFOExsZWrLObjkhtaS6creuGHGU?=
 =?iso-8859-1?Q?RcjskgZ/vdhZ2ffoY6G+RDUMYUj0EenwxnMPl/e4KmjMYDA4iAGvF2IeFn?=
 =?iso-8859-1?Q?PeJ1KtfOk3P46ZGq7jtA0keyIMx7IZVxdbCwy78pLe8O1s9RpEJlGam76X?=
 =?iso-8859-1?Q?UyVNakQF22V5HezBTBYzVwEuV8URUbaUKN64k8P8G5El/0yVZlVr3ceF4X?=
 =?iso-8859-1?Q?JW4JGtFZWVhbD9I8Iqa/7Xdvs30cwdTfgEG6cPBO/QIfxyh44tD3KWntiy?=
 =?iso-8859-1?Q?tlnl+8GKIdiQ6lAN2Yyf+f2fr+Ad9BvhwS6WYXbpzKvgRypyb9g9oxAY7r?=
 =?iso-8859-1?Q?3PtQyEUUa2RfT0kK3v6n5rJtQKuXjo6gvQN9HCLIb3L4cTc3E9i9jGQF1O?=
 =?iso-8859-1?Q?s488xCcJY5/qpE+6d/gdaDcyKQqIOAsRTYvg31YOR5ssXx1PJbNU83yZCh?=
 =?iso-8859-1?Q?HL3MAC+pOZLFZKPwH2LV/rfIvHJVxbjpXLw27OBtR/URN37FRL4ggsLSLj?=
 =?iso-8859-1?Q?Q4ArxTnTaciTfDm1NM5BLYoKnTXRIqN0iJJkkYadWP00KpvCKpqvpqCMDh?=
 =?iso-8859-1?Q?n1J/HXUlySiXC67mecWFVL/QKV1Ip3WHRlAWNU3eMvy5+bdeFDMMpkMfSd?=
 =?iso-8859-1?Q?yj0/WDttC3fEw4WMHDIFPd1D3VcdQ8AOxwaHWFMOWKU5O3YrkW1F8l5PAf?=
 =?iso-8859-1?Q?KnMLMtJHQgVYHD2WcrrXq0anDMpBU50wLeXiXesgBBfPkJzw+q8Z5YfDNN?=
 =?iso-8859-1?Q?uRjxR1xUlFcrIbL/Rh59eEKwu4yWi4/4s4JLCHtBI5sIBGz19re+pmAmvD?=
 =?iso-8859-1?Q?iIdmuYA/zeKdzkYTNumReW3i6C+vvovLBlWMzbLFvdQC/aLPG/arS7Hip3?=
 =?iso-8859-1?Q?MSgPjUkhVj3O69L1yXmZUTHFeDLkY2AikPlY+vFV/TVyOOPDd6NOwh/r+5?=
 =?iso-8859-1?Q?qXJauQ6a0e2QPkFR3uTYRwj5eTb8z1CVqlQU7qipKNB/XYmESJHD5VVTZU?=
 =?iso-8859-1?Q?sQOLBiiK98D33LNr0hRh2lWtr3AhTJxwIewfQxKgtujtJlj+5HtKiz5n45?=
 =?iso-8859-1?Q?pZuhBBYmauD8i2LOL3LHSbI/+0P86toLtXNecVP1hVGBDGg44/hBhoc7/L?=
 =?iso-8859-1?Q?ilM1qWpLBdggie6mTrMz4G21KZkwuz24cWk+8/49sJW+dvd/+cFai/ivf2?=
 =?iso-8859-1?Q?mzq3jEJpZjiFpmv+gn2ZshDKcr4OfgGo+82tHW75vx9P4CQXbbauU/BFQD?=
 =?iso-8859-1?Q?YBgJdx7v9A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd06d767-41f3-49b2-5e2b-08deb1cfe354
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 15:45:56.3260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lA4jBEJa5xksxPJoBaEal5LpfXX3f7s9zBuFDq5jo8okikdPsHgj/5cb1VTwh24mUvJaBR10J0ZObdYAq6JqJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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
> Sent: 12 May 2026 20:35
> To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Philippe Mathieu-Daud=E9 <philmd@linaro.org>;
> Zhao Liu <zhao1.liu@intel.com>; Matt Ochs <mochs@nvidia.com>; Nicolin
> Chen <nicolinc@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nathan Chen <nathanc@nvidia.com>
> Subject: [PATCH v3 6/7] hw/arm/smmuv3: Set default ats, ril, ssidsize, oa=
s to
> auto
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Set the default value of ATS, RIL, SSIDSIZE, and OAS to auto, in order
> to match the host IOMMU properties when accel=3Don.
>=20
> If accel=3Doff and these property values are set to auto, the default
> property values defined in smmuv3_init_id_regs() for OAS and RIL will
> remain unchanged, while SSIDSIZE and ATS values will remain initialized
> at 0.
>=20
> Introduce a new compat for the changed defaults.
>=20
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

