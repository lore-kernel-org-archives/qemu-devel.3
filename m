Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9594FCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXDGS-0007Me-NQ; Wed, 10 Jun 2026 03:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXDGR-0007M9-4p
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:22:15 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXDGP-0005WN-Dc
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 03:22:14 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-45fe59255beso3336218f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 00:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781076132; x=1781680932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=swR1kws8Bc8COdij5Ri9BNZI+cTU82Y2Q84RV7DbauI=;
 b=whv2VvsILIG/PCBaC4o3CUIlKg4Won/GCNh1jCQLtsLPr+5q8Opm5cHMUvSgW68OLH
 J9Bt2YHPOVi5BlUjDxcvHoPUEfzZJ9FoK8vhl58YPD8sIHQS+73KviYB1RyucAkctZJn
 W16ytXSh2pfc46zExvu4GaCslVt3jvKOjYFGFaUSt/uM48Cy6+ID+6psSW8po3350+i3
 L4sueDrbDnYHkjPQ5lN95+zGGEteCo6pZXVhzp/dMrl16ReGRE/pbDYqaViNTe3tUY4A
 VXBP74QtdVKVl7r8I93eDFHA29MMf1GfvJECKG8Ult3+FqCPQ+rPCrbG+QoLB/TkigZ8
 at+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781076132; x=1781680932;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=swR1kws8Bc8COdij5Ri9BNZI+cTU82Y2Q84RV7DbauI=;
 b=q7xPI+xmxkuyx7hfvMHYSS9HmP324URKsnM3K5wgxl3MRDjiRq/ZPXoJtMBao+6PVW
 vbpNYIK+64gEfdA3LIQAjgwNrdaXULTennYhIbYvk1v1+opmRXdHcUgkfJu87jF5fOEK
 lHXzEeNmW0+0LLI3DMEy7JN7+lLaPlHT1zvrd7qDyZWjflIfOHh8N9MtqhnRvhDs7RVa
 LRAYjgbdyk1Fc4ycmFr0VoI3vMKA1mCZCWyEc6NwGWCCn94O7Y7iUKhbS1D8Fx0zK1WH
 6qKWhaLViee15nrgq8utXtSSxNMmApxQfSfZYVThgTPicovRZR4/MXznJyenCzx7LHF1
 NCsA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9K+bkTyRNrgZnT+wGPK8jbPVIYwE0Lf3t2Sq5xqdMQdwqAu+tzP3A7hhcNRsB6AUBcHUe/tAdid922@nongnu.org
X-Gm-Message-State: AOJu0YwryZvGekmox/NyHFM4V6HtmPBo9jNdRNIHB3XBEO3y1UpIDpV1
 lSuwFrNbwKLzhId8j9XREh6fhZlHCDbAtDTRRMzyzYU1RYXar1t/OqSobRBCi4Xkn08=
X-Gm-Gg: Acq92OH831zhgGumM/vR+muRmp1OPmaL2BBjaMlJvv9uQb6yT6CUSGa0ZDj9M9s412K
 N1iqGHSQrPlSWI7dkIacOyyar52qFqpEFKyOFB+ZaoUBuUrrfyf/KEAswK9A24BLMnPEfe+KwYH
 qDKl+nz5BJm4i/tYJaoCBWZ8iULUmjl9pK7vNU8I5AOTaa/9LGLJjcnqHnUjUwuuMukin0fNzQN
 HKwdIk6GHLzRKrwdVsLW0kVG6CcVXT+9SKruHqE/7Kip7b66lYMNmvSu88jG1yPn2Kc77yCXDW7
 dmSwvjqlnwj7qsYAkqHwWKkws93MgU+tLdfsURClNfUPe7ljAjfAMMVDHX8I5Ss4DksuL0iDgMZ
 bExAqogKJYP+WMOdRx71dz08Qopb+D2qrxxopkM4xZqWgyMxkW2Cltbz3gQDz8rbqJx/RRkIAUK
 F529zyURrvscdqIbvv3fPj7BPWldwvj4nUwQqIucMR0eBz9qGZ2VKoyZMzSHDDKAu693kdpM+EY
 +3IMoXqmPwHDfGydxn2CJHXTsj7ycJ+cUgQV7Nx/9P+2Jx0RpdXiLkUXgBf3YL3
X-Received: by 2002:a05:6000:41d5:b0:460:3210:b6eb with SMTP id
 ffacd0b85a97d-4603210b7b5mr37747111f8f.43.1781076131622; 
 Wed, 10 Jun 2026 00:22:11 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-144-251.home.otenet.gr. [2.86.144.251])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcde3sm70975460f8f.1.2026.06.10.00.22.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 00:22:10 -0700 (PDT)
Date: Wed, 10 Jun 2026 10:20:58 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 12/27] tests/tcg/meson.build: test gdb support and
 introduce gdb_arch
User-Agent: meli/0.8.13
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-13-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260609214745.772536-13-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tgen4x.2pfd5war96v8x@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, 10 Jun 2026 00:47, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>A given target can now declare which gdb architecture it requires.
>Also, we add the code to check gdb capabilities, and version.
>Tests can use gdb_version.version_compare('>=X.Y') to test this.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> tests/tcg/meson.build | 22 +++++++++++++++++++++-
> 1 file changed, 21 insertions(+), 1 deletion(-)
>
>diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
>index a47f1ada779..1496cba460c 100644
>--- a/tests/tcg/meson.build
>+++ b/tests/tcg/meson.build
>@@ -1,5 +1,11 @@
> env = find_program('env')
> 
>+gdb_progs = ['gdb-multiarch', 'gdb']
>+if config_host.has_key('GDB')
>+  gdb_progs = [config_host['GDB'], gdb_progs]
>+endif
>+gdb = find_program(gdb_progs, required: false)
>+
> tcg_tests = {}
> # tcg_tests is a dictionary with following structure:
> #
>@@ -7,6 +13,7 @@ tcg_tests = {}
> #   'name_of_target': {
> #     'cc': cross_compiler,
> #     'folder': 'folder_for_test_src_files',
>+#     'gdb_arch': 'gdb architecture requirement',
> #     'qemu': emulators['qemu-...'],
> #     'tests': [
> #       {
>@@ -33,6 +40,18 @@ tcg_tests = {}
> # is guaranteed to be unique also. They can be duplicated by setting 'test_name'.
> # Default name is derived from src if 'exe_name' and 'test_name' are omitted.
> 
>+gdb_arch_supported = {}
>+gdb_version = '0'
>+if gdb.found()
>+  gdb_version = gdb.version()
>+  gdb_arch = run_command(python, files('../../scripts/probe-gdb-support.py'),
>+                           gdb,
>+                           check: true)
>+  foreach arch: gdb_arch.stdout().split()
>+    gdb_arch_supported += {arch: true}
>+  endforeach
>+endif
>+
> # plugins come first, as we need to build the list
> test_plugins = {}
> subdir('plugins')
>@@ -46,13 +65,14 @@ foreach target, plan: tcg_tests
> 
>   # return a clear error if user mispell a target entry
>   foreach key, _ : plan
>-    if key not in ['cc', 'folder', 'qemu', 'tests']
>+    if key not in ['cc', 'folder', 'gdb_arch', 'qemu', 'tests']
>       error('unknown tcg test plan entry \'' + key + '\' for target ' + target)
>     endif
>   endforeach
> 
>   cc = plan['cc']
>   folder = plan['folder']
>+  gdb_arch = plan['gdb_arch']
>   qemu = plan['qemu']
>   tests = plan['tests']
> 
>-- 
>2.43.0
>

