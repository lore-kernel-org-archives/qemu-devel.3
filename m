Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7133ACA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 21:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCO9N-0008L8-GK; Thu, 01 Oct 2026 17:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <finalspace@googlemail.com>)
 id 1xCNro-0001cF-MN
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 16:59:00 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <finalspace@googlemail.com>)
 id 1xCNrm-0003op-MU
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 16:59:00 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48b09f6bbe8so729039f8f.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 13:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20251104; t=1790888337; x=1791493137; darn=nongnu.org;
 h=content-transfer-encoding:content-type:subject:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h0eoJxX310phepsHQO5YNfa7hvQCj3jKCbKUYBWFB68=;
 b=YBiamG7MnJS2DTqWUPm1yCVBMS02yIZU67AdlNpRcopyEmSqXqQlEZ2qVIqu+6gbqM
 WXcOugLUayYG928EUk4OUn/ObLhsv+0/x8x5DuCPssyqvFRKGt98+PvBGDG8d8X+hh5d
 2jp0U8RXNtZ9AQYAdsiUpVWq3XjfbCOXXQn532H5k+InIEqeIbK6uf14aLtfkDt2Q70K
 9POgbyCEsAKyXtRiRj9snC9zFvkT7TIjJrB+YX100nayR8LR/YWTEiF3QtsIWQhOKwIQ
 wwIppIPS0/3D4kdcLDG+msAHiPBMooi8cjARvXWf+vP8nuNQoTDw/vP+yw3SB4mqkVY+
 9S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790888337; x=1791493137;
 h=content-transfer-encoding:content-type:subject:cc:to
 :content-language:user-agent:mime-version:date:message-id:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h0eoJxX310phepsHQO5YNfa7hvQCj3jKCbKUYBWFB68=;
 b=Dz+izYqL+8F3q1IM0ZG6jSBS0qK/16ENDkpmSodNTdllHOf7z6XDR8+54g2auyRjCq
 Gx2R7UuYNWm3mixSereS3YBbZmQx0ATSMKBUSH/ovqcuqYd9WR50ZvouFedrd6aE1ev4
 3iVOlx4K8YIPZncSapqePaf/0I9vSsSBdimJM+pUU+dwgrps5wgT5Sk7xlT+nfj4YuGQ
 Y3j5CijnZfJ6+rNnHVTr1TzssAasEYZQSCMpqSym6KPwsdkqw9sS/dv9TmMi8zrLGa4G
 86/DdRDtzeuqGuJg5vTlk2vn8OhX8ZIXxKLs1XmbTs1JdHdWh8QagikXH5ws/6nQlDyf
 JYxw==
X-Gm-Message-State: AFq9FYLzYvOhqwOU3prUAlwVBnSNaRXkySWw074MIIWtdyNGVCLyti6b
 xFM8MsCdqD1yMA3FBKh6dvK5HgkouyTcFaMmYRYT45Xksz5ddZ+n8nvOORjRjsLn
X-Gm-Gg: AYBFou0dil5tDT3ZAjQFGkSdL2IlrviW6jHDRPR23uK3vdi5sTPIBcv0e3fvDzcrpHK
 EPBsN8mH/1DgdryJEvnlH6RrKhwYo1vcahYqghQScTrqjlpJDhTocODDfH+GFqDXxTRIo8HVqzZ
 IckoRi8MVMS4EhPd06M+hJGKmK5mBsaUshg5gFPBxmTSety2N1pX/cDV/f5e8//PiITwWAJLmR0
 exH9++eHrMjU/xD/8ibQXAHSEv3OWHKd/jzNqf41xVqdLfuPj2/tjpGSqNQU2sIGL2VrXkSJkwL
 ODGinMjWCVVp4g9ukHx3hi9Z9xL74gLrpXPQJqOz83T4qIRtXUyB1AtCO5iEYS/D3OF6ozCsv1h
 SNjfYIQkuv6lkrO6lYDUuOKn1WJ9GwlRtbItRXRtSl8ILTQv/bSETPvLmC5/pDGUFdphAhQwt3a
 khz7K0qnpkxGLbY1V1HtLEVUQrrUbOI9Sa59KPujCDxj1g4SzE6eaMbrNpIdkE66c9fbppuseiG
 WQJH2MF+JL6Uc/fkp5w+w8QaPYo+TEs1rlFlD5o/qUaa8mmlQIi
X-Received: by 2002:a5d:4ecb:0:b0:486:f42f:6860 with SMTP id
 ffacd0b85a97d-48b127350a0mr1141021f8f.56.1790888336706; 
 Thu, 01 Oct 2026 13:58:56 -0700 (PDT)
Received: from ?IPV6:2a02:8070:a187:e860:9b62:bb2d:1448:9374?
 ([2a02:8070:a187:e860:9b62:bb2d:1448:9374])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380f07cdsm779286f8f.10.2026.10.01.13.58.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 13:58:56 -0700 (PDT)
