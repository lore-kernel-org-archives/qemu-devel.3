Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AF5C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 07:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI0yy-0004HC-0b; Fri, 14 Jun 2024 03:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sI0yw-0004Gf-84
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:04:18 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sI0yu-00059p-E1
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:04:18 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-35e1fcd0c0fso1486254f8f.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 00:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718348654; x=1718953454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ELcYFfboRwhxj6i36xhUJqb2REz8NmqDEdgnN2O4J5M=;
 b=BIKhVZnLQknt64bPXeIX28ChBUtsXIyoNX20qbg15nlD1EWsVxK4uAv1dlomeXf01O
 LHamhw4amVn27XHKxXrARH8cu0Za+S2YEfOkDh2ek5AJ2OjLuClQSL4nmS5YBCbQyJey
 8ylYMjDrn4rZVHLaqMBcljwq8/JOO9QdtUYB++3THZ7tcnDDi0nhjX3t7UNe4s6Hjn6P
 S7fkTOF7ATHharTpoVgr7zyTBtnb7AO7cm5lMu3dU/uH7H+K7kWu/FvYadBbBMw4BNUm
 qk3IVawpErOeV1w3WlJBIM6XgRcohVmd1MWWSugKYOL6ME2sJy3EZpZ2PRitKaBkwxFZ
 ss/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718348654; x=1718953454;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ELcYFfboRwhxj6i36xhUJqb2REz8NmqDEdgnN2O4J5M=;
 b=fwBOh8hyOkddq4cyDmc1A8yxq+3/BgUU4NeD/6tuPSm8B+NB7ijMe896WEJdJAASWS
 iwinXmOlRrUJf2ZemSPAc8Wms2M7B/XjU7yeAisrn8xB7hyaIN/3PRpARSRrhzinF1tM
 IQuIMsd0vhne1YVbDK+xK8zQ6sgry/RWsxQ775LzGY6TAdv/wSQhVrD8dKWVu6lAE9SZ
 4S4F3Zj0KXE4THiDFTMVQmeguWzfYXur/rQp5te/w4ITbsTzXsBkLLRK+Nd5oLmKYI0Y
 LxuFFud7T2+wFKEHg+7DrXIBMogXySPCc3PmeIWHLQI/XAiUtA1l45O2odWGkt+55qIp
 3dnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmi3eNYloaPXyoMWTEP5MDgmxnKTk5Z9RYxsvEJwuWESlO1PhQQqcLLbRab+tbkCythyXzwxRoxKpP1vsiAKscZs95UlU=
X-Gm-Message-State: AOJu0YwjWk5DVMStZ2NW8L6BiKkEVN8Rejn4BPiHPgUkij6Zbrj8M8nb
 U5Wcmvw055jXt/U82/T5ZceKhN5P9FX3LW11zzeM81yfHZ3Y6c0N/tvt1uKo2Lg=
X-Google-Smtp-Source: AGHT+IFbhwUhTYw3Uqws0hI72DXsEcLeSB4s0EieSx9DHdoUvcqn8yk+DJRo/U64iXuOY49Zr3Uo3A==
X-Received: by 2002:adf:fe90:0:b0:35f:28e1:501f with SMTP id
 ffacd0b85a97d-3607a788c70mr1128317f8f.66.1718348654465; 
 Fri, 14 Jun 2024 00:04:14 -0700 (PDT)
Received: from meli-email.org (adsl-33.109.242.225.tellas.gr. [109.242.225.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075c6fa4esm3380861f8f.67.2024.06.14.00.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 00:04:14 -0700 (PDT)
Date: Fri, 14 Jun 2024 09:38:01 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
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
 <ZmqcFf0xB9m4WkA3@redhat.com>
 <CABgObfb4+FSsadFTVg6Dc1zehQV2Vei2_kSRd5CfxsGBLPN6Eg@mail.gmail.com>
 <Zmq47yQV-sQ0hGMy@redhat.com>
 <CABgObfYaxBxc8GS3=YU=EwNLEihEoD4ikZ595P4m_KTZCAAaBw@mail.gmail.com>
In-Reply-To: <CABgObfYaxBxc8GS3=YU=EwNLEihEoD4ikZ595P4m_KTZCAAaBw@mail.gmail.com>
Message-ID: <f26b0.f15017t08v16@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42c.google.com
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

On Thu, 13 Jun 2024 23:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
>On Thu, Jun 13, 2024 at 11:16 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
>> I guess there's a balance to be had somewhere on the spectrum between doing
>> everything against the raw C binding, vs everything against a perfectly
>> idiomatic Rust API wrapping the C bniding. The latter might be the ideal,
>> but from a pragmmatic POV I doubt we want the barrier to entry to be that
>> high.
>
>Yes, I agree. I guess we could make things work step by step, even
>committing something that only focuses on the build system like
>Manos's work (I'll review it).
>
>I can try to look at the basic QOM interface.
>
>Manos, can you create a page on the wiki? Something like
>https://wiki.qemu.org/Features/Meson.


Certainly! Just to make sure I understood correctly, you mean a wiki 
page describing how things work and tracking the progress?

I added https://wiki.qemu.org/Features/Meson/Rust

And a Meson category https://wiki.qemu.org/Category:Meson

Thanks,
Manos

