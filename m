Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF086CD3447
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 11:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLIyt-0003lX-Bk; Fri, 08 May 2026 07:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLIyr-0003l7-OV
 for qemu-devel@nongnu.org; Fri, 08 May 2026 07:02:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLIyp-0007nP-BL
 for qemu-devel@nongnu.org; Fri, 08 May 2026 07:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778238169;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gGACEgXKKdmcbolTf9mSKV9ZsbFWfvhzwwhsPitvzNo=;
 b=JyTT79fJmA4ZRfcCioYpQaYtDLMWkQcrqP/l3qf1Qkxv1ARhDgxMfndYd5rqHFtvGqFcwl
 JHipUIT0Jknl1XGvPlYd60nAN2gHmas/Bq+1fC4iWSxfU5XpYGBnYpb4imu/y9dIGA9H2C
 W1aajDEOP4aVwsoYuOm463l+PnHvoiE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-nrogcM0xNOuatbs_CamqGA-1; Fri,
 08 May 2026 07:02:47 -0400
X-MC-Unique: nrogcM0xNOuatbs_CamqGA-1
X-Mimecast-MFC-AGG-ID: nrogcM0xNOuatbs_CamqGA_1778238166
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51D0818005B8; Fri,  8 May 2026 11:02:46 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.204])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A39C5195394A; Fri,  8 May 2026 11:02:44 +0000 (UTC)
Date: Fri, 8 May 2026 12:02:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] meson.build: Add -fzero-init-padding-bits=all
Message-ID: <af3C0NRWVTfYRXbu@redhat.com>
References: <20260508104723.2144051-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508104723.2144051-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 08, 2026 at 11:47:23AM +0100, Peter Maydell wrote:
> The C standard doesn't always guarantee that struct and union padding
> bits are zero initialized, even if the code initializes a struct.
> For QEMU, this is potentially problematic, because we often have
> structs that match data structures in guest memory, where we
> initialize them and then bulk copy them into the guest.  If the
> compiler didn't zero init the whole of the memory containing the
> struct, we could potentially leak random data from the host into the
> guest via the padding bytes.
> 
> We already use -ftrivial-auto-var-init=zero, which will zero out
> padding in many of these cases, but -fzero-init-padding-bits=all
> closes some gaps, for example cases where we initialize a
> variable with a struct initializer, and cases involving unions.
> 
> Follow the Linux kernel in using both options. Compare kernel
> commit dce4aab8441 ("kbuild: Use -fzero-init-padding-bits=all").
> 
> This option exists in gcc-15 and above; it's not supported
> by clang, but clang documents that it guarantees zero init
> of these cases always:
> https://clang.llvm.org/docs/LanguageExtensions.html#union-and-aggregate-initialization-in-c
> Older gcc which don't have the option behave as if it were set.
> 
> (These options are passed through the cc.get_supported_arguments()
> filter, so we don't need to do anything extra to avoid passing it to
> a compiler that doesn't recognize it.)
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> CC stable just as a precautionary thing; it's safe and we
> might as well make sure the hardening options are set there.
> ---
>  meson.build | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


