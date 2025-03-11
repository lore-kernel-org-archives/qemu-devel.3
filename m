Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C10C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 07:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trtwl-0008EY-Iu; Tue, 11 Mar 2025 03:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trtwj-0008DZ-OI
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:22:37 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trtwc-0006xm-Rz
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:22:36 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3913d45a148so1852100f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 00:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741677746; x=1742282546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RiqtK+WGn48nGIXahXLpynuNvzi5ACWNnAt/H2NedkQ=;
 b=CTsKYi3EHQp541lSU7zGRfP+jHvmlwZWa+La9VpvI6X+F52miGC2vgPhUuiYljL9I7
 f4i0aoXtW0FiuuurM93SMJz51DvPHlegkibiv0l4igVBBvHMrnp3BAYne8UIMVTdxgkK
 +8dHm4gCimxKi0wt4RX5i9EjCFQQ2bUNwGe738anZIPR/AFW/jTHmBDlAV2qhaaKcAqr
 OI2SLLY1VdRxJTXpg7vpMoY3RcgO7v6BWpaHTeIhH7bTSJqTdg3QW7faV3fQt3P8bQwO
 ibhe/HsyM9c1CxY3HVQ+kGOGypglQzW3GmfRVHyuyuQ+rJ9aCwDvtrcIgMriMaVAN/Xs
 NdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741677746; x=1742282546;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RiqtK+WGn48nGIXahXLpynuNvzi5ACWNnAt/H2NedkQ=;
 b=EgnIHg+1YpbhxWE0Q5/6/8DTjCgDPJFcdxK+JSMW/Cbf6TZYXb6I3vLg8svrZLWzx6
 si/u9d2hheb9Ceaiv9aaZtBFENjGmg9v1/x1b4uOiOcmL/4uJEcmfV2Lwv6RWJtCRWc5
 e3Spbi8bM+ieaa4AIiJJbjZU6ZmjNNS176r4rFQbERi0JR44R8Uesr6d5uYfY1nuLz59
 mB3I/A1OE6meS5MZFEY0W0q36Ytr5PxWS9i62hCsbS2KKodkKt4tBmSq/FjsaJhCkRxm
 8vfnKaWTrXfNywKbNyVTRv9G9vooIveL0UZd4EM1z1bwIs2W3t2JB9K9DL39PFIyvBL4
 gZWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGNnLBsSsBHiDtDRofRQP9FCo4W0pXvuNAK9M3cT9DPzdHiRIw//1mgXt+cOSrKyy+8HOpyMsW49sh@nongnu.org
X-Gm-Message-State: AOJu0YyqI1k+oalrlXijZhFyYeyZ1Q4S3pcWxm4xfrtmV0t1qHiZpDLK
 AzsXeG5Htz0MRALS9orAouNOSWSVf+m2XgVjHc6WXWT5wVtfrZaPmHjfCasVaZrIQrxSmuBu8u3
 UjMc=
X-Gm-Gg: ASbGncug6ftdVIaZY3XHrphBU1zCFyyT5y1c2hA0IBnIFXo9MeNfx+VegJZKLJP3c2C
 1E5NIrjjC8EWY10SMoM4vMdTAOBfT+yLsxk/BxWsww1otgOBrmjNP+z0zYMVmJG0Ub19VGSiAT2
 gMeKw4XqWRmuBnREVe9lGFp3y+8+RbVde1UoKUWmk2muiOEa3V8RE10Y1D/ndeSRYZ8wonF8iYP
 T+bxsSJkm4hcZTRc952hoxzI7UTy/I8/GsYwaiMhZjzKyE5ory6aRO9+MxohQ+s0GWr9k1clZHB
 F5w4s6DN5gMi6DCIUzkNX4jrrXtlLSd0MndNtq27W4OmF/6vI4S+xP4pSUDFW3n1Ii544hH1uK0
 kqWVlsMEdsw/j
X-Google-Smtp-Source: AGHT+IEyDF9iCN4hK3M0/KpC2Q1G3yC0uo7zu3SXLxFqEqTUj9wsAmLH8hTOMv/uP4hx8J3TysfYHQ==
X-Received: by 2002:a05:6000:1842:b0:38a:8ec6:f46f with SMTP id
 ffacd0b85a97d-39132dc4335mr12526898f8f.53.1741677746448; 
 Tue, 11 Mar 2025 00:22:26 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f4fsm17119439f8f.77.2025.03.11.00.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 00:22:26 -0700 (PDT)
Message-ID: <1128bbf1-363f-4ce6-b58a-655f3e141ccd@linaro.org>
Date: Tue, 11 Mar 2025 08:22:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/qapi/backend: Clean up create_backend()'s failure
 mode
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: michael.roth@amd.com, berrange@redhat.com, jsnow@redhat.com
References: <20250311065352.992307-1-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250311065352.992307-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 11/3/25 07:53, Markus Armbruster wrote:
> create_backend()'s caller catches QAPIError, and returns non-zero exit
> code on catch.  The caller's caller passes the exit code to
> sys.exit().
> 
> create_backend() doesn't care: it reports errors to stderr and
> sys.exit()s.
> 
> Change it to raise QAPIError instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   scripts/qapi/main.py | 24 +++++++++---------------
>   1 file changed, 9 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


