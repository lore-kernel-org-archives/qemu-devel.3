Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5206CFB44C8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBXu-0005Cb-7i; Fri, 24 Apr 2026 04:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXg-00053N-FB; Fri, 24 Apr 2026 04:05:45 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXe-0001I1-Jh; Fri, 24 Apr 2026 04:05:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVxtRf+QLJWehW5uIqq2n9JjTwepC1LTPXWcPObd8AFcAfow+ORbdbbj/nL/oLXR6LxSjpCBR4wocDzxP6F08oy07YEjGGHagu54TIFIuSrpOFUysIWGmw+ltn9sJcDpPsBsVVa6ZbHi934ztTfJz7GbH+J7jgia52/vhw358UbqpMYmHQXmxP8JzsjO5A3+jb8Z6nfNBVBMtm0q4coXawJFaRhXj6E6wvFjD6agAEdAuBMiL/AaEAYYhOEjmtkjUEeWm6f9QxXMQSFdPYhoZRgWoTZBGbeSbb+uElr2fvHjpq280spK1IJomDwVAicSYfExD2f+G34twQDf87cInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rRaAH+M0gmGI75Fu9T+UdOCeNggmfgzhvnjrKg1krs=;
 b=OfnidHtrmPU82cKGc2MOL8DJwzEDVAP4AfpMmZNXZCzw+stsd94WM2emTxPvfQa32oFAVJR0v2XbmJYk1xc8DmVRSUYc2om5p/cg34x2+mvIlmIbScIhlb4i5VofS6pyyDsuYfK3F0w2t7S53f7rimtpxbp5mIQMQTBYOh7qoNbVymvHd+hMuktk1ATcNqrqbhfVGH74Z4lAVa0vL7lGlIy0AspbIYk4INS7lbHfAl/D4eOJxByP4ETkLYUDFAQLRgHZxXwD1i9oNiCSwkFpeS3ZtFBelybEfn04e0EQHzbOrS1/dAydeQExtwPAc3UBe7lMRFv77v0P+cEKlDGBqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rRaAH+M0gmGI75Fu9T+UdOCeNggmfgzhvnjrKg1krs=;
 b=kKkY8feIggTWU0sHhq9WdH2FIqDdmUpfoNwREgabGVUumYftsS9hnkOSlV26PiQ/UVl/Uhf5nVnN6pYbqLa/Qhmx1wGYBcod+hyUg1kB4bEBDUDvkly7GY//szrjYnybTLT3wjmX2E8LTWz6CrHTMbH4vpqQBEVlSo9iRqa6nz3Amjd0FXOHNNLu3m1400geu937XIp7PFO4aeChFWtby0jQvx8g9fs5c+c3TmrXfBbqEeY9SNeucgEeoh+fDEFReWBs1yPFIxW2sxqQUoODqG6bAGAbvgyBKYxebteRMXwYRaa1o55c7y0KNosbRB1wWAImi9E3ZsflTgfY3SPSFA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5856.apcprd06.prod.outlook.com (2603:1096:101:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 08:05:26 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Cornelia Huck
 <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v5 12/18] hw/usb/hcd-ehci: Implement 64-bit qTD descriptor
 addressing
Thread-Topic: [PATCH v5 12/18] hw/usb/hcd-ehci: Implement 64-bit qTD
 descriptor addressing
