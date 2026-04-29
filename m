Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72112FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 20:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIBCa-0001pK-KT; Wed, 29 Apr 2026 16:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wIBBw-0001ce-8q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 16:07:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wIBBu-00030n-Jn
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 16:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777493245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DQE1HWutJZrccc4xhn8bIEm1VSEiR13vxsMi+6wM40Y=;
 b=e6eHj9dKq2TPebzMnG0TIBproC0UCI7axPX2+Kdr4++b/n9+HQRbOoSquhMbul/3eIxdvh
 3av+kzgeQhTUqJdo9QKtLrxiOa1lC2WPmo5FQGG4DwQwc7pb3s2TpbYZ7xSIzhm5t+RBM5
 xLz6UAPV1Rpeeit6sTBci8fL5XHZbxw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-Qagf-15PMumVpnfBcRpD6Q-1; Wed, 29 Apr 2026 16:07:23 -0400
X-MC-Unique: Qagf-15PMumVpnfBcRpD6Q-1
X-Mimecast-MFC-AGG-ID: Qagf-15PMumVpnfBcRpD6Q_1777493243
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82f9429f49cso259090b3a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 13:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777493243; x=1778098043; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DQE1HWutJZrccc4xhn8bIEm1VSEiR13vxsMi+6wM40Y=;
 b=njHDF2AhXsMimu8Sgw9uEXtyexn0wicBnma9czZtsy7ehBw3OJ36/3nj8ukxEZLy7B
 H2/SsRr392pE+WL9dYVgFp0e4c+aKb6W9kiSmz6v//OMWmDTzV9kZo5RF3/5qk5drN7B
 P0iXBb5aeM5pc7phWA0MWOZblT3DA/MSld5kKAw75eBBEk8izC2YNsrZ6oXXD8tSSPv4
 dK605mWMbgV/IY/TM4h8lq/E2mEe2a5/VDNAet4LmFHBFVsSAq8dSyaD3FTNKYdcERr/
 x15BP+fSDX6AeQnutgKpt1nNHzoiSmmH6nYhN2DHUCJk3X6XJklJLJITeE5xrUplrq1g
 jXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777493243; x=1778098043;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQE1HWutJZrccc4xhn8bIEm1VSEiR13vxsMi+6wM40Y=;
 b=Z3ulmvyc1itY3MLgb5DIcsp3KIOjzSSsC9KvmdM+HooRAhf+IGrdTAmiIpKLHI/ttc
 tqyzYmbcfy91//7bkGtWIlEmZS0x6c3IkCmYhNAqcRHxqoovONG8z8g1O81qFYyNYEzW
 FV8djxCxMBscyNf9UfoUN8bSfTBLS9HKsxv2OSS0v/S1kxsXbw/hpiwWIOGCbvSsIzNW
 3qP3gT5Rejl2sPmhocdPiMIumDhxGWqDkqv2HNV2vqkoXlBnwQKXcFgEFs1MKifULk8W
 9YFkI+Ke0lHUhU7ouvZwU7AKLM+TCx6w7wHRnkjeiZS1+hQPUSJdgqo1GhoA9RqghEwt
 iAZQ==
X-Gm-Message-State: AOJu0Yzs5BYrv0DNFGm2tYQ7scq8tnSURRfRLL5irptJpe2OJngANUkP
 ycpI+Xp9ggUkYx7CL1QMriJ/EJTVKoGYfVcaq2G8QBfFbaHO0UNiByob/qfkKKAvMjcWOWWemq/
 vj2A5dxs9rMtFHNjVUN4NArd9xSWKuvEwqkwTL+qcd3pNnbu8pcPzhAeb9rGzSuVz
