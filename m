Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0C7FB44C8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBXZ-0004vG-UW; Fri, 24 Apr 2026 04:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXX-0004rR-0t; Fri, 24 Apr 2026 04:05:31 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXV-0001Fe-6m; Fri, 24 Apr 2026 04:05:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFPAzOgPW7tXBA8HmwaJnbLtq8ofRIdgKKTqFsXI5acECByjcMehDtufr/PRADkvcrsKi+soDEzXIDjPd1G7F9b+k0cFdZTfaCzqi12FJdb4hyQVCJ+G/se6THVVv9g4binGDXFZTHcLDHpMswHiw+WssnZQZNcrgznc9gtA7P78rINLVGPeO5jyb3eAWkONQAYuSzYoIawt8q6ByH6RMLTtCfjqFHSkOVLs9fE7vgw+KvKUUp9+HxUmVYhBUTMOnUpYS7/KMHeOIFfW2+36us2xrpdKgPG9aEK2cDg8FZYXzrlPB7BNnuDODrXjzp1FLDDNqqBVe+Skek7SRpYWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMKQRCZFc7RPoBQ8nUjV37mdC7POgSgSdSqK+Fbow1A=;
 b=PPAepfA0FhGlvmxk0xAouEMp0tkCWwgbzJxelfEncv9PuXH0EqBfHesKan74tc3vpql9pk1hU42tJPqmZi+5OwJBk+T7hdWACJMQWGvZpF/6tIJGdo+Em6qF8VAIKiU59Lg/PFU9t2qYlc3S2vb0NahPGbVeECvdeyoh6ZFXrlYZemziLAK51CIcUdUgDFjFpFMi7k7xbV4mvjimiqPLWujFbEE8Kpgc5vscw/n2Rl7ZTGexUFCwNhsR45/tXnkCWaJckPKLaiF1fps/vVrNxle7D4Kp6vlnUUw6vdnONkpUPommeT+knqXwtlZjVcAMq0Rk/DR2oIxXksbkfIdFFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMKQRCZFc7RPoBQ8nUjV37mdC7POgSgSdSqK+Fbow1A=;
 b=nD5Lh4zq42hQbWs+e7t3kIES8N0iHLaIEGdnWx0WKJLveQ7u5WCMSh7P2wVSb1sUJmW1L4yhmcrg3MYV8mXVFLCSfs48rA2fb0dJJD7bADcxxDRdzc5x/+2uepB2fkWmkCNzeRMF8MmesD8Iup34GNLlcgp68y4zXE1+jKc99b5p5G0En6kwWldc0j3QkK2lmtxFmH5z/hJKi95MX+UEeN+FWurDJN6U4KjUVMpuCHRH9rFbYbGGE3tq8HwMQFq4qumVMYIKjD+GxzO3I21ghA1C4YrFGt42X6t7Hz9b46CCFWfrGBuIt7XtKL3NrCzACbxFy7b0PMoJJqkknsF/8w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5790.apcprd06.prod.outlook.com (2603:1096:101:b9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 08:05:13 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>, "open list:sPAPR pseries"
 <qemu-ppc@nongnu.org>, "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v5 03/18] hw/usb/hcd-ehci.h: Fix coding style issues reported
 by checkpatch
Thread-Topic: [PATCH v5 03/18] hw/usb/hcd-ehci.h: Fix coding style issues
 reported by checkpatch
Thread-Index: AQHc08EUz+0kfx21J0ycWAQw2wsrrw==
Date: Fri, 24 Apr 2026 08:05:13 +0000
Message-ID: <20260424080508.53992-4-jamin_lin@aspeedtech.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5790:EE_
x-ms-office365-filtering-correlation-id: fcfa66b5-5af3-4cd7-1327-08dea1d836aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: MmNAERU5o0VXSAoEoyumrqrimaPgDTJqZHsJg04Lt91xYvwUjDGKiBoCLWJyGIYmdBHYF8U2sD67NYsllTZrBYxo1bnfZ6evUKM02pxRLYOoJ/6BZiyQV5rdC8tbW7LWYgI6tDvGI/7hy6rfP9epUPzO9DQEBFLMBf3rsKpuc0wJn4+fAH0+04H66HtMVzToOyd2cKe2CI9CV/JUyLeoHCdtATBQ2zEBrmURP1rB8QnnjlwLNnaiJwxNshrq1Z19HDGLhORZ6g0HyINOBMhpeMMTgN//hmdk+e37eG98b47TsYR3x6zG/EDWojVqvQQuEa0pU5+YC8mybUqIU5BAMyb3brGFEMcIhNRXDJNBEMokMEmEoxQtAu1Da99Z6eHBbhxuDmTvvPE4LrPZbVgpgrpiQjYkrLjH/6hcBKkZzSKX4ZqOoC69z4Bz2giSIHlpwgJSnl0xcyiqNoaeYQm4crhWmqQIGRchoEWizJ8X1G/wK5WcRXjOSc/j86qy4Q73lLmuDwVxnJzvXXANox7RFvxtjmycjbeDBinfU993M/w+869DwguWr4IuhsTFY/P8krxJ+c9P1nE4rcscwaHLN2ou/0dMzu1Ef7t2dD9Zuy0bfFqhaRx6oDlekrgLB8bi6Lvfz/rfH3A4tqo75SprBcveGYcB6PFI2wI33GqArtDxrm0RvrB/a+uvucQrXEPnIJ1WBurEQ0LyH9rVwCdbkr2k3ZyrqgIMpYP9aANcpcePX3JsG+YSZMXdGR+E9Rl79UGvqbFZxHmsHOBcFXkqpyrlNTbXsVG88rfs/9NoXPAfSyHUD9xdG3OdTw+dKs5J
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UZHU5yGykH33L6fQsACbfiTWvHvXpvWitgeXIWy5sXe8clyArkwA2d6Nmk?=
 =?iso-8859-1?Q?jdEt+F5xJfD+S7VR7sq7NdNyypdG51gCQiD9TQ8X41QUx/QCgDED/19Omq?=
 =?iso-8859-1?Q?7nwRgwbiFD5GMWBkyf7mGnwYztAasZDUEBB8BW0cnj+7QM5Vg1QMH49anD?=
 =?iso-8859-1?Q?zCIwHngjtzfgXdWblb3q3olO5LlZRPFtaCJ+hHQEsm8Pxkl8Zwgg8IUW9u?=
 =?iso-8859-1?Q?RazFgs6LgjgU6FNKjicGAIYjsLnr1CECn9mGRZeFZT/08TDTZHgkDdBr9k?=
 =?iso-8859-1?Q?+0ZKIKka20TF+7Zf0It3jnqEReHcbihZGgpei84bXPVhnpDf9m1ZycvW7S?=
 =?iso-8859-1?Q?NtATgV8h7Hi4UUEzNbpee/qUq+mDmIFAhgguzUbE/9XRp+HXEj2iLKGUAJ?=
 =?iso-8859-1?Q?ggWLIjiHVepGZx8sSL9IvPTWWkPBBKP2iafxCEk4js6+jEKcDtEReIkvge?=
 =?iso-8859-1?Q?UcB5P52zKGvvfWV1MJImeISrP1PXe+bR6JyqL6/co96GB0UIkMaYt7I+K1?=
 =?iso-8859-1?Q?vYku59fRNCkSjNbqltoB08K4MQG2sL0vbuIcLxWXlKHkqoe9dFZxHzkOfc?=
 =?iso-8859-1?Q?/bNLm0NOZN8QtZ3RicixEktWKXPgfcVaz5ZWWI57lWL2AQlDMZlGLlNggW?=
 =?iso-8859-1?Q?QIVhwdCHIm72gMAS+0eOzfytP27LAW1GYWeI/EYVak3Q+HsZkWgKnDHETa?=
 =?iso-8859-1?Q?LWG2ENrNLv5gDas4Qn8qQFlvDUwo0Kc97vaAttzPeGRKNmlytOapQLjtop?=
 =?iso-8859-1?Q?BJS9iKquxzq644rhBCE/+6bxRumwXDcJaYDO3d2Ohu/xprBJAkiZXK4BFv?=
 =?iso-8859-1?Q?66ST00RfFzwynxrcRzFdwL/HN47uTnT0NxPM7D4w5y9dQeBEry+roPLHoJ?=
 =?iso-8859-1?Q?bSZMZBmm3hero59ubDwNTKBYXdjpQ2INd7qr36XnhZwRCzsJrYKJiKLU6R?=
 =?iso-8859-1?Q?Pl+14xHqElTPDpieerGIJ+4lolQnTXpOK2c7pmz+eJNORw5+NbyCJwwgSZ?=
 =?iso-8859-1?Q?owIanZ2Zgxlr0+bP6oDSFar/JtmAGGnJpeK9Ah24Y+uMqhDRv57CI9SePx?=
 =?iso-8859-1?Q?imGRGUIyvpxzEdQvjUn12LmwrrSIynyOOnC2AVXShXTi35x0w2dwMQvokv?=
 =?iso-8859-1?Q?tdW+G83VsrrnIRrJCC8Ca9pUXO2L7bWXCqEX8rSQOfIZWMjBd10hZuAgNL?=
 =?iso-8859-1?Q?a+JUHBvVtD9flE1Pq6y1toKzkyUACCO1tlLqIGEX1gCO41a8StkHRViD0t?=
 =?iso-8859-1?Q?X/o/R5klMRVugu322+PnFhlV1tVUl8+/xNyDN12av3tn+C/5yMcm5Lwk7S?=
 =?iso-8859-1?Q?LgIM7E7lVgmT9DUFgnfZCCPbyf4yM5oMEAL2+juWLtV+eqMgKzaFDKkb50?=
 =?iso-8859-1?Q?WNnjSZP57a6mUH6SL+ttuZVkNRtpwhuFRA+7+mkfqJV3+naOCotauV7wS8?=
 =?iso-8859-1?Q?OTMt7a5RN51ptK7BXDDVuii2Ooc2LQ8OlprhaLkBsq7ZFkcfV7TmNcMo+y?=
 =?iso-8859-1?Q?tmSs3Ulqb8J80J90lFh0lJo7+l/40sf2zjwe9AFFQ41pblQc9AT5zkvMdq?=
 =?iso-8859-1?Q?MR+gj6pFASLv3derjR1VG+YKDIGqOQ4clzuwJZ4zr33Bsz3SGrzPFlNuiT?=
 =?iso-8859-1?Q?mO4XBxn01KYuocJbZrAwHKuPJXV+dACYDMX+GzFR/+xTUo0U59e0ZCz7T/?=
 =?iso-8859-1?Q?IrIvBQUHZWlyR0Hn2TIX08E3EgcWAKls8JlbLfpX8SAqwNe5eFft7ySHfX?=
 =?iso-8859-1?Q?JUi+sJeYPoRHUhysgBDrZwC78VemILdyw391LXGLx0BbEz1Q6P50ECv2Ow?=
 =?iso-8859-1?Q?y/RtMkophQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: g37v+j7OIwjxpnIRLl3NqDIVCSUwOxJrWa5pursIp8x13C/3C48RjD8tSUSmi1rDhyyWavy7snbtwe5ym7WihgtA6N7TKLmRWmd/0yNMMf2iu2QYU+wdmPDnELBTaDqYbyBSIcYMDbuql7Rj7WUCBzvpmXYRxxqL4ljXTDqEYKHiSl/zZLp8/7xBFzaV6se2cQbVw2pwkT11dYYPi97VCl3pC7/jHaN5qYpQStRU+i+bSfuNkXhNbGpQmp6Fydq21/GABY50CnDzGO/Pw9VV95jfK9GezioSgD/YtHvLi4u/nORoWAkJ5hczoSPkaHRgkXyJjbIA4SvWGTeHo/fp7g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfa66b5-5af3-4cd7-1327-08dea1d836aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:13.5227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Ttl1LvtMMIsIU+umgbrxlsaEZ4RUCu+YaYpTbKH8DIH3w+8OmolQCD3y3nSMc6u2cT2HKzE1pHIkWdR7GeVToq3etExNxtkarLyte4ejCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5790
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

No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 17 +++++++++++------=0A=
 1 file changed, 11 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 3aec0e047c..736407fd52 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -43,7 +43,8 @@ typedef struct EHCIPacket EHCIPacket;=0A=
 typedef struct EHCIQueue EHCIQueue;=0A=
 typedef struct EHCIState EHCIState;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.3=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.3=0A=
  */=0A=
 typedef struct EHCIitd {=0A=
     uint32_t next;=0A=
@@ -74,7 +75,8 @@ typedef struct EHCIitd {=0A=
 #define ITD_BUFPTR_MULT_SH       0=0A=
 } EHCIitd;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.4=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.4=0A=
  */=0A=
 typedef struct EHCIsitd {=0A=
     uint32_t next;                  /* Standard next link pointer */=0A=
@@ -118,7 +120,8 @@ typedef struct EHCIsitd {=0A=
     uint32_t backptr;                 /* Standard next link pointer */=0A=
 } EHCIsitd;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.5=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.5=0A=
  */=0A=
 typedef struct EHCIqtd {=0A=
     uint32_t next;                    /* Standard next link pointer */=0A=
@@ -148,7 +151,8 @@ typedef struct EHCIqtd {=0A=
 #define QTD_BUFPTR_SH                 12=0A=
 } EHCIqtd;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.6=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.6=0A=
  */=0A=
 typedef struct EHCIqh {=0A=
     uint32_t next;                    /* Standard next link pointer */=0A=
@@ -230,7 +234,8 @@ struct EHCIQueue {=0A=
     int async;=0A=
     int transact_ctr;=0A=
 =0A=
-    /* cached data from guest - needs to be flushed=0A=
+    /*=0A=
+     * cached data from guest - needs to be flushed=0A=
      * when guest removes an entry (doorbell, handshake sequence)=0A=
      */=0A=
     EHCIqh qh;             /* copy of current QH (being worked on) */=0A=
@@ -268,7 +273,7 @@ struct EHCIState {=0A=
      */=0A=
     uint8_t caps[CAPA_SIZE];=0A=
     union {=0A=
-        uint32_t opreg[0x44/sizeof(uint32_t)];=0A=
+        uint32_t opreg[0x44 / sizeof(uint32_t)];=0A=
         struct {=0A=
             uint32_t usbcmd;=0A=
             uint32_t usbsts;=0A=
-- =0A=
2.43.0=0A=

