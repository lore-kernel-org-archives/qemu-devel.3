Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8F6C27C53
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 08:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGEOb-0005Ac-Mw; Sun, 09 Jun 2024 04:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sGEOZ-0005AT-SD
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 04:59:24 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sGEOW-0000Nv-TJ
 for qemu-devel@nongnu.org; Sun, 09 Jun 2024 04:59:22 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7046e87e9afso105724b3a.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 01:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717923559; x=1718528359;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TiNXRggKOd8tiPolmpM0X1M1FzyLTexY4bsdWhAi1fA=;
 b=wJ4Z8rpmKgTWvTdxI5LNdH/rYgrfAwvkep1Lv+k7CXfqWckU+ewTom4lR1hDEDK+Oa
 vFPBW7PI7O+E15mT7YB/U1tr6exL/D0nBFFJLe3d63odssXjg5RCpC8ph80dFKJf0mU2
 iM2eLr/J/854iO78VNKORFgr+DcRKkrn7VdokwAKMQ9z2Kw2wXf7qnf+0/TqkZFzJdRL
 Jm0y0oCCopRey3kwBB+C/9jiDLZEuJ3Xi4EYr0O4+zUpCBWj7dlsnaXHbUEV0K1jBwMK
 /0AnAJ/iW31h3Br+CWsTXOADxCJY2vbF7id+q+62s52x+qi6ENld/kLZt32AXF644Ij4
 Onag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717923559; x=1718528359;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TiNXRggKOd8tiPolmpM0X1M1FzyLTexY4bsdWhAi1fA=;
 b=ePPME5jdwXqIT+KrKFnJHj0f/aUpWZxP0eE2GpPgH6utifk+fr0k9A06PhSeJsiv4G
 6B+BzaIIN4Kzui4uWv6xOZtkx5kiomZgLwi4W62oVMkW+MXwLxgv6N0iBXOLYTKRUlJJ
 F74pRLkuzZtgY3i6aWdFYmyIqkqbNx4rju11KoXxGTsFg5zn/yapDv3Sy8nmyi7HhxCs
 MEbA0I7TvAq0oeB2uDvpB22keKv8eJwdZDWZJUYdH8fzI9ONI2Hue7WG5Qa9qQcco6sl
 P6y1V/ENBzb9Xex4e0oIsqCXWKtNWU10wufyam25lj8b3BUmQMuYb2ETlxcAw/dbz8eO
 B/Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmrf36cHa1qZYxyvbTzSm+k2iTPesrQFrAud0H4GFeN4RGlkQbtqI7R2kL4Y4HhwaRjKJhKa+66nbZweSYnVySoSprc3o=
X-Gm-Message-State: AOJu0YwxGTH7pisI4o9zQwX+EcPC3r/jPFu7b06y2ezM42W6SrLlQK+K
 k5RtQd3RsuV8fbOsiPCiw3JFcjL6KTDZ21COW1XuFBBHHN8hcRrQ+/rf2q9CB+WHqauHr56zPOK
 wjk4=
X-Google-Smtp-Source: AGHT+IE3zxmrXcL0/sidHCQpnpSnUFe6dB1tGiXKKpDgIS4yaUNA7TiQdQFke3qqwoH7PH8LgljLUQ==
X-Received: by 2002:a05:6a00:8506:b0:704:25de:f297 with SMTP id
 d2e1a72fcca58-70425def3f2mr2182639b3a.29.1717923558649; 
 Sun, 09 Jun 2024 01:59:18 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd3774besm5310345b3a.14.2024.06.09.01.59.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jun 2024 01:59:18 -0700 (PDT)
Message-ID: <16786a0d-4cf5-4e62-9db1-a2f448f4b8a6@daynix.com>
Date: Sun, 9 Jun 2024 17:59:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw: Moves int_clamp() implementations to header
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, marcandre.lureau@redhat.com
References: <20240608202045.2815-1-phil@philjordan.eu>
 <20240608202045.2815-3-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240608202045.2815-3-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
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

On 2024/06/09 5:20, Phil Dennis-Jordan wrote:
> Both hw/input/hid.c and hw/usb/dev-wacom.c define identical versions
> (aside from code formatting) of a clamping function, int_clamp().
> (marked inline) To avoid duplication and to enable further re-use, this
> change moves the function into qemu/cutils.h.

Wht about replacing int_clamp(a, b, c) with MIN(MAX(a, b), c)? 
MIN(MAX(a, b), c) has a few advantages:
- It works with any integer types
   (so you can replace even uint_clamp() in hw/display/vga.c)
- It makes clear that b is the minimum value and c is the maximum value
   while it is not with int_clamp()
- It is already used in other places.

