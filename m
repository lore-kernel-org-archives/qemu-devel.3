Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B183EC1104
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 16:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuYe3-0003MY-M2; Mon, 23 Feb 2026 11:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arunkrishnak2407@gmail.com>)
 id 1vuYe0-0003MH-5u
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 11:18:48 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arunkrishnak2407@gmail.com>)
 id 1vuYdy-0006sF-Gv
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 11:18:47 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so711326366b.0
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 08:18:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771863523; cv=none;
 d=google.com; s=arc-20240605;
 b=OK+Kki4xcvg6hSKg49xoF2c1VuQceZt3zRp9ify+s/YOS4Y+H+0cbZ5s4O3r7AOW9v
 vjI1PV4K9+oxXb7b2QrelWjRH/yi5peWWEgHFqHXNtwvAp9UxwkR6+//Q3KrH+HhNtLZ
 fpwnmu2RQYHrgBCr2YwIfDjJR2goU78QFLi9e32PXxpMgeQC/QrYL2thNwgr95t1EWOH
 z8NgGGuKJrXCiiuou53Sv9PK/4ldsVXsucrUJYPv4yXHZS3NAR35spqcA14Qt0cg2cFN
 fTNI52EWtLiacX7h/bwuy/kQx5H1LNU6AJZx0G4DiFyaOHd+uZ9/MVGZf2WIAyekswXt
 PRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=lqKumOudaUOpfh0LtoujbZT9/vCspj5JPeOuIigzzs4=;
 fh=JirxBaScZozn3BmdGRKDvComHK6cFh7juRbYj85p4cQ=;
 b=WuViDkMb0/bOFnkBSGVksMnGC+A4wH0P5PShCwRFEoAyIimYkSxSN54AmuAW8qlX12
 hMOf+Ps5skM3a9bc9QOH/5TUrvUwxGEhel2gFOujHvU/cd1wagSS95Xd1tfh23AdGoZ0
 Cc2Ci+loA14uwFdz9VxgOU2Rnxst6tPmHDC1l7xKXxwHe/RfCd+SSahNDEtqPJlg/r26
 SARD7yd1fgSGLwiomoMpEBMpNL+S5YOBxAZOaAByVBekRkZ6207MtsjGPEr//fMlZjda
 NC4ejXJBgZbS0EZPq4Ae7h+J1LkQczRyg0vD634oeuF9yQCHFjPJD6HE48w+4bkbz0Kk
 Ul4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771863523; x=1772468323; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lqKumOudaUOpfh0LtoujbZT9/vCspj5JPeOuIigzzs4=;
 b=YQePvqcrlJ9r9qQ1RvdXZuLnqkMG/RWaOABOsvdbmpHaEC150wEA20rchdtaB43kOk
 NLnZPCnDV0v5hX5rVSS6Tseoo0AP0WeTwa7Xma24lYGEUK5ADQ/64q6zOJwDLjMaAvYP
 Sx1RYAyTuk0KIrn/QAnlD6ms+20LnOnRaTwzzXA1I7sza+w2lP6yzjT4D8hyMckwdQej
 W8yP4Yrbc1ldIhItV5zIstsC4IiPI53ikcsUd3UVZP2MPA42DYpnrTh/GR1twOgXgJ7P
 t3PC1kbdnMmSMFAxdrRQTD2v/7PfqSANpgHrBZJZPZHcE+A60nmgMwqVzPxiVovMeCbD
 a/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771863523; x=1772468323;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lqKumOudaUOpfh0LtoujbZT9/vCspj5JPeOuIigzzs4=;
 b=Rr9JXygmHwOnhwAIO9e5TEMbpf11hLHs+NxRysjshYXjtP/pLm9HTw26RpuEVtqn2i
 rlDkFSZt74P9sBh5IgkVkApY/+V6C44uN0b95UmaZaKKx/ijavGtIIwnKulhvPe8ukBU
 z/e9Mv/PB+Y2BGKI6UTMwRmxXgNS8UPDBvjSdf6r+Vf4jHA2HsxJy9U7/zoWuhboiNRT
 o5J+9ARoJfi2LJl/q9tvHLfCCOEzwtFG+he/PPDBnd7968A+N5cX5KwbM8KSeZ13R+RG
 7/MQPCPfKsmKh2+WIVPOwRkvAt4HnvLFk6HroGKdnVi/dhK3aKV20DO/98WetHQF5Rzc
 wqKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU56bNTBSrXotw0YEQFyTMgsTVUiTtyVl+6Hc/BVKAOZzXCqt6nX+IKbxd4/dXbhVRXZaX/LeFTUnn2@nongnu.org
X-Gm-Message-State: AOJu0Yxu+0O5viG1PFlfR+6M8F1Pgar48m1p7Y9IAQY6hSQY+9q9lG5E
 XTonqweTpPciDS4We4glDNSIwuKXuE4jVMw8hOsnR0Y06W61easD1Cf3DwiO1T7g1V1ZK8yqFOr
 JIEvtEVNCJtjokO5duaSNdHS5/PCRGPM=
