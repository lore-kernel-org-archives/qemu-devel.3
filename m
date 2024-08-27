Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C12C5321D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 01:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1silHR-0007bL-LV; Mon, 26 Aug 2024 21:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1silHQ-0007Vb-5M
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 21:45:56 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1silHO-0000uj-Ku
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 21:45:55 -0400
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-81fd520fee5so192729839f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 18:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724723153; x=1725327953; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=gnBypZwThmW7BXWbqp19p+1I3KKoGFTUWZoM+iQsd6M=;
 b=iepQ/+lEjFVOCjNq/gjfV8P1L8Eg/LHkDD9DWDCm5QKjF9KlzYsQRQ+XUFm7OWvkFN
 dGcLXUjO3pGUuGZAvMEkvDtUHj6VhqJWsikckipDLIeceJQWLhylhzN/tnXugKNMqg3Y
 YpXPpydw8J7jvUpnjlODqrMC6LhlUh3WcaXOGPSyH6R4aiqY2iSv5UAROTEKpQBKluOM
 AIuT49LoBcAyKPDhuUlUbgiCRBy7JnzvPF0cKkCyVnsikeekwwFYuSsZhpMQgc6LgApY
 ezEABf7C5Lzjm+jCmpgHfDKwUnruPVmV128patuvT7w9jrifUlSug7W5KUDewJxUocdz
 jPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724723153; x=1725327953;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gnBypZwThmW7BXWbqp19p+1I3KKoGFTUWZoM+iQsd6M=;
 b=Nl8nLQRMhKw9yaf0sxAE5xR8dKhuuOFUs/L1JPPAEnkDUYuBbqEpT6VO5Ur45uVuyh
 Xbm8W8d+nLhY+VPRqlRb8nJj5LIapk0I0VP9nGQA9fvjQJPZXorMZXHhsKhdA04xltB7
 YUddI0FmvKOzfN9DBRYkQXziR5Jj+iHr2U9/ZAkYtRVZ3xFTnnm6waQi+Y/+xTItDtTj
 G80ryPYyV7gMfCH5mkFDUMTjNRrZcrFy6RT0cPKqGsMmX0FRpdz3jBL5mClH3kpQcTKP
 FJhqDD5zsE4CGeP2Vp9t357Uu6kH3vl7rFG30lNKRuBz7LtCXJfZAdWUh1h9EwIaipAT
 DjZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJhEjQokI+cBIYDNJLQQcFaJuuv5k6/uRGcSTbjNgwoehjtZPqhddcwjcsrzVbukE1DkH/V8EBnEHm@nongnu.org
X-Gm-Message-State: AOJu0YyiGx6vWZ6xsGMm4PgCe6kXErv/+P6lKj8E2MRK7IxRSKZMZqY5
 toBltgPxo3U9m9yh/9lCiSFzLnmj2Y2kmO7ES+bKEppOXYMxLGdx
X-Google-Smtp-Source: AGHT+IGskpIhkmcHz2E6ANUEgQ6308gnb7Y3+vagfBV0cMg2wvJKEtxUuu2tSxi0ryyEflmD+ixUZA==
X-Received: by 2002:a05:6602:641f:b0:824:d658:39a with SMTP id
 ca18e2360f4ac-829f1220fa5mr202780239f.3.1724723153124; 
 Mon, 26 Aug 2024 18:45:53 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:284:8201:81c0:d990:ff71:59bf:a3e])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5c92bsm2465897173.61.2024.08.26.18.45.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Aug 2024 18:45:52 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <bcain@quicinc.com>,
	<qemu-devel@nongnu.org>
Cc: <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>
References: <20240827002631.3492200-1-bcain@quicinc.com>
 <20240827002631.3492200-3-bcain@quicinc.com>
In-Reply-To: <20240827002631.3492200-3-bcain@quicinc.com>
Subject: RE: [PATCH v2 2/2] target/hexagon: add enums for event, cause
Date: Mon, 26 Aug 2024 19:45:51 -0600
Message-ID: <000101daf822$d9a97970$8cfc6c50$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLd+W9ohof6Agj59aNvpT7d/saPhAGpLMQ7sCcJLyA=
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <bcain@quicinc.com>
> Sent: Monday, August 26, 2024 6:27 PM
> To: qemu-devel@nongnu.org
> Cc: bcain@quicinc.com; quic_mathbern@quicinc.com;
> sidneym@quicinc.com; quic_mliebel@quicinc.com;
> ltaylorsimpson@gmail.com
> Subject: [PATCH v2 2/2] target/hexagon: add enums for event, cause
> 
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>  target/hexagon/cpu_bits.h | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



