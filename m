Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F63D715DE
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 10:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjatS-0004Pn-GN; Sat, 24 Jan 2026 05:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vjatR-0004PY-OZ
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 05:29:25 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vjatP-0000ZW-SB
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 05:29:25 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-bde0f62464cso983211a12.2
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 02:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769250562; x=1769855362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MgIA2t9QkKmcSpwgOmCTi3gG4Zz+4PUAWamrqMJWRts=;
 b=wxCr5SA/FDIppugR3cTe2j3Js8VlAWcg1OOJHdRux6/SoHuh2yEx8jWjkq3qKVER6w
 XTZ+9iTK5nJt1Dc1hxlfkpbDCXla2fnuop04ZBssQO4yJHnJrNdNY8dpSqq66Ycm+jAn
 sZ9NvcnjD9dmKG5yWhig2YkznIIDn1v9d2FPztG3rN85vlYlQhiwfLnE4KvHKEnry4hx
 YY+02eEBAv/0NzKmjG4nwKMQQnk7AEGBvuAud7f7wSdwT2tUalo5YI5GPtgr4RU+oUq+
 gf2qQZ//W3R2lBj4QyKc7mNHzazSqmRZB5Zl/eah2MtSYJWstVX7ZVubthL91q0QIMli
 yU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769250562; x=1769855362;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MgIA2t9QkKmcSpwgOmCTi3gG4Zz+4PUAWamrqMJWRts=;
 b=lTIF9ogXZJp+WJnH31nYhqCQCfzU2T8R41qSQRCsz6lXMb2kWH4xr2uUGWAt1Wtf9x
 YAhOkxRTLyYyxW50lcAwXU6SixHtRmReHTyhhx5dD7v4dP74M/ppLOjLDmifXwVHVG9k
 SxjwjXCY4ksLlI/h7Q1orIbR+r05yFJoZZzvT9jKEi+iV/744V/n+XWnrwlIerdv1TIS
 P/84SAvz+EZ1vbnUTuUPpAqd4kYTIEsRxqad3ZZVJzl3PAVzSVcQZ7qoGWnQLgTeJgMO
 feBBGC+aUoal7abOsmYs9SYnV95vKGPgeKhTGHGgD7tqvHlmWpFjzwtpnp4ozlUBNeg7
 SK+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUKd5GXSp2BBIkLuK7c9+J0ZXRHWYe2Q4afNR0Pz2Wm00XZpwqCrWCLDH4WfEZvhkg5h0+M5gl40zy@nongnu.org
X-Gm-Message-State: AOJu0YzcyZhpwK1YiAvSR7PpDtoaB68Oyb42SfYPbp8YI49dxX9iDFUJ
 STINmW+grb/hhxFWj/w32YuZLE2BzLKXERg+c2eCEHtQ8BgODFO3Hri3XPwi1rv2C+Y=
X-Gm-Gg: AZuq6aKRgtZpSFVHR02GjblWFx1E7tHcAGwNiiSr7ZBpH7bduyMmrCBUkXnj7zILXWx
 SOkhXIiahNWQUNkEddHwHTwiE0ru414F5aWgsknBVhafpS7ff2jv/uj1iiTzFhekUe8GnGpfiIa
 6TtSD8kssqiiCdIOlkrZqsCNA7XzllsRDu3ecfoTPKzlZomau37mp/UB9LnHllIu83tot6dTVJo
 shxnhRP0jQzKPJfjiB5+TrvUocWtmUgptA+1T/i6r+CiE97kd1okB8KWlMFtKrN/HJSx378TxWo
 +lxgDw4nxhi2Q6bS0Ifq97JLRlMRluPrQn8IKoO8BNVsoseLiw0pIBPDv8BewBCuqIjP9l2D2t4
 6ARqD6QzH/DxxM3TjR4X7YuRd1xdDaS57c0F51Kt0JHnaZHvgcklDn1LgxXGdv2NwTfcgYOwkZJ
 gAib/lMHE26DyBuQb4iz7/S8PFzfANVg==
X-Received: by 2002:a17:903:2b0e:b0:2a0:8963:c147 with SMTP id
 d9443c01a7336-2a7fe733d7emr59133745ad.45.1769250561821; 
 Sat, 24 Jan 2026 02:29:21 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802f97902sm42450905ad.57.2026.01.24.02.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Jan 2026 02:29:21 -0800 (PST)
Message-ID: <52c432ed-3bcc-41b6-9e14-e9098be2e030@linaro.org>
Date: Sat, 24 Jan 2026 21:29:16 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/36] Migration patches for 2026-01-23
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20260123195352.12850-1-farosas@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260123195352.12850-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/24/26 06:53, Fabiano Rosas wrote:
> The following changes since commit 2339d0a1cfac6ecc667e6e062a593865c1541c35:
> 
>    Merge tag 'hw-misc-20260120' ofhttps://github.com/philmd/qemu into staging (2026-01-21 07:39:57 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/farosas/qemu.git tags/migration-20260123-pull-request
> 
> for you to fetch changes up to 03a680c9782ecbbdf2a604918326413527d69322:
> 
>    migration/channel: Centralize calling migration_channel_connect_outgoing (2026-01-23 11:34:25 -0300)
> 
> ----------------------------------------------------------------
> Migration pull request
> 
> - Removal of deprecated query-migrationthreads command
> - Removal of deprecated QMP migrate argument 'detach'
> - Removal of deprecated zero-blocks capability
> - Removal of deprecated migration to file using fd: URI
> - Improvements to fd handling in QEMUFile
> - Cleanups to postcopy tests
> - Cleanup of migration channel connection code

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

