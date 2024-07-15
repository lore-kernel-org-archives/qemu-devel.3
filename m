Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB5AC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 13:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTLwt-0000yg-IJ; Mon, 15 Jul 2024 09:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTLwX-0000a0-4M
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTLwV-0001A2-6t
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 09:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721050837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0CePbDAFK3Cwx4iJFDM/ZEI2OLkyFBDt7VdipzQwDjA=;
 b=g/TdjPBzHjMwFaX+ZR6rOZ4lHjlEWxgSaJCBT3qnonnhnwladFOd4gr6ym7lFyRwBZqCoc
 10ii+naYSyw0GuyQlMlG8YdSEIvWxfbn5k43z3FZxtLLOX1JgcpZjK7zzh8sCJIzg3rVYr
 u8JtFaFkNU7iT4ZaxYt5hglg6MpSUVg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-5XajdKCSOnOXiGJmzt_n5g-1; Mon, 15 Jul 2024 09:40:35 -0400
X-MC-Unique: 5XajdKCSOnOXiGJmzt_n5g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4279837c024so30986765e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 06:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050833; x=1721655633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0CePbDAFK3Cwx4iJFDM/ZEI2OLkyFBDt7VdipzQwDjA=;
 b=DB5ry8M99Q0TIUdtLH0yCQJ6aky42O/gsYE9VdUpvUo5vIHQFCfdz59SpA5fVGF0x9
 RL9TF2hxNCYLECVYAEffehF/oLowSbeOXXnX0YWiF+VtiecB2L7BW39j26rLQR7s2FVO
 b4v6hCuLkk2SxwXV4QWO0nRUvjawjfuMkhu6L9h2a41ergDswSTepFfQgoi/kW2fTB8t
 6B5xN/vWd9t8Qkf9yWX5NZ3CFplnCEL5jArZkTMC78vN2kocPpqR8a+9IBBU2YJmgHKo
 ZzRy4M69SBdSvOPlZ2+o16PVa5mqdMixJb5w8PEwoOtTqWT4KjmvyQPZMumstqbAuZEk
 P67w==
X-Gm-Message-State: AOJu0Yws+UBf6wacm5B+gFPTHA2klLtuICdVIQTS7v5qrtVen7akic4J
 yH4pjz373jVgNCle1Opwqj5e3RlribMxALIuUhBRl94DRwI9TKUctrJVknnQYvsl74XYPP+9iJd
 nHVPjxyCPk7Hgsf5LgfkQiD46xRphJwHk/+et+nHr2XvYBhYnQeQxSUVI9lS5
X-Received: by 2002:a05:6000:2c5:b0:367:9c4b:6486 with SMTP id
 ffacd0b85a97d-367cea965f2mr17195098f8f.32.1721050832945; 
 Mon, 15 Jul 2024 06:40:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/to+35Qg2T6kOmGipjxAfWotvQ3bT3oQAFAK1lGW3KG6UmWFb6K1qFHxd8mGbWl8BcquFRQ==
X-Received: by 2002:a05:6000:2c5:b0:367:9c4b:6486 with SMTP id
 ffacd0b85a97d-367cea965f2mr17195066f8f.32.1721050832552; 
 Mon, 15 Jul 2024 06:40:32 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabf128sm6423597f8f.40.2024.07.15.06.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 06:40:32 -0700 (PDT)
Date: Mon, 15 Jul 2024 15:40:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <maz@kernel.org>,
 <jean-philippe@linaro.org>, <jonathan.cameron@huawei.com>,
 <lpieralisi@kernel.org>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <andrew.jones@linux.dev>,
 <david@redhat.com>, <philmd@linaro.org>, <eric.auger@redhat.com>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <mst@redhat.com>,
 <will@kernel.org>, <gshan@redhat.com>, <rafael@kernel.org>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linuxarm@huawei.com>, Shaoqin Huang <shahuang@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH V15 7/7] gdbstub: Add helper function to unregister GDB
 register space
Message-ID: <20240715154030.44ebfb7e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240713182516.1457-8-salil.mehta@huawei.com>
References: <20240713182516.1457-1-salil.mehta@huawei.com>
 <20240713182516.1457-8-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat, 13 Jul 2024 19:25:16 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> Add common function to help unregister the GDB register space. This shall be
> done in context to the CPU unrealization.
> 
> Note: These are common functions exported to arch specific code. For example,
> for ARM this code is being referred in associated arch specific patch-set:
> 
> Link: https://lore.kernel.org/qemu-devel/20230926103654.34424-1-salil.mehta@huawei.com/
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  gdbstub/gdbstub.c      | 13 +++++++++++++
>  hw/core/cpu-common.c   |  4 +++-
>  include/exec/gdbstub.h |  6 ++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index b9ad0a063e..5da17d6530 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -618,6 +618,19 @@ void gdb_register_coprocessor(CPUState *cpu,
>      }
>  }
>  
> +void gdb_unregister_coprocessor_all(CPUState *cpu)
> +{
> +    /*
> +     * Safe to nuke everything. GDBRegisterState::xml is static const char so
> +     * it won't be freed
> +     */
> +    g_array_free(cpu->gdb_regs, true);
> +
> +    cpu->gdb_regs = NULL;
> +    cpu->gdb_num_regs = 0;
> +    cpu->gdb_num_g_regs = 0;
> +}
> +
>  static void gdb_process_breakpoint_remove_all(GDBProcess *p)
>  {
>      CPUState *cpu = gdb_get_first_cpu_in_process(p);
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index b19e1fdacf..fe5383b4f9 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -281,7 +281,9 @@ static void cpu_common_finalize(Object *obj)
>          g_free(cpu->plugin_state);
>      }
>  #endif
> -    g_array_free(cpu->gdb_regs, TRUE);
> +    /* If cleanup didn't happen in context to gdb_unregister_coprocessor_all */
> +    if (cpu->gdb_regs)
> +        g_array_free(cpu->gdb_regs, TRUE);
>      qemu_lockcnt_destroy(&cpu->in_ioctl_lock);
>      qemu_mutex_destroy(&cpu->work_mutex);
>      qemu_cond_destroy(cpu->halt_cond);
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 1bd2c4ec2a..d73f424f56 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -40,6 +40,12 @@ void gdb_register_coprocessor(CPUState *cpu,
>                                gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
>                                const GDBFeature *feature, int g_pos);
>  
> +/**
> + * gdb_unregister_coprocessor_all() - unregisters supplemental set of registers
> + * @cpu - the CPU associated with registers
> + */
> +void gdb_unregister_coprocessor_all(CPUState *cpu);
> +
>  /**
>   * gdbserver_start: start the gdb server
>   * @port_or_device: connection spec for gdb


