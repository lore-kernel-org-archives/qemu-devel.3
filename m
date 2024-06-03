Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791B3C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 05:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0To-0006Zb-Gl; Mon, 03 Jun 2024 01:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sE0Tk-0006Ye-Sz
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:43:34 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sE0Tj-0004W1-4c
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:43:32 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-702442afa7dso2245572b3a.2
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 22:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1717393409; x=1717998209;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CF7aM0XW2lPKlnABg+hhf9qX+aYBEyE1SS1JCRijTac=;
 b=oHcpCrk6gYPUal8OHsVoHbFALCNuLfAlo8dO2oWpxj2KUNxSUK7cODIXT4nuQN1gak
 jqogOFm6PgO+um6AUf4kN6dj5J4dNU+GOrrLJXofBgCTMMK8Pywtj8pLpNnr7XuHodMx
 v+4q+zwpJKA+4YyhuT2acSq8RCVUnfmHTel3ZhXyowP+uEdALHnjds6FKYVkS90rqeVi
 dw8WkoI1uYVYxXPT9nt+8uix0TfvWQImF+uifDuT7P0UXGYLpffNItR5ah9QXB5DQIs7
 7TnpladCmFV/em2M66Ds6WDTgkba07GB5Hteakl8w+VDSR38ybvQfhcmhKRMXnvgHWI+
 Ikkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717393409; x=1717998209;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CF7aM0XW2lPKlnABg+hhf9qX+aYBEyE1SS1JCRijTac=;
 b=mjAItUq0mTEqkt3S14ILz9lVbifAXGxwhmq/weZXm7LXlU+ZEvKuuJNGpCadNdn+5D
 QzTkfoAb0NzN4M7CShrhMfd4XKbc1Pd2Shkow6XjJtn1o4tW32VgpUQeAXKEe0cYA06i
 ZUW412lz/3S/Rb9yHspfiflFpro5L5eLrVTmGfon8XzIKOwSI/pgg83ENP5lnApTbbax
 1/jmr4tWtZ/iYLGzCOaxE6xxHHaSca9sPQtQYiRKLemnw835GIQMCRZ1kb/CSMwD6jO7
 lj9A3wa0+KeG2fUP7v5ne+UZM8hNB1J3ms/FhgEx8pIyqchitfSWpdXgzaKB01xGWrLo
 FN4g==
X-Gm-Message-State: AOJu0YyzuRxbaFklMIKtMiNIruYKG/7InowTJV0mjGhyL7ENimI7wXqE
 GgTIZeXKbdZxQeb4Lklwl4KVcCJLy8v7r/tzvxpNWgFrBZUasZ2ThOdKeaA9xcs=
X-Google-Smtp-Source: AGHT+IFiDp5FckwxlL+ZzaeDBEfYoj9n4WjoHTyqrl+dBRDTX3PSqw3uIf5vjfPmTtld5LdmLRkgBA==
X-Received: by 2002:a05:6a00:8008:b0:6ee:1d03:77b9 with SMTP id
 d2e1a72fcca58-702478f8e86mr9516844b3a.31.1717393409092; 
 Sun, 02 Jun 2024 22:43:29 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-702423dbfc4sm4734141b3a.66.2024.06.02.22.43.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Jun 2024 22:43:28 -0700 (PDT)
Message-ID: <bc3ec22f-9baf-404b-81fb-5bc131f6c5a6@daynix.com>
Date: Mon, 3 Jun 2024 14:43:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 11/13] virtio-gpu: Handle resource blob commands
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
 <20240527030233.3775514-12-dmitry.osipenko@collabora.com>
 <dba6eb97-e1d1-4694-bfb6-e72db95715dd@daynix.com>
 <4d75ecad-8205-4854-85f6-774db6b55404@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <4d75ecad-8205-4854-85f6-774db6b55404@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/06/03 14:32, Dmitry Osipenko wrote:
> On 6/2/24 08:45, Akihiko Odaki wrote:
> ...
>>> +    case HOSTMEM_MR_FINISH_UNMAPPING:
>>> +        ret = virgl_renderer_resource_unmap(res->base.resource_id);
>>> +        if (ret) {
>>> +            qemu_log_mask(LOG_GUEST_ERROR,
>>> +                          "%s: failed to unmap virgl resource: %s\n",
>>> +                          __func__, strerror(-ret));
>>> +            return ret;
>>> +        }
>>> +        res->mr = NULL;
>>> +        g_free(vmr);
>>> +        break;
>>> +    case HOSTMEM_MR_UNMAPPING:
>>> +        *cmd_suspended = true;
>>
>> This code path should be unreachable since the command processing is
>> blocked while unmapping.
> 
> Will change to abort()

I don't think abort() call is needed here. You can just do what you do 
for HOSTMEM_MR_MAPPED; the reference counter will automatically catch 
the double-free condition and abort.

> 
>>> +    if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
>>> +        ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
>>> sizeof(cblob),
>>> +                                            cmd, &res->base.addrs,
>>> +                                            &res->base.iov,
>>> &res->base.iov_cnt);
>>> +        if (!ret) {
>>> +            g_free(res);
>>
>> As noted for an earlier version:
>>> Use g_autofree instead of writing duplicate g_free() calls. See
>>> docs/devel/style.rst for details.
> 
> The g_autofree isn't appropriate for this code. It's intended to be used
> if you allocate a tmp variable that should be freed in all code paths.
> This is not the case here, the res variable isn't temporal and shall not
> be freed on success.

You can assign NULL to res after QTAILQ_INSERT_HEAD(). See 
rutabaga_cmd_resource_create_blob() for example.

Usually g_steal_pointer() should be used in such a situation but 
unfortunately it is not possible in this case due to how 
QTAILQ_INSERT_HEAD() macro is implemented.

