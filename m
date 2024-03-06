Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188F1C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 11:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhpho-0003HV-2r; Wed, 06 Mar 2024 06:45:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <poffer@nvidia.com>) id 1rhphl-0003Gq-DR
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 06:45:01 -0500
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:200a::600]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <poffer@nvidia.com>) id 1rhphj-0005m2-1l
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 06:45:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V12BT/Ojg7KyWX8EFTULLICLdrhaafPuY9d+K+xkrfvJhJtw9HsTeo0TlCibz522BfHFJ5Ykn7u7t9ClTkLbPs5u4uiqjy5CgMGOryegl952KBSfvUJkZKUBk/niyci7tvexRSwXTVj2iu4p/HsYtRhCqSgy/nXewfxnX0XmK+v/dHahQUryi/I8/yyEDoOM0HZ1xym/qkn5xLrMUsNTy72GeN3M/YwfjHTsL3SzgBpKbNRLiKK1SLVIi7/xXs7qqbMRJ+CaGm8/7Z7YTxVj2z7b0qmkEDMZPBtakka7UQmEn7HNvN/HpMzSIaZF1JHnv2+ksZMduC8mshF+JM4tiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDxsfp6kYR/gn1eoVHv+/sPxhxOHtK+fJyHar4hg+U4=;
 b=M5sfvsSRw5jwxoI+HXdNTm5bCyfCA+3JMfTfiP77P20fMbveSwBR0QlgtPfqQNvT/Oob02NFryQJlT8t18RJALTOHkTxuQsOqHUqUW2npVgMKpPzjcqjDBv4ECkqmfqdiVsqTtNwApCGKK3WBTsKY9dr6QRgXu/cdJZVDreISiXwUkOWwA69fcfmfKWDNj4n6YT/k5gu7F9bp3DppjwHlk1UfuNSYX5rCQB4IIoi2IDcZjUb4/DW7LSyE7sbH87OuysGQR/GedUlM7tqukhzPIpIkUn8KujRYx3ZD9d0JixKbdBNaztyBTqw54BDcLUxQvTKt76lTZnVpj2MlvhhGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDxsfp6kYR/gn1eoVHv+/sPxhxOHtK+fJyHar4hg+U4=;
 b=gVOKemlHQjl+PBMapylRAuyhOtpwdxoh2odO3wEPRHGdBs0MzwsNNF/d3SluO8h8z1nxSE2oQUvJrXy0EuY4Y4atJXB8vPRAM28KBPw71Pgt9mFH1xwsyAuWg+bby8RDnSn8GGG6PcqMQpBLB7oGOWxM0mPT/1LA37Von/maw9LT5NEx2sVkyKDoskD/1mCJevWZaoKQDl8oCFJFBrdvgsqW1bF+KnqPiDjxpJ2eTQdB2g+YNthZtfhxgdLtJoVkwpM17s9yyacutg4RqbVo0F6DoGSFHtbiWxfemfLOsfYH4PFWaFtVJhujJKXbWz66eY4cN4rsbhK/Mle/55PelA==
Received: from MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 11:44:53 +0000
Received: from MW4PR12MB6997.namprd12.prod.outlook.com
 ([fe80::1afb:ba76:620e:60c4]) by MW4PR12MB6997.namprd12.prod.outlook.com
 ([fe80::1afb:ba76:620e:60c4%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 11:44:53 +0000
From: Paz Offer <poffer@nvidia.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: How do I enumerate devices connected to i2c busses on running QEMU?
Thread-Topic: How do I enumerate devices connected to i2c busses on running
 QEMU?
Thread-Index: AQHab7qpsOlck+0Nc0u38zU+bmloJQ==
Date: Wed, 6 Mar 2024 11:44:53 +0000
Message-ID: <MW4PR12MB699791410D2714B76FE8E863A0212@MW4PR12MB6997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6997:EE_|CH0PR12MB8532:EE_
x-ms-office365-filtering-correlation-id: a172f1d1-4fc2-4fb7-4955-08dc3dd2d6bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ptxWGyNrDAMorakICPwYoQxN3DpnLh44fmTXrN6mc1sukdjFHuouK/0OO3MZODiDEiOLFxlT+AhQjjN7JPWVcBSgD0x9Pi0hoRNXEVpgHCkyjC2Bpk+jvsjEhyqxrN/Pb/Ifg53xdomZfJJWllNLAGPAooJH4Xy+QloW2KcqaDGP4bNFAsyzuwnb+GqJDwKjD71f6k/+w4xUMReCb1kB8pNpJddmd2mz2ZOA5+CCGS0LiB8r3evtUV6WR6EY0db5sUET+eKVtikiIv2m2bxjxdKGc6idwFqIZGKpsrZS6am9eO9ZgmncNXMKlCMGPI9K5q9P++iLssKUTNZl/GYwpM17LEZ49WshhD1jRnEiwsWWqqBxn/euEtVEFlDSf2gkj68Nl8lF1MLfLV5l+oom7LEg5k7sJnDwkHEIG3gDZBgsIy7iaoRd8Vr9F58WT+ZDyCUuU5kAcbqt7xjKSghKNCCIWib3GiGRp3eYxoXx104xv33dJDybHkY1Tbe8HC8FQBlkL1XgmoxA/g7KgCAsp8h172X/o4g/+THOO3TvWiy4fZ9qEGcxqWMQpW/L+izDgb2+YuScwflpz+QT/E2kp4hX2D7ZHFEpVuyIlqKTvJsIBi5M48KAJLjJlBPK4mshwISQ2yXDC0W4+xEZfL/AkNGqYrVrLLsqYKCWumx+na53LLFG+Ii3G7x8QBXqHhySyHjrlKEZpNS0ts/C1hYiuWuhmdSFhdbHh+tSFGM+4n8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AQ6Zpole1kBxRXL2SZ4Qu1+CpGSuS5K4B34xY+j76s/tLpSp0thibF/4MF?=
 =?iso-8859-1?Q?ACwibzN6vU2oXAgBxPwHoP9cxqV3xUw3l3iA82lcoatTyxAauyAUSyZYeg?=
 =?iso-8859-1?Q?LtT7yce5QKozzgBFtVqQ63CVVJCqRJu0bs4xm1kI/BiDtGJREYmljZ/wPi?=
 =?iso-8859-1?Q?i6lnSXubSEoqsbMesZXLCTO0h3aqmmh/vSzTzhY28mkn2K8lKV/Bw/UFyQ?=
 =?iso-8859-1?Q?sWQhzvbnlVCs20Rpw6e/WcwZcsIJD6rkSF4gvkvcG8DLMlORYYjeeMDkec?=
 =?iso-8859-1?Q?oZJXWH1iuSRV56xcCXbGCSQSZXcMW9j66If3bV5jxqiNPKJCTlNT4e6Qis?=
 =?iso-8859-1?Q?DzFlovUYgg+Z7NkgNuEHEwHajA6l5JJ5DoghES5HoDhlGqJEI0I2hvAikf?=
 =?iso-8859-1?Q?BxDx5OEf9Ek/H4PTDNww3vNXQHL0maT/5Ff14m33W4nfVmdJY4gnYaQN+M?=
 =?iso-8859-1?Q?FLBNKAstNNOTtwyPVWia4f5yEhy439fp56XD4HkWCWgX+d3tmKd01LaxKm?=
 =?iso-8859-1?Q?ZV53+48yXy4YuZVE4MTFsVuqbXJf842q4JXXRuId4RSw3zrjYILB1lZT6W?=
 =?iso-8859-1?Q?ArdfhpZUskO2WW0hCZ8hfeH1v39SM/Jufv45niECqVbzKpEtm3zxc9b10N?=
 =?iso-8859-1?Q?GwIhQEPUsWn/2WG8Jcn+DVO/6PXNHYU0oiX8kRY3QCuWMTj3eWK3hnAVpV?=
 =?iso-8859-1?Q?4XxF0BLaTP17mAFpWr6SUg3qgzQQS27EEbJMi4H+50OQSL6pfB5nwLEhBU?=
 =?iso-8859-1?Q?/wrrWXD8JeF6rRzHfRjUzPASuCy2W0zVp23QTI/FDYRpN+KfhS/DF6jjWP?=
 =?iso-8859-1?Q?aCd6Awpj2QeJAPBoonfWRPB3BpF4l3BhRJofNRUb72qtsvuQMiE06HYPHs?=
 =?iso-8859-1?Q?1FfVF9UzcSvXGnzta1E65Q5KtSmSEsgpqf8o7JXmYy3MxV8iAkVo8OK51b?=
 =?iso-8859-1?Q?8tuS36J1XFGB6QxjMvn7ddQimQcVBO4fTfn4StraPDk/hSPy4bcslRUXic?=
 =?iso-8859-1?Q?WgcjhmtL7fi0VrRqEK80JO6MvtnvfX5c26Gu7Q1+9JdqP/ifDt8V/RaPwt?=
 =?iso-8859-1?Q?tXotlmF+tBzu6j3BaxzIsaJSugGsxEx0zQaTI88FbTicwP+Dkrr83PYZec?=
 =?iso-8859-1?Q?B760CoL62mnfJiFlA+Sa3UM0Y3/bRSf/P6Uzls8g9tocYtUj2oXYGcNZwL?=
 =?iso-8859-1?Q?4P3GgGzV5pNVNHyMsztcUM/PEHb5KNj/PR5c8orUmnVncCi4pkLqqbELwC?=
 =?iso-8859-1?Q?R1lSXpJFlpY6v8J0JegwEf9e63w3BYCmSwV9EEPATMOYwRm1QM6n8BkTgB?=
 =?iso-8859-1?Q?8QTp6LXYsyEEc/ewMI5XynkfHqupOunocYXcNYWNL/nyb56oUT9vJDvagI?=
 =?iso-8859-1?Q?O179yCXv1Z4Vse9Db48nmqhC8PaFHYRlESeeyWtK25/gAjWadXUo8pfgY3?=
 =?iso-8859-1?Q?KEGmeOta6soia0PRPrsmKTdPnBvf9tlijHWyFAfERvJ2e0I9ii3cp80GkS?=
 =?iso-8859-1?Q?RJ75II+J2mw4Lm+/KlOmtX1GDZ4C7H9kFfGCnZvQ0SKpUCsfs5uVFZDa6g?=
 =?iso-8859-1?Q?4UWifb9U2VhRDoDvotNVbnwaHH5c/fM60wwezXMlZnfI3INu0paqT+7+Uv?=
 =?iso-8859-1?Q?2TY9qkJgLbw5U=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW4PR12MB699791410D2714B76FE8E863A0212MW4PR12MB6997namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a172f1d1-4fc2-4fb7-4955-08dc3dd2d6bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 11:44:53.4952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kM2RBEokqFhmDYqh/pQKSsmHZT+LuCtsirjk/AuyaAf0VOIvugQCjq/XeHPqxIlVrLNCKiJOcL2zkP0tBKH9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532
Received-SPF: softfail client-ip=2a01:111:f403:200a::600;
 envelope-from=poffer@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--_000_MW4PR12MB699791410D2714B76FE8E863A0212MW4PR12MB6997namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I want to enumerate all devices connected to i2c busses in running QEMU hos=
ting Linux.
I understand I need to use 'qom-list' and 'qom-get' in monitor mode, but I =
did not find documentation on how to use them for specific information.

Thanks for any tip,
Paz

--_000_MW4PR12MB699791410D2714B76FE8E863A0212MW4PR12MB6997namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I want to enumerate all devices connected to i2c busses in running QEMU hos=
ting Linux.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I understand I need to use '<span style=3D"font-family: &quot;Courier New&q=
uot;, monospace;">qom-list</span>' and
<span style=3D"font-family: &quot;Courier New&quot;, monospace;">'qom-get</=
span>' in monitor mode, but I did not find documentation on how to use them=
 for specific information.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks for any tip,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Paz</div>
</body>
</html>

--_000_MW4PR12MB699791410D2714B76FE8E863A0212MW4PR12MB6997namp_--

