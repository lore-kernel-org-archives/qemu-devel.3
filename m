Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E171FC54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 16:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp9MW-0002Gh-6J; Tue, 26 Mar 2024 12:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <poffer@nvidia.com>) id 1rp9MT-0002GU-HL
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:09:18 -0400
Received: from mail-bn8nam11on2100.outbound.protection.outlook.com
 ([40.107.236.100] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <poffer@nvidia.com>) id 1rp9MR-00072z-DD
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:09:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyLB+1WB8PNk09e6mew3Z9bYr0QtoCk00enw/1gZ5r0Sg+T+Ly1lmxpLiX0pZBQ3iz+BAYpSJ48z3+wKMNyXRe/d+oBSqGCQqdK2j00LH8dLVm0iXIuycpFhOY4Vv6lVKpmpyWT/NxS24LaYo5xcNVeVsA1wLeJM9I/MUEU/qI+PSYRuq/vkrcAuF5zrORfuoH9IQza6jMG+pBmhXY4BN0qzMLxrQnyV+59WBQe7svGDg3fWiRltniMsxmer1ckiSFNwHrA0ZlzwJJUvq6CIqXCCvvt98R4bdqBbja8Ut7AbM8L3I8Nu6+GKF0/c6ARC17euEPdmcK8lxpBSRuS08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfjznhJj+bBz7iH1KfKZtbHVGwt3D7xCptG4dB/YIAY=;
 b=EV2oYr2Rl6ljZ0V5fKWYYe9aJVD3KSyn8JjlvA+H1Sz0laMXC4U5ds8sPnDJUaHZ+pZzTTFFwwItn6gQinq8159auWd31c7fZvfTWGlgwxNPzQkQEGRGW9MormfubjXXOaaN+2QQnw0YA1B4h7mezUph8e5wJfbrmrDdj03NRLIl0maHMb4fqfg2oawb+SmLJJYPMG3BS7miZ+V3OO8C0GSyhiPvWyLEYQ18Ini1EZsuMhsFYk43d9GxQXKCCWC8oyPybJZs9dNklsYsQcl+f4kyIWvqROu4NWem4j5glOrJZUoRWTD6H0dw18K6Cca/rdP2xEhj+IsiA46CKC0Kmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfjznhJj+bBz7iH1KfKZtbHVGwt3D7xCptG4dB/YIAY=;
 b=ec1T6H7a57K9slYjBXKcNqS684ZZ4jkjEWJ+jjNso44ssRh3fTA5+BJN6RqC6RddcHBSpIRurGTL1EOquggEOEwo9FOYEDTwSiaHrn+pyHT1r/AfRJazP7cZenz4QFqCeZV2EmZ6piUuyzKMLuYbBU7BifOIQHbQLy/1P5eallYlYv8psk3p6OWLvIprQHUMEL0MPvb0yoTMrbcbjzJqj9l2cmu0nDALGmDusC244sffTU3aNkuu1OnMeI10cDKEDwIkOfh/FBQf6C641wS/6yU7P3ci7nmeBhHXE5GIC8uJnbWTdB8lZ+W+N2bk/0RZ8bCMDmwEMiLq9Y2HpOk4/w==
