Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF233D48981
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgiAR-0002Ck-J2; Fri, 16 Jan 2026 06:39:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vgi9t-00026v-Ey
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:38:42 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vgi9q-00017n-OR
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:38:29 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so10478345e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768563504; x=1769168304; darn=nongnu.org;
 h=in-reply-to:from:cc:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yegmVWK+S8ae7YDwsWiupFNvdK/cte+7BnKI7zq9fY=;
 b=CUFYFssAGToB8TEDFTE9miKomlDcvEGrrfLpowTRbfkwD2qYhQWft3GEytn0Jte8lg
 Ua1zVIILRjbhVlVUJyuuCnH6SLXiSVZQ434b3caYzV+tMNwyM8GVx/3I4DcfCu8sZbch
 9pFMEBd4MJ9ZYDvO462rHEMbwbk6TGIylvrVnx64vnMdgv+PlIpOTBSl/CpNxLq4SioO
 JgZ12MK7vlGb9icXPJgp+PIERzpbyZuZCutw69+rooR8WOZQICfhB66ASV0fChSji4yn
 1lYFb4/3KZxExYic8ztma9co3ue+Dw+9K3g25XprnyW7VoOyt3ik3ftFjxbaP8fBqWg7
 O9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768563504; x=1769168304;
 h=in-reply-to:from:cc:content-language:references:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5yegmVWK+S8ae7YDwsWiupFNvdK/cte+7BnKI7zq9fY=;
 b=d0yqLVZODYHEZo6HlYDHsmoVizGq9PCieDT3Tw2CrMuEXXfxGvAG6tVYDSONv1GhGe
 fMDr9GYuRJVlVbinRn1tL0c/4LRhRYnjcZsw0APhjpt/9Jk5oUe/yU5Hib8bOwyOWheK
 BgC1Tk++RXp1z2gsKeU8ZGzHKSSWhiYFHrcnbt2L3MyGO3tlK+0KQtDm/qscGV3sXSAf
 KbcgAE1XmDoenQ/h6n/L8CRrSHVmCPwAOL+cEoEU1DAfMqljlaM6zv0v3AYiFJq8I3Si
 diduUSHiXQ2RxkI107ssO1kVkvWXjlNHTFJEfiEEwCk1c9KggAcSVE9BTq9mAwRO8i+A
 rGJA==
X-Gm-Message-State: AOJu0YyPo/Rm066uvwx+iU1FmFTEGBVUHzqNygLmRXcZFFvXcapSCPe0
 jyBDp/gDOI3YXdsgfhF/Winh0iLHhyb40MxtkXYWheSvwtKM5VAI5nQuTbYEOKYNiuvN9PmGrFa
 x/O9Y
X-Gm-Gg: AY/fxX5IqWX7dDg+XxYiE/TIEOsMUeu2cZL3ZZIGT+WZvhcEpDItBFNyCp7XMYhWFg5
 ophII1seviJXUhBCMm5EGGVW0yeRLMKSVEgi/7lBYr3Gm1qkKuWXgsfMvOEpycxuCDZXLDbBp/m
 PItSqreF6Ajr/h6UMV8dan04tio4wyj7taNhO6qydCKXxidFnCZpsBgO/Suo7IKEdP4pZniIcDZ
 s6BRDweD3os4pIX5PsoyaAYOoBihYsnxe1GWsYmIhhph9KDeGTApSoQPiJEplN2zrE22tuKP61f
 gacrYbVbJpJPQkzTy38cz9OdJ95pzjG6to0Gfbp07Ks8i1znBkXMKEpGY8GjYCW0ddnnIcT+SSW
 J3YDUXft6mkuhsaZd2y/InW7zLGEX1zPiIcYQcahO/rWYJcDvvkj5QmB2JGp0HKwIJIG6bjAR92
 KD4VP6U40Oo36e3zQNih+KA68u9l4EDnnsm7RY5WZ+VRUhvIi7z8+WnG4=
X-Received: by 2002:a05:600d:8445:10b0:480:1a22:fce8 with SMTP id
 5b1f17b1804b1-4801e3494acmr26838915e9.26.1768563504145; 
 Fri, 16 Jan 2026 03:38:24 -0800 (PST)
