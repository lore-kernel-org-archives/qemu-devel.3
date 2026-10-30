Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFD4606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=SEUwzYe6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMsTv-0005XM-JU; Fri, 30 Oct 2026 15:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ar.semenov@outlook.com>)
 id 1xMqMs-0006QV-Tj; Fri, 30 Oct 2026 13:26:18 -0400
Received: from mail-centralusazolkn190100000.outbound.protection.outlook.com
 ([2a01:111:f403:d107::] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ar.semenov@outlook.com>)
 id 1xMqMr-0005Tb-4y; Fri, 30 Oct 2026 13:26:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgnBwDELqhYB1ZrMYT94lsjRrIz3S1KwOyS0jVcxdcSixYCRVzws558WX7MdQiN/6+ziLRiKYmYGDLak6GoAu1tMvANWmhzjfTJs9CZsODrCYGRzflRsDeXxkdOUoWH7rDbtZQ8pAWnd3n1QRh8d438IpMVV+JMx6ntD97Mj3qBZjvHLkQPND7GRf0VnpuTgp2v3FmSMiiH7lsvdDJIz7/MyQ7RwjeZnks4Q3P2arH39q16is3w4NoxXpItORRCdKNaB7I2+TSTdGSBErEtH4Yed5smx1yajUiMVq16R4IibdAsWCvyV281rTmgTWR6qDeS7hWyRxVivc9LbueRQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRnBFojsoXoNyJ244ylU/u+eWLNzIV5MB9bG+U1zTZ8=;
 b=pBrmuBeJ/ZAWdkzJWFw2swpyW57FZlO97ZLtTfCTUa5nWZO0J0+jriQOBxEP2cV+qR1kj3cP0ITpt+3H5gotr8bg+w3uDDRFPaegJJkzGp6qyiU/jqgVMHtrM3kbV1R45Z5AcD0PetNpmRF35MRTxrJz2lmdcnEZM4G1TUz25WYvKdQRLB4dZAnZYeazrNPVHYqDzc8ZkXF45MGBOlX1JA8opBzbfCWyY2+5izuyPx5oUg1L53mZKhtVlov+ONErJPIbrMuDJ/p4zP7o+MzVkqaIY9Ie52pJNAMd6xgsdQG5b/zGxZjPKjkVOTVZ+knipi6dMqHEqV0eI6ztFb/Tqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRnBFojsoXoNyJ244ylU/u+eWLNzIV5MB9bG+U1zTZ8=;
 b=SEUwzYe6GvcHO6isObtcA/9q1UkEpW2rjZ1hQL9L5BZaXFU06Nm7SKp7/wkQWwvqqOMMukUun8CWGCNVadvCBfItRIBePlPMS70tg0acP4X9bWorby4LUxn4dQgzqqC/4y5vi/e7D/K5EHlmvWo9cGU7wMdXOKzxRCvqsV/4YFg5MUX7r4fEvtdHiQM/kX+AQzgI4VoZaSLdbz3KCSmf/jQ6bvdZbELRwqVj0NGBk5N1cJ2JPj3LFw82oECxdtsIEncguPDWEW07uPK3eWaGmwZBfk4mNRuXki1AU0O6XlOGqPM01FIOnfPUaI7hNPW1YCM09oxasCQKCdoRDRedCQ==
