Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4321BC25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 06:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDeQn-00058d-TA; Sun, 02 Jun 2024 02:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sDeQl-00057u-7P
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 02:10:59 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sDeQj-0007AX-Jc
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 02:10:58 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f44b42e9a6so25871845ad.0
 for <qemu-devel@nongnu.org>; Sat, 01 Jun 2024 23:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717308656; x=1717913456;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=voDRJVjzQNSxWDJC8y9qDc/zY+viPyBzYvA73adSijY=;
 b=gbRC8vKi3qk9O1njBXv7xBEKnff+Ua0MKmhq7DPZ7m/KMRDHCXtQXHocqDQXDKuBLA
 5pNW47/OiomtbcHQ5OPSuBEwWM20//F5IrSMpJlpFg3+8nZJ/c3SWuRAXQwGIBPRATK0
 1bxgrlz51sEauwIYYbBqZ/eTECeyJO15R/zsbZHPuvztXdoyfQ+Hz7lolnFeQchl2jZM
 l5nKAD1fSz3m1oOUN58OzxPKnkwnwvD9kATgZdFhVGJMs5UM8p+2KbL7PDUe0T6Fc1sS
 9551jwJKXpD8MWUHghDmCy8kfpAQUUcrhRaL38i6orjXRyHx9C8xrpHzV1S8VV6ilkmF
 ppSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717308656; x=1717913456;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=voDRJVjzQNSxWDJC8y9qDc/zY+viPyBzYvA73adSijY=;
 b=HQb9iaZhEX7tjufObXirjf4hnpp3iQV/vJT2Q0bVwV3L9LvRK+IpWcFlOSFHnUXTuo
 OaUgSOZ2MyLCQo0Q1M4Lx7i/2FMzOZ+7v49Acjc7/7k8gS64X3jHGwCiHTjjQ3CNqqJ1
 MpSmsbkgfUz1fQHS2+KkETyvl0BHW9thZyG9DkIxIFCpnNYDAHMuNofWcfI6VOlshddW
 aqQTkYDFQCi7ex7oKtRq0U4K8XcoFX/a0RsAhkWf7IzdVtneq6R/DJothNv+1zJRGd3r
 Tww7FbwdTyvhgdplM+baUvP1CwCbJa9yMDNm5NmDu+q1tHUcc7aKlixXBfAngYtB09ys
 USQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHR6/nuEhAKv8QCsud1EYabHB89ram6App/E/Zoa7kCxWEwwuTFV2TOZ6C6F4r+rxhuv5jtHT0HvFIj2MQ7QmSlUheM3k=
X-Gm-Message-State: AOJu0Yx4rtP1zPPEC4S84TwzK89Kid/PMQcsH3d0gTEwxP53UUafsxl2
 TH42PJ3KHw9GPcwa02v0fVAJRL04zGEdIZtRqt2k0E2do+3z1YoEty5YFNSQ15Vc9PcyFJpWaW5
 k6zc=
X-Google-Smtp-Source: AGHT+IGgL/yId8FDUmuvMfbeolUbTSJH4MqB2WtK5sago1yTPD/7SZrdKSWT9lK51zcV8P06XDc0CA==
X-Received: by 2002:a17:902:d48a:b0:1f6:5893:d6ae with SMTP id
 d9443c01a7336-1f65893d994mr25000845ad.50.1717308655937; 
 Sat, 01 Jun 2024 23:10:55 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6342c6acfsm41967265ad.265.2024.06.01.23.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jun 2024 23:10:55 -0700 (PDT)
Message-ID: <c845165a-ef63-4174-b18d-51031b29503a@daynix.com>
Date: Sun, 2 Jun 2024 15:10:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/5] meson: move block.syms dependency out of
 libblock
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240527104937.30443-1-pbonzini@redhat.com>
 <20240527104937.30443-3-pbonzini@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240527104937.30443-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

 >On 2024/05/27 19:49, Paolo Bonzini wrote:
> In order to define libqemuutil symbols that are requested by block modules,
> QEMU currently uses a combination of the "link_depends" argument of
> libraries (which is propagated into dependencies, but not available in
> dependencies) and the "link_args" argument of declare_dependency()
> (which _is_ available in static_library, but probably not used for
> historical reasons only).
> 
> Unfortunately the link_depends will not be propagated into the
> "block" dependency if it is defined using
> declare_dependency(objects: ...); and it is not possible to
> add it directly to the dependency because the keyword argument
> simply is not available.
> 
> The only solution, in order to switch to defining the dependency
> without using "link_whole" (which has problems of its own, see
> https://github.com/mesonbuild/meson/pull/8151#issuecomment-754796420),
> is unfortunately to add the link_args and link_depends to the
> executables directly; fortunately there is just four of them.
> 
> It is possible (and I will look into it) to add "link_depends"
> to declare_dependency(), but it probably will be a while before
> QEMU can use it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

This is not ideal but I think is good enough.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

