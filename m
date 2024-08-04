Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92476C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 21:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saj25-0004wf-DK; Sun, 04 Aug 2024 17:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saj23-0004w8-9d
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:44:51 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saj21-0004AE-Hh
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:44:51 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7093d565310so8123300a34.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722807888; x=1723412688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GkZuqKMpffW2rN6hnGfO4Sor8puJN9jsiGe1b+cHRMY=;
 b=INJwx5drExYHXUboFW6vemQmiV8/e7ePGqRTE4Rwj/p63UfJPW2Ri2yQLFXKyFEhPr
 o266gfHTM2dEl7XhSu7vwzh/UjDsd32psprwgV5RSSXook7oGYawmoOz8jqCq76pT4G9
 FkxwJsIBNrislku/k1HJq77g4cFeKWKQ9W1iwEmlRWluxRqMG4WBKAOZ3WXhPxgKb3zV
 EY6uNAmqz5cQjNIsQF3K1I2ohzGeWLcdk4KmuENDt9uCS1Zr3lQpukTWU8iYQO7+K0bE
 foLQZG23ApNIpphTldMCQqbj9yltCRVJ5SoPEEHcyG8pSZLNLnUYBrb8k6se+K10qNIb
 20VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722807888; x=1723412688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GkZuqKMpffW2rN6hnGfO4Sor8puJN9jsiGe1b+cHRMY=;
 b=p8knc39zVhPWBASFA3AMdl21TL5YZ50nvoqbwzpKt+HHeg1Cb6RIuSY4K6O+EoDcPI
 vS1ztVGjx6c7Tx6AXMj4BzafkhC5mfH6VXblxxEWhuiDy9DRDZnnVtXvWoievxsNWuTF
 1fOO8SyoOBhaC4SY+HHE1Ui270PDikgxGJxYmU74V7Fv48wuF7e81mld/6fyrFaFm4Sk
 Azl/oyPrACJ9PwZt6rFs8XBs6l5j3eK/QIid1W6W3mLU1mcOt+f66gVCuDeFO5XfXhfZ
 PQvyUa3F2cRkE8ZnPXiFVIsOC6d1jOx9sSaGGaC5Ij6a/JFiixfweDOoQ5iGJihPox2Z
 ze8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe3LwfIDHhDXHasptOH7EVd178nhipCb2nuegJw+pYqeWBixufeb+QAzvIkD9NApxIlm/wYKhYTOVLFkDAnw3dU9Xg7l4=
X-Gm-Message-State: AOJu0YxNRsXy56fc1WAwASyB/QNUDTKZzM6oPf4t4Lm1FCgxJBfddm9A
 akRr76PS8ujWATFtIXdrHDKeiidqYCMohQwggK/fTNJGOccbUZNsPp+ekBb6q6s=
X-Google-Smtp-Source: AGHT+IFg0DYDr1DVKPkmJohpyNjqT0wKpFK4xv/krJMzrXDNuAJ0aFa+ct/0y9q/cPH1p2JDr5k8HQ==
X-Received: by 2002:a05:6830:6dc5:b0:703:6311:7798 with SMTP id
 46e09a7af769-709aa00b761mr15696328a34.5.1722807888047; 
 Sun, 04 Aug 2024 14:44:48 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cffb091a99sm5613754a91.21.2024.08.04.14.44.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 14:44:47 -0700 (PDT)
Message-ID: <32fa8fc3-6554-465f-9208-236016f76fd0@linaro.org>
Date: Mon, 5 Aug 2024 07:44:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] bsd-user: Define validate_prot_to_pageflags and use
 in mprotect
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
 <20240802235617.7971-17-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802235617.7971-17-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

On 8/3/24 09:56, Warner Losh wrote:
> Define validate_prot_to_pageflags. Use it in target_mprotect to validate
> the flags. Our taraget_mmap needs more work before it can be used there,
> do don't copy linux-user's use of it there. This should hvae no net
> functional change, but does make target_mprotect more similar to
> linux-user's.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/mmap.c | 28 +++++++++++++++++++++++-----
>   1 file changed, 23 insertions(+), 5 deletions(-)

> +/*
> + * Validate target prot bitmask.
> + * Return the prot bitmask for the host in *HOST_PROT.
> + * Return 0 if the target prot bitmask is invalid, otherwise
> + * the internal qemu page_flags (which will include PAGE_VALID).
> + */
> +static int validate_prot_to_pageflags(int prot)
> +{
> +    int valid = PROT_READ | PROT_WRITE | PROT_EXEC;
> +    int page_flags = (prot & PAGE_RWX) | PAGE_VALID;
> +
> +    return prot & ~valid ? 0 : page_flags;
> +}

Comment still refers to @host_prot, which you removed.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

