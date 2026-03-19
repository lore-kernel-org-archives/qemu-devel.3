Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BACA1075275
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38uf-0003pv-AX; Thu, 19 Mar 2026 04:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w38uc-0003ph-Sw; Thu, 19 Mar 2026 04:39:26 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1w38ua-00026m-Va; Thu, 19 Mar 2026 04:39:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhM6s2TTzh4lJHdd2tmMsC3xeFsE2ABXkUspKKwhWOf0HXhBDqRoRvI5luIGTD7t1U9DTJKktLWauGxtOE5RepLzOfY1hLMmUk+0NGq0CqiWtspPbJ+a6iM9KNICJ/mMRR2qD0kIU5gReDcElmCsVRbv6yo0mAyCEEHGr8MZ+kH0Aik+J5P4dsMU297H4DCiBz1XPdaqpHRKHcFzLkuBorKW7os+52pE9/Gw+w6Kj926YGpI2/nDgkWh1R1zgIfHm7IO7v8PqnMu9UtorZKMFOBlq5rCV8ZWoSiJ/U0BeoOVgFNT8mSuayX4M+LKTArJ0MMWoQxc7d4wjVKArkfbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot5tTKLBLF5LY7KCzpZUZUMsAvrFa6BYIZRJ87aeC2A=;
 b=DYc+KSL027FYPpPxOTFP1VZ03KexbDf14ks2NQIMGX3e69H4TTQ1nFhL7irOtB097ndAsFIH8GhV3/1W8+cKJaIfcvBOvvP0aaPW4TRhKkTAryK/RTnl/QtOApo/7qjex5w3sCcDI4AWUV71pHv1xLX9nGmKyEKUMdvOfn7BYpzlDnOYX4ejc0ZFiZlZdaG2oQUG6tnk3YlTAQSSHw4JbsucLdgBjSOu+T0MqMUFPF7q4FFDSFUadN2t5lM3uCtC9sPCkVLk+WUf1PHEMS1Gc+0AfsLtscJp96WqZClOzkAHMnDhJj+WVMypst8ch/DGg8rSUtJPwwgs96mXws0GQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot5tTKLBLF5LY7KCzpZUZUMsAvrFa6BYIZRJ87aeC2A=;
 b=kuSINyX0taPjJrJ+8CqGBCh2+50KpwGlGKs5V9rpuhRe7ETE2SIyQpgmN+Yl+cwlbiz0/o5VsC9/5Baw4SWgXUnrVfTxecp8jjkEc6fDzomd946xSqTZgpyiRbs56ru/RvtNyKcrrOa9atj5tjnvxJ+hhq501D45Opi0FiUsPCDZ4WHF2GAjlr2S806PqdRg35aezouPkpOahOzsLIVLEimHp1ZvnCbreu55QCwfZhs2xXeIlnGy3HqLXTP8GJh9dcnfznLE2ZFc4gUM6EUIxl+1vJF067b5G45+Qrw3N4SztrInHinnXvosGTMI2m6PHV+vjQ+07aC5GVjkicGOOg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 08:39:19 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 08:39:19 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nathan Chen <nathanc@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Matt Ochs
 <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 7/8] hw/arm/smmuv3-accel: Change OAS property to OasMode
Thread-Topic: [PATCH v4 7/8] hw/arm/smmuv3-accel: Change OAS property to
 OasMode
Thread-Index: AQHctwf8/054wsQePkejAOdeL7oydbW1iaPw
Date: Thu, 19 Mar 2026 08:39:19 +0000
Message-ID: <CH3PR12MB7548BF9B8F46C770B4E15C24AB4FA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
 <20260318184907.4060030-8-nathanc@nvidia.com>
