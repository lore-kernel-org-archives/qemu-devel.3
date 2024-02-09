Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DED3C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 17:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYUxT-0003Gd-JH; Fri, 09 Feb 2024 12:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYUxS-0003GU-4L
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 12:46:38 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rYUxQ-0003mk-Hv
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 12:46:37 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4101565d20bso11067325e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 09:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707500793; x=1708105593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CMP9+oA5PZa1GDmH6J/3qdiJQiJNWPu5uwirTMrtciQ=;
 b=KEFxoYk85D6ruYBCpE6YUpNA4rx9wwTsuc6oZJbNT3zFr4VDiGXPSxDPaYc+cqIaFc
 E4xbQxJQTna2w4XfXZr9X9+IH7c87CcBtDxuBx2DsBwejOnrUi0tKbvs+vvtulyEjibD
 b8maQ7/NCDNPqDwPzr7LQASUia2ux6oSIi2ReDUhbo4Fc4bYfiqSbvQZ6c+p/4r9B7dq
 rIOVVvhrZp0NPVGGUbxd2ywqFRJwpZOUGjx9Ta/FKMgHJmW5L+hnlOSRLGRbgifhPglU
 MwkTpHJ/+8GWoiIMGHyDwqti9LpbMJvLmDKUzyuAukrrmZShULCk1zQPeYirueJB86Gt
 PbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707500793; x=1708105593;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CMP9+oA5PZa1GDmH6J/3qdiJQiJNWPu5uwirTMrtciQ=;
 b=FOiqArx+MToZpN0ByHa5y48RIyOxGs76diD/AxfFw6Stp08E0YQzsQzsXdqzLxXdV9
 6hho4H5qb+kblxuWnfMy2homCYo7+nn/kzJqXtjm4ritsVUpvcdyVwGbMFsQsjqiZeIP
 IzfscHq2sRHe6nPdptcbqVV9GWP1kfhXmSZozVBtAs3iUsIIh2R2PsMqL9lJNMLz8e9M
 SM2fTTb/zevhFDHrrSzfAkw5RU1i0h7W/wZcG/ehsTvC2KCtgEpUWFaAL7gJOc6KzA8K
 AzWn0Og7MIQOBhY/DxRyO4ScODfzd+YGkFN7AoMsxzyScJ5ckr0RH8FlgXZ0a17lYoqg
 TYgA==
X-Gm-Message-State: AOJu0Yy/fppmg4BcT7QgEylc/JdUBk5Ffhj1Hlm6BcefHjqgeTY9AIRq
 r2oQFCDu06gAspKeA5UVtdRnC1+SwFV219nzACxylnDc86InyBzyHx60g9mnsGDB1zLGunAtCLa
 6
X-Google-Smtp-Source: AGHT+IH99libf9jh1GuN0cLdKL6aQYBI2jm6wSEaGlryUhwhMHBmWeUUEqkbvRsmEWdL9BCLx6e6Sw==
X-Received: by 2002:a05:600c:16c9:b0:40e:f154:752 with SMTP id
 l9-20020a05600c16c900b0040ef1540752mr23840wmn.20.1707500793453; 
 Fri, 09 Feb 2024 09:46:33 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWGi45v2J76YthBvZEFTR/Y8eQh2CMiRBtNwTSpewaIt3GvhYYJV03JsJTM8HOH/wGHDO/f/8O41zTqtXQdw0dWc3A1J1XOxTI/Hkkkx3zrtkKPfX9JqO13c1yO5tNJ6zFFMUnNgs4A5w==
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v17-20020a05600c445100b0041076153a40sm1266859wmn.44.2024.02.09.09.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 09:46:32 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5BE985F79D;
 Fri,  9 Feb 2024 17:46:32 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  den@openvz.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH] kvm: emit GUEST_PANICKED event in case of abnormal KVM
 exit
In-Reply-To: <20231101152311.181817-1-andrey.drobyshev@virtuozzo.com> (Andrey
 Drobyshev's message of "Wed, 1 Nov 2023 17:23:11 +0200")
References: <20231101152311.181817-1-andrey.drobyshev@virtuozzo.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 09 Feb 2024 17:46:32 +0000
Message-ID: <875xyxledj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> writes:

(Add kvm@vger to CC for wider review)

> Currently we emit GUEST_PANICKED event in case kvm_vcpu_ioctl() returns
> KVM_EXIT_SYSTEM_EVENT with the event type KVM_SYSTEM_EVENT_CRASH.  Let's
> extend this scenario and emit GUEST_PANICKED in case of an abnormal KVM
> exit.  That's a natural thing to do since in this case guest is no
> longer operational anyway.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Acked-by: Denis V. Lunev <den@virtuozzo.com>
> ---
>  accel/kvm/kvm-all.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index e39a810a4e..d74b3f0b0e 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2816,6 +2816,14 @@ static void kvm_eat_signals(CPUState *cpu)
>      } while (sigismember(&chkset, SIG_IPI));
>  }
>=20=20
> +static void kvm_emit_guest_crash(CPUState *cpu)
> +{
> +    kvm_cpu_synchronize_state(cpu);
> +    qemu_mutex_lock_iothread();
> +    qemu_system_guest_panicked(cpu_get_crash_info(cpu));
> +    qemu_mutex_unlock_iothread();
> +}
> +
>  int kvm_cpu_exec(CPUState *cpu)
>  {
>      struct kvm_run *run =3D cpu->kvm_run;
> @@ -2969,21 +2977,24 @@ int kvm_cpu_exec(CPUState *cpu)
>                  ret =3D EXCP_INTERRUPT;
>                  break;
>              case KVM_SYSTEM_EVENT_CRASH:
> -                kvm_cpu_synchronize_state(cpu);
> -                qemu_mutex_lock_iothread();
> -                qemu_system_guest_panicked(cpu_get_crash_info(cpu));
> -                qemu_mutex_unlock_iothread();
> +                kvm_emit_guest_crash(cpu);
>                  ret =3D 0;
>                  break;
>              default:
>                  DPRINTF("kvm_arch_handle_exit\n");
>                  ret =3D kvm_arch_handle_exit(cpu, run);
> +                if (ret < 0) {
> +                    kvm_emit_guest_crash(cpu);
> +                }
>                  break;
>              }
>              break;
>          default:
>              DPRINTF("kvm_arch_handle_exit\n");
>              ret =3D kvm_arch_handle_exit(cpu, run);
> +            if (ret < 0) {
> +                kvm_emit_guest_crash(cpu);
> +            }
>              break;
>          }
>      } while (ret =3D=3D 0);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

