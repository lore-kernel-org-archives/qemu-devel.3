Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6F2C48BC4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 18:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbPsq-000138-S5; Sat, 17 Feb 2024 13:57:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.bermudezl@uniandes.edu.co>)
 id 1rbPso-00012d-05
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 13:57:54 -0500
Received: from mail-mw2nam12on2136.outbound.protection.outlook.com
 ([40.107.244.136] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.bermudezl@uniandes.edu.co>)
 id 1rbPsh-00084N-Vy
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 13:57:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRYIE7J3JrO7vk6H9ZjNSnxEDbZlxZ7DmjwhxYUPRSvL4RHTV7l6UsoLn2vHbbfnZinI3frSUWgEdxr0JOCoqVslRwD0zD7k15xtttjbQNOdCZwSIDqD68FklM2B8aFRZNFvXpnwTys9VR4l1RK6S/S493hNxEh5H6B2igBV8KJQ2BHl7ntyyTYECjoTdFL0J9SLvl7grqUSAjurQPJu+SXfB4FwpUA0dQ55uGjgSvuCxo1vO56QFJddhcelznDweEiI5MUIpZt2snCGFK3GFWPZ/MXFC/Kz3Z7HUAqelEnoZgYiQqLr/iDbFK1cuVs7wx9zr9RSwVyu9QacZkZq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10qdEw2Nwriq5apIDnI2seBJNURXi7JRMWyukUqjkWE=;
 b=IbceyA41Pi09HCyKoGdleEHWwfY3Z+M0tysSc/KZDoIwyvqXdtv5h5Ry5ozS5K5E3oe034CchkTZr1yYMouC4QK8YKcIzjTryO+SXKV/BRVxYIFGB3YFv+Q+1lsC8zM64hKn/2bRevliGEDZ7NUrdvIz/oZW24qPoNvqcOzqCGkx6nWnslaBTjTMwAA0Fvr+dLyQTmMtdCTq0XzQsQA+GBPQDoqp7XNurFrhDXQveXpscTy6g+LfEWnzTzfc+KHfCXcd1rQia3zHpacnFYayHXY9HZfMCF3cmrj2BAqhZ3p4lMRmOnEJed92XuuF674bLWLcyM3pE5N05b3kNaSJeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uniandes.edu.co; dmarc=pass action=none
 header.from=uniandes.edu.co; dkim=pass header.d=uniandes.edu.co; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniandes.edu.co;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10qdEw2Nwriq5apIDnI2seBJNURXi7JRMWyukUqjkWE=;
 b=bNyN/+acXbf8gUN192qY38IUBtpQSgN0X3S4xy3KDz4jwi3822GwdjZ8Gs7joBctlaSsTZgfYs7Gg9i/VzqP7uojEoGiEecL1YXF24rphJq3J4il1CV6qLASSg6uwCMcjYQi8wWRLgYl8qbBbLyhfb9NH66p4/8WJbZ5ABlxslk=
