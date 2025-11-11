Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECFECCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 06:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIhek-0006vG-53; Tue, 11 Nov 2025 01:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vIheh-0006tC-K3
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 01:15:03 -0500
Received: from mail-norwayeastazon11013015.outbound.protection.outlook.com
 ([40.107.159.15] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vIhef-0000iH-4w
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 01:15:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmEqKF6PDGdDw0i/jOuFeHzIffnfbzSrX5euBSptMimDmPg8cpEmtPBjsO/GuJnN+6lCtXbV9Zzs0FSS4+RsTvtK7f9NKCGWD9yZ46chMeu/F+WOT79jp1wFcVMNhVE99ccFdUXLGR0y3vcN84TfNvDNopB5Ciw1MkaMtRnEOF2Bbp+jOBl6IcQePjukoKekxfoNqzxe2U7I4nN9jBCfH2Alhn55XVOvFuo1Gxwgp/tsk5L6s+LHVtkcxlfo5fE8+ftwdE4cQZqMwBSMVkcoQFQbzJ3JQmCSB20AlrjJz/a3ig+F414KjygqwSOx1hH+w9W/exV0T8QQIa8jMJM89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BRrLHN46AC6t7B6eb3DRCoBYEDUCJ41I6RNanAfyfg=;
 b=W1UReFN2z4QXg0jetuWBN0iEOmRu1/mjqVZd5JR8njQsKtYnFCpdIJRPaQTgPw4qXopxohi5zjvgOnR3QzXY7XEtmKFCvO2DkCvzaDKKwjMZ3/J5pYlIPVMJHndDRBUMOJUqi5EhhsmnBZtOF6N/BtLAn8SMDrPezY450QHwaUZPgoIUGcVn/gwsBKvmrdI09f5iQdW+ayBMP/cng5O4KLkGD6foZhhDaZukST/j1KRQfTlKNkE08h59GkF56mAACAa4K2rV4lB4ankvMCnOh9v+UBM5lIwzZnWT3zeq1xIX4XRFeaAt7pbGcNRkV8BAixenA6yJkr/lXJyLjAlxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BRrLHN46AC6t7B6eb3DRCoBYEDUCJ41I6RNanAfyfg=;
 b=TVT00VGOwyn0b/Y9nDdT9WQ2xYjz9WbQoOlUOJxh18+V/5aZ93mwMdY9EXQPKV048xPHV8ZsC4BVhUN+0ELn6yu4TsI995AmZ5ilYgVxO8kQw6AJqGKSGYoDEQe+3ZFpXTGbjFOIIccyfhJFqU38hyrHjwg5ySE0X8sb+J2jDiO+tdZjXUrAhhAo/OUwpkpKOwWF/A4828480osEcyR315nOR6J/zrhjd63/pKg61fksWHiY9hMfhntDNgL7WODjuqZ5V2arfuir8oAjRtTqqfD9fRMnTCAl8bcIyth2W1hA3nEhca+3KlUHI9RACgMj+p8/VNIueNP7bb4VUO8jMQ==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by PA4PR04MB7712.eurprd04.prod.outlook.com (2603:10a6:102:ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 06:09:57 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 06:09:55 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCH 04/13] hw/arm/fsl-imx8mm: Adding support for
 USDHC storage controllers
Thread-Topic: [EXT] Re: [PATCH 04/13] hw/arm/fsl-imx8mm: Adding support for
 USDHC storage controllers
Thread-Index: AQHcUjRzryNtOF8Nk0i6sZyz7dMJS7TsAmuAgAD6sjA=
Date: Tue, 11 Nov 2025 06:09:55 +0000
Message-ID: <AM9PR04MB8487E41CDCB73BF6B6C84B2A87CFA@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
 <20251110112257.184578-5-gaurav.sharma_7@nxp.com>
 <5779078a-925b-4998-9534-5881e72e7125@linaro.org>
In-Reply-To: <5779078a-925b-4998-9534-5881e72e7125@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|PA4PR04MB7712:EE_
x-ms-office365-filtering-correlation-id: bb3158b4-cf23-44df-0581-08de20e8efb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ytuF2tC2fh5jUzdX9hIXfP9pwvKQ3TuKVcsDJCfHjQekafp//eYaU4M7mE?=
 =?iso-8859-1?Q?kd4/74xl/bTz2WM0OMb3M/0rPofCURpLrOWcpfizBsHmRbn6KoyfKmrN8M?=
 =?iso-8859-1?Q?a7tGFtiZwKp5MlQsCR7/ajr0Qn7l1GkGFfS7vI5ewn9fvCVaSCbsUn2lCB?=
 =?iso-8859-1?Q?df3s3M5FV9aUaIrwhkd+zrs/ANZhj2RB7lXckQ1UjK1uc+x9wYUM0weuoU?=
 =?iso-8859-1?Q?m4TmF0jXZQvS62h7M/qNV4ab5hXRFfTLBFFCJP64Ys8QeJYyD8L4ylfd9j?=
 =?iso-8859-1?Q?Z3/hrqY+F6732iE4WPDRtW4wwxkpDDqqlbZU1iSexvVL4Y1U4/02jbtqXC?=
 =?iso-8859-1?Q?IFn1odYFsbGNmOyIF1QXcUsnnlh0iD10DoDez00k/3PNwNl/qm3f+SNGzv?=
 =?iso-8859-1?Q?A05349XbuBteqqCz7gRORqnekEHIADvsNRcV0Vq9zPWLZ2luifCRdSRuJJ?=
 =?iso-8859-1?Q?kstpVtLaqX4AAGDzWHSEvzM1BgZbeXGOHxJC6OhpFtqwHr5EBmzvpbdraz?=
 =?iso-8859-1?Q?4TGzHquSmDzDrod35ah/rBMG2UGJ7Eh8tMt9GcJ/D6ikF4Z52EgY4fhlxb?=
 =?iso-8859-1?Q?iZaCazzDLG30O4LlcFsutYKZ+yiwcwNoQtEViu0PcYALmJzlV31iwVIJ7t?=
 =?iso-8859-1?Q?806fV8yoFhBwLIc4YJJX7rNJpLweLA6xRz9Xqn38LgTNEVmyU/gcFqS9ZW?=
 =?iso-8859-1?Q?mxYi7xkiveqLHBdBSteh3ajf2x9CDS8vJksC8Sb5O+AUd337GbkqQqTO9u?=
 =?iso-8859-1?Q?V5DQ5hEaofH8MhXVDuoeXNduVN5fUL3vJMWNDmkVF5krdW5C57EIg7RDAt?=
 =?iso-8859-1?Q?QKB0iYSKCIwi+hV9Z9lSskHxOr4/YZW83P3/62fjf6wqn+uqj7pBi9H+b3?=
 =?iso-8859-1?Q?NUA2bpFr6az09+1pyTiugUOxJiibqOIVjeZFytnUCfcNYsWByZa52zPVNJ?=
 =?iso-8859-1?Q?XJWYysz0ririMLSYh1tp9L+IwIGy437aEm6J25poGG+Gbj4wJbIbP8I/mP?=
 =?iso-8859-1?Q?3MnSMgr6NH1z9yGna6PBd8R+ovCYM6GlsZ6IJyw9fAuz1/jwTLYzozjSJJ?=
 =?iso-8859-1?Q?yE+aDDNg/kbl6O9hfSffRaT/7vju99SZliMiH3xjj2GMX2JXeRT5DcWa25?=
 =?iso-8859-1?Q?14kRfXUky8vrCTBX6m+LGEe5is4otBWx7F0AtW3f332Wd4Nnzv3G28k2IT?=
 =?iso-8859-1?Q?uV0Gg4H1zmw0WjHhk3f24841v9X4WkwTzoB0XsbC1n09CKtv4N1GS/akpr?=
 =?iso-8859-1?Q?drRU5gvWAj68FjKiwUYIyK3VX8zmd6XZDm11KJUPW3PaBEbjBgmVe7aTKK?=
 =?iso-8859-1?Q?n1VBfinZJ0fVuhqmzG4D0XS4Hn40uikJCKl9SUn1uaRrMVvHIl2WDM9IEt?=
 =?iso-8859-1?Q?hILz6zOIj8I4bBisW8fyHk3IL4N0hM4odfWzAA7m06N1tGjyjdBnarfqoz?=
 =?iso-8859-1?Q?/lmOzk9rq4T0YEBEhIwd09x7jD57yKBmmcXxhkwxg7M5vkSfSS/dzOWaiB?=
 =?iso-8859-1?Q?5zGd2M+VajzBrb0zrO9h61k0tmGDclu2dAZgRueGcCJhcKo5WGbohOjbIb?=
 =?iso-8859-1?Q?5w5ZgJMaXhi64fyKCMU5Qw9woMwg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rEvdOVNnioDNWgRk7Z6a50iE1BUYtnlGc0t6amx+Y/wFEeTAz/7Tp2v3w3?=
 =?iso-8859-1?Q?jX9TSPeNgzG1OcB5mKYcED0WG85tuQMMcgVi9Q6TI2A3vPe3hlh/jDB89Y?=
 =?iso-8859-1?Q?3Hs1GBH5iIdO3NNdRnzy9BHIwa58G6kMqmtp5OEDLIYRvauQzFfn0glyBm?=
 =?iso-8859-1?Q?cq9XhXrBsxaTut7vq4sC+UIr7MWxpTYtWt+/yrecsPhWwX7BW/ZrdlZD5J?=
 =?iso-8859-1?Q?xnvVorXgjUJfVj2slc3JoDgDVw4EQ0rP469CY+pAaYE7TGoRZ0sXNWbOa4?=
 =?iso-8859-1?Q?KmSleAKuJuxnvm8MmnpQeBZXs7CVvjalMcWpoq6KJ5MbCwRvglGY5kn+vH?=
 =?iso-8859-1?Q?h/F6UkmCC9uy4yGrNPyaPnItmlu16sh6H1BC+fvf+Z0c7w9xxIGxKtce7V?=
 =?iso-8859-1?Q?j7TyyhwjCPp/viXwR+2fuj/Zd+nnGqCpOMWfB4k+anI/RbWLFVs+xljH1/?=
 =?iso-8859-1?Q?p/NXaLO1zkyu1+vLR4xUmzrJWn2PnNbvqBI+sr7qH+7mtV552zN5NRJ23F?=
 =?iso-8859-1?Q?HrAdYMyItCrAsJ7SrxcqZsggMze26+UheUtTR2u7sJ0UH38+JJqbxMZmR3?=
 =?iso-8859-1?Q?htFWpB5Mi11G204PUsZMrtOa8bsFKYs6Ri+qc/inKNwhG4Zx4H9lYOhURA?=
 =?iso-8859-1?Q?fsP63k4evcL3K6BtiI0L4KQERKDZ9jcvbidj/BayDMXjtAsw6DnPHO4j0/?=
 =?iso-8859-1?Q?XK25FOFCLtn2szvUcgFKRkxat9o/QJClNvxUJtg+bc1feqvT9GJiWQWs96?=
 =?iso-8859-1?Q?YwU601d6qLXDPAITS9BsgfTP+fa6xNTuByRGEGs+iWIQWxWFEgUQF5GNzr?=
 =?iso-8859-1?Q?37lyY8CFC3RlNfKrYI4T/JEnJXy3Q3y3g/rFik4JD8CdgFE7smdqTCCRgX?=
 =?iso-8859-1?Q?CCL5S/5JG+ABdgd7YDkm8ZeJLzkCQCWkoM8YhlcYu4EGAuQUy9j55MBCDv?=
 =?iso-8859-1?Q?kpk+anPVOMBWVKGRs/Mruwt2ipcWRvn00cefWstr6kF5HMQq+1OUAKJJAk?=
 =?iso-8859-1?Q?LM0a+1GwkVdKEhT8ac+CUdhfEW5jlBACtLDZ4/V+uTNOzzX5e9u8yxJ+b/?=
 =?iso-8859-1?Q?uXl35P19vvvuGHnzvWAmVpbgcxSxy3e/leLoPskAodFWjB8T4RJ4m2cJ4D?=
 =?iso-8859-1?Q?zwGbdEl+OMjpvwmOTbqo2uM8r8Tfb3RgLoTS6rrzia/7tiR5Ras8ROulJ0?=
 =?iso-8859-1?Q?lPRKbsWLV/nt3Yig1GCo3LBkawRjflgjILvcbrDRQ6sNU1zhw1tC7h5M0Q?=
 =?iso-8859-1?Q?ku7P2fKaQ0dX91vw/rn18e6C81T692Ub6d/PrPvFGprLnhZFYQEX+m9onp?=
 =?iso-8859-1?Q?rF11muHgpx+vZrk5qn9t2Lnws52pObM/ZHNK0CtRIIDqP4oRDXYzF4Tmf6?=
 =?iso-8859-1?Q?78CoLwsRZk4XId4oAcR54ieBN0gD5UcGlKqdaSUl29q1DFmRXFCrPO/Mht?=
 =?iso-8859-1?Q?EwH/UmIe7jLMxq+ZUfs9YkowCzIAgAmGJzd1c1BrGJoZRhlNpLS1Bxl+f7?=
 =?iso-8859-1?Q?WpNY1dtZb5ofxutfT4NbQ3OLO+7jmtrJcZni9GuxYhW6wb7ioqpQvbnG6c?=
 =?iso-8859-1?Q?T4sQ+SiimK0zfH1qhAAfrWUDXQb3JgQW/TkKuzYtyWGloaIcEfSvNRvxL7?=
 =?iso-8859-1?Q?ygRirVeNTWHEMEC/3thyB/UexCzDsVO5fF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3158b4-cf23-44df-0581-08de20e8efb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 06:09:55.8939 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptppaQ9p0tpv1IHzkUPVfTeUANMAtcEJnYrFinc8+8bDmOBmtoFpaTo7+i9W5T3TeP92AU1hrEoGnu48htEK+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7712
Received-SPF: pass client-ip=40.107.159.15;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thanks Philippe for reviewing and catching this. Yes, it should be a 'stati=
c const' since we do not expect this struct to be modified. My bad. This pa=
ttern needs to be fixed in multiple patches. I will wait for additional rev=
iew comments on the patch series before rolling out a v2. v2 will also have=
 changes to remove iMX8MM CSI and DSI dtb nodes since they are unimplemente=
d.=20

-----Original Message-----
From: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=20
Sent: 10 November 2025 20:35
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>; qemu-devel@nongnu.org
Cc: pbonzini@redhat.com; peter.maydell@linaro.org
Subject: [EXT] Re: [PATCH 04/13] hw/arm/fsl-imx8mm: Adding support for USDH=
C storage controllers

[You don't often get email from philmd@linaro.org. Learn why this is import=
ant at https://aka.ms/LearnAboutSenderIdentification ]

Caution: This is an external email. Please take care when clicking links or=
 opening attachments. When in doubt, report the message using the 'Report t=
his email' button


On 10/11/25 12:22, Gaurav Sharma wrote:
> It enables emulation of SD/MMC cards through a virtual SDHCI interface=20
> The emulated SDHCI controller allows guest OS to use emulated storage=20
> as a standard block device.
> This will allow running the images such as those generated by=20
> Buildroot.
>
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> ---
>   docs/system/arm/imx8mm-evk.rst |  1 +
>   hw/arm/Kconfig                 |  1 +
>   hw/arm/fsl-imx8mm.c            | 25 +++++++++++++++++++++++++
>   hw/arm/imx8mm-evk.c            | 17 +++++++++++++++++
>   include/hw/arm/fsl-imx8mm.h    |  7 +++++++
>   5 files changed, 51 insertions(+)


> @@ -342,6 +346,26 @@ static void fsl_imx8mm_realize(DeviceState *dev, Err=
or **errp)
>                              qdev_get_gpio_in(gicdev, serial_table[i].irq=
));
>       }
>
> +    /* USDHCs */
> +    for (i =3D 0; i < FSL_IMX8MM_NUM_USDHCS; i++) {

static const?

> +        struct {
> +            hwaddr addr;
> +            unsigned int irq;
> +        } usdhc_table[FSL_IMX8MM_NUM_USDHCS] =3D {
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_USDHC1].addr, FSL_IMX8MM_USDH=
C1_IRQ },
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_USDHC2].addr, FSL_IMX8MM_USDH=
C2_IRQ },
> +            { fsl_imx8mm_memmap[FSL_IMX8MM_USDHC3].addr, FSL_IMX8MM_USDH=
C3_IRQ },
> +        };
> +
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), errp)) {
> +            return;
> +        }
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0, usdhc_table[i].=
addr);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
> +                           qdev_get_gpio_in(gicdev, usdhc_table[i].irq))=
;
> +    }

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>