Received: from CH3PR11MB7346.namprd11.prod.outlook.com (2603:10b6:610:152::12)
 by SA0PR11MB7160.namprd11.prod.outlook.com (2603:10b6:806:24b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 17:25:36 +0000
Received: from CH3PR11MB7346.namprd11.prod.outlook.com
 ([fe80::89d:2e3f:86f3:48e4]) by CH3PR11MB7346.namprd11.prod.outlook.com
 ([fe80::89d:2e3f:86f3:48e4%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 17:25:36 +0000
From: Arseniy Semenov <ar.semenov@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, Daniel Henrique
 Barboza <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "antikostya2@gmail.com"
 <antikostya2@gmail.com>, Arseniy Semenov <ar.semenov@outlook.com>
Subject: [PATCH] target/riscv: add support for the hcontext CSR
Thread-Topic: [PATCH] target/riscv: add support for the hcontext CSR
Thread-Index: AQHdaJOAUxdH3pO4MEmFpfh8iB7Iuw==
Date: Fri, 30 Oct 2026 17:25:36 +0000
Message-ID: <2b1cfd78-2a92-4077-9ab1-a2c865d6d673@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-imapappendstamp: CH3PR11MB7346.namprd11.prod.outlook.com
 (15.21.0569.002)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7346:EE_|SA0PR11MB7160:EE_
x-ms-office365-filtering-correlation-id: 9a6cc9ed-732e-4c28-c2e8-08df36aacfb4
x-microsoft-antispam: BCL:0;
 ARA:14566002|31061999003|15080799012|24121999003|15030799006|41001999006|24021099003|39105399006|22091999003|8060799015|22141099003|8062599012|19110799012|4140399003|6050399003|102099032|440099028|3412199025|26121999007|3430499035|40105399003|1710799026;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?dB8Lo8vRIdhBNDaC633mbOfpXqnbLMGWBDaeuNdaGQmb5N+EqmAuLs7pZY?=
 =?iso-8859-1?Q?di2GJH66G2kcc6nERcwqJMlQZPFVz+iMU9ZM5mYRCAoxJjW0R3lobw96rD?=
 =?iso-8859-1?Q?XN0X0PKhSUn0J4XRzn/6yLQ531O8UmmdxnMy0lBcebYUmqPV1ALtO+ebpy?=
 =?iso-8859-1?Q?rtj5Ib+XJ+evEV4/dx9IOyjadgDu28CzHo1cO5xjgKQNJoN47gxV3CXToj?=
 =?iso-8859-1?Q?JpD/r4V+fNDmn5uO1E2qof4rjS25GFcmTgAUdlwxNewkzQVAvhGcyfmZgP?=
 =?iso-8859-1?Q?BTY3y2f+EEleXQOUEjYNxwEwa3OHZwJHdwqDjxNFJrcMRkmgHObQ9wabMh?=
 =?iso-8859-1?Q?Reup8Awa9TA4yVrmBQPRrpcYpFHJjUvnc0N1k6+7ExrY0w0YUUKkHHCjSI?=
 =?iso-8859-1?Q?9yCOFn/JjVUSZzjFj5/QBV0/QJsOWYieDP2exzhC0iDBkd2mzs2FmAa0iW?=
 =?iso-8859-1?Q?o8pgQA7DBXL6Sj5w3EDpEYnhPb/iavVC+G5rnp+nbtSR8lqp4gVyB0YQI/?=
 =?iso-8859-1?Q?wh2C4YFpHVBrMeHqjjOG6i3j/p1Z8+92O3watMWv3MXkIVp9FKpsCpSEgL?=
 =?iso-8859-1?Q?i9LYEbdj56nbP0iJvZ8M1/nzjDGZ1y/t9U0xq4KQSg//HRFHUqN5tl0Uqw?=
 =?iso-8859-1?Q?8qDup+mbqZKxYz+2Q5DGCJseoXVxobwQTVyLxMLnEN+ZVpnY459bPfPazL?=
 =?iso-8859-1?Q?sjOrNZ5k5jEArwVWxwYYAlaIh5iSyf26Hntq8Kr/zNcYT0kuOfRmFgPGev?=
 =?iso-8859-1?Q?0gOtMpkN01QxmCKflWxsUdYb062nvj54qxudU0MKER6VchCCjin+MFhBSX?=
 =?iso-8859-1?Q?2pRi7Py0JlBVu8DTRoptO5YxVzz1UiuElE1JMLZw0/lWaH4QX8Lr1uXrkG?=
 =?iso-8859-1?Q?jv+BAQGQ2hMZsNgIJWpc3DOQv1sv/TKnEqX64SChxhwQgglGBZf6A/TmtY?=
 =?iso-8859-1?Q?qZu29TQ1yNv2orxAkn2PgVJNHO1rZ42Nn95FQH/W0f0Ub/iI3otjJlV3zA?=
 =?iso-8859-1?Q?xMzj+WGd9rx5MLJmmroIa+4eQ1ei+1RDLVkBrh1kldes9HY7h7DdOKSrcz?=
 =?iso-8859-1?Q?EdqXav8mpEa8Q6RbUGWcgT1wt9W7A2Ncq6ghUlgAyKNnaFPBG5N6xUrIYY?=
 =?iso-8859-1?Q?oZeO/hYM5W3ud6s9qYEGxn8hdgAY6JYsM+0VIS43v13ity0AVcExc+siSl?=
 =?iso-8859-1?Q?celw+bRBFN3oBQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wK6mUA2PNjiORQuFhUGseXtCwxOIVaZxILKKCcnEwiq3Juvs2IEpxBS/7G?=
 =?iso-8859-1?Q?VGMeDb6SItrwgIf7mpUZzf+SmNL6gGy6UHQUjhOVBTL0hwI5jpHpCq6sr7?=
 =?iso-8859-1?Q?HJwzrAH5tFw6JlPFBh2DNBqtJ9i9RzkiG7af698yK19IDvZ1XqyIoUz8nP?=
 =?iso-8859-1?Q?bHVEJHrnsI2I84dhh4gyPimzzAXkA2DwGJZGW4bVoqEnVEiHGKG2Tvg4Xp?=
 =?iso-8859-1?Q?t9gpUgvG6My2ENA6hrIMJmxO9QySp910s+jPCKJrMztXd7dO9+o6sAdaTy?=
 =?iso-8859-1?Q?XYSK4d55DFmSTNTZtfTHmPT1J/A2I6xwlLl5fgH7gAHSRAb+3UCSVGYgm4?=
 =?iso-8859-1?Q?zuoVGHrcxMzjWP+NpT84Vg181tW12SUNNPKT+Yl3djd28xW6fIxWjXlqOk?=
 =?iso-8859-1?Q?8Ri2P4Xq5j6Wn6xzW8/IRCRjHiGQINjLoQWchY4CZ2hdR8yAGhPHn/O8m3?=
 =?iso-8859-1?Q?G+rsN7z5UkcrCbQ5S3JwX+4ridqTXv52PUqisfkVY/CgBnh4k6RcS78ncp?=
 =?iso-8859-1?Q?BqOuKUYY2R/WpWgqF8KHf7ihT9mBkB12qjUan7Lmg/R8Z2j8xota8K2Mns?=
 =?iso-8859-1?Q?w6LxXrjfqvgOf4tX4Nu6OH8IqonDdbZXVDigsF6N4Tncnkh1EM3agRkxSo?=
 =?iso-8859-1?Q?TPcOQiuz15xSXqfw+QgiXMoGwa9NMhoNstIp7RleYvltGLsgtd1MoaySg1?=
 =?iso-8859-1?Q?jVBGHHMsqDsRy0Rp37QAS5BSfIFA961W2J8DXzVbx6htsRLVb5p/x2oFcu?=
 =?iso-8859-1?Q?OeerY30Ve0Pppk0XpD4yoIoFj576nI0EzBSOSxrvt4r+jklKsZt/zytCza?=
 =?iso-8859-1?Q?SNA0PZ/WiUTwmGwcVcKDS0F4KfwbFfOyqJ5ll0xBx5cfxfkUMHVIx9HcWj?=
 =?iso-8859-1?Q?xLn31AXwQva2zTuRDWB3bS03cpxvNj2ByCg8fqzD9/wZxEjw4bIlCw/YJi?=
 =?iso-8859-1?Q?JNPS/wus40/4U2qrFnU0yjaM1WN7dYjt0eUyIqxPpMneWjFUJLN90b1N7a?=
 =?iso-8859-1?Q?ThxKT06RieLrCf1OjtmT2CGMeQwGhj+Zmb4Sy7RlznULZ6HOFrKFXVkD+r?=
 =?iso-8859-1?Q?lnVXBnFTa9E+rUbaYBPRFMkqhRszi5r4aBOZ1IQUPz8VTDGUrWzWPmRoYx?=
 =?iso-8859-1?Q?MRiCXjzmhx/RfT8kzVPUecyBG9qgUuLgo5LJu7F5noypA1niGUYZo2rw8A?=
 =?iso-8859-1?Q?iQrY+NL5fs3TJ1ZgmlkUren6hanp/gc416tY6ssU5fWL9OG8qD8an3MKsu?=
 =?iso-8859-1?Q?QrTOlSzHqfmZQy/xla+GvD/Et0/4gV8pKdPEWgx4n7LpgHbo95vkHnWgKS?=
 =?iso-8859-1?Q?l0tsuS8x4c5uktwujsrkwgT3IbP285Vtw8+lMbBlfuBUpAjGlKeZrnmZ6n?=
 =?iso-8859-1?Q?6+ow6b3zhs29bFaDzjcbwHBTh5QF+Kawh4VlMXhZ3paBJW2aQzYOY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <8F0593CE1D243548B30B5BBC18C6B09F@sct-15-20-9412-4-msonline-outlook-a6b68.templateTenant>
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7346.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6cc9ed-732e-4c28-c2e8-08df36aacfb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 17:25:36.6530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7160
Received-SPF: pass client-ip=2a01:111:f403:d107::;
 envelope-from=ar.semenov@outlook.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Oct 2026 15:41:40 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement the hypervisor context (hcontext) register described in=0A=
"The RISC-V Debug Specification" Version 1.0.  The hcontext CSR is=0A=
accessible from H and M mode, gated by the Smstateen HSCONTXT bit.=0A=
Writes are masked to the width mandated by the RV32/RV64 xlen.=0A=
=0A=
Signed-off-by: Arseniy Semenov <ar.semenov@outlook.com>=0A=
---=0A=
This series adds emulation support for the hypervisor context (hcontext)=0A=
register, as specified in "The RISC-V Debug Specification" Version 1.0.=0A=
=0A=
The hcontext CSR (0x6a8) is a read/write register accessible from H and M=
=0A=
mode, whose value is derived from the mcontext register.  Accesses are=0A=
gated behind the Smstateen HSCONTXT enable bit and writes are masked to=0A=
the xlen-dependent width defined by the spec.=0A=
=0A=
No behaviour change occurs when the H extension is not enabled.=0A=
---=0A=
  target/riscv/cpu_bits.h |  1 +=0A=
  target/riscv/tcg/csr.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++=
++=0A=
  2 files changed, 47 insertions(+)=0A=
=0A=
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h=0A=
index 3579789a1f..bfa10afca8 100644=0A=
--- a/target/riscv/cpu_bits.h=0A=
+++ b/target/riscv/cpu_bits.h=0A=
@@ -456,6 +456,7 @@=0A=
  #define CSR_MNSTATUS        0x744=0A=
  =0A=
  /* Debug/Trace Registers (shared with Debug Mode) */=0A=
+#define CSR_HCONTEXT        0x6a8=0A=
  #define CSR_TSELECT         0x7a0=0A=
  #define CSR_TDATA1          0x7a1=0A=
  #define CSR_TDATA2          0x7a2=0A=
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c=0A=
index 063590f56a..db1c8e58f4 100644=0A=
--- a/target/riscv/tcg/csr.c=0A=
+++ b/target/riscv/tcg/csr.c=0A=
@@ -814,6 +814,16 @@ static RISCVException debug(CPURISCVState *env, int cs=
rno)=0A=
      return RISCV_EXCP_ILLEGAL_INST;=0A=
  }=0A=
  =0A=
+static RISCVException hmode_debug(CPURISCVState *env, int csrno)=0A=
+{=0A=
+    if (riscv_has_ext(env, RVH) &&=0A=
+        (riscv_cpu_cfg(env)->debug || riscv_cpu_cfg(env)->ext_sdtrig)) {=
=0A=
+        return RISCV_EXCP_NONE;=0A=
+    }=0A=
+=0A=
+    return RISCV_EXCP_ILLEGAL_INST;=0A=
+}=0A=
+=0A=
  static RISCVException rnmi(CPURISCVState *env, int csrno)=0A=
  {=0A=
      RISCVCPU *cpu =3D env_archcpu(env);=0A=
@@ -5703,6 +5713,40 @@ static RISCVException write_mcontext(CPURISCVState *=
env, int csrno,=0A=
      return RISCV_EXCP_NONE;=0A=
  }=0A=
  =0A=
+static RISCVException read_hcontext(CPURISCVState *env, int csrno,=0A=
+                                    target_ulong *val)=0A=
+{=0A=
+    RISCVException ret;=0A=
+=0A=
+    ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSCONTXT);=0A=
+    if (ret !=3D RISCV_EXCP_NONE) {=0A=
+        return ret;=0A=
+    }=0A=
+=0A=
+    *val =3D env->mcontext;=0A=
+=0A=
+    return RISCV_EXCP_NONE;=0A=
+}=0A=
+=0A=
+static RISCVException write_hcontext(CPURISCVState *env, int csrno,=0A=
+                                     target_ulong val, uintptr_t ra)=0A=
+{=0A=
+    RISCVException ret;=0A=
+=0A=
+    ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_HSCONTXT);=0A=
+    if (ret !=3D RISCV_EXCP_NONE) {=0A=
+        return ret;=0A=
+    }=0A=
+=0A=
+    bool rv32 =3D riscv_cpu_mxl(env) =3D=3D MXL_RV32 ? true : false;=0A=
+=0A=
+    target_ulong mask =3D rv32 ? MCONTEXT32_HCONTEXT : MCONTEXT64_HCONTEXT=
;=0A=
+=0A=
+    env->mcontext =3D val & mask;=0A=
+=0A=
+    return RISCV_EXCP_NONE;=0A=
+}=0A=
+=0A=
  static RISCVException read_mnscratch(CPURISCVState *env, int csrno,=0A=
                                       target_ulong *val)=0A=
  {=0A=
@@ -6620,6 +6664,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {=0A=
      [CSR_TDATA3]    =3D  { "tdata3",   debug, read_tdata,    write_tdata =
   },=0A=
      [CSR_TINFO]     =3D  { "tinfo",    debug, read_tinfo,    write_ignore=
   },=0A=
      [CSR_MCONTEXT]  =3D  { "mcontext", debug, read_mcontext, write_mconte=
xt },=0A=
+    [CSR_HCONTEXT]  =3D  { "hcontext", hmode_debug,=0A=
+                         read_hcontext, write_hcontext },=0A=
  #if !defined(CONFIG_USER_ONLY)=0A=
      [CSR_DCSR]      =3D  { "dcsr",      sdext, read_dcsr,     write_dcsr =
},=0A=
      [CSR_DPC]       =3D  { "dpc",       sdext, read_dpc,      write_dpc }=
,=0A=
=0A=
---=0A=
base-commit: a19f59a72d96056d9a8f48cf6c77f5787491e414=0A=
change-id: 20261019-hcontext-e8e8f54989a4=0A=
=0A=
Best regards,=0A=
--=0A=
Arseniy Semenov <ar.semenov@outlook.com>=0A=
=0A=

