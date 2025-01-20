Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7047AC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 13:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taadT-0007rU-QS; Wed, 22 Jan 2025 08:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1taadO-0007r9-6D
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 08:19:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1taadK-0006hW-HV
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 08:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737551940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=ETvbZ1y0GnXnCEHw9vHGB65cA/LrS2sr6MMnCAtgtMo=;
 b=Y4PWXSuv16dJsrLc+A7Xb4JLvoIxiUv4tVjLbLpNGGq1bMTWbHGwpEA0MmR44+l7S0PjWO
 mHOxMzM4tNXqatCDttVrZQIgTSV2uvhcwLkR14TTooennqwWE2UiWJ8NkeWycVP1yXDABU
 zymMONSgTWmChUW0+Ptc5+8R2MBkMcE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-kUwP-R5IORSIxoozOS5WWw-1; Wed,
 22 Jan 2025 08:18:56 -0500
X-MC-Unique: kUwP-R5IORSIxoozOS5WWw-1
X-Mimecast-MFC-AGG-ID: kUwP-R5IORSIxoozOS5WWw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A2E81955DD4; Wed, 22 Jan 2025 13:18:54 +0000 (UTC)
Received: from gezellig (unknown [10.39.192.136])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B6DF19560AA; Wed, 22 Jan 2025 13:18:52 +0000 (UTC)
Resent-From: Kashyap Chamarthy <kchamart@redhat.com>
Resent-Date: Wed, 22 Jan 2025 14:18:49 +0100
Resent-Message-ID: <Z5DwOQ64Mftg8o4v@gezellig>
Resent-To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Date: Mon, 20 Jan 2025 10:06:07 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, sebott@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs/cpu-features: Update "PAuth" (Pointer
 Authentication) details
Message-ID: <Z44R-cUz9CWMp5Gi@gezellig>
References: <20250117191106.322363-1-kchamart@redhat.com>
 <20250117191106.322363-3-kchamart@redhat.com>
 <87sepgtp3e.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sepgtp3e.wl-maz@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

On Sat, Jan 18, 2025 at 10:04:37AM +0000, Marc Zyngier wrote:
> On Fri, 17 Jan 2025 19:11:06 +0000,
> Kashyap Chamarthy <kchamart@redhat.com> wrote:
> > 
> > PAuth (Pointer Authentication), a security feature in software, is
> > relevant for both KVM and QEMU.  Relect this fact into the docs:
> > 
> >   - For KVM, `pauth` is a binary, "on" vs "off" option.  The host CPU
> >     will choose the cryptographic algorithm.
> > 
> >   - For TCG, however, along with `pauth`, a couple of properties can be
> >     controlled -- they're are related to cryptographic algorithm choice.
> > 
> > Thanks to Peter Maydell and Marc Zyngier for explaining more about PAuth
> > on IRC (#qemu, OFTC).
> > 
> > Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> > ---

[...]

> > -TCG vCPU Features
> > -=================
> > +"PAuth" (Pointer Authentication)
> > +================================
> > +
> > +PAuth (Pointer Authentication) is a security feature in software that
> > +was introduced in Armv8.3-A and Armv9.0-A.  It aims to protect against
> 
> nit: given that ARMv9.0 is congruent to ARMv8.5 and therefore has all
> the ARMv8.5 features, mentioning ARMv8.3 should be enough (but I don't
> feel strongly about this). I feel much strongly about the use of
> capital letters, but I live in a distant past... ;-)

Sure, I can keep it to just v8.3.

On capitalization, I don't feel strongly about it, I just followed this
commit[1], which explained that the rebranding changed "ARM" to "Arm":

    6fe6d6c9a95 (docs: Be consistent about capitalization of 'Arm',
    2020-03-09)

That's why I went with it.  I see you know this by your "distant past"
remark :)  To match the above, I'll keep the capitalization to "Arm".

> > +ROP (return-oriented programming) attacks.
> > +
> > +KVM
> > +---
> > +
> > +``pauth``
> > +
> > +  Enable or disable ``FEAT_Pauth``.  The host silicon will choose the
> > +  cryptographic algorithm.  No other properties can be controlled.
> 
> nit: "choose" is a an odd choice of word. The host implementation
> defines, or even imposes the signature algorithm, as well as the level
> of PAuth support (PAuth, EPAC, PAuth2, FPAC, FPACCOMBINE, ...), some
> of which are mutually exclusive (EPAC and PAuth2 are incompatible).
> 
> Maybe it would be worth capturing some of these details, as this has a
> direct influence on the ability to migrate a VM.

Yeah, I thought about it but I was not sure if it's the right place.  As
you point out, there's a live-migration impact depending on the level of
PAuth support, so mentioning these details will be useful.

I'll come up with something for v2.  Thanks for looking!

-- 
/kashyap


