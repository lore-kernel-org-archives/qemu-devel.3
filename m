Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D60C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 05:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGtVU-0002Uo-Km; Mon, 19 May 2025 01:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uGtVS-0002Uf-7I
 for qemu-devel@nongnu.org; Mon, 19 May 2025 01:57:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uGtVQ-0000iU-DN
 for qemu-devel@nongnu.org; Mon, 19 May 2025 01:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747634261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmLGG4R/tVOOnk7rY/pzQ66kGEsPX4hEwuqGbtZyU/8=;
 b=SgId30o7AxA11PIthTJ/NaaI/R34aggrQNzkMNFjfqDpRZxfFdWpSDkTQMs/HImI13JvMz
 y7Z8eJj48xLhrr2DWheMHrKxxwHnQ5ggzPI4qaUJId3QCzUs96kURM/MBsK9KV93MR9eIN
 6IXZf2yXo3GOKCLMglyI44LeT4YWKM8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-oJ06FS_UN3OkVmKQwLRTlQ-1; Mon,
 19 May 2025 01:57:38 -0400
X-MC-Unique: oJ06FS_UN3OkVmKQwLRTlQ-1
X-Mimecast-MFC-AGG-ID: oJ06FS_UN3OkVmKQwLRTlQ_1747634257
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94DC419560AE; Mon, 19 May 2025 05:57:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A550C180049D; Mon, 19 May 2025 05:57:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 203BD21E66C3; Mon, 19 May 2025 07:57:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Michael Roth
 <michael.roth@amd.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  berrange@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 02/12] qapi: expand docs for SEV commands
In-Reply-To: <20250515172732.3992504-3-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 15 May 2025 10:27:22 -0700")
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
 <20250515172732.3992504-3-pierrick.bouvier@linaro.org>
Date: Mon, 19 May 2025 07:57:34 +0200
Message-ID: <871pslkur5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> This gives some more context about the behaviour of the commands in
> unsupported guest configuration or platform scenarios.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  qapi/misc-target.json | 43 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 36 insertions(+), 7 deletions(-)
>
> diff --git a/qapi/misc-target.json b/qapi/misc-target.json
> index 5d0ffb0164f..ae55e437a5f 100644
> --- a/qapi/misc-target.json
> +++ b/qapi/misc-target.json
> @@ -110,7 +110,11 @@
>  ##
>  # @query-sev:
>  #
> -# Returns information about SEV
> +# Returns information about SEV/SEV-ES/SEV-SNP.

We prefer imperative mood "Return" over "Returns".  Could also use "Get"
or "Query"; matter of taste.

> +#
> +# If unavailable due to an incompatible configuration the
> +# returned @enabled field will be set to 'false' and the

I'd prefer "field is set".

> +# state of all other fields is undefined.
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

Errors better go into their own section.

   # Returns: The @SevLaunchMeasureInfo for the guest
   #
   # Errors:
   #     - If the launch measurement is unavailable, either due to an
   #       invalid guest configuration or if the guest has not reached
   #       the required SEV state, GenericError

> @@ -185,8 +198,9 @@
>  ##
>  # @query-sev-capabilities:
>  #
> -# This command is used to get the SEV capabilities, and is supported
> -# on AMD X86 platforms only.
> +# This command is used to get the SEV capabilities, and is only
> +# supported on AMD X86 platforms with KVM enabled. If SEV is not
> +# available on the platform an error will be returned.
>  #
>  # Returns: SevCapability objects.
>  #

Likewise.

Suggest to use the opportunity to switch the intro to imperative mood.
Together:

   ##
   # Get SEV capabilities.
   #
   # This is only supported on AMD X86 platforms with KVM enabled.
   #
   # Returns: SevCapability objects.
   #=20
   # Errors:
   #     - If # SEV is not available on the platform, GenericError
   #

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

Likewise.

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

Likewise.

docs/devel/qapi-code-gen.rst:

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

    Separate sentences with two spaces.


