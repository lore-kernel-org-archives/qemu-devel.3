Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687BE606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F5wHEOt4;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=grZW64el
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJQlg-0007kq-14; Wed, 21 Oct 2026 03:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xJQla-0007kT-Ah
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xJQlW-0001EB-RU
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792567777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iNngR5AsgI/xtMeDOuhVg9W0RMqoNvBNp812kQ07xDc=;
 b=F5wHEOt4hrUPElKuIZejRArTzlBs9YW34GIJce/ILSGctOFlqLCikoj1bJek4AztjHVPsC
 LWF0lvFdOrMozWGEPE1El74zBU8sh+mGkVZjQqLrY73PYnrwIagLKANyejwnXHH1JynO0L
 xiVFnNpDwaamOqXNRHsH/wauh4sow9g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-CYjzAE2IO8aXbgtc_yFsYA-1; Wed, 21 Oct 2026 07:29:29 +0000
X-MC-Unique: CYjzAE2IO8aXbgtc_yFsYA-1
X-Mimecast-MFC-AGG-ID: CYjzAE2IO8aXbgtc_yFsYA_1792567768
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48c415561aaso266867f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792567768; x=1793172568; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iNngR5AsgI/xtMeDOuhVg9W0RMqoNvBNp812kQ07xDc=;
 b=grZW64elrX82EYo0UaQy2YEp+g9R2VSKP/C0NT7PlwCQCBILC8o9j83xqYQQ+7kZgS
 Pe5MahrA1DEgnBjoqW49VcIvnNvUeDBff5NwzXam3knG/f/WidYgmnyu+z8X6LlG+aHZ
 bKPuR55RyPR6EKWTwC8yWahxL2kapu5uHMTkK0+6SHrkMIc8aVucUfRLM8AG2NHx/Iu+
 n1NMeTxNOWisu/z+GRHGFyWkqShAyq+CBJy2E1ln6x3PUPB8VML03woyn1ZJ+DqQMiQB
 5UfbHKG3/RmKRyKftGj7JIjBauOjwjPy18XCQMvDBJZJB2UhupsjEf2pKzexK4Novtyt
 QI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792567768; x=1793172568;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iNngR5AsgI/xtMeDOuhVg9W0RMqoNvBNp812kQ07xDc=;
 b=m3Y8UUXyDRNkReLiPP7E6DPTYqcoqBYEqIUOK6PWRWc42Ah2QeGTktsk5W22Odz+/k
 6WtmZbW/VUJ0APsZy4F8c4qGp41DTfc8UYFvFa00TE8cza9Q8KWJNC3BlU7R0tvvGVmn
 YLPgNoc9kc+tt1paLqUwWncrh3aHn5LuNoyAHYeYVDvUSdEvKeZOH8DUrtAOxkBLgOHE
 CBtHbd34SyUWiQLVydLzC/9sPt+GBEeQFluTGtgA30+yXSLpER9MaPCOvzyfcK5OMeiD
 7duW86cQ/NPpUqkJ+v9vxKtcrTEacn9b2C90ZUT6dDT9We2K84VIAHe2fdiUrEBFUfr3
 WxQQ==
X-Gm-Message-State: AFq9FYIg5AQAhTHfjCTCcCmpx4YgOrQ5ZMudh3hI110Yri1a93y49VPf
 8s9MWxn10SCb6S5i4HW51KPCVL30nqIsbRYx7h2GZe0vHuBm4zi9ySTzoGDTOkTXc/xj4E2FUJ4
 W1A6WSE9bhNYulJoARNHa+2hRPmTPEy14n2I3C9kBRj9ciT0U5BT7GkxI
X-Gm-Gg: AYBFou3CUaM1GKXcHilZ5VmB/pAGjFqDsD7LksePvHGHBsw1eL6fQ497/I0q295tBER
 mo5HzGvNKOaRCn36t1fGjJPRE+yJF8FWG9T6XlQGL2JtSxUCnAfCFu8bX6nTsVYB6Hpg0lFxm6J
 AhYeFe3Qffv/dkoXsj9Vv6vyFjb+npbnn6RGD2sfk5ax1d1Uz24uuhiQ5lEzNsIT1T838GgnV9X
 c+g/UiQj6odkaX0vI+sVwpP1wvC0yX8vl9mo5yK1r0TSUdZwTIfWsxc6ofWe/bGwL7/41YjwLXt
 z6EZ9EtpBu0j9erJr67f3KdyQshEfZqHa7xTtZlbNr2iKeroChkoFX0uITzvpCPyFjlouXrz/e7
 W+E0=
X-Received: by 2002:a05:600c:3e19:b0:4a0:8b1:f5c with SMTP id
 5b1f17b1804b1-4a1fdd26e3fmr21638955e9.22.1792567768188; 
 Wed, 21 Oct 2026 00:29:28 -0700 (PDT)
X-Received: by 2002:a05:600c:3e19:b0:4a0:8b1:f5c with SMTP id
 5b1f17b1804b1-4a1fdd26e3fmr21638555e9.22.1792567767721; 
 Wed, 21 Oct 2026 00:29:27 -0700 (PDT)
Received: from sgarzare-redhat ([80.116.165.64])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2d324f8sm119776885e9.6.2026.10.21.00.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 00:29:27 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:29:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Oliver Steffen <osteffen@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] igvm: add command line parameter support
Message-ID: <athpxweAwaPNNMJo@sgarzare-redhat>
References: <20261019-igvm_command_line-v3-0-29aeacbd6cd7@redhat.com>
 <20261019-igvm_command_line-v3-1-29aeacbd6cd7@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261019-igvm_command_line-v3-1-29aeacbd6cd7@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 11:12:46AM +0200, Luigi Leonardi wrote:
>Add a "cmdline" property to the igvm-cfg object and a handler for the
>IGVM_VHT_COMMAND_LINE directive, which copies the string into the
>parameter area the directive points at.
>
>The command line is passed to whatever software the IGVM file loads,
>such as an SVSM. For example, SVSM can use it to select the serial port
>it logs to.
>
>Acked-by: Markus Armbruster <armbru@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/igvm-cfg.c            | 21 +++++++++++++++++++++
> backends/igvm.c                | 31 +++++++++++++++++++++++++++++++
> include/system/igvm-internal.h |  5 +++++
> qapi/qom.json                  |  7 ++++++-
> qemu-options.hx                |  6 +++++-
> 5 files changed, 68 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


