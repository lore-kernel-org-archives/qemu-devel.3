Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24C3C531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 18:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmyDV-0001XG-BL; Thu, 23 Jul 2026 14:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmyDA-0001S2-8q
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 14:32:02 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wmyD4-0004iM-4l
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 14:31:59 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso675075f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 11:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784831482; x=1785436282; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9IUQr6dRDSnojFA7KPPEV0ZefekKlqix5Uxqq1XSfSg=;
 b=Slxfd3oofTzjiLrUYAEfiups+zJN3HwDvboMi+EkcWyzwro0Rtnk+VlSCYq4xLt0QX
 yQcbEvXzshUGfKQgcPtZqRzn8VHJ4MGhvV7NjNoQ6lLkwQoJ9fgWl6C1NON7lYNe4BeQ
 VBmdYJyz7XHiOUQgbclJ3E0DsEcIru7aLGIW9X1R2sao0MctnHcwgTQUik9CvkJri+kJ
 2bRJHMdDTDzC8ItU4K9tyCSJHHgcYJWpqS2qn4AoVG/p3ax4+tiOyckQ5yuJ5dSVpqUs
 EgragKiCbhYs6DOi9V/VCVdrP1V4TJKK8bvloi+MAfWYYXZbslSbfWqc5oZgOQt90vOO
 BlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784831482; x=1785436282;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9IUQr6dRDSnojFA7KPPEV0ZefekKlqix5Uxqq1XSfSg=;
 b=gvpPFO+DLD4JqrPntn19yqqd4VCO/GZFwohbx/yi55Tfijc0Hz9s9RiIF1tD95p64t
 3vAl4XwbhkRlOsl1TI3zlNyUvJmHDJWLLt+A+FiHDe9bu0Q2yoy75DVzL1FZ/hca6aoz
 eFs2gOcnqgzMzfuVNpmApL1kqgviAL6ZQhsenbujFu2qTb0l7VoRzStJ5gigfoKcyX9/
 ItkWt0m+1m8m6GE8EyhQJ2NVjiZXE+/bK+IytaXthSToJIxw7AZ8wncvffNgd12S4EMF
 0Hmcrd1lXwRtD1y+P3ehBInH8GKGObxa2ry9aibxWtfQb5dDE8V4qffRAvAES6b2v20X
 602Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoN4j5a7lHt0zWzr0JDKKv6FnZzbUFhZ4Ek0Z0MZtFjKSpU3hRPQxlaDyCZ2UVn186uYsfvsvqzBHm7@nongnu.org
X-Gm-Message-State: AOJu0YyZAPpD712gYVpvdSOH1ZYtF1tutMg01r/TRCllQLu7oLdtr7hO
 zIews7oOZ8EjaJH6VsP8UDD6OODJInAwGXBkoRldHa9VbkhCsmZaLsvN
X-Gm-Gg: AR+sD11DJxPEvjuhXQ3+sONwPppPTUrM/V0Rg7vgyvB+8eH/rLy8NFPil/oN8DWTRPK
 6/T1HWTVlyaExcKAUMNKPzqdIbZ+ExnlhlOHdUmxkEv9O1RAuaQ7ni0P76NGF/5Dm4bRSO4l5q5
 z0ZPDrftfw5Az3ZPgAR6k4C5csa8E09OkdykBjMEGJAtqOLgSFmAhTs3nMIFc2EJikePjwllNkm
 OSr6z17w+D2DdGqbpTXB3L6eOXnOYBdLl1hmUem4WcSGkOTl0itoPb0ScuPlvwuxzSnjqLOkQJv
 QgE0P9FksktT6rP+j0VYv970WABs5lYkuW2TkddURA/hmlVrW9onZYaQA/915JcCBaSu2iI9C/U
 cC19WWfBJUhwPU5nPTbdVmaNT2E1gyZ9QehdLHnAcsBHcy+xOzMzH1cAgYfHH/NgPlDZHJIO/wT
 fhrl59v8Vo
X-Received: by 2002:a05:6000:25c3:b0:475:f0f0:9ef7 with SMTP id
 ffacd0b85a97d-47f8d76ee04mr5099034f8f.60.1784831481490; 
 Thu, 23 Jul 2026 11:31:21 -0700 (PDT)
Received: from ehlo.thunderbird.net ([185.238.219.95])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6ef25sm16033983f8f.36.2026.07.23.11.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 11:31:20 -0700 (PDT)
Date: Thu, 23 Jul 2026 18:31:00 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Pavel Pisa <pisa@fel.cvut.cz>
CC: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
Subject: Re: [PATCH 7/9] hw/net/flexcan: Drop oversized 'mb[]' mailbox view
In-Reply-To: <202607231251.05529.pisa@fel.cvut.cz>
References: <20260723070059.6332-1-shentey@gmail.com>
 <84061116-c6d5-4def-acd8-ba9c81a0eece@oss.qualcomm.com>
 <F33F7AFC-1868-49E8-95C8-CBB04339F6A3@gmail.com>
 <202607231251.05529.pisa@fel.cvut.cz>
