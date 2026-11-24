Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE67606A696
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DmHbNR6U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVxiJ-0002JB-E6; Tue, 24 Nov 2026 16:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVxiF-0002HZ-DZ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:06:05 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVxiD-0003d3-1C
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 16:06:02 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-67db0791748so5735892d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 13:05:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795554357; cv=none;
 d=google.com; s=arc-20260327;
 b=PeKoS1/NwOXQbyaTVs4KgEHHFvtSGphXqP8tdaiE8gdsA81bhzdp4+MX/meQ+iuD8p
 0qK9Yeu4B/bFZ3FkUC5ILFaATMfUpcWNJoaKHmi+nw7iSBQ5/1LG/M/mh8eCMvGjdjY8
 s83BmgI3TPrRkhwFbezGAMQrVZqyN7x99EQ9DoKAclQ2ZK33zdwg/eZQMZpwjjJo3fD8
 Tk6MHN9kaTT+oghBWvwoJquzr1qEtEKShMyqN9iQtqDMDKqAUWKfQCI0+03PGovbc2MM
 zMdXXEck3/0V2ev20R2QXqT/FPFcoZaqRrO+Fx+YQKUh96zYRI6UVzv8ql7kCcF503oH
 A6fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I/f6r/ExPk9REdTgv8EyfMo1qoPzQAZJRilFJwbfvMU=;
 fh=WIdQJohB0vIqxKCdH0snD1wsfK/6NXLtzjVX+0IK7aE=;
 b=kwrrjiisJgtgnS+HP3qPK8rLAizqhgZcy3uYIMZVCnn0Q1FWAi15SEoneHZsMhAyzo
 pDixo974DgKTufwN5+tzEoGwEExVKx5Muv8sypyRl+vlbNkSfAAtijL74bRPaPrk/DDr
 GC36m/nQ0vff3BEbnnzBFmE2LZdJV+nRuwLkLkPNBnyIyaooEBjblQSWR/dvDRRXUxjQ
 L4OYxISuUfBhn2fPA6xlE8s8RZztDgKF3STkS6b+Pl5vrRoDpJB5a0z5PmJPPdr2Okdd
 cJrP2Th8HN2oCaekOovCqnhBFa7u7CnqKcvV0NrucXWyhjfDbSWmF1GoVOZ20j0LdXU/
 8oFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795554357; x=1796159157; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I/f6r/ExPk9REdTgv8EyfMo1qoPzQAZJRilFJwbfvMU=;
 b=DmHbNR6U0N48QP+fK5N5Z8sZ9qaYSnIFzETixaINVBCz00NSDT20dKzfC/Hh3JD+te
 xDQGVa/mvFiQFrnXxWsjYb8USJDzRq1XWZcYtB4y6W9SDZsT6CWMgzUhwiTNHZl67WBg
 gvJRcOG8lqJknWpPYm4aTne4x/6Vg52LowpzK2Z+1pkw+Ryb2pasXggLm8mfYC1kyI0t
 bPkTKz1MpQetJfAWi/blZlFHIzNphz/bPohfaxcE0xOP4iZcE+OAgI08K0QqlJbpM9Sf
 eU/MS8NdBS/dhZkfwLffYUiwDRjUQZdSNDdzfReW4pBnuSTmCm6uVYJPF1UMXwZjrbE7
 2Guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795554357; x=1796159157;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I/f6r/ExPk9REdTgv8EyfMo1qoPzQAZJRilFJwbfvMU=;
 b=rr8XXJzQwbgkKmTuf4cqdVOLUOvKMQiLBmG7iAhbM83oZg0SW1av5WWpoFAcoE2Jxs
 cbd4nGQLhDYNICwrveQj6zNBVuhTo+P3/DZMnFpydyi6fHCBu4bI05MXTdqzNVq0VYxP
 i0GuLG6QJdiJv8UQnjaGvimYfJaxTDipUlHSQw9eIAA/hjLBchApmLgqvd7rXnh2Vf+u
 E4AH7dKgk2L94VAHN7knMsJkV/Cczd2i8I2iw8cG36bcJNCgRdaSgEOEUy8UCozuGET5
 p9IPpW2xYFnfE+qy857x7f/SzYXXB3g3VZihl5i9o8DReV1n5qxr3zzSTiUWvTXMg81y
 FR3g==
