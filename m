Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE2CC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 00:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weitx-0001mX-18; Tue, 30 Jun 2026 20:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1wehWx-0006tV-Ph
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 19:06:15 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shankerwangmiao@gmail.com>)
 id 1wehWw-000236-7P
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 19:06:15 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2c9c49c28f8so77775ad.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 16:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782860773; x=1783465573; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ss9dGaW1wP6RF2P19SXGB3OdcXjjt9bWJHXzsalAu60=;
 b=pwlR9nb5o//kRkfpZT5OtA8h91wSj/8rxYUmUOJW14Uou3xqdWRtzirwPnuuwbHd2K
 ytYMJBnYpKuw8uhcpfW6nDGOrSST9OuF4zBkCLMlb6wxb5c4bTBUdB+07fsGJt1y7je1
 eGEJ1VF/l00KlgxnPoXChwmAWUw2NIu7Ihqz1UKcyzOYk62PmYyoU54f9QC4w9zeq1T5
 DUsTBpWtRJK57suur1x9mNxETTLsEKhq9276puSh9LW7QuZxwzcwBtdIZbAw44mDvira
 WxV+1bEQf6gGNxpDGcuGQg3n5Y4NsJOzC2AQ13QYY2+Cip3epDAErbBln+d4VdG5qzN9
 eoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782860773; x=1783465573;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ss9dGaW1wP6RF2P19SXGB3OdcXjjt9bWJHXzsalAu60=;
 b=Fr2XCgWZyvYBzLUNs1pJxMLOukkpBlvbNJbWYOUzBMnIDSpiiKSkzF3vkuEwZ0iQqK
 NAQKXnmzgTWqpn7APE3O2lmt+dYdXIJnjhSwm86awG2n4LAdYu58Iz+FKt8Qeskqyn2z
 2aIR45/zAO6xybVOSmcLZwgsb6gS7nkuE4XxCuaEV1EcDrVvoXz+P2aTa/9HBiL71Qad
 6MUwf8hA6sWw+o9CIfwpGIm/Rb1Qg32+agW1DxKbPBQGXa4wsqHGKkfVu6BBAvh3AdCi
 JyLxzUsnOdN/LhJuAkTl41U0g27neIakevEfOe4ZYCgx/Fy5eJhlvJmnrTRpkZZgIH5W
 Ky3Q==
X-Gm-Message-State: AOJu0Yz+Ai6XYX6YwLVBF5Sg2JUomGl1SokkF2N0m1k6+zwE9+nTEkNv
 i25uaVq7A1rQMH1CjlGW6UGo4TnmrU0mZVzqLmnRZi1E2v4PTOTGR0VL
X-Gm-Gg: AfdE7cm+UeYZUpUK3wRbboh3SkZvOXFlxOdZTkhEOIEXER83xdfCJ8oBh6E3ytfHgbg
 e0c2bKmIR4ie0NC6MjGRfKGM1SeL03Cm6HggFH43J4Yh/cilrIO6MGi/HmremSPIoaI9mcfEzki
 KJUKB9Uc5QlHuf/wd5DhvoN92dBVt1+/MQPMnCZsRouJep2mxvoO3J7847cz5ZEfRT3I0SVj8ZV
 lGyxLOiBM4jpqoHzJq/YRuFacxtXO8QzmelmEVCJNMfGm7N5yPNOFw5+yoADNViH21NFRWcEsZp
 94NvvWfRumycGpnHXRIZ9UzaPtAtpsXcLaigBUAk6xFmnwPnQ9QEej8mF89v37QhsbI/9VGnr/b
 1dqD7QQ41D95zvtclfKyRx14QJqrcoxXX9FTdO04LQag0Oug7p34COmueu5fyWb2wYPC1FUi9Eh
 yuZNirLdz5CbZhn7ldlVkQDGnkMPIaJ7ntZw==
X-Received: by 2002:a17:902:eccc:b0:2c9:ffc2:dffa with SMTP id
 d9443c01a7336-2ca2ea29009mr24626615ad.6.1782860772315; 
 Tue, 30 Jun 2026 16:06:12 -0700 (PDT)
Received: from smtpclient.apple ([2406:4440:0:105::41:a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca382b5175sm21415465ad.63.2026.06.30.16.06.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jun 2026 16:06:11 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH 1/6] target/loongarch: make VReg aligned to 16 bytes
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <2d93e964-29d1-4ebc-a128-5dd265fe527e@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 07:05:57 +0800
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D5196EBA-39D2-498D-9FD3-A9AA1499FFAB@gmail.com>
References: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
 <20260701-loong64-be-v1-1-9c7d65e00697@gmail.com>
 <2d93e964-29d1-4ebc-a128-5dd265fe527e@oss.qualcomm.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=shankerwangmiao@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 30 Jun 2026 20:34:01 -0400
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

Hi,

> 2026=E5=B9=B47=E6=9C=881=E6=97=A5 06:41=EF=BC=8CPhilippe =
Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi,
>=20
> On 1/7/26 00:15, Miao Wang via B4 Relay wrote:
>> From: Miao Wang <shankerwangmiao@gmail.com>
>> When tcg_gen_gvec_* functions are used to operate on 128-bit
>> vector registers, the registers are required to be aligned
>> to 16 bytes. On some platforms, such as s390x, __int128 is
>> not aligned to 16 bytes, which will break the requirement
>> and make tcg_gen_gvec_* functions operate on only 64 bits.
>> Explicitly use aligned 128-bit integer to fix this.
>> Fixes: 008a3b1662b6 ("target/loongarch: Add LASX data support")
>=20
> IIUC that would be 16f5396cec2 ("target/loongarch: Add LSX data
> type VReg") with the first trigger in 57b4f1ac188 ("target/loongarch:
> Implement vadd/vsub").

Yes, I agree with you on 16f5396cec2, but I think the first trigger
should be 2d5f950c054b ("target/loongarch: Implement vaddw/vsubw"),
since in 57b4f1ac188, the 128-bit add/sub is implemented by first
reading the 128 bit value in two 64 bit halves and storing the
result as two 64 bit halves, which does not require the registers
are 128-bit aligned. 2d5f950c054b is where MO_128 is first used
with tcg_gen_gvec.

>> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
>> ---
>>  target/loongarch/cpu.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>> index =
ad30c73167ecf6d8dc6faa8c6a18c212fe4fce55..d3eb35953abb87dfb34b8f3340f8dfd8=
3264a484 100644
>> --- a/target/loongarch/cpu.h
>> +++ b/target/loongarch/cpu.h
>> @@ -275,7 +275,7 @@ typedef union VReg {
>>      uint16_t UH[LASX_LEN / 16];
>>      uint32_t UW[LASX_LEN / 32];
>>      uint64_t UD[LASX_LEN / 64];
>> -    Int128   Q[LASX_LEN / 128];
>> +    Int128Aligned   Q[LASX_LEN / 128];
>>  } VReg;
>=20
> QEMU_ALIGNED(128) on the whole struct instead?

Ack

>>    typedef union fpr_t fpr_t;


Cheers,

Miao Wang


