Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC41C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 03:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPZhg-00056e-Ip; Thu, 04 Jul 2024 23:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sPZha-000564-Rd
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 23:33:39 -0400
Received: from mail-sgaapc01acsn2080b.outbound.protection.outlook.com
 ([2a01:111:f400:feab::80b]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sPZhX-0003mS-CH
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 23:33:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cpiv61YzzfDlzJuXEPj8jZNT1EOSiYPmpFrTlcBpTw0N8ChqYsmQFBwER4gNM8TTcp+2rxhok5G20UdCkQKtQaBEiG5akQ207lL2Jkd6zORGrVLbkxrwSPJO94rBd7U0BxUPHGayGgXQvac8k5tZMcx6GYXT58PppxlmMXattOF3hXRT2APqMMbJaVx73f0WHIOj2IYntz1w5bIiDidBdM+9XdzjxxDY4qBfA/EzpFXRuJLMxgDzqTqJ6ncRoUrOiGJFKRdLol1IfS4dciWV9FV3bxi5/sQLuzlMcvtuiFqmRzU+rglGqz29dy0S6l/tjEqfsni6rZ0gHNIrmzA1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/YIvRofYO0R16YIMpAlHEXp6ljGp8JFJhITXZtB0uI=;
 b=nK3N+wUZDXGQ7qK/Of6xg5EJbiF8kZuk5mRmzCd7pUfwqhOrJxWPfitIomU+IS727Dk4l45AGljOMtuF1+5s8/CogNUoe70Rxq4fgFUBmSA6gOGaqKZw+Eo598IKqfEV6uXQbn3iixxWp2CDUeGh6tmVBH6dsqN6WLzrqBNreQM9WbcZRTIPl5KEjalq5ra/YzvzIkDVG1SF5grsEMAlh3xgrD6LZD4Rn8a7A41vrH5HXP+YWUHaf+uz8GxpoYuPOvnjb4BatsUF8Hx9LlSp+Up0rV95tpI6ibNK+XObD2KerVCkR4copByzj8zcZojYsSP3g3eOZH0vge4egRZTXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.JP;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/YIvRofYO0R16YIMpAlHEXp6ljGp8JFJhITXZtB0uI=;
 b=liCMFQJNCh+IgzWkelZHvGQZUfQE3Nd2c4Yvyvi832o+xQoe8s4/4pIBT2SYOWf/TkiQ+Cu8Pgh8IYYITMijxhyYcdzLbfXgwVgUXK4mikoof5uxGrERAbrFPAIPpiUsznJJaxy04t7IDw4PLYSiI2zQYE1OIc9s9j8OZERyDtaAEPU0cDF9Oyciyw8nlvguiB2G9EQUCkFlu3R2dy2brOwi9wnbwMioAn7JvTAVJFyfaBjAXhVXRKN92ZAUPwsEEOLvAUsG8jg9JfyxsWKQO32BXFhWRidh6nut9p0+XKyhqVADiQdbQvXHAx1EiRtAFDWty1/qeCXzpmCazBNbZA==
Received: from SEZPR01MB4301.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::5) by KL1PR01MB5736.apcprd01.prod.exchangelabs.com
 (2603:1096:820:10e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Fri, 5 Jul
 2024 03:33:28 +0000
Received: from SEZPR01MB4301.apcprd01.prod.exchangelabs.com
 ([fe80::40ec:96e8:ebc2:2872]) by SEZPR01MB4301.apcprd01.prod.exchangelabs.com
 ([fe80::40ec:96e8:ebc2:2872%6]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 03:33:27 +0000
From: =?iso-2022-jp?B?GyRCMEtGIxsoQiAbJEJCQEA2GyhC?= <taisei1212@outlook.jp>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>
Subject: [PING][PATCH] hw/intc/ioapic: Delete a wrong IRQ redirection on I/O
 APIC
Thread-Topic: [PING][PATCH] hw/intc/ioapic: Delete a wrong IRQ redirection on
 I/O APIC
Thread-Index: AQHaxvexsisMgUUJlkSRN/8Sl71JD7HniWYq
Date: Fri, 5 Jul 2024 03:33:27 +0000
Message-ID: <SEZPR01MB43019C6C7D242A7A18B9C0B6A4DF2@SEZPR01MB4301.apcprd01.prod.exchangelabs.com>
References: <TY0PR0101MB42850337F8917D1F514107FBA4D52@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
In-Reply-To: <TY0PR0101MB42850337F8917D1F514107FBA4D52@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn: [mxv7y7BQ00ZdnUnobWr054exya4/XMvI]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR01MB4301:EE_|KL1PR01MB5736:EE_
x-ms-office365-filtering-correlation-id: 4df030d4-de01-4933-94dd-08dc9ca33b86
x-microsoft-antispam: BCL:0;
 ARA:14566002|9400799024|8060799006|19110799003|461199028|102099032|440099028|3412199025;
x-microsoft-antispam-message-info: G8Jt6RtRL48xms4UnsDg4Vcjs1elDSmiRRX5jCOMrGg9PKzMn90n0xn47y1HxhyPsjP+IJqkKfv/E/u9VlrYW7e9prX6i6g6YZ5JJsXVZz5ld9AZS16vjGY6VDW8I1InP/+vNlHeYyh+hqQUaTAM3fKSKiKGfNW/hLFJsFkscGi7BbyqoqQydjxsrggvURVwb3Xz0M+pxzodRVND+mpwHhsl+y8X6O3MjTgith6JIJcWOXF6pHImLSwHt2nPYVhc3r0B3g09R0UogHy71S+WGZobGVuCD2B/lrWgRVT4QgcHoMVVjCXSb+KVYsx2nNHTmUgwiREPyABX1WzdzpPPtWXYWOUzy01zXTvOutUsta5V77GiQIctmZ21NLW/xttPIv+AIALXgiyIYeVd1s2XB/wdgD934CmTzWfhh+Lm6YlJI0AjJnW8lR1wABpivuLlaREHUVA7/ytEVOWd3+cjNWyUCGtkcnCOaNTlHdT8I5pJGYtCe6b+QMw0fVJrM2z+JlxkoAcuCtjEsQODseNVELxLO6EVZn9IurjWWvZb4MZc9HSiOejRCH1qS4Mlj6N0eYNzrez3TFTOiad/iXtHOhxw0M2t8Wn5hdB3nkb1VBu0J8cLIz81qXMhX6Bft9ZqsRo3YDagaYdrmkBH09hnYA6fscbpw+d5MAdNmTjBi+HBJqEdkd7XQPwkWluTHKtRz3tkuafmWi46D/ElwGu7YLjHaMlyXc0Nm4VYadtiywA=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?SHE3bDU4c01iOUZCNDg0Zzc5Tlp0NWM5ajdDMkk5ZWhXa05janBWend4?=
 =?iso-2022-jp?B?U0lMQ21wcmdMWm5TUHU3cVplYm8xbTBKRkh2dHVDb1ZCRkU0eEF2Ymdj?=
 =?iso-2022-jp?B?TzUzcTRQUmNOTVNYVWVuZCttRGhlRDJ3NnJHSUo3ZzJZZ3FGYWFJQnFC?=
 =?iso-2022-jp?B?WGU0bEtOU0hOR1p3bkkvU1BXMDYyN05DaG9tRHJkR0hYeW93TmlsWDMr?=
 =?iso-2022-jp?B?d09pWVdGWittaTQ4QWdEZmcvSXU5MUZUZW9ub2kxaFB0WWlya1NZZEpn?=
 =?iso-2022-jp?B?YlE3dG1LZ2hFZVl6dXpMUmlLMHVteGVoNDVucWxQUnRneVZKbFVnMitq?=
 =?iso-2022-jp?B?Yk9zQVpnOTRCS0V6U0pMTGl5akRNQ0w4UFRkWUlMREpXenJGSWhvUWc5?=
 =?iso-2022-jp?B?K2JXSEJtbDQzN3RJNW1JVzdHSHJVMWRCMW5xLzVVaUJncVpmck5DT3lY?=
 =?iso-2022-jp?B?eHN2TWx2ejl3QjJSNFBYUHBQdGFpZytwM3c1cnBxcG5GSmxoVGpuQnNi?=
 =?iso-2022-jp?B?a0QvUGtXVURXZnBvdlZaTXdmN1l1RnpoZ2ZhT1R6emVleDNJV1dOR0FS?=
 =?iso-2022-jp?B?TU9ocE5xQ3BnTTFsaXZjSnBMRGl0ZFZWbmJKV20yYkgyU21OT3BRMFBz?=
 =?iso-2022-jp?B?dUFlTko1b3I0UFJ1TVEvZFpNUFlVenlRZC8xWlMvT0l2MWdpZ1ArRHpM?=
 =?iso-2022-jp?B?bjNqckFycWFOQnVsSnlYSFUyanV2Rnc4T2F4YitPRUFIdnRQcG8xLzd1?=
 =?iso-2022-jp?B?ck9QcXdGRlcrMEpMZmZkZnpoUTJ4U3RFcElHZWh0bi9HZTFJWUIweFAw?=
 =?iso-2022-jp?B?VHZhL2dxZjNSZzRxMkdrQWh2ckR2aDRyOTc4OC9Cc3VtaTlLdlpHRm1t?=
 =?iso-2022-jp?B?T043N2w0dEdBdmdLRk1vcTBWWGNUWmRnbnh4V2V0VDhZajBiV01iVG9B?=
 =?iso-2022-jp?B?MnF4TDgybTZ4UkFDWlRHOHkxV2QranZjVXF4RFZPOGwrUzBxZmtlY3lj?=
 =?iso-2022-jp?B?aWJZREpYaVdlM1paQmNZL05BSDFpUmFSck5hZG9IcTc4MzZ3WWpkRnJ4?=
 =?iso-2022-jp?B?K210K2U2QkszajcydGVjN2Q4T01weW5LdVRpUXJmYTRaMit5VGlPUVFJ?=
 =?iso-2022-jp?B?RXpNSUM3WUF5Wm5EOTZrMUxFV09HQXdrbUVnaUZheTlSakNrSUxHZkgy?=
 =?iso-2022-jp?B?d2JYK3YvSFRXdHFJVko4Z1dpMzhkU3hVZTZEUHQ0ZWtscWFkVDFmRnlG?=
 =?iso-2022-jp?B?Vk5XZkhEK0Z6WVBkdG1VUCs3ZmxTZnlraGp0YmZ2SHY1ZnZJc3F1cENi?=
 =?iso-2022-jp?B?VmF0VG1ERmxOUmpPcnBzVUJCblI3dXFRUFpQWmNaMVdjbHFqeStrVUFI?=
 =?iso-2022-jp?B?MTRjS3lCRllTblZqdHVJMGdPTVNUTXhUK3BES2hnSW00Ui9rSEFHOWVw?=
 =?iso-2022-jp?B?R3p5WFM5NFlUb0VPRGY1bUU4YlltWnFORTBHY0hZejNQT05mQitrbWxa?=
 =?iso-2022-jp?B?MHhsU1Y4VU00dVhxeVhaaU0yay9hYUVLVTlJUGZrUnppc2thZVYzS3Ar?=
 =?iso-2022-jp?B?WWMvS1BnU3cxTUFJdXcxelc1OFQwazlTWXpmWjBsSmZaSklKKzhtemlU?=
 =?iso-2022-jp?B?SnJacm92VDBRYWVjWHZWaU1reVJBWFNnMm5UNVF6V1ExRFgyWlEveXYr?=
 =?iso-2022-jp?B?N1ZQeEQ3aGFEWWlLVXVudE1UMFFVbFMxQUhVNFBFWmhZN1M2K0VMT0RK?=
 =?iso-2022-jp?B?RUZBeE1qUS9PbkVhSjhpQlE2c2xtd3lRdkNycEpDYzZnWmdHSGFnNWs9?=
Content-Type: multipart/alternative;
 boundary="_000_SEZPR01MB43019C6C7D242A7A18B9C0B6A4DF2SEZPR01MB4301apcp_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-b4c57.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4301.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df030d4-de01-4933-94dd-08dc9ca33b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 03:33:27.1680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5736
Received-SPF: pass client-ip=2a01:111:f400:feab::80b;
 envelope-from=taisei1212@outlook.jp;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

--_000_SEZPR01MB43019C6C7D242A7A18B9C0B6A4DF2SEZPR01MB4301apcp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

This is a ping to the patch below.
https://lore.kernel.org/qemu-devel/TY0PR0101MB42850337F8917D1F514107FBA4D52=
@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/

________________________________
=1B$B:9=3DP?M=1B(B: TaiseiIto <taisei1212@outlook.jp>
=1B$BAw?.F|;~=1B(B: 2024=1B$BG/=1B(B6=1B$B7n=1B(B25=1B$BF|=1B(B 21:03
=1B$B08@h=1B(B: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
CC: pbonzini@redhat.com <pbonzini@redhat.com>; mst@redhat.com <mst@redhat.c=
om>; TaiseiIto <taisei1212@outlook.jp>
=1B$B7oL>=1B(B: [PATCH] hw/intc/ioapic: Delete a wrong IRQ redirection on I=
/O APIC

Before this commit, interruptions from i8254 which should be sent to IRQ0
were sent to IRQ2. After this commit, these are correctly sent to IRQ0. Whe=
n
I had an HPET timer generate interruptions once per second to test an HPET
driver in my operating system on QEMU, I observed more frequent
interruptions than I configured on the HPET timer. I investigated the cause
and found that not only interruptions from HPET but also interruptions from
i8254 were sent to IRQ2 because of a redirection from IRQ0 to IRQ2. This
redirection is added in hw/apic.c at commit
16b29ae1807b024bd5052301550f5d47dae958a2 but this redirection caused wrong
interruptions. So I deleted the redirection. Finally, I confirmed there is
no problem on 'make check' results and that interruptions from i8254 and
interruptions from HPET are correclty sent to IRQ0 and IRQ2 respectively.

Signed-off-by: TaiseiIto <taisei1212@outlook.jp>
---
 hw/intc/ioapic.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 716ffc8bbb..6b630b45ca 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -154,15 +154,8 @@ static void ioapic_set_irq(void *opaque, int vector, i=
nt level)
 {
     IOAPICCommonState *s =3D opaque;

-    /* ISA IRQs map to GSI 1-1 except for IRQ0 which maps
-     * to GSI 2.  GSI maps to ioapic 1-1.  This is not
-     * the cleanest way of doing it but it should work. */
-
     trace_ioapic_set_irq(vector, level);
     ioapic_stat_update_irq(s, vector, level);
-    if (vector =3D=3D 0) {
-        vector =3D 2;
-    }
     if (vector < IOAPIC_NUM_PINS) {
         uint32_t mask =3D 1 << vector;
         uint64_t entry =3D s->ioredtbl[vector];
--
2.34.1


--_000_SEZPR01MB43019C6C7D242A7A18B9C0B6A4DF2SEZPR01MB4301apcp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Meiryo, =1B$B%a%$%j%*=
=1B(B, &quot;Hiragino Sans&quot;, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
This is a ping to the patch below.</div>
<div class=3D"elementToProof" style=3D"font-family: Meiryo, =1B$B%a%$%j%*=
=1B(B, &quot;Hiragino Sans&quot;, sans-serif; font-size: 12pt; color: rgb(0=
, 0, 0);">
<a href=3D"https://lore.kernel.org/qemu-devel/TY0PR0101MB42850337F8917D1F51=
4107FBA4D52@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/" id=3D"OWA90a0c=
7b0-04b5-6fd9-ca55-d9ac14856663" class=3D"OWAAutoLink">https://lore.kernel.=
org/qemu-devel/TY0PR0101MB42850337F8917D1F514107FBA4D52@TY0PR0101MB4285.apc=
prd01.prod.exchangelabs.com/</a></div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>=1B$B:9=3DP?M=1B(B:</=
b>&nbsp;TaiseiIto &lt;taisei1212@outlook.jp&gt;<br>
<b>=1B$BAw?.F|;~=1B(B:</b>&nbsp;2024=1B$BG/=1B(B6=1B$B7n=1B(B25=1B$BF|=1B(B=
 21:03<br>
<b>=1B$B08@h=1B(B:</b>&nbsp;qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org=
&gt;<br>
<b>CC:</b>&nbsp;pbonzini@redhat.com &lt;pbonzini@redhat.com&gt;; mst@redhat=
.com &lt;mst@redhat.com&gt;; TaiseiIto &lt;taisei1212@outlook.jp&gt;<br>
<b>=1B$B7oL>=1B(B:</b>&nbsp;[PATCH] hw/intc/ioapic: Delete a wrong IRQ redi=
rection on I/O APIC</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">Before this commit, interruptions from i825=
4 which should be sent to IRQ0<br>
were sent to IRQ2. After this commit, these are correctly sent to IRQ0. Whe=
n<br>
I had an HPET timer generate interruptions once per second to test an HPET<=
br>
driver in my operating system on QEMU, I observed more frequent<br>
interruptions than I configured on the HPET timer. I investigated the cause=
<br>
and found that not only interruptions from HPET but also interruptions from=
<br>
i8254 were sent to IRQ2 because of a redirection from IRQ0 to IRQ2. This<br=
>
redirection is added in hw/apic.c at commit<br>
16b29ae1807b024bd5052301550f5d47dae958a2 but this redirection caused wrong<=
br>
interruptions. So I deleted the redirection. Finally, I confirmed there is<=
br>
no problem on 'make check' results and that interruptions from i8254 and<br=
>
interruptions from HPET are correclty sent to IRQ0 and IRQ2 respectively.<b=
r>
<br>
Signed-off-by: TaiseiIto &lt;taisei1212@outlook.jp&gt;<br>
---<br>
&nbsp;hw/intc/ioapic.c | 7 -------<br>
&nbsp;1 file changed, 7 deletions(-)<br>
<br>
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c<br>
index 716ffc8bbb..6b630b45ca 100644<br>
--- a/hw/intc/ioapic.c<br>
+++ b/hw/intc/ioapic.c<br>
@@ -154,15 +154,8 @@ static void ioapic_set_irq(void *opaque, int vector, i=
nt level)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; IOAPICCommonState *s =3D opaque;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; /* ISA IRQs map to GSI 1-1 except for IRQ0 which maps<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp; * to GSI 2.&nbsp; GSI maps to ioapic 1-1.&nbsp; T=
his is not<br>
-&nbsp;&nbsp;&nbsp;&nbsp; * the cleanest way of doing it but it should work=
. */<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; trace_ioapic_set_irq(vector, level);<br>
&nbsp;&nbsp;&nbsp;&nbsp; ioapic_stat_update_irq(s, vector, level);<br>
-&nbsp;&nbsp;&nbsp; if (vector =3D=3D 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vector =3D 2;<br>
-&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (vector &lt; IOAPIC_NUM_PINS) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mask =3D 1 &lt;&l=
t; vector;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t entry =3D s-&gt;i=
oredtbl[vector];<br>
--<br>
2.34.1<br>
<br>
</div>
</body>
</html>

--_000_SEZPR01MB43019C6C7D242A7A18B9C0B6A4DF2SEZPR01MB4301apcp_--

