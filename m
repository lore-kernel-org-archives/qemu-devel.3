Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F92FCEE8E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 11:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvDJP-0001B1-7o; Wed, 25 Feb 2026 06:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vvDJN-0001Ae-IP
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:44:13 -0500
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vvDJM-00010W-5I
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:44:13 -0500
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-1271257ae53so6478776c88.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 03:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772019850; x=1772624650; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=05HjhtVsBXJBNbVvU5Fgi1igTh88gY8jk4o8+838xC8=;
 b=MfHuo16EhKYIowcjAOB99M0MZkbnrKj6QqOYuJF8uS7oiFvuT2VZB5QdgT7dwf7Go2
 akFifaLJ04/CQ7D40+rsooMWzk+9mobOmI7oIhHAHUHchrbhDe502Gs9uzaqNUTDoHna
 DfXEK8+9yYNsb0qjrr4pgZhj9FcXd8WXYoF6lLKZslJMU9sGt5DvRk2UTOPkYoSeYEIO
 0GyDQEdJQ54OnkAyYznnpmHRSi5OMnp0lJEEte7ARRehmdQWQUOhqFvkB3iKxURtsUsm
 9Avu+6bY+TKASZOb2c1epKHIAmV/OuImWRwQyfRJFyRw8v5EsvnqaLy+40lz4lZRw5Ky
 zl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772019850; x=1772624650;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=05HjhtVsBXJBNbVvU5Fgi1igTh88gY8jk4o8+838xC8=;
 b=JvRUUGPWXMduyE1pVcJNQRsMGK6Tk2IfgG6Lw1a1z6Wj7q+zLCQLcYo089kq2KssWS
 Aq7k+vFaKccgbBolOHRy30K0GLiu3lNEICi4sn4jdNUG4VqeMHxQn1TXYpWzzSD/W+gP
 kij4v+o9mW1HKaV93sii3egISg6PU/cWjPS/TLFSy6bRflRC8fKeGMsI9IHVvsDzxZvJ
 op/WjpQSpnGMYlnBnRDgWWnwzq2rYn4UYCk7K3RnR9DioJZpW0B4U4kZMfLJSdJQTLqq
 7kREUCI6voI4fCnTkv4hFm/p75wVR2z/X0KAvH7pl6/Uf+q1FUl2gX5SrEd+pnDPgHJ2
 xVPA==
X-Gm-Message-State: AOJu0YwYuC5uXX9Z4+ccc3GlPxoT6psNBEXCYzAELJXLEOSCLCgixY1n
 YW3Cg9uHO39tR1lJwJlLYwEFMdzo04ZoVI2euRu3WsiPPJpjak9T2ey4
X-Gm-Gg: ATEYQzznGKoxR9L5Yo7i16vJT6F9mWeh5OKFsiNy5+AFQ3UIJEv+F16psD87eLxBhSe
 9Xhd4rFAQXR+Sgw4TJ5V+wRzsDTr8LKos2hVRMpMBVCBD+IOnP5yE728dbfzIYz6LITa392r8Rg
 VYR1w9WkHhkq+0nc3rIpWCtYY3BcmMDKWUzdsvnOGCzyRYywUE3y2sgis41vf+NQf/GLccMGv+J
 It+WbKf/KBZ+rLFUeDTfHFz7+Jk+b94XqjQSMYWV3BwJXzXujurb0p3gOW64V2/iTsoOu+qY4JH
 3qdXqHw3/Kr5ULyysHyGPyCdUfKhELnzcOpbqinTvNzyb2kGZd/pdUin6l5IvLYLyq92h54ly9F
 TW8k/JiDTVVdstg2Hx88Kta54e8ILAOd0tuSRXROd7+d2XfSeUdv8HPubnlg39/hoxYCN/hrXbt
 7rJfguL7pbAWRx8/w/piRMl2OADaoSBcS6/QefGIi3XHfxZEJpcGqzTqfvvLnLMzTAx44tKsvcE
 icRJw9wx/gqaILQ4gboFntvxW6IW00=
X-Received: by 2002:a05:7301:6706:b0:2ba:9f79:8189 with SMTP id
 5a478bee46e88-2bd7baea79dmr6172092eec.13.1772019850125; 
 Wed, 25 Feb 2026 03:44:10 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bd7dc169e2sm9611586eec.29.2026.02.25.03.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 03:44:09 -0800 (PST)
Date: Wed, 25 Feb 2026 19:44:13 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org
Subject: Re: [PATCH 3/3] fpu: Simplify OCP FP8 E4M3 NaN classification in
 parts_canonicalize
Message-ID: <aZ7ge-zVkIuiiHkT@ZEVORN-PC.localdomain>
References: <20260225110802.1217946-1-max.chou@sifive.com>
 <20260225110802.1217946-4-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225110802.1217946-4-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dl1-x1241.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Feb 25, 2026 at 07:08:02PM +0800, Max Chou wrote:
> The OCP FP8 E4M3 format has only a single NaN encoding (0x7F/0xFF),
> Replace the indirect check via parts_is_snan_frac with a direct
> check of no_signaling_nans to make the intent clearer.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>  fpu/softfloat-parts.c.inc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
> index 3c323c0cec..5ef7e2d921 100644
> --- a/fpu/softfloat-parts.c.inc
> +++ b/fpu/softfloat-parts.c.inc
> @@ -245,8 +245,8 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
>          case float_expmax_e4m3:
>              if (p->frac_hi == 0b111) {
>                  frac_shl(p, fmt->frac_shift);
> -                p->cls = (parts_is_snan_frac(p->frac_hi, status)
> -                          ? float_class_snan : float_class_qnan);
> +                p->cls = no_signaling_nans(status) ? float_class_qnan :
> +                                                     float_class_snan;
>                  return;
>              }
>              /* otherwise normal */
> -- 
> 2.52.0
> 
> 

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao

