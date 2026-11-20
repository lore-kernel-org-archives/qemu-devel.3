Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85185606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PdB3hwFS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUP0v-0004Hm-Vq; Fri, 20 Nov 2026 08:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowangio@gmail.com>)
 id 1xUHGc-0003ha-HH
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 00:34:34 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jasowangio@gmail.com>)
 id 1xUHGa-0002NC-T9
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 00:34:34 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c50abd5b4fcso73907266b.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:34:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795152859; cv=none;
 d=google.com; s=arc-20260327;
 b=a54m4w8hk3rKwgR/mdPtMmOZCf3MzB/In/7HobqOVE7tPTAuEOQGcyGZCzb59NeCzP
 eepn494b9v6RlJ8Wep7Kit0gimCOaI995zWhK2/t2uHKToBU4KvyW7ig3HwWS2JXWmQZ
 cG/JXerT+xg8gei81y3yx7ULShdl1eP5d7c/QcVrwRP1i6yWlHiG2Atg8BVc0ao5whVI
 fpFi6aFwxQxD5lqk7V5R2OSMiMj877OOkPxV6+CRCYMUE2bLfK98rU7957fi82jJdfSR
 bRR2U+O9M/EfAl+N7PXssm369QZAm89wyQy7jpZPqVm+EHqS5CrZjaaHk+9sZ/xfXMTs
 n74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nXlcVNIxUXz7dFB4G2Vpxq9dLGn/TGRDkIssgEDFT5M=;
 fh=f8TXMtjFdlQaMuFXomXdRCIa0SeiMGCStmKGVCOn5Ag=;
 b=aKnQXxaiZ6YQblnLA7K/T1FfQb4yTtYZ9zi5RBVyHIO/dVEsZjWiGaFaF55g5E122q
 2CeXTU/2ShO9hKNjAkZUTcaqGORbD8kS30z6Rzm8+uxJ0tesc7fxpGAMtZQ19sWUF0xw
 mTIXYALKQeBQNmyLtC87xeXUcsWCnFsnxpBqEgXdxNJOnd09khlplTApHnc1cPr9k1nb
 rljtQmNOEcGWZyNsbNAPYCxVz1j4kKbjEbBv0VCXyzui1Px030nuPjP1OA2GYmSTCutW
 JVS+DZksUwFztOlQryJJyWdc6I8MQoleCnb31jdsoMN8cXeF1ZP3hNVvQrSph+B9KZHU
 AkuQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795152859; x=1795757659; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nXlcVNIxUXz7dFB4G2Vpxq9dLGn/TGRDkIssgEDFT5M=;
 b=PdB3hwFSzRaUhWbwvT/P1B85GvL0TqvP0+Ol/ATN400ScxWaJkXHiSO1liah0FPp7a
 SHy//3v75jU/kt9KlNadhuV4VQRnuW8l/oaD4DslCuugAkj84ozjrwQizmRBDKAN0Vln
 0F+ANDQAo5JgiR8QsyJM8unhncYVUPZyEGfnw2FqtXIWVLoodwcQ9pju6y63S8TI1fUQ
 jS4jqaCat0ZgVW06u/U325mMMFxftaFbWuGkq13nUS3eFJQn8CdSpiPLVhm+rIK+1eGV
 R4nqWWTsVfihGBylMyVszD1gFdxbbHEhJWZ2tlZQ1QYBFi25OiG+aV1YEZJoUqlwFQxN
 leQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795152859; x=1795757659;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nXlcVNIxUXz7dFB4G2Vpxq9dLGn/TGRDkIssgEDFT5M=;
 b=QpgXqNTdvzP+mj1I9Bk7O2hsQBB0kVenOTRzyqMbgUUCGs2S6+8CgH7/DARGbtOyfB
 fvcFupx3ddZcwX7No9pJxs48/5S/Lk1eHmI569bjHEb5eNfug6GSdeU6PkqI3LQ+PrVj
 brxYLysVpz5D+yGoE1xbO8QNkvNi7RgwfhQURszTcHMCOsSmVpOlGERAIP8KHmVwya0x
 J5txMCSPH4WruthsPO+z4WCAUuc8LQS2W9aiXcLmkITDgwmkTs0Pieg6plY1YY5MM5Xp
 3rY7V1On7aJ5QOtQo/hnztWxwr597rpVyngpjP6UhlJZWq0jy9nDS6g3Ez7I4FcubGT3
 00rw==
X-Forwarded-Encrypted: i=1;
 AL+hErGpRbW+9yGm5lfQWvFoAFjyyz90kTxthXm0hCjmloQ9XBQxOBli2Al/0jkkeSOaQG4NOAPnWzq5ncvh@nongnu.org
