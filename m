Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DEEC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 20:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmfTI-0002FN-I7; Mon, 24 Feb 2025 15:54:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1tmfTB-0002DN-FE
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:54:30 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wuhaotsh@google.com>)
 id 1tmfT8-0005Qj-Sb
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:54:28 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5461a3a03bdso187e87.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 12:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740430463; x=1741035263; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RlKtyHKmjkuK0qExQigH14CrDu3IzYINbLBSLatrJPU=;
 b=37FQzMi6CwWeLRVqHnhygsT44uLHbYU/G9N4WQrbDCKP1msqhmF08qwKe0yvFp4M26
 h7occLAtiPFl31F6dps7KQmESZUQQQTEv8GeoFHPU49zYc0XWqkmCZdM6JOO2d8UjMgR
 n+RykjNI3i54LBdpR4iifSJsdIcUx1TePCWnQAx9VjWkc/gMuPF9AN4o3pVFPhtAjUEX
 gUni3eLB4Gm2iHRUtPKrnpEChn6GpzbbticQ6/BH9oyeMpvDwgVRjnLmaAz4V3h2sMKN
 JnmpeG3tgOzzUQ5PyUMN8vM8s+cc9Mvn62BE01V16gJNJ54aoYJTTlKEeJsKW0vPRcJB
 0gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740430463; x=1741035263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RlKtyHKmjkuK0qExQigH14CrDu3IzYINbLBSLatrJPU=;
 b=AUpmDoaeySdFCOL5gegA/2Qa9Zrh8akqSHKjFiPEV/oTPVAolYzBfql7Dih/pQbuWE
 lYdWIg4/5m8Z6+xxrv49dcwXDctV5FrpV01QwXqdbbo6P0NLVWLas8BNjOJ8U+at6fK1
 PeKetjMP/QoxYoqsQ5F+VLWnMmy1pxVKpRmgWomrTZX6O+bBM39rsPUriwl4BY1QFd4+
 HZypLp7DMHOIOVCYtcJpyig1r02koRrF9fOC5TV2U0PDFmjf4Q/gtEon+AcrdO6pTNFb
 e0YbOEolFhzDSfzOyF25xzBkpsSydTJPcFyNS19KCDt+VRS/zJeA3JcJpiqVdUvsfEBx
 BaAA==
X-Gm-Message-State: AOJu0YyTCzcy1kyWRy+pvMtiHb7JMP4+ejNBF/WEWv+O/fAQ5Fy0/4fr
 raWdKbrIihu++ydVkkF+FLt2io0cg7sq5lovtD1SrNMfO4BsI39p1ywRuS1WPh5b1D8tIErEvBh
 vHVx2jUy4O7qQJDfMyBCAKf3xrETvUx92JQIM
X-Gm-Gg: ASbGncs9429tNa0B6+Vc/7D31KYTKVADBrwuz+dPFrc/4sWIsZV2WL6yUQ9t1/RSytZ
 SYVLpDVPmxASI6oWzZonJbvDyz+exs9yT/V1xBTImcNp5ByqOpaqkYXSO/25cxDS9woLApIW9Vq
 +ZNVPKVo+dfe4Z50jzY1Z3HCUHGc+AeA86lPza
X-Google-Smtp-Source: AGHT+IGiuw491x1K+GHoTvmUD7Z3FePjtca3kJwPc6w4IiEkHzh541g9JoabBUhKr6BAVkwJtybt3WlFzGSVjXxqdmQ=
X-Received: by 2002:a05:6512:b9d:b0:542:6b39:1d57 with SMTP id
 2adb3069b0e04-5485099c434mr90433e87.3.1740430463367; Mon, 24 Feb 2025
 12:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20250224205053.104959-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20250224205053.104959-1-pierrick.bouvier@linaro.org>
From: Hao Wu <wuhaotsh@google.com>
Date: Mon, 24 Feb 2025 12:54:10 -0800
X-Gm-Features: AWEUYZnb91g44R1mQSftDXTwGD3xgW8LHWmD4j3x9DK4eY6RZfIjMQHKE8Qcklk
Message-ID: <CAGcCb11d2d7xYA0p+y=9PH1uEmzXmjBP5upu3YXQ6TAGdfN_5w@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/npcm_clk: fix buffer-overflow
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, titusr@google.com, hskinnemoen@google.com, 
 peter.maydell@linaro.org, qemu-arm@nongnu.org, 
 Tyrone Ting <kfting@nuvoton.com>
