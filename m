Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE7BC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 23:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts9G4-0001Uy-Vz; Tue, 11 Mar 2025 19:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ts9G3-0001UW-AP
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 19:43:35 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ts9Fu-0008Mr-Vu
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 19:43:34 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7c0155af484so828469685a.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 16:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741736585; x=1742341385; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=esNtTW+lZx2U9qNFnPzRyJ7WwTDg6VVeB867IcbnwVo=;
 b=f2JS06s+UqfbIgJq9WF0UWDgFvbnOItdDneXAu98QoDSckgmzLaVFcf7CLmTWIZZNq
 QVY2vEED5Tcz19D7SJtuppnftr4EfUuOT26UQqwFck6ptY4UBNsR0oNQZ+FUAYa1nGe0
 7zPmcG0889QRe/Vbxu4Br4FSpU0DvWC95QqHO1wY8Zpq3QmcoGKjL7E/kOjXqxlz7EWy
 YH3nybD+MQJ4ETz9Nv6RcPJbpisIGfAxMeFbIPsTzt85GXPou4kBb6FkEmXKoT/f9oRq
 JFs8MxJpR1jveA1Ol5grXsCPVJqSCqrVL7mobHO1JOOqjp0tKx/NPXBgg2BDlgp8H/gk
 VH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741736585; x=1742341385;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=esNtTW+lZx2U9qNFnPzRyJ7WwTDg6VVeB867IcbnwVo=;
 b=dSuWCR3jDh314OjjR9A8Gvz26UilB2PfYA8+nq+ySOF4lS9vjGnlfq5y1zjVh/ImKQ
 5spyDpVdWkAh0eFO4jLtX0Ar8aDnTV00tXz/HmxJX2944z8TbFwQ/YeS+VSBEEvE0NAY
 OM6gkyBuoRiQSdjpthQOUGCzNvp3qzJdEbRut21PR0/cPq02y8urdVj842J9/4/lUWTT
 V9VUYOY2hFKi8S3ZD2P1+es5BOyALczMuxLbSSUYnzNKC8MPuXQuu2oI6tSDGIX1wGLI
 MnONu1R17AYc/CHtnvAldJAKI3GWnZjfsoqF+daaxoOKAtVbnayylUib9qmw+YTLmDC8
 fiPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpnWZvzh3W+yB4D+6dsBIzoWVjUR86/kewtSwZ7n/8ZnfQsRYslc/0na/lIj2/0TO9xlUkz1DpVp7n@nongnu.org
X-Gm-Message-State: AOJu0YzBa5XESDBf6uVEp/Kc61G+a8QNnDFmjdHFEMS0Fw8dqsiJ9P77
 W0wGRh/jFRT8lZx7vh/pCcLXC2Z2O3ucgk2vcEJvjMNh1SvF0YtA1kvuXMZ05iw=
X-Gm-Gg: ASbGncuSwjp6C9Tp/oHwtEbXPMezLdTvsYGIEQhhhBLHCwKd0Egk0ZppBkCZF49bpAn
 uGKSUthsp/wxVaxvCUaIF68KmDJr9Y4JQ1vhsSwJ1ja/GdwycpVHOXanqHSz4RdwLVqqB+Ue/JG
 PC4nSE9RXyymoYCbHlp8pSmcAaubzv3zsmkO39KSf91K1jyqtgh7pUSKF8dcMz6Y95JPvQtAiJx
 Ve9dDgEMuJWAcv1JBHA9KmahJ5ys/9x8YTg4E4XSoAm1kuQZrDyzR//iyhHUnKrvXxpxHMRDuWb
 Jv9+z3XRMTWejoqa1VjieRF2BJEV++K0FyE8O/D86lQs69ktmT0/xCAdrgYnj84=
X-Google-Smtp-Source: AGHT+IHP7c4VJ43uKzrNZnXmgjSShuyibE7GYoJAw+bOwCGWvXkvIXj8H0Lw2ju/iRHKTSnHQbgMGg==
X-Received: by 2002:a05:620a:6885:b0:7c5:674c:eecc with SMTP id
 af79cd13be357-7c5674cf064mr422488385a.32.1741736584647; 
 Tue, 11 Mar 2025 16:43:04 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:a832:3b35:d71f:4119])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c56a596e5bsm14272985a.1.2025.03.11.16.43.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Mar 2025 16:43:03 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-33-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-33-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 32/38] target/hexagon: Add stubs for
 modify_ssr/get_exe_mode
Date: Tue, 11 Mar 2025 18:43:02 -0500
Message-ID: <00ad01db92df$54cc0260$fe640720$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgLJQJfTtOy0jkA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250311-4, 3/11/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x736.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 32/38] target/hexagon: Add stubs for
> modify_ssr/get_exe_mode
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



