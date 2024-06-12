Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD1DC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 23:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHWxp-0004fv-81; Wed, 12 Jun 2024 19:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sHWxn-0004f3-Sz
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 19:01:07 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sHWxj-0002Hy-21
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 19:01:07 -0400
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7eb12b2bf78so13821039f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 16:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718233261; x=1718838061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PkHN5ZHaGSGPBr+6ovQnLLgpRVbBLYqPBu2sokkC6DM=;
 b=V+M0vawtbkB29mFbBmMdmInN3qFO/UrJaacCb4HOGVN9N34KX4OOxRSGvGpSfdGmzu
 EJwC3RZNbhL0kASFr26oLwReAUCwPh7nMG1Hm9wPt3thY7VUWlszMdDFJ0KOoavjJ0Kj
 Ig4Un9TZ5i+gwSjFmDWvZNbo5hQ6c9a1u92f4MVkIrJQDD23S8JCvXK/xW6PC1SZkz0V
 6bYT8kUPp/IhXbc7nGK2Z5ua9BLLbqoaVFczXokOuTyty8vraQlSv4cPE+8No2vB8cJ+
 PVe7gfT3v90HYffbge1Q6sY2E0sYWJIrb0tyUc8wjZrb6CmewEFWfS4028V4eHWkxR4a
 aW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718233261; x=1718838061;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PkHN5ZHaGSGPBr+6ovQnLLgpRVbBLYqPBu2sokkC6DM=;
 b=kD9nfy2TY2Gp6Y19oSCik0rySX3yP5uHcbheHISqBEtsGgBbpf96ee9/2oOgqi3ID4
 9DHXatdP5xAr5vsQ8x/dNov5PesFcAlWU3GY/Eq4P2Ucw+2sbtnhdb0ykf4gh21d1TQj
 G9+GcPoMUK/YbLvISLGb+27X0+b3RJMXyAow6/G+reP2NGmB8GR1/g7JszJwF7YsTlar
 tjEF+5pALGfwqFQ6Z29stqydTJOMFrI30cnR4L7zqOEJ/q9e8QHT9PJeMD1zeuOgF+gK
 N/tji/TcjMg1uDB1ckZfUdbgMJaJNPMTkOvPv2FcgVq/cc7RNyKPEb1V7O32ZAsgV3rc
 7sgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIfzUzx1LMPpzO45hDK2xwmUetwEWoEoAx1yRNDaPZnQp95MaYcLAIDcEAt9iqD8fCAEbiITnmfW6mTG9vuqEfYLAdcu0=
X-Gm-Message-State: AOJu0Yw5sW7PLM4FKzom/9LD6icMXfrUqo7o7nbfv3OIQf6yvLi3Ukto
 mYA3QJxpp2yEb7ZUX9JTYmHTbVE3ZNWeG03XpxZwjFAHrvFMpXgVjt8jGI5KbI8=
X-Google-Smtp-Source: AGHT+IHXKntcdBTNP8aph+w7LOdXmIyWc8cLH8HnEFdGDHf0aBZ58uA/8nozoI8QJwa2NTvJYZeWMA==
X-Received: by 2002:a05:6602:1645:b0:7eb:8015:3ec6 with SMTP id
 ca18e2360f4ac-7ebcd0a8a01mr323526539f.4.1718233261129; 
 Wed, 12 Jun 2024 16:01:01 -0700 (PDT)
Received: from ?IPV6:2607:fb90:35e0:8272:93ec:4db6:b474:173c?
 ([2607:fb90:35e0:8272:93ec:4db6:b474:173c])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7ebdba6594esm4210039f.29.2024.06.12.16.00.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 16:01:00 -0700 (PDT)
Message-ID: <3da62ef7-f596-465f-96dc-d7e325982b6d@linaro.org>
Date: Wed, 12 Jun 2024 16:00:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Alex Williamson <alex.williamson@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20240610171315.346143-1-stefanha@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240610171315.346143-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/10/24 10:13, Stefan Hajnoczi wrote:
> The following changes since commit 80e8f0602168f451a93e71cbb1d59e93d745e62e:
> 
>    Merge tag 'bsd-user-misc-2024q2-pull-request' of gitlab.com:bsdimp/qemu into staging (2024-06-09 11:21:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git  tags/tracing-pull-request
> 
> for you to fetch changes up to 4c2b6f328742084a5bd770af7c3a2ef07828c41c:
> 
>    tracetool: Forbid newline character in event format (2024-06-10 13:05:27 -0400)
> 
> ----------------------------------------------------------------
> Pull request
> 
> Cleanups from Philippe Mathieu-Daudé.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


