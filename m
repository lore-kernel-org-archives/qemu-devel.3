Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989A7C54E41
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 01:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdK5S-0004fA-J8; Thu, 22 Feb 2024 20:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rdK5J-0004e6-QW
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 20:10:45 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rdK5D-0005RR-LZ
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 20:10:38 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-299354e5f01so1150460a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 17:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708650630; x=1709255430; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FsocNsV5S5uLOtsFN5MzUOfPy0hMvWjfmH7MDaJFuJY=;
 b=mGYUMUBNp7qG+tldxhcnWxQsb19AsgzK53tUx9rGKbgZ1rsFDU+uJBuohVu5Rk8vbm
 W4Z1hqenbsgBuKSlf2QyQdBX5hCsn7UPBWF6ZcDPVKpKu77zPDKAvORd8pFjjBJrHMJO
 naPjHpC2X+nfpYpHHUYgPmw+UeXNcSRfI976oCAPRI/I37LPg4cTkVqO0Vj5znoF9+tG
 JT+eXBItUuamhL2lr9lpUVDQvbCR3P8cKXPHvlHii7qjQ3mB2L/vM4NQM5LHL3vYdfJQ
 rOzIbnO9+gYkvI6pfetDth4+HU2FucDf4DjcPwUrwtaansKFxNMsaizu3nEpRpSoJXdD
 mwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708650630; x=1709255430;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FsocNsV5S5uLOtsFN5MzUOfPy0hMvWjfmH7MDaJFuJY=;
 b=JoeeTdUfl5hXva5CW7NKo1Ugl5c4xHAFpyhGwDTLT3pZM9aaPwq2+yrjHivrcNGNfP
 5f7YlYyNHVgT+4TvaWZlYBgksKjanUBK2gp46j4ddvBwb/RQ2fAwU3HT1MOyOlxtypUr
 3yMapNHWOKzCp5WnETC5BYP13XOzPgitIX9KcoGYYMqvxaqVIPttpjiXQC1nXlq+LHxg
 t0tQzoyxOsh+3C5khEUCTxU3MpdM2sFFOqzEbEfiXxqAGsixiJXxJsF7EVClLnbsVKJY
 X5iuYm0UUv+xLwYOXgoxJlA/dpCZp6J2QpqzpydRcKY9XPnFOh0oeCcbEmyDY5SOjLA7
 3qbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVERsdHhthvJqmIKUwM/QmWoEH4TEDH/SrGabFxjCS1ueSwZKrYSKQbgc00K/nMuUbfH5mlk/0sVIRQEeST830nKhCVg98=
X-Gm-Message-State: AOJu0Yzz9Lv0LUycL63zoGF0ljB3mHjtaPcK03WMCI5tHoPbJA4ky56U
 wQoDXZYZDQ+doluLPFJkktW+69zcAoopCTX7J0aNzKRHhp7C/2Eh
X-Google-Smtp-Source: AGHT+IEgegNPa5DAxV/spHSaD3cG498TEZNcMJMilXQ3clbnT0y1OvRpim1AUzVpBly1/1tk4QWQcA==
X-Received: by 2002:a17:90b:19cd:b0:29a:2349:4d1e with SMTP id
 nm13-20020a17090b19cd00b0029a23494d1emr991083pjb.23.1708650630200; 
 Thu, 22 Feb 2024 17:10:30 -0800 (PST)
Received: from localhost (220-235-194-103.tpgi.com.au. [220.235.194.103])
 by smtp.gmail.com with ESMTPSA id
 bt24-20020a17090af01800b0029954a48c38sm126703pjb.38.2024.02.22.17.10.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 17:10:29 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Feb 2024 11:10:23 +1000
Message-Id: <CZC23G1ADP0L.YS7H1H63DEKV@wheely>
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
 <CZ9I9VE1A542.30BIYSXFQT963@wheely>
 <f9fe86e0-e562-45d5-a4cc-aa0052ef5368@redhat.com>
