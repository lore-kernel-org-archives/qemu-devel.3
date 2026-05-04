Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63670CD3424
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 02:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJjRm-0001hJ-6V; Sun, 03 May 2026 22:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRi-0001eh-Ly; Sun, 03 May 2026 22:54:11 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRg-00040F-VQ; Sun, 03 May 2026 22:54:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCa4hCaTdOa4dHXs1N8/Klz2KSlqkGbRDtF++KE27aZ4Gi+n8iAwXQGiMSD+xOhM68Qp2b7lW6eU8uC/5c2OLRfSeneOPriYySgnzCJyuLtVPNiDHbV3b/Ob9KL27eJbwFAmc5bfv6YysYae/BWxuWtzqIAQfapC0TEsMoLJzns0Ry3SQxSZ2cH2gYvcwqWvGQw5ldKsJHLEzT3Grdaz4BPnEKwIipoTILj8FjKI934lsFdGhMgMHK4C2iqsx6phksBmDIRL64Vk5Q07KfHtBBUBg8nYGRaibJynbrWM3pbw90ejxqV2jc/nDog3h7SuDg5yY4uOHYFuX8secGhWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZmRshDm37UDSuBxiuaZP8DuMMoer6dqKwO/mLKFHAU=;
 b=o/xRHCsLymOJfbYdtByKNNXRilTPrNOLvkAT4cGnxwddzMGpTnqQjvd20sBShatloAe6YfABZpF4QdWZRVqB96Ep5pSopjAjGdhuXtt4zD4aSUmbjwRxPPPk5dkruDq++apOSYvgvKT0Fu2uL8e4DZK9+LVITEV45Y8ySyZoUWCYYJRLpbDU2dmLOQwjBs3+1f/sRGsz3hU4RfB2HUn+m71P2kStBtbmxVdHcqbCNVrU4ImEev14gvqQ66zLtiiRgZR4Sa813SUgjgkBd7aPgmSxLbgsBDfGutsg8g/3WQnQzHkeMtDv54V7RPLOQUmfR+fXm5HACwQeiJP94tcKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZmRshDm37UDSuBxiuaZP8DuMMoer6dqKwO/mLKFHAU=;
 b=rcqKnur2D7Bm2KQyJsaqWCm0qCyaQ7Ssu8CnJgT/xVikgXoynhHXVGyFLX6/wLtdqk7Xpaua5SkbZ/fXvsgHw3F5feBp/ZG21TaWpGROgEd7vg7cq1x0x1e/Oerth01Osh49YFqNr29brF7u/KZrNW5Cz55lGoD3qw+fI5wc3jGWwNre+I+qw2+vyCfMgHqxgmgdL+oqoyuVQOKC3zKdliuj2KXCofloGL1vRfXk/jSpaPZpH4FMd4JfN0zgQN7A7hj1O1ak2DbSK3f+GpnFfmJc0d/VXj59mT1xnIv6nKXnt45aedrl3aD+quXhJF/DAcr4jkOd4Y1Kgmiefxs3Bw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5111.apcprd06.prod.outlook.com (2603:1096:101:57::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 02:53:56 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 02:53:55 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v6 11/11] tests/functional/aarch64/test_aspeed_ast2700: Add
 USB EHCI test for AST2700 A1/A2
Thread-Topic: [PATCH v6 11/11] tests/functional/aarch64/test_aspeed_ast2700:
 Add USB EHCI test for AST2700 A1/A2