X-Gm-Message-State: APuU4Z+CSMpdj1NBqDEuXzeBDYuAwQq7a7W3XupIp2WHr+ZgZS4KNI+o
 Kh+Qk/a+QFxrD/dCmpKvkGeJmMTfOsn8JiDzA02m13U0ghmr1pN8lXeyuDIJjD217ul39mmSYYc
 gKZ7oRCm01LBBkRIe0lLn+EyllURjslhcrhPEkzxb5Q==
X-Gm-Gg: AZFdTZdB9CKzS0mVl3KP7DVIYXrUg5uViOf49CCOc144B8jD6AGzwD0k5OuN5mmyBxg
 PLfkOZAVW9+AjBPBhwn5fMJ+1FpH9q/zjutHlZQ9eQdxtQ8otvtdoP1OUdKDP4lqmaf2Aic9g6n
 1z+o+k0kwHRlQJRnMmegtXAgUtPLDX/3ZfZOpuGumxyVT5N2/mUEzkoHbUNVZO9UZhXm8i2Upm4
 EStJnmHrCIkhwQ8Vuz5bZE+NRR+7Vfqxsn0KbOgHojciIUSqqvl0fBFKarxkPanDOz5MpC7b0oX
 nI9uZ88edCT3Z1ZfLuNHAiD1w03D8QKzUyvlUaOhFA0a3mServ8/6/7Xen6ayWUr9ueLS82iCZr
 NexcLR+vYtUyvDM9FjPNbSUHkLVAbAkigfCxIC9IfA02FV5rPDh2hLL2YoU3gkKUtfhzW0G0AhO
 6Ck/d5nsefeCKsfYu3eykb
X-Received: by 2002:a05:690e:400c:b0:67b:fdfb:1827 with SMTP id
 956f58d0204a3-67e44919570mr244291d50.60.1795554357072; Tue, 24 Nov 2026
 13:05:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124185556.81132-1-philmd@oss.qualcomm.com>
 <20261124185556.81132-4-philmd@oss.qualcomm.com>
In-Reply-To: <20261124185556.81132-4-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 21:05:45 +0000
X-Gm-Features: Aa3M54r2e2mQC9oXfZUC0xenHCX1Mke62gPIWj5cdx9pve6mws6-LqqeGjK_0Qw
Message-ID: <CAFEAcA8+uzpn2HdNQF86_QE3E7jQL9hLvEyUqQKFTf96Tq=U6w@mail.gmail.com>
Subject: Re: [PATCH-for-11.2? 3/3] hw/block/pflash_cfi01: Reject out-of-range
 blk_offset on load
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 18:57, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> A migration stream can set blk_offset beyond the flash storage.
> The write-confirm path would then write past the end of it.
> Check that the pending write block fits in the storage in
> pflash_post_load() and fail the load.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: phudd6 & kietvha1 from Viettel Cyber Security
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4388
> Fixes: 284a7ee2e290 ("hw/pflash: implement update buffer for block writes=
")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/block/pflash_cfi01.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 72c544dee8d2..7975d3578973 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -1028,6 +1028,13 @@ static void postload_update_cb(void *opaque, bool =
running, RunState state)
>  static int pflash_post_load(void *opaque, int version_id)
>  {
>      PFlashCFI01 *pfl =3D opaque;
> +    uint64_t size =3D pfl->sector_len * pfl->nb_blocs;
> +
> +    if (pfl->blk_offset !=3D -1
> +        && (pfl->blk_offset >=3D size
> +            || size - pfl->blk_offset < pfl->writeblock_size)) {
> +        return -EINVAL;
> +    }

I was about to suggest we should check for other negative
values that aren't -1, but it turns out blk_offset is a uint32_t.
Using "-1" seems to be the style in the rest of the file for that
sentinel value, so no objection to adding another use.

(We could I think check more tightly because I believe that
blk_offset is always a multiple of the writeblock_size, but
the check above is enough to avoid an out of range access.)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

