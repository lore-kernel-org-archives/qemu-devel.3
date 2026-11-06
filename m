Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A6606A32E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cF22ZlCq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPPzP-0001OQ-4y; Fri, 06 Nov 2026 14:52:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xPPzO-0001OH-8g
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:52:42 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xPPzL-0003n4-7J
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:52:41 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b587538a37so1360097a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 11:52:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793994757; cv=none;
 d=google.com; s=arc-20260327;
 b=lV3Aqqlxn0zpbPXvLl/iiR1GB5cKuVVPwrmyA3W3izncqZp26GlgehIU5JQsWbtSUl
 SmV4/4G8lCctj0E2aLF4d5cX4y7PQw7PesJTQkNO1Pdtf0i/pi/u6wEBT0O0XSd4ECZG
 KHwxXolAvC0aIzpVmN5H6ZbLYhClq/lw1mpEe60H6FcYDfG9HT/dhjxpHyT7//g1zYFp
 kRlAVbA6fKa+Q4tJI71BMPM8tRb1kJ70sEm7m+ZKri6dyzjJMit+o4Bt1EXfBwPhKrpk
 tRMOxlDpfcnGYuIXAarO6GCbdfqe8deKsinyhXXMm4/IqW0G2mBZpxt2e84CekDoTUlP
 t7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=ot527T2XVPs6A5KI6osN3lfsmDMM74Oet7TPdw1EWj4=;
 fh=NMe96GAiLKSrd2j6VF4VASvf6rm/0Lv3LDgYXjvc75g=;
 b=mf1OckJYpzVTwLn6qiM89tP64+HoCOdifh239S7+6Q8q65k50Kg2WcihlY6G7GoFVb
 y9xtysHcIZZDpJnIXFKOqkVgDaAjqB+7SY4iJHTsFrGA3Y8xaa9HlSA7rVrXGuHX58a1
 N+WrOQweESJUP+j0rfNQ1oWytx0s/wSXLhNfkO2UEn2Qlcp4aolgXZ9UzAiosHJ6XGBS
 ccP4HoPdArKt+RDcyzX6FYu6OB5T71EeYeZYlf7ozDK5s/sLPXLzLPC27+ydUU4LsRJR
 iH9GMPW8InhFwEGxN8A+zPcb5apgyrhnCid4wdkyzq4lb9/nJFQA4gcP5SEd+lbjSpv1
 ZkAQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793994757; x=1794599557; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ot527T2XVPs6A5KI6osN3lfsmDMM74Oet7TPdw1EWj4=;
 b=cF22ZlCqVg+95qm/2Jx5FFJIfvrV3WgcpBW5VVQBehuY4nA+Vr/jEhmcgeQCqq42ls
 1mcZ7Xr3rt0qHMIIJzUReKLbMiXztnR+wIw2F2qTRuR+BX0AlW6myLLcnISCbKqqjNsN
 DiSF5B2D6FZ4SY9LC66XaxpOQMXYbzZoEbZSVUCkAC+7q0gLF+1wlHkCJnRBgZ7eL3c4
 oGURWL2z7vpLahKO8OnOxls3CP4miC0/AfnNQoVpCKUCtOz/sMIT3KovZL7XuI7ac/H+
 UYi1mpxW5k2cp3ZhMCWwr3QJVm1/MMhgDhctRaax+/aQyzxV/OgElSV/OC7utLB/HsRn
 1TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793994757; x=1794599557;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ot527T2XVPs6A5KI6osN3lfsmDMM74Oet7TPdw1EWj4=;
 b=Zx3VHtCPTq9RwqdBHhxalGW4dGdkBw8XhmDVE8YGn+oedmMaEZcgYo4kxpYSrS079V
 w2FtZQd5MZWv5M1jtzRsIV0O1I2Tz7bt7C9+Zjfv3iVFaq8o8CtSzmysEnrfqvTQsY/F
 +p/E4HjYVPIMLXx2UbeZiw/pJU96rbGSej3DJQuSejbq26bA8jiahbdSCKP3UhlpfN6q
 Nn1A746oodgRlx7vHKc56tTZjwZghA8/U+HAE80SnOvGxg2gyuosUBpggbWXYkDqc6Qe
 +RoSBlhmgM2mQZNnOsKPlW8sg4lUHYRdVp0rL+MY0F2lRIHAcVhSZyiBRnzulAkRTg8I
 oCbQ==
