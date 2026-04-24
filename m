Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9A9FB44C6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBXt-0005BY-Ba; Fri, 24 Apr 2026 04:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXa-0004wy-RT; Fri, 24 Apr 2026 04:05:34 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXY-0001Fe-Mj; Fri, 24 Apr 2026 04:05:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLjIiFtwa5kLPczz9Wb69x2IwIYyVBPXXqSG4Z//fSRh1qze6qbE92cqV6XIopKlMa4+Zso96zqaLN5azW4jvirFdtIfWWJLc9ylfzepVBC0SuQ8K/fVsVFXayF+yQ+PDr5TFjQe1vgHaLMqfNuQ5D0UNsMdP0+mRDhJRhnk9t7qDyxdw+on0E4o3JxFFSGdkywFr7OI4XZfXblO/2hrtCzYyZBSd0sDOoYD2X/iV5emlPEMrZyWecwksQICMOqBc2ABU6Uel7WeFoM8a3Lx7xUuhkcWTHEx8GawxPEJ39/VjlHmP69PVk+0+dbvITZTa4bHonu4deiul/W+GCv5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wf/rspbizfO8S2VdtP+UJa/82oa/vwofXBGb6mH0/F8=;
 b=hjh18yApknhQ2aHT8npe0fzAmLJKu/wE9iYb8Qr0S5oVETFIqNLMueaLDdI0OKfCJghGx8+BNzdrukow9shCjjgZEhnL90bt+uXxJVyHPhnDVWGDRs5NkICg8fRFRWDSxVIxF4DEY4Yd+HtpxQ8OhPaffZ/FdNBIGbrU162RSMq57b64fJ6nwJkqwx9r/Y6EGLWjNw1brw/+bo9on1vww/iJozFDMSi0z6wSS+9KaW7WhpqwtAlQTM/I9uV6ushHscqOd+/P4d+pO/BQrFJ9XzB/G7vRg0Ui3i8GGmVycphlim7aUeRkX1VkrrDggaICyNkd3XI4RBSfRgmuYCgM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wf/rspbizfO8S2VdtP+UJa/82oa/vwofXBGb6mH0/F8=;
 b=TfnBO/M/yv7vX/gE8ww8cC+1p6M1M3nWsWKllVIWc2IJj8ilAaoCSRetaqtpcs9wBxFom8AhAYWqLZfgmCPNelOlER+ePGwBNBgytLFVjgSqgV7e0GfPOZdfTzQnvrWADx8IO6KqfdaWeBZuFGHrt6zvxd6Qp5J68qJMMDiSfD8pucSpbQaMGEVR4B4qJsJW8ev8aORD+FUs9x7HjZqzNPj9fzk5zUPocLRLVXQ2Yawq+0xybKH1c3hNfOPK3DCK9a91aAQgU0ZPZypsywIAqFcTC73zy9L0pqQSkdlCa/AsnUC7nY53+aaAhHJf7Z2ynwLKsW2wAntyRGzQb229qw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5790.apcprd06.prod.outlook.com (2603:1096:101:b9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 08:05:16 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:16 +0000
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
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v5 05/18] hw/usb/hcd-ehci.c: Replace fprintf(stderr, ...) with
 qemu_log_mask(LOG_GUEST_ERROR)
Thread-Topic: [PATCH v5 05/18] hw/usb/hcd-ehci.c: Replace fprintf(stderr, ...)
 with qemu_log_mask(LOG_GUEST_ERROR)
