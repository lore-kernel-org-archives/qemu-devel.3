Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E9606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TWN1OkQi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJA9W-0007yt-OW; Tue, 20 Oct 2026 09:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJA9U-0007yI-Sb
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 09:45:16 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJA9S-00055E-PO
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 09:45:16 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8aea7b7ca0cso23986277b3.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 06:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792503913; cv=none;
 d=google.com; s=arc-20260327;
 b=eN950/Ckv0P7Zei6AK2hS/ck4cTZuhXWiGbybL0nmBbojcjGtsoae2LBfhogAEz1iE
 B6jN8cHUeioaGa/9VfpUwJEeOBwGk5fDf2+q3eOBx6F18VgaFMHoFRvjfEwo7wKhJJN9
 1VyFGPTx16UvidvGu/Wkib5sRklk362iJ8JUxI4ecIGP/+em8fwC6pUvmzNvnYDRFZFB
 61xI2uV1Tl6F5hvuuwY1XcIhBTJyS4/K6DNfMbIIMGU4JG5Z/MJMC/dLey1Ovg5tPXEP
 Yn0t+tU3OrZ64Zuh07b7fwMY3agR80jKOWo56QmDY1UaCX+nKf2MZMJW3sPcWHjLaLpV
 6WGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jtWeFmERuTIWiGub5eckixUA1LB8Wjo5yRV72Te/LnA=;
 fh=oraPjQU+yAe2h/NZP3Xc/cKBl+/fAxl4XlrKwLshaqM=;
 b=YXhysTnOkKWbE5fjI6eoxnR22IntqYAVG9Rzf3V74WaijDr17N5rYsZ9VfCVoHKWup
 pp13ypR+SvR+5inRt2lLpLiLEHbJX4w+KvsHQ9aWSWT2Tl1bCAUuiez6Ajc1dt05Pz3J
 dUJ6FyOUPoXl8/lHM7Js1WPjA9gFG86QeFL0Uy3s1W4I42LdT+qUm6rvdEWsLlV4ml+r
 8mGT5B7nQ4OOzaCOq5WUEsF+m/y+GR/s+3+SFXGCJVMyohMeqzGsDKMYruZfQhMx33Ck
 3cXqZH0KqHWM1kSZ1ZWa7D1xzLWU78kbpeSttWhRxHL8b8TG92VVav8rQj7xfja5Y/F0
 louQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792503913; x=1793108713; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jtWeFmERuTIWiGub5eckixUA1LB8Wjo5yRV72Te/LnA=;
 b=TWN1OkQiniHj6wY7+TFbTDOV+gTHdOp0AD4Yo77kJCY7sHsgg5I4yvmmUuZvsYkMmq
 VNf5lPPth/HfRbWGvooKt/5nriituXKVwQZKnidJHk8JSd4zE/Cov0GxX9hOY/T1rch2
 lIaYV0uZShmHHHtWllGHmu5g+k1peLeWUBKZFGeeE+NqKwcLdhUXvM+DqRmUs0NMWNaf
 arRlXB7Di9vgRAlM6LJobuIhlecDlCIBGheeD/T5wHDTgJMhwtRqJ+xUvOd1T/Q28zE7
 Eb18X0i8kttqjG93hjoVidXvnoSTZLQKvPTUWpQakFj6MBL66VgPJ9M7VxqN7AU8wEWR
 CGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792503913; x=1793108713;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jtWeFmERuTIWiGub5eckixUA1LB8Wjo5yRV72Te/LnA=;
 b=B/1E2+BZHw7+Ff+0janenLZBriEb1ybf9jCmwNJmTevfx7DpOPPnsowEb7RRU1n3Yu
 FhTNCsASe3VpyquJPcwUwOfnnti4EJd7/qET5Qo6mL24LDMquEmA503V65OCQIc0ePgb
 S4fLDns5vgsBI8U2Vef6gqEfvDESf3oDNOGxWem7hGXMaCrzw5YVM4z4dLuxKF68Dr7C
 IzWB5oIgMnMkOMHwjnQzi5BH2sXm0d16PN/jkvAkfBcbz+f60PMNKKQGAKSp+06ElCcy
 xOL/LrZBcjLk2AEN6yS34SartUNIZXh8AfwR0PP2l1gLE2I0XLma6pwyITDmgIpX32Fr
 CIlw==
X-Gm-Message-State: AFq9FYIDvaNwwOif7uMvAxBMmiZFa8FR6fIXjb/WjGTHcNUgjSaYsSUu
 eY3hWZp4X/1aRuGQjw8/wKGxmJbKL1OWZJD7bVbKOlMBkFSKBivv/VMD9jU7UAWGWQczsXzDo95
 sxVvomEgwNytpAXabSrc1MaHTEKLwcncu1r/Uz8EUyA==
