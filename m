Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC5BF483DD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4jHd-0000sN-Gr; Mon, 23 Mar 2026 13:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w4jHY-0000rr-Rp; Mon, 23 Mar 2026 13:41:41 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w4jHX-00070w-0q; Mon, 23 Mar 2026 13:41:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/qK5Mlz7LFGX0W+Q8ZdhIWss1uk+zEwCfw0SdrfCOfmnPmDZplOxoJpvHFtXLI9NczldrTMcKjlRiIlfb5eCv8J4kUmQvv6LcYRqvyDHGywmBNDdrYKBKvSE2/z+4LMBK1I+OoHXvKNDx8yLibD1fQHXzNm9FLkrBWEBm2uojyd7XMSl9Ubw+6vacB24gqVjkRDW50t9vm/8sbtPHPosmqq7GF+KQLgex9gRi2YiCY6BD+QDy4dNngkNPUNnZ/Bs6ZKzke3kY6LgCH1L6dmbY+Ia8xw8O/mestw2HLJkg5w9AFzqhnwWeyqh5QKKlBOD/dAXgpXtDtTQ05KdEHOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsDRf2Z/7/PfLMJkibGuCwCzW5VFsDX/bBur9gliDUI=;
 b=MV/Cub4e+KqTa4jR4w1kvjn5WU2S2bo+qTKbrvB23gBeozl1Sz7lGl1lhk5yOFzuLSVs4rnCROkzs+rKF4NGLzszA2wBuSMwcdPzzWbgPPoeA2bFKpA+V1bx1lhjxfV+TUq4MbwJYX2b0qu5K1I8A8aoc1tj+NiC4j/+c4zWjoA0fgZSSbVj0I4pFDjpWeeYtHt5S02Opju+AdJQ0WFBwRDrBHuBnZklqfZ54kurm/8WvORYvyZS0bp61B4A+L1DIOUoa+blN3a9DBaYJCuRHFwaSWFn5oBr9Ic5HxWPi5Iwbsd7mAT1s7R9DsEoWxE0z6AiazDYzep1QaraIf9ZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsDRf2Z/7/PfLMJkibGuCwCzW5VFsDX/bBur9gliDUI=;
 b=qfAFTGjP0Cd3c3eUjyQlvlT6/h0ir4Irh3654FyqIxSBhSGQ8eHI5mNlavgjcdhLwbGoACmpOxDuDETh/S1liU3FmntLIdP3aYFsWC6le7KcYk2bsyf1m5HrWIII3oorHHHtpTekXV2eDbF4Rfwfz8wi38rArwY0Y52e84q1LlJ8+hSJuqL8HgoWeF/Nt4XHYZuIFJzd7sgAmdfmK3bZBZwQITQSiCGPZn1vcShA0qqPlQjcSF9gv1wRGvdRXRwEet+3HELYw6XiXCEQW9I0Zqm5JLmxXNKWxR8TC0sCR79TJQ2vMJLvpILC2+tpz6OCnNWrtTlMll1JYSgoVc/xlg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB6978.namprd12.prod.outlook.com (2603:10b6:510:1b8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 17:41:30 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 17:41:29 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Daniel_P=2EBerrang=E9?= <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Matt Ochs <mochs@nvidia.com>, Nicolin Chen
 <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
 SsidSizeMode
Thread-Topic: [PATCH v4 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
 SsidSizeMode
Thread-Index: AQHctwf6OwrZMOQjTES+TWh1wPCW57W1xeAGgAahAwCAAAJGcA==
Date: Mon, 23 Mar 2026 17:41:29 +0000
Message-ID: <CH3PR12MB7548E042617EA0BDFB34C55BAB4BA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
 <20260318184907.4060030-6-nathanc@nvidia.com> <87341w9ftp.fsf@pond.sub.org>
 <e855b12b-5e1c-4590-8440-a29155a6c9b0@nvidia.com>
In-Reply-To: <e855b12b-5e1c-4590-8440-a29155a6c9b0@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB6978:EE_
x-ms-office365-filtering-correlation-id: 8c8282eb-e5ef-451d-8a6a-08de89036a75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: bKTSDaMUmPRibqoIxQmechJUl93KCuWkopRP9YZHOiV5OsxjG8E7T+deS16kgUmO0cm1cuKXvY3TmgkXc2SDJD/iHFIkpTnSt3EI9w2tzXRjHCRuO5BqV6Qq90yeYOLRZIX928jMzjUvFRiRGXaKt42oFr0v5/vT9G1K8RmVOcO9Nc7IlYThUCaRmC+gJoBrkiJ9nkeQTh0iUtNfzHnH9eNOJ+e6HkKGm7znczfRBhcdMCqDf+QudmfebOIS1Lld01YNGyG7XeTKbCSCv0+4a+7F8KdjmmBYtLbpG9kDo/Djv+2VxKgmjW8F0dxGKjh2JeEK+lqQ7nueWgBtZG6kHl94Yr/VOcAp7pJLATYfAavlyE7HZeq173Rkz6hCDa1KZ83xIN0BWAeLP2VHC6/Ij0TV2kulTeWrXfqlNeUUuUbKNoVu10fd6h1IWO9PhJI6QKoPXZgI37TgZh1W0ve2pvxNCGSkm7hbk2nzcNaspqlOkJNR8VclMZy7MRKXC8mnTD6sDvroJsxf7xt+Htp02n4NVQKl7eZzvIB/TGr71oQmbOys4kJy2XFGXc2Ovh6nYUQou1+mB1zdhnhZm9a9ozWZgUg3YaEJR3er/0ZT5sVRVRe+lJDrdAqz+A9iheylCtUy2/8raKuIHkOn6UO18aKAzeQYJubQ4RyMkpLo9ulFYoUyQVFOa0nmgXpTyDCujrzrL3S0E/2zLdFy6wDGVay5D6z2h4yX+8B2pY4VXwaZ5aA2lhTzGp9KcedNNMUkRzEtfGF/HO5WcpYnTR478ZucQL/DK+CJt3I5KoqW9iE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5EoBFvzNB6ghs4LkUeg1xK9OAG25TtFNRNmSsIUBpm7HyXt715FQk7sP5z?=
 =?iso-8859-1?Q?LBYSbnsNHSw+Mk4j1WBS+VJyJ8Tbn0OnDLtkRFE6IjI46LbWV5tbw/X7E8?=
 =?iso-8859-1?Q?gJKxYuXRQytdQY9CO2apatk9sQtFf87Pyr1Idlfygt4p+AxLaHr7UcE1Fu?=
 =?iso-8859-1?Q?h9ztfTqYA3Din6GPx0fUD9Nwh18DVMjV0dJHTnK49JYT26shxUJd/gSD30?=
 =?iso-8859-1?Q?AXfhd1KV6y31XstIFq5pm87t5OURmxEEgtNoQWmO1ExtQBQnLV5vDpE9LE?=
 =?iso-8859-1?Q?6kKuFGgLgvKcJdOUcrmyTlykGnmfiiXq9Y0DLt8fM6Ne6SS+OT87ZPdzcW?=
 =?iso-8859-1?Q?70yVZQJ8RQFWHdtzZoQWgthoOPKIFwnJ2fbjk+NUuSBi1nxJIL3JIJhHCw?=
 =?iso-8859-1?Q?E8nq6P8kaG30a2QkCcOitp2z5ZAkSb5GI0q7J6eHNsQiBBmnmzMWX17jPV?=
 =?iso-8859-1?Q?HYEbCCtrS98+sqtGWsi2zCWH8OXfFrEMEIddRzjOx6FSVpLYkL6Pw2gJQN?=
 =?iso-8859-1?Q?1CHwV0pWtVCKXcY8lfTs/mRIBqYBtefbDOXekY88LF00GBsjEBw/NFuLvJ?=
 =?iso-8859-1?Q?0xT8k5zyMumP4xI/z5CIF//U2g45zV2Qjo8Xxrq83mtlhvwVaE6xKHnt80?=
 =?iso-8859-1?Q?fhHdEUg97CEtmJAzfB8nkMvs/iolIN3xVzNlykt3ZxA9a6r+o7SJg5i0xr?=
 =?iso-8859-1?Q?DrUsItk42Aa7jes0750rCGOSPtMgqNXry5UU+T+NrWCA6IGWYaQBKj601f?=
 =?iso-8859-1?Q?KSBR538LtkeM78KvKJ7TXzX4wmrZB96Vz7+wKEPmjW8gn/9o0ttpb6uTw0?=
 =?iso-8859-1?Q?GX2lfduJTZHYzNvR8L3ih95VJz8cVl5BI2CDjCIHpmqERfDzia1rickeX0?=
 =?iso-8859-1?Q?10K3if6Me+Rvw3bB3eJf485Lz9xt0sQwlpi8NBnT/7ts9wDDRF82vOeaaS?=
 =?iso-8859-1?Q?7q+mBprmO86lgrZ7XiO6qQ6EO2OEkdjdaPnDltNRVFsFJ0QPBdssZ6wLKo?=
 =?iso-8859-1?Q?pmHyjrK0l8E0Cb3LrDzPaXXx8orcpmFbpcK2UR9uuckYE32+mJERvYF2X0?=
 =?iso-8859-1?Q?J69ufEAEq7UaNDPaO+s7pz4sTUXNa0qHnKbe2i1H2vqoZHI/crVSm8a1vR?=
 =?iso-8859-1?Q?uTIMqON2pcmzNEEIkYLfC1UUEsNq67T3UqQ/ClJwsVwaji8lVpFJOngIPB?=
 =?iso-8859-1?Q?6kbQRdxT3yMwgW0K8x8tJ4E2YMV5J9seYw93xqPW8ktDfFA/oXi8ryMIIB?=
 =?iso-8859-1?Q?rNY9gz2a6P+mwN1WLEczAPc73nbL8nlt84b2WRAbkw/I+a8Vi0cK0DPace?=
 =?iso-8859-1?Q?a1xDT1aThNiUpJGyE6VO90Wdw7Y5a4+PtZ1EqDFlvrauUFHHNeadJ12uAM?=
 =?iso-8859-1?Q?iBepb5yRRspmxuAYYGN6sTbLu9XZrxKd5XBdbyUZ5pGWeC7WIU9Nh3LdhH?=
 =?iso-8859-1?Q?mgvwzCGEW7BarW0EKg15iV/61mtk4MB+c5YwQop+/uL3U27riaVv/Tbtpg?=
 =?iso-8859-1?Q?2kNNS9lwCe1nYHsecmGksinGv5EdzBXn1jUI4iQJKzqE1R2iyGBxcAKZov?=
 =?iso-8859-1?Q?YUtIxGiCFoxxIclc3iY3RFtZ/QKLOXTqtVfASoMoXuRjTEH1sQ4k1o7mtz?=
 =?iso-8859-1?Q?SzY/tGLhR94KyqlF9XUNbN2ZR2FhR8r5nw5vu5Zb5jEnkHHslECJybiQtE?=
 =?iso-8859-1?Q?hlfxZ+E31m46CNq0wQWQsrhQwjbG8Irp0nWpJJIzyIzxdMjjt+IIZm783O?=
 =?iso-8859-1?Q?vhJZ8aN3RrgcRqi042mLD+rLVvLaDkNYwZhbMOvVdHk0SxZMtokHjLch7a?=
 =?iso-8859-1?Q?8UsoZxi0yQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8282eb-e5ef-451d-8a6a-08de89036a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 17:41:29.6649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MnTSyDSOoqxyXFpH//eg+GEvQAnY0skTnf4smCymaTELT3qJaMO+MxX1v2+cfSXkJGo9A6ZVPiMXraJH2G5/zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6978
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
> Sent: 23 March 2026 17:29
> To: Markus Armbruster <armbru@redhat.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; Eric Auger
> <eric.auger@redhat.com>; Peter Maydell <peter.maydell@linaro.org>;
> Michael S . Tsirkin <mst@redhat.com>; Igor Mammedov
> <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>; Shannon
> Zhao <shannon.zhaosl@gmail.com>; Paolo Bonzini <pbonzini@redhat.com>;
> Daniel P.Berrang=E9 <berrange@redhat.com>; Eric Blake
> <eblake@redhat.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Nicolin Chen
> <nicolinc@nvidia.com>
> Subject: Re: [PATCH v4 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property
> to SsidSizeMode
>=20
>=20
>=20
> On 3/19/2026 5:14 AM, Markus Armbruster wrote:
> > Subject line: please use the literal property name, for easier grepping=
.
> > I.e. something like
> >
> >      hw/arm/smmuv3-accel: Change "ssidsize" property to SsidSizeMode
> >
> > Same for several other patches.
> >
> Yes that would be easier for grepping - I will change it to use the
> literal property name in a respin today.
>=20
> > Nathan Chen<nathanc@nvidia.com> writes:
> >
> >> From: Nathan Chen<nathanc@nvidia.com>
> >>
> >> Change accel SMMUv3 SSIDSIZE property from uint8_t to SsidSizeMode.
> > Incompatible change; okay because property "ssidsize" is new in this
> > release.  Spelling out such things out in the commit message helps
> > reviewers.  Not worth a respin by itself.
> >
> > Any particular reason this is called @ssidsize and not @ssid-size?
>=20
> I'm not sure there's a particular reason - this property was newly
> introduced in the accel SMMUv3 series [0]. Should we include a patch to
> change it to @ssid-size to match the format of other properties?

I don't think we should as that name was selected to match the SMMUv3
IDR1 register filed name in the SMMUv3 specification.

Thanks,
Shameer

