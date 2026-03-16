Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DA5F4645E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 12:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w26pU-00020F-LS; Mon, 16 Mar 2026 08:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1w26pR-0001z5-FL
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 08:13:49 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1w26pP-0003bS-Pp
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 08:13:49 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-8cd90401034so482974685a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 05:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1773663226; x=1774268026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u0gaU/PZ7K2uE4jupvy5A1zor4R/fJ+Y1/cbTlF7XDY=;
 b=CCp2oK8hqQ3AwTacciifE40GourkuRkuBXNVuh6R9rZetBpxZ4IFIGlP7sd8qz11Ag
 LE/G6/9M/34vjXiASQbCzpdZ9xDbNDajnyJzoMOoujmzbc1K2HYYSjT4wXGGJbU95L/5
 iocWsr58vGeCmkMzZZlK3JsLE1Tu28fbpCs2tS9hcrF6nFx66lZH4WVhg6TWVy3UAUoW
 me/wk3LHYLzjqpsli0i64QJXqT1R8VHTx/N9g4kpnF6nhiTtoDZS6nivCJyIOBhGDky8
 FheaaTG/A2x2n7DfVJCfprDdfe2Uqp5imTnpm4NKc1Yqp9tsE9ZoCCTyOP/2DG0FnCwq
 MSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773663226; x=1774268026;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u0gaU/PZ7K2uE4jupvy5A1zor4R/fJ+Y1/cbTlF7XDY=;
 b=SoUFxN7j36+pnR/nKJfhYYxEAA9br6jDldJTBn05fBomlqWSLqAfZjAYe7z+JTZv/d
 m/a7Pzh9wpZN77JrWjmYHOnIsQZofsseBT5jCm58DX6ixGfTr7pkQgNgrCinaCe19eIJ
 OgeFpO0BdSsF540R/ss4ofXT8WS4beYK1NXXnw4yrbCFx6HRMSwJ+nBLSWEqMyxEigS1
 SfxhxbZQirLn/Ly9X+IozRfmuzh0Pq4YH/8+NcYD6kdkQrMyxszQJQjLrR2uvypcbZ3v
 GRyWQUeHwrdA+MrS/RfazrKYH/EOMkqHKUgyrKTjjyfF3fPeY6pljLinM9qWnG0F1ve3
 69sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY5o+/f3jFsPm8X5Wv/NeRoj3/0QcAgMcg9SetkiZ0Sdq6zNfIo8B8gs2VCjFvBSNVXvHCXF+yQll3@nongnu.org
X-Gm-Message-State: AOJu0YyMuVkw/BC0ckC9ISh3uXrhJC5LH/tewUTBoq1dDvvBuBUIVrqy
 RFY+qfjmODZkTXocQ7x0ziBUYnp/1gR5YYNS9nTARkvQQSVA9GpQdBup0HgHwU0orCk=
X-Gm-Gg: ATEYQzxYrTLXooM91LE2H6G9RFqSrihu1V+KQOuXmTG1t37Wwy/OvMkxhRPIvtHJufu
 DzsTk38CSgydrwD6ZG1pz8+LBB78vhn2cv0xdNxoG4Gnlx86imlYA7JWgQeXPPn/9lmaAFlfQ3R
 kjbcAX5IToWFtU6z8LQqskAsQZfmVKDzzPuMumsMgrm63RbfhVgIThjIn7KiF5man0YY/txoPtU
 GrV0Yzuct8cdQ8QI7NAWnxei6beSBdDiBpTB5bd+Ry5Rqhr/ASC1D217GUp7IWmTSfPlHgejrpi
 5Gpw9KxhxBMDKl1fGuRZwyu8rVdN8UY2ays+txfj4HCps6uxvyAQ4nYkANWKe+buqxWB0JnonJ5
 lIfCNdifF+6FJ7CIZkAoKdeidFfGEuX10V4Qm+f8fZ/E9Dmrso8Rflmm33WknjONP9BIrWZrwzq
 iTe995AR3KG5ULjd8LmDcAdDWaA6Vq7En8hT6UIQJolLm+hRbOLdWM
X-Received: by 2002:a05:620a:4095:b0:8cd:75d5:5456 with SMTP id
 af79cd13be357-8cdb5b70723mr1673839685a.66.1773663225807; 
 Mon, 16 Mar 2026 05:13:45 -0700 (PDT)
