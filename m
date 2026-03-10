Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB27EB1071
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzywK-0008Ek-65; Tue, 10 Mar 2026 11:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzywB-0008Dj-JP
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:24:01 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vzyw9-0002il-0G
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:23:58 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D4215BCF5;
 Tue, 10 Mar 2026 15:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773156234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3cMk/ySMl8VABt8Qa3s6UeC3B6lqA1pqOPEJQ4wKCPE=;
 b=yfnpz1EABhoNcDMqmDUHC4QFkExVKjLdEPY0OAPpiwXBHQgz3/zOww1gjXFzrK+VMVgj0J
 fwNq/ibq784WAcJ2mVpRGTrbKCqQFEYjyHk7gcsArKQG9ZDF4tE30XodUw3cV4mc/QuSfa
 v0LpgDSX7BcMdZYW2YkME32zkNAEUwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773156234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3cMk/ySMl8VABt8Qa3s6UeC3B6lqA1pqOPEJQ4wKCPE=;
 b=HbwhgepLZSmNvvdL9ZkUAsOAmeHqX6kHNOQUE5iVqhG3weP95ikW1Y6vH/jNGLCmCI/pnU
 8TrOxYIEaRXCM3BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773156234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3cMk/ySMl8VABt8Qa3s6UeC3B6lqA1pqOPEJQ4wKCPE=;
 b=yfnpz1EABhoNcDMqmDUHC4QFkExVKjLdEPY0OAPpiwXBHQgz3/zOww1gjXFzrK+VMVgj0J
 fwNq/ibq784WAcJ2mVpRGTrbKCqQFEYjyHk7gcsArKQG9ZDF4tE30XodUw3cV4mc/QuSfa
 v0LpgDSX7BcMdZYW2YkME32zkNAEUwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773156234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3cMk/ySMl8VABt8Qa3s6UeC3B6lqA1pqOPEJQ4wKCPE=;
 b=HbwhgepLZSmNvvdL9ZkUAsOAmeHqX6kHNOQUE5iVqhG3weP95ikW1Y6vH/jNGLCmCI/pnU
 8TrOxYIEaRXCM3BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDF9F3F50C;
 Tue, 10 Mar 2026 15:23:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vWL5IIk3sGkUUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Mar 2026 15:23:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PULL 27/49] meson: Add -Wformat-overflow=2
In-Reply-To: <CAFEAcA8DpJno_LRrxyjMxDx5gqH_m_PNeqtZxnkg9mZ_QwbzFg@mail.gmail.com>
References: <20260309155219.62400-1-philmd@linaro.org>
 <20260309155219.62400-28-philmd@linaro.org> <87h5qn23v5.fsf@suse.de>
 <CAFEAcA8DpJno_LRrxyjMxDx5gqH_m_PNeqtZxnkg9mZ_QwbzFg@mail.gmail.com>
Date: Tue, 10 Mar 2026 12:23:51 -0300
Message-ID: <87bjgv1zeg.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid, suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 10 Mar 2026 at 13:47, Fabiano Rosas <farosas@suse.de> wrote:
>> ../tests/qtest/ast2700-sgpio-test.c: In function =E2=80=98test_output_pi=
ns=E2=80=99:
>> ../tests/qtest/ast2700-sgpio-test.c:27:33: error: =E2=80=98sprintf=E2=80=
=99 may write a
>> terminating nul past the end of the destination
>> [-Werror=3Dformat-overflow=3D]
>>
>> ../tests/qtest/ast2700-sgpio-test.c: In function =E2=80=98test_irq_level=
_high=E2=80=99:
>> ../tests/qtest/ast2700-sgpio-test.c:85:33: error: =E2=80=98sprintf=E2=80=
=99 may write a
>> terminating nul past the end of the destination
>> [-Werror=3Dformat-overflow=3D]
>>
>> ../tests/qtest/arm-cpu-features.c: In function =E2=80=98test_query_cpu_m=
odel_expansion_kvm=E2=80=99:
>> ../tests/qtest/arm-cpu-features.c:578:35: error: =E2=80=98%u=E2=80=99 di=
rective writing
>> between 1 and 10 bytes into a region of size 5
>> [-Werror=3Dformat-overflow=3D]
>>
>> ../configure
>> --target-list=3Dx86_64-softmmu,i386-softmmu,aarch64-softmmu,arm-softmmu,=
ppc64-softmmu,s390x-softmmu,riscv64-softmmu,aarch64-linux-user,loongarch64-=
softmmu
>> --disable-plugins --enable-modules --enable-werror
>> --enable-trace-backends=3Dlog,dtrace --enable-debug --enable-docs
>> --enable-rust --enable-strict-rust-lints
>
> Could you do a configure with all targets enabled and a make with
> "-k" so we can check that these are all the source files your gcc
> complains about, please?
>

