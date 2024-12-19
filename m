Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E53E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 10:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tODNs-0002yk-Ub; Thu, 19 Dec 2024 05:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tODNr-0002yD-IV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 05:03:55 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tODNm-0007IQ-UM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 05:03:55 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so3864015e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 02:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734602620; x=1735207420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mXCIk6dfNVEh9UR4aHsi/3+L8qM9W3TR4OmGtyFazeE=;
 b=Tn9SkJPz+rrUbOTzuus/eiSJ66pFX33YKLT7mY0tyruDqwLrxYk77U8KqRqgbPCXgi
 nL26ZFUlGessEd7D3R9aeeAjHRGSwNDnhFbbrOV3QhTT435gFmTxDK5WuSaJpANG2P1d
 DCx3g7FmKS2n/XVdLFBQXBHYd7kf+6WsMEMT6qUfj3oGbpbapCqGWgsnL80uR97BamZV
 JqNRsd64vNFL1RLmNeKkWsNyBcb6CWNXdi8b4uNyDeCci9DvL9znBMiGqq63mPcGqZ6f
 5INoX+2Ab9YIXJzBRWF5cw2GxzrXHjQdDA4FM+K2wptHA1BfTLFTWIRVpk8Pnvj9x9Qd
 WjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734602620; x=1735207420;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mXCIk6dfNVEh9UR4aHsi/3+L8qM9W3TR4OmGtyFazeE=;
 b=v9aWyjeneEy9q5YvikAbwfWUIXK9QL5ZFcrJyujl90lHeUpHUD3qcxyPVUcm/IbEPY
 MOPBweECv8UNmdXXPmz/NjasN0KE7K3jv3Eh+534qPOWWvCr+Uwyhl/EZXiDbmGfugt9
 780Ls1HrgdKlVhTU65+yT97Jw8PJmA/8Bva8u3CH2pfmqH+PkzjRH5bg6oxyqO4AjQ4e
 CHk98eKeDFlwsaQ42egit6KgxWQMNdZL4nPfckyEvrOpfgwagn7wLJZTizf53xqkgDfG
 gl221WBFY4DKuwJnyWtuEfftHrPLJIeL0lbMZ5Li1NKwTio2VGkdQMzz6i0EbJ4DxSdf
 jtLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWAnqgCedcboHLrOzKPNvKIWNJMzAnFZyEv84Rw9XJgYFojn1zylxaeW/vDT8sopaOWh7qE7vUqa9g@nongnu.org
X-Gm-Message-State: AOJu0YydoyvbIMv7RU5+Ax1LSlKaKZWPbafauGhGSuBajL86MCWpRxdG
 E1EKOSmMURXqjq3RkrLaV3ohVV8m+f5p+ivO2/B/s44NTFvH+shXyxpXnbKkJE0=
X-Gm-Gg: ASbGncskQQ7joYqpcT23HJ/rOm+iu/L8BkktCw5x6QkLq2j2JWidcvltdXzaTJHtrP/
 npEQ602IwIPNbZF6UgDZWlE+8so50Rt+g00vvac96XVkLBun73QkBgsqToWGIIsKDcMXX7SaPYH
 oDJl+uFGm5l89cVodOD6VaURKEB68mvSIhUMMbNWTzSnA0ii++JEeQsPJTLcAx/zeI4D/zifvRm
 Koi8qLcN6M5YxlFP/Xko/ykqWH9OMBcSR9HuZjAe+9nI5z6Mrp1MjgKl2vocmRUq+k=
X-Google-Smtp-Source: AGHT+IGB6GQuYEYhB8N41I+20yLF7oTleDHl5+vLe7kyV5H69eLiTwBtVSvLpfvM2GUsL2Sx7QFbjQ==
X-Received: by 2002:a05:600c:3b88:b0:434:a315:19c with SMTP id
 5b1f17b1804b1-4365c77e436mr24721105e9.3.1734602620028; 
 Thu, 19 Dec 2024 02:03:40 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b11495sm47429465e9.19.2024.12.19.02.03.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 02:03:39 -0800 (PST)
Message-ID: <6eed1b13-f41a-4590-8254-dbfb1f9c7a5b@linaro.org>
Date: Thu, 19 Dec 2024 11:03:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Daniel Berrange <berrange@redhat.com>
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <61096f4d-7b5f-48fd-9840-caf058db2201@linaro.org>
 <2933CCF9-F9D6-46D1-9658-07B85104011D@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2933CCF9-F9D6-46D1-9658-07B85104011D@redhat.com>
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

