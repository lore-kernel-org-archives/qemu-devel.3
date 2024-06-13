Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A02C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHgHe-0007ji-Ky; Thu, 13 Jun 2024 04:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHgHd-0007cA-80
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:58:13 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHgHb-0000RY-Cv
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:58:12 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-35f24fabb81so746901f8f.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718269089; x=1718873889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Y2iaLGc28slq4NRbWeOEPsgQ/LGWHuGbUwKbffB7YsE=;
 b=Oe/Tuq+cuKUAeChf70kH0yijpqOiKL5UkfANHr7ULpR8+0rwXLud2HmrQlZM0EMYlQ
 JvNpnqrossmHG9O5/mIHHt0XRWjHiBhs1Vyn9XpgxODE1NY6ZnG7HQwqITnqJxsty1xT
 /spBZz7zbLHiNxp6YIwZzIG18gY8bDbKTJTNKp2GoSyPc0SD75qLxoOptjr/b97DmsZ2
 DHPnUtX59fd5/Rhcr2tAusPidL5z0GxcaEVkj59aVpsz5hwaONemf42X4NNY2nFErzge
 fWnzIfY9Itu9Meh0WqXNs41tG1tbAq+hhLgD7do+woGPQ0gFFSzO3SjGZOCvoGZPYsuo
 2qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718269089; x=1718873889;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y2iaLGc28slq4NRbWeOEPsgQ/LGWHuGbUwKbffB7YsE=;
 b=vc33ipql1IZmR52hnLMHSNJUNVZ/28dK6A56M7YW9DqavvRb4rCzTkcWmfVJnB2eA4
 QovpnI9AXvP/hs8sr0mAdEoDzQniyrSWbIiZ/YPpf7t8gxgC9eMnTxL4OCnkaVVpBWqz
 TpxbuosgswXQNDQ2UO/SVc/X1Y3VcuAdIz6MmbRt7e1m2hnaBlXxvEjaZE0MQ/IdIE+M
 hHBJd/esUpxVh0+ulndknRrEHgx0PSTOowO/DQdqnDuYXwKtp8nFLFLczBfJ0HNhgu/G
 JZlop/7FYzZwVJT1NEg0f5cjEWck2eYDFKs5tuJnpGKeDVpPfciVun5dYaewsLAY9zgM
 fLVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVttWfKvg3nQaU/SgEuS8iDh6ucGCVxPeXufmS65tMSRhhmEVK2CJanlCpoHn+gVpwtCkONe4R0I520pXRtWe+r/L1QJD4=
X-Gm-Message-State: AOJu0YxziMLneIBPvyXbUQCYndk1DG+Cxq2Y0lkup58LBrXVdK/SY4ZX
 kr8E/jBLUDvsRSfKj+V/hLANVdGy8ttUau91BWkUho7kuRxH6ts16pEN5wcAFA9t5xKRscv1Vyx
 q/Yk=
X-Google-Smtp-Source: AGHT+IGPkHZCssYOz8VZegAKVQn18I/T6Ng8D8FnIwfeCjS6Gue78ZSK9LgM/BJPz/eXRIF6hfnguA==
X-Received: by 2002:a5d:5288:0:b0:35f:18ad:bccb with SMTP id
 ffacd0b85a97d-35fe1bfda3fmr3044765f8f.35.1718269089135; 
 Thu, 13 Jun 2024 01:58:09 -0700 (PDT)
Received: from meli-email.org (adsl-33.109.242.225.tellas.gr. [109.242.225.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750acebcsm1057299f8f.60.2024.06.13.01.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 01:58:08 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:49:22 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
 <ez270.x96k6aeu0rpw@linaro.org> <ZmnHoajecti472mi@redhat.com>
 <ezjl0.qx0tmsp6d6t@linaro.org>
 <CABgObfbGwKc0RYBcDPzNkE8HOSouFj4D15Oh7TuiKOC+D7raaA@mail.gmail.com>
 <ZmqcFf0xB9m4WkA3@redhat.com>
 <CABgObfb4+FSsadFTVg6Dc1zehQV2Vei2_kSRd5CfxsGBLPN6Eg@mail.gmail.com>
In-Reply-To: <CABgObfb4+FSsadFTVg6Dc1zehQV2Vei2_kSRd5CfxsGBLPN6Eg@mail.gmail.com>
Message-ID: <f0gwv.95xzc4653e7w@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
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

On Thu, 13 Jun 2024 10:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
>Il gio 13 giu 2024, 09:13 Daniel P. Berrangé <berrange@redhat.com> ha
>scritto:
>
>> On Wed, Jun 12, 2024 at 11:27:04PM +0200, Paolo Bonzini wrote:
>> > Il mer 12 giu 2024, 22:58 Manos Pitsidianakis <
>> > manos.pitsidianakis@linaro.org> ha scritto:
>> >
>> > > In any case, it is out of scope for this RFC. Introducing wrappers
>> would
>> > > be a gradual process.
>> > >
>> >
>> > Sure, how would you feel about such bindings being developed on list, and
>> > maintained in a (somewhat) long-lived experimental branch?
>>
>> IMHO any higher level binding APIs for Rust should be acceptable in the
>> main QEMU tree as soon as we accept Rust functionality. They can evolve
>> in-tree based on the needs of whomever is creating and/or consuming them.
>>
>
>My question is the opposite, should we accept Rust functionality without
>proper high level bindings? I am afraid that, if more Rust devices are
>contributed, it becomes technical debt to have a mix of idiomatic and C-ish
>code. If the answer is no, then this PL011 device has to be developed out
>of tree.
>
>Paolo

Getting Rust into QEMU, at least for our team at Linaro, is a long term 
commitment, so we will be responsible for preventing and fixing 
technical debt.  And it will be up to the hypothetical rust maintainers 
as well to "keep the garden tidy" so to speak.

To put it another way, I personally plan on making sure any bindings and 
any QEMU-ffi idioms that arise are all homogeneous and don't end up 
being a burden for the code base.

Your concern is valid, and thank you for raising it. I feel it is 
important to figure out how this will be managed, since it's also an 
argument for the final say in whether any of this code ends up in the 
upstream tree.

Thanks Paolo,
Manos

