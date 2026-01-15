Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AE0C47BEA
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 13:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd7WH-0005Ny-K2; Tue, 06 Jan 2026 08:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@hotmail.com>)
 id 1vd7WF-0005NU-J6
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 08:54:43 -0500
Received: from mail-japanwestazolkn19012048.outbound.protection.outlook.com
 ([52.103.66.48] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@hotmail.com>)
 id 1vd7WD-0003lB-Q6
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 08:54:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nv1SO/Q0EPgygUOObT4bGmIh22S+fD0R+VSWmWpeC3sqVxJrcAOz4abiqkS0x+AIwteK2TfA6wej2o/rTV3+toFkDR6XXVMY0Hl+uobcKc9/6pkS8lmafXu1loTbGTGsjKxRVl4U0KB3rRVPqIMYGOfB9FHfrCcIHKUUPo6eyEeOMjN/3mIXshA72xpmvgAGGv7tgKPYhPZI4DjaCERpSE/pAX/RImYDg+aSxPL+FJt2l8U0GcQGsW9J8ty8RKPK6lqqp5tcmJKfqwkgqhwIM0Xsb5QLahvTJ+ssRN1PTaTNLreW2d2+So3BqJe//eOYh2q7VCOmnFCC21KBelNf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQRF06nUDB5tDZFMgCv2i7eIMWGBhyelHFVz18/XXOU=;
 b=uVRwZ6llOI8XfOm6rwmWGbnVdRFmOVFjBY04JwMJ09zKb2b9ksqnHNqzw6Uhh3CR0U25wu2Pt6uZCS3yY9Xkn5CgIDW1S2Y6mPCh+RsU3zRWQvgxEVMkdRtSnxkH230sFAnLr4poNvYrGTApIAkLdzAYdR3w98Zdu6JyuijPMUJvq303CE3FUwr4zNrWoEG94rDVTuAOP+dvY18M4SlIF7rPODiCshpxzZ9V/3SEzXSXfumoQWCNYDJr3NVf2NVykm6Pr/C3bmnyfylfLWMtQnnp45fADolTphzI2NZ4cMJZ0HgIhlzIXiXmKZ6iDPqx4nEXetKa47Vkhai2Cw59CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQRF06nUDB5tDZFMgCv2i7eIMWGBhyelHFVz18/XXOU=;
 b=dZIAWf/UhY9ww5jzzNah7MERWnDRZemXPnG3Zv8i4xxre3kKjO5LIFLWxPF9DSDp2GftmgBzxCKesco+FTVJNyQK5yGIHV/5jVSkF2OIV8K8h4Dj615EY8Wex8Hg+Y/hAVLZwB9/JU0CztgsctcpFI4aGhYNBZ1TzbSrIu7bEhQ/2TOKDbylIUyPiL7RxuUl+J72gV5eq8lsnaJ1nur4D9u/mUV00fwnxsv9q9WexLkmLjUyd2+uC0JgmEhY2bmzAzcUCjJb5/omq5vbseDv4+S1+xo6NbQ9Fr6NX/MWcwNjd3pVtJ5Rzb+e6Fm/FDAmghhLPcCKPnU7RN24YKJBxA==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEYPR01MB4174.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 13:49:33 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9499.002; Tue, 6 Jan 2026
 13:49:33 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: eduardo@habkost.net,
	pbonzini@redhat.com,
	qemu-devel@nongnu.org
Cc: wei.w.wang@hotmail.com
Subject: [PATCH v1] target/i386: Reserve 0x8000001D and 0x8000001E if
 !CPUID_EXT3_TOPOEXT
