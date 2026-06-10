Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D10CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXJtv-0001zv-77; Wed, 10 Jun 2026 10:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wXJtu-0001zn-47
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wXJts-0006Kb-Qx
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 10:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781101643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M0hpGkV66dtmsEeoaeeouULLbRThvqbfA3/mWGYdhI4=;
 b=Eur+HXFvVqdExBbC2RgPxGmu1c3Rec9IGnwM1YZ/z4mzCyyQ6H06uwao9sPFhleNCImPp7
 XUAEImJ3LSqmqxfJkOaVybp7ZlSuztQS32d3an5edQ3UPW7W4EO6nikvDCKd5IW5Px5K43
 UdK7ztxKc0lnJ+aW9tEO0xDLMSMfunM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-pKaeszRuPFeWwjdWXPxDkw-1; Wed,
 10 Jun 2026 10:27:21 -0400
X-MC-Unique: pKaeszRuPFeWwjdWXPxDkw-1
X-Mimecast-MFC-AGG-ID: pKaeszRuPFeWwjdWXPxDkw_1781101640
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 322CA185BD66
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 14:27:20 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.44.33.103])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C2CC4180058C; Wed, 10 Jun 2026 14:27:19 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id 6797980641C; Wed, 10 Jun 2026 16:27:18 +0200 (CEST)
Date: Wed, 10 Jun 2026 16:27:18 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] igvm: populate errp in stub functions
Message-ID: <ailrwxbi1i-xy37h@dobby.home.kraxel.org>
References: <20260609-igvm_stubs-v1-1-5f39d6e0db4a@redhat.com>
 <aigULaw73khPNxoR@redhat.com> <aigUdNYq0YRtAZKt@leonardi-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aigUdNYq0YRtAZKt@leonardi-redhat>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

  Hi,

> No, when IGVM is not enabled in the build it's not possible to trigger
> any of these stubs. On top of that, I don't think it is possible to trigger
> these stubs even when igvm is enabled. This is because the only architecture
> that implements igvm support in qemu is x86.

We have these stubs mainly to avoid linker errors when compiling igvm
support on !x86 architectures.  So we do compile igvm support for other
architectures (or, to be exact, we compile the core igvm code once and
link it into all qemu-system-$arch variants).

Nevertheless I think that the stubs should not be reachable.  The igvm
code already has checks like this ...

    } else if (target_arch() == SYS_EMU_TARGET_X86_64) {
        result = qigvm_x86_set_vp_context(data, vp_context->vp_index, errp);

... so it should never try to call x86 support code on
qemu-system-$somethingelse.

On that base I think switching to asserts should be fine.  If we
actually hit any assert the core code lacks a sanity check.

take care,
  Gerd


