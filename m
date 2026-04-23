Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE05FAD410
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFmSO-0007XP-6n; Thu, 23 Apr 2026 01:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSM-0007Vr-89; Thu, 23 Apr 2026 01:18:30 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSK-0003DU-Ap; Thu, 23 Apr 2026 01:18:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQsGJtzp6JfL4EZfyf80agdBG67hFhKih/UKXJIjGgzrNbEYtZWf4/PAg1xWfU5NwSK0Nqjj++koBcs/ymObNK+0TAjawvuHY0gqlegY7FK+Je1+JyIioU2ZktTH8fZbOYlo7HvQluPId0vwUuINHfoYyRdyFvFXg6Dq7aZdrpJK0EWYvZEDT1Fi1Mks4DMn0F/kh68XjETcmGpvwNhWytFJe26/cW96Hy2NnP9hhaTnFqH4t/r/5NAYTh0EITpqn4RynCmB+LrkyVACCNg2wUVUUQnYSLRQTP787RRSZ6SW2LYB2lgYBZ6FgaFsjDL22JqXJvtzLec4a0kZwxjXyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXoR4UdLkGjcJ3WfUu+Cs03fPTbZxQW3bPIQfbCHMKc=;
 b=gQmlKPWr1HIevPfUDP78RpYkVIQYEylVvvlgHQ5XHKQ9EfD1O2GeQV6ot3KivZ7Kh4IQbFAXLHbPgR6QdTulSZmzNY3J7CLLtOsT4HaegbpR8v1rIN4uLk26RokgASBD/K4jjmjuZPJCbX4WgXWwxSj4ryvmd1/c3Wrw7PcXH5XjsXqDEUJUT1x4zqz4jPsIo0ACrFSKnd2+/g9lJQMLivbzc3L/RRfNxr0ZzsUrht3v+zg+uJ1HAIV58nRMd1umrFxdzozs7cppSmp6SDAmU12eAn2tp4nug0nFz+mkZjWVejgK1SFKJSpNq1qwt1y3KtVvpdEqMyjUEg+dIFhv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXoR4UdLkGjcJ3WfUu+Cs03fPTbZxQW3bPIQfbCHMKc=;
 b=f336Q2vIr7EJNt7RN/conm8fWQoYn8Eyko1gLtoEzgLoe+xooDutp0NMwyxzg/RgLsysTNGNzGeWwoYFiAT0TXKyFCk+rmTmYLlMbxDjAkkjjWoaSxOlPoYV41bbpW7SJNbuTO1qJ/4JQ43SdLUq8ruo1ss3Phsbdn8fhpnmpLGxGWBXQ8bNCWfUjvxRa/9g/6ih086YrRPF5KmroLF9q6xN5Jo3mIU/Ki0FaQTpGHPYKfVBVE9diTimgvknqhG9HY4jDy40sRioCSQISfWQuq77iJpeWV6082iIeXcg3ZAPnHPNqfuBbCoM1B1cnDYF0jGOmto2swKQ2uKz8KBFiA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUXPR06MB8534.apcprd06.prod.outlook.com (2603:1096:d10:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 05:18:16 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 05:18:16 +0000
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
Subject: [PATCH v4 09/17] hw/usb/hcd-ehci: Add property to advertise 64-bit
 addressing capability
Thread-Topic: [PATCH v4 09/17] hw/usb/hcd-ehci: Add property to advertise
 64-bit addressing capability
Thread-Index: AQHc0uCXaAHzE37+KEGxtHY8z15QVA==
Date: Thu, 23 Apr 2026 05:18:16 +0000
Message-ID: <20260423051804.362095-10-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: b4130c4b-b35d-4c6c-5c58-08dea0f7b9c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: WiS88gWLtdxCwmeG1zKXQZYvjvM0ckEAck9aQ+1Ygk6DfLpaEMmsaCclaUsKpjbgrsObgOVcTQ9M9WLXU8fGNRPwdUuudsKctKniJ8oGwVBcH52o0GT3q5M8hgV474QVgc0QVd3LFmES2A3vpY2qn+zEoIMbExJno6Dj9j6FK726AGWa4i3zrbKCkrWHOckOyWBAXOC/M89PTxwlgBVEgBA5QR1IreqmhTMoOwuV+pB17ZjKL7mOwloM6Aw5dQMXL/8H+RWJE2VEoWqUnfLOD4qZ5SXwSchg91ukZ1ezU92cogu61EPxK/nzI232aClIIbiDUS3v8o86QZCGHQnyyT3a02mNy5KPGRHDgj7MPWN/iiJgU2GiFddRfSZDKOSGk3Zl6GbCCQMdSzz/OAJj0Qqydxe92o/V7kOeQZVLMhDSha8igqzy/zx7rWxyKCN+bgqyCxoscf0KSrpKdvkGWfpSBQEErebTVtyD+HsZ0AxGkGVIAZT3T3U+Fhza3iF09sxG7/FrST1eib6kiAKwXjaRAhcjJ1NdW9SSTcHJaApdvikOctDRD9jXetjV0aSylx5ZnkagyAh0jb/M5vekt3bHdVVkKsu/H6X9+kxbgxZBkTn4O36ptuDb4+ECqSm8DHdK3ImNorCr9tZ6HHdDCJU3K5Xv98Urpv+fx8zC3p/SDNjWAaLrNHZhgrqiLAYCvb1W7c1HIR8o/CTp2ia6RxArX/AEHBDeUc2oS5vFn69+kzf0edXPSpc+6z8P8FLM3Ihm8THgu7/6io5J/uJcXj3NYiWlNsNtY1XynVO1OwVEbwr7gd2Zvj1Y6l4kF7nZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BMIUP2C/Riq/8Uyfy8Ngy2K4dgcCc2mgF5mf5bpiNnjOfdZHauBJzvIGcB?=
 =?iso-8859-1?Q?9bWbuGWdlBk+f9kFZSkFo/cF76jL6m6jLc5dfsu5mzNy1+GZ4NR70TxieV?=
 =?iso-8859-1?Q?IJv46mI4LXe1q7n9AvkeNbHNK09vFdYduLo45v5WzmtRFQiapemBHvU0O2?=
 =?iso-8859-1?Q?6bxrjUa2Y/h/UlfBRS9uL11y4Ld5/tMcoyggtMcGHmRqfw+lDKd0CA2fNz?=
 =?iso-8859-1?Q?haVwbqYnTrZHuLC3oDeeqhaW6BwrKXCqQ95+VnGTY2T1l6HDhd3YgzF8Pg?=
 =?iso-8859-1?Q?02Y97iDH+IjHCtopyKzP+eNEl+Ep30M7dyeXuxoWlHA2a2MJRA0xaa8uye?=
 =?iso-8859-1?Q?F92JZdJO48fkz9riZh3wBwNmO6UP64AoZ+ljfuqaP9DE/j6TzsPsrsVgbm?=
 =?iso-8859-1?Q?+f50igFeIc7XySXm9JRl+cZbsN3dSUVydH2jqDMQGwErLA/pNw9nYVHQHJ?=
 =?iso-8859-1?Q?N1mirQ1cBhxVjJlfxNYM+bxMFIXj+wtVL8l00XouyT7Wi1OOXAusJEYZKb?=
 =?iso-8859-1?Q?8nMo4N4ECX5gYEn6oRXALHUp1A5hiiKhzq3LYbzhNk+V9WcTy2kytfDpV/?=
 =?iso-8859-1?Q?tm1PLy1FKckYHTkT/d0BD/1KwlrAyAaGkOBIkcfxBEBdRt25YMCluf7qZ8?=
 =?iso-8859-1?Q?YjC3L0+scWZxONQTNup3EkuP0Ex/MqwHjqFIIf8IaQT71bY/oBBcZ0dIYQ?=
 =?iso-8859-1?Q?vxd6Gd2uE1YJyTFl4cIF+LLcRAzc/gaAb/5zOwykiDEe5YsuyKz7LIQW6+?=
 =?iso-8859-1?Q?R+yr8Z7lZ3t1/jxttsV9GYarLwsol7tkLtYvj1FhnCxbTseJvrhtf285hg?=
 =?iso-8859-1?Q?ZPXxZ0lb5ZhskWJASXTjJmmDV4XycnU5Ah+aHQkryI8aW44lNpzdX/PTeR?=
 =?iso-8859-1?Q?qShN1AQ2GLRhWCoqfNo2zr+pgVR0T7W+Wmm3j+lDzURUHjPAwcReKnawoG?=
 =?iso-8859-1?Q?ty51jCNFYSItTevpUPJGNXSdHwCleL2Qn75rAXm6K4i4zodAlQ2RlHDQYS?=
 =?iso-8859-1?Q?VehUwB068K7A/4o1IBf8a6+/VIQZqSdExPpflg5L90fj+8/k+IpBUsaS12?=
 =?iso-8859-1?Q?d3Jl3gazmVsteELiYAINM+W6wjA8jEJc9s/Ajb+27sQdIEmAP3Eiqc3ddy?=
 =?iso-8859-1?Q?4XqYnRt0xCO2YTTowRZyTRVo1gRUVaETqCRaLau3G5Bf1vGu+QEtLCaHcC?=
 =?iso-8859-1?Q?LTjZ6jFu4hHagktSwPY92zBtBUWb3MXSbxcDcJYFhQpkxuhiaUK/w1RIKS?=
 =?iso-8859-1?Q?IEkqBxwdUKxmQnUgdm2vqjWgA/qJo4zvtPgiHPh78axOel/qsv4FnYLS/e?=
 =?iso-8859-1?Q?ZuAAoR0ECi1WzqTo0b8OFDGa7G2cxDk8LzqgGDRmHPav5C4LxSJPGoTKfi?=
 =?iso-8859-1?Q?qBX7njaD8n/jU0mfYFCtkAO6X/muxj+H2OmMQCz9cXs1CBNyJEOy+6VPoK?=
 =?iso-8859-1?Q?CK62x+OKl7pQbKeVIuIWl2uGK7jT1kgomx86oG9AijTVlVFYqT3EBzR6i0?=
 =?iso-8859-1?Q?5pnB8mpWCzsARK0FhCdt9MGXD4+LdH76iox5GWOyuVWCTU4HWMdc0URfri?=
 =?iso-8859-1?Q?eHI2Opw8zccZADyZt87wniKXEFosVTQVI+Yg6gXSEgejMkjgxTq+dl/gOZ?=
 =?iso-8859-1?Q?8JaYgn95cG0niidYAZL7hScuDD1W8/KNsoIstgrK1Z/5gmBvBvoae0SXls?=
 =?iso-8859-1?Q?uu9lMdK7A0s0tNRLVEFwRgl3UJajrgVk32kEnXmUCJSeixEo/zB0Z8PA74?=
 =?iso-8859-1?Q?HxXM4NuXvcZ/GMDVELJP2hvltFsct7NXXlEt2WrZbN7AEZw8Z4jeoCh6qv?=
 =?iso-8859-1?Q?YdfUH3VFAA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VZYlXnGHgREI8zvE+JzJK+Ob3wZM8C86zRynFy7v3RPwmUbjkHxcSQ6FhiwYmUvzyp5Z4hKVswfWUX9Omjuut6Sk4ih7VzYyKhPVJ35LYR/Rv2xPxwSHyrLFe7DUmIc6k2Uzf1L/QrlK9xwIB4U4dvdqFdemI3WOb4Z851YyE431oQK97qBV0YDo8M4pkVsFBmpm0ZejzEj7H0wuHzxBlMDF7OzHM+h4n/DkZbSbfTF/BPa5aVCvHOjq70vNOA0U2yS9IxUkiSbLGxLNgdz8z1U5NbYJHWlSL2k4J0e2j//cGk4vaX6OAi2YwvaoDV+jyTRTg8crrQ+Ga7ZiNKYqIQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4130c4b-b35d-4c6c-5c58-08dea0f7b9c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 05:18:16.7150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bJzCKXIenlurktva3H0Vvyf34HXFlEkOQtVkIO7lZvgWXpsLX8nK1im6JzHOPKZu9beskPvlYngCs/1sFQhKrmGHqMBooLeBqOTf3IC0dVk=
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
index 3acbddfc5c..f1f2fde578 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -257,6 +257,7 @@ struct EHCIState {=0A=
     /* properties */=0A=
     uint32_t maxframes;=0A=
     bool migrate_fetch_addr_64bit;=0A=
+    bool caps_64bit_addr;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
@@ -313,7 +314,9 @@ struct EHCIState {=0A=
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
index 0c8bdb48ad..b23ff92e12 100644=0A=
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
+                          "      64-bit addressing capability is disabled\=
n");=0A=
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

