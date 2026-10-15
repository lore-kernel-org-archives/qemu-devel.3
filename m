Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB07CC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHF4v-0004br-9W; Thu, 15 Oct 2026 02:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xHF4q-0004bh-DI
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:36:32 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xHF4m-0006XC-VN
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:36:30 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b1a86c0316so6092586a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:36:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792046186; cv=none;
 d=google.com; s=arc-20260327;
 b=GNgSI/2yOb/t0oC83UQMk3FUQQM+n495z4ukeN+Xb6VP6/PJsY0nIBkSniUVVyJHTt
 /xRb6Ecxji7o4wzVLJ40Z3AJWW/0zOBtvA9SBAt/s1eQkOF7z3xgLhZOqEs7R2M5Rpsa
 bisUZikmvosWDimXCjYZlSwVAjg0HKUgY721KHpLbHN4ZO99xOGDf7u4fIucmdxt2QNK
 SszB0Uq022rL+MHbDwEvmUHaTt7DeNK79vOBfvoMmz9amz0LK43l1kjwo384205Flqt9
 1nKLb6onvlN+UmevmFh+PnTynggrbxaNb/cWGhUpQUbzx1DpVcTA6ApG/KzvbkEHUFzC
 sUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=jQdr4RoEgY2WXfrQfYBf5fpefg1kMnboDN64ZFYf8us=;
 fh=B4QX2KwFXVvsqEOvhvHh4LNJ8Jo803Dy109fz9W/2Fs=;
 b=Ds6apGkStWQCo3zDdLcYdWMKmDKpm7hToXxXS29LHWwv7/mZMJgg+BBcnbD2t0Hn0O
 16fQf7cGW8WUbmXiYqEG3ST06U0IWw6Uc/sjIfjDiXuirTLyDZkVrM5zXcFkdWUjttzA
 aSm8D/S1hlJis8Dr69xT/ZD/25eau+tKa6fdYxuSPL6mq8rXWJoN5xt2DGm/5xqvxZgn
 SH6A6WS0Eroul+8ZL0cjwWZNGED7qlG0E1Ue+mi/lCCEqpC6IGQJvBZhp5A4EgF/B3Bp
 zyOyTakdbq/BhsigkDExn5OWHU2TFhzUupGoj2dJQfnnviK1vBt/gfydCCljHyA14GcY
 +nlQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792046186; x=1792650986; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jQdr4RoEgY2WXfrQfYBf5fpefg1kMnboDN64ZFYf8us=;
 b=Dly4jpN8fIBe/98qqs/5UtVuAu5FtY7sqkiGgx3gDI1fLedl9rFtytvrjovoExK12I
 1ybWyBp8igN3O+Bqca4Y/o089BtXFdFHcnOkKLpnNEKu1bQs3PzS8rkZjbIA7hv5Xvmw
 s3Cij6YZ5A/anF3WV/t+OSM9vjd1E4/zBDAcK8UhVOYmQQVZHlYaZOXouWRfKYMA8zf5
 rEfbTVqSi14x0/l1bduer3scQkQZWO78VyN55zPuXyvS5+CeaJKpE07ADlLrEiA81Asr
 ynIKtbjxEOP1cHJAi9zqxl6r+dL+XQKMaagBmlqC3DRy4qJyGJhLKWrR6pfSCR8xktq1
 +Bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792046186; x=1792650986;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jQdr4RoEgY2WXfrQfYBf5fpefg1kMnboDN64ZFYf8us=;
 b=ZUu5lxz9sRjwpE4QgE2Uc+za7Ibh7BxU9PQ4vsWl8JDMJx4jWF+EhI8kXA7QjUfIgA
 a0oi6oP0OfnOg00qPzkH9jr1C/cwZ4xUjKNFZ7NrTLCukCW21e/9TF+QF/h67V++1PYQ
 V+I8EFyl5kuZLca4ry0j1n0Muuc6XSADYrxyu/C7bDU7EWg9OVf99EKKn/g1OigcBzJ+
 rclyJNbH7kep/CHGGbrV37Qr0Wxl7zS9aMjsuqYNZ4YEwgVpQXKNR1SB+D0WhfZTuWAC
 hnfAi1arxQf+4DX2BOIKr4/Bdc2ADqB1Qmu71K5dmCgH+SRbJlOlhvEDBtErZ85YqNyq
 4QaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmAc9sLiiqacfnRAr0UK50u5oks7rRQ8aFEIjTXyXzHqvljSON3xkjpAq7YxKjGPD2kfVczSSAyia7@nongnu.org