X-Gm-Message-State: APuU4Z+xduZ9h75/5zlj41ZivtFFNFL/wuHdwY/JQeXQnyPi2Sl3VV3L
 1JJnwdKudWZ4MXA1jjd/9ogSMl7R54qpXLZ/ORxQRJEn9N6Ha4f+LyEAtsxoItZVWEdp02cwc8Z
 aCLSqfiAgm41JJ3ygICIlxmuEwiNi4Ac=
X-Gm-Gg: AYBFou0i5Py+KYm2NlxXSf9dNUTQKQr7kztKMKv0+2JhYovvGL6YGHHiyCp8eWVELMw
 8Gu87aR7s8dD6Pk5ouIS+NKQ0cCmthsABJFu0RCr3en4fVC+dnT4SsxyRSYJ+GrLuX9fJWtvgZH
 Qk7v3tPCoA8qFv/ek8BhQ/AtrXjq7iDjkWMUvXp7lhacmExF4wZ5Z2bbAjwX7H7pKYWw4zf9NXH
 eGWFzO5w6nOm20SqFMdnZhUSRqSSEVNKoAuwSSzPIS31RO66MiHzArLZ8t1UoyE/cosnSxgUXSp
 +EojOxG3qLO6PvVUv0PwlWXcrS/znEMG8SrKRiirPrqazNcSPz4tAucqTIUHkWq5x6dqVC27bjk
 gapNS1eYisL98She5neI4ziBpcnxoPqri//34cFi5KtYBSgVjSd5d9fajdpeShGMJ0yA=
X-Received: by 2002:a17:906:f583:b0:c51:3c8f:55e8 with SMTP id
 a640c23a62f3a-c513c8f658dmr134344266b.46.1795152859014; Thu, 19 Nov 2026
 21:34:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117014128.600675-1-gaochengbo@bosc.ac.cn>
In-Reply-To: <20261117014128.600675-1-gaochengbo@bosc.ac.cn>
From: Jason Wang <jasowangio@gmail.com>
Date: Fri, 20 Nov 2026 13:34:06 +0800
X-Gm-Features: Aa3M54plnkl8HkU-2y3ytP-F3pPgmKZjw1Qo95wgcttk8BjPy3RUp02ELxFiw98
Message-ID: <CAAf7B_MwWBBvq_AtvK-cwhnvjVdANToBvE5z+KPcSN6Cp=5--g@mail.gmail.com>
Subject: Re: [PATCH v1] hw/net/e1000e: Account for current descriptor data
 when appending FCS
To: Chengbo Gao <gaochengbo@bosc.ac.cn>
Cc: dmitry.fleytman@gmail.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 qemu-devel@nongnu.org, guoyaxing@bosc.ac.cn, wangran@bosc.ac.cn, 
 majiuyue@bosc.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=jasowangio@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Nov 2026 08:50:48 -0500
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 9:41=E2=80=AFAM Chengbo Gao <gaochengbo@bosc.ac.cn>=
 wrote:
>
> The FCS append condition checks desc_offset before it is updated with
> the payload copied into the current descriptor. This causes FCS bytes
> to be placed in a separate descriptor even when the current buffer has
> enough space.
>
> With KEEP_CRC enabled, the DPDK em non-scattered receive path subtracts
> four bytes from the first descriptor's length, truncating a 98-byte
> ICMP frame to 94 bytes.
>
> Include desc_size in both the FCS append condition and the remaining
> length calculation so that FCS is appended to the current descriptor
> when space permits.
>
> Signed-off-by: Chengbo Gao <gaochengbo@bosc.ac.cn>
> ---
>  hw/net/e1000e_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index b87a9f167a..6a01481e22 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -1601,7 +1601,8 @@ e1000e_write_packet_to_guest(E1000ECore *core, stru=
ct NetRxPkt *pkt,
>              }
>
>              if (rx_desc_buf_size &&
> -                desc_offset >=3D size && desc_offset < total_size) {
> +                desc_offset + desc_size >=3D size &&
> +                desc_offset + desc_size < total_size) {
>                  /*
>                   * We are in the last 4 bytes corresponding to the FCS c=
hecksum.
>                   * We only ever write zeroes here (unlike the hardware).
> @@ -1609,7 +1610,7 @@ e1000e_write_packet_to_guest(E1000ECore *core, stru=
ct NetRxPkt *pkt,
>                  static const uint32_t fcs_pad;
>                  /* Amount of space for the trailing checksum */
>                  size_t fcs_len =3D MIN(rx_desc_buf_size,
> -                                     total_size - desc_offset);
> +                                    total_size - (desc_offset + desc_siz=
e));
>                  e1000e_write_payload_frag_to_rx_buffers(core, ba, &basta=
te,
>                                                          (const char *)&f=
cs_pad,
>                                                          fcs_len);
> --
> 2.43.0
>

Queued.

Thanks

