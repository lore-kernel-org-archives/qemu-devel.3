Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE15C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9uT-0004bN-09; Wed, 12 Aug 2026 10:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu9uN-0004av-Ey
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:26:21 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu9uL-000808-6g
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:26:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso753829f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786544774; x=1787149574; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YcnO3Xh+742FjPBkq0WdAKT2ki4ZGetAVbaOfDKx9sc=;
 b=aLXiD7PMacrHVUgTGOzo7b7kNzrQA1wE+d28mUkLXCLTEWBPOuLcuBtIJMgrBo0sXM
 uJNjRBO/Nxn1GgmnZs6kSR5JhiXw/xxDCqtVLheq+fSoCD4yueBHpcwrmmvEY26cNNHD
 ioLzcmS323uLpDjaju5cZ9xo6B9vJ0eSFWeadXME2C3LtBKA86ceSpQQ8sh2Pnij1K1+
 WR8HpYSz5BwD1knZ/8IkvsSO1R8annAxFdsF1wbkiYWjT37aUwSW/TzVz6u394UqJKZm
 xI8e4RJAXM9xUXndwbjEE6XvoaeComdH10r51OEnmCHPMtTf3alDtiObv7xick2ojMhD
 kFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786544774; x=1787149574;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YcnO3Xh+742FjPBkq0WdAKT2ki4ZGetAVbaOfDKx9sc=;
 b=j0LWKQVVqEtTNg9SikgFJRsPpjSqibRD/zZZpiZL+X8Uq6mkQMt78k8B/sNLM/8f0v
 Z2dzg5lgQxx3i2jnsNukF5jy9n0zMTO/WptQf3l1AHIVIg118CtVNYkISV7K42zk/gG4
 Ep4FupjGhA5RBizTqtixcaeqLUrw+gjvUIFDR3bPukAGGCgSF2i64SxfqLOJWvS0uhrc
 D8J7pwVgOPdNK1Y+OfDCfya81I9ExzHo0sA+5PCjNtp+L6DDFj/mmNbnnSTji4CmZ0du
 +6myxeTNUk0e1fcG8PuLqrsDkVFXImw9MjxpcVDVluD/SbGFhNhCHJAuxi+QhjMdOD89
 EnNw==
X-Gm-Message-State: AOJu0YxWBK5XvynfF1RJmbX9cw9+HSIkCIhX9bMEkxnjzFYP/fxUGici
 QVD8jQOdD/WxGdwroR2iY85UTSYl5HrttFV4sXdFJYQ60DRovFHIh2Q6k0o1kLqyZVw=
X-Gm-Gg: AR+sD12CAiAyndjukh4DMNqR/o06qEy75lsWjrxeemrXNCBRmEYuxFiRPbA/NCRRnC2
 U81GhJ2D1OgQgYeFOFWVWffsEodrl+fMSA1+lPeBbY07hP5BsydKPGgyqcCtssPQue2oI+KDKHY
 Do54EtjO1I+fg1kg8RV1TGYXyKK6LiZG5odIvXY0CFA/YUZ5EbwbXmGp/Owqp95mrBZjGMbyyaY
 e1Hbm+WvYSm8F3vwDj9pKrFxiih9OoULRIP6vFx4kZ3PnBGpKvptNfVUA+YnX6i7WXEv21BugTm
 mRC+yZTrvyRa/B79a4cH0G8UW1luhW+BAbMcJKGcCTZIkHK3/Sj8XghI5mAUl3osfW6M7rpmew1
 YHte4FRAehia6vezlx4y2NSSADqcYr3oSuNTHhs2jx5fhcoAIIpHhi1nqs6uR2YrYxUUkYyJcsH
 wIBk6U2f0F5iLB+13TGGVo/KKWNoIWqTdZmUGCIYZ1+gzA7sTmR2UuAy+Egasa
X-Received: by 2002:a05:6000:481b:b0:47f:8f8f:db74 with SMTP id
 ffacd0b85a97d-481528bb7e1mr8346944f8f.12.1786544774200; 
 Wed, 12 Aug 2026 07:26:14 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150bf7767sm7169206f8f.5.2026.08.12.07.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 07:26:13 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0EDDB5F886;
 Wed, 12 Aug 2026 15:26:12 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Helge Deller <deller@gmx.de>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v6 041/103] tests/tcg/aarch64: system tests
