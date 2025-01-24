Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E925C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNCd-00056M-Si; Fri, 24 Jan 2025 12:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tbNCU-0004oq-5j
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:10:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tbNCQ-0005uM-8S
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737738627;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bXgsYg9WUAufTZvCWSM3+Rce5P2yUI3NDiSYwkQVMF8=;
 b=HaZ5Aa33WW5lSaLMx195MpuqO0MhazM6+c3lQIbP/cCOUiMkqbC/2zO5ByDivxzvWg5ZC2
 LPSNbDAthnhvOZlHkLj8FmO5zIkLZahboSk/FFZF4yfRC64Awm9wmyvkLJtKBDPKxXPHTG
 Y1g1+D+eYyYlR8Q15jOrSdmU9inGIOw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-6Aj9TfTIOV6GbUZVOFVv5Q-1; Fri,
 24 Jan 2025 12:10:23 -0500
X-MC-Unique: 6Aj9TfTIOV6GbUZVOFVv5Q-1
X-Mimecast-MFC-AGG-ID: 6Aj9TfTIOV6GbUZVOFVv5Q
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 796891B0B4C2; Fri, 24 Jan 2025 15:36:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 423DB1800348; Fri, 24 Jan 2025 15:36:10 +0000 (UTC)
Date: Fri, 24 Jan 2025 15:36:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 3/5] tests/functional/test_mipsel_malta: Convert the
 mipsel replay tests
Message-ID: <Z5OzZrq7CRBICDyG@redhat.com>
References: <20250124141529.1626877-1-thuth@redhat.com>
 <20250124141529.1626877-4-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250124141529.1626877-4-thuth@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jan 24, 2025 at 03:15:27PM +0100, Thomas Huth wrote:
> Move the mipsel replay tests from tests/avocado/replay_kernel.py to
> the functional framework. Since the functional tests should be run per
> target, we cannot stick all replay tests in one file. Thus let's add
> these tests to the file where we already use the same asset already.

Are the replay tests liable to impact running time much ?

The test timeouts are per-file, which could motivate
a separate test_mipsel_malta_replay.py file ?

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/avocado/replay_kernel.py        | 54 ---------------------------
>  tests/functional/meson.build          |  1 +
>  tests/functional/test_mipsel_malta.py | 30 +++++++++++++--
>  3 files changed, 28 insertions(+), 57 deletions(-)

> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index b7719ab85f..7d233213c1 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -35,6 +35,7 @@ test_timeouts = {
>    'arm_sx1' : 360,
>    'intel_iommu': 300,
>    'mips_malta' : 120,
> +  'mipsel_malta' : 500,

snip

> +
> +    @skipLongRuntime()
> +    def test_replay_mips_malta32el_nanomips_4k(self):
> +        self.do_test_replay_mips_malta32el_nanomips(self.ASSET_KERNEL_4K)
> +
> +    @skipLongRuntime()
> +    def test_replay_mips_malta32el_nanomips_16k_up(self):
> +        self.do_test_replay_mips_malta32el_nanomips(self.ASSET_KERNEL_16K)
> +
> +    @skipLongRuntime()
> +    def test_replay_mips_malta32el_nanomips_64k_dbg(self):
> +        self.do_test_replay_mips_malta32el_nanomips(self.ASSET_KERNEL_64K)

Guess that answers my own question. I'd think a separate
file for replay tests per target is nicer, so we leave the
default executed malta tests with short timeout in meson.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


