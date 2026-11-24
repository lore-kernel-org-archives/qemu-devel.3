Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AED606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jBCasxcC;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GrlDsSpz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVyEh-0004VY-E6; Tue, 24 Nov 2026 16:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVyEf-0004Te-EP
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:39:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVyEd-000752-St
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795556370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HoDBm7jolZX4m5j/8U+v4mwfNjkjwekJKWOb97WOSgg=;
 b=jBCasxcCcYpjMX/l9BDLBtUxZQvNqeveR5B2F5+xeuHIg/uiJ3zouXOlXdLLo9q0bED+AR
 EI8k226Hg0qKqPfa1+iUkehI7zWCe7WjDAw5qdGkexPGD4VGYmLF003S8MSXCrtsBliKTR
 22KtoQ3OJuFmZYjnX/dL59/VLxawbHM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-I6YAq9bAOUmIJd_eM39C0A-1; Tue, 24 Nov 2026 21:39:27 +0000
X-MC-Unique: I6YAq9bAOUmIJd_eM39C0A-1
X-Mimecast-MFC-AGG-ID: I6YAq9bAOUmIJd_eM39C0A_1795556367
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-921161ab1a2so72938956d6.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 13:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795556367; x=1796161167; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HoDBm7jolZX4m5j/8U+v4mwfNjkjwekJKWOb97WOSgg=;
 b=GrlDsSpzBUKGBfzbxlMy8tPSqOTHNpy1tlrv+D9mQcHagYc9bNkqEXf2oiLGtZ7kaB
 Kgl9I7fUKtOL9nnN74eISUUTxLZ1sW1vWrLphzvUmygYGhubFTkuwzT8aIgoSs4uoCgB
 sqCzRW4RGaMv2y9rthTJqh/UA16Mx+o4uwGqAghBd3J2zaOXBPwCUTUDnte7ge3LY79d
 69HmmbAMGZmNxxtH5V5Jge3q7CMFBXQqsbHE1VI570zuKhHrbIZf813RugdMsY5U8SbF
 btdozCpMkVQfehC4/J9m/EcojbKT2OBAZv9Y/CNY9SVEIHaHWiZJn7LS2m5vSzHpNQFU
 Mdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795556367; x=1796161167;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HoDBm7jolZX4m5j/8U+v4mwfNjkjwekJKWOb97WOSgg=;
 b=b5hnqWmRGdypZNhOMx8+6Pd1Dl75A4qX0npbSNRELnqXiWBfZSasO21edhvmA3sg9E
 0MXI2LVEqMPQSr39MCYC+CfwD6Q5DyU/qbWWMpNmwoBgGdr+eSPP0nzywbnvAMlnmYc1
 WDZxw700fcLTbni/NdQIYeA+kxS4LzJb26WjuxKdQvl1uX4Lg9AOhtM8KoaN+DRhL8M2
 uw5b/wWU579pV95SmZsxEPDoFQD4+061PjqcNowZPWW09aEGgxNKC/zwrPB6MGsOrzOp
 PfX7BIQjzl3t4P9RmMtMcz+ZOkR2rswKXjoMTdRFNj67NFtVZClEba/gNBFEJJ1tGwz4
 NvJQ==
X-Gm-Message-State: APuU4Z/FmJVO3u/HKyWU7aHSCSO0mE6+zIlTOEomVrICX7tG+pcTBJHR
 pZP6Y9TzHReABmUtGpxqdVTN5kpv2Dq964PVrHHexRpxnlrbUsGZ/Y2iQRNYPE4SV1uUe4TdzT9
 L0cSQ6Fb8a3fWHvrkFpahxvfF28kVIcseXrJ3pFoEKA/BOhL2xQxpbBn5
X-Gm-Gg: AZFdTZeI5lDQG2EAcqr3I7EikwOkWAS4emN355XJTCeOxn4/m4L+jWjmhVLR3ft9vZ+
 8ijnMcRwPgyDQSu+oZG0OLR4SZeMnBbcbsdqbmwqU0n1n0mxYrS7PRwjaWEydWnbLLuEFJBWr8k
 zhHGLr60dkm9CD7oTgsnGPoGrt3d/vmfD0G5e/5TKYo5J93gP/kZaSQTKl9ydHcq0GDdv8VKY9p
 D75b2pHXEGu34l8h8y0v1YrqbXXHXnHcHtT11rrmpLn9xXyBUayFuWTMOZV/BKCdPZ3XRIvH8es
 /GsWL5Hu0mCm7t75IlPfU7gKjEq/Ak+UyEOJNxkiL1fCtOxQpj5RVFskNV6vYGF2VQ4PteNVB/o
 tC7SgQKZCphkljh/3RGUVVUpqiqsjNVE0QCcSsql3iJz7
X-Received: by 2002:a05:6214:27e3:b0:921:1049:269d with SMTP id
 6a1803df08f44-92134b49b0bmr271089016d6.20.1795556366622; 
 Tue, 24 Nov 2026 13:39:26 -0800 (PST)
X-Received: by 2002:a05:6214:27e3:b0:921:1049:269d with SMTP id
 6a1803df08f44-92134b49b0bmr271088526d6.20.1795556366163; 
 Tue, 24 Nov 2026 13:39:26 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921349b253csm147184116d6.15.2026.11.24.13.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 13:39:25 -0800 (PST)
Date: Tue, 24 Nov 2026 16:39:24 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: memory_region_init_ram_ptr() handling of sizes that are less
 than a page
Message-ID: <awYEDAgvEbeVtrAW@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <CAFEAcA_77DxGK-26Z6=qx0a88Zd0KQgFjKgJc2CgTmm-iOzbsg@mail.gmail.com>
 <CAFEAcA-o9DoPL1D0-S3hpB1bT6iSNgy4zm1VZRSjcjxHkmUfiQ@mail.gmail.com>
 <awW88uEaJ2IKp-nY@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA-PB-tPvdXc6ZMMhanN0fPi9uvGQ=XtM0h2+uxt-JnrSg@mail.gmail.com>
 <awXafWB2p8VuG_Qh@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA8-UQPdJ4na2EXfFff+Nw547nYVDfQcK-pjLr6ykW=ThQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8-UQPdJ4na2EXfFff+Nw547nYVDfQcK-pjLr6ykW=ThQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 08:38:02PM +0000, Peter Maydell wrote:
> On Tue, 24 Nov 2026 at 18:42, Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Nov 24, 2026 at 05:37:23PM +0000, Peter Maydell wrote:
> > > The atmega.c code explicitly calls
> > >         vmstate_register_ram(&s->sram_io, dev);
> > > which is why #4877 reports that we crash during migration.
> >
> > Ah...
> >
> > This seems a hack.  I don't see what we benefit from g_malloc0() rather
> > than using memory_region_init_ram(), it's hand-coding how allocation is
> > done.  IMO we should switch.
> 
> That's what it used to do before commit 9f99072fc08 last year,
> though. I should check with RTH why it's doing that so we know
> what we need to test to make sure we avoid breaking something.

Yes.  Just some quick thoughts in case helpful:

- After Gavin's ff77a51511 landed, ram_device should be treated the same as
  RAM at least in term of memory_region_supports_direct_access(), so IIUC
  it's not "IO regions" even now in master branch.. maybe there's something
  special with TCG, though, ignoring that bit.

- memory_region_init_ram() should work with less-than-psize iiuc, only the
  ramblock allocation will be aligned to psize but MR size should be intact
  (smaller than psize).  We waste some bytes but assuming no big deal.

-- 
Peter Xu


