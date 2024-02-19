Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE3AC54764
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 10:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc0U2-0006cL-1S; Mon, 19 Feb 2024 05:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rc0Tz-0006br-Q8
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:02:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rc0Tx-0001fO-WD
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 05:02:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708336960;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MgIfNi1yukTizBF5iD8naV/Cp7XFzo46cyMnig9W5zI=;
 b=UjmCLiTMmVnstqxIO+DFAAy09HusNwIxBVwj/0NtnzM00O48+AJ931uh1aQr0C41u7TWgh
 ixPIUmqYh1nYMV3sxWB+98ExRSED84GLYECUJwhhX9loQuwAi8wxZfTvtT02MHJuN4zchQ
 5EQasnONdtEvbPEGsAuePXXkv8TKS0w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-PEsoT89DOhiDPzvrOniCFQ-1; Mon,
 19 Feb 2024 05:02:36 -0500
X-MC-Unique: PEsoT89DOhiDPzvrOniCFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4BB63C0F188;
 Mon, 19 Feb 2024 10:02:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A2781C060AF;
 Mon, 19 Feb 2024 10:02:34 +0000 (UTC)
Date: Mon, 19 Feb 2024 10:02:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Alexander Monakov <amonakov@ispras.ru>, qemu-devel@nongnu.org,
 mmromanov@ispras.ru
Subject: Re: [PATCH v5 10/10] tests/bench: Add bufferiszero-bench
Message-ID: <ZdMnONFiJDtP-X42@redhat.com>
References: <20240217003918.52229-1-richard.henderson@linaro.org>
 <20240217003918.52229-11-richard.henderson@linaro.org>
 <2abd887c-c99c-437c-f0bc-e06f3a13fd33@ispras.ru>
 <ba0548c4-d47c-4bf0-8f27-1f753b41b603@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba0548c4-d47c-4bf0-8f27-1f753b41b603@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Feb 17, 2024 at 09:21:50AM -1000, Richard Henderson wrote:
> On 2/16/24 23:49, Alexander Monakov wrote:
> > 
> > On Fri, 16 Feb 2024, Richard Henderson wrote:
> > 
> > > Benchmark each acceleration function vs an aligned buffer of zeros.
> > > 
> > > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > > ---
> > > +
> > > +static void test(const void *opaque)
> > > +{
> > > +    size_t len = 64 * KiB;
> > 
> > This exceeds L1 cache capacity, so the performance ceiling of L2 cache
> > throughput is easier to hit with a suboptimal implementation. It also
> > seems to vastly exceed typical buffer sizes in Qemu.
> > 
> > When preparing the patch we mostly tested at 8 KiB. The size decides
> > whether the branch exiting the loop becomes perfectly predictable in
> > the microbenchmark, e.g. at 128 bytes per iteration it exits on the
> > 63'rd iteration, which Intel predictors cannot track, so we get
> > one mispredict per call.
> > 
> > (so perhaps smaller sizes like 2 or 4 KiB are better)
> 
> Fair.  I've adjusted to loop over 1, 4, 16, 64 KiB.
> 
> # Start of bufferiszero tests
> # buffer_is_zero #0: 1KB 49227.29 MB/sec
> # buffer_is_zero #0: 4KB 137461.28 MB/sec
> # buffer_is_zero #0: 16KB 224220.41 MB/sec
> # buffer_is_zero #0: 64KB 142461.00 MB/sec
> # buffer_is_zero #1: 1KB 45423.59 MB/sec
> # buffer_is_zero #1: 4KB 91409.69 MB/sec
> # buffer_is_zero #1: 16KB 123819.94 MB/sec
> # buffer_is_zero #1: 64KB 71173.75 MB/sec
> # buffer_is_zero #2: 1KB 35465.03 MB/sec
> # buffer_is_zero #2: 4KB 56110.46 MB/sec
> # buffer_is_zero #2: 16KB 68852.28 MB/sec
> # buffer_is_zero #2: 64KB 39043.80 MB/sec

Totally nit-picking, but it would be easier to read with a little
alignment and blanks lines:

 # buffer_is_zero #0:  1KB  49227.29 MB/sec
 # buffer_is_zero #0:  4KB 137461.28 MB/sec
 # buffer_is_zero #0: 16KB 224220.41 MB/sec
 # buffer_is_zero #0: 64KB 142461.00 MB/sec
 
 # buffer_is_zero #1:  1KB  45423.59 MB/sec
 # buffer_is_zero #1:  4KB  91409.69 MB/sec
 # buffer_is_zero #1: 16KB 123819.94 MB/sec
 # buffer_is_zero #1: 64KB  71173.75 MB/sec
 
 # buffer_is_zero #2:  1KB  35465.03 MB/sec
 # buffer_is_zero #2:  4KB  56110.46 MB/sec
 # buffer_is_zero #2: 16KB  68852.28 MB/sec
 # buffer_is_zero #2: 64KB  39043.80 MB/sec

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


