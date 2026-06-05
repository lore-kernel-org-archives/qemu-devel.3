Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A283CD6E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVRiL-0006iO-1Q; Fri, 05 Jun 2026 06:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wVRiJ-0006ha-6y
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wVRiH-0003xr-J7
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780655020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZEKuxq+x7Er8MMZwistXFD2qiyrLMoeR5dGWXqQoi4A=;
 b=Ix+Zo16GFkDG6XV+aEA+sTO2rEsPHVzupJraLiGOdjhK0hzDDCOFLvM3W/1/Tcd6W+NzNX
 lre9gmAbBw+7AYGu2TTCpv6bIeN+venvKEguSXeVbzGjKQWg4A3hM013Srxit8yCeLy2zZ
 hcPTcfBeayWoDu29pWXSc9N9RoHqcaI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-T9COOF2SM_ia2KumgndYuw-1; Fri, 05 Jun 2026 06:23:39 -0400
X-MC-Unique: T9COOF2SM_ia2KumgndYuw-1
X-Mimecast-MFC-AGG-ID: T9COOF2SM_ia2KumgndYuw_1780655018
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45ef55779d1so1109478f8f.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 03:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780655018; x=1781259818; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZEKuxq+x7Er8MMZwistXFD2qiyrLMoeR5dGWXqQoi4A=;
 b=cW0+kME2PqZlmBetOEWlSrJitffx0GrbCxte3/54T/ZMns81+FGePVMKPwuh33fJX9
 +S5xd9dv2JZghjR7JeqH8lOpsmtkWZGqzHLD+RLLSxO1QlOHRcSExkDADvJp+zFEVdIp
 mTYs8qSfXNtwUyFJ6C21AkrLzkN1gKhx255uwXE8fNF3VkpcFgQaQwwduw5opsMi4ObG
 1n2rE+r3yOAnrYmrGYpdTzmAcI3367aOTUpEjNx9zx6l8qmkFwqdzK/GdvCOv9EfeyFD
 6BEdAhcdZQ1vG2VxbyPnX8+uPHue9yzM97M55CTyHc+DZ0Jz/qlgree0Didbx39qH7e7
 z5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780655018; x=1781259818;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZEKuxq+x7Er8MMZwistXFD2qiyrLMoeR5dGWXqQoi4A=;
 b=AR3M1TwHh4e3dWthk4etkX/QTWPQv8AKzPDx3fZXgEmHV2CYiBoFZmU6hxAFa8bqQ2
 q07GQDgSR1PT5yVagKEdQyIn9U/C1mYPki7m205AsmjlIRnZB8envpn8sIxtkZM8DD4u
 nELMpb+hnGM2j63MzGIYovGI9rf9m7ACtimWLtuIGZ/fpUexOWL13Vp1tasQkpP2SsyG
 kBaS6zqsmTNMR4wy6nCeyzwSY2UjXdVMXmrqPs4xpon/nO82u0hn0jnUtNk7HxxCnHJH
 HXRz51A8lNDPpepNw6w7KWlcob4Usf/PYSt6yvkZfgmcS+08nMhbl4UdyN5ih5UhP+Ju
 e1Ww==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ADaRyGaMPOJ3ZQLA55P9h1D/YXH5QJ/k+qCOoSvvDCTsThWFU/5Z7pYKWy3l+uW1UbjePi8v5ysPo@nongnu.org
X-Gm-Message-State: AOJu0YxZvqDzKzLyaPEKNqkm7djDAv+5V6llXDTDJyjgp3QqQnzLyWn6
 B/dpIoragFYgY133Cic3UfaoPry4DSLXhGWMmyzjDMh80HMTA+Y6r3ZWdnS2YfLPD1CecHQ7tW3
 Z1zvDMC5KVDj+c2BhUSzw+GP8Oi3wTPX//pXFdDSAVYlhHwLqpXvZYjHd
