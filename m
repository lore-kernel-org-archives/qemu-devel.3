Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775E9E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 11:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWCrl-0003Iu-4r; Fri, 10 Jan 2025 06:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWCrj-0003Ic-Jc
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:07:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWCrh-0003KG-3g
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 06:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736507263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sO44nZBLu0p6kJCOrykrWaO05+eJcPWGJw8Kv1uRJqk=;
 b=Ayvl9Us+STYn4mbfF+9BW7uZNdnZtbfylh6q2NoG/sHlCftZZ0Lf/gXjmr1kRTUa2DPp2/
 0O2/ZP1rD/lAiEpgi3ZFUleBlq+u41cIZ5Cbt0EMZQH1TJ0jjRMlSoJb+xV6LKzV1ouxq1
 e/VBoYxYtbAwWqpdCGKf+1fy0wGwGyE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-VfGYMHLaNjiYgYPgTrIhgg-1; Fri, 10 Jan 2025 06:07:41 -0500
X-MC-Unique: VfGYMHLaNjiYgYPgTrIhgg-1
X-Mimecast-MFC-AGG-ID: VfGYMHLaNjiYgYPgTrIhgg
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38a684a096eso800163f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 03:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736507260; x=1737112060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sO44nZBLu0p6kJCOrykrWaO05+eJcPWGJw8Kv1uRJqk=;
 b=OLE05t2FVxp/Bt6vBjcngayVU5cXMxxg38S5TueVdJ1o3x9y1rqpnVw/UHhQfYhfzL
 e4JwsTi48mX/NTMRdZaKAJG7x2iR7gSI7N2TNQ/vArTVxEpX0sYbW4kHfc1WxOA9RJkZ
 2bHp7c8RV7bc5zoWmsTzH1fWr5FZPRneuhAIDAeD+1eYMh8DWWY/6cwhfuvQTb333HBJ
 0I/habMxiZHisIYtsF19DOYvc4dyw06lw12hMixiaMMFvL8lSGdDqrRF8BVATEih7v25
 WHJHcaYHuBOn9yLFYs6ZdlcAz7dMyhlX1p/7GIoTyEVTh3gbtzsRypP4zUXMq/nc57T9
 ypjA==
X-Gm-Message-State: AOJu0YxAZ2TEyUOjArpnUi5s9U8hx9eOYl3USBGBcYAG6sY7zmzJH1OY
 KGYjGM2REMnkZ9xdulrNFXjdahMOvyPpiZCau/fceKQ57HNmOMpcMMVN2Ov16fLAtWIB0MqwzkB
 UZMziNOPF1lEAyNk9iHDPxZFIxnYyp6SSUpuYbnuV6GkzCm+0uyDVQzgknhqSM+6kYLYrI0wd8M
 tICJzUoK7es0TuoTt+MrOQpuiK5dM=
X-Gm-Gg: ASbGnctWpeROu5X4eIWxdvfwDzBLV2wUrGbq08arzk+PEX8W5w0HCHLRT/SVnRmGdyB
 /Cib/oDrITcVnQ08mPxLuDOG//iYQSmV9sghR8Q==
X-Received: by 2002:a05:6000:186b:b0:385:ef97:78c with SMTP id
 ffacd0b85a97d-38a872d2ae8mr8316930f8f.6.1736507260327; 
 Fri, 10 Jan 2025 03:07:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFs42KPX6jTEmbJDUeYcp44d3LXHrUb6CR3365lYu57GVSTCF+JHSX1XdsfVd8beoIjC7euUTCZ83sYTL/yno=
X-Received: by 2002:a05:6000:186b:b0:385:ef97:78c with SMTP id
 ffacd0b85a97d-38a872d2ae8mr8316899f8f.6.1736507259938; Fri, 10 Jan 2025
 03:07:39 -0800 (PST)