Received: from ?IPV6:2a10:d582:31e:0:bf4d:6c0b:c4a1:ca58?
 ([2a10:d582:31e:0:bf4d:6c0b:c4a1:ca58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fd458aesm15936255e9.2.2026.01.16.03.38.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 03:38:23 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------okY9sOL9SMnTDT0AwoSqrbjB"
Message-ID: <c19329fc-f57e-4687-a490-c38c4bfea866@linaro.org>
Date: Fri, 16 Jan 2026 11:38:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tcg: target-dependent lowering of extract to shr/and
To: qemu-devel@nongnu.org
References: <20260115135453.140870-1-pbonzini@redhat.com>
 <20260115135453.140870-2-pbonzini@redhat.com>
Content-Language: en-US
Cc: pbonzini@redhat.com
From: Jim MacArthur <jim.macarthur@linaro.org>
In-Reply-To: <20260115135453.140870-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

This is a multi-part message in MIME format.
--------------okY9sOL9SMnTDT0AwoSqrbjB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 13:54, Paolo Bonzini wrote:
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index fbf09f5c826..79ca49154a2 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -3509,11 +3509,8 @@ static void process_constraint_sets(void)
>       }
>   }
>   
> -static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
> +static const TCGArgConstraint *op_args_ct(TCGOpcode opc, TCGType type, unsigned flags)
>   {
> -    TCGOpcode opc = op->opc;
> -    TCGType type = TCGOP_TYPE(op);
> -    unsigned flags = TCGOP_FLAGS(op);
>       const TCGOpDef *def = &tcg_op_defs[opc];
>       const TCGOutOp *outop = all_outop[opc];
>       TCGConstraintSetIndex con_set;
> @@ -3540,6 +3537,24 @@ static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
>       return all_cts[con_set];
>   }
>   
> +static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
> +{
> +    return op_args_ct(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op));
> +}
> +
> +/* Return true if the backend can efficiently handle IMM as an immediate
> +   for OP.  */
> +bool tcg_op_imm_match(TCGOpcode opc, TCGType type, tcg_target_ulong imm)
> +{
> +    const TCGOpDef * const def = &tcg_op_defs[opc];
> +    const TCGArgConstraint *args_ct = op_args_ct(opc, type, 0);
> +
> +    tcg_debug_assert(def->nb_iargs == 2);
> +    return tcg_target_const_match(
> +        imm, args_ct[def->nb_oargs + 2].ct,
> +        type, 0, 0);
> +}
> +
>   static void remove_label_use(TCGOp *op, int idx)
>   {
>       TCGLabel *label = arg_label(op->args[idx]);

Functionally this looks good, but there are a couple of coding standards 
issues raised by scripts/checkpatch.pl: The definition of op_args_ct is 
over 80 characters, and your block comment for tcg_op_imm_match should 
use /* and */ on separate lines. If those are fixed I'm happy to approve it.

Jim

--------------okY9sOL9SMnTDT0AwoSqrbjB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 1/15/26 13:54, Paolo Bonzini wrote:<span
      style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
      cite="mid:20260115135453.140870-2-pbonzini@redhat.com">
      <pre wrap="" class="moz-quote-pre">diff --git a/tcg/tcg.c b/tcg/tcg.c
index fbf09f5c826..79ca49154a2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3509,11 +3509,8 @@ static void process_constraint_sets(void)
     }
 }
 
-static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
+static const TCGArgConstraint *op_args_ct(TCGOpcode opc, TCGType type, unsigned flags)
 {
-    TCGOpcode opc = op-&gt;opc;
-    TCGType type = TCGOP_TYPE(op);
-    unsigned flags = TCGOP_FLAGS(op);
     const TCGOpDef *def = &amp;tcg_op_defs[opc];
     const TCGOutOp *outop = all_outop[opc];
     TCGConstraintSetIndex con_set;
@@ -3540,6 +3537,24 @@ static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
     return all_cts[con_set];
 }
 
+static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
+{
+    return op_args_ct(op-&gt;opc, TCGOP_TYPE(op), TCGOP_FLAGS(op));
+}
+
+/* Return true if the backend can efficiently handle IMM as an immediate
+   for OP.  */
+bool tcg_op_imm_match(TCGOpcode opc, TCGType type, tcg_target_ulong imm)
+{
+    const TCGOpDef * const def = &amp;tcg_op_defs[opc];
+    const TCGArgConstraint *args_ct = op_args_ct(opc, type, 0);
+
+    tcg_debug_assert(def-&gt;nb_iargs == 2);
+    return tcg_target_const_match(
+        imm, args_ct[def-&gt;nb_oargs + 2].ct,
+        type, 0, 0);
+}
+
 static void remove_label_use(TCGOp *op, int idx)
 {
     TCGLabel *label = arg_label(op-&gt;args[idx]);</pre>
    </blockquote>
    <p>Functionally this looks good, but there are a couple of coding
      standards issues raised by scripts/checkpatch.pl: The definition
      of op_args_ct is over 80 characters, and your block comment for
      tcg_op_imm_match should use /* and */ on separate lines. If those
      are fixed I'm happy to approve it.</p>
    <p>Jim</p>
  </body>
</html>

--------------okY9sOL9SMnTDT0AwoSqrbjB--

