Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0886CF5543A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4O7-0003Q1-Oz; Tue, 24 Feb 2026 21:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4O1-0003Kk-LL; Tue, 24 Feb 2026 21:12:25 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4Nz-0000Bm-El; Tue, 24 Feb 2026 21:12:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHRVHXkjFCQx3P/GjtzQGGZDrf4QeZGoPQSEi5fJRzuyEUOy+6Ljh5PgtJrcsHzrGdHgy/MZ40ebe3YqmWTAYbd/i5NUCU26OG5dpzvg75mLEVlU+Gy2lNuiGb5origg0aE0SE5lYoT7zlluJC0qCO/nlbb7jwh49R3pL36J84tZCksNibkQwHEr6xTTzBWCUPVrKuwutOFnWtCXPJH9cZM+ivkTp+iCO7x0W4/AZLcd6AEzZ9T1323FeS6emjMRk5u71aBUpg9UILMN2wFVug2hArvtN6b0XyQissMMnjIgjA9pyWEZr+dt1kexEy08EEgw3aPrZkOPXD6xvgCUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AfGtPMk2GdcOR/dNWkYdXVyFTbKcXQekwWg2uyyeg0=;
 b=VMaDo0KHlJ5Ad8YcchFM6BeMzesLOueocefE2QaeR1f0ozM/G9NeMgaeQ+6vqtCyn6c32VOq+X8Vy0wOLSoWxlOOWPoDJV5X6cyO0+iETuyTEtswHcduBPlrIfHIe42WRBlYeZy3iCUHjcRlvUX7fIhfWLUofjbRzcNBpekJjCGHgmrxVLHbJ2+fQyDP8mbooiY5IkOcjjMOuPb8Ij6Kziaf4R6LVHi+FqXj4YD+tmIgJMLM5nsRvpMT0chV8IMRiRDz5qi7ftlsW77ZcvTFZDGK9r7wUtsKmYBbolXs1WDId+1QHn5lTLizS4dfKRjcMva7oQzRXd6oiuqm/QYtAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AfGtPMk2GdcOR/dNWkYdXVyFTbKcXQekwWg2uyyeg0=;
 b=WmPM7M8W2ZuoMzq8FrBYjPuqU/PrIPvVcb6WfaxPURceEf/vNtuQU0mQrBOjLrNDUA2BrtzwwFXindBavdt2cZKQo382AKj/WuSVqItLeQkw8olsSmfYa94hxHaO6I2RoEG9UBT8ijvlKmYP+D5+UERxuIRPB2Q0jLV8x1yK9DWLWdb0kN0jAfvmxIBr0iV1uqvinJJdjVc7a+DVPUnune3y4rV9bIBmNt0ehX3q9toIe/C4QHLti+k36UarNbNd3Ov9WDtiKsG5NpBjK+pqctXv0EpZ4IWxiKR61GwmuQtakxWWiOM+cvR/51qM0LMvsVXe+Vz6Vyzxc0vD5jjsiA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSNPR06MB8468.apcprd06.prod.outlook.com (2603:1096:604:487::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:12:08 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:08 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Patrick
 Venture <venture@google.com>
Subject: [PATCH v7 05/22] hw/i3c/dw-i3c: Add more register fields
Thread-Topic: [PATCH v7 05/22] hw/i3c/dw-i3c: Add more register fields
Thread-Index: AQHcpfwlG7bZMgqRvkyIH+3gqMyAaQ==
Date: Wed, 25 Feb 2026 02:12:08 +0000
Message-ID: <20260225021158.1586584-6-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSNPR06MB8468:EE_
x-ms-office365-filtering-correlation-id: 2f4d9ebb-4cb7-4540-4440-08de74134795
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?l68cuMShLPdvdXeILKBbann1hF8Fv8Y5kqnfDO9AUec5bfA4AbbkgDnJ9e?=
 =?iso-8859-1?Q?gWgsUqPpkXxW7DXyTOJHRhGHZA18DM3Asqpy/unreQ/FrItaZo3sr8jkVr?=
 =?iso-8859-1?Q?ZMzOu5GblBvwRAVrNTLPRcgW8nOtDfeKe6kz+FkrBAzNI3b28yL0/PvG7h?=
 =?iso-8859-1?Q?CbZRCmgZ0CCYtbAIkS1DHw77/AfzNGqAJtgvYUcNAfSye+3FgLpBPopBUO?=
 =?iso-8859-1?Q?XOakv+TI+ae1p8XrNA+EuQcKA47w/qnZyi1Rz7C7npkAMlyOqJpoQ5f7jj?=
 =?iso-8859-1?Q?i+oiSpG+NTxmE/LJeE7LF9ZpDqJo/CRQeN/1tEfH3I0oCkCQP9++I0Vt0r?=
 =?iso-8859-1?Q?r2+4aesWWJVmiWbAbi60O7yfTwiQgv1yY/ZGcOAVy6Cj41h7enEltQLRVm?=
 =?iso-8859-1?Q?1UlIpAAgCg8RPrigJaW9dTlTCJ9nxTCYDylD5D7RmIOj3N/l+b62oBiacv?=
 =?iso-8859-1?Q?iwMzxDmHZ7CM4XtfGizzUoSOfqZE1pN+jNGtsazKDyE4+2+yZkpmoxlMDi?=
 =?iso-8859-1?Q?1f2NEn+ukjSZ2dnFe7wHo4olPP56igRkMI8ugz8qsX8OYrjiOvuokmEXgi?=
 =?iso-8859-1?Q?rrRQIM4cr4HOHcm9eL4ZgmNgz/efC/9RLs+PmaAqMOZhCnXERGz8YPWH/T?=
 =?iso-8859-1?Q?k+t4WV03uP4FDLskFCGINitf8QA00Cnmgev3MX8YuvMkI8ZvL5qTw6pOHA?=
 =?iso-8859-1?Q?IJuRoWqKSik+fq0HtqZE7NH0EgnLIM+NN1zcM7//vobkd8ExbHh2NViU7Q?=
 =?iso-8859-1?Q?JdeR8R9v1e9MxwEyQjbldv6DPo4h+5HK/hnNiTxIrqwr61bbwy1/1Hin24?=
 =?iso-8859-1?Q?2nbiZLoEYtqXcWSrOfEvN9bBtchR3CEsZYsSG1nELV4ti7PfoJ/gYMfyOQ?=
 =?iso-8859-1?Q?xFkeFn9rFzRFqNlagZdSgYaKnOMNjc2/zCQpPX8VDnUeGTLXVk26evoO6w?=
 =?iso-8859-1?Q?ivijXcFBzmA0ggNp+d+u6X3P7x3B/W05uKw5uYtHdJymzEaMSOgwq5DQaa?=
 =?iso-8859-1?Q?1xtJIgK++sNM+adYVxAzXwOHGC6Nfhy1WCWUi/i2q3AkXQDA9hs+IWIM4Z?=
 =?iso-8859-1?Q?FXizrsDjBM2HuxL9/pnw6/qhECiTDBlf5mvI60sMWzoO8JDS8BDUUvUGDF?=
 =?iso-8859-1?Q?lfMQAGNXfh6MfObT1FOaXx+CorSWFMLypyh5ZTDe8lI4ddxMnLphb37AXs?=
 =?iso-8859-1?Q?pBcH6RHqT/YWtlwv/sOOh/AUjEbx+7mcvYsJ77wridI42BgzsP2xk4g4qZ?=
 =?iso-8859-1?Q?udP/UMyflZeO9/az+be02FRg383BnM+kEQydj5fUtQ5WlkLLo1mjGS0c7z?=
 =?iso-8859-1?Q?zyuSjBxUqdAJyP9RDLGike1fcjwVC3Tdvh6++imaIXsUxwmQCnpw7a3YM3?=
 =?iso-8859-1?Q?kvKfER/8woTwSxlC2XVvm9ddHCldKZwlCZa7rQ9on9Zd84PCO/dY1ESfFc?=
 =?iso-8859-1?Q?DEKgaIo2XdNi1Mi93WW5+5gDA466EqRJfM+pbHQRC9Z0fbso6+0wwk9taD?=
 =?iso-8859-1?Q?G8rVxdPTqqgYKzQl9vmxU7T/VctGEPSJW6BzfQ/uuN9WaPTIALKxwcnBJ6?=
 =?iso-8859-1?Q?b6DMO3NZfd2XCcspjg5MmhuVmA1CA7tSyU13ZKanhgrAo5/OwIL2wcqWyu?=
 =?iso-8859-1?Q?gH42Qs2ipgLWp+p3Am/H9QrKwyo5dIef2ur5XenvbmqFVv9+rmj7a/1idR?=
 =?iso-8859-1?Q?5DEQRANy5IUCvX8DKyz4UHb26mEHZYAZsp45Fnzm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CM8y2xS+eBhFS1Qw/pQxulVLqJGnwkK2d8Tc76hq63XGGYhrZwJtoDco7G?=
 =?iso-8859-1?Q?/V+GJYGJBWq9k4nX93vJx933IeJIvOgFKFNTVne9dcsIxp4e178QUf9J47?=
 =?iso-8859-1?Q?DoP5NIMpZ1uneYG96KJHuVP6dg2g9cxTRxW6qu80rzGvmx5SRTRQhFuLYV?=
 =?iso-8859-1?Q?C25AGCqZcV92MYfMemSXvKvOogde+5w6aOXg4ujTgctVgR4FTGy7iZEvay?=
 =?iso-8859-1?Q?H1Hdb+R7IkQy+VKVp5AKmm1UCrzm0MnDiu5SvAW2W4/oFexsdr+s8JvcrH?=
 =?iso-8859-1?Q?OB44DgIc3YOytleAQvxVcs7OVXWJ/SHAS8jI1E0xyEVJ8Ee6vgQLC7EcPi?=
 =?iso-8859-1?Q?zPPsIe3gsFdBLLk5+hW7RcWJoW9K8m8Uw8iUZQJeH7Z6uSYkW8Xh4RlNw0?=
 =?iso-8859-1?Q?O5tsvnI+QA8vmCR/gtQQ/rSqrdr5nWhr2eQlovhVI+VYfpicMCbKAPTTEy?=
 =?iso-8859-1?Q?BFSXH0cYDA2NjoESNYjo1OOOTNC9vu0/jhFiIas84Xcras/8c0l4/LujIS?=
 =?iso-8859-1?Q?fC2827hCT0y1IQ4muS58DKyyhIT402iIsJg/2m+zU88gucYcyIQdOuYY5A?=
 =?iso-8859-1?Q?oUWHHC76fZX4o8HeLfK6TZnxFhJeG4bUvmWcWRn22b+W9zYIi1vFxziFh6?=
 =?iso-8859-1?Q?OWFSAt1G3Z/FaptY4tW8ttqkMbe0+PVVaNLl7Gh/13Uydxzf3lBlj1kk+W?=
 =?iso-8859-1?Q?8M/eNEjZzMsQy+0UK74U6UN61kpZeaHUtxTweHtC933IFfvhlAbXUbef27?=
 =?iso-8859-1?Q?m/dsUtXjIZvLglAhn6TrLtS8kAuoaIr36xgfX5H2iiu9dXhCkUyROi0wJr?=
 =?iso-8859-1?Q?iPGTQ6ZdG96fYS8d2a/WMQ5i5CpRmyQtqe3HZEg602Bp2FQ7II1VRJniqQ?=
 =?iso-8859-1?Q?CUdX6BLeF0KMFLJA6fStPijkDbGORo6qX+EF9C3THFaD8jAQtus0nnX1VU?=
 =?iso-8859-1?Q?mfDD2nhTU1T8zgRhApD5nfxJFFuddp1x/r49+whelD7GrZikHALpqBHFRF?=
 =?iso-8859-1?Q?xDstH4l9hwW5Tq23p0M4FVFWxuchknieNiDDq2hxFnH0s0sOZWCesNXZSE?=
 =?iso-8859-1?Q?amuF9H9gFibac7xGV9BLtBYgaSfemQk/tS2xpOOepFMPXsEubPXpaw4e0r?=
 =?iso-8859-1?Q?vjypkuEvKjsfghxHCTqshI1qtPd6yzKp0OuG+TMaFEGbOxF5ST2RwoTBZF?=
 =?iso-8859-1?Q?QJOCVm1uOd3LtPYqzRV/F6TsGRKIKgLlIdKfn/GrPTxWYUdiU42ebu2+BN?=
 =?iso-8859-1?Q?MQDVQHul9iRwf3MvvVwmyJYYHUnBSr0v5BYlLXox3wN2QDVJLGoOm0DLDF?=
 =?iso-8859-1?Q?CISlAV+GaNkgik1bhPgVZyjsMzH6gIGqc5UjW7LTIki8RJ8E2zO/UlLgnr?=
 =?iso-8859-1?Q?dTSRu7P5ZGFIwcTNRNEfgwgBgv6W1G7J+AZqEOSwDtNPo2qwoZ/yKNnbTb?=
 =?iso-8859-1?Q?qxU/XozHI7lW+tY3dd/SIqaR0AxGIxkTBlmnXdAnhxg/SagBL6tHuBAph8?=
 =?iso-8859-1?Q?6cDaQmHhAuqreJiOIk6LqOevSet66ekhl7v1SHSEEZ5l3GTKQMiTJ13ufd?=
 =?iso-8859-1?Q?G5Pw3IT67qnrXNkN7CNzLEiZtrtSlkdmYetS9rBU2eaebsC7qgyuYT2hKI?=
 =?iso-8859-1?Q?OmtkXwaDCrkTrskQpLI/y97EhiVzjn4Rub3tm6g8yAc3Yjvw5WO8ql4w5I?=
 =?iso-8859-1?Q?Zlx0BMzGv6f+c8vw0CTGvFiLfHGHV4z7HLDOQmEsZI98C11J5A9J4RXQIu?=
 =?iso-8859-1?Q?p5Ku2jIlbgMnoSh9K9GRG4UZHYwPqQDysPlJYoO/3QiVWQKDKc/bnGb1Rg?=
 =?iso-8859-1?Q?2ZaE4aHWfg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4d9ebb-4cb7-4540-4440-08de74134795
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:08.6891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GvGeM33W94mdm90wazqzWKeFbDXb5nkwoow2L5uR92jbsNnaD0IV10whrhT/Vm+6ffDuu3Wiwjenn870zB88j5JODOffrrz/ka014hS47Ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8468
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UPPERCASE_75_100=0.001 autolearn=no autolearn_force=no
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

Adds the rest of the Designware register fields.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 199 ++++++++++++++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 199 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 6cadc59191..48dde008de 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -19,54 +19,253 @@=0A=
 #include "trace.h"=0A=
 =0A=
 REG32(DEVICE_CTRL,                  0x00)=0A=
+    FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)=0A=
+    FIELD(DEVICE_CTRL, I2C_SLAVE_PRESENT,         7, 1)=0A=
+    FIELD(DEVICE_CTRL, HOT_JOIN_ACK_NACK_CTRL,    8, 1)=0A=
+    FIELD(DEVICE_CTRL, IDLE_CNT_MULTIPLIER,       24, 2)=0A=
+    FIELD(DEVICE_CTRL, SLV_ADAPT_TO_I2C_I3C_MODE, 27, 1)=0A=
+    FIELD(DEVICE_CTRL, DMA_HANDSHAKE_EN,          28, 1)=0A=
+    FIELD(DEVICE_CTRL, I3C_ABORT,                 29, 1)=0A=
+    FIELD(DEVICE_CTRL, I3C_RESUME,                30, 1)=0A=
+    FIELD(DEVICE_CTRL, I3C_EN,                    31, 1)=0A=
 REG32(DEVICE_ADDR,                  0x04)=0A=
