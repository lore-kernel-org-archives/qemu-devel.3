Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39F4C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 12:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJtsI-0003XX-Jt; Tue, 27 May 2025 08:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJtsG-0003XF-Jz
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJtsC-0003xg-JU
 for qemu-devel@nongnu.org; Tue, 27 May 2025 08:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748350654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jc2urrYN6Tpus1iL/LNkloxwXKQm1S5NZ/BdI6J/cQw=;
 b=gAB2MC527ZoBhazC45THphZrzO/ovR6HCUj/Quj0ZkXnRrh2iRUuJ/o/WCPWckHC+Od3pU
 VKxAE07bTMCXbppiTOX9qM9WmpNtASyLgevyVjo4RZrOV/LJEWOe6nh7ZQG5vMaaCWADRK
 QciUm39PNR27LdzBSyaIgwb3116QLT8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-DpjaI5MzPeiL1udbizmYGw-1; Tue,
 27 May 2025 08:57:33 -0400
X-MC-Unique: DpjaI5MzPeiL1udbizmYGw-1
X-Mimecast-MFC-AGG-ID: DpjaI5MzPeiL1udbizmYGw_1748350652
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 167CF1800261; Tue, 27 May 2025 12:57:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C8E719560AB; Tue, 27 May 2025 12:57:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F1CAA21E675E; Tue, 27 May 2025 14:57:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  thuth@redhat.com,
 pbonzini@redhat.com,  richard.henderson@linaro.org,
 peter.maydell@linaro.org,  berrange@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH v4 15/15] qapi/misc-i386: move errors to their own
 documentation section
In-Reply-To: <20250522190542.588267-16-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 22 May 2025 12:05:42 -0700")
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
 <20250522190542.588267-16-pierrick.bouvier@linaro.org>
Date: Tue, 27 May 2025 14:57:28 +0200
Message-ID: <87o6venrd3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  qapi/misc-i386.json | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
> index 6f79817e382..796eaa5f406 100644
> --- a/qapi/misc-i386.json
> +++ b/qapi/misc-i386.json
> @@ -166,12 +166,13 @@
>  # measurement for SEV-SNP guests is only available within
>  # the guest.
>  #
> -# This will return an error if the launch measurement is
> -# unavailable, either due to an invalid guest configuration
> -# or if the guest has not reached the required SEV state.
> -#
>  # Returns: The @SevLaunchMeasureInfo for the guest
>  #
> +# Errors:
> +#     - If the launch measurement is unavailable, either due to an
> +#       invalid guest configuration or if the guest has not reached
> +#       the required SEV state, GenericError
> +#
>  # Since: 2.12
>  #
>  # .. qmp-example::
> @@ -210,12 +211,15 @@
>  ##
>  # @query-sev-capabilities:
>  #
> -# This command is used to get the SEV capabilities, and is only
> -# supported on AMD X86 platforms with KVM enabled. If SEV is not
> -# available on the platform an error will be returned.
> +# Get SEV capabilities.
> +#
> +# This is only supported on AMD X86 platforms with KVM enabled.
>  #
>  # Returns: SevCapability objects.
>  #
> +# Errors:
> +#     - If # SEV is not available on the platform, GenericError

Stray #

> +#
>  # Since: 2.12
>  #
>  # .. qmp-example::
> @@ -234,11 +238,7 @@
>  #
>  # This is only valid on x86 machines configured with KVM and the
>  # 'sev-guest' confidential virtualization object. SEV-SNP guests
> -# do not support launch secret injection
> -#
> -# This will return an error if launch secret injection is not possible,
> -# either due to an invalid guest configuration, or if the guest has not
> -# reached the required SEV state.
> +# do not support launch secret injection.
>  #
>  # @packet-header: the launch secret packet header encoded in base64
>  #
> @@ -246,6 +246,11 @@
>  #
>  # @gpa: the guest physical address where secret will be injected.
>  #
> +# Errors:
> +#     - If launch secret injection is not possible, either due to
> +#       an invalid guest configuration, or if the guest has not
> +#       reached the required SEV state, GenericError
> +#
>  # Since: 6.0
>  ##
>  { 'command': 'sev-inject-launch-secret',
> @@ -273,15 +278,17 @@
>  # 'sev-guest' confidential virtualization object. The attestation
>  # report for SEV-SNP guests is only available within the guest.
>  #
> -# This will return an error if the attestation report is
> -# unavailable, either due to an invalid guest configuration
> -# or if the guest has not reached the required SEV state.
> -#
>  # @mnonce: a random 16 bytes value encoded in base64 (it will be
>  #     included in report)
>  #
>  # Returns: SevAttestationReport objects.
>  #
> +# Errors:
> +#     - This will return an error if the attestation report is

Scratch "This will return an error"

> +#       unavailable, either due to an invalid guest configuration
> +#       or if the guest has not reached the required SEV state,
> +#       GenericError
> +#
>  # Since: 6.1
>  #
>  # .. qmp-example::


