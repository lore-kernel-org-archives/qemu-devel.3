Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5075AC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 01:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcEhA-0003wg-Vp; Mon, 19 Feb 2024 20:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rcEh8-0003w5-Ei
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 20:13:14 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rcEh6-0000S6-Uc
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 20:13:14 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dbae7b8ff2so16112725ad.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 17:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708391591; x=1708996391; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6nOob6L4iGmLzDenZjN+btQD5TlzgcGlePVs0qtux4=;
 b=DbmxrZ28jV0k/2moydk9l3TBt6GC9TvgxUuiSYRJyWbf/8yjBT0OCahHY3YopAgIBc
 F2m1vialcZVSaQaDNc83TmwWOPqSVdLWkUjj1vmftnB6WQ6R6i9QBafPYPHYYkf6UcVQ
 LS+n2Ingonkguc1IldYJEGGoy6gXbk7eFjvmRim1pceh3/bhAVLgbaEC9oWKGOYiH/tb
 HsWMCrYJk+mdXbBKoqPnsEkhBi9su29OjAuCAxVP4a7Cr+P1GaJwg/C7gqvmtG225Pze
 fzHf/Ag2VGuzlmW2q+l9P8iFM/e2ohOD+C012oIJU6I6yCJ8iDmG8OuCZE006A20L0Zb
 bFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708391591; x=1708996391;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K6nOob6L4iGmLzDenZjN+btQD5TlzgcGlePVs0qtux4=;
 b=oBG/3JQV5Il5nofWxECrXSf0MwMPU8pfQE6I4UtIrWYeY3kZ+UtAqgHTMTqbkfWtVU
 ULA4lFCu+Fq3cx+9XKXHbHZe/oCjn3HBaFJvjuTw/Mn9cITkRZleSfYjDr2gevmliuTQ
 szhmAC7ys1PHHpK1cSq0xNMTXOnzE2WMlpKeE4u7QM2itwSlB1wWt83hxHNlD8BZIGJ3
 /CqB5NuLFQ/Sw1eeVzo2m/f2th7fbvZZ8+cxvfAGRNbFStZ+Ei/05vym8QwZcKXLEyc5
 8OwV7Djp+NvbYaAAX629QjjmrnYA9T+L7KiSw3akG45EBZF+b8u3qmO/16sYFCshvjcz
 BfUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVskJAbMaffuBTajMf5W+ML80ym2LagfMCT0SsBn6uoChSIo9ZAejYqkQXL4YApDWekAZtmvG3aDEEi6B0EIoH1Gx95+Jk=
X-Gm-Message-State: AOJu0Yxo+SaBpUnL+XdjnzA4LwQ9xsua6pGBEaTaqvz/5H6wL1RrDBo5
 aE2jPl9kfgbVlkfum3Nf9t1nH34i5nJUAmEpgou8T0E2zLIWMPSk
X-Google-Smtp-Source: AGHT+IHQX3DA15403w9Nn6vQFLq0Cp77jp6n8I88Ouo1WNzqj9K+EFUA8DRBnaHIyE22oJLt4xGWGg==
X-Received: by 2002:a17:903:230f:b0:1dc:15f5:fddf with SMTP id
 d15-20020a170903230f00b001dc15f5fddfmr410764plh.7.1708391591482; 
 Mon, 19 Feb 2024 17:13:11 -0800 (PST)
Received: from localhost (123-243-155-241.static.tpgi.com.au.
 [123.243.155.241]) by smtp.gmail.com with ESMTPSA id
 s4-20020a17090330c400b001db9cb62f7bsm5038242plc.153.2024.02.19.17.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 17:13:11 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 11:13:04 +1000
Message-Id: <CZ9I9VE1A542.30BIYSXFQT963@wheely>
Cc: "Paolo Bonzini" <pbonzini@redhat.com>, "Peter Xu" <peterx@redhat.com>,
 "David Hildenbrand" <david@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Dr . David
 Alan Gilbert" <dgilbert@redhat.com>, "Juan Quintela" <quintela@redhat.com>
Subject: Re: [PATCH] system/physmem: Fix migration dirty bitmap coherency
 with TCG memory access
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240219061731.232570-1-npiggin@gmail.com>
 <c15b1b35-c613-4811-b76f-faed6c7ac942@redhat.com>
In-Reply-To: <c15b1b35-c613-4811-b76f-faed6c7ac942@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue Feb 20, 2024 at 12:10 AM AEST, Thomas Huth wrote:
> On 19/02/2024 07.17, Nicholas Piggin wrote:
> > The fastpath in cpu_physical_memory_sync_dirty_bitmap() to test large
> > aligned ranges forgot to bring the TCG TLB up to date after clearing
> > some of the dirty memory bitmap bits. This can result in stores though
> > the TCG TLB not setting the dirty memory bitmap and ultimately causes
> > memory corruption / lost updates during migration from a TCG host.
> >=20
> > Fix this by exporting an abstracted function to call when dirty bits
> > have been cleared.
> >=20
> > Fixes: aa8dc044772 ("migration: synchronize memory bitmap 64bits at a t=
ime")
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
>
> Sounds promising! ... but it doesn't seem to fix the migration-test qtest=
=20
> with s390x when it gets enabled again:

Did it fix kvm-unit-tests for you?

> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -3385,15 +3385,6 @@ int main(int argc, char **argv)
>           return g_test_run();
>       }
>
> -    /*
> -     * Similar to ppc64, s390x seems to be touchy with TCG, so disable i=
t
> -     * there until the problems are resolved
> -     */
> -    if (g_str_equal(arch, "s390x") && !has_kvm) {
> -        g_test_message("Skipping test: s390x host with KVM is required")=
;
> -        return g_test_run();
> -    }
> -
>       tmpfs =3D g_dir_make_tmp("migration-test-XXXXXX", &err);
>       if (!tmpfs) {
>           g_test_message("Can't create temporary directory in %s: %s",
>
> I wonder whether there is more stuff like this necessary somewhere?

Possibly. That's what the commit logs for the TCG disable indicate. I
have found another dirty bitmap TCG race too. I'll send it out after
some more testing.

> Did you try to re-enable tests/qtest/migration-test.c for ppc64 with TCG =
to=20
> see whether that works fine now?

Hmm, I did try and so far ppc64 is not failing even with upstream QEMU.
I'll try with s390x. Any additional build or runtime options to make it
break? How long does it take for breakage to be evident?

Thanks,
Nick