In-Reply-To: <20260728044248.137626-42-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 27 Jul 2026 21:41:45 -0700")
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-42-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Wed, 12 Aug 2026 15:26:12 +0100
Message-ID: <87jypvza7v.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
<snip>
>  # Multi arch tests
> diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/sys=
tem/meson.build
> new file mode 100644
> index 00000000000..9c31694fbac
> --- /dev/null
> +++ b/tests/tcg/aarch64/system/meson.build
> @@ -0,0 +1,108 @@
> +tests =3D []
> +
> +minilib_dir =3D meson.current_source_dir() / '..' / '..' / 'minilib'
> +minilib_printf =3D files(minilib_dir / 'printf.c')[0]
> +link_script =3D files('kernel.ld')[0]
> +boot =3D files('boot.S')[0]
> +cflags =3D ['-nostdlib',

We need a -ffreestanding here

> +          '-Wa,--noexecstack',
> +          '-I', minilib_dir, minilib_printf, boot,
> +          '-Wl,-T', link_script]
> +qemu_base_args =3D ['-display', 'none',
> +                  '-semihosting-config', 'enable=3Don',
> +                  '-kernel']
> +qemu_def_args =3D ['-M', 'virt', '-cpu', 'max', qemu_base_args]
> +
> +# Multi arch tests - add cflags only once per src
> +multi_src =3D []
> +foreach t: tcg_tests['multiarch-softmmu']['tests']
> +  foreach src, setup: t
> +    new_cflags =3D cflags
> +    if fs.stem(src) =3D=3D 'memory'
> +      new_cflags +=3D '-DCHECK_UNALIGNED=3D1'
> +    endif
> +    if src not in multi_src
> +      setup +=3D {'cflags': [new_cflags]}
> +      multi_src +=3D src
> +    endif
> +    tests +=3D {src: setup + {'qemu_args': qemu_def_args}}
> +  endforeach
> +endforeach
> +
> +tests +=3D {
> +  '../../multiarch/system/memory.c': {
> +    'exe_name': 'memory-sve',
> +    'cc_feat': 'sve',
> +    'cflags': [cflags, '-DCHECK_UNALIGNED=3D1', '-O3'],
> +    'qemu_args': qemu_def_args,
> +  },
> +}
> +
> +tests +=3D {
> +  'asid2.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
> +  'feat-xs.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
> +  'gpc-test.c': {
> +    'cflags': [cflags, '-DLOGGING_VECTOR_TABLE',
> +               '-Wno-main', '-Wno-unused-but-set-variable'],
> +    'qemu_args': ['-M', 'virt,secure=3Don,virtualization=3Don,gic-versio=
n=3D3',
> +                  '-cpu', 'max,x-rme=3Don',
> +                  '-semihosting-config', 'enable=3Don,arg=3D3',
> +                  qemu_base_args],
> +  },
> +  'rme_gdi.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
> +  'semiheap.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
> +  'semiconsole.c': {
> +    'cflags': cflags,
> +    'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=3Don,id=3Dst=
dio0',
> +                  '-semihosting-config', 'enable=3Don,chardev=3Dstdio0',
> +                  '-mon', 'chardev=3Dstdio0,mode=3Dreadline',
> +                  qemu_def_args],
> +    'wrapper': [prog_run_with_input, 'X']
> +  },
> +  '../../multiarch/system/memory.c': {
> +    'test_name': 'memory-record-replay',
> +    'qemu_args': qemu_def_args,
> +    'wrapper': [prog_record_replay],
> +  },
> +  'vtimer.c': {
> +    'cflags': cflags,
> +    'qemu_args': ['-M', 'virt,virtualization=3Don,gic-version=3D2',
> +                  '-cpu', 'cortex-a57', '-smp', '4',
> +                  '-semihosting-config', 'enable=3Don,arg=3D2',
> +                  qemu_base_args]
> +  },
> +}
> +
> +tests +=3D {
> +  'pauth-3.c': {
> +    'cc_feat': 'v8.3',
> +    'cflags': cflags,
> +    'qemu_args': ['-M', 'virt', '-cpu', 'max,pauth-qarma5=3Don', qemu_ba=
se_args],
> +  }
> +}
> +
> +tests +=3D {
> +  'mte.S': {
> +    'cc_feat': 'mte',
> +    'cflags': cflags,
> +    'qemu_args': ['-M', 'virt,mte=3Don', '-cpu', 'max', qemu_base_args],
> +    'gdb_test': ['--test', files('../gdbstub/test-mte.py'), '--', '--mod=
e=3Dsystem'],
> +    'gdb_feat': 'mte-baremetal',
> +  }
> +}
> +
> +if 'qemu-system-aarch64' in emulators
> +  tcg_tests +=3D {
> +    'aarch64-softmmu': {
> +      'cc': cc,
> +      'cc_dockerfile': cc_dockerfile,
> +      'cc_docker_host_arch': cc_docker_host_arch,
> +      'cc_feat_cflags': cc_feat_cflags,
> +      'folder': 'aarch64/system',
> +      'gdb_arch': 'aarch64',
> +      'gdb_feat_version': gdb_feat_version,
> +      'qemu': emulators['qemu-system-aarch64'],
> +      'tests': tests,
> +    }
> +  }
> +endif

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

