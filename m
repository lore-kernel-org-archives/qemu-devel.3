Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E776CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 06:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4vrZ-0004XC-80; Sat, 04 Oct 2025 02:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bobby.prani@gmail.com>)
 id 1v4vrV-0004Wz-IQ
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 02:35:21 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bobby.prani@gmail.com>)
 id 1v4vrU-0007H9-2j
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 02:35:21 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-30cceb3be82so1955188fac.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 23:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759559718; x=1760164518; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pFPthaAVh2r6N8QubvLQ9+/f0boz1xnnyNTgbYSJyZ8=;
 b=H1hYX9xBPoODAvRudZQBfs4sfIrH1rpogwdLTt9N+LWsou11c3Z3ZBbzkMpWu/s5Fm
 CAsIeBfbsIO5bPRbM2RutMQtdBl+uhPqUALdqVGDYv5oT2TpuJRSMKOcboSKl91xmRlf
 7fml2j0AdzqBvarFlkhJqjfUc1eYsoJF2+NJT3wwfubL66ME8OoxM8xBKTZIxATXSZt5
 idbWjaQ5QVDW8vsN1GIsUaojaxi3LoZihPt6RyOF+onhaSJMweKKZ457gASVGCE8atT5
 3LqLnaPhR7Pf7j68WBgIIdpMRx2GqSampT/J+SQ9XoMvY6KZPGyiy2cHfJRbeINvE9d/
 ZloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759559718; x=1760164518;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pFPthaAVh2r6N8QubvLQ9+/f0boz1xnnyNTgbYSJyZ8=;
 b=rEc+0uVjAomHH+m+gwS6gdQYi1Q78Mep/I5tPyldLPX3QA0pp7XLnUKXtyao+NIhI1
 oe7VGh/By8ukuz1lv1N2aYe+OvnKNRk/9SbVgJfTY0Fpf0JCArklrlT6iQXmdBLKr//T
 hzqZuSIlqshWgOHI0A60C4ncgV3wQ2GKxQhB5VI7ejxw5J/QtF2Hw3ewPCOFecWxHtnh
 oZyUPJI8GROczyfYazgrn+tOAyB1UPuWp4xmelYQzN/fSsNAuReMoeLZ+P01Loi/ZUyS
 GraORFt6knY99kmAbnPPviy+XEwEq/uTFEQc98mRc8PesTLFtX+nRhupdIlfUd8yxxhF
 aBFg==
X-Gm-Message-State: AOJu0YzyhN8cbTHyOnIZMNjfuvQyG3jcNs6Vf6VH2vZhS1L8v2HIUial
 0NuSkFE4z8oDN0ItYRShFecCxlYxGT3J6BiHs88YZPLpzEyHCItKIjuR5cAnyBFeA/IaoyyO6nx
 MUIZFpcpZZyAcRVDyU8814A65vlcL6LA=
X-Gm-Gg: ASbGncsbT+1oNEwnteXb1ZhVkS8qcImNIpQdQlB7Gjs7wc5xpGkRncDRCO6zf/pX/ou
 M+r7Hpt4HHCMhPB3puO8SCVOTiZlRI4sKse/MP49eqLrsZDuJ72cF+p7hyRUjedHbEHUcLbtk/W
 0bfQ7iHUhQoZHRnu4X//vN64Oqwr316cV8M+Kv8boj/YO/D279BuTIoMxQ8I/aByJ97sHCrfkiB
 At6xC/4HXWtedhm1VBIQjq0iI+suLmPgDLrrGreNFcjr3Cm3Ng=
X-Google-Smtp-Source: AGHT+IGwtHclAnyHPdGkaIEY4/GEGttqEt/+cry9InxPF0a1SYLCN8eTxIBcl5K52Z9xC+lTXLPJVqLBX+XF566t6nU=
X-Received: by 2002:a05:6870:243:b0:381:e796:fbdd with SMTP id
 586e51a60fabf-3b0fa24e778mr3197577fac.35.1759559718081; Fri, 03 Oct 2025
 23:35:18 -0700 (PDT)
MIME-Version: 1.0
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Fri, 3 Oct 2025 23:34:52 -0700
X-Gm-Features: AS18NWBVdMCYdQE4IPLOJfb_rs8OGHP4SfYjFFuoad3ATgCky4r9AybkhOIBBew
Message-ID: <CAJhHMCCfOqP6E2XvkY5JNtgQrXXH7uV_y9wfLcYFh9kecgocaQ@mail.gmail.com>
Subject: Reg. guest unaligned accesses in TCG
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=bobby.prani@gmail.com; helo=mail-oa1-x35.google.com
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

Hi Richard and Alex,

I am trying to implement efficient x86 guest on ARM64 host
virtualization where the host has FEAT_LRCPC2 instructions. If I
translate every x86 load to LDAPR and every x86 store to STLR, it will
meet the memory consistency requirements.

The necessary condition for using these RCpc instructions is the
alignment. The manual states that alignment fault will be raised if:

* Not all bytes of the memory access lie within a 16-byte quantity
aligned to 16 bytes, and
* The value of SCTLR_ELx.nAA applicable to the current Exception level is 0.

How does TCG check for alignment? How do I check if the guest memory
access is within the 16-byte alignment? Will alignment fault be raised
if it is not?

Any pointers are greatly appreciated!

Thank you,
-- 
Pranith

