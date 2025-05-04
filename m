Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A61EC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 20:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgKS-00070I-V9; Sun, 04 May 2025 16:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hslester96@gmail.com>)
 id 1uBgBx-00067e-Sr
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:44:05 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hslester96@gmail.com>)
 id 1uBgBv-0005vb-24
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:44:04 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ad1a87d93f7so153710166b.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 13:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746391440; x=1746996240; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WOUNzZU/QQTW27MFNQqLUiTNQ2Ryio16OLw/kM3JBy0=;
 b=QPYkS5MtlyaGOnifcyP072hNKmaG5Xj/vqIq5vy5vy9kiPfCKCrMnSR5u191NLT+Me
 oh0YR9PzBhEF7FlFncOAhMeNMHp0rqz5Lbki4aaFf6dRLQ3d8OnsqXvhT8HNunxsnCbq
 NxNHIluqoB7fKaKUubKFx7BpKfmotfKv087q1t9aTIilsKKJgRavkIGsaL7MDJ6EAlNI
 4l8L0IGQ+tO1qwYmAA6UhIGIeDfyNXJ0xKWo98tiUD6M87RgamsergHDgxLmKi6GeMQt
 2R155z6P1tZAhYzrQSnD7Ftb145S+bimAOUH9ZkiQC9AMksacvuM716YmGLbAVv0gm0f
 MlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746391440; x=1746996240;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WOUNzZU/QQTW27MFNQqLUiTNQ2Ryio16OLw/kM3JBy0=;
 b=kJhlmmlQkC4AKeSb2wcC8+2U8LfUWw4nt1vaVX8SKafDR4/m6f43cgdMsaREfcFMIa
 jf1EiXt8BOqbm+U2zBMdztxMuFKW2OZ08NzUSnWDFWL/PsopKLFD4sg0KHQBuIMadjgw
 2IsOLXsabAS8XOmPLRmjCC8NhEuHXMSgOFBAMye1BI/egJVdr4nG3d/Vf7ujMmncjauJ
 azVAprAVQ36OW8tQUpROI442YYDhwKVuSHlmL00cKZpl6qZjMUx3cUpZtI/sLUtQZeXU
 UsitPjBTlLdISe4YomEBHbnDI31Xej/YTL4MNsrpdYHLqJOOxSIbHX+arxaxq1qvQvkz
 hdHw==
X-Gm-Message-State: AOJu0YxrsEJhP06d7RLlhKxXt5lh/VceQZVcClnyZVZ4pRz8RVUWCm8D
 RCdWgy9gMcFgBbhgDyqVEDx2eXzsu3GreQdiMupiPVwmcaIaZ99fut5x7UJJLFHaIccxYufZ1RG
 3C6zDLNb0U+nvJWjCYeCXlTpV0Ti8iQ==
X-Gm-Gg: ASbGncuJLJjtY9h7C60ha4rvrOTXwQdJSnWhSuyBqPTCCjnKcqdww2s8017uLLAvnop
 ZOCbjZnA1t5TzVnRpLgSIegj9M7dLut9XJ56x5Q6I8KZUQWCRTY+GPpMMPWctlqyz5UmJ660bdB
 Kz/FbcFBHIf9a1Imc92pMM
X-Google-Smtp-Source: AGHT+IFIM+fT6THrPuU8X3smZEiayvcbRnJM8Oih+TsGvXU+szPtBQJSUhV5uvg3/Cr95RheZx+0lAjj29z1gUPwTU8=
X-Received: by 2002:a17:907:d8a:b0:ac2:88d5:770b with SMTP id
 a640c23a62f3a-ad1a497d72cmr480500466b.25.1746391440146; Sun, 04 May 2025
 13:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <CANhBUQ0BVpgmB6+qd9X8ieiyDcg4pSUzLAvO33LQbpfeq3Be2Q@mail.gmail.com>
