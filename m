Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE4CC47DDF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 10:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV7q6-000398-QN; Wed, 31 Jan 2024 05:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rV7pv-000385-PY
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:29:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rV7pt-00058Z-Lo
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706696932;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7QFSz4iLpWcX1LVK89RhT/r6+WUAlS1/Pj27Dogjyms=;
 b=NBdJIzfJlP6KX/rzU1J3ZVV+4XxVG42VRpTFl5SBbRqq9njNdYlTqiNmLJFk+df3IqMifr
 5Q/na0iDVfAOGT5CWiHLo53r1Nhjk18wt+iMnMnYMj/7XzyaWEHZIB/D4oMKrFM2Gf7waC
 cYx65CeCeLmXRmQacDqdauQXuyPA0Xs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-ncC9b_gUPgOcqtOek-qlUw-1; Wed, 31 Jan 2024 05:28:48 -0500
X-MC-Unique: ncC9b_gUPgOcqtOek-qlUw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73D3C8B3963;
 Wed, 31 Jan 2024 10:28:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7551492BC6;
 Wed, 31 Jan 2024 10:28:44 +0000 (UTC)
Date: Wed, 31 Jan 2024 10:28:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Babu Moger <babu.moger@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v8 00/21] Introduce smp.modules for x86 in QEMU
Message-ID: <Zbog2vDrrWFbujrs@redhat.com>
References: <20240131101350.109512-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240131101350.109512-1-zhao1.liu@linux.intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jan 31, 2024 at 06:13:29PM +0800, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Hi list,
> 
> This is the our v8 patch series, rebased on the master branch at the
> commit 11be70677c70 ("Merge tag 'pull-vfio-20240129' of
> https://github.com/legoater/qemu into staging").
> 
> Compared with v7 [1], v8 mainly has the following changes:
>   * Introduced smp.modules for x86 instead of reusing current
>     smp.clusters.
>   * Reworte the CPUID[0x1F] encoding.
> 
> Given the code change, I dropped the most previously gotten tags
> (Acked-by/Reviewed-by/Tested-by from Michael & Babu, thanks for your
> previous reviews and tests!) in v8.
> 
> With the description of the new modules added to x86 arch code in v7 [1]
> cover letter, the following sections are mainly the description of
> the newly added smp.modules (since v8) as supplement.
> 
> Welcome your comments!
> 
> 
> Why We Need a New CPU Topology Level
> ====================================
> 
> For the discussion in v7 about whether we should reuse current
> smp.clusters for x86 module, the core point is what's the essential
> differences between x86 module and general cluster.
> 
> Since, cluster (for ARM/riscv) lacks a comprehensive and rigorous
> hardware definition, and judging from the description of smp.clusters
> [2] when it was introduced by QEMU, x86 module is very similar to
> general smp.clusters: they are all a layer above existing core level
> to organize the physical cores and share L2 cache.
> 
> However, after digging deeper into the description and use cases of
> cluster in the device tree [3], I realized that the essential
> difference between clusters and modules is that cluster is an extremely
> abstract concept:
>   * Cluster supports nesting though currently QEMU doesn't support
>     nested cluster topology. However, modules will not support nesting.
>   * Also due to nesting, there is great flexibility in sharing resources
>     on clusters, rather than narrowing cluster down to sharing L2 (and
>     L3 tags) as the lowest topology level that contains cores.
>   * Flexible nesting of cluster allows it to correspond to any level
>     between the x86 package and core.
> 
> Based on the above considerations, and in order to eliminate the naming
> confusion caused by the mapping between general cluster and x86 module
> in v7, we now formally introduce smp.modules as the new topology level.

What is the Linux kernel calling this topology level on x86 ?
It will be pretty unfortunate if Linux and QEMU end up with
different names for the same topology level.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


