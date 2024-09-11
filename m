Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE04EE57C0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soPCF-0000RF-MF; Wed, 11 Sep 2024 11:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soPBv-0007iC-Rx
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:23:39 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soPBs-0002Pj-FS
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:23:35 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7cd8803fe0aso4906253a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 08:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726068211; x=1726673011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OuvMeDUVp0mbaD2Ccta77meu7WyU6zTm7qPRf/MNjOo=;
 b=jT3yPNP8ZJX8SjAHuqKLQp6r8HSxurfxnAVWGZ5v7TiofYiMi6fpSKr7rLFqaEyAX4
 y8WhfeolMVDPsFW1PYJ2J/qSd1FctyMprDnTlpKh61hh9XS2MErclk5+97oEzsf+XTTM
 rZ0A6QhD0yX6jYbWLdsR13rs8RfAQu54GUwBlTI6DnSwSyZnfCnAb1t5yOwY8kiDfXR2
 DJZ+q334ipbLvg7uf4gjTM/dDJwiFNoVwSda+tVIvhLkFgoNv51frZTu18VkYbtq4YZN
 veh4KOOWNxjmTfQVgA6qftMmwBjFse03R3MxRV+OR06gUM/2/NM/SwwTxAOY8vM/G9Rz
 /jhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726068211; x=1726673011;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OuvMeDUVp0mbaD2Ccta77meu7WyU6zTm7qPRf/MNjOo=;
 b=f8DICSjxTieAV0b51cguqyR599HQH4DzKct4et1tuF0QDlWH0L7VokkVV4Z7I+jZZN
 Cs0fPXLV8rHz6GUgywztAIsEmllShy3u26iIj7m9SIY1GM5vqwdQkGdzPQAohdFuOvMT
 DibR9mteiuU4odWGuQNJldekYfjIKHL5xOJm1SwMEeBt5GAtnTzeKEBpPdL21N0BXi3k
 ax99TOubMfW0OqkKsUUJkpv0rfia4zlWyN778MRwsambisJC/xng5oI8yrnyRp5pz8mC
 w5k7jlDEM/yjh1jFLmb/BkKedTp1el3i94BknnBhUtKm5D8V7X+eJQljXZQ+iZxu0b34
 D4vg==
X-Gm-Message-State: AOJu0Yy//O5/oQ+i6T3vdhUjU3emViLh8N+moDbhvWSKOAepYZl7G0yq
 ekSKpcxwygs981QdlByca5jxMU1Zr1itpvZO0OIActHOt03hGqcsYF7U0LCOrg0=
X-Google-Smtp-Source: AGHT+IFVEaQbbNIN6u4ycMxcdISjFC11x2LnDF31jXta/zBjlVjuD+C9lapW5FnwVoc/RuMXV2R+aQ==
X-Received: by 2002:a05:6a20:d809:b0:1c6:fb07:381e with SMTP id
 adf61e73a8af0-1cf5e1aba0fmr5779831637.44.1726068210675; 
 Wed, 11 Sep 2024 08:23:30 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3102009b3a.80.2024.09.11.08.23.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 08:23:30 -0700 (PDT)
Message-ID: <510bda9d-031a-4235-aee3-119c5f8865ea@linaro.org>
Date: Wed, 11 Sep 2024 08:23:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/39] docs/spin: replace assert(0) with
 g_assert_not_reached()
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 "Richard W.M. Jones" <rjones@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Corey Minyard <minyard@acm.org>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Keith Busch <kbusch@kernel.org>, WANG Xuerui <git@xen0n.name>,
 Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng
 <fam@euphon.net>, qemu-s390x@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <lvivier@redhat.com>, Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-2-pierrick.bouvier@linaro.org>
 <zkyoryho5alnyirnl7ulvh5y6tkty6koccgeygmve42uml7glu@37rkdodtlx4f>
 <bwo43ms2wi6vbeqhlc7qjwmw5jyt2btxvpph3lqn7tfol4srjf@77yusngzs6wh>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <bwo43ms2wi6vbeqhlc7qjwmw5jyt2btxvpph3lqn7tfol4srjf@77yusngzs6wh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/11/24 05:37, Eric Blake wrote:
> On Wed, Sep 11, 2024 at 07:33:59AM GMT, Eric Blake wrote:
>> On Tue, Sep 10, 2024 at 03:15:28PM GMT, Pierrick Bouvier wrote:
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>
>> A general suggestion for the entire series: please use a commit
>> message that explains why this is a good idea.  Even something as
>> boiler-plate as "refer to commit XXX for rationale" that can be
>> copy-pasted into all the other commits is better than nothing,
>> although a self-contained message is best.  Maybe:
>>
>> This patch is part of a series that moves towards a consistent use of
>> g_assert_not_reached() rather than an ad hoc mix of different
>> assertion mechanisms.
> 
> Or summarize your cover letter:
> 
> Use of assert(false) can trip spurious control flow warnings from some
> versions of gcc:
> https://lore.kernel.org/qemu-devel/54bb02a6-1b12-460a-97f6-3f478ef766c6@linaro.org/
> Solve that by unifying the code base on g_assert_not_reached()
> instead.
> 

I'll add this to messages. Thanks.

