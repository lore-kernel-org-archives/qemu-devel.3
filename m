Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BB8C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 06:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHzQo-0002PK-1J; Thu, 22 May 2025 02:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHzQf-0002OQ-Gc
 for qemu-devel@nongnu.org; Thu, 22 May 2025 02:29:24 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHzQZ-00009O-0F
 for qemu-devel@nongnu.org; Thu, 22 May 2025 02:29:21 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-742c5eb7d1cso6034565b3a.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 23:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747895352; x=1748500152;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X7wJaoojbNMJ4yW0rFuO9RrN4Wd9IZN5FjfpVj1pWuw=;
 b=RDuRwwf7CPgI4oZ6+D8Zo0615YmcV0O30GNkL82sA1XHEk17Q5r/iTv+2Wur8PTzFl
 H1/bAhyLSk2Q5bn0/hkmCKtcsiZ/DxNzBICkd22K8RbFq0yRX/1D4KM6HJULBnysUcfT
 8bg4RkPa81SMQMk1n8kP1LpYMmMG/fqPVMsrRQk7uj4hpu25zDh52DD1Hfh3DIgB5w3E
 ww4hCEXUg8eE43tqUvA4vaIB+GyaG0WAXllnSZffcDUMEDgwpchhyUr7R4S34O88IOow
 meyHFX/HRCoy0dAu2uxRIYrh/y/SDeOJesqFF9CKe6r5aOjYK5Hqz6/H7MaIl1RzH2ai
 Ve8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747895352; x=1748500152;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X7wJaoojbNMJ4yW0rFuO9RrN4Wd9IZN5FjfpVj1pWuw=;
 b=PvRZ+EOdFzOcADfzF8zCbmw+skuRL6BvVyOe9IiU6DL8rSHGz/s+w4CMo0CpiCPRzB
 +/rqxc9rilmermlpSArn8YJjSeaDTQHtOeFI6OJXGNSLIxRm/bit/StNMGNeTRzuQBDI
 tRVch4zvMyi01AQ6pjOhBUUck3eDVMwz4MBaJAZm9YhQ4rfi1PdmYkB9TRF4S2ZAnbab
 IXVzhG5aYs7Z7VwxHJDyi3QBGzs7pbBk3tIhXCCX7QUo/1mkiqFYjk3ZkIswfKSj87cB
 XY4rCO8+l6TEMmwv+SJUZ7AGP+3IIaTYGlqAXmgeEY8ZQGECwAaUvqYLgGGNwUTGNL6B
 ovRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEqD6zd/PH8XeehQ7zBc2Ym6Jk9bAretXcrfCKwMyWbur8dztVSlJfZm2EBAbdWXfc2OuFtAYaH0UJ@nongnu.org
X-Gm-Message-State: AOJu0YwZmux8tJu2pcrL8QpKQKe14iUuyXATKTO1FEjPbuy02e0vc9t7
 DuBLTZAd2RK5D3vbiyO/hcMT6SDXkM7SECfUOkqdNcST72bKAKNPaQD7pyM9gF5RNZc=
X-Gm-Gg: ASbGncvbtaI024j0cu231Tl0bFfAzlPLeuhCCJM9fgwipRukP5wch/KMzIS+VmVsKgB
 2y6G8lQOVvr712PAI90NtpbsZFKP0uo9zk/C43X3+D0RgA00Oj2tBhQ0tWDbck8yoKurvX77Mx/
 t7qfsOqExipFTw+vYc2blmBPh/f7sgeOQ/6zJIdoY3nzOBe6C6UnMrKTMhuDT200Xm1t8xixpJR
 uBwMR0Yk8mVXerCNKxEsDCGkMeQWpvKhXYMVGtsqFvDiEM9z5gaNvVl5Nsw2G0gySWbdqlX5UFC
 XRFLMuURq6ojSgyEU4A7SNQ8YRiXvulMq8PM+rq4wequWatj1S44Oj0fr6o9Vw==
X-Google-Smtp-Source: AGHT+IE1HJ96JVinrS9Y5I3LAC6A8WMBYeeLwC5abBhLV9ZVlcJcqNt+jIGZmR3nLyMsxzttAVOfFw==
X-Received: by 2002:a05:6a00:ab87:b0:73c:c11:b42e with SMTP id
 d2e1a72fcca58-742a98d427dmr30701216b3a.20.1747895352477; 
 Wed, 21 May 2025 23:29:12 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a970b9basm10545596b3a.49.2025.05.21.23.29.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 23:29:12 -0700 (PDT)
Message-ID: <0e6cb7af-37eb-4e8d-b342-ecfcdb639f10@daynix.com>
Date: Thu, 22 May 2025 15:29:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/20] gdbstub: Implement qGDBServerVersion packet
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>,
 Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-20-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250521164250.135776-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 2025/05/22 1:42, Alex Bennée wrote:
> From: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
> 
> This commit adds support for the `qGDBServerVersion` packet to the qemu
> gdbstub  which could be used by clients to detect the QEMU version
> (and, e.g., use a workaround for known bugs).
> 
> This packet is not documented/standarized by GDB but it was implemented
> by LLDB gdbstub [0] and is helpful for projects like Pwndbg [1].
> 
> This has been implemented by Patryk, who I included in Co-authored-by
> and who asked me to send the patch.
> 
> [0] https://lldb.llvm.org/resources/lldbgdbremote.html#qgdbserverversion
> [1] https://github.com/pwndbg/pwndbg/issues/2648
> 
> Co-authored-by: Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
> Signed-off-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
> Message-Id: <20250403191340.53343-1-dominik.b.czarnota@gmail.com>
> [AJB: fix include, checkpatch linewrap]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   gdbstub/gdbstub.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 6023c80d25..def0b7e877 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -28,6 +28,7 @@
>   #include "qemu/cutils.h"
>   #include "qemu/module.h"
>   #include "qemu/error-report.h"
> +#include "qemu/target-info.h"
>   #include "trace.h"
>   #include "exec/gdbstub.h"
>   #include "gdbstub/commands.h"
> @@ -1597,6 +1598,18 @@ static void handle_query_threads(GArray *params, void *user_ctx)
>       gdbserver_state.query_cpu = gdb_next_attached_cpu(gdbserver_state.query_cpu);
>   }
>   
> +static void handle_query_gdb_server_version(GArray *params, void *user_ctx)
> +{
> +#if defined(CONFIG_USER_ONLY)
> +    g_string_printf(gdbserver_state.str_buf, "name:qemu-%s;version:%s;",
> +                    target_name(), QEMU_VERSION);
> +#else
> +    g_string_printf(gdbserver_state.str_buf, "name:qemu-system-%s;version:%s;",
> +                    target_name(), QEMU_VERSION);
> +#endif

I sugguest passing "qemu" as the name property.

I guess LLDB developers chose to explicitly have the key-value pair 
syntax so that users can have one unified logic for parsing and avoid 
the mess of HTTP's User-Agent; there is a proposal for Web that 
introduces key-value pairs in a similar manner:
https://developer.chrome.com/docs/privacy-security/user-agent-client-hints

If we embed more information like to the name property, users will need 
to have an additional logic to know if it's QEMU or to know other 
information. Instead, we can emit:
name:qemu;version:10.0.50;

and we can use something like follows if we want to tell more:
name:qemu;version:10.0.50;qemu-mode:system;qemu-target:hexagon;

