Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BC710854D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2mux-0002Ix-3c; Wed, 18 Mar 2026 05:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w2muv-0002IX-20; Wed, 18 Mar 2026 05:10:17 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w2mut-0002PC-5h; Wed, 18 Mar 2026 05:10:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ff9qEyZ7Zxv+fnncWxK8IZkHzdomNZRHGPiIzAN469E8M12RjFhRm94yB0P4ElvZi/YEb4RHD2KtsXfICC5pAjrUcPwuy0Emcsablv3KwG5LuCm/28e/g9qzfMzcMjU5bQIDsMuWzH4NpDCltlsbm8UFmlEA3hidYIDZjZ3jRXPXYrs0SD5ZzEOmAqyk6f+A34l1X75+d0l6QK0qPAaA/KYBZnQgXsWK+A8HBQwI9XFXrMpqeSFzPN1pekLI9+WH+yfLWKYhNydCIz0bsWhbMLe/cIMskdr4/L6b2KsdzC4fbIO+YeenbM/iKdU2cKpQHhWQ9d8iTf38U6nI1S7qcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SpI4Fr+QYW/NplyKfQfgZ+YLNxdKTBeVFBADaNsSdA=;
 b=pLpSbfOzAAET5fE34GG2zWZE6Eciiuv6OZM3QQTOQms7u1K/2j7jm4FoNLuHH4NM//wCC1nFyvt7rLyNYdzkwYC/AQqPf7yWBXVIPR+Xs66BC180oWT2U39NRVF9lcUtYJiJzO6IFYIexUXHb/R40Zj4fxrVCwdRbwOS0A3rEWdwRwfM66Q+cW2++h6P30mjzhIz/FQ3KmJm6YGnKdb2hEN7u09PeuLbqfIOyM/xbW0imqPwVIV80Cahy4NDzCXxTFWqSat1qzfR47ftWfvOMM6TPWjxUiJF9AYCVO0UTicEEb6MmKCqTrWCLfaHmmFLLguwfb8xdDPvhOmtzvz+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SpI4Fr+QYW/NplyKfQfgZ+YLNxdKTBeVFBADaNsSdA=;
 b=mRGGEzytFLUbjECXF/0XxEKKxGVEAiEZbjmHTobyWTHZW0nkW38WaPJXes9Qczes1DxiQ+oScm0nTPEP0DvDfymApyGvkcf5KBo3pCq3sxnfwC9+f5ZAwQZ1qzi7Au9a+lXYFejYRG+6vFFP+lvrkg9FftdO2zfu16ii7c9gocx14MBPuhX/iTHI99HeGrj+xJWsMEHRc9rx4+3qRt7wyRc8g5zcxhWJFNbxwalekMGon0dAOAeFRAhjO0UzhR8jJ7NdImYpo3frjQX3MnXvfCeOxxY3YNk628+OMWTOel81ZBwKf3UBDzv7+Pk9LkjMwvtX07+sd6WSPVQxXtqLaA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 09:10:07 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 09:10:07 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v3 1/8] hw/arm/smmuv3-accel: Check ATS compatibility
 between host and guest
Thread-Topic: [PATCH v3 1/8] hw/arm/smmuv3-accel: Check ATS compatibility
 between host and guest
Thread-Index: AQHctj0+CkSbs9/TNU+sHpuWsshrU7W0AKQQ
Date: Wed, 18 Mar 2026 09:10:06 +0000
Message-ID: <CH3PR12MB7548DD2E34492D7E73376999AB4EA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260317183755.3721625-1-nathanc@nvidia.com>
 <20260317183755.3721625-2-nathanc@nvidia.com>
