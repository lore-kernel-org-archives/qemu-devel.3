Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC248C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAPzb-0004AW-4K; Fri, 24 May 2024 04:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sAPzZ-0004AJ-Ve
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:09:34 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sAPzY-0000D5-13
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:09:33 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5b9706c84e5so220630eaf.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716538170; x=1717142970;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UWZkdA07i1Ppf6/qLhu0Cdi6mvtfcIbE5UbsBFQzASI=;
 b=W6bLACpolgzJerlaAkAVmS/X5bcNdYTZGeVe84yb0Ag+8cVmAzkjTGIrYbUlmEsETo
 Ocb717y0qD7DMk1DJ2r0/4knA2EXuXJQsq60rOgrhLJc74/XbaXgJtu2wf/54o61nOrS
 Xs/ZObc8xiId8VmRLqXTakVMHt8OJsZXOVx9qR6bcpDH03UJ1v+Wox9ekYA1SSJEfHsz
 pvNA189qzVXE9A3u5N8NcRoejMpGGP73S9XLxOFH2BwQK6MLSGhVomYc3AsQ2RMyvZQD
 caX3ym/ptlOrIsS3uKhrDdcOAw0uTnHR9h9QFRy7hNyEAM+oBXCX5a1smlOH0Hqtn+Bz
 sO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716538170; x=1717142970;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UWZkdA07i1Ppf6/qLhu0Cdi6mvtfcIbE5UbsBFQzASI=;
 b=E9775bYI9cuerJkhOu9lKq43RF6CMIMmfQX/sSTcmbkowlxH71kVE2elhe9eiy3up2
 sihSdqheNP/ilto++xsqyGoBIKloy03ZxG3KofXV5zBLdN3ZaML74BP1bBSIxslV/zoD
 1mbVgLYAjr3/KINX4PA1PpbcEYY3SIutyers878VakyVHeILNm4X/FXdvggIG9ddKUXJ
 TqSpHp/6eKUkM3nlz9d8mSATNMJdVDjgYSoGPkEpyAi3n853hqRlnUEYgGhyc8UpevTa
 ho6T25aI9edK9XYlf4mfqeGmmgGQCfrRb2F5jAq4PUewSla1X2CX5ckBinl69KVra+Tz
 CjJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiHUQkGUoW6AbCLML91ZUX0pkYwpaSDNQeUf7mYrRoHSHzIE6CS4K9F5KK5Sj5zAFaYrWiFrcpQ5Md/s9vodCLP2f72qA=
X-Gm-Message-State: AOJu0YwRmiUX7VMW8dSbcylwacIM5szTCwf2h7xcpTBR8ez1Tfm5rQdr
 Ip9mDpSUWTuUtWSSttkvevfaEQ8vwJa2QcS7bd041bHEtpW2pADdIip+3zstObE=
X-Google-Smtp-Source: AGHT+IHet/S0zI7LOGlmQ3XYDV5lE/LFiWL6AqZsr05LnnMrdTj3hP/KDOGotkMod3NYOPBwwhNKgQ==
X-Received: by 2002:a05:6358:e81b:b0:18d:e328:7e7f with SMTP id
 e5c5f4694b2df-197e5467ad5mr159722255d.23.1716538170440; 
 Fri, 24 May 2024 01:09:30 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-68222cbb639sm662233a12.56.2024.05.24.01.09.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 01:09:29 -0700 (PDT)
Message-ID: <861dacd9-12fc-4fe8-9d85-c0795d643519@daynix.com>
Date: Fri, 24 May 2024 17:09:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] meson: Drop the .fa library prefix
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20240522-xkb-v3-0-c429de860fa1@daynix.com>
 <20240522-xkb-v3-3-c429de860fa1@daynix.com>
 <CABgObfYoEFZsW-H4WJ7xW0B85OqFi932d3-DmNAb6zTohFn=Og@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CABgObfYoEFZsW-H4WJ7xW0B85OqFi932d3-DmNAb6zTohFn=Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c31;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/05/22 22:45, Paolo Bonzini wrote:
