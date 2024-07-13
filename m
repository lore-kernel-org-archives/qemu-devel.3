Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7164DC3DA45
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2024 12:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSbTg-0003HW-Un; Sat, 13 Jul 2024 08:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sSbTe-0003GF-9c
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 08:03:46 -0400
Received: from mail-sgaapc01olkn20827.outbound.protection.outlook.com
 ([2a01:111:f400:feab::827]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <taisei1212@outlook.jp>)
 id 1sSbTb-000850-Rh
 for qemu-devel@nongnu.org; Sat, 13 Jul 2024 08:03:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyj+qb1p624m3GyWOrzhoOqwpOUBiMOxNvKSwIyvByxOyGyADhaOSPbqV1ZY2oS/Q1mNOzu9AIAP7g4yrzTp2Ha8c6gGr0NRkSPwjJ+1JJamdTQI88QojjTSPEJW7RB+tbnOke2zL0yVGaZUAA4FuX3G/fVpV472gODFNOHiOBT4ui5x0bX4uLTyGDGnRh2Jpi3nuTwG10C1U8fvhchp0B+Qh9W5qHidKlN0iL+2ceIIYX64EsKtmYDciyq1JeucnDlMIolcZ8zVz09wS0S3Jy8A9AOSEvg3dV2tjOFVLr4pha+5PCLB+uapR4+4/DEql9fXvOCMXXVhWL9v1gwnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwpK0PGp56uHEoPbStgypFeG3VCVqPjw+iv6uDzI/Ss=;
 b=LTRuUH426FKjkq+lFxM/sR8h7vlniwJrRmB+vxQVgFkL7Y+JXbN68usKO5BdAC7/dJmsEvGPdoX0TY6Oz1Ae2Stl1+cn/dAbj4mGL/bWznoKbKZSBJ7Y8zX6kO5dBGYCN/Mh7mQP3KAPKwdhjJkbiZbj1bs+mm7jrvsJ9/8fBZ40OegC1IWWvwTTgm2QK1ejgpHCQZWPM2tBJyn0dr2z9unBtzru/3hmqAcrf2XimplnDHxMPuct4K2YoG5JksjzvWaufYbGTMpkEZx6S49vN+Gbt5Tum7pd1x0dOsuq4eC2WM6cW44oTgMW5qxjMablriAKDcl8v5E1vFyY2kywaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.JP;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwpK0PGp56uHEoPbStgypFeG3VCVqPjw+iv6uDzI/Ss=;
 b=DQewFya5aM49l0ub4+2+/Vlg6nM1xxMWvBbo6ItuA9uPyjyi3EZOCLcNY3GDUjulqJPxRkFpfoqFzsvdWURX/xvNuFb3vfCxAyn+fbg1cv7RW7Rw+0qitVG3HfYIhvmurnCMQ/oFbmXC5alEEO8TJe/ogo2+7K8/XfULCYn4dbnyzSW3QIT9uwTatg6054mCsMB6/JHNKO1mHzHc1ogoHYruWAKf2reRjmcNgV2u2QZAu4QNQC4539itep3UCZcJOCXv297HrWv4azbceHxqBqh2NYGqoQxIohlEFBcXwUL0h2u7tcMTt0gXZniri1/5X1ukc0z18c01nYgDj6kbAA==
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1b0::11) by TYZPR01MB5454.apcprd01.prod.exchangelabs.com
 (2603:1096:400:41e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Sat, 13 Jul
 2024 12:03:36 +0000
Received: from TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35]) by
 TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
 ([fe80::85c5:f6c5:8a81:ee35%6]) with mapi id 15.20.7741.042; Sat, 13 Jul 2024
 12:03:36 +0000
From: =?iso-2022-jp?B?GyRCMEtGIxsoQiAbJEJCQEA2GyhC?= <taisei1212@outlook.jp>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>
Subject: [PING^2][PATCH] hw/intc/ioapic: Delete a wrong IRQ redirection on I/O
 APIC
Thread-Topic: [PING^2][PATCH] hw/intc/ioapic: Delete a wrong IRQ redirection
 on I/O APIC
