Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F44FC9EF5
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 11:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vypyF-0008TD-U2; Sat, 07 Mar 2026 06:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vypyA-0008SP-5N
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:37:18 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vypy7-0007RZ-4l
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:37:16 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48375f10628so66550705e9.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 03:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772883432; x=1773488232; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ph3h9lg7Q2cj9fEXg9hEbgjSF7fjMUHWQscfkdIi7LI=;
 b=gbKd5eJHKtPvmp+HyGTGL61IXr2hODSNw76LyqDhaD6qbQ0WyIZsi2QwBN0XLz/SDo
 e/bMnhbDuNE44JucmLCIGpjzHgaf9lVaDt5QiVhque3fEFr6HfpmR3CQeQ3xdAtt26L6
 p53dUqwdGDq9bf0LsSRw69cSnTlfLOe+f/pZglnlbscBiwAUiNT0IDrQCmDwrpMIko2f
 4K1TDO+kFFHM1qRqJ1nb1L0A2WOfWCfFJ92JohSleg7aeLqhSw0erg+rwXSF370n3tsj
 oMrZwJkRUFuCmP0u4dFqU0tl0M0eFat3Tym5t5SLV3WpZP62v4pfwhK7D+vsHVdGoESO
 Xlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772883432; x=1773488232;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ph3h9lg7Q2cj9fEXg9hEbgjSF7fjMUHWQscfkdIi7LI=;
 b=esGhezRgTBy8jdMzH9iJr0rH/JJqDOBzFubDvVYqL0dIq5yL/DobLe/nCx93gIhW/y
 jI/U+PRt3X4GpcXTHHjxqtz8HivqitePmQkShHk7KMifTD5P/mf4A4NBtFPxCyp7g5aY
 p7p5BdJzj3zIzewn8Sz1NF+KSRJED4yJM+0WPsXy/RlNoMryegNTFXN5mMwBeFOhpBr2
 fD5VGr1trDk2wmn69JI0v1MXrK/IpPImjwjWDduNpewFzme3uNMO+8KCw2zAhje6ZihN
 lkOEH0IP2ynUmL5GjWtWQIINIixoByxqIIBZeXNuVbUOZI8QFjVmUFP7tZAUIeZQb91d
 ckGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmU3mK9nJPplg4flrUL5676ZsgSS7CXDqZ6oJhNNWYvX+ZEGMSVYjTazeCdJh3XThW3LttDUXZACwH@nongnu.org
X-Gm-Message-State: AOJu0Yxb4damjw+A15+jo3s6VR9rUdhIHkvEPgcxqRpUZPQTyTIR9UYT
 reZKpTkcxvOVWBn+pmlTKe/S/gfHI/WgXAw3p6cENogJ+QTW4QOIzD8OMTMk3vWzSvc=
X-Gm-Gg: ATEYQzyP91bRLamuU0QEcUoF7P7r1/bL3cfPPYGQJQaKLLMYQcA94YKhhDlOMJKn3Vj
 H61ZUBHWjz1PJwLCca89g1Sq44rvGHka9/8NxtqcOAGm7Ifgvje71xGWvOYTvu1UStCRpKEZ8Vh
 ud8MFtJQDePWqbOnGEjtoKlhdyUK2MDpS4P5Ep2IJrqOROUF3FClWDpQpE7urIkNJ5Rt7vlWbtb
 eJE3AkuiZbfT3TkON05QTade8sLc6mS4NCMI4W27vXKYT5Ih1ps9jqb9thMrvOI/Hk8YEwQUaYe
 VXhLz3cMN0Ywa3xLTtzarDyRh4cH29pRA38ageNsrez/rbxHK6yTb5e/gouqc05bn2YHSNGw0P4
 DY3qd12Gj0kdIzbjuEhUiX60xXqmN2GawTv0d1R9xePsMIyFGFJmgy3J+ALSoE2D/Ei6gOaxIRv
 qeBBOjqf+r5J/1gqI4vAvb8s2ndBjvbOalM4nS2OGqa3Xd/I3OU4MkpDmLq6Fhr6ixgg5k6EdGu
 D1m
X-Received: by 2002:a05:600c:3b0c:b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-48526979668mr86001445e9.24.1772883431862; 
 Sat, 07 Mar 2026 03:37:11 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fb3666asm163949625e9.14.2026.03.07.03.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2026 03:37:11 -0800 (PST)
Message-ID: <5b57e5c8-8efd-42ae-a965-5b6e1c6af2ca@linaro.org>
Date: Sat, 7 Mar 2026 12:37:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/27] audio: make jackaudio use qemu_thread_set_name
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 qemu-rust@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
References: <20260305174743.3084606-1-berrange@redhat.com>
 <20260305174743.3084606-13-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260305174743.3084606-13-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Hi,

On 5/3/26 18:47, Daniel P. Berrangé wrote:
> This has greater portability than directly call pthread_setname_np,
> which is only 1 out of 3 possible functions for pthreads that can
> set the name.
> 
> The new API requires a trampoline function, since it can only set
> the name of the current thread.
> 
> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   audio/jackaudio.c | 28 +++++++++++++++++++++++-----
>   1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index f49fd82c45..be6fb378f7 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -633,18 +633,36 @@ static void qjack_enable_in(HWVoiceIn *hw, bool enable)
>       ji->c.enabled = enable;
>   }
>   
> -#if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
> +#if !defined(WIN32)

I'm getting on macOS:

../../audio/jackaudio.c:654:12: error: unused function 
'qjack_thread_creator' [-Werror,-Wunused-function]
   654 | static int qjack_thread_creator(jack_native_thread_t *thread,
       |            ^~~~~~~~~~~~~~~~~~~~

No clue why this isn't covered on CI. My local build:

   Audio backends
     CoreAudio support               : YES
     PipeWire support                : NO
     JACK support                    : YES 1.9.22

> +struct QJackThreadData {
> +    void *(*function)(void *);
> +    void *arg;
> +};
> +
> +static void *qjack_thread_trampoline(void *targ)
> +{
> +    struct QJackThreadData *data = targ;
> +    void *(*function)(void *) = data->function;
> +    void *arg = data->arg;
> +
> +    g_free(data);
> +    qemu_thread_set_name("jack-client");
> +
> +    return function(arg);
> +}
> +
>   static int qjack_thread_creator(jack_native_thread_t *thread,
>       const pthread_attr_t *attr, void *(*function)(void *), void *arg)
>   {
> -    int ret = pthread_create(thread, attr, function, arg);
> +    struct QJackThreadData *data = g_new0(struct QJackThreadData, 1);
> +    data->function = function;
> +    data->arg = arg;
> +    int ret = pthread_create(thread, attr, qjack_thread_trampoline, data);
>       if (ret != 0) {
> +        g_free(data);
>           return ret;
>       }
>   
> -    /* set the name of the thread */
> -    pthread_setname_np(*thread, "jack-client");
> -
>       return ret;
>   }
>   #endif

Fixed adding:

-- >8 --
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index be6fb378f72..589aecede9a 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -712,7 +712,7 @@ static const TypeInfo audio_types[] = {
  static void __attribute__((__constructor__)) audio_jack_init(void)
  {
      qemu_mutex_init(&qjack_shutdown_lock);
-#if !defined(WIN32) && defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
+#if !defined(WIN32)
      jack_set_thread_creator(qjack_thread_creator);
  #endif
      jack_set_error_function(qjack_error);
---

