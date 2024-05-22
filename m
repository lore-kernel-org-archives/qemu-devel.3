Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18018C25B74
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 01:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9b0i-0003PX-RS; Tue, 21 May 2024 21:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9b0h-0003Ou-8F; Tue, 21 May 2024 21:43:19 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9b0f-0007zl-PI; Tue, 21 May 2024 21:43:19 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1eeb1a4c10aso6127515ad.3; 
 Tue, 21 May 2024 18:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716342188; x=1716946988; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fIXtoA9pPuZlajDkW6aQmpw5sFiTlVBM+dhoP5mNfs=;
 b=K2WL52uG/cLPj90vu0HkyKk8Ikv0bhTTCqDP94WSo8h7dstwoOKwJYNxaXv+vC8epq
 iRq4XPLsKLYPaNcgPc431MUvten2ZgBSOTPtTIITueDl6lcNHhRC8iqg9yWq/RlRwGwD
 Jtp6UsyleDGVk8M2agZJCN/6Ff5B6EAKhKF8O45lovksqYphZ2Roh1BH1HFDDYdnkHe6
 JdDThMjhnyr2Zw+i9foz4Z4OfpI0dj5aUXOjArmvYXN2W2spgUjOPr9XEnuhRH3Sy9lA
 Rz7B7QcTgOnC9gf70dxDbcfPlvTiPMwItJNLIb/Hgj//x/SirpY9BsRe115KQdabrau2
 6k+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716342188; x=1716946988;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2fIXtoA9pPuZlajDkW6aQmpw5sFiTlVBM+dhoP5mNfs=;
 b=JnvQwzo2+zpfvTs8UK//ZTJ82R3csE3E7TXnDgFTrGZ198t2BEsIGVkkN7HdkfSsfM
 c28Ix0R9dQB6WQiYKkCqwWy2aIXvNeE23lRdFsmRRicaMBZj3aQEFX/APFpER/j3vFH3
 grwpyeKW+pZ4cIuOtXmz8c/lGdjRxWXzmDRUXdL/0HjGSjT17SCnMctoLcbFaMQZr0YQ
 ZdlJiQemHJoCY7Y4edNT52lFGNDeHLm37YjHUjNamLYybszh1OpFioAlBrGntED2s+6g
 Wfp0kVyVPFvPPCQfKYUpxgSvuPK245lL4MaxhfzOuy1RMJRssRTjucekPZvgE9f6wX1O
 sXQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCueW7EHsjmq4Id5p3zvlrPZiFAPbx1+mHnI3mTG7RxlJdX2IvfdREYpl9EEd4OoU+bBj39S6RefXxBxLGq1ovpcO8
X-Gm-Message-State: AOJu0YzDuY0ROau2kUluIDVQ+HSbzE4kiMbbEVtXW4Tqw/i/USn4uA+8
 jfhv6H89j/nf7rhn1cNCjedNQzjBUzmxHx722HfXHm0XOItf/phVt5LQyg==
X-Google-Smtp-Source: AGHT+IFAqwHq/MkKkLZXEgRv32u6apJsSRzB8Zyydh53vf6Y11TjHxHAkE4iZgem7vVcXB/PMFC4sA==
X-Received: by 2002:a17:903:2803:b0:1f2:ff7d:ecf1 with SMTP id
 d9443c01a7336-1f31c97a913mr6896275ad.16.1716342187828; 
 Tue, 21 May 2024 18:43:07 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0c136a12sm228490755ad.251.2024.05.21.18.43.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 18:43:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 11:43:02 +1000
Message-Id: <D1FSIXSFIDFG.1K94TH3V8LF7L@gmail.com>
Subject: Re: [PATCH v2 06/12] target/ppc: Add PPR32 SPR
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Glenn Miles" <milesg@linux.vnet.ibm.com>,
 "Chinmay Rath" <rathc@linux.ibm.com>
X-Mailer: aerc 0.17.0
References: <20240521013029.30082-1-npiggin@gmail.com>
 <20240521013029.30082-7-npiggin@gmail.com>
 <05148488-d827-4c6a-936b-5eeaff2a5d86@linaro.org>
In-Reply-To: <05148488-d827-4c6a-936b-5eeaff2a5d86@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

On Wed May 22, 2024 at 3:40 AM AEST, Richard Henderson wrote:
> On 5/20/24 18:30, Nicholas Piggin wrote:
> > +void spr_write_ppr32(DisasContext *ctx, int sprn, int gprn)
> > +{
> > +    TCGv t0 =3D tcg_temp_new();
> > +
> > +    tcg_gen_shli_tl(t0, cpu_gpr[gprn], 32);
> > +    gen_store_spr(SPR_PPR, t0);
> > +    spr_store_dump_spr(SPR_PPR);
> > +}
>
> The documentation isn't clear on whether this zaps the low 32 bits. If th=
e low bits of PPR=20
> are {reserved, must-be-zero, undefined} or suchlike, this is fine.
>
> If not, then you need a deposit here, to preserve those bits, e.g.:
>
>      gen_load_spr(t0, SPR_PPR);
>      tcg_gen_deposit_tl(t0, t0, cpu_gpr[gprn], 32, 32);
>      gen_store_spr(SPR_PPR, t0);
>
> Anyway, it might be best to add a comment here re the above.

Oh good catch. The other bits are reserved which means they can return 0
but it's not necessary. We implement all the bits though, so we should
not have mtPPR32 zeroing out the other half. In theory we probably can
since they're "undefined", but it doesn't seem nice. Actually now I look
the ISA says reserved bits in SPRs should return 0 for reads in
user-mode which we get wrong in a few places.

Anyway yes, for now I'll go with your deposit. Thank you.

Thanks,
Nick

