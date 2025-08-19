Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46341CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 15:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoNtV-0002le-MU; Tue, 19 Aug 2025 11:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoNtP-0002cD-O7
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:04:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoNtM-0003NT-IR
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755615891;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lJVaPLaMgBW+iLFaW02IKkVA5Wl2P39O12xOf81eP1k=;
 b=Nxi0yHvWn9KZstM0/e/a7+mbG55PlAWrRcXGGpBAtjqljuFeXzcCXDnm63E4+pZgtnx8i9
 O0qGWVswLYHpUvqan+DbAbFUi1+FGK2cXL5GEsUvPCqlKMYYvBbh3LFlD/Hi3PdkcqHJDh
 wYrkgswV86yXSA/9Lt88eJTKrYBvJ8U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-qY9wa5LiMQepK5lCbjWXuA-1; Tue,
 19 Aug 2025 11:04:49 -0400
X-MC-Unique: qY9wa5LiMQepK5lCbjWXuA-1
X-Mimecast-MFC-AGG-ID: qY9wa5LiMQepK5lCbjWXuA_1755615888
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AEAB1800293; Tue, 19 Aug 2025 15:04:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CC9B19A4CA1; Tue, 19 Aug 2025 15:04:45 +0000 (UTC)
Date: Tue, 19 Aug 2025 16:04:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 "Christian A. Ehrhardt" <christian.ehrhardt@canonical.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH 10.1?] Revert "i386/cpu: Warn about why CPUID_EXT_PDCM is
 not available"
Message-ID: <aKSSitJ-jeV8K7Ux@redhat.com>
References: <20250819150235.785559-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819150235.785559-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 19, 2025 at 05:02:35PM +0200, Paolo Bonzini wrote:
> This reverts commit 00268e00027459abede448662f8794d78eb4b0a4.
> (The only conflict is in the !is_tdx_vm() part of the condition,
> which is safe to keep).
> 
> mark_unavailable_features() actively blocks usage of the feature,
> so it is a functional change, not merely a emitting warning.
> The commit was intended to merely warn if PDCM was enabled when
> the performance counters are not, so revert it.
> 
> Reported-by: Christian A. Ehrhardt <christian.ehrhardt@canonical.com>
> Analyzed-by: Daniel P. Berrangé <berrange@redhat.com>
> Analyzed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/i386/cpu.c | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 673f8583c80..6d85149e6e1 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -8946,9 +8946,6 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>  
>      /* PDCM is fixed1 bit for TDX */
>      if (!cpu->enable_pmu && !is_tdx_vm()) {
> -        mark_unavailable_features(cpu, FEAT_1_ECX,
> -                                  env->user_features[FEAT_1_ECX] & CPUID_EXT_PDCM,
> -                                  "This feature is not available due to PMU being disabled");
>          env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
>      }
>  
> -- 
> 2.50.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


