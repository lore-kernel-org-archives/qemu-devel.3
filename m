Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C976C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 23:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzOtR-00077a-CF; Mon, 31 Mar 2025 19:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzOtO-00076a-Av
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:50:12 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzOtI-000303-8B
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:50:07 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-227c7e57da2so74067035ad.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 16:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743465002; x=1744069802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vWm676soR1drDIdMisfluauKEAk3s8/iAtd5VQlMFA4=;
 b=dZBq+Gbk1GeFYeqRtYWrwx7Ehb+j/Ri/1I20hjw1N4s4jb8NVImPu6TQHe5k6avHcd
 +bLbBMDFb91b9xaWyOYKPkFtym5DNS0mbdWGIwaejTGkfJvJZWkCwtvnzeA3+wgts8to
 a/wCTW4sHRO5EdSISfNuCGEwwoaleg7IyBFcGD1o1nwQvJ5DCX0PDC3PIdr9Q8Yx3m+K
 rM1yF1sPf6ef0FjOg3W+9uYAEFixPQwpk+Suo8ts+Iih5tQ9DGA8m13N5B+Hfk+rOnGM
 C0JuwEs06eaObG4J3BoE64wbmWYxQq9rBmOGZe4JaHzac2/AfMoYalBqfwSsINORp2Hd
 JUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743465002; x=1744069802;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vWm676soR1drDIdMisfluauKEAk3s8/iAtd5VQlMFA4=;
 b=BIoan/mCec8H+T1z4HVd7YJBsq/qUgIJigeQOEeNyg4PHXU4C0FVS8N9GpNEuj9fqT
 Y0wu0wYWBgMEnKc2TcbN/OJLKDdaVQXA4H/LMdBcGViP04hjVSdrMjBfdub6dIYV4RP6
 ocdr/YeDRmKxAq6/KaSS8g7HkYpQhd8jxbVO1EkwepnMU1XOFRycR9TNzHB+jMLLdLRm
 eUq1Ux8xyv/3YwU0g4q0NuzVkuX5G9Wx+va7a8aL8lPSA11sl5JCJ2vcMWQKbPdK3DLp
 LQoAqvBLnK5aqCOgQ1k4L8gQOgp1EwCzgkxv9UJHJrbYxT/2gUxZ6pcdUdAv46lM/egj
 NP8A==
X-Gm-Message-State: AOJu0YyBD7kjaCtsYuQzZPf2Gp0FuZbvBlMFcx/QMpQqH5eiyWnZBLYr
 gbkOyHvs4OBcq0IqSuQLh8qL/og7NSCfD0Hrqq7YP+FJ4jRtC4UYiKPx7tVWDJ+PPCaUTV80jsL
 I
X-Gm-Gg: ASbGncs315MasD30lI609D64z+IvqFSmAVhiBgfsKkAQfUvTTsjXY/VOHGz3nmyqAeP
 DpIcbswK/CBIHLl2JPaTdDYbRNtblMIPoMjFO/l/lhFURSjBbqRbIZWPoA8fNIFYQJrE+uFLz9m
 9s/KRPQc8jSSlehVFCrwIBNpeJOV/DcbUtt2wV2E7qk9ZIQMkL8pd+ML6Pt7nPPf20Dc/WISQ0A
 hNgfDLCBk6Rn+Qz9IENJBNfQ885W54AWT+4zsfNt5AgrltpbujcXoCpLJqvXyLGkmJLGBVJEay6
 /T9HyV0vin/OVe+UoHJY1WU6/eiKCqaYHEJi6hwhCgtmDmIo7fvIUTof5g==
X-Google-Smtp-Source: AGHT+IGttM7gazM0hGkca+Urwuo0q8Gn1ugGc3sNfVf3gHdKo4mb00lMM4IkeoArShJ0++cSEhlZ9Q==
X-Received: by 2002:a17:903:1c7:b0:21f:4b01:b978 with SMTP id
 d9443c01a7336-2292f9e8394mr156109445ad.36.1743465002012; 
 Mon, 31 Mar 2025 16:50:02 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1ecbc9sm75668785ad.215.2025.03.31.16.50.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 16:50:01 -0700 (PDT)
Message-ID: <eda8b528-78c1-4664-9d12-f3a74e190947@linaro.org>
Date: Mon, 31 Mar 2025 16:50:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bsd-user: add option to enable plugins
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, richard.henderson@linaro.org,
 alex.bennee@linaro.org, Kyle Evans <kevans@freebsd.org>
References: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/31/25 16:42, Pierrick Bouvier wrote:
> Nothing prevent plugins to be enabled on this platform for user
> binaries, only the option in the driver is missing.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   bsd-user/main.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index fdb160bed0f..329bd1acc02 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -175,6 +175,9 @@ static void usage(void)
>              "-strace           log system calls\n"
>              "-trace            [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
>              "                  specify tracing options\n"
> +#ifdef CONFIG_PLUGIN
> +           "-plugin           [file=]<file>[,<argname>=<argvalue>]\n"
> +#endif
>              "\n"
>              "Environment variables:\n"
>              "QEMU_STRACE       Print system calls and arguments similar to the\n"
> @@ -225,6 +228,8 @@ static void init_task_state(TaskState *ts)
>       };
>   }
>   
> +static QemuPluginList plugins = QTAILQ_HEAD_INITIALIZER(plugins);
> +
>   void gemu_log(const char *fmt, ...)
>   {
>       va_list ap;
> @@ -307,6 +312,7 @@ int main(int argc, char **argv)
>       cpu_model = NULL;
>   
>       qemu_add_opts(&qemu_trace_opts);
> +    qemu_plugin_add_opts();
>   
>       optind = 1;
>       for (;;) {
> @@ -399,6 +405,11 @@ int main(int argc, char **argv)
>               do_strace = 1;
>           } else if (!strcmp(r, "trace")) {
>               trace_opt_parse(optarg);
> +#ifdef CONFIG_PLUGIN
> +        } else if (!strcmp(r, "plugin")) {
> +            r = argv[optind++];
> +            qemu_plugin_opt_parse(r, &plugins);
> +#endif
>           } else if (!strcmp(r, "0")) {
>               argv0 = argv[optind++];
>           } else {
> @@ -433,6 +444,7 @@ int main(int argc, char **argv)
>           exit(1);
>       }
>       trace_init_file();
> +    qemu_plugin_load_list(&plugins, &error_fatal);
>   
>       /* Zero out regs */
>       memset(regs, 0, sizeof(struct target_pt_regs));

For BSD folks,

if you're not familiar with plugins, you can try this command:
$ ./configure && ninja -C build
# plugins are built by default
$ ./build/qemu-x86_64 \
  -plugin ./build/contrib/plugins/libstoptrigger,icount=1000000 \
  -plugin ./build/tests/tcg/plugins/libinsn \
  -d plugin \
  ./build/qemu-system-x86_64 --version

Output should be something similar to:
icount reached at 0x7f2933a6a3f8, exiting
cpu 0 insns: 1000001
total insns: 1000001

It stopped after executing 1000001 instructions (libstoptrigger), and 
report how many instructions (libinsn) were executed.

Regards,
Pierrick

