Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB508C9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9PjX-0000rx-UH; Wed, 23 Sep 2026 12:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x9PjW-0000qt-7O
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 12:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x9PjU-0004LO-L5
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 12:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790180527;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H4D47+Kf84D/M5AvyLwBNOHI4bu1uWl4MXTV5Y9W2XM=;
 b=EmfFWbT1uSnybtncyvEC7BHamgDrRlgTeZUOOAdl4WtoXRhHvcbW1ST/ZpjAZwLHqQjMnV
 cAeH3K61B4OIL/QvJzuxsPkkQgciggGtOL3vsx0i97qpktvGUB89YodnhQ+KNPhEQe7L5p
 xLzf+hpoEzYsCXSABI/yCVnjEuZmkuI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-kX70Z55JOoS4hyRpMyc7Ow-1; Wed, 23 Sep 2026 12:22:05 -0400
X-MC-Unique: kX70Z55JOoS4hyRpMyc7Ow-1
X-Mimecast-MFC-AGG-ID: kX70Z55JOoS4hyRpMyc7Ow_1790180525
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48706ee8fbaso826562f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 09:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790180524; x=1790785324;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H4D47+Kf84D/M5AvyLwBNOHI4bu1uWl4MXTV5Y9W2XM=;
 b=ZD6u7s2cjP4dWQ+MPENvghks40FAvXkJ/E0hiaebwxTRCQNYpLMcPAhWYTBsOIETjY
 pStmZaCfuFWWvffRQaD9D8CjL0dmMg8wGoTiW1FjMJK5k+Vz9ew7EgMpKqqSENNQXFbl
 vfrmnFvyHGkHvv0KpdHRIi1Hhzlic19OMEH8x6V4z9THCUAhyWwHP9z2tty/D8RhZY7X
 HAWJ5izSjd/oRmDZ0Gz5o9lcNP6Xbvs45b/kQMcZvp11gVtunruDY5TlAMHisbLTuSg5
 oOhsZDiSqw7MSUIKmiEfDbzNrv07uSkYux5wNszSiAgMPebyMjCD+PVhJTB9i8bZ4fSy
 VcfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOaB1qm2XqroIXs4DyCTNyNsmkpZMy8pIwV32Y6Fz6GxgIpDrwGp8ZPlTJeFYF2YcZLKGU7qErvC3S@nongnu.org
X-Gm-Message-State: AFuF++l7urDrupVtNC4zJd4okUZ7W+LK9OZ3Fa6FyidWkKE49zwOi415
 stpDxBhxTSSroXoIJaIxAVNqe9GCVj7eeUK14sTYy6mfQ8pNvldrgSAa8UKdWLQRTH0ifr8RAco
 mItkXWMLW2cGp2tKVyyJIbmGdMCDpFM9FISuT+vmZ3dkE/wYUGm41S3l5Kfrr3feJ
X-Gm-Gg: AYBFou2PlMG2Ziupn0uhBAkFfWEjA+RelrZIQBII7oEukXRAdtsCtvFgGVDqxBXbfsh
 DMgiqYpGERLYSffsz3dhdONx7otaz+dRD8buRZtZPunEOAEgCsPO9C7VJDup9FUeDXRy7db8aSF
 edGM+xsXeGenEn3WYmfzSqP9z7E29fQCPZsmSPwtnAnAMOhxHgJtZTeBPIXOt62T8tCpSm8wvU2
 B0in8aQ76ozEO1AIZnqvwPFLI7CkWrL8T3CYEsmN5OY1p0qJFLopS8p6RW43J224OBSvzCoa+dF
 0bDqlCGumZjchUcCKnJiQjknZjpjYSni5n8HxXJ/subuPJeN6Ki/X0nhX/RO3Rs6/vvZq1qgbG8
 x1HAA+PRmuhia6Ug4JA39dbt2l07ELtjREp1cta5GsyEEl3pb
X-Received: by 2002:a05:600c:1f8c:b0:49c:fc6e:a3d2 with SMTP id
 5b1f17b1804b1-49fdf12f2b5mr49459805e9.17.1790180524567; 
 Wed, 23 Sep 2026 09:22:04 -0700 (PDT)
X-Received: by 2002:a05:600c:1f8c:b0:49c:fc6e:a3d2 with SMTP id
 5b1f17b1804b1-49fdf12f2b5mr49459355e9.17.1790180524146; 
 Wed, 23 Sep 2026 09:22:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde18555bsm91240255e9.2.2026.09.23.09.22.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 09:22:03 -0700 (PDT)
