Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DB1C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCbi-0001hQ-PO; Wed, 28 Feb 2024 00:35:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rfCbf-0001gv-PA; Wed, 28 Feb 2024 00:35:52 -0500
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2009::601]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1rfCbd-00005i-BC; Wed, 28 Feb 2024 00:35:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egeY3qHw1IZwaHwJnvN65eMIVr18+4yZLayK162jBkACrW4wR7g5700+lRsNvkAeLKkMDaLiWw8H+FIONumVafSqOXtdWeetBv5pdtvv9jVMNwemiE4DVyTu+pW8hcQzMJRwtcMAE8C9W5QqEoTusLHpbL95d0gE3DdBuehrnBtlS4Enc71XmQM4ou8Nx3pX/36KHDG22IhfO3gfpMWe7n1RGpSW4kAJuttPGnhcUa7w59bdXCxKx8FeNI+3gwqZgYnUqElOHlRJyQ8atvAdNi6DMaL0xfelcY5pVGWUEXU1Zn6zwNSOMciYlBr9YpoUFzqp+Cd10ESjFqBxCtzzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2Dmjo0eTFQBTdZu7RcW+bAtGwrsY89f3kYbWYqUfcY=;
 b=VVE6OU64JJAir2w0c0EnvEAZmQXpHmAR5uc+h95fHbgopB55ktSs5hk6i7MuXDO5aP+ISmIMnnIsWWbc/y3lQ65FEhiXZfx0FJ3cL4Os0rL6KBsxW8xLQCG8iDEt86jVWcmkC2dcewyU8f4z1MnvEqBzeZbeOY4bTTtC4O6U0VEOeCLUtoUXu4X4EIHxrs50JcQf89RecAm/DGKYB7+2t0foelNgcrmhNxuWw3oaY35V14Ff5XtB14DlUwQHGA7cgx6HtrLCCnTA3hYO2l2y3Hi+zBvF2dEDkOse/GBsa8Fwi8oXqKovnoiU8S3KApvQ1yZ6K1ElItKmPGMMQlxycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2Dmjo0eTFQBTdZu7RcW+bAtGwrsY89f3kYbWYqUfcY=;
 b=q5NdSJr1xOQjmdbDTeWvnldZ29FwK1tD5TAJSe1zOGN0aVsPFN3oUnj7eb6jT/uz1v7AiS82QP8ENkOL1L4puCroPWdPRZYbZDMDnXHF0m4JWd2cy/s7b3AfLFaPh1tJTXV5mgtUBgClhWKi1PINl0rWFl1fLW9ozf/V+/8NGqsht7rxbsXy4uUOyMKzTOZF2gqxfj6OK6Hj0kqQfJE0TMBVeXIniB0zqSvCmAmU/3e1uHDZ9+kDX/5z7PfH/9Vwmc22L55ENw5DcDcI4co8YEyPbfVGR8UVG+dUtnT/LofRBLhgQeh+nJGMLXu+SxfxFKuAiU0e6gMDkY2Hmkw4dQ==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 05:35:41 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::284c:211f:16dc:f7b2%5]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 05:35:41 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, 
 Zhi Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Aniket Agashe
 <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 1/2] qom: new object to associate device to numa node
Thread-Topic: [PATCH v7 1/2] qom: new object to associate device to numa node
Thread-Index: AQHaZlXRpHP8fv3NL0CqBnE3t10aOLEeLS2AgAEV0SI=
Date: Wed, 28 Feb 2024 05:35:41 +0000
Message-ID: <SA1PR12MB7199AE8E98FE0A585A901883B0582@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-2-ankita@nvidia.com>
 <20240227130023.00000744@Huawei.com>