+    FIELD(DEVICE_ADDR, STATIC_ADDR,         0, 7)=0A=
+    FIELD(DEVICE_ADDR, STATIC_ADDR_VALID,   15, 1)=0A=
+    FIELD(DEVICE_ADDR, DYNAMIC_ADDR,        16, 7)=0A=
+    FIELD(DEVICE_ADDR, DYNAMIC_ADDR_VALID,  31, 1)=0A=
 REG32(HW_CAPABILITY,                0x08)=0A=
+    FIELD(HW_CAPABILITY, DEVICE_ROLE_CONFIG,  0, 3)=0A=
+    FIELD(HW_CAPABILITY, HDR_DDR, 3, 1)=0A=
+    FIELD(HW_CAPABILITY, HDR_TS,  4, 1)=0A=
 REG32(COMMAND_QUEUE_PORT,           0x0c)=0A=
+    FIELD(COMMAND_QUEUE_PORT, CMD_ATTR, 0, 3)=0A=
+    /* Transfer command structure */=0A=
+    FIELD(COMMAND_QUEUE_PORT, TID, 3, 4)=0A=
+    FIELD(COMMAND_QUEUE_PORT, CMD, 7, 8)=0A=
+    FIELD(COMMAND_QUEUE_PORT, CP, 15, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, DEV_INDEX, 16, 5)=0A=
+    FIELD(COMMAND_QUEUE_PORT, SPEED, 21, 3)=0A=
+    FIELD(COMMAND_QUEUE_PORT, ROC, 26, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, SDAP, 27, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, RNW, 28, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, TOC, 30, 1)=0A=
+    FIELD(COMMAND_QUEUE_PORT, PEC, 31, 1)=0A=
+    /* Transfer argument data structure */=0A=
+    FIELD(COMMAND_QUEUE_PORT, DB, 8, 8)=0A=
+    FIELD(COMMAND_QUEUE_PORT, DL, 16, 16)=0A=
+    /* Short data argument data structure */=0A=
+    FIELD(COMMAND_QUEUE_PORT, BYTE_STRB, 3, 3)=0A=
+    FIELD(COMMAND_QUEUE_PORT, BYTE0, 8, 8)=0A=
+    FIELD(COMMAND_QUEUE_PORT, BYTE1, 16, 8)=0A=
+    FIELD(COMMAND_QUEUE_PORT, BYTE2, 24, 8)=0A=
+    /* Address assignment command structure */=0A=
+    /*=0A=
+     * bits 3..21 and 26..31 are the same as the transfer command structur=
e, or=0A=
+     * marked as reserved.=0A=
+     */=0A=
+    FIELD(COMMAND_QUEUE_PORT, DEV_COUNT, 21, 3)=0A=
 REG32(RESPONSE_QUEUE_PORT,          0x10)=0A=
