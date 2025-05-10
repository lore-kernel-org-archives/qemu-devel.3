Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F869C3ABBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 04:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDc5j-00053a-Nx; Sat, 10 May 2025 00:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDc5i-00053M-5x
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:45:38 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDc5f-0007OI-Sg
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:45:37 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-74237a74f15so2423116b3a.0
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 21:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746852334; x=1747457134;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QrSMM4TKtkt+LPkj2y0AwU2n7uM1JNftoyOLUf6bXyA=;
 b=WaHbx8qFRJYdJCVLtVz6xG8q/3JsyF1dfpZgczA2F0PCsH3YHSnf/Iog5YVcw7oKJX
 yXazt7AFQEeXJYTo2Dm4GkBoumEAzt/MWUHEyCO0doCxNewrkWxMzVKIqyVA/yrPA3UJ
 LmCmwCSwTvmTX4Pmku2txFSmxH1aZ9mfT0bfFI6RdzwyORBu7QDXVfqoKe57zB6ajuqZ
 Pm3dXTMTeXaGWg4Vv9QVupvJCjsaMKMj2D8GtR5DRrZslcA6hl1TERteephKTSLrPR+f
 Nc0OWGI93vek3iLzmQGS6VeBjWBaUJBVhD8sHnflfH3VUzu6GGl9rz5RP9DfoqX6oVYs
 Au2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746852334; x=1747457134;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QrSMM4TKtkt+LPkj2y0AwU2n7uM1JNftoyOLUf6bXyA=;
 b=Ma87LQ4iP+0/8tSlZ9AbWqb+hYb/GYAHKFGYAjRvWEokT6AYPsYhaRQCxjvnXAprr5
 EGMwRSTLd6MfugDpYd6Ud12N7q7KS5kD9okgQBDMjydMbbSZArSAwIkt0J6zCzipZI5H
 jlq+uB7ymgTG2wgfRA3qZ5iSqDKqZF4gHsfGgfq13w06ZTYg6byLDC5pQ24r+CJ0wqMc
 ctxtS+qe/yyA6De50n7/NMOsVygdnG2j//Ad2eHNfKhMuOPtBov/ZlfVi+f0Det1w3Jh
 vi5TcNQE8klef64phH9Bx1OtoWA7jq5wxGuKR7ur4zlCFqz9yuwUkODc7knIzfcgqI0v
 qRTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUeGpbmomOXkfCqfQqM407CeegrFqO9M9UoJEvQJO4fD/Y4h4NOk4zkTVx0PIVtQ1+HqN4asV2IcWJ@nongnu.org
X-Gm-Message-State: AOJu0Yyqbx+BL0OkcQq/0M5QOAMyl5fA4l1bX7LfvhZ63RCa0fwvw4ch
 f/dvM42FJxT/O5zVf6qHVl1eRQWeph4oa4AsEFpLUubzh4TkObowhJOS/AJcnBg=
X-Gm-Gg: ASbGncsMYJC1nifr4sW/i2m+DQbhRs6kaPCHbRiCM2gLDVQ8Wykzfnny5DuFMQTYryc
 mYUdpOEFl7P3AUddCAa8xiKzhR0srBMureE8KOvq7GCHTQdAiUOjwLvzzy97LcACKkuJKORwy4A
 KijIb3FSbjdJe7lZmG4gLYKmn6j+2Bu5nYrWB3eIS9v2jYG7ENedTVhznCQ+evFEY2TFO+LpaBN
 rRXo6kktUnVFNp3P1eO7gK1Lb0TrxzLPdzqAGMX3RuyY6tJBwTW3ytE4tQWVgOjFuh2ldlh7wkX
 3WdrGH2B7M24lZMl8guiDBxPPPWsSedDcshQxrhcU3G+cuPTWdt3Fe2u080wrQ==
X-Google-Smtp-Source: AGHT+IFrYoQEbzLU5wPGDpCzZFJ2jWLYUP+crdH2QfRE3HaxOyAg9RQnpWXBl9AuJI6MXi1y7pJp5w==
X-Received: by 2002:a05:6300:668a:b0:1f5:7007:9ea5 with SMTP id
 adf61e73a8af0-215ababa3d9mr9801554637.2.1746852334098; 
 Fri, 09 May 2025 21:45:34 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b235198cccdsm2265681a12.64.2025.05.09.21.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 21:45:33 -0700 (PDT)
Message-ID: <f0890b48-9b80-4ae7-892a-c45fd3dee089@daynix.com>
Date: Sat, 10 May 2025 13:45:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] contrib/plugins: allow setting of instructions
 per quantum
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
 <20250506125715.232872-7-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250506125715.232872-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/06 21:57, Alex Bennée wrote:
> The default is we update time every 1/10th of a second or so. However
> for some cases we might want to update time more frequently. Allow
> this to be set via the command line through the ipq argument.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> ---
> v2
>    - checkpatch fixes.
> ---
>   docs/about/emulation.rst |  4 ++++
>   contrib/plugins/ips.c    | 10 +++++++++-
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index a72591ee4d..456d01d5b0 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -811,6 +811,10 @@ This plugin can limit the number of Instructions Per Second that are executed::
>     * - ips=N
>       - Maximum number of instructions per cpu that can be executed in one second.
>         The plugin will sleep when the given number of instructions is reached.
> +  * - ipq=N
> +    - Instructions per quantum. How many instructions before we re-calculate time.
> +      The lower the number the more accurate time will be, but the less efficient the plugin.
> +      Defaults to ips/10
>   
>   Other emulation features
>   ------------------------
> diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
> index 9b166a7d6c..62ed8ddd08 100644
> --- a/contrib/plugins/ips.c
> +++ b/contrib/plugins/ips.c
> @@ -147,6 +147,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                              const qemu_info_t *info, int argc,
>                                              char **argv)
>   {
> +    bool ipq_set = false;
> +
>       for (int i = 0; i < argc; i++) {
>           char *opt = argv[i];
>           g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
> @@ -177,6 +179,9 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                       return -1;
>                   }
>               }
> +        } else if (g_strcmp0(tokens[0], "ipq") == 0) {
> +            max_insn_per_quantum = g_ascii_strtoull(tokens[1], NULL, 10);

It may be nice to have an error check performed for ips.

> +            ipq_set = true;
>           } else {
>               fprintf(stderr, "option parsing failed: %s\n", opt);
>               return -1;
> @@ -184,7 +189,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>       }
>   
>       vcpus = qemu_plugin_scoreboard_new(sizeof(vCPUTime));
> -    max_insn_per_quantum = max_insn_per_second / NUM_TIME_UPDATE_PER_SEC;
> +
> +    if (!ipq_set) {
> +        max_insn_per_quantum = max_insn_per_second / NUM_TIME_UPDATE_PER_SEC;
> +    }
>   
>       if (max_insn_per_quantum == 0) {
>           fprintf(stderr, "minimum of %d instructions per second needed\n",