In-Reply-To: <CANhBUQ0BVpgmB6+qd9X8ieiyDcg4pSUzLAvO33LQbpfeq3Be2Q@mail.gmail.com>
From: Chuhong Yuan <hslester96@gmail.com>
Date: Sun, 4 May 2025 16:43:49 -0400
X-Gm-Features: ATxdqUGXfxWhjhExNwVCeL-DybPU_GEhhwadqT1KGrrUZfiLrx_yxNQ3olgTbxs
Message-ID: <CANhBUQ0E0bpyL584ZN-4kcjknOtun-UT0Rd28LC=KXSJoLCALw@mail.gmail.com>
Subject: Fwd: Out-of-bounds access in rx_fifo_push()
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=hslester96@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 04 May 2025 16:52:47 -0400
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

Hello,

This is a bug I reported to qemu-security, while I was suggested to
forward it here
because it doesn't align with the virtualization use case.

Thanks,
Chuhong

---------- Forwarded message ---------
From: Chuhong Yuan <hslester96@gmail.com>
Date: Sat, May 3, 2025 at 11:30=E2=80=AFPM
Subject: Out-of-bounds access in rx_fifo_push()
To: <qemu-security@nongnu.org>


I detected an out-of-bounds access in rx_fifo_push() with the fuzzer.
Run the fuzzer with:
```
export QEMU_FUZZ_ARGS=3D"-display none -machine accel=3Dqtest, -m 512M
-machine smdkc210"
export QEMU_FUZZ_OBJECTS=3D"*lan9118-mmio*"
./qemu-fuzz-arm --fuzz-target=3Dgeneric-fuzz
```
The error stack:
../hw/net/lan9118.c:455:5: runtime error: index -30 out of bounds for
type 'uint32_t[3360]' (aka 'unsigned int[3360]')
    #0 0x5db0345b2020 in rx_fifo_push qemu/build/../hw/net/lan9118.c:455:26
    #1 0x5db0345b02a2 in lan9118_receive qemu/build/../hw/net/lan9118.c:546=
:13
    #2 0x5db034f8c2cf in nc_sendv_compat qemu/build/../net/net.c:794:11
    #3 0x5db034f8c2cf in qemu_deliver_packet_iov qemu/build/../net/net.c:84=
1:15
    #4 0x5db034f93d1c in qemu_net_queue_deliver_iov
qemu/build/../net/queue.c:179:11
    #5 0x5db034f93d1c in qemu_net_queue_send_iov
qemu/build/../net/queue.c:235:11
    #6 0x5db034f73a83 in net_hub_receive_iov qemu/build/../net/hub.c:74:9
    #7 0x5db034f73a83 in net_hub_port_receive_iov qemu/build/../net/hub.c:1=
25:12
    #8 0x5db034f8c0b1 in qemu_deliver_packet_iov qemu/build/../net/net.c:83=
9:15
    #9 0x5db034f916d5 in qemu_net_queue_deliver qemu/build/../net/queue.c:1=
64:11
    #10 0x5db034f9195c in qemu_net_queue_send qemu/build/../net/queue.c:210=
:11
    #11 0x5db034f80328 in qemu_send_packet_async_with_flags
qemu/build/../net/net.c:742:12
    #12 0x5db034fd8e1a in net_slirp_send_packet qemu/build/../net/slirp.c:1=
30:12
    #13 0x730d1764af9d
(/usr/lib/x86_64-linux-gnu/libslirp.so.0+0x19f9d) (BuildId:
083a517df5bba0cceb41bd923e84dd78ed894739)
    #14 0x730d17638dd0
(/usr/lib/x86_64-linux-gnu/libslirp.so.0+0x7dd0) (BuildId:
083a517df5bba0cceb41bd923e84dd78ed894739)
    #15 0x730d1763957a
(/usr/lib/x86_64-linux-gnu/libslirp.so.0+0x857a) (BuildId:
083a517df5bba0cceb41bd923e84dd78ed894739)
    #16 0x730d1763868a
