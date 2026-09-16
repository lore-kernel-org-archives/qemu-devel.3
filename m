Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF5BC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nud-0007ZT-Gf; Wed, 16 Sep 2026 07:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6nua-0007YT-M8
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 07:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x6nuX-0001NM-26
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 07:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789558483;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GPItmGHS9xfNsVi4422o0ziSBOe9IbPnGPvyCe6lmV8=;
 b=B4fMVjFjAwDQ80/H26SXCc4eIIJwwlyQBA4hyzqe4V40Q97mI3owTmkN4OOYk7Xtj8fWcl
 2GatKngLCDB42ngAAuPUEa9BpkxhSbPwy92ZArTCoqpOB/5kUKDzMX9MztZDj4Tx/1YQl3
 j8gcwddvXkOQ147/7xW3gMUQ7FXXobI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-DDfhOqbdOTC2P_AsI_frew-1; Wed,
 16 Sep 2026 07:34:40 -0400
X-MC-Unique: DDfhOqbdOTC2P_AsI_frew-1
X-Mimecast-MFC-AGG-ID: DDfhOqbdOTC2P_AsI_frew_1789558478
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADC921955D6C; Wed, 16 Sep 2026 11:34:37 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C40AE426; Wed, 16 Sep 2026 11:34:32 +0000 (UTC)
Date: Wed, 16 Sep 2026 12:34:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v8 06/10] hw/vmapple: aes: convert MAX_LEN to a #define
Message-ID: <aqp-xTxJaZEFNsQA@redhat.com>
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
 <20260916100021.73825-7-mohamed@unpredictable.fr>
 <CAFEAcA_T1Ka5M=40LYKXD1nwnEefYbjx5mG=OfWuDqwFkMcdYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_T1Ka5M=40LYKXD1nwnEefYbjx5mG=OfWuDqwFkMcdYA@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Sep 16, 2026 at 12:20:33PM +0100, Peter Maydell wrote:
> On Wed, 16 Sept 2026 at 11:00, Mohamed Mediouni
> <mohamed@unpredictable.fr> wrote:
> >
> > Working around this compiler warning:
> >
> > ../hw/vmapple/aes.c:257:14: warning: variable length array folded to constant array as an extension [-Wgnu-folding-constant]
> >   257 |     char hex[MAX_LEN * 2 + 1] = "";
> >       |              ^~~~~~~~~~~~~~~
> > 1 warning generated.
> 
> I'm surprised this wasn't already caught by our '-Wvla' setting:
> we don't want to have variable length arrays at all.

The -Wgnu-folding-constant warning seems to be saying that
GCC will always evaluate this expresson at compile time
eliminating the variable length array. Presumably that
expansion happens before -Wvla gets to see the code.

IOW, this warning is saying that we're not portable to compilers
other than GCC/CLang, which is just fine by QEMU's intent.

If we don't want to change the code, it looks valid to add
-Wno-gnu-folding-constant, since we dont care about
portability to other compilers.

> 
> > Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> > ---
> >  hw/vmapple/aes.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/vmapple/aes.c b/hw/vmapple/aes.c
> > index 553e688adb..9d062d5a7f 100644
> > --- a/hw/vmapple/aes.c
> > +++ b/hw/vmapple/aes.c
> > @@ -253,7 +253,7 @@ static bool cmd_iv(AESState *s)
> >
> >  static void dump_data(const char *desc, const void *p, size_t len)
> >  {
> > -    static const size_t MAX_LEN = 0x1000;
> > +#define MAX_LEN  0x1000
> >      char hex[MAX_LEN * 2 + 1] = "";
> >
> >      if (len > MAX_LEN) {
> > @@ -262,6 +262,7 @@ static void dump_data(const char *desc, const void *p, size_t len)
> >
> >      qemu_hexdump_to_buffer(hex, sizeof(hex), p, len);
> >      trace_aes_dump_data(desc, hex);
> > +#undef MAX_LEN
> >  }
> 
> MAX_LEN is an awkwardly generic name. I would define it outside
> the function, something like
> 
> /* Maximum amount of AES data to dump in trace events */
> #define MAX_AES_DUMP_DATA_LEN 0x1000
> 
> Then you don't need to #undef it as there's no risk of a clash.
> 
> (Really this function ought not to do the binary-to-hex
> conversion of all the data unless the trace event is actually
> enabled, which docs/devel/tracing.rst says you can do, and
> it would maybe be nice to emit at least some truncated data
> in the "more than 1K of data" case, but let's stick to fixing
> the compile issues for the moment.)
> 
> thanks
> -- PMM
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