In-Reply-To: <20240227130023.00000744@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|DM4PR12MB5149:EE_
x-ms-office365-filtering-correlation-id: 44dd4cf1-b5ab-4fca-ad38-08dc381f1a20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zOe4Dyf/npw8Aif0Zovts4+9xy6H5lD7/zKgMLnwiF50yyLL7tSVCW+Gm/fS1+l71xwqEGJRbSA4XGGfr+a5jBNuuNmR9qdTUknc7f5mp87mEHDL/72dpZKMPLWVDaGjeYVoSt8mfm2rwv5UwgqPZNsmCFB3xeCLwlJ4LramvQwdW56TZfwbXd4+IItSSuueVRpJJtdrgeISt7MhBGEEFmG1WVWJ74DfPVneEibhAy3peVDrFuYPfJSqkAp119KDIDkRPsSi6gv87X+o/WV9f7PTdC3g2EKxNNymYRCgmdSeD8H+5okzU3QkBx31ALQZ2FAW7THipoExBH6ZsyNfsIMfP0/z/Ep8aBYRoEvhm97vR7W5kBAV+yRe80lt7FVHovgcI3XB0kgPNKTHqYGykJ2/54cShmAYkmFj1ZF4NknQAVygnd87GHBrri++Fgmx+NJxNF7D4LGSkd58fc1vWQ7AGGxNd3K3y7WJ1VLGH8POeMPLtPqP8BL/i5/nBtHCI5NacS8pliUxhrM0zRlhzLaS5HImktissA3GJsLhKAIEAMkAoHl+LqbtgB3Q6N4A0a5Vqh80UsrFC8Q2XCqTiV6bNfaJmyfDDv307+UHFe2i6b9yWEpudtvDQbxhB4C8p0KUvbxZBzh/wgTxHeiftfNRCT+IOzjartA4Spq6Dw07yIv4JEWw7yP08IZvOn6ELzzZ8/PDSkCfgMNb9SUUTQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?q8DOsoHUCzkHlyKsj5g9vCYxhoIeWx1/nR7WT3oWyYNcqsAj3C9M+//K5L?=
 =?iso-8859-1?Q?sMzKwAzAAZdActWiPxKxN9S1+1keWZNliZ73ooveZWbm9vavuOUj8Qs6j9?=
 =?iso-8859-1?Q?d+RcsEewR5jhfxUqLAvmd2ncFcDMbz9ifCLJpwxZzQ6lMLqQB28vdckDH2?=
 =?iso-8859-1?Q?FDBbeA0oDkX2R/BdOtZUC1s2wgR1/zCGwysPqr82we9feHDc6upvHBwa3d?=
 =?iso-8859-1?Q?Y+VWzAn4j4tqbfYun3azARLWjhmswpRKsDiemF1oEthUtTBy7QK4ZIULvz?=
 =?iso-8859-1?Q?iXRoc17PjMZVoeJg4f6Qezy45tQgMdI9p8pEm0/fAWsopEaA3z2VXmgJPl?=
 =?iso-8859-1?Q?XK8IqbAA4aGY+zZVW2IGOjWa4DaRSTwpU/ZBVEw9DxEvmkwqZ3+GXvwEwG?=
 =?iso-8859-1?Q?XROVpwOQwkOWcSq+Ieh2VuuvGExCZflSyQkFyEZkjK8sgJU7teItPUJsCJ?=
 =?iso-8859-1?Q?SowToHe3OVeAZkkpsVnG01uHAzYES/kKnl9Pjf7+scihpfffKPsGEWD4vs?=
 =?iso-8859-1?Q?OL0R1zwMszJbo915DsdB58mnSgqZnIkYYSniYe1u0bn/bp1jJ/6myXVF4P?=
 =?iso-8859-1?Q?Vj8yUkIuHR8Rd/0hYIFbYbsYROappI/KCw39f5wIKBzd6VXLKaOgW15w25?=
 =?iso-8859-1?Q?M3IA0RRPVV1AdFJ9ALt53kb6OtpCJIBnR40wxEdpy0nvGgyKaGJjXhL1Lc?=
 =?iso-8859-1?Q?plcxHAofEjrlXlf+RLyIEXTDba6J3/YVSEGml/CZeGrtpVTS2bVVO5DN2T?=
 =?iso-8859-1?Q?AQnp5IVkc0UNrQRtqxbeVzrAdvxB7TnY064imcFKgIBkjdJ58zS4A0E0dW?=
 =?iso-8859-1?Q?q6A7YS7ofk8zm6TOuC+7SwByO/9w00QpCdMi/aR4cPEtbSdaafHslLwBvB?=
 =?iso-8859-1?Q?xvSQ2iIdG/JVFgNYVigKsDp9pb3GSZnoevRg2vSy/6lfg+zMRhCp+a1GIk?=
 =?iso-8859-1?Q?pqnJelqa2/MpidWNIMPjSVj2P1HJKcj656EdT8Hty8G434r7k/HRKHQXX8?=
 =?iso-8859-1?Q?KgdC7FYyiYzW5AKSbLrTwAUHCTh0+OGBQajLmWJzkyGxiCmxJN65nJ1Gbs?=
 =?iso-8859-1?Q?WiYj8/MuDcR+TNqd/LQgLMVAzRH+svAYPH+xU2NN2q84kGzrk/HZ/UYEJq?=
 =?iso-8859-1?Q?D28iIGe9b3UUPrNlzmR6U+rALx7jUyqX1yo7Pp0f85eef4ojUBE8/3c1rb?=
 =?iso-8859-1?Q?wNtr9SfhgbOTXnMRJIb/VDwOm1dufW25uYpRZuZ6/MR1pn8yflQKL6huQY?=
 =?iso-8859-1?Q?P8+BCL1OJM0xj/VN3OrrzKhuAjsSVDglfCVmmro25KBpsy7lIyayi9YLF9?=
 =?iso-8859-1?Q?xE35mICpGlplCAk2X9BEL1EaK8uEeEEsizVDNCc7cz0JYJLAG+0VnRSoW7?=
 =?iso-8859-1?Q?V/kHwJwbeMWN+fqKX9pcG5vU7mCueQ9qSBO17ar9W/A+yXv6twmOomDg/Z?=
 =?iso-8859-1?Q?q9HoHB/2SPsVi13ZI7LoLStFA1y//Ozxycdtz6gVM4b668owUi1gq99INt?=
 =?iso-8859-1?Q?MEqr/XSgOaxRp79Ume2gulP/HJCEqZkArWtsNUC16dB7NBkpSDkgNJrkdi?=
 =?iso-8859-1?Q?Ee0W8oQDZ/fYiMk0sdhHd9PnK2syjapmaX/gGBx3pH4RwbE+wCuihmQDFz?=
 =?iso-8859-1?Q?suzvEOB0Ca3xE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44dd4cf1-b5ab-4fca-ad38-08dc381f1a20
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 05:35:41.3114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: me8ocjuSo0YnMHpRV5t7kXo7JQfoNrzHg4S9/WMFPXwR6k7wFZ9rjCUgHj+G/8GaMnE65KbqT+3dwSntSHB8FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5149
Received-SPF: softfail client-ip=2a01:111:f403:2009::601;
 envelope-from=ankita@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

>> diff --git a/include/hw/acpi/acpi-generic-initiator.h b/include/hw/acpi/=
acpi-generic-initiator.h=0A=
>> new file mode 100644=0A=
>> index 0000000000..2f183b029a=0A=
>> --- /dev/null=0A=
>> +++ b/include/hw/acpi/acpi-generic-initiator.h=0A=
>=0A=
>> +typedef struct AcpiGenericInitiatorClass {=0A=
>> +=A0=A0=A0=A0=A0=A0=A0 ObjectClass parent_class;=0A=
>Too indented.=0A=
=0A=
Yes, will fix it.=0A=
=0A=
>> +} AcpiGenericInitiatorClass;=0A=

