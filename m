Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50406C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 02:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWSDB-00048p-DL; Tue, 23 Jul 2024 22:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWSD9-000480-Q6
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 22:58:39 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWSD8-0001eI-5e
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 22:58:39 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2cb6662ba3aso323063a91.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 19:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721789916; x=1722394716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RHra870W0UMXidD5WJs462EBk+2460EXTNYCSm+SuLk=;
 b=nM5mk6WhcWuy21/fstqnp2eKNZX656I+h+MD+1PksYXhRN9gUQJSVhHv35dG0yJgHM
 QuRIBQV6U1xtLRgoA5DljuRFm+zTJaPGzF+UJKKq0ezlD14QpO9G0vn5VAwYO4VDDYlg
 dvO5UGiL9i635sW0aWl7KDGBIiSPctm8qbJJ6EypSz3jlFtvCn8BNmywJVj9Cm+VFvel
 RZstixFoaK+1HVSZJD3zx5LsMN4xMr1DI8NrWpSLQGOgnP3uFirUp00jbt/hDfHKD+9P
 dUAtJQ9FKGDW6Nw+92FQtX7XVm2UsXpLgIRXDxTVC2evjCLWEH91yF159C0rvCi9pd0c
 6L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721789916; x=1722394716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RHra870W0UMXidD5WJs462EBk+2460EXTNYCSm+SuLk=;
 b=A8pCxzdyr/+iAlsAMZzfveo0qcb/w40mBQrFgFn9d8E0NemR6jRmDAYz+DOJpr5Kc8
 powlovv1i0cLdQwOjcF34KMzFKCKups3ydH0qicbbDQ3GrX3Bao8FGhJZVxyZqRcWD+4
 zjVztZZbIklT7EzdeQcjhXy/omL05gIHhBfEVEuQ0na+Xxv2AZvwitTVAvHoX6ZjQ1w3
 TQ0sguKh36Aui96Q1lHhzo7MVZGlWPMH3VmLfF1qIZLnpJWi3rAc0pt5bGk5l+dXIVRN
 3XdlA2JVUmYcfv0UycVTZfT133Mxy8iC1zDXVrDXIwlHrIqtcNeKDMjVrWQo8Ld11c99
 /BgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfZWV5mMtgDEKYSExuuXbCNJrVQ4Lfi/RiieFxQTyujcWIqmyIOhnhCuvrcZqbqIeKxMNIkoGuMaR92VA77rvaSbya1ZE=
X-Gm-Message-State: AOJu0Yy7czQ0qTWeDcZhmaPwH66iVwx5nWkqBBNMM6HVLWxOxwzCJIzH
 FP3W3pNVID/4a3oOH58WTFGjs1TLkyseYtyU4YD65+34lqcvqUld8uz5yQ0ITrQXrftOpkd07sZ
 Y3sQRoQ==
X-Google-Smtp-Source: AGHT+IHDmSTsI0ACQU5MreosaB5JdAY+47k2JFEfT2hNGmnYBxeZQvVZqz+HUcr8JxSJrXfuL87HVA==
X-Received: by 2002:a17:90b:33cb:b0:2c9:75a7:5c25 with SMTP id
 98e67ed59e1d1-2cdb9443005mr893069a91.15.1721789916101; 
 Tue, 23 Jul 2024 19:58:36 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-79f0bb06e79sm7019297a12.41.2024.07.23.19.58.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 19:58:35 -0700 (PDT)
Message-ID: <0a9491c4-c1cc-430a-a7fc-b88fe154f61f@linaro.org>
Date: Wed, 24 Jul 2024 12:58:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/11] target/i386, HPET changes for QEMU 9.1 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240723141529.551737-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240723141529.551737-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 7/24/24 00:15, Paolo Bonzini wrote:
> The following changes since commit a7ddb48bd1363c8bcdf42776d320289c42191f01:
> 
>    Merge tag 'pull-aspeed-20240721' ofhttps://github.com/legoater/qemu into staging (2024-07-22 07:52:05 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to 7c912ffb59e8137091894d767433e65c3df8b0bf:
> 
>    hpet: avoid timer storms on periodic timers (2024-07-22 19:19:44 +0200)
> 
> ----------------------------------------------------------------
> * target/i386/kvm: support for reading RAPL MSRs using a helper program
> * hpet: emulation improvements

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

