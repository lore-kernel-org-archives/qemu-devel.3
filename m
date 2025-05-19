Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042CDC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 08:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGw4t-0000mh-5C; Mon, 19 May 2025 04:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uGw4s-0000mZ-3o
 for qemu-devel@nongnu.org; Mon, 19 May 2025 04:42:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uGw4q-0005Te-7B
 for qemu-devel@nongnu.org; Mon, 19 May 2025 04:42:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so32891525e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747644146; x=1748248946; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0JZTkeP0hqFjz+ItViE1OoH01EezIpmomC2zK/9NxvU=;
 b=xISLxXV7c8oMKdOB5DhIxfV7e/uq42BdANs+3QFn3T4AI4oLIK7AVBjO7qnrtuQqNZ
 cW21KywuydfVoKmpb1F/brUUEH4hB6idY4SOM5NcqaqtWiT0+qAypZ+cSdfXrQnr/fmW
 0uQoaBXS7rxv8ZiAe8AKXhXrCHKGvrwXZWQINNWcfjRSBt8/kjbUOz0WehM23v7JlMEG
 HE5t4Vm4SlLgfSbQqTBdgCndtrCwbqPW8g2NvEDf9mZXuZ0mBgDY/f9mcFCGD8sgyvpZ
 L/u7f8GOoxSDNKkbKKRJXGAGdwkczF3UYu387CYjVfKSwYLdrTTN7Y3Ht1QUHpqEku3s
 BB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747644146; x=1748248946;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JZTkeP0hqFjz+ItViE1OoH01EezIpmomC2zK/9NxvU=;
 b=raCKsLftTIysneHdCronIXSP8lKd9iZCcEcF6upASMsW96HsBv9JJTq7Isc/ZclpDf
 LQTJWzDj73B+czBzxIoCEWPXSO0ZagTSxHtqdSyhVhRLQ06/7g4pJ7hMnF4h03PpqofT
 9hE/CYUlx1SQZoK9mVh7OyvOTunhjh+btgn0RwBZhDVFP+QYLU1CdMNaloP3qBm6jfyr
 b1aGjgX0etQUnzz0Rbe6BC9qkx5LwqtC4Fgo8Q+DQRT9cFiOA3BTGlYIDmzA4DZUHX2D
 P9I6G5zjkf+aLkUZvOv6RTzsbtHokrY1xTn8MUwxYHZBG6ffUUPMgBWXVtxZ6HOtlFlZ
 DGwA==
X-Gm-Message-State: AOJu0YxOJm/yZe60te0ZYPre0ptqrniottHWg00Lme6xhNkg5K7wEkRV
 lRQmsIx3XpbxDHHlrzkIDMuvl3U5SEtOmHxKCZNaYjeLWRcz+jRArJ8j6enVucKir/cf98p58OA
 ly1uhff8=
X-Gm-Gg: ASbGncsGfZEWcp4CHo4LkqUsu+b6cYppaFNMTUO6wtXyZanh0Jk8Er9foNINjcLafE8
 BTvwjobj247PcYCKSkOLhNhHk139t4bhIH3wmw3CuG0LipJwn/4rhBsFsPQs06Y59mNlGhs5oUe
 SFkCS2HCjPx+9nbxUjshedj86lRSBrOC4Le1lbx4sbpbpOEZ0jA3S6+UGLfFk225SkXXqV9r5Vp
 2Z5Lb6wLU7RtyF8WQRSvFnQHe4dGQg1+JEi24BH+g65HanxH+hoyOkRKhSLwjmA8eVfelTQgbjF
 JhEB5Jlu86ivVwwjgyQzPri05kigAuc58ItNGi9QDqZfzOuOw642ypXnwlQNxhgLqAWH8mVIxEe
 IcFgv9MGU34JAsA==
X-Google-Smtp-Source: AGHT+IGaC9u7qslNsPb2QWrK74+FCKU8TJfFSgai4pKGHAfHkk3/wr+e1raJr7Ksu/0F6nbqHKi43w==
X-Received: by 2002:a05:600c:4fc9:b0:43d:5ec:b2f4 with SMTP id
 5b1f17b1804b1-442fd6271b6mr146784155e9.10.1747644146454; 
 Mon, 19 May 2025 01:42:26 -0700 (PDT)
Received: from meli-email.org (adsl-1.37.6.162.tellas.gr. [37.6.162.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442ebdc362fsm158473975e9.1.2025.05.19.01.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 01:42:26 -0700 (PDT)
Date: Mon, 19 May 2025 11:41:04 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Mario Fleischmann <mario.fleischmann@lauterbach.com>
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com,
 Mario Fleischmann <mario.fleischmann@lauterbach.com>
Subject: Re: [PATCH v2 12/20] gdbstub: Expose GDBRegisterState
User-Agent: meli/0.8.12
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
 <20250430052741.21145-13-mario.fleischmann@lauterbach.com>
In-Reply-To: <20250430052741.21145-13-mario.fleischmann@lauterbach.com>
Message-ID: <swi2up.1p55n77aa7new@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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
> gdbstub/gdbstub.c      | 7 -------
> include/exec/gdbstub.h | 8 +++++++-
> 2 files changed, 7 insertions(+), 8 deletions(-)
>
>diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>index 565f6b3..291ac55 100644
>--- a/gdbstub/gdbstub.c
>+++ b/gdbstub/gdbstub.c
>@@ -48,13 +48,6 @@
> 
> #include "internals.h"
> 
>-typedef struct GDBRegisterState {
>-    int base_reg;
>-    gdb_get_reg_cb get_reg;
>-    gdb_set_reg_cb set_reg;
>-    const GDBFeature *feature;
>-} GDBRegisterState;
>-
> GDBState gdbserver_state;
> 
> void gdb_init_gdbserver_state(void)
>diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
>index 0675b0b..c2941e5 100644
>--- a/include/exec/gdbstub.h
>+++ b/include/exec/gdbstub.h
>@@ -16,11 +16,17 @@ typedef struct GDBFeatureBuilder {
>     int base_reg;
> } GDBFeatureBuilder;
> 
>-

Accidental line deletion here?

With that fixed,

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



> /* Get or set a register.  Returns the size of the register.  */
> typedef int (*gdb_get_reg_cb)(CPUState *cpu, GByteArray *buf, int reg);
> typedef int (*gdb_set_reg_cb)(CPUState *cpu, uint8_t *buf, int reg);
> 
>+typedef struct GDBRegisterState {
>+    int base_reg;
>+    gdb_get_reg_cb get_reg;
>+    gdb_set_reg_cb set_reg;
>+    const GDBFeature *feature;
>+} GDBRegisterState;
>+
> /**
>  * gdb_init_cpu(): Initialize the CPU for gdbstub.
>  * @cpu: The CPU to be initialized.
>-- 
>2.34.1
>
>

