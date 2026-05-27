Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317DECD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 03:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS59n-00020K-G4; Tue, 26 May 2026 23:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wS59j-0001ze-Ig; Tue, 26 May 2026 23:42:08 -0400
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wS59h-0007s9-NM; Tue, 26 May 2026 23:42:07 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id B3DC2EC0201;
 Tue, 26 May 2026 23:42:02 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
 by phl-compute-04.internal (MEProxy); Tue, 26 May 2026 23:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1779853322; x=1779939722; bh=OL9Vca83QaIB8hRW9MwwQZDpYYZmMIcm
 OArdfstDfk0=; b=Q6VbkquDvy3cUriIGrCeeFVY8Wt6ZCFQX4vKc2xXv5JVSCCB
 rfSGn6pR+nSiZWxBxVyWjtZEr/mS2UFIZDfozcb4yZrk91utSYBamGNudIWoC7f3
 GkJFdZYGjN6rRFoASgT0huwxnAyDSSgXkpcxXaz1/ZsRPRQsrcWrnYlLv43gqOrG
 i/EbZ8c8ycfx8VE4uaOiMSTto2NSl/Rpo/olEwuuPcFsDwkUt+uxw7ROwE5KPijm
 n/5J8mdbm0BPxuXLk63rQbF8fuZ9l6mkbe9AmegW0mn4EIjS61+UkTXCCKiY//0B
 Ct2y/wquTW4KIUdT/Tsl0R6EuguhV1rEDZMqQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779853322; x=
 1779939722; bh=OL9Vca83QaIB8hRW9MwwQZDpYYZmMIcmOArdfstDfk0=; b=S
 UVqwQ3XCT4upjRVyvRDJVtApGzKcCh9BIhj8DzZP24wjN7S2qalYNg8dvXJyi9sp
 mFwu3bDQbgEG+nfhPtk4pI1bhc2MTF1DqJvwW/l3OXaaQNvHlA8WKVKaAmeV+nvC
 EnriP0I1xfoV34qLPnyFRzAkh5jXK8ckpFC5eow7Fl+qZ6p1hFztWW/1urU2V6d/
 2dGkIyaXf8kBiKrGEO6I/y4ndBsiNMVkB2xCUAy7QXk88NJoS06IVZAfrhznu7e5
 1pr7Q8dmSbuJVsbny+QPlg/C3XQ8xcqh3kFQtin91st/VpbEipwnXwDhFoQFQ0Ni
 e4C2Z3+VN0bKUHZ2wbSVQ==
X-ME-Sender: <xms:CWgWarEcz2B8R4W6TgS3Y7zBbSn0id4ICw32-X_sBWgQtGEefn1dSw>
 <xme:CWgWajIRsRj-Bsd5F0i9fvmScYbttdxoSc1tlgFLwhLws2ua9GxS2cmhD-uOeTWpI
 bzySYWXWVNLm0qlpywMQre848BTEQwTeaS51m3ffnOS_ZXGRFHQles>
X-ME-Proxy-Cause: dmFkZTF4erQvknL824UsuJhBcGIIZ+wEUUph5m7sMOO7kgtkxmcPavDnM8VJfSeUQzyqwd
 uEAO4xb1e3FFEg6FEsCTnSbPsPOMoy9xg1XFKhNQbd5tOHU8uQzEonmcduk70I7uZgkVHV
 bPF3iRw1IkvqzepBe7/hX7cY2/mLPb8FDtA4mLgjCkCHJIkNFvj9HDQou7bSRZdp5h12R9
 lGYBGyWSVhdWm2hZdW3F+Ez1YOXBSaOjySUYppiYtBwKn69VUxNMSu2THM97XVp5Wn1khe
 fesWTtkrsRrQVtf9OXGBokrsdvxIBeVhxXnfgR/Wn8/Ku6bIgZTedRAv82GR2Lh3uNBxBu
 0Yqm1XzuxZI7TfShy+bVUSznQmsLRU9VwSmg6ZrnNWKRMPKA7o5JoSBe+bbwpG5cJ8OP4i
 WCPVaMJTPQ6hLKebJgID2hzImWcWKAb9tZGy2NwKRBakfk1h7HgQ1cXWudET3VmeND3jtk
 JlcCwn10XahOTOua/G3r3gKfQYAJpR78UKpOreY6soE2SLxSpKMz3ruyJz+cmnjSrPKdqp
 N1mg4msX6Lg+BgT1jzeHTkqwzqWe44hKLV8kmJyBr//0uJFmfuBj5xsS+AjY0O2w4fSOjj
 UXm5Clsv4q0K27mMiw5Y9iNpdXRnRsEYIW04vasrygYp6kpMfPNO8M04b+7A
