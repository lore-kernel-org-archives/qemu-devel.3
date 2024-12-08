Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0F4E77173
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 14:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKIDn-0000mm-59; Sun, 08 Dec 2024 09:25:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Mellurboo@outlook.com>)
 id 1tK54E-0006qA-Du
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 19:22:34 -0500
Received: from mail-am6eur05olkn2078.outbound.protection.outlook.com
 ([40.92.91.78] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Mellurboo@outlook.com>)
 id 1tK54C-0002Ut-Kz
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 19:22:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJMirdpVStPqKoucTWPBKXiuVX021HLG+KPF3gqzNoEz+HEjYmTmrofVtZT8MV8sV9neOcCg4xxebwxJG62LrJtuJ6LkT/G7oXgG7EmgESk4PtXhGdcu+6Vmflz3ZbJoyQ765tqekzA9l+osbPQqRil+1/jzuWXpe36y+7NaBq9UbEV23IOKGp7MAtLp32WB2MoxVGOxPpQUEXL94ai1qcSOW2bRdxwe89zpH06Lb+tBpliSZunyAT837UiS5rM4M73HR9tfm2BDN8Ej6jc6HrKep1M5mfP4pptY6iecv84qjFdB6X0Ab4g2SI8BA21SawtAmk2fwRxMkjMxR9LuNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdX3dV4NltTKmTmMcWuAhfevxecgPqXSV12kqxlTaTo=;
 b=QTJBGKSS1/7WEzGrNHcP5QkY2u6A7MOgwylQSOqiS2ngQd0iKYiXuwot+e0azFAWyd8pPfOvbsTlw4vGHcANH4J2Zz0BYMo5szIfZFaLeuLGPIS06sMomIZxQe4DGgf9rcrGrUytjMUeISoGvuycIf0E2pV1V9ftHdFlRZkb1IIZf2bFfHkFaIs3cT5f0C8mLXW2iEpqoGf307OzNaqUPiO88+K1qyBysQsp+gxtepflw8J03c9xl8hWHUNnUIY4GQMsl7SOSV2RY30V3bcFzrR8dXBxIEeHbuh8NuPuHW9XEp0RSjCqnrpfW0vrRBHdDrmZ6BNKSnloJ4bSZGL+ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdX3dV4NltTKmTmMcWuAhfevxecgPqXSV12kqxlTaTo=;
 b=V9b3MIs8Z3YL+Y7L0hXXvSm+pkDT2aVzExA6hbik17fwFH/vgb3+FXQDfwlzrgtVEQxHqaMww2y3268zjB8OuwcfVgbULtecgmxwmHwnydQDoXTBNdbYcOX72t1ATSCJMgiZy6OULRVVsWxXtvVKNGXWT2o96/P6l7YM1i2q+ABcjD6wq/qNXlo8W6oYdz+dnQA/8foBqpEfl8VOe0NLSQe/SPmelxcpfpyK2UjnJRxjckAnEATEHEsmDZoZLNVjHPNjsoK8p+hJOeUN6GzsCLu4hcuj5DTNGLK1/ySadrFUl7XfDRHzggKgkovs5uVlEf8T8r9Zi4nZkLfw4a+l/Q==
Received: from AS8P192MB2000.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:56d::10)
 by DB5P192MB2231.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:48b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Sun, 8 Dec
 2024 00:17:27 +0000
Received: from AS8P192MB2000.EURP192.PROD.OUTLOOK.COM
 ([fe80::f45d:9a39:d0c2:bd2f]) by AS8P192MB2000.EURP192.PROD.OUTLOOK.COM
 ([fe80::f45d:9a39:d0c2:bd2f%4]) with mapi id 15.20.8230.010; Sun, 8 Dec 2024
 00:17:27 +0000
