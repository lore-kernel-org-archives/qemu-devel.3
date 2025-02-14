Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AE6C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 17:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tize1-0001Lf-8F; Fri, 14 Feb 2025 12:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tizdx-0001L7-8h
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 12:38:25 -0500
Received: from mail-am7eur03on2072b.outbound.protection.outlook.com
 ([2a01:111:f403:260e::72b]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1tizdv-0005Gi-8W
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 12:38:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6TN5BkCposSVlM6mz840CZ1ozCYUTYdOgAIitMqgCGn48DOEA42e8BeT56aduGk9RzEXBf5Jc5hLyRh5WB2m6o9z+Em/A9Jib8j3T25RuYdcpPzUSIXm9n7W1UgkQaxSxMQfBMyvr9bk15x06maD8VIcyKxr6GA951rKqzzZSrSXXQwQLrPwneyRZdtVvUWaPecfGzNzP4jc8O+catXRk9N2QNRAvQp4SW3BIwpxNv+IIOW2B3OpDYAdohiXOe/ELH3az85gEtiA7M1HJWembTVys1vBPwWTViGBsv5OANT+0AvBT9GBHRqQTSYXi2U8ynRs4XM3OlbgHOapPUDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmvkKjNzWmlYL9hmD7xXtPKG9RBEhuwvo/Rh5fmAdAk=;
 b=kZWnaNibvuVHRI1vPdzip65FM6Z7a+b/P67zTdj9JfLL0gpfSHnbN8DYyEA5aTnLHPcoGZJ0J7qzFt6BZ8uL8+zfWpojS3jFVOG0Hcxwly2+rbBWbdawja9HQTYrRhweBTgRM+5jFd6wLJ0SgzCmAHlWK+p1aGkuTLyldQg6dkcBg0djw3QWvFHygQBry+K7p8c54AK3KWTL/BAnEzmq+W2TtLCuFqWs1BUWMIAF5W0N2U2n5OfvHwmGS0umkCtf28fb6JiOd1KBWiixTya8AJ7NzZnsp/kegNVjQVphq82+PPhFr5bNGTy4C2D3hCEuBY8eTLsyMa0zKK9CDWytBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmvkKjNzWmlYL9hmD7xXtPKG9RBEhuwvo/Rh5fmAdAk=;
 b=JAJjgkHz4CxVQMbwQgk+zO1E83LZ12EBjMSCIAeA376DIFSeIpHdHdOnbFuB9hOHAd0hnlPxmnXncOH/Qc8S0asdUlTVlV5BYGrn8zHIAugdqGdxQjOebF9cFxXKxC09y8h3jLQNyY1Ulq56RMrit+RKfvzt8lIxI6GCUMhjDuxVxp63QSFmVNFDv4J2ZpiIhUYApDwRw9xeKwVy0xccwnPQBA5gI0QQJdPns3liMZ7/rupt8qWmqoEkiVYnbgYv+55mSMFDIxGVjOItBdsSZDJk0NTM/rUGN5MifPyivQnDJfT/PaAcfINFmIdxiV4EuEg1gx4RrlPAOKJn8tjeFw==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by PR3PR09MB4329.eurprd09.prod.outlook.com (2603:10a6:102:3c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 17:37:46 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%6]) with mapi id 15.20.8445.017; Fri, 14 Feb 2025
 17:37:45 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "cfu@mips.com" <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Aleksandar Rakic
 <aleksandar.rakic@htecgroup.com>, Faraz Shahbazker <fshahbazker@wavecomp.com>
