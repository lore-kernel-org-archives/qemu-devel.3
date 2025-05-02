Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D55C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 10:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAo4r-0003N1-9f; Fri, 02 May 2025 06:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAo4p-0003Mp-3P
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:57:07 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uAo4m-0007Q1-PK
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:57:06 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso13452335e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 03:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746183423; x=1746788223; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vj5HuKv9glVT8gzdZRhVYIHfs8SfQJDKua/Qa0b7zos=;
 b=cZFAphMMeaS8jPpEEi/9WA8ROpSVnkZN6bpX/svpD1MsHpsumIAnwWhZsszL3QoWJ6
 dxlbMydhpDSD+TcWqjEQvM13YhNOTWj/j0GCwSXAxoYa+CN1hUm/OrNnrJyJJ60UR8wy
 J3EEiUIwCCh55ehJq5hsnV2iHEZuddV6XH4vjH14VPG0zL6JOxUF1S+UVeiY5EoBRfdV
 qHf5BbPUQdVYnwcXRLMyyYdRN6JSFPvItmuv4F70cdmAeMZRqllZmWAu0szKEP6bN4Bo
 98BmBSRjdbxVxDSSernkluomouRU2bNEGNwCU/9YQroG9Ritd8MTgvE+pBGSrvD8/RZm
 6tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746183423; x=1746788223;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vj5HuKv9glVT8gzdZRhVYIHfs8SfQJDKua/Qa0b7zos=;
 b=ppIiiDrzchDKOxUsDA2WZj1dG2LXlOrsjJ6UsjspA+5W2Fywcwwac94Oi2AjsuaQ7O
 srH6I+HAdoipALM/cUMJl95EdAylSrR8G0be9XK61bTuKRtszs1E/EwlyUtX/PDYrgIJ
 8lJlbvy7Fc7zAN9ig0Dt4wrdrtKOWZsm+80JkAC0DPn3yycXyU5+qUYWF1faev3MWE8w
 WhTqKC2kvMlA0gUFafC5hocI83abOVpsQBu+9NEKuSmuvcfQiUXirvInDd1MetHV0d6n
 ctkNjGkfOFXskMo3Yl1/NoT261KwEOq2jPcKfxF3jwM/FZj8f8Ja4XajB/fF8XXL7fzX
 0tng==
X-Gm-Message-State: AOJu0YxVvEIaGbbyPicVZm0FjPPS8u/ZePa6z6sEiMAGzB2Tk0TdHG7b
 C24BTapcZf6zBA6nhLgWn5r8WgjpRP5yQN+bmoWzJPDGbEv3gC2ogF4NGOR5asMsV/37sC2Yqvj
 28s0=
X-Gm-Gg: ASbGncvGbbVmq6iXxPFjpKtLGyI6dCcdGlxqprTzvyfUcxqAswAK8VuCON5A71LjoSg
 UO3WM6l+i3vLq2RfIV42T3i3wLq3s4s+0VyZ4lk4+FUQZW1ol06x/8zd/qlLSAemDEX0YQH8CUe
 osrIv7RwsFuLn68kIX6wY46Bzp9QhzycEbwfAFggwaN+D38J7ecB2hfKPkO9gI7OKd4G6fDf5Sq
 eQWlzRyiBwgkfTzMfKV2fzBnK+L89Fk/TJ0mmLs/6/8J9pg+vPMLxkBNZfUOPASNBmEq39pkYAP
 ygf4RIPaRgw7lTevEnaAYPL74wJm8Dpg1oAHT/bNKCMVx/YODtflCIDLkQ6X2TbwiuLyphgdilx
 JGa6lvg==
X-Google-Smtp-Source: AGHT+IHGNTBBOgX82T5ORi3HjaUolZAwYOXAL04GOhkaDD5BCgmTQRERhnqDM+cnpKptc27ZxKtu6A==
X-Received: by 2002:a05:600d:10:b0:441:bf4e:89c8 with SMTP id
 5b1f17b1804b1-441bf4e8b11mr10844085e9.3.1746183422702; 
 Fri, 02 May 2025 03:57:02 -0700 (PDT)
Received: from meli-email.org (adsl-37.37.6.161.tellas.gr. [37.6.161.37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b20a65sm85968975e9.32.2025.05.02.03.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 03:57:02 -0700 (PDT)
Date: Fri, 02 May 2025 13:54:13 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-rust@nongnu.org
Subject: Re: [PATCH 0/9] rust: allow minimum version of 1.77
User-Agent: meli/0.8.12
References: <20250502102323.104815-1-pbonzini@redhat.com>
In-Reply-To: <20250502102323.104815-1-pbonzini@redhat.com>
Message-ID: <svmrr1.1reefsjrvnmr2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hey Paolo,

We should update the version check in the root meson.build in the first 
patch of this series:

> if have_rust
>   rustc = meson.get_compiler('rust')
>   if rustc.version().version_compare('<1.63.0')
>     if get_option('rust').enabled()
>       error('rustc version ' + rustc.version() + ' is unsupported. Please upgrade to at least 1.63.0')
>     else
>       warning('rustc version ' + rustc.version() + ' is unsupported, disabling Rust compilation.')
>       message('Please upgrade to at least 1.63.0 to use Rust.')
>       have_rust = false
>     endif
>   endif
> endif

