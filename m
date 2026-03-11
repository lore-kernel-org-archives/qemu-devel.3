Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39155FD0644
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 07:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Dy8-0003Cs-Al; Wed, 11 Mar 2026 03:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxn-00031Y-22; Wed, 11 Mar 2026 03:26:40 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w0Dxk-00052z-Bj; Wed, 11 Mar 2026 03:26:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AP7P0Y4S3AOKqJaZk9BZaF6+RuMmt8h2PO2B/vSUYslKp9oBnyHFlDmTilTUisPB19ChIOEbCAlyJuSMffJG7ngQUIyR/sMG1IVkMmJ8zfFN7L018GcFxoYD8O6wJutnF7u8o9eb4zNPYkq77pMuEwUOL5WsESkJlm9Uh5erW1X3bVpZm84Jzdp+j7wrSLLUpU1mnAguXGdPAnJnLJKSn+vIm7UQHhyBw6UwRd5Qgz8jz65+7/Q/8J+BjGzTEHhvkTzJaKg8RuFywWFjMkKU3O0qQaThlURFtH4qNHUVr1LDxJnZqSmQ3CsKpMbivPxrAQsZlphFQB8h9hhdApFNcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkNfTZcIrGWgh1D3atFjdHIVT8xSoWDqUyuONMPDrZk=;
 b=TJ1YTh0Waau8K4vFQQev031sTtY7dqQp5bhZkaJTchXbDiIeYdi5RvjwJg2GCMAPzA5O1Mfzw0EbUdJ4KIqo0hqxgdWUo2TOtXZFudx70BfL2t171VvHFVoUaX9229OKzcdR/SKCGgTGF9imWQ5WJZehKfgtMZNIcvO98Mr93IKwQiF4YJ5shNupyrp0OConXTC7/l/WzAb3kpCo5FGKt0IyUxznjEH356BUGi13/UEHmcU58rsabUdc6n+r70aNN59/qxR6GMN2Xc8fRfpQfIhRjUgij6Vv34wNA82q7YfH36O9tFpBAXMcpJ4cQp8PqP548idjGBdILK/GeReQgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkNfTZcIrGWgh1D3atFjdHIVT8xSoWDqUyuONMPDrZk=;
 b=cBWXfAZPbb16fn98dt6TWEd3joUxru0mqKyBIva+nqWQg2CBlCiAMCS+q5k/+v4IcrBVCjvnRpFNej45/YEOgVahmXmDL28vmThWHUvoTZWe/qYicSwVcv9ObxerCAtFHuYwpJ3uT1c9tmLN82NuHA/QlRTe0yfjEA6EEEbR2AgmkjhzwcmFer6n1O/l0CW7L/eMu09GEOBZWcv7+UqNfGdlPvNk5YZy6RAlgYQTvaxyYdNjwHl5LDD40gURW/C0S5eZLvV+ZgTnsV1VkhAwU+qw5ZCDxElPoTMebbO8dzuauZ6IK47zKqpN9Fi6X+MP7FiBNdGq8AC6jIovqmewjg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6082.apcprd06.prod.outlook.com (2603:1096:101:d7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 07:26:26 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 07:26:26 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v1 09/13] hw/usb/hcd-ehci: Implement 64-bit iTD descriptor
 addressing
Thread-Topic: [PATCH v1 09/13] hw/usb/hcd-ehci: Implement 64-bit iTD
 descriptor addressing
