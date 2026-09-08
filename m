Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0C3C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 00:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3jxH-0006n9-3a; Mon, 07 Sep 2026 20:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3jxE-0006mr-R4; Mon, 07 Sep 2026 20:44:52 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x3jxC-00030c-6M; Mon, 07 Sep 2026 20:44:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLQrNuII3mfRl0zhNCTz8bjVscACRbY58pwkJC9/w0zGir7N4It4vk0Bkeqd7XGvYDfUvVl2JL2hbX/KhFYxYoBmXXx07t8yn1HkEUB9WloZlmgQsAtllEzxJoWVo/7hOizPmg2wXFcox/cundbgpUWxbu+G2YNPoNjNtHHthjNm24a1pfQpKCtNd6RG3JPPooLzpbgGH0wysU/p3zL1N0WmcVMoFD5hQhUgl0e9ucCDigDZiEH4Gt0xSXaq3c+DkvR4vqfwXw1qHIXnjH83a/GZoafTgSL48O9OWtJjmAJYUpfpuNNFAILDStxG3yFFH0WOW5fgwFOGc5RDgcRFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5qYBjRokh1itSYWDM4bgzLd7TfnVwf31nEM7iGpb5Q=;
 b=Iaz+ICjSWBrP8So4/ckOQAYA+TgtBtgorSFe+u6oZQOH89mwP3dJyzV2E9w+m7o0MBUgocccPiokko6GUFwIMSYhw+hpRfHBxzCL1MpdMa8Jz9OADnDjtwWjvTu2MBLRzgN68sWd0AmMa8u3QM3I8SgArcuRBCsPqWhNYYkSq94lBFBYlDDzpXvC9Ts5S41c6AGY8n2/IinYhHwfDxLxTDhbzq4/LScOs5VDHDIULTl6uGpBaLNoNIzqoiSGynUrEqRaB01sjFZfCFhhcJB+66f9K0JEBpYP8MvHD0UydPF6H9gaOr0tDCdBZTqb155gH2JJAYs3OXLomCcgl4BWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5qYBjRokh1itSYWDM4bgzLd7TfnVwf31nEM7iGpb5Q=;
 b=HUlNjA9cYhNPJPZJjuY22K588RrDo6YeUfkWCgoJxafXm+nrG48PqwzpbecqZ5gMt5/RtKld0YnnpH+/TQubJk0KkdWLOl0uPRRKyqbtEmzMe1s+3sr3OqKl5cwHRQ0nt8lSGp1E2leoi6o38/cRw5gPhiL8TLXWY8/WtkK+ZGV8+KFPULPmNTV6RIVTe63aJD0CeJtZNRO7uSXYS+E6YSywdU8Minuu1Irzl9ay7jwh9S5bhVTeixG8WYUdznx+86F7krcyarLZTpdmCWncUWMf4VnWX1yCs99wHUC0oM+7vHLwWzWDdWk5dk8l3vb1S7tt437YP3SjDF8UGjLONg==
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com (2603:1096:101:3d::12)
 by KL1PR06MB7318.apcprd06.prod.outlook.com (2603:1096:820:144::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 00:44:39 +0000
Received: from SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c]) by SEYPR06MB4989.apcprd06.prod.outlook.com
 ([fe80::e4df:26cb:6609:971c%6]) with mapi id 15.21.0382.012; Tue, 8 Sep 2026
 00:44:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 3/7] hw/pci: Add the ASPEED VGA device id
Thread-Topic: [PATCH v1 3/7] hw/pci: Add the ASPEED VGA device id
Thread-Index: AQHdPqoTgbUnj+hjRE+CSudBXkxE6rbC1/cAgAEA5BA=
Date: Tue, 8 Sep 2026 00:44:38 +0000
Message-ID: <SEYPR06MB49899D9A8E1A7C8C61A528ADFCB12@SEYPR06MB4989.apcprd06.prod.outlook.com>
References: <20260907092004.2590015-1-jamin_lin@aspeedtech.com>
 <20260907092004.2590015-4-jamin_lin@aspeedtech.com>
 <20260907052308-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260907052308-mutt-send-email-mst@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB4989:EE_|KL1PR06MB7318:EE_
