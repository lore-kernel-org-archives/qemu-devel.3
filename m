Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C1BFB44CA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBXV-0004qg-D9; Fri, 24 Apr 2026 04:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXT-0004oz-6f; Fri, 24 Apr 2026 04:05:27 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXQ-0001Fe-Mp; Fri, 24 Apr 2026 04:05:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVIvPrHXh17aUDKqTBom5QeHcbJcGw4TqruZTRfpplPSVTa4ZV3BtwBOj0ihWuZqBUdsrb3BDd2lEW6hufgegNCWOOPzEyj59aJ6tzhNZ1VzRynUIqKg5DhbEUEm1LQVwmRxwskAKnO28XixPkJn7zRsjU8gDxYFiqNhyWb6HM1hLo+XlZCj9As1fTpS/odhkJFQM4RnKPeZpXiAWCyvcNzTT9I3YXu7rxNOV3m3nC95FaXOlDsE3k4wSRMaopy3/ADNcVSvSH2m4/Lmn0uUKAYC0BPKsg6AzenpATCD9ZrJUqz34FNe4ie5vu5gK1w1/717UsNiZCJZf0+EehUSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwR4naIx23sJKPSRHSeZ4okd+xkvAW4yP6Gm6sin8q4=;
 b=iqSvcLsP4kV+92oegPwfb303Izn62PBDha4j9IbfReVvCmGSAqyqUlhUVK/S9HdeLamj0ey6P/rxFGz86o24kX+QyMN72bVJkt6ymUB1lRVKEmzFUbexH0/LHiupM948kejnpc+EzLtSBI07JgD3ifb1ThI+wF0jmhmu7pkb6JsFrNxDXzmTSaNt6j/ZSTmREex6c+3JxIjoiRU1mYCNthznvY5+ftbBkJhuhKKZpbUjJrNHv7ReiueYBQNR5uz38Kb68L86Yv7SlC0SSr5M4egjjkjEvPeeGz0NIi3UWyJVsSrZIYzAoqk8NouDCKD3x9tI+rFlS5XHHdwISw8c3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwR4naIx23sJKPSRHSeZ4okd+xkvAW4yP6Gm6sin8q4=;
 b=KXd1MjrghRlhFzwPY1gE7P6OEUxBQmPok9uGZwL3mPLSs5c1Y6nyIijx5WUwuTJ0Fp1TdtL2EMLL3tMPz+1F5PjJ+ZTBSHczlweNseNenF4J2zaEACNS8b9hhw1ZayRZ/YOSWg4vihcAFqtDVMt3cRl6eILqtHAuPg5V/3O1CPx9PZw3oOE27ulwOQ7M5b+8Nn07+y0CyaLjqB61G4rtUOBthNbY7a9V74SbeFDMJm6CATPYSrXFqLox1qiNHcidSRZj9VUUfQeEkKK9LR3cHgAH/N5W5P29YLZg3DeyQO8jFBycHnQMfT9WlKbj3O+Ck6FtizcyR6/JKQbzkjJQtQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5790.apcprd06.prod.outlook.com (2603:1096:101:b9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 08:05:10 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:10 +0000
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
 <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, Cornelia Huck
 <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v5 01/18] tests/functional/arm/test_aspeed_ast2600_sdk: Add
 USB EHCI test for AST2600 SDK
Thread-Topic: [PATCH v5 01/18] tests/functional/arm/test_aspeed_ast2600_sdk:
 Add USB EHCI test for AST2600 SDK