Thread-Index: AQHc08EVcDl4XXqFDEishnwsa0W49Q==
Date: Fri, 24 Apr 2026 08:05:16 +0000
Message-ID: <20260424080508.53992-6-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 2e186251-dea5-41ec-d66b-08dea1d8383f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: MgBqwsqPfU54mwyVoPO0PkxxyvuROyAfly6NyGc9qz/vn5pNw098zoHkDUs5BLQ59WUNvHgNrfk2PD5FBMEiLGccxGK485sXTmQK60X0sJJJYVT4QVJUVhnqgkQv5fDKFYd7zAMTwJtgWKnUlLKka8ZFUOAuv5SgnXUznMDw0PVeyGqbDgjHqm3nlHxN1qsZvU3bTJ5oqPMdqPU7ijHvUPKrPG5mMjXcNJQGEtjTuZFh4tx1Oiq79Pq5hagHIAbdtMLgl2HENFPp1vONgATm+/mw0/Cah8CJd1eB/TM8sM8pI+Pu4Tp2CiARSU6bxN4M0EQ8Nlu0Gs9mTd/gbGPXj3fgnauawZHkLb9XOtidrEasgirOCjNKTgza+FDHoEtM6+DbTek7uwR6gLayL855IMvmzJa0YcO3h6tqpDKJY5A+vQMvWHVCJZwrj3j/N7aGR4IXUsJKWfQBlH/qRrHJ0y5HQ7uSB9hFyZ8I9oTOWqlGC/toB/ZCrgkeGYI2MpNHSDO/uExvyMdE3eN+/a38i7OsEd4eYefqOZFms8UCA78mWtdPwizl0WgZuY8vG5XfSfJO47IYNjmLqTGDKtkbiwHnqZsyTrKjfMS83jiH9VrrboGBQ5U0G5+IixZOmWO5mqyqLBZC7DofEpNsyc5vZaSrQu978drovuFsrPwmRUL0VscNSoUjnG+aHV0x75dzQZX53Sku8d0q3Z+5sCGvZzNHsz6qJHS5Rh06CL22DhF8q200RV3yBRX3YDLGDPGXExN32jL6X6yKpCB0KMexZ5XVw2Kcyuz23/g1D3i00Toam3rYbF+LSN0UUazd8JHk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0Q5CRuun9PDWRb/3NydtqLNmHjGWv89W9NhIPuQ56qEDMHnrR8OfZmK9CY?=
 =?iso-8859-1?Q?gHcivKdGG54WeWRib9k2a82DPSLj3yh2AjFRTsfibVP8OnfUUNQfPJc3B5?=
 =?iso-8859-1?Q?yYDvA85/kCZBlqqTVWwSIaa1a4Dn4nasnZJG1Bq5ZhhW/oSgVMGAsU9YNk?=
 =?iso-8859-1?Q?P11wwzU1eCP6YjiEDLMCcY1Fqn+DsTQjNAC5JyKXyIxMrn8DvVIjs01a75?=
 =?iso-8859-1?Q?BvpVWAgYVs47b1uvJXARj7uhxJZm7fZIFWQ/3JGRILD5tmNtiGHTqCaOwp?=
 =?iso-8859-1?Q?gpz6M6xPnEEC7DG1qhM+kvKqkK128xm2dR13u16e2D3iiY0OO5k5/prfLj?=
 =?iso-8859-1?Q?X3AAk1opQ4Ta6xBdGNiPVigLVqtL2iv9rVDToRzhg7IfCOPPPd25JUVb3e?=
 =?iso-8859-1?Q?2DqMDTJBmLn4RdrvqU7VBlbQut0T7eZQ1MsbOG12E9YUtidqFWFUl8hYaJ?=
 =?iso-8859-1?Q?o2DJo+97vZXRnlTSt0V73V/MOK3pG88XpUc+iacYY7hdUZ72J8e4N70QC8?=
 =?iso-8859-1?Q?LDsqXuBf1U4G83tECQq+PNNpE8P9Q7oJLAD6vpPHjYm/bOymeU1vP2xfVB?=
 =?iso-8859-1?Q?6d5aZS6g7dGxKPAAPYa0qfyB94ZGNC4adN5yLvh63x1o0KkNVLVYo8DqCh?=
 =?iso-8859-1?Q?ktXc8GU4BBtG9NKVv0VJPyqoT+E9DdGdtqvE9RK9hjf+G7EsH+ot2OjZE7?=
 =?iso-8859-1?Q?xSnJe/OiJy1BsPG+0yOX5Y9QU1zNqME/Ly5NIR3ctSBQaxd5rfjq27eeL+?=
 =?iso-8859-1?Q?ymSLFgYVOdqHdwIy+7sV5zVUTUGX8LOcOx4RYlI/cO8IkQN2Ac5W3y/ZjA?=
 =?iso-8859-1?Q?e4+w+SO+C6hKUglUuLgqqCTp3X68Q1mXQY0SEZKgHBGJid/fF5snYXtU5W?=
 =?iso-8859-1?Q?WzYhaQZ1n5AE+2XrTTaLgTKWALm7keZ16OcJu+Brq/+we8yMOm0m79X51Z?=
 =?iso-8859-1?Q?F7JEZhabNGmXUUt8c2IGHb/1nFiTTyaPcRPN4Ugu27DdcK71TI05+2YW0H?=
 =?iso-8859-1?Q?KMGEhzdRbke6IcHVF0hDsIMgYcCqKuMmHbE8SvXCZmPRvG93Fvw41hebfI?=
 =?iso-8859-1?Q?GNJFFEvqpkXvcNT9LfngSk8nYgiVxD7Ng5N/9J2Mv2LpYKMs9+KO6wMbLL?=
 =?iso-8859-1?Q?+GmMya0xxoQVk1xUSiSVGgQW8NQwlewK0euG6xwR7WAsgUUWmj8sTF6e1z?=
 =?iso-8859-1?Q?fYQGfbRSX/wyZ9JM47HmCWDaK4cB9P1OrDRZXdn0pRu+TGbD2Vqo+yHrn9?=
 =?iso-8859-1?Q?EYoE0zJB6FDe2dK2rgA4YSTsyl3CcEcbKkx0J5pYGoNkv3S5wiGy8VkCWn?=
 =?iso-8859-1?Q?mbJEMqUbgp7iP/1WWqQbiG/53zm2cMjmdSPDWXCLrDUIqZNsEq/a0vUyLz?=
 =?iso-8859-1?Q?C+ds/DzyfiA2zfyyH8ID891yMMhB/+2R1zbEAkA42xpQijf3zRVwi24S0w?=
 =?iso-8859-1?Q?U6PghKMsgfTIgsy2/hmK/Qtsd5yJLJ9x8DQD30gINBH1eXv1KauCCNOW7o?=
 =?iso-8859-1?Q?foF3wb5bFL9h/NrVujYX2BbXPK3l7ti+zT5upD87yXUa7ndVzgp2gPliXI?=
 =?iso-8859-1?Q?BUfS6n0/6USik9fO3Ipb1ce2sKUmXQ4LWfljlN+dxNeHwajPmRhE67FsaA?=
 =?iso-8859-1?Q?fiZ4zprR3JKzS5+gu2XzbCP1ODOPoCy+nsbQYOQkURKB6qaVmGqeAsUp2b?=
 =?iso-8859-1?Q?BJvYUZ1tXURiDQOi4FRU2B5KJnejeOBlsZ3H8fcI6lMV7hrdN2+armCzIY?=
 =?iso-8859-1?Q?oV9X36bbzt1mqtDfjJLFXd1ffS36wfOL6E7qVPlspBJrTkrQpgjWt73Zaz?=
 =?iso-8859-1?Q?VoKhUyisug=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ixajn8xVZMfCfxyTl1meNVuSnNUrRZRHAvI8XOg0jdQya5ITzFTnJpbXlAk/GGj4Uyc3PGT0/vuOkdWsKO3BouaJYR3Zu+51G4cga8ZFELmwTOM+AOQDcfXVS0dEXSbUV59oizGLJykUJdmhF1UNDqEC5Ln7QPd58i/dWqJ9lVwX5iXIFwCVaSfE+U1YEsnISwGj1OgcLXdpqVVS3jl03eTJn+kHRRBmhjKHJxFUaHGylNTfeqlMabnVHW2/GMsAiSP2A7HA71C7OeiU1YMt8Eb5m+lZ+SneBCHdpQ9pF+0A6sYuQBDHVvnbSdWYuO6btVOEBXJ+/opja6sJK0NmSQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e186251-dea5-41ec-d66b-08dea1d8383f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:16.1286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cc+NMDXx0yma+OzxXslOFwqbME+UBu1fb2oDU63YgIeG0Lo9wNSR+xKruhRIX60By6+vVSwQNdyo0Ly7EhCzzN3aBDupUJrmqmsioUs7LMg=
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

