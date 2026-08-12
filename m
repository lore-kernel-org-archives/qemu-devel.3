Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162FAC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 16:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuByx-0002tt-9P; Wed, 12 Aug 2026 12:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wuByu-0002th-Ov
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:39:09 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wuByr-0005X6-FH
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 12:39:08 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-39f9d4bed90so750611fa.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 09:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786552743; cv=none;
 d=google.com; s=arc-20260327;
 b=HgpzLV9tEK9hd/IA1jI1vJsg5quSYkV/WlfOxfaqVPc9q1OiO2rq2rScmBSq2ScGUm
 nlsUhKdRZth6BRjHybN161RLPbuaADV2S7fMghRlHjrjPKY2FKd8u6xgbbQ+K9cIr10T
 ZemcYrWklz9m1mMeSzhf60h7Oha9CwrMj6llxsFqdUKKZ8o9t3M3hyAqHtGy4VAHnchi
 PD7AhOxTI07DTSi8iDQhsQjIpnv0fxA+aHghCRtH5XdlPZvbLwQSD0rGxpa6hKXaETOV
 g37fgCcYCtHYGEsjrIOdKQQc8mzCbN66QOWe1r3SNigcCoGav1fmtJ02NZBdSxzzOt4/
 uphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZMtepMRHBTAhSbOtOZZC2Dqkj89q/cnHC5zjcgMNH4w=;
 fh=YYFlP8b5nG0xp43ekYQGYSQr9uembBeNxJ16OtaRW/0=;
 b=sIdDWBRloz5EeqaTCgTR3bvtMTvVr1of7+D+YDONb0FrBXVJh1lnQyi1wm5pi+Tp1r
 lGsuY/VlQALCu4vbWLTI5OGBREB1sZcbIkbj2Fv94dzCm0i5JZD6Kbv77XDN0dJ8hsoQ
 ZAn+5jZJBn4/p2CWxMekfH4aeszaWOO2PNtBcYueEIV/nAl29yYQPC7HyFDgUp1zmt1B
 Tv4yCYkyKtMEimCOgltu/AXIt10ye2Bp/2unkc6C5/ZF6k93KKSafK40IEgJSGpVd+mU
 5DeuLnfDu+RBAabtZ8RJrRO72CKhGru1HU+pCMVSjNiQEYddGUSTrlj+i247l2lawDSJ
 7IXg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786552743; x=1787157543; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZMtepMRHBTAhSbOtOZZC2Dqkj89q/cnHC5zjcgMNH4w=;
 b=j3qr/QsAebUqw5DAn20KaX2df74Fp5kdjdajzzZcrI16uViKBftJ7CSbyTSxEZggRT
 MNVT0bGbq6JiAE/YuTnpoAzB1o3zuXY+1Ozqfq+VnahFC1SejdKI7LqJ3o6NVMvGBq1S
 cqOewIaczSfpq2SIrPNdH98FhyPxUamiYv1PkYikG3s3/Lqes/9ftXdceePreWqzYnuQ
 CF+jV55nE+KOVkhVL9CZ8wtw9JqIa4pLnE4tpx5dpq0MeQ3R0BrctfWkJ/VKFXoVleWw
 yfMVdxCWNVcf/WWvPlq+12Y5xF4wTHRT9jvV2nOxXthR+vgXRLp+o2d+UJ7FnELwloTa
 w7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786552743; x=1787157543;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZMtepMRHBTAhSbOtOZZC2Dqkj89q/cnHC5zjcgMNH4w=;
 b=HoVIoC7L+vUli4IxHxm/CUBLhfjec0O7/+BNaQvVA899xTVXRR0FW4jzkrnbluLPU/
 B+GhOqAv/Tnc00jjN8Fy2uMmF4h/ZoFLkIhSf2y+mVYM3akGJv2DkSq4JvISPv+8W8iC
 VgeCdLTKd0rEUJGDv4/oJyw/Fc3jausNjdMDzZ0B5laZ4WPJ9y3rdKicBP68iAkuRoyT
 v5EdmuaAGT7A/kCVnH4bF/PrewQiac8h5gjkV4jP7e0tc8NL+vHbwXnw0vEyFWol0r/n
 GQiJ37wu5GaNN6e2SCiqfdePIzWVQrS1Si+AK8388sZ8tYXYR0bulq9AYgYjnH5JUaSV
 uPHg==
