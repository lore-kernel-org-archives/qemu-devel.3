Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217CFCA5FAB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 05:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBn2K-0003aT-AS; Wed, 30 Sep 2026 01:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBn2I-0003aK-HY
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 01:39:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBn2E-0003Cw-Qb
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 01:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790746756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bc4S+WvQ7UV7ol4ygWnM7Q0jgYUsR2/JQwfZMZpW+zs=;
 b=JezBPrueQidgw+hjxAKIpPDPioAt0TGLY7MzQ3s7gSxRUBVv0n2zTeTjJyFo1Lp4kOhkTU
 k89US9barfjX7hJcNiQ11Qzo52cJoMgP48FUFpp7gEwqagQynW3Ug+jOULhVL+RZ61Jh/B
 SFYvEO0BQ/Pns4uERF2BWn6Lgqs+FrU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-Yj1nbG0fOPmD3Gr78Cu5hw-1; Wed,
 30 Sep 2026 01:39:14 -0400
X-MC-Unique: Yj1nbG0fOPmD3Gr78Cu5hw-1
X-Mimecast-MFC-AGG-ID: Yj1nbG0fOPmD3Gr78Cu5hw_1790746753
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A51521800678
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 05:39:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6405419560AB
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 05:39:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C889221E6A04; Wed, 30 Sep 2026 07:39:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] qapi: convert intro sections fixup
In-Reply-To: <20260929223044.2998391-1-jsnow@redhat.com> (John Snow's message
 of "Tue, 29 Sep 2026 18:30:44 -0400")
References: <20260929223044.2998391-1-jsnow@redhat.com>
Date: Wed, 30 Sep 2026 07:39:10 +0200
Message-ID: <87ik3nti0x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

John Snow <jsnow@redhat.com> writes:

> "We" (Me, I, Myself) missed two last spots during bulk conversion of the
> intro section syntax.
>
> Some definitions are still intentionally left without an intro
> section: BlockdevSnapshotSync is the only case I am presently aware
> of.

There are quite a few more, but BlockdevSnapshotSync is the only one
followed by a plain section.

> The remaining two were genuinely just missed; convert them now.
>
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/machine-s390x.json |  4 ++--
>  qapi/qom.json           | 14 +++++++-------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/qapi/machine-s390x.json b/qapi/machine-s390x.json
> index 8d8cbe2fb75..9ae559bbc2d 100644
> --- a/qapi/machine-s390x.json
> +++ b/qapi/machine-s390x.json
> @@ -150,8 +150,8 @@
>  
>  ##
>  # @DummyBootCertificates:
> -#
> -# Not used by QMP; hack to let us use BootCertificatesList internally.
> +#     Not used by QMP; hack to let us use BootCertificatesList
> +#     internally.
>  #
>  # Since: 11.2
>  ##
> diff --git a/qapi/qom.json b/qapi/qom.json
> index e03ede34421..2d0d0e47fbb 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1039,13 +1039,13 @@
>  
>  ##
>  # @SevSnpGuestProperties:
> -#
> -# Properties for sev-snp-guest objects.  Most of these are direct
> -# arguments for the KVM_SNP_* interfaces documented in the Linux
> -# kernel source under
> -# Documentation/arch/x86/amd-memory-encryption.rst, which are in turn
> -# closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware commands
> -# documented in the SEV-SNP Firmware ABI Specification (Rev 0.9).
> +#     Properties for sev-snp-guest objects.  Most of these are direct
> +#     arguments for the KVM_SNP_* interfaces documented in the Linux
> +#     kernel source under
> +#     Documentation/arch/x86/amd-memory-encryption.rst, which are in
> +#     turn closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware
> +#     commands documented in the SEV-SNP Firmware ABI Specification
> +#     (Rev 0.9).
>  #
>  # More usage information is also available in the QEMU source tree
>  # under docs/amd-memory-encryption.

Hmm, shouldn't we split this one?


