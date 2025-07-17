Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48540C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLKE-0006sI-Qu; Thu, 17 Jul 2025 05:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4m-0006Gn-NO; Thu, 17 Jul 2025 05:38:54 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4j-0002Os-7n; Thu, 17 Jul 2025 05:38:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcLTRJcubE/GuWreul94+qbXlUHl2CuzXYc+EvzoIY1mLQvTePRIaA5BDk1nNviChxgf3ibmOWZH6pkOAIV/ib7ql+KWIoXTk6rF0iLrxyuiqJSxn/yGBiW+TO5MaglbiaCmjuwePoOeZLcopZKUzoZclMsKZ1P9Pua1J7OG4RhYemLzyXAHCchNOZP/pfXgm5G13a7pbVS8/YTqiFpkC6S7gGwHjeUxt4a9iEWlHR+Bya/Yd2EWdQEE8BCYAZjeiqEIqgnMHDAXYX9s87Dxator/lOd2dGLU6QrmalzlaJ+P9QjU7s1E4ALGCEZHUtm9VO7YqtzfKv0pwZYS7YLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B2ff2ziNn2+GX5awih+lr4Qq85q9aJz9U8M4bimKwDU=;
 b=tvz6PN79KHXULfgPqBQZKuMa5+uXCm1rodfqTkCRaM7/pK+T9PsZU6EOvGUM/UPqYcL6KwdXkU7Q+wTWo7Z7yLltd1/XK/Sb+3LcHH/8J8HR6Cp4s75ZHhsCmIcnk1Nmv5CfDNrzdx/9QIC7x+Ni3NomNmLNzfnyYKAOLfPj0bdGf9lLrL/cD0A3AXwRAoNhyZ0lsvbdPxCmmY1id0mzSgAZFvoBLrD0ZIm9ot/VzarXzqV6WbGGRaysHVYTk8lawsJAD1Pw1bPSAIjM0DQXNOpp+eNnpSXuIi4bpv7/58GFkYnCgG3k5/WjFg5lCaAGnZQ1Sytc3Am2zO5iPdBGuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2ff2ziNn2+GX5awih+lr4Qq85q9aJz9U8M4bimKwDU=;
 b=WWOd/1IUTeDAsdYAu8VpXq6HQn2Ql49wabCOi4icAPSR1Uhqn+OB34mwNdYdILrVIx4x7mAfk6NEpBOyNQAEyu626879TM9Q85M6xu+2+8MqxLXR3BWDrpqF8s4yrdWSIQoogCFFSgIvD2xwkPUJm8gLmub9jEpt4AX1uJF+cksnTqn3jKdS3HrRBPP/fI8NUoOBHaC8n6V+g4SvWAqa3K4fENCYIP2x+cIWlZ6KvLyH39n3/E0kWYHdnAU7TC89yws8rgfyLcqGOuTrBZAc/asuUDePdvwgLLCKP4DWPSC86KvFMpO2mXyBRaU1KZ4IEz7/Dw6uY2plS45Uy0O/Hw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI1PR09MB4318.eurprd09.prod.outlook.com (2603:10a6:800:155::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:38:44 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 17 Jul 2025
 09:38:44 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 03/14] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH v6 03/14] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHb9v6Vpe1TlVo22kuJ6Dgs5NcocQ==
