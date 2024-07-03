Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBE2C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvbQ-0005Q9-2E; Wed, 03 Jul 2024 04:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvbN-0005Pl-I5
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:44:33 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvbL-0004Ar-Io
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:44:33 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42562fde108so36640315e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719996269; x=1720601069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1xL9KQDK5cwGimZTLwypmQ7wxHSyQYzBd2b2HcSXn10=;
 b=o+uMG7PrXEkzgG0qsJ7DfVfiSJDn8fBkX14lSjOn5hOlBLDSCmvIxCz4+tWMInDytn
 KJZxgbq0bKcaBh9inOmmfyNt7S3b/IIcvsP8z0zSeoBaQEfkxg6LAorSZ6Ir3EUhw6x0
 9zGb9elhf7C6LeZZJk5sp6IEZSOg3FkRC7L8Aprn6PaOvzphnNfVoWinLWerpOEqFytD
 Kue4ZsY3PQZtqU1kmj18t3G/ZPo4kI/cb+BKrrXjaj6KA36xbqmRdkc6SZL0xSkx18cQ
 gWcaPpYkAaMlAAuadtp0ZAmUdJ0KhzYoY2XPECekWRHc4cKritIfQ6Xx/Qa+RjaatBcV
 Af8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719996269; x=1720601069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1xL9KQDK5cwGimZTLwypmQ7wxHSyQYzBd2b2HcSXn10=;
 b=MiNUH8CUs1RswQKAw+PC/+gNvUSjBC8FynagFa/67tpO2LrQYihHPBImojDbGuJqK0
 FWiw/ivXwlmfT4ugQ+uPScRvphEV6IEAugm+G9vlH44JG5f5g4tetVCPoUjxPG9wfdU/
 NO+zMhbSzXUbZ6AC6mg/kwWiFWJuW7gOhGGzyKiMXOGQXkmj2AqYeeLmH8I3MSq0gXpF
 GBok9kzAzKqmnZyRDugIla0xFC5TTIP4ZZtimHH99TArZFTfyfmHFzHNhRhOaSTxuqjg
 b4mhpz2nmMMbi+hD2YOqsL1yw1xqQrP2ogEho+HLUVjH9rKzDmj9nXWI1AvwXabsGzOE
 aUbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlw2B6nCwzvSiDfYDtYAaRiC/eET6Jdv+CeTo+Ts9izG/E0mCX3rqWrM7+dctkKethMewl1uO7dya9ojGL2dwwKaOzRIk=
X-Gm-Message-State: AOJu0YyT4fOlI4VSAB7EQturvkZ8vPRYMCooPF7xugi+wmXlkJWEP2jn
 liQdP2tnnd3Rv+GTqDEn8IdBzQKmc/8jYREgqh+vfcYCcaJIJIttoAz94HcRcmQ=
X-Google-Smtp-Source: AGHT+IE9SCFaP+0i/nt+MVTTxoOGNUuxVsGojYaT+yeBglZuEgnN4V6RKEYhWX1HxxjZLj0LQzCNHw==
X-Received: by 2002:a05:600c:3388:b0:424:a587:51d3 with SMTP id
 5b1f17b1804b1-4257a02f6f2mr72962225e9.13.1719996269292; 
 Wed, 03 Jul 2024 01:44:29 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0cee27sm229875145e9.48.2024.07.03.01.44.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:44:28 -0700 (PDT)
