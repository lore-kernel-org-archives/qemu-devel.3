Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E21CC25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENCG-0005Bg-KV; Tue, 04 Jun 2024 01:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sENCF-0005BL-R9; Tue, 04 Jun 2024 01:58:59 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sENCE-0005L4-7J; Tue, 04 Jun 2024 01:58:59 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-702548b056aso2372124b3a.1; 
 Mon, 03 Jun 2024 22:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717480736; x=1718085536; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gl8nhqFsYbY5YUB00tLeYqld+esrzmjcXavcX0Ll0gA=;
 b=A5T1oFG82oSezTRAgDQq8OxG4OlSo6//B64iwS7xcOj+MD8+JpL7bvbD1qBae6QxHr
 3bGjgIg5Q7nmQa6a/GmTTxmOsgDDXm+Y3hdHiwpHuKSG5YXqL0DcfvwrDX2kjCxuWm8j
 ceM0hIDHLZ55BkwUc09A+6M1lK4XNEMlqq7QX6VX1Sg7QstwHd+Od8UkKPRA7QRAAKL0
 vLJnwYpc5fjZui0Sl+Cpo5M/dbV5qWW/XNmhGD9LnxQypPisow3WbDqcTABr1JwMy8ym
 S+VpP0HZtTj5eut0t696ovBWAADLZ1FF1rRYN3DqS7rfiElHX2ljhP2TnhbSf4WBSH0U
 Wqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717480736; x=1718085536;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gl8nhqFsYbY5YUB00tLeYqld+esrzmjcXavcX0Ll0gA=;
 b=SlNcm89vqwrxPAAmYpUORx9++DQl02bJnd/SxDk0yUdYRbA8Iwl49FDstUx0j3XC+9
 9lgxYkpTS6C4IhMSApaxJHRvDooAHvmcCCeMnUUdEKSEX5doZ5g3ft50kjGtzq3asJK4
 veNilgDOXPAEbJpuYoKnPiR7ptybgmNOAMOjSt+VN6ei2QIa/I3lZlryCtlILe7qlp3p
 GQhrV4/z+lKZWNjSaIhYbto8uRQoExMsjzY8tYsLDVrHrT9mr626JAjUVFXQywy4EyGf
 MJXAEKjgiF23QBoFZBhKHGwUu0axOPAYA+dXQkQg3NeaCtGSBE/H7wZDFbjqNfvcPPHq
 1Q7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmcS03Nn6Bh3mnrlp+iTfI5umI18yjwRDXCyb473oFis+tEDtfIWCiwYtZuoluC4m4p06d+aoOUufo1HKgp/+v7RkQEhqq2+TK+63sDsw1idu3CxDcbAc/BMI=
X-Gm-Message-State: AOJu0YwXk6AZjbETtQcFex1R0gkOq1nTvL1HBeAvPHQPNrTVPPvArnOF
 JYtxOZa76/Y1Tk0btRRqifAShr6olAeuw8QFsGD45awcHgwnVJG1UQQdAA==
X-Google-Smtp-Source: AGHT+IEUimO7kKL5JzPZ4X9UjN4s4Rov2b/FPNTv9+n2YcOTF0OmtGxebNsWC6ZgEm82JBiWDYR9bw==
X-Received: by 2002:a05:6a00:23c6:b0:6ed:41f3:431d with SMTP id
 d2e1a72fcca58-70247666e1bmr12408633b3a.0.1717480736101; 
 Mon, 03 Jun 2024 22:58:56 -0700 (PDT)
Received: from localhost ([1.146.11.115]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-702425d9aeasm6373462b3a.50.2024.06.03.22.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 22:58:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 15:58:49 +1000
Message-Id: <D1R03V1KZTWF.2BW5FQ7M7SGZ9@gmail.com>
To: "Shivaprasad G Bhat" <sbhat@linux.ibm.com>, <cohuck@redhat.com>,
 <pbonzini@redhat.com>, <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>
Cc: <mst@redhat.com>, <danielhb413@gmail.com>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH 2/2] target/ppc/cpu_init: Synchronize HASHKEYR with KVM
 for migration
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.17.0
References: <171741555734.11675.17428208097186191736.stgit@c0c876608f2d>
 <171741557432.11675.11683958406314165970.stgit@c0c876608f2d>
In-Reply-To: <171741557432.11675.11683958406314165970.stgit@c0c876608f2d>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon Jun 3, 2024 at 9:53 PM AEST, Shivaprasad G Bhat wrote:
> The patch enables HASHKEYR migration by hooking with the
> "KVM one reg" ID KVM_REG_PPC_HASHKEYR.
>
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  linux-headers/asm-powerpc/kvm.h |    1 +
>  target/ppc/cpu_init.c           |    4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/=
kvm.h
> index fcb947f656..23a0af739c 100644
> --- a/linux-headers/asm-powerpc/kvm.h
> +++ b/linux-headers/asm-powerpc/kvm.h
> @@ -646,6 +646,7 @@ struct kvm_ppc_cpu_char {
>  #define KVM_REG_PPC_DAWR1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc4)
>  #define KVM_REG_PPC_DAWRX1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc5)
>  #define KVM_REG_PPC_DEXCR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc6)
> +#define KVM_REG_PPC_HASHKEYR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xc7)
> =20
>  /* Transactional Memory checkpointed state:
>   * This is all GPRs, all VSX regs and a subset of SPRs
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index b1422c2eab..cee0a609eb 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -5805,10 +5805,10 @@ static void register_power10_hash_sprs(CPUPPCStat=
e *env)
>          ((uint64_t)g_rand_int(rand) << 32) | (uint64_t)g_rand_int(rand);
>      g_rand_free(rand);
>  #endif
> -    spr_register(env, SPR_HASHKEYR, "HASHKEYR",
> +    spr_register_kvm(env, SPR_HASHKEYR, "HASHKEYR",
>              SPR_NOACCESS, SPR_NOACCESS,
>              &spr_read_generic, &spr_write_generic,
> -            hashkeyr_initial_value);
> +            KVM_REG_PPC_HASHKEYR, hashkeyr_initial_value);
>      spr_register_hv(env, SPR_HASHPKEYR, "HASHPKEYR",
>              SPR_NOACCESS, SPR_NOACCESS,
>              SPR_NOACCESS, SPR_NOACCESS,

Hmm... now that I look at it, the hashpkey value also needs to be set
in the machine and migrated, right? That looks broken. I *think* if we
make this spr_register_kvm_hv, and you will also need to add a KVM
API for the register, that should get it working becuse SPRs will
be migrated for us.

Thanks,
Nick

