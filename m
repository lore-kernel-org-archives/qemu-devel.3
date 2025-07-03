Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EB4C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHAF-00049o-70; Thu, 03 Jul 2025 06:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1uXHAD-00049X-Ce
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1uXHAA-0006Y5-2A
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751538446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8FDoktE5kdVG8aAutup0Bp3nilcaZmhun/BLXKaX/R4=;
 b=hIQC6LrHSY43rMET8SrNbAKApfGfJQAjnivEjXGPP3k7Qo/lUz2TSt+858rGlFje9oH3+e
 CDFdO1YaXeJyuRCEaNubyBWzUW/LUpIzdhJ4PBo7rPv0PaES2xVC0Rc2q/54dcRvrkLCM/
 SY9AR4Akda0lV+BmWO4Wg51A+1+Bryc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-5Lhcx6qkMQah3JRaVHDBjQ-1; Thu, 03 Jul 2025 06:27:24 -0400
X-MC-Unique: 5Lhcx6qkMQah3JRaVHDBjQ-1
X-Mimecast-MFC-AGG-ID: 5Lhcx6qkMQah3JRaVHDBjQ_1751538443
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4538a2f4212so38077555e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751538443; x=1752143243;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8FDoktE5kdVG8aAutup0Bp3nilcaZmhun/BLXKaX/R4=;
 b=DX4BcWDW5eYtqaidxgNhIkiME2OV7DSrLfg5NJa67sRG5185EqszwhBu51kb/1jo+c
 Xkk7+y19iW04WFZPE6f9r+YXL/WxO7cvU6L73Z7EEMLu5GwFrj8o+DXcRcfYt0Me8+HX
 SJz0OexSfZ8txZujuqokKLVlri91dr5+ArDZROFUdj5vzMt6OXdtIth1kFfQLt0hS2x7
 JCrfiUFUKmjXbnel+peHLz/een8749jHtGowt0MDWotdtmYQnAQngPvAAUMb7CRrDSZW
 aYw/GWmJJMQvyNib22tOrpCdekfKKDi+jgO9kqezT5v67yXzM+S+QIUSB7Eg741S7GLX
 q3WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3WyRWs3aVNj3fwu8DeFvhu9VR+Gn2y/V06z/OZwWRgpQB898/ojffBBDnnbXeYm3pf6WfzTofYl8C@nongnu.org
X-Gm-Message-State: AOJu0YwMkVq8Fyih8koT1evyU5is0oIOgnRS+3pQEZXD1MDe9z3EXDYl
 ab8j70KsCcQYgArTk1RQZauU42rWeLs1AXo2mxszC+tUazsslt785IbpAm+S0BgA/lg5cvuZb6D
 qEFrBVfiK2qkwApqtlULZWITSubwiDwW5k+8OnOoHm+zR/2T2U5M9CVUL
X-Gm-Gg: ASbGncs/IBw0O1LglQexEJDEo/RQRl/6lNHColtmz6pSLfXlG4bHRgpG8TkP9n7Ftt8
 A20bAxS6QXs5cv77yxaJkhW10UYMdZvR3wfVa3a+248fYXl4zYsNYxWjlfyClI/aQDdutTOX70M
 UEeumPpfN0xiMg4KFr+btWxPLUSg8StYAXzKstfQp14i50/pqq2Tg0N3K8o4tSNMCtF2le7RPBw
 WjADyi3RSA/sM1or9WcBOWxWWA/UDLOqlUHD2DGvi2dqmlGwZRnMY16o8VlAP0GdDIWmlgkFQj9
 xPiGH4bt6ri5I1tXOrb61XH27aIfaahtnA==
X-Received: by 2002:a05:6000:21ca:b0:3a4:fc52:f5d4 with SMTP id
 ffacd0b85a97d-3b2005840cdmr3240333f8f.47.1751538442905; 
 Thu, 03 Jul 2025 03:27:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBDMBXVNQZtkVi3gutIZf8PlnbtBqxMN5AmyrAFHJT/YZXvrWsohEihMTurAJGheflv5apDg==
X-Received: by 2002:a05:6000:21ca:b0:3a4:fc52:f5d4 with SMTP id
 ffacd0b85a97d-3b2005840cdmr3240307f8f.47.1751538442322; 
 Thu, 03 Jul 2025 03:27:22 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud.
 [2a10:fc81:a806:d6a9::1]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52ad2sm18039524f8f.48.2025.07.03.03.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 03:27:21 -0700 (PDT)
Date: Thu, 3 Jul 2025 12:27:19 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Weil
 <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 09/10] net: Add passt network backend
Message-ID: <20250703122719.766a55e3@elisabeth>
In-Reply-To: <48ce7ba4-882e-4e6b-801a-135d489ae7f0@redhat.com>
References: <20250618155718.550968-1-lvivier@redhat.com>
 <20250618155718.550968-10-lvivier@redhat.com>
 <CACGkMEvcC7jv9LN5bP61E0OgSBENswotm+3fq8NAg3wBC9vUEQ@mail.gmail.com>
 <48ce7ba4-882e-4e6b-801a-135d489ae7f0@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sbrivio@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 1 Jul 2025 15:00:42 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> On 01/07/2025 03:46, Jason Wang wrote:
>
> > I would like to know the plan to support migration and its
> > compatibility for passt.  
> 
> As I said, the goal of this series is to be able to use '-nic passt' as we can use '-nic 
> user'. '-nic user' supports migration but TCP connections are lost.
> 
> With this series '-nic passt' supports migration but TCP connections are lost.
> 
> But we can improve '-nic passt' because we can migrate TCP connections too, for that we 
> need to launch passt-repair and to use vhost-user, if we really want to do this it can be 
> added (with a 'migration=on' parameter?)... but it's also already managed by '-netdev 
> vhost-user' and passt started manually or by libvirt.

For context, as I suppose it's not obvious: passt needs a helper on
both source and target to migrate TCP connections, because it needs the
TCP_REPAIR socket option (same as CRIU) to dump and load connection
parameters, to connect() TCP sockets without a new handshake, and to
close() them without a RST.

That helper is passt-repair(1), and its only purpose is to set and
clear TCP_REPAIR on sockets passed via SCM_RIGHTS.

By the way, at the moment, the only user of passt with a full
integration of the TCP migration capabilities is KubeVirt:

  https://github.com/kubevirt/enhancements/blob/main/veps/sig-network/passt-migration-proposal.md
  https://github.com/kubevirt/kubevirt/pull/14875

With libvirt, right now, one would need to run passt-repair manually.
Ideally, at some point, libvirt should gain the ability of doing all
that for the user, but I haven't even thought of a reasonable proposal
for how exactly libvirt could do this, yet.

Migration of everything else doesn't need any helper, but "everything
else" is just observed addresses at the moment, that is, passt needs to
know what link-local and global unicast addresses the guest used to
properly NAT traffic in some cases, and these are bits of back-end
state we also transfer.

-- 
Stefano


