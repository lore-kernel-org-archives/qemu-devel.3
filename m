Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01329C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWCSi-0004Em-Qp; Tue, 23 Jul 2024 06:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWCSh-0004C7-Sr
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:09:39 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWCSg-0007jH-6D
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:09:39 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-426526d30aaso39783455e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721729376; x=1722334176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZeYcvyWXqPhEuJ9a6QTqyD4r5ZT63GH0kkiojce9fe8=;
 b=N9t+88+Re6/XMUnkbHRNXlK/LCg25MERgK6v2SAp/vxX0JaWmVpi6df3vXRojBOJ+r
 97Xwzmjwz3AyjD24l2gWxBqAOYfxFbuaMyR6uchLGyl3jozcHB8OLLDKmbK/qduoUN1G
 aZ+D9dyaOFEFvj7DEmv1atmX8HrQSwR7sVoiUUBntZdZwhi0h70CRmfZHV6xEa57+yfq
 H/6hZNFpELQ6iqAKUz4nVJO739Gi6IDdade423ieFfvqWACKhQ1qoqRkSs4F+PD8vvRF
 emjvhRAjlAM5VyVLgcfDoem4ZX7gwATSz63EsC/oTIKGQEgPgzRqjyErP64OWNg8dxHc
 8v4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721729376; x=1722334176;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZeYcvyWXqPhEuJ9a6QTqyD4r5ZT63GH0kkiojce9fe8=;
 b=W72JJnVWtunYFc3UuYvIpPrvKXYBmIcnir/WW8Hxjkl/k9A1dxJE900k1jcriniavN
 FFCpwZwiZ/vOUxbzgd+eXMbEhvxiWuQtaFRLkvnJdHv62VA21agQNRAzu90zceK76SLZ
 T5csnhfgpL5L/2ka3L8fUvuBUyEznLSnTTGTr15ssihQ4XNnH9L24qsKlxE7QuiQW4D/
 m2P8LI9rE8qDkceR1mCoMstS8yBb48ZshpWy9PqmB+ZgJ2D3gLmkOzgfIatcnxDCg1Xp
 igm5X/HegMLWh99CAd6Slej5nIzr0ZhAozmNKoJ3DGa0TQzZVhrn3oXu3mDy9KIcW5Vz
 as5Q==
X-Gm-Message-State: AOJu0Yzy4tTWzQNRRD+2fetX6cwCeizeyCu4hbAPhY9TTdYUSjQZpVeV
 29RiMm+hh21b8aM49CUd7kx7qStvyEpifw2/ph9B5GTsui5ZehOxYWsMg6YZea0=
X-Google-Smtp-Source: AGHT+IEgeg1SXGq+lv/LqFewMySRPXTkYqPi9Ph3KNtJgR8CWcbYp+wEW8p9fkWESwmY3omJScxWdQ==
X-Received: by 2002:a05:600c:4586:b0:426:6822:855 with SMTP id
 5b1f17b1804b1-427dc575129mr51461795e9.36.1721729375599; 
 Tue, 23 Jul 2024 03:09:35 -0700 (PDT)
Received: from meli-email.org (adsl-231.37.6.1.tellas.gr. [37.6.1.231])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6929981sm166303485e9.36.2024.07.23.03.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:09:35 -0700 (PDT)
Date: Tue, 23 Jul 2024 13:06:20 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [RFC PATCH v5 3/8] CI: Add build-system-rust-debian job
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <ef587f7f38ad5714d5c8eeb05448d19a6130799e.1721648163.git.manos.pitsidianakis@linaro.org>
 <Zp9sOsyefNXsgiXA@redhat.com>
In-Reply-To: <Zp9sOsyefNXsgiXA@redhat.com>
Message-ID: <h2mvx.gsw7w2v0uuew@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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

On Tue, 23 Jul 2024 11:39, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>On Mon, Jul 22, 2024 at 02:43:33PM +0300, Manos Pitsidianakis wrote:
>> Add job that builds with rust support enabled on debian.
>> 
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>>  .gitlab-ci.d/buildtest.yml | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>> 
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index e3a0758bd9..e025e2cbf6 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -107,6 +107,17 @@ crash-test-debian:
>>      - make NINJA=":" check-venv
>>      - pyvenv/bin/python3 scripts/device-crash-test -q --tcg-only ./qemu-system-i386
>>  
>> +build-system-rust-debian:
>> +  extends:
>> +    - .native_build_job_template
>> +    - .native_build_artifact_template
>> +  needs:
>> +    job: amd64-debian-container
>> +  variables:
>> +    IMAGE: debian
>> +    CONFIGURE_ARGS: --enable-rust
>> +    TARGETS: aarch64-softmmu
>> +
>
>Do we actually want to do this ?  With the updated lcitool containers,
>any of the existing build-system-XXXX jobs ought to be able to detect
>availability of rust and build with it. Re-using existing jobs means
>we burn less CI time.
>
>With regards,
>Daniel

Hello Daniel,

I think we do, as long as a rust toolchain is not required to build QEMU 
by default. The other jobs could detect availability of Rust but we 
don't have a way to check if it works and not fallback to compiling 
without Rust.

Could we force enable Rust in one of the existing jobs?

Manos

