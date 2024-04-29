Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7D9C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1SBQ-00084E-CV; Mon, 29 Apr 2024 10:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s1SBM-00083z-PT
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:40:42 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s1SBJ-0005XX-Qr
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:40:39 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5afbd1c3ffeso152775eaf.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 07:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714401636; x=1715006436; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3WN628YGxItChdkbnkALdWrVvJ3ZzH0wqKObfW8to5s=;
 b=kQ05qw26/bCRu57em27GTXPozaumY0IIKesqUTS3tNnwEl3B9gkrqZEkgf/Kgv7gL/
 yb2MHq1tt+LfLm018Nakcv6vvIbVO+rsUaIn1S1MLgWzRxbZhVbeVxMKPVTS9I34uFpa
 Z+HebKGXNQBDnlH1lwfkvW/pqMCubXq+sbeFS+/GlCuLBEvu0yIwU/C4xSbd9SYFmZ5y
 xHiL9+ho/hGDLYUGiWu5c2dSjPn2cBy+hESxqEptNVTy91p9wZcPwARIJuzIw+pJ7BsU
 sIjKp5tZcYl0TCnOzvIL/DQad0WEYP6muGVi8TCtJd50cjQNDdMrfev24BxB3TMYGvwP
 pRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714401636; x=1715006436;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3WN628YGxItChdkbnkALdWrVvJ3ZzH0wqKObfW8to5s=;
 b=Q06arqDEeM6eFhTIyRCal5qj+WFcJKVRIVEHS1WqSkJTdd4mr9Y7n/tLwOt7twmVnh
 h/HCj3CDwIQ5D17kXNHh9RwpuzOBXm6ihihlm6kFO+rMJyi8FjjmNw4McxivAp7SbtYz
 wcUmwckH3QZ4kq1G6gcvhA7nZ1FRmaEEZ+JdZQso0JXdKd3bLDrQ8VWI6F4yxG6z0FmY
 Su7udU8W+1//dtRlEZ0pKsNG4gW0qPIWq4+eH7JxqGgYaGDUfoup1GtXMWMz7YsIKGtx
 ZTrbzjzcDpXW2wlNQxpsSyZCjVnYv9pLjDUXK5IBROsHMYO4LSB8TfFHqYOqHGD23QB6
 keNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7Fh4nZhbHO8ERbg7lowPxvM/sfKXSWL1h6WVqlkVHH4YaHdD1MShK+ziabxL6Q90eZRozxOKH15BEX1ZHq7KY6X0K6Gg=
X-Gm-Message-State: AOJu0YxUly4qWoB6/U8wEyO/9zMR8RYIJ5huL4epDdR4OtXDPxtVl1b4
 UwUyCnKMmLjG0xHQBdiqCHPv51/W3ueWeZOOCSw22HETN7Pkggq+
X-Google-Smtp-Source: AGHT+IHLZu8+CNvbdqD5eONvjuCYL/Olz9QWE4+pqrp+TuZcGcn9f0G+5oefCV4/warXSLlOJPaa3Q==
X-Received: by 2002:a4a:e6cb:0:b0:5af:73be:72ce with SMTP id
 v11-20020a4ae6cb000000b005af73be72cemr12520703oot.0.1714401636063; 
 Mon, 29 Apr 2024 07:40:36 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:8080:1f00:9c00:2639:f689:1715:fc7b])
 by smtp.gmail.com with ESMTPSA id
 v23-20020a4a3157000000b005af4ecbcc5csm2377725oog.29.2024.04.29.07.40.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Apr 2024 07:40:35 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Matheus Tavares Bernardino'" <quic_mathbern@quicinc.com>,
 <qemu-devel@nongnu.org>
Cc: <bcain@quicinc.com>, <sidneym@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>
References: <c7af62451b02ffdc1d68bc00093b40a8080bc3ff.1714155331.git.quic_mathbern@quicinc.com>
In-Reply-To: <c7af62451b02ffdc1d68bc00093b40a8080bc3ff.1714155331.git.quic_mathbern@quicinc.com>
Subject: RE: [PATCH] Hexagon: add PC alignment check and exception
Date: Mon, 29 Apr 2024 09:40:39 -0500
Message-ID: <028d01da9a43$3503f8b0$9f0bea10$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJzRyC/evNEDGnzkOUKIb6QtlGw1rBN8+vA
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Sent: Friday, April 26, 2024 1:16 PM
> To: qemu-devel@nongnu.org
> Cc: bcain@quicinc.com; sidneym@quicinc.com; ale@rev.ng; anjo@rev.ng;
> ltaylorsimpson@gmail.com
> Subject: [PATCH] Hexagon: add PC alignment check and exception
> 
> The Hexagon Programmer's Reference Manual says that the exception 0x1e
> should be raised upon an unaligned program counter. Let's implement that
> and also add tests for both the most common case as well as packets with
> multiple change-of-flow instructions.
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---


> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -473,6 +473,7 @@ static void gen_write_new_pc_addr(DisasContext

You haven't added the check to gen_write_new_pc_pcrel.  It's not needed
there because the encoding guarantees the target is always aligned - right?
However, there is a call to gen_write_new_pc_addr inside that function.  In
this case, we'll add a check that isn't necessary.  Consider adding a
parameter to indicate if the check can be avoided.


> a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
> index f839b2c0d5..02d7fff34c 100644
> --- a/tests/tcg/hexagon/Makefile.target
> +++ b/tests/tcg/hexagon/Makefile.target
> @@ -51,6 +51,19 @@ HEX_TESTS += scatter_gather  HEX_TESTS += hvx_misc
> HEX_TESTS += hvx_histogram  HEX_TESTS += invalid-slots
> +HEX_TESTS += unaligned_pc
> +HEX_TESTS += unaligned_pc_multi_cof
> +
> +run-unaligned_pc: unaligned_pc
> +run-unaligned_pc_multi_cof: unaligned_pc_multi_cof run-unaligned_pc
> +run-unaligned_pc_multi_cof:
> +	$(call run-test, $<, $(QEMU) $< 2> $<.stderr,"$< on
> $(TARGET_NAME)"); \
> +	if [ $$? -ne 1 ] ; then \
> +		return 1; \
> +	fi
> +	$(call quiet-command, \
> +		grep -q "exception 0x1e" $<.stderr, \
> +		"GREP", "exception 0x1e");

We should also test endloop instructions.

Thanks,
Taylor