+    FIELD(RESPONSE_QUEUE_PORT, DL, 0, 16)=0A=
+    FIELD(RESPONSE_QUEUE_PORT, CCCT, 16, 8)=0A=
+    FIELD(RESPONSE_QUEUE_PORT, TID, 24, 3)=0A=
+    FIELD(RESPONSE_QUEUE_PORT, ERR_STATUS, 28, 4)=0A=
 REG32(RX_TX_DATA_PORT,              0x14)=0A=
 REG32(IBI_QUEUE_STATUS,             0x18)=0A=
+    FIELD(IBI_QUEUE_STATUS, IBI_DATA_LEN,   0, 8)=0A=
+    FIELD(IBI_QUEUE_STATUS, IBI_ID,         8, 8)=0A=
+    FIELD(IBI_QUEUE_STATUS, LAST_STATUS,    24, 1)=0A=
+    FIELD(IBI_QUEUE_STATUS, ERROR,          30, 1)=0A=
+    FIELD(IBI_QUEUE_STATUS, IBI_STATUS,     31, 1)=0A=
 REG32(IBI_QUEUE_DATA,               0x18)=0A=
 REG32(QUEUE_THLD_CTRL,              0x1c)=0A=
+    FIELD(QUEUE_THLD_CTRL, CMD_BUF_EMPTY_THLD,  0, 8);=0A=
+    FIELD(QUEUE_THLD_CTRL, RESP_BUF_THLD, 8, 8);=0A=
+    FIELD(QUEUE_THLD_CTRL, IBI_DATA_THLD, 16, 5);=0A=
+    FIELD(QUEUE_THLD_CTRL, IBI_STATUS_THLD,     24, 8);=0A=
 REG32(DATA_BUFFER_THLD_CTRL,        0x20)=0A=