Message-ID: <59aff568-9101-4f0a-ae62-61a32b8c1935@redhat.com>
Date: Wed, 23 Sep 2026 18:22:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 01/25] target/arm: expose SYSREG_ props for
 REVIDR_EL1 and AIDR_EL1
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
Cc: cohuck@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 gshan@redhat.com, skolothumtho@nvidia.com, sebott@redhat.com,
 armbru@redhat.com, philmd@linaro.org, yangjinqian1@huawei.com,
 shaju.abraham@nutanix.com, mark.caveayland@nutanix.com,
 ping@khushitshah.com, sandesh.patel@nutanix.com
References: <20260921123249.1708067-1-khushit.shah@nutanix.com>
 <20260921123249.1708067-2-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260921123249.1708067-2-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Khushit,

On 9/21/26 2:32 PM, Khushit Shah wrote:
> REVIDR_EL1 and AIDR_EL1 are implementation-defined and have no named
> fields in Registers.json.
>
> Emit dummy VAL fields covering the full register for these registers
> in scripts/update-aarch64-cpu-sysreg-properties.py, then remove the
> special case for these in kvm_arm_expose_idreg_properties(), exposing
> them as SYSREG_ props.
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  scripts/update-aarch64-cpu-sysreg-properties.py |  9 +++++++++
>  target/arm/cpu-idregs.h.inc                     |  2 ++
>  target/arm/kvm.c                                | 10 +---------
>  3 files changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/scripts/update-aarch64-cpu-sysreg-properties.py b/scripts/update-aarch64-cpu-sysreg-properties.py
> index 0b4e4d3e0c..2269063408 100644
> --- a/scripts/update-aarch64-cpu-sysreg-properties.py
> +++ b/scripts/update-aarch64-cpu-sysreg-properties.py
> @@ -246,6 +246,15 @@ def generate_sysreg_properties_from_registers_json(id_reg_names, raw_json_path):
>          # Sort decreasing lsbs
>          sorted_fields = sorted(unique_fields.items(),
>                                 key=lambda x: x[1]['lsb'], reverse=True)
> +        if len(sorted_fields) == 0:
> +            # For cases like REVIDR_EL1, add a dummy field covering the
> +            # full register.
> +            sorted_fields.append(('VAL', {
though I think it is important the property name stays SYSREG_REVIDR_EL1
and not SYSREG_REVIDR_EL1_VAL so I guess we need either a property alias
or a special handling for those regs (better as alias were not really
meant for that purpose I think).

Eric
> +                'lsb': 0,
> +                'msb': 63,
> +                'width': 64,
> +                'enums': []
> +            }))
>  
>          for unique_key, bits in sorted_fields:
>              enums_list = bits.get('enums', [])
> diff --git a/target/arm/cpu-idregs.h.inc b/target/arm/cpu-idregs.h.inc
> index c7e93c48b7..bc52112430 100644
> --- a/target/arm/cpu-idregs.h.inc
> +++ b/target/arm/cpu-idregs.h.inc
> @@ -12,6 +12,7 @@
>  /* IDREG_END(REG) */
>  
>  IDREG_START(AIDR_EL1)
> +    IDREG_FIELD(AIDR_EL1, VAL, 0, 64)
>  IDREG_END(AIDR_EL1)
>  
>  IDREG_START(CLIDR_EL1)
> @@ -2438,6 +2439,7 @@ IDREG_START(MVFR2_EL1)
>  IDREG_END(MVFR2_EL1)
>  
>  IDREG_START(REVIDR_EL1)
> +    IDREG_FIELD(REVIDR_EL1, VAL, 0, 64)
>  IDREG_END(REVIDR_EL1)
>  
>  IDREG_START(SMIDR_EL1)
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index e3a0dc07de..8a823d0324 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -554,15 +554,7 @@ void kvm_arm_expose_idreg_properties(ARMCPU *cpu, ARM64SysReg *regs)
>          ARM64SysReg *sysregdesc = &regs[i];
>  
>          if (sysregdesc->writable_mask) {
> -            /*
> -             * special case REVIDR_EL1 and AIDR_EL1 which are writable but
> -             * do not expose named fields. They will need to be handled
> -             * separately
> -             */
> -            if (strcmp(sysregdesc->name, "REVIDR_EL1") &&
> -                strcmp(sysregdesc->name, "AIDR_EL1")) {
> -                decode_idreg_writemap(obj, sysregdesc);
> -            }
> +            decode_idreg_writemap(obj, sysregdesc);
>          }
>      }
>  }


