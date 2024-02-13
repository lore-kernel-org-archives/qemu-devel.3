Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FA3C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZueJ-0008Eo-CC; Tue, 13 Feb 2024 10:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZueG-0008E6-7O
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:24:40 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZueE-0000ep-GC
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:24:39 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-411a5a86078so11035105e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707837876; x=1708442676; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NnERH8CLXZnHJKrLceDOpJ/dglooNx+nyZRpfQtAwxo=;
 b=JU1DLbn4YY9O91NBFZdEUlHBLFtHOiudTig4zt8GCt++9oz5CRoxRCP+ZG/3im4NJ0
 b7Xtwgm2tC/T6hv14aj/6/sz0PQ3yTrb6jOeNrotaFDQNheQhIBMOGa3a8Wr4PeaJJKb
 DqbUmD17OFtUDQyHWE6e0cc52/irYliAPueTeVQUlT1NEOynY1H1R4Gg47LGbYQCJ9wt
 GKIBuyliNa4OccxVMiMW8Wcz+MTgpfkCftdlcv46Gfe/DUokVJeKIHD7ddH1QmUaP3Dq
 ZLOkbu/bsu5f7uvz1AgfUdP6VXTi56uTr5F37N+Tpe4ZoOZoT2zO1HqRfFvlzDil+2yP
 yv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707837876; x=1708442676;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NnERH8CLXZnHJKrLceDOpJ/dglooNx+nyZRpfQtAwxo=;
 b=C8l70choBWretxj3LxCW53P0IwZw2u3j/fsqv7FzIw5Pq86GIJigDEB750FhKDzoVs
 Bsj+JpzoU+CFONycV/KDAEO7YfjnfkS8dYKl7vYPhg1ktuv1D36FYOD9uD5g9zjJtZqY
 2/y/BmkwoI/t1N+fyarYuti2x8KqTGdo4GLWdYUysht+7ZKlH2gXb2i0YrAs0seSYkHe
 8mbXFwhgynC/D24zNssnf76K4AiB/Pulo0gA7adEuCWg2sf4HsEqtyYlvTzWG3OZYGSl
 fs0QkotUyB+dl2xBd0HXpkTn/JnORzPJKBSofaHY+NjWa96xEQnNN0uLIge3IBOhA7vr
 4vrg==
X-Gm-Message-State: AOJu0YzkeeVOk0wzsW9iDhU4gwBsU9LSkrOgevfNixQ28W268EZhUT9K
 UpbgenOp+s23nJVRZTpunuyRIBUDY6FQNgc46HS0+JWJbnDrKWZfPsTp+jEazy2r+J+WU21ojmi
 P
X-Google-Smtp-Source: AGHT+IFzV/2BApd2A12IunlPC5Kv9//xOOvkvoRw03w135M3RkiwdjzBjfw//EQEfL6SfdE5cnEhfw==
X-Received: by 2002:a05:600c:45c6:b0:410:4a3:1ae7 with SMTP id
 s6-20020a05600c45c600b0041004a31ae7mr8579966wmo.17.1707837876114; 
 Tue, 13 Feb 2024 07:24:36 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUwff/SLBpfFJIYgBx61kYLDmeDYvx6wFNTf1uE77S8ATDoGrC8Y9pW0wV5cq/szn1jg9+6UbOBGGV7Pv2vMsu5M/m/9RIv16JQL9EFIjnsWugsBDt/qxkL4PyXqU/Q0fMpKzmHN7cn8JBVdEY/pvAZbKxBvLAD06aqxjYBHizmCGeE157npenS8HFQJFrUSEaNI4nfshz+11332EAgJzfYhssJ3/RYtK4yyxBXdwhQ2pqzrh1I5XQDdjuU+ldeQsfvhrvaf1PT4K9bUoVWGl9nd9p+kQxoKm/vZ8MrlEwlXIKCUecVIsE4Ocyp3IBa3JqTp0N4GV4lxF8nKP8vvsFu0nFl9O/OS3hMUX2jl3nVwZODNDnu2z7GGPtS8bYOSfoTKWXNlPS8mBGhtJrJUQx4dTYiqUs3VEol1qb1Wbr0FZEnq6jj80R2uZKz54VMMY//GNSL6p3NP0dCx2Oler4SBkl+Mze6hWOCSDCGxj+dPEr+Bjq51zUBGRPCzte6li+a22ywPQZQrTuvIOCAWFGRQHqeUnTdbCShQl0lTl/w5bQ546b1VFvMYwl/5xP7YqIu7Dn0OJ4mv5yv3lvVDpbKKeB5Iz4jSwi5KW2Mr3DNFs+7fr3dt3DzWis/WU8W/0oZgj9FFgc1kaC3jZ9j4Er1dlYg71RcfNJ3iRUmjN7LlGlRh60D3ykl2aUfUKwpA1F9k3P0tf+qNoqG30/26QyzjIp8C47hnxDh8/Ziy2ArmhRYmCe5zd+mwkEIcXduCVWHLG/3R70syimWVvfIoXl420kaQFUHzUgtimjvc3mkfdPKeWmXyfJcUr6vruQgCz9leYrNtLI2Uui3kOTeRC70riFlfR01UBW4fTKuKcj33F5GLO1lAH9JwX0lY0AqYzoz+a8ZAtZOu3HniG6xzYUjgEQdDE/JDLRYz2CWijM2nhp4NZ36VQ8dllqxVlEc4ebBzD
 1BL/IaDysl32wHFn6Gd+hecpQGkuplAb7HOQGI3J/SaYzgNCOq4wBh1CaHnLOnUcE875GLJrHfJ6CxazDk98Rtd4qzsfO3nRRS9F2UBzCLXHuLJjV+BOq+hRQtJZEV4BEn8zsjndz/NNGTf5mstsgndcyDsi99AY4oRf1wkQS5Uxdi863PgzCocQSf5juwt3lMzWhIPfJqpjWp9eJphVqf4CT1j/B2o1y1gD389AJnlFbS84ke0ChVo+8k71PTzhZhLJreESkP9N1H9VpCpBatUcVqaixhzVBp6KaM7tjAkFet1201OGwN0JO8mD73hHzHu6lJVIIhnA==
