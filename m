Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A8DE95379
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaTc-0006n7-S4; Wed, 04 Feb 2026 05:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnaTa-0006mp-Sl
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:51:14 -0500
Received: from 5.mo548.mail-out.ovh.net ([188.165.49.213])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vnaTX-000834-OG
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:51:14 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.216])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4f5cbH0PFKz5vTn;
 Wed,  4 Feb 2026 10:51:07 +0000 (UTC)
Received: from kaod.org (37.59.142.108) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 4 Feb
 2026 11:51:05 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S002a6c51236-3782-4637-bdcc-b4673be56201,
 E481ED796CD1A7AD002472F698DA8951F44CEEA4) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <f263fe2e-20cf-408b-885a-f6cd8125c700@kaod.org>
Date: Wed, 4 Feb 2026 11:51:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/20] hw/i3c/dw-i3c: Add more register fields
To: Jamin Lin <jamin_lin@aspeedtech.com>, <komlodi@google.com>,
 <nabihestefan@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>, Patrick Venture
 <venture@google.com>
References: <20260203085229.1543287-1-jamin_lin@aspeedtech.com>
 <20260203085229.1543287-5-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260203085229.1543287-5-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: fad1f23a-720a-4b6e-baaf-7c4e6bbdeaa4
X-Ovh-Tracer-Id: 2637420533270612807
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGFaCAFDPEQkjCgDJXStKDggl0lh8KlnNZxMwk0lQJ88NxM4ClBCMUtRMPgZSTekz7lXML9gPPcv+HU54G1eH9EWuHkLqSToJzNXKBsxbEjOn4PTHSj+gdOPR5qcoBmnISKwaHVOdYJvQBqy+0rEORRiw4kLILjaxBR/35YnVkfc9D1XY95HTrYgfVg9BJYCwdZSAn0zrpStujURh/V2Ux3l4YCMnxTcjuX87z30KL+E6dQKCu7sAMhHRbxrjeBsqYhUNhp2HgnXAj5qtOkNyZ5vS91bN/Fdcf9j0nJCAMSLuB4NRyRjut5/7cWXBLzkm2kJhh1/0vOAhISQjeTfjX4L0EWquj7b5ASpF08N6vKKzMXoavBZW7H4MIGvXWm4PvN6syqo9CBazAGcr4VsX4+iJod4FTYkNbFFkZhzU5gQst01RZT+GCzv68eQm1hKb4i4jkN8sqn8sWqTylQAd/Eczt58ELq+LXqx1jA5czS1k0idTuAC3k3ekn8xaV9HdscKdsJR/tT8GR6aEHCd6OOuiNSEIVQm0+MCahJc8v+fQIQnPXN9wTUWNa2pgJxlpqyMtrf1bRRSZ6tC8+4DooqP2aMH/097PxkRUcPPGCOjJPz3T0IZpI7ctSlS80A9Zqm+E70gR70Sk1SfVJ99WOsEzMkAeamXGlUQ2n7GbUtgQ
DKIM-Signature: a=rsa-sha256; bh=vcYMhoOsyILyLkHIILCjIlCffs/y1kb7PpaIcdebVek=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770202268; v=1;
 b=daP52euSgTyCw1STKOII2dN5lL5OsZxTwLQhXsXmIYm12Iuvl86xK+jhYi96hBChJVWi3UE/
 j5jw4wRJWRkcMXJSLO1QMqnrrDkOZHwsynECdYvHhTqZ+AdD03jirZg+JfktOy27Zi2N+L27LKz
 FPH20/agYx5dHOUgrm+V0iwVciN5jUnzUM4Z8Zl/VbF2PepVBPfTFDdmJhJ54c04KBEm403Quqz
 MXDPHJ3HIGNDtuCWVpaa77mn16e9JZiWHvCj7OoQx92Jfh1/6AoqT5mYIlHVwq52C7cbvbIkevs
 KTdAS95HluR54MDE1D76sKTSLhTRDo/qBvzaCtAXS9vOA==
Received-SPF: pass client-ip=188.165.49.213; envelope-from=clg@kaod.org;
 helo=5.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_75_100=0.001 autolearn=no autolearn_force=no
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

On 2/3/26 09:52, Jamin Lin via qemu development wrote:
> From: Joe Komlodi <komlodi@google.com>
> 
> Adds the rest of the Designware register fields.
> 
> Signed-off-by: Joe Komlodi <komlodi@google.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> 
> Reviewed-by: Patrick Venture <venture@google.com>w


