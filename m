Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66E6ECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 06:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snuYt-0002VY-Pu; Tue, 10 Sep 2024 02:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snuYr-0002Ua-Qz
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 02:41:13 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snuYq-00064S-7E
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 02:41:13 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c3d20eed0bso457287a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 23:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725950470; x=1726555270; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GHTY511G79cYKVSEDZtS9umLvynjQucato98CT5LVJA=;
 b=Be6SCYtEpwC3MKIgKWTDahdrb30NwNur/oQjVi7rMp19oXha5q8aGZChnvNvImR706
 BL3Dsocr8i+4Qs9CZ8HLzUPMe3a0BJy8AxtRzqUfk6Ea/Gq/+fiKgIU062IxPIHXdVBs
 XAkWpxsoFwoRR6jcnoVlfFMvERbuMw8JFx1j5GjlbhxMVE0GktrFoZhhawshxjACCR8G
 gJWNsBswOReGAHdZzsypBQFbuhzImqLLFqLnIMsprAVzUJHapfwc8O7N/yOO5INF9vBK
 8dHo7aqbKfB4mIg3YO10t5SpxZT+SeR3RSfR20c0LugS4jU+iZ263FsMUcOXLUuxn3lb
 oNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725950470; x=1726555270;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GHTY511G79cYKVSEDZtS9umLvynjQucato98CT5LVJA=;
 b=Hu3NGSpfpS9KyU7jZdD6cOIHCIvfxNTayDSJamwLK3F3iEZKqgKy6EXAJHNzdHzcr1
 ip97d6l+Ms9RfEpiyQknAaUolReThI9N8sBhKaN/ak0HicU84A8wcKcZtqUY+atOzzx8
 MJ/f9rx2iLiL8cGWIAkQGiAQ/zl6soRz0sClC68QZg1oGgqqmYs2l1jaZBcX1FfXoae8
 3D/VK6YieDsecXs0TjhH6iD++/SUNpUknszDFO8g4IXr54AlHBXp0Sqve2wJFwGXZ+gS
 Dn6PjHJpJXXR9YOlwZliAgl2pki0qJRoF1F3ECuEvNWCIsVhA532IFvj+uAWJo8KNVKg
 3QKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeQ5hxg3ClHCyD4KDsZuxANogrk5Wq7CFeJKGtJdhfpXb1lx3TOJRM1jCrly7z6mqjaRLeZay2rTrT@nongnu.org
X-Gm-Message-State: AOJu0YzOftTe+nsg4sB/GWUFY0B5YPZMMGTHdaZzJSaY0zNCKFtpjytJ
 DIRU3p6bP3TshdabNBUbCtxokLHVNryFzYmEmMJtj/GRA/71BapV7XKPR1rfP1Nyc39PMThEicW
 w
X-Google-Smtp-Source: AGHT+IFvjmXhfPY9sEIqnoT0OHhHYmlr5lP7FFLJWmJ72F7ect7DGg1GRlWK7Op8udsBuDoyTPZ4bg==
X-Received: by 2002:a17:907:a45:b0:a86:80ef:4fe5 with SMTP id
 a640c23a62f3a-a8a8885db26mr1169146566b.47.1725950470124; 
 Mon, 09 Sep 2024 23:41:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25cf4aa7sm440600766b.176.2024.09.09.23.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 23:41:09 -0700 (PDT)
Message-ID: <4942adc4-68f5-4d26-acfc-f47f531c9c43@linaro.org>
Date: Tue, 10 Sep 2024 08:41:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: check-functional skipUnless failure
To: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>
References: <5f193fa1-89ec-4424-b6fd-c7ae1a4beedf@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5f193fa1-89ec-4424-b6fd-c7ae1a4beedf@linaro.org>
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

On 10/9/24 05:58, Richard Henderson wrote:
> [rth@cfarm120 bld]$ make check-functional
> [1/2] Generating tests/functional/func-precache-m68k-m68k_nextcube with 
> a custom command (wrapped by meson to set env)
> FAILED: tests/functional/m68k-m68k_nextcube.tstamp
> env 
> QEMU_TEST_PRECACHE=/home/rth/qemu/bld/tests/functional/m68k-m68k_nextcube.tstamp PYTHONPATH=/home/rth/qemu/src/python:/home/rth/qemu/src/tests/functional /home/rth/qemu/bld/pyvenv/bin/python3 /home/rth/qemu/src/tests/functional/test_m68k_nextcube.py
> Traceback (most recent call last):
>    File "/home/rth/qemu/src/tests/functional/test_m68k_nextcube.py", 
> line 25, in <module>
>      class NextCubeMachine(QemuSystemTest):
>    File "/home/rth/qemu/src/tests/functional/test_m68k_nextcube.py", 
> line 60, in NextCubeMachine
>      @skipUnless(tesseract_available(4), 'tesseract OCR tool not 
> available')
>    File "/home/rth/qemu/src/tests/functional/qemu_test/tesseract.py", 
> line 16, in tesseract_available
>      (stdout, stderr, ret) = run_cmd([ 'tesseract', '--version'])
>    File "/home/rth/qemu/src/tests/functional/qemu_test/cmd.py", line 69, 
> in run_cmd
>      subp = subprocess.Popen(args,
>    File "/usr/lib64/python3.9/subprocess.py", line 951, in __init__
>      self._execute_child(args, executable, preexec_fn, close_fds,
>    File "/usr/lib64/python3.9/subprocess.py", line 1837, in _execute_child
>      raise child_exception_type(errno_num, err_msg, err_filename)
> FileNotFoundError: [Errno 2] No such file or directory: 'tesseract'
> 
> 
> On this host, tesseract is not available.
> But skipUnless is not skipping, but erroring out.

While looking at this, I'm surprised to notice has_cmd() actually
*runs* the command by calling run_cmd(). I'd have expected it solely
checks for binary presence and RX perms, avoiding unexpected side
effects.

