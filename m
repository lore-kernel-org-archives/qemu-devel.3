Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCD0606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S88vwF1s;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=eZ55/RQE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOmo-0008Ko-1h; Thu, 29 Oct 2026 07:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seott@redhat.com>) id 1xMNrl-00055S-4j
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:00:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seott@redhat.com>) id 1xMNrj-00008U-HP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 07:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793271614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mo7xsVZK9sCsf4WxWBCWnUrQEem7P5ym7LFAj53/gX4=;
 b=S88vwF1seoe9BY+vpYhEzII7zDkpH7hh8UXjqnbjC9lIPAMJl+RupK47tOm7IVPhopHpfJ
 pU4ROfbDVswJVptiEy7iBvTMm68rm8DFC16ANy096EL5jA59XY+N8VAjzsuin8BDQQZrJx
 zq/gW34ZpMVnj+Be2l4ybEeiFEdyX0U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-a9O1uE7ZPZKBgXDvNnwKqQ-1; Thu, 29 Oct 2026 07:00:12 -0400
X-MC-Unique: a9O1uE7ZPZKBgXDvNnwKqQ-1
X-Mimecast-MFC-AGG-ID: a9O1uE7ZPZKBgXDvNnwKqQ_1793271612
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48b027578a4so1574690f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 04:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793271611; x=1793876411; darn=nongnu.org;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mo7xsVZK9sCsf4WxWBCWnUrQEem7P5ym7LFAj53/gX4=;
 b=eZ55/RQEwQ9v1/mMoByeW6Aej4upDq75a1zqeyf0bNS4MOKTH/UO0uvNeLG63u5DMM
 cPJaS5qg08FxXM69H778TAQEmFDpWmJp7Pa805uCp6AlBRpQjOZtvlYNmb7pBsRt3yZk
 8YZM+vGqt1ws5hFcXcYPDlAbmxi9p/4vRaQtFxeWb/4AeBdb0PCNbA4G6/p+RCu+jL5d
 QNb3yUgLETyCTIHs/4g4N6YRKrAutpIDQhfwyfYYG75RWS1j1h9VjpOOtXBUWyfNytiL
 CMwfzfTdM9zcEKioKFumdf/rArRn2Ze8V9g6fSVA6ByYl7sz7+igmojkcyfNCIMBQFux
 m8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793271611; x=1793876411;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mo7xsVZK9sCsf4WxWBCWnUrQEem7P5ym7LFAj53/gX4=;
 b=YLAmrM4ZVaNGPst1U7xliuXhmeecOw2tH8FyvgagUT+4Tae8D2cyoUuzR1l8UXEujE
 /Ae0fECknlJYxRzukYJ/IFs1EQht3IcFuvkafoXIfAfn/PEuEWuW5ooqF6JkVik8Ypr3
 k4rhVrmlDy4KZLLyLVKvLjdSjo2V9xM47PJkMLWQ9dfKhBC33uw1QJChj/gIhQkfOLmK
 3ka/XlVVd9OPqN1KnXR3Lr6N8mVnyL6UcLfAVbnQEYW8+OJaKme34JMUiOD21E1OD314
 GEEEIzbulYsr+PbXad5Dcr94c9nNqxmjoqqyi7d1Fp7B4jaw6Q0ONsg9Z+d/FRUtntcC
 vbXg==
X-Forwarded-Encrypted: i=1;
 AKwUvByAA7F3QFxxkiAY+iNz4N0oqj8ALo2ZIqsbEWVIRVu7Y2tZlmErMcqE3BsGzbV2gIzxjjFZYpRzcBXK@nongnu.org
X-Gm-Message-State: AFq9FYL5unEQwfAtdvaN1mlLA0uE9VW792sogTD+hM/HDJk/x0QzNb2G
 XAzfLxMriUXDsQ0eshiK+HbHNv10fTGp1pDd0g0Lu3IFZ95UMm9ilOLLF1C+VPcf4np1XtiDk13
 IiLuA8q6qEaCJxB8CvAXCjt4Fc+vJRqmQXqrDREIGLLzvqZQyOZGbwus2
X-Gm-Gg: AYBFou2xQTEVNhsYiQl5dUxbTPzCp06RCZY/yQ2VoKNSSKhfLXGAWO2fkbwQskYjR8s
 Wd3fdab9vUlQENbjKg+2ZHMHOOu4+S9cKvpsKNbyk1Ub29aQN+L3Zl0Dc7eOjOn6h9uSsWoM0lm
 Eq12SMyL2AFxr3jRf3O44+lTEjzbsUEKYdfHLiGvFebZcNZMe55fwduNvI4s4qsVFEjEKsvz5S1
 ccjYot3GxkMpN87y+NAxKi9Wv1M86Xa3cX5a4VTP8+vph/FclVQr0vzXNbyKAkkKMmwWuuuOXcG
 HSDt7v8hlF0Cp4SHKJg/0XhVobxC8wGehhJ2iLVhNVbkOQIptzNA9UPvo0vwM3Xa1lqhPaxNgvL
 ME5nD00/k5MjSOxQFNg8Oo7x9z9oZdyGL/1muSJoJb7iU708WQWCZ+B0uOjLVQsWNoXKHo9OlWH
 OnANhaAXsYIVFaBZkiNT5LfkTeH/BuupwKVsoCqzg=
X-Received: by 2002:a05:6000:4919:b0:48d:ff71:dd97 with SMTP id
 ffacd0b85a97d-48e5d319cc9mr11391877f8f.7.1793271611509; 
 Thu, 29 Oct 2026 04:00:11 -0700 (PDT)
X-Received: by 2002:a05:6000:4919:b0:48d:ff71:dd97 with SMTP id
 ffacd0b85a97d-48e5d319cc9mr11391818f8f.7.1793271611120; 
 Thu, 29 Oct 2026 04:00:11 -0700 (PDT)
Received: from seott-rh (p200300f6af1574019b2c5947d8ec139e.dip0.t-ipconnect.de.
 [2003:f6:af15:7401:9b2c:5947:d8ec:139e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc4d76sm34227569f8f.12.2026.10.29.04.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 04:00:10 -0700 (PDT)
Date: Thu, 29 Oct 2026 12:00:09 +0100 (CET)
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
Subject: Re: [PATCH for-11.2 7/9] target/kvm: Pass an Error handle to
 kvm_arch_init_vcpu
In-Reply-To: <20261029092307.281287-8-eric.auger@redhat.com>
Message-ID: <31abc997-8c83-cd34-7fdb-5dfeccaad26d@redhat.com>
References: <20261029092307.281287-1-eric.auger@redhat.com>
 <20261029092307.281287-8-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=seott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Thu, 29 Oct 2026, Eric Auger wrote:

> The 2 callers of kvm_arch_init_vcpu(), namely kvm_rebind_vcpus()
> and kvm_init_vcpu() are passed an Error handle. So it is a pity
> not using it in kvm_arch_init_vcpu(). Also, in the future, the
> error handle could be passed to other functions called inside.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


