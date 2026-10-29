Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FD4606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gA3U91dJ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BsV5nEdb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMMIA-0005wG-IP; Thu, 29 Oct 2026 05:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xMMI1-0005vp-Of
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gromero@redhat.com>)
 id 1xMMHz-0005Ix-6g
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793265552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=muNMbILdrhNzMRs0lHQB3e/T+MgjwAZeqZzlpAH8yr0=;
 b=gA3U91dJsciS7d7UDAPadhCh0mSgwY0pOcmPih1AsHKWTLHEWEuQssFLuNjXW5aRmLYJFx
 ZlcxtF2WyzgKGGvgbU/BEZEHGcD7jfk7IDwbMEBVbYBv6c8qbDkMBWx228bgLdwKkHYNK0
 saT62s7drVEYOJnVMi40M4C5/Yyz8mE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-gzggIwoEPCWqVljhC3gQLw-1; Thu, 29 Oct 2026 05:19:05 -0400
X-MC-Unique: gzggIwoEPCWqVljhC3gQLw-1
X-Mimecast-MFC-AGG-ID: gzggIwoEPCWqVljhC3gQLw_1793265544
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e1ad3cb66so1143521f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 02:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793265544; x=1793870344; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=muNMbILdrhNzMRs0lHQB3e/T+MgjwAZeqZzlpAH8yr0=;
 b=BsV5nEdbgDvVSS5sA5WqYcylgdJAIwlaeYwFL4gqSQ+kSu8XrKztyVEgOBt+6zxapm
 dC3gGZIVzDbt/+YYNWqhkeQPvkTHPP7aUw/M/KfTSr2iyZ2kZ9Y24EuVULSRyjF1WYn4
 iV3iACCotzof+heyGU8bNNm2HFe/OtONocDIWP1pSytsTT0COSbUWwVeJ414WDSGn7ro
 Je1FE84ibrg3AXCpRTXUPAis73wwYAkVyvMptlpueObMzouCHaUBJQDJCKQ/GEgNHJ3L
 LJj5npz1ZAt3lhrOh3MDFYkU2eFr9wXtS0gSoaXgUt1ZDab0Ltpij9ufKzD8Uj2KXEsr
 KivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793265544; x=1793870344;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=muNMbILdrhNzMRs0lHQB3e/T+MgjwAZeqZzlpAH8yr0=;
 b=XNS0Z2UecEPbKQmRCI3HK5QmseQpb5BYLoFFM+x1StPzqOTChWciEQzsAr9l+2qXJP
 1OeX/9V0Eu0CBGxPt5zuceYpA6fJ9gJ19hDwKDZmS6NLITVogOwA7MmHw3hNe4Zu3fMj
 IlP881jbvwUnMjEsMEdv7BJdepUVCznvP/E91dj0+KnjDLc0kNEuLpJPNtVaM1C0njqH
 uPCvEvNPzQgi0j5xvrgk4V3bSNQxZCGowysky5G0qp1Anduf/OvaVJ4o41PtiMJIvoK7
 jml3XKIib1mHwo0GOAY1fR+dOMrNwwnCNTVhpUMx4GVVUCeCi7qGbv44djj0gpXrXCTl
 WVlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTsTi5ILz7f2gMeFnu4L7lDWs6FAQvm6/KYNPSocK6UFk+aG6X+LOL7Gj/efzMoTXo/cpkTKQuvwj5@nongnu.org
X-Gm-Message-State: AFq9FYLm/Gl7QBOdnZKRr+tsonc9tRj79mh2uLJuWYVuY5Lfx2+jp3J4
 q3PrR+mCN6iBOgzToQTv8qWYLfee+BzZ05BkpHdTQleJKH9MQNN47VadMtAb0IN0ZtPYHhSIzeB
 hKY89z2I+yVu+TaV5AK2cYJ3/p3WKPxdDxBXgcUbeN5+fg78soyR8xMhK
X-Gm-Gg: AYBFou2MMVRd21WyTNfu2rAUwiEJ8qw45UifJC4URDspvD0FYWuLu02dpOh1x2hEg//
 K/ADhoP1MLi5UHNsrpTAh2zyBxm8kIz8SEOjXoGpi3h4zqi6IlQruA+AEKLQFYr6RPytTpLZcE7
 leT2Ei28w3GXnhkXmxLTq5aKoO3zNBwQlbku/yDO8x5n065cItaaBijY+sIFNRa4EV0nZ4GOXAU
 HdY0b7u6Cw7fUuOfbrpOTEna5zuSvZ9eDoFK5AQDrW2ktsRdHH98T5nNjBQHqHdZ71BEaXJgVX3
 qNdpbbbtCjYO4g+W1BFTzOjlzhs8LpugJ9RZP1N8Ubb7GOoaCo84C1Xdi5+4SQssEQfN4mKL19r
 BNbf6bEAr/hSYObzrIMzw3iCvUZq1n762kg==