In-Reply-To: <f9fe86e0-e562-45d5-a4cc-aa0052ef5368@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1034.google.com
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

On Fri Feb 23, 2024 at 6:59 AM AEST, Thomas Huth wrote:
> On 20/02/2024 02.13, Nicholas Piggin wrote:
> > On Tue Feb 20, 2024 at 12:10 AM AEST, Thomas Huth wrote:
> >> On 19/02/2024 07.17, Nicholas Piggin wrote:
> >>> The fastpath in cpu_physical_memory_sync_dirty_bitmap() to test large
> >>> aligned ranges forgot to bring the TCG TLB up to date after clearing
> >>> some of the dirty memory bitmap bits. This can result in stores thoug=
h
> >>> the TCG TLB not setting the dirty memory bitmap and ultimately causes
> >>> memory corruption / lost updates during migration from a TCG host.
> >>>
> >>> Fix this by exporting an abstracted function to call when dirty bits
> >>> have been cleared.
> >>>
> >>> Fixes: aa8dc044772 ("migration: synchronize memory bitmap 64bits at a=
 time")
> >>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>> ---
> >>
> >> Sounds promising! ... but it doesn't seem to fix the migration-test qt=
est
> >> with s390x when it gets enabled again:
> >=20
> > Did it fix kvm-unit-tests for you?
>
> It does, indeed! With your QEMU patch here, your new selftest-migration t=
est=20
> of the k-u-t is working reliably with TCG now, indeed. Thus feel free to =
add:
>
> Tested-by: Thomas Huth <thuth@redhat.com>

Great, thanks.

>
> >> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test=
.c
> >> --- a/tests/qtest/migration-test.c
> >> +++ b/tests/qtest/migration-test.c
> >> @@ -3385,15 +3385,6 @@ int main(int argc, char **argv)
> >>            return g_test_run();
> >>        }
> >>
> >> -    /*
> >> -     * Similar to ppc64, s390x seems to be touchy with TCG, so disabl=
e it
> >> -     * there until the problems are resolved
> >> -     */
> >> -    if (g_str_equal(arch, "s390x") && !has_kvm) {
> >> -        g_test_message("Skipping test: s390x host with KVM is require=
d");
> >> -        return g_test_run();
> >> -    }
> >> -
> >>        tmpfs =3D g_dir_make_tmp("migration-test-XXXXXX", &err);
> >>        if (!tmpfs) {
> >>            g_test_message("Can't create temporary directory in %s: %s"=
,
> >>
> >> I wonder whether there is more stuff like this necessary somewhere?
> >=20
> > Possibly. That's what the commit logs for the TCG disable indicate. I
> > have found another dirty bitmap TCG race too. I'll send it out after
> > some more testing.
> >=20
> >> Did you try to re-enable tests/qtest/migration-test.c for ppc64 with T=
CG to
> >> see whether that works fine now?
> >=20
> > Hmm, I did try and so far ppc64 is not failing even with upstream QEMU.
>
> Oh, indeed! Actually, now that you mentioned it, I remembered that I chec=
ked=20
> it a couple of weeks ago already:
>
> https://lore.kernel.org/qemu-devel/7d4f5624-83d2-4330-9315-b23869529e99@r=
edhat.com/

Okay I'll look at re-enabling it then.

> > I'll try with s390x. Any additional build or runtime options to make it
> > break? How long does it take for breakage to be evident?
>
> For me, it normally breaks after running the migration test a couple of f=
ew=20
> times already, let's say one time out of ten runs?

Seems like a tricky one to debug.

It looks like the migration qtest is just migrating while incrementing each
char in 99MB of memory? Interesting if that breaks but k-u-t multi
migration on s390x does not. Could be worth looking at the differences
between them.

It is also odd the qtest didn't trigger this TCG bug. I have another
multi-migration test for kvm-unit-tests (not yet submitted) which does
similar dirtying of memory and that *does* break TCG.

Thanks,
Nick

