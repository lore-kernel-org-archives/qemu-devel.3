Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A17DCCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 08:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBUZd-0004wu-6F; Wed, 22 Oct 2025 04:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vBUZb-0004wl-QP
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:51:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vBUZa-0007V2-4t
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761123115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HTVfpZ74qmUbTKaRa/nuyPzTywqjM3Wm6K/B+nnaUVk=;
 b=hzSyXJqcm+lnj7GRJxp60bAN8EsMx9r8uknVXRlghpTmrY61p78KN6zfNC8iPMv2K2wjLP
 zpwY3ovQU7iK5ISZybe1iB3RyV2AwoM6UNHWA/KZ4wuKWZYWLiy7BKdUHCatLOTBuRaxLS
 gcoey+Fg1lm5ccB6UIDEXNs5X46uQkM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-kzR3WXixPjG9lgj5cv38sg-1; Wed,
 22 Oct 2025 04:51:52 -0400
X-MC-Unique: kzR3WXixPjG9lgj5cv38sg-1
X-Mimecast-MFC-AGG-ID: kzR3WXixPjG9lgj5cv38sg_1761123111
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E651319541BD; Wed, 22 Oct 2025 08:51:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A7F3180044F; Wed, 22 Oct 2025 08:51:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EC86F18000B5; Wed, 22 Oct 2025 10:51:47 +0200 (CEST)
Date: Wed, 22 Oct 2025 10:51:47 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 5/5] igvm: add MAINTAINERS entry
Message-ID: <3hkj3ririipknv74qz3d7i3vgfn7hbfp5vibdfe6ax4jebgshd@44gfd4sj4ogw>
References: <20251015112342.1672955-1-kraxel@redhat.com>
 <20251015112342.1672955-6-kraxel@redhat.com>
 <b59aaee4-89c6-4033-946f-bc2702993294@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b59aaee4-89c6-4033-946f-bc2702993294@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 22, 2025 at 08:57:39AM +0200, Philippe Mathieu-Daudé wrote:
> On 15/10/25 13:23, Gerd Hoffmann wrote:
> > Add Roy (being the original author) as maintainer.  Add myself as
> > reviewer.  Status to be decided.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >   MAINTAINERS | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 84cfd85e1fa1..3ebcbcdfdb04 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3893,6 +3893,15 @@ F: roms/edk2-*
> >   F: tests/data/uefi-boot-images/
> >   F: tests/uefi-test-tools/
> > +IGVM Firmware
> > +M: Roy Hopkins <roy.hopkins@randomman.co.uk>
> > +R: Gerd Hoffmann <kraxel@redhat.com>
> > +S: TBD
> 
> If not Supported, then Maintained?

I was hoping for Roy (as original igvm author) offers an opinion on
this.  Not sure he is still working on igvm though given that there
wasn't a single reply from him so far.  Should he moved on to other
things it doesn't make much sense to add him as maintainer ...

Roy?

take care,
  Gerd


