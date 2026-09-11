Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF9EC88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x51el-0001PR-Fb; Fri, 11 Sep 2026 09:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x51ei-0001Ol-MR; Fri, 11 Sep 2026 09:51:04 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1x51ef-0006Ma-NP; Fri, 11 Sep 2026 09:51:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRnrl95Tcyb01JHt1oCdHoOESGyEABpPBAGUO1Y6mAWTH5+UeUsyUxJBUdzFynKeGY7TVlXjiBifdTz/wp8brEcAvY6yrhQPeiAAdKLBVbsmlYkTre6tdTx/i0srlF2lffHp0b5X9ccRJwGVcTXLv+GydUgx6OyKrf5l6HlZ8ncfeZP93mgUKtBRJdLcbmywgDx1VRaOlaBhINQq3vGYM2GqEVKPjbxOiXs9COBfsMZOS9Hm33QddZpAQW8P2g/pIjjfud9XgIOJeELMtFvUuCmzNH0l3Q17Y6UMMOatXqweK/iqE+Ukpl6wGDlAdbyMM+nR/G4bhLdxUcaXxy2rag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAZHZQOPC8FropIGIJAeuBMswFromnEbRXJedDRnpYQ=;
 b=HwaB5oBf+XgCVbXvp/UQm0E44I2y8MCCvkQFbFHzMSVlS2zqCU9jrAYkChpVz/xizREfFkhnFZK7hnHtRGtKpx9X6q0ERmuZ5tbGxldHQlKsajDlJdCb10Rm9ARKE+Y6VDDqmiX17A+UgOzRIBVmHUy2sS2atd2nK/Iy683wNPlFDHeb9lo8pQUWb+MT5D268mzCmf8BG+qQsadwtzqIQ5fFSmzGd+0zhu6BDiHdgfQQX5VsPnHWQ5z54/cwn+sifvsyCGeQVRpphtep9DWv1gvIYU63g37nx2ZUZfm1KH4+/mjZNn3Z9TdQb+awXZRUh6na6QoPGwg1+w2p+BHavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAZHZQOPC8FropIGIJAeuBMswFromnEbRXJedDRnpYQ=;
 b=s7tGClts1ZlporpHFKA7MW/lyJAkxTKSl+tRXUiHWh9Vi7JAFIe8YFpiV1j3Lc8SwC8vxhF9ZgCISLI7Tu/PaHbE/hQ3wHj0hJRJIoZKIFHC3utPUNxZc/X3zxJ2P95gSQfEwXoS7v16CaiAfnh32v3JkCv1FoiNNEDb+e7SICaBg8FItdSGPRAXwpGut2L9cTi0KUgM+y78ruKIn+o3XZcPagcpkSUZfGdDG52469uU67EAUGaQjjWIsZ4/as5ZJtzxTBpC0Ag1T0xOCG8LX4OvSZNJ/kk60PKdRjyi+Nm6aKxe/o3goQXIx1DbFrpbSDFVRyIIa4w2GM2z5Uuc1Q==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Fri, 11 Sep
 2026 13:50:53 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 13:50:53 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "kvmarm@lists.linux.dev"
 <kvmarm@lists.linux.dev>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "shaju.abraham@nutanix.com"
 <shaju.abraham@nutanix.com>, "khushit.shah@nutanix.com"
 <khushit.shah@nutanix.com>, "yangjinqian1@huawei.com"
 <yangjinqian1@huawei.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>
CC: "maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
Subject: RE: [RFC PATCH v8 15/20] target/arm/kvm: Ignore and trace unexpected
 writable reserved fields
Thread-Topic: [RFC PATCH v8 15/20] target/arm/kvm: Ignore and trace unexpected
 writable reserved fields
Thread-Index: AQHdNT7Vaym+s/bSoUKaxK+U1n8cBrbJfJMA
Date: Fri, 11 Sep 2026 13:50:53 +0000
Message-ID: <SJ0PR12MB8614E4CF6C7C81CAE67A018DABBE2@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260826093747.1670077-1-eric.auger@redhat.com>
 <20260826093747.1670077-16-eric.auger@redhat.com>
