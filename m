Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54B9C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEzqU-00078n-U1; Wed, 05 Jun 2024 19:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEzqT-00078d-1f
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:15:05 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEzqR-0001FY-6c
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:15:04 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f692d6e990so3841805ad.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717629300; x=1718234100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vlCLkcY2sncir5x2b+MaLJLG/abK6GNTs+IkP/0Iyhc=;
 b=cGkt6zdbTlMYU/ejuUhh4AmSaOgIgHJP0D+P1ImfgyeYiR3XZlcUn72uzxg9+jHciK
 HFltSM/OtXlgiktZ1tGxWOmJ7Y8r0zpIJwowS8KtdqCuYXlaQ747PujmBeEXHOXqfKiR
 w48d4W1RzzCq4i09KJaf2SQRl+GzUxj/DEYTjHvCO5SKEMRiV+fyoroiobrkdbHJeeIE
 CaR+wIdd72Uc5NQHdpvtRz495AGl0Li6W1RTPkpKlVukz05eq2SJSzl30nq5MQnoKsAT
 d9KZqPJwHvN+7HttVunT5NJ+plt/6Eftbl3XitQWNoDXha6crHto6MBa7Y8oAfOU7y6h
 vDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717629300; x=1718234100;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vlCLkcY2sncir5x2b+MaLJLG/abK6GNTs+IkP/0Iyhc=;
 b=sNg+UyludR6CqCDpxFJW7iH+8KT6h8JWRs83XVkPIsgmkT3S5AHFFez2Td1lOzi4CF
 Xmiapjqm9tYE7nBnWKBCrigDBDPP4xh4aOSEAum9+OiFR0UTMXGsuq8X5TGpw1GCqZkA
 WTrUO6jGlc/URyJUrQ/6RnfQS3PoHGkVWX4dASDiwj5xe5cReBlBL2e3WpDhVbF4g2t9
 7hrwrxLVcNmLw5EDmL8oOizGqw2hVoerCGi60Xx/1K1fpc42tsECljiWNrNfdLUpA6og
 6uHX8mk6XZVUgX1mPfq5LDUiEO8S+imkvQ2KA4QLhgXRYG6hEsx5Bh9YAf4vWsUEkHUA
 Aqiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUceq1qEzDCEOva9axdepN+EH+vWXQNmYZ0Iox+nj58X8mN6ew+r0FtBIdSVa5OfRCDsUPUWLmzz6xOJFCialuCw5bkJP8=
X-Gm-Message-State: AOJu0YwAqNZcRdHXeFk/2UOKHdRW3CRxYQW68Mz7V+KykAeWfGjoYODu
 p3CuF8GdP6LD20+kFhLlfMC4NhH1oB5+eK+YzSLPHBsLOwOloVO5nbkaG5c9ZCk=
X-Google-Smtp-Source: AGHT+IE7qdeYPsFamn6Nv3nnXhcKEf0mLeTh2yNZYsF088K7QjBNEVHGaokBT0+QWkRr7P7oEWgMcA==
X-Received: by 2002:a17:902:ec8f:b0:1f6:8ae4:50de with SMTP id
 d9443c01a7336-1f6a5a852b4mr49022645ad.61.1717629299940; 
 Wed, 05 Jun 2024 16:14:59 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd76c240sm879515ad.89.2024.06.05.16.14.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 16:14:59 -0700 (PDT)
Message-ID: <a0e9ee6b-fbe6-48af-a122-fbf5d31aa476@linaro.org>
Date: Wed, 5 Jun 2024 16:14:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-user emulation hangs during fork
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
References: <mvm5xunu4ye.fsf@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <mvm5xunu4ye.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 6/5/24 02:14, Andreas Schwab wrote:
> $ qemu-x86_64 --version
> qemu-x86_64 version 9.0.50 (v9.0.0-1211-gd16cab541a)
> Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers
> $ cat fork.rb
> begin
>    r, w = IO.pipe
>    if pid1 = fork
>      w.close
>      r.read 1
>      Process.kill "USR1", pid1
>      Process.wait2 pid1
>    else
>      print "child\n"
>      r.close
>      if pid2 = fork
>        trap("USR1") { print "child: kill\n"; Process.kill "USR2", pid2 }
>        w.close
>        print "child: wait\n"
>        Process.wait2 pid2
>      else
>        print "grandchild\n"
>        w.close
>        sleep 0.2
>      end
>    end
> end
> $ ruby fork.rb
> child
> child: wait
> grandchild
> child: kill
> $ qemu-x86_64 /usr/bin/ruby fork.rb
> child
> child: wait
> ^Z
> [1]+  Stopped                 qemu-x86_64 /usr/bin/ruby fork.rb
> $ grep SigB $(for p in $(pidof qemu-x86_64); do echo /proc/$p/status; done | sort)
> /proc/3221/status:SigBlk:       0000000000000000
> /proc/3224/status:SigBlk:       0000000000000000
> /proc/3228/status:SigBlk:       fffffff27ffbfa9f
> 

Works for me:

rth@stoup:~/zz$ ~/qemu/bld/qemu-x86_64 `which ruby` fork.rb
child
grandchild
child: wait
child: kill
rth@stoup:~/zz$ ~/qemu/bld/qemu-x86_64 `which ruby` fork.rb
child
grandchild
child: wait
child: kill
rth@stoup:~/zz$ ~/qemu/bld/qemu-x86_64 `which ruby` fork.rb
child
grandchild
child: wait
child: kill
rth@stoup:~/zz$ ~/qemu/bld/qemu-x86_64 `which ruby` fork.rb
child
grandchild
child: wait
child: kill


r~

