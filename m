Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE98FCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXWl-0004Jq-Uq; Fri, 06 Mar 2026 10:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyXWj-0004JQ-SZ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:55:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vyXWh-0003TR-NP
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772812540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=remnNIHqpuVKwr6Ri9repv7C0J3XOdjb+X+CahsEnQk=;
 b=HzS2CxuFbHrEwD5/WtC2B6elM5SqQFaoUPXbvNEtm+6QGFCfnMLG07bR7c/RjpyQwee/K2
 7OgHZ90xH56y1aw467ZNhyRD0F/+BCjHT9c0jxWS6K5Jjw/63h4nU/Oagugewk4yqek4Fd
 40qI5HfqrrZFIiUyYBfjLxlcaMzX1lc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-3mtrL81ROQ6amwrDe1rSlw-1; Fri, 06 Mar 2026 10:55:39 -0500
X-MC-Unique: 3mtrL81ROQ6amwrDe1rSlw-1
X-Mimecast-MFC-AGG-ID: 3mtrL81ROQ6amwrDe1rSlw_1772812539
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-899f757514bso362308716d6.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772812539; x=1773417339; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=remnNIHqpuVKwr6Ri9repv7C0J3XOdjb+X+CahsEnQk=;
 b=T69HXShPPmos2RDrFVS6tWHDawIvBN/BPRcF9feRgxdLyXC6y6uIlF656llWB5nTT7
 8YxcD5WAvl02gWAYrcyd9jRiO+KkJR38o/r2mwH2b5UemeOa9Fj8HtXD9lI2cVoed3Sr
 c9V8/bdEKeD46jGCEZu5J/7zU+Mt1hghX9DVZdVZhI0bHMkJsOXmC6SvFLFHW+nEsEuH
 cVZKySOfxRBBT69vE1R6SJgQQqaYf59uRCzMfRKXgQSmvaePBmoQdyFW+KcL7xMcgq53
 LHQX97j2bWISAwyq4mbAnB+W6RGJOLN9fpvjwyl9zWDC9wJmv3DKoXPJw07GcmWbyYac
 SRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772812539; x=1773417339;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=remnNIHqpuVKwr6Ri9repv7C0J3XOdjb+X+CahsEnQk=;
 b=pe+sO17LXrnyaJU1+sVIGh3m0B2Xrs+ds1qkkYDne7w/LyWY2cxmjKST3vKXxpHsR4
 JsEg73TZl4y6RmeoOdVTEmsejSJc/OBT2cJo0aHbP+NzPOGO50tHtdaPhmhOqNpiXW68
 1e8uRkCJjzg5JeIfqghvvACEyjj76XVK+1KB3CX6+PYoZFLa+w2Xgb21AbM/USHC3pdJ
 1/gwh2tpal3Cv1U0RaaaI2Ilqh6TGEXXascp+PfcI8Udj+1gziMsO7mdAbJ4sw4LiaxM
 Fnr/idR3NTYF07lrT+uN5swwAoSjeIP0EVLhFQgM6hwOmXb9Z/abEbPZTRnUSYXqc4Um
 2rZw==
X-Gm-Message-State: AOJu0Yy3gXi+TB4PnKJnVw6xieZNUEUTJpvw7iwOlYgBQLidMsWtNWVP
 nBugoChHRk6xkld8AoPObHv0Zk5fVmjwfVo6G2XGKunn0WUb2FwVJYgrquT7IenO3MhuGJVOkKl
 Ox07uCGwZfSr9UEgr/DgeCM3+OvSlESKzjXRjbrj2EGBZ20lIqj25irhV
X-Gm-Gg: ATEYQzwvIkQ1toHw43A7Eo6Tz0SRlxVeYUFuBgDrriypEZ58FxnAkgBL9TcNz93w6VR
 52eCEhTooFrmUmC64GpsHX2q28mlg8dbxPuooFFlokuF01hlDGc2Dq54hVadmAshdCY9+/Fh6F7
 t22kXcfQtYEauJ4XGKeUIgps2yZEgX0rvQO8nKxvh+JULyENxO2MqcJMZ9GEIhiAk8uSeu4rsTc
 NJuY61ixV2TasmouCkFY4sO/S0lTnc0IQsCbaSir7/xU4jPUICV90jVSqJLKtsAYoUVbQDmQP4N
 1liTLFYYDY7OnJBVCqIm9aXyFtGl+o8er6CmHkaaSCBdzPSlFR86z8fhg/nygkRCKpnIkhtPWBN
 493jeJwMlZnXBLa2dyF3EFqFGppGM05qDaKqYurN+iOc7LJRavIg7kBXzJPpPPYvELtOF0slwle
 uvJuaeVg==
X-Received: by 2002:a05:6214:2124:b0:89a:170b:a6fe with SMTP id
 6a1803df08f44-89a30c2df79mr28613196d6.65.1772812538713; 
 Fri, 06 Mar 2026 07:55:38 -0800 (PST)
X-Received: by 2002:a05:6214:2124:b0:89a:170b:a6fe with SMTP id
 6a1803df08f44-89a30c2df79mr28612756d6.65.1772812538111; 
 Fri, 06 Mar 2026 07:55:38 -0800 (PST)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a3173c581sm17061096d6.53.2026.03.06.07.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:55:37 -0800 (PST)
Date: Fri, 6 Mar 2026 10:55:36 -0500
From: Peter Xu <peterx@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <its@irrelevant.dk>,
 =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Fabiano Rosas <farosas@suse.de>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v3 1/6] migration: add
 VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8, 32}_ALLOC
Message-ID: <aar4-DgXbartZY4y@x1.local>
References: <20260306150342.395923-1-alexander@mihalicyn.com>
 <20260306150342.395923-2-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306150342.395923-2-alexander@mihalicyn.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 06, 2026 at 04:03:37PM +0100, Alexander Mikhalitsyn wrote:
> +#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT8_ALLOC(_field, _state, _field_num, _version, _vmsd, _type) { \
> +    .name       = (stringify(_field)),                                \
> +    .version_id = (_version),                                         \
> +    .num_offset = vmstate_offset_value(_state, _field_num, uint8_t), \
> +    .info       = &vmstate_info_ptrs_array_entry,                     \
> +    .vmsd       = &(_vmsd),                                           \
> +    .start      = sizeof(_type),                                      \
> +    .size       = sizeof(_type *),                                    \
> +    .flags      = VMS_VARRAY_UINT8|VMS_POINTER,                      \
> +    .offset     = vmstate_offset_pointer(_state, _field, _type *),    \
> +}
> +
> +#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT32_ALLOC(_field, _state, _field_num, _version, _vmsd, _type) { \
> +    .name       = (stringify(_field)),                                \
> +    .version_id = (_version),                                         \
> +    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t), \
> +    .info       = &vmstate_info_ptrs_array_entry,                     \
> +    .vmsd       = &(_vmsd),                                           \
> +    .start      = sizeof(_type),                                      \
> +    .size       = sizeof(_type *),                                    \
> +    .flags      = VMS_VARRAY_UINT32|VMS_POINTER,                      \
> +    .offset     = vmstate_offset_pointer(_state, _field, _type *),    \
> +}

Hi, Alex,

Per previous discussion, I thought we plan to add a new VMS_* flag, am I
right?

https://lore.kernel.org/r/CAJqdLrrKK-pTzk+Qm_45p9A6DRgj4VbFzSb6vFtJTkpN3UaFpg@mail.gmail.com

-- 
Peter Xu


