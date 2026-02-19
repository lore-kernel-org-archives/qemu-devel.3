Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93ACE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 03:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsufr-0002r5-Sw; Wed, 18 Feb 2026 22:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsufq-0002qj-3O
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 22:25:54 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsufo-0006V1-HX
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 22:25:53 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c70378ddaafso272011a12.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 19:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771471551; x=1772076351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xZtMqoBM+JC6W7HM8lhkJa3WjrReTwoR/27QiAoEVv4=;
 b=xtnm7ui27WX6EMsftbCiYtptlawXjVphO+HlcNQc/Q5nFsrvK3PY3G8fBnY1u3wi9p
 P0n0plz1C/lt1WqfjgDCPGXk4bsmiQqTEkxOQQQwL8LaztYhkbFE0yR1tXywncmBLP1Q
 oGU6/HgJFYoiPUEemuX/GOVRBuf/doDlAt11tFjDKQZjD4gYnRqw3P3v3CqtM8T5QTuP
 wJpTG9o7StTbOAnFipVHmany6oFC15aup18oU8gZWSLt0rcHqaiipXknZurVoUc7M1I2
 Ha3woaYv68QUQjAXwUU+oye1XDEtfDhGcxOMckoedCtOmGddL6XABR/ct6BrGtPKOusJ
 L4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771471551; x=1772076351;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xZtMqoBM+JC6W7HM8lhkJa3WjrReTwoR/27QiAoEVv4=;
 b=DeZcFyKSBROXzBpkZzZxybRmpcnGMrgh8hLmlset8DFLkAMuD89cZQrOItjysI+Y4g
 MUFmIgav0U3rlS54d7vx9m4FTCWK5VGSSaTXbGhkW1iDAYO0/XKxTHGNAwdaQpQJ26WN
 55TmJciGgqwqVFuz75344Jh3Zn6kow9iYi0hlH2XKACpxKVGuEtlmqTjI8NDwgotW/5p
 6KwuLbHO4MUBt+o5ByioF4egtFy8F9ud4yYA9JPQ0bUgygG4M4KBJrSlnvyffqO5ux1G
 pp9htlsWnYn8lbubU44OOfZblPGJpa9uOjkylOs1csgwcL85OhnF5Z3PrL7RRuT7A9bb
 l2mw==
X-Gm-Message-State: AOJu0YxJVhQDcNpFofeDZJir3/w+o8ftkom+FEYNCJ7CQSRIlUh98t2i
 NKFUaiQpmhhq9vE1ZMcu2QvG5tRDPgMogsNkIjVhbX4lYGKRweoWo+xIc7ZMOrnVOKO3A0bYNEs
 UIckeS4I=
X-Gm-Gg: AZuq6aLYg/c2mUDeT7IoMbqQBY6pZ7WioPku+G6y3g755h40OqM/MNt8mIuK+tgbqnl
 P+ImbOSMOgITpeUUXfYdQjCa0LheCMsOgb279aLNPJNF8dZXknLmD0a3jiZTgXkXhz4W3r3xT7o
 ayzcUVZt9MjgLD7CHU98wI+zLgeDze+hoIja3i/pMih/sa0S3RHC9/unElhNTWVSmSQR5xBkLnx
 BDZSfSHFc2DPIq+kLKATduxDnNJhujj4ZA43ROq025dz/iSnYMtwgu90onIQd1McI4qxnAUPJym
 8WlIOv+Q+NyslcGNFHlJEVXwyVGTN5VrDW6gHTIPB1PR9/YmKwQJnudQ1KAVG483x4q2BluFN4a
 EEvH6jFs34oPTgpBGTHdQOzrjBsmlj2LXLzjOAijXj1FcDbcH5t8FLa5/ue2d5ALlqulfGTVcox
 aFMqT8BUqJ4ofPgbpEEF8PyscCzsWC6VnnuINHqHKC/whxscUgut6x1xQE/xJOHkWokIPxbgQQJ
 XtoXlmCSE1V8zTrm+aTt3Y6IHFwim20Pr0f2EjjJD/pwW3NPs3BpJnTFaqwXHzqXUqQ
X-Received: by 2002:a17:902:d2cd:b0:2a7:afb2:ce1c with SMTP id
 d9443c01a7336-2ad175b9a93mr176896385ad.61.1771471550840; 
 Wed, 18 Feb 2026 19:25:50 -0800 (PST)
Received: from ?IPV6:2403:580b:742d:0:a224:e0c2:669c:b307?
 (2403-580b-742d-0-a224-e0c2-669c-b307.ip6.aussiebb.net.
 [2403:580b:742d:0:a224:e0c2:669c:b307])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aaf5506sm141679655ad.87.2026.02.18.19.25.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 19:25:50 -0800 (PST)
Message-ID: <8ac70bf7-2856-48d0-8451-770bb35d27c4@linaro.org>
Date: Thu, 19 Feb 2026 13:25:45 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] system/globals: Build as common code
To: qemu-devel@nongnu.org
References: <20260216213121.47122-1-philmd@linaro.org>
 <20260216213121.47122-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260216213121.47122-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 2/17/26 07:31, Philippe Mathieu-Daudé wrote:
> Now that  all targets have the graphic dimension variables
> initialized the same way, we can move them to the common
> file unit, having them built once. Remove the now empty
> globals-target.c file. The command line '-g WxH[xD]' option
> is not changed and behaves the same.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   system/globals-target.c | 14 --------------
>   system/globals.c        |  3 +++
>   system/meson.build      |  4 ----
>   3 files changed, 3 insertions(+), 18 deletions(-)
>   delete mode 100644 system/globals-target.c


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

