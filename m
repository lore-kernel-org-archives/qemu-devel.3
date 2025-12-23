Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1538E6F07B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 09:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXz06-0001cU-7l; Tue, 23 Dec 2025 04:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXz03-0001b2-1H; Tue, 23 Dec 2025 04:48:15 -0500
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vXz01-00026J-8i; Tue, 23 Dec 2025 04:48:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+vZGfE69bB26fmD1lwoy9trYq9dlu7Ko99mK/iEG4GHAMLHCGXH2UYBDvAz8Id+IFrEnOpTfY4LKW+5fkGTRuvp3iI+4dmCZyAmdAi+ewQzDCD5JPi1YMLtgrTLJUdANNJUmIEsI9sM5S0YnAiuKxUsDgmmT8uStYvh6oH7M2o/pqwtDzrxdW4l13+5Cz36WSFmxERwD4y75SV1PSFXzuqsmWtURJLtOsYMZU0fzV+ODiOH+iIh8teDcrO/wiNhQaygdwPOVmAgbO24wJy/RbkjnG5/tE/2B+bcvGhgq5NhgUfSExhPR7c39CE4AYU8bAGUp0nK+DE5XZ1tSZAPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE3+NKy0APkAID7+4k3ccrzlzMukSS4RW/9+sasbrMI=;
 b=tKX+yICLWtRkYEcNETCDBZbcizzaKruhSGVWLUzAaaD49WQDZy4PuXNGpWq8tdCLCKwQGecrzlTQIqAgliMrGth3dJeEEG+aJZIldbIfbFg8hNgutaBHFbwnapUQpOjXdY5xezlTgGsJSUBewP3y3Yi7VHT1RqwJCHjPngyNGbgykpHO95aPQF0RgjQ6JCE1OLrvtvsg8TcwGJqF3YA3ELjxvEfbQYLmFuQ0tk7x6XKQJQB/b5J9gMNiDxhlIfAD7qjoDMnixHOiGrBVKratY5hioebjMZs3TQa7Jm6nqx3Lab3NyepqeGbQYm0Gw3jLUTSFVuMNQJCd/MFvF1znXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE3+NKy0APkAID7+4k3ccrzlzMukSS4RW/9+sasbrMI=;
 b=FzXVIzti01MaMi6iHf+CdJjFLCpNw4FBPbqKhEX5U6/ieqZZeVcnEV3KZ0NUfJ1XKUYJMkcl9U5dKnyYqsy60a9/3YyJXcztUP7P4C9a789FH9z/BOxqnTp3lGmn23EO+RE8YGNXucvI85nj5YC7OmTPqnbGUlGM3tdpM0izgOvU8K/Nl1mx1Q3uRdCMCbwVd7zVW8OPOWWkdSX1wxiIUHqcy6wuPpaRMCM0evyJXKe7TPJYhgMjoswRvt+I/I7C3XkC7iPsa2DJrWPKLj3qiaT1nFoF50cDyWwGyxGcyTz6Ba3pspCsTqdkwg88+huohdm5NL5LnbAv4FXGBsCv7A==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by AS8PR09MB5758.eurprd09.prod.outlook.com (2603:10a6:20b:539::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 09:47:59 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 09:47:59 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v15 12/12] test/functional: Add test for boston-aia board
