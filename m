Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E347C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 04:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whK2Z-0000zN-TV; Wed, 08 Jul 2026 00:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1whK2Y-0000z6-EF
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 00:37:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1whK2V-0005Zk-Ha
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 00:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783485458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MEc1lZ0nB4a1x1y5BVVpMLZISPgR4IzaNZqjQkqTrp4=;
 b=ZOBMAoayNAjCHI7+w1ieLO7tDAmF3LrOSvFvz5ntNyk79D48b2K3e4axS4J34qvImEjSmA
 SLPROi9DgRDfIRvu2ckdc6SHkoeK962Oji9GekwUoysPXSOEeZgb46UgOfzh7D4kkJGKjs
 Orex1c+TqGfYxeZejlB3thiwZwTu2ls=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-pnTR7nsDPQGQtoCOdoJiVg-1; Wed,
 08 Jul 2026 00:37:34 -0400
X-MC-Unique: pnTR7nsDPQGQtoCOdoJiVg-1
X-Mimecast-MFC-AGG-ID: pnTR7nsDPQGQtoCOdoJiVg_1783485453
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9AE4180136A; Wed,  8 Jul 2026 04:37:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29D4D18005B5; Wed,  8 Jul 2026 04:37:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B623921E6920; Wed, 08 Jul 2026 06:37:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com,  kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com,  peter.maydell@linaro.org,
 mst@redhat.com,  cohuck@redhat.com,  pbonzini@redhat.com,
 eblake@redhat.com,  jpb@kernel.org,  lorenzo.pieralisi@linaro.org,
 qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  kvm@vger.kernel.org
Subject: Re: [RFC v1 23/25] docs/interop/firmware.json: Add arm-rme firmware
 feature
In-Reply-To: <20260707224306.1202330-24-mathieu.poirier@linaro.org> (Mathieu
 Poirier's message of "Tue, 7 Jul 2026 16:43:04 -0600")
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-24-mathieu.poirier@linaro.org>
Date: Wed, 08 Jul 2026 06:37:29 +0200
Message-ID: <87fr1um706.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>
> Some distributions provide packages continaing firmware to be run under
> QEMU, such as "qemu-efi-aarch64" or "edk2-aarch64". Those packages also
> contain descriptors in /usr/share/qemu/firmware/*.json listing the
> firmware features, so that environments like libvirt can figure out
> which firmware they can load.
>
> Define an optional feature for arm64 firmware to indicate that a
> firmware supports running in a Realm. Firmware implementations need
> extra support for running in a Realm, in particular to distinguish
> shared from private guest memory.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  docs/interop/firmware.json | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index 421bee0e5ed4..c68d7f5013f8 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -161,6 +161,9 @@
>  #     options related to this feature are documented in
>  #     "docs/system/i386/amd-memory-encryption.rst".
>  #
> +# @arm-rme: The firmware supports running in a Realm, under the Arm Realm
> +#           Management Extension (RME).
> +#

Please format like this

   # @arm-rme: The firmware supports running in a Realm, under the Arm
   #     Realm Management Extension (RME).

>  # @intel-tdx: The firmware supports running under Intel Trust Domain
>  #     Extensions (TDX).
>  #
> @@ -229,7 +232,7 @@
>  { 'enum' : 'FirmwareFeature',
>    'data' : [ 'acpi-s3', 'acpi-s4',
>               'amd-sev', 'amd-sev-es', 'amd-sev-snp',
> -             'intel-tdx',
> +             'arm-rme', 'intel-tdx',
>               'enrolled-keys', 'requires-smm',
>               'secure-boot', 'host-uefi-vars',
>               'verbose-dynamic', 'verbose-static' ] }

With the formatting tidied up
Acked-by: Markus Armbruster <armbru@redhat.com>