Message-ID: <3A984F2D-FCCC-401C-8ADD-6335C7F44478@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x433.google.com
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



Am 23=2E Juli 2026 10:51:05 UTC schrieb Pavel Pisa <pisa@fel=2Ecvut=2Ecz>:
>Hello Bernhard and Philippe,

Hi Pavel,

>On Thursday 23 of July 2026 12:26:41 Bernhard Beschow wrote:
>> Am 23=2E Juli 2026 08:20:34 UTC schrieb "Philippe Mathieu-Daud=C3=A9"=
=20
><philmd@oss=2Equalcomm=2Ecom>:
>> >On 23/7/26 09:00, Bernhard Beschow wrote:
>> >> As indicated in the comments, the `mb[]` a=2Ek=2Ea=2E `mbs []` views=
 should
>> >> cover 0x400 (1024) bytes=2E However, the `mb[]` array covers four ti=
mes
>> >> the size since `sizeof(FlexcanRegsMessageBuffer)` returns the size i=
n
>> >> bytes instead of counting the number of uint32_t fields=2E This shif=
ts the
>> >> subsequent register offsets by 0xc00 which is not intended=2E Fix th=
e size
>> >> and thus the offsets by dropping the now unused `mb[]` view=2E
>> >>
>> >> Note that the different size changes the migration layout=2E Since t=
he
>> >> device model is new, no change in the version fields is needed=2E
>> >
>> >typedef struct FlexcanState {
>> >    =2E=2E=2E
>> >    union {
>> >        FlexcanRegs     regs;
>> >        uint32_t        regs_raw[sizeof(FlexcanRegs) / 4];
>> >    };
>> >    =2E=2E=2E
>> >} FlexcanState;
>> >
>> >static const VMStateDescription vmstate_can =3D {
>> >    =2Ename =3D TYPE_CAN_FLEXCAN,
>> >    =2Eversion_id =3D 1,
>> >    =2Eminimum_version_id =3D 1,
>> >    =2Efields =3D (const VMStateField[]) {
>> >        =2E=2E=2E
>> >        VMSTATE_UINT32_ARRAY(regs_raw, FlexcanState, sizeof(FlexcanReg=
s) /
>> > 4),
>> >
>> >        ^^^
>> >
>> >This "consider this structure as a casted array of u32" is very fragil=
e
>> >anyway, and will unlikely scale over time=2E
>> >
>> >        =2E=2E=2E
>> >        VMSTATE_END_OF_LIST(),
>> >    },
>> >};
>>
>> Any suggestions what to do instead?
>>
>
>I would suggest to keep the state as uint32_t array=2E
>It is accessed by this and only by this size as the
>FlexCAN MemoryRegionOps are defined=2E In the fact
>I would like/plan in longer term, even to switch
>the mbs array to be plain area of uint32_t in the future,
>that is remove field
>
>  FlexcanRegsMessageBuffer mbs[FLEXCAN_MAILBOX_COUNT];
>
>in FlexcanRegs=2E
>
>There should be only function which would return start
>of given FlexcanRegsMessageBuffer based on index
>argument and actual message buffers configuration=2E
>It is required for CAN FD where message buffer
>size is configurable=2E The raw/uint32_t area is kept
>the same, but it is distributed to the indexed
>buffers different way=2E
>
>So my preference is to move from structured view
>in direction to the offsets in the words array=2E
>Even the registers could be defined as offsets
>to this array in the theory but as the overlay
>structure for register accesses is used even
>in the Linux kernel driver, I do not think that
>this is necessary=2E
>
>But replacement of
>
>  FlexcanRegsMessageBuffer mbs[FLEXCAN_MAILBOX_COUNT];
>
>with appropriate
>
>  uint32_t mbs[FLEXCAN_MAILBOX_AREA_WORD_COUNT];
>
>and access functions would please me, because
>it helps with future CAN FD support=2E

Having CAN FD support would be nice indeed=2E Let's keep the code simple f=
or now though until it gets implemented=2E Having just one way of doing thi=
ngs helps avoid traps such as those fixed in this series=2E We can change t=
he code any time as we need it=2E

Best regards,
Bernhard

>
>Best wishes,
>
>                Pavel Pisa
>    phone:      +420 603531357
>    e-mail:     pisa@cmp=2Efelk=2Ecvut=2Ecz
>    Department of Control Engineering FEE CVUT
>    Karlovo namesti 13, 121 35, Prague 2
>    university: http://control=2Efel=2Ecvut=2Ecz/
>    personal:   http://cmp=2Efelk=2Ecvut=2Ecz/~pisa
>    social:     https://social=2Ekernel=2Eorg/ppisa
>    projects:   https://www=2Eopenhub=2Enet/accounts/ppisa
>    CAN related:http://canbus=2Epages=2Efel=2Ecvut=2Ecz/
>    RISC-V education: https://comparch=2Eedu=2Ecvut=2Ecz/
>    Open Technologies Research Education and Exchange Services
>    https://gitlab=2Efel=2Ecvut=2Ecz/otrees/org/-/wikis/home

