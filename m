Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87513C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCyxH-0006SM-N1; Fri, 31 May 2024 05:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCyxF-0006O3-Qo
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:53:45 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCyxE-00045y-4c
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:53:45 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5755fafa5a7so2179239a12.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 02:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717149221; x=1717754021; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=by8oQzEvfMWn9An5Bgyvq9qi6+RX+nrQ4N4tB/vX/+o=;
 b=mnVs10fqmvm6hfe6PI49VB49KGle4OTJoJsJu8HkwxOV4FSd0NiniUPbvup/HkLr3k
 MdVTxfVWih0+UJjiKD9JLcwVMz6vyLiLx3IF1PFXU+VqcqD6ojgAl5a1v/0A9+cUZPzd
 bglLMTL3Hg/IBNnzFw4nv8gFcp0fPoCJce2fxo6IlW6r/rG8xXCNIltELm6EYuFd0YXD
 Ty6guH6k04SYAOGZLU6EzU3nt8PqAZ5OkqRojltE+E+P0xDlgHDaWhQQVdUX9M+sUIcm
 HOLjxuOsjLeqiXPgbSsBETf+FvbplkTW16u/6xCwn3EPWjNAQLwaoANFQd53CA+HioJg
 ISiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717149221; x=1717754021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=by8oQzEvfMWn9An5Bgyvq9qi6+RX+nrQ4N4tB/vX/+o=;
 b=J4c5rITdYXTbPeGca2RxfkYh+gJKBEfqdOqkWTT2GUNVOBSb28S2BO7oVvjzz2zcXH
 Wou6Five9EzvMqyRnOsE+Zwy0Yf5oTonaBv7IO3Yz8yqFGYmkH9+fK4vS6l7GSGpHFAF
 BShqdrRtj1E2aJwQ01DICCmVXnpe7Zt1wDOplf59433rVYXTR2s5sVV+vo1BU8VBXD9r
 86V2x9mRtk7HeLtZzmQ3hmBXvvoc3VlEivihVclldUq1qACOGSfmAwJZxJIlPOlNxilw
 tQCoJ2xkAxeMw7ICjmEi7tlCLBBsiIpJomqc8xUWYVfzUmDGChDHGAV5sGZub6tIpQ9u
 RU4Q==
X-Gm-Message-State: AOJu0YyAxOUZq5ynGTCDAPr8nasWSYIqE8wswn/s/JI6jkxNetGEExZW
 Jfs2qiopz9LxYwSfAqw4GgEc2IoNZUsJqAOAwuYgosVW7/GHuM5Hz2/75TzGkI/UHPXH7hZBP4u
 NF4mZHXQVV4PJV7/phAxabrZNLop5VCbNxyWaLg==
X-Google-Smtp-Source: AGHT+IHHKLivT/9TLd0maI8X4jLawlUHlZQtZXfcIbhBYqBakcXtNIVqu0Y3L+FuFu7MEYHcytHIlxi5fsmER3CXM3o=
X-Received: by 2002:a50:9ee1:0:b0:578:36a2:7073 with SMTP id
 4fb4d7f45d1cf-57a36450a36mr1059222a12.29.1717149220760; Fri, 31 May 2024
 02:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240526193637.459064-1-richard.henderson@linaro.org>
 <20240526193637.459064-6-richard.henderson@linaro.org>
 <CAFEAcA83_tyi+mwffuM18LSiUjXksgyO7P-oyZrAo8Bup6ZJGg@mail.gmail.com>
 <c24794ec-cef2-4963-8161-5a1ad63c7a7c@linaro.org>
In-Reply-To: <c24794ec-cef2-4963-8161-5a1ad63c7a7c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 May 2024 10:53:29 +0100
Message-ID: <CAFEAcA-2JAZifBG_RDKELtDDnmvBfTq94fjSr5qwPSf5Q+dcwA@mail.gmail.com>
Subject: Re: [PATCH RISU v2 05/13] risugen: Be explicit about print
 destinations
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 30 May 2024 at 18:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/30/24 05:51, Peter Maydell wrote:
> >> @@ -87,13 +87,13 @@ sub progress_update($)
> >>       my $barlen = int($proglen * $done / $progmax);
> >>       if ($barlen != $lastprog) {
> >>           $lastprog = $barlen;
> >> -        print "[" . "-" x $barlen . " " x ($proglen - $barlen) . "]\r";
> >> +        print STDOUT "[" . "-" x $barlen . " " x ($proglen - $barlen) . "]\r";
> >>       }
> >>   }
> >>
> >>   sub progress_end()
> >>   {
> >> -    print "[" . "-" x $proglen . "]\n";
> >> +    print STDOUT "[" . "-" x $proglen . "]\n";
> >>       $| = 0;
> >>   }
> >
> > These are the progress-bar indicators -- shouldn't they go to STDERR,
> > not STDOUT, if we're going to be careful about where we send output?
>
> Why?  I would think that only errors would go do stderr...

Usually when programs have their stdout and stderr going to
different places it's because stderr is the terminal and
stdout is "wherever the 'normal output' of the program
should go". So progress bars and error messages go to stderr
because those are for the user reading the terminal, not
for whatever is consuming the normal output.

In the risugen case we always output to a named file,
so the distinction is less important.

thanks
-- PMM