In-Reply-To: <20260318184907.4060030-8-nathanc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB6633:EE_
x-ms-office365-filtering-correlation-id: 0902ca4a-68f4-4802-45ee-08de85930324
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: AdpUYZygsn9yCAJlR2myMEfagX/J4oUkkwxYUlmY/TnD+U2g/eJYRj6ywjQOT+3PLorkAZxPK80AdmhindSnblmRfVVxiM0ju89c/ufMTUftQHgBCUAC2B0IImG0h0FTwGrZKazEPDsz1WCmk1r94vWNw+WrOk0kLhfWphvx7QCHrnrUfTjMFyZ+3kwDfWj7EftodSw4SAwZpi2fXMpatBXZuhZSqP2FkB+pjVOJ3vpOyICDTkMdR09p94ivKx/9ovOhBTJ0Ku8p8CyvDu3IkN4DsUzv9/BQEFtwrMV485P8c2T/wTn6pj9N30qdZe7cH5KyKKKfmrDcBqIm+X//H84dzw3xgiIeIaOoQo4wIg+c10HjNFvGsjcQliNM044WIK46A0TlGaREBxwzAQqf3GDhjmnYK2AsATM2cDL7+syYiSIlApw5W88zsu156ONhhCKh8yPz7u3Ssf1kjCa+Mr9J5hI3pz4D6IJGffZyNLLh9dfaG7DEAq3X2rbEduU1V2LFEOWW8zw0hCCFVvd8qD933U566C9rFzUOkfUiuPD9XRR4xVZ0Kd8QiV55kuwyuxpTXnW6ghCY1R3QN3rjZ2WnnnxHHPvumquVDBAs5bdC9xVJ6/t+/cZdXtTzprQ6J+9uJzaQG2G9NuGMY6oF5qZiMyogCOUvCQcHq3dGq6kyA4JCdKHMPpkzN6/qahId++MZewTUx9dF3lyDd+5OWclQrRBv+FldwOvPmAUK2Po1fxZcPG1yNXnTecguor+wW5+TCEq59naWuXCWZCKfwlVUxZo1qu2Rt1WuCkGCkVU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Hzu4a4tvNK6WSEWxeOz+EziE4utzFkSMr0C3dUES0OUK+EFbNDCJwrTn69?=
 =?iso-8859-1?Q?q88aLl1JQsUobv8HtGGOkFf4WSRgBovLxGwMz4Yvj90oA6rm/Rlt5spkmv?=
 =?iso-8859-1?Q?gyFvF1S1fPVEzhVXpBtL2fIMnKmIWR1vhVz+cuQLzVkaah9eATzF8hZo4c?=
 =?iso-8859-1?Q?e4fxb5Ohugi5bnJ3S9daKzhhzyLQJBsKCwkBX1pAgxcpR21rsKmsAzkKdy?=
 =?iso-8859-1?Q?0wCYD/wnyuoySxa9Bq9hlNaf2Ge48LzoD00RJs5k3pInPPuWCnAzuL9gsL?=
 =?iso-8859-1?Q?oxjHK/r7TmE+O80QcgTCArlvpqAfPTnoht1YGUVOt+f0qytDcqojJjM7d9?=
 =?iso-8859-1?Q?xcakkWbTS5TGTA13ELY2/qclaNQbfUiqEBiL06HDIfKYR7SLwSrFLW25Ux?=
 =?iso-8859-1?Q?jCbRP62BiytLLrSOryHh9hNVk50vpSEsnK34V/h7Tfjephr8KEDOwsmDjv?=
 =?iso-8859-1?Q?8DDyHRUsUDTt999rGRX6hEAVgTc6jur6MmN1i56Dm/zu03Ar9c53TuEs8x?=
 =?iso-8859-1?Q?C/J/Idg3LJsNu9N2Kup8D1Tm2/UG29RUIOz9uJEfp2IWes+0TRY9mOUo5Z?=
 =?iso-8859-1?Q?9Dji7GPTSbDSEpmuC6zlEE3YndtynjPOsmmabvYAkRYbh8PsOfv9ZmUACk?=
 =?iso-8859-1?Q?1Crd+3zkvcB82YnZbJS2Qu+DRnC/mRPpnWVXht4gZR2fik815kLhKz089R?=
 =?iso-8859-1?Q?E606bukaKfV3hAyoBlMgqKfAuJkRUBx01d3ddii5UdAOnRu2206uyEL3cx?=
 =?iso-8859-1?Q?aIdJO1poTZZ7W3HFPqmMvyV3wJCD76hPhQRPOTB7oS4PDn8zQxKkSgc6EI?=
 =?iso-8859-1?Q?ua7G6bdaB8WZI2Zu0xnvYRRtlZmYkCqkloVtQ4yJ4wOLQNZcRJ0alHYe+N?=
 =?iso-8859-1?Q?p9B83N5nLlfrjYl7ghAedo0q2QSpmETnlvdfUrtYq1NzoC2lMezkhh8ZP8?=
 =?iso-8859-1?Q?2ue6JTTFidhduwoSjwQ3EFKzMc8jyXeZHK1v8ocqH42lsDQlPGbQqEESNj?=
 =?iso-8859-1?Q?1tTxxZEaYEkasxO8bMoShvAwqnVWKoE7UAN2kDs05aXjRG2SvlYlra/Mc/?=
 =?iso-8859-1?Q?ED3FwkhaE0b0O5mQw5gdXpl3If9NSafURRcwJhZ631IEZwqoTQWVnX3iXI?=
 =?iso-8859-1?Q?boRzN0ZrXfgVxKTp+tniRMtCo4XQYxbuLMuodm6t1qYjd9XF/bObqQH8YB?=
 =?iso-8859-1?Q?KuPtZ0Pcmz9mhgxLoH+OV+SN8yfx4yEWnv+9G8xts6WpQ/z00V1c+Jyovg?=
 =?iso-8859-1?Q?Dhjmy5ve5YYDdCcFGKebYDZ/7jUtal813NOGkEHo/C1kzxJ4pLhcj7+nXI?=
 =?iso-8859-1?Q?DN+MgyqIK8psA1GZ06/UOhCWGaTavRPye4eYaPhImrx7cxpIjbVVo/psWx?=
 =?iso-8859-1?Q?OE+WlRRxNORRAxdKKdKG5qiWgdFCMvzDbgn1zgQAod0ONkiH5J7XyA1Kw/?=
 =?iso-8859-1?Q?NxOi+z1oO2wcnDjdiGxx5EJO8ftGAS+fHVrjgZEpipwpkpEXTsG0o0lv16?=
 =?iso-8859-1?Q?M77wUgMp1V2+fno5OneEjVQ0LnXg6+CAODXQI8rgIvgdHvoneLY57WOqoJ?=
 =?iso-8859-1?Q?GCx7HMLP9yUMKB1n1cFWlkR5xyVIQBLirvAeLeBg3nmibx3FxW1L5DisOq?=
 =?iso-8859-1?Q?NWgRN/No7LAVvxR46w1it1FDGJSHQy2R5g2jhRcQV6n0LjpgoYVzKdLR0o?=
 =?iso-8859-1?Q?sGBbutKAUYsI4YUwgdQFt7s4nhX5JasFtO2AM2tsy7yp9i07rIetia6iHv?=
 =?iso-8859-1?Q?l/VQs8xyfaRuLOCH1Q4WIYM+jXGx+HFh1+MksDl9ZoYcPlyPbg0rX48t5G?=
 =?iso-8859-1?Q?TqkH/EkaPA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0902ca4a-68f4-4802-45ee-08de85930324
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 08:39:19.2510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6jJ4pLBIZuySg1G67MobU/6/uZGqDqr+RMSECXQsViAlYn+r+8wlb1swQb1b7+fMvTEhZzhF9hgytIdpcniaVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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
> Sent: 18 March 2026 18:49
> To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
> Cc: Eric Auger <eric.auger@redhat.com>; Peter Maydell
> <peter.maydell@linaro.org>; Michael S . Tsirkin <mst@redhat.com>; Igor
> Mammedov <imammedo@redhat.com>; Ani Sinha <anisinha@redhat.com>;
> Shannon Zhao <shannon.zhaosl@gmail.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Daniel P . Berrang=E9 <berrange@redhat.com>; Eric
> Blake <eblake@redhat.com>; Markus Armbruster <armbru@redhat.com>;
> Shameer Kolothum Thodi <skolothumtho@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>
> Subject: [PATCH v4 7/8] hw/arm/smmuv3-accel: Change OAS property to
> OasMode
>=20
> From: Nathan Chen <nathanc@nvidia.com>
>=20
> Change accel SMMUv3 OAS property from uint8_t to OasMode. The
> 'auto' value is not implemented, as this commit is meant to
> set the property to the correct type and avoid breaking JSON/QMP
> when the auto mode is introduced. A future patch will implement
> resolution of 'auto' value to match the host SMMUv3 OAS value.
>=20
> Fixes: a015ac990fd3 ("hw/arm/smmuv3-accel: Add property to specify OAS
> bits")
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Thanks,
Shameer

