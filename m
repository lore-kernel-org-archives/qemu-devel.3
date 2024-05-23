Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2E8C25B7A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 09:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA4Xa-0000Ga-0U; Thu, 23 May 2024 05:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sA4XW-0000Fv-R4
 for qemu-devel@nongnu.org; Thu, 23 May 2024 05:15:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sA4XQ-00038h-Me
 for qemu-devel@nongnu.org; Thu, 23 May 2024 05:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716455703;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVCJSHjn3S8LEfqzL3G4DwhtejyJWwlt/IXG49X9yEs=;
 b=XnlQP7/kVnCs3xQ7lg3Xa3uHO1/kl/nHGk+mUOIZ43vjEHKmO7eruZBI5gaJWeDGqCsdSZ
 u5+1c5SF1j81UNs2F7mvaasS4/aqweOIsDY+fZeKhO3GOWaQDfzBiYR+d9+v1n7Ke36z/W
 yf1k//QR1IO08pNanZmTJM25S2zHGAM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-LKNo5nvmMcer3Yx9r_SldQ-1; Thu, 23 May 2024 05:14:59 -0400
X-MC-Unique: LKNo5nvmMcer3Yx9r_SldQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69979101A551;
 Thu, 23 May 2024 09:14:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C30BC40C6EB7;
 Thu, 23 May 2024 09:14:58 +0000 (UTC)
Date: Thu, 23 May 2024 10:14:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Artyom Kunakovsky <artyomkunakovsky@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] meson.build: add -mcx16 flag
Message-ID: <Zk8JEJjrXDvMa49q@redhat.com>
References: <20240522193016.136866-1-artyomkunakovsky@gmail.com>
 <Zk74F0a8ejAp_mP8@redhat.com>
 <CAFEAcA-jGojmCeE3o=FbghjrSwVWOnKtj-orOtahPaDDv=n2Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-jGojmCeE3o=FbghjrSwVWOnKtj-orOtahPaDDv=n2Sg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 23, 2024 at 09:52:35AM +0100, Peter Maydell wrote:
> On Thu, 23 May 2024 at 09:04, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Wed, May 22, 2024 at 10:30:16PM +0300, Artyom Kunakovsky wrote:
> > > fix linker error if the project was configured by the './configure --cpu=unknown --target-list=riscv64-softmmu' command
> >
> > Isn't this simply user error, with the right answer being
> > to pass a valid CPU target to --cpu, rather than "unknown"
> 
> I've felt for ages that we should probably drop the "unrecognized
> host CPU, fall back to TCI" path and insist that we only run
> on recognized CPU types. Then we could also sanity check that
> the user passed a valid --cpu option.

Yeah, I think that's reasonable. Worst case, a user will have to send us a
patch to recognise a new CPU target, at which point at least we know that
it exists as a possible target.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


