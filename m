Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F66BD6C290
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 20:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDUes-00036z-Jx; Tue, 19 Nov 2024 15:17:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDUeq-00036e-C7
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 15:17:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDUeo-0000hx-Ac
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 15:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732047425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ycczPael0UOcqGoabQkS1sbbtYLhEj/YYXcXGZmvnk=;
 b=QvedlAU+GLRN1xwch/+At40D7aX2jczYoTZQu6GUw6ySCGxwOnG1/mXJx6hXRK4HyxBrah
 dusmhVw9QFJaMOzAqTFs3G+J9NDo5y38HR95dnyi9iQ5v8JhBf6vJLDVOGdP/jqbP88MPi
 0jY/9hgqkK8SGV+Yf+vWLzgpHmiIx78=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-RQl3R8saN2CSb3DhY86ahg-1; Tue, 19 Nov 2024 15:16:59 -0500
X-MC-Unique: RQl3R8saN2CSb3DhY86ahg-1
X-Mimecast-MFC-AGG-ID: RQl3R8saN2CSb3DhY86ahg
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d407522108so18844406d6.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 12:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732047419; x=1732652219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ycczPael0UOcqGoabQkS1sbbtYLhEj/YYXcXGZmvnk=;
 b=U7qygEQT7XBDe/m+g/mKE2A9GM69HX1uZGA02uxWXIPzAT6B3sw8+i/sflLv5bjf58
 jhwkxef+8MHErQOzIGhthXDuUj1fP3OSO5k9EnbzCrAHuVceKPwzD2UZoPKj8PEvq4nZ
 q270R0677nmw2E9/m9gXXzbnLGqJ1wMyG9OTXprU3J8XqJdGc0z/QdOp1yL9zBFhj8yl
 CuKSKLHQaBfDholpOZoZzq5KxyjnfGZEctMdJhaKZllK0m9jP4d2RxcFqISOABAJkCgx
 pMsCpvzXcjpxdmD+TQ3h4T+qerAbXbNZ8qlQ1jDYFju/AfDsXofLK2v5bUPooFDXmfFV
 P6zA==
X-Gm-Message-State: AOJu0Yxd2pPPdoZrE3sIi1+/Fm2ZOihbE8hqSTC1pPpj6pOADT9idBWo
 BUn0RlqVPnLd3JY+smSojYKLmw6bqzK1V/sktfRbl57DoxE4wp4cxOX9RwUweftA0sQ++TEaiGK
 8itR5oV7oqPf78yKu4gqjtoVPWFpbklhbKGiKoRcC1gMeHzOAoRjF
X-Received: by 2002:a05:6214:daf:b0:6d4:23c5:90f7 with SMTP id
 6a1803df08f44-6d4377af832mr4284966d6.4.1732047419386; 
 Tue, 19 Nov 2024 12:16:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+9txngXvp0Z8pPlwslZ0lcRvF/msjRcqfs45OT4/Tqid1hMizQzFy7AbUdra1jEbQ5voUOw==
X-Received: by 2002:a05:6214:daf:b0:6d4:23c5:90f7 with SMTP id
 6a1803df08f44-6d4377af832mr4284746d6.4.1732047419115; 
 Tue, 19 Nov 2024 12:16:59 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d43812ad15sm63046d6.84.2024.11.19.12.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 12:16:58 -0800 (PST)
Date: Tue, 19 Nov 2024 15:16:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V3 11/16] migration: cpr-transfer mode
Message-ID: <ZzzyOJT_mDh37_Py@x1n>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-12-git-send-email-steven.sistare@oracle.com>
 <ZzUg9w0Kvfuleuxk@x1n>
 <51967cb2-05ec-485b-a639-8ff58d565604@oracle.com>
 <ZzZJvTldpe3D4EO5@x1n>
 <c53feba3-d448-4494-8dbf-0725a2dd8dba@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c53feba3-d448-4494-8dbf-0725a2dd8dba@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 19, 2024 at 02:50:40PM -0500, Steven Sistare wrote:
> On 11/14/2024 2:04 PM, Peter Xu wrote:
> > On Thu, Nov 14, 2024 at 01:36:00PM -0500, Steven Sistare wrote:
> > > On 11/13/2024 4:58 PM, Peter Xu wrote:
> > > > On Fri, Nov 01, 2024 at 06:47:50AM -0700, Steve Sistare wrote:
> > > > > Add the cpr-transfer migration mode.  Usage:
> > > > >     qemu-system-$arch -machine anon-alloc=memfd ...
> > > > > 
> > > > >     start new QEMU with "-incoming <uri-1> -cpr-uri <uri-2>"
> > > > > 
> > > > >     Issue commands to old QEMU:
> > > > >     migrate_set_parameter mode cpr-transfer
> > > > >     migrate_set_parameter cpr-uri <uri-2>
> > > > >     migrate -d <uri-1>
> > > > 
> > > > QMP command "migrate" already allows taking MigrationChannel lists, cpr can
> > > > be the 2nd supported channel besides "main".
> > > > 
> > > > I apologize on only noticing this until now.. I wished the incoming side
> > > > can do the same already (which also takes 'MigrationChannel') if monitors
> > > > init can be moved earlier, and if precreate worked out.  If not, we should
> > > > still consider doing that on source, because cpr-uri isn't usable on dest
> > > > anyway.. so they need to be treated separately even now.
> > > > 
> > > > Then after we make the monitor code run earlier in the future we could
> > > > introduce that to incoming side too, obsoleting -cpr-uri there.
> > > 
> > > I have already been shot down on precreate and monitors init, so we are
> > > left with specifying a "cpr" channel on the outgoing side, and -cpr-uri
> > > on the incoming side.  That will confuse users, will require more implementation
> > > and specification work than you perhaps realize to explain this to users,
> > 
> > What is the specification work?  Can you elaborate?
> > 
> > > and only gets us halfway to your desired end point of specifying everything
> > > using channels.  I don't like that plan!
> > > 
> > > If we ever get the ability to open the monitor early, then we can implement
> > > a complete and clean solution using channels and declare the other options
> > > obsolete.
> > 
> > The sender side doesn't need to wait for destination side to be ready?
> > Dest side isn't a reason to me on how we should make sender side work if
> > they're totally separate anyway.  Dest requires -cpr-uri because we don't
> > yet have a choice.
> > 
> > Is the only concern about code changes?  I'm expecting this change is far
> > less controversial comparing to many others in this series, even if I
> > confess that may still contain some diff. They should hopefully be
> > straightforward, unlike many of the changes elsewhere in the series.
> > 
> > If you prefer not writting that patch, I am OK, and I can write one patch
> > on top of your series after it lands if that is OK for you. I still want to
> > have this there when release 10.0 if I didn't misunderstood anything, so
> > I'll be able to remove cpr-uri directly in that patch too.
> 
> I made the changes:
>   * implementation
>   * documentation in CPR.rst and QAPI
>   * convert sample code in CPR.rst, commit messages, and cover letter to QMP,
>     because a channel cannot be specified using HMP.

Yeah we can leave HMP as of now; it can easily be added on top with
existing helpers like migrate_uri_parse().

>   * migration tests
> 
> New CPR.rst:
> 
> -------------------
>   ...
>   This mode requires a second migration channel named "cpr" in the
>   channel arguments on the outgoing side.  The channel must be a type,
>   such as unix socket, that supports SCM_RIGHTS.  However, the cpr
>   channel cannot be added to the list of channels for a migrate-incoming
>   command, because it must be read before new QEMU opens a monitor.
>   Instead, the user passes the equivalent URI for the channel as part of
>   the ``cpr-uri`` command-line argument to new QEMU.
>   ...
> 
>   Outgoing:                             Incoming:
> 
>   # qemu-kvm -qmp stdio
>   -object memory-backend-file,id=ram0,size=4G,
>   mem-path=/dev/shm/ram0,share=on -m 4G
>   -machine aux-ram-share=on
>   ...
>                                         # qemu-kvm -monitor stdio
>                                         -incoming tcp:0:44444
>                                         -cpr-uri unix:cpr.sock
>                                         ...
>   {"execute":"qmp_capabilities"}
> 
>   {"execute": "query-status"}
>   {"return": {"status": "running",
>               "running": true}}
> 
>   {"execute":"migrate-set-parameters",
>    "arguments":{"mode":"cpr-transfer"}}
> 
>   {"execute": "migrate", "arguments": { "channels": [
>     {"channel-type": "main",
>      "addr": { "transport": "socket", "type": "inet",
>                "host": "0", "port": "44444" }},
>     {"channel-type": "cpr",
>      "addr": { "transport": "socket", "type": "unix",
>                "path": "cpr.sock" }}]}}
> 
>                                         QEMU 9.2.50 monitor
>                                         (qemu) info status
>                                         VM status: running
> 
>   {"execute": "query-status"}
>   {"return": {"status": "postmigrate",
>               "running": false}}
> -------------------

Thank you, Steve!

-- 
Peter Xu


