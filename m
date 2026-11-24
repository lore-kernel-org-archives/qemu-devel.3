Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645AE606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NPrOrhcm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVwPW-0000kY-0l; Tue, 24 Nov 2026 14:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xVwP6-0000fE-J9
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:42:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xVwP5-00012G-4r
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795549328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aJkgFt8xjUdaDSoNHUDWH0R2q3LcwADrXRqgLeQmvh8=;
 b=NPrOrhcmLAhPNk374VEWK1srUIKjbacDijstUp972YyzsZrx4iL0H1MSQHPA7TLK8YZ0j6
 Jh4UYwcTCgP/8VZUAQ4jyanEY25XgvwYTSrx7+SgcJQnsrgU5Pulf4jB/xAwtoaV9cVRsQ
 3QJMQyuUcVV5K2XLcM9YRWmef2QtYpc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-2rpY3QcgN5y6gWvS7cHoVg-1; Tue,
 24 Nov 2026 19:42:04 +0000
X-MC-Unique: 2rpY3QcgN5y6gWvS7cHoVg-1
X-Mimecast-MFC-AGG-ID: 2rpY3QcgN5y6gWvS7cHoVg_1795549323
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9989018052ED; Tue, 24 Nov 2026 19:42:03 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 619A118004FC; Tue, 24 Nov 2026 19:42:00 +0000 (UTC)
Date: Tue, 24 Nov 2026 13:41:55 -0600
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, 
 peter.maydell@linaro.org, berrange@redhat.com, armbru@redhat.com,
 alex.bennee@linaro.org
Subject: Re: [PATCH 2/3] AGENTS.md: let agents know what the participation
 rules are
Message-ID: <awXodJFK6fnP6uUW@redhat.com>
References: <20261124164217.1768040-1-pbonzini@redhat.com>
 <20261124164217.1768040-3-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261124164217.1768040-3-pbonzini@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 05:42:16PM +0100, Paolo Bonzini wrote:
> Humans seem to be extremely unreliable in following rules around this,
> even after being told directly and repeatedly. Telling agents what to
> do seems to yield better results.
> 
> The starting point for this document is GStreamer's AGENTS.md file, as
> of commit d08375499c279a56c0e77c928fbeae0d80cdf937.  I used GStreamer's
> agent instructions in the context of Meson, which uses a very similar
> file, and it's both annoying and too willing to take the lead once the
> model decides that it likes you.
> 
> To avoid this, the text tries to favor cooperation between agent and user.
> It suggests that the agent includes the state of the work when committing,
> so that contributors have the material they need to review the agent's
> work.
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  AGENTS.md | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


