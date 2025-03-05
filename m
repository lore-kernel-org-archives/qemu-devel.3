Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC18C282E5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 18:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tptYl-0007KD-CK; Wed, 05 Mar 2025 13:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tptYi-0007JP-Au
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 13:33:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tptYg-0001Kr-L6
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 13:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741199609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2oklQe515wgmSE411eEKNy/LDka3rD8MHHr+TK591kg=;
 b=AcrCouabisaxcFG1lUIkHQX9vsNIbF+fytNK3CRNo6+mC2cSJ/WoZglBvf9sWXpTpNWJ6H
 mKqR8O/BHOd0MpINrsWGqcBHhzBchkIthjkkntfc3oVE6dwYyHz9H+evKtKROp2Z0gdgRg
 iJU0FZoxV93eZ3eCRMVQHTiXrtsur2o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-B1AujLNdMlqZJCzRko7F-g-1; Wed, 05 Mar 2025 13:33:22 -0500
X-MC-Unique: B1AujLNdMlqZJCzRko7F-g-1
X-Mimecast-MFC-AGG-ID: B1AujLNdMlqZJCzRko7F-g_1741199601
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4393e89e910so38135395e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 10:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741199601; x=1741804401;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2oklQe515wgmSE411eEKNy/LDka3rD8MHHr+TK591kg=;
 b=j/RtXdtynnyeElMRTmX1DCqx1GF6UzPXZTZrlFGMNvt/vXkcXJ26MiI3fdYYpofqn2
 Wj8oMawjk3uGl2Csh7j9oJn6cPKYgb9r6Wtti9mlKkcntpWcs9Z5ZK3fsGarC0EgNBDx
 LQiAGgSR6vNjfHgPUmJTZ324mSm0VQgIjVi+IfZozoEO4mxvmNshRA/Q00nzClhjiTDz
 AgGU8tGSZ7j4RJcApL2Yot7OnL/bSUxQlgqc8hTPZM6CNRASTHgdGiZ2v8KfGR2PXNST
 P9jDy8WYwh8W79SWJMNeJggWTV2+0hZW6iBQEOj489uzK5GWxzxx83YgOvQaBNhXBjo8
 lDUA==
X-Gm-Message-State: AOJu0YxGKVIaMwYZSD8REuc6nDiJ+hLcogCPGglCcqzlOLme2xbCjBit
 EH4+Rbow6DBGM5XIZirZLQT0+AsGZRUYK25R8+LnIz8hZw1xOJPE4hp30SPH+9wX1hN1IIiGV+t
 8GvsCCncrRDrzOyr5hybWpeXRL2GfMA5DOZFVK1tHvRMM6uqjQtaX
X-Gm-Gg: ASbGncuc9czlRMtP5KFDHueAv2VnrOB6C3FlJihyhrqf/V10Kr8X0cq22lSOMPhg4lA
 2mxj0UfDf2aMBHqUm0s5QR+Ju5CNQWg8wd9jEMeg6dcJku+4OEP5m4I9OQdeg6sT6hNohkp2CXB
 /Ro5jmQ11u+lS4FZlaL1XC1vj1VsAka+DVsikpHeQ2oA0mJpCLoRdh0zOJdAZp+aHRRW0tehX39
 VapwKtL0y84f0bElz/zUi7bOYjWp35RryVD2i8xkcDaoK72gDpR3Zwt8QnxdWEUNIoJYWlfoM3b
 FVVdJhZcs5F5fkJbpDjOU/wr7nR6tPeA2+znTldhMQcs/vc=
X-Received: by 2002:a05:600c:4f87:b0:439:89e9:4eff with SMTP id
 5b1f17b1804b1-43bd29c5f71mr38728285e9.10.1741199601496; 
 Wed, 05 Mar 2025 10:33:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGitIQMkEox+XpNmB9Eh6VKfrRym/M8pKmQKJ8J7iyHlW5OuIkjnJa39ijZhG2fEDtjsLvRQ==
X-Received: by 2002:a05:600c:4f87:b0:439:89e9:4eff with SMTP id
 5b1f17b1804b1-43bd29c5f71mr38728015e9.10.1741199601062; 
 Wed, 05 Mar 2025 10:33:21 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-391188029e0sm6103928f8f.52.2025.03.05.10.33.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 10:33:20 -0800 (PST)
Message-ID: <f19d3690-e8af-4ccb-a4da-20a87a48852c@redhat.com>
Date: Wed, 5 Mar 2025 19:33:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v2 3/3] hw/s390x: support migration of CPI values
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <20250224120449.1764114-3-shalini@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250224120449.1764114-3-shalini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/02/2025 13.04, Shalini Chellathurai Saroja wrote:
> Register Control-Program Identification data with the live
> migration infrastructure.
> 
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 13ea8db1b0..4d0838d037 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -260,6 +260,20 @@ static void s390_create_sclpconsole(SCLPDevice *sclp,
>       qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
>   }
>   
> +static const VMStateDescription vmstate_control_program_id = {
> +    .name = "s390_control_program_id",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(system_type, ControlProgramId, 8),
> +        VMSTATE_UINT8_ARRAY(system_name, ControlProgramId, 8),
> +        VMSTATE_UINT64(system_level, ControlProgramId),
> +        VMSTATE_UINT8_ARRAY(sysplex_name, ControlProgramId, 8),
> +        VMSTATE_UINT64(timestamp, ControlProgramId),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static void ccw_init(MachineState *machine)
>   {
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
> @@ -308,6 +322,9 @@ static void ccw_init(MachineState *machine)
>       ret = css_create_css_image(VIRTUAL_CSSID, true);
>       assert(ret == 0);
>   
> +    /* register CPI values */
> +    vmstate_register_any(NULL, &vmstate_control_program_id, &ms->cpi);

  Hi again,

after looking at this for a while, I think it might be cleaner to store the 
state in the TYPE_SCLP_CPI device instead of storing it in the machine 
state. Then you can also use dc->vmsd there instead of using the legacy 
vmstate_register_any() function.

Additionally, I think you need some compat handling for backward migration 
in your patches. E.g. have you tried migrating from an old version of QEMU 
to a newer one (that includes your patches) and then back to the old one?
I think the TYPE_SCLP_CPI device should only be instantiated for the machine 
types >= 10.0, but not for the older machine types, e.g. by introducing a 
"use-cpi" property to the TYPE_SCLP_EVENT_FACILITY (set to true by default). 
Then in ccw_machine_9_2_class_options(), make sure that this property gets 
switched to "off" again, so that older machine types don't have the new 
TYPE_SCLP_CPI device. WDYT?

  Thomas


