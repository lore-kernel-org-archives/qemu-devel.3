Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E349FC5321C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woLl9-0001PX-Np; Mon, 27 Jul 2026 09:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1woLkz-0001Ok-KW
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:52:37 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1woLky-0005gV-8H
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:52:37 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso3733850a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:52:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785160354; cv=none;
 d=google.com; s=arc-20260327;
 b=A32Nn9hH+Iu/49avLduSfUngTujbYKqGJHmex0hG6XdqEzufEsCrpl0G3KAKRfcMcz
 OftFcsrDp9hurFmfaYGjx8as4d+OChfum7worAk/APdp3IXMYnPz4XEUplonZ2l3uZ60
 rspQz3rbXwxfYQefAAUSnlTtQ26WCDJB8VIlgPIQiZCvZdpFNwt37aRzgST05xGr+aDz
 MEGOILFOKjAU2Z/4QFNofpK03fne31feDwpJtYXNpfmHCtIKk4BvFZVZ7BG7MP6VYhX3
 TW4hRa/W6fcZOkrUKW86DFJClsohnK7OyzXt5zhDefArsJ34MRwqaGOmIph0UKQkltMe
 2fiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Q0NaRC4RzFcdN8VioE5698r2JpyUMJ6iYVxr5mkJoP8=;
 fh=mRBqdSZrg4oP4hT1rf/4XEbPabqmsuyhG5HFn0z+hms=;
 b=Rv/srYG3/NPIezH3cqB0f3u/tQVnpqOTkvHzctoMFMCQKDRsNx1HVTKAxLXax5Z08Y
 IuhzUpWynyaSnc6D0t7WHXKsx27I3b7SHLLDtr0dgDjf1rxotGWK4KgoRlglMR2klUcx
 4YnHDvMfaf+K6xU6SF9Bf71cBIanusleUl8io7QomQEUjJrQ8YOL046LKfscPQAkE9Hp
 8MYGHjRWruHn1jrh03lh2wzgp+hM5sjUsF5REVptFIoJZmUwG0Nv2izWvzbFk2efYnp9
 Bug+1JZq6ZGOmH65zsJruSsLQMTglOn9+gvpur7tT2TWChp5fovXdxFWURhtBFJ7NwVL
 62Yw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785160354; x=1785765154; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q0NaRC4RzFcdN8VioE5698r2JpyUMJ6iYVxr5mkJoP8=;
 b=TTu7d/t1GPuCzcHW0f1hgg86VGpAu4daEvdwKt9zorKYJlJN73MtYCdWVl108JTwY3
 RacBRq2KjQ50iZUlfB/+y8Q10SwbrmU/mxPFrv3L3HPUt5yQpQ+jK4HxYnruHIVPWKgd
 5oFN5FSK/yXoeouRkqwsbLItOM7OrA9knVtSrYRK7E57C+y952/N4Rn+GeG97RAvW4Rh
 icB/688vNBt4ly3txw+IiyP4ncjwa7PVU/SeBbV5ayabgf/QVHdkPWez2wOKyPKOWHsB
 Fytl5q0lfg/z/Exdn/tpYYCYSDmc1nJH2fkQWPGtsz0Mmb+MLq2IzkJPK4u/v9mUuTdz
 G4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785160354; x=1785765154;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q0NaRC4RzFcdN8VioE5698r2JpyUMJ6iYVxr5mkJoP8=;
 b=hmD19PewRzSWQ3ztSHc1pzV44rDztmaHm5REG6bo3pnE9tZt9V76+4mfIEQbPEWk6K
 ovmHYW5joGKPUohCa0vxUKYvPvPKxPC7ZQ8AZY8wTmqf0Zxohm7epT9aSEN7J58AnX3V
 ebM/f1JS6N6Le9pO0Fsijl7RlqPE2XdnwIRlTFWM6ZRqV1d6JraT9acF+3R4YPjzACJB
 g4TwPbjEIH9VzrDVqiotxt5KoGcLiRkb071CSeZimvrjPZSUD06KS5GVD6jtf+bKcZND
 Se8Afq453iQKHmHaWbHTtxIE3caNhHNkyHRnhmz6l2qtbFlzo+ashTDHbnBs433TgUqX
 5emQ==
X-Gm-Message-State: AOJu0Yyu9RGtsG7L2lbG9clKw8MzDsMhHLkjhx8V/d9TSkOOuc3nhHqM
 dtNDemfakTOpjFl9osJEtRSsXIaZnN35nqKIAjVDB3x0LM5KSM8+3MDtawSq7cJtHKFu89/ansF
 pe24h7UR419IxtXQVkxhtGwVQAN9LVwXxxA==
X-Gm-Gg: AR+sD112FW64YnSqFeFrxGJF/OVxvBknphKLnNSjTe+A9LqGXhKB/umbNnfZ7LGmGDJ
 fvQqkipT0z+EuEsXRRSMaZ72Yb+f2kv6bQCPT62PyvoCZeQx7nb7DoficHPajrBv91K4ND6topv
 B6ZYZ6oxHeCmFb2klabAKtkogFbGQs34D9rA9Uz3dnC7hb08U6kwCt1pgF8dOHebfpL3QGCwbLt
 uMaodnFSjerny/YUr/nlbyYSuDDTBDjyGT3tRugmVMz6WM9RS0gPB20OVcvmtQupxd5OE9ZYcij
 fzjWVkrzJU16T5KnHeE=
X-Received: by 2002:a05:6402:a518:20b0:6a0:c62:75ce with SMTP id
 4fb4d7f45d1cf-6a00c6276e9mr724166a12.30.1785160354018; Mon, 27 Jul 2026
 06:52:34 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 27 Jul 2026 09:52:21 -0400
X-Gm-Features: AUfX_mwTnMF5KoAlZr4o75cARO-0azF7KvclqITyu-ZZVIPrV0sD5oJlVrG0bDM
Message-ID: <CAJSP0QVRaqb6Au+s-64bouKqu7S4yPoQiExUuL45MnAWAp5p8w@mail.gmail.com>
Subject: CVEs and the QEMU 11.1 release
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,
QEMU v11.1.0-rc2 will be tagged tomorrow and -rc3 a week after that.
The project currently has a backlog of confidential and potentially
CVE-worthy bugs. Maintainers are triaging these bug reports and fixes
are being sent to the mailing list.

Holding up the QEMU 11.1 release for any and all CVE fixes is not
realistic this time around since there are still a number of upcoming
fixes expected over the coming weeks. Many CVEs are low severity and
do not pose enough of a security risk to hold up the 11.1 release.

I'd like to approach CVEs as follows:
1. CVE fix authors and maintainers should indicate the severity in
cover letters. This will ensure that serious CVE fixes are included in
v11.1.0 while less serious CVEs do not hold up the release.
2. Low severity CVE fixes should go into the -stable branch if they
cannot make it into v11.1.0.

I will be looking at CVE fixes on a case-by-case when -rc3 is tagged.
If you feel a fix is critical, please let me know.

Stefan

