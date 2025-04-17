Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6355C369C7
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Ly0-00008o-6n; Thu, 17 Apr 2025 05:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Lxv-00007P-Mw
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:55:27 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Lxq-0001tu-VA
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:55:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso3913325e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 02:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744883721; x=1745488521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ESxmPEsDrgjCRYYmui/83TcI+NXdgh7xp9aoly0xOU0=;
 b=i7dNYml85Eyna008oVFkKR1E4l3j5AmOyUiOXfeeYL51PKkn5qHx8bzEnxcTJRJqVj
 E1CR9oOfeJ8UXOsGItrCLjn5sRPC2dZzVIRZU94N2DZh31JOA/1NmaJoMELHEpk9TTlf
 0p55ebqd1wh/kQcaXueBLDN2t2A84MrV4xogUo7LdxJJXMyN3JN33FomxgOt3//ztK8C
 ElwjnIxX01+29FBlhdBLw4lek9Mmp/Jt+O6M59xvmMqnI2OorEDWEQ+NWOxK6jW0HBWG
 3jym2oGxesXCnM7+APUFyRKPNTb9JGuyCQNKacp0b1MX4q7VmIDuNAyeIxdQjLBDQTVB
 h9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744883721; x=1745488521;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ESxmPEsDrgjCRYYmui/83TcI+NXdgh7xp9aoly0xOU0=;
 b=n5iMZISzpOcRPvbwVkf+ssJ7jEXMeM2nMkCQqOiwFKydkjzDTIHFNncJKatQFM9ac7
 QIV6rjfnOeRw06qlfUJ5kUkXOkpeZOmEmjaTVlTwO12qYU/WzSUSDmUe8oi8YGJAZL2C
 712Re6/xmkbfMrfEqL4mzyW7oHAxtr417kQDn798N50w+yeKRBzJ4ZKrnZhwqxDIpV/I
 MdgowMWbqp6/5bXzIuEfQOmYGQEyDns8m1jw2/rhT5Z/j2jiUDcfB1YHMMvtZBOSH6Mu
 PSXbi5wQ52/SzQbBACIr4FGpqa2fxa2eizRB6DbzPozpwB8EIqL6XP3LOnKNI5+iBrrc
 P7wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfEhFGdkStF70rCWEzg/Y6U1JuOxxBOt8j0/m/jcshXEKfMazMnVX6x943g7h2OBFq4eq6ZdQNCQzj@nongnu.org
X-Gm-Message-State: AOJu0YzzBQKMzD0+hkvt7hHeqZp+EGwKF5CRF6AXql3mo4hvtVkj+uvs
 gRqkjLIeXW8shpRUn6PypKBi0qeyJrzYa/U7JKAARIFn00kWp7g9PJ+38ZOIiPk=
X-Gm-Gg: ASbGncs13D7Wh9tFWc86kK0+NdzFsSdxRDKC+CzArhdocmI7juX4R93VW7gdRW+LvDU
 RM/XmnloJMBqxCQSW8gXE20OEun2j9JSD5/2IToLkGxUA7oxT8HIIJIeXVZvUcXDJ6Ko5ed7vCg
 EmDV+qawsGyJt6vCz7+e403SfxClISXBGfSKopd/xCjW1jabx9bfWLiuCb6CcG+tXUflkDnlkkF
 8g65C8bjI3cpk7tTVVLf7EYOk/wtv2+AsUbp+fmeQhQyvDhxAWrvyXWXJKXOq0JrKNVt8xzRQuY
 YmGbR3J6GyrvKjMAW99JLRWVYvo1Mn9uq3YLqnBnV988VcAXLhK6f7pyXXlt1reKjO0AUg4gqEk
 XL/mv9zqP