+    FIELD(DATA_BUFFER_THLD_CTRL, TX_BUF_THLD,   0, 3)=0A=
+    FIELD(DATA_BUFFER_THLD_CTRL, RX_BUF_THLD,   8, 3)=0A=
+    FIELD(DATA_BUFFER_THLD_CTRL, TX_START_THLD, 16, 3)=0A=
+    FIELD(DATA_BUFFER_THLD_CTRL, RX_START_THLD, 24, 3)=0A=
 REG32(IBI_QUEUE_CTRL,               0x24)=0A=
+    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_HOT_JOIN,   0, 1)=0A=
+    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_MASTER_REQ, 1, 1)=0A=
+    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_SLAVE_IRQ,  3, 1)=0A=
 REG32(IBI_MR_REQ_REJECT,            0x2c)=0A=
 REG32(IBI_SIR_REQ_REJECT,           0x30)=0A=
 REG32(RESET_CTRL,                   0x34)=0A=
+    FIELD(RESET_CTRL, CORE_RESET,       0, 1)=0A=
+    FIELD(RESET_CTRL, CMD_QUEUE_RESET,  1, 1)=0A=
+    FIELD(RESET_CTRL, RESP_QUEUE_RESET, 2, 1)=0A=
+    FIELD(RESET_CTRL, TX_BUF_RESET,     3, 1)=0A=
+    FIELD(RESET_CTRL, RX_BUF_RESET,     4, 1)=0A=
+    FIELD(RESET_CTRL, IBI_QUEUE_RESET,  5, 1)=0A=
 REG32(SLV_EVENT_CTRL,               0x38)=0A=
