Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C0CCD4846
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMcXZ-0003E1-TP; Mon, 11 May 2026 22:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMcXY-0003D7-IY
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:08:08 -0400
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMcXW-0004qr-Sj
 for qemu-devel@nongnu.org; Mon, 11 May 2026 22:08:08 -0400
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-8b7f937ef44so28406246d6.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 19:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778551686; x=1779156486; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vpuabHOf+U9MEgyNUnfpjMEoIyiMndXe69sZcdp5B8Y=;
 b=FqxK/A7JsegkGndudb1Z0TW8ReA7xsxL5r39hpoFBqyqJYbBGYPCB9LgIwmLIL4PF1
 EXW2KQiioIoBQHwBTXOpjsjYKGCJ9Yk1KQgDsp6Vg/Mv09bOw7CuUsZRpeG2WM/hdxtm
 wOFZsBe+vTil2BE8/E2HWUsFsdx87r4+GrofmEMaORKLfkKeqbP+APxY2qrbG+frKGot
 ITZMkAGrdNMKMzisrr6MUlcXuRiqkiCpFAkRX6WwcxxWaPeoUljmYPvcTr95b/IA0GQG
 pWH7aUyGtfq9LVB3f22fQM6ShLBp+Cs1Y3EKYwoPI8P0oPnT7XqihLbyMiC2J7amsCkD
 Frgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778551686; x=1779156486;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vpuabHOf+U9MEgyNUnfpjMEoIyiMndXe69sZcdp5B8Y=;
 b=dT6xyp7LNolQyPFgbTsMXlVgpiKVJRNIe7AiLzbQ+OwxgFk6fEDeBEOLdOeNiLlwsY
 zcdxKPFh0+6tHuWxoFQZ5REQdhCWL/admSa25CTVN4abntS33ctCO9wLiUi86yRgOZh+
 If0uO0Wsjmwa90kyzV1CntI6R5PFumWRAZVmVIe4Uib2CKKFz1hxeK0t9koRrqujBEf/
 t1JlhENK6JaMfV/EoVL9wq/bAMlePEGKpIi3RVDVlgmSo31ZedkLf0djcX7VTCAgCmZM
 MvF/rbWntshn7lDmMQk4NEgpj8KC7wwL5M6/b1Fab6hSo1BEejl9u6UnJ1fYtKPvXqoD
 /RZw==
X-Gm-Message-State: AOJu0YxydZjF9BaZTn4fvqBd7NHw6OPtyhABfRsouf4a74TeLvErv6RO
 p690GKm5mMeghqR4fcdJpfT0+eec1+bFIPnreNlPgt8cHQaonxPJtV7i
X-Gm-Gg: Acq92OGtMoWmARn7L+5bcadnN7tpaxFQ2x4un6i7DphqIKyx7Nl5DmgrbE6jbA92En2
 XzXw/K3YNaLw2FpOdEJZ+lwckDcuyiMdZ4Vx4kcHRsyaymXzZVzSsdlzlRVtOiApxm62vkpoMWG
 CLHxiS5JLg3Ngrh4RSfsGb8TcXLmVX8aoplqWaHkkhZaqXkUca/dM7Jv8rYmaqVKTQ+e2cMLBNS
 8m1Ocr9aLtZUMwX2GU0uJUXDZ5+/a3Rm1YybTdCCdkQy19OgL15e4OgOq80aKo3LkkOIe7+i0RC
 /j5Kvb6bhoOMT9neCOaq+K0RH9hwZy/MRlwWqTbnSjX8SPYff8za40MlB6oE9RgYHErWuJSUINg
 abUS6qkijSFIuNy8KV/Y270VY9odbZLfiguDfTViZPquaQH8nMz03dqQvGnh4i16Duonq3i4Lgc
 jKu53WNZ0okFMTDDEbldZk5wr9zELDG3zr463WFB/34j38QGNg8xaQHoe8e7RC+UNP4eu53GPv
X-Received: by 2002:ad4:5ded:0:b0:8bd:75c2:5528 with SMTP id
 6a1803df08f44-8bd75c255c0mr349531146d6.12.1778551685406; 
 Mon, 11 May 2026 19:08:05 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c2ec034252sm71420236d6.39.2026.05.11.19.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 19:08:05 -0700 (PDT)