X-Gm-Message-State: AFq9FYJ5BQCgvBt4wFlAO7XfzoGooMvx4tuyt+wmBHT1q2lHBTKNAzBW
 vPiAEZ6iWLDkqoGvVsJo43/Jq0rUY+YsrN6BWyjEdwvxwPskVhoQSrgnY41LDx5bG7VW82pD3L8
 Yswu1+uiz8Fp5UNvJLiolI+HkPLfeFa4=
X-Gm-Gg: AYBFou0Kk+0ppvV9CswOP7ZF9inN1ntpMODKFTKMqT0TAM/1FAu0Z0OwtkzfqT7fAqa
 82fHl30BEVHtGG8NdEVDM0+k6rruAWF2ceg/mtcUr0o+mp1T9QJ8kIifKWb4D//DwPrbNfIsIpr
 +4MbJASzT+O4xIMSvPuVWNbhyrpzQhWcXDIT8HUVUW0f0C4s9b/pQSCp2Vvv1UqRYj8OZVOYJFa
 JnMHIejZnp34yOeoSDocmh/BavkyzbtylG0OUMxHcSBtZDXAqH61ODU28PJC+GCOHTlX3B+wuAb
 FH5w48yHsFRRf7Pxa8Hxz5jj9Y3KmodHke9l2qG/ZgexPc76SKfcU/5E04oid35I7w==
X-Received: by 2002:a05:6402:11d3:b0:6ac:b85d:10f1 with SMTP id
 4fb4d7f45d1cf-6b17c23e86cmr14654876a12.11.1792046186224; Wed, 14 Oct 2026
 23:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
 <87bj8vbj3u.fsf@pond.sub.org>
 <30dd70d0-a899-43dc-863e-f49128fdc8af@oss.qualcomm.com>
In-Reply-To: <30dd70d0-a899-43dc-863e-f49128fdc8af@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 15 Oct 2026 14:36:14 +0800
X-Gm-Features: AclHuK_x9ONhOU7awkbYHS57wianz7pvvFbbubYMW7FJ3oP0iXtmST0nSZsJ7EM
Message-ID: <CAE2XoE8Ob9UNFFer6VFTqfqfwYfH447iZJbe8ag3cBoX+1-EQw@mail.gmail.com>
Subject: Re: [PATCH 0/8] multi-target: remove qmp_query_cpu_definitions
 duplication
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x531.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 15, 2026 at 2:14=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/14/26 10:58 PM, Markus Armbruster wrote:
> > Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> >
> >> This series allows to link multiple targets that define
> >> qmp_query_cpu_definitions. It simply replaces the duplicated definitio=
ns with
> >> target-specific ones and a single dispatcher. We didn't use yet the di=
spatcher
> >> pattern, and it's the first situation where it appears to be a good fi=
t.
> >>
> >> A possible alternative would be to introduce this callback directly at
> >> target-info level, which I think is a less desirable solution, since i=
t would
> >> ties this API to monitor.
> >
> > I'm curious... why would such a tie be undesirable?
> >
>
> We have a unique definition of target-info for all targets
> (https://gitlab.com/qemu-project/qemu/-/blob/master/target-info-def.c),
> which is simple and nice.
>
> We could consider adding callbacks in this "generic" file only if they
> are implemented for all targets, but as we can see in this series, only
> a few targets implement this. It would be more boilerplate for the same
> result.

I personally think we can call it "generic" if three or more targets
are implemented, otherwise it's too restricted. And also get it hard if
new targets want to leverage/implement it.


Anyway, this series is still fine, I have no objection, just some points.

>
> IMHO the two concerned functions (qmp_query_cpu*) look more like an
> exception than a proper rule. dump functions (posted in another series)
> are more related to cpu, and not to target themselves.
>
> I would happy to revisit this if community prefers to go in a different
> direction though.
>
> >> If the approach here is accepted, I'll extend this series with
> >> qmp_query_cpu_model_expansion which follows the same pattern.
> >> With this, we'll be free to link together almost all the base architec=
tures.
> >
> > Series
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> >
>
> Regards,
> Pierrick
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

