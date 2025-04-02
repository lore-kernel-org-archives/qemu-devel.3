Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABFBC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 05:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzr7m-0008R0-Fj; Wed, 02 Apr 2025 01:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tzr7g-0008QO-Ad
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 01:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tzr7d-0003nM-IW
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 01:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743573523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lcGarsH+mglExZUpUBeG7l8uqC3ADCaMsreYLc8otBo=;
 b=bcrdNsR0S7t3WpBERDsEzO2dq/k5embAeeF4mNHgaucM/wHzEOqhqw0/ql4Xi7zLbdMyhm
 p3HuTG3PE+z51OO0CnwPHLpvQ5GVe6hgkPqDwC0KkgBswtDWCPU3K3YfqgMuEAe4bNpmM3
 VkYcw/ny++nlRlJmOdWDstGI81HFIYE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-bl_iJ3plOmuQHrmRQQog7w-1; Wed, 02 Apr 2025 01:58:42 -0400
X-MC-Unique: bl_iJ3plOmuQHrmRQQog7w-1
X-Mimecast-MFC-AGG-ID: bl_iJ3plOmuQHrmRQQog7w_1743573521
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5e68e9d9270so5115714a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 22:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743573521; x=1744178321;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lcGarsH+mglExZUpUBeG7l8uqC3ADCaMsreYLc8otBo=;
 b=JbdtNIile7tu/r1HGNYRMiv0sKsivNd731JhS2UZiyqi3gtkvRdPA1dSMB4syRXGCK
 uVEQJ759cc9o5plU5b6GO1mLTysnyn9ldUXV6IlnE7QAK+avmUemFzFIT68d7AHOca8w
 cayUQp4rdYMaGNiqyxC41z6VHk3yltY/imn/H8v6sLhBH81iA77ueqK9jdz2GljbXvoY
 el0AAdPDDJIHD/zpnalibB3Jnk1etizV4KPdK2a1FwkXJ/x5/LvUlzfHG8woz0g1R6st
 5SVMMPpRMLlv4jH0JLRnfAGMP8zLqnxBIfakXomSs3Z/5Kbm4OTEWz2u4JFPLAO8hUY6
 EbhQ==
X-Gm-Message-State: AOJu0YzM8kgTVwQR6JJ9ApoCBKYq+8ifyuxLmQOze3pwBsOInqfY0exA
 +Pn7cVSLn3dO0LDpZmkVgG8Q/EVYdl3VX/+TBru04NBKv0DzKaK2t7PmWu/CDFg/pzxkccI1Gfc
 Fdk1UISV9mBhXU3SWb3AF31429loY+GhYyjQaMZ7NR3NA8alWluNU
X-Gm-Gg: ASbGncvaZr5Re9eGahjEPDNsC68Z9pdzbtzCIKw1zM0Lmq5x5lqw7vb1sAjd3aoe53e
 o2Q5EAT6nEEe4zM1r5pSQQ5KQ/mCOYYouoVhjibnujbwcvoL/DPJmxiD4LZKlSWopAOpna8mQVN
 z00HXHDUmi6igFF9vgstYOxEONZAMQhN0H4aryW/1nclW/YfKfBHfT4XTpZ9gZpsKQs3Rv4Mu4G
 8RW36QTxksPBSs1RLjaeScrlwVPJMAhaSkcTh8yMvEXmNe6Y0Fihx4Fqf2irRb/2e9JqGomApoS
 GvPO9r+D9NV+DMk7k6xCC6pmFCnLv9Ed8xLfmjuBowdJ
X-Received: by 2002:a17:907:7fa1:b0:ac3:2ad9:f126 with SMTP id
 a640c23a62f3a-ac738bbe70fmr1325387766b.41.1743573521002; 
 Tue, 01 Apr 2025 22:58:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt3q+jY9zCoiodYMjN40Bbe2NBfUaTXxkS7M5TQosj5+Y2Daul6ax36PowtER/jXbvX78TXg==
