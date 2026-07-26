Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260C7C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 17:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo32V-00068p-5J; Sun, 26 Jul 2026 13:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wo32T-00068O-0d
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 13:53:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wo32R-0002hI-HY
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 13:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785088402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIi4J1lETdJXnYiMKEJJBoPZhci+fIKHPnY2NG53otA=;
 b=QxqMC+IQfp9WXtshhSehozTDaBSV5bfPBTssJ1QKfG6W0N3OtUnH1P2cbWl4hJdunUaDLH
 NWGqZQqrsl4tdghBIzvUMEGLurYsXMEMJ6DiyE6WJ7FoHxUvglBZyrxwXahHO+aH3Ct/Yf
 IeoDpOU0Koi6yC5O8895dHKcp9Hs5pw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-Zr4urT9ePyOviCne02CSbA-1; Sun, 26 Jul 2026 13:53:18 -0400
X-MC-Unique: Zr4urT9ePyOviCne02CSbA-1
X-Mimecast-MFC-AGG-ID: Zr4urT9ePyOviCne02CSbA_1785088398
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84842381150so3366623b3a.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 10:53:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785088398; cv=none;
 d=google.com; s=arc-20260327;
 b=Tta7xB2jESJZfUnQMt+Iht5OPaUNEFkeLeuIHaPYQGYFpWHm5qERUurD+nSjGwy6Kq
 HgUpD+yFrSTbHjin0jR81ArAl5e75OXksbaUyqxNHERYSjC3KCumBVf8opvY2chugesh
 V+RT56+SGgLayZRr2gS5Vvx3417p0xcHw5GQXPJGB7yqvYn1pDizNSCQQzzfNPUNoRE6
 1gcq7zYBNJK8HZJ08cB6rWyS9Ha1z9nym5LF/OTGVV5ukgNUmnYuv7Jc1FwB/S+3Sdgo
 3Qn0yNgA3rDnHnEEGoqRs5W4odfGzoLJfm4Px2TlAFR1drVlqG7pJef6zIrDcxxSnvtb
 UGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jIi4J1lETdJXnYiMKEJJBoPZhci+fIKHPnY2NG53otA=;
 fh=H43sBeeAJt7YELhQKIaki7qmlCjYtNabp1Cv/0P75oA=;
 b=rfAiqFtk7cuC3V5jgcgvYrfIHpu/3YNM8tkxL9yBGMIPuJmLYG8ayiE60pdOh297f3
 1AAVKahkt6JnGyXzZLP3dwzug3UHPfZ5D96ET11SMew+B96unrtT2jrLcwHJwB6fhdmu
 TTAos32FFi9dVPD9CQ/vCbNVZjlQsGg99kQ/f5rQH/0tGNOSRqJBqt4+KLlxm7ooWTmR
 nJA1c/ZKOonYp1KmhOzudPPYawsbArV1YLLnpJiQoLzEJqATu9Z+tUug0uMZxVka+/XX
 MGGUERC6Eb/wJL6Sza8AP+ZTiV3t4n38r3nEl2PyHDK/Xoaf4vINSM3b8ejTGY9ceQSD
 W8Dw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785088398; x=1785693198; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jIi4J1lETdJXnYiMKEJJBoPZhci+fIKHPnY2NG53otA=;
 b=V3A8ONicnDCjPcdAD2xIRDMytStD8c2NFpK4oVQCNvm1HVhB8a7lp3IEme/29c8MLf
 ulWd3yMxMpUE57TMrmqdyC1IzPNW2iDxpQYML0iChFnJPY1Jg0EjFSOC0VEYQYSulHSG
 FrWd+af/+vkOm1YWbpK5/0wcKSBWFLSHzlGJ+TQX1D/9xzBtj/0NgKTmSsT+9TFhavLA
 vL49qpI/YEbP8NQi+DInrme9zdBe9dpySqd6a/Yk53lcmt6CuqGTN+hvvRBI0aHOyKcX
 N+zqzehroSi2ieWsJ0Tq5Z5deLS/V56n8WB5Kf4287lr8j8PVtv9ZFUGYhvwMGkHaf0q
 s4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785088398; x=1785693198;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jIi4J1lETdJXnYiMKEJJBoPZhci+fIKHPnY2NG53otA=;
 b=DoZs/OKORcfTMXT3D8Kh7y2rNM5v21VHQRbXTKF0wD7fH2XUq7WY9B9kAXOczhQY0+
 /Q12daWbaIrDIUIjBZEdAlj/QP2ixM1a7q8I9KisDP6HEgl9CeVSsUHmAsuY61FrOSTv
 Mg+fmB3lvD4fnjUAD7gWjnIxMCclZQds0ggMXfT6mTBo0eklO8A1HP/4Jg4I+rhpCT2l
 v61qcz/PEmJLCnkKIhQYJLQXYaMc7ipdTk81+TLaQiiq7VOHcd/Bkfnd1zwv2CNZ2C5E
 2zB18p3QXeOcEpu1ZzFHBhQt/YQB6i5rFPS8xv5WxyyL6Q2cutFYuvaNe5OCky6mq3/F
 5QKQ==
