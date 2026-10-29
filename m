Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8D2606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KxtBsL5c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMKaD-0006xn-CS; Thu, 29 Oct 2026 03:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xMKZK-0006sO-0K
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 03:29:04 -0400
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xMKZH-0000xv-E5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 03:29:01 -0400
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso1014910eec.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:28:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793258934; cv=none;
 d=google.com; s=arc-20260327;
 b=cV0mSUQFr4if5JnWQT23pY8GLvldM1AdIrTyoO2WDLNoSYPgk4aFaRX4D8PN0KXrov
 JiRjp93QUkqWHJwnB6388YsE6y6vH/jL/gL5Gi1xRi0FwQa96Eg9plN2RviTN5BzmBf8
 wYGgXQzMUcdAT2gUhsRsS9Hs/fVuOi4KDGr8PBbEczxzOX9Zhb4Y36gsWkCmXJtlLRGv
 hM7Tj5GSB9UXylGfv4k6CuTZB+BjVPLd1C4m2ZU7gnvjIPiDtZ7II9DVj3qXClnn6LBU
 TbRudfls+rwH/hUkuNS78LjiU1whrfGaCFhLLn7ri/34nVPJ0TUEQB/jVqVuyGselF6F
 lndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eo8hPxsvdDg879uDKM8KiBgf7tWS1lmd7toGk8Rmhxg=;
 fh=DwcTdZ9Che+4s5719rvtO3JN6AeQL93qKfg0zCnplLU=;
 b=E5TP/ORy6wvX5r1kotmUgnbXSTwxSLoZ+ey0ARVge9MzvNSaeqZzSKmC98vGAXtHRj
 22I7h88XbXUus7hUamytC2Iw0UD6EGxWdDcAbkJnSILr9fHwIuIStGMjpO5QiXzJOCn0
 ERM72iHQfy3pFxC95ugWjdzclvwAuSEQ4XcnW8xK3LXWA2jwjwk0acv/p050IrdC0O7l
 7ZbRHEUqzNQCFwbM5jZugqTTZz5jm878UiqmE8Zc36HnLoqe8uprIS4gn5lHYhfWUWeO
 tV+8tCgcaakjZbZ3jM1Hqg2lfCVkme1Nl+9X7o/osVnGIwQFCj90BdRMC6XgXjuLwcy3
 TYYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793258934; x=1793863734; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eo8hPxsvdDg879uDKM8KiBgf7tWS1lmd7toGk8Rmhxg=;
 b=KxtBsL5c+61mQa3Mj+1eFQWpvOVifubNjHIhC5m9K9KqiUypZsSgqymQ1T5ZG2jYIT
 KMN08+fDkN4n70Xs1RrKMZzUW7wIRCxSm8hV/xBzShMeWgRipXf817147WSh2ea/Ju4Q
 JdbysR2yngniCol0Yy3x8thnRAMLxrCfG8T1cwXAFE86pdNxwpJJjzrllynMRV4Mys+O
 r91mZ6z2f/ujr5G3lidl0ARQLBeNjTWV9amBLn9wtVYJqIjzU8yOCAzS4vYmdcIY4gcr
 OD4ZowM1kPaM34ox6nmL0fdx+wdmV38fSN3dpexCa6sq1Ehf8/gj45GA+1MEZEpPYgHi
 C2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793258934; x=1793863734;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eo8hPxsvdDg879uDKM8KiBgf7tWS1lmd7toGk8Rmhxg=;
 b=Ny4UYC5g0biTO2Mkts6NK2Cy5M/5QRRTFLUN+C6ztjP+rFfZPEWpLDI5dfFPVOswmG
 dtihXpSzE8e4LzG6Eb0ahxYS0RqQC1UYIIlRMrQfZaAALiGsVNXX57pY+hn39GhmPVvS
 y93DlE1GGkkViQwB0h0d4SfhnIOq+LbsT6eI6apz7AVSpVrdDv7LAI4/z1XwwobY7+jK
 Jr/GT9GwW9UM/czl7l/FpGigPVBbi5CPYtJss+vRiiQ85OEsYrm/yYOi8TePSOCt6saJ
 MFSY3OFdCNdeXLV30Pazd0Wp1BWGr0YQ6gjCgkpF5SvdlS7QeFwPC+Z8rrySwwEsIKfD
 2doQ==
X-Gm-Message-State: AFq9FYKNqz9WpyS39smBzR/FJOxRohpsnNa12DcSXyPhdeXioyPrrTIp
 uF16RzKXQ9MoHvEIQJRQePcp3H9gKm33gdikF//XS8I4+H6stShirqOD4f+RQlHuEfYanMnapRt
 fHwYknjqVNa3xgNMyIS+6+lIeMRzlFmg=
X-Gm-Gg: AYBFou0d+D8kbWU03MI9r209kRcd+wbjcYOHFbAv3stc3ZYkW+Mk5YZCNO8s/+hwQFJ
 nQN26b8sn4RBGvguwa1h0vqHRBsamAi3g0zxS4UDOIh3f9oULh2BftmI6RGJ/vmBp0zrSrqXOp7
 JUVOothiSQAyqkH5HZNy9l25Xttxz95MtRTnh8JfCORzN2sdFKu14/WaH1kBEn68KjnMv6Ec7Dz
 0czHoVVolmSDnroRvN+Y9SBfPeRxrWMPJK7Fv2STNH21HITwT3uSQJyCP7hVEHZ7FLJBkh8jaYf
 hObJ5HNxek5nloJSA6jDEh9Kn6lYpyaUaZi8kBiSdXPnB7rb4Sy04G56Wfy+upQq98dp2KRzn7O
 NOUP+/KBXxfvqi4YZLvodPLK589JgBZIAnJws7Kk6WB9706g+U0aMGAeUxGvXcECIdEazeuHu7l
 92WND2wxlzAHc92g==
X-Received: by 2002:a05:693c:87d0:10b0:347:8d01:164f with SMTP id
 5a478bee46e88-36a203ceca6mr7048141eec.19.1793258933779; Thu, 29 Oct 2026
 00:28:53 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029070521.1170540-1-armbru@redhat.com>
In-Reply-To: <20261029070521.1170540-1-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 29 Oct 2026 11:28:41 +0400
X-Gm-Features: AclHuK_h-10lyPpGwAtMqDkiZynkV4N-e32ZBYNkd4-VlgXxcM0s330SXk2Zy5Q
Message-ID: <CAJ+F1CJgAiEyM1r5R0DMbvzYo-bvRojCM0CPqQsYVEGE1RZF6w@mail.gmail.com>
Subject: Re: [PATCH] hw/audio/intel-hda: Belatedly update comment for removal
 of -soundhw
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com, 
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1331;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 11:05=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> Comment is stale since commit 039a68373c4 (introduce -audio as a
> replacement for -soundhw).
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/audio/intel-hda.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
> index 3d361a4976..431deb2211 100644
> --- a/hw/audio/intel-hda.c
> +++ b/hw/audio/intel-hda.c
> @@ -1303,8 +1303,8 @@ static const TypeInfo hda_codec_device_type_info =
=3D {
>  };
>
>  /*
> - * create intel hda controller with codec attached to it,
> - * so '-soundhw hda' works.
> + * Create intel hda controller with codec attached to it,
> + * so '-audio model=3Dhda' works.
>   */
>  static void intel_hda_and_codec_init(const char *audiodev)
>  {
> --
> 2.55.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

