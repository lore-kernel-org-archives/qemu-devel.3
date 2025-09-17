Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E32CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 18:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uywTH-0007t1-UJ; Wed, 17 Sep 2025 14:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uywTF-0007sX-Dg
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 14:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uywTA-0001D0-2B
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 14:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758132083;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Y7b+9rZN2Ihdft/r1GTe1V7xdsjUwXySBVnRBKZYsNA=;
 b=f6Do7Wi5eM9Semx/QMYLuKCaIY9oDqNLMPYFZW5JWrB+kbGvDx19s+GXQuAcDKZ1LTOR47
 QV3oiy1g5DaORI3oLuxt3HyddE4ovGL+nzxJ6abmCZ7kWDhcRupzr9miSF61OUedct7bFo
 tRIhzzESg3CNXD/WNHr6m5Y2j6X8ONQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-k7LXAldEPYOOsIP7eivjTg-1; Wed,
 17 Sep 2025 14:01:17 -0400
X-MC-Unique: k7LXAldEPYOOsIP7eivjTg-1
X-Mimecast-MFC-AGG-ID: k7LXAldEPYOOsIP7eivjTg_1758132077
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEB461800350; Wed, 17 Sep 2025 18:01:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BA10300018D; Wed, 17 Sep 2025 18:01:15 +0000 (UTC)
Date: Wed, 17 Sep 2025 19:01:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: More check-functional asset download issues
Message-ID: <aMr3aNpHz1ySnBEg@redhat.com>
References: <d6b2f2c8-809d-4a94-a18b-2accf10fc5f9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d6b2f2c8-809d-4a94-a18b-2accf10fc5f9@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Sep 17, 2025 at 10:49:56AM -0700, Richard Henderson wrote:
> Hi,
> 
> We have
> 
>   https://patchew.org/QEMU/20250829142616.2633254-1-berrange@redhat.com/
> 
> in master already, but are still seeing up front failures:
> 
>   https://gitlab.com/qemu-project/qemu/-/jobs/11391070330
>   https://gitlab.com/qemu-project/qemu/-/jobs/11391070366
> 
> 2025-09-17 17:26:56,222 - qemu-test - INFO - Downloading https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/buildroot/qemu_ppc64_e5500-2023.11-8-gdcd9f0f6eb-20240104/uImage
> to /builds/qemu-project/qemu/functional-cache/download/2478187c455d6cca3984e9dfde9c635d824ea16236b85fd6b4809f744706deda...
> Traceback (most recent call last):
>   File "/builds/qemu-project/qemu/tests/functional/qemu_test/asset.py", line 135, in fetch
>     with urllib.request.urlopen(self.url) as resp:
>   File "/usr/lib64/python3.9/urllib/request.py", line 214, in urlopen
>     return opener.open(url, data, timeout)
>   File "/usr/lib64/python3.9/urllib/request.py", line 517, in open
>     response = self._open(req, data)
>   File "/usr/lib64/python3.9/urllib/request.py", line 534, in _open
>     result = self._call_chain(self.handle_open, protocol, protocol +
>   File "/usr/lib64/python3.9/urllib/request.py", line 494, in _call_chain
>     result = func(*args)
>   File "/usr/lib64/python3.9/urllib/request.py", line 1389, in https_open
>     return self.do_open(http.client.HTTPSConnection, req,
>   File "/usr/lib64/python3.9/urllib/request.py", line 1350, in do_open
>     r = h.getresponse()
>   File "/usr/lib64/python3.9/http/client.py", line 1377, in getresponse
>     response.begin()
>   File "/usr/lib64/python3.9/http/client.py", line 320, in begin
>     version, status, reason = self._read_status()
>   File "/usr/lib64/python3.9/http/client.py", line 289, in _read_status
>     raise RemoteDisconnected("Remote end closed connection without"

Sigh, yet another type of exception that urlopen may raise.... this is
why apps end up wanting to catch Exception rather than try to match
all possible specialized subclasses.

We already catch Exception but treat it as a fatal error. I'm inclined
to switch it to be a transient error, so that we don't abort the CI
jobs, just skip tests with msising assets, as we do for HTTP error
codes and for DNS resolution errors.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


