Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023A0104891D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6W0-000756-8S; Fri, 27 Feb 2026 17:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6Vy-00074m-SN
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:40:54 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6Vx-0002yw-2A
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:40:54 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43992e14638so2504479f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772232051; x=1772836851; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YQlabin62Sw+Bdpj0u8UxxKXzV+FcZUgAiroO0KTX84=;
 b=QQAxKcq3HlIVZZnPGSNnKNKggWvIN4YnVfgIWvVZb8YYMEa+cu6SAIG++WCECz1Nxw
 KdEAfykwyebAgcKoijJ54t1Xv8Mp82qvCLa8c0/YHafCk/7eacXPgCvPXjGqbGCDilag
 ajecazR3gF/rruN5QLe66U1sHs5ELZVZ0XIErp+m9JJnHQa1XGZtar7M80HgguYuBH7r
 SCnzop6INhhZijA48LR6JXGR4LzRO+OJX9eO/z1QiEZ2gR3u8vbCBsnox9C+iPe7Maz7
 21xykNabIhIzvPt6P8aHo76VhuTbQSYP4dJr15bSFegVvv5vTiDU3vhafjTqMR3lklDb
 +b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772232051; x=1772836851;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YQlabin62Sw+Bdpj0u8UxxKXzV+FcZUgAiroO0KTX84=;
 b=LxkQml92RLRRKfYHbWomxRVFXmLWpBc0wufxDeJ1BoKWrhmj1LHjpctLfhwoNMkRwr
 CjxKlTX7lEZh8QOHe5CtWVvgb8HN8ywrr7k4RRfWbhutooL4e6B2K98t1ar/iI2tmUpZ
 7EET+Qfxpqi3lxYWcq3G+cQ6uXSWrEvjGAnM5G7tLmwRCJAl+Odyx6P/fX+RlgZvGYdM
 YSF8bIv+jWIj4vlUnvfPQ1kPpIPPUgdsifXorUTMcKg9RDSAgDG0G1ucLHHUiiLFtoIO
 1dGEK/L8fvy0cKuDH2Hw+92pcxzFV2HDOD6jlwhzHjShjPBqTAn/EcN3YGazaM+zV2Av
 EEAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDPlIsDWN+hhSLtj7sVfAWG8ujvR6MdyHFn0TVaj3MA7tUWLmSGkmH43m/RlBZlG1f2dybYMGDuz9m@nongnu.org
X-Gm-Message-State: AOJu0YxOjFFpVBd/aZu4s9eD04/hNObt9uoCpIRjTpoUGGf6a2FDUEkC
 /y9Ef0h+C/MKNijd3sxnvCj1aeKlhwWPz3hH0CmcmCwBjN/kSK96oH6tnbIA3SO23wo=
X-Gm-Gg: ATEYQzwoyEAUrqa+E0Idn+L8wQNokkrCtIMxa3ZIgB/lQ9S3ADZyNw+dYjxx9eoDtIR
 QUCpMTtpTi6DPe+gqnJOhVXZbDFuLgiMc1BcwaGIL0Diax8L3pHtjitBkgB2AhnJEjUIpu1TusH
 21SjJAoVqmHSP/fimUn4/xL4g1axsXTgyfzEQUovfIyJC/raYMxfMYXCf2UYy12i30xG96pXZ6E
 rOkfOH3yKU0f+liapbjENkQz/u8R/xm5v9nI6DztmEQqPkq9fOu2cwO5MMjRRYKmB+4oaOsRwsb
 8DMedMisHUlqAdxJo18VSTQE7VCv2y0qIWXrvygSDv8bMLJlt2E4EfElb24zfWQoKDHpj2VgOZ0
 y7LcbDAXOT8oiMe7vg76oPyzc1q3bmLUilKV8sg4AuaXyAUjfQ/txHL7XbHbVjq3BAqI/jDkZpy
 dNrY3/XUrZcq18AwetPeQ7VFhhsjgQq1bip+1zbmtlCNT/DvCH+fMWufQD4ndRCpUF/w==
X-Received: by 2002:a05:6000:3104:b0:439:912d:1e28 with SMTP id
 ffacd0b85a97d-4399de36cf7mr7642591f8f.57.1772232051227; 
 Fri, 27 Feb 2026 14:40:51 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c38sm8346000f8f.31.2026.02.27.14.40.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:40:50 -0800 (PST)