X-ME-Proxy: <xmx:CWgWavp_CiMGvJpzWtKGurlWb8z8iSS7sgHKiQI8OvGyhyk3-JpQoA>
 <xmx:CWgWah0qXeOW2SGFc8fvS1UfKeFYeOIjn_pUPJ6X7CPxT1tRcQsrkA>
 <xmx:CWgWany-twTHtXTgoZZ2syFlvleK2vI-XH-HJIz5AT7xdjeobswQ6g>
 <xmx:CWgWatgIKJzyaFHFE3ji76k1X73h9QcAKtkusm4UqIsU_qAlh3s-WQ>
 <xmx:CmgWalnPl8z4L_Vkme11kaTqRemvT9eb3w5yoaWvBWcJ3yphoMpy01-E>
Feedback-ID: ifd214418:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id BB71B240009B; Tue, 26 May 2026 23:42:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AAji7O2cgZlo
Date: Wed, 27 May 2026 13:41:41 +1000
From: Alistair <alistair@alistair23.me>
To: "Portia Stephens" <stephensportia@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, "Alistair Francis" <alistair.francis@wdc.com>,
 "Chao Liu" <chao.liu.zevorn@gmail.com>,
 "Daniel Henrique Barboza" <daniel.barboza@oss.qualcomm.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Weiwei Li" <liwei1518@gmail.com>,
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>,
 "Portia Stephens" <portias@oss.tenstorrent.com>
Message-Id: <02b1f49a-84f8-4762-a21d-13c8087f6c0a@app.fastmail.com>
In-Reply-To: <20260527030327.2289-1-stephensportia@gmail.com>
References: <20260527030327.2289-1-stephensportia@gmail.com>
Subject: Re: [PATCH v2] target/riscv: Add support for a custom CPU arch state
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.146;
 envelope-from=alistair@alistair23.me; helo=fout-a3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Wed, 27 May 2026, at 1:03 PM, stephensportia@gmail.com wrote:
> From: Portia Stephens <portias@oss.tenstorrent.com>
> 
> Custom vendor CSR implementations may require custom state information.
> This adds a custom_arch-state struct to the CPUArchState. It also adds a
> RISCVCPUDef function pointer for handling allocation and initialization
> of the custom_arch_state as well as a reset function pointer for setting
> the custom_arch_state fields to known values on reset.
> 
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> ---
> target/riscv/cpu.c | 15 +++++++++++++++
> target/riscv/cpu.h |  7 +++++++
> 2 files changed, 22 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 862834b480..ca557d27b5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -819,6 +819,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>      if (kvm_enabled()) {
>          kvm_riscv_reset_vcpu(cpu);
>      }
> +
> +    if (mcc->def->custom_arch_state_reset) {
> +        mcc->def->custom_arch_state_reset(env);
> +    }
> #endif
> }
>  
> @@ -1167,6 +1171,9 @@ static void riscv_cpu_init(Object *obj)
>      if (mcc->def->custom_csrs) {
>          riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
>      }
> +    if (mcc->def->custom_arch_state_init) {
> +        mcc->def->custom_arch_state_init(&cpu->env);
> +    }
> #endif
>  
>      accel_cpu_instance_init(CPU(obj));
> @@ -2706,6 +2713,14 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
>              assert(!mcc->def->custom_csrs);
>              mcc->def->custom_csrs = def->custom_csrs;
>          }
> +        if (def->custom_arch_state_init) {
> +            assert(!mcc->def->custom_arch_state_init);
> +            mcc->def->custom_arch_state_init = def->custom_arch_state_init;
> +        }
> +        if (def->custom_arch_state_reset) {
> +            assert(!mcc->def->custom_arch_state_reset);
> +            mcc->def->custom_arch_state_reset = def->custom_arch_state_reset;
> +        }
>      }
>  
>      if (!object_class_is_abstract(c)) {
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 7d79c7a5a7..8132c65012 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -213,6 +213,9 @@ typedef struct PMUFixedCtrState {
>          uint64_t counter_virt_prev[2];
> } PMUFixedCtrState;
>  
> +typedef void (*riscv_csr_custom_init_fn)(CPURISCVState *env);
> +typedef void (*riscv_csr_custom_reset_fn)(CPURISCVState *env);
> +
> struct CPUArchState {
>      target_ulong gpr[32];
>      target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
> @@ -509,6 +512,8 @@ struct CPUArchState {
>      uint64_t rnmip;
>      uint64_t rnmi_irqvec;
>      uint64_t rnmi_excpvec;
> +
> +    const void *custom_arch_state;
> };
>  
> /*
> @@ -561,6 +566,8 @@ typedef struct RISCVCPUDef {
>      RISCVCPUConfig cfg;
>      bool bare;
>      const RISCVCSR *custom_csrs;
> +    riscv_csr_custom_init_fn custom_arch_state_init;
> +    riscv_csr_custom_reset_fn custom_arch_state_reset;

Why do we need an init and a reset? I assume init is to allocate the stuct, but that should probably be commented here.

How do you expect these to be set? Do you have an example?

Alistair

> } RISCVCPUDef;
>  
> /**
> -- 
> 2.43.0
> 
> 
> 

