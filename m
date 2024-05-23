Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD8EC25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 02:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9xmz-0007Fp-R3; Wed, 22 May 2024 22:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9xmy-0007FZ-5j
 for qemu-devel@nongnu.org; Wed, 22 May 2024 22:02:40 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9xmw-00042b-Ew
 for qemu-devel@nongnu.org; Wed, 22 May 2024 22:02:39 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f467fb2e66so3073743b3a.1
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 19:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716429757; x=1717034557; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0x7h5g4EFJY46ID01FqLN/0B4mB076BSJJPAvLRoiEc=;
 b=a/XoRyTY8i6ugX2FJ5+lCK9fky438Cv+DXBN+DlGz0gbWnd66bNMqt1j+qDLSDZTND
 7NziySQGUS9/VmLhFj/pUR1qia0upXrWmzcBzcU/PeBB4Fz5InEmff8uxCywAropNS/z
 xc+WWN16oMp4sUui4rJ6N3ul4VhMomNX7CXNjIKVbTONb/GOx2W82khGlnnkJs5yoMny
 Z1hBnR7BuKKoYGRyCUf/y4Huuhn5ND4eqW0heza6KTb2YNK6czm7VJOyu6STW1u4wE18
 gsSXo/gWSEwRFHTpQfAVRW5yq4T2hWcKNblayUDK3eaVBBNOMDclcrbHsojHs1gZJBps
 Ie9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716429757; x=1717034557;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0x7h5g4EFJY46ID01FqLN/0B4mB076BSJJPAvLRoiEc=;
 b=iO9ccuoRwF5iTVjtdUObe0FuF1D5l9p++8Tny4XJ4Su+ICqbMAV/2+S3ncVE3HVgfX
 5lx4HjmIGoef40t5H8tmX988TxgK2THwZptEwoYBsIfiEXblx/nyFgzZmrFKFGTEH46g
 /6em1Im1oIVm4K/3MH475EIXw2Kj9iG3qVulSG4DO7nVKi16hLuEIXfqlQsiKULBhIYW
 mctmP0Yjh6sWirz+08bbNkvAQKyCZ17DrVtnrjHRFIUR0EbGfPQ9Uqypgt/PEcXKhQJF
 9RNeGnq5L8TNgCZ9mfd5TnsTgzEOjqUa42dg0dgbW5ga6VH9q9yJSmrPiBQEQZjPOp4o
 Kcmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+whi18KCV+5zirvES6vrlQ1EXQ2pziExvDQUzB6UYGIilDRE4ZWPBAo1NZCrstHUAk2UazaKPEsbaiYsnu9C0GzQrVek=
X-Gm-Message-State: AOJu0YwShMXQqWOJ6wMwZAmSl1VGwCci0jdLrqU7O8Zr5G2yVDWkyoRT
 mELm9Zae9E/7TyL7geeWfWdrCtO318PUFoBTlY//gN/pvxOoWzeNCNB8/CQsJpz73zqtSsevv8c
 O
X-Google-Smtp-Source: AGHT+IG9G8lsqePGd0mAJ89Wq2k7m+AUu2BWA4Gl4LsmOiHMDoG71ZFkjy2IkkBvQk5shybAwQWg5w==
X-Received: by 2002:a05:6a20:d80b:b0:1b0:1025:2f5 with SMTP id
 adf61e73a8af0-1b1f84e0c88mr4345005637.0.1716429756775; 
 Wed, 22 May 2024 19:02:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bdd9f21b9asm450187a91.41.2024.05.22.19.02.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 May 2024 19:02:36 -0700 (PDT)
Message-ID: <1d478dda-fb1f-4b4f-aa08-d0e4b85c5050@linaro.org>
Date: Wed, 22 May 2024 19:02:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] Migration patches for 2024-05-22
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20240522222034.4001-1-farosas@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240522222034.4001-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 5/22/24 15:20, Fabiano Rosas wrote:
> The following changes since commit 01782d6b294f95bcde334386f0aaac593cd28c0d:
> 
>    Merge tag 'hw-misc-20240517' ofhttps://github.com/philmd/qemu  into staging (2024-05-18 11:49:01 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/farosas/qemu.git  tags/migration-20240522-pull-request
> 
> for you to fetch changes up to 8f023a0bd946bb0c122543c64fe2b34bad0dd048:
> 
>    tests/qtest/migration-test: Fix the check for a successful run of analyze-migration.py (2024-05-22 17:34:41 -0300)
> 
> ----------------------------------------------------------------
> Migration pull request
> 
> - Li Zhijian's COLO minor fixes
> - Marc-André's virtio-gpu fix
> - Fiona's virtio-net USO fix
> - A couple of migration-test fixes from Thomas

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


