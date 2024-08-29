Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19953C83F27
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 14:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjfpc-0003fJ-HS; Thu, 29 Aug 2024 10:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1sjfpb-0003ep-HK
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 10:08:59 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1sjfpZ-00067c-KB
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 10:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1724940530; x=1725545330; i=deller@gmx.de;
 bh=po+BeAvk1qWDXDStescWLJtEyehZ1Bbho9bMkDl3DbE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=kQC2XX/Fpn+vPYdv0KGyruCeVVoTdFprDbagNSRf9VBtgxNxltNiCBoorFfuUg/W
 YpFO0KLKuL0Zd/sgtrfm119Va2+5zTgT8xqXfBTB4cqYSQUIayWDTAmvML0UupZwT
 FjD7hFDp4txKqNZkRu5hjbCEqJp1j5f7TO/Com2aBDAMY5jdFPOvzEMIQuO/8WVPl
 bSwex6b0xDmMnUp4BO/kEPzFKZ6+SdscbTFDKP7ONM6VJ/m3RYQHO+6vXFRiqByGF
 KJevkMtaLg60Cxp7D8Tl34I89YHuUb1J+eTJ+R1pusd/uSrZvpMSFk0HzwQJPtAwr
 6ZJFDoN8Ac72p3i1MA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.126]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlw7f-1sK02r0gCJ-00kdIa; Thu, 29
 Aug 2024 16:08:50 +0200
Message-ID: <d61755ff-0d63-4865-8050-7fe441798bcf@gmx.de>
Date: Thu, 29 Aug 2024 16:08:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu-hppa-user: crashes immediately in hppa chroot
To: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
References: <Zs9am5fIuo3eXoKF@p100>
 <b8fe65c4-c7ee-4f01-98df-65ff304a3eb2@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <b8fe65c4-c7ee-4f01-98df-65ff304a3eb2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UwXJyCYTGwJvRKeDwtTT8hl6+LNqgQZNYKQjAzefDiRSdl/HGft
 mtSg9pLPyqt1QMD0/O35uY3Fgku9mxh9SUMsir80JCwiOeeIf3wkFTxzJpGbDNYXlkZfIW0
 iRRdJpfaT76oi40xLWkt5AkGqeqOM15zS1UOq/Z/9do25C55AWm8GmGCBiN5khmUxyiEaiH
 9WMCo2sE5nPIlavmabrAw==
UI-OutboundReport: notjunk:1;M01:P0:3L1juzigfaU=;haDSVZiiP0oss0kiqqr0A6dLxhc
 vk1J9bXmai+NGdtV/c+0t6EU4nuXslxQmT8iiZ0wvgDlN1kqNCsGHsV0r4PRJqK0I2yCo/01M
 b300m1VUFjVZ8JdLdArgJ9Y9C7+ob2W/Q5tSavO7DUB5ftNqNUz5uOFwykgD9570l2pWLETsB
 Bx4e4b/Cu0RFiE5AhahRAPSV5AMx29UhfTBh42XaiSHJgYvjb9FLEgGXuFnROemFvatZOikv/
 +klW4hUHSCtPe1kArIKEzWtXRa8RaGGxuojbEs+ZhWfE41MYqyj4Hclqb2YKcVAaFwV2OZAr5
 CWDNmXxPNxJszVXMZvYQc2bVvrcVTx8nRoU2vMVYMkws9OlQrPDAfR574nHuX68SvNVP6QrHv
 nsGaRYscnokBp+//oLaoChBtm73X3qoHqobuut7n2ywtFDFEgtQ8yqL9DKPOg7NZO2b6D5CQw
 LHeIncbNFEg3a/u6ilMt8KZQibT2qs9gP/ucPqfeSfoqXZrxDV1/q1k18BEbZc76WDCtHQwRT
 Xb119rsSWGtXKK1r8gar++cgvkbRZrjubd+mCtcG1/+7FLZJBxFPj3yWa8qN8K1f6NE8w/7yv
 Sd1VENI27yNAGofq/KOHJR5fPG3/EwuAQbMvRY/N8Q2nsTlfiT3WfpbcHaUrA95vWU5hG02K8
 jGtQvGok0vjmOIe8+L4LivMXuJGB8i63A2nDtP+p+YDGliVn+FKNTycj9OZyh2f94qXXkmq3q
 /cs6SaVAVAsPHTnUYWtfZDq1WScVI2GD4HaE0Mkz/TxK1Nco3PR6C2rU8LfVcnFjUaqn0xbUV
 HyIsiPZ71o9t2OPsaj9iiWcA==
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/29/24 04:38, Richard Henderson wrote:
> On 8/29/24 03:12, Helge Deller wrote:
>> Hi Richard,
>>
>> I tested qemu-user from v9.1-rc4 for hppa and noticed that it crashes
>> immediately when starting a hppa chroot.
>>
>> I was able to bisect the segfault back to
>> commit 081a0ed188d8d9d9038f00337d331d185a7ae331
>> Author: Richard Henderson <richard.henderson@linaro.org>
>> Date:=C2=A0=C2=A0 Wed Mar 27 13:04:00 2024 -1000
>> =C2=A0=C2=A0=C2=A0=C2=A0 target/hppa: Do not mask in copy_iaoq_entry
>>
>> This commit does not apply to git head any longer, but when I instead
>> apply this (modified) patch the segfault vanishes:
>>
>> --- a/target/hppa/translate.c
>> +++ b/target/hppa/translate.c
>> @@ -664,6 +664,11 @@ static void copy_iaoq_entry(DisasContext *ctx, TCG=
v_i64 dest,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const DisasIAQE *src)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_addi_i64(dest, src->base ? : cpu=
_iaoq_f, src->disp);
>> +
>> +#if CONFIG_USER_ONLY
>> +=C2=A0=C2=A0=C2=A0 uint64_t mask =3D gva_offset_mask(ctx->tb_flags);
>> +=C2=A0=C2=A0=C2=A0 tcg_gen_andi_i64(dest, dest, mask);
>> +#endif
>> =C2=A0 }
>> Any idea or suggestion to fix it?
>
> More specifics are required.
>
> root@stoup:/opt/chroot/hppa/sid# ./qemu-hppa -L . ./bin/echo foo
> foo

You need to build a static binary of qemu-hppa and register it with binfmt=
.

On x86 debian machine I do (as root user):

modprobe binfmt_misc
echo -1 > /proc/sys/fs/binfmt_misc/qemu-hppa  # temporarily unregister hpp=
a binfmt
mv -f /usr/bin/qemu-hppa-static /usr/bin/qemu-hppa-static.old # save away =
old to be able to copy new
cp build/qemu-hppa     /usr/bin/qemu-hppa-static  # COPY NEW STATIC BINARY=
 IN PLACE (you need to copy yours!)
# register at binfmt:
echo ':qemu-hppa:M::'\
'\x7f\x45\x4c\x46\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\=
x00\x0f:'\
'\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\=
xff\xff:'\
'/usr/bin/qemu-hppa-static:POCF' > /proc/sys/fs/binfmt_misc/register


Then you should be able to chroot into your sid chroot and you should get =
a shell prompt:
chroot /opt/chroot/hppa/sid

With git head this segfaults for me.

Helge