Replace direct fprintf(stderr, ...) calls with qemu_log_mask()=0A=
using LOG_GUEST_ERROR in the EHCI controller implementation.=0A=
=0A=
Direct writes to stderr are discouraged in QEMU as they bypass=0A=
the logging framework and cannot be filtered or controlled at=0A=
runtime. Using qemu_log_mask() ensures that guest-visible errors=0A=
are properly categorized and can be managed via QEMU logging=0A=
options.=0A=
=0A=
All affected messages correspond to guest-triggerable error=0A=
conditions, so LOG_GUEST_ERROR is used consistently.=0A=
=0A=
This change improves integration with QEMU's logging infrastructure=0A=
and aligns with upstream coding guidelines.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 46 +++++++++++++++++++++++++---------------------=0A=
 1 file changed, 25 insertions(+), 21 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 7e0b767eb9..8acaedeaa9 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -36,6 +36,7 @@=0A=
 #include "qemu/error-report.h"=0A=
 #include "qemu/main-loop.h"=0A=
 #include "system/runstate.h"=0A=
+#include "qemu/log.h"=0A=
 =0A=
 #define FRAME_TIMER_FREQ 1000=0A=
 #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)=0A=
@@ -425,7 +426,7 @@ static int ehci_get_pid(EHCIqtd *qtd)=0A=
     case 2:=0A=
         return USB_TOKEN_SETUP;=0A=
     default:=0A=
