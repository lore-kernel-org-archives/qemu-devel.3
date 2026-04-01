Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFB8D3516F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7sTi-0006Pd-C7; Wed, 01 Apr 2026 06:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sTg-0006PV-BO
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:07:12 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sTd-0002cD-MG
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:07:11 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43cfce3a195so2018692f8f.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 03:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775038027; x=1775642827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iiixGl+tdbHJDaOxGGSWI6B4QRc4ryUA5JlTRv2uWdM=;
 b=KZkLOeFq5RW3qzv8Qa0RYPqN9swlFqgRRT9pJDf68V0XZTnR+a/vuCTgncckSvF/eS
 A0y3DZANms5dSgOIeydo1l2TeBWVPUHjJwUx5b6Ghi8U6gx0M6dzPzlFtlltMMWWFnWV
 U7l1pNZSTSsDaNlVpyze+7gVD5cGsNU2rWI2mgyVm3Me6/VCVfyjBIQVaLMuk/iPo3Cx
 U8/GnxnVW41QIGyZy7lNFZFeE2X3dSj2iZlNTcWSbZ6mxdoGYraH2OR1AZvvSNmTM+/x
 86Ap6xvW6agbsZwEH7zaMeV1w6PitJfZK4Spv1p5hy7HOcULYOtWAMeAWcf+V51Ozp+O
 yLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775038027; x=1775642827;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iiixGl+tdbHJDaOxGGSWI6B4QRc4ryUA5JlTRv2uWdM=;
 b=BFJITBrXeC+8vjkDBJYY8XAsn379ZOwdx7ofvZmlGmwPpngbrGk1QI5/hEaoa4sQO8
 XR8kk3EizK4Rx+aHz49d7Aja0ASE6QYDIGo4+ewLXUQgtVz6OizaBd7+FUasDqH/3KJC
 24EZ7iSbWLxQ64rFUXvY5sVsNKZVkt2ARaIQE7+9++42kJkZTAm6eGjaRyaZTHm5hiPL
 M64258we7kOtXPnAkDG/a3fYCqtk3JwbOEhYRh4SvXDFVdaS5PhBg6PF4AWAuboyoeBE
 lMuS81pAGCQNGz6+zgj+hrRcJCfPIu65lNCKqcbI+y8M+TBqfSGpgsOnAriXZsu6RZZ0
 Fk1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUsCk6jubp8eSNw2ouhA1cNsyKPPJhczgVK+qCEJLmcjmtLSA0X0ZpBE1yP1TVHSrLjDqt2KVXoKKs@nongnu.org
X-Gm-Message-State: AOJu0Yyz1Cb3uOijjzX/mL8S1OwrSSe9N09bgJkpLN3c7lnDEgdTAM0y
 trxRZodAXPxUUiS9pWTIecddzBZKgRDMqI4hveffjg0t+hJXwPszUOpt4P3TKdCEM3Y=
X-Gm-Gg: ATEYQzxfXMD8s2Z0iZ8V5DKhYz5cEdeP8fifeDw57jCMFcZpzCzn3Narrihi5XTRZZA
 gQgOQeFuK8SDNYW5HFEy9lyM8NCmBlVGw8zUVdB7IOTaNHw4RNp9ADZcIjJgWf9OAOGhfiWh7vA
 E0QpEFWiSqUMokiTw8zfYYR+lS/ntMWPLk5oyL75IyNd4RX7b04YgTugK9miZqji75PgBU9YYln
 MJAjAbEovDT9xLOr/IziYTbreE8Az3W5pogtjrGZ7PJneS568N9JiT1+SReYWg7I+FmUrlml9M+
 GPRfE4t0Q3OSs54DJEc/1u0bj2Rz8WRDfeBxJCNfQMe5QSp5RpkdfyyAqVr/4EC7S/fmNxhAxjT
 YGFYRVZS6I4A0puYixSBW29fhJeINMl2ea2q9ztkm20lU+mzvMuRU+SgJGcFqzYGgfNEt8qosoE
 EgTI4FANhd+weukhoIjOhtQlgMgfFuklcuOEhYNIf9C10RBw3lvAW8kJG6VdYp8SUyoA==
