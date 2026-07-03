Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25F8C44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfaJ5-0006sn-FL; Fri, 03 Jul 2026 05:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wfaIx-0006o2-D3; Fri, 03 Jul 2026 05:35:29 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wfaIv-0003aK-Nt; Fri, 03 Jul 2026 05:35:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5a86PrMgSn12TC95jtZ3SNZZyw+gklI9d3GQA6QCGWNy+67o0hgdCWMlLhCGxamvDOLtokYyZuBgAIMxZKRt2OU4q58A31hiaAN2IwIy0TkqL7ME1A6gqSOcl/Len1AbETtVxtitL4sh+NO0NtDb5Qk/y+2DMrby966hZzqs9U9yFDKiCrQyhhKwmdJz2NA9c3BpF3gKdLvmXdmBL/o8qf8cD0YjjnA95bD4o1nurC2DmIbbBPZ+Gx4vOfs4WcuLGgHWEf5xqSEwXLLCqliZ/aIj5qhYw3mhsIngGyTpifhByXv4PzASqfRXAmj5Yw96ASaNILKtn7EdcH7VJVzmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8G67qn0zo0kp26tivzygtzU7a5tESk0nYeWHseUqk20=;
 b=g/+ECQ7ouI+XFLEG5ZYf4Uf5bUftA8j+3/ozE0Xof8HVmM/pbkJJ2wgicJzeZwZ0io1YbBtVaSybI14+u7uO7knoQlKcGMqKZxluXu22vuvgSi3g+pRvZGRDIhqubpRh2OprAk+Ynb/09E+4j8jPGWwWpDhWAppgsDeAtXJXAOR19XifCvyFVvLpKvZd1qMWD+wghqMmg/w0Ds/l8uk0ZEpmSCAjvMbMBfksgnFsZ5YT7tb8UDflltzzawoyci4A3I8YRXZV8teQauN5lXSC48RIlO3KwZFQKJzUWckvTJZbkK4wjZPqDQNBpRYFmn3Hln7Ysc4CGAY1tA3frW1Xyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8G67qn0zo0kp26tivzygtzU7a5tESk0nYeWHseUqk20=;
 b=Hjh6TyeOFX/TiyJ4ipuGxd+nwj9cY96oyf0/tuMXUAKCExe9QlUHc441I25DUujv99R6ZI8dLbIJ1tK0J0mht2ZpEPbrJ5CALZr1tyrrVPn2JC8RtyVqHqlC9W9N89saTA8Em0VuhuZY8CwXBbJZnQh5w+eWQrhGrx+LXJ6or7RMx6mszBcwwiEXm1zTvKnYgfU+eq+lpfdyUSD4tt77UynOH7FbBc7sydce9Ua/4Upb0sWDOAqIfFg//l8E2oeoBIUuTXiGGm1moSxRgGJx6/VLArnBF27V/WUim54mvCZAregkhRz54qLSchi8SoZk2JvE6JRgz/v1FO4B+UJkFg==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 09:35:20 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%3]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 09:35:20 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "berrange@redhat.com" <berrange@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: RE: [PATCH v2 4/5] hw/arm/smmuv3: Check L1STD.SPAN
Thread-Topic: [PATCH v2 4/5] hw/arm/smmuv3: Check L1STD.SPAN
Thread-Index: AQHdCTnEDeF1imKmWUGMGwMyUokucrZbjAGg
Date: Fri, 3 Jul 2026 09:35:20 +0000
Message-ID: <SJ0PR12MB86143BE05361D043D82FCBA3ABF42@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260701091209.2860306-1-eric.auger@redhat.com>
 <20260701091209.2860306-5-eric.auger@redhat.com>
