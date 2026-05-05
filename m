Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFD1FF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 07:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKALA-0002Pa-0q; Tue, 05 May 2026 03:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKAL6-0002P9-7Y
 for qemu-devel@nongnu.org; Tue, 05 May 2026 03:37:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKAL3-0006VI-8r
 for qemu-devel@nongnu.org; Tue, 05 May 2026 03:37:07 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so15163595e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 00:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777966623; x=1778571423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EsTNKUUT3otbOvwNlhUdkMG/7rXwq5KvfCOIV17gPKs=;
 b=tXBfChlBzy5qrvM00TIjoROBgI3U+v+GO0QSdg+N6jOlwl4imZHhKnyciBGbYcTGkL
 6ghvdXMFWVPLQQx77fQFrBYeEayvgAhvxmWX9mcR0hXFZ2UxdP/XXsu1JjmBBTij17wb
 9WkoVtCIT/jXCUz9em/almXCrVUL50EaSLm1dEOUvgsL0sauZXbGP2tPHE5Hmk+zHPg4
 K1171uXZoZ0769evo9lx/HS44LwVJS1r82NPP//pZrX2sV1Zf+6YNhEa/1QzixwsdQrh
 EXvOh/7+U+2Hlx0WF+mVuuMkYEvtkoNheFsmvO1BmxC+zlW4jqg775J/h6JKFobiL4Ce
 TOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777966623; x=1778571423;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EsTNKUUT3otbOvwNlhUdkMG/7rXwq5KvfCOIV17gPKs=;
 b=Qv2d+tsqHg++6I+s8UzdQRCa4goWxKslGwDFmMTW6I5Gj1brDCX8RfSZppF1HHEI7l
 0GvllcEjII9VF0gOwK25zD8ZrT9UR8kP/i2w7YcGvQy7eMox7PxWqlQey3MMv9k0JhHP
 I51Ho19kh2L4uc73Y8aOATW94zhVXDdSMx5vEJa76ISgZ40ctcNhiY8vqmkNw4aenzpT
 KiFcXiQDRAW8BqaE4qKpwgCSJGwcrI7g3o5bI1iwhm+IKWBFY+u/GV0VGw3VFNUPyfWh
 8M4bWkK9Z4fQKUMYHFK6FzQFehL3uExSOybiDfYGQMHjN1AjsbMlM1faJbRAeETOo4EY
 S7Wg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2Y4Q8THk7w9Kk9QztA73QOiycqdDd3aIuWNRloaNsbK1NJUl7lO23AntTU6GWdr4nPyBdLV2X0Eh8@nongnu.org
X-Gm-Message-State: AOJu0YzH3S8/+/6O7EuAVatbX7bBvfPZOKcbRy/Mh84fCMsxrvAfaG5X
 CjT23tbhRvCo61+P7gAP7Z9SaLyVm12vBqw7xBsLLoWdt+oDyxLCmS/IB8NgBHCKTsU=
X-Gm-Gg: AeBDiev3wcWG8sZSIfwouY7B3Zdcg6fNJ7f426XEv1NJ4LPb9/xTP77+oSYzUI13yll
 TqSnzw4RPe8kHXNHbzM5zl0R4OOVCos2rOBGdnQyqv6GU9FukAs52keIV1gD7UKcHLYw6r8NmAP
 VMtM9C3/0C9YLS3J1KrnJhezFIbl6GsZKT+0CZarcwDL4aJfkaPCfIMsPGnCMoiCCfNnle0f/qn
 4UKBK4QFsxGcbyQU/VjksRarmXENa9pi8sWH/DapejZHi8UMLWNOlxRZAjrlFWrZXP3WH1e5kyd
 yqKv3RHDBNx6VO84RmB0fFNRp+fsT7NaXrMwzKs1NkCXbZjN564Dohh0DKruy9MV9ax8CbppWAB
 6BXoT5b+pNNLw2PzzJqEp/9ZqJK8sQl235UObIoLM+vJlunaUZMDp+z4PhnwIxd6dfUyBnn/7L4
 nnwjF2S05lAXK/wD46SozfcHHVKeJ9TpkvF88hcJbTUTnxxkaylKascEiivwh5oCb83g==
X-Received: by 2002:a05:600c:a590:b0:48d:5e7:a5b4 with SMTP id
 5b1f17b1804b1-48d05e7afb7mr80661815e9.23.1777966623444; 
 Tue, 05 May 2026 00:37:03 -0700 (PDT)