X-Gm-Message-State: AOJu0YwLhNk3QQ61+kF0sS2jYeu88gXe0IVLVhjVAkGmO0JHDa/1BKzu
 keTE8PfPjhikXRY51k1ASnfHu/V+u9qgQNJToTAAWhi/v5ArDZ1kWLlU7qUcmjCyK/YD6y+WuvS
 iwvjB9qYmwPaZgKOQNSsQ/QMKoU+27+g=
X-Gm-Gg: AR+sD131GR2Mbr8TDaFu2GLxqPjZeBFAkSrEtH5wySryVbxLIwL7e3Z38o+ozF87R7q
 0FEMsDTuIt5wAg/kxD3rmBDre4LyKMxSTLE3mxa7tOfP8IqtCgQjMFd/uYA7gdgwCZ19I7469T1
 3tp4mCYM0gavbYKf5P1mEERqMe9cz3s1eYUTUuVNU3YjR6BruvO28Or43FrjXm38w/b7ui/5mcM
 BQdv1KsoCQjEwdxjJMBwkJ0h7C39r5EKDySlJ8cQm/dz+xK9xqLyaFowGAPLW9V8KqUCcJzc3Z/
 tpI5PayZitRZtmor6QLvzyLMTIwm5Sv51H0wxG2HQoaeCcZ0OLK/ZNZdJhvN6zh8fPce6hOwsc7
 a
X-Received: by 2002:a05:6512:687:b0:5ae:a500:e368 with SMTP id
 2adb3069b0e04-5b45317e4ddmr115107e87.3.1786552742582; Wed, 12 Aug 2026
 09:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
 <anogKPQgWvLLjOH3@x1.local>
In-Reply-To: <anogKPQgWvLLjOH3@x1.local>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Wed, 12 Aug 2026 22:08:50 +0530
X-Gm-Features: AUfX_mxUJM_WyMdQNBlx9Me0xhGj1WaX2wjfCV-aqiGkCrlUjdvFTTwABKNdkpE
Message-ID: <CA++cPvJwQt0te1WLY1Aia77USnjuxOTDCE5R=d=sSvgr0CNEBg@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] migration: fast snapshot load
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com, 
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com, 
 pierrick.bouvier@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=aadeshveer07@gmail.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Hi Peter,

Thanks for trying it out. I will take care of the disabling migration
in the next version. I have replied to the page size issue in
corresponding mail.

Thank you,
Aadeshveer Singh


On Tue, Aug 11, 2026 at 12:32=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Sat, Aug 01, 2026 at 08:06:17AM +0530, Aadeshveer Singh wrote:
> > This series implements a "fast snapshot load" mechanism to
> > significantly reduce the perceived resume time of a VM from a snapshot
> > file.
>
> I gave this one a quick shot, it ran all fine here.  It's a bit of a pity
> that I still almost need to rely on postcopy-blocktime to get some more
> info out of the async load process.. but I think it's still OK.
>
> One other issue I found though, after applying this patch, QEMU will also
> allow me to use QMP/HMP "migrate" (rather than "migrate_incoming") comman=
d
> when both postcopy and mapped-ram are enabled, which will ultimately lead=
s
> to an error:
>
> (qemu) info migrate
> Status:                 failed (Unable to read from file: Bad file descri=
ptor)
>
> What we can do is to disable it for qmp_migrate(), e.g.  migrate_prepare(=
)
> can bail out for outgoing migrations of such setup.
>
> Other than that (and the page size issue I raised in the separate email),
> I think it's ready.
>
> Thanks,
>
> --
> Peter Xu
>

