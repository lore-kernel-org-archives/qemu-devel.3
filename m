Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE13606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QQBoneY0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMas-0001Rf-K0; Tue, 20 Oct 2026 23:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJMap-0001RO-Se
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:02:19 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJMao-0001Z3-5S
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:02:19 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5ba3b1199f6so210219e87.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792551736; cv=none;
 d=google.com; s=arc-20260327;
 b=CAdZs9O3ZAzilbxIBBNfug3/Cu6omMYsTVNA0NANp87gWKIDM6WFPMgvN+0VfaCM+q
 iUa9RQF0pDIU7vN23noOvLmUDxpUtHWR4cqMfXzdPFdP0/nUoKoh7OswQjKIMo2X0C97
 CfTwHHa5ma6Z2PFDyEc8nM6iVGItuMF65z2stfwVeHek+YacHF0soptyfBNLGt4CFXBc
 YLq9ZRjl2OyEl7K9q6vRjUlqZifbqeiFCY4/JFRJVGxDqZoF6UHo2+RR0xZCXD6lHkMF
 hgN9+AH+EHXxP4zUfxTKGWt2VdpmPg/bWtuP0Mqi4bg0Q5k9+5HL9uBXMsIshY++YiAk
 CnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=lFAq0lA8ry/Jj5tx6x/Rtj3gqVM43ztm6niqRdhKs8A=;
 fh=n+s/UmlNdAcpkwZHkfPfDfNjQ/P7HHEaFIgb3Ls+s2Y=;
 b=Q2HvSBfqxvpD7EOdRMEbfFF/SNjTbsjAXkSdRXDJ1DnRjFhoPkx9PswtrlXp7SMFQU
 t/PinaXf+A2gt9+hwIDEqFUUBszMN7UsOETOJ/D8WqlnXtyN2ZE69C5uSEByX3sbNwxX
 8j6SPth4wMMZfy6FNP7t4NK8gaExwLaNkzz1dlnAlej5DLvgjbNAXYP3uVuNm6996/5a
 VLMj3Ja7h+A7SKl1JV/eYi8curBX3cUQanpt3g10G7BgIdIOE14TFifuv090tju4QmQ2
 eZnfeUxSixd74IGei2ijrGwU9oqRlQEbvVZmRJ/pqyFjqRahzTkSTkRAosvD3bMxrwkt
 QWsQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792551736; x=1793156536; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lFAq0lA8ry/Jj5tx6x/Rtj3gqVM43ztm6niqRdhKs8A=;
 b=QQBoneY0Nzi69ZcadQp3luOfivNDDxNVdGBL0fZwU+JrRe72ZDd0tkAmFVmpC4cee0
 6eNvYlg0yJ/hQy6UYAOQEn2LCzHukZk3WD+PYWtkzz+x0Pu+ZebdpxKnVAxhayEVfXlx
 fttUlRW7ceKiXxD/HzWT0xCNo2s4G45Y5Cu80rCtMIHzTcyyJmNicBVsfUuNkLc7S+BZ
 qMnLJ4OcbpGN2ygcIXSlITFXs2YU2fTHYkZpx3B2pV9U/EwQRN64lttq6FzAMVwEYnyX
 gNTYslTDb9w3WfWWWdSwaxymU3n5MGe7PXGInz0HbTVhrzQBGcTiQwtScNxWFzlHVg0V
 KUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792551736; x=1793156536;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lFAq0lA8ry/Jj5tx6x/Rtj3gqVM43ztm6niqRdhKs8A=;
 b=Id6TSL/kF3X700tCHwy6qlODTT6D6619t8iZ1q3tqHtGOkXAgPqaPVXvtnS7taPHnd
 12TZMcanceXXXSyIySQBqUNeBzeBExqo86Sq2DAYEtavc7fn822NBgZgk/i/byXAsdpu
 Q72JbavkC+g9Y9AyhsPW5vbHFe6VVPl38N/6NfzA4y9YA1J1QOy6XK4d3lClSzTQiwNC
 ts+eQ+qVl4nerJV8dH6wRKfZdLic+RNajZaiDjfx4vb4ZMrvBxxBoUfdMIZ3Ei1Fi9Fo
 eb5JLB1EkfdqREMDAZflGC7mC9M0nZ/9521jijSHh2XPTPCEyRS0UzIC6qISs03HHOyj
 l2/Q==
X-Gm-Message-State: AFq9FYJMqgbz7szCTQa88AZcO4TyfND3R1qITc7+F8ov0dd5BZB7nTcH
 6+GFvzjA2xiLHJdtB9iFXvWixaOroTcXDTUJqYNc7/R/ZBhadSyjg+l0ulzjpuVCbv+OvcF3f/m
 ZR32vQgtFO4et3hPyUp7PV9eApo9jsY+92MEp
X-Gm-Gg: AYBFou1IoAHRpz/by979KK5jpHB3tDsOdeLp8RP5nmW5mTUoK6YKNw4AIne5ECbDSoP
 jhSauiunD7pMKKFpcFQPzPqKEGO3dK6y2Hp5MsDikjS8DQ/ObatERdHnAydC5uZMuTM12TS0FLf
 sVw0ICwKaTimniYylq4BJ50mHSm1z0ZLhm5xDV3w7ykEfOXr5FOBcHVyqVc+3H6G8u8s77fjTqD
 yJFszWAfPZtwXTKg0iquFhVpZwGLYqVHrzF4Zh9zLkMR9QuHz86Q377suxqSHM7FY+bN3rqzmz8
 RTHC4DQkcxO69xbBlENbzX3HFPcB2M56sw2tb2Ov4QoSk23wG4kBd5TTR0MIWYd5eXL7yATgrGJ
 gV89P/ppio2Bvc7oix8+Sv9USuiv4G/xZifE5IahvFfIZ+YyEMLjUtSxsp7rsE4ej1ucmBJZzib
 laG7Boo3YhIUvRI6IZC70n3hYGX+P50GzOKO6WG1+1tDITOlyFvVqw
X-Received: by 2002:a05:6512:1302:b0:5bf:a193:7a5b with SMTP id
 2adb3069b0e04-5bfa1cdf6e6mr217363e87.34.1792551735932; Tue, 20 Oct 2026
 20:02:15 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260924022022.2414514-1-mattst88@gmail.com>
In-Reply-To: <20260924022022.2414514-1-mattst88@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 20 Oct 2026 23:02:03 -0400
X-Gm-Features: AclHuK-DIv5XIrQv69e7GeZ2Oo16qyM53P0BgYQPORMruv6_VxzhElEXDZV4SDA
Message-ID: <CAEdQ38GmTzHp2YTz+vGJ8h8w9tes3Efzb3+du-9YEK66xTUZLw@mail.gmail.com>
Subject: Re: [PATCH qemu-palcode 1/3] console-low: Fix off-by-one stack
 corruption in entInt
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x12d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Richard,

Would you mind applying these three patches?

Thanks,
Matt

