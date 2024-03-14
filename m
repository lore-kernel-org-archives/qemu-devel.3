Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD39C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 03:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkc9D-0007MD-MW; Wed, 13 Mar 2024 23:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rkc9C-0007La-7a
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 23:52:50 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1rkc9A-0001aF-By
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 23:52:49 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dd7df835a8so4797385ad.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 20:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1710388365; x=1710993165; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uukGC2YgkiA6kPo351DkNE23YYT/xm/ozkkgaxd2t2w=;
 b=FdXsonbtkWbv+tqwZYkiAX4SQx4NpjySajxOB2lilzuQOzidzBEWZRSQAD7N9CGNZZ
 NC2GX5XTILuXajyvRUJcbhnkqcQoblIWSAkdrst/x45UEqXEznatYMO/HY0Ka1tGTryV
 4uMXdl0akfBwEJYgyOoQrvGbscf8IWcNP+gTtOPBlTe19lf1ryCE+cB/BX4MKhC8uPPa
 ZOTmbqxQNIXdxXTnNDunrJP+285GESIY72ryG9Fdunihrl3uo4lV/tA3Y2Vzp1kLvrQ0
 Mir3DwHkjG8WWk+Oa52tt0+zDviHUZyucA2upf2ElSA6xngn6ZlWvvdEhfeOQ73L93qJ
 TAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710388365; x=1710993165;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uukGC2YgkiA6kPo351DkNE23YYT/xm/ozkkgaxd2t2w=;
 b=VMXyhxQnrQEVdUjzkfERFP3qrs1MoCuP9V5C4gNIrvFS40ml2IF+OZiE+KdhGg1lF6
 Pxvegn2FlZbNZNlP2xDDTKk7fweZUqVwwWHib4mLLv1HyUcgzW7+4hBVJIKxS8728ywi
 vjEzaD5t4JjnhtLOLbktKipfL65lzYOKFGl5iKJYzRY3tkL4YsLRb0CVIKPLPPwFFlF1
 rCrCVK3cwhaoDN2yszLERbmQLL3MA1tcYMhg1HGMJEAf19tohNiqhv82gQTRDIP17ukE
 SjKjYDeTunhfgr6gEcV/FbE57PweHelnDcNDGfdcXctxUqVEPzE+VXSgLSR9A5sMvhfh
 dUBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDazx72YL3ltax1qm74dQDtZeQPOWNaLizqcr3U8AjacsVea9tDU/5pfC10jRpd1sVeVNudL4yCGVaPQUJU4k1r1eFe1c=
X-Gm-Message-State: AOJu0YztbeBnZ3ZI9ajbZ9A0kQOXuBfxw8KEHMXqIPnb3IPmQVLMFHAu
 ByFN9Q1LO3Q7Ee99WZrsQNau6ipzXiOE8+p/M/66mnCAWECoCthKDKu9M3lsHJc=
X-Google-Smtp-Source: AGHT+IE61WGKudf1fKmddlALVxSKtz1c/MrLKYnuyL0TWqU1rKISKhHlUDHpyFOTh1FhrFbTW3MpHg==
X-Received: by 2002:a17:902:cecf:b0:1dd:d412:906c with SMTP id
 d15-20020a170902cecf00b001ddd412906cmr1018388plg.12.1710388365212; 
 Wed, 13 Mar 2024 20:52:45 -0700 (PDT)
Received: from [100.64.0.1] ([136.226.240.169])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a170902ecc200b001dddc21866csm428329plh.103.2024.03.13.20.52.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 20:52:44 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------KGMbmnlyOj1YMr26eVfba8hg"
Message-ID: <9c04593a-3909-47b4-92f7-4195582a8e83@sifive.com>
Date: Thu, 14 Mar 2024 11:52:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 v14 4/8] target/riscv/vector_helpers: do early
 exit when vstart >= vl
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, philmd@linaro.org
References: <20240313220141.427730-1-dbarboza@ventanamicro.com>
 <20240313220141.427730-5-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Max Chou <max.chou@sifive.com>