In-Reply-To: <20260317183755.3721625-2-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CY8PR12MB8196:EE_
x-ms-office365-filtering-correlation-id: 241d372a-6920-48a3-8e29-08de84ce2623
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|56012099003|18002099003|7053199007;
x-microsoft-antispam-message-info: OJOkfZYTIgihWvS474kHTvlaKUSszimEojn5FW4vXILpJ2Jdm4Rnw6L+ystc2639kqOd9Pp4wFiVnlxYYb/xaMBvBLXSYE1puTx9R3LcEiBoySeYAvtDjRt+Pzu84O37AuSYrOUI+eNaTJvnV2PpArV7uhpbo8jt3cydT+rJzIcMz3X32ZUDsSlRWiQ8ePxiYltz1SMuTOnq95pO11COROUF+YCd0yx4W0Ovvlu8zKkWtZzq7RnaiWzFfIv3BVHiII/KaTyE2rMa3WwDQyGfFl9P/Y0tjNI3kH2/TGZYGkBGp6ZRUqzaaFp/3WBwEG0nvWc6sMsFEoPGfOtGN8WXbiDiAAq/GBRpKuoyEQnri8/pFyt1vzRy/U7A7LPX2a//WUDuHsRhf3jfpkdvHiZPdPxmpHiQ4nvaV2tVgS8hB8BngL6rfRSTyFV2hwJnYnViL75cUcBcDKodQ5f1taF+hE+q6zcIexhmI3aeiZixXSFEImbNo0PYx/lNV4NrT15Z23xqYUU9ArWFF2p/J6kfP2v4PLH1GBosNaW0iabOoWPkjc1CO8TzBIdRVxU+t+Gz9QYruTZu4B/Sr9kGuiSvHKrgJW/2QGjFOtZqDonIzW14Q41bcHZW0gfxGqccST/QVpaubaDdF3S0A5Rd4fXHUMUqPFC26XMlUjtray5BREFqrTg7LV0VkqKEY205b97972EVoAm1l1Djz9dUbRlkRzi7V5M98CnQaEuGGvDJbSFRPpC4EbV6ICWbvq+19ZpYQ16lx2yRwoVioTFJBYtrnfoQk94QhwrqY0jYhAnbMrQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3H95xl0kjaOfLErhBVvJXm9ml3wdC1ZzW0oKSRux+kxWNEOLaWX18XoNJ2?=
 =?iso-8859-1?Q?HVWTvH4e5E+IOYRFNq8bz+tabVziDm9T93+eZ6LVJUoyktsQFGkzYf4xDT?=
 =?iso-8859-1?Q?XRkWYMSgFXYLku5Q4Vw52tyf46FNaDr+QKpAdnj2tivKcSqC91yqGpBNi8?=
 =?iso-8859-1?Q?Omqu1Zs2eIyVUWuLL2RpP1YKJf1iQ+0g42OcUQH8ILtm+ox5pe2affNPca?=
 =?iso-8859-1?Q?E5cJPojaaL3CbK6IFr0QbpkMxbDaMrk87sbeVZKjFyfQI8uq0FGNpwI2Z8?=
 =?iso-8859-1?Q?rZHwLMhH0Ov1MWNL20KM1mbPbCgAnbA4Okrf3z5XTsKqYOCQHm/qOjItYK?=
 =?iso-8859-1?Q?BazEoCULKIYFQxTZM0jGCQPc8HILyuQysVLcwZcf5y1tpTtXUZkJUFdgi2?=
 =?iso-8859-1?Q?yyZPZ8PZ5UzxKZU8F2e+AnTXWAoSVVpNdr6sN9JIv03KFVI1FnmGCDasbz?=
 =?iso-8859-1?Q?3x+fF0xsyCIxvllY2zYDLh3mLZ7JeyzQACTIZOcV0gNCFynkzQurqxjKxs?=
 =?iso-8859-1?Q?/Hl4ur8JBgQEjGgq01tjtxTxpUYJ+c6c233POknAQ0XAiFo4OI0FgxoeHy?=
 =?iso-8859-1?Q?8sWMsNkkrnlZMrBnUdBVhJLm6a0uOvUriTf4SKKoFKV3zhTSTAxL679rq8?=
 =?iso-8859-1?Q?9eR4anb3Ylh/5lUEbmZBLb706dk8NCyjFFN2A4n5fuy+jI1If3ssWRHLZi?=
 =?iso-8859-1?Q?NOCqFodju3OeT3/8Bdopbbi/i3POXKyjyPtFX6rxxY69hAm5yvHvxGN84D?=
 =?iso-8859-1?Q?V8LwHGYK9ETcvvnUvK21DDQos+ORb9Afiui8CXF73BCsd+Cnu2DtKRoz34?=
 =?iso-8859-1?Q?xcVXv0TBOJ/fop3pReRnXTlqgz5OM+1eyWwuMi2VwPgMCDP75xT6RQdUCc?=
 =?iso-8859-1?Q?q81c5jnZg+i1I8y3eWL1GU77EWK0adSpFqgcOEwDxGYsF/Z6u3zaYjsDD7?=
 =?iso-8859-1?Q?jEuDKggH6T5OixMQNwe3QXhnpLB6WS7kMOJ6siA7tB1J48jB2HPv6R+EPy?=
 =?iso-8859-1?Q?P9t3spCl5+/RV7FxXZR9ju+P2kUvoaAnjx9EwzlNJBlFnHLtdqKmnwulVY?=
 =?iso-8859-1?Q?zXCMujoFpowx3b4DV+Q9F+PkydSJcFY/IRF8LJTtitOhPw+3AdTPEpBQ6s?=
 =?iso-8859-1?Q?cbQFfHzKIiIIsSBgnOlTc0P7iJ9SM9XDse0jPkDZxY+UD+SBqevYKrVWRK?=
 =?iso-8859-1?Q?Ky6zzxN+UAmnmmfo3yqH34Iq8YbeLWur/8eiRPi70LOGItH0pq6o0a7jVI?=
 =?iso-8859-1?Q?G62ThVrR1o4bVCtcr/ice48wNnYJahhg5kWAAC6Hngu3mpTgj1Q8PzMZ1P?=
 =?iso-8859-1?Q?f+eYr9sc8Cvcj0Yxlwa6iFvPNrvuOA+GGm9dP/hKSBHhRldoPySyRvUeCi?=
 =?iso-8859-1?Q?TBYvxjViNsku7ETiT1Ce0BduzSy0JMDq5VhTPy0zYWF/5HPDkK0TxA1PcU?=
 =?iso-8859-1?Q?VRpYtl97gcP690ehXi5GSJ/hsUPUA3oDy94PfpSDgTBFL7AmUqcv+0tcPB?=
 =?iso-8859-1?Q?pCJ7EC967MHFMumAsCf9l8c7e89E2o+TPywAqji1e9htaYaC+8aHDt5Ldq?=
 =?iso-8859-1?Q?pnGM9gm4V7TsL+yp5NTn+udHqkqz/Zt3oE7TZHHRBX8ldy6D/LQDDI3zFo?=
 =?iso-8859-1?Q?gM7qwVWHVD5mxq7ZdcRaBbjnL1Rltrzex0kHuwhrkQK4MRIKfQsoPr3N4C?=
 =?iso-8859-1?Q?wTJzXczqBpK3bvlXMltlARwIECFRFg/QNF7UDNEcKYFfUVIIHwQJ53SrBJ?=
 =?iso-8859-1?Q?kb2gU2oGalCZeDDvC4EosoEGwYtDv4zBD/gbYrYSelxMyYilSMbuw/qtRI?=
 =?iso-8859-1?Q?GB8Tz2UgSg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241d372a-6920-48a3-8e29-08de84ce2623
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 09:10:07.0555 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qhng5Th1Mws8wDQ+BR5lf19LhOlDQjr4Mpkvc+l+UIk6GFh/7SFDrvOsRRjINcJGJL5HApkCJhDqlVGXvWyllw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196
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
> From: Nathan Chen <nathanc@nvidia.com>
> Sent: 17 March 2026 18:38
> To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Shannon Zhao <shannon.zhaosl@gmail.com>;
> Michael S . Tsirkin <mst@redhat.com>; Igor Mammedov
> <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Daniel P . Berrang=E9 <berrange@redhat.com>; Eric
> Blake <eblake@redhat.com>; Markus Armbruster <armbru@redhat.com>;
> Shameer Kolothum Thodi <skolothumtho@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>
> Subject: [PATCH v3 1/8] hw/arm/smmuv3-accel: Check ATS compatibility
> between host and guest
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Compare the host SMMUv3 ATS support bit with the guest SMMUv3 ATS
> support bit in IDR0 and fail the compatibility check if ATS support is op=
ted as
> enabled on the guest SMMUv3 when it is not supported on host SMMUv3.
>=20
> Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c index
> 17306cd04b..2bb142c47f 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -101,6 +101,12 @@
> smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>                     smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
>          return false;
>      }
> +    /* Check ATS value opted is compatible with Host SMMUv3 */
> +    if (FIELD_EX32(info->idr[0], IDR0, ATS) <
> +                FIELD_EX32(s->idr[0], IDR0, ATS)) {
> +        error_setg(errp, "Host SMMUv3 doesn't support Address Translatio=
n
> Services");
> +        return false;
> +    }

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer


