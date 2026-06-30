Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD23C43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 00:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weitx-0001mY-12; Tue, 30 Jun 2026 20:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1wehAk-0003xj-6A
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:43:18 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1wehAi-0003oO-MH
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:43:17 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-84789df5be0so9836b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782859395; x=1783464195; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+Qu6iAtCM9ny+ZJJiiaEpeaU+d6O6Uo3RKNTVYIuSKA=;
 b=UT9DrXN7uc9YMUrlKdZAQRv07m1k8xWDewXfNPtRqTtfrWCmNMdNAt5pcl+9phoSi0
 /ipjLGoNejZJZ4saNFoNd4p3Jwm2ejzIfix6nnx0k4KyPDy7ZIR2af29XX0qBnQ0isG2
 3NOUZlZAILQ2pljiewEW9HvG6zrJaVI6RVb4QGO6kEmLdhtoeIb1CR8R04glkKs6BkiQ
 c1kv8n8jRBaEuuajzqeAkN/Bahz59nkMVUMCBsIyfYYTIoxARHap1XVD/w0WpfvSvDE2
 5vjvluUfi2K61aq+v8z0CbfFuF8D9uuPWOE3Lj0S7I1MlS7QELpm4w2a/V24jwBmBkKl
 oPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782859395; x=1783464195;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+Qu6iAtCM9ny+ZJJiiaEpeaU+d6O6Uo3RKNTVYIuSKA=;
 b=e9PMqkl9ugOfao3ep0Q9vVUOXctPVFXhKfXonbuc+JSoLSENB/m1RWTN9fT8k0MVtV
 FJ5EncdhHQ9FeKdNb24tqZ4qxewd76eGkjVLYm2NKgVJp6wWC8f6yCIEMJ4WOtfXA49I
 QOiQLAQMs/BNIFLgMfDzIWYa4ZHx/wDxk9BLJOITKo4xXHPNwfgKw3voVkLy5af4u+m9
 oVAi47kGZqJ8xUz8Er8VIB0HPcPTDLe3WmXxhSsBCpVeKE6WGA775AQFU1bV6gMDCCrm
 Wwlfy1AhDYM+XoFO/fvvhTz1czMj5ShQRBpGa3LqYIydspvG6WtITb3RDAv2XcU7t72w
 IQfQ==
X-Gm-Message-State: AOJu0YzPG9F8WHapasY5Xr9H5L9kTv4r2gwVW7NI2NRpfw5lnj8Te856
 iNqmf9BW7YsGG1B0RGeVTYf91/c0MjsDAqb5OdtYgJ2v8Qq5xxKeas9W
X-Gm-Gg: AfdE7cnNt9EsAEyua7TE8GpDmPmXAkDdiD5mKVD/WaHt60xdFMVPdxEFyEKL81Lu5K/
 npIug5qj3oXWfN32xNxBj/sAPWmKBDUQu6ga4jxN7usikzlX/ppJvBSWaM5tJ0qMVsb4dWnm18j
 Esu4PwG1BXc0h43qk4OHO0m+ZToqw4ze175fgs5CtOCOJLM817f9koE6XMIxFhxbqn22eTS6sTJ
 Y+Xwc+xTW/JJy37y7RYPEsuK8PpABP7N1rvbMZb1G5CZjoMwSi++Vt+KGtPn0AgvtRRBfnwfWN0
 ikISMPiF2gzr+fcQg7ZbntPRBbkujqJq+cWrm3jQ5k5OG0nztiYVYb1cfqHHHUMeK1HhPyB7ICk
 T5xz8fuhFyFdyTrFjEj3KGhmRkyYc9Rv0RGwZpUK6YueK7EesLhNkJg3yYrNzbgJC5bDi5cVZC5
 NlcVPJCFQl1Kcmi8iBYYpv4r9fWXI3WCa+Pd5vZdfgI6seQA==
X-Received: by 2002:a05:6a00:3d0f:b0:845:cb89:c1a3 with SMTP id
 d2e1a72fcca58-8479f0e9c81mr2877150b3a.1.1782859394669; 
 Tue, 30 Jun 2026 15:43:14 -0700 (PDT)
Received: from smtpclient.apple ([23.247.139.92])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8479ff89f93sm2949343b3a.4.2026.06.30.15.43.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jun 2026 15:43:13 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH 5/6] target/loongarch: do_vldrepl_vl: Fix endianness when
 reading from guest memory
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <3697e939-0d8d-41ca-9af3-0729ef589bd2@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 06:42:59 +0800
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C577E147-250A-448B-957A-E02D7DBBA322@gmail.com>
References: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
 <20260701-loong64-be-v1-5-9c7d65e00697@gmail.com>
 <3697e939-0d8d-41ca-9af3-0729ef589bd2@oss.qualcomm.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=shankerwangmiao@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Jun 2026 20:34:00 -0400
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

Hi,=20

> 2026=E5=B9=B47=E6=9C=881=E6=97=A5 06:34=EF=BC=8CPhilippe =
Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 1/7/26 00:15, Miao Wang via B4 Relay wrote:
>> From: Miao Wang <shankerwangmiao@gmail.com>
>> When reading from guest memory into vector registers, endianness =
should
>> be considered since the data in guest memory is in guest endianness =
and
>> the values in vector registers is in host endianness. Add MO_LE flag =
to
>> tcg_gen_qemu_ld_i64() to fix this.
>> Fixes: 4a26512f01e0 ("target/loongarch: Implement xvld xvst")
>> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
>> ---
>>  target/loongarch/tcg/insn_trans/trans_vec.c.inc | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc =
b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
>> index =
03938b1f052335190cdc437fc2d453b4f4fe16a4..91b1e15b61cac5d119892df1abd2ecf8=
a4c8e59d 100644
>> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
>> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
>> @@ -5397,7 +5397,7 @@ static bool do_vldrepl_vl(DisasContext *ctx, =
arg_vr_i *a,
>>        addr =3D make_address_i(ctx, addr, a->imm);
>>  -    tcg_gen_qemu_ld_i64(val, addr, ctx->mem_idx, mop);
>> +    tcg_gen_qemu_ld_i64(val, addr, ctx->mem_idx, mop | MO_LE);
>>      tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd), oprsz, ctx->vl =
/ 8, val);
>>        return true;
>=20
> Missing counterpart in do_vstelm_vl(), otherwise:
>=20

The fix for vstelm_vl() is in the next patch in the series.

Cheers,

Miao Wang



