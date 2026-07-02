Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1ABC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 10:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfEhy-0003UY-Kn; Thu, 02 Jul 2026 06:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wfEhP-0003KJ-Vz
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 06:31:24 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wfEhN-0002NJ-69
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 06:31:14 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6986287534eso2765619a12.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 03:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782988268; cv=none;
 d=google.com; s=arc-20260327;
 b=gNUUTE2YEEdYX+ilf04dPLZjfA87PI8ctz2vUwtD6JQyc931iamKbDx3pgwce0Pn8X
 6PVr2jvgKIpit0IUYyoTrf14mUWABOdwskm27qWBZsgvLM04GGTlCo9Pm3q+UC0KqD9s
 2Iqb8CSj6vNYrAtwDhZ/iNyKj53fqsuzcC8QX+5swwrmmrgbACsikd3RRdzWDQNU+JKj
 obnfCQru7NJFxubLTmSqCgVkR4r4Ht2/9Fy/SLI5DP7F/EbaEwcmoyPPuiUr0l2F76mF
 axQMD3m8THh9zdMVfSyQCBQfqjb+BWjz+AM/07ZVS5ugK1URvcRRFCdUtGUDRa5jHKyR
 Xc6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=RCqKSiW31byNbxauWgdPrmdBt0IGsjWahfLgIrEmSzU=;
 fh=I3z4n71ZJ06q82VrQmuhTux95UJ175dzoVedP0PBYJM=;
 b=UimcZvZmObNwqs2CUTzGBvRo79MiIDa4Dgcj8NqJGXkl5puqZbx1k/55h5gclziyvc
 Z0PmD6MqfDyP82W46DJHd4w++K5mtcZYzY7eA7qGiEzba5ytqrkLODss8hc/UlDyYAFV
 GXmZSKuadZ/ymQjwLBrxFzSArPEvgtIk0ZswzJ5OqL1hi1Pn7Q5GXfMtcoAcQ/tX0Q0d
 nDdME0wPC6ijh9WW0Rob0R69Gj57CLhniaHQ/w6iVMyn7HhTTip5VCiTNFnY5yfLsCqp
 kxcrXSbkmG3ejHfENuH722dOVR3X44XZm+3ggaqoUd9PPPq09K9uSlfpJNjqovtfDKeT
 ps2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782988268; x=1783593068; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RCqKSiW31byNbxauWgdPrmdBt0IGsjWahfLgIrEmSzU=;
 b=oGQpJGBEp6DNpObGzkh3DKIZ+VJEqUCC6l+5v84NRPJozEfadxNcXKpVjWTSxJ50j3
 leNxzDgtO+/gGe4LGpKHQwG2vEYERioSODlqpgCyq3m70y2EpQORXCG4FSwWjCmScEx8
 I9BNBHV1ydQNJEMoLmfvlVkZn9U+jJB63gxabsE5sXhz0QHgtaQV/w+E2aGoWJWOj3QU
 psaWXUjsQ0lKMJhY2yH20ICa5RcwOBcTVY+UzahIXfxlZRezqIfP3msafd03A3CPHLHr
 bLt7NsX9TrX+Xeag9gweFmLgI/E7GCt5XjzM3L76s7ESqz9+cLQbVZKE9ucBOFTNEuHA
 yrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782988268; x=1783593068;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RCqKSiW31byNbxauWgdPrmdBt0IGsjWahfLgIrEmSzU=;
 b=CDnIp1vpH59uZChl0e9eIBdS6nORc5vhkI6/35baiTxNT8JskujzQD5pN+7hbWU0if
 2ySa1BZx41hg21uWxga/OKCfeTUDeQI156sVDxHaHEsa0CK40UQD/MglYE3Lpr/cBrhx
 cqx9tyIHgMpOwuGEJh8j2/6HkH3OIfPu1WK79JwfYrqO+3w9SkIbPA5ooknhPgaw6Ovk
 RN5DF5tWfrvY9gcOGetjw4J21P3LT+Dezi+DCyl37pcWi7GB12BeTTOLIXGq12BAcREq
 c2PaKQvi6qj23dwe7Vm91VsuYziQMThoajSkIoLpSkOFR6kl++SoP5gBcTmMpUqrkPc1
 T3Kg==
X-Gm-Message-State: AOJu0YwTDuNW3sc8kP0WJLC6s9OAydls5hc5XIWxDjZDzo4aeaBrS+GT
 oPy/YNk7fpA9If24TVO7Y+Pzxv9+i0v3yFw2riJRIOl73I2y6IhhHMIUqWixsIBmfOB0asTrZ8U
 1KrxkiQ89JLo3QakhH2aXqxNHFGdvjwk=
X-Gm-Gg: AfdE7clYP3Gq2wqsfjRZdX56tF+/N06JFx5oxnar1pPl7v6Gnm9EVCcpcFcqRjEQkF/
 rSHEXqk+QmhSrvCVhS2aVwzMCnLPbMseA+jShn/NvGw6J7Sxu9kkvqCWpEqRqXRI4r0m3iXSNbz
 /n2yvxuDsQpATc/l4tWRtXP7Ae6nvSK9lgIijitNbyBFWF0mOiUdeB/kygybVKBuMwC8u3K3T00
 B8cV7bcLGJztGubt54b4t37njA4W305VwksvRMlVCAKDgiyRbm+91pb/CyJqrFI/jIdYxi3Mi2A
 mvT5J46CSnB4iZWZdzN0UkRpRdw1zgfnQDkvavwQC4AHZKn8goVavmXeZ4dGfmtZR9Sy
X-Received: by 2002:a05:6402:40d0:b0:698:3b7c:be67 with SMTP id
 4fb4d7f45d1cf-6989f394812mr2481072a12.35.1782988267632; Thu, 02 Jul 2026
 03:31:07 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 2 Jul 2026 12:30:54 +0200
X-Gm-Features: AVVi8CeQvaoIlWLMU_H-1mZYjNf807wOxl4qIvV-yZ1LOvAxVhnapYesu-rfSsM
Message-ID: <CAJSP0QWjjAz_A6z31TTpV1hU07+K9pstnd_CNyQyj+Zc6ssZcQ@mail.gmail.com>
Subject: OpenSBI docker image RISC-V crosstool gcc URLs 404
To: Bin Meng <bmeng.cn@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52a.google.com
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
The docker-opensbi job has started failing because the crosstool gcc
URLs in .gitlab-ci.d/opensbi/Dockerfile are not working:

#8 [3/4] RUN wget -O -
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.3.0/x86_64-gcc-8.3.0-nolibc-riscv32-linux.tar.xz
| tar -C /opt -xJ
#8 0.510 --2026-07-02 10:11:48--
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.3.0/x86_64-gcc-8.3.0-nolibc-riscv32-linux.tar.xz
#8 0.511 Resolving mirrors.edge.kernel.org
(mirrors.edge.kernel.org)... 142.0.200.124, 2605:f480:58:1:0:1994:3:14
#8 0.579 Connecting to mirrors.edge.kernel.org
(mirrors.edge.kernel.org)|142.0.200.124|:443... connected.
#8 0.643 HTTP request sent, awaiting response... 404 Not Found
#8 0.805 2026-07-02 10:11:49 ERROR 404: Not Found.
#8 0.805
#8 0.805 xz: (stdin): File format not recognized
#8 0.805 tar: Child returned status 1
#8 0.805 tar: Error is not recoverable: exiting now

https://gitlab.com/qemu-project/qemu/-/jobs/15145227587

Maybe it's time to upgrade to a newer gcc version that is still available?

Stefan

