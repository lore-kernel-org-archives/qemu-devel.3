Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB2CD637A8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 19:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJEZ-0004Mg-SU; Wed, 13 Nov 2024 14:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBJEY-0004ME-8O
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:40:58 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBJEW-0002Vs-52
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:40:58 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43168d9c6c9so63224305e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 11:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731526854; x=1732131654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uNDZQ0n6ZRKfzFleqMZOBaj/TiXqsy/X5FWoD3PZyc8=;
 b=DFdqdP7RMBYT/FWye/oTrW+AyEDbvOz4tr95aqGQ3j7ObomsT9E1/werPyu4N2KGsp
 JRelcJ5zr76eYPl4KzVoPrMYG7X0Aa+rJkyMjFSvhgor/odgsrwupIDpxrPmgW9k4mkL
 4zxRGmAYe74J7gZU4c2TS26eDAqvi5YzkHzDbcBLlrC/tI07QBarRCsvHtqKsYVAGgAL
 zHc0AKCuoOo9HUiLXu2GHJOBJcN5jfaHznZ7W2sFWnmJnrDrvGPEMup/ra0e24nQ82BD
 y4NW/t+PeZ01jD1E10HISSRkWfTb4ISt6ijZKGFgIuS7HWaRRO7pVuhX9C+OkeXVXIUR
 ATtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731526854; x=1732131654;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uNDZQ0n6ZRKfzFleqMZOBaj/TiXqsy/X5FWoD3PZyc8=;
 b=mIyzXG1YLZSG/0ozirauALBDllPXU0L8Hni3ONtmWnkvoDU+C+/XSLhIrYy/VlqYuY
 7Lh9LxNO2hVdQRNh7gqvzD3H98jLyrcyPnZ66CH8e3BOLswhFx2jxa5+fi5JH5PEKy59
 fLXHV8pEBQ9wJ/ucVUxVkoUn5oh49/WdwcHQEEPucyrPlJ3CoKmFwHln93APgtjM0U1H
 SJUppIfQhMNSs8ynN4TvBbnPKdQ2kCp45P7myPbqh5Kk6DZ34Eil7Hj5FcE5/NTSN15g
 nqecykmKETIt7MOsPQHhrTYCEQetXzU8fhl6NzI5J+nkC571hTJCpdP1tIcOvzwN9cWC
 LE3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnnQnZhhzH52hmW9g4VK3fMPl6HcCKbTFH25YjIOMXfkPkEu3DEPUkeqmLc1/kxyK29x18ZRtoXcgl@nongnu.org
X-Gm-Message-State: AOJu0Yy8AbZ9vjEaiylaVM/xLyiQzHV90D8izdjnwxsMwgr31dFOVYEc
 zHm1n5biOIUdjO4SMvThjgrZmrn1N2k1VH+V7jPV5cQkj34vfUKKDqTIDy9ku+c=
X-Google-Smtp-Source: AGHT+IHmLMEPgJYxvXB+gjAwAQjB0hheoIUXw1UgTDzdYH8LBJDewlLkVlV4P3ppL7kqIMHkAhiAuA==
X-Received: by 2002:a05:600c:4f04:b0:42e:d4a2:ce67 with SMTP id
 5b1f17b1804b1-432b7505d19mr206435235e9.17.1731526854495; 
 Wed, 13 Nov 2024 11:40:54 -0800 (PST)
Received: from [192.168.69.126] ([176.187.209.238])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97db25sm19312273f8f.41.2024.11.13.11.40.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 11:40:53 -0800 (PST)
Message-ID: <0d1f8f1d-2894-4753-aeef-1a229a71a334@linaro.org>
Date: Wed, 13 Nov 2024 20:40:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuzz: disable tcg for OSS-Fuzz builds
To: Alexander Bulekov <alxndr@bu.edu>, Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20241113163800.355547-1-alxndr@bu.edu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241113163800.355547-1-alxndr@bu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 13/11/24 16:37, Alexander Bulekov wrote:
> OSS-Fuzz builds have been failing due to some strange issues that seem
> to be related to color codes from libffi:
> https://oss-fuzz-build-logs.storage.googleapis.com/log-8d5435ee-1677-40af-9656-b4162fa881e1.txt
> 
> Disable tcg to disable libffi.
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>   scripts/oss-fuzz/build.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> index 7398298173..095f7a90e3 100755
> --- a/scripts/oss-fuzz/build.sh
> +++ b/scripts/oss-fuzz/build.sh
> @@ -65,7 +65,7 @@ mkdir -p "$DEST_DIR/lib/"  # Copy the shared libraries here
>   # Build once to get the list of dynamic lib paths, and copy them over
>   ../configure --disable-werror --cc="$CC" --cxx="$CXX" --enable-fuzzing \
>       --prefix="/opt/qemu-oss-fuzz" \
> -    --extra-cflags="$EXTRA_CFLAGS" --target-list="i386-softmmu"
> +    --extra-cflags="$EXTRA_CFLAGS" --target-list="i386-softmmu" --disable-tcg

IIUC we are using the QTest 'software [un]accelerator' to fuzz via I/O,
right?
Then maybe we can disable all accelerators to speed up build. But please
mention it in the commit description.

Regards,

Phil.