X-Received: by 2002:a05:6000:4203:b0:48e:35d4:55b5 with SMTP id
 ffacd0b85a97d-48e5d312084mr9821753f8f.52.1793265544293; 
 Thu, 29 Oct 2026 02:19:04 -0700 (PDT)
X-Received: by 2002:a05:6000:4203:b0:48e:35d4:55b5 with SMTP id
 ffacd0b85a97d-48e5d312084mr9821701f8f.52.1793265543927; 
 Thu, 29 Oct 2026 02:19:03 -0700 (PDT)
Received: from x1 ([151.41.153.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3705sm40270073f8f.45.2026.10.29.02.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 02:19:03 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:19:00 +0100
From: Gustavo Romero <gromero@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 0/9] target/mips: Re-introduce the R5900 CPU (system)
 + sort tcg tests
Message-ID: <5szicatcvnmrtnkx3cng44rz5z3devi5e4anrf7bxxgge6ury7@w73pa455iwnt>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <28e90058-6b1d-40ad-9aed-590107f3f77f@oss.qualcomm.com>
 <a3555348-c24c-4df5-95a4-b4ab0a7490c1@oss.qualcomm.com>
 <4ef98888-b13d-4033-aa02-f48482fc0b7a@oss.qualcomm.com>
 <8628b8e5-7138-4f2c-bd32-ce8a8cb9acff@oss.qualcomm.com>
 <6d7bb396-7f1a-4732-81ca-adb16b8baeda@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d7bb396-7f1a-4732-81ca-adb16b8baeda@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gromero@redhat.com;
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Phil,

On Thu, Oct 29, 2026 at 07:10:18AM +0100, Philippe Mathieu-Daudé wrote:
> On 29/10/26 06:51, Pierrick Bouvier wrote:
> > On 10/28/26 10:46 PM, Philippe Mathieu-Daudé wrote:
> > > On 29/10/26 06:39, Philippe Mathieu-DaudÃ© wrote:
> > > > On 29/10/26 06:33, Pierrick Bouvier wrote:
> > > > > On 10/28/26 12:25 PM, Philippe Mathieu-Daudé wrote:
> > > > > > Add R5900 system tests, code is covered, CPU can come back,
> > > > > > allowing to fix a bug on PCGT opcode.
> > > 
> > > 
> > > > > See some test failures, related to gdb:
> > > > > https://github.com/p-b-o/qemu-ci/actions/runs/40776744817/
> > > > > job/123131480244
> > > > 
> > > > Ah hmm I had similar failures due to too old gdb, I might have
> > > > missed to check the version in that container image. IIRC
> > > > Gustavo had similar problem with ARM I'll see how he fixed
> > > > that (I suppose check gdb version and skip the tests).
> > > 
> > > Found it, this is 'gdb_feat_version' :)
> > > 
> > That's the right way to deal with it indeed.
> > 
> > That said, the gdb used in this test (on GitHub) comes from debian
> > stable, which is fairly recent (16.3).
> > 
> > Is a more recent version needed for complete mips support?
> > If yes, I can update to the latest gdb so we can get full coverage on
> > GitHub. Meanwhile, you can find which minimum version is needed.
> 
> Indeed, the problem is simpler, located in the
> tests/tcg/multiarch/gdbstub/registers.py.
> 
> Before there were no register descriptions for MIPS and the test was
> skipping (registers with no names). Now it runs for real. Apparently
> this is what commit 6ef164188d00 ("tests/tcg: finesse the registers
> check for "hidden" regs") aimed to resolve but was a bit too
> restrictive, this fixes it:
> 
> -- >8 --
> diff --git a/tests/tcg/multiarch/gdbstub/registers.py
> b/tests/tcg/multiarch/gdbstub/registers.py
> index b3d13cb077f1..8d886413eb28 100644
> --- a/tests/tcg/multiarch/gdbstub/registers.py
> +++ b/tests/tcg/multiarch/gdbstub/registers.py
> @@ -180,10 +180,13 @@ def complete_and_diff(reg_map):
> 
>      for e in reg_map.values():
> -        if "initial" in e and "hidden" not in e:
> +        if "initial" in e:
>              name = e["name"]
>              old_val = e["initial"]
> 
>              try:
> -                new_val = frame.read_register(name)
> +                if "hidden" in e:
> +                    new_val = frame.read_register(e["regnum"])
> +                else:
> +                    new_val = frame.read_register(name)
>              except ValueError:
>                  report(False, f"failed to read {name} at end of run")
> ---
> 

ah, I was late for the party, you already found it :)

Reviewed-by: Gustavo Romero <gromero@redhat.com>


Cheers,
Gustavo