On 19/12/24 10:35, Ani Sinha wrote:
>> On 18 Dec 2024, at 11:13 PM, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> On 16/12/24 12:48, Ani Sinha wrote:
>>> VM firmware update is a mechanism where the virtual machines can use their
>>> preferred and trusted firmware image in their execution environment without
>>> having to depend on a untrusted party to provide the firmware bundle. This is
>>> particularly useful for confidential virtual machines that are deployed in the
>>> cloud where the tenant and the cloud provider are two different entities. In
>>> this scenario, virtual machines can bring their own trusted firmware image
>>> bundled as a part of their filesystem (using UKIs for example[1]) and then use
>>> this hypervisor interface to update to their trusted firmware image. This also
>>> allows the guests to have a consistent measurements on the firmware image.
>>> This change introduces basic support for the fw-cfg based hypervisor interface
>>> and the corresponding device. The change also includes the
>>> specification document for this interface. The interface is made generic
>>> enough so that guests are free to use their own ABI to pass required
>>> information between initial and trusted execution contexts (where they are
>>> running their own trusted firmware image) without the hypervisor getting
>>> involved in between. In subsequent patches, we will introduce other minimal
>>> changes on the hypervisor that are required to make the mechanism work.
>>> [1] See systemd pull requests https://github.com/systemd/systemd/pull/35091
>>> and https://github.com/systemd/systemd/pull/35281 for some discussions on
>>> how we can bundle firmware image within an UKI.
>>> CC: Alex Graf <graf@amazon.com>
>>> CC: Paolo Bonzini <pbonzini@redhat.com>
>>> CC: Gerd Hoffman <kraxel@redhat.com>
>>> CC: Igor Mammedov <imammedo@redhat.com>
>>> CC: Vitaly Kuznetsov <vkuznets@redhat.com>
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>>   MAINTAINERS                  |   9 ++
>>>   docs/specs/index.rst         |   1 +
>>>   docs/specs/vmfwupdate.rst    | 109 ++++++++++++++++++++++++
>>>   hw/misc/meson.build          |   2 +
>>>   hw/misc/vmfwupdate.c         | 157 +++++++++++++++++++++++++++++++++++
>>>   include/hw/misc/vmfwupdate.h | 103 +++++++++++++++++++++++
>>>   6 files changed, 381 insertions(+)
>>>   create mode 100644 docs/specs/vmfwupdate.rst
>>>   create mode 100644 hw/misc/vmfwupdate.c
>>>   create mode 100644 include/hw/misc/vmfwupdate.h
>>
>>
>>> +static void vmfwupdate_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    VMFwUpdateState *s = VMFWUPDATE(dev);
>>> +    FWCfgState *fw_cfg = fw_cfg_find();
>>> +
>>> +    /* multiple devices are not supported */
>>> +    if (!vmfwupdate_find()) {
>>> +        error_setg(errp, "at most one %s device is permitted",
>>> +                   TYPE_VMFWUPDATE);
>>> +        return;
>>> +    }
>>> +
>>> +    /* fw_cfg with DMA support is necessary to support this device */
>>> +    if (!fw_cfg || !fw_cfg_dma_enabled(fw_cfg)) {
>>> +        error_setg(errp, "%s device requires fw_cfg",
>>> +                   TYPE_VMFWUPDATE);
>>> +        return;
>>> +    }
>>> +
>>> +    memset(&s->fw_blob, 0, sizeof(s->fw_blob));
>>> +    memset(&s->opaque_blobs, 0, sizeof(s->opaque_blobs));
>>> +
>>> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_OBLOB,
>>> +                             NULL, NULL, s,
>>> +                             &s->opaque_blobs,
>>> +                             sizeof(s->opaque_blobs),
>>> +                             false);
>>> +
>>> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_FWBLOB,
>>> +                             NULL, fw_blob_write, s,
>>> +                             &s->fw_blob,
>>> +                             sizeof(s->fw_blob),
>>> +                             false);
>>> +
>>> +    /*
>>> +     * Add global capability fw_cfg file. This will be used by the guest to
>>> +     * check capability of the hypervisor.
>>> +     */
>>> +    s->capability = cpu_to_le16(CAP_VMFWUPD_MASK | VMFWUPDATE_CAP_EDKROM);
>>> +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_CAP,
>>> +                    &s->capability, sizeof(s->capability));
>>> +
>>> +    s->plat_bios_size = get_max_fw_size(); /* for non-pc, this is 0 */
>>> +    /* size of bios region for the platform - read only by the guest */
>>> +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_BIOS_SIZE,
>>> +                    &s->plat_bios_size, sizeof(s->plat_bios_size));
>>> +    /*
>>> +     * add fw cfg control file to disable the hypervisor interface.
>>> +     */
>>> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_CONTROL,
>>> +                             NULL, NULL, s,
>>> +                             &s->disable,
>>> +                             sizeof(s->disable),
>>> +                             false);
>>> +    /*
>>> +     * This device requires to register a global reset because it is
>>> +     * not plugged to a bus (which, as its QOM parent, would reset it).
>>> +     */
>>> +    qemu_register_reset(fw_update_reset, dev);
>>
>> Shouldn't we use qemu_register_resettable() instead?
> 
> OK will do in v3.
> 
>>
>>> +}
>>> +
>>> +static Property vmfwupdate_properties[] = {
>>> +    DEFINE_PROP_UINT8("disable", VMFwUpdateState, disable, 0),
>>> +    DEFINE_PROP_END_OF_LIST(),
>>> +};
>>> +
>>> +static void vmfwupdate_device_class_init(ObjectClass *klass, void *data)
>>> +{
>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>> +
>>> +    /* we are not interested in migration - so no need to populate dc->vmsd */
>>> +    dc->desc = "VM firmware blob update device";
>>> +    dc->realize = vmfwupdate_realize;
>>> +    dc->hotpluggable = false;
>>> +    device_class_set_props(dc, vmfwupdate_properties);
>>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>> +}
>>> +
>>> +static const TypeInfo vmfwupdate_device_info = {
>>> +    .name          = TYPE_VMFWUPDATE,
>>> +    .parent        = TYPE_DEVICE,
>>
>> What is the qdev API used here? Why not use a plain object?
> 
> I wrote this taking vmcoreinfo device as starting point. I will leave this as is for now unless anyone has strong opinions.

We shouldn't blindly copy/paste & spread possible design mistakes.

Marc-André, any particular reason to implement vmcoreinfo using qdev
and not plain object?

> 
>>
>>> +    .instance_size = sizeof(VMFwUpdateState),
>>> +    .class_init    = vmfwupdate_device_class_init,
>>> +};
> 
> 


