Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72741C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 22:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdd4D-0001qB-8g; Mon, 12 Aug 2024 17:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdd4B-0001n4-WB
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 17:59:04 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdd49-00015U-05
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 17:59:03 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2d1e3381cb1so2544120a91.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 14:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723499938; x=1724104738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9LmER1dWmsqRK4CiN3P9lIS9uolZPf/yXTNF/x0I0bA=;
 b=s4akxeC7O017kFBU5h+M8OA8fy6h5/uCfOp8Fx4MiWuODhkmEOV+V/qQFMBDBIlnE2
 FW342YQq3P+up4puQ/dbYfYvyhy0M0CvsAjOihzeg+yAiqscV9GAjYfDVhdEX6B3kn6d
 GhJBluhS/NgqFDKyJl2NPEahDgvCDefggRQqAKMIFyJVmCe2z9LsTOVH+9PMBal3ADhV
 TfKUdJM6hXDeZUQDnToopiIYc7S3KNpL9ZTlkAKawl8H6uexIUTI6H1XoFNE9JAV7o9J
 H2UrYKyxg/xIMGdwq5+6ta26rwVXdT4y1U7Vtt4poeWG2gwxvlc8AiwQ6cpMwKXxcch2
 wGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723499938; x=1724104738;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9LmER1dWmsqRK4CiN3P9lIS9uolZPf/yXTNF/x0I0bA=;
 b=wkUK693I3xqyCEYScVJqHhwXybhsAz1OnKPtnyt3Al7DpsTsVGhl29y8KPpjRaUwwe
 6zVdi8w/yBcNzTH08zFkFTsipxnsMhG4XT1NWHg6EHR4msLGGlsvFsJrtZ6n/ZjYgXkh
 DBGtnbn3/BAnt95b3jXWcdQO2TUeAjlcrMfrori/28VsP4VBj41k7OuY0nxgHX8X6g8e
 xFjChUZsfjGnk73g6uv5Yg9v5b4l+SrHQwbxyi9r3qAJOqyBe2PWGGw/IXrarOvzmbny
 +fDGlwkIwJRCwTGx7hF7BuBoc/r2etiCCXtcn0eDMsGhnIUkw1u8xAABFxXWl3jwVbty
 5Jtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ2L/Ft/NkxZKHUk2ME8yWL4IKePptI+ZVgYZ2brpDzHmog6KJDAhehj/NPDsysd65cPtSWbsL5+dBBAId4VdI3WpAF3Y=
X-Gm-Message-State: AOJu0Yx9I90ydzVbrqemCMBlNBPN8Q53k7DQ3Pvq6P2IRggfh0T9uF5g
 v703XYTUNDuU8VHavq18WOOqfikZ7gt2InPdy3Ytw9FTBU6rKoxjkCLAPIe3jvU=
X-Google-Smtp-Source: AGHT+IFahUcfqzd0KrhhGKl9phSwITi6nHU8qV5N8hG+X0vLKOVbJcWZtJHArYFzU6EIvkP/hifMFg==
X-Received: by 2002:a17:90a:f014:b0:2d0:d82:60ae with SMTP id
 98e67ed59e1d1-2d39267e352mr1859168a91.37.1723499938223; 
 Mon, 12 Aug 2024 14:58:58 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1c9c7ad59sm8952206a91.13.2024.08.12.14.58.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 14:58:57 -0700 (PDT)
Message-ID: <2069ce65-1803-4a3b-a468-4a9514185293@linaro.org>
Date: Tue, 13 Aug 2024 07:58:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Net patches
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <20240812072810.5247-1-jasowang@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240812072810.5247-1-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 8/12/24 17:28, Jason Wang wrote:
> The following changes since commit 0f397dcfecc9211d12c2c720c01eb32f0eaa7d23:
> 
>    Merge tag 'pull-nbd-2024-08-08' ofhttps://repo.or.cz/qemu/ericb into staging (2024-08-09 08:40:37 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/jasowang/qemu.git tags/net-pull-request
> 
> for you to fetch changes up to fa62cb989a9146c82f8f172715042852f5d36200:
> 
>    net: Fix '-net nic,model=' for non-help arguments (2024-08-12 13:36:42 +0800)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

