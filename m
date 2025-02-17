Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4821FC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjvwg-0006un-0k; Mon, 17 Feb 2025 02:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvwT-0006uI-5R
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:53:31 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjvwR-00077I-K9
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:53:24 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-abb94e3b49bso137645866b.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 23:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739778802; x=1740383602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cGo2ph+QRN9fU3tlXzHkGUVniYnegjh0vVO51PdvH0I=;
 b=X3y2+g83n4Ik4lfVaJfZbzJIYJk2SAmsf+E/f8svZ8ummbtLxi8C90Dv2uZ0tsedKn
 wvsNAgyQ72YHgeTTkPJ6xvchMvT+BG6QndRVt8WkEZGxtbDEXdaoWJsWQqTEULYLPkjL
 CsdsgKMUv9D36sNx5TaV/8GBfcj0BAaRETtNvX+1d7Vb2Q29WaHCGBR6Zn0WtHHYq3Ht
 HDgJYoqWFLAf+IxmbZB+tMo5PqPLy+dQlxM4akdWDLlv0w0VwIpMPxqSg4JPACnKQ6ep
 JOTwRRAeyU1Ruqa0VJp6E9WTrg6YKlPH5bAucIBIWTuAgsyEjaE1F1OY5Fi0AemUxBp4
 ehyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739778802; x=1740383602;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cGo2ph+QRN9fU3tlXzHkGUVniYnegjh0vVO51PdvH0I=;
 b=B2s8wfFza34+7kunYzb2DlxJxUnv2uMBKXyvnYDqCcJ+z4sgfpKi/jmWQyvU4uBf23
 iadd9cpgw8B+ypdtBPUnyKXT9/SmlUM8f5mRD644uX582KUECkDqybzAV9hc3Yi1cKlc
 +GHM8Sv8ABTMwlQ3FY+sJWHQfMd3yE863rpcoSV3/yqcdsVsA7i6V1jFXmn43XRK+Ha6
 Sw4CV5ZSYcIpMvr/lSSAM+UDI2dDvqfFduGmK3Kb/+05sW5kvQSeIMHD+oeDq1iJwFP7
 FUMdhD8OTVIYEd2INsH7UeHqxah5NuZiL0drfRCmDz+4RzWYSVuIZ4143V4bYrl52V4G
 oAnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXExw7DpuzOEX5Hw3dOoZqEC8DgkU1cOErNDl5IUgyosbs0emvS3WwLk0FQdFrkBiHZsE4AkBs0OH/Y@nongnu.org
X-Gm-Message-State: AOJu0Yz5YbRAp9cMEhse6Gf/JOZk7BHCr+m+10UmkzNpaTMFdeyMTuVy
 VNvK6j6wI4cupGztYAW1/s4hkfjC72OtCSkiOCFiP9tqoX6XfpDcwpuA6a3lPTCN0eeIgqpRWu7
 5
X-Gm-Gg: ASbGncuGz7OJILs3ZmP5nFrlnYc0Ru76qJhiKf+5t0ZNNFwfjr/ziIqKXw8Jx2dl4xk
 UjIy7dnHxxjpOwXUQeXXto3N+v4SJuHAUITv8CJZA7+RS2W3jn1QZZMQIBdUp5sOTgxTLQnJi15
 H5M7NXJi1TcpQj0ZnOeu0AoKXFs+uWR1ige+xU0qJz9qbGpb3FOGJEX4DWM1MztbLiZWkhk2JXc
 hJChhe9W4rPunpPPw80uYTvlxhueI24h+Xw4FUuukPi42T0ADGoAaMm3ZTM4MGJXlBp3+gjwtZZ
 HBZDmkCpGTNHdqGvM5tH2cabikgz3I3V2Rs=
X-Google-Smtp-Source: AGHT+IHE1UEV4KF4q3EU79cU/KVlshxEBUsqy83Y9w5Ajm+xI2Mgtw4tG1bBL6lR92Fwr8531lqKEw==
X-Received: by 2002:a05:600c:4e8d:b0:436:488f:4f3 with SMTP id
 5b1f17b1804b1-4396e70d13emr60706055e9.17.1739778787725; 
 Sun, 16 Feb 2025 23:53:07 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ccef7sm11725681f8f.31.2025.02.16.23.53.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 23:53:07 -0800 (PST)
Message-ID: <88507629-1e5a-4c06-9011-6360357dfb5a@linaro.org>
Date: Mon, 17 Feb 2025 08:53:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 053/162] tcg: Merge INDEX_op_shl_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-54-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-54-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           | 10 +++++-----
>   tcg/tcg-op.c             |  4 ++--
>   tcg/tcg.c                |  6 ++----
>   tcg/tci.c                | 13 ++++---------
>   docs/devel/tcg-ops.rst   |  4 ++--
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 17 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


