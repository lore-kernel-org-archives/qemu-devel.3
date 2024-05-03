Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC97C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 19:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2yJw-000071-HP; Fri, 03 May 2024 15:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2yJu-00006X-Np
 for qemu-devel@nongnu.org; Fri, 03 May 2024 15:11:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2yJs-0001kv-Gm
 for qemu-devel@nongnu.org; Fri, 03 May 2024 15:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714763502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Tm17DOENmw8WLWxWV+W46SMPQ0KANiBQCtbc9vekSA=;
 b=T4tWKbrozxygecwqih3AJyY9VXOdx4Rc6c+C5mYCQrZXboUyHzx4K/pv7zuPkNIVRNZOMC
 +o5wwr8/Fc/6t82H8E0nYA5KKmdL6AYAlrnoSyEs3F9aNY9KECgVNd9ljB04s2wnwA8YS5
 X6TJNs2On1tDzQFt95tZaoRuT5hGSmw=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-Dha-AjcDOnqz5_XiZ6Wa4A-1; Fri, 03 May 2024 15:11:41 -0400
X-MC-Unique: Dha-AjcDOnqz5_XiZ6Wa4A-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-4dcebab04ffso6082e0c.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 12:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714763501; x=1715368301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Tm17DOENmw8WLWxWV+W46SMPQ0KANiBQCtbc9vekSA=;
 b=FgqVanOrPDi2X9WnKnUSI1EtsFiMrWgoNww3Y5ajSic8aCx5iqwWJ1409weCz0YlFF
 LkWyhe2I9CHh4fPlY0eDRUFeLpRJmXTRng2NPr0OWKjh1lOLmrwrnuaV61Uf/3aLuS9n
 Sxm4fSw7frk39iRRrgfhG8+W+mdsEUN9pYb0daX7KzrzeUYyTMhWRyZPp/mnN2qJlz3l
 4K6vHCjDBhC8P0iF61qOtsQxZZqFTC5+epmKdYoS1Wh2hQUEL4C5RzfRldP4Rv+tAL9T
 wrD5Dw3diFBAQgHhuKKZuzN+IDMKbnkj0atHnOWybBa05KNUGbjBLMLaynBRpHdurq4W
 AeOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP6S9sev/m9b6ap9VYQUUx+IoC5B0DOBMB9pEh24qIf3CO+N6CC2LToKlDGE0VPcQ6qz+Y1H09P1IfU/X8u7qIPcNo7oE=
X-Gm-Message-State: AOJu0YxC9yZXNoP5UQx3RFpJs0MO1VVvQme3Sy1H8fouwSabjCSJoTDf
 YfvGXcaJ7YG9nhoeh5igLiRJ5uXF2GZ1hekPFPpGD/zfQqxJhoxTpAShrvel/c6eZAu2iXvffUd
 wHa3AeVxKLr9jhieCE/zmsT9J0G3lIQh7jHlqsMXC2Xr/Eu9x1QmP
X-Received: by 2002:a05:6122:1993:b0:4df:1c43:8288 with SMTP id
 bv19-20020a056122199300b004df1c438288mr3895222vkb.0.1714763500452; 
 Fri, 03 May 2024 12:11:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgFI6Su9P7Jw5JuS69U2gWdmJpRUaiO4QWR9gdoccJglXCmDcs5GZUCd6sI9dubvrS5CfJuQ==
X-Received: by 2002:a05:6122:1993:b0:4df:1c43:8288 with SMTP id
 bv19-20020a056122199300b004df1c438288mr3895143vkb.0.1714763499156; 
 Fri, 03 May 2024 12:11:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 fy5-20020a05622a5a0500b00437a6e5b3fdsm1845933qtb.66.2024.05.03.12.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 12:11:38 -0700 (PDT)
Date: Fri, 3 May 2024 15:11:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>,
 QEMU Devel Mailing List <qemu-devel@nongnu.org>
Cc: Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Het Gala <het.gala@nutanix.com>
Subject: Re: More doc updates needed for new migrate argument @channels
Message-ID: <ZjU26faJBrt9Gb-G@x1n>
References: <87ttjf1jk8.fsf@pond.sub.org> <87fruznjqf.fsf@suse.de>
 <31a8bb06-5270-4fbb-b8f1-39cd06687c34@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31a8bb06-5270-4fbb-b8f1-39cd06687c34@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
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

