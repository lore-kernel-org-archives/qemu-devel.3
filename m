Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832E9C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 14:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl8zw-0006j7-1n; Fri, 15 Mar 2024 10:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl8zu-0006iB-1T
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:57:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl8zr-0005Yi-2K
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 10:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710514641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z3I3ysKjyW5FjGVF6NMjxicsoQkcVIjvj9EUem2iyZ4=;
 b=Tm9IG3+3fOh368aMUdO9Y9MROLEzOSfpYFMgPcKtzTnfPUxhXtImx2tJ3SCCZEvDaDcnqJ
 WY9M1UTqVbcYk6IKYpR1f4RLmimfiH6xPfp0RAZpEXdIZeJavxDW/hj43nqGinQGfaAaZJ
 WhXIYnGlnW+yeTMMQh2pj1Gp+zafg28=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-PEheDFNWMTOPlOp3nqm1TA-1; Fri, 15 Mar 2024 10:57:20 -0400
X-MC-Unique: PEheDFNWMTOPlOp3nqm1TA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-690ab2b0de1so6446896d6.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 07:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710514639; x=1711119439;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z3I3ysKjyW5FjGVF6NMjxicsoQkcVIjvj9EUem2iyZ4=;
 b=ULUfDwsoggQUpcI2SzIzUJpdeWe5DhqD/FipplKyZxXDNcrdKiEW3ETK5mZkqwwZNX
 7ZIN9e0aLXI6dUmlc/ahs6++R8a7vgXS0mbTvQBz+Ynai9Vjsi3iJSNgBd1O6r1xfiI1
 rPtVYZAzXPcMz20B+CZmK9mA4YUxZG4V0AD6fO+B68928VIn8FJbticAy6IRvgjOZlH3
 v8mlK/7xhUPtM8zgtjS3sV1ItFVLLzrPuEZTAf8s17mN3yKayeS7Rla0F4myG2TJp1MM
 3B9U9qVCpI3TvQ1oIvPswZcece3qMXdgP34wkNftnjHsjEuMV18VF8DbTW5cuRKqInUn
 Paww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCA1oxZXY46tarQN3Fc0n2EHOsv3dby2WGSzrV22saTZ5WjEVaRlUY6tRAaU+wRaMAFoHVXmkvJp0XN20+8UvIIG048N8=
X-Gm-Message-State: AOJu0YwcvDTpCt6TRjcl3TuFkvxsALQwlj880KZnAHnmWsPHnZYx4IlT
 ZP7fwPz2nn+kLkQSgtV86H4dJ0CLkRtjFbitl21MfGuYTazZpJv9IZSsibueb0sqpXcJ4sU/GWt
 psofBUYyDpTf3pDxCBi5q/dP557lZgKAK94QyYQNZRCsXtFw3g5yd
X-Received: by 2002:a05:6214:5c01:b0:68f:e779:70f2 with SMTP id
 ly1-20020a0562145c0100b0068fe77970f2mr5405783qvb.3.1710514639558; 
 Fri, 15 Mar 2024 07:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy6reuFh01BuDyxg3MMfyL1eSJ27dWtoyaLmMpLGTSqyNY1gU47mnJdmXqkwKlMSTQRK7Y7g==
X-Received: by 2002:a05:6214:5c01:b0:68f:e779:70f2 with SMTP id
 ly1-20020a0562145c0100b0068fe77970f2mr5405756qvb.3.1710514639023; 
 Fri, 15 Mar 2024 07:57:19 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 gv4-20020a056214262400b0068fb6fb217csm2126370qvb.122.2024.03.15.07.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 07:57:18 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:57:16 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Message-ID: <ZfRhzMypPVOd5Q83@x1n>
References: <8ba5dba7-1849-46ff-b708-a9caac66be27@redhat.com>
 <b2b52017-c4cd-43e9-a67b-2ccbb92ad99e@redhat.com>
 <874jdbmst4.fsf@suse.de> <ZfByYiL3Gl9d9u7h@x1n>
 <87wmq7l2xx.fsf@suse.de>
 <b9cb5c16-59a4-4cdc-9d12-6d7c2306b4ff@redhat.com>
 <ZfQqpK0xCwygYYho@x1n>
 <c946ae1f-3315-496e-b316-33343e43830f@redhat.com>
 <ZfRJHEya_kPaXWbU@x1n>
 <36089ba2-7ee3-412f-9050-739a8ead2fbc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36089ba2-7ee3-412f-9050-739a8ead2fbc@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 15, 2024 at 03:31:28PM +0100, Cédric Le Goater wrote:
> On 3/15/24 14:11, Peter Xu wrote:
> > On Fri, Mar 15, 2024 at 01:20:49PM +0100, Cédric Le Goater wrote:
> > > +static void qemu_savevm_wait_unplug(MigrationState *s, int state)
> > 
> > One more trivial comment: I'd even consider dropping "state" altogether, as
> > this should be the only state this function should be invoked.  So we can
> > perhaps assert it instead of passing it over?
> 
> Yes. If you prefer this implementation I will change.

I am fine with either approach, we can wait for 1-2 days to see whether
others want to say.  Otherwise the other approach actually looks better to
me in that it avoids SETUP->UNPLUG->SETUP jumps.

And then we wait to see whether UNPLUG can be dropped for either way to go,
perhaps starting from adding it into deprecation list if no objections from
the relevant folks.

Thanks,

-- 
Peter Xu


