Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95658CCD1A1
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 11:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqson-0001Vu-5G; Wed, 18 Sep 2024 07:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sqsog-0001Nv-GL
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 07:25:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sqsoe-0001VU-Eg
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 07:25:50 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42bb7298bdeso71422835e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 04:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726658746; x=1727263546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wL1x/D9kc/0DoSlj/2DjDcFgOEL3PIDCYA8sCBLYQrs=;
 b=dD/K2eympELElLgJzAJn1HK7rr+BQsw4d+dKq0ParsdNLt4wXdikny7mjlvzfre2SH
 EDUkfJ3QIQtY8jAZBLcKEsfLa8rpZkpnb4d6n/BBYHv94nHSg0EsQ0HGUbFCsz6Bfy6n
 BkG4CkMZLHz51wTvWFMWcPLM5WCkur4CEC3qMZQmvAPj/mi4NGmWtYg0smkgQMaZej8K
 8vD1OHHXIsuNQrpn8r9zYaFI6KI3yGENyBipRVtPTBbbmiW22s3pz9xK4DTU1fychD5y
 arDUi8M5mvH714oM4Hm/zohHBKEvkUiZSRMLS6V6cgDVgZ7TChCn0kd0CzSEHjyp0H2u
 AhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726658746; x=1727263546;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wL1x/D9kc/0DoSlj/2DjDcFgOEL3PIDCYA8sCBLYQrs=;
 b=C1KgE7672V3rdGLEuzXnMxteC8096emoQF/xBeM+FNUxayAFA8EAHc+VKGXqxNyOko
 W0xrmDdoC2cZXJHMeOHDRlkDZ/ArI5UIgReiGrOS37HcCjU/6SuWQalEI5XlNL37CmVn
 9/P6p5e1cWk0wdCTW7E16Aq5Yyn7caaFVaKoEWaoYVcMIYpmL3x3xYOy9qoe9zgVOoG6
 OSR8gYm5f2/qheLMeIAl5G+145LFRhS4ba7RLoedUCGsR0QAOtFF/pwEk0++HLu+T7LY
 Z+wZamPEqxxiLCv6nmbW6dKw2+nmvoRy6xWwSbsGRlS3vcjUTBxBJY6qxAS/zb0sTSn/
 kApQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBK/yc9EFFLe/xQppzBRb1zABdatDZszMiOEbki3/xBMABjWoH3rDPWuh4uyi6bL5pCnUUHDDTOg7/@nongnu.org
X-Gm-Message-State: AOJu0YzBvTLlMEVWpilEiWvlDlr/ngn4D3Gj6Hf7KUAePzui2ir8maHv
 zRjBjs/qWrE9MrcciUSFGLLZFUHA7Ta1it7Epedz5WSwZxklO6Wqv093QmcgKhQ=
X-Google-Smtp-Source: AGHT+IE8kS6Bqwjfro5GiSVEMdQujfotyo0dUxw2FR3WZeuWWeRroJzIqihBKVocsu2nYEqJIO9OWg==
X-Received: by 2002:a05:600c:4f92:b0:42c:b508:750e with SMTP id
 5b1f17b1804b1-42d90720d6dmr160569185e9.11.1726658745812; 
 Wed, 18 Sep 2024 04:25:45 -0700 (PDT)
Received: from meli-email.org (adsl-13.37.6.161.tellas.gr. [37.6.161.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7050a34dsm14464005e9.29.2024.09.18.04.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 04:25:45 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:23:50 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com
Subject: Re: [PATCH v2] audio/pw: Report more accurate error when connecting
 to PipeWire fails
User-Agent: meli 0.8.7
References: <3a78811ad5b0e87816b7616ab21d2eeef00b9c52.1726647033.git.mprivozn@redhat.com>
In-Reply-To: <3a78811ad5b0e87816b7616ab21d2eeef00b9c52.1726647033.git.mprivozn@redhat.com>
Message-ID: <k0aew.wb5rgrgw058q@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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

On Wed, 18 Sep 2024 11:17, Michal Privoznik <mprivozn@redhat.com> wrote:
>According to its man page [1], pw_context_connect() sets errno on
>failure:
>
>  Returns a Core on success or NULL with errno set on error.
>
>It may be handy to see errno when figuring out why PipeWire
>failed to connect. That leaves us with just one possible path to
>reach 'fail_error' label which is then moved to that path and
>also its error message is adjusted slightly.
>
>1: https://docs.pipewire.org/group__pw__core.html#ga5994e3a54e4ec718094ca02a1234815b
>
>Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>---
>
>v2 of:
>
>https://mail.gnu.org/archive/html/qemu-devel/2024-09/msg03485.html
>
>diff to v1:
>- Dropped duplicated S-o-b line
>- Fixed typo on error message (s/PipeWite/PipeWire/)
>
> audio/pwaudio.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/audio/pwaudio.c b/audio/pwaudio.c
>index 3b14e04fbb..8e13b58286 100644
>--- a/audio/pwaudio.c
>+++ b/audio/pwaudio.c
>@@ -769,13 +769,15 @@ qpw_audio_init(Audiodev *dev, Error **errp)
>     pw->core = pw_context_connect(pw->context, NULL, 0);
>     if (pw->core == NULL) {
>         pw_thread_loop_unlock(pw->thread_loop);
>-        goto fail_error;
>+        error_setg_errno(errp, errno, "Failed to connect to PipeWire instance");
>+        goto fail;
>     }
> 
>     if (pw_core_add_listener(pw->core, &pw->core_listener,
>                              &core_events, pw) < 0) {
>         pw_thread_loop_unlock(pw->thread_loop);
>-        goto fail_error;
>+        error_setg(errp, "Failed to add PipeWire listener");
>+        goto fail;
>     }
>     if (wait_resync(pw) < 0) {
>         pw_thread_loop_unlock(pw->thread_loop);
>@@ -785,8 +787,6 @@ qpw_audio_init(Audiodev *dev, Error **errp)
> 
>     return g_steal_pointer(&pw);
> 
>-fail_error:
>-    error_setg(errp, "Failed to initialize PW context");
> fail:
>     if (pw->thread_loop) {
>         pw_thread_loop_stop(pw->thread_loop);
>-- 
>2.44.2
>
>


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

