Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46496E9A052
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7PV-0008D9-9k; Thu, 19 Feb 2026 12:01:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7PJ-0007z2-UM
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:01:42 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vt7PB-0005qm-Fp
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:01:36 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c6f306faaffso470228a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771520491; x=1772125291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uF8IXfTcMZlcG9O3xjIaK79vVL8RMlmGcHQGEryHElA=;
 b=WTUHfKV9GZDp9dspTZiu6iE4nF/7cgMyykHXUhu/grP3eSgtnZE6TCXWfK0ihHLBBI
 raIRtn0rBvXVmIdq1fNdOWejMMT0wrBNl5eoI2c/WfwCBObZcfyBt9uAGCcXv55gzdeK
 y46uoCP6k4WvNWIY65EHrecrN3aa0V1W2UFCrrpKn+2Dq2l0bdpB94H9PWCC3dVNY8Fc
 pI/qkhGGNTilFLz9Ht6J6FrGQVUOBXk5nna+6y2gcLHiMO8JuwPWckFkOZc/E06eG6ZH
 zTmaRKS0hTCM5gw4ypHPscnK5oa5Q52oGMPZoxBVPGnHR/Z7hVfQOmdrBg/vZ4/vgOer
 vaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771520491; x=1772125291;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uF8IXfTcMZlcG9O3xjIaK79vVL8RMlmGcHQGEryHElA=;
 b=Y7onv6Z3StXBF8yulnghOa0U7Hbd2ZwgaMAAFLABP4+pOYkUIvtt5OX0kpZptPhn+F
 89JWIZIVOQBPJDl/5F1n9OY4AKfITbU0GRDQuBiZHs0QGQB4jBiy0e4PjUlhf79Tfkw/
 rmx+L0QksyEaybfDGl5MMwAUuX1EfPYNzt5IUeogJ8QCvpsOfOWUN0t5HhJ9Vp4iqdjO
 iHOiF2qYgquhxx+OSWgP6i/yQNSDcxYbkAgnVbmLxTRLkRHI0on/pM8ayD4c70Gx0AXk
 OmrcE0Hi1OPEDKG7spw8S4OHuZGx3263BuBjDmLf1XUCKJyO8BKdHZFnQ88EuMMJUqRF
 8UIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlOWbD1utBAJeLYNT1q1ukA5T4Y630sAEpsyttngW2/tPX0os0tMjkQNuCQDVctBFuGfCK9cANDnLE@nongnu.org
X-Gm-Message-State: AOJu0YzUC1HR0IO0udEaft9MWimCRkVPFVgPyf2AQCzRAfBDi2GkWvlL
 JM+k+U7haYrpHelE8hXBs72vDD5YMdL/Qc4MlphY7Kfh61kMikSDZaIPnW1hjfnThw8=
X-Gm-Gg: AZuq6aJgWjGgyf/URbSoW2lDcvzKssqRfShqb+D0CEL+9BCic3PrmZymOxtcq25vfLS
 2PowBM88Kq7RT6Bk3rtL9B9EtuXa0K33vvSjeKuRQHGpVt55HTOzwEs01bIS/gV9ZyF/Tl+GiB3
 +SeW6gsc6a2RocDq1mD52ZInC0xJKFAkdgSaACCsZzzEu3/pD7lAsAr40QRWJ1l3x7bjWHmpd+3
 zROHtlDKhpwHZAA9LMr6UPesHRICDLdvR/mQjSRAz4cN1m6wve/izdppHdga2+1FAFGWXBH7v+O
 M/plnjAlgTSzSF0tbnnCzTae3u/bTgfze9yk/Y1VhiS8bfCB7BjbrhM2hWgZosPG64coR1NutDh
 Y0yM+g/xHxNAvssG9wu5mic7Yp826L/gpcfUDtQ4priknzdZhllKySqHEQHm/czcJIAaAq14k1i
 lpb9Aeer/jIx+nxdNI37ohMg2cI59GeHD+QARWO81trsVcG4NWT1R+JlzFMVZW2R+idgE1
X-Received: by 2002:a17:902:ce89:b0:2a8:7814:47d0 with SMTP id
 d9443c01a7336-2ad1749829fmr171074845ad.22.1771520491050; 
 Thu, 19 Feb 2026 09:01:31 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a743570sm170091855ad.41.2026.02.19.09.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 09:01:30 -0800 (PST)
Message-ID: <27465be5-5964-4402-8034-f0c7c4edc3b1@linaro.org>
Date: Thu, 19 Feb 2026 09:01:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/24] bsd-user: Add do_bsd___semctl implementation
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>
References: <20260218-bsd-user-claude-v3-0-0137b37b221e@bsdimp.com>
 <20260218-bsd-user-claude-v3-18-0137b37b221e@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260218-bsd-user-claude-v3-18-0137b37b221e@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/18/26 9:22 PM, Warner Losh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Add implementation of __semctl(2) syscall for System V semaphore control
> operations. Handles command translation, endianness conversion for GETVAL/
> SETVAL, and array/structure conversions for GETALL/SETALL/IPC_STAT/IPC_SET.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.h | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 116 insertions(+)
> 
> diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> index e1e552b58f..cb7fe1d6d0 100644
> --- a/bsd-user/bsd-misc.h
> +++ b/bsd-user/bsd-misc.h
...

> +    case IPC_STAT:
> +    case IPC_SET:
> +        __get_user(target_buffer, (abi_ulong *)target_un);
> +        err = target_to_host_semid_ds(&dsarg, target_buffer);
> +        if (is_error(err)) {
> +            return err;
> +        }
> +        arg.buf = &dsarg;
> +        ret = get_errno(semctl(semid, semnum, host_cmd, arg));
> +        err = host_to_target_semid_ds(target_buffer, &dsarg);
> +        if (is_error(err)) {
> +            return err;
> +        }
> +        break;
>

For all the cases using this pattern:

```
if (is_error(err)) {
     return err;
}
```

> +    case IPC_RMID:
> +    case GETPID:
> +    case GETNCNT:
> +    case GETZCNT:
> +        ret = get_errno(semctl(semid, semnum, host_cmd, NULL));
> +        break;
> +
> +    default:
> +        ret = -TARGET_EINVAL;
> +        break;
> +    }

Shouldn't we instead goto this epilogue to ensure we call unlock_user?

> +    unlock_user(target_un, un_ptr, 1);
> +    return ret;
> +}
> +
Regards,
Pierrick

