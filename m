Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE0AFD88D4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 01:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w08aT-0001Y2-Nt; Tue, 10 Mar 2026 21:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08aK-0001U7-10
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:42:07 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w08aH-0006OR-FW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 21:42:03 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-8cd78a4ce8dso494039585a.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 18:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773193319; x=1773798119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:autocrypt:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2BE3AUNIINDYc+tYjNIEEmAuAQPk6dAGTez1Ow7YGUg=;
 b=nXC1gJXX1+k6/K9/XEmURnlkgyOgiC6VIu9NWAKPuCPy5xZMBdQa3mVXIc/ibK7hnv
 QJke1acwPcKlc3aHY6KzQXaVZhNt1fHqMKuFRM3hKU3wBii/2TXLZvi5B4WFOhx7hKEI
 hdXGYoQiG0gxARK1sMXqv/hYg9ZIzWi99GCkn+fsmgZFwjdix7wQZaU1kCdW3scfHhMv
 +tjXg9JyL4nfL49Iedfricn6vOKwkxTrglUe2BRKEVmgWt1OPuPZy+3tWRH2H+iHwwc2
 iNJtC4qLz217Vwk+4GHW0kEyoZMCCj8qYos1AejM8jU9YdeF9H9hJpSIv73qa/wcSD7n
 sLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773193319; x=1773798119;
 h=content-transfer-encoding:in-reply-to:cc:autocrypt:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2BE3AUNIINDYc+tYjNIEEmAuAQPk6dAGTez1Ow7YGUg=;
 b=IXOmp6rxLHjI2Z+R62ldLJvL7EkXHdrQi3x5e6cKxSjmqVJxewUkH2OhtRy3ZkGnu/
 ws1ErdLVYRtX5JPX1yeXoPHBejicqEMND5Tf3P0B46i+yIURJ/alofcfGBmxmyw4DiWY
 yzyE7q3PEWNwrQvIUj7zf/UxzCwkBhTkM3gk/tpO9t0sEOp86D9y9SZ2tUcjCfBQze1o
 F5W/rX5UMbvqRH9COR9usvJyiUz9vY5pIt2FjJ0f2XjHBqvtfaZnsdjqvDl6JQbuJeWQ
 Y+0+l7K0PWlhjL7nHSSz+ChZFHlvfJt88fACEDA2xmjZoOFttelGfz3+anlTpY1PLRWz
 +INg==
X-Gm-Message-State: AOJu0YweyVr08pvDUa9M8RdsKAD26YGvs43nvewSVOW/jB8UTWS1mEkE
 w49WbnEOX2SIKPf9EfSsNt+4h8L0z54O/OvRPG+HZdtVa0KMYpIQa2uOlaqSyeMCl9THA4XD0dR
 G557P
X-Gm-Gg: ATEYQzyXw2gmQ0UbWWP5EPGytPRe7WBPPoFwpCM3tfH4hjDeBOOVkmi+J/nhgYbb6oe
 axIgPjng/geQQokKQE/u+zEG6UbPXAUBDsQfnSxSK61/mIrdhJjNmCqR7Fnql1qM4adqdhTYHWW
 tEvdIvR1ZaI2CGNzPjq3TcU869HWubPtZtio1lW1fv+nitNMV+qoa8mTZLwk5IPdyEB9/OMivL4
 JVX/oEdpVUJ22dPHqbCaUO2cfmlLGss2OCbrH1/QcgTRWYk1j2gKEH1rrsrE2OPBkq2bGgkB/4o
 e5UcStaVsd6YZX3t4Fflwhe49IsdvM1ZJRD76uKDYqVIZYirONGQ0AKpNjQVv4aCZ0DH5EjxMAD
 CTiZEDbcHLq1r2bX+EqjUlBesmnnus+FWf4gHzeulVl/OIFjIew8VJTJuBNOdQS6vp/TcH+5IPE
 7j+EyQe/T3S4rp29u+ctTbalQQsBtDMLuptLUbjKl6CJff7E8ADkv71OEkPgyn7QG1iRcyj/Snh
 UkNpEo=
X-Received: by 2002:a05:620a:1903:b0:8cb:3df5:4b6b with SMTP id
 af79cd13be357-8cda1a56377mr131834985a.61.1773193318842; 
 Tue, 10 Mar 2026 18:41:58 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda21348e2sm40397285a.35.2026.03.10.18.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 18:41:58 -0700 (PDT)
Message-ID: <6ea61ae5-0a83-4279-8a8b-897a162d54a9@linaro.org>
Date: Tue, 10 Mar 2026 18:41:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] gdbstub: Always infer base register index from GDB
 XML
Content-Language: en-US
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
In-Reply-To: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x72c.google.com
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

On 3/10/26 6:38 PM, Pierrick Bouvier wrote:
> The following changes since commit ae56950eac7b61b1abf42003329ee0f3ce111711:
> 
>    Merge tag 'firmware-20260310-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-03-10 13:32:30 +0000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pbo-linaro/qemu tags/pr-gdbstub-20260310
> 
> for you to fetch changes up to 6511d4eed79a7e59f03e661f31924277e4d6e600:
> 
>    gdbstub: Generate a single gdbstub-xml.c / gdb_static_features[] (2026-03-10 17:12:18 -0700)
> 
> ----------------------------------------------------------------
> - [PATCH v4 00/16] gdbstub: Always infer base register index from GDB (=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>)
>    Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-1-philmd@linaro.org
> 
> ----------------------------------------------------------------
> Alex Bennée (1):
>        tests/docker: add gdb-multiarch to all-test-cross
> 
> Philippe Mathieu-Daudé (15):
>        tests/tcg: Temporary disable multiarch tests for PPC targets
>        tests/tcg: Disable prot-none test on GitLab
>        target/i386/gdbstub: Remove stale comment
>        meson: Restrict gdbstub to user/system builds
>        gdbstub: Simplify gdb_init_cpu() logic
>        gdbstub: Add trace events for around XML parsing / generation
>        gdbstub: Have scripts/feature_to_c.py generate more verbose output
>        gdbstub: Make base register explicit in m68k GDB XML files
>        gdbstub: Remove @g_pos argument in gdb_register_coprocessor()
>        gdbstub: Emit base_register index in GDBFeature entries
>        gdbstub: Consider GDBFeature::base_reg in gdb_register_coprocessor()
>        tests/tcg: Re-enable disabled multiarch tests for PPC targets
>        gdbstub: Remove 'gdb-xml/' directory prefix in TARGET_XML_FILES
>        gdbstub: Move gdb-xml/ within gdbstub/
>        gdbstub: Generate a single gdbstub-xml.c / gdb_static_features[]
>
Send this PR for Philippe, as it's the last day for soft freeze, and 
that it's already the middle of the night in his timezone. We tested it 
together.

This series fixes original issue reported here:
https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/

As well, it enables gdbstub tests that were never ran in CI since 
gdb-multiarch was not installed.

Regards,
Pierrick