(/usr/lib/x86_64-linux-gnu/libslirp.so.0+0x768a) (BuildId:
083a517df5bba0cceb41bd923e84dd78ed894739)
    #17 0x730d17638add
(/usr/lib/x86_64-linux-gnu/libslirp.so.0+0x7add) (BuildId:
083a517df5bba0cceb41bd923e84dd78ed894739)
    #18 0x5db03627becf in timerlist_run_timers
qemu/build/../util/qemu-timer.c:563:9
    #19 0x5db03627d1b8 in qemu_clock_run_timers
qemu/build/../util/qemu-timer.c:577:12
    #20 0x5db03627d1b8 in qemu_clock_advance_virtual_time
qemu/build/../util/qemu-timer.c:683:9
    #21 0x5db035e5b7e1 in qtest_process_command
qemu/build/../system/qtest.c:718:18
    #22 0x5db035e5714d in qtest_process_inbuf qemu/build/../system/qtest.c:=
769:9
    #23 0x5db035e56ac6 in qtest_server_inproc_recv
qemu/build/../system/qtest.c:897:9
    #24 0x5db035f5a702 in qtest_sendf qemu/build/../tests/qtest/libqtest.c:=
695:5
    #25 0x5db035f5a814 in qtest_clock_step_next
qemu/build/../tests/qtest/libqtest.c:1116:5
    #26 0x5db035fdcc4f in generic_fuzz
qemu/build/../tests/qtest/fuzz/generic_fuzz.c:666:13
    #27 0x5db035fcfa57 in LLVMFuzzerTestOneInput
qemu/build/../tests/qtest/fuzz/fuzz.c:172:5
    #28 0x5db033ae6459 in fuzzer::Fuzzer::ExecuteCallback(unsigned
char const*, unsigned long)
llvm-project-15.0.0.src/compiler-rt/lib/fuzzer/FuzzerLoop.cpp:612:15
    #29 0x5db033aea030 in fuzzer::Fuzzer::RunOne(unsigned char const*,
unsigned long, bool, fuzzer::InputInfo*, bool, bool*)
llvm-project-15.0.0.src/compiler-rt/lib/fuzzer/FuzzerLoop.cpp:514:22
    #30 0x5db033aeba9b in fuzzer::Fuzzer::MutateAndTestOne()
llvm-project-15.0.0.src/compiler-rt/lib/fuzzer/FuzzerLoop.cpp:758:25
    #31 0x5db033aeddaf in
fuzzer::Fuzzer::Loop(std::vector<fuzzer::SizedFile,
std::allocator<fuzzer::SizedFile>>&)
llvm-project-15.0.0.src/compiler-rt/lib/fuzzer/FuzzerLoop.cpp:903:21
    #32 0x5db033ad2b7a in fuzzer::FuzzerDriver(int*, char***, int
(*)(unsigned char const*, unsigned long))
llvm-project-15.0.0.src/compiler-rt/lib/fuzzer/FuzzerDriver.cpp:912:10
    #33 0x5db033abfe46 in main
llvm-project-15.0.0.src/compiler-rt/lib/fuzzer/FuzzerMain.cpp:20:30
    #34 0x730d16e2a1c9  (/usr/lib/x86_64-linux-gnu/libc.so.6+0x2a1c9)
(BuildId: 42c84c92e6f98126b3e2230ebfdead22c235b667)
    #35 0x730d16e2a28a in __libc_start_main
(/usr/lib/x86_64-linux-gnu/libc.so.6+0x2a28a) (BuildId:
42c84c92e6f98126b3e2230ebfdead22c235b667)
    #36 0x5db033abfe84 in _start (qemu/build/qemu-fuzz-arm+0x2600e84)

By analyzing the codes, the reason is that the code at line 624
doesn't have a boundary value check, so `s->rx_fifo_used` can be a
negative value. So if line 622 cuts `s->rx_fifo_head` to 0, the
`fifo_pos` at line 452 will be negative, which causes the
out-of-bounds access.

Ack: Chuhong Yuan (hslester96@gmail.com)

