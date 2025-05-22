Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C61C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBI7-0000uz-4u; Thu, 22 May 2025 15:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBI0-0000gy-Vh
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:09:13 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBHz-0006wi-8u
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:09:12 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-30e8a968b15so5933106a91.3
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747940949; x=1748545749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OyTrm5QkBf1uYJ/MAoGvWOGtHNNLL++H2p58cJWl7EY=;
 b=pgf/G/EbUYD0kjuF/pgV0DxNtUfe36LKyaZBv6Q7WQNk9RKfV650CJZ1wAK0H16rzp
 uObRMWB81t9gVfNdmUm1Cnt/pEi38Wsr1fnJuH7xMS35iyXRLcpaKkh3dmUAFAhtWlWu
 1CJ4IAr8gDE+ZlNRAmQu0hlYjYe58z9wfYedPrW0+rQ8ltE38Hd4KNiWYLGytKlxm4+x
 WQSEJ/gK/BZRCgCIKKPg0U1+vnSsDPM74hrJjk3D9hZ3LB7neAgdepIcAt+c2j3/rUva
 ZgPcVU68PqhHdh8tz5Es2taiD56+rt2DSSbtdQnc2S+XGA6vGsVrAQXSWS50WlTtVXFb
 hdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747940949; x=1748545749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OyTrm5QkBf1uYJ/MAoGvWOGtHNNLL++H2p58cJWl7EY=;
 b=Pl9oWFLRvFSknwALtvVMX4CKLIbdNq1OEWdMjsLYvgmai9F3eDGe2GNmADseZzYNBN
 pDQgzByNh4o5c/B6yhmC6rT6b73Q9QHDxiJNz0H9Eadb+ccvM1u8dGpbC+uMkdlgTuJ7
 8xQUyA7NFQDeE39XXxWLs6AE16juuFcTD6Dq3ZTELVaayPUK9AC4rQvd71z69Oj2NCBs
 9e0GFAB9nEA3dBp97iaWYy8c+IHYufY09he7vVlNpjKB2CEOp241tBBlzBBr/0OUqz23
 teqqoqV0p9ZAGjBZwjQ58//pCn2Vmu7y6Pbj6W1KQc3qmWmsfKPUAbIjXbtWBClgC+nv
 bXZg==
X-Gm-Message-State: AOJu0YxWRTBBiM2xdrOeYYNF64LVptXgYcZkIKeoCuiKaxGxgcgcVWLp
 r4cfdK0nZKA7T5qFBKk4aWCOLpVEXfkF/XzBQF1oSJb086lSrx+o3d05w6OtGm7YQ1ibzlMe1gw
 VbgJq
X-Gm-Gg: ASbGncuIZxeVCQZlwsp32q7l84SezHpXht9E/05HmtU9bDf6jcIXEyVUnMEwXEsQr93
 Ju7MNp+xlDPs/mXnSzWdLIv61PvrFHI2JqNi5cDy+Ii8wBFXGxKrOE4pmnwCBtwpjQjdc2Dnh91
 bO9vN9Doj5GodTdJmakldoRKiVEnxPLaS9qx2MoWPySuqpjzAFFKV4n1GZo/qUGWh2lR8thZ45Q
 zdmNkSbyaNpIOuLMSP/puW2YZr4lDoocGkdGYi2IKQGo4Xyay9cb2WCOFSAVYI9SjLuwawSLvG+
 Uw1cdHi8S9YFnG4q9Md+1zh8haP+d/xTS/X9GPmJH0Lrw8j7r7P3CnvjZvXs69ZZ
X-Google-Smtp-Source: AGHT+IFNoHSz2kHP4KB1WDx1DyTo7Wygrvf44Re2Nx7Q7Xx0M/khgUtPp5j2FY2mT6zp0ftMju4Xhw==
X-Received: by 2002:a17:90b:1cd0:b0:2fa:1a23:c01d with SMTP id
 98e67ed59e1d1-30e8314dbf1mr32446638a91.21.1747940949003; 
 Thu, 22 May 2025 12:09:09 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f3650006esm5907623a91.35.2025.05.22.12.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 12:09:08 -0700 (PDT)
Message-ID: <17152e34-a71e-45af-8ef2-abf86467ebac@linaro.org>
Date: Thu, 22 May 2025 12:09:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] qapi: remove all TARGET_* conditionals from the
 schema
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, armbru@redhat.com,
 michael.roth@amd.com, philmd@linaro.org, richard.henderson@linaro.org,
 berrange@redhat.com, thuth@redhat.com
References: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

This series contains a rebase mistake (two patches were merged 
together), please skip it and check v4 instead:
https://lore.kernel.org/qemu-devel/20250522190542.588267-1-pierrick.bouvier@linaro.org

Regards,
Pierrick

