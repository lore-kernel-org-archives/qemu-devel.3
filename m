Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A08C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 04:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta69F-0006Fg-BS; Mon, 20 Jan 2025 23:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1ta69D-0006FY-Id
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 23:45:55 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1ta69C-0002sY-4G
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 23:45:55 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2166651f752so119552155ad.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 20:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737434751; x=1738039551; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5UrDsofvNdKLkIEL5dqor1YT0QkeEsdgm1riDI9EX8=;
 b=TBjONqJb3a4P9jvqKwIbgQ0BJWqnQLek1U/LxADEug/p2DL8pTuWiGHUpDMOmWfRP6
 LijPWbidInP8nimaS9uFbw4DSlezIdyxKc863QFc/vRY2ezGxxfJi6SHnk12hjVSe/vS
 A2zunQMyNTiuGiV+QV5BZfb2mJ+aWHYeEISS4ZYygGyEkd1RHEXPu+potFCGXipyYESx
 r2Fct4G5VHtPGXnnKy/Pq7BcWAaK2Hs155JdFzgoNzD4X8K9/QszdPzV4/I8BMG41B91
 GYECvI6SVrNx3bcj2Dzz8TtUy8296DVKfD6rWdarWFf+EAnSuDO6ZpBs5TZNtMNC+hvX
 K9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737434751; x=1738039551;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a5UrDsofvNdKLkIEL5dqor1YT0QkeEsdgm1riDI9EX8=;
 b=p2Mv/x4PGQgwItqkUZdCfKJQ55IIE2R7G+8dF5rvGsIn9ba3Y/WXdMuth0F4fIVjHZ
 agazjGqcq9d7YT2BU+HXjrbps4koLe0m/yJ+WMNuENt1DueV3Rm/q6MdyVWxpWO8WXrp
 ZLUfNNHDRTtoX1Ku1jgjRqGHGvGXZlBXzNtjwMByCX56Fcn/BfahjcrZEzDDGKBp/qAj
 UQANgHHWUPB+U+drGYWW9G5g4th8StfqoeQofYK2VuyJ3uYQ3REV1E7EfT7Yh2lcKpv+
 tb2Yh6Yh+VzR74PTFNGWiYvbwO/KSTD0hFeGB3fG6BAODCwOO0aNDH8sqfwdlGIjcv6n
 m2Bw==
X-Gm-Message-State: AOJu0YzU8vkaz6mW2BXKfQqW9Wwe1Hz3fiyElXoYUzp3u7MObedecgUp
 cJ7blsnUnxTGMJc3lJFMoHJ2pVNN1xx8WnKtE0yJQLeKCCY9J99s
X-Gm-Gg: ASbGnculM6srqqUazuIAhsDaGSikzBV7QhgFVSRn678YmDXxNZclOQ3ujyBpIevW3qP
 7WpdIDj9UQeQaqDk3VfigS60MgVpJZXp/f/HOQ6FBnWei/A9Wn47qO8ObMSf101xbH3pbmqTCu1
 dOqKoSfjo+p12mqGbgcJOCfJvO5NZSKycuod1grFqQh+K781zdDHuLm74kz6b884pDuW0bt71au
 Z5QKLCLCGMNfekCyMUHNAXbversLoEVbCZ77RPiWpnc9ANDgLNbmkLa6tkO3PLL
X-Google-Smtp-Source: AGHT+IFhTdPegaLi1bDHe7EiajeY4GYnrl6Tx+4Sfn8KEggh5QEAy9k/Mb97/VQBF5fuqWqElsBoWQ==
X-Received: by 2002:a17:902:e88f:b0:216:48f4:4f20 with SMTP id
 d9443c01a7336-21c3551437emr225347605ad.16.1737434750976; 
 Mon, 20 Jan 2025 20:45:50 -0800 (PST)
