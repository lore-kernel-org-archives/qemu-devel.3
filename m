Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D823C7EE39
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Jun 2025 18:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVx7M-0004xj-SX; Sun, 29 Jun 2025 14:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uVx7K-0004xX-V3
 for qemu-devel@nongnu.org; Sun, 29 Jun 2025 14:51:07 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uVx7I-0000qM-Sl
 for qemu-devel@nongnu.org; Sun, 29 Jun 2025 14:51:06 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-60c9d8a16e5so3293332a12.0
 for <qemu-devel@nongnu.org>; Sun, 29 Jun 2025 11:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751223061; x=1751827861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLq6/4RxcSJfEghBO0gACi7Caox0/R7AEh1EL2jb81o=;
 b=Eupeehgqs9Hf5lyt8lCjB0R5Yh8drk9BNsCIsPgoj4rF/R3RaYdQc5TFj8HBQM8fEu
 bQy3z/1xpd7EALlaF3o++WRH7dWFgVZvxHWcVnGxP/qnzryxT015xAEf2YwoP/b9i3BJ
 AZ1c0VGyOuPok4k8LfnpWD2pHYQUOZYwEcY2JSCz2tbLCRMmfqPRmZvAaM+/hJ3+56FH
 obzKCzfgno18SjbK4y0XolYA8xtQlr2DRHSdrGBXi7F2TDdhPBqo1QVLgSyNn6SxYOPQ
 J8pF2a+T98wq/pUUSJjeGwsztE0OgOe/0j6kfbHdbMrQ9vuO/ClMYrbC0N1rU13iBedG
 pTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751223061; x=1751827861;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zLq6/4RxcSJfEghBO0gACi7Caox0/R7AEh1EL2jb81o=;
 b=YbBFqVt+gDJOUJ/cqynmR1gOC7+bS1ItqJLK7yO2rjAaVilyifKIFHpBqKgcIkobAX
 7PQui83PxGmvauXKw/b6zAAQ0dwoGV8wAWUsLYb8TDy0hPsWCibbEVMd7VBpZLNSli6g
 OR3Yi5EwaiKxAYyIAH4pHl5sWaD6IRNoPBQFLFB8d9joFircU0AnXnCXIE6abfnKDzyB
 0jA6n4Jx2mkZgvwzhtX9RaipZcW70gG2+8Dj6ciMYh3Ddu9u/IZj6jg6CISH9xOBb66x
 TpXjEccum5IkhECsDEeozIf7ItTeVYKs66wltcFb/x9p+FZs+NYGu3GRAnfRsfypZQ29
 cq4g==
X-Gm-Message-State: AOJu0YyUZFJNKUjcxycy8RA6p11FbFS3RzVCBPfSB1yj1b+ACQ6s0y3E
 085wMZDu1ozpzLUW2IwoboNl+naMtQ+j7wvENt0sYaoEghrcgAOv8RKxxwLrmF2HscU=
X-Gm-Gg: ASbGnctWK8OergxKURcWFZYf9fFdNuoHFZwoXvFJLkpL0r8Agx7zLx82Gu+Xkhkw6GC
 3mnQE+pzjIKZ6NXWirhlUxe7Nv2AJN2Uqu2725AdcxUmc7PfyfZkPvEomGCbyZwGdzg9Y/n8+tb
 mCVJJ2NO38BujGJR9Wf/PBsmKLBssheDJkO+BsA7kDWSq2R5O5FEHejKucoT/O8dlNPQqn8CWKl
 TIibsetLpr38PFoIJWCzjhKBZdQ1Ssd7bt2JYbwg67bjn9EOYVkXXmMJI8YedS+JzwqTBM77t/J
 s41jt0onh8FCvuPvE9Qt7fe+fDPL4wBMz0gM6CLcnl6O6svDAFGWNOpJFal5trE=