X-Gm-Message-State: APuU4Z+T+fCW2ccBFo+2Xo0ieq77LJY4dTL5hg45YSxtEXg1wGXrTCDo
 cOfrmEge4cuHERNGnCvr+C0k+yXY/YOxZam6/TefappoVA60txB/aV5vnbBe/+tOXFEuc6h2bUN
 XUh1okistDPuwC2GRLtCU4ywKhuZMwQU=
X-Gm-Gg: AYBFou0lIMYxLpR3ArNBTykY2EhTIPM5CD8jhJBN4qk588GDtWUY1aU3W9ep3s984A2
 jWnVmlXe+s4sD57yhGYOXnA7+2XQVNkNIWPaBqDbwmAbn/671yJG6U4U0j0NANJYygVBR703Ixi
 A5l62mEtAVAhxOjdR7vRZw7xm15gc0CniilHMOEh7aweox9qhcbO096hykhWEOQ/QoNZ/76bMzO
 V/ib3IygEwVyG9vltIatqjEsBUETLZj/jwzy6maHJ+APWdGMcfHouOl2SFabOdU7gR+Noztn9UM
 95qfwc6XoTTAwBpPHWixJasT3hLCAi2jHUT1RSiTmBwqyiWJJyB9eyKkI40KT1RDQt09yidDI7N
 LcQaJ8KXU5j5mEgwOg+HGAypZPkqojuhzbxqbvQ==
X-Received: by 2002:aa7:d30b:0:b0:6b5:4f86:3be2 with SMTP id
 4fb4d7f45d1cf-6b5977f756fmr1886794a12.35.1793994757183; Fri, 06 Nov 2026
 11:52:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105190346.1539-1-luoyonggang@gmail.com>
 <20261105190346.1539-3-luoyonggang@gmail.com>
 <f84768d9-1aa4-463d-a0f5-4844a4babe22@oss.qualcomm.com>
 <CAE2XoE_u9AhjKZxtocf-e=8SjgiJ5gURxJVmwoXHTu6uKWK9+g@mail.gmail.com>
 <93d749b2-aa50-4cdf-9343-7d7a11bc6a8c@oss.qualcomm.com>
