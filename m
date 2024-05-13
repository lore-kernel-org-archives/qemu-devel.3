Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD87C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 14:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Waj-0000ek-OS; Mon, 13 May 2024 10:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Wad-0000WZ-QU
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:23:43 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Wab-00012N-0W
 for qemu-devel@nongnu.org; Mon, 13 May 2024 10:23:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-420180b5897so5921065e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715610219; x=1716215019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=guvFxqIkn4FGmGdZCrgQ8fts+jBa7izHC5JcMHzr+cw=;
 b=EhZK33ds79nmgFI4EXwrrh7eFqibWQ7mkWnRYCPnfVVYYRliV2d9q8RRQ6cTneAdYK
 +/epnpx6axd2dy6pl55VsKFposcje9fDakH3TZUEnzxMoDYPKZgyvl8nj6um31L4s49l
 1zkBuOJvsTLb9a3QoHQHHiVoU7UUQ0Qt7o0RDMVqj3kcolrLpclfWBmx44PH1ayYSrRc
 mjh4Hvxd3YY+LZPNFrqdCt3E/1FAG4FSDPTggf2qQkRJzS2jCPPL56dgROxMtQ3DsvTZ
 2b0a698Ps6IfM4es+x0PWFUsL8BKf6T8IePNEXs4JGQTsuecHhn6lng5J9HedtkVXCJt
 5+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715610219; x=1716215019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=guvFxqIkn4FGmGdZCrgQ8fts+jBa7izHC5JcMHzr+cw=;
 b=s4aMrKOlJPei9HotMZT9jtULcRlzndUfoe12VSwsbBl7clzVPMISDt92lrBhO0PlMf
 GyNa69mjavQv5wKhrZvG98xJ4sjtO8ZmJk0wb/Bgs9BYxBurqHX/5qOqQKEtLxiqDI8E
 fOmz8IsibdAi9L/UVeJ/t0E5nnPl2s9bn1LUQfAQNNl1cVXtYyX5Diup1EZRjqRKeE7X
 dvd+REYoC2kKKvdzy7wX2SPE+qn0xbtLGPmgHy7iBNlPMvVDipXk+7UCB1VrmxflsvPH
 AQ5BeM7Bb7jYT2hQHd1PzVig6inbOVvbuEw/9D1eJgDOaWfa8a55G+m//wOnNLPsgpfh
 b/9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc2tJEi3NMwhKrYI0kmJmh1GzChi2w6leKYe5MhW9RknNexp+04J1U/K4q/8yk2X9ak6FDEhjcqfsjNOxZfqNGKV2eG9k=
X-Gm-Message-State: AOJu0Yz0eQDWriY7gK6TPC5OFrDvpvV09B5d1XIq/Y9K97yne1+IUwGJ
 6gkpoHdzHQ7HWYM7ga5hhzsH0/ElgFFIzYGAOzrrtOjEYFI2FqosJ3JuZS5hJH7mEwkAU6X1PGd
 9tPI=
X-Google-Smtp-Source: AGHT+IFJD8JDmOB5rguwK4Pip0IcyA+cA3m6RvQNOU39A2L654z7nuwn/OdRRGJrm0Zek2gUOszS0A==
X-Received: by 2002:a05:600c:3595:b0:41a:e995:b924 with SMTP id
 5b1f17b1804b1-41fead6504emr67643895e9.33.1715610219329; 
 Mon, 13 May 2024 07:23:39 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbca98sm11252711f8f.112.2024.05.13.07.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 07:23:38 -0700 (PDT)
Message-ID: <236fa43a-bb2a-4d10-89a8-bc70bb9f406b@linaro.org>
Date: Mon, 13 May 2024 16:23:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] block/vmdk: Improve error messages on extent write
 error
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, hreitz@redhat.com,
 marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de,
 pbonzini@redhat.com, richard.henderson@linaro.org, qemu-block@nongnu.org
References: <20240513141703.549874-1-armbru@redhat.com>
 <20240513141703.549874-4-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513141703.549874-4-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 13/5/24 16:17, Markus Armbruster wrote:
> vmdk_init_extent() reports blk_co_pwrite() failure to its caller as
> 
>      An IO error has occurred
> 
> The errno code returned by blk_co_pwrite() is lost.
> 
> Improve this to
> 
>      failed to write VMDK <what>: <description of errno>
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   block/vmdk.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


