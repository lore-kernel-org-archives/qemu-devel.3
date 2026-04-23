Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E92FAD40D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFmSF-0007Q2-2R; Thu, 23 Apr 2026 01:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSD-0007Ov-Df; Thu, 23 Apr 2026 01:18:21 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSB-0003Bi-UX; Thu, 23 Apr 2026 01:18:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTxjvV9Qr9H+4nKB2N2FJU7iwrqefK9bGIbX7nqdmrdQFuQHVpRLBlyNTe6a+8kbkmcLBmrqj7ZxVvOyUWkRJujfIuCVokCxjRogGkQ5Oo+BmFBoJuN5SpgNDYwohFl2vgtp27bVaworXNVgJNdJjLN4CRWhmoDiEOpUnCv8hiKAwTZA8mkGWUouXMTiUFBPAZOCY4mCAR/3rQP8RE4je3O/HVwkvijUN43n574TgktJ/ZuUZztzKk5u+Q2N1p/M2r5EYeo8O5mtLcbmBb/opa25wfoQfwpdOAT+shvUnRCzPzj1WSISy1ox4rmb9Ve80qiMq40kA5X87kby6wlZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCFEwtHBZ+mIU1V0QNyiXC1wsVKvlT2QfSiHUhROkWE=;
 b=w88nir0m80j7gVS+Yn2ym9DM6CsP0tGqN9zmKygXTCEBIBzR20yfVirbBpdK7vk/ObBMilShLGb0WnoMSNAc1ZmRC+1+KjIh2LU3AN+Mhdrkt/YJPiypkDSKhkgbZ+bt6TocIqWDHOU+Is2D+oJgladb8mNCrB6BlF3deeYOW+NWbvgmJumKXi8GgsGs/9HDNbBw0fZHT6efePgSXgPewmpLeck9juhLu5sQLP/pSGU4kKZDBTpOjoDHJvGI0u5vOO7sV9q2sceIxOPepQIj8FDmUyYFe1LXA898IlP4j+28my6zgZDMTnsNirjr4tj5o7T2pJEmwuIXACJsA3pnkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCFEwtHBZ+mIU1V0QNyiXC1wsVKvlT2QfSiHUhROkWE=;
 b=SXe7GrCKZ5xEGp57n8k6FV6WGb6YBqtu+h3tIVSbLUUXi9hN0VXqMyNB2C/PpK+1rsS2VLBiSv/fG0wgb2FjihVecIWrYz05FN0ZskL13jOM8AzmleoBlohSKojWhAxK5MDQa8OK3QdrgcWiV/WywBkrZ5nULFuUm14D+b9+fAGjtXd8rHwXrKvaI7Y2iPxGuDmpPm3qKJncwoU6Tt0YwVImIItXIF/13KlUHfyzSyy2G8NTqGNtWfFoteeShQ7lpzPxAwJgLmJxdVeMk+V65Ylzgv6A14TAs989zoKJ8Af6UBLG+uRJwKm5ucvd4c0pXTsKuMFpC1mga4cIBqMpRQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUXPR06MB8534.apcprd06.prod.outlook.com (2603:1096:d10:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 05:18:08 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 05:18:08 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "farosas@suse.de" <farosas@suse.de>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v4 02/17] hw/usb/hcd-ehci: Remove unused EHCIfstn structure
 and dead code
Thread-Topic: [PATCH v4 02/17] hw/usb/hcd-ehci: Remove unused EHCIfstn
 structure and dead code