Thread-Index: AQHc08EbpbJwd2qS3EyDLGVoWRNsYQ==
Date: Fri, 24 Apr 2026 08:05:25 +0000
Message-ID: <20260424080508.53992-13-jamin_lin@aspeedtech.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5856:EE_
x-ms-office365-filtering-correlation-id: 9c46a31c-8e33-4714-5754-08dea1d83dfb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: Q43S78MlzrRquXKwyw1njY9vWpcwPhw44b/dtNuWqgEptlrHPQ+CBkm/T5CyDj9ow1q9fOqSz56nSUzbM/U9q4x39m5PQ6HSJY2X4836UKknHZceIeOgDWUqqLDBRiumNYPjkpvBK+JZbvp5dq0iFS+2m7FzGwAbCewmsHcGCV6u2jucfi5eSnV0lzzq6XRIYjKwJbQXcmHDQ5JGKi47Uh/kREATNgaUAbL8ELwXoDIncl0bbIUSHz+3uBan3mXqSoMcFNWIaUGjfS3sPUfSZKZjogN74R0taeDr2zJcFGmBYXTYTnmQ3kcPyut1C/VWxhulSZNOSi7aOr4mKgjA2fmN5uMXjjE4aivQeDyguF9EhX7frf4rCW0eXODHytV9bWZJ2UV5Sbmr2oYp/r09k5YoLZ9EyWXJdS+J0SEegugScUZ/92MwjrLqNJYMANgclIEHPrRc09tLck75aoyi5RV2AKa7cKD2/EzwTMxUQZWp9MwFnAUCo914f2tLRTM06TqhgocrRYSoZSHdOvGOEsy+GxyM3U6W6Ou+lACEO97aRn6DgQUBxVDGSy85SUFewcNrXwzV1wBU/Y18+Oe9FTFf7DYtLdDP5YiKI0IrYU2iF79zN+GXoBJfikP/RqSk5R/7pe5/muv4Q1N36PXvdNEVM/jXog+Ak+ZtsCEeHliKmsw6mtMCFgQVH0IP9mt/bmV7Ba0VObLxSL+PH43tdjRmx4DJ1RjHpk8k6B2rYOdDmWLQCNXSxGpsw8wxjQurDcLCEfXSzYQL4A4AqScIIrFtZbuLg4NFzASW+DGXO2ulXfa6yiZKYiF2jYRbvZ5+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BrGQmwl1CARMUr/RGq2FBiptOfJYug0iciag15s0OOq617wyUyGfw5pyKx?=
 =?iso-8859-1?Q?KALFZe/2B4UN9XJh93dbAqsIJzzqh0BDoBXyXPJNVe82r0GytIZT3jgSOW?=
 =?iso-8859-1?Q?O7a5noD6i/CcUaTjmzvvsFmYIF3LeUSK1q9vN+JxfbeeIUNulER5DAijEn?=
 =?iso-8859-1?Q?eiFL+oiPf46uk6snTivy1dvKD/PH65NW/2jULkAtZaqmiovNe9aGy2taoS?=
 =?iso-8859-1?Q?dikrmLB7kmaCpzEYZE5uQ+QwyXf/GIw1qqdzG3G9LldGkIUOQ/LxdU+ZaO?=
 =?iso-8859-1?Q?xN+grUOzD4HlLQ6qXsHmiSF0LUed7FZdOCa1Df0LBSvMz8tP39c3kA6v49?=
 =?iso-8859-1?Q?JrVrBUK2zTlSWc214x+Nnl2rZgDZQ/Mm8HoQjka7Ffu8Zr0x3Zv0HxiwJ4?=
 =?iso-8859-1?Q?8lnXhmtyQ33bIElcBuVkSbfXsrnFOztlBP2CN/WeO+xwDQl3otHqw4/yKK?=
 =?iso-8859-1?Q?FCBEo4hiqJOrdzGqP9VuCEC2Xf/ZHQxlkWT07yx7uqfJoukwUU+sZ4tO+A?=
 =?iso-8859-1?Q?gXH4fq4Zo9m947agxmeCGKug0wlOwvNw2qiNkX9DMJ1sLsLQRBSHO78KkD?=
 =?iso-8859-1?Q?Jc3vo5bMRMwd4Dp2pi9hzOfVbIVP9vFBcC5zuAswpA6m0iF6aMibW/PkG8?=
 =?iso-8859-1?Q?WPtwFxQ8rf8s6vFP7asSZ2u9txCSZeI+JarbFhARHgiHO3HAgMiaLhedVR?=
 =?iso-8859-1?Q?RsAzGYQPgrrFgvzbFctXOFkHodkBn6pRqaisj6j6w9nBFmuOpj8xLimSVp?=
 =?iso-8859-1?Q?Kmjyod6dmAPqBjHSFduIHUZDSQUA1V8wxe4RF+To80xjaxDAbfGeISvB8o?=
 =?iso-8859-1?Q?jiW78PZ7y81DkUjNoGrP94+PeARUzGiOe0HrKWvsuUzJaPCNNI1QwKYgTq?=
 =?iso-8859-1?Q?6xbV8FqwJ6RV5tKclpe9BELiPGvN3Zo2ZKrj+7ZBxL/8YG9usw8pdowuV4?=
 =?iso-8859-1?Q?by5avYSq0LvCgLEDYRDjsdMVfa1F9eV3MZFBE3OkXxcOxpiwSpeGVvrhzF?=
 =?iso-8859-1?Q?vN0b49iilyozylwhPYMZM1u954Jjg1D1WcSPMQnuWI75cxvwQCFA5Bivoe?=
 =?iso-8859-1?Q?1Fwu4iWus4vcMcDnkRHoaUylyMptY3l1tsFue+zTVKrRmGIIaOSqQZ6NjH?=
 =?iso-8859-1?Q?DpYS3Lhy3iPPXMkGUfV97s5eO6AuIFyPJmC+bkh6B4EW9IijLwDntmWsZc?=
 =?iso-8859-1?Q?9oHS0GxUbITr1OfedKovuH5QLJq2kc9UHwZuKRL6PCrIRpatcoNGkcweua?=
 =?iso-8859-1?Q?MbJD81NJMqAsD3l1tGj7QU74QghjYQdXpSYZFoxUlD5HBLnnkkThX+t/Di?=
 =?iso-8859-1?Q?Gk4qC9Pq7G3PWav192/77F+YqdtSSmsHGoFD5KUKXKI6ugSg65pdy7Cx49?=
 =?iso-8859-1?Q?j+L7z4kCdg7g+87tI4/EoJUQ1Wjhs0VKKoO6kffnAxFfqjMPxxkHti/LLz?=
 =?iso-8859-1?Q?C4i3wgwfFO844X3P23sHXP79dzXFpasXK85eTu6TCQBBtIs58MR93N4vR+?=
 =?iso-8859-1?Q?1V5/QnAEHl7rnigssfRJvFW1EKmuADNgA6Fji5tsUGnjmu4MRP0SaXd88y?=
 =?iso-8859-1?Q?AEidXQKi3s7JPfBs0Tda54x1LDaga044DC2sZCmPoj4OidZ15OvLlWQqdN?=
 =?iso-8859-1?Q?qxHjI080sNxidpcRclPwgLsmG5T/vOszrHz6M3sm1nzC1/AghONXWFm7iS?=
 =?iso-8859-1?Q?M33S0ldhcK0OlW+u20HehnWzgM6TJnrxtmdUC2lmDt3mgbbIArp9lkYvEJ?=
 =?iso-8859-1?Q?RJheO3mqushDz0l7Au7RwKoFPW9NZCEcbM7FUc1S5ms5ffqtPrzHfU+JQF?=
 =?iso-8859-1?Q?eEtddZZ0GQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h+DZFKqHa05JXWS9ZUP/g5nlYwr+wKKJTq55GUev930S/q/UMdnYoL1rw6KwieRyyfoOrE/ErI5Ub0wBdi3sCoQZo+efneZM8zg1X4fV81z/Foo1iWBVQMszUHqHuwCNmP4PG92jEcdmKH+WdQTSbw3WswtWNDQxBXfKYgqp8tq4qdPfnT5/IXb+ariqKETbViTngCrLi4LgSLcE7vVp6lkQo3JoFeUEkdCUbp6CnKLE23SZNZFtzRoM0aO+S8lOYgXaN8FIKassM4OeF91s5tAhg69gerxYde3Q/bPQ29tYejIIbMt1/rINYEtDNDlahJyBMRkes+r3mg3VvyoWJg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c46a31c-8e33-4714-5754-08dea1d83dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:25.7810 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XKMqiMIugiqyBuP3gpmbZWkid9ScsFoI2LI9cMylPDb1xh8ukdN/DCISDommxyUTDHfmTGFATxqaAqvHqqIXdOG/m2xIvs7mHb4NSHTu45c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5856
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