Thread-Index: AQHc08ESE2yKawARQkGIwYC65krhwQ==
Date: Fri, 24 Apr 2026 08:05:10 +0000
Message-ID: <20260424080508.53992-2-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 59f95c58-a63e-4626-df97-08dea1d834eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: jTUtqRkUVk+KKAW5fe2cwvsXfs+wTV5S1kcllXfwyIAB/syJA4sRviE8s8d2HkSh71viTRCfvUbfqYq+S19BDYbw+IrZVG55Rn9m0MP+BV6c5k+rSK/ygG87CCgMJ5WXvrqBSBUwwk9cBjUFS7KURQufh4fEp+MMbDuPf6jwLczgHD2/4E6LHxbU//++JWP8ykclv1PI5fxdtzydUnLS5A9556wTFmJSCzuhKyWmh+tpnBvWezvSqzqkZEVsxk3NrXIYg0xTRM1KlLZNLiwJ786MkATcAV6MgUU0rBoht/aAkveADFIRlfX2x59r2+2IE7ZjYmTPGNSm8jrcAJe70irrkFrMr1mo8WQWZAn5GJYZOJ0BUld0XGENemJvePyar63JO9UJGnqrgQ4og5GNwKhah4U3oJrgYpmR+r0dvjuHEwY+FAU1rvdZEILMMbQnSCaSmb8Ptwx0v66GYCqbuY2BIHfsJuY8wSX73/2hTeTCCU8kBSVHJ0pg2VzRWq3SNqrqOuutdb3dT7lZ45bhwQwTgf9tMmXxgQNTdl+KylFK/4tiFQm+3mG5tPc3my5eA01r/+V8S+iVhBxManrBnee32SpspqsADiCEJk0f9glp0lBJOcZNX+E6NhWwmZUdW4x+FdJ57jfJzInB8B1Go6uRqqhUA1OwMNKWEQDQ1paapPmVnjSZ0tx05EhAIuw1BjSfIumibF6FsTgvA+GI3TVeVQ7inQloQRm+nkspi3jVS/9c5m4FD8HYQ+vbbebsITXxq1pt4yy/DP6JY8u/MfdcYWltaPpaPsVLAnUFXKZWNfR5YjyQRo6UAyfzV4TJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WK8X7cWkASOvsxy+XItGxFq3iDT5SVo2MgGpFQRYdQGpzdTE9JdgQoMuIn?=
 =?iso-8859-1?Q?vMU8ls/nC/1r2tAClYxMXs44JBEvQ9HoIxL3V+uL5h4OZONJ1e3rtqXW2v?=
 =?iso-8859-1?Q?wA1pfM8ePRmI+nT2bVeamA5WYbUNnr8IW3DgQyYJxUEwrGoPF0OeQFvdsa?=
 =?iso-8859-1?Q?UnTduGLMCAJYc63Y7yfalFfFGVOg36wIdHZ/Ca+laYayiRBcBwrdAn8INR?=
 =?iso-8859-1?Q?S3tuLMdcpRnlZUupNxJxzb3zK3FYHHaoEYXiQ9JrkNZsMhlmS382EmEXKR?=
 =?iso-8859-1?Q?xWJpIHhCzEs+dyY+V0CzhVTwdrF/ZezxIPruGmHNYylIXYv6ayXR43YV+u?=
 =?iso-8859-1?Q?KIftHTQgDGDglsAp6mA1+2cMBcPMg44o4mtD4JiGwuqeGtBQSQDEyFM/zA?=
 =?iso-8859-1?Q?JZCJv/CMp6iOuNbcqi/gHMDlFFeoSAIrxSkg1SDie6Ygn+zHXg5JHtL9nf?=
 =?iso-8859-1?Q?OM0aXYju9is8rAqaE2nj0E6zm6dS8fMrnzqfJ5VfisDHlNOMVOA1vfmnzB?=
 =?iso-8859-1?Q?g9zI0yFTq9CuXrlevxQi+uliVWI4Iqt7u2Xzny2Mps9N7oWguCzC0ZIN8C?=
 =?iso-8859-1?Q?bazVaI7Bo5dXsFUgI8pmsQ6AuyJYIwnwPHRwfzqOlHzhhEK3LSDLb84139?=
 =?iso-8859-1?Q?0J9V6eyp1nC5kckvSkTBQGB7Bqqy+VtHuHudagxxMQCUxM1u9NDYS6z37a?=
 =?iso-8859-1?Q?SbDis52K1eaBooKwOBpknJIDRjZpN67q+7P3edFAyeakO7F7CkKCfQEyAb?=
 =?iso-8859-1?Q?Jxp2UX/rbyCWDyt1zOCRNfhCAX85H8+oZvXxYL0hjmcd/fQgGU148G3/zl?=
 =?iso-8859-1?Q?lk4dEpxaKqj4HnJ1mUgXsa5WYeYWb9lJ+cM7r9xSq18r1awvwdAeoknBSR?=
 =?iso-8859-1?Q?K2YjCi+23VMGmoB/PfBJotXkT4oXNGP6BAy/zSnnM7hH4Unuh8at3144bZ?=
 =?iso-8859-1?Q?QLfFPyOSOEnwD4f0se53pqfey2C3L5EcktlZtxcHax9pcuL5mL+6znf/QV?=
 =?iso-8859-1?Q?VF2LSBOLKQafPSIzljgmaAaOpsmPj8qnG2FawIXcbFC6rqR2m/all/7RC9?=
 =?iso-8859-1?Q?ak8FZEVHXfl3E0AxMJGb9p7ij3jF61x80HVRLba1mjBYRlh5OTXf+EFrlV?=
 =?iso-8859-1?Q?3F3HMXsl6VDnGFAuMGzb1SVhZrxl5Sx/rJUSwm6eCljyb4PfT8E9VIhnyA?=
 =?iso-8859-1?Q?vMSTUbpiqEaiyiRDHat1PidZJSCl0xeuSVqs3YoOM30d0pp9kmVCvZdCm8?=
 =?iso-8859-1?Q?ftdMlbZYINSpph09k5O3UoxUNZPdIibfBdORCDgVKlx2U3OXqj8hgrAZ3j?=
 =?iso-8859-1?Q?g6iCe7+/eXSwG1h/qwdRpZ0NrQ963cj63KpljlrXaCq4cGznK4HQhLf3+4?=
 =?iso-8859-1?Q?jCUh2YToZI+iUWPxMjXoZRU1/1k5k9fFsdVoLMtxCv6phVTmRx+et98HPr?=
 =?iso-8859-1?Q?04XjrWI7sI++Jw7dI53NfxPiDUU+94EPOjyESj6lHlkqZeq4I4U37haO7D?=
 =?iso-8859-1?Q?WzcTaqorHqlWd4+D9/rf9BOJ89xYxYq3Ze8XTTNRK4O29sFYF8JvmgBWvl?=
 =?iso-8859-1?Q?SLMQxcZJfMmDxTpxTLt/hhnPCP17mTNMHQef7uJP0+BLFWGBvEBdSyYcvh?=
 =?iso-8859-1?Q?0S3DGN6L2Uvh0wUUbvaP3afK1YsezUzsoK8vvvbWlTScSis9g9VDWSZ/X8?=
 =?iso-8859-1?Q?0BrimCgAKiqSxHjX/aauDHnF7UPHUtlVyCYdp1Tkgtb73eciIQIe1tC0SG?=
 =?iso-8859-1?Q?TH0/Kaiub5Xq65dFDIitEOGHwtHe6n+G9mZbSICOxN1itK3HSc+XOo9VJ9?=
 =?iso-8859-1?Q?ch8Lgdo8+A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: L5bqAzqcsgwxSbu5krWpqpIQy0sa4fbehPXrgVW4qgqF3G8r7FONVsmlITGLXb/i2AH9CnYvc93QLoQv3BBPolP72VdI03rqdTLA5q5LQL5ckW3pf3eNVk+yShTePMu2XlUlubpjAUP0Nm+jbgA46JksjaarfVVWh/0niZMSYqLdzT536B1P/pPAALWHr3b/no0rbXD1lJabvRZwP2A8YaLsi1o0MHsITp8k1XWjQqZQErqvYsylUpXYxgZAz8eehHdLZMKr9U11bGKJZ5FjtOrHDe1yHKBijo1Oir7SyKcG7l27tHo5aEdG05WyHrHcl6OJN7AU1DvNGRhnEBIvyg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f95c58-a63e-4626-df97-08dea1d834eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:10.5553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rhdtb+Z6k/fH6a30rYYighbTML+AqNTJPAW0Yf1Gm2jwRTtD39KBnBqC+RyUBAr/7agKW12CHk+d8Ak+SipjDlsxJwsBG0YgqBRxPnnubv8=
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