In-Reply-To: <20260826093747.1670077-16-eric.auger@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|IA1PR12MB6649:EE_
x-ms-office365-filtering-correlation-id: 5e6e8c23-e9f1-4416-ee4a-08df100bb2a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|7416014|10067099003|4143699003|56012099006|22082099003|18002099003|11063799006|921020|38070700021;
x-microsoft-antispam-message-info: 5kWPnlyT2Fb8eDFT0jE5oxXmRgQkM3hnJEvt3xRhrMhc0ik98DOeg+xDL6jxIhKwJ5L8HXr1Eq7j6L2ZoV8OkaDVMyZhHDQ+YpR6jrM2Si3ncAD/0g9cxrXOd3UX9RRXI9vBn3KaIyixx1LTLE35w8cLOfAsrXBcwrrF0Qn7C29QIx+kS/9zDz2rxXapxvyGXMjOpfCp+RDSkarwXxr5NB7nhx+ECcnwKjy35654Zi8Tmr81ZWHalD7+KEQTrEsjDxJ45BF+KPXo0aDT/9el23kssoznnq++l5DeLfDTyecQdLwUcgSWkqR9x1lsoo8jXNzjSMJy1aVbL3vHOfX8fpfE7BXNSQZG5GQzptrLDToTtBO6QW2vs/RWHifUYrsWst3d+VZHJpur/SWFi5xO51ofRWlgm8De1xQGDF7DoQaqZFPm9x8UbopzHH7hGctP7SmZJZvWeNO3jRsO7wD0+htNHXwJ/DU7fUaWUcSOEX9I3xTqmecn23MQoLbuMzhA3pBLgxam1Ar1CPubvAZriFLDlf2QqvBgFAncAjZ2hysNATBRB4uSYK3gQ2hHOe/N+yx6A9PgmNhlnyiVQxNixwSYUje3RpnQlqSpNG/z/rNUepNIQLOaFLnjan8PtPQOdczUBISkNZeMulBsHC77+r80a9Zs1uDeq+WfgLO/p8rFKWYDqRvqBbaaUtoHceKh5vlf/QcsNRq7mzkU564idYZNS7NWF+3r3fvSYooX6DNvmQKNwv6NAY0ZIZJ0dREz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003)(11063799006)(921020)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uTs4GHROOzTp/edjL5jKt+T6+nIqjpMxDy/ES36ZaF3SLjl83AkQS6i5Wf62?=
 =?us-ascii?Q?RFzoJZUVFeCsuDoA3DXUlnKft8gMr9ynvRSJ0hqjm3TxrnphZppaWJ85AYtz?=
 =?us-ascii?Q?njmlRCmxIQnmE0juc50p2dkou1eEP7ztf23RtlLE6xg9g5sNbLtHHeFdEnn/?=
 =?us-ascii?Q?6qH3h6U7KrY8UbXNV6SnISyJV6gpOxmRsDCGTrB0WTrfk8WVqL3yf0W8o4Do?=
 =?us-ascii?Q?3oTFrAKnr7uptKMy4hEdwfpXDN9MQyq4WNgjAVJTGJlQDUXzsG09DguQ7Yjf?=
 =?us-ascii?Q?plWSpthSokWIbEGMpDlC0H5Gi4u0qv03exBl7jOly3DnOTa+Px5/BeG4Y1DL?=
 =?us-ascii?Q?Aze/eGqOCk+9DuDbJdPSPf92vAAHGIorKPtX9nBZ/B7UpqqUsOt1vNGl/qcC?=
 =?us-ascii?Q?/wNpTYWUFCNhTvdFS3lWHTQb/wEoxcrtoGi7YV/gYx2kV3RGnfFy5KKLUSOS?=
 =?us-ascii?Q?BXfPr62cU2qrJ0elF4ZID19FVCLRrRn4cQ3uqQGoced8HlB0Ux5kPmoT6sb9?=
 =?us-ascii?Q?+bS8Xt91TeHbUsFbKwS3mmGIuNdXcLDiepeCyV0dq9H6AiItJMpImvKvQ5QY?=
 =?us-ascii?Q?B13RJXZTleZorjuyAMajHNOZaXgXwSt+Ksn85ipZSmB8pyZZAWRotscmKGFD?=
 =?us-ascii?Q?XZFJvAKBnYWWuoJcVFcnxY+3LXsu0LrXAja9wj64Vd7ddFjOe6P84o4QTaJY?=
 =?us-ascii?Q?xNjzu7s2WY2CbYJlsk1VO+J8K09Ha8HqsedFBqesRISbzdMYS9vnK0vyss3J?=
 =?us-ascii?Q?pSY1yzLcezm2jqBTx7GFSOSvkb3FRCaKWMTA6w61VbDQQXws6iwCnmOHMOFd?=
 =?us-ascii?Q?qiPD6Xzly770lk849/E+KGPdmCAiYoZrUhzDh4kTBwurR18w0hqWf1hwvVcW?=
 =?us-ascii?Q?NVH1qOyO7j6cGkJA8uZ5qx26ly3jJDSZ88PDxPE/NhccHTXPKdveGWYzfIZh?=
 =?us-ascii?Q?tzqXiiAAcxBuMJKzLu52pHU2PB1gesfHGxLvy4Rj6bDe7AXI1e7udKEr+4sw?=
 =?us-ascii?Q?guoFV38JQXxKXNhsJ9OUQmGZ8mOxDnAUvTTPuwwdbamC6yWt9bJrNU6maRyQ?=
 =?us-ascii?Q?Rbif9g5LMp2xXX29waLf57kQr1J7ridjBDo6hlAFaoYgKotjOWFWwzUzZH0L?=
 =?us-ascii?Q?9oeuIVZGRafvm/AeA/07yaoqQ8WJo2H9N0p8mqbPqHjtaPN0cpoEDsB7PxuU?=
 =?us-ascii?Q?I/oGxhnvCXOZzMwg7XEHJrcbOflD+0Ecl8BzSUsgxim/QOYh+vdkLeL7kb32?=
 =?us-ascii?Q?yUzO4pa1cMZL80wIa+cOfnYRH1hMACMuSpMze0e8sMOoeceI2Itc3AzkbqIG?=
 =?us-ascii?Q?sbybtpFtOIXVd+wCUnTKMtrJdCO2uEZXbeI1BZ9a6VOQpoQ9NF+r9e6M4QH8?=
 =?us-ascii?Q?GYCsXD5kPtQwu6oYAXxPBbArtPOw/2KTomaI0c2bvipvNB9XF1p06ur0P27D?=
 =?us-ascii?Q?gTUP5bpOLIWLeQm3Hl/yUMgzhnNtbWAagdxPcbOpRew5WvGR08gnwwYtTpL7?=
 =?us-ascii?Q?bwQ4xkAjz4q4s9mX9Owp9/uUfp/Byd8rGaA49HESyxgHVQKhH8gkSJkb92cT?=
 =?us-ascii?Q?ruONkFYEgItV/xj7TLscDAybAiZ8UEg5nBR++u7cqpsu7YI2+CWd+N0HkGZD?=
 =?us-ascii?Q?NsePOkELJDdFikS1mZtDhF3MuVILLcgTZ3kFzSccI9dZR99tCxNCRo5mZoUV?=
 =?us-ascii?Q?LSCGvTRw8DpiNs2kK7p1cGEiXUxn/jBMJU573SODlIhGEtC/ktL5ywiUlmC/?=
 =?us-ascii?Q?7nw52pjRUw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6e8c23-e9f1-4416-ee4a-08df100bb2a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2026 13:50:53.7880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +++LqLjPxUPoj2ZxDhpfyXE1cLKKJrBbgRNfpAkxyMbXj5Hap+k+I/GIPv9rcI3qVWNMaK1rSG9b3KEYIpviFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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

