Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B95EC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMPx-00072O-U3; Thu, 20 Jun 2024 14:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sKMPw-000722-Ft
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:21:52 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sKMPu-0001I9-Qc
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:21:52 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-35f2c9e23d3so1532583f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718907708; x=1719512508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rT7PHRJ4nPS9NYRqb1Y8b7l/QDxgC28f/1jxxvx4TJI=;
 b=Sl4JUq7d7PQw4x/gOwKjdslUjYUkNXfirjMT5wo2YViuRh7JtQeq2xo2Psp3F03zB7
 SmhfNxN7a9mCltTIC1NnrZdmXPMyb5bfe04lyFXj3092s/9Vl61UZixCe2RkUt0oxqis
 tJ24rCdF174Kj4pu4AEsrQQRga0roG78L6DA70LQ9SbbzJ3puMTeTTP2nEQPvlUE5fRn
 e8+G017XfWh9Z3ez6OG46CmAiurLDhY5Wk21pLKWt/fpd0FOv56Jhm6bubjAT7vo50tf
 Ij1Ws/eBhRhGyvxH6pKU+SHqB3NImMSIateDpUTGFopKky8aOitR2Y1tBY17R8tP7XJQ
 4qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718907708; x=1719512508;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rT7PHRJ4nPS9NYRqb1Y8b7l/QDxgC28f/1jxxvx4TJI=;
 b=abyOz00+ACDAxTPROBislulFlmXUbqgtZp1bihXjPtMnX/DiekdpVIhBqRUbfKLq1h
 6Bk3DC8IzZpXrtrDCick4ilSyN+80yk8t8SssSunp0of3IwcOou5QA70RFxMhn1bB4ai
 q3iLf1Q5GRyHgk0xCzwHbLDo8KQ2PTenPgkO8h2J+20CSJ0R/PUHMT/GguQs+ZLfnKo1
 zVdksb/sQEkWcS2glST1U6F+vYTgjVnfGs/SXVuIRtH+oF0jYhPKf/qer7DoDW7lPn0V
 tQAV0QYs4sMXk4r7I080avBbaVtiL5YLQnDh2jtI6BLGkKhf7YeuxrJjQYj8nHpgRYHr
 pvSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW5aIvuLHti9Qf+q36rDs3yNWuG2s57mqvatIhyATzHR+80Mr7kqwGp5Ifbnjj69yIda2tpRXU0MsrLO9fo2Og3vYZkls=
X-Gm-Message-State: AOJu0YygdlatQjN5Hdqxn9W9aHtolx3BnvaKEgrBbE6veCyl7HnQEvWT
 hH0pE/DYyQHSONQQzAkyTp6EVbE/dOvifwudBB7UxyxWpGqtP7gkPnirSFX5F+E=
X-Google-Smtp-Source: AGHT+IEOcKDKG6hjiUMv0taBJBRELoYInhfVl7p032HdU1WrWjrmmZFX4jr51ptNPD/2CajQIABM3w==
X-Received: by 2002:a5d:4d4f:0:b0:35f:1243:a956 with SMTP id
 ffacd0b85a97d-36301358c2dmr6574033f8f.23.1718907707886; 
 Thu, 20 Jun 2024 11:21:47 -0700 (PDT)
Received: from meli-email.org (adsl-103.37.6.162.tellas.gr. [37.6.162.103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104b8bsm20398011f8f.105.2024.06.20.11.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 11:21:47 -0700 (PDT)
Date: Thu, 20 Jun 2024 21:18:46 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
 <877cejdg4c.fsf@draig.linaro.org>
 <CABgObfbQPMjAS4eMP9=p6vqv_6WYrKk-bGauFkhRtzwY7rA00w@mail.gmail.com>
In-Reply-To: <CABgObfbQPMjAS4eMP9=p6vqv_6WYrKk-bGauFkhRtzwY7rA00w@mail.gmail.com>
Message-ID: <fe5oa.0duljr6rjpx6@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

On Thu, 20 Jun 2024 15:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
>On Thu, Jun 20, 2024 at 1:10 PM Alex Bennée <alex.bennee@linaro.org> wrote:
>> > +# FIXME: These are the latest stable versions, refine to actual minimum ones.
>> > +msrv = {
>> > +  'rustc': '1.79.0',
>> > +  'cargo': '1.79.0',
>> > +  'bindgen': '0.69.4',
>> > +}
>>
>> So for Debian Bookworm this comes out as:
>>
>>   msrv = {
>>     'rustc': '1.79.0',
>>     'cargo': '1.79.0',
>>     'bindgen': '0.69.4',
>>   }
>
>I think it's 0.60.1 bindgen and 1.63.0 rustc/cargo? That means we
>don't have generic associated types (1.65), which are nice to have but
>not absolutely necessary.
>
>The only other one with an old version is Ubuntu 22.04 (1.58.1), but
>it has 1.75.0 in updates
>
>Paolo

1.63 is definitely old at this point but we might still be in luck, 
(Except for bindgen). I will try running cargo-msrv[0] which finds the 
actual minimum supported version of a codebase with a binary search and 
see if we can give up features if necessary.

[0]: https://github.com/foresterre/cargo-msrv

