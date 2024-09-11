Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77B2EE0213
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soPKN-0004r6-SZ; Wed, 11 Sep 2024 11:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soPKL-0004kB-RF
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:32:17 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soPKK-0003aT-30
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:32:17 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-718e11e4186so2019361b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726068734; x=1726673534; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y9xV2TZChxQ5XF8GRBSAuhQm9XxO95EtIVwV6Hqv3wQ=;
 b=W0UVsH/UvONyUUzfvy4X/+cl4tm5/CwkFt+iXVQxEd71OcKSKWX2LYGont52E0Xua0
 I0uafh6VMpTsb2u7CRegIekB4bMs6tCtkE4V4rvxMirqlGwpOJ1PkHJjBnOF0IXMlbe5
 10j6K8FLkqXrbC9HBM5hjxBw1ydpnaJ9DQRy8HpK7awwR5E1ovrJAixIx/wf0YGYmqlo
 k/fH1r/oJHv2MKiKqZhSV3SJteJEqnb0eY9YyyQ2Q+WtTsRgRkhnFjSy6woZ6aKed9Ju
 EnwHv7iQuVEwnSM/30ZeYnREuKvcmDg1KiZT1aCkDEZVI1i0KLOFuz1HFDoNfDnVU1WD
 Ok5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726068734; x=1726673534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9xV2TZChxQ5XF8GRBSAuhQm9XxO95EtIVwV6Hqv3wQ=;
 b=JrKSufi+0Ew7QmU4/LvoDiWPQYeddnMz2qroPUMxCqp7jUjHdijsM4u+Io1VmDpGVa
 9mvH3Fw5Ysa6P2z2k+LYOW4DLspn40d+fYl6rUy6aXSIWmG1jS6uds50EYZNCAadmyI6
 8Y7LMEE9gf2XYASSgxPa2SJOmT5oO8E0N8S/N0QxLJmab47Agu0ZGvK5/+aSUGWAFYSG
 6WGyFzQrG8TdFdIsx2OH+lkpJXpDyEzLqnlTALlqdKD5z2oTVb6E7y3RKW3SRZ65bdlB
 KJ0/VLqMftboXqq6E7OTlvZ766BkqsuygTNPIJt2r+X66iSGiV3xhe2Lgt1ZY49LOPfV
 eA1w==
X-Gm-Message-State: AOJu0YyjRwBjfAPxgrrMgxudrr+ebpULMo6Sz+5/W5rBR9MjwzCxvPj3
 lZ83LYL7yUQc7IrRcXMx3o12ADogxMNs5EsMMD2p1kJBfi6mxqVriYITYpXfYmQ=
X-Google-Smtp-Source: AGHT+IHsW5uOP/RaOllDCB0TLXsQjlnlosQgvXVaTG84PqVow4h1ijgneVn5RfrzY4pP4UlM86UxFQ==
X-Received: by 2002:a05:6a21:2d84:b0:1cf:2ad4:3083 with SMTP id
 adf61e73a8af0-1cf62ce253cmr6250911637.23.1726068734436; 
 Wed, 11 Sep 2024 08:32:14 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8205sm3131563b3a.21.2024.09.11.08.32.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 08:32:13 -0700 (PDT)
Message-ID: <45c6a39b-9c16-4580-ad6b-99973b5e6b0f@linaro.org>
Date: Wed, 11 Sep 2024 08:32:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/39] hw/ppc: replace assert(false) with
 g_assert_not_reached()
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
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
 <20240910221606.1817478-21-pierrick.bouvier@linaro.org>
 <232858c7-6270-f763-adfc-b6c8259bf021@eik.bme.hu>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <232858c7-6270-f763-adfc-b6c8259bf021@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 9/11/24 07:10, BALATON Zoltan wrote:
> 
> 
> On Tue, 10 Sep 2024, Pierrick Bouvier wrote:
> 
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>> hw/ppc/spapr_events.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index cb0eeee5874..38ac1cb7866 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -645,7 +645,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
>>          /* we shouldn't be signaling hotplug events for resources
>>           * that don't support them
>>           */
>> -        g_assert(false);
>> +        g_assert_not_reached();
>>          return;
>>      }
> 
> If break does not make sense after g_assert_not_reached() and removed then
> return is the same here.
> 
> It may make the series shorter and easier to check that none of these are
> missed if this is done in the same patch where the assert is changed
> instead of separate patches. It's unlikely that the assert change and
> removal of the following break or return would need to be reverted
> separately so it's a simple enough change to put in one patch in my
> opinion but I don't mink if it's kept separate either.
> 
> Regards,
> BALATON Zoltan

Mostly done this way because it's easy for creating many commits.

