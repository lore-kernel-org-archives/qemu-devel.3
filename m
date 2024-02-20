Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE84C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 03:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcH3X-0004Ka-Ra; Mon, 19 Feb 2024 22:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rcH3W-0004KC-El
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 22:44:30 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rcH3V-0000G0-0t
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 22:44:30 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5dbf7b74402so4069881a12.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 19:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708400667; x=1709005467; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TsW+5zt5M5iRAPM3ioqvfJoQZCHDlcbd6YmsKdlG8Z0=;
 b=JMUEL/PLD/e1BzKtJ2WocT1+x7e9aCZI/hCGdVUL1JfZz663fD83UMie+LbSpR5d2B
 VvuTx1J9o2tPKIrtt9KYStPWjnuOl6ppKelOwqON7LYENliJkltpdwomleXuFEU1A0Th
 fBLzd2NIRr4QMMXVJxk5dGZCalDADtAZjPdTI71mp8cUmn7wGGykUX7+6449RH5zpcK0
 uLwmFkHBnpvQDWoMVbDIXyxOgTr4jmKCaJRHyI8Isg7h8z1E4n8T6eiLIwCxowz1jqGh
 d8ovs6Bwkh2g38vffo+kQERtOT659HkO0MsqWvQz4xOm+TPUmlyJh0mpc5ooHm//nyjR
 p5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708400667; x=1709005467;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TsW+5zt5M5iRAPM3ioqvfJoQZCHDlcbd6YmsKdlG8Z0=;
 b=XlfVBW9v7C7uAdihxK1Tz/d1I6gBVIDwdgBvrE8LmuHNHqxom+7OiPhhxDiWny+ZKl
 8yVsSDRjjhhBaSpcxBcLfsdTkhJzgsh/cnkiBKR8+4nz16mkEDLx+TkGGU6v/SSiZ6Ca
 b+wY6f+YdVNxNxCDeqVomqSRhggJfpigiGH9nAS5+rvzF0cLol37CYFaIPAartXlOoaO
 r+82VDIdRbf0JHjgD+3CL4/QlDm5c9tuG38Hyih396YC18otkZmrmhHJqNpafmRzr/hV
 dfnus9A183i1cve7flSgMRnXNRPGf7eQiovJef4GdSSkWJqy85deKEbvD7+ly9bjcSbH
 C+Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuAvY2lOqHU+zUqE6Rs3sAjnh11fqs+c0zyw24MH6tIIrr5HTtUShsTI7VIbH7zJlid5Uz7iN2CZfs8bP3fApTS8wENj8=
X-Gm-Message-State: AOJu0Yz227ITcKcIRJ3POe/g4u3tL2ZLorTGSdHOfhhTWKmC7N5D5P3c
 PsXDtSt3q9b8ptvsQbZNOtN6EY6s0Mfz4tO775BeQG6btQkhny0A
X-Google-Smtp-Source: AGHT+IFFRbTWk9NX25jZtHgE46HGsX9K6jPJyQPL9tHMllHe0AubRwWJ51l8rvdr6G633U6SGmR7Xg==
X-Received: by 2002:a05:6a21:3a82:b0:1a0:855e:3b1f with SMTP id
 zv2-20020a056a213a8200b001a0855e3b1fmr10013991pzb.17.1708400667144; 
 Mon, 19 Feb 2024 19:44:27 -0800 (PST)
Received: from localhost (123-243-155-241.static.tpgi.com.au.
 [123.243.155.241]) by smtp.gmail.com with ESMTPSA id
 j6-20020a17090276c600b001da1ecb05f9sm5106017plt.240.2024.02.19.19.44.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 19:44:26 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 13:44:21 +1000
Message-Id: <CZ9LHP99JPFX.2UP5C8BM6FH0Q@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>, <qemu-devel@nongnu.org>
Cc: "Paolo Bonzini" <pbonzini@redhat.com>, "Peter Xu" <peterx@redhat.com>,
 "David Hildenbrand" <david@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Dr . David
 Alan Gilbert" <dgilbert@redhat.com>, "Juan Quintela" <quintela@redhat.com>
Subject: Re: [PATCH] system/physmem: Fix migration dirty bitmap coherency
 with TCG memory access
X-Mailer: aerc 0.15.2
References: <20240219061731.232570-1-npiggin@gmail.com>
 <c15b1b35-c613-4811-b76f-faed6c7ac942@redhat.com>
In-Reply-To: <c15b1b35-c613-4811-b76f-faed6c7ac942@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x529.google.com
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
>
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
>
> Did you try to re-enable tests/qtest/migration-test.c for ppc64 with TCG =
to=20
> see whether that works fine now?

I'm seeing a hang about every 10 minutes with s390x. ppc64 is reliable
so far.

So both my patches didn't fix the problem for s390. It seems like the
test just stops running, so maybe it's a harness problem? I didn't
dig into what state the machine is in at this point.

I did fix a few ppc64 migration issues recently that came up with
testing reverse-debugging. That was very good for finding problems
(but very difficult to diagnose failures). Maybe that helped stability
on this test?

Thanks,
Nick