Hi Eric,

> -----Original Message-----
> From: Eric Auger <eric.auger@redhat.com>
> Sent: 26 August 2026 10:36
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
> devel@nongnu.org; qemu-arm@nongnu.org; kvmarm@lists.linux.dev;
> peter.maydell@linaro.org; shaju.abraham@nutanix.com;
> khushit.shah@nutanix.com; yangjinqian1@huawei.com;
> cohuck@redhat.com; richard.henderson@linaro.org; sebott@redhat.com;
> Shameer Kolothum Thodi <skolothumtho@nvidia.com>;
> philmd@oss.qualcomm.com
> Cc: maz@kernel.org; oliver.upton@linux.dev; pbonzini@redhat.com;
> armbru@redhat.com; berrange@redhat.com; abologna@redhat.com;
> jdenemar@redhat.com
> Subject: [RFC PATCH v8 15/20] target/arm/kvm: Ignore and trace unexpected
> writable reserved fields
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> KVM currently reports some bits as writable whereas they are
> RES0 or RAZ. The code easily allows to do some sanity checking
> for such inconsistencies. Let's add a trace event when this is
> encountered and skip the field
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  target/arm/kvm.c        | 8 ++++++++
>  target/arm/trace-events | 1 +
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 2557d7b0d9..8ec9bc51cd 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -433,6 +433,14 @@ decode_idreg_writemap(Object *obj,
> ARM64SysReg *reg)
>          }
>          lower =3D field->shift;
>          upper =3D field->shift + field->length - 1;
> +
> +        /* Sanity check the field is not a reserved field */
> +        if (strstr(field->name, "RES0") || strstr(field->name, "RES1") |=
|
> +            strstr(field->name, "RAZ")) {
> +            trace_unexpected_writable_reserved_field(reg->name, field->n=
ame,
> +                                                     lower, upper);

This hangs QEMU on my setup, the guest never starts.
I think, we need to advance map/i:=20

+            map &=3D ~MAKE_64BIT_MASK(lower, field->length);
+            i =3D ctz64(map);

Thanks,
Shameer