In-Reply-To: <93d749b2-aa50-4cdf-9343-7d7a11bc6a8c@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 7 Nov 2026 03:52:24 +0800
X-Gm-Features: AclHuK85PberziWGNeL7A5AGI5kU6sK89zJr1BIeaxVvMH0vWlvXeibUMOB_b44
Message-ID: <CAE2XoE_rbBgArumXgWbG+GynNFF31248F_sB-nG+T4BEZjBPpQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] target-info: add target_mask_selected()
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 7, 2026 at 1:47=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 11/6/2026 9:46 AM, Yonggang Luo wrote:
> > On Sat, Nov 7, 2026 at 1:44=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 11/5/2026 11:03 AM, Yonggang Luo wrote:
> >>> Return the QEMU_ARCH_* mask of the selected target. System mode
> >>> returns QEMU_ARCH_ALL until a target is selected. User mode returns
> >>> that target's bit. Tools return 0.
> >>>
> >>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >>> ---
> >>>  include/qemu/target-info-init.h | 15 ++++++++++-----
> >>>  include/qemu/target-info.h      |  9 +++++++++
> >>>  stubs/meson.build               |  1 +
> >>>  stubs/target-mask-selected.c    | 13 +++++++++++++
> >>>  target-info-def.c               |  3 +++
> >>>  target-info-qom.c               | 10 ++++++++++
> >>>  6 files changed, 46 insertions(+), 5 deletions(-)
> >>>  create mode 100644 stubs/target-mask-selected.c
> >>>
> >>> diff --git a/include/qemu/target-info-init.h b/include/qemu/target-in=
fo-init.h
> >>> index b7024c9fae..8492986832 100644
> >>> --- a/include/qemu/target-info-init.h
> >>> +++ b/include/qemu/target-info-init.h
> >>> @@ -24,12 +24,17 @@ module_init(do_qemu_init_target_info, MODULE_INIT=
_TARGET_INFO)
> >>>
> >>>  /*
> >>>   * User mode does not support multiple targets in the same binary, s=
o just
> >>> - * define target_info().
> >>> + * define target_info() and target_mask_selected(). The target is al=
ways
> >>> + * selected.
> >>>   */
> >>> -#define target_info_init(ti_var)        \
> >>> -const TargetInfo *target_info(void)     \
> >>> -{                                       \
> >>> -    return &ti_var;                     \
> >>> +#define target_info_init(ti_var)                           \
> >>> +const TargetInfo *target_info(void)                        \
> >>> +{                                                          \
> >>> +    return &ti_var;                                        \
> >>> +}                                                          \
> >>> +uint64_t target_mask_selected(void)                        \
> >>> +{                                                          \
> >>> +    return QEMU_ARCH_BIT((ti_var).target_arch);            \
> >>>  }
> >>>
> >>>  #else /* CONFIG_USER_ONLY */
> >>> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> >>> index 2cd4cc5671..5673d10eba 100644
> >>> --- a/include/qemu/target-info.h
> >>> +++ b/include/qemu/target-info.h
> >>> @@ -134,4 +134,13 @@ bool target_base_riscv(void);
> >>>   */
> >>>  bool target_riscv64(void);
> >>>
> >>> +/**
> >>> + * target_mask_selected:
> >>> + *
> >>> + * Returns the QEMU_ARCH_* mask of the selected target. System mode
> >>> + * returns QEMU_ARCH_ALL until a target is selected. User mode retur=
ns
> >>> + * that target's bit. Tools return 0.
> >>> + */
> >>> +uint64_t target_mask_selected(void);
> >>> +
> >>>  #endif
> >>> diff --git a/stubs/meson.build b/stubs/meson.build
> >>> index 744fb759a2..49cede8582 100644
> >>> --- a/stubs/meson.build
> >>> +++ b/stubs/meson.build
> >>> @@ -12,6 +12,7 @@ stub_ss.add(files('monitor-hmp.c'))
> >>>  stub_ss.add(files('qapi-event-emit.c'))
> >>>  stub_ss.add(files('replay-mode.c'))
> >>>  stub_ss.add(files('trace-control.c'))
> >>> +stub_ss.add(files('target-mask-selected.c'))
> >>>
> >>
> >> For which configs is the stub required?
> >> target-info-def will always be present.
> >
> > For tools
> >
>
> Can you post the exact link error that exposes the absence of this symbol=
?

There is very much, I extract part of them:


[61/389] Linking target tests/fp/fp-test
FAILED: [code=3D1] tests/fp/fp-test
gcc -m64  -o tests/fp/fp-test
libevent-loop-base.a.p/event-loop-base.c.o
libqom.a.p/qom_container.c.o libqom.a.p/qom_object.c.o
libqom.a.p/qom_object_interfaces.c.o libqom.a.p/qom_qom-qobject.c.o
libqom.a.p/qom_compat-properties.c.o tests/fp/fp-test.p/fp-test.c.o
tests/fp/fp-test.p/.._.._fpu_softfloat.c.o -Wl,--as-needed
-Wl,--no-undefined -pie -fstack-protector-strong -Wl,-z,relro
-Wl,-z,now -Wl,--start-group libqemuutil.a
subprojects/libvhost-user/libvhost-user-glib.a
subprojects/libvhost-user/libvhost-user.a
subprojects/berkeley-softfloat-3/libsoftfloat.a
subprojects/berkeley-testfloat-3/libtestfloat.a
subprojects/berkeley-testfloat-3/libslowfloat.a -lnuma
/usr/lib/x86_64-linux-gnu/liburing.so
/usr/lib/x86_64-linux-gnu/libgio-2.0.so
/usr/lib/x86_64-linux-gnu/libgobject-2.0.so
/usr/lib/x86_64-linux-gnu/libglib-2.0.so -Wl,--export-dynamic
/usr/lib/x86_64-linux-gnu/libgmodule-2.0.so -pthread -lm
/usr/lib/x86_64-linux-gnu/libpixman-1.so
/usr/lib/x86_64-linux-gnu/libepoxy.so -Wl,--end-group
/usr/bin/x86_64-linux-gnu-ld.bfd: libqom.a.p/qom_object.c.o: in
function `type_register_internal':
/build/release-amd64/../../qom/object.c:243:(.text+0x1c2): undefined
reference to `target_mask_selected'
/usr/bin/x86_64-linux-gnu-ld.bfd: libqom.a.p/qom_object.c.o: in
function `target_mask_filter':
/build/release-amd64/../../qom/object.c:120:(.text+0x1df): undefined
reference to `target_mask_selected'
/usr/bin/x86_64-linux-gnu-ld.bfd:
/build/release-amd64/../../qom/object.c:120:(.text+0x37a): undefined
reference to`target_mask_selected'
/usr/bin/x86_64-linux-gnu-ld.bfd:
/build/release-amd64/../../qom/object.c:120:(.text+0x1ebf): undefined
reference to `target_mask_selected'
collect2: error: ld returned 1 exit status
[62/389] Linking target tests/bench/benchmark-crypto-akcipher
FAILED: [code=3D1] tests/bench/benchmark-crypto-akcipher
gcc -m64  -o tests/bench/benchmark-crypto-akcipher
libevent-loop-base.a.p/event-loop-base.c.o
libqom.a.p/qom_container.c.o libqom.a.p/qom_object.c.o
libqom.a.p/qom_object_interfaces.c.o libqom.a.p/qom_qom-qobject.c.o
libqom.a.p/qom_compat-properties.c.o libcrypto.a.p/crypto_afsplit.c.o
libcrypto.a.p/crypto_akcipher.c.o libcrypto.a.p/crypto_block-luks.c.o
libcrypto.a.p/crypto_block-qcow.c.o libcrypto.a.p/crypto_block.c.o
libcrypto.a.p/crypto_cipher.c.o libcrypto.a.p/crypto_der.c.o
libcrypto.a.p/crypto_hash.c.o libcrypto.a.p/crypto_hmac.c.o
libcrypto.a.p/crypto_ivgen-essiv.c.o
libcrypto.a.p/crypto_ivgen-plain.c.o
libcrypto.a.p/crypto_ivgen-plain64.c.o libcrypto.a.p/crypto_ivgen.c.o
libcrypto.a.p/crypto_pbkdf.c.o libcrypto.a.p/crypto_secret_common.c.o
libcrypto.a.p/crypto_secret.c.o libcrypto.a.p/crypto_tlscreds.c.o
libcrypto.a.p/crypto_tlscredsanon.c.o
libcrypto.a.p/crypto_tlscredspsk.c.o
libcrypto.a.p/crypto_tlscredsx509.c.o
libcrypto.a.p/crypto_tlssession.c.o libcrypto.a.p/crypto_rsakey.c.o
libcrypto.a.p/crypto_x509-utils.c.o
libcrypto.a.p/crypto_hash-nettle.c.o
libcrypto.a.p/crypto_hmac-nettle.c.o
libcrypto.a.p/crypto_pbkdf-nettle.c.o
libcrypto.a.p/crypto_secret_keyring.c.o libauthz.a.p/authz_base.c.o
libauthz.a.p/authz_list.c.o libauthz.a.p/authz_listfile.c.o
libauthz.a.p/authz_simple.c.o
tests/bench/benchmark-crypto-akcipher.p/benchmark-crypto-akcipher.c.o
-Wl,--as-needed -Wl,--no-undefined -pie -fstack-protector-strong
-Wl,-z,relro -Wl,-z,now -Wl,--start-group libqemuutil.a
subprojects/libvhost-user/libvhost-user-glib.a
subprojects/libvhost-user/libvhost-user.a
/usr/lib/x86_64-linux-gnu/libnettle.so
/usr/lib/x86_64-linux-gnu/libgmp.so
/usr/lib/x86_64-linux-gnu/libhogweed.so -lnuma
/usr/lib/x86_64-linux-gnu/liburing.so
/usr/lib/x86_64-linux-gnu/libgio-2.0.so
/usr/lib/x86_64-linux-gnu/libgobject-2.0.so
/usr/lib/x86_64-linux-gnu/libglib-2.0.so -Wl,--export-dynamic
/usr/lib/x86_64-linux-gnu/libgmodule-2.0.so -pthread -lm
/usr/lib/x86_64-linux-gnu/libpixman-1.so
/usr/lib/x86_64-linux-gnu/libepoxy.so -Wl,--end-group
/usr/bin/x86_64-linux-gnu-ld.bfd: libqom.a.p/qom_object.c.o: in
function `type_register_internal':
/build/release-amd64/../../qom/object.c:243:(.text+0x1c2): undefined
reference to `target_mask_selected'
/usr/bin/x86_64-linux-gnu-ld.bfd: libqom.a.p/qom_object.c.o: in
function `target_mask_filter':
/build/release-amd64/../../qom/object.c:120:(.text+0x1df): undefined
reference to `target_mask_selected'
/usr/bin/x86_64-linux-gnu-ld.bfd:
/build/release-amd64/../../qom/object.c:120:(.text+0x37a): undefined
reference to`target_mask_selected'
/usr/bin/x86_64-linux-gnu-ld.bfd:
/build/release-amd64/../../qom/object.c:120:(.text+0x1ebf): undefined
reference to `target_mask_selected'
collect2: error: ld returned 1 exit status
[63/389] Linking target tests/bench/benchmark-crypto-hash
FAILED: [code=3D1] tests/bench/benchmark-crypto-hash
gcc -m64  -o tests/bench/benchmark-crypto-hash
libevent-loop-base.a.p/event-loop-base.c.o
libqom.a.p/qom_container.c.o libqom.a.p/qom_object.c.o
libqom.a.p/qom_object_interfaces.c.o libqom.a.p/qom_qom-qobject.c.o
libqom.a.p/qom_compat-properties.c.o libcrypto.a.p/crypto_afsplit.c.o
libcrypto.a.p/crypto_akcipher.c.o libcrypto.a.p/crypto_block-luks.c.o
libcrypto.a.p/crypto_block-qcow.c.o libcrypto.a.p/crypto_block.c.o
libcrypto.a.p/crypto_cipher.c.o libcrypto.a.p/crypto_der.c.o
libcrypto.a.p/crypto_hash.c.o libcrypto.a.p/crypto_hmac.c.o
libcrypto.a.p/crypto_ivgen-essiv.c.o
libcrypto.a.p/crypto_ivgen-plain.c.o
libcrypto.a.p/crypto_ivgen-plain64.c.o libcrypto.a.p/crypto_ivgen.c.o
libcrypto.a.p/crypto_pbkdf.c.o libcrypto.a.p/crypto_secret_common.c.o
libcrypto.a.p/crypto_secret.c.o libcrypto.a.p/crypto_tlscreds.c.o
libcrypto.a.p/crypto_tlscredsanon.c.o
libcrypto.a.p/crypto_tlscredspsk.c.o
libcrypto.a.p/crypto_tlscredsx509.c.o
libcrypto.a.p/crypto_tlssession.c.o libcrypto.a.p/crypto_rsakey.c.o
libcrypto.a.p/crypto_x509-utils.c.o
libcrypto.a.p/crypto_hash-nettle.c.o
libcrypto.a.p/crypto_hmac-nettle.c.o
libcrypto.a.p/crypto_pbkdf-nettle.c.o
libcrypto.a.p/crypto_secret_keyring.c.o libauthz.a.p/authz_base.c.o
libauthz.a.p/authz_list.c.o libauthz.a.p/authz_listfile.c.o
libauthz.a.p/authz_simple.c.o
tests/bench/benchmark-crypto-hash.p/benchmark-crypto-hash.c.o
-Wl,--as-needed -Wl,--no-undefined -pie -fstack-protector-strong
-Wl,-z,relro -Wl,-z,now -Wl,--start-group libqemuutil.a
subprojects/libvhost-user/libvhost-user-glib.a
subprojects/libvhost-user/libvhost-user.a
/usr/lib/x86_64-linux-gnu/libnettle.so
/usr/lib/x86_64-linux-gnu/libgmp.so
/usr/lib/x86_64-linux-gnu/libhogweed.so -lnuma
/usr/lib/x86_64-linux-gnu/liburing.so
/usr/lib/x86_64-linux-gnu/libgio-2.0.so
/usr/lib/x86_64-linux-gnu/libgobject-2.0.so
/usr/lib/x86_64-linux-gnu/libglib-2.0.so -Wl,--export-dynamic
/usr/lib/x86_64-linux-gnu/libgmodule-2.0.so -pthread -lm
/usr/lib/x86_64-linux-gnu/libpixman-1.so
/usr/lib/x86_64-linux-gnu/libepoxy.so -Wl,--end-group
/usr/bin/x86_64-linux-gnu-ld.bfd: libqom.a.p/qom_object.c.o: in
function `type_register_internal':
/build/release-amd64/../../qom/object.c:243:(.text+0x1c2): undefined
reference to `target_mask_selected'
/usr/bin/x86_64-linux-gnu-ld.bfd: libqom.a.p/qom_object.c.o: in
function `target_mask_filter':
/build/release-amd64/../../qom/object.c:120:(.text+0x1df): undefined
reference to `target_mask_selected'
/usr/bin/x86_64-linux-gnu-ld.bfd:
/build/release-amd64/../../qom/object.c:120:(.text+0x37a): undefined
reference to`target_mask_selected'
/usr/bin/x86_64-linux-gnu-ld.bfd:
/build/release-amd64/../../qom/object.c:120:(.text+0x1ebf): undefined
reference to `target_mask_selected'
collect2: error: ld returned 1 exit status
[64/389] Linking target tools/qemu-vnc/qemu-vnc
FAILED: [code=3D1] tools/qemu-vnc/qemu-vnc
gcc -m64  -o tools/qemu-vnc/qemu-vnc
tools/qemu-vnc/qemu-vnc.p/meson-generated_.._.._.._ui_dbus-display1.c.o
tools/qemu-vnc/qemu-vnc.p/meson-generated_.._qemu-vnc1.c.o
libio.a.p/io_channel-buffer.c.o libio.a.p/io_channel-command.c.o
libio.a.p/io_channel-file.c.o libio.a.p/io_channel-null.c.o
libio.a.p/io_channel-socket.c.o libio.a.p/io_channel-tls.c.o
libio.a.p/io_channel-util.c.o libio.a.p/io_channel-watch.c.o
libio.a.p/io_channel-websock.c.o libio.a.p/io_channel.c.o
libio.a.p/io_dns-resolver.c.o libio.a.p/io_net-listener.c.o
libio.a.p/io_task.c.o libcrypto.a.p/crypto_afsplit.c.o
libcrypto.a.p/crypto_akcipher.c.o libcrypto.a.p/crypto_block-luks.c.o
libcrypto.a.p/crypto_block-qcow.c.o libcrypto.a.p/crypto_block.c.o
libcrypto.a.p/crypto_cipher.c.o libcrypto.a.p/crypto_der.c.o
libcrypto.a.p/crypto_hash.c.o libcrypto.a.p/crypto_hmac.c.o
libcrypto.a.p/crypto_ivgen-essiv.c.o
libcrypto.a.p/crypto_ivgen-plain.c.o
libcrypto.a.p/crypto_ivgen-plain64.c.o libcrypto.a.p/crypto_ivgen.c.o
libcrypto.a.p/crypto_pbkdf.c.o libcrypto.a.p/crypto_secret_common.c.o
libcrypto.a.p/crypto_secret.c.o libcrypto.a.p/crypto_tlscreds.c.o
libcrypto.a.p/crypto_tlscredsanon.c.o
libcrypto.a.p/crypto_tlscredspsk.c.o
libcrypto.a.p/crypto_tlscredsx509.c.o
libcrypto.a.p/crypto_tlssession.c.o libcrypto.a.p/crypto_rsakey.c.o
libcrypto.a.p/crypto_x509-utils.c.o
libcrypto.a.p/crypto_hash-nettle.c.o
libcrypto.a.p/crypto_hmac-nettle.c.o
libcrypto.a.p/crypto_pbkdf-nettle.c.o
libcrypto.a.p/crypto_secret_keyring.c.o libauthz.a.p/authz_base.c.o
libauthz.a.p/authz_list.c.o libauthz.a.p/authz_listfile.c.o
libauthz.a.p/authz_simple.c.o libqom.a.p/qom_container.c.o
libqom.a.p/qom_object.c.o libqom.a.p/qom_object_interfaces.c.o
libqom.a.p/qom_qom-qobject.c.o libqom.a.p/qom_compat-properties.c.o
libevent-loop-base.a.p/event-loop-base.c.o
ui/libqemuui.a.p/clipboard.c.o ui/libqemuui.a.p/console.c.o
ui/libqemuui.a.p/cursor.c.o ui/libqemuui.a.p/dmabuf.c.o
ui/libqemuui.a.p/display-surface.c.o ui/libqemuui.a.p/input-keymap.c.o
ui/libqemuui.a.p/kbd-state.c.o ui/libqemuui.a.p/keymaps.c.o
ui/libqemuui.a.p/qemu-pixman.c.o ui/libqemuui.a.p/spice-module.c.o
ui/libqemuui.a.p/vgafont.c.o ui/libqemuui.a.p/cp437.c.o
ui/libqemuui.a.p/vt100.c.o tools/qemu-vnc/qemu-vnc.p/qemu-vnc.c.o
tools/qemu-vnc/qemu-vnc.p/display.c.o
tools/qemu-vnc/qemu-vnc.p/input.c.o
tools/qemu-vnc/qemu-vnc.p/audio.c.o
tools/qemu-vnc/qemu-vnc.p/chardev.c.o
tools/qemu-vnc/qemu-vnc.p/clipboard.c.o
tools/qemu-vnc/qemu-vnc.p/console.c.o
tools/qemu-vnc/qemu-vnc.p/dbus.c.o tools/qemu-vnc/qemu-vnc.p/stubs.c.o
tools/qemu-vnc/qemu-vnc.p/utils.c.o
tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc.c.o
tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-enc-zlib.c.o
tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-enc-hextile.c.o
tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-enc-tight.c.o
tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-palette.c.o
tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-enc-zrle.c.o
tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-auth-vencrypt.c.o
tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-ws.c.o
tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-jobs.c.o
tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-clipboard.c.o
tools/qemu-vnc/qemu-vnc.p/.._.._ui_vnc-auth-sasl.c.o -Wl,--as-needed
-Wl,--no-undefined -pie -fstack-protector-strong -Wl,-z,relro
-Wl,-z,now -Wl,--start-group libqemuutil.a
subprojects/libvhost-user/libvhost-user-glib.a
subprojects/libvhost-user/libvhost-user.a
/usr/lib/x86_64-linux-gnu/libz.so /usr/lib/x86_64-linux-gnu/libjpeg.so
/usr/lib/x86_64-linux-gnu/libpng16.so -lsasl2
/usr/lib/x86_64-linux-gnu/libnettle.so
/usr/lib/x86_64-linux-gnu/libgmp.so
/usr/lib/x86_64-linux-gnu/libhogweed.so
/usr/lib/x86_64-linux-gnu/libgio-2.0.so/usr/lib/x86_64-linux-gnu/libgobject=
-2.0.so
/usr/lib/x86_64-linux-gnu/libglib-2.0.so
/usr/lib/x86_64-linux-gnu/libpixman-1.so -lnuma
/usr/lib/x86_64-linux-gnu/liburing.so -Wl,--export-dynamic
/usr/lib/x86_64-linux-gnu/libgmodule-2.0.so -pthread -lm
/usr/lib/x86_64-linux-gnu/libepoxy.so -Wl,--end-group
/usr/bin/x86_64-linux-gnu-ld.bfd: libqom.a.p/qom_object.c.o: in
function `type_register_internal':
/build/release-amd64/../../qom/object.c:243:(.text+0x1c2): undefined
reference to `target_mask_selected'
/usr/bin/x86_64-linux-gnu-ld.bfd: libqom.a.p/qom_object.c.o: in
function `target_mask_filter':
/build/release-amd64/../../qom/object.c:120:(.text+0x1df): undefined
reference to `target_mask_selected'
/usr/bin/x86_64-linux-gnu-ld.bfd:
/build/release-amd64/../../qom/object.c:120:(.text+0x37a): undefined
reference to`target_mask_selected'
/usr/bin/x86_64-linux-gnu-ld.bfd:
/build/release-amd64/../../qom/object.c:120:(.text+0x1ebf): undefined
reference to `target_mask_selected'
collect2: error: ld returned 1 exit status
[65/389] Generating block.syms with a custom command (wrapped by meson
to capture output)
[66/389] Generating qemu.syms with a custom command (wrapped by meson
to capture output)


>
> >>
> >>>  if have_block
> >>>    stub_ss.add(files('bdrv-next-monitor-owned.c'))
> >>> diff --git a/stubs/target-mask-selected.c b/stubs/target-mask-selecte=
d.c
> >>> new file mode 100644
> >>> index 0000000000..510a515851
> >>> --- /dev/null
> >>> +++ b/stubs/target-mask-selected.c
> >>> @@ -0,0 +1,13 @@
> >>> +/*
> >>> + * Tools have no selected target.
> >>> + *
> >>> + * SPDX-License-Identifier: GPL-2.0-or-later
> >>> + */
> >>> +
> >>> +#include "qemu/osdep.h"
> >>> +#include "qemu/target-info.h"
> >>> +
> >>> +uint64_t target_mask_selected(void)
> >>> +{
> >>> +    return 0;
> >>> +}
> >>> diff --git a/target-info-def.c b/target-info-def.c
> >>> index bcf9cfe1e4..a992019626 100644
> >>> --- a/target-info-def.c
> >>> +++ b/target-info-def.c
> >>> @@ -9,6 +9,9 @@
> >>>  #include "qemu/osdep.h"
> >>>  #include "qemu/target-info.h"
> >>>  #include "qemu/target-info-def.h"
> >>> +#ifdef CONFIG_USER_ONLY
> >>> +#include "qemu/base-arch-defs.h"
> >>> +#endif
> >>>  #include "qemu/target-info-init.h"
> >>>  #include "hw/core/boards.h"
> >>>  #include "cpu.h"
> >>> diff --git a/target-info-qom.c b/target-info-qom.c
> >>> index aeeedb7e81..fb4c9835e5 100644
> >>> --- a/target-info-qom.c
> >>> +++ b/target-info-qom.c
> >>> @@ -9,6 +9,8 @@
> >>>  #include "qemu/osdep.h"
> >>>  #include "qapi/error.h"
> >>>  #include "qom/object.h"
> >>> +#include "qemu/base-arch-defs.h"
> >>> +#include "qemu/target-info.h"
> >>>  #include "qemu/target-info-def.h"
> >>>  #include "qemu/target-info-init.h"
> >>>  #include "qemu/target-info-qom.h"
> >>> @@ -40,6 +42,14 @@ const TargetInfo *target_info(void)
> >>>      return target_info_ptr;
> >>>  }
> >>>
> >>> +uint64_t target_mask_selected(void)
> >>> +{
> >>> +    if (!target_info_ptr) {
> >>> +        return QEMU_ARCH_ALL;
> >>> +    }
> >>> +    return QEMU_ARCH_BIT(target_info_ptr->target_arch);
> >>> +}
> >>> +
> >>>  void target_info_qom_set_target(void)
> >>>  {
> >>>      g_autoptr(GSList) targets =3D object_class_get_list(TYPE_TARGET_=
INFO, false);
> >>
> >
> >
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

