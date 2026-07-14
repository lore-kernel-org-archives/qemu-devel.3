Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FDAC44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 07:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjXaP-00060A-7R; Tue, 14 Jul 2026 03:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXaD-0005tJ-RT; Tue, 14 Jul 2026 03:29:38 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wjXaB-0006WV-OC; Tue, 14 Jul 2026 03:29:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lImn5GaXyuOJdIImqr5Wajn220+2Ia60gbQWvj0hgU3Xc7pklI7V4VjyMUhz+zb6EK0WygjYfEYBp55tF+h0G029e9q/vMH91krGHIZiz3jrWzx9MQbz89zpFJMFl7BzoYcmaFz6z0KgPUmpMetF7qJ7eb0uneU/m9eQlYnKS9m6fgPvfXIQRhwcAgy8U20+0vJJXDjc78exgPZSFfjnvcHHy9POB3rNHxdfVj2gJSDFD/jzv+YHFD6JQ4C3HhOBto7Srv/0vmIkJwgkU2fu/hskFCU2MW2BHeKarBeO1ULVYHMolcVAOeJNbybp/cIMzitcnPzkrki5FP2rPPniAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fo/0X/sP7KOxrB3v8Kz0RC+hKyUFyDa2nND+3OsxO58=;
 b=sBCXj0VG4p5IEGFGY445WDRlO/CCRrbTCZQ1wIJaMBCDZT2/8/ipydosTScpqaHHiJoN9WoQ2+3R7NQiE9xhZYgyD5BqIMoZsLTIEm9/SsKSlPqRBAbr/aq9ZJhhQ0LetPdHulcZZgn9Vu1KYtTmDkva9cmVrVcVAWVTqSN6w30BRPC5353rcmnPYUyJDDf2pwB5v16fD5uSi9/JtuGlA+2rI/SxVtXGTcCd+m+VGoXmrUlcON4iIhILHl5Sj8hPc6zE+rHvTsXsR4sSlhjDwLnhxHzbeWfXN/oQkUhY4+TMfYjIPhtgBKmenm/P8+hrXNQwRQQ+Un1gHx2hC1z9Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fo/0X/sP7KOxrB3v8Kz0RC+hKyUFyDa2nND+3OsxO58=;
 b=J2KsL4Kpd4HIPPjAANVzTvdQoC8JuixsndKNsYfZvIJ7cnzv06dRWJd+VZ+SJ1tF5Rpzx+/r9MizoZ9wM7Ss3G3pWJvzpyS6LxPIJqorE6J5uwzduVgktdZ67+jJ4q/uoNyHc3d1nPppKkNWyvTTB2i3D2rFxnDNA7Zd/qMdUdclPYmM1tJxq9KVnqJjQUgshjNmIFQ75+8r5rDHOkIez4C6rM7QZMnkMkvzLtZBRqmbzFxjtqyCvGKK3ibGdYBs887vL8hRB490O5zDHywlrySgqqacuk1WUpoDMeaz3ILDG5vWNk5az8+oX8nn7TNTlbvfXG6jy5f+ZauPnXATNA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6117.apcprd06.prod.outlook.com (2603:1096:101:f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 07:29:24 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 07:29:24 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 15/15] tests/functional/aarch64/test_aspeed_ast2700: Drop
 the AST2700 crypto self-test workaround
Thread-Topic: [PATCH v1 15/15] tests/functional/aarch64/test_aspeed_ast2700:
 Drop the AST2700 crypto self-test workaround