From: Myles Wilson <Mellurboo@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Please Read: Error in website redirection
Thread-Topic: Please Read: Error in website redirection
Thread-Index: AQHbSQX0mSE+zJ9SfUibLDzvq5Y9Rw==
Date: Sun, 8 Dec 2024 00:17:26 +0000
Message-ID: <AS8P192MB200003EB31EB6CD8EF3FE6C2B1332@AS8P192MB2000.EURP192.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P192MB2000:EE_|DB5P192MB2231:EE_
x-ms-office365-filtering-correlation-id: 4ae69aaa-b801-4ba9-3166-08dd171db25c
x-microsoft-antispam: BCL:0;
 ARA:14566002|461199028|9400799027|8060799006|15080799006|12050799009|8062599003|15030799003|19110799003|440099028|3412199025|10035399004|102099032|3430499032;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?EnCo0J7Da2N3YRGo9H89HPOSONRPKTP/HwusqJDTwgHgpCXgEnuGSikDMC?=
 =?iso-8859-1?Q?jzg44GGB8+intIABlXcL+nuw0WCPv+yCSXv8QDf7OGrw+kZU258C3vs704?=
 =?iso-8859-1?Q?kHT6WaJ75Cdu8hYKnYTqOfAm9FK6kiPFi1KkUYUO5+KClDgRWT0YdqS5pI?=
 =?iso-8859-1?Q?auQ6xHWhFWe6wi5SGhBuPU/pqikIrCUg682HffxXm5MSwCTKjNdAF8zrqc?=
 =?iso-8859-1?Q?b+CrCRI5y56w1k8L+jV/UuuGIQBnm9kCd+APU5IMJB2QOOiHNC4LRSYYj0?=
 =?iso-8859-1?Q?kxxMjxlm4KFft/HW4NDnCt+TbTJlsZF/C/XM4f6jmb85GAY8sX1iJi4yaS?=
 =?iso-8859-1?Q?E9MEmvzcnZOLv/qht7s5jCbcu9gCHfZ/06KCg7xvv+gv2LMp6CrM3tvjug?=
 =?iso-8859-1?Q?L1RYDPk2y7qgqgFtT72Ez6wIHRoni/6kl50CI845iQWryx8nCSX5gSwpvI?=
 =?iso-8859-1?Q?AZGNXLq2X72MQCOqNITtOqOsxMIC26gjIPMsR42gOWwdrxD4rWVwUhlPJD?=
 =?iso-8859-1?Q?G7ZtWxitOxzP8fREURPTbOEPT+5wqv5iLqRzRtGFxEimeDh4whWIJLDO0A?=
 =?iso-8859-1?Q?iEgxeQTJzHHBcanF+NEp3XNC4VKtUO8W+T9sBV6Hy3PNgekhTgH0zDl3m/?=
 =?iso-8859-1?Q?dQe0yYcYr8Uo/cRCmRKPE5YQPy7KrHX+5y8I3fVM2ik4nV1eZE9R6lKzaS?=
 =?iso-8859-1?Q?1FJjLIllN+9CDMkXN+cKhWjMc0z1GHor46o1rKCmsssThrGndtNEwEtb0R?=
 =?iso-8859-1?Q?2HN5Gq/zaz0uFF7GDgRoMmcKC1z9t32OQ9HodMOuY1B+QYbnNFoNzeOQQ2?=
 =?iso-8859-1?Q?sGR6ibEHs05z3S6MZycxbYsDVKetEZM0hl9xldvON+OaatLyZVkNLBUncA?=
 =?iso-8859-1?Q?PB/pSCPm5sp+w3pGTmPCVeVVmpcAAkUsKjSNnRglnihFto4563Wm0tJam9?=
 =?iso-8859-1?Q?4gXDB65TYBhKACtrDJMxczw5R8nUBfiCBProJEBnS9gg6AsBGzEPSQlbD0?=
 =?iso-8859-1?Q?sflfTQFOg7SL9tXzQsBQU3DgOKOvaI6nnhJUrgarvzfJjhjNtZx0oECR53?=
 =?iso-8859-1?Q?lbiwaE9owVq6QJzXMDSXTsovJniLE9RHmgG92HDj+QFl6d4SQvqQkdKZWU?=
 =?iso-8859-1?Q?YyrRj+3xFZLxkWiG17Tu7kr+kpfbQ6gUDymcx0LIZ2XUtFEo2GwePBFvB2?=
 =?iso-8859-1?Q?O42S9MSAEdIKCg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ebk4LucqquMI+IyHis/2K3aeOKb4JAXuwfjrcO/seePjd07PP1/kx67qa7?=
 =?iso-8859-1?Q?/VUgdtkOjmLKBnnbxm+FuS3NxHXc0lNEOAeja/Zgt2txHYESYSA3zUXn+I?=
 =?iso-8859-1?Q?yzhlyoynaHPOsq1uiAVIA0FZdV9TK7Xe/+NjAbS8Dz1gGhxMisgnEtXIGi?=
 =?iso-8859-1?Q?j+t81Cd0HVn53s3c8f1vFcM3vXoBld+It55kpZMc1he/pmuzzilqcvNlgV?=
 =?iso-8859-1?Q?xZTYYIBDv5clQGiNh0go6LIfv6iTsG69u/Bw+1kaWPc1FMOd3d4lxxsRhx?=
 =?iso-8859-1?Q?qVGfGdFuksPBK7u2rS9rueTXp1wcVEUqjw1pbhM/2MkB1FM1u/QcnURTyz?=
 =?iso-8859-1?Q?ofFTLr+9r5BPThlAYTvaoWtKUz7N93xC170DGehoBbR2IMu0YoZWel1py8?=
 =?iso-8859-1?Q?TRCpsSaFbLsm1NaKsWl1/W3fWWFMc7jLj3TztsGMftb3yb2+TAIIUcEBeH?=
 =?iso-8859-1?Q?RMo+xQbtgRLtmLLOKZ0Gngeu1G2FGHa3ch2EU0eKCXQU/N/VmZTHOw5Jxw?=
 =?iso-8859-1?Q?7vxXkKDgSrigi9mhofHqZAQfZv3J4hgFE5DnKd0wb138Bqp9A6PuFWLind?=
 =?iso-8859-1?Q?BA01WyEWhg1GkcH8haE9sOeeR0fn9gnNM97M7BLKO5SyI2imRI/wdwu0tm?=
 =?iso-8859-1?Q?AAJwyHXasmb1kRcJGXfamPOt7VXrC0/DrkSDgBLd+2GjaGtymY5d1yzRM5?=
 =?iso-8859-1?Q?WnPS+ixACY47K8zmSsMytNo4EBFMG/y7TLhM7WFRymwMKPqxtdh2v4TdHv?=
 =?iso-8859-1?Q?UCaV3wbZNXyywZk95cvTIIk1bt8UE1HiEXuNw8K0hAgFeXSzE1thKFNn8X?=
 =?iso-8859-1?Q?EDU/XCX4MYkpHEtl/TN/lgzkMS0xTb0dVsZyOhz+2Cxe8NmJEggaEhI7gg?=
 =?iso-8859-1?Q?pE+4JoyHighGCBN/jUmJ8XcpwVVIZ52c02TJNlq0PzOXdL0OkNu9vxE0Ek?=
 =?iso-8859-1?Q?s49geWG7xzcOS2zl7WCZWm8pvAqFLhnlAWTGpf7e8qU7Ykb2JgpAGoB/uB?=
 =?iso-8859-1?Q?8RzVWsj3wZs48YDuutBrtjJV5/uQy4gIJ9IQr0+h9koKQRdN8lwT68Ctqw?=
 =?iso-8859-1?Q?SeXpTF+e+2XZ41mJ2PxPDXvC1rgOfdhexq9y1Uk8F2CJvBvR16/oTEIQhu?=
 =?iso-8859-1?Q?8tc8I0ZzQskPuVyRLZsIB46HandchoOkWAKfVNJYEafDpDV1jCrPiN/EHV?=
 =?iso-8859-1?Q?zTA9Hd3zJ++7hdBsgWqHLOfxsaBKhe8DSlhK37LperSHb33CRbhdRyGdMN?=
 =?iso-8859-1?Q?a14IrR3g4khaSK26RPPw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_AS8P192MB200003EB31EB6CD8EF3FE6C2B1332AS8P192MB2000EURP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P192MB2000.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae69aaa-b801-4ba9-3166-08dd171db25c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2024 00:17:26.9842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5P192MB2231