X-Google-Smtp-Source: AGHT+IGUfXWKyFM4XefxQiHYXGjmm4q9W12PYU83RLQz5voi/ViBCXutPx60TMYvUbiG93as5aKp7w==
X-Received: by 2002:a17:906:dc89:b0:ae0:a483:39bc with SMTP id
 a640c23a62f3a-ae35017d967mr1012078166b.46.1751223061356; 
 Sun, 29 Jun 2025 11:51:01 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae35365a923sm542221866b.68.2025.06.29.11.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 11:51:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 358695F7DD;
 Sun, 29 Jun 2025 19:50:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yodel Eldar <yodel.eldar@gmail.com>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,  laurent@vivier.eu
Subject: Re: [PATCH 1/2] contrib/plugins/execlog: Add tab to the separator
 search of insn_disas
In-Reply-To: <20250627204817.47595-2-yodel.eldar@gmail.com> (Yodel Eldar's
 message of "Fri, 27 Jun 2025 15:47:58 -0500")
References: <20250627204817.47595-1-yodel.eldar@gmail.com>
 <20250627204817.47595-2-yodel.eldar@gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Sun, 29 Jun 2025 19:50:59 +0100
Message-ID: <87wm8uwfe4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

Yodel Eldar <yodel.eldar@gmail.com> writes:

> Currently, execlog searches for a space separator between the
> instruction mnemonic and operands, but some disassemblers, e.g. Alpha's,
> use a tab separator instead; this results in a null pointer being passed
> as the haystack in g_strstr during a subsequent register search, i.e.
> undefined behavior, because of a missing null check.
>
> This patch adds tab to the separator search and a null check on the
> result.
>
> Also, existing, affected pointers are changed to const.
>
> Lastly, a break statement was added to immediately terminate the
> register search when a user-requested register is found in the current
> instruction as a trivial optimization, because searching for the
> remaining requested registers is unnecessary once one is found.
>
> Signed-off-by: Yodel Eldar <yodel.eldar@gmail.com>
> ---
>  contrib/plugins/execlog.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
> index d67d010761..08fc1f12d4 100644
> --- a/contrib/plugins/execlog.c
> +++ b/contrib/plugins/execlog.c
> @@ -232,12 +232,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, stru=
ct qemu_plugin_tb *tb)
>           */
>          if (disas_assist && rmatches) {
>              check_regs_next =3D false;
> -            gchar *args =3D g_strstr_len(insn_disas, -1, " ");
> -            for (int n =3D 0; n < all_reg_names->len; n++) {
> -                gchar *reg =3D g_ptr_array_index(all_reg_names, n);
> -                if (g_strrstr(args, reg)) {
> -                    check_regs_next =3D true;
> -                    skip =3D false;
> +            const gchar *args =3D strpbrk(insn_disas, " \t");

We have a general preference for glib here, could we use g_strsplit_set?

Something like:

modified   contrib/plugins/execlog.c
@@ -232,12 +232,14 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct=
 qemu_plugin_tb *tb)
          */
         if (disas_assist && rmatches) {
             check_regs_next =3D false;
-            gchar *args =3D g_strstr_len(insn_disas, -1, " ");
-            for (int n =3D 0; n < all_reg_names->len; n++) {
-                gchar *reg =3D g_ptr_array_index(all_reg_names, n);
-                if (g_strrstr(args, reg)) {
-                    check_regs_next =3D true;
-                    skip =3D false;
+            g_auto(GStrv) args =3D g_strsplit_set(insn_disas, " \t", 2);
+            if (args && args[1]) {
+                for (int n =3D 0; n < all_reg_names->len; n++) {
+                    gchar *reg =3D g_ptr_array_index(all_reg_names, n);
+                    if (g_strrstr(args[1], reg)) {
+                        check_regs_next =3D true;
+                        skip =3D false;
+                    }


> +            if (args) {
> +                for (int n =3D 0; n < all_reg_names->len; n++) {
> +                    const gchar *reg =3D g_ptr_array_index(all_reg_names=
, n);
> +                    if (g_strrstr(args, reg)) {
> +                        check_regs_next =3D true;
> +                        skip =3D false;
> +                        break;
> +                    }
>                  }
>              }
>          }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

