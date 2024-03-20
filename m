Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C45EC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 09:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmsiX-0004qg-KU; Wed, 20 Mar 2024 05:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmsiW-0004qY-Fm
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmsiU-0002rD-RJ
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 05:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710928716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=olzv6suonsfJIJXUtUo+TXh4fMZEnDFK6l1vA9ZtLSg=;
 b=IRmt/SB5ex8BjJmflnBr3meruTpI/EG8ZD3nawX4c9odxrfWQCsZx1zjoww7zxyLBttSPE
 5Ht57sukH1bzOPxx7+z3niQi1VznLsgvIY1V8keJrr6kapGVUgHfgvriMBhInsHHTGXdjJ
 mXMBxapDzg6XCZ4IXKf2fAR1YdDTPEs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-NqdeoGRXP-Cf3dzsTJ_HLw-1; Wed, 20 Mar 2024 05:58:33 -0400
X-MC-Unique: NqdeoGRXP-Cf3dzsTJ_HLw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a45acc7f07cso355179366b.2
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 02:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710928712; x=1711533512;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=olzv6suonsfJIJXUtUo+TXh4fMZEnDFK6l1vA9ZtLSg=;
 b=dMISugNlOoMdAv/2O2ylPCo1yuYThnWg0S7MlQavgzmug6gw6umt2OLYjxpL624MTF
 zi6qsYOw6Sq2fXvfI19Ctqcml1EJT1CGWGVau0VZWtdetYb7jipkIOPlhAX0yBiIXgAh
 2lh/VnpRASQNXCkU33WVRs7JRoQr0FqjoB074Xqm4TnhjaqFFtlcGT5aDvRbP8nMq935
 kzsUjTbvhFtD1qMuRIJo/wNu93YytRO/uyXB4ZrJipf2lbeNuSrA7+Sg6dJEdOFIhY+X
 zHeO+enSlXpczTCEJ06Y6Ittw/SCE3tZX61POEpd5kyy+EPGC9MuZ/4jgmkBBfgGQcL8
 zJ2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4J51AOZzhtsiRmjGNEoChNrzrOLjCGwApRqe+82LApfey+OQuJWfT63QhIlDJp2oHZWsEvGTv7OFeGumTbgP3NSBDsrU=
X-Gm-Message-State: AOJu0YzLPI1svKJSWM7jg/I9VrhfpkKGTJxj2sARPwefvAb2WzrhW9Bn
 lUET2D9fXMbWuEk7M4ILvnVvnCzyqzXAg+6cXJ0NdJWdwQaIdg35ULTtZ3FwsgO6ghHVIfBGSlc
 SOeR7zh0yTLFU490uPdmzbuNskuyEGZ8lcitgntCoU21c8N/ec3ZO
X-Received: by 2002:a17:907:2d21:b0:a43:bf25:989 with SMTP id
 gs33-20020a1709072d2100b00a43bf250989mr16319686ejc.9.1710928712292; 
 Wed, 20 Mar 2024 02:58:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTU/30fz8Oef1veksYmdHpfQ94fe1ioJBB+0DYY6hl0EdRS1Wuv3rb5HRubkg5yWc8V8V/Rw==
X-Received: by 2002:a17:907:2d21:b0:a43:bf25:989 with SMTP id
 gs33-20020a1709072d2100b00a43bf250989mr16319671ejc.9.1710928711925; 
 Wed, 20 Mar 2024 02:58:31 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.googlemail.com with ESMTPSA id
 gq5-20020a170906e24500b00a46be5c78f4sm3425428ejb.142.2024.03.20.02.58.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 02:58:31 -0700 (PDT)
Message-ID: <366370f2-3d2d-4d14-81db-11fddadc2f24@redhat.com>
Date: Wed, 20 Mar 2024 10:58:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 37/49] i386/sev: Add the SNP launch start context
Content-Language: en-US
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>,
 Brijesh Singh <brijesh.singh@amd.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-38-michael.roth@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240320083945.991426-38-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/20/24 09:39, Michael Roth wrote:
