Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C958C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxV7w-00037A-0G; Thu, 18 Apr 2024 13:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sloosemore@baylibre.com>)
 id 1rxV7o-00036a-5Y
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 13:00:40 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sloosemore@baylibre.com>)
 id 1rxV7m-00077P-BU
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 13:00:39 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-36b30909b01so4080835ab.2
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 10:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713459636; x=1714064436;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qNlS77H+pL42RlL7qf4MOHsQ3NM/Ilv2Mnjc9BC9ICo=;
 b=pqDFjbAJk+wvC1K1nySnbFJ6i99OMEH6LLOJDTC7eoteT5ibQ3UUgj8a0FogVluMbh
 rWK5ogngUwcOgBnSGIvO3KphhFZVGTFT9vFMffX50CLxbAopPlu10B4IT5lyF3G42H4+
 9yMi5lh0TRnc8hxZNtY/p7vRaO/YfMlxDYfYTcGIkU+72q8ZrxRB5uOaFTYyD+TfbcHd
 3AV51FnoA04pMrwr53+7wHBGe1OqmjUubk5BPAtYlbenY1toRI7jv5jZwaUJ5/Y+j1UC
 pHKjeYScIQ9mz1pZJyRlIjQ5whMfOiahYI6cVtiE8HIXSMIWdS+1UgiwWJoU1yXYbnaH
 prvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713459636; x=1714064436;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qNlS77H+pL42RlL7qf4MOHsQ3NM/Ilv2Mnjc9BC9ICo=;
 b=ar5C1ZTpLvzoUqv49ODvLWAbSNikOArGvhjxoKTxbzzc9s1+1ltAqYhH5BFrKiUTe+
 p3iJmpGBNcgWzHg8Q9Y30Nd9Yd7nhMqE7oewzxanbF6g6n/AOZc4+2Sla8o0gw1OXpuZ
 TGNrPjSIGUc95w+HHVHjvFd3PGvr4JPRFDrx9cRaGN8nYdvhUirp3/rW9RFNOXxbTKVF
 vUr4nzrcgF6Qyewt6qE2kLCScaKxfPHOfkALAQaDZg/3HyeiccodZ6F548+w+WhJDFCD
 2P+oWve5hEQuwPN+e9oxtFArnXNod9zkL9BxEgwk++qaO0ljxOYOWszi8Gf4gaSGffUI
 U5rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDhKll5yMAGvvTHdxG2eLLEUxgzsK0MPu6buSjeos6O1ewuC6MYYAHgGGbU3MTSN8b083kqzt/l3ulvXfrJrCJAloazSE=
X-Gm-Message-State: AOJu0Yy4IQ+WAymK/5ZFmYGNRzXPoEazvxYAQcHcT8arRanZKOh7AD5p
 mUTopfdd+TMVUfStxKsZ96e6cxE/6le+SWzO2R7u9uZlH3MwYpQBXHwuxwSbcAU=
X-Google-Smtp-Source: AGHT+IHKlphkHSaQOsmfMnKfwDNWSaDF/GST0ATSlmdqgQEYowZAXXRPLPhQxIBXjIu4HbLTlHD9fw==
X-Received: by 2002:a05:6e02:16c9:b0:36b:2e91:efc0 with SMTP id
 9-20020a056e0216c900b0036b2e91efc0mr4004441ilx.23.1713459636161; 
 Thu, 18 Apr 2024 10:00:36 -0700 (PDT)
Received: from ?IPV6:2601:281:d901:5620:a066:ea41:9db5:8f23?
 ([2601:281:d901:5620:a066:ea41:9db5:8f23])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a056638168400b0048275128dbfsm508078jat.96.2024.04.18.10.00.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 10:00:35 -0700 (PDT)
Message-ID: <442883ff-6900-4a5e-ba4e-f4af50fd6e2d@baylibre.com>
Date: Thu, 18 Apr 2024 11:00:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Deprecation/removal of nios2 target support
To: Jeff Law <jeffreyalaw@gmail.com>, joel@rtems.org,
 Joseph Myers <josmyers@redhat.com>
Cc: gcc@gcc.gnu.org, binutils@sourceware.org, gdb-patches@sourceware.org,
 libc-alpha@sourceware.org, Chung-Lin Tang <cltang@baylibre.com>,
 andrew@reenigne.org, Yao Qi <qiyaoltc@gmail.com>,
 Dinh Nguyen <dinguyen@kernel.org>, qemu-devel@nongnu.org,
 newlib@sourceware.org, Arnd Bergmann <arnd@arndb.de>
References: <55a1bc52-b435-463e-8be1-4b23e44393a0@baylibre.com>
 <b5d375ed-283-974a-febf-892760ff855@redhat.com>
 <CAF9ehCVZddmGe0emH8H6ChjuUxia-NOpxa0dCA=5+2PAnvytZA@mail.gmail.com>
 <1fc9fdd9-bbb7-4506-bfe5-b31e9331eb90@gmail.com>
Content-Language: en-US
From: Sandra Loosemore <sloosemore@baylibre.com>
In-Reply-To: <1fc9fdd9-bbb7-4506-bfe5-b31e9331eb90@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=sloosemore@baylibre.com; helo=mail-il1-x134.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 4/18/24 10:06, Jeff Law wrote:
> 
> ACK.  Just one more note to the wider audience.  I looked at QEMU's user 
> mode support for nios2 on/off over the last couple years.  It never 
> seemed to work well enough be able to run the GCC testsuite reliably.

I looked at the problems with the nios2 user-mode support in QEMU in 
some detail a few years ago.  It looked like the problem was that it had 
copied the target syscall data structures from GLIBC and wasn't 
accounting for 32-bit target/64-bit host differences -- this 
particularly affected signal handling.  I'm pretty sure we asked Intel 
if they wanted this fixed and they were not interested in pursuing that. 
  The end result is that user-mode QEMU is not very useful for GLIBC or 
GDB testing.

> As a result, my tester builds nios2 and will run the testsuite, but all 
> the execution tests are only built, they're not actually run.  It's been 
> fairly stable, but its not doing in-depth testing.

Yes, as I noted in my previous message, there is nothing seriously wrong 
with the nios2 GCC port at present; it just seems kind of pointless to 
invest time in continuing to maintain it as a hobby when the 
architecture is dead.  I think legacy customers generally would prefer 
to keep using the toolchains previously distributed by Altera/Intel or 
Mentor/Siemens instead of trying to build a new bleeding-edge toolchain 
from scratch, too.

-Sandra

