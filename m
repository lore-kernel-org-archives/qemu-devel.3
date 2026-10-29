Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35682606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KpD3EKJS;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PWR0cNcf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOmn-0008Kc-Na; Thu, 29 Oct 2026 07:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seott@redhat.com>) id 1xMNXM-00006j-5E
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:39:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seott@redhat.com>) id 1xMNXK-0005V6-Qg
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793270342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AWPSUMK7+fKN4RVSbD77BcctC/xguXAzAkCplDxTUoI=;
 b=KpD3EKJSgh7X5AnP91w+OCeEvWEHlFKU5uoY2YSEusWuVdGKULvgxuYXPo+EbH9ib3ADF9
 d9DAQKqW8M8321+SxI+ozXum95SO7UbqzaLImxEJBenLt2hYeA/dwQrbXsFVH4uxKHPNax
 Zxnc75Ih1ze4EIYByQA9M00tH9/RqEE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-lICUJxtmPJa8X439E32j6A-1; Thu, 29 Oct 2026 06:39:01 -0400
X-MC-Unique: lICUJxtmPJa8X439E32j6A-1
X-Mimecast-MFC-AGG-ID: lICUJxtmPJa8X439E32j6A_1793270340
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a4af69e06fso14304595e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 03:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793270340; x=1793875140; darn=nongnu.org;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AWPSUMK7+fKN4RVSbD77BcctC/xguXAzAkCplDxTUoI=;
 b=PWR0cNcfmxJjBbaqLf2rA3Ty2h448HYUgl8RORIRRnQ/WW75oRmzlCrSLhDayqmczI
 mx2VnyvlW5YdxAbLCE4iMPavMbaQFPEiO7XL7xki18F3nNX9yTCbKB/aXZ5SuZ0scZZK
 TCU1JJMR9kVPLqZDke6VhlNSHjNYvo+ey98oka40eY85LVpz0vmRGt1UMqPXpvNBd77p
 BfD9hQ+HJ+FpczL9HZRyr6lWQhkkx12bVTK5fudHt2nz4TnxBdyqpgJZlR0s1vBayiCj
 DiOmCHq95w9+BzBnbRc6ZlctVDfpHRvD2AIshP/9spwqCSGlCm9uuKXi8sjouy/X6WHy
 tuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793270340; x=1793875140;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AWPSUMK7+fKN4RVSbD77BcctC/xguXAzAkCplDxTUoI=;
 b=S6ROLXf1vggfjmPYIGRlvq9xvM2yntA461bT6P3pj9vp07lEtXOYpCdV0xAc2/K735
 h5HiyJ3Al5Fs49K4hP7ejfHJE/HSL3eqfi4X981JwbKVi5SDgxvBT5fcck/wAgKR6QKe
 EjsatuhOS21XsWShAKq8o5vVApHR1b3JwEO9gGsXVODt1folMmFvS3amVhdJ05ayYbFu
 WX/iz4JgNuqn6FK2G+/t+nX4f4FfkqktSTrgZcRjDamrrqv/+RRZdoVMOshPAJcO7TAi
 IvxZv4rhzr6QVpPa/E3OsfBtTD5dimNwGjBCZevEGd5EN7F8CKaKa7jycii6GGRkHlnq
 Ecxg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfiYnYHeO3GuWbeb2a+oDFqLxpg+Yv76HIl2SyzUJE68zmNjxm1TW6rpBjp70YnUEUnS/UUr1cN5/X@nongnu.org
X-Gm-Message-State: AFq9FYI3m/AYyvhpTYj+3YUziz+4Mj0RpXtX0hd/BpGqo+r6Kp9JKOlh
 J9y9aZlAZTs3e1Xm9vT/0iuE9KcWrUG+hzpNGtmjKed0DuVO6t5xDVmRozjxivHUKGJho/RTWX8
 NP5TbHh3P5x1tOgdkESuCeAkC6KacRdWGtYQAed7A8JPeHgutMwB73iE+
X-Gm-Gg: AYBFou1lyVOBv5a7yiQ3BTO1ZQiD7476ojv3ELdpirbGsMzkC8KHh3rSuS9p/GdLMDs
 OJtWVqR7lKTMCI5cNwFT3a4y76YSSt7eaFgWlXqZTYKHXGGnMAVMkPQ3G2BsRWEp48HA0UZzTtT
 /Ra9XP1q+j48Zvp8HK0oc5ErbxfE+zxGTDbY+cyv2TufOPz+3HiFEzzxhIKJAwJXIH6Ila3I0ZQ
 +60JF+ktOWPgQoER8s4Ui97Px7S6GNK96E29VPlw3rq75lhDB/EmFeKvcpbZkYqVykxCX2U7nZu
 VFFFrQcvaQwo/ouygcEpzp0YlnoxKaGkZdFXJvjtluQFfdbEysF7c3Zt1ZwKB+1RYSrCjo+5IT8
 hIl8qf5YNhjqzqpiWacud4zaFC8Qy4z1afmpZxc3f269ueqiC7wJAFXxg8Rm6QmUSVoojLkbjEp
 6mwli1AEBLXypQrGh90PeWS5Jinwj9DDPnFZ4jlA==
X-Received: by 2002:a05:600c:1391:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4a966c41a4emr113043735e9.9.1793270339866; 
 Thu, 29 Oct 2026 03:38:59 -0700 (PDT)
X-Received: by 2002:a05:600c:1391:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4a966c41a4emr113043355e9.9.1793270339537; 
 Thu, 29 Oct 2026 03:38:59 -0700 (PDT)
Received: from seott-rh (p200300f6af1574019b2c5947d8ec139e.dip0.t-ipconnect.de.
 [2003:f6:af15:7401:9b2c:5947:d8ec:139e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdfb8esm33570637f8f.54.2026.10.29.03.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:38:59 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:38:57 +0100 (CET)
From: Sebastian Ott <seott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, shaju.abraham@nutanix.com, 
 khushit.shah@nutanix.com, richard.henderson@linaro.org, 
 pbonzini@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com, 
 7746591750@163.com, maobibo@loongson.cn, harshpb@linux.ibm.com, 
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com, 
 milesg@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com, 
 armbru@redhat.com, mbawa@redhat.com
Subject: Re: [PATCH for-11.2 5/9] target/arm/kvm: Pass an error handle to
 kvm_arm_create_scratch_host_vcpu
In-Reply-To: <20261029092307.281287-6-eric.auger@redhat.com>
Message-ID: <a4d2cce1-7d56-ec85-b5f6-13d46537e249@redhat.com>
References: <20261029092307.281287-1-eric.auger@redhat.com>
 <20261029092307.281287-6-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.129.124; envelope-from=seott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:59:09 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Thu, 29 Oct 2026, Eric Auger wrote:

> This allows to report a precise error message if any error occurs.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


