Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9076BD6DDED
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 11:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBucR-0002l8-D1; Fri, 15 Nov 2024 06:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBucP-0002iv-N3
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 06:36:05 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBucH-0002DG-Hl
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 06:36:00 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c9693dc739so2388468a12.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 03:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731670554; x=1732275354; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tjxWCAQ7tL0VCYC07+J4VybS8cYzfmiCOEW4VumHzx4=;
 b=TEm50CX5nmQadwD2YSFv1Cr0EK4akMJuOlT0MX7v0IX2DW61eywcGwTm6yoPMayuQ4
 3SavXcaxMBiNNJXazIV5s8q8x9uIg4iItrB/A6eHGsJXzFnPdO5S/AagvioCfQOgRmVn
 bkTPhga5sf/C/xWSTeHJeFpeTkML9a+/KeDc8U/P4hmQt92rGgXAqJHtDVd7mfl+tLdH
 msO/0jocYtZ/K6WcL2ry3e4+NaOGMDqlNkipFwpSE32zac3mSWpMGxglG3Nyrrx836X0
 um4PqhG9pbXJ55AqrhXDNRRlsJKiU1JHQ71tU/PUXCl2N9QunkJFILvJcnn2oBbzxDGQ
 hxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731670554; x=1732275354;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tjxWCAQ7tL0VCYC07+J4VybS8cYzfmiCOEW4VumHzx4=;
 b=mqpHxH9LICUoPXq+t00F2Pw8ciirFbWCY0adp4bWCtK44sZWDSdqUZ+F5NjqUWei5I
 6j/5uHHac/jUWtCBoQA72Wivh5oyZpM6i5dZFh8EQ3MBNjAsbKCsmKSydyXBCJr41fy5
 KXrAFhysBeUgvIxg7jaFskFKODSiaTl2wa+SGWjlp7RSqhF6fZg8ITa4YjuPbJei5hG5
 Gxouug+kjpGmYMKcdEfPTAUK4I5EZf0rqgTfyYQ2zcBG21ypnzxbr4s76tWyqSWQibER
 UkMMzTxqlRx85nrlt5Q8d0zlTLdCn1jjnFinL/QR3hi2T58BvpEy8YqE7N24XB/oY3Rb
 lCpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIbploC48iJwVpTNNePx9lhyZEUni+0Ho46A6DrcgBEyZ1YeevsFBGormdLl5MjAY6LD/snLOleqls@nongnu.org
X-Gm-Message-State: AOJu0YyMibCwMdsDo79m2zfHZnUtgySjL+Q3SC09mE+xvw1hDhmuWBiv
 GXcA63UY3USjJa7kAkRaRrlBgbCVvJRr6m84xqPYsshDG/+sUtED0Gm9ZgCrsAWInOCM8C03u4k
 PekLCreyf17jV3P06WA17v3PvaVEKSurmX1nfDQ==
X-Google-Smtp-Source: AGHT+IHnybV07eZMGeRGUOWXHMquvslvm84jbgc9Atw2Ows/hliCvUZgysxtDoAhELIxrhzeunzcA6Ap3Nijq54eloI=
X-Received: by 2002:a05:6402:1941:b0:5cf:9c92:f803 with SMTP id
 4fb4d7f45d1cf-5cf9c92fb7emr443706a12.30.1731670554489; Fri, 15 Nov 2024
 03:35:54 -0800 (PST)
MIME-Version: 1.0
References: <20241023000147.34035-1-iii@linux.ibm.com>
 <20241023000147.34035-2-iii@linux.ibm.com>
In-Reply-To: <20241023000147.34035-2-iii@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 11:35:43 +0000
Message-ID: <CAFEAcA_-b1-j5hjsE6nx2HsXP=eYt66WqHPUGkw_h7Tp-N2JxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/s390x: Fix the floating-point multiply-and-add
 NaN rules
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 23 Oct 2024 at 01:02, Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Order the helper arguments to match the Principles of Operation.
> Implement the "Results: MULTIPLY AND ADD" table in pickNaNMulAdd().
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