Date: Tue, 12 May 2026 10:07:51 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH 00/13] target/riscv: remove riscv_cpu_* arrays
Message-ID: <agKIuzJdhI6P4dmt@ZEVORN-PC.localdomain>
References: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511132910.1738069-1-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qv1-xf41.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Daniel,
On Mon, May 11, 2026 at 10:28:57AM -0300, Daniel Henrique Barboza wrote:
> Hi everyone,
> 
> We have been dealing with two sources of extensions information in
> target/riscv/cpu.c:
> 
> - isa_edata_arr[]: an array that we must keep in riscv,isa ordering that
>   also has priv_spec info;
> - riscv_cpu_* arrays: used to set user properties and set defaults for
>   rv32/rv64, among other users across the code.
> 
> The main issue here is the info being duplicated across arrays.  When
> adding new extensions we go through a ritual of adding basically the
> same stuff in both isa_edata_arr[] and riscv_cpu_extensions[].  We can
> eventually forget to do all steps of that dance, resulting in patch 1.
> 
> The second issue is a desire for less abstractions.  An extension is
> something that we report in riscv,isa, that might be exposed to users or
> not, that might be a vendor or an experimental ext.  All these
> distinctions don't require multiple distinct arrays.
> 
> I also made an effort to start moving away from the 'named features'
> stuff we have going on.  A 'named feature' is just an extension that
> most of the time isn't exposed to users, most of the time represents
> innate TCG behavior, and sometimes have a different enable mechanism
> aside from setting a flag to 'true'.  None of that is exclusive to this
> class of extensions therefore I believe we should move away from it
> over time.
> 
> There are more design simplifications I want to do in cpu.c and with CPUs
> in general, but for now we can enjoy less lines to maintain.
> 
> Patches based on alistair/riscv-to-apply.next.
> 
I’m seeing some compile errors after applying these patches on top of commit
0844c21f24ca (target/riscv: Update MISA.X for non-standard extensions) from
alistair/riscv-to-apply.next.

---
../target/riscv/tcg/tcg-cpu.c: In function ‘riscv_cpu_update_misa_x’:
../target/riscv/tcg/tcg-cpu.c:1158:11: error: unknown type name ‘RISCVCPUMultiExtConfig’; did you mean ‘RISCVCPUConfig’?
 1158 |     const RISCVCPUMultiExtConfig *arr = riscv_cpu_vendor_exts;
      |           ^~~~~~~~~~~~~~~~~~~~~~
      |           RISCVCPUConfig
../target/riscv/tcg/tcg-cpu.c:1158:41: error: ‘riscv_cpu_vendor_exts’ undeclared (first use in this function)
 1158 |     const RISCVCPUMultiExtConfig *arr = riscv_cpu_vendor_exts;
      |                                         ^~~~~~~~~~~~~~~~~~~~~
../target/riscv/tcg/tcg-cpu.c:1158:41: note: each undeclared identifier is reported only once for each function it appears in
../target/riscv/tcg/tcg-cpu.c:1160:27: error: request for member ‘name’ in something not a structure or union
 1160 |     for (int i = 0; arr[i].name != NULL; i++) {
      |                           ^
../target/riscv/tcg/tcg-cpu.c:1161:43: error: request for member ‘offset’ in something not a structure or union
 1161 |         if (isa_ext_is_enabled(cpu, arr[i].offset)) {
      |                                           ^
[1658/2250] Compiling C object libqemu-riscv64-softmmu.a.p/target_riscv_vector_helper.c.o
ninja: build stopped: subcommand failed.
---

Maybe try rebasing again and fixing it.

Thanks,
Chao
> Daniel Henrique Barboza (13):
>   target/riscv/cpu.c: add xlrbr isa_edata_arr[] entry
>   target/riscv/cpu.c: fix smctr/ssctr isa_edata_arr[] order
>   target/riscv: make riscv-qmp-cmds use isa_data_arr[]
>   target/riscv/tcg: treat all exts equally in
>     cpu_disable_priv_spec_isa_exts
>   target/riscv/tcg: use only isa_edata_arr[] in cpu_cfg_ext_get_name()
>   target/riscv/cpu.c: remove riscv_cpu_enable_named_feat()
>   target/riscv: remove riscv_cpu_named_features[]
>   target/riscv/kvm: use isa_edata_arr[] for unavailable props
>   target/riscv/tcg: use isa_edata_arr[] to enable max exts
>   target/riscv/tcg: use cfg_offset as cpu_set_multi_ext cb opaque
>   target/riscv: do not set defaults in cpu prop callback
>   target/riscv/tcg: use isa_edata_arr[] to create user props
>   target/riscv/cpu: remove riscv_cpu_* arrays
> 
>  target/riscv/cpu.c            | 315 ++++++++++++----------------------
>  target/riscv/cpu.h            |  12 +-
>  target/riscv/kvm/kvm-cpu.c    |  25 ++-
>  target/riscv/riscv-qmp-cmds.c |  30 +---
>  target/riscv/tcg/tcg-cpu.c    | 137 ++++-----------
>  5 files changed, 153 insertions(+), 366 deletions(-)
> 
> -- 
> 2.43.0
> 