Thread-Index: AQHc0uCSUn71WarDskudEuJUK23SCg==
Date: Thu, 23 Apr 2026 05:18:08 +0000
Message-ID: <20260423051804.362095-3-jamin_lin@aspeedtech.com>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUXPR06MB8534:EE_
x-ms-office365-filtering-correlation-id: 3c02d483-1eb2-490e-1f82-08dea0f7b49a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: jYMCeZPgIrZDLl/Rfp9FkqYR1UQXbaWTPhLW3kIvqkDrJu5QU9xFL1QeUVg3mHJbXVuI/dEVTSIXkm1IvnL00rgm7CwAAWrvcYnIJsJE4JwGDgJPrCqyMFcYj7YAxx7eA0La3vGgDdM4HywuLO8rUcH8IjCHcTBxtFIDiS8xbm3OWZ9olAxIbo8HGKn6zDWgM9Rj+T8A1xUtSDtx9HTEuKWjoGpBMEmJXB2gQwjUtPh3I0LWouoXnaWybEN229bbnZmPjg+H2bkz2zzV6mIO2cKiPVjUln4DrtOb3K6NogoxrcjoG29IYayqTU+4kjKD1J2/73zkfQOFppYz09hqpRVJK5K5wsvyMrLjDBoIS/KhVU3bN2vTDutPiEneNg7YxPpVqdHKBfj89ncCY5WRm4S/EyrNhIQdUOjfM/wWikrkRfXhyzeV9fHUXfAB9jTUZS/oxFmjmz7K5Kj/U29wz4ApaZ/89XOD2ChZ8OXDpg5G8wJ2BX4StrhqjrFHr+deTApspdXgp6VFhf0S4yehlXfWMOURhhjNfZVRB1e+c5KqADkqLo8N3DZ6mzffi9fPufSCuoNjy1y4Uf5Jd3whu5WIH9wVxeOQhuVB53VG9j/FLCkyMuwk9pzauMobY+AqT9V9N5LEPqBs8QleinDRTpkCudFoH2hgHpXfFg+WflC0zHTDD7HeAsFDnGoQPqt7b+fyYtRFws+0WmmRq4IcHv+Yoikt9VOzBrljk0tDLI3TxWyDw8nAHBbscQqKVsVIuWy+Pq4BcekArQw23jIvvxjnBfyUb8aFLDSOI10unOJFk9+p960hkDIfMh7bFRaZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hWEG2gtptjOQ2yJ3gs+nGuhG5DC2nbXhcyn3tfSjmTQsOCg0y6pC6Gsd1s?=
 =?iso-8859-1?Q?ua/N7teydReXPFhOklIYDwQlZM9GFoFVN3dvSje/gO5Kt3Ff7pmsiN6E2G?=
 =?iso-8859-1?Q?usnO5UglU8DZPCtO1gMQBtJu+/9Jj37Dco9C5f02DnS2Z9MGzwziv0R0TH?=
 =?iso-8859-1?Q?xjdESPL5iovSFmntck30CIz2u5K10bRC37Pj3ho8Byc7Lou6zz0oGLxCiE?=
 =?iso-8859-1?Q?T8/hTQc5QyrptuAac4tJLX/VVnmwvSlVfhlHKmdhub4LpMmng4LIG2IyR+?=
 =?iso-8859-1?Q?yIMtU+vr93esdmSxD0iDfU5fl/SWPL+Tu+n4rxtthXSr1C33Lc/G6eUT8q?=
 =?iso-8859-1?Q?YeuJmJqj9q2HcjlSmfRedHtLOoxTmjofTOtBMobijGJJxfGq/3ckBxnHLP?=
 =?iso-8859-1?Q?g7Z6nNXQo07uvQ+rFTFSwXVt1iguhmziyiTXb7EmaUDCk+AWPv2FjBPE30?=
 =?iso-8859-1?Q?56zJqGz+oBbYaNdmVJjkH0UxmSxT39Nfi/V14zIyEYNFrkLIkTWB2jB9Ek?=
 =?iso-8859-1?Q?eImmyTOBowsjJawp7gkzyvB2ScG3kPjn2xPASb4Gu+9EIubFT3avXx2S9m?=
 =?iso-8859-1?Q?DAUHEie4qMgMyZAQ/x9XKeEkNg5JgdYooMPWHvZoMlCdJBvhPQuceXEAxS?=
 =?iso-8859-1?Q?lU6NBHjT4+ElMI9M/xQ49xTSxy4N/NVnQvFA3+DkNg1A6e3g79KJyJoCbv?=
 =?iso-8859-1?Q?WVtx5fWhkbzqybWWv5U+OQ2jDTjSIkPzTPvF5HHB6azxWPOHSaSCV7Ft0t?=
 =?iso-8859-1?Q?QO9wJI8ucsQywcyKKEoNhcAXR/bW6O3yxNPkU+OdOJ0y2EVu1V64sK2pN0?=
 =?iso-8859-1?Q?rbPOQXUDP/sYQKnEeVgWXD4RbYbYqF9NOZHXXRQsl0vbmgydPAtdAQ5Y/D?=
 =?iso-8859-1?Q?l8qNqF4cjs2y97mJNGJE6okTaQe2lLOt1GmDfH7gr7uswBOYYShFOo4lkN?=
 =?iso-8859-1?Q?HDGiE1E89DNC5ioPjygGppxwi+3VfyOYsNbeb49XFXyMiJRsSKnux47DNz?=
 =?iso-8859-1?Q?7Alc/Z9BE+vXlvKXcXcUk7rLmMjlm7wTQJV1IRl5n/1dAe5srBIDMEGTHT?=
 =?iso-8859-1?Q?NbJx1OSdUPWJ2q18eFF6+iShBjvov8xjLrGenD+7Jmq0cwPy9u4AiV9u/Z?=
 =?iso-8859-1?Q?/mMe8gjmJkjcJWI1uz1J0vGU6PSc0YoSezH8Mzcoydb8dktkwsaWFnplC6?=
 =?iso-8859-1?Q?fpT032J36/wYJ71ia2F9owaT0Hwyt1TJyPjRxmeOZd2Bw+8+iU4cL3uJzq?=
 =?iso-8859-1?Q?K5vzksU2h5tLKTZ2ozljWPL31NsuRKB/LVjBjNKJUJnEXGDlt/6it8XTM3?=
 =?iso-8859-1?Q?BNdaIGZtc3Nv39RN0p4Pg1JXI0wLclg7hKyd2xJKQCQxtP/jtp8wbZZOgv?=
 =?iso-8859-1?Q?xC/8KDf1m7e7dvjqr4Dyr+RvsekoeqtIZZTOHToE6u88nL/YzJElD5oFNn?=
 =?iso-8859-1?Q?tpDqpWUe/YbUgT3VXTFHl9VjN3zFSlQMDjCTPgUXFWV/PO64+6f9fWMwLH?=
 =?iso-8859-1?Q?OSs+0sxvBBBXaR49CvnEQbG7Zo5jkLZkRPVQ2qFPQTVJeCitMouz6obA/k?=
 =?iso-8859-1?Q?kMMGpDEnXGDtNC3H+eJUZANNfDVZrJdAAz+pGKdZsJI1AgunhuAjaP4EpM?=
 =?iso-8859-1?Q?eNTpZzTMGmoKCFbwXTNNVn/xJ9WF/INX9PwaLNTWjXPYNTV0vR1haMUdOc?=
 =?iso-8859-1?Q?9PUVAFJoby5M8sFGBPkZm+QTyh8f07hdmK4VxoFvyIUCJ+ZUIykbzFylOc?=
 =?iso-8859-1?Q?/ojcf10Zl6iSIFHPc3Ckg2EpUr20vsdVaI2mlEn0PI1+Zup/ZnaUEmzyK5?=
 =?iso-8859-1?Q?f0oXsU5B5w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KQhfRy0NMQ07sJKGGyRHC9lJ6DPgxRdUzd9TTFTuT+DTduQm95EyvxC3ewKj540KsJ5yqCODjE7Nw2UdI8bfacElUe0G82TEWJQDHxopMlGVnMhp0Y66o14nHgLuoeeMa2AXdDWYRq2C1ocyTk4MlbUhESVLhcWZXWtuaopJioeZGUF6IHIyhaUjpKRppXje3mtnv6DVllwywVmd8jMRU8iqfiARBTSzUPJRl81IxfZvoMLwtT1RxaJlMJdc/RXgG1kpEk1MmI743sRF5rG6g1iwwZqW0AzfiaEWggTtMpwSjFY9iE1bqpNSSMbYD0w8zqZHmgl4CrJ5+BABhVCPbQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c02d483-1eb2-490e-1f82-08dea0f7b49a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 05:18:08.0242 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXZbGn0QVy84FBm/z5ve9zr1f+527pgt4JPvchLmNZESZMxkRlUunfgOtpygQuHBSAxXgaWM5RP993hC2wkQDux6pjghlci8FTQ5AAx5c10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8534
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