Thread-Index: AQHcsShfZeJMlRPRYkimFt6DLcf0vw==
Date: Wed, 11 Mar 2026 07:26:26 +0000
Message-ID: <20260311072614.1095587-10-jamin_lin@aspeedtech.com>
References: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260311072614.1095587-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6082:EE_
x-ms-office365-filtering-correlation-id: e1704b6a-1cdd-485f-fd1b-08de7f3f8194
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: ujxxVfxjPqUH/qSVkob9xOelzm7tlAroG1sPxVgZ/GBgeRnvr+xCM7nqw0puHF5BXHYIT4bjpDBL3pjG9OwLbuEoepn6ozXTD9/+ujbT28OmBo35cev6T6SsMN7vreFWmPZ6xlFB/mwwHS2V/ZXQvIlmy+brf1LZFEpe1yAbh8+QEeUGxZVzeX2kyZK4tH1K9mV1bpgrb4pynsu3azmVb4P3TYhbPLgI/qekCdxiU3ReUMo6GbcIbvzgCE83vLXhl+n+aMUiGOGUPWE2On/eJRUQjo1yp1kij9gGW3877FBi9VF7G+pP31/3pH0lBGWDigwSJLwLmab0QK/ObHQhSkn44vgsCLgtMu86eFeTSZ5OKTXDuZ/pFaWcPjFZGW+aHN6WpiynsOtIibc9ljxv3O6mkoahzuQ4RngN3mobyPJrF1LrOzMgD4w5NVOCY4DzszyYp4Oxfj39roC4IT/XGCGMRHtvvEo9bA/LRovKT1/z4s4AaU7rwmMrYs8xb+xMpYMNHvXzQfTNQJGGga1rtWg+5b8if7uUxsBDYxbXdDvysLHN+Fzf1hmXyHEhY3n4fxMQbzIEaxVOX0VC2DI6xYpaNrodh3cGwM17XZtnvN9/xDqLdINhFxttv1xXSQKaUdZrE5eYlBsVNbewH0F5okd/Hssh+5cyTddsxFlXgNL9M/7xtiBNdUE5Vu2JJXgTPcCv6pGWbCzetKkjot/SBz59ee3iCJlHdZUIygiY9sucBQT42sQEMbvUaEr2QCdoyzM8y7pVMbzo8A34U/WOzN8oQWmaBDUQYMUE2l9KODc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l7V7PVWcOhSfXdHwZzbgBWWoF6mXIqUiUBwNRlhno/JiQbj/6EojE7W4Xp?=
 =?iso-8859-1?Q?DfChRhedfr1//5dL2M8ReWumOTFWuLIZFSJaYsPsLfKaVRbQsbp4nw4pc6?=
 =?iso-8859-1?Q?UovmXY9Rf1x5S3aaAQaRzB7Gl7qzJLWMsSf1BjkrgswakRacdQmdTDeacU?=
 =?iso-8859-1?Q?3wcWtTeoKlnWPlCskw+iqy8hQMqggEtAb+VuyaNBeyWzYadX+7QsI0moIx?=
 =?iso-8859-1?Q?BwN8AVt28AUUnMf/m+lLZ7H2y6Ol1TSTDZJCxHs4w8El63tlVcEu6rXyZk?=
 =?iso-8859-1?Q?XZ0Q0WNewTB5Kp49YfrEC7hydfIRLDf0uqiZsruMxhCWywMiRpLWMKn99T?=
 =?iso-8859-1?Q?9b9+x6lOUd3qHwZo4Ta2LmHJRzdk+unzmpfI1XfE9Jn944I1lmrXVs1ZgY?=
 =?iso-8859-1?Q?MmN/PruZnP+YtJDIMLzvks1uA03+YDr00Bn3EPoRSzw0chpZsSN7bibCLU?=
 =?iso-8859-1?Q?es7AkI5hVT5FeQP2AD/gr+aA7cutx48J2wV62Su8gn0A/CEjyzpaf3G+b9?=
 =?iso-8859-1?Q?2UQVRxgEc/aggGFw4OB0BLkCQ/00CNpFwfEmhA0RDcoVMTnNfIJpcipkVJ?=
 =?iso-8859-1?Q?KSc676XHYtD1xO8iyfow9qrJHCL0FUK5gogwm+ahF9gpDnxPFlNrC24RiQ?=
 =?iso-8859-1?Q?JJ6CVEmcwt/F/fF7JKHkP+O1BfVpBJZngdZF9zzfuqPhMtdrYI8p6m7Lui?=
 =?iso-8859-1?Q?qCuebUcaRSOn+D1l9QXZjcSdm6ag/wilBD98QyhgY2s4kfvHBw4QW+vGCu?=
 =?iso-8859-1?Q?pUY8ZjqxWiJ2QP0NWmFU25p1jwlMxHVBl6WmXoJEcicA9jfi0+FpWHr6dT?=
 =?iso-8859-1?Q?3RtzZLu4MvHNkXv5YAVi9g3XC/qPMn0ZBWRVhv33URCxvys4PVvd/lnYwR?=
 =?iso-8859-1?Q?rBQGezhO+ueVvOJ/nRT6aK630cmb654GfiW82I/RqyYwy0Edlwxkp+R/Lj?=
 =?iso-8859-1?Q?JlNcfTGR3eW8/Rbvd3zoLCsAGmGZF4GaDplJEBvUc+UgU/J95+ZDPsSqs7?=
 =?iso-8859-1?Q?gHHnJ2hy27qxfXvRmbw0QTYCTh6xWAtMDhsKr1u1n2nuGaVTULLjF59lqn?=
 =?iso-8859-1?Q?+E898lEWf9ZjLwCuOR6NUBfy7DY8b7IoGWcutV16g/rIB1TpIIieI2R058?=
 =?iso-8859-1?Q?nDo9ag/VMuJWiST4w6nRWcNo10lL0u4dcQCp4w1LNbE64vF0NeILIsrRNv?=
 =?iso-8859-1?Q?GqeQTbrr+xe8NS4jvnpOMcsdrsRNr5JhbveIdsE4xemAN7ozi0orzrSjGF?=
 =?iso-8859-1?Q?UFudiSRC78D273wLUL5eumW2NzKlaGqrf/A9VvCVEurVpZe8uW841zJsgv?=
 =?iso-8859-1?Q?9Y+2UTYXrxef8CdPQsypRcdzKoWqS1g+B9e3yP2yztKL1xwvI7kiNHgNqk?=
 =?iso-8859-1?Q?K9I0rT2+vy55y8lslkwK8IdVM3O2SbUCjWp16dXoRIq6miCOcQ/NcVMu0h?=
 =?iso-8859-1?Q?5RPJARbknNuUIMtX6n3R3ec56kICG6aukVHxF5jzZTAaMXF/8zPXd4hIyU?=
 =?iso-8859-1?Q?e4GTQkvPyA9qu5eQ4LLgZE99oWXyZIRlIyGLDG0N5zTP7nZ5jVtZaZobUr?=
 =?iso-8859-1?Q?hdoTmPML5MKoqJPbFhM3qmhEVytmLONbmE+Sdg3PEmm30t/cDYuNPQBKRW?=
 =?iso-8859-1?Q?vh4DAYPp4zFVgX9Gb+jPve1zS25VeziEdisuq7LbKId1FpooEUKYKWSHQW?=
 =?iso-8859-1?Q?DwCed5qdrYlh7ziv5z9qhrei5b0BpZ6Ul7ZAKpdfmJMPOiYxl0GNThJGaZ?=
 =?iso-8859-1?Q?h7BAB15Td1BePIix/mWqjCNF244OqB99REP1QpvXB/YQESTl5I3GfXMu/h?=
 =?iso-8859-1?Q?XcYy2Pw2yA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BL7i2wd/OSvE3lJt4mcPKro18y+6tFGzA3Dhv8S/vStiPMe+3JvOxQn5jA3kGy9cECmOL2CHv/sot4EmnDNAB3nlY6XJPjzfjzPTScyceuJ0w4RGFpCEAz89dZSlI0suEMhsb44CJKKeby3HvWqD1orjQw06CbhBWme8T+I9PCHGZ3MSLEvCeLO6Id9Eo7w3XVfT7grCxqPZhBxoPpNWvGzlgtKe9XCCNHP+rHcvlBSLWMfJIXwvHNqZ4SKC5RDkaOhl6FiI126+rk4rKpxp3vT/S1dzLPxz8NL0DKFNrWdKs9cVFyz5Yl9s2yv/xCF7la9EbySvYrxf+PX/exstow==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1704b6a-1cdd-485f-fd1b-08de7f3f8194
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 07:26:26.6589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zpkFqRXLui64skOdalzEeovdCeeVgWuQZwFFzzm5ZiJx06D/gDNSm6ivXkA66qkgQnfFOGo5f5xm4dX4nlYIgMoFktXYuXPntW2Y+rBA6u0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6082
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

