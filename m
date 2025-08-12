Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608CCCA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 13:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulp9I-0006zK-Ga; Tue, 12 Aug 2025 09:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ulp9G-0006yv-5r
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ulp9A-00026K-Bv
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 09:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755005673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=woQEfNyuSW23CY6khUq7amK3Pty9M/RWYtqG5o2DGzY=;
 b=F5A9bduXQCAiM7hTalfac+RLygEf7LbF5GxK17mHueUf8d1uyqxuflJpmDgA3wObFa74AV
 toKhuSkDBUzu0L3yiXBxAyu0nvbLecebjBkzbGDa49kYaOvSEjumWZsphyqv13G/QeKKtE
 jcgiGADVYvKYFwka889eaAxyBhcMAPM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-9yrf1jC6OI2J_sWzecmByg-1; Tue, 12 Aug 2025 09:34:32 -0400
X-MC-Unique: 9yrf1jC6OI2J_sWzecmByg-1
X-Mimecast-MFC-AGG-ID: 9yrf1jC6OI2J_sWzecmByg_1755005672
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4aedcff08fdso104235671cf.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 06:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755005672; x=1755610472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=woQEfNyuSW23CY6khUq7amK3Pty9M/RWYtqG5o2DGzY=;
 b=BBRQNxrI6Jk3cfRCOteDCR+s1hIobR8WGJ54yG8lWVMvG1tPS6/Ef770UQ6DNcAXoW
 qzdurlN1NDXadMVG9vSN5WnXIJRsZpxeB1EkHaZ1nJ/oCWoLHL8E4Mx7Fx6S3ngCZJgr
 u9zksD8rcM0KJE5s3rCj0L03ifTIUzb6pLbL50TDzq+fijao/H1EpKrcNYH/jbquuWex
 zgTmZ/m3QmnhtAleDKl0/Ex7hopmq5mgFYEinH2HZVYNPcfrF54DQCbzDeJpG3oqBdO5
 Sw9562a3XBrJki2fCgbYatR/IwNW6MJ0C3CNHnuqmIhl6xPOZInmYAKNABg7vuQims7M
 SdVQ==
X-Gm-Message-State: AOJu0YwrV+Ga492qjvnxOgs8oyuZAzLrBXYsSzWSMZGWClEtQt1vfBYx
 02Kaau4w/8v9lZ4J9lEe+qetCtIglV4ih1fDww63sNbmvGeCOG2PL76tda8alUD0IuZuiyY+BpN
 47WjQzDR+czpUepAYGM6O/YW7acBZqRZi/4NhSb7cDxeYQceW0u5wabKWF/z7uMHBNvg=
X-Gm-Gg: ASbGnctL5fEX9s3N5fIBTk5RHeBy4OpEHjiOPD+TwcFo4rNWz9TzsX2TN8FqUnUH2N0
 LUabBfr4DFs6XurTRE5BzOWmjkF+q2B2Sbo+qhUCOLS1y16dnfiNPGaL59kXqcJCjwUhd9Q9/aG
 C+q3Gi6ehnBOmcwgHFrpod16I4FGhGJzS45S74lcOCtHXvsKg7z9Lmlk7SxENJxsOxBNtclV6Ti
 McH0x9zi1IuZxHmmeDrdPBqGMYsps9E9DwgN0NWHMD6WmA20H09HmrfAHB3da7/wAxpHylXLwHw
 oZNlinqYulKsIOZql1EQtEZ0BgsK
X-Received: by 2002:a05:622a:1353:b0:4af:322:346a with SMTP id
 d75a77b69052e-4b0ecc5bdcdmr45323891cf.37.1755005671575; 
 Tue, 12 Aug 2025 06:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNNw6GXDVzy59dFQqjAXlqf303UxTP0IZYBV/LgrWebm73ojnHjfgRI5OkVx82V05rQ4CjMg==
X-Received: by 2002:a05:622a:1353:b0:4af:322:346a with SMTP id
 d75a77b69052e-4b0ecc5bdcdmr45323321cf.37.1755005670985; 
 Tue, 12 Aug 2025 06:34:30 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b06a395932sm120672371cf.38.2025.08.12.06.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 06:34:30 -0700 (PDT)
Date: Tue, 12 Aug 2025 15:34:26 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH 0/4] migration: Introduce postcopy-setup capability
 and state
Message-ID: <xfzgjwld4ba7mymu3xhkxdwpeie7bbjnbei2xchkqncamktk3g@rbafrorlpvcv>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <aJoEJhJw-_rGVBbA@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJoEJhJw-_rGVBbA@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Peter

