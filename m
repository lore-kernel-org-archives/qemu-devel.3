Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3222BC47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 15:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVCzh-0007Tz-MJ; Wed, 31 Jan 2024 10:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1rVCzg-0007TM-96
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 10:59:20 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1rVCze-0000Zo-2W
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 10:59:20 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-29041136f73so2921176a91.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 07:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1706716756; x=1707321556;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to; bh=2tYCQRNgAZqwKRtR7jgxEs9S4CMjsHb/RcxjBFK8bE4=;
 b=ggTQb7sdwBKiIKlUPvhXO/M8qfhPfQOU8wXfQDrKkmrhm20ThSUidltfjQToP7Ysix
 Mji16AIAq5/KGfBQurFhABfiehVvKt6lKyQ427bRkygrMIZP0j0l9JrfJtjzWKNTocSQ
 x1z3A56AFyUhlIaBlAJxYaq7iTbqo1y0cEYzUu0XJjuZje3vjWopjLFCq+GS6IyaXgdx
 pDXwLQVlS9XsDVDQT4TbP0zNXrgD8JMzJSNhMt3tLIibbKoa4/LftV2TGFET7woDrNIu
 qXzwtjM4m0uAII/C+NEDqqYjZjyYjQvndSEat1AiYi/l0NBrsr6eN4Tfi2IeI35aSw47
 CM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706716756; x=1707321556;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tYCQRNgAZqwKRtR7jgxEs9S4CMjsHb/RcxjBFK8bE4=;
 b=P19u/fMi2Aom89koBeNU3WSiNb1XjIBdWvEFGT7+ETDJ4/OrqCECmukmO7z7nBEOTI
 4ypDyygGettXCk3Xo26sOmaakz4poWmkLqyopvt6hsRuZAWCP8T4+wwUkmvyQD8rj/Og
 rFxGQcvW1w0Krc8UVFErAQRubrkW6dgnmQ07cKj3DPGuc0wfvGdDb5ykfdnkYfiUuxJ3
 UyNwF4D3Zk6GfrLmez0jXqQnq08qnaE/jkWjYDgq0BUEnrguAE1wSapUHtVvRYFQ9fgj
 QAVza1W139g0UDAvZNX4HAW6kBUXwsQcL5mNp9vOPEo+zRZMcWZ/0li5tqP8LNOlsTud
 +axg==
X-Gm-Message-State: AOJu0Yym4atJ8FCakPc3VeYBcEUFkwZfKF0U7X18vvzglehIt/NVt1Tk
 i//Q83Bfj2RiIDH4JKcdKvS8oo2VKXS6hg6YAXZDhXbmYl454gG6rnVK5mTmtLI=
X-Google-Smtp-Source: AGHT+IHkLqmeGopJwus/JjJcG+C3kOqqtllRCvELNYYwCNkT3Oml8KMueADzCsoiV4D/rVxVuAdu4g==
X-Received: by 2002:a17:90a:c7d2:b0:295:eeb7:c53f with SMTP id
 gf18-20020a17090ac7d200b00295eeb7c53fmr1418541pjb.5.1706716755728; 
 Wed, 31 Jan 2024 07:59:15 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWrNcIeUGJOTfQmB+PDhthnU0br0AGbtk4a6ou4Op9RvT/6EO5sV47AXaCjah6VOgKXMjp03JwJSGmQ+Qz2+Ogkth74YAWUv5uSBhSV0PbzuvEu3akAQmCzLpS2UKadLpOTD9gyxCK0unPXGXZhs1UckYsonAkZtmGTuw8IJyU9B0NShYMIpaXahpFiHQvHSJvPjL9qPZVZBCVp3AOkk2EBw34T8C+jboe5koJgqRO875alxLiUVG/w0vV9nVfd+t/+LzRwFa9xHLTcHwreKC2ygFjwPr1wUmvQ/Lze+EjeUoiAadEX5TLEWuG9AEZUHbhMVaNxtt8KbHqlNs5YBAG4u2gxGaQrH5/FMdQlM8um0tqJbqReMbdXbmx5LefN7pkVjC3yL9zO/U7Rk9lZMgJzcSV42o1ilbZwSY/y92lC2ugJ6SoUNabz0IpQmwu+Ui4trayE/rZlHY/NuRlEdO8zO9vx2EcwQpTiYflYzTRHqY+rRDwqLxaivGe7u9IkGPYts39TjlfxCa9FxZ/o/KblS2QRdXxGev3Pt6NHQTEG4DROCglxId90tnIXH9O/PXDW4lY60Qa1x7LlG/igclHsJUbZAyw8QPcuoAPXdxgNiSnnZSrjSeukzzo5EIZ6K2I/qjY0JRe6fL4=
Received: from localhost ([12.44.203.122]) by smtp.gmail.com with ESMTPSA id
 nb4-20020a17090b35c400b00293d173ccbasm1679314pjb.52.2024.01.31.07.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 07:59:15 -0800 (PST)
Date: Wed, 31 Jan 2024 07:59:15 -0800 (PST)
X-Google-Original-Date: Wed, 31 Jan 2024 07:59:13 PST (-0800)
Subject: Re: Call for GSoC/Outreachy internship project ideas
In-Reply-To: <CAJSP0QWE8P-GTNmFPbHvvDLstBZgTZA7sFg0qz4u28kUFiCAHg@mail.gmail.com>
CC: Alistair Francis <Alistair.Francis@wdc.com>, dbarboza@ventanamicro.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, afaria@redhat.com,
 alex.bennee@linaro.org, 
 eperezma@redhat.com, gmaglione@redhat.com, marcandre.lureau@redhat.com,
 rjones@redhat.com, 
 sgarzare@redhat.com, imp@bsdimp.com, philmd@linaro.org, pbonzini@redhat.com,
 thuth@redhat.com, 
 danielhb413@gmail.com, gaosong@loongson.cn, akihiko.odaki@daynix.com,
 shentey@gmail.com, 
 npiggin@gmail.com, seanjc@google.com, Marc Zyngier <maz@kernel.org>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: stefanha@gmail.com
Message-ID: <mhng-125f45c7-5a14-4c91-af16-197a4ad2f517@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=palmer@dabbelt.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 31 Jan 2024 06:39:25 PST (-0800), stefanha@gmail.com wrote:
> On Tue, 30 Jan 2024 at 14:40, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> On Mon, 15 Jan 2024 08:32:59 PST (-0800), stefanha@gmail.com wrote:
>> I'm not 100% sure this is a sane GSoC idea, as it's a bit open ended and
>> might have some tricky parts.  That said it's tripping some people up
>> and as far as I know nobody's started looking at it, so I figrued I'd
>> write something up.
>
> Hi Palmer,
> Your idea has been added:
> https://wiki.qemu.org/Google_Summer_of_Code_2024#RISC-V_Vector_TCG_Frontend_Optimization
>
> I added links to the vector extension specification and the RISC-V TCG
> frontend source code.
>
> Please add concrete tasks (e.g. specific optimizations the intern
> should implement and benchmark) by Feb 21st. Thank you!

OK.  We've got a few examples starting to filter in, I'll keep updating 
the bug until we get some nice concrete reproducers for slowdows of 
decent vectorized code.  Then I'll take a look and what's inside them, 
with any luck it'll be simple to figure out which vector instructions 
are commonly used and slow -- there's a bunch of stuff in the RVV 
translation that doesn't map cleanly, so I'm guessing it'll be in there.

If that all goes smoothly then I think we should have a reasonably 
actionable intern project, but LMK if you were thinking of something 
else?

> Stefan