EHCI supports 64-bit control data structure addressing when the=0A=
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,=0A=
the CTRLDSSEGMENT register provides the upper 32 bits that are=0A=
concatenated with 32-bit link pointer values to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
iTD link pointers are stored as 32-bit values and must be expanded=0A=
to full 64-bit descriptor addresses when 64-bit mode is enabled.=0A=
Update the iTD traversal path to use ehci_get_desc_addr() when=0A=
following link pointers.=0A=
=0A=
Appendix B also defines high dword fields for iTD buffer pointers.=0A=
Add bufptr_hi[7] to EHCIitd and use ehci_get_buf_addr() to construct=0A=
full 64-bit buffer addresses from bufptr[] and bufptr_hi[] fields=0A=
when processing isochronous transfers. This allows buffers above=0A=
4GB to be handled correctly.=0A=
=0A=
When 64-bit capability is disabled, descriptor and buffer addresses=0A=
remain 32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 1 +=0A=
 hw/usb/hcd-ehci.c | 9 ++++++---=0A=
 2 files changed, 7 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index df16426f76..f0cb50ba45 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -73,6 +73,7 @@ typedef struct EHCIitd {=0A=
 #define ITD_BUFPTR_MAXPKT_SH     0=0A=
 #define ITD_BUFPTR_MULT_MASK     0x00000003=0A=
 #define ITD_BUFPTR_MULT_SH       0=0A=
+    uint32_t bufptr_hi[7];=0A=
 } EHCIitd;=0A=
 =0A=
 /*=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 5964ede05b..a4a45c7601 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1471,7 +1471,8 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
                 return -1;=0A=
             }=0A=
 =0A=
-            ptr1 =3D (itd->bufptr[pg] & ITD_BUFPTR_MASK);=0A=
+            ptr1 =3D ehci_get_buf_addr(ehci, itd->bufptr_hi[pg],=0A=
+                                     itd->bufptr[pg], ITD_BUFPTR_MASK);=0A=
             qemu_sglist_init(&ehci->isgl, ehci->device, 2, ehci->as);=0A=
             if (off + len > 4096) {=0A=
                 /* transfer crosses page border */=0A=