> From: Brijesh Singh <brijesh.singh@amd.com>
> 
> The SNP_LAUNCH_START is called first to create a cryptographic launch
> context within the firmware.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   target/i386/sev.c        | 42 +++++++++++++++++++++++++++++++++++++++-
>   target/i386/trace-events |  1 +
>   2 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 3b4dbc63b1..9f63a41f08 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -39,6 +39,7 @@
>   #include "confidential-guest.h"
>   #include "hw/i386/pc.h"
>   #include "exec/address-spaces.h"
> +#include "qemu/queue.h"
>   
>   OBJECT_DECLARE_SIMPLE_TYPE(SevCommonState, SEV_COMMON)
>   OBJECT_DECLARE_SIMPLE_TYPE(SevGuestState, SEV_GUEST)
> @@ -106,6 +107,16 @@ struct SevSnpGuestState {
>   #define DEFAULT_SEV_DEVICE      "/dev/sev"
>   #define DEFAULT_SEV_SNP_POLICY  0x30000
>   
> +typedef struct SevLaunchUpdateData {
> +    QTAILQ_ENTRY(SevLaunchUpdateData) next;
> +    hwaddr gpa;
> +    void *hva;
> +    uint64_t len;
> +    int type;
> +} SevLaunchUpdateData;
> +
> +static QTAILQ_HEAD(, SevLaunchUpdateData) launch_update;
> +
>   #define SEV_INFO_BLOCK_GUID     "00f771de-1a7e-4fcb-890e-68c77e2fb44e"
>   typedef struct __attribute__((__packed__)) SevInfoBlock {
>       /* SEV-ES Reset Vector Address */
> @@ -668,6 +679,30 @@ sev_read_file_base64(const char *filename, guchar **data, gsize *len)
>       return 0;
>   }
>   
> +static int
> +sev_snp_launch_start(SevSnpGuestState *sev_snp_guest)
> +{
> +    int fw_error, rc;
> +    SevCommonState *sev_common = SEV_COMMON(sev_snp_guest);
> +    struct kvm_sev_snp_launch_start *start = &sev_snp_guest->kvm_start_conf;
> +
> +    trace_kvm_sev_snp_launch_start(start->policy, sev_snp_guest->guest_visible_workarounds);
> +
> +    rc = sev_ioctl(sev_common->sev_fd, KVM_SEV_SNP_LAUNCH_START,
> +                   start, &fw_error);
> +    if (rc < 0) {
> +        error_report("%s: SNP_LAUNCH_START ret=%d fw_error=%d '%s'",
> +                __func__, rc, fw_error, fw_error_to_str(fw_error));
> +        return 1;
> +    }
> +
> +    QTAILQ_INIT(&launch_update);
> +
> +    sev_set_guest_state(sev_common, SEV_STATE_LAUNCH_UPDATE);
> +
> +    return 0;
> +}
> +
>   static int
>   sev_launch_start(SevGuestState *sev_guest)
>   {
> @@ -1007,7 +1042,12 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>           goto err;
>       }
>   
> -    ret = sev_launch_start(SEV_GUEST(sev_common));
> +    if (sev_snp_enabled()) {
> +        ret = sev_snp_launch_start(SEV_SNP_GUEST(sev_common));
> +    } else {
> +        ret = sev_launch_start(SEV_GUEST(sev_common));
> +    }

Instead of an "if", this should be a method in sev-common.  Likewise for 
launch_finish in the next patch.

Also, patch 47 should introduce an "int (*launch_update_data)(hwaddr 
gpa, uint8_t *ptr, uint64_t len)" method whose implementation is either 
the existing sev_launch_update_data() for sev-guest, or a wrapper around 
snp_launch_update_data() (to add KVM_SEV_SNP_PAGE_TYPE_NORMAL) for 
sev-snp-guest.

In general, the only uses of sev_snp_enabled() should be in 
sev_add_kernel_loader_hashes() and kvm_handle_vmgexit_ext_req().  I 
would not be that strict for the QMP and HMP functions, but if you want 
to make those methods of sev-common I wouldn't complain.

Paolo

>       if (ret) {
>           error_setg(errp, "%s: failed to create encryption context", __func__);
>           goto err;
> diff --git a/target/i386/trace-events b/target/i386/trace-events
> index 2cd8726eeb..cb26d8a925 100644
> --- a/target/i386/trace-events
> +++ b/target/i386/trace-events
> @@ -11,3 +11,4 @@ kvm_sev_launch_measurement(const char *value) "data %s"
>   kvm_sev_launch_finish(void) ""
>   kvm_sev_launch_secret(uint64_t hpa, uint64_t hva, uint64_t secret, int len) "hpa 0x%" PRIx64 " hva 0x%" PRIx64 " data 0x%" PRIx64 " len %d"
>   kvm_sev_attestation_report(const char *mnonce, const char *data) "mnonce %s data %s"
> +kvm_sev_snp_launch_start(uint64_t policy, char *gosvw) "policy 0x%" PRIx64 " gosvw %s"


