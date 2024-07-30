Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97427C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYr62-0006R6-Tf; Tue, 30 Jul 2024 13:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYr5v-0006QH-Vy
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:57:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sYr5u-0004X3-DJ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722362225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tZr9kaM/CUPg8gq/nc48liOQoiLlwuUn6UtsJygLl6w=;
 b=ZmJbQC7X6BJkWCnXPSMTM3YDHYzctOIJFxI0vfBqLRbGUaPpsJz2JkvhjUwi14fHgt4X8t
 aBfI+IanFyzMf3m33uZAjtgqaMODwG/eXLzu+DqVIIxpJgTAF+lUbIxoudp+7wA55JXNPD
 9YtDiSUFYs63nUlMEWKM8TD3RX/aYcs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-8bBJTkNjNLWFb-FAvWKPdA-1; Tue, 30 Jul 2024 13:57:03 -0400
X-MC-Unique: 8bBJTkNjNLWFb-FAvWKPdA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5a534faa028so4809549a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 10:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722362223; x=1722967023;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tZr9kaM/CUPg8gq/nc48liOQoiLlwuUn6UtsJygLl6w=;
 b=kwa4SIa+6xg+5dmUu5PsH6F+bfRNHo2JsAJgy892oTBnNlGkXbKYS+9MTOvEH/JFi8
 ipUsbUVIt2iNnBiPdGGhcdmyG7hRIHgh1PG0eYhu5VekKR5Ou4DTUNYQvK/OKZq/usi1
 w79e9lkKqSSh4143Ua9mPH+W+fMiOkufk2MD1DztK0mZFTqah0HdHh5/q4D/fg93Wp7m
 O9wuKK3olUH9I9l8YbtJ1un9EY6LasJfAn9iGgciwV/KHUbBkZAGyv8oPQVByXSpn6ac
 O2WsVmYU09s4Mhfll6ZxC6tm0bJo7298Mj0xXvNze7tc5kxga59q4MT3diM9m5u05XHq
 YFxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCXrsI0O8EGWQYMP5SDxRxYIGCKbup9N/tL1f4FjdSUlbwfkm4fIaPk9WyoJIS9Cv//aax08J8epFRFLVCNsU7+n0mWDc=
X-Gm-Message-State: AOJu0YwAUXvSapjmdbs/tnfZGnuKLdSjsmOsYE12D1DcYAg0XGMGYrmK
 0WWN69cn8w/KGqJ3BYgzyaLJ1LyDfb1jN/e+3FCNqenj9irzbyK8Xo1L/jlhk3d9rmYiHB5ELv9
 HW142NrXgFHA5wqMZBjQuJ3ojEzqyNWM3ooezdXEtTnyhNK/Jqb9O
X-Received: by 2002:a50:d001:0:b0:5a3:b64:3b98 with SMTP id
 4fb4d7f45d1cf-5b020bbde40mr6584172a12.19.1722362222673; 
 Tue, 30 Jul 2024 10:57:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuGhg33idbLuoGki2S1lBS3nx9os7iR880ZzJI3UaOmb5bQfL8+r25PS9IVWB6VI6vmtz/Kw==
X-Received: by 2002:a50:d001:0:b0:5a3:b64:3b98 with SMTP id
 4fb4d7f45d1cf-5b020bbde40mr6584149a12.19.1722362221904; 
 Tue, 30 Jul 2024 10:57:01 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:ce53:abb9:7fe9:ef80:6a78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac6359392bsm7553867a12.33.2024.07.30.10.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 10:57:01 -0700 (PDT)
Date: Tue, 30 Jul 2024 13:56:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Yui Washizu <yui.washidu@gmail.com>
Subject: Re: [PATCH v5 0/8] virtio-net: add support for SR-IOV emulation
Message-ID: <20240730135602-mutt-send-email-mst@kernel.org>
References: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
 <20240730073712-mutt-send-email-mst@kernel.org>
 <125b333d-36a3-49d2-84e5-76a5f9d23a48@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <125b333d-36a3-49d2-84e5-76a5f9d23a48@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Jul 30, 2024 at 09:26:20PM +0900, Akihiko Odaki wrote:
> On 2024/07/30 20:37, Michael S. Tsirkin wrote:
> > On Mon, Jul 15, 2024 at 02:19:06PM +0900, Akihiko Odaki wrote:
> > > Based-on: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
> > > ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
> > 
> > OK I will revert this for now. We'll try again after the release,
> > there will be time to address s390.
> > 
> 
> I'd like to know if anybody wants to use igb on a s390x machine configured
> with libvirt. Such a configuration is already kind of broken, and it is
> likely to require significant effort on both side of libvirt and QEMU to fix
> it.


I assume Cédric wouldn't report it if was unused.


> As an alternative, I'm also introducing SR-IOV support to virtio-net-pci. It
> does not suffer the same problem with igb thanks to its flexible
> configuration mechanism.
> 
> Regards,
> Akihiko Odaki

Sounds like this needs more review time, anyway.