> On Wed, May 22, 2024 at 12:49 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>> The non-standard .fa library prefix breaks the link source
>> de-duplication done by Meson so drop it.
> 
> Can you show the difference in the command lines?

Without this patch:
clang  -o qemu-io qemu-io.p/qemu-io.c.o -Werror -flto -Wl,--as-needed 
-Wl,--no-undefined -pie -Wl,--whole-archive libblock.fa libcrypto.fa 
libauthz.fa libqom.fa libio.fa libevent-loop-base.fa 
-Wl,--no-whole-archive -fsanitize=cfi-icall 
-fsanitize-cfi-icall-generalize-pointers -fsanitize=undefined 
-fsanitize=address -fstack-protector-strong -Wl,-z,relro -Wl,-z,now 
-fuse-ld=lld -Wl,--start-group libqemuutil.a 
subprojects/libvhost-user/libvhost-user-glib.a 
subprojects/libvhost-user/libvhost-user.a libblock.fa libcrypto.fa 
libauthz.fa libqom.fa libio.fa libevent-loop-base.fa @block.syms 
/usr/lib64/libgio-2.0.so /usr/lib64/libgobject-2.0.so 
/usr/lib64/libglib-2.0.so /usr/lib64/libgmodule-2.0.so -pthread 
/usr/lib64/libgnutls.so -lm /usr/lib64/libpixman-1.so 
/usr/lib64/libzstd.so /usr/lib64/libz.so /usr/lib64/libcurl.so 
/usr/lib64/libssh.so -lbz2 -lpam -Wl,--end-group

With this patch:
clang  -o qemu-io qemu-io.p/qemu-io.c.o -Werror -flto -Wl,--as-needed 
-Wl,--no-undefined -pie -Wl,--whole-archive -Wl,--start-group libblock.a 
libcrypto.a libauthz.a libqom.a libio.a libevent-loop-base.a 
-Wl,--no-whole-archive -fsanitize=cfi-icall 
-fsanitize-cfi-icall-generalize-pointers -fsanitize=undefined 
-fsanitize=address -fstack-protector-strong -Wl,-z,relro -Wl,-z,now 
-fuse-ld=lld libqemuutil.a 
subprojects/libvhost-user/libvhost-user-glib.a 
subprojects/libvhost-user/libvhost-user.a @block.syms 
/usr/lib64/libgio-2.0.so /usr/lib64/libgobject-2.0.so 
/usr/lib64/libglib-2.0.so /usr/lib64/libgmodule-2.0.so -pthread 
/usr/lib64/libgnutls.so -lm /usr/lib64/libpixman-1.so 
/usr/lib64/libzstd.so /usr/lib64/libz.so /usr/lib64/libcurl.so 
/usr/lib64/libssh.so -lbz2 -lpam -Wl,--end-group

> 
> One possibility to force de-duplication of objects is to change
> "link_whole: foo" to "objects: foo.extract_all_objects(recursive:
> false)" in all the declare_dependency() invocations that involve a
> 'fa' archive.
> 
> This completely gets rid of the archives, which now become just a
> dummy target. I have gotten reports of "ld" exhausting the limit of
> open files when using thin archives (thin archives contain "symbolic
> links" to the files with the actual object code, thus reducing disk
> usage), and this would also be fixed.
> 
> The disadvantage is requiring a bump to Meson 1.1.x as the minimum
> required version (the recommended version is 1.2.x because earlier
> versions are incompatible with recent macOS). It could be done before
> this patch (because then this patch is a total no-op), or after too to
> fix the immediate issue with sanitizer builds.

I wrote such a change and applied after this patch, but it caused 
dependencies to be ignored. Please see "[PATCH RFC 0/2] meson: Pass 
objects to declare_dependency()", which I sent earlier.

Regards,
Akihiko Odaki

