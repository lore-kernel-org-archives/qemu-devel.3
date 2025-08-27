Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7986FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 08:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urBUY-00056o-O5; Wed, 27 Aug 2025 04:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1urBUX-00055u-8j
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:26:49 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1urBUU-00070A-DW
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 04:26:49 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8856E3F690
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 08:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756283200;
 bh=TrWZxGNDWW9O1+udTyTUhrNsfg/6XhManRb2ylcytXE=;
 h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
 b=B+CJVUMDGFzvYuqnWCu394JKUaEp7KeBEzsksyx08XvmeqhPkfHvTkq8NygC2ViOl
 DKfQe5nDO3WCsTZ3WxMVg25S2pUJUfAWdC+QzXTdsNK/mU9LBPzUmLcqq1BzvF4t37
 E+CJCqOntQT8je237WmxWqc4WqtIvBgKPEnP+Nf8bUXBCJOE0V8SW/4wT1ZKfa7NQf
 YuTV6j9WmMnl9Aq5CYVfxK7uEEjt+bnJb/8UQSZw2pu3WBQUxGCoSP/2He72ttDVNF
 OP2bCJzJJqNcvYUTVSO/gPgy43kw/2h7ZtzJAvtii6PtQtIzfCEUCb7xTwRF+2GuYm
 /gBY8dZQjV+NA==
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-61c9847e805so1477347a12.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 01:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756283199; x=1756887999;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TrWZxGNDWW9O1+udTyTUhrNsfg/6XhManRb2ylcytXE=;
 b=cU9wnNm1YHzNWuDykGFBZG4ilTSagyP6WKgDJmObl5y4/8k9YQNPLRXjWT6NLH4EcV
 znQWCocR0MCfFdYMJt+vOHlELclseQ5RYlARVBsTb7yKvc72l6IK6Dyv6eN7LV1FWSTC
 wG52WSpW7eXscWthJySVMxf6+v1DQPRy1Y45GLxBu13W5hUDJows9MNGhnsVXBxTNGQC
 ZR3jJZqUYWehHngWAJR2acpGuPQwHcFItyKJEaM9wYEMb4xpAmCwaCeN2udkcLgLoikc
 lpOWq8Tt+kSfjQfhRFMptaqh5yarrBsRC+iZaaQbLK/LET3lsCzaZxd8/plWg3MyYIOd
 WbLw==
X-Gm-Message-State: AOJu0YzaSjc/4csbwE+OZKWtlmbOznDiEQCwIfD3RKTdPShIqlPPKWNJ
 6suqcMw9MzT7Iz4Ynx2+mYA6qKSJfuUTHf0MDNe1RJr+PdcmdbIfaovFqFDxMKOOMnRBvKmNSU+
 ctbrHTgIed2w8cwiyhl3JayBCyMMjV7MxvLSU+sOj8/khk1M/WqlWh1xagC5d8MMI0giFGs7TP/
 T4snMwqAISrr/+vK/SkqLAkHTxObSGPH7e751RyG+lVRrmnfM7czf4MN9Biw==
X-Gm-Gg: ASbGnctR3AXEethY3MJ4HA7Gj6UlGAOTJ/DFjG+dz2olQAkKh6nhizkkyAJra3X9NwY
 giBy+CnBj5UgoUTlTP8OGZkiaJslgaMPQO/6tqGjC0zMWJGTu0EL5Ky2wFk7qeMMHPvachgbOio
 l5keMMK+hEadXL2xpQ3gI=
X-Received: by 2002:a05:6402:21c8:b0:61b:fd1c:a2d6 with SMTP id
 4fb4d7f45d1cf-61c1b49e8f3mr16006166a12.15.1756283199586; 
 Wed, 27 Aug 2025 01:26:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4bmvJH5+4Mc/6opF2+d/9xTBihZ9blTPQMmZX5AwTzAMqrjkKpv6G7qGAhpu0WU0QxIYTmagpjD0a+IycXNw=