Content-Type: multipart/alternative; boundary="00000000000086fd1a062ee98ba8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=wuhaotsh@google.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

--00000000000086fd1a062ee98ba8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks!

On Mon, Feb 24, 2025 at 12:51=E2=80=AFPM Pierrick Bouvier <
pierrick.bouvier@linaro.org> wrote:

> Regression introduced by cf76c4
> (hw/misc: Add nr_regs and cold_reset_values to NPCM CLK)
>
> cold_reset_values has a different size, depending on device used
> (NPCM7xx vs NPCM8xx). However, s->regs has a fixed size, which matches
> NPCM8xx. Thus, when initializing a NPCM7xx, we go past cold_reset_values
> ending.
>
> Report by asan:
> =3D=3D2066=3D=3DERROR: AddressSanitizer: global-buffer-overflow on addres=
s
> 0x55d68a3e97f0 at pc 0x7fcaf2b2d14b bp 0x7ffff0cc3890 sp 0x7ffff0cc3040
> READ of size 196 at 0x55d68a3e97f0 thread T0
>     #0 0x7fcaf2b2d14a in __interceptor_memcpy
> ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_intercepto=
rs.inc:827
>     #1 0x55d688447e0d in memcpy
> /usr/include/x86_64-linux-gnu/bits/string_fortified.h:29
>     #2 0x55d688447e0d in npcm_clk_enter_reset ../hw/misc/npcm_clk.c:968
>     #3 0x55d6899b7213 in resettable_phase_enter ../hw/core/resettable.c:1=
36
>     #4 0x55d6899a1ef7 in bus_reset_child_foreach ../hw/core/bus.c:97
>     #5 0x55d6899b717d in resettable_child_foreach
> ../hw/core/resettable.c:92
>     #6 0x55d6899b717d in resettable_phase_enter ../hw/core/resettable.c:1=
29
>     #7 0x55d6899b4ead in resettable_container_child_foreach
> ../hw/core/resetcontainer.c:54
>     #8 0x55d6899b717d in resettable_child_foreach
> ../hw/core/resettable.c:92
>     #9 0x55d6899b717d in resettable_phase_enter ../hw/core/resettable.c:1=
29
>     #10 0x55d6899b7bfa in resettable_assert_reset
> ../hw/core/resettable.c:55
>     #11 0x55d6899b8666 in resettable_reset ../hw/core/resettable.c:45
>     #12 0x55d688d15cd2 in qemu_system_reset ../system/runstate.c:527
>     #13 0x55d687fc5edd in qdev_machine_creation_done
> ../hw/core/machine.c:1738
>     #14 0x55d688d209bd in qemu_machine_creation_done ../system/vl.c:2779
>     #15 0x55d688d209bd in qmp_x_exit_preconfig ../system/vl.c:2807
>     #16 0x55d688d281fb in qemu_init ../system/vl.c:3838
>     #17 0x55d687ceab12 in main ../system/main.c:68
>     #18 0x7fcaef006249  (/lib/x86_64-linux-gnu/libc.so.6+0x27249)
>     #19 0x7fcaef006304 in __libc_start_main
> (/lib/x86_64-linux-gnu/libc.so.6+0x27304)
>     #20 0x55d687cf0010 in _start
> (/home/runner/work/qemu-ci/qemu-ci/build/qemu-system-arm+0x371c010)
>
> 0x55d68a3e97f0 is located 0 bytes to the right of global variable
> 'npcm7xx_cold_reset_values' defined in '../hw/misc/npcm_clk.c:134:23'
> (0x55d68a3e9780) of size 112
>
> Impacted tests:
> Summary of Failures:
>
> check:
>   2/747 qemu:qtest+qtest-aarch64 / qtest-aarch64/qom-test
>        ERROR             9.28s   killed by signal 6 SIGABRT
>   4/747 qemu:qtest+qtest-arm / qtest-arm/qom-test
>        ERROR             7.82s   killed by signal 6 SIGABRT
>  32/747 qemu:qtest+qtest-aarch64 / qtest-aarch64/device-introspect-test
>        ERROR            10.91s   killed by signal 6 SIGABRT
>  35/747 qemu:qtest+qtest-arm / qtest-arm/device-introspect-test
>        ERROR            11.33s   killed by signal 6 SIGABRT
> 114/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_pwm-test
>        ERROR             0.98s   killed by signal 6 SIGABRT
> 115/747 qemu:qtest+qtest-aarch64 / qtest-aarch64/test-hmp
>        ERROR             2.95s   killed by signal 6 SIGABRT
> 117/747 qemu:qtest+qtest-arm / qtest-arm/test-hmp
>        ERROR             2.54s   killed by signal 6 SIGABRT
> 151/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_watchdog_timer-test
>         ERROR             0.96s   killed by signal 6 SIGABRT
> 247/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_adc-test
>        ERROR             0.96s   killed by signal 6 SIGABRT
> 248/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_gpio-test
>         ERROR             1.05s   killed by signal 6 SIGABRT
> 249/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_rng-test
>        ERROR             0.97s   killed by signal 6 SIGABRT
> 250/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_sdhci-test
>        ERROR             0.97s   killed by signal 6 SIGABRT
> 251/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_smbus-test
>        ERROR             0.89s   killed by signal 6 SIGABRT
> 252/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_timer-test
>        ERROR             1.09s   killed by signal 6 SIGABRT
> 253/747 qemu:qtest+qtest-arm / qtest-arm/npcm_gmac-test
>        ERROR             1.12s   killed by signal 6 SIGABRT
> 255/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_emc-test
>        ERROR             1.05s   killed by signal 6 SIGABRT
>
> check-functional:
>  22/203 qemu:func-thorough+func-arm-thorough+thorough /
> func-arm-arm_quanta_gsj                      ERROR             0.79s   ex=
it
> status 1
>  38/203 qemu:func-quick+func-aarch64 / func-aarch64-migration
>                           ERROR             1.97s   exit status 1
>  45/203 qemu:func-quick+func-arm / func-arm-migration
>                           ERROR             1.90s   exit status 1
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>
Reviewed-by: Hao Wu <wuhaotsh@google.com>

