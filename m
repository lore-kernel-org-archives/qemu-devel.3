Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5744ECCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RYm-0004h0-R8; Thu, 16 Oct 2025 13:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9RYj-0004d5-8E
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:14:38 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9RYd-0004FY-WC
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 13:14:36 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-27eceb38eb1so11821985ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760634863; x=1761239663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xbf8AuRX9mwiNpLkN8rUpE4f3cRZY7K2AwrEPz3vr+0=;
 b=Tk7MghiQVEGI4P16BQi6NRkHuKFyUTkmp3zW21eH5JHhhRK04yufRj0/ZSESE+2qZL
 +8pYw4n+WrAoo8x14w3DD2jmZm2NxPs5rkhba8x+2a4hSD1t2zMFeure56EQ0hlzMA7y
 tiPZmoLj70vzHbXigT564Y28ThhC5kJc5kBKjEdRj+2AawAyOilY9kBE8ziceoWAHapr
 UPNO6CLnWyYI6twmZJZFUN6fFRbxgdgaiNit1H8qbg/oE+1LHiTSpB6YQq8ryehmxX+Z
 bFbtdvJL6XUfFLoGULbdo03fuAgWbkdkmSDwurLSjaEBQbNAsR1ppBsgMtVJ49nQqoSY
 1MtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760634863; x=1761239663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xbf8AuRX9mwiNpLkN8rUpE4f3cRZY7K2AwrEPz3vr+0=;
 b=Kq3hdSyKjQfwDcgKyMZ3RcF3k2J9QxuHhHcMHQFjUxsZkv2GtZoWTb2b2ePjiykyrj
 beoXtlFM+jAkH5REQh/fIxM/Z10jCrwqIJX4mRT9aTlE20nwDEB773XxZo9owgo7+8dr
 PoL0epPy4pS+bPluVbwdXcWFZdXi3hGXuhqhp7alU8oNFBoSKBHTyqk2pnvnF6JOncXW
 qOHrPaEO5Uy12eYU8jr3XVE3nspXrrH39Lt8mHyThl+2Ynk0DQSCT0Nfss7aTB5GDtsq
 sXzklzlIPH42KHo6oPZpvn3kWfkuHtwgXJqEQrCAVXLhPHbNEz79zIhvIBB6VYx/CBry
 oHVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdR6kRgFeuD0DTiE2V3/s1WUztmGr7MvHD0Zb0qfzUDKOHawKL8seynD+2o9oeyzaMxYeoio0ikFcJ@nongnu.org
X-Gm-Message-State: AOJu0YzpR0EueXQQ/7cihuSAeyzrx5r3i5g30TnbN9Pv7xTYdG0VJTgJ
 6yVl4a66+7sQ5FqC7eDAJgMi+G7W9IpxmOr2BO8GhuDaA09CO6MwdlTdKyg1dtoMAR8=
X-Gm-Gg: ASbGnctlTbBENELrTzkgVWIb4nIBx9FyiWTTYXQiL3Tft4GVJEhSlu/PNcV9DvU/jTj
 +xMr2nxyIhcUPv5wOsjdOb/5IL5hL9M2+uaz9C7nIJ7WvnRTziU3TCZhIEdVqxe9oZ5vtT3L1u9
 6I6DWF2tWV5T4E2HLAO72UFOJ+uVntyuCi+gbD0oCd8KdSiYXKUwpMind2sR0LeEWxGq2DbmB7J
 Z0WzP/ScuLGkW5A6/i5Dmomevt7P+VWu2amzCZICKFyK5sdTSdqPp2gO6STTKpwF71NuZg//Jgk
 k1vE11UVFwni9fv1JCdMiHqzBSbGrtJvGjdHQLFzmKLhrGWJ6yZChy+JxkR0RSe/DVOGRD2Td/n
 lsbOY+k/8VBqfvq/7PD5coBP7MTE3RXsOPzbNBIXLRI+CboN1txHJSv1Jhmm0iOldZ1QfOSkA82
 4BCCGbH43L5QkKuzARUxVEmIM=
X-Google-Smtp-Source: AGHT+IF182F4lmL6LvxLkrYofl7mXVzTygfR3b9k9De4jgcnqkzNqlvOwYury9mzQ7IWDkZNzFWKJQ==
X-Received: by 2002:a17:902:db11:b0:240:48f4:40f7 with SMTP id
 d9443c01a7336-290cba4efc9mr8442235ad.39.1760634862800; 
 Thu, 16 Oct 2025 10:14:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099aba062sm35990345ad.98.2025.10.16.10.14.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 10:14:22 -0700 (PDT)
Message-ID: <e760f90e-497a-4e8c-9e2c-87195f2b98de@linaro.org>
Date: Thu, 16 Oct 2025 10:14:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 21/24] whpx: arm64: gicv3: add migration blocker
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
 <20251016165520.62532-22-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251016165520.62532-22-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/16/25 9:55 AM, Mohamed Mediouni wrote:
> GICv3 state save-restore is currently not implemented yet.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   hw/intc/arm_gicv3_whpx.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


