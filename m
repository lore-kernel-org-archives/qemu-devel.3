Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9BDC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 03:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7Ks-0000Lu-HV; Sun, 12 Jul 2026 23:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KN-00009K-Sw; Sun, 12 Jul 2026 23:27:32 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KL-0006V2-En; Sun, 12 Jul 2026 23:27:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEGfyAiyohDjna5OTgYnQiSkK59UCdCblS3oFfmSBsMIfWaQMGVekf4Em8tHAZ2fGS7SjkK3VWjNeBs4t04qm5ztajM/QIINi0sYcKxgwxiOWKlUnWtoHyzffzQwHlJM+VB+vpiYozwC3GAvSo48HCZiC3p/hHByG7poHv27t47hWeLckQzlrqurdFN8i6v2apX5HrZbw1f46WrG/Ck8mmd+7w0v/ixbGQwHFyhaLBfRGosG5kPA4yQnmoOgISFcZ7Y9BuAGVIbPrtNPcblTu1fzjaKvRwLJFzDNSMPYflPGbOLaHU8n7G3BbVzAq9Hz0lGt3ssZkBXpSTmU/joFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHuTUQFaUemiO7M6T0aQ3M6RpoCwRYz34NGmlsXO/IE=;
 b=sHi5O2Yk3l/tobf6a6iCw/voVqkHz8iqTqiBgXzEveByuqVKHLZmmWpJamLXfc+BlHLXIO9v/vxiIdi3FuWI7vN4dLcn0hAJAKB4hMueeUD/9oYxeddZ26rOmuLj6ejEldbEqrnqM0jlu5kVrM4hFHbuRZDuQ9LP+rByOy6ihuhQZV1V6IzwyOiZDT6gv7DyJ34ow9NrV3ZXkmzw3b9bbyDxtWg+7j/NgP1i74w2nezIrNfO4THnMBEdzU5poxJ2Jy7Nd8mqGbK7AuOnxfc7CHjDrv431V6YjZACQZ+1H2tgXVNHKdLmQ3z6y2a6tMgw5X2jn/i7cT8DgNb1qaKgIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHuTUQFaUemiO7M6T0aQ3M6RpoCwRYz34NGmlsXO/IE=;
 b=pRGQJmXc1uyIcQF6ZI3aKfMOA38iylVnuslIOL7SWEztvSuXGjw5lXgDXA9rYmCPBo6s4y/yn5ONIULWx4T2zWn5yrL5jbASQFZL2nplFwyAanzWTqQQ2M0tt1+utOmA0ILAZnCn5A5MxYK7WZw1I6DOKkEcV4aURxVKu0yMLYbnhOyhtXJ5NaM7bNH8ayjgw8qDSWEKKFEYSDEU/+TpJZyOFBUR0DLye/lkXQoGIDnoKDGu2dtmFHE9Ern0KnfhS4CD7ABo/tbcyMsv2trXzV8sHvxC5xfM3x3GdadF5KlwQ6ZF85ag1Kj/YzyQfXm0lCdvVouLjCk4fHd5BTa2uA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB8221.apcprd06.prod.outlook.com (2603:1096:101:2f1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 03:27:16 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 03:27:16 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, Zhao Liu
 <zhao1.liu@intel.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>
Subject: [PATCH v7 07/10] hw/usb/hcd-ehci: Add ctrldssegment-default property
Thread-Topic: [PATCH v7 07/10] hw/usb/hcd-ehci: Add ctrldssegment-default
 property
Thread-Index: AQHdEneAIZiidgj220ul5tIgxpu89g==
Date: Mon, 13 Jul 2026 03:27:16 +0000
Message-ID: <20260713032704.3583103-8-jamin_lin@aspeedtech.com>
References: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260713032704.3583103-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEYPR06MB8221:EE_
x-ms-office365-filtering-correlation-id: f8bcfe2b-36ba-4bb0-d7ed-08dee08ea350
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|38070700021|56012099006|921020;
x-microsoft-antispam-message-info: yYeqHMS1JFoUdoNREEfWuSW0q7NIijd6AX6y5+Q6VLUDn2GmSu6zlI0e4EQ5Orl85rKDMiZtbWjmShK3BSvA+8ycF04LoHT4FSGaJPPaELDHPihaToyNfeH8C0oWqDuZzln0OBFvTvJ2XmhYvPreNjT5Mei9JNXskFWaWk2pWUmAfy66MAUN1AgA5bL7L+5pxt3M2tScjRRKbkq3e7RDXsJ0bxT7LV2ZmMHcdWB/66TdvOWge6TYMMfMX4QPr0ZDwVHzHGF2hBui5/A++2LlM98JAbTLOIienkjYRs2ya1dZqB1pA19rdIN2b7oAF5+kXrfA8wtH5fU8gRhYIyNmo4bvAzL/yz4k7Y4eUZqhBB7Frd3pB05z34QDMNQc3y6yBg5FjNDCsdrWnRzwooJ0S1QolSQzjwqctAry1FM7jA4q2h/aw7U0c7Ud81DsWlOivko+GPdD84UgKCicMx2os/MrS2OQg1UEXSPrwm08dR+yKqqbVtBMdPALBT2Kx1EpB3oX1snER8LZV3qxQo4eW4xd0WxsjKs571pUg4C4LyRTbxqYasIyQ+nryIlm0DHLzm5kPG7IJ+ZR0s/825Y4h4pIAR1DsQ9Yn0yAm5JI/ArF1qRGw02Cwk8nHvXrgU/r5AZK96Xg72ZlWpKNz8xs44RTMlZXvcEd3li1M0B1mp+xCI6vRM1TamfwEehqySl8is0j+ieiPj7Im2TFUtOs9RB52HfIjyeueAZAp/dC/5Ktwt23ocb9r/ro+Lvj/6Sz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GmyggePTs2k4SY0IAGEoT+oZ22EoDj0hzInC182zTEwifDmxQSvqn0M9yz?=
 =?iso-8859-1?Q?Z/GhwH8gvReoGbiN8mxNKEOWXWq/mHzrg6uT9hITgLT6IY6tOttKmalLx0?=
 =?iso-8859-1?Q?EQRLKGl1SOWBvI3Oe4KqWqadX97+niYaFsaZbXz97POHtKMSTjuPNtBABZ?=
 =?iso-8859-1?Q?pVnlq3sd7EgEV8byAO3oLTNlCgbfbau237MXkCRyQlSRkOW/+JbeoTxaUc?=
 =?iso-8859-1?Q?lH7kZfGTWMK2wJO2WmeplzmBF6JwMb9s+ZQYMH/VWlCLBypKz79Etz+x7i?=
 =?iso-8859-1?Q?aOrOj+YYY2LEhX3F1iLV/nizuQBTc5CpDfm6v3xzxqa+570ah82wHqrLmx?=
 =?iso-8859-1?Q?s92hcBbZ4Rzrvd2g3yvNgPlxtxIrQon/lYYNHVIb+gn59cmZOdknBGQuUO?=
 =?iso-8859-1?Q?2fkqn1k14leb9046RdL8Pg3VEqdKzTE5SAAh1MARCmQ4FWNV4H73ifPDMo?=
 =?iso-8859-1?Q?4nByfC26bu9mmiB9vkwg5Z036qbPg9VQmg/ELEESH5T/sIDPKNwuOvj7lU?=
 =?iso-8859-1?Q?zZkM9XUr/8JuNGThdfmymA03Rc6I3n6ZzkHqre6iUyvH2aHajq8B2KCEa4?=
 =?iso-8859-1?Q?K/Nn2kd5t2ig+1EDopecbiBrlHzExottWoTGlLR46ooNxRcblqyNWBGQGL?=
 =?iso-8859-1?Q?1VyFjaOTCepEkoTci4Sk9rL9852btF1JN4XHl7toO3ejwyAxwD3hws1EjU?=
 =?iso-8859-1?Q?g503PXFErF4ZIy/IJrG5cPyyWz0ZZVMf8brFM1Gek+H/kmQ1cnkb/1ucjS?=
 =?iso-8859-1?Q?e4+z7o/H7RoJG926Vuf6Hcf31NGWIOYkbqFindnEMPJYdl8mz0JO1mmS0/?=
 =?iso-8859-1?Q?X7oFwn5LtniBAO3Lg3ZZRbsLaY6hoWN4yV977v/3X/IUOdxd5sME14CIab?=
 =?iso-8859-1?Q?M+7fmvELiO79QktrghF1+4nNvnbJcHFLR0zcBVu3yey15WjUhoE2S9d8nB?=
 =?iso-8859-1?Q?TeJ+qeDCWHXGzF3phiciwwjOuOBSUW9fRkSFLkRZATNqfWkJh8kLZpn6cW?=
 =?iso-8859-1?Q?qeCVUuc+3gLUy37qFOmutntDrIwloUxTRH2/uDAmhs91zQTxvd4wvQ1Whb?=
 =?iso-8859-1?Q?AtCTSNHjTy5cYK4RETiQiI9kjlyRuLkKACqQOxnWQpy2CM1oHMq1T93EEQ?=
 =?iso-8859-1?Q?I4EC9AsH7jIB7VUi6pcutcu0Mr0P1F2xEaA0ZOWCiU12G0vq+o5aWCWbpy?=
 =?iso-8859-1?Q?/xYiSYSMM4q9yT8bTfpGSpU3Cdk0jPr4eYwpiM1Cm3MLfN4/b/Cq9wPsoV?=
 =?iso-8859-1?Q?sVMiHgQA/geb7TNwnBjwHf+0Xm3URHv56+CPbRJ4b7ei3NCcO0bRR0E/TB?=
 =?iso-8859-1?Q?RELo9kNiaObklVVsLqAg9C64sI5/JM2MAoew27/bBCBO1Bip+SURIDaPmE?=
 =?iso-8859-1?Q?6y7dciDRa0t2aX1/ZOKNvnFbBLXb+o/RpRT9ypS8trNe8sJ1KMvR/pGkvp?=
 =?iso-8859-1?Q?4uaFo2qqLAlraoqA30dUYkhpJCSKJw4owl1GHpVVdUqMjKjbETkP9xbROG?=
 =?iso-8859-1?Q?Y86YmjPPvjmNoYJ6fwog7NW2l2tZ4NlaDo5EOpNKeL5pdz7SOWSMbsToQ2?=
 =?iso-8859-1?Q?O3EzK0SxIRIq8jJG1JRY7PaNFw2vRvUEDx8Kc5bC2XVnHWsDp1Uv7e5doI?=
 =?iso-8859-1?Q?ABVRzEHp28btWV9Wu8KMs7+s/gliivHqR/bq0o8V3kAi4uZFMBk9j7CCXU?=
 =?iso-8859-1?Q?+sDLBVRhGCb/m2lixGSNcsEeSK0O0OHxnR0nGPPO3iEpobiOFsoVrFdMS0?=
 =?iso-8859-1?Q?S+SeMsa5/rrYXS6xSsv+Qyjg5RwcXxkPpIgVEezUq5vqA1BN0Z9x16KZmx?=
 =?iso-8859-1?Q?8YVQIneH/w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: G90wtIOPv3gcOfTaUkUvMouGGauFjKlMarT3b5MHgT3OkVIpZkR7XTM94pWMK1X7Ny43FvwmONzbbxD8rZqKypBMBPtkMCZp3yjzkC2UyxOyeThi988lqWklKyKQyfy7lXypA7Dh7UQ6SLff4/16X/TkMuTdlndz6ApQ7hu19XGvHIJD0Jty3b7YBRlPTTIc29yy0ds0e0UU0Q9scdwKnDrUb+kwhYXOIn6xfNOdP2s5543P57afwiLSy6ISo71pS0TCdeE2InYH3Rvy6nCjxNBcBgGGt590B77Qc9/eyNO6ewT9ajHNr6ObI2Yq7WeTbXxBCCORAvRm0ccfrNh/Ow==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bcfe2b-36ba-4bb0-d7ed-08dee08ea350
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 03:27:16.2915 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6T+xLeQs2UIjArtNFpaPN8qmGJ8VwfH9v3ct+DlA4+JdJaprfsqCYWR+kED0EKZI7GInYX+N/hQH8EarfmJBd1JzlTSTZkn6IonztVaYrIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8221
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

When 64-bit addressing is supported, the Linux EHCI driver programs the=0A=
segment register to zero. See ehci_run function:=0A=
https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-hcd.c=
=0A=
=0A=
The driver comment also notes that descriptor structures allocated from=0A=
the DMA pool use segment zero semantics.=0A=
=0A=
Descriptor memory is allocated using the DMA API. The platform driver=0A=
configures a 64-bit DMA mask so memory can be allocated above 4GB.=0A=
See ehci_platform_probe function:=0A=
https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-platfor=
m.c=0A=
=0A=
On AST2700 platforms, system DRAM is mapped above 4GB at 0x400000000.=0A=
As a result, descriptor addresses constructed directly from the guest=0A=
EHCI registers do not match the actual system address used by the=0A=
controller when fetching queue heads (QH) and queue element transfer=0A=
descriptors (qTD).=0A=
=0A=
Add a ctrldssegment-default property so platforms can provide a=0A=
descriptor address offset when constructing descriptor addresses.=0A=
This allows systems where DRAM resides above 4GB to access EHCI=0A=
descriptors correctly.=0A=
=0A=
The default value is zero, so existing machines are not affected.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 5 ++++-=0A=
 hw/usb/hcd-ehci.c | 1 +=0A=
 2 files changed, 5 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 49176f3fd2..b5ac9c8670 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -268,6 +268,7 @@ struct EHCIState {=0A=
      */=0A=
     bool migrate_fetch_addr_64bit;=0A=
     bool caps_64bit_addr;=0A=
+    uint32_t ctrldssegment_default;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
@@ -333,7 +334,9 @@ struct EHCIState {=0A=
     DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \=0A=
                      ehci.migrate_fetch_addr_64bit, true), \=0A=
     DEFINE_PROP_BOOL("caps-64bit-addr", _state, \=0A=
-                     ehci.caps_64bit_addr, false)=0A=
+                     ehci.caps_64bit_addr, false), \=0A=
+    DEFINE_PROP_UINT32("ctrldssegment-default", _state, \=0A=
+                       ehci.ctrldssegment_default, 0)=0A=
 =0A=
 extern const VMStateDescription vmstate_ehci;=0A=
 =0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 9a80c74972..451a918e9f 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1162,6 +1162,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
                           "64-bit addressing capability is disabled\n");=
=0A=
             return;=0A=
         }=0A=
+        val |=3D s->ctrldssegment_default;=0A=
         break;=0A=
 =0A=
     case ASYNCLISTADDR:=0A=
-- =0A=
2.43.0=0A=

