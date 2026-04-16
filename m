Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B27F8DFC3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDU0f-0006Pn-Qd; Thu, 16 Apr 2026 17:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDU0a-0006Ow-Gr
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:12:22 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDU0Z-0003vx-1w
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:12:20 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-483487335c2so92708295e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776373937; x=1776978737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3QevSFvKa0pcJKxRM3Y84I0qN7jGsotXoEvBJ7Whqag=;
 b=QvEfFjLtLFiMFbza1hKDL7LCQ2RS3bcnUv+IKDgO9kX8bric9sP2HaSFdJlKMCY6xY
 MS9t3Ckjq1c/rk+0zi+AE87EfFd/6nQYrGUBqllCLfbhmaR8/WtE4SWO0gYyshG59gpQ
 B0XAcSPwn0gdY2dZUu89H8A8FTTIi400BMojVnD/2tEDDuxZYtX8CgOUMD8gg3q5/XED
 5R1GfczebacmBe/57hGYAMvt2FMXLax7M1G4S7KawV/9W8mKbRK7hYvqMnD2cQmEynRO
 pcJmdWV2jNtkKoNMpTviqcaYbkXhYMraRVxBEPS8vhjgiYxzVHPyIV1MQwEYB1vnZxTA
 8JRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373937; x=1776978737;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3QevSFvKa0pcJKxRM3Y84I0qN7jGsotXoEvBJ7Whqag=;
 b=guGtvjwG60NETU7E89njcU7yHaVksojDVBlH7NQOECUxL7OXNNKIvebHanBK3v1/zb
 fvrAHRsNTdyyyeZR1b61CP48yOlVu4OU7TfAY5VFh6NxW/6qSic2s2qNnAGI+OB7Kq/R
 KO0cVGIrNAoMyb5HpOrmCHOKUSFwlqQ1PMnu16UtYrWsXCihYXn7u4MgUluiG+AoOmIB
 ucwIY+jvJdGDON5fONYEEHrCoBtETW+s0VI5WvChqtdtfdCrqvPYQCJTKk3BvmtZqoNC
 wwvKWpGS14oqVcTN8olfAJCnR/C9H8uuN0VXGDimQv8kdDVSB8z2omkWpocDYxyloERn
 LX1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ88ZiYtn41j/qZSzyZbnHDgaX1Tc2aI28sI+1wzkt6Q6eyXGwDnCmaHrJDAbEe/o1kv5uDJjKkUrB7B@nongnu.org
X-Gm-Message-State: AOJu0Yy2DIBWAHeVWHYX9GHK8PEm0rKFniaN8w86fGhyGor5BCWlw6T2
 g5MT/2NX4c1UWopjHdlVpf47Du8EKoKcRTA3taethB+Zj0pt4TON+9+NTbvFXBMmdXc=
X-Gm-Gg: AeBDiet3Vvdkyqdd4qK1EGg6m7jbt3Y/i3vurPzH/56J13jG7P6JBOqZZFpuwh8Nbm0
 RrN2cZlsThf2K/P9/k4bpD1g7yxqgf29YekR1SSP41FBWyqegaYZEfEhHOoPQkECxmeoqZtyidd
 hyvDxctZveeY4cfBW6Jm5cOkuwRFEpSEby/bpSmG8qfKS27Z0A92Zf6e7zQ0MCX1Lf2IdOEpAT6
 8Bna+DLCz/utjE8xOSrGz/0nK3TCMNsM4jrcZM4UnNA/goGGnrGH3aXNXJ59JsSpwmlWZF9JRiK
 dXoRlgNZ0O0Ovo5eJTnR2DnDhTJQlhynYqOPTsKVSblVBXzyw7vBdEUzkF2M9TI67pvmgVjcTcp
 gdRJiRkqSZjDFben+vnrjgaueX+r1se2umkK11wTONMXl7Ci1xNIra7Lm0uBjPyCUnphSlYtZ+3
 DyHucGUbJtl5xhVDgW7lbBStMM5bfhUQQthuVZKIhKesHv/hxDYT1llFMREV3pSWtrgB6pEkOm5
 Yna
X-Received: by 2002:a05:600c:4f0e:b0:488:945a:ed63 with SMTP id
 5b1f17b1804b1-488fb6e8491mr3900245e9.0.1776373937514; 
 Thu, 16 Apr 2026 14:12:17 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead401ca0sm14626190f8f.36.2026.04.16.14.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 14:12:16 -0700 (PDT)
Message-ID: <3fb10483-4474-4cfa-8e41-081d82a05158@linaro.org>
Date: Thu, 16 Apr 2026 23:12:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] hw/hexagon: Add global register tracing
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-3-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416210305.2255579-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/4/26 23:02, Brian Cain wrote:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   meson.build                    |  1 +
>   hw/hexagon/trace.h             |  2 +
>   hw/hexagon/hexagon_globalreg.c | 73 ++++++++++++++++++++++++++++++++++
>   hw/hexagon/trace-events        |  3 ++
>   4 files changed, 79 insertions(+)
>   create mode 100644 hw/hexagon/trace.h
>   create mode 100644 hw/hexagon/trace-events

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

