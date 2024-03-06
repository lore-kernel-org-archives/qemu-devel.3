Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999F0C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 16:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhu3O-0003lF-3G; Wed, 06 Mar 2024 11:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhu3M-0003l3-8W
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:23:36 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhu3B-0004LZ-LW
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:23:35 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a45670f9508so269266b.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 08:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709742204; x=1710347004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eQWZWHJ+4CGxm/sW6ViaEFLYelWh1L5bxQ5FP7dieNk=;
 b=qMrwZnVKV8BtBIyRY5KxKGHPxT7dn+f0ZmnOPtNVhxuQ0uY0G+Lra+vsgEC6LvWvXp
 rvWet8uA3JlgsFu17Zz3TmC/tEDR5mWm7uiai7GeBNSIjDpeXpmsPizNvv40yhKPj38/
 EP0a87qWBsmbkhRK4a3ds7mK0NoTwWqyahF38nlzQ4XZt5mZzHzHQmvKesl4Fbjadoad
 maXaGBbL6VdDvgg1tZPSasIoVf1na9HLgYBgT6/NrUNp8YpsxerKkVzWwemL6PGGEKXy
 wyQ1g58UdT81o6heyGXdLqfb6qAio88aI8SsGWuRa0roDGEdIMLkZNKN35jHlIOOH2dn
 Dv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709742204; x=1710347004;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eQWZWHJ+4CGxm/sW6ViaEFLYelWh1L5bxQ5FP7dieNk=;
 b=LHS9/RYBjL6BNvzURSaD7A+1WQUAKry3X3ubtCkg+andpRzPTx0rUBR4GVWA3Tb1yB
 3wpwvwuLv7QYVjeMUw5NDfFIDaCaBHdZHFR84ZLRoq6K0MU1NK+PJ3yQmaQW3Mrql+ee
 kumq5VU9FcY+dQ9LVBs0FC7zP1pT+35gZvn+uspDZS2CNxPIjEl/EQ1LiDyIOZwT6mLD
 zutm7JYGLwhR7SdN6oEn9mweFAeClPBT9aHJAeUO5GKGBa+iE5sALpn3W2YOH9jHAhyL
 z9y6mRC+1RvdWXNpGKECZMLHfJf8SPZvtJic8Z9y43D6DKL7ynlbukqDzOhadd+A87AO
 hk0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMxl6qQ9sKxFnAONYm7y457qGX3/VklTaxeQhM5vaMvx6tujsSVitItfZ33D7C33YrczfocIF3AGQGzUf2kNtiS/Fn9oo=
X-Gm-Message-State: AOJu0YxhuAw/cZvuaXxlwauX3wppzpMYB7yCaGR3gYz4ft5xN+LX5cRf
 nSn4BlF+Nqpyth7FIo9PDOj65WWxuv36XUFh0brltcaj+IrKICaVZq/ZuGmgmQs=
X-Google-Smtp-Source: AGHT+IEjkQ+W5lHRD6bMAdtY2QgyKHhWeQOCNxO3Xlc1EwOWZg1/EWdl+b0J2NE2wl/qPzP6LN9UhA==
X-Received: by 2002:a17:906:4088:b0:a44:d084:926b with SMTP id
 u8-20020a170906408800b00a44d084926bmr7339023ejj.77.1709742203961; 
 Wed, 06 Mar 2024 08:23:23 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 j12-20020a170906094c00b00a3e5adf11c7sm7253127ejd.157.2024.03.06.08.23.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 08:23:23 -0800 (PST)
Message-ID: <4cccc4c2-fe3b-4af7-aedb-69d96dadf56f@linaro.org>
Date: Wed, 6 Mar 2024 17:23:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] blockdev: Fix block_resize error reporting for op
 blockers
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org
References: <20240306131055.2460378-1-armbru@redhat.com>
 <20240306131055.2460378-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240306131055.2460378-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/3/24 14:10, Markus Armbruster wrote:
> When block_resize() runs into an op blocker, it creates an error like
> this:
> 
>          error_setg(errp, "Device '%s' is in use", device);
> 
> Trouble is @device can be null.  My system formats null as "(null)",
> but other systems might crash.  Reproducer:
> 
> 1. Create two block devices
> 
>      -> {"execute": "blockdev-add", "arguments": {"driver": "file", "node-name": "blk0", "filename": "64k.img"}}
>      <- {"return": {}}
>      -> {"execute": "blockdev-add", "arguments": {"driver": "file", "node-name": "blk1", "filename": "m.img"}}
>      <- {"return": {}}
> 
> 2. Put a blocker on one them
> 
>      -> {"execute": "blockdev-mirror", "arguments": {"job-id": "job0", "device": "blk0", "target": "blk1", "sync": "full"}}
>      {"return": {}}
>      -> {"execute": "job-pause", "arguments": {"id": "job0"}}
>      {"return": {}}
>      -> {"execute": "job-complete", "arguments": {"id": "job0"}}
>      {"return": {}}
> 
>     Note: job events elided for brevity.
> 
> 3. Attempt to resize
> 
>      -> {"execute": "block_resize", "arguments": {"node-name": "blk1", "size":32768}}
>      <- {"error": {"class": "GenericError", "desc": "Device '(null)' is in use"}}
> 
> Broken when commit 3b1dbd11a60 made @device optional.  Fixed in commit
> ed3d2ec98a3 (block: Add errp to b{lk,drv}_truncate()), except for this
> one instance.
> 
> Fix it by using the error message provided by the op blocker instead,
> so it fails like this:
> 
>      <- {"error": {"class": "GenericError", "desc": "Node 'blk1' is busy: block device is in use by block job: mirror"}}
> 
> Fixes: 3b1dbd11a60d (qmp: Allow block_resize to manipulate bs graph nodes.)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   blockdev.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


