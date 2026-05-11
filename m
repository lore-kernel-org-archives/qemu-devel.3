Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD883CD37B2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSlS-0006LY-UY; Mon, 11 May 2026 11:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wMSlR-0006LL-N1
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:41:49 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wMSlM-0001ff-Eu
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:41:48 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-67b6a6bd7b8so9237933a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778514100; cv=none;
 d=google.com; s=arc-20240605;
 b=e4Me0o71Y2sFdNv9z73JHeoAr+18VCf2u3d8PKFy7EmRMTnxkRJwl9mBP9mI3HUvdX
 iQP2A2VQACt+otEe+kUswNlLz0MG1QRE/N/vzlgm6QZE3DDteZ+rFiDEuG7rcQS27GYl
 uk5lahsPraT67pCTZHeCMXKYYKoBasXCVXHVismWSrufnfEVVIXc6/Rb0BGVAiuEfu35
 GSbY/ChO9SpSmq0zUKbKolXG56xXww/utLXJ/pjrHfZO9MJzB/xQZyH+pSg8CEAsyfmw
 SXV024ZaeMST5GZxLDgNoNFUAffjOpNS48zk5B8tjOu1Z6/YzoSSi+5fbSHptMYptSM7
 bX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=x8HibxC7ANepOUfH956M/7+a5HE2oRqSkUnPyUYliP4=;
 fh=LB0Jf5c78D+DGLUBMeMmlBa74IwZzQF/oYRpwkzmAl0=;
 b=bVajXfIGlal8vr2YS/t94x3RGgnl3L+aUZZrNsmzTcsYq3ooiqY4A0WuhP22reYqyE
 ceVxnXLiH0/rQKnyIDXBCRvkmuUl7rcubFYGP/5iSrJUBzD37cCXbla04FSvP19fsAed
 83BHpHAbAs12kZNCoJB4Xm2MixYmt8747ORwvnXoqLpESaeZrXPlMGxZoRymEUYerEba
 AACq9OMvrdk0VjhKtSJ5bR9GK8FBuM0C+rxYfgD5fPtLai5UOHKOOc2VLGmTmoyn9+Sg
 onmF70GrczSv3Twuc21e2L5p0eT+AP4Otz6dGoQ/tUSxlzVJ30xuFRUYLn4OrN2Bm+1z
 pGdA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778514100; x=1779118900; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=x8HibxC7ANepOUfH956M/7+a5HE2oRqSkUnPyUYliP4=;
 b=s75HUwbAAHDDg76Hlp5Zg+BdiS0gXaJBU+t9i339ZCdpHm84RgyhmEBRPOI8DtR7qT
 j+3SGqW9eNkofOnUuMTkMoy29zgIPHbWEcrwMgEaZrO8AZ+V59oWgVObfE/bKAqxXQ9u
 XNk/LHy6gXVVqBKM0qMJyPlHmo8vJv/NSK5vKGYyIWUdQs9dzchXJL9j9s4eZPSK6GTe
 YPIKUhPgbg/nFOE7XKIGZT5mjmoYkAD2SioZ+ObBKa/EObTYoixFrBtlLSZ1p+vbv+19
 qGKUNp1FbEq02dIKOng+rYD34IKWyvMrBno1iLwUfr8EnWMXYl3WGmcJR7b84qPiYlsD
 S3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778514100; x=1779118900;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x8HibxC7ANepOUfH956M/7+a5HE2oRqSkUnPyUYliP4=;
 b=kZ90uy/agVPFYZogdqlJ/7kQJ5u6FSkcgFywAH/wPAfESHnZAdMP8+/jCjF3QUiTZz
 dSdqzrIyLS3tQvZMbmwQ3dg36bzhMmW6n1YBraW/efUSrxmfb6CEOkOP3kCaNTtRN7H0
 nAlzUq1qNHAtGT0FaJYSCYJ2u9yF6ewbw/XQnYFyhZzx44zFTrB7NC4QtTA++AIiP92A
 KDP7yb2Q0OR0pwZjJHBNlKqusJ2PIHop8q5xTT8DLT/S3vHzWz5T/EH2PlVvDB6EuLUu
 4x9fgvgfhZLZAw3U353PCtnO69+/D7agll4XV/K3/0Cr9d5MfuB6scBEtBmIeDog/JDq
 49DQ==
X-Gm-Message-State: AOJu0YzNujffbOcf+n55HiRZV/7D7ilrZpN+46DTjXBffqKeLLw+9WoO
 ZiVp07WF2LoRzieg/TMcpPi+GSEBCEFgI5ccyDiaQuxQGMRQnD0r4XdSVGTL8FY7SklzglhtrWx
 QDfWm3DEMTq1JbPBTJASRC1NDDBziD575P7FzQZg=
X-Gm-Gg: Acq92OFdW6oqFXZ4dkK01Ox1bIxPQCPqCWpdl+iwujTjsuRDTzNE4yFX6RN7E3a5adW
 x5VOG4tudVzUlgtjSul953RNFYSkK3pR0aDlAiDt4oFLMY4ywc4xPxBKmfRoVyUE48Vpjl2g/aD
 N4RN/m4HZN/CGzvQIKMLsSPTzsDASzYlQiWRMyf70lHiqBfxGQH35O5Sdm54ciGv2vSzA6XR3Mf
 RjwgYzd35xZjroo0v8NOFhSPHILwRXBa5XeYnwiKBG3DM7YpVvrp9OzogtzNGaT8NmL5JnEE/wm
 WhrhrUaYDTt+oePfiGVkAUWGqWR/hX526KcrtA==
X-Received: by 2002:aa7:d354:0:b0:678:a5d1:ca74 with SMTP id
 4fb4d7f45d1cf-680b35fe35cmr12881a12.16.1778514100138; Mon, 11 May 2026
 08:41:40 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 11 May 2026 11:41:27 -0400
X-Gm-Features: AVHnY4IuIfh1zmaM8BNAWNTaMQjozbPuvj2tl7nyOnQpjIzd9ML5F8EbaELEe98
Message-ID: <CAJSP0QUsXh5uY4rOp7vK_6pK3ctCwGCHgtYXt4FLDSmBMj6VSQ@mail.gmail.com>
Subject: QEMU 11.1 release schedule
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 mohamed@unpredictable.fr, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,
I am proposing the following dates for the QEMU 11.1 release schedule.
Please let me know if you see any issues with public holidays,
upstream/downstream releases, etc.

I CCed everyone who had more than 100 commits merged since QEMU 10.2
in order to bring this to the attention of the most active developers
and maintainers.

2025-04-22 Beginning of development phase
2026-07-07 Soft feature freeze. Only bug fixes after this point. All
feature changes must be already in a sub maintainer tree and all pull
requests from submaintainers must have been sent to the list by this
date.
2026-07-14 Hard feature freeze. Tag rc0
2026-07-21 Tag rc1
2026-07-28 Tag rc2
2026-08-04 Tag rc3
2026-08-11 Release, or tag rc4 if needed
2026-08-18 Release, if we needed an rc4

Here is the wiki page:
https://wiki.qemu.org/Planning/11.1

Stefan

