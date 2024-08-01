Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D4AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZT0G-0002qy-F9; Thu, 01 Aug 2024 06:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sZT0E-0002kr-N7
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sZT0B-0007xy-Qp
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722507943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4GEfj283YW3vI+Cv4waBmHqqVswXd/eX6JpuwFWvIeU=;
 b=B1K1t1QFgUbNcGElhRastQSWec+5/9xQ+w260i/ZQM/jx9CANJz+y09ovpRHdgwvFEaV6T
 X2VvKm9z7fTxfn8FaghkbNvSM52PjLNh070i7d3nXLnHKQNCopdM2Bgh35YUoQWEh0e/z5
 Y2gPpMCZcF3Pw0YhOS16KL5suD5Cnl8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-ZAXQmnFOOUqgI-0NFh2cjw-1; Thu, 01 Aug 2024 06:25:41 -0400
X-MC-Unique: ZAXQmnFOOUqgI-0NFh2cjw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4280f233115so43451585e9.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722507940; x=1723112740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4GEfj283YW3vI+Cv4waBmHqqVswXd/eX6JpuwFWvIeU=;
 b=dk6jNj0Z7cdUbMAOrKUvwC70ihvdpkQsn6hqZ0xlOylhNgWaooshWg3iAcbOReToNa
 RuK5OCk+Y/DqPGrToncBV4DjO6J7dEzhdq0Z3Vta/etsNPXe1weLUY3J7rXYrlYyxFcU
 YnlEeBm7PTegg8DnN4unTb4efSjn98iCFBxjjnisoJgJKToXW0v7PSL3vCaii24uO3gm
 Ez7xVBF8Huquj699hExGYgOCWRYq0N6WgUA4XMAjbILiRp329No9NnwPQjjeBCnw1sX3
 GOmbv2dj4D5/DvwusNf0kiimrJt9e6ay0mpilBYNWJgw6k75HwDA17Lr1q5IY5c2mLsi
 7XiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSO16W1CRbvzd8DK7jDJ3n0pLAeiBPztKMpRfB/0HKjvja8eA7FX/afDbX2Kq75hJGpnu42UPlefuxVcShqN0A2S8XeU8=
X-Gm-Message-State: AOJu0YyI1xl+Wb28pBfu8CmFlnHviIfzZ+pl80GfWLh2kQFYxudj5DSa
 q9OCjc5W/ZSRiMRiF/mzcDSRCPCljq/MM6EHEk4mATBdJTgL9JixwuXHrfUx097t/bG8T/hLVQr
 bpho031Lg0oBHE4JrUnxgeZuQyKBEsXV4dkeBRBGkOVWZBQaAlMlb
X-Received: by 2002:a05:600c:154d:b0:428:abd:1df1 with SMTP id
 5b1f17b1804b1-428a9bdb800mr16587615e9.9.1722507940321; 
 Thu, 01 Aug 2024 03:25:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6vz9Ly4NKF10mrQpScLeuPxSfm+gLYXwmRxfIaFzEExfY6LzLHp2bQ/5NiYSvn8nGUzAvCQ==
X-Received: by 2002:a05:600c:154d:b0:428:abd:1df1 with SMTP id
 5b1f17b1804b1-428a9bdb800mr16587445e9.9.1722507939854; 
 Thu, 01 Aug 2024 03:25:39 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282baf39f3sm50189875e9.36.2024.08.01.03.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:25:39 -0700 (PDT)
Date: Thu, 1 Aug 2024 12:25:37 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Manish <manish.mishra@nutanix.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, John Levon <john.levon@nutanix.com>,
 qemu-devel@nongnu.org, berrange@redhat.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, bob.ball@nutanix.com, prerna.saxena@nutanix.com
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
Message-ID: <20240801122537.4307ea77@imammedo.users.ipa.redhat.com>
In-Reply-To: <d7de1729-e497-4913-be8e-8938e83b3a2a@nutanix.com>
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com>
 <6e65dbb2-461e-44f4-842c-249c7b333885@intel.com>
 <Zqn6mNuCH4/HJoO/@lent>
 <bda03736-ade0-46a9-977f-1ae368374555@intel.com>
 <d7de1729-e497-4913-be8e-8938e83b3a2a@nutanix.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

On Thu, 1 Aug 2024 15:36:10 +0530
Manish <manish.mishra@nutanix.com> wrote:

> On 31/07/24 9:01 pm, Xiaoyao Li wrote:
> > !-------------------------------------------------------------------|
> > =C2=A0CAUTION: External Email
> >
> > |-------------------------------------------------------------------!
> >
> > On 7/31/2024 4:49 PM, John Levon wrote: =20
> >> On Wed, Jul 31, 2024 at 03:02:15PM +0800, Xiaoyao Li wrote:
> >> =20
> >>>> Windows does not expect 0x1f to be present for any CPU model. But=20
> >>>> if it
> >>>> is exposed to the guest, it expects non-zero values. =20
> >>>
> >>> Please fix Windows! =20
> >>
> >> A ticket has been filed with MSFT, we are aware this is a guest bug.
> >>
> >> But that doesn't really help anybody trying to use Windows right now. =
=20
> >
> > For existing buggy Windows, we can still introduce=20
> > "cpuid-0x1f-enforce" but not make it default on.
> >
> > People want to boot the buggy Windows needs to opt-in it themselves=20
> > via "-cpu xxx,cpuid-0x1f-enforce=3Don". This way, we don't have live=20
> > migration issue and it doesn't affect anything. =20
>=20
>=20
> Yes, that makes sense, I will send a updated patch by tomorrow if no one=
=20
> has any objection with this.

I'd rename it to
   x-have-cpuid-0x1f-leaf
(x-) to reflect that it's not stable/maintained and subject
to be dropped in future=20

Also please clearly spell out that it's a temporary workaround for ...
in commit message.


>=20
> > =20
> >> regards
> >> john =20
>=20
>=20
> Thanks
>=20
> Manish Mishra
>=20