Subject: [PATCH v4 2/3] Skip NaN mode check for soft-float
Thread-Topic: [PATCH v4 2/3] Skip NaN mode check for soft-float
Thread-Index: AQHbfwcoW6N2vaAyPUW2IKSqtPMqzA==
Date: Fri, 14 Feb 2025 17:37:45 +0000
Message-ID: <20250214173702.2308488-4-aleksandar.rakic@htecgroup.com>
References: <20250214173702.2308488-1-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250214173702.2308488-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|PR3PR09MB4329:EE_
x-ms-office365-filtering-correlation-id: 54e7782f-ae18-47a5-2424-08dd4d1e4b05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?au2/1HeUzpF8HmOXAUKWACPvAjsLYcEsPUQzqurJM0rxgYFwTS5XKZMecn?=
 =?iso-8859-1?Q?TvmG+iG7oT3m167BK4mZUqURcX0rMG8zTJHFl9u0Rjq3rWjfLeeOuuiPGG?=
 =?iso-8859-1?Q?P8/Yt6eTqUu4OBKpLtQNB4vkv6gXVHBqmrQcugLxbg7N1SICpyt7kTzZQy?=
 =?iso-8859-1?Q?GhpzAIU5DbusC0vGIRAF+ye7rg8mHXdHsbkHUEL/aQaKO82fdmBFcAS5M6?=
 =?iso-8859-1?Q?ypExWuyRpmtnf3M4CXh1b8XN6XYS9rh/xEbPWJ15S0Atrc9qxYa+EZf7Z5?=
 =?iso-8859-1?Q?mJ5i2RrJMe/ktkU+gHkqgpMHTYkjwtbpUqyZ4cFEkYIlNCM7mgskO/bwBP?=
 =?iso-8859-1?Q?1dYoVj34VyRO+zyIgZdt2ZB3WucCadedM0fp0OFEoIBUpdpHSrcb575Fpn?=
 =?iso-8859-1?Q?4Ud0B7vPEMguFbIHFg9hRCDuiqZlq5kGWzlvPhYF/li1Tp59JSfoN1s2z2?=
 =?iso-8859-1?Q?d8CxNFs98S3xq4AEQwG4bC4KTe/4VeBr4NYxlA0qATe8eKcD7HZ2Uqrh8x?=
 =?iso-8859-1?Q?0EBjCJv20yvwBFDo9rL0XnDYSu6v0zbqKEhPpCrdlxfCZGrcLfcB2bh/Wb?=
 =?iso-8859-1?Q?dsLR7OoQxvcajRhTleg1GmKQOyTRsNmlAG4cN6TyhWeP+03tAXf9YtxUNk?=
 =?iso-8859-1?Q?Wwg96nJV1mDK76IvNYUdQZfH4GePhZIo8uHZDKx3KNIngMGlmRkDc/FIxA?=
 =?iso-8859-1?Q?+ZHZT8K5d8Jw9VFZADIJ/OY+Zmnz+dw7Ahd+kvGtZiAOKLJmNOmslVdT/t?=
 =?iso-8859-1?Q?agvjAvZtxdQ7C89JiCXAs0Y5gOEBHAyh1ak5R+1OfIFvfbsHL+BV/9gvW6?=
 =?iso-8859-1?Q?UtQeve+UEOtt05TstrruUq5kR8lRubnMg40UmdDjXKjMbGVWYj9gKiHUyE?=
 =?iso-8859-1?Q?5VJU/UH+6o2by1BcxNW2Fs1lh0S+Y1D6vNbCDQ9spE6XnfKQcQO6XmZvXA?=
 =?iso-8859-1?Q?qFLIkYaEGB93sPK/5NydFoChMKVEmkO+jLSfnkKfjRkxp7+NxsapZLm3D4?=
 =?iso-8859-1?Q?MJXG1S+j6z6sn+scQ+3qVL0qoNLXzKXIJNNmcGKdlFhAiQgsJBmg2Hz/Ji?=
 =?iso-8859-1?Q?FNna1vIuVjUxrHiuV6W+YjQc2R0eyFo5sFu5FHdpUNI6546HpYXzMWcW5y?=
 =?iso-8859-1?Q?S3b/HxsVyrngR0FkFU3iQIzXsu5Hdd/+jFXqpA1QyBKMdkU4ufgIHkX0i1?=
 =?iso-8859-1?Q?j5C1AXtb3KXyfQtUJzG2gqh0tougmEqWj/B3/NH5/GQ5XO0TM0httYMVK8?=
 =?iso-8859-1?Q?7PwaIq0fqdPMvpjbh9a9dHL7rCrIcvzjmkhtnqmo2WwkP1fKDhJ3NZPoC2?=
 =?iso-8859-1?Q?BG9ZKEv1zS9DmAe/H0yndYQuiO8c7isxMEZax8Dpi70UPEOFdBA3ukgWcg?=
 =?iso-8859-1?Q?WMUz9eHrdm9XPiuFRTbXFpMbzJLcihLglK4GFOwSR7Szt0jvOmPCbu93tC?=
 =?iso-8859-1?Q?thIgQUNIb56F0qF1nf7d4A9EarA5wAQv8QkCtn41ZcF+/MqbfWZkF0Va6z?=
 =?iso-8859-1?Q?UjQrMZ+eG8eJM0pxaXZkIe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UuPWE3hNGMnvOlOdwoqt0GbJDY2jDGwZdDXz07uivuZH/x54r4ABHHhBTO?=
 =?iso-8859-1?Q?GFNA5PcxbZHaOjEksCNfq1k0wYxtQ1u/fieevD8CueO/Qjl1S1i7rgf8Lv?=
 =?iso-8859-1?Q?55iUO9yj/AqezJTWWvPBtPy0hb+nE30vn3g9FYlMOTKDiKP9yXCJv3fsbg?=
 =?iso-8859-1?Q?S4BX7UBrzRA6kF9U4L8tTigcwTcQ7+cbf+LeTY+gQACX/7tZSvEnOiU6sB?=
 =?iso-8859-1?Q?RSa6HBLtoakVtP+RddwFXiLwZyZTqla6uIsZqyeuHYr/hcLG6Y0w8/X85M?=
 =?iso-8859-1?Q?b7vicPqV3gTpyDdsG9zbxpi2kwIJkgaxNj+WkLpHraYsgmJezI3C8Kamb+?=
 =?iso-8859-1?Q?8sGhKq0cJ2mPfoCsEQiwrtv8duI6HFGedkZpGPoBL6skVhl99IIsBnGuoK?=
 =?iso-8859-1?Q?giAyVWsgIP1oYE8q2htovAjgWzK9MOW9EabrgpdclFhiTlwnagTmWUjvAS?=
 =?iso-8859-1?Q?Tfw6mqqS1raBtfaz8/+TNND/WxuPbklFVGY0Gp6/o0erkuXILj97BoSUPY?=
 =?iso-8859-1?Q?eTyc2/X9nwSdh8aDavt2tUAXJ5slUQnOMvrR58h/0qpBBPqLZaQ4ffFmMp?=
 =?iso-8859-1?Q?2s5d7lz6LW1vg1VeOhwJGQdEr+Atb97hz1hsMnOgw2HK761rULzx7R1j3d?=
 =?iso-8859-1?Q?6cvzynPlcn7ex23+lbEl/seZQdox1UrUa7a+s3QukRATyNa3qWF/AVLDih?=
 =?iso-8859-1?Q?B+eALXhzhY8uysIq8SqkSIr4eDygLUdrXhCGfvO3tzHQf8ZZQr9bKepHTl?=
 =?iso-8859-1?Q?WVRmSb0UPtK75dZMxyLaGwaKaYpmqJLtbTL2ym7P27RDPV9TFaHF7VJpu+?=
 =?iso-8859-1?Q?+3oxotH0tJEGYrO1WD765UG6hOhA5gvIokhwlibhfPioL3btbN9jnCgiTD?=
 =?iso-8859-1?Q?sMh7UJrL1bAU3hB3GjRYXpuJWTkBCFGXnN9lmHsEGPLoJPA+nDbWAbAl7K?=
 =?iso-8859-1?Q?Z6j5jDyymJLPyYBFf3hBVRuDP18hFrRNb2svY1J26MJDv6IMM0dtSs+GbR?=
 =?iso-8859-1?Q?ueHQWCvgvWlQhvBJTRbbwxB5iMJ09hBBJAgrxxH4eE/Nc/B6NVy1qHJ5K2?=
 =?iso-8859-1?Q?B075HcjOlVX/f6CNhq5qqC7UliOqO3iLw787sBK9X7v5SBqapDj/cWEDKn?=
 =?iso-8859-1?Q?hCm+RusirhZSSvDARHrU07GxsYqQdIJorpoyNzV9ln1mzuhYxdoYaY3gqG?=
 =?iso-8859-1?Q?C9oCc1PpzK3mkUxLyt8A+w0RfoMczIJcLE0tYxnrWbGBveU/zomjgcjUen?=
 =?iso-8859-1?Q?bPtRP7pej41vAHFIOfMfHYGJ9wfmrs0RZ6SjBryEg2k+AbLu9J4KT8aTA4?=
 =?iso-8859-1?Q?1VI2WzVWIJFq7D3MrzJ9Uobxy2dotYZBoZVmUj1jg3NpcOfvjb4gQdW5Cl?=
 =?iso-8859-1?Q?gial4+YDN6Yt0DWggUeruWXqflVeLqsuYz6ycwIWoYVt1sE7d77MMnytsf?=
 =?iso-8859-1?Q?FQAzSMarmAP9R7/TlCL82rkaxtbkT/E0nXd14vgvRKq1cE1VblV5wWh10N?=
 =?iso-8859-1?Q?H2X5R7nUGCLYnt9blPjQtTJ6tDf8XH3eJIat8cuXusz2uDiED6te3YCP8v?=
 =?iso-8859-1?Q?+uFeO/RJmJMojlN8A9FcghN6IYdzDBr7W7xCr+vHuX/6b5iQ2cVMeTUffs?=
 =?iso-8859-1?Q?rJOSIsF2tA5cBjFVfSMDt12ORUQjUbHFnNv8X0Qx2Mzvb3rp2ONyKq7/mp?=
 =?iso-8859-1?Q?6ENDCuddKC+v4MWtBpA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e7782f-ae18-47a5-2424-08dd4d1e4b05
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 17:37:45.8902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2q1dWscIRkzZ4lv4ni7lod9p0EgWVgLLlAERZdyFZg9rGOs+HHbVgYAfnu3qrx5o6hdIAowsiWnxlTiVCYghhB+MsB+DtoMQGNdjWwunM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR09MB4329
Received-SPF: pass client-ip=2a01:111:f403:260e::72b;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
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