The EHCIfstn structure, defined according to EHCI spec section 3.7,=0A=
is currently unused in the EHCI implementation. Remove it to reduce=0A=
unused code and improve maintainability.=0A=
=0A=
Additionally, drop a block of disabled (#if 0) code in=0A=
ehci_state_advqueue() that was never implemented. This code path=0A=
is incomplete and has no functional impact.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 7 -------=0A=
 hw/usb/hcd-ehci.c | 6 ------=0A=
 2 files changed, 13 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 0ae8c06331..3aec0e047c 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -202,13 +202,6 @@ typedef struct EHCIqh {=0A=
 #define BUFPTR_SBYTES_SH              5=0A=
 } EHCIqh;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.7=0A=
- */=0A=
-typedef struct EHCIfstn {=0A=
-    uint32_t next;                    /* Standard next link pointer */=0A=
-    uint32_t backptr;                 /* Standard next link pointer */=0A=
-} EHCIfstn;=0A=
-=0A=
 enum async_state {=0A=
     EHCI_ASYNC_NONE =3D 0,=0A=
     EHCI_ASYNC_INITIALIZED,=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 57f930b099..23167bf96f 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1756,16 +1756,10 @@ static int ehci_state_fetchsitd(EHCIState *ehci, in=
t async)=0A=
 /* Section 4.10.2 - paragraph 3 */=0A=
 static int ehci_state_advqueue(EHCIQueue *q)=0A=
 {=0A=
-#if 0=0A=
     /* TO-DO: 4.10.2 - paragraph 2=0A=
      * if I-bit is set to 1 and QH is not active=0A=
      * go to horizontal QH=0A=
      */=0A=
-    if (I-bit set) {=0A=
-        ehci_set_state(ehci, async, EST_HORIZONTALQH);=0A=
-        goto out;=0A=
-    }=0A=
-#endif=0A=
 =0A=
     /*=0A=
      * want data and alt-next qTD is valid=0A=
-- =0A=
2.43.0=0A=