Thread-Topic: [PATCH v15 12/12] test/functional: Add test for boston-aia board
Thread-Index: AQHcc/E3AR66niqlP0mTBeHXNy13/g==
Date: Tue, 23 Dec 2025 09:47:56 +0000
Message-ID: <20251223094739.1983381-13-djordje.todorovic@htecgroup.com>
References: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251223094739.1983381-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|AS8PR09MB5758:EE_
x-ms-office365-filtering-correlation-id: ea342883-b70f-419a-b564-08de42085b6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?K3hr39AzPTvdU+yYVaSdlCL+o0OaBqUGjKsFy83G1sJQ5BsHAvEm8CmXi7?=
 =?iso-8859-1?Q?2wKn0ELZVUy4jPF6Di36Ccy4sm5RsW1n4TugxEdyBShj4hc1EtEm3nay2e?=
 =?iso-8859-1?Q?SIwtzIZ29TfbiQPGK4bgIoHvhcAfUIktLwkptrQfl76bX37DMe2BeJH41E?=
 =?iso-8859-1?Q?IB+4HWw91Us5edDi+jH53ksYgCZ6cDdoF5btCg+up0OsL6p8tHEcQ1KuGu?=
 =?iso-8859-1?Q?XlU//PBFDqoTEyQsQiUVp+9hqOVo9xB6gKFCwpj2ULwH8LlY6HJjwFlTQP?=
 =?iso-8859-1?Q?lKHNMkLGJ2H6Ftl4nGNZb+K1hl61TyQrBw7I731jaj3VPisrKbjnhdpCKk?=
 =?iso-8859-1?Q?YNSFQjZ9T5p3v1z30pAr62vF0hNwsjgmk95+LfXjh7FLOCM/LSr2ijZLaG?=
 =?iso-8859-1?Q?bEq1ZkIAZdk3lavmEQm9WHTKcWvVK5c61ynm6mc52LheXQZmV/jLa/AMMU?=
 =?iso-8859-1?Q?cnQWvqCEk5dNkxERP+G/N4/5paZYawVCT/8hhUyTIJl3OlqYsywsrOvbxb?=
 =?iso-8859-1?Q?RRaEf3n1XhaGMdwc43XaMbzYkGyCZFV+yIeOXWHDyz7Dfe2L3ix4XWJw1a?=
 =?iso-8859-1?Q?cWVkAlVXMh/N3z61qP8m3aJPtM1osEBKVTDEZmiXeeQNs43Hk9PZ39C6iE?=
 =?iso-8859-1?Q?T5XTiAOaQKZkFTlkPnzWbQZIKopTjZZITBnawjrC7JUeAWLe7ZPzDsqNCb?=
 =?iso-8859-1?Q?HUQPFxdzGZZLchf63SgZho0xbQS56uYRnkOpmNbsnEiFNvkavF9a3EfN2E?=
 =?iso-8859-1?Q?nWpMf0wynWIprp/9tejdQpbKi53YIYdUpTRMrvM5RcMrSWOlwMntyiEuBi?=
 =?iso-8859-1?Q?JnqbYuAt+lzbk1Z5w3zy2OqI5Hb60SBnScvJ80qqf08VgEg9YBmvIG/Eyg?=
 =?iso-8859-1?Q?i2R78Mxe+ELM443/7kG/q8xnmFp6uhAP2EanXKkio3YknyzgNK9bdGekvs?=
 =?iso-8859-1?Q?gARr7Eg0PMyySlyIw0i5fLl4OBOP/JsCoMTOZ6VIj3esFV4c8JwphhNu0Q?=
 =?iso-8859-1?Q?6Jd2qSHbRXH2YM4s5HyCAd8+UktQkcQk5rO34NyQwZ7bWWK0KOlcviq5SA?=
 =?iso-8859-1?Q?CK66qY5mGLLmrXv/T+3uCBQTNUPNdgWfCp7j4+jDvL9zoMpFVak3y39Eo7?=
 =?iso-8859-1?Q?USjDE8yVq492l5betsOfe8CQRixBAOrtqydn2/OUJOtbD5KUOU/2Aqkjp2?=
 =?iso-8859-1?Q?Jpqa7iDXAn4oE5fyR9MkUDXxywSMQf8m6W9iu6StcOT3ZrdwU7l7zD29jV?=
 =?iso-8859-1?Q?eip3xojazi5j7ALA2fPoXgJcxrGw/sxihMmgLc7PjtC5ByLCvuBUArkbKC?=
 =?iso-8859-1?Q?Z3KzKjo4YR6TrZ+zDW9b1cnq+Sj2eARFgPAWoJh/QMFcYsZPDszdvC8la7?=
 =?iso-8859-1?Q?Gdu7MG4w4wKYDBgQ1H8FrLuBucnzhGFcQ9RE3GP/uh7rcmsClcKzko0TPw?=
 =?iso-8859-1?Q?OPoY6sC3P9mQSRSBRJWdx0Rk6qaBc5l45WaZ2Ng6gLUdNw1yn6MPzshfFv?=
 =?iso-8859-1?Q?JZKydmj9HYhkLQvoIvncSocnYJbscQHqanJOzGBDyd7iiIiVM8U0QFQxiW?=
 =?iso-8859-1?Q?40eKhgj5b0Cqj2847uxNa1UczxHh?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cPj7APR6zeqkriPWzj2oL5sGv82JmyERw6zLQzjY0nf+YzOlXMfkRXC6bb?=
 =?iso-8859-1?Q?URrTPjA+rmyU7ZVC003GQmyTIFnlxZLFZYRm9xVjNgPzDPcIeHR7e8pQsD?=
 =?iso-8859-1?Q?sOZzN+ayFTAn+0IdsvIj1TpFhzpgNaxSYEA8G/bNfJS5FXJxNk9rj0Hv6r?=
 =?iso-8859-1?Q?5O1k826SvWtBrVn8hn3QqWCPMPq5TercZZdsV87RlpNtU/NHHIeyqpAwiO?=
 =?iso-8859-1?Q?TtmYOT2U4mVLpUjysdJ7YukkC6gaWYbctmXxzOLzeIrw6yDaPf9EcnNpzS?=
 =?iso-8859-1?Q?TVOxE6pfJ0/6IKT2IeJ6PN6Th/xSTq87RYfUitSQWZamrb/kVfhctAPMVE?=
 =?iso-8859-1?Q?kt72eQepxdUD6DQjvPtE+sL4gY9CBfAqq8Lj6BIRY2aUN+tcoARIgTRSzQ?=
 =?iso-8859-1?Q?l4HRGEMKKPIPOs6nGuyZm0hFtg/Maj3YNOX8f94+YxEyypFj3nIuOmhEdk?=
 =?iso-8859-1?Q?UF6JWX/1RnioRbF0wqALltFoIqYhcGtBd6nnTrwg35Pa/rurDz9O9zes5G?=
 =?iso-8859-1?Q?Ioos+AZ6sFokN6vqwDfoj4ZTsy8sWuaw/iXXj/AZf0ipOPtpOuQUIUeodQ?=
 =?iso-8859-1?Q?HR6F0hpOqgIfD/BfPgWBDekj5T+EDjUWdfAYv6lb1Tzsgy3ukGoh6s7EHm?=
 =?iso-8859-1?Q?hcbFfegcKMlq17m9kVKKKDQIePzNtY9JgDTDdnPaNu1lHFCLTAuc8XHG8r?=
 =?iso-8859-1?Q?Iq98IN0nerKilcH7nDEAaMRevcF0HQmXLaAV3sXcC8JvVkgTf8ozirniWU?=
 =?iso-8859-1?Q?UWbq7x/Q6Jm4vPE2NbYZNwbP9sN1/ycPUAyOEakbhSPN8dW827tpEtCHEP?=
 =?iso-8859-1?Q?FBSDtHQr/VUjq/9psPPb+MiwPfsrCaTVTaeoBRr9t749IohJHVpwIzKBQs?=
 =?iso-8859-1?Q?fUJvQvT6VcB/I1rjul6RHGcH5R5czOaM8xpk9I+XR7ezmYxktM94+D2UB9?=
 =?iso-8859-1?Q?HceBEqBYqrksisGhQ5/7H9cakJs0b7E//6f/78iiaIjGCeqHsUudov9RnN?=
 =?iso-8859-1?Q?NA/e3V2KJ4RdZLkhLG8RHQfL0LVm0BDaqwzENMzHs4og6ciKTT6OLZDCSN?=
 =?iso-8859-1?Q?YI4JBclJ1JPJHjh5pQcSIKgBBd9jahkM/Fs/CfPed5VYDyy6/0TO0d3HkR?=
 =?iso-8859-1?Q?FH0Il10o9bY/zfFjcvSSVRKKCVBuU42Vjn6cevxL3VMmlJYLfpzFNRuyUt?=
 =?iso-8859-1?Q?VlBfU/4b1EgASiXZ0lj7FGOJ2nadQCvc+8bP8Wd/f31SUx385UymxLVpSQ?=
 =?iso-8859-1?Q?yPbdqpC+K7+d2ZBT4pbM5+1PY5AbZz4lRss/BYHqr7U2JpDodGj1OWjFj5?=
 =?iso-8859-1?Q?jHOBwCA4gg3GfeNhqT8fCnWD4qTuhN0oTs6r8/nXveXK769EQSyTBC4TQt?=
 =?iso-8859-1?Q?AU+XHRrfp1BMZ0TsvBrkjQbbjuJFX9WoGhLSKlFhwQj93Sb1wDycTrNJ8c?=
 =?iso-8859-1?Q?SctcwyBhFnXz7YcHs6g2GroYDy46ciikoAMp4mnLJIMRL5dHZ/zRhyue3P?=
 =?iso-8859-1?Q?EOP8Wlyaszufzfy3ichkHzAG8sbJVx9oQWKlBdiOJts3QVXeUXFZju99lj?=
 =?iso-8859-1?Q?szYsnAPx2ik1EfYhYGpdCOVaXYZCf7uE5ZNVcCPI+S6AaMUSlcfFob6EL0?=
 =?iso-8859-1?Q?UA74a4nbnzZekrOfH52u3Wev7XT6LoExVLxs1vo0pl31JsDcJAQpuMa1EL?=
 =?iso-8859-1?Q?5/wLaV4evMdxlIpgA8wn0AVAy6qoOtn0JG4UyKElkCTpWzNOEoxryM0IaW?=
 =?iso-8859-1?Q?LTTR4UMWqyjEFZ+nNq2qvqwNhAp0foWHJ0WlJ8lkCDuXEeNTIqv57m4uzm?=
 =?iso-8859-1?Q?/P3bnl/8AzNCSDz5txgCc4fM3mGBkOHB+mG0ZXXZw5Z6+IQt2AC1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea342883-b70f-419a-b564-08de42085b6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 09:47:56.9500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrd9HT0Kh2kxdZYSUJVzvTFBzccEWxioZCEa2h97zhk856S2fFyd/H7/SARirX9JBvP1qkZkRYYFMrNd2WjEPjgx2UhbHrYzAqrwsI4i5E8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB5758
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add functional test for Boston AIA board. The P8700 RISC-V based
CPU by MIPS supports it at the moment.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/riscv64/meson.build    |   2 +
 tests/functional/riscv64/test_boston.py | 123 ++++++++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100755 tests/functional/riscv64/test_boston.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv6=
