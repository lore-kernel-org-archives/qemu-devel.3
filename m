Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7D1C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 18:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lfa-0004Va-TR; Wed, 08 May 2024 14:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1s4lfP-0004UM-8w
 for qemu-devel@nongnu.org; Wed, 08 May 2024 14:05:27 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1s4lfM-0005LR-Hk
 for qemu-devel@nongnu.org; Wed, 08 May 2024 14:05:23 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5b203ce4ef0so6525eaf.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715191517; x=1715796317; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eENa/BZ/fp6up6GGz0T8HJY5xaqtroVQNCQ7oEBn7fs=;
 b=UVMkkOz4EUv1uLLEN2RLwcMPpCcftnlhTMD590wt6EC2frRz4kkeyLvZVEZrCK+oNb
 9UXFA/FWgVl7abOnj5o8UarR4fAknEsdoMToxK/4dP0wEU8RiRJEQlWLnvgCryifGeRZ
 ts25794/QULdY1gFvBy5I51oA3zlMfwNOHESO8usQ4668s0bTBlIEakUXPybIWlO7yyJ
 DE0L79Jq3Sjn6pNklvURm1VSbnIEMm3whkZRZc5TtKQ8h+Yp/+ClAUKwbsQHZ160QCQl
 LFyK6MWlzyhcau1/q+qt+ouJUWF5k75KZ9sJ7ENsknNi+69zxbMIKl4ayvT0IYpLuYu7
 d6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715191517; x=1715796317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eENa/BZ/fp6up6GGz0T8HJY5xaqtroVQNCQ7oEBn7fs=;
 b=sMCUKb56JJLwgw9eZgJeKHwe6Y9qjYpTQZI+5ac6yy4Dgf+y9Q8knJdayghNUnfqUV
 YuYoE0M4QQ4JunZ/s4s2eD68QgXkCBkeCPvRV7qopgCcD6D9ncBTMuGq0sIVyW63g0NC
 Ej7dktMDzLl1FQmoNJwjWGecNOrCnBG7AJUj4cI606lULb04e2Z0r12+WikFxZvErf1B
 VJa7M4KSfu3i4xXS/zXooUEq+DQ0zV08pnlA0a4cU9RXYNgJkHDW9Ix+BscgsexVSrRe
 U7T4nyU9xUejBrQowMUQMmOEGgVCkIQka8P2YGzf+femQvdO91JczWHyXCcArtLJ+Wjx
 vMQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQtP4gVYcxlqz29N+LyRuzb/NfUjBoD38a1l3nFputvYoq3fW0rjfcGDpWrGwr9tqEU/8fisAmH6XNgpHzITY/dRbDWX8=
X-Gm-Message-State: AOJu0YyjC3NZuPYePYBKG3jZy3OaMUiWmDIv/Si0xJqnChf3dgMY3rn8
 YfhkApu7UuSUntHzDafNkUnoIA54IfG1nFVMAcZedSZqAGLX6OyujRBqVnXGybhz7OmzpyvQ+2k
 6uTU1pA8vGxxNMdMyykZKQ85/L78=
X-Google-Smtp-Source: AGHT+IGhWG4dz+kFxrU5hYik2+BHPtja35yNpr2LuXwibCiun1MJcz9X4Mq2x18zpp7KJpSowwe2RXnbttH488r7ryA=
X-Received: by 2002:a4a:8c32:0:b0:5af:292b:6982 with SMTP id
 006d021491bc7-5b24d5e6a16mr3202601eaf.5.1715191516878; Wed, 08 May 2024
 11:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240508043229.3433128-1-zhao1.liu@intel.com>
In-Reply-To: <20240508043229.3433128-1-zhao1.liu@intel.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 8 May 2024 14:05:04 -0400
Message-ID: <CAJSP0QX0y_J1pu+hgUNhXn7bFJfoAMm9Ux9vq3u+k_UDjwK8Ww@mail.gmail.com>
Subject: Re: [PATCH] scripts/simpletrace: Mark output with unstable timestamp
 as WARN
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Mads Ynddal <mads@ynddal.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 8 May 2024 at 00:19, Zhao Liu <zhao1.liu@intel.com> wrote:
>
> In some trace log, there're unstable timestamp breaking temporal
> ordering of trace records. For example:
>
> kvm_run_exit -0.015 pid=3289596 cpu_index=0x0 reason=0x6
> kvm_vm_ioctl -0.020 pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
> kvm_vm_ioctl -0.021 pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
>
> Negative delta intervals tend to get drowned in the massive trace logs,
> and an unstable timestamp can corrupt the calculation of intervals
> between two events adjacent to it.
>
> Therefore, mark the outputs with unstable timestamps as WARN like:

Why are the timestamps non-monotonic?

In a situation like that maybe not only the negative timestamps are
useless but even some positive timestamps are incorrect. I think it's
worth understanding the nature of the instability before merging a
fix.

Stefan

>
> WARN: skip unstable timestamp: kvm_run_exit cur(8497404907761146)-pre(8497404907761161) pid=3289596 cpu_index=0x0 reason=0x6
> WARN: skip unstable timestamp: kvm_vm_ioctl cur(8497404908603653)-pre(8497404908603673) pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
> WARN: skip unstable timestamp: kvm_vm_ioctl cur(8497404908625787)-pre(8497404908625808) pid=3289596 type=0xffffffffc008ae67 arg=0x7ffeefb5aa60
>
> This would help to identify unusual events.
>
> And skip them without updating Formatter2.last_timestamp_ns to avoid
> time back.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  scripts/simpletrace.py | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
> index cef81b0707f0..23911dddb8a6 100755
> --- a/scripts/simpletrace.py
> +++ b/scripts/simpletrace.py
> @@ -343,6 +343,17 @@ def __init__(self):
>          def catchall(self, *rec_args, event, timestamp_ns, pid, event_id):
>              if self.last_timestamp_ns is None:
>                  self.last_timestamp_ns = timestamp_ns
> +
> +            if timestamp_ns < self.last_timestamp_ns:
> +                fields = [
> +                    f'{name}={r}' if is_string(type) else f'{name}=0x{r:x}'
> +                    for r, (type, name) in zip(rec_args, event.args)
> +                ]
> +                print(f'WARN: skip unstable timestamp: {event.name} '
> +                      f'cur({timestamp_ns})-pre({self.last_timestamp_ns}) {pid=} ' +
> +                      f' '.join(fields))
> +                return
> +
>              delta_ns = timestamp_ns - self.last_timestamp_ns
>              self.last_timestamp_ns = timestamp_ns
>
> --
> 2.34.1
>
>

