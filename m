Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A09606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LCGjaGSN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQ7l-0001xn-09; Thu, 29 Oct 2026 09:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMQ7R-0001wt-Mc
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:24:38 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMQ7Q-0008Aj-6e
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:24:37 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-679334baa1fso2618714d50.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793280274; cv=none;
 d=google.com; s=arc-20260327;
 b=f9SJYc6H4tPQtJqEkgtVkgHI3ViojRUYhqvOL9aTXZ1Hf09i+Q/YvOQstDFNpl+kIE
 rVkkaTiMtiXRQkBWhY/12vUjULrtDZkDywnQHmKEXFE5aNI80JzkygsegMCcWGYakhZZ
 3/OEkgmPnSuJeFq3cfKsvdUzCFj5QQ8jNg32C3PVKirxuekIgg4i0721p+6ClyRmdo/d
 XB3I32bWNvmmNzC4rJJUtDNbQXE5UP9Qdvmh+LQZd475uZWpFKUBvai+dmL/bGvhH2el
 fBUUHslB5rlaSomMqz2WsCfh2ZievMYWplsA1miqB96ozO/qLrVnQhGjeMwa+ql1TMVf
 OAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2ta8sKyDOzwxVWBcBAaJVOxYbm2bhcFOKz5Kd4dIWj0=;
 fh=NRz0OXRAxV+z6Kpoc81dQlzU2TlB+/D2BZup0yMYhus=;
 b=EhgDWbcnxZnjnYe9mvfD5mMe6yRUeJKoqb24/S+5nY2IhGvjA7CMDdnXbhwa7/HnXQ
 /Pvc4AOmKl5NC1JbnUUCgKirvzbG1vfKy2JyBMymd3b1TlG42jC8HNiV4pvPGfc1Rslw
 L6d4FynjSLT06L6Bxj85Mtc+S0Yg3gi3WPIpWY+mCKySXLVxPS1NMYZf/+h6j18wMWWy
 zrlpl85C1N7YZTnH9EWT4tcYtGZ2Y8xs6WQWU4AqCFV6Lrzuek3ElA3+QbXs8FCtsJLU
 zWZvfy1AigDyhvKC7xg1rw/h1+1Br2KRZpCVXXHhlwnOyA5xn6MMTzEzwpixb7CpLkFS
 /F2Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793280274; x=1793885074; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2ta8sKyDOzwxVWBcBAaJVOxYbm2bhcFOKz5Kd4dIWj0=;
 b=LCGjaGSNtDN9AKdredbr2qBy1bnbkYO6b/2R+6nKw3sZYdXOH6Z4ZG3h35EQ3OP0ry
 +pSK5Iun3SLCfbM3ClwChev/PL5IJC6zz1ekblKW33+2KRuYLTOIUM8TwMKm3Kv0b63N
 30kPXkFXLp4MBeY3pq+Wr/lvCzaCGrn0s4DOGEHbIVFOkKzMEjCLX3c98sj4saGioVsE
 FjetlW1DXIKhWeh1hkpupQ5XpOfXJXh+mENNxt+ncEJrpAwhlrXOMeUMJYePb01ZxZSS
 EbGbyuiqY9bs8SmEDggmIMZw5GDmNcIV1ycbxsRmTTsrNFwy5WW/OoG+5TNwaTy/Xam6
 eHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793280274; x=1793885074;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2ta8sKyDOzwxVWBcBAaJVOxYbm2bhcFOKz5Kd4dIWj0=;
 b=fQkeuocwZh1KCwuktZLohA7gfSqHHUapiZKGrkTZYKhwEiQi2Qhdmehmsq4A+AzdTe
 JZd4cMsR022jmudKqriwmfoOmak3YfC+MPrYvhdq8yFqHDKaHBryAVW6DlEBc8ydmtur
 80cZpUyduKuK3tcSTo19qwDlByEgQF5nCvbLjZnwREWtbsrG4np2t2muyCKfcjQFrWoY
 FgXIlbHDNF69UmR5lpArgk7j6OVrvre8T4ndHXYBycwdv4osG2YZ4SubWiiQFmH3rHU6
 Dh5MYV2yRt2Dei+IFjKuTJgQi/TpkV2kVGEPlXgHvW/Uxpm7eHWQahyC5QaamtJRFsUg
 R+uw==
X-Gm-Message-State: AFq9FYJZEKPJtq/OocHYevnAf1dBDt0DIOSDfEdN0TKqS4jHaSHUhmo8
 2lzo+zzVzzLCWOm2pK4N01AD6I6Sr8OpQTSQ+b+xUdE2K6Gy+OTJijtpnBrvm3LxN+PdnSJzDn6
 u+0xFwx/fa2KgaQOr9WFHWlnrl2Dd46YJQQXgOoG7lQ==
X-Gm-Gg: AYBFou0hjD4C0vd919rh0aPlSSeXIeBRRAVATRXVVw2IpyS8NH/AExJr166WYVUuOQJ
 OTzu8LXZogxP0OBeprfGEo9AMN7LU0/YpSPzlcEjVfOSNSnHkX+mkidkTb3fbCkarTzVbuXVt9w
 QL9iazxGk16HeOEIHwO2mnFNvNIj137BhKDhX9mBvMLiVheANb6eUXOmGgVOgTn6Lg1iJM7CnJs
 /k7UqDMWvhh08z+iiD3CK4EojQ/P0WnXSYLbslFfhd9lG6G5rouueAqTl1N2RYbvTkfUY5kuWF6
 b2hsPsC46QfZLiGh7swfeRnEO8E9O9KnU+8ubWjBglzTIjbagd6tFuNpTe7fm9rUEf0lTTH2P7T
 J2l32So2ysQOF0y9CZom1WwbH1wysUEwjgudQrNtVvkPK4PvUWaO79CmIeckyucoVu9FP436BA4
 OgjMmn+0bawYBS9s9lAP+Z
X-Received: by 2002:a53:e01c:0:b0:672:99e0:ec0b with SMTP id
 956f58d0204a3-67a7bed3ba0mr2682870d50.163.1793280274413; Thu, 29 Oct 2026
 06:24:34 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022160426.451919-1-peter.maydell@linaro.org>
 <6f6d3064-94c8-45dd-b012-dcfd09ca9ad9@oss.qualcomm.com>
In-Reply-To: <6f6d3064-94c8-45dd-b012-dcfd09ca9ad9@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2026 13:24:22 +0000
X-Gm-Features: AclHuK84yy6Q3dKZB1mew2vxrhUROuIHLLmbVm6Aa8Ozf3fPLfJfpkb0ldweSFA
Message-ID: <CAFEAcA_wS4Q4vHcd7Ne7rviVpVF9Nn6RGqfFxLCFAthw3AoA7w@mail.gmail.com>
Subject: Re: [PATCH] net/tap: Avoid "close(-1)" in net_init_tap() error path
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 at 17:14, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 22/10/26 18:04, Peter Maydell wrote:
> > Coverity point out (CID 1660042, 1660052) that some error-exit paths
> > in net_init_tap() reach the "close(fd)" at the 'fail' label when 'fd'
> > still has its initial value of -1.  This isn't a valid fd, so while
> > close(-1) will fail and we are ignoring its return value anyway, we
> > should avoid it.  (Compare net_free_fds() which has "don't close -1"
> > logic in it.)
> >
> > Resolves: Coverity CID 1660042, 1660052
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   net/tap.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Thanks; I'll pick this one up for target-arm.next since I'm
doing a pullreq anyway and it's a trivial coverity nit fix.

-- PMM

