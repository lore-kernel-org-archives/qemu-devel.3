Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D175CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 06:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS7rX-000134-TA; Wed, 27 May 2026 02:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wS7rU-000127-Ix
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:35:28 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wS7rT-0003iR-0j
 for qemu-devel@nongnu.org; Wed, 27 May 2026 02:35:28 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4526a8170ceso5783665f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 23:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779863725; x=1780468525; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=35tjvRDf4IvXuC9qFXqLgZGbYREDKhqwvEQqRe+6hUI=;
 b=hEbGZCFudyycOrudhagy630G314IWB6OOiQ0GoacGqZ/SNvklk32Hhx56ykCTVqvwR
 vkhcLzlhF3TCwcFN3zBUdK9xW7qstXT882ATGJKPgJf9vA2hQrpqruetZVhLfdh/KlP1
 nNph2eoBCJx3wLl3T6rl7kMe/XTZ+rehT8nGg56SjjRvWJnSPwnTKFVQtswyL8bNMzUd
 KWP4pInGoU2CUS1RSShVBQO+64hF9AGxSuPt5mPOFj8zY5cyx1zfsgxKsevQS5wskkvj
 fSuQY1Ot9WVbHy0fCIJZiRbKlAYj06dAtlUG3sKxL+dIU2vOss2/xsZOtPycfI0bF9Ka
 t5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779863725; x=1780468525;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=35tjvRDf4IvXuC9qFXqLgZGbYREDKhqwvEQqRe+6hUI=;
 b=TW1z+JSHkA3+qb2ukvt6RUVh10OacCh2JAsEbejwpcBmG7gh7mUYghu9XJbH0sLD7N
 SwzvtKV7zZJ9axD6ibI0a6YayyA4GuHAs8N+wo+d8ThdJEz9t7KPrKYSL8qId2YTtTDQ
 MG1msZRGKliEVQQ+xoK9HdSvv01OfbqXJCxUp3/3hqz0uLb1iO2sFH1KcBJ2M/o8qXsL
 mH0mRhoCI+gkEyHRVyhTINOZx3Jn/F7HKkKCgSu7nXN7iCK0fm4FEf5iDsNBTk4S3fZ2
 WBDKfT2htDS69xoHVHmI6l/Z2p+Y5gqTA638fSBHwG6tvIDBWIYnQfqhCvmBqSRMvAYj
 bQ1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Lb187RZhfgbQP7ebR3192yAEgX0Ufwsdr4+Ch+Y9QJNLevxqW5NKXDFU1eIM7PFUxrKf06SMNsoYd@nongnu.org
X-Gm-Message-State: AOJu0YyY0JEArmqDg0X9VqhEbgPl8rboLZnZDkNVv0irxQYXXY9jpbb0
 54YxNyJpiwb+HiBFtvQBQstpCbGdGWeGOM0jBJ54omojab+zsu99MajTh/x2JQnUqX4=
X-Gm-Gg: Acq92OGK9osEuf2pGrhbjwrHGkcMY9VSojKMRj9aBYY6Gz0OEGwqkp/m9q3K/nVRdpI
 XCyWQvYszu7vsN+DJnTV8IA175SHV8IgzRoTdlyLsI/uMGMUNK/HEk3DW6+ZGniwFVRisWBF6jh
 TP6ixqruPVmXm1yMZkBYNxwEq5+yAjCGD6ILyQRKea2JHsGmNRkiXyYGvZAFGyeQN+NZ3NpvA0X
 j2YsObDwJXVFybgwYU9J/JOTKGCZetOtAU2XgWscJv/U/e04bxUQlZLbxc4GWuc/4RsuOsEFksa
 /zOAJFkNSZgnleEaE1VixOe83NmtEFkiZyEY7uWAELGkGI8TIvi0hPIMdouWLsGY8Q0mua3HejN
 CHH7yhw8MeW/j4ONhU7aV3clguTBUQD6JGPs+YXdzkSOPhKQgEdkHIKqIG/APFYbJ/+tbAuQ4tY
 jD2i3xLSTCof58fO1PwCBDh43Hn6Xa0tL8/MHrybjFNPG4ANwTpJbchqIZEUKfC4by+j/nOzw=
X-Received: by 2002:a05:6000:4010:b0:43d:7b90:fa23 with SMTP id
 ffacd0b85a97d-45eb38b7b7cmr37571989f8f.29.1779863725305; 
 Tue, 26 May 2026 23:35:25 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb4bae01sm3774141f8f.0.2026.05.26.23.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 23:35:24 -0700 (PDT)
Message-ID: <20109bef-cdd2-41c7-b30a-8039944b7d96@linaro.org>
Date: Wed, 27 May 2026 08:35:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] ebpf: move ebpf skeleton source to ebpf/ directory
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
 <20260508152428.2648560-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260508152428.2648560-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 8/5/26 17:24, Peter Maydell wrote:
> Currently the code and makefile to regenerate rss.bpf.skeleton.h
> are in tools/ebpf/. This isn't really a good fit, because the tools/
> directory ought to be standalone tools of the kind that we build
> with configured with --enable-tools and document in docs/tools.
> 
> Move it to ebpf/bpf-src with the rest of the ebpf code.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   {tools/ebpf => ebpf/bpf-src}/Makefile.ebpf | 2 +-
>   {tools/ebpf => ebpf/bpf-src}/rss.bpf.c     | 0
>   2 files changed, 1 insertion(+), 1 deletion(-)
>   rename {tools/ebpf => ebpf/bpf-src}/Makefile.ebpf (96%)
>   rename {tools/ebpf => ebpf/bpf-src}/rss.bpf.c (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