X-Google-Smtp-Source: AGHT+IHUr52I6Hsu8tzshHOgbhzDkiHTPYbRD/a44+LftBX99Q9Ir//2EM1w9KGuA1rTB9OD9MQhsQ==
X-Received: by 2002:a05:600c:a09:b0:43c:f00b:d581 with SMTP id
 5b1f17b1804b1-4405d6decb3mr40538105e9.29.1744883720794; 
 Thu, 17 Apr 2025 02:55:20 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96c184sm19871210f8f.30.2025.04.17.02.55.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 02:55:20 -0700 (PDT)
Message-ID: <e7f66ec8-ee38-453d-a6de-4ed8d5a54268@linaro.org>
Date: Thu, 17 Apr 2025 11:55:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] block: Update block to compile with Emscripten
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <9da41d784991f77e2c1f38d0781cd047b593e053.1744787186.git.ktokunaga.mail@gmail.com>
 <afe0abf1-2c33-47d8-bde6-8abc722eb212@linaro.org>
 <2d232dbc-4613-4352-8ede-3fd5dcefc32c@linaro.org>
 <CAEDrbUbQ2h1wj-KJqjYjcGPb4Pyp0te8ycy2DoJGENvT2+Mxcg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAEDrbUbQ2h1wj-KJqjYjcGPb4Pyp0te8ycy2DoJGENvT2+Mxcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 17/4/25 11:32, Kohei Tokunaga wrote:
> 
> Hi Philippe and Richard, thank you for the feedback.
> 
>  > Actually what about checking the symbol presence in meson?
>  > Something like (untested):
>  >
>  > -- >8 --
>  > diff --git a/meson.build b/meson.build
>  > index b18c46d16a2..33185fdf315 100644
>  > --- a/meson.build
>  > +++ b/meson.build
>  > @@ -2654,3 +2654,2 @@ config_host_data.set('CONFIG_TIMERFD',
>  > cc.has_function('timerfd_create'))
>  >   config_host_data.set('CONFIG_GETLOADAVG', 
> cc.has_function('getloadavg'))
>  > -config_host_data.set('HAVE_COPY_FILE_RANGE',
>  > cc.has_function('copy_file_range'))
>  >   config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
>  > @@ -2756,2 +2755,6 @@ config_host_data.set('HAVE_UTMPX',
>  >
>  > +config_host_data.set('HAVE_COPY_FILE_RANGE', cc.links(gnu_source_prefix
>  > + '''
>  > +  #include <unistd.h>
>  > +  int main(void) { return copy_file_range(-1, NULL, -1, NULL, 0, 
> 0); }'''))
>  >   config_host_data.set('CONFIG_EVENTFD', cc.links('''
>  > ---
> 
> Emscripten doesn't provide copy_file_range implementation but it declares
> this function in its headers. Meson correctly detects the missing
> implementation and unsets HAVE_COPY_FILE_RANGE. However, the stub defined in
> file-posix.c causes a type conflict with the declaration from Emscripten
> during compilation:
> 
>  > ../qemu/block/file-posix.c:2019:14: error: static declaration of 
> 'copy_file_range' follows non-static declaration
>  >  2019 | static off_t copy_file_range(int in_fd, off_t *in_off, int 
> out_fd,
>  >       |              ^
>  > /emsdk/upstream/emscripten/cache/sysroot/include/unistd.h:207:9: 
> note: previous declaration is here
>  >   207 | ssize_t copy_file_range(int, off_t *, int, off_t *, size_t, 
> unsigned);
>  >       |         ^
>  > 1 error generated.
> 
> If introducing a new stub isn't preferable, we could update the existing
> stub in file-posix.c to match the declaration used by Emscripten. The
> manpage[1] also aligns with this signature.

You are correct we should use ssize_t instead of off_t.

If meson fails to link, it won't define HAVE_COPY_FILE_RANGE, so you
shouldn't get "static declaration of 'copy_file_range' follows 
non-static declaration" right?

> 
> [1] https://man7.org/linux/man-pages/man2/copy_file_range.2.html 
> <https://man7.org/linux/man-pages/man2/copy_file_range.2.html>
> 