On 2025-08-11 10:54, Peter Xu wrote:
> [Sorry to respond late on the real meat of this series..]
> 
> On Thu, Aug 07, 2025 at 01:49:08PM +0200, Juraj Marcin wrote:
> > When postcopy migration starts, the source side sends all
> > non-postcopiable device data in one package command and immediately
> > transitions to a "postcopy-active" state. However, if the destination
> > side fails to load the device data or crashes during it, the source side
> > stays paused indefinitely with no way of recovery.
> > 
> > This series introduces a new "postcopy-setup" state during which the
> > destination side is guaranteed to not been started yet and, the source
> > side can recover and resume and the destination side gracefully exit.
> > 
> > Key element of this feature is isolating the postcopy-run command from
> > non-postcopiable data and sending it only after the destination side
> > acknowledges, that it has loaded all devices and is ready to be started.
> > This is necessary, as once the postcopy-run command is sent, the source
> > side cannot be sure if the destination is running or not and if it can
> > safely resume in case of a failure.
> > 
> > Reusing existing ping/pong messages was also considered, PING 3 is right
> > before the postcopy-run command, but there are two reasons why the PING
> > 3 message might not be delivered to the source side:
> > 
> > 1. destination machine failed, it is not running, and the source side
> >    can resume,
> > 2. there is a network failure, so PING 3 delivery fails, but until until
> >    TCP or other transport times out, the destination could process the
> >    postcopy-run command and start, in which case the source side cannot
> >    resume.
> > 
> > Furthermore, this series contains two more patches required for the
> > implementation of this feature, that make the listen thread joinable for
> > graceful cleanup and detach it explicitly otherwise, and one patch
> > fixing state transitions inside postcopy_start().
> > 
> > Such (or similar) feature could be potentially useful also for normal
> > (only precopy) migration with return-path, to prevent issues when
> > network failure happens just as the destination side shuts the
> > return-path. When I tested such scenario (by filtering out the SHUT
> > command), the destination started and reported successful migration,
> > while the source side reported failed migration and tried to resume, but
> > exited as it failed to gain disk image file lock.
> > 
> > Another suggestion from Peter, that I would like to discuss, is that
> > instead of introducing a new state, we could move the boundary between
> > "device" and "postcopy-active" states to when the postcopy-run command
> > is actually sent (in this series boundary of "postcopy-setup" and
> > "postcopy-active"), however, I am not sure if such change would not have
> > any unwanted implications.
> 
> Yeah, after reading patch 4, I still want to check with you on whether this
> is possible, on a simpler version of such soluion.
> 
> As we discussed offlist, looks like there's no perfect solution for
> synchronizing between src <-> dst on this matter.  No matter what is the
> last message to be sent, either precopy has RP_SHUT, or relying on 3rd/4th
> PONG, or RUN_ACK, it might get lost in a network failure.
> 
> IIUC it means we need to face the situation of split brain. The link can
> simply be broken at any time.  The ultimate result is still better when two
> VMs will be halted when split brain, but then IMHO we'll need to justify
> whether that complexity would be worthwhile for changing "both sides
> active" -> "both sides halted" when it happened.

Yes, a network failure can indeed happen at any time, but that's the
decision we need to make if we can allow the possibility of two machines
running at the same time. And depending on that, one solution is more
complex than the other.

Right now if the network fails during the device load and the
destination reaches 3rd ping and postcopy-run, the machine would start,
but the source wouldn't. So to me, it looks a bit like a regression, if
we introduce a possibility of two machines trying to start.

> 
> If we go back to the original request of why we decided to work on this: it
> was more or less a feature parity request on postcopy against precopy, so
> that when device states loading failed during switchover, postcopy can also
> properly get cancelled rather than hanging.  Precopy can do that, we wished
> postcopy can do at least the same.
> 
> Could we still explore the simpler idea and understand better on the gap
> between the two?  E.g. relying on the 3rd/4th PONG returned from the dest
> QEMU to be the ACK message.
> 
> Something like:
> 
>   - Start postcopy...
> 
>   - Send the postcopy wholesale package (which includes e.g. whole device
>     states dump, PING-3, RUN), as before.
> 
>   - Instead of going directly POSTCOPY_ACTIVE, we stay in DEVICE, but we
>     start to allow iterations to resolve page faults while keep moving
>     pages.
> 
>   - If...
> 
>     - we received the 3rd PONG, we _assume_ the device states are loaded
>       successfully and the RUN must be processed, src QEMU moves to
>       POSTCOPY_ACTIVE.
> 
>     - we noticed network failure before 3rd PONG, we _assume_ destination
>       failed to load or crashed, src QEMU fails the migration (DEVICE ->
>       FAILED) and try to restart VM on src.
> 
> This might be a much smaller change, and it might not need any change from
> dest qemu or stream protocol.

I can test this idea, but I think it should be working and there should
be no problems if there are no network issues. However, then there's
also a question if we want the destination side to exit gracefully if
there is some issue during device load that doesn't cause immediate
crash. IUUC it would switch to POSTCOPY_PAUSED and then the management
application would need to kill it and restart the migration.

> 
> It means, if it works (even if imperfect) it'll start to work for old VMs
> too as long as they got migrated to the new QEMU, and we get this postcopy
> parity feature asap instead of requesting user to cold-restart the VM with
> a newer machine type.

But are migration capabilities limited to machine types?

My understanding is that once VM is migrated to the new QEMU it can
start using the capability even if it uses older machine type. Then we
would be in the same situation, that the feature is usable once we are
migrating from a newer QEMU instance.

> 
> Would this be a better possible trade-off?

So, while yes, such solution would require fewer changes, but to me, it
feels like introducing a known regression if the network would fail
before the destination reaches 3rd ping message while processing the
packaged command. But in case the probability of such failure is so
slim, that it's not worth to have the more complex solution, I can move
on with the simpler one.

Thanks,

Juraj Marcin

> 
> Thanks,
> 
> -- 
> Peter Xu
> 


