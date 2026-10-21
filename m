Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE2B606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dWD4P9Ec
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJdCz-0006WM-B4; Wed, 21 Oct 2026 16:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJdCw-0006W8-TY
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:46:47 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJdCv-000748-IY
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:46:46 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5bc18f54abbso943989e87.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 13:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792615604; cv=none;
 d=google.com; s=arc-20260327;
 b=IABLpAGtd5zFlrWVZrMl5iea8bXhwDH0/I5/8Q6n6g2jzNsSNMh6NoPWce+ojInKke
 GyaSQIrjURpf+Rzu9UVCchhL/WrA8T5TLnDbd25+86SfXqQyLfCJ20iS8E46ktKCVG5u
 Qg5P+Er4ouo6VtFqMpL2F/KxWm6D5AC6XNywVKFL9Z+7yV0LGa6jqPgSJ/QghMsPu9V5
 YW7zNTA+Fq8P2KwlPDutswyFp+ik7JSEbu54cLejvNlCdJinO1OavrZoBnN+GVF9LFSs
 wgHimrQxLxmXm4OviR88DeBgZmgoNHOBRNaHwGnLBRh5J0rHWA/s5JcQrOOWZ/hM672y
 gWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ej/8MbNNUi+HZX7n9z1aHjeCNyjZivERxhzpqW0FuVs=;
 fh=fMfr6U9vqZWyCHK3rqr7ZLaoP9Sdvf4Q6WFrB1e877c=;
 b=s2gQKf87h4kT81onBS07eN5NqFwf6nnjrfe5MeScSNLl+PyF0iDwyEZbQZxHArVQk+
 h4Elo3mmmDsm6UsjBIDeXPD760ltbQzLtNWamK5COzHAxRc7aOFGQ5sfdE8IIMouP4Sc
 f+YGfiftATypVS3O9hPuET2obEW8tOX5d4X4jLrlDS7eRuOFcTCcACxSn2Q5+bU6J8ib
 yqzhj5UxY7KVeaw1T4ZXI69WQFcs6h0X1whOPWjrJmWlQRKNMWv4ovREb4pOBphQctgL
 bmtAjrPZSDNYiaOBqLSHPsTjvXpQ7zoxTbA+KRczfxaFN0GTtfsn9GSklh/OwnfJPHYI
 5rtA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792615604; x=1793220404; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ej/8MbNNUi+HZX7n9z1aHjeCNyjZivERxhzpqW0FuVs=;
 b=dWD4P9EckrnIqAbPh5Iz3KQuKyJfh4en0YFgfytzM3OkvUusi6NOLQdJn8Grh7P2ud
 do9DvFWLygZtPuwe8zM4LyMrQ0JQx/le3G0UCmVNFiiVIObDtODLnYpG7wIQvk57UKtT
 Uz3BzecRFg/z570jco57+6QyUQta6/OQzrl5OPctEL5dTh6Ydx6Dho8JEeikCDPw9C5G
 CADRL4lMMzrPMlsK1hJG2tVxJzEA5vl6FeL5A4nPJgM0oG6ErHe1HrmCDyUWdZgIxmNA
 wiWs10GwBK7pu0Ng6qh17z0bvHuSi/uSfdXrXERAti35BVXAc/4gmpqracZjTAjrWd4W
 8adA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615604; x=1793220404;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ej/8MbNNUi+HZX7n9z1aHjeCNyjZivERxhzpqW0FuVs=;
 b=w1hocqXjW/xPDpZR6Fu6Wv+mLst75ecbvptxbJaD5GnbWck3jpabf6tSCLquuc71ao
 fU8UlAN5FSiWhc4uQh4jRHhxHHMQbWyB/Y7L9HcRWj2Sx3xZ6Wy6cVCEZbd/LvoEffff
 piz+MbGPtVwAIjc0Qn3J5pAR3SelPuJyHtCWpk+9WV+vfSjrel6yjR23ExDdqoUvMG2q
 qWI8TCcEGiylCm5/eDmSaUXcziPmVlNmS9+bQdRTtpeNwKVJPzZ6NUpCKrGfnUI6zndi
 YbHccxoK5Y2peALGxlSQj2RETbLp5xffT2Qy6mTKt732bNKbJd3zNNIDKFXsDL5O9FZg
 rqtA==
X-Gm-Message-State: AFq9FYIT6yq20fMF8k2WHESU3SZGUOnt6pfpjaeNsQMTcYs9eipMC4Nm
 WfDojZawT65Gxv9HI2rCmt0ow1IL0+znTqqTZWikkMccgx/zDNmQGjLLhRgz2Gpygk661ZgVlU6
 0x+CmOcQi/eerPxrJgum+hfPyN/GbqbJZwC8LtXs=
X-Gm-Gg: AYBFou3/AYyaSubEQeatP/ED1GuwS0ir9+yRCLPb/nJJNFc5J2g9jbExMjfNFCrNgg8
 W7ipNoJ5Wkb3F3h1My7KrGb6vt7BVcN2oz+lihVd/ZvknUE5a6I2ahYzQTrLSezo6tzLVOikUB8
 6iRyqEVOPOJEMsFFCnbnJMNq4P/T7Lhot8z8pKYWBXTDYDH0vU/9RE/Fm66jd1C+YLh6OwSJVFt
 VJN7GW/25/KYkGoHDOmW5YfHIFoDUcZDgb6/U6mSnbZYZmVBC7qNoaAChtaPmNfanzxR/bKMjmG
 jDJHnXMBKGoDNf8fkras7pO2Jg2HypMbmOIEds+6ODIlFAxg0l3uaYvEX2+fPDU3nEe4+Q88v4n
 i+qco+Mtr+Jv3xxX/MgOXpKMvWQ1fgSCYEmmhBTi0HOwQ4z7k5lkHwhTgKON2duMO5iau90AZGt
 wPNx3NzZQ5N279PaA8pV6oJYzLPs8W7ox/BsgOpiCxUG7gDBaahATb
X-Received: by 2002:a05:6512:3d17:b0:5be:494a:f966 with SMTP id
 2adb3069b0e04-5bfa1cfbbddmr1182905e87.44.1792615603642; Wed, 21 Oct 2026
 13:46:43 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021141652.363109-1-richard.henderson@linaro.org>
 <20261021141652.363109-86-richard.henderson@linaro.org>
In-Reply-To: <20261021141652.363109-86-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 21 Oct 2026 16:46:30 -0400
X-Gm-Features: AclHuK-DznQGUf5fNYnfmHm51Llsy_YpQF2NH3C7JgakHiNy7mgRi6ZdFDRrnHc
Message-ID: <CAEdQ38HAH1CkW7ve5uhBTOsyWfcSgG4rvHvpnY8-YJ2njKkDXw@mail.gmail.com>
Subject: Re: [PATCH v6 085/100] tcg: Split out gen_bitswap
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
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

Subject says gen_bitswap but the code adds tcg_gen_bitswap.