Yep, it's just these ones:

tests/qtest/ast2700-gpio-test.p/ast2700-gpio-test.c.o
tests/qtest/ast2700-sgpio-test.p/ast2700-sgpio-test.c.o
tests/qtest/arm-cpu-features.p/arm-cpu-features.c.o
tests/qtest/aspeed_gpio-test.p/aspeed_gpio-test.c.o


[5862/6179] Compiling C object tests/qtest/ast2700-gpio-test.p/ast2700-gpio=
-test.c.o
FAILED: tests/qtest/ast2700-gpio-test.p/ast2700-gpio-test.c.o
../tests/qtest/ast2700-gpio-test.c: In function =E2=80=98test_input_pins=E2=
=80=99:
../tests/qtest/ast2700-gpio-test.c:54:36: error: =E2=80=98sprintf=E2=80=99 =
may write a terminating nul past the end of the destination [-Werror=3Dform=
at-overflow=3D]
             sprintf(name, "gpio%c%d", c, i);
                                    ^
../tests/qtest/ast2700-gpio-test.c:54:13: note: =E2=80=98sprintf=E2=80=99 o=
utput between 7 and 17 bytes into a destination of size 16
             sprintf(name, "gpio%c%d", c, i);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


[5875/6179] Compiling C object tests/qtest/ast2700-sgpio-test.p/ast2700-sgp=
io-test.c.o
FAILED: tests/qtest/ast2700-sgpio-test.p/ast2700-sgpio-test.c.o
../tests/qtest/ast2700-sgpio-test.c: In function =E2=80=98test_output_pins=
=E2=80=99:
../tests/qtest/ast2700-sgpio-test.c:27:33: error: =E2=80=98sprintf=E2=80=99=
 may write a terminating nul past the end of the destination [-Werror=3Dfor=
mat-overflow=3D]
         sprintf(name, "sgpio%03d", i * 2 + 1);
                                 ^
../tests/qtest/ast2700-sgpio-test.c:27:9: note: =E2=80=98sprintf=E2=80=99 o=
utput between 9 and 17 bytes into a destination of size 16
         sprintf(name, "sgpio%03d", i * 2 + 1);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../tests/qtest/ast2700-sgpio-test.c: In function =E2=80=98test_input_pins=
=E2=80=99:
../tests/qtest/ast2700-sgpio-test.c:54:33: error: =E2=80=98sprintf=E2=80=99=
 may write a terminating nul past the end of the destination [-Werror=3Dfor=
mat-overflow=3D]
         sprintf(name, "sgpio%03d", i * 2);
                                 ^
../tests/qtest/ast2700-sgpio-test.c:54:9: note: =E2=80=98sprintf=E2=80=99 o=
utput between 9 and 17 bytes into a destination of size 16
         sprintf(name, "sgpio%03d", i * 2);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../tests/qtest/ast2700-sgpio-test.c: In function =E2=80=98test_irq_level_hi=
