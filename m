Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ECAC36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1oPe-0001PR-K7; Mon, 07 Apr 2025 11:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u1oPV-0001N1-7Y
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u1oPR-0000LW-Vq
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 11:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744039751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NIzfVCtunpWqSAMWhRMresRAwiWUPBx+LLA0Tun2PAE=;
 b=KTRafKipXGAdsQNtclzV71XET0o51DL8OBmZAd/3S/SKZaZC9XbHwY1wIEeUwesaX9KU9H
 BIc94yd6gI0nc6s0Hi4QtCD7Pf3ToaFR3rdYx984dZ0xmfkcZ6yzMikpMOCnnLtzQAF4/m
 wRskOGFrCT1WBaLmKL+FEQULOLOq9EY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-hUQxFyflOu6agev8LUPElw-1; Mon,
 07 Apr 2025 11:29:06 -0400
X-MC-Unique: hUQxFyflOu6agev8LUPElw-1
X-Mimecast-MFC-AGG-ID: hUQxFyflOu6agev8LUPElw_1744039745
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BC4C180AF53; Mon,  7 Apr 2025 15:29:05 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54CED3001D0E; Mon,  7 Apr 2025 15:29:01 +0000 (UTC)
Date: Mon, 7 Apr 2025 10:28:58 -0500
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com, 
 kwolf@redhat.com, armbru@redhat.com, jsnow@redhat.com, devel@lists.libvirt.org,
 pkrempa@redhat.com, michael.roth@amd.com, pbonzini@redhat.com
Subject: Re: [PATCH v2 1/2] qapi: synchronize jobs and block-jobs documentation
Message-ID: <747fxuxfvrmkesa5gnl5w343bacuenqhpfg2sgrcjl6wfyrbur@bvg7rw4lu4t3>
References: <20250404193154.707145-1-vsementsov@yandex-team.ru>
 <20250404193154.707145-2-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404193154.707145-2-vsementsov@yandex-team.ru>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Apr 04, 2025 at 10:31:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Actualize documentation and synchronize it for commands which actually
> call the same functions internally.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  qapi/block-core.json | 59 +++++++++++++++++++++++++-------------------
>  qapi/job.json        | 29 ++++++++++++++++++++--
>  2 files changed, 61 insertions(+), 27 deletions(-)
>

Overall makes sense, but one thing jumped out at me:

>  # @block-job-complete:
>  #
> -# Manually trigger completion of an active background block operation.
> -# This is supported for drive mirroring, where it also switches the
> -# device to write to the target path only.  The ability to complete is
> -# signaled with a BLOCK_JOB_READY event.
> +# Manually trigger completion of an active job in the READY or STANDBY
> +# state.  Completing the job in any other state is an error.
> +#
> +# This is supported only for drive mirroring (which includes
> +# drive-mirror, blockdev-mirror and block-commit job (only in case of
> +# "active commit", when the node being commited is used by the guest)),
> +# where it also switches the device to write to the target path only.

The doubly-nested parenthetical feels long.  Is there a more concise
way of expressing the list of three commands, where one of the
commands only supports it in the special case of "active commit"?


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


