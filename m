Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35745C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 20:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv1PO-0008En-7K; Thu, 11 Apr 2024 16:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rv1PL-0008EU-Uv
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 16:52:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rv1PJ-0005Oj-OS
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 16:52:31 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-417f81ef467so991085e9.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 13:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712868747; x=1713473547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7O8j3IQZJ7GoRXTbOdB+iZPgEPiO85NDldNfvtBqSb8=;
 b=h9XjfdSmJGX08KPmZ56cIrSRw2eq1/g+vsAY9VzDDLs7IQPUCY6gBgPrSwNmUGNBlf
 NDBuT7ix9vzde2IFhgiF7VlT3UZAVUfPCdmx1rl4Trc3FrvDBtyqFDDpSsEMC2V9ACwe
 QBroU27/WaOZoBAJVp0yULktWeaLJChUHyp3OSS3CDFIrraEnoEAiSL417mVBYe3MXJc
 bUDo00OZZz78PTt+PzhB5Q8OVIu9+zeEV2gGqdW9Bn7yvIIA073tsL64Yd3FBKafcV0P
 lzvdWQBZ0RmnafS2RGEFJNHpr2hUIgL+GtBC+5VJJaomp9C8OhpSkbDTQkIhn4PSJsA8
 HVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712868747; x=1713473547;
 h=content-transfer-encoding:in-reply-to:cc:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7O8j3IQZJ7GoRXTbOdB+iZPgEPiO85NDldNfvtBqSb8=;
 b=NvOX8HQcyHryIIIbpEsmkfZDEf9CgNHHWxyVHfMye0p/25sdc5JcOpVET0TcpXxtge
 3CpBJbg8j3K7JS93PiMO2vRMZ12qU8Ab2hdmzv2OJULuOVLogf3RN+BODDqjfHMl4eiG
 vCIvF7XEG62Nieood1G067/CmS2+5IV1rG2b++l9tCdL9B55Cz+IvpUw9ERl/lYa510E
 SMNNLJzohChopLX63a9FTyfUCKA9sHxHYs1tEVz1O+2yI+Aa+yA/vnORtgWokmB889KO
 xSXA3DVZbhEp1cJbZTFdycxcv9+M9PH+l4JlOBbuVHbozcifALd6Lt59YJpcG/QElyF/
 zqGw==
X-Gm-Message-State: AOJu0YzLnndaU2Kp3pnw0Tlvuz32luf99AKJnUA+l0r4qIU3MpBMvrnV
 bJffPOTw4rIPccebZQkk3KT09deBzGeDkB0oKm8TvhHRpMCt8VFXZwmVeOfNx2AIsu9tmODdiYL
 doOc=
X-Google-Smtp-Source: AGHT+IHU7YoTRAJ8xe0pCeewlYL/WfGGUnOpMBSPyvM977aZ0d2epK1q3TRQi5JXZPOVch6CTkN5LA==
X-Received: by 2002:a05:600c:3511:b0:416:2629:bbaf with SMTP id
 h17-20020a05600c351100b004162629bbafmr738067wmq.29.1712868747309; 
 Thu, 11 Apr 2024 13:52:27 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 fm6-20020a05600c0c0600b004156afd6843sm6625049wmb.18.2024.04.11.13.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 13:52:26 -0700 (PDT)
Message-ID: <2da86ddc-f74f-4a3f-944d-f152b3e42f9d@linaro.org>
Date: Thu, 11 Apr 2024 22:52:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: QEMU Community Call Agenda Items (April 16th, 2024)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: QEMU Developers <qemu-devel@nongnu.org>
References: <23a27641-4e51-41d7-867f-89e3f305d2b9@linaro.org>
Content-Language: en-US
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, afaerber@suse.de,
 ale@rev.ng, alistair.francis@wdc.com, Anton Johansson <anjo@rev.ng>,
 armbru@redhat.com, bbauman@redhat.com, bcain@quicinc.com,
 berrange@redhat.com, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, clg@kaod.org, cw@f00f.org,
 Damien Hedde <dhedde@kalrayinc.com>, eblake@redhat.com,
 edgar.iglesias@gmail.com, eduardo@habkost.net,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, eric.auger@redhat.com,
 felipe@nutanix.com, iggy@theiggy.com, imp@bsdimp.com, jan.kiszka@web.de,
 jgg@nvidia.com, jidong.xiao@gmail.com, jim.shu@sifive.com,
 jjherne@linux.vnet.ibm.com, Joao Martins <joao.m.martins@oracle.com>,
 konrad.wilk@oracle.com, Luc Michel <luc@lmichel.fr>,
 mburton@qti.qualcomm.com, mdean@redhat.com, mimu@linux.vnet.ibm.com,
 paul.walmsley@sifive.com, pbonzini@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 shentey@gmail.com, stefanha@gmail.com, wei.w.wang@intel.com, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com,
 eblot@rivosinc.com, max.chou@sifive.com
In-Reply-To: <23a27641-4e51-41d7-867f-89e3f305d2b9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi,

The KVM/QEMU community call is at:

   https://meet.jit.si/kvmcallmeeting
   @
   16/4/2024 14:00 UTC

Are there any agenda items for the sync-up?


Alex maintains the invite on our Linaro project calendar here:

https://calendar.google.com/calendar/event?action=TEMPLATE&tmeid=MWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfMjAyNDAyMjBUMTQwMDAwWiBjX2s1cDJscGd2YnB0ZGlya3U1c2kwMWJsbW5rQGc&tmsrc=c_k5p2lpgvbptdirku5si01blmnk%40group.calendar.google.com&scp=ALL

If you want to be added to the invite list let him know and you can get
spammed by your calendar app as well 😉

Regards,

Phil.