X-Gm-Gg: Acq92OEqzvrCYYLPRd2PY3AjcBUn6vMIKpwhHg9SudExZvtClPewvNV5p4k4K2lxqOp
 hsn53gQiuv3cqXqV6YdCSrtZ1yoopVPja7Lu+NiVpEfLFsdBDgfgu/US7G84g5NVBCZDx0eFExb
 5FwQ3AExvHcaUTOxzJEWQf3DxwLGUeXj4LIpLKy1RXJDHMZWhpAdRNsq5I4hTKhgZ4b69XdjySN
 81DVD6THBSXaza/ZhZJmnC69+aedzFvyDVQLGj5zbyEuXr+xUTgAGzQYT94alZZ/4oHJooAaOHc
 /qfFS15dMbeMFwdMkx33J58rr/gC9gEdYX3rlYlOXRHQZU30ug0jPHJQ59F55R4g85rzHDdWu2c
 my7a28vSLQR4FinYslFGDkzibQrCCsyiocpfo0G+YGXlxPnazH8JgF88=
X-Received: by 2002:adf:fd8b:0:b0:43b:498f:dceb with SMTP id
 ffacd0b85a97d-460304f6b48mr3589095f8f.9.1780655017619; 
 Fri, 05 Jun 2026 03:23:37 -0700 (PDT)
X-Received: by 2002:adf:fd8b:0:b0:43b:498f:dceb with SMTP id
 ffacd0b85a97d-460304f6b48mr3589058f8f.9.1780655017092; 
 Fri, 05 Jun 2026 03:23:37 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35eae5sm24556165f8f.33.2026.06.05.03.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 03:23:36 -0700 (PDT)
Date: Fri, 5 Jun 2026 06:23:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260605061949-mutt-send-email-mst@kernel.org>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <aiBBV48wyDF57vUi@redhat.com>
 <CABgObfZNX2rLnB=FosVopFmLB_S_5V48UPLjNTTtn543d9RfHg@mail.gmail.com>
 <aiKhBDfATZ1SkmYm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiKhBDfATZ1SkmYm@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jun 05, 2026 at 12:12:20PM +0200, Kevin Wolf wrote:
> Am 03.06.2026 um 17:35 hat Paolo Bonzini geschrieben:
> > > > +**Small bug fixes**
> > > > +  These should be limited to 20 lines of code or less, not including
> > > > +  tests.  You are still expected to :ref:`understand and explain your changes
> > > > +  <write_a_meaningful_commit_message>` and the rationale behind them.
> > >
> > > I think the "20 lines or less" is not going a good job at expressing
> > > the intent behind this point. I'd like us to emphasize between the
> > > "why" of this point, as that helps contributors & reviewers make a
> > > decision of whether a change is "within the spirit" or the rule of
> > > not.
> > 
> > True but we also need a rule. The spirit is better explained elsewhere
> > (and also, building consensus on spirit vs. a rule are two different
> > things).
> 
> But "20 lines or less" is still not a good rule because it measures
> something that isn't really what we're after. The rule is "trivial
> code", and yes, there is no good way to measure that. But that's not a
> good reason to replace it with a metric as good as defining productivity
> of an engineer by lines of code added.
> 
> Can we turn this just into an example, and also be a bit more specific?
> Like "20 lines of low complexity code"? (Or is it more like "moderate
> complexity" that you have in mind?) But it's definitely possible to
> write 20 lines that aren't trivial at all, so the rule shouldn't allow
> that.
> 
> > > Docs is an area I'm more wary of from the social expectation side rather
> > > than the technical or legal side.  I don't feeel like "pay attention to
> > > the organization and flow" really mitigates to the tendancy to production
> > > of vast reams of convincing sounding slop.
> > 
> > Reviewers have no obligation to review.  The good thing about slop is
> > that saying no takes about the same effort as the author put into the
> > creation of the change.
> 
> Just saying "no, because I don't feel like reviewing this" is actually a
> new thing for most of us, and doesn't feel very comfortable. We may need
> to get used to it, but I don't think it's easy.

If someone repeatedly sends me slop, defined as code/text they did not
read, I will warn them and eventually start ignoring them.
We can mention it's something maintainers can do.

> > > > +There is no requirement to include your prompts or summarize the
> > > > +conversation in the commit message or cover letter, but you may do so
> > > > +if you think it helps a reviewer judge the result.  For example:
> > >
> > > IMHO we should actively discourage the inclusion of prompts
> > > entirely as it is the wrong information to provide.
> > 
> > Why? I think it helps especially in the case where we're asking for
> > maintainers to apply their discretion, and for reproducibility. It may
> > not be always applicable, but it can also help.
> 
> Not sure how much reproducibility there can possibly be with LLMs. :-)
> 
> Kevin