4/meson.build
index c1704d9275..b996c89d7d 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
=20
 test_riscv64_timeouts =3D {
+  'boston' : 120,
   'tuxrun' : 120,
 }
=20
@@ -10,6 +11,7 @@ tests_riscv64_system_quick =3D [
 ]
=20
 tests_riscv64_system_thorough =3D [
+  'boston',
   'sifive_u',
   'tuxrun',
 ]
diff --git a/tests/functional/riscv64/test_boston.py b/tests/functional/ris=
cv64/test_boston.py
new file mode 100755
index 0000000000..385de6a61d
--- /dev/null
+++ b/tests/functional/riscv64/test_boston.py
@@ -0,0 +1,123 @@
+#!/usr/bin/env python3
+#
+# Boston board test for RISC-V P8700 processor by MIPS
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+
+class RiscvBostonTest(QemuSystemTest):
+    """
+    Test the boston-aia board with P8700 processor
+    """
+
+    ASSET_FW_PAYLOAD =3D Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/fw_pa=
yload.bin',
+        'd6f4ae14d0c178c1d0bb38ddf64557536ca8602a588b220729a8aa17caa383aa'=
)
+
+    ASSET_ROOTFS =3D Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/rootf=
s.ext2',
+        'f937e21b588f0d1d17d10a063053979686897bbbbc5e9617a5582f7c1f48e565'=
)
+
+    def _boot_linux_test(self, smp_count):
+        """Common setup and boot test for Linux on Boston board
+
+        Args:
+            smp_count: Number of CPUs to use for SMP
+        """
+        self.set_machine('boston-aia')
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self.ASSET_ROOTFS.fetch()
+
+        self.vm.add_args('-cpu', 'mips-p8700')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-smp', str(smp_count))
+        self.vm.add_args('-kernel', fw_payload_path)
+        self.vm.add_args('-drive', f'file=3D{rootfs_path},format=3Draw,sna=
pshot=3Don')
+
+        self.vm.set_console()
+        self.vm.launch()
+
+        # Wait for OpenSBI
+        wait_for_console_pattern(self, 'OpenSBI')
+
+        # Wait for Linux kernel boot
+        wait_for_console_pattern(self, 'Linux version')
+        wait_for_console_pattern(self, 'Machine model: MIPS P8700')
+
+        # Test e1000e network card functionality
+        wait_for_console_pattern(self, 'e1000e')
+        wait_for_console_pattern(self, 'Network Connection')
+
+        # Wait for boot to complete - system reaches login prompt
+        wait_for_console_pattern(self, 'Run /sbin/init as init process')
+
+    def test_boston_boot_linux_min_cpus(self):
+        """
+        Test Linux kernel boot with minimum CPU count (2)
+        """
+        self._boot_linux_test(smp_count=3D2)
+
+    def test_boston_boot_linux_7_cpus(self):
+        """
+        Test Linux kernel boot with 7 CPUs
+
+        7 CPUs is a special configuration that tests odd CPU count
+        handling and ensures proper core distribution across clusters.
+        """
+        self._boot_linux_test(smp_count=3D7)
+
+    def test_boston_boot_linux_35_cpus(self):
+        """
+        Test Linux kernel boot with 35 CPUs
+
+        35 CPUs is a special configuration that tests a non-power-of-2
+        CPU count above 32, validating proper handling of larger
+        asymmetric SMP configurations.
+        """
+        self._boot_linux_test(smp_count=3D35)
+
+    def test_boston_boot_linux_max_cpus(self):
+        """
+        Test Linux kernel boot with maximum supported CPU count (64)
+        """
+        self._boot_linux_test(smp_count=3D64)
+
+    def test_boston_invalid_cpu_count(self):
+        """
+        Test that 65 CPUs is rejected as invalid (negative test case)
+        """
+        from subprocess import run, PIPE
+
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self.ASSET_ROOTFS.fetch()
+
+        cmd =3D [
+            self.qemu_bin,
+            '-M', 'boston-aia',
+            '-cpu', 'mips-p8700',
+            '-m', '2G',
+            '-smp', '65',
+            '-kernel', fw_payload_path,
+            '-drive', f'file=3D{rootfs_path},format=3Draw,snapshot=3Don',
+            '-nographic'
+        ]
+
+        # Run QEMU and expect it to fail immediately.
+        result =3D run(cmd, capture_output=3DTrue, text=3DTrue, timeout=3D=
5)
+
+        # Check that QEMU exited with error code 1
+        self.assertEqual(result.returncode, 1,
+                         "QEMU should exit with code 1 for invalid SMP cou=
nt")
+
+        # Check error message
+        self.assertIn('Invalid SMP CPUs 65', result.stderr,
+                      "Error message should indicate invalid SMP CPU count=
")
+
+if __name__ =3D=3D '__main__':
+    QemuSystemTest.main()
--=20
2.34.1