EHCI supports 64-bit addressing when the 64-bit Addressing Capability=0A=
bit in HCCPARAMS is set. In that mode, the CTRLDSSEGMENT register=0A=
provides the upper 32 bits that are concatenated with 32-bit link=0A=
pointer values to form 64-bit control data structure addresses=0A=
(EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
qTD link pointers (current_qtd/next_qtd/altnext_qtd and qTD.next)=0A=
are stored as 32-bit values in the data structures and must be=0A=
expanded to full 64-bit descriptor addresses when 64-bit mode is=0A=
enabled. Update the qTD traversal paths to use ehci_get_desc_addr()=0A=
when following link pointers.=0A=
=0A=
Appendix B also defines high dword fields for qTD buffer pointers.=0A=
Add bufptr_hi[5] to EHCIqtd and extend qTD fetch and QH overlay=0A=
handling to load and propagate the high buffer pointer fields.=0A=
=0A=
When 64-bit capability is disabled, descriptor and buffer addresses=0A=
remain 32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h |  1 +=0A=
 hw/usb/hcd-ehci.c | 19 ++++++++++++-------=0A=
 2 files changed, 13 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 3428839ec6..fc66aacd9f 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -139,6 +139,7 @@ typedef struct EHCIqtd {=0A=
     uint32_t bufptr[5];               /* Standard buffer pointer */=0A=
 #define QTD_BUFPTR_MASK               0xfffff000=0A=
 #define QTD_BUFPTR_SH                 12=0A=
+    uint32_t bufptr_hi[5];=0A=
 } EHCIqtd;=0A=
 =0A=
 /* QH overlay: altnext_qtd, token, bufptr[5], bufptr_hi[5] */=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 5ffd4c9885..e82e0f625c 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -472,7 +472,8 @@ static bool ehci_verify_qtd(EHCIPacket *p, EHCIqtd *qtd=
)=0A=
             (p->qtd.next !=3D qtd->next)) ||=0A=
         (!NLPTR_TBIT(p->qtd.altnext) && (p->qtd.altnext !=3D qtd->altnext)=
) ||=0A=
         p->qtd.token !=3D qtd->token ||=0A=
