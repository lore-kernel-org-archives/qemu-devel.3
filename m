Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1408606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 05:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WnsttN3R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLaBj-0006TO-LO; Tue, 27 Oct 2026 01:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLaBh-0006T1-Ne
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 01:57:33 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLaBf-0005jx-U8
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 01:57:33 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6ae14eecc64so5051706a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 22:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793080650; cv=none;
 d=google.com; s=arc-20260327;
 b=PY254j4Tksuhxh0z+ZApxbByrRzP5cpfs/5XjB/C1tXgwbf2HMVhNL7dT2ADbZdixp
 xaCiKumjrgKy5DqqyMMKlsxybN4UwRfLGaWq9qaZRUIhPPmKe4qXj0JPner2IdyIqreU
 L3mIzSveWNkBR/cbWu4549wLEDLb0KijhwgMPxvnJuyGOEd7PCuJpYtnb/hoLHbYkMVc
 qpB1pfXuanbKW/aTsq3TgOBOlGwv4l3tLVASgbGXuoldBXqsIYOT1Rl+a993QABlB2ly
 uRe42N4NnXKFZV+BjB7EpBJrpGTLts0zamktv6JB2VCwLpR4FXqjg6jn8psl7emAyWs0
 iKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KmWhgj2e7LdsPcgeUqcJHV0uU9SfamGZZy6dOuvKyko=;
 fh=NAVYNpTplidU1fTItU/WkVuNuBvrbpGusj6Y9iDiBoE=;
 b=c51b5eraM62yCCtM0GenZ4eLsQ9eSSLOo3PwCMYoUBF6loaZe9QMcChnhax4tlp8wt
 auziQ+Fc4jij7fCVfqBan5MRJFkYP+h1btN+1C3m4v7M2umgTXTI3IdOsarqtiRHLfM+
 KQF0PLrc1y3OKJy+IAicYThqpEdktXazQ1UoRE5i7/JPgHFMiZA/zvX35JKMFHpuGt0S
 FZedXjxbPdRMsH0TyBkqEWOaWnhQL4YhKLRb9kJqML05TWuJMo8VfcAe3WLPOcTgOl0e
 fuyYlM1JseON06RO8Eox1BzBC9Y3Y/aYiJW3EtFA/C4RVrOGVje3JXaOlhdlD3sBDYV4
 Paaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793080650; x=1793685450; darn=nongnu.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KmWhgj2e7LdsPcgeUqcJHV0uU9SfamGZZy6dOuvKyko=;
 b=WnsttN3RyNtxO1In03f23moCUNVQer/7FKQUhIRv11Y2KAECkDuL2n1Ru5RrN0RjWe
 VvwqGhtbvi8q6Oh6ThP3NXUauQfbZRsStjuveRvqRb0WUHURSUCBFJz7x2kIIiM58syb
 ddFcsFs4yeGA4qkVNDX+BxhnskKV+WaRgjhX0yJzdJRK6+gBK03J0q3JwLaaq0fvVMue
 4Fi8UfLEypAtHmzVRIwQlWzdPaVjyxI/gIwhRXX05TX2JFMnPosExTNWKOq/FZYvUS+A
 CeYTuafBFrdXN2HKB6qbA+pjgHWZpsjlUo04YCpjZAH6J8rA0Hi9QsXojyj81WV5Wna0
 NaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793080650; x=1793685450;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KmWhgj2e7LdsPcgeUqcJHV0uU9SfamGZZy6dOuvKyko=;
 b=LPRl9JTQJwp+OxTSEXCKt4L5Lpjrnud7C2MkZKlM47DM2PnVmMLGuMBTeTj+JU3dZ/
 Aiwu4jj2ZsFEcogxBZuljuMD6e32c2lJm2NFohSAcflKbDhInurDR/FeER4EGbl2aEpC
 NaVya48m2m8cRkVUdOYxGhNL0i5+vcP6S//+IQrY/4AAnejwwKbWbDoJBBu5JbEv55Kv
 5z9t1WuV5bSkelaQRrY+ZIotcxecgd6qDs5c9WeU7MsREJsnHwibaEHhFm3UUcYYgtDx
 Rd40dsqL6FE7e1lby1ZtKqDKinJaNsJfTjNV+6pE8X6MrR82tpKz2we+C4UeFp4p89yO
 +FUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1zrTTvRUoP1W5q/Z3anU6rQApTS3aXDfRkoJs6ggeYF1/4e5EIkSTFEAwfESYiYigp4UoWcu7kGLh@nongnu.org
X-Gm-Message-State: AFq9FYKdQHoqy8/191X82Bi6qWxR897r6PASMHpQjpXQaB63vQ4LlSh+
 RRrob0rGq235uDudmfB9WEN8yFe/hvpl32UCh1K2wJqSt5ZZ9oH9KhuUG6vHIX2fMoRGAc3InhG
 erjFrxnaNs+BC2I6997+eoN8m/lIPgYP1GaRYE9k=
X-Gm-Gg: AYBFou384ea0T3CJmbiqH1bmzcHZL2RK7+AX43pAnWia5I+RuRp384ds4Qf7JedH2ME
 kRpYQ7EEhCV9iOcsqDKTUBdquOR5ySyiWyeQOzO/bbWYgXd4Z4UEsNIcsAuBWaH9KOfgN8rDvhq
 gErvaF0SFRFzrMT9i5sA/NhOz13/IrFd1N0bu1hv919s9Wfhxjx1cgP9rc+HvE171AvaPJX0E59
 SUfNidWDLmBM2xpXlqTHjEFEV1OM3nH5TIHAwlaeFDfa6jTh3Yg4zLpzBFSUuFgXYBNuWJ+g0aI
 tX06fManCdnuVhZ+AYe8NjS191VjEe7R47j06aQHRic3+tQMXlTFSQRGMiKGTWAvmqOMcwcjJWY
 LqYEAbzKgbzGgqsdJDEmjt4F/XZKKf6Pt9ljSJC+2Z2PGtnRQACQM6ZZbpA==
X-Received: by 2002:a05:6402:51d2:b0:6b1:d2d6:4013 with SMTP id
 4fb4d7f45d1cf-6b442ff0ee2mr9599173a12.17.1793080649865; Mon, 26 Oct 2026
 22:57:29 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_4_kLo+p2k+3+JvD_pPLPjc5M9_HSX70_6ewqjg1HyEQ@mail.gmail.com>
 <cd06ea46-5935-40cc-9897-bf004c0983d7@oss.qualcomm.com>
In-Reply-To: <cd06ea46-5935-40cc-9897-bf004c0983d7@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 27 Oct 2026 13:57:17 +0800
X-Gm-Features: AclHuK89wFDiSR2ezgQc8yKXWk2iXwi5Fslj2bxHXl2WmbTEFis9kJyS7DOUvZ8
Message-ID: <CAE2XoE-xipsj_xNJ5tQ5GEkNV+sJE3VuoATxuHj8M9xyVW2u0Q@mail.gmail.com>
Subject: Re: [PATCH 00/26] multi-target: prefix helpers with target prefix
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-level <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> I hope that through the recent series sent on multi target topic, you
> can see better how to try to slice work in smaller pieces. I try to
> focus on having a clear goal for each series, and each patch has a
> unique purpose. Then wait for reviews, and iterate from here.

I have learned much, I need more information or discussion about thow to
avoid calling target_info() in class_init. You suggest me to use is_availab=
le
but I still did not get it, because for multi-target binary, the is_availab=
le
will not be called. so adding more things into is_available is
useless(for my target).
So I want a more clean explanation of how to do that. (I have already
tried rename/duplicate
the QOM name with is_available, too much changes and cumbersome)

I have an idea is maybe add a function
void object_class_property_set_targets(ObjectClass *klass, const char
*name, uint64_t targets);
so that that property is only available on that list of targets


>
> For now, I'm focused on having the rest of base architectures in multi
> target, and don't plan to touch on "single binary" topic anytime soon.
> But I feel progress can be made on both sides, as they don't touch on
> the same things, single-binary being oriented towards machines/cpus and
> command line, while multi-target mostly touches target code.
>
> There is still room for you if you want to progress on single-binary.





>
> Regards,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