In-Reply-To: <20260701091209.2860306-5-eric.auger@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|BL1PR12MB5849:EE_
x-ms-office365-filtering-correlation-id: 7fb2355b-e759-4d38-19e2-08ded8e6661f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|38070700021|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: LmFBMGtwkH2qPt7RCD+xcKb3BRzJA+yrjGjXmdYwph5ovycxSfC3JlM7/6L16nvpB05Fhxf3Of6Vz0AHdlHRsdSYps8lihj16HQjtVzS47LPxHjlpjPE0Ixn98SaHx/6ixlO9fQED/wIOH8/Qm8/2ZMJsaJ3VZhry1FtoOTdfWJjdGN5UAFvmVwVvT4W0KlkDqN6UEypMcAZ+ro/hPss9TddCMAWukoH+VQI9E8Is+7kqCv3FtgucMXCRmqa2Uw+pfvO1pTxbaxAmjYNpDVAcedNkVWWFZ8yTMEnX46Xqlf/x18i9sNJLUQAVXGs2APSjGRF/G6HuPc0MoeDAiWtUt/XwJBUJ0DhGcCBV9DnTrnJ9wvzmvMACQ778oijuB/r/aIJFwKQxghEOiWWFvdWkDDbAH5Z73sbp2kEF22O30ioPhtPQ+UioRsU3oVk1ZXRxxOlHK3RRS2qia9GR15BJp0jicd6aizOPAf6gxKCmArqLnheYdQsR4VygE3PY4jUMe+lPR+TwCEcDMrar5O51XUvea+Irr3M7NLb2rO2Fzf2nnJumZelHkJrFj7TYMki9UTu+8ebikYFWLN3gBwKlpfn8USkQ7ZU0yIQiwSOMasRgilmzdksb5s6IP1XN5QXiFWV6dk1x6BjyYR6TzjhV8VySs/RIj7Kc/GesKXn7ChLbKiwUMIrwiC51K3FMO0eegTwxCX15I3JSfb6OhqRrM1MqMVEltHf5SrnpBGNHM0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DvAt5q5UZcV9O3+f3Mej26eQ1CqDlXQanzUUEokRRl0cs+gGVDf1riU0Fpl6?=
 =?us-ascii?Q?UDSi5+0DhwqGsp9cwz8mQ4VU2YSAr/bkSPASYsSNA0sYMut0EjcJJ/VB72QX?=
 =?us-ascii?Q?1iG2XhKHBnR7Y1XhNnObKiIDM3PgCxG8PqNSd1HQKGaIcetOumpcmca5Q1eE?=
 =?us-ascii?Q?BrUPWhDiZdMw8AcYw26mw+L2/02vZ08ynOUs2m88GNUNTuIpWgS/maRhCY8q?=
 =?us-ascii?Q?Psup3Tt5YrklcPHwVAkQ8yV3IzM2v475Bw1ETDxvC8YsYFbkUK9lf/VKlKYk?=
 =?us-ascii?Q?LPqw3364QkmdT0yN++AFk1LLnZXXhWmvdEMdh5NLLnTVZMTKFzmmpRhEJB8z?=
 =?us-ascii?Q?zwcBqLTp3xdMmSpV1DoHRp6uVdUyxCf7f8E5O41USvDTavH1+lq1x0j92eFB?=
 =?us-ascii?Q?gwRIDllL59DCLCl8rBMRGoG5uNf9L0TIojIJwh+GcVFol6sXb2x5L3W8dW07?=
 =?us-ascii?Q?yvktf46/PwX/1Xe51h1INYyIcJY02EVyHUfO/OlIyHLMYcqdVHzIdE9U4k3l?=
 =?us-ascii?Q?otgSVn5TuSQb5uZ4lMlyRdGAmmP/FyG3TDXAoODaj99ZF4Q0SkEBfHDCcTng?=
 =?us-ascii?Q?gHMj61w0M8QQXIXXuLKGktG0fXcAWH4acwv+hZ2X9+l1Glah7VzEtmoJXGk8?=
 =?us-ascii?Q?5CaoSlwGvXkdCq7TaPkvLTePOYDa00p/jOpsO5BH5H99abjqBa4fFdCsJy8W?=
 =?us-ascii?Q?LoZJ48HYrqiCTicAcDD7LOInFjPwg7aQ9ItZFQ6BaD6Z4kCDhUStIvb2q0G0?=
 =?us-ascii?Q?PD8Y1NKnGygBBdrbBW4I+Vr+pXKuMPsfCJxEuQ2f2C/kCD0RnzO5BcFGbI3g?=
 =?us-ascii?Q?pTidRo/MCuynahH7dOzKAPU/fBD+GWWQAvBvQP/mNyrsURx/FAx6VabIYZkW?=
 =?us-ascii?Q?GQImiW/8arYJ9euI8FAwX11Mr73QpxnEzVRY6V9aXJ2fulzsdkn38eR/7tt4?=
 =?us-ascii?Q?qsYSBvU7eEBQiYHCLlSp+Gb7GmxOOcrTd+U58zJ4vMNgFdYmF+7GC/cZM12C?=
 =?us-ascii?Q?OGki8wajWW6HKr3IEmFZIPgabPuf8QR3b15R8oFmH/mlSY+evRyMUmTxythF?=
 =?us-ascii?Q?5jOMf1wXdF5JNzZ0VikGuOhimQeog/d0Tk+Jn7tJWqvUMW/Qt7TbPaCls2mI?=
 =?us-ascii?Q?VuxP72NlNGa5cT74hMbPLTYx4etknVijN/nbJwB3BEmX5PlKP+B0tD6KGN8f?=
 =?us-ascii?Q?zOqciLifKzcnTKnIDxdusvboPDPWFun57+fECYdOzYn2apAs0QDlEDRELWXp?=
 =?us-ascii?Q?uN6O9oXDPSWDIj9JYtaBEOZlcD6J+zZvRwaCqMJrTfv6y/3gGvlN+L8BMG8t?=
 =?us-ascii?Q?MWFTDbyMLOtjUS3xZHCwSXDgMOkbW9LQ9d+rycPBqd5S/VTlHr8MsuKs99RR?=
 =?us-ascii?Q?PpZtX+GF47U9FXs+hvBASvenziGrbdjkKSUpvhUJ4Mpg8RvKhUkxF1tB2s5U?=
 =?us-ascii?Q?AjHA7B3U0tt+Thpew/TEYBVvlAa0HvNsTwrAtfc7LD17Vfz3XmdCTTneEH2d?=
 =?us-ascii?Q?DTfkynEmTQNDPe0BsQeOFPhKB4whddH23+IWtCo/W+791kh0PHD6vHQYEefF?=
 =?us-ascii?Q?rf25fuL0fvIBVCNak6qfS0NMaBNS7kkleb72/aHo2oP24uiSq0qpIUNXMtiU?=
 =?us-ascii?Q?M5baL+UDvUfPzVGReHc5XiZQcgMYidNXPRm9nGE4MTqBZ14eMrC7qMDYfEl9?=
 =?us-ascii?Q?PTcqtpWncGFvA4yr4xSAQCaOTvfk7NuQb3NaGgTWH1HOyq1nc5OpjdWaLFHl?=
 =?us-ascii?Q?JJ0YovGq0w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb2355b-e759-4d38-19e2-08ded8e6661f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 09:35:20.0225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2TyqkBi4TZjUrKV7H8KlwnR7EUEOXUrq+oN2ZxWgBBN1NoHISzIg566w7lj8LVnsM5IXxabkZhE3wfis5ue4Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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
