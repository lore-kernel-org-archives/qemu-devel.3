Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3776C606A33C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B20+GQz/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWUea-0008ER-Hp; Thu, 26 Nov 2026 03:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xWUeZ-0008EI-T2
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 03:16:27 -0500
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1xWUeY-00013H-4v
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 03:16:27 -0500
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-38644aedba1so10135738eec.0
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 00:16:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795680984; cv=none;
 d=google.com; s=arc-20260327;
 b=bTKbDTrZkvNtz4kw7FNsaxcFhkBGa87hP7iDgyzSQ7S90SAW4bv5rWBkIWyn1ThGqV
 furSCwVyDkKxzeHuXhW7ZuF81vzlJlFkeWfGb/2ZozvAGYuwI0GNw46mLIrVXTtVErWS
 /+8+8ImSNB/SHBbE2m17mwZCCLnci9DUTvbPwXm9E3g34A/x07tKBT423c4+eshxDYBu
 77LywKrbiRYA0qxOEEEAUwRqAOlWyMHbl8YqvWvl7DZgliyApWKrz7LD/zjroa8ldsok
 VZqddhsW9SbVDkXkxMvEZxLqFUCmawfUqlIPqVrIAhWHDzowUR/73mvTfEba2emLOp1M
 NkmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cJxjkLBmnB25B2jIeyKQmCdUpS26xJfZ4d2dFpNgelw=;
 fh=8XoHuS5rSky6Q5QTihzH+NHauPFkqo5PY2FLZlkkmvo=;
 b=NU2eP24tHHGcTFkVJ475hiamTzk1B/pPTvnyuYLpc7czw0umCDhHsb7jgXuyite3WF
 bwMxP69kzKS6g1EreZsH7dnGHunRmJhg8Bn7Nr0OPi7deghtCUfmOBZ+eLqF+g/2bDHv
 hoqOXYoO4wa88oCh7YySd0sx0AJF/poQrrKCjtdt8Nq3do99VnPmuVlRl8AkugRxJXTv
 iZXZJWO5479AqgdHNxLnpjuzhKcqp40k4eHsraTv2RuyYTXIZpHuL86omJL1Q0AfxMdF
 b7mjHD2N2/16nF/cYDp4/kaxBw3hgSBdodh8y9Ywnvnju1wrnBGvYsh9N43nX4zd/57I
 exgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795680984; x=1796285784; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cJxjkLBmnB25B2jIeyKQmCdUpS26xJfZ4d2dFpNgelw=;
 b=B20+GQz/1SVHcBekrrVMRH5MW8y1VqzCdwdArHeFO+xAoz71TO9ahri9rHU22YIMf6
 RdTkHDvEicIDrdwybHRT9pxM7wS10aI0GyTMwYntLBYrdMh2dyr/p1HGGw8P1gGwAZgH
 N5V3X5j6PhlM5a6VWRH2bU6Gx7tv023b7VsqHZJxHNeiJYuebk5x02eh/oYcwOCGM29P
 h1KM6K3L/qmADrTERw1jjsOueZI3wnIW2m0SyQIHoIU8p9GpYRTNiYidMd1hL2DUD17V
 fMOReOlLyKl2w5CTBUbptJA32d49gMAJKGqfZOK6HpDgAyo5w4Ph92hX5yyCwL3AOio4
 mu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795680984; x=1796285784;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cJxjkLBmnB25B2jIeyKQmCdUpS26xJfZ4d2dFpNgelw=;
 b=Jw8u6ClhuqW5isFVLKRhjPV4U1G1ODYwsJR9gdhLf1TostbdOqhePvhJQOrV3KxqBB
 yjdeZHgrO4UG3rrSbjzbhSalqA+/agEnkToSo+vG7z0UWjYxwQns4vDAXmGU8nXk9nAF
 Yq3JzMhK0fs8Im9DT4QyQVIOrIW+i+5OlPN0tUP8KyguQw2fOaBij1HCk6vCshFoDCLD
 z1jmKMQePPbyD6bumh95AyQUa9JSrlPvDGxs9eo1Ma2ckuyekSTkYiThy00dk2tSQlbv
 KRB2VdRGUQupfbsvB268JIGaECQ+R9TnQ0I4bMnddl53yWhcvtXj9DvpEP5PYZDcvsQN
 hn+A==
X-Gm-Message-State: APuU4Z9IlC0QP+uAhWoH1K4fvDUGNgdRwaGp0Z1GCqnzd4h79+obqVI9
 egG4j0xO2hODSIwnhad7BAjrJkOKmS66EppIUXD57dntemxaXcC/s3aQNLVmLPhXwPmzM39S0e5
 wq2sSR0f3h5WGdFaELjyPbbLfJ2cDNe+12w6lpfA=
X-Gm-Gg: AZFdTZcZ0uDYYV8rjGR0kTtfnLtzsaZCcKEjW5wkdJqrshcAC+Q9kzYRej2W4K2YRKa
 Y9TMXl8I/FlKnoZBWt/pktSCHw1mNdfswTG/JfrhHquBSXhGowigNT7kro+3NaIUSyBsfSxHiPi
 60D0UpOSiPpTptVnSwLmGTTCespyNfH1zu0tuiiNNHaruWm7IyBgFvUuBAFJJ5A58vRSstoGBcB
 jadKOUgnsPL0pTQstLjRUaE5OM94WGEYKzqqswvBbgkPsjCBF1Uka/SulM0vCV+kU1GgQ6PaEjD
 /3O5NfOm+Bfyai1n1fpb1qOyngr2XqyebrdHek4uZcfNZrjuXe5TYJdqDMr8ttxcXct8TK5IGdr
 XLhg/Ta3gHdEr2eaqknhQjgQBIhLWKqfsm8HBilCh6wy3dKosqOlKPc9exyZA0l7iTshkSQ==
X-Received: by 2002:a05:7300:a9c:b0:386:a8a1:9855 with SMTP id
 5a478bee46e88-386a8a1ade6mr12951259eec.1.1795680983941; Thu, 26 Nov 2026
 00:16:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261108105957.62338-1-apolivodaa433@gmail.com>
 <CAGscdFvSGgpQy-WR9W7T3tF6FN9qSmMQ5y2AOCUoqM1ormO93w@mail.gmail.com>
In-Reply-To: <CAGscdFvSGgpQy-WR9W7T3tF6FN9qSmMQ5y2AOCUoqM1ormO93w@mail.gmail.com>
From: Andrey Polivoda <apolivodaa433@gmail.com>
Date: Thu, 26 Nov 2026 18:16:12 +1000
X-Gm-Features: Aa3M54qVXO6RqjXHQ6G8Pd1LM9P10pBrcMW_FMxC8nwZA8VtM_JI7qtLIdZiMOE
Message-ID: <CAGscdFu+spe-rL9TpjxZ0k-t1mLq6u5HqDSiu2KAe134Uqswgw@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Allow execution of INVD and WBINVD only when
 CPL==0
To: qemu-devel@nongnu.org
Cc: QEMU Stable <qemu-stable@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=apolivodaa433@gmail.com; helo=mail-dy1-x1329.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, PYZOR_CHECK=1.392,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ping
https://lore.kernel.org/qemu-devel/20261108105957.62338-1-apolivodaa433@gmail.com/T/#u
https://patchew.org/QEMU/20261108105957.62338-1-apolivodaa433@gmail.com/