MIME-Version: 1.0
References: <20250110094400.512788-1-michael@anarch128.org>
In-Reply-To: <20250110094400.512788-1-michael@anarch128.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 10 Jan 2025 12:07:29 +0100
X-Gm-Features: AbW1kvaqZfQ4VtfauNCqnuJUFAzoP_4V-j-_8yOUffmNeJ_YRgCNbDU8VFhhSf4
Message-ID: <CABgObfY_GOQN5OWBQXYvfrBtNVZGGc75p3gRHrpqQNxUErfB3A@mail.gmail.com>
Subject: Re: [RFC]: port of embedded x86-mini disassembler to QEMU
To: Michael Clark <michael@anarch128.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: multipart/alternative; boundary="00000000000060fb1c062b581a93"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000060fb1c062b581a93
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 10 gen 2025, 10:52 Michael Clark <michael@anarch128.org> ha scritto:

> a note to announce a port of the x86-mini disassembler to QEMU.
>
> - https://github.com/michaeljclark/qemu/tree/x86-mini


I assume the huge .h files are autogenerated? If so, QEMU cannot use them
without including the human-readable sources in the tree.

I can see how that might be interesting for x86 virtualization where you
have only one target and therefore you can get rid of the capstone
dependency. At the same time, other virtualization targets like arm64 and
RISC-V are going to become more and more important=E2=80=94not less=E2=80=
=94and not having
to maintain a disassembler ourselves as part of QEMU is also a big plus...

Paolo


> - https://github.com/michaeljclark/x86/tree/x86-mini
>
> # x86-mini
>
> the x86-mini library is a lightweight x86 encoder, decoder, and
> disassembler that uses extensions to the Intel instruction set
> metadata format to encode modern VEX/EVEX instructions and legacy
> instructions using a parameterized LEX (legacy extension) format.
>
> - metadata-driven disassembler with Intel format output.
> - written in C11 for compatibility with projects written in C.
> - low-level instruction encoder and decoder uses <=3D 32-bytes.
> - python tablegen program to generate C tables from CSV metadata.
> - metadata table tool to inspect operand encode and decode tables.
> - carefully checked machine-readable instruction set metadata.
> - support for REX/VEX/EVEX and preliminary support for REX2.
>
> the x86-mini x86 encoder and decoder library has been written from
> scratch to be modern and as simple as possible while also covering
> recent additions to the Intel and AMD 64-bit instruction sets such
> as the EVEX encodings for recent AVX-512 extensions and soon REX2/
> EVEX encodings for Intel APX, as it is written with that in mind.
>
> ## interest to the QEMU community
>
> - x86-mini is fast. raw decode performance is ~100-200MiB/sec.
> - x86-mini is small. 5 files, ~5 KLOC or ~13 KLOC including tables.
> - x86-mini is complete and includes the latest AVX-512 extensions.
> - x86-mini is easy to extend and uses extended Intel format metadata.
> - x86-mini is documented with detailed info on the metadata format.
> - x86-mini has CLI tools for searching x86 instruction set metadata.
>
> ## techinical notes
>
> - the decoder is table-based and uses a metadata interpreter.
> - the decode table is ~66KiB with a ~150KiB acceleration trie.
> - there are currently 3658 opcode entries active on x86-64
>   which expands to 4775 table entries due to parameterization.
> - it could be made faster by vectorizing the prefix decoder and
>   generating decode templates from the metadata to consteval
>   metadata interpretation to eliminate some L1 D$ traffic.
>
> after cherry-picking the commit, one can test host and target
> disassembly support. e.g. for an x86-64 target on an x86-64 host:
>
> $ echo aaa | qemu-x86_64 -d in_asm,out_asm /usr/bin/openssl sha256
>
> ## caveats and limitations
>
> - supports 32-bit and 64-bit disassembly, and theoretically 16-bit.
> - designed to support 16-bit but base index formats are not done yet.
> - x86-64 is exhaustively fuzz-tested against the LLVM disassembler.
> - but x86-mini is new and hasn't been battle-tested in production.
>
> if you already link with capstone then it doesn't provide very many
> immediate benefits, however, I think it is potentially useful as a
> small embeddable disassembler to evaluate for potential inclusion.
>
> ## rationale
>
> I worked on the QEMU disassembler while working on the QEMU RISC-V
> target back in 2017/2018 and I was curious about vector support.
> it seemed at the time that TCG vector support was piecemeal, plus
> the old x86 disassembler seemed messy and incomplete. I also needed
> an MIT-licensed disassembler to enable use in a commercial product.
> basically, I was looking for a lightweight symmetric x86 instruction
> encoder and decoder library in pure C with simple build requirements.
> that is what prompted this initiative.
>
> it would be nice to have an x86 disassembler building out-of-the-box
> as I find QEMU's built-in tracing extremely useful and given x86 is
> a popular target, a small embedded disassembler might be practical.
>
> ## summary and conclusion
>
> at minimum, the metedata may be useful for x86 EVEX support. note
> I see `tests/tcg/i386/x86.csv` in the source tree. the metadata is
> also based on x86-csv but has had numerous inaccuracies fixed as
> well as conversion of legacy instructions to the new LEX format.
> in effect the metadata has been fuzz-tested against LLVM for x86-64
> and ISA coverage is in the order of ~99.7%. the main branch of the
> linked repo has a procedural fuzzer for metadata-based instruction
> synthesis that could be useful for generating test cases for QEMU.
>
> I am kind of throwing this over the fence, although the code is quite
> self-contained and my stress and mental health is now under control.
> also I have not yet run checkpatch.pl on this code. it is a preview.
>
> x86-mini submaintainer.
> Michael Clark.
> --
>
>

