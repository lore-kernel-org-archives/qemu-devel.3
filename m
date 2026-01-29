Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7DFD6101A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlSY6-0004qn-Pl; Thu, 29 Jan 2026 08:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vlSY4-0004q2-9N
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:59:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vlSY2-0001fz-OK
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769695141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0mzBwcr4SPvpOv7IvzCKtPngX3nJdjp02emv6IwJHXk=;
 b=SJn5IjBlfgVONl3BKCjc8MtZU7GPMkDI1q6PTH4h3nezfXm4J1kPKJbSnpyxsMBQGZA0u9
 9y02JmK120sMdQDy8sHjsorIPMzOhh+nz95kaS34GCDgeQOdU+XZZCczx0Ijyghl88g7yz
 ORWQdljp9Q4pzqEvNqXNL1+lA/pK6mk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-YAubqBmpOrGq-5GHcphVcA-1; Thu, 29 Jan 2026 08:58:59 -0500
X-MC-Unique: YAubqBmpOrGq-5GHcphVcA-1
X-Mimecast-MFC-AGG-ID: YAubqBmpOrGq-5GHcphVcA_1769695138
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4806865a01bso7168045e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 05:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769695138; x=1770299938; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0mzBwcr4SPvpOv7IvzCKtPngX3nJdjp02emv6IwJHXk=;
 b=tTf8gzq5iV7tWLs3rNSclgQiTbCX14EPQYbKBwfDz/HQdlRTZPmS9warK4Dw8kXYQg
 0aEMJUwQ3RHqC6pPXHGkFcn7U3pPyhf4XwIHXAjKksJveLj4bKPVg7X/HLaPwgyTkckX
 xKT4/TQ/2LV8zNGFKI1UrWF2rjY6ChYc9zGeAoW1NmFg0KwFXx5USnLETqR26XrAakPo
 l4y2130IVUtaOIvaN1lCaJ7hm9iJngyQTuUFqpR+GUUs9ESQgxfL1mJaJ0oy1+9eR3Il
 Tt8PsK09a4bA31h2u0a4eixX56zpfzN8/+LthpSumWtpHyf+QnXKRqNOr7M/CcxuKx9h
 yp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769695138; x=1770299938;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0mzBwcr4SPvpOv7IvzCKtPngX3nJdjp02emv6IwJHXk=;
 b=qLNouTwF/TPT5kUFyWs21gt7PBQUcb2qyf4BMmeB+5DRmhdT24496EkSA1DRRBOCnO
 +fg1icCgIP3Z3QbV1mVcUGGtLRBjBJ7dVEsR3MAYSXcExfZhqY2vlzvW8TYlqANZW5fi
 lA60hb7IFFqq9QBtezbI7iK4hyBde9DNp6IY4Z2kHueaTs6jdXI3+r4PwQZVF4aIdmNg
 IOcDc0UpHoajxCvm8o+Hy57K9+mKWYbiArydbRPqb6Iig1sOjeODbGs0qGhFXki0Cwyk
 OIsyWBmnP3f9kFRT8JHCQkt3G4vsHTSlMit1wOM/FDvYIKQyY/xR+R6U1K6pn4ca1ZWJ
 gAeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQvrM6U86sCJSRmLrn6RRDCbNLJjlluUlWBYXtbyFdqDOjK/KzUc+qWxPX8L+ZZ5pPkhz+l1ZX+v1E@nongnu.org
X-Gm-Message-State: AOJu0YwjhzVk+OA9lA1EECsNV4pwBGqLqH1lWMDpXj+zVCOpp9TrQaAm
 QecXGFb2U5Z4wp75++C+rnI8bLymrOMq+I+gtojnTzJ4j3pzkvdgW+X3r9xcLkdcpNmpqs1Hqyw
 4kt4BAyaCRSoIaooI9kZ8ddUNgKJlrr0UB7w64F405v6Mcn4Mpa/jYgHf
X-Gm-Gg: AZuq6aI3aF30U3DT4nrtv2q24n3GhmX3spKpaI392uvvuJBOMMxIzam7crxhLkrMYdy
 09x5iQvd5kK3WP5kXSDhzWhusaWCf6vGzuavSvI/SbljlnWg3sCJzsWgw3CWX9RC0tNArW3/3fk
 noHOUP7Tu6JsuVtVtaWqUA3vCpDd5rjpf1OZ899mmbXWQgr+n71gnga96qXOhSgifh+2iNprZwH
 mQA4I1D+wfsc0svSg+ZYxGgqgiHUoQDevoM1lR5qdgE0YT5PAcyjgfw/6IwoPZsfmqlxqiPVkrR
 /nuZ/X2g2vsKTxfJbTkZdzhmSI2zfDNSHB8WWnv0aJbE0LC0iwjeOmzP9v+O1rP+J/O9KxLXc+0
 bSNzTq9aFPsoosUTeuHizBM3cOJ8Jj+CTBg==
X-Received: by 2002:a05:600c:1e1c:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-48069c161d3mr113493845e9.15.1769695137974; 
 Thu, 29 Jan 2026 05:58:57 -0800 (PST)
X-Received: by 2002:a05:600c:1e1c:b0:479:2f95:5179 with SMTP id
 5b1f17b1804b1-48069c161d3mr113493445e9.15.1769695137573; 
 Thu, 29 Jan 2026 05:58:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1353ac2sm15682263f8f.38.2026.01.29.05.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 05:58:57 -0800 (PST)
Date: Thu, 29 Jan 2026 08:58:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: Re: [PATCH v18 05/22] tests: data: update AArch64 ACPI tables
Message-ID: <20260129085831-mutt-send-email-mst@kernel.org>
References: <20260127182805.73212-1-mohamed@unpredictable.fr>
 <20260127182805.73212-6-mohamed@unpredictable.fr>
 <CAFEAcA9qtLv1wOKkEmtNO5UsGTAM0x7YD+y8Fsu8hCQRAD_o5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9qtLv1wOKkEmtNO5UsGTAM0x7YD+y8Fsu8hCQRAD_o5A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jan 29, 2026 at 01:36:49PM +0000, Peter Maydell wrote:
> On Tue, 27 Jan 2026 at 18:28, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
> >
> > After the previous commit introducing GICv3 + GICv2m configurations,
> > update the AArch64 ACPI tables for the GICv2 case.
> >
> > Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> > ---
> >  tests/data/acpi/aarch64/virt/IORT               | Bin 128 -> 84 bytes
> >  tests/data/acpi/aarch64/virt/IORT.smmuv3-dev    | Bin 364 -> 260 bytes
> >  tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy | Bin 276 -> 192 bytes
> >  tests/qtest/bios-tables-test-allowed-diff.h     |   3 ---
> >  4 files changed, 3 deletions(-)
> 
> The process documented in tests/qtest/bios-tables-test.c says
> that this commit is supposed to have the diff of the disassembled
> table data in the commit message, so that human reviewers can
> confirm that the changes are as expected. (If you git log
> tests/data/acpi you can see how this looks.)

not just that, also so the patch can be rebased.

> Can you provide the ASL diff, please? (If this is going to be the
> only fix needed to this version of the series, which I hope it
> will be, then I can update the commit message as I apply the
> series, so you don't need to respin, just reply with the updated
> commit message with the diff in it.)
> 
> thanks
> -- PMM