Message-ID: <d3e10484-681f-4f99-94d1-3e067440809e@linaro.org>
Date: Fri, 27 Feb 2026 23:40:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] Add RISC-V big-endian target support
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Conor Dooley <conor@kernel.org>
Cc: Alistair Francis <alistair23@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <A02120BF-779D-4B2C-B29D-A9CB044EA895@unpredictable.fr>
 <CAKmqyKO6ioRt+h_tZrudbriv-QDVsOG1LNJ+GFQJ3ZO-fEhjiA@mail.gmail.com>
 <20260226-hangout-satin-fd7913f18f2b@spud>
 <CAKmqyKNST9ExmpcFE3iejmzZZRtMNSiVXkzfUK4GhhcketrCEw@mail.gmail.com>
 <de767b4f-93f2-47b1-8813-d1c063a30759@htecgroup.com>
 <20260227-dandruff-chemicals-4b3d22ca6354@spud>
 <e18fd3f3-30a7-4e19-ac54-b4caf68ee9fe@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e18fd3f3-30a7-4e19-ac54-b4caf68ee9fe@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Djordje,

On 27/2/26 15:24, Djordje Todorovic wrote:
> On 2/27/26 13:56, Conor Dooley wrote:
>> On Fri, Feb 27, 2026 at 12:42:21PM +0000, Djordje Todorovic wrote:
>>> On 2/27/26 01:56, Alistair Francis wrote:
>>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>>
>>>>
>>>> On Fri, Feb 27, 2026 at 9:47 AM Conor Dooley<conor@kernel.org> wrote:
>>>>> On Fri, Feb 27, 2026 at 09:30:00AM +1000, Alistair Francis wrote:
>>>>>> On Wed, Feb 25, 2026 at 9:39 PM Mohamed Mediouni
>>>>>> <mohamed@unpredictable.fr> wrote:
>>>>>>>> On 25. Feb 2026, at 11:20, Djordje Todorovic<Djordje.Todorovic@htecgroup.com> wrote:
>>>>>>>>
>>>>>>>> This series adds big-endian (BE) RISC-V target support to QEMU,
>>>>>>>> covering both softmmu and linux-user emulation for riscv32be and
>>>>>>>> riscv64be.
>>>>>>> Hello,
>>>>>>>
>>>>>>> There’s no Linux RISC-V big endian. Maybe the right thing to do is to not
>>>>>>> support it unless we’re sure that it can get to Linux upstream (for the linux-user mode)?
>>>>>> Agreed. We really need upstream Linux support before user mode
>>>>> On that front, Ben posted patches for it and Linus was really really not
>>>>> enthused when he became aware of it:
>>>>> https://lore.kernel.org/linux-riscv/066d70c7-b0a7-45e5-9337-17901bc95664@codethink.co.uk
>>>>> Even without Linus' take, I feel like there's absolutely no chance of
>>>>> upstream support without meaningful shipping hardware that requires
>>>>> big endian support, because basically everyone else was also opposed to
>>>>> adding it...
>>>> Yeah... I saw that.
>>>>
>>>> A few thoughts, just because Linus doesn't like it doesn't mean QEMU
>>>> can't support it. But I am hesitant to support BE considering the lack
>>>> of ecosystem support everywhere else.
>>> Please be aware that MIPS will ship hardware based on riscv BE
>>>
>>> soon:https://mips.com/products/hardware/i8500/
>> Not the meaning of "hardware" I was using, as this appears to be a core
>> complex IP rather than physical hardware? Do you know of any devices,
>> outside of a MIPS test chip or w/e, that are going to use this IP?
>>
>> On the linux support front, the devils advocate take would be that
>> people should just run this core in LE mode, but that's a bridge to be
>> crossed when someone produces an SoC using that core complex and on
>> another mailing list!
> 
> Yes, you are right, the i8500 is an IP. And I can share for now that
> QEMU and FPGA
> 
> board with the i8500 bitfile are the targets for testing of RISC-V BE
> software.

Just to clarify, as explained by Thomas elsewhere in this thread, we
are not opposed to have QEMU runs big-endian RISCV cores, and indeed
what guest runs shouldn't be a blocker (Linux support is convenient
for testing, but as long as you provide any other guest firmware code
we can run, we are happy). What we do not want is to add a new binary.
Endianness is a runtime variant. If implemented correctly, the current
binaries should be able to have the HARTs running any endianness. See
the recent changes in qemu-system-microblaze for example. Other targets
are going to get their endianness unified (but it will take time).

Regards,

Phil.