Thread-Index: AQHa1RywQiuKMOR1Ok+VgKWEKjnrmg==
Date: Sat, 13 Jul 2024 12:03:36 +0000
Message-ID: <TY0PR0101MB4285A7F9CE0D5A5F07FB674CA4A72@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
References: <TY0PR0101MB42850337F8917D1F514107FBA4D52@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com>
 <SEZPR01MB43019C6C7D242A7A18B9C0B6A4DF2@SEZPR01MB4301.apcprd01.prod.exchangelabs.com>
In-Reply-To: <SEZPR01MB43019C6C7D242A7A18B9C0B6A4DF2@SEZPR01MB4301.apcprd01.prod.exchangelabs.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [LBvOzIUT+QV8Osl6kuAE41GNHRb4cNWi]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR0101MB4285:EE_|TYZPR01MB5454:EE_
x-ms-office365-filtering-correlation-id: dbe08571-58ab-48cb-cfc7-08dca333d365
x-microsoft-antispam: BCL:0;
 ARA:14566002|19110799003|9400799024|12050799009|461199028|8060799006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info: HzYdZjHFjrPD2Vp/i40EtE88Ka9TvdOHIDWMkq5fOF8Q5+hSpDyTLygZSeDBicL2b/DsBfLvnQJkZuwW3ys9C6jE9ENBWq5qXwFKUSu1unXg4AXAoOhQ4DOagdROLcGffW22igXedmi9AYXLevZenbXTFemNY2Bo2H54DQp+ddW4ynmaxznsOAArdi9O7PoG/EGF6tJDcMPfkrpv/zeNMVTEf7x0dqT0jNFl8VlDaEBcpsJ/+4NrS1qc/GLcDL5dVm8v7UG4sngk220aQhLr8t0ytR30AWDREYtQJHC6fb14wOvqW4YhOiTgZEPmb3tWeKd84y0hwy3nQPPdounB13RSZ4PpiSikoeOqP4k1lu144CoxasSNH1x/yuTylR7h/5JClKC27y35IsJwBC3s2vwa/z5IQzAfHUb7xXT8VulaPSjmEnHw8YEL6pAxL6Ag0kizjSPIUJcDtGxEqKy8Q/oQ6fxofNyJPqcpD5kEaOXh4PEd5+Mp3AGnqxj9M50dRolrEzl9cARx5N9ftEJ2KXLEw0vIuBmoPTxlQkk1ItT6BvxgbQKTvVIgsQAyigEDDo+voaCgS1M463d7aZ8fVxYg6krzWNYaoo4Xqsx20JQNX5uy1myPfGaOQ+qS9dnB1cQp1JSEdd/eY6uTZ0Ci9JFN5x/wv/zvlFUcFXUqlLzRMOyYS3tRRuQqEsTgxnakYWeT3vNvqD0MUqzMG/uA8HX6vNcs4FYl5Dkrea7z/+wlvO0vGHX/6IxXxHNH1/lg
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?V285azh5RUViUzdTV0JTdERpUjJ3aytnUmU4eEF5MkhqamNNUEFqanlZ?=
 =?iso-2022-jp?B?czRzSit3V25VRnlwZEtUeThEOTBYd2FsTW9ncml6bElhVUNRSm1zalR3?=
 =?iso-2022-jp?B?ampMekRHSCtJRkxNcGExYkUweE5hdW1kT2c4blRGQ2l6TEJFS1RsTHNF?=
 =?iso-2022-jp?B?d1ovb3E1NHRaeVczaGlrREVSejVUdmd4ZWgxWjJOSHJseDJDbHgwYmNy?=
 =?iso-2022-jp?B?L0JIRzRUV1pNZXdheG1MUTlaYlE1ZEo2WE16cHA5cmtBTUUrbkd2MEdx?=
 =?iso-2022-jp?B?NWRUNXd3ZHdkT20vVFFDUDNHeFpiazJHd0RsWHBkMk9KR09IWG1lTE03?=
 =?iso-2022-jp?B?aDJYQmY0RW5LK1pUQVc1TmhheG5QM2xNbWJYempGN29adk9uNXRUd0hX?=
 =?iso-2022-jp?B?SGpHbVNJR3lJQXl0aUdzaUJncjBjcXFzYlU5dCtTQnhmdC9QSDdvOTFh?=
 =?iso-2022-jp?B?TjR5R3p5UVN1bFNhYjhPenFoeHhyYXliZUdGMUt1WFhsT21wWUxjTFdB?=
 =?iso-2022-jp?B?VXBMbEJtZEJNdkhtc2hoWUgwbU9MRWpUMkl2MEdCQUFtOUFzeE5PcHhm?=
 =?iso-2022-jp?B?K1QydmtEdnFWemQwRGVORkE1S0pOT1VuYmIvdE5jMWlGOFBGR1pTdDRy?=
 =?iso-2022-jp?B?SjNxTCtmcjFFM3hxazhNci84UDE4WEgrdTNrVXMyL3Y2UllUalEraUt0?=
 =?iso-2022-jp?B?SSthTHBNdnd4UzJJZ05NNWd2UTFUT3lkRVV0bWhpSmc1UzJEY1RLaGts?=
 =?iso-2022-jp?B?RG5Sa2Z5SHZvMTRiRWhXazJLcTNEL245cEZ3d256dlJEck5SMDZyK3JQ?=
 =?iso-2022-jp?B?ek5TVG5TcHpNYUdqMWhmN29MQ0FBbUY0Q3JNaUIxYmxWRkZkcW5EMkpD?=
 =?iso-2022-jp?B?TTgzeFpOL2JBUnRvcTJJQ2FOR3V5Q29LVDdrSjdJOXRuVklTNWkyNEx4?=
 =?iso-2022-jp?B?OVV3cmJsckpDU3RFZ3BianFJRFovWG9tQWN3b0pPbjFPR2phSGNqbXJa?=
 =?iso-2022-jp?B?dWdXbFdLdkNPanJ5VG0zbjFBdTlJWU5CdWRUOXZOM29aRWY5QUo4VG0r?=
 =?iso-2022-jp?B?OEtDTDhQcmZTNnFTbXJaZ3dEZjBZQXF4eldrZiswWUJDNWlQcDk5L2pF?=
 =?iso-2022-jp?B?dENTTVg0Ri9JSkdkcHhQdXVrZU95WmdiTUh3U2FQZDNtc2dGbFZNeFAr?=
 =?iso-2022-jp?B?RGlHTUxnaldOR2Y2d2FOWGVXTHpYTnU2c1VSWUNKemhINVh3L3hxdjlI?=
 =?iso-2022-jp?B?MHI0Y1ZMNE8zUVdHUm5jL2ZyMWJ6VTQ2bUMyVnUrbzNzcjZheHNody9O?=
 =?iso-2022-jp?B?OVo3K1ExdlMyaGhsODZCZ0RGaEh2NEh2djl0MjY0TEhpMWQ0bGtqRHhG?=
 =?iso-2022-jp?B?eG9uMTFHUkN5a1l5OWNCQVVtQXA3T0xJclpZdWZkdTlncS9VaTdGaisx?=
 =?iso-2022-jp?B?K0NmbkVXTVRkQXh5TDl4R04waHVERFRaMFowMFZaUnRManMyQXJ4ZVMr?=
 =?iso-2022-jp?B?em94aWtnMG5TWmV5YW8xYWZZMkFERE1Tcmp2NFNWK3RhWmNQSVF0UkFr?=
 =?iso-2022-jp?B?OFlaWXFmczNYcm5qdklSSHYvb2lacXFCNlBvcnVPRkdsYm5MaEszOEc5?=
 =?iso-2022-jp?B?eVlZemlyWm55VE9oQUYwbGNwUWpGU0ZqU0poR3NHZFF0eCs0T1VyT0xU?=
 =?iso-2022-jp?B?VVFncXJNdHhtRUN5ZE53T3FzTlNWc2xBY2ZvRTlkNnJaQjlYV2NJZmlY?=
 =?iso-2022-jp?B?NHhSZXlFcGUrcDhVZjJhR2NuNDQ4NlVndEM4VnJoUStWSXJ4MVlyd1k9?=
