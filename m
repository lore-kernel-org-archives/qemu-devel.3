Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D37CC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7t5r-0005Ts-LZ; Thu, 24 Apr 2025 05:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u7t5p-0005TK-7Z; Thu, 24 Apr 2025 05:42:05 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1u7t5n-00024m-C4; Thu, 24 Apr 2025 05:42:04 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac6ed4ab410so131384066b.1; 
 Thu, 24 Apr 2025 02:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1745487720; x=1746092520; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JBgcF66bAes2tdC/cppNINK64ZI/vVeNg3Xt/eFhDXs=;
 b=R5KdbQVPK9JVbH+gyCNVCmalRSMMahWEdihfcFF9EZUoLEfYRkR/W9RCvqW6WR8mg7
 rxR5NLeh7yY1HWbGGsHdhkIwcTQdPBiO41Y1kTUSM+9fKUiNMdqxeoOJsyybqO/qH99a
 OsxS3fWpFBeGbpPNMsWfQoWZhblWkUaubTW38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745487720; x=1746092520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JBgcF66bAes2tdC/cppNINK64ZI/vVeNg3Xt/eFhDXs=;
 b=M5IcWICZ2LaNC1iZyxOj0U2mAOJ44cXxXqoUD5YR2rPrc47WlxBrktgnNhxVInpH34
 4BChw2ln5iGgd61/085jn3nyf1yc37NPXECiJNFYJWZuxQPPxgGM1etLmrRJQ5xcb5LJ
 4XsoKbqN5iLzY71YHkrpgVgwmSD6aWRFNkwNyRMO5zg8mxhAi3s1Z0uHUTY0WPFwQJy5
 6/JJtsOREEaWJSMIplPXupSpvXoDHB10o2Agcz/oRTVr/C3BIj0591V14BUX/TrvDWoA
 QGbe0NqYavHhD0rdHjwFBJrAkqdDBLNOSGbyPctQFeWuhxKQbUfY8D0ajK/WZ1oLonG3
 dxEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJW0JPWeC7cPjSDvWZztTZvB9p1jFWJ1XHzfXQnHg3aLltg0jyhK/hz4dDOLYQlQPzDOo+fE1CzDTD@nongnu.org
X-Gm-Message-State: AOJu0YzzF+oTN8UVtfCbn2ZZFmqE8EMqACSPvUEn1DljiMqH6Sk5E/iQ
 BGbxsbk9wiJEBkIEkw30geH34xYomhiA2hzBC/580gkfOfiN/iJVnB5+tXMzG3xkea9LpN+4gXC
 Cb8/rv//1n7DJZi6m8pf2XyXXhHHpBiFv
X-Gm-Gg: ASbGncu41q2yQW/7Mq0DpmrdxYEK31EyPbQSgwqgL2WRKu+rJeBwrMr/QcEunzjk4cL
 BiwYFFCg7NAqYq3/Y/Jaa3msfA2wZpQ06qW8m5Wreh3WYGx5IjxBQ1Jy+766YYUea3N7tfyJWE8
 cbUkMmw4AMnaS64btgo0W6
X-Google-Smtp-Source: AGHT+IFW/6xZKY6SZvyON9tDvosbGBxLEd7NPvWo1i2z+GH7bL8TfVF6jl3GL2ZZrUTt/8oV8sMAVTIr5wCtBnkdu1k=
X-Received: by 2002:a17:907:9717:b0:ac7:971b:ffd with SMTP id
 a640c23a62f3a-ace570e7e04mr196665366b.10.1745487720236; Thu, 24 Apr 2025
 02:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
 <20250423110630.2249904-10-dbarboza@ventanamicro.com>
In-Reply-To: <20250423110630.2249904-10-dbarboza@ventanamicro.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 24 Apr 2025 19:11:47 +0930
X-Gm-Features: ATxdqUE8YufjUrf9n9XYZpp_BLp_ngoi5NYffiCfmTYWZCXkBTFHhlcDnw3BBNY
Message-ID: <CACPK8Xei9L_82YV7+wPmTacEh2MNLFticOEny_6kSM9miCAt2w@mail.gmail.com>
Subject: Re: [PATCH 9/9] hw/riscv/virt.c: remove 'long' casts in fmt strings
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, 23 Apr 2025 at 20:39, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We can avoid the 'long' casts by using PRIx64 and HWADDR_PRIx on the fmt
> strings for uint64_t and hwaddr types.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/virt.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 036a0a9bfb..075c035f25 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -309,7 +309,7 @@ static void create_fdt_socket_memory(RISCVVirtState *s, int socket)
>
>      addr = s->memmap[VIRT_DRAM].base + riscv_socket_mem_offset(ms, socket);
>      size = riscv_socket_mem_size(ms, socket);
> -    mem_name = g_strdup_printf("/memory@%lx", (long)addr);
> +    mem_name = g_strdup_printf("/memory@%"PRIx64, addr);

I wondered why this wasn't a HWADDR_PRIx.

addr (and NodeInfo::node_mem?) could be a hwaddr? That would make
everything more consistent.

Cheers,

Joel

