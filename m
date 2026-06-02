Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002FBCD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUP7B-0003zn-7d; Tue, 02 Jun 2026 09:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wUP6s-0003iB-V6; Tue, 02 Jun 2026 09:24:48 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wUP6r-00012L-1f; Tue, 02 Jun 2026 09:24:46 -0400
Received: from example.com (unknown [167.220.208.33])
 by linux.microsoft.com (Postfix) with ESMTPSA id EDCB320B7167;
 Tue,  2 Jun 2026 06:24:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EDCB320B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1780406668;
 bh=LCOwzis7g194ZBNNfE6h7mPzrsYvjco0QzpQSBmnjkg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YaHEezITzNoC7Q2rATMpRImS9cXDTSoaOAUFGQmVBOvlGAovO1ksXCjbVq6Mhcv6p
 K7V5Nwb+XxhCjvCY+ZgP3neRhlBem9mwHaH82QQvzw1TnRS2OnDJRuM9OkLOoIHOS+
 DrfpBrszGhyeAW0AYjzzRXQwlv5LKZYLADWngBrE=
Date: Tue, 2 Jun 2026 15:24:35 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Aastha Rawat <aastharawat@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v4 10/15] accel/mshv: implement cpu_thread_is_idle() hook
Message-ID: <ah7ZkxbmEMOgQw+5@example.com>
References: <20260527-mshv_accel_arm64_supp-v4-0-66d871dcdc53@linux.microsoft.com>
 <20260527-mshv_accel_arm64_supp-v4-10-66d871dcdc53@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-mshv_accel_arm64_supp-v4-10-66d871dcdc53@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 27, 2026 at 05:00:46AM +0000, Aastha Rawat wrote:
> From: Magnus Kulke <magnuskulke@linux.microsoft.com>
> 
> In MSHV the hypervisor APIC is always used, so we to implement this hook
> to make sure the AP's vcpu thread is not blocked waiting for an INIT SIPI
> by the BSP. Without this change soft reboots with -smp cpus>=2 will
> hang.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 927e1b39bb..61a9d58546 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -719,11 +719,23 @@ static const TypeInfo mshv_accel_type = {
>      .instance_size = sizeof(MshvState),
>  };
>  
> +/*
> + * Haulted vCPUs must still enter mshv_cpu_exec() so that MSHV_RUN_VP
> + * is called and the hypervisor can wake them (via SIPI on x86 or
> + * PSCI on ARM64).
> + */
> +
> +static bool mshv_vcpu_thread_is_idle(CPUState *cpu)
> +{
> +    return false;
> +}
> +
>  static void mshv_accel_ops_class_init(ObjectClass *oc, const void *data)
>  {
>      AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
>  
>      ops->create_vcpu_thread = mshv_start_vcpu_thread;
> +    ops->cpu_thread_is_idle = mshv_vcpu_thread_is_idle;
>      ops->synchronize_post_init = mshv_cpu_synchronize_post_init;
>      ops->synchronize_post_reset = mshv_cpu_synchronize_post_reset;
>      ops->synchronize_state = mshv_cpu_synchronize;
> 
> -- 
> 2.45.4

this has been merged independently since: dbfb680772d5184544f7c0a8bba96bec229c96e6

best,

magnus

