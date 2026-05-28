Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3937BCD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSaxH-0004Kc-Pv; Thu, 28 May 2026 09:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSax9-0004K3-UG
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:39:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSax7-0007ap-7S
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779975551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/fWkcUcpNNAUjyW+qmOzo1tDZhLeSbJNrXoWW2G7E0=;
 b=eqRvy3Rh1BRuOSgAWoqJXnaMFC6NK9LPTbmj2kkzGVjxBthr7Uu59PfvcUqmuU41+9oXvD
 2fNB8RSFYgBGflrd6ji2KyoOoJNRSpnks+51/VahNjNSsVhkaLDn009igRgsZJSXGPASXV
 3ICKKXAGayTwx03K1CkLHKQBG8ini9U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-AuU2lYIEMoWVFeqVvYZMXQ-1; Thu, 28 May 2026 09:39:10 -0400
X-MC-Unique: AuU2lYIEMoWVFeqVvYZMXQ-1
X-Mimecast-MFC-AGG-ID: AuU2lYIEMoWVFeqVvYZMXQ_1779975548
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-90cbd806004so2638356385a.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779975548; x=1780580348; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s/fWkcUcpNNAUjyW+qmOzo1tDZhLeSbJNrXoWW2G7E0=;
 b=mfeUlIqqm06fRZIICat2P34ypM5fuE7wF1nSIxDa6ki5LasXSao/6XmIvpeLeHut+0
 nHZMthJa+7HOpOamdI8U5hUfFudnWdcAHyr5aW3EiG76l0ndqLVgCTzxJXoSJXse3m1y
 utv+hHC3oD71Gsa6VybYz+5r/tZrUx0Odp1fzWdNHc0WvOUQaXyAfKNr7tu3SU59bJPn
 RFJHAI2OBW4HT5VMqz87XkGKJimqIE9cdb7T42W1isTMS4odED1ZkoOY6K7FS8tIIENg
 fSLmxbtl7vBQrmWJmNE9jEeyb/X17VG2uk3kBx7ltr/EHKSyP1EYkFwaGnc5EuuhMwja
 eUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779975548; x=1780580348;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s/fWkcUcpNNAUjyW+qmOzo1tDZhLeSbJNrXoWW2G7E0=;
 b=OJfQY7oedLWaChoqArHQgQVeDHN0MYx3BzqP9Epv+Hr6+/yhwpEOmeMgJIlGsD7uqf
 8pl1tMzd/oA9UOnizOvc3jbNPTn12B4LcaTzL82KyxmXfbZ5UqPNS2Zc1chS65rzdILe
 KqcTMITaUi0WhJ49hmt64EEFXKco/r/zb7ScKfd7t+lmsUF9Ih8HqJFij4gQvYaUwRCs
 38FhqGdejGdMIzLatE2Sn8DF+gM2tgsFVluNT/LChhNKn1E0HAy2skJTVWHK8IHpelfJ
 Abh43BEHujKNyhFG68pkOkOlAtMzBPv3C1FbhD8s2pCadUQ0vZpdoAE1HxtdDuQsJ1ew
 1fcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+agA9JoNUE+2pclrEb7tBRPFAWCgzBNV0cH/REgLKQqS51vtEYuqUfoOfHxLJUrrm9MtfnijWF+ER@nongnu.org
X-Gm-Message-State: AOJu0Yyira0HWTvbITcZ6noxtAuhpSi+PEluwRqtD8Ybu1KWcKBUIzZK
 V1tZybpMAuwm0I0KNYN6cWUM3qV/hAYBFCgmM0caFaxuc70WeL2GPrTKEtL4YY1Rl6lfrbSLMhO
 7pO4FOQUe51jRlW+fPp7fM7prw/xLMovu3ou+IgwMiWK6c5/yYO9WkEfN
