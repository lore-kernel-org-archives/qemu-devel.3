Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA08C83030
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 20:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKxw-0003VC-8W; Mon, 30 Jun 2025 16:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWKxt-0003Ut-BS
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:18:57 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWKxq-0002DZ-EX
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 16:18:57 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2363616a1a6so19964475ad.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 13:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751314732; x=1751919532; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gcbpiwxb/T3MTViaos40c0NFlzFRu1N9xiMG5+q6Wko=;
 b=QK+aQbE/OCXs/5QbDve1FPSH5J7ZCjnAcEvviuL+RitF6ri6SnzxPVG36ZklfhwP+3
 1bjQTrIvp36wZ1eOElbd20yMBfc2NPnnflMztlqo+k+Ff55AOp5NseH7K5ytuvD0bllu
 smHw88d3YNmSz+CwY2bHg6a4E4lejXXOJTAeNajHbFiWIlP6QZxOQ6Mtz/HOOUfwxkuQ
 YNhsrF0Ira2Iws5Ckp934BmAbytU/M7iy0BNsbGqq1De35FvmexPjIU+J1EiqxXO58ko
 ixnzySYq2m8Ch80NErpP5nNQ+D+9N05AbjXAofI7sPWRZJqj+N18nqAfrdXErRYh1y3k
 zgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751314732; x=1751919532;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gcbpiwxb/T3MTViaos40c0NFlzFRu1N9xiMG5+q6Wko=;
 b=RIDCKiQJESVngrClDDRYtWRmbBsW8fAxINWGDIVlMI4RnY/7sQgS6+HT4fVrlrfn6I
 g/3zuHSyHNBSdlhU33sX0dkET5QXr9m47cpbRUhjoUdzOvng8o7lO8KzfrFuY8co9vOb
 hxFxSRms3i+s4BYfQYq/q29e8diymVLMuEFL2eO6y+xtP0k27aMyDFZjZJ3L4uthv+i/
 YzCEy+NEL7YO7PBM7MrHJ1llsLrBhcnTjSIKtD9DyLvevUNGQS03wwQEz/LoU0n+rnhQ
 tzr9ji4m84qIeEODh3BtQsl7tToSmMFr/qLipPG4gSw1MxW5HObBGlfdoTZuD/0d6KEw
 rjMQ==
X-Gm-Message-State: AOJu0YyTFL8L0tEI6jjRoIl6Fw515+2ofZFVoxcwL22pBMPeXhGRFReQ
 IVgNCsn4kmt/G04xYGTcZ/N4DuPBhiwf+KiGdwkuhOldi+lb2dwHFtRFpham/sc89Yk=
X-Gm-Gg: ASbGncvDt9lTMhXIxOobERva+kGDPzu4PjMc8zPUUnfMCDiMJLGPyjef58gnN3ytQwM
 APm3dvRn+ul9q64l9AUod3TMJ3dZy22dEP2Ke3ZsFwte7U1RvsN4QvA0rVLxyRbk6ULya6rqoA3
 c/I3s+A8vAAhHn+RCn6H7Hbk4l+U++u4Okms79XYPKsk/HYWv5zQ/kAbQMF+7r+3JOnOi8TVds6
 uX80zPh+tOfrnr14rjaJWdDvmnZ6Os4kUIrFnwjOHIOOl4q8GzM8+4uPJSKi5O/uEoWWKSD5ewL
 snbADu8CYD1JQjnqGy4YPEbpWx2XuNBQ4Ve3YzYTaoz30CU7xS3hKDZH0t4h//WwxatIgwP9pfY
 =
X-Google-Smtp-Source: AGHT+IHi99KE6TJ5XslJutN2HXwokQs37vumKrPI0b1RYv2/MQuqibzwp2eL5YA0QGZOXPCxnYyWEw==
X-Received: by 2002:a17:903:1786:b0:235:6e7:8df2 with SMTP id
 d9443c01a7336-23ac465cc6cmr218261865ad.41.1751314732124; 
 Mon, 30 Jun 2025 13:18:52 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3adeabsm85277395ad.159.2025.06.30.13.18.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 13:18:51 -0700 (PDT)
Message-ID: <66852209-91e3-43a2-8d7a-51b31f843dca@linaro.org>
Date: Mon, 30 Jun 2025 13:18:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Options to output the preprocessor code
Content-Language: en-US
To: mindentropy <mindentropy@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <CAM2a4uyBMNSdKNtJWWTgNivj6dpDFzJJepkfpU5RN-wir9vQEQ@mail.gmail.com>
 <81d022a7-fdf7-4a03-9a3b-cb2635c96cda@linaro.org>
 <CAM2a4uxrzRKrQsnaNXwQO208V4WExg+MvweKfRwF+_RgXrFqxw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAM2a4uxrzRKrQsnaNXwQO208V4WExg+MvweKfRwF+_RgXrFqxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 6/30/25 12:23 PM, mindentropy wrote:
> On Tue, Jul 1, 2025 at 12:27 AM Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> You can get verbose command for building by using make V=1, or ninja -v,
>> depending which command you like to use.
>>
>> Then, you can get a preprocessed output by using '-E' gcc option.
>> Don't forget to remove -o option, emitting the object file (or replace
>> path).
> 
> Is there a Make rule to just generate the preprocessor output?

No, you need to find the command for the associated file you want, and 
manually add the -E parameter.

