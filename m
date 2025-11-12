Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B47CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 11:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ8gG-00032V-9R; Wed, 12 Nov 2025 06:06:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vJ8cL-0001pm-3Y
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 06:02:31 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vJ8cI-0007xt-C5
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 06:02:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0HLAwKcV33J7GQr7BT3d9qYy2RW7cQheDmPHAXZ+ZDrxs+OK6ce8Ge87GabVfkr/WAU7CytN8eCd0FnrHqZ0w3nZRXjenD+Dhfu4tzS3dBfkyNTFR8eZk8Nfp5HUKTwACIMfb7vWtsVWA/TIlgmRvrWSHqeCRI6HcEzgExIx2l6jkclmMmDiOZcNSIIDNPQN+q2zoholDsrwuL3++OP8jIdIApRw2Cb026kgAT10oJ3vsnkiIVHqWxdOUca0HDkblYPuh6GJWee4tpbIbxVfQinTPmr4WisJ5lA+kknj6E/chGY1lClanfHrTBBhfgIzgr2DneHw2vMZO8k9OoiYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbKAFrqKiPxTafWqkXrV6f5lgHSXj+4l9Va6BX9EL6A=;
 b=FX954rqMEbjxX/Frcs6BY5nHAE6paDSkn86SD2DmkB8E0XGjSvL3awJcQGd0t3yWKJL8gHWLoCqhOYuiit6lrTAc2XQW3GuwC1lnrQIfnSj40gNHC/h3dKt1XQyw9Y9rYevV9Bqxts10UJwFMBeQn2TOC5BnQoDUoLJmrk5WK1NSgnMI/zR7c8FnoQN3LW8aiilodh+LOVnAooL7OVhd36gHpZurAIFA2xqml7z3t5G6gd64Y+NudcnQa8fIw/jPWsoWPiDfr0aQs3i3D/ywP/PkcSkcTqR+j7Skw++6Y8z/YjgbqvDdmoxPk9IuxiD5uKb6B2HQAlmUW/0QssixCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbKAFrqKiPxTafWqkXrV6f5lgHSXj+4l9Va6BX9EL6A=;
 b=j20I6KRu6klnF6LA+WfFXNi+5VIx0g5eG2qGhXEU9LHkoTAh3ZwYrjUTe/zfjCMNZ/4lnjiQ0uajRiAivByMijuARks8Ibtg/epYuoMaPZOgAjcToRK5PPBkUnDwyGmt4kwuPh9rKymunDLU6CZ2MbUTIlGxdDuJUdGCXrysTT66fJOQPJumAXA3iK9Ls7ap42+ZN+pxT68DUb97N71aSRtEVtNsYKMDeGx/LiRUmrPSI/vl45GQ0pfY/0hZnIUqd0TFBX50OFjXM8/aipezymK01D2/VeNVAnF7q7BcB+SFgAW8a8k+mE3lO6Cdn1fzKAWgfW8FgdrkRj7opKg0/g==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by DUZPR04MB9746.eurprd04.prod.outlook.com (2603:10a6:10:4b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 11:02:15 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 11:02:13 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional
 testing of iMX8MM emulation
Thread-Topic: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional
 testing of iMX8MM emulation
Thread-Index: AQHcUjR4IKJSoyibD0aCjGOoNfN43rTuH2WAgAB2bjCAAAqRsIAAQSGQ
Date: Wed, 12 Nov 2025 11:02:13 +0000
Message-ID: <AM9PR04MB8487096A518874924AC17DEB87CCA@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
 <20251110112257.184578-14-gaurav.sharma_7@nxp.com>
 <61242433-9D75-47F8-BC44-FD35748F055C@gmail.com>
 <AM9PR04MB8487682307D0672DA3F5345B87CCA@AM9PR04MB8487.eurprd04.prod.outlook.com>
 <AM9PR04MB84874E537D542ED6CD0216F387CCA@AM9PR04MB8487.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB84874E537D542ED6CD0216F387CCA@AM9PR04MB8487.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: shentey@gmail.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|DUZPR04MB9746:EE_
x-ms-office365-filtering-correlation-id: 05188944-90e2-4911-052a-08de21daef30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|19092799006|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ZOEaDO/t3QvGq1+aoQA8AqgCeKsFk8uXrIBE7khDPVbCcpBhEAxVqGv7wyLt?=
 =?us-ascii?Q?NjKfXwtOBNncLzHc9aZlOdOX8Q/7lMVWaix2qXxfwAX/bx4yoYQSWuOJF8iM?=
 =?us-ascii?Q?LWs9lPhAJBuAnlHk5LzHK620Y8+zhXMwLRdYviJW1Du4e9OJfRzv0TEJGrng?=
 =?us-ascii?Q?6QgANaZdppkEHEfLXG1rfZXJUt7r+Z9LSOVDtXFRa6pm37nXUQt8wnSF98Z+?=
 =?us-ascii?Q?UUcoUyIp5jVOQlJ9WJzouVJrGr0TA3fgivEKV0DHR9zWqPBAxkR2YdKSSz5j?=
 =?us-ascii?Q?fVjpYljNZ54Zw8SOv/iSiaeg7G3Fix1mAdak94XT5gH9cCGgLEKCzt87x4s6?=
 =?us-ascii?Q?V99RLqzw+HCIH9NTt0sUoVne9z59iGk2xg/P/W7JTvuE4HIq/o5wKy0DwdIM?=
 =?us-ascii?Q?2K94H60nXvz6qnmH5oMP12MJw+q1LiQGW6M/ke9IbACk6e4XfmPnXwFUtNaZ?=
 =?us-ascii?Q?DRXpySvf2tnIChbW8DzZ9IPhz8kGaqmljTRSdY8oKbhLNAdUEjy7i7mtBwux?=
 =?us-ascii?Q?HPwVpsXsna+4AcQVoJYsYpbt6mqXc1EqOeADxBUC1p9OFJZsXdBZtKPv3SE0?=
 =?us-ascii?Q?U5qZGtP9UUWRpUqH/XNFtiy0ckEa2i/FSEpa7tcNuR3dQvBBSkd5ZSgdZwC7?=
 =?us-ascii?Q?fVoBNu9EAXnhAnUJox7XrFfAvkb9eYUXK5mUW3Cqci9vTNJkJtQqXUjA7WPW?=
 =?us-ascii?Q?dPPCLEOP4XGtyW0Ro0JWEC0c7pHw+ejhdbRG5pvtGbKPVHtquzduSqXlnMkd?=
 =?us-ascii?Q?ifslWe2Ph6WJsmS0P9l4gzBTCFCIfF4KbBlUPBXgjL7pTHtxXSbTofsV0DEn?=
 =?us-ascii?Q?zYkYDyAFPXVwxUUb5Bsnoa5z5NtE5tVktV1tcgFFrsQleltQn3TyBKUtecCb?=
 =?us-ascii?Q?Zg1HZ0giPNUamSHXbpqrxjKo42fBryenkW2pM99oCmRG10cJV+RL05xj07Zg?=
 =?us-ascii?Q?00SrTrLwFi+hquuXtyzdP7A0qpOcmPK7abHyRDE3xefKTVAlVjw+jEDoZLZn?=
 =?us-ascii?Q?MVha5/Ky0MVvd7ORvp/wPJjh97dtMlg9ujnsxBzg0kZEq9vUrIUTJhwpQmOP?=
 =?us-ascii?Q?qLvBDHcAZnFWlp5HLY8KFn5X2dqEKT5oWkRakw9C8EfEo0SDdJhmcmwO5f4L?=
 =?us-ascii?Q?i/L0jIgDkBgE2mEGImt9h+ejjMla3hcy5iq99t38c4xXwdk0m618or+htnNP?=
 =?us-ascii?Q?UoOusjN9czhrTE8rQs2rZnhp/8VnlfxpPNLqqsqlhZDkfAtZSb0EHsxO5ntY?=
 =?us-ascii?Q?rab8wKWeROOOEY14mOgjUCHR+gWgqMlvVOUHHkgzdt+D6dsRF2tXgNwykTow?=
 =?us-ascii?Q?pg6oGv5y8Eap0fu4emTUOrMLON7o1k7fw/kNNIiKpEJWPG/4qlhJvRCWaZfW?=
 =?us-ascii?Q?0ho45QEvgNvifWvjeWAd7LjEhAGgOuB1GG6NPrIGDU6rSGYQFvV+S6B9l3Yc?=
 =?us-ascii?Q?3dA+nIbNQEcrNuZX7ixJioXhx9GxK927c0pyLEpMe6L2bU+jcpFISbKBBkPb?=
 =?us-ascii?Q?E98jnAESnRgiJ+P8aJhsV36C8G66MfT3xiU8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H3O8hzODakDCtKmq+Giq+06/uw6jn1gFsYccSU38qveWhnkW4TqHHr5GNp6K?=
 =?us-ascii?Q?MU1mocbzXG01fJKlSnK1/CmZd/lCzYs1pA5M8Cho/cTRoQn6vcnFYT5bETMF?=
 =?us-ascii?Q?DdECtM1+F3P2+LK6t++8Nfvw7Qm+4GX7PncZDR15plJcUd9gs9lqXbPHWLgd?=
 =?us-ascii?Q?H/PRQ5WaqdpFfbyYa91aSLEtbw53GEZbG9BmVxGyVvJbrVAjjbAXRCOgEXi+?=
 =?us-ascii?Q?mqT7F5AGFh/F1wBMEnu+Df5lK0/+Wul4DODqn5agTW1cw9cB+GsykPxrB4v0?=
 =?us-ascii?Q?WzIKP8isDHUpYmp82XMZjpfcXbdx/Oq7MsyKqA7hzq7BfE7lrk7PMpOXrT+p?=
 =?us-ascii?Q?dWeH6rJ2qMfcN78qa51fXDmNPlmWeTCNgmImXQ+LUIOb8q7tGjRPcoOar+ef?=
 =?us-ascii?Q?DvphPYuyfVNQHhMN0st6JjoJTiht4GGAegu6cbmt+YGXjcnr9LmT+W6xeqZE?=
 =?us-ascii?Q?Y9OsyKMEYfiIQjd/SuCrZxm/hr0yZKLObABCp6vIZAkwRxF9/3kt4t8dB9xc?=
 =?us-ascii?Q?PjNJ2Bef2DsffBRHjOxbOI6RpV2Ps9jbSTPNmijz5L1eEkyx+P/qLD7zm8ix?=
 =?us-ascii?Q?YzW+T9VYlWeUYzMAD80L1lhmgwbQMhDvv6IEqFo2zrmzaT9ndgQGI3HteQOb?=
 =?us-ascii?Q?NNYwXzij8bbj5No6rwb1T6QJWPu1lHb/x0yUPKacVbgTpB/0mUpqm7HY0T6g?=
 =?us-ascii?Q?7ZjzrjFvP+wurJ0CTJYLKfEQ4qNIrLfpAurhqtD+KY4+eq7iaH2eOLQS9ZXU?=
 =?us-ascii?Q?7fXwq6Nugt+FzCEI7jHHFgxvogNZBKNIN/ipnlVCq5WIQzdewHhKYYfJ+cjC?=
 =?us-ascii?Q?BtywyliXlYoVsm3iNHphNoyAC5LtAWQ111sA7afdSoEla+rgxABE443rXJD2?=
 =?us-ascii?Q?dTxjtMO9Yk5oNQmXDVcNlGilKw4TX2+EjVpS6zheIcjWO0q/jBzB6VMmzcTn?=
 =?us-ascii?Q?hFgGQaXTCTH69w/VLyanT/Go+OybrG1wuEaKNf+9aMeFAidvivRXtxKj0HT7?=
 =?us-ascii?Q?OpjZI8RleLRHeX8IQLkuhDKNCtFQ0EzKouOFtmrl4Glg1NDL2ZH7GyfGkwWq?=
 =?us-ascii?Q?H0MDajY1zkKFNhzdVwFORCeLOWh1F/NhwOP506fvEserSI8RylNRYVK+VVJm?=
 =?us-ascii?Q?FGv8s8Mwt9gauSI4IZg+g28g+DyWY4xd4JkbAWwXEWRhGdn5ebNr8nJPALVq?=
 =?us-ascii?Q?2fAkHtiqF5tOLoqNdSq9JXLk2dyGXzvSanB/RY8qoV+4if/DO6PimIxMRtIx?=
 =?us-ascii?Q?hdCtDSmTORT9ZgiQp2cWzdxTFKeZIeKFwjzQdMfmAnJzqeHibwgC39KtvMpR?=
 =?us-ascii?Q?XGkL5m9lCOJsjhfDnRJriTYDJydg4+Ig2aPlxImSN6Gpec6LJjebx5WsvjJ0?=
 =?us-ascii?Q?Lvk/4BRW0iAPIb8jFUCXr6zODqwwJyoSBv/ADAg+8xZnAHwfumXcSRXtJDZ/?=
 =?us-ascii?Q?tlPQ18w+Mm5oolWqux1yNhup1qJwGyNDUTkeWCgiIGN1ioTc+bx7Xeg4IkyA?=
 =?us-ascii?Q?sb2iWBEi1lmV7KdxiRVUIXsrPvaqwLtH8Bjpe69S3aV302jquLiOnB0aReWG?=
 =?us-ascii?Q?SUuL4X5CvjS6h34y8J7I2dfPtTF3wyyyIF+0S8dA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05188944-90e2-4911-052a-08de21daef30
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 11:02:13.2006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xA3sQFa9Ify8dRIGCJv/UpaWkI5hSNbLj9pwX55vkHmYOcXIY3H5tijIN3z1NZpSBq7vFCuyH+xvj/x358yWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9746
Received-SPF: permerror client-ip=2a01:111:f403:c20a::7;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

@'Bernhard Beschow' looks like I was referring to the hex dump of a differe=
nt Debian disk image. I have got the offset for iMX8MM now. I have tested i=
t as well. The console looks good. Now the only question remains:- shall we=
 continue using offset based method to extract dtb or download it from the =
cloud instead?

-----Original Message-----
From: Gaurav Sharma
Sent: 12 November 2025 12:35
To: 'Bernhard Beschow' <shentey@gmail.com>; 'qemu-devel@nongnu.org' <qemu-d=
evel@nongnu.org>
Cc: 'pbonzini@redhat.com' <pbonzini@redhat.com>; 'peter.maydell@linaro.org'=
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional t=
esting of iMX8MM emulation

Sorry The correct xxd dump for dtb offset 0x64F51000:- xxd -s 0x64F51000 -l=
 4 disk.raw
64f51000: e103 16aa                                ....


-----Original Message-----
From: Gaurav Sharma
Sent: 12 November 2025 12:28
To: 'Bernhard Beschow' <shentey@gmail.com>; qemu-devel@nongnu.org
Cc: pbonzini@redhat.com; peter.maydell@linaro.org
Subject: RE: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional t=
esting of iMX8MM emulation

Thank you for reviewing Bernhard. Yes, iMX8MM is very close to iMX8MP that'=
s why I chose to stick to that structure.

" Looks like these lists are sorted alphabetically. Shall we preserve that?=
"

-- yes "tests_aarch64_system_thorough" should be sorted alphabetically pres=
erving the original order - - will modify it in v2 patch

"This DTB offset is the one for the imx8mp-evk, and in fact the console log=
 confirms it. Both machines seem to be so similar that the test passes anyw=
ay"

-- yes, I just found out in the console log. The test was giving a false po=
sitive. Thank you for the heads up!  I have now modified it to fetch the dt=
b from the Debian stable repository. Verified it's working correctly via co=
nsole log

What you need is the offset in the "disk.raw" image that gets extracted fro=
m above file. Open "disk.raw" in a hex editor and search for "imx8mm-evk", =
then determine the offset of the preceeding "d00df00d" DTB magic. That is y=
our offset.

-- do you mean the DTB magic "d00dfeed" instead of "d00df00d"? Also, while =
I was analysing the DTB offset of the mainlined imx8mp functional testing '=
disk.raw' which has debian-12-generic-arm64-20231210-1590. The script menti=
ons the DTB_OFFSET at 0x64F51000. Dumping this offset using xxd[also verifi=
ed it via hex editor]:- # xxd -s 0x51000000 -l 4 disk.raw
51000000: 6cff 0060
It doesn't mention the DTB magic number at this offset. Please let me know =
if I am missing anything here .
Can we choose not to rely on the hardcoded offset and instead download the =
dtb from the Debian stable repository itself? This way the same functional =
test can be used easily for the future imx board porting as well.
Looking forward to your guidance.



-----Original Message-----
From: Bernhard Beschow <shentey@gmail.com>
Sent: 12 November 2025 04:51
To: qemu-devel@nongnu.org; Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: pbonzini@redhat.com; peter.maydell@linaro.org
Subject: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional testi=
ng of iMX8MM emulation

[You don't often get email from shentey@gmail.com. Learn why this is import=
ant at https://aka.ms/LearnAboutSenderIdentification ]

Caution: This is an external email. Please take care when clicking links or=
 opening attachments. When in doubt, report the message using the 'Report t=
his email' button


Am 10. November 2025 11:22:57 UTC schrieb Gaurav Sharma <gaurav.sharma_7@nx=
p.com>:
>Added script that would validate the iMX8MM emulation by checking the
>linux console log. If it succeeds, it will return:-
>
>ok 1 test_imx8mm_evk.Imx8mmEvkMachine.test_aarch64_imx8mm_evk_usdhc
>
>Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>

>Hi Gaurav!

>Nice to see another imx8 machine being contributed! I'm impressed how clos=
e you stick to the imx8mp, both in terms of structuring this series as well=
 as the code.

>I've built your series and ran the functional test. Comments below.




--

>---
> tests/functional/aarch64/meson.build        |  2 +
> tests/functional/aarch64/test_imx8mm_evk.py | 67 +++++++++++++++++++++
> 2 files changed, 69 insertions(+)
> create mode 100755 tests/functional/aarch64/test_imx8mm_evk.py
>
>diff --git a/tests/functional/aarch64/meson.build
>b/tests/functional/aarch64/meson.build
>index 5ad52f93e1..31ecedbf6f 100644
>--- a/tests/functional/aarch64/meson.build
>+++ b/tests/functional/aarch64/meson.build
>@@ -5,6 +5,7 @@ test_aarch64_timeouts =3D {
>   'aspeed_ast2700fc' : 600,
>   'device_passthrough' : 720,
>   'imx8mp_evk' : 240,
>+  'imx8mm_evk' : 240,
>   'raspi4' : 480,
>   'reverse_debug' : 180,
>   'rme_virt' : 1200,
>@@ -28,6 +29,7 @@ tests_aarch64_system_thorough =3D [
>   'device_passthrough',
>   'hotplug_pci',
>   'imx8mp_evk',
>+  'imx8mm_evk',

Looks like these lists are sorted alphabetically. Shall we preserve that?

>   'kvm',
>   'multiprocess',
>   'raspi3',
>diff --git a/tests/functional/aarch64/test_imx8mm_evk.py
>b/tests/functional/aarch64/test_imx8mm_evk.py
>new file mode 100755
>index 0000000000..d5eb43afc6
>--- /dev/null
>+++ b/tests/functional/aarch64/test_imx8mm_evk.py
>@@ -0,0 +1,67 @@
>+#!/usr/bin/env python3
>+#
>+# Functional test that boots a Linux kernel and checks the console # #
>+SPDX-License-Identifier: GPL-2.0-or-later
>+
>+from qemu_test import LinuxKernelTest, Asset
>+
>+class Imx8mmEvkMachine(LinuxKernelTest):
>+
>+    ASSET_IMAGE =3D Asset(
>+        ('https://cloud.debian.org/images/cloud/bookworm/20231210-1590/'
>+         'debian-12-generic-arm64-20231210-1590.tar.xz'),
>+
>+ '7ebf1577b32d5af6204df74b54ca2e4675de9b5a9fa14f3ff70b88eeb7b3b359')
>+
>+    KERNEL_OFFSET =3D 0x51000000
>+    KERNEL_SIZE =3D 32622528
>+    INITRD_OFFSET =3D 0x76000000
>+    INITRD_SIZE =3D 30987766
>+    DTB_OFFSET =3D 0x64F51000

This DTB offset is the one for the imx8mp-evk, and in fact the console log =
confirms it. Both machines seem to be so similar that the test passes anywa=
y.

What you need is the offset in the "disk.raw" image that gets extracted fro=
m above file. Open "disk.raw" in a hex editor and search for "imx8mm-evk", =
then determine the offset of the preceeding "d00df00d" DTB magic. That is y=
our offset.

Best regards,
Bernhard

>+    DTB_SIZE =3D 45 * 1024
>+
>+    def extract(self, in_path, out_path, offset, size):
>+        try:
>+            with open(in_path, "rb") as source:
>+                source.seek(offset)
>+                data =3D source.read(size)
>+            with open(out_path, "wb") as target:
>+                target.write(data)
>+        except (IOError, ValueError) as e:
>+            self.log.error(f"Failed to extract {out_path}: {e}")
>+            raise
>+
>+    def setUp(self):
>+        super().setUp()
>+
>+        self.image_path =3D self.scratch_file("disk.raw")
>+        self.kernel_path =3D self.scratch_file("linux")
>+        self.initrd_path =3D self.scratch_file("initrd.zstd")
>+        self.dtb_path =3D self.scratch_file("imx8mm-evk.dtb")
>+
>+        self.archive_extract(self.ASSET_IMAGE)
>+        self.extract(self.image_path, self.kernel_path,
>+                     self.KERNEL_OFFSET, self.KERNEL_SIZE)
>+        self.extract(self.image_path, self.initrd_path,
>+                     self.INITRD_OFFSET, self.INITRD_SIZE)
>+        self.extract(self.image_path, self.dtb_path,
>+                     self.DTB_OFFSET, self.DTB_SIZE)
>+
>+    def test_aarch64_imx8mm_evk_usdhc(self):
>+        self.require_accelerator("tcg")
>+        self.set_machine('imx8mm-evk')
>+        self.vm.set_console(console_index=3D1)
>+        self.vm.add_args('-m', '2G',
>+                         '-smp', '4',
>+                         '-kernel', self.kernel_path,
>+                         '-initrd', self.initrd_path,
>+                         '-dtb', self.dtb_path,
>+                         '-append', 'root=3D/dev/mmcblk2p1',
>+                         '-drive', f'file=3D{self.image_path},if=3Dsd,bus=
=3D2,'
>+
>+ 'format=3Draw,id=3Dmmcblk2,snapshot=3Don')
>+
>+        self.vm.launch()
>+        self.wait_for_console_pattern('Welcome to ')
>+
>+if __name__ =3D=3D '__main__':
>+    LinuxKernelTest.main()