Thread-Index: AQHdE2J+5t5NWVnVpkOaOy7Inx4vnA==
Date: Tue, 14 Jul 2026 07:29:24 +0000
Message-ID: <20260714072900.3023742-16-jamin_lin@aspeedtech.com>
References: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB6117:EE_
x-ms-office365-filtering-correlation-id: 72cdcb6a-9614-40c9-2602-08dee179a104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|921020|38070700021|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: z/dApU0CosKvViPnsUtKDRqw8LzIDw5B86mbgiOHI53OqMqu3yrJDUYi78tSjl3sPV2Yv0WVp7p+CXuPzAggj4IcvPRIbOXLt3h+6ttmLKmu1wzrSAvql6bYnCY0+2wUQTwmc7MVuOn2RMIVKNfVkbeqKzHRyT0lBOqgalErMzi0ZwY7b/WznKoBoNttAk7V5kyO6WSehJ0CnVzh4HzOxze5gHnr0aODgIwxkiGdWjLAcsJa/pshPgdtEGvWURzh6zOkUZ5WnfNYymcAZvzFhTQGFf0+JBeNjjNwyN6yl60zNQJYC7auGzhuEW/iVl/+hlfMdS5ktTBb2joTK0mGT75OcuNbydsXRN5onIM1G+cKARlargeKwFy6X1hsBgPhngOpIrJFkRpdKb8KWz34mbuN/2GTf6jFKYYPNP2Gk7w1OCj0FuS8bUL2GnWfj7JDSZzwV8ssa+ym/kK5BuidG0Wnse/IG7ijPCKwFuf7VB8vba48O+BskZOObnX1Ol25XyTspNtjGSb4TOuB1ZgzFrNF4VHBLuuHRuB+HXhW6qlY/7ACo2ZDsnPi66mdTnrcu1EA2CrdM4qE5HQW/JpY550Vk0udH7yVSzPzgcCetCB8dtHXeaIlIk1X7dlKZxrUq/255Qh595szrGzLS7LXQGoT14szjfJj9QaazXZJUOUHAMReLfGJzbolY2vvsimlwvjZ3po+eQV2M3YJzY/CgT2/DFrKZRQ5zXU0+8kwBOKa9Zu6IRYUxnYMKoJ92guU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(921020)(38070700021)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SvtPDBYcudGzBRGfR2iKirgU6xICmGCSlL0eD7spzeYgQEx8rCEAXWRSWy?=
 =?iso-8859-1?Q?R3gLEpL7C1LFi2HZZc0zWj3Mmqde01KQOJmjuQrRLbwKuPSiY71OO/Lvut?=
 =?iso-8859-1?Q?D9tTg20R65E9M4XYfgAM62MzPjWN55AcELxG93TL+RkLTKmlMc7b3hygpa?=
 =?iso-8859-1?Q?gEDZrulGe/BC05hmn5DzyJqqIGZ2UHYeeGd5ufzlgieQJdmOYwFqWTW/OB?=
 =?iso-8859-1?Q?HlTkx6A5mb9HYINkpxwvO4aEP/vTpN829lAIsaW7OTVxEedz0TCO0DQj25?=
 =?iso-8859-1?Q?F2cZRhiNswQJmzwwoUqV09ZfU1mROobPPN3waO0ty+6cyCQgwoJJHKkA8X?=
 =?iso-8859-1?Q?9mGb5L3eqE3eBIhiTrQ1LC9/hqVBf1GcYIXsjZfZW9/a/NqcW6okVrRwTM?=
 =?iso-8859-1?Q?+8/AHK+ujCCPQRFWBlyo6/NpgJj+LWpubmw4CqltYpnD6Gc6QMlJryXhQs?=
 =?iso-8859-1?Q?BfzeLOUQMCCMsqBHr4j4OnHRcxZU+ev92/m1tg6i9jKC71AlMSAwsO7Ejz?=
 =?iso-8859-1?Q?kDXjo8C1+JxQmgeQwYMz26GVkFEf4siwh6FnhxRbPFeL8wNXgqoBrnflBz?=
 =?iso-8859-1?Q?9ghjWlWaCm+nxx0vVGGMQPIR0ZJfan49i7Y2WhCDg03vGapBCGGHTqBADM?=
 =?iso-8859-1?Q?EALExWilT+XCeN8uz81/efpvOeiOxuBByOyxb5iHh7SyciS1gIC+sHdQE1?=
 =?iso-8859-1?Q?nCegJVddKTOLkOIwjB49UY6IH4fjWfS8bdziT3M8XOXbWKzrtAUcnu5MUJ?=
 =?iso-8859-1?Q?2RtopvuuL01l+VYXITYjpEpPK325une7wPQFoej89CNfUbX4+19BYy1CwA?=
 =?iso-8859-1?Q?dkgx8S3RO5DgLaETkMP7c3SFFZqDRvXDnlbV1yFGCgtLwkujv/RIeU+iGw?=
 =?iso-8859-1?Q?TLV8rLshxtvzbU3tX6/yzXkthnQYlsn8D4wmfdB7VsTOjQhy6KyZhB+hmR?=
 =?iso-8859-1?Q?4S+ROMyBgllpzDSVW/al29MpiSAJsxe1aRTdgI8Ed74CPHX84wZkVVx2D8?=
 =?iso-8859-1?Q?Du45PAloUqr7odluS2Iox5CwS4RaNDP5fmPFSjSIcrPVrcrmFylhXOXZJI?=
 =?iso-8859-1?Q?xkrxzdNU89I/aDqC5vfPlwcAXJHQ5eTvLo34Sy2KpK3BqofE6gv4P1R/rp?=
 =?iso-8859-1?Q?o11V9wECpo8zIi6CZGdNgzXaydHF0WJaDR1WjL+/R83svu9TiTXuE4sQRV?=
 =?iso-8859-1?Q?slTL2QWBfacqI7lR0TBqjebmspYJ9ddoOcR1nLAAfJt0UQlS9gAnyrObfv?=
 =?iso-8859-1?Q?JTo9PmFLYB1JqrNYocc93hFIzLpsBTOQQc43BSzIxw9WVff+HuQn5Yi4zc?=
 =?iso-8859-1?Q?ee77eryVizPsXeFols/jkIO763DS8FaoYDjJBoh9YQbAq0h6ASvemGZat5?=
 =?iso-8859-1?Q?pZAvhe+Q1I5S/Sb5L1RvE1462hVRWcaAkge7Ja0+5uchd9BRUiqSRQ8P34?=
 =?iso-8859-1?Q?Mzi2rlt/Bc65PkjTn8/1o/OTtCnmD3+EOftTaH7+c7b9GA4mW5BHbEDHus?=
 =?iso-8859-1?Q?ZDJ8+LF5N5Mru1YNEza9RnKAHn2r+pJWPLY1mErG8WYoo+Pcf9f7IKA0wi?=
 =?iso-8859-1?Q?PxuhhHrpEUQ04Nsx5L+09XQ+gfndSYZ9aPka11TIlS4e7t2qOuqA3bQX2V?=
 =?iso-8859-1?Q?6nm5W/7GCti+0uqyIxpD/6EzLbwlU9Su8dWD2Kj4FN/bPBkpQoGvCDubip?=
 =?iso-8859-1?Q?qQubfEV/YLIE8nwVgi/3TIp+/YKdgG+exUxCJa2V17V9ojSGOwjdLkJ/+J?=
 =?iso-8859-1?Q?mwKtpK7vrDkhURIqLVSq5gySL4gK3YhQ3wGw2zwSUkuloIS2U1giSTn+VE?=
 =?iso-8859-1?Q?NidUCqovXg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: i5nq5ZfIaeKVYCXJ22NZGktmMQsTVqGmswRGtfhrJl0BfK144dtUf2PeWvxNWWRtNHCGGPMF6r9df23AOuHClVuhu19N9Q7g6CW2VEVL+me3eQL0VHM3Q5f+cRN+h2AYHhHr2g2AbubemtJyl0obpQI+NeXcQpmCai9mxG09K8JKibvkYAhMM3qT0a5S8LFULM8S3yJr1ocHnejB7syL+dCL86HBxCidhavsyasOL8xx4FR1GviNPC5C3luo2kjNVyr9JkAzg5pIEJm6MsxnWHa0MomC4CoI6tOTv4xLGlgLeJpehUXBkeUQMSrsZSdyazYlA4rQNUtDY1lj9NL4wQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cdcb6a-9614-40c9-2602-08dee179a104
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 07:29:24.1618 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D33MGWm9Xaq0gS+a/it93UTJ2BXrtWoQ8qwSWnEysRUUoZrNDRkzgUlJ1f9QyivzCJFke1CufU/8CF4W2mZ000jWmWB7/Og5kzH+7I8tAVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6117
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