Received: from DM6PR08MB5850.namprd08.prod.outlook.com (2603:10b6:5:158::12)
 by SJ0PR08MB7797.namprd08.prod.outlook.com (2603:10b6:a03:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.28; Sat, 17 Feb
 2024 18:52:42 +0000
Received: from DM6PR08MB5850.namprd08.prod.outlook.com
 ([fe80::a4c9:830d:1290:99a7]) by DM6PR08MB5850.namprd08.prod.outlook.com
 ([fe80::a4c9:830d:1290:99a7%7]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 18:52:31 +0000
From: Isaac David Bermudez Lara <i.bermudezl@uniandes.edu.co>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: QEMU development setup
Thread-Topic: QEMU development setup
Thread-Index: AQHaYdIpj9ZpzRpXh0aT/+bmeBxApA==
Date: Sat, 17 Feb 2024 18:52:30 +0000
Message-ID: <DM6PR08MB5850F6109B1F37FE288A6ECCB0532@DM6PR08MB5850.namprd08.prod.outlook.com>
Accept-Language: en-US, es-CO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uniandes.edu.co;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR08MB5850:EE_|SJ0PR08MB7797:EE_
x-ms-office365-filtering-correlation-id: 8fcb526f-c6ca-4d4b-4bf7-08dc2fe9985b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vsHTH1pChZ+dSnSIGb1SarZJrZ8WvvQGJ1jKCWluTzj/bV8mXG7Asu10DAujEh4pKfXKAG65p81BtADMAdUcmNjzUligIDoCNJi/j/gp8/kWLiCdys0s5Cy2DcQCG0JOKetx+cO+o/SgFPjtkCho1eJWqx8CMFsqXtKSA2lUd0h1R+QptZZGSNnYNDglYje0rTr/A4jBq15Xc/GDsuNSzBSEO91IAaY3RuecFNNbycz9OqYUxsBrIcJApKyi581p4Ml3eN2BbJIHhHzSQohM/31fVfSRZs/cVxwJVaelmU1zGIP6jhHkm6iYLu+iMFRa66cO7aWMIjMEtRx7MEvNQS8+6vsaKoM0CAs4anBfOHH8b1LsK3bPSHv/5zxbIdwoKM+PuXwD0fhVRvs0m/DXw8mcXQvt/mrQ4xkFIJ6TVHAMG4f2a1zsJsTxaUXMDRXubiWMO1wyvdKEDrot4lJjSmxr3djit8bqYhIRwmQ5Mf3LodCswQhb7/lKlHwZvgP6TjmOKyT825nPn1HWHSDT3VelIBkgYVWfhdN64E8CGPLA4I+Xak/x89xnH9f+mSgoJBj/v+/IRF8DkNKagMGxoRNTsUxgP7bDrYRF/YfZ/V691rwH51Pu5Xkn+bF3l2M1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR08MB5850.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(39860400002)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(2906002)(5660300002)(7116003)(66556008)(91956017)(66476007)(66946007)(8936002)(76116006)(66446008)(52536014)(71200400001)(64756008)(8676002)(6916009)(558084003)(26005)(33656002)(122000001)(38070700009)(3480700007)(86362001)(786003)(316002)(478600001)(41300700001)(9686003)(7696005)(6506007)(55016003)(19627405001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rc1CWgf8/s8tBjqbQiIhTe0XZ5rMH7xhwVzZMrUgLheAahHdqargC9y7DV?=
 =?iso-8859-1?Q?T1PPHYOjOHRR62ZVblBGhjCb0Ti26DvIiLAPqcU+LLAExQzjLOuNJC30Ce?=
 =?iso-8859-1?Q?7fPTso078omWHjCEZL/1pHRGt14h7vSNWlAX4mg8FIVADp6SzCpowHPD1/?=
 =?iso-8859-1?Q?f5ph0ctcmr9mM0vyRw5WuJV+F1lJdLT8aaTDV5peCeSc77Hz33nItX9V98?=
 =?iso-8859-1?Q?lJHU41QPMTof/ojmx+ORhr1yCnxh6y6g5uPzK+uU1tJyZiYC/LXC1AJR5A?=
 =?iso-8859-1?Q?qL2ua9MiagZortfj/TNDltwrZodUFwdq/3+9yKcvc+MQu0eDW+/byrS2jD?=
 =?iso-8859-1?Q?H1UCXnV/MidhTHMlr9yVMKF0Ug9YpShQ2r5TQYiM2q/japdYik3FZeQGM3?=
 =?iso-8859-1?Q?oUx4dayJ7Q5vZly68oKMkHO3EK/Z/zfHIrN+5p8ojlUhV+b9+LWI6a3NQc?=
 =?iso-8859-1?Q?TNLl46sP4uz2jhp+gtwD7xycZNsfLN3lMjSzWEgdov2nC3qHyk0xsjDXie?=
 =?iso-8859-1?Q?PlMaqOqdl3IfcpXt0u0xYAhQ5dyDfLu9UbxRL8vJXNUO4910eYi0hwn3yq?=
 =?iso-8859-1?Q?RdSttZEYd6TtGNdVDp2i/U2kjw5CPdT+G1+m2xKkpuV6+ONfmA62GJ8zKl?=
 =?iso-8859-1?Q?4upbw0i5LF/XeWSRCec/lWBaNN+Q+DyZsyL+knZRmk1Y1GGuq/BP1GqFTh?=
 =?iso-8859-1?Q?68Ad1e/t+XD89NvOFxGes9iCutOmD0p1MHx3BBKgwYXO+BO5Li0YivR3F1?=
 =?iso-8859-1?Q?qBS2zXDr5lpEPVmosg/qMXXU3ATpgzra0ZF+fPHwOqNkbBx01QjX8vKCLY?=
 =?iso-8859-1?Q?wJZvgVHqtC81jXk2UeJbXZFlvRvc7e4n29feZy26QFMYSrgayNlZxjs9Lf?=
 =?iso-8859-1?Q?vL2tld4K2F8+KJO+yNhocVBVvrtce3e0wQsjeExGc4GHHznag4epUMdw0K?=
 =?iso-8859-1?Q?hKcQN+1S86LRlujLcqAEgelYa0hu09nWWYxYeG/P5lCD2qRTOkibDxAeon?=
 =?iso-8859-1?Q?uCqrqwid1t+IY8bpd60lM09ugSq0bhPvZUCqICDmOK/oaTAKCCKf6o5fK+?=
 =?iso-8859-1?Q?C5SlAxBDzUsIx03ZCyf00GMpjYi1sQLko+VKO4e6S1xYnwp6/qDBYBeon6?=
 =?iso-8859-1?Q?DT74i3dDIL4rA3WfGhSrastXZFHyQxLQ2slX3ku9gki0hVpye1eOfv3gwB?=
 =?iso-8859-1?Q?v9Cq9XY4Xe7vH7OyE4t9wJeun/BGedOt3awtqcWWMMisF6w0O10Qs9DUp1?=
 =?iso-8859-1?Q?CkBHHPKfUZRsEGzjCr2luNiwapn2jCHwuEw8Ew5iudQxovryRDSlumaExY?=
 =?iso-8859-1?Q?kExsGtDcU9n7AZNre4oFkzmHFUE5v1j+zTgCipnyXC6E5zQATD5s2+HYRa?=
 =?iso-8859-1?Q?Pv37kvq4J1qCP1b0Ik+GfnjgmdzB5onDR8zevwOmOczy7gS5TuNLyGK+ZS?=
 =?iso-8859-1?Q?j0gvBVW9UVDIAWgXEsEpZbm0NqplUf9SQNPGV9RQoqXE4Puq+lPPq/zJ0p?=
 =?iso-8859-1?Q?nJBh8Y3KLkCDyh1T7y5v5/QLa68Y5zujc0t0ENovr1m/obhuQpcxP0KdT2?=
 =?iso-8859-1?Q?8OOuQiVOMcMz36TQCkcfGBNtvTO6vF7mF/otnIS7kMjMLOsLksDvRhu5kF?=
 =?iso-8859-1?Q?EEbhMqJxooxvEzvNPy173+ztVLpJjXTonS?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR08MB5850F6109B1F37FE288A6ECCB0532DM6PR08MB5850namp_"
MIME-Version: 1.0
X-OriginatorOrg: uniandes.edu.co
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR08MB5850.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcb526f-c6ca-4d4b-4bf7-08dc2fe9985b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2024 18:52:30.9510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fabd047c-ff48-492a-8bbb-8f98b9fb9cca
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O1h58S8oz/MQY/A/L87ZUivQGipmaWCSn/iWxGL6mRHNcXWkRg5UEC9b16oUiFM101iSQcnEx4H0OrQzlh7ZZRKENdPIP6n4TSlFVYUAHyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB7797
Received-SPF: pass client-ip=40.107.244.136;
 envelope-from=i.bermudezl@uniandes.edu.co;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--_000_DM6PR08MB5850F6109B1F37FE288A6ECCB0532DM6PR08MB5850namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi, I am just starting out on QEMU development, and I would like to know wh=
ich tools to use. I would really appreciate it.
Additionally, how is the support for LLVM toolchain on QEMU?


Best regards

  *
Isaac

--_000_DM6PR08MB5850F6109B1F37FE288A6ECCB0532DM6PR08MB5850namp_
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
Hi, I am just starting out on QEMU development, and I would&nbsp;like to kn=
ow which tools to use. I would really&nbsp;appreciate it.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Additionally, how is the support for LLVM toolchain on QEMU?</div>
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Best regards</div>
<ul data-editing-info=3D"{&quot;orderedStyleType&quot;:1,&quot;unorderedSty=
leType&quot;:2}" style=3D"margin-top: 0px; margin-bottom: 0px;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); list-s=
tyle-type: &quot;- &quot;; margin: 0in 0in 0in -0.25in;">
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">Isaac</span></div>
</li></ul>
</body>
</html>

--_000_DM6PR08MB5850F6109B1F37FE288A6ECCB0532DM6PR08MB5850namp_--