Content-Type: multipart/alternative;
 boundary="_000_TY0PR0101MB4285A7F9CE0D5A5F07FB674CA4A72TY0PR0101MB4285_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR0101MB4285.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe08571-58ab-48cb-cfc7-08dca333d365
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2024 12:03:36.4639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5454
Received-SPF: pass client-ip=2a01:111:f400:feab::827;
 envelope-from=taisei1212@outlook.jp;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_TY0PR0101MB4285A7F9CE0D5A5F07FB674CA4A72TY0PR0101MB4285_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

This is a ping to the patch below.
https://lore.kernel.org/qemu-devel/TY0PR0101MB42850337F8917D1F514107FBA4D52=
@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/

________________________________
=1B$B:9=3DP?M=1B(B: =1B$B0KF#=1B(B =1B$BB@@6=1B(B <taisei1212@outlook.jp>
=1B$BAw?.F|;~=1B(B: 2024=1B$BG/=1B(B7=1B$B7n=1B(B5=1B$BF|=1B(B 12:33
=1B$B08@h=1B(B: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
CC: pbonzini@redhat.com <pbonzini@redhat.com>; mst@redhat.com <mst@redhat.c=
om>
=1B$B7oL>=1B(B: [PING][PATCH] hw/intc/ioapic: Delete a wrong IRQ redirectio=
n on I/O APIC

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


--_000_TY0PR0101MB4285A7F9CE0D5A5F07FB674CA4A72TY0PR0101MB4285_
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
<div class=3D"elementToProof" style=3D"direction: ltr; text-align: left; te=
xt-indent: 0px; margin: 0px; font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot=
;Hiragino Sans&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
This is a ping to the patch below.</div>
<div style=3D"direction: ltr; text-align: left; text-indent: 0px; margin: 0=
px; font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&quot;, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://lore.kernel.org/qemu-devel/TY0PR0101MB42850337F8917D1F51=
4107FBA4D52@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/" id=3D"OWA54c20=
d07-a939-c4be-629e-f60a909c3e68" class=3D"x_OWAAutoLink" data-auth=3D"NotAp=
plicable" style=3D"margin: 0px;">https://lore.kernel.org/qemu-devel/TY0PR01=
01MB42850337F8917D1F514107FBA4D52@TY0PR0101MB4285.apcprd01.prod.exchangelab=
s.com/</a></div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quot;Hiragino Sans&=
quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>=1B$B:9=3DP?M=1B(B:</=
b>&nbsp;=1B$B0KF#=1B(B =1B$BB@@6=1B(B &lt;taisei1212@outlook.jp&gt;<br>
<b>=1B$BAw?.F|;~=1B(B:</b>&nbsp;2024=1B$BG/=1B(B7=1B$B7n=1B(B5=1B$BF|=1B(B =
12:33<br>
<b>=1B$B08@h=1B(B:</b>&nbsp;qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org=
&gt;<br>
<b>CC:</b>&nbsp;pbonzini@redhat.com &lt;pbonzini@redhat.com&gt;; mst@redhat=
.com &lt;mst@redhat.com&gt;<br>
<b>=1B$B7oL>=1B(B:</b>&nbsp;[PING][PATCH] hw/intc/ioapic: Delete a wrong IR=
Q redirection on I/O APIC</span>
<div>&nbsp;</div>
</div>
<div style=3D"direction: ltr; font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quo=
t;Hiragino Sans&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
This is a ping to the patch below.</div>
<div style=3D"direction: ltr; font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quo=
t;Hiragino Sans&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://lore.kernel.org/qemu-devel/TY0PR0101MB42850337F8917D1F51=
4107FBA4D52@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/" id=3D"OWA88a56=
f57-845d-f21e-759e-204afba01d75" class=3D"x_OWAAutoLink" data-auth=3D"NotAp=
plicable">https://lore.kernel.org/qemu-devel/TY0PR0101MB42850337F8917D1F514=
107FBA4D52@TY0PR0101MB4285.apcprd01.prod.exchangelabs.com/</a></div>
<div id=3D"x_appendonsend"></div>
<div style=3D"direction: ltr; font-family: Meiryo, =1B$B%a%$%j%*=1B(B, &quo=
t;Hiragino Sans&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"direction: ltr; display: inline-block; width: 98%;">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri=
, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>=1B$B:9=3DP?M=1B(B:=
</b>&nbsp;TaiseiIto &lt;taisei1212@outlook.jp&gt;<br>
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
<div style=3D"direction: ltr; font-size: 11pt;">Before this commit, interru=
ptions from i8254 which should be sent to IRQ0<br>
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

--_000_TY0PR0101MB4285A7F9CE0D5A5F07FB674CA4A72TY0PR0101MB4285_--

