Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D51C27C65
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 18:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH6Yq-0005fL-Oh; Tue, 11 Jun 2024 14:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sH6Yn-0005eG-0L
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 14:49:34 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sH6Yj-0007hO-1K
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 14:49:32 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6a3652a732fso7065706d6.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1718131767; x=1718736567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FZ57A/ZCkfpV5yg2tmC7bKwUPtcUE0pmK9rMqbzMhZA=;
 b=I7jykxxmQSux89FmVRlg/9tWKfCDa8+uJmnaQ4u7GoNconlEf9nDhvfVt740PVruAW
 +N32z8t0LrSvr1uOR0cVsE8PLiqE6I4Y00wm6ZArnYT9yimUunYyMVh/f/jZ3i/kaAW0
 aFFY1wuYwEhjgu6/KCoaaqmpr/34P5CY+YqXyNA0WBHg+RYtb7d9VF/ys8nL2W63lO2a
 RMWa/wDtUk9P2SzE1+lbyhE5x2oTtVJr5Lro+8MHgvb/FHZy8BZS5SrQCJRmQE/NKmlv
 xIPuMMccd5by5a8CI9IP+jKkFxMYlTMSPPr71s9ZSSYVLWZa+AP1ERplLET5iCtpCeSv
 j5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131767; x=1718736567;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FZ57A/ZCkfpV5yg2tmC7bKwUPtcUE0pmK9rMqbzMhZA=;
 b=NYHR9+KIRvjGW+8aGIpfTnJIJ1Dnf2vJ26TXPfA+VdgVDTP2wz3QCNsii09zZFhGq8
 51PmXEPJJLaqjv080CXPv2dr0dNxR1D15tMk+iRI8Fia8/SAhCjdzzke9UbiBL+VXwqq
 guDFphNv8LE7T7YhHmK83wLJIxhYCXdbWM7kgwjsm4fFfEX/rgasYmk+uOEbIO3+zUjK
 FQaep8BiGZjUCfbfVlUnHTldbBGLd01DradjJowQvZZ0FDn2/ow77PAk/l8bcEHRemF9
 3GOCfzTo+iKKJiA0dKo48lRtG36xnUayZVb/a8SmDU96N1ixHaQwsuMmMSQR7AbLWn7t
 Sx/w==
X-Gm-Message-State: AOJu0YxYtPV3PdhFjXJc7MObckgXePRiu7aJDx7CQ12yxDe1nEEzk3ZT
 uzdzaJ6WBZvMg+oV2FjoTPoRpVAgdazRx0gwvWBsyiPgIcZKENTc5c+2giqiCyBJ3qFb0+VwaYV
 ovA==
X-Google-Smtp-Source: AGHT+IGLLEAUl9hcR4WwhIiPOTaf1vjXrmVzGifC4Tj2r/+7NaplXDTxdsuzgzTXqRQJuAfFtZEQzQ==
X-Received: by 2002:a05:6214:468c:b0:6b0:7fcf:36b8 with SMTP id
 6a1803df08f44-6b07fcf391bmr78025496d6.53.1718131766879; 
 Tue, 11 Jun 2024 11:49:26 -0700 (PDT)
Received: from [192.168.86.22] ([136.56.85.135])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b070a09166sm35565736d6.73.2024.06.11.11.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 11:49:26 -0700 (PDT)
Message-ID: <d19dfc20-a9ce-4ceb-adcb-8ef0648cd870@cs.unc.edu>
Date: Tue, 11 Jun 2024 14:49:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] Add an "info pg" command that prints the current
 page tables
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, peter.maydell@linaro.org,
 nadav.amit@gmail.com, richard.henderson@linaro.org, philmd@linaro.org
References: <20240606140253.2277760-1-porter@cs.unc.edu>
 <20240606140253.2277760-2-porter@cs.unc.edu> <ZmKzqB6k2p4OUwpN@redhat.com>
Content-Language: en-US
From: Don Porter <porter@cs.unc.edu>
In-Reply-To: <ZmKzqB6k2p4OUwpN@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=porter@cs.unc.edu; helo=mail-qv1-xf2a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/7/24 3:16 AM, Daniel P. Berrangé wrote:
> On Thu, Jun 06, 2024 at 10:02:48AM -0400, Don Porter wrote:
> Please don't add new HMP commands that don't have a QMP
> equivalent.
>
> This should be adding an 'x-query-pg' QMP command, which
> returns HumanReadableText, and then call that from the HMP
>
> There is guidance on this here:
>
>    https://www.qemu.org/docs/master/devel/writing-monitor-commands.html#writing-a-debugging-aid-returning-unstructured-text
>
> If you need more real examples, look at the various
> 'x-query-XXXX' commands in qapi/machine.json  and
> their impl.

Thank you both for the pointers.  This makes sense to me;
outputting a string is much cleaner.  Will implement in v4...

-dp


