Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE05606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XMarn1PM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmow-0006H0-JG; Fri, 30 Oct 2026 09:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMmou-0006GC-Bv
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMmos-0007dm-Ts
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793367537;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FgkwkSXkh+U/XGfrC3955Cku45Y51ut+ucBIIoAyE+k=;
 b=XMarn1PMJeg4hg89fDterDNFUBrhQk+poL72Hiv22jKhx3MjznKkBNywtMzEkVpdhaHm8F
 evgXKj9Nsf3MwbSFgKQuwR8oxBt0JImfij9wlJLy2ucF+sBu1d3T9EkhKnyB7LbAb1HfRF
 OueAfDvF+WQ31CTSqF733IxsWkvnq0w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-80-k8vheMFSbPpj84A1FJw-1; Fri, 30 Oct 2026 09:38:55 -0400
X-MC-Unique: 80-k8vheMFSbPpj84A1FJw-1
X-Mimecast-MFC-AGG-ID: 80-k8vheMFSbPpj84A1FJw_1793367534
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a318cd95e8so6660405e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793367534; x=1793972334;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FgkwkSXkh+U/XGfrC3955Cku45Y51ut+ucBIIoAyE+k=;
 b=HMR7Zc5ByhCR0sIjSqlHsy+I57Iaxdy+v81sdH5azYFIOH2axgKdDpDe8+03e6VpNB
 5+b8hPZxcY1WUNcWWgCPlxRQ6X5d0xT23uslmAH2c13p510+DTp7uHMYnTFADJSF6koc
 d7HzfHPvh9DsPETVO3b6uUNYjccrQ2CtG8WTuyAy9l7F85i5WM6XTeIJwGifuUfeeVsh
 7p45I4wV2DEXkZS1+svD7GPdGC2ssdjw+V2iZskX2yybw2svy0ehqZOkV9H9QbsrnMeF
 FwiXVoQic2STc+Ypo2EXuCUnUNKDKFh8NPVP1RAVsVMLzwhiQFWgU3ZAbET03OYxzSZK
 ikGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwk5VNRbgLCLZg+0JlTfakH5pIitzDbIkKfibzlQTNHfTLgR7rsT8Csn9GbDk1AY+oqkVxwyzShGUTF@nongnu.org
X-Gm-Message-State: AFq9FYKUClMWNPExWzag0yu5T4HfcDvNJvM4VWDdM9hYhJfU53INrYt8
 GNbvK31WEz9o1Onr6O39zm2Ha4QGK5eDjrSd/mwGhJAnvirEgmjdXehaNh4wPIjVwAVdT2pxI+Y
 XcVLTFVwrFrxu7MvKh3eIDYbOxQgrnAnQzAFvCtn/J0JiHAgR15y5gCHN
X-Gm-Gg: AYBFou3657uLzyaUzm+XADj1Vf6yryPUfx617PVibd0bTcucdJq7iAn5DHwpdx2PSi9
 nKahD6flEMpf962Xpo86HWvGxwaMRWrsqQJ8WodQrJTKUEWuXdDySRHbcbDPxKBWjhFS9JiC8L+
 8Qe9SKA0+W1HXhcg460ps5htDoE1NfkKk/AxfI+QPsFdt6rJwFu3YfXFpQPDqVKGZ0ZKqpsJLng
 4Tuhtaaj3NeiAUQGUFuT0i4LcY7grhNaGYal5rdoc90pcQtX2CH0jnqj5mPe4osgd172YPllknp
 +uUEGBZGg7AZOCIRq4YxAICQUfY0AwtTHxkNbDIGHwEEReG81OWEwV7icNHBqQxaaIuPDyB8N6T
 tbHFrL/EHNQXbzuZpbEGmPTCzdw2rlbCol07P/36lPrMs/lChAajWFn1FG7sSApuVWghUTgI9ON
 4R7EwlTjOS7NhSJouKrQmcyQ==
X-Received: by 2002:a05:600c:3554:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4ac14ec66d9mr54313395e9.2.1793367534298; 
 Fri, 30 Oct 2026 06:38:54 -0700 (PDT)
X-Received: by 2002:a05:600c:3554:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4ac14ec66d9mr54312615e9.2.1793367533860; 
 Fri, 30 Oct 2026 06:38:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf7146621sm63977345e9.13.2026.10.30.06.38.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 06:38:53 -0700 (PDT)
Message-ID: <07e7cbd0-7c3d-4fb4-a781-580cca1c28b2@redhat.com>
Date: Fri, 30 Oct 2026 14:38:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 for-11.2 10/10] target/arm/kvm: Improve error handling
 on scratch vcpu probe
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 richard.henderson@linaro.org, pbonzini@redhat.com, skolothumtho@nvidia.com,
 philmd@oss.qualcomm.com, 7746591750@163.com, maobibo@loongson.cn,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com,
 daniel.barboza@oss.qualcomm.com, milesg@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, alireza.sanaee@huawei.com, armbru@redhat.com,
 mbawa@redhat.com
References: <20261030131406.461599-1-eric.auger@redhat.com>
 <20261030131406.461599-11-eric.auger@redhat.com>
 <CAFEAcA9koKTMaxgAhv6qnwRr2RBdtkoJSX5dOZaiq4r0K-ueUw@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA9koKTMaxgAhv6qnwRr2RBdtkoJSX5dOZaiq4r0K-ueUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/30/26 2:25 PM, Peter Maydell wrote:
> On Fri, 30 Oct 2026 at 13:15, Eric Auger <eric.auger@redhat.com> wrote:
>> Pass an error handle to both kvm_arm_create_scratch_host_vcpu()
>> and kvm_arm_get_host_cpu_features(). This allows to improve the
>> error reporting on kvm_arm_set_cpu_features_from_host().
>>
>> If any, the error is stored in the new cpu->host_cpu_probe_err
>> field and further propagated on realize().
>>
>> In arm_gic_cap_kvm_probe() call path we just pass a NULL error handle
>> to kvm_arm_create_scratch_host_vcpu because we don't care about the
>> failure nature and just want to revert to emulated versions if it
>> fails.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Many thanks for the diligent review & suggestions!

Eric
>
> thanks
> -- PMM
>


