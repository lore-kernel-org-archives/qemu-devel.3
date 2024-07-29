Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E37C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 10:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYNec-00059i-2a; Mon, 29 Jul 2024 06:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYNeX-00058F-8G
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 06:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYNeV-0003Zv-48
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 06:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722249049;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=E/v307qrJPqbG9EmIQvCRmaOD0J7mX5czZH3z26/3Oo=;
 b=V2N0tunD/yqHH7mECyjxG/TcIiukxptlI4brkPCKH0L1Uvt2Q8///6IMbKAvv7tsp0A5h9
 NTLpi4j9nwPSB1/Dk0TQOiKnkD2qaWILiHaMA6jrac5FCEnofBV5BaghcP4EdPnfgOUD81
 uudiZpNOaW7KP8gx9EJP3aIHq2cVRak=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-g733LZZ5PF-0JSc1Znuxmw-1; Mon,
 29 Jul 2024 06:30:45 -0400
X-MC-Unique: g733LZZ5PF-0JSc1Znuxmw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C2951955D4E; Mon, 29 Jul 2024 10:30:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.58])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04B55195605F; Mon, 29 Jul 2024 10:30:34 +0000 (UTC)
Date: Mon, 29 Jul 2024 11:30:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH 03/13] tests/avocado/intel_iommu.py: increase timeout
Message-ID: <ZqdvR3UFBCAu8wiI@redhat.com>
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-4-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240726134438.14720-4-crosa@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 26, 2024 at 09:44:28AM -0400, Cleber Rosa wrote:
> Based on many runs, the average run time for these 4 tests is around
> 250 seconds, with 320 seconds being the ceiling.  In any way, the
> default 120 seconds timeout is inappropriate in my experience.
> Let's increase the timeout so these tests get a chance to completion.

A high watermark of over 5 minutes is pretty long for a test.

Looking at the test I see it runs

   self.ssh_command('dnf -y install numactl-devel')

but then never actually uses the installed package.

I expect that most of the wallclock time here is coming from having
dnf download all the repodata, 4 times over.

If the intention was to test networking, then replace this with
something that doesn't have to download 100's of MB of data, then
see what kind of running time we get before increasing any timeout. 


> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/avocado/intel_iommu.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/avocado/intel_iommu.py b/tests/avocado/intel_iommu.py
> index 008f214397..9e7965c5df 100644
> --- a/tests/avocado/intel_iommu.py
> +++ b/tests/avocado/intel_iommu.py
> @@ -25,6 +25,8 @@ class IntelIOMMU(LinuxTest):
>      :avocado: tags=flaky
>      """
>  
> +    timeout = 360
> +
>      IOMMU_ADDON = ',iommu_platform=on,disable-modern=off,disable-legacy=on'
>      kernel_path = None
>      initrd_path = None
> -- 
> 2.45.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


