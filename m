Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB14CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 16:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSHQc-0007Pg-68; Wed, 27 May 2026 12:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSHQZ-0007PP-Ro
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:48:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSHQX-00081o-Bc
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779900495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Ph3W67RBTJzrTnXPMi/Td+8jgTh9yXrrm9HaK1sEU4=;
 b=Qgdzl1R/unTlmA/xGShSwZ+0+0xKSHlHrFhfduzEe8sqd2e/Lyqhs79Zn2ZN7WZ/bdauBp
 jclG204YUVPn9WZyE6nmIQJfD0Bxgf22XEfahOQaXWLcS61L4yVixItg4sMGmUJj/lQuFf
 B02FBTN9RHBnbTfGSMIwPQzfV4SQUfA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-RnICkODFPICmRoRte8cykQ-1; Wed, 27 May 2026 12:48:09 -0400
X-MC-Unique: RnICkODFPICmRoRte8cykQ-1
X-Mimecast-MFC-AGG-ID: RnICkODFPICmRoRte8cykQ_1779900488
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4904ee02e72so40719945e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779900488; x=1780505288; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8Ph3W67RBTJzrTnXPMi/Td+8jgTh9yXrrm9HaK1sEU4=;
 b=cb6RBq7lWbpwLjqwtIW3ezyXM6S6vRwCpg/BB83SkF+XEhrjzaRK3Y/HNIMF2rPonv
 dIwZd24NHo0adIJx8E4ixXJr9LZZ6/y9Z9msgqoQAjSHbo3uHn4MhceWvTHMJSa+1Wrm
 0xFE9rb0wsaKclweDyQHK35/0rNtohcLwDYfsiT+CYm7NuzjMq9p1XJc2pXskC9MrRc1
 a2r0BvlGxUmUR6KCOWzvQ2yvBKssW7truOdwJo5xw1d44s6HJuxyUcrMjjTRhMflg0m2
 G/k33hIjXNWu3KugyplA601uIlCf/HrMFyENyk6Nfk4SQf7BJVAwHuV+2+MTkzo/OAfz
 1kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779900488; x=1780505288;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Ph3W67RBTJzrTnXPMi/Td+8jgTh9yXrrm9HaK1sEU4=;
 b=AICX1Yl+aEtzgaAwPqusPFylovldvPhSpDWIn3XTpnUrXeMj2GB2osxkOG8PqhUOk+
 +2dXP4yo7wh4lURahwPj0w6JKyVE6Y+D0W1MYYW6DI4iHqX4hWTozBXo724hMEGRRINa
 yRA+lXXPXIe84SNQijapM2lyj4NC30yLzJL9LsS4Ul23f/lJEjJCJnROjt1/78KasNMr
 m/2rp3RGJlXG+D04gnazec4XoEWjfeCyHstQV9gqKd7LO7WIF+inSOgeSWlKl80iVY3I
 hcmknkqBVFmoxHNo/TMK4L+eadV5K0Ua8Yn5APBm/Joit00sMByfgnAx5yos0pj7sieA
 O10Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wS7VwTgZ0At/YLndt65i8FOYMts2nuJZIkJ+luVsxlBz3YcooHNfpUUGY4WJKlKA35IWEapNYBMhp@nongnu.org
X-Gm-Message-State: AOJu0Yzv0Hdeg0oTvlau+uzoTL41jwOTTN11t1A3QbFup+wg9ZtNWePr
 31OuR0mL027nvUVoIZnfsUpBLlgCzO5a56VtMwweazodE5BEu1mYACoUxv1WKMOtwfD9nx3H0df
 aQJMZ6I4eot5/AQqSuDtIc0dBSvuM43lI5iSPDLRc22ONjy7aj0e/qDrX
X-Gm-Gg: Acq92OFFIP7WWdKZqAfwGzZz3vMx8907x4zWLysg5jjjl+7dw/Wjk83pWSBfDo5z2C2
 5aLiMrj2aeGI6OTSALbyNxp2/d/8ChZ9nNcriu/Yt2TfZ/7eiyh7LIRLIFKBbCkYac5qP1uscRu
 Cax487ZiakiDs1CxlsQ3XPph+DLRO6wHON8ydlmIBdX7ShkAEcIw5Q9SYUkRpOpG0wiGm5usiSn
 KBh3q/PJCSUku6hb51jXcTJxORX74brhske2Cdnp72iR6fuyjz6dW1oADc3HkGUsYUTROYxOwrv
 TGLHxUgqAVEtFO3CVszqKuuHX8dFSc2QicqnjJvuiIv7QbBEm3VpIp+kPIbMrR/0Q1iqbI5uE3r
 7UbECpIdtuWnY
X-Received: by 2002:a05:600c:35c8:b0:490:45bb:8dd9 with SMTP id
 5b1f17b1804b1-49045bb8efdmr424009635e9.8.1779900488233; 
 Wed, 27 May 2026 09:48:08 -0700 (PDT)
X-Received: by 2002:a05:600c:35c8:b0:490:45bb:8dd9 with SMTP id
 5b1f17b1804b1-49045bb8efdmr424008865e9.8.1779900487556; 
 Wed, 27 May 2026 09:48:07 -0700 (PDT)
Received: from redhat.com ([31.187.78.155]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904526c926sm728024935e9.1.2026.05.27.09.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:48:06 -0700 (PDT)
Date: Wed, 27 May 2026 12:48:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: on ai generated and code provenance
Message-ID: <20260527124115-mutt-send-email-mst@kernel.org>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <ahXbxzB4C_lr6b0N@redhat.com>
 <20260526140231-mutt-send-email-mst@kernel.org>
 <ahXtqyuIa4XqkMHb@redhat.com>
 <20260526152526-mutt-send-email-mst@kernel.org>
 <CANCZdfonroZmdRRpPdHzTKR_m8qyVdSG14gXB-K3BTuv=Qgw9g@mail.gmail.com>
 <ahauQKLOU1tzDtbb@redhat.com>
 <f8791a2d-257b-4233-aafb-ccd45e695542@redhat.com>
 <CANCZdfrZFwq3Rq8xifJtvz2o8_3_z=4OTxvknv3x9b719bZK4Q@mail.gmail.com>
 <8416cfdf-b9a6-427c-8118-fd2ed7661f2e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8416cfdf-b9a6-427c-8118-fd2ed7661f2e@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 27, 2026 at 06:05:47PM +0200, Paolo Bonzini wrote:
> On 5/27/26 16:14, Warner Losh wrote:
> > Why invent something new here when Assisted-by: is used elsewhere
> > and is likely more familiar to other users.
> 
> Because Assisted-by was invented by AI companies to get free advertisement.

Jonathan Corbet is in the pocket of AI companies? Or Sasha Levin?
https://lore.kernel.org/lkml/20251223122110.2496946-1-sashal@kernel.org/
https://lore.kernel.org/lkml/877bqtlzug.fsf@trenco.lwn.net/

> (It's not just me; see
> https://akselmo.dev/posts/stop-advertising-in-your-commits/ for an example).

Does not impress me as being either super informed or super
professional.



> Also, it does not answer any interesting question.

It does for me - I will learn which models are more likely to produce
bad slop.

> Not using it is also a good way to sieve people who didn't bother to read
> the policy, now that I think about it.

In my experience, AI tools add "Co-developed-by:" tags by default. One
has to read the policy to add Assisted-by.


