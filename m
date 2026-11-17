Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46D5606A336
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IsOKWgHz;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bvznUT8H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTHzD-0000rA-R8; Tue, 17 Nov 2026 07:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTHzB-0000r1-Aj
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 07:08:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xTHz7-0001gv-Gv
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 07:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794917302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oR7r+LdHvm3f6cL4vt0AXV+i+T5VFo3EPxsTb2MkM90=;
 b=IsOKWgHzV9b0Yi+QqPPvqWWMbbuXLL4lV7g3UeEXpAOj9L2OWX3gZPpWvueQBIeABS9L78
 XZJRQNnN5eazFhTTjxIXOdl3fcyJwZBz7uzLv58F19GfLOXZwnV2PsnN2IZxxB8n5J699D
 puWIjlGz7LHVxJ7asjKv8F7r9v3KFM8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-3pNFls-uMrawr3RUjNVcQw-1; Tue, 17 Nov 2026 07:08:20 -0500
X-MC-Unique: 3pNFls-uMrawr3RUjNVcQw-1
X-Mimecast-MFC-AGG-ID: 3pNFls-uMrawr3RUjNVcQw_1794917300
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a16dc2323cso39611765e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 04:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794917299; x=1795522099; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oR7r+LdHvm3f6cL4vt0AXV+i+T5VFo3EPxsTb2MkM90=;
 b=bvznUT8H6iJ/lm0TkiifFcxIG4K+h+Szq2Fc61QThK7GUVx179+jKwOEtGimjPhhMu
 hhyB7qC5j+YDc6Wfi3Ng6gXfiP/LYctG61Za4Gg0S1A9DAF5J2NnJaQ9v7NmfwXsJ5ux
 UtdtmUSnEgqB2W4weI7zYZF/eNWVvAV+7MRS2srNxN616yO0IrAnUTDCjHEGaK4BpC7f
 aKc3KERfRaDAH4W74EoTQ9o8Rq8AckNB9f2OI29x7fvoU7WwbsiswkqO0boyCri59+vb
 dP16a1lSHYZkCv2Dq0Ehcjq10oHbWRcv+ZrOijzWlMcUDl8TIz3Cxo+i/J2h1uIQqWqJ
 cRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794917299; x=1795522099;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oR7r+LdHvm3f6cL4vt0AXV+i+T5VFo3EPxsTb2MkM90=;
 b=PkTj+9d871mmRsZWV/5xHSWv8xBO0yGtga3pPdrC9Gh+Ui+j/6ep2jbjSJ7ikTtjeQ
 TZZVyfbSFqSuGKv4IRPQYS2me3TW0JBrAEzZm2iybtT+P2sHoIOLXkqZErN6lsA6xZeY
 3wVcl7z//dJtA4KIG/ArYfztO/470qE5xWkwBk6ulJBqdkPeRjVh4Z8eZscE/QAq8dO2
 o2NX0tfU/zl4gwO0oqOPlI3HF3YXw4qpoJHjjGVAw0iUqfIrlbW7cb7LMncQcKg2XH2C
 pHpqAT/hdPRxSMqiZ/F1reU9CYA/kpvJQQZl3G9i33MpMRCQl7VR8Ffk73KPWpGBXeUl
 jC+Q==
X-Gm-Message-State: APuU4Z8ZznK6YhWf416UcbhL4POm6XAzzIKsYv8llPWVsQ4bDiXv1AOg
 cZj8gl6H7+WMBBMxfJSW/8YGRCJAsctseBNM9gbCw+ZlWcV9vtqPhwQSVNh8ueHaNajE2DdiotX
 Q1QpiWaMWtnu0WZaGepeMNwh4Z6kyrZc36hW59nIVWzaliz7gqM2YTqWa
X-Gm-Gg: AYBFou1mLj4eZpWSFp049+lzUx+OtnuQUhBRnkjwz/JlLvDsS/JVNZ9+6wZUqUAtkav
 LeRS54XulMiu0ybBtrcHK6zIml5sR/G9p8qvVXRPHCtUuoIwYKc5PWMDX+rUfD284+RsM7C5GWJ
 ZBaARgm6zDbrflb4k9IZvvGmF+vmLypfTZ10pfKVONWlaoSoLKLuUjUDLKLUS7vxkrWlcwmN1U5
 2fmzq1L0XopKPQ8T/sMxSmHqfmZ3+p2jgnoIgaDa/pwEYfUYAGgnVa7k6gZoaZklb9cKhmpldD3
 un5Wrqsh7SrVP6TZ59sst0JwjK9d0caSEi7cW3chfGi7pmM80BocVr1Rewh8T14/YMGpf+Qz8Zv
 wR6grawzgXuURdab+iA+ixm1/8EsSxlzvBZgNbJtmqik=
X-Received: by 2002:a05:600c:621b:b0:4bb:5f95:c014 with SMTP id
 5b1f17b1804b1-4bb5f95c108mr228674155e9.19.1794917299498; 
 Tue, 17 Nov 2026 04:08:19 -0800 (PST)
X-Received: by 2002:a05:600c:621b:b0:4bb:5f95:c014 with SMTP id
 5b1f17b1804b1-4bb5f95c108mr228673375e9.19.1794917298951; 
 Tue, 17 Nov 2026 04:08:18 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7838c912sm58082635e9.4.2026.11.17.04.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:08:18 -0800 (PST)
Date: Tue, 17 Nov 2026 07:08:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] hw/i386/amd_iommu: Mask address when calculating large
 PTE page size
Message-ID: <20261117070754-mutt-send-email-mst@kernel.org>
References: <20261105105816.3012283-1-peter.maydell@linaro.org>
 <CAFEAcA_osj+ewemYAt1A+8LA+LuDcJXqvyLfdQS68C_TLq5qjA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_osj+ewemYAt1A+8LA+LuDcJXqvyLfdQS68C_TLq5qjA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 11:40:27AM +0000, Peter Maydell wrote:
> On Thu, 5 Nov 2026 at 10:58, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > The amd_iommu handling of the "large PTE page size" (where Next Level
> > bits are 0b111) case is not correct.  We calculate the page size
> > using the address in the descriptor (as per table 14 of the spec),
> > but we don't explicitly pick out the Page Address field, instead
> > passing the whole PTE word to cto64().  This means that a PTE which
> > incorrectly sets all the reserved high bits can cause cto64() to
> > return 63 or 64, and we will try to shift by an out of range amount,
> > which is undefined behaviour.
> >
> > Mask the PTE with AMDVI_DEV_PT_ROOT_MASK to get the page address
> > (matching how we do it to get the address for the next page table
> > level in NEXT_PTE_ADDR).
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3618
> > Reported-by: huntr bubble <https://gitlab.com/bubblehuntr>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> 
> As this is a small fix that's been reviewed and not yet picked
> up, I'll take it through target-arm.next. I have a small set
> of "oops I forgot about that" patches that I'm planning to
> send today.
> 
> thanks
> -- PMM


yea have a small set too.

Sure, take this.

Acked-by: Michael S. Tsirkin <mst@redhat.com>


