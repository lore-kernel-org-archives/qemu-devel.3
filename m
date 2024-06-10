Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AADFC27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 13:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGevz-0003qx-GJ; Mon, 10 Jun 2024 09:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sGevx-0003qS-IS; Mon, 10 Jun 2024 09:19:37 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sGevu-0008Fd-UW; Mon, 10 Jun 2024 09:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=jCRBsW8ZUV7JwQ+XKRjuYwB4Qd/WP5ltErF5V8WW9R0=; b=RDNlVBknMaznwdwf
 fy9cCgGLN8C3l0XolnsKS6YXs5i0GiuBcgI1zhs6gEurzyfMkZGQ7/sKEbWufAv8AdVQ/8WMcIv7Q
 3bvzSVFPSk5VFtYpwLcrbTt80oB3W3npU2Wd55J+YYoE0wahK/3YNr50GS8NXsw2QuorHzqvr1KTK
 uNWozRDrTYt621kaBGgyTbQxXF1DNyCF5ll503NXYkMOifJMy1FwdTPcca3Wx+fmSI58ARrd4lqbQ
 U9M67YYHq3Rz8uV2rYIPF6BYzftaH2gSrp+Chs9lKJwmMqJUVFj07Lq2mc7FyEnzyvd7XoX4ttX0Y
 kKWPjA/SPhfBmKpZ/w==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1sGevo-005KAT-2j;
 Mon, 10 Jun 2024 13:19:28 +0000
Date: Mon, 10 Jun 2024 13:19:28 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] monitor: Remove obsolete stubs
Message-ID: <Zmb9YNgnV7R4_4iB@gallifrey>
References: <20240610063924.51154-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610063924.51154-1-philmd@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:18:46 up 33 days, 32 min,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

* Philippe Mathieu-Daudé (philmd@linaro.org) wrote:
> hmp_info_roms() was removed in commit dd98234c05 ("qapi:
> introduce x-query-roms QMP command"),
> 
> hmp_info_numa() in commit 1b8ae799d8 ("qapi: introduce
> x-query-numa QMP command"),
> 
> hmp_info_ramblock() in commit ca411b7c8a ("qapi: introduce
> x-query-ramblock QMP command")
> 
> and hmp_info_irq() in commit 91f2fa7045 ("qapi: introduce
> x-query-irq QMP command").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
> Note x-query-roms is used as example in
> docs/devel/writing-monitor-commands.rst
> but was removed in commit dd98234c05
> ("qapi: introduce x-query-roms QMP command").
> ---
>  include/hw/loader.h   | 1 -
>  include/monitor/hmp.h | 3 ---
>  2 files changed, 4 deletions(-)
> 
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index 8685e27334..9844c5e3cf 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -338,7 +338,6 @@ void *rom_ptr(hwaddr addr, size_t size);
>   * rom_ptr().
>   */
>  void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
> -void hmp_info_roms(Monitor *mon, const QDict *qdict);
>  
>  #define rom_add_file_fixed(_f, _a, _i)          \
>      rom_add_file(_f, NULL, _a, _i, false, NULL, NULL)
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 954f3c83ad..ae116d9804 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -35,7 +35,6 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict);
>  void hmp_info_vnc(Monitor *mon, const QDict *qdict);
>  void hmp_info_spice(Monitor *mon, const QDict *qdict);
>  void hmp_info_balloon(Monitor *mon, const QDict *qdict);
> -void hmp_info_irq(Monitor *mon, const QDict *qdict);
>  void hmp_info_pic(Monitor *mon, const QDict *qdict);
>  void hmp_info_pci(Monitor *mon, const QDict *qdict);
>  void hmp_info_tpm(Monitor *mon, const QDict *qdict);
> @@ -102,7 +101,6 @@ void hmp_chardev_send_break(Monitor *mon, const QDict *qdict);
>  void hmp_object_add(Monitor *mon, const QDict *qdict);
>  void hmp_object_del(Monitor *mon, const QDict *qdict);
>  void hmp_info_memdev(Monitor *mon, const QDict *qdict);
> -void hmp_info_numa(Monitor *mon, const QDict *qdict);
>  void hmp_info_memory_devices(Monitor *mon, const QDict *qdict);
>  void hmp_qom_list(Monitor *mon, const QDict *qdict);
>  void hmp_qom_get(Monitor *mon, const QDict *qdict);
> @@ -141,7 +139,6 @@ void hmp_rocker_ports(Monitor *mon, const QDict *qdict);
>  void hmp_rocker_of_dpa_flows(Monitor *mon, const QDict *qdict);
>  void hmp_rocker_of_dpa_groups(Monitor *mon, const QDict *qdict);
>  void hmp_info_dump(Monitor *mon, const QDict *qdict);
> -void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
>  void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
>  void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
>  void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
> -- 
> 2.41.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

