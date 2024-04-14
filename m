Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAB7C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2024 06:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvtTu-0005WJ-GO; Sun, 14 Apr 2024 02:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rvtTr-0005W4-LA
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 02:36:47 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rvtTq-0003qE-1P
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 02:36:47 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2343ae31a9bso500327fac.1
 for <qemu-devel@nongnu.org>; Sat, 13 Apr 2024 23:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1713076603; x=1713681403;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cXN7juaAYZAEBSeEZbmkoPghqsVS4rgKdc+k4xRP1WY=;
 b=KpvYUTyV4jeFvac6E6OqxRFck/GhdmKEzdLxAiynpvtCckDCBJgtkC06AqivKgg1c/
 5Fk4YnpqNqR3637aGfA0QB0oXZDuzVbOWbdHcKYkNPcUv56Ktk8AbY1rycMmDK+VCoa+
 Td4KAk2s2cjM7Uu1K6WJlMRFSBcs6O4oJWwmyANCufNkGuBEnIqqHxg92odG92KxIII5
 mXO4QalHX48q1HZVh6n6DseRj/s8VPpTCCWPwTyi93+AHROvoQI1fwbLqVS0cUbhlx3v
 qp5QLMFzO7maT5MyHo31hnwEzTLQzHvD3o9l1VbMUMv5afVr7nFFTgMjtwZ6t+DSyCJh
 91yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713076603; x=1713681403;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cXN7juaAYZAEBSeEZbmkoPghqsVS4rgKdc+k4xRP1WY=;
 b=IvVYbmwQz0vZEeWd8XDHJtJsMPfOkBDjBW1wQTpFZvzLzKiLcLyTiU4QkO5K8dUXgC
 LRyfPOcfXyJxJF3q7YcxFYnmr9zOvqTuz8N48/SdvNGGKnwKruysYiLyyaweVZUgfN39
 45KAbTO0CzYTYrf6M8iqFJ9YLLItnOyVG/jga+Z870q4YHDx0kiQ75S8KrE3GhRcN8jJ
 rP8Ke5YmIIeA4bONjNxY3AMDe+pVjOmes0iU4ow9hwhAY2ZGDD3YGnDpwslblgYCDSSE
 QN4UFoVcg/TkB/mTOBnXbzzyN9LGO+Vjq8NAz6N0kuOgaG1sde5UgpVOjU9teKSndWqB
 Hrig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn/To5gUfRP9Y7CEfJct1rAwk3xS8k1Dgde6y5f1LVBAgVutVggmJqy6yu5hLyN8un8z9247uhA6RtlACbXzMAjz40IIk=
X-Gm-Message-State: AOJu0YwbFxMDprYuus6YDeKRwlFBlILTW5IHnnledXVA0apwMCsBkEWu
 iU6OpNjcoeMj3kOSmyVYyVkeKLoYDJ1o7m4Rfb3sik89+h9DiRf8JafmcGqnvWw=
X-Google-Smtp-Source: AGHT+IEwSyJ6LOCq1i1vSDF3lWs5x0EHv0tx/E9WfExj8AXYDq4eWBxvY1fI7YX4rmNxo4Lq9H7oIw==
X-Received: by 2002:a05:6870:e09:b0:22a:4f07:13cc with SMTP id
 mp9-20020a0568700e0900b0022a4f0713ccmr8404864oab.33.1713076603639; 
 Sat, 13 Apr 2024 23:36:43 -0700 (PDT)
Received: from [157.82.206.17] ([157.82.206.17])
 by smtp.gmail.com with ESMTPSA id
 t8-20020aa78f88000000b006e7243bbd35sm5392155pfs.172.2024.04.13.23.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Apr 2024 23:36:43 -0700 (PDT)
Message-ID: <55167bc1-da2e-4b9c-b7db-b592f05707df@daynix.com>
Date: Sun, 14 Apr 2024 15:36:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 17/20] ebpf: Fix RSS error handling
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
 <20240403-rss-v9-17-c6d87e69d38b@daynix.com>
 <CAOEp5Odc3aTY8vAgmWwxp7aBkUYQ4H6mpoN4Xv2y2gNpC-JoFg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5Odc3aTY8vAgmWwxp7aBkUYQ4H6mpoN4Xv2y2gNpC-JoFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::33;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/04/13 21:16, Yuri Benditovich wrote:
> On Wed, Apr 3, 2024 at 2:12 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> calculate_rss_hash() was using hash value 0 to tell if it calculated
>> a hash, but the hash value may be 0 on a rare occasion. Have a
>> distinct bool value for correctness.
> 
> This is interesting question whether in reality the hash value might
> be 0 or not.
> On one hand - this seems like a kind of fix.
> On another hard - this adds computation cycles for each packet, and the
> corner case that this targets to fix seems hardly reachable if at all.
> Optimistic estimation is 2.5*10^-8 percent of address:address:port triplets.
> I would suggest at least to find some proof of the fact that the calculated
> hash might be 0 in real case where source addresses are not random.

Your estimation, which suggests the low probability of error, and the 
fact that an error in RSS is not fatal and only regresses the 
performance, should be sufficient to determine how this patch should be 
handled; this patch is nice to have, but is not worth to backport to 
stable or to merge before the 9.0 release.

Regards,
Akihiko Odaki