Thread-Index: AQHc23E/Qng6uCGlPUu7KSWoH/sHBw==
Date: Mon, 4 May 2026 02:53:55 +0000
Message-ID: <20260504025342.1452605-12-jamin_lin@aspeedtech.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5111:EE_
x-ms-office365-filtering-correlation-id: 0c070bca-24a7-42b3-d877-08dea98861ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: vGkrSrK0Xv+IZK7XB3OdXBrcTBuqxF4IzSUNiwtAdTeYRttEHLPiDHAv2LkqQZlyW87ySWiZs8wXrC4wOPoAvE1u8mTKkaFrqUw0etiisjXbkpyLku4K0gCStbI/zIft09S9GxsH5TZSxM42xMxir6TXkCt2UTvMbYVLyUGie/jb7cbS6GBwkE73D0Bp3W0welILRBSqUetdjNNFrAVBL+oaHsIWpRnKLvf6qQ4Bej3JcBv0Sq70LW/wC/LtD8RXeAiDtcgXOINVq6GmI1KiNWHlYUSnMZKtyfEfTJ4gu9eFX3ObDf/0M9StdjNgWE8BncLNByOuv9KIQQBIYhbfWVOxZVgUWBU80gr+1QusbsesSRLX1/E5pUrOVamXSpDsOev0K7Rn5lRsVxhRSlRCVsP25AJkgA1XTRR+J1Dyl7kPxfJzxOB+D0bviddhOPu3Tldj3iK0u/VreIFaPdi89+4+1eDFF+X1t0xw84svmL9GcE8kojNhb/Z3MfhSUWFfKeS99I3C71uPU/uLPkFykMRX2Ub/RRgYdbSf8jh3GptWWJBPxDlZ8x0TVZB0sqMDVwElR3G5+TzVj7t05UwiUksHVOsc3zYbNCC2tj/7LRrNQQ2RAcRS2zCBdgyJSMbh5nYKor1cHfcwAWJy7mIXQq7+wpUaAIl4SAtRAmxyaQWchDDAEWW/THzO3ExJTb/O6z9u5MnUvA8mUsOw/SZR7JQ5FZInBcACZ3Lb0IN32ptcIVcyLs+92kKY783ONek9TcueMT9Qx2bceS0NkGvN2Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Dxk9Rb91Y2DbyVh1SOcHO7yx7k6Ix76O1L9ApQ8zIkK0dUEZz2+yLDJPqg?=
 =?iso-8859-1?Q?kW0xE3GDzfPnoxsWwnyYngKjf26Wp0AoSmr78sJ8v1x+JlIaKT5CXK5dXC?=
 =?iso-8859-1?Q?nsL6R984smIDb3jmPVfEZ5eykqcw+1Nl0lTZWIE+fVjpHWZPr8lUUoW1VD?=
 =?iso-8859-1?Q?HBtlDxI3qrUwf+Q/aSrxbFTJxyQwElSEunNuVxxPQafb56BrOPcpMgGrWO?=
 =?iso-8859-1?Q?j0LG51OjW3VUtJ1RgOdVOkIh3PlR7WnkIRjDtpE3lDwtY/4lgaUAFPpS9Q?=
 =?iso-8859-1?Q?ENXsM1nnVBnb4iOhkWLEFsWyq61GjvhNPETYX+IWysXahFNgZ4qOI6UQJt?=
 =?iso-8859-1?Q?VBQR/ZpIJm6kddWSZaMhPl5qT+L1LXVVy7wkIOAcgDB3I+8m3xb1IUDIyJ?=
 =?iso-8859-1?Q?mt8Zw04PehmPSJ6VimjiWciH9eSdDhsHN1vviTCoUbiHkq2P8NL4uVtlBR?=
 =?iso-8859-1?Q?+ddcfFpB2n4Q/fb0GVo3UyQJDqjyTnc+86A4t6OrOoaNx3cfwpQF1O5U1l?=
 =?iso-8859-1?Q?sx87WBmQW/4+WhbIkb+3xhpQxhKCFPygZ7SX5eUGkxBL/9g+X+09xTNyhJ?=
 =?iso-8859-1?Q?RVsgAysjgJXtfrU4qoG4G2uCNNJ7njzoqnmYHV7PPFnzaN/FR/yZihTMrf?=
 =?iso-8859-1?Q?01l3/+eVRIkkd3g6tEv1z46pXY0UQns/l3REclehto1J7OkwM+S/T44u+Y?=
 =?iso-8859-1?Q?I2uvR8ZG5cqJVm8H/1e3KNo8Id8qS99fXRcOnTxbFkVkymRdSQB+r9qDv6?=
 =?iso-8859-1?Q?s5Vznzb3LPJFT7BcsSV3yrnuECNHt+dClySwq3qIIiGBB8yxqQmfvPjFKB?=
 =?iso-8859-1?Q?wtGh2ouro4/6Emy9y1Lk0hcklCSqS49YKKUWRoIr6v3P6F2z/cRktOW53a?=
 =?iso-8859-1?Q?785YIIwHh4iu9+vA3fbBtwjKPmnPJbFacfTlFkY92XeAu09AYg0ZLrvNwI?=
 =?iso-8859-1?Q?n1AqERMXloBJm2eEs+R9weMtcuv51GGOtSAIWdzOyGDVYtWM6lUFahT88r?=
 =?iso-8859-1?Q?bv3d3KPMYXqldvoghSJDa29JviPveyD8U+n6KaVm5NYcpyxllmIACAi5yc?=
 =?iso-8859-1?Q?Wt8hXgJZWBmktN9o3yXtHo1sVdG8BlUB9Du1+RzFgPxgsVDVh3HgjXrHyF?=
 =?iso-8859-1?Q?PdaU7VlkQ0TTlW0SvVaAa3KZMVoIsBQVEKf9I60sSOfuBcR4gsAVsTr8ep?=
 =?iso-8859-1?Q?b3jPapNFL5SX3oH/uWJHnRsPVSBauBVdZC/4VimtxxPTgt4z2eFpuslxLb?=
 =?iso-8859-1?Q?iRcjUHaVPASZ1ZV0/lBFAQUx3ZWGfw1RnDWAXAyBp8qXjqa+0G/V/oyEAv?=
 =?iso-8859-1?Q?mbRLiwG5L22wmRyCCgIuHvW7Jk2gqUkYLRBw8DStrWjE35n/QlvqBAcft1?=
 =?iso-8859-1?Q?lqeobGEnujG/VIHDbH5X80B8h9Cz5mD0xIFUGXDIZm1L0CdPcxbM1QCfvl?=
 =?iso-8859-1?Q?u5VvxEzroiKW7EWiyBEmfvQ8Aw3nEnXNM4RNWPYahPbYgctnWVW/iaudGl?=
 =?iso-8859-1?Q?6HBFY/W+DumrwHg94gLUZ5CEBmljWLyAeaxAFjZVB+tK9yM4EXWfAFguyh?=
 =?iso-8859-1?Q?yeK/VrZOAoNt4RZahSGNIhK+fRT2RRZtaCdB64i+pqwvA+oA8FTQJsQ/3g?=
 =?iso-8859-1?Q?GD2AieLOiGF3zzxlRB2HMT4IaeqAU8B6FtPkS2CyxjAnqxENG6ICmhtFLN?=
 =?iso-8859-1?Q?BqeTcWZZ7IjmXzrdx1pBDqosPpUlgIb2ud9Na/LbFwYgZbAl5mrLPOS8Rt?=
 =?iso-8859-1?Q?GjuUxM2OmSzpA12n7D/guPTk8CYuFPS5Cw5l7y+8w9q9bA5diAtoXc36fQ?=
 =?iso-8859-1?Q?kcg819K69g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LpEX7fUEb7YUQA40UgUZuDTcCJtTAutpF+aD4EWjroEscKN5sGuJS8Xn298c+VeauqU+41PueM3+N6tfb6T0nMgUFt9mFMsrg5Hxytw+JCt3aCDrA/roFvhlF2uQN0wYySultJ2IxV09oa5TG7Uxgqin+9c3y+L4KgQHABjmFoKn6XEdCiXuoKotw66ocbdZnuas3pw4ilA9GrBjCX102m/bVxmMukWUYIgcSVvuo2s0t6rq7eyaOMCsQxwt/3MmgMLnjAXcWVlCcnTSRq4VXuAC61qDzs0VpTtumbzYk0sSIhZPBZz4mY4SAs1a+XIDtoUCL6vlRI2lZsq6BXo6mg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c070bca-24a7-42b3-d877-08dea98861ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 02:53:55.4377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S5SZ4c0Lqc0xOK3KaZll8mym8VuT6jEpuogecgWXsoVzSDAKKCogClmULUhCOOYTWDgynpcrgtwcKNwFSEUWc5XiraFJbJsXBnF9Mq6Zr/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5111
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Add a functional test to verify USB EHCI support on the AST2700 A2/A1=0A=
by attaching a USB keyboard device and checking its=0A=
enumeration via lsusb.=0A=
=0A=
This introduces a helper routine that runs lsusb in the guest=0A=
and validates that the emulated "QEMU USB Keyboard" is detected.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 tests/functional/aarch64/test_aspeed_ast2700a1.py | 7 +++++++=0A=
 tests/functional/aarch64/test_aspeed_ast2700a2.py | 7 +++++++=0A=
 2 files changed, 14 insertions(+)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a1.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a1.py=0A=
