Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C70C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 23:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rws2A-00061Z-J7; Tue, 16 Apr 2024 19:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rws26-00061A-Or
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 19:16:10 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rws23-0000ZN-Gi
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 19:16:09 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e3ca546d40so36665725ad.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 16:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713309366; x=1713914166; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C9WhiVlQMH7+nQDIJtGcV0zepCzHR0okzVyp5RsCYbk=;
 b=KET/AlpgUVis5Z0H7Ex24xK1LmnEIQXUszChISaoRbMQiU7qvdWh+EGota9mrfTrzy
 L3rSE2Q6Yl+3oI3X3GCEHAyUamOIrwtVg1ETn9b5uwbqcUlItuvHx8EC3fvuWDjHKhnl
 nHb2WGlRtlMztaUMip6OlviIOgVhQbHT45SZ4r0x273yN5tz97qUri6qMcqrwZMMQxuH
 cJ0uMuo1PT6wQ1m2rU7HtE8OHKJ9idU6Mdf2j1hb7/MRzzQSThT4WDTiQM+EwMUMTUkp
 KK4cJwRuRgKwnbO8GyRMCF2M8s+/Op+gDYeGemN4k4bwdKuj/KAZzi5IHqwZ39uCq3lf
 GGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713309366; x=1713914166;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C9WhiVlQMH7+nQDIJtGcV0zepCzHR0okzVyp5RsCYbk=;
 b=PEbaLg4jQlnAdjiSFsC3tYS4tabRsuzTEUlq3n+Q84MD+Q2wk6/EDYv6VTB10L2R2U
 TE21dVPjYzf4yDc0EtEBOXFmaLNAolX2TBgMiqfGxaL4zQ+vScxequ/P9dkikAijHBB5
 ULyRsOLMRlrLerQoYaK0vpueA5MeLu+fPOUs0PmeyLInHCi0pQx59DFw1iksbKv7E8E+
 JAOy+ZAC81sN64PsKj+iH2qlN+hxLcPwzMozN/wfADpwXVi/H5RsW+I2bV6cdOti/Y8R
 Q6pp6zJdfhLYnnXr/doPmyWtjBIgp3wxq4ftpu1rBjxHA/7RPPLev9t0qbQ94FfmCkVi
 PEHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBF/e90pNn9Mn0tcFuvwWjn6VfrwFvcaQX+en897rlCuwoZvp7h1fNY9ztIPKFf+cPiqyPHRAjQHOe+HlrPlWlC6zVbXY=
X-Gm-Message-State: AOJu0YzFQS2gmGsp86kSQLR3D5KLxGY0ro+yefdZYe297/A/ZjoknUpz
 u7jN5z1K7IN1awqCneWsf7KoLxm0eaMfFUEhRbHvaglDj67xZXBmkBVLK1aVj2g=
X-Google-Smtp-Source: AGHT+IHJkbNuKdhoMb++xw99Fz5uHzEY7L78LlIyh1/Mao3Vge829ra2WPaN/Mvc7l46hfoIu0FC/Q==
X-Received: by 2002:a17:902:ec90:b0:1e2:616a:9c31 with SMTP id
 x16-20020a170902ec9000b001e2616a9c31mr14444576plg.39.1713309365885; 
 Tue, 16 Apr 2024 16:16:05 -0700 (PDT)
Received: from [192.168.68.110] ([177.45.186.202])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a17090332c500b001e546a10c50sm10294646plr.286.2024.04.16.16.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 16:16:05 -0700 (PDT)
Message-ID: <6dc065e2-81d8-4562-84c0-8a697c58ef71@ventanamicro.com>
Date: Tue, 16 Apr 2024 20:16:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 v3 2/2] qtest/virtio-9p-test.c: remove
 g_test_slow() gate
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, qemu_oss@crudebyte.com
References: <20240327142011.805728-1-dbarboza@ventanamicro.com>
 <20240327142011.805728-3-dbarboza@ventanamicro.com>
 <a6b402b9-9f84-4d72-a631-09f04bb31450@tls.msk.ru>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <a6b402b9-9f84-4d72-a631-09f04bb31450@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
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



On 4/16/24 16:54, Michael Tokarev wrote:
> 27.03.2024 17:20, Daniel Henrique Barboza :
>> Commit 558f5c42ef gated the local tests with g_test_slow() to skip them
>> in 'make check'. The reported issue back then was this following CI
>> problem:
>>
>> https://lists.nongnu.org/archive/html/qemu-devel/2020-11/msg05510.html
>>
>> This problem ended up being fixed after it was detected with the
>> recently added risc-v machine nodes [1]. virtio-9p-test.c is now
>> creating and removing temporary dirs for each test run, instead of
>> creating a single dir for the entire qos-test scope.
>>
>> We're now able to run these tests with 'make check' in the CI, so let's
>> go ahead and re-enable them.
>>
>> This reverts commit 558f5c42efded3e0d0b20a90bce2a9a14580d824.
>>
>> [1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg05807.html
> 
> This makes tests being unable to complete on a tmpfs.  It looks like
> 9pfs tests needs another tweak here.
> 
> # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-798502.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-798502.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -M pc  -fsdev local,id=fsdev0,path='/tmp/q/master/qtest-9p-local-9LHRL2',security_model=mapped-xattr -device virtio-9p-pci,fsdev=fsdev0,addr=04.0,mount_tag=qtest -accel qtest
> Received response 7 (RLERROR) instead of 73 (RMKDIR)
> Rlerror has errno 95 (Operation not supported)
> **
> ERROR:../../../build/qemu/master/tests/qtest/libqos/virtio-9p-client.c:275:v9fs_req_recv: assertion failed (hdr.id == id): (7 == 73)
> 
> This is when I build it on /tmp/ which is a tmpfs.  When I build
> it on a real filesystem, it works fine.
> 
> Apparently xattrs aren't supported on a tmpfs.

Hmmm not sure how to proceed here since I'm not a 9p expert by any means. I'll
let Christian decide what to do.

If we can't figure it out we might need to re-introduce the gate again. Thanks,


Daniel

> 
> /mjt

