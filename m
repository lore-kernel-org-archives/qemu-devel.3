Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC16CD4F59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 07:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm7JP-0002HJ-PU; Thu, 05 Sep 2024 03:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sm7JM-0002FQ-La
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 03:53:48 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sm7JK-0004Z2-RM
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 03:53:48 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42bbf138477so3616715e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 00:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725522824; x=1726127624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XqY0s06bY3jWuv7GyeDa0fRK+xfuCT2a4K+AtgDYRFg=;
 b=cI0EL9/qmRFeoJnkDvVv4B0MUPbSzvBC9YwnPgNlFsEi76R2BSHsnQkprDBSInhjfk
 hIVFxn1BNq5Bgt0e9alY4s4AH6/P8peeWga7AqZ1JGiLkm5kqepT5aRZVBydSbF1/D9h
 YgHrxNDJ+JYsdUXvhieYNpTAy3FIxJibXNrGh4YLHfmXpHolYxHTUe4Qi4cOFw7s0RRh
 5BX1hIbyJfQ4u/8X/KjDDKcb3/zblPueho+3DhbQUu1sv/U7aN1P7H7KeB0keBKuscdz
 Biql3uiR+/eqDHqXWlZ6yMt3wj2K4SEiet+f2k3cFUzypmVxsDTmiUw7g3+xskWOfN4X
 JB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725522824; x=1726127624;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XqY0s06bY3jWuv7GyeDa0fRK+xfuCT2a4K+AtgDYRFg=;
 b=J5ZlOwV0M4KXNmFSL76o25DpKkMx5P7KcFYaNphxCE/SZpTuskoFe1aFxJmTaLQMnL
 IlsEBJZgaSwqgTlezdbDo1mU7RE3/I0TOCdELQsQO+tdVSMan0WBm+v21F386vwzPdOl
 av49RhG5cP1c75uSQKtYUGcl4PSVz41BmzjIA0uWen9pBwtned+vfycNF7zpZrMDoV/i
 SX8B5QQtSzrBx8IZGGGDaJ3dqf3s2Pt+z2EIsj0QL56wmFSMNM6m6Hx87pYCHchC08ET
 W6jhfkLU8xx7RaXb3opJ0pYYQdpTU37fc1K2VZD80R92ySw/SHqkOE7ACAdrq71zgMKQ
 fq/w==
X-Gm-Message-State: AOJu0Yz/6sS3+mjH7nJ8Q0aznco+aHWEmEYl5hwcGEoV461Vqa+abo8R
 F9eIxudIGJi303O0l2ll4dGw0kxJvDrmK0OfvOTxpU4DJvK3WISgP/8T0ztmfiM=
X-Google-Smtp-Source: AGHT+IGL0or0VTO4R7BIImoMB2JsOpgw9uypgdG8Prd6NWQq6pszZYfGdM3BLH8PXqLt8uFGiRuhtw==
X-Received: by 2002:adf:a38a:0:b0:374:c7f8:3d52 with SMTP id
 ffacd0b85a97d-374fa04b2f6mr7033292f8f.54.1725522823751; 
 Thu, 05 Sep 2024 00:53:43 -0700 (PDT)
Received: from meli-email.org (adsl-122.109.242.227.tellas.gr.
 [109.242.227.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374bfbfc7b7sm13715020f8f.88.2024.09.05.00.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 00:53:43 -0700 (PDT)
Date: Thu, 05 Sep 2024 10:50:33 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Daniel P. Berrang=?UTF-8?B?w6kg?=<berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH RESEND v9 7/9] rust: add crate to expose bindings and
 interfaces
User-Agent: meli 0.8.7
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-7-35579191f17c@linaro.org>
 <CABgObfbe1tFWb1yogUskbUszFyHjy_qhk0k6B9YrgBeVNTnDww@mail.gmail.com>
In-Reply-To: <CABgObfbe1tFWb1yogUskbUszFyHjy_qhk0k6B9YrgBeVNTnDww@mail.gmail.com>
Message-ID: <jbxxi.e6usblfysvwu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 04 Sep 2024 14:01, Paolo Bonzini <pbonzini@redhat.com> wrote:
>On Wed, Aug 28, 2024 at 6:12 AM Manos Pitsidianakis
><manos.pitsidianakis@linaro.org> wrote:
>>
>> Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
>> provides some declaration macros for symbols visible to the rest of
>> QEMU.
>
>The only comment I have is that I would drop the allocator support
>completely. It adds complications and, at least initially, we can
>plan/hope that all cross-language allocations go through a constructor
>function like error_setg() or object_new().
>
>In the case of QOM, if we wanted to allocate objects in a Box rather
>than malloc-ed memory, we could also put in the object a free function
>that calls
>
>   mem::drop(Box::from_raw(p))
>
>Fixing rust.bindgen() to use the right CLANG_PATH/LIBCLANG_PATH should
>probably be done in meson itself. The (not too hard) alternative is to
>just use a custom_target.

Can we get the include directories of common_ss.all_dependencies() for a 
custom_target? Meson does this:

  for de in kwargs['dependencies']:
      for i in de.get_include_dirs():
          clang_args.extend([f'-I{x}' for x in i.to_string_list(
              state.environment.get_source_dir(), state.environment.get_build_dir())])
      clang_args.extend(de.get_all_compile_args())
      for s in de.get_sources():
          if isinstance(s, File):
              depend_files.append(s)
          elif isinstance(s, CustomTarget):
              depends.append(s)

But I think the functionality to extract this info from dep objects is 
not exposed to meson.build files.

