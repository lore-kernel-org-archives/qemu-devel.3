Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5712C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTeXn-0007Tx-Eo; Tue, 16 Jul 2024 05:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTeXe-0007SN-9s
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:32:15 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTeXc-0005wQ-Fa
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:32:13 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3dab3b85623so1657406b6e.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 02:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721122331; x=1721727131;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0h7vEO93IdCSRgDAkWXmBz30RLWjKvU0Oa4UseQwWlc=;
 b=I6EHR60WeB08/2+UJ5uTxbTxDatIRd6fD01bnhCk6B6k9yg9gzTyUB6dRh+WT7BPyf
 /HCubGLZ5GrVONbzUBy6qoB9Cp+pFlahx2hLdqhwTEGUpiDqKwt3hWf3OWQL2Hi9BIEt
 sZJLJe38KWw0E4QZfiDsVSSylhwzVna0bXA1kDGSYVLy/IUjZSgcjw+7d3kSWAWucvka
 1fLlXTRUQ7mX2e9tw6NA3a2iE/wPDw+BnOjgp8I/NvadTDWdq/xxhYNyqQDaYvc1xILa
 WbujDpHTUuDpL0eoeg0pMfYmZI962Pv1se9B92DTH29C4sVaSSyb6MIyX5GQDtj+Mj/A
 rrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721122331; x=1721727131;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0h7vEO93IdCSRgDAkWXmBz30RLWjKvU0Oa4UseQwWlc=;
 b=N3Yd9B7p107Lf74R48XCS3Ezeoa01ryzpmHyy/WMUV0Ao1mhNREczPAKXqh9N/mUm0
 dXSz59lsSfnNwEeqxBxvdzgVvygQWiecH3KaIIq0fTYlakzvUzM5daeSzfiAAQzWLlVO
 jPrH1PfHmYsKtWdDihlfY0ejDj4T8wd8rtXhjIZnO8ZXpCJMI8Dad6qavyGv6fuVl+6d
 4IkkhN1a3Z/qoJlAlKxoqgSpkmHKbuWnsld8Kg5U5CTkTDL6VULU5TI7KKO7e8z+QHiY
 tAZ8yJWCQAlvSS7zamprcVrOxE1cvxaod7dc1+pgLzHriAOLVUwhcbyv2pqKonbxoggM
 2Ghw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGeDQcR5XKLl6nIo5gSWDnCax0qDV26rlUkHu/SzJzU/PVX6InQIdXI7KKV32BMiAo6WCKfpileq+1JhK9KM4d2A3eTCE=
X-Gm-Message-State: AOJu0YyVYXreR/z02FtKctVt/axXFaJp5WHgzT7z3RVh2E6cUjwclDTX
 ecwRkCBuJR0Y+E9lZhnrPCQu3fFE1eO5NWUClRvpG//5J3sGUGYEz+WzxRKyYRo=
X-Google-Smtp-Source: AGHT+IGs3zKFxOknL5dJxI4LghUcg8hvg1z69dlhCXcJh2Nyi4MGZnSIdYjuXJwm/6FD/Y9HGph4Wg==
X-Received: by 2002:a05:6808:1586:b0:3d5:1eba:10b5 with SMTP id
 5614622812f47-3dac7b81044mr2234126b6e.12.1721122331249; 
 Tue, 16 Jul 2024 02:32:11 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca8303sm6022623b3a.173.2024.07.16.02.32.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 02:32:10 -0700 (PDT)
Message-ID: <8498a828-cbc0-4f3d-9028-862f8372ebb3@daynix.com>
Date: Tue, 16 Jul 2024 18:32:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] util: Introduce qemu_get_runtime_dir()
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, virtio-fs@redhat.com,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>
References: <20240716-run-v4-0-5f7a29631168@daynix.com>
 <bca5bd94-d6af-450b-a023-0bbe57fdba3f@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <bca5bd94-d6af-450b-a023-0bbe57fdba3f@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::231;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x231.google.com
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

On 2024/07/16 17:06, Michael Tokarev wrote:
> 16.07.2024 10:27, Akihiko Odaki wrote:
>> qemu_get_runtime_dir() returns a dynamically allocated directory path
>> that is appropriate for storing runtime files. It corresponds to "run"
>> directory in Unix.
> 
> Since runtime dir is always used with a filename within, how about
> 
>    char *qemu_get_runtime_path(const char *filename)
> 
> which return RUNTIME_DIR/filename instead of just RUNTIME_DIR ?

I'm not sure. Such a function would be certainly useful, but I slightly 
feel such a function concerns with too many responsibilities. Getting a 
runtime directory is one responsibility, and how to use is another. They 
are clearly distinguished; it does not matter how the path to the 
runtime directory is used after acquiring it. For example, you can keep 
the path to the runtime directory, and derive the paths to two files in 
the directory.

I don't object to such a change, but I rather keep this series as is 
unless there is anything wrong else.

Regards,
Akihiko Odaki