+    FIELD(SLV_EVENT_CTRL, SLV_INTERRUPT,      0, 1)=0A=
+    FIELD(SLV_EVENT_CTRL, MASTER_INTERRUPT,   1, 1)=0A=
+    FIELD(SLV_EVENT_CTRL, HOT_JOIN_INTERRUPT, 3, 1)=0A=
+    FIELD(SLV_EVENT_CTRL, ACTIVITY_STATE,     4, 2)=0A=
+    FIELD(SLV_EVENT_CTRL, MRL_UPDATED,        6, 1)=0A=
+    FIELD(SLV_EVENT_CTRL, MWL_UPDATED,        7, 1)=0A=
 REG32(INTR_STATUS,                  0x3c)=0A=
+    FIELD(INTR_STATUS, TX_THLD,           0, 1)=0A=
+    FIELD(INTR_STATUS, RX_THLD,           1, 1)=0A=
+    FIELD(INTR_STATUS, IBI_THLD,          2, 1)=0A=
+    FIELD(INTR_STATUS, CMD_QUEUE_RDY,     3, 1)=0A=
+    FIELD(INTR_STATUS, RESP_RDY,          4, 1)=0A=
+    FIELD(INTR_STATUS, TRANSFER_ABORT,    5, 1)=0A=
+    FIELD(INTR_STATUS, CCC_UPDATED,       6, 1)=0A=
+    FIELD(INTR_STATUS, DYN_ADDR_ASSGN,    8, 1)=0A=
+    FIELD(INTR_STATUS, TRANSFER_ERR,      9, 1)=0A=
+    FIELD(INTR_STATUS, DEFSLV,            10, 1)=0A=
+    FIELD(INTR_STATUS, READ_REQ_RECV,     11, 1)=0A=
+    FIELD(INTR_STATUS, IBI_UPDATED,       12, 1)=0A=
+    FIELD(INTR_STATUS, BUSOWNER_UPDATED,  13, 1)=0A=
 REG32(INTR_STATUS_EN,               0x40)=0A=
