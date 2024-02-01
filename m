Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FCAC47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 12:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWZR-0005wP-PV; Thu, 01 Feb 2024 07:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVWZP-0005vU-LA
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:53:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVWZO-0006yk-7c
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706792009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WwnBtpy5PJQx7MekledeFchN2wFSg89vBsxxtU+9CiI=;
 b=iPuRY/4pUrfnINzHhWyqMfd5nEx6IXg3BS2aYg1uws8tLHzu7KwciVyyB5xMytXXfzNIB/
 zyfcMg4yeoRfEX5Yl1/7YU2MRAR/nAqbGqHQze51wtG2+lbCeuc7prhKpOYBumhmZQ6v0n
 KFdyvbvk5PxbI4tRjHRv9qedTt62cvY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-4Z2KyhodPm6Fnj0o9TxLyQ-1; Thu, 01 Feb 2024 07:53:28 -0500
X-MC-Unique: 4Z2KyhodPm6Fnj0o9TxLyQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-dc6b26eed12so1283861276.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 04:53:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706792007; x=1707396807;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WwnBtpy5PJQx7MekledeFchN2wFSg89vBsxxtU+9CiI=;
 b=OUq2/buELRJPSZd1ltm191SvC5MkcFmE1BdeROjDhsXuNlRAy97AWiz+xK6yfI24s2
 q7nvvdjYL2l8ZF2QomkH44IHLXyJIK3dSKh/RO/PuLY2wBYX8T3+gPiJmcTOFcQ2/Uqi
 YTG+TZhNQTvl1aef45V7XwSRDvsNziEaJTL/zgHK3VUbD8fchmfZOHuulKSlZgxYrhj0
 gegs3iSRZRRuBg9OyI+vrHSpKQFm4Etdwb3l563PKjdl7YwlqbYjX06hLDr2FzSkm52w
 syseuLK7AM6+tnWZ/KDGb/FNmSgRl5plxJ08eebDk009tkgFbvIsvFleJmSidOCtybvV
 UKcQ==
X-Gm-Message-State: AOJu0YwSqt5JaZ2Nvy9N8K/E1yNTxqbp2fC146FmZYYFZobI3nvyZZ80
 663atLHD9jsDc9ovFjJCsSo+X2iEWveg77nXyFmtzpvD5eYLNUwGOBqnU/t8x1WozllQCa6v6YG
 r/GxCiBQ2muXMcitZlSHB26e2zKpfnqvTjuJ3xYl0CX/6X0auCIKu
X-Received: by 2002:a5b:d0b:0:b0:dc6:b7de:61fa with SMTP id
 y11-20020a5b0d0b000000b00dc6b7de61famr4659068ybp.12.1706792007592; 
 Thu, 01 Feb 2024 04:53:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4xpWOqvazpnskZmeJgwOpQzViJZ5FcEGwN3FdP5H1SizoxTRE3w283lbcPw91NmRp1qRCxA==
X-Received: by 2002:a5b:d0b:0:b0:dc6:b7de:61fa with SMTP id
 y11-20020a5b0d0b000000b00dc6b7de61famr4659044ybp.12.1706792007300; 
 Thu, 01 Feb 2024 04:53:27 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU1WwuCtisxBfbY0ASmeVzsNr0t57jZ43T901VZ1liUjc5Q49Tz+T6RUwf1o+NpXs+aY3k6HJQcX5RNOK4nsyNoqVJPr3NGpuA9d0wokOu2hFVOco/AbIjeQD2Tkig3NcMSTyWRN18hVDlUVpHUkXoERskz+3sUl6JZqGMqlmuQlHj7npX0PmsIbBg4DTbi7gOKA0eAtkjQXrWbV+5lI6StMkwP7KtM7nSL2pW0fy9z0VjNEaCD13M9gJqqNIZA/p9/npg9Vsg9hTdyqPbE70/tBbhwA4amxCYE61Q4CJVllr0ixusF9YCipb/EPHArnFXQceFVT4jPID6tJWXMIsWKkMMk5bTf1YUyouW/oOQ9RHVjzZZvPl8LKmqzOaW70Di04IJYaJGmvXWvfmJJJnWqmMNVq+YR9jQm8g7AFTqbJD/M/pOY22W8lSOczk1SxiFc4e1tyJClY91neE/dYqYzJdRQwhODIz17fKTUoctomWj/f1F9hkOv9AKjG7SZ4p+7vHj3XN2aqYzGN1B5izKzSQ3Law/fUEpytT5238eW6AGBbg==
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de.
 [109.43.177.196]) by smtp.gmail.com with ESMTPSA id
 s9-20020a05621412c900b0068c821c7822sm36403qvv.106.2024.02.01.04.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 04:53:26 -0800 (PST)
Message-ID: <5d063217-43a4-4e85-96f7-b9778e29f3e5@redhat.com>
Date: Thu, 1 Feb 2024 13:53:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] Revert "hw/elf_ops: Ignore loadable segments with
 zero size"
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Beraldo Leal <bleal@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chris Wulff <crwulff@gmail.com>
References: <20240201122835.1712347-1-alex.bennee@linaro.org>
 <20240201122835.1712347-5-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240201122835.1712347-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 01/02/2024 13.28, Alex Bennée wrote:
> This regressed qemu-system-xtensa:
> 
>      TEST    test_load_store on xtensa
>    qemu-system-xtensa: Some ROM regions are overlapping
>    These ROM regions might have been loaded by direct user request or by default.
>    They could be BIOS/firmware images, a guest kernel, initrd or some other file loaded into guest memory.
>    Check whether you intended to load all this guest code, and whether it has been built to load to the correct addresses.
> 
>    The following two regions overlap (in the memory address space):
>      test_load_store ELF program header segment 1 (addresses 0x0000000000001000 - 0x0000000000001f26)
>      test_load_store ELF program header segment 2 (addresses 0x0000000000001ab8 - 0x0000000000001ab8)
>    make[1]: *** [Makefile:187: run-test_load_store] Error 1
> 
> This reverts commit 62570f1434160d356311e1c217537e24a4ac85cd.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/hw/elf_ops.h | 75 +++++++++++++++++++++-----------------------
>   1 file changed, 36 insertions(+), 39 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