@@ -1479,7 +1480,9 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
                     qemu_sglist_destroy(&ehci->isgl);=0A=
                     return -1;  /* avoid page pg + 1 */=0A=
                 }=0A=
-                ptr2 =3D (itd->bufptr[pg + 1] & ITD_BUFPTR_MASK);=0A=
+                ptr2 =3D ehci_get_buf_addr(ehci, itd->bufptr_hi[pg + 1],=
=0A=
+                                         itd->bufptr[pg + 1],=0A=
+                                         ITD_BUFPTR_MASK);=0A=
                 uint32_t len2 =3D off + len - 4096;=0A=
                 uint32_t len1 =3D len - len2;=0A=
                 qemu_sglist_add(&ehci->isgl, ptr1 + off, len1);=0A=
@@ -1768,7 +1771,7 @@ static int ehci_state_fetchitd(EHCIState *ehci, int a=
sync)=0A=
 =0A=
     put_dwords(ehci, NLPTR_GET(entry), (uint32_t *) &itd,=0A=
                sizeof(EHCIitd) >> 2);=0A=
-    ehci_set_fetch_addr(ehci, async, itd.next);=0A=
+    ehci_set_fetch_addr(ehci, async, ehci_get_desc_addr(ehci, itd.next));=
=0A=
     ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
 =0A=
     return 1;=0A=
-- =0A=
2.43.0=0A=

