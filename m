Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10074CD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbyvF-0008CJ-Qc; Tue, 23 Jun 2026 07:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1wbyvD-000849-3v
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1wbyvB-0006Kr-H8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 07:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782212639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1JIgEclowEXABG9SdcQNGXY2ozHxip5lkQmRqI7eO0=;
 b=O0J0OaeOZDv4NTVMD1eKB4uWuziFPKGPKAqZ5VBNvgOGTebCGkdUUz/uTmH/ZGbFgqyY5k
 Q836fOIq6GCaUOum9jAjmsCoqehdjO8loM81hiMQk+Sg/b0xaVyuoubjJxkTqv19YINs/+
 E4GnoOe59wBZO/Ci+0+Xwb+LijoYfFA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-CtvLYU_2N_e-SHExjiJAfg-1; Tue,
 23 Jun 2026 07:03:55 -0400
X-MC-Unique: CtvLYU_2N_e-SHExjiJAfg-1
X-Mimecast-MFC-AGG-ID: CtvLYU_2N_e-SHExjiJAfg_1782212634
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 922AB1955DAE; Tue, 23 Jun 2026 11:03:53 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA9571800348; Tue, 23 Jun 2026 11:03:49 +0000 (UTC)
Date: Tue, 23 Jun 2026 13:03:46 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 00/35] monitor: turn QMP and HMP into QOM objects
Message-ID: <ajpoEoUcQ5IxMJy1@angien.pipo.sk>
References: <20260623095551.2106712-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623095551.2106712-1-berrange@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 23, 2026 at 10:55:16 +0100, Daniel P. Berrangé via Devel wrote:
> Conceptually -object and object_add/object_del should be sufficient
> for essentially all QEMU configuration....if only we ported all our
> internal custom backends/devices/etc to QOM. That is of course a big
> job which is why it hasn't happened.
> 
> This series started with the premise that the monitor is one of the
> easier areas to convert since we have no more than three classes,
> a common base, and QMP and HMP subclasses[1]. So why not give it a
> go and thus unlock the ability to dynamically create/delete monitors
> in QMP/HMP.
> 
> This series does the conversion in a great many small steps to better
> understand the implications at each stage.
> 
> The high level outcome of this series is
> 
>  * HMP and QMP monitors are QOM objects, 'monitor-hmp' and
>    'monitor-qmp' respectively
> 
>  * Both can be cold plugged and hot plugged. QMP only, can
>    also be hot unplugged.
> 
>  * '-mon' is obsolete, deprecated and replaced by '-object',
>    but -monitor, -qmp and kept  as high level syntax sugar

I was giving this a spin by implementing libvirt support for it. The
basic usage seems to work well but I've encoutered a regression in
behaviour which happens both when the QMP monitor is instantiated using
the new syntax but also the old one
( -mon chardev=charmonitor,id=monitor,mode=control)

When libvirt wants to re-connect to a qemu running with these patches it
re-issues a 'qmp_capabilities' command after connecting.

With these patches qemu does not respond to that command even when the
old syntax is used. This makes libvirt stuck when re-connecting to VMs.

The log on libvirt's side is not very interesting:

2026-06-23 11:00:11.229+0000: 529808: debug : virSecuritySELinuxSetDaemonSocketLabel:3190 : Setting VM ha socket context unconfined_u:unconfined_r:unconfined_t:s0:c677,c680
2026-06-23 11:00:11.229+0000: 529807: info : qemuMonitorOpenInternal:608 : QEMU_MONITOR_NEW: mon=0x7fff94001b80 fd=35
2026-06-23 11:00:11.229+0000: 529807: debug : qemuDomainObjEnterMonitorInternal:5165 : Entering monitor (mon=0x7fff94001b80 vm=0x7fffac185b60 name=cd)
2026-06-23 11:00:11.229+0000: 529807: debug : qemuMonitorSetCapabilities:1437 : mon:0x7fff94001b80 vm:0x7fffac185b60 monfd:35
2026-06-23 11:00:11.229+0000: 529807: info : qemuMonitorSend:822 : QEMU_MONITOR_SEND_MSG: mon=0x7fff94001b80 msg={"execute":"qmp_capabilities","id":"libvirt-1"}^M

as nothing else ever comes from monitor 0x7fff94001b80


