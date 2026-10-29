Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562F2606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZVX+uqKu;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U5H1OKgi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOmp-0008OA-Ui; Thu, 29 Oct 2026 07:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seott@redhat.com>) id 1xMNeJ-0002DN-PV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seott@redhat.com>) id 1xMNeI-0006m0-5G
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793270780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aCRAuj8L9bf3T4NGV22Rip7Qr09eLMc08WjjKuugBEE=;
 b=ZVX+uqKu/gKS4N/wMgPo6iX8/7zgJszTT5TcB6rscG6JL77I5jgnotqY4XiRKdTssBjsUa
 0n9iQ/xzt7PdJpBEdgBk2+ota8FrtsLb1aMY5s7yjlNvK7vC8O7IHn0aTsQaWoRXkcRgna
 S067hRgmOWnizosq9/k4FdfHYcyg4wI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-P4mZxOVDPPKddJH520WMwg-1; Thu, 29 Oct 2026 06:46:19 -0400
X-MC-Unique: P4mZxOVDPPKddJH520WMwg-1
X-Mimecast-MFC-AGG-ID: P4mZxOVDPPKddJH520WMwg_1793270778
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a027f2e364so14820145e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 03:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793270778; x=1793875578; darn=nongnu.org;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aCRAuj8L9bf3T4NGV22Rip7Qr09eLMc08WjjKuugBEE=;
 b=U5H1OKgim7D0J5v1haw9UQ1RgvubHnIsddVY7Uw5n2y6yI0OD/XshWk8dke3erRkOU
 xgOiUeIutEYidUaRVzv+8MurW7gPTJZ5pjfycdryZRhwLLMxumCdrOYTW1Tzx9s3n5Mj
 aX4FXMpJW5ijCgquRSQWr0sjnMtxICgOlmfaEQM1SC2YnhYwujE7JmlrBCBeNfVG63h2
 8ZFZWx5ehr0DPoWlwluneNq78hGwuJRVbunAR7uFmE8xB9aMv9F/T1rsKCz18/t0Yhlr
 HB/GY238Ug7ZvOEAWBuUoxCO3owkSQd8kQ2LBhjE4jdTiOO45chSffK1Awt+D//udmtc
 B4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793270778; x=1793875578;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aCRAuj8L9bf3T4NGV22Rip7Qr09eLMc08WjjKuugBEE=;
 b=gePNqWu4L1LtfkhOjtzikEa208pnW3omuYPMbv6H0jdJIhL8Vw1EM82l0RpJzcQ63z
 CNrRcuSZvk1eUZgr+iaoPDKvqOe0LHYWde+j5o9u8G0Ug65OsFviZJCmzJN/zRaGcan8
 eDyhUkrOxcjBcgjdL850ba79q8BZEzY78X+ApCaHKstqavAfIAuWbXYrN76entg6nFtK
 g6g1gkoB69u2BZSnNlUT31vCbx3MGGJM08nc+mmF7sXowWCMNGrxc13huLO8QGkR/Uz1
 YavkycpdWN4TqshoIiWuV5Lix92+ASXprYXIZOKb17vrwwgnXDDyc18AN7sIDgPGCJ1x
 DwHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzv2QD3AIbBWtX/YRAvFcsWK9dOexVGWBeTqDrJqtBlpg6dgJ/n879qznbLo+NU6IjQajUl3WmrFMLs@nongnu.org
X-Gm-Message-State: AFq9FYLTiHWGFqJ5DWYLBeuEaxkmX9o3rC0JVz60EokKI54M61DV1oxe
 zmzID9MMQcdeKKxk+2W3MNv5ACVNA1/WbATcMm/L5zx3PJBJMALeRL5pR9u6HMg6y73hHI9fZBR
 uNFSF5fX9uIiY64Wf+xA4RKUOZgOafMbd2q2mf2tYF+JXakGsOWfehWno
X-Gm-Gg: AYBFou3Bw2rK07szaH7fQF0Z0V6dUe+h4TVC7NJ89r4I5/PZb6KzjnYGFIPo77/o9ZX
 1iPEmkiz/+AyJgrpmZ7wI1CZu2Tf2wCwRck86rTYbz46QWOkRY5mx/e88MXk2jjKKMo0o2Yk0S/
 rXGlrmo8So3sq03WmjZDq3MFfFAx8YyIYj1Qg4E2EhSHaS9kmcDBRWOpNXt4TnimZ95fjOmpyRX
 4cltnDjWXo/Vxsrqetc4x3oMVjxFjdwzXXVOAoxBa3fSKGCz2E/a+xrBWWoFlasq8UF8gorHKoF
 pYr9r+7dJs0xLloE2T4aNu+zGqg5LYifGIc3fMQHYLQIMVo6Js1lDHlzmTcvR+GUe9xWV/IoRPR
 iiLkeZlWmubEK5hVka/hzEE6p+KIHv1MM9h0+mcPEGcua9+W71fWCn0kCrAvajJ30BOhUF5YCLw
 Oxg/6+v1VnVo7w1nygN9VDjIy3T82pHNcsenHOyAs=
X-Received: by 2002:a05:600c:314f:b0:4a3:59c9:a744 with SMTP id
 5b1f17b1804b1-4a965be619dmr105819955e9.7.1793270778142; 
 Thu, 29 Oct 2026 03:46:18 -0700 (PDT)
X-Received: by 2002:a05:600c:314f:b0:4a3:59c9:a744 with SMTP id
 5b1f17b1804b1-4a965be619dmr105819385e9.7.1793270777775; 
 Thu, 29 Oct 2026 03:46:17 -0700 (PDT)
Received: from seott-rh (p200300f6af1574019b2c5947d8ec139e.dip0.t-ipconnect.de.
 [2003:f6:af15:7401:9b2c:5947:d8ec:139e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04723sm62384845e9.5.2026.10.29.03.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:46:17 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:46:16 +0100 (CET)
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
Subject: Re: [PATCH for-11.2 6/9] target/arm/kvm: Pass an error handle to
 kvm_arm_init_cpreg_list
In-Reply-To: <20261029092307.281287-7-eric.auger@redhat.com>
Message-ID: <e76a8f4d-a171-9663-2322-3d4366e1ba36@redhat.com>
References: <20261029092307.281287-1-eric.auger@redhat.com>
 <20261029092307.281287-7-eric.auger@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Thu, 29 Oct 2026, Eric Auger wrote:

> Pass an error handle to kvm_arm_init_cpreg_list(). A Subsequent patch
> will do the same with kvm_arch_init_vcpu().
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