> From: Eric Auger <eric.auger@redhat.com>
> Sent: 01 July 2026 10:12
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
> devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
> berrange@redhat.com; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Nathan
> Chen <nathanc@nvidia.com>
> Subject: [PATCH v2 4/5] hw/arm/smmuv3: Check L1STD.SPAN
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Span values above 11 are reserved and behave as 0.
>=20
> Also span must be within the range of 0 to (SMMU_STRTAB_BASE_CFG.SPLIT
> + 1),
> ie. it must stay within the bounds of the stream table split point.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

> ---
>  hw/arm/smmuv3.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 5ec3700d0d5..f694f832598 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -707,7 +707,7 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid,
> STE *ste, SMMUEventInfo *event)
>=20
>          span =3D L1STD_SPAN(&l1std);
>=20
> -        if (!span) {
> +        if (!span || span > 11) {
>              /* l2ptr is not valid */
>              if (!event->inval_ste_allowed) {
>                  qemu_log_mask(LOG_GUEST_ERROR,
> @@ -716,6 +716,16 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid,
> STE *ste, SMMUEventInfo *event)
>              event->type =3D SMMU_EVT_C_BAD_STREAMID;
>              return -EINVAL;
>          }
> +
> +        if (span > s->sid_split + 1) {
> +            if (!event->inval_ste_allowed) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "invalid span (0x%x)\n", span);
> +            }
> +            event->type =3D SMMU_EVT_C_BAD_STREAMID;
> +            return -EINVAL;
> +        }
> +
>          max_l2_ste =3D (1 << span) - 1;
>          l2ptr =3D l1std_l2ptr(&l1std);
>          trace_smmuv3_find_ste_2lvl(s->strtab_base, l1ptr, l1_ste_offset,
> --
> 2.53.0


