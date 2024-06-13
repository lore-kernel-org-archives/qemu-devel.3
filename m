Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA82C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 05:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHclK-0003UZ-86; Thu, 13 Jun 2024 01:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHclE-0003RY-UH
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 01:12:32 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHclD-0003Iq-6d
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 01:12:32 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ebdfe26226so5135081fa.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 22:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718255549; x=1718860349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ccCWEPbIP3Yg2v6HjmxjF4lRR04h9g5vpJVJjNT8YGg=;
 b=ITdtWQNerIjtJc7yLssEgb0uYSyH7sGHWOLYf+SPr6lwAJoZNJ7sOaZyM7hPI5+3Y+
 17SosXz8xLraKs3G8Umw2LikYEo0bzNBlx2ssrBADGOtTTWiqQvBswJUYQyujt2X8GiO
 qgB6eHHRh7F5ImYLiBGxYplSlY52Kuiy25I6SzxMTUCg75XwenuxSW7MPZ89wERhgOt5
 tXjZgAOWN5Z5LX9wJ45jlvx0pVz6EqcZ6NMUIZwXA9wTEwAAQRfp6knNQV1+Gtmv+90U
 MJclargnhkg2PnPFeLLjcu4MSOsypcatciRUGwJsh8kajwM59VGTWkBsyItmAwZ/Sc6s
 WyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718255549; x=1718860349;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ccCWEPbIP3Yg2v6HjmxjF4lRR04h9g5vpJVJjNT8YGg=;
 b=n+KB3ae9/PyFcvsKb80wYZNM53WdnYFpCjgPYU9CifBK9pjkCQygs7TiDrJ+IZDQKs
 Qf/ZmOQhgPOZd27OcvfO031vUtL4zOI45VIRc2v0KGzhbq2vrGnC/ANc6/IVqx1hhuyC
 gZEfB9ujhdf9ahGEyYvPUhrjeKs7JtjRPOayPDcWz3LlPHgn4dpazN/gyUt/G6+vos6Y
 XYF447N3ir/pb0BALOXQ2WPiawtZ+xFgNMieuJbzQ2NhspxES15n6fd4QAmQgybinJ5U
 b3/N3mE6tsFkUCH2BP0W6NjynxYACmXulmG4r34IwNF8TMjciIjBZCxlPBspoGjb+hz1
 QJSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHvm/1lQJHfHi1tzsOx+IlcqQ+oy4Zcg7QPVDdYlNt6j1kFbv3aNp5XZytSVRvuBv1OLvZvadLwS4RkYldxay1UG+Wyeo=
X-Gm-Message-State: AOJu0Ywio5hhnmQ9UEMzLHyXSB6hw6Pw0jXLL9GzNkjmxV8YJ8dnWhWX
 5KI1W4rGjDVMcEfmE2tth8vg4wB+Ty8DOFgE6tqNfs0M5jH8z6wLxSUqNXGO9J8=
X-Google-Smtp-Source: AGHT+IEeRZYyHTAZDyyDw0FE5fLIhh4cmvRvmdEWpKeaLxr3qKr81j+1U/2N9ilsGgy2sF8OMpdH2w==
X-Received: by 2002:a2e:8350:0:b0:2e9:8497:46ce with SMTP id
 38308e7fff4ca-2ebfc9495ffmr24404691fa.46.1718255548951; 
 Wed, 12 Jun 2024 22:12:28 -0700 (PDT)
Received: from meli-email.org (adsl-33.109.242.225.tellas.gr. [109.242.225.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104a3dsm569606f8f.112.2024.06.12.22.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 22:12:28 -0700 (PDT)
Date: Thu, 13 Jun 2024 08:09:12 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
 <ez270.x96k6aeu0rpw@linaro.org> <ZmnHoajecti472mi@redhat.com>
 <ezjl0.qx0tmsp6d6t@linaro.org>
 <CABgObfbGwKc0RYBcDPzNkE8HOSouFj4D15Oh7TuiKOC+D7raaA@mail.gmail.com>
In-Reply-To: <CABgObfbGwKc0RYBcDPzNkE8HOSouFj4D15Oh7TuiKOC+D7raaA@mail.gmail.com>
Message-ID: <f06gr.8csaobu5kui2@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x236.google.com
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

Good morning Paolo,

On Thu, 13 Jun 2024 00:27, Paolo Bonzini <pbonzini@redhat.com> wrote:
>Il mer 12 giu 2024, 22:58 Manos Pitsidianakis < 
>manos.pitsidianakis@linaro.org> ha scritto:
>
>> In any case, it is out of scope for this RFC. Introducing wrappers 
>> would be a gradual process.
>>
>
>Sure, how would you feel about such bindings being developed on list, 
>and maintained in a (somewhat) long-lived experimental branch?

Hm the only thing that worries me is keeping it synced and postponing 
merge indefinitely. If we declare the rust parts as "experimental" we 
could evolve them quickly even on master.  What do the other maintainers 
think?

Thanks,
Manos

