Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957B4C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sModc-00050n-CP; Thu, 27 Jun 2024 08:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sModZ-00050a-Rs
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sModY-0002SR-Az
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719492843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SRB3UFqNJiy8Dj+afll5kFpWjgAYthIs3jmHkF6njLU=;
 b=fhDmAzkMzN0gvSfo9i6R4KnMzf6i0v0086o4cfx1WD7FpbY4cy7fR9c/RV50Z00yxih+mJ
 tMZIEXE3Ejf4BLzg1OFFNT3WhepQMXY/jh0KE5vudSEySh3Dt2z3CelqD94bx09S+K0NPC
 zDizw2+a/fd65C9JUSJKEyAKeLxAyg8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-tXbLATeANv6SHT5u7rXqAQ-1; Thu, 27 Jun 2024 08:54:02 -0400
X-MC-Unique: tXbLATeANv6SHT5u7rXqAQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a729da8fbf1so74008466b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 05:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719492841; x=1720097641;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SRB3UFqNJiy8Dj+afll5kFpWjgAYthIs3jmHkF6njLU=;
 b=RN5aFpEF2ywAivNeMJAC3DW07w4NFSNhSIXztmUjEJenKymzT8BUL8NtfhwpBEOokR
 YL6VqOWx+GqdmIzwNo1P6DAOuVoGT4MMINXP6FgxXsl5HUSHD7ypybfy2kPSDdbaD1LF
 ZxKiUmtPLj8s9Rrgeuz7ZS597/+D+92qLbOYnxXpHGGLUzFHcyjjxmjCZJHYZwLsGTZ9
 w6qBO9qfl6x59tRTzP+6lkqHECYGVtJayIXz3WqYKqN9s6kmIwjZfatKdkbEwFtHoR+/
 8C1VZLSKQjE7eaydIwW5CXeLsHdrUlWt63BDSsnOj36VNFbsbSrXBqKD+UV4HDppb6bK
 c13g==
X-Gm-Message-State: AOJu0Ywo0xDr6RcAv3tzt0ytw6x9H3sSLWbA+K9E2ch6B8RSRfrILXQr
 BeWi5IUkZ8Bq4vEX8qIecRzauZYHioQ2m7/WOlNY9azmK+vOU/tdYoBq58vxCAPcS8YTSenGieT
 KhYp6Ur9mnevMISOuFuT445CDeAVdxchYdytWOlDzdtqSOeCKVedO
X-Received: by 2002:a17:907:c089:b0:a72:6442:d53a with SMTP id
 a640c23a62f3a-a7296f5b91amr201745766b.9.1719492841010; 
 Thu, 27 Jun 2024 05:54:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVolaN9PKICdKE/UjcuL176yQTUfnYPuRZS0bWRAM4H0eHW7nz8HYzlin4Kjr25zjPNY7CeQ==
X-Received: by 2002:a17:907:c089:b0:a72:6442:d53a with SMTP id
 a640c23a62f3a-a7296f5b91amr201742366b.9.1719492840257; 
 Thu, 27 Jun 2024 05:54:00 -0700 (PDT)
Received: from sgarzare-redhat (83.0.40.93.internetdsl.tpnet.pl. [83.0.40.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a729d7b5173sm56977566b.157.2024.06.27.05.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 05:53:59 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:53:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v3 10/15] docs/interop/firmware.json: Add igvm to
 FirmwareDevice
Message-ID: <culz2lmg4fsdugz54vy56f52dgoywt5nfg6aycn7exsb3j3jrv@d75i6hhipkje>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <1bcb6bdfe74f96c7c2553ff25fb79f1def381f74.1718979106.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1bcb6bdfe74f96c7c2553ff25fb79f1def381f74.1718979106.git.roy.hopkins@suse.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 21, 2024 at 03:29:13PM GMT, Roy Hopkins wrote:
>Create an enum entry within FirmwareDevice for 'igvm' to describe that
>an IGVM file can be used to map firmware into memory as an alternative
>to pre-existing firmware devices.
>
>Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
>---
> docs/interop/firmware.json | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
>diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
>index 54a1fc6c10..9a9178606e 100644
>--- a/docs/interop/firmware.json
>+++ b/docs/interop/firmware.json
>@@ -55,10 +55,17 @@
> #
> # @memory: The firmware is to be mapped into memory.
> #
>+# @igvm: The firmware is defined by a file conforming to the IGVM
>+#        specification and mapped into memory according to directives
>+#        defined in the file. This is similar to @memory but may
>+#        include additional processing defined by the IGVM file
>+#        including initial CPU state or population of metadata into
>+#        the guest address space.

Should we add (Since: 9.1) ?

I'm not sure about that, since I don't see it used much in docs/interop/

Thanks,
Stefano

>+#
> # Since: 3.0
> ##
> { 'enum' : 'FirmwareDevice',
>-  'data' : [ 'flash', 'kernel', 'memory' ] }
>+  'data' : [ 'flash', 'kernel', 'memory', 'igvm' ] }
>
> ##
> # @FirmwareTarget:
>-- 
>2.43.0
>


