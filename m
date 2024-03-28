Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172A5C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpmfd-0004n6-CD; Thu, 28 Mar 2024 06:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpmfb-0004mj-KP
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:07:39 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpmfY-0004eq-WA
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711620457; x=1743156457;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=n17yKXZn4ypFFR//dbwLVZa7UTzzDZvkwHj1XDiz1yI=;
 b=buOKZcVAsS9dzHZ6ww7ibf3r4Z9iebHeBPsm7jK7/Q1IX8B+dhhjyeOO
 Le8xMry7va3Ko4Kh6hs7QH22autE1inMw/2n8rDcz4kvqv3dU88DrB0yY
 yASEp3UhxiajabLXqi/0KT32vNA7GMBXv6YKgSLE4xmC4w7SAxp8q7Uf/
 XpMSps6qlbO5y9nimKw/prD11J4bV3K98pRz7V8hgeT4xieOSu5pWkmof
 Pq0Qvc2ZlWlKOBjBbttUWZdl16l5GiStZq9yhAxg5uNGYe9P+vnfAmjm7
 VfPwMfKk9O7jTGFXMjYMEHWSzItDXoZdxkrm4MCIjC10q3ggrm9wtkgUx Q==;
X-CSE-ConnectionGUID: Xa2st5bxT6uaTn5eZsJ3uA==
X-CSE-MsgGUID: 96emXVjKTEOK7DqU78rUvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17394780"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; d="scan'208";a="17394780"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2024 03:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; d="scan'208";a="17049886"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 28 Mar 2024 03:07:30 -0700
Date: Thu, 28 Mar 2024 18:21:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH for-9.1 v5 1/3] hw: Add compat machines for 9.1
Message-ID: <ZgVEpt7pOzNK2wrM@intel.com>
References: <20240325141422.1380087-1-pbonzini@redhat.com>
 <20240325141422.1380087-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325141422.1380087-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Paolo,

Just meet typos when compiling ;-)

On Mon, Mar 25, 2024 at 03:14:20PM +0100, Paolo Bonzini wrote:
> Date: Mon, 25 Mar 2024 15:14:20 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH for-9.1 v5 1/3] hw: Add compat machines for 9.1
> X-Mailer: git-send-email 2.44.0

[snip]

> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index b1dcb3857f0..67e8b0b05e8 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -859,14 +859,26 @@ bool css_migration_enabled(void)
>      }                                                                         \
>      type_init(ccw_machine_register_##suffix)
>  
> +static void ccw_machine_9_1_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_9_1_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE(9_0, "9.1", true);

Should be:

DEFINE_CCW_MACHINE(9_1, "9.1", true);

> +
>  static void ccw_machine_9_0_instance_options(MachineState *machine)
>  {
> +    ccw_machine_9_1_instance_options(machine);
>  }
>  
>  static void ccw_machine_9_0_class_options(MachineClass *mc)
>  {
> +    ccw_machine_9_1_class_options(machine);

s/machine/mc/

Regards,
Zhao


