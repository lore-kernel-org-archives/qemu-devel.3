Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E297DCD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKymR-0002X6-VK; Thu, 07 May 2026 09:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKymQ-0002WS-Nk
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:28:42 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKymO-00088D-Oj
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:28:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so5475485e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 06:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778160519; x=1778765319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/n8MiD5pZ2bQ+lhKXvepppuy7QIkaHoLIMJgMMqTy1U=;
 b=y7Utrb6dM+Z0BAKz7NxX0xM8SizutOQ2RgKZSB9pF+qxBUtO5NTP6NdBCqPJhTgdJW
 w0BDqXXOyTb539jgDSUlCcYVfyJs+y1v/jMhtt4/C6Ob7pZshfdlv0evW3ev9gmv4233
 i0k+vFtjkhd+w76MBncgYahFj2mPNoqhvFnkeP0qang5K0p5UrwlPt9/7Z2M1hWnt8Wz
 +pF5c0ueBrj1eVNt8hTordKNbXT+dqd4dhdQiOnDDLjwYy6r8dcsL96moFRIBr5UJYxM
 HO8P/HHu8F9rApOR4T4WKMUqT+BKFaueWkTFUWmPmRj/c4ImHjMzR8f4ckzSoRE9pBqq
 aL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778160519; x=1778765319;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/n8MiD5pZ2bQ+lhKXvepppuy7QIkaHoLIMJgMMqTy1U=;
 b=p3F13sBLl7eDMK3v8Az9AT3B+cUnUcqhoaFVG8tYkPJljR8IpqXtY9sg3BsYHJ7zA2
 fpof5Np6uZKxFaz73vGgAptavKNxRZVSsicOq2lobDH501SjKnmX1mRVZKKy6VMNAL8i
 wZ1pEJaNW/l8g1UlCQDEkPhM59e5qwEx3/E/lHK5ogPhmweHuF5ZL60UT6gcBW6I8dtY
 uSsTinADF/3nfA6AAfMiVQtNOs7xFUzIR4yRsP2dg7CLC4YKfowXyZXcFhEVEg6sb5uZ
 hnMR/BJI7Xr1xDtuGHyqx5oCLm0OZkyyYQAx2AY6pDveafO1tancvlifa06vQKSlouPs
 VnbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ufNd+I6w2MC66MwQJrS8yl3ddkt62JvrqHfW0W23APZHSrx2WvyyUJ2TPuFbmWHPiHrvS5sA+jCv6@nongnu.org
X-Gm-Message-State: AOJu0Yy/AAtTexNOZDJUDkhh4Hk07fJlHOKBCeiN1DDWxEGL6EzZz22t
 be04OVtkBNDxmdhN77SUCSVUlXWDvPbnXcugiaeg9n2wo6fyPEESk0gaPED9ZuMUAH0=
X-Gm-Gg: AeBDievn9/W+MFBnPio442DG/4PaRajXu3iGiQm4087XfwC6R6gRRo0YNyM8FQ7SSvb
 JIsOvWFaoPBB8BtSvf6U0B3njiBtaEXB4ejaIyHWCXT4YqS2o8Kjw9cgUoboo+nxIVYyFlrYZy0
 jctgTmYVYjMs6GjikMY8VrDZAmbn+2xHiGwmbC7pVH2ACJHAYPbIqkKqUzc7ptCJDVJzz0B7b/N
 XubcZ8mWaSX4eKukS0JFVi/Zuhw3Sa5cMsemL3uDqkQ+NstAwUEbrUTKfvR98nQJI0FuTJ0jel0
 TXYvsHq+HSyp3/iVjtAU3Ykg7Zx2/tJPIULy9PgqTGOI/Chl3Td8rB2jTT5ocVqdqPdvnqjJ0B3
 3Hrz2Btv53AvD+Mc8vRQVTtntV35FzCCHF3nCB6Kl76WpF3hQQKYMZNe8rJskXOVUJ1xLO4/rhG
 Ppir+c1sE1bHxZ80NPPX+Pl/OD4TkKs/cVRi/AlmIlJAMTajguyS+Au2lbxujKZjdcND8cZj3KW
 Q0q
X-Received: by 2002:a05:600c:4e0c:b0:48a:55d8:7882 with SMTP id
 5b1f17b1804b1-48e51e16e58mr142076535e9.9.1778160518849; 
 Thu, 07 May 2026 06:28:38 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e539109b7sm115849935e9.15.2026.05.07.06.28.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 06:28:38 -0700 (PDT)
Message-ID: <3a471cb9-e6b3-4cd1-add8-918d3af93a3b@linaro.org>
Date: Thu, 7 May 2026 15:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/25] hw/core: Implement
 cpu_get_phys_addr_attrs_debug() with cpu_translate_for_debug()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-17-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430093810.2762539-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 30/4/26 11:38, Peter Maydell wrote:
> Implement cpu_get_phys_addr_attrs_debug() with
> cpu_translate_for_debug(), so that CPUs can implement only the
> translate_for_debug method and have all of the wrapper functions
> cpu_translate_for_debug(), cpu_get_phys_addr_attrs_debug() and
> cpu_get_phys_addr_debug() work.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20260417173105.1648172-16-peter.maydell@linaro.org
> ---
>   hw/core/cpu-system.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

