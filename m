Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B34C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gjf-0002qP-T1; Wed, 08 May 2024 08:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4gjY-0002lu-0j
 for qemu-devel@nongnu.org; Wed, 08 May 2024 08:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4gjV-00017c-9h
 for qemu-devel@nongnu.org; Wed, 08 May 2024 08:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715172555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+UH2SLE6JiWPuwo29iAkiHoegHXd814nyvIRH8CH55c=;
 b=DvhAVuqFSZUcVcuzCDWR4lyCcpGpTq2/JC+abVFimVD120YjV1LL/6KOdLMRgW0I0v6k2R
 Ie1sDZYQGE+hPWz37LeY2lvJaGZuiRkNYW7oAskBPv72zu+3AO551OJZovU24i/SYpA6nq
 GUgy4synfwGEbObkmn+eu+BXyI0zjlk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-3mHTp4Q3Oq-6mZ0tiJHbWQ-1; Wed, 08 May 2024 08:49:14 -0400
X-MC-Unique: 3mHTp4Q3Oq-6mZ0tiJHbWQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2b433dd1f24so1516859a91.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 05:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715172553; x=1715777353;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+UH2SLE6JiWPuwo29iAkiHoegHXd814nyvIRH8CH55c=;
 b=T6LqCWO1f967VXsGovUHPeNkbc+gK7fmUyomWuCBaabFDagVROynVb1NYhpfBf22Wy
 LMskd77Ig4Kw90o4wtZpeYwd0wRO3s33AxLxKz1yr7uo2ekQoMu7Ah78tSw+gQr0CScn
 M7KL82axNtO1gvWcVnYe29Q7zI39RN3tQL6GGoQ3EOySzM3Knj+294FOeUcWxN+vvXmF
 vDE02Qo2DF89rypduqMUBoTdgfvi93kW4BD1PFtL0GEii/xU9rYhUbdS+BhCkGCPy51Y
 U54boL3Ipa0BQUhQ7SSbLV/LDw7gDlLIcSrN2zsOFFF8fx7w/nA3i/ez18+qwX0zqV/9
 YaxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6L39h9mhQW8HXHJk9IjW3rm10+YxQGTpS74otcypIAbXicAcFGkt96bWtDZGV0DluK0C0fibzvxlMV0G2lwdR5ctbVVY=
X-Gm-Message-State: AOJu0YyJd4SVG757GeY0F65RHY7/LY0H91G9P3ZXhfcPOAD/pr6tCq3k
 Ic/5BMowUSASsGJzhoov1LOI111PD+kr6H/KcJ8iFHTZTz+emzMFZa1RE2iLOPlSsO4nQ7jW8wW
 /f4hEYBH6/cqblKnfYGzuQryvBLpuI2ceSXMA5U0HeJVxSz1xhkWc
X-Received: by 2002:a05:6a20:9693:b0:1ad:7bdd:361f with SMTP id
 adf61e73a8af0-1afc8de8c8emr2465762637.5.1715172552928; 
 Wed, 08 May 2024 05:49:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjlA+i5KE/XBcCj7Y2V5zffPU0H5WXBpmmoIfjqwc9e4a5Av/SYkftc/lzZneCihWPtJVkHg==
X-Received: by 2002:a05:6a20:9693:b0:1ad:7bdd:361f with SMTP id
 adf61e73a8af0-1afc8de8c8emr2465735637.5.1715172552252; 
 Wed, 08 May 2024 05:49:12 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b628ea6ae7sm1336189a91.51.2024.05.08.05.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 05:49:11 -0700 (PDT)
Date: Wed, 8 May 2024 08:49:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Claudio Fontana <cfontana@suse.de>,
 Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 2/9] migration: Fix file migration with fdset
Message-ID: <Zjt0xELzTq2qWwc_@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-3-farosas@suse.de> <ZjUPl6XwB3Zt3cKR@x1n>
 <ZjsxiDEZgXycn_tl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjsxiDEZgXycn_tl@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
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

On Wed, May 08, 2024 at 09:02:16AM +0100, Daniel P. Berrangé wrote:
> On Fri, May 03, 2024 at 12:23:51PM -0400, Peter Xu wrote:
> > On Fri, Apr 26, 2024 at 11:20:35AM -0300, Fabiano Rosas wrote:
> > > When the migration using the "file:" URI was implemented, I don't
> > > think any of us noticed that if you pass in a file name with the
> > > format "/dev/fdset/N", this allows a file descriptor to be passed in
> > > to QEMU and that behaves just like the "fd:" URI. So the "file:"
> > > support has been added without regard for the fdset part and we got
> > > some things wrong.
> > > 
> > > The first issue is that we should not truncate the migration file if
> > > we're allowing an fd + offset. We need to leave the file contents
> > > untouched.
> > 
> > I'm wondering whether we can use fallocate() instead on the ranges so that
> > we always don't open() with O_TRUNC.  Before that..  could you remind me
> > why do we need to truncate in the first place?  I definitely missed
> > something else here too.
> 
> You're mixing distinct concepts here. fallocate makes a file region
> non-sparse, while O_TRUNC removes all existing allocation, making it
> sparse if we write at non-contiguous offsets. I don't think we would
> want to call fallocate, since we /want/ a sparse file so that we
> don't needlessly store large regions of all-zeros as RAM maps.

I meant fallocate() with FALLOC_FL_PUNCH_HOLE.  But now I think it'll be
good we avoid both.

Thanks,

-- 
Peter Xu


