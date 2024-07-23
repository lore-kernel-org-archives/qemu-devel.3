Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A45C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWCi1-0002KN-84; Tue, 23 Jul 2024 06:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWChr-0002Bx-LA
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:25:21 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sWChn-00036h-0n
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:25:16 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ef2d7d8854so23230461fa.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721730312; x=1722335112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/PKG23ZdxBx9vlJyFFkxqReU++nrCF2XeS6ddaYma3E=;
 b=CvPEqM7k3eX4SoNTyVS5AVqziQLcgB7GZ1N0dqj9oCZfuuxzV0W074RQmRaZX0T9LQ
 aRY1pdN/zQaFO4QPb51jJGjErI3CUuQWwyvCCfOymjtszhN8SrS2P3o4HfJnBs4MQmvA
 7fyR2WQ3Ye6hWu9ja5h2Fg35VgF6hOuQAk/D9orKNOPHNqUwD7RsO11vt4MuyES6aZUA
 l4FbTEK4meCxeXgf/1gFH18VSlLRi7FcVcnTlKBE0R4fbA+x9tciWqgw3IQpYqUWg3jQ
 eG0nWGMPS18ycG1ExIo0V094xYQTKyff8Uey9DQWGZlZhSIjufeo6uDvBM6WoITllw+N
 M5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721730312; x=1722335112;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/PKG23ZdxBx9vlJyFFkxqReU++nrCF2XeS6ddaYma3E=;
 b=V1pEQoERiOduH5NpgKRGzVGUR+DPNiDKmNY5EzX2Wdiau92cMVmJpo+5MkkSut2UsV
 YII4nKAqGEf+oTedYB/Zn6ZfwDEQ+AMMJln6jIzTmed+erKCcH/hzHHHeSly02WpjXvP
 464CF6POT9xBWWIpveNj4tFuMdr+nciSFpXwS+Ww8gGt5O7h4z+dvzwObtBKns0/czCY
 NVaUlFoZykq2s81jREeRDSTcJKj9ZWxcpfHcJm12oYDPMsWtz3Wg+SYhReDjaFDAxMa8
 JmRqDwjtDLAc/XmQs+dZTWXHTxmQAgg1wAjSEgiLUjMY4H8WT0VmOYKBYhj9RCQaasq2
 zoQw==
X-Gm-Message-State: AOJu0Yy3goYRcf+8Z91WLrAMkUrvblvTMqOqpsRAZH/NPVjUBwmjWXsY
 ePLEOLPRVKAE+4qL6oNjQLqrqPb7pCeHhcxIbZRUe0EnTbM0yokNtrspJVCD2Sc=
X-Google-Smtp-Source: AGHT+IHQUyZTqNMYlEYa8j3ZEM7+JjdCZ00lgAgmz9a/LEEVyxA0JIkRo7ddCTWDXMxiixrg4ATyJw==
X-Received: by 2002:a2e:9f16:0:b0:2ee:80b2:1e99 with SMTP id
 38308e7fff4ca-2f01ead8f10mr17088251fa.44.1721730312136; 
 Tue, 23 Jul 2024 03:25:12 -0700 (PDT)
Received: from meli-email.org (adsl-255.109.242.224.tellas.gr.
 [109.242.224.255]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a9466bsm194964335e9.41.2024.07.23.03.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:25:11 -0700 (PDT)
Date: Tue, 23 Jul 2024 13:24:33 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
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
 <Zp9sOsyefNXsgiXA@redhat.com> <h2mvx.gsw7w2v0uuew@linaro.org>
 <Zp-BvLXg2yebs52-@redhat.com>
In-Reply-To: <Zp-BvLXg2yebs52-@redhat.com>
Message-ID: <h2nly.03v1pc1zuu0o@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22f.google.com
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

On Tue, 23 Jul 2024 13:11, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>On Tue, Jul 23, 2024 at 01:06:20PM +0300, Manos Pitsidianakis wrote:
>> On Tue, 23 Jul 2024 11:39, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>> > On Mon, Jul 22, 2024 at 02:43:33PM +0300, Manos Pitsidianakis wrote:
>> > > Add job that builds with rust support enabled on debian.
>> > > 
>> > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> > > ---
>> > >  .gitlab-ci.d/buildtest.yml | 11 +++++++++++
>> > >  1 file changed, 11 insertions(+)
>> > > 
>> > > diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> > > index e3a0758bd9..e025e2cbf6 100644
>> > > --- a/.gitlab-ci.d/buildtest.yml
>> > > +++ b/.gitlab-ci.d/buildtest.yml
>> > > @@ -107,6 +107,17 @@ crash-test-debian:
>> > >      - make NINJA=":" check-venv
>> > >      - pyvenv/bin/python3 scripts/device-crash-test -q --tcg-only ./qemu-system-i386
>> > > +build-system-rust-debian:
>> > > +  extends:
>> > > +    - .native_build_job_template
>> > > +    - .native_build_artifact_template
>> > > +  needs:
>> > > +    job: amd64-debian-container
>> > > +  variables:
>> > > +    IMAGE: debian
>> > > +    CONFIGURE_ARGS: --enable-rust
>> > > +    TARGETS: aarch64-softmmu
>> > > +
>> > 
>> > Do we actually want to do this ?  With the updated lcitool containers,
>> > any of the existing build-system-XXXX jobs ought to be able to detect
>> > availability of rust and build with it. Re-using existing jobs means
>> > we burn less CI time.
>> > 
>> > With regards,
>> > Daniel
>> 
>> Hello Daniel,
>> 
>> I think we do, as long as a rust toolchain is not required to build QEMU by
>> default. The other jobs could detect availability of Rust but we don't have
>> a way to check if it works and not fallback to compiling without Rust.
>> 
>> Could we force enable Rust in one of the existing jobs?
>
>Yes, pick any existing job where it works.
>
>With regards,
>Daniel

OK sounds good, will make the change!

Manos

