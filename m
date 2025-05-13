Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDB0C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 12:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEoPZ-0006v9-LJ; Tue, 13 May 2025 08:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEoPP-0006u3-Ub
 for qemu-devel@nongnu.org; Tue, 13 May 2025 08:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEoPK-0004Jw-Nw
 for qemu-devel@nongnu.org; Tue, 13 May 2025 08:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747138007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GIYdh6aj0ntYCjyEH1vNNlmdCgzEXnaaUKLyoGaZJMk=;
 b=gfB7NsXzFMn+/+HpG8IZkIWswIbEnrHwpgKc8eJKWwzg60GxbtjV1AnEvsDyxe9R4bq39u
 AgtzRUMuRp3jR92KdFgeecXWkk6GQ3u21WUP02ZBbY6LfuLG26Mrit4ElQvusadnzodDhj
 DTKSlGcAW+GMBTip5iV2e7hMx2LO6W4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-4wU0s_3LMC2FA9cj6bozwA-1; Tue,
 13 May 2025 08:06:44 -0400
X-MC-Unique: 4wU0s_3LMC2FA9cj6bozwA-1
X-Mimecast-MFC-AGG-ID: 4wU0s_3LMC2FA9cj6bozwA_1747138003
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3363E1955D45; Tue, 13 May 2025 12:06:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE5B1180045B; Tue, 13 May 2025 12:06:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3728921E66C3; Tue, 13 May 2025 14:06:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 02/10] qapi: expand docs for SEV commands
In-Reply-To: <20250508135816.673087-3-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 8 May 2025 14:58:08
 +0100")
References: <20250508135816.673087-1-berrange@redhat.com>
 <20250508135816.673087-3-berrange@redhat.com>
Date: Tue, 13 May 2025 14:06:40 +0200
Message-ID: <8734d8emun.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> This gives some more context about the behaviour of the commands in
> unsupported guest configuration or platform scenarios.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qapi/misc-target.json | 43 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 36 insertions(+), 7 deletions(-)
>
> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
> index 5d0ffb0164..ae55e437a5 100644
> --- a/qapi/misc-target.json
> +++ b/qapi/misc-target.json
> @@ -110,7 +110,11 @@
>  ##
>  # @query-sev:
>  #
> -# Returns information about SEV
> +# Returns information about SEV/SEV-ES/SEV-SNP.
> +#
> +# If unavailable due to an incompatible configuration the
> +# returned @enabled field will be set to 'false' and the
> +# state of all other fields is undefined.

That's awful.  Not this patch's fault.

What's "incompatible configuration"?

Actual behavior as far as I can tell:

* If !CONFIG_SEV: GenericError "SEV is not available in this QEMU".

* If CONFIG_SEV and !sev_enabled(): SevInfo filled with zero bytes

* If CONFIG_SEV and sev_enabled(): SevInfo filled properly

sev_enabled() is true when the machine's cgs member is an instance of
"sev-common".

>  #
>  # Returns: @SevInfo
>  #
> @@ -141,7 +145,16 @@
>  ##
>  # @query-sev-launch-measure:
>  #
> -# Query the SEV guest launch information.
> +# Query the SEV/SEV-ES guest launch information.
> +#
> +# This is only valid on x86 machines configured with KVM and the
> +# 'sev-guest' confidential virtualization object. The launch
> +# measurement for SEV-SNP guests is only available within
> +# the guest.
> +#
> +# This will return an error if the launch measurement is
> +# unavailable, either due to an invalid guest configuration
> +# or if the guest has not reached the required SEV state.
>  #
>  # Returns: The @SevLaunchMeasureInfo for the guest
>  #
> @@ -185,8 +198,9 @@
>  ##
>  # @query-sev-capabilities:
>  #
> -# This command is used to get the SEV capabilities, and is supported
> -# on AMD X86 platforms only.
> +# This command is used to get the SEV capabilities, and is only
> +# supported on AMD X86 platforms with KVM enabled. If SEV is not
> +# available on the platform an error will be returned.

What does "not supported" mean here?

>  #
>  # Returns: SevCapability objects.
>  #
> @@ -205,7 +219,15 @@
>  ##
>  # @sev-inject-launch-secret:
>  #
> -# This command injects a secret blob into memory of SEV guest.
> +# This command injects a secret blob into memory of a SEV/SEV-ES guest.
> +#
> +# This is only valid on x86 machines configured with KVM and the
> +# 'sev-guest' confidential virtualization object. SEV-SNP guests
> +# do not support launch secret injection
> +#
> +# This will return an error if launch secret injection is not possible,
> +# either due to an invalid guest configuration, or if the guest has not
> +# reached the required SEV state.
>  #
>  # @packet-header: the launch secret packet header encoded in base64
>  #
> @@ -236,8 +258,15 @@
>  ##
>  # @query-sev-attestation-report:
>  #
> -# This command is used to get the SEV attestation report, and is
> -# supported on AMD X86 platforms only.
> +# This command is used to get the SEV attestation report.
> +#
> +# This is only valid on x86 machines configured with KVM and the
> +# 'sev-guest' confidential virtualization object. The attestation
> +# report for SEV-SNP guests is only available within the guest.
> +#
> +# This will return an error if the attestation report is
> +# unavailable, either due to an invalid guest configuration
> +# or if the guest has not reached the required SEV state.
>  #
>  # @mnonce: a random 16 bytes value encoded in base64 (it will be
>  #     included in report)

Strict improvemement already, so
Acked-by: Markus Armbruster <armbru@redhat.com>


