Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240BDC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 18:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlBgv-0004tW-MI; Thu, 20 Feb 2025 13:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlBgt-0004t1-Q7
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:54:31 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlBgr-00075U-WC
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 13:54:31 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e587cca1e47so1278975276.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 10:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740077668; x=1740682468; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ym7wF1ak4ewqxwNY8UafygPqWacAc2OvtvlP0b04NHE=;
 b=qAytn/gkhPDUzMAWFlbc+a0YdcNL2LDiQXjyY7SPdKA5+nlWgaz3XGIi4j+3o0qDoK
 CbiWKeJ2eH3WORqwsGelrKKzfvxY2VpbaoSWoMJzOGtPAArfa69S+FG/aqgPc+Rs8w27
 OMNpvxwXJV3ong0Ncfyg6/Cy2r5K8xtbNv7bmj/oYUR83/TrWGSYHlaUP6t7jFrcCRhw
 qUukRqx1g12CfGBf84bFd/3GZG0RCxYTBALceEslI2qm8Wx1JjurfEu2jY9nQ5sIcDCD
 BcvY5yiS9oI5VLSY+ZTut0yjfmhKptQxh2p6pao6iCUqzGi9WCJWBSCYDMTZnzkDLeRe
 wQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740077668; x=1740682468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ym7wF1ak4ewqxwNY8UafygPqWacAc2OvtvlP0b04NHE=;
 b=UhAsKzDoQ80izYwLCIzYcIb4AfIndUPojBWL+7Yoi/cgnRMnXHUBd3FX7JFtAtFKJQ
 rwBXLsoFt9SJ9a4fpCPZCt38aLmgtUiVjWX50R4ky8VndrIeh2vk6ycyMF9SeTDHSkYx
 Rrf/64hdIfCZourWAlZaz6nB26vpdrYqTaoMJwP+yW31QOdewieap7H+kEEmyYMCdLvL
 v/hGkRUyXCVRAZPgGa3WkiQYy3OjeoazNHvWEs28elf0tUiBYTiJMI+PE1epKEW3L6D0
 /0U6X+3VnqCE5rbrTNR3kNhpnuWmo/5sT3Dx0LNCYbEq8AXDUUCK9cKG2M8fG+xzab19
 6S2A==
X-Gm-Message-State: AOJu0Yw1KddHxQKVVkN6UXTHfz+34hWJe/W2n9lkopjCPnja7T+m3D/f
 rQnfzDCXCnFcNbjgH6LLhIxjn3DF2af4I/Z0Y5v6LwlnPBbUuhxwOQCIgC+0htMMXjjA0XzTYtl
 ctV4APbDdodeV5gVBx3LCYczkzbFfhA9lkYSnhA==
X-Gm-Gg: ASbGncsT6o0GNGcMxQIjk8Y4dJzEyKxr8QEWde6Cl8kNr33mvTPQj5nawwMYJX2avk8
 wtk1vrlpwoBO6D4HGgGpBHZkn8uz3F1cB1iwSBPF+lGcqeIKNt3CFxkxcf7g5eT+EpYf9GB8idA
 ==
X-Google-Smtp-Source: AGHT+IHtMGB8tGqyS7durOTMmTT+d1HFjjMOFKay8qdiJ4M7snDd7N6Auuotv763wh8FjBuLJCTTPcvyl51Nc62ITAc=
X-Received: by 2002:a05:6902:2086:b0:e5b:109b:2099 with SMTP id
 3f1490d57ef6-e5e245f7c7amr350796276.23.1740077668640; Thu, 20 Feb 2025
 10:54:28 -0800 (PST)
MIME-Version: 1.0
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-7-peter.maydell@linaro.org>
 <64deaf4f-b999-41aa-ae44-876a1860a10c@linaro.org>
 <CAFEAcA_upC=ty1PWXOSsHHgk67EoPi6rB2DhK2M5_q2mzUCW=Q@mail.gmail.com>
 <d7a0260d-5cdb-4e87-b12c-32e1dee4df1c@linaro.org>
In-Reply-To: <d7a0260d-5cdb-4e87-b12c-32e1dee4df1c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2025 18:54:16 +0000
X-Gm-Features: AWEUYZlOAq6rBLTWv8Eljdpxxbs3lHUGajzwQOq7bVKD0v0bJYO5rIjt69K0dyM
Message-ID: <CAFEAcA_uPWSgwpygQiSBzCLsBV+HH5Pun1E9RGw16Z3SMj4REQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] fpu: Move m68k_denormal fmt flag into
 floatx80_behaviour
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Thu, 20 Feb 2025 at 18:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/20/25 09:12, Peter Maydell wrote:
> > That suggests that we are correctly implementing the x87
> > required behaviour in QEMU, and so that the TODO comment
> > I add in this patch isn't right. But then I'm a bit confused
> > about what the code is actually doing. Why do we need to look
> > at fmt->m68k_denormal in the input (canonicalize) code (i.e.
> > to have different behaviour here for x86 and m68k), if
> > both x86 and m68k accept these pseudodenormals as input?
> >
> > Is the difference that for x86 we accept but canonicalize
> > into the equivalent normal number immediately on input,
> > whereas for m68k we accept and leave the pseudodenormal
> > as a pseudodenormal (well, m68k calls these a kind of
> > normal number) ?
> The difference is in interpretation: x86 ignores the explicit integer bit of the
> pseudo-denormal, m68k considers it part of the input value.  This gives m68k one extra bit
> of range in their denormal, which allows representation of smaller numbers.

Ah, I see. So I suppose:

(1) we should call the floatx80_status flag
"floatx80_pseudo_denormal_valid" since it affects both inputs
and outputs, and document it in the enum like:

+    /*
+     * If the exponent is 0 and the Integer bit is set, Intel call
+     * this a "pseudo-denormal"; x86 supports that only on input
+     * (treating them as denormals by ignoring the Integer bit).
+     * For m68k, the integer bit is considered validly part of the
+     * input value when the exponent is 0, and may be 0 or 1,
+     * giving extra range. They may also be generated as outputs.
+     * (The m68k manual actually calls these values part of the
+     * normalized number range, not the denormalized number range.)
+     *
+     * By default you get the Intel behaviour where the Integer
+     * bit is ignored; if this is set then the Integer bit value
+     * is honoured, m68k-style.
+     *
+     * Either way, floatx80_invalid_encoding() will always accept
+     * pseudo-denormals.
+     */
+    floatx80_pseudo_denormal_valid = 16,


(2) the comment I add in canonicalize should instead read:

+    /*
+     * It's target-dependent how to handle the case of exponent 0
+     * and Integer bit set. Intel calls these "pseudodenormals",
+     * and treats them as if the integer bit was 0, and never
+     * produces them on output. This is the default behaviour for QEMU.
+     * For m68k, the integer bit is considered validly part of the
+     * input value when the exponent is 0, and may be 0 or 1,
+     * giving extra range. They may also be generated as outputs.
+     * (The m68k manual actually calls these values part of the
+     * normalized number range, not the denormalized number range,
+     * but that distinction is not important for us, because
+     * m68k doesn't care about the input_denormal_used status flag.)
+     * floatx80_pseudo_denormal_valid selects the m68k behaviour,
+     * which changes both how we canonicalize such a value and
+     * how we uncanonicalize results.
+     */

?


thanks
-- PMM

