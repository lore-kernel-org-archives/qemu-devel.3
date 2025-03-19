Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F20C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tux7k-0004Vi-G4; Wed, 19 Mar 2025 13:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tux7d-0004UD-Rl
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:22:31 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tux7c-00074H-5w
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:22:29 -0400
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7c56a3def84so692795985a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 10:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742404947; x=1743009747; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KjiU+cCoYGCd7mWHezuEwk2hYWtjIIX5319wYD3HIG8=;
 b=nnxBpW0lVWttV5c8rAhRZE0UVDb0wlKkV9rl3IP71qTZyoufCKFH5VObfzNNDvsEgJ
 jOxxWsDNgqaI8WK9AYjUXZ3aaseoRtWN6kgnCInYJr0VSUbgyBExUV92sDpBErx8T5+q
 DaDHc8glya48e3DqgaIosM+tMkIetbOU8U0Dg9detDykYFip6NVFf/8E4BekPFTxtoxh
 QIUAWyVg897/cURkHW1gxqeQep6QThJF83iCCPfPRDHCpm86zUU2CKiIk8rDSOmT9ehi
 MsLFm+nZA0uldOQnwEycsWcoegXEuWm9KCjsolDk+64iNxhcG1HIGB1ExICM97XjoK7P
 FhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742404947; x=1743009747;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KjiU+cCoYGCd7mWHezuEwk2hYWtjIIX5319wYD3HIG8=;
 b=dNlodiQw/58CcpSAVx6FUSzCqxBZzks0SXXPfDlenaDbnYAGeEEbcKkwh1cE1Texlz
 iGrpeD7u/R/cstF3eGxIL7VrUvkVWD7n7McTsVfXPvyY/jHP1w0uB/yoUZD1YM22B2pF
 j9+PAuD6S9ALIJU2ybhTNyjyvIEygaz33WX0iFfw7KY9m99esq1tHAhPaqQOiPX7yf8W
 9V6M8Bk9Zzi0R9YQhyYY4n4iUaV+ki8D6sVlH/GUh5G1qlFQOBOMSu4VO1dGWEIGCoVa
 vKReLAO5N6yEoNQGbbqQxIYRhTw1KuejyZgeBVSg6RNro0M9Ejxyt0Wv2AKz7fwUbc01
 BzxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTGyNm8DSrysRWEqz7kGX0yvEsttof+LEi6jMdzeCzORHF1YE+uW/FeBmlk7+EEXQ0hdJNGcTsqRzD@nongnu.org
X-Gm-Message-State: AOJu0Yxy8fwJ2NdIo2WQC1ACE8JvYc9ebCw5i5opxI/QF9jl7TpZkcER
 WpZxHv+RHtoM4UvVtsiAJT+QNQCPQG4dwGSSKn0iX7zVRYvQiiGN
X-Gm-Gg: ASbGncsyCKoWK0wIIZgzjO5kvdaCn+Yfmd60zFNXVU5yqHdT4/ihQIBJO7rnj4qaPPt
 0ChjR9BTaYiLFmaQWo2VDQPfGkz185znmjkVyjDMbER+fZjz0sUHTVa9I/eGfmW6y2FU9DOOShf
 zqyMHt+T2iJoQfiYXwA/yXZ5AufM/f0wmpkwBTgT4hZUeqb1ovPu17VN0BsgbgsR2UC04kcmfW0
 y+wRPT1bCvDbylHkCx6Ce39Z17/+4rAxRPu52U6TjeFR1TNPlCtVMNPA1qfH5kQcAGoqjVpNe9h
 psz9ZSJWIwLxpitDUm9vfuRFX6mrCz9cNxZKLQpNWbma3tSDYAkp2HiXJ3qnsHfh9L9fn6Or
X-Google-Smtp-Source: AGHT+IEpLcXS4a/UgcJWPduUDjKHehzb46qJ6Z6d3sQYoJ12rFTy+q7WXouNz9W4v9m7uyg2TplhRg==
X-Received: by 2002:a05:620a:444c:b0:7c5:9769:3da8 with SMTP id
 af79cd13be357-7c5a84a31afmr443510485a.43.1742404946852; 
 Wed, 19 Mar 2025 10:22:26 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:992d:4509:eca7:6f8])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573d72ceesm881885385a.66.2025.03.19.10.22.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Mar 2025 10:22:26 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-37-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-37-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 36/39] target/hexagon: Add TCG overrides for transfer insts
Date: Wed, 19 Mar 2025 12:22:24 -0500
Message-ID: <02c301db98f3$7c00be60$74023b20$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQFJ7wdmsvrxRoA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250319-0, 3/18/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x735.google.com
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:29 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 36/39] target/hexagon: Add TCG overrides for transfer insts
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