X-Received: by 2002:a17:907:7fa1:b0:ac3:2ad9:f126 with SMTP id
 a640c23a62f3a-ac738bbe70fmr1325386066b.41.1743573520565; 
 Tue, 01 Apr 2025 22:58:40 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-76.web.vodafone.de. [109.42.51.76])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71967fc5fsm873033866b.141.2025.04.01.22.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 22:58:40 -0700 (PDT)
Message-ID: <5732993a-1555-4e97-900c-e9d3855dafc9@redhat.com>
Date: Wed, 2 Apr 2025 07:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] hw/s390x: add Control-Program Identification to QOM
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Daniel Berrange <berrange@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250331140041.3133621-1-shalini@linux.ibm.com>
 <20250331140041.3133621-3-shalini@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250331140041.3133621-3-shalini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 31/03/2025 16.00, Shalini Chellathurai Saroja wrote:
> Add Control-Program Identification data to the QEMU Object
> Model (QOM), along with the timestamp in which the data was received.
> 
> Example:
> virsh # qemu-monitor-command vm --pretty '{
> "execute": "qom-get",
> "arguments": {
> "path": "/machine/sclp/s390-sclp-event-facility/sclpcpi",
> "property": "control-program-id" }}'
> {
>    "return": {
>      "timestamp": 1742390410685762000,
>      "system-level": 74872343805430528,
>      "sysplex-name": "PLEX ",
>      "system-name": "TESTVM  ",
>      "system-type": "LINUX   "
>    },
>    "id": "libvirt-15"
> }
> 
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> ---
>   hw/s390x/sclpcpi.c                | 38 ++++++++++++++++++++
>   include/hw/s390x/event-facility.h |  9 +++++
>   qapi/machine.json                 | 58 +++++++++++++++++++++++++++++++
>   3 files changed, 105 insertions(+)
> 
> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
> index 7ace5dd64e..969c15e43d 100644
> --- a/hw/s390x/sclpcpi.c
> +++ b/hw/s390x/sclpcpi.c
> @@ -57,8 +57,11 @@
>     */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/timer.h"
>   #include "hw/s390x/sclp.h"
>   #include "hw/s390x/event-facility.h"
> +#include "hw/s390x/ebcdic.h"
> +#include "qapi/qapi-visit-machine.h"
>   
>   typedef struct Data {
>       uint8_t id_format;
> @@ -99,10 +102,37 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
>       ControlProgramIdMsg *cpim = container_of(evt_buf_hdr, ControlProgramIdMsg,
>                                                ebh);
>   
> +    ascii_put(event->cpi.system_type, (char *)cpim->data.system_type, 8);
> +    ascii_put(event->cpi.system_name, (char *)cpim->data.system_name, 8);
> +    ascii_put(event->cpi.sysplex_name, (char *)cpim->data.sysplex_name, 8);
> +    event->cpi.system_level = ldq_be_p(&cpim->data.system_level);
> +    event->cpi.timestamp = qemu_clock_get_ns(QEMU_CLOCK_HOST);
> +
>       cpim->ebh.flags = SCLP_EVENT_BUFFER_ACCEPTED;
>       return SCLP_RC_NORMAL_COMPLETION;
>   }
>   
> +static void get_control_program_id(Object *obj, Visitor *v,
> +                                   const char *name, void *opaque,
> +                                   Error **errp)
> +{
> +    SCLPEvent *event = (SCLPEvent *)(obj);
> +    S390ControlProgramId *cpi;
> +
> +    cpi = &(S390ControlProgramId){
> +        .system_type = g_strndup((char *) event->cpi.system_type,
> +                                 sizeof(event->cpi.system_type)),
> +        .system_name = g_strndup((char *) event->cpi.system_name,
> +                                 sizeof(event->cpi.system_name)),
> +        .system_level = event->cpi.system_level,
> +        .sysplex_name = g_strndup((char *) event->cpi.sysplex_name,
> +                                  sizeof(event->cpi.sysplex_name)),
> +        .timestamp = event->cpi.timestamp
> +    };
> +
> +    visit_type_S390ControlProgramId(v, name, &cpi, errp);
> +}
> +
>   static void cpi_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -114,6 +144,14 @@ static void cpi_class_init(ObjectClass *klass, void *data)
>       k->get_send_mask = send_mask;
>       k->get_receive_mask = receive_mask;
>       k->write_event_data = write_event_data;
> +
> +    object_class_property_add(klass, "control-program-id",
> +                              "S390ControlProgramId",
> +                              get_control_program_id,
> +                              NULL, NULL, NULL);
> +    object_class_property_set_description(klass, "control-program-id",
> +        "Control-program identifiers provide data about the guest "
> +        "operating system");
>   }
>   
>   static const TypeInfo sclp_cpi_info = {
> diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
> index f445d2f9f5..39e589ed44 100644
> --- a/include/hw/s390x/event-facility.h
> +++ b/include/hw/s390x/event-facility.h
> @@ -169,10 +169,19 @@ typedef struct ReadEventData {
>       };
>   } QEMU_PACKED ReadEventData;
>   
> +typedef struct ControlProgramId {
> +    uint8_t system_type[8];
> +    uint8_t system_name[8];
> +    uint64_t system_level;
> +    uint8_t sysplex_name[8];
> +    uint64_t timestamp;
> +} QEMU_PACKED ControlProgramId;

