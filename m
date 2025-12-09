Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406D1D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 09:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vStrD-00053g-QH; Tue, 09 Dec 2025 04:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vStrC-00053U-Ff
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:18:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vStrA-00008i-HD
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765271882;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UzaPQgvetfjXB4DRUL1KWkZxUPY4t8Z8gJ/x4LQ7bg4=;
 b=RbF9h2ThriHzY3BOUnlT24cKhMUQAQuiMH09csb82ma8lE+GYvGMZq6iTef1lldkIqiTZg
 OqH3GNxSFq+boVFRmZh5coBHHGCv4+61WR+J1JT3sTneAWzT7tb8aIysoIol6GeapZNedc
 QHSFBikYk+tpcaFI7uWRi+JMkFdQTC0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-W52xwf-9Nkae4JYkTY6CyQ-1; Tue,
 09 Dec 2025 04:17:59 -0500
X-MC-Unique: W52xwf-9Nkae4JYkTY6CyQ-1
X-Mimecast-MFC-AGG-ID: W52xwf-9Nkae4JYkTY6CyQ_1765271878
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE3F01956052; Tue,  9 Dec 2025 09:17:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.79])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 082431956095; Tue,  9 Dec 2025 09:17:55 +0000 (UTC)
Date: Tue, 9 Dec 2025 09:17:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@opnsrc.net>
Subject: Re: FWD: [ATTENTION] Mails on qemu mailing list are disapapearing
 making communication unreliable
Message-ID: <aTfpQO14axEvcOIT@redhat.com>
References: <CAJ7pxeY8dpK53ePE6YcXqHpmxD9B7e9tY49ij6HzgU450OgYLA@mail.gmail.com>
 <20251209022028-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251209022028-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 SUBJ_ATTENTION=0.499 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Dec 09, 2025 at 02:24:44AM -0500, Michael S. Tsirkin wrote:
> Hi guys,
> who has ability to contact the list admins? Can help Salil?

I'm not a list admin, but I have some observations below

> ----- Forwarded message from Salil Mehta <salil.mehta@opnsrc.net> -----
> 
> From: Salil Mehta <salil.mehta@opnsrc.net>
> Date: Tue, 9 Dec 2025 00:44:04 +0000
> To: "Michael S. Tsirkin" <mst@redhat.com>
> Subject: [ATTENTION] Mails on qemu mailing list are disapapearing making communication unreliable
> Message-ID: <CAJ7pxeY8dpK53ePE6YcXqHpmxD9B7e9tY49ij6HzgU450OgYLA@mail.gmail.com>
> 
> Hi Michael,
> 
> I hope you are doing well.
> 
> I’ve noticed that some emails are going missing from the qemu-devel mailing
> list. This has now happened multiple times, both with emails I have sent from my
> official address and with emails from other contributors.
> 
> Over the past three months, I have consistently observed emails disappearing
> from the qemu-devel archives, which makes the mailing list communication highly
> unreliable.

I can see patches arriving in my INBOX via qemu-devel from salil.mehta@opnsrc.net
but no patches from salil.mehta@huawei.com

I do see some (non-patch) emails from salil.mehta@huawei.com, but the
mailing list is re-writing this From address for DMARC countermeasures

 Salil Mehta via <qemu-devel@nongnu.org>


Recapping mail delivery policies, DMARC requires a pass for *either*
SPF or DKIM checks.

SPF checks will always fail for mails forwarded via any mailing list.

DKIM checks should still succeed *provided* the mailing list does not
modify the message content, or certain headers. QEMU mailing list
behaves in this respect generally, and applies countermeasures when
appropriate.

I see no  DKIM records huawei.com, but I do see SPF records.

This guarantees DMARC fail for any @huawei.com sender using any mailing
list, however, the @huawei.com DMARC policy is only set to 'quarantine'.

That should not block delivery to list subscribers, merely suggest
that MTAs put the mails in the Spam/Junk folder *if* DMARC fails.

mailam is cautious and thus applying DMARC countermeasures to huawei.com
addresses due to he missing DKIM records, in order to reduce the chance
that the mails end up in Spam/Junk folders for list subscribers.


This does not explain why messages might never appear in the list to
begin with though.

It is notable, however, that messages from salil.mehta@huawei.com
do arrive if they are non-patch mails. Presumably those are via a
normal email client 

I wonder how Salil is sending patches ? Some tool like git send-email
or git-publish ?

If so I then wonder if the tool is NOT correctly configured to use an
official huawei.com outbound SMTP relay ?

While you can have git send-email deliver directly to lists.nongnu.org,
the huawei.com SPF policy will almost certainly result in the mails
getting either rejected or dropped, *UNLESS* they are relayed via one
of the officially designated huawei.com SMTP relays.


> For example, the attached .eml file is a message from Vishnu (Ampere) which
> was sent to the list but later disappeared. This is starting to raise serious
> concerns about the reliability of the mailing list, and the broken communication
> is creating confusion for everyone involved.


In terms of mails from Vishnu, I see nothing in my INBOX from Vishnu.

The mail quoted below has a From address of vishnu@amperemail.onmicrosoft.com,
while people seem to sending to/cc for vishnu@os.amperecomputing.com

Is that From address correct ? It seems like the latter is more likely to be
the canonical address for Ampere accounts.

If not, perhaps that is triggering some rule that discards the mails when
sending is amperemail.onmicrosoft.com



> From: Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>
> Date: Mon, 27 Oct 2025 13:58:59 +0530
> To: Igor Mammedov <imammedo@redhat.com>, salil.mehta@opnsrc.net
> Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
>  salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
>  jonathan.cameron@huawei.com, lpieralisi@kernel.org,
>  peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
>  andrew.jones@linux.dev, david@redhat.com, philmd@linaro.org,
>  eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
>  oliver.upton@linux.dev, pbonzini@redhat.com, gshan@redhat.com,
>  rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
>  gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
>  linux@armlinux.org.uk, darren@os.amperecomputing.com,
>  ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
>  gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
>  miguel.luis@oracle.com, zhukeqian1@huawei.com, wangxiongfeng2@huawei.com,
>  wangyanan55@huawei.com, wangzhou1@hisilicon.com, linuxarm@huawei.com,
>  jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
>  shahuang@redhat.com, zhao1.liu@intel.com
> Subject: Re: [PATCH RFC V6 00/24] Support of Virtual CPU Hotplug-like Feature
>  for ARMv8+ Arch
> Message-ID: <c2462372-f797-47f3-a96e-4872f9cedde5@amperemail.onmicrosoft.com>
> In-Reply-To: <20251006160027.20067fe4@fedora>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