-        fprintf(stderr, "bad token\n");=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "bad token\n");=0A=
         return 0;=0A=
     }=0A=
 }=0A=
@@ -532,7 +533,7 @@ static void ehci_free_packet(EHCIPacket *p)=0A=
     }=0A=
     if (p->async =3D=3D EHCI_ASYNC_FINISHED &&=0A=
             p->packet.status =3D=3D USB_RET_SUCCESS) {=0A=
-        fprintf(stderr,=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
                 "EHCI: Dropping completed packet from halted %s ep %02X\n"=
,=0A=
                 (p->pid =3D=3D USB_TOKEN_IN) ? "in" : "out",=0A=
                 get_field(p->queue->qh.epchar, QH_EPCHAR_EP));=0A=
@@ -1042,8 +1043,9 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
 =0A=
         /* not supporting dynamic frame list size at the moment */=0A=
         if ((val & USBCMD_FLS) && !(s->usbcmd & USBCMD_FLS)) {=0A=
-            fprintf(stderr, "attempt to set frame list size -- value %d\n"=
,=0A=
-                    (int)val & USBCMD_FLS);=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "attempt to set frame list size -- value %" PRId=
64=0A=
+                          "\n", val & USBCMD_FLS);=0A=
             val &=3D ~USBCMD_FLS;=0A=
         }=0A=
 =0A=
@@ -1101,7 +1103,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
 =0A=
     case PERIODICLISTBASE:=0A=
         if (ehci_periodic_enabled(s)) {=0A=
-            fprintf(stderr,=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
               "ehci: PERIODIC list base register set while periodic schedu=
le\n"=0A=
               "      is enabled and HC is enabled\n");=0A=
         }=0A=
@@ -1109,7 +1111,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
 =0A=
     case ASYNCLISTADDR:=0A=
         if (ehci_async_enabled(s)) {=0A=
-            fprintf(stderr,=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
               "ehci: ASYNC list address register set while async schedule\=
n"=0A=
               "      is enabled and HC is enabled\n");=0A=
         }=0A=
@@ -1200,7 +1202,7 @@ static int ehci_init_transfer(EHCIPacket *p)=0A=
 =0A=
     while (bytes > 0) {=0A=
         if (cpage > 4) {=0A=
-            fprintf(stderr, "cpage out of range (%u)\n", cpage);=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "cpage out of range (%u)\n", cp=
age);=0A=
             qemu_sglist_destroy(&p->sgl);=0A=
             return -1;=0A=
         }=0A=
@@ -1306,7 +1308,8 @@ static void ehci_execute_complete(EHCIQueue *q)=0A=
         break;=0A=
     default:=0A=
         /* should not be triggerable */=0A=
-        fprintf(stderr, "USB invalid response %d\n", p->packet.status);=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "USB invalid response %d\n",=0A=
+                      p->packet.status);=0A=
         g_assert_not_reached();=0A=
     }=0A=
 =0A=