+    FIELD(INTR_STATUS_EN, TX_THLD,          0, 1)=0A=
+    FIELD(INTR_STATUS_EN, RX_THLD,          1, 1)=0A=
+    FIELD(INTR_STATUS_EN, IBI_THLD,         2, 1)=0A=
+    FIELD(INTR_STATUS_EN, CMD_QUEUE_RDY,    3, 1)=0A=
+    FIELD(INTR_STATUS_EN, RESP_RDY,         4, 1)=0A=
+    FIELD(INTR_STATUS_EN, TRANSFER_ABORT,   5, 1)=0A=
+    FIELD(INTR_STATUS_EN, CCC_UPDATED,      6, 1)=0A=
+    FIELD(INTR_STATUS_EN, DYN_ADDR_ASSGN,   8, 1)=0A=
+    FIELD(INTR_STATUS_EN, TRANSFER_ERR,     9, 1)=0A=
+    FIELD(INTR_STATUS_EN, DEFSLV,           10, 1)=0A=
+    FIELD(INTR_STATUS_EN, READ_REQ_RECV,    11, 1)=0A=
+    FIELD(INTR_STATUS_EN, IBI_UPDATED,      12, 1)=0A=
+    FIELD(INTR_STATUS_EN, BUSOWNER_UPDATED, 13, 1)=0A=
 REG32(INTR_SIGNAL_EN,               0x44)=0A=
+    FIELD(INTR_SIGNAL_EN, TX_THLD,          0, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, RX_THLD,          1, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, IBI_THLD,         2, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, CMD_QUEUE_RDY,    3, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, RESP_RDY,         4, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, TRANSFER_ABORT,   5, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, CCC_UPDATED,      6, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, DYN_ADDR_ASSGN,   8, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, TRANSFER_ERR,     9, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, DEFSLV,           10, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, READ_REQ_RECV,    11, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, IBI_UPDATED,      12, 1)=0A=
+    FIELD(INTR_SIGNAL_EN, BUSOWNER_UPDATED, 13, 1)=0A=
 REG32(INTR_FORCE,                   0x48)=0A=