Message-ID: <b3b1e802-d0f9-4fa0-9d7c-39f62d3ee5b9@linaro.org>
Date: Wed, 3 Jul 2024 10:44:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/22] qga: allow configuration file path via the cli
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-16-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613154406.1365469-16-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 13/6/24 17:44, Daniel P. Berrangé wrote:
> Allowing the user to set the QGA_CONF environment variable to change
> the default configuration file path is very unusual practice, made
> more obscure since this ability is not documented.
> 
> This introduces the more normal '-c PATH'  / '--config=PATH' command
> line argument approach. This requires that we parse the comamnd line
> twice, since we want the command line arguments to take priority over
> the configuration file settings in general.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   docs/interop/qemu-ga.rst |  5 +++++
>   qga/main.c               | 35 +++++++++++++++++++++++++++--------
>   2 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
> index 72fb75a6f5..e42b370319 100644
> --- a/docs/interop/qemu-ga.rst
> +++ b/docs/interop/qemu-ga.rst
> @@ -33,6 +33,11 @@ Options
>   
>   .. program:: qemu-ga
>   
> +.. option:: -c, --config=PATH
> +
> +  Configuration file path (the default is |CONFDIR|\ ``/qemu-ga.conf``,
> +  unless overriden by the QGA_CONF environment variable)
> +
>   .. option:: -m, --method=METHOD
>   
>     Transport method: one of ``unix-listen``, ``virtio-serial``, or
> diff --git a/qga/main.c b/qga/main.c
> index 6ff022a85d..f68a32bf7b 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -1018,15 +1018,14 @@ static GList *split_list(const gchar *str, const gchar *delim)
>       return list;
>   }
>   
> -static void config_load(GAConfig *config)
> +static void config_load(GAConfig *config, const char *confpath, bool required)
>   {
>       GError *gerr = NULL;
>       GKeyFile *keyfile;
> -    g_autofree char *conf = g_strdup(g_getenv("QGA_CONF")) ?: get_relocated_path(QGA_CONF_DEFAULT);
>   
>       /* read system config */
>       keyfile = g_key_file_new();
> -    if (!g_key_file_load_from_file(keyfile, conf, 0, &gerr)) {
> +    if (!g_key_file_load_from_file(keyfile, confpath, 0, &gerr)) {
>           goto end;
>       }
>       if (g_key_file_has_key(keyfile, "general", "daemon", NULL)) {
> @@ -1092,10 +1091,10 @@ static void config_load(GAConfig *config)
>   
>   end:
>       g_key_file_free(keyfile);
> -    if (gerr &&
> -        !(gerr->domain == G_FILE_ERROR && gerr->code == G_FILE_ERROR_NOENT)) {
> +    if (gerr && (required ||
> +                 !(gerr->domain == G_FILE_ERROR && gerr->code == G_FILE_ERROR_NOENT))) {
>           g_critical("error loading configuration from path: %s, %s",
> -                   conf, gerr->message);
> +                   confpath, gerr->message);
>           exit(EXIT_FAILURE);
>       }
>       g_clear_error(&gerr);
> @@ -1167,12 +1166,13 @@ static void config_dump(GAConfig *config)
>   
>   static void config_parse(GAConfig *config, int argc, char **argv)
>   {
> -    const char *sopt = "hVvdm:p:l:f:F::b:a:s:t:Dr";
> +    const char *sopt = "hVvdc:m:p:l:f:F::b:a:s:t:Dr";
>       int opt_ind = 0, ch;
>       bool block_rpcs = false, allow_rpcs = false;
>       const struct option lopt[] = {
>           { "help", 0, NULL, 'h' },
>           { "version", 0, NULL, 'V' },
> +        { "config", 1, NULL, 'c' },
>           { "dump-conf", 0, NULL, 'D' },
>           { "logfile", 1, NULL, 'l' },
>           { "pidfile", 1, NULL, 'f' },
> @@ -1192,6 +1192,26 @@ static void config_parse(GAConfig *config, int argc, char **argv)
>           { "retry-path", 0, NULL, 'r' },
>           { NULL, 0, NULL, 0 }
>       };
> +    g_autofree char *confpath = g_strdup(g_getenv("QGA_CONF")) ?:
> +        get_relocated_path(QGA_CONF_DEFAULT);
> +    bool confrequired = false;
> +
> +    while ((ch = getopt_long(argc, argv, sopt, lopt, NULL)) != -1) {
> +        switch (ch) {
> +        case 'c':
> +            g_free(confpath);
> +            confpath = g_strdup(optarg);
> +            confrequired = true;
> +            break;
> +        default:
> +            break;
> +        }
> +    }
> +
> +    config_load(config, confpath, confrequired);
> +
> +    /* Reset for second pass */
> +    optind = 1;
>   
>       while ((ch = getopt_long(argc, argv, sopt, lopt, &opt_ind)) != -1) {
>           switch (ch) {
> @@ -1582,7 +1602,6 @@ int main(int argc, char **argv)
>       qga_qmp_init_marshal(&ga_commands);
>   
>       init_dfl_pathnames();
> -    config_load(config);
>       config_parse(config, argc, argv);
>   
>       if (config->pid_filepath == NULL) {

This looks like a trivial (correct) CLI change, but
I don't feel confident anymore reviewing this area,
so will let others have a look.

Regards,

Phil.

