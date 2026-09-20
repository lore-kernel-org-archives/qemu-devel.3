Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D23BC982D7
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 01:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x86Kw-0005vX-4j; Sat, 19 Sep 2026 21:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x86Ku-0005vJ-VZ
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 21:27:20 -0400
Received: from mail-lf2-x10.google.com ([2a00:1450:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x86Kt-0006hZ-Ju
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 21:27:20 -0400
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b5e4f1e419so704158e87.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 18:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789867637; cv=none;
 d=google.com; s=arc-20260327;
 b=exncB88T0J1aj9qJm89d7KqsuuPSLrpAX7EXMtyLJ+UeiFpSAWzR+IZab/WFXBmuSM
 YlUPHJZSEQODNB3QOt01r/HuABC+GM57HqWQeX/G4j25r35UnZRfYOf/MswkSbHRqn4q
 YT9SrpSjFfFY/vMRWc8/yQXP5ccD2nMrKNQsl3cRtjMtUm/zBSgAQURmPbHdNoQwXNQY
 9sh9jYtFmo0h3kPJIrMjMULIgG89BgcsJdTCZJ9RBX/sFrqP9luEGYv68UH/0WqUBZIo
 ynlVMirl8UMRAi5fBDmXrEgCe9luFIG3Wnry9idpRNMuMq5vM6J99I7LDwJAIeiIECRD
 HnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ASqCZGyBix2GBlo0S88bq5uOVYWZ3h7hj6mYqSymFZE=;
 fh=As83UklfS/tEI+2YiN8BqNnyk+rw8YeizYHxIK03tjk=;
 b=pS4FENaHMJjEtzkMs7BrEYIEGuD6cssWxOnb5lZynLIyX5Ze+K0vmE6K/OeDZiQqc4
 VWivf1T0U7JFnGC/lFladhSFpv6u6tl/OkfTcQcNzNB6MThu/cUEey0doEtRZEWmshcX
 EvfExBbLvJHAYPMQytZUHMSw+azpCUH3Y1gqw5ZX8J4PkD06lwcRmMlslTGfKNBvwzLw
 qhrmr3QWrG4jSefqFjGzMRg5lgH0UBFQubJ8oiUmIU3mtZMk0FaX3LER7PW9tL2JKERd
 yzp/Q8bJodktWg0ORP9NLL9SzBbeNZFSzyuG2qkTnFX0IYRebksN+Fyg/gHWk53jbMZQ
 d21w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789867637; x=1790472437; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ASqCZGyBix2GBlo0S88bq5uOVYWZ3h7hj6mYqSymFZE=;
 b=k3KKYXBU7qx3YXarCFa6pMtk9dqL42f7NFiznCttiQMgLCZIvR5ZuiBfYr1MYBLUtG
 tNoAVR8wepel+FhYTraqFJCXdGV64laWSHnHYIr9WPRVmIyKiuJhLe25+0BWOt60HhHW
 5Us/GE5fVRvZ4e/Dmuj1Vn30LbmtFq0QAEqVhBmeQJfhhcNBkKieQO/SabuKp22AhoTx
 V/PwRSYglq4XAGiUdvSWwZa+eFAY84V0ir5L5Mo8+pIhplM2Vbm1xtpN69qtMWfShdqd
 OXRJSpCZcutVzTniO5ayHqcM2PIF2u0nVYFsONb3YSASfwl9lS/lm5y8jdbMQqrQ579m
 xV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789867637; x=1790472437;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ASqCZGyBix2GBlo0S88bq5uOVYWZ3h7hj6mYqSymFZE=;
 b=E/UxgNzoYiZ1PSxpxeRDjLLMZPxrkN2UJoHgG6QZ/oRU1dcmM1s/GoJtjFBYLI52Z1
 4eBkCuixXAet+lIuj985pLTO0b1DgRzEARoAmHtx77IBm65r2dsOnibR5nvRZeNUodyF
 WKBLw55WYMoD8tXk7ImpVw8O7wH6NWN87xuNCmFeszzzMBQruoiwy84ZXEYmykKQ8vHq
 aN6Haa6kAntKeq0BsNrzGGSzlDuPlecyd4uT29jpltD1/DEvCDqGdTAHN2VAh1uU4B0q
 xz5B/ntsL2sDI2pR1MBEJVAEBKHLFQ1cjtTiDdKy8ociYOsyBYYdj0rDyO3EgXyEYEvP
 H1Pw==
X-Gm-Message-State: AFuF++k6Coa5niBr1+S88QNWu1Pa1SV5OYAZWzrtnIpnwp/BJ+AY7ByL
 B73Orn0lYKvJ5Nse8kKCAcmDAJ/ztumHjxblKY8TgkFBaHgxY7FwgshEWWtF9vizShReWZYNsr9
 /ybLBqKuNdtpMa2OUNTreMs8562i/Dt0=
X-Gm-Gg: AYBFou3y6qvc3CJ7PdRe0JXVnzgPAw7X16DU+0TSaDpQFVoCjl9Q19xBSEIqiaoJuIL
 ksImw+94im60Wawrr2QPmSA5sGUa2RcUXR9tKCKfXwN9TN74Fcm5OFjpx3xJZtgKfe23Y6MdrdN
 eOfVzhM1FBpNzYmSEiJDhmAOqG2MDQrHBl/JFLvhGwiKPKef/+VfR5rCqTQR2iNSF31XOUyD7I6
 /D0gIGw07ssWITZHJ2XCa3oHteM42I7Z66Q8hsW1kmWRlax8o6OK7qoPCW8BTZtckbULyNPTpJy
 240dQ1tTcCa70rl2aV6PddH4IkYTLCP/T9UGqCa6P/VJN2JOuLsTMALnCgufBCKzhEoG+8IbV4Y
 4wvQcEIIY8hpZ8A==
X-Received: by 2002:a05:6512:3190:b0:5b4:ab3a:8305 with SMTP id
 2adb3069b0e04-5b8c1446a1dmr1860162e87.11.1789867637271; Sat, 19 Sep 2026
 18:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260917220718.60899-1-richard.henderson@linaro.org>
 <20260917220718.60899-2-richard.henderson@linaro.org>
In-Reply-To: <20260917220718.60899-2-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 19 Sep 2026 21:27:05 -0400
X-Gm-Features: AcwNN1XWsz0GYFSwlNAUNTcMMSMq1RmiFw1HI1D4wKKSFFShRdYEnezpMk8AQoU
Message-ID: <CAEdQ38GUXfAvrgCjb6gqKk4Ph72HrGXZYo28QwTGtHZpuTaWOw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] tests/guest-debug/run-test: Add --pargs
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:36::10;
 envelope-from=mattst88@gmail.com; helo=mail-lf2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Sep 17, 2026 at 6:07=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add --pargs <string> to pass command-line arguments to
> the user-mode program.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Matt Turner <mattst88@gmail.com>

One observation: --pargs is only appended in the user-mode branch, so in
the system-mode branch it is accepted and then silently dropped. That
matches the option's stated purpose, since there is no program to pass
arguments to there, but a silent drop is easy to spend time on. Perhaps
worth either a comment or an explicit error.