gh=E2=80=99:
../tests/qtest/ast2700-sgpio-test.c:85:33: error: =E2=80=98sprintf=E2=80=99=
 may write a terminating nul past the end of the destination [-Werror=3Dfor=
mat-overflow=3D]
         sprintf(name, "sgpio%03d", i * 2);
                                 ^
../tests/qtest/ast2700-sgpio-test.c:85:9: note: =E2=80=98sprintf=E2=80=99 o=
utput between 9 and 17 bytes into a destination of size 16
         sprintf(name, "sgpio%03d", i * 2);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


[5896/6179] Compiling C object tests/qtest/arm-cpu-features.p/arm-cpu-featu=
res.c.o
FAILED: tests/qtest/arm-cpu-features.p/arm-cpu-features.c.o
../tests/qtest/arm-cpu-features.c: In function =E2=80=98test_query_cpu_mode=
l_expansion_kvm=E2=80=99:
../tests/qtest/arm-cpu-features.c:578:35: error: =E2=80=98%u=E2=80=99 direc=
tive writing between 1 and 10 bytes into a region of size 5 [-Werror=3Dform=
at-overflow=3D]
             sprintf(max_name, "sve%u", max_vq * 128);
                                   ^~
../tests/qtest/arm-cpu-features.c:578:13: note: =E2=80=98sprintf=E2=80=99 o=
utput between 5 and 14 bytes into a destination of size 8
             sprintf(max_name, "sve%u", max_vq * 128);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../tests/qtest/arm-cpu-features.c:598:35: error: =E2=80=98%u=E2=80=99 direc=
tive writing between 1 and 10 bytes into a region of size 5 [-Werror=3Dform=
at-overflow=3D]
                 sprintf(name, "sve%u", vq * 128);
                                   ^~
../tests/qtest/arm-cpu-features.c:598:17: note: =E2=80=98sprintf=E2=80=99 o=
utput between 5 and 14 bytes into a destination of size 8
                 sprintf(name, "sve%u", vq * 128);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../tests/qtest/arm-cpu-features.c:611:31: error: =E2=80=98%u=E2=80=99 direc=
tive writing between 1 and 10 bytes into a region of size 5 [-Werror=3Dform=
at-overflow=3D]
             sprintf(name, "sve%u", vq * 128);
                               ^~
../tests/qtest/arm-cpu-features.c:611:13: note: =E2=80=98sprintf=E2=80=99 o=
utput between 5 and 14 bytes into a destination of size 8
             sprintf(name, "sve%u", vq * 128);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../tests/qtest/arm-cpu-features.c:623:35: error: =E2=80=98%u=E2=80=99 direc=
tive writing between 1 and 10 bytes into a region of size 5 [-Werror=3Dform=
at-overflow=3D]
                 sprintf(name, "sve%u", vq * 128);
                                   ^~
../tests/qtest/arm-cpu-features.c:623:17: note: =E2=80=98sprintf=E2=80=99 o=
utput between 5 and 14 bytes into a destination of size 8
                 sprintf(name, "sve%u", vq * 128);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


[5974/6179] Compiling C object tests/qtest/aspeed_gpio-test.p/aspeed_gpio-t=
est.c.o
FAILED: tests/qtest/aspeed_gpio-test.p/aspeed_gpio-test.c.o
../tests/qtest/aspeed_gpio-test.c: In function =E2=80=98test_set_input_pins=
=E2=80=99:
../tests/qtest/aspeed_gpio-test.c:149:36: error: =E2=80=98sprintf=E2=80=99 =
may write a terminating nul past the end of the destination [-Werror=3Dform=
at-overflow=3D]
             sprintf(name, "gpio%c%d", c, i);
                                    ^
../tests/qtest/aspeed_gpio-test.c:149:13: note: =E2=80=98sprintf=E2=80=99 o=
utput between 7 and 17 bytes into a destination of size 16
             sprintf(name, "gpio%c%d", c, i);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

