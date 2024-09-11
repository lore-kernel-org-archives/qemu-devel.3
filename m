Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E1FEE4983
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 09:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soJr9-0003Aa-KN; Wed, 11 Sep 2024 05:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1soJr8-00034P-AJ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:41:46 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1soJr6-0006Si-Gx
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 05:41:45 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-201d5af11a4so69571565ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1726047703; x=1726652503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kn5qlxz6rYEqhaF1IlMFBCOQtR9IuIiaMxxsFKOJnss=;
 b=NPL5wx794wcySPZluOoAAU0ajYkxarE3hCK5UlAJ5/j3OphX/X/01L001/Gok4uxUO
 +/z7qoHuxZnZGbSqnchgcF5/RaDjovy1CmPdHZmGPSBGbPPGuR8Tzh703RJz9zaukh6r
 SRzxbo5UyGdG2KZjYiwpfAiDyajnfAb/J436B0+CnGRhMg9cjg6ipbgPx4EDs0OinusJ
 8Dt3vO3LLoZL06GaeNQvfBdfm7A1kh6oC5hYvjVKJVRw5RSq0e+O03UjDfTmsahWSL8s
 bWefY/qts6y8zWfeSQT4rmnxJWq6Xowx1WV78Q1LPdYywhSZPokwDyrJ132gj9M45e+P
 MyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726047703; x=1726652503;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kn5qlxz6rYEqhaF1IlMFBCOQtR9IuIiaMxxsFKOJnss=;
 b=UiD+1CtnpJtOTlo8dEp6uOiHyHujaAlC0QJwVGoBrw8GFwlWTCzvtaIfeBFit6/V2W
 d9caF/+rfiVYkjROtwNL0h8gNE+0gW9zJEwApZCCwtWYq4qgvtOiWjwea27uwBT1X5NS
 n9vBpKIliY28VfPN26LtEeZSSSET/d0l3HGNiQ2nEzdxS4QjRYvgqe+/EUoOjt3pOHZo
 E5N5sVJzEBCmikkfAmr+HEJ63BoQJ1K2n6VegiW26EOPTiWffTNBKNjvKIsMel11K3Oo
 HNptNYaUgbBkWRN0l0UY+K9cYWxKT9b+Aa58YvwpW/1aJTMEwuLvcFEznaGxQbCNxkRH
 OFDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo+6JGlNdBkVlZCloiPGNYYxqX3JqAGBn0CNiiarW+C0dDQOwgVcyqH17bD7sjjvbIt2IGaJmoaL/v@nongnu.org
X-Gm-Message-State: AOJu0Ywl9huIZ/YPwRBRxFQPZJawsxprT4/lCbcT4DNxSuXgBmtUIwiN
 c5HMgqBV7IjSfF7Amg5IIsYfuUCZOWdKZJDcOJTlchR1/doSbGkIYVESu7BLqEo=
X-Google-Smtp-Source: AGHT+IG7rMRmLj/y96aXDOZLOEvKG9GOrb7S5g+4beGqyo1xcxzviLsaVZV/GqWsQoagVaROIUgcuw==
X-Received: by 2002:a17:902:f790:b0:202:19a0:fcba with SMTP id
 d9443c01a7336-2074c6a4573mr64727285ad.41.1726047703192; 
 Wed, 11 Sep 2024 02:41:43 -0700 (PDT)
Received: from [192.168.68.110] (201-68-240-198.dsl.telesp.net.br.
 [201.68.240.198]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e321fdsm60213095ad.83.2024.09.11.02.41.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 02:41:42 -0700 (PDT)
Message-ID: <c9167c3f-9cb4-458b-ab1e-ee5c1103f76b@ventanamicro.com>
Date: Wed, 11 Sep 2024 06:41:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/39] hw/ppc: replace assert(false) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>, 
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
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
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240910221606.1817478-21-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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



On 9/10/24 7:15 PM, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/ppc/spapr_events.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> index cb0eeee5874..38ac1cb7866 100644
> --- a/hw/ppc/spapr_events.c
> +++ b/hw/ppc/spapr_events.c
> @@ -645,7 +645,7 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
>           /* we shouldn't be signaling hotplug events for resources
>            * that don't support them
>            */
> -        g_assert(false);
> +        g_assert_not_reached();
>           return;
>       }
>   