X-Received: by 2002:a05:6402:21c8:b0:61b:fd1c:a2d6 with SMTP id
 4fb4d7f45d1cf-61c1b49e8f3mr16006143a12.15.1756283199091; Wed, 27 Aug 2025
 01:26:39 -0700 (PDT)
MIME-Version: 1.0
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Wed, 27 Aug 2025 10:26:12 +0200
X-Gm-Features: Ac12FXxArA1NHBWQqhUSGpW3b2k3EtHqvw2E8ynHS4Y5J4B0NUq5i2IvPqoAYk8
Message-ID: <CAATJJ0++oPyjgXsekOKpHosps4jTpe9p9TWGGDpb2igbf6iipw@mail.gmail.com>
Subject: Weird conflict with gcc-15
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=christian.ehrhardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi,
in testing qemu 10.1 since rc levels I've found yet another odd
behavior. As far as I can tell it's not your fault, but I wanted to
tell you for awareness and potentially to help me get the right debug
data.

A test that triggered when checking Ubuntu was the one of EDK2,
emulating riscv when running on ppc64, example log [1]. Yep, yet again
not the most common setup :-) and the same emulation in all other
Ubuntu architectures as host works fine.
Gladly this was reproducible and it eventually led me to a wild
journey which now makes me consider gcc-15 (15.2.0-1ubuntu1) as the
suspect here.

After confirming that I spotted that it only happens if qemu is
compiled with a particular optimization option.

The issue itself is as weird as jumping into an if, despite the
condition not being met :-/

Thread 3 "qemu-system-ris" hit Breakpoint 1,
riscv_pmu_icount_update_priv (env=0x10147c310, newpriv=1,
new_virt=false) at ../target/riscv/pmu.c:200
200 if (icount_enabled()) {
(gdb) n
203 current_icount = cpu_get_host_ticks();
(gdb) n
206 if (env->virt_enabled) {
(gdb) n
211 counter_arr = env->pmu_fixed_ctrs[1].counter;
(gdb) n
212 snapshot_prev = env->pmu_fixed_ctrs[1].counter_prev;
(gdb) n
215 if (new_virt) {
(gdb) n
216 g_assert(newpriv <= PRV_S);
(gdb) p new_virt
$1 = false

Since I know the arch, the function and the tunable - I can use a
rather surgical mitigation like this.

diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index a68809eef3..5317d8be57 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -189,6 +189,13 @@ static int riscv_pmu_incr_ctr_rv64(RISCVCPU *cpu,
uint32_t ctr_idx)
  * env->priv and env->virt_enabled contain old priv and old virt and
  * new priv and new virt values are passed in as arguments.
  */
+#if defined(__powerpc64__) || defined(__ppc64__)
+ #define NO_GCSE_ATTR __attribute__((optimize("no-gcse")))
+#else
+ #define NO_GCSE_ATTR
+#endif
+
+NO_GCSE_ATTR
 static void riscv_pmu_icount_update_priv(CPURISCVState *env,
                                          target_ulong newpriv, bool new_virt)
 {

But a mitigation is all that it is, ideally, I'd report this as a gcc bug.
Yet the - understandable - hard requirement of getting the
pre-processed files makes this quite complex. As I can't even exactly
point to where exactly things go wrong.
I'd ask if one of you has experience in providing gcc-bugs out of a
qemu build. Is it as obvious as throwing -save-temps into *flags or is
there more to consider get what would be needed?

P.S. If you are curious and want debug binaries and the journey to
find this, it is all at the related Ubuntu bug [2]

[1]: https://autopkgtest.ubuntu.com/results/autopkgtest-questing/questing/ppc64el/e/edk2/20250818_045238_153f0@/log.gz
[2]: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2120835

-- 
Christian Ehrhardt
Director of Engineering, Ubuntu Server
Canonical Ltd