Received: from localhost ([138.44.251.158]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3a9000sm68479655ad.118.2025.01.20.20.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 20:45:50 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jan 2025 14:45:27 +1000
Message-Id: <D77H7J5KX2NC.1A25FAUCNO1BV@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Dmitry Fleytman" <dmitry.fleytman@gmail.com>,
 "Akihiko Odaki" <akihiko.odaki@daynix.com>, "Jason Wang"
 <jasowang@redhat.com>, "Sriram Yagnaraman"
 <sriram.yagnaraman@ericsson.com>, "Fabiano Rosas" <farosas@suse.de>,
 "Laurent Vivier" <lvivier@redhat.com>, "Paolo Bonzini"
 <pbonzini@redhat.com>
Subject: Re: [PATCH 3/9] qtest/e1000e|igb: assert irqs are clear before
 triggering an irq
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Yan Vugenfirer" <yvugenfi@redhat.com>
X-Mailer: aerc 0.19.0
References: <20250117170306.403075-1-npiggin@gmail.com>
 <20250117170306.403075-4-npiggin@gmail.com>
 <CAGoVJZxkm_zj7RPBs9Lk3tpgYfzNi9UdsVOKsDibGZ98i+Ddew@mail.gmail.com>
In-Reply-To: <CAGoVJZxkm_zj7RPBs9Lk3tpgYfzNi9UdsVOKsDibGZ98i+Ddew@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun Jan 19, 2025 at 7:22 PM AEST, Yan Vugenfirer wrote:
> On Fri, Jan 17, 2025 at 7:05=E2=80=AFPM Nicholas Piggin <npiggin@gmail.co=
m> wrote:
>
>> Assert there is no existing irq raised that would lead to a false
>> positive interrupt test.
>>
>> e1000e has to disable interrupt throttling for this test, because
>> it can cause delayed superfluous interrupts which trip the assertions.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  tests/qtest/libqos/e1000e.h |  1 +
>>  tests/qtest/e1000e-test.c   | 10 ++++++++++
>>  tests/qtest/igb-test.c      |  6 ++++++
>>  tests/qtest/libqos/e1000e.c |  9 ++++++++-
>>  4 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/libqos/e1000e.h b/tests/qtest/libqos/e1000e.h
>> index 30643c80949..7154aec0339 100644
>> --- a/tests/qtest/libqos/e1000e.h
>> +++ b/tests/qtest/libqos/e1000e.h
>> @@ -54,6 +54,7 @@ static inline uint32_t e1000e_macreg_read(QE1000E *d,
>> uint32_t reg)
>>      return qpci_io_readl(&d_pci->pci_dev, d_pci->mac_regs, reg);
>>  }
>>
>> +bool e1000e_seen_isr(QE1000E *d, uint16_t msg_id);
>>  void e1000e_wait_isr(QE1000E *d, uint16_t msg_id);
>>  void e1000e_tx_ring_push(QE1000E *d, void *descr);
>>  void e1000e_rx_ring_push(QE1000E *d, void *descr);
>> diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
>> index 746d26cfb67..9ab81ecff5b 100644
>> --- a/tests/qtest/e1000e-test.c
>> +++ b/tests/qtest/e1000e-test.c
>> @@ -61,6 +61,9 @@ static void e1000e_send_verify(QE1000E *d, int
>> *test_sockets, QGuestAllocator *a
>>                                     E1000_TXD_DTYP_D   |
>>                                     sizeof(buffer));
>>
>> +    /* Ensure the interrupt has not been taken already */
>> +    g_assert(!e1000e_seen_isr(d, E1000E_TX0_MSG_ID));
>> +
>>      /* Put descriptor to the ring */
>>      e1000e_tx_ring_push(d, &descr);
>>
>> @@ -105,6 +108,9 @@ static void e1000e_receive_verify(QE1000E *d, int
>> *test_sockets, QGuestAllocator
>>      char buffer[64];
>>      int ret;
>>
>> +    /* Ensure the interrupt has not been taken already */
>> +    g_assert(!e1000e_seen_isr(d, E1000E_RX0_MSG_ID));
>> +
>>
> I don't think potentially crashing the guest is the right solution.
> I suggest maybe substituting with logging.

This is just for qtest where assertions are used to indicate
failure.

Thanks,
Nick

