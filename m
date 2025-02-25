Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58781C021BC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 08:01:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmpsP-0004fJ-Ut; Tue, 25 Feb 2025 03:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmpsL-0004ex-De
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 03:01:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmpsI-0002Fh-SQ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 03:01:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740470464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UTXiVhrh/zWPR+9n6ige5IUJSGcgDB/Uh9ILPTZoKyk=;
 b=VaA3Fn4Vh/q+uYGnfPwA7NtgY8jiKt9D1P91WVYxEVWQn9GkB73V89dI0W0PUDk/J9UZrE
 Q3inU+smD4M4q90PQC1HGQ0BomdCIjQ/5v4kI4i0zXVN6WGoJacW406D7zbWcRsj7xMcK2
 Y4IHY//t8+/4gdXHzyOXp1sBXBAprXo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-iX_8tUhqNb62otJWkzRK6A-1; Tue,
 25 Feb 2025 03:00:59 -0500
X-MC-Unique: iX_8tUhqNb62otJWkzRK6A-1
X-Mimecast-MFC-AGG-ID: iX_8tUhqNb62otJWkzRK6A_1740470457
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC476180087E; Tue, 25 Feb 2025 08:00:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.219])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E25C519560AB; Tue, 25 Feb 2025 08:00:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7269E1800091; Tue, 25 Feb 2025 09:00:53 +0100 (CET)
Date: Tue, 25 Feb 2025 09:00:53 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/i386: introduce x86_firmware_reconfigure api
Message-ID: <swzs7ekgm3blkn66tjzogllljjeminrheopf5z7skjss3s7zj3@o5uszou56i2r>
References: <20250221032051.35033-1-anisinha@redhat.com>
 <wdwnpkhgisjqzztersvs3vov4piwqaaxf7gqfm2v2tibbaeakd@rfe24yyhrflr>
 <CAK3XEhOHOKM-XqozhY4Vod8R7-kWhdi1EmnTT38RorG8DRYTdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK3XEhOHOKM-XqozhY4Vod8R7-kWhdi1EmnTT38RorG8DRYTdQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Feb 25, 2025 at 09:10:40AM +0530, Ani Sinha wrote:
> On Mon, Feb 24, 2025 at 9:01 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> >   Hi,
> >
> > >      /* should only be called once */
> > > -    if (ovmf_flash_parsed) {
> > > +    if (ovmf_flash_parsed && !force) {
> >
> > I think it makes more sense to clear ovmf_flash_parsed when replacing
> > the firmware (instead of adding the force override).
> 
> I thought about that but wondered if that is an internal
> variable/implementation specific detail which should not be exposed
> outside.

You don't have to expose the variable directly, you can also provide a
helper function to clear it.  Best with a name which documents the
purpose.

take care,
  Gerd