Date: Thu, 17 Jul 2025 09:38:42 +0000
Message-ID: <20250717093833.402237-4-djordje.todorovic@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI1PR09MB4318:EE_
x-ms-office365-filtering-correlation-id: 4b8f9209-1dbb-4209-52c8-08ddc515b906
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ziovHZNWQBfhGCWSwEGQtO//0Io6+6RpZBpz07qLT6SkZ7hlBLgEr2JxsG?=
 =?iso-8859-1?Q?kuwsEJu8dddTP75ywPOnkgGL7iL1YX9LuIE4qP2HPUig0z//4pfKUWe9is?=
 =?iso-8859-1?Q?FwU7P2W0LtktVAkPU5gPA+Yycc1dReHNSfbTeOA1E8E6cr6YMTnC6cHbsM?=
 =?iso-8859-1?Q?q76V6kY7W8Kf6PhWwCMtXnpvk2Ldprg1sQ4FOI3gCJHmMBypOxJtXFm3mW?=
 =?iso-8859-1?Q?0Cxm4cn8sPNrwSqjCcylWD9LZ8xmwMqKBMe+h+3befU90stEvDu4NLqlai?=
 =?iso-8859-1?Q?Y77snkEYiLMpZ2IWnB76xN0oEiJdvX+xP1k3lLhjhoKrzRjG0EJ66PO542?=
 =?iso-8859-1?Q?6wE1jy1UkOZBhHaHFAhnBs/K0/eX3v90tEieD+hqWXnHpGemkGeaIhfHSb?=
 =?iso-8859-1?Q?/qdNZUYXDHf2aJsA9Y5ciqh/Q3YkKkSqe/kgmo4YAaXwLSFWwk6QLW2B/z?=
 =?iso-8859-1?Q?xjQWneJ3AhzW0z0MrHzRcj3OB1CF2rqXa9busUsfnsN3XEebfyVXmK40zg?=
 =?iso-8859-1?Q?lPJaPi9Q0o2rR98EnLyXTgEmRc8yn1Ouv6po1df73HVg6ofX7o+uJDguhk?=
 =?iso-8859-1?Q?WOLv28LWvEcQXI4uXwFFPC0X4G7tBjjGfDPNSP8QjD7K19NCBuQ3K7MQOB?=
 =?iso-8859-1?Q?ptvF2imvDvzMDRFsCBRgxRRsSkI4yX1xG3Zks5SKu5u3LhnH2gN2YUtWuc?=
 =?iso-8859-1?Q?OlARIXH99CIZYDpavKl2ZUvWtU1FaW/Dq8p0/sQTdzwuC4gMlW+GWk3ZTU?=
 =?iso-8859-1?Q?7z9eq18TcdAP3p1LH3HqXEg56p6KYnf3v48Kd+illY0OoYEje9S7PpCfWU?=
 =?iso-8859-1?Q?yckahvOkIB+DalTxMdl1rUAfcVtwsnyShjjUdOpMJIA1XktXs1pQBpMN8b?=
 =?iso-8859-1?Q?yw511WZgT5b4R5h0uUIChM4Xer5xW2SPx5CmKoC/26kPaBTcT88rhfCdFe?=
 =?iso-8859-1?Q?V2qkfIH3oS/lTgs53Q48zr165IspNTv2oZFbRZNiS/sEdc6sMFrUFzYRDm?=
 =?iso-8859-1?Q?6tTTL1IVS3f7fDzxIIDzGzmfDWdUzmVsyh8g45DKu3WOYX2ezcIQ1FrEos?=
 =?iso-8859-1?Q?2Tx0cZO36hgSYXNrsvqRoRIT9JIEGqZJt5JvfEJwbWLgW0uPDRc5i3/Rlq?=
 =?iso-8859-1?Q?EqdxKGLUx3XIB3aUDK9JNKx+8fRN9WgeCnd8YE2fJyJCtxz4XI0UE3E7Ig?=
 =?iso-8859-1?Q?+FhUk2eOPmP1Kgz03egNvbhh0PzWVM6AKKdpYzBeDoZdLQm7ZZcSkpe9yK?=
 =?iso-8859-1?Q?AyNra4YL5G+f/9cuC+jMf+PYKKwKVd4z/kHk1Jed45L0UgwgoXsuwzus4n?=
 =?iso-8859-1?Q?Yii4CUQ1n31hYjYeGZNWrVkoSqF0KMRbmoqHdzHevMNL6Xt+HRpJWmc0Lq?=
 =?iso-8859-1?Q?8poYW5It7GDqLEcER1iBrBKWOB8r8AiIsrwuS0FhK0VNbA2P2q6Y89dqcV?=
 =?iso-8859-1?Q?JMpxoaYcQONsIAmjGbxWbOoCjsm428MqciC7hdsBi4zZWyRTGKLKARiTgl?=
 =?iso-8859-1?Q?HAZDZREnnZ69wnK5aJOL+qe6xRooG8t08MNSzp1+41RA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?W3Ah3fdY7Yt/q+FZYMuYGF7vxQmyHA+AelV/YB3ejTbxu0sZ3DY3u6H9wF?=
 =?iso-8859-1?Q?kdGAfUpfyqS3qfGfoMQ4GuRx3IV1YI6GYq+xUxab05lOSiGBGx9YR93ap5?=
 =?iso-8859-1?Q?dn8llJTO+W6f/eoE4hnXSQ2qhvFgUmAZJFLBmdaSEad1ZFljtTnyUTzAY1?=
 =?iso-8859-1?Q?icEaNgHPYcF+hMlClqSy9huZ2wLOgOT/SUC3Pm3W/WlvRL6M/f8lBsc0NA?=
 =?iso-8859-1?Q?OEVJ4ZXowRlvZJYEU8lLO9Q3JSCdH8o/aOeX1XAiuL0mg7MwP9fDFOSxqg?=
 =?iso-8859-1?Q?PRLC39XsWaF0AUpXthlGweW4n51kWWz4oXHKpsCZV03/9NphCt0SedtrNS?=
 =?iso-8859-1?Q?ZgnEL8j3EXSLfXbYADKjubckZ+1H+dvIiv21V1/mnLYLa88IqwmAjtuDp+?=
 =?iso-8859-1?Q?YKCco8LPBeZ0JOOHl7UXk5LYDQdqzjy5OG122xegK6BgE8glaCpsO3TkKQ?=
 =?iso-8859-1?Q?9nNaertLLTr26XagjTtFRQOjnPH9402YYTqB3IR9A73qK2dpz2b966S1oQ?=
 =?iso-8859-1?Q?V4UTUby4dXsUr1EfMDxIj+2taBNfCHhhYNYMvmhZiBebnJ4fOfyB8tlo5H?=
 =?iso-8859-1?Q?oUddjIpbLXWDGeCccsjLycpgar5Fige+iIRoKGKbw8PL2tGyIxTtTBFPv3?=
 =?iso-8859-1?Q?1oPEH/ymaFpf/JVjQjrgT5mfDvl3BHxajsVXyzt+ubLEHFvucXK3OdGJLj?=
 =?iso-8859-1?Q?IXX1yWLNduLBpUmruhyR7rxp1W2ntzRbtV46l6WkEXfIxDqL6jkSKcActx?=
 =?iso-8859-1?Q?ljAMzY0GhuOG4dO7UDZEHWpEDjPfukV6+pFuG1/fxICkoHh3Zfby29yp+D?=
 =?iso-8859-1?Q?Xx5+JlAI6xBaDtsEHApawBXNIGdRr/hjaaZoFMqQOcHBUscuv/olTboupA?=
 =?iso-8859-1?Q?fEgCdcWOHF9yin2cqY2n9y2ed4AahbT1spZWmcQ5oRcGcTa3FYVQfaqsdM?=
 =?iso-8859-1?Q?u6iojNTV2L0ow4pPN9AN3qGaw0FuqliosX5tIvvjWc8WB5usavNlJvCZ5k?=
 =?iso-8859-1?Q?bEJGmchi8vJZ7b/uplxm+O6A6Kko8ShnDliLw7FEkwN8P1xohBgkCXD6dx?=
 =?iso-8859-1?Q?jPagJd4PINxo6iv4p64LhKxm0Yqt7sQcV8Z6pPyg6wDkakizBJpm1tDM3C?=
 =?iso-8859-1?Q?FT8A2SVZHSCvxwkmCWNx0Z3OeLN/0qwMocy+Even/cjpWdD4B89sa7Urwc?=
 =?iso-8859-1?Q?rvBIwdoXzXLkOzeZNyDRTvRFNGIvFUw4znZmS6vXllix1iQJH3JENl9Ru8?=
 =?iso-8859-1?Q?oj/rgy5u7ltxPI4b05zXRMtFZ60pRJRayHpjqa4kjISgCbW6WuIvjqCXHt?=
 =?iso-8859-1?Q?RDa0ykB7TeTD9Oa85qzx0gjwrPTHP+Ene2N7HXvtuUTxVna3BXQriHSIVh?=
 =?iso-8859-1?Q?JylaITNQ3OXEe4NScNjITn/YgTL7j6yCTWEnUGVRmA8WE0Qb7of5eB0CMk?=
 =?iso-8859-1?Q?Zoepf0dI6Yh3IqVPDRI80MNUHaZepgIWaOdcwPey1dSjEpK+BEqSpLqFVx?=
 =?iso-8859-1?Q?QyIFp9noPyaWz8AkWSvMs3+96xxg+JSYeP7hWX1VsR7bxIIHWFVQ9+hVl0?=
 =?iso-8859-1?Q?NfXPPFSpmndPkEN8aSXF9n8AeMdFAmsflRvJJYnhHTmNmF0G5WJDxlzbhg?=
 =?iso-8859-1?Q?ekyJZmipVvPcOTMxXuXH8njopSiibqLjW4mMFycfgHD0luBZUeqjmVrDAy?=
 =?iso-8859-1?Q?CGbJjBd9OYn0mr9vRQo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8f9209-1dbb-4209-52c8-08ddc515b906
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 09:38:42.6781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TbUNSSyNWoJqUXl+qhvhCPpciSj/INSVNPhr9oDkuIiswAtYYj8LLK1U8JxKEYhl4BqYbUI2vheSP7sWkRcQa+HqGvSYAhAuWs8HN/lWlFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4318
Received-SPF: pass client-ip=2a01:111:f403:c201::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR03CU001.outbound.protection.outlook.com
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

