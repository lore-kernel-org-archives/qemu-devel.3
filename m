Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E66DE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tND5g-0005t5-0y; Mon, 16 Dec 2024 10:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tND5f-0005sp-0k
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:32:59 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tND5d-00029D-Dp
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:32:58 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so47963855e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 07:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734363176; x=1734967976; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qeaxxk/5UFmrNO7/apHq03mhKmg7rYak4StgbvlwN5Y=;
 b=jaSNpGkutKq7TrYbDvxbGv6I+zUqTCNAnbZg26Rp9jk8QderwZHT3v4o2sGISpFN5F
 5bL7fgWCOmzA73e3DZGk2mT2RNEYXsqCay1JmyYTjsiQxqV9aFfXxVFD4jBfO5BzmqnN
 c0U5JZ+xjNwFa6psz3noHGu6vBcHmqG18jwyjlmE2vvcLVoAzt9H8aubuc6L3vCbK4d6
 8tUfvVI9yA6qCAsMmO/KC0dX/kh8SJpL8hx51CMrBSUHAxngpIWNu8xNHH5B2lvPY1Uk
 Eqw5RS08L5Q6UUOeJG66wmirqtm/1VIBGz2YMMnVbRL982Vm+GUAlIefL+N/khyuLWJi
 /RCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734363176; x=1734967976;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qeaxxk/5UFmrNO7/apHq03mhKmg7rYak4StgbvlwN5Y=;
 b=uHnZwtN03mHp7sGuQ33awQGHQQbM3MPeL8AR/zrDtnVLQTsn1uTvaI5iw7yfX+kQML
 /PZrFrvbLIj7/VOeo5fyFcM/kHQVIiKu4Qm4/RvUyaBkckR3ZFNSLTl8Trahk8fK7c2S
 MwFg9atZ3bDYWCSsiSqt7YGOD7XZ9HB970clkuV2ma2HxM4abhFIT30w6JGNIF0B9xJP
 VYDCFQ11ZUCTFPkk50PCrwByvmdkrER0lBsIrHKBGyfz202ORPnyfg9+bWLiQpScWKJm
 C5p1c9ePNrdteY9OdkDGa3NdbIbn0ie+2sFXyM9AuJdu0dy8ZzYoXNsUxrLf7gSZCTKM
 4ccA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMG/f/bHrKanY0Mw1RwWbOLIjOnU8yiv8QcvrVxqs7s8Ih5co8cYcOtxq0PWosXb/wK4mDJAvB3Ozn@nongnu.org
X-Gm-Message-State: AOJu0Yyw4Ob5tEpo4j9RE/MkWILt6x55G5svPV0ygCvPk8293IjBzdXd
 mbEkVo+6vUBQIRTRQVrvMG4XBeBVjABnoOTL0cskjfe60r5VJ3uGQ/bh5y3IP98=
X-Gm-Gg: ASbGnctDw5tUt/PGP4X0SHIFxQkXWdXg8+kz/IMtKWZ9ZR/oPeQHV7Dwm6ukrCyCEF6
 Tk572Tage9B7QWxj6wDe7NAVVZ6YHbMyzr44TcU1hRGJ49vO9BNRrYso6I0Fitgl4qbc19F24Mg
 c9XDKyIAOWNU1hU840okAPt/ELepQG+Xcw/gyr21G+fNDTheowSP0+uwTUQWaY4vSu3QXeFkoLc
 9IIGTqnQRFnCvTVUr1OqUPNg6ADZ76g1GMOwswdX/OZnv/gITURs6zGPEhG4yphFNRmJJUY
X-Google-Smtp-Source: AGHT+IFl7SXCSW2IO3EOhj7BP5hXFGmNl/+/dsW5oGmdxofaZgwKY4FYjKtkGkN+xEA8H8Q9/fc3oQ==
X-Received: by 2002:a05:600c:510c:b0:434:9ec0:9e4e with SMTP id
 5b1f17b1804b1-4362aaa60dfmr130950425e9.30.1734363175401; 
 Mon, 16 Dec 2024 07:32:55 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625706595sm145289435e9.33.2024.12.16.07.32.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 07:32:54 -0800 (PST)
Message-ID: <626ee016-ec18-46c1-9ec7-a9357ed16a49@linaro.org>
Date: Mon, 16 Dec 2024 16:32:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg/s390x: Use the SLOF libc headers for the
 multiarch tests
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20241216133819.78583-1-iii@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241216133819.78583-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 16/12/24 14:37, Ilya Leoshkevich wrote:
> Compiling the s390x tests on Fedora, which has the s390x cross-compiler
> installed, fails with:
> 
>      In file included from qemu/tests/tcg/s390x/console.c:8:
>      qemu/tests/tcg/s390x/../../../pc-bios/s390-ccw/sclp.c:11:10: fatal error: string.h: No such file or directory
>         11 | #include <string.h>
> 
> This is because Fedora does not have a cross-libc. Since console.c
> already uses the SLOF libc implementation, add the respective headers
> to the include path.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.softmmu-target | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