+    FIELD(INTR_FORCE, TX_THLD,          0, 1)=0A=
+    FIELD(INTR_FORCE, RX_THLD,          1, 1)=0A=
+    FIELD(INTR_FORCE, IBI_THLD,         2, 1)=0A=
+    FIELD(INTR_FORCE, CMD_QUEUE_RDY,    3, 1)=0A=
+    FIELD(INTR_FORCE, RESP_RDY,         4, 1)=0A=
+    FIELD(INTR_FORCE, TRANSFER_ABORT,   5, 1)=0A=
+    FIELD(INTR_FORCE, CCC_UPDATED,      6, 1)=0A=
+    FIELD(INTR_FORCE, DYN_ADDR_ASSGN,   8, 1)=0A=
+    FIELD(INTR_FORCE, TRANSFER_ERR,     9, 1)=0A=
+    FIELD(INTR_FORCE, DEFSLV,           10, 1)=0A=
+    FIELD(INTR_FORCE, READ_REQ_RECV,    11, 1)=0A=
+    FIELD(INTR_FORCE, IBI_UPDATED,      12, 1)=0A=
+    FIELD(INTR_FORCE, BUSOWNER_UPDATED, 13, 1)=0A=
 REG32(QUEUE_STATUS_LEVEL,           0x4c)=0A=
+    FIELD(QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,  0, 8)=0A=
+    FIELD(QUEUE_STATUS_LEVEL, RESP_BUF_BLR,         8, 8)=0A=
+    FIELD(QUEUE_STATUS_LEVEL, IBI_BUF_BLR,          16, 8)=0A=
+    FIELD(QUEUE_STATUS_LEVEL, IBI_STATUS_CNT,       24, 5)=0A=
 REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)=0A=
+    FIELD(DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC, 0, 8)=0A=
+    FIELD(DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,       16, 8)=0A=
 REG32(PRESENT_STATE,                0x54)=0A=
+    FIELD(PRESENT_STATE, SCL_LINE_SIGNAL_LEVEL, 0, 1)=0A=
+    FIELD(PRESENT_STATE, SDA_LINE_SIGNAL_LEVEL, 1, 1)=0A=
+    FIELD(PRESENT_STATE, CURRENT_MASTER,        2, 1)=0A=
+    FIELD(PRESENT_STATE, CM_TFR_STATUS,         8, 6)=0A=
+    FIELD(PRESENT_STATE, CM_TFR_ST_STATUS,      16, 6)=0A=
+    FIELD(PRESENT_STATE, CMD_TID,               24, 4)=0A=
 REG32(CCC_DEVICE_STATUS,            0x58)=0A=
+    FIELD(CCC_DEVICE_STATUS, PENDING_INTR,      0, 4)=0A=
+    FIELD(CCC_DEVICE_STATUS, PROTOCOL_ERR,      5, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, ACTIVITY_MODE,     6, 2)=0A=
+    FIELD(CCC_DEVICE_STATUS, UNDER_ERR,         8, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, SLV_BUSY,          9, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, OVERFLOW_ERR,      10, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, DATA_NOT_READY,    11, 1)=0A=
+    FIELD(CCC_DEVICE_STATUS, BUFFER_NOT_AVAIL,  12, 1)=0A=
 REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)=0A=
     FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)=0A=
     FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)=0A=
 REG32(DEV_CHAR_TABLE_POINTER,       0x60)=0A=
+    FIELD(DEV_CHAR_TABLE_POINTER, P_DEV_CHAR_TABLE_START_ADDR,  0, 12)=0A=
+    FIELD(DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH,         12, 7)=0A=
+    FIELD(DEV_CHAR_TABLE_POINTER, PRESENT_DEV_CHAR_TABLE_INDEX, 19, 3)=0A=
 REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)=0A=
+    FIELD(VENDOR_SPECIFIC_REG_POINTER, P_VENDOR_REG_START_ADDR, 0, 16)=0A=
 REG32(SLV_MIPI_PID_VALUE,           0x70)=0A=
 REG32(SLV_PID_VALUE,                0x74)=0A=
+    FIELD(SLV_PID_VALUE, SLV_PID_DCR, 0, 12)=0A=
+    FIELD(SLV_PID_VALUE, SLV_INST_ID, 12, 4)=0A=
+    FIELD(SLV_PID_VALUE, SLV_PART_ID, 16, 16)=0A=
 REG32(SLV_CHAR_CTRL,                0x78)=0A=
+    FIELD(SLV_CHAR_CTRL, BCR,     0, 8)=0A=
+    FIELD(SLV_CHAR_CTRL, DCR,     8, 8)=0A=
+    FIELD(SLV_CHAR_CTRL, HDR_CAP, 16, 8)=0A=
 REG32(SLV_MAX_LEN,                  0x7c)=0A=
