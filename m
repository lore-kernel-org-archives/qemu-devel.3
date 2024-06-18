Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CC7C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 04:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJQOT-0006Pl-5m; Tue, 18 Jun 2024 00:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJQOR-0006PJ-9k
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:24:27 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJQOP-0005qY-Oe
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:24:27 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-6e41550ae5bso3658791a12.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 21:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718684664; x=1719289464; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EatsKT8USxXAXsS9VZKV3NwWO7JRZltOJlHTCWs93as=;
 b=oK8IpuMUnn4L18V12/UkjzVnQdn3O3qwAESIKhYrhIf30kXxEjLsy+4YOCSA1BfO06
 uQRUK/Cc8ftoCrM3Tj1hyv5lyTFaj0eZfKKVZr5vURB35Q+zR500K94OLGwXdwRfFSuR
 GZPheVIMj/E1yUHzvjGWFdXrQymY4JJ6wD2V9sAAbh4Va8kGowjQufbshlsH7DugzPSy
 qDMce2DFiVQmqnprO+hCYfSk3EXvYDMXj0vqhdoyeQVN4mcsQYpUHi0YR+awdEFOpoI9
 n1+W9PUp3aJlZjXijgYacE1V7Dx17iMkxB797MffYGhqH+vAJTFnSUImCmNB4b0EL5G/
 8W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718684664; x=1719289464;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EatsKT8USxXAXsS9VZKV3NwWO7JRZltOJlHTCWs93as=;
 b=hKPLqyLyzWJq2wtcguDfbrbEttx84/9zQw3Swd8J9NMNP9QWTbDd7LJQCA+/CxJQtu
 0zaGgrOVF9Q7RTaAJopuDMDU8Yn/TA3X1qc62X/Q0DYLbCViyOGy6wC8bKIErwlDm+Eq
 K6KFfKu/2PZJ9xPL0GDzePwD1HlY9Y9+tAKKui4MU9ygMetOtQwspEFFQhVaFWcgshLE
 hOC4iy0MYLric7i0p8n/LXo9V7IBWIxJY/pBvLKaWq+XGhXP0pFv+qG8RoUws2OR0Lkn
 Jq7wutsQ8zUO3us7wF9aSvK5tOFod8E7iZvUH7MFcOlMxSiFKsO5hPs4rocVQ/DIN7Xr
 ZxRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN/e1niMW1Ffv4Zby+EmPPHqiuSTLpVB8AUVqmSWwkv2GraofYIdW8cJUoO1QChjqszawcgDXAI7lQQqDSms/I87Y8bi0=
X-Gm-Message-State: AOJu0YxqJ0Zod907G1n6hHiQp//xMEAnATVe04rBJxA+kLZej0Rbi4il
 3ci7CBN1Hqcv3Fwh7hX2vui0a99x/S39vCSep0X5NWxIR0DfQJ/84E9BFGf2zGc=
X-Google-Smtp-Source: AGHT+IHi4s87DXMudMGCN17QIWyn8oRj0CrhBeOlQ+0lm8ggZxE1rFed5LF0wufWnPe2W0eYlmFhiw==
X-Received: by 2002:a17:90a:b116:b0:2c2:c8b:f187 with SMTP id
 98e67ed59e1d1-2c4dbd3559fmr11109642a91.36.1718684664198; 
 Mon, 17 Jun 2024 21:24:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c4c45fa925sm9825128a91.29.2024.06.17.21.24.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 21:24:23 -0700 (PDT)
Message-ID: <3eed856e-51bf-4dd5-8665-60132adf01a3@linaro.org>
Date: Mon, 17 Jun 2024 21:24:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/23] Added CPU loop function
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@freebsd.org>,
 Sean Bruno <sbruno@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-3-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-3-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 6/17/24 11:57, Ajeet Singh wrote:
> +            /*
> +             * The carry bit is cleared for no error; set for error.
> +             * See arm64/arm64/vm_machdep.c cpu_set_syscall_retval()
> +             */
> +            pstate = pstate_read(env);
> +            if (ret >= 0) {
> +                pstate &= ~PSTATE_C;
> +                env->xregs[0] = ret;
> +            } else if (ret == -TARGET_ERESTART) {
> +                env->pc -= 4;
> +                break;
> +            } else if (ret != -TARGET_EJUSTRETURN) {
> +                pstate |= PSTATE_C;
> +                env->xregs[0] = -ret;
> +            }
> +            pstate_write(env, pstate);

No need for full pstate read/write:

     env->CF = {0,1};


> +            break;
> +
> +        case EXCP_INTERRUPT:
> +            /* Just indicate that signals should be handle ASAP. */
> +            break;
> +
> +        case EXCP_UDEF:
> +            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPN, env->pc);
> +            break;
> +
> +
> +        case EXCP_PREFETCH_ABORT:
> +        case EXCP_DATA_ABORT:
> +            /* We should only arrive here with EC in {DATAABORT, INSNABORT}. */
> +            ec = syn_get_ec(env->exception.syndrome);

Nevermind about my question about syndrome.h vs patch 1.


r~