Received: from [192.168.68.100] ([152.250.131.163])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda1fd6325sm1179396085a.11.2026.03.16.05.13.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 05:13:45 -0700 (PDT)
Message-ID: <2283b27e-2916-4d0b-841a-744ffc366f14@ventanamicro.com>
Date: Mon, 16 Mar 2026 09:13:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] target/riscv: Don't leak general_user_opts
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260313182957.28432-1-farosas@suse.de>
 <20260313182957.28432-4-farosas@suse.de>
 <CAFEAcA-2mcfjsngURah2jGvz0kib+-JYCGWjUPGWF8W262HJYg@mail.gmail.com>
 <8e124f96-b6c7-4e9b-b11e-f0f3e387eaf4@ventanamicro.com>
 <CAFEAcA8m9gq+5paC2GxDZeS7eO-49+VOoF1sjbZ3sCndu49FyA@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA8m9gq+5paC2GxDZeS7eO-49+VOoF1sjbZ3sCndu49FyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qk1-x733.google.com
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



On 3/16/2026 7:49 AM, Peter Maydell wrote:
> On Mon, 16 Mar 2026 at 10:42, Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>> On 3/16/2026 6:56 AM, Peter Maydell wrote:
>>> This doesn't look to me like it's sufficient. These hash
>>> tables are used to store the values of CPU properties.
>>> Those are per-object, not per-class, so surely the hash
>>> table needs to be in the object, not a global ?
>>
>>
>> This hash is used as a hack to determine if a QEMU command line option was
>> user set or not (i.e. a global setting).  Back when this was introduced
>> (and I assume this is still the case today, need to double check) the command
>> line support in QEMU didn't provide this information.
>>
>> Most QEMU targets don't care whether a given CPU property was user set or not,
>> but the RISC-V target has a lot of code that automagically disables stuff given
>> certain conditions (e.g. riscv_cpu_disable_priv_spec_isa_exts()).  The result is
>> that we were reaching situations, Gitlab bugs being opened and what have you,
>> where the user was doing things like this:
>>
>> qemu-system..... -cpu X,extensionA=on (...)
>>
>>
>> But so it happens that extensionA isn't compatible with the existing extension set
>> in X.  The behavior back then was to disable extensionA during realize() and be
>> done with it, leaving users baffled and frustrated with their cmd line settings
>> being ignored.  Now we're able to error out in these cases.
> 
> OK, but why does this require the hash table to be global? This sounds
> like it's a per-CPU thing: if I have two riscv CPUs and one is:
>   cpu 0: has extension X
>   cpu 1: has extension A, not extension X
> 
> that's fine -- A conflicts with X but we don't have both of them
> in the same CPU. With a global hash table we have no way to distinguish
> this from "one CPU with both A and X".
> 
> I would have thought we only want to error out if the user sets up
> a single CPU with a conflicting set of extensions.


In light of Phil's efforts w.r.t single binary QEMU, hybrid targets and etc, I
agree that this hash table should be an object instance so each CPU can have
their own extension set.  Back then the scenario you described wasn't something
we were concerning with, thus create multiple instance hashes with the same content
(since all CPUs would always be the same) seemed too much.


> 
> I'm also not sure why you need to care whether the property is set
> by the user on the command line or by the board code with C code.
> If a board or SoC model tries to create a CPU that has both extensions
> X and A, shouldn't that also be an error that we want to bail out on?

We have too much code that enable/disable extensions and chained dependencies
under the hood.

Let's say you have "-cpu rv64,extA=off,extX=on", i.e. disable A and enable X.
But X has a dependency of Y, which has a dependency of Z, and Z requires A
enabled.

So now we're on realize(), see extA=off, we disable A.  Then we go to X, figure
out that we need to enable Y because of it, but then we need to enable Z, oh and we
need to enable A as well.

In the end we ended up enabling A because it's a 3 hop dependency of Z, and now the
user is confused because he demanded A disabled.  And why wouldn't we enable A?
The default state of extensions in TCG is off, thus there was nothing to tell us if
that particular extA=off was something that the user demanded or not.

And this is how the hash table to track user opts business started. Keep in mind that
we have 148 extensions (and counting!) to deal with.  Users aren't able to track these
dependencies and get frustrated when QEMU doesn't do what it is told, and they were
going to Gitlab letting us all know about it.

Maybe the right course of action would be to claim that the user command line was bogus,
QEMU did nothing wrong and call it a day.  And maybe, now that we have profile CPUs and
people care mostly about them, we could remove all this stuff from the code and let
users fall in their faces with bogus cmd lines.  I have plans to simplify some things
(mostly the distinction between CPUs types) and might touch on this area too.  But
for now this is where we are.


Thanks,
Daniel





> 
>>> There are also other hash tables in the TCG riscv code
>>> with the same problem (using a global variable to store
>>> property info that is per-CPU, not global).
>>
>>
>> Not sure which hashes are you talking about but there's a high chance that they
>> have to do with tracking QEMU command line options that were set or not and we
>> want to know the difference.
> 
> riscv_tcg_cpu_instance_init() calls g_hash_table_new() for
> misa_ext_user_opts and multi_ext_user_opts unconditionally.
> 
> thanks
> -- PMM


