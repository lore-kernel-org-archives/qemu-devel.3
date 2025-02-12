Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3505C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEQw-0000wk-1B; Wed, 12 Feb 2025 10:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiEQr-0000vh-WF
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:13:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiEQp-0006s4-Lo
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739373221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ikfzaXif5O4UjkldV940638RllzN4Raj95Ue7hkAmlA=;
 b=GSA/UWmuNzIxno0rGIkIEZikCFgjsIPzQvetpTKdUsvR1aY+0ICD4KRy0YyOVA2e4Avzep
 u7M3nA38u07bNWD9k/omgSFmUM92mg6esO3b9sH3K1+yOqPXenJYncRm2EX6Fc7M5d38dF
 LAG6Yxdr1DxUiR31/Kk5jaDQNLUnX2I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-KARjU9MFM4uqcXKksAw1_w-1; Wed,
 12 Feb 2025 10:13:40 -0500
X-MC-Unique: KARjU9MFM4uqcXKksAw1_w-1
X-Mimecast-MFC-AGG-ID: KARjU9MFM4uqcXKksAw1_w_1739373218
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 418B719560A1; Wed, 12 Feb 2025 15:13:38 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.168])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1E9E1800115; Wed, 12 Feb 2025 15:13:35 +0000 (UTC)
Date: Wed, 12 Feb 2025 16:13:33 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/11] rust: Add some block layer bindings
Message-ID: <Z6y6nUo68dIkryOu@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-4-kwolf@redhat.com>
 <b7b2ab97-acd3-4008-abd6-3da874541113@redhat.com>
 <Z6yecuOmtQKYUwLj@redhat.com>
 <CABgObfb-MXHYY4eM5LUbiRdOqWFG_CEcM-Xkv+v_dNWMwThKHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfb-MXHYY4eM5LUbiRdOqWFG_CEcM-Xkv+v_dNWMwThKHA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 12.02.2025 um 14:47 hat Paolo Bonzini geschrieben:
> On Wed, Feb 12, 2025 at 2:13 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > Yes, we definitely need some proper bindings there. I'm already tired of
> > writing things like this:
> >
> >     return -(bindings::EINVAL as std::os::raw::c_int)
> >
> > Or even:
> >
> >     return e
> >         .raw_os_error()
> >         .unwrap_or(-(bindings::EIO as std::os::raw::c_int))
> 
> This by the way seemed incorrect to me as it should be
> 
>      return -(e
>          .raw_os_error()
>          .unwrap_or(bindings::EIO as std::os::raw::c_int))
> 
> (leaving aside that raw_os_error does not work on Windows)... But then
> I noticed that read_raw() also does not negate, which causes the error
> to print incorrectly...

Yes, I actually noticed that after sending the email and fixed it (and
another instances of the same) up locally.

> > Which actually already shows that your errno binding patch does the
> > opposite direction of what I needed in this series.
> 
> ... so my patch already helps a bit: you can still change
> 
>     if ret < 0 {
>          Err(Error::from_raw_os_error(ret))
>     } else {
>          Ok(())
>     }
> 
> to
> 
>    errno::into_io_result(ret)?;
>    Ok(())
> 
> and avoid the positive/negative confusion.

No reason to write essentially if (ret != 0) { ret } else { 0 }. This
one should do:

    errno::into_io_result(ret)

And yes, it's already a good improvement.

> Anyhow, I guess the first one wouldn't be much better:
> 
>    return errno::into_negative_errno(ErrorKind::InvalidInput);
> 
> whereas the second could be
> 
>    return errno::into_negative_errno(e);
> 
> But then the first is already a special case; it only happens where
> your bindings are not trivial thanks to the introduction of the
> Mapping type.

Yes, the second one seems like the more important one because the other
one should only happen in bindings eventually. We could still have
something like an errno!(InvalidInput) to make the code in bindings less
verbose.

Or if you have to define the constants anyway - you currently do this
only for Windows, but for into_negative_errno() you might need it on
Linux, too - and it wouldn't be a problem for the constants to be
signed (that they are unsigned is the main reason why it becomes so ugly
with the bindgen constants), you could just make it -errno::EINVAL
again.

Kevin