Do we need the QEMU_PACKED here? The members seem naturally aligned, and the 
struct does not seem to be involved in the communication with the guest 
directly, so if you don't need it, please drop the QEMU_PACKED here.
(without PACKED, the compiler can optimize the code in a better way, and 
this causes less trouble on exotic platforms like SPARC that cannot access 
unaligned memory addresses)

>   struct SCLPEvent {
>       DeviceState qdev;
>       bool event_pending;
>       char *name;
> +    ControlProgramId cpi;
>   };
>   
>   struct SCLPEventClass {
> diff --git a/qapi/machine.json b/qapi/machine.json
> index a6b8795b09..cd2bcd2d13 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1898,3 +1898,61 @@
>   { 'command': 'x-query-interrupt-controllers',
>     'returns': 'HumanReadableText',
>     'features': [ 'unstable' ]}
> +
> +##
> +# @S390ControlProgramId:
> +#
> +# Control-program identifiers provide data about the guest operating system.
> +# The control-program identifiers are: system type, system name, system level
> +# and sysplex name.
> +#
> +# In Linux, all the control-program identifiers are user configurable. The
> +# system type, system name, and sysplex name use EBCDIC characters from
> +# this set: capital A-Z, 0-9, $, @, #, and blank.  In Linux, the system type,
> +# system name and sysplex name are arbitrary free-form texts.
> +#
> +# In Linux, the 8-byte hexadecimal system-level has the format
> +# 0x<a><b><cc><dd><eeee><ff><gg><hh>, where:
> +# <a>: is one hexadecimal byte, its most significant bit indicates hypervisor
> +# use
> +# <b>: is one digit that represents Linux distributions as follows
> +# 0: generic Linux
> +# 1: Red Hat Enterprise Linux
> +# 2: SUSE Linux Enterprise Server
> +# 3: Canonical Ubuntu
> +# 4: Fedora
> +# 5: openSUSE Leap
> +# 6: Debian GNU/Linux
> +# 7: Red Hat Enterprise Linux CoreOS
> +# <cc>: are two digits for a distribution-specific encoding of the major version
> +# of the distribution
> +# <dd>: are two digits for a distribution-specific encoding of the minor version
> +# of the distribution
> +# <eeee>: are four digits for the patch level of the distribution
> +# <ff>: are two digits for the major version of the kernel
> +# <gg>: are two digits for the minor version of the kernel
> +# <hh>: are two digits for the stable version of the kernel
> +# (e.g. 74872343805430528, when converted to hex is 0x010a000000060b00). On
> +# machines prior to z16, some of the values are not available to display.

You've got the same information in the comment at the beginning of the 
sclpcpi.c file already ... maybe it would be good to have it in one place 
only to avoid double maintenance in case it needs to be changed in the 
future. I'd suggest to change the comment at the beginning of sclpcpi.c to 
say something like "for a detailed description of the contents of the CPI, 
please see the S390ControlProgramId QOM-type description." or something similar?

  Thomas


