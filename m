Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F1ACD1292
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 12:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rutIC-0004uz-01; Thu, 11 Apr 2024 08:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rutI5-0004ty-Ez
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 08:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rutI3-0006d5-B1
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 08:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712837545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Rn9/XTLxjVr1HPxEoR9u06CvqQZ61nBz0m285Le0e4U=;
 b=GirN3z4PlrQV5h7b8c4FEwhKWz5ibgnLC0UHzPqzlJPdiNb8Wu/NM6kQjNvqQvmbrm0Jwx
 JQlFI/vK1yEbfbCywkobMJXGQFhFyJ4FadAVfyhm9dr5Xkn5EUUb66eaEJQZTtwGbLDw5m
 nmQiHaWoN6OFn+6QcAOC3FlntgjY4f0=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-Vxom9C6yN9eUPsDEzCKR9w-1; Thu, 11 Apr 2024 08:12:24 -0400
X-MC-Unique: Vxom9C6yN9eUPsDEzCKR9w-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6ea16ead32cso5245704a34.3
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 05:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712837543; x=1713442343;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rn9/XTLxjVr1HPxEoR9u06CvqQZ61nBz0m285Le0e4U=;
 b=RWPcpe4HqHR6CMuWvKEApBTiTN5NaVMnOkmmewqxOFbr6idJHD5ks12EH481F0n2aK
 oZf5Zwo3goLxpwSuo1yowSYKneUf1Zi4yd7NBmC2H7OX3t0HFOnZG+J0D34FOUl4DDay
 PGB+w192WEwBr4oJpZDEQhvVcr/AI4vsfYGonExMzIWatbwDnpEOsZxvQOMrc+WO7gX9
 eLJ5MvO1iKtYDBzcIKlCCs7gX7oRCkhdR7mzIKWJS0IqCT0JzhnRfSEZvNLxw+cBcq9G
 74+uT/wYZ4qLXwV2tv+IRnSpi3QS/IP94oUoau7+5QBFXfppeSuuAemHf3Qf8qVX0j5U
 3EAg==
X-Gm-Message-State: AOJu0Ywgvyow2mSmHyOd/HuBaQ+4lWGww+ewIqoBY16CjYmtn6awEA7D
 6qhB1EXC2Qm2BbXORPi/Q2gTnBFY4Dn7I41uQtmTXm3iMUXFnpZ3eVYrO4ZCAsY1ggyaaW1qwPN
 fv5Z6lVC8pd8ZBJmqwRkX7llvyBhjW0zDQOK0JykRmrFyMIMbHJxS0SPZuA/7UWyAH5b62cNrAd
 2HC7z++MdoKSJFZLkZStSQC0EMOfFhjfXk
X-Received: by 2002:a9d:6945:0:b0:6ea:1c73:a198 with SMTP id
 p5-20020a9d6945000000b006ea1c73a198mr6122787oto.0.1712837543561; 
 Thu, 11 Apr 2024 05:12:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvA3z3k2IGVe8bOyr3IWu0AHJyx+8H99mGpRMSD5oJ5jVGaW3lTxFzEkcvRlkpuxUGlmQAzg==
X-Received: by 2002:a9d:6945:0:b0:6ea:1c73:a198 with SMTP id
 p5-20020a9d6945000000b006ea1c73a198mr6122759oto.0.1712837543177; 
 Thu, 11 Apr 2024 05:12:23 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-142.web.vodafone.de.
 [109.43.179.142]) by smtp.gmail.com with ESMTPSA id
 w11-20020a0ce10b000000b006986c3f3d21sm852954qvk.116.2024.04.11.05.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 05:12:22 -0700 (PDT)
Message-ID: <1ccea33f-23cd-4beb-b6d4-8bdc9c623dd9@redhat.com>
Date: Thu, 11 Apr 2024 14:12:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] meson.build: Disable -fzero-call-used-regs on
 OpenBSD
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240411120819.56417-1-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240411120819.56417-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/04/2024 14.08, Thomas Huth wrote:
> QEMU currently does not work on OpenBSD since the -fzero-call-used-regs

That should be "OpenBSD 7.5" ... older versions are fine since they are 
using an older version of Clang that does not have -fzero-call-used-regs 
yet, I think.

  Thomas


> option that we added to meson.build recently does not work with the
> "retguard" extension from OpenBSD's Clang. Thus let's disable the
> -fzero-call-used-regs here until there's a better solution available.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2278
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   Note: Given that we're close to the release, I think the host_os check
>   is the best we can do ... the problem does not seem to trigger in all
>   functions, only if certain registers are used by the compiler, so a
>   more sophisticated check here seems to be too fragile to me right now.
> 
>   meson.build | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index c9c3217ba4..91a0aa64c6 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -562,7 +562,11 @@ hardening_flags = [
>   #
>   # NB: Clang 17 is broken and SEGVs
>   # https://github.com/llvm/llvm-project/issues/75168
> -if cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }',
> +#
> +# NB2: This clashes with the "retguard" extension of OpenBSD's Clang
> +# https://gitlab.com/qemu-project/qemu/-/issues/2278
> +if host_os != 'openbsd' and \
> +   cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }',
>                  name: '-fzero-call-used-regs=used-gpr',
>                  args: ['-O2', '-fzero-call-used-regs=used-gpr'])
>       hardening_flags += '-fzero-call-used-regs=used-gpr'