On Fri, May 03, 2024 at 09:13:27AM -0400, Steven Sistare wrote:
> On 5/3/2024 8:49 AM, Fabiano Rosas wrote:
> > Markus Armbruster <armbru@redhat.com> writes:
> > 
> > > Commit 074dbce5fcce (migration: New migrate and migrate-incoming
> > > argument 'channels') and its fixup commit 57fd4b4e1075 made command
> > > migrate argument @uri optional and mutually exclusive with @channels.
> > > 
> > > But documentation still talks about "the migration URI" in several
> > > places.
> > > 
> > > * MigrationCapability @mapped-ram:
> > > 
> > >      # @mapped-ram: Migrate using fixed offsets in the migration file for
> > >      #     each RAM page.  Requires a migration URI that supports seeking,
> > >      #     such as a file.  (since 9.0)
> > > 
> > >    I guess it requires the migration destination (@uri or @channels) to
> > >    support seeking.
> > 
> > This is ambiguous. The migration destination is usually the VM at the
> > end of the migration, not the medium to where the migration stream is
> > written to.
> > 
> > One option is to just add the mention to channel all around: "Requires a
> > migration URI or channel that supports seeking".
> > 
> > > 
> > > * MigMode @cpr-reboot:
> > > 
> > >      # @cpr-reboot: The migrate command stops the VM and saves state to the
> > >      #     URI.  After quitting QEMU, the user resumes by running QEMU
> > >      #     -incoming.
> > >      #
> > >      #     This mode allows the user to quit QEMU, optionally update and
> > >      #     reboot the OS, and restart QEMU.  If the user reboots, the URI
> > >      #     must persist across the reboot, such as by using a file.
> > > 
> > >    I guess this saves to the migration destination (@uri or @channels).
> > > 
> > > * Migration Parameter @tls-hostname and its two buddies
> > > 
> > >      # @tls-hostname: migration target's hostname for validating the
> > >      #     server's x509 certificate identity.  If empty, QEMU will use the
> > >      #     hostname from the migration URI, if any.  A non-empty value is
> > >      #     required when using x509 based TLS credentials and the migration
> > >      #     URI does not include a hostname, such as fd: or exec: based
> > >      #     migration.  (Since 2.7)
> > >      #
> > >      #     Note: empty value works only since 2.9.
> > > 
> > >    What's the default when we're using @channels instead of @uri?
> > 
> > The same, both URI and channels get put in the same structure before
> > taking the hostname.
> > 
> > > 
> > > * migrate-recover
> > > 
> > >      ##
> > >      # @migrate-recover:
> > >      #
> > >      # Provide a recovery migration stream URI.
> > >      #
> > >      # @uri: the URI to be used for the recovery of migration stream.
> > > 
> > >    Should this command be extended to accept @channels?
> > 
> > Yes.
> > 
> > > 
> > > * docs/devel/migration/CPR.rst
> > > 
> > >    Didn't look closely.  Let's discuss the others first, then come back
> > >    to this one.
> > > 
> > > * HMP migrate
> > > 
> > >    Fine, because this still only supports URI syntax.
> > > 
> > > * CLI option "-incoming defer"
> > > 
> > >          "-incoming defer\n" \
> > >          "                wait for the URI to be specified via migrate_incoming\n",
> > > 
> > >    and
> > > 
> > >      ``-incoming defer``
> > >          Wait for the URI to be specified via migrate\_incoming. The monitor
> > >          can be used to change settings (such as migration parameters) prior
> > >          to issuing the migrate\_incoming to allow the migration to begin.
> > > 
> > >    I figure we should call it "the migration source" instead of "the URI"
> > >    here.
> > 
> > I think it's worse. We need a proper way to refer exclusively to "the
> > thing that the user passes as an argument to the migrate command".
> 
> Agreed.  My thoughts:
> 
> "migration URI" -> "migration URI/channel"
> or
> "migration URI" -> "migration stream"

"stream" might imply more on the protocol itself to me, e.g. how the
migration headers are defined, rather than the entity / fabric we use to
send the data stream?

Maybe we can simply do s/URI/channel/? As "channel" can also imply the URI
in this case as yet another (old) format to specify the migration channels.
It's like we always use QIOChannels underneath whatever way we specify the
channels (either URI or the new "channels" API).

I also copied qemu-devel starting from now.

Thanks,

-- 
Peter Xu


