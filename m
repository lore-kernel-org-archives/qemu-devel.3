Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA404C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 16:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww0de-0006Xm-N1; Mon, 17 Aug 2026 12:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ww0da-0006WI-S6
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ww0dZ-0003EY-F8
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 12:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786985796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oLyHa7or1IT5WIFamHpBt8mPu02hqKYlWoeuTiO2Avg=;
 b=fg3E0k9Uymjx24HcW9rZpsbd43TQRgYMnfaoK3A9sz0X3crrzsMbkmK2F9izwnXKva6DRW
 X+yBo/G2xfNq5JtFkp35c8gQEFrVVhANhUQpH2cwREglrHn/rChEJgdSEfxxIhzJeqdc0B
 JN0+TQFq4ZAkrROQ+m6FxW+bnPiUP0g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-_b9AAhwRPcCYp3RH11RmZg-1; Mon,
 17 Aug 2026 12:56:30 -0400
X-MC-Unique: _b9AAhwRPcCYp3RH11RmZg-1
X-Mimecast-MFC-AGG-ID: _b9AAhwRPcCYp3RH11RmZg_1786985789
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68F5B18001E2; Mon, 17 Aug 2026 16:56:29 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D2191956042; Mon, 17 Aug 2026 16:56:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 3/3] dockerfiles: update CentOS Stream 9 to Python
 3.11, Meson to 1.12
From: marcandre.lureau@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru, alex.bennee@linaro.org
In-Reply-To: <20260817134313.922754-4-pbonzini@redhat.com>
References: <20260817134313.922754-1-pbonzini@redhat.com>
 <20260817134313.922754-4-pbonzini@redhat.com>
Date: Mon, 17 Aug 2026 20:56:16 +0400
Message-Id: <178698577647.3397024.10486003602144138621.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1749;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Ef1SklGXVttAM02pvNVD93F4ISxdqAL0xB0lia1OnRc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgz0yzf6rdhZZ13S4UbEX9YyQAJIGm9vUjioC6
 foqfGBiRxiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoM9MgAKCRDa6OEJdZac
 5d6gD/955ZYJssJH8jywarvV5KrSn8i0fWkIK3mMIDe0ZbXrXrDNmQ/AbayzIbh0Q2gd7U0SYwX
 YTj71ZA08O4ZlBjtlLo6Y620ukw1B05A8I80j5KlOU77QOnc4ISOosBpalt/IjOboTUDZJ34uUV
 7rVAy4BoUsk8LjZ8/xgsGFWUKogoWxqTe1AqqUA7rR1d7Hyis1rVMXddG46FqEfNM1aioGonfbd
 LZ8JytNDVr7oSiZgveAttcA25nxjspqRhcqT/sOYMHRSWTqJS+HWI1S6zIffgNheaYtLsF1CTSV
 cvdQtrPUH1CRK5TQEMqgzla2i/iR76mRZSpEnKlje9tFY1CcUrjljVWZMFtMVNLNmzLh9oTamF7
 O9VnK15BnSTtF3FpTt6GKBojY74SS75pXta1W9Spzu9tbz2y41aUo0EnmYckUIxLagrL7o30ORZ
 NHydZlrs+7yD7juN3zFWL+4+4o84EEFVa2vSwtFJ1L39vKYPxIH+qyTR+lH25U//w6z6myn6me8
 ikioFtDMGjwgYLpuZnuvxzH0jTGOqVBdVFXoNneNYGiRjrnqUpVD+0aXhTJIUVV70lIpOMH48Vj
 EGkQNbcyUJtRgPRMJ06LD6IOkfeW2Khkbcd2bP7Ke6iaVLrJf7zd/Y6mYPwPtQfLI0pcHJOBTbs
 hk1IYAFcWXm06mg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Python 3.10, which is a requirement for Meson 1.12.0, was never
> packages for CentOS Stream 9 so update directly to 3.11.

packaged

> 
> The opensuse-leap-15.yml file was not in use anymore, so delete it
> while touching tests/lcitool/targets/.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-ID: <20260817134313.922754-4-pbonzini@redhat.com>
>
> diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
> index e38cd692db93..8101370a2dbe 100644
> --- a/tests/docker/dockerfiles/centos9.docker
> +++ b/tests/docker/dockerfiles/centos9.docker
> @@ -95,13 +95,11 @@ RUN dnf --quiet distro-sync -y && \
>                  pixman-devel \
>                  pkgconfig \
>                  pulseaudio-libs-devel \
> -                python3 \
> -                python3-pip \
> -                python3-setuptools \
> -                python3-sphinx \
> -                python3-sphinx_rtd_theme \
>                  python3-tomli \
> -                python3-wheel \
> +                python3.11 \
> +                python3.11-pip \
> +                python3.11-setuptools \
> +                python3.11-wheel \
>                  rdma-core-devel \
>                  rust \
>                  rust-std-static \
> @@ -131,11 +129,15 @@ RUN dnf --quiet distro-sync -y && \
>      ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
>      ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
>  
> +RUN /usr/bin/pip3.11 install \
> +                     sphinx \
> +                     sphinx-rtd-theme

Since it's a rust-enabled container, why not pip install meson 1.12 here?

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


