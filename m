Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD9DC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 06:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHH4f-0006q7-9N; Wed, 12 Jun 2024 02:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHH4d-0006pW-Dr
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 02:03:07 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHH4b-0008N0-Mi
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 02:03:07 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ebdfe261f9so49336791fa.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 23:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718172184; x=1718776984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+WZJ0zbGQ9rPRWIgjD7uEcrT9KcXmkhz2RNKTxF8QTk=;
 b=XkiFr9EjkKRf4MG3I3+sMmP30l6uwVd+Nhl5Ub6sMSdnTWt/ce+ZFZ2g27k7iia9NK
 uQCC3eZsbbxt2FQpDN8V+Hh719ocOOlKZLW6du9e+HNogf3gnum12/OHituIX++Y8xRH
 yGqG9ZGroH4dc9dgWWQW2L+8i7uotdv51InO97i2ReYJFljWz3w7PAFzUTpi0dG6k6v7
 /gTBFuuuv7eMlPNlR4YxsWukbGLdFFkBXNvyLwt2JX+BoyWekSLkZXd3G5YE4SZZ+Ux4
 Bk5BApD4ykuE3iI3pW65udTp8Ak+B5gTkfkgT/3Fkq4Q+5DOGbN3vHaaPrlbL+ZGhxm0
 2hIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718172184; x=1718776984;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+WZJ0zbGQ9rPRWIgjD7uEcrT9KcXmkhz2RNKTxF8QTk=;
 b=qV+F8+IbBSA5TX6Jnhmkh2EhD7DLrZvj1Sdh/VR0aztI/JUHHi7nCXxLH1faPPS2nk
 XhgNoymbRzyCHq6FKKfEi/rEgj3GD/8Aku3CkY+ntF1zw8TO9IDhlWes+sJZcYa3HQ6t
 bJg1uB76w3oI8ii96IqDNjuTrwrVjuwnTDc5G7IHDYEr4iVM8XLlkwTSmwrvdPzfEuhr
 xvLQRU2LMhocZzqZ9Vr7W97TDAsO2zDo/hac/GdRogJ74SRAQzY9tYCNF7u/PenYPhkB
 qmWgAy1CxSOCbPKpsCxT8GgsmDmCJQtw20YuSafYjuc8AV+Qv4vXQXpJMcK3wdC8Lreh
 L0cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq5C/qNHUj5fs8DdYm3Wo2O4Vw0p1eVXLT4WlAWeXRLSEt/89uGwzTkjwQD7RwTIoLQDfN45Xe97D65eotnF14s9qBsXE=
X-Gm-Message-State: AOJu0YwaP+tU5B/sVerypuW2TCaso8eZSl5O6V94im8w+rQ5h3fxJZVy
 o1oNZZYQ3Az9B8GfxsROa+++UODvP586GXIVuPDFoq7c1Df2x3+Wcss0VX+i5tM=
X-Google-Smtp-Source: AGHT+IHQFwyR+oWFMqCciBrG6Sb/nPhAsuzdeR6lZPM0nKGQtIHvgkPY+3N3nUF9HxvlunZ8ffTICg==
X-Received: by 2002:a2e:bc0a:0:b0:2eb:fcf2:f7c9 with SMTP id
 38308e7fff4ca-2ebfcf2f958mr5753131fa.3.1718172183723; 
 Tue, 11 Jun 2024 23:03:03 -0700 (PDT)
Received: from meli-email.org (adsl-33.37.6.162.tellas.gr. [37.6.162.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f254fb3c2sm6897833f8f.49.2024.06.11.23.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 23:03:03 -0700 (PDT)
Date: Wed, 12 Jun 2024 09:01:01 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Madeeha Javed <javed@igalia.com>
Subject: Re: [PATCH] scripts/qcow2-to-stdout.py: Add script to write qcow2
 images to stdout
User-Agent: meli 0.8.6
References: <20240610144708.81351-1-berto@igalia.com>
In-Reply-To: <20240610144708.81351-1-berto@igalia.com>
Message-ID: <eye51.7m7tedycfrgc@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x235.google.com
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

Hello Alberto,

On Mon, 10 Jun 2024 17:47, Alberto Garcia <berto@igalia.com> wrote:
>This tool converts a disk image to qcow2, writing the result directly
>to stdout. This can be used for example to send the generated file
>over the network.
>
>This is equivalent to using qemu-img to convert a file to qcow2 and
>then writing the result to stdout, with the difference that this tool
>does not need to create this temporary qcow2 file and therefore does
>not need any additional disk space.


Can you expand on this a little bit? Would modifying qemu-img to write 
to stdout if given, say, - instead of a file output path be enough to 
make this script unnecessary?


>The input file is read twice. The first pass is used to determine
>which clusters contain non-zero data and that information is used to
>create the qcow2 header, refcount table and blocks, and L1 and L2
>tables. After all that metadata is created then the second pass is
>used to write the guest data.
>
>By default qcow2-to-stdout.py expects the input to be a raw file, but
>if qemu-storage-daemon is available then it can also be used to read
>images in other formats. Alternatively the user can also run qemu-ndb
>or qemu-storage-daemon manually instead.
>
>Signed-off-by: Alberto Garcia <berto@igalia.com>
>Signed-off-by: Madeeha Javed <javed@igalia.com>
>---

