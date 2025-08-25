Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739DFCA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 10:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqUSn-0000J7-EN; Mon, 25 Aug 2025 06:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqUSZ-0000HD-Ab
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:29:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqUSV-00061E-1q
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756117787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VKQJLAbYVYWf911JTqlSSntFq1pIoSJJRgvHa6rLgv0=;
 b=FnPNtJTJn0VEAm18brmGSOF8Wh2vKPlz4DXJEVG7JZqzRygBQnbiJvU21YiBasvCeqIW/6
 tvO4V1Z+EPvOcJu0NuJjtmMMnMK7UG30REw17j4gw/lgrteiGU9aUw52wfMjjGgxP/LBTh
 Gx6GVtHEyRRcxE6y4ziLRejR7OXYk3Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-i9h93q1jMBSpOjG8KOZXyA-1; Mon, 25 Aug 2025 06:29:45 -0400
X-MC-Unique: i9h93q1jMBSpOjG8KOZXyA-1
X-Mimecast-MFC-AGG-ID: i9h93q1jMBSpOjG8KOZXyA_1756117784
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45a1b05d251so24055915e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 03:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756117784; x=1756722584;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VKQJLAbYVYWf911JTqlSSntFq1pIoSJJRgvHa6rLgv0=;
 b=wWZIf1jSXsffYiAGuRZGBDMZ4vH2QyDeCh5eBcRI0/C8KVG3yKvekHcjeAp/qNl7tu
 /YkD0fMTQ1UhF1y82wGQ2yt11wQqmV0ux4DEV4/yWwYFynIx5j52CM19+1N/5AIBILnd
 O0yCFche0YlojtWwPNJQWSEImF+Vpgs36GZ1TC8pAB912/AtRHQzbTICqjt3hSIiwk1o
 Txdyr5/J6q5YIP63byCmAbrw4//3TSFTPTwlF8YI3qpFxUD6edSMy7UcWzMyoAMIOv2I
 Lu6zlTWFfg2wGQau2kvmRRhrnNpqWNdCCgiT8cMMVi6ZEikfdQuIdyZ7O24qtTtML+je
 ceEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0YR9iA3btH/1FZLxWfa0tiIJ6MIvptsXrG7OnYIMQSub15jXuoZ02wEhzmIy7epiqRAKO416s/vhB@nongnu.org
X-Gm-Message-State: AOJu0Yzme+xsbCfyuizhZWrURtM0pB61iZ5RlKmhadTFAjGeptfEhOdi
 npI8qJRKoUuD5TNrUc1FXoyymhp8hvJp3LJCoS6f2ok1y5zMVdjKkwI5oNETduoWRHimx7NqUKC
 huGySsw8pr3NUyg1tS5nhADDX1tRQWU3wRc3JwUYEWhjUz6KWl3Oggjvb
X-Gm-Gg: ASbGncvQ9VnaZVYNXzONcdIKubgAd3F9lnVifC1Y8XIwLnNvd8awJ14pm+g6j2Kx40e
 BOPUL9ssG+wBPDJL1cNXNf/zG9Ye8aBsf/8+N176bzGR9QdDDCCYzxzvh5rqB4Yo7xnaVBk34U2
 QEX9MHiJRpNpbPtQx/ER8JNTMF7jczQo4YWIv0rY/RIuKxIMVOAdwMv8rU52qiLua4OsT20okoT
 W/QLnUMSbWgJDPEdkQstsoazM6AJdOnmPCGEyyGd+YeAL3pMAbSLUJ/YBLl6GrQ0Wu8/25ng25x
 e6zkZQaKzpgTF72ca6MFesYyHyLl33lhzZWoGu/6elglwM5jh6Uz1emRkjNPV+3BHXiVSzUlt3C
 zt8A=
X-Received: by 2002:a05:600c:b8d:b0:456:496:2100 with SMTP id
 5b1f17b1804b1-45b517c2e4emr127307825e9.31.1756117784182; 
 Mon, 25 Aug 2025 03:29:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+7UC6le9Nb78uKFp9+/xdKTyWFU7IIRjTBcVcXD3hz2EVYZnlifI8UjT3p2Rs5Ijvi8/QpQ==
X-Received: by 2002:a05:600c:b8d:b0:456:496:2100 with SMTP id
 5b1f17b1804b1-45b517c2e4emr127307595e9.31.1756117783721; 
 Mon, 25 Aug 2025 03:29:43 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-112-084.pools.arcor-ip.net.
 [47.64.112.84]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57492d32sm104040415e9.21.2025.08.25.03.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 03:29:43 -0700 (PDT)
Message-ID: <53b6e23f-5328-42c6-9c58-97ddbf3e5b29@redhat.com>
Date: Mon, 25 Aug 2025 12:29:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tests/functional: Adapt reverse_debugging to run w/o
 Avocado
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-arm@nongnu.org, 1844144@gmail.com, Jan Richter <jarichte@redhat.com>
References: <20250819143916.4138035-1-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250819143916.4138035-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 19/08/2025 16.39, Gustavo Romero wrote:
> The goal of this series is to remove Avocado as a dependency for running
> the reverse_debugging functional test.
> 
> This test, the last one I’m aware of that relies on Avocado, requires it
> because of the need for GDB to test reverse stepping and continue.

  Hi!

Please note that there are currently also some efforts going on to extract 
the GDB part from avocado into a more self-contained python module called 
aautils, which might help here, too:

  https://github.com/avocado-framework/aautils/issues/82

> In this series, we leveraged the run-test.py script used in the
> check-tcg tests, making it a GDB runner capable of calling a test script
> without spawning any VMs. In this configuration, the test script can
> manage the VMs and also import gdb from the test script, making the
> Python GDB API available inside the functional test.
> 
> The test is kept “skipped” for aarch64, ppc64, and x86_64, so it is
> necessary to set QEMU_TEST_FLAKY_TESTS=1 in the test environment to
> effectively run the test on these archs.
> 
> On aarch64, the test is flaky, but there is a fix that I’ve tested while
> writing this series [0] that resolves it. On ppc64 and x86_64, the test
> always fails: on ppc64, GDB gets a bogus PC, and on x86_64, the last
> part of the test (reverse-continue) does not hit the last executed PC
> (as it should) but instead jumps to the beginning of the code (fist PC
> in forward order).

At least the x86 test used to work for me most of the time, it just fails 
occasionally. Same for the ppc64 test if I disable the powernv subtest there.

> Thus, to run the reverse_debugging test effectively on aarch64:
> 
> $ export QEMU_TEST_FLAKY_TESTS=1
> $ make check-functional

I gave it a try, but this did not work for me, the test was not run at all 
anymore. Are there any patches needed on top?

Anyway, shifting to a different test harness here makes me wonder whether 
the whole reverse_debug test should maybe be rather moved to tests/tcg 
instead, where we already have the basic support for the stuff from 
tests/guest-debug/ ?
The aarch64 would require a different guest payload, of course, in that 
case, so not sure whether it's feasible?

  Thomas