index b0c08854da..42b8b200cf 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
@@ -118,6 +118,11 @@ def do_ast2700_pcie_test(self):=0A=
             'ip addr show dev eth2',=0A=
             'inet 10.0.2.15/24')=0A=
 =0A=
+    def do_ast2700_usb_ehci_test(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'lsusb',=0A=
+            'QEMU QEMU USB Keyboard')=0A=
+=0A=
     def start_ast2700_test(self, name, bus_id):=0A=
         num_cpu =3D 4=0A=
         load_images_list =3D [=0A=
@@ -161,10 +166,12 @@ def test_aarch64_ast2700a1_evb_sdk_v11_01(self):=0A=
         self.archive_extract(self.ASSET_SDK_V1101_AST2700A1)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
+        self.vm.add_args('-device', 'usb-kbd,bus=3Dusb-bus.3')=0A=
         self.start_ast2700_test('ast2700-a1-image', 1)=0A=
         self.verify_openbmc_boot_and_login('ast2700-a1')=0A=
         self.do_ast2700_i2c_test(1)=0A=
         self.do_ast2700_pcie_test()=0A=
+        self.do_ast2700_usb_ehci_test()=0A=
 =0A=
     def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_01(self):=0A=
         self.set_machine('ast2700a1-evb')=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a2.py=0A=
index ed414999f4..40e0ad81ed 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
@@ -121,6 +121,11 @@ def do_ast2700_pcie_test(self):=0A=
             'ip addr show dev eth2',=0A=
             'inet 10.0.2.15/24')=0A=
 =0A=
