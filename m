Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCD0C4829F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZywq-0000fA-Vm; Tue, 13 Feb 2024 15:00:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZywn-0000e9-Do
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:06 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZywk-0001Pv-UB
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:04 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6e0f4e3bc59so1063239b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 12:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707854401; x=1708459201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=guDiieTxUSfqv0dor9zh+qiMUo0IwxhxquIa8D5c0tI=;
 b=JHlKL2OGXMwR7KZ8hpMUxYaq/1n2PQH66zRszw1tHy+GMYyDXhndlmy+sZic3LJlbq
 sm4CH67L6pgMLq+mq09lThpSs0UpXy+93sG+BVx90is1d4X60IWnCMqFQOmLm18YslQp
 wb+fZWGsmVIseNNveGxaly84BLA7s/0rAW0/vB0PQRo07lSYRrzJhPjDGNdHRCcx54jC
 k0Z/PELNc6GdUB/L80qacbio2Ig9JylAFjUATwRjvYvSrhE70heKnG9I9erlcIFAmO/e
 1Snu+Kn20H7hf/QfeDfIrCaBhGo/Dq4UuorpRadhSsjl3CLUYmLTTaRw2+wIQPos4upu
 6vqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707854401; x=1708459201;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=guDiieTxUSfqv0dor9zh+qiMUo0IwxhxquIa8D5c0tI=;
 b=Z7IVZFTr9/XR5DChQ/MA6VuVr5QnBqrJDRqU9IqXrE0F+ESuJvXl6TzsXYUuO8eVD+
 MDuIvZxRZv6kh+myW+QRomIox0LIUndkMUQ1RjFcmiz01X7iWXyamS3VaNhoVNh4KL/H
 3fCDNqohmtHjhEX5qyPj9ItN01gpdg+YGyWaZ5NztZ5w3TEYCkflgrq0YurZkUVoNLYd
 EkabK4btBE/hs3KYBF9Fpxrlsd8znEOpXkZIaQ9SwhmSG+6QRvLUvZUkIVakDw4i8bu5
 hIh/T8jU4td48qiMFmjmHgySGAdbhq7ba7CjM2GiP7B210HOGgKri99vBIvm2WQtIZ6v
 Ka8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsm2cKpGpSbUsUH3IJ10X8EFVifhW71f4XYoW1z6OcVnAN4I/nnzUvfLYyohzi6TACezeJdM552bqnsP1P96IBQz49xWU=
X-Gm-Message-State: AOJu0YwP9Zzkn6NrSxn6EYTPLGrJMsSTwi1ob9vszed6ytbTF0i9yizF
 RH+yR9SgOD+qeDMJOvn/gRRKt9RTQHAJTCN3JAedpkM70aHJsFJjlpYx090lR/jEoYVryyWbfpo
 P
X-Google-Smtp-Source: AGHT+IFI+S/5tZHovjB/srZ5SSYjuEm1febPSWQT0lfKw4Q/Xkr+1hHFY9mdHn+6HHZ1jnVXXOabDw==
X-Received: by 2002:a05:6a20:e586:b0:19c:972d:3e9 with SMTP id
 ng6-20020a056a20e58600b0019c972d03e9mr576935pzb.48.1707854401190; 
 Tue, 13 Feb 2024 12:00:01 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXFV6I3cWRWgmgT8H9isuN4DvpcHWJ27rCr7tSu82VOinQBMVGZg9kqpdD4rjVRGIjsFWC9nIay6MJRtU5tUfLr4UOW0vo=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 b7-20020a62cf07000000b006e037ce7cb8sm8185585pfg.0.2024.02.13.12.00.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 12:00:00 -0800 (PST)
Message-ID: <94a93713-33a0-4808-8d41-cd0365beb0bc@linaro.org>
Date: Tue, 13 Feb 2024 09:59:58 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/33] linux-user: Split out mmap_h_lt_g
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-23-richard.henderson@linaro.org>
 <ogglz7yhvelvrnmfyhvpx7hjdl5rgl5gh3iioomtagi3mlckcd@qaa6w4javinb>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ogglz7yhvelvrnmfyhvpx7hjdl5rgl5gh3iioomtagi3mlckcd@qaa6w4javinb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 1/29/24 05:26, Ilya Leoshkevich wrote:
> On Tue, Jan 02, 2024 at 12:57:57PM +1100, Richard Henderson wrote:
>> Work much harder to get alignment and mapping beyond the end
>> of the file correct.  Both of which are excercised by our
>> test-mmap for alpha (8k pages) on any 4k page host.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/mmap.c | 156 +++++++++++++++++++++++++++++++++++++---------
>>   1 file changed, 125 insertions(+), 31 deletions(-)
> 
> [...]
> 
>> +        if (fileend_adj) {
>> +            void *t = mmap(p, len - fileend_adj, host_prot,
>> +                           (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED,
>> +                           fd, offset);
>> +            assert(t != MAP_FAILED);
> 
> Is it possible to recover here? Of course, we are remapping the memory
> we've mapped a few lines earlier, but asserting the syscall result
> looks a bit odd.

This first one we cannot recover from, because we've already (potentially) overwritten the 
previous memory mapping.

>> +        if (!(flags & MAP_ANONYMOUS)) {
>> +            void *t = mmap(p, len - fileend_adj, host_prot,
>> +                           flags | MAP_FIXED, fd, offset);
>> +            assert(t != MAP_FAILED);
> 
> Same here.

This one we could, because the memory was previously unmapped.


r~