--00000000000060fb1c062b581a93
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 10 gen 2025, 10:52 Michae=
l Clark &lt;<a href=3D"mailto:michael@anarch128.org">michael@anarch128.org<=
/a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">a note to announce a port of the x86-mini disassembler to QEMU.<br>
<br>
- <a href=3D"https://github.com/michaeljclark/qemu/tree/x86-mini" rel=3D"no=
referrer noreferrer" target=3D"_blank">https://github.com/michaeljclark/qem=
u/tree/x86-mini</a></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">I assume the huge .h files are autogenerated? If so, QEMU ca=
nnot use them without including the human-readable sources in the tree.</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">I can see how that might be=
 interesting for x86 virtualization where you have only one target and ther=
efore you can get rid of the capstone dependency. At the same time, other v=
irtualization targets like arm64 and RISC-V are going to become more and mo=
re important=E2=80=94not less=E2=80=94and not having to maintain a disassem=
bler ourselves as part of QEMU is also a big plus...</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><br>
- <a href=3D"https://github.com/michaeljclark/x86/tree/x86-mini" rel=3D"nor=
eferrer noreferrer" target=3D"_blank">https://github.com/michaeljclark/x86/=
tree/x86-mini</a><br>
<br>
# x86-mini<br>
<br>
the x86-mini library is a lightweight x86 encoder, decoder, and<br>
disassembler that uses extensions to the Intel instruction set<br>
metadata format to encode modern VEX/EVEX instructions and legacy<br>
instructions using a parameterized LEX (legacy extension) format.<br>
<br>
- metadata-driven disassembler with Intel format output.<br>
- written in C11 for compatibility with projects written in C.<br>
- low-level instruction encoder and decoder uses &lt;=3D 32-bytes.<br>
- python tablegen program to generate C tables from CSV metadata.<br>
- metadata table tool to inspect operand encode and decode tables.<br>
- carefully checked machine-readable instruction set metadata.<br>
- support for REX/VEX/EVEX and preliminary support for REX2.<br>
<br>
the x86-mini x86 encoder and decoder library has been written from<br>
scratch to be modern and as simple as possible while also covering<br>
recent additions to the Intel and AMD 64-bit instruction sets such<br>
as the EVEX encodings for recent AVX-512 extensions and soon REX2/<br>
EVEX encodings for Intel APX, as it is written with that in mind.<br>
<br>
## interest to the QEMU community<br>
<br>
- x86-mini is fast. raw decode performance is ~100-200MiB/sec.<br>
- x86-mini is small. 5 files, ~5 KLOC or ~13 KLOC including tables.<br>
- x86-mini is complete and includes the latest AVX-512 extensions.<br>
- x86-mini is easy to extend and uses extended Intel format metadata.<br>
- x86-mini is documented with detailed info on the metadata format.<br>
- x86-mini has CLI tools for searching x86 instruction set metadata.<br>
<br>
## techinical notes<br>
<br>
- the decoder is table-based and uses a metadata interpreter.<br>
- the decode table is ~66KiB with a ~150KiB acceleration trie.<br>
- there are currently 3658 opcode entries active on x86-64<br>
=C2=A0 which expands to 4775 table entries due to parameterization.<br>
- it could be made faster by vectorizing the prefix decoder and<br>
=C2=A0 generating decode templates from the metadata to consteval<br>
=C2=A0 metadata interpretation to eliminate some L1 D$ traffic.<br>
<br>
after cherry-picking the commit, one can test host and target<br>
disassembly support. e.g. for an x86-64 target on an x86-64 host:<br>
<br>
$ echo aaa | qemu-x86_64 -d in_asm,out_asm /usr/bin/openssl sha256<br>
<br>
## caveats and limitations<br>
<br>
- supports 32-bit and 64-bit disassembly, and theoretically 16-bit.<br>
- designed to support 16-bit but base index formats are not done yet.<br>
- x86-64 is exhaustively fuzz-tested against the LLVM disassembler.<br>
- but x86-mini is new and hasn&#39;t been battle-tested in production.<br>
<br>
if you already link with capstone then it doesn&#39;t provide very many<br>
immediate benefits, however, I think it is potentially useful as a<br>
small embeddable disassembler to evaluate for potential inclusion.<br>
<br>
## rationale<br>
<br>
I worked on the QEMU disassembler while working on the QEMU RISC-V<br>
target back in 2017/2018 and I was curious about vector support.<br>
it seemed at the time that TCG vector support was piecemeal, plus<br>
the old x86 disassembler seemed messy and incomplete. I also needed<br>
an MIT-licensed disassembler to enable use in a commercial product.<br>
basically, I was looking for a lightweight symmetric x86 instruction<br>
encoder and decoder library in pure C with simple build requirements.<br>
that is what prompted this initiative.<br>
<br>
it would be nice to have an x86 disassembler building out-of-the-box<br>
as I find QEMU&#39;s built-in tracing extremely useful and given x86 is<br>
a popular target, a small embedded disassembler might be practical.<br>
<br>
## summary and conclusion<br>
<br>
at minimum, the metedata may be useful for x86 EVEX support. note<br>
I see `tests/tcg/i386/x86.csv` in the source tree. the metadata is<br>
also based on x86-csv but has had numerous inaccuracies fixed as<br>
well as conversion of legacy instructions to the new LEX format.<br>
in effect the metadata has been fuzz-tested against LLVM for x86-64<br>
and ISA coverage is in the order of ~99.7%. the main branch of the<br>
linked repo has a procedural fuzzer for metadata-based instruction<br>
synthesis that could be useful for generating test cases for QEMU.<br>
<br>
I am kind of throwing this over the fence, although the code is quite<br>
self-contained and my stress and mental health is now under control.<br>
also I have not yet run <a href=3D"http://checkpatch.pl" rel=3D"noreferrer =
noreferrer" target=3D"_blank">checkpatch.pl</a> on this code. it is a previ=
ew.<br>
<br>
x86-mini submaintainer.<br>
Michael Clark.<br>
--<br>
<br>
</blockquote></div></div></div>

--00000000000060fb1c062b581a93--