Received-SPF: pass client-ip=40.92.91.78; envelope-from=Mellurboo@outlook.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 08 Dec 2024 09:25:18 -0500
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

--_000_AS8P192MB200003EB31EB6CD8EF3FE6C2B1332AS8P192MB2000EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,
I was recently trying to download QEMU and noticed, on the landing page of =
https://www.qemu.org/, the button titled "Full list of releases"
redirects to https://download.qemu.org/ which results in a 403 forbidden er=
ror.
the same issue is present throughout the whole site with any button or hype=
rlink to see full releases (even the one found in https://www.qemu.org/down=
load/ )

I hope to see these issues resolved soon!
thank you,
Myles "Mellurboo" Wilson




--_000_AS8P192MB200003EB31EB6CD8EF3FE6C2B1332AS8P192MB2000EURP_
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
Hello,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I was recently trying to download QEMU and noticed, on the landing page of =
<a href=3D"https://www.qemu.org/" id=3D"LPlnk">
https://www.qemu.org/</a>,<i> </i>the button titled &quot;Full list of rele=
ases&quot;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
redirects to <a href=3D"https://download.qemu.org/" id=3D"LPlnk">https://do=
wnload.qemu.org/</a>&nbsp;which results in a
<b>403 forbidden</b>&nbsp;error.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
the same issue is present throughout the whole site with any button or hype=
rlink to see full releases (even the one found in
<a href=3D"https://www.qemu.org/download/" id=3D"LPlnk">https://www.qemu.or=
g/download/</a>&nbsp;)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I hope to see these issues resolved soon!</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
thank you,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Myles &quot;Mellurboo&quot; Wilson</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_AS8P192MB200003EB31EB6CD8EF3FE6C2B1332AS8P192MB2000EURP_--