X-Received: by 2002:a05:6000:15e0:b0:43d:1c75:db70 with SMTP id
 ffacd0b85a97d-43d1c75dc44mr323751f8f.15.1775038026471; 
 Wed, 01 Apr 2026 03:07:06 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21e26basm32164951f8f.3.2026.04.01.03.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 03:07:05 -0700 (PDT)
Message-ID: <406a855e-5058-4206-b693-d1b74c11a395@linaro.org>
Date: Wed, 1 Apr 2026 12:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/11] ui/vnc: disable audio feature when configured
 with --disable-audio
Content-Language: en-US
To: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260315201646.96862-1-heifetz@yandex-team.com>
 <20260315201646.96862-3-heifetz@yandex-team.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260315201646.96862-3-heifetz@yandex-team.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 15/3/26 21:16, Sergei Heifetz wrote:
> Disable the audio feature in VNC when QEMU is configured with
> `--disable-audio`. Do not compile the corresponding audio-related
> code.
> 
> The audio feature is disabled in a way that makes a QEMU server behave
> like a non-QEMU server (as far as audio is concerned). The client sends
> the audio pseudo-encoding, but the server does not respond with
> confirmation, because send_ext_audio_ack is now behind an #ifdef.
> A well-behaved client should handle this accordingly and continue
> using VNC without sending any audio-related messages to the server.
> If a client misbehaves and sends VNC_MSG_CLIENT_QEMU_AUDIO while
> the audio feature is disabled, the server will close the connection with
> an error.
> 
> The behaviour described above is already present when there is no audiodev
> (`vs->vd->audio_be` is NULL).
> 
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> ---
>   qemu-options.hx |  3 +++
>   ui/vnc.c        | 27 +++++++++++++++++++++++++++
>   2 files changed, 30 insertions(+)


> @@ -2197,10 +2205,15 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
>               send_ext_key_event_ack(vs);
>               break;
>           case VNC_ENCODING_AUDIO:
> +#ifdef CONFIG_AUDIO
>               if (vs->vd->audio_be) {
>                   vnc_set_feature(vs, VNC_FEATURE_AUDIO);
>                   send_ext_audio_ack(vs);
>               }
> +#else
> +            VNC_DEBUG("Audio encoding received with audio subsystem "
> +                      "disabled\n");
> +#endif
>               break;

IIRC the way the project choose to compartmentalize subsystem is
to use stubs instead of cluttering the source with #ifdef'ry, so
I'd expect this effort to be extracting the audio code. For example
here declare vnc_audio_set_encodings() in "ui/vnc.h" ...:

   void vnc_audio_set_encodings(VncState *vs,
                                int32_t *encodings, size_t n_encodings);

... move the current definition to ui/vnc-audio.c ...:

   void vnc_audio_set_encodings(VncState *vs,
                                int32_t *encodings, size_t n_encodings)
   {
       if (!vs->vd->audio_be) {
           return;
       }
       vnc_set_feature(vs, VNC_FEATURE_AUDIO);
       send_ext_audio_ack(vs);
   }

... and the stub in ui/vnc-audio-stub.c:

   void vnc_audio_set_encodings(VncState *vs,
                                int32_t *encodings, size_t n_encodings)
   {
       VNC_DEBUG("Audio encoding received with audio subsystem "
                 "disabled\n");
   }

(Although VNC_DEBUG calls fprintf so better would be to convert to
  error_report in a preliminary cleanup patch).

and the ui/meson.build change becomes:

   vnc_ss.add(when: 'CONFIG_AUDIO', if_true: files('vnc-audio.c'))
   stub_ss.add(files('vnc-audio-stub.c'))

Does it make sense?

Regards,

Phil.