X-Gm-Gg: AZuq6aI/+7ipZpCS8sRi457F3T956BrmLfMoUYFQYtKp2Mt1I//B9jQVWgLy5cKvHgP
 KgRQwKwsFXlwmVuWHIIprUJOwy71vv1ZzkCGpGxeVZFX59zP6vQKibunTvn15h5oDM84NaqRiyC
 Mc5f9B7CUdjmJpDV6mMNxPyd4m9SA3tjgGyFrvQan7rn1VM5x3y9VRDnMnQatxwG8u6aUhk+TfS
 bLidxycy3VwYLzbnQrMovkQb+M4jsMzgnmxFHXIIXfgMV2vKPGIZNml5lA95TZMVNjwXpV/lG4e
 +DP0y+D3TWRX0pyDg0tAWYBDRiR+WcpKxKlStG+fwRy4jRl5emrLzKDlqXDYpO4C3O/jnUN2CbM
 9n3FukPm5VjWuI7YucnldDmPwUNmT8rQmDaYFO4rSjFSZXXra7cFlSTKtgSHKUZ9K59m4WeuxDd
 UhA1ddGEG/j8HjXdzpaHLNkQ==
X-Received: by 2002:a17:907:25cd:b0:b8d:bcea:438 with SMTP id
 a640c23a62f3a-b9081b9b91bmr630238866b.44.1771863523191; Mon, 23 Feb 2026
 08:18:43 -0800 (PST)
MIME-Version: 1.0
From: Arun Krishna K <arunkrishnak2407@gmail.com>
Date: Mon, 23 Feb 2026 21:48:31 +0530
X-Gm-Features: AaiRm53DjqfXAi-nLHBQUL0K4BhBX_qA65P8oWXo3nO67HRRI6LfJdHtBstzkCQ
Message-ID: <CAFMJydMjLq+O+wuez_eSPYAqMgH9DPBXAW-o9zMZCSQVb_3e0w@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: stefanha@gmail.com
Cc: alex.bennee@linaro.org, danpb@redhat.com, deller@gmx.de, 
 gmaglione@redhat.com, hreitz@redhat.com, kvm@vger.kernel.org, 
 kwolf@redhat.com, marcandre.lureau@redhat.com, mark.cave-ayland@ilande.co.uk, 
 mvaralar@redhat.com, osteffen@redhat.com, pbonzini@redhat.com, 
 philmd@linaro.org, pierrick.bouvier@linaro.org, qemu-devel@nongnu.org, 
 sgarzare@redhat.com, thuth@redhat.com
Content-Type: multipart/alternative; boundary="000000000000e40364064b801f46"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=arunkrishnak2407@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000e40364064b801f46
Content-Type: text/plain; charset="UTF-8"

I am reaching out to you regarding a potential GSoC project, as suggested
by Warner Losh.

I have been researching potential areas for contribution and noticed that
QEMU currently has several missing ioctl calls. I am curious if
implementing these would be a suitable topic for a GSoC project or a
general contribution.

I want to be clear that I am still evaluating this idea and am not entirely
sure of its feasibility or scope. My current plan is to focus on the
discrepancy between the ioctl headers and their actual implementations in
linux-user/syscall.c to identify unimplemented ioctls. I also noticed that
the current automation relies on regex, which I think can be improved in
complex cases.

I am interested in building a more reliable method to identify and address
these gaps.
If this is a viable path, I would appreciate your guidance on how to best
approach it or if there are specific areas within this topic I should focus
on.

Thank you for your time.

Best regards,
Arun Krishna K

--000000000000e40364064b801f46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I am reaching out to you regarding a potential GSoC p=
roject, as suggested by Warner Losh.</div><div><br></div><div>I
 have been researching potential areas for contribution and noticed that
 QEMU currently has several missing ioctl calls. I am curious if=20
implementing these would be a suitable topic for a GSoC project or a=20
general contribution.</div><div><br></div><div>I want to be clear that I am=
 still evaluating this idea and am not entirely sure of its feasibility or=
=20
scope. My current plan is to focus on the discrepancy between the ioctl=20
headers and their actual implementations in linux-user/syscall.c to=20
identify unimplemented ioctls. I also noticed that the current=20
automation relies on regex, which I think can be improved in complex=20
cases.=C2=A0</div><div><br></div><div>I am interested in building a more re=
liable method to identify=20
and address these gaps.</div><div>If this is a viable path, I would=20
appreciate your guidance on how to best approach it or if there are=20
specific areas within this topic I should focus on.</div><div><br></div><di=
v>Thank you for your time.</div><div><br></div><div>Best regards,</div><div=
>Arun Krishna K</div><br></div>

--000000000000e40364064b801f46--

