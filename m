Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C3CC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 05:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAN91-0002SC-I7; Fri, 24 May 2024 01:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAN8z-0002Rv-Hd
 for qemu-devel@nongnu.org; Fri, 24 May 2024 01:07:05 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAN8x-0003Y3-S8
 for qemu-devel@nongnu.org; Fri, 24 May 2024 01:07:05 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2bdefdeb545so970004a91.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 22:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716527222; x=1717132022; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5glbj7SsRH2wfBDL1+zwN3MQxxX9QqFcOd1S8s96gyE=;
 b=o82pXN8soU+BShy8F8xb3pzurBoK2XlzG+UuRQeIbQWqP9R/GmUR+KpcVnKY5LG3cI
 UjX2aNLct9YtsXTeE6GTO+AhoKmWP8ESKaA3A2JLBK9DUipRyWV8MhFMMTdDfMprADEm
 sVHqzd95yL1mFpHs3awY9b1H4runTk1KKwknpjk5iiUYsdMLxPFLHMKj20jDqOiohV1X
 lF9CJpYBic4fNio6c9PqaUsjMBaz3VIhFi64NF1+wr7Q5CebM7+F03KXkQSXOrvrjrVP
 X8naWVgvn7E2kPespEJmaJrvjj8r2Av/UxZwKrwQ7JNQFjZj6vyvVtFc9hlopG/KgDhN
 6hkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716527222; x=1717132022;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5glbj7SsRH2wfBDL1+zwN3MQxxX9QqFcOd1S8s96gyE=;
 b=mXLT5ssHx7V9vsfRMpVC+bvOL9fHjg2aNTPS+5rDlmh4FM3EsR+b/tI6PAaf5alDnL
 /2R8nrRYVi27Iw3I1ILm7Vd8rHkIdllDSRZ3H9JT7hm23k9wetDfwrrsGGJK6RWtQ4Yj
 r6QoU8jQrhhnlXn5xwA3U+xAdi3IBU0LzO7vuXqm5OnW3v1OaE1n2KqM/V7nvDxZFZeY
 fcQSMzzBxSHP4EYMCrydNJoaHQ+/Mm16p0ezlj7gIyVc3c9cn7UyIm2kTEr9W1vw7rc6
 uP6rmG12WexVxoFDZg6vCLg2ia9D4Mwmyl+9KscgsOz0nhp019wCstSBi0ucnkPZy5TH
 WoHA==
X-Gm-Message-State: AOJu0YzzQQATqwwBtbQ0t8aVp5QD7PYT3eynKuzWtvhwEIV23aVYTFmX
 sZtGmNENY/jyJaprQ9tUd4atI2dhP1cWEhLFcW4O7MLKmsfcICXM38bUCNaYdeVE/ZuDbbhT0qj
 X
X-Google-Smtp-Source: AGHT+IHePo+CDAWaLcJTDEw5SdzwchcIlnznCUJsZh6a3TRsohpSo+Qr1xxDwrPmHrysngNVnZ7l6w==
X-Received: by 2002:a17:90a:ce07:b0:2bd:6891:7e2d with SMTP id
 98e67ed59e1d1-2bf5f407646mr1110674a91.44.1716527221606; 
 Thu, 23 May 2024 22:07:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bdd9f5bd16sm2414699a91.51.2024.05.23.22.07.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 22:07:01 -0700 (PDT)
Message-ID: <f93da6f4-91ef-42e5-8abb-0132afd5e16c@linaro.org>
Date: Thu, 23 May 2024 22:06:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20240523161553.774673-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20240523161553.774673-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 5/23/24 09:15, Richard Henderson wrote:
> The following changes since commit 7e1c0047015ffbd408e1aa4a5ec1abe4751dbf7e:
> 
>    Merge tag 'migration-20240522-pull-request' ofhttps://gitlab.com/farosas/qemu  into staging (2024-05-22 15:32:25 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git  tags/pull-tcg-20240523
> 
> for you to fetch changes up to bfd43cccab9fb77b8405ca556fc2f2ed3b2920a3:
> 
>    accel/tcg: Init tb size and icount before plugin_gen_tb_end (2024-05-22 19:05:26 -0700)
> 
> ----------------------------------------------------------------
> tcg: Introduce TCG_TARGET_HAS_tst_vec
> accel/tcg: Init tb size and icount before plugin_gen_tb_end

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


