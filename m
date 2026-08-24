Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D072C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyPGt-0006Pv-25; Mon, 24 Aug 2026 03:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPGr-0006PT-S4
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyPGq-0006EF-Fd
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787557143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8C4RmEYjjArsm2e7BSisNF8rZ6uCAlsV/fCdaLKVOo=;
 b=YD1i2spZsLzzs/mFDuYYdH8ECnCNJunt1knHr0lEf5G9OKF437eOQD02Pr1U70/RgPtHOh
 7PIBzx+QfiyXtbZDBNFvnmKrHQH7KBg9cOh793hKR6cPRYh9+GCeG7LQAIrHSmJ+VvSbAX
 q1qgA+6+PkmHP1mvyfFDbCob/whsayg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-ZzHakEc7NJKcHfePID-39Q-1; Mon,
 24 Aug 2026 03:39:00 -0400
X-MC-Unique: ZzHakEc7NJKcHfePID-39Q-1
X-Mimecast-MFC-AGG-ID: ZzHakEc7NJKcHfePID-39Q_1787557139
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A87251955E74; Mon, 24 Aug 2026 07:38:58 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0CA53434; Mon, 24 Aug 2026 07:38:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 02/12] tests: add Python3.12 to centos9.docker
From: marcandre.lureau@redhat.com
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Cleber Rosa <crosa@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260824052859.880475-3-jsnow@redhat.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-3-jsnow@redhat.com>
Date: Mon, 24 Aug 2026 11:38:46 +0400
Message-Id: <178755712683.3526866.11521669620152567935.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2251;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bulDB9ZdE8LXLBzlGPMVpMc1IpbYRGTxiL9FMnHA7EA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqi/UJm7QLFp4YpRHjmVccJoa/WacpioMj8QOnz
 BCStxoU41yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaov1CQAKCRDa6OEJdZac
 5acoD/4nM8p1Tr5rj8Epzy4gR4UowG8QZNTAczZaFTnDDBEfYXoqN13R/BdW36Fx7zQZZsb88qt
 oHtQHD0oOwgCajUM4W6AoB0kWMwOb616AOZ7erPPUn3ii0T6sbwYzNvRL9767z8X3ErVUo6+ddr
 Paqn8SsjYZXm4yCIv63MIptggWrkhnsitvm/dxb+hA2GCWReX0MR5JpHekBJXX0eZRxXbTsobP6
 CCkG0lEe2bHK3GuN/aqg+7kOZByE4OuqMu7k0UyVNyVGrGdRHaBAeOPSTWDUcHkSTQ78iSIe+hd
 /LF3TlwT6Is2IH7RDonUD3ZOexdHx6ICFfvKOAUXhsg21GSmUwNBuHCk35wkNfFHybeUll9G+wb
 OwVGJEUeM4DMflCyohmqwej/Q0WO0GUqD9Krv55mmUAVhlnko3fuGilOVfTwiXdd1eMnnY8vans
 iOUQxz5cXD/C9/G9hLGaa0lUKOfOTF5koqdXr3NjfJ82F9fyR00DOBIl4k6cHnBDpRm0BhDkaRd
 Ai4+qJi2SZUUOaf+39cX6igZQ2g/ocUMeH/buTH4Y4sNz/ykVUEuMKCyJkPmKfjapLWoiACfOgh
 5Bo5RN1hogQmbeV6vvYG2o20dggaqIxdDtP1kN/lTSlIo5bGEEwmjEOwUURnDYZehFLJafKi04U
 Z17MEDizlS1nGuA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> While we recently upgraded to Python 3.11 for the CentOS 9 container,
> upgrade it even further to Python 3.12.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Message-ID: <20260824052859.880475-3-jsnow@redhat.com>
>
> diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
> index 6f5c400c2db1..8bfce395f9d7 100644
> --- a/tests/docker/dockerfiles/centos9.docker
> +++ b/tests/docker/dockerfiles/centos9.docker
> @@ -96,10 +96,10 @@ RUN dnf --quiet distro-sync -y && \
>                  pkgconfig \
>                  pulseaudio-libs-devel \
>                  python3-tomli \
> -                python3.11 \
> -                python3.11-pip \
> -                python3.11-setuptools \
> -                python3.11-wheel \
> +                python3.12 \
> +                python3.12-pip \
> +                python3.12-setuptools \
> +                python3.12-wheel \
>                  rdma-core-devel \
>                  rust \
>                  rust-std-static \
> @@ -129,7 +129,7 @@ RUN dnf --quiet distro-sync -y && \
>      ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
>      ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
>  
> -RUN /usr/bin/pip3.11 install \
> +RUN /usr/bin/pip3.12 install \
>                       numpy \
>                       opencv-python \
>                       sphinx \
> @@ -139,7 +139,7 @@ ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
>  ENV LANG="en_US.UTF-8"
>  ENV MAKE="/usr/bin/make"
>  ENV NINJA="/usr/bin/ninja"
> -ENV PYTHON="/usr/bin/python3.11"
> +ENV PYTHON="/usr/bin/python3.12"
>  # As a final step configure the user (if env is defined)
>  ARG USER
>  ARG UID
> diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
> index 2b317e0a61c5..5c56e4aca1b0 100644
> --- a/tests/lcitool/mappings.yml
> +++ b/tests/lcitool/mappings.yml
> @@ -4,16 +4,16 @@ mappings:
>      Ubuntu2204:
>  
>    python3:
> -    CentOSStream9: python3.11
> +    CentOSStream9: python3.12
>  
>    python3-devel:
> -    CentOSStream9: python3.11-devel
> +    CentOSStream9: python3.21-devel

3.21 -> 3.12

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


