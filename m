Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE200C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 11:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmWd0-0005h3-OV; Mon, 24 Feb 2025 06:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tmWcz-0005gt-T4
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:28:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tmWcx-0003YV-QZ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 06:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740396476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ydNXOc/IipmZD2imYH1NMp26SfTnsk98P5B5ovD+mBU=;
 b=V2nZsSJfDdIVoKLV5hRMwFLnWNc8ToGHEQtbjTfxOyrBiTqWV7FXiNbRuBwitNbQyH5dJ3
 isVIBRuUacs83uLMnFkP3VBKo3D8kC4wjGMFk950PRP1B4gakbdcmVd5eHIU2G+IcPBWxU
 XqZYRd9j+1m11XKCpDtUeMdj34jqNlc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-znrS-rZ9Ne-yOpZyBcxA5g-1; Mon,
 24 Feb 2025 06:27:52 -0500
X-MC-Unique: znrS-rZ9Ne-yOpZyBcxA5g-1
X-Mimecast-MFC-AGG-ID: znrS-rZ9Ne-yOpZyBcxA5g_1740396471
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1EA9196E078; Mon, 24 Feb 2025 11:27:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 615B5300018D; Mon, 24 Feb 2025 11:27:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EF2F921E675F; Mon, 24 Feb 2025 12:27:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] MAINTAINERS: remove widely sanctioned entities
In-Reply-To: <20250221161443.2321327-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Fri, 21 Feb 2025 16:14:43 +0000")
References: <20250221161443.2321327-1-alex.bennee@linaro.org>
Date: Mon, 24 Feb 2025 12:27:48 +0100
Message-ID: <8734g3h9aj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> The following organisations appear on the US sanctions list:
>
>   Yadro: https://sanctionssearch.ofac.treas.gov/Details.aspx?id=3D41125
>   ISPRAS: https://sanctionssearch.ofac.treas.gov/Details.aspx?id=3D50890
>
> As a result maintainers interacting with such entities would face
> legal risk in a number of jurisdictions. To reduce the risk of
> inadvertent non-compliance remove entries from these organisations
> from the MAINTAINERS file.
>
> Mark the pcf8574 system as orphaned until someone volunteers to step
> up as a maintainer. Add myself as a second reviewer to record/replay
> so I can help with what odd fixes I can.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I have nothing but respect for the individuals this drops from
MAINTAINERS, and am grateful for their contributions.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