+    def do_ast2700_usb_ehci_test(self):=0A=
+        exec_command_and_wait_for_pattern(self,=0A=
+            'lsusb',=0A=
+            'QEMU QEMU USB Keyboard')=0A=
+=0A=
     def start_ast2700_test(self, name, bus_id):=0A=
         num_cpu =3D 4=0A=
         load_images_list =3D [=0A=
@@ -164,10 +169,12 @@ def test_aarch64_ast2700a2_evb_sdk_v11_01(self):=0A=
         self.archive_extract(self.ASSET_SDK_V1101_AST2700A2)=0A=
         self.vm.add_args('-device', 'e1000e,netdev=3Dnet1,bus=3Dpcie.2')=
=0A=
         self.vm.add_args('-netdev', 'user,id=3Dnet1')=0A=
+        self.vm.add_args('-device', 'usb-kbd,bus=3Dusb-bus.3')=0A=
         self.start_ast2700_test('ast2700-default-image', 1)=0A=
         self.verify_openbmc_boot_and_login('ast2700-default')=0A=
         self.do_ast2700_i2c_test(1)=0A=
         self.do_ast2700_pcie_test()=0A=
+        self.do_ast2700_usb_ehci_test()=0A=
 =0A=
     def test_aarch64_ast2700a2_evb_sdk_vbootrom_v11_01(self):=0A=
         self.set_machine('ast2700a2-evb')=0A=
-- =0A=
2.43.0=0A=