The AST2700 boot tests appended 'cryptomgr.notests=3D1' to the kernel=0A=
command line to skip the Linux crypto manager self-tests.=0A=
=0A=
Now that the HACE crypto engine emulates the crypto command, the=0A=
self-tests pass, so drop the workaround and let them run. This also=0A=
exercises the HACE crypto emulation during the functional boot tests.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 tests/functional/aarch64/test_aspeed_ast2700a1.py | 5 -----=0A=
 tests/functional/aarch64/test_aspeed_ast2700a2.py | 5 -----=0A=
 tests/functional/aarch64/test_aspeed_ast2700fc.py | 5 -----=0A=
 3 files changed, 15 deletions(-)=0A=
=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a1.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a1.py=0A=
index b0c08854da..bc535449b5 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a1.py=0A=
@@ -51,10 +51,6 @@ def verify_vbootrom_firmware_flow(self):=0A=
         wait_for_console_pattern(self, 'pass')=0A=
         wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-=
A)')=0A=
 =0A=
-    def disable_kernel_crypto_selftest(self):=0A=
-         exec_command_and_wait_for_pattern(self,=0A=
-            'setenv bootargs "${bootargs} cryptomgr.notests=3D1"', '=3D>')=
=0A=
-=0A=
     def enable_ast2700_pcie2(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
             'cp 100420000 403000000 900000', '=3D>')=0A=
