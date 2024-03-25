Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E963BC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rolvQ-000632-2Y; Mon, 25 Mar 2024 11:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rolvO-00062o-Ns
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rolvM-0005jK-Co
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711379263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vziyHw6uP4sIz5qJuOs8a63o+uuRY7vtwlSq66O7yjg=;
 b=APktHERZAPoN2FbOH1orjUCkOkgKpijKJ3qkXWb6DyN4VOcu4tX4oZ2+4bdfP8o6ZkFurB
 fB/yNGbuo6qDo2wMBAd4t4okw0fXQYx0Swog7ZV04csnCSYXlfo5kITmbTpLIqz/6OpGmy
 wYrmG5bSQT733YDdSH1JAnES6evTFv0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-yqlPR4H6O46eSJi_eQ1Q4Q-1; Mon, 25 Mar 2024 11:07:42 -0400
X-MC-Unique: yqlPR4H6O46eSJi_eQ1Q4Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4140225e68aso25532535e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 08:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711379261; x=1711984061;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vziyHw6uP4sIz5qJuOs8a63o+uuRY7vtwlSq66O7yjg=;
 b=hobHqNS8M1f1jO24dM26L2tHJBZ7Q+ukm3+VfoJFehAV02+3nFGAhcwTId3tAPprYq
 TprRGCdpuxDbgcFCp+TkFt5EjzCnECAm+vjMYN7LXLfm8GEmN8UrhPDMVjpe9C7KCYm2
 OFcRQGGO0olwFo30WOcjh7buT01B6Z3v69IZOeXZwHQTlMFd5w1S5AMV8Kw3J2FQAkph
 /b2yfij7zIS7OWridCI0wuZop/UCTGRJXaEhMWmkqhlpVggFkRD1avyVzaQY11680T39
 q+AJqEdUYLgHTWWr+nq8MWWAwAM0iPOJhkh357yvM4ukN6Al/264dPKMt0ukv3Ow/ddO
 QbcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWytJcNesMf9Nk7HThxJp77qvCVSCksRwNd5cFg7bDZVip7xHbpSST25JIenpRC37W44QqnyXsQWPNKB4TbbecwBW9lEA=
X-Gm-Message-State: AOJu0Yx/0E5bFtb6nnN+md2WpGQBbIs/V64OQHg34x0DlRtwq5uZXIIJ
 i6V2zpjQ1G+k++XqHeklqD1erOkW5BBTPtxChK8fQvkY6FEnneBsYPsGU1HUvKa7tWbr44uBy8h
 26VuWV6PudC192zTpHUT9msDN0MTpyl033jJ86H6NUzhHyxi0dRXL
X-Received: by 2002:a05:600c:1547:b0:413:ff10:cee with SMTP id
 f7-20020a05600c154700b00413ff100ceemr5304570wmg.13.1711379260926; 
 Mon, 25 Mar 2024 08:07:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfcN7VfVjeGJA9m4GweBwN2xknwjO5rhC8/zMdsVizGTzihSOnK6WOYyrXAtT47IAEThEqqA==
X-Received: by 2002:a05:600c:1547:b0:413:ff10:cee with SMTP id
 f7-20020a05600c154700b00413ff100ceemr5304554wmg.13.1711379260623; 
 Mon, 25 Mar 2024 08:07:40 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-176-158.web.vodafone.de.
 [109.43.176.158]) by smtp.gmail.com with ESMTPSA id
 x4-20020a5d60c4000000b00341ce1b64f0sm2496782wrt.17.2024.03.25.08.07.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 08:07:40 -0700 (PDT)
Message-ID: <aa14d73f-7374-4df8-a31a-8909801ef2f8@redhat.com>
Date: Mon, 25 Mar 2024 16:07:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v5 1/3] hw: Add compat machines for 9.1
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Cornelia Huck <cohuck@redhat.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Gavin Shan <gshan@redhat.com>
References: <20240325141422.1380087-1-pbonzini@redhat.com>
 <20240325141422.1380087-2-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240325141422.1380087-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/03/2024 15.14, Paolo Bonzini wrote:
> Add 9.1 machine types for arm/i440fx/m68k/q35/s390x/spapr.
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/boards.h        |  3 +++
>   include/hw/i386/pc.h       |  3 +++
>   hw/arm/virt.c              | 11 +++++++++--
>   hw/core/machine.c          |  3 +++
>   hw/i386/pc.c               |  3 +++
>   hw/i386/pc_piix.c          | 17 ++++++++++++++---
>   hw/i386/pc_q35.c           | 14 ++++++++++++--
>   hw/m68k/virt.c             | 11 +++++++++--
>   hw/ppc/spapr.c             | 17 ++++++++++++++---
>   hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>   10 files changed, 83 insertions(+), 13 deletions(-)
....
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index b1dcb3857f0..67e8b0b05e8 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -859,14 +859,26 @@ bool css_migration_enabled(void)
>       }                                                                         \
>       type_init(ccw_machine_register_##suffix)
>   
> +static void ccw_machine_9_1_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void ccw_machine_9_1_class_options(MachineClass *mc)
> +{
> +}
> +DEFINE_CCW_MACHINE(9_0, "9.1", true);
> +
>   static void ccw_machine_9_0_instance_options(MachineState *machine)
>   {
> +    ccw_machine_9_1_instance_options(machine);
>   }
>   
>   static void ccw_machine_9_0_class_options(MachineClass *mc)
>   {
> +    ccw_machine_9_1_class_options(machine);
> +    compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
>   }
> -DEFINE_CCW_MACHINE(9_0, "9.0", true);
> +DEFINE_CCW_MACHINE(9_0, "9.0", false);
>   
>   static void ccw_machine_8_2_instance_options(MachineState *machine)
>   {

For s390x:
Acked-by: Thomas Huth <thuth@redhat.com>