In-Reply-To: <20240313220141.427730-5-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This is a multi-part message in MIME format.
--------------KGMbmnlyOj1YMr26eVfba8hg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel,

According the v spec section 15.2 & 15.3.

"The vcpop.m instruction writes x[rd] even if vl=0 (with the value 0, 
since no mask elements are active).
   Traps on vcpop.m are always reported with a vstart of 0. The vcpop.m 
instruction will raise an illegal instruction exception if vstart is 
non-zero."

"The vfirst.m instruction writes x[rd] even if vl=0 (with the value -1, 
since no mask elements are active).
  Traps on vfirst are always reported with a vstart of 0. The vfirst 
instruction will raise an illegal instruction exception if vstart is 
non-zero."

Both the vcpop.m and vfirst.m instructions will raise illegal 
instruction exception with non-zero vstart.

And currently both the trans_vcpop_m and trans_vfirst_m translate 
functions check the vstart_eq_zero flag.
So I think the early exit checking in the vcpop.m and vfirstm helper 
functions may be redundant.

> @@ -4585,6 +4641,11 @@ target_ulong HELPER(vcpop_m)(void *v0, void *vs2, CPURISCVState *env,
>       uint32_t vl = env->vl;
>       int i;
>   
> +    if (env->vstart >= env->vl) {
> +        env->vstart = 0;
> +        return 0;
> +    }
> +
>       for (i = env->vstart; i < vl; i++) {
>           if (vm || vext_elem_mask(v0, i)) {
>               if (vext_elem_mask(vs2, i)) {

According v spec section 15.3

""The vfirst.m instruction writes x[rd] even if vl=0 (with the value -1, 
since no mask elements are active)."

If both the vstart and vl are 0 here, the early exit checking will 
return the wrong value 0 (the return value should be -1) here.

> @@ -4604,6 +4665,11 @@ target_ulong HELPER(vfirst_m)(void *v0, void *vs2, CPURISCVState *env,
>       uint32_t vl = env->vl;
>       int i;
>   
> +    if (env->vstart >= env->vl) {
> +        env->vstart = 0;
> +        return 0;
> +    }
> +
>       for (i = env->vstart; i < vl; i++) {
>           if (vm || vext_elem_mask(v0, i)) {
>               if (vext_elem_mask(vs2, i)) {
>
--------------KGMbmnlyOj1YMr26eVfba8hg
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><font face="monospace">Hi Daniel,<br>
      </font></p>
    <p><font face="monospace">According the v spec section 15.2 &amp;
        15.3.<br>
      </font></p>
    <p><font face="monospace">"</font><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">The </span><span
        style="font-size: 9.000000pt; font-family: 'RobotoMono'">vcpop.m
      </span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">instruction
        writes </span><span
        style="font-size: 9.000000pt; font-family: 'RobotoMono'">x[rd] </span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">even
        if </span><span
        style="font-size: 9.000000pt; font-family: 'RobotoMono'">vl</span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">=0
        (with the value 0, since no mask elements are active).<br>
          Traps on </span><span
        style="font-size: 9.000000pt; font-family: 'RobotoMono'">vcpop.m
      </span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">are
        always reported with a </span><span
        style="font-size: 9.000000pt; font-family: 'RobotoMono'">vstart
      </span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">of 0.
        The </span><span
        style="font-size: 9.000000pt; font-family: 'RobotoMono'">vcpop.m
      </span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">instruction
        will raise an illegal instruction
        exception if </span><span
        style="font-size: 9.000000pt; font-family: 'RobotoMono'">vstart
      </span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">is
        non-zero."<br>
        <br>
        "</span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">The </span><span
        style="font-size: 9.000000pt; font-family: 'RobotoMono'">vfirst.m
      </span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">instruction
        writes </span><span
        style="font-size: 9.000000pt; font-family: 'RobotoMono'">x[rd] </span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">even
        if </span><span
        style="font-size: 9.000000pt; font-family: 'RobotoMono'">vl</span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">=0
        (with the value -1, since no mask elements are active).<br>
         Traps on </span><span
        style="font-size: 9.000000pt; font-family: 'RobotoMono'">vfirst
      </span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">are
        always reported with a </span><span
        style="font-size: 9.000000pt; font-family: 'RobotoMono'">vstart
      </span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">of 0.
        The </span><span
        style="font-size: 9.000000pt; font-family: 'RobotoMono'">vfirst
      </span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">instruction
        will raise an illegal instruction exception if
      </span><span
        style="font-size: 9.000000pt; font-family: 'RobotoMono'">vstart
      </span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">is
        non-zero."</span></p>
    <p><span style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">Both
        the vcpop.m and vfirst.m instructions will raise illegal
        instruction exception with non-zero vstart.</span></p>
    <p><span style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">And
        currently both the trans_vcpop_m and trans_vfirst_m translate
        functions check the vstart_eq_zero flag.<br>
        So I think the early exit checking in the vcpop.m and vfirstm
        helper functions may be redundant.<br>
      </span></p>
    <div class="page" title="Page 78">
      <div class="layoutArea">
        <div class="column"> </div>
      </div>
    </div>
    <div class="page" title="Page 78">
      <div class="layoutArea">
        <div class="column"> </div>
      </div>
    </div>
    <span style="white-space: pre-wrap">
</span>
    <blockquote type="cite"
      cite="mid:20240313220141.427730-5-dbarboza@ventanamicro.com">
      <pre class="moz-quote-pre" wrap="">@@ -4585,6 +4641,11 @@ target_ulong HELPER(vcpop_m)(void *v0, void *vs2, CPURISCVState *env,
     uint32_t vl = env-&gt;vl;
     int i;
 
+    if (env-&gt;vstart &gt;= env-&gt;vl) {
+        env-&gt;vstart = 0;
+        return 0;
+    }
+
     for (i = env-&gt;vstart; i &lt; vl; i++) {
         if (vm || vext_elem_mask(v0, i)) {
             if (vext_elem_mask(vs2, i)) {</pre>
    </blockquote>
    <p><font face="monospace">According v spec section 15.3</font></p>
    <p><font face="monospace">"</font><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">"</span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">The </span><span
        style="font-size: 9.000000pt; font-family: 'RobotoMono'">vfirst.m
      </span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">instruction
        writes </span><span
        style="font-size: 9.000000pt; font-family: 'RobotoMono'">x[rd] </span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">even
        if </span><span
        style="font-size: 9.000000pt; font-family: 'RobotoMono'">vl</span><span
        style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">=0
        (with the value -1, since no mask elements are active)."</span></p>
    <p><span style="font-size: 9.000000pt; font-family: 'IBMPlexSans'">If
        both the vstart and vl are 0 here, the early exit checking will
        return the wrong value 0 (the return value should be -1) here.<br>
      </span></p>
    <blockquote type="cite"
      cite="mid:20240313220141.427730-5-dbarboza@ventanamicro.com">
      <pre class="moz-quote-pre" wrap="">
@@ -4604,6 +4665,11 @@ target_ulong HELPER(vfirst_m)(void *v0, void *vs2, CPURISCVState *env,
     uint32_t vl = env-&gt;vl;
     int i;
 
+    if (env-&gt;vstart &gt;= env-&gt;vl) {
+        env-&gt;vstart = 0;
+        return 0;
+    }
+
     for (i = env-&gt;vstart; i &lt; vl; i++) {
         if (vm || vext_elem_mask(v0, i)) {
             if (vext_elem_mask(vs2, i)) {

</pre>
    </blockquote>
  </body>
</html>

--------------KGMbmnlyOj1YMr26eVfba8hg--