-        p->qtd.bufptr[0] !=3D qtd->bufptr[0]) {=0A=
+        p->qtd.bufptr[0] !=3D qtd->bufptr[0] ||=0A=
+        p->qtd.bufptr_hi[0] !=3D qtd->bufptr_hi[0]) {=0A=
         return false;=0A=
     } else {=0A=
         return true;=0A=
@@ -1200,6 +1201,7 @@ static int ehci_qh_do_overlay(EHCIQueue *q)=0A=
 =0A=
     for (i =3D 0; i < 5; i++) {=0A=
         q->qh.bufptr[i] =3D p->qtd.bufptr[i];=0A=
+        q->qh.bufptr_hi[i] =3D p->qtd.bufptr_hi[i];=0A=
     }=0A=
 =0A=
     if (!(q->qh.epchar & QH_EPCHAR_DTC)) {=0A=
@@ -1233,7 +1235,8 @@ static int ehci_init_transfer(EHCIPacket *p)=0A=
             return -1;=0A=
         }=0A=
 =0A=
-        page  =3D p->qtd.bufptr[cpage] & QTD_BUFPTR_MASK;=0A=
+        page =3D ehci_get_buf_addr(p->queue->ehci, p->qtd.bufptr_hi[cpage]=
,=0A=
+                                 p->qtd.bufptr[cpage], QTD_BUFPTR_MASK);=
=0A=
         page +=3D offset;=0A=
         plen  =3D bytes;=0A=
         if (plen > 4096 - offset) {=0A=
@@ -1727,7 +1730,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
     } else if ((q->qh.token & QTD_TOKEN_ACTIVE) &&=0A=
                (NLPTR_TBIT(q->qh.current_qtd) =3D=3D 0) &&=0A=
                (q->qh.current_qtd !=3D 0)) {=0A=
-        q->qtdaddr =3D q->qh.current_qtd;=0A=
+        q->qtdaddr =3D ehci_get_desc_addr(ehci, q->qh.current_qtd);=0A=
         ehci_set_state(ehci, async, EST_FETCHQTD);=0A=
 =0A=
     } else {=0A=
@@ -1805,14 +1808,14 @@ static int ehci_state_advqueue(EHCIQueue *q)=0A=
      */=0A=
     if (((q->qh.token & QTD_TOKEN_TBYTES_MASK) !=3D 0) &&=0A=
         (NLPTR_TBIT(q->qh.altnext_qtd) =3D=3D 0)) {=0A=
-        q->qtdaddr =3D q->qh.altnext_qtd;=0A=
+        q->qtdaddr =3D ehci_get_desc_addr(q->ehci, q->qh.altnext_qtd);=0A=
         ehci_set_state(q->ehci, q->async, EST_FETCHQTD);=0A=
 =0A=
     /*=0A=
      *  next qTD is valid=0A=
      */=0A=
     } else if (NLPTR_TBIT(q->qh.next_qtd) =3D=3D 0) {=0A=
-        q->qtdaddr =3D q->qh.next_qtd;=0A=
+        q->qtdaddr =3D ehci_get_desc_addr(q->ehci, q->qh.next_qtd);=0A=
         ehci_set_state(q->ehci, q->async, EST_FETCHQTD);=0A=
 =0A=
     /*=0A=
@@ -1841,7 +1844,9 @@ static int ehci_state_fetchqtd(EHCIQueue *q)=0A=
     if (get_dwords(q->ehci, addr +  0, &qtd.next,    1) < 0 ||=0A=
         get_dwords(q->ehci, addr +  4, &qtd.altnext, 1) < 0 ||=0A=
         get_dwords(q->ehci, addr + 12, qtd.bufptr,=0A=
-                   ARRAY_SIZE(qtd.bufptr)) < 0) {=0A=
+                   ARRAY_SIZE(qtd.bufptr)) < 0 ||=0A=
+        get_dwords(q->ehci, addr + 32, qtd.bufptr_hi,=0A=
+                   ARRAY_SIZE(qtd.bufptr_hi)) < 0) {=0A=
         return 0;=0A=
     }=0A=
     ehci_trace_qtd(q, NLPTR_GET(q->qtdaddr), &qtd);=0A=
@@ -1922,7 +1927,7 @@ static int ehci_fill_queue(EHCIPacket *p)=0A=
         if (NLPTR_TBIT(qtd.next) !=3D 0) {=0A=
             break;=0A=
         }=0A=
-        qtdaddr =3D qtd.next;=0A=
+        qtdaddr =3D ehci_get_desc_addr(q->ehci, qtd.next);=0A=
         /*=0A=
          * Detect circular td lists, Windows creates these, counting on th=
e=0A=
          * active bit going low after execution to make the queue stop.=0A=
-- =0A=
2.43.0=0A=

