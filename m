Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13FDC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 15:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdsY8-0000pL-IV; Fri, 31 Jan 2025 10:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tdsY5-0000mr-Hi
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 10:03:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tdsY3-0000a9-HW
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 10:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738335789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ppHR4eTsr/QfCv1lFAsfcTk5ivYctdtCj806RYcl+Y=;
 b=TMEBuI4qQkkpTQi6F4afYA7GkbNwsV1qcPSyNNhEAmeYpjPzFwUqm1V/JPKfJ+yaeEgf8k
 OGs/MDpznsSH2MkKtpjMQzOMgV4z3nq8HHyz7LV+kqx/6WJYFQB+MbWCf7xgt0d24JN71/
 RE7H0D3GI12+N4j52NvDVcuG9YuPsG0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-7UTW5NhSOYWr2h5n3yvhUQ-1; Fri, 31 Jan 2025 10:03:07 -0500
X-MC-Unique: 7UTW5NhSOYWr2h5n3yvhUQ-1
X-Mimecast-MFC-AGG-ID: 7UTW5NhSOYWr2h5n3yvhUQ
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4678f97242fso53009101cf.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 07:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738335786; x=1738940586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ppHR4eTsr/QfCv1lFAsfcTk5ivYctdtCj806RYcl+Y=;
 b=ajxcQqUmcU6dBeMa14fn+fJWeRwKL4L6FNdWYQvGuMgH+bfF8nr3P2u6Fpie+5RsIY
 oWkO4mUXHomy5TbXpSfTfkMQI73jHdjkvEyNq0GgiyCdLsoiSHZFP715vprmf3r4BDyA
 WJBf6k25Nb6FtXhNClfwNbg6sa23C3A8H4+7QwX+4jV/84C++y96HROXwiX0DBtcZw7W
 ubl+VbVG5RNCTzqo2Crtsuzufv2VGiCiQA1JskHMgVaUQ6PF/ioaCgsye39tmwvQyRH0
 ICx6N7UnK1lOYAiCQckfjpDx0g44TZohSaXio05v/QqqsAuG/VBMo1/rGk6nExwU2pfe
 DrpQ==
X-Gm-Message-State: AOJu0YzhaO08+nHWik5jpNYRh7E+dS02+Qmi4o9hUqSvnQ68t4P79dss
 G9ec/bhcm/TbRIDJqvvnH4BOzLrgvbE8UJY7e67n+7lR0qemj36aAGC0ZQ0Hj8qKZtKOU7kZopL
 CY3XVxuvKFHL/psg+od7oK49KSa26rLhq/fjws+MvK+stS1arB5nSwO8deQuK
X-Gm-Gg: ASbGncuCuFEpTWEiwZN/ztWhq6LI727mirzhi2+82BaMEeleB6H/cVovp3LcGk8rRJd
 dkleL0IkwwufzG2a0YrEouOPfLAdo0OBdCQltysAiFEkG5aPt8l82CX6qeJ+gFkR7bDuoGTtsN8
 c04XagNLZz0uvVoarVx40qhirpSJiKiyVmZFceTIsZfYr82QwuSZBLdxO3IdrQA/pqtdBqqF8Ef
 aHRmmy/zJwBrc8/ZvTJDU6bxK13/n+4fH9ZhbnqHHnD7OuwB74tbdRhY0R2bYAtQkx+HjSiwFwB
 WeNSvqAFcY6+zuuDoUzF3cqbO9KxI+v3sWFQFVuVD+qwnKdJ
X-Received: by 2002:a05:622a:2614:b0:46c:7189:25e9 with SMTP id
 d75a77b69052e-46fd0a1d0f3mr194943521cf.5.1738335786425; 
 Fri, 31 Jan 2025 07:03:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkH0WidO5hVyJYgx5pYId4gkMfSpktzec4jGEpZgy/Um5QeYjabOr18V8PZHyFTeEJbzphKQ==
X-Received: by 2002:a05:622a:2614:b0:46c:7189:25e9 with SMTP id
 d75a77b69052e-46fd0a1d0f3mr194942951cf.5.1738335785901; 
 Fri, 31 Jan 2025 07:03:05 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0e0c12sm18671321cf.37.2025.01.31.07.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jan 2025 07:03:04 -0800 (PST)
Date: Fri, 31 Jan 2025 10:03:03 -0500
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Add keepalive messages from dst to src during
 postcopy
