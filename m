Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E9FCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKKn-0007VF-Bz; Thu, 15 Oct 2026 08:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHKKk-0007UF-Hl
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHKKi-0003mA-Jd
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066395;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ZS8O6pAKs14B2vAv0EVl9bnzCeWoqf8Dh1MzJORQ00=;
 b=THgLQDbEzhIo2/L38TSAvRyj0kEYoR2MooqF7J0pHYcD/sNUZrYroidzEQqlBmsmQxWxnH
 gtZX+8Jl0Ls05vNi8g6UxPhL53zO4DapwhvqCIDabaI1Kmig0hRPfljeQTUiZJZtuCM15o
 TRq/UUbQfqCu63fQHiP4/2XxZ6/E0fg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-YDuxhffIOdKMXh1zcrjqvQ-1; Thu, 15 Oct 2026 12:13:11 +0000
X-MC-Unique: YDuxhffIOdKMXh1zcrjqvQ-1
X-Mimecast-MFC-AGG-ID: YDuxhffIOdKMXh1zcrjqvQ_1792066390
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a019d53f46so15855035e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 05:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792066390; x=1792671190;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6ZS8O6pAKs14B2vAv0EVl9bnzCeWoqf8Dh1MzJORQ00=;
 b=I3qLn3Yvbs67eoW4UBP6bTtsVPfvFHTaktk73qjr5gxiP1X096GARKz0t5EOoIJStH
 a6XDQAZo5c75vx1v2Q5vNPmoXD4QQKC2PM/7PWj5SUaJ/YeozQemZGRT8Mx3uoUkRRD3
 G3KaaHgqh0ehlDEP+2JQUTVatRM4J+PtfSOxyUyD2iJH/B34iHKfYQiPCuUOHYK3cgvh
 zgYtHJxuUtXuzfmcBzL7xzooWAtrIShyr8ZOZnsxPvlbsb4rKVlNosNjZSk7/z85Z3DT
 okt1C2WCS9vVQRWUKzhLeaTcaC9RCeczCqLf3xBA360/TplpVhb4IdRL63VI7vIlFWzT
 9Ncw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEXNo8m5L8fea2TgVJPc4QM0jqboi5SUdf5xsyqOyhd7nZt+vRBITUp5Wb/0F8AyQn0VmEUlZdXurs@nongnu.org
X-Gm-Message-State: AFq9FYIu+ef1EMbKnM8WB0dDtqHlAt9/pfZc/5De0/lLxI6k8ERB85KL
 U/tV7bdOF/UU9kGHDsQ6U+LuAgJlo8hV7NBT91r7Q3iSZ2eRFpC271PlQZdxkwjXsrIsb6HZxe9
 bksXt+ys4Z4NoIYcjl9yawYXzbm7O2aGlXsKZxq3tTSn10t+Sjh0Ioeaz
X-Gm-Gg: AYBFou3HGmE+A5aOBVN/Q+1HVUfxd0WGCp2BpUKgI8Kz6X85FMzalidS46/aAJQLVSn
 kHktGmXw5KuP3eeNsfETpPNDRvLtqKONXrDQKToo0GeD3JeO4jsZIFIYg8hkNWOJ9hXB9hI72tG
 iPwTBbmSTK+8tJFLxaO4+MlF5cQs2zFffeA3hY48QqJS6wO1DUbwqK2E/MLxoO03tZLSYQ3LdRb
 iBVWudP8OekwUfX2trkFNgGU1SbA4IScazOglzBzi1V3Y8iC9bP4PBxwoETdQPTb9X5O4EOIGTp
 MwoanEfLiuHe1IiiZRIh3i2xDJvHAKHtNN1gY6eAjbAazL1xV2SF++5Y2zDuKGbKcO2h1xoAXAH
 WCDNlBk2Fdv4KdhuFs1uNH1/IdH2zGQ9e2EyMok35NMGW0uQ3
X-Received: by 2002:a05:600c:3b98:b0:499:79b9:e220 with SMTP id
 5b1f17b1804b1-4a18e49886amr424421035e9.10.1792066390230; 
 Thu, 15 Oct 2026 05:13:10 -0700 (PDT)
X-Received: by 2002:a05:600c:3b98:b0:499:79b9:e220 with SMTP id
 5b1f17b1804b1-4a18e49886amr424420585e9.10.1792066389771; 
 Thu, 15 Oct 2026 05:13:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd99faf3sm66449875e9.14.2026.10.15.05.13.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 05:13:09 -0700 (PDT)
Message-ID: <395b66c9-4173-401b-b469-8972b710aae2@redhat.com>
Date: Thu, 15 Oct 2026 14:13:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 14/25] target/arm: add neoverse-v2-v2 named CPU
 model
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
 <20260921123249.1708067-15-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260921123249.1708067-15-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Khushit,

