Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D55D606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=icu9LXd3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJGEV-00044l-UO; Tue, 20 Oct 2026 16:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xJGEL-00044D-Os
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 16:14:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xJGEK-0003bz-7U
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 16:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792527279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1xngvI0ltnnkZ/TUzrD/Kmq2prihBGvxz8+6IZ42KU=;
 b=icu9LXd3Dd52wSuNG+Pjv65rsI7USyh+D5hbBpLfxOn/xgVmnZxRj3xOnU/Te3eMDxwGN3
 DrOj/xIy4H2/5WDPlG30wm3U/peHUpwNj5CxaNZSyDIz+PFddj2mRNbMf+b37rWrLgzwa5
 rqkLzRw9jeXliGLxVvxvuqfma6+JBxU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-mp5-va54Pi6b5z4mTu7Kgg-1; Tue,
 20 Oct 2026 20:14:34 +0000
X-MC-Unique: mp5-va54Pi6b5z4mTu7Kgg-1
X-Mimecast-MFC-AGG-ID: mp5-va54Pi6b5z4mTu7Kgg_1792527273
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20DA4195419E; Tue, 20 Oct 2026 20:14:33 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 524B5195608B; Tue, 20 Oct 2026 20:14:32 +0000 (UTC)
Date: Tue, 20 Oct 2026 16:14:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v3 21/24] trace: remove "disable" property from trace files
Message-ID: <20261020201431.GC20810@shajnocz.csb>
References: <20261005120855.421973-1-berrange@redhat.com>
 <20261005120855.421973-22-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005120855.421973-22-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 05, 2026 at 01:08:52PM +0100, Daniel P. Berrangé wrote:
> diff --git a/target/hppa/trace-events b/target/hppa/trace-events
> index 01761a4559b..7c897610a9e 100644
> --- a/target/hppa/trace-events
> +++ b/target/hppa/trace-events
> @@ -1,19 +1,19 @@
>  # See docs/devel/tracing.rst for syntax documentation.
>  
>  # mem_helper.c
> -disable hppa_tlb_flush_ent(void *env, void *ent, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p va_b=0x%lx va_e=0x%lx pa=0x%" PRIx64
> -disable hppa_tlb_find_entry(void *env, void *ent, int valid, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p valid=%d va_b=0x%lx va_e=0x%lx pa=0x%" PRIx64
> -disable hppa_tlb_find_entry_not_found(void *env, uint64_t addr) "env=%p addr=%08lx"
> -disable hppa_tlb_get_physical_address(void *env, int ret, int prot, uint64_t addr, uint64_t phys) "env=%p ret=%d prot=%d addr=0x%lx phys=0x%lx"
> -disable hppa_tlb_fill_excp(void *env, uint64_t addr, int size, int type, int mmu_idx) "env=%p addr=0x%lx size=%d type=%d mmu_idx=%d"
> -disable hppa_tlb_fill_success(void *env, uint64_t addr, uint64_t phys, int size, int type, int mmu_idx) "env=%p addr=0x%lx phys=0x%lx size=%d type=%d mmu_idx=%d"
> -disable hppa_tlb_itlba(void *env, void *ent, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p va_b=0x%lx va_e=0x%lx pa=0x%" PRIx64
> -disable hppa_tlb_itlbp(void *env, void *ent, int access_id, int u, int pl2, int pl1, int type, int b, int d, int t) "env=%p ent=%p access_id=%x u=%d pl2=%d pl1=%d type=%d b=%d d=%d t=%d"
> -disable hppa_tlb_ptlb(void *env) "env=%p"
> -disable hppa_tlb_ptlb_local(void *env) "env=%p"
> -disable hppa_tlb_ptlbe(void *env) "env=%p"
> -disable hppa_tlb_lpa_success(void *env, uint64_t addr, uint64_t phys) "env=%p addr=0x%lx phys=0x%lx"
> -disable hppa_tlb_lpa_failed(void *env, uint64_t addr) "env=%p addr=0x%lx"
> +hppa_tlb_flush_ent(void *env, void *ent, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p va_b=0x%lx va_e=0x%lx pa=0x%" PRIx64
> +hppa_tlb_find_entry(void *env, void *ent, int valid, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p valid=%d va_b=0x%lx va_e=0x%lx pa=0x%" PRIx64
> +hppa_tlb_find_entry_not_found(void *env, uint64_t addr) "env=%p addr=%08lx"
> +hppa_tlb_get_physical_address(void *env, int ret, int prot, uint64_t addr, uint64_t phys) "env=%p ret=%d prot=%d addr=0x%lx phys=0x%lx"
> +hppa_tlb_fill_excp(void *env, uint64_t addr, int size, int type, int mmu_idx) "env=%p addr=0x%lx size=%d type=%d mmu_idx=%d"
> +hppa_tlb_fill_success(void *env, uint64_t addr, uint64_t phys, int size, int type, int mmu_idx) "env=%p addr=0x%lx phys=0x%lx size=%d type=%d mmu_idx=%d"
> +hppa_tlb_itlba(void *env, void *ent, uint64_t va_b, uint64_t va_e, uint64_t pa) "env=%p ent=%p va_b=0x%lx va_e=0x%lx pa=0x%" PRIx64
> +hppa_tlb_itlbp(void *env, void *ent, int access_id, int u, int pl2, int pl1, int type, int b, int d, int t) "env=%p ent=%p access_id=%x u=%d pl2=%d pl1=%d type=%d b=%d d=%d t=%d"
> +hppa_tlb_ptlb(void *env) "env=%p"
> +hppa_tlb_ptlb_local(void *env) "env=%p"
> +hppa_tlb_ptlbe(void *env) "env=%p"
> +hppa_tlb_lpa_success(void *env, uint64_t addr, uint64_t phys) "env=%p addr=0x%lx phys=0x%lx"
> +hppa_tlb_lpa_failed(void *env, uint64_t addr) "env=%p addr=0x%lx"
>  
>  # op_helper.c
> -disable hppa_tlb_probe(uint64_t addr, int level, int want) "addr=0x%lx level=%d want=%d"
> +hppa_tlb_probe(uint64_t addr, int level, int want) "addr=0x%lx level=%d want=%d"

From docs/devel/tracing.rst:

  Format strings should reflect the types defined in the trace event.  Take
  special care to use PRId64 and PRIu64 for int64_t and uint64_t types,
  respectively.  This ensures portability between 32- and 64-bit platforms.

These format strings apply %lx to uint64_t arguments. This won't work on
32-bit or the Windows LLP64 data model.

The format strings must use PRIx64 instead of "lx". We probably didn't
notice before because they were disabled :).

Stefan


