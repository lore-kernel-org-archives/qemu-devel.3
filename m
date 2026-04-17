Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACA8F43697
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 13:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDitZ-0008WR-Hk; Fri, 17 Apr 2026 09:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDitV-0008WE-Qh
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:06:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDitU-0003CM-9j
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:06:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so9035505e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 06:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776431158; x=1777035958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlGZhjwrhiqpCrE1LDX5wOwnyIHSo4s9XbmnT1ylqZg=;
 b=WrFSjR3HXl3CuvYvPz/HMuRPiP9Ka/lDFbjW3GlCKhxVefH/qruyGYj+IexvjzPrsl
 ZUOgh8DKDpK2mhpqAgyOPZTWglpTZPFTFSW5xGmvIEvsqOE4Bs9CIYM0BQZXc27ws2e4
 yKQN+VGFFUc7pH2T7gXN68YsC8bFQL/+a/VQOlnElsi9YzqrFSTPNPV8Bx7xrZVjptQY
 K673cI7lTdpdDBk6EkRxf2G/gw/FhukyTE2jjNLIxbnMpkNwJk6JYUCJ8FDUn3EwYxRg
 zV2ryLxi9GlCkva6bNMlvGHtA6ZE/f2tKnJHeNAWotqJ+LyjaBpPfiq0B2DdMfvsIwgu
 K0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776431158; x=1777035958;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hlGZhjwrhiqpCrE1LDX5wOwnyIHSo4s9XbmnT1ylqZg=;
 b=I6jYL2VJhYJNS1R7zoan2p0aIBfHT5uQoqEaEvCSkA+TMLCewsfl0WP2FjjUewG2fb
 BxB+FENzPZZxqp/BrY8w7/+H5ornN1RXZcK23ZuczWnDYTZU1QBGUBmsMDZTyDYr+PXl
 LyfpJSwCwLyin0aAVTeMqw6H8lj4bX2H3cbt8XdSJjPfwYGfor7bQ25GVM8Z43VpOtMP
 +f539Cd7/HHGgL9seSo7vbRoG6HlkheNneHSteqryf6WD0iRIIjmoc1lOYuPvt8dTC7s
 GIrM7qUo1EmZUrbnL3xZnlzH5tCzqX8xV7Ju8JmU1jT2M8g7jzAjrTr+It5fAlWxCQ4P
 l2jg==
X-Gm-Message-State: AOJu0YzNL1f2IU5tfwPfB09yApujWymf4M2V7t/RXR/fWKOOUT1g+SS8
 KchdKn3zYCfZ1hRLQThE59q1ntJErrMqKG7j+hRHUdp2l8wGKmPWy8pnkfLGHQ5LywA=
X-Gm-Gg: AeBDievYjmd4LUd8bHrMRbbaRPptsq4J7cbbePNsxG5EQzJbU+g8tsuigJ91M/vJWhF
 O8iBNrYhnlIaHUzn6EB8he/3jPS4TGcCrBztikTqf4BBKUUET1+MTUYG9unnsBPYt7mzQ68yaTG
 vynIN5qmlAthvLyOR0Go3HksmgOdLcCGbOwC5fG2L+Kdz6eG2VL2QuHwxAS1kqgKUBz6lhre8tw
 HcOMdmaNbsDt+blgipRrU58Za53TFwiO1HhzknVNcdcxkeioITjr/sBO89yVHsOROmKd+2iSv6A
 QciIlkAIXo+y16xLS+GCBUxa+neSTXwlgNvynpeDfvtU3uUwknkEBbDPtMpJ7YjuDjX4Ae7qor5
 DDaS3E1jngMEGgKgP7bYIQdyV2RBV7ta5d7Kv6o+tiQkzR70QSDH3ZomIs49lFJJM1MV482XqNN
 wtOXecaJeQeeYcl7zno+99mf3eXqsDxnC5Gg==
X-Received: by 2002:a05:600c:a108:b0:488:a82f:bbb4 with SMTP id
 5b1f17b1804b1-488fb78a0famr32375895e9.26.1776431158340; 
 Fri, 17 Apr 2026 06:05:58 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc16f8c3sm40973365e9.2.2026.04.17.06.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 06:05:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D15D15F94F;
 Fri, 17 Apr 2026 14:05:56 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Mark Burton <mburton@qti.qualcomm.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: update address
In-Reply-To: <20260414223604.104290-2-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 14 Apr 2026 15:36:02 -0700")
References: <20260414223604.104290-1-pierrick.bouvier@oss.qualcomm.com>
 <20260414223604.104290-2-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.1-pre2; emacs 30.1
Date: Fri, 17 Apr 2026 14:05:56 +0100
Message-ID: <87se8trb2j.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

