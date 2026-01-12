Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E07C9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJti-00011B-Fp; Mon, 12 Jan 2026 10:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1vfJtd-00010k-PQ
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 10:32:00 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1vfJtc-0007YW-DJ
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 10:31:57 -0500
Received: from example.com (unknown [167.220.208.95])
 by linux.microsoft.com (Postfix) with ESMTPSA id A68C12126E44;
 Mon, 12 Jan 2026 07:31:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A68C12126E44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1768231913;
 bh=EQxEO7h87mep765CWv+P2/ONJAGJRV+A0ylhgI+ieIw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Qgpm0hfuEcp9hn+B7shC6CqtFWdVhsjmHxWaPcf58UnHH7+MBVTndPETFxIRG8SaL
 OuTjq5TdvhHKBXaJF0nl8v7LY/12TThQ5l/6AmjJVxQYS3hird0V2HExKn9abluGfi
 eZ6KEfk/L9ESqeiB5xwI+SPjwEnWBm/KKxJPK4Lc=
Date: Mon, 12 Jan 2026 16:31:48 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
Subject: Re: [PATCH] include/hw/hyperv: Remove unused 'struct
 mshv_vp_registers' definition
Message-ID: <aWUT5GVD97KXXwIj@example.com>
References: <20260108185012.2568277-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108185012.2568277-1-clg@redhat.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Thanks, looks good to me.

On Thu, Jan 08, 2026 at 07:50:12PM +0100, Cédric Le Goater wrote:
> The 'struct mshv_vp_registers' definition in hvgdk_mini.h is unused in
> QEMU and conflicts with the canonical definition in
> linux-headers/linux/mshv.h.
> 
> Remove the duplicate definition to avoid build conflicts when the Linux
> headers are updated.
> 
> Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  include/hw/hyperv/hvgdk_mini.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
> index d89315f5452fd565469bbfc98cacb226b71da13f..cb52cc9de283bbe4201357127c2eb1b0b37e4cab 100644
> --- a/include/hw/hyperv/hvgdk_mini.h
> +++ b/include/hw/hyperv/hvgdk_mini.h
> @@ -450,13 +450,6 @@ typedef struct hv_input_set_vp_registers {
>      struct hv_register_assoc elements[];
>  } hv_input_set_vp_registers;
>  
> -#define MSHV_VP_MAX_REGISTERS   128
> -
> -struct mshv_vp_registers {
> -    int count; /* at most MSHV_VP_MAX_REGISTERS */
> -    struct hv_register_assoc *regs;
> -};
> -
>  union hv_interrupt_control {
>      uint64_t as_uint64;
>      struct {
> -- 
> 2.52.0

