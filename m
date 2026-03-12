Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD12FED2F9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 10:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0cvq-0001RC-Gd; Thu, 12 Mar 2026 06:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0cvm-0001Ok-Jg
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 06:06:14 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0cvk-0002U6-Nw
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 06:06:14 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso9599615e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 03:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773309971; x=1773914771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iymtGmR/890I08OsjJ87tJm75o/s9OOevshp/uCw5TI=;
 b=qsIGCICO/uD4CKxnsMtdg5d5c+ZE4V4b/t3y7HTh3/GwFEGYCnOUIop5VsXOfO9Npr
 GN/4QtMHYrNldGmciMp0MS1P47gHbNRneRagPpFHz3JggY/xiZk5dIWaMJS6Gc1waZhY
 L+NJ8tyx+dZVHTJ2NTMlpuOvaWopO23Ibrqt3CMUpz+Z8sB8UNZv8DRz0+85fd9WTStg
 fK/fGynYKoPdte5oHA7bwxz1fOI4Wc+p4d8U4mbAiJrThROhLUol0wkx9Nt64zzVNGJN
 /igbDDoTg7SO0QQqDeE5qMbCyTPxFTw2Sj2zzbWfNa44ylNLTpdLjTDQ5nlfs64r0JGX
 N+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773309971; x=1773914771;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iymtGmR/890I08OsjJ87tJm75o/s9OOevshp/uCw5TI=;
 b=gksWKz2KlHbmD/TdSzBbQ0vHnVIOh280uZUHCCzvLTQszA5fSV8zipjF304qBo7OLu
 SuLhvkZUL4khi0VYtK63MvSUPcjENtMTDV09AtDgXVtafrkNP7hHzz+JFHEtiNfBdVVw
 TSljvAkiiUbK5G0o4maI4wiwwimMuZpo6ZNzMyuQ2LE93mcydg0WVgPs3GrkQEHRMPkT
 LdcIIHDafi3Uo1Y7QukdsFpzgTYpCCRVzB5CsSc/pACl8cu4E4a6l9T9R94B5qqwzIDQ
 9Aycx0vp+T36dW9etWC+AjWGsI2MVXbN3COR7ZSEnkiBF5bFF4m1Dv+hTSgkM9eybHda
 S+KA==
X-Gm-Message-State: AOJu0Yzu/3lKGKuR1Cv79hC439YqS9eOrqtylQf3xzRC3pX/E1rNf8gA
 ajwtoMzR4RDnsCsEgpY/CfMZK9oYOG+dLFr+AkWZDEphH+dkZYgZLBL+sPKste7WiPI=
X-Gm-Gg: ATEYQzxyMrZy855bWXvzxbU1qVjWlUzzpWP0jIehQ5jmEvQ1ieAJzx7KXWGwxR4KV/O
 yafxptZraBJqrZTdC/AeIMPPm61EZmWgSa7Ya+rpVGIgvGt9J32MMaDpVGoxDCsVopFp/SBKR76
 f4e4ZaHPt2g820J5vN4wE4UrjlNKNJlX/GhplVDP+Iwe3oH2cA+9+YgxIFGG94O4Mm1WPi0tjLb
 m6iIlLue2jvp8LUP1IBPuUpwjzO7kjQypQ93cPOZS3kkDPFujl550IykIhPrlLaPzhhhF5RZe9B
 01YvMXu+JoU69Q9Q1XzQZh/lefUgC8L62wgS29HU0OdIcG36cl3rUlMvQZwnt8FSYPu2H0kz1Q2
 DeP6itwf5Zx2zGdVbcvA/1yMHCEmuDgLFQcgYNtpwZoCAwQ3vW/O6AWFfd9lT2o+tnXxaUHJuPb
 nSH4fqH3dHWc6gG0nK+sZhjwZA8OphN6z4kztto1wXOZSvrji/9pDWb6PUCOMpkjU8DQ==
X-Received: by 2002:a05:6000:2304:b0:439:c5cf:fc73 with SMTP id
 ffacd0b85a97d-439f81e23cfmr11240689f8f.12.1773309970604; 
 Thu, 12 Mar 2026 03:06:10 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19acbbsm7260086f8f.2.2026.03.12.03.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 03:06:10 -0700 (PDT)
Message-ID: <dd99087a-58bc-41db-820c-4a37b58c56ac@linaro.org>
Date: Thu, 12 Mar 2026 11:06:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] gdbstub: Always infer base register index from GDB
 XML
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Mark Burton <mburton@qti.qualcomm.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20260311013837.69945-1-pierrick.bouvier@linaro.org>
 <CAFEAcA-FtvvZhgYJVHD+Btxjq4RXVdW88ysPhqTgOJPm7og25Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-FtvvZhgYJVHD+Btxjq4RXVdW88ysPhqTgOJPm7og25Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/3/26 10:47, Peter Maydell wrote:
> On Wed, 11 Mar 2026 at 01:38, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> The following changes since commit ae56950eac7b61b1abf42003329ee0f3ce111711:
>>
>>    Merge tag 'firmware-20260310-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-03-10 13:32:30 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/pbo-linaro/qemu tags/pr-gdbstub-20260310
>>
>> for you to fetch changes up to 6511d4eed79a7e59f03e661f31924277e4d6e600:
>>
>>    gdbstub: Generate a single gdbstub-xml.c / gdb_static_features[] (2026-03-10 17:12:18 -0700)
>>
>> ----------------------------------------------------------------
>> - [PATCH v4 00/16] gdbstub: Always infer base register index from GDB (=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>)
>>    Link: https://lore.kernel.org/qemu-devel/20260310232045.58440-1-philmd@linaro.org
>>
>> ----------------------------------------------------------------
> 
> 
> 
> Applied, thanks.

As of this merged commit 769a37d8bd0:

   v10.0: Total build units: 7797
          (https://gitlab.com/qemu-project/qemu/-/jobs/9788294720)
   v10.1: Total build units: 6443
          (https://gitlab.com/qemu-project/qemu/-/jobs/11142814212)
   v10.2: Total build units: 6367
          (https://gitlab.com/qemu-project/qemu/-/jobs/12474666739)
current: Total build units: 5679
          (https://gitlab.com/qemu-project/qemu/-/jobs/11142814212)

v10.2 -> v11.0 delta so far: 6367 - 5679 = 688  (-12%)
v10.0 -> v11.0 delta so far: 7797 - 5679 = 2118 (-37%)

I'd like to thanks Alex for pushing this effort forward, Pierrick
Richard Anton and few others for the work done and reviews.

(We are no down to 2 duplicated common symbols, then start the
harder parts with duplicated target symbols...)

