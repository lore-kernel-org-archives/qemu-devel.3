Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F8CE98E10
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSe2-0003dL-Fj; Mon, 23 Feb 2026 04:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vuSdW-0003CW-Mz
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:53:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vuSdT-0007ZN-T2
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840430;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J8W965Y8h3JHBViUOPnvqNiMbgbuvz0Arfa1VzILhD8=;
 b=cCcq/Sv6Y3C3vAXjRZ5tX64Hy9us7mA6WMmsPJomW31E8Nx5yR+tprxJnraoQ9fjD52hwd
 eNRTyNZt+9V9SX6phuG622UWgwBiUtM+a86sE64CkuYjuuzaHLrrv+Dj2JNGTNKJP2ZoEK
 Zsq3Je5uJmKzze881gzVjC6TenLj3rQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-dAPBLBITNQKIETtFXTFxzw-1; Mon,
 23 Feb 2026 04:53:48 -0500
X-MC-Unique: dAPBLBITNQKIETtFXTFxzw-1
X-Mimecast-MFC-AGG-ID: dAPBLBITNQKIETtFXTFxzw_1771840427
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A1561956072; Mon, 23 Feb 2026 09:53:47 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.11])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F47F1800670; Mon, 23 Feb 2026 09:53:44 +0000 (UTC)
Date: Mon, 23 Feb 2026 09:53:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
Subject: Re: [PATCH v2 00/16] rust: QObject and QAPI bindings
Message-ID: <aZwjpfu-qCCSoHdx@redhat.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108131043.490084-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Jan 08, 2026 at 02:10:27PM +0100, Paolo Bonzini wrote:
> This adds two related parts of the Rust bindings:
> 
> - QAPI code generator that creates Rust structs from the JSON
>   description.  The structs are *not* ABI compatible with the
>   C ones, instead they use native Rust data types.
> 
> - QObject bindings and (de)serialization support, which can be used to
>   convert QObjects to and from QAPI structs.
> 
> Unfortunately Rust code is not able to use visitors, other than by
> creating an intermediate QObject.  This is because of the different
> architecture of serde vs. QAPI visitors, and because visitor's
> dual-purpose functions, where the same function is used by both input and
> output visitors, rely heavily on the structs using the same representation
> as the visitor arguments (for example NUL-terminated strings).
> 
> The serde format implementation was co-authored by me and Marc-André.
> Marc-André did all the bug fixing and integration testing.
> 
> As an example of how this would be used, the marshaling functions for
> QMP commands would look like this:

Can you give more of the big picture about what follows this ?  From
this example you're showing, are you suggesting that you'll be soon
moving QMP command impls from C to Rust ?

> 
> fn qmp_marshal_query_stats(args: *mut QDict,
>     retp: *mut *mut QObject, errp: *mut *mut Error)
> {
>     let qobj = unsafe { QObject::cloned_from_raw(args.cast()) };
> 
>     let result = from_qobject::<StatsFilter>(qobj)
>          .map_err(anyhow::Error::from)
>          .and_then(qmp_query_stats)
>          .and_then(|ret| to_qobject::<Vec<StatsResult>>(ret).map_err(anyhow::Error::from));
> 
>     match qmp_marshal_query_stats_rs(qobj) {
>         Ok(ret) => unsafe { *retp = ret.into_raw(); },
>         Err(e) => unsafe { crate::Error::from(e).propagate(errp) },
>     }
> }
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


