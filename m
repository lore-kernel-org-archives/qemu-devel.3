Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505CEC25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 16:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7H6r-0002N2-1o; Wed, 15 May 2024 12:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s7H6d-00028L-BK
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s7H6a-0000W4-GC
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715789027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pIPBGmf9yp3Oxdy1K/zj6zxRcx/G7iglIcn1aO7wTqM=;
 b=CXU2hpUzT5Gj+9wjJGCDgJAPu5XUP8tZihCHDL5W5wUt1xLv+tOMjRN4U/Bjhuc1F4PPfQ
 H1WE7xSfPfCsz3q2J2szHKpr5UVlKmMy4CtKETUwo5XtNfdr5bmwNcrnvZFYHgVqzgINuK
 cco9pxfVdA7hZ5FBNVeTe+GHqQwgKc0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-TatNabdnNK6va8Ex3UZVkA-1; Wed, 15 May 2024 12:03:44 -0400
X-MC-Unique: TatNabdnNK6va8Ex3UZVkA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2e41bd70238so65480611fa.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 09:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715789022; x=1716393822;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pIPBGmf9yp3Oxdy1K/zj6zxRcx/G7iglIcn1aO7wTqM=;
 b=SXKuN8g5X9LMFy6miCMLSvlLq32wnDPI792PTtrlckwagfGjuIPXcfbMiQ+pj7Uo3J
 gs6CINcq3ij1uEBbqktL906SnEET6w08EmrNDqctOWBPcEbVGaK8xd93pXAvf6Kvfj4H
 3c2IRqWiVr+cHHvp23ugMGu9Du17GVrk4xY17IxHe0e+FzXAM+ry7Wk1DS5B6SsxXJQq
 rJdgfvO473NEExPDkXDT8t13eaeVrWMAf7xSCZcaX3QAKAbCohxAcLqDL3naUSKWpjcM
 j6sand/JsPZ6sds77pjXCONhIlU1NpgKgFUnopfk7X2T0wz6OCBtB0oAc+KxlvUTDuOu
 oMzQ==
X-Gm-Message-State: AOJu0YyQCb9x6GVBdlmOgchqLMK78pN6Ur2Bj6XbjVayWaI78kmdou5M
 siPn6G7t3Qr/tIJ4ENGN+VTb3QVjUeGctSRK1pbBzdquXYoEIzfDHpPW50IOK3Ok+o38zsLi5Ng
 xVcjbWF34vrdaZ+w66qtmJgZQhir12fxyaIXO+uapqUwBxKsEjyim
X-Received: by 2002:a2e:93cf:0:b0:2e1:d94a:773f with SMTP id
 38308e7fff4ca-2e51fd2dcffmr102765281fa.11.1715789021647; 
 Wed, 15 May 2024 09:03:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/clW54uw6NAgfRJJHwanjkhale8Na9R0MiOSsCcV6PAcE7WLMiCWX9R1ebCtFM0Ho1dPrZg==
X-Received: by 2002:a2e:93cf:0:b0:2e1:d94a:773f with SMTP id
 38308e7fff4ca-2e51fd2dcffmr102764681fa.11.1715789020460; 
 Wed, 15 May 2024 09:03:40 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c01e:6df5:7e14:ad03:85bd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbc082sm16897669f8f.107.2024.05.15.09.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 09:03:39 -0700 (PDT)
Date: Wed, 15 May 2024 12:03:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3 4/5] Set major/minor for PC and arm machines
Message-ID: <20240515120304-mutt-send-email-mst@kernel.org>
References: <20240515141557.1277999-1-marcandre.lureau@redhat.com>
 <20240515141557.1277999-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240515141557.1277999-5-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

On Wed, May 15, 2024 at 06:15:55PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>


I would much rather compat machinery was in one place
as opposed to being spread all over the codebase as this
new API would encourage.