On 9/21/26 2:32 PM, Khushit Shah wrote:
> Add a KVM-only named CPU model for Neoverse V2 r0p1 (TRM 102375),
> inheriting from neoverse-v2-v1 (r0p0).
>
> r0p1 only changes MIDR_EL1.Revision and adds FEAT_ECBHB
> (ID_AA64MMFR1_EL1.ECBHB).
>
> Final ID register state requested from KVM for "neoverse-v2-v2":
> [  0] AIDR_EL1                 = 0x0000000000000000
> [  1] CLIDR_EL1                = 0x0000000000000000
> [  2] CTR_EL0                  = 0x000000009444c004
> [  3] DCZID_EL0                = 0x0000000000000004
> [  4] GMID_EL1                 = 0x0000000000000000
> [  5] ID_AA64AFR0_EL1          = 0x0000000000000000
> [  6] ID_AA64AFR1_EL1          = 0x0000000000000000
> [  7] ID_AA64DFR0_EL1          = 0x000000f010305009
> [  8] ID_AA64DFR1_EL1          = 0x0000000000000000
> [  9] ID_AA64DFR2_EL1          = 0x0000000000000000
> [ 10] ID_AA64FPFR0_EL1         = 0x0000000000000000
> [ 11] ID_AA64ISAR0_EL1         = 0x0221100010210000
> [ 12] ID_AA64ISAR1_EL1         = 0x0011111101211052
> [ 13] ID_AA64ISAR2_EL1         = 0x0000000000000000
> [ 14] ID_AA64ISAR3_EL1         = 0x0000000000000000
> [ 15] ID_AA64MMFR0_EL1         = 0x0000011100101125
> [ 16] ID_AA64MMFR1_EL1         = 0x1000000010312122
> [ 17] ID_AA64MMFR2_EL1         = 0x1221011110001011
> [ 18] ID_AA64MMFR3_EL1         = 0x0000000000000000
> [ 19] ID_AA64MMFR4_EL1         = 0x0000000000000000
> [ 20] ID_AA64PFR0_EL1          = 0x1101000120110011
> [ 21] ID_AA64PFR1_EL1          = 0x0000000000000021
> [ 22] ID_AA64PFR2_EL1          = 0x0000000000000000
> [ 23] ID_AA64SMFR0_EL1         = 0x0000000000000000
> [ 24] ID_AA64ZFR0_EL1          = 0x0000100000110001
> [ 25] ID_AFR0_EL1              = 0x0000000000000000
> [ 26] ID_DFR0_EL1              = 0x0000000000000000
> [ 27] ID_DFR1_EL1              = 0x0000000000000000
> [ 28] ID_ISAR0_EL1             = 0x0000000000000000
> [ 29] ID_ISAR1_EL1             = 0x0000000000000000
> [ 30] ID_ISAR2_EL1             = 0x0000000000000000
> [ 31] ID_ISAR3_EL1             = 0x0000000000000000
> [ 32] ID_ISAR4_EL1             = 0x0000000000000000
> [ 33] ID_ISAR5_EL1             = 0x0000000000000000
> [ 34] ID_ISAR6_EL1             = 0x0000000000000000
> [ 35] ID_MMFR0_EL1             = 0x0000000000000000
> [ 36] ID_MMFR1_EL1             = 0x0000000000000000
> [ 37] ID_MMFR2_EL1             = 0x0000000000000000
> [ 38] ID_MMFR3_EL1             = 0x0000000000000000
> [ 39] ID_MMFR4_EL1             = 0x0000000000000000
> [ 40] ID_MMFR5_EL1             = 0x0000000000000000
> [ 41] ID_PFR0_EL1              = 0x0000000000000000
> [ 42] ID_PFR1_EL1              = 0x0000000000000000
> [ 43] ID_PFR2_EL1              = 0x0000000000000000
> [ 44] MIDR_EL1                 = 0x00000000410fd4f1
> [ 45] MPIDR_EL1                = 0x0000000080000000
> [ 46] MVFR0_EL1                = 0x0000000000000000
> [ 47] MVFR1_EL1                = 0x0000000000000000
> [ 48] MVFR2_EL1                = 0x0000000000000000
> [ 49] REVIDR_EL1               = 0x0000000000000000
> [ 50] SMIDR_EL1                = 0x0000000000000000
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  hw/arm/virt.c           |  1 +
>  target/arm/cpu-models.c | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f5a8ea1145..90e818690c 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -4147,6 +4147,7 @@ static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
>      if (kvm_enabled() && target_aarch64()) {
>          g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("arm-v9.0-a-v1")));
>          g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-v2-v1")));
> +        g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("neoverse-v2-v2")));
>      }
>      if (target_aarch64()) {
>          g_ptr_array_add(vct, g_strdup(ARM_CPU_TYPE_NAME("cortex-a53")));
> diff --git a/target/arm/cpu-models.c b/target/arm/cpu-models.c
> index 2de67f353b..af60924953 100644
> --- a/target/arm/cpu-models.c
> +++ b/target/arm/cpu-models.c
> @@ -16,6 +16,7 @@
>   * Current Hierarchy:
>   * arm-v9.0-a-v1
>   *   neoverse-v2-v1 (r0p0)
> + *     neoverse-v2-v2 (r0p1)
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
> @@ -212,9 +213,21 @@ static const ArmModelPropValue neoverse_v2_v1_props[] = {
>      MODEL_PROP_END
>  };
>  
> +/* Neoverse V2 CPU model (TRM 102375, r0p1), inherits from neoverse-v2-v1. */
> +static const ArmModelPropValue neoverse_v2_v2_props[] = {
> +    /* MIDR_EL1 */
> +    MODEL_PROP("SYSREG_MIDR_EL1_Revision", NUM, 0x1), /* r0p1 */
> +
> +    /* ID_AA64MMFR1_EL1 */
> +    MODEL_PROP("SYSREG_ID_AA64MMFR1_EL1_ECBHB", NUM, 1), /* FEAT_ECBHB */
> +
> +    MODEL_PROP_END,
> +};
> +
>  static const ArmNamedCpuModel arm_cpu_models[] = {
>      {"arm-v9.0-a-v1", NULL, arm_v9_0_a_v1_props},
>      {"neoverse-v2-v1", "arm-v9.0-a-v1", neoverse_v2_v1_props},
> +    {"neoverse-v2-v2", "neoverse-v2-v1", neoverse_v2_v2_props},
nit I would call it directly neoverse-v2-r0p1 and leave the -v<n> suffix
for potential fixes. Same for r0p0 obviously.

Thanks

Eric
>      {NULL, NULL, NULL}
>  };
>  


