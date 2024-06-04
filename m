Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2FFC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEaDA-0007Aq-Ji; Tue, 04 Jun 2024 15:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEaD9-0007AL-3D
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:52:47 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEaD7-0007AB-H3
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:52:46 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5b9778bb7c8so3369660eaf.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717530764; x=1718135564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zisOd2FXRld0oo3UDLNzFRd7bcHsRdxky1rEPxhG8n4=;
 b=SofcIDuBc26RMSNsbt0E0b4rjuIa08WNlNMdKamEtQIME3A73u7+r2bEKKoL4FPggU
 PnTggmWjqW1eTQB7jrlRPvNmIIh+HSet1aKWe2QgaZkRySD6eBP2EApBjGAHZSVPNUX0
 n6APduZZ943JhBEVGYXLwdVMnaWJiD7rqpXQMgNZ8G4ABrWR7/0yvIC5O1H3l4IAppB9
 aF93WWosR21DVii7TGTBC6WE3ko3QwWETLEreq7T3aZ70P0QA1xvzSyCkEp2Lk7pjXLT
 fOanRy/r56yL3ZXcUHpRpUXOM1NBsd0wseDpyDeLcDWHrrx602r570og1kxA6535abdT
 ejFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717530764; x=1718135564;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zisOd2FXRld0oo3UDLNzFRd7bcHsRdxky1rEPxhG8n4=;
 b=jeKv6GwecJ3o/2Lbeu0+wjLr154ltRIweFWRSASLR61nGQaqT6n5ngogfP5Rsy0ppY
 4imjBSdlCI9bW5infJxUElgB+QNJ6eM7h3MKXB3zrKy8vfBelReOofblgABxBvYoTGjA
 BwC9x26eNtnrMIdffvoCKgYf4vQnvCkRBocOIkMddNCKQWJf8h7outsBCsoJ4Np58T3d
 a0isyHcqpMxGMvH8AK5gPqNreqWshuHvdSBbRbMKNyeNVoFC1kDs5KLy7ssQS8vhoWc1
 jtVNfdsJBWJghqY9MQIIxGE8tHvKgksiLE4jWFsXJ5P/1uzPF9WBIj7ASGg0U+VNJM4l
 zdSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPUP4UomPWwJfndOc5C2h8qCU6l+iwwz+jQVTTbb6rnARNEIIPgF2ORwUKRC9/JSUwS7s0o+IuQLtsep6xcjVXFYFVFYA=
X-Gm-Message-State: AOJu0Yyzku5H+1iRTVlVCLJz/h5qaxl9xsTvTEeKrPVBm6B/54Pt+45w
 qfpxp5UhrnZ1QsonLQpkwS0o6UXKONDlQ/P8U9KILDeEdDy/vxH1mMnw0GkssaA=
X-Google-Smtp-Source: AGHT+IFkRU6UIwKKIPMyHnJvFuviGiMhV+7QpKPgF/JpDgd8b4V4FFOZMXcfjqlx3PaT1oa5pDWU9w==
X-Received: by 2002:a05:6820:1607:b0:5b1:bf03:d1c6 with SMTP id
 006d021491bc7-5ba78f2cf7amr674426eaf.1.1717530764060; 
 Tue, 04 Jun 2024 12:52:44 -0700 (PDT)
Received: from ?IPV6:2607:fb90:4563:8160:73fd:f139:21f2:408e?
 ([2607:fb90:4563:8160:73fd:f139:21f2:408e])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ba7aa54866sm50615eaf.35.2024.06.04.12.52.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 12:52:43 -0700 (PDT)
Message-ID: <17a5e0df-73bc-498e-825c-d3cfd66cab92@linaro.org>
Date: Tue, 4 Jun 2024 14:52:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/20] Net patches
To: Jason Wang <jasowang@redhat.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
References: <20240604073755.1859-1-jasowang@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240604073755.1859-1-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/4/24 02:37, Jason Wang wrote:
> The following changes since commit 3ab42e46acf867c45bc929fcc37693e327a35a24:
> 
>    Merge tag 'pull-ufs-20240603' ofhttps://gitlab.com/jeuk20.kim/qemu  into staging (2024-06-03 08:18:14 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/jasowang/qemu.git  tags/net-pull-request
> 
> for you to fetch changes up to dcab53611191f50cf4feabc1d8794d04afe53407:
> 
>    ebpf: Added traces back. Changed source set for eBPF to 'system'. (2024-06-04 15:14:26 +0800)
> 
> -----------------------

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