Received: from [192.168.69.100] ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a05600c290500b0040ef95e1c78sm11961096wmd.3.2024.02.13.07.24.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 07:24:35 -0800 (PST)
Message-ID: <994ba2be-1a5b-4a41-9171-3494b8b71b32@linaro.org>
Date: Tue, 13 Feb 2024 16:24:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Mark Burton
 <mburton@qti.qualcomm.com>, mdean@redhat.com, felipe@nutanix.com,
 cw@f00f.org, eblake@redhat.com, iggy@theiggy.com, jidong.xiao@gmail.com,
 peter.maydell@linaro.org, stefanha@gmail.com, Warner Losh <imp@bsdimp.com>,
 zwu.kernel@gmail.com, jgg@nvidia.com, cjia@nvidia.com,
 konrad.wilk@oracle.com, wei.w.wang@intel.com,
 Joao Martins <joao.m.martins@oracle.com>, afaerber@suse.de,
 bbauman@redhat.com, eric.auger@redhat.com, jan.kiszka@web.de,
 jjherne@linux.vnet.ibm.com, mimu@linux.vnet.ibm.com, z.huo@139.com,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, Brian Cain <bcain@quicinc.com>,
 Luc Michel <luc@lmichel.fr>, Bernhard Beschow <shentey@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Alessandro Di Federico
 <ale@rev.ng>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jim Shu <jim.shu@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Damien Hedde <dhedde@kalrayinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: QEMU Community Call 13th Feb [Minutes]
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Attendees:
- Philippe Mathieu-Daudé
- Markus Armbruster
- Anton Johansson
- Manos Pitsidianakis
- Paul Walmsley & SiFive QEMU team

Notes:
- Discussion on introducing a WIRING step in QDEV realization steps
   https://lore.kernel.org/all/20240209123226.32576-1-philmd@linaro.org/
   Bus-based devices already do something similar (IRQ wiring) in their
   BusRealize handler (i.e. PCI). MMIO mapping is usually done explicitly
   in-band, triggered by the guest.

- Make some QDev properties "configurable-only" then "read-only"
   https://lore.kernel.org/all/20211103173002.209906-1-kwolf@redhat.com/

- Steps in dynamic machine / heterogeneous emulation per last week call
   https://wiki.qemu.org/Dynamic_machine_and_heterogeneous_emulation_roadmap

- No objection to adding new binary we can use to prototype
 
https://lore.kernel.org/qemu-devel/20240209152945.25727-1-philmd@linaro.org/
   Suggestion to use QOM interface to prototype API changes and
   avoid to convert the whole tree.
   Watch out to not end with never finished conversions.

- Leverage QOM interfaces when inheritance pattern doesn't work
 
https://lore.kernel.org/all/20240212174925.1504899-1-peter.maydell@linaro.org/
   Why can't we model the reset tree with QDev?
   Maybe be needed for RESET because MachineState isn't QDev.

- SiFive already using QMP to create dynamic machine and using
   heterogeneous emulation using old patches from Xilinx / Edgar
   Iglesias. Team definitively interested. Possibility to help
   in few weeks when team get more comfortable with community.

- We might let the current Tuesday QEMU community call for generic
   topics and add an extra "dynamic machine / heterogeneous emulation"
   quick call every Thursday

Action items:
[ ] Setup a community calendar invite!
[ ] Next meeting next week

