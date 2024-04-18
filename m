Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59229C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 16:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxUrZ-0005ws-0N; Thu, 18 Apr 2024 12:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rxUrX-0005wG-JD
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rxUrV-0003z7-T6
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 12:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713458628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oHDPDrocqsRK8z1RWNdzPDSvqCOb/uGRruZi9B8v1IM=;
 b=YnywTbreryJVC65udMLV/7k4mkr9PRpm+AJYWbBS6RfCN4tjVzyfjm1Dru/sqfDeqlBrPO
 gp4VyN3QM8orD1QclXwhnZ5GctSlGmT42L18/nJJ7hhIiO8j2er8FXPzO4lmS6H08RpoK2
 /HjClvM7a0HpljU1qIqQ2kNn5XiYjlc=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-qaI3lmCGMuuHMkbtJRKvFg-1; Thu, 18 Apr 2024 12:43:47 -0400
X-MC-Unique: qaI3lmCGMuuHMkbtJRKvFg-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5acdbfb49daso419572eaf.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 09:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713458626; x=1714063426;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oHDPDrocqsRK8z1RWNdzPDSvqCOb/uGRruZi9B8v1IM=;
 b=NXS8x1w20QnD1xSX3YSqKFi8tEi+e/GyQ834/YioqDAz7jOPS9T/idIemV2ZY+6bWo
 lXdzQzLkBK/MSOL/pbDyElfnwoa3gh1kmJlPWpczU4ez66+pdtPjCGFMVStY8InD/Wcg
 szK8pG1h09F6uOx6F9naObWcUVEukGfagQAVYeLTLRfQSASwg/N4hY/GkiRqJiK6+1JT
 OEpsG1/zFk8MHkTjPaEk4aVA0AKy6aPQ/saP/+veTHbCWqSOFhhZjkRLsW/1XrgyF9SC
 w1RjIvzXSx2QR1gKD1VwS6++o8stwy/blF2olZ//8Res6UWz6y5dTA6pHMXEc+XZnqhH
 OtdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5pWgmuKz2jlX0h/s4z7xGm/uDbi0aNsVspJgWhHq+LpPYpSMfRxA8ddYt/mzQOnsLFxXdemLpCgWsbSLXCYmpleiFlxA=
X-Gm-Message-State: AOJu0Yyhwx8X9/u/aNQ1LoR1Fz1fyU2YFgYJ2SQ9F+mf/Ehg65NnY1dO
 3/WoEKuuHzziahi8IE+X5pXcTYtaVyJ6RinNVSFDfmuclFNHhw67GWAQpPkA0CR61LEHUe/EEGO
 VWxAdlooynukojbQxZW/wNLu+3O6DE+UvMc6nRVbyjxbFu2qYihUh
X-Received: by 2002:a05:6358:338c:b0:186:6b7e:d2dd with SMTP id
 i12-20020a056358338c00b001866b7ed2ddmr3958536rwd.1.1713458626092; 
 Thu, 18 Apr 2024 09:43:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSKVx+ylTTL3YgU3WHKVll/PL+DSUMtluty1mXSJyNHxBZFAlPvNmDj17b7/IIMcx7TKyW1A==
X-Received: by 2002:a05:6358:338c:b0:186:6b7e:d2dd with SMTP id
 i12-20020a056358338c00b001866b7ed2ddmr3958508rwd.1.1713458625494; 
 Thu, 18 Apr 2024 09:43:45 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 g23-20020ac84dd7000000b00436e0eb2346sm804146qtw.55.2024.04.18.09.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 09:43:45 -0700 (PDT)
Date: Thu, 18 Apr 2024 12:43:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 farosas@suse.de, yc-core@yandex-team.ru, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 pkrempa@redhat.com
Subject: Re: [PATCH] migration: do not exit on incoming failure
Message-ID: <ZiFNvgf0sDwC1Zkv@x1n>
References: <20240417221329.248803-1-vsementsov@yandex-team.ru>
 <ZiEwF0rWlLaKMzqw@redhat.com>
 <0a1d8984-bc01-41bf-9099-0ef426e848ca@yandex-team.ru>
 <ZiE_n7qwvRCz3vjE@redhat.com>
 <985d47bb-3c14-4576-95fa-28649710686b@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <985d47bb-3c14-4576-95fa-28649710686b@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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

On Thu, Apr 18, 2024 at 06:47:31PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 18.04.24 18:43, Daniel P. Berrangé wrote:
> > On Thu, Apr 18, 2024 at 06:40:38PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 18.04.24 17:37, Daniel P. Berrangé wrote:
> > > > On Thu, Apr 18, 2024 at 01:13:29AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > We do set MIGRATION_FAILED state, but don't give a chance to
> > > > > orchestrator to query migration state and get the error.
> > > > > 
> > > > > Let's report an error through QAPI like we do on outgoing migration.
> > > > > 
> > > > > migration-test is updated correspondingly.
> > > > > 
> > > > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> > > > > ---
> > > > > 
> > > > > Doubt: is exiting on failure a contract? Will this commit break
> > > > > something in Libvirt? Finally, could we just change the logic, or I need
> > > > > and additional migration-parameter for new behavior?
> > > > 
> > > > There's a decent risk that this could break apps, whether
> > > > libvirt or something else, especially if the app is just
> > > > launching QEMU with '-incoming URI', rather than using
> > > > '-incoming defer' and then explicitly using QMP to start the
> > > > incoming migration.
> > > > 
> > > > I'd say that with '-incoming defer' we should *not* exit on
> > > > migration error, because that arg implies the app explicitly
> > > > wants to be using QMP to control migration.
> > > > 
> > > > With the legacy '-incoming URI' it is probably best to keep
> > > > exit on error, as that's comparatively more likely to be used
> > > > in adhoc scenarios where the app/user is ignoring QMP on the
> > > > dst side.
> > > > 
> > > > None the less, I think we need to check how libvirt behaves
> > > > with this patch to be sure of no surprises.
> > > > 
> > > 
> > > Sounds reasonable, thanks! I'll rework it to behave the new
> > > way only with "-incoming defer", and check how libvirt behave with it.
> > 
> > If there are problems and/or we want to be super safe wrt
> > backcompat, we could add a new  '-incoming managed' as
> > being equivalent to '-incoming defer' but without the
> > implicit exit.
> > 
> 
> Probably, that's the best variant. As I can check libvirt in some case, but not at all cases. And libvirt is not the only vm manager finally.
> And we can in the same time deprecate "-incoming defer" in favor of new behavior.

Or just make it a new migration parameter?  Then we keep all existing
interfaces untouched, no risk of breaking anyone, and then it'll also apply
to anyone who uses things like -incoming tcp but still wants to keep the
qemu instance alive?

Thanks,

-- 
Peter Xu


