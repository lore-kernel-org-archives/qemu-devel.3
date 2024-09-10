Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED472ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 11:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snyoz-0005RX-FX; Tue, 10 Sep 2024 07:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snyow-0005Qn-O1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:14:06 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snyou-0001dD-RR
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:14:06 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c26852aff1so6297761a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 04:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725966841; x=1726571641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7LUNBCFMOK1dnFjHo5WjzcQB0Uw9vV8fJUBWXvZgEHM=;
 b=HspC5rZb/+VbKzmTaJcqLAI9OwHojdJ1mZyVpSxz7Ho4uYRrjuoElEPN2YUnZg05Yp
 nr0sj4OStKexCafyKKS578+F+XGxaRCo3wu/vT0An1T5LKCUViIzHGIpt5OQTEsLyT45
 eQdZJBLD+vbFeRhT7E/1fezBaxHC0ccw+cvXepfAYThnEkFWdcPvPSTl807x/xrWy4kB
 MZ7mGHv5aH0eAxV67OV/ijlq8GC00YPzXKjnk9uuy0WtL1Ybl+zP5Q2rqpYdMYJRMgfK
 RnDmTE5aywaL8zxDMoeseA+qYXSF6/dwtiZv328r1GlmA6W4pZ1yFnDxEv3FpMyZXb2k
 JEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725966841; x=1726571641;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7LUNBCFMOK1dnFjHo5WjzcQB0Uw9vV8fJUBWXvZgEHM=;
 b=VSNC9oE4Bkr8UjNSDKXP2fvwfRgWZZ1NiUWkXsM0lwKORzwB1IR00EGLSTnVMI4xtK
 1B0e9TpndvLZKRg4vLxCdFDN6/P6w5DhEriNKFIRFZbBjFH056bWXFaYlBG8aWjnoYB5
 e8gcvBCFE+LiR14ERE/O3Rt2suQMenBL3GS3pjjPamJ9ncLrUzZob79jYnGNPInYUjFf
 DNcv7NASVHvO1kki5WsawEAR3yM7REE6BjcT78XR9k1pCDobD3SkOy5n00jZNWK7vKJX
 jnVIJe8ejhYml+4zkG+ADA3zfppd9dRKq/bEySUSAPJV4D5/iEJESMaaRq9rR/eeDr9a
 rUoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/lzXk5ePiT4HT0/gTkH4y5vZ5OjrkZGtliWuBsSVCFERmxfZbgJpA3RcfWZrjS7Bj+2UsuXd7erso@nongnu.org
X-Gm-Message-State: AOJu0YwA6KHnjRRvO+0RFRu/xnkIr5T0/gAj7GAx2jzW+ltSW3X0nsUK
 UpUqLaKmFmB0cVbSlWHLTzw5MCF6y+sVlil1zvQ2oPMpjzJJTjmNLW5dn0hZ/Z7NwRGDtUOldab
 B
X-Google-Smtp-Source: AGHT+IG4og8CAuPi60U3dXsmknyBdkw1Bt7XtwFHqlk5i4FkoIiujKvwNYFvYBe4EsLQQEFb4c7qIw==
X-Received: by 2002:a05:6402:13d0:b0:5c2:6e5f:3bf9 with SMTP id
 4fb4d7f45d1cf-5c3e9742e64mr9451189a12.28.1725966841165; 
 Tue, 10 Sep 2024 04:14:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd46909sm4305742a12.25.2024.09.10.04.14.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 04:14:00 -0700 (PDT)
Message-ID: <79f8ca1e-a626-43e8-8b08-4fb231dca07f@linaro.org>
Date: Tue, 10 Sep 2024 13:13:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: check-functional skipUnless failure
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <5f193fa1-89ec-4424-b6fd-c7ae1a4beedf@linaro.org>
 <4942adc4-68f5-4d26-acfc-f47f531c9c43@linaro.org>
 <b04d662f-0ec1-4c93-a67a-d0e77df271cd@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b04d662f-0ec1-4c93-a67a-d0e77df271cd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 10/9/24 09:36, Thomas Huth wrote:
> On 10/09/2024 08.41, Philippe Mathieu-Daudé wrote:
>>> line 16, in tesseract_available
>>>      (stdout, stderr, ret) = run_cmd([ 'tesseract', '--version'])
>>>    File "/home/rth/qemu/src/tests/functional/qemu_test/cmd.py", line 
>>> 69, in run_cmd
>>>      subp = subprocess.Popen(args,
>>>    File "/usr/lib64/python3.9/subprocess.py", line 951, in __init__
>>>      self._execute_child(args, executable, preexec_fn, close_fds,
>>>    File "/usr/lib64/python3.9/subprocess.py", line 1837, in 
>>> _execute_child
>>>      raise child_exception_type(errno_num, err_msg, err_filename)
>>> FileNotFoundError: [Errno 2] No such file or directory: 'tesseract'


>> While looking at this, I'm surprised to notice has_cmd() actually
>> *runs* the command by calling run_cmd(). I'd have expected it solely
>> checks for binary presence and RX perms, avoiding unexpected side
>> effects.
> 
> It uses "which" to search for the binary ... that could be done better 
> for sure (especially since "which" might not be available on all 
> systems), but it already was done this way in the Avocado tests, so at 
> least that's not a regression.

Sure, I just wanted to share my surprise before forgetting ;)