X-Gm-Gg: Acq92OFeJfsuIFBRK5M6kwF2YixvEMu/PuF095YYv/rp57wugEUZbbWo9bUsn7I13gW
 OOOFyE1ne4jU29o9sE1EDqEWtTJmtQau2+JmL2o6FthOSnsbvyvp4E8BElmZnbDlg3ASqup+kyb
 Xih56JR2OIF9+b6yiz58+MSP67NwHb6eJ6HARY4vAzlvi+g89pK2ndvTDiwGawRVaz91yCa4Pqp
 V3PxE43E8fCQoZ6T63d0kA8V/4OHfApCnCGTrx4+iqxARSuzpfAnWWa0T1HHZIpnu69kyTwYmAu
 netXhy2FrHBH7jQtde1dR21ciy8O0+i2b6lxK3+ekt5c3gd2uwtJyXzI8h/9E2eYGc/+SJZlNA/
 6sA9VmchWG09iztRkrHJ5x3+y9MeqARIzFdYAZoi4XeYjAiRF7Y4KwN9i6Q==
X-Received: by 2002:a05:620a:6cc5:b0:914:e429:5b42 with SMTP id
 af79cd13be357-914e4295b91mr2450172785a.51.1779975548479; 
 Thu, 28 May 2026 06:39:08 -0700 (PDT)
X-Received: by 2002:a05:620a:6cc5:b0:914:e429:5b42 with SMTP id
 af79cd13be357-914e4295b91mr2450167285a.51.1779975547923; 
 Thu, 28 May 2026 06:39:07 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86e9bf5sm814983685a.8.2026.05.28.06.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:39:07 -0700 (PDT)
Date: Thu, 28 May 2026 09:39:06 -0400
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 1/7] memory: Export memory_region_set_ops()
Message-ID: <ahhFepYkLT-uXbf7@x1.local>
References: <cover.1779723483.git.balaton@eik.bme.hu>
 <d6fff532607b5153094cd6c72f78a2de5672aaec.1779723483.git.balaton@eik.bme.hu>
 <CAFEAcA9Nh9qZ1k_Pq04ajdP8ObrNpen4aYeu-mPNiYbRc9ho3Q@mail.gmail.com>
 <ec2a907a-9fab-d56a-83a2-409254146209@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec2a907a-9fab-d56a-83a2-409254146209@eik.bme.hu>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 25, 2026 at 10:57:39PM +0200, BALATON Zoltan wrote:
> On Mon, 25 May 2026, Peter Maydell wrote:
> > On Mon, 25 May 2026 at 16:47, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> > > 
> > > Make memory_region_set_ops() function public. In some cases such as
> > > when devices have configurable endianness or different behaviour based
> > > on settings it is necessary to change the ops callback after the
> > > memory region is created. Export memory_region_set_ops() function for
> > > this.
> > 
> > If some other CPU is in the middle of using the old MemoryRegionOps
> > when the device swaps them out under its feet, what happens?
> 
> In my limited test with PPC and ati-vga this seems to work and the switch
> would happen in device register write so nothing else is expected to run
> accessing the device at the same time at that point. I can't tell for all
> possible cases but that would then be a problem in the caller not in this
> function. Callers are expected to call it when appropriate which I could
> mention in the doc comment if needed.
> 
> > You could also remove the old MR from its container and add a different
> > one with the different behaviour when the guest changes the config,
> > or have both of them in the container and toggle which is visible
> > with memory_region_set_enabled(). That might potentially be more
> > awkward but it would avoid having to look into the memory region
> > API internals.
> 
> That could also work if I had a container but it's switching the endianness
> of a PCI BAR which is registered with pci_register_bar() so it's easiest to
> switch the ops on the region than hacking around it using two more otherwise
> unneeded memory regions as I also can't swap PCI BARs so it would need a
> container aditionally to two regions using the same callbacks just with
> different endianness. Allowing setting the ops of a single region seems
> simpler.

I think PeterM's proposal makes more sense.

Having two MRs registered under the same offset of parent and dynamically
enable/disable seems to be a common way to solve similar problems in QEMU.
I don't see why it is hacky if we can allow dynamic flip of mr->ops, which
smells more risky.

Exporting that API may invite more abuse, which I'm not sure it's good.

The other thing I want to mention is having ops flippable relies on "BQL
serializes everything", but it's already not true with exceptions like
HPET, see memory_region_enable_lockless_io().  I think this will introduce
tech debts that we don't necessarily need.

Thanks,

-- 
Peter Xu


