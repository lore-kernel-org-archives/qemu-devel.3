Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A518DC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcP1r-00051I-4z; Tue, 20 Feb 2024 07:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcP1m-00050M-GS
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:15:15 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcP1h-0003XF-RC
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:15:14 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33d066f8239so2510103f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708431308; x=1709036108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qWIF/CSB2Arm8l+bVbLMRzNUXCEBW2+rjxT18EmLzWc=;
 b=pF8fUifCgp63KkpBhf9GZ/QIaa0T6BD1io59uXWwcB1jwGlPAkXt8W8py6buFtFydB
 5Mq2hwUSF4yY6g1XsoH1LINfCeV9iS/wD6TzCwBnMOw1L9Umfjvs32o4C3GyeEROR1xi
 ZF5wlBR8xZi3Km5DxQFFmv7eYDhOf0HAgHKwwkLJOZ1dKxByahDJVnsyCi7Su/gvxJKy
 0ZGEFm03keMsskCuSZvHiYbYlsnZqUcz57/yhUtba/L1BbDAU0zAzdVaZT26Un+WOIfn
 9zVgclLVgpGX/eZaYw9nKwhPUE/UpxgKgO5eJMwqXyIeEoB2VeU0xpe8J23t21i6PX+9
 K6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431308; x=1709036108;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qWIF/CSB2Arm8l+bVbLMRzNUXCEBW2+rjxT18EmLzWc=;
 b=KajVes4P7VWCVcaJapo2uIJfDCE6CQd78tGqdJZX7ai8CU7k2LhTtZNDZ7MP9AjvsX
 d+0FyVPwMJsac4vo8h1R7ma75HJH0ggqFkrXYgm7MDBwHhOJKzzFZBgnhaMKvffbg4l2
 1RHpbUtIaAh2wMD0liMsEjpEcgRVVuYdoQfuTqG12ascRG7HJO6YScstBpjCQWEexuQ3
 liqdSKr/I6cQ6/wA8A+kAY6OsPm/u5JhDw7GRbyxjThE1iBVjSipCI3H/KrW9mxuVtdb
 /r/RnHH0uOF/1fGkDHQf/HkzM1GCXU6PJnkn8/9LJxT5ZJL5a9+iUCvW9xS9YIltGiQ0
 4cEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvezrER+7UlUkIcWcwZGEDkgxrfh/8g+kLHMxQve6ZpHNnSxjW8Va0O6oSbgrPdbJjv3lJizsA/JI2QOMJ9VWhYDN5AIc=
X-Gm-Message-State: AOJu0YwatNjZkt1Gw2uLpZM7MFCJwT3J7kDwtC0GsgHish34eRPWILfP
 eSkx971D/R2GOx7LP3KbpVUudvPU+BmzAdGCKVmKT7W8FqScYXTcTcZXaiZMuEc=
X-Google-Smtp-Source: AGHT+IGKeOPD+uElxrLApnUYet3aa5N9CagTrFnJUK3Tjy1Fxg7jjMVhk4Hm832bRkrvGekHBL0W5A==
X-Received: by 2002:adf:f352:0:b0:33d:1145:8787 with SMTP id
 e18-20020adff352000000b0033d11458787mr9179373wrp.25.1708431308016; 
 Tue, 20 Feb 2024 04:15:08 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 a7-20020adfeec7000000b0033b483d1abcsm13193952wrp.53.2024.02.20.04.15.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:15:07 -0800 (PST)
Message-ID: <719c1acc-2f00-4b34-b999-3da312b97fee@linaro.org>
Date: Tue, 20 Feb 2024 13:15:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU Community Call 20th Feb Agenda Items
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <87ttm3cpmd.fsf@draig.linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 Mark Burton <mburton@qti.qualcomm.com>, mdean@redhat.com,
 felipe@nutanix.com, cw@f00f.org, eblake@redhat.com, iggy@theiggy.com,
 jidong.xiao@gmail.com, peter.maydell@linaro.org, stefanha@gmail.com,
 Warner Losh <imp@bsdimp.com>, zwu.kernel@gmail.com, jgg@nvidia.com,
 cjia@nvidia.com, konrad.wilk@oracle.com, wei.w.wang@intel.com,
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
In-Reply-To: <87ttm3cpmd.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Cc'ing previous recipients.

On 20/2/24 13:00, Alex Bennée wrote:
> 
> The KVM/QEMU community call is at:
> 
>    https://meet.jit.si/kvmcallmeeting
>    @
>    20/2/2024 14:00 UTC
> 
> Are there any agenda items for the sync-up?
> 
> I maintain the invite on our Linaro project calendar here:
> 
>    https://calendar.google.com/calendar/event?action=TEMPLATE&tmeid=MWd2dWI5NDM1bzdocnJlbTBhMHJhbG5sNWlfMjAyNDAyMjBUMTQwMDAwWiBjX2s1cDJscGd2YnB0ZGlya3U1c2kwMWJsbW5rQGc&tmsrc=c_k5p2lpgvbptdirku5si01blmnk%40group.calendar.google.com&scp=ALL
> 
> If you want to be added to the invite list let me know and you can get
> spammed by your calendar app as well ;-)
> 


