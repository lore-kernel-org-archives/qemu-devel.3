Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB9BC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 10:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGywv-0000K7-5s; Tue, 11 Jun 2024 06:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGywt-0000JX-Tg
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:41:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGywp-0004VT-RM
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:41:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42108856c33so39033265e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 03:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718102510; x=1718707310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZByNP+oNv/xzX3om4QkM8m6oC9AwrKZtPseQ5HYaPD0=;
 b=xrLDVt85HwLK1haH2om/8nFzptDv5wAncn8vdVzDOIv8JDKMJYlU0BGtlfKzCnM5yb
 5cJlexpA2WsAWN3nKlOzaYOFQtguuovIBtEm9QzPu0SgYMgJvJShy8jJGxTyLLWocJ0r
 oJ5sIv2qLu1ksORgiIQIOxtlfiUot+rEtAuNSPSpeb7sjy6e1Bi6ml8A5VQZydja4B1K
 FxmHcVIVqm6d19doLBh3l9QfxERtjy4yNBa+WmxrOMqPhfEpzzoZ65Gkxcc1EGQgt4v7
 X2rhy9wLj4r9h9O/GJxXo8nmPWzi7SNXHiPfThLLDASw7ZDYC2y0989XgxrOEMaPuXwG
 9/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718102510; x=1718707310;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZByNP+oNv/xzX3om4QkM8m6oC9AwrKZtPseQ5HYaPD0=;
 b=ClzDig8zzL22yRMnw6+fd1ZuNYr3t+P5Q73c0wsfAU/pbiVAmCNou7CC8XzSqIORW6
 7pbJujo+k/w2TZVmbZYO7FtXC4E9atqja2KFhxIThT/w0W85Oo8MRjH2YNDRRrYsV/iY
 O/TSUvF+BHFXL6hDpjhvuuYdTzHOkvFl6gmarVl9G9g9tktBMblNv8Cgiwjwxvx6Q9qb
 zT/3cxMIuLlkW2bX6i0yo5XaRUTyZhyHnrhc6PgKbd7y+SwmGog+Pj/Btz39risTuoBg
 Of/A91BxPzTJE9HoOpX4UngUezgV+xDxQ7/GGNEW2LQklSJWiH6dTwENjayK1F8WdoN2
 4EXQ==
X-Gm-Message-State: AOJu0Yx7j6AT+bLoG8JSfbPrBybxqWm8gE19oJGMTVCzclN1LqP2x0c1
 v+0fPu9c7zHnowd+U9YG2WkGmVsJtxRG+Z80PGcv7TPZUrBU81H4dMVr+eY1UFo=
X-Google-Smtp-Source: AGHT+IFZlFNSpmmYAPivEErjsw8U+tKzknD5NLpQM7kQDq9DBgq+OvViNzT3UzKMBSenuOg1qqntAw==
X-Received: by 2002:adf:fb0b:0:b0:35f:1bb0:ed8e with SMTP id
 ffacd0b85a97d-35f2b28b0ebmr2161255f8f.21.1718102509655; 
 Tue, 11 Jun 2024 03:41:49 -0700 (PDT)
Received: from meli-email.org (adsl-33.37.6.162.tellas.gr. [37.6.162.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5fc1c77sm13368918f8f.95.2024.06.11.03.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 03:41:49 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:40:43 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
User-Agent: meli 0.8.6
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <ZmgJVGMx81aHjg5f@redhat.com>
In-Reply-To: <ZmgJVGMx81aHjg5f@redhat.com>
Message-ID: <ewwdn.svkk6gugl8pt@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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

On Tue, 11 Jun 2024 11:22, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>On Mon, Jun 10, 2024 at 09:22:35PM +0300, Manos Pitsidianakis wrote:
>> Hello everyone,
>> 
>> This is an early draft of my work on implementing a very simple device, 
>> in this case the ARM PL011 (which in C code resides in hw/char/pl011.c 
>> and is used in hw/arm/virt.c).
>
>looking at the diffstat:
>
>>  .gitignore                     |   2 +
>>  .gitlab-ci.d/buildtest.yml     |  64 ++--
>>  configure                      |  12 +
>>  hw/arm/virt.c                  |   2 +-
>>  meson.build                    |  99 ++++++
>>  meson_options.txt              |   4 +
>>  rust/meson.build               |  93 ++++++
>>  rust/pl011/.cargo/config.toml  |   2 +
>>  rust/pl011/.gitignore          |   2 +
>>  rust/pl011/Cargo.lock          | 120 +++++++
>>  rust/pl011/Cargo.toml          |  26 ++
>>  rust/pl011/README.md           |  42 +++
>>  rust/pl011/build.rs            |  44 +++
>>  rust/pl011/meson.build         |   7 +
>>  rust/pl011/rustfmt.toml        |  10 +
>>  rust/pl011/src/definitions.rs  |  95 ++++++
>>  rust/pl011/src/device.rs       | 531 ++++++++++++++++++++++++++++++
>>  rust/pl011/src/device_class.rs |  95 ++++++
>>  rust/pl011/src/generated.rs    |   5 +
>>  rust/pl011/src/lib.rs          | 575 +++++++++++++++++++++++++++++++++
>>  rust/pl011/src/memory_ops.rs   |  38 +++
>
>My thought is that if we're going to start implementing devices
>or other parts of QEMU, in Rust, then I do not want to see it
>placed in a completely separate directory sub-tree.
>
>In this example, I would expect to have hw/arm/pl011.rs, or hw/arm/pl011/*.rs
>so that the device is part of the normal Arm hardware directory structure 
>and maintainer assignments.

I agree 100%, but I thought it was not my place to decide that, it's 
part of the "request for comments" side of this series.