Message-ID: <Z5zmJyocuk3DSpeT@x1.local>
References: <20250130161139.548078-1-jmarcin@redhat.com>
 <Z5vpTx3d3MYQL2pi@x1.local>
 <5epliohdmjfh4gctt55qqm4we6abn4sfuc47ixvuoau2ztdwhx@uqvlx4m4mqlm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5epliohdmjfh4gctt55qqm4we6abn4sfuc47ixvuoau2ztdwhx@uqvlx4m4mqlm>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Jan 31, 2025 at 02:42:41PM +0100, Juraj Marcin wrote:
> On 2025-01-30 16:04, Peter Xu wrote:
> > On Thu, Jan 30, 2025 at 05:11:36PM +0100, Juraj Marcin wrote:
> > > When there are no page requests from the destination side and the
> > > connection breaks, the destination might not be aware of it. This is
> > > the case for example with a TCP connection, which by default remains
> > > open unless it is explicitly closed or the TCP stack fails to
> > > successfully send a packet.
> > > 
> > > Such situation without any traffic from the destination to the source
> > > side can happen for multiple reasons. For example, if all pages accessed
> > > at idle are already migrated, but there are still non-migrated pages
> > > that are accessed very infrequently, or if the destination QEMU is
> > > started with '-S' option and the management application does not run
> > > the 'cont' QMP command right away.
> > > 
> > > Due to this, the destination side might not know about the network
> > > failure and stays in the postcopy-active state instead of switching
> > > to the postcopy-paused state, informing the destination management
> > > application about the issue.
> > > 
> > > This patch resolves this by sending a keepalive message on the return
> > > path to the source if there is no page fault (thus page request message)
> > > in a certain amount of time. This wait time can be configured with new
> > > 'postcopy-rp-keepalive-period' migration parameter, by default it is
> > > 60000 ms. By setting this parameter to 0, sending keepalive messages
> > > can be disabled completely.
> > 
> > Hmm, I see.. Does it mean it would also work if we leverage tcp keepalive
> > events?  I just checked on my system, indeed it can at least be too large a
> > default value:
> > 
> > $ sysctl net.ipv4.tcp_keepalive_time
> > net.ipv4.tcp_keepalive_time = 7200
> > 
> > I wonder if it makes more sense to set it to a smaller value.  What you
> > proposed here (60s) as default sounds more reasonable indeed at least to
> > me.
> > 
> > Is that a concern (e.g. tcp keepalive not enabled, or timeout too large) so
> > that maybe it's better we have our own way to timeout the session?  If so,
> > maybe worthwhile to add some comment on that.
> 
> Accepting or relaying TCP keepalive packets is not required by the RFC
> and is not enabled on sockets used (at least on the destination side,
> which I cheked). Therefore, I opted to implement it at higher layer,
> migration protocol itself. I can mention it the commit message.
> 
> However, even with 60s keepalive period, the time it takes for the TCP
> stack to give up trying to send a packet can be around 15-20 minutes.
> This could be possibly configured at socket level with
> 'TCP_USER_TIMEOUT' socket option.

I see it's defined as:

#define TCP_USER_TIMEOUT	18	/* How long for loss retry before timeout */

It doesn't look like to be the knob for the keep alive?

Since at it, I did check the relevant knobs for keep alive, and looks like
they do exist, and they can also be configured per-socket (and IIUC it
shouldn't be affected by the global configuration).  Then.. instead of this
new migration packet, how about we configure tcp keep alive on migration
sockets?  We may also not need a compat property entry.

IIUC, we need to tune below knobs:

#define TCP_KEEPIDLE		4	/* Start keeplives after this period */
#define TCP_KEEPINTVL		5	/* Interval between keepalives */
#define TCP_KEEPCNT		6	/* Number of keepalives before death */

So maybe we can setup SO_KEEPALIVE to 1 to enable keepalive, then adjust
above three knobs to make sure it HUPs properly when detecting network
down?

[...]

> > > @@ -2399,6 +2407,10 @@ static void *source_return_path_thread(void *opaque)
> > >              trace_source_return_path_thread_switchover_acked();
> > >              break;
> > >  
> > > +        case MIG_RP_MSG_KEEPALIVE:
> > > +            trace_source_return_path_thread_received_keepalive();
> > > +            break;
> > > +
> > >          default:
> > >              break;
> > 
> > So we ignore unknown messages on return path.  I didn't expect it, but
> > looks like it means we can enable this without worrying about compatibility
> > with older QEMU binaries, am I right?
> 
> I also thought this and it seemed to be working when I tested it, but
> actually it isn't the case. Due to 'header_type >= MIG_RP_MSG_MAX'
> condition after reading the header type, the return path on the source
> side fails. So we need to change the default to 0, so it is disabled by
> default.

We figured this out offline.. :)  We'll need a compat property if going
with this approach.

-- 
Peter Xu