x-ms-office365-filtering-correlation-id: 4538cb5a-5ff1-4558-991d-08df0d425d12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|7416014|10067099003|56012099006|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: 4IYeL3UaOtYoFPG1bLcIvnUG4F1jrF+hjuk9xLPvAl2grl1z/N/+XgPGweILZ7uPdyuUhI0zhYvWvS4ZQd5XbkQM+jL/+k/jGCYFvqZNqpcbe+1/TNzhdUTWNcCDb/fBufHSHivDkHJGlEVfiCUjJhIwdIrk53Gno9jqV3F4bGJbZnPuCvYdujcJMDw9BYXGedgqeuGgry8/ZOyY7buZHezhfpzO8eq17Q0RQvmAbQrIQbOR8lgXKnpW3wnTedY6K07/NFxxRsgFISQAPTLTsl43dIjkey3J831RXeidBYDIZlm27BG/1zgMAnMxOyvRhXeq0heKV9Z2xLJI1ZgUv354pQDMOMQ/TvHKNnxvfFCrtAQcB9oF2HyNruZeu9tbCUJhhJ59iVkYnpT6sZTGW/ajeDNBpPLFRNEA5kBNYI5IrlzrA8YCePO6soDIVzP2AQVHps2L99dyMw2pryqALdTDT7FAoiYy35T9MpNwXkwVliPgUx1KMJ4J9Ue4tgCy2T0/i5+ES/+bK/n2kiqWMAsAYolojBpsjpPy5J9N0pHpIQ4fGmcJbFyAGV9w1teVaRZWmUaJjrRWhvjRGbbv/C6+HwAgKg6bQLFWT5+N8mjZwEOGjMsao6hkS7oVQM2ws8EBm8rd++B3PEF4kBHLlw7/Ync5U863d9sXI6SbbZ1smkEx2qO801il4JE4xs5G1XhyfG8nL+Gbb35wZ8eahQCwPapuCaJIS6ZpZ4iXWUk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR06MB4989.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(7416014)(10067099003)(56012099006)(22082099003)(18002099003)(4143699003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?w6VajKzUDWkSGh70HTebD75tJ3rnUaky0W75XDi+CerLHFpz0Rq2g6TH4N?=
 =?iso-8859-1?Q?X68+PmMW2xM+AwPWbvZvdKkDaG3fh3gtfDPTzNhMaEymPA4V6tqj8Dntcv?=
 =?iso-8859-1?Q?X1daGge7a+qHoKuHCFfMpJU8J8ZC5cSA3PXmoa+uHHF2lKLG3HxIjJ69gX?=
 =?iso-8859-1?Q?S6AwZshsa8MUeh6EOjVpKheiHZtUi4SoGVW5ZUg0Gwn3pyMrEAWdb6FRT7?=
 =?iso-8859-1?Q?JIg1MFB0W0rF1QjAIQZnXVuY1bPvisnhPFsRvVSB4VWb+dsgxGaNp4m1QL?=
 =?iso-8859-1?Q?4pKIIaq7U8VC43WbTDyJmoyxhMvCzZEUY7PU0Ndgiil6YBSJUh1Bi5GQ+e?=
 =?iso-8859-1?Q?qYiI7UxCY/BtAWuW6lGJS78KO4E1odIgzOIlg4V/6SFm3z/OAB6lOGgdUT?=
 =?iso-8859-1?Q?4K/4oSqPmI1rN0J0Y8H/TN9LUh5548pmeUBmqaYellbDvJzh4zkvdjERmW?=
 =?iso-8859-1?Q?LwLqyn5UwULG1It4UcIO/Q6XI/qDnn8R8jqqU8lby2drJDq+TOYc1YKzL/?=
 =?iso-8859-1?Q?/X0A/2xC/My93+qKAdoKC0qOJua4/skUSi3sGzKqRXP4qhWs7y66HO1zwG?=
 =?iso-8859-1?Q?Ai19jVvQn5tLQROjw3/2hzCu87l60c0ePgPQAO+EEaM/38wnEwGbP3Vv7j?=
 =?iso-8859-1?Q?d5oqs9b5Sfih3fzGphXoAYmzbAl63jHwEFMMxJNpx2Fyozepdv0e8SPfiz?=
 =?iso-8859-1?Q?O04dYZ8pJijxCW14GtdlpqVhMU1TT/RmaDd+XEup/taeyGdZPbAbKfsAGE?=
 =?iso-8859-1?Q?3G9CY0sH/hQBrOYRgsWkeKLYSZvfwLz56gl3SnrrQ4nDmYslswCE6smUaO?=
 =?iso-8859-1?Q?M1NB5Cg4Tqfqqb+LnCxhBtZiXIBeUZt2okkViwG9JRTSaccUR4Pyn3eHJF?=
 =?iso-8859-1?Q?0BkGrH8uoBoxf5EYnyTa3Gsor4sbTcH20hwX8+OOiZcqA8tnHB2f3FM4JX?=
 =?iso-8859-1?Q?gmjMLIn3ZOLd4MMUCaNd1WQTAY55f02elmRiCvz4IWDaKblmSvOOeevnLh?=
 =?iso-8859-1?Q?Tge8gTR3Yzl9oGlSa9hveYWzHkZetBnx2rNx8SUMjvax6XGsdIGSjNiwq6?=
 =?iso-8859-1?Q?bX88hOSCWQ6XJiXVLzdpbpTDb8iZHdPmdix5m2AAMfAaTuHyJtOlaWBliB?=
 =?iso-8859-1?Q?u+tu69eE4INHTpOyG7zO9B77Tyso7D4eetwfBybE5mPcbx8ptVvwwNCTXc?=
 =?iso-8859-1?Q?NLzdQW5jx0OyEs/fu4FPOf0V0yV4jlqWB+Zk/Jrr/YKpMYpykHop7Bk+b0?=
 =?iso-8859-1?Q?WkHozp+c8iEPopGAcKf80RM0RFGYak0LrWMvQ79HJyOjpKvNCZ7ZESA736?=
 =?iso-8859-1?Q?Cw3HvYWjnCg2MnXkeILWB8PXSpwvmhSmUfRL2a6vvyKkvEJtWQCw+V5gmW?=
 =?iso-8859-1?Q?NL6wtSfP7dFbMQwVKLInSMScNmbPyOxoE0hiWqQ3YPRHI/BB7BsVvvcHEL?=
 =?iso-8859-1?Q?/vb35BM7RCtP8890DKOZXfvN93mdC3uyL5cdDsjNOIh6sm7Al9ps253sdu?=
 =?iso-8859-1?Q?JIt4Hgp8IhdHh80g0C8l5w81qNhJpTiEsac/S0P/WwUw0Ztx71Nu8MErr9?=
 =?iso-8859-1?Q?Rw36IQtDXAE277MCCKecrEBZwYxVHQmRxTOCc3KVmv/tdrc28A2IUiho5B?=
 =?iso-8859-1?Q?bPNWUYPmROgXwL1NH4Bcq4QFXtqPz8cnuWu2bns+Kg5dQn6tM1akhnWKE7?=
 =?iso-8859-1?Q?mcxu6sYZHR6Ok6O4BB8bUlRPn56o56HKgLwmPDyNcfpRnjW8RIsctYtx70?=
 =?iso-8859-1?Q?9XtgZOLeIHbLoblY1etxKmQTNp2MxhnU2cGs/8ZGioL3IemmF9JVMwX/r2?=
 =?iso-8859-1?Q?+4hfXzdE/A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: u4dH10ZhmTWHcSN9LUUz/FGLrUs8zQZIam9+u3QqR2V5rLYjazpxb8YiIam5YyKgRTY43h3XjfNB86gGBUGhlyBSvYDPHc+xCm8XD3wQmGV4LRZ/AQyaDaYOqqxUtySsB0dqFZ7LQV2fgk4c0wdaZtvDTffcdyThBdm2tT6m+C0Dx+aJsd+xMRWa7PY0VRb6fVLVD2RpglMb+uqKO5e40Rhe3M4pZwZeaAM2QvOHrDiRIktjx4qCryIZUne12Ri5qVkpmQiB9EqEih10knB6DG3/85x+2RhE0gUY/XP1c16l8Lwuf5Pt7RWYlHMAa7DvVwZewiRhxuaRETrsZUUjFA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB4989.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4538cb5a-5ff1-4558-991d-08df0d425d12
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 00:44:38.9774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbaNL8J6iadd9QsfFODwamn8p782lfQN1EzN8NDgGfGfzEltjIZsF/pyKn/5P+4zFZ8c2UlEjKQAqK38di4ax6phEUoCS8kbqn2KSuQ9JLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7318
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Michael,

> Subject: Re: [PATCH v1 3/7] hw/pci: Add the ASPEED VGA device id
>=20
> On Mon, Sep 07, 2026 at 09:20:08AM +0000, Jamin Lin wrote:
> > The ASPEED vendor id is already listed. Add 0x2000, the device id the
> > display controller of the ASPEED BMC SoCs reports, so that the model
> > added by the next patch can use it.
> >
> > No functional change.
> >
> > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> > ---
> >  include/hw/pci/pci_ids.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h index
> > 16034aaa2c..e16d93dd13 100644
> > --- a/include/hw/pci/pci_ids.h
> > +++ b/include/hw/pci/pci_ids.h
> > @@ -292,5 +292,6 @@
> >  #define PCI_VENDOR_ID_NVIDIA             0x10de
> >
> >  #define PCI_VENDOR_ID_ASPEED             0x1A03
> > +#define PCI_DEVICE_ID_ASPEED_VGA         0x2000
> >
> >  #endif
>=20
> you do not really need it, it should only be used in one place. open-code=
 the
> dev id in the implementation.
> subsystem id will be copied automatically if not set.
>=20
Thanks for the review and suggestion.
Will drop this patch.
Jamin
> > --
> > 2.53.0
> >