X-Gm-Message-State: AOJu0Yw8sKnoTnBj/js/vg7lJJDle7GDu5VFS3Edmy9CXF2lHimMCTV3
 /q0t34ILlXWVu+xEgRWZkAtOuPY/0ANdTAvA0KjIs9EslFbzogcwoFD61wcQzoa8C6t2z3bxgrQ
 4FoBqepcm6zg/vwndsG8Wz9oYnWUMTNYObuZL3PlloD3wUKAlCD63F27QSySRlFZWNntexH1wnz
 r9CwsN6gND1BfTSoYPo+i2ZcKNkJdYsB8=
X-Gm-Gg: AR+sD10UkYlaEY1Ih3CxvV61Xph8qehePDkf/JlrpAyZQMi2e11KMhnbGXMbf2wDxWx
 Of95jub8Goj8O+Zm1yWtWVfH9ho6conrmwlz0x5xv7w2zdIreHLuAndS+AO/uP2sPxfwRYnvvio
 0+T2JQvRmwYg6JOYaWj4B0WNkHzjdYfB2Tw6K5VBXXznswFXQCSW1KN3/L8vimDV1w8oJi6DWzL
 O83rQYSEFK4d+HRwV5+dw+kBwP+L0Jb1lxuCbSuE0P7f4YX1LdoLvh6BiLkhJctHAw7KtXzgY8w
 7Q==
X-Received: by 2002:a05:6a00:99e:b0:847:7ece:3426 with SMTP id
 d2e1a72fcca58-84e595b6f99mr4490080b3a.58.1785088397760; 
 Sun, 26 Jul 2026 10:53:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:99e:b0:847:7ece:3426 with SMTP id
 d2e1a72fcca58-84e595b6f99mr4490059b3a.58.1785088397248; Sun, 26 Jul 2026
 10:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-2-4b83a70e9f3b@redhat.com>
 <f83491f5-6ef7-45ba-bb84-26341835cb25@tls.msk.ru>
 <CAMxuvaxUWc=Qr9pQQ6wW6XnAzp4mf77aYpcFuXvret1KL_W9kA@mail.gmail.com>
 <0b2bf915-d2d5-4a21-8ee1-d11427476d40@tls.msk.ru>
In-Reply-To: <0b2bf915-d2d5-4a21-8ee1-d11427476d40@tls.msk.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 26 Jul 2026 21:53:05 +0400
X-Gm-Features: AUfX_mzdyOTg7oGlxIx6xGY_PtSWre_pu099X_1m5CsN4Ftnt1xnlq8cov7GDHA
Message-ID: <CAMxuvaxU3HJwkyvD0WtifFCMfcivNiUTK4U9Yg0j7cpc5LXLaw@mail.gmail.com>
Subject: Re: [PATCH 2/5] ui/vnc: fix OOB write in vnc_refresh_lossy_rect
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi

On Sun, Jul 26, 2026 at 9:14=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 7/26/26 20:07, Marc-Andr=C3=A9 Lureau wrote:
> ...>> Unfortunately this (additional) fix does not mention the
> >> previous fix, so there's some confusion about which commit
> >> actually fixed this issue.  It looks like the first fix was
> >> incomplete and this additional fix were needed.
> >
> > That's correct, we reused the same CVE
> >
> > Daniel P. Berrang=C3=A9 said on the issue:
> > We didn't release master yet. As long as we also didn't release any
> > stable branches that claimed to fix it, we could re-use it IMHO.
>
> Heh.  This is exactly what actually happened - there were
> 2 stable releases on Jun-25 (v10.0.11 and v11.0.2) which
> contained the first half.  Now there are 2 more stable
> releases from Jul-24 which contains the second half.
>
> Unfortunately I haven't noticed this duplicated CVE#,
> or else I'd add a note to the second half in the stable
> pick-ups.
>
> I know you don't like me rushing things to the stable
> series, and this is an example why this might be bad.
> Fortunately this is not a regression, at least.  And
> usually security fixes come in faster anyway.  Ohwell..
> I'm sorry to disappoint you further.

for the record, I do appreciate your work, and I make mistake too :)
Next time I'll check if a release was made already with the CVE#


