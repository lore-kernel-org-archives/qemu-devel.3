Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8719CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 10:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzYZ1-0005VI-GF; Fri, 19 Sep 2025 06:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uzYYy-0005UC-H6
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:42:00 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uzYYw-0003Is-BE
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:42:00 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b079c13240eso345072766b.1
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758278516; x=1758883316; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TMSIyJ4KFet3yEGpde8P9d3ZMSPdaT2ujttqCdo0jpo=;
 b=oyPrrPNZqPsKeXyCkzwVuvVjFHkPNtvF/2exNOmOdpzZQXCboZ17rNT9FhHAnjFI3j
 MvQV8loSvLVk4+2QxmXGio/pLKIYippVlVTgeQLavZof/QrBP+5eLCNZTjAX8pw17qoN
 ZvEwOMKbLeX07zq0k2u0Sc1yJE8Bt+aFhdM+rye+gfMMc6lMpU6CahsOtB9QD9EQZocv
 BqyR6hqEa1mUnrFgZkNtAm1qETcAPUmuD9NSs71DcDlPRO5aIewpR01TyJOGrMqoL4YX
 9LC4HFfpG8Hd8vxIMRST1tK+yV+FcRhJ72DcAPJhR/xBLwAuMn9dq6gmMZd9uSYqpR9u
 2TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758278516; x=1758883316;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMSIyJ4KFet3yEGpde8P9d3ZMSPdaT2ujttqCdo0jpo=;
 b=Knyzy0cP3Cj4oICcPrN2cAOnhd2BsmAv+npkkHlkNAeeSQc254fTMvVTJDCttn36fX
 n4BdwxEhA7H6SHnMx+E/9hwz+bNHWH0QZ/T4Zdt8jxA9EGWD9VQVbiU6viqego5+D+hg
 DRYRu+hbenRpxUNG57IvJgsyYRwPUkaTqMrpv8hAVs2WYu96xBjh6/6BvYG2ltqdMKL7
 Zqz0HSuVmN7ft7oqgfjXty6KTxPep9FqwwKlpbJKcFTEiFUmr87SINaV8DEvl5j6Fajy
 zMmbThVRNvPuZ7CfE68d7serOLLcQPM8g24nD2rfIpucATYJVBvboyN8WQVspvNumvxi
 IyEg==
X-Gm-Message-State: AOJu0YzFcAYlmpKUT75MQatA6I5KoWQ2GjJPa68M5NXLaliH72JNKG+w
 IY0AXUgodVoBkM+28HqR0tzin8OENwqfWpPsYyhzhGFi40nR8sA9yJHLqJTYCdOU+AB9P9sirq/
 6SEbtGFlMOafb0m+j9aiqsZiy7z+xioCg15Wzkh6YhQ==
X-Gm-Gg: ASbGncvnCuuhz+HTj/avx5xL9DULV+RCQTNlLqr4O3o8C3qWx09qwygMC75RQMaCXjy
 e3tLbSHpP5SdhEKPNtroUz1C07gQ9DapzqtYlEV8AQ6qV6LTBKmF9BsChRYD/y821Bws8H3hFT7
 gx1LNg6QDKCI/6r39cqhp87jqxnoaBPxhIBvEw1kGI1hVnceYpzZ8kUsCt4NOO4yNyqlFdydQPp
 onNkQ==
X-Google-Smtp-Source: AGHT+IGyq9SXF7C2paltcJLr0tBVS6atCLiSjcn+nx4Qaerjdo5uAnx/h2Zmu0PgKsWiSCEwILQDnZq9N+YnCjdiHcE=
X-Received: by 2002:a17:907:7290:b0:b04:48b5:6e8a with SMTP id
 a640c23a62f3a-b24eca00bf9mr284587366b.7.1758278515772; Fri, 19 Sep 2025
 03:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250919083625.86678-1-pbonzini@redhat.com>
In-Reply-To: <20250919083625.86678-1-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 19 Sep 2025 13:41:28 +0300
X-Gm-Features: AS18NWDywiG_4fXkr5UrKxDHQlWBxv9TWmbCeTjIqNO7VX0EQzlold405RmnPw8
Message-ID: <CAAjaMXa2F-AptpLNy4=LeVRb9FXX6QzzAdVR2PZcqWX6LEYR7Q@mail.gmail.com>
Subject: Re: [PATCH] rust: vmstate: use "cast()" instead of "as"
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
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

On Fri, Sep 19, 2025 at 11:37=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> Reported by clippy, fix it.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  rust/migration/src/vmstate.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.r=
s
> index c05c4a1fd66..e04b19b3c9f 100644
> --- a/rust/migration/src/vmstate.rs
> +++ b/rust/migration/src/vmstate.rs
> @@ -144,7 +144,7 @@ macro_rules! vmstate_of {
>          $crate::bindings::VMStateField {
>              name: ::core::concat!(::core::stringify!($field_name), "\0")
>                  .as_bytes()
> -                .as_ptr() as *const ::std::os::raw::c_char,
> +                .as_ptr().cast::<::std::os::raw::c_char>(),
>              offset: ::std::mem::offset_of!($struct_name, $field_name),
>              $(num_offset: ::std::mem::offset_of!($struct_name, $num),)?
>              $(field_exists: $crate::vmstate_exist_fn!($struct_name, $tes=
t_fn),)?
> --
> 2.51.0
>
>