Received: from MW4PR12MB6997.namprd12.prod.outlook.com (2603:10b6:303:20a::14)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 16:04:08 +0000
Received: from MW4PR12MB6997.namprd12.prod.outlook.com
 ([fe80::1afb:ba76:620e:60c4]) by MW4PR12MB6997.namprd12.prod.outlook.com
 ([fe80::1afb:ba76:620e:60c4%7]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 16:04:08 +0000
From: Paz Offer <poffer@nvidia.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Endless data flow on i2c bus
Thread-Topic: Endless data flow on i2c bus
Thread-Index: AQHaf43FbGZcoA9M+Uuy5peHQE/1ZA==
Date: Tue, 26 Mar 2024 16:04:08 +0000
Message-ID: <MW4PR12MB69971E8D044CD7C38EF0CDDAA0352@MW4PR12MB6997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6997:EE_|PH8PR12MB7375:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fBlGX/ty+azykTnaaBo/PrYUiwwZ1vks1ZabP4VO33/6/Gb4PSrUV7flV2fIj5x7GBSzZ5yLHg+dE8pvpdIW9SySKWm+E5k9HalulmjtVH0MbjdB0VFapYzRntau1xjMa0u8JDQJJbOZ5lcsslsYkRBXfIMfAMZFRwtY/vM1+p6XAb4IVD7u51xQ4OhE8nt+xcelJjfAsOkbdabda07oMiMdFUCFVjmlJ3smpEtiPx7ZgNzwPzro0Ec+S0zG2D/TAvGZpgujh+HI+aALCBYg77PPDzAvIJahLgqISKHP1qOhGBPkh7QcfN6RBtJjQ+nLOjIrL+RPthYNlqocrAbdqTNFlnF3c1Tsy/+FULzXC8Q3cgg7ViEKdKxfuPoKEWKwYWfhp5o6eheEVYvO04WxpBrFE1yD4n1x+N0S601LXBKhR/auDDwol9rajiHpOWOsZFFKx/vWYCr0wKOaQdEYK4AJSQ4Z+e7iyzYG6SXcmOEyOUR5khnWsuccC8soP/c7+inx00dqRs0C2KppbLtO2+vIad/l/QjGPpOUk1ONOUtfwyl7G5+R+dZDoD9g+wE1BbIauuKv/Jq6fDekF3YuM6nbqYj1o0ReNbnAt2g8Dw15zgf7pS4DTsvQLDF8eCvIpTaTw+zs+uGh7k96AaPrBL5qAKXdydAWGdJJRPjclxI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OtZ+D27JZewrTViGScCPv+tba/eWU+QrwYiRZWVKos+7/QlTdrX06WjrEK?=
 =?iso-8859-1?Q?Xvhi3MbWtylPKgFpaGaUPC8jPCy8d1H8EEGRgrUXIxS8Hx5tZcvGE49rR2?=
 =?iso-8859-1?Q?9EFJVhhdCnFgc59jFmZi80NWAOw/vW9U1yLLk0ZGQBhDsgBkpJdbvBpKAf?=
 =?iso-8859-1?Q?2y209x44i+vChRCgsiRlYnyAM1I/X+THe+UqicZNOuatIh6928sH2sGFbK?=
 =?iso-8859-1?Q?UsHK0FrsN5Z5u8iGQDapBLDctw9k1VFFNan7FX2ZViTzMFCEUXOg3gwRIa?=
 =?iso-8859-1?Q?rejMHwRph5/TZO9dymEIw9AydehHYLdIxSFv5nd3RjoubwGpI1lksyR3h2?=
 =?iso-8859-1?Q?ZQw2fuL/Y8oOE1R69SQ1lnyR/1Tq/XSq7+Qx29pVwOBgHC6Bu53VGYKAK/?=
 =?iso-8859-1?Q?OPVfEUgug0qJo1RllvmWXdTOuy4L8XMJ6Sv9Xg+2DCKNOBbpcbg9OUS9Gr?=
 =?iso-8859-1?Q?u7fo9wAZ/6anjRsFjC4caE4To+hbqC8mXdlJgQ9SCVuRTpN5px8Dte+PpZ?=
 =?iso-8859-1?Q?19ML5iHzMgR9qvUpuO/M2PhVladJE8sQ+eA4tKGwf8XDt3XpnYw8jAovjd?=
 =?iso-8859-1?Q?O/SqpbNOuXXQ1ynb4gI1+4djCUx+n+DKEWDiTnbwYrbjVw5O4pdOe1R5oU?=
 =?iso-8859-1?Q?Kzmv8oE4Xh6K+NJ+ILVAFVSfRhY1IWJGQ6jyvQMdk7msJ2H9TufP2wqm7v?=
 =?iso-8859-1?Q?bewA6SXWrVNyzLV8AL1LrqIWhD3f0472ugv1zph8FSNGmZOZXdSwTIlUJr?=
 =?iso-8859-1?Q?rmGiFaKes1E9mInzcuuPdrBvX2ADzvvV0mNakQoLYiaAFJB3UZ/aZxq7qu?=
 =?iso-8859-1?Q?wWipb5NAD8CwCcs/fnDTIox4xNzoIPeaXW/lgD9kzaEv9WYcgxsPVC6igB?=
 =?iso-8859-1?Q?2wPOIK9tYswBoZ0bx7EhLQ/uLexPuvWHQt9698SpEvxlVb2n3J1fwU9foW?=
 =?iso-8859-1?Q?il1PmbSPxuUYRz2RVqUibfdPzTqTb4jb+rjNz0BWpQn6uUvY7cAl9ksxSh?=
 =?iso-8859-1?Q?KozE78l++eOYtmpqn5UmTDQ11jW4cTjYUQipxIhsmQVNHCSZd5Rv9lXmql?=
 =?iso-8859-1?Q?rEIv6Ixw3pZLDj0nPjGOAE85P/WpAhUlKxREphq8S54qHr4ti7WuXzlce8?=
 =?iso-8859-1?Q?/CJHjxlb5nONBF1ZylXtEHAlbhq6zoHsdeDS+I3CoRYtgFJSVenUw34Lr1?=
 =?iso-8859-1?Q?QxH6lQAXDsrWIywOUZ4ZgXLUYv1eXiCB0pgmXBj89aOIJgBqJuEisJnVIk?=
 =?iso-8859-1?Q?hnVbYMW6W4dkjOXHLldOZBV+OY4qkdHNXPVGxTUTw1z2i40O3YyBlxT+i3?=
 =?iso-8859-1?Q?rS0C6C7fbskMJzOp4SZP3GiUXUFjluoMxemH1LiZ93YqZSOA0QWeTqWEAp?=
 =?iso-8859-1?Q?boFJWZPEEsqy5E4u05qNkUQOaat30umg9aFHUgtnnl8KvVhS7JnoNBkYkw?=
 =?iso-8859-1?Q?wFKPwO2lYc/Kd5EeZBKIPyLUKrNKQ+sn8NCz/nWcN/q5BfrGU47D3n8hJC?=
 =?iso-8859-1?Q?oFkJcmJ0M4eLmf27k6hOOUxz48mRr/IcjPnWsS8+j274RJ4fDQhCIgy+oo?=
 =?iso-8859-1?Q?iO+Spw8qCcFWqTL50wiUotTQEgENU7KkEBGQuX6/ln1JihyJZK/zWylDpX?=
 =?iso-8859-1?Q?2izlpLKAfjEYQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW4PR12MB69971E8D044CD7C38EF0CDDAA0352MW4PR12MB6997namp_"
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d788117-7a6e-4af8-ca45-08dc4dae5e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 16:04:08.0339 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iOQnDrX31sbUzZCwT5N83qNkFbLr+sFHO93VyqTrKCoUOcsngoV193BmEOfnLTR4JkuNdZHHbrKQnyBcWCWpjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375
Received-SPF: softfail client-ip=40.107.236.100;
 envelope-from=poffer@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--_000_MW4PR12MB69971E8D044CD7C38EF0CDDAA0352MW4PR12MB6997namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I am simulating an i2c slave device, listening on address 0x30.
My intention is that in the hosted Linux OS, my driver will communicate wit=
h this (simulated) HW device.

The problem I have is that ever since I start QEMU, and even before the hos=
ted Linux OS was fully loaded, the device receives endless amount of data o=
n the bus:

  *
Few times stream of 7 bytes,
  *
Few times stream of 9 bytes,
  *
Repeat forever...

This continues even after Linux is loaded.

My question is how do I know what is this data and how to ignore it?

Many thanks,
Paz



--_000_MW4PR12MB69971E8D044CD7C38EF0CDDAA0352MW4PR12MB6997namp_
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
I am simulating an <b>i2c slave device</b>, listening on address 0x30.</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
My intention is that in the hosted <b>Linux</b>&nbsp;OS, my driver will com=
municate with this (simulated) HW device.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The problem I have is that ever since I start QEMU, and even before the hos=
ted Linux OS was fully loaded, the device receives endless amount of data o=
n the bus:</div>
<ul data-editing-info=3D"{&quot;orderedStyleType&quot;:1,&quot;unorderedSty=
leType&quot;:1}" style=3D"margin-top: 0px; margin-bottom: 0px; list-style-t=
ype: disc;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Few times stream of 7 bytes,</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Few times stream of 9 bytes,</div>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Repeat forever...</div>
</li></ul>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
This continues even after Linux is loaded.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
My question is how do I know what is this data and how to ignore it?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Many thanks,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Paz</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_MW4PR12MB69971E8D044CD7C38EF0CDDAA0352MW4PR12MB6997namp_--

