Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13C0C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 14:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPijI-0002Ai-HC; Thu, 12 Jun 2025 10:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uPijB-00029d-1I
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uPij7-0005iy-Ua
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749737777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eet4CCnKiCdz4kay6uxTV2EPFXCO2j7HvnK8ae/+bP0=;
 b=MV9QEQ72vMokd5j8Lp8DCr7Tm1n+GNEE2VuYgDzpyxYbuDfoX5nrxt39fUbiXU2BhDDeoT
 IxJn88/3TOEXTJiMUxFNDnwkiqn26rwZE5/w2xaVJeUwz7VM3SXCLZL9MkE5Yh1h/oMYj/
 QRr64pGpjIeyffALAlD1Dn+KOXDtBy8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-2gvVUHA9OsG9Imy0aQWIFA-1; Thu,
 12 Jun 2025 10:16:10 -0400
X-MC-Unique: 2gvVUHA9OsG9Imy0aQWIFA-1
X-Mimecast-MFC-AGG-ID: 2gvVUHA9OsG9Imy0aQWIFA_1749737769
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33AC61956088; Thu, 12 Jun 2025 14:16:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.69])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A3A6180045B; Thu, 12 Jun 2025 14:16:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3B114180108A; Thu, 12 Jun 2025 16:16:05 +0200 (CEST)
Date: Thu, 12 Jun 2025 16:16:05 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 0/2] Seabios 1.17.0 20250611 patches
Message-ID: <4ftyylwfpk2d6xioduftadbbwq3cydjmzeaqivksseem4a2h5d@xg7u6y6qaaak>
References: <20250611075037.659610-1-kraxel@redhat.com>
 <3bc239aa-a2ab-400c-84b5-d7de3e5193ea@redhat.com>
 <CAJSP0QU++wDCXvYe2sUyHCZHrHVVY2ehdeAswjDE_5V2J-qE9w@mail.gmail.com>
 <4dd4bee5-7098-4f24-a81b-3935c58a6d9c@redhat.com>
 <CAJSP0QWyjzLLGnvrzMDtRubHuzAPWNtejb_wLz33PVWJ+QJLmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QWyjzLLGnvrzMDtRubHuzAPWNtejb_wLz33PVWJ+QJLmw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

  Hi,

> I didn't fix it. GitLab's mirror operation is still failing. Your
> suggestion of force pushing should fix it, but I want to understand
> why a commit was lost first.
> 
> The issue is that QEMU's mirror and upstream have diverged. The
> following commit is only in QEMU's mirror repo:
> 
> commit 44693a974cd90917f81a7d0310df4b592edd7e09
> Author: Christopher Lentocha <christopherericlentocha@gmail.com>
> Date:   Tue Jan 21 11:59:14 2025 -0500
> 
>     Fix AHCI Disk Detection when using EDK2 CSM
> 
> It is not possible to fast-forward to upstream's master due to this difference.
> 
> Gerd: Do you know what happened to this commit upstream?

Hmm, no idea.  Didn't notice it got lost until now.  Also can't remember
having seen a non-ff update on the seabios master branch when pulling.

Either me or Kevin must have deleted it by accident, or something went
wrong with the coreboot git server (where seabios git repo is hosted).

Guess we must do a forced update once to get them back in sync.

take care,
  Gerd