@@ -1354,7 +1357,7 @@ static int ehci_execute(EHCIPacket *p, const char *ac=
tion)=0A=
            p->async =3D=3D EHCI_ASYNC_INITIALIZED);=0A=
 =0A=
     if (!(p->qtd.token & QTD_TOKEN_ACTIVE)) {=0A=
-        fprintf(stderr, "Attempting to execute inactive qtd\n");=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "Attempting to execute inactive qtd=
\n");=0A=
         return -1;=0A=
     }=0A=
 =0A=
@@ -1395,7 +1398,8 @@ static int ehci_execute(EHCIPacket *p, const char *ac=
tion)=0A=
             p->packet.actual_length);=0A=
 =0A=
     if (p->packet.actual_length > BUFF_SIZE) {=0A=
-        fprintf(stderr, "ret from usb_handle_packet > BUFF_SIZE\n");=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "ret from usb_handle_packet > BUFF_SIZE\n");=0A=
         return -1;=0A=
     }=0A=
 =0A=
@@ -1479,8 +1483,9 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
             case USB_RET_SUCCESS:=0A=
                 break;=0A=
             default:=0A=
-                fprintf(stderr, "Unexpected iso usb result: %d\n",=0A=
-                        ehci->ipacket.status);=0A=
+                qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                              "Unexpected iso usb result: %d\n",=0A=
+                              ehci->ipacket.status);=0A=
                 /* Fall through */=0A=
             case USB_RET_IOERROR:=0A=
             case USB_RET_NODEV:=0A=
@@ -1584,7 +1589,8 @@ static int ehci_state_fetchentry(EHCIState *ehci, int=
 async)=0A=
 =0A=
     /* section 4.8, only QH in async schedule */=0A=
     if (async && (NLPTR_TYPE_GET(entry) !=3D NLPTR_TYPE_QH)) {=0A=
-        fprintf(stderr, "non queue head request in async schedule\n");=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "non queue head request in async schedule\n");=0A=
         return -1;=0A=
     }=0A=
 =0A=
@@ -1606,8 +1612,10 @@ static int ehci_state_fetchentry(EHCIState *ehci, in=
t async)=0A=
 =0A=
     default:=0A=
         /* TODO: handle FSTN type */=0A=
-        fprintf(stderr, "FETCHENTRY: entry at %X is of type %u "=0A=
-                "which is not supported yet\n", entry, NLPTR_TYPE_GET(entr=
y));=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "FETCHENTRY: entry at 0x%x is of type %u "=0A=
+                      "which is not supported yet\n",=0A=
+                      entry, NLPTR_TYPE_GET(entry));=0A=
         return -1;=0A=
     }=0A=
 =0A=
@@ -2118,13 +2126,13 @@ static void ehci_advance_state(EHCIState *ehci, int=
 async)=0A=
             break;=0A=
 =0A=
         default:=0A=
-            fprintf(stderr, "Bad state!\n");=0A=
             g_assert_not_reached();=0A=
         }=0A=
 =0A=
         if (again < 0 || itd_count > 16) {=0A=
             /* TODO: notify guest (raise HSE irq?) */=0A=
-            fprintf(stderr, "processing error - resetting ehci HC\n");=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "processing error - resetting ehci HC\n");=0A=
             ehci_reset(ehci);=0A=
             again =3D 0;=0A=
         }=0A=
@@ -2181,8 +2189,6 @@ static void ehci_advance_async_state(EHCIState *ehci)=
=0A=
 =0A=
     default:=0A=
         /* this should only be due to a developer mistake */=0A=
-        fprintf(stderr, "ehci: Bad asynchronous state %d. "=0A=
-                "Resetting to active\n", ehci->astate);=0A=
         g_assert_not_reached();=0A=
     }=0A=
 }=0A=
@@ -2231,8 +2237,6 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
 =0A=
     default:=0A=
         /* this should only be due to a developer mistake */=0A=
-        fprintf(stderr, "ehci: Bad periodic state %d. "=0A=
-                "Resetting to active\n", ehci->pstate);=0A=
         g_assert_not_reached();=0A=
     }=0A=
 }=0A=
-- =0A=
2.43.0=0A=

