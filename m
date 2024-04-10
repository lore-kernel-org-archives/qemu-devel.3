Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C92CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 08:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruTIn-0006Hh-Ry; Wed, 10 Apr 2024 04:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruTIk-0006HA-Fk
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 04:27:26 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruTIi-0006jN-LA
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 04:27:26 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a51a7dc45easo612649566b.2
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712737642; x=1713342442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TvNUWkfIStlGuEJgVPFYmXNVjyyN3UG8KuLFg/lC00A=;
 b=n9J1hXb0SaENTmHI3cm5R3TPG/LZYWGATbo5GXrgpCYSEQAghR9+i5Y474xYgxrC4/
 HYyumb+lzS7WITO+K0rC0uGVy66g+D+Hw5y27OXzLhr1IRrMrby1OXnwxe/5PEEnw5e8
 L7xpZI2MC76DdgEVVQk8UD4u8t5mFwkdNPwWTiPWJf+N82c36NKM7rAmKqjT6GSvkCsG
 00nVgw7TSZjCDPFRq2AjRiBmVFh+rxnSX26wkKqhCNzy02E5d5jhbFZzD2P9cV34Na+p
 mabXrkHcW+eAuQmgTv/W3tvifXug9PBqUo4mo+W6WpVtBu3TaTgdYtUorf51jf7NypSF
 AoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712737642; x=1713342442;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TvNUWkfIStlGuEJgVPFYmXNVjyyN3UG8KuLFg/lC00A=;
 b=nTrBHFenCBenT2vCNXmS+G285alOT35MTBWrRovyH0T4gQOXqMNBsGIBL9Mb1IulK6
 ZllJtwKBh73pLFQShhh2mI3IME2Y8S7/a/lTT5/ongicMbDFS5KUorLgHPtkVFFuUGtf
 iT51Rhq3TJgh5Nsud4rjJ5YoKjX6y1onQ283Hlnt4orjgU6/usDsWNXhHK80+Iog8gLf
 mVzEWPzQmgme8E3j41Qh7ONpLkRBov7oA3m2icH9sEn7uqu6yB1Nx7VQWjLBMPtr+CRc
 7y9Xb0vTLQf78gZAl7aAdL/+u4D262uKZ5FZX83LuGBIHPiJ0nzAWcmbEJ5wxiBmzugJ
 sqbQ==
X-Gm-Message-State: AOJu0Ywr1BtvKaY2Yo9u+9xENI3c1VbktR1zhuxiRr/KwcvERUxXe2kW
 aQ4s5sr36CMBRU/IeWEcaOMcKn9eUqlXqbCe0svmFdgd1g7Mx3+y1JSGMa3PMPk=
X-Google-Smtp-Source: AGHT+IEYs0ReobtgzmNvCORFzj1wdNMnPfV5v0DYxhnk8o7M6i5euox4lYAfL8PqSBHXFYwkzfGGVQ==
X-Received: by 2002:a17:906:4ac9:b0:a51:7ee5:514f with SMTP id
 u9-20020a1709064ac900b00a517ee5514fmr1074238ejt.3.1712737641816; 
 Wed, 10 Apr 2024 01:27:21 -0700 (PDT)
Received: from [192.168.69.100] (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 ho40-20020a1709070ea800b00a4e8acaccb1sm6627330ejc.132.2024.04.10.01.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 01:27:21 -0700 (PDT)
Message-ID: <7f9861df-6647-4edf-adb2-49a4dbeaf800@linaro.org>
Date: Wed, 10 Apr 2024 10:27:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? v2] hw/net/net_tx_pkt: Fix overrun in
 update_sctp_checksum()
To: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, qemu-stable@nongnu.org,
 Zheyu Ma <zheyuma97@gmail.com>
References: <20240410070459.49112-1-philmd@linaro.org>
 <CAA8xKjVrv5cnpuLiNsZxoA8RfX8-jN3PvKYCAcPXY2Xcmw-wFw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAA8xKjVrv5cnpuLiNsZxoA8RfX8-jN3PvKYCAcPXY2Xcmw-wFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 10/4/24 09:35, Mauro Matteo Cascella wrote:
> Hi,
> 
> On Wed, Apr 10, 2024 at 9:05 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> If a fragmented packet size is too short, do not try to
>> calculate its checksum.
> 
> This was assigned CVE-2024-3567.

Thanks for the quick reaction!

>> Reproduced using:
>>
>>    $ cat << EOF | qemu-system-i386 -display none -nodefaults \
>>                                    -machine q35,accel=qtest -m 32M \
>>                                    -device igb,netdev=net0 \
>>                                    -netdev user,id=net0 \
>>                                    -qtest stdio
>>    outl 0xcf8 0x80000810
>>    outl 0xcfc 0xe0000000
>>    outl 0xcf8 0x80000804
>>    outw 0xcfc 0x06
>>    write 0xe0000403 0x1 0x02
>>    writel 0xe0003808 0xffffffff
>>    write 0xe000381a 0x1 0x5b
>>    write 0xe000381b 0x1 0x00
>>    EOF
>>    Assertion failed: (offset == 0), function iov_from_buf_full, file util/iov.c, line 39.
>>    #1 0x5575e81e952a in iov_from_buf_full qemu/util/iov.c:39:5
>>    #2 0x5575e6500768 in net_tx_pkt_update_sctp_checksum qemu/hw/net/net_tx_pkt.c:144:9
>>    #3 0x5575e659f3e1 in igb_setup_tx_offloads qemu/hw/net/igb_core.c:478:11
>>    #4 0x5575e659f3e1 in igb_tx_pkt_send qemu/hw/net/igb_core.c:552:10
>>    #5 0x5575e659f3e1 in igb_process_tx_desc qemu/hw/net/igb_core.c:671:17
>>    #6 0x5575e659f3e1 in igb_start_xmit qemu/hw/net/igb_core.c:903:9
>>    #7 0x5575e659f3e1 in igb_set_tdt qemu/hw/net/igb_core.c:2812:5
>>    #8 0x5575e657d6a4 in igb_core_write qemu/hw/net/igb_core.c:4248:9
>>
>> Cc: qemu-stable@nongnu.org
>> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
>> Fixes: f199b13bc1 ("igb: Implement Tx SCTP CSO")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2273
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Since v1: check at offset 8 (Akihiko)
>> ---
>>   hw/net/net_tx_pkt.c | 4 ++++
>>   1 file changed, 4 insertions(+)

Patch queued.


