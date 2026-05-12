Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B005CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 18:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMrXP-0005R6-F1; Tue, 12 May 2026 14:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMrXN-0005QN-E8
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:08:57 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMrXK-0008FG-8W
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:08:57 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488ba840146so52726545e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778609328; x=1779214128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0YroQDR6Pinai/uwnuVEC/mgvlb6ysDbxDAJlpN/dgs=;
 b=W9PudCEiZsyYRxxwVCPBlYZw/8CYa7GiWHSitGhFjAouU7x+C/bE3M3YzQ0YjNpNcx
 yxxUUdUNk6zecxeXkEUPUl7usy8jp8PHA8Li4UyqzTGSnLkZP1uApdwxFb3FwvfL8b5F
 MB8dgx4RIbSXlbdfTSVil6Or+C5V8u3hyKhS6s0tWz3SozK3Zf1+7N3CCcWUBAIa+BEP
 WiADOyyZludGQmduw3e6o5K73JN9+7geWsj6pkVMezhmcPnOyHwrBdEoEl6qMlCR80Oz
 9ECKaPN/CnanGICdMzPWFHquoSUJpGflIJhH//4SA+wAjPMPjw1lJ/22nJ1/muiqP54e
 9fdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778609328; x=1779214128;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0YroQDR6Pinai/uwnuVEC/mgvlb6ysDbxDAJlpN/dgs=;
 b=M7mwFtdKKCbJ0JlYTB61oFy+lF+9JDDZBXN0+Kebilp3zPhn6AVRbKzBsK3rlH+OIn
 RnvEzywBiwBylu/8BP4QIfkk7sLU4xZZ02WTJufHuWEkgr5AZ+2DA1jT1DsXxGFzKRd8
 ioEozwLU8+WDxI9zwqUWNmXfrAitQrLV68s0lVtH+2QvoxVesNn2lTxZX+EEZ1vuRE8d
 NqmoE1Innx4g9mL4x7gQgwYEJdWFb6m3SMga4DMns3BxbnU23MwnMC3jO1B/MRkyHea2
 9qMqPgCKWRubK8GOgNDw9NmbeWUmJKa+5nJSd23H8s6LuuKBTZSvpOIeTgda6dOSClcL
 O+pA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/plEelfV9JL1a7GLzD9CpNsoNh76vbM9bIv96T6X81q6M/9jx3icg7llaSJV+KQUrpL7dPwUMwZkPE@nongnu.org
X-Gm-Message-State: AOJu0YyfKPcmLoVEQlzUcJrv9OuJzUbCtPhoCdrwsJq18JO7pXj2+QeA
 qyuEoWN5QRA4UWj/OYojnDcnv19rteutkBXMfTp8hgyU4+fcf+xG3NF54v1wgTWVr45fVNM0l13
 Wmy2GRF0=
X-Gm-Gg: Acq92OE9NJGeV4BfHwJujfIkRyXasC+BbusG+50cKpNY+4eAACZjAx0GixB0y5idhkB
 cbxf9IpwlvzpIO5mHJFdG9qDeXL1Qv0ldJFkWOWejVjPLaHt6Adtow+XGy/gbShTpz35ML+pZIu
 8JW8pTyPXJL2RNdDkL9MJx8d0zrWS11igbRSTx4LaXB5GXHIQAS+Gfb4vfRjDQURPJmmjrm4VpQ
 3FshOjW2cRh1+VgJ9wdM0KnzuKHKeb/+COkcIQ7pB57/rBlOT3iIjK9uxQ7grEGu1HAfvRf1EcX
 vALLfz9RPAZHVPCNGXyWRm4DYSs/YVmH2wv1AImyMmYThpAAa8YJ8CYpAHg2/O0c5L7EYfXQLZX
 n3vvw225Jiz5iik6yNT1J50sMaIxAPI4xmPwRDuji6c6zvQuf2yYZHs58IoPY/aRDbW/mzNxqnI
 8KCtJsQiDrHSEyXj5G93q3TFKxZxey7hO9DTyFLoNCYUlqcxEoXNznvQhyxDSZKW8CmQ==
X-Received: by 2002:a05:600c:6388:b0:48a:6fd4:d3d4 with SMTP id
 5b1f17b1804b1-48e8fe8049bmr61176335e9.29.1778609328523; 
 Tue, 12 May 2026 11:08:48 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d625basm11346735e9.9.2026.05.12.11.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 11:08:47 -0700 (PDT)
Message-ID: <6fb5ef6f-9c7d-442c-8f03-e25d2121c1f3@linaro.org>
Date: Tue, 12 May 2026 20:08:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] target-info-qom: detect target from QOM
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
 <20260512150208.1167711-5-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260512150208.1167711-5-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 12/5/26 17:02, Pierrick Bouvier wrote:
> For now, we expect only one target to be available at runtime. This will
> change with the single-binary and we'll detect which one to use
> dynamically.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qemu/target-info-qom.h |  2 ++
>   system/vl.c                    |  2 ++
>   target-info-qom.c              | 16 ++++++++++++++++
>   3 files changed, 20 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