> ---
>  include/hw/i386/pc.h |  4 ++-
>  hw/arm/virt.c        |  2 ++
>  hw/i386/pc_piix.c    | 74 ++++++++++++++++++++++----------------------
>  hw/i386/pc_q35.c     | 62 ++++++++++++++++++-------------------
>  4 files changed, 73 insertions(+), 69 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index e52290916c..fa91bb7603 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -292,12 +292,14 @@ extern const size_t pc_compat_2_1_len;
>  extern GlobalProperty pc_compat_2_0[];
>  extern const size_t pc_compat_2_0_len;
>  
> -#define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
> +#define DEFINE_PC_MACHINE(maj, min, suffix, namestr, initfn, optsfn) \
>      static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
>      { \
>          MachineClass *mc = MACHINE_CLASS(oc); \
>          optsfn(mc); \
>          mc->init = initfn; \
> +        mc->major = maj; \
> +        mc->minor = min; \
>      } \
>      static const TypeInfo pc_machine_type_##suffix = { \
>          .name       = namestr TYPE_MACHINE_SUFFIX, \
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 3c93c0c0a6..7e3a03b39a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -109,6 +109,8 @@ static void arm_virt_compat_set(MachineClass *mc)
>          arm_virt_compat_set(mc); \
>          virt_machine_##major##_##minor##_options(mc); \
>          mc->desc = "QEMU " # major "." # minor " ARM Virtual Machine"; \
> +        mc->ma##jor = major; \
> +        mc->mi##nor = minor; \
>          if (latest) { \
>              mc->alias = "virt"; \
>          } \
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 99efb3c45c..bb6767d8d0 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -477,7 +477,7 @@ static void pc_xen_hvm_init(MachineState *machine)
>  }
>  #endif
>  
> -#define DEFINE_I440FX_MACHINE(suffix, name, compatfn, optionfn) \
> +#define DEFINE_I440FX_MACHINE(major, minor, suffix, name, compatfn, optionfn) \
>      static void pc_init_##suffix(MachineState *machine) \
>      { \
>          void (*compat)(MachineState *m) = (compatfn); \
> @@ -486,7 +486,7 @@ static void pc_xen_hvm_init(MachineState *machine)
>          } \
>          pc_init1(machine, TYPE_I440FX_PCI_DEVICE); \
>      } \
> -    DEFINE_PC_MACHINE(suffix, name, pc_init_##suffix, optionfn)
> +    DEFINE_PC_MACHINE(major, minor, suffix, name, pc_init_##suffix, optionfn)
>  
>  static void pc_i440fx_machine_options(MachineClass *m)
>  {
> @@ -521,7 +521,7 @@ static void pc_i440fx_9_1_machine_options(MachineClass *m)
>      m->is_default = true;
>  }
>  
> -DEFINE_I440FX_MACHINE(v9_1, "pc-i440fx-9.1", NULL,
> +DEFINE_I440FX_MACHINE(9, 1, v9_1, "pc-i440fx-9.1", NULL,
>                        pc_i440fx_9_1_machine_options);
>  
>  static void pc_i440fx_9_0_machine_options(MachineClass *m)
> @@ -534,7 +534,7 @@ static void pc_i440fx_9_0_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0", NULL,
> +DEFINE_I440FX_MACHINE(9, 0, v9_0, "pc-i440fx-9.0", NULL,
>                        pc_i440fx_9_0_machine_options);
>  
>  static void pc_i440fx_8_2_machine_options(MachineClass *m)
> @@ -549,7 +549,7 @@ static void pc_i440fx_8_2_machine_options(MachineClass *m)
>      pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
>  }
>  
> -DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2", NULL,
> +DEFINE_I440FX_MACHINE(8, 2, v8_2, "pc-i440fx-8.2", NULL,
>                        pc_i440fx_8_2_machine_options);
>  
>  static void pc_i440fx_8_1_machine_options(MachineClass *m)
> @@ -563,7 +563,7 @@ static void pc_i440fx_8_1_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1", NULL,
> +DEFINE_I440FX_MACHINE(8, 1, v8_1, "pc-i440fx-8.1", NULL,
>                        pc_i440fx_8_1_machine_options);
>  
>  static void pc_i440fx_8_0_machine_options(MachineClass *m)
> @@ -578,7 +578,7 @@ static void pc_i440fx_8_0_machine_options(MachineClass *m)
>      pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
>  }
>  
> -DEFINE_I440FX_MACHINE(v8_0, "pc-i440fx-8.0", NULL,
> +DEFINE_I440FX_MACHINE(8, 0, v8_0, "pc-i440fx-8.0", NULL,
>                        pc_i440fx_8_0_machine_options);
>  
>  static void pc_i440fx_7_2_machine_options(MachineClass *m)
> @@ -588,7 +588,7 @@ static void pc_i440fx_7_2_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_7_2, pc_compat_7_2_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v7_2, "pc-i440fx-7.2", NULL,
> +DEFINE_I440FX_MACHINE(7, 2, v7_2, "pc-i440fx-7.2", NULL,
>                        pc_i440fx_7_2_machine_options);
>  
>  static void pc_i440fx_7_1_machine_options(MachineClass *m)
> @@ -598,7 +598,7 @@ static void pc_i440fx_7_1_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_7_1, pc_compat_7_1_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v7_1, "pc-i440fx-7.1", NULL,
> +DEFINE_I440FX_MACHINE(7, 1, v7_1, "pc-i440fx-7.1", NULL,
>                        pc_i440fx_7_1_machine_options);
>  
>  static void pc_i440fx_7_0_machine_options(MachineClass *m)
> @@ -610,7 +610,7 @@ static void pc_i440fx_7_0_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_7_0, pc_compat_7_0_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v7_0, "pc-i440fx-7.0", NULL,
> +DEFINE_I440FX_MACHINE(7, 0, v7_0, "pc-i440fx-7.0", NULL,
>                        pc_i440fx_7_0_machine_options);
>  
>  static void pc_i440fx_6_2_machine_options(MachineClass *m)
> @@ -620,7 +620,7 @@ static void pc_i440fx_6_2_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_6_2, pc_compat_6_2_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v6_2, "pc-i440fx-6.2", NULL,
> +DEFINE_I440FX_MACHINE(6, 2, v6_2, "pc-i440fx-6.2", NULL,
>                        pc_i440fx_6_2_machine_options);
>  
>  static void pc_i440fx_6_1_machine_options(MachineClass *m)
> @@ -631,7 +631,7 @@ static void pc_i440fx_6_1_machine_options(MachineClass *m)
>      m->smp_props.prefer_sockets = true;
>  }
>  
> -DEFINE_I440FX_MACHINE(v6_1, "pc-i440fx-6.1", NULL,
> +DEFINE_I440FX_MACHINE(6, 1, v6_1, "pc-i440fx-6.1", NULL,
>                        pc_i440fx_6_1_machine_options);
>  
>  static void pc_i440fx_6_0_machine_options(MachineClass *m)
> @@ -641,7 +641,7 @@ static void pc_i440fx_6_0_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_6_0, pc_compat_6_0_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v6_0, "pc-i440fx-6.0", NULL,
> +DEFINE_I440FX_MACHINE(6, 0, v6_0, "pc-i440fx-6.0", NULL,
>                        pc_i440fx_6_0_machine_options);
>  
>  static void pc_i440fx_5_2_machine_options(MachineClass *m)
> @@ -651,7 +651,7 @@ static void pc_i440fx_5_2_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_5_2, pc_compat_5_2_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2", NULL,
> +DEFINE_I440FX_MACHINE(5, 2, v5_2, "pc-i440fx-5.2", NULL,
>                        pc_i440fx_5_2_machine_options);
>  
>  static void pc_i440fx_5_1_machine_options(MachineClass *m)
> @@ -665,7 +665,7 @@ static void pc_i440fx_5_1_machine_options(MachineClass *m)
>      pcmc->pci_root_uid = 1;
>  }
>  
> -DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1", NULL,
> +DEFINE_I440FX_MACHINE(5, 1, v5_1, "pc-i440fx-5.1", NULL,
>                        pc_i440fx_5_1_machine_options);
>  
>  static void pc_i440fx_5_0_machine_options(MachineClass *m)
> @@ -677,7 +677,7 @@ static void pc_i440fx_5_0_machine_options(MachineClass *m)
>      m->auto_enable_numa_with_memdev = false;
>  }
>  
> -DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
> +DEFINE_I440FX_MACHINE(5, 0, v5_0, "pc-i440fx-5.0", NULL,
>                        pc_i440fx_5_0_machine_options);
>  
>  static void pc_i440fx_4_2_machine_options(MachineClass *m)
> @@ -687,7 +687,7 @@ static void pc_i440fx_4_2_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2", NULL,
> +DEFINE_I440FX_MACHINE(4, 2, v4_2, "pc-i440fx-4.2", NULL,
>                        pc_i440fx_4_2_machine_options);
>  
>  static void pc_i440fx_4_1_machine_options(MachineClass *m)
> @@ -697,7 +697,7 @@ static void pc_i440fx_4_1_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
> +DEFINE_I440FX_MACHINE(4, 1, v4_1, "pc-i440fx-4.1", NULL,
>                        pc_i440fx_4_1_machine_options);
>  
>  static void pc_i440fx_4_0_machine_options(MachineClass *m)
> @@ -709,7 +709,7 @@ static void pc_i440fx_4_0_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0", NULL,
> +DEFINE_I440FX_MACHINE(4, 0, v4_0, "pc-i440fx-4.0", NULL,
>                        pc_i440fx_4_0_machine_options);
>  
>  static void pc_i440fx_3_1_machine_options(MachineClass *m)
> @@ -723,7 +723,7 @@ static void pc_i440fx_3_1_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
> +DEFINE_I440FX_MACHINE(3, 1, v3_1, "pc-i440fx-3.1", NULL,
>                        pc_i440fx_3_1_machine_options);
>  
>  static void pc_i440fx_3_0_machine_options(MachineClass *m)
> @@ -733,7 +733,7 @@ static void pc_i440fx_3_0_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_3_0, pc_compat_3_0_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
> +DEFINE_I440FX_MACHINE(3, 0, v3_0, "pc-i440fx-3.0", NULL,
>                        pc_i440fx_3_0_machine_options);
>  
>  static void pc_i440fx_2_12_machine_options(MachineClass *m)
> @@ -743,7 +743,7 @@ static void pc_i440fx_2_12_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12", NULL,
> +DEFINE_I440FX_MACHINE(2, 12, v2_12, "pc-i440fx-2.12", NULL,
>                        pc_i440fx_2_12_machine_options);
>  
>  static void pc_i440fx_2_11_machine_options(MachineClass *m)
> @@ -753,7 +753,7 @@ static void pc_i440fx_2_11_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_2_11, pc_compat_2_11_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11", NULL,
> +DEFINE_I440FX_MACHINE(2, 11, v2_11, "pc-i440fx-2.11", NULL,
>                        pc_i440fx_2_11_machine_options);
>  
>  static void pc_i440fx_2_10_machine_options(MachineClass *m)
> @@ -764,7 +764,7 @@ static void pc_i440fx_2_10_machine_options(MachineClass *m)
>      m->auto_enable_numa_with_memhp = false;
>  }
>  
> -DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
> +DEFINE_I440FX_MACHINE(2, 10, v2_10, "pc-i440fx-2.10", NULL,
>                        pc_i440fx_2_10_machine_options);
>  
>  static void pc_i440fx_2_9_machine_options(MachineClass *m)
> @@ -774,7 +774,7 @@ static void pc_i440fx_2_9_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
> +DEFINE_I440FX_MACHINE(2, 9, v2_9, "pc-i440fx-2.9", NULL,
>                        pc_i440fx_2_9_machine_options);
>  
>  static void pc_i440fx_2_8_machine_options(MachineClass *m)
> @@ -784,7 +784,7 @@ static void pc_i440fx_2_8_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_2_8, pc_compat_2_8_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
> +DEFINE_I440FX_MACHINE(2, 8, v2_8, "pc-i440fx-2.8", NULL,
>                        pc_i440fx_2_8_machine_options);
>  
>  static void pc_i440fx_2_7_machine_options(MachineClass *m)
> @@ -794,7 +794,7 @@ static void pc_i440fx_2_7_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v2_7, "pc-i440fx-2.7", NULL,
> +DEFINE_I440FX_MACHINE(2, 7, v2_7, "pc-i440fx-2.7", NULL,
>                        pc_i440fx_2_7_machine_options);
>  
>  static void pc_i440fx_2_6_machine_options(MachineClass *m)
> @@ -809,7 +809,7 @@ static void pc_i440fx_2_6_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6", NULL,
> +DEFINE_I440FX_MACHINE(2, 6, v2_6, "pc-i440fx-2.6", NULL,
>                        pc_i440fx_2_6_machine_options);
>  
>  static void pc_i440fx_2_5_machine_options(MachineClass *m)
> @@ -823,7 +823,7 @@ static void pc_i440fx_2_5_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v2_5, "pc-i440fx-2.5", NULL,
> +DEFINE_I440FX_MACHINE(2, 5, v2_5, "pc-i440fx-2.5", NULL,
>                        pc_i440fx_2_5_machine_options);
>  
>  static void pc_i440fx_2_4_machine_options(MachineClass *m)
> @@ -837,7 +837,7 @@ static void pc_i440fx_2_4_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4", NULL,
> +DEFINE_I440FX_MACHINE(2, 4, v2_4, "pc-i440fx-2.4", NULL,
>                        pc_i440fx_2_4_machine_options)
>  
>  static void pc_i440fx_2_3_machine_options(MachineClass *m)
> @@ -849,7 +849,7 @@ static void pc_i440fx_2_3_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_2_3, pc_compat_2_3_len);
>  }
>  
> -DEFINE_I440FX_MACHINE(v2_3, "pc-i440fx-2.3", pc_compat_2_3_fn,
> +DEFINE_I440FX_MACHINE(2, 3, v2_3, "pc-i440fx-2.3", pc_compat_2_3_fn,
>                        pc_i440fx_2_3_machine_options);
>  
>  static void pc_i440fx_2_2_machine_options(MachineClass *m)
> @@ -865,7 +865,7 @@ static void pc_i440fx_2_2_machine_options(MachineClass *m)
>      pcmc->resizable_acpi_blob = false;
>  }
>  
> -DEFINE_I440FX_MACHINE(v2_2, "pc-i440fx-2.2", pc_compat_2_2_fn,
> +DEFINE_I440FX_MACHINE(2, 2, v2_2, "pc-i440fx-2.2", pc_compat_2_2_fn,
>                        pc_i440fx_2_2_machine_options);
>  
>  static void pc_i440fx_2_1_machine_options(MachineClass *m)
> @@ -881,7 +881,7 @@ static void pc_i440fx_2_1_machine_options(MachineClass *m)
>      pcmc->enforce_aligned_dimm = false;
>  }
>  
> -DEFINE_I440FX_MACHINE(v2_1, "pc-i440fx-2.1", pc_compat_2_1_fn,
> +DEFINE_I440FX_MACHINE(2, 1, v2_1, "pc-i440fx-2.1", pc_compat_2_1_fn,
>                        pc_i440fx_2_1_machine_options);
>  
>  static void pc_i440fx_2_0_machine_options(MachineClass *m)
> @@ -913,7 +913,7 @@ static void pc_i440fx_2_0_machine_options(MachineClass *m)
>      pcmc->acpi_data_size = 0x10000;
>  }
>  
> -DEFINE_I440FX_MACHINE(v2_0, "pc-i440fx-2.0", pc_compat_2_0_fn,
> +DEFINE_I440FX_MACHINE(2, 0, v2_0, "pc-i440fx-2.0", pc_compat_2_0_fn,
>                        pc_i440fx_2_0_machine_options);
>  
>  #ifdef CONFIG_ISAPC
> @@ -936,7 +936,7 @@ static void isapc_machine_options(MachineClass *m)
>      m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
>  }
>  
> -DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
> +DEFINE_PC_MACHINE(0, 0, isapc, "isapc", pc_init_isa,
>                    isapc_machine_options);
>  #endif
>  
> @@ -949,7 +949,7 @@ static void xenfv_4_2_machine_options(MachineClass *m)
>      m->default_machine_opts = "accel=xen,suppress-vmdesc=on";
>  }
>  
> -DEFINE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
> +DEFINE_PC_MACHINE(4, 2, xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
>                    xenfv_4_2_machine_options);
>  
>  static void xenfv_3_1_machine_options(MachineClass *m)
> @@ -961,6 +961,6 @@ static void xenfv_3_1_machine_options(MachineClass *m)
>      m->default_machine_opts = "accel=xen,suppress-vmdesc=on";
>  }
>  
> -DEFINE_PC_MACHINE(xenfv, "xenfv-3.1", pc_xen_hvm_init,
> +DEFINE_PC_MACHINE(3, 1, xenfv, "xenfv-3.1", pc_xen_hvm_init,
>                    xenfv_3_1_machine_options);
>  #endif
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index bb53a51ac1..df3614b9bc 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -331,7 +331,7 @@ static void pc_q35_init(MachineState *machine)
>      }
>  }
>  
> -#define DEFINE_Q35_MACHINE(suffix, name, compatfn, optionfn) \
> +#define DEFINE_Q35_MACHINE(major, minor, suffix, name, compatfn, optionfn) \
>      static void pc_init_##suffix(MachineState *machine) \
>      { \
>          void (*compat)(MachineState *m) = (compatfn); \
> @@ -340,7 +340,7 @@ static void pc_q35_init(MachineState *machine)
>          } \
>          pc_q35_init(machine); \
>      } \
> -    DEFINE_PC_MACHINE(suffix, name, pc_init_##suffix, optionfn)
> +    DEFINE_PC_MACHINE(major, minor, suffix, name, pc_init_##suffix, optionfn)
>  
>  
>  static void pc_q35_machine_options(MachineClass *m)
> @@ -373,7 +373,7 @@ static void pc_q35_9_1_machine_options(MachineClass *m)
>      m->alias = "q35";
>  }
>  
> -DEFINE_Q35_MACHINE(v9_1, "pc-q35-9.1", NULL,
> +DEFINE_Q35_MACHINE(9, 1, v9_1, "pc-q35-9.1", NULL,
>                     pc_q35_9_1_machine_options);
>  
>  static void pc_q35_9_0_machine_options(MachineClass *m)
> @@ -384,7 +384,7 @@ static void pc_q35_9_0_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v9_0, "pc-q35-9.0", NULL,
> +DEFINE_Q35_MACHINE(9, 0, v9_0, "pc-q35-9.0", NULL,
>                     pc_q35_9_0_machine_options);
>  
>  static void pc_q35_8_2_machine_options(MachineClass *m)
> @@ -398,7 +398,7 @@ static void pc_q35_8_2_machine_options(MachineClass *m)
>      pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
>  }
>  
> -DEFINE_Q35_MACHINE(v8_2, "pc-q35-8.2", NULL,
> +DEFINE_Q35_MACHINE(8, 2, v8_2, "pc-q35-8.2", NULL,
>                     pc_q35_8_2_machine_options);
>  
>  static void pc_q35_8_1_machine_options(MachineClass *m)
> @@ -410,7 +410,7 @@ static void pc_q35_8_1_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v8_1, "pc-q35-8.1", NULL,
> +DEFINE_Q35_MACHINE(8, 1, v8_1, "pc-q35-8.1", NULL,
>                     pc_q35_8_1_machine_options);
>  
>  static void pc_q35_8_0_machine_options(MachineClass *m)
> @@ -426,7 +426,7 @@ static void pc_q35_8_0_machine_options(MachineClass *m)
>      m->max_cpus = 288;
>  }
>  
> -DEFINE_Q35_MACHINE(v8_0, "pc-q35-8.0", NULL,
> +DEFINE_Q35_MACHINE(8, 0, v8_0, "pc-q35-8.0", NULL,
>                     pc_q35_8_0_machine_options);
>  
>  static void pc_q35_7_2_machine_options(MachineClass *m)
> @@ -436,7 +436,7 @@ static void pc_q35_7_2_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_7_2, pc_compat_7_2_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v7_2, "pc-q35-7.2", NULL,
> +DEFINE_Q35_MACHINE(7, 2, v7_2, "pc-q35-7.2", NULL,
>                     pc_q35_7_2_machine_options);
>  
>  static void pc_q35_7_1_machine_options(MachineClass *m)
> @@ -446,7 +446,7 @@ static void pc_q35_7_1_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_7_1, pc_compat_7_1_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v7_1, "pc-q35-7.1", NULL,
> +DEFINE_Q35_MACHINE(7, 1, v7_1, "pc-q35-7.1", NULL,
>                     pc_q35_7_1_machine_options);
>  
>  static void pc_q35_7_0_machine_options(MachineClass *m)
> @@ -458,7 +458,7 @@ static void pc_q35_7_0_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_7_0, pc_compat_7_0_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v7_0, "pc-q35-7.0", NULL,
> +DEFINE_Q35_MACHINE(7, 0, v7_0, "pc-q35-7.0", NULL,
>                     pc_q35_7_0_machine_options);
>  
>  static void pc_q35_6_2_machine_options(MachineClass *m)
> @@ -468,7 +468,7 @@ static void pc_q35_6_2_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_6_2, pc_compat_6_2_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v6_2, "pc-q35-6.2", NULL,
> +DEFINE_Q35_MACHINE(6, 2, v6_2, "pc-q35-6.2", NULL,
>                     pc_q35_6_2_machine_options);
>  
>  static void pc_q35_6_1_machine_options(MachineClass *m)
> @@ -479,7 +479,7 @@ static void pc_q35_6_1_machine_options(MachineClass *m)
>      m->smp_props.prefer_sockets = true;
>  }
>  
> -DEFINE_Q35_MACHINE(v6_1, "pc-q35-6.1", NULL,
> +DEFINE_Q35_MACHINE(6, 1, v6_1, "pc-q35-6.1", NULL,
>                     pc_q35_6_1_machine_options);
>  
>  static void pc_q35_6_0_machine_options(MachineClass *m)
> @@ -489,7 +489,7 @@ static void pc_q35_6_0_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_6_0, pc_compat_6_0_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v6_0, "pc-q35-6.0", NULL,
> +DEFINE_Q35_MACHINE(6, 0, v6_0, "pc-q35-6.0", NULL,
>                     pc_q35_6_0_machine_options);
>  
>  static void pc_q35_5_2_machine_options(MachineClass *m)
> @@ -499,7 +499,7 @@ static void pc_q35_5_2_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_5_2, pc_compat_5_2_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v5_2, "pc-q35-5.2", NULL,
> +DEFINE_Q35_MACHINE(5, 2, v5_2, "pc-q35-5.2", NULL,
>                     pc_q35_5_2_machine_options);
>  
>  static void pc_q35_5_1_machine_options(MachineClass *m)
> @@ -513,7 +513,7 @@ static void pc_q35_5_1_machine_options(MachineClass *m)
>      pcmc->pci_root_uid = 1;
>  }
>  
> -DEFINE_Q35_MACHINE(v5_1, "pc-q35-5.1", NULL,
> +DEFINE_Q35_MACHINE(5, 1, v5_1, "pc-q35-5.1", NULL,
>                     pc_q35_5_1_machine_options);
>  
>  static void pc_q35_5_0_machine_options(MachineClass *m)
> @@ -525,7 +525,7 @@ static void pc_q35_5_0_machine_options(MachineClass *m)
>      m->auto_enable_numa_with_memdev = false;
>  }
>  
> -DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
> +DEFINE_Q35_MACHINE(5, 0, v5_0, "pc-q35-5.0", NULL,
>                     pc_q35_5_0_machine_options);
>  
>  static void pc_q35_4_2_machine_options(MachineClass *m)
> @@ -535,7 +535,7 @@ static void pc_q35_4_2_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v4_2, "pc-q35-4.2", NULL,
> +DEFINE_Q35_MACHINE(4, 2, v4_2, "pc-q35-4.2", NULL,
>                     pc_q35_4_2_machine_options);
>  
>  static void pc_q35_4_1_machine_options(MachineClass *m)
> @@ -545,7 +545,7 @@ static void pc_q35_4_1_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
> +DEFINE_Q35_MACHINE(4, 1, v4_1, "pc-q35-4.1", NULL,
>                     pc_q35_4_1_machine_options);
>  
>  static void pc_q35_4_0_1_machine_options(MachineClass *m)
> @@ -562,7 +562,7 @@ static void pc_q35_4_0_1_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v4_0_1, "pc-q35-4.0.1", NULL,
> +DEFINE_Q35_MACHINE(4, 0, v4_0_1, "pc-q35-4.0.1", NULL,
>                     pc_q35_4_0_1_machine_options);
>  
>  static void pc_q35_4_0_machine_options(MachineClass *m)
> @@ -572,7 +572,7 @@ static void pc_q35_4_0_machine_options(MachineClass *m)
>      /* Compat props are applied by the 4.0.1 machine */
>  }
>  
> -DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
> +DEFINE_Q35_MACHINE(4, 0, v4_0, "pc-q35-4.0", NULL,
>                     pc_q35_4_0_machine_options);
>  
>  static void pc_q35_3_1_machine_options(MachineClass *m)
> @@ -587,7 +587,7 @@ static void pc_q35_3_1_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v3_1, "pc-q35-3.1", NULL,
> +DEFINE_Q35_MACHINE(3, 1, v3_1, "pc-q35-3.1", NULL,
>                     pc_q35_3_1_machine_options);
>  
>  static void pc_q35_3_0_machine_options(MachineClass *m)
> @@ -597,7 +597,7 @@ static void pc_q35_3_0_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_3_0, pc_compat_3_0_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,
> +DEFINE_Q35_MACHINE(3, 0, v3_0, "pc-q35-3.0", NULL,
>                      pc_q35_3_0_machine_options);
>  
>  static void pc_q35_2_12_machine_options(MachineClass *m)
> @@ -607,7 +607,7 @@ static void pc_q35_2_12_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v2_12, "pc-q35-2.12", NULL,
> +DEFINE_Q35_MACHINE(2, 12, v2_12, "pc-q35-2.12", NULL,
>                     pc_q35_2_12_machine_options);
>  
>  static void pc_q35_2_11_machine_options(MachineClass *m)
> @@ -618,7 +618,7 @@ static void pc_q35_2_11_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_2_11, pc_compat_2_11_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v2_11, "pc-q35-2.11", NULL,
> +DEFINE_Q35_MACHINE(2, 11, v2_11, "pc-q35-2.11", NULL,
>                     pc_q35_2_11_machine_options);
>  
>  static void pc_q35_2_10_machine_options(MachineClass *m)
> @@ -629,7 +629,7 @@ static void pc_q35_2_10_machine_options(MachineClass *m)
>      m->auto_enable_numa_with_memhp = false;
>  }
>  
> -DEFINE_Q35_MACHINE(v2_10, "pc-q35-2.10", NULL,
> +DEFINE_Q35_MACHINE(2, 10, v2_10, "pc-q35-2.10", NULL,
>                     pc_q35_2_10_machine_options);
>  
>  static void pc_q35_2_9_machine_options(MachineClass *m)
> @@ -639,7 +639,7 @@ static void pc_q35_2_9_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v2_9, "pc-q35-2.9", NULL,
> +DEFINE_Q35_MACHINE(2, 9, v2_9, "pc-q35-2.9", NULL,
>                     pc_q35_2_9_machine_options);
>  
>  static void pc_q35_2_8_machine_options(MachineClass *m)
> @@ -649,7 +649,7 @@ static void pc_q35_2_8_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_2_8, pc_compat_2_8_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v2_8, "pc-q35-2.8", NULL,
> +DEFINE_Q35_MACHINE(2, 8, v2_8, "pc-q35-2.8", NULL,
>                     pc_q35_2_8_machine_options);
>  
>  static void pc_q35_2_7_machine_options(MachineClass *m)
> @@ -660,7 +660,7 @@ static void pc_q35_2_7_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v2_7, "pc-q35-2.7", NULL,
> +DEFINE_Q35_MACHINE(2, 7, v2_7, "pc-q35-2.7", NULL,
>                     pc_q35_2_7_machine_options);
>  
>  static void pc_q35_2_6_machine_options(MachineClass *m)
> @@ -675,7 +675,7 @@ static void pc_q35_2_6_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v2_6, "pc-q35-2.6", NULL,
> +DEFINE_Q35_MACHINE(2, 6, v2_6, "pc-q35-2.6", NULL,
>                     pc_q35_2_6_machine_options);
>  
>  static void pc_q35_2_5_machine_options(MachineClass *m)
> @@ -689,7 +689,7 @@ static void pc_q35_2_5_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v2_5, "pc-q35-2.5", NULL,
> +DEFINE_Q35_MACHINE(2, 5, v2_5, "pc-q35-2.5", NULL,
>                     pc_q35_2_5_machine_options);
>  
>  static void pc_q35_2_4_machine_options(MachineClass *m)
> @@ -703,5 +703,5 @@ static void pc_q35_2_4_machine_options(MachineClass *m)
>      compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
>  }
>  
> -DEFINE_Q35_MACHINE(v2_4, "pc-q35-2.4", NULL,
> +DEFINE_Q35_MACHINE(2, 4, v2_4, "pc-q35-2.4", NULL,
>                     pc_q35_2_4_machine_options);
> -- 
> 2.41.0.28.gd7d8841f67