X-Gm-Gg: AYBFou3LHVuuqWwFAy05/244xO4guo5T9q38GsS+NgTOvZu+WPPhHhDEF9QIBZp5vx3
 +e4Jy36valKyNmJo9BtnJOCF7QrR1jccDYh9ka9MzEbP1Bz50BM8y0Ze1YjKIoeo4iDeIHe8UHO
 wflF4ij2ari8gWug4JygenfywFCAVDIJoLgjQrRLIQVgBXH43qDXD224zycyvjogGG2HOwZHzEl
 m3QhQQ0Zb1EIJ/Cvs62aFCLB/bbzlLgtjV7ejYr4PxhraKpsYMXJRPt2yUc4XqsY976cp2M20yO
 kxwOD77QqPm7gmvDck1wKmSmbryAIhSbLJjbkTV6u7whe4cd1uKicP34HlQVVWUVhiPOnX6Hu/d
 kWJZj2LE36OobBfrSBUByYeBM1cLVZMSRKuhcFBmO
X-Received: by 2002:a05:690c:112:b0:873:5bd1:98c9 with SMTP id
 00721157ae682-8b0f21d095amr35358157b3.59.1792503913032; Tue, 20 Oct 2026
 06:45:13 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260806213640.699905-1-brian.cain@oss.qualcomm.com>
 <20260806213640.699905-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260806213640.699905-3-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2026 14:45:00 +0100
X-Gm-Features: AclHuK_vYBtJHMZ9a4qD8FriVhrufuPjZfTsGR7wU2WuEQK4dvnUbb9bvMwwgaE
Message-ID: <CAFEAcA8CYaJ=jAyc29RSdUMD_SWquJqz4fNQyW7oCrWithZhYA@mail.gmail.com>
Subject: Re: [PULL 2/3] tests/tcg/hexagon: add slot-assignment tests
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, 
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 6 Aug 2026 at 22:37, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> valid-slots: packets that legally share a slot and were wrongly
> rejected before the fix (load and transfer, load encoded first;
> dczeroa packed last with three transfers).
>
> invalid-slots: unassignable packets that must still be rejected:
> store + duplex, load + indirect jump, three logical ops competing for
> slots 2 and 3, and five ops for four slots.
>
> Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/invalid-slots.c | 72 +++++++++++++++++++++++++++++++
>  tests/tcg/hexagon/valid-slots.c   | 62 ++++++++++++++++++++++++++
>  tests/tcg/hexagon/Makefile.target |  1 +
>  3 files changed, 135 insertions(+)
>  create mode 100644 tests/tcg/hexagon/valid-slots.c

Hi; if you build QEMU with the clang sanitizer enabled
("--enable-ubsan --cc=clang --cxx=clang++") then the invalid-slots
test added here results in the hexagon decoder trying to shift
by -1, which is UB:

$ UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
./build/clang/qemu-hexagon
./build/clang/tests/tcg/hexagon-linux-user-invalid-slots.test
../../target/hexagon/decode.c:603:35: runtime error: shift exponent -1
is negative
    #0 0x555695dc2392 in decode_set_slot_number
/home/pm215/qemu/build/clang/../../target/hexagon/decode.c:603:35
    #1 0x555695dc2392 in decode_packet
/home/pm215/qemu/build/clang/../../target/hexagon/decode.c:783:14
    #2 0x5556959801e7 in decode_and_translate_packet
/home/pm215/qemu/build/clang/../../target/hexagon/translate.c:1274:18
    #3 0x55569597f927 in hexagon_tr_translate_packet
/home/pm215/qemu/build/clang/../../target/hexagon/translate.c:1375:5
    #4 0x5556958bda32 in translator_loop
/home/pm215/qemu/build/clang/../../accel/tcg/translator.c:216:9
    #5 0x55569597ec72 in hexagon_translate_code
/home/pm215/qemu/build/clang/../../target/hexagon/translate.c:1428:5
    #6 0x5556958bca00 in setjmp_gen_code
/home/pm215/qemu/build/clang/../../accel/tcg/translate-all.c:251:5
    #7 0x5556958babd7 in tb_gen_code
/home/pm215/qemu/build/clang/../../accel/tcg/translate-all.c:324:21
    #8 0x55569589fbfc in cpu_exec_loop
/home/pm215/qemu/build/clang/../../accel/tcg/cpu-exec.c:973:22
    #9 0x55569589e309 in cpu_exec_setjmp
/home/pm215/qemu/build/clang/../../accel/tcg/cpu-exec.c:1019:12
    #10 0x55569589e10d in cpu_exec
/home/pm215/qemu/build/clang/../../accel/tcg/cpu-exec.c:1050:12
    #11 0x555695977cdb in cpu_loop
/home/pm215/qemu/build/clang/../../linux-user/hexagon/cpu_loop.c:38:18
    #12 0x5556961fe1f5 in main
/home/pm215/qemu/build/clang/../../linux-user/main.c:1010:5
    #13 0x7c65f202a1c9 in __libc_start_call_main
csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #14 0x7c65f202a28a in __libc_start_main csu/../csu/libc-start.c:360:3
    #15 0x55569582d294 in _start
(/home/pm215/qemu/build/clang/qemu-hexagon+0x910294) (BuildId:
d18c0fb84fd3431a52be6d831fc64fd2d0e00980)

(This also shows up as "make check" failing in this config.)

Could you have a look at what goes wrong here, please?

thanks
-- PMM

