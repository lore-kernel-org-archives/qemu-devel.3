Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CDD606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oo8sEavV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOmo-0008LP-D3; Thu, 29 Oct 2026 07:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stringermattingly408@gmail.com>)
 id 1xMH1U-0007hu-3w
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 23:41:53 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stringermattingly408@gmail.com>)
 id 1xMH1O-0004cs-Gm
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 23:41:47 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6df7f544919so1066527eaf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793245304; cv=none;
 d=google.com; s=arc-20260327;
 b=kB8dDTSZn4DMGL6VLw6jWzApfTNvY+nomz+pQxMB1V7b9VrLO8zdRyQh/adu9N3gow
 D4L9yTdh0GHI8BcqVA3zgg3LNjdFNEXq0E1nOFvAV+HEG+8P7rvw4NhMLLs8yXhxI5V1
 HO+RQ50XLA/MG500q/XNKzhjRa129SkhNBI4IVMql2vFnaZvpBbzzE3VTJ/jOnDkUCuC
 gRCLeyAOsvX07HAjgj7Rl6CqOjxwf1Lv0sbllbDkjoukBV2o9e6yhQtLBa3QboERwJqc
 SCpABY+OrLWYJ39BjmNDPmsm3UlN91RiKdSHF5pTCPG+DOIxhOB/309uouPrruer/1Qq
 NN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=bYt8mK5PjRlmmJtIkns0bx9Mq3/cxPQxLlYoZl0xIZE=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=HMUNyPNi/Fv/K5RrQeFVZwo6hk1Llzj3A2o9hnX0n7RZLHVLHETJqRXIqnLL/60hVY
 JlkWUhTnOZF1hKzOegQLueEZAAyFxNnC0uD5AVg0Eeggcv8+KeTvxvBMz3QGwlSQaFsx
 roCb2TYMC5gT/Oukm6sCf3J/7AWD+p2oekZv6i+4SsbXeavBTAnuI+QVhtGqo/1Xu8Hm
 +Ulgz24CcnsHSxocZJs/ePxqg5iF58T9sgoE5mPudhpH22PeHfwhQbjyoM7x/qYIrTCR
 3CvF/gHyEvJfU2ORbzWEHzCclfRkWSc/XlDtMfLXTGQgHTsnCMzagSr6n+00sPO/4Vfq
 uwtw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793245304; x=1793850104; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bYt8mK5PjRlmmJtIkns0bx9Mq3/cxPQxLlYoZl0xIZE=;
 b=oo8sEavV6+0lPEM2wSxUVkqO1ceufHZp79yV0vFO4urVHR6UwDhxEmW6AtwbGhZmsX
 D1KAzC6VJ84G9P9f1dgQZOomziORhFtcFSBK78znghU0t19tzNk2v50jLlTpz+hhaD1R
 3wcWQdtRL6XzMAbQC8jq73I3WwdX65jUOuu+HYudCxjRev/B57K5Rqh6ObQ5f1OF1f3W
 61v1Jb7bvMpgYcsm4E8aKz5LljRHPlt6otBOpinFn/xUsTM0CoeMh1xy0qu0C9mNICCf
 UWYA5DEhuv0ntW+lDboTQ44c69D4yS6pOSRWkHdWuC39q78jVey/Rc5sbPA79mkPJ+2O
 CNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793245304; x=1793850104;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bYt8mK5PjRlmmJtIkns0bx9Mq3/cxPQxLlYoZl0xIZE=;
 b=EMFzFFJC+slCsJsYUdq/KdLoV/+tivGl9CW53VQKMvJAIMYC9ricU/YIr6vxU2Avoz
 2DNgHRPHAKNohn1v3GOOWnQ9Z9GanUmCnexH1Gd1bWevZC7lrSkwc3iwwhZOtWUch3Cd
 FAmsuwnnqmyr0djXLEOlWS4BJIyVTU6RW5VqqghjOhmOZssDNkvgC+FlcC3mYnhyjpTU
 qeWpSdO2r/VIkyE2FNYGJbF5qBXTod6Dh0VzBFCuclNN33Z92yctpUZNRwcCxEUbv8SW
 MwtfR5ib1qPDuHawlzuT92uHPgNivVAgEuqb2objgEEcKVxCdpLDLwptCDpCzIVdo6Se
 3Hog==
X-Gm-Message-State: AFq9FYKfhoIvyRcCmYRsQqYwLw2YsBdo2MkJ1h7PjhTZaXdUyi2iVthv
 A7yiSb0xA+P//8A39b1wmIrBMV2t+5B+0aC/IPIEI7V6dgBuKYf/We1GVavLFrCL2kaQaKT3DGn
 hiwqf+9cPUtbDFGQaWOjvM+tQm2kHFJCnzBPV5GmK8Q==
X-Gm-Gg: AYBFou2NcjFR/qCVZcWH1gMsK2oVOJVIc8N2ke8zk5ijvrYWyP/aqHXb5SXOFUMqR3P
 E8WWUPcdk5OnAP6aArrafCoY+QFRM/Ku3yqCZ1vl4bpxDqfqDZeGEradaNahRx1jxiemkiaAarR
 pMTpXmGbLuwjvcp0afb0ElQfDP0bC/GZIVkw+wbHexbvLaz4XFJg+fAHinc7xFhvN4vcxYtcgoe
 SIXdBYjR/5mzMXsGL578ue5Cp6rygwho2o21STrrRp2eUKpvjl2sLsj6+R3EPvpfPyI0ibe5zUv
 WoWRiBU3wfhPReySg1FJozLNvDVgGRUmyOdLf6enFAy4HQmXr6EwRDn7t9YLldGna8u6Ff4d/yq
 hRJcZTBk3/7ohQ6s/cN0z4jJ2avU2LEuL6hS9b3nej18gdvyALYqX73Ucvkf5sVK0F7gIKF0MrG
 Kcug5lmw3Ux1DcYb5meIcRWJ+WQA4+m2Zyqo3b9eBUb5sUUTSsLmwWcpk=
X-Received: by 2002:a05:6820:2219:b0:6cd:3ffc:acfc with SMTP id
 006d021491bc7-713f2145eecmr2311306eaf.76.1793245303463; Wed, 28 Oct 2026
 20:41:43 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Stringer Mattingly <stringermattingly408@gmail.com>
Date: Thu, 29 Oct 2026 11:41:32 +0800
X-Gm-Features: AclHuK9ixdDUa736G7uQ_zLXOTISKhX0amBWZ5xkgMJEMXVvUMpo6bstoMe4HjM
Message-ID: <CAN+BGFaMPE1PhwfYQgDhjT6xhXQg7q7XcDSmpskijG8Cg+5HhQ@mail.gmail.com>
Subject: Hi, need help with qemu ios vm
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004ee369065ef2755f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=stringermattingly408@gmail.com; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:59:09 -0400
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
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000004ee369065ef2755f
Content-Type: text/plain; charset="UTF-8"

whether it can be provisioned and get appleid accounts authorized ?

thanks

--0000000000004ee369065ef2755f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>whether it can be provisioned and get=C2=A0appleid ac=
counts authorized ?</div><div><br></div><div>thanks</div></div>

--0000000000004ee369065ef2755f--

