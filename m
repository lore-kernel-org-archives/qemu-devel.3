Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84105C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 08:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnDBd-0001CL-MT; Wed, 26 Feb 2025 03:54:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnDBc-0001Bu-7j
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:54:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnDBW-0007Me-BP
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740560069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n97+krRuLVDtXyPSfXlLRM5Nysc5dN6moE7au0gQzLo=;
 b=M/GZX4cXUu6UCDQkRqxHgNtRLPuLxQoaHGCaYsgG4mehrBafSO/kv5Svp9mm5fDfuneDfO
 tVwWukkGHVeS2XPyW0Ew6UBn2s2recngzGtBX23KQ5EDQkfWZz/odu7I1DBXVNdft/q8qx
 p1oOuJAj9yrnEkC/lgZqztzEq3lzd7g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-97Y1gnhpNhOTpHEJ7BAI0A-1; Wed, 26 Feb 2025 03:54:27 -0500
X-MC-Unique: 97Y1gnhpNhOTpHEJ7BAI0A-1
X-Mimecast-MFC-AGG-ID: 97Y1gnhpNhOTpHEJ7BAI0A_1740560067
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390d5f1e05cso146701f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 00:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740560066; x=1741164866;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n97+krRuLVDtXyPSfXlLRM5Nysc5dN6moE7au0gQzLo=;
 b=GiDXAH7SP4oM3c/+WeTscfnAy38HKgGAx0pjkjmcB8cqqb5JaYuBSrF3yAP1ssjIrd
 Np+RjgL9lzIlmypr1Wn77JdPTzLijEF0jaK6wPCO8x1rvbHJwXCnk8oGBJEt2k6xvZ3s
 zysuc18I/Bx20aCoBhL+oRVlm1DikEHm7vxYgb6sndQ5U1hTB5WhzPZac63O36f4TaOr
 tC6MhlBH9W6/OJVtFpUoELbTPDk9g7kwv0QgzegademCjp80lWz6RSg1w6mBNtXl+oFB
 SFSCuQs9LsZDMHvlZF15fbGleuZDxW39LgWWc/L+g1ny+DPrQGw9ZuHlaAsuahpt74Fm
 wYPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt42R7FpD6J+k4/2TM1eRUXP8tvasbypk56SK0/48SKyQqJvtccXCn8SBSOn7sXbqTCQIgyxBPks6R@nongnu.org
X-Gm-Message-State: AOJu0YwbDrMI0Py3soBo7GV+zKSz6yCH878VjDOTOs4WWsaINHIAHPiP
 /Q1u4lENaWdHK8JVHJD7ctc2kjmuCua/59MqQECDMa39E6IXlCi7gaY2tqAboAS5XrSW1l6oamH
 h6aVl5ZA8AMJaBiiy5MlzxyrCT0EGH2E7HXBMuwf//a4CkPzyqzDX
X-Gm-Gg: ASbGnct42AnONyCxDueTZwP5+BbJNWNAboo+8Wda0YFhqAgpHID+9yNpQCBo6ECAMo2
 P/x3ZyhYYs958zcIUmNIpI29bckrBvjXc3CCSBrEvkzLFNmioWTUXoupT0cHQeYGQDNxYHyHE6u
 Jjgy8TlfppNUULjd0OvmWvTvRPswuIhAfibyl4Gz9m3ooiCrwd1aYg3AtHoP3xIpMkQ33eNQJ9W
 MCJdtYzlk94zmOBt2QmcF6FAd6BhcRidjd6wG1oeIDhH3Vn8AUkaKH1gfjcIYGzB0qDF08QtBWC
 9BSjCa1PGeXAruiLuntd5Ei/yDKD1m/4Yddcz80cIDKshHDRiIoJuTtAjkg=
X-Received: by 2002:a05:6000:1cc6:b0:38a:8ed1:c5c7 with SMTP id
 ffacd0b85a97d-390cc638914mr4237560f8f.46.1740560066618; 
 Wed, 26 Feb 2025 00:54:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYaekFhdPU45h/K/O03B93af5ATeL7EbZ3LjIPSUED0HzwiODxT7S+pu78iIzCjECLv9NEyA==
X-Received: by 2002:a05:6000:1cc6:b0:38a:8ed1:c5c7 with SMTP id
 ffacd0b85a97d-390cc638914mr4237538f8f.46.1740560066243; 
 Wed, 26 Feb 2025 00:54:26 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8fb50asm4708252f8f.82.2025.02.26.00.54.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 00:54:25 -0800 (PST)
Message-ID: <ca0e8fe3-6832-4627-b09f-83207278d603@redhat.com>
Date: Wed, 26 Feb 2025 09:54:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/36] vfio/migration: Multifd device state transfer
 support - VFIOStateBuffer(s)
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <96303daed289e9c7a3261590027d18e425ea07c2.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <96303daed289e9c7a3261590027d18e425ea07c2.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

On 2/19/25 21:34, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Add VFIOStateBuffer(s) types and the associated methods.
> 
> These store received device state buffers and config state waiting to get
> loaded into the device.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/migration-multifd.c | 54 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 0c3185a26242..760b110a39b9 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -29,3 +29,57 @@ typedef struct VFIODeviceStatePacket {
>       uint32_t flags;
>       uint8_t data[0];
>   } QEMU_PACKED VFIODeviceStatePacket;
> +
> +/* type safety */
> +typedef struct VFIOStateBuffers {
> +    GArray *array;
> +} VFIOStateBuffers;
> +
> +typedef struct VFIOStateBuffer {
> +    bool is_present;
> +    char *data;
> +    size_t len;
> +} VFIOStateBuffer;
> +
> +static void vfio_state_buffer_clear(gpointer data)
> +{
> +    VFIOStateBuffer *lb = data;
> +
> +    if (!lb->is_present) {
> +        return;
> +    }
> +
> +    g_clear_pointer(&lb->data, g_free);
> +    lb->is_present = false;
> +}
> +
> +static void vfio_state_buffers_init(VFIOStateBuffers *bufs)
> +{
> +    bufs->array = g_array_new(FALSE, TRUE, sizeof(VFIOStateBuffer));
> +    g_array_set_clear_func(bufs->array, vfio_state_buffer_clear);
> +}
> +
> +static void vfio_state_buffers_destroy(VFIOStateBuffers *bufs)
> +{
> +    g_clear_pointer(&bufs->array, g_array_unref);
> +}
> +
> +static void vfio_state_buffers_assert_init(VFIOStateBuffers *bufs)
> +{
> +    assert(bufs->array);
> +}
> +
> +static guint vfio_state_buffers_size_get(VFIOStateBuffers *bufs)
> +{
> +    return bufs->array->len;
> +}
> +
> +static void vfio_state_buffers_size_set(VFIOStateBuffers *bufs, guint size)
> +{
> +    g_array_set_size(bufs->array, size);
> +}
> +
> +static VFIOStateBuffer *vfio_state_buffers_at(VFIOStateBuffers *bufs, guint idx)
> +{
> +    return &g_array_index(bufs->array, VFIOStateBuffer, idx);
> +}
> 


