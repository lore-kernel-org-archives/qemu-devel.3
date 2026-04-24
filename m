Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5FAFB44C8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBZd-0006WB-Lp; Fri, 24 Apr 2026 04:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBYW-0005da-84; Fri, 24 Apr 2026 04:06:35 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBYU-0001I1-EV; Fri, 24 Apr 2026 04:06:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiAack2L0ombWbPOUuLthpUGcGByq5sqZirjh7ODJlBfy9OzQP2qb888OtNoHtrJGIgRd5KlTEPbeMOmZp6Oo/9PcYai9ePh/PuvsjbVAJjxMv1vUiLeJ519zG8DeTas36McfWOZSjRndN6inaQTnn5Ul77bwQf/ON9jJX+fLfPdHsKK4cSbmw61Mu6wnCrWNOk5t/LI536Ka1JCTlvBzYh/2Cuib0F+TsLtPwNhAcK6qy9vVbtHqOkcVFjSWVHHf+H0BHqh1dvpcIsbZBwR6EHNGCOvSofWXfC3STBmVAmYT0nFbxJ5uqIBN9lrT1tsSpcTK3fGRKeYTDhFnJqFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6kJShgNwc7EOpcMbd0ButIrMV8f3NyOSWSt8Ki8ywk=;
 b=ce/Ra0++456FteFV3JO/JSzynCjdmlQaHJTnzcgBAi0Uqj+rw8WVL0AFsr8Y5jiACVPlfb9MWoSShjMkp16pb0dJJka+V2ArNPMyDETyEMHM8YIU4wDI+KOF6BJnOL9PytI8TqwnFoXB0CXqecwY6JA3nc/jLR7uSLHvnOcNacKiGUcyR3auEsY16VU77Z/yxPy7kjBSHLVc+f4CbmygO81qMkAnEJZG/IxbJbW6XrrfyFOcmLTjVWQWfjdlLmu+Zijc6XZT9clSLUtBrQMwxQOnnBuWBTl0fbK9NbyhLLQLUxDmaT3MYcyW4ZDxIhK7r+IqDnIeCG8mSwqQJHfsTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6kJShgNwc7EOpcMbd0ButIrMV8f3NyOSWSt8Ki8ywk=;
 b=HQDAE5aQoCiQsZCnt5yJKvQ7XbP0At93Vwr8hUIWVBQcDWXBZtjWnJ0SXJWYVucbqgh5YdbBzW5P9O3xlP+j9abBCzM40OR3kXnAPhJDvL8OAFGIcgREfxGVwTFyyq2F9Ba5zWJZV/Ug+dCT78mzQIRPSIW7pTemCZXibLJz4qBrp/wk7pC0XrYnIHl35w2DVAKy93a911BeQN8/C7ygN4tDhYGW830ShQdOEbvsS0DFEDMCZ3iz2KiKC5d4IxxmI7OcXfxEZjHK4neY3sHhZLmfbrqA6d8aGymNYQgmdbqMUCCA6CJ+TmWpP4GaCM7G/YxdQzXFMtK5DcR0FvwbMg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5856.apcprd06.prod.outlook.com (2603:1096:101:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 08:05:32 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:32 +0000
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
 <harshpb@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, David
 Hildenbrand <david@kernel.org>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>, "open list:sPAPR pseries"
 <qemu-ppc@nongnu.org>, "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v5 17/18] hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA
 addressing
Thread-Topic: [PATCH v5 17/18] hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA
 addressing
Thread-Index: AQHc08EfQHPRAYdYyU+9/PcUTUe6Dg==
Date: Fri, 24 Apr 2026 08:05:32 +0000
Message-ID: <20260424080508.53992-18-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: b34d0b56-0ce6-4f3d-8d11-08dea1d841f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: Bp1HPkZoSlIYK8UQBAjESFf9Uh/iAqWd1wSDwQvVMsKsQqgRf2HI97MO7SDE0ju3IlvmWshD8wGDyY9anwMRCgMqhp1//vEznA8X9jWb2BI2QbbqQvNxWEqGGEMA/5thnwuVZEkB5n7ycfVH5eHVlij/YaZKZynJ4PuAl8Mzt0huI+h7pDQuG2fs264OVFPK63y7PkykLAKH8IUMy6Bp/ZgIoD9REuY14ShtmJvYqTwN1QOMPLDiOT23rz+ENM90X56F+fL7mFNY/NvQOO6JDdI6nWChq0bLDwxlqKVa2LJom8w/WAkj+25rqRTemMrcyo7n9v1bDL+UT1CCakSr2B6on78U/nwbfZykth2TgtoO0Kap+1QG26CInsrUZqsbsxyoMjDzX1wTcToDMOgykowdz+GGjC4BxJ9bB777TvB7y0mdczcxuR/emQebcUhYspF3naCArTo8g6/y9kYoaobv64oZRK/6rqhMgtyaDJ5w27QDpwNMfDhmUx+rJDTwuh7icS0MGfRl2UZANy6UJL05B400hPAS7UYerg/vHfEM0D2ngfTwhsfkaF9sWV59n5UiyPzKao1Zb7OypK/dBUR3BVvxfSfgiqEEApVCv3OjRkN984N9oUYepAVMp9+7BzjJ7SqzKT/2VCfSh31U4LwrDmIr5Q5jWtJjrXdwKbfoiS/Ohz2e4Xl7AnXZlb4XKeQPEZ+ish+cxsEalRrXxmM6EKaRxC2Tm3MEbrRhh/JFi1NUHzMCHPQYpTbS51ikVri0bACOmHtuta5Dn5WruFKMvu5IrSfEJA2zMLObowxXprSi4K+kdKe52CVPzHbO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EI4hn7OEpuZjnz4+PPSGnw58RFyJ85MS51oAWoGQLRnNvW27l+BJpbcik+?=
 =?iso-8859-1?Q?Ca41fn379qpCmTy4EZtwqDhbRM9d/dEkCswSdqb0QLYl0vq266tGmTRIqf?=
 =?iso-8859-1?Q?Z8C17FgO9+TtGfh3QT25pfYFIZ3ifW6WuXvpMgdJdrKvI1lq234YyWF3jy?=
 =?iso-8859-1?Q?A9lkzrYiOUQduYN1/ZdUhX74v4bWX1lxw1zwiE4xb4EFZaRicNH84KXARs?=
 =?iso-8859-1?Q?ea33Q43vfvz7ZDTts13ir9aYbFCvBK48I7VD6haj7XVMvbTDNttKkT+1R1?=
 =?iso-8859-1?Q?ioCFXJnoQKso03PqP3DVqYCdOiAnn7nPdwYuUTTecjvNXzW674P/XqsiRy?=
 =?iso-8859-1?Q?Ax2aIZpM1a4xrek6DeKQ0G+/l1cXsWQqmraOwN05DAqiAN3uJP+XI88Q7q?=
 =?iso-8859-1?Q?WHy4YdTJNXbGEuW7xo/ePf0IyZpLZFPjP7ptYQQB9SGw/Wy72rjjeSlelO?=
 =?iso-8859-1?Q?JsiizNPZD6PKFuCaAx46UFLlkmJpwykAd/k1LXlb/Mx67AW6/mAtn7Obu/?=
 =?iso-8859-1?Q?7zX2ct5qaac4GTBV/r0Z6dAQ+WU44EtQtIo3Im5wf++mkapOtudchXwsvI?=
 =?iso-8859-1?Q?K+beGiLpLri/t0R9yeZrIonEMZ40YtMdzNx/Zi/7cPaPpTmCwcw3V2QQ46?=
 =?iso-8859-1?Q?XyOGsOEqlYiauJOGzZ6dcdvpG4z1coAmk5a32rxpis/gxibUkTZsSHuH77?=
 =?iso-8859-1?Q?s6yId03TA03dBGwnGZ3CotyFCTD/l7Xn9BbDjIAHoUpT1IucFaLPfEjeq9?=
 =?iso-8859-1?Q?rLPBhZZWqfpU3vpq5O9kzKtxvS3Irc2uFiX7fmnsKMKa6GDhAZfubdtQKP?=
 =?iso-8859-1?Q?YZ/E9rebXf4NN6ZYxcd73Fu7G2em0DFwKi4tlyqKSnKmlMvOcmSqFFuJ2k?=
 =?iso-8859-1?Q?LU1N8WsdzVZq2t2/p8glpJ72aS8hJ0tIWeYghW5vMqF2OEBrfANZC0zcAF?=
 =?iso-8859-1?Q?btwh9qalYdeJEZU0KKlwC54KDeXrWFIrAB0kl6kAKgCXXV+mlT2fcNDApB?=
 =?iso-8859-1?Q?4HMDYbZgaYli45sxpU3do0Ukd26obMk7BhR8Ghe/UJNpFq1p4OVdeaEt7A?=
 =?iso-8859-1?Q?cflmn8pi+pQYs+Ap+qVCxQJnb8gCSG2pxDaXjPn9W67oUcLjBIrnbhtLh9?=
 =?iso-8859-1?Q?d/8SJ2Vxofp1K8fC0O/Arb2QQ/y1ZjjwZM+nSXm+RBF53FAqHWy8P/3/VQ?=
 =?iso-8859-1?Q?xBPFzFOQHVSN0rliXC2wD/zBIEt46tTpogaLIL1cccKmR+dzgk/Zh3sGHE?=
 =?iso-8859-1?Q?Qm0A/g2I1kneW5RYhFGPbK474lVskjS7MH56T45ns5QGViNTTLbz4H2OzV?=
 =?iso-8859-1?Q?VhcFoeqyRYEl9Ql8rsh5GWRK39qOzR5PshVm14jzY4xFj5b9DWHiUGhXAI?=
 =?iso-8859-1?Q?nII3otxhrZMtdq+kyXz5pWDltvgKloNssf17cssOCzbKVr7U2daFBgHEmq?=
 =?iso-8859-1?Q?zEJbNpZmkDQvN7fhp6vjJa2Fs8ymBmLVx3cLXyZa4KtezNVObVGY3mEnIS?=
 =?iso-8859-1?Q?2HdPNWXq1zoj6s1TOempeURHg+yV9fwaku8EuRyQyocuD2OEC9+/08mBBw?=
 =?iso-8859-1?Q?X9qJxjSISs3IlEKqfLKv2yfDyniQLcuCTxH7u2cpDgzjvjQfU2QuBdRbNi?=
 =?iso-8859-1?Q?lXKzTTBUpjOgqHDZ75M6yDyNOml/zIKzSPKlPhtyll6CSQS28tZoBmyci5?=
 =?iso-8859-1?Q?p4iVLVhEFPGkrP+tkn/+bUDyQeI+eG8kO7wZ+m+8+1ee7IIRtmfaHb8csU?=
 =?iso-8859-1?Q?h7GRd71HdWCJyZEH2Lh5qsOLv8vaLkeyTxTctff6TckSL7GioBDshQpp07?=
 =?iso-8859-1?Q?d1UMfxtcEA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Pbvjv6egSiQYCc3lx9EhuUedOnTy6ZYA91LJSRN21p7UdM7j3nX7osyFqo5eUI9dsKQyKDnaZoQJjCl3m/ZC7YNd+6uvC8pTz79scH3isl6OzugnuEjqpWJSC6RNdzIC/WIrKjS4hekG8VugN8+3D6KHRU6lf2H9CpDquFQurmTeuD79j2bVmzzm1RMpIh+do/ZHrrvts0E4pCGHPuVjwkDFZcI/ScgQu1MXKhZQAgc9C+5+in3STvfdgvpehyc7fK+RDgNq5VnhQHw0N31g3qVflzyxx87AqXz9QEg5CtPRqUtv74QivDnMoXzHl8wJyWFOaP3yrX82NH0HtZzhZw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34d0b56-0ce6-4f3d-8d11-08dea1d841f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:32.4101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HKBNODmuaAbC3lne4qyU1cBlODoNFTpSlQd208XyyRmvVvBEgoBSySOp7xG6LqIZE9gwk097NScapRi0zlzBmYsKVZTmdDoTIVEdarq8UXw=
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

AST2700 supports a 64-bit DRAM address space. Therefore, DMA=0A=
transactions must be capable of accessing 64-bit addresses.=0A=
=0A=
Enable the "caps-64bit-addr" property for the EHCI controllers=0A=
on AST2700 so that USB DMA operations can correctly handle=0A=
64-bit memory addresses.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 0cb39dc191..4959cc9e43 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -858,6 +858,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
     for (i =3D 0; i < sc->ehcis_num; i++) {=0A=
         object_property_set_int(OBJECT(&s->ehci[i]), "ctrldssegment-defaul=
t",=0A=
                                 0x4, &error_abort);=0A=
+        object_property_set_bool(OBJECT(&s->ehci[i]), "caps-64bit-addr", t=
rue,=0A=
+                                 &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {=0A=
             return;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