+    FIELD(SLV_MAX_LEN, MWL, 0, 16)=0A=
+    FIELD(SLV_MAX_LEN, MRL, 16, 16)=0A=
 REG32(MAX_READ_TURNAROUND,          0x80)=0A=
 REG32(MAX_DATA_SPEED,               0x84)=0A=
 REG32(SLV_DEBUG_STATUS,             0x88)=0A=
 REG32(SLV_INTR_REQ,                 0x8c)=0A=
+    FIELD(SLV_INTR_REQ, SIR,          0, 1)=0A=
+    FIELD(SLV_INTR_REQ, SIR_CTRL,     1, 2)=0A=
+    FIELD(SLV_INTR_REQ, MIR,          3, 1)=0A=
+    FIELD(SLV_INTR_REQ, TS,           4, 1)=0A=
+    FIELD(SLV_INTR_REQ, IBI_STS,      8, 2)=0A=
+REG32(SLV_TSX_SYMBL_TIMING,         0x90)=0A=
+    FIELD(SLV_TSX_SYMBL_TIMING, SLV_TSX_SYMBL_CNT, 0, 6)=0A=
 REG32(DEVICE_CTRL_EXTENDED,         0xb0)=0A=
+    FIELD(DEVICE_CTRL_EXTENDED, MODE, 0, 2)=0A=
+    FIELD(DEVICE_CTRL_EXTENDED, REQMST_ACK_CTRL, 3, 1)=0A=
 REG32(SCL_I3C_OD_TIMING,            0xb4)=0A=
+    FIELD(SCL_I3C_OD_TIMING, I3C_OD_LCNT, 0, 8)=0A=
+    FIELD(SCL_I3C_OD_TIMING, I3C_OD_HCNT, 16, 8)=0A=
 REG32(SCL_I3C_PP_TIMING,            0xb8)=0A=
+    FIELD(SCL_I3C_PP_TIMING, I3C_PP_LCNT, 0, 8)=0A=
+    FIELD(SCL_I3C_PP_TIMING, I3C_PP_HCNT, 16, 8)=0A=
 REG32(SCL_I2C_FM_TIMING,            0xbc)=0A=
 REG32(SCL_I2C_FMP_TIMING,           0xc0)=0A=
+    FIELD(SCL_I2C_FMP_TIMING, I2C_FMP_LCNT, 0, 16)=0A=
+    FIELD(SCL_I2C_FMP_TIMING, I2C_FMP_HCNT, 16, 8)=0A=
 REG32(SCL_EXT_LCNT_TIMING,          0xc8)=0A=
 REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)=0A=
 REG32(BUS_FREE_TIMING,              0xd4)=0A=
 REG32(BUS_IDLE_TIMING,              0xd8)=0A=
+    FIELD(BUS_IDLE_TIMING, BUS_IDLE_TIME, 0, 20)=0A=
 REG32(I3C_VER_ID,                   0xe0)=0A=
 REG32(I3C_VER_TYPE,                 0xe4)=0A=
 REG32(EXTENDED_CAPABILITY,          0xe8)=0A=
 REG32(SLAVE_CONFIG,                 0xec)=0A=
+/* Device characteristic table fields */=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC1, 0x200)=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, 0x200)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, DYNAMIC_ADDR, 0, 8)=
=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, DCR, 8, 8)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, BCR, 16, 8)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, STATIC_ADDR, 24, 8)=
=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC2, 0x204)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC2, MSB_PID, 0, 16)=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC3, 0x208)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC3, DCR, 0, 8)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC3, BCR, 8, 8)=0A=
+REG32(DEVICE_CHARACTERISTIC_TABLE_LOC4, 0x20c)=0A=
+    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC4, DEV_DYNAMIC_ADDR, 0, 8)=0A=
+/* Dev addr table fields */=0A=
+REG32(DEVICE_ADDR_TABLE_LOC1, 0x280)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_STATIC_ADDR, 0, 7)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_PEC_EN, 11, 1)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_WITH_DATA, 12, 1)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, SIR_REJECT, 13, 1)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, MR_REJECT, 14, 1)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_DYNAMIC_ADDR, 16, 8)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_ADDR_MASK, 24, 2)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_NACK_RETRY_CNT, 29, 2)=0A=
+    FIELD(DEVICE_ADDR_TABLE_LOC1, LEGACY_I2C_DEVICE, 31, 1)=0A=
 =0A=
 static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] =3D {=0A=
     [R_HW_CAPABILITY]               =3D 0x000e00bf,=0A=
-- =0A=
2.43.0=0A=