From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>

Skip NaN mode check for soft-float since NaN mode is irrelevant if an ELF
binary's FPU mode is soft-float, i.e. it doesn't utilize a FPU.

Cherry-picked 63492a56485f6b755fccf7ad623f7a189bfc79b6
from https://github.com/MIPS/gnutools-qemu

Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
---
 linux-user/mips/cpu_loop.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 462387a073..07c1ebe287 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -304,8 +304,10 @@ void target_cpu_copy_regs(CPUArchState *env, struct ta=
rget_pt_regs *regs)
     if (env->insn_flags & ISA_NANOMIPS32) {
         return;
     }
-    if (((info->elf_flags & EF_MIPS_NAN2008) !=3D 0) !=3D
-        ((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) !=3D 0)) {
+    if (info->fp_abi !=3D MIPS_ABI_FP_SOFT
+        && ((info->elf_flags & EF_MIPS_NAN2008) !=3D 0) !=3D
+           ((env->active_fpu.fcr31 & (1 << FCR31_NAN2008)) !=3D 0))
+      {
         if ((env->active_fpu.fcr31_rw_bitmask &
               (1 << FCR31_NAN2008)) =3D=3D 0) {
             fprintf(stderr, "ELF binary's NaN mode not supported by CPU\n"=
);
--=20
2.34.1