From: Finalspace <finalspace@googlemail.com>
X-Google-Original-From: Finalspace <finalspace@gmail.com>
Message-ID: <9ac0657c-aacf-49c1-8320-bb57b6c57ca4@gmail.com>
Date: Thu, 1 Oct 2026 22:58:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: Hints to fixing the critical ES1370 bugs which are currently unusable
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=finalspace@googlemail.com; helo=mail-wr2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 01 Oct 2026 17:16:53 -0400
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

The following bug-report / hint in this e-mail was detected by Claude 
Opus 5 at 2026-09-01. This includes also adding traces to the qemu 
source codes to identify the issue by claude autonomously.


However this entire email and verification of the bug itself was done by 
me (Torsten Spaete), a professional developer with almost 3 decades of 
programming experience with focus on 
multimedia/game/simulation/emulation programming (C, Delphi, C++).


# Bug

Since QEMU 3.1.0 (december 2018, commit 154c1d1f96) the ES1370 sound 
device is not usable anymore in any windows 9x guest -> Issue 
(https://gitlab.com/qemu-project/qemu/-/work_items/2243).

The ensonic audio driver (eapci95.inf) can be installed just fine, but 
after the installation there is a constant low-volume noise that is 
playing (hard to describe in words).
You need really good headphones to hear that, but you can still verify 
it by never hearing any sounds playing, not from windows, not from 
games. Executing other sound actions such as changing the volume freezes 
the entire guest for a few seconds (even the mouse freezes).

## Why the bug happens

Due to a bug in the register handling of the ES1370 system, a sample 
value of 5512 Hz (reset-value) on DAC1 and value 705.600 Hz on DAC2 is 
used to play any sound in windows 9x.
But the ES1370 driver sets DAC1/22050 Hz by default, so those values are 
clearly wrong.

The issue is that 8-bit and 16-bit register writing/reading handling is 
not properly handled for all register.
To be exact, any 8-bit or 16-bit access to non 4-byte aligned offsets fails.

Only 32-bit register read/write operations are handled properly, so when 
an assembly instruction is executed that operates on AL or even AX, 
depending on of the position of the register, writes do nothing and 
reads returns 0xFF or 0xFFFF (all bits set).
This means that writing with offset 0x01, 0x02, 0x05 will not write at 
all (not aligned to 4-bytes). Offsets multiples of 4 (0x00, 0x04, ...) 
reads just fine but writes resets remaining bytes to zero.

An example is 8-bit writing 0x21 to the CONTROL register starting with 
Offset 0x01 (not 4-byte aligned!). This effectly does nothing and 
reading from that register in that way returns 0xFF for 8-bit accessors.
The result should set DAC1/WTSRSEL to 22050 Hz and enables XCTL0 (line 
out), but it does not and properly was working before in QEMU 3.0.

In addition 8-bit reading of the STATUS register returns 0xFF as well. 
This results in short freezes in windows 9x when using the volume slider 
or start actual playing sounds.

## Reproduce

To reproduce the issue, you need a default QEMU 11.1.1 build (with or 
without the tracing enabled).

- You install windows 98 SE (i only tested win98 se) with a quick 
install iso or use a default installation, it doesn't matter that much.
- You attach an iso with the proper ES1370 win9x drivers (eapci95.inf) 
and run the `setup.exe`.
- After installation is done, you reboot
- You should hear that low-volume noise sound and/or changing 
volume/playing sounds freezes the guest for a few secs

- Ideally you have enabled logging, so you clearly which sample format 
are used

## Debugging

To see the wrong values in the log/console, you can use `-trace 
es1370_stream_format` which prints the `fmt=5512` in the wrong case.
Also lost register accesses can also be made visible by enabling the 
define `VERBOSE_ES1370`.

# Host Environment

I am running a CachyOS system with classic xorg/X11 and a KDE plasma 
desktop environment with decent hardware (Ryzen 9 7950X, 64 GB DDR5, 
Fast M.2. SSD's with DRAM caching, RTX 3090, Creative Sound Blaster G8).
The qemu version is the unmodified 11.1.1 cachyOS/arch binary package 
version.

# Guest Environment

```
set -x
"$QEMU" \
   -M pc-i440fx-9.2,accel=kvm,hpet=off -cpu coreduo -m 256 \
   -nodefaults -display sdl -rtc base=localtime \
   -device VGA \
   -audiodev pipewire,id=snd0 -device ES1370,audiodev=snd0,addr=5 \
   -netdev user,id=net0 -device pcnet,netdev=net0 \
   -device piix3-usb-uhci,id=usb \
   -drive 
id=hd,if=ide,index=0,media=disk,file="$R/vm/run/es1370-stock.qcow2" \
   -drive 
id=hd2,if=ide,index=1,media=disk,file="$R/vm/run/es1370-stock-data.qcow2" \
   -drive 
id=cd,if=ide,index=2,media=cdrom,file="$R/vm/iso/es1370-original.iso" \
   -boot order=c \
   -qmp unix:"$R/vm/qmp.sock",server,nowait \
   -trace enable=es1370_stream_format \
   2>&1 | tee "$TRACE_LOG"

```


Thats about it.

I hope you everything you need to reproduce the issue and include a fix 
to future qemu versions to make ES1370 usable again.


Thanks,

Finalspace


