Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6520210ED659
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w64zW-0002Cv-Iu; Fri, 27 Mar 2026 07:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w64zR-0002CP-Bo
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:04:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w64zP-0002di-GD
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774609469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mZpCcTF5vcb8c3hR5GSSbS6PwWKFR4qlQpkpKjSKfnY=;
 b=hgzjKsprMoWRyDOd+gBeLoSwP3Xbv4GAjWtCqszDSQebohG+Qx8QG1784pLb2K7XAVC/mI
 LtouMKSkuYlT6JZQZE4wZcCZDWe7ElyoOpydj1e4H7P6nZzqOGzcJGlRi1ymhJwxB1dVkz
 bNcC0Jv1BawxDLB+We4HlXr0Zp9VLss=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-U6hsU90MOg-YJTWC1xCx8Q-1; Fri,
 27 Mar 2026 07:04:26 -0400
X-MC-Unique: U6hsU90MOg-YJTWC1xCx8Q-1
X-Mimecast-MFC-AGG-ID: U6hsU90MOg-YJTWC1xCx8Q_1774609465
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DAC0195609E; Fri, 27 Mar 2026 11:04:25 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.239])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22EFF180058C; Fri, 27 Mar 2026 11:04:22 +0000 (UTC)
Date: Fri, 27 Mar 2026 12:04:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yan Vugenfirer <yvugenfi@redhat.com>
Subject: Re: [PATCH 7/7] meson: Build block_syms and qemu_syms only when
 enable_modules
Message-ID: <acZkNMFwyT6hz4-C@redhat.com>
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <20260326160033.68318-8-kkostiuk@redhat.com>
 <acVonq8XqzPItFxx@redhat.com>
 <a5a61b29-adea-457d-a3e8-c62e88cf8ff6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5a61b29-adea-457d-a3e8-c62e88cf8ff6@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Am 27.03.2026 um 11:47 hat Paolo Bonzini geschrieben:
> On 3/26/26 18:10, Kevin Wolf wrote:
> > Am 26.03.2026 um 17:00 hat Kostiantyn Kostiuk geschrieben:
> > > Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> > 
> > I'm not a meson expert, but the change itself looks ok to me.
> > 
> > However, the commit message is definitely a bit too empty. It should say
> > why you want to make this change.
> 
> Agreed, I *think* it's because scripts/undefsym.py would immediately exit
> here:
> 
>     if len(args) <= 3:
>         sys.exit(0)
> 
> but it should be spelled out.

If that's a problem, why doesn't ./configure --disable-modules fail on
Linux?

Kevin