Add a functional test to verify USB EHCI support on the AST2600=0A=
SDK machine by attaching a USB keyboard device and checking its=0A=
enumeration via lsusb.=0A=
=0A=
This introduces a helper routine that runs lsusb in the guest=0A=
and validates that the emulated "QEMU USB Keyboard" is detected.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 tests/functional/arm/test_aspeed_ast2600_sdk.py | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functi=
onal/arm/test_aspeed_ast2600_sdk.py=0A=
index d787e90d10..01548dd135 100755=0A=
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py=0A=
@@ -40,6 +40,11 @@ def do_ast2600_i3c_test(self):=0A=
             'i3ctransfer -d /dev/bus/i3c/5-1234567890ab -r 8 | grep 0x | x=
args',=0A=
             '0x12 0x34 0x56 0x78 0x90 0xab 0xcd 0xef')=0A=
 =0A=
+    def do_ast2600_usb_ehci_test(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'lsusb',=0A=
+            'QEMU QEMU USB Keyboard')=0A=
+=0A=
     def test_arm_ast2600_evb_sdk(self):=0A=
         self.set_machine('ast2600-evb')=0A=
         self.require_netdev('user')=0A=
@@ -54,6 +59,7 @@ def test_arm_ast2600_evb_sdk(self):=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
         self.vm.add_args('-device',=0A=
             'mock-i3c-target,bus=3Ddw.i3c.5,pid=3D0xab9078563412')=0A=
+        self.vm.add_args('-device', 'usb-kbd,bus=3Dusb-bus.1')=0A=
         self.do_test_arm_aspeed_sdk_start(=0A=
             self.scratch_file("ast2600-default-image", "image-bmc"))=0A=
 =0A=
@@ -81,6 +87,7 @@ def test_arm_ast2600_evb_sdk(self):=0A=
              '/sbin/hwclock -f /dev/rtc1', year)=0A=
         self.do_ast2600_pcie_test()=0A=
         self.do_ast2600_i3c_test()=0A=
+        self.do_ast2600_usb_ehci_test()=0A=
 =0A=
 =0A=
 if __name__ =3D=3D '__main__':=0A=
-- =0A=
2.43.0=0A=

