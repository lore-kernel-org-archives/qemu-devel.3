Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8821CD3436
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 10:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKZaL-0000EC-Es; Wed, 06 May 2026 06:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wKZaJ-0000DM-Jg
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:34:31 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wKZaI-000255-2d
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:34:31 -0400
Received: from example.com (unknown [167.220.208.68])
 by linux.microsoft.com (Postfix) with ESMTPSA id 56AA520B7168;
 Wed,  6 May 2026 03:34:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 56AA520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1778063664;
 bh=ac9PLJVs1L9e7wKi2saZETCjTCdTQF2XJcJ33IO86ow=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BdaTzEkBrIwphe5lYj0ManoarCY7xAArLH5b352q3w7jwCYvUauZWILi/X72SX9/F
 OgZVl9ks+2zt2m72uzn5ODLwlSRTTcRghw49SO+UoGNnVKGH83eeRp8+bYTQo6IZXL
 hqnS0k1S8xrcEglNPdwMWpy8eXrqCtZ3vKjS++9c=
Date: Wed, 6 May 2026 12:34:22 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/7] target/i386/mshv: remove duplicate function for
 reading vcpu registers
Message-ID: <afsZLjWgkr6v2vF9@example.com>
References: <20260505185028.237207-1-dblanzeanu@linux.microsoft.com>
 <20260505185028.237207-2-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505185028.237207-2-dblanzeanu@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 05, 2026 at 09:50:22PM +0300, Doru Blânzeanu wrote:
> Remove function `fetch_guest_state` because it is a duplicate function
> of `mshv_load_regs` function.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  target/i386/mshv/mshv-cpu.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 4ed6e7548f..9defd05db6 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -1291,25 +1291,6 @@ static int handle_pio_non_str(const CPUState *cpu,
>      return 0;
>  }
>  
> -static int fetch_guest_state(CPUState *cpu)
> -{
> -    int ret;
> -
> -    ret = mshv_get_standard_regs(cpu);
> -    if (ret < 0) {
> -        error_report("Failed to get standard registers");
> -        return -1;
> -    }
> -
> -    ret = mshv_get_special_regs(cpu);
> -    if (ret < 0) {
> -        error_report("Failed to get special registers");
> -        return -1;
> -    }
> -
> -    return 0;
> -}
> -
>  static int read_memory(const CPUState *cpu, uint64_t initial_gva,
>                         uint64_t initial_gpa, uint64_t gva, uint8_t *data,
>                         size_t len)
> @@ -1429,7 +1410,7 @@ static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
>      X86CPU *x86_cpu = X86_CPU(cpu);
>      CPUX86State *env = &x86_cpu->env;
>  
> -    ret = fetch_guest_state(cpu);
> +    ret = mshv_load_regs(cpu);
>      if (ret < 0) {
>          error_report("Failed to fetch guest state");
>          return -1;
> -- 
> 2.53.0

Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