Date: Fri, 16 Jan 2026 03:19:33 +0800
Message-ID: <SI2PR01MB4393C152E5D8E3E964AA9E02DC87A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::7) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID: <20260115191933.3629006-1-wei.w.wang@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEYPR01MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5fb4c3-67ef-4dde-ff38-08de4d2a6b79
X-MS-Exchange-SLBlob-MailProps: qdrM8TqeFBv5zL3Pq3ogIg0sNnRYStpo9ixdgsxkFBX4GQndK7PDrZXvGL9bbdn24FXGLmHUkQjys4r3KN2cT4ORkgLKtV6evAvW//UpIrDsD7iynO2kw4K4fNZJsULlpOw5GcMTZE19c1x3nn3KcmDGRIwBfjbTJM3gkXSpq/Y34dBhtb/78LcPd1ZD/HTeMEsuPeRp4nAHVzArvHw8J0ScbEk3vFzHFI9VakgNYcZY8xnBL3JY6Qgf8taLVK2Y7AAsa/GDKMIk5uJfIMY2HcjWNkqQtpOw2cV6g5Kns3mwkeL/B3Npi4qy7OmsDHhGgDvwy2l6txdoJzPQEYfkfRQeCDUM6n1Iv54oVvwsEACowHmuZu/hizh3XPxZ4C8eOkQLFxfVW4LiQq9h2gARL+XazZ1+4HexjsezhP0H6pMLLhq3uKidTtmDuseJVKueSykS+1hpTK1dUDbzg9Tfxtuu1fbqpkLyF7tReaaPOBOzU6vnhyFceQRRppRYyYCV6Pe2JfBEC6Gd7MPiPm7ubZKccOE09aSyehqXWae/ybpI2gWNNH5I4L3A80GiX7G4JhVDM6zf98dyOrSCNIBt+HxHgAy3yWJGJj5VHlX/j/NK3mKnbs7INn0Nl50NI75JG1+U/uqsHAOY6UXb7HEnkyeElG7yWDMbo9xXDOuJEUqvMq4UCsa8qw5YwtTG12k7lMDdlqX7R8eO3a+7clCCWrobH/EpWLlcNd670d3egFJyYadBeSRnA7BkhvwSxyS5/JAdJI/0HIEClCoqo7lUAxxZT9qlbppz
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|51005399006|37102599003|5072599009|5062599005|461199028|8060799015|41001999006|23021999003|15080799012|19110799012|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zeZfIBV+9jEcB7Hjbvv/g8L2TAeh+MyRcMe/gI66VKEz6eWh51rFYXNoLFUH?=
 =?us-ascii?Q?aEiPGJQgadeSCPs8Lqx0jeOT6EQIjBQiPPc68ApbbZWi3+NnbRONg4uo86wn?=
 =?us-ascii?Q?wyxRIEkfOrNKrfSl+N6Oadl6B1gp+KjsxASc1qMtkKMbvT7Y2EwmxDFq9ky2?=
 =?us-ascii?Q?emGjpJeJDt7FloP54H8xG4k6vBbV6yJmrnqot0yjW52mALQvbK2LAVBzwgs+?=
 =?us-ascii?Q?4Eri5tSizDGtECEolzIOMGwfxbxSxFWLI34qG0yseAlgbzm2jJw6iySP9/q3?=
 =?us-ascii?Q?oJhUztWgCzRuQwNbCZLxvF12YjwQSZWfKh++jamy71ZgDrHPVdS5qsy7h6WS?=
 =?us-ascii?Q?o3RKpeZrgqTMZ5xwQTUql9oqDczgJrHTqYJUnsdtGv7BtUMEfIQ1QZvQgBdX?=
 =?us-ascii?Q?bEIbharN+4uMejVw79Kht6q0BjfLn/fQZcjtO3H7ie5/HZW12KqUFzkexJjf?=
 =?us-ascii?Q?ooltgOc3yaZ3RJ/RKPjOZRnLppNOrpzKtreIK88CmwgZbwvsyMOlI3ZQEBmi?=
 =?us-ascii?Q?8druQqpE+AkQmQxyzxCJrPN3gQpnXywDacfwHLn5NRxwQ1AYAjCesXZb/NDa?=
 =?us-ascii?Q?6EV0p9jBjOoM8X7KWO1H7QVWTxVD2ro2NaHl7ABGGwXB5lKhAgbvKyrBdsql?=
 =?us-ascii?Q?xdbBG/vpEtLP0Nh7hzPxXpkE8LO/CQbBV2cYu1MbOaiTgIZOlag+LcocZUX8?=
 =?us-ascii?Q?eoVanWXaO2s3Cqc6Eu/nN2jvSM9C3qHbjg9Wjn7ZW/o87P3SOrzGIr9SJPFa?=
 =?us-ascii?Q?f2BorGB89Bb5fC6QIvf/diLcyOONCp/HF+TBiUam5XVbbumbaoZXpk6SaunW?=
 =?us-ascii?Q?I2hnSxJbENZZHzQ3X97QAhNd3LXlVuAu0rDyFCD/q7WLxqhGthnSrVptG0Bs?=
 =?us-ascii?Q?ILTVsWYGN2NU/JG9MVf3Kk5s2iaxCevx8HFAZtdekQ/XZ1mm6axF4SGRnF0P?=
 =?us-ascii?Q?om0/Pn6ihKgF4nsSvOw3i26MFHxcQMUZNfPWKY8hrVAGIFcDLtJYIYjU1etP?=
 =?us-ascii?Q?66eOzxuB0SiQOkEMBO0BKryWoabnC7fCZsT73T2e7Ac850Gfan4T+cgWNcc6?=
 =?us-ascii?Q?+u6P/pwL9/e5JqVwiE9svlVpgIbMnQrzIiMQBM7mx7OLnUG+rkMd+QhMYRLa?=
 =?us-ascii?Q?wd/6LM37b8cYFQC51VwxQjJAoPz8FD14AdXT2wrPnSXZKb+CHnr4TNsack9K?=
 =?us-ascii?Q?Kn8DnZyy0hrEo9waEKuM1H5bTpxN9tqCg68WlVwI4MDYbxu+K3i5HLTCwhWs?=
 =?us-ascii?Q?2s0oObG14qC4IqhgqZqvbBP1bOBRd9oo959AavMIT0KamGQk3Ky8PG/cD4E7?=
 =?us-ascii?Q?FpA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hyRyN5F80eTce9bcGsrosxFhBt0HL+wbXCEfcZAooctjdii4HCSZwF7wuSVv?=
 =?us-ascii?Q?elXTVFQUtAmSKBrEoTEoeS7xPzN4lzms0bu/ZpQOdcM0v8TXh4Yjdv2fh8HP?=
 =?us-ascii?Q?oZ9Pau9pCTUiFJdS2SN3zbIQOdsSy3OTHt7ia+oVAyXzDm7xKcm0mXraUzAl?=
 =?us-ascii?Q?MX5F0VKCoGDaDsg6J5zhxrSSAvYUHXj4YDAkYtioufpks+/jDR2rAwlghb9m?=
 =?us-ascii?Q?CTwpDnUEAxA+SxrLp5A76ON/iNjqE7acA+w+Jh/2EuA6i2jxVunZTnOvcWnv?=
 =?us-ascii?Q?1JJXFA6OKliGx7YZHMk8Jvuw2nbJfRsDs0TPMhdqThpVmbm6lvfuRl9FunXV?=
 =?us-ascii?Q?DF1f2FK15AbvjZUIYCA4DSRqoIUeCW6Fk4WahPgTisL1wE4INgLvCoJISCPR?=
 =?us-ascii?Q?FuHsTcVHxG+RSFdsRiUpjiz5Y9HErCwO71cX+Ck33QvCtUVCGgBNDwBeAWCP?=
 =?us-ascii?Q?3UBvpsM9RpQHFw4Fbwz+ZlZK+8Rfw3FVMqmR4Jo1cAZ8ZUYC1vKHNGv+Matg?=
 =?us-ascii?Q?HraqnCLlI9yBWvUK/FwQWUs42c20PD0pW51f2MGYT7LTdkXcIgzyFOcvcl5u?=
 =?us-ascii?Q?UfZFlZ6RI3uaKBpD5i/1gVpU0Sr3KGl+X2RVpAh8B+/hMnolpzOCK0oL59uL?=
 =?us-ascii?Q?cvf4nJ0WnPEYXU8ss8367M3gePtHbz5fVNPIaEKSuJ4JKcNWKgC//2CdENCR?=
 =?us-ascii?Q?uIoMgpXQbeOlrPrWRhmEt1GCz70/ZVwKcka4zyqf+TqNxv36M7rKO54Qgegl?=
 =?us-ascii?Q?RdkjvnD/Zqb7qUnPn56YgBlSf7Ppf+sYJbmmKZDj6r0Xqv6+e+KJA6Cn/sFA?=
 =?us-ascii?Q?2IuWIrQzUzDutQ6Yum7c0KxECJECreqrpv+8rjrP0iPalutmwIquFd50r1fr?=
 =?us-ascii?Q?Jyc0r8EUblT1s6AbXmXEYvzlQ8q5NKDjts039DZoSbAqEZN/jfyVidnPtVtW?=
 =?us-ascii?Q?3kHOssacJL5MuZnqmnhRTG4m73P2d8+Q+eLUvAhYl2l9DJArboLNe2x4zjdN?=
 =?us-ascii?Q?s5Ze6a2mJlVwW+gvJca+N9rhoVu0h3UnrH99N1BJYGFiz0sbdlFuU7reWaQL?=
 =?us-ascii?Q?mZiDUKuZ5j/X5pnoX9leTZaX0FPL29PhgXtMhdadftOPMU4qfXF+Rr8Tpd9I?=
 =?us-ascii?Q?U9CtdJM007lPJ22mYeIX57C1YNuGB4Nca5/CP6Bokd9Eif/AsF0UYI6bhj9z?=
 =?us-ascii?Q?2Dwz/16bjyhBKgEAHwU67jxraunOwlyROzJOJsApNYnhr00ECyhkga2o8iNH?=
 =?us-ascii?Q?u9la5uaXamL6xz0q1yWeDLipTehBZLNV7nFYMTzHQnRyAeKZDrnGKh9yfOYf?=
 =?us-ascii?Q?OqLAe/a/jua4bxXYwI4jA4IioGBSyGoMxuFiXdbt7qUknK5BmwB77SpEUp7v?=
 =?us-ascii?Q?dsqsnZ7M07piZNaUqdfi+Lt/AISO?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-5f51e.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5fb4c3-67ef-4dde-ff38-08de4d2a6b79
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 13:49:32.9170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4174
Received-SPF: pass client-ip=52.103.66.48; envelope-from=wei.w.wang@hotmail.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_DATE_IN_FUTURE_96_Q=0.01 autolearn=ham autolearn_force=no
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

