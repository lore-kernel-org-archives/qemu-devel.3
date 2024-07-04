Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F204CC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPItP-0002s6-Sm; Thu, 04 Jul 2024 05:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPItO-0002gw-1N
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:36:42 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPItG-0003BL-Lk
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:36:41 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-58b447c519eso550215a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720085792; x=1720690592; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G8B6eb4ww0yKA+UBY9yvqfw0NCeMSI847h9VcCUDQ0s=;
 b=vquM2rQ/Qh/TkTX+VcojZezpsZW8or2FrqtjznHldnxmFQ2yYjg4jfxFyzis0oya/h
 FpHT0Tu4eQYhcdQGSTd8T5sutM6ZwfI/jVxyILetdL2DLQlL9Y3ilhXJbOwnrqaqjK+y
 y0asfbPBKGDuKqfkcA+yag42ESUhBQGdE8KxliYMaHQ/nlNS6EPdlIAj4rGvZLNWX2AK
 30zTOi86shM9F1yAQdx89UQPpDv4qPgoD9a+7A47Qz4NCQQ3s+pYnJwpCNzyotRdRVGV
 NE0BzJaSDvndZcFPlUrm3RfHpR+sTJmcLt8R1G/c45LUshEzxdH1krPp7f/roMGMd5ng
 735w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720085792; x=1720690592;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G8B6eb4ww0yKA+UBY9yvqfw0NCeMSI847h9VcCUDQ0s=;
 b=L4dkrPZ3TAD3KgaluEISJ0Gxgqre38PGhqpSjwHOi+LDvtmluzNRW5L6ryfL3101Rn
 CiHsAoqXSKGGINuX+az5HqVkLyUpV9j3/WJge4lBQSlly2ewClI6Q19Fo9CRlrCaIcVC
 wabGN2fPRso6PbnFcLxauo7jVi6xPZJjkoBjl0ZQjcDIGk+HvCjx68MbX7xBGx9AuyLq
 44F0eQ43b0/GTEEiVgq8Ldx7DFYfDce+BaccFfy3oGUiQu+qLC9dlVnEnJU0P4/BlOeP
 IviujLk7S2tWiM9rusc0N7ShDBtmdZTtkl5r9eBU9rCXmYn34jHutAohQHHDJ5XE2B4X
 SNlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV88+38rpF2rO7tjyDHQ4fKUbRA+ox0ZoqV6dKc7AIMCMJuZWHi4CI2CH6dBeknN1wC0va23fvaRmY5TgORczx/MVErHnk=
X-Gm-Message-State: AOJu0YwSZBSGuGpr7j8ttQxH/PaltyIOl87AMuKV7vwe5sQJ4NLaijgS
 IQog4I0wDsPB964lJF6XC43v3EIghmYXeVR/181QJLtvqUWMPwPc7Rrm3rmeceO1395lOjFK4n2
 SinNjXIn0soaF8XyEClwKN8W2+wnFw060AnGureHnXHanwhF6
X-Google-Smtp-Source: AGHT+IEm4Ni4osSrVgfdMV1pc/mrSL6pb2ZxCsk9CmIB7a0rI5AruiKCoRITk/YFJZo/Ab8HqK4hkB+HSjXFEQrCp/k=
X-Received: by 2002:a05:6402:35d0:b0:58a:e810:227d with SMTP id
 4fb4d7f45d1cf-58e5b3a7c0fmr755344a12.21.1720085792104; Thu, 04 Jul 2024
 02:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240704084759.1824420-1-zhao1.liu@intel.com>
 <20240704084759.1824420-5-zhao1.liu@intel.com>
In-Reply-To: <20240704084759.1824420-5-zhao1.liu@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2024 10:36:20 +0100
Message-ID: <CAFEAcA_hW5CLHdxRfLX0CwyPp=6Z3xn6SgZDdF50_NWyE7PxRw@mail.gmail.com>
Subject: Re: [PATCH 4/4] target/hexagon/imported/mmvec: Fix superfluous
 trailing semicolon
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org, 
 Brian Cain <bcain@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 4 Jul 2024 at 09:33, Zhao Liu <zhao1.liu@intel.com> wrote:
>
> Fix the superfluous trailing semicolon in target/hexagon/imported/mmvec/
> ext.idef.
>
> Cc: Brian Cain <bcain@quicinc.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/hexagon/imported/mmvec/ext.idef | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
> index 98daabfb07c4..03d31f6181d7 100644
> --- a/target/hexagon/imported/mmvec/ext.idef
> +++ b/target/hexagon/imported/mmvec/ext.idef
> @@ -2855,7 +2855,7 @@ EXTINSN(V6_vscattermhw_add,  "vscatter(Rt32,Mu2,Vvv32.w).h+=Vw32", ATTRIBS(A_EXT
>      fVALIGN(RtV, element_size);
>      fVFOREACH(32, i) {
>          for(j = 0; j < 2; j++) {
> -             EA =  RtV + fVALIGN(VvvV.v[j].uw[i],ALIGNMENT);;
> +             EA =  RtV + fVALIGN(VvvV.v[j].uw[i],ALIGNMENT);
>               fVLOG_VTCM_HALFWORD_INCREMENT_DV(EA,VvvV.v[j].uw[i],VwV,(2*i+j),i,j,ALIGNMENT,MuV);
>          }
>      }
> --
> 2.34.1

As a change this is obviously fine, but given the "imported"
in the pathname I don't know if this is something that should
be fixed in whatever upstream source we got this from instead
or as well. Brian ?

thanks
-- PMM

