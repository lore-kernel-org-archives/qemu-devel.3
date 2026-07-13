Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A82DC44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 03:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7KD-000078-Tu; Sun, 12 Jul 2026 23:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KC-00006N-AC; Sun, 12 Jul 2026 23:27:20 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wj7KA-0006V2-Qz; Sun, 12 Jul 2026 23:27:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmEJxhYfhRNenYWET98Ae5+yk0NXo7shiKcEKgP624tGToj21+9OJ+b0yQR2qNEjqqBWuo7WNzogLpOBHpDYdPEJfQhzKSLYtKUCyMXLPT80oqLEwSu5e/vujzI5/mtOieUrjOmR/zqzLqWDEtxAMMer3xusGY567RkZ+z9HmAdjIu8Mu39c804hd/SKMq+cyQ8YrBuHrMJq9vqC14Es3QzPHuJF1UN7/lEizTvpJoM4P7kBGONvEh6DcClUwoXz2mDIqoEdwhxcHTIJpnWMFbLaRZR956qbMw0mn+5B0PxjwKytIXB5TqlAYvHtLOkcjrQKCpm0f2ZB0kBq2sfIbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTVRdH0uBhpjhim9+GWhuh5kMccvyBUoqoca5wbul9I=;
 b=oeHRjnuRj9U+Rjm3lbyM56/bRKTbkKb1a8xgbmTdkoPLotLXkjvp1neKhqE3d86EdYEJVwrOYGYmFXTDXHV+8fzYkrRLlMjZx0NB2RYaFMLqpbY9UMZt+DYa/eAhsD8aUyhk45nm+zPOekcG3Sx4Ckek7ZKea3sQJ9ecFimB7x+nAog715eABvei3cYU6+9rQRyjgppF9SItgEr5p7Aw4DDIPd4R0sYfa8I1+RAY9VIN7VKTzjh0qndJ733RA6L98JRrzeoVUmmMBcivY5rg21oWDRi/6NXzI/GrE7ZG32nyjUqhx2iFRC2zHFT90NIjD8njHw+uMl6qaNTcRZJc/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTVRdH0uBhpjhim9+GWhuh5kMccvyBUoqoca5wbul9I=;
 b=ocOGybJiqggUU6PWzmoyfvJg8GW1I33aEIi71d2MK60i6tQQ6w0v/+bmbAYgD33RRO0SVBbCq2HUIH3cx9jkNzYhTtjgjCrDH9vZ34/TdRhFZjRpOuTsP3Feqeh/MbJA9YticOVcbDe2ywU5X8zwg2mBPZ9j1fFhvm1IC/SZCp9YeAhpiJbp648Q+jwkBl+bAEv9B3ZHhrCC1rmjyUmIlJtBEYbjIt9Zh11mvGqp3SCa/EuEHGjU0h8Rc0cAX3D4EIWznzDMh+iH2Xbv02ul3F2gQzldQDtZ4c/UFiA1z4gjdkTpStlBtts12Co6RwBKS1Yh79BJHTecgACQQBU+8w==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEYPR06MB8221.apcprd06.prod.outlook.com (2603:1096:101:2f1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 03:27:09 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 03:27:09 +0000
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
Subject: [PATCH v7 02/10] hw/usb/hcd-ehci: Add property to advertise 64-bit
 addressing capability
Thread-Topic: [PATCH v7 02/10] hw/usb/hcd-ehci: Add property to advertise
 64-bit addressing capability
Thread-Index: AQHdEnd8PdYyrxso10yrO2lUpH7qmA==
Date: Mon, 13 Jul 2026 03:27:08 +0000
Message-ID: <20260713032704.3583103-3-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: ab927d66-acd7-4a14-3c0d-08dee08e9efe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|22082099003|18002099003|38070700021|56012099006|6133799003|921020;
x-microsoft-antispam-message-info: qLtJ4j24UuT+pnTmADmYoMM0xY+wnBZCOnLkbR0Aov8axHf/qGNWFM9F8RDX/PCNSN7j8HhyUyb2r0yriZCND5Ql35KLHS8Fd1kviKP2RjmBLY5PtmbyhEsHqdI4yRkzWxa6HDrRfoHsy3Tr+a3rizV56//9SGV8/5EIveoYaAF9eYS8BBw3I2bR2xMwskHCGZDjynT1Do47ED/98D/JzA0hLWX13RbmNsmODJ6o0b1N7t1IlVkISjGozphY/9pD4prvBZY7/B4cNfscdiSuKXQRctdQnF1Jt1qi91IYyC/3LJiqX/S+N60SFb3JNtPkSxDiamnaD2VeWJYIWbZHYe7gVUCURyx/hYHae7haFXxxy0CV7oA7SZ5ygDEZPBa1RVQ/knRkcZI8HONCTDG2RUG8kklzvHWKMq4J2CQkUbdUDUm+E4oyT3jR2LhPm4QRPK/1hotppPN6dhbJxWukKjSP7NvFwxEGdIqG5vqqW3w4lUYl9OO6oT/PCekuNOKqda6pnr3uVyaHP1uj61dw3Ote3TNrbOKUgrHLE+zDzYPiXV6fYfVSEcLzr8cT61DxPrdBNADyaq1hr7Yxc2HDTZdrhcaS35xGX8Jji33Q2OL/MFURqkEqGuhosOPyZhKgXV6wapt1nZzJaB1MbC1C70T0tiGcfio1tXmx40gkKOJhTHfBDCN7HWrMLwsvnq1AnOVZWT+gyGS+Qx/qIxGQmThCZtNYgpvAGL7K6v1Jh8Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(6133799003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GiPdo5Yf4aQxbSFWmnuH2x1CjiVPnBCbLGrW6AJ1DzpRoRYvuWU3AlRNmJ?=
 =?iso-8859-1?Q?iS1WcX4ArKfz/W+/oYHPl0khj1w7++Tp/HdT+gJLMbs88mcBLRWJPhJLrN?=
 =?iso-8859-1?Q?vZUTcQLHFv2zIMriULAvSLKncSFVKoX0wOxPUIcQqu/uP5IBS17p/LiF+f?=
 =?iso-8859-1?Q?0tB7J3oxIRhgwgjmOsMl8yqnZzgqCPEMTDC/DcPUv/a71QIkpVSfklzW98?=
 =?iso-8859-1?Q?4eZGjkAlqMAYSI2KA9arnEZZzCGIwCdshEPga/JGTJHpF+hMMoAZJrqQyV?=
 =?iso-8859-1?Q?GjymeSt4XfkB5riAjomPWu9pgrJA3izr9Blc/LHG6AKgJNvv4quqrj+L5y?=
 =?iso-8859-1?Q?6hD/IE+L4o39P1hQMmFK3VVDGJaeVg8JyUk48l614h3uwg2KkUZbsQUqD1?=
 =?iso-8859-1?Q?wpjbu03HNVdPS4LMA4lo7NsLc9scYUgRdXssIpZbSG948xrtc6jFV5Ngpo?=
 =?iso-8859-1?Q?begaECmzzETRy9Iw6eTMPEkG+lNhKt77K5ybPBGx7wz2P+m9EraVuZaDH/?=
 =?iso-8859-1?Q?4C8oPjMvjY3CLdzAATMNavoaXWdVKklgjzwqT1RHUYoXee2/c84PO3CVsr?=
 =?iso-8859-1?Q?9ansDwBcT7pA52Mc213CuypszbziIna/ocf8xu/87c9bqIa6OIj/NotNay?=
 =?iso-8859-1?Q?31/CpRd+AUqNgHqzPnZBXhEuP4/TZPIUbT74EgImfjhntTH2VCFtDsyMSd?=
 =?iso-8859-1?Q?B/wmsE11wkUdfCJIM0DFYk+Xj536FykztrGSyGeioB0y3wDpJt3jN32oYM?=
 =?iso-8859-1?Q?jfrYZkYk6rv1K6HAC+C2RPDdGtBd06N1j/pvRKiYBlIYSUJuuLhN7CBcB0?=
 =?iso-8859-1?Q?mLZmsFk8mlpWPePiC2u6QP1JF7YZ4MH1qh025VEkf0EvhYwaeZs8sId+F7?=
 =?iso-8859-1?Q?83dWloiIEudJd2y4rY4Miwe2cC70/hZ90Nk/4iLD4BwYMhqQbuLiVoEON9?=
 =?iso-8859-1?Q?yb3juLVAzYRSszyHPCYA+S+heZOC8OVwrk82hWs6KZC8cF3PmMAa+zFKBc?=
 =?iso-8859-1?Q?WhSvSS+wNQDZANfPFB3YWxwBf7C2dUFVtZCcBIOlY+r4+3vfquYjR7HQ6l?=
 =?iso-8859-1?Q?1fKYCjzY7sDtUnjNAPBN6SRouJanxZ6MEmbBikfpl3UPAJnDo17WCdP6gJ?=
 =?iso-8859-1?Q?PfZvkUie/tjSsL5pl6HMniF1lpzjLJv1uZy99a5MH19YSS9Lm+ZJqYu90F?=
 =?iso-8859-1?Q?GjymTMpJQwoJzq3R32OCVt0siDwuhZPD31wrLQxPotJjJx0V0X2vCi2n/8?=
 =?iso-8859-1?Q?qfmzoXJMyka/vNRXe9bCDTrRz6wmS6t1Z7rNNABO9iJNh//SG0BLcZybbb?=
 =?iso-8859-1?Q?SwYIglsU8cxysmsXsoDcqca1KGlXUJK62Ape8QedrLJ93kr5WJZetG/8CG?=
 =?iso-8859-1?Q?CE31BhGRQYPyMhdPiKYEwScRBdBZiVb/izl/NFcPAz82rU1Sz4BK0G+/0p?=
 =?iso-8859-1?Q?icX9lOTpn1D7wUxU5qZiodwpAp3XqJ0twzAmROld3H4TPVPH8BmkVe0gKj?=
 =?iso-8859-1?Q?nI8+qA1lzhuezSu3OBgJnn922R3iTx8TXPK41HVY3L3qKNWnFqA4HoviWQ?=
 =?iso-8859-1?Q?80GbZlwwrBpgWvImYZ5XbEMpVYweR3LwMScLkfXilkDgF+gGWNylv9dosi?=
 =?iso-8859-1?Q?axr19tozEpZRSPE8gTTGmR31EI4ugZ2WrGjibQgfI+gOA3kb1tqJHGOlgH?=
 =?iso-8859-1?Q?JlLkzh+JGrNr9RfhCY7b206L5lLIyC9tWHTIQ9VmPR8CCn1HHW5pjQAVdi?=
 =?iso-8859-1?Q?3GCtk2yqiy42zQY4vZRi8ypQcFxL5b7JuCm2wjd4zCiEMoqtfZ70vZoAut?=
 =?iso-8859-1?Q?e/xqX6nXQw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FZgRHNxe5LK1dhwP9OHRYohe9SsEpULepMfWa4AOl+I9Z/Hsz/dM3PwX+9zk/D0PAG1i6pp9Mon9c2NynPMXCV7TK9bjlr0PCreHguqnmvTBOp6u1FFwNL5o0nzKjWo1sE6sUS/xaPkgccmv5P6Ibd6PXQyHpNmsXttvco8/9wYDF6OUlRUjkT2jjq6clZEZ5Ss9gUzRvRf+b+/j9cbZRvb13UYsAVk4w7Wy2Do3579lqtWN8BzjkZreJqEph6s+j8eYYFCtCjmIrl/qrGnz8xijFdSuCRKflUfaN7NJrVBArhUjy1J/sxyRu1B8xj7iezwb0LqiJ3a5NPrk3tJX+A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab927d66-acd7-4a14-3c0d-08dee08e9efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 03:27:08.9841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nbJrO/SB/8883GNh13xZnnFZXvnCT/PWmaxfKCjdX8WpUjxmwclhCAB3VOm9jKr9XKVtf+w12dzXkyytgh8zXWC3qhtN879GMUO8cPGybqE=
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

Introduce a new boolean property, "caps-64bit-addr", to control=0A=
HCCPARAMS[0] (64-bit Addressing Capability).=0A=
=0A=
When enabled, the EHCI controller advertises support for 64-bit=0A=
address memory pointers as defined in the EHCI specification=0A=
(Table 2-7, HCCPARAMS). This allows software to use the 64-bit=0A=
data structure formats described in Appendix B.=0A=
=0A=
When disabled (default), the controller reports 32-bit addressing=0A=
capability and uses the standard 32-bit data structures.=0A=
=0A=
The EHCI CTRLDSSEGMENT register provides the upper 32 bits [63:32] used to=
=0A=
form 64-bit addresses for EHCI control data structures. Per EHCI 1.0=0A=
spec section 2.3.5, when the HCCPARAMS 64-bit Addressing Capability bit=0A=
is zero, CTRLDSSEGMENT is not used: software cannot write it and reads=0A=
must return zero.=0A=
=0A=
Add a capability check in the operational register write handler and=0A=
reject guest writes to CTRLDSSEGMENT when 64-bit addressing is=0A=
not enabled.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h |  5 ++++-=0A=
 hw/usb/hcd-ehci.c | 14 +++++++++++++-=0A=
 2 files changed, 17 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index cbc32c296d..f739e6371b 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -261,6 +261,7 @@ struct EHCIState {=0A=
      * Old machine types only transfer 32-bit fetch addresses.=0A=
      */=0A=
     bool migrate_fetch_addr_64bit;=0A=
+    bool caps_64bit_addr;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
@@ -324,7 +325,9 @@ struct EHCIState {=0A=
 #define DEFINE_EHCI_COMMON_PROPERTIES(_state) \=0A=
     DEFINE_PROP_UINT32("maxframes", _state, ehci.maxframes, 128), \=0A=
     DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \=0A=
-                     ehci.migrate_fetch_addr_64bit, true)=0A=
+                     ehci.migrate_fetch_addr_64bit, true), \=0A=
+    DEFINE_PROP_BOOL("caps-64bit-addr", _state, \=0A=
+                     ehci.caps_64bit_addr, false)=0A=
 =0A=
 extern const VMStateDescription vmstate_ehci;=0A=
 =0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 1a0c580115..e65ea825b0 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1109,6 +1109,15 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
         }=0A=
         break;=0A=
 =0A=
+    case CTRLDSSEGMENT:=0A=
+        if (!s->caps_64bit_addr) {=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "ehci: write to CTRLDSSEGMENT while "=0A=
+                          "64-bit addressing capability is disabled\n");=
=0A=
+            return;=0A=
+        }=0A=
+        break;=0A=
+=0A=
     case ASYNCLISTADDR:=0A=
         if (ehci_async_enabled(s)) {=0A=
             qemu_log_mask(LOG_GUEST_ERROR,=0A=
@@ -2554,6 +2563,9 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev,=
 Error **errp)=0A=
                    s->maxframes);=0A=
         return;=0A=
     }=0A=
+    if (s->caps_64bit_addr) {=0A=
+        s->caps[0x08] |=3D BIT(0);=0A=
+    }=0A=
 =0A=
     memory_region_add_subregion(&s->mem, s->capsbase, &s->mem_caps);=0A=
     memory_region_add_subregion(&s->mem, s->opregbase, &s->mem_opreg);=0A=
@@ -2613,7 +2625,7 @@ void usb_ehci_init(EHCIState *s, DeviceState *dev)=0A=
     s->caps[0x05] =3D 0x00;        /* No companion ports at present */=0A=
     s->caps[0x06] =3D 0x00;=0A=
     s->caps[0x07] =3D 0x00;=0A=
-    s->caps[0x08] =3D 0x80;        /* We can cache whole frame, no 64-bit =
*/=0A=
+    s->caps[0x08] =3D 0x80;        /* We can cache whole frame */=0A=
     s->caps[0x0a] =3D 0x00;=0A=
     s->caps[0x0b] =3D 0x00;=0A=
 =0A=
-- =0A=
2.43.0=0A=