The AMD APM states that if CPUID 0x80000001.ECX[TopologyExtensions] = 0,
then CPUID 0x8000001D and 0x8000001E are reserved. To comply with this,
ensure that EAX, EBX, ECX, and EDX for the two leaves return zero when
CPUID_EXT3_TOPOEXT is not enabled.

To test, launch a VM with CPUID_EXT3_TOPOEXT disabled using "-cpu host" or
"-cpu EPYC-Genoa,-topoext" on a Zen-based machine.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
---
 target/i386/cpu.c     | 7 ++++++-
 target/i386/kvm/kvm.c | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6417775786..437da88b4a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8489,6 +8489,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x8000001D:
         *eax = 0;
+        /* 0x8000001D leaf is reserved if CPUID_EXT3_TOPOEXT is not set */
+        if (!(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT)) {
+            break;
+        }
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, count, eax, ebx, ecx, edx);
             break;
@@ -8519,7 +8523,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     case 0x8000001E:
-        if (cpu->core_id <= 255) {
+        if ((env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
+            cpu->core_id <= 255) {
             encode_topo_cpuid8000001e(cpu, topo_info, eax, ebx, ecx, edx);
         } else {
             *eax = 0;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 60c7981138..c988358548 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2029,6 +2029,7 @@ uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
                 cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
 
                 if (c->eax == 0) {
+                    cpuid_i--;
                     break;
                 }
                 if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-- 
2.51.0


