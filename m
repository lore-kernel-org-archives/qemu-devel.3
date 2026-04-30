Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68F1FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGR-00044f-ON; Thu, 30 Apr 2026 10:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIRgf-0006KP-R8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIRge-0001cN-8d
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777556655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cDxYja7+LsqUXvxH96Cnyw4lrAQPTFphBhCPL76+H3c=;
 b=I2y4ZgO+3+p2+ny+un5SWG77Ujrmccwq1x2VUEmWXgmofEEUobThu4CpYR6453S6bV97Uo
 Famiho4bTwrEi97iPVF/u0GX/Fuv6RX4vWZCX79qGJ7P/diKy9sbEEurYcOv1XJTm1uMJA
 iEyfGtJ3ph/ZW9Qcqtdxx/hOX05SeX4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-hKVFkXSxMOWejx-2n3GWHg-1; Thu,
 30 Apr 2026 09:44:09 -0400
X-MC-Unique: hKVFkXSxMOWejx-2n3GWHg-1
X-Mimecast-MFC-AGG-ID: hKVFkXSxMOWejx-2n3GWHg_1777556646
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08C8B19560B6; Thu, 30 Apr 2026 13:44:05 +0000 (UTC)
Received: from [10.44.50.160] (unknown [10.44.50.160])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD2731953947; Thu, 30 Apr 2026 13:44:01 +0000 (UTC)
Message-ID: <7c15ed6b-f0e6-4582-a28c-2ac28ae37197@redhat.com>
Date: Thu, 30 Apr 2026 15:44:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 35/37] whpx: i386: nested virt settings
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
 <20260422214225.2242-36-mohamed@unpredictable.fr>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <20260422214225.2242-36-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/22/26 23:42, Mohamed Mediouni wrote:
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

This should use the VMX and SVM CPU features.

Paolo
> ---
>   accel/whpx/whpx-common.c       |  1 +
>   include/system/whpx-internal.h |  2 +
>   target/i386/whpx/whpx-all.c    | 68 +++++++++++++++++++++++++++++++---
>   3 files changed, 66 insertions(+), 5 deletions(-)
> 
> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
> index d846e08714..305b2ae1d0 100644
> --- a/accel/whpx/whpx-common.c
> +++ b/accel/whpx/whpx-common.c
> @@ -556,6 +556,7 @@ static void whpx_accel_instance_init(Object *obj)
>       whpx->hyperv_enlightenments_enabled = false;
>       whpx->ignore_unknown_msr = true;
>       whpx->intercept_msr_gp = false;
> +    whpx->nested_virt_enabled = true;
>   }
>   
>   static const TypeInfo whpx_accel_type = {
> diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
> index 15027a7d52..4436cfe6ba 100644
> --- a/include/system/whpx-internal.h
> +++ b/include/system/whpx-internal.h
> @@ -47,6 +47,8 @@ struct whpx_state {
>       bool hyperv_enlightenments_required;
>       bool hyperv_enlightenments_enabled;
>   
> +    bool nested_virt_enabled;
> +
>       bool ignore_unknown_msr;
>       bool intercept_msr_gp;
>   };
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index ea5d1e535c..d17db73cff 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -2974,6 +2974,39 @@ static void whpx_set_intercept_msr_gp(Object *obj, Visitor *v,
>       }
>   }
>   
> +static void whpx_set_nested_virt(Object *obj, Visitor *v,
> +                                   const char *name, void *opaque,
> +                                   Error **errp)
> +{
> +    struct whpx_state *whpx = &whpx_global;
> +    OnOffAuto mode;
> +
> +    if (!visit_type_OnOffAuto(v, name, &mode, errp)) {
> +        return;
> +    }
> +
> +    switch (mode) {
> +    case ON_OFF_AUTO_ON:
> +        whpx->nested_virt_enabled = true;
> +        break;
> +
> +    case ON_OFF_AUTO_OFF:
> +        whpx->nested_virt_enabled = false;
> +        break;
> +
> +    case ON_OFF_AUTO_AUTO:
> +        whpx->nested_virt_enabled = true;
> +        break;
> +    default:
> +        /*
> +         * The value was checked in visit_type_OnOffAuto() above. If
> +         * we get here, then something is wrong in QEMU.
> +         */
> +        abort();
> +    }
> +}
> +
> +
>   void whpx_arch_accel_class_init(ObjectClass *oc)
>   {
>       object_class_property_add(oc, "ignore-unknown-msr", "OnOffAuto",
> @@ -2986,6 +3019,11 @@ void whpx_arch_accel_class_init(ObjectClass *oc)
>           NULL, NULL);
>       object_class_property_set_description(oc, "intercept-msr-gp",
>           "Intercept #GP to log erroring MSR accesses.");
> +    object_class_property_add(oc, "nested", "OnOffAuto",
> +        NULL, whpx_set_nested_virt,
> +        NULL, NULL);
> +    object_class_property_set_description(oc, "intercept-msr-gp",
> +        "Toggle nested virtualization off/on.");
>   }
>   
>   int whpx_accel_init(AccelState *as, MachineState *ms)
> @@ -3166,7 +3204,8 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
>       whpx_rdtsc_cap = processor_features.Bank0.RdtscpSupport;
>       whpx_invpcid_cap = processor_features.Bank0.InvpcidSupport;
>   
> -    if (whpx_irqchip_in_kernel() && processor_features.Bank1.NestedVirtSupport) {
> +    if (whpx_irqchip_in_kernel() && whpx->nested_virt_enabled
> +        && processor_features.Bank1.NestedVirtSupport) {
>           memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
>           prop.NestedVirtualization = 1;
>           hr = whp_dispatch.WHvSetPartitionProperty(
> @@ -3174,11 +3213,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
>               WHvPartitionPropertyCodeNestedVirtualization,
>               &prop,
>               sizeof(WHV_PARTITION_PROPERTY));
> -            if (FAILED(hr)) {
> -                error_report("WHPX: Failed to enable nested virtualization, hr=%08lx", hr);
> -                ret = -EINVAL;
> -                goto error;
> +        if (FAILED(hr)) {
> +            error_report("WHPX: Failed to enable nested virtualization, hr=%08lx", hr);
> +            ret = -EINVAL;
> +            goto error;
>           }
> +    } else if (whpx->nested_virt_enabled) {
> +        whpx->nested_virt_enabled = 0;
> +        info_report("WHPX: nested virtualisation not available");
>       }
>   
>       hr = whp_dispatch.WHvSetPartitionProperty(
> @@ -3222,6 +3264,22 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
>           synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
>       }
>   
> +    if (whpx->nested_virt_enabled) {
> +        /* enlightened VMCS is an Intel-specific enlightenment. */
> +        hr = whp_dispatch.WHvGetCapability(
> +            WHvCapabilityCodeProcessorVendor, &whpx_cap,
> +            sizeof(whpx_cap), &whpx_cap_size);
> +        if (FAILED(hr)) {
> +            error_report("WHPX: Failed to query processor vendor, hr=%08lx", hr);
> +            ret = -ENOSPC;
> +            goto error;
> +        }
> +        if (whpx_cap.ProcessorVendor == WHvProcessorVendorIntel) {
> +            synthetic_features.Bank0.EnlightenedVmcs = 1;
> +            synthetic_features.Bank0.NestedDebugCtl = 1;
> +        }
> +    }
> +
>       if (is_modern_os && whpx->hyperv_enlightenments_allowed) {
>           whpx->hyperv_enlightenments_enabled = true;
>           hr = whp_dispatch.WHvSetPartitionProperty(


