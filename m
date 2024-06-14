Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFEFC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 07:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI0ye-000444-RU; Fri, 14 Jun 2024 03:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sI0yd-00042O-Hl
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sI0yc-00050x-54
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718348636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KGlHMv7GgAdtmwNwvoEVn2WtwzNvEl24MYmPZfAC67E=;
 b=EbRkh7fVry2aF5bM08vSTRz/qn6BhW8Wuihsn1cEYMD5veK/4vAb3isyvqwzPRVH1Ev5py
 bCEfmk9JnjTFEKfJ6FhaNLr5+Qb9vn68SMPB4pE5MWiJdce8Mkua9uiLx+mrYp/sE6RKmG
 HatyfjH6FbW9acas9qsKOigFjvt0llc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-z5XXioZRNSy2i8pCFGDltA-1; Fri,
 14 Jun 2024 03:03:52 -0400
X-MC-Unique: z5XXioZRNSy2i8pCFGDltA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E82419560B4; Fri, 14 Jun 2024 07:03:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.178])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B5733000219; Fri, 14 Jun 2024 07:03:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5ED391800D65; Fri, 14 Jun 2024 09:03:48 +0200 (CEST)
Date: Fri, 14 Jun 2024 09:03:48 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 2/4] usb/hub: mark as deprecated
Message-ID: <ikx6c6o45yvwyrnzulrwt6bzentxmpclffod5djizycbfhcmmu@zuunl6mrz3kd>
References: <20240606143010.1318226-1-kraxel@redhat.com>
 <20240606143010.1318226-3-kraxel@redhat.com>
 <ZmHKotWS7ywfIvOj@redhat.com> <87r0d2w431.fsf@draig.linaro.org>
 <87o785b5vn.fsf@pond.sub.org> <ZmqvJIekaW9jWP6F@redhat.com>
 <87y1799lg8.fsf@pond.sub.org> <ZmrOgxutj7ETndGM@redhat.com>
 <8734pgx5ho.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734pgx5ho.fsf@draig.linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Jun 13, 2024 at 03:49:23PM GMT, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > I don't want to loose that clear & easily understood meaning, by overloading
> > "deprecated" for scenarios like "it is sometimes better to use a different
> > device instead of this one, depending on factors X, Y & Z".
> 
> I agree we shouldn't overload the meaning if deprecated.
> 
> So to this case in point. Is there anything you can do with usb/hub that
> you can't do with the newer xhci based one?

Well, it's a hub.  You can (virtually) plug it into a usb root port of a
ohci/uhci/ehci/xhci host adapter and get 8 more usb ports.  Those new
ports are usb 1.1 only though, so not very useful in a modern world,
except maybe for HID devices which don't need much bandwidth.

> Is it backward compatible
> enough that an old kernel would work? Or are we talking really old
> kernels at this point?

Pretty much everything should be able to drive the usb hub.

take care,
  Gerd


