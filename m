Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F686606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=o9/h8N6z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrXr-0000co-Tp; Fri, 13 Nov 2026 08:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRrXo-0000ag-QY
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:42:21 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRrXm-0006YX-17
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:42:19 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-91f1324a134so15580476d6.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 05:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794577336; x=1795182136; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CMOsV1+SqDHHYMZ22FsZEoCEqdIMsoSZJR/6s5gN+cQ=;
 b=o9/h8N6zrSHPRNLzmdBPwvShYOkOnbgjemysvUPPUvgjepnmyoj8lPQjrUC5z0DxG2
 jLqfSsQ16MCXtUIV5uLSljLzpQiTQGPCIFNJay28om3Oq3EBDJgC74C0jK1q9DUXN3qw
 bESJEOMyUQE5osyZ5tCcgI97mVCF6iicycVW6D6nXqv0QgtWMcE1QzSgnop7QQdVu8di
 Y8F+QOsB3D/U/9QsUabgy2q5Swiqt7tNiEisppNNQBCE3EaACROhDppnjtnPx2r+NzkJ
 zp6fQRcMPSDRtxYu75HX5d/Xk9Zb8ps/AIIImmvs1YcoCnVSyvKm/+TWlI5Fk08pNctA
 9SNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794577336; x=1795182136;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CMOsV1+SqDHHYMZ22FsZEoCEqdIMsoSZJR/6s5gN+cQ=;
 b=Bx1pR4ZOu/hKzneZybL1N5XXkXhij7DjDaziq8BoAZyqd2SPMWdx+ms/IwljZXSWkW
 rtow4zLsNfHa85kdu85i4b7olWIC2Fm/IpHpkoXXvigVKfqVafweBfCkZe8sD93NMafY
 FBmrZ3A4ob+BPY9zGC8l4B6vwhSWp4s5eYv8WViNXVBmcRLsfK9bcpMpDbmUOcZBs2kv
 cQmHAbwf48pv1KLhCBShLOkdhrT8IjDkX0Jfgpucu6Bz5lQ3wGg2yW23INpJgpdLmWqZ
 v5zzFJMbb/3u0BFZYpL4e+i4/IJE6VnXYffztiEV58edGz6/OMJSMwj0qPw3XE518ZDE
 cdJw==
X-Forwarded-Encrypted: i=1;
 AL+hErFjKX2cN2T3LdQ6mSMqp2jbqM04Hvg2Oa50PNSexXgd9kS5oxgVHY16J+nL4NH+J29QizdN0/xX9Lam@nongnu.org
X-Gm-Message-State: APuU4Z/DUudxIJQDY9R7IBaPynVWfUEXkaMrdfmuknh6f2RV3iEtUyK4
 BQII1us5rM6yBgzZORgHPvlweCDJpjaMwpvg1YilCiiO0ug7qXF/ifiNrFdgPRhRflkRnkR9NnS
 HZVmgifc=
X-Gm-Gg: AYBFou0z5lmEFyLL6It3+1zCotpyt/yf6KGTG4jx6dmeoigN003yLR5pxenO0Djtx8e
 1v/xMvrlcKMPnEMX4t4iWirfnIWecmZzrfqk4ShYtsn8wUKqvON88J9OpJUwmjbm9yiMclYAOjZ
 HCQctiBcOEzWEWr1/rgcd5PYaAoQ/7bejvmwCN0sITnYBLSTQupU80Vz6fwJrHuA2MKSFW9EutI
 vrxld8Q6FZMH7vEFz85/cF5EJ9IitzEEbnoBvORZkf/XhntY8CtzzP0EUwuceeG3HaugzyNy41x
 xCgRGdauxCkF44azfoaabM0TQrW8Ez+dxVXXX00Qklzr7caoaUoCval7CmEhng23UJAGi4k/8q7
 KKd9Vmt7HPeuKnPOWoqfDCA1jKfPv/BwlMZywod30hT67LjFl6CldRjRixhTv94Y4m63mWADLlP
 SuCK2ruFmrp9Bv5ph49MY4bALJ22MsfQyzxu7LzynBhwTt/aPQsaHSoXAuzI9iKBKDOPWiVvXQ6
 Qu+9RtBwnokIS8Wg/DLX7ZzTvWgDAYY++9PQqrAbkDEFXB5DIGI9hRFI90QqpOm9ZK+RG+Wb96f
 f8bcNqicWj2tX3R21xbh9SNDHCLR6Q5P6rmqjscRs4g=
X-Received: by 2002:a05:6214:2dc2:b0:917:84c2:67ba with SMTP id
 6a1803df08f44-91f242244c1mr35883016d6.34.1794577335257; 
 Fri, 13 Nov 2026 05:42:15 -0800 (PST)
Received: from [172.31.6.230] ([69.196.88.181])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23efa2edsm19923076d6.15.2026.11.13.05.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 05:42:14 -0800 (PST)
Message-ID: <eb81bf45-b43c-4b9c-be45-b38809105214@linaro.org>
Date: Fri, 13 Nov 2026 06:42:11 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/5] Trivial patches for 2026-11-12
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20261112191239.2327003-1-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261112191239.2327003-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 12:12, Michael Tokarev wrote:
> The following changes since commit 29760efaf96bbe5928f8111881eddbf5ac06439e:
> 
>    Update version for v11.2.0-rc0 release (2026-11-10 14:47:54 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
> 
> for you to fetch changes up to 84d6ea1499d584bc31b64aeae4e0e8528e0da5b4:
> 
>    hw/audio/intel-hda: Belatedly update comment for removal of -soundhw (2026-11-12 13:30:40 +0300)
> 
> ----------------------------------------------------------------
> trivial patches for 2026-11-12.
> 
> Nothing fancy, some stuff collected since long time.
> 
> v2: drop
>     Matthew White (1):
>        configure: --disable-containers should prevent `docker.py probe`
> as it causes questions.

Applied, thanks.

r~