Received: from [10.115.35.66] (95.170.88.92.rev.sfr.net. [92.88.170.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d14781f43sm24636675e9.0.2026.05.05.00.36.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 00:37:02 -0700 (PDT)
Message-ID: <1476b7df-b8b7-492a-b46c-81d0bf9cb66e@linaro.org>
Date: Tue, 5 May 2026 09:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/13] hw/i2c: Add designware i2c controller
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair23@gmail.com>
Cc: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Chris Rauer <crauer@google.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-2-joel@jms.id.au>
 <CAKmqyKPyUYfnS3BsHT31hp_P5ufDOZHmr3VW8aUyeTTSTS-Rcw@mail.gmail.com>
 <afmKctliUOEgQrmN@lima-default>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <afmKctliUOEgQrmN@lima-default>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 5/5/26 08:20, Nicholas Piggin wrote:
> On Thu, Apr 30, 2026 at 01:53:21PM +1000, Alistair Francis wrote:
>> On Sat, Apr 25, 2026 at 11:20 PM Joel Stanley <joel@jms.id.au> wrote:
>>>
>>> From: Chris Rauer <crauer@google.com>
>>>
>>> In the past this model has been submitted for use with the arm virt
>>> machine, however in this case it will be used by the upcoming
>>> Tenstorrent Atlantis RISC-V machine.
>>>
>>> This is a re-submission of the model with Chris' permission, with a
>>> light touch of updates to make it build with qemu master.
>>>
>>> Reviewed-by: Hao Wu <wuhaotsh@google.com>
>>> Signed-off-by: Chris Rauer <crauer@google.com>
>>> Link: https://lore.kernel.org/qemu-devel/20220110214755.810343-2-venture@google.com
>>> [jms: rebase and minor build fixes for class_init and reset callback]
>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>> ---


>>> +#define DW_IC_COMP_PARAM_1_HAS_ENCODED_PARAMS   BIT(7)
>>> +#define DW_IC_COMP_PARAM_1_HAS_DMA              0 /* bit 6 - DMA disabled. */
>>> +#define DW_IC_COMP_PARAM_1_INTR_IO              BIT(5)
>>> +#define DW_IC_COMP_PARAM_1_HC_COUNT_VAL         0 /* bit 4 - disabled */
>>> +#define DW_IC_COMP_PARAM_1_HIGH_SPEED_MODE      (BIT(2) | BIT(3))
>>> +#define DW_IC_COMP_PARAM_1_APB_DATA_WIDTH_32    BIT(1) /* bits 0, 1 */
>>> +#define DW_IC_COMP_PARAM_1_INIT_VAL             \
>>> +    (DW_IC_COMP_PARAM_1_APB_DATA_WIDTH_32 | \
>>> +    DW_IC_COMP_PARAM_1_HIGH_SPEED_MODE | \
>>> +    DW_IC_COMP_PARAM_1_HC_COUNT_VAL | \
>>> +    DW_IC_COMP_PARAM_1_INTR_IO | \
>>> +    DW_IC_COMP_PARAM_1_HAS_DMA | \
>>> +    DW_IC_COMP_PARAM_1_HAS_ENCODED_PARAMS | \
>>> +    ((DESIGNWARE_I2C_RX_FIFO_SIZE - 1) << 8) | \
>>> +    ((DESIGNWARE_I2C_TX_FIFO_SIZE - 1) << 16))
>>> +#define DW_IC_COMP_VERSION_INIT_VAL             0x3132302a
>>> +#define DW_IC_COMP_TYPE_INIT_VAL                0x44570140
>>
>> I would prefer these to sue the QEMU register API
> 
> That's probably a good idea. It's a lot of churn to change it, but
> I'm having a try. Might do it as a follow on patch.

Good suggestion but please as a follow up, this patch is already
big enough, is reviewed and tested.

> 
>>> +
>>> +    /* Receive data */
>>> +    if (recv) {
>>> +        uint8_t pos = (s->rx_cur + s->ic_rxflr) % DESIGNWARE_I2C_RX_FIFO_SIZE;
>>> +
>>> +        if (s->ic_rxflr < DESIGNWARE_I2C_RX_FIFO_SIZE) {
>>> +            s->rx_fifo[pos] = i2c_recv(s->bus);
>>> +            s->ic_rxflr++;
>>
>> QEMU also has the Fifo8 which would handle the FIFO for you, I would
>> prefer that as well.
> 
> Yeah, that one isn't so hard and makes the code nicer. I might've found
> a bug in dw_i2c_reset_to_idle() not clearing rx_cur while doing it.
> 
> Thanks,
> Nick
> 