> ---
>  hw/misc/npcm_clk.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/misc/npcm_clk.c b/hw/misc/npcm_clk.c
> index d1f29759d59..0e85974cf96 100644
> --- a/hw/misc/npcm_clk.c
> +++ b/hw/misc/npcm_clk.c
> @@ -964,8 +964,9 @@ static void npcm_clk_enter_reset(Object *obj,
> ResetType type)
>      NPCMCLKState *s =3D NPCM_CLK(obj);
>      NPCMCLKClass *c =3D NPCM_CLK_GET_CLASS(s);
>
> -    g_assert(sizeof(s->regs) >=3D c->nr_regs * sizeof(uint32_t));
> -    memcpy(s->regs, c->cold_reset_values, sizeof(s->regs));
> +    size_t sizeof_regs =3D c->nr_regs * sizeof(uint32_t);
> +    g_assert(sizeof(s->regs) >=3D sizeof_regs);
> +    memcpy(s->regs, c->cold_reset_values, sizeof_regs);
>      s->ref_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>      npcm7xx_clk_update_all_clocks(s);
>      /*
> --
> 2.39.5
>
>

--00000000000086fd1a062ee98ba8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Thanks!</div><br><div class=3D"gmail_quot=
e gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb =
24, 2025 at 12:51=E2=80=AFPM Pierrick Bouvier &lt;<a href=3D"mailto:pierric=
k.bouvier@linaro.org">pierrick.bouvier@linaro.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Regression introduced by c=
f76c4<br>
(hw/misc: Add nr_regs and cold_reset_values to NPCM CLK)<br>
<br>
cold_reset_values has a different size, depending on device used<br>
(NPCM7xx vs NPCM8xx). However, s-&gt;regs has a fixed size, which matches<b=
r>
NPCM8xx. Thus, when initializing a NPCM7xx, we go past cold_reset_values<br=
>
ending.<br>
<br>
Report by asan:<br>
=3D=3D2066=3D=3DERROR: AddressSanitizer: global-buffer-overflow on address =
0x55d68a3e97f0 at pc 0x7fcaf2b2d14b bp 0x7ffff0cc3890 sp 0x7ffff0cc3040<br>
READ of size 196 at 0x55d68a3e97f0 thread T0<br>
=C2=A0 =C2=A0 #0 0x7fcaf2b2d14a in __interceptor_memcpy ../../../../src/lib=
sanitizer/sanitizer_common/sanitizer_common_interceptors.inc:827<br>
=C2=A0 =C2=A0 #1 0x55d688447e0d in memcpy /usr/include/x86_64-linux-gnu/bit=
s/string_fortified.h:29<br>
=C2=A0 =C2=A0 #2 0x55d688447e0d in npcm_clk_enter_reset ../hw/misc/npcm_clk=
.c:968<br>
=C2=A0 =C2=A0 #3 0x55d6899b7213 in resettable_phase_enter ../hw/core/resett=
able.c:136<br>
=C2=A0 =C2=A0 #4 0x55d6899a1ef7 in bus_reset_child_foreach ../hw/core/bus.c=
:97<br>
=C2=A0 =C2=A0 #5 0x55d6899b717d in resettable_child_foreach ../hw/core/rese=
ttable.c:92<br>
=C2=A0 =C2=A0 #6 0x55d6899b717d in resettable_phase_enter ../hw/core/resett=
able.c:129<br>
=C2=A0 =C2=A0 #7 0x55d6899b4ead in resettable_container_child_foreach ../hw=
/core/resetcontainer.c:54<br>
=C2=A0 =C2=A0 #8 0x55d6899b717d in resettable_child_foreach ../hw/core/rese=
ttable.c:92<br>
=C2=A0 =C2=A0 #9 0x55d6899b717d in resettable_phase_enter ../hw/core/resett=
able.c:129<br>
=C2=A0 =C2=A0 #10 0x55d6899b7bfa in resettable_assert_reset ../hw/core/rese=
ttable.c:55<br>
=C2=A0 =C2=A0 #11 0x55d6899b8666 in resettable_reset ../hw/core/resettable.=
c:45<br>
=C2=A0 =C2=A0 #12 0x55d688d15cd2 in qemu_system_reset ../system/runstate.c:=
527<br>
=C2=A0 =C2=A0 #13 0x55d687fc5edd in qdev_machine_creation_done ../hw/core/m=
achine.c:1738<br>
=C2=A0 =C2=A0 #14 0x55d688d209bd in qemu_machine_creation_done ../system/vl=
.c:2779<br>
=C2=A0 =C2=A0 #15 0x55d688d209bd in qmp_x_exit_preconfig ../system/vl.c:280=
7<br>
=C2=A0 =C2=A0 #16 0x55d688d281fb in qemu_init ../system/vl.c:3838<br>
=C2=A0 =C2=A0 #17 0x55d687ceab12 in main ../system/main.c:68<br>
=C2=A0 =C2=A0 #18 0x7fcaef006249=C2=A0 (/lib/x86_64-linux-gnu/libc.so.6+0x2=
7249)<br>
=C2=A0 =C2=A0 #19 0x7fcaef006304 in __libc_start_main (/lib/x86_64-linux-gn=
u/libc.so.6+0x27304)<br>
=C2=A0 =C2=A0 #20 0x55d687cf0010 in _start (/home/runner/work/qemu-ci/qemu-=
ci/build/qemu-system-arm+0x371c010)<br>
<br>
0x55d68a3e97f0 is located 0 bytes to the right of global variable &#39;npcm=
7xx_cold_reset_values&#39; defined in &#39;../hw/misc/npcm_clk.c:134:23&#39=
; (0x55d68a3e9780) of size 112<br>
<br>
Impacted tests:<br>
Summary of Failures:<br>
<br>
check:<br>
=C2=A0 2/747 qemu:qtest+qtest-aarch64 / qtest-aarch64/qom-test=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ERROR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A09.28s=C2=A0 =C2=A0k=
illed by signal 6 SIGABRT<br>
=C2=A0 4/747 qemu:qtest+qtest-arm / qtest-arm/qom-test=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ERROR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A07.82s=C2=A0 =C2=A0killed by signal 6 SIGABRT<br>
=C2=A032/747 qemu:qtest+qtest-aarch64 / qtest-aarch64/device-introspect-tes=
t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERROR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 10.91s=C2=A0 =C2=A0killed by signal 6 SIGABRT<br>
=C2=A035/747 qemu:qtest+qtest-arm / qtest-arm/device-introspect-test=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERROR=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 11.33s=C2=A0 =C2=A0killed by signal 6 SI=
GABRT<br>
114/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_pwm-test=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ER=
ROR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.98s=C2=A0 =C2=A0killed=
 by signal 6 SIGABRT<br>
115/747 qemu:qtest+qtest-aarch64 / qtest-aarch64/test-hmp=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ER=
ROR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02.95s=C2=A0 =C2=A0killed=
 by signal 6 SIGABRT<br>
117/747 qemu:qtest+qtest-arm / qtest-arm/test-hmp=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ERROR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02.=
54s=C2=A0 =C2=A0killed by signal 6 SIGABRT<br>
151/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_watchdog_timer-test=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERROR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A00.96s=C2=A0 =C2=A0killed by signal 6 SIGABRT<br>
247/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_adc-test=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ER=
ROR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.96s=C2=A0 =C2=A0killed=
 by signal 6 SIGABRT<br>
248/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_gpio-test=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERROR=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01.05s=C2=A0 =C2=A0killed by si=
gnal 6 SIGABRT<br>
249/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_rng-test=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ER=
ROR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.97s=C2=A0 =C2=A0killed=
 by signal 6 SIGABRT<br>
250/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_sdhci-test=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERROR=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.97s=C2=A0 =C2=A0killed by=
 signal 6 SIGABRT<br>
251/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_smbus-test=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERROR=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.89s=C2=A0 =C2=A0killed by=
 signal 6 SIGABRT<br>
252/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_timer-test=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ERROR=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01.09s=C2=A0 =C2=A0killed by=
 signal 6 SIGABRT<br>
253/747 qemu:qtest+qtest-arm / qtest-arm/npcm_gmac-test=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ERROR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01.12s=C2=A0 =C2=A0k=
illed by signal 6 SIGABRT<br>
255/747 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_emc-test=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ER=
ROR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01.05s=C2=A0 =C2=A0killed=
 by signal 6 SIGABRT<br>
<br>
check-functional:<br>
=C2=A022/203 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_q=
uanta_gsj=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ERROR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.79s=C2=A0=
 =C2=A0exit status 1<br>
=C2=A038/203 qemu:func-quick+func-aarch64 / func-aarch64-migration=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ERROR=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01.97s=C2=A0 =C2=A0exit status 1<br>
=C2=A045/203 qemu:func-quick+func-arm / func-arm-migration=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ERROR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01.90s=C2=A0 =C2=A0=
exit status 1<br>
<br>
Signed-off-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@lina=
ro.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;<br></blockquo=
te><div>Reviewed-by: Hao Wu &lt;<a href=3D"mailto:wuhaotsh@google.com">wuha=
otsh@google.com</a>&gt;=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
---<br>
=C2=A0hw/misc/npcm_clk.c | 5 +++--<br>
=C2=A01 file changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/misc/npcm_clk.c b/hw/misc/npcm_clk.c<br>
index d1f29759d59..0e85974cf96 100644<br>
--- a/hw/misc/npcm_clk.c<br>
+++ b/hw/misc/npcm_clk.c<br>
@@ -964,8 +964,9 @@ static void npcm_clk_enter_reset(Object *obj, ResetType=
 type)<br>
=C2=A0 =C2=A0 =C2=A0NPCMCLKState *s =3D NPCM_CLK(obj);<br>
=C2=A0 =C2=A0 =C2=A0NPCMCLKClass *c =3D NPCM_CLK_GET_CLASS(s);<br>
<br>
-=C2=A0 =C2=A0 g_assert(sizeof(s-&gt;regs) &gt;=3D c-&gt;nr_regs * sizeof(u=
int32_t));<br>
-=C2=A0 =C2=A0 memcpy(s-&gt;regs, c-&gt;cold_reset_values, sizeof(s-&gt;reg=
s));<br>
+=C2=A0 =C2=A0 size_t sizeof_regs =3D c-&gt;nr_regs * sizeof(uint32_t);<br>
+=C2=A0 =C2=A0 g_assert(sizeof(s-&gt;regs) &gt;=3D sizeof_regs);<br>
+=C2=A0 =C2=A0 memcpy(s-&gt;regs, c-&gt;cold_reset_values, sizeof_regs);<br=
>
=C2=A0 =C2=A0 =C2=A0s-&gt;ref_ns =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);=
<br>
=C2=A0 =C2=A0 =C2=A0npcm7xx_clk_update_all_clocks(s);<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
-- <br>
2.39.5<br>
<br>
</blockquote></div></div>

--00000000000086fd1a062ee98ba8--

