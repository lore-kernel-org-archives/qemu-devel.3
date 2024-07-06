Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCA4C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 14:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQ6bD-0005i4-8n; Sat, 06 Jul 2024 10:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ6bA-0005gl-7x
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 10:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ6b8-0001Wd-HZ
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 10:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720276869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gCKQWQ5N/O7xFn9vt40NyrtyS75JScU93rfdKb9KEdM=;
 b=fRLyVkzdH+1oy23K45H2D56RcvRDBWdE8ovhk2bfkJnlVSmD7i33dYoUyvEUbUXPXu7jc/
 3zM/79b+5Nab/XmnWlwnSLk4QW0oTRQOLNQYNJQnu5HfSMS6bkTHoqfcUVm2T7GUb22zIt
 y530IWoaihek3PiM9tKLJyLSm0+JWH8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-wuvtjZabMKusE1OvqWAx8A-1; Sat, 06 Jul 2024 10:41:08 -0400
X-MC-Unique: wuvtjZabMKusE1OvqWAx8A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-367962f0cb0so1705903f8f.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 07:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720276867; x=1720881667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gCKQWQ5N/O7xFn9vt40NyrtyS75JScU93rfdKb9KEdM=;
 b=Fmc0gjZQVmCNlQkSfgbaT2lIsDbp8vFozxT/TeqxOYDsLDsx/dXmT5HO56hb+qKvGk
 ZPHtoQ0YvJG8rMR8OKvsWrNEHaGnBCPLM5RDPkZvpUcfuIjA7y9eshOB0XZw69K/u96R
 0agc1oxcfLuWFsGN/zChgLKbr7RKecDwPfcqR3f9R0zlFDHPdxL67xLs1PBJVluw6wzz
 npE8oKnnz9pnyro6nGdNH2HfywwTm5bwpvI2e9GrdONf/cKg8uREIwPDzhkycr4P3CfC
 NTZGX3kxX3xMZ85CKBdVy9+Nl2XNg+O+H61sBN7FsQO/F9Aj9JOAB8Wf9KHQUvoFCM3T
 QUag==
X-Gm-Message-State: AOJu0YxBfOlylbhiUV3J8BGBtfxZueZWyCfzRFf1EEJi9UyDXFPw/3AL
 U5KhyvmImg32uK2fe+ngufdAM3TKT/q3Uhm34c8rcD9AoSvfmhqQXEerPAOLgKDWk3KNBnqmx9v
 Y7F9tXSjRzuT+PxIV3R6hJWh9Y38BkqrAdSvyrp3G4MG03tcrMmcK
X-Received: by 2002:adf:e68b:0:b0:367:4d9d:56a5 with SMTP id
 ffacd0b85a97d-3679dd63aa0mr5419502f8f.44.1720276866875; 
 Sat, 06 Jul 2024 07:41:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEP0AA4YMUmDcdbBJa+n4ZeJA8w2TFy/xM7v2jIG8XFjTomCT1LF5I90K9yEp+swYcHm/PVNg==
X-Received: by 2002:adf:e68b:0:b0:367:4d9d:56a5 with SMTP id
 ffacd0b85a97d-3679dd63aa0mr5419469f8f.44.1720276866450; 
 Sat, 06 Jul 2024 07:41:06 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367a18c2810sm5772765f8f.18.2024.07.06.07.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 07:41:05 -0700 (PDT)
Date: Sat, 6 Jul 2024 16:41:03 +0200
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
Subject: Re: [PATCH V13 7/8] gdbstub: Add helper function to unregister GDB
 register space
Message-ID: <20240706164103.16662dd2@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240607115649.214622-8-salil.mehta@huawei.com>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-8-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Fri, 7 Jun 2024 12:56:48 +0100
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
> ---
>  gdbstub/gdbstub.c      | 13 +++++++++++++
>  hw/core/cpu-common.c   |  1 -
>  include/exec/gdbstub.h |  6 ++++++
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index b3574997ea..1949b09240 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -617,6 +617,19 @@ void gdb_register_coprocessor(CPUState *cpu,
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
> index 0f0a247f56..e5140b4bc1 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -274,7 +274,6 @@ static void cpu_common_finalize(Object *obj)
>  {
>      CPUState *cpu = CPU(obj);
>  
> -    g_array_free(cpu->gdb_regs, TRUE);

so free() is gone but new  gdb_unregister_coprocessor_all() ain't called,
are we staring to leak some memory here?

>      qemu_lockcnt_destroy(&cpu->in_ioctl_lock);
>      qemu_mutex_destroy(&cpu->work_mutex);
>  }
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index eb14b91139..249d4d4bc8 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -49,6 +49,12 @@ void gdb_register_coprocessor(CPUState *cpu,
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