Introduce P8700 CPU by MIPS.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 target/riscv/cpu-qom.h      |  1 +
 target/riscv/cpu.c          | 15 +++++++++++++++
 target/riscv/cpu_vendorid.h |  1 +
 3 files changed, 17 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 1ee05eb393..1e62b96094 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -55,6 +55,7 @@
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nan=
hu")
+#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
=20
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e584bdc5ac..401c0f6c7d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3180,6 +3180,21 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.max_satp_mode =3D VM_1_10_SV39,
     ),
=20
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max =3D MXL_RV64,
+        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec =3D PRIV_VERSION_1_12_0,
+        .cfg.max_satp_mode =3D VM_1_10_SV48,
+        .cfg.ext_zifencei =3D true,
+        .cfg.ext_zicsr =3D true,
+        .cfg.mmu =3D true,
+        .cfg.pmp =3D true,
+        .cfg.ext_zba =3D true,
+        .cfg.ext_zbb =3D true,
+        .cfg.marchid =3D 0x8000000000000201,
+        .cfg.mvendorid =3D MIPS_VENDOR_ID,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode =3D VM_1_10_SV57,
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb..28f0ce9370 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -2,6 +2,7 @@
 #define TARGET_RISCV_CPU_VENDORID_H
=20
 #define THEAD_VENDOR_ID         0x5b7
+#define MIPS_VENDOR_ID          0x722
=20
 #define VEYRON_V1_MARCHID       0x8000000000010000
 #define VEYRON_V1_MIMPID        0x111
--=20
2.34.1