typo in the email address.

C.


> ---
>   hw/i3c/dw-i3c.c | 199 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 199 insertions(+)
> 
> diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
> index c949579ea1..2f04c69320 100644
> --- a/hw/i3c/dw-i3c.c
> +++ b/hw/i3c/dw-i3c.c
> @@ -19,54 +19,253 @@
>   #include "trace.h"
>   
>   REG32(DEVICE_CTRL,                  0x00)
> +    FIELD(DEVICE_CTRL, I3C_BROADCAST_ADDR_INC,    0, 1)
> +    FIELD(DEVICE_CTRL, I2C_SLAVE_PRESENT,         7, 1)
> +    FIELD(DEVICE_CTRL, HOT_JOIN_ACK_NACK_CTRL,    8, 1)
> +    FIELD(DEVICE_CTRL, IDLE_CNT_MULTIPLIER,       24, 2)
> +    FIELD(DEVICE_CTRL, SLV_ADAPT_TO_I2C_I3C_MODE, 27, 1)
> +    FIELD(DEVICE_CTRL, DMA_HANDSHAKE_EN,          28, 1)
> +    FIELD(DEVICE_CTRL, I3C_ABORT,                 29, 1)
> +    FIELD(DEVICE_CTRL, I3C_RESUME,                30, 1)
> +    FIELD(DEVICE_CTRL, I3C_EN,                    31, 1)
>   REG32(DEVICE_ADDR,                  0x04)
> +    FIELD(DEVICE_ADDR, STATIC_ADDR,         0, 7)
> +    FIELD(DEVICE_ADDR, STATIC_ADDR_VALID,   15, 1)
> +    FIELD(DEVICE_ADDR, DYNAMIC_ADDR,        16, 7)
> +    FIELD(DEVICE_ADDR, DYNAMIC_ADDR_VALID,  31, 1)
>   REG32(HW_CAPABILITY,                0x08)
> +    FIELD(HW_CAPABILITY, DEVICE_ROLE_CONFIG,  0, 3)
> +    FIELD(HW_CAPABILITY, HDR_DDR, 3, 1)
> +    FIELD(HW_CAPABILITY, HDR_TS,  4, 1)
>   REG32(COMMAND_QUEUE_PORT,           0x0c)
> +    FIELD(COMMAND_QUEUE_PORT, CMD_ATTR, 0, 3)
> +    /* Transfer command structure */
> +    FIELD(COMMAND_QUEUE_PORT, TID, 3, 4)
> +    FIELD(COMMAND_QUEUE_PORT, CMD, 7, 8)
> +    FIELD(COMMAND_QUEUE_PORT, CP, 15, 1)
> +    FIELD(COMMAND_QUEUE_PORT, DEV_INDEX, 16, 5)
> +    FIELD(COMMAND_QUEUE_PORT, SPEED, 21, 3)
> +    FIELD(COMMAND_QUEUE_PORT, ROC, 26, 1)
> +    FIELD(COMMAND_QUEUE_PORT, SDAP, 27, 1)
> +    FIELD(COMMAND_QUEUE_PORT, RNW, 28, 1)
> +    FIELD(COMMAND_QUEUE_PORT, TOC, 30, 1)
> +    FIELD(COMMAND_QUEUE_PORT, PEC, 31, 1)
> +    /* Transfer argument data structure */
> +    FIELD(COMMAND_QUEUE_PORT, DB, 8, 8)
> +    FIELD(COMMAND_QUEUE_PORT, DL, 16, 16)
> +    /* Short data argument data structure */
> +    FIELD(COMMAND_QUEUE_PORT, BYTE_STRB, 3, 3)
> +    FIELD(COMMAND_QUEUE_PORT, BYTE0, 8, 8)
> +    FIELD(COMMAND_QUEUE_PORT, BYTE1, 16, 8)
> +    FIELD(COMMAND_QUEUE_PORT, BYTE2, 24, 8)
> +    /* Address assignment command structure */
> +    /*
> +     * bits 3..21 and 26..31 are the same as the transfer command structure, or
> +     * marked as reserved.
> +     */
> +    FIELD(COMMAND_QUEUE_PORT, DEV_COUNT, 21, 3)
>   REG32(RESPONSE_QUEUE_PORT,          0x10)
> +    FIELD(RESPONSE_QUEUE_PORT, DL, 0, 16)
> +    FIELD(RESPONSE_QUEUE_PORT, CCCT, 16, 8)
> +    FIELD(RESPONSE_QUEUE_PORT, TID, 24, 3)
> +    FIELD(RESPONSE_QUEUE_PORT, ERR_STATUS, 28, 4)
>   REG32(RX_TX_DATA_PORT,              0x14)
>   REG32(IBI_QUEUE_STATUS,             0x18)
> +    FIELD(IBI_QUEUE_STATUS, IBI_DATA_LEN,   0, 8)
> +    FIELD(IBI_QUEUE_STATUS, IBI_ID,         8, 8)
> +    FIELD(IBI_QUEUE_STATUS, LAST_STATUS,    24, 1)
> +    FIELD(IBI_QUEUE_STATUS, ERROR,          30, 1)
> +    FIELD(IBI_QUEUE_STATUS, IBI_STATUS,     31, 1)
>   REG32(IBI_QUEUE_DATA,               0x18)
>   REG32(QUEUE_THLD_CTRL,              0x1c)
> +    FIELD(QUEUE_THLD_CTRL, CMD_BUF_EMPTY_THLD,  0, 8);
> +    FIELD(QUEUE_THLD_CTRL, RESP_BUF_THLD, 8, 8);
> +    FIELD(QUEUE_THLD_CTRL, IBI_DATA_THLD, 16, 5);
> +    FIELD(QUEUE_THLD_CTRL, IBI_STATUS_THLD,     24, 8);
>   REG32(DATA_BUFFER_THLD_CTRL,        0x20)
> +    FIELD(DATA_BUFFER_THLD_CTRL, TX_BUF_THLD,   0, 3)
> +    FIELD(DATA_BUFFER_THLD_CTRL, RX_BUF_THLD,   8, 3)
> +    FIELD(DATA_BUFFER_THLD_CTRL, TX_START_THLD, 16, 3)
> +    FIELD(DATA_BUFFER_THLD_CTRL, RX_START_THLD, 24, 3)
>   REG32(IBI_QUEUE_CTRL,               0x24)
> +    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_HOT_JOIN,   0, 1)
> +    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_MASTER_REQ, 1, 1)
> +    FIELD(IBI_QUEUE_CTRL, NOTIFY_REJECTED_SLAVE_IRQ,  3, 1)
>   REG32(IBI_MR_REQ_REJECT,            0x2c)
>   REG32(IBI_SIR_REQ_REJECT,           0x30)
>   REG32(RESET_CTRL,                   0x34)
> +    FIELD(RESET_CTRL, CORE_RESET,       0, 1)
> +    FIELD(RESET_CTRL, CMD_QUEUE_RESET,  1, 1)
> +    FIELD(RESET_CTRL, RESP_QUEUE_RESET, 2, 1)
> +    FIELD(RESET_CTRL, TX_BUF_RESET,     3, 1)
> +    FIELD(RESET_CTRL, RX_BUF_RESET,     4, 1)
> +    FIELD(RESET_CTRL, IBI_QUEUE_RESET,  5, 1)
>   REG32(SLV_EVENT_CTRL,               0x38)
> +    FIELD(SLV_EVENT_CTRL, SLV_INTERRUPT,      0, 1)
> +    FIELD(SLV_EVENT_CTRL, MASTER_INTERRUPT,   1, 1)
> +    FIELD(SLV_EVENT_CTRL, HOT_JOIN_INTERRUPT, 3, 1)
> +    FIELD(SLV_EVENT_CTRL, ACTIVITY_STATE,     4, 2)
> +    FIELD(SLV_EVENT_CTRL, MRL_UPDATED,        6, 1)
> +    FIELD(SLV_EVENT_CTRL, MWL_UPDATED,        7, 1)
>   REG32(INTR_STATUS,                  0x3c)
> +    FIELD(INTR_STATUS, TX_THLD,           0, 1)
> +    FIELD(INTR_STATUS, RX_THLD,           1, 1)
> +    FIELD(INTR_STATUS, IBI_THLD,          2, 1)
> +    FIELD(INTR_STATUS, CMD_QUEUE_RDY,     3, 1)
> +    FIELD(INTR_STATUS, RESP_RDY,          4, 1)
> +    FIELD(INTR_STATUS, TRANSFER_ABORT,    5, 1)
> +    FIELD(INTR_STATUS, CCC_UPDATED,       6, 1)
> +    FIELD(INTR_STATUS, DYN_ADDR_ASSGN,    8, 1)
> +    FIELD(INTR_STATUS, TRANSFER_ERR,      9, 1)
> +    FIELD(INTR_STATUS, DEFSLV,            10, 1)
> +    FIELD(INTR_STATUS, READ_REQ_RECV,     11, 1)
> +    FIELD(INTR_STATUS, IBI_UPDATED,       12, 1)
> +    FIELD(INTR_STATUS, BUSOWNER_UPDATED,  13, 1)
>   REG32(INTR_STATUS_EN,               0x40)
> +    FIELD(INTR_STATUS_EN, TX_THLD,          0, 1)
> +    FIELD(INTR_STATUS_EN, RX_THLD,          1, 1)
> +    FIELD(INTR_STATUS_EN, IBI_THLD,         2, 1)
> +    FIELD(INTR_STATUS_EN, CMD_QUEUE_RDY,    3, 1)
> +    FIELD(INTR_STATUS_EN, RESP_RDY,         4, 1)
> +    FIELD(INTR_STATUS_EN, TRANSFER_ABORT,   5, 1)
> +    FIELD(INTR_STATUS_EN, CCC_UPDATED,      6, 1)
> +    FIELD(INTR_STATUS_EN, DYN_ADDR_ASSGN,   8, 1)
> +    FIELD(INTR_STATUS_EN, TRANSFER_ERR,     9, 1)
> +    FIELD(INTR_STATUS_EN, DEFSLV,           10, 1)
> +    FIELD(INTR_STATUS_EN, READ_REQ_RECV,    11, 1)
> +    FIELD(INTR_STATUS_EN, IBI_UPDATED,      12, 1)
> +    FIELD(INTR_STATUS_EN, BUSOWNER_UPDATED, 13, 1)
>   REG32(INTR_SIGNAL_EN,               0x44)
> +    FIELD(INTR_SIGNAL_EN, TX_THLD,          0, 1)
> +    FIELD(INTR_SIGNAL_EN, RX_THLD,          1, 1)
> +    FIELD(INTR_SIGNAL_EN, IBI_THLD,         2, 1)
> +    FIELD(INTR_SIGNAL_EN, CMD_QUEUE_RDY,    3, 1)
> +    FIELD(INTR_SIGNAL_EN, RESP_RDY,         4, 1)
> +    FIELD(INTR_SIGNAL_EN, TRANSFER_ABORT,   5, 1)
> +    FIELD(INTR_SIGNAL_EN, CCC_UPDATED,      6, 1)
> +    FIELD(INTR_SIGNAL_EN, DYN_ADDR_ASSGN,   8, 1)
> +    FIELD(INTR_SIGNAL_EN, TRANSFER_ERR,     9, 1)
> +    FIELD(INTR_SIGNAL_EN, DEFSLV,           10, 1)
> +    FIELD(INTR_SIGNAL_EN, READ_REQ_RECV,    11, 1)
> +    FIELD(INTR_SIGNAL_EN, IBI_UPDATED,      12, 1)
> +    FIELD(INTR_SIGNAL_EN, BUSOWNER_UPDATED, 13, 1)
>   REG32(INTR_FORCE,                   0x48)
> +    FIELD(INTR_FORCE, TX_THLD,          0, 1)
> +    FIELD(INTR_FORCE, RX_THLD,          1, 1)
> +    FIELD(INTR_FORCE, IBI_THLD,         2, 1)
> +    FIELD(INTR_FORCE, CMD_QUEUE_RDY,    3, 1)
> +    FIELD(INTR_FORCE, RESP_RDY,         4, 1)
> +    FIELD(INTR_FORCE, TRANSFER_ABORT,   5, 1)
> +    FIELD(INTR_FORCE, CCC_UPDATED,      6, 1)
> +    FIELD(INTR_FORCE, DYN_ADDR_ASSGN,   8, 1)
> +    FIELD(INTR_FORCE, TRANSFER_ERR,     9, 1)
> +    FIELD(INTR_FORCE, DEFSLV,           10, 1)
> +    FIELD(INTR_FORCE, READ_REQ_RECV,    11, 1)
> +    FIELD(INTR_FORCE, IBI_UPDATED,      12, 1)
> +    FIELD(INTR_FORCE, BUSOWNER_UPDATED, 13, 1)
>   REG32(QUEUE_STATUS_LEVEL,           0x4c)
> +    FIELD(QUEUE_STATUS_LEVEL, CMD_QUEUE_EMPTY_LOC,  0, 8)
> +    FIELD(QUEUE_STATUS_LEVEL, RESP_BUF_BLR,         8, 8)
> +    FIELD(QUEUE_STATUS_LEVEL, IBI_BUF_BLR,          16, 8)
> +    FIELD(QUEUE_STATUS_LEVEL, IBI_STATUS_CNT,       24, 5)
>   REG32(DATA_BUFFER_STATUS_LEVEL,     0x50)
> +    FIELD(DATA_BUFFER_STATUS_LEVEL, TX_BUF_EMPTY_LOC, 0, 8)
> +    FIELD(DATA_BUFFER_STATUS_LEVEL, RX_BUF_BLR,       16, 8)
>   REG32(PRESENT_STATE,                0x54)
> +    FIELD(PRESENT_STATE, SCL_LINE_SIGNAL_LEVEL, 0, 1)
> +    FIELD(PRESENT_STATE, SDA_LINE_SIGNAL_LEVEL, 1, 1)
> +    FIELD(PRESENT_STATE, CURRENT_MASTER,        2, 1)
> +    FIELD(PRESENT_STATE, CM_TFR_STATUS,         8, 6)
> +    FIELD(PRESENT_STATE, CM_TFR_ST_STATUS,      16, 6)
> +    FIELD(PRESENT_STATE, CMD_TID,               24, 4)
>   REG32(CCC_DEVICE_STATUS,            0x58)
> +    FIELD(CCC_DEVICE_STATUS, PENDING_INTR,      0, 4)
> +    FIELD(CCC_DEVICE_STATUS, PROTOCOL_ERR,      5, 1)
> +    FIELD(CCC_DEVICE_STATUS, ACTIVITY_MODE,     6, 2)
> +    FIELD(CCC_DEVICE_STATUS, UNDER_ERR,         8, 1)
> +    FIELD(CCC_DEVICE_STATUS, SLV_BUSY,          9, 1)
> +    FIELD(CCC_DEVICE_STATUS, OVERFLOW_ERR,      10, 1)
> +    FIELD(CCC_DEVICE_STATUS, DATA_NOT_READY,    11, 1)
> +    FIELD(CCC_DEVICE_STATUS, BUFFER_NOT_AVAIL,  12, 1)
>   REG32(DEVICE_ADDR_TABLE_POINTER,    0x5c)
>       FIELD(DEVICE_ADDR_TABLE_POINTER, DEPTH, 16, 16)
>       FIELD(DEVICE_ADDR_TABLE_POINTER, ADDR,  0,  16)
>   REG32(DEV_CHAR_TABLE_POINTER,       0x60)
> +    FIELD(DEV_CHAR_TABLE_POINTER, P_DEV_CHAR_TABLE_START_ADDR,  0, 12)
> +    FIELD(DEV_CHAR_TABLE_POINTER, DEV_CHAR_TABLE_DEPTH,         12, 7)
> +    FIELD(DEV_CHAR_TABLE_POINTER, PRESENT_DEV_CHAR_TABLE_INDEX, 19, 3)
>   REG32(VENDOR_SPECIFIC_REG_POINTER,  0x6c)
> +    FIELD(VENDOR_SPECIFIC_REG_POINTER, P_VENDOR_REG_START_ADDR, 0, 16)
>   REG32(SLV_MIPI_PID_VALUE,           0x70)
>   REG32(SLV_PID_VALUE,                0x74)
> +    FIELD(SLV_PID_VALUE, SLV_PID_DCR, 0, 12)
> +    FIELD(SLV_PID_VALUE, SLV_INST_ID, 12, 4)
> +    FIELD(SLV_PID_VALUE, SLV_PART_ID, 16, 16)
>   REG32(SLV_CHAR_CTRL,                0x78)
> +    FIELD(SLV_CHAR_CTRL, BCR,     0, 8)
> +    FIELD(SLV_CHAR_CTRL, DCR,     8, 8)
> +    FIELD(SLV_CHAR_CTRL, HDR_CAP, 16, 8)
>   REG32(SLV_MAX_LEN,                  0x7c)
> +    FIELD(SLV_MAX_LEN, MWL, 0, 16)
> +    FIELD(SLV_MAX_LEN, MRL, 16, 16)
>   REG32(MAX_READ_TURNAROUND,          0x80)
>   REG32(MAX_DATA_SPEED,               0x84)
>   REG32(SLV_DEBUG_STATUS,             0x88)
>   REG32(SLV_INTR_REQ,                 0x8c)
> +    FIELD(SLV_INTR_REQ, SIR,          0, 1)
> +    FIELD(SLV_INTR_REQ, SIR_CTRL,     1, 2)
> +    FIELD(SLV_INTR_REQ, MIR,          3, 1)
> +    FIELD(SLV_INTR_REQ, TS,           4, 1)
> +    FIELD(SLV_INTR_REQ, IBI_STS,      8, 2)
> +REG32(SLV_TSX_SYMBL_TIMING,         0x90)
> +    FIELD(SLV_TSX_SYMBL_TIMING, SLV_TSX_SYMBL_CNT, 0, 6)
>   REG32(DEVICE_CTRL_EXTENDED,         0xb0)
> +    FIELD(DEVICE_CTRL_EXTENDED, MODE, 0, 2)
> +    FIELD(DEVICE_CTRL_EXTENDED, REQMST_ACK_CTRL, 3, 1)
>   REG32(SCL_I3C_OD_TIMING,            0xb4)
> +    FIELD(SCL_I3C_OD_TIMING, I3C_OD_LCNT, 0, 8)
> +    FIELD(SCL_I3C_OD_TIMING, I3C_OD_HCNT, 16, 8)
>   REG32(SCL_I3C_PP_TIMING,            0xb8)
> +    FIELD(SCL_I3C_PP_TIMING, I3C_PP_LCNT, 0, 8)
> +    FIELD(SCL_I3C_PP_TIMING, I3C_PP_HCNT, 16, 8)
>   REG32(SCL_I2C_FM_TIMING,            0xbc)
>   REG32(SCL_I2C_FMP_TIMING,           0xc0)
> +    FIELD(SCL_I2C_FMP_TIMING, I2C_FMP_LCNT, 0, 16)
> +    FIELD(SCL_I2C_FMP_TIMING, I2C_FMP_HCNT, 16, 8)
>   REG32(SCL_EXT_LCNT_TIMING,          0xc8)
>   REG32(SCL_EXT_TERMN_LCNT_TIMING,    0xcc)
>   REG32(BUS_FREE_TIMING,              0xd4)
>   REG32(BUS_IDLE_TIMING,              0xd8)
> +    FIELD(BUS_IDLE_TIMING, BUS_IDLE_TIME, 0, 20)
>   REG32(I3C_VER_ID,                   0xe0)
>   REG32(I3C_VER_TYPE,                 0xe4)
>   REG32(EXTENDED_CAPABILITY,          0xe8)
>   REG32(SLAVE_CONFIG,                 0xec)
> +/* Device characteristic table fields */
> +REG32(DEVICE_CHARACTERISTIC_TABLE_LOC1, 0x200)
> +REG32(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, 0x200)
> +    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, DYNAMIC_ADDR, 0, 8)
> +    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, DCR, 8, 8)
> +    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, BCR, 16, 8)
> +    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC_SECONDARY, STATIC_ADDR, 24, 8)
> +REG32(DEVICE_CHARACTERISTIC_TABLE_LOC2, 0x204)
> +    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC2, MSB_PID, 0, 16)
> +REG32(DEVICE_CHARACTERISTIC_TABLE_LOC3, 0x208)
> +    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC3, DCR, 0, 8)
> +    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC3, BCR, 8, 8)
> +REG32(DEVICE_CHARACTERISTIC_TABLE_LOC4, 0x20c)
> +    FIELD(DEVICE_CHARACTERISTIC_TABLE_LOC4, DEV_DYNAMIC_ADDR, 0, 8)
> +/* Dev addr table fields */
> +REG32(DEVICE_ADDR_TABLE_LOC1, 0x280)
> +    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_STATIC_ADDR, 0, 7)
> +    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_PEC_EN, 11, 1)
> +    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_WITH_DATA, 12, 1)
> +    FIELD(DEVICE_ADDR_TABLE_LOC1, SIR_REJECT, 13, 1)
> +    FIELD(DEVICE_ADDR_TABLE_LOC1, MR_REJECT, 14, 1)
> +    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_DYNAMIC_ADDR, 16, 8)
> +    FIELD(DEVICE_ADDR_TABLE_LOC1, IBI_ADDR_MASK, 24, 2)
> +    FIELD(DEVICE_ADDR_TABLE_LOC1, DEV_NACK_RETRY_CNT, 29, 2)
> +    FIELD(DEVICE_ADDR_TABLE_LOC1, LEGACY_I2C_DEVICE, 31, 1)
>   
>   static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] = {
>       [R_HW_CAPABILITY]               = 0x000e00bf,


