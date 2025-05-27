Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47534C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJudX-0003xB-4b; Tue, 27 May 2025 09:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uJudQ-0003wY-24
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:46:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uJudI-00043n-Bt
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748353577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cB1KsqFiKdg8YKvaa5Qva53CmyhmkCRHThVF+28lPxg=;
 b=M7N8e6d6Q4wjCDOR1COfDHBgO4IA/kwk66uOoSqZ3e7O8f6hojg6b8G846Mb4p5qeVupti
 APuo6pqaaF1/822E4aWmjBK1/XbQeqa61N3TsHmwoRFXsj83qF1/Q7gBY3ZzY/CanKXBu3
 VntfC4M/AuyXrLRBPnmV1E5v4E9sS7c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-ti2KgA5XOXK0eWwsd6KsBA-1; Tue, 27 May 2025 09:46:15 -0400
X-MC-Unique: ti2KgA5XOXK0eWwsd6KsBA-1
X-Mimecast-MFC-AGG-ID: ti2KgA5XOXK0eWwsd6KsBA_1748353575
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4766afee192so93506151cf.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 06:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748353575; x=1748958375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cB1KsqFiKdg8YKvaa5Qva53CmyhmkCRHThVF+28lPxg=;
 b=o0cMMJOP4MkE5vguoM7BHbtxJzSpKX4wUYY1xDdgzDApNR2Cyitxy4PbLWuRBlyUSI
 9oxZHaK6KlrlQNqFNGl5LgxhxSted7OeaZaBVIV0QKk67ERiXomw9gH3fscHicJQjCTT
 OeU4bwrj26BnpN998AHgVVXKmLMinM1Irtx/7hVg3X76HqM4p83LxLNRDKYtycXLqOYU
 2UwVUwMtIMeDQTg8RPkgjJv8lBubokpobIPTueV7S0HgmPfYPAH1sBZP5SRdMQUad2Fx
 x6ScaYKtuZiNr5mNbRfrQyzs3+XCplLpG3R6Yv/NXONDXLb/+fLcA83yQ7JdQ1V+ceUJ
 tXSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt+8IWtbtS0k/Ws7oKbvUfuiq1g8vSmDnQOGXJ34eUgxXpMALeiqip7SIloGLLozT6q554sfLSG0Qj@nongnu.org
X-Gm-Message-State: AOJu0YwsehIOqy/kaw87DQZ1Drt5YIow9JwZXbXyBZBCVKEvQ4dqPD1k
 0emBCJaSGYOgRIBUd9Y3THwX6I+6tc092zLzj+YlPftyu5hJIxh0q6ef+BdRW85oXeRtQGPT19Q
 5vvo+JnzU5oyDxHHQKdpuxNySOd1uUNPW7dvALoTJWhFBZERdrW1pJ5da
X-Gm-Gg: ASbGncsftFByahM5ZngfwFzn748cMmO8+DDEHLL0mifToUwV0l11NAG7yT/teVnUWRt
 S4g0cAeS+pRAs/EiShOfXu6HR0SNTy5lq8GqPK7om8GSAz602HKZY1D04/CcC/YSN2s9S0Tq87g
 KoPzckItkha0XgKaUtPndahZd5rSVBuWNt39jC+EGT7ZopnZPIz9EEflGnTVF93PaAikk4ppoqI
 OPo6h7m4CFrWooLG9JDkNaltBrf4iMFiA+PrEMm8s8c49LabeZNO7jQI9bBgZzM3xCmuGzNClce
 DWI=
X-Received: by 2002:a05:620a:440a:b0:7cc:8a96:8a2d with SMTP id
 af79cd13be357-7ceecc16761mr1952195685a.40.1748353574926; 
 Tue, 27 May 2025 06:46:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA21aG4Rl4azllthmBWJIPrPLCT1Ybli+S+3gSfcf0JLBZzkcIhOlA3hQ+Cw7XvCKHq9ZnjQ==
X-Received: by 2002:a05:620a:440a:b0:7cc:8a96:8a2d with SMTP id
 af79cd13be357-7ceecc16761mr1952191485a.40.1748353574535; 
 Tue, 27 May 2025 06:46:14 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd467d7eddsm1726303885a.34.2025.05.27.06.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 06:46:13 -0700 (PDT)
Date: Tue, 27 May 2025 09:46:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 00/11] Improve futex usage
Message-ID: <aDXCI2Xo3sNM27DG@x1.local>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
 <aDR_J5iYsSlBTDJm@x1.local>
 <ceac6afc-a300-4ca8-a14e-7f60b31b75a0@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ceac6afc-a300-4ca8-a14e-7f60b31b75a0@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 27, 2025 at 11:09:08AM +0900, Akihiko Odaki wrote:
> On 2025/05/26 23:48, Peter Xu wrote:
> > On Mon, May 26, 2025 at 02:29:10PM +0900, Akihiko Odaki wrote:
> > > Akihiko Odaki (11):
> > >        futex: Check value after qemu_futex_wait()
> > >        futex: Support Windows
> > >        qemu-thread: Remove qatomic_read() in qemu_event_set()
> > >        qemu-thread: Replace __linux__ with CONFIG_LINUX
> > >        qemu-thread: Avoid futex abstraction for non-Linux
> > >        qemu-thread: Use futex for QemuEvent on Windows
> > >        qemu-thread: Use futex if available for QemuLockCnt
> > >        migration: Replace QemuSemaphore with QemuEvent
> > >        migration/colo: Replace QemuSemaphore with QemuEvent
> > >        migration/postcopy: Replace QemuSemaphore with QemuEvent
> > 
> > In case it makes things easier.. I queued the three migration patches;
> > AFAIU they look like standalone to go even without prior patches, meanwhile
> > it shouldn't be an issue if they're queued in two pulls.
> > 
> > I am still not sure whether patch 1 is needed at all, but I'll leave that
> > to others to decide.
> 
> The migration patches shouldn't be applied before patches "futex: Check
> value after qemu_futex_wait()" and "qemu-thread: Avoid futex abstraction for
> non-Linux" as they fix QemuEvent. Merging migration patches earlier can
> trigger bugs just like one we faced with hw/display/apple-gfx*

I didn't see anything like it mentioned in either cover letter or the
apple-gfx patch.  Could you provide a pointer?

> 
> Regarding patch 1 ("futex: Check value after qemu_futex_wait()"), I can
> argue that we should have it to comply the generic "upstream-first"
> principle; the upstream (man page) says to make a loop, so the downstream
> (QEMU) should follow that until the upstream says otherwise. But I think
> it's a good idea to spend efforts to understand the reasoning behind the man
> page since it's so important that it affects not only QEMU but also any
> userspace program that uses libpthread (i.e., practically everything).

IMHO it's not how we define upstream/downstream, but maybe it's me who
missed something.

It's fine - as long as someone agrees with you (Paolo? :), it could likely
be that I was wrong and I just didn't realize that.

Thanks for the update anyway, I will drop the migration patches regardless.

-- 
Peter Xu