X-Gm-Gg: AeBDiesQfjfMoLXn6Nbmmz/CCZNA3xiqOO79Vg5j1ErYjHCOPbEKnwVoxWDmGHOU5O9
 i8XyI/l9QDYJy3TpiLJ4ofjwHCytVXDkv3YqZK9BFqGAjg9KEt0RZhsGFkeObnyFcqbf6936GmG
 bUMLJusv9sTKe4W7lHwUp0pG3wIbje5pEYC2vJ7ZicqmCNU/yV0KpDxCh86/5M8EB0hPigLlS0V
 6LldKNE68qL+LTsokF0cl48bOdBAnvRFBNo0x2nV1HtofY/zOpCHU8VJ8Gr8Aj9yXePfaFBa5EQ
 E7lt9pxBzOEcGfVs9MxInrDRtPoSFxl5d1QYWpvNxPaY+wV7enExNy8gii/ywdk3M6HLQf/YuaD
 Voo0xMY6l09goTPtLDUZOg6c=
X-Received: by 2002:a05:6a00:2d16:b0:82c:9c90:54cf with SMTP id
 d2e1a72fcca58-834fdc1e9demr89976b3a.43.1777493242580; 
 Wed, 29 Apr 2026 13:07:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d16:b0:82c:9c90:54cf with SMTP id
 d2e1a72fcca58-834fdc1e9demr89947b3a.43.1777493241960; 
 Wed, 29 Apr 2026 13:07:21 -0700 (PDT)
Received: from fedora ([49.36.109.214]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed80ec94sm2932261b3a.52.2026.04.29.13.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 13:07:21 -0700 (PDT)
Date: Thu, 30 Apr 2026 01:37:16 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH] tpm: Dynamically allocate tpm-tis buffer
Message-ID: <afJk9Lsn25UQOnwE@fedora>
References: <20260427200134.453022-1-armenon@redhat.com>
 <765f0577-ee8f-4944-93fe-bb93e420668f@linux.ibm.com>
 <afBbLDmdYFY5feJx@fedora>
 <84607c2e-1da9-43d2-8a5b-e50e91c0f8ba@linux.ibm.com>
 <4b5c983e-8bbb-4851-bb0f-f478ad14121b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b5c983e-8bbb-4851-bb0f-f478ad14121b@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Stefan,

On Wed, Apr 29, 2026 at 02:15:16PM -0400, Stefan Berger wrote:
> 
> 
> On 4/28/26 8:57 AM, Stefan Berger wrote:
> > 
> > 
> > On 4/28/26 3:01 AM, Arun Menon wrote:
> 
> > > > 
> > > > With MAX() it can now be bigger than TPM_TIS_BUFFER_MAX if the
> > > > backend says
> > > > so -- hm...
> > > 
> > > TPM_TIS_BUFFER_MAX is still 4096.
> > 
> > Oh, I had still based my patches on your TPM_TIS_BUFFER_MAX increase to
> > 8192 bytes. Let me fixes this along with a few other things. I will let
> > you know.
> > 
> > I have another series that I will post now that can be applied to
> > master. It's adding a test for TIS over I2C but I will need to extend
> > that one also with the large transfer test case then.
> > 
> > 
> 
> So I have resolved this issue now along with a few other things. My branch
> is here: https://github.com/stefanberger/qemu-tpm/tree/work-tpm-for-11.1
> 
> - I have applied the i2c swtpm test case series first since it could be
> easily upstreamed first
> - Then your patch "migration/vmstate: Add VMState support for GByteArray"
> - Then the CRB chunk + TIS extended buffer support series. I modified my
> patches (last 4 in that series) to
>   - increased MAX_TIS_BUFFER_SIZE to 8192
>   - added migration blockers dynamically for TIS whenever >4096 bytes are
> either in the request or response; remove them later on again when device
> goes into ready state for example
>   - added large transfer test also for i2c
> 
> Please pick up those patches for v6 posting, or otherwise you can split your
> v5 series up into CRB-only support for v6 and I post my (last 4) patches
> later on.
>

Thank you. I agree. I will post v6 as CRB-only support. The GByteArray
patch is already accepted. The complex TIS changes can be posted
separately later.

Regarding the TIS buffer: I saw you implemented the migration blockers
and 8192-byte increase in your branch. Should I discard my
'Dynamically allocate tpm-tis buffer' patch entirely, or do you want to
try and adapt that logic into your TIS follow-up series later?

Since your new migration blockers are based on the 4096/8192 threshold,
it might be simpler to stick with the static approach for now, but let
me know what you prefer.


Regards,
Arun Menon

> 