@@ -71,7 +67,6 @@ def verify_openbmc_boot_start(self, enable_pcie=3DTrue):=
=0A=
         wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
         wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
         exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
-        self.disable_kernel_crypto_selftest()=0A=
         if enable_pcie:=0A=
             self.enable_ast2700_pcie2()=0A=
         else:=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/func=
tional/aarch64/test_aspeed_ast2700a2.py=0A=
index ed414999f4..5aea0a9dd0 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py=0A=
@@ -51,10 +51,6 @@ def verify_vbootrom_firmware_flow(self):=0A=
         wait_for_console_pattern(self, 'pass')=0A=
         wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-=
A)')=0A=
 =0A=
-    def disable_kernel_crypto_selftest(self):=0A=
-         exec_command_and_wait_for_pattern(self,=0A=
-            'setenv bootargs "${bootargs} cryptomgr.notests=3D1"', '=3D>')=
=0A=
-=0A=
     def enable_ast2700_pcie2(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
             'cp 100420000 403000000 900000', '=3D>')=0A=
@@ -71,7 +67,6 @@ def verify_openbmc_boot_start(self, enable_pcie=3DTrue):=
=0A=
         wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
         wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
         exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
-        self.disable_kernel_crypto_selftest()=0A=
         if enable_pcie:=0A=
             self.enable_ast2700_pcie2()=0A=
         else:=0A=
diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/func=
tional/aarch64/test_aspeed_ast2700fc.py=0A=
index df889134ed..1648fa9dba 100755=0A=
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py=0A=
@@ -27,10 +27,6 @@ def do_test_aarch64_aspeed_sdk_start(self, image):=0A=
 =0A=
         self.vm.launch()=0A=
 =0A=
-    def disable_kernel_crypto_selftest(self):=0A=
-         exec_command_and_wait_for_pattern(self,=0A=
-            'setenv bootargs "${bootargs} cryptomgr.notests=3D1"', '=3D>')=
=0A=
-=0A=
     def enable_ast2700_pcie2(self):=0A=
         exec_command_and_wait_for_pattern(self,=0A=
             'cp 100420000 403000000 900000', '=3D>')=0A=
@@ -47,7 +43,6 @@ def verify_openbmc_boot_and_login(self, name):=0A=
         wait_for_console_pattern(self, 'U-Boot 2023.10')=0A=
         wait_for_console_pattern(self, 'Hit any key to stop autoboot')=0A=
         exec_command_and_wait_for_pattern(self, '\012', '=3D>')=0A=
-        self.disable_kernel_crypto_selftest()=0A=
         self.enable_ast2700_pcie2()=0A=
         wait_for_console_pattern(self, 'Starting kernel ...')=0A=
 =0A=
-- =0A=
2.43.0=0A=

