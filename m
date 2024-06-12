Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE6BC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 11:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHM7M-0000uC-96; Wed, 12 Jun 2024 07:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHM7L-0000sx-7f
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:26:15 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHM7J-0007LL-J7
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:26:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42121d27861so56811945e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 04:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718191572; x=1718796372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=L8pc7m38cemVR3cNvvaLhXXHuPXIWAzk05wEHMQjZ8U=;
 b=XIg8pVEH4qExN+zILewhTymO3QeOn6JSH52dzX/FHmcDYARwSO/743vYc5GH56zYpS
 +8ekznmtTTHSY6Xt82Ryzb7E6gikqyIFkM+IHiKLy3pJl6OjlQx5RbOZlVUorhCXL3qF
 D17V/mwj0ARWznL2Vrg8OGSNzxPOUWM0AGkjmc1Gr4Zhvo9Kmll5wFk271wXGy9smfW2
 9MdQMu1saMe+Q1zY2VRqO5q/vfHhn6zTA+BBe2deKqcXicI2oZMH4exBjyBZGuqJY/XQ
 zqqqOC5A13TEHlEgGk571giV7cu5Mpk1jMnYfP2k5zzF7uZLKRa/nhKEHZV5DOZCSkAS
 bEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718191572; x=1718796372;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L8pc7m38cemVR3cNvvaLhXXHuPXIWAzk05wEHMQjZ8U=;
 b=TU5/768JptdjEfGRuLQKWJ/1MGY7U+Ian4NImNnjso7JfcUMabsxPNzsx49mfz4T6f
 8oMHm4msb1fBzJvGKfUc9Wm+RBtsUANxUKxqcBd1qdhV6fwAVQXO8niVV3s5uriUhLC5
 K2/PZUE2rQHlejiOjb4GQvOJBAPpHfbiy8bsg8vdticvTE/bP/OmCG6zRZ8h0UhJ4hRe
 mbZaQ4E4wQpUpJ+mYzxPdwD0fiVMTud3J0TLQThY4LVGLsRxNbcW2DhhINdiV3iiOJzH
 om2wYWjCDQZCvIQfEHjrDtgHg7jdk7sKCJ3SYWE5S8Qk7DAQLNCwG5IqoDmUYQD0j6an
 BI/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYg+mAMTTLu29YjxA5ttp2w1cuTkzeKGMLsEt/EWdcKRAog/bLwZAZqlfGqbGbc41Oi7bn2xc6JRP2EZf+hoxo6zpBPgY=
X-Gm-Message-State: AOJu0YyyI2mrxtKkE8iYi3j6VzgXUxa2FZWgAvGtFXNS6z/VuAZudcoc
 59ZF6N1d+7/J85IB5LFh4K1WFrODn4YkIyNGS0BChDe9jeNHH8y8LtdKaWHcEZs=
X-Google-Smtp-Source: AGHT+IGOzTbZygtbZWPgwJdxR4YtIZ0FNcEtFnnJSjEP3tdUqdq7g1sjKHU0BKdcxNJCu2fBvMIJyg==
X-Received: by 2002:a05:600c:310f:b0:421:b79:93fd with SMTP id
 5b1f17b1804b1-422863b875amr12425695e9.21.1718191571909; 
 Wed, 12 Jun 2024 04:26:11 -0700 (PDT)
Received: from meli-email.org (adsl-33.37.6.162.tellas.gr. [37.6.162.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422871f8eb4sm22327355e9.39.2024.06.12.04.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 04:26:11 -0700 (PDT)
Date: Wed, 12 Jun 2024 14:25:20 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Madeeha Javed <javed@igalia.com>
Subject: Re: [PATCH] scripts/qcow2-to-stdout.py: Add script to write qcow2
 images to stdout
User-Agent: meli 0.8.6
References: <20240610144708.81351-1-berto@igalia.com>
 <eye51.7m7tedycfrgc@linaro.org> <w511q52ms83.fsf@igalia.com>
In-Reply-To: <w511q52ms83.fsf@igalia.com>
Message-ID: <eyt3m.ivfg6ce1i6n6@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
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

On Wed, 12 Jun 2024 12:21, Alberto Garcia <berto@igalia.com> wrote:
>On Wed 12 Jun 2024 09:01:01 AM +03, Manos Pitsidianakis wrote:
>> Hello Alberto,
>
>Hello Manos!
>
>> > This is equivalent to using qemu-img to convert a file to qcow2 and
>> > then writing the result to stdout, with the difference that this
>> > tool does not need to create this temporary qcow2 file and therefore
>> > does not need any additional disk space.
>>
>> Can you expand on this a little bit? Would modifying qemu-img to write
>> to stdout if given, say, - instead of a file output path be enough to
>> make this script unnecessary?
>
>Yes, it would be enough. Allowing qemu-img convert to write to stdout
>would indeed be very nice for the end user but it's a bit of a niche use
>case and it's also not a trivial task so I don't think that it's worth
>the effort. The output files that you pass to qemu-img convert need to
>be seekable because the only way to produce a qcow2 file without doing
>that is by precalculating all the metadata in advance before starting to
>write anything (that's why this script reads the input file twice).
>
>This is fundamentally different to what qemu-img convert does, which is
>to read the input file from start to finish and write it to the output
>file, relying on the relevant driver's existing write operations. All
>those assume random access to the output file.
>
>qemu-img is also much more generic in the sense that it supports many
>different output formats and image options.
>
>In contrast, writing the algorithm for a basic subset of qcow2 is quite
>simple and that's why I think that it makes sense to do it in a separate
>tool.
>
>Berto

Thanks for the complete explanation! It makes sense. Maybe add it to the 
commit message as well, it's informative.

Manos

