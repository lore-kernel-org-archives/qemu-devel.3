Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AE0EE20A5
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 13:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voMCZ-0000gm-91; Fri, 06 Feb 2026 08:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voMCS-0000fr-Q3
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:48:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voMCQ-0003YR-Cm
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770385718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ucQCEQy+03vqCXCyK6/PvmZgemMRXhaPs96Hqa7QhBk=;
 b=fvAQWNEwZaTMB5bGbVT6DoYQP/IqqqPTqHrr0rQKDfgTtshPFFEdL22xQeI5nTOLW6kd5N
 Q9y1QvR263sEeKXIVW3gs4+jiu8H7EqmYdj35xnUwb0RQrAEGh02+vbtdyfu//yLzXMW61
 kNCq+fvKstilrI3f3jGRneqhOECb5Zc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-EylXikfDPEmd_mE5ykbZQA-1; Fri, 06 Feb 2026 08:48:37 -0500
X-MC-Unique: EylXikfDPEmd_mE5ykbZQA-1
X-Mimecast-MFC-AGG-ID: EylXikfDPEmd_mE5ykbZQA_1770385716
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47edf8ba319so35775075e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 05:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770385716; x=1770990516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ucQCEQy+03vqCXCyK6/PvmZgemMRXhaPs96Hqa7QhBk=;
 b=U7Ams8STaYtD/B6bgDdfrZc69pOtWhXQnq7R9iNh5PQE2fz3o0fB3XImcKt3rEI8z5
 4Ps3+Spt+uVf7m2+To1ytO7RVo05RaSHtS3NptTIku2SQk4MLgYrcC8kWlv9ERWzMPSk
 IuBr3gzfDWZoY33KEi5KhEAe7QnEUbALoA4yMYeMQDk/anfi70KJd2A5RQzCckFBPhGd
 Xkf2FU9asrNFTv5a3pV9D9SCU+Q7tLGZhEr1FmYlz6diWvfUa++iYDwC5sj8eUoeAjyy
 oaGck44rtkRJ1iVfjuN89hRazomSMR7Lkj9tFc+zKvOZxsCJ6jHrdGELVZhx6YRa8AXr
 gazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770385716; x=1770990516;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ucQCEQy+03vqCXCyK6/PvmZgemMRXhaPs96Hqa7QhBk=;
 b=INtzj5a7dbHynuBc6xd0ZtWRe/XYaIVTihF/v6mkNO6VN6O5iyYxAh92bGseTA8nFE
 KqwIDFeuGSD6Zxi7WUxRNHWV76YlfHlf6WdB8rbCioxsa6QMAfmbrZhGg6c5HAFNsxDM
 li+tHXyVUUQ0R4UrYbxceft2mlZCY+w6ARoR2f8QznX8Vay93DNuC6vdV8j9MbfvGLja
 Rap5siyMynOBYwl8+pepjmfD0bgOXOKpBFjdv7vi3fE6b68fPFsTsUrfCz0Zc4wJYvIR
 EaiU7GIk23lV0YILSJsQNZOB+kz4vG6ajiJ+6gvf1PnXg/knRi0uAybj9CbANnxysoNk
 XbHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd3tSeAsFCAmcd+NmgXwXlg/AmrP/8uLexnfzkO+M8T9DUSInWh0a+19P4JRKwdcIeWh9BbeSMzMDG@nongnu.org
X-Gm-Message-State: AOJu0Yy9st0lUAeCMKWD8fxcpIYMJnTuJIlg8hUf/0vq5d3jxNHwZTpv
 rIgU98owFsdKhkCkGpBL3+z49cvCOnoxKyGNRuU1WkwuL2f5QadTwE8aKpbd9aIPlDort51DwTJ
 x9X72nFAlEWP2ZuVoEKURZ66rpSkax0s+BkKYia1lSqhwGht2Lb0yMeGi
X-Gm-Gg: AZuq6aKdlcsAFq18zYEfw/omlqFxYZ08DvQ4IumxHJnwIW7uYFeTevEq8dMYnK2XQxa
 oHM5gqpjls6HRHtTFqhWK125+4tRnwAFVL62JZiK/tbMSg/EZ8BjMT2gzJS0WVl7epdzkltd4/r
 tdTNUvjiVZPAWXFqzkhZ/mbY5z+cTRYDH4SJvW4m1AXHaEkyZO+AVoOs1mFFWJcgBWELCmjcPPh
 hkZr9mbMzgA1kmRZaFp9RPzugTGDKiHO0KZ10iMtRBh55StAT6yiOxeAyxj+6Lxj2vPE/FEDTaw
 iZStG/OpwggQLQXN6Qa7K8GydU83aLTKUOoNTcuOZ0VLuS7lqL5Ziznpcn3lNq1ThWtdtDld/oF
 dtMcrFUE=
X-Received: by 2002:a05:600c:6289:b0:47d:18b0:bb9a with SMTP id
 5b1f17b1804b1-483203393b7mr46870485e9.33.1770385716057; 
 Fri, 06 Feb 2026 05:48:36 -0800 (PST)
X-Received: by 2002:a05:600c:6289:b0:47d:18b0:bb9a with SMTP id
 5b1f17b1804b1-483203393b7mr46870125e9.33.1770385715629; 
 Fri, 06 Feb 2026 05:48:35 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bcdfcsm6217969f8f.10.2026.02.06.05.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 05:48:35 -0800 (PST)
Message-ID: <5ca70c9c-8cfe-4733-9f85-20adb3a4446f@redhat.com>
Date: Fri, 6 Feb 2026 14:48:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tests/docker: allow display of docker output
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260107130145.1495219-1-berrange@redhat.com>
 <20260107130145.1495219-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260107130145.1495219-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 07/01/2026 14.01, Daniel P. Berrangé wrote:
> The --quiet command is used with docker unless V=1 is passed to make,
> and as a result stdout from docker is never visible by default, making
> it hard to diagnose failures building / running containers.
> 
> Meanwhile passing V=1 is undesirable as that makes the entire build
> system verbose.
> 
> Introduce a $(DOCKER_V) make variable which is initialized from $(V)
> 
> It is thus possible to display docker output without also enabling
> make verbose output.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/docker/Makefile.include | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 7d4582b6a8..d58a280333 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -40,14 +40,14 @@ docker-qemu-src: $(DOCKER_SRC_COPY)
>   docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>   	  $(call quiet-command,			\
>   		DOCKER_BUILDKIT=1 $(RUNC) build		\
> -		$(if $V,,--quiet)			\
> +		$(if $(DOCKER_V),,--quiet)		\

Hmm, do we maybe want a

DOCKER_V ?= $(V)

earlier in this file, so that DOCKER_V gets enabled when running in normal 
verbose mode, too?

  Thomas


