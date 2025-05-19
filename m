Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADF9C3DA6D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 08:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGw3F-0008Q3-1v; Mon, 19 May 2025 04:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uGw34-0008Pj-EM
 for qemu-devel@nongnu.org; Mon, 19 May 2025 04:40:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uGw31-0005Bf-SW
 for qemu-devel@nongnu.org; Mon, 19 May 2025 04:40:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so42712345e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 01:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747644033; x=1748248833; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c7Tiqcdwm81CA8rX9tyKqOTIm//gCtofDFzXDEDMofY=;
 b=zgO3ua2PADw4nWFIYcn5uDyDT9aNk0OWMA6gN18MCKk825IbZpx/FJcbwWhw0jUlJc
 olJgMgw35gE5Tx9zy9JUvTaaSJk4YQRhcN0meZQm1kIWHRgRFWf5uH9noI0YuIFFX2eK
 WT77f6aVh/7KRCFuZXza2iA6KtRZA8Fd36y/cM2C61JuYtg4KzdUDiObDAd4JgZPptzl
 X8OxkUzKhCJSkqxTGhiNkN7MVMIiYOYceJyet2J+QKNhiMbrtIIiEyaSX8EwRZlpy1nM
 EHTDd+kc3h1ndzO2Dd0zQ+2ss1E3GXmwe6DuO82MZtNYM99+4RE8AFSA2YBd4ndZ/hac
 CNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747644033; x=1748248833;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7Tiqcdwm81CA8rX9tyKqOTIm//gCtofDFzXDEDMofY=;
 b=RAE87pSN/iSLBo2PNMfmzFhKxx0W8xVGJGrw2E0HFulPK4ucqunyZeRTA9XjYeIXsp
 QNyZ3Q/xHWnHiQNFAfH2gM3J/1++/LB0ACurBrW81CkwpX7hdMsRSvAv7DUCu+cqPTJU
 rIhaKT18UIvBi77lmh2XSomfcc0vxfwgliLbUVdwLc+vDrr3XQzpELNWDxBY2m+iuJrP
 DsQ/TfXd73OIooNAv/6dxy1I5nYeKfYKs1zVEppGG6BzV6eVza2oTNYmWdyGG1ISGnNe
 CqRAFjEABMKNxYaCbin0/pmTg2TSU8g6lWJuZO8EorTlataFj+lwoSt7HsNdJzyOGCHU
 mNFg==
X-Gm-Message-State: AOJu0YzX7EGOemZSjmEPfJuSIknhBgXdlgAro2uBR+omnyYzcpOGFwh2
 n9faWVx1ewGniv6sS2wbXcRPUQWRvwruz8XvuuCVVeCgOo5KKSLz7joP5uRQ4oUy0DFSCEElkdc
 BESFYJbs=
X-Gm-Gg: ASbGnct6UvGQQ5UXPJqc3+8xuzF3+4MEJEtmgqXqg0GuQV7+Xe9gfilb8Wgmz4csHni
 v0GrDA5Jc7/s+vdGMy91Q5CUonIUX3SnMEcUu32oQrxgAB2C5zChyPQ87I1t9pxADSFrc3N3VY4
 XzPLe4BJC2j86X9QOV6vNrmLm+0sPjqdlMuhP1nO1kOEv2m+1MGNY9Vb/HqiroT95DO4oJVdo9d
 n7xURM8R3Dvgx0vI8WObQTGXpH6wl4mv4IzFQF6WHzgyprqp9xuVjzB9j2uNDVgdQxyRZNUu3bv
 5uLI/IrG7HGpxSkqoGOwZW4tiuCzqG1Oc8ral25pBbM7c3WagTZMqsU+mUAMhmnHsMhcpqrbDx7
 lofSLBttpbDe7sw==
X-Google-Smtp-Source: AGHT+IGLpRfCOxWgukTSj8tUeHA9AlaBgvXPcGD4eQJB6Cdul1AjjvO0XIfRhnBmtF17v+DNNeNu1A==
X-Received: by 2002:a05:6000:1883:b0:3a0:7d39:c23f with SMTP id
 ffacd0b85a97d-3a35c821990mr9307335f8f.21.1747644033135; 
 Mon, 19 May 2025 01:40:33 -0700 (PDT)
Received: from meli-email.org (adsl-1.37.6.162.tellas.gr. [37.6.162.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca6210asm11875324f8f.41.2025.05.19.01.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 01:40:32 -0700 (PDT)
Date: Mon, 19 May 2025 11:38:40 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Mario Fleischmann <mario.fleischmann@lauterbach.com>
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com,
 Mario Fleischmann <mario.fleischmann@lauterbach.com>
Subject: Re: [PATCH v2 16/20] gdbstub: Expose gdb_write_register
User-Agent: meli/0.8.12
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
 <20250430052741.21145-17-mario.fleischmann@lauterbach.com>
In-Reply-To: <20250430052741.21145-17-mario.fleischmann@lauterbach.com>
Message-ID: <swi2rj.3jwvaeg7bc4oy@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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

On Wed, 30 Apr 2025 08:27, Mario Fleischmann <mario.fleischmann@lauterbach.com> wrote:
>Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
>---
> gdbstub/gdbstub.c      |  2 +-
> include/exec/gdbstub.h | 10 ++++++++++
> 2 files changed, 11 insertions(+), 1 deletion(-)
>
>diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>index 291ac55..6ace944 100644
>--- a/gdbstub/gdbstub.c
>+++ b/gdbstub/gdbstub.c
>@@ -527,7 +527,7 @@ int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
>     return 0;
> }
> 
>-static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
>+int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
> {
>     GDBRegisterState *r;
> 
>diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
>index c2941e5..e2d8488 100644
>--- a/include/exec/gdbstub.h
>+++ b/include/exec/gdbstub.h
>@@ -130,6 +130,16 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname);
>  */
> int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
> 
>+/**
>+ * gdb_write_register() - Write a register associated with a CPU.
>+ * @cpu: The CPU associated with the register.
>+ * @mem_buf: The buffer that the register will be written from.

I think this is more explanatory:

"The buffer holding the bytes value that will be written to the register."

Either way,

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>+ * @reg: The register's number returned by gdb_find_feature_register().
>+ *
>+ * Return: The number of written bytes.
>+ */
>+int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg);
>+
> /**
>  * typedef GDBRegDesc - a register description from gdbstub
>  */
>-- 
>2.34.1
>
>

